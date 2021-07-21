Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20D3D0C0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhGUJHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235712AbhGUJEk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6C5760BD3;
        Wed, 21 Jul 2021 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860676;
        bh=5i/qmH4alWxdVkgDs3KPdq+gTt6IvLSVBOVfIwtm4gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAe1e8+kTwckG36+6Jis6ef/X+PQSooe63JLr55JIdETVNpOBpMbajyKdqt+JrIbt
         Y8WtR3oFxZeIiY9X3QewX/BTAzyqqWAxXjcjkBEsx8d2a7fwgmqt87sO52LlXsTfqW
         03x8r1EHfR1AZh33SdEd3wBWiVjH2U9K8S8e7wY6fvGmZXKt+zLovWvKLtaFD7gKEo
         bWtRRC4N1Aciu3Cw48BULTU2qHnkOiuTeUxyGHg/fmjSrtLMd3JrSLwZIwtXhX15HU
         nAxle0NVtQ5izaPSILmkhqy+0CjRZVq+c6Xzvd9IGECf/X2vbVNsAO98vGUa8hqlQV
         9HqiUnPXy7Ccg==
Date:   Wed, 21 Jul 2021 12:44:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 031/138] fs/netfs: Add folio fscache functions
Message-ID: <YPfsfawVEs+S5wI6@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-32-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:17AM +0100, Matthew Wilcox (Oracle) wrote:
> Match the page writeback functions by adding
> folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
> folio_wait_fscache_killable().  Remove set_page_private_2().  Also rewrite
> the kernel-doc to describe when to use the function rather than what the
> function does, and include the kernel-doc in the appropriate rst file.
> Saves 31 bytes of text in netfs_rreq_unlock() due to set_page_fscache()
> calling page_folio() once instead of three times.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  Documentation/filesystems/netfs_library.rst |  2 +
>  include/linux/netfs.h                       | 75 +++++++++++++--------
>  include/linux/pagemap.h                     | 16 -----
>  3 files changed, 50 insertions(+), 43 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
