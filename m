Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484025B5E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiILQhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiILQhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:37:34 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83421827;
        Mon, 12 Sep 2022 09:37:33 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id CA7951D28;
        Mon, 12 Sep 2022 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663000531;
        bh=Ui8pdc+SYrf0NKbT80RGG/JWRJM3TTpCzms4S0GlvCY=;
        h=Date:To:CC:From:Subject;
        b=VydmfSURxkuljDKiJ5j/+eDuwBM25EAwZiPVZj3VnuM40xZ8UEnSwt9dzMzg+WX5a
         dLzfJpobDSXIYmjFdJgkQwdBaX2JBdbrjhazL9eSz5UAh76OMxgp+SIJPXWDsazoIO
         Mz7zQz8Z5xB2DdHc6Ti1pxnElqOlRLCN8VZQMsjM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 12 Sep 2022 19:37:31 +0300
Message-ID: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
Date:   Mon, 12 Sep 2022 19:37:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] fs/ntfs3: Refactoring and hidedotfiles option
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added some info about CONFIG_NTFS3_64BIT_CLUSTER and
hidedotfiles option

Konstantin Komarov (3):
   fs/ntfs3: Add comments about cluster size
   fs/ntfs3: Add hidedotfiles option
   fs/ntfs3: Change destroy_inode to free_inode

  fs/ntfs3/frecord.c |  2 +-
  fs/ntfs3/inode.c   |  4 ++++
  fs/ntfs3/ntfs_fs.h |  1 +
  fs/ntfs3/record.c  |  4 ++++
  fs/ntfs3/super.c   | 52 ++++++++++++++++++++++++++++++++--------------
  5 files changed, 46 insertions(+), 17 deletions(-)

-- 
2.37.0

