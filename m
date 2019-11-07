Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDDF2986
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 09:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfKGIoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 03:44:11 -0500
Received: from verein.lst.de ([213.95.11.211]:55791 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfKGIoL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:44:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4983468B05; Thu,  7 Nov 2019 09:44:09 +0100 (CET)
Date:   Thu, 7 Nov 2019 09:44:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iomap: Fix overflow in iomap_page_mkwrite
Message-ID: <20191107084409.GB9895@lst.de>
References: <20191106190400.20969-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106190400.20969-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:04:00PM +0100, Andreas Gruenbacher wrote:
> On architectures where ssize_t is wider than pgoff_t, the expression
> ((page->index + 1) << PAGE_SHIFT) can overflow.  Rewrite to use the page
> offset, which we already compute here anyway.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good except for the ssize_t vs loff_t in the changelog:

Reviewed-by: Christoph Hellwig <hch@lst.de>
