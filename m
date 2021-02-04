Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2213530EF81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhBDJUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 04:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbhBDJUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:20:33 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC2C0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 01:19:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lg21so4141521ejb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8lxogqlMZgpD9J7gbgqwGDjE7NKX9NOMGrM6eS5WeBQ=;
        b=QdCtg961nF58oQwzzj/FzDEuBgWW7M25dZnVjXoEgymQXTCxy0678cMv6XetCZpUaZ
         qGUlVnZB3LpsWGlT71eX2hazbFGUU2pF0XcdLR33Ivk89k8hrz5XdRrgSaJhJCaZhyfT
         OdwMZ5PMaqR3dd5Kq5eizc2wWsP0JYooM+DK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8lxogqlMZgpD9J7gbgqwGDjE7NKX9NOMGrM6eS5WeBQ=;
        b=s+5QQS7GdXRIbbyXPXd1h+ctZxI4c1fLvJZcwEhUdQu4Y86QiZj4zisgsRg40i4JsK
         Tyt537+r3tPW2v3VDFiANHQPFXMCYUElRz+fr1VGdqwIB7MOHexaIgA86CnlttL1vnRi
         f7C7M3GRlPYge9mowmJ3I05l+Uh/JPRm7UNneuG8EBZhyv7OxjadewxJ8W9ePPXsqNiK
         CSC4PY96UwLfoMtiXixOFgsA/ltMbD2hkqWc8HOTOd0SVxC52jNJIQS5OM908ELETPQF
         rgSViivcUWbZWjlAszF8LXYOq0jB2OPd5sGQ3R7EtgiyOnu4jmpp3NreRWX6NIiYzEfn
         Pc9w==
X-Gm-Message-State: AOAM530FHEnaR3Vaj6rIuLsv2kPxnBF/6oF+0Zm6uDOn5rUS4pok0y3C
        jEJVb8mCmn1/bIV4Ru4N73vtag==
X-Google-Smtp-Source: ABdhPJzueTAe+j4RnxD8AuLmdsIejqrJgdfclHJVHYp18QuH68ItotqE3diVPpuh2mkrAQoj3CScEw==
X-Received: by 2002:a17:906:2d0:: with SMTP id 16mr7353415ejk.373.1612430391385;
        Thu, 04 Feb 2021 01:19:51 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id k26sm2255486eds.41.2021.02.04.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 01:19:50 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:19:43 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.11-rc7
Message-ID: <20210204091943.GA1208880@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.11-rc7

- Fix capability conversion and minor overlayfs bugs that are related to
  the unprivileged overlay mounts introduced in this cycle.

- Fix two recent (v5.10) and one old (v4.10) bug.

- Clean up security xattr copy-up (related to a SELinux regression).

Thanks,
Miklos

---
Amir Goldstein (1):
      ovl: skip getxattr of security labels

Liangyan (1):
      ovl: fix dentry leak in ovl_get_redirect

Miklos Szeredi (4):
      ovl: add warning on user_ns mismatch
      ovl: perform vfs_getxattr() with mounter creds
      cap: fix conversions on getxattr
      ovl: avoid deadlock on directory ioctl

Sargun Dhillon (1):
      ovl: implement volatile-specific fsync error behaviour

---
 Documentation/filesystems/overlayfs.rst |  8 ++++
 fs/overlayfs/copy_up.c                  | 15 ++++----
 fs/overlayfs/dir.c                      |  2 +-
 fs/overlayfs/file.c                     |  5 ++-
 fs/overlayfs/inode.c                    |  2 +
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  2 +
 fs/overlayfs/readdir.c                  | 28 +++++---------
 fs/overlayfs/super.c                    | 38 +++++++++++++++----
 fs/overlayfs/util.c                     | 27 +++++++++++++
 security/commoncap.c                    | 67 +++++++++++++++++++++------------
 11 files changed, 136 insertions(+), 59 deletions(-)
