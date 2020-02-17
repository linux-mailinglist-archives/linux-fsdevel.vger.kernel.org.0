Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37FD161416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 15:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBQOCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 09:02:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBQOCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i4qarw20lvxrlPR62vHBEFB8tnXHI3FU5InVqT9e8ZI=; b=FCAV8shUiXodtxiHo9lP5Bp1pV
        GNBVzj54Ym/CArI5JhJ1T5sH1YWOirYDvtC3DaxPsMUCb/ACYKMpJcExr6sprjRC55DO+GLCaiIKo
        I6jnPaFkzEa0lF3dCq/R69Ayhm4f6szpCMTzPPR3ZmOmJBdqRCa9nRxkWCOS4Fm2+BZt1witgsWJL
        DABWXuZzKBdnnH9bAZ1fzwJQwPKlGJlQt7qiWoNJO0p1eoD5ejZyRPpqKRAyU6OJBuKqoneaw4DH8
        78iAvIXVXakwwKhfvvGpVGgZs+X+7i6RUenVD7GZOEuH5UWa7rprLNr/nPpXDvpl4489S4uM8JXl5
        FUSVvwvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gz4-0005ZI-SL; Mon, 17 Feb 2020 14:02:50 +0000
Date:   Mon, 17 Feb 2020 06:02:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH] iomap: return partial I/O count on error in direct I/O
Message-ID: <20200217140250.GA21246@infradead.org>
References: <20200213192503.17267-1-rgoldwyn@suse.de>
 <20200217131752.GA14490@infradead.org>
 <20200217134417.bxdw4yex5ky44p57@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217134417.bxdw4yex5ky44p57@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 07:44:17AM -0600, Goldwyn Rodrigues wrote:
> > Haven't we traditionally failed direct I/O syscalls that don't fully
> > complete and never supported short writes (or reads)?
> 
> Yes, but I think that decision should be with the filesystem what to do
> with it and not the iomap layer.

But then you also need to fix up the existing callers to do the
conversion.
