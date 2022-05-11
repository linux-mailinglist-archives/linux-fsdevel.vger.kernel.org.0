Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5105237A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbiEKPrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEKPrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 11:47:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8CE443E9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 08:47:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o69so2604588pjo.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoGgk2kWCSBtnI2kB77KiBaGWej6XbWC5/VEwo6RBHk=;
        b=UqYYm4C2fW4mDDQmf6XLxKC/brLgrS9dhVDWviBXTaq7FGn78m3bKsJeMNJHx2wk3+
         rULMOiRS+P0ZWx8dLnN2gYJeg71wDglfQFgm5wJHMj2qg5/Je0FPLtro+JJ6iV9Lob+J
         IfdmTH9vDGh3EOK9znhgho9UvGmGaFbGdjwMUbVl29Q5hQzDGDMzzgme//fpmJKfSdEI
         SgE4NoSwVXXKTDiY9+FrBKb4FfRMkGv3/Z2uTE8/r0rYGZMyexdZWg0vAeis9xPQ/jRV
         7K3vxdq6GuFpZBRpOMVOPe+7txqriPUqd25KBoLnRqz1lSlh2qUpWn2idi6g4DJR4Bsb
         UR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoGgk2kWCSBtnI2kB77KiBaGWej6XbWC5/VEwo6RBHk=;
        b=mluOejvdl/2JuxluiofDv3OsHW/KMvTUeax53yYFE32FJdhVpLlxiEO69RaJZX1c8m
         nEys/o3n+PoLy+zV4ZGuOA3z3Qr8Cg5og6fRnKW/gtoPRvFOsrvfyelZoV6oku1KkNyw
         IUBTC/BtS+u9+tCGOjlTPxRqGQPiJOmOx9bclSKo83iQfEmh6CO7AwVfMFcsKwKyRZKE
         coAEMCoxsyGbi1QQSzPDEdHodFyxsuAn0CMzEvPRyqzwcphcHKO8ZtXKha2N7NZHxuXm
         4h4xwWACOWHcIi3GVuQykN8KR3K/2P64D1kqSr2hGCgyEnLML8jfj1n463I6NDc82tJF
         Ccyg==
X-Gm-Message-State: AOAM532wKM088U/FiOvWWe1L6zh2zVXxXC+JFsrUpvVFOuFqJjiQiqi8
        zzrOemwVKRa4oXxGhYK6vPt2Ifb9JsH3cOfE1eMSYw==
X-Google-Smtp-Source: ABdhPJzb8nRTew8x8xkS/1yBjApTvNis41Up/0XXYEsHQ3BPsgO0HbXOB1SZHhshqbsoueRXOJsPthjQCb9zCs/wlcY=
X-Received: by 2002:a17:90b:4c85:b0:1dc:5778:5344 with SMTP id
 my5-20020a17090b4c8500b001dc57785344mr6055143pjb.8.1652284021808; Wed, 11 May
 2022 08:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
 <20220511000352.GY27195@magnolia> <20220511014818.GE1098723@dread.disaster.area>
 <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
 <20220510192853.410ea7587f04694038cd01de@linux-foundation.org>
 <20220511024301.GD27195@magnolia> <20220510222428.0cc8a50bd007474c97b050b2@linux-foundation.org>
 <20220511151955.GC27212@magnolia>
In-Reply-To: <20220511151955.GC27212@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 May 2022 08:46:50 -0700
Message-ID: <CAPcyv4gwV5ReuCUbJHZPVPUJjnaGFWibCLLsH-XEgyvbn9RkWA@mail.gmail.com>
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linmiaohe@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 8:21 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Oan Tue, May 10, 2022 at 10:24:28PM -0700, Andrew Morton wrote:
> > On Tue, 10 May 2022 19:43:01 -0700 "Darrick J. Wong" <djwong@kernel.org> wrote:
> >
> > > On Tue, May 10, 2022 at 07:28:53PM -0700, Andrew Morton wrote:
> > > > On Tue, 10 May 2022 18:55:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > > > It'll need to be a stable branch somewhere, but I don't think it
> > > > > > really matters where al long as it's merged into the xfs for-next
> > > > > > tree so it gets filesystem test coverage...
> > > > >
> > > > > So how about let the notify_failure() bits go through -mm this cycle,
> > > > > if Andrew will have it, and then the reflnk work has a clean v5.19-rc1
> > > > > baseline to build from?
> > > >
> > > > What are we referring to here?  I think a minimal thing would be the
> > > > memremap.h and memory-failure.c changes from
> > > > https://lkml.kernel.org/r/20220508143620.1775214-4-ruansy.fnst@fujitsu.com ?
> > > >
> > > > Sure, I can scoot that into 5.19-rc1 if you think that's best.  It
> > > > would probably be straining things to slip it into 5.19.
> > > >
> > > > The use of EOPNOTSUPP is a bit suspect, btw.  It *sounds* like the
> > > > right thing, but it's a networking errno.  I suppose livable with if it
> > > > never escapes the kernel, but if it can get back to userspace then a
> > > > user would be justified in wondering how the heck a filesystem
> > > > operation generated a networking errno?
> > >
> > > <shrug> most filesystems return EOPNOTSUPP rather enthusiastically when
> > > they don't know how to do something...
> >
> > Can it propagate back to userspace?
>
> AFAICT, the new code falls back to the current (mf_generic_kill_procs)
> failure code if the filesystem doesn't provide a ->memory_failure
> function or if it returns -EOPNOSUPP.  mf_generic_kill_procs can also
> return -EOPNOTSUPP, but all the memory_failure() callers (madvise, etc.)
> convert that to 0 before returning it to userspace.
>
> I suppose the weirder question is going to be what happens when madvise
> starts returning filesystem errors like EIO or EFSCORRUPTED when pmem
> loses half its brains and even the fs can't deal with it.

Even then that notification is not in a system call context so it
would still result in a SIGBUS notification not a EOPNOTSUPP return
code. The only potential gap I see are what are the possible error
codes that MADV_SOFT_OFFLINE might see? The man page is silent on soft
offline failure codes. Shiyang, that's something to check / update if
necessary.
