Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E83A77EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 02:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfIDApZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 20:45:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfIDApY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:45:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1CAEC90065AC5183BE43
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2019 08:45:23 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 08:45:13 +0800
Subject: Re: [QUESTION] `FUSE_3.1' not found error when calling fuse_new()
To:     <miklos@szeredi.hu>
References: <5D6F030B.7060901@huawei.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "wangyan (AF)" <wangyan122@huawei.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5D6F0911.4000002@huawei.com>
Date:   Wed, 4 Sep 2019 08:45:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5D6F030B.7060901@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I clean up the /usr/local/lib/libfuse3.so.3 and reinstall fuse again,
the problem is gone. The new location of libfuse is
/usr/lib64/libfuse3.so.3. Probably the old libfuse is installed by my
manual 'make install'.

On 2019/9/4 8:19, piaojun wrote:
> Hi Miklos,
> 
> I encounter an error when calling fuse_new() from libfuse3.so.3, and I
> wonder if I missed some macro like 'FUSE_3.1' or fuse_new() could not
> be called like this?
> 
> Hope for your help.
> 
> ---
> # ./main
> ./main: /usr/local/lib/libfuse3.so.3: version `FUSE_3.1' not found (required by ./main)
> 
> main.c:
> #define FUSE_USE_VERSION 30
> #include <fuse3/fuse.h>
> #include <fuse3/fuse_lowlevel.h>
> 
> static struct fuse_operations hello_oper;
> 
> int main(int argc, char *argv[])
> {
>         struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
>         struct fuse *fs;
> 
>         fs = fuse_new(&args, &hello_oper, sizeof(hello_oper), NULL);
> 
>         return 0;
> }
> 
> ---
> The fuse3-libs and devel rpm is from the following website:
> 
> https://centos.pkgs.org/7/epel-x86_64/fuse3-devel-3.6.1-2.el7.x86_64.rpm.html
> https://centos.pkgs.org/7/epel-x86_64/fuse3-libs-3.6.1-2.el7.x86_64.rpm.html
> 
> Thanks,
> Jun
> 
