Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A582FE40B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 08:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbhAUHeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 02:34:50 -0500
Received: from verein.lst.de ([213.95.11.211]:59242 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbhAUHe0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:34:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F246467357; Thu, 21 Jan 2021 08:33:43 +0100 (CET)
Date:   Thu, 21 Jan 2021 08:33:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v4 15/18] mm/filemap: Restructure filemap_get_pages
Message-ID: <20210121073343.GH23583@lst.de>
References: <20210121041616.3955703-1-willy@infradead.org> <20210121041616.3955703-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121041616.3955703-16-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:16:13AM +0000, Matthew Wilcox (Oracle) wrote:
> Remove the got_pages label, remove indentation, rename find_page to retry,
> simplify error handling.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
