Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36B195675
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 07:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfHTFHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 01:07:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24738 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbfHTFHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 01:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566277660; x=1597813660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fl8BLF18hm58lWYLu4Ls1heitlaJ27vCTrR3jcNlaHs=;
  b=UJiHQFTu/c9Yg863aVkzxe8O0iWRaur2agyIMgOSumtjqOlSzBF5/8On
   fUtPS9Cq2qdXVA8dHTznZxIPDJaS6hfJiCIlscp4h66ulK69j5vy9AVFg
   n9NFa3NSeBA5v6bgbrQ0ykOFBv5Uspo52rIWxfZ8PquNE2E6LF3crtmuh
   XRsHfTHLMirNV3IHsu/EpKlz5cfb+YXY70kUzhbQxvYTTnRlw95kaP2CG
   qcJKgMos+2Jh7pvym/6mpNHPxnxyzTwTySTK9SSfKUGxrilfxpTHIwhku
   d4DBXJvrQtLg+APY6Xor8M9drOPYcMwiQ6lJdd9qF3UddfDrBIO6tk+X+
   w==;
IronPort-SDR: phjFc4own2sYnUD7KNrBxEoMGYaQJPqlPvqYgz0Q4Me6KcJvPtIt4ly9vR05vfuqEwL9I8kECu
 jyTsejwmgw25pBgc8YTjmqXu1f7iME1SpEXO5rYxD435l4EAUzMeE4Upj/FJoUwi8egLy80uXh
 Xk0eVJqPMs+PcHRTDX/N675zlSrVPP8zZHNIYH8j1sRKikAlWBH6UmAivgJtVkqWxaSukJOpEK
 J5TVpFOaQ2fYeUUK50fS0PUS7tvy7/Z5WtjrNSv7biIlfcqR9iAG21NyuRw6H4GCe45isFdnxE
 WFE=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117137003"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 13:07:40 +0800
IronPort-SDR: t/DaqTsA2a8PmhuI/lO/UfCpjRfTb3QddGAGs+sKX6KtrcUbYFlyp7rHKsU+mr1ir2y6Mkup0E
 KKgtGOUQJg31SyUte2BUstzSSMPdCtnXi+92f0kakQHoS+HFzvBqx8qqUm9CFC8js+TLS9Vfid
 +ZBhy9lF+FHSKNPCg/TBQ7ju31A6U6uUNc/+Xs6CO6A6I6uioUrnMfPAny8Js6GuV1bCPSNTxf
 YJnvKQlq6+i9TqbwcQNHW2ThDDCbRSpy4xT7BtpfytNHYPXHOxnCuwnootrAB9FmbOc7J60+8q
 X3KaaiqmJBFIG+S3aHvTPHfA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 22:05:02 -0700
IronPort-SDR: zjBaAsyLYEpztGAsSYq97eqrEj2pj0dwX9CaAa1dI5CzY/bpd/VNRcxAaREbCA/iYKFgIeiotC
 GLB8LG0RR80dMDJwY2D9EbZdBpjgaFp62kPodQ3+r5j3ATbxF/3qMCnSA6+C6J72QUjvp/guwj
 pNgN6GCsLQ5RK2dhfB9Gnz5LbXjVIEDZ1OhnLkyiTTP12jSJQaABBCIP5h4N7Xz5CJsFiMkSMD
 3MrQFXhVYbfpUoqduDN8E/tfjjPwb7IJ28e9JAOhC5WcFsjNOMbRmtXlCjV+c6d+pYz2UlRIgT
 z3k=
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 19 Aug 2019 22:07:37 -0700
Received: (nullmailer pid 1583429 invoked by uid 1000);
        Tue, 20 Aug 2019 05:07:37 -0000
Date:   Tue, 20 Aug 2019 14:07:37 +0900
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Message-ID: <20190820050737.ngyaamjkdmzvhlqj@naota.dhcp.fujisawa.hgst.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-4-naohiro.aota@wdc.com>
 <edcb46f5-1c3e-0b69-a2d9-66164e64b07e@oracle.com>
 <BYAPR04MB5816FCD8F3A0330C8B3DC609E7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <86ef7944-0029-3d61-0ae3-874015726751@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86ef7944-0029-3d61-0ae3-874015726751@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 17, 2019 at 07:56:50AM +0800, Anand Jain wrote:
>
>
>On 8/16/19 10:23 PM, Damien Le Moal wrote:
>>On 2019/08/15 22:46, Anand Jain wrote:
>>>On 8/8/19 5:30 PM, Naohiro Aota wrote:
>>>>HMZONED mode cannot be used together with the RAID5/6 profile for now.
>>>>Introduce the function btrfs_check_hmzoned_mode() to check this. This
>>>>function will also check if HMZONED flag is enabled on the file system and
>>>>if the file system consists of zoned devices with equal zone size.
>>>>
>>>>Additionally, as updates to the space cache are in-place, the space cache
>>>>cannot be located over sequential zones and there is no guarantees that the
>>>>device will have enough conventional zones to store this cache. Resolve
>>>>this problem by disabling completely the space cache.  This does not
>>>>introduces any problems with sequential block groups: all the free space is
>>>>located after the allocation pointer and no free space before the pointer.
>>>>There is no need to have such cache.
>>>>
>>>>For the same reason, NODATACOW is also disabled.
>>>>
>>>>Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
>>>>INODE_MAP_CACHE inode.
>>>
>>>   A list of incompatibility features with zoned devices. This need better
>>>   documentation, may be a table and its reason is better.
>>
>>Are you referring to the format of the commit message itself ? Or would you like
>>to see a documentation added to Documentation/filesystems/btrfs.txt ?
>
> Documenting in the commit change log is fine. But it can be better
> documented in a listed format as it looks like we have a list of
> features which will be incompatible with zoned devices.
>
>more below..

Sure. I will add a table in the next version.

btrfs.txt seems not to have much there. I'm considering to write a new
page in the wiki like:

https://btrfs.wiki.kernel.org/index.php/Feature:Skinny_Metadata

>>>>+	if (!hmzoned_devices && incompat_hmzoned) {
>>>>+		/* No zoned block device found on HMZONED FS */
>>>>+		btrfs_err(fs_info, "HMZONED enabled file system should have zoned devices");
>>>>+		ret = -EINVAL;
>>>>+		goto out;
>>>
>>>
>>>   When does the HMZONED gets enabled? I presume during mkfs. Where are
>>>   the related btrfs-progs patches? Searching for the related btrfs-progs
>>>   patches doesn't show up anything in the ML. Looks like I am missing
>>>   something, nor the cover letter said anything about the progs part.
>
>
> Any idea about this comment above?
>
>Thanks, Anand

I just post the updated version of userland side series:
https://lore.kernel.org/linux-btrfs/20190820045258.1571640-1-naohiro.aota@wdc.com/T/

Thanks,
Naohiro
