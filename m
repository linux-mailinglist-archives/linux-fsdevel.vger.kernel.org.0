Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA7393FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhE1J2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 05:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhE1J2Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 05:28:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75BCB61183;
        Fri, 28 May 2021 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622194011;
        bh=7sb7LkWt1Nj8Y8So80VR7UwfMAFVmUGr91m14h5P+98=;
        h=From:To:Cc:Subject:Date:From;
        b=hCXcVJF/SVdoMUd9ZK4DALkvqK34SyapYUK2OKWenxwDNVTucsfw+x7ICvd9fBEXh
         +Gwjmncn85A/0pwM6z80zDfBtj1qBifDCbgYKCsfRW+exh+qaUCW7HBeKzeOX0MQ25
         Ibj0NQ1cQanJ4/42cS9QXxK9vwxfLbH+ROlHOwHuQhs6Lgs0QlanOYccjxMzxaPZrX
         fxCp8pGGqI6EixTsG1nfqzNYwBH3WNZOX8UDR2bmFpGD/THxAWbMlOYFbXUoaesYhn
         CMqZqKvoTdNxIqRKWmohAJCyb+8+rdjV7rHrVeCMEbiGa5R6ca3XrnJxlDbyvwK2tx
         G8ts1Mod2T/7Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/3] openat2: flag fixes
Date:   Fri, 28 May 2021 11:24:14 +0200
Message-Id: <20210528092417.3942079-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

A few fixes and tests to openat2 to prevent silent truncation when
passing in flags in the upper 32 bits.
With the feedback from Richard worked in I picked this up so it can sit
in -next for a bit.

Thanks!
Christian

Christian Brauner (3):
  fcntl: remove unused VALID_UPGRADE_FLAGS
  open: don't silently ignore unknown O-flags in openat2()
  test: add openat2() test for invalid upper 32 bit flag value

 fs/open.c                                      | 14 +++++++++++---
 include/linux/fcntl.h                          |  4 ----
 tools/testing/selftests/openat2/openat2_test.c |  7 ++++++-
 3 files changed, 17 insertions(+), 8 deletions(-)


base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.27.0

