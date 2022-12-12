Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D467649934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 08:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiLLHGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 02:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLLHGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:06:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913492658;
        Sun, 11 Dec 2022 23:06:17 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p4ctE-00035Q-2R; Mon, 12 Dec 2022 08:06:16 +0100
Message-ID: <beedcb6f-5d72-da1b-993a-36de38a144c1@leemhuis.info>
Date:   Mon, 12 Dec 2022 08:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] fsdax,xfs: fix warning messages #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <da90b96d-ef1e-4827-b983-15d103a3a1ef@leemhuis.info>
In-Reply-To: <da90b96d-ef1e-4827-b983-15d103a3a1ef@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670828777;b560bec2;
X-HE-SMSGID: 1p4ctE-00035Q-2R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.11.22 11:30, Thorsten Leemhuis wrote:
> [Note: this mail is primarily send for documentation purposes and/or for
> regzbot, my Linux kernel regression tracking bot. That's why I removed
> most or all folks from the list of recipients, but left any that looked
> like a mailing lists. These mails usually contain '#forregzbot' in the
> subject, to make them easy to spot and filter out.]
> 
> On 24.11.22 15:54, Shiyang Ruan wrote:
>> Many testcases failed in dax+reflink mode with warning message in dmesg.
>> This also effects dax+noreflink mode if we run the test after a
>> dax+reflink test.  So, the most urgent thing is solving the warning
>> messages.
> 
> Darrick in https://lore.kernel.org/all/Y4bZGvP8Ozp+4De%2F@magnolia/
> wrote "dax and reflink are totally broken on 6.1". Hence, add this to
> the tracking to be sure it's not forgotten.
> 
> #regzbot ^introduced 35fcd75af3ed
> #regzbot title xfs/dax/reflink are totally broken on 6.1
> #regzbot ignore-activity

#regzbot inconclusive complex issue; fixes with backports apparently
planed to be merged for 6.2

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
