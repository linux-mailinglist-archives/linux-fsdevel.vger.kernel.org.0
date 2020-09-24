Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D52767D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIXE3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 00:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIXE3B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:29:01 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C260E20888;
        Thu, 24 Sep 2020 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600921741;
        bh=rO/bNcZHwLT9QTBkuyjZ4ahgv+SZFROlqsq/52bymt0=;
        h=From:To:Cc:Subject:Date:From;
        b=Rs5Fnpx1+kMOIPp6FrLcwizUYAmnr1trqn6z58T4WhfCNzSfjwSkIuvmrCLNNKuYV
         h83JFF9l8jBLk1oFYxyaFvH/LUHYjCSMon4nXUxTY7K8bQM01kFjKU3t49ioWLBDsM
         ZJzba7PzU5Ino48o+muguuzoP2FYvRDOSDaHNrdQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] fscrypt: avoid ambiguous terms for "no-key name"
Date:   Wed, 23 Sep 2020 21:26:22 -0700
Message-Id: <20200924042624.98439-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes overloading of the terms "ciphertext name" and
"encrypted name" to also sometimes mean "no-key name".
The overloading of these terms has caused some confusion.

No change in behavior.

Eric Biggers (2):
  fscrypt: don't call no-key names "ciphertext names"
  fscrypt: rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME

 fs/crypto/fname.c       | 16 ++++++++--------
 fs/crypto/hooks.c       | 13 ++++++-------
 fs/f2fs/dir.c           |  2 +-
 include/linux/dcache.h  |  2 +-
 include/linux/fscrypt.h | 25 ++++++++++++-------------
 5 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.28.0

