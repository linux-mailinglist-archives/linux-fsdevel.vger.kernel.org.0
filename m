Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060121549E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgBFRBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 12:01:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39333 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFRBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:01:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id w15so6237077qkf.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmS/7wtgn9N71iOUdFHNX5Vdg3GTma2dtOP/iagF/e4=;
        b=Y9xpuvnqudEsbja267CpPg+QhdIA4ilUst52q5l7AgAeqjSGCyzOS/WPtQj/8stv7z
         QqW+wxwT4by9munenixAhBh/e1fOMdGJTIqz7ix24BprsmT1zEmjp+bhvX4P1YXE2Msv
         jNr/3vSE7TzyO5mbWrACkxtnYH3UdP2pb7j/4zE3lYi22TVzF7hOSB4baWY/vjHLa1WI
         PhL5qka43jC+eIUUfdGvBqEKLxWSL3k9IBVe40mYhNZE6Vydi5+QoyB7BXDcw9H21ZsO
         bqq5sAZTZXwQBBGGoO5qrsGRYv2ieIvJ5xdNvfE902PrGGXaNfKdDQaA9UXhoZikhbdp
         auBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmS/7wtgn9N71iOUdFHNX5Vdg3GTma2dtOP/iagF/e4=;
        b=Qb7QNWq1RmXi/TWa09u1cpPT/yCr7f43Qjhn/byzc3nAUnkKAsTAc4eXQQ+gCHeLyx
         SXty8dRhCkp5Fu89LZNd34qVGw86pDilkTLVikV6OMap/o7McO7GpOFWCiEXe6rYmA6+
         CQTb1xXADnu1E2ANFhazVPeEXMEwTwhGe/Jn7gni4aAU2n8gGt6/ZhS2nP8GfODp6ONT
         HCc1YmdsnADZL7zEXlRPgmoEVxKoGpUBdMYA1btc0v4oAi2Qp5Ld7+y+MXD7R/IvxuJj
         OfIwxry5p/gJBtC+tibkOoB/UV7DMxj38LY7aEFFHY7Lf+R3BTM+tAT0o7qKHQBtXbkA
         9aVw==
X-Gm-Message-State: APjAAAV+GVxnHL12l5Jcf7Q/vD+Ovizr3eUAb79mWkVK8I9/tGC/g6fB
        lp0Zy8GLl8J7wtoKWZEN3T2AEg9tPHw=
X-Google-Smtp-Source: APXvYqy5A0pKzeXDiUIi0sPsG44E7E25EGodU46J5ai+gBkIzKGFALXjVWU7usm7bBvkruoXUvjzbQ==
X-Received: by 2002:a37:9d0c:: with SMTP id g12mr3238743qke.35.1581008490406;
        Thu, 06 Feb 2020 09:01:30 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y21sm1875819qto.15.2020.02.06.09.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 09:01:29 -0800 (PST)
Subject: Re: [PATCH 12/20] btrfs: introduce clustered_alloc_info
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-13-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ae469d32-e2a7-72df-cdd7-30a81734201f@toxicpanda.com>
Date:   Thu, 6 Feb 2020 12:01:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-13-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:42 AM, Naohiro Aota wrote:
> Introduce struct clustered_alloc_info to manage parameters related to
> clustered allocation. By separating clustered_alloc_info and
> find_free_extent_ctl, we can introduce other allocation policy. One can
> access per-allocation policy private information from "alloc_info" of
> struct find_free_extent_ctl.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent-tree.c | 99 +++++++++++++++++++++++++-----------------
>   1 file changed, 59 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b1f52eee24fe..8124a6461043 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3456,9 +3456,6 @@ struct find_free_extent_ctl {
>   	/* Where to start the search inside the bg */
>   	u64 search_start;
>   
> -	/* For clustered allocation */
> -	u64 empty_cluster;
> -
>   	bool have_caching_bg;
>   	bool orig_have_caching_bg;
>   
> @@ -3470,18 +3467,6 @@ struct find_free_extent_ctl {
>   	 */
>   	int loop;
>   
> -	/*
> -	 * Whether we're refilling a cluster, if true we need to re-search
> -	 * current block group but don't try to refill the cluster again.
> -	 */
> -	bool retry_clustered;
> -
> -	/*
> -	 * Whether we're updating free space cache, if true we need to re-search
> -	 * current block group but don't try updating free space cache again.
> -	 */
> -	bool retry_unclustered;
> -
>   	/* If current block group is cached */
>   	int cached;
>   
> @@ -3499,8 +3484,28 @@ struct find_free_extent_ctl {
>   
>   	/* Allocation policy */
>   	enum btrfs_extent_allocation_policy policy;
> +	void *alloc_info;
>   };
>   
> +struct clustered_alloc_info {
> +	/* For clustered allocation */
> +	u64 empty_cluster;
> +
> +	/*
> +	 * Whether we're refilling a cluster, if true we need to re-search
> +	 * current block group but don't try to refill the cluster again.
> +	 */
> +	bool retry_clustered;
> +
> +	/*
> +	 * Whether we're updating free space cache, if true we need to re-search
> +	 * current block group but don't try updating free space cache again.
> +	 */
> +	bool retry_unclustered;
> +
> +	struct btrfs_free_cluster *last_ptr;
> +	bool use_cluster;
This isn't the right place for this, rather I'd put it in the 
find_free_extent_ctl if you want it at all.

And in fact I question the whole need for this in the first place.  I assume 
your goal is to just disable clustered allocation for shingle drives, so why 
don't you just handle that with your extent allocation policy flag?  If it's set 
to shingled then use_cluster = false and you are good to go, no need to add all 
this complication of the cluster ctl.

If you are looking to save space in the ctl, then I would just union {} the 
cluster stuff inside of the find_free_extent_ctl so the right flags are used for 
the correction allocation policy.

This whole last set of 10 patches needs to be reworked.  Thanks,

Josef
