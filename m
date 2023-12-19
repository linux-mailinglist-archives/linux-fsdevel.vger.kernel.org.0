Return-Path: <linux-fsdevel+bounces-6488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941FE818837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAE1C242A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094618E1A;
	Tue, 19 Dec 2023 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhejx43F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE118E0C
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f6729a57fso613046d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702990902; x=1703595702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FrKoQsj7bW6Krr8WntSc/YIwx65jqHqch8JPyqGyUM=;
        b=Vhejx43FzjCpLeex5VSIc0QEBnNcUQKJlEexsRdQPG5245aEg+DTHROLLnCEWzHuec
         WuWtOB9bSQBa9+H+l0UIsII3V8xzx9ID0l6tiDLSFYAt8KvdSHT8CXa84PCXl+Fwwtq9
         WivXfx+3S3ajvcTmDHNBblYHSpYGnvlV1EM7ZbMtUFADZbchrBunAhRbXsYZraPbsYQ2
         h73OV5FBH7UqxVaWFTawkfFKcmeYgVw/Tzg3AgrtFh3erzasL9N8eoJACUE1RruZZJ2d
         NpWvbZNxfUNEoK9S35zZo3g4B1SE3KJnipKfwLDY8qqjO1gewbVX7MGz5ouFN1M3Zv2L
         VsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990902; x=1703595702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FrKoQsj7bW6Krr8WntSc/YIwx65jqHqch8JPyqGyUM=;
        b=KHGjKzd4gmW8B2eIQ9kVzbFTpD2vkV4XQUin225RV5MKKmoeiRnEZ9uqmZG6EIZx/M
         NilJQRw1QKuo4AG3jY/rpaSqmI979TY73SHGmfKKquw4kPrFqDoYhKTd1w9J2jb57/4u
         LxJpkcFcZmEQdRHC+VCV5kLQrGE0jZaYYqRPWBJtQWNfwKqahIxE9X3p3VZFdu5c0oia
         3FomVTFVxKKVvHSMVxsXK4iq4hAn6fhxI0IgR8ScnkvKcdswggZTtIo+A4FwYx8G1XdF
         dIVYdy0ZVGr+mWXT9IinpONGr/TFwCC6nruMdiIaUk3W6s5oVqpOKXLVmTuwjpdyI2Dh
         lU+A==
X-Gm-Message-State: AOJu0YzlaPTVPu+iZNvse4sW4UI8bApZ6kG1HAHG4CRkvZkHfVmd87OL
	xAQ6iu7lURE7Nbi92TcSym06rLthqepFB1IgU2s=
X-Google-Smtp-Source: AGHT+IF7CkUZkbk6hs9Uu9K6jC5ZChfMNBOCyEIY+uqgZdUGDAQWPzBz2F9U0T4gRkd9pL3XfQTwXmtCnqvM0uXvkWc=
X-Received: by 2002:a05:6214:19c4:b0:67a:ca07:cf96 with SMTP id
 j4-20020a05621419c400b0067aca07cf96mr1469519qvc.39.1702990902051; Tue, 19 Dec
 2023 05:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm> <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm> <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm> <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm> <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm> <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm>
In-Reply-To: <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Dec 2023 15:01:29 +0200
Message-ID: <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"

> > Here is what I was thinking about:
> >
> > https://github.com/amir73il/linux/commits/fuse_io_mode
> >
> > The concept that I wanted to introduce was the
> > fuse_inode_deny_io_cache()/fuse_inode_allow_io_cache()
> > helpers (akin to deny_write_access()/allow_write_access()).
> >
> > In this patch, parallel dio in progress deny open in caching mode
> > and mmap, and I don't know if that is acceptable.
> > Technically, instead of deny open/mmap you can use additional
> > techniques to wait for in progress dio and allow caching open/mmap.
> >
> > Anyway, I plan to use the iocachectr and fuse_inode_deny_io_cache()
> > pattern when file is open in FOPEN_PASSTHROUGH mode, but
> > in this case, as agreed with Miklos, a server trying to mix open
> > in caching mode on the same inode is going to fail the open.
> >
> > mmap is less of a problem for inode in passthrough mode, because
> > mmap in of direct_io file and inode in passthrough mode is passthrough
> > mmap to backing file.
> >
> > Anyway, if you can use this patch or parts of it, be my guest and if you
> > want to use a different approach that is fine by me as well - in that case
> > I will just remove the fuse_file_shared_dio_{start,end}() part from my patch.
>
> Hi Amir,
>
> here is my fuse-dio-v5 branch:
> https://github.com/bsbernd/linux/commits/fuse-dio-v5/
>
> (v5 is just compilation tested, tests are running now over night)

This looks very nice!
I left comments about some minor nits on github.

>
> This branch is basically about consolidating fuse write direct IO code
> paths and to allow a shared lock for O_DIRECT. I actually could have
> noticed the page cache issue with shared locks before with previous
> versions of these patches, just my VM kernel is optimized for
> compilation time and some SHM options had been missing - with that fio
> refused to run.
>
> The branch includes a modified version of your patch:
> https://github.com/bsbernd/linux/commit/6b05e52f7e253d9347d97de675b21b1707d6456e
>
> Main changes are
> - fuse_file_io_open() does not set the FOPEN_CACHE_IO flag for
> file->f_flags & O_DIRECT
> - fuse_file_io_mmap() waits on a dio waitq
> - fuse_file_shared_dio_start / fuse_file_shared_dio_end are moved up in
> the file, as I would like to entirely remove the fuse_direct_write iter
> function (all goes through cache_write_iter)
>

Looks mostly good, but I think that fuse_file_shared_dio_start() =>
fuse_inode_deny_io_cache() should actually be done after taking
the inode lock (shared or exclusive) and not like in my patch.

First of all, this comment in fuse_dio_wr_exclusive_lock():

        /*
         * fuse_file_shared_dio_start() must not be called on retest,
         * as it decreases a counter value - must not be done twice
         */
        if (!fuse_file_shared_dio_start(inode))
                return true;

...is suggesting that semantics are not clean and this check
must remain last, because if fuse_dio_wr_exclusive_lock()
returns false, iocachectr must not be elevated.
This is easy to get wrong in the future with current semantics.

The more important thing is that while fuse_file_io_mmap()
is waiting for iocachectr to drop to zero, new parallel dio can
come in and starve the mmap() caller forever.

I think that we are going to need to use some inode state flag
(e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
unless we do not care about this possibility?
We'd only need to set this in fuse_file_io_mmap() until we get
the iocachectr refcount.

I *think* that fuse_inode_deny_io_cache() should be called with
shared inode lock held, because of the existing lock chain
i_rwsem -> page lock -> mmap_lock for page faults, but I am
not sure. My brain is too cooked now to figure this out.
OTOH, I don't see any problem with calling
fuse_inode_deny_io_cache() with shared lock held?

I pushed this version to my fuse_io_mode branch [1].
Only tested generic/095 with FOPEN_DIRECT_IO and
DIRECT_IO_ALLOW_MMAP.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse_io_mode

