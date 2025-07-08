Return-Path: <linux-fsdevel+bounces-54212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4978AFC115
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 04:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AFC16CD1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE0226D17;
	Tue,  8 Jul 2025 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k+tTCpDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF520F067
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943460; cv=none; b=KNBKHnY09TS4p1r+uM29QQjWmy7D0vIgAKd1A7yLrBVdDk8xlvrRe2G9f2ka18idJMWlynsEnxFb0HZAkXw1HJjKtJrgtKYMjxbpMNtNMi9qNq/cUIAOXXHx/EBfo+tP7blV66+fiBKJHx0Xhu91bt4pG9W54IFD2izKyZhxyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943460; c=relaxed/simple;
	bh=PnjnN+k3e3K1wsuURKENo3vWF8eD6Xl60kbH652iqdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX382uBt1i02bcns55z7FQFFeVtLcuqKZ4TJTejo1KRfoFSERpsyurIUT5F+W70q/4hQlna38Gqn0ui8n2eSpciPjaCfolzk4wOoqYWLC8Z8Cdsv0RPXvWr+X9JbOijwaS6VQGUHphUpbP+08DuZcBjcl1iaIgXy7tB/YA9ZmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k+tTCpDb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=zxbtgzgtR+Cwj6Zevp99InqAAqjQTHcxcxEam4YNztY=; b=k+tTCpDbSZMDo5tzcjxDOLdhYy
	K5FI8AgDzeqkOT8VrNgmCxzCs7KRM/vdagHI1AtgvaO59HmVQZryP97qu9uKM9/WY5MczFdGI0LPW
	WCmoCAi1Rp/7xovvAa48NE8vPN3lt5BzTljALAxZP75ydFrOyTW73imM6aH3bOSWJWFrZMFswMAnE
	WIWe5VkSia6xu83135vyJxsxj/UAyuLATtzFSx5/J9FL7mOY41WmW4BKEwGHUsgBRsXgMKI/eVwH8
	n3rjnj96+Na5FRpHWKYH/5VHJthdM2D3+VcyjhRuEtCTXJO4rJMsKaYEgteaZcG8tW73ET9/r1LJU
	c/hN/ywg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyWU-00000005vwE-2IVu;
	Tue, 08 Jul 2025 02:57:34 +0000
Date: Tue, 8 Jul 2025 03:57:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
Message-ID: <20250708025734.GT1880847@ZenIV>
References: <20250702212917.GK3406663@ZenIV>
 <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
 <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
 <20250704042504.GQ1880847@ZenIV>
 <CABPRKS89iGUC5nih40yc9uRMkkfjZUafAN59WQBzpGC3vK_MkQ@mail.gmail.com>
 <20250704201027.GS1880847@ZenIV>
 <CABPRKS_hSYbJHid=GJo4r9RGUjNWMYA04CwM+M=yPHY5kQXUTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPRKS_hSYbJHid=GJo4r9RGUjNWMYA04CwM+M=yPHY5kQXUTw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 12:29:55PM -0700, Justin Tee wrote:
> > is OK only if all updates of that thing are externally serialized.
> > If they are, we don't need atomic; if they are not, this separation
> > of decrement and test is racy.
> Agreed with this too.  Vport creation and deletion is serialized, so
> we do not need to declare debugfs_vport_count as atomic.
> 
> At this point, cleaning up the lpfc_debugfs_terminate routine may be a
> little more involved.  If it’s alright with you, Broadcom will take up
> the responsibility to clean up the lpfc_debugfs_terminate routine
> during our next driver version update, and we will of course state
> your authorship in that particular clean up patch.
> 
> Regarding this thread’s enum selector patch, I can provide the signed
> off by after we see that the enum declaration is moved to
> lpfc_debugfs.h.

Would this do?

[PATCH v2] lpfc: don't use file->f_path.dentry for comparisons
    
If you want a home-grown switch, at least use enum for selector...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 3fd1aa5cc78c..42d138ec11b4 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2375,32 +2375,32 @@ static ssize_t
 lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
 	size_t nbytes, loff_t *ppos)
 {
-	struct dentry *dent = file->f_path.dentry;
 	struct lpfc_hba *phba = file->private_data;
+	int kind = debugfs_get_aux_num(file);
 	char cbuf[32];
 	uint64_t tmp = 0;
 	int cnt = 0;
 
-	if (dent == phba->debug_writeGuard)
+	if (kind == writeGuard)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
-	else if (dent == phba->debug_writeApp)
+	else if (kind == writeApp)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
-	else if (dent == phba->debug_writeRef)
+	else if (kind == writeRef)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wref_cnt);
-	else if (dent == phba->debug_readGuard)
+	else if (kind == readGuard)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rgrd_cnt);
-	else if (dent == phba->debug_readApp)
+	else if (kind == readApp)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rapp_cnt);
-	else if (dent == phba->debug_readRef)
+	else if (kind == readRef)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rref_cnt);
-	else if (dent == phba->debug_InjErrNPortID)
+	else if (kind == InjErrNPortID)
 		cnt = scnprintf(cbuf, 32, "0x%06x\n",
 				phba->lpfc_injerr_nportid);
-	else if (dent == phba->debug_InjErrWWPN) {
+	else if (kind == InjErrWWPN) {
 		memcpy(&tmp, &phba->lpfc_injerr_wwpn, sizeof(struct lpfc_name));
 		tmp = cpu_to_be64(tmp);
 		cnt = scnprintf(cbuf, 32, "0x%016llx\n", tmp);
-	} else if (dent == phba->debug_InjErrLBA) {
+	} else if (kind == InjErrLBA) {
 		if (phba->lpfc_injerr_lba == (sector_t)(-1))
 			cnt = scnprintf(cbuf, 32, "off\n");
 		else
@@ -2417,8 +2417,8 @@ static ssize_t
 lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	size_t nbytes, loff_t *ppos)
 {
-	struct dentry *dent = file->f_path.dentry;
 	struct lpfc_hba *phba = file->private_data;
+	int kind = debugfs_get_aux_num(file);
 	char dstbuf[33];
 	uint64_t tmp = 0;
 	int size;
@@ -2428,7 +2428,7 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	if (copy_from_user(dstbuf, buf, size))
 		return -EFAULT;
 
-	if (dent == phba->debug_InjErrLBA) {
+	if (kind == InjErrLBA) {
 		if ((dstbuf[0] == 'o') && (dstbuf[1] == 'f') &&
 		    (dstbuf[2] == 'f'))
 			tmp = (uint64_t)(-1);
@@ -2437,23 +2437,23 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	if ((tmp == 0) && (kstrtoull(dstbuf, 0, &tmp)))
 		return -EINVAL;
 
-	if (dent == phba->debug_writeGuard)
+	if (kind == writeGuard)
 		phba->lpfc_injerr_wgrd_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_writeApp)
+	else if (kind == writeApp)
 		phba->lpfc_injerr_wapp_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_writeRef)
+	else if (kind == writeRef)
 		phba->lpfc_injerr_wref_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readGuard)
+	else if (kind == readGuard)
 		phba->lpfc_injerr_rgrd_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readApp)
+	else if (kind == readApp)
 		phba->lpfc_injerr_rapp_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readRef)
+	else if (kind == readRef)
 		phba->lpfc_injerr_rref_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_InjErrLBA)
+	else if (kind == InjErrLBA)
 		phba->lpfc_injerr_lba = (sector_t)tmp;
-	else if (dent == phba->debug_InjErrNPortID)
+	else if (kind == InjErrNPortID)
 		phba->lpfc_injerr_nportid = (uint32_t)(tmp & Mask_DID);
-	else if (dent == phba->debug_InjErrWWPN) {
+	else if (kind == InjErrWWPN) {
 		tmp = cpu_to_be64(tmp);
 		memcpy(&phba->lpfc_injerr_wwpn, &tmp, sizeof(struct lpfc_name));
 	} else
@@ -6160,60 +6160,51 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			phba->debug_dumpHostSlim = NULL;
 
 		/* Setup DIF Error Injections */
-		snprintf(name, sizeof(name), "InjErrLBA");
 		phba->debug_InjErrLBA =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("InjErrLBA", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, InjErrLBA, &lpfc_debugfs_op_dif_err);
 		phba->lpfc_injerr_lba = LPFC_INJERR_LBA_OFF;
 
-		snprintf(name, sizeof(name), "InjErrNPortID");
 		phba->debug_InjErrNPortID =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("InjErrNPortID", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, InjErrNPortID, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "InjErrWWPN");
 		phba->debug_InjErrWWPN =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("InjErrWWPN", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, InjErrWWPN, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "writeGuardInjErr");
 		phba->debug_writeGuard =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("writeGuardInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, writeGuard, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "writeAppInjErr");
 		phba->debug_writeApp =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("writeAppInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, writeApp, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "writeRefInjErr");
 		phba->debug_writeRef =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("writeRefInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, writeRef, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "readGuardInjErr");
 		phba->debug_readGuard =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("readGuardInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, readGuard, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "readAppInjErr");
 		phba->debug_readApp =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("readAppInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, readApp, &lpfc_debugfs_op_dif_err);
 
-		snprintf(name, sizeof(name), "readRefInjErr");
 		phba->debug_readRef =
-			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
+			debugfs_create_file_aux_num("readRefInjErr", 0644,
 			phba->hba_debugfs_root,
-			phba, &lpfc_debugfs_op_dif_err);
+			phba, readRef, &lpfc_debugfs_op_dif_err);
 
 		/* Setup slow ring trace */
 		if (lpfc_debugfs_max_slow_ring_trc) {
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.h b/drivers/scsi/lpfc/lpfc_debugfs.h
index 8d2e8d05bbc0..f319f3af0400 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.h
+++ b/drivers/scsi/lpfc/lpfc_debugfs.h
@@ -322,6 +322,17 @@ enum {
 						 * discovery */
 #endif /* H_LPFC_DEBUG_FS */
 
+enum {
+	writeGuard = 1,
+	writeApp,
+	writeRef,
+	readGuard,
+	readApp,
+	readRef,
+	InjErrLBA,
+	InjErrNPortID,
+	InjErrWWPN,
+};
 
 /*
  * Driver debug utility routines outside of debugfs. The debug utility

