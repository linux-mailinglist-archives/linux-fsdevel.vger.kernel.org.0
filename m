Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B61A72D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 07:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405415AbgDNFMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405409AbgDNFMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:12:35 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352DC0A3BE2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 22:12:34 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e5so15348097edq.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 22:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCKH9//GDUVyra9MYbJtXuz/rft75HC1YdEpud3oR/w=;
        b=wDyM6KBFKLlwwTmGUBwUr0f9mEfcZL3MHRC2qD1g8Ri5hzXZNb/yzQj6Pr/ZKsOXDZ
         i8o1+jiGMZA6uHKUntfBZb+bIsOtO7+1LBUceyEI8O/0tAVI4147/8qj5VnTkwYpzp8p
         OQwtvf3E1orMQsMGR1mGI4iaBrR52m55wkk2YuddOwJVzEJip2u4dKD8u1dHNHC44qyf
         0p6BxMnrbJM4Vt58Ih9rpAxyb+KxIbYh8GXtZEX5seabEA+alTbGBBCsUbEbv7tMGQbY
         5acT+NDRcEvCOXYhXjXmABnXdzSRCoer0XRx9DXEbsWcR75NMcPPUrLZjCNRkAkFZcJR
         U5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCKH9//GDUVyra9MYbJtXuz/rft75HC1YdEpud3oR/w=;
        b=KKGqognVYC9iBn42xnX3JnowkfA6p0Xv7ZiXliDfGrE4CIJF92wQdzATfNAsnh3EVV
         p3PSFMtx3CCek/wsdMaIc/+H4wKaD2lClqW6rGPZD94WTuzZ/lTnvBYDSVqKgraDiQrZ
         s2QONwLd2wXcLzrAPL4/C1nO0sGksMXPJm9W78sz3++GI1XpdhKP5kYjziJ+cTXnNNxV
         spZNF81MJU15r3iePKxhAiNk4lLhNnPsLT5Tp/9P12HQH450CXj3YPty8mEtoFm8miFz
         CMPKp3tibQHXaDlZhlFLMkn7HPoc3z45bQgYsquk6GwSguJHm8XOnt49W2NTTbDmUKS5
         PcDg==
X-Gm-Message-State: AGi0PuY/NVwUEAVyV6GFEKfFRTXmmY65GWbGeZRZIfwjr/Lum/Dr4Dqj
        GqNwpdiiGNA3Plr7KbFFx/RKeZsWjej1sLl+NsjCEA==
X-Google-Smtp-Source: APiQypKjvu1zmWD35TkvQGGIPcBAQQsVLki0XXXLdYacZXLIP+W15lBvsYFcPXTdJ4zV8Nr44sratkgYZ4gJIezi0ik=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr18225259ejj.317.1586841153456;
 Mon, 13 Apr 2020 22:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-10-ira.weiny@intel.com>
 <20200413161912.GZ6742@magnolia> <20200414043821.GG1649878@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200414043821.GG1649878@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Apr 2020 22:12:22 -0700
Message-ID: <CAPcyv4hfCnFTRsDv8Kviux7=2teu9Tdyc3HDjNJQpagG-JaM+Q@mail.gmail.com>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
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

On Mon, Apr 13, 2020 at 9:38 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Apr 13, 2020 at 09:19:12AM -0700, Darrick J. Wong wrote:
> > On Sun, Apr 12, 2020 at 10:40:46PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > Update the Usage section to reflect the new individual dax selection
> > > functionality.
> >
> > Yum. :)
> >
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >
> > > ---
> > > Changes from V6:
> > >     Update to allow setting FS_XFLAG_DAX any time.
> > >     Update with list of behaviors from Darrick
> > >     https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> > >
> > > Changes from V5:
> > >     Update to reflect the agreed upon semantics
> > >     https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
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
> >
> > I thought ext2 supports DAX?
>
> Not that I know of?  Does it?

Yes. Seemed like a good idea at the time, but in retrospect...

In fairness I believe this was also an olive branch to XIP users that
were transitioned to DAX, so they did not also need to transition
filesystems.
