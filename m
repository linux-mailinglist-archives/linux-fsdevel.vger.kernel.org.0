Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6449D03A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbiAZRBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiAZRBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:01:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502DCC06161C;
        Wed, 26 Jan 2022 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=vyuyBqRIMMh9+Buu1wPmRydLHC
        BlGk8+V1RHAbQx2h0FvJRQ5gLwUQNndUx6SX1PtD6QhjtC8w6TjcY+iIIpLzogtV+NdgG8GmFGu+a
        hAzdqhWNYdeggW3JUHmkt41CG4wIsC2wZbUWOpt/s4rxUDyk3aDU7Y9eKZ0pEi5hZ0IELzym6xXFT
        aeEB351WaqFX00txzDg1nIbI4j1AD8WUqBKB8bpG4MsdqLgdsBGL1yH7J1DGbVD+UKt9olE1dBvi1
        woGEdZoprV2f21o+eNvLuzjfWk3wETLqk8jz6vkwl7KJPCsMjP1qr8e3r3ZHuTpstyZmKl2TjVWyK
        9imIT18A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nClfp-00CpqB-KG; Wed, 26 Jan 2022 17:01:33 +0000
Date:   Wed, 26 Jan 2022 09:01:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 1/4] vfs: make freeze_super abort when sync_filesystem
 returns error
Message-ID: <YfF+bRP0gimCfpdt@infradead.org>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316349509.2600168.11461158492068710281.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316349509.2600168.11461158492068710281.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
