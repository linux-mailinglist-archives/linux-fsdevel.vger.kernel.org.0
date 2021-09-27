Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36EE4197DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhI0P2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:28:21 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:38042 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235112AbhI0P2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:28:07 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 53D4F82215;
        Mon, 27 Sep 2021 18:26:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632756387;
        bh=i6bYZLXmor/RfRF2EogMQiOHKnFbIX15Y4f9ovWqXAs=;
        h=Date:To:CC:From:Subject;
        b=t3R0Pr22o2nLBd6mqHe5Y7V33SVKrLXht0jffz9WkWw07Jmr7mgUMfRHgI+g/Im1Y
         mGVXcdKzkVc0WBJEfARUmq9AAkUQSvZDobDTlTHJMR2UMtznOyZ3V3oCJKlvu+LL2N
         m4I2eimlt3Hqgf5tXNKrFc5m0KRZLK/c2SbQYgl0=
Received: from [192.168.211.27] (192.168.211.27) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 27 Sep 2021 18:26:27 +0300
Message-ID: <a1204ce8-80e6-bf44-e7d1-f1674ff28dcd@paragon-software.com>
Date:   Mon, 27 Sep 2021 18:26:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2 0/3] fs/ntfs3: Refactoring of xattr.c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.27]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removed function, that already have been in kernel.
Changed locking policy to fix some potential bugs.
Changed code for readability.

V2:
  fixed typo.

Konstantin Komarov (3):
  fs/ntfs3: Use available posix_acl_release instead of
    ntfs_posix_acl_release
  fs/ntfs3: Remove locked argument in ntfs_set_ea
  fs/ntfs3: Refactoring of ntfs_set_ea

 fs/ntfs3/xattr.c | 69 ++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

-- 
2.33.0

