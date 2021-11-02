Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A394437C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 22:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKBV10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 17:27:26 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43683 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbhKBV1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:27:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EB55E3201E1E;
        Tue,  2 Nov 2021 17:24:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 02 Nov 2021 17:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=e5gpuyKwqH+Bir9HLpikatUDcm
        KKMaf55jBo7dlQDtM=; b=DaKG+BRZHTIm+w3gqdqYWyegPP2VAIkQ/DSpRsV3eD
        QoP+qd6eQ6n9Ma7kQE2Ak1T0bYYBJ/W5ycy53euAig74Ae8Jmo3HxOErUv5uXBew
        9wpcvzTPbeb1MKqy8sVbyMwdfDJGgaDbdGhp2MD5fOjg28CpIbWRGxRccW78GGxN
        CAvS1BuNM9/LmGmRMQC5zldQfXaMu28d5EsqIG95plGNS5OQjAwfD5MC2Q9zNlmg
        41yBRGP3YbA35Su1P4vQvibTa9gDSt3IQR95UMsgm2+uRiuxlXMF7Xs3va3Sngfz
        pI/kWrbODLUbJiJ6z2LBus1L5FwGj3gvd5NFny2FoRqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=e5gpuyKwqH+Bir9HL
        pikatUDcmKKMaf55jBo7dlQDtM=; b=d0leh4szawm0HCT8FVTMsrvoiIAVHvm5a
        QM4hDcB8Db776qUZpAH0GMwpKLwfA2V3MJzQ1n4xR0Rv09Qx84D4x9CUiwCNDu7o
        CLmARwy1Zpy1zUEwakM5sZsyPngbVK8ht6QV7R2W4MLSXobOTCU0HExIABwcnNgJ
        VsRuFznkzt4nCeeLfAMxYwiMQab422cF8aYhAnVjwvVrgZtqcSc4wGGlOiQqU+nv
        uY3Huya7jvmS1/8mrlFR9KyVRKgwohi3XoWy+6ZXJEn5hzYR9VDXxmKHFat9J0Vm
        o7m05I1Cd7sv270iNEkleHOwIoUZGxVxmdKcjBqcHtVkQj/whnzLA==
X-ME-Sender: <xms:oKyBYS386Wk_RQgwoStI9xUZQwWlRY-kVqWV4hgbrSC6t7LG6s0CNw>
    <xme:oKyBYVHpohico6d7JuVlVGF_gQLNMDAR_qQeiumtwh52w8aKzMXxNiYEPc-4kYqyf
    zudpxqoK2WJq8W10A>
X-ME-Received: <xmr:oKyBYa51CCdyuZvfYAWWRW-9dXuN6BCjDpxG9SEHmHcd1GUXU-rBNs-Z99AKbVZa506ksXQTIfA5HiC9_96dCEUfLCap2qHYBACkFbqS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhsthho
    phhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekfedtffejtedvgfelgedtgfdvkeffgfffieei
    leeuleekudfgteegteeigeekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:oKyBYT3bn916UwLYaZb6O2OQJsdnFwq2uIaw6ckxAe2W_wVCVEoukQ>
    <xmx:oKyBYVHriDq1Wl03da7_U0JtfjBaqHW1m6b_kUHKfbB-4A4XvNo5sA>
    <xmx:oKyBYc-TSZ1rm2brgqNqeRKJ-4FCa6A9obDtoWOKbbamOxtUqmQ5Iw>
    <xmx:oayBYTMx7oirvI4-4JjY9FyF0xaSXEI_Tq1c5qJfqv2LIKHs0LkfRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Nov 2021 17:24:47 -0400 (EDT)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH 0/4] exfat: minor cleanup changes
Date:   Tue,  2 Nov 2021 22:23:54 +0100
Message-Id: <20211102212358.3849-1-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

Hi,

These patches contain a few minor changes I wrote while studying the
exFAT file system driver.

With best regards,

Christophe Vu-Brugier (4):
  exfat: simplify is_valid_cluster()
  exfat: fix typos in comments
  exfat: make exfat_find_location() static
  exfat: reuse exfat_inode_info variable instead of calling EXFAT_I()

 fs/exfat/dir.c      |  6 +++---
 fs/exfat/exfat_fs.h |  2 --
 fs/exfat/fatent.c   |  4 +---
 fs/exfat/file.c     | 14 +++++++-------
 fs/exfat/inode.c    | 11 +++++------
 fs/exfat/namei.c    |  6 +++---
 fs/exfat/super.c    |  6 +++---
 7 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.20.1

