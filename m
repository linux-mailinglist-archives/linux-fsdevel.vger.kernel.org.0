Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE6490827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiAQMFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbiAQMFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:05:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECEC06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 04:05:41 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso29914250pjm.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XijcxB+wrJg3ZDH3E17cd83OGIYlUVleo3c/t8keBF4=;
        b=pvS1drTgYlxOHbq1NlOx3QYGVPt5JWFMIddUJJ3ULXO8iydp+S1FK/u73Uc52T5Hza
         Jet7UL2E0vB4JqpLN4YrAp5+a0zORYw8nv14kOAb1nwFybzcfL4TxREa6CrM0st7zrZH
         tH5NrijSlZNo/STm+4WRmJBBK/l8TLztaqpW8cNqu9kvg5mf9Y3z8qBd/GT2f1ihhUFx
         31gF8JaaIpGC6xpZMcdgtCVmgjDuOKpLQmAJVte3ad0Vigb7YT8pCtT9dqnhNsHWDSTf
         0IIdww93Q1FirqQTpbuQ+qiIRlMhpFQ3uJaAk9oXBgUN08iTyQ3uFl/5Vxdo1aFw48cW
         h5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XijcxB+wrJg3ZDH3E17cd83OGIYlUVleo3c/t8keBF4=;
        b=ROXg9JDPhZ2eK+umkfelOJYRzSoVArGOSaK5bQpP1+V+FiN99VDEZQiSKIXRdTzQxA
         8SMHLcgCZ01rPavWhxhpyLgowpL2IKugRzX5Rsx2+sjzlk4vtuRBpOtmKR3sy2RClQ1v
         QofC/VvUcYgvpsxXp3kgZq+2tMmifZQsYHpBX9PT+665PlEMYwogHEuOemavBuZD/mjK
         w3CglfbKbjVzJcg3kVl8GWFhyrK5syRzz+Er0mq0Kg1T1kVZkHfP97Yn3dXWovflfgcm
         g3vbCbICVzr71XRhK//tFFQRxBLxwaNrndv0nm0Iuc4PewG2nAE6BFU/m3RXdyop1odZ
         ruhw==
X-Gm-Message-State: AOAM532clFZTIVmgZ3RFcRyRRMvmcMreq06QSDqnrQrxw+e2rtFwgEEp
        RR8xMTEhf8XM818tOCJMDa/2i9Itl0gCRA==
X-Google-Smtp-Source: ABdhPJwrUuk78lZNrfiG770Yo5MOGfnn4jr2+NM30ZcoP+0dpl0xE1BMEcu7vMn7DjaKPNOh+nnbAg==
X-Received: by 2002:a17:902:f545:b0:14a:725f:74a5 with SMTP id h5-20020a170902f54500b0014a725f74a5mr22194104plf.2.1642421141062;
        Mon, 17 Jan 2022 04:05:41 -0800 (PST)
Received: from localhost.localdomain ([39.121.10.168])
        by smtp.gmail.com with ESMTPSA id j11sm13455885pfn.199.2022.01.17.04.05.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 04:05:40 -0800 (PST)
From:   ByeongGyu Jeon <ntnegm@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     ByeongGyu Jeon <ntnegm@gmail.com>
Subject: [PATCH] fs: read_write: fix coding style error
Date:   Mon, 17 Jan 2022 21:05:28 +0900
Message-Id: <20220117120528.2346-1-ntnegm@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Antivirus: Avast (VPS 220117-2, 2022-1-17), Outbound message
X-Antivirus-Status: Clean
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixed coding style errors of fs/read_write.c

Signed-off-by: ByeongGyu Jeon <ntnegm@gmail.com>
---
 fs/read_write.c | 74 ++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0074afa7ecb3..160e3c7da473 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -240,39 +240,39 @@ loff_t default_llseek(struct file *file, loff_t offse=
t, int whence)
 
 	inode_lock(inode);
 	switch (whence) {
-		case SEEK_END:
-			offset +=3D i_size_read(inode);
-			break;
-		case SEEK_CUR:
-			if (offset =3D=3D 0) {
-				retval =3D file->f_pos;
-				goto out;
-			}
-			offset +=3D file->f_pos;
-			break;
-		case SEEK_DATA:
-			/*
-			 * In the generic case the entire file is data, so as
-			 * long as offset isn't at the end of the file then the
-			 * offset is data.
-			 */
-			if (offset >=3D inode->i_size) {
-				retval =3D -ENXIO;
-				goto out;
-			}
-			break;
-		case SEEK_HOLE:
-			/*
-			 * There is a virtual hole at the end of the file, so
-			 * as long as offset isn't i_size or larger, return
-			 * i_size.
-			 */
-			if (offset >=3D inode->i_size) {
-				retval =3D -ENXIO;
-				goto out;
-			}
-			offset =3D inode->i_size;
-			break;
+	case SEEK_END:
+		offset +=3D i_size_read(inode);
+		break;
+	case SEEK_CUR:
+		if (offset =3D=3D 0) {
+			retval =3D file->f_pos;
+			goto out;
+		}
+		offset +=3D file->f_pos;
+		break;
+	case SEEK_DATA:
+		/*
+		 * In the generic case the entire file is data, so as
+		 * long as offset isn't at the end of the file then the
+		 * offset is data.
+		 */
+		if (offset >=3D inode->i_size) {
+			retval =3D -ENXIO;
+			goto out;
+		}
+		break;
+	case SEEK_HOLE:
+		/*
+		 * There is a virtual hole at the end of the file, so
+		 * as long as offset isn't i_size or larger, return
+		 * i_size.
+		 */
+		if (offset >=3D inode->i_size) {
+			retval =3D -ENXIO;
+			goto out;
+		}
+		offset =3D inode->i_size;
+		break;
 	}
 	retval =3D -EINVAL;
 	if (offset >=3D 0 || unsigned_offsets(file)) {
@@ -693,7 +693,7 @@ ssize_t ksys_pwrite64(unsigned int fd, const char __use=
r *buf,
 	f =3D fdget(fd);
 	if (f.file) {
 		ret =3D -ESPIPE;
-		if (f.file->f_mode & FMODE_PWRITE)  
+		if (f.file->f_mode & FMODE_PWRITE)
 			ret =3D vfs_write(f.file, buf, count, &pos);
 		fdput(f);
 	}
@@ -1137,7 +1137,7 @@ COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
 #endif
 
 COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
-		const struct iovec __user *,vec,
+		const struct iovec __user *, vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
 	loff_t pos =3D ((loff_t)pos_high << 32) | pos_low;
@@ -1157,7 +1157,7 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd=
,
 #endif
 
 COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
-		const struct iovec __user *,vec,
+		const struct iovec __user *, vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high, rwf_t, flags)
 {
 	loff_t pos =3D ((loff_t)pos_high << 32) | pos_low;
@@ -1169,7 +1169,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 #endif /* CONFIG_COMPAT */
 
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
-		  	   size_t count, loff_t max)
+		size_t count, loff_t max)
 {
 	struct fd in, out;
 	struct inode *in_inode, *out_inode;
-- 
2.17.1


-- 
=EC=9D=B4 =EC=9D=B4=EB=A9=94=EC=9D=BC=EC=9D=80 Avast =EC=95=88=ED=8B=B0=EB=
=B0=94=EC=9D=B4=EB=9F=AC=EC=8A=A4 =EC=86=8C=ED=94=84=ED=8A=B8=EC=9B=A8=EC=
=96=B4=EB=A1=9C =EB=B0=94=EC=9D=B4=EB=9F=AC=EC=8A=A4 =EA=B2=80=EC=82=AC=EB=
=A5=BC =EC=99=84=EB=A3=8C=ED=96=88=EC=8A=B5=EB=8B=88=EB=8B=A4.
https://www.avast.com/antivirus

