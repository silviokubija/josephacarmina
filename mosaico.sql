-- Cria a tabela para armazenar as fotos do mosaico
CREATE TABLE IF NOT EXISTS public.mosaico (
    posicao integer PRIMARY KEY,
    url_imagem text NOT NULL
);

-- Habilita segurança em nível de linha (RLS)
ALTER TABLE public.mosaico ENABLE ROW LEVEL SECURITY;

-- Qualquer pessoa pode ver as fotos do mosaico (para o site público)
CREATE POLICY "Imagens do mosaico sao publicas" 
ON public.mosaico FOR SELECT 
USING (true);

-- Apenas o administrador autenticado pode alterar as fotos
CREATE POLICY "Apenas admin pode alterar mosaico" 
ON public.mosaico FOR UPDATE 
USING (auth.role() = 'authenticated');

-- Apenas o administrador autenticado pode inserir fotos
CREATE POLICY "Apenas admin pode inserir mosaico" 
ON public.mosaico FOR INSERT 
WITH CHECK (auth.role() = 'authenticated');

-- Insere as 7 posições padrão (caso não existam) com caminhos temporários 
-- (Essas URLs locais vão quebrar se a Vercel não tiver, mas a Van poderá sobreescrevê-las no painel!)
INSERT INTO public.mosaico (posicao, url_imagem) VALUES 
(1, 'assets/imagens/mock_1.jpg'),
(2, 'assets/imagens/mock_2.jpg'),
(3, 'assets/imagens/mock_3.jpg'),
(4, 'assets/imagens/mock_4.jpg'),
(5, 'assets/imagens/mock_5.jpg'),
(6, 'assets/imagens/mock_6.jpg'),
(7, 'assets/imagens/mock_7.jpg')
ON CONFLICT (posicao) DO NOTHING;
