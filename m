Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28221549B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFQwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 11:52:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41549 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFQwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:52:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id x82so6179457qkb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4tt4nfdiit9U7XpM53n0RKTZMiAVVYwGAawHfl5Fsek=;
        b=ACS2bzwOM3Uoi3wDTiZ/iMGh4c2dU92xnrlqk5j91FRj2Qb+iCN3qm5nyADOd0bE8G
         vbTECqlXQBS+sp1XIfsyUt+8CjmM6cTcTz67j8H9ouIaKaxkt8TmxV24pb+jvUYTrVTY
         VhKtow8Vr2efNsVv8ZJcUzyl7OiqUWhGfURiSKkdxCO3imCPYeR2b8dLuxoulHXWXO6+
         6M1uYDJMINp5oBwMcqQQDlQH+9PbaYVKPLd8G41g3F9hiWYhoNdDnpzCBkZNa9+rW+mv
         1sPRaJGSUiOfS0it0QQW2drtecdyrZ06Rc9FUUQ2v9M+Y8ErXfwiV4gyPFRHFXn7evRb
         hZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4tt4nfdiit9U7XpM53n0RKTZMiAVVYwGAawHfl5Fsek=;
        b=MxF8Lcygz1Czf3ApWukFAnZI57eGSCddeJWWEMLixJguqUzcuRnx8oqC0G72pMiCzx
         Qk3rewBM0eDOPo4ZiqVJfmLNxuEoUFxROoTZYmeTJZajM2TWogwFqKNWPVHbU7GwZm3A
         wWwR2kN4xLO3mhta27z82RZaKqH0hNZS8a6cVXWlUh0ZOEBZx1+K9HMMBvY6VISIW2uI
         tD6nt8Fgg6wb6rB5TIrf0cKuiuknbcxz6sz9Kn+/pJzJqSbFINfYdcrQFJlE3C+BhTfS
         GPc6X5qgOBBV1ufJRWpklKmVVsM07ECpXtt7Q0P4E8EVk/wIFckq85PnpfsimSrTB6Ih
         9naA==
X-Gm-Message-State: APjAAAUhi47ZmRKq0u2hIISFBXnNbkWiXfg/oX3fTi46DEKXLKUWP1WZ
        AY3WukX0Aw/i+D5/OPoB2xnD4jLIXuA=
X-Google-Smtp-Source: APXvYqwHE/KHy5XiaDLKibC1o/Xmw+U6W6UdX2v4ND6Q9W4c1EOAlJuEZmVNrNRAiNoaFALTzqfBvA==
X-Received: by 2002:a05:620a:12cf:: with SMTP id e15mr3479056qkl.120.1581007940793;
        Thu, 06 Feb 2020 08:52:20 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 141sm1633035qkk.62.2020.02.06.08.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:52:20 -0800 (PST)
Subject: Re: [PATCH 09/20] btrfs: parameterize dev_extent_min
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-10-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b8c284f3-520c-5777-9309-0fb913227824@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:52:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-10-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:42 AM, Naohiro Aota wrote:
> Currently, we ignore a device whose available space is less than
> "BTRFS_STRIPE_LEN * dev_stripes". This is a lower limit for current
> allocation policy (to maximize the number of stripes). This commit
> parameterizes dev_extent_min, so that other policies can set their own
> lower limitation to ignore a device with an insufficient space.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/volumes.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 15837374db9c..4a6cc098ee3e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4836,6 +4836,7 @@ struct alloc_chunk_ctl {
>   				   store parity information */
>   	u64 max_stripe_size;
>   	u64 max_chunk_size;
> +	u64 dev_extent_min;
>   	u64 stripe_size;
>   	u64 chunk_size;
>   	int ndevs;
> @@ -4868,6 +4869,7 @@ static void set_parameters_regular(struct btrfs_fs_devices *fs_devices,
>   	/* We don't want a chunk larger than 10% of writable space */
>   	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>   				  ctl->max_chunk_size);
> +	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   }
>   
>   static void set_parameters(struct btrfs_fs_devices *fs_devices,
> @@ -4903,7 +4905,6 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   	struct btrfs_device *device;
>   	u64 total_avail;
>   	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
> -	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   	int ret;
>   	int ndevs = 0;
>   	u64 max_avail;
> @@ -4931,7 +4932,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   			total_avail = 0;
>   
>   		/* If there is no space on this device, skip it. */
> -		if (total_avail == 0)
> +		if (total_avail < ctl->dev_extent_min)

This isn't correct, dev_extent_min is the total size with all stripes added up, 
not the size of a single stripe.  Thanks,

Josef
