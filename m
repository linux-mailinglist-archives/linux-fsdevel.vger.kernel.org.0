Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411791B2874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgDUNvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:51:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728651AbgDUNvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IInilyB2ckeUfP1pJZsdQY8G2HWtqy1MvibEpjmv5kQ=;
        b=LmvZvg2I11XAbDZc/v16ulUtX5/yN/Qr1RKH/fEYFr+sbuqJk1u/HrUZJUCOvDstR0yqa2
        hpPpv8ceSBWzkGi6Cej95MQPzrt4iOMPovPn/Tg+F7g3VuuZrms01O+xf/g7RFhoIwBzYa
        9dvFTI2GlIhBvTd7frzVUBY1+GS/0B8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-FoD-eoaBPxGLBr98wkjdFw-1; Tue, 21 Apr 2020 09:51:42 -0400
X-MC-Unique: FoD-eoaBPxGLBr98wkjdFw-1
Received: by mail-wr1-f72.google.com with SMTP id i10so7500793wrq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IInilyB2ckeUfP1pJZsdQY8G2HWtqy1MvibEpjmv5kQ=;
        b=oQlZaoruV7ZXqwvs7yab5cfsp/Zsjl8PQ/j7iH+ODFC6/pzsKPIzOj2EYWL9HIvelJ
         d/c73204RrPwzSokbh9MEnvu4bd+HHR+OB73ytoOWgqJBk6AGUhc9SH4eIviSvQcE79/
         sedvG/qCzWlufsFjJdynTCNC18FewpxlxFpkY/U14g8WPd/Wohq8+biwxVSQUbs3Uy7w
         wT9Rs6Xh7dg29Ofqe4fjLAsYqTV/D1pXa2aI6vc2anwDi0lYSI0SHoFIY77tPoEXBS1M
         rFHyGLZy+urPTM6R+GOmFamX4MD6c1v9LtVH+DpbxBT7a08Gl7fTQAXSqbAhTwgOWJd4
         EaXQ==
X-Gm-Message-State: AGi0PubP5E9PhjxmhhgPXOiOLwBJf6W7LM8WNTCU8IK2dWsKvn3uKDGO
        nOldbU3yi/tS8F6fpub4psKtvXfyC/hiUM9ikEbRNaL9dNZPavtdsnKn8aL2XElEz7Sg0tn15tt
        mnMRWju2IXGajjLJ16yIuzosK+A==
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr4916145wmf.3.1587477100754;
        Tue, 21 Apr 2020 06:51:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypL9ml34u2SXsT4cym73Fj9YcZ5gNZl/Vlb+iTik+1IYxflheOGQshudBA/kLdh/qIi+ct+15w==
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr4916110wmf.3.1587477100572;
        Tue, 21 Apr 2020 06:51:40 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id a187sm3565830wmh.40.2020.04.21.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:51:40 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 0/7] libfs: group and simplify linux fs code
Date:   Tue, 21 Apr 2020 15:51:12 +0200
Message-Id: <20200421135119.30007-1-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

libfs.c has many functions that are useful to implement dentry and inode
operations, but not many at the filesystem level.  As a result, code to
create files and inodes has a lot of duplication, to the point that
tracefs has copied several hundred lines from debugfs.

The main two libfs.c functions for filesystems are simple_pin_fs and
simple_release_fs, which hide a somewhat complicated locking sequence
that is needed to serialize vfs_kern_mount and mntget.  In this series,
my aim is to add functions that create dentries and inodes of various
kinds (either anonymous inodes, or directory/file/symlink).  These
functions take the code that was duplicated across debugfs and tracefs
and move it to libfs.c.

In order to limit the number of arguments to the new functions, the
series first creates a data type that is passed to both
simple_pin_fs/simple_release_fs and the new creation functions.  The new
struct, introduced in patch 2, simply groups the "mount" and "count"
arguments to simple_pin_fs and simple_release_fs.

Patches 1-4 are preparations to introduce the new simple_fs struct and
new functions that are useful in the remainder of the series.  Patch 5
introduces the dentry and inode creation functions.  Patch 6-7 can then
adopt them in debugfs and tracefs.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

v1->v2: rename simple_new_inode in new_inode_current_time,
more detailed explanations, put all common code in fs/libfs.c

Emanuele Giuseppe Esposito (7):
  apparmor: just use vfs_kern_mount to make .null
  libfs: wrap simple_pin_fs/simple_release_fs arguments in a struct
  libfs: introduce new_inode_current_time
  libfs: add alloc_anon_inode wrapper
  libfs: add file creation functions
  debugfs: switch to simplefs inode creation API
  tracefs: switch to simplefs inode creation API

 drivers/gpu/drm/drm_drv.c       |  11 +-
 drivers/misc/cxl/api.c          |  13 +-
 drivers/scsi/cxlflash/ocxl_hw.c |  14 +-
 fs/binfmt_misc.c                |   9 +-
 fs/configfs/mount.c             |  10 +-
 fs/debugfs/inode.c              | 158 +++--------------
 fs/libfs.c                      | 299 ++++++++++++++++++++++++++++++--
 fs/tracefs/inode.c              |  96 ++--------
 include/linux/fs.h              |  31 +++-
 security/apparmor/apparmorfs.c  |  38 ++--
 security/inode.c                |  11 +-
 11 files changed, 399 insertions(+), 291 deletions(-)

-- 
2.25.2

