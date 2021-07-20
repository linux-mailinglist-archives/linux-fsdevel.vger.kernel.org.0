Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE883CF90A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhGTLD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhGTLCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:02:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1450C0613E5;
        Tue, 20 Jul 2021 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1vnsGZe5HZs1qi7Iv0H83IbcsD3LEb+LqjsBUd4XKZc=; b=r91kb8bteKqyq0XuMThYiIXutA
        O95y92OX+9Q90xjN+c1xGF4bJz/5bUYw41QQdjF567Z3ydoAJZx+GwuqCQ0UQtjZnOatsSg98oSEh
        X42vlyBp72TX49aMIZ0ijjtC7EqD3WhB1oE4vOszMKh3Fs1y7IeSQyHwUksgQKg2ureJQULMsLwDh
        UNlXhN/ihaJjl8xP6gYNwI2E8nM73NvGwOvBtSFyHXKDhbfcOzCK8TYEaRYuiQLvIcTLR74dA+ffP
        QAnRA/0WJCZIuPiq5HKLhoE7mqsyQdVLM/9Ir65bnKm6G2iX623VGUFMre7qyGBPZtFm1Gnoe7Imw
        FMMBGizA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5o6o-0083bq-AY; Tue, 20 Jul 2021 11:40:29 +0000
Date:   Tue, 20 Jul 2021 12:40:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 05/17] iomap: Convert iomap_page_release to take a
 folio
Message-ID: <YPa2JnzxhbriKgQ8@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-6-willy@infradead.org>
 <YPZyuyAQx9yqO9qV@infradead.org>
 <YPazk2wV2J8+3chJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPazk2wV2J8+3chJ@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:29:23PM +0100, Matthew Wilcox wrote:
> Probably even better ...
> 
> 	struct inode *inode = folio->mapping->host;
> 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);

Fine with me.
