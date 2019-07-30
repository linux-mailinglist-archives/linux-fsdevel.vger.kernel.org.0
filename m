Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB357B3C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfG3T7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:59:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfG3T7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:59:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N63mC-1iPTLI09aS-016Nh4; Tue, 30 Jul 2019 21:59:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v5 14/29] compat_ioctl: use correct compat_ptr() translation in drivers
Date:   Tue, 30 Jul 2019 21:55:30 +0200
Message-Id: <20190730195819.901457-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730195819.901457-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730195819.901457-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NR2XEl6+AoboPzHACO6k3v5xd19rmW+nghDi36gUHs44bTK8aTX
 j4qhcD2DWMgm3+w5BQbm37jRIwRUO1gaZlXowaZzD69dFljMBUlpDumVE2ajIdx5obcNlti
 nAmFEkrJj+t317mLhm+zRAyT+KpWBS/M4DUVEBLFC8zstuJ6l7ocOS0FIwjCL5iNxhFm2a0
 dHq1Q5oHD7ND7iQ6+MUZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u33HB7XxxV8=:vLsaGE+sfhIAM14qUsuw0R
 +928w3h7E05CCYPEkSRuA9fqKtOyNwXWQf+p7/tNW+MbXN+zfzd98K6FgXQvN7HqGZ7l/cJVO
 JYmjVrCW6JjQ/bx80HforgEaK0mOIZUzFIRQ/TLVMAuN9dc/NEsBmwm9QDG0DzXQnCBLQtHYq
 o2ceQvd0dOCKrFoZ6XOd4P6ZA990RYgAioOtooOQBwbdqfXPYn/RK1LVesjyEvXnQAV0mi890
 nnlbNvW9ICG1DfrcBajqCHDlwX1UBQgEvFc8zImPXkPoS2NbrmfLov5E4AmZaWkC6raNUXvhD
 Kch/xpLw8RD+2ZVqKo7BeKyiF8/8tmKxrr2RYsrh5pgp4cBhm+/R+s5lPcV64TL9GTmvidnc3
 9KqCKNPCCpOiKUTKKfUdQDXV/3wECFOqCit1j2UETF4UJtghNlWzy1ZMFHsbiiSDjW3mXOCwZ
 NNq4R6a1JUzd8PJh2Ome6hqH1Ri8lXo59BqX+eN0DCWqLsBYkw+FGwuBIlD5fswQCWfLHTk1C
 SQ+plLlsSxrF/0j5RX6k/mPhEP87QEn8+m1mKE3E4/Teza5RHj5j9g96VfE4KDvzbZvKy6hzt
 Tkd2BSD0TBYVSl98UGIIxZpxnyromDQzXVdEMCIcHKkgBapCnnYU45+eZsAr19gGMzOwuZVfB
 oeNJZp3eYYD5yY/Rd96ta1kQXMzAhg4JqRHvoGjEcmXwLbdm3zgEHwwTj6RQkuCsECNphdXNe
 AUXjEEHJwlCwYBkjK7uS+5IN7jXnZSNGBDs5vQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A handful of drivers all have a trivial wrapper around their ioctl
handler, but don't call the compat_ptr() conversion function at the
moment. In practice this does not matter, since none of them are used
on the s390 architecture and for all other architectures, compat_ptr()
does not do anything, but using the new compat_ptr_ioctl()
helper makes it more correct in theory, and simplifies the code.

I checked that all ioctl handlers in these files are compatible
and take either pointer arguments or no argument.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/cxl/flash.c            |  8 +-------
 drivers/misc/genwqe/card_dev.c      | 23 +----------------------
 drivers/scsi/megaraid/megaraid_mm.c | 28 +---------------------------
 drivers/usb/gadget/function/f_fs.c  | 12 +-----------
 4 files changed, 4 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 4d6836f19489..cb9cca35a226 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -473,12 +473,6 @@ static long device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EINVAL;
 }
 
-static long device_compat_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	return device_ioctl(file, cmd, arg);
-}
-
 static int device_close(struct inode *inode, struct file *file)
 {
 	struct cxl *adapter = file->private_data;
@@ -514,7 +508,7 @@ static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
 	.open		= device_open,
 	.unlocked_ioctl	= device_ioctl,
-	.compat_ioctl	= device_compat_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.release	= device_close,
 };
 
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 0e34c0568fed..040a0bda3125 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1215,34 +1215,13 @@ static long genwqe_ioctl(struct file *filp, unsigned int cmd,
 	return rc;
 }
 
-#if defined(CONFIG_COMPAT)
-/**
- * genwqe_compat_ioctl() - Compatibility ioctl
- *
- * Called whenever a 32-bit process running under a 64-bit kernel
- * performs an ioctl on /dev/genwqe<n>_card.
- *
- * @filp:        file pointer.
- * @cmd:         command.
- * @arg:         user argument.
- * Return:       zero on success or negative number on failure.
- */
-static long genwqe_compat_ioctl(struct file *filp, unsigned int cmd,
-				unsigned long arg)
-{
-	return genwqe_ioctl(filp, cmd, arg);
-}
-#endif /* defined(CONFIG_COMPAT) */
-
 static const struct file_operations genwqe_fops = {
 	.owner		= THIS_MODULE,
 	.open		= genwqe_open,
 	.fasync		= genwqe_fasync,
 	.mmap		= genwqe_mmap,
 	.unlocked_ioctl	= genwqe_ioctl,
-#if defined(CONFIG_COMPAT)
-	.compat_ioctl   = genwqe_compat_ioctl,
-#endif
+	.compat_ioctl   = compat_ptr_ioctl,
 	.release	= genwqe_release,
 };
 
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index 59cca898f088..e83163c66884 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -41,10 +41,6 @@ static int mraid_mm_setup_dma_pools(mraid_mmadp_t *);
 static void mraid_mm_free_adp_resources(mraid_mmadp_t *);
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);
 
-#ifdef CONFIG_COMPAT
-static long mraid_mm_compat_ioctl(struct file *, unsigned int, unsigned long);
-#endif
-
 MODULE_AUTHOR("LSI Logic Corporation");
 MODULE_DESCRIPTION("LSI Logic Management Module");
 MODULE_LICENSE("GPL");
@@ -68,9 +64,7 @@ static wait_queue_head_t wait_q;
 static const struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,
 	.unlocked_ioctl = mraid_mm_unlocked_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = mraid_mm_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 	.owner	= THIS_MODULE,
 	.llseek = noop_llseek,
 };
@@ -224,7 +218,6 @@ mraid_mm_unlocked_ioctl(struct file *filep, unsigned int cmd,
 {
 	int err;
 
-	/* inconsistent: mraid_mm_compat_ioctl doesn't take the BKL */
 	mutex_lock(&mraid_mm_mutex);
 	err = mraid_mm_ioctl(filep, cmd, arg);
 	mutex_unlock(&mraid_mm_mutex);
@@ -1228,25 +1221,6 @@ mraid_mm_init(void)
 }
 
 
-#ifdef CONFIG_COMPAT
-/**
- * mraid_mm_compat_ioctl	- 32bit to 64bit ioctl conversion routine
- * @filep	: file operations pointer (ignored)
- * @cmd		: ioctl command
- * @arg		: user ioctl packet
- */
-static long
-mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd,
-		      unsigned long arg)
-{
-	int err;
-
-	err = mraid_mm_ioctl(filep, cmd, arg);
-
-	return err;
-}
-#endif
-
 /**
  * mraid_mm_exit	- Module exit point
  */
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 213ff03c8a9f..7037ec33c424 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1351,14 +1351,6 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long ffs_epfile_compat_ioctl(struct file *file, unsigned code,
-		unsigned long value)
-{
-	return ffs_epfile_ioctl(file, code, value);
-}
-#endif
-
 static const struct file_operations ffs_epfile_operations = {
 	.llseek =	no_llseek,
 
@@ -1367,9 +1359,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.read_iter =	ffs_epfile_read_iter,
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = ffs_epfile_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 
-- 
2.20.0

