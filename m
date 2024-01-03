Return-Path: <linux-fsdevel+bounces-7247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6B82354C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2577B23D4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B01CF9A;
	Wed,  3 Jan 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNIwlO/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA061CF81;
	Wed,  3 Jan 2024 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so7017706276.0;
        Wed, 03 Jan 2024 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308677; x=1704913477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3P7TvENTUXCCxDuer7owzhzadDBABeW0+xPh3g0xYl0=;
        b=MNIwlO/QLn9eMnG0khaQb3JVXUrvaXzC0WcOe3osKt3B+41Er0Fj3WL7eqgWewVjNs
         3po1symrrvXJy8VcHp2K0QIOqshFE95mKGBWQfrWqlsGXj2GYmT76Fm8pF9w8t4Jv2qr
         NhnSL2peJ5tG/90QzA7AXDFPNFr2Sipa+u0ciz2HWbfc82f9+wO/mXgWkuLW8vux5BgD
         jHqXGbDRutw+IcAbGtxrqoOQxn9Tv6FPdFlQgYcVO2fgZvH3Ds6t4W2M3AAuCcfKL/oe
         w0R9nRURP/BxSkSPG79ceM74svX4Ek31NJ0fXX3F9HurHJ9ixA0PWJfCUzHBFXbry3qP
         rrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308677; x=1704913477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P7TvENTUXCCxDuer7owzhzadDBABeW0+xPh3g0xYl0=;
        b=NESGEq22y2TU5YKslv1zmI++HRzOGbI6cqMJSWS3F9MEN2GXVkIBhLneEnNBxWixsc
         7uk5/SkRLOuNNM1IXHfLxpZ/1aP4S+kjJuV24bKcRCf+kS73Qq6Zx/mGWoujb+s3KRN3
         3PcOE1PG0uRwHILvhtklIx9EBLs96yrF9l6Be3Qxx1J1w0IVPEn9J5Wf+L81SdUK7dGW
         qFaaJLOWOxpKxU6MVdMbQSxqn64PbEI4ruDK+dMxgtQROWgf7l2bMyfjo1nf+fEImTrn
         by16mwbU6LFnI5c8m7SOiQDZc4anKgvWtvKch7t6LXVJPrV5xR9BaZkcJbBMisDTMmkV
         uFyg==
X-Gm-Message-State: AOJu0YxDh7Yv9QRuGHYs78RbIDNlI1QyL8MfV1i5rFoP6bQ4zuZIWVag
	L7pckhUL8WxXkdDy6p6k4DCUoNvjCGDlA2Q0c1E=
X-Google-Smtp-Source: AGHT+IHWctEo5+TAE3mBXsW2ui7AvYRXmEDIySDi90MKjt+/1jmLbTKkd4Fg3OVZUGviJa2OJZthnIaXyL1IFLmeTjw=
X-Received: by 2002:a05:6902:1a46:b0:dbd:af86:426e with SMTP id
 cy6-20020a0569021a4600b00dbdaf86426emr11152309ybb.45.1704308677590; Wed, 03
 Jan 2024 11:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com> <ZZWhQGkl0xPiBD5/@casper.infradead.org>
In-Reply-To: <ZZWhQGkl0xPiBD5/@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 3 Jan 2024 16:04:26 -0300
Message-ID: <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 15:02, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 31, 2023 at 05:14:08PM -0300, Wedson Almeida Filho wrote:
> > > Also, I see you're passing an inode to read_dir.  Why did you decide to
> > > do that?  There's information in the struct file that's either necessary
> > > or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
> > > network filesystems need user credentials to do readdir, which are stored
> > > in struct file.  Block filesystems store readahead data in struct file.
> >
> > Because the two file systems we have don't use anything from `struct
> > file` beyond the inode.
> >
> > Passing a `file` to `read_dir` would require us to introduce an
> > unnecessary abstraction that no one uses, which we've been told not to
> > do.
> >
> > There is no technical reason that makes it impractical though. We can
> > add it when the need arises.
>
> Then we shouldn't merge any of this, or even send it out for review
> again until there is at least one non-toy filesystems implemented.

What makes you characterize these filesystems as toys? The fact that
they only use the file's inode in iterate_shared?

> Either stick to the object orientation we've already defined (ie
> separate aops, iops, fops, ... with substantially similar arguments)
> or propose changes to the ones we have in C.  Dealing only with toy
> filesystems is leading you to bad architecture.

I'm trying to understand the argument here. Are saying that Rust
cannot have different APIs with the same performance characteristics
as C's, unless we also fix the C apis?

That isn't even a requirement when introducing new C apis, why would
it be a requirement for Rust apis?

Cheers,
-Wedson

