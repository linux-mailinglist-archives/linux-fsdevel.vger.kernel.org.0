Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A428215CC55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBMUYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbgBMUYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SkhWaIZ18aMaJ7Wk9+3f6WYB8fb4IbtJavOpp6sl/as=;
        b=B4DlyDoh1IcrfWIgiJws7IS8HEf+4TxwLUSqrcxCLefiSjI3PbJXviu/TOzh6imsph4f1U
        nWeDCCbRm+acfIOe9QqQ/o4DEH+K0b2RJBYRV59jmbJBVWbsTdePvJ7stbsYlpIF3R7Cgh
        PASuJlFAjeP7szc5obKO7aSso4RCqh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-udg9qeCJMX-le8RoneTrRw-1; Thu, 13 Feb 2020 15:24:30 -0500
X-MC-Unique: udg9qeCJMX-le8RoneTrRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5288E1857344;
        Thu, 13 Feb 2020 20:24:28 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA5B2100032E;
        Thu, 13 Feb 2020 20:24:25 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/7] Switch to page_mkwrite_check_truncate
Date:   Thu, 13 Feb 2020 21:24:16 +0100
Message-Id: <20200213202423.23455-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Darrick ended up not merge these changes through the xfs tree, so could
you please pick them up and put them in your trees for the next merge
window?  Luckily the changes are all independend of each other.

Thanks,
Andreas

Andreas Gruenbacher (7):
  fs: Un-inline page_mkwrite_check_truncate
  fs: Switch to page_mkwrite_check_truncate in block_page_mkwrite
  ubifs: Switch to page_mkwrite_check_truncate in ubifs_vm_page_mkwrite
  ext4: Switch to page_mkwrite_check_truncate in ext4_page_mkwrite
  f2fs: Switch to page_mkwrite_check_truncate in f2fs_vm_page_mkwrite
  ceph: Switch to page_mkwrite_check_truncate in ceph_page_mkwrite
  btrfs: Switch to page_mkwrite_check_truncate in btrfs_page_mkwrite

 fs/btrfs/inode.c        | 16 +++++-----------
 fs/buffer.c             | 16 +++-------------
 fs/ceph/addr.c          |  2 +-
 fs/ext4/inode.c         | 15 ++++-----------
 fs/f2fs/file.c          | 19 +++++++------------
 fs/ubifs/file.c         |  3 +--
 include/linux/pagemap.h | 28 +---------------------------
 mm/filemap.c            | 28 ++++++++++++++++++++++++++++
 8 files changed, 50 insertions(+), 77 deletions(-)

--=20
2.24.1

