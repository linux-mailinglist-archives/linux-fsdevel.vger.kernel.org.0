Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A25536B08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354568AbiE1GD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbiE1GD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:03:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7967AE89
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NyQthQJpGcstabnX8JyKAqtCUdWovwhdWvPL8jhV61A=; b=bKlSY2gztszLwfbyS2K4jiT8z6
        pFHRc6+3EKjUyuJ4DqXpNXxX4go2lWqRCTJnRWQIZ5Elnwcx1CathJshqdp5W/bOTRHDuRFRLvnyt
        SmMLwdaD2DVGI8/PWl90GmTrH9d23njJOE4QsxmuS2MHMiuh0RqR+X+rRUacjnn7Na+R9UpTvNosv
        RdKBBmIPud78ufQCigB++w5fs5ygjvRGcuD6EDle2P79dJlE2nfFwkLtvZurKGroKSw5FSK92V6k7
        xhRrSEkAiniiM3VQRH3jRiw1PW6Xih/7SI8ZEtXXvCd3Jj1bqc/sEKb0JoojWGysYGmKy7DEfde9W
        IFGuiZ7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupYL-001X2z-4M; Sat, 28 May 2022 06:03:57 +0000
Date:   Fri, 27 May 2022 23:03:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 20/24] btrfs: Use a folio in wait_dev_supers()
Message-ID: <YpG7Tf5CQiFr3qCz@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:32PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove a use of PageError and optimise putting the page reference twice.

Looks good (although the entire code around it could use some love..)

Reviewed-by: Christoph Hellwig <hch@lst.de>
