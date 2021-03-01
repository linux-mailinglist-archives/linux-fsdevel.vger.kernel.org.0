Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424D7328C1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 19:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhCASpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 13:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240491AbhCASnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614624109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/bw7Em3MQTLSbWrJzku5elf34tlVsF/GuX6xjSbODzg=;
        b=egf0yHfkY2CLAxMwXIuozJl541Z/dkXU1jNmLqzWehJdXyLT+v8dR37uNPJp1synkjtHou
        leO9cPiLJ5iKf4yeU39tEuHSFMfQvU5H1dTmvk2TzNoBD3vTuiPFWCEQM/4Fsolaemk6yz
        SaJLTz+cM0FoKHiF3wok1yJ0FD+AyOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-34rguDLlOFeZi_rGWNNdbA-1; Mon, 01 Mar 2021 13:41:47 -0500
X-MC-Unique: 34rguDLlOFeZi_rGWNNdbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56881107ACE3;
        Mon,  1 Mar 2021 18:41:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40A9119744;
        Mon,  1 Mar 2021 18:41:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH resend 0/4] vboxsf: Add support for the atomic_open directory-inode op
Date:   Mon,  1 Mar 2021 19:41:39 +0100
Message-Id: <20210301184143.29878-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Here is a resend of my patch series to add support for the atomic_open
directory-inode op to vboxsf, since this series seems to have fallen
through the cracks.

Note this is not just an enhancement this also fixes an actual issue
which users are hitting, see the commit message of patch 4/4.

Regards,

Hans



Hans de Goede (4):
  vboxsf: Honor excl flag to the dir-inode create op
  vboxsf: Make vboxsf_dir_create() return the handle for the created
    file
  vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
  vboxsf: Add support for the atomic_open directory-inode op

 fs/vboxsf/dir.c    | 76 +++++++++++++++++++++++++++++++++++++++-------
 fs/vboxsf/file.c   | 71 +++++++++++++++++++++++++++----------------
 fs/vboxsf/vfsmod.h |  7 +++++
 3 files changed, 116 insertions(+), 38 deletions(-)

-- 
2.30.1

