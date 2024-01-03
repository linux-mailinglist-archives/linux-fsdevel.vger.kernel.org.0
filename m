Return-Path: <linux-fsdevel+bounces-7230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3328822FF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56391C2376A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210D1C282;
	Wed,  3 Jan 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="NsG4qZt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E21BDE4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336f2c88361so5950043f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293835; x=1704898635; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=26lBYaET/iovrDgfz5YLoogPsBj8H+kNuh6NM10QAGs=;
        b=NsG4qZt/4yOdlbvusC/niK7SKEvzWZliVmzVyb0jd3vx4UuQqLoh5c+Uv1qalWhLwf
         gS3CQsaBgDrO0L17verCcHUImt2quG8R4XklfLHlUdRsJPXeksj5f9gCP5esV4IgbXw7
         +wXP+n6oA4Wz7IwFAw8bREL0ClLzyme4gQVJPHJv1LCEIgfMkR57vBNGmzyczEP8QoOK
         qfwNEm6g+DRnYmBzIWnxsHRbsK5Hv83TYfI206kcykAGfl2AdmHU2+qe2yGTFsNTVP6S
         +mxNn1gMWYOq0CSmjDpmB8Sb9kPLD72kRAB9nxngZ+ZK2dEzpKCGVZiugIh3Pt9f3H/7
         qCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293835; x=1704898635;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26lBYaET/iovrDgfz5YLoogPsBj8H+kNuh6NM10QAGs=;
        b=tRUZay1tCljYz75hQQX6GyqI9ABB8GjeitLdTZlD9Pta2NkhoxTbIoQmuWRmNpQMTN
         ty7L507AoqygOE4ZDwaH0ThqOVQ+79Pke9cmZVQJq9vkNrMz2uX1ZsWk1s55rZ4oj08c
         noheK8k79LkFa6YgxR/65U8fMoz8m7Ipg2Slbwlf7CwVlqR60dgxyZ7MhrhxOycRu88x
         bXOEJu/kWKrlajkmel8/H6Kuc+0vx8tcW4DeY98orWuCIsdtoou8cijEkv/rvYPrIyz7
         Svijs2l8QKFS/MJO/VOAsxQTf5PgyRMAyBDNogCIX/d8XXulcOZvovZMgNOzpg4XaIyj
         jz9A==
X-Gm-Message-State: AOJu0Ywn8yDmJscM6q5tJTHiRUj4EDoI4ZudlOyFm/zLjDYlQr++13Vr
	r0kEs8tqWItzvMSdS+Mwjas3+wCKAYfV8Q==
X-Google-Smtp-Source: AGHT+IF5XvWQFrhLzBY8gWki2UzwvkZ39dl/9BCBmTftZkehY8DjAJrW6v8naOFtGtfDOZT9fliIpQ==
X-Received: by 2002:a05:600c:211a:b0:40d:7fde:148b with SMTP id u26-20020a05600c211a00b0040d7fde148bmr3556391wml.217.1704293835609;
        Wed, 03 Jan 2024 06:57:15 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c4fd000b0040d2e37c06dsm2537188wmq.20.2024.01.03.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:15 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-17-wedsonaf@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 16/19] rust: fs: allow file systems backed by a
 block device
Date: Wed, 03 Jan 2024 15:38:25 +0100
In-reply-to: <20231018122518.128049-17-wedsonaf@gmail.com>
Message-ID: <8734ve5uu5.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

[...]

> @@ -479,6 +500,65 @@ pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, New
>              })))
>          }
>      }
> +
> +    /// Reads a block from the block device.
> +    #[cfg(CONFIG_BUFFER_HEAD)]
> +    pub fn bread(&self, block: u64) -> Result<ARef<buffer::Head>> {
> +        // Fail requests for non-blockdev file systems. This is a compile-time check.
> +        match T::SUPER_TYPE {
> +            Super::BlockDev => {}
> +            _ => return Err(EIO),
> +        }
> +
> +        // SAFETY: This function is only valid after the `NeedsInit` typestate, so the block size
> +        // is known and the superblock can be used to read blocks.
> +        let ptr =
> +            ptr::NonNull::new(unsafe { bindings::sb_bread(self.0.get(), block) }).ok_or(EIO)?;
> +        // SAFETY: `sb_bread` returns a referenced buffer head. Ownership of the increment is
> +        // passed to the `ARef` instance.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })

I would prefer the target of the cast to be explicit.

BR Andreas

