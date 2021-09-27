Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1386C419827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhI0Pr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:47:59 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:44013 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhI0Pr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:47:59 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id B2740820E8;
        Mon, 27 Sep 2021 18:46:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632757577;
        bh=NZiieUg67Jcn8Z9LRxeMObN8UOVIM8Yfq/fco7QwMXw=;
        h=Date:To:CC:From:Subject;
        b=O7P1qsBcuwdooTh5TFRUBqLNhvRfk/UyieUJDGOnNu5K+C2Dnq/vADNSDhwTbmd8P
         /xYkOMHBVGVDQq1JxIUHo66oiCKngPHI59jPKJ/PciZ/0BPH3HOv1MctqneZrprRCs
         Ubu8m1NTXohfMkod8dNn+bItPs+YQNSJMCWV2T50=
Received: from [192.168.211.27] (192.168.211.27) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 27 Sep 2021 18:46:17 +0300
Message-ID: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
Date:   Mon, 27 Sep 2021 18:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] fs/ntfs3: Refactoring of super.c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.27]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix memory leak in ntfs_discard.
Reject mount so we won't corrupt fs.
Refactor ntfs_init_from_boot function.

Konstantin Komarov (3):
  fs/ntfs3: Fix memory leak if fill_super failed
  fs/ntfs3: Reject mount if boot's cluster size < media sector size
  fs/ntfs3: Refactoring of ntfs_init_from_boot

 fs/ntfs3/ntfs_fs.h |  2 --
 fs/ntfs3/super.c   | 36 +++++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.33.0

