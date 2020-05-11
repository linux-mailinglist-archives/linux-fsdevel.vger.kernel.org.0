Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8561CCF4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 03:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgEKBz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 21:55:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729177AbgEKBz1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 21:55:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36CC5B2F649EB3DADC61;
        Mon, 11 May 2020 09:55:24 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 11 May 2020
 09:55:22 +0800
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <linux-fsdevel@vger.kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
Date:   Mon, 11 May 2020 09:55:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200511111123.68ccbaa3@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/11 9:11, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>    kernel/sysctl.c
> 
> between commit:
> 
>    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
> 
> from the parisc-hd tree and commit:
> 
>    f461d2dcd511 ("sysctl: avoid forward declarations")
> 
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 


Kernel/sysctl.c contains more than 190 interface files, and there are a 
large number of config macro controls. When modifying the sysctl 
interface directly in kernel/sysctl.c , conflicts are very easy to occur.

At the same time, the register_sysctl_table() provided by the system can 
easily add the sysctl interface, and there is no conflict of 
kernel/sysctl.c .

Should we add instructions in the patch guide (coding-style.rst 
submitting-patches.rst):
Preferentially use register_sysctl_table() to add a new sysctl 
interface, centralize feature codes, and avoid directly modifying 
kernel/sysctl.c ?

In addition, is it necessary to transfer the architecture-related sysctl 
interface to arch/xxx/kernel/sysctl.c ?

Thanks
Xiaoming Ni

