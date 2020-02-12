Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE57C15A21D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgBLHe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:34:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLHe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VxRUapHd7o/hPw0/UoJoo3K3tLVDD3iUiQQ+YB+fPrU=; b=OqCYBmBVgZgY2PVrufwv58UlCA
        e+gVjjox/snuJ/bOm/aXA7TljNw4yq8StckvefQVj9cnX2lfVUvtbcxLLKHzEmQ0XdPUBNK5y228v
        4AIUFcFEx8cTkHRynBy9jPFLPJcQU7yQo6978V89mjkJutdx6T4bzl1jchS93B8oNX/KC8Iia1VdD
        uvL0xSRjO6GOhkrgVwrgTJwgvpgT1lVkS25py7QDJ1Hru9JAY+98dtDw5ULGuAm/2FhiUHT9QR3rV
        aTlLegX/iWzNNsz2b9/xZFspNczK3TYOwIE1gw7LD/qVgMuvt0RjOSEIrnjK8VME9zZrat5zHVGlB
        on3Ahb+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mXu-0003wy-H1; Wed, 12 Feb 2020 07:34:57 +0000
Date:   Tue, 11 Feb 2020 23:34:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 01/25] mm: Use vm_fault error code directly
Message-ID: <20200212073454.GB7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:21PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use VM_FAULT_OOM instead of indirecting through vmf_error(-ENOMEM).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
