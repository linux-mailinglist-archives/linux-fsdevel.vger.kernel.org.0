Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED38A44280E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKBHSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhKBHSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:18:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C348C061714;
        Tue,  2 Nov 2021 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=LPha+na88e5TzHtb+WK+Zno5yz
        1aHZRoGJR1vgmsEtP3K/2+TGm/sY3OYhUa6z8Me9feb7jhWo4ELLqC9faXPgmeyw8vC3k1hzj2DbH
        IrAq9USqfn0v0cO7xzlr/FPFYSj2dYP7T6hKABt6fMrgQdzKSBDka933auf8uYcUANCX0+H35h+5N
        JquuNQanJi0soKcTi2b3xdOA/NbbZfmHyL64KgRKPzrjGUbwX0ToGcAUQBenu5mehAbcTo120/vlf
        G3SZYXjdwWgD0PqWoQB7av30s2TsAPge63xPexTOC3ZsMFtpyymy57qeR7JORx/zma1D6RikNHUOE
        1o9Btgtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho1Y-000kPf-UP; Tue, 02 Nov 2021 07:16:00 +0000
Date:   Tue, 2 Nov 2021 00:16:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/21] iomap: Pass the iomap_page into
 iomap_set_range_uptodate
Message-ID: <YYDlsP+ZUiyp90SU@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
