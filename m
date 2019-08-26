Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459689CBBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfHZIie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 04:38:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5094 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfHZIid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566808732; x=1598344732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qYbgIhd+LYGqIfubx5rmRAWksx9Nt8cmtOHsk7qSItk=;
  b=X9bZ2388DUojFeSDe5YbW857FZkGyT1e3MSHv2gvzoJlMDatPVoSX4Jl
   gbxWkPggPvyaERPRIo3Mx8ukxHBK9aJ/jcU7KgvuvpyCzJVCqwSwVdHuZ
   tGAdVz0pPaZ8H2XQ0zbrfA8AjVJjK6nua6whpEIUdm8xELsHLgC7oNOLL
   F31ewHWm/ofzBHeiYgIvoj8dfjC+21egs4uq/A+l9P/0b2Mub1BRiGOH8
   lu2ul+85oxjKKEuctVh6113fMLIkyucK6XB5+MwH6SE29hhQc88kJXExu
   UU/QOS3y8FVXWsit7A575tnx2CAuZnuzxqJf/3AuRz9PR/ynnZVK1hwaR
   A==;
IronPort-SDR: +NYucYLSYUloOsAOtD/US7ixMCVHRLJjXiO3jvPBh+Xm9/FjrwcksOE7ks4F8NKahkq8uJqBVG
 DK/y+nCefhWLPyMMCx9eSiWNvSlv8u5+EzAJHaRDn180XkF1Y7iFwDlgaSkot11FtIsns4ydbl
 GZLHM0sZl/YEW4XGBaCpMbUvDDUD/E8DQHZeboH0iXbD3ucfs7p5t1ChZuRbR2LQxcwWuIqDpW
 KEJZq/nbqSwxHW8xMwX1hl8QSILAbfM7xaN3UKZ7gI0R3idY/UAvgnO7RIielJc0ugZYf2E2xV
 vG4=
X-IronPort-AV: E=Sophos;i="5.64,431,1559491200"; 
   d="scan'208";a="217133459"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2019 16:38:52 +0800
IronPort-SDR: 8rUzccAQWn5lL4m2aWkPP0rJYEJAHrfbfv5uwLZF4j8nhaC9ygH8edIoGGIca8FEgqa4QLecT3
 Ge4Cp3V6pRZbFnj4WpEmPh0VJt3ts+KFYFenf/hl6C7Tv2Zey1k7nt5qdSfe5E2ljU76EiXIuc
 L2iT+a4mJmlJrcSYtQWO/Lk27PcwFc7aOhTT3Gj2pZPayHgEjVrMyOBWCmfwqXImGr0owKE6us
 +utAeZq5EfNlRk4mOCCWt8/fWtRxXvuUK4AfgBcjNG8VSSy6AWFJoRco7AK2Ea0JIPq+FmrIwj
 IJ5NgqG+sRZGSM/FeAxPug0/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:35:47 -0700
IronPort-SDR: wr3nDW4oIPCcBwy+O0TRgLMW7eyuq3PGxgiPKJdbyxJr7Ob3Upd7CwmIBD/iZXTuatInYvRkrh
 zNCqtgeU5c8AettFjMuPlXzK/DvYOEVoCW8jVjNteuCbhCZ+2Qufws0AB1//aO+5523zr4CKi7
 +JBkz+tPBaTpBOijfr2NNVVcpn4Jm5MFREPIH9iQwvbUDqkK/OPB8z6gz23eSC60bn+7xsWikc
 YRuPqOSsnwReqP5dDpVdQym5sq3T1BpJPnC1OAvt5Wugi1oyk+EY+63bUZcpZiZ9hNd1qBhmrC
 yM0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 26 Aug 2019 01:38:32 -0700
Received: (nullmailer pid 432157 invoked by uid 1000);
        Mon, 26 Aug 2019 08:38:30 -0000
Date:   Mon, 26 Aug 2019 17:38:30 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 03/27] btrfs: Check and enable HMZONED mode
Message-ID: <20190826083830.3dvajoi3dnu3nrr5@naota.dhcp.fujisawa.hgst.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
 <20190823101036.796932-4-naohiro.aota@wdc.com>
 <9c947b6c-c74d-24eb-ff6b-b448c8acfa40@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c947b6c-c74d-24eb-ff6b-b448c8acfa40@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 02:07:05PM +0200, Johannes Thumshirn wrote:
>On 23/08/2019 12:10, Naohiro Aota wrote:
>> HMZONED mode cannot be used together with the RAID5/6 profile for now.
>> Introduce the function btrfs_check_hmzoned_mode() to check this. This
>> function will also check if HMZONED flag is enabled on the file system and
>> if the file system consists of zoned devices with equal zone size.
>>
>> Additionally, as updates to the space cache are in-place, the space cache
>> cannot be located over sequential zones and there is no guarantees that the
>> device will have enough conventional zones to store this cache. Resolve
>> this problem by disabling completely the space cache.  This does not
>completely disabling ~^
>
>> introduces any problems with sequential block groups: all the free space is
>introduce ~^
>
>> located after the allocation pointer and no free space before the pointer.
>                                           is located? ~^
>> There is no need to have such cache.

Thanks.

>> @@ -25,6 +27,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>>  		       struct blk_zone *zone, gfp_t gfp_mask);
>>  int btrfs_get_dev_zone_info(struct btrfs_device *device);
>>  void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
>
>
>While we're at it, shouldn't all the functions in hmzoned.[ch] have a
>!CONFIG_BLK_DEV_ZONED compat wrapper and hmzoned.o is dependent on
>CONFIG_BLK_DEV_ZONED?

Exactly. It was broken on !CONFIG_BLK_DEV_ZONED as the bot pointed
out... I'll push them behind CONFIG_BLK_DEV_ZONED in the next
version.

>-- 
>Johannes Thumshirn                            SUSE Labs Filesystems
>jthumshirn@suse.de                                +49 911 74053 689
>SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
>GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
>HRB 21284 (AG Nürnberg)
>Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
