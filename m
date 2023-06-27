Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0073F4C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjF0Grk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjF0GrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:47:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4247E2726
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HIzmMw7ysPooK1NP7gUn/j/+g/
        cwlGFt0bmdsDaj+q+FevHEQbvXlghmshE0DWI93P4Ehi8nKq8x+HYOv3/S4MCYJ2eB3INh+0SX9pR
        yT8uvoSk4r7eu7K7w1GlXvqr6FgFwLZoCDWji18uO9m+7F9JVRtTqvXepSff9b8DoL1R7fYkzHXS4
        JVgURVOExZuThWPvwE9/icL049apgqemK4HsdPORNfWkEDMc8AEO4sAz/xiJt92+YmeJmegbF0gbK
        PM8YYnF6yO/BujKvAOad26jaF8x9RpqfB/Grx+yjgPS4HeXJs24Px0y4sqbBTK4IvjoFgkGoF9t5O
        nUCkgw2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE2RB-00CCtw-28;
        Tue, 27 Jun 2023 06:44:29 +0000
Date:   Mon, 26 Jun 2023 23:44:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] shmem: Refactor shmem_symlink()
Message-ID: <ZJqFTUBroDNkniHD@infradead.org>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
 <168780369414.2142.7968970882438871429.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168780369414.2142.7968970882438871429.stgit@manet.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
