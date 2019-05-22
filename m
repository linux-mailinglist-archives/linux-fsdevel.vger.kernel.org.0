Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F62690C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfEVRZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 13:25:20 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37129 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVRZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 13:25:20 -0400
Received: by mail-lf1-f42.google.com with SMTP id m15so1681385lfh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7Rirt74S1yD4yP+J2ZudOTJniWaSa0DpfPmuZp5N3E=;
        b=XFgwzL9Czq/fUxRs5wHgvyNhi48yDGB+xxuz4WmxU2bfW8cmFdsEuI5Ki6hbzd/a4B
         MrkJ1ez2xmHk7U6faB0FgfHgq7r+CSeQMoXnl94dt6Fyvi7wTpNbTiyOWJJ3MdFjeEjL
         3+wMZFMdBxq7kxREhPScxqLrw9FYA+05kZQOmVnk9ajF3rjARVRmQWfCqfc8L49ETUsp
         iEFEZbHQGM+oOBdJcCuFa4PfRrPTGn0d17ZiTmwUBSzha+Q8UFL5VJnGYCtbKPhkTM/4
         qIYq9LWStYMzriPDLqxFEkaVZc/B885dMgfOpN0WXQTMgehjnvjSoJdIyjVvflEN7mRn
         Ej6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7Rirt74S1yD4yP+J2ZudOTJniWaSa0DpfPmuZp5N3E=;
        b=JtMM05vbhGOM2gedS8GmEiIzuBIQvmNdSsiCFFDdyFOE9B5OW3UJLYIg5PpBLb2tSt
         s+JrY+YxWI8rO9bDvSaGmavXSsuuNaZxnFf3X+1KR95GC1cu1w6Dph77VdF6UuRVSbaN
         n3CXFDTWcRdUFrqcJ7lzYuAN+NAaEasbdAfryV3NE3wxAe0UCMsOQXKc3eMUSzMGroIK
         EOIcW2PtUEO96upYaZ2Tu8uLUDuX5cqAYrfIaSOmT2vkkfVSc6VXswy+SEoqlElRfdF4
         qsCkdlpIo6+hcSdTpFTPVT24r8Ti1w6hoVLuyC4CZkYbG5u4nqPCBx/T8yLW9FgCEzyk
         tcpg==
X-Gm-Message-State: APjAAAWzpy+xzJVM20f4ijD2LSWv6KGBfmGh+jobNVHZaoYxQ1k+abIu
        8TqlRCmt/6Tz3R+97aFPQxOn3Sg0acOGhq7Ngo6k/Q==
X-Google-Smtp-Source: APXvYqxdFfXLG78m2vTeD305QxiaBew4ujuFAwdoEZuXGRQDa4VxSsSzGydy8lR/NKz6uA1dQX+d96aJ2p6nduX9IDE=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr37020653lfl.159.1558545917089;
 Wed, 22 May 2019 10:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
 <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com> <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
In-Reply-To: <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
From:   Yurii Zubrytskyi <zyy@google.com>
Date:   Wed, 22 May 2019 10:25:05 -0700
Message-ID: <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hang on, fuse does use caches in the kernel (page cache,
> dcache/icache).  The issue is probably not lack of cache, it's how the
> caches are primed and used.  Did you disable these caches?  Did you
> not disable invalidation for data, metadata and dcache?  In recent
> kernels we added caching readdir as well.  The only objects not cached
> are (non-acl) xattrs.   Do you have those?
Android (which is our primary use case) is constantly under memory
pressure, so caches
don't actually last long. Our experience with FOPEN_KEEP_CACHE has
shown that pages are
evicted more often than the files are getting reopened, so it doesn't
help. FUSE has to re-read
the data from the backing store all the time.
We didn't use xattrs for the FUSE-based implementation, but ended up
requiring a similar thing in
the Incremental FS, so the final design would have to include them.

> Re prefetching data:
> there's the NOTIFY_STORE message.
To add to the previous point, we do not have the data for prefetching,
as we're loading it page-by-page
from the host. We had to disable readahead for FUSE completely,
otherwise even USB3 isn't fast enough
to deliver data in that big chunks in time, and applications keep
hanging on page faults.

Overall, better caching doesn't save much *on Android*; what would
work is a full-blown data storage system inside
FUSE kernel code, that can intercept requests before they go into user
mode and process them completely. That's how
we could keep the data out of RAM but still get rid of that extra
context switch and kernel-user transition.
But this also means that FUSE becomes damn too much aware of the
specific storage format and all its features, and
basically gets specialized implementation of one of its filesystem
inside the generic FUSE code.
Even if we separate that out, the kernel API between the storage and
FUSE ended up being complete VFS API copy,
with some additions to send data blocks and Merkle tree blocks in. The
code is truly if we stuff the Incremental FS into
FUSE instead of mounting it directly.

-- 
Thanks, Yurii
