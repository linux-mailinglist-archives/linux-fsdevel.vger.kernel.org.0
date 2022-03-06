Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1304CEED8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiCFX5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 18:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCFX5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:57:30 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A65358E7A
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 15:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646610996; x=1678146996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jIlBydrq9wOvhJ6TbDU10XU8HY52nfBSmUDZKWw3wik=;
  b=Ii7cIhl7h0JIN9klXOpeGwlFzeEJdq5b4tVW47Kne6MO8OP2y143eNhZ
   3riAo2jS0+eR21BCZqETaMXxD8jKxPNoNnstOxd75Bt2bU3cB+N47xTYu
   dGr6lxd4ZDSz9nBgnjFbiNvwPN1Vd+Fg2KgnMlV9V9dTGTnEovCUM6AXO
   eJAh6odUDjR37iYylgBGJSBYRLJTRcF+uokeAzUjaoM8GBfAtFFLx67hl
   8PZP0GexldjpIWiHHwSQb+4rM3O/6JCwsCM/SUIo9kgc6J32/1jXptcfn
   GSLdrKvnwT+2wWzcSlttJYC48ZwdLRmO5L1CZnJUrNI57W1Ix3vMwcXhQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="193548107"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 07:56:36 +0800
IronPort-SDR: menP5t5tid6Hz9EieCCen8NAmHZaE1Kk/0gxUkuZWIQwYo73367e4F9IdZIoMK5cPZsgbReEyq
 IG6erTzSwc0Xxrs35mvCrkNCZi5NXfrNCImcF4ZMC7CeJ0Yy8qEUQTddWo+L3BFTwM6G+/tNIY
 i2rRSeeKUmWPhQAost8JWh0aNomOPT645SYLiJ7m/ujMGRLdd/w6fbLjWFjd3MP1omkZ6SsFHr
 87Kq6PgBD1eLkuoJRTk+ZP80+LCe8cbvTCWLulQlWeH7dt/4TEKX2NpI9y/jC8TasK39qFK1Qb
 bcAF5Zrb37sxJ5Xlfe9w6sMd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:28:55 -0800
IronPort-SDR: yGUudCgPE/fNhZdlmYdwi/NIMGzE4Yj6ZtjP86gVcqZt+frhs+msdj1AyMzVsiki/y9iJ1EYJp
 LtpcI0QQDNst40rRxZ/gacyV4kARSy/t9t/oSGKeb6AGX9fhvS+UpDYrPJsULXRX6Xo+0eRIm+
 JgkICU98g1vkjrLRdocz3snHQzb2yUxNnr25sZD79ltU6vMHsNSH4ikNKHqq4R7t9sNlxXb8+5
 E1zptmCyOtA3Li1rtMJk7XeXdjyuMMPF0q58y3lJ9mlrrAvScept7trIRHJOULyaGTBFPvjpaw
 HZU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:56:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBdm369vpz1SVp6
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 15:56:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646610994; x=1649202995; bh=jIlBydrq9wOvhJ6TbDU10XU8HY52nfBSmUD
        ZKWw3wik=; b=Fp6YONHtYMicWip/Z6/Ul4HUgmuM7MV0DaxO8+FWRI8jf2fM6Nf
        olOEoUWlbfEsLvMJ6uFCt7gGTFNpT4mgyTuXePv+3hSx0kMqypCNCtKYoLQbrmpZ
        1Xe8MDqVAbePwkO2ksc1jBrGDb7WVIoZYzvMildavgUAgmv0/JEcZKXPjj/e3eM6
        2qCTlGsdb1I2c7N1h3CNuJ+BsEqC/d5/pk7x6f/3d9CGblujX4FjKMqLhu1xXJPD
        Lgn+xncxyPSKYYc8uXyLbMCjT+c1ePGptXjQvkyg1EydYiNvJeRtdQs69FNgV/LN
        BF+rCEOivdS1Q7fDWnWDONxBlbQSHw11qTg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 48xGw6xL2l_X for <linux-fsdevel@vger.kernel.org>;
        Sun,  6 Mar 2022 15:56:34 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBdlz6HmSz1Rvlx;
        Sun,  6 Mar 2022 15:56:31 -0800 (PST)
Message-ID: <e2aeff43-a8e6-e160-1b35-1a2c1b32e443@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 08:56:30 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YiKOQM+HMZXnArKT@bombadil.infradead.org>
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

On 3/5/22 07:10, Luis Chamberlain wrote:
> On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
>> On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
>>> Thinking proactively about LSFMM, regarding just Zone storage..
>>>
>>> I'd like to propose a BoF for Zoned Storage. The point of it is
>>> to address the existing point points we have and take advantage of
>>> having folks in the room we can likely settle on things faster which
>>> otherwise would take years.
>>>
>>> I'll throw at least one topic out:
>>>
>>>   * Raw access for zone append for microbenchmarks:
>>>   	- are we really happy with the status quo?
>>> 	- if not what outlets do we have?
>>>
>>> I think the nvme passthrogh stuff deserves it's own shared
>>> discussion though and should not make it part of the BoF.
>>
>> Reading through the discussion on this thread, perhaps this session
>> should be used to educate application developers about how to use
>> ZoneFS so they never need to manage low level details of zone
>> storage such as enumerating zones, controlling write pointers
>> safely for concurrent IO, performing zone resets, etc.
> 
> I'm not even sure users are really aware that given cap can be different
> than zone size and btrfs uses zone size to compute size, the size is a
> flat out lie.
> 
> modprobe null_blk nr_devices=0
> mkdir /sys/kernel/config/nullb/nullb0
> echo 0 > /sys/kernel/config/nullb/nullb0/completion_nsec
> echo 0 > /sys/kernel/config/nullb/nullb0/irqmode
> echo 2 > /sys/kernel/config/nullb/nullb0/queue_mode
> echo 1024 > /sys/kernel/config/nullb/nullb0/hw_queue_depth
> echo 1 > /sys/kernel/config/nullb/nullb0/memory_backed
> echo 1 > /sys/kernel/config/nullb/nullb0/zoned
> 
> echo 128 > /sys/kernel/config/nullb/nullb0/zone_size
> # 6 zones are implied, we are saying 768 for the full storage size..
> # but...
> echo 768 > /sys/kernel/config/nullb/nullb0/size
> 
> # If we force capacity to be way less than the zone sizes, btrfs still
> # uses the zone size to do its data / metadata size computation...
> echo 32 > /sys/kernel/config/nullb/nullb0/zone_capacity
> 
> # No conventional zones
> echo 0 > /sys/kernel/config/nullb/nullb0/zone_nr_conv
> 
> echo 1 > /sys/kernel/config/nullb/nullb0/power
> echo mq-deadline > /sys/block/nullb0/queue/scheduler
> 
> # mkfs.btrfs -f -d single -m single /dev/nullb0
> Label:              (null)
> UUID:               e725782a-d2d3-4c02-97fd-0501de117323
> Node size:          16384
> Sector size:        4096
> Filesystem size:    768.00MiB
> Block group profiles:
>   Data:             single          128.00MiB
>     Metadata:         single          128.00MiB
>       System:           single          128.00MiB
>       SSD detected:       yes
>       Zoned device:       yes
>         Zone size:        128.00MiB
> 	Incompat features:  extref, skinny-metadata, no-holes, zoned
> 	Runtime features:   free-space-tree
> 	Checksum:           crc32c
> 	Number of devices:  1
> 	Devices:
> 	   ID        SIZE  PATH
> 	       1   768.00MiB  /dev/nullb0
> 
> # mount /dev/nullb0 /mnt
> # btrfs fi show
> Label: none  uuid: e725782a-d2d3-4c02-97fd-0501de117323
>         Total devices 1 FS bytes used 144.00KiB
> 	        devid    1 size 768.00MiB used 384.00MiB path
> 		/dev/nullb0
> 
> # btrfs fi df /mnt
> Data, single: total=128.00MiB, used=0.00B
> System, single: total=128.00MiB, used=16.00KiB
> Metadata, single: total=128.00MiB, used=128.00KiB
> GlobalReserve, single: total=3.50MiB, used=0.00B
> 
> Since btrfs already has "real size" problems this existing
> design takes this a bit further without a fix either. I suspect
> quite a bit of puzzled users will be unhappy that even though
> ZNS claims to kill overprovisioning we're now somehow lying
> about size. I'm not even sure this might be good for the
> filesystem / metadata.

btrfs maps zones to block groups and the sectors between zone capacity
and zone size are marked as unusable. The report above is not showing
that. The coding is correct though. The block allocation will not be
attempted beyond zone capacity.

> 
>   Luis


-- 
Damien Le Moal
Western Digital Research
