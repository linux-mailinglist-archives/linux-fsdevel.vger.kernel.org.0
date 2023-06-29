Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131974305E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF2WYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2WYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:24:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199252D62;
        Thu, 29 Jun 2023 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j73TsJ8p6bLbCGEbkQLwUvgvSOenhS26pj4KF68J9QY=; b=RxoPjxQGYLUgC54v7oHes1xDio
        2Ifww8slldw/LrlgSJ/QP87+MQqsmgRDwFydFpk7HSUlbmSJt6D8H1tf0yFX8f27ufSzXOClu8DXp
        6hNg+1J6D9WLx/4EnVGG+67QAGc05pph6ynErKeCVYDb85LtREBoLA4arq5L5VlZT14/B05fKRbXl
        5PWg9Ip92QIfaN1CgjcJ7/67QF2aGFV91ghWWuKlcAAy2gYydHQnSbtGAbDiSRJ59lnBYWRaLOfya
        tW45bGTBPhLIpe0uzgL59e3NvWkTGLWw8dU4cGgIKzpw5nM+TAUFpQNqkQrywy1W/i5QcygbAVkKb
        2OO2FCnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qF03m-002KrV-3B;
        Thu, 29 Jun 2023 22:24:18 +0000
Date:   Thu, 29 Jun 2023 15:24:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arnd@arndb.de, matthieu.baerts@tessares.net, rdunlap@infradead.org,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: [GIT PULL] sysctl fixes for v6.5-rc1
Message-ID: <ZJ4EkpN71LEsakct@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit c6b0271053e7a5ae57511363213777f706b60489:

  Merge tag 'fs_for_v6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2023-06-29 13:39:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.5-rc1-fixes

for you to fetch changes up to 554588e8e932e7a0fac7d3ae2132f2b727d9acfe:

  sysctl: fix unused proc_cap_handler() function warning (2023-06-29 15:19:43 -0700)

----------------------------------------------------------------
sysctl-6.5-rc1-fixes

Linus, included in this pull request is just a minor fix which
Matthieu Baerts noted I had not picked up. I adjusted the Fixes
commit ID to reflect the latest tree.

----------------------------------------------------------------
Arnd Bergmann (1):
      sysctl: fix unused proc_cap_handler() function warning

 kernel/umh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
