Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA33B2CE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFXKwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 06:52:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:35377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232191AbhFXKwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:52:08 -0400
IronPort-SDR: w2IF1V6UF0o+iSWS7neQO8zQEvB9dSUnXtYcNzNYMfrlpEuOAXX/UHtdqi1rcc0T+04gJTGNp1
 y8gBkbtQoMxw==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="204438803"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="204438803"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 03:49:49 -0700
IronPort-SDR: bloUs6MTuopNNLA1Xl4hUG6pB2P7g9WQuQTLWQKu4SZmVZ3c4WP5g+1xC3v1QQDtzb2ljbVg9o
 IHTrS/tto6Ug==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="487710028"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 03:49:43 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lwMvT-004yd4-Bm; Thu, 24 Jun 2021 13:49:39 +0300
Date:   Thu, 24 Jun 2021 13:49:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jia He <justin.he@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v2 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Message-ID: <YNRjQ5dJpSYWbbRP@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-3-justin.he@arm.com>
 <YNRJ61m6duXjpGrp@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNRJ61m6duXjpGrp@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:01:31AM +0200, Petr Mladek wrote:
> On Wed 2021-06-23 13:50:09, Jia He wrote:

...

> > If someone invokes snprintf() with small but positive space,
> > prepend_name_with_len() moves or truncates the string partially.
> 
> Does this comment belong to the 1st patch?
> prepend_name_with_len() is not called in this patch.
> 
> > More
> > than that, kasprintf() will pass NULL @buf and @end as the parameters,
> > and @end - @buf can be negative in some case. Hence make it return at
> > the very beginning with false in these cases.
> 
> Same here. file_d_path_name() does not return bool.

It was my (apparently unclear) suggestion either to move it here, or be
rewritten in generic way as you suggested in the other thread.

-- 
With Best Regards,
Andy Shevchenko


