Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F271A15536D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 09:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgBGIDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 03:03:03 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:56173 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgBGIDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:03:03 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id CBE58AC879;
        Fri,  7 Feb 2020 09:03:00 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/20] btrfs: refactor and generalize chunk/dev_extent/extent allocation
Date:   Fri, 07 Feb 2020 09:02:59 +0100
Message-ID: <1977483.1kS9YxoVVV@merkaba>
In-Reply-To: <20200207060600.bxcot22i3tpemrn5@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com> <5861600.kR87CiLkK2@merkaba> <20200207060600.bxcot22i3tpemrn5@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Naohiro Aota - 07.02.20, 07:06:00 CET:
> On Thu, Feb 06, 2020 at 12:43:30PM +0100, Martin Steigerwald wrote:
> >Hi Naohiro.
> >
> >Naohiro Aota - 06.02.20, 11:41:54 CET:
> >> This series refactors chunk allocation, device_extent allocation
> >> and
> >> extent allocation functions and make them generalized to be able to
> >> implement other allocation policy easily.
> >> 
> >> On top of this series, we can simplify some part of the "btrfs:
> >> zoned
> >> block device support" series as adding a new type of chunk
> >> allocator
> >> and extent allocator for zoned block devices. Furthermore, we will
> >> be
> >> able to implement and test some other allocator in the idea page of
> >> the wiki e.g. SSD caching, dedicated metadata drive, chunk
> >> allocation
> >> groups, and so on.
> >
> >Regarding SSD caching, are you aware that there has been previous
> >work with even involved handling part of it in the Virtual
> >Filesystem Switch (VFS)?
> >
> >VFS hot-data tracking, LWN article:
> >
> >https://lwn.net/Articles/525651/
> >
> >Patchset, not sure whether it is the most recent one:
> >
> >[PATCH v2 00/12] VFS hot tracking
> >
> >https://lore.kernel.org/linux-btrfs/1368493184-5939-1-git-send-email-> >zwu.kernel@gmail.com/
> Yes, I once saw the patchset. Not sure about the detail, though.
> 
> >So for SSD caching you may be able to re-use or pick up some of this
> >work, unless it would be unsuitable to be used with this new
> >approach.
> Currently, I have no plan to implement the SSD caching feature by
> myself. I think some patches of the series like this [1] can be
> reworked on my series as adding an "SSD caching chunk allocator." So,
> it's welcome to hear suggestions about the hook interface.

Thank you. Adding Zhi Yong Wu to Cc.

I don't know details about this patch set either.

@Zhi Yong Wu: Are you interested interested in rebasing your SSD caching 
patch above this refactoring work?

Ciao,
Martin

> [1]
> https://lore.kernel.org/linux-btrfs/1371817260-8615-3-git-send-email-> zwu.kernel@gmail.com/
> >Thanks,


-- 
Martin


