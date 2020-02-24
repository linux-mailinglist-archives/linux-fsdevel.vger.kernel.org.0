Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F140716B2F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgBXVlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:41:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBXVlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NvJp7tTodaVHCZTEDiIj+yawWDduVL3Oct69ajAcLic=; b=igQ0lGMGn8KdLvHIbVPzsUeKgG
        j10MnNZMuq6fJKQv0MSVMg+Y/0gN9OgLzE7u9neWDTcLC9mCS/LiX246FGoWpmJbXSwegQgcBjLdz
        Nq2o1N+9I6tazK/m7Q+iUOpOFQC5u31Jr4q1tpXtMSrfjarKH1or/of3lwGNKGFGGmfUhoaO/xPni
        DbhCdWHHlwIkwP0z1vHfOioVeL34vwJvtBGTOWey9/IAzoY4g2jfskQNrhQAq5UlyQR6bBY+vr+U7
        eSTr5r0V4JFmSHrHc92QOQOikws4qtL6e6cfeY76efaL2sTg5s8ZwJ7y4F6h4+ALSsJfavSgqAWxq
        YsGLY/Ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LU1-0007Zo-K2; Mon, 24 Feb 2020 21:41:45 +0000
Date:   Mon, 24 Feb 2020 13:41:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 10/24] mm: Add readahead address space operation
Message-ID: <20200224214145.GG13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks fine modulo the little data type issue:

Reviewed-by: Christoph Hellwig <hch@lst.de>
