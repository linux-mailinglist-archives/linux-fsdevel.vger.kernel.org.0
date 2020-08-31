Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58D9257191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 03:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgHaBcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 21:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgHaBcb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:32:31 -0400
Received: from X1 (unknown [65.49.58.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F0A20DD4;
        Mon, 31 Aug 2020 01:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598837551;
        bh=+cVkfyIdo9Ykx5TVLAOYP786mQQQRmSIWUg/FPBusUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L661MFP9Wbf2yo0O9O66Gx6qxQuUdUWxFBJ6mEpvMD9tq3FV/BZZekjvbqhjv1Vw+
         7APNFieiy/UalV4ge5iLAzZ7PqoXNJiF6Lwr/I015EK+0+MqaDYApizPKHJ3qOSpp9
         MXQC3YcTQLh57Brj6ejqkRE8bV7avusaP3FzQ8Fo=
Date:   Sun, 30 Aug 2020 18:32:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] fs/xattr.c: fix kernel-doc warnings for setxattr &
 removexattr
Message-Id: <20200830183230.35f8904e05a8f0f1a3ab025e@linux-foundation.org>
In-Reply-To: <7a3dd5a2-5787-adf3-d525-c203f9910ec4@infradead.org>
References: <7a3dd5a2-5787-adf3-d525-c203f9910ec4@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 30 Aug 2020 17:30:08 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in fs/xattr.c:
> 
> ../fs/xattr.c:251: warning: Function parameter or member 'dentry' not described in '__vfs_setxattr_locked'
> ../fs/xattr.c:251: warning: Function parameter or member 'name' not described in '__vfs_setxattr_locked'
> ../fs/xattr.c:251: warning: Function parameter or member 'value' not described in '__vfs_setxattr_locked'
> ../fs/xattr.c:251: warning: Function parameter or member 'size' not described in '__vfs_setxattr_locked'
> ../fs/xattr.c:251: warning: Function parameter or member 'flags' not described in '__vfs_setxattr_locked'
> ../fs/xattr.c:251: warning: Function parameter or member 'delegated_inode' not described in '__vfs_setxattr_locked'
> ../fs/xattr.c:458: warning: Function parameter or member 'dentry' not described in '__vfs_removexattr_locked'
> ../fs/xattr.c:458: warning: Function parameter or member 'name' not described in '__vfs_removexattr_locked'
> ../fs/xattr.c:458: warning: Function parameter or member 'delegated_inode' not described in '__vfs_removexattr_locked'
> 
> Fixes: 08b5d5014a27 ("xattr: break delegations in {set,remove}xattr")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: stable@vger.kernel.org # v4.9+

hm, are kerneldoc warning fixes -stable material?

