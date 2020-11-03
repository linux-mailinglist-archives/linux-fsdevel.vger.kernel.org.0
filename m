Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AC2A3DB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgKCHbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:31:48 -0500
Received: from verein.lst.de ([213.95.11.211]:36003 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCHbs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:31:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C56567373; Tue,  3 Nov 2020 08:31:47 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:31:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 06/17] mm/filemap: Don't call ->readpage if IOCB_WAITQ
 is set
Message-ID: <20201103073146.GF8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-7-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:01PM +0000, Matthew Wilcox (Oracle) wrote:
> The readpage operation can block in many (most?) filesystems, so we
> should punt to a work queue instead of calling it.  This was the last
> caller of lock_page_async(), so remove it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
