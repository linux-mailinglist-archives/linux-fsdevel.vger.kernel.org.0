Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B82A5B92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 02:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgKDBK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 20:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgKDBK4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:10:56 -0500
Received: from X1 (unknown [208.106.6.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604D122404;
        Wed,  4 Nov 2020 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604452255;
        bh=E7byRLJjd21HleD6szmFkPj5iDpgKBajIkLCUIM5wwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=omYcAWqZ8GWqYjNAGRKotaAc+GB2NZNQaK2b+OfcZieJ7MdXMy46ztUkR5fv4bVnv
         rRX22fiV8YXO1mY0Y4qq+nQUb6jNkV9foJgJEuMvRCk4PZmeMrLKqRqQrhReJ1CMeX
         7c4Ubt+oHidcnHYi53fK0HW9E28gZ22kcgo+jMjY=
Date:   Tue, 3 Nov 2020 17:10:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>
Subject: Re: [PATCH] mm: Fix readahead_page_batch for retry entries
Message-Id: <20201103171054.7d80b3010cac0bee705d0ae7@linux-foundation.org>
In-Reply-To: <20201103142852.8543-1-willy@infradead.org>
References: <20201103142852.8543-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  3 Nov 2020 14:28:52 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Both btrfs and fuse have reported faults caused by seeing a retry
> entry instead of the page they were looking for.  This was caused
> by a missing check in the iterator.

Ambiguous.  What sort of "faults"?  Kernel pagefaults which cause
oopses?

It would be helpful to to provide sufficient info so that a reader of
this changelog can recognize whether this patch might fix some problem
which is being observed.

> Reported-by: David Sterba <dsterba@suse.com>
> Reported-by: Wonhyuk Yang <vvghjk1234@gmail.com>

Perhaps via links to these reports.

> Fixes: 042124cc64c3 ("mm: add new readahead_control API")

So I'm assuming we need a cc:stable, but it isn't yet fully clear?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h

Please don't forget the "^---$" separator, thanks.
