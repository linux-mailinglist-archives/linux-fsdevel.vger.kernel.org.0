Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893B1534647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiEYWQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiEYWQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 18:16:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EB8674F0;
        Wed, 25 May 2022 15:16:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653516974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5mqVOpRN7OrcPZs/HUScyADcePdW23SpFj2zCYffFg=;
        b=A/fPG898MRly5Tc/PqoRr+gojCPZESK+ybSanenHSpRukoYsMgKL1tIdWjQkoXKHh7gnu5
        3tSns9VEwTZNL5PcrvbeKbCsMiSj5EkMKc4W4Rg8mKMWmbaUqxmJfLkw/CIffaks9obWVx
        DLzIVsfw0NaQwpMpzW0u+ssndpxa9+cmlUu00WYjEOGNqB/Htj5euMAWbPFagaiSK/TQLJ
        AkBfTCaYftJAONlvrXRmFFnUC2Jaf7hcD80c3SVdbr+w4vdJf/KpzC+C87Ld3cU+Rsd+F9
        jWRqfoan51qmLIQ6UW2kGFEGbz/vtCERHAqxw1Z+Ln8GIfbR9YkHWaWteikOgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653516974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5mqVOpRN7OrcPZs/HUScyADcePdW23SpFj2zCYffFg=;
        b=Loxi6Khma+UmYtJGsZe6ptxZj5n1QWv/vTy7oBgCyywSsY1DcTQxk4DEcOolLB/lmIwoU1
        OxZFhePpCs1jItAw==
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Richard Fontana <fontana@sharpeleven.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "joe@perches.com" <joe@perches.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: RE: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
In-Reply-To: <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org> <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
 <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
Date:   Thu, 26 May 2022 00:16:13 +0200
Message-ID: <871qwhz2aa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tim!

On Wed, May 25 2022 at 19:05, Bird, Tim wrote:
>> From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberlain
>> I agree that we want to keep the number of licenses as small as
>> possible but we cannot really dictate which dual licensing options a
>> submitter selects unless the license is GPL-2.0-only incompatible,
>> which copyleft-next is not.
>
> Um, yes we can dictate that.

No!

> There were good reasons that the original BSD dual-licenses were
> allowed.  Those same reasons don't apply here.

That's just wrong. The reason why dual licensing is allowed is to share
code across licesce preferences. The very same reason applies here.

> Each license added to the kernel (even when added as an OR), requires
> additional legal analysis.  Corporate lawyers don't usually rely on
> the interpretation of novel licenses from external sources.  They do
> it themselves.  This means that hundreds of lawyers may find
> themselves reading and trying to interpret the copyleft-next license.

It's none of our problems that corporate lawyers are obviously unable to
act, cooperate and to agree on something.

     The license in question is around since 2016 and the kernel carries
     code under that license since 2017.

  So what the hell are you complaining 5 years after the fact? The whole
  point here is to convert this to SPDX identifiers.

Aside of that I'm impressed by your chutzpah to make up an argument on
corporate lawyer costs.

  Do you realize how much costs the very same crowd of corporate lawyers
  created by ill advising their employees to put corporate defined
  boiler plate into every other kernel source code file or by not
  advising them at all and let them add random crap?

  Do you realize that the costs to cleanup this mess have been mostly
  covered by community members with the help from a _very_ small subset
  of corporate lawyers?

  Do you realize that it's hilarious that your so costly corporate
  lawyers only need to react now that we are trying to convert licensing
  information to SPDX 5 years after the fact?

  Do you realize that the SPDX cleanup effort is reducing the costs for
  everyone including _all_ of the corporate lawyers you are so concerned
  of?

Sure, complaining about your individual corporate costs is way simpler
than:

   - contributing to community efforts to reduce those costs

   - acknowledging that the community efforts even without contribution
     or your particular organization are reducing those costs

Try again.

> And here's the thing.
> The copyleft-next license has a number of legal issues that make it problematic.
> Not the least of which are that some of its terms are dependent on external
> situations that can change over time, in a matter that is uncontrolled by either
> the licensor or the licensee.  In order to determine what terms are effective, you
> have to know when the license was granted, and what the FSF and OSI approved
> licenses were at various points in time.  You literally have to use the Internet
> Archive wayback machine, and do a bunch of research, to interpret the license terms.
> It is not, as currently constructed, a good license, due to this lack of legal clarity.

And here is the thing:

    Whether you consider it to be a good license or not, does not matter
    in this context.

    The license _IS_ GPLv2 compatible which is even understandable for
    mere mortals, i.e. non lawyers. That's the only relevant point for
    including code under this license into the kernel.

    Your way-back machine argument is beyond hilarious. Guess what the
    folks who try to cleanup the corporate lawyers induced mess in the
    kernel rely on? But that's absolutely not applicable to this
    problem. Why?

        The kernel has very strict rules for licensing today. Any valid
        SPDX tag in a source file has to be accompanied with a
        corresponding machine readable license file.

        This license file is version controlled and if there is a
        dependency on any other license in the context then the
        dependency is also available in the git history.

        So no, you do not need Internet archive for this at all simply
        because if the kernel git history vanishes from the planet
        then this particular licensing problem is the least of your
        worries.

Maybe it's about time to move your corporate lawyers, who are
caught in their own past sins, to the reality of today.

Thanks,

        Thomas
