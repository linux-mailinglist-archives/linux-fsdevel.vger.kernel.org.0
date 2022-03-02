Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0CE4CA4E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 13:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiCBMgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 07:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiCBMgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:36:45 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1125EDC9;
        Wed,  2 Mar 2022 04:36:02 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nPOCz-00072Y-9N; Wed, 02 Mar 2022 13:35:57 +0100
Message-ID: <09fd50e3-7483-41ec-ee71-1a2ce8ff7b0f@leemhuis.info>
Date:   Wed, 2 Mar 2022 13:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Anthony Yznaga <anthony.yznaga"@oracle.com,
        Kees Cook <keescook@chromium.org>
Cc:     matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
 <ed02afd1-4e0f-4604-324c-0a58c0ca4b57@physik.fu-berlin.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ed02afd1-4e0f-4604-324c-0a58c0ca4b57@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646224562;65569228;
X-HE-SMSGID: 1nPOCz-00072Y-9N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.03.22 13:01, John Paul Adrian Glaubitz wrote:
> On 2/20/22 18:12, Thorsten Leemhuis wrote:
>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>> acted upon since it was reported about a week ago, that's why I'm hereby
>> forwarding it to the lists and the relevant people. To quote
>> https://bugzilla.kernel.org/show_bug.cgi?id=215601 :
> As a heads-up, this issue has been fixed in 439a8468242b [1].
> 
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=439a8468242b313486e69b8cc3b45ddcfa898fbf

Thx, but no need to in this particular, thx to the "Link:
https://lore.kernel.org/r/a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info"
that Kees included in the patch description. That allowed regzbot to
automatically notice the two new mailing lists threads where Kees posted
patches for testing and later also made regzbot notice the fix when it
landed in mainline:
https://linux-regtracking.leemhuis.info/regzbot/regression/a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info/

Sadly quite a few developers don't set such links tags, but I hope with
some education (and a improved regzbot that is a bit more useful at
least for subsystem maintainers) that will improve over time.

Ciao, Thorsten
