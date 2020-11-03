Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62B2A3E03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCHu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:50:26 -0500
Received: from verein.lst.de ([213.95.11.211]:36081 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCHu0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:50:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7370C67373; Tue,  3 Nov 2020 08:50:24 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:50:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 13/17] mm/filemap: Remove parameters from
 filemap_update_page()
Message-ID: <20201103075024.GL8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-14-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:08PM +0000, Matthew Wilcox (Oracle) wrote:
> The 'pos' and 'count' params are no longer used in filemap_update_page()

Shouldn't this go into the patch that removes the usage of the parameters?
