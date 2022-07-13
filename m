Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07595732FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiGMJhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiGMJhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:37:50 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77312AE67;
        Wed, 13 Jul 2022 02:37:49 -0700 (PDT)
Received: from [192.168.88.254] (unknown [125.163.212.174])
        by gnuweeb.org (Postfix) with ESMTPSA id A329F7E257;
        Wed, 13 Jul 2022 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1657705068;
        bh=57SLDvvXl7rAug93QDj0lqPFPcMCMvcdhau9G4XvILU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=IIgI5xu30CTTbc0kQQGgSjypt0Hk5DiHNiL/CQqUKg2f1xwjVTQJvrayg3lEvY1Ky
         pLGGFNJx+DrsdLyTmBh7iqFipkB7+XXjMfZRkcI0rjy7bXEpYt8/3IlQYPigzcdeMj
         /M/Gnrk8M/3ytApnaizbieBLjX1mA/WsB8cYdUZgoivbx8x4TKNGq5sziF14bkWpZC
         pWPmXO0sBDZIoRDfhNU+xzFIJF90xQzZ0NsNnqPbDZM+ZYpjboO9mf9oktmoV3mwYq
         lS2wQ7Zr+MICXCtX0p1Iv2R+zZXHR44HmyUKIl0Se5Kwk0xKrQqKY8h4sSYLMUFAJC
         h4CHGGibu/s3g==
Message-ID: <c5336d2f-bb63-1799-f4c0-effc11048998@gnuweeb.org>
Date:   Wed, 13 Jul 2022 16:37:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
 <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
 <Yp5iOlrgELc9SkSI@casper.infradead.org>
 <dd654ee2-ae10-e247-f98b-f5057dbb380b@canonical.com>
 <Yqe+zE4f7uo8YdBE@casper.infradead.org>
 <cd2a4ea4-52d2-cf95-7769-859b0a35b564@canonical.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: Linux 5.18-rc4
In-Reply-To: <cd2a4ea4-52d2-cf95-7769-859b0a35b564@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/22 3:27 AM, John Johansen wrote:
>    99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
> 
> but I would like some other peoples opinions on doing that, because we
> don't understand why we are getting the current lock splat, and without
> understanding it is a fix by avoiding the issue rather than being sure
> the actual issue is fixed.

Update from me:

I can't reproduce the splat in 5.19.0-rc4. Not sure if it's already
fixed though, since it happened randomly and I didn't realize what
action provoked the splat. I am running Ubuntu 22.04 for my daily
desktop activity.

I'll keep my lockdep on and will send you update if it's still
triggering.

-- 
Ammar Faizi

