Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9E390182
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhEYNCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 09:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232988AbhEYNCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621947675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r/I5LVaIFoJjMPSMV7/2ikhr538cIt3EnxAcMEqig1A=;
        b=XQuypyPgxo+q/NN7gP6cHPC2TavJhpktsbR5WTJ/DiTMhexsWehOw4BIGWUDpMCrMj3oj0
        ymQd2D+hjabo1nFDmYcRHZSsJzwf4ffynr/lUuyrCA91Lx8DJlGTxsQaOTqct6vyUpwLV9
        6WHeivMKKfDJ0ZNhJ4U6C7Sveg38YxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-fHrS5wC5OUWvuEqtMHSEiQ-1; Tue, 25 May 2021 09:01:11 -0400
X-MC-Unique: fHrS5wC5OUWvuEqtMHSEiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16EC380ED8E;
        Tue, 25 May 2021 13:01:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E01B86060F;
        Tue, 25 May 2021 13:01:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, geert@linux-m68k.org, willy@infradead.org,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] netfs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4007707.1621947662.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 25 May 2021 14:01:02 +0100
Message-ID: <4007708.1621947662@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 =

Hi Linus,

If you could pull this, there are a couple of fixes to the new netfs lib i=
n
it:

 (1) Pass the AOP flags through from netfs_write_begin() into
     grab_cache_page_write_begin().

 (2) Automatically enable in Kconfig netfs lib rather than presenting an
     option for manual enablement.

David
---
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b=
5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/netfs-lib-fixes-20200525

for you to fetch changes up to b71c791254ff5e78a124c8949585dccd9e225e06:

  netfs: Make CONFIG_NETFS_SUPPORT auto-selected rather than manual (2021-=
05-25 13:48:04 +0100)

----------------------------------------------------------------
netfslib fixes

----------------------------------------------------------------
David Howells (2):
      netfs: Pass flags through to grab_cache_page_write_begin()
      netfs: Make CONFIG_NETFS_SUPPORT auto-selected rather than manual

 fs/netfs/Kconfig       | 2 +-
 fs/netfs/read_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

