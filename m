Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A525346C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 00:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbiEYWn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiEYWn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 18:43:57 -0400
Received: from protestant.ebb.org (protestant.ebb.org [50.56.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6EA3098;
        Wed, 25 May 2022 15:43:55 -0700 (PDT)
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by protestant.ebb.org (Postfix) with ESMTPSA id 2EF49820B4;
        Wed, 25 May 2022 15:43:54 -0700 (PDT)
Date:   Wed, 25 May 2022 15:29:20 -0700
From:   "Bradley M. Kuhn" <bkuhn@ebb.org>
To:     linux-spdx@vger.kernel.org, J Lovejoy <opensource@jilayne.com>,
        copyleft-next@lists.fedorahosted.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        jeyu@kernel.org, shuah@kernel.org, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org, linux-doc@vger.kernel.org,
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
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Message-ID: <Yo6twJ5rqrB/J/rJ@ebb.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87h75g0xbm.ffs@tglx>
 <87y1yph1cm.fsf@ebb.org>
 <a8c4636b-707c-2563-c521-2455ac08237c@jilayne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8c4636b-707c-2563-c521-2455ac08237c@jilayne.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J Lovejoy wrote:
> (And to give credit where credit is due, Bradley's input during that
> challenging "negotiation" was very helpful. :)

😊 … thank you!

I'd written today:
>> So, this problem that Thomas notes above is definitely an error by the
>> SPDX project, *just like* the one that exists for the deprecated “GPL-2.0”

J Lovejoy replied:
> To be clear, the GPL-2.0 identifier was never an error by the SPDX team - we
> were always very clear as to what it meant/means.

… but notwithstanding a clear definition of a moniker (which I agree indeed
you've made for most SPDX identifiers), if that definition fails to
adequately match historically understanding (and/or fails to take into
account nuances in the document it represents), confusion ensues for users.
Users *were* confused about “GPL-2.0” (remember, we did a small (admittedly
non-scientific) survey at a session at a conference — FOSDEM I think it was?)

Most SPDX *users* won't speak its defined terms fluently; I suspect most of
Linux's licensors (and even most licensees) don't speak SPDX fluently, so
presumably you want SPDX identifiers to have some intuitiveness —
particularly for the use case of linux-spdx, which requires the identifiers
to be *both* human-readable and machine-readable.

This is relevant to the copyleft-next-0.3.1 identifier.  SPDX could define
“copyleft-next-0.3.1” to mean for SPDX purposes: “the text of copyleft-next
without any options in its terms exercised/removed” (— although I note
https://spdx.org/licenses/copyleft-next-0.3.1.html seems to be wholly silent
regarding options exercising/removing).  However, there is currently
confusion — shown in the fact that Thomas still asked:
>>>> If I want to remove this option, then how do I express this with a SPDX
>>>> license identifier?  Sigh!
… upon noticing this part of copyleft-next:
>>> +    Unless I explicitly remove the option of Distributing Covered Works
>>> +    under Later Versions, You may Distribute Covered Works under any Later
>>> +    Version.

Anyway, I'm pointing out SPDX's shortcomings on this point *not* to
captiously admonish SPDX, but rather to point out that any issues with SPDX
identifiers and their formal definitions shouldn't influence a decision about
what licenses are acceptable for inclusion as dual-license options in Linux.

Plus, I remain hopeful that over the long-term, the SPDX project will take
feedback from efforts like linux-spdx to solve the kinds of problems that
have come up in this thread and others.

Finally, I've already started a sub-thread on the copyleft-next list to start
discussing maybe the license (in future versions) shouldn't have this option
anyway (for unrelated policy reasons).  That might yield a side-benefit of
making the problem evaporate entirely for SPDX.  (Anyway, after 25 years of
living with GPL's “-or-later vs. -only” mess — I, for one, am convinced new
licenses like copyleft-next should try very hard to not repeat that mistake.)

 -- bkuhn
