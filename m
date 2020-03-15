Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20475185E53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgCOPxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 11:53:55 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:7014 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgCOPxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:53:55 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id AAAA226111A;
        Sun, 15 Mar 2020 23:53:37 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Eric Biggers <ebiggers@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v2,2/2] doc: zh_CN: add translation for virtiofs
Date:   Sun, 15 Mar 2020 08:52:39 -0700
Message-Id: <20200315155258.91725-2-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315155258.91725-1-wenhu.wang@vivo.com>
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
 <20200315155258.91725-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVCT0xLS0tLSU1MS0lDQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6NBw5KTg9MDcfSRw3KT1K
        EzQwFDZVSlVKTkNPSUNMTUlNT0tLVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQU1NQkw3Bg++
X-HM-Tid: 0a70dee6a0899375kuwsaaaa226111a
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Translate virtiofs.rst in Documentation/filesystems/ into Chinese.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changelog v2:
 - add a blank line in the end of index.rst to index virtiofs.rst
 - Asked-by Stefan Hajnoczi
 - added SPDX header and Copyright info
---
 Documentation/filesystems/virtiofs.rst        |  2 +
 .../translations/zh_CN/filesystems/index.rst  |  2 +
 .../zh_CN/filesystems/virtiofs.rst            | 61 +++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs.rst

diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index 4f338e3cb3f7..7c4301d962f8 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -1,3 +1,5 @@
+.. _virtiofs_index:
+
 .. SPDX-License-Identifier: GPL-2.0
 
 ===================================================
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index 0a2cabfeaf7b..fd3700a4db6d 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -27,3 +27,5 @@ Linux Kernel中的文件系统
 .. toctree::
    :maxdepth: 2
 
+   virtiofs
+
diff --git a/Documentation/translations/zh_CN/filesystems/virtiofs.rst b/Documentation/translations/zh_CN/filesystems/virtiofs.rst
new file mode 100644
index 000000000000..cd836a9b2ac4
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/virtiofs.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. raw:: latex
+
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/filesystems/virtiofs.rst <virtiofs_index>`
+
+译者
+::
+
+	中文版维护者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+	中文版翻译者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+	中文版校译者:  王文虎 Wang Wenhu <wenhu.wang@vivo.com>
+
+===========================================
+virtiofs: virtio-fs 主机<->客机共享文件系统
+===========================================
+
+- Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
+
+介绍
+====
+Linux的virtiofs文件系统实现了一个半虚拟化VIRTIO类型“virtio-fs”设备的驱动，通过该\
+类型设备实现客机<->主机文件系统共享。它允许客机挂载一个已经导出到主机的目录。
+
+客机通常需要访问主机或者远程系统上的文件。使用场景包括：在新客机安装时让文件对其\
+可见；从主机上的根文件系统启动；对无状态或临时客机提供持久存储和在客机之间共享目录。
+
+尽管在某些任务可能通过使用已有的网络文件系统完成，但是却需要非常难以自动化的配置\
+步骤，且将存储网络暴露给客机。而virtio-fs设备通过提供不经过网络的文件系统访问文件\
+的设计方式解决了这些问题。
+
+另外，virto-fs设备发挥了主客机共存的优点提高了性能，并且提供了网络文件系统所不具备
+的一些语义功能。
+
+用法
+====
+以``myfs``标签将文件系统挂载到``/mnt``:
+
+.. code-block:: sh
+
+  guest# mount -t virtiofs myfs /mnt
+
+请查阅 https://virtio-fs.gitlab.io/ 了解配置QEMU和virtiofsd守护程序的详细信息。
+
+内幕
+====
+由于virtio-fs设备将FUSE协议用于文件系统请求，因此Linux的virtiofs文件系统与FUSE文\
+件系统客户端紧密集成在一起。客机充当FUSE客户端而主机充当FUSE服务器，内核与用户空\
+间之间的/dev/fuse接口由virtio-fs设备接口代替。
+
+FUSE请求被置于虚拟队列中由主机处理。主机填充缓冲区中的响应部分，而客机处理请求的完成部分。
+
+将/dev/fuse映射到虚拟队列需要解决/dev/fuse和虚拟队列之间语义上的差异。每次读取\
+/dev/fuse设备时，FUSE客户端都可以选择要传输的请求，从而可以使某些请求优先于其他\
+请求。虚拟队列有其队列语义，无法更改已入队请求的顺序。在虚拟队列已满的情况下尤
+其关键，因为此时不可能加入高优先级的请求。为了解决此差异，virtio-fs设备采用“hiprio”\
+（高优先级）虚拟队列，专门用于有别于普通请求的高优先级请求。
-- 
2.17.1

