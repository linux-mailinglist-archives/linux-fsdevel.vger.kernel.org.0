Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204A327E9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhCAMwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 07:52:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42240 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhCAMwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:52:41 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lGi1n-0006d6-CG; Mon, 01 Mar 2021 12:51:59 +0000
Date:   Mon, 1 Mar 2021 13:51:58 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kernel-doc fixes to latest fs changes
Message-ID: <20210301125158.llalx7uxhigg4f3p@wittgenstein>
References: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 07:00:54PM +0100, Lukas Bulwahn wrote:
> this patchset was motivated by new warnings with make htmldocs appearing on
> linux-next in the last week.
> 
> Please apply this on top of your latest work in fs on top of the mount user
> namespace refactoring, cf. the commits referred in the individual commit
> messages.
> 
> 
> Lukas Bulwahn (5):
>   fs: turn some comments into kernel-doc
>   fs: update kernel-doc for vfs_rename()
>   fs: update kernel-doc for may_create_in_sticky()
>   fs: update kernel-doc for vfs_tmpfile()
>   fs: update kernel-doc for new mnt_userns argument
> 
>  fs/libfs.c         |  1 +
>  fs/namei.c         | 13 ++-----------
>  fs/xattr.c         |  2 ++
>  include/linux/fs.h | 17 ++++++++++++++---
>  4 files changed, 19 insertions(+), 14 deletions(-)

Thanks for fixing this up, Lukas. Randy has fixed some of my missing
comment updates as well so we only needed

>   fs: turn some comments into kernel-doc
>   fs: update kernel-doc for vfs_rename()

Christian
