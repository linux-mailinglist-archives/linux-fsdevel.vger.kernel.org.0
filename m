Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723AB744564
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 01:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjF3XxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 19:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3XxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:53:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30A10FD;
        Fri, 30 Jun 2023 16:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tBguVH6T/Ggb9KVY+w61Ct5mLTCQ9Iqp8l22Kr6DhxI=; b=MabUXmWDLVXSP2c2FuXcWIDfp1
        uUvyGklSWvPYC71KNDgurI2Y/1FclgUWbLmkS5nNRfp+1I/4prXDlmr/7DbL36Ij1kO+ErvMDp7Dm
        c0I40RudgurdGpW44pDi3U2yaMerbJKU4vnlqA4VP+SUTRdmWHBEtqkOHFyKrSz+ibBjbfLQENpyv
        sjUJGrF1XSW8qnNtUp50UbdxU5WiKEEjVoZ2yHrRshXqMx0F0zOu7NmHaXrFP3Y9j61oYVS1eThxS
        2Nsc1k6IZQflMH0tMy4VacldcwMqWeb6sf/MUucg0vptusfBvXG9QPkM/2YxxFdBYXtpSwDABu9eL
        fMr3jZZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qFNvE-004nU5-2m;
        Fri, 30 Jun 2023 23:53:04 +0000
Date:   Fri, 30 Jun 2023 16:53:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     trix@redhat.com, keescook@chromium.org, ebiederm@xmission.com,
        yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org
Subject: [GIT PULL] second set of sysctl fixes v6.5-rc1
Message-ID: <ZJ9q4AUkeaENryE7@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit b25f62ccb490680a8cee755ac4528909395e0711:

  Merge tag 'vfio-v6.5-rc1' of https://github.com/awilliam/linux-vfio (2023-06-30 15:22:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-fixes-v2-v6.4-rc1

for you to fetch changes up to 7fffbc71075dcb733068d711c2593127cdce86f0:

  sysctl: set variable sysctl_mount_point storage-class-specifier to static (2023-06-30 16:19:47 -0700)

----------------------------------------------------------------
sysctl-fixes-v2-v6.4-rc1

Just one minor nit I forgot to merge.

----------------------------------------------------------------
Tom Rix (1):
      sysctl: set variable sysctl_mount_point storage-class-specifier to static

 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
