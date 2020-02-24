Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCA16B2BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBXVhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:37:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXVhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nX5VslAb9aYoRq0onwDHGJTJ67RlRcQ5wURtwjQgsok=; b=X8jrNEtXW298x3gA4/IDu/10Ny
        1ViCr7MxaOAVAjf+Zay51p9ufyNNeifHWxRgfL7eg/f6/9IGK8yNGMSs5mcRTo4GJfD5Oha50wx9X
        RoWUPQWYyRqvieERC9AWCihjU8tiBSlNZrctgEXFVEsQK7++p7wCg2aKVkS1CvjpiIwt9Ve8v+vRf
        D7/k++eIpijcp7XpCFPS+rlPj4VcVAUYvWzvnFBPmlk7Gt3lfaziHMCRv1B2QDfMJQkNJcugtekWK
        xrNSMkT+9Wb9QLRQJEabeqGGgvvnwCrUQqnrBXNB6655cSxapzIfAzu7myQkdoaNjUxv8uHXRfmBc
        zL8XhDxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LPe-0005je-RR; Mon, 24 Feb 2020 21:37:14 +0000
Date:   Mon, 24 Feb 2020 13:37:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 08/24] mm: Remove 'page_offset' from readahead loop
Message-ID: <20200224213714.GE13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:47PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Replace the page_offset variable with 'index + i'.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
