Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4704B47E053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbhLWIWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbhLWIWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E1C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFGOFXbr0un8TPT9fkQ5Br1roJ8tDtNj1c47KV22lUg=; b=m0g3yu2B6J/dfXTBau6n1eQQBo
        KRenfFrnG08wxTup0xWJynhaW4JPlHFTdHIP+hN4QHbDg/3vIDbgkhJzYw0QEJcdua5ZsxJuivTz+
        0AVo0Xe8cao4NeQO0G2JKTRPcmXuzzgWmVPg+BdPT6XNauegsaq4xSMXaMy8r8AZNRuJqjqnY9Z7d
        0WIMW8gLY1nu5HZroqqr5iHCbWL5HXfF4tlOTfctkTThYY0BFRpEYv1b8vcpIpzblERjvv7rN/ek9
        FKTXuZLodB+LjRXAsBJcoWWablcintyG+X3QPZFwZCK3Ls0QBxzBQ3sQg2QP/Uzy/+84PVs5JMWeM
        pH8qNuXg==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMx-00CCxD-Hu; Thu, 23 Dec 2021 08:22:35 +0000
Date:   Thu, 23 Dec 2021 09:22:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 44/48] fs: Convert vfs_dedupe_file_range_compare to folios
Message-ID: <YcQxyY2x+QRwbtd7@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-45-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-45-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:52AM +0000, Matthew Wilcox (Oracle) wrote:
> We still only operate on a single page of data at a time due to using
> kmap().  A more complex implementation would work on each page in a folio,
> but it's not clear that such a complex implementation would be worthwhile.

It sounds simple enough to be worthwhile.  But no need to do it here:

Reviewed-by: Christoph Hellwig <hch@lst.de>
