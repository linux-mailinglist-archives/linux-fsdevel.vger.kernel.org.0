Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE953154386
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBFLwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 06:52:37 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:39463 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbgBFLwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:52:37 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 06:52:37 EST
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 04959AC2B6;
        Thu,  6 Feb 2020 12:43:30 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/20] btrfs: refactor and generalize chunk/dev_extent/extent allocation
Date:   Thu, 06 Feb 2020 12:43:30 +0100
Message-ID: <5861600.kR87CiLkK2@merkaba>
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Naohiro.

Naohiro Aota - 06.02.20, 11:41:54 CET:
> This series refactors chunk allocation, device_extent allocation and
> extent allocation functions and make them generalized to be able to
> implement other allocation policy easily.
> 
> On top of this series, we can simplify some part of the "btrfs: zoned
> block device support" series as adding a new type of chunk allocator
> and extent allocator for zoned block devices. Furthermore, we will be
> able to implement and test some other allocator in the idea page of
> the wiki e.g. SSD caching, dedicated metadata drive, chunk allocation
> groups, and so on.

Regarding SSD caching, are you aware that there has been previous work 
with even involved handling part of it in the Virtual Filesystem Switch 
(VFS)?

VFS hot-data tracking, LWN article:

https://lwn.net/Articles/525651/

Patchset, not sure whether it is the most recent one:

[PATCH v2 00/12] VFS hot tracking

https://lore.kernel.org/linux-btrfs/1368493184-5939-1-git-send-email-zwu.kernel@gmail.com/

So for SSD caching you may be able to re-use or pick up some of this 
work, unless it would be unsuitable to be used with this new approach.

Thanks,
-- 
Martin


