Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF15A62BF98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 14:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiKPNfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 08:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiKPNfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:35:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80212193EF
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Q6luM+SmNEKniKa8/GmDPUoIwT2baxJOIJc5WvVRxyI=; b=KMx8CjHYGIQh1huF+Owr2OKfru
        EvXR6wccl8GwfPPvBesaNZgfDMtPkHWMcVafBxewvw5PSR1wrhnaE2YKEoONfchTzebVuDb+6TsVQ
        GV24OrKciQmXyLeccLZILVQwrWacWEdfI+z3CTR4CjEvytBaGGUtwD3T9tznHx8rwpTvB3IBoJT07
        Iil5bKhO2z8i68xG8nreSWD+wHiMEx0PWbVfaE+gUuzgJFbJnA5YJe/uG6hu+k+hbWuYkYLwMEfis
        qvKQEshBbth6FZ5rdQbZ7L970iVweCyVVXCZxWpFMfWY9Jjyt10OytY+BDOo/PT13Gq1RwF80wVoB
        9afXdl9Q==;
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovIZ5-003zcZ-Dh; Wed, 16 Nov 2022 13:34:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: remove ->writepage in ntfs3
Date:   Wed, 16 Nov 2022 14:34:50 +0100
Message-Id: <20221116133452.2196640-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konstantin,

this small series removes the deprecated ->writepage method from ntfs3.
I don't have a ntfs test setup so this is untested and should be handled
with care.

Diffstat:
 inode.c |   33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)
