Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0804CEEDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiCGAIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCGAID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 19:08:03 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E55D18D
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 16:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646611628; x=1678147628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nNfWDU248eoscI+YgfWro7RpxsGSrUUuiIfQ3hajC6g=;
  b=QqSBB66LLPSM+QFsv/4xZVjCoZLmJM4/K//cU7JOi14sSMzwMjeDVRNj
   A2CEMlWrwecw41DCgfUs0VvCGlmd1wMHLNXOah17cxgpGhvYNTLyZXvx/
   B/Z8PIKofZsEFdFUCrFJg+TTV08vsYU69hCGQ97x9MKYamaRgF60jSVt8
   M+J5GYvL5mprlwzVSUlnpgApl9BydRNyaU0V2MZLwLCbug2818Tg6E84E
   JqdmxM7FLrawnVOTP9IKUCcxTOT4Ut35O9O7u7zBnGDkRZnFd5bTvvUe0
   lfTqMXg/pBAxT28S4mRpa4VUQErTZDJDJCCBssKrr3Qwoqx0yn62hzWRZ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="199461531"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 08:07:08 +0800
IronPort-SDR: obu0segLYk2E4yX2RsbS+RK6ZFQhIvbYt7UGWQmkLfiSe70Ck44R5swUXAK63mu+uzrKRL4g+W
 zQ3beCDhPOg0Gm0zkUM4uDfSGPoCI3xHrRPj+czUakuPXg9mdWfEsHJJM8UOC7cN9S7LSZHHi8
 f/iGf1gtczt+Ky5lh8bSy8FO8keZf8Jq5GGM18EO2jc8mAjHukgi0/xLeo5TXexzjkj3H8sL9x
 pYIJ4qylYvegXQjrpmJ0nF35UmdsW8Ymp7V+bcpZsPcUsYedazSGrCQvADxaEd1cfioOWfs+M2
 06LNM+pTtuzeuTz0tU1da+7S
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:39:28 -0800
IronPort-SDR: 4f/KwvRT+JgcHv1lYz3ED20rcUcqCACe0DZc58nWMrFDZPKs4FVaRkGGQpAm4Y8XVcjkSGTdfc
 twmvso2pmD1tXISSyDnTv8QAuI7lTvvyE+vHdOFvH989tbPxoo29YNkFvQeuHwsMX10ObnAvyY
 MJ0gCneKx2VnRkBey2r06XmN/ia9YOyECxIEAyvo+0lYg0jPp5DltRyGAmZQkEHTe5YVzyHYh/
 C8AIgtCT8ova6Kjny3QFdo+/NpVQLWoCnpEUj76PQGO/dwMp4qkj4cvJweJMjmjMeIVliQF1EX
 jFs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:07:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBf0D5fStz1SVp5
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 16:07:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646611627; x=1649203628; bh=nNfWDU248eoscI+YgfWro7RpxsGSrUUuiIf
        Q3hajC6g=; b=enC18t7duHeyEqP5ELa2ddd3pfK957Y/2CMNGJIB890YMvd2FPP
        DTIvoBKtCGOMXmYXAvBsDRqqpLuW1LgAMYXvB2TByERvb3SIKMwQT7ww6sZNzBxl
        AyOxzt/pEJ0XtpdN9Gufbd1G+2VPUQw6gAP0knGtg9jv9je7kGD1R2uyGiIHKL2y
        a2lWzL03feeQP35gQJtJaF+66kB7HOzk+x2iemZ4pOCpJExN0+U8S8FK/xTfdRVg
        n/8wfgB14QkaqetaRLaL9lELi1uOPnfdjtNxplYVkKYuLVZJeS4zEoSO+QTR7x3q
        lXGnM7ehMs8lRK+sV5+AodlEBKag7qFbYgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N1nfYbnXHlZX for <linux-fsdevel@vger.kernel.org>;
        Sun,  6 Mar 2022 16:07:07 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBf084kHKz1Rvlx;
        Sun,  6 Mar 2022 16:07:04 -0800 (PST)
Message-ID: <bcbb135d-9d8b-c2cc-2a2b-a09b9e26dec4@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 09:07:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YiKY6pMczvRuEovI@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/22 07:55, Luis Chamberlain wrote:
> On Sat, Mar 05, 2022 at 09:42:57AM +1100, Dave Chinner wrote:
>> On Fri, Mar 04, 2022 at 02:10:08PM -0800, Luis Chamberlain wrote:
>>> On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
>>>> On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
>>>>> Thinking proactively about LSFMM, regarding just Zone storage..
>>>>>
>>>>> I'd like to propose a BoF for Zoned Storage. The point of it is
>>>>> to address the existing point points we have and take advantage of
>>>>> having folks in the room we can likely settle on things faster which
>>>>> otherwise would take years.
>>>>>
>>>>> I'll throw at least one topic out:
>>>>>
>>>>>   * Raw access for zone append for microbenchmarks:
>>>>>   	- are we really happy with the status quo?
>>>>> 	- if not what outlets do we have?
>>>>>
>>>>> I think the nvme passthrogh stuff deserves it's own shared
>>>>> discussion though and should not make it part of the BoF.
>>>>
>>>> Reading through the discussion on this thread, perhaps this session
>>>> should be used to educate application developers about how to use
>>>> ZoneFS so they never need to manage low level details of zone
>>>> storage such as enumerating zones, controlling write pointers
>>>> safely for concurrent IO, performing zone resets, etc.
>>>
>>> I'm not even sure users are really aware that given cap can be different
>>> than zone size and btrfs uses zone size to compute size, the size is a
>>> flat out lie.
>>
>> Sorry, I don't get what btrfs does with zone management has anything
>> to do with using Zonefs to get direct, raw IO access to individual
>> zones.
> 
> You are right for direct raw access. My point was that even for
> filesystem use design I don't think the communication is clear on
> expectations. Similar computation need to be managed by fileystem
> design, for instance.
> 
>> Direct IO on open zone fds is likely more efficient than
>> doing IO through the standard LBA based block device because ZoneFS
>> uses iomap_dio_rw() so it only needs to do one mapping operation per
>> IO instead of one per page in the IO. Nor does it have to manage
>> buffer heads or other "generic blockdev" functionality that direct
>> IO access to zoned storage doesn't require.
>>
>> So whatever you're complaining about that btrfs lies about, does or
>> doesn't do is irrelevant - Zonefs was written with the express
>> purpose of getting user applications away from needing to directly
>> manage zone storage.
> 
> I think it ended that way, I can't say it was the goal from the start.
> Seems the raw block patches had some support and in the end zonefs
> was presented as a possible outlet.

zonefs *was* design from the start as a file-based raw access method so
that zoned block devices can be used from applications coded in
languages such as Java, which do not really have a direct equivalent of
ioctl(), as far as I know.

So no, it is not an accident and did not "end up that way". See:

Documentation/filesystems/zonefs.rst

If anything, where zonefs currently falls short is the need to do direct
IO for writes to sequential zones. That does not play well with
languages like Java which do not have O_DIRECT and also have the super
annoying property of *not* aligning IO memory buffers to sectors/pages
(e.g. Java always has that crazy 16B offset because it adds its own
buffer management struct at the beginning of a buffer). But I have a
couple of ideas to solve this.

> 
>> SO if you have special zone IO management
>> requirements, work out how they can be supported by zonefs - we
>> don't need yet another special purpose direct hardware access API
>> for zone storage when we already have a solid solution to the
>> problem already.
> 
> If this is fairly decided. Then that's that.
> 
> Calling zonefs solid though is a stretch.

If you see problems with it, please report them. We have Hadoop/HDFS
running with it and it works great.With zonefs, any application
chuncking its data using files over a regular FS can be more easily
converted to using zoned storage with a low overhead FS. Think Ceph as
another potential candidate.

And yes, it is not a magical solution, since in the end, it exposes the
device as-is.

> 
>>> modprobe null_blk nr_devices=0
>>> mkdir /sys/kernel/config/nullb/nullb0
>>> echo 0 > /sys/kernel/config/nullb/nullb0/completion_nsec
>>> echo 0 > /sys/kernel/config/nullb/nullb0/irqmode
>>> echo 2 > /sys/kernel/config/nullb/nullb0/queue_mode
>>> echo 1024 > /sys/kernel/config/nullb/nullb0/hw_queue_depth
>>> echo 1 > /sys/kernel/config/nullb/nullb0/memory_backed
>>> echo 1 > /sys/kernel/config/nullb/nullb0/zoned
>>>
>>> echo 128 > /sys/kernel/config/nullb/nullb0/zone_size
>>> # 6 zones are implied, we are saying 768 for the full storage size..
>>> # but...
>>> echo 768 > /sys/kernel/config/nullb/nullb0/size
>>>
>>> # If we force capacity to be way less than the zone sizes, btrfs still
>>> # uses the zone size to do its data / metadata size computation...
>>> echo 32 > /sys/kernel/config/nullb/nullb0/zone_capacity
>>
>> Then that's just a btrfs zone support bug where it's used the
>> wrong information to size it's zones. Why not just send a patch to
>> fix it?
> 
> This can change the format of existing created filesystems. And so
> if this change is welcomed I think we would need to be explicit
> about its support.

No. btrfs already has provision for unavailable blocks in a block group.
See my previous email.

> 
>   Luis


-- 
Damien Le Moal
Western Digital Research
