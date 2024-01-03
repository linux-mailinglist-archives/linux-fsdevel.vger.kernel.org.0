Return-Path: <linux-fsdevel+bounces-7229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606FF822FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCBF285E4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010C1BDF3;
	Wed,  3 Jan 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="zhdJL75h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278321BDC5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33687627ad0so9769675f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293834; x=1704898634; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bXNwxpUDgjd1HqwAtyR3JBj0sSAlzYyMJhJeLU+RMHI=;
        b=zhdJL75hotTbe2cjhYOKJ8k53YDXZ1kfDK+BoRIYBjUfHTRIbgG5ykJSjQ/cBJe4d8
         X2MDOJ8kfrxAtICgN63Q0xZgMhFjtR4sE0Vpe5sEvebl4mKzkr10eEGxhxNn/edEXzF8
         hiTzaxl8bo6NY6w7j2znuVc7YH6poTKH3myq26B38pcE+66LhRRPIfbfFSRvDks3UAHH
         6ARivyVhcaZx+Aml5TbOixito79mes0EcQNFuYA0Fx+K1Ovs5t/IzxeHg0k9jEcMlXOV
         FuY7xwueDLIcdd/1ZSCbMX6DDMU0PGHIe93JoE2aJiqT3OoT92es1sDE8Veshn/VQ3u0
         woNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293834; x=1704898634;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXNwxpUDgjd1HqwAtyR3JBj0sSAlzYyMJhJeLU+RMHI=;
        b=rsu8/UwAl1NhfwWgAIDB4e0A4citS2bNRpaAF7lqlds5ljml/Cc59SdIbgq2EF/mxq
         fG6pawjj2LY3994O0M7quRDpjLwihKHT47Bh03JTvw9kE4wgIvQcViWIRwf/WY+Cevlk
         e7Yru3ZQvvHkwWOsmq7eYRnxE9hwHXLmKPEOjhbXHc2nNfUdA1FdIluUir2aeDvFwMTO
         gVN7ireCCKAZ7tG4dbFYLWQsrHvzB+bq0HCptIRzQW2a0ulNuDjwkAwGHucrCSQFx/K1
         YLfhIaLiV3ZsPL80L/muf3Nix8Tz7AAXLiM56HTLlBkiIJxSurenAvW1HsxJqmnjfgUH
         zsWw==
X-Gm-Message-State: AOJu0YzqTfGVbkVh9bSLaEpDU45d7A6e1OxdO9mXyI6zB8LBMV8DeHMG
	IEUZLaHHG9Fq3R28I7LAD3rigSasiEd42g==
X-Google-Smtp-Source: AGHT+IEuT3AEMOkxFTRLO+KaQVOlBSLjooNv0V2LCqZ3Ljx3iMclFmiAsk67Tzvcd5V39iLSlwbnlA==
X-Received: by 2002:a5d:6ac1:0:b0:336:7bb4:bab2 with SMTP id u1-20020a5d6ac1000000b003367bb4bab2mr10062819wrw.15.1704293834587;
        Wed, 03 Jan 2024 06:57:14 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b0033719111458sm14121254wrs.36.2024.01.03.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:14 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-16-wedsonaf@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 15/19] rust: fs: add basic support for fs buffer heads
Date: Wed, 03 Jan 2024 15:17:28 +0100
In-reply-to: <20231018122518.128049-16-wedsonaf@gmail.com>
Message-ID: <877ckq5uuk.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

[...]

> +// SAFETY: The type invariants guarantee that `INode` is always ref-counted.
> +unsafe impl AlwaysRefCounted for Head {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_bh(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::put_bh(obj.cast().as_ptr()) }

I would prefer the target type of the cast to be explicit.

> +    }
> +}
> +
> +impl Head {
> +    /// Returns the block data associated with the given buffer head.
> +    pub fn data(&self) -> &[u8] {
> +        let h = self.0.get();
> +        // SAFETY: The existence of a shared reference guarantees that the buffer head is
> +        // available and so we can access its contents.
> +        unsafe { core::slice::from_raw_parts((*h).b_data.cast(), (*h).b_size) }

Same

BR Andreas


