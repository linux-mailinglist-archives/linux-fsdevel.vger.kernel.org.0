Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C077110CC4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfK1P7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30868 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbfK1P7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QKhcWtDiS7/760SnkOxrpi6vYzcV3K4p0XWCddGTw50=;
        b=RNuV8zUM88HcfELkhrTgDR64C4h2xyTZc4lZlgG1jCmHFE3eSYGLRH0/VhxEpbQFC3+7Kq
        A02RemQk2YU32OvXtQwokGfJ+V+vdJCl6BuaA7JYHM3BfQqOVUV2I3AVc6j8M+BI0zofHG
        8d4HHLqCmf4DPYBFu3TRm6bc4CLA0kI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-48nzN6CvPLKlyQjgeC_UFg-1; Thu, 28 Nov 2019 10:59:44 -0500
Received: by mail-wm1-f70.google.com with SMTP id y14so3698726wmj.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3yhlwDOvg7AFEqMoOVR4Bjti5sAroqomITTwCcM79o=;
        b=c0/P8YzzqHQVMk3Ud4oum0FzhC1npKGdqFe6NQJGHz2yR2/gUfTGYehc0ydrVifhUX
         WLq9HuzcVkObBIoG3FfUBbG5aaptPVJvedHMyKUMa8A978+eBZ7Crs4elWtKdiCVrghS
         0ZVS+5q81G1Vpj23aTF1NNiypLpjkYhTew/jnn2rnAwhVyDkOynLCl4c6F0Jxpt1TN8r
         HrOPmaZwtr9ADU2YPhPcB5VOtn9eSSPUabfAkDQFpzWkXuvJvQm6Jcl/lQwarccr1oLR
         gVdEe62YYu9lMXp9Mb1Q2oWof0UToWuugGjoPQCTp76N6mmWsAyDPQ8pd4N8DuOYkLa5
         N89A==
X-Gm-Message-State: APjAAAVNC7oAHvi9B1XK0G4I8C6IlsyBPo50E2ML4jxNOcghTQpWdahH
        9tObgjqjstYBmR6+PTxFi1CbN1EPuaZ+nRuGmir2RdWtUwJ9YqTTzA3iqqsraepPRE7hRXGZme8
        aXy27ijMkGwJKtLeMSek5+ezIYA==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr9469227wrx.147.1574956782982;
        Thu, 28 Nov 2019 07:59:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqy56LD19VR8hVYgnLY51e7TZkC9A/+6AB9/Val4JzeZHKrsxlez4di8rIOvg2TnlqBLGtkNqA==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr9469217wrx.147.1574956782804;
        Thu, 28 Nov 2019 07:59:42 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:42 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/12] various vfs patches
Date:   Thu, 28 Nov 2019 16:59:28 +0100
Message-Id: <20191128155940.17530-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: 48nzN6CvPLKlyQjgeC_UFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

This is a dump of my current vfs patch queue, all have been posted in one
form or another.

Also available as a git branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#for-viro

Please apply.

Thanks,
Miklos
---

Miklos Szeredi (12):
  aio: fix async fsync creds
  fs_parse: fix fs_param_v_optional handling
  vfs: verify param type in vfs_parse_sb_flag()
  uapi: deprecate STATX_ALL
  statx: don't clear STATX_ATIME on SB_RDONLY
  utimensat: AT_EMPTY_PATH support
  f*xattr: allow O_PATH descriptors
  vfs: allow unprivileged whiteout creation
  fs_parser: "string" with missing value is a "flag"
  vfs: don't parse forbidden flags
  vfs: don't parse "posixacl" option
  vfs: don't parse "silent" option

 fs/aio.c                        |  8 ++++
 fs/char_dev.c                   |  3 ++
 fs/fs_context.c                 | 72 ++++++++++++---------------------
 fs/fs_parser.c                  | 19 ++++-----
 fs/namei.c                      | 17 ++------
 fs/stat.c                       |  4 +-
 fs/utimes.c                     |  6 ++-
 fs/xattr.c                      |  8 ++--
 include/linux/device_cgroup.h   |  3 ++
 include/linux/fs_parser.h       |  1 -
 include/uapi/linux/stat.h       | 11 ++++-
 samples/vfs/test-statx.c        |  2 +-
 tools/include/uapi/linux/stat.h | 11 ++++-
 13 files changed, 82 insertions(+), 83 deletions(-)

--=20
2.21.0

