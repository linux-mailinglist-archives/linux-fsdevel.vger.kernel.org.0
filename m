Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33D0536B0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiE1GGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:06:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E09DF38
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2jdyMFgby36iYA2MQTzDG6VGrzdDvl1K94LnTMG+Vg=; b=zxlEWezoZb9jLuvZz3tYRMfqfJ
        KTtGJMh/4xMXz1XCwQm4YQeNJsDXKsqmofkICKlzxDwvtd+nfLQ+YkwPkTYwiyvhLo3jQXrIIeD9I
        sKQh78gbnuCX5fXPKS4PNfIgn2xk0IZ8VVO3+7UmYNOYebKmmWycqAzqFf6ZCj6fgncHVsXn5e0Ec
        CqLeYrZokYqEt3CVrqg5KUEPxmztK15oTIqx2JtAGjLb7HB/z29AtPlpYE77rN5jabNgtn0VGxVRb
        Lab5OkwD97MhRb12HGpOW8QcfjTYBotM5Be5zTq6BklRjCNtzaQUf7TrB58NsLCEqDnYyVfNBu20C
        tb+XfeEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupap-001XHz-CK; Sat, 28 May 2022 06:06:31 +0000
Date:   Fri, 27 May 2022 23:06:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 23/24] hostfs: Handle page write errors correctly
Message-ID: <YpG75yPXPYhkMaCA@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-24-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:35PM +0100, Matthew Wilcox (Oracle) wrote:
> If a page can't be written back, we need to call mapping_set_error(),
> not clear the page's Uptodate flag.  Also remove the clearing of PageError
> on success; that flag is used for read errors, not write errors.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
