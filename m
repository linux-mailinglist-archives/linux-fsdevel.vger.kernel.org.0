Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C605A0515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiHYAPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 20:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiHYAPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:15:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FFD6C75F
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 17:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661386533; x=1692922533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NQ6YMt/Gh3taRCiJQmF6o9X3VadrlfeoDwP2+Ym6YvI=;
  b=dskWFTBkGPuqy6TbRW9GMvVdMafsfiTJ4aOKIAnBeNH9sYGUOQYc2KB0
   nTbmlIrDm0qGdpf5QGbAOw+b1gjRy552NZYLiE1afomDO4lrs41FpF3lv
   M83qQTZbR3VxV0U6jXlMCbvsSeq/Sxxs5Fv8HolAsy+bBckDYH1yHDTmP
   ZhoJByUP02vQZQhnF2/7bgjvXcOn2CbJixLBJTZl7Fz7gBcGUo9mE7OYN
   vz1oEggCxvo4X6WwGHJ6MtbB76pX4EWt7xOza49DogXQVCkTsV7NTJwQG
   QOMvYX6Vwl6MnvXAxaslWNw9LL8nrCGZdLHz/8CD0iKC7KuN2abIIP2Jx
   g==;
X-IronPort-AV: E=Sophos;i="5.93,261,1654531200"; 
   d="scan'208";a="214736285"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 08:15:32 +0800
IronPort-SDR: BcslB5rnnV16Q0Mb/KMxft4BoHnGE0TgVyJZkjBhcEsb8axXIAnUNYCJ2z62D4u/AtYAnoKhU+
 fMvKNg5omMkIIkjzHryn3juT9CM2c4Eu4s2N2D21LbEq7TrmWdxbrS3bnIdMkYH7ImYhOw/D2U
 NhRiO4Yss+qXIzSK/7nqwA74FDEAIAgDfj5gUyqqiZNAA1/8F4ns7jkEov73lD0O+L3kcAcOx9
 du32vc7Y1xuS4u+NQOtw23wZ5Nca6CFi3omg8U+Dhus0F8RLCL4aI8UOqwazT+IksEnOji1ISs
 hAIdr+oxbIKHqBNEgRtXUSdR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 16:30:48 -0700
IronPort-SDR: inFzYTyeOebPNE+gMcOJJp2qmP6WNp6aaPr2wArp4OwFF1uyLXX/crkBEeVpCeUtgSAAXSIDFL
 gSHcpBorwCqeeWFeSvcyt8dY0eZG8Xd2VurxoRqoM6WTIHGYRGJH4Z9wmMYdKRPLXAidSxeQTJ
 rJbulcc9tx/JMepNK60KV9+VVMRA+Wp2luyqU2GK582l4Ly8OR48Z4Z8A60Ukq+zg1GqsdtyuC
 JXOykbKqaHevfKCPNcmZ+oge7orm9vW6Jmc2vg2dz+dL4qS0RNJhnQ0Oteg9UEAoMMGZueyil5
 6q0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 17:15:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MCk501c0Dz1Rwry
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 17:15:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661386531; x=1663978532; bh=NQ6YMt/Gh3taRCiJQmF6o9X3VadrlfeoDwP
        2+Ym6YvI=; b=f5MKhf91jeWoqx69eVdOIig+38dZxi+8cPTnEjrYiTHKWYrPk+B
        a5kmyUfMwt6cEXwxmhQk4QvPfXUcoAUSAWGQloBjtsLUEqN8ktQppXAD8ZtClzdE
        NE1uwE3jShdZDkNxMS0jTSHBnqYOpDEen6hEuUVxAvdlHgFio2LzxtyYeZLBnwvo
        irB64osQy9PBKQZ/YmKia3WZ18mfysJO5HX2a/s290hL2x5c1bSWYO+t6n9JDRD1
        oihFUUTCk+/B6eKFKrb96lGnlP3DXrLv14Qmu8tvqBSHNlJ6HxAyKEd8Nt1lte5Y
        cWcNGao12pCCDQMmnzINr/JEXDp25pWqshQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IwOomX9S1GGd for <linux-fsdevel@vger.kernel.org>;
        Wed, 24 Aug 2022 17:15:31 -0700 (PDT)
Received: from [10.89.82.240] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.240])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MCk4x5QNsz1RtVk;
        Wed, 24 Aug 2022 17:15:29 -0700 (PDT)
Message-ID: <589cb29e-d2aa-085f-db83-fa718f4fbef2@opensource.wdc.com>
Date:   Wed, 24 Aug 2022 17:15:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ANNOUNCE] CFP: Zoned Storage Microconference - Linux Plumbers
 Conference 2022
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <CGME20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2@uscas1p1.samsung.com>
 <20220522220128.GA347919@bgt-140510-bm01>
 <89b2bb4b-1848-22cc-9814-6cb6726afc18@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <89b2bb4b-1848-22cc-9814-6cb6726afc18@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/08/24 16:43, Bart Van Assche wrote:
> On 5/22/22 15:01, Adam Manzanares wrote:
>> Zoned Storage Devices (SMR HDDs and ZNS SSDs) have demonstrated that they can
>> improve storage capacity, throughput, and latency over conventional storage
>> devices for many workloads. Zoned storage technology is deployed at scale in
>> some of the largest data centers in the world. There's already a
>> well-established set of storage vendors with increasing device availability and
>> a mature software foundation for interacting with zoned storage devices is
>> available. Zoned storage software support is evolving and their is room for
>> increased file-system support and additional userspace applications.
>>
>> The Zoned Storage microconference focuses on evolving the Linux zoned
>> storage ecosystem by improving kernel support, file systems, and applications.
>> In addition, the forum allows us to open the discussion to incorporate and grow
>> the zoned storage community making sure to meet everyone's needs and
>> expectations. Finally, it is an excellent opportunity for anyone interested in
>> zoned storage devices to meet and discuss how we can move the ecosystem forward
>> together.
> 
> Hi Adam,
> 
> On https://lpc.events/event/16/contributions/1147/ I see four speakers 
> but no agenda? Will an agenda be added before the microconference starts?

And the speaker list is not up-to-date either. I am a speaker too :)

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
