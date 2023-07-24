Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFA760019
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGXTzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 15:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXTzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:55:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CDF171B;
        Mon, 24 Jul 2023 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vdG/qNSKAzMCne6hs3LuiSYA/9ObGKKt85CSCwfqp+8=; b=Lo5vCN0PICFy6ElN9FzwxzcyT6
        7YJ6rFItX/cYTsSesVk8KecuQbeNAINLKOV3oZlEXpxacWvJ1/fJ/mEKrfYTtgn3vG25lSW5INIcE
        PR/Ygv2r8wxwQNoCMmPV0AMuOuq70/Fgo1PQP/q9HuX83lOk8eMIq7nNGwPBGvXLM9HUyTQrZYhZP
        TU1unPlfOoex8HJhdrzkerKgTClh3BDodQqKgGchzLpYrforw30e84WAfgMyJfK49cYkq3nbMUZYT
        +px7X36aw2QkJ8Sfg31jHyIyDVVneeD8XtR1rls9kwupX+qEFNTISZQw1h8WNkvj8bugHCERVTCXh
        vbLJoDvQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1eF-005Kws-0A;
        Mon, 24 Jul 2023 19:55:15 +0000
Date:   Mon, 24 Jul 2023 12:55:15 -0700
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
Subject: Re: [PATCH 2/6] fs: rename and move block_page_mkwrite_return
Message-ID: <ZL7XI7wFLJ5MXXSy@bombadil.infradead.org>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720140452.63817-3-hch@lst.de>
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

On Thu, Jul 20, 2023 at 04:04:48PM +0200, Christoph Hellwig wrote:
> block_page_mkwrite_return is neither block nor mkwrite specific, and
> should not be under CONFIG_BLOCK.  Move it to mm.h and rename it to
> vmf_fs_error.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis
