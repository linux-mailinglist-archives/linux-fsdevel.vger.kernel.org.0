Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E208A442856
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKBHaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhKBHaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:30:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6373C061714;
        Tue,  2 Nov 2021 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jdm/QBCB3g1mmJmo3Y5N27+U79DUnPMJE6rhgiuJeX0=; b=Z7etUTuTju2oDlMKEiX4s0kJpf
        B2esI9f+uvMXU2fUe6fgqt9ziwtsLlTa3sJkSbugeqLWOllE6Qn+5J0+fcPRUJ/j6WQzilTmE1fbT
        ls8CCrGlX++thzTp89ZF3SzSlvguKetzT2O+RCo01JznRx1lPkeWsoATfPDJIVwh4pxsnYZRsxXl+
        xviAfxZfvH/G7IKe0tjjLU/n6Jptu47dJ+nYzkFaKDPihbqtMWkPwi7UGvcAH9Ckny6EGqk3hpKSK
        zCB7gkPVHtiYnUSzD2GWKQXIgmiw1GiMfY8qkYifJXkkbj50cnsRgFwnbhqeXC76FD5AR329/L/ew
        5gS+/kpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhoCj-000mMz-W0; Tue, 02 Nov 2021 07:27:33 +0000
Date:   Tue, 2 Nov 2021 00:27:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 20/21] iomap: Support multi-page folios in invalidatepage
Message-ID: <YYDoZSxpBMOQfbql@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:28PM +0000, Matthew Wilcox (Oracle) wrote:
> If we're punching a hole in a multi-page folio, we need to remove the
> per-folio iomap data as the folio is about to be split and each page will
> need its own.  If a dirty folio is only partially-uptodate, the iomap
> data contains the information about which blocks cannot be written back,
> so assert that a dirty folio is fully uptodate.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
