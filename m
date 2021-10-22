Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC8437A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhJVP4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:56:00 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:44963 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhJVPz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:55:59 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id E7ABB81C3F;
        Fri, 22 Oct 2021 18:53:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1634918019;
        bh=Lxw5GkdUO2KWgwUcR9Ex5W3ZS1/0b0VHIXt7Vr5Qi6Y=;
        h=Date:To:CC:From:Subject;
        b=UzBQYO2a/+BZxw0JTN+IsGvwUR7yTPczHxEy0wJtN9URAQUdks8lSmQ8ITKALUsbH
         qzU+Ylk/iO01rHQzGoDlijMrOXAwkCd1ieAaK73PAT0bXIkjoo+vIj35WjDlD4Pifd
         9ybVVGutu6Vu9N0CcuxrKWb2z5J54V0PbFPMtIuU=
Received: from [192.168.211.69] (192.168.211.69) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 18:53:39 +0300
Message-ID: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
Date:   Fri, 22 Oct 2021 18:53:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/4] fs/ntfs3: Various fixes for xattr and files
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.69]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Various problems were detected by xfstests.
This series aims to fix them.

Konstantin Komarov (4):
  fs/ntfs3: Keep preallocated only if option prealloc enabled
  fs/ntfs3: Restore ntfs_xattr_get_acl and ntfs_xattr_set_acl functions
  fs/ntfs3: Optimize locking in ntfs_save_wsl_perm
  fs/ntfs3: Update i_ctime when xattr is added

 fs/ntfs3/file.c  |   2 +-
 fs/ntfs3/xattr.c | 123 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 113 insertions(+), 12 deletions(-)

-- 
2.33.0

