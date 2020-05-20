Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAB1DB165
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 13:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETLUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 07:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 07:20:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA823C061A0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 04:20:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so3332486ejq.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56SGhcyK7h3nlixc/WhwZR2DoIL8pNFZvChxJ3qBgro=;
        b=TxfYKVxYVFfCs8i2Vi9BQbNqxUsBlp737CU0QRWDFGflGGUqQ4KL0DrSCj9f5f8B9A
         srhor7uAaj568a/aA6w2KN1ZCj78ruiLf0w8AbVcmpl077VvtkSUPqEd5VpkpSCdIUb9
         Cfjv1GMVvlTf5E8AbNLN3bn55sKNfaVjuvKp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56SGhcyK7h3nlixc/WhwZR2DoIL8pNFZvChxJ3qBgro=;
        b=aWRZNkzHi/JccT3QPvXnVYNDIopmSeNMExktcK8p/0W4/MsAGAVo4RrUbGsMo9Rr5G
         d4W8WpTpJpzoVcmjTean4qDeGuBxnJYTD48T02rUaHoolwxHuyov9xxS1P9ebZoKPPAT
         twBGMjn1qReP2YMmzFzmZhBxBU4PdFttTr2Qpm7/trIn+W9r05s0xsRm/KWO9XoiRcOs
         ZatnvC71JR2vTW8+rKTMnTxEvO8KxiuPXTFIdBO/lPridI9duwabxGoRaVCqxJ2lomp9
         8b2bH3BxcBApuYyfTT1wSKkRJ8ZvMtskg05x5A1ecSOqA8lNRy0Qvynn6lV8r2Eaw02X
         ASVg==
X-Gm-Message-State: AOAM531SiTFmMXeaTPMCJf971+O8ganKS2jFCqHDvX4knPG+QIq201do
        tYmeHAOjdq3tV541C7So5bzfnOK2AXb1x6dN7trFxQ==
X-Google-Smtp-Source: ABdhPJx+P94dGQ64ppbHjlnXmNryVQv5No+atzEiem400vzryPPIDwWWuPy1i2M+gn6vmeZdZUDvyc08UUJyNWG+QyE=
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr3543965eja.14.1589973638596;
 Wed, 20 May 2020 04:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b4684e05a2968ca6@google.com> <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com> <9a56a79a-88ed-9ff4-115e-ec169cba5c0b@oracle.com>
In-Reply-To: <9a56a79a-88ed-9ff4-115e-ec169cba5c0b@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 May 2020 13:20:27 +0200
Message-ID: <CAJfpegsNVB12MQ-Jgbb-f=+i3g0Xy52miT3TmUAYL951HVQS_w@mail.gmail.com>
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 2:35 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/18/20 4:41 PM, Colin Walters wrote:
> >
> > On Tue, May 12, 2020, at 11:04 AM, Miklos Szeredi wrote:
> >
> >>> However, in this syzbot test case the 'file' is in an overlayfs filesystem
> >>> created as follows:
> >>>
> >>> mkdir("./file0", 000)                   = 0
> >>> mount(NULL, "./file0", "hugetlbfs", MS_MANDLOCK|MS_POSIXACL, NULL) = 0
> >>> chdir("./file0")                        = 0
> >>> mkdir("./file1", 000)                   = 0
> >>> mkdir("./bus", 000)                     = 0
> >>> mkdir("./file0", 000)                   = 0
> >>> mount("\177ELF\2\1\1", "./bus", "overlay", 0, "lowerdir=./bus,workdir=./file1,u"...) = 0
> >
> > Is there any actual valid use case for mounting an overlayfs on top of hugetlbfs?  I can't think of one.  Why isn't the response to this to instead only allow mounting overlayfs on top of basically a set of whitelisted filesystems?
> >
>
> I can not think of a use case.  I'll let Miklos comment on adding whitelist
> capability to overlayfs.

I've not heard of overlayfs being used over hugetlbfs.

Overlayfs on tmpfs is definitely used, I guess without hugepages.
But if we'd want to allow tmpfs _without_ hugepages but not tmpfs
_with_ hugepages, then we can't just whitelist based on filesystem
type, but need to look at mount options as well.  Which isn't really a
clean solution either.

> IMO - This BUG/report revealed two issues.  First is the BUG by mmap'ing
> a hugetlbfs file on overlayfs.  The other is that core mmap code will skip
> any filesystem specific get_unmapped area routine if on a union/overlay.
> My patch fixes both, but if we go with a whitelist approach and don't allow
> hugetlbfs I think we still need to address the filesystem specific
> get_unmapped area issue.  That is easy enough to do by adding a routine to
> overlayfs which calls the routine for the underlying fs.

I think the two are strongly related:  get_unmapped_area() adjusts the
address alignment, and the is_file_hugepages() call in
ksys_mmap_pgoff() adjusts the length alignment.

Is there any other purpose for which  f_op->get_unmapped_area() is
used by a filesystem?

Thanks,
Miklos
