Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C3534495
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 21:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbiEYTwZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiEYTwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 15:52:23 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 12:52:22 PDT
Received: from protestant.ebb.org (protestant.ebb.org [50.56.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D08D630B;
        Wed, 25 May 2022 12:52:22 -0700 (PDT)
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by protestant.ebb.org (Postfix) with ESMTPSA id 9D99C820B4;
        Wed, 25 May 2022 12:14:38 -0700 (PDT)
From:   "Bradley M. Kuhn" <bkuhn@ebb.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Organization: Opinions expressed in this email are my own and are not necessarily those of any organization with which I have an affiliation.
References: <20211029184500.2821444-1-mcgrof@kernel.org>
        <20211029184500.2821444-2-mcgrof@kernel.org> <87h75g0xbm.ffs@tglx>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAABGdBTUEAALGPC/xhBQAAABVQ
 TFRFAAAAWjotvpiH/PHt27Sj7sq8lXFeBchlBgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsT
 AQCanBgAAAAHdElNRQfiCx4VFw6omMmeAAACAklEQVQ4y43UPZPbIBAGYGdu0puzQ51bI+qMdXId
 r0F1RoLrwfb+/5+QF307VVR4PDxiF14h7Xa7t3q8LJGjavj7a1euCYiZnaPnv9DF4FyMLKdXOPs4
 XM7KKzzKaF83gem+hUuF8QYUg7Fb4LEQAK1OG3hu4bbC3LpUC87+B9AMfQOg0yv0owEOK4x1+gnu
 M3yaV3jOMGxvKoXEKC9gAoabJtZYlXO8wJcb1hMHQClZgSj7cbzsY4a2vSqltIlz8nMpZnMkEmVw
 N4DtcYJo3AMPXFIMRMax/BjhOxZi2CpKKpWSZCd4C8aZ4CpzjR+Cint9WEp5H12IbbySEpHdaYVh
 OY9onf0Qq9//zDCFEW0MbFjUz7mHD1UdO4B3iErk9whdKdWVRuW5YLl5KnU2rjTBDyPmQImm5mec
 WQx7X3fBNwAzQ9kvBTKR0BwR3Bewhisn2mpkhea3BZwBcdorRlQk9QKecyZukRPeHTmuEL1FdjlJ
 tmTlvoAJPnRaMnKinNICn4QthNaKlNAlLae9sc5UODaelVh+l345u7ZMIY89GNdmWV8cIaTFlLGm
 QKLrzQykh/Aw02WsdoE2l1g7JIPdyWGFL6Hy1uJZsEjavLUXkVyeIdrbpPoXQHxDG0l68wEoW8vG
 BLI6qc2XoUEWCUI26aQfK1wypuwV7v6mtMhtgL8avOP/pBCiigAAAABJRU5ErkJggg==
X-Disclaimer: Opinions expressed in this email are my own and are not necessarily those of any organization with which I have an affiliation.
Date:   Wed, 25 May 2022 12:13:45 -0700
In-Reply-To: <87h75g0xbm.ffs@tglx> (Thomas Gleixner's message of "Mon, 23 May
        2022 23:10:37 +0200")
Message-ID: <87y1yph1cm.fsf@ebb.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In answering Thomas' question …

Thomas Gleixner wrote at 14:10 (PDT) on Monday:
> If I want to remove this option, then how do I express this with a SPDX
> license identifier?

… some licensing/SPDX background is in order.  (I apologize in advance for a
few paragraphs of license-splaining, as I know that many on this thread know
these points already, but I suspect most only have only vague familiarity
with this issue.)

copyleft-next 0.3.1 reads:
>> +11. Later License Versions
>> +    The Copyleft-Next Project may release new versions of copyleft-next,
>> +    designated by a distinguishing version number ("Later Versions").

Many don't realize that GPL is (or was, pre-copyleft-next) unique in
structure among copyleft licenses in that the -or-later clause of all
licenses in the GPL family is configurable.  That yields the complex forms
of: GPLv1-only, GPLv1-or-later, GPLv2-only, GPLv2-or-later, etc.  GPLv3 even
added the proxy upgrade clause (— a formulation SPDX can't handle at all).

Other non-trivial FOSS licenses — such as Mozilla Public License (MPL),
Common Development and Distribution License (CDDL), and Eclipse Public
License (EPL) (as just three examples) — all have “automatic -or-later”.
Thus, “MPLv2.0” *always* means “MPLv2.0-or-later”, so if you use the SPDX
moniker for that (“MPL-2.0”), it really is akin to using “GPLv2-or-later”.
Meanwhile, there is no *actual* way to license code under “MPLv2-only” — the
license text itself prohibits it.

All that's to say: the GPL has (historically) always been a huge FOSS
licensing special-case because of the complex configurability of its
“-or-later” clause.

One of the last activities I did with SPDX (in late 2017) was to help
negotiate a solution on reworking the GPL identifiers to deal with this
special case.  The solution was a classic political compromise — where
*everyone* left unhappy — but that's what led to the deprecation of SPDX's
“GPL-2.0” identifier in favor of “GPL-2.0-or-later” and “GPL-2.0-only”.

I wasn't involved with SPDX anymore when they (much later) created the
identifier “copyleft-next-0.3.1” — but it appears it was a case of “those
who forget the past is condemned to repeat it” — because copyleft-next's
SPDX identifier indeed has a similarly confusing ambiguity to “GPL-2.0”:

copyleft-next 0.3.1 text reads further:
>> +    Unless I explicitly remove the option of Distributing Covered Works
>> +    under Later Versions, You may Distribute Covered Works under any Later
>> +    Version.
Thomas Gleixner noted about it at 14:10 (PDT) on Monday:
> If I want to remove this option, then how do I express this with a SPDX
> license identifier?  Sigh!

So, this problem that Thomas notes above is definitely an error by the SPDX
project, *just like* the one that exists for the deprecated “GPL-2.0”
identifier.  But, that isn't copyleft-next's fault [0], nor Luis's fault.
IMO, Luis shouldn't be punished (i.e., by being prohibited by the Linux
project from licensing under the GPLv2-compatible terms of his choosing)
simply because the SPDX project erred.

Fortunately, the problem *is* hypothetical here because Luis has *not*
indicated that he's licensing under “copyleft-next-0.3.1 REVOKING
new-version-upgrade”, so it's not a problem for Luis' patch that SPDX offers
no way to represent that licensing sub-option in copyleft-next.

[0] Nevertheless, I am wondering, given that (a) opting-out-of-auto-upgrade is
    *so* GPL-specific, and (b) the auto-upgrade opt out has caused decades
    of pain and woe throughout the GPL-using community (and for SPDX!),
    maybe copyleft-next should, in fact, drop that clause entirely in future
    versions. Discussion of that is likely not of interest to most folks on
    this wide thread, so I'll pick up that conversation more narrowly just
    on the copyleft-next list from here …

 -- bkuhn
