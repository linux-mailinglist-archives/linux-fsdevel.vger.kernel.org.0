Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E62124068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 08:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRHfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 02:35:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2362 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRHfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576654521; x=1608190521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=35lr1IuUSoighFYbyYf9wy3qAzw3B517Y8C6MTrv72A=;
  b=PgwrYWhzlEa4Cg5aw4D1kthSlotooZ8HFw2IMdfmLMwOhPC2V2eCajfq
   13Oiie2REMPgXZ2l2LuG3PSXw9+/Qjs3UWaFuTxvQ2ysl1Dg4KUAg8ery
   upPmg6CYoMIG4R3L/LX7BjwZxkTubmjWYVf1os/sg7kJEsCPVAExCDxHu
   5pfWtuFaJdctl3SwulLj2J8N4PkIL3yMErRM2vXIM9PcddJrTrISygWT4
   1bO87wXqoxZT9wX7/UoeXNCFyo+47hoc+JjcfAAJy4g9X8zr4JzsvKLR4
   OcRmAc8rQLqp43kKGOLn1CfBd2MFvuj8Iz1PnIOdDU5hpSjHBY73bN4MI
   Q==;
IronPort-SDR: tI97PSMbZuZpx/kx02N2dS6ayoV804EF0HnWbFULVe+z7iprWpPtmvPH/Xr2J1aN5aguaY3xxs
 /tIzTK9RROeIIHHNwaT4VBXoiS32iyoaJHkJH70SZldjAqkTT97oCdNIByyd1cU2reOh4bOGv2
 b1ZgrUuhSmoUzLq58MNIGC/FkszCkWFJ4QCmijgkaOINtljbFB1PL+j56FGFWc6c1dh1CAjFiQ
 tvcaavCkCR5yGdEYTsfvZ8RxJ9jZ5krly10HeNWoP4+1Of3HvG08qO5U0F3ooaDVtOY9mY+K+a
 GXI=
X-IronPort-AV: E=Sophos;i="5.69,328,1571673600"; 
   d="scan'208";a="125608552"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 15:35:20 +0800
IronPort-SDR: pu+BCemSQPcBhFxDfgJd3IZLcmcRFunCsYETpeA39LhS3anHggGOW9cHG10NfcNyBYDpj+V9+Q
 lvSiFrKW7JwTtU5g16fruepzhdRA4vBcFivAWyzQpn3EgplEQf7SkxPBLzYMhRoT0o6pQXuZQc
 c0t1zHsyPcSMZpeoEGbsQq2dtz5YAUp9Lj3PpF7fsJdWOb6zMEezVXxtd2MZqDv2GJELz+LiCE
 5fH9OkxSedZ/5R4CL1zo1rjqBjrlfc53XOwWR7TjcNO0dNoSSnI9zifNmRT/qNMqrRU9fbmUvJ
 0RHhH4y12Gx0zXHcSd5yJ6Gy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 23:29:44 -0800
IronPort-SDR: u9LKptzO0Y8d+giAsBSMHWR69XPUIYgsoBozSab28xXQXzW+EB4LcM5YhId7TQOrAWCEUP88q4
 XO1MlVi3bCNIUKr5w0Ybg2Cwrcaijffbb9/0ilBSV1jadXetsOuOMhewqyicx2ojs0ExHDJsvk
 owpSHUjLJUbc8rohUj+nZyX1sUMTSOpVgnvL+oRDdKO41cZg02Ys3/5ZMfFQvnBO6eyjXWAual
 5pqj03ghYHF7K1Kqmq/Qr6rO+IohDJai7ZyWR1SMigMIRweywt/nVZTzdta/Ipek66kZSFlYKn
 KXo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 17 Dec 2019 23:35:19 -0800
Received: (nullmailer pid 964425 invoked by uid 1000);
        Wed, 18 Dec 2019 07:35:18 -0000
Date:   Wed, 18 Dec 2019 16:35:18 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 11/28] btrfs: make unmirroed BGs readonly only if we
 have at least one writable BG
Message-ID: <20191218073518.zqtzfdgz7ctwlicn@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-12-naohiro.aota@wdc.com>
 <78769962-9094-3afc-f791-1b35030c67dc@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <78769962-9094-3afc-f791-1b35030c67dc@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 02:25:37PM -0500, Josef Bacik wrote:
>On 12/12/19 11:08 PM, Naohiro Aota wrote:
>>If the btrfs volume has mirrored block groups, it unconditionally makes
>>un-mirrored block groups read only. When we have mirrored block groups, but
>>don't have writable block groups, this will drop all writable block groups.
>>So, check if we have at least one writable mirrored block group before
>>setting un-mirrored block groups read only.
>>
>>This change is necessary to handle e.g. xfstests btrfs/124 case.
>>
>>When we mount degraded RAID1 FS and write to it, and then re-mount with
>>full device, the write pointers of corresponding zones of written block
>>group differ. We mark such block group as "wp_broken" and make it read
>>only. In this situation, we only have read only RAID1 block groups because
>>of "wp_broken" and un-mirrored block groups are also marked read only,
>>because we have RAID1 block groups. As a result, all the block groups are
>>now read only, so that we cannot even start the rebalance to fix the
>>situation.
>
>I'm not sure I understand.  In degraded mode we're writing to just one 
>mirror of a RAID1 block group, correct?  And this messes up the WP for 
>the broken side, so it gets marked with wp_broken and thus RO.  How 
>does this patch help?  The block groups are still marked RAID1 right?  
>Or are new block groups allocated with SINGLE or RAID0?  I'm confused.  
>Thanks,
>
>Josef

First of all, I found that some recent change (maybe commit
112974d4067b ("btrfs: volumes: Remove ENOSPC-prone
btrfs_can_relocate()")?) solved the issue, so we no longer need patch
11 and 12. So, I will drop these two in the next version.

So, I think you may already have no interest on the answer, but just
for a note... The situation was like this:

* before degrading
   - All block groups are RAID1, working fine.
  
* degraded mount
   - Block groups allocated before degrading are RAID1. Writes goes
     into RAID1 block group and break the write pointer.
   - Newly allocated block groups are SINGLE, since we only have one
     available device.

* mount with the both drive again
   - RAID1 block groups are markd RO because of broken write pointer
   - SINGLE block groups are also marked RO because we have RAID1 block
     groups

and at this point, btrfs was somehow unable to allocate new block
group or to start blancing.
