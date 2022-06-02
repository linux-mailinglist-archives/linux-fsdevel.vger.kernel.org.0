Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231453BF01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiFBTlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 15:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiFBTl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:41:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4712E9E8;
        Thu,  2 Jun 2022 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eceey+RredpO1DUpw4XgOlm7hqUoNbIq9MwFfP+irVY=; b=VRfjtgzVIIfFh/6aegPoMJ5pyK
        7gk1arWHebBfVWqJyt7uVOHx6SccEXwTqEY4lmki3xAk/qtzDLUH/1h6P7WkO5+TI+V+WeXu+q1zW
        MKwPhqjFfksjbafDWz/o58AsRSqI3qKUxVt/TG5ZyxlpLgjf4xYG3vQzdOW3Ojhl0/k9BEK7hVPge
        vQQDgt2E+uzU7nGqfhz+pdZ8UvuHHOEjUTBveG1XXbJ7+qD58PscQcpWReyxghMtyCtLvZexlxH5A
        xWrB7CHz3eMGKOSGlDx1LQXODDK1IYdclZ9DSkkwRBSPLbaiNjrWly5+ox1t3zfrMt6ueTradwhiw
        j+OX/Zrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwqgx-0047ut-H1; Thu, 02 Jun 2022 19:41:11 +0000
Date:   Thu, 2 Jun 2022 12:41:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <fontana@sharpeleven.org>,
        "tj@kernel.org" <tj@kernel.org>,
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
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Message-ID: <YpkSV51Pieq7K4x2@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
 <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <871qwhz2aa.ffs@tglx>
 <BYAPR13MB2503DAC31B8B5CC69F8FECD3FDDE9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YphWomPaMdLCa3Pt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YphWomPaMdLCa3Pt@kroah.com>
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

On Thu, Jun 02, 2022 at 08:20:18AM +0200, gregkh@linuxfoundation.org wrote:
> On Thu, Jun 02, 2022 at 04:11:16AM +0000, Bird, Tim wrote:
> > I don't think that the Linux kernel should be used for license promotion, but if it is,
> > then it should be used to promote GPL-v2-only.
> 
> I agree, and in a way, I feel like that is what is happening here for
> this original submission.  See below for more...

I have been using copyleft-next for years and cross polination for me is real.

> I agree, dual licensed code that is added to the kernel is either done:
> 	- because the original code had a non-GPL license and it was
> 	  added so that it could be compatible so that it could be added
> 	  to Linux.
> 	- because the code being accepted into Linux can also be used in
> 	  another non-Linux codebase now or in the future.

Sometimes such cross polination is purely speculative, but we don't
stop and ask people for evidence of this.

You forgot that another reason is because some attorneys like some
permissive license more. That's it. The Clear BSD license is an example.
In that case it was a new license to Linux. So let us be clear that one
could argue that was a bit of license promotion.

> The submission here was neither of these.

You are incorrect.

I have a vision for Linux kernel testing and I have put *years* of
effort in this regard and thinking about architecture behind all this.
So yes cross polination is *extremely* important to me and hence some
of this effort.

  Luis
