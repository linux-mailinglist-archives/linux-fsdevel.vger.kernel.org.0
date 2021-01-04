Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756E62EA0F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 00:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhADXgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 18:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbhADXgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609803323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yVDxwdUBGkQMs4znx48SVYeyk3m6+wNqj8IWaOnvkQE=;
        b=G/Y67hDxxcV00WOh+bgyJZ/th4eNgXGJquW/DKAsclbs05SjxZDyEfu2GeO7bWHjbrs925
        RVY1oEqwqO2NRP359MRfV1xzYX5sOEbO8pSliJ9zO50oDSooTWESfMGfCYg1feNdzN2T5E
        7i5P3ALWaKFHoiUzMawWe2gcQoI/X5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-ylFvUh_aPBKm5_1dbnK1wA-1; Mon, 04 Jan 2021 18:35:21 -0500
X-MC-Unique: ylFvUh_aPBKm5_1dbnK1wA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B7A8030A0;
        Mon,  4 Jan 2021 23:35:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D05E31A7D9;
        Mon,  4 Jan 2021 23:35:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] afs: Fix directory entry name handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <313280.1609803317.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 04 Jan 2021 23:35:17 +0000
Message-ID: <313281.1609803317@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these two commits, assuming Daniel doesn't object?  The fir=
st
is the fix for the strnlen() array limit check and the second fixes the
calculation of the number of dirent records used to represent any particul=
ar
filename length.

I've added Tested-bys for Marc Dionne into the branch, but otherwise the
patches should be the same as have been on the branch since the 23rd (was
commit 587f19fc90c1).

David
---
The following changes since commit a409ed156a90093a03fe6a93721ddf4c591eac8=
7:

  Merge tag 'gpio-v5.11-1' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/linusw/linux-gpio (2020-12-17 18:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-04012021

for you to fetch changes up to 366911cd762db02c2dd32fad1be96b72a66f205d:

  afs: Fix directory entry size calculation (2021-01-04 12:25:19 +0000)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (2):
      afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=3Dy
      afs: Fix directory entry size calculation

 fs/afs/dir.c               | 49 ++++++++++++++++++++++++-----------------=
-----
 fs/afs/dir_edit.c          |  6 ++----
 fs/afs/xdr_fs.h            | 25 +++++++++++++++++++----
 include/trace/events/afs.h |  2 ++
 4 files changed, 51 insertions(+), 31 deletions(-)

