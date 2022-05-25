Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC385341A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiEYQoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiEYQoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 12:44:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E2F5B0;
        Wed, 25 May 2022 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vQwYgNKDRgS2qpTyQs3mbz3qErcGxI+LPqEWaO92rGE=; b=n2pZBM60IWPdwz6eOBvZDj4IzM
        2G/vH6A7fion2Y2H0CO8QiYZwTa4ZkjQWoymkrecPQTBZoulZ4zRXE2jD24dmQMx5O5FULR7Fy/I5
        QNBJ568Bxr3tVC2KYMGczArz7q+0Bej5Yg3h0mZ9/n+D7EKdErCWF7yZwT6RMCz/Y5l6/+qvk1bkF
        YkXhLAsIPoqUHWYP7aQONL1yzYWuDD/VBgkLqg6UBy/GCGZQkZuiqfl+o8FSPQ9eFwfBKc+HqUK8D
        v5+SVGfDyoOp1QJYL8KhwJZpZyiMAHSK5L9chqo55Otl6Iu23Ri9goRXZ7Sz0jk4gMdMqIIUCmQpy
        WP+WtZ8g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntu6v-00Bsgf-HW; Wed, 25 May 2022 16:43:49 +0000
Date:   Wed, 25 May 2022 09:43:49 -0700
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
Message-ID: <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87bkvo0wjd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkvo0wjd.ffs@tglx>
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

On Mon, May 23, 2022 at 11:27:34PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> > +    "FSF-Free" means classified as 'free' by the Free Software Foundation.
> > +
> > +    "OSI-Approved" means approved as 'Open Source' by the Open Source
> > +    Initiative.
> 
> copyleft-next is neither nor. Confused...

The terms are used in two clauses:

4. Condition Against Further Restrictions; Inbound License Compatibility
7. Nullification of Copyleft/Proprietary Dual Licensing

IANAL but at least as per my reading, in both cases it is used to refer to
"other licenses", not itself, so I see no issue with that use. If there
is an issue it would be nice to hear more details about it, so that
perhaps new versions of the license can make this clearer somehow, if
not already.

  Luis
