Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C83442847
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBH0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhKBH0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:26:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E72CC061714;
        Tue,  2 Nov 2021 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T1H40nh/mkwlggQrI0IOqTfGBu1Ndz+FEpjDr+b/ixA=; b=TYKbOPcP1X8XmJ+b9lJsF2g0un
        NgD6DSCStSrMdngTQKagOq/zZwOq8iUVEc9Ffsj2VPNFlKmt8Ff1+/Gh+p5kshjKILPFQsPS413kG
        ln7atzIEhTd2r8vqkHzVw6cdrLiDWn2nP1tQbi+y7n1YlaqXA7dlNqq3bAfQClDN9Oqkl8j/uOZUX
        SuJhplx3g2yaB6GVIiM6kd0qAS1ZTc4ehMYIR+R7OYW+HlhCW4Nto2xhNkvJx416CrkkmtxH81Okp
        00d92hB5FVgYU6vZrzUHkxzdaBeV1usgF2pwPqShDwSTmV+/0UN0GHm4wRo6oz6bUTqIyqhrjFO+k
        /YZZfktw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho8r-000lp5-JI; Tue, 02 Nov 2021 07:23:33 +0000
Date:   Tue, 2 Nov 2021 00:23:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 17/21] iomap,xfs: Convert ->discard_page to
 ->discard_folio
Message-ID: <YYDndfQ0WIkdcqnz@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:25PM +0000, Matthew Wilcox (Oracle) wrote:
> XFS has the only implementation of ->discard_page today, so convert it
> to use folios in the same patch as converting the API.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
