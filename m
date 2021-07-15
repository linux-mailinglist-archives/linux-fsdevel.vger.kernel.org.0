Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D323C9CC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhGOKhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:37:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:16970 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhGOKhO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:37:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="271634220"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="271634220"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 03:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="452373614"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 03:34:17 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3yh0-00DhHX-P0; Thu, 15 Jul 2021 13:34:10 +0300
Date:   Thu, 15 Jul 2021 13:34:10 +0300
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
Subject: Re: [PATCH v7 1/5] d_path: fix Kernel doc validator complaints
Message-ID: <YPAPIsGkom68R1WR@smile.fi.intel.com>
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210715011407.7449-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715011407.7449-2-justin.he@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 09:14:03AM +0800, Jia He wrote:
> Kernel doc validator complains:
>   Function parameter or member 'p' not described in 'prepend_name'
>   Excess function parameter 'buffer' description in 'prepend_name'

Yup!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: ad08ae586586 ("d_path: introduce struct prepend_buffer")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  fs/d_path.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 23a53f7b5c71..4eb31f86ca88 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const char *str, int namelen)
>  
>  /**
>   * prepend_name - prepend a pathname in front of current buffer pointer
> - * @buffer: buffer pointer
> - * @buflen: allocated length of the buffer
> - * @name:   name string and length qstr structure
> + * @p: prepend buffer which contains buffer pointer and allocated length
> + * @name: name string and length qstr structure
>   *
>   * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
>   * make sure that either the old or the new name pointer and length are
> @@ -108,8 +107,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>   * prepend_path - Prepend path string to a buffer
>   * @path: the dentry/vfsmount to report
>   * @root: root vfsmnt/dentry
> - * @buffer: pointer to the end of the buffer
> - * @buflen: pointer to buffer length
> + * @p: prepend buffer which contains buffer pointer and allocated length
>   *
>   * The function will first try to write out the pathname without taking any
>   * lock other than the RCU read lock to make sure that dentries won't go away.
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


