Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99D73B16AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFWJUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:20:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:42447 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJUC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:20:02 -0400
IronPort-SDR: jmwZUDAdN25eL1wZQG7qOPjcJ/At9TuVpq1iz0GUfcTyozkOLTgppSRCQJRuIXDxqNF+ARey3Y
 A66O8qDYG7Xg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228794024"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="228794024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:17:42 -0700
IronPort-SDR: gQnBrP65T+lz6S8763w2muAHovH5yPToGcJVeWeReg4kEPK7IEnSCpeWNe1kG4NAi+IJoL2Cqa
 +yxtijtof93Q==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="639395294"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:17:38 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvz0o-004hdo-En; Wed, 23 Jun 2021 12:17:34 +0300
Date:   Wed, 23 Jun 2021 12:17:34 +0300
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
Subject: Re: [PATCH v2 0/4] make '%pD' print the full path of file
Message-ID: <YNL8LlRLhr6Iq/OK@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055011.22916-1-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:50:07PM +0800, Jia He wrote:
> Background
> ==========
> Linus suggested printing the full path of file instead of printing
> the components as '%pd'.
> 
> Typically, there is no need for printk specifiers to take any real locks
> (ie mount_lock or rename_lock). So I introduce a new helper
> d_path_unsafe() which is similar to d_path() except it doesn't take any
> seqlock/spinlock.
> 
> This series is based on Al Viro's d_path() cleanup patches [1] which
> lifted the inner lockless loop into a new helper. 
> 
> Test
> ====
> The cases I tested:
> 1. print '%pD' with full path of ext4 file
> 2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
>    with '%pD'
> 3. all test_print selftests, including the new '%14pD' '%-14pD'
> 4. kasprintf
> 
> TODO
> ====
> I plan to do the followup work after '%pD' behavior is changed.
> - s390/hmcdrv: remove the redundant directory path in printing string.
> - fs/iomap: simplify the iomap_swapfile_fail() with '%pD'.
> - simplify the string printing when file_path() is invoked(in some
>   cases, not all).
> - change the previous '%pD[2,3,4]' to '%pD'
>    
> Changelog
> =========
> v2:

Should be v6 now. So, next v7, otherwise you confuse bots and people.

My remark was for you for the future submission, this one is already spoiled.

> - refine the commit msg/comments (Andy)
> - pass the validator check by "make C=1 W=1"
> - add the R-b for patch 4/4 from Andy

-- 
With Best Regards,
Andy Shevchenko


