Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE12FA738
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405319AbhARRPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:15:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:14256 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407000AbhARROA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:14:00 -0500
IronPort-SDR: jgT180sITbFf52JiqHuI4q6lmZlm2IUsKw/p1SihYf/PickUfAgARdLr14yXZCosTKcS6tf0ax
 wifQlR1mT4NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="166494841"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="166494841"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:13:12 -0800
IronPort-SDR: LzA/uh7JspkW3LdbsSeABYObh+4WRAiQX2209NaAyRjhwUCi4zb+QwtkGd47mDVIzHIo/KmNdU
 VK3n3lxAiA1Q==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="402103087"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:13:09 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1l1Y6V-002OAi-1j; Mon, 18 Jan 2021 19:14:11 +0200
Date:   Mon, 18 Jan 2021 19:14:11 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-mm <linux-mm@kvack.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] [v2] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for
 unhashed addresses
Message-ID: <20210118171411.GG4077@smile.fi.intel.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210116220950.47078-2-timur@kernel.org>
 <CAHp75Vdk6y8dGNJOswZwfOeva_sqVcw-f=yYgf_rptjHXxfZvw@mail.gmail.com>
 <b39866a4-19cd-879b-1f3e-44126caf9193@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39866a4-19cd-879b-1f3e-44126caf9193@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:57:55AM -0600, Timur Tabi wrote:
> On 1/18/21 4:03 AM, Andy Shevchenko wrote:
> > On Sun, Jan 17, 2021 at 12:12 AM Timur Tabi <timur@kernel.org> wrote:

...

> > Any user of this? (For the record, I don't see any other mail except this one)

> It's patch #2 of this set.

I haven't got that one.

> They were all sent together.

Apparently not to me.

> http://lkml.iu.edu/hypermail/linux/kernel/2101.2/00245.html
> 
> Let me know what you think.

Makes sense. Hint: use lore.kernel.org references as they are much better in
terms of provided features and patch representation.

...

> > >          DUMP_PREFIX_NONE,
> > >          DUMP_PREFIX_ADDRESS,
> > > -       DUMP_PREFIX_OFFSET
> > > +       DUMP_PREFIX_OFFSET,
> > > +       DUMP_PREFIX_UNHASHED,
> > 
> > Since it's an address, I would like to group them together, i.e. put
> > after DUMP_PREFIX_ADDRESS.
> 
> I didn't want to change the numbering of any existing enums, just in case
> there are users that accidentally hard-code the values.  I'm trying to make
> this patch as unobtrusive as possible.

But isn't it good to expose those issues (and fix them)?

...

> > Perhaps even add _ADDRESS to DUMP_PREFIX_UNHASHED, but this maybe too
> long.
> 
> I think DUMP_PREFIX_ADDRESS_UNHASHED is too long.

What about introducing new two like these:

	DUMP_PREFIX_OFFSET,
	DUMP_PREFIX_ADDRESS,
	DUMP_PREFIX_ADDR_UNHASHED,
	DUMP_PREFIX_ADDR_HASHED,

and allow people step-by-step move to them?

-- 
With Best Regards,
Andy Shevchenko


