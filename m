Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61E3B07A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhFVOn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:43:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:21429 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhFVOn4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:43:56 -0400
IronPort-SDR: 4q8jBg3OzPoi6SDV5nlefjbb7iIUucBBE3t1EVMsxeaHVMyYnbsmNexzz/R5C3UheK2MgICuPo
 WswDY/VSsROA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="270912498"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="270912498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:41:39 -0700
IronPort-SDR: D0TgOxHz7vjeNIF82vRPSn4mBD8aa7i11oQRY+c3CiLeKlwJRI9SwkqpZI+twzK4Mjt8abRRdM
 REl5eNYH5Qrg==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="406347546"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:41:33 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvhai-004Uof-Q5; Tue, 22 Jun 2021 17:41:28 +0300
Date:   Tue, 22 Jun 2021 17:41:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
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
Subject: Re: [PATCH v5 4/4] lib/test_printf.c: add test cases for '%pD'
Message-ID: <YNH2mDwgsd5r+1Xs@smile.fi.intel.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-5-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622140634.2436-5-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:06:34PM +0800, Jia He wrote:
> After the behaviour of specifier '%pD' is changed to print the full path
> of struct file, the related test cases are also updated.
> 
> Given the full path string of '%pD' is prepended from the end of the scratch
> buffer, the check of "wrote beyond the nul-terminator" should be skipped
> for '%pD'.
> 
> Parameterize the new using_scratch_space in __test, do_test to skip the

__test()

> test case mentioned above,

-- 
With Best Regards,
Andy Shevchenko


