Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CCA67A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfICLmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfICLmW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 153C74E925
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:21 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n6so8635308wrw.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAN7nnEOH+Yjifk4c+jX2lC/QmauX+hAkPf3AFHmQks=;
        b=BHumGccGi9g1xClHo2bH8IagBrSg0DvAgvFCmqAwiGPTIl7RyZHssdVd4X5UKjuv/H
         mLk8k9Rx0V6vOYQsY3zPzXJGDOFKrxS3yqDyFi6x+lNk3FrVf7tfS44XQd3kgEZ8Ryv2
         h1g6j2pq6+POC+3Xssz3Q+RXLUaj/FCimq0KCy22nbMGzViqUP080QHJIgE/jBEPhZGW
         NAXlCf1wIcmJRhhvYuCh21ilkX4yYEIDt7pPn1OD+la3gq/tYF/Pwb4E/DMYeJcdQ0pz
         Qyj3/9hQRzi6w6i5Vcs3b8eVomcH8PtIqqaI4JdDq1YWq7mz1yhioaFVo+RzS5bccUjs
         caMQ==
X-Gm-Message-State: APjAAAVVsSPWRNH2+lgHhs4tdZKvXEg3+wNFR5vVpIhxdMM4ExJzgCoD
        oy57YBu1aXVkvI3LLkLH1s2uz6mF9Ofd22kgZxvYSUYgc9w3CLQqI7q22v1EUtY8q0KCuwodfZ1
        mXqSX+HJOiWhhKUdQOm02Uo435Q==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr28211435wru.209.1567510939818;
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxBZwbWA+ixdgpc74X3E/33uuCSu4TTuS7g05oqkicDMw4i1d0jy4fyCnvZ596KAZw2h29cw==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr28211419wru.209.1567510939587;
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 16/16] virtio-fs: add Documentation/filesystems/virtiofs.rst
Date:   Tue,  3 Sep 2019 13:42:03 +0200
Message-Id: <20190903114203.8278-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
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

