Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4902B9054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 11:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKSKnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 05:43:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49962 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgKSKnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:43:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJAfU5F022945;
        Thu, 19 Nov 2020 10:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DTOE+XSushUDSfqfyx9hff7Q2wdQPamXkFT+tBHMqBY=;
 b=EfJsme9lRXmaDogMd8C7qS8NGL82inkjmWUJkVvbcyJb96DBogU99I0Q+b8LHF1Meofv
 XWJGnisbiNCkwtDmMNrf4W5Dni/AYK39Bdmu8M5e950H1oDZYLk9yrQcm2v+cW+IHarE
 P+Oo5exoYjqLuZ2tvuVNB4i00VvdJGvorMyh3Fg/QSmgWl9KavqwmZYtx0/4Evz5HYTt
 /rEwOfBrj0vIzh3je9fiUS2CVmnfWKRLMZyq2t7i4rM5u2zVDMBInBocsxP8i0alJ8Mu
 qOfhCMPLpqYBW7X6KO1TMfVcvt6UDWXrLNeXL5edu+CbTOcTXhUU9P4LZe2Oxba8rn+N 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34t4rb4v1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 10:42:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJAdZGY142124;
        Thu, 19 Nov 2020 10:42:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ts0tjhe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 10:42:57 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJAgsrA001792;
        Thu, 19 Nov 2020 10:42:54 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 02:42:54 -0800
Subject: Re: [PATCH v10 07/41] btrfs: disallow space_cache in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <2276011f71705fff9e6a20966e7f6c601867ecbc.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f922fa0e-1c9f-dd2a-2595-fcd88d29420e@oracle.com>
Date:   Thu, 19 Nov 2020 18:42:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <2276011f71705fff9e6a20966e7f6c601867ecbc.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=2 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190079
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> @@ -985,6 +992,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   		ret = -EINVAL;
>   
>   	}
> +	if (!ret)
> +		ret = btrfs_check_mountopts_zoned(info);
>   	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
>   		btrfs_info(info, "disk space caching is enabled");
>   	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 2897432eb43c..d6b8165e2c91 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -274,3 +274,21 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   out:
>   	return ret;
>   }
> +
> +int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
> +{
> +	if (!btrfs_is_zoned(info))
> +		return 0;
> +
> +	/*
> +	 * Space cache writing is not COWed. Disable that to avoid write
> +	 * errors in sequential zones.
> +	 */
> +	if (btrfs_test_opt(info, SPACE_CACHE)) {
> +		btrfs_err(info,
> +			  "zoned: space cache v1 is not supported");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 52aa6af5d8dc..81c00a3ed202 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -25,6 +25,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   int btrfs_get_dev_zone_info(struct btrfs_device *device);
>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>   int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
> +int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   				     struct blk_zone *zone)
> @@ -48,6 +49,11 @@ static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
> +{
> +	return 0;
> +}
> +
>   #endif
>   
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> 

The whole of the above code can be replaced by..

-------------------
@@ -810,8 +810,15 @@ int btrfs_parse_options(struct btrfs_fs_info *info, 
char *options,
                         break;
                 case Opt_space_cache:
                 case Opt_space_cache_version:
                         if (token == Opt_space_cache ||
                             strcmp(args[0].from, "v1") == 0) {
+                               if (btrfs_is_zoned(info)) {
+                                       btrfs_err(info,
+                                       "zoned: space cache v1 is not 
supported");
+                                       ret = -EINVAL;
+                                       goto out;
+                               }
                                 btrfs_clear_opt(info->mount_opt,
                                                 FREE_SPACE_TREE);
                                 btrfs_set_and_info(info, SPACE_CACHE,
-------------------

Thanks.
