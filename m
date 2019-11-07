Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563D5F2980
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 09:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbfKGInU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 03:43:20 -0500
Received: from verein.lst.de ([213.95.11.211]:55785 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfKGInU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:43:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C022A68CEC; Thu,  7 Nov 2019 09:43:17 +0100 (CET)
Date:   Thu, 7 Nov 2019 09:43:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fs: Fix overflow in block_page_mkwrite
Message-ID: <20191107084316.GA9895@lst.de>
References: <20191106190239.20860-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106190239.20860-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:02:39PM +0100, Andreas Gruenbacher wrote:
> On architectures where ssize_t is wider than pgoff_t, the expression
> ((page->index + 1) << PAGE_SHIFT) can overflow.  Rewrite to use the page
> offset, which we already compute here anyway.

Looks good modulo the s/ssize_t/loff_t/ mentioned in the other patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
