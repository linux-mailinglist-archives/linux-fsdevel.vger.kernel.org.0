Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943BC9FAF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1G6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 02:58:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1G6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=szNJz18IkRAVT+3DLDeg5T2vD
        WT8kAIr+wRfzUYqoWe2r0V3HDeaGreLe677vNPwGbgYYq1xGfL1D1t2kE0r3pViWZkUmLoS8sqSIl
        QXWFlVXGkG2vnmcVnBlXgmKcU6Q9RtifXngNuzfT/C26+O01GKWLef7p7JZS87uqfT58i/KziRv4G
        yJQvoyNT0RB1HjYDeYtrlzCqDnJi7svD549u+Kt8T7NPZOlZjGhyHsREDEYG7ve2Cz2CAcV9yVPyA
        CbRp6AuAwF7Fj77sSpASWMNq6GeVTuQUhJJNJGvHpnaCQ8FRrPUOoghkohlGayGnr9EflsVWobzvS
        jC9Apm6Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2ruX-0007U1-Ox; Wed, 28 Aug 2019 06:58:29 +0000
Date:   Tue, 27 Aug 2019 23:58:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20190828065829.GB27426@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826205829.GC13860@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
