Return-Path: <linux-fsdevel+bounces-7223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7E822FEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ED21C21733
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC31A734;
	Wed,  3 Jan 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="HCCVy2GJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10E1A70B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5d8a6730so59907215e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293828; x=1704898628; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=qQwnCXrd05NY+Z7IX+h0AaqYDBg7QO9Ec6n/qqGH/gE=;
        b=HCCVy2GJrL6XGXdSgji6P+Ct5PQXrd7ngO5GsWkANxuhm7mP0AsYYYonaDJbm4k9t1
         VsgCHGtbLWnUALLC4GJ2LGAV3BiQu2n4IJHEaOaK6/EFQ/VBwNOQLNpfT2JQhsw9WSDO
         BUdvnFhYnwN7qDMOhp1zw+gcaKhML42Br8M2dFYR99/8ae2EZzlTng4PjcGBXtLoFXAK
         /QBA73EAQqs2d6HGQ581ARMdxxb4M7yFuso9WfTSE0bBx9dDH6sO5nyaqgeHDzQhXmB6
         s4i2SRNUY/qNFVtk2/4hGTTpIoeceJswW7Qgxhw7uaEhA1/fyLQ7c3uLUXZLXctQvSEu
         7Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293828; x=1704898628;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQwnCXrd05NY+Z7IX+h0AaqYDBg7QO9Ec6n/qqGH/gE=;
        b=qhVdO8EIYKxWcakBReDrELCRHVTQT1tu3es4Tt72wk41bQrDRKvveaAZbQfkNIIZTT
         n6wsxEj+0z8rLhxwr2kMdEsMEYIVz3Cs0JjdjH8NCZvKh1LrvBXQKIw01ADKggxN+CXe
         whfjL9+77XI9XLag5+NndBPyy6J3kgNHJM97jHJT8OEelb4Xg1lo8xVc8yrkozx7ZEJG
         GOJyDnoAZM90kZo4VUWUZb0SaNiWXAUVF404XJkxbyXktCSOBubgUy6HxpbvGoQiRsCR
         M72UL2EcEV06b7ignR4C5TZLk5jUN8f69FhLEQV/S12dkpfQHmWsJY76b8C9wZDO80F/
         pUng==
X-Gm-Message-State: AOJu0YyDw7SWPBS20XvhiH0zbHcgusdBnCc/GpovtYD+40WgZHZxkhfe
	pT/VDxi6X0IVyTXkgwyglCXPFKqemFb59Q==
X-Google-Smtp-Source: AGHT+IGAYkAJPhIDHRRMofgASPkn7CgUV4z6XZf0NjmWIz4mrzIVM4J6E1j3RegEGTcVgniGWKZRYQ==
X-Received: by 2002:a05:600c:4f11:b0:40d:85a2:40e9 with SMTP id l17-20020a05600c4f1100b0040d85a240e9mr2574886wmq.1.1704293828119;
        Wed, 03 Jan 2024 06:57:08 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b0040d87b9eec7sm2562676wmo.32.2024.01.03.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:07 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-6-wedsonaf@gmail.com>
 <86207b78-db19-4847-b039-c84ab9452060@ryhl.io>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Alice Ryhl <alice@ryhl.io>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew
 Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Date: Wed, 03 Jan 2024 13:45:46 +0100
In-reply-to: <86207b78-db19-4847-b039-c84ab9452060@ryhl.io>
Message-ID: <87wmsq5v6c.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Alice Ryhl <alice@ryhl.io> writes:

> On 10/18/23 14:25, Wedson Almeida Filho wrote:
>> +    /// Returns the super-block that owns the inode.
>> +    pub fn super_block(&self) -> &SuperBlock<T> {
>> +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
>> +        // shared reference (&self) to it.
>> +        unsafe { &*(*self.0.get()).i_sb.cast() }
>> +    }
>
> This makes me a bit nervous. I had to look up whether this field was a pointer
> to a superblock, or just a superblock embedded directly in `struct inode`. It
> does look like it's correct as-is, but I'd feel more confident about it if it
> doesn't use a cast to completely ignore the type going in to the pointer cast.
>
> Could you define a `from_raw` on `SuperBlock` and change this to:
>
>     unsafe { &*SuperBlock::from_raw((*self.0.get()).i_sb) }
>
> or perhaps add a type annotation like this:
>
>     let i_sb: *mut super_block = unsafe { (*self.0.get()).i_sb };
>     i_sb.cast()

I think it would also be nice to make the cast explicit:

  i_sb.cast::<SuperBlock<T>>()

otherwise the cast is no different than `as _` with all the caveats that
comes with.

BR Andreas

