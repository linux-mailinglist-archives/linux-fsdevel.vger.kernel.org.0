Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945C4CFC8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiCGLWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 06:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiCGLWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:22:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597385FA7;
        Mon,  7 Mar 2022 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GDzxRMNFOjer3awDR6cVdhL2XUMV2dUGBn9CFb8NYFQ=; b=hFVlqV3tjdDWyIxGImMoSJLU2y
        9pxbMr/ed/1W4tz/lB1BOkMMQ5ubNpvAT+/GFagmQOFgl8hBdM6FhgwZACMHx+ckPRcrlgXUG6BC1
        Rl6ov1pZjsNKe91IZ39JlLzZO2Tzg7EvLXxzHAlbe43LOOQT1+bQN5RKSJAkhpG6Gvdj9gG6p91Ix
        XW5agBGeIwbd0TOP4bcCJTMLBQujXV9CyJxHfSiQLTvse6KcdjMsoJY6gSTTa9UgFqljkeeAqUz0x
        R+/9/lQ8cY6uAZWoSik2crkX4Rz8Yjw78208p3FWBH7gzFSbAEGb8IkQT8ECrw2F76VfdgCLVSUJq
        jWR3RkkQ==;
Received: from [2001:4bb8:184:7746:acf1:fa8:78c0:4ff2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRAtL-00HCg6-IV; Mon, 07 Mar 2022 10:47:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: remove write hint leftovers
Date:   Mon,  7 Mar 2022 11:46:59 +0100
Message-Id: <20220307104701.607750-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this removes the other two fields and the two now unused fcntls
as pointed out by Dave.
