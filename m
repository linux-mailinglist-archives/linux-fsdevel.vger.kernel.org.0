Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142C86B5C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGQFF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:05:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=h82G5t6WdHPwpMQcdhgXaQujw
        f11byeUz0BvJLsDaa5LoTLa1n3PEiniFo2QTSacBp0bZlsV331gEfY3Q6NdXFjMcNXe7+nmg/ttzk
        R/Qd8zhN5LsoJUibSpW5viA2W/Ex8xcWxsnpfWj6VVW81lOGH5NbHl6tguKGDlBzSwyCDfGhKxUEl
        iRQ5xKrug2SaWXcE38sXQTt4aeTI2tPU7vBU9hBZYSG+ZO4kXYY5jzCKm+2jFEB5lFfz7JOjMFevJ
        T5/TJzCJufqhQc7li2B5p9HG5v6do1Kr4s51+B9BLbAfacWb5w46wHxVrPj6npSncw9JZC44NcDA5
        rkFp25/sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc88-0004jQ-CN; Wed, 17 Jul 2019 05:05:28 +0000
Date:   Tue, 16 Jul 2019 22:05:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 8/9] iomap: move the main iteration code into a separate
 file
Message-ID: <20190717050528.GH7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321361147.148361.259588516341531573.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321361147.148361.259588516341531573.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
