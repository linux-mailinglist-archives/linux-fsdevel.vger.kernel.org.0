Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC12A9124
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKFIVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:21:54 -0500
Received: from verein.lst.de ([213.95.11.211]:50596 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKFIVy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:21:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7619E68B05; Fri,  6 Nov 2020 09:21:52 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:21:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 16/18] mm/filemap: Don't relock the page after
 calling readpage
Message-ID: <20201106082152.GJ31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-17-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:42:17PM +0000, Matthew Wilcox (Oracle) wrote:
> We don't need to get the page lock again; we just need to wait for
> the I/O to finish, so use wait_on_page_locked_killable() like the
> other callers of ->readpage.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

although I still think a little comment would not hurt.
