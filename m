Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E4534209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiEYRLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiEYRLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 13:11:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BD9A7E3E;
        Wed, 25 May 2022 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZxWGWDeNIjBTZ3yADnXAVGs8gsX4RbH3lsSPJIQk2xA=; b=NY/GaE0QNpODMGKM+vGMi9TgQ2
        eWPa6Biwv/mD663b20rie6GLJSFWZ6m365AWpE8duk35nt115T/gbvgKRSJdAbXKGNMR68TP+LywH
        GJnoKmJ8kBlchSnkLmNiSMNtvwrttGZZMyU9TZlL1DQFCSxgN70x03EH+pIK+3YaxVjsdb29Pe8XP
        SrdfQR6c5YJldB03qpLN21yuuwjRpSQOeko5SYZMstTOi5LSrCMYS5Q2mZMcPx72lLR53H1eg7sT5
        schNm3faRVcQ8XVU9iJLyrM2B6DPp8z5t3YXMuAGK9QoA8qUAsoffPWE9cl6EVzxRIm9+eGXwb9ev
        8Rmwut0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntuX2-00Bwlx-CJ; Wed, 25 May 2022 17:10:48 +0000
Date:   Wed, 25 May 2022 10:10:48 -0700
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
Message-ID: <Yo5jGMMctUP7i2dI@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87h75g0xbm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h75g0xbm.ffs@tglx>
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

On Mon, May 23, 2022 at 11:10:37PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> > preferred. A summary of benefits why projects outside of Linux might
> > prefer to use copyleft-next >= 0.3.1 over GPLv2:
> >
> <snip>
> >
> > o copyleft-next has a 'built-in or-later' provision
> 
> Not convinced that this is a benefit under all circumstances,

I'll just drop it.

> but that's
> a philosopical problem. The real problem is this:


> > +Valid-License-Identifier: copyleft-next-0.3.1
> 
> and

Why is this an issue?

> > +11. Later License Versions
> > +
> > +    The Copyleft-Next Project may release new versions of copyleft-next,
> > +    designated by a distinguishing version number ("Later Versions").
> > +    Unless I explicitly remove the option of Distributing Covered Works
> > +    under Later Versions, You may Distribute Covered Works under any Later
> > +    Version.
> 
> If I want to remove this option, then how do I express this with a SPDX
> license identifier?

Good question, souinds like generic semantics for SPDX evolution?

  Luis
