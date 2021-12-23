Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3547E052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347115AbhLWIWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbhLWIWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4AEC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=f2tlXrmqM6lkrW8SNkC242Ou81
        4ItgaZ4aFpPYYcdSP7+vzQOdt9tNTQ7LQPp6UH4EmKyx9Ca0N+47AOVEBdLT3Rxc4esXKbCOLAivq
        1rbTEM4M0QlaOQYVphPGXZK9JFdULyJbpOfHUFmg8/kAJs6axPNfJEI2v2bzxLXP9fB/Bj9xyqwu0
        3JGnlT+DxQJ+r4jemIcvKfY2iQETTuGIk+cLBEWJVW71VyWdVCt5miEqTeMVMeDm0lw/e3+f5ofCb
        PYpAqL9dsxcf054slrxqtTDTm7YBNedXuxm+VghyBaaLzTfnk55/gh5vrE/EgiNV/4PaLWI0/VSdo
        Walbgvvw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMr-00CCuk-O6; Thu, 23 Dec 2021 08:22:30 +0000
Date:   Thu, 23 Dec 2021 09:22:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 43/48] mm: Remove pagevec_remove_exceptionals()
Message-ID: <YcQxw97sAwovJNXJ@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-44-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-44-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
