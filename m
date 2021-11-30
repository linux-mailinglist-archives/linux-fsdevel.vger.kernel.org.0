Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C0462BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 06:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhK3FN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 00:13:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:45905 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233404AbhK3FN2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:13:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="299540189"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="299540189"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 21:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="609003517"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2021 21:09:51 -0800
Date:   Tue, 30 Nov 2021 13:09:51 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, siglesias@igalia.com,
        kernel@gpiccoli.net
Subject: Re: [PATCH 1/3] docs: sysctl/kernel: Add missing bit to panic_print
Message-ID: <20211130050951.GA89318@shbuild999.sh.intel.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-2-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109202848.610874-2-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:28:46PM -0300, Guilherme G. Piccoli wrote:
> Commit de6da1e8bcf0 ("panic: add an option to replay all the printk message in buffer")
> added a new bit to the sysctl/kernel parameter "panic_print", but the
> documentation was added only in kernel-parameters.txt, not in the sysctl guide.
> 
> Fix it here by adding bit 5 to sysctl admin-guide documentation.
 
Thanks for the fix!

Reviewed-by: Feng Tang <feng.tang@intel.com>

- Feng

> Cc: Feng Tang <feng.tang@intel.com>
> Fixes: de6da1e8bcf0 ("panic: add an option to replay all the printk message in buffer")
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 426162009ce9..70b7df9b081a 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -795,6 +795,7 @@ bit 1  print system memory info
>  bit 2  print timer info
>  bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
>  bit 4  print ftrace buffer
> +bit 5: print all printk messages in buffer
>  =====  ============================================
>  
>  So for example to print tasks and memory info on panic, user can::
> -- 
> 2.33.1
