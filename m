Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316705124DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiD0WAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiD0WAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:00:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3717325EF
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651096659; x=1682632659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AUyIcwobFfV5SoYGzqqBamGFyyqRQJh2j8T40K6gwpo=;
  b=pHm/ovlvkcgXfXcu442KUwrc8Y+5jThMTlC8fmV+8OK/8pZUfjiu3/36
   EPIGUB1PJoqsYCH5eglpQdEuyyG0i+e0qszKX+I5F/PdgAOh0XZSySlgg
   /yICTBJWN+/CztWeMGvGFYhmbITEdzxGwR9Sk/wKQReAxMR4APnNmP5+k
   djXrZXGWxLJbHG03+5EQURMpe9RBZadzphPPWReBOF4v0TJzJm6G8tfKF
   dh5LAo7Na4yrk7MDgoC1OWcFlBYndUywf95MTrcM+kzeHKIMv6+xdRkAm
   4inPMocExvk03BZW4xgEMLgVTSbVFzOQk19HsKqf+/JtWD+T1LstxRkZC
   w==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="303207110"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 05:57:38 +0800
IronPort-SDR: 8hHk3zJ1mf3RIdTR2VicvK0M2PM2dNFGsudOpznEy08XcdoU8fZHE4Hdn34TkVS5aZoW/8NO7B
 eBaVpeNC21xxQdxX6jvPc3o18uMH5AUmws5jjz/Oyra4DGQydaMpoEp+krz7nBUg8SjktYryWU
 SLW614dDCxuOgUVz+X5iH6jF8B6T9q91PN5uAeZ9gcsOyvMd9X8GXdGnKfiJYT1Jl6n8j+8UcX
 bpxhZe9vg//3qf8g3iWi8B9OvGZKeYqASU9fzy9WM0KxAdgDjjFvSAnTrg749s3ygJarhbDwwP
 Sc229HWdu7Z5Q6h0JeTkaQeR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:28:31 -0700
IronPort-SDR: sdE07Zqz1syoD3l8ZBM2bNX23eSWdGSmTx4m4yxkqwisSF7+dUVkLR1wxeWbjNcIXLZqnvK39w
 L6ZXjUw3cANGW2MzY+kbYIkeMMl6P0hssH9o4TM3uw+Iw+1THTs2mJzbiDxKhorhKtNBkwSpMl
 zMmrTSx9pXN8xBAsIsD2QQ17UkWsedVl2A6hy21+rF+MqsAx3XVg3N0ZhfsOu+h+hnRhxo96PS
 UEtGrX7ugzjh/TFuaMY8xr7QOrh3sba9z2HLfzij+GoZyOCj7fxDHKKv1nfH/H7XoysWz4ZaBn
 zfI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:57:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXfp1Dflz1Rvlx
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 14:57:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651096657; x=1653688658; bh=AUyIcwobFfV5SoYGzqqBamGFyyqRQJh2j8T
        40K6gwpo=; b=PSstadGp5ulB2J+BWMxkaXnwwaZ8yjM0p23ACWCmqaNxmGu2kGS
        C8l6BvptPaomaiRYSqAyEpBwVAZubeO6rdS2iadrzki/hkGC2m6LaHJas2Yo0byY
        b9/2e33a44eeqtMNBaFgpcrEk472ygG6lllz6Td6b0v/IC3Xb6COAp8AGPgaIUvG
        DA37YPM7cc2BTrg4NKQT0+sj6QcAEOlIpxkKWtjy6UKghsbkrYOsdezEtdxNTpY1
        lZjeKqdK16ZbuRaO/nwXFLCpv4KwgJcUyGUvM7/EhO6RzVJtcVZ8NbXkoF2BZzMF
        oWpLBf6y7Wn2PVIlOH20Sd65u7CYkD88S2w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1CoSPEI6n59I for <linux-fsdevel@vger.kernel.org>;
        Wed, 27 Apr 2022 14:57:37 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXfm4bP3z1Rvlc;
        Wed, 27 Apr 2022 14:57:36 -0700 (PDT)
Message-ID: <ae18fae1-c914-7bea-7c7b-861962b10c2c@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 06:57:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        inux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
 <20220426101241.30100-2-nj.shetty@samsung.com>
 <0d52ad34-ab75-9672-321f-34053421c0c4@opensource.wdc.com>
 <20220427153053.GD9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427153053.GD9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/22 00:30, Nitesh Shetty wrote:
>>> +/**
>>> + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
>>> + * @q:  the request queue for the device
>>> + * @max_copy_sectors: maximum number of sectors to copy
>>> + **/
>>> +void blk_queue_max_copy_sectors(struct request_queue *q,
>>
>> This should be blk_queue_max_copy_hw_sectors().
>>
> 
> acked. Reasoning being, this function is used only by driver once for setting hw
> limits ?

function name points at what limit field it sets.

-- 
Damien Le Moal
Western Digital Research
