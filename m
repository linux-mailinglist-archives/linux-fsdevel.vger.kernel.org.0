Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906C7362BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 06:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFTErh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTErg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:47:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B1DF1;
        Mon, 19 Jun 2023 21:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QeiChVQT7tf/l7Q1r7WXDXzuDc
        TUlhW2KdJXT9248CtsyQTjKq+l52rQWzR5Xz/uDubkihDnIMkUIRceZXMDDMMkpojDdqnjPkoCd99
        lU3070zo3zB/bo0FtUjgrKJL1VdZHp7A5Ccs75otFSejpC2zp3b1r8Jeij/2+oy1c/crzCoUsk5Lp
        xDeim6QG6dfaAgLHxCtuMBGC5voKWbIuUnJQ6LQfPk40wKBK3lRAL1qmPj44rMJbbZDzDbJKMyjvE
        ptf9lH/2i2JuzSRnRXWmifvnt7K+1fSokzjd0Lw1CZBNfZWal94utyqLlc8r5iqmprb2r6nm+4mXA
        gTh8vzVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBTGy-00A8nf-1Y;
        Tue, 20 Jun 2023 04:47:20 +0000
Date:   Mon, 19 Jun 2023 21:47:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v2 1/5] fs/buffer: clean up block_commit_write
Message-ID: <ZJEvWNvZyjyEI4lJ@infradead.org>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
 <20230619211827.707054-2-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619211827.707054-2-beanhuo@iokpp.de>
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
