Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4C2A90FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKFIHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:07:18 -0500
Received: from verein.lst.de ([213.95.11.211]:50517 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFIHS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:07:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74F7468C4E; Fri,  6 Nov 2020 09:07:16 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:07:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 02/18] mm/filemap: Remove dynamically allocated
 array from filemap_read
Message-ID: <20201106080715.GB31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:42:03PM +0000, Matthew Wilcox (Oracle) wrote:
> Increasing the batch size runs into diminishing returns.  It's probably
> better to make, eg, three calls to filemap_get_pages() than it is to
> call into kmalloc().

Yes, this always looked weird.

Reviewed-by: Christoph Hellwig <hch@lst.de>
