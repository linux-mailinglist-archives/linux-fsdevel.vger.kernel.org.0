Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A62271E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIUIpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIUIpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:45:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB354C061755;
        Mon, 21 Sep 2020 01:45:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so10354629ljg.9;
        Mon, 21 Sep 2020 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZmaZ187zMFdVdjh+DfPERuCP3WU0wLxzZIFDgqpQhQ=;
        b=UWXytXWmkq8pXmYqB0sXkFrf5u7O8zADyv3pKBcOd43273LrLEK/6dwQie7xrTzsFY
         om+1pH6WEDJNAT2FC5RZEXob/KRC6BhuELwRQTtlvWyS36FiytI4T13PRHgaPvhqTOmm
         JnxMoCogivVva8Xm2cqsnuYpJ5d7lJj6ft92HDVD4p/9uEForZYyO+gdHPYZMAUq++Qq
         M1rqpVX3Vnj2KoBKnqSQr5mA55K3Ux9Svkrgvl7128w9LytJpLCirpoWpIfX+fiWXgLN
         hfRQHGkBqoDrOX6dl6WzzpJsP4xUBo+tICCmmkS34li8nJVViMd6ZQnNGiU/epbwh+QT
         3mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CZmaZ187zMFdVdjh+DfPERuCP3WU0wLxzZIFDgqpQhQ=;
        b=gc9RUqGvyZasbDWoF4cPdreyGZ031WAIpkLUduqMMRRniCMMkwpVk5KvGYxDFH9m4v
         rW+dq6/DxaCWTma9T+PrhAECJnC7hTrMzUNhFOaHiSx1W+ShFSgbyRA43fu6aVmIV6u3
         TndqpvwrDhnnfALh+tWxXrWvl3afy0g6AJslOXwj0Fy9gYEmmJWq+p33z7RvWjonDbN2
         BOMGulKRFCra9UbEAGXL3yzp80InYxcEIqk1u4FuJFouAZGdwMPe11yvCmuuiZTBSAq7
         9WfFEKNhJuxTgoVX9rYR7LCMW5I3x8X7Nj3Ob7kf3CjJBflt4cWrRqvYAwLL912TG/gY
         8LDw==
X-Gm-Message-State: AOAM530G0V/N9EdGhIVxXZPdKH6PFRm8PfqpG4GbAp0VsSZiina+dCuo
        79Rr2NICPia7oQ4GClgZVusiJC/uu0eFEA==
X-Google-Smtp-Source: ABdhPJx5mav1W62IiUmXTaMhqLWi6f2dGUFFf8sbUeC0z4e5MZ82zAxsAmryelg6X6Izw+2IGouZSQ==
X-Received: by 2002:a2e:2c0e:: with SMTP id s14mr15080290ljs.174.1600677953001;
        Mon, 21 Sep 2020 01:45:53 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:485b:5520:1d32:5ffa:5dce:483f? ([2a00:1fa0:485b:5520:1d32:5ffa:5dce:483f])
        by smtp.gmail.com with ESMTPSA id u14sm2551614lji.83.2020.09.21.01.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 01:45:52 -0700 (PDT)
Subject: Re: [PATCH 08/14] dasd: cleanup dasd_scan_partitions
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <20200921071958.307589-1-hch@lst.de>
 <20200921071958.307589-9-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <28f7f012-2787-2959-394e-cda480786ea9@gmail.com>
Date:   Mon, 21 Sep 2020 11:45:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921071958.307589-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 21.09.2020 10:19, Christoph Hellwig wrote:

> Use blkdev_get_by_dev instead of bdget_disk + blkdev_get.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/s390/block/dasd_genhd.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
> index af5b0ecb8f8923..a9698fba9b76ce 100644
> --- a/drivers/s390/block/dasd_genhd.c
> +++ b/drivers/s390/block/dasd_genhd.c
> @@ -101,18 +101,11 @@ int dasd_scan_partitions(struct dasd_block *block)
>   	struct block_device *bdev;
>   	int rc;
>   
> -	bdev = bdget_disk(block->gdp, 0);
> -	if (!bdev) {
> -		DBF_DEV_EVENT(DBF_ERR, block->base, "%s",
> -			      "scan partitions error, bdget returned NULL");
> -		return -ENODEV;
> -	}
> -
> -	rc = blkdev_get(bdev, FMODE_READ, NULL);
> -	if (rc < 0) {
> +	bdev = blkdev_get_by_dev(disk_devt(block->gdp), FMODE_READ, NULL);
> +	if (IS_ERR(bdev)) {
>   		DBF_DEV_EVENT(DBF_ERR, block->base,
> -			      "scan partitions error, blkdev_get returned %d",
> -			      rc);
> +			      "scan partitions error, blkdev_get returned %ld",

    blkdev_get_by_dev() now?

> +			      PTR_ERR(bdev));
>   		return -ENODEV;
>   	}
>   

MBR, Sergei
