Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470764048C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhIIK7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 06:59:12 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:54207 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234190AbhIIK7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:59:05 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 7A9EB8222B;
        Thu,  9 Sep 2021 13:57:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631185072;
        bh=lFeB5P4IRKLH+dCr4Ctl4bLHANihU+j33NAESc0WfIo=;
        h=Date:To:CC:From:Subject;
        b=ushFAaCx+06CteDOHPfvT7D4fZYGztGERWbnzdjCy0vdq3sh6Q/MuUbE8BlVQujV6
         JQcTVUIelnHDnWS36clzVDA1piTd3rPpXd8vRI7US9vmm6X/wd5oP044sGhPaSr4ND
         tqJ2jr+qALZ+41F/SjIgrulFO7E+pSCBVbgARKAs=
Received: from [192.168.211.46] (192.168.211.46) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 9 Sep 2021 13:57:52 +0300
Message-ID: <db0989dd-c03b-d252-905c-f0ebd0abe27f@paragon-software.com>
Date:   Thu, 9 Sep 2021 13:57:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] fs/ntfs3: Speed up hardlink creation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.46]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfstest 041 was taking some time before failing,
so this series aims to fix it and speed up.

Konstantin Komarov (3):
  fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
  fs/ntfs3: Change max hardlinks limit to 4000
  fs/ntfs3: Add sync flag to ntfs_sb_write_run and al_update

 fs/ntfs3/attrib.c   | 2 +-
 fs/ntfs3/attrlist.c | 6 +++---
 fs/ntfs3/frecord.c  | 6 +++++-
 fs/ntfs3/fslog.c    | 9 +++++----
 fs/ntfs3/fsntfs.c   | 8 ++++----
 fs/ntfs3/inode.c    | 2 +-
 fs/ntfs3/ntfs.h     | 3 ++-
 fs/ntfs3/ntfs_fs.h  | 4 ++--
 fs/ntfs3/xattr.c    | 2 +-
 9 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.28.0
