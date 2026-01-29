Return-Path: <linux-fsdevel+bounces-75892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPSRNju7e2l0IAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:55:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE7B41BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D613021E6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 19:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDA32ABC8;
	Thu, 29 Jan 2026 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="XV7+R5rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AF2F5A36
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716534; cv=none; b=P+9u9jnGDWFSAY0vBiB+v2Jjd+ts6dif+a+xJZqum1sIvz26XFexeuMJQZcOko5kBnErkSu0SPZVVCUizukKtzOwC5uAghhhRupXmJP9t8iIZSeMHc54GHbFHoY5Bf9kpwEHEOmghExxmYjkEVo86DrWy08Z0ADVvpoXDiW+5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716534; c=relaxed/simple;
	bh=4mvhGfVmufMVXQecx/qoJdu1rrrZHIERRGU2RUk7D6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u3kr6cKu+HHKS8c0q0jaazveM4F+dKD240fnwIOgxOJhjCDKg5HVzhqbc3WT4d53r+nKtyPcOgTtlvrDpR097IJv2LiKwG+xthGBBtG1UF0Br+Y+4Bxmm63Lf7GSuwpi3JNqE7AmKKtfI36d4WPPiCEfud2s/eTKw8CngwWK2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=XV7+R5rf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79456d5dda4so13459927b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1769716532; x=1770321332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu8LL6RTmmp4YPPMJ8+s9esd7jWNAOUE78QB9JmUMXc=;
        b=XV7+R5rfehrqOp649n7blF/1Pi68kDAjK8I8K9fkMYI9xNDKkgWi09dt1R7dYzJBcu
         3zRSHVqkSUrvy++3N2/KphEu+fnwKcBft7v2oQ8rvnxZGo3+JTT0h5X7BZI10XkMIybx
         5sznjQPNTChJ+ABlbybHKim27LvV4mURfJzn9jWGnwlatE9HLIUgc+T/cuyVUHDkSbpN
         6uSGvgPp/alsT6w4wqxKwtF1L0LdEfdRa/4mY/sZmhJVx3uEmtpmInEjOxcQQygWMe9q
         XdWxOorUlt60KoKdQhLWvWcYc6Lq/Kq8VkUQAZeBjU98E92VZuPQXmXbGvJgbDnxp6+l
         meYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769716532; x=1770321332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu8LL6RTmmp4YPPMJ8+s9esd7jWNAOUE78QB9JmUMXc=;
        b=TxUFRji7ulzIgN511eWB4t31ixe39GNUqTBGQejLeH3/x2tpoKfTLsnDBBqYWQ1u35
         rZsS3TuGi1Iwe1ypDsti4RecaEl+A/NUNmrED6WTinYe+Zgd95izmtmATFS/oPG0X1VB
         TbsU+Wgofvmxe0der75ffUVSKXBKOleVSqahAFVBzoayEpBzk8QHIWGiMgp9zC27y1tJ
         Plf0hIpqhwd44fLf5/NOXmYBS2XRpZRHJBPCM94+J9xHT7lgkQBq+PBYkv8aTihsHupo
         U/GvTwA3VZ0Iw0SXplQCNapt2nCIcfEm24CssxWu5Qby+JF75D6dHwNUgoktGVkLkQZG
         HXGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/y0e45++PuFs7tex6E/LAyzHq8W70nzTVCaO2g+6Y1vAGv8KGQd4bE8+GV4DGPKednr+KXm9HXXjzm5QM@vger.kernel.org
X-Gm-Message-State: AOJu0YyEu+54TWhPOHj/68ng+Fx0Sr/NosxkRZsCtIx4VHDkN27Etl0J
	Fw2rMxa9OVveIYKAf8zpeomK/aqEDkgSowuQnRtwqnQ472xtb3afwYULCFYJOiDAvVA=
X-Gm-Gg: AZuq6aLfm1QnNsBjnwfWr09rB+18ZFdLjYdP0QQQp0B1yu4Ft6ohgC0GGrw9LXRHFHh
	pvVB+aH8ntQXvZysMb9fPsMmO4vAQLIoVoYdc3yudEPTr+Yatv/gq8P3CEo1G/Yf3MavajJwu0g
	wUZnDu3FXGtes6YS4PqmFBqkQFfBm6YzjYWrQXxm0fd4xzp2fKrjlI/OJi7rlJB+NzjntgpzXAw
	QDawJtsr5BskGwlgS+y7FH1/OEraGNIID0p/fCrpMr0L491rxAl7c7fEPmFF7E1eYsawz6kVyYx
	qkx5D4s/FLqZC8OcP5iVumoJbz7Z7f7nwzeCCD0LDkwsLXjGGXZE4SF+OaGJ+1KusRRaiit2A2X
	iky//1jfmiYFrnlwaTgWmMvgp2XkmLhSw1EMa5tmDlD1WjPd5XukjkheTykztR9iEnHBd/oOJv3
	aLxDIiTRtDGKru8kpo68Pq9y3EP9cyIjtLa0PcxNpd0PxGyuMyuqfNIZXuPEZb2/zNHEYlXdujW
	56zjHcXyTf/toSeAbj3Do4=
X-Received: by 2002:a05:690c:81:b0:787:e3c0:f61f with SMTP id 00721157ae682-7949e0758e5mr14525877b3.57.1769716531967;
        Thu, 29 Jan 2026 11:55:31 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:a4bf:cff0:217d:d01b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828aab8csm28228617b3.26.2026.01.29.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:55:31 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] hfsplus: fix warning issue in inode.c
Date: Thu, 29 Jan 2026 11:54:43 -0800
Message-Id: <20260129195442.594884-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75892-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,dubeyko-com.20230601.gappssmtp.com:dkim,dubeyko.com:mid,dubeyko.com:email]
X-Rspamd-Queue-Id: 46DE7B41BD
X-Rspamd-Action: no action

This patch fixes the sparse warning issue in inode.c
by adding static to hfsplus_symlink_inode_operations
and hfsplus_special_inode_operations declarations.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601291957.bunRsD8R-lkp@intel.com/
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 533c43cc3768..922ff41df042 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -396,14 +396,14 @@ static const struct inode_operations hfsplus_file_inode_operations = {
 	.fileattr_set	= hfsplus_fileattr_set,
 };
 
-const struct inode_operations hfsplus_symlink_inode_operations = {
+static const struct inode_operations hfsplus_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.setattr	= hfsplus_setattr,
 	.getattr	= hfsplus_getattr,
 	.listxattr	= hfsplus_listxattr,
 };
 
-const struct inode_operations hfsplus_special_inode_operations = {
+static const struct inode_operations hfsplus_special_inode_operations = {
 	.setattr	= hfsplus_setattr,
 	.getattr	= hfsplus_getattr,
 	.listxattr	= hfsplus_listxattr,
-- 
2.34.1


