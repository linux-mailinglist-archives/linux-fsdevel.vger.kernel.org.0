Return-Path: <linux-fsdevel+bounces-5312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BE80A351
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524531F21415
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD013ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Y22GGZoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404E10CA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034830;
	bh=44CkX4+ckoIo+Cm2bpfCUlSUAWzQO7MK/E1kJ38W4PY=;
	h=From:To:Cc:Subject:Date;
	b=Y22GGZoF3xRdxsNH/VrbhFhTJnU8Ehao31oyR6jFLs/h1ypHZIYLeEY5VJ9We2uSr
	 N8WJeeIYoILTTsnxlQpNzfa3W2Gca/XCQA7vTMVf0V/RSO5IIcdHHUI+bZSH6TGAW/
	 iA7Q5a6th8SgYOmEvHSl4wYrEvHD3kE73+VAkdVM=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034448t7yd7jnbh
Message-ID: <tencent_0E5AE3EC14C4E534F5D1CF23DD4D7C4CE005@qq.com>
X-QQ-XMAILINFO: Mkw1Oys1xyjC+aNo2qoMx+yhdo2c+xBltJdfeLfZ+hS9upIRLGCo9mPbEBG4Zr
	 SUtViMpxOqd5EBgbDg+QD1Vdv1/LA8iO4DwBf424KbNpFRLVZhpm/tAzkAdEaCb2CWIshGsm5gRn
	 XstMvGDZBGWg9O6Y/XAzujfGO6MAty/ImaOBvimSlcdTxf+IZp9/XUoDs7BaXca+m6+gZTxAk7LD
	 cSMGTVW+jLsdgpNxJBAZLgqi4VIVVwuaB+UaNYOEzyO1NWYkXspkXSA6zSbgt3Q0SNGmAAFi+URS
	 3hV9iQNKSMkZ4cshq5ej4KJdumN/ccZ66/eSIr5EnFaQjwKJPGgdaE/1ArZvoz11HF4pMbJr1gwG
	 H8xKHQ3kg1boTrW5iGd8qNdtOIqs2MfKWTV+2TJzZt6fGe74Sy4Cbp6b915ddg0+LbLN6eK8Wzxs
	 TIeY969ySmVCke5NwLkAFN49z4Pshir49o2TlMrdDboNuVBfFOJNtMTRr7VktcA6Pm6MAmCujptc
	 r3UeojOgzugcXhEtn903ZYN4FXpjL/xHwS1XkHUls0cyH/ZD6W9FtzwdjqJz6Qni92yd47nke0/T
	 Yr50xCqpS9UlyHbMq/hW7pGsJs75j5sZuxBa128WfaM+K2W1Az2R+qqmpWARaUJwUPw2KBgHErVT
	 UfEaSeShCZLqWZg6SSvMI8UL5EGn5Vfjc1G1dmsS8mF7j0UxFMIfgSeIs0tullIwU66/Ufrp3uhH
	 1LA7GQBtE2g3kR4n2zxosLdZit/RdfEUhknn3cyDkVhy/msuWG99zed4HWA62Z5sjzP1hn+Hnw43
	 pETmCLvSQl8wJTYeXdLoEcgxmaAxMTUC017ej1goweO5v0pjrc6mE3JCNMfpdss9FmmbU2UpBAWO
	 v9YheUFfQwK6KKuQMAtQ6d/Z899t9nAutnPcYwW0KzI/D5aKcVgLcSQHbcvFnholM0ECzE9EzIeK
	 Lqx7Vkyyd5vwV/+N0hFn6TAaCD4TcE9r+61Uhw6Bj4xRlLjMYTr19eJV5/nRcy4LqUnjYFxfE=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 00/11] exfat: improve sync dentry
Date: Fri,  8 Dec 2023 19:23:08 +0800
X-OQ-MSGID: <20231208112318.1135649-1-yuezhang.mo@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

This patch set changes sync dentry-by-dentry to sync
dentrySet-by-dentrySet, and remove some syncs that do not cause
data loss. It not only improves the performance of sync dentry,
but also reduces the consumption of storage device life.

I used the following commands and blktrace to measure the improvements
on a class 10 SDXC card.

rm -fr $mnt/dir; mkdir $mnt/dir; sync
time (for ((i=0;i<1000;i++));do touch $mnt/dir/${prefix}$i;done;sync $mnt)
time (for ((i=0;i<1000;i++));do rm $mnt/dir/${prefix}$i;done;sync $mnt)

| case | name len |       create          |        unlink          |
|      |          | time     | write size | time      | write size |
|------+----------+----------+------------+-----------+------------|
|  1   | 15       | 10.260s  | 191KiB     | 9.829s    | 96KiB      |
|  2   | 15       | 11.456s  | 562KiB     | 11.032s   | 562KiB     |
|  3   | 15       | 30.637s  | 3500KiB    | 21.740s   | 2000KiB    |
|  1   | 120      | 10.840s  | 644KiB     | 9.961s    | 315KiB     |
|  2   | 120      | 13.282s  | 1092KiB    | 12.432s   | 752KiB     |
|  3   | 120      | 45.393s  | 7573KiB    | 37.395s   | 5500KiB    |
|  1   | 255      | 11.549s  | 1028KiB    | 9.994s    | 594KiB     |
|  2   | 255      | 15.826s  | 2170KiB    | 13.387s   | 1063KiB    |
|  3   | 255      | 1m7.211s | 12335KiB   | 0m58.517s | 10004KiB   |

case 1. disable dirsync
case 2. with this patch set and enable dirsync
case 3. without this patch set and enable dirsync

Yuezhang Mo (11):
  exfat: add __exfat_get_dentry_set() helper
  exfat: add exfat_get_empty_dentry_set() helper
  exfat: covert exfat_find_empty_entry() to use dentry cache
  exfat: covert exfat_add_entry() to use dentry cache
  exfat: covert exfat_remove_entries() to use dentry cache
  exfat: move free cluster out of exfat_init_ext_entry()
  exfat: covert exfat_init_ext_entry() to use dentry cache
  exfat: remove __exfat_find_empty_entry()
  exfat: remove unused functions
  exfat: do not sync parent dir if just update timestamp
  exfat: remove duplicate update parent dir

 fs/exfat/dir.c      | 286 ++++++++++++++++++-----------------
 fs/exfat/exfat_fs.h |  23 ++-
 fs/exfat/inode.c    |   2 +-
 fs/exfat/namei.c    | 352 +++++++++++++++++---------------------------
 4 files changed, 288 insertions(+), 375 deletions(-)

-- 
2.25.1


