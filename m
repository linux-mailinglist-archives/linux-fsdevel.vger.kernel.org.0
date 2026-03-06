Return-Path: <linux-fsdevel+bounces-79570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOUXKaUuqmkyMwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:32:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C14E21A40E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5538930254D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D857318EDF;
	Fri,  6 Mar 2026 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Eyaq+uSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0A2F4A16;
	Fri,  6 Mar 2026 01:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760731; cv=none; b=VQ6YEFnrhuAQxdx0g5Gq/f/w4DbqHRSdpBJq9F27KPAhZJJSkDr0bZD1JOGbC5ssG9YH9QuR2xUMCv0NM2C9z5jkV3MKcZKDkuXsOtnA5k5uWCWDsviqRAtobGO+/QlUQY8bKT/RLI5RTBUh9OPun5CYiNDO4BWIb5vLuhZVWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760731; c=relaxed/simple;
	bh=/vL+7x1vRUY4YrQcTVBklhT4wck9ypOKsyNWWLgwWhY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oU4Cod+D13Q2ohkA02ZU1JhJrdf7ry2gVtjJ+cyLMybONKGJwpGE53ROFhCxK2C7ugYAUeVLSKyxk1xghiqcCxp5pLE8YtLelUAnDUAenvCHLGIYfzUbyoP675ab/QejKUIQ+L4f8YTklpM+LZgGxtOOSSu5S0xwCzk6CIioRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Eyaq+uSL; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772760721; bh=bFAnYbExLf/ve1uEheDPaRO59WfrrSOmgvv5TG9t77k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eyaq+uSLQWzWuhOGg9aFfchUlMWJZzwNgyRVhEKhL32+nfcwnXUcN2Pm7nKd0I2AC
	 efghJ2OU83E1QuckaymoUcQzUh8g8fTUr2ysv8Cw+DF3wi1KtPrkV+zJI4KPJ08+3o
	 2AhIlUV9r17RvZxXUFBMTaUj8e9nz+qm5Q9+IR64=
Received: from lxu-ped-host.. ([111.201.4.63])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 7F98B891; Fri, 06 Mar 2026 09:31:57 +0800
X-QQ-mid: xmsmtpt1772760717tx01idgac
Message-ID: <tencent_43696283A68450B761D76866C6F360E36705@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoety4pU97mgLQw7vMgtRIkyvdyE5Wf8ZHAX7pQW+a7v3zYk669gE
	 s9+Gs7Mqajh+Ex98OR13bEJEiEggTjmOU88mk3B4c3FjGocsNVutlmco9sBuLnj6IyT07invfoBp
	 uJ/9B6MpfncR/exdC8jrgX7BF/2UCcxs825wfT8+nrYG0WNisTn4cLtqbl/XPrljm0Dhbb4W2fyN
	 XV5uKdr9fbyc7C4xAw6EFHGJIxiJPtT9waJ02Zd4ZUyP7NqI5Agy5GprT2IzfPOhjw0jSASpb+Tv
	 aVMWh5yHzOVWhKy17D+7U0G58WCBf19+/s3F8WOOyaH+jns8Q93UzC5iGxYrn2KGz5QiwEtE/0hd
	 LiKvqcVqeKSRyMbNuBdIXVAfEdTq9enrpb6S1zMyOV2eQbw3tTMxhKEMUgvoH9hNrIf8TcuEhq+z
	 UsPcBs1KsURLdMK7W8hV+yH5e92W5sj5sX5AF6F3rno15OfV1hsZ7rlxAmrV2vd1cIa1q3cMOhru
	 Y1LOvAOFoFqCkUqomrCQMJUcth4ZWjTolcEFrUMfAD2iJzE3UYKIt92UgA/BO+6OjxBL8LZT7lBd
	 7HbpF9vPrTLTh8xEp+PNRYL+HhqtXA0olM/UTP13j8w4cipg4VnI3CMNMxyWHQRUopp7XWtg6YYs
	 2v06UDAcZlKTK7Bw8EldHWIIae9e/AVo6VDdQSHrH79lj6ip5ehISGsDkFocpPpGaAuCr1t2USoe
	 5h92BPEL5466yOh1Sl4b5VIV+T4EvczD6qCXSxC8q0K5+GzktN1U/o6GQcOfyEqPK8rrNPCbRH4+
	 7w2R33s4qOUIZl486ECtMYxVJYcmbF3vSs+oo4scu67HxiHovttjCQigx8nn4L8wnCaM+Qj0UKIJ
	 ngrwWD3bHyI7MJMpRFuAjWA3Ck5a3qSIG48A2xKqTOLD5kbR3j5hjRsMPsNjLoE7qjw0qoJyzBlV
	 Dj8Q+S9/dXc4NoONCpb6ZAgAU7QESEZZRnwbzilMK+rYBDtF+VxBAWOpN8xBLpdm6ukrBFLIpg2z
	 dX2lKyPYlWaokh3za+GxQWtA3ycjicAl/O+B4+Lg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Edward Adam Davis <eadavis@qq.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	eadavis@qq.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v5] ext4: avoid infinite loops caused by residual data
Date: Fri,  6 Mar 2026 09:31:58 +0800
X-OQ-MSGID: <20260306013157.440502-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <agn2b2tn4h3whokr262gca5s6eoautng2u2vt6535w7myuyk6x@6kgv6h7pco5g>
References: <agn2b2tn4h3whokr262gca5s6eoautng2u2vt6535w7myuyk6x@6kgv6h7pco5g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C14E21A40E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79570-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,qq.com,vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Action: no action

On the mkdir/mknod path, when mapping logical blocks to physical blocks,
if inserting a new extent into the extent tree fails (in this example,
because the file system disabled the huge file feature when marking the
inode as dirty), ext4_ext_map_blocks() only calls ext4_free_blocks() to
reclaim the physical block without deleting the corresponding data in
the extent tree. This causes subsequent mkdir operations to reference
the previously reclaimed physical block number again, even though this
physical block is already being used by the xattr block. Therefore, a
situation arises where both the directory and xattr are using the same
buffer head block in memory simultaneously.

The above causes ext4_xattr_block_set() to enter an infinite loop about
"inserted" and cannot release the inode lock, ultimately leading to the
143s blocking problem mentioned in [1].

If the metadata is corrupted, then trying to remove some extent space
can do even more harm. Also in case EXT4_GET_BLOCKS_DELALLOC_RESERVE
was passed, remove space wrongly update quota information.
Jan Kara suggests distinguishing between two cases:

1) The error is ENOSPC or EDQUOT - in this case the filesystem is fully
consistent and we must maintain its consistency including all the
accounting. However these errors can happen only early before we've
inserted the extent into the extent tree. So current code works correctly
for this case.

2) Some other error - this means metadata is corrupted. We should strive to
do as few modifications as possible to limit damage. So I'd just skip
freeing of allocated blocks.

[1]
INFO: task syz.0.17:5995 blocked for more than 143 seconds.
Call Trace:
 inode_lock_nested include/linux/fs.h:1073 [inline]
 __start_dirop fs/namei.c:2923 [inline]
 start_dirop fs/namei.c:2934 [inline]

Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: fix ci reported issues
v2 -> v3: new fix for removing residual data and update subject and coments
v3 -> v4: filtering already allocated blocks and update comments
v4 -> v5: don't touch corrupted data and update comments

 fs/ext4/extents.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ae3804f36535..4779da94f816 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4457,9 +4457,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
-		if (allocated_clusters) {
+		/*
+		 * Gracefully handle out of space conditions. If the filesystem
+		 * is inconsistent, we'll just leak allocated blocks to avoid
+		 * causing even more damage.
+		 */
+		if (allocated_clusters && (err == -EDQUOT || err == -ENOSPC)) {
 			int fb_flags = 0;
-
 			/*
 			 * free data blocks we just allocated.
 			 * not a good idea to call discard here directly,
-- 
2.43.0


