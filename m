Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F97B7F41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbjJDMgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbjJDMfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:53 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au (icp-osb-irony-out4.external.iinet.net.au [203.59.1.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99BC1E4;
        Wed,  4 Oct 2023 05:35:43 -0700 (PDT)
Received: from gateway.pc5.atmailcloud.com (HELO mqr.i-08c0d97331176e550) ([13.54.26.16])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 04 Oct 2023 20:35:35 +0800
Received: from CMR-KAKADU04.i-00e2aafc82f8e4b03 by MQR.i-08c0d97331176e550 with esmtps
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qo16F-0002by-1P;
        Wed, 04 Oct 2023 12:35:35 +0000
Received: from [203.220.76.238] (helo=[192.168.0.22])
         by CMR-KAKADU04.i-00e2aafc82f8e4b03 with esmtpsa
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qo0eB-0005nQ-3A;
        Wed, 04 Oct 2023 12:06:36 +0000
Message-ID: <22caaecc-c954-d880-672f-45761bf7fac2@westnet.com.au>
Date:   Wed, 4 Oct 2023 22:06:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
 <35a33582-9206-94bb-eca2-a1d9c585f6c1@westnet.com.au>
 <ZRsi7smLotWDwoNP@casper.infradead.org>
 <9d73b9e2-502e-4ef5-bb49-bc89d478329a@westnet.com.au>
 <ZRx0lIo5i2EuIsZ/@casper.infradead.org>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <ZRx0lIo5i2EuIsZ/@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-atmailcloud-spam-report: Action: no action
X-Cm-Analysis: v=2.4 cv=P7P8xAMu c=1 sm=1 tr=0 ts=651d554c a=1qi1FL2F0EdFFg+SXJ3Exg==:117 a=1qi1FL2F0EdFFg+SXJ3Exg==:17 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=8g8xS9MRXoAFlEb5IXsA:9 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfAmUuvsILtV2K9sDwZC7fTHAJy9B8bsXj8FFb2QWx9qHYZfrqmuosXgYNdJncSBIxJksOu0m7jpqiLpP1/a4zgICWf3m2wymcwM7oLDbgG7NaJT/Pn8y L1cRWkaievwZGd5kr54HDH08FzyhIQCsHeV5DP7JVYumukb5Jes2ti+fcgYw2dtXG8jxpxqxOHzRgw==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/10/23 06:07, Matthew Wilcox wrote:
> On Wed, Oct 04, 2023 at 12:14:10AM +1000, Greg Ungerer wrote:
>> On 3/10/23 06:07, Matthew Wilcox wrote:
>>> 00000918 <folio_unlock>:
>>>        918:       206f 0004       moveal %sp@(4),%a0
>>>        91c:       7001            moveq #1,%d0
>>>        91e:       b190            eorl %d0,%a0@
>>>        920:       2010            movel %a0@,%d0
>>>        922:       4a00            tstb %d0
>>>        924:       6a0a            bpls 930 <folio_unlock+0x18>
>>>        926:       42a7            clrl %sp@-
>>>        928:       2f08            movel %a0,%sp@-
>>>        92a:       4eba fafa       jsr %pc@(426 <folio_wake_bit>)
>>>        92e:       508f            addql #8,%sp
>>>        930:       4e75            rts
> 
> fwiw, here's what folio_unlock looks like today without any of my
> patches:
> 
> 00000746 <folio_unlock>:
>       746:       206f 0004       moveal %sp@(4),%a0
>       74a:       43e8 0003       lea %a0@(3),%a1
>       74e:       0891 0000       bclr #0,%a1@
>       752:       2010            movel %a0@,%d0
>       754:       4a00            tstb %d0
>       756:       6a0a            bpls 762 <folio_unlock+0x1c>
>       758:       42a7            clrl %sp@-
>       75a:       2f08            movel %a0,%sp@-
>       75c:       4eba fcc8       jsr %pc@(426 <folio_wake_bit>)
>       760:       508f            addql #8,%sp
>       762:       4e75            rts
> 
> Same number of instructions, but today's code has slightly longer insns,
> so I'm tempted to take the win?

Yes, I reckon so.


>>> We could use eori instead of eorl, at least according to table 3-9 on
>>> page 3-8:
>>>
>>> EOR Dy,<ea>x L Source ^ Destination → Destination ISA_A
>>> EORI #<data>,Dx L Immediate Data ^ Destination → Destination ISA_A
> 
> Oh.  I misread.  It only does EORI to a data register; it can't do EORI
> to an address.
> 
>> 400413e6 <folio_unlock>:
>> 400413e6:       206f 0004       moveal %sp@(4),%a0
>> 400413ea:       2010            movel %a0@,%d0
>> 400413ec:       0a80 0000 0001  eoril #1,%d0
>> 400413f2:       2080            movel %d0,%a0@
>> 400413f4:       2010            movel %a0@,%d0
>> 400413f6:       4a00            tstb %d0
>> 400413f8:       6c0a            bges 40041404 <folio_unlock+0x1e>
>> 400413fa:       42a7            clrl %sp@-
>> 400413fc:       2f08            movel %a0,%sp@-
>> 400413fe:       4eba ff30       jsr %pc@(40041330 <folio_wake_bit>)
>> 40041402:       508f            addql #8,%sp
>> 40041404:       4e75            rts
>>
>> But that is still worse anyway.
> 
> Yup.  Looks like the version I posted actually does the best!  I'll
> munge that into the patch series and repost.  Thanks for your help!

No worries. Sorry I didn't notice it earlier, but glad it is sorted now.

Regards
Greg


