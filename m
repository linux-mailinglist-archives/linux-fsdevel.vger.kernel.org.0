Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907D442ED28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhJOJJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233389AbhJOJJg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2F2D60E53;
        Fri, 15 Oct 2021 09:07:23 +0000 (UTC)
Date:   Fri, 15 Oct 2021 11:07:18 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, serge@hallyn.com,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>, dwalsh@redhat.com,
        jlayton@kernel.org, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2] security: Return xattr name from
 security_dentry_init_security()
Message-ID: <20211015090718.4xwdnyujw354hnxe@wittgenstein>
References: <YWWMO/ZDrvDZ5X4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWWMO/ZDrvDZ5X4c@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 09:23:07AM -0400, Vivek Goyal wrote:
> Right now security_dentry_init_security() only supports single security
> label and is used by SELinux only. There are two users of of this hook,
> namely ceph and nfs.
> 
> NFS does not care about xattr name. Ceph hardcodes the xattr name to
> security.selinux (XATTR_NAME_SELINUX).
> 
> I am making changes to fuse/virtiofs to send security label to virtiofsd
> and I need to send xattr name as well. I also hardcoded the name of
> xattr to security.selinux.
> 
> Stephen Smalley suggested that it probably is a good idea to modify
> security_dentry_init_security() to also return name of xattr so that
> we can avoid this hardcoding in the callers.
> 
> This patch adds a new parameter "const char **xattr_name" to
> security_dentry_init_security() and LSM puts the name of xattr
> too if caller asked for it (xattr_name != NULL).
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---

Looks good to me.
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
