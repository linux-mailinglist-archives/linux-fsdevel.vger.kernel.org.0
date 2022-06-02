Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D253BECE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiFBTbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiFBTbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:31:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258ED7679;
        Thu,  2 Jun 2022 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gzVpT7tOB20um8Lkk3V4vLLMTLk2RQ4leayk+zil6B0=; b=VmtYS/+PA6EtkXyQ9KDc3JlqVz
        XJS73NSZvA1NejDs0tTStnuzCXtiR3jsHGfvfsNzhn5jIpiNZD7wQHgGrlAyHFgm2jJAhBGUuDSfy
        0Bp+iNEZNatkR+sck4YbaQeDaC6tvyk96V9ixKZ7sdPRFg/d56c8BFUVvBTUgkVq6jLP9aDxfJsKT
        yBEXSgn6eTUQxiFKVqqBXPifFQYQZPsr3WVPIixI70wvxIn0HAA55YxBdCvU7chuQdcrDJRCcwH6t
        XupPMYjGPe8Jwc/0ZRDy5l3fgYkcYENyC6wi82we+9arz8wh9gv8RbxmZQBgtHfpyBwPDedxNURFY
        rpEgSWbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwqWw-0046MO-7D; Thu, 02 Jun 2022 19:30:50 +0000
Date:   Thu, 2 Jun 2022 12:30:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <fontana@sharpeleven.org>,
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
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Message-ID: <YpkP6kExQcQZd2/O@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
 <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <871qwhz2aa.ffs@tglx>
 <BYAPR13MB2503DAC31B8B5CC69F8FECD3FDDE9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503DAC31B8B5CC69F8FECD3FDDE9@BYAPR13MB2503.namprd13.prod.outlook.com>
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

On Thu, Jun 02, 2022 at 04:11:16AM +0000, Bird, Tim wrote:
> I don't think that the Linux kernel should be used for license promotion, but if it is,
> then it should be used to promote GPL-v2-only.

I already *used* copyleft-next on Linux on a dual licensed manner, the
patches in question are about using SPDX to simpllify things and adaopt
the SPDX annotations.

And, to re-iterate once more, I'm using copyeft-next as that is *my*
license of choice for *any* new software projects I use and I want to enable
cross prolination between them. I have been doing this since I wrote
CRDA many years ago. I have many reasons for using copyleft-next and I've
listed many of the reasons why a free software developer would care to enable
this cross polination but yet again you seem to be disregarding all that.

This is similar to how 2-cluase BSD is compatible with the GPL
and is used for cross polination to BSDs even though in practice
a lot of that cross polination may not happen.

There are practical uses here and I've been using this license for years now
and I have no intention on stopping.

  Luis
