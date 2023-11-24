Return-Path: <linux-fsdevel+bounces-3645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F547F6CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71310281B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BF8F57;
	Fri, 24 Nov 2023 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxLAdW1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2277C1A8;
	Thu, 23 Nov 2023 23:37:29 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a0d4e79c1so4874096d6.1;
        Thu, 23 Nov 2023 23:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700811448; x=1701416248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG/gsUHWvkT6+6+wGSY1vHckBzAuwdxp2sKBiJla/IM=;
        b=WxLAdW1gLkJ5gdjZzt+Hi9zxWtia+g8x0Ofype9SJmgUHdG1nKmExQdhK41Y59lsG6
         hHIiQMehBEiG0h1XEaNlSR09bPmzQpizuvEGJhe/yRDokQpFROu/mP3bDH8OCtqEvBAF
         6vb7AKovYvrvvv/5v4npkvwekSpkYiywK2mfDYhcEt30ZhFj6pMZWDD1Il5bhYGe1Iix
         CsUtWuFAvSfLSPHxuqrLTfcrSOZDnukvmhQBFLaurE0AOu8hOHTlU+O3w3ARugkeX6yq
         NQGsydN2oYYSY7Ofm0Ex7Bf9JJEbUG4Gw1MqmnmA1DBT2L9PKbwINu4CH2mHtFzuNaLg
         Q9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811448; x=1701416248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RG/gsUHWvkT6+6+wGSY1vHckBzAuwdxp2sKBiJla/IM=;
        b=pJWcI2YsLX29/sxSZLrwMH8PdJ9SyqiOVVIYeT/pVU8wE2rR9Ut4AJlQlzSoPff+z5
         xOEC+1B9Wun/7nhQFXZN6tLmm/OgAAC960TYuqMU0f6cd1sZ4ZJ1SqJIsxXkxDcgRuLt
         TVzTdddUF3mS4vf9hHNlib+Y+fRbSDasw6dZmoRXSc2rmDWZld/55gWLn1cCwJNcNuFA
         y1MGeeunN1cHaKI1uqItZTxgMwnM1c024e9+EcqWQrTokm9d8qR7vZDQP0Rjh0VPfY33
         pPxBPZroCQb5LbHrhI54ZJxj5LAHfyraqdctF3WzSt0Xfop2pHjlMH4Tz6HNwwsiG4wN
         06Gg==
X-Gm-Message-State: AOJu0YzxzJCk0Nh7yIkwCt0dmbqhUhULusRTBJSwhda8pjxuLqIKWe2m
	iiGRbz+U8bNo/O8vyXGDqEAOlqjUP3LZyXbX+WSUbS5m8OM=
X-Google-Smtp-Source: AGHT+IFIgzLSZTxPu/9pqbHNF1McIBPTZSA1ASIa03RiyKiEHRPw6i5jY3pqVfKtA+LW45UiNtL6o5zH2D6HizzyLFQ=
X-Received: by 2002:a0c:eecd:0:b0:679:e7dd:fa9 with SMTP id
 h13-20020a0ceecd000000b00679e7dd0fa9mr2164016qvs.10.1700811448213; Thu, 23
 Nov 2023 23:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060553.GA575483@ZenIV> <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-9-viro@zeniv.linux.org.uk>
In-Reply-To: <20231124060644.576611-9-viro@zeniv.linux.org.uk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 09:37:16 +0200
Message-ID: <CAOQ4uxgRiQCG_Q5TP+05_N4V=iFTemzGTd62ePgAgotK52EAAQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] [software coproarchaeology] dentry.h: kill a
 mysterious comment
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 8:07=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> there's a strange comment in front of d_lookup() declaration:
>
> /* appendix may either be NULL or be used for transname suffixes */
>
> Looks like nobody had been curious enough to track its history;
> it predates git, it predates bitkeeper and if you look through
> the pre-BK trees, you finally arrive at this in 2.1.44-for-davem:
>   /* appendix may either be NULL or be used for transname suffixes */
>  -extern struct dentry * d_lookup(struct inode * dir, struct qstr * name,
>  -                               struct qstr * appendix);
>  +extern struct dentry * d_lookup(struct dentry * dir, struct qstr * name=
);
> In other words, it refers to the third argument d_lookup() used to have
> back then.  It had been introduced in 2.1.43-pre, on June 12 1997,
> along with d_lookup(), only to be removed by July 4 1997, presumably
> when the Cthulhu-awful thing it used to be used for (look for
> CONFIG_TRANS_NAMES in 2.1.43-pre, and keep a heavy-duty barfbag
> ready) had been, er, noticed and recognized for what it had been.
>
> Despite the appendectomy, the comment remained.  Some things really
> need to be put out of their misery...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/dcache.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 9706bf1dc5de..a5e5e274eee0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -270,7 +270,6 @@ extern void d_move(struct dentry *, struct dentry *);
>  extern void d_exchange(struct dentry *, struct dentry *);
>  extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
>
> -/* appendix may either be NULL or be used for transname suffixes */
>  extern struct dentry *d_lookup(const struct dentry *, const struct qstr =
*);
>  extern struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
>

Al,

Since you like pre-git archeology...

Mind digging up what this comment in fs.h is about:

/* needed for stackable file system support */
extern loff_t default_llseek(struct file *file, loff_t offset, int whence);

Or we can just remove it without digging up what the comment used
to refer to ;)

Thanks,
Amir.

