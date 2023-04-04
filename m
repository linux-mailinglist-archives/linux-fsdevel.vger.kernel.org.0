Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814B6D6A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjDDRO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjDDROl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B31720;
        Tue,  4 Apr 2023 10:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 217B36378B;
        Tue,  4 Apr 2023 17:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F60FC4339C;
        Tue,  4 Apr 2023 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628479;
        bh=YaUvSAb+y+Cjb64X7Lrm9tby/Kb+5UTjRbbEV78qtVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyONJpNXKaLMFKaOhSSWFqJTNcbR8KyZFi907wXZjLR8By0KvxzrxkADm26HVSJdg
         87pZbHXq117AiS7wENSNNfIIBGaAbnO09US11y0lcQ4cRw7vhTLoRx8AQsbqThN9Ti
         sAou1kJDg50Ug+NiXGtrhH9vfZiLd+zaMxfQRv/iBLxG8G70cJZ0ONrDKZEmk9+jbn
         kCzmVPLHrpa7VQ+t7BkLgv6dzA28ov1ROlx1OMrr8oRPcCylnGBRgfZOrVoatSpU46
         m8tklPFCdAHD66VUnnu6oM3EhHEURsZV4bITFuVetU4lBd7HsAjjrgjP7ohCgefa5K
         J0ZS0OzI+Bcgg==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        djwong@kernel.org, anand.jain@oracle.com
Subject: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Date:   Wed,  5 Apr 2023 01:14:09 +0800
Message-Id: <20230404171411.699655-4-zlang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404171411.699655-1-zlang@kernel.org>
References: <20230404171411.699655-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fstests supports different kind of fs testing, better to cc
specific fs mailing list for specific fs testing, to get better
reviewing points. So record these mailing lists and files related
with them in MAINTAINERS file.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

If someone mailing list doesn't want to be in cc list of related fstests
patch, please reply this email, I'll remove that line.

Or if I missed someone mailing list, please feel free to tell me.

Thanks,
Zorro

 MAINTAINERS | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b1a5a3..620368cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -107,6 +107,83 @@ Maintainers List
 	  should send patch to fstests@ at least. Other relevant mailing list
 	  or reviewer or co-maintainer can be in cc list.
 
+BTRFS
+L:	linux-btrfs@vger.kernel.org
+S:	Supported
+F:	tests/btrfs/
+F:	common/btrfs
+
+CEPH
+L:	ceph-devel@vger.kernel.org
+S:	Supported
+F:	tests/ceph/
+F:	common/ceph
+
+CIFS
+L:	linux-cifs@vger.kernel.org
+S:	Supported
+F:	tests/cifs
+
+EXT4
+L:	linux-ext4@vger.kernel.org
+S:	Supported
+F:	tests/ext4/
+F:	common/ext4
+
+F2FS
+L:	linux-f2fs-devel@lists.sourceforge.net
+S:	Supported
+F:	tests/f2fs/
+F:	common/f2fs
+
+FSVERITY
+L:	fsverity@lists.linux.dev
+S:	Supported
+F:	common/verity
+
+FSCRYPT
+L:      linux-fscrypt@vger.kernel.org
+S:	Supported
+F:	common/encrypt
+
+FS-IDMAPPED
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	src/vfs/
+
+NFS
+L:	linux-nfs@vger.kernel.org
+S:	Supported
+F:	tests/nfs/
+F:	common/nfs
+
+OCFS2
+L:	ocfs2-devel@oss.oracle.com
+S:	Supported
+F:	tests/ocfs2/
+
+OVERLAYFS
+L:	linux-unionfs@vger.kernel.org
+S:	Supported
+F:	tests/overlay
+F:	common/overlay
+
+UDF
+R:	Jan Kara <jack@suse.com>
+S:	Supported
+F:	tests/udf/
+
+XFS
+L:	linux-xfs@vger.kernel.org
+S:	Supported
+F:	common/dump
+F:	common/fuzzy
+F:	common/inject
+F:	common/populate
+F:	common/repair
+F:	common/xfs
+F:	tests/xfs/
+
 ALL
 M:	Zorro Lang <zlang@kernel.org>
 L:	fstests@vger.kernel.org
-- 
2.39.2

