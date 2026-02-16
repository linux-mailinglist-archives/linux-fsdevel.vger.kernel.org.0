Return-Path: <linux-fsdevel+bounces-77262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJciF5KrkmlPwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:30:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C30140FEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD42301904C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229132DECC6;
	Mon, 16 Feb 2026 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OsPAOT7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44C2DC34E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219825; cv=none; b=OvXx6j8QKWHZJ8s8Ui8SjvgSnNLA8qDXMnyrcbNWh6mnWT6xV37HCaMggB21IkSXqRNShtKTKmZyhG7CJjijwkq8httyvFMiGaCoH3ASCgOza7NSPOw3wO0jwvkQHasv81M753Yz1UZ5n7Xkix0XrvSlZUdiJeEtm06CLGEhEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219825; c=relaxed/simple;
	bh=yaoZiGJRmleaAjBrHr4rDHz3K5lfm9ffTY7X/vd931s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GqIbcTmYRsLNtlCO/xF4tNhkSfc/w6lRcH1BqoMa3Xb9vymC8Bdvm/h2VFZTgS5o96s26K51ClQk9VIUJGqY0VZBLDtuyqsd5L2B0fI6685kTYauxfXXe7LJzAjrPbry9UPgIJ0I4D//oM8PYWFDV/d3YgclfBzGxeOMECx/uLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OsPAOT7V; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260216053022epoutp03e97e563f5463b5a5517e30785e4fc715~UowtDqtJw0328103281epoutp03M
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260216053022epoutp03e97e563f5463b5a5517e30785e4fc715~UowtDqtJw0328103281epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771219822;
	bh=8sAfC/3dKyrER4IA8GN6LBaI6vkbRHIWXiD/pNQH4nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsPAOT7VkvwemCeRyhClSOaCpaqJLe1bCCtAb2g7s5TYHjaB7lCjR8t1WBexxfZKD
	 mF/7AXdPB0uJ7iJBxYlTliJ1GsP5g7kjlZRTyG3inm1ft/n9B4NTd3tIp8L9p+KsuD
	 zNzQojkrL1reO+xjnd+NZBtM3JhbAxzN0vKTRzsw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260216053021epcas5p2b0f20b9ef3a822795dbc3b008bfbecdd~UowslZwI50350003500epcas5p2o;
	Mon, 16 Feb 2026 05:30:21 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fDrvd06ckz6B9m8; Mon, 16 Feb
	2026 05:30:21 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260216053020epcas5p44f066f0118b0293a2f8394c2ce1527bb~UowrTMtTu1994719947epcas5p4_;
	Mon, 16 Feb 2026 05:30:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260216053018epsmtip1de0be74bc0c71ea398e42ded5ef8088e~Uowp2Hnym1602916029epsmtip1I;
	Mon, 16 Feb 2026 05:30:18 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, brauner@kernel.org, jack@suse.cz, djwong@kernel.org,
	axboe@kernel.dk, kbusch@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 2/4] fcntl: expose write-stream management to userspace
Date: Mon, 16 Feb 2026 10:55:38 +0530
Message-Id: <20260216052540.217920-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260216052540.217920-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260216053020epcas5p44f066f0118b0293a2f8394c2ce1527bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260216053020epcas5p44f066f0118b0293a2f8394c2ce1527bb
References: <20260216052540.217920-1-joshi.k@samsung.com>
	<CGME20260216053020epcas5p44f066f0118b0293a2f8394c2ce1527bb@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77262-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim,samsung.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D8C30140FEB
X-Rspamd-Action: no action

Wire up the userspace interface for write stream management via three
new fcntls.
F_GET_MAX_WRITE_STREAMS: Returns the number of available streams.
F_SET_WRITE_STREAM: Assign a specific stream value to the file.
F_GET_WRITE_STREAM: Query what stream value is set on the file.

Application should query the available streams by calling
F_GET_MAX_WRITE_STREAMS first.
If returned value is N, valid stream values for the file are 0 to N.
Stream value 0 implies that no stream is set on the file.
Setting a larger value than available streams is rejected.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/fcntl.c                 | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/fcntl.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f93dbca08435..c982f0506a3f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -441,6 +441,30 @@ static int f_owner_sig(struct file *filp, int signum, bool setsig)
 	return ret;
 }
 
+static long fcntl_get_max_write_streams(struct file *filp)
+{
+	if (filp->f_op->get_max_write_streams)
+		return filp->f_op->get_max_write_streams(filp);
+
+	return -EOPNOTSUPP;
+}
+
+static long fcntl_set_write_stream(struct file *filp, unsigned long arg)
+{
+	if (filp->f_op->set_write_stream)
+		return filp->f_op->set_write_stream(filp, arg);
+
+	return -EOPNOTSUPP;
+}
+
+static long fcntl_get_write_stream(struct file *filp)
+{
+	if (filp->f_op->get_write_stream)
+		return filp->f_op->get_write_stream(filp);
+
+	return -EOPNOTSUPP;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -563,6 +587,15 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 			return -EFAULT;
 		err = fcntl_setdeleg(fd, filp, &deleg);
 		break;
+	case F_GET_MAX_WRITE_STREAMS:
+		err = fcntl_get_max_write_streams(filp);
+		break;
+	case F_SET_WRITE_STREAM:
+		err = fcntl_set_write_stream(filp, arg);
+		break;
+	case F_GET_WRITE_STREAM:
+		err = fcntl_get_write_stream(filp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index aadfbf6e0cb3..4b75470fc07a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -190,4 +190,8 @@ struct delegation {
 #define AT_EXECVE_CHECK		0x10000	/* Only perform a check if execution
 					   would be allowed. */
 
+/* write stream management */
+#define F_GET_MAX_WRITE_STREAMS		(F_LINUX_SPECIFIC_BASE + 17)
+#define F_GET_WRITE_STREAM		(F_LINUX_SPECIFIC_BASE + 18)
+#define F_SET_WRITE_STREAM		(F_LINUX_SPECIFIC_BASE + 19)
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.25.1


