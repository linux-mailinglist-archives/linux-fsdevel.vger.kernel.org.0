Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97375341CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbiEYQ5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiEYQ5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 12:57:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A769BAD0;
        Wed, 25 May 2022 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pd4ZKHsCuwHbRpUVf7SH7T6MocnoUW1wyZlaf+DhBgw=; b=rbb/t1Gya+2NhoVAtcLM6UX02v
        9hSw7P9l2AHuQYsheLBHoMrfI69aZHUlfQN98ERH4tTZL+jhd/NJewBbLwDWlIEf6CdcF74g3mWs7
        JpyH+hxaqbUAkh7kNuX+A8EccNBsGHLEGLe/XA9HJtNywrQqfnwhdYt1MnVGMkCwAArix0iB7BwIP
        JhK3LD+ofrn2jYClqvFG3Jl/z7QWjDs//HmPO4JsrKuC5d11qmNUKWBH0XXwJQAvnjg1UebVR09Sz
        +4xUUPz8c0rqxG2RDHC2LZhaBlFa/X+P3bQwNf12i9hf0nhE0Si/8juf1oam66p0rw5dbwSHU2FaL
        irUGiZZg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntuK6-00BuIT-QJ; Wed, 25 May 2022 16:57:26 +0000
Date:   Wed, 25 May 2022 09:57:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <fontana@sharpeleven.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        keescook@chromium.org, rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Message-ID: <Yo5f9nctTwHZqPbl@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87ee0k0wrn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee0k0wrn.ffs@tglx>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 11:22:36PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> > --- /dev/null
> > +++ b/LICENSES/dual/copyleft-next-0.3.1
> > @@ -0,0 +1,237 @@
> > +Valid-License-Identifier: copyleft-next-0.3.1
> > +SPDX-URL: https://spdx.org/licenses/copyleft-next-0.3.1
> > +Usage-Guide:
> > +  This license can be used in code, it has been found to be GPLv2 compatible
> > +  by attorneys at Redhat and SUSE, however to air on the side of caution,
> 
> air ?

Hehe, thanks I'll fix in the next spin.

> > +  it's best to only use it together with a GPL2 compatible license using "OR".
> 
> This paragraph is not really understandable for Joe Developer.
> 
>   copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
>   can therefore be used for kernel code. Though the best and recommended
>   practice is to express this in the SPDX license identifier by
>   licensing the code under both licenses expressed by the OR operator.
> 
> Hmm?

Let me try clarifying this further, how about:

   copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
   can therefore be used for kernel code. Despite this, if you use
   copyleft-next-0.3.1 on Linux, the recommended practice is to express
   dual licensing with GPL using in the SPDX license identifiers by
   using by the OR operator.

> > +  To use the copyleft-next-0.3.1 license put the following SPDX tag/value
> > +  pair into a comment according to the placement guidelines in the
> > +  licensing rules documentation:
> > +    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
> > +    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
> > +    SPDX-License-Identifier: GPL-2.0+ OR copyleft-next-0.3.1
> > +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> 
> Please don't propagate the GPL-2.0 and GPL-2.0+ tags. They are
> outdated (still valid) in the SPDX spec, which reminds me that I should
> update the relevant documentation...

OK thanks for the recommendation, I'll leave it at:

+    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
+    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

  Luis
