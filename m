Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE18FB3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHPGlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 02:41:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPGlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/3AMdneQMHbJ6jzTXFd3V+Aivs0XGBJ9bktDdp3GzLQ=; b=Y1tPwsGXD3zLqx6AOMMUC3Ugj
        xvuB4D2C6bk0bsDZUc2vCFCGWjhFXIVzYgysQXCcQRB+uikJ0X/l2H1E1y5QD8FXqA88WZOUhmp8R
        U6kV5i27Z4lDw2/Sm9wfTyEATaiZTF3TiyVuQZ3IxRvey7pa7QuyHbhRCJsjIMC02NAylFSATtg/P
        Liz4EatPY+I/G/jvRno3m2IaEvVXSFDadd4wOM63qLJOvYGraOJEbkkulmEVq6vQ2YLLFGss0Rjnp
        8oi7Fbs95eCMQPUOgvBZ4KT9i8SXNpRGURLuo5Csu6hmKkNjXlqBU0/I8zcD2FkEjXhudVjYt8BSL
        oAd7Pn+9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyVvN-0003KH-5j; Fri, 16 Aug 2019 06:41:21 +0000
Date:   Thu, 15 Aug 2019 23:41:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] vfs: don't allow writes to swap files
Message-ID: <20190816064121.GB2024@infradead.org>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
 <156588515613.111054.13578448017133006248.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156588515613.111054.13578448017133006248.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new checks look fine to me, but where does the inode_drain_writes()
function come from, I can't find that in my tree anywhere.

Also what does inode_drain_writes do about existing shared writable
mapping?  Do we even care about that corner case?
