Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340211408F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAQLbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:31:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40928 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQLbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:31:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so7217634wmi.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 03:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4LeJjBpolNxsPHs8hK9ZG05YNjYvXnMesXroqzLzpJg=;
        b=NXVR1qQdxlaevdrX7YCGFG3X/El1auSIMDnegbcC9oAhGfGVxdT6NYsINMaSjsie99
         Q9N9B4bA2U6xXkJFCJGxWW4YL+w8inWU0Mz4zGG+Y+3a5yVyrppBk5WfDXXA9bHsn8tf
         U11U1Agd22Y58V4uP2R5j0Kfy4+QzWNbc5HLuydk4sk/mEvSfP43hDvqH+1KMZnJeg9e
         3aab8AwXRARgZVUIcJSECr5sxPN00+dRDYcdn3CPvifT0ZeLhUkWrp0XcyFsfqCOgvta
         z2fgAL4iSp3v9MVJXCF46Wzen21utZnUI+X5f3nh/ysLPX7s4VcQ+bn44AOVMPKIL2zw
         37Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4LeJjBpolNxsPHs8hK9ZG05YNjYvXnMesXroqzLzpJg=;
        b=F7/M+K8rvrRZy1GaCMeHDBFpQ8neAoUBqVvK/Q0ZjaeZG/Pm2H51KwNJgrZfJTVE6U
         Jf8B0OYehqx8XjOiRWZwUnBjWEWXp0VSDxGPgEQt+kA0ci9XHF+8LUTQFhWahWtm5jBS
         CG6MjJ0AFPvmcgoqj/QxVyMxvhnO3xbiPBweiC18Hj74KBFH8VkNavDkx1v562wDkfCF
         dyR1I56sPodzPEif9uiHZJEEtRkKklPh5OUKITyx/xwEadZa+89vMXx5n/Sf1WuR9oZu
         fOhoYO74T1KkbAfDzKPRw3pBNb63Els80eJWnjF67V+wcjWWq7Pow/s6N7R6btqJW+Tb
         twEw==
X-Gm-Message-State: APjAAAW+nHOtoaQgYJbq+hvButgiGYI/9hulMEeTmmvfeedXtwd9Ogni
        6UHlkmX3Lj/l2Zch4jjfrZ0=
X-Google-Smtp-Source: APXvYqxN8PMgo/gw49UXNkwTYYR0YafZLdNnKzoirvugPt2ItV5xRgDr2mJSGtWEvZNEC5Kh55wMVQ==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr4025909wmj.31.1579260708593;
        Fri, 17 Jan 2020 03:31:48 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b67sm185571wmc.38.2020.01.17.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:31:47 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:31:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>
Subject: Re: udf: Commit b085fbe2ef7fa (udf: Fix crash during mount) broke
 CD-RW support
Message-ID: <20200117113147.hs4hylolxzej4urh@pali>
References: <20200112144735.hj2emsoy4uwsouxz@pali>
 <20200113114838.GD23642@quack2.suse.cz>
 <20200116154643.wtxtki7bbn5fnmfc@pali>
 <20200117112254.GF17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117112254.GF17141@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 17 January 2020 12:22:54 Jan Kara wrote:
> On Thu 16-01-20 16:46:43, Pali Rohár wrote:
> > On Monday 13 January 2020 12:48:38 Jan Kara wrote:
> > > Hello,
> > > 
> > > On Sun 12-01-20 15:47:35, Pali Rohár wrote:
> > > > Commit b085fbe2ef7fa (udf: Fix crash during mount) introduced check that
> > > > UDF disk with PD_ACCESS_TYPE_REWRITABLE access type would not be able to
> > > > mount in R/W mode. This commit was added in Linux 4.20.
> > > > 
> > > > But most tools which generate UDF filesystem for CD-RW set access type
> > > > to rewritable, so above change basically disallow usage of CD-RW discs
> > > > formatted to UDF in R/W mode.
> > > > 
> > > > Linux's cdrwtool and mkudffs (in all released versions), Windows Nero 6,
> > > > NetBSD's newfs_udf -- all these tools uses rewritable access type for
> > > > CD-RW media.
> > > > 
> > > > In UDF 1.50, 2.00 and 2.01 specification there is no information which
> > > > UDF access type should be used for CD-RW medias.
> > > > 
> > > > In UDF 2.60, section 2.2.14.2 is written:
> > > > 
> > > >     A partition with Access Type 3 (rewritable) shall define a Freed
> > > >     Space Bitmap or a Freed Space Table, see 2.3.3. All other partitions
> > > >     shall not define a Freed Space Bitmap or a Freed Space Table.
> > > > 
> > > >     Rewritable partitions are used on media that require some form of
> > > >     preprocessing before re-writing data (for example legacy MO). Such
> > > >     partitions shall use Access Type 3.
> > > > 
> > > >     Overwritable partitions are used on media that do not require
> > > >     preprocessing before overwriting data (for example: CD-RW, DVD-RW,
> > > >     DVD+RW, DVD-RAM, BD-RE, HD DVD-Rewritable). Such partitions shall
> > > >     use Access Type 4.
> > > > 
> > > > And in 6.14.1 (Properties of CD-MRW and DVD+MRW media and drives) is:
> > > > 
> > > >     The Media Type is Overwritable (partition Access Type 4,
> > > >     overwritable)
> > > > 
> > > > Similar info is in UDF 2.50.
> > > 
> > > Thanks for detailed info. Yes, UDF 2.60 spec is why I've added the check
> > > you mentioned. I was not aware that the phrasing was not there in earlier
> > > versions and frankly even the UDF 2.60 spec is already 15 years old... But
> > > the fact that there are tools creating non-compliant disks certainly
> > > changes the picture :)
> > 
> > I tested also Nero Linux 4 (Nero provides free trial version which is
> > fully working even in 2020) and it creates 1.50 CD-RW discs in the same
> > way with Rewritable partition. Interestingly for 2.50 and 2.60 it does
> > not use Overwritable, but Writeonce (yes, for CD-RW with Spartable).
> > 
> > And because previous UDF specification do not say anything about it, I
> > would not sat that those discs are non-compliant.
> > 
> > Moreover, is there any tool (for Linux or other system) which uses
> > Overwritable partition type for CD-RW discs? All which I tested uses
> > Rewritable.
> 
> No. But CD-RW means that the media needs "erasing" before overwriting so
> using 'Rewritable' partitions there is fine and in the kernel we do want to
> force such mounts read-only because we don't support "erasing", do we?

I guess that this formulation as you wrote is the reason why all
formatting tools decided to use Overwritable type for CD-RW.

But it is not completely truth. You need erase CD-RW before formatting,
not before rewriting blocks on it. And kernel already supports rewriting
one random block on CD-RW media via pktcdvd.ko layer (part of mainline
kernel).

So to mount CD-RW media with UDF fs on it in R/W mode, you need:

1) erase & format CD-RW media (e.g. via cdrwtool)
2) setup pktcdvd layer for CD-RW media (e.g. via pktsetup or via /sys)
3) mount pktcdvd block device with udf fs

So, kernel supports UDF on CD-RW media also in R/W mode, just it is not
straightforward as for other hard disk block devices.

> > > > So I think that UDF 2.60 is clear that for CD-RW medias (formatted in
> > > > normal or MRW mode) should be used Overwritable access type. But all
> > > > mentioned tools were probably written prior to existence of UDF 2.60
> > > > specifications, probably targeting only UDF 1.50 versions at that time.
> > > > 
> > > > I checked that they use Unallocated Space Bitmap (and not Freed Space
> > > > Bitmap), so writing to these filesystems should not be a problem.
> > > > 
> > > > How to handle this situation? UDF 2.01 nor 1.50 does not say anything
> > > > for access type on CD-RW and there are already tools which generates UDF
> > > > 1.50 images which does not matches UDF 2.60 requirements.
> > > > 
> > > > I think that the best would be to relax restrictions added in commit
> > > > b085fbe2ef7fa to allow mounting mounting udf fs with rewritable access
> > > > type in R/W mode if Freed Space Bitmap/Table is not used.
> > > > 
> > > > I'm really not sure if existing udf implementations take CD-RW media
> > > > with overwritable media type. E.g. prehistoric wrudf tool refuse to work
> > > > with optical discs which have overwritable access type. I supports only
> > > > UDF 1.50.
> > > 
> > > Yeah, we should maintain compatibility with older tools where sanely
> > > possible. So I agree with what you propose. Allow writing to
> > > PD_ACCESS_TYPE_REWRITABLE disks if they don't use 'Freed Space
> > > Bitmap/Table'. Will you send a patch or should I do the update?
> > 
> > Could you do it, please?
> 
> Sure, attached.
> 
> > Also question is, what with those 2.50 CD-RW Writonce partitions and
> > with Spartable which creates Nero Linux?
> 
> Well, we force them read-only and that's what we should do because we don't
> support CD-RW in the kernel... But I may be missing something.

We support CD-RW in kernel, but now I realized that we do not support
UDF 2.50 in R/W mode. So this should be OK for now (until UDF 2.50 R/W
mode is implemented).

-- 
Pali Rohár
pali.rohar@gmail.com
