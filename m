Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169914EB7A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 03:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbiC3BMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbiC3BMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:12:17 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4003B3204F;
        Tue, 29 Mar 2022 18:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=atFJa
        Ri5msGe8CVKy3LOTDOJSQ345/ooI9jAkmzAIiE=; b=jVK9nsIGrt12YRiSDBxGU
        kprKAsDlDBjIQ1FXS8kOohl9Ivgfl4gOaUvWFOwQkA4iYCcYDiubnULs/UpYYTqb
        YSGXiInf6GbQAX78GCT5eWhan3VW/RhaX8nCDHSN8OuO/RFFbyTYcEEGX9vIGDeR
        OCp/i4P6kk1lV3T2PAs8aQ=
Received: from [192.168.3.109] (unknown [218.201.129.19])
        by smtp7 (Coremail) with SMTP id C8CowABnCnX0rUNiN1F3AA--.5469S2;
        Wed, 30 Mar 2022 09:10:13 +0800 (CST)
Message-ID: <7ea53bf4-9f2f-2120-d7eb-b2292fa9f156@163.com>
Date:   Wed, 30 Mar 2022 09:10:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux resetting when the usb storage was removed while copying
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com>
 <87pmmee9kr.fsf@mail.parknet.co.jp>
 <06ebc7fb-e7eb-b994-78fd-df07155ef4b5@163.com>
 <15b83842-60d9-78b8-54e9-3a27211caded@roeck-us.net>
 <87pmm6hbk9.fsf@mail.parknet.co.jp>
 <e69813b2-9b60-02de-dbec-414c2baf42c8@163.com>
 <87ilrxgibb.fsf@mail.parknet.co.jp>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <87ilrxgibb.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABnCnX0rUNiN1F3AA--.5469S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1ruF4fuw4fuw1DZryxKrg_yoW5GFykpr
        W7AF4Fga9Yqrya9F1fJw1kCw1vq3yIkFn5GrnrWas8uan8uF1Fya1DJFyjvFW2kFs5u3Z8
        XF1qk3srAFWDtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0XdbUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiQhHT7VaEBYhpbwABs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/3/29 18:32, OGAWA Hirofumi 写道:
> qianfan <qianfanguijin@163.com> writes:
>
>>> This limits the rate of messages. Can you try if a this patch fixes behavior?
>> Yes, this patch fixed the problem and watchdog doesn't reset again.
>>
>> Next is the console log when usb storage disconnected:
> [...]
>
>> cp: read error: Input/output error
>> # [  218.253995] FAT-fs (sda1): FAT read failed (blocknr 1130)
>>
>> 'FAT read failed' error message printed only once.
>>
>> Interesting.
> Hm, message should print 10 times, then is suppressed. So this time, the
> test may not reproduced. Can your test reproduces the issue reliably?

Right.

I found copy file from usb storage to tmpfs or ubifs has the different 
behaviors. I got only one error message when copy to tmpfs and got 10 error 
messages when copy to ubifs. Next is the log when copy to ubifs:

[  313.767873] musb-hdrc musb-hdrc.0: ep2 RX three-strikes error
[  314.594767] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 
driverbyte=DRIVER_OK cmd_age=0s
[  314.604930] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 03 92 b6 00 00 
f0 00
[  314.612882] blk_update_request: I/O error, dev sda, sector 234166 op 
0x0:(READ) flags 0x84700 phys_seg 2 prio class 0
[  314.625613] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 
driverbyte=DRIVER_OK cmd_age=0s
[  314.635768] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 03 93 a6 00 00 
10 00
[  314.643746] blk_update_request: I/O error, dev sda, sector 234406 op 
0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  314.656025] usb 1-1: USB disconnect, device number 4
[  314.674700] blk_update_request: I/O error, dev sda, sector 1405 op 0x0:(READ) 
flags 0x0 phys_seg 1 prio class 0
[  314.685673] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.691490] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.697294] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.702987] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.708685] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.714377] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.720074] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.725799] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.731480] FAT-fs (sda1): FAT read failed (blocknr 1343)
[  314.737186] FAT-fs (sda1): FAT read failed (blocknr 1343)

My gpio watchdog toggle every 100ms and I sniffer watchdog toggle signal and 
uart console, watchdog toggle time is 119ms when those message printed, delayed 
19ms.

This patch can really solve this problem, thanks.

>
> Well, anyway, the patch looks like working.
>
> Thanks.

