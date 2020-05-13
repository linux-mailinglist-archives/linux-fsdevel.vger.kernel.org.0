Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B281D0F53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgEMKHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbgEMKHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:07:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F23C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XVYeZfx6K3WGxKVwW/YhiZBKS3kiBql0CsXTNE4SvQA=; b=WJ76JCzXQxHa3seKYplSClz8cE
        bqdV02dZ5TDdnI3rj6RnHlmUYSVSmk44WReR0ERhBsZssT1Fx+ilxhovIFU33RLa4eoegQLrU+Uhz
        QVfYSNx6QToz9goZ9gbecGAa4gLNxPihLU3xN4UOsdc+gp1FZVD+ykky1cZ/GaoE+fAN34zaTl1xy
        Gz8pIbagCu4+WC7bSarhqCOPjWP1hl/sCxCzcsB1hy2jdAuXq7Nb6xNbxQWBGAP97pEj+kDaSQ0YB
        4eZ10YcR/nlg9e76CKRBp/d+uFHEVaNco8xU/TSfN08Sd9ElGWxNnUN01Y21xQYC0PBnZs/wr43Ld
        d3qz6p5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoIJ-0005iD-JN; Wed, 13 May 2020 10:07:19 +0000
Date:   Wed, 13 May 2020 03:07:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/12] vfs: don't parse "silent" option
Message-ID: <20200513100719.GJ7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-13-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-13-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:15AM +0200, Miklos Szeredi wrote:
> Parsing "silent" and clearing SB_SILENT makes zero sense.
> 
> Parsing "silent" and setting SB_SILENT would make a bit more sense, but
> apparently nobody cares.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Looksgood,

Reviewed-by: Christoph Hellwig <hch@lst.de>
