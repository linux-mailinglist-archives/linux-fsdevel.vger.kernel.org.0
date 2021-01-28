Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5039E3074DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 12:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhA1Lb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 06:31:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhA1Lb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:31:57 -0500
Received: from [95.90.240.160] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l55W6-0006cC-OQ; Thu, 28 Jan 2021 11:31:14 +0000
Date:   Thu, 28 Jan 2021 12:31:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, lkp@intel.com, kbuild@lists.01.org
Subject: Re: [whitespace] attr: handle idmapped mounts
Message-ID: <20210128113114.znddyov6hdqfgs35@wittgenstein>
References: <YBKeHne9FZ42mich@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBKeHne9FZ42mich@mwanda>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:21:02PM +0300, Dan Carpenter wrote:
> Hello Christian Brauner,
> 
> The patch 2f221d6f7b88: "attr: handle idmapped mounts" from Jan 21,
> 2021, leads to the following static checker warning:
> 
> 	fs/attr.c:129 setattr_prepare()
> 	warn: inconsistent indenting
> 
> fs/attr.c
>    124		/* Make sure a caller can chmod. */
>    125		if (ia_valid & ATTR_MODE) {
>    126			if (!inode_owner_or_capable(mnt_userns, inode))
>    127				return -EPERM;
>    128			/* Also check the setgid bit! */
>    129	               if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
>       ^^^^^^^^^^^^^^^^^
> The patch accidentally swapped tabs for spaces.

Thanks. Must've sneaked in despite clang-format. Will likely fix in a
separate commit. I don't want to rebase because of this.
