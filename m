Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44A217D48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGHDF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgGHDF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:05:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6EC08C5E1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 20:05:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 8so886126pjk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 20:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sxoy6q+HxdTygJctVhkj+Ncax7HD8YrVRDBUHbmI/GA=;
        b=jvxGSCDzgqCSzD3A5CZ6zoxEY3HwELi8FObL00AmNlxQWLpvrUeBFZBc3B9zB5etbX
         mYEpJX0jRgUUJ4S9ot+BQk61eRDjpYkKZjXS5FkMSOUavjWBlMPiA5+LW/699y0iXpQC
         s8ynNf8lIHMTPkHzVRmSAVfDowYI++DiMfl/exKk9l+l/8eEG3w0s91A1Ycqqyju5MfB
         hrssrkk130gtKV4YYHCQ2dycaO4RT4XQHdC+kpGmlUYHSXN8zNcGMq9fWspZLGH9mYPU
         dePpa1pDLmtFFKbvxkZX6SahRyc7gjEHircUdtQBKPXrVPw+ESEA+mxA7Fqh1xXzohzl
         +nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sxoy6q+HxdTygJctVhkj+Ncax7HD8YrVRDBUHbmI/GA=;
        b=I+DbhucibIrfMRF5hPJRb4rbwgX4TQg3AnNTkZLi/oVz6tPsxzzLl8LYrlU0GQxBHc
         CZ1Do8U7gXhkxUKRTIPePsrniDli9ivJrvQNPx9+CJ2ZuCyrRqeBDdNSjG+3Zyayte8U
         7J5eegfzPKSfI2HWKj203tqfy54p9E+a1XCkvwFCRR/PBk/5Ky55wpH6+zpjaS9MDHme
         IzySAQ5p8+qdDGgrGo1DGBQNcZSmF/v9bUqiBu7v7tzvKDR+C/7EJeV6AalbXMKPthU5
         yeBTI8vr0t5dotRCR5yV/Fsi4crB4oc0qUKdy9mrnQieNj8UZuJDz0i3ozP1hfhJOzc8
         zoNg==
X-Gm-Message-State: AOAM530xDhepw6LFFiTYVljUP5OlOvxGYLqPAK2umChqezEwF+pIaY0v
        YfX+PqbKPf4/NXT8WHcoZ1Lrrm4lGLA=
X-Google-Smtp-Source: ABdhPJxHc+FKhRyKZRaUpdsFwS/kCIg/eIMdmz1LxIxSnZIjP9Kv5YSfmEOlULOG9PgVuLCQSbtYJSctP7g=
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr1032734pjz.1.1594177556279;
 Tue, 07 Jul 2020 20:05:56 -0700 (PDT)
Date:   Tue,  7 Jul 2020 20:05:48 -0700
Message-Id: <20200708030552.3829094-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v11 0/4] Prepare for upcoming Casefolding/Encryption patches
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
new string allocation.

Daniel Rosenberg (4):
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support

 fs/ext4/dir.c           | 64 +---------------------------
 fs/ext4/ext4.h          | 12 ------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 20 ++++-----
 fs/ext4/super.c         | 12 +++---
 fs/f2fs/dir.c           | 84 ++++--------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 fs/libfs.c              | 94 +++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  | 23 +++++++++-
 include/linux/f2fs_fs.h |  3 --
 include/linux/fs.h      | 16 +++++++
 include/linux/unicode.h |  3 ++
 14 files changed, 172 insertions(+), 185 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

