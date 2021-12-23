Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014DB47DF48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346702AbhLWHDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbhLWHDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:03:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508AC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=S5pwdJrg7W9UGRoMoH1ouk4HLv
        9N+UwBcWTYt7eGfPmmGtFgSCpjDcalTHuL24VGNX0fK2OHMd4t3s/zCUuphlVijpU2vfnHWtkKc7J
        MqcC5/Pdom/ys8sCEhOIujHEeNxnmjEZLaG3OZP9FJErCxlCmTfVvcwu3CCFV1aDplr+s0fjO7CRW
        JLVd/PIeBPqBFu4r4YPIhW9lD4uIcwXapLPi4c0b350AdQ/gQ5p1oqJCZLd7ClPPY1GIdqhedisas
        UVCKQyz78Qv74yv13xM647tLV36cxYzszjEZmduXx2OoWTGB6zYfiOeBuKa0YbVaN8ntsjBV2Tgz5
        WwWiUpbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I8f-00BxC0-QD; Thu, 23 Dec 2021 07:03:45 +0000
Date:   Wed, 22 Dec 2021 23:03:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 11/48] filemap: Add filemap_unaccount_folio()
Message-ID: <YcQfUd2eY/hNWeON@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
