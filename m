Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0A43B76B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhJZQmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:42:43 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:42054 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhJZQmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:42:43 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E38F21D0D;
        Tue, 26 Oct 2021 19:40:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635266416;
        bh=sHnbaQw4Aja8R3gW9j+PJGpzrn5GboghqoJ4gVn1PSs=;
        h=Date:To:CC:From:Subject;
        b=bj2KAkQgteXcMJAyEdM5mizZAFFjjo307T21h7y/NH3mNvbJDN09nf3Mu3CZAapvF
         Em5LKLw+OHHsdaFFs7kXK4mwCa2Hrmwd6S9T1FiAzq3rIk+oC87jKyU9t4sQjrN9Oq
         TiOtbk4WiFR0t5VHkdWWeNNc5N7JE2Sm9YYRQ8UM=
Received: from [192.168.211.149] (192.168.211.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 26 Oct 2021 19:40:16 +0300
Message-ID: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
Date:   Tue, 26 Oct 2021 19:40:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2 0/4] fs/ntfs3: Various fixes for xattr and files
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.149]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Various problems were detected by xfstests.
This series aims to fix them.

v2:
  - swap patch 3 and 4;
  - fixed commit message for patch 1;
  - fixed compile error in patch 2.

Konstantin Komarov (4):
  fs/ntfs3: Keep preallocated only if option prealloc enabled
  fs/ntfs3: Restore ntfs_xattr_get_acl and ntfs_xattr_set_acl functions
  fs/ntfs3: Update i_ctime when xattr is added
  fs/ntfs3: Optimize locking in ntfs_save_wsl_perm

 fs/ntfs3/file.c  |   2 +-
 fs/ntfs3/xattr.c | 123 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 113 insertions(+), 12 deletions(-)

-- 
2.33.0

