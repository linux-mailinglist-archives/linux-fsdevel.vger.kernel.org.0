Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB34463E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbhK3TIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 14:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhK3TIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:08:30 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB89C061574;
        Tue, 30 Nov 2021 11:05:11 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 14so27384890ioe.2;
        Tue, 30 Nov 2021 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tA8rNLmEmTIGMleqHR6JTe/h5SWKaBwqglrHS55I9XA=;
        b=HhIYf9GuGhLuVNkOq1UPoco6ZyvWOcH19Io95SXOMEMFD4XCs02yNCaJKtuHkZc338
         b249IUBZiTkjDooHxoQZkFTAsnACfBCgqkvXKYfis0uOl4t9i+m9sMJP/D9qK57T3SMW
         uKYTyAeKGpzNP83pSQ4Q6AshTLeLN2QTXV7P4LNjTxrXLzzyXaY9EadUPfpvSvA+vJ/p
         +54+y8CIHlkgQv6GqqACFN8VT6MzuobWeN+hJQewuGkAJXi/h/zNHBs8XKXAUgY/Rp8u
         sO2dtRvJog51ka7uJpajHPm/SeXfzFPZXKsPx1JtAj26k+FUwGqkPBche8Ub964mNNMV
         BsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA8rNLmEmTIGMleqHR6JTe/h5SWKaBwqglrHS55I9XA=;
        b=kuIIZ5xtoieiD0LfAmUJFAzzhbxVMRuU6E60WiCS7705VwxjfG2eeeC/APqP/1x/+6
         TpPfjSU3zbdLIGI/u96/FPED3l+Ge2oWDrqr1rfZ5+g8c9qH60y4ouEYhDWwgD58DjVP
         XLDlO+kh7vWHmx7h+cmmXRpRs91G2z62y7K83USyb8oBAv59MflgipnpZy1ric0kiTOm
         O+2IrhGFrFZvCj2CfJfrS5Ox+9HMfYEBkHlnlQEBn7JFXwinG++qkUIAZarlgJ+tqOEg
         g6qMb8mKbIcDJQ5Q95evwRj90rNg9Hce+Ea/9H8t2lB2qffO/0tG4kqtmSvw+Pceu2lZ
         sM/A==
X-Gm-Message-State: AOAM530CmoAXxXf7lCXxL/NmOP8++x655yqe9g9Q9fuRu31ECuZoF6H0
        iWIcZdSqqTNONN4shO4Na1QLJfniCsXjmeQK7qV5fOor
X-Google-Smtp-Source: ABdhPJzynjLoYw9pgrZO/Ro6nsOBbraw4PkA3fySltZ5MiGIQS28ii6pG+kVrY0l/zn3KDCk2rmKYuebyTe3bkndFM0=
X-Received: by 2002:a02:a489:: with SMTP id d9mr1691020jam.47.1638299110774;
 Tue, 30 Nov 2021 11:05:10 -0800 (PST)
MIME-Version: 1.0
References: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
In-Reply-To: <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 21:04:59 +0200
Message-ID: <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  > I was thinking about this a bit more and I don't think I buy this
>  > explanation. What I rather think is happening is that real work for syncfs
>  > (writeback_inodes_sb() and sync_inodes_sb() calls) gets offloaded to a flush
>  > worker. E.g. writeback_inodes_sb() ends up calling
>  > __writeback_inodes_sb_nr() which does:
>  >
>  > bdi_split_work_to_wbs()
>  > wb_wait_for_completion()
>  >
>  > So you don't see the work done in the times accounted to your test
>  > program. But in practice the flush worker is indeed burning 1.3s worth of
>  > CPU to scan the 1 million inode list and do nothing.
>  >
>
> That makes sense. However, in real container use case,  the upper dir is always empty,
> so I don't think there is meaningful difference compare to accurately marking overlay
> inode dirty.
>

It's true the that is a very common case, but...

> I'm not very familiar with other use cases of overlayfs except container, should we consider
> other use cases? Maybe we can also ignore the cpu burden because those use cases don't
> have density deployment like container.
>

metacopy feature was developed for the use case of a container
that chowns all the files in the lower image.

In that case, which is now also quite common, all the overlay inodes are
upper inodes.

What about only re-mark overlay inode dirty if upper inode is dirty or is
writeably mmapped.
For other cases, it is easy to know when overlay inode becomes dirty?
Didn't you already try this?

Thanks,
Amir.
