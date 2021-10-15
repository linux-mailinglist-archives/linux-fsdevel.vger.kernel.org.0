Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B542EAF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhJOIGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhJOIGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:06:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D0C06176D;
        Fri, 15 Oct 2021 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V/RBXrqenGIWpxRD/50XfbTnyayQ4rCJg+f2/Q6o6SE=; b=r6glmjWkT+gZH6ooBvITyfccYt
        JaaszEtEuYPaeO57o+V7o7Vflli4fwJvNLMhfOjZ5WvgHU9UviQy21o5fAG2UasCRG+nG+HXoDS77
        kU9UGTllbnmpxf4aRm0YaiQPeem4z0yRyU2UORAv0KQNhdtQnlw1Uvp3TDMMd4RF9XwBASq/uurpr
        dWBGN40T8zsx9FA8XHJ3Js+21m8LnUdmqpnnOPxMo5MSY7vD8kZBtH6kBGhvOSBkKDsE748PnSwyf
        oDhh2RVvsK+51K1gS5hZxpaWntgpBmgifGQPhJpVFppDEvNMVMSfxi1blUtzkbRmvUmehIQxEjpA6
        xiorRq5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbICF-005qYt-AQ; Fri, 15 Oct 2021 08:04:07 +0000
Date:   Fri, 15 Oct 2021 01:04:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     willy@infradead.org, hch@infradead.org, akpm@linux-foundation.org,
        sunhao.th@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: inode: use queue_rcu_work() instead of call_rcu()
Message-ID: <YWk195naAMYhh3EV@infradead.org>
References: <20211015080216.4871-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015080216.4871-1-qiang.zhang1211@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NAK.

1. We need to sort ounderlying issue first as I already said _twice_.
2. this has a major penality on all file systems
