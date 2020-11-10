Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6202ADE30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgKJSYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:24:23 -0500
Received: from verein.lst.de ([213.95.11.211]:36910 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJSYX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:24:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8342667373; Tue, 10 Nov 2020 19:24:21 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:24:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v3 16/18] mm/filemap: Don't relock the page after
 calling readpage
Message-ID: <20201110182417.GG28701@lst.de>
References: <20201110033703.23261-1-willy@infradead.org> <20201110033703.23261-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110033703.23261-17-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:37:01AM +0000, Matthew Wilcox (Oracle) wrote:
> We don't need to get the page lock again; we just need to wait for
> the I/O to finish, so use wait_on_page_locked_killable() like the
> other callers of ->readpage.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
