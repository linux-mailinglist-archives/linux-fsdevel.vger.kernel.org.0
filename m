Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC27A73CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjITHQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjITHQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:16:12 -0400
Received: from icp-osb-irony-out2.external.iinet.net.au (icp-osb-irony-out2.external.iinet.net.au [203.59.1.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C4A993;
        Wed, 20 Sep 2023 00:16:03 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: A9a23:XOu7eKvTXW8iBOuehyK7C8uvTufnVHxfMUV32f8akzHdYApBsoF/q
 tZmKVkyQEty1hlBgm0KGI+zxf6LyZfVzubXKHJtqTc3CSgiRfPtXbyxNl33Mz6ZMvrNRUdm6
 9R2QtTbJajYdFeFzvuWGuan9SMUOZ2gHOKmU7aVYHgpHGeIdQ964f5ds79h6mJXqYXha++9k
 Yuai9HSPlajxwl1Pgo8g05UgEoy1BhakGpwUm0WPZinjneH/5UmJMt3yZWKEpfNatI88thW5
 gr05OrREmvxp3/BA/v5yeyjKhVirrT6ZWBigVIOM0SuqkQZ/HRqis7XOdJEAXq7hQllkPgh4
 +ROkaWPZzt4Ba/jmrowCzpDTgNHaPguFL/veRBTsOSglhycNSKyk7M2ShtsCOX0+M4qUScQs
 6ZCdnZXNkDra+GemdpXTsFjnMksMc/kMZkSoFl/wCrFC/s6B5vERuPD+Le02R9s2JwRQa6BP
 ZNxhTxHc0nJXgVsOlMtB7kbruSEgGm4ImIBgQfAzUYwyy2JpOBr65DBOcTUdpquTMRanlqwr
 2nb+23zRBodMbS31juB9mOEh+nBhyr3VYseUrqi+ZZChFyV23xWCxAMU1a/iee2h1T4WN9FL
 UEQvC00osAa8E2tU8m4UQa0rWCJujYCVNdKVe438geAzuzT+QnxLmwFSCNRLdU8v88eWzMnz
 BmKksnvCDgpt6eaIVqB8a2KpDe+IgARLGkfdWoKShYD79D/oYY1yBXVQb5LFra0gdL0Hxn/x
 jmLqG41gLB7sCIQ//jruA6C2Wjy48KRHkgp/grWGGmi60VweeZJerCV1LQS1t4YRK7xc7VLl
 CFV8yRCxIji1a2wqRE=
IronPort-HdrOrdr: A9a23:EEVSbKwHnZStNrEIjHS/KrPxceskLtp133Aq2lEZdPU1SL3kqy
 nKppkmPHDP6Ar5NEtOpTnCAtjnfZqkz+8X3WBJB8bBYOCEghrNEGgB1/qZ/9SIIUSXnYQw6U
 4HSdkYNDSaNzlHZKjBjjVQXOxQueWvweSDgaP3yH9pXRtrcchbnnlEIzfeOEkzaA5YCZ8+DZ
 b03Ls3m9MMQwVuUu2LQnEZW+DCotfPko7qJQUBGwMqgTP+/Q+A2frzDhyR3hIVVjVSzPM56G
 DA1wTy+6WktJiAu2Ph/l6W54lTkNvlwN5EGMHJkNEcLnH2hh+vf5kJYcz8gBkl5MuUwBIBlt
 3UphcpOM5+r0nWYnq+rXLWqmzdOXIVmgTf9WM=
X-Talos-CUID: =?us-ascii?q?9a23=3Ac1ftf2txNmga8BbjyaJu4dSW6It1WUze6E7vDXP?=
 =?us-ascii?q?pMmRGSuO4EXyLpYFdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8R4XtQ+LKed1SuVxQbwxhIeQf9g16pm2K0AJq5o?=
 =?us-ascii?q?tnvuHGSpgfGbC1R3iFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="464740721"
Received: from 58-6-226-208.tpgi.com.au (HELO [192.168.0.22]) ([58.6.226.208])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 20 Sep 2023 15:15:57 +0800
Message-ID: <1b677562-929c-62f7-353d-80af3c30c7c4@westnet.com.au>
Date:   Wed, 20 Sep 2023 17:15:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Matthew Wilcox' <willy@infradead.org>
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
 <c61a58a1f5a34f2b96c6043840635197@AcuMS.aculab.com>
 <ZQnCiZuMbFnwbEUt@casper.infradead.org>
 <bfbf4d9ae5674d5dbe8c509abf5b0f84@AcuMS.aculab.com>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <bfbf4d9ae5674d5dbe8c509abf5b0f84@AcuMS.aculab.com>
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



On 20/9/23 01:57, David Laight wrote:
> From: Matthew Wilcox
>> Sent: 19 September 2023 16:47
>>
>> On Tue, Sep 19, 2023 at 03:22:25PM +0000, David Laight wrote:
>>>> Anyway, that's not the brief.  We're looking to (eg) clear bit 0
>>>> and test whether bit 7 was set.  So it's the sign bit of the byte,
>>>> not the sign bit of the int.
>>>
>>> Use the address of the byte as an int and xor with 1u<<24.
>>> The xor will do a rmw on the three bytes following, but I
>>> doubt that matters.
>>
>> Bet you a shiny penny that Coldfire takes an unaligned access trap ...
> 
> and then the 'firmware' silently fixed it up for you a few 1000
> clocks later...
> 
>> and besides, this is done on _every_ call to unlock_page().  That might
>> cross not only a cacheline boundary but also a page boundary.  I cannot
>> believe that would be a high-performing solution.  It might be just fine
>> on m68000 but I bet even by the 030 it's lower performing.
> 
> I do remember managing to use 'cas2' to add an item to a linked list.
> But it is so painful so setup it was better just to disable interrupts.
> For non-smp that is almost certainly ok.
> (Unless the instructions are slow because of synchronisation.)
> Otherwise you need to use 'cas' on the aligned word.
> Assuming coldfire even has cas.

It doesn't. See CONFIG_CPU_HAS_NO_CAS in arch/m68k/Kconfig.cpu for how
m68k deals with ColdFire and early 68000 parts not having it.

Regards
Greg


> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
