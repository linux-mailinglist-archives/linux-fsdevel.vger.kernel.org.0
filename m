Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D243C88B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhGNQgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhGNQgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:36:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21DC06175F;
        Wed, 14 Jul 2021 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E59m+GVi094TFbvrpSAWW/RQt7HioINU7/WpCpCjfvc=; b=LUfBwxZqenfCEIRbP6xn2QbZBz
        kZhnaWUaA955PFYVElevkwXFpftL17iuvQ/xHo7W/M0+DBG2zgEysfFqLm1qwbwT2fDYwPx7IaTyG
        0qnFXxlFHXJiXjK5eZBVBJMpg2KBWxGehT9cerDEMd00tEi9eUCnq/je5WXz/621+Ti7AFGSuT8uc
        lh0FeDDwTDmZfpYUUgeOLBvX/sAQd/UHLlk3gz6OZSP2l/PHuvnPbSRVArKtd61omG5e+0ZCxQlPB
        cVIiNGE1kzpjE0/SLpDOU6knTGeBexaEXRcbf/qnUao+/BZEJudTO7dDA119oN6y4xTu6TrIx3qnO
        C6ov6SBQ==;
Received: from [2001:4bb8:184:8b7c:cf3c:edf1:863a:f995] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3hoq-002NR1-Hg; Wed, 14 Jul 2021 16:33:12 +0000
Date:   Wed, 14 Jul 2021 18:33:07 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] configfs fix for Linux 5.14
Message-ID: <YO8Rw23KxCDjzKeA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 7fef2edf7cc753b51f7ccc74993971b0a9c81eca:

  sd: don't mess with SD_MINORS for CONFIG_DEBUG_BLOCK_EXT_DEVT (2021-07-12 12:25:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.13-1

for you to fetch changes up to 420405ecde061fde76d67bd3a67577a563ea758e:

  configfs: fix the read and write iterators (2021-07-13 20:56:24 +0200)

----------------------------------------------------------------
configfs fix for Linux 5.14

 - fix the read and write iterators (Bart Van Assche)

----------------------------------------------------------------
Bart Van Assche (1):
      configfs: fix the read and write iterators

 fs/configfs/file.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)
