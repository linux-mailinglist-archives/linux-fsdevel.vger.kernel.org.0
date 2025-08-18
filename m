Return-Path: <linux-fsdevel+bounces-58173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECAB2A9DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552371B63E94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C1322DCF;
	Mon, 18 Aug 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E9j1yP6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FC322A39;
	Mon, 18 Aug 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525595; cv=none; b=qatoY2sRIv7DCyWjtLuDLRzY4/P+oivtEEVdN5h8PB1Wpw/5ibk5JP9xsaKdMGRGl01qCbP/oH4g4987CmYTyfbFs+DXhy8g1hjCWjzv6TPfY2VFQ3hTBfMx8Fb3V3xrGRClgwzBf3wUOwFWU4l4ZHaA1chFjGUO7m+wBbFHcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525595; c=relaxed/simple;
	bh=jj53V94zqaHhX9kDmLB5IOaA+ZJ0TvHlFvFNhVaoAyw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pfhUBb5igOOvQJLXtuBT7mFBk0mPOdcPTMvtl3WPan2MnjugefjEy/cQ3kIEh2bUXYcytjI/yb0p7p5bP4Vb8us5JIS0p3p+AUH/BPhn3B5r/ssTfGdTkV9JLmlfUxn/Cv41JolvHYyNN/Xa6YoN2YqTFHLYtTCh7mzjFYbvsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=E9j1yP6x; arc=none smtp.client-ip=43.163.128.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755525590; bh=jO6mm0SEtl/dOnAj5fjSuDHUXJTe4jEIzLbN9ric9mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E9j1yP6xB/FVZKl3MZ5Jbl4KeFZ3CUdAatvjnj3U70z1SvU7KDFnzBfJtZObSLvIp
	 zcIqwhn8+JB0mznKoD9rPmflmFlfGycghdH/SEIBQFP3Xtwm20YAjga+FhRebRcCiW
	 wmfhOfMHpUYLp0cFf03z7yGgGmhvmAZYEfdInG8U=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E9707618; Mon, 18 Aug 2025 21:58:23 +0800
X-QQ-mid: xmsmtpt1755525503ta32cnhnn
Message-ID: <tencent_44D70651C9BAEEF1EEC70C85A7DF46D71206@qq.com>
X-QQ-XMAILINFO: NrNHTFHgCqYay8hiWnes+LpuXKDZczPVfsB5vT53Rni7ByHTB2ibBRUXX1XttM
	 yQXsRWCkVr0TF/fWCln+paXfY9fn9/CsA2QeZiaGxDYVDM4Ld/E32gxv7uhzZ2kaDuaDsYvA/oej
	 Hc8NZpU2MMuFMDWmGNn6iU41wvyAowKFpPstpk21ZO/LHn+lV0gS9utlsMWbbxkMV98bObycHxDg
	 1h/v3t2x/2NsuSdjsj+RhlX+uLA+7LhbHoZs7hn9/Ucphnr2W+MeDV1PdLKMQxh6oUXZVmFRyOZ/
	 fEXvqCz+2MQ2U42P0JcZfnugMZezqwSg0DE8i14eXtS4HWJ1PqR5d8ICS7KWyxd7y8AnwiTgHd2j
	 J7bO/JeRMY+qS32K4WxSV1KpGL/nVva0NmVRLSCFYCSufAERIDZD025WTH1RUOXIXjvAJcTLPAob
	 Rey1E26RWOPuCmYS57Uh56vsOUIHB5/6aK3UmTjR/OnU8cCgBbLjTM6PjTa6+DdyGArNUUFt89OM
	 uPgp1I8Mo27UKfxe0Lu+L23FReHi5b2vGiwmWUeu0j4R8Edq/RWIkKWjRi3VYUd/28WD+TNyc/UL
	 gRn3hRRjqf6wcclOV2MgIK+iSFlsaITohuFOIWLp/2pKeJNaQjOIbMGMYYMc638yd/Z+NNOmtUTV
	 5pU/krEfyNrQPB9bqcy1c6dhiQtUCt2AGAeK7fbbje+SdVxQOd7ik/ZlcNmeqal6b/yIecE/MRWP
	 JLmTtladJTUq2thrJWGLylJB/mN6gDu/NZZO99FyH6B8mZBg+/5lusgViH4ita5Kf7KtJy2oqxlE
	 dTBLNiaeeGoa+WlJQtpl5E5NOj5w068Na5emcbbWymGkB6KP2/P6WW62qNu80/56tifoQJ+WJd3p
	 Sj1zSJm9M98Apx1W+YnRpMg34aBnVjkjWIXZggTZs8M3yt4Q8ltYslc9jDtqdw6ceAkyDQwUxWBI
	 dEAvXikeZ2yFFhFgaGvAEjclnn/5KK4zMjLjTglS5iPEy97GsIJiEH/tj+KiX8uMmkVzvQJt89wR
	 U/yHIJZkNZ2Cjr460V73nKJi7GWCM=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: viro@zeniv.linux.org.uk
Cc: eadavis@qq.com,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] fat: Prevent the race of read/write the FAT32 entry
Date: Mon, 18 Aug 2025 21:58:23 +0800
X-OQ-MSGID: <20250818135822.535841-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729100635.GH222315@ZenIV>
References: <20250729100635.GH222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 11:06:35 +0100, Al Viro wrote:
syzbot reports data-race in fat32_ent_get/fat32_ent_put.

	CPU0(Task A)			CPU1(Task B)
	====				====
	vfs_write
	new_sync_write
	generic_file_write_iter
	fat_write_begin
	block_write_begin
	fat_get_block			vfs_statfs
	fat_add_cluster			statfs_by_dentry
	fat_chain_add			fat_statfs
	fat_ent_write			fat_count_free_clusters
	fat32_ent_put			fat32_ent_get

In fat_add_cluster(), fat_alloc_clusters() retrieves an free
cluster and marks the entry with a value of FAT_ENT_EOF, protected
by lock_fat(). There is no lock protection in fat_chain_add().
When fat_ent_write() writes the last entry to new_dclus, this has
no effect on fat_count_free_clusters() in the statfs operation.
The last entry is not FAT_ENT_FREE before or after the write.

Therefore, the race condition reported here is invalid.

BR,
Edward


