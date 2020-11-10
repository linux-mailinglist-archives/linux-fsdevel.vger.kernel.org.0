Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701CB2ADE1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgKJSU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:20:26 -0500
Received: from verein.lst.de ([213.95.11.211]:36877 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJSUZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:20:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1CFE67373; Tue, 10 Nov 2020 19:20:22 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:20:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v3 02/18] mm/filemap: Remove dynamically allocated
 array from filemap_read
Message-ID: <20201110182022.GA28701@lst.de>
References: <20201110033703.23261-1-willy@infradead.org> <20201110033703.23261-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110033703.23261-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:36:47AM +0000, Matthew Wilcox (Oracle) wrote:
> Increasing the batch size runs into diminishing returns.  It's probably
> better to make, eg, three calls to filemap_get_pages() than it is to
> call into kmalloc().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
