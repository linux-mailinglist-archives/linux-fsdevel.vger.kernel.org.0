Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B36B5B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfGQE7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 00:59:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQE7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mKfZ8UVTAJ5Xm4KKNFd/QH18z
        dsIFHTw6lCipxA82SOBGa3ClPNdTrsEpTE14ocuT3J7SedUILHOTPCxs4IodaloCwG05zBRM5hZgu
        uRBrFCrCAmXKKEzwjzcf9ajmG8C1vLHudeYzLs2P9/Sl2zFPVIZ8bORZkbP88SC0XdyMCMYrisbhu
        E/hcFKR34k7bbxAw0jp1YiInNyQs4dPTjQZWo9yqJ+W9EmSjZJQ9QdHf/VrnSh8HV5c2mLWBh1sFJ
        iAInMq2fy4yUSacTjMZo1qbV5ARPfKIBSKMFgGQLqG7coTWOBlty8AoKcDeBQPg6WPRIyLzqlNza3
        cF9T0BCSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc2R-0001v5-2s; Wed, 17 Jul 2019 04:59:35 +0000
Date:   Tue, 16 Jul 2019 21:59:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 2/9] iomap: move the swapfile code into a separate file
Message-ID: <20190717045935.GB7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321357313.148361.12301737644937245852.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321357313.148361.12301737644937245852.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
