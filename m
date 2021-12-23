Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10D647DF88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhLWHZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbhLWHZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:25:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D65C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=zebS0051+nnrFUab4VMHTW8geD
        l3XE9ba7DC0o7v5p++imoenbPzExiYACvtXzalyBlTiF0/y/B7ricyfi+K9ktyIstZ5efC5MZCpd/
        gbEarrW6ruqzWEp2ihzQGc3wTvulYWDLOZjWgtWn6OXi0EIfJC0hOgr1cMs1RMzbbl83d4gWzK4Ov
        uBOrhmUE4uyJfNqobNOfwgxHI7Gn7RGZQfipAmmtCepm4iQvEEGsS74e8a1Yp+olb6m0qCCgkjuuZ
        bc9pc1edbbtqncSBw68hfLcywy5tOGQOeJ49RZj1304Hd5HLeTFTbTQC+KGgLAqglkU8AY1tkN1xP
        uTwGF/dg==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0ITj-00By77-GO; Thu, 23 Dec 2021 07:25:32 +0000
Date:   Thu, 23 Dec 2021 08:25:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 24/48] filemap: Convert filemap_fault to folio
Message-ID: <YcQkaNpDeYnAe0RM@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
