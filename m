Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5F6B55A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCJXdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCJXdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:33:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3035A1C321;
        Fri, 10 Mar 2023 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CNl8Hp4SH69dRDEI3CTQtAM/rG11ZgGlp/t1ojj+irE=; b=JmAiUE1cpilzqc5dKzALezwzHd
        ejaD2mbvbe87MGZp7CXJseZaOPzsDiwGEefFWgh6+ZwsnwXAXqK2dKwffdnkgRxwIAmPXwR0rfDEi
        oGoKor47o3ERNELgLVrJ9v24FylEjj3EqhcPXflPyqTsED2Vrq3fqYA4TnbDY5/83mfkUQBB7judk
        AjhFgFJiR6039P0zDj1ZgLpOy9Hs1SliSNConBE0ULyrX7DOhQQ0JCsy1mzEVdS3465f00cin5i5+
        nx5IqEcnQ8mT6ZoaaXESWUaynywQCqNyS5u2ib+4DSykssW04sL1IJ3dlgHRlhIBI+9DsLxf0h2sp
        FofxyPsQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamED-00Gdav-Sl; Fri, 10 Mar 2023 23:32:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] x86: simplify sysctl registrations
Date:   Fri, 10 Mar 2023 15:32:46 -0800
Message-Id: <20230310233248.3965389-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are trivial conversions to reduce more code and avoid API calls
that we are deprecating [0].

[0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     

Luis Chamberlain (2):
  x86: simplify one-level sysctl registration for abi_table2
  x86: simplify one-level sysctl registration for itmt_kern_table

 arch/x86/entry/vdso/vdso32-setup.c | 11 +----------
 arch/x86/kernel/itmt.c             | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

-- 
2.39.1

