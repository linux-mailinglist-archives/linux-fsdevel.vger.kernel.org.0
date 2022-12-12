Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C1649929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 08:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiLLHEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 02:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLLHED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:04:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55757285;
        Sun, 11 Dec 2022 23:04:01 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p4cr0-0002Aw-UH; Mon, 12 Dec 2022 08:03:58 +0100
Message-ID: <f2ff04c7-fbae-6343-a9cb-10a9c681463b@leemhuis.info>
Date:   Mon, 12 Dec 2022 08:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [REGRESSION] XArray commit prevents booting with 6.0-rc1 or later
Content-Language: en-US, de-DE
To:     Jorropo <jorropo.pgm@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, nborisov@suse.com,
        Matthew Wilcox <willy@infradead.org>
References: <CAHWihb_EYWKXOqdN0iDBDygk+EGbhaxWHTKVRhtpm_TihbCjtw@mail.gmail.com>
 <Y3h118oIDsvclZHM@casper.infradead.org>
 <CAHWihb_HugpV44NdvUc2CV_0q2wk-XWyhmGdQhwCP6nDmo1k7g@mail.gmail.com>
 <Y4SnKWCWZt0LtYVN@casper.infradead.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y4SnKWCWZt0LtYVN@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670828642;260373e9;
X-HE-SMSGID: 1p4cr0-0002Aw-UH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.11.22 13:18, Matthew Wilcox wrote:
> On Sun, Nov 20, 2022 at 12:20:13AM +0100, Jorropo wrote:
>> Matthew Wilcox <willy@infradead.org> wrote :
>>> On Sat, Nov 19, 2022 at 05:07:45AM +0100, Jorropo wrote:
>>>>
>>>> Hi, I recently tried to upgrade to linux v6.0.x but when trying to
>>>> boot it fails with "error: out of memory" when or after loading
>>>> initramfs (which then kpanics because the vfs root is missing).
>>>> The latest releases I tested are v6.0.9 and v6.1-rc5 and it's broken there too.
>>>>
>>>> I bisected the error to this patch:
>>>> 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae "XArray: Add calls to
>>>> might_alloc()" is the first bad commit.
>>>> I've confirmed this is not a side effect of a poor bitsect because
>>>> 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae~1 (v5.19-rc6) works.
>>>
>>> That makes no sense.  I can't look into this until Wednesday, but I
>>> suggest that what you have is an intermittent failure to boot, and
>>> the bisect has led you down the wrong path.
>>
>> I rebuilt both 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae and
>> the parent commit (v5.19-rc6), then tried to start each one 8 times
>> (shuffled in a Thue morse sequence).
>> 0 successes for 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae
>> 8 successes for v5.19-rc6
>>
>> This really does not look like an intermittent issue.
> 
> OK, you convinced me.  Can you boot 1dd685c414 with the command line
> parameters "debug initcall_debug" so we get more information?

Jorropo, did you ever provide the information Matthew asked for? I'm
asking, as this looks stalled -- and I wonder why. Or was progress made
somewhere and I just missed it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke
