Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932858F2DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiHJTOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHJTOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:14:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA525CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660158856; x=1691694856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gYs2N/Wznfe3hlI62W4thC972nT2hghgh16QaFZ50J8=;
  b=R37rG6NsZOKUOUmBiBiPdVk9q6O0a0JgXIPfR5xazqL/CcSRYOuKTFrP
   TWpqd3aZtLX8gnM0Jmcto9MHJLcRnS9EA9QQ5o4FdIUn7FoQyf4C519Xm
   dZ6dKUYp4LUUr53QqsHfDV5XpTEgwHMjORk8sDsP19iAlrfuZGCVMy1iL
   N6Fntvl+ebhxLq9fcPifXeyo2/zuJ6jPUXt6i0MuHwFOrWTHtNYpNzRLw
   dQLkg9xJNnAnG7wcvcJ97NjEeIGcDuU0J64jpRKQYxFSfbxTf+LXov2BF
   b/ydTKqRN863d+Gr0Bwi1Sh3rksRPrVcJt92K4q9sW4D6kHle9pmVPlNC
   w==;
X-IronPort-AV: E=Sophos;i="5.93,228,1654531200"; 
   d="scan'208";a="208372762"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 03:14:15 +0800
IronPort-SDR: u1LIaqZM8UT00FvcCLEw4/YV5QR82n6kIE1rMGEIXe8qNK3Ztd0FThPBEl7FKOAGwiv5mGvYfi
 MfQJ5pOEzvD+QeK+gwtiqckRmSQ3A9BGisroceOG/tulbZ9eEblEiDNZ/Xk7Rlgr7ZknMrq8sj
 weRRiVejerxXrwwqccRGBXqK+uGvCK4ViqkK0smh4z2V5SVBiMkrjIwzNwLePt4kmjh1uLvMDK
 h11rXn4JBRJ+oPEJdap5cpw/pB16zlPuu2SBRB4Wj3Z2wrpfAsoHg0I+Ww6CljBFqGQsylv5pR
 oA/7z5SQSrHzMEAOK4g/jzum
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 11:29:52 -0700
IronPort-SDR: 0klT9OJnDxLFnTZIPoBSrEIG6oqlpQ1LMatqRRa3tPqA6RXWp/OGQ3VSG1Pao9cNwUxK9TiJmK
 DkJsvZYAiOTCfoAsryyYZajaSa4mWh9vDpDHDxG2oACipeGQzJ10Z76Q6DwrqorHVfLsBFbaqh
 YfSLDVQc+/vgzjes+5ysuiiK10lJyLHgMWoiHXajp7QJFAHenBVG31GYvJppRLw8IDTR4mMfkQ
 fzaKwm7BLj4sHBjmrXjmqPyGFzCugBVWucqlQ5K+er1jM+ENBQqU5UY0HnASRBFdfqORMopLW+
 Uz0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 12:14:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M303r48bXz1Rwnx
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 12:14:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660158856; x=1662750857; bh=gYs2N/Wznfe3hlI62W4thC972nT2hghgh16
        QaFZ50J8=; b=d0n8HJFXlKQXqBnNdMkzYIOQWtTycr767wYpgddwIW8Qv1fW36a
        U8I5u40dIV6O7OIEtikV53q9kuXuKDN1XZsHrJReFsgKzQsG2Ronv/PX8cb39Xwu
        jwF9nDGfESrkxDlgAnFV4iH8j/T27PS3BEZ1FfKM5WUn7G4OvM5jVR77tM1qtDuJ
        1qmc1Q7W5Q+ednE3BTdgKhHNLfL6celHqoLHwRGBEuXLtVtmS/ug32ILM5VvIY2Z
        6Msr12vN0126RkHd56pcCVc881qm/5ZfxB5i1QCPEylNNl+3W6oKwq6nGKpfr0OF
        U/buWdaTQkRAU6EulPHoHpybNVtgXj9A08A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SC9nZidhb_mr for <linux-fsdevel@vger.kernel.org>;
        Wed, 10 Aug 2022 12:14:16 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M303q5mpcz1RtVk;
        Wed, 10 Aug 2022 12:14:15 -0700 (PDT)
Message-ID: <27eed02c-fd92-6f99-b213-1be70193b37d@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 12:14:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
 <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
 <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
 <24b7e027-e098-269b-ccf7-b14deb499c33@opensource.wdc.com>
 <8aa0e7a4-265c-21f4-bdb4-57641d15b7b9@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8aa0e7a4-265c-21f4-bdb4-57641d15b7b9@acm.org>
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

On 2022/08/10 11:08, Bart Van Assche wrote:
> On 8/10/22 07:36, Damien Le Moal wrote:
>> On 2022/08/08 8:37, Bart Van Assche wrote:
>>> Thanks for having taken a look. Please help with verifying whether the
>>> following patch is sufficient to fix the reported warning: "[PATCH]
>>> tracing: Suppress sparse warnings triggered by is_signed_type()"
>>> (https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).
>>
>> With the current Linus tree, I do not see this sparse warning. However, applying
>> the above patch, "make M=fs/zonefs C=1" generates a lot of warnings:
> 
> That doesn't make sense to me. My patch reduces the number of sparse 
> warnings that are reported.
> 
>> make -j64 M=fs/zonefs C=1
>>    CC [M]  fs/zonefs/super.o
>>    CC [M]  fs/zonefs/sysfs.o
>>    CHECK   fs/zonefs/sysfs.c
>>    CHECK   fs/zonefs/super.c
>> fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
>> include/linux/kernel.h, arch/x86/include/asm/percpu.h,
>> arch/x86/include/asm/preempt.h, include/linux/preempt.h,
>> include/linux/spinlock.h, ...):
>> ./arch/x86/include/asm/bitops.h:66:1: warning: unreplaced symbol 'return'
> 
> I think that you are hitting a bug in sparse. See also 
> https://lore.kernel.org/all/e91d351c-3c16-e48d-7e9d-9f096c4acbc9@debian.org/T/. 
> I also see the above warnings if I use the sparse binary from Debian 
> testing. I do not see these sparse warnings if I download the sparse 
> source code and compile that source code myself.

Good point. I was using Fedora 36 sparse package. Using sparse compiled from
source, I now see again the warnings without the patch and no warnings with the
patch applied. So the patch looks good. Are you going to send it as a fix for
6.0-rc1 ?

Cheers.


-- 
Damien Le Moal
Western Digital Research
