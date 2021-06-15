Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5D3A78F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFOIV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:21:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:42149 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFOIV0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:21:26 -0400
IronPort-SDR: S2qHGS77UfT2DfsWk9lCSCz6sRTmBSgC9hLfM/joYT++v6StAhtObcPTJ9C8u2VjxYFjqRDYle
 hZgf42WLHfJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205904582"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="205904582"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 01:19:21 -0700
IronPort-SDR: Olkw6z4fiz+gyu28336Axd1RWoyW1OLqxuG5K+u8s6XkfGkXy+wEytgBgVByyIIb2AQKY+6Fmu
 3/NrWcFtewRA==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="621281055"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 01:19:18 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lt4Hy-002SbW-Od; Tue, 15 Jun 2021 11:19:14 +0300
Date:   Tue, 15 Jun 2021 11:19:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Message-ID: <YMhigpkyU+a6eqB5@smile.fi.intel.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com>
 <YMd5StgkBINLlb8E@alley>
 <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <55513987-4ec5-be80-a458-28f275cb4f72@rasmusvillemoes.dk>
 <AM6PR08MB4376DCEC0F689A5736597B40F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376DCEC0F689A5736597B40F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:56:01AM +0000, Justin He wrote:
> > From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Sent: Tuesday, June 15, 2021 3:48 PM
> > On 15/06/2021 09.07, Justin He wrote:

> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Just a reminder that you still have this footer that prevents (some) people to
respond to your messages.

-- 
With Best Regards,
Andy Shevchenko


