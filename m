Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8B5E5D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIVIKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiIVIKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:10:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0665CC8F6;
        Thu, 22 Sep 2022 01:10:37 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MY7Fj0JwPzHpmF;
        Thu, 22 Sep 2022 16:08:25 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:10:35 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <akinobu.mita@gmail.com>
CC:     <akpm@linux-foundation.org>, <corbet@lwn.net>, <david@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
        <osalvador@suse.de>, <rafael@kernel.org>, <shuah@kernel.org>,
        <viro@zeniv.linux.org.uk>, <weiyongjun1@huawei.com>,
        <yangyicong@hisilicon.com>, <zhaogongyi@huawei.com>
Subject: Re: [PATCH 0/3] fix error when writing negative value to simple attribute files
Date:   Thu, 22 Sep 2022 16:06:48 +0800
Message-ID: <20220922080648.254312-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919172418.45257-1-akinobu.mita@gmail.com>
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Sep 2022 02:24:15 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:
> The simple attribute files do not accept a negative value since the
> commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), but some attribute files want to accept
> a negative value.
> 
> Akinobu Mita (3):
>   libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed value
>   lib/notifier-error-inject: fix error when writing -errno to debugfs
>     file
>   debugfs: fix error when writing negative value to atomic_t debugfs
>     file
> 
>  .../fault-injection/fault-injection.rst       | 10 +++----
>  fs/debugfs/file.c                             | 28 +++++++++++++++----
>  fs/libfs.c                                    | 22 +++++++++++++--
>  include/linux/debugfs.h                       | 19 +++++++++++--
>  include/linux/fs.h                            | 12 ++++++--
>  lib/notifier-error-inject.c                   |  2 +-
>  6 files changed, 73 insertions(+), 20 deletions(-)

I have tested this version, it is ok.

Tested-by: Zhao Gongyi <zhaogongyi@huawei.com>
