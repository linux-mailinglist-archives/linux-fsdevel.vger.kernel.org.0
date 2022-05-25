Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB694534713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbiEYXyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 19:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEYXyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 19:54:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B69D070;
        Wed, 25 May 2022 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4fKDERpiICSOVgCQ8QwCarZ+nXg0XUnq0ATowURuHc=; b=dzwK7kFgMsM4dtgzFXJxmWXZFa
        u+Q7RFwB4jvwWWz8PwBDLQpHj4ZK0YGZiyHU+lI4x2bdXw5XdPK1jJ4rxeSbi0iM9LtMiUjwiCMGK
        sk07Lf4YOWErKZDftjL5EUS6bSB+I4To98jq/cbHVJYzq336XwpuNwFstUEWVUW911uW9NiZh86Dl
        glQIo5lGtlpAyKujL6jZzNtS5izUCyWSs8RcUticJXAxL0UBNTsem/IXOFrXk02tosz4FEzKSD99r
        HjN3iYpVp6vLptw5OEzyRio/9aMzIA5bMm9QOG5QhrN7Gz3D7nlgWgRVNkbVz4ahCkN4/pjws9RbT
        LUmv21/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu0pC-00CynK-Py; Wed, 25 May 2022 23:53:58 +0000
Date:   Wed, 25 May 2022 16:53:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Richard Fontana <fontana@sharpeleven.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        jeyu@kernel.org, shuah@kernel.org, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
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
Message-ID: <Yo7Blhgke3WhZSLe@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87ee0k0wrn.ffs@tglx>
 <Yo5f9nctTwHZqPbl@bombadil.infradead.org>
 <874k1dz674.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k1dz674.ffs@tglx>
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

On Wed, May 25, 2022 at 10:51:43PM +0200, Thomas Gleixner wrote:
> On Wed, May 25 2022 at 09:57, Luis Chamberlain wrote:
> > On Mon, May 23, 2022 at 11:22:36PM +0200, Thomas Gleixner wrote:
> >> This paragraph is not really understandable for Joe Developer.
> >> 
> >>   copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
> >>   can therefore be used for kernel code. Though the best and recommended
> >>   practice is to express this in the SPDX license identifier by
> >>   licensing the code under both licenses expressed by the OR operator.
> >> 
> >> Hmm?
> >
> > Let me try clarifying this further, how about:
> >
> >    copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
> >    can therefore be used for kernel code. Despite this, if you use
> >    copyleft-next-0.3.1 on Linux, the recommended practice is to express
> >    dual licensing with GPL using in the SPDX license identifiers by
> >    using by the OR operator.
> 
>   'using in the ..' ?
> 
> and
> 
>   'by using by' is off by one 'by' :)
> 
> I'm not seeing how that clarifies stuff further. I might be biased, but
> the version I suggested is crystal clear.

Oh sorry, I didn't realize the paragraph you posted was a suggestion, I
thought it was the one you were indicating needed further enhancement!

I'll just take yours then.

> >> > +  To use the copyleft-next-0.3.1 license put the following SPDX tag/value
> >> > +  pair into a comment according to the placement guidelines in the
> >> > +  licensing rules documentation:
> >> > +    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
> >> > +    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
> >> > +    SPDX-License-Identifier: GPL-2.0+ OR copyleft-next-0.3.1
> >> > +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> >> 
> >> Please don't propagate the GPL-2.0 and GPL-2.0+ tags. They are
> >> outdated (still valid) in the SPDX spec, which reminds me that I should
> >> update the relevant documentation...
> >
> > OK thanks for the recommendation, I'll leave it at:
> >
> > +    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
> 
> 	SPDX-License-Identifier: GPL-2.0-only OR copyleft-next-0.3.1
> 
> please. See my previous reply quoted above.
> 
> > +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

Sorry I hadn't had my coffee yet so I should only list:

SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

Will do this on the next spin.

  Luis
