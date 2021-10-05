Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD72422125
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhJEIvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 04:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhJEIv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633423779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yWuvkskdEI9r2ThEQjUFBlxKCU4JS4TIq1nVqm3oeN8=;
        b=ZoJuzOt78h0hbMpmuG3Nk7HDne1S5zbwrEZGYgkqTYt01QTkns1xbLKlV/c2d0RY4fANPS
        GeGZNvnajv0ZICINpGESdL3qXn8liedFe0SkKIKf2a4hFhrjL3XV66vhRCsOVWLqtIz26k
        S9LJLQw1qJM52JfT9S4NZ+99cVsa15M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-ZXH9L7g7PKSPz5-zvYCjiw-1; Tue, 05 Oct 2021 04:49:38 -0400
X-MC-Unique: ZXH9L7g7PKSPz5-zvYCjiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1E819057A0;
        Tue,  5 Oct 2021 08:49:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A15360657;
        Tue,  5 Oct 2021 08:49:24 +0000 (UTC)
Subject: [PATCH v3 0/5] fscache, afs, 9p, nfs: Warning fixes
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        linux-nfs@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        torvalds@linux-foundation.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Oct 2021 09:49:23 +0100
Message-ID: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of warning fixes for fscache, afs, 9p and nfs. It's mostly
kerneldoc fixes plus one unused static variable removal.  I've split the
old patch up into per-subsys chunks and put the variable removal in its own
patch at the end.

The patches are on a branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

Thanks,
David

Changes
=======
ver #3:
 - Dealt with the kerneldoc warnings in fs/9p/cache.c.
 - Split the single patch up.

ver #2:
 - Dropped already upstreamed cifs changes.
 - Fixed more 9p kerneldoc bits.

Link: https://lore.kernel.org/r/163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk/ # rfc v1
Link: https://lore.kernel.org/r/163281899704.2790286.9177774252843775348.stgit@warthog.procyon.org.uk/ # rfc v2
---
David Howells (5):
      nfs: Fix kerneldoc warning shown up by W=1
      afs: Fix kerneldoc warning shown up by W=1
      9p: Fix a bunch of kerneldoc warnings shown up by W=1
      fscache: Fix some kerneldoc warnings shown up by W=1
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
 10 files changed, 66 insertions(+), 55 deletions(-)


