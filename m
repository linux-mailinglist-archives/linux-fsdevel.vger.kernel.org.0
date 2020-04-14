Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117931A8AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504696AbgDNT0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730103AbgDNTYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D174AC0610D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2020 12:05:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v1so1077855edq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2020 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gF1rMGZ/eX8G89eh4/hnEQhUj+jW1CwhhogtzydCw04=;
        b=kAbO6h8rAxnlPUj6sdwoV8am8x/5ArQ2M8OJsFa+YkS1RIfmPHFKEJY18CRNoAGtm7
         awWWFVONlQPnHlvqkUjg6uL/MDQOGsx73UodjlQ1LEI0blS67rdDe0rfMMkhcyVx59ng
         /XjBMPm1bEnSuvBdmJaEN8SDQVmOBc6oxlJBCWE3HubVS7g9ZrscxOtIty/JnbdfmKQ5
         T021eyBs86pI9j73PbTEpEKqK98Liv0/ZE8EBU1YSxeJUST3sasbCURvuo+AU4INgn1d
         Z99+Dd7JvRBaMHTq2mCVKu5owgzwgF89ly3P04mHKtUgm30djmmPXt0J2awvZLZa4rpe
         w97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gF1rMGZ/eX8G89eh4/hnEQhUj+jW1CwhhogtzydCw04=;
        b=CtvW/3iGLgNDwrXWR6zic4ghJ9xSpHfJ6y1/fqE36a0OB3m0hy2bW3TV0IHeR4ZBNg
         p8m0tdYd+atCX8lLWSAST/G8C84K9pHAu2rkJvM2y6PqR2iqEqnncwWA2AG0tRfSK21z
         4R8Pgdf7VpExSayDzlvlpfjpuclZnoE+cLChA8LBd0M0kzqnEglWfVU1Flusv0B1QM6d
         K9vlJ2EQsBvk2v+P4NSbe18Exhjq+YffmXaiVi1yixmu/TS62Wewl3WIjYYrd4duviIS
         uy6C6XR/BtFZXBGoE1LXO5FlQgdeYumkXcb+MUHbrMaUyiDEsopihe4TMPUJW8fHVQ2T
         FIAQ==
X-Gm-Message-State: AGi0PuaJt6y7ZDZNFoVUo+sIEQzEehKvIPkG8WKOdp7Iie4lBbX5OOLG
        3WRuTGuxo8mkRsF1v9q6PnVHmbVQGfDaxf2eR08vFw==
X-Google-Smtp-Source: APiQypLpxLw06YROHozj/c2cmajSpvDh2ixxHgmlY2cOrNPKW8LKK+/4LBCTENrfuZLVR/Gcbmd1iginW9IYtm3lsUI=
X-Received: by 2002:aa7:d711:: with SMTP id t17mr9242415edq.296.1586891109388;
 Tue, 14 Apr 2020 12:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-10-ira.weiny@intel.com>
 <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com> <20200414161509.GF6742@magnolia>
In-Reply-To: <20200414161509.GF6742@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Apr 2020 12:04:57 -0700
Message-ID: <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Mon, Apr 13, 2020 at 10:21:26PM -0700, Dan Williams wrote:
> > On Sun, Apr 12, 2020 at 10:41 PM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > Update the Usage section to reflect the new individual dax selection
> > > functionality.
> > >
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >
> > > ---
> > > Changes from V6:
> > >         Update to allow setting FS_XFLAG_DAX any time.
> > >         Update with list of behaviors from Darrick
> > >         https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> > >
> > > Changes from V5:
> > >         Update to reflect the agreed upon semantics
> > >         https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > > ---
> > >  Documentation/filesystems/dax.txt | 166 +++++++++++++++++++++++++++++-
> > >  1 file changed, 163 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> > > index 679729442fd2..af14c1b330a9 100644
> > > --- a/Documentation/filesystems/dax.txt
> > > +++ b/Documentation/filesystems/dax.txt
> > > @@ -17,11 +17,171 @@ For file mappings, the storage device is mapped directly into userspace.
> > >  Usage
> > >  -----
> > >
> > > -If you have a block device which supports DAX, you can make a filesystem
> > > +If you have a block device which supports DAX, you can make a file system
> > >  on it as usual.  The DAX code currently only supports files with a block
> > >  size equal to your kernel's PAGE_SIZE, so you may need to specify a block
> > > -size when creating the filesystem.  When mounting it, use the "-o dax"
> > > -option on the command line or add 'dax' to the options in /etc/fstab.
> > > +size when creating the file system.
> > > +
> > > +Currently 2 filesystems support DAX, ext4 and xfs.  Enabling DAX on them is
> > > +different at this time.
> > > +
> > > +Enabling DAX on ext4
> > > +--------------------
> > > +
> > > +When mounting the filesystem, use the "-o dax" option on the command line or
> > > +add 'dax' to the options in /etc/fstab.
> > > +
> > > +
> > > +Enabling DAX on xfs
> > > +-------------------
> > > +
> > > +Summary
> > > +-------
> > > +
> > > + 1. There exists an in-kernel access mode flag S_DAX that is set when
> > > +    file accesses go directly to persistent memory, bypassing the page
> > > +    cache.
> >
> > I had reserved some quibbling with this wording, but now that this is
> > being proposed as documentation I'll let my quibbling fly. "dax" may
> > imply, but does not require persistent memory nor does it necessarily
> > "bypass page cache". For example on configurations that support dax,
> > but turn off MAP_SYNC (like virtio-pmem), a software flush is
> > required. Instead, if we're going to define "dax" here I'd prefer it
> > be a #include of the man page definition that is careful (IIRC) to
> > only talk about semantics and not backend implementation details. In
> > other words, dax is to page-cache as direct-io is to page cache,
> > effectively not there, but dig a bit deeper and you may find it.
>
> Uh, which manpage?  Are you talking about the MAP_SYNC documentation?

No, I was referring to the proposed wording for STATX_ATTR_DAX.
There's no reason for this description to say anything divergent from
that description.
