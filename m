Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49922FE418
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 08:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbhAUHgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 02:36:51 -0500
Received: from verein.lst.de ([213.95.11.211]:59214 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbhAUHch (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:32:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C924767357; Thu, 21 Jan 2021 08:31:50 +0100 (CET)
Date:   Thu, 21 Jan 2021 08:31:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v4 09/18] mm/filemap: Change filemap_read_page calling
 conventions
Message-ID: <20210121073150.GD23583@lst.de>
References: <20210121041616.3955703-1-willy@infradead.org> <20210121041616.3955703-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121041616.3955703-10-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:16:07AM +0000, Matthew Wilcox (Oracle) wrote:
> Make this function more generic by passing the file instead of the iocb.
> Check in the callers whether we should call readpage or not.  Also make
> it return an errno / 0 / AOP_TRUNCATED_PAGE, and make calling put_page()
> the caller's responsibility.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
