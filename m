Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686032A3DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgKCH21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:28:27 -0500
Received: from verein.lst.de ([213.95.11.211]:35986 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCH21 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:28:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69C6B67373; Tue,  3 Nov 2020 08:28:25 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:28:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 03/17] mm/filemap: Pass a sleep state to
 put_and_wait_on_page_locked
Message-ID: <20201103072825.GC8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-4-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:58PM +0000, Matthew Wilcox (Oracle) wrote:
> This is prep work for the next patch, but I think at least one of the
> current callers would prefer a killable sleep to an uninterruptible one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
