Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA3D3D8460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 02:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhG1AEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 20:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhG1AEK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79AE860F9B;
        Wed, 28 Jul 2021 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627430649;
        bh=CVtEJinMhj+vpS0dGC/FJSBH3tbjVYSpo1t2j7x6Dyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APFPyXj1T7+IwlOacL5ZeFCHaMci+xsdrYC+dJVjlDNaVdVJA6JUVULactRthGlh0
         Zrb876CILloo016O6+Bus/czZk4sihv4X7iFmZT+8/OsmnHZGeZTtbWrmeBQez63hM
         t5Mb/Me5GSnEq0/QMKdcnHrRWUkbYitwkkXORBGZHmabKEVgBDi8U2L92xuYUx09fA
         cf4enWRxT0fK+Yw060P9tUi+dWLnrK3eemqD0zCfsjJT8hTuTU5t+uGOYl04wWmwkO
         4GK4vLg80TOU+WQTDtYn9E5YoBbODEudHGTn9uPEyUWdUgxazX4+w5cJxQToTyJcDw
         0Lq+o1fqCPvrA==
Date:   Tue, 27 Jul 2021 17:04:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] filesystems/locking: fix Malformed table warning
Message-ID: <20210728000409.GE559142@magnolia>
References: <20210727232212.12510-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232212.12510-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:22:12PM -0700, Randy Dunlap wrote:
> Update the bottom border to be the same as the top border.
> 
> Documentation/filesystems/locking.rst:274: WARNING: Malformed table.
> Bottom/header table border does not match top border.
> 
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org

Looks ugly but probably correct
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/locking.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linext-20210727.orig/Documentation/filesystems/locking.rst
> +++ linext-20210727/Documentation/filesystems/locking.rst
> @@ -295,7 +295,7 @@ is_partially_uptodate:	yes
>  error_remove_page:	yes
>  swap_activate:		no
>  swap_deactivate:	no
> -======================	======================== =========
> +======================	======================== =========	===============
>  
>  ->write_begin(), ->write_end() and ->readpage() may be called from
>  the request handler (/dev/loop).
