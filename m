Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395332FE410
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 08:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbhAUHgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 02:36:06 -0500
Received: from verein.lst.de ([213.95.11.211]:59219 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbhAUHcv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:32:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6161A68B05; Thu, 21 Jan 2021 08:32:09 +0100 (CET)
Date:   Thu, 21 Jan 2021 08:32:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v4 11/18] mm/filemap: Convert filemap_update_page to
 return an errno
Message-ID: <20210121073209.GE23583@lst.de>
References: <20210121041616.3955703-1-willy@infradead.org> <20210121041616.3955703-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121041616.3955703-12-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:16:09AM +0000, Matthew Wilcox (Oracle) wrote:
> Use AOP_TRUNCATED_PAGE to indicate that no error occurred, but the
> page we looked up is no longer valid.  In this case, the reference
> to the page will have been removed; if we hit any other error, the
> caller will release the reference.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
