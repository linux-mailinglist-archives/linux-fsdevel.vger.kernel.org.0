Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D94551078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiFTGjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFTGjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:39:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55424DEE0;
        Sun, 19 Jun 2022 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rzc+YDP+QeA5ZwvIzM/iY6bnPG
        mp2cnrjHxgRLKh0kd8PydfNaE7A2NGUO7yhOcMoOp5ZBLxGWX7F+bi5hZIsEOGM+Imd8/4VLZk+4q
        zval1MueoItY/4/ma5xoGPFk+ym5I7edMnwM3NgAipicNdGsXyJg982bcHO0ogfabo8tKndIMiOZ2
        8F4Eb3u/1nyMt32rqW8hBIfzlh6g8XJmiAKDGk10cek4n23xARJEfHgPb6a3pO4oLQmt2H4UBXJyG
        S7g+YA3rko9RG8Z9DM4wpGNqsxBwch95+SJ9xg0+ffEBH3vK6T3M8o7glglOXE7q1NNyQjLRKk3TT
        RPNcaOKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3B40-00GSKO-J0; Mon, 20 Jun 2022 06:39:08 +0000
Date:   Sun, 19 Jun 2022 23:39:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/3] jbd2: Drop useless return value of submit_bh
Message-ID: <YrAWDEqRathKIRkx@infradead.org>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
