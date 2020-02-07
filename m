Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D656155363
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGH7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 02:59:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28832 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGH7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581062344; x=1612598344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kRGU8VDfii+JwOMDIHg0U7aPmqCXdOJdsX6jlCMGZKg=;
  b=J+ADxy09aqILcqWg0DF18/o2caDFaPcqX/6TsW3h+ix/iYqrkqdt1CzC
   kJ71o50zKwaRJqQxeMM4Tm+YsBHghTPNuRLHS+eVykePNkYESZUGndbyg
   GiaJJgGa7NJim3SORilNyIKb+QerWpc6R5tMc8LmsgRRROyaHnbNKs3+U
   tQVpQwXb95Q6JGL4iVak3qyVptVeg80UybZGb4MyvQ+RCYpgwXiBQwrao
   FrOhkvgINLf6O66pFKStajNfexFW+oLwz8ZOHcad7NXotM3YWE5CRcGSS
   Wj72fY37ZENDlUQ5rr4VCLfiOjnpN5Ak5r1+ecOCQPjHy+dFJOdffbSfA
   g==;
IronPort-SDR: xtF/2JEEBNmmrhKeizytPeWggeoYJbVxUKgUwfsxGPeUNDB9mG4wxVY8W5N0MbmZwFFYyrvaVw
 uTmuCfnBbkKn3JWtZH6hSZ+DaXnIiBVVaZt2dpRVmS/MiNP/nleM7caahAziyTZW9ka9AU40a9
 dwAeVpBv5uQ5FCSx1J/kHWb2XVYGQscgCwBD635zvpllDvahbe2SJf5o/u9xQ4WD4ZW4CHvCzD
 tMVsWQ469dcVW4q9j4DhgNjQPiLU8H7f3XcU9JNQxhLU8g/ErqCyZ2OfIcaWOurF6FF8mm0sXp
 z38=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="129334777"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:59:03 +0800
IronPort-SDR: uUbad4o7tPZf4AnTeXVX/aEIGsvnS1Dx2wLyIArXI6oWD453vUJJuMJbNNewMpc04z/GrdW5XV
 6N3AWTW44FKAzEElNjt68vamdE+vmssdQnrqsqp6xnFnkWEF8NZj5ZckRqDDjSlNtURarccin2
 eUcTBR6e/owXEVl+AuashGYQhDmutV6ZqF8P7bLWLtYgHcp7U1bT3g9+f+sw8UX4+kDXhT7NDg
 gBj62rxJRO4rUVSNnWS7Y14LaDHgRiB251aHpGTOWAWWM4Qxa3BRNNsrQE9sSvo2rSNvMJ3/QY
 8U2Ee1yBuCDpp3v9VKMHCA9/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:52:02 -0800
IronPort-SDR: pmFc+8G2YkTT5xTAgGqME1mLV/BSAHegChGzvtWFnkV+rlhwWwwYfMniHEWvtOkLjpFP+z1R3v
 bgWIqujCWx4dlJBrNPGhxxZWA7IiZ+6J3QiT86Gy+/WYZz1RaCAn0ENSgdlwsuMOMdXZ3fiVxZ
 HZXI2J4c6mDsb0p+UgcoXGSNFp6f4nPfm2+lfR4XGAVHHFH8BwHrC85gOXXNxH1mxGKtPzoBRV
 xsXZ/b1QO2nxGvg8kCkCJHqOAZEksZ4yKJtFZnvxUuB53z+fnTvWyeDj+Yep4xgZJ424+fwZ6c
 nb4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 06 Feb 2020 23:59:02 -0800
Received: (nullmailer pid 856616 invoked by uid 1000);
        Fri, 07 Feb 2020 07:59:01 -0000
Date:   Fri, 7 Feb 2020 16:59:01 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: factor out set_parameters()
Message-ID: <20200207075901.o4lfuf3txharr4co@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-6-naohiro.aota@wdc.com>
 <82286a4a-0688-2ada-b245-abdb998147c4@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <82286a4a-0688-2ada-b245-abdb998147c4@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:40:37AM -0500, Josef Bacik wrote:
>On 2/6/20 5:41 AM, Naohiro Aota wrote:
>>Factor out set_parameters() from __btrfs_alloc_chunk(). This function
>>initialises parameters of "struct alloc_chunk_ctl" for allocation.
>>set_parameters() handles a common part of the initialisation to load the
>>RAID parameters from btrfs_raid_array. set_parameters_regular() decides
>>some parameters for its allocation.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/volumes.c | 96 ++++++++++++++++++++++++++++------------------
>>  1 file changed, 59 insertions(+), 37 deletions(-)
>>
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index cfde302bf297..a5d6f0b5ca70 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -4841,6 +4841,60 @@ struct alloc_chunk_ctl {
>>  	int ndevs;
>>  };
>>+static void set_parameters_regular(struct btrfs_fs_devices *fs_devices,
>>+				   struct alloc_chunk_ctl *ctl)
>
>init_alloc_chunk_ctl_policy_regular()
>
>>+{
>>+	u64 type = ctl->type;
>>+
>>+	if (type & BTRFS_BLOCK_GROUP_DATA) {
>>+		ctl->max_stripe_size = SZ_1G;
>>+		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
>>+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
>>+		/* for larger filesystems, use larger metadata chunks */
>>+		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
>>+			ctl->max_stripe_size = SZ_1G;
>>+		else
>>+			ctl->max_stripe_size = SZ_256M;
>>+		ctl->max_chunk_size = ctl->max_stripe_size;
>>+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
>>+		ctl->max_stripe_size = SZ_32M;
>>+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
>>+		ctl->devs_max = min_t(int, ctl->devs_max,
>>+				      BTRFS_MAX_DEVS_SYS_CHUNK);
>>+	} else {
>>+		BUG();
>>+	}
>>+
>>+	/* We don't want a chunk larger than 10% of writable space */
>>+	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>>+				  ctl->max_chunk_size);
>>+}
>>+
>>+static void set_parameters(struct btrfs_fs_devices *fs_devices,
>>+			   struct alloc_chunk_ctl *ctl)
>
>init_alloc_chunk_ctl().  These function names need to be more descriptive.  Thanks,

I see. I renamed these two.

Thanks,
