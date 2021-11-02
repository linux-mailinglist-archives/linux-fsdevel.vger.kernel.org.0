Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256E44427FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKBHQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKBHQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:16:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EAC061714;
        Tue,  2 Nov 2021 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=wgt3hyvUHi+RGezG0HS3YweUTe
        xBclpStejmpPmH5GoR5N0h3zbZoHfrcXKs++Vv06oXbw4ITLh1RzvaDT+5NTNOFGWxpS0+0jg7Q4P
        uoawAkEF3IvOrikMkYkHXXvcbJ57o2l7IFP6h5R3VhhM3ezgRBEUZdwWkxf1MavWAgHEfwgU55mU/
        o4yVyiXoWMgvuNVkA3KZDGmuU8E7e1/9oWmLpAsNQVP9yG6d4Bgfzg3mjweWlO3veMryCvnOkpx9Q
        FQ0xUUTOCuj7jLKOoFZwR0W70i14bM02ApF6u6GvdMdjZ+WV1xP+9mSXUO7/VPUMqRLTfjENGJAUA
        eIf8YqRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnzf-000jtA-Q5; Tue, 02 Nov 2021 07:14:03 +0000
Date:   Tue, 2 Nov 2021 00:14:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/21] iomap: Convert iomap_page_create to take a folio
Message-ID: <YYDlO1hbSUxl4kQg@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
