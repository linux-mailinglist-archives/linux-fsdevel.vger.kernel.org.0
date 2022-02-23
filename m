Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045584C0CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 07:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiBWGwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 01:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiBWGwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:52:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC7DFC0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 22:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CGnuuoNJln+YLjNOvn2lSl/NF9CVQ94rukgpLCCCvrI=; b=tr7kC8HMCeF/3IYZPuUSQtQNvX
        Ot0lQKy9RXYUWWzuO/n6BbeM1iULEIwMSYmRvGdostCdFFJxF38Udqz3d9JRyxJRCzkEYd+q5/ICb
        3vkmkyNUY134PJL8gwNfaaXcG6FwzJOcm39YUFR0xrlkAZLI8o/CW57mCINvshh6WE5vU/6mhMckl
        O8M3skdfIGL44/BgUnl7Gn6SVoebBye4rL2jXHwdYG+i2m5x+LaV4ReN2O4ARys4CspUjSO4s5u/5
        ZlvjeoRU7vbAxy01ud1fFs5tAu1h7VpZKzs+K90wHgKE+lAeXo7MnR4ykizVCVIKinwu084ZwJ3kg
        DGFMLe9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlUx-00D2jA-4n; Wed, 23 Feb 2022 06:51:39 +0000
Date:   Tue, 22 Feb 2022 22:51:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/22] fs: Pass an iocb to generic_perform_write()
Message-ID: <YhXZe+4Z2AfEaJ+v@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -extern ssize_t generic_perform_write(struct file *, struct iov_iter *, loff_t);
> +extern ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);

Please drop the extern and spell out the parameter names while you're at
it.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
