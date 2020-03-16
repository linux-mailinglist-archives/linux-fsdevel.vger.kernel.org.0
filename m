Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E361865D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgCPHoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 03:44:09 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39089 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728302AbgCPHoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:44:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TsjIkOZ_1584344641;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TsjIkOZ_1584344641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Mar 2020 15:44:01 +0800
Subject: Re: [PATCH v2,1/2] doc: zh_CN: index files in filesystems
 subdirectory
To:     Wang Wenhu <wenhu.wang@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
 <20200315155258.91725-1-wenhu.wang@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <c163e158-125c-1b31-1bfb-6927b86d2a82@linux.alibaba.com>
Date:   Mon, 16 Mar 2020 15:44:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315155258.91725-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/3/15 下午11:52, Wang Wenhu 写道:
> Add filesystems subdirectory into the table of Contents for zh_CN,
> all translations residing on it would be indexed conveniently.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changelog:
>  - v2 added SPDX header
> ---
>  Documentation/filesystems/index.rst           |  2 ++
>  .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++++++++++++
>  Documentation/translations/zh_CN/index.rst    |  1 +
>  3 files changed, 32 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 386eaad008b2..ab47d5b1f092 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -1,3 +1,5 @@
> +.. _filesystems_index:
> +
>  ===============================
>  Filesystems in the Linux kernel
>  ===============================
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> new file mode 100644
> index 000000000000..0a2cabfeaf7b
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -0,0 +1,29 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. raw:: latex
> +
> +	\renewcommand\thesection*
> +	\renewcommand\thesubsection*
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
> +:Translator: Wang Wenhu <wenhu.wang@vivo.com>
> +
> +.. _cn_filesystems_index:
> +
> +========================
> +Linux Kernel中的文件系统
> +========================
> +
> +这份正在开发的手册或许在未来某个辉煌的日子里以易懂的形式将Linux虚拟\
> +文件系统（VFS）层以及基于其上的各种文件系统如何工作呈现给大家。当前\
> +可以看到下面的内容。
> +
> +文件系统
> +========
> +
> +文件系统实现文档。
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index d3165535ec9e..76850a5dd982 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -14,6 +14,7 @@
>     :maxdepth: 2
>  
>     process/index
> +   filesystems/index
>  
>  目录和表格
>  ----------
> 
