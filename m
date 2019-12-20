Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C981275B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfLTG2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:28:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:20255 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfLTG1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:27:44 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191220062741epoutp044eb442586ca4e8413423751df7f7b93d~iAGbYMlJ31295312953epoutp04d
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:27:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191220062741epoutp044eb442586ca4e8413423751df7f7b93d~iAGbYMlJ31295312953epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576823261;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9tUM0Q3a4aWLCtL//yJrsYFBLB83IjPqP7f1Risl/OEnLf808pme6Kz+nyNhH0PZ
         +eUy2pyM0zyTdMK6FhtvS6k2mA6x+L9F5SFsJNDwVEwfkKMZD0lfONq1Ly6Z0Qv7m4
         R/dlb5VEcdEogSG0KN78iyoQQvah1YuoF/4OOGUQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220062740epcas1p198de66264b934c70c09e0f06a169b823~iAGbFUFAS1644816448epcas1p1O;
        Fri, 20 Dec 2019 06:27:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47fJhC6x9szMqYkf; Fri, 20 Dec
        2019 06:27:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.67.48019.AD96CFD5; Fri, 20 Dec 2019 15:27:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191220062738epcas1p2aa7a91f04263efc3d6d7200eb04c1296~iAGY3evdR3026930269epcas1p2V;
        Fri, 20 Dec 2019 06:27:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220062738epsmtrp186e985ce262928cf0d3e8b5fcb627c5b~iAGY2u8oG2110821108epsmtrp1Q;
        Fri, 20 Dec 2019 06:27:38 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-7d-5dfc69da9d9b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.0A.10238.AD96CFD5; Fri, 20 Dec 2019 15:27:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220062738epsmtip19684d03438198481900cbd4178cc99ba~iAGYuxoI32891528915epsmtip1Y;
        Fri, 20 Dec 2019 06:27:38 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v8 11/13] exfat: add Kconfig and Makefile
Date:   Fri, 20 Dec 2019 01:24:17 -0500
Message-Id: <20191220062419.23516-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmnu6tzD+xBsvOmFg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORlH3ngWdPBWTPjTzNLAeImri5GDQ0LARGLSbuMuRi4OIYEdjBK/H2xm
        7GLkBHI+MUq82aQBkfjGKPH5+lN2kARIQ8uD/UwQib2MEp3LGhghHKCOz+/fs4CMZRPQlviz
        RRSkQUTAXmLz7AMsIDXMAnMYJXb0zmIEqREWsJSY/c0VpIZFQFVid+N+NhCbV8BW4uSi/cwQ
        y+QlVm84AGZzAsV/f30OtlhCYA2bxN1bp9ggilwktv87D9UgLPHq+BaoS6UkXva3sUO8WS3x
        EWZmB6PEi++2ELaxxM31G1hBSpgFNCXW79KHCCtK7Pw9FxwQzAJ8Eu++9rBCTOGV6GgTgihR
        lei7dJgJwpaW6Gr/ALXUQ2LJkwPQ4JnAKHGjtZl9AqPcLIQNCxgZVzGKpRYU56anFhsWmCDH
        1iZGcGLTstjBuOeczyFGAQ5GJR5eh7TfsUKsiWXFlbmHGCU4mJVEeG93/IwV4k1JrKxKLcqP
        LyrNSS0+xGgKDMiJzFKiyfnApJtXEm9oamRsbGxhYmZuZmqsJM7L8eNirJBAemJJanZqakFq
        EUwfEwenVAOj1oaFDhu2pSQyNs6uucJfnB9dcNfptdChuSVuojxh+zlv/Jp9LWray6s6e7+Z
        POHNncqevmxpYVfDko3mRU+ut/+4OcntY0iJ+46eG/NCd6zj27Rpe+ss0yCewNSD1lEbZzse
        8ZzM4bZAr0rs24v2/V8cfqS63l2dV2pQ6HNPQvKifnL6vj1vlViKMxINtZiLihMB+YehpIID
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO6tzD+xBr9WyVk0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MI288Czp4Kyb8aWZpYLzE1cXIySEhYCLR8mA/
        E4gtJLCbUeLaJTeIuLTEsRNnmLsYOYBsYYnDh4u7GLmASj4wSqz8OpUNJM4moC3xZ4soSLmI
        gKNE767DLCA1zAKLGCXefZzMClIjLGApMfubK0gNi4CqxO7G/WwgNq+ArcTJRfuZIVbJS6ze
        cADM5gSK//76HOocG4nGbWsYJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJ
        ERyAWpo7GC8viT/EKMDBqMTD65D2O1aINbGsuDL3EKMEB7OSCO/tjp+xQrwpiZVVqUX58UWl
        OanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTBaicy9d3bqc0a2tfy/Yps5RcWr
        5y41CKrMTQqPyfrmOkkla6lesqrgK8szdxtmPpS/HfuqwaT67r8W5hfBWxRjjFhX8yQ9F5AO
        anWcctuPc92adSq/Nt962SE/K6D29an75009wiTEMqearffRFT3azPxm56/WA9unHMprzrib
        k3bxHOOc25lKLMUZiYZazEXFiQCM4KSjPAIAAA==
X-CMS-MailID: 20191220062738epcas1p2aa7a91f04263efc3d6d7200eb04c1296
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062738epcas1p2aa7a91f04263efc3d6d7200eb04c1296
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
        <CGME20191220062738epcas1p2aa7a91f04263efc3d6d7200eb04c1296@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the Kconfig and Makefile for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/Kconfig  | 21 +++++++++++++++++++++
 fs/exfat/Makefile |  8 ++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 000000000000..11d841a5f7f0
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config EXFAT
+	tristate "exFAT filesystem support"
+	select NLS
+	help
+	  This allows you to mount devices formatted with the exFAT file system.
+	  exFAT is typically used on SD-Cards or USB sticks.
+
+	  To compile this as a module, choose M here: the module will be called
+	  exfat.
+
+config EXFAT_FS_DEFAULT_IOCHARSET
+	string "Default iocharset for exFAT"
+	default "utf8"
+	depends on EXFAT
+	help
+	  Set this to the default input/output character set you'd
+	  like exFAT to use. It should probably match the character set
+	  that most of your exFAT filesystems use, and can be overridden
+	  with the "iocharset" mount option for exFAT filesystems.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 000000000000..e9193346c80c
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the linux exFAT filesystem support.
+#
+obj-$(CONFIG_EXFAT) += exfat.o
+
+exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
+	   file.o balloc.o
-- 
2.17.1

