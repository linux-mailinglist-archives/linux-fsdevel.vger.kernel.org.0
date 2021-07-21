Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713923D10E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhGUNbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:31:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53570 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGUNbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:31:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B66C2034F;
        Wed, 21 Jul 2021 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626876701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+cGFAAgYbKbT/oKXMw/ioitanAoRkhilVXc2hZdhdW8=;
        b=RgDS4OQ+hznjaeTtYSs1ZNgR+KxBce/K5tVZmU7qSR5FpMrQihjiBojlwE6X7X38abCWNT
        pHCyD0yayR9+4TYtX/5jX5vOSMIYaVwFjLvYpPC91NII6c9aB81YKg1NXCYER8zSFmp9CQ
        IE5u31TlViWbyfdfL9mk8u2Mz67VUUk=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75FC2A3B8A;
        Wed, 21 Jul 2021 14:11:41 +0000 (UTC)
Date:   Wed, 21 Jul 2021 16:11:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com
Subject: Re: [PATCH v7 0/5] make '%pD' print the full path of file
Message-ID: <20210721141141.ehnnneafnwezqnk6@pathway.suse.cz>
References: <20210715011407.7449-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715011407.7449-1-justin.he@arm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2021-07-15 09:14:02, Jia He wrote:
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
> TODO
> ====
> I plan to do the followup work after '%pD' behavior is changed.
> - s390/hmcdrv: remove the redundant directory path in printing string.
> - fs/iomap: simplify the iomap_swapfile_fail() with '%pD'.
> - simplify the string printing when file_path() is invoked(in some
>   cases, not all).
> - change the previous '%pD[2,3,4]' to '%pD'
>    
> Jia He (4):
>   d_path: fix Kernel doc validator complaints
>   d_path: introduce helper d_path_unsafe()
>   lib/vsprintf.c: make '%pD' print the full path of file
>   lib/test_printf.c: add test cases for '%pD'
> 
> Rasmus Villemoes (1):
>   lib/test_printf.c: split write-beyond-buffer check in two

The patchset is ready for linux-next from my POV.

I could take it via printk tree if Al provides Acks for the
first two "d_path: *: patches.

Or Al could take it via his tree if he would prefer to do so.

Best Regards,
Petr
