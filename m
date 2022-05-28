Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB3536AF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiE1FtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349008AbiE1FtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:49:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A326163B
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7tlyWYj50jjriKdh8WZL0X1UuZpv8+ldNsw5zcN/4rw=; b=b4UcQ8Rd3xMBHwYRDX6kukq/gc
        amdR56H423GoNPm/mH5JsWVrPgc1MFNFQCsShDnfBA03bEMwKx0VRmM4xFkEXUqQnWe/JzLUSugbS
        Kbr4A6anQjQeUiDen3tIkaxqhLgLY8KRTk39lw8RQwfO5u2fPxXP/JWOcrWnNckUH0kRh8qmOS5xz
        CQ56alunemZ9zZE+8bvqHode72AVm70Lb9rgIgrpciOpAPXoD5uIvnHDSwsJSzb7rNiNLbXu8wPC3
        EUMpYbP2PkRyKlPi+fVPq4ilnmCY7vs3afNBnpZdwzcv13ifsl9Md50bzCs9ON8yQ5T5N7zH12qc4
        AilaB+cA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupK0-001VSA-9U; Sat, 28 May 2022 05:49:08 +0000
Date:   Fri, 27 May 2022 22:49:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/24] ext2: Remove check for PageError
Message-ID: <YpG31Hnnye356SsT@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:20PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() encounters an error, it returns an errno, not a
> page with PageError set, so this test is not needed.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
