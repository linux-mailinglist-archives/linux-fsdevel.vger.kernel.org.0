Return-Path: <linux-fsdevel+bounces-7224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59720822FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D91C237C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA01B26D;
	Wed,  3 Jan 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="vAW5zvyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E81A70C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso106121165e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293829; x=1704898629; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr5HbBl5N6cy6sjezjCV1TgQWW1jCwwc89aGHLxyq6c=;
        b=vAW5zvyIYvkaAS5ajss0kIukb9KLxT0BW+dIZt59iRWBJBgFn6kYzwVsZ8qBO+oEI/
         KhFrm70DpbFE3OTOgpDEiXs8CEMz1lrMXA4HDp+3ujU6rwCaOD8WHaDN3Y4Z4VOiITcQ
         d1Iwbjjm/6jbFc9R4JWju5i3fZbovyX94MaWESuxbMy5BRBQDFnnI8Hz9hYE6A96jV8V
         xxozOvQj6XBxTZbInk+QEumOKueyuyM0mTqZ+CBKD2/XhjVET4EQvI3rvY7pFwDTWz3P
         ++T1KhaXnRijZI9uv0htrKM87fJXy9hWqupWJcMfX45clCS/hRXLG/bGW4FqMoUi0wb9
         l0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293829; x=1704898629;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5HbBl5N6cy6sjezjCV1TgQWW1jCwwc89aGHLxyq6c=;
        b=HGBuipoEG8181vymGvdnAfgYIgo6X0DYQz7RkSVr2KXK07re6nYNJEbj9jNRPcXC4l
         QoKtFWxLINuKRox5vwh5yRH+0035OzHwbfAy2V+krQ1amrn5xgo0+UuFB//o7/QSTK2Q
         sTy7ReU/ffYmHAnRUJJ81Y5IA1HVircVFmOf0DqTqaX+Sj7lGITAjappnTW/BpogD0cL
         jJe2ORKu82A+QwSbkXRZzVHXeJieGbepSWHQLVK+mjq9J8jkkIEKN9Gxx3WhrJGHPmOy
         yQ0OW2/mPvT1+bP/I9RwQu4u2JK7+FZbEm5XbTrhzr2FeUdSKQKYhuXXgmc/AHTVWEVF
         yhMw==
X-Gm-Message-State: AOJu0YzukRZ4mdZggPimZwzDbHth7cCO09dQ9gWX4zsha+Eb5gFAx2I+
	6o7Isj3GEj6NoYZUkY7TstvlJcNjhpc8aA==
X-Google-Smtp-Source: AGHT+IG6NkBEBRre4rmvJ5aFuSttrI4POj1UgW3FBTw0+m89hLL4U0g5ob2JT9piT4ekwuslRk4Cig==
X-Received: by 2002:a7b:cb86:0:b0:40d:71a3:66bb with SMTP id m6-20020a7bcb86000000b0040d71a366bbmr4982697wmi.117.1704293829162;
        Wed, 03 Jan 2024 06:57:09 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b0040d87b5a87csm2507258wmb.48.2024.01.03.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:08 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-6-wedsonaf@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Date: Wed, 03 Jan 2024 13:54:34 +0100
In-reply-to: <20231018122518.128049-6-wedsonaf@gmail.com>
Message-ID: <87sf3e5v55.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

> +/// The number of an inode.
> +pub type Ino = u64;

Would it be possible to use a descriptive name such as `INodeNumber`?

> +    /// Returns the super-block that owns the inode.
> +    pub fn super_block(&self) -> &SuperBlock<T> {
> +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
> +        // shared reference (&self) to it.
> +        unsafe { &*(*self.0.get()).i_sb.cast() }
> +    }

I think the safety comment should talk about the pointee rather than the
pointer? "The pointee of `i_sb` is immutable, and ..."

BR Andreas


