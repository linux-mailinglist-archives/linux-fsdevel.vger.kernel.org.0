Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41A8170592
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBZRH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:07:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgBZRH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zuKVx+x+d2CRDbmOIHUQcsQ78U8eI2O7e4FcEVHD4ak=; b=jBVHe720Oz4QM93RRxqAXNQ+0L
        hWsUsZNuf4kg3JgIqeGTrjOerzaCcO7/g6K7je+ek18c1KIg7UxZU/PK+NCVRK8Lhl11GYraKadBQ
        j8DC/ExYyXkdNDQ3QANaihJyM5OJMk3BU48kHyDWUtAO6TU3X5oRaproeODcdij1tHX8xtUb5Nyud
        g5p4pNlxRSYPL33pdpP57VC0ee2Z0ra1tzT8bv5CqewJ1zoRCrn1NakUzAnanqvl4ZdiKEp/4saYm
        bGaTczv7VSWTEXBvCl05ml3WPBX3ZXNCUKYhbJfoI4k9LCVnThYNxIZ6x7nxXVdGLr6bGfdC3fPTU
        Vf8uoblA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j70A7-0008Vg-QE; Wed, 26 Feb 2020 17:07:55 +0000
Date:   Wed, 26 Feb 2020 09:07:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 25/25] iomap: Convert from readpages to readahead
Message-ID: <20200226170755.GE22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225214838.30017-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:48:38PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in iomap.  Convert XFS and ZoneFS to
> use it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
