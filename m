Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E474BD032
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 18:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbiBTRUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 12:20:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:20:11 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B43220FF;
        Sun, 20 Feb 2022 09:19:50 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nLpsB-0004DC-LH; Sun, 20 Feb 2022 18:19:47 +0100
Message-ID: <823f70be-7661-0195-7c97-65673dc7c12a@leemhuis.info>
Date:   Sun, 20 Feb 2022 18:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Kees Cook <keescook@chromium.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
In-Reply-To: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645377590;e3e5a095;
X-HE-SMSGID: 1nLpsB-0004DC-LH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[reply to get Anthony on board, I screwed up when copy and pasting his
email address when sending below mail; sorry for the noise!]

On 20.02.22 18:12, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I'm hereby
> forwarding it to the lists and the relevant people. To quote
> https://bugzilla.kernel.org/show_bug.cgi?id=215601 :
> 
>> On ia64, after 5f501d555653f8968011a1e65ebb121c8b43c144, the gcc
>> binary crashes with SIGSEGV at startup (i.e., during ELF loading).
>> Only gcc exhibits the crash (including g++, etc), other toolchain
>> components (such as ld, ldd, etc) do not, and neither does any other
>> binary from what I can tell.  I also haven't observed the issue on
>> any other architecture.
>>
>> Reverting this commit resolves the issue up to and including git tip,
>> with no (visible) issues.
>>
>> Hardware:  HP Integrity rx2800 i2 Kernel config attached.
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: 5f501d555653f8968011a1e65ebb121c8b43c144
> #regzbot from: matoro <matoro_bugzilla_kernel@matoro.tk>
> #regzbot title: gcc segv at startup on ia64
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215601
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
