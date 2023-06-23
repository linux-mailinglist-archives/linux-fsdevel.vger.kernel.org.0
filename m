Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EE773B77B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFWMhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFWMhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:37:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093CB213A;
        Fri, 23 Jun 2023 05:36:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qCg21-0006qx-5j; Fri, 23 Jun 2023 14:36:53 +0200
Message-ID: <b55af831-7fcb-09c9-c9e7-74719bdd01d9@leemhuis.info>
Date:   Fri, 23 Jun 2023 14:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [linus:master] [page cache] 9425c591e0: vm-scalability.throughput
 -20.0% regression
Content-Language: en-US, de-DE
To:     kernel test robot <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <202306211346.1e9ff03e-oliver.sang@intel.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <202306211346.1e9ff03e-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687523818;09cc1c5e;
X-HE-SMSGID: 1qCg21-0006qx-5j
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[I know this is mostly been dealt with already, but due to the immanent
release I'll add this to the tracking to make sure Linus becomes aware
of this]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 21.06.23 09:19, kernel test robot wrote:

> 
> kernel test robot noticed a -20.0% regression of vm-scalability.throughput on:
> 
> 
> commit: 9425c591e06a9ab27a145ba655fb50532cf0bcc9 ("page cache: fix page_cache_next/prev_miss off by one")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 9425c591e06a
#regzbot title mm/page cache: performance regression (2 reverts pending)
#regzbot monitor:
https://lore.kernel.org/all/20230621212403.174710-1-mike.kravetz@oracle.com/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
