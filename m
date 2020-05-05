Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC01C5248
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgEEJ70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEJ7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d9/2/ImBBU1sG2WjASIeQFuxFx4M1cJ3aHV1v3tGabw=;
        b=F60945qoQuAJrw+sfJ0nKxwcAitH+Y0nsX3rpNW+XsPp1gi1EVo237qaz5RrS+3RWHawLP
        WHiRp/YAPDzegbJI0KPuA2P0/DHGjrYWSuvAI2HzXB89XBp9IEFTq9cLwjhvigpkBF52pa
        X4bvLDZo73acVDLVq8IlwutHqbj8IW0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-B5hTSbOPMWqHQ2FQitOtyA-1; Tue, 05 May 2020 05:59:18 -0400
X-MC-Unique: B5hTSbOPMWqHQ2FQitOtyA-1
Received: by mail-wr1-f71.google.com with SMTP id y4so975765wrt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9/2/ImBBU1sG2WjASIeQFuxFx4M1cJ3aHV1v3tGabw=;
        b=PGcTPqLw3znJCHMeZGL8AJmpHrgXQDShr5PyWk1vOmnfrrnnfPyk90S6GfOW5GHbFz
         PLNz4a7jlJBPm6tVSOMVHfNU+mZKPLkV8nBdoAxS9Dnjvwkxhcx2WewL+0WTKQeVjs36
         RS2v+QyIDK8xg9jJ8VP449wkeaTRGC0dXGcowVF5fP58yAwDW054t6lIQMPYHBqevaFV
         aMFLFvAMNx2SXmnTWPPpcKdnSR2tU+VvEyH05G2jJPJtWa0ql8VoQrOcd6ydnoMjvOTS
         lTerq5NvK0KbUBhdVA72PVAwaRX6kxAGmbCK+2Zs5e/NyzVFJ6YKw52MzOPOWuesGU3h
         iyBQ==
X-Gm-Message-State: AGi0PuZonT6d/O8csUHc3Ps+ZscW0dTbDxwuASZbh4mJz6YG4OPLlE7P
        CWAv/B++dDoEwVeJgtj+b4LFFDlRY8u8q2hHMw3OWB/tHwKsqTCNaYuiNe3yXqkSLZh6mtl2Q61
        OmrvKswCwYd4B8zXWj69clWl5Tw==
X-Received: by 2002:adf:f887:: with SMTP id u7mr2639849wrp.369.1588672757613;
        Tue, 05 May 2020 02:59:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1+OcWXvT3aZYh6O/chdJ53csJsKP3XZQmR6UManXO1rhDsdlp4BJXFoNOskV4H5RzOMjxmA==
X-Received: by 2002:adf:f887:: with SMTP id u7mr2639831wrp.369.1588672757414;
        Tue, 05 May 2020 02:59:17 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:16 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/12] vfs patch queue
Date:   Tue,  5 May 2020 11:59:03 +0200
Message-Id: <20200505095915.11275-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Can you please apply the following patches?

All of these have been through the review process, some have been through
several revisions, some haven't gotten any comments yet.

Git tree is here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git for-viro

Thanks,
Miklos

Miklos Szeredi (12):
  vfs: allow unprivileged whiteout creation
  aio: fix async fsync creds
  proc/mounts: add cursor
  utimensat: AT_EMPTY_PATH support
  f*xattr: allow O_PATH descriptors
  uapi: deprecate STATX_ALL
  statx: don't clear STATX_ATIME on SB_RDONLY
  statx: add mount ID
  statx: add mount_root
  vfs: don't parse forbidden flags
  vfs: don't parse "posixacl" option
  vfs: don't parse "silent" option

 fs/aio.c                        |  8 +++
 fs/char_dev.c                   |  3 ++
 fs/fs_context.c                 | 30 -----------
 fs/mount.h                      | 12 +++--
 fs/namei.c                      | 17 ++----
 fs/namespace.c                  | 91 +++++++++++++++++++++++++++------
 fs/proc_namespace.c             |  4 +-
 fs/stat.c                       | 11 +++-
 fs/utimes.c                     |  6 ++-
 fs/xattr.c                      |  8 +--
 include/linux/device_cgroup.h   |  3 ++
 include/linux/mount.h           |  4 +-
 include/linux/stat.h            |  1 +
 include/uapi/linux/stat.h       | 18 ++++++-
 samples/vfs/test-statx.c        |  2 +-
 tools/include/uapi/linux/stat.h | 11 +++-
 16 files changed, 153 insertions(+), 76 deletions(-)

-- 
2.21.1

