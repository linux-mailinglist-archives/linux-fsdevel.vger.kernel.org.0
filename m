Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C42620C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgIHUPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgIHPKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638C7C008599;
        Tue,  8 Sep 2020 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ucrLpPUSygiKHx5/XLaUJmgkp0
        qnbsKOyQsZTl5747Ai7SA+5Gi/Il+xaY/nz60utOb/A0+cI6TqhYf9CD4adjc0joJ9IMTcGroIp0z
        W83F8uJkCAfc6Ey5twbC95I6s0gRb3k2+N/Kf375fQXFMYbrLwn4ZmATrl8VxntrdZvWcLkUfxaAR
        tCzcQdQmlb5vvyJ8uxhZHG2OXnxnt5Gvve5X44ppSPMuq7q5Pywhr0/k6DfodFhs4x+wjcz1hnY5s
        am+4aewKyBvm2FN4vBlNXY8uNZwNzEFYMMB6aIj6u7jnPEl2qYWopVH3eZ7gOKQ7Vb+i7gCdg5mXM
        +f/91QQw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf65-0003IE-DX; Tue, 08 Sep 2020 14:59:49 +0000
Date:   Tue, 8 Sep 2020 15:59:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: Clear page error before beginning a write
Message-ID: <20200908145949.GO6039@infradead.org>
References: <20200907203707.3964-1-willy@infradead.org>
 <20200907203707.3964-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907203707.3964-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
