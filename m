Return-Path: <linux-fsdevel+bounces-48682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1CAB2809
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D5D3B724E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96E22DFB6;
	Sun, 11 May 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bbW2+qnr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A31D63C2;
	Sun, 11 May 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746963821; cv=none; b=JeV/43XuQX7+fDnMmc9RkfFCcewmPAXpCQQMgBCtIocrE2NlufzucPCzdhWM9fzMIT7+JoUi1sgCVpWPQshbgc1IaSol5MHz4qPt/tjxhrF5sQqpU0RXSbM5Hjdb0SSioyKos8fQVJunKksFhaOqd26gupF4k4G5kJqp/8wb96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746963821; c=relaxed/simple;
	bh=ZPvxAooEpfDoKQZzvszZnuoHXtjVGwgesqHCgjlgE4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChqE7blnhQ+NTMnBzg2E8qA5ZADMiVA5hLsYhppFFqUWi5J7nquldSeBs+20vLiVv3OzQOFEcnFBPovEiM6cKCzwrWJStVLLoj62monE2ApS1gbPrgZ2O7MpyC30vKeFaBMntnkjcp1XuGApRop5wP5k1Ch5+Gpctr7tf1ybxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bbW2+qnr; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746963810;
	bh=FoJvhhjjd/ZdkM/GndWXo3kordP5UEz6B23XMYFaBmk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bbW2+qnrEDINCSJulkgNTFQo2n1yDAYdGQ5V2Jas7uD5yE8llfnL1b6yucLqWg90z
	 2b/FvXI3WE+tmXcW671gKl9Sj31R4xsS6z92IxiviNjAkAruFp6l1+MZEI4PL1+2TU
	 2gukYodZ/DD7AQ8hHsYKKqbdf4aWSkVKUhJKwUh0=
X-QQ-mid: zesmtpip4t1746963797t33ba7a67
X-QQ-Originating-IP: kYfqd3Ijwqo5BKNFllcGhIDKYTXwOjy+//ib0K/u+GE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 11 May 2025 19:43:15 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15087200853929096546
EX-QQ-RecipientCnt: 19
From: WangYuli <wangyuli@uniontech.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: akpm@linux-foundation.org,
	tglx@linutronix.de,
	jlayton@kernel.org,
	frederic@kernel.org,
	chenlinxuan@uniontech.com,
	xu.xin16@zte.com.cn,
	adrian.ratiu@collabora.com,
	lorenzo.stoakes@oracle.com,
	mingo@kernel.org,
	felix.moessbauer@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] proc: Show the mountid associated with exe
Date: Sun, 11 May 2025 19:42:43 +0800
Message-ID: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NpNGBNXPqmmiTkbFis1y7jlXGfdgzRygfFNMDnoXA7fncTIHCm3dN5KQ
	EZIAK4ns/7w4uo1jtQTGDRP55z91RumknzpgyTgtJZsEU7Hnri/hX5BO4ULTUlLhLp6rabF
	DOoMSTwhAn2Ns97eLEYpWXSrbj8CCbsSUf7KxPKPzK+sWMBkMBAZh+syEgq0/ZHHieuVezB
	lgQSfqMXi2l7TznH1ao/CWpKRcJ3VwqbR7pkagq3t4uGlZYyCSMCCSjXf1356e3woOnZe6s
	OMXkqWqwopklVCBcL57PbqUPqUxqfnNn8V4fKYyQXH/pCA/A4O3BoWwYFTfckcJa1dNl4ba
	2+HITwZybM0RmNn/HBT9mBRs76y2J56X0gWa/JPkc5ws5ZYsHK38F82Yb7S5DZgdms6w+ix
	rDIbhDvf3VjkyyZ5Dmt+ZddCXA/MFtxCHCvbkId/NqXPyvuS1ImaqvfFYIuWinIm53fkf03
	LhT8EsRgDa58sFLGssx1sfhdRbBTZyyifSRjcMiTXKguhyhgkLry0lilsE3UEX6aqm4T3r8
	/3Vr/oYhgSc/og8bCWgcHafspi2pc9IwBXE0TWK/JNdy9yvjMe384j3E4PE+DsQU6ntmCOo
	jgBtRyV0xz46gHLkIKYGbjO7KD3t3k4GN/81HZt//6GJqR+vlyOk6ybiEgfNZYFTwfRGTk+
	ywa0LZBOxi8TWwLNRIhT2lXtXSTEHdnKhwPLVxNyWPp4Qrn4jsLsJHzqysYThDw5mNg15BX
	wV4jOn+RAU/inxhU/1J1dCvxtU9Alrzgt+T7jAZ+9N2RpG5TJiQLf62UX0C6vCziW4ykJIM
	T87KBkLMqLbSx3HWrsQcWJ7La34iZuqgtBwTAMVcW2pv8npvkoC0n8FOb4BkX4gtPqSE+nD
	XbViW0kvMWpzAKGtv0TuDw5Cn5TInv6WiHLiM9vZJI9qhRQ7PwxRuuovm2JFYdA/P87kaS1
	4IGiFFbgXy48Qjp37Af+aqhot3DFTx1ldpatNLcFkgVAwvbB6ZZKgDuvQ9JSZ6rClfBt2MA
	LNlgAGZTC2+a+dcr3gELyW2b0JC4SEgBEiup36sw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: Chen Linxuan <chenlinxuan@uniontech.com>

In Linux, an fd (file descriptor) is a non-negative integer
representing an open file or other I/O resource associated with a
process. These resources are located on file systems accessed via
mount points.

A mount ID (mnt_id) is a unique identifier for a specific instance
of a mounted file system within a mount namespace, essential for
understanding the file's context, especially in complex or
containerized environments. The executable (exe), pointed to by
/proc/<pid>/exe, is the process's binary file, which also resides
on a file system.

Knowing the mount ID for both file descriptors and the executable
is valuable for debugging and understanding a process's resource
origins.

We can easily obtain the mnt_id for an open fd by reading
/proc/<pid>/fdinfo/<fd}, where it's explicitly listed.

However, there isn't a direct interface (like a specific field in
/proc/<pid}/ status or a dedicated exeinfo file) to easily get the
mount ID of the executable file without performing additional path
resolution or file operations.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 fs/proc/base.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b0d4e1908b22..fe8a2d5b3bc1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -101,6 +101,7 @@
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
+#include "../mount.h"
 
 #include "../../lib/kstrtox.h"
 
@@ -1790,6 +1791,28 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 		return -ENOENT;
 }
 
+static int proc_exe_mntid(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task)
+{
+	struct file *exe_file;
+	struct path exe_path;
+
+	exe_file = get_task_exe_file(task);
+
+	if (exe_file) {
+		exe_path = exe_file->f_path;
+		path_get(&exe_file->f_path);
+
+		seq_printf(m, "%i\n", real_mount(exe_path.mnt)->mnt_id);
+
+		path_put(&exe_file->f_path);
+		fput(exe_file);
+
+		return 0;
+	} else
+		return -ENOENT;
+}
+
 static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct inode *inode,
 				     struct delayed_call *done)
@@ -3342,6 +3365,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	LNK("cwd",        proc_cwd_link),
 	LNK("root",       proc_root_link),
 	LNK("exe",        proc_exe_link),
+	ONE("exe_mntid",  S_IRUGO, proc_exe_mntid),
 	REG("mounts",     S_IRUGO, proc_mounts_operations),
 	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
 	REG("mountstats", S_IRUSR, proc_mountstats_operations),
-- 
2.49.0


