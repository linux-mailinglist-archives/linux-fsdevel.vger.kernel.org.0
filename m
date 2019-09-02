Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D7A55FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfIBM2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:28:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfIBM2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F00YZR20OKS9hpCy+NmnvPb/a9hMj2df+foI3LrwsI0=; b=Ei9IagKy4eiTF1pBi0Lf/vIfL
        S+xgDHBkxR+1oKoyugKczja5koHUZDuTb/ZLi20pCuPakSbdEQhMtKQbs8tn711wLvPAtKUsThQMD
        s5GcniBuXJlw1gZjDilvtU/iNyWffavjNO+25PQN//pNmOGwq+UN8Nx3PE1Zsvbh5G+11m/QVf7RW
        HJ3pklGCjX6lqeIKZtj10IV86p8psVVqorn5V0oKiECXxb59+TDJ6qOwa4JOjhCSX+LwL5vK54Kzn
        mHZ+y/8hkhw7J7aAI4AIfd1FWIzYzoUNKlAF8pkn4FCgzoczmje/U9O6TNeGZ4dR4yBqicJu2A/XF
        ItEvhs2aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lRB-00049w-8b; Mon, 02 Sep 2019 12:28:01 +0000
Date:   Mon, 2 Sep 2019 05:28:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 18/21] erofs: add "erofs_" prefix for common and short
 functions
Message-ID: <20190902122801.GP15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-19-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-19-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks.  I don't have a tree with all these applies, but please make
sure this covers at least all inlines in headers and all methods
wired up to operation structures.
