Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C576005C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGXUQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 16:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXUQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:16:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F017C7;
        Mon, 24 Jul 2023 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgMGRzESWkQ+jza5LIM+2YG5UUtrxuCLlNlof8Ub3HI=; b=O7F9hoVVXTS2psPy2k7JJ4s7IV
        IFRIFjXM/COmp3BhCSgJJIcqjslFLLiil0flagqfpYDSLagDfxTp1mMnXvkwm2dO9XAhtNcuGhvCW
        CjL28WFSFwTOaCPuYP9QVCU/w1XbZUJKIvL+kHSltzWxU2aDD7rT1907mwDx6mDoJEYlLeRrXmdMw
        97GKTpo9aZaesc/sYpE0k17UAbn+xod3TYGf/H0f1sBRhOsRwB53FIEn93d9HMgD5LCGKg9m80Zid
        ollV6hUINPUnfmUSgmc0tnDaX9/1cj6QYZmrrNy8gBFixAvJArEZTKUDSgTEY8sHHb0hjsdUFGm1Z
        lHr8V6IA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1yS-005MyN-1n;
        Mon, 24 Jul 2023 20:16:08 +0000
Date:   Mon, 24 Jul 2023 13:16:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add CONFIG_BUFFER_HEAD
Message-ID: <ZL7cCNGhe4/YhLWn@bombadil.infradead.org>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-7-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:04:52PM +0200, Christoph Hellwig wrote:
> Add a new config option that controls building the buffer_head code, and
> select it from all file systems and stacking drivers that need it.
> 
> For the block device nodes and alternative iomap based buffered I/O path
> is provided when buffer_head support is not enabled, and iomap needs a
> little tweak to be able to compile out the buffer_head based code path.
> 
> Otherwise this is just Kconfig and ifdef changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
