Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4552E5302F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbiEVMJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245270AbiEVMJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:09:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C01233A15;
        Sun, 22 May 2022 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ta1ELs7sS1+3xDvRmwvWIiNhXL
        bwZJXQMRkKvQ4pQKgBwcdZwfAcOaKV6J/X4+rJtbLQTahOfWKMoPy3AONmzRbqfFRFtRVUAEwkFwP
        VPu+XOST7tPyXtZMkbRV/smwz79fZox8h4ZsC2+GjFM4zd6qhfD+2geLt3Q14CmQvdaK1S5/rc0lO
        B0Ji3uWcuOQEQt695RAXelX5wG6YvVOjT9K7PijzdoNhZEzmHR32dJi5E1+j4C7vJuz7MzXj8+4gb
        nCs+Sid7i+Q+zHq1gxbIA3R+R8RqdbJ8oZCczPwQ32CNb7qY8HmKLYN98CVNH1etnE9U4giisrd/E
        5tf432PA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nskOX-001Gmx-Lv; Sun, 22 May 2022 12:09:13 +0000
Date:   Sun, 22 May 2022 05:09:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc/base.c: fix incorrect fmode_t casts
Message-ID: <Yoon6ZIzvgaVMtlq@infradead.org>
References: <31a6874c-1cb8-e081-f1ca-ef1a81f9dda0@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a6874c-1cb8-e081-f1ca-ef1a81f9dda0@openvz.org>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
