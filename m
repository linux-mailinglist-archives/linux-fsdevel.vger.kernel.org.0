Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269566B5B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfGQE7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 00:59:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQE7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=S02wYMUqMbhtM4gLEWW1vKm1l
        m8zTjJdKCrbXhr4PdnKZ5qVzFzc4chkPPfmWviL9wKRlYC52tdmgilSZNMKZoAR8VtxQ/XTh5awgV
        7uvPAmLX22m6j4C1s3DXSXk6SBRGTfJ1nScWRyUSH3ZVOgZ1FDsSqJ+5ZuK1HSjdgfMIaADanE4Mu
        b9Pl5X0Gzglb8M5H/jcxtEaVyndPs1jV1oPlKAXj2lZNvZIpKdBTOh9RwJYGWxMTrMJRzD9zXEL+i
        Db3zQ14fEcZR/7EBMhGWF8hgxikM26jrwEToTpKMYgiqQOKkr5IFDUmcpqS8u+c8ROcnqVGRKJL2R
        U6KJ5AvLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc2h-0001wW-TA; Wed, 17 Jul 2019 04:59:51 +0000
Date:   Tue, 16 Jul 2019 21:59:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 3/9] iomap: move the file mapping reporting code into a
 separate file
Message-ID: <20190717045951.GC7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321357958.148361.3663936110731905790.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321357958.148361.3663936110731905790.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
