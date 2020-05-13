Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3441D0F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbgEMKGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbgEMKGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:06:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDACC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0U1v+kkNYsA1U52Siacs/bMpeC1sD++B/1kLBVF24wA=; b=fZOtChekDqKfLH9crd2sLf0grm
        tkXYDLueKVHi8I+FwtNzpyg6e+MPgmiEOle+OMWCcAPrjLy+p5cOi1xeRjp2d6D/hBPeBrtg2Td9c
        k+eo2PGh1S3K6EGg5br1KXV/n2ZyVAO+Z+NO5ZV18Q1Iey7u4TCw055GDvEGvFV3vH+aiLZeMcP6k
        yNHFqS9JyCkRSaltvZg6bIf+euQkYCGG3agjPsx27ld4/ZWI7PJxjsMI7jWHGPfK5634vFe6riuoS
        ZPlOLv+mvlcvMIQGCS+oTCXXXmZayFYvYRn2ibjgoVd01NfCL+VCUskkxgX1qGXHzPKW+KG97AhEe
        K4Y0wkzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoHl-0005gE-3z; Wed, 13 May 2020 10:06:45 +0000
Date:   Wed, 13 May 2020 03:06:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/12] vfs: don't parse forbidden flags
Message-ID: <20200513100645.GH7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-11-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-11-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:13AM +0200, Miklos Szeredi wrote:
> Makes little sense to keep this blacklist synced with what mount(8) parses
> and what it doesn't.  E.g. it has various forms of "*atime" options, but
> not "atime"...

Yes, this list looks pretty strange.

Reviewed-by: Christoph Hellwig <hch@lst.de>
