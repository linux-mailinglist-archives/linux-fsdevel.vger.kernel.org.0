Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38244427F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhKBHQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhKBHQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:16:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89370C061714;
        Tue,  2 Nov 2021 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iyPiD06oTEYjUMmdxNC2ui2Auz/y/Iufvmou1ZG+EvU=; b=2Z9yv9wGv98CEqYYbUvfpEB0TT
        rVUichQgFJ2n1a0ugMlmDEYB1wUbpGA0sSJoYMzW7HdX/6eMP9+1CAZ0aG+z0mLzYrofImZheF82K
        g1qQzdiyQy/UThv6UzgQOXSefyPoIjdeFIbdimXtkD2brEPor4b/dWPTWFJWVRB42BKrhAozVKpRo
        tRipzEmb2swrMh1Pji8PmMdB/tCMP/HWqXm370VntdFo+8xQqfoaizddQG/oj0Iz3a3D7H3IS334f
        qdNoi+cfpu69R8zI3/DQOi7j5yrnzBXMSiH5IehIdXkLlJkim8o7WO+M8g474Amlnc1+4TGqYSMgS
        v2qhOdiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnz0-000jd7-Dg; Tue, 02 Nov 2021 07:13:22 +0000
Date:   Tue, 2 Nov 2021 00:13:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/21] block: Add bio_for_each_folio_all()
Message-ID: <YYDlEmcpkTrph5HI@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:11PM +0000, Matthew Wilcox (Oracle) wrote:
> +static inline
> +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)

Please fix the weird prototype formatting here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
