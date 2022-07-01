Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C3563426
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiGANLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiGANLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:11:41 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C79D5925C;
        Fri,  1 Jul 2022 06:11:26 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7254221B5;
        Fri,  1 Jul 2022 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656681016;
        bh=02KihnYdaZm2ncpfXa/zdWa/4dUMAjXhtcspmqZ/iQc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=mP4lTzPxF70rg8R7AaoBiR2jL2xAFAY+/6mtWP6oh7IKcqR5wLOJ1idZf5Zjh8i7L
         OfBAp92Ofh+91lXT/L+ZGvnA37YVn15fwKKQtETHQylGpHDbegufSUGpnQi94rQqQO
         jLkzOUXZNqufZbc7pstGHzmk0s+QpPwIQHpIFB+8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B8B4B21B8;
        Fri,  1 Jul 2022 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656681073;
        bh=02KihnYdaZm2ncpfXa/zdWa/4dUMAjXhtcspmqZ/iQc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=KvvpoADQyImOQM7pjCEgEWkZjUezYYwliAyAPGCu8BtmjposgJNA2ewq3EaCC1hoT
         3FdOOzUXW1bxub9Da494xDQIpwT9QprpJReI3d5nZmt5+39xQcH9qTwVzPntRj8JrD
         xi89KWLZyPirofVKtghKw0441ycBJA7XABOgKoeE=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Jul 2022 16:11:13 +0300
Message-ID: <5ddc83fd-5e98-d66a-91c2-afb8a037ebb6@paragon-software.com>
Date:   Fri, 1 Jul 2022 16:11:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH 4/5] fs/ntfs3: Make static function attr_load_runs
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
In-Reply-To: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
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

attr_load_runs is an internal function

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 4 ++--
  fs/ntfs3/ntfs_fs.h | 2 --
  2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 43b9482f9830..68a210bb54fe 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -84,8 +84,8 @@ static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
  /*
   * attr_load_runs - Load all runs stored in @attr.
   */
-int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
-		   struct runs_tree *run, const CLST *vcn)
+static int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
+			  struct runs_tree *run, const CLST *vcn)
  {
  	int err;
  	CLST svcn = le64_to_cpu(attr->nres.svcn);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 5472cde2aa5f..b88721e48458 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -408,8 +408,6 @@ enum REPARSE_SIGN {
  };
  
  /* Functions from attrib.c */
-int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
-		   struct runs_tree *run, const CLST *vcn);
  int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
  			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-- 
2.37.0


