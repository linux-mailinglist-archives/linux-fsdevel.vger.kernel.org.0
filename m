Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0182E2894
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgLXS2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 13:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgLXS2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 13:28:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0257C061573;
        Thu, 24 Dec 2020 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=VGafzW+gDLjGLMNoybNSBGNiUL4/Bi3JEFJxz+NnDOo=; b=EhJff5vA4Ww2XgctyYRLpm5zaW
        fRb++J29JhQTcpWEtDdKhunxvfrubKlxzZI6mk3AeZEvGqrgkAZ8DnAxMnvlREgOTa9odqM6ubPUi
        9VoylnGnIYzu+2X/G3J/CtrUMdrFMijVEKnIuYlm4v4kszYsGULZp1Nt3fBzThEONGsRLtKCj+CQs
        Cs8EOGH/qKHER6lmIV04pGHhCSwHwvC3qezfOo6SqzswdE6qkFIfRoLDly20ykRbeL6Gi09JsixXi
        8Nam8gVIdPJVmiDV2Xtfe5/BdGo2AENkRg2yBGtTnltj64CRb0vAf5ekbHFJ55JHDuBaJzCT7AllJ
        1VEiqVXQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksVKp-0007Zk-7Z; Thu, 24 Dec 2020 18:27:35 +0000
Subject: Re: [RFC V2 37/37] Add documentation for dmemfs
To:     yulei.kernel@gmail.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk,
        pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, sean.j.christopherson@intel.com,
        xiaoguangrong.eric@gmail.com, kernellwp@gmail.com,
        lihaiwei.kernel@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
 <6a3a71f75dad1fa440677fc1bcdc170f178be1d8.1607332046.git.yuleixzhang@tencent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8920d25-e109-cfce-5137-1f4374c815e9@infradead.org>
Date:   Thu, 24 Dec 2020 10:27:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6a3a71f75dad1fa440677fc1bcdc170f178be1d8.1607332046.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12/7/20 3:31 AM, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> Introduce dmemfs.rst to document the basic usage of dmemfs.
> 
> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> ---
>  Documentation/filesystems/dmemfs.rst | 58 ++++++++++++++++++++++++++++++++++++
>  Documentation/filesystems/index.rst  |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/filesystems/dmemfs.rst
> 
> diff --git a/Documentation/filesystems/dmemfs.rst b/Documentation/filesystems/dmemfs.rst
> new file mode 100644
> index 00000000..f13ed0c
> --- /dev/null
> +++ b/Documentation/filesystems/dmemfs.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +The Direct Memory Filesystem - DMEMFS
> +=====================================
> +
> +
> +.. Table of contents
> +
> +   - Overview
> +   - Compilation
> +   - Usage
> +
> +Overview
> +========
> +
> +Dmemfs (Direct Memory filesystem) is device memory or reserved
> +memory based filesystem. This kind of memory is special as it
> +is not managed by kernel and it is without 'struct page'. Therefore
> +it can save extra memory from the host system for various usage,

                                                             usages,
or                                                           uses,

> +especially for guest virtual machines.
> +
> +It uses a kernel boot parameter ``dmem=`` to reserve the system
> +memory when the host system boots up, the details can be checked

                               boots up. The detail

> +in /Documentation/admin-guide/kernel-parameters.txt.
> +
> +Compilation
> +===========
> +
> +The filesystem should be enabled by turning on the kernel configuration
> +options::
> +
> +        CONFIG_DMEM_FS          - Direct Memory filesystem support
> +        CONFIG_DMEM             - Allow reservation of memory for dmem

Would anyone want DMEM_FS without DMEM?

> +
> +
> +Additionally, the following can be turned on to aid debugging::
> +
> +        CONFIG_DMEM_DEBUG_FS    - Enable debug information for dmem
> +
> +Usage
> +========
> +
> +Dmemfs supports mapping ``4K``, ``2M`` and ``1G`` size of pages to

                                                     sizes

> +the userspace, for example ::

       userspace. For example::

> +
> +    # mount -t dmemfs none -o pagesize=4K /mnt/
> +
> +The it can create the backing storage with 4G size ::

   Then

> +
> +    # truncate /mnt/dmemfs-uuid --size 4G
> +
> +To use as backing storage for virtual machine starts with qemu, just need

                                                 started with qemu, just specify
   the memory-backed-file

> +to specify the memory-backed-file in the qemu command line like this ::
> +
> +    # -object memory-backend-file,id=ram-node0,mem-path=/mnt/dmemfs-uuid \

                        backed


> +        share=yes,size=4G,host-nodes=0,policy=preferred -numa node,nodeid=0,memdev=ram-node0
> +


-- 
~Randy

