Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08EA534718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 01:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbiEYXy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345035AbiEYXy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 19:54:57 -0400
X-Greylist: delayed 7465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 16:54:56 PDT
Received: from mx1.supremebox.com (mx2.supremebox.com [198.23.53.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91369D070;
        Wed, 25 May 2022 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TqucRm9Dg5uQc0lXNeeQRLwX8YON2kIDkDZmFacymJY=; b=fZ40LqRrXVlxCFWC9k9qJlmFy2
        r4P8w3C1HmYxhdFmJKdwUovESGYAPtZu7BE7Po5tZGjBrDap7oYpDu9lPYQoMlExFqWhDNhXwhN7B
        dEQaTT/Zh+gU3LEwqFeh2NOcXjc8ArWnVeNLw6N1dfiPazNCJWdYHgRUnLYgNBSHC+PM=;
Received: from 75-166-140-231.hlrn.qwest.net ([75.166.140.231] helo=[192.168.0.91])
        by mx1.supremebox.com with esmtpa (Exim 4.92)
        (envelope-from <opensource@jilayne.com>)
        id 1ntytc-0000Pc-UT; Wed, 25 May 2022 21:50:25 +0000
Message-ID: <a8c4636b-707c-2563-c521-2455ac08237c@jilayne.com>
Date:   Wed, 25 May 2022 15:50:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Content-Language: en-US
To:     "Bradley M. Kuhn" <bkuhn@ebb.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        copyleft-next@lists.fedorahosted.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        jeyu@kernel.org, shuah@kernel.org, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org> <87h75g0xbm.ffs@tglx>
 <87y1yph1cm.fsf@ebb.org>
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <87y1yph1cm.fsf@ebb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/25/22 1:13 PM, Bradley M. Kuhn wrote:
> In answering Thomas' question …
>
> Thomas Gleixner wrote at 14:10 (PDT) on Monday:
>> If I want to remove this option, then how do I express this with a SPDX
>> license identifier?
> … some licensing/SPDX background is in order.  (I apologize in advance for a
> few paragraphs of license-splaining, as I know that many on this thread know
> these points already, but I suspect most only have only vague familiarity
> with this issue.)
>
> copyleft-next 0.3.1 reads:
>>> +11. Later License Versions
>>> +    The Copyleft-Next Project may release new versions of copyleft-next,
>>> +    designated by a distinguishing version number ("Later Versions").
> Many don't realize that GPL is (or was, pre-copyleft-next) unique in
> structure among copyleft licenses in that the -or-later clause of all
> licenses in the GPL family is configurable.  That yields the complex forms
> of: GPLv1-only, GPLv1-or-later, GPLv2-only, GPLv2-or-later, etc.  GPLv3 even
> added the proxy upgrade clause (— a formulation SPDX can't handle at all).
>
> Other non-trivial FOSS licenses — such as Mozilla Public License (MPL),
> Common Development and Distribution License (CDDL), and Eclipse Public
> License (EPL) (as just three examples) — all have “automatic -or-later”.
> Thus, “MPLv2.0” *always* means “MPLv2.0-or-later”, so if you use the SPDX
> moniker for that (“MPL-2.0”), it really is akin to using “GPLv2-or-later”.
> Meanwhile, there is no *actual* way to license code under “MPLv2-only” — the
> license text itself prohibits it.
A few folks on the SPDX legal team did a summary chart of all the 
nuances and while I'm not going to go down that road again, suffice to 
say, the "or later" clauses have more variation than most people would 
think (which is probably b/c most people don't need to pay attention to 
it). The "+" operator is always available if someone so chooses to apply 
it as needed.
>
> All that's to say: the GPL has (historically) always been a huge FOSS
> licensing special-case because of the complex configurability of its
> “-or-later” clause.
Agreed.
>
> One of the last activities I did with SPDX (in late 2017) was to help
> negotiate a solution on reworking the GPL identifiers to deal with this
> special case.  The solution was a classic political compromise — where
> *everyone* left unhappy — but that's what led to the deprecation of SPDX's
> “GPL-2.0” identifier in favor of “GPL-2.0-or-later” and “GPL-2.0-only”.
I would agree with this characterization, except this was the outcome 
the FSF wanted, so ostensibly they were happy (and you forgot that 
GPL-2.0+ ).
(And to give credit where credit is due, Bradley's input during that 
challenging "negotiation" was very helpful. :)
>
> So, this problem that Thomas notes above is definitely an error by the SPDX
> project, *just like* the one that exists for the deprecated “GPL-2.0”
To be clear, the GPL-2.0 identifier was never an error by the SPDX team 
- we were always very clear as to what it meant/means. It was that the 
FSF didn't like it. That is clearly explained in the blog post on the 
SPDX website, as well as the post on the FSF site on the subject.

Jilayne
