Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481D23A36C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFJWDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhFJWDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:03:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D19C061574;
        Thu, 10 Jun 2021 15:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S5fFWXHOH3qnl9bDgtifUgmrEc7Yp/mILWxuXKd81zM=; b=dTkdoSYXGIfl73JJUOk6P0Zo0T
        PiV77J4copLFuyFaalKN859LP9+tUwTrvrm/TCAOguzwUMBsoGRE4NDu9WEj5b9j/mEQ6YZkShd55
        7nQ9flfmc5SoP1rFGYvmmljlO2wq7lHdYWpmMS68JS2CJqV+YipKYl78srK+/EYJB+D+ygcTI8za4
        Xt0k84xaPlyWx02qTCu7xrRK428/Nk+fkfRsQ4QeRdFjmgrgB31Z9kqXtQGJjG0B7YtP9ATyXq08I
        F/PvmCibwBXG0BTFTE6goabcVYxY0OeS/qhbIbRx6q+xhHSEZIfVFQC+9N4aYap6MjlEJqV4/2xqg
        N6R38/Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lrSjr-0028yE-RS; Thu, 10 Jun 2021 22:01:31 +0000
Date:   Thu, 10 Jun 2021 23:01:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: remove mention of "crc" cpio format support
Message-ID: <YMKLs8kgUbz2oSdp@casper.infradead.org>
References: <20210610214525.13891-1-ddiss@suse.de>
 <20210610214525.13891-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610214525.13891-3-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:45:25PM +0200, David Disseldorp wrote:
> @@ -40,9 +40,9 @@ grammar, where::
>  
>  
>  In human terms, the initramfs buffer contains a collection of
> -compressed and/or uncompressed cpio archives (in the "newc" or "crc"
> -formats); arbitrary amounts zero bytes (for padding) can be added
> -between members.
> +compressed and/or uncompressed cpio archives (in the "newc" format);
> +arbitrary amounts zero bytes (for padding) can be added between
> +members.

"arbitrary amounts of zero bytes", but even that doesn't sound quite
right.  Maybe "arbitrary amount of zero-byte padding between members"?

