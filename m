Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E57A73E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjITHWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjITHWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:22:43 -0400
Received: from icp-osb-irony-out2.external.iinet.net.au (icp-osb-irony-out2.external.iinet.net.au [203.59.1.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DB293;
        Wed, 20 Sep 2023 00:22:35 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: A9a23:xGcDEKncPfZRAAHEGTRw5dLo5gyqJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIv7RMywkvx1ptBB6l0bb0CeDoHuZblerYTSQZyrzc3J55zgZKtLcyDKUvtND+lIMTGTUZ2h
 +0TcdCowPocFxcwnT/zdOC7xZVA/fvQHOGkWbScYnkZqTJME0/Ntzoyw4bVvaY12bBVMyvV0
 fvursvWPkOS2jIcGgr4PIra9XuDFNyr0N8plgRWicJj5TcypFFMZH4rHpxdGlOjKmVi8k9Wc
 M6YpF2x1juxEx4FVoj/yu6jGqEAaua60QOm0hK6V4D+2UIa/nRaPqsTbJIhhUlrZzqhxstaw
 t9klbmKRwYVMPPLqNUTDhhTKnQrVUFG0OevzXmXgpXClQufLSuqm7M0VnRe0Y8wp7YxXycUr
 6JecmhdBvyAr7veLLaTRfNhidklI8TxMZk3pXx70TfUEbAtRpWFSriiCdpwgGls2ZwXQq2HD
 yYfQRRJRi/RPyRyAw8SM5Musf+aul7QaTIN/Tp5ooJyuQA/1jdZz7npNMv9e9qEX8xZk0+U4
 GXc8AzRLhgENdDZ7TOE/XKwrubEgCfyUsQZE7jQ3vprhkCDg28eEhsbUXOlrvSjzE2zQdRSL
 woT4CVGhawz8lG7C9fmUxCmrXqsoBERQZxTHvc85QXLzbDbiy6dB24ZXntIctcmnNE5SCZs1
 VKTmd7tQzt1v9W9VXWH6L6QoSiaPSkTMH9HaygZSwcM/9jkpsc0lB2nZtB7EaG6j9vdFjT5w
 jTMpy8774j/luZWh+DluAqd3Xf2/siPUhY650PcWWfj5x4RiJOZWrFEIGPztZ5oRLt1hHHa1
 JTYs6ByNNwzMKw=
IronPort-HdrOrdr: A9a23:5rTZZK3p7qBPZBgNA2Q5cQqjBD0kLtp133Aq2lEZdPUzSL3gqy
 nOpoV86faQslsssR4b+exoVJPvfZq+z+8R3WByB8bEYOCOggLBR+sM0WKF+UyDJ8SUzI9gPM
 lbAstDIey1J1w/pcHz5RmjE8xI+qj8zImYwc3bi1trUg1ubbhthj0JdzpzQncbeCB2QZIlEJ
 Kd48BDoSasPW8Qctm2b0N1I9TrlpnCiZbvYRsNAhg65U2VlDutrLbxDhif2X4lIkty6IZn+X
 XAmwz97KCkr/z+0AbV0yvJ441Rg8aJ8Ko5OCTP4vJlTgnRtg==
X-Talos-CUID: =?us-ascii?q?9a23=3AQPBk0mscTlBg1xLtMUWUVoTT6It8aVbXxl7wBnW?=
 =?us-ascii?q?2CFpnFrqleFHN+ahdxp8=3D?=
X-Talos-MUID: 9a23:9VkdxAoeOwopQ79+1Uwezx9EHvx5v52TMRgIqpQWltG2CQtfITjI2Q==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="464741731"
Received: from 58-6-226-208.tpgi.com.au (HELO [192.168.0.22]) ([58.6.226.208])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 20 Sep 2023 15:22:33 +0800
Message-ID: <35a33582-9206-94bb-eca2-a1d9c585f6c1@westnet.com.au>
Date:   Wed, 20 Sep 2023 17:22:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <ZQm67lGOBBdC2Dl9@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 20/9/23 01:14, Matthew Wilcox wrote:
> On Tue, Sep 19, 2023 at 02:35:25PM +0000, David Laight wrote:
>> From: Matthew Wilcox <willy@infradead.org>
>>> Sent: 19 September 2023 15:26
>>>
>>> On Tue, Sep 19, 2023 at 01:23:08PM +0000, David Laight wrote:
>>>>> Well, that sucks.  What do you suggest for Coldfire?
>>>>
>>>> Can you just do a 32bit xor ?
>>>> Unless you've got smp m68k I'd presume it is ok?
>>>> (And assuming you aren't falling off a page.)
>>>
>>> Patch welcome.
>>
>> My 68020 book seems to be at work and I'm at home.
>> (The 286, 386 and cy7c600 (sparc 32) books don't help).
>>
>> But if the code is trying to do *ptr ^= 0x80 and check the
>> sign flag then you just need to use eor.l with 0x80000000
>> on the same address.
> 
> I have a 68020 book; what I don't have is a Coldfire manual.

You can find it here: https://www.nxp.com/docs/en/reference-manual/CFPRM.pdf

Regards
Greg


> Anyway, that's not the brief.  We're looking to (eg) clear bit 0
> and test whether bit 7 was set.  So it's the sign bit of the byte,
> not the sign bit of the int.
