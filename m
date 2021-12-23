Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8615347DF2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbhLWGwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWGwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:52:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623EC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=r9kmSVor3enx3cBm66VSUIKsLf
        //m6dY9JEEGNEKqJloEYMKj3IYpHk/XEHhk1XexAiN4W3pR40C9A0tVZ46DqWusKWh/69HDYd1q22
        iiKbfa5+6tdT9JenFBvq89cSGBlcBn2YgBI/A7/ex8Pfh5/xFZypthbrE7BhDUyqSR8AydX+Zvw9E
        +JtaNeB+yCe5CBMl4wsqjnElulmXuMUquyD9YfY+pZwUkt71NaqBCbisgD5vGPp2lC3Z2IwSY6b9x
        9/eEyXOSs+6UZmmqaWOVwmVZVdkpUaYbKKlyr7z5QFgY4ZvdadYRD31bvB3tPmB5F0Vm1tqZkgLKa
        q5xmAPKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0HxV-00Bwou-8F; Thu, 23 Dec 2021 06:52:13 +0000
Date:   Wed, 22 Dec 2021 22:52:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/48] mm/writeback: Improve __folio_mark_dirty() comment
Message-ID: <YcQcnSuCuO5teWTR@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
