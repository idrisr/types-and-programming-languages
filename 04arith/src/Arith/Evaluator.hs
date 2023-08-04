module Arith.Evaluator where

import Arith.Syntax

isNumericVal :: Term -> Bool
isNumericVal TermZero = True
isNumericVal (TermSucc t) = isNumericVal t
isNumericVal (TermPred t) = isNumericVal t
isNumericVal _ = False

isval :: Term -> Bool
isval TermTrue = True
isval TermFalse = True
isval x = isNumericVal x

eval1 :: Term -> Maybe Term
eval1 (TermIf TermTrue t _) = pure t
eval1 (TermIf TermFalse _ t) = pure t
eval1 (TermIf t1 t2 t3) = TermIf <$> eval1 t1 <*> pure t2 <*> pure t3
eval1 (TermSucc t) = TermSucc <$> eval1 t
eval1 (TermPred TermZero) = pure TermZero
eval1 (TermPred (TermSucc t))
    | isNumericVal t = pure t
    | otherwise = Nothing
eval1 (TermPred t) = TermPred <$> eval1 t
eval1 (TermIsZero (TermIsZero _)) = pure TermTrue
eval1 (TermIsZero (TermSucc t))
    | isNumericVal t = pure t
    | otherwise = Nothing
eval1 (TermIsZero t) = TermIsZero <$> eval1 t
eval1 _ = Nothing

eval :: Term -> Term
eval t = maybe t eval $ eval1 t
