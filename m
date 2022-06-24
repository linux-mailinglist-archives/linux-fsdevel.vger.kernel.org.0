Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A085598A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiFXLkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 07:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiFXLkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:40:01 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D7F68038;
        Fri, 24 Jun 2022 04:40:00 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D4CF01D74;
        Fri, 24 Jun 2022 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656070746;
        bh=1/1elZUUKD7tI89T7KFg5z8eRLmsFz1VvhO0iissUGM=;
        h=Date:To:CC:From:Subject;
        b=c+aKHTPDJ7weN0SbS1MeDAVimh04arl+fffqRMGC/+RUZD0l9nKZAVGpzcpwecB+H
         1UXGCkaQBh5BaEwdmFuV/SiHo4xN7Sh7rEixz3pFablhbNpOD5K9HXmCClrkDsbmPS
         gihoAjBkkcduYeeACf6pXxj1rhycO6i0cw3jDs3I=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Jun 2022 14:39:57 +0300
Message-ID: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
Date:   Fri, 24 Jun 2022 14:39:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] fs/ntfs3: Various bug fixes
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These commits fix 3 xfstests
Patches are based on version with FALLOC_FL_INSERT_RANGE support
https://lore.kernel.org/ntfs3/ab1c8348-acde-114f-eb66-0074045731a4@paragon-software.com/T/#t

Konstantin Komarov (3):
   fs/ntfs3: Do not change mode if ntfs_set_ea failed
   fs/ntfs3: Check reserved size for maximum allowed
   fs/ntfs3: extend ni_insert_nonresident to return inserted
     ATTR_LIST_ENTRY

  fs/ntfs3/attrib.c  | 46 +++++++++++++++++++++++++++++++---------------
  fs/ntfs3/file.c    |  3 ---
  fs/ntfs3/frecord.c |  4 ++--
  fs/ntfs3/index.c   |  2 +-
  fs/ntfs3/ntfs_fs.h |  2 +-
  fs/ntfs3/xattr.c   | 20 ++++++++++----------
  6 files changed, 45 insertions(+), 32 deletions(-)

-- 
2.36.1

