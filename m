Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77DB216BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGGLpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGGLpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:45:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0FAC08C5DF
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 04:45:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s9so46825388ybj.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LLQSBg64iwWxTtcpWWM6iR9wTgF8QbEH02Vy+2bg9Hg=;
        b=vaUinhNZkQN3RAVXNuIvu2m9UALKLZu6+nRg7EiTfijttvY5uvU/HlfVTs6MFI3BjD
         Er2jhbF7pByOmGUAkA0Rwjx6r1yRJYYD9O+cl25wvja83NKdtmmp1zngnkV02lhR5H60
         b5PjacpY1TP2NcUr9fiYcugKPCAjjR9rmlEhUHB0wiSX4QdOcSpvSGrvsQV0rT/nifCK
         2ZKi0Cmb2t3TuutVgBjI50QCH9omrBcU2W/h5TS/pS3DnoIpdnsJzSM7wmedPsCcY2wS
         ytB1vf691KXilc3nIafaO0kmcuwa8X3LA+tSoYg6SrxvtuS6RBnGMpkCLIhuojqhRuKM
         4b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LLQSBg64iwWxTtcpWWM6iR9wTgF8QbEH02Vy+2bg9Hg=;
        b=J5oRr6ASOnOijBovkq0nwJLMtYgjETrIdTfNAk7M3vK+gdZ2nBeCQGv9NZ8JcrDhYU
         lsT3/n9j7czXRhBP8wxYhN8mi+Z4I2O5DlrmxewDtqrcVbf3sXCnEL9KWXCAVrc2Qt4F
         sKBRG5IqSndtBDtXHwZ/lSJ8l9UxsAmn1yONZWzzU0kDvUh8QTz3gZclxc69Euzp0V41
         m186CVbT7QzjKGwdBhLPBJNAKBA2kceQ52LQTRLHUpEZf9VAeiuaOvnRrUNY6tKIqZJ4
         vpWmwtTBDS1bTUUgzleLFLdwIwSyMj563UvZW+uOG1SuYj758qny48UXRXuGd/ZvYCje
         qMBw==
X-Gm-Message-State: AOAM531yS/DA1QQnbfl5PZoMEnJtXyPCb1xTQYj4ib2O9UQqeY3jILLM
        4h1r7cYkeKPpmPMM0SZbZ8RADNzTEco=
X-Google-Smtp-Source: ABdhPJwLxIHBchd80Gve4mlw6g7Mb8civMvZG5ZcJoCOlzyO/mCAmx2JmX2IzIWBOuqsBIRGM+219TLjngU=
X-Received: by 2002:a25:b903:: with SMTP id x3mr32504935ybj.445.1594122311275;
 Tue, 07 Jul 2020 04:45:11 -0700 (PDT)
Date:   Tue,  7 Jul 2020 04:31:19 -0700
Message-Id: <20200707113123.3429337-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v10 0/4] Prepare for upcoming Casefolding/Encryption patches
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This lays the ground work for enabling casefolding and encryption at the
same time for ext4 and f2fs. A future set of patches will enable that
functionality.

These unify the highly similar dentry_operations that ext4 and f2fs both
use for casefolding. In addition, they improve d_hash by not requiring a
new string allocation, and ensure we don't attempt to casefold the no-key
token of an encrypted filename.

Daniel Rosenberg (4):
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support

 fs/ext4/dir.c           | 64 +--------------------------
 fs/ext4/ext4.h          | 12 ------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 20 ++++-----
 fs/ext4/super.c         | 12 +++---
 fs/f2fs/dir.c           | 83 ++++-------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 fs/libfs.c              | 96 +++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  | 23 +++++++++-
 include/linux/f2fs_fs.h |  3 --
 include/linux/fs.h      | 16 +++++++
 include/linux/unicode.h |  3 ++
 14 files changed, 174 insertions(+), 184 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

