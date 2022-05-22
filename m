Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF35530394
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbiEVOrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiEVOrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 10:47:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75253B556;
        Sun, 22 May 2022 07:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6425EB80B34;
        Sun, 22 May 2022 14:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79041C34116;
        Sun, 22 May 2022 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653230825;
        bh=a51gBxNLQofvnXQvPGeOGUPwx0lk0XSHXB1iH2PIOOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhG2/aPgybnxURcEG+DiHKUS0uSfkYwWODY7z7R7GBjXCLCeAwGUMMr5jaSMCU/10
         YGxNlwBDUW6zChFgTRxXVFApSBz/YvLQeFOu04lEPG4DGYOIl4gGj6KQlW5lBUgC3b
         DpAuEAMGf0tIZ+YL3nwobmU/47/9EkDeda8dncBE=
Date:   Sun, 22 May 2022 16:47:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        keescook@chromium.org, rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
Message-ID: <YopM5XGMdqVCU+bL@kroah.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org>
 <Yao3vtSKBKLyQY1E@kroah.com>
 <87fsl1iqg0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsl1iqg0.ffs@tglx>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 04:37:19PM +0200, Thomas Gleixner wrote:
> Greg,
> 
> On Fri, Dec 03 2021 at 16:29, Greg KH wrote:
> > On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:
> 
> sorry for missing this thread. I came accross it now as I'm looking into
> the licensing mess again.
> 
> >> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> >
> > Again, sorry, but no, I am going to object to this license as you are
> > only accessing a GPL-v2-only api.  Any other license on a file that
> > interacts with that, especially for core stuff like testing the
> > functionality of this code, needs to have that same license.  Sorry.
> 
> That's a bogus argument. First of all the code is dual licensed and
> second we have enough code in the kernel which is licensed MIT/BSD and
> happily can access the GPL-v2-only APIs.
> 
> Aside of that we have already code in the kernel which is dual licensed
> 
>      GPL-2.0-or-later OR copyleft-next-0.3.1
> 
> We just can't make it SPDX clean because copyleft-next-0.3.1 is not in
> LICENSING.
> 
> While I agree that we want to keep the number of licenses as small as
> possible, we cannot really dictate which dual licensing options a
> submitter selects unless the license is GPL-2.0-only incompatible, which
> copyleft-next is not.
> 
> Can we just get over this, add the license with the SPDX identifier and
> move on?

From what I recall, I had technical reasons I didn't take this series,
but that was a long time ago and I would be glad to review it again if
it were rebased and resubmitted after the next merge window is closed.

thanks,

greg k-h
