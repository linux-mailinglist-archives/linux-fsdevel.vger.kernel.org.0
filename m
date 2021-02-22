Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9232119B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhBVHvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 02:51:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57256 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhBVHvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613981268; x=1645517268;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=I7gEhcAiQWm7xkZhIQBr9647eucFuNKvy/zHo8RnLRo=;
  b=hQgMqqHtAhMmrA0OobAF4asGVIDtVWMdMXf9Fy9OjDSCCcKx9daG3ywt
   RpoGiv/0LugN4Al0BgRyEoVNfP7C/vtEv3f+R9AaIizgnf/P0u+Plr0Ce
   PN/ae4W+kueDh6y32APToLPZrKBPQRvLdDiV+RkmeXpRPAYa5K0ST/leN
   czCIpqjbhgw6jeNDBBTzOrDIAsTppVESShlKNIz4dYXpWt3tOsuc2o3oG
   Hv+dkBc3jzjHeL/bzsGJEHaJZ7DZL73iINCbM9dbbygrMvFCh5TKCHWoi
   VqtUCCVioA4yQJ9Aus+JGuQtc37QKcIJHjZ+FWOGW/vgDCXS50lLG8spr
   A==;
IronPort-SDR: GPxpXauqj8gJHi3DrvqfKiOxXU3M5iVeiNEsUNk3xc5hPZEAVmpW/AXBewh+nLmbphM8U+tD5X
 ETbAtlRJPq08mHPE/AMatVRkvu8//ccu8OipVaByaxb02nc3tOgilWnJDVstQ0gIECuCYx4kKb
 vV3TnhiQcMvPRe/Uem8hH7mLAl7UON2AWF5pnsvu6uI6WlEHiPjsCDyy41dh9hb+ChZbFbFuqF
 pmZBv8CsjOWsOWNuAPJat8g+UqiUQuDwTACJTGu6hFMq5btutgIiQp+nVQLlf+6qS5CXtgzTSo
 K7U=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="264674816"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 16:06:09 +0800
IronPort-SDR: gSeHAdgID6gsgYEE6g76dxDJ7wwtyzMyFRsHStJ4gGbOOnZUaRenQHp3Q/JiGslqMfK9jij66s
 WkdXwbiMiE5p+RywsvzM3NNYP/wDft+zsJXnha1C8Gk9c/VJ4wqTYzcV0pu58mKi3WWX0XXPFp
 8S4xnpc/6NcbrnSococFXvL4ig9e/vzS5AjfQ8D2kTyIK71VFqAeoLqcLpx+2Z3wM1ZTour/qf
 SasIhfzxU/0NNmNY/ERboq792goLW86DSvxTdcnvhy4lE74trjadMUNkvGq6QPoCbbRXBsGhTS
 VR3MwjRhQmKFIVKsNg8N7TV9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 23:32:18 -0800
IronPort-SDR: JgH3gSVH9lcWxXlRg/QoEkPWSzxowDWQDBAxglfcg3jgnnQkOP7rpl26GfmdcKpZM0EFNvhwbg
 xQZU2ZTLnMa3VnICajT3GvQpv+p36WFDvYQgRNPg10mPYCOXh3J1Qgeru8rPlLqNek+pEMFeYu
 EcJOY6WTci4l718OnV4Uv2zc14RaSnk9AJFX/lxF32kTudTXqG+10GdbKEFjQv/8iuNX1P+j+y
 uvJ9oMoKDXpgHbqu5ZyZw9dldHJpBKHelUIbkOe+q/cJw+tWEVi3aWST1Z7Q1+NH6P55hyKlwp
 ICI=
WDCIronportException: Internal
Received: from cnf009945.ad.shared (HELO naota-xeon) ([10.225.62.190])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 23:50:45 -0800
Date:   Mon, 22 Feb 2021 16:50:43 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Message-ID: <20210222075043.3g7watpx5gedguaj@naota-xeon>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211151901.GD1993@twin.jikos.cz>
 <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211154627.GE1993@twin.jikos.cz>
 <SN4PR0401MB359821DC2BBF171C946142D09B889@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210216043247.cjxybi7dudpgvvyg@naota-xeon>
 <20210216114611.GM1993@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216114611.GM1993@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:46:11PM +0100, David Sterba wrote:
> On Tue, Feb 16, 2021 at 01:33:28PM +0900, Naohiro Aota wrote:
> > On Mon, Feb 15, 2021 at 04:58:05PM +0000, Johannes Thumshirn wrote:
> > > On 11/02/2021 16:48, David Sterba wrote:
> > > > On Thu, Feb 11, 2021 at 03:26:04PM +0000, Johannes Thumshirn wrote:
> > > >> On 11/02/2021 16:21, David Sterba wrote:
> > > >>> On Thu, Feb 11, 2021 at 09:58:09AM +0000, Johannes Thumshirn wrote:
> > > >>>> On 10/02/2021 21:02, David Sterba wrote:
> > > >>>>>> This series implements superblock log writing. It uses two zones as a
> > > >>>>>> circular buffer to write updated superblocks. Once the first zone is filled
> > > >>>>>> up, start writing into the second zone. The first zone will be reset once
> > > >>>>>> both zones are filled. We can determine the postion of the latest
> > > >>>>>> superblock by reading the write pointer information from a device.
> > > >>>>>
> > > >>>>> About that, in this patchset it's still leaving superblock at the fixed
> > > >>>>> zone number while we want it at a fixed location, spanning 2 zones
> > > >>>>> regardless of their size.
> > > >>>>
> > > >>>> We'll always need 2 zones or otherwise we won't be powercut safe.
> > > >>>
> > > >>> Yes we do, that hasn't changed.
> > > >>
> > > >> OK that I don't understand, with the log structured superblocks on a zoned
> > > >> filesystem, we're writing a new superblock until the 1st zone is filled.
> > > >> Then we advance to the second zone. As soon as we wrote a superblock to
> > > >> the second zone we can reset the first.
> > > >> If we only use one zone,
> > > > 
> > > > No, that can't work and nobody suggests that.
> > > > 
> > > >> we would need to write until it's end, reset and
> > > >> start writing again from the beginning. But if a powercut happens between
> > > >> reset and first write after the reset, we end up with no superblock.
> > > > 
> > > > What I'm saying and what we discussed on slack in December, we can't fix
> > > > the zone number for the 1st and 2nd copy of superblock like it is now in
> > > > sb_zone_number.
> > > > 
> > > > The primary superblock must be there for any reference and to actually
> > > > let the tools learn about the incompat bits.
> > > > 
> > > > The 1st copy is now fixed zone 16, which depends on the zone size. The
> > > > idea is to define the superblock offsets to start at given offsets,
> > > > where the ring buffer has the two consecutive zones, regardless of their
> > > > size.
> > > > 
> > > > primary:		   0
> > > > 1st copy:		 16G
> > > > 2nd copy:		256G
> > > > 
> > > > Due to the variability of the zones in future devices, we'll reserve a
> > > > space at the superblock interval, assuming the zone sizes can grow up to
> > > > several gigabytes. Current working number is 1G, with some safety margin
> > > > the reserved ranges would be (eg. for a 4G zone size):
> > > > 
> > > > primary:		0 up to 8G
> > > > 1st copy:		16G up to 24G
> > > > 2nd copy:		256G up to 262G
> > > > 
> > > > It is wasteful but we want to be future proof and expecting disk sizes
> > > > from tens of terabytes to a hundred terabytes, it's not significant
> > > > loss of space.
> > > > 
> > > > If the zone sizes can be expected higher than 4G, the 1st copy can be
> > > > defined at 64G, that would leave us some margin until somebody thinks
> > > > that 32G zones are a great idea.
> > > > 
> > > 
> > > We've been talking about this today and our proposal would be as follows:
> > > Primary SB is two zones starting at LBA 0
> > > Seconday SB the two zones starting with the zone that contains the address 16G
> > 
> > For the secondary SB on a file system < 16GB, how do you think of
> > using the last two zones (or zones #2, #3 will do)? Then, we can
> > assure to have two SB copies even on such a file system.
> 
> For real hardware I think this is not relevant but for the emulated mode
> we need to deal with that case. The reserved size is wasteful and this
> will become noticeable for devices < 16G but I'd rather keep the logic
> simple and not care much about this corner case. So, the superblock
> range would be reserved and if there's not enough to store the secondary
> sb, then don't.

Sure. That works. I'm running xfstests with these new SB
locations. Once it passed, I'll post the patch.

One corner case left. What should we do with zone size > 8G? In this
case, the primary SB zones and the 1st copy SB zones overlap. I know
this is unrealistic for real hardware, but you can still create such a
device with null_blk.

1) Use the following zones (zones #2, #3) as the primary SB zones
2) Do not write the primary SBs
3) Reject to mkfs

To be simple logic, method #3 would be appropriate here?

Technically, all the log zones overlap with zone size > 128 GB. I'm
considering to reject to mkfs in this insane case anyway.
