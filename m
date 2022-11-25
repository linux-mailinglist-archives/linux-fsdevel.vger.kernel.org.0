Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3316638B15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKYNX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 08:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKYNXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:23:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC940931;
        Fri, 25 Nov 2022 05:23:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490D5623FB;
        Fri, 25 Nov 2022 13:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC855C433C1;
        Fri, 25 Nov 2022 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669382630;
        bh=EGJ1sbVmh8zfuee638fIF/XO+8/weuDlINdqpi5zZtE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ITYmgIWGeb/7tfCFFc4kVDpIzqmupq1CVJap5fhBl/OT/PtkT4fvz+47vLok2k5y+
         9CRsV+JeWA0KEW85LVZu0FSIZep4yXbkGkq4EGBqpjWl9J4R07ZmdftvaN+jO6GvVh
         UV+8CnZQsig9drGP5ocCBKCwdeh2CEjv01ouksVCHxKjEnYvQ0VQOwyYDVIftWVHKE
         GsZuPwqfzHVqHsCgI2NSiNlqWlCXseI+0MB2Oq49i12gvBk+OTgmkxmQgpHo2z4CO0
         KgxgBErlyuKDTZUoexdSzNPrYs0i7nPI8jo2JLFO4nl05cBpvzph4ae7XpMCDCSp+4
         bOGw2Qy+6YgWg==
Message-ID: <1d474f53670771f324745f597ec94b63a006d687.camel@kernel.org>
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
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
Date:   Fri, 25 Nov 2022 08:23:45 -0500
In-Reply-To: <Y4A6/ozhUncxbimi@ZenIV>
References: <20221120210004.381842-1-jlayton@kernel.org>
         <Y4A6/ozhUncxbimi@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-25 at 03:48 +0000, Al Viro wrote:
> On Sun, Nov 20, 2022 at 03:59:57PM -0500, Jeff Layton wrote:
>=20
> > --- /dev/null
> > +++ b/include/linux/filelock.h
> > @@ -0,0 +1,428 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_FILELOCK_H
> > +#define _LINUX_FILELOCK_H
> > +
> > +#include <linux/list.h>
> > +#include <linux/nfs_fs_i.h>
>=20
> Umm... I'd add a comment along the lines of "struct file_lock has
> a BS union by fs type; NFS side of things needs nfs_fs_i.h"
>=20

Ok.

> > +struct lock_manager_operations {
> > +	void *lm_mod_owner;
> > +	fl_owner_t (*lm_get_owner)(fl_owner_t);
>=20
> Probably take fl_owner_t to some more neutral header...
>=20

I left it in fs.h for now. Some of the file_operations prototypes need
that typedef, and I figure that anyone who is including filelock.h will
almost certainly need to include fs.h anyway. We could move it into a
separate header too, but it's probably not worth it.

HCH mentioned years ago though that we should just get rid of fl_owner_t
altogether and just use 'void *'. I didn't do it at the time because I
was focused on other changes, but this might be a good time to change
it.

> > +#define locks_inode(f) file_inode(f)
>=20
> Why do we still have that one, anyway?  Separate patch, obviously,
> but I would take Occam's Razor to that entity...
>=20

I can spin up a patch to nuke that too. I count only 30 callsites
remaining anyway.

> > +struct files_struct;
> > +extern void show_fd_locks(struct seq_file *f,
> > +			 struct file *filp, struct files_struct *files);
>=20
> If anything, that would be better off as fl_owner_t...  Again, a separate
> patch.

I'm not sure what you mean here. This prototype hasn't changed, and is
only called from procfs.

--=20
Jeff Layton <jlayton@kernel.org>
