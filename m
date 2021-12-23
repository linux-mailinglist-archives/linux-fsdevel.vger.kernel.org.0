Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC34647DF2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhLWGvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWGvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:51:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC05C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JyS4y57KB8cl7wCtR5LfbZFnSaH6KizQccm4HasKSsg=; b=W/0XXPYteLo92XElFV4aBW21Gq
        yAP9J8Gzjc4l5gNghYum7c+EBXFEW+dHSCoY2axvdeqCtiv6jN+cAHPTsTjFSq1ObIdJan3zke2P0
        FVfzQW7722a/7+R4IlbZqqXDvc8Z3gwWX1GiHQ/yPhCsEEw/a+I2lx5r5vo5/p8TH7Ug9uq9l+aDz
        uhnqy2jJcgKzKbhbEDCNPVR+X++Qqi+oXuASH7iFujHvkc8h/tHeHBGLaShTYGj5fJm4UUfed3exE
        a9B07USvroKD+VOWdvqsJtP0IyPcqxDkvHw38K969bZd5pmyWLz0e8rQp5wgQg4OtKMQqJPkfgTsU
        AEKYigzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Hx1-00Bwmx-PY; Thu, 23 Dec 2021 06:51:43 +0000
Date:   Wed, 22 Dec 2021 22:51:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 03/48] mm/doc: Add documentation for folio_test_uptodate
Message-ID: <YcQcfyEJEYUxiQA7@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do changes to comment get a doc prefix in the subject now?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
