Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C49536B05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbiE1GCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbiE1GCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:02:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA5E74
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uYXzrV+DtoSk9kPAECiILCkfcPpXNMD+fuOQxUK/giM=; b=o96qohAr4yUHhzyQ7b4NxMnnEM
        JXeKjp5f4cMQxoAnRzFzPWOlGIWwd07TDB2w3OUCBtbwrjmFsB6cyCd/KZFrnWPbIGupjM/b4df3V
        KfJ+xTDN+MPHuNxzbLA1WWIQTDh4Jzh4ABA69521o/gi4BP5yzrhSuS1PgFpGrz7OEVdV6tcwaqnx
        8a7XAd7yNjZTZI2w6AaAAQ2oToQ5iufIm1N7SXmbK9pKdpEH1fOxKqbNpnnJlcbimG9mo45RtjBYM
        ul79d0qks7rr1b4dpAyxPzt/MFJmEpJqiBjQeIupJaI4+XYZ4TnbmbCBJiKeOs/BjvkiWOX2s7J6M
        kDSZt/XQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupWc-001Wtw-5T; Sat, 28 May 2022 06:02:10 +0000
Date:   Fri, 27 May 2022 23:02:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 19/24] nfs: Leave pages in the pagecache if readpage
 failed
Message-ID: <YpG64hg3EfL/h1zN@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-20-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:31PM +0100, Matthew Wilcox (Oracle) wrote:
> The pagecache handles readpage failing by itself; it doesn't want
> filesystems to remove pages from under it.

This looks sesible to me, but please Cc thisto the NFS list or
maintainers, it might be worth to dig out the history and possibly
test cases for it.
