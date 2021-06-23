Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3FC3B1686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFWJPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:15:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:62359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhFWJPI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:15:08 -0400
IronPort-SDR: 0Ax3ZcRkDUV0NZ/iK54yUUoS/lOv3TKGLbWjewVI2/iSotjiClY9YvdDT4MabbWJa1XbGDZb1m
 +O2uj8GAkxEA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="187608058"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="187608058"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:12:41 -0700
IronPort-SDR: LUgIbKZ6f1Tkkgr/GVxI7wzz+qfxJ/nIxHt/00xPofIV3CQbqD3Bj9eRkt3mx+PEpm1HLCGoER
 IfRqg4kG81uQ==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="452965804"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:12:37 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvyvx-004hao-2B; Wed, 23 Jun 2021 12:12:33 +0300
Date:   Wed, 23 Jun 2021 12:12:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin He <Justin.He@arm.com>
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>
Subject: Re: [PATCH v5 0/4] make '%pD' print the full path of file
Message-ID: <YNL7Aft1EXJ9cyMC@smile.fi.intel.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <YNH3C6P9i7xvapav@smile.fi.intel.com>
 <AM6PR08MB437633FB7FDF81D8F1A96DCAF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB437633FB7FDF81D8F1A96DCAF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 04:13:03AM +0000, Justin He wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday, June 22, 2021 10:43 PM
> > On Tue, Jun 22, 2021 at 10:06:30PM +0800, Jia He wrote:

...

> > > v5:
> > > - remove the RFC tag
> > 
> > JFYI, when we drop RFC we usually start the series from v1.
> > 
> > > - refine the commit msg/comments(by Petr, Andy)
> > > - make using_scratch_space a new parameter of the test case
> > 
> > Thanks for the update, I have found few minor things, please address them
> > and
> > feel free to add
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> 
> I assume I can add your R-b to patch 4/4 "add test cases for '%pD'" instead of
> whole series, right?

It was against cover letter, means to cover the whole series, but since you do
not address my comments, do not apply to the patches we have not settled down
on.

-- 
With Best Regards,
Andy Shevchenko


