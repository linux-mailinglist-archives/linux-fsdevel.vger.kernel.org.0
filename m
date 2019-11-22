Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF81072F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKVNQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:16:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Nfq2Sr7vKomyvMvQE70VWUktT
        Uri1F7nHaA8/+zh4oHjWKvr5Z+33mSlD50bhltkR3+cYHmSlgP+rl7L5KNZOZyBYZ8R0ZqsL2gXuN
        gRfp0dZzLkWQGlxqmn0740Ve0QfN7povzlDPFvkAsKhb3QuePoPig96b/CBmdSSCJK0mp+Q/hmoUv
        4RIbbkGXMCT9AHFaMeZFP9YbyiYmQEek3xBlJ+g2i+vTI2xx7Xw3nhVufeW7/O0ZGYb0gflEo5dQy
        IqH+j4cJzs7lvgSzGGCrKNJuwVHYtsZQnBOxZLC3pg8uiyCfOj8vGeEDu4B9h7Cs2t5aSExi6yk6b
        fN+4wtzqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY8nA-00033Q-I4; Fri, 22 Nov 2019 13:16:08 +0000
Date:   Fri, 22 Nov 2019 05:16:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: trace iomap_appply results
Message-ID: <20191122131608.GA5075@infradead.org>
References: <20191122014601.GQ6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122014601.GQ6211@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
