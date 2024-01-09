Return-Path: <linux-fsdevel+bounces-7652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A1E828C91
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C64289A74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB83C468;
	Tue,  9 Jan 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3soMEpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04F3C097;
	Tue,  9 Jan 2024 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2049434276.2;
        Tue, 09 Jan 2024 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704824722; x=1705429522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhhgTuWR0cqJm/rRcVpjpNyL7CU/HczMZ4SiqapHg60=;
        b=f3soMEpJsiAEEsMdVb8GAridOWaV5pKhc4G6JERmXDcy74mjpP0D4N6cwRt9aKfFL4
         iay6XntvEKlGYOo8KPSiSjU7ieTJCnYiXmIWhNcTRFowfvNGiqHVe/cqPG9WZCFPyChY
         voMPLRhcCrp7sURZTI1aSyhcaDLmSz41zRv+KpezFi3zWm10H9c+zCju42PN5k5pK47i
         qVl2AjYq9/9b/WC0Pla+Ub2lBRxljuZTG5pirv80g3VAnMNPnv4d3SPPXB/oxGkPX8Fk
         mU+Bup8SdJgGSgNXyV70uGo/PwXsQlwstxbsxA1Nuaz/GVp/N4hzrd2K0OhedK6og54M
         mwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824722; x=1705429522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhhgTuWR0cqJm/rRcVpjpNyL7CU/HczMZ4SiqapHg60=;
        b=BRFBwHk5WOMUGhhiIGQQNh9R5Z97fgDTFZVM7jgPcAdT37T5nXT/0KYQOsnsdcc4a2
         /HtpWoaG+8Q9Rn0fSsAkoQ7e5m0vwlpB17UaMruplAxnAu+YE9+EovXhAqahgAtK+tQ7
         6Enyv7W2uGGuNKkvtRSvGw9XXIHs/BmANgcTzB463+kZjS1tNldKsLBhtD9a+0+jGQ7s
         v8OYiwqL8paqVlwwFBVAX5uemZEi6nxGfnz5f55YsqHgjjhXm0zcGlUZq1umlU1ZEwyl
         Esg7GIN5eliGN9zrY5u7K6fO+pXEEQwJaqfOLlXZdH7/so3TXt94v8KHNoXugiIYlOSK
         yerw==
X-Gm-Message-State: AOJu0Yztnrv2IVnC3Oi1vBnXj+wldzabkSGjduSGTKzja9WzH2F2faJm
	xNSsRHZEGOLCVz6djHriEwyslR9+3O9hYxaMtNA=
X-Google-Smtp-Source: AGHT+IHef3JcK98RzDGilRrId8COyN0y9BJ4bTtDqeZcC0tpGd2CnWPwWL5QSHRyiR1sB3AuvhzM3EIQ9r2Al1GqamY=
X-Received: by 2002:a25:2e41:0:b0:dbd:5bbd:8d37 with SMTP id
 b1-20020a252e41000000b00dbd5bbd8d37mr2582105ybn.103.1704824722302; Tue, 09
 Jan 2024 10:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org> <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
 <ZZYOkCyujEaR7TdX@casper.infradead.org>
In-Reply-To: <ZZYOkCyujEaR7TdX@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 9 Jan 2024 15:25:11 -0300
Message-ID: <CANeycqppvyhHhDSpRjxcNMGsKhm=-HCsR3fvpaH9FirNZCnSGw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 22:49, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 03, 2024 at 04:04:26PM -0300, Wedson Almeida Filho wrote:
> > On Wed, 3 Jan 2024 at 15:02, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Oct 31, 2023 at 05:14:08PM -0300, Wedson Almeida Filho wrote:
> > > > > Also, I see you're passing an inode to read_dir.  Why did you decide to
> > > > > do that?  There's information in the struct file that's either necessary
> > > > > or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
> > > > > network filesystems need user credentials to do readdir, which are stored
> > > > > in struct file.  Block filesystems store readahead data in struct file.
> > > >
> > > > Because the two file systems we have don't use anything from `struct
> > > > file` beyond the inode.
> > > >
> > > > Passing a `file` to `read_dir` would require us to introduce an
> > > > unnecessary abstraction that no one uses, which we've been told not to
> > > > do.
> > > >
> > > > There is no technical reason that makes it impractical though. We can
> > > > add it when the need arises.
> > >
> > > Then we shouldn't merge any of this, or even send it out for review
> > > again until there is at least one non-toy filesystems implemented.
> >
> > What makes you characterize these filesystems as toys? The fact that
> > they only use the file's inode in iterate_shared?
>
> They're not real filesystems.  You can't put, eg, root or your home
> directory on one of these filesystems.

tarfs is a real file system, we use it to mount read-only container
layers on top of dm-verity for integrity.

The root of a container is made of potentially several of these
layers, overlaid with overlayfs. We use this in confidential kata
containers where we need to enforce authenticity and integrity of
data: with tarfs, the original tar file is exposed to confidential
VMs, so we can use existing signatures to verify that an attacker
hasn't modified the data before the container starts, and dm-verity
ensures that we catch any attempts by the host to change data after
the container is running.

> > > Either stick to the object orientation we've already defined (ie
> > > separate aops, iops, fops, ... with substantially similar arguments)
> > > or propose changes to the ones we have in C.  Dealing only with toy
> > > filesystems is leading you to bad architecture.
> >
> > I'm trying to understand the argument here. Are saying that Rust
> > cannot have different APIs with the same performance characteristics
> > as C's, unless we also fix the C apis?
> >
> > That isn't even a requirement when introducing new C apis, why would
> > it be a requirement for Rust apis?
>
> I'm saying that we have the current object orientation (eg each inode
> is an object with inode methods) for a reason.  Don't change it without
> understanding what that reason is.  And moving, eg iterate_shared() from
> file_operations to struct file_system_type (effectively what you've done)
> is something we obviously wouldn't want to do.

I don't think I'm changing anything. AFAICT, I'm adding a way to write
file systems in Rust. It uses the C API faithfully -- if you find ways
in which it doesn't, I'd be happy to fix them.

To show its usefulness, I'm providing a real file system that uses it,
is simpler than the C version, and contains no unsafe code. So barring
bugs in the abstractions, it contains no memory safety issues.

Why do you feel I need to mimic the unsafe (in the sense that the
compiler doesn't help you prevent safety issues) way C does it _now_?

Cheers,
-Wedson

