Return-Path: <linux-fsdevel+bounces-7228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF6822FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AEF1F24718
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E2F1BDD8;
	Wed,  3 Jan 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="PGmrMfmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E81B29A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3374e332124so475002f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293833; x=1704898633; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=PHgl55sG9GwAd3JNNacRnTRNBBE/Qay3HmG6eQZjYlY=;
        b=PGmrMfmoBj2GC9wiFEP7nTBLBLZEYSf6+ISm9RP5a+LO47f5q+e/+ZsXm5C59llkfR
         UxX7geMS4A2+xXtIGJ+leDe/U2uWr4fnmQNtcKrCPEBlq8Wu7I0X86C0GrbBKkydSFls
         K00v0Y5v4QLnAxvhs5kzdgPuqy2GYHFliYhfbPLqVxT9A/I+rzWN6BWSANNShmUK0BkM
         m59Cj1KTN+hXFFu4D3BH3DWGqEsNShlmaNl/XsrGlXuiIbBCDLOhwTMi4UGcVRf0XyG/
         yFBEvo8UODYkhlugMzX4sjL7K7pAiab+2IXmdaQqTBI+GCINT8n7t4SWDygmgTFYn0/b
         DKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293833; x=1704898633;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHgl55sG9GwAd3JNNacRnTRNBBE/Qay3HmG6eQZjYlY=;
        b=EH7mSPKWTYB+NVb294CeqYLfQ1AyCWcSW0iFSHQtGHLslLGU+UBkBQqt6vXmYmS9Lf
         uYJ5VCQLK1J7Zx0NaK96XoN4b0P26TjMrpSQirkiWymroC2jw5StZluQCseFyzYVA8aa
         qSCGJTMvZWTPdXx9uclgzOFCw7CRz6GjHPEXKcJsTkh3wI31ICouo9Oj15zmvdzsLn/2
         +9h49AqWuuavHLZd2z3Q5R4eZSqZGmKFT+ppgvGJFTDHAKnYP+sud/PxpSg8o4Fbakke
         e4YuZhCvn7XFKLVFl5p44YflKQJmX5VAuuo8CZfR4ayhHwFCU2zMXT/gxpwT5fJ74/WG
         EsTg==
X-Gm-Message-State: AOJu0YzTr8eAc8ky8ILNtWGBwwK3XtDVjdXQoH+89WVa76+aKJ1U2y76
	o5QHSgeaPiVSpb7ufAwOcYMczClAryARjg==
X-Google-Smtp-Source: AGHT+IEgNqWFV96ggC4LQ9YLY4NIwjOwnf+YJysQyIyLaNjux3Hp/MmKSEMeu/SoacuUoawSfDUAkQ==
X-Received: by 2002:a5d:638b:0:b0:337:9b0:58d4 with SMTP id p11-20020a5d638b000000b0033709b058d4mr5014749wru.115.1704293833555;
        Wed, 03 Jan 2024 06:57:13 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id dr16-20020a5d5f90000000b003373ef060d5sm8285124wrb.113.2024.01.03.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:13 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-15-wedsonaf@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 14/19] rust: fs: add per-superblock data
Date: Wed, 03 Jan 2024 15:16:00 +0100
In-reply-to: <20231018122518.128049-15-wedsonaf@gmail.com>
Message-ID: <87bka25uut.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

[...]

> @@ -472,6 +495,9 @@ pub struct SuperParams {
>  
>      /// Granularity of c/m/atime in ns (cannot be worse than a second).
>      pub time_gran: u32,
> +
> +    /// Data to be associated with the superblock.
> +    pub data: T,
>  }
>  
>  /// A superblock that is still being initialised.
> @@ -522,6 +548,9 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>              sb.0.s_blocksize = 1 << sb.0.s_blocksize_bits;
>              sb.0.s_flags |= bindings::SB_RDONLY;
>  
> +            // N.B.: Even on failure, `kill_sb` is called and frees the data.
> +            sb.0.s_fs_info = params.data.into_foreign().cast_mut();

I would prefer to make the target type of the cast explicit.

BR Andreas


