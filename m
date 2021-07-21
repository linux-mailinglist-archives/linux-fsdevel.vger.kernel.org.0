Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB373D10D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhGUN0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:26:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbhGUN0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:26:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 56BD722542;
        Wed, 21 Jul 2021 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626876413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsBzF8jN6NkkFCtTA12oeFWwTLn6/eVWsX76X7VzP+U=;
        b=rkv4HriYmi/G6EV+FgmomCR0saofJFi/1sJHoVk2OVGerczwdVgjPMq4FJ5CUOtJOTfVHC
        0m5U8ulPfqOHo6inPq6PxKAjmnC+fte+d1vkOf+7MBHeSRQ1fnWylHzCIyeWjFgtefP5HU
        Ri7WRjG6BZUSlMV6N08TgCP/+w7rId4=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45390A3B8B;
        Wed, 21 Jul 2021 14:06:52 +0000 (UTC)
Date:   Wed, 21 Jul 2021 16:06:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com
Subject: Re: [PATCH v7 5/5] lib/test_printf.c: add test cases for '%pD'
Message-ID: <20210721140649.6luuiujudf7snoi6@pathway.suse.cz>
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210715011407.7449-6-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715011407.7449-6-justin.he@arm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2021-07-15 09:14:07, Jia He wrote:
> After the behaviour of specifier '%pD' is changed to print the full path
> of struct file, the related test cases are also updated.
> 
> Given the full path string of '%pD' is prepended from the end of the scratch
> buffer, the check of "wrote beyond the nul-terminator" should be skipped
> for '%pD'.
> 
> Parameterize the new using_scratch_space in __test(), do_test() and wrapper
> macros to skip the test case mentioned above,
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
