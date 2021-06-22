Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0803B079B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhFVOmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:42:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:26400 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFVOmS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:42:18 -0400
IronPort-SDR: +/aXxwOX+E7u/bNUYFvIZ4pzNF/ESvT/wDCARkhRpX1ntbdDVl4LAcohs3THsZ4F/LobBZtSyJ
 1Q3r2JudbeRA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228621337"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="228621337"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:40:02 -0700
IronPort-SDR: emBQV5XIc1/KaJ/O0NcCGaGXgBFS8dFGi9PMnXOuirCNUUetfSCQIAffEdnfX+QSlF9iY6fho8
 t+dXuC8ahIwA==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="473791317"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:39:59 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvhZC-004Uni-Sn; Tue, 22 Jun 2021 17:39:54 +0300
Date:   Tue, 22 Jun 2021 17:39:54 +0300
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
Subject: Re: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Message-ID: <YNH2OsDTokjY1vaa@smile.fi.intel.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622140634.2436-3-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:06:32PM +0800, Jia He wrote:
> Previously, the specifier '%pD' is for printing dentry name of struct
> file. It may not be perfect (by default it only prints one component.)
> 
> As suggested by Linus [1]:

Citing is better looked when you shift right it by two white spaces.

> A dentry has a parent, but at the same time, a dentry really does
> inherently have "one name" (and given just the dentry pointers, you
> can't show mount-related parenthood, so in many ways the "show just
> one name" makes sense for "%pd" in ways it doesn't necessarily for
> "%pD"). But while a dentry arguably has that "one primary component",
> a _file_ is certainly not exclusively about that last component.
> 
> Hence change the behavior of '%pD' to print the full path of that file.
> 
> Precision is never going to be used with %p (or any of its kernel
> extensions) if -Wformat is turned on.

> Link: https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/ [1]


> 

Shouldn't be blank lines in the tag block. I have an impression that I have
commented on this already...

...

> -last components.  %pD does the same thing for struct file.
> +last components.  %pD prints full file path together with mount-related

I guess you may also convert double space to a single one.

> +parenthood.

-- 
With Best Regards,
Andy Shevchenko


