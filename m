Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21C044A97E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbhKIIpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbhKIIpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:45:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FEBC061764;
        Tue,  9 Nov 2021 00:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GdDi/V7QAih1ySMP6lNBNALRpM6uMtlAa7/wriuKKIQ=; b=t4qYVbkLs6XV+3ZMzgaKIGBLc/
        A111GVlOmbJuUlyRFxObdNTJh28Qg486VZWphJbOhnJmNlVx9pCbFMEvNj7aoN78sZE2OywpBUUnE
        avyRjhxamttPyL5Zr2rmvQ7q1h2sa/vjurTVcnJuOJuCT50wXO3A2W5ONY5KCEhF2GnfRM8umRI0I
        NnK8dgW+S/nCKZT3erQ7M3p14u08IhVdboBhaxlzr253Kxx07eWWLHd5ZWGwaN3Cps83oXXSx3gDM
        vrbsP+FZaZiw30Lk9oIfQV7bo+ZbJWskccJ+9bF6FWyptC1XHoL/54xA6bp97LYnjTlKArLEvRn/1
        2AaBpdjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMhv-0013z1-1m; Tue, 09 Nov 2021 08:42:19 +0000
Date:   Tue, 9 Nov 2021 00:42:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 07/28] fs/buffer: Convert __block_write_begin_int() to
 take a folio
Message-ID: <YYo0awMVcSO7texG@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		get_block_t *get_block)
>  {
> -	return __block_write_begin_int(page, pos, len, get_block, NULL);
> +	return __block_write_begin_int(page_folio(page), pos, len, get_block, NULL);

Overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
