Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76502FE411
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 08:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbhAUHgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 02:36:17 -0500
Received: from verein.lst.de ([213.95.11.211]:59243 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbhAUHeq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:34:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3765168B05; Thu, 21 Jan 2021 08:34:04 +0100 (CET)
Date:   Thu, 21 Jan 2021 08:34:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v4 16/18] mm/filemap: Don't relock the page after
 calling readpage
Message-ID: <20210121073403.GI23583@lst.de>
References: <20210121041616.3955703-1-willy@infradead.org> <20210121041616.3955703-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121041616.3955703-17-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:16:14AM +0000, Matthew Wilcox (Oracle) wrote:
> We don't need to get the page lock again; we just need to wait for
> the I/O to finish, so use wait_on_page_locked_killable() like the
> other callers of ->readpage.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
