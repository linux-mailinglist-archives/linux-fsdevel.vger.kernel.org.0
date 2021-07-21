Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49A3D104C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhGUNPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:15:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhGUNPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:15:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4A9620341;
        Wed, 21 Jul 2021 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626875744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d2zL4DSMxxgusCwerQYFit51RZdm7XIpv5GcoSHdjTc=;
        b=k41ZNBw3GYqRYI9O1VKZjSxUOz2zBx+Bp+E+Nz9zW7n8bXxAVTwiYAaGH73jrLMynem9Ji
        nNQvCmYsb7AdauDaq7kR9oSaQ4aVPKIgUynRW1ea8F7jdq7NzNBYwUVyF2pECfarNjpDhj
        tZeaGuigE2yUMqO09pxLu/N6JsmB0yo=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47F1EA3B83;
        Wed, 21 Jul 2021 13:55:44 +0000 (UTC)
Date:   Wed, 21 Jul 2021 15:55:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v7 3/5] lib/vsprintf.c: make '%pD' print the full path of
 file
Message-ID: <20210721135544.w4blqsvcyr42sxcb@pathway.suse.cz>
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210715011407.7449-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715011407.7449-4-justin.he@arm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2021-07-15 09:14:05, Jia He wrote:
> Previously, the specifier '%pD' was for printing dentry name of struct
> file. It may not be perfect since by default it only prints one component.
> 
> As suggested by Linus [1]:
>   A dentry has a parent, but at the same time, a dentry really does
>   inherently have "one name" (and given just the dentry pointers, you
>   can't show mount-related parenthood, so in many ways the "show just
>   one name" makes sense for "%pd" in ways it doesn't necessarily for
>   "%pD"). But while a dentry arguably has that "one primary component",
>   a _file_ is certainly not exclusively about that last component.
> 
> Hence change the behavior of '%pD' to print the full path of that file.
> It is worthy of noting that %pD uses the entire given buffer as a scratch
> space. It might write something behind the trailing '\0' but never write
> beyond the scratch space.
> 
> Precision specifier is never going to be used with %p (or any of its
> kernel extensions) if -Wformat is turned on.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/ [1]
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jia He <justin.he@arm.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
