Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D8551105
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiFTHLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiFTHLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:11:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769B9DF37;
        Mon, 20 Jun 2022 00:11:40 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o3BZS-0004T2-U0; Mon, 20 Jun 2022 09:11:38 +0200
Message-ID: <1b39ecc0-cb2c-1655-aee7-f67a2253a8ea@leemhuis.info>
Date:   Mon, 20 Jun 2022 09:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fscache corruption in Linux 5.17?
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Max Kellermann <mk@cm4all.com>
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YpXUrclhwN+oOlfj@rabbit.intern.cm-ag>
 <YnI7lgazkdi6jcve@rabbit.intern.cm-ag> <Yl75D02pXj71kQBx@rabbit.intern.cm-ag>
 <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <507518.1650383808@warthog.procyon.org.uk>
 <509961.1650386569@warthog.procyon.org.uk>
 <705278.1650462934@warthog.procyon.org.uk>
 <263652.1653986121@warthog.procyon.org.uk>
 <325231.1653988405@warthog.procyon.org.uk>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <325231.1653988405@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655709100;293ffa7d;
X-HE-SMSGID: 1o3BZS-0004T2-U0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.05.22 11:13, David Howells wrote:
> Max Kellermann <mk@cm4all.com> wrote:
> 
>>> Can I put that down as a Tested-by?
>>
>> Yes.  A month later, still no new corruption.
> 
> Thanks!

David, is the patch from this thread ("fscache: Fix invalidation/lookup
race" --
https://lore.kernel.org/lkml/705278.1650462934@warthog.procyon.org.uk/ )
heading toward mainline any time soon? This is a tracked regression and
it looked to me like there hasn't been any progress in the last two weeks.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke
