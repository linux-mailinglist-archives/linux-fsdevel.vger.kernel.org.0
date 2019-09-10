Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C767AEE43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393854AbfIJPMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 11:12:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393840AbfIJPMQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:16 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AD2383F4C
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 15:12:15 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so1473779wmd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 08:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAN7nnEOH+Yjifk4c+jX2lC/QmauX+hAkPf3AFHmQks=;
        b=tTdxeAI5aYu7fdj0flw56sXajSn60naeEUtny/5tkR+Pyn4skxvNz/ZxfIF+AVXNbv
         OAjzNi4K0OH0Mey116ZhMZGPbgr9IKuo4uIzvuLizPSWCfpOKbqAbw9OyKGJTsyB1Rqs
         L7pMEbyVffaFrkqN38mP0tnipkukpiNmZAcwxvpCF53iY1P+CKY8BfWi0g2Q+2QJUQzW
         9fvh2jk5+xhGZM6JLYHG1ZmBeB9RLLYrBhyfaWljfldGRL+kxvRfYxZff7iHhhZnUyaz
         nponX/kqjEcpcGXfyGw+jqZU05Ijzse/TeMEjfm+9KXOT8shgLfvn7zhxxlcrz1CJOjR
         7wvw==
X-Gm-Message-State: APjAAAVaWtgboIttIpnzlxn5gOozlLxkCaixlCk6g+lKS206DS+T0Nzx
        4pAVQQlP4BBlsdh/3fhDQBXWhHkicwI2iX1P6L3eUxihkJhuQnw0vwtxSo6f/GdMixsrH8ldd4n
        bhguvSY8tgxTvptMARyf9R51dPw==
X-Received: by 2002:adf:9050:: with SMTP id h74mr26234790wrh.191.1568128333801;
        Tue, 10 Sep 2019 08:12:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvOQRQwrn10rdgOMO23uRs00N8x3JYmcNUIw+5WHM1A0xUU4eykcv2yQqRRFgic5VK12F86w==
X-Received: by 2002:adf:9050:: with SMTP id h74mr26234766wrh.191.1568128333561;
        Tue, 10 Sep 2019 08:12:13 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g185sm12803wme.10.2019.09.10.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:12:13 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 3/4] virtio-fs: add Documentation/filesystems/virtiofs.rst
Date:   Tue, 10 Sep 2019 17:12:05 +0200
Message-Id: <20190910151206.4671-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
References: <20190910151206.4671-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add information about the new "virtiofs" file system.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/index.rst    | 10 +++++
 Documentation/filesystems/virtiofs.rst | 60 ++++++++++++++++++++++++++
 MAINTAINERS                            | 11 +++++
 3 files changed, 81 insertions(+)
 create mode 100644 Documentation/filesystems/virtiofs.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 2de2fe2ab078..56e94bfc580f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -32,3 +32,13 @@ filesystem implementations.
 
    journalling
    fscrypt
+
+Filesystems
+===========
+
+Documentation for filesystem implementations.
+
+.. toctree::
+   :maxdepth: 2
+
+   virtiofs
diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
new file mode 100644
index 000000000000..4f338e3cb3f7
--- /dev/null
+++ b/Documentation/filesystems/virtiofs.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
+virtiofs: virtio-fs host<->guest shared file system
+===================================================
+
+- Copyright (C) 2019 Red Hat, Inc.
+
+Introduction
+============
+The virtiofs file system for Linux implements a driver for the paravirtualized
+VIRTIO "virtio-fs" device for guest<->host file system sharing.  It allows a
+guest to mount a directory that has been exported on the host.
+
+Guests often require access to files residing on the host or remote systems.
+Use cases include making files available to new guests during installation,
+booting from a root file system located on the host, persistent storage for
+stateless or ephemeral guests, and sharing a directory between guests.
+
+Although it is possible to use existing network file systems for some of these
+tasks, they require configuration steps that are hard to automate and they
+expose the storage network to the guest.  The virtio-fs device was designed to
+solve these problems by providing file system access without networking.
+
+Furthermore the virtio-fs device takes advantage of the co-location of the
+guest and host to increase performance and provide semantics that are not
+possible with network file systems.
+
+Usage
+=====
+Mount file system with tag ``myfs`` on ``/mnt``:
+
+.. code-block:: sh
+
+  guest# mount -t virtiofs myfs /mnt
+
+Please see https://virtio-fs.gitlab.io/ for details on how to configure QEMU
+and the virtiofsd daemon.
+
+Internals
+=========
+Since the virtio-fs device uses the FUSE protocol for file system requests, the
+virtiofs file system for Linux is integrated closely with the FUSE file system
+client.  The guest acts as the FUSE client while the host acts as the FUSE
+server.  The /dev/fuse interface between the kernel and userspace is replaced
+with the virtio-fs device interface.
+
+FUSE requests are placed into a virtqueue and processed by the host.  The
+response portion of the buffer is filled in by the host and the guest handles
+the request completion.
+
+Mapping /dev/fuse to virtqueues requires solving differences in semantics
+between /dev/fuse and virtqueues.  Each time the /dev/fuse device is read, the
+FUSE client may choose which request to transfer, making it possible to
+prioritize certain requests over others.  Virtqueues have queue semantics and
+it is not possible to change the order of requests that have been enqueued.
+This is especially important if the virtqueue becomes full since it is then
+impossible to add high priority requests.  In order to address this difference,
+the virtio-fs device uses a "hiprio" virtqueue specifically for requests that
+have priority over normal requests.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd0..459b3fa8e25e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17117,6 +17117,17 @@ S:	Supported
 F:	drivers/s390/virtio/
 F:	arch/s390/include/uapi/asm/virtio-ccw.h
 
+VIRTIO FILE SYSTEM
+M:	Stefan Hajnoczi <stefanha@redhat.com>
+M:	Miklos Szeredi <miklos@szeredi.hu>
+L:	virtualization@lists.linux-foundation.org
+L:	linux-fsdevel@vger.kernel.org
+W:	https://virtio-fs.gitlab.io/
+S:	Supported
+F:	fs/fuse/virtio_fs.c
+F:	include/uapi/linux/virtio_fs.h
+F:	Documentation/filesystems/virtiofs.rst
+
 VIRTIO GPU DRIVER
 M:	David Airlie <airlied@linux.ie>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-- 
2.21.0

