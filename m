Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB811439C27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhJYQ74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 12:59:56 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49438 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234107AbhJYQ74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:59:56 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6F2E11D18;
        Mon, 25 Oct 2021 19:57:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635181051;
        bh=zE92f7no4pPlDEilsj0pP1PCQtLcS1RcHHNEWDSZNLA=;
        h=Date:To:CC:From:Subject;
        b=qhhE8t+TDmtff5FnK9/CyzHEyTPank/TsaKtaOOnukaMc/ec8AV1v+gC4LoLAfHQn
         AstlWKoplKfwaVsEKnslHsZr4i/zeI5NdRnx5b/9Y13vwzFfyiHN3oY47FphVT22FK
         m7fKWTx44HhwwTMf1G13aL7Ib9CKN6xhM39GGg4U=
Received: from [192.168.211.155] (192.168.211.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 25 Oct 2021 19:57:31 +0300
Message-ID: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
Date:   Mon, 25 Oct 2021 19:57:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/4] fs/ntfs3: Various fixes for xfstests problems
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.155]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes generic/444 generic/092 generic/228 generic/240

Konstantin Komarov (4):
  fs/ntfs3: In function ntfs_set_acl_ex do not change inode->i_mode if
    called from function ntfs_init_acl
  fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated
    space)
  fs/ntfs3: Check new size for limits
  fs/ntfs3: Update valid size if -EIOCBQUEUED

 fs/ntfs3/file.c    | 10 ++++++++--
 fs/ntfs3/frecord.c | 10 +++++++---
 fs/ntfs3/inode.c   |  9 +++++++--
 fs/ntfs3/xattr.c   | 13 +++++++------
 4 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.33.0

