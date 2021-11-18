Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF98D456509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 22:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhKRVbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 16:31:42 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38107 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229795AbhKRVbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:31:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 423D55C0118;
        Thu, 18 Nov 2021 16:28:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Nov 2021 16:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=NLwPJJpbYaPqGrKT8L4DdKi8W9
        BT6JPK2nAzjv5Ph4w=; b=QudZmgdivCJ+HebQCSjxCT2ex0vtPccFBlYpk+9n3x
        GGbjOrIQwqo0kY2LpovogzVdWHgUS6g1X1xFJ5a4BkHLodClQ9IixWhwtSe+NX7P
        97BzqN07mzSRWJLD2xF8EPvFbJ/jMiUvr7bQ7YxNP0Q6EoS7OlbntnNghY3IuC7Q
        m9iqIbdQNAMcVr0a8elS4zcXPtPfy76AhibdBWWuDMJMBFHgCNt4nDPfcm3C/C+P
        Edo2sK/USBIlmDDC2d97hxkEWCqOStT1XIMx72AH16RpzuO79I48OspTIxei6Wba
        EUBNY33DmhMZVoQLCW2Qz64rbhiEmEAqfOGD3DH1PByQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NLwPJJpbYaPqGrKT8
        L4DdKi8W9BT6JPK2nAzjv5Ph4w=; b=Z0Gdra+O31R3Gz7Inpj7iPTugzlM04WY5
        iEQmdG2uR8qbhguCoGyhTM7upnVbcI89Q1u4sv/fJKzuNmdGWnLC30Z0+/eZOOtW
        n8AfJloc6wcJMK8jNSPIQmRHaCSC5f9DCjsX+BV+HZ4/O6/LyLZn3osy+zkcUpno
        YDpvTyM9McLW1J8RaxvVtgDKFa44b4TISBqJSGirkAoPZAokKA/Ha7JUukWLgcjk
        fhnfqj4k1KglEcUXvmYxY3Uaul05urbZ4wfDsaW6MyESkoUiet8Wpbp8iDhGrDfv
        RRiFWBXlpkYq0R3rktGw085kIULEHuIEihIlYcaI1ntpGjYqRHQYg==
X-ME-Sender: <xms:iMWWYaXiKWaZIFum_HSycOqJ9Mw4-ZR0fiDsrzOciEjku0prgt1wqA>
    <xme:iMWWYWnah2-mhl-CS-sD3R605uDVnCcSmqwKDZTFb_NvDWNdDT_qq6DD9B6-oapup
    CyBPujgh_TSP5HN2A>
X-ME-Received: <xmr:iMWWYeasPukD-GMEVw_QWVRpHu6960Jai1-0qcAuDQW1RZgTLYEe5w9U6yPd6uCyJcJpvV3eiZvgB4qhyaspkqpQCbsYEojPoLJ70m53>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeigddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhsthho
    phhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekfedtffejtedvgfelgedtgfdvkeffgfffieei
    leeuleekudfgteegteeigeekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:iMWWYRWu8btbk8BekjuZKbqDUkrmodFtQ0A55lQ9H_92Nl0LN9opQA>
    <xmx:iMWWYUnB7RUCsthRD80DF9Ibo3P3Xz3LX6w2_BnwipB0BM-wZ1No1A>
    <xmx:iMWWYWd-FfBexd1yGykpPEZIyLF__RfVpVyy9W0f_S7-LoU0NvyIGA>
    <xmx:icWWYZxOCoICeK7lDhJk9m2arvWE8jPDSadQ7IzcRBO_m7j5wwBcSA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 16:28:40 -0500 (EST)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH 0/1] exfat: fix i_blocks for files truncated over 4 GiB
Date:   Thu, 18 Nov 2021 22:28:27 +0100
Message-Id: <20211118212828.4360-1-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

The following patch fixes an issue in the exFAT driver. The number of
allocated blocks becomes wrong if a file is truncated over 4 GiB.

A similar issue was fixed last month by Sungjong Seo:

  commit 0c336d6e33f4 ("exfat: fix incorrect loading of i_blocks for
                        large files")

Below is a test case for the issue. A 7 GiB file is truncated to 5 GiB
but stat() st_blocks shows only 1 GiB being used.

$ dd if=/dev/urandom of=file.bin bs=1024k count=7168

$ /sbin/xfs_io -c "stat" file.bin
fd.path = "file.bin"
fd.flags = non-sync,non-direct,read-write
stat.ino = 11
stat.type = regular file
stat.size = 7516192768
stat.blocks = 14680064

$ /sbin/xfs_io -c "truncate 5368709120" file.bin

$ /sbin/xfs_io -c "stat" file.bin
fd.path = "file.bin"
fd.flags = non-sync,non-direct,read-write
stat.ino = 11
stat.type = regular file
stat.size = 5368709120
stat.blocks =  2097152

Christophe Vu-Brugier (1):
  exfat: fix i_blocks for files truncated over 4 GiB

 fs/exfat/file.c  | 2 +-
 fs/exfat/super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.33.0

