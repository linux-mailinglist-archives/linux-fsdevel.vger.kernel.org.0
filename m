Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4472C830A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgK3LRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 06:17:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgK3LRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:17:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUB9DU4072296;
        Mon, 30 Nov 2020 11:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Y7YK6VDzAXQWGnlu/xgy/wLUsDe4DrpptCVjETeUpmU=;
 b=R1p32X3doea+dSWMHAVO2PzZKePZSRWuNCOHYB4wytQ+7gME9hlwCMK8VbGkQ6Ad2O8m
 94EfrIhAgbDFf2mSITEWHgQ2BNEQbIYu16B2vWBS0yJ2FmV4u5JLI2Zmz+bfNTDpUCxh
 mgU/B+hkEGIjpmAXpWksWde9p3KJtwGu2h9xqm7pwp+sr/K3OGPEaAQ+1szmYReyd4xf
 DyJlaO5KBWjpsU2hygv6RDRYCpqLunziqpihdpYPqB0PFf7yL2MNr5cv3nLy2tLlBA2a
 v57j6SVWRo4y0YxGbHKpWmZGWF+HLSdpdJyF1HDFV6NZw8gMdzgeCoXjDSWz8761LON4 BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkcgg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 11:16:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUBABOw193501;
        Mon, 30 Nov 2020 11:16:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540aqegf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 11:16:36 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUBGSnr007005;
        Mon, 30 Nov 2020 11:16:29 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 03:16:28 -0800
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
From:   Anand Jain <anand.jain@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
 <20201112125734.dcxk5q7cuf5e7hje@naota.dhcp.fujisawa.hgst.com>
 <f75372bf-9dad-1397-21f2-7bfb53c9a94f@oracle.com>
Message-ID: <f824f52c-65ad-b0fe-a830-bb1a94c5d4be@oracle.com>
Date:   Mon, 30 Nov 2020 19:16:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f75372bf-9dad-1397-21f2-7bfb53c9a94f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=2
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=2
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Below two comments are fixed in the misc-next.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


On 18/11/20 7:17 pm, Anand Jain wrote:
> 
> 
> Also, %device->fs_info is not protected. It is better to avoid using
> fs_info when we are still at open_fs_devices(). Yeah, the unknown part
> can be better. We need to fix it as a whole. For now, you can use
> something like...
> 
> -------------------------
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1223d5b0e411..e857bb304d28 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -130,19 +130,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device 
> *device)
>           * (device <unknown>) ..."
>           */
> 
> -       rcu_read_lock();
> -       if (device->fs_info)
> -               btrfs_info(device->fs_info,
> -                       "host-%s zoned block device %s, %u zones of %llu 
> bytes",
> -                       bdev_zoned_model(bdev) == BLK_ZONED_HM ? 
> "managed" : "aware",
> -                       rcu_str_deref(device->name), zone_info->nr_zones,
> -                       zone_info->zone_size);
> -       else
> -               pr_info("BTRFS info: host-%s zoned block device %s, %u 
> zones of %llu bytes",
> -                       bdev_zoned_model(bdev) == BLK_ZONED_HM ? 
> "managed" : "aware",
> -                       rcu_str_deref(device->name), zone_info->nr_zones,
> -                       zone_info->zone_size);
> -       rcu_read_unlock();
> +       btrfs_info_in_rcu(NULL,
> +               "host-%s zoned block device %s, %u zones of %llu bytes",
> +               bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : 
> "aware",
> +               rcu_str_deref(device->name), zone_info->nr_zones,
> +               zone_info->zone_size);
> 
>          return 0;
>   ---------------------------
> 
> Thanks, Anand
> 
> 



>>>> @@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
>>>>      rcu_string_free(device->name);
>>>>      extent_io_tree_release(&device->alloc_state);
>>>>      bio_put(device->flush_bio);
>>>
>>>> +    btrfs_destroy_dev_zone_info(device);
>>>
>>> Free of btrfs_device::zone_info is already happening in the path..
>>>
>>> btrfs_close_one_device()
>>>   btrfs_destroy_dev_zone_info()
>>>
>>> We don't need this..
>>>
>>> btrfs_free_device()
>>>  btrfs_destroy_dev_zone_info()
>>
>> Ah, yes, I once had it only in btrfs_free_device() and noticed that it 
>> does
>> not free the device zone info on umount. So, I added one in
>> btrfs_close_one_device() and forgot to remove the other one. I'll drop it
>> from btrfs_free_device().


