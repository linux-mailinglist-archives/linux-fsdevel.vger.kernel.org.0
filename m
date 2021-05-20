Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3390238A0B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhETJV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 05:21:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:26865 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhETJV1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 05:21:27 -0400
IronPort-SDR: LW+HI2QSrRyZTkJt8quQWRUZkV69/XMC18ydqOxEqYXu7sFJqT7KJiotz6lDPHENAT5u+Mcbsw
 HTBUGfU/evWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="222265499"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="222265499"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:20:04 -0700
IronPort-SDR: D9tFDRabU8LkRDjtkf+DxCKaIENTndI7pYZSuQu6DfX7cPNkp698kwjW15pbXtxjKQUQwNicQ+
 Ou8ZWaZUI04A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395631467"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:19:59 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ljeqS-00DRbU-2L; Thu, 20 May 2021 12:19:56 +0300
Date:   Thu, 20 May 2021 12:19:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/14] d_path: make prepend_name() boolean
Message-ID: <YKYpvFg3WQe7svpI@smile.fi.intel.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-8-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376607691168C132AB2F558F72A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376607691168C132AB2F558F72A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 09:12:34AM +0000, Justin He wrote:

> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Fix it.

-- 
With Best Regards,
Andy Shevchenko


