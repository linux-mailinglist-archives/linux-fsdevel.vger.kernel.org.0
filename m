Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08EC5AA55A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIBB4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiIBB4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:56:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F1A286F
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662083806; x=1693619806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=al/CnY7kQXrcz0e7K7fDQHFhM+LHnJ6CS/AHMcHJBWg=;
  b=BcvImtwmELid3jRNpFfW7H47elx/bwl2ys+uqnzs3ScD/s99z3LW6g5B
   V0apzYnjEi3hivOEpLBFRCwgYah2jVLLl6ReCQCnHUBla36qs0KierKTD
   i2A7kDTrRMA8Vlb34MB2eQ2pOQBH0btYVE+UWrut3DvcRXvrhsQFJY9Us
   ZF04ZyBMcYkauIRCLIy42iBYn3HRnnbVzcIBWen93GIXMIN38Re+e55ST
   8LvtX5Xuo+CZdnD/U7ZgI/bjzh3Xf5YUfcRoNq/AvwxUKXpbqutfTYzaW
   QAL0kl8sQlGAJuXYmcxOHafrrI8gytI0udEFojZ8MvmPpnsbH7FGRMVbn
   w==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="210774737"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 09:56:45 +0800
IronPort-SDR: 7kW5Gn/JEjhnf/MmUmsQGGHFmSP6lnQ6KNbQhNh35Y3fbmvjRi6Tqkh6LZNlXY1P2scWbfphec
 heZBElj1FDfpHAPWcwuyG1vr8ohSaplCZ8nlx9i7Xgxkt2uiTV5XjE1HurGNu/aIpN3k7+FXH3
 muKn3Nc+GptqSWUtu5LUO8RGSezYcpzjcwr8V7f70GhhsT8nJ+nV9xGvnD/999S26Y85SreONj
 Qks+plGegQ5lDwLVykAZ4yPYsPGvNwlwV5bz+kFcTBX+blqmfEc3vgL62obVgYx65ninK7QYxX
 DNLssMTyNzJh56QGPE5MGieZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:11:51 -0700
IronPort-SDR: Ha5RrcloP8ROJVI6wSzNDsN9A6mP7dR8xOByeQoi4in9ChX8V1KKUlklsuuxbbyx79aDCD86aw
 Ugk+xjs2azV1Q7yQK1nrJK8HhL+H+7UrpFxF9sDKkjdC6kNvpWtZ7T8Ws7bUGQNB8I7UO2efJf
 2D7tTkzk5V/FKsRW5wSn8fdqGfLG/unxAxDhM39Sgd7+lRH8bARLerzxoKyC60Xr3Q+V4qa4sl
 OEEy1jccdpuMzxwiQawQStn8ptyoYUaNucaJyPbHmKonqS7qbjpUEGXSFVgUaASTO0ZgrQzdfZ
 tzQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:56:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJgy506bJz1RWy0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 18:56:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662083804; x=1664675805; bh=al/CnY7kQXrcz0e7K7fDQHFhM+LHnJ6CS/A
        HMcHJBWg=; b=K9lq6sRk1lf3n3qPe/oNm7QQKKzCi9/xw05H6VyRi9nyIJek0Yd
        n4wmFsGNYStqe7guXF9GfrFvnNJ1pjH2i/dcDo4XIPbUGihoznqX4PIBJLbDCJ+P
        70XOc056QCv6m5bmsq0J77dasC7aygvE+82hqLf6akOj+6G+9kHjQZME0r1ktiQ7
        enB3EE5cceT3sD+sd0x2HsAUOIMEzJbVoW6RA0TfmxEMGEMlr3BvQ305rhEX5E42
        EfQ2bqvJfEVjXvvEbGyb0P2/dR6e5FWKzwoZ427ZQwdOjsFZlpQLNa311eD0AccK
        AkZuMut8ONWql5xJgZhk/Wk89LHIynPiw+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aOVHj4saXMVo for <linux-fsdevel@vger.kernel.org>;
        Thu,  1 Sep 2022 18:56:44 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJgy15tRJz1RvLy;
        Thu,  1 Sep 2022 18:56:41 -0700 (PDT)
Message-ID: <429d26b8-f7d8-6365-a2fa-f4ed892182e4@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 10:56:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 15/17] btrfs: calculate file system wide queue limit for
 zoned mode
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-16-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220901074216.1849941-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/22 16:42, Christoph Hellwig wrote:
> To be able to split a write into properly sized zone append commands,
> we need a queue_limits structure that contains the least common
> denominator suitable for all devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/ctree.h |  4 +++-
>  fs/btrfs/zoned.c | 36 ++++++++++++++++++------------------
>  fs/btrfs/zoned.h |  1 -
>  3 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5e57e3c6a1fd6..a37129363e184 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1071,8 +1071,10 @@ struct btrfs_fs_info {
>  	 */
>  	u64 zone_size;
>  
> -	/* Max size to emit ZONE_APPEND write command */
> +	/* Constraints for ZONE_APPEND commands: */
> +	struct queue_limits limits;
>  	u64 max_zone_append_size;

Can't we get rid of this one and have the code directly use
fs_info->limits.max_zone_append_sectors through a little helper doing a
conversion to bytes (a 9 bit shift) ?

[...]
>  	/* Count zoned devices */
>  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>  		enum blk_zoned_model model;
> @@ -685,11 +677,9 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  				ret = -EINVAL;
>  				goto out;
>  			}
> -			if (!max_zone_append_size ||
> -			    (zone_info->max_zone_append_size &&
> -			     zone_info->max_zone_append_size < max_zone_append_size))
> -				max_zone_append_size =
> -					zone_info->max_zone_append_size;
> +			blk_stack_limits(lim,
> +					 &bdev_get_queue(device->bdev)->limits,
> +					 0);

This does:

	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
                                        b->max_zone_append_sectors);

So if we are mixing zoned and non-zoned devices in a multi-dev volume,
we'll end up with max_zone_append_sectors being 0. The previous code
prevented that.

Note that I am not sure if it is allowed to mix zoned and non-zoned drives
in the same volume. Given that we have a fake zone emulation for non-zoned
drives with zoned btrfs, I do not see why it would not work. But I may be
wrong.

-- 
Damien Le Moal
Western Digital Research

