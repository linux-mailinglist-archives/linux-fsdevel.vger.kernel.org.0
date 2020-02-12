Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6315A232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgBLHhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:37:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ub35BfmW+M0ifVaTgZWLcs5bakGOi6jawZxfmuy/9mw=; b=loYSMHIEXkZ4SS1mXaXFT0jRwY
        y3MMhj44jsgNvfh+OXQd1HZ8zCWOKzNPn+f5hpJ19+Qw/pnpaYApUZcFoH7EnrtDGeEoZtzzC026J
        /2WzzvrGsbQJx+wXLzliUA3cgZFEyblax5KlpuNNhdA4Apvx12S41UrLMFU8vDXYn31Eyi/49nnX0
        fNzw5kcUKtrIx6rdoXDJlHokiwYRFOFqMygmaG//VaaCHB/0xKWNXPtBOeOYUR/buNd0RnEoeePIn
        vxgbrpS+gh2lk78x3GyJ7LPnZPpSPV6ilA6M/cE/8sUa7Km7CJDPVokbDX9+RgbWWL0/7LaxhJxhF
        4908I7rA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mam-0006GL-VF; Wed, 12 Feb 2020 07:37:52 +0000
Date:   Tue, 11 Feb 2020 23:37:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/25] mm: Unexport find_get_entry
Message-ID: <20200212073752.GC7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:24PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> No in-tree users (proc, madvise, memcg, mincore) can be built as a module.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
