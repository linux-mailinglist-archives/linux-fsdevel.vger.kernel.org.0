Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF0C63A66A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiK1KyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiK1KyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:54:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70701E4;
        Mon, 28 Nov 2022 02:54:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73DA360F9F;
        Mon, 28 Nov 2022 10:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02102C433D6;
        Mon, 28 Nov 2022 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669632839;
        bh=TCH4X0vYXDYZIjposZLwuZH5bK38a+ap9JQQcvpsmrQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NiNiD/NIPJwPZZvubu2no8wdsdDDjItBldgVSQaImG5cxRrl7n6IQYZBc0nV5JpBQ
         xVnrX+B1v8v8ehMk7vofau11mkaKHiqPTVjq0mOg6uPLSQDNcWU6ra7XZX/5SPPGhe
         3NTDUsRcNblciTaLJIOHNpisMvl41lRYHx3bKhRvui4ToVySHHAMBffDg6ovppKkDe
         qsAeUfpeq06hna20AvMvcPdONgQBIVeU0n576fCL1sfDRo1XzYu64pPEHg4b2C61ur
         Lr2NVgPJPqeEYUjJtggTrBXIJXDvpIqIvFPOspCvYeix5kRtYTD6U+z1lN7Xo1zCxs
         ZI6W95+J1AmkQ==
Message-ID: <6a093484bb977355db40c70ffa51386f3d4ed57b.camel@kernel.org>
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
Date:   Mon, 28 Nov 2022 05:53:54 -0500
In-Reply-To: <Y4Dw65Nzt4bX9esd@ZenIV>
References: <20221120210004.381842-1-jlayton@kernel.org>
         <Y4A6/ozhUncxbimi@ZenIV>
         <1d474f53670771f324745f597ec94b63a006d687.camel@kernel.org>
         <Y4Dw65Nzt4bX9esd@ZenIV>
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

On Fri, 2022-11-25 at 16:44 +0000, Al Viro wrote:
> On Fri, Nov 25, 2022 at 08:23:45AM -0500, Jeff Layton wrote:
>=20
> > I left it in fs.h for now. Some of the file_operations prototypes need
> > that typedef, and I figure that anyone who is including filelock.h will
> > almost certainly need to include fs.h anyway. We could move it into a
> > separate header too, but it's probably not worth it.
> >=20
> > HCH mentioned years ago though that we should just get rid of fl_owner_=
t
> > altogether and just use 'void *'. I didn't do it at the time because I
> > was focused on other changes, but this might be a good time to change
> > it.
>=20
> Might be...
>=20
> > > > +extern void show_fd_locks(struct seq_file *f,
> > > > +			 struct file *filp, struct files_struct *files);
> > >=20
> > > If anything, that would be better off as fl_owner_t...  Again, a sepa=
rate
> > > patch.
> >=20
> > I'm not sure what you mean here. This prototype hasn't changed, and is
> > only called from procfs.
>=20
> Take a look at that function and its caller.  The use of 'files' argument=
 there
> is (and can be) only as an opaque pointer to be compared to ->fl_owner; a=
t that
> point it might be pointing to freed memory, for all we know (and give fal=
se
> positives if already reused).

Ok. What we want this function to do is show any traditional POSIX or
OFD locks that were set on a particular file. The logic in
__show_fd_locks looks right, but you're correct that we don't want
anyone dereferencing those pointers in that codepath.

Note too that this info is not wholly reliable. POSIX locks can merge
with other locks that were set within the same process (same
files_struct) but on different fds.

I think we want to get rid of fl_owner_t anyway. Maybe we should replace
it with an unsigned long instead of void * to discourage anyone from
trying to dereference those pointers?

> TBH, I'd never been able to finish the audit of files_struct pointers pas=
sed
> into locks subsystem; there definitely are moments when code from fs/lock=
s.c
> is dealing with pointers to already freed instances - show_fd_locks() at =
the
> very least.  They are not dereferenced, but beyond that...

Yeah. In general, we try to ensure that locks are torn down before the
file with which it is associated, but with some of the delayed freeing,
they can outlive the file at times. For example:

    https://tracker.ceph.com/issues/57986

--=20
Jeff Layton <jlayton@kernel.org>
