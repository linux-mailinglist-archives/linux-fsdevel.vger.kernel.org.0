Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBB2ADE28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgKJSXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:23:00 -0500
Received: from verein.lst.de ([213.95.11.211]:36895 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJSW7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:22:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C28467373; Tue, 10 Nov 2020 19:22:58 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:22:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v3 13/18] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201110182257.GD28701@lst.de>
References: <20201110033703.23261-1-willy@infradead.org> <20201110033703.23261-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110033703.23261-14-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:36:58AM +0000, Matthew Wilcox (Oracle) wrote:
> Move the complicated condition and the calculations out of
> filemap_update_page() into its own function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
