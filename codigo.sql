-- Adicionar campo codigo (Código / Etiqueta da peça) na tabela produtos
ALTER TABLE public.produtos ADD COLUMN IF NOT EXISTS codigo text;
