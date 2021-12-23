Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8647E068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbhLWI3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhLWI3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:29:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43EC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YQzP/a1XJhK8TjZgQSuWk8EwShUVuqtEL6NOBN8g3Vg=; b=iz/YOUtUD13RhkVpb4/hxnzUzy
        X11oNGfWugg5WAjownglEBMvC7CfulTfU/C7WRtImu5zYXg5Bc8/WFlfYFv0ODcgmsBSZMcaXwDzm
        VRDzj4t+4j5yK9UtBlf6vtGynm5wzgM7ChjWhMOKcygvEXH+JtZW+i06iKWUxgZrjn6pIWCOADJwj
        YWJzj4HfEOqPTrvtAfCFOR5/z7++IzBsmp5WR92LzB/IhtMYyhzBBvRz700SHhYDPz5I6SVKXb+bs
        0A6Ma5a8iGIWMkoDjsPb2B6XCi4hEFQj84fNR6ACaK5zZwshbeU2/09x2poj4mYE67MeZkvizWCVP
        /WyHwwfw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JTO-00CFQV-27; Thu, 23 Dec 2021 08:29:14 +0000
Date:   Thu, 23 Dec 2021 09:29:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 47/48] XArray: Add xas_advance()
Message-ID: <YcQzV7kA9aqdzKJC@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-48-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-48-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:55AM +0000, Matthew Wilcox (Oracle) wrote:
> Add a new helper function to help iterate over multi-index entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
