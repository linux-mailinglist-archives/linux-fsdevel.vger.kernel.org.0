Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30631C604
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBPEen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:34:43 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18990 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBPEek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613450078; x=1644986078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1K4xJHKJbxOw8JJXH43P+hiIJxJ9J1wR1J29SGZvUbk=;
  b=L/9cHcC83E/ku9pkBMb33HFWfYIR5ss81E9FXJMXfGVGY0yD+/Wi9Jye
   mIxTX6PIpxFTGNGRmzRlDGfjmVlOO+8DEtgc2N6UMjul22FJh7DCWKAtL
   5cW7LIxPzX2azT1ebqb9H7sBdN4CEfunIfNz1XtFFCev7tJh/bk336xHy
   Cl7XL9npfDQIg89JDqfrjFEp3+0TUu3zxnXEQlov4YephR14pVLP1mHG7
   XwiPvHO7TKoAWsitiG33fjNQH4o+pkylWf++4jD5RtUKUpVigLM/maPql
   qUSNv+M5qlVDVXXYBAQf3YOQqJB3iFcqMx94kYA+oYRnYzHH3IxdlVnee
   Q==;
IronPort-SDR: 7zpyXWbsu0vSk9dMBXpjuMztD6BFz1L8Qt1mas/QilViYdLO3/2BFbZcZ8NC8pGcwmbJXEkZ5V
 qWpJDxN7h/YZPaP4rWKaKjwPsAwG65bbaQv4qcMN90PtH2e5RotdBAYBFnci1qgeYTRr9KBcu6
 LOvUgSNWGg0PJuDqXRaQ+bfJoOOdhTnoQIXlYgq5TDuhg+bCIOQkDZPPaUlsfe5a819kaTx9zE
 ylLynrv0FQbhcGj8ADIwBUZ8OCMFadmX+U6obDSpUyqH6FHl+7pvd6UQyw/SGaEhS3ozLyUQX2
 iXY=
X-IronPort-AV: E=Sophos;i="5.81,182,1610380800"; 
   d="scan'208";a="160021452"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2021 12:33:31 +0800
IronPort-SDR: 9MGgAfLFq1S1fd8l0PLq1uBl7cGoIkXjvMIYoYLA9f8rzY1fOPKqDUWqRy2CgjAyXd8kFhcBgd
 FVKyaFWXZ6+/0tbRkP7gzdSVazu9oRgawrsSVkqVp+gZIMOIxmOY8DYcsIegx+XzVt1nSDkwMy
 HZgYje1p+KT9yRInY7e99k3r30DroxVdhlyWHTzzzPNChzzaOa1gn43dnX0PhLn5lZKf4eLM3m
 cnJ7iBVZE2GxjN/R9rZLOHJGVWZT9xgAcSOy6xPR8QnobHPpMGlKkqayxEhzUxDd3h9NlHCxZu
 F8bJmBBwkYGsKD/vBP1cv7l3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 20:15:17 -0800
IronPort-SDR: 3WSYAwqBN/bNVr7gcSYt8DAUWiYNbRELWIc0HJdZlNjZGoWbLDxA1Z/SIp6sRLDNB0TFdq3yF1
 mFQyhvzE1AXpaDHHtGjPyM745azWgyfSLNEpR1cKeecnd1Sn0b6DBDuzfhqi4vJDXZJxM5dfGJ
 s0zHWcYsaTmPkzRfJy9udtwMebwStai2hSEu/sAQWapd09j3q1pM/56j+Y7nrOzzNr0CwCcxNm
 +56eeZV/zvqoOKz6J+wt6L/aGq95C1IvvnG+u732vWfpRZHlPxlx5foGFhiO9m5VRF9WPoYNmm
 SFg=
WDCIronportException: Internal
Received: from c3zwqf2.ad.shared (HELO naota-xeon) ([10.84.71.92])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 20:33:30 -0800
Date:   Tue, 16 Feb 2021 13:33:28 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Message-ID: <20210216043247.cjxybi7dudpgvvyg@naota-xeon>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211151901.GD1993@twin.jikos.cz>
 <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211154627.GE1993@twin.jikos.cz>
 <SN4PR0401MB359821DC2BBF171C946142D09B889@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359821DC2BBF171C946142D09B889@SN4PR0401MB3598.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 04:58:05PM +0000, Johannes Thumshirn wrote:
> On 11/02/2021 16:48, David Sterba wrote:
> > On Thu, Feb 11, 2021 at 03:26:04PM +0000, Johannes Thumshirn wrote:
> >> On 11/02/2021 16:21, David Sterba wrote:
> >>> On Thu, Feb 11, 2021 at 09:58:09AM +0000, Johannes Thumshirn wrote:
> >>>> On 10/02/2021 21:02, David Sterba wrote:
> >>>>>> This series implements superblock log writing. It uses two zones as a
> >>>>>> circular buffer to write updated superblocks. Once the first zone is filled
> >>>>>> up, start writing into the second zone. The first zone will be reset once
> >>>>>> both zones are filled. We can determine the postion of the latest
> >>>>>> superblock by reading the write pointer information from a device.
> >>>>>
> >>>>> About that, in this patchset it's still leaving superblock at the fixed
> >>>>> zone number while we want it at a fixed location, spanning 2 zones
> >>>>> regardless of their size.
> >>>>
> >>>> We'll always need 2 zones or otherwise we won't be powercut safe.
> >>>
> >>> Yes we do, that hasn't changed.
> >>
> >> OK that I don't understand, with the log structured superblocks on a zoned
> >> filesystem, we're writing a new superblock until the 1st zone is filled.
> >> Then we advance to the second zone. As soon as we wrote a superblock to
> >> the second zone we can reset the first.
> >> If we only use one zone,
> > 
> > No, that can't work and nobody suggests that.
> > 
> >> we would need to write until it's end, reset and
> >> start writing again from the beginning. But if a powercut happens between
> >> reset and first write after the reset, we end up with no superblock.
> > 
> > What I'm saying and what we discussed on slack in December, we can't fix
> > the zone number for the 1st and 2nd copy of superblock like it is now in
> > sb_zone_number.
> > 
> > The primary superblock must be there for any reference and to actually
> > let the tools learn about the incompat bits.
> > 
> > The 1st copy is now fixed zone 16, which depends on the zone size. The
> > idea is to define the superblock offsets to start at given offsets,
> > where the ring buffer has the two consecutive zones, regardless of their
> > size.
> > 
> > primary:		   0
> > 1st copy:		 16G
> > 2nd copy:		256G
> > 
> > Due to the variability of the zones in future devices, we'll reserve a
> > space at the superblock interval, assuming the zone sizes can grow up to
> > several gigabytes. Current working number is 1G, with some safety margin
> > the reserved ranges would be (eg. for a 4G zone size):
> > 
> > primary:		0 up to 8G
> > 1st copy:		16G up to 24G
> > 2nd copy:		256G up to 262G
> > 
> > It is wasteful but we want to be future proof and expecting disk sizes
> > from tens of terabytes to a hundred terabytes, it's not significant
> > loss of space.
> > 
> > If the zone sizes can be expected higher than 4G, the 1st copy can be
> > defined at 64G, that would leave us some margin until somebody thinks
> > that 32G zones are a great idea.
> > 
> 
> We've been talking about this today and our proposal would be as follows:
> Primary SB is two zones starting at LBA 0
> Seconday SB the two zones starting with the zone that contains the address 16G

For the secondary SB on a file system < 16GB, how do you think of
using the last two zones (or zones #2, #3 will do)? Then, we can
assure to have two SB copies even on such a file system.

> Third SB the two zones starting with the zone that contains the address 256G 
> or not present if the disk is too small.
> 
> This would make it safe until a zone size of 8GB and we'd have adjacent 
> superblock log zones then.
> 
> How does that sound?
> 
> Byte,
> 	Johannes
> 
