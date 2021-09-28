Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F043141B4CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbhI1RSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:18:05 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:51360 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241935AbhI1RSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:18:04 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id D6C7F81FE6;
        Tue, 28 Sep 2021 20:16:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632849382;
        bh=q9FQW1NyPX+/PEIXZoUtfUROqa82bC7XxrBaUVEa47g=;
        h=Date:To:CC:From:Subject;
        b=Jn1HIwncXV3i6cPUwtI4YlFT5xHagzc+ohiRu/AKMhvQcqH6j8xiU+xdW+x3xCZFv
         7vn0Rgc/SsFBA19DWM1kcnpM5MGOQz+W5duFqUHtYDs77IW6exfr7C0CEXiFJy1vB5
         OpOV6NnZinexR4bStw6PDfJ69+u47eD1/mK+wwvs=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 20:16:22 +0300
Message-ID: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
Date:   Tue, 28 Sep 2021 20:16:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2 0/3] fs/ntfs3: Refactoring of super.c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.85]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix memory leak in ntfs_discard.
Reject mount so we won't corrupt fs.
Refactor ntfs_init_from_boot function.

v2:
  Fixed wrong patch 1/3.
  Merged two changes to the same piece of code.

Konstantin Komarov (3):
  fs/ntfs3: Fix memory leak if fill_super failed
  fs/ntfs3: Reject mount if boot's cluster size < media sector size
  fs/ntfs3: Refactoring of ntfs_init_from_boot

 fs/ntfs3/ntfs_fs.h |  2 --
 fs/ntfs3/super.c   | 36 +++++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.33.0

