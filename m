Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A009410048
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhIQUXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhIQUW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:22:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D89C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 13:21:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e7so10682130pgk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8P/ocM2t2YFJb3hFlVvikABipXfDcrvJYjnQI/Pc2oY=;
        b=jKkIebtQy/64rwoKx8BBORdPcS7pcRGFeer2ZITl4fQMj2Dxupuu8/2V6F2WUIiRkZ
         hzsm7e1i/2VHuxg0VSqvFlJiKo0v4Ui286Ovcg3zT9OmLgSeGd97TauIHY6gvxDuYaPp
         Xj+s4AdSeqmWM5KrlaKW2FozE8SCoJQUnUsnXpBY44rpHE1ZTdbB6LEpZu88MrQjep7R
         6dK6ZFuyRSzTvKBe7D2Cd1RDp4FaHAL4h9/IOxlpja4CPXC+Ksd+iP2Pp841IZmCD9v1
         iMe6lGen3gv7yEW9D29g9Eu7JJhJY6VQ+yL8ECvjWeyHbczH3lmWBhnQQBjQeyP1/+Bk
         PMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P/ocM2t2YFJb3hFlVvikABipXfDcrvJYjnQI/Pc2oY=;
        b=WCB/0+nnIwabGUsIko8v35UuqtX6ekDUlVJ62Y7EbYg8ELXkY/9YMtSFSSlgDfHqP8
         ONb6/RtFQvwYNoOy6hSsq2R4catM3XU/JIQ5q1xDP9tCI5GIXQbA6Pmgnx6h8/63Ur+G
         1tTXRIP3V+56v+MTC09VXzov9IRPmphoZD1bOI91OvCk4I1iZBN9676p0aGEjGPyZmvV
         peqdD/7fEXgPNZxRg4h/lsikRg0SQOKV/4H5kUfsFCGXpkLl+6+0ifsip1oP7rUxo/Qu
         IlhlFfoY0RsgqlUDNR09f5fTjcP9y/qtvaArE5//IxR8X5GAukPKjZ75xWDA1hEEanVM
         w+tg==
X-Gm-Message-State: AOAM530C/sWdIk92j++1RiHz4kiBbd2L9BYKg0Sz4hjj1nhFtLGXpMAJ
        eh5D+oIO5OOiQIhIkk41HfSuhkA5ZQ7cxtsYYTOC4w==
X-Google-Smtp-Source: ABdhPJz6pZs8b4rTLRF6l/MEXnlyU2zD0PW32CvHmSHzYJ5xyUpo5M5M+k1BM1hqEEwhlnAIyc7OUqqASaST32B6YnI=
X-Received: by 2002:a63:1262:: with SMTP id 34mr11373646pgs.356.1631910096519;
 Fri, 17 Sep 2021 13:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210914233132.3680546-1-jane.chu@oracle.com> <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com> <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
 <YULuMO86NrQAPcpf@infradead.org> <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
 <YUSPzVG0ulHdLWn7@infradead.org> <20210917152744.GA10250@magnolia>
In-Reply-To: <20210917152744.GA10250@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 Sep 2021 13:21:25 -0700
Message-ID: <CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 8:27 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Sep 17, 2021 at 01:53:33PM +0100, Christoph Hellwig wrote:
> > On Thu, Sep 16, 2021 at 11:40:28AM -0700, Dan Williams wrote:
> > > > That was my gut feeling.  If everyone feels 100% comfortable with
> > > > zeroingas the mechanism to clear poisoning I'll cave in.  The most
> > > > important bit is that we do that through a dedicated DAX path instead
> > > > of abusing the block layer even more.
> > >
> > > ...or just rename dax_zero_page_range() to dax_reset_page_range()?
> > > Where reset == "zero + clear-poison"?
> >
> > I'd say that naming is more confusing than overloading zero.
>
> How about dax_zeroinit_range() ?

Works for me.

>
> To go with its fallocate flag (yeah I've been too busy sorting out -rc1
> regressions to repost this) FALLOC_FL_ZEROINIT_RANGE that will reset the
> hardware (whatever that means) and set the contents to the known value
> zero.
>
> Userspace usage model:
>
> void handle_media_error(int fd, loff_t pos, size_t len)
> {
>         /* yell about this for posterior's sake */
>
>         ret = fallocate(fd, FALLOC_FL_ZEROINIT_RANGE, pos, len);
>
>         /* yay our disk drive / pmem / stone table engraver is online */

The fallocate mode can still be error-aware though, right? When the FS
has knowledge of the error locations the fallocate mode could be
fallocate(fd, FALLOC_FL_OVERWRITE_ERRORS, pos, len) with the semantics
of attempting to zero out any known poison extents in the given file
range? At the risk of going overboard on new fallocate modes there
could also (or instead of) be FALLOC_FL_PUNCH_ERRORS to skip trying to
clear them and just ask the FS to throw error extents away.

> }
>
> > > > I'm really worried about both patartitions on DAX and DM passing through
> > > > DAX because they deeply bind DAX to the block layer, which is just a bad
> > > > idea.  I think we also need to sort that whole story out before removing
> > > > the EXPERIMENTAL tags.
> > >
> > > I do think it was a mistake to allow for DAX on partitions of a pmemX
> > > block-device.
> > >
> > > DAX-reflink support may be the opportunity to start deprecating that
> > > support. Only enable DAX-reflink for direct mounting on /dev/pmemX
> > > without partitions (later add dax-device direct mounting),
> >
> > I think we need to fully or almost fully sort this out.
> >
> > Here is my bold suggestions:
> >
> >  1) drop no drop the EXPERMINTAL on the current block layer overload
> >     at all
>
> I don't understand this.
>
> >  2) add direct mounting of the nvdimm namespaces ASAP.  Because all
> >     the filesystem currently also need the /dev/pmem0 device add a way
> >     to open the block device by the dax_device instead of our current
> >     way of doing the reverse
> >  3) deprecate DAX support through block layer mounts with a say 2 year
> >     deprecation period
> >  4) add DAX remapping devices as needed
>
> What devices are needed?  linear for lvm, and maybe error so we can
> actually test all this stuff?

The proposal would be zero lvm support. The nvdimm namespace
definition would need to grow support for concatenation + striping.
Soft error injection could be achieved by writing to the badblocks
interface.
