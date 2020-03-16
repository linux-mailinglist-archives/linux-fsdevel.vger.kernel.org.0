Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27761869B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 12:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgCPLCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 07:02:55 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:43796 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgCPLCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:02:55 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id DC89A261636;
        Mon, 16 Mar 2020 19:02:43 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v3,2/2] doc: zh_CN: add translation for virtiofs
Date:   Mon, 16 Mar 2020 04:01:32 -0700
Message-Id: <20200316110143.97848-2-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316110143.97848-1-wenhu.wang@vivo.com>
References: <20200315155258.91725-1-wenhu.wang@vivo.com>
 <20200316110143.97848-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VOSE9CQkJDT0xPSklKSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhQ6FBw*FTg1SzZLMhIWMS8U
        HRIaCwJVSlVKTkNPSE5NTk1CTU5LVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUxKS0M3Bg++
X-HM-Tid: 0a70e3029e069375kuwsdc89a261636
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Translate virtiofs.rst in Documentation/filesystems/ into Chinese.

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changelog:
v2:
 - add a blank line in the end of index.rst to index virtiofs.rst
 - Asked-by Stefan Hajnoczi
 - added SPDX header and Copyright info
v3:
 - rm raw latex field in translations/zh_CN/filesystems/index.rst
   for none compatibility test with Sphinx 1.7.9 or later(only v1.6.7 avalible for me now).
 - mv SPDX-License-Identifier to the top
 - Reviewed-by labels added
---
 Documentation/filesystems/virtiofs.rst        |  2 +
 .../translations/zh_CN/filesystems/index.rst  |  2 +
 .../zh_CN/filesystems/virtiofs.rst            | 58 +++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs.rst

diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index 4f338e3cb3f7..e06e4951cb39 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _virtiofs_index:
+
 ===================================================
 virtiofs: virtio-fs host<->guest shared file system
 ===================================================
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index f5adcdc5fa1c..14f155edaf69 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -23,3 +23,5 @@ Linux Kernel中的文件系统
 .. toctree::
    :maxdepth: 2
 
+   virtiofs
+
diff --git a/Documentation/translations/zh_CN/filesystems/virtiofs.rst b/Documentation/translations/zh_CN/filesystems/virtiofs.rst
new file mode 100644
index 000000000000..09bc9e012e2a
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/virtiofs.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
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
+	中文版校译者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
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
+
-- 
2.17.1

