Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C240FFE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhIQTj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 15:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhIQTjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:39:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209F6C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 12:38:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g184so10572504pgc.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2+Hh3F66cL6BpjONlixjboMa3d3Dr6Wccaac4ba0jE=;
        b=vPVoybXUpHkOIx/4oBHOyHOxXIaG88Kxkxe2gf1MN6vplcSMHfkPomSPpz+YdV5+I2
         m7oyFT5ixFaermZpqd88wRx43KQtE4XNw/VnDn7EfXhYdZgcFGaWdsuEznvwEOfYW8ab
         n+YxXRB6lmhJ431BOxOoQE8wCsczglL1XfDT+XX1SbvMDI6omSXbO42R6BQNGkNNfY3w
         0IjSq7dNz5H/nNJDKkROUb7wUrC9/QVcJ+KQCl+ZSQAJh2UUET/dM29VdewqTAoVSknq
         b/ItlBAGc5tpvPvwEpRz4mlw9G1dZBf9962O/bicmwv3ZlANcXPeW1h6r2d/s9u8A4tw
         N9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2+Hh3F66cL6BpjONlixjboMa3d3Dr6Wccaac4ba0jE=;
        b=oqDxID4QNhk23faofN2TM6xmWPVIpkPQMtbXc/8ny5RNyGv9D46iu7r4QG6WfbOoIq
         FcVpmu2ZpghbEeuR4vIItSkiNbKcPQfVDq55od8oUOUXWKNdK7fgIAJ4KZYyck+lblxf
         5ggFoyza0GL4vO7OamWFLaTGGdUqTCTatEvocI7dOACVc0e6DlReA55CT16MxHxdSZ4o
         khLQkZ1Z9MfVdFrhnrZzhhdVbF2XOpnfCHDmSRwxASakD7RBN+xjfH/cpLkisbvyEqR0
         B1Ak2NGGVjqVtOcDGDJcZPsrDOl92u4PwOhtvpssp5ZuJ5LAMqXhfs+bWyYAr8GkO3Ov
         odtA==
X-Gm-Message-State: AOAM531w9rMouJNWejwvedPZFbbW2n9iKsDer7PglPO9QQS3i6fIQDNr
        QBoYESF7beIn7A1kEj8S+0RzEDkiPHI6Ph6T/o5SOw==
X-Google-Smtp-Source: ABdhPJw9Rph55U9iCJhtxsNCpmwsnCdMb15i9Rn5WefNvzVO816JUbUXWBiompaDXIZ9AAqQQxd1N1iZLl7s73K/osU=
X-Received: by 2002:a63:1262:: with SMTP id 34mr11217082pgs.356.1631907482638;
 Fri, 17 Sep 2021 12:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210914233132.3680546-1-jane.chu@oracle.com> <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com> <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
 <YULuMO86NrQAPcpf@infradead.org> <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
 <YUSPzVG0ulHdLWn7@infradead.org>
In-Reply-To: <YUSPzVG0ulHdLWn7@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 Sep 2021 12:37:51 -0700
Message-ID: <CAPcyv4hJZpoJPF5_6F+wUUjVY5fHXbVRsLfVNPSZxiS+7yzV0Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 16, 2021 at 11:40:28AM -0700, Dan Williams wrote:
> > > That was my gut feeling.  If everyone feels 100% comfortable with
> > > zeroingas the mechanism to clear poisoning I'll cave in.  The most
> > > important bit is that we do that through a dedicated DAX path instead
> > > of abusing the block layer even more.
> >
> > ...or just rename dax_zero_page_range() to dax_reset_page_range()?
> > Where reset == "zero + clear-poison"?
>
> I'd say that naming is more confusing than overloading zero.

Ok, I see Darrick has a better suggestion for the shed color.

>
> > > I'm really worried about both patartitions on DAX and DM passing through
> > > DAX because they deeply bind DAX to the block layer, which is just a bad
> > > idea.  I think we also need to sort that whole story out before removing
> > > the EXPERIMENTAL tags.
> >
> > I do think it was a mistake to allow for DAX on partitions of a pmemX
> > block-device.
> >
> > DAX-reflink support may be the opportunity to start deprecating that
> > support. Only enable DAX-reflink for direct mounting on /dev/pmemX
> > without partitions (later add dax-device direct mounting),
>
> I think we need to fully or almost fully sort this out.
>
> Here is my bold suggestions:
>
>  1) drop no drop the EXPERMINTAL on the current block layer overload
>     at all

s/drop no drop/do not drop/?

>  2) add direct mounting of the nvdimm namespaces ASAP.  Because all
>     the filesystem currently also need the /dev/pmem0 device add a way
>     to open the block device by the dax_device instead of our current
>     way of doing the reverse

Oh, interesting. I can get on board with that. There's currently no
/dev entry for namespaces. It's either /dev/pmemX, or /dev/daxX.Y as a
child of /sys/bus/nd/devices/namespaceX.Y. However, I see nothing
glaringly wrong with having /dev/daxX.Y always published regardless of
whether /dev/pmemX is also present.

>  3) deprecate DAX support through block layer mounts with a say 2 year
>     deprecation period
>  4) add DAX remapping devices as needed
>
> I'll volunteer to write the initial code for 2).  And I think we should
> not allow DAX+reflink on the block device shim at all.

Yeah, I think this can fly.
