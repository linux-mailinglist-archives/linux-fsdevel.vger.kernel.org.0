Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4223B6755
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhF1RNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:13:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:58065 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbhF1RNE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:13:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="229618165"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="229618165"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:10:21 -0700
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="557638784"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:10:15 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lxulu-0065LO-Em; Mon, 28 Jun 2021 20:10:10 +0300
Date:   Mon, 28 Jun 2021 20:10:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Justin He <Justin.He@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: [PATCH 09/14] d_path: introduce struct prepend_buffer
Message-ID: <YNoCciPja5NqOMF0@smile.fi.intel.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376D92F354CD17445DC4EC1F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <f9908c77-77e2-03fd-25a4-f7ce9802535e@metux.net>
 <AM0PR08MB4370B5A85FFDD36D79DE73E2F7069@AM0PR08MB4370.eurprd08.prod.outlook.com>
 <eedc09ed-f13a-8a08-4e3a-83b2382d43cc@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedc09ed-f13a-8a08-4e3a-83b2382d43cc@metux.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 06:42:48PM +0200, Enrico Weigelt, metux IT consult wrote:
> > > this smells like a generic enough thing to go into lib, doesn't it ?
> > > 
> > Maybe, but the struct prepend_buffer also needs to be moved into lib.
> > Is it necessary? Is there any other user of struct prepend_buffer?
> 
> Don't have a specific use case right now, but it smells like a pretty
> generic string function. Is already having more than one user a hard
> requirement for putting something into lib ?

Why it should be in the lib/? Do we have users of the same functionality
already? The rule of thumb is to avoid generalization without need.


-- 
With Best Regards,
Andy Shevchenko


