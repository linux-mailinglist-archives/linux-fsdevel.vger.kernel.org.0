Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100F6123E56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 05:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLRERh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 23:17:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15334 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRERh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576642656; x=1608178656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vs4WqmcL5Uihup/VUIgBJGix0fbS4voLeckQDX/LB/c=;
  b=IpclZv/BIyHXZCAAQcOrk7NOz3lf0ZLy0eCaF0J8jAq+kmSKVBSpB0Oa
   dExWahNKwcfQMlzbrOMak9S16syP22L5wUlAeNk/YE6dpSI9bqBP/Rm1X
   o1t4GkPqgtVdtNpVt9xlJ5sE4loRlskpvrOBxPoYahC/bfYEXElU7sPhQ
   m0waWcI4GRhr+WpsiMAVCW/4ZKTsyOfslRUHmhBZbbYGHaQHiAQi8BMmC
   +bBf6rHCfCN2YwRImgDFLQk8GOQJl/ialjAl1xvWF64OCOUvMKLlxOn6y
   xUFzJU5l2ie32bi0gWLwjD7IW5mFQZlm+IkqEfaRQbtcLIrwyMgYcJq7u
   w==;
IronPort-SDR: rWILF8j/GjwjuCFx4RNMmSBBCB749blrszc9/ibvoyeki7UVVyh/iGkuN0Oh/NwZWN/ldgh8ZD
 glzISLJ/pcqzFUqoc/9lcqBLwJxK/mg2FDeTee4XTHCaXBxnxIJTY7BIwh10QNxBxyY0sUiMdE
 +WBnSEdIBCpt7SEAQojrqZ8ig4Ei6yJ8PLrIFSXjIe0Yiz8inHGFmStsRYKgkH6A73cQqp4hQ+
 Wh1JCg+GpoFO6nUIUnmVp1jKrHlVIZb+2q8oMDF1N+Hd5MOZcpLs+E+j3y/8BpieyFthnsqJHS
 4Ek=
X-IronPort-AV: E=Sophos;i="5.69,328,1571673600"; 
   d="scan'208";a="125597858"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 12:17:36 +0800
IronPort-SDR: qKV2f/r/FSbTIxejY8UAr1K3BJxwR+HZIuIlWDzgeGZsa3VyApyxWz/CY89kVZXy6ueAdT7R8z
 ctHnO9Zh7cbOQYKUhdAIPVSh8Y31ICZwRmrQm/avxI7re/sPIS1VQFXOVXe6rWXXBYPWrkCRBh
 Vcsr6q+SY9fC9B4aS5X6vNsDeFglTGDsaV5FZl8LaZmy42PzYXfEWzXmPYTOhWL0xYqg1P08uU
 j0mG6vWnDnHXYz/IsS6hm3fKj0kgtiQHbwwRh1lbN1l/cbN0B4sXvnoxF/B/AoW1BBiTkcD551
 vzAbmJjjTlid6D0FhV+nmmid
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 20:11:38 -0800
IronPort-SDR: r/8IHBdUtilN0Eoe17yg4/m8Y7Fhdcak9Pv04B/mYaVD4NS8Jeowg+oD8DG7Zr4H3sc6BSZmRO
 T7bSzPuhtDsAcwnfJAOSWTNu7K+22mu6p+S1Ds5fhpKuPapoMAOExWKNNugfYniRAxdUzt0Yq/
 MKkIQtXPKuPHCnTTZp7GZOIZYLBKeMn7B4rGwESPWuMg/IhGT1AZK8Ug6ba9HGd5Y/53A2Rj1m
 cUvaIeOhVWcY3i6Lu/NCYMR/4yZxQdhucNLySobZXiFvnChnpDTdVJldeaMJ98Va1Wkwk6gSWf
 Xio=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 17 Dec 2019 20:17:35 -0800
Received: (nullmailer pid 715618 invoked by uid 1000);
        Wed, 18 Dec 2019 04:17:34 -0000
Date:   Wed, 18 Dec 2019 13:17:34 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/28] btrfs: Check and enable HMZONED mode
Message-ID: <20191218041734.beb6z3juswbs5sc6@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-4-naohiro.aota@wdc.com>
 <a51f1292-3097-cd4b-bee5-dee5d4141ffb@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a51f1292-3097-cd4b-bee5-dee5d4141ffb@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:21:07AM -0500, Josef Bacik wrote:
>On 12/12/19 11:08 PM, Naohiro Aota wrote:
>>HMZONED mode cannot be used together with the RAID5/6 profile for now.
>>Introduce the function btrfs_check_hmzoned_mode() to check this. This
>>function will also check if HMZONED flag is enabled on the file system and
>>if the file system consists of zoned devices with equal zone size.
>>
>>Additionally, as updates to the space cache are in-place, the space cache
>>cannot be located over sequential zones and there is no guarantees that the
>>device will have enough conventional zones to store this cache. Resolve
>>this problem by completely disabling the space cache.  This does not
>>introduce any problems in HMZONED mode: all the free space is located after
>>the allocation pointer and no free space is located before the pointer.
>>There is no need to have such cache.
>>
>>For the same reason, NODATACOW is also disabled.
>>
>>Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
>>INODE_MAP_CACHE inode.
>>
>>In summary, HMZONED will disable:
>>
>>| Disabled features | Reason                                              |
>>|-------------------+-----------------------------------------------------|
>>| RAID5/6           | 1) Non-full stripe write cause overwriting of       |
>>|                   | parity block                                        |
>>|                   | 2) Rebuilding on high capacity volume (usually with |
>>|                   | SMR) can lead to higher failure rate                |
>>|-------------------+-----------------------------------------------------|
>>| space_cache (v1)  | In-place updating                                   |
>>| NODATACOW         | In-place updating                                   |
>>|-------------------+-----------------------------------------------------|
>>| fallocate         | Reserved extent will be a write hole                |
>>| INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
>>|-------------------+-----------------------------------------------------|
>>| MIXED_BG          | Allocated metadata region will be write holes for   |
>>|                   | data writes                                         |
>>| async checksum    | Not to mix up bios by multiple workers              |
>>
>>Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>I assume the progs will be updated to account for these limitations as well?
>
>Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
>Thanks,
>
>Josef

Oops, while it's errored out from mkfs.btrfs, I forgot to add early
check for RAID56 and MIXED_BG. I'll add the checks in the next series.
