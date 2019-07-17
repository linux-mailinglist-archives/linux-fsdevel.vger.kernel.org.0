Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD16B5BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfGQFDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:03:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=qOqMY/fRxHj1fADDzJPm814yZ
        K2KI97hWSGjGlw7HGxpcCGLY/eiEhatNzu55UTvYmWsP8cAnnI3lOU8Rvo6vYaLLgfr6DgudF2kDg
        nluL6+bCw2upULSNoG0jiOKSqiRqhVZGq0O3BwFD/5PNpKMXTOfAryEEqBBSxsMdiMm1VTbapP55z
        O/aw1uophF9ofzCr90Og5UiJammz9MKAtht/O8FaOlYjp0qBWry5xo5tqW7m7N9ds3t59Q6nBIRRM
        0XsA90oKhJaUPKu+0G5vManNwOL6C3c03p40z0JjrOkrPLgnXgjBKw+wwYgMs8hiDEqx4292YVByS
        4q1G4/Tzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc63-0003Qg-Tk; Wed, 17 Jul 2019 05:03:19 +0000
Date:   Tue, 16 Jul 2019 22:03:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 6/9] iomap: move the buffered IO code into a separate file
Message-ID: <20190717050319.GF7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321359871.148361.5478305811743639876.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321359871.148361.5478305811743639876.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
