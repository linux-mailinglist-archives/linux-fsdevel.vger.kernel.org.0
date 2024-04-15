Return-Path: <linux-fsdevel+bounces-16970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74A8A5C6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 22:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C864B2814F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238DA156977;
	Mon, 15 Apr 2024 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="K6eZcu0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-68.smtpout.orange.fr [80.12.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF84155734;
	Mon, 15 Apr 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214091; cv=none; b=mFUfkhi8SmEK3CobjmoDHPLWHducd80coVq+iotRWTBteGwf0jJ3VK10GjXw+bXfcMH2vaJ4NV1NmVEyOxk/py2Z+bg56S6lVHFtQoOc0ZRQ+Qgc3DX7tT5wzZmVTjyH3askQQzSoGXB+x5OlLxWz/TjNJdIDr+8R6Wo3yID7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214091; c=relaxed/simple;
	bh=OXUn3oOBfuYnTTy1mRu7lO/Z7jMxLafr2xQIIy2r0mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FROabLKez9A3/ZiRZMsqYlQ9eN1tqQuKfvhW6S0qaFGABTcm+tLGREAAwytiEhvwJprX761VNvnfYH33Wqwphj8El+R7kryPQd+ydY1XcRLN/r5tnFnmy38ClldPvg9vnalvpMrifCKeJWwvi0tuFpgGC/9vB7dkg3CnuCFrqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=K6eZcu0g; arc=none smtp.client-ip=80.12.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wTF9rwTfAUEo7wTF9rKczA; Mon, 15 Apr 2024 22:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713214081;
	bh=S7uRgOT3iqhsU0DFa0D2HmmuEAbosFRiIzoeYLAMrm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=K6eZcu0gztGMQv7qYT7noG/tiTulzOJYXNLMMvyf4z1n5jh04K24Gxm12D/Hr0qh2
	 oHRKVbot6M3PXazewZLyPvNuBcM7L6pLo0wv/HefPHx9OgqjY6TQzZN2qSW1+j5iJb
	 C0TQDfggobQt3/DjsvQovsKQ4kG7a2N6/2yyMPBbddMJFOW9Bzno03XjjK+9W5436m
	 C0bMXP6XrQ0PP7BYFN5Sd8JzMp3QeHiGq7ZPdhTuAusvVI1aOQL4By3DNuH0WsMU1h
	 G4B/jAMVUs4WT+h+jai5YCsyDTxKD4XSxhQkbUJl2Rm9QPDFEKoDVC5N0sqaZwfHH/
	 1BFeRPZEdgywQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Apr 2024 22:48:01 +0200
X-ME-IP: 86.243.17.157
Message-ID: <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
Date: Mon, 15 Apr 2024 22:47:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/01/2024 à 14:29, Christophe JAILLET a écrit :
> Most of seq_puts() usages are done with a string literal. In such cases,
> the length of the string car be computed at compile time in order to save
> a strlen() call at run-time. seq_write() can then be used instead.
> 
> This saves a few cycles.
> 
> To have an estimation of how often this optimization triggers:
>     $ git grep seq_puts.*\" | wc -l
>     3391
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Hi,

any feed-back on this small optimisation of seq_puts()?

Most of its usage would be optimized and a strlen() would be saved in 
all the corresponding cases.


$ git grep seq_puts.*\" | wc -l
3436

$ git grep seq_puts | wc -l
3644

CJ

> ---
> Checked by comparing the output of a few .s files.
> Here is one of these outputs:
> 
> $ diff -u drivers/clk/clk.s.old drivers/clk/clk.s | grep -C6 seq_w
> 
>   	call	clk_prepare_unlock	#
>   # drivers/clk/clk.c:3320: 	seq_puts(s, "}\n");
>   	movq	%r12, %rdi	# s,
> +	movl	$2, %edx	#,
>   	movq	$.LC66, %rsi	#,
> -	call	seq_puts	#
> +	call	seq_write	#
>   	call	__tsan_func_exit	#
>   # drivers/clk/clk.c:3322: }
>   	xorl	%eax, %eax	#
> @@ -34520,6 +34521,7 @@
>   	popq	%rbp	#
>   	popq	%r12	#
> --
>   # drivers/clk/clk.c:3205: 		seq_puts(s, "-----");
>   	call	__sanitizer_cov_trace_pc	#
> +	movl	$5, %edx	#,
>   	movq	$.LC72, %rsi	#,
>   	movq	%r13, %rdi	# s,
> -	call	seq_puts	#
> +	call	seq_write	#
>   	jmp	.L2134	#
>   .L2144:
>   # drivers/clk/clk.c:1793: 	return clk_core_get_accuracy_no_lock(core);
> @@ -35225,20 +35228,23 @@
>   	leaq	240(%r12), %rdi	#, tmp95
>   	call	__tsan_read8	#
> --
>   	movq	%r12, %rdi	# s,
> +	movq	$.LC77, %rsi	#,
>   # drivers/clk/clk.c:3244: 	struct hlist_head **lists = s->private;
>   	movq	240(%r12), %rbp	# s_9(D)->private, lists
>   # drivers/clk/clk.c:3246: 	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
> -	call	seq_puts	#
> +	call	seq_write	#
>   # drivers/clk/clk.c:3247: 	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
> +	movl	$142, %edx	#,
>   	movq	$.LC78, %rsi	#,
>   	movq	%r12, %rdi	# s,
> -	call	seq_puts	#
> +	call	seq_write	#
>   # drivers/clk/clk.c:3248: 	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
> +	movl	$142, %edx	#,
>   	movq	$.LC79, %rsi	#,
>   	movq	%r12, %rdi	# s,
> -	call	seq_puts	#
> +	call	seq_write	#
>   # drivers/clk/clk.c:3251: 	clk_prepare_lock();
>   	call	clk_prepare_lock	#
>   .L2207:
> @@ -37511,7 +37517,7 @@
>   	subq	$16, %rsp	#,
>   # drivers/clk/clk.c:3082: {
> ---
>   fs/seq_file.c            |  4 ++--
>   include/linux/seq_file.h | 10 +++++++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index f5fdaf3b1572..8ef0a07033ca 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -669,7 +669,7 @@ void seq_putc(struct seq_file *m, char c)
>   }
>   EXPORT_SYMBOL(seq_putc);
>   
> -void seq_puts(struct seq_file *m, const char *s)
> +void __seq_puts(struct seq_file *m, const char *s)
>   {
>   	int len = strlen(s);
>   
> @@ -680,7 +680,7 @@ void seq_puts(struct seq_file *m, const char *s)
>   	memcpy(m->buf + m->count, s, len);
>   	m->count += len;
>   }
> -EXPORT_SYMBOL(seq_puts);
> +EXPORT_SYMBOL(__seq_puts);
>   
>   /**
>    * seq_put_decimal_ull_width - A helper routine for putting decimal numbers
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index 234bcdb1fba4..15abf45d62c5 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -118,7 +118,15 @@ void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
>   __printf(2, 3)
>   void seq_printf(struct seq_file *m, const char *fmt, ...);
>   void seq_putc(struct seq_file *m, char c);
> -void seq_puts(struct seq_file *m, const char *s);
> +void __seq_puts(struct seq_file *m, const char *s);
> +#define seq_puts(m, s)						\
> +do {								\
> +	if (__builtin_constant_p(s))				\
> +		seq_write(m, s, __builtin_strlen(s));		\
> +	else							\
> +		__seq_puts(m, s);				\
> +} while (0)
> +
>   void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
>   			       unsigned long long num, unsigned int width);
>   void seq_put_decimal_ull(struct seq_file *m, const char *delimiter,


