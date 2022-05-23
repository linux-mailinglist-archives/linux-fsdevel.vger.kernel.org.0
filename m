Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02BD531DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiEWV2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiEWV2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:28:52 -0400
X-Greylist: delayed 5226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 14:28:51 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089C0A2056;
        Mon, 23 May 2022 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0TgBdWDrgCwk3/yiVL4MjST4OruMage9l2vL9QRHrUI=; b=DEPNVraFW2DF3xnuijyQYottQI
        EnzvrRqNHh6tdFjrww5RoRUiKbcMnwDONbrvvay2nocBtbdlpj6vOkSk82OCn6LO7yGqjCa8mTFGP
        1unIyHtE8ceJZphYFwv/RAGJlsR00fpL9uMACN/7kz1yKM+SaopXnXn2N8S2BWamZqidXlSYrSRip
        SeO/AzJLndNbm5diDt1KOmBF9QNaXiIzfF8s4Hsc0kdDE8d4/C4LDjg0wp7xajO+12IWm11+S82S0
        iNRZBktO0eWh7LwCLFJaFhPmwY4Zym97HGYjIhdxL77wFwVNWNWiCitM3w+m18cmGkLIBUsLUQVuu
        mIRJ0BAA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntDrR-005iLS-B4; Mon, 23 May 2022 19:37:01 +0000
Date:   Mon, 23 May 2022 12:37:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tj@kernel.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        keescook@chromium.org, rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
Message-ID: <YoviXT37FAUqpQEu@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org>
 <Yao3vtSKBKLyQY1E@kroah.com>
 <87fsl1iqg0.ffs@tglx>
 <YopM5XGMdqVCU+bL@kroah.com>
 <87czg5ip2z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czg5ip2z.ffs@tglx>
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

On Sun, May 22, 2022 at 05:06:44PM +0200, Thomas Gleixner wrote:
> On Sun, May 22 2022 at 16:47, Greg KH wrote:
> > On Sun, May 22, 2022 at 04:37:19PM +0200, Thomas Gleixner wrote:
> >> On Fri, Dec 03 2021 at 16:29, Greg KH wrote:
> >> 
> >> While I agree that we want to keep the number of licenses as small as
> >> possible, we cannot really dictate which dual licensing options a
> >> submitter selects unless the license is GPL-2.0-only incompatible, which
> >> copyleft-next is not.
> >> 
> >> Can we just get over this, add the license with the SPDX identifier and
> >> move on?
> >
> > From what I recall, I had technical reasons I didn't take this series,
> > but that was a long time ago and I would be glad to review it again if
> > it were rebased and resubmitted after the next merge window is closed.
> 
> The license addition and the SPDX identifier cleanup should be seperated
> from the new test code which was part of the series.

I'll send a re-spin after the merge window and split this up.

And FWIW, AFAICT I addressed all the comments, so I can resend after
the spdx stuff gets merged so to make the series easier to read /
review.

  Luis
