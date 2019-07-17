Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13F6B692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 08:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfGQGWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 02:22:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQGWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3DuVoq8gYnl6PuZdeh81qs/SdxbUi+lblJs2JhrUVvI=; b=mzYRMI4TsoqRYO/dyE842ZVaf
        6cP7uTaSwlDV/FoRu6sfvAH73YgKcodlXt5aEdeNzVG/+J7F21M3YUWoQs0cj30mUpkBJ2TfwFziW
        rcNnZctT4d7PekD/baWvTcELrkKP9eK9oqgJ5iInixk8PepJD3N0XS9MeKm3NDAUVrmlrjMDjXDS8
        5uZY/FY7WRLJXwdGjGAvuRDFLPUTDG444zbJBCMZB8rWZmfnCXtaA3ULNI83qUD8D/8GovjvOBaF5
        EXu/yPLT5eHYWlBVQN3qnp8QEE/3wNPdRSwQMlDb2/zhvTg6qErYWvdGAj0YtO4bCKp5mMUt8RvO6
        uBZHBYekg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hndKh-000089-ML; Wed, 17 Jul 2019 06:22:31 +0000
Date:   Tue, 16 Jul 2019 23:22:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 8/8] iomap: move internal declarations into fs/iomap/
Message-ID: <20190717062231.GB27285@infradead.org>
References: <156334313527.360395.511547592522547578.stgit@magnolia>
 <156334318826.360395.9686513875631453909.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156334318826.360395.9686513875631453909.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:59:48PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Move internal function declarations out of fs/internal.h into
> include/linux/iomap.h so that our transition is complete.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Didn't I ack this earlier?

Reviewed-by: Christoph Hellwig <hch@lst.de>
