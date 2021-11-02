Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8589244283F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhKBHYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhKBHYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:24:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AECC061714;
        Tue,  2 Nov 2021 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=25t4zGWpnw8HHNkC0Ciojz5cGe
        ti9g4ociK4hf+75KkOzX7IBHFJsgz3ZD8vJuEAB38C4GqgFWSiCbbc2UEyArXmjk39eVcEL6xrz4+
        EF7fLV5hLStXTfXbvlDB0mrM+laaIWHUMsolzgum0pbIXRCT7TeGE0GrKuAdl8UN1WYYRcrw8VVkt
        7SrrbewqcnT0DZlh3N3gMcwAUF6V+aL4vonrPpg1ZLcXtH1xZi7xkQIdoap/kzrfaUOBYxaux7sut
        uqt0eTugASXBfVzkwxR32wvekmHj+OgkdMhtJCTSysYJt2yH5OjdUAYka7WdEAdFcbZJ4HNWVJkt5
        iy2g7GrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho7U-000lUc-5r; Tue, 02 Nov 2021 07:22:08 +0000
Date:   Tue, 2 Nov 2021 00:22:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/21] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YYDnIO/oQxlAxxXg@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
