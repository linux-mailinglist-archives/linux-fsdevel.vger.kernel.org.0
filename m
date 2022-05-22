Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873153038E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbiEVOh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346465AbiEVOh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 10:37:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371E3A728;
        Sun, 22 May 2022 07:37:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653230240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5Fe8A93A6DD/J1N/jpffgipxZd+155XlRgjaweWdIE=;
        b=yVhg1amxUWOuwbdcyEaGP+ffz8Ve8j/Cd6tSIS1y6Cgd4v9A8j+peCHGPh2C6xk1fJ+uwL
        mDSOpPpoEzhSpRkci7p0aGh1BVh2GcV0OIxkj5ft3t5OFw8094YkM/3iVeA0A8hsNkTb7Q
        PpCFgh74l5bf/wxDzwyfprw2qRUkCQa3x2ZWj30RadZstSnVhjwPW5yeOcLwZsE/FhxnzA
        Zv64lpw6ZM+gqgiBKxzBq5K14nryyokhvMo5efmYr73y5/omaml6kZ2qoIziTN8Edg6o68
        +GIQcdA8y2nZcJH/LKmEA2A+p0+e3kMXjorM9MQ+AeHnL8Ij3bgwKtI9HYvmlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653230240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5Fe8A93A6DD/J1N/jpffgipxZd+155XlRgjaweWdIE=;
        b=laPnb48NsLJLrQPzN+cLvGDrjuUi2Z2r08uPV5oiF2Nn2R8axKFylC1t1VwGWxm8/LLGLo
        1i//NEMJ/DAl8pAA==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, akpm@linux-foundation.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, keescook@chromium.org, rostedt@goodmis.org,
        minchan@kernel.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
In-Reply-To: <Yao3vtSKBKLyQY1E@kroah.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org> <Yao3vtSKBKLyQY1E@kroah.com>
Date:   Sun, 22 May 2022 16:37:19 +0200
Message-ID: <87fsl1iqg0.ffs@tglx>
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

Greg,

On Fri, Dec 03 2021 at 16:29, Greg KH wrote:
> On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:

sorry for missing this thread. I came accross it now as I'm looking into
the licensing mess again.

>> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
>
> Again, sorry, but no, I am going to object to this license as you are
> only accessing a GPL-v2-only api.  Any other license on a file that
> interacts with that, especially for core stuff like testing the
> functionality of this code, needs to have that same license.  Sorry.

That's a bogus argument. First of all the code is dual licensed and
second we have enough code in the kernel which is licensed MIT/BSD and
happily can access the GPL-v2-only APIs.

Aside of that we have already code in the kernel which is dual licensed

     GPL-2.0-or-later OR copyleft-next-0.3.1

We just can't make it SPDX clean because copyleft-next-0.3.1 is not in
LICENSING.

While I agree that we want to keep the number of licenses as small as
possible, we cannot really dictate which dual licensing options a
submitter selects unless the license is GPL-2.0-only incompatible, which
copyleft-next is not.

Can we just get over this, add the license with the SPDX identifier and
move on?

Thanks,

        tglx
