Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17B72FDFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbjFNMLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244220AbjFNMLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:11:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C981FFD;
        Wed, 14 Jun 2023 05:11:29 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C082D6606EF9;
        Wed, 14 Jun 2023 13:11:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686744688;
        bh=vkoaLcxa/wT0Fcl73RCnDFggBDckXDJX/rwJsp2AhJg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fumlvVf4Wm/lEZCmLXxDzGTiOoPcbLOwj2ACJWCo7sCxTtT+BjF3/wqzy+n/JW6kw
         uV7sBot9LyZHLmqwlgAw7idG6YI1BFQjVRMptqoMhpaMQfFSaWPU5x6PdhkAPkCOdV
         Hx4wNu4MSk8K4JGUnG7xL5YbZcIa5LAtJ6C5l4yZ/rCcw+ZhltbPgNJu0Rl+vyJXuN
         Si3FDPvlQepoRuBns23HCA2akj2zRDsqmZVIKSCXyh5P0FEKPwjyUSAX19pemHwitk
         DfpSzb7vVJXXirGsHYd8qK7UDxhdVsFyJmhm+k5mYosPWDMuqD9BGn+CgHnMGzNANq
         TuG5yWh7xXICQ==
Message-ID: <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
Date:   Wed, 14 Jun 2023 14:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Content-Language: en-US
To:     =?UTF-8?B?V2VpLWNoaW4gVHNhaSAo6JSh57at5pmJKQ==?= 
        <Wei-chin.Tsai@mediatek.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWVsIExlZSAo5p2O5aWH6YyaKQ==?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
 <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
 <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
 <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Il 14/06/23 11:59, Wei-chin Tsai (蔡維晉) ha scritto:
> On Wed, 2023-06-14 at 08:16 +0100, Russell King (Oracle) wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On Wed, Jun 14, 2023 at 11:20:34AM +0800, Wei Chin Tsai wrote:
>>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>>> index 0e8ff85890ad..df91412a1069 100644
>>> --- a/arch/arm/kernel/process.c
>>> +++ b/arch/arm/kernel/process.c
>>> @@ -343,6 +343,7 @@ const char *arch_vma_name(struct vm_area_struct
>> *vma)
>>>   {
>>>   return is_gate_vma(vma) ? "[vectors]" : NULL;
>>>   }
>>> +EXPORT_SYMBOL_GPL(arch_vma_name);
>> ...
>>> diff --git a/kernel/signal.c b/kernel/signal.c
>>> index b5370fe5c198..a1abe77fcdc3 100644
>>> --- a/kernel/signal.c
>>> +++ b/kernel/signal.c
>>> @@ -4700,6 +4700,7 @@ __weak const char *arch_vma_name(struct
>> vm_area_struct *vma)
>>>   {
>>>   return NULL;
>>>   }
>>> +EXPORT_SYMBOL_GPL(arch_vma_name);
>>
>> Have you confirmed:
>> 1) whether this actually builds
>> 2) whether this results in one or two arch_vma_name exports
>>
>> ?
>>
>> -- 
>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> Hi Russell,
> 
> We did confirm that it can be built successfully in kernel 6.1 and run
> well in our system.
> 

It runs well in your system and can be built successfully because you're building
for ARM64, not for ARM...

> Actually, we only use this export symbol "arch_vma_name"
> from kernel/signal.c in arm64. We also export symbol for arch_vma_name
> in arch/arm/kernel/process.c because that, one day in the future,  we
> are afraid that we also need this function in arm platform.
> 
> Thanks.
> 
> Regards,
> 
> Jim
> 


