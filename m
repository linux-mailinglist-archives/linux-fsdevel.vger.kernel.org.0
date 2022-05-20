Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDB52EEC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbiETPKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350639AbiETPKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 11:10:52 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6163A0;
        Fri, 20 May 2022 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1653059446; i=@fujitsu.com;
        bh=AVZvvk8By7v5SnMkr9rpDYtWLxmKN2qhcVg7w2Ws7Pk=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=h5mjKwiGdcrY1dSiefe34rZzXhdQ+9Sm38mtkRjdUTckAAgQw+5sEB6/tY7N9s+J3
         UHQi7zCvT3C2kLScv8BHJHJvGUJgm5QzD6s2njXMCXswhJBYGD71jAZmLIaFrXFkKP
         9tuvweKbNTVPje+qQx/jdjPyjHEwB/kOUYAWmTMNWisoVpatuY1m4w3327QbuFo1LL
         6qMwuSq7Jd9AqzDlhQLhXFDFNpnVOQDmRiL5kDc+dvU0NzvYiu9OU/J/u9kWjOiF7s
         +nOhgsX/pf55PaQbRQ0GoFizKLHPxRFjn1gjnVej8xyiM8uMmE622C8RK+xfpJetf3
         Tmetq0x62o7Ng==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42Kxs+FI0i1d355
  kMGGHnsXrw58YLT7cnMRkseXYPUaLy0/4LH4uW8VusWfvSRaL83+Ps1r8/jGHzYHD49QiCY/N
  K7Q8Nq3qZPP4vEnOY9OTt0wBrFGsmXlJ+RUJrBkLprxnKjjIUXGw/RNbA+N89i5GLg4hgY2ME
  l9e7GCBcOYySUyfewwqs4dRYv67HUxdjJwcbAKaEs86FzCD2CICjhIv2mewgNjMApsZJZY9Dg
  exhQXsJG5du8/WxcjBwSKgKvF2lz1ImFfAQ2L9hB1sILaEgILElIfvwcZwCnhKLLjeDVYuBFS
  zZIEMRLmgxMmZT6CmS0gcfPGCGaJVUeJSxzdGCLtC4vXhS1BxNYmr5zYxT2AUnIWkfRaS9gWM
  TKsYrZOKMtMzSnITM3N0DQ0MdA0NTXWNjYBME73EKt1EvdRS3fLU4hJdI73E8mK91OJiveLK3
  OScFL281JJNjMBYSSlWyNjB+H3lT71DjJIcTEqivKUr2pOE+JLyUyozEosz4otKc1KLDzHKcH
  AoSfDmrAHKCRalpqdWpGXmAOMWJi3BwaMkwiu/FijNW1yQmFucmQ6ROsWoy/H0+Ym9zEIsefl
  5qVLivHbrgIoEQIoySvPgRsBSyCVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwryqq4Gm8GTm
  lcBtegV0BBPQEbeUW0GOKElESEk1MCVICcRH7dqxt0yEKaw1uWR3xpkrzxdLbDqwV7ap98f0y
  5f/RFS/yVRKfjMnc2NJpEgt0x2FTfeCjH96MWs4Sk/cdWa9j3y1k4Hj7vm3GhXmbZmcsaMksa
  yFV97MnqVmeRJv9BEZPtmGDmXuM33tHfE/vgvz1MzzdH8YN+Vh3JXXy4wMNU7LiVdtcbzsNWn
  3GaUEluOS1zevepwZJPV9xmP2kgJNMyWePZmNV64etY5YuTDd7R8v45ecxmcZJrqB8z8cW7R/
  4Zqilid9hxNr/Cd9+hA3e53tItmytw/lUuyTc6ZXfTPQ8nferfZ0/xlN+R+/7hnYrS7cyev5/
  eqNVtmZj1faL2c1i7hmvG/lVCWW4oxEQy3mouJEANr3H0GcAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-571.messagelabs.com!1653059445!68088!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6459 invoked from network); 20 May 2022 15:10:45 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-9.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 May 2022 15:10:45 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 13A2AD75;
        Fri, 20 May 2022 16:10:45 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id D635BB5C;
        Fri, 20 May 2022 16:10:44 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 20 May 2022 16:10:32 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v9 4/4] ceph: rely on vfs for setgid stripping
Date:   Sat, 21 May 2022 00:10:37 +0800
Message-ID: <1653063037-2461-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1653063037-2461-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1653063037-2461-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we finished moving setgid stripping for regular files in setgid
directories into the vfs, individual filesystem don't need to manually
strip the setgid bit anymore. Drop the now unneeded code from ceph.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ceph/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8c8226c0feac..257ec53b1765 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -657,10 +657,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		/* Directories always inherit the setgid bit. */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(dir->i_gid) &&
-			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
 	} else {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
 	}
-- 
2.27.0

