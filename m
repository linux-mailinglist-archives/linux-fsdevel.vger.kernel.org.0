Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA15359CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhDILNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233741AbhDILNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LlwhhPpg7/dsLVztmTdE1jlVBmRFkdvw6ZvqHL4cSJY=;
        b=B2NI2jtmGltElinEQMZyu9yvydxhMbESDehCp7nioJXAhAoDjVKM724mnYHlYddm2aT2hd
        FmNTEv07pQRV9Ythh3vc3IP7/M6sgaYdPbUVSAjFu4aQmDiec3B0Lh4oCRwwOIfjjd4jGi
        DaR9Af0JPIThQBWc8PZHhstLU7WZ7zg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-UE-1IAERN--C7uF1_ZODSQ-1; Fri, 09 Apr 2021 07:12:59 -0400
X-MC-Unique: UE-1IAERN--C7uF1_ZODSQ-1
Received: by mail-ej1-f71.google.com with SMTP id pj13so2037369ejb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 04:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlwhhPpg7/dsLVztmTdE1jlVBmRFkdvw6ZvqHL4cSJY=;
        b=iFZzcH/HLDcK4nFWiEb0N9x/mAJnCewDjQS4DCISUKDJf4by+ehMHO91nnBlgFLPzi
         IgCeojVmQ1R+QWwHgKQv0H3ESa0dNNo6u1qutQ5RJcYDc0aCqMweIIxx2uytKHb8/+LH
         nI6EgvZj4H9rr852wIXBSfEHMznLikpk4S+AfdNZKKA3FfUqrQqzMSe0pwCXi8V28Ft+
         J+WaUPq5ymi9ePZRNqQmTCmhJNT2FDhzWJODKSrcsiwh7Sn9NQQgedU/kE/AzH7A5sMn
         9Khd4iJi+eOZJkacFWl/b2PXN6QtyRevSH0T5dpdt8UV4XelZGll5qvoOFPvy0ok0N8n
         RvdQ==
X-Gm-Message-State: AOAM532oJCkTc+L6VgyEQIcVi+mf2AIivgUsiAqv714vZYr8FNabw4Hj
        z9CJGdSlQPlUeaZ+t9MSjv+5hUlsrQc52eg1SAWzzBINBCzs4r81nii8HxNgXcsexDZEhQrMFL6
        ofbeOXprqXii+aH7XYIAJfUDLWA==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr16886107edj.178.1617966778544;
        Fri, 09 Apr 2021 04:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9DN2Sw6T+TRJMgdrKflu/6Pq2gsJ2XI7RSTKrE+UZAOitmzvCa6P+n4y7usKpGVJqkST9ag==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr16886085edj.178.1617966778324;
        Fri, 09 Apr 2021 04:12:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:12:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
Date:   Fri,  9 Apr 2021 13:12:52 +0200
Message-Id: <20210409111254.271800-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series attempts to clean up part of the mess that has grown around
the LSM mount option handling across different subsystems.

The original motivation was to fix a NFS+SELinux bug that I found while
trying to get the NFS part of the selinux-testsuite [1] to work, which
is fixed by patch 2.

The first patch paves the way for the second one by eliminating the
special case workaround in selinux_set_mnt_opts(), while also
simplifying BTRFS's LSM mount option handling.

I tested the patches by running the NFS part of the SELinux testsuite
(which is now fully passing). I also added the pending patch for
broken BTRFS LSM options support with fsconfig(2) [2] and ran the
proposed BTRFS SELinux tests for selinux-testsuite [3] (still passing
with all patches).

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/
[3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_haines@btinternet.com/
    ^^ the original patch no longer applies - a rebased version is here:
    https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775c7507c1996bd172de3bcbff139.patch

Ondrej Mosnacek (2):
  vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
  selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount

 fs/btrfs/super.c         | 35 ++++++-----------------------------
 fs/nfs/fs_context.c      |  6 ++++--
 fs/super.c               | 10 ++++++----
 include/linux/fs.h       |  3 ++-
 security/selinux/hooks.c | 32 +++++++++++++++++---------------
 5 files changed, 35 insertions(+), 51 deletions(-)

-- 
2.30.2

