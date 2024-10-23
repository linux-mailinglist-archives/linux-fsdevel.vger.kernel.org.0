Return-Path: <linux-fsdevel+bounces-32641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1A9ABE36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 07:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD3A1C22A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 05:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCBD14659D;
	Wed, 23 Oct 2024 05:59:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020B7482;
	Wed, 23 Oct 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663154; cv=none; b=a1+JoNsgclmaYv9E/+aQdeucVEYI9B2jR6wAv74CvyHoFJw5polnjNs47+aJIikh51L3VETl/ypWvTXf5Quq39/P9MxTGClrJ/0XTdXQHyxO3volJXuOn9wHQsTKGeJg6hZ6Uo+CQtTYwyQ1x3D8DC5q0z6V6xlHYNBIzfIf3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663154; c=relaxed/simple;
	bh=Xi5BGcHQLbGAp6H9NkT1WNHevJNkx+l8YFWJdHWZLzc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=YMRCAg9NGIshblOdQtKoDEZxs3DwOZFd/0Qb7rzCP+wFicbiL6xqG+G6LPELCZm4ZM8jfo6ZlyMDYL6r0e7pBq7f35hi1YgrdPQzKitdFvHCVPrSx1gvCz0Ozdlc1+UTLerSx+pPLwnyGj2PeE0qI+LbWc79fUZrXHkZBovi5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4XYJJl1K4Kz5B1Jw;
	Wed, 23 Oct 2024 13:59:03 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4XYJJX3snzz501bb;
	Wed, 23 Oct 2024 13:58:52 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 49N5wm1k079965;
	Wed, 23 Oct 2024 13:58:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 23 Oct 2024 13:58:50 +0800 (CST)
Date: Wed, 23 Oct 2024 13:58:50 +0800 (CST)
X-Zmail-TransId: 2afa6718909affffffff87c-afe8a
X-Mailer: Zmail v1.0
Message-ID: <20241023135850067m3w2R0UXESiVCYz_wdAoT@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <yang.yang29@zte.com.cn>, <yang.tao172@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <lu.zhongjun@zte.com.cn>, <chen.lin5@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBmczogZml4IGJ1ZyB0aGF0IGZwdXQoKSBtYXkgbm90IGhhdmUgZG9uZSB0byBjb21wbGV0ZSBpbgoKIGZsdXNoX2RlbGF5ZWRfZnB1dA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 49N5wm1k079965
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 671890A7.000/4XYJJl1K4Kz5B1Jw

From: shao mingyin <shao.mingyin@zte.com.cn>

We find a bug that the rcS file may not be executed, resulting in module 
and business not being loaded. When trying to execute rcS, the fput() 
related to rcS has not done to complete, so deny_write_access() returns 
ETXTBSY.

rcS is opened in do_populate_rootfs before executed.
After flush_delayed_fput() has done to complete, do_populate_rootfs 
assumes that all fput() related to do_populate_rootfs has done to complete.
However, flush_delayed_fput can only ensure that the fput() on current 
delayed_fput_list has done to complete, the fput() that has already been 
removed from delayed_fput_list in advance may not be completed. Attempting
to execute the file associated with this fput() now will result in ETXTBSY.
Most of the time, the fput() related to rcS has done to complete in 
do_populate_rootfs before executing rcS, but sometimes it's not.

do_populate_rootfs	delayed_fput_list	delayed_fput	execve
fput()			a
fput()			a->b
fput()			a->b->rcS
						__fput(a)
fput()			c
fput()			c->d
						__fput(b)
flush_delayed_fput
__fput(c)
__fput(d)
						__fput(b)
						__fput(b)	execve(rcS)

in execve(rcS), deny_write_access(rcS) returns ETXTBSY because __fput(rcS) 
has not done to complete.

This patch can guarantee all fput() related to do_populate_rootfs has done 
to complete, and ensure that rcS can be executed successfully.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Yang Tao <yang.tao172@zte.com.cn>
Cc: Xu Xin <xu.xin16@zte.com.cn>
---
 fs/file_table.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997..345e68caa4d7 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -462,6 +462,8 @@ static void ____fput(struct callback_head *work)
 	__fput(container_of(work, struct file, f_task_work));
 }

+static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
+
 /*
  * If kernel thread really needs to have the final fput() it has done
  * to complete, call this.  The only user right now is the boot - we
@@ -475,11 +477,10 @@ static void ____fput(struct callback_head *work)
 void flush_delayed_fput(void)
 {
 	delayed_fput(NULL);
+	flush_delayed_work(&delayed_fput_work);
 }
 EXPORT_SYMBOL_GPL(flush_delayed_fput);

-static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
-
 void fput(struct file *file)
 {
 	if (file_ref_put(&file->f_ref)) {
-- 
2.25.1

