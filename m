Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC223974AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhFAN5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 09:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhFAN5R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:57:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D2D7613AD;
        Tue,  1 Jun 2021 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622555736;
        bh=YN7o5f9fBCBFbH2qZ6cL/jNoKOfjGMbMwEHCND+A5ek=;
        h=From:To:Cc:Subject:Date:From;
        b=gWRDASJonbR+b56GSuyJ0eRh0DYFtmm8FB4bGZOZvGpmkJbtt85zJImnfBjyMFys+
         hqa2DT9OM8+W9FVPwGIRSuE9/gcjVn8sKKL0eAJJCb7ZpPSJYvE+RG9xUc0XFRgP/Y
         aaeHMdVbvjkYHcoII4ysoGbjJLD6Vw/sVMjp2gFp8OrcrwMyAS6lXCo58V1SvwT1+j
         ONEzJZlLrm2OxBY0Bh2iTYmsClqCxMVK9x3XTC7i7RX9wdQ/RZDv8fNw5Jjr2RXyYr
         RlxAs5ArIpYuStA3AQMaWZDRgBhXLj709B7i4jYdK5/904owK0jpRY2CfH4gTb9vKr
         5IiNLkOZx338w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Ross Zwisler <zwisler@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/2] mount: add "nosymfollow" support to new mount api 
Date:   Tue,  1 Jun 2021 15:55:13 +0200
Message-Id: <20210601135515.126639-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; h=from:subject; bh=2VOLKzrE9sAWczuMjbrHDrSkmmBg/7JOJuGDMktJ6ao=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRss7EvryucfHz/Z3PPZFGWqrSQyAlv2Rd1bg5Z0qfZ1nd5 yRPRjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkoCjAybLPS5PzIFxx8opBBMua07n En/t59PRJR75euuuYc/UXkBcP/qH8/HLze9BcvEG5/0iYcZPSwcsfZkAsxB7itPtv8s+phBwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

When we introduced "nosymfollow" we didn't add support for it to the new
mount api. Fix that so users making use of the new mount api can
specifiy it in fsmount() and mount_setattr().

This also adds tests.
This is obviously v5.14 material without the need to rush. This can be
found at:

https://git.kernel.org/brauner/h/fs.mount_setattr.nosymfollow

Thanks!
Christian

Christian Brauner (2):
  mount: Support "nosymfollow" in new mount api
  tests: test MOUNT_ATTR_NOSYMFOLLOW with mount_setattr()

 fs/namespace.c                                |  9 +-
 include/uapi/linux/mount.h                    |  1 +
 .../mount_setattr/mount_setattr_test.c        | 88 ++++++++++++++++++-
 3 files changed, 92 insertions(+), 6 deletions(-)


base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
-- 
2.27.0

