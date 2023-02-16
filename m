Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F196992B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 12:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBPLHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 06:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBPLHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:07:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F0338B76;
        Thu, 16 Feb 2023 03:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4752A61F47;
        Thu, 16 Feb 2023 11:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38752C433EF;
        Thu, 16 Feb 2023 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676545661;
        bh=uIJ8oF2A7ZYaYb6BfW+DNEbnze9p7SG1BuuIeqZr46M=;
        h=Subject:From:To:Cc:Date:From;
        b=MWbetuoLyHC6hSGXXPdC6TE+VsYBW8inbjrOcn2g+JQn5d03r/Jhrgeni46QoLs9g
         Vd6MOgDJTd4MGF6sS7XsP1+sWDgwHB+ftTMl+EGSKpD6yJUqpjmqdhrXVJ49DtOC/r
         Wxp7FWQqh9rOK85/UDhqI2trV2teja0egcB6nMwl/ddbTXbZtI+FtuNW/eg6ZwByoQ
         daoGS0yq2aiFwhoSZNWSRCCqUPbAC6kqosj1hE/SubamNch/Ak6YyqCC1yQzLJLMps
         06F/DDI88JSlbJEmAXJjfsWPWZfhxvJICUQU+s7ZsMeDfX8k/YXWiGvWbNF0ZuErL/
         zermXSModyJpQ==
Message-ID: <c56632e59e4c5b727619de7dd79db11d15bdca6f.camel@kernel.org>
Subject: [GIT PULL] file locking changes for v6.3
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 16 Feb 2023 06:07:34 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ho+cotI388jsVDHTTOTf"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-ho+cotI388jsVDHTTOTf
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9=
:

  Merge tag 'xfs-6.2-fixes-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-li=
nux (2023-01-08 12:11:45 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lo=
cks-v6.3

for you to fetch changes up to c65454a947263dfdf482076388aaed60af84ca2f:

  fs: remove locks_inode (2023-01-11 06:52:43 -0500)

----------------------------------------------------------------
The main change here is that I've broken out most of the file locking
definitions into a new header file. I also went ahead and completed the
removal of locks_inode function.

Note that there was a minor merge conflict with the fuse tree reported
by Stephen Rothwell:

https://lore.kernel.org/lkml/20230127112640.6f55e705@canb.auug.org.au/T/

Cheers,
----------------------------------------------------------------
Jeff Layton (2):
      filelock: move file locking definitions to separate header file
      fs: remove locks_inode

 arch/arm/kernel/sys_oabi-compat.c |   1 +
 fs/9p/vfs_file.c                  |   1 +
 fs/afs/flock.c                    |  14 +-
 fs/afs/internal.h                 |   1 +
 fs/attr.c                         |   1 +
 fs/ceph/caps.c                    |   1 +
 fs/ceph/locks.c                   |   1 +
 fs/cifs/cifsfs.c                  |   1 +
 fs/cifs/cifsglob.h                |   1 +
 fs/cifs/cifssmb.c                 |   1 +
 fs/cifs/file.c                    |   1 +
 fs/cifs/smb2file.c                |   1 +
 fs/dlm/plock.c                    |   1 +
 fs/fcntl.c                        |   1 +
 fs/file_table.c                   |   1 +
 fs/fuse/file.c                    |   1 +
 fs/gfs2/file.c                    |   1 +
 fs/inode.c                        |   1 +
 fs/ksmbd/smb2pdu.c                |   1 +
 fs/ksmbd/vfs.c                    |   1 +
 fs/ksmbd/vfs_cache.c              |   1 +
 fs/lockd/clntlock.c               |   2 +-
 fs/lockd/clntproc.c               |   3 +-
 fs/lockd/netns.h                  |   1 +
 fs/locks.c                        |  29 ++--
 fs/namei.c                        |   1 +
 fs/nfs/file.c                     |   1 +
 fs/nfs/nfs4_fs.h                  |   1 +
 fs/nfs/pagelist.c                 |   1 +
 fs/nfs/write.c                    |   1 +
 fs/nfs_common/grace.c             |   1 +
 fs/nfsd/netns.h                   |   1 +
 fs/nfsd/nfs4state.c               |   4 +-
 fs/ocfs2/locks.c                  |   1 +
 fs/ocfs2/stack_user.c             |   1 +
 fs/open.c                         |   3 +-
 fs/orangefs/file.c                |   1 +
 fs/posix_acl.c                    |   1 +
 fs/proc/fd.c                      |   1 +
 fs/utimes.c                       |   1 +
 fs/xattr.c                        |   1 +
 fs/xfs/xfs_linux.h                |   1 +
 include/linux/filelock.h          | 439 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++
 include/linux/fs.h                | 429 ----------------------------------=
----------------------
 include/linux/lockd/lockd.h       |   4 +-
 include/linux/lockd/xdr.h         |   1 +
 46 files changed, 507 insertions(+), 457 deletions(-)
 create mode 100644 include/linux/filelock.h

--=20
Jeff Layton <jlayton@kernel.org>

--=-ho+cotI388jsVDHTTOTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAmPuDnYTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFfwzEACQ1sIhw3ZPLXcJ2myJbZGKSQir1Tbh
IKXq/GXXqGYN/6txDJCgsjfnzr96PW5l2raG+8J6pTJviGUIU6ZKhsNhXHrZHJis
cacOqS9X5IsTBjenHRFLShpZFjZH3f0l+uT6IN/6NaO9IX8cSBfE74yteNVymFSG
ebKk9kSXYlYFZq/HWgE7lvGwSeYXA0jnDTJEUsAF10Q5EMHqR/B8Av+MwwyvzcKd
rkm18hSBLiNxWyOhYmpFiFrQUHy3Va7kKqFOAFKr/7hx3NuUj4hJhSaEvCe08SpT
lb/jajAvQZLs7QaWkDn45VuOOMszAQfRHxqDOTbvxPC2LaUj9WRAOhbFqLEGiGia
UKDjftVFcd6UAbsEyTB/lQLx0G8GahzyXhSzt2SfbbMYQ8kX2zDlAAMhJ1WMCO8k
dzEedOBigK2t5bv88bQFfh2YWBD8HOkVOQr2YDAka2wKDWsqkd56p+6eHluPZSBU
XEoDfY2vWGnI4+7R0ConUo9PC93aVhhaVhcminQOEchWHUZZvOWrH4UOB9dMGorN
5xjlDLAyO49lQiVotbbR7/nzkj9n5EpzF8lJLopaOxSGnVkK8FEAzcFEgfaO2m/W
VP6+30bTpXWw9WWaEyg6oiDE95bM6iH8K/RH06hoDecuZ3tqISDZd2DcyhZ+Y5Db
mUR0DL30dCVnOw==
=AxhF
-----END PGP SIGNATURE-----

--=-ho+cotI388jsVDHTTOTf--
