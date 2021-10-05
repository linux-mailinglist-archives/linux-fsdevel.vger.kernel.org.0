Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B44227FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 15:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhJENgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 09:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235081AbhJENgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633440890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KbQMyQ3OBXFxJwor2dj+AzBaJlpfPumA3y+3T9hS3ck=;
        b=QHPCPnKOvr64ktw012kT9Ifp7S93uK0JXRy9gKNyTAmogmT2jIqreQf6/jPS/pwQdshLb3
        TbhEqfIGtoCHKPxSl0S0ofdVNcU6ogqji7J/s7ioKZkwFoPVIs9lGdzqpn1A2Z4vUTibe3
        3bJ4PPDHutYUAQE3+hrCX8Vm4b5aXz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-p9vWSj-wP-G3pUDdrQWKnw-1; Tue, 05 Oct 2021 09:34:47 -0400
X-MC-Unique: p9vWSj-wP-G3pUDdrQWKnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50907802921;
        Tue,  5 Oct 2021 13:34:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7085B2619A;
        Tue,  5 Oct 2021 13:34:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache, 9p, afs, nfs: Fix kerneldoc warnings and one unused variable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1082804.1633440879.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 05 Oct 2021 14:34:39 +0100
Message-ID: <1082805.1633440879@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you consider pulling these changes please?

The first four patches fix kerneldoc warnings in fscache, afs, 9p and nfs =
-
they're mostly just comment changes, though there's one place in 9p where =
a
comment got detached from the function it was attached to (v9fs_fid_add)
and has to switch places with a function that got inserted between
(__add_fid).

The patch on the end removes an unused symbol in fscache - I moved it last
so you can discard it if you'd rather not pull that one just now.

David

Link: https://lore.kernel.org/r/163214005516.2945267.7000234432243167892.s=
tgit@warthog.procyon.org.uk/ # rfc v1
Link: https://lore.kernel.org/r/163281899704.2790286.9177774252843775348.s=
tgit@warthog.procyon.org.uk/ # rfc v2
Link: https://lore.kernel.org/r/163342376338.876192.10313278824682848704.s=
tgit@warthog.procyon.org.uk/ # split up

---
The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae4089=
6:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/warning-fixes-20211005

for you to fetch changes up to ef31499a87cf842bdf6719f44473d93e99d09fe2:

  fscache: Remove an unused static variable (2021-10-04 22:13:12 +0100)

----------------------------------------------------------------
Warning fixes

----------------------------------------------------------------
David Howells (5):
      nfs: Fix kerneldoc warning shown up by W=3D1
      afs: Fix kerneldoc warning shown up by W=3D1
      9p: Fix a bunch of kerneldoc warnings shown up by W=3D1
      fscache: Fix some kerneldoc warnings shown up by W=3D1
      fscache: Remove an unused static variable

 fs/9p/cache.c          |  8 ++++----
 fs/9p/fid.c            | 14 +++++++-------
 fs/9p/v9fs.c           |  8 +++-----
 fs/9p/vfs_addr.c       | 14 +++++++++-----
 fs/9p/vfs_file.c       | 33 ++++++++++++---------------------
 fs/9p/vfs_inode.c      | 24 ++++++++++++++++--------
 fs/9p/vfs_inode_dotl.c | 11 +++++++++--
 fs/afs/dir_silly.c     |  4 ++--
 fs/fscache/object.c    |  2 +-
 fs/fscache/operation.c |  3 +++
 fs/nfs_common/grace.c  |  1 -
 11 files changed, 66 insertions(+), 56 deletions(-)

