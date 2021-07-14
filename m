Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED63C8142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhGNJUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 05:20:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:62308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhGNJUI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:20:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="207296715"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="207296715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 02:17:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="494122677"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 02:17:13 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3b0s-00DFlH-HQ; Wed, 14 Jul 2021 12:17:06 +0300
Date:   Wed, 14 Jul 2021 12:17:06 +0300
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
Subject: Re: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Message-ID: <YO6rkgKpca/Z0LtH@smile.fi.intel.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
 <YNL6jcrN42YjDWpB@smile.fi.intel.com>
 <AM6PR08MB4376C83428D8D5F61C0BF3F2F7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <AM6PR08MB4376DB011A86FCD8C76FE80DF7139@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376DB011A86FCD8C76FE80DF7139@AM6PR08MB4376.eurprd08.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 08:33:10AM +0000, Justin He wrote:
> > From: Justin He
> > Sent: Thursday, June 24, 2021 1:49 PM
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Wednesday, June 23, 2021 5:11 PM
> > > On Wed, Jun 23, 2021 at 01:50:08PM +0800, Jia He wrote:

...

> > > > +	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
> > >
> > > I have commented on the comment here. What does it mean for mere reader?
> > >
> > 
> > Do you suggest making the comment "/* ^^^ */" more clear?

Yes.

> > It is detailed already in prepend_name_with_len()'s comments:
> > > * Load acquire is needed to make sure that we see that terminating NUL,
> > > * which is similar to prepend_name().

-- 
With Best Regards,
Andy Shevchenko


