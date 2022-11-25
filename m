Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE3A6382D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 04:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKYDtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 22:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:49:16 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D82B26117;
        Thu, 24 Nov 2022 19:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I2TD8YnyUVRKaNNBGvfs3pUWZDwIFw5kNMaApqkurhc=; b=LNV2e8UbAEOQw/T25Fn0zcJFtt
        fNpKOR7AmYQmyKebyHLdQkC/VRgO+jC6IaDUeHAjw4EL0DsbkFM6Iqc2wV96JeHEovMJKBTXDZmhv
        ZBw2xsCMnqYGB42wL+ylBtaiFvmXn4+q48vjcw+DG90eOjgZU2/9rcOSLcqiIsrxuWaDw1SMMEzx7
        t7JkkxZCAEJ97Erz/o4KvknT6QpkedMLh6PAKj8gLWbA+2hlrTJV8E/LgdR9rDoShxcJCoTpm912V
        ABkJ97xsSUr6RQZKyn8cXzXou9+2BUXYywgtCMyz0UPAL3QT8v6w4dSbpiqIhsoN4SGRxmTtMbclh
        leUGm6UQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyPhG-006aFN-28;
        Fri, 25 Nov 2022 03:48:14 +0000
Date:   Fri, 25 Nov 2022 03:48:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
Message-ID: <Y4A6/ozhUncxbimi@ZenIV>
References: <20221120210004.381842-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120210004.381842-1-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 20, 2022 at 03:59:57PM -0500, Jeff Layton wrote:

> --- /dev/null
> +++ b/include/linux/filelock.h
> @@ -0,0 +1,428 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_FILELOCK_H
> +#define _LINUX_FILELOCK_H
> +
> +#include <linux/list.h>
> +#include <linux/nfs_fs_i.h>

Umm... I'd add a comment along the lines of "struct file_lock has
a BS union by fs type; NFS side of things needs nfs_fs_i.h"

> +struct lock_manager_operations {
> +	void *lm_mod_owner;
> +	fl_owner_t (*lm_get_owner)(fl_owner_t);

Probably take fl_owner_t to some more neutral header...

> +#define locks_inode(f) file_inode(f)

Why do we still have that one, anyway?  Separate patch, obviously,
but I would take Occam's Razor to that entity...

> +struct files_struct;
> +extern void show_fd_locks(struct seq_file *f,
> +			 struct file *filp, struct files_struct *files);

If anything, that would be better off as fl_owner_t...  Again, a separate
patch.
