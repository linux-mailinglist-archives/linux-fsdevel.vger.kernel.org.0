Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CB4E3ED3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 13:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiCVMym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiCVMyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:54:41 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 05:53:13 PDT
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81325589
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 05:53:11 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 522C29545F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 07:31:08 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WdfHn79x7RnrrWdfInTe1c; Tue, 22 Mar 2022 07:31:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E5Aows6fzjBhdYfTnbSqfUWzSiW9YfHAmPUHEbpwWJo=; b=PnuDbzlG5Hb7/SDAr+eaO1WhIQ
        Q6BIijqhYFQBjt7yjZ3FMOOwS28Ak8FhVwKW+z+dlTMHhzyAxFztOQOV8HnkluXKGaB4ym0KmwanN
        gMOuoqxxcro2voHlUaKIOW1mYxnOVBRytcSk8hA8l+enCVIuzL9ZGzpGuKGzGvUnGyQmxdKWfOygz
        spqWBZBvXLypBX6OMagJdROR+Opg2Cn7nJutE7maFdp7trq4vFzRYrgJQFD2bEIjkloWw4/aX+9q9
        z44ceBNeRezKB6jc9TWTR6HJ+2ayNh6ylxP1eojwLQIRQ7FRE5oH8SwKN1gqKJOeHcvZYQxg9D40u
        Yht5/cKg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54390)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWdfH-002AJg-HW; Tue, 22 Mar 2022 12:31:07 +0000
Message-ID: <15b83842-60d9-78b8-54e9-3a27211caded@roeck-us.net>
Date:   Tue, 22 Mar 2022 05:31:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux resetting when the usb storage was removed while copying
Content-Language: en-US
To:     qianfan <qianfanguijin@163.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-watchdog@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com>
 <87pmmee9kr.fsf@mail.parknet.co.jp>
 <06ebc7fb-e7eb-b994-78fd-df07155ef4b5@163.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <06ebc7fb-e7eb-b994-78fd-df07155ef4b5@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWdfH-002AJg-HW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54390
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/22 01:42, qianfan wrote:
> 
> 在 2022/3/22 15:21, OGAWA Hirofumi 写道:
>> qianfan <qianfanguijin@163.com> writes:
>>
>>> Hi:
>>>
>>> I am tesing usb storage on linux v5.15, found that the system is resetting when the
>>> usb storage(fat32 format) was removed while copying. Besides my custom board
>>> has a gpio-watchdog with 1.6s timeout.
>> Looks like I/O error by unplugging usb while reading data pages for
>> readahead, then your watchdog detected some state to reset system.
>>
>> If you disabled watchdog, it works as normal soon or later? If so, FAT
>> would not be able to do much (maybe ratelimit I/O error to mitigate
>> serial console overhead), request is from userspace or upper layer in
>> kernel.
> 
> I had changed console to ttynull and the system doesn't reset again.  kernel driver generate lots of error messages when usb storage is disconnected:
> 
> $ dmesg | grep 'FAT read failed' | wc -l
> 
> 608
> 
> usb storage can work again when reconnected.
> 
> The gpio watchdog depends on hrtimer, maybe printk in ISR delayed hrtimer that cause watchdog reset.
> 

Exactly. We had a similar problem recently, also related to the gpio watchdog.
I think the system ends up in a loop, retrying block 1162. Key for fixing
the problem will be to find the function causing the loop.

Guenter
