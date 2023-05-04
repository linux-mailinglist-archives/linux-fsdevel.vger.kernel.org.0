Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531956F6F99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjEDQKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjEDQKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 12:10:01 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6225BB8;
        Thu,  4 May 2023 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1683216594;
        bh=wyFyXx0lKxZ8YrC0WLs2wNO+YieXVO9DplmXwDJCWaE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=VJVSWMipgpjES2y+oUQIUzOaf3E/pkw+7QcfKMsvha3lUaXaOfX/nJBSN/52Fm4Jb
         KjXx3F4SYEYeysECZaveFswf5F+wShp7XGLwT2NQ3FkxzPky5HhIPDdvR3xW1vsAIG
         gSxW8EC1rJY4iP7xcaDY5Snkahhm2TyqAwwjjAUo=
Received: from [IPV6:2408:8462:2b10:be3:4913:da2f:a6cc:3a8c] ([2408:8462:2b10:be3:4913:da2f:a6cc:3a8c])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 4D9723A; Fri, 05 May 2023 00:01:13 +0800
X-QQ-mid: xmsmtpt1683216073tuofohmjl
Message-ID: <tencent_DC538304754DFEA48B3167F9F13E8B548D0A@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoRqPYdf389XKueoXGmn2A+bcS+m2jufnBBJTCbULCgmUk/1bYY/
         KpKBo/h/2EnTJE5ErnggbssfhzSqpEu5+A3BIFaPBwId8eRg+O0SlrCdyxdDe8IzzNLYk0B7Okm1
         dc/2Jpxi2B6ucsg7fzzs3g2vZO5MVsBMwYDXkxYP2c6X/stQlvT9Vl4NTJ9ftxIjahIQMZGahyKR
         fd2qPuht1rc1meXnVR3ZIvaIW6WZsf/XDzjl2XUOPFxf3WbogV0N1rXtAM7iOdupUgupLdNrDbw6
         CMmOFjZdgdRYYE43QpbkqFnsuYBdBufQoYKmLYHajJ33AEKskS2IXWlOOCt7EPFgprc3tg4p8wij
         ZdI5ap5QUxZvaGroM/4jr/YLpjfyqjiL31Ds3dvuNjEH5RNgbbkTqVQuCJi0GzK5MWwileVAxVgn
         yhDgHQH0+Lmr3ChLEu1yThYUhGjudOvE1AWPLgzPl00m9mbq+OYSsLxmrrXnzo1ozKbFJwfxx0mw
         vpWIjtl2t5sUT72Y3sXA0pxNSlmTqW9zbzVchpTGr3ygoOejJRsVdFFBWQl3b+cNg/r/3CIKputT
         gq9THEj2OGoUxbgLSnvhI2KQ/MQ0NzaKvx78zH/ISj4X8LK7A8NAPVD5K4GJzoJjXkDJs2pc0gSs
         dnQWyFWZou8392UN3FmiRoiCHQILoGvcFqNPUPwlbiWHUZMW6RuP41JMauxs93xBJUZUw/fIxqrC
         3qrFmEBYa9MPdyoD4CjYhSFe/67nfCdEK/bw8g2ApJA+NcLC+YVvKoISWRX4FZJgsOmhK3K8W2uf
         mRPDy4jX6nT1ateew3DsU7lEtv2xjyrsNmoPs2lXuZ5ZbUVqwsxF+kPmwe8KiCLpkwNaVocx33rJ
         BGz9ag2J4eL7vqZXtMbgqa/ugH7OSCoj3q+Usb0FLgAwPZCSM45ilTlFlNq+myqJIjJjMkUy6YEu
         vTB5BEzhg+zvbY7/xFJ9m0Czme7rSDO5zc8Amc/SpHgz0xEjDOyQT5GwSxBuKt7JmQNg/mDsA=
X-OQ-MSGID: <0f841ada-e08b-7ab2-acfa-7dcd0343816f@foxmail.com>
Date:   Fri, 5 May 2023 00:01:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
From:   Wen Yang <wenyang.linux@foxmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
 <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
 <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
 <7dded5a8-32c1-e994-52a0-ce32011d5e6b@kernel.dk>
 <20230419-blinzeln-sortieren-343826ee30ce@brauner>
 <868ceaa3-4854-345f-900e-52a79b924aa6@kernel.dk>
 <tencent_31DEA62F31CFF96D3ED356F1508707594C0A@qq.com>
In-Reply-To: <tencent_31DEA62F31CFF96D3ED356F1508707594C0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2023/4/21 01:44, Wen Yang 写道:
>
> 在 2023/4/20 00:42, Jens Axboe 写道:
>> On 4/19/23 3:12?AM, Christian Brauner wrote:
>>> On Tue, Apr 18, 2023 at 08:15:03PM -0600, Jens Axboe wrote:
>>>> On 4/17/23 10:32?AM, Wen Yang wrote:
>>>>> ? 2023/4/17 22:38, Jens Axboe ??:
>>>>>> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
>>>>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>>>>
>>>>>>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>>>>>>> then a read(2) returns 8 bytes containing that value, and the 
>>>>>>> counter's
>>>>>>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>>>>>>> N event_writes vs ONE event_read is possible.
>>>>>>>
>>>>>>> However, the current implementation wakes up the read thread 
>>>>>>> immediately
>>>>>>> in eventfd_write so that the cpu utilization increases 
>>>>>>> unnecessarily.
>>>>>>>
>>>>>>> By adding a configurable delay after eventfd_write, these 
>>>>>>> unnecessary
>>>>>>> wakeup operations are avoided, thereby reducing cpu utilization.
>>>>>> What's the real world use case of this, and what would the expected
>>>>>> delay be there? With using a delayed work item for this, there's
>>>>>> certainly a pretty wide grey zone in terms of delay where this would
>>>>>> perform considerably worse than not doing any delayed wakeups at 
>>>>>> all.
>>>>>
>>>>> Thanks for your comments.
>>>>>
>>>>> We have found that the CPU usage of the message middleware is high in
>>>>> our environment, because sensor messages from MCU are very frequent
>>>>> and constantly reported, possibly several hundred thousand times per
>>>>> second. As a result, the message receiving thread is frequently
>>>>> awakened to process short messages.
>>>>>
>>>>> The following is the simplified test code:
>>>>> https://github.com/w-simon/tests/blob/master/src/test.c
>>>>>
>>>>> And the test code in this patch is further simplified.
>>>>>
>>>>> Finally, only a configuration item has been added here, allowing 
>>>>> users
>>>>> to make more choices.
>>>> I think you'd have a higher chance of getting this in if the delay
>>>> setting was per eventfd context, rather than a global thing.
>>> That patch seems really weird. Is that an established paradigm to
>>> address problems like this through a configured wakeup delay? Because
>>> naively this looks like a pretty brutal hack.
>> It is odd, and it is a brutal hack. My worries were outlined in an
>> earlier reply, there's quite a big gap where no delay would be better
>> and the delay approach would be miserable because it'd cause extra
>> latency and extra context switches. It'd be much cleaner if you KNEW
>> there'd be more events coming, as you could then get rid of that delayed
>> work item completely. And I suspect, if this patch makes sense, that
>> it'd be better to have a number+time limit as well and if you hit the
>> event number count that you'd notify inline and put some smarts in the
>> delayed work handling to just not do anything if nothing is pending.
>
> Thank you very much for your suggestion.
>
> We will improve the implementation according to your suggestion and 
> send the v2 later.
>
>
Hi Jens, Christian,

Based on your valuable suggestions and inspiration from TCP's 
/Delayed ACK/ technology, we have reimplemented v2 and are currently 
testing it.

After several days of testing, we will send it again.

Thanks.


--

Best wishes,

Wen




