Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA07A8DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjITUlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITUlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:41:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E8BB
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 13:41:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41206fd9717so1091791cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695242473; x=1695847273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWfoV3C+7YSBwabU1RrTm8uXi7/h5S313DOQ9XVA4fs=;
        b=ll42s7Zw90tsjWd0E2BU7/7sJ/jiJ+kxuR6GFEOw+jkTvDFcUtLYINP90IDwFI4hGV
         K+egE2k1NR89tBtiCbQz56anRWdpdVnb3WhCAS+MYPgYFdNEAUUvZdkwmC39fRwhpwvw
         US8TD28CfIt17GPAIZX/QAfwB5tR56/VKTvtOP3ByJhwPdKhImi6c3AfR0dAEpGbVY7o
         utZXJAWfqc4nnPAEYdg7FIAlaRvflddvaNzNElUYC9f0aJVODyT9AtcqCBZvNwYnzBAH
         wnFo6DcKdcXIEW302r60Wqhv1STdkIVnEFj8FadghQLRyYnhvi4VTELZNbEW2W8IMIN9
         lwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242473; x=1695847273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWfoV3C+7YSBwabU1RrTm8uXi7/h5S313DOQ9XVA4fs=;
        b=SA0tE9Qw+1XYgACY85f7hVYndRiWgvxSdnJgjnexabdQi5Gmyld/7EHVZCBgjPx6GZ
         AifBSgK8jDDYMGgF4OZ/wU4yaseayxXieEGEEc4WpZj1tJE6YlCjhbpwtK4z4g8R6e/X
         esnh9n87ipd5tIU3NIbCsYDpWAkzQYTmLSGwpEVMTNLMAkjdQRzZaFw4TPlCOB3lZG6t
         3lTlNO3/47oCzoitevs6pOeziwYjnyx6s41gj6Ktnxc5mAo+hexPRRVW6fErbkvZkp3g
         0M6qpTQ2dyusmhsiS7awsImXzBK4UeX0w6pts4i0FgGQ/VxZzLSQ5AroiKK2Je+FqCgh
         Hqkg==
X-Gm-Message-State: AOJu0Yy7YM0vN/Z0mvsDknIC3/e2ktsYOJ+ORpjr5JA8pjc0rRxdq3hO
        XjswkMjahFz1x20JEmI4qnk4PVKE0J9o+olGNEuK1WJp
X-Google-Smtp-Source: AGHT+IHCzJajQHoo4ag+MBSCuMbz+nBgjUOKbqVuICXRsb6shtfJZIsUaiffrvD5xvp+3k7IrE2ufA==
X-Received: by 2002:a05:622a:551:b0:412:1163:1d20 with SMTP id m17-20020a05622a055100b0041211631d20mr4219646qtx.48.1695242473530;
        Wed, 20 Sep 2023 13:41:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:104:ea12:bd23:169? ([2600:1700:2000:b002:104:ea12:bd23:169])
        by smtp.gmail.com with ESMTPSA id c17-20020a05622a025100b004166905aa2asm1690qtx.28.2023.09.20.13.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:41:13 -0700 (PDT)
Message-ID: <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com>
Date:   Wed, 20 Sep 2023 15:41:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] nbd: call blk_mark_disk_dead in
 nbd_clear_sock_ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-8-hch@lst.de>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230811100828.1897174-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-08-11 5:08 AM, Christoph Hellwig wrote:
> nbd_clear_sock_ioctl kills the socket and with that the block
> device.  Instead of just invalidating file system buffers,
> mark the device as dead, which will also invalidate the buffers
> as part of the proper shutdown sequence.  This also includes
> invalidating partitions if there are any.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/nbd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8576d696c7a221..42e0159bb258fa 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1434,12 +1434,10 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
>  	return ret;
>  }
>  
> -static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
> -				 struct block_device *bdev)
> +static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
>  {
> +	blk_mark_disk_dead(nbd->disk);
>  	nbd_clear_sock(nbd);
> -	__invalidate_device(bdev, true);
> -	nbd_bdev_reset(nbd);

This change breaks nbd-client, which calls the NBD_CLEAR_SOCK ioctl during
device setup and socket reconnection. After merging this series (bisected to
511fb5bafed1), all NBD devices are immediately dead on arrival:

[   14.605849] nbd0: detected capacity change from 0 to 4194304

[   14.606211] Buffer I/O error on dev nbd0, logical block 0, async page read
[   14.619101] Buffer I/O error on dev nbd0, logical block 0, async page read

[   14.630490]  nbd0: unable to read partition table

I wonder if disk_force_media_change() is the right thing to call here instead.

Regards,
Samuel

>  	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
>  			       &nbd->config->runtime_flags))
>  		nbd_config_put(nbd);
> @@ -1465,7 +1463,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  	case NBD_DISCONNECT:
>  		return nbd_disconnect(nbd);
>  	case NBD_CLEAR_SOCK:
> -		nbd_clear_sock_ioctl(nbd, bdev);
> +		nbd_clear_sock_ioctl(nbd);
>  		return 0;
>  	case NBD_SET_SOCK:
>  		return nbd_add_socket(nbd, arg, false);

