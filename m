Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E66185E4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgCOPxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 11:53:38 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:6432 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgCOPxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:53:38 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 4DDC9261012;
        Sun, 15 Mar 2020 23:53:17 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v2,1/2] doc: zh_CN: index files in filesystems subdirectory
Date:   Sun, 15 Mar 2020 08:52:38 -0700
Message-Id: <20200315155258.91725-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315092810.87008-1-wenhu.wang@vivo.com>
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVIQkhLS0tKSU5DQ05LSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06Pyo5LTgzLDczIhwVKTw0
        PwEKFCJVSlVKTkNPSUNMTUtITkNPVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQU9ITkI3Bg++
X-HM-Tid: 0a70dee6518a9375kuws4ddc9261012
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add filesystems subdirectory into the table of Contents for zh_CN,
all translations residing on it would be indexed conveniently.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changelog:
 - v2 added SPDX header
---
 Documentation/filesystems/index.rst           |  2 ++
 .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++++++++++++
 Documentation/translations/zh_CN/index.rst    |  1 +
 3 files changed, 32 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 386eaad008b2..ab47d5b1f092 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -1,3 +1,5 @@
+.. _filesystems_index:
+
 ===============================
 Filesystems in the Linux kernel
 ===============================
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
new file mode 100644
index 000000000000..0a2cabfeaf7b
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. raw:: latex
+
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
+:Translator: Wang Wenhu <wenhu.wang@vivo.com>
+
+.. _cn_filesystems_index:
+
+========================
+Linux Kernel中的文件系统
+========================
+
+这份正在开发的手册或许在未来某个辉煌的日子里以易懂的形式将Linux虚拟\
+文件系统（VFS）层以及基于其上的各种文件系统如何工作呈现给大家。当前\
+可以看到下面的内容。
+
+文件系统
+========
+
+文件系统实现文档。
+
+.. toctree::
+   :maxdepth: 2
+
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index d3165535ec9e..76850a5dd982 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -14,6 +14,7 @@
    :maxdepth: 2
 
    process/index
+   filesystems/index
 
 目录和表格
 ----------
-- 
2.17.1

