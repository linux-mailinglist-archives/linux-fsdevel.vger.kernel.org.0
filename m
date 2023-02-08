Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEEF68F167
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBHO4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjBHO42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:56:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B352F759;
        Wed,  8 Feb 2023 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sNoW+XXKrhsLxx/PUh/mZ327YoLMZFe15WsgYbQncQ8=; b=MMNU6uXpNOQEiKV14BJYkv7Rut
        0jmQc66l+AM5l1dDct+R4BrLdy5YlK2PL3ZrwW8/SGYtjN1PNUMKz77N1qmk8U7YV7rLLU9eY1etY
        kYyS2KaAE7/D5z5PN54FLudpyo5WjU0gljRhKuv/SETMiu69xmtLXd5D3N/QLmQZ0muQWxchq6oKP
        jKxTuN6XH2mG9N+QQWzb6rO83UhFWtxLTwHaZ9XG95SjyupNjEgOpwalguIxVa8z52Knjj4brQzwD
        OtZJAYFmDkk0Xovbp8KH4M/Ey0VtA8ntSGH6ZwnDCi9ljEmP7bEPID9oiU2g5R5JE8Gx5wvpfI6Dt
        rZnbRZqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlrp-001I3C-A2; Wed, 08 Feb 2023 14:56:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/2] Remove lock_page_killable()
Date:   Wed,  8 Feb 2023 14:56:09 +0000
Message-Id: <20230208145611.307706-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the last caller of lock_page_killable() and the API.

Matthew Wilcox (Oracle) (2):
  cifs: Use a folio in cifs_page_mkwrite()
  filemap: Remove lock_page_killable()

 fs/cifs/file.c          | 17 ++++++++---------
 include/linux/pagemap.h | 10 ----------
 2 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.35.1

