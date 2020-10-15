Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B628F7EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgJOR4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 13:56:21 -0400
Received: from verein.lst.de ([213.95.11.211]:32878 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbgJOR4T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:56:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14ED368B02; Thu, 15 Oct 2020 19:56:17 +0200 (CEST)
Date:   Thu, 15 Oct 2020 19:56:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/13] fs: Allow a NULL pos pointer to __kernel_write
Message-ID: <20201015175616.GA23287@lst.de>
References: <20201003025534.21045-1-willy@infradead.org> <20201003025534.21045-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003025534.21045-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 03, 2020 at 03:55:22AM +0100, Matthew Wilcox (Oracle) wrote:
> Linus prefers that callers be allowed to pass in a NULL pointer for ppos
> like new_sync_write().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
