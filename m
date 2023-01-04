Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327F65D09C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 11:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjADK0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 05:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjADK0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:26:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B30FAE8
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 02:26:44 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pD0yo-0003x4-NF; Wed, 04 Jan 2023 11:26:42 +0100
Message-ID: <90148f55-62f5-cd9e-4d38-33ad38bab5ff@leemhuis.info>
Date:   Wed, 4 Jan 2023 11:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] acl updates for v6.2
Content-Language: en-US, de-DE
To:     Christian Brauner <brauner@kernel.org>
Cc:     hooanon05g@gmail.com, linux-fsdevel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20221212111919.98855-1-brauner@kernel.org>
 <29161.1672154875@jrobl> <20221227183115.ho5irvmwednenxxq@wittgenstein>
 <16855.1672793848@jrobl> <32ce10e7-62ff-92f1-cac4-00037a2110a5@leemhuis.info>
 <20230104101443.knstpogkznjlz6qh@wittgenstein>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230104101443.knstpogkznjlz6qh@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672828004;d5ecb87a;
X-HE-SMSGID: 1pD0yo-0003x4-NF
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 04.01.23 11:14, Christian Brauner wrote:
> On Wed, Jan 04, 2023 at 11:04:06AM +0100, Linux kernel regression tracking (#info) wrote:
>> [TLDR: This mail in primarily relevant for Linux kernel regression
>> tracking. See link in footer if these mails annoy you.]
>>
>> On 04.01.23 01:57, hooanon05g@gmail.com wrote:
>>> Christian Brauner:
>>>> On Wed, Dec 28, 2022 at 12:27:55AM +0900, J. R. Okajima wrote:
>>> 	:::
>>>>> I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).
>>>>
>>>> Hey, I'll try to take a look before new years.
>>>
>>> Now it becomes clear that the problem was on my side.
>>> The "acl updates for v6.2" in mainline has nothing to deal with it.
>>> Sorry for the noise.
>>
>> In that case:
>>
>> #regzbot resolve: turns out it was a local problem and not regression in
>> the kernel
> 
> When and how did regzbot start tracking this? None of the mails that
> reported this issue to me contained any reference to regzbot.
> 
> If something is currently classified as a regression it'd be good to let
> the responsible maintainers and developers know that.

That happens these days (again) -- since five, too be more precise, as I
recently (again) changed how to handle that mails (some maintainers
hated getting mails about adding reports to the tracking, but I recently
 decided they have to deal with that locally).

But the mail that added this thread to the tracking was before that,
sorry. :-/
https://lore.kernel.org/all/2aa5cc7e-ca00-22a7-5e2f-7eb73556181e@leemhuis.info/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
