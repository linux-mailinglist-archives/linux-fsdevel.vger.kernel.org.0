Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084A6195B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 12:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiKDL7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDL7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:59:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE8429802;
        Fri,  4 Nov 2022 04:59:52 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oqvMU-0004Ta-0v; Fri, 04 Nov 2022 12:59:50 +0100
Message-ID: <db612736-1704-e2c0-0223-675f8ffacc76@leemhuis.info>
Date:   Fri, 4 Nov 2022 12:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
 <99249078-2026-c76c-87eb-8e3ac5dde73d@leemhuis.info>
In-Reply-To: <99249078-2026-c76c-87eb-8e3ac5dde73d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667563192;3a2c8fb5;
X-HE-SMSGID: 1oqvMU-0004Ta-0v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

On 30.09.22 13:52, Thorsten Leemhuis wrote:
> 
> Hi, this is your Linux kernel regression tracker. This might be a Qemu
> bug, but it's exposed by kernel change, so I at least want to have it in
> the tracking. I'll simply remove it in a few weeks, if it turns out that
> nobody except Maxim hits this.

There was one more report:
https://lore.kernel.org/all/20221020031725.7d01051a@xps.demsh.org/

But that's it so far. I'll put this to rest for now:

#regzbot monitor:
https://lore.kernel.org/all/20221020031725.7d01051a@xps.demsh.org/
#regzbot invalid: a kernel change exposed a bug in qemu that maybe still
needs to be fixed, *if* more people run into this


