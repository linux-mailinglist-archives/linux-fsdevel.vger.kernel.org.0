Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9130099C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbhAVRWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbhAVQFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:05:19 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EBC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 08:04:39 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id v19so1508041ooj.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uOcDAQTvbMFsGW2wN4EW2b9gto6d910RnbvMcnDkd/c=;
        b=bXsPFrB1DV10D190ze4iNrrBtwxSSmGn8GrafBPD8BtyliQHqw2ujTyLDkoZ5OWg96
         6mipU1MFOuHREzL57e6Q38tAtdqs11tzO6y7rYligD0OnUaG7xcUlS0KmEkfAM0Yswgu
         l++pDvDOnvP/GdecS4qp8nK7kjhRgr4yIBykvRURR76yz2BEwPVLZ3CX8agwcxDDHSFr
         QiXBIbhIQPDcMg2oRqrarqb5vDUym50sSShT5GnuyVhklzDs16MyaduLffdt/dXgdOnO
         Xk4kYv3OylnZ5xhixhBLqJ58EZw1FUQbqz4w08kgeUSkYT3jgBjpggdnOyWhVRE7Czu1
         kV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uOcDAQTvbMFsGW2wN4EW2b9gto6d910RnbvMcnDkd/c=;
        b=dNNDby4t0BvZUFtIibr7QmnOAu2bIq5Gn5rMDOhW1YVDYnrw+NoMPkin1Z4uEF754s
         HHtBYsrfToM9LZVq/pJHgh+fGAbHPbK1jJo44MjjEKj3ACC0jwlbrSj4N6TWhWiySXVj
         F4NEIw+ROwwkPkcRFnoSZtfwzSuDuaIYYo5qBj2JxDL63q4itXzfwBVskiA2sQJJdxOP
         yliUPvYEbypUNpYTIoN0fWwgeh9lSFMdd69mNhv+sxlZdpEntMNu1n1Fgc/rm7JO+GE5
         sr0IHR1I2E3VmffQ6Cg0Djx0VBwje02FP8ioSgwBjVT7gFrfUALi9AKgZrPkQQBa4XyB
         w9Yw==
X-Gm-Message-State: AOAM533kAs7VTDuDrN5T8+5K9BrbmaFeaKenVxyZavyiQsoILxCcsOT2
        +rwqXBH9At2noY4lycLMGURYYw==
X-Google-Smtp-Source: ABdhPJzIjq8M1jb98C+LunJrol58KNv9YwNRZtbUnN8EKKfvwE3/ZyEzVUyiSlU2AxPGpBEkCN2gaA==
X-Received: by 2002:a4a:94cc:: with SMTP id l12mr4259445ooi.70.1611331478531;
        Fri, 22 Jan 2021 08:04:38 -0800 (PST)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id q6sm1743948otm.68.2021.01.22.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 08:04:37 -0800 (PST)
Date:   Fri, 22 Jan 2021 10:04:19 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on
 security.capability
Message-ID: <20210122160419.GA81247@sequoia>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
 <20210119162204.2081137-2-mszeredi@redhat.com>
 <87a6t4ab7h.fsf@x220.int.ebiederm.org>
 <CAJfpegvy4u9cC7SXWqteg54q-96fH3SqqfEybcQtAMxsewAGYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvy4u9cC7SXWqteg54q-96fH3SqqfEybcQtAMxsewAGYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-20 08:52:27, Miklos Szeredi wrote:
> On Tue, Jan 19, 2021 at 10:11 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> >
> > Miklos Szeredi <mszeredi@redhat.com> writes:
> >
> > > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > > filesystems (overlayfs and ecryptfs) into account.
> > >
> > > That patch fixed the overlay case, but made the ecryptfs case worse.
> > >
> > > Restore old the behavior for ecryptfs that existed before the overlayfs
> > > fix.  This does not fix ecryptfs's handling of complex user namespace
> > > setups, but it does make sure existing setups don't regress.
> >
> > Today vfs_setxattr handles handles a delegated_inode and breaking
> > leases.  Code that is enabled with CONFIG_FILE_LOCKING.  So unless
> > I am missing something this introduces a different regression into
> > ecryptfs.
> 
> This is in line with all the other cases of ecryptfs passing NULL as
> delegated inode.
> 
> I'll defer this to the maintainer of ecryptfs.

eCryptfs cannot be exported so I do not think this proposed fix to
ecryptfs_setxattr() creates a new regression wrt inode delegation.

Tyler

> 
> Thanks,
> Miklos
