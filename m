Return-Path: <linux-fsdevel+bounces-49484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46CABCFCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 08:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DC3AB4B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BFA25CC7A;
	Tue, 20 May 2025 06:47:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054CE2566FD;
	Tue, 20 May 2025 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723642; cv=none; b=lmO4TuEkvVOB1fPewzl11baHrvpSyKtOfQe7X9XE+xrpK426MgCORQXw+9QIcvZ8qkyGV+o/J3CKUZPMFVK16HYB2uafcTDA/gmo80YglrlkrmogwlNdwfStY4kgUGIOmQpURB583T7mM/5EWaFLDB7nJrX29QE7synPWKW+oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723642; c=relaxed/simple;
	bh=fZkGjgB/UcgWxFUx/tS8ABoO9Kf/EdFNI8P4PGYnnbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1ZLRttNZFL9KbZDDFNFjre/DURAtg4iAeMohMcFFqyPSc8kUbT8fViBG2eNCaMv1JSOM/sZbIbYuCzadzk96/jD8vJ9RCBojxC+/kQGPaIOhP2vfaIuDcuY5vzgzcpDQOVNshMtjvdHYLa2S6GJ1jPzz3y2vv4Mb7YgIufDeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxyuBzJSxoMhLzAA--.76S3;
	Tue, 20 May 2025 14:47:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxzMRsJSxobs7iAA--.56897S2;
	Tue, 20 May 2025 14:47:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dcache: Define DNAME_INLINE_LEN as a number directly
Date: Tue, 20 May 2025 14:47:07 +0800
Message-ID: <20250520064707.31135-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzMRsJSxobs7iAA--.56897S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4kuF13ZF1xGw4xCry8JFc_yoW5Zw4UpF
	n0yw4DKrWfCw4jya4DZ34fury3urykJ3WrCa9Fq3y8tF98JF98WrW7t3WY9ryxJrWSqa1a
	yrWrAan8XF4DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

When executing the bcc script, there exists the following error
on LoongArch and x86_64:

Traceback (most recent call last):
  File "/usr/share/bcc/tools/filetop", line 218, in <module>
    counts = b.get_table("counts")
  File "/usr/lib/python3.13/site-packages/bcc-0.34.0+a434ee50-py3.13.egg/bcc/__init__.py", line 658, in get_table
    keytype = BPF._decode_table_type(json.loads(key_desc))
                                     ~~~~~~~~~~^^^^^^^^^^
  File "/usr/lib64/python3.13/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ~~~~~~~~~~~~~~~~~~~~~~~^^^
  File "/usr/lib64/python3.13/json/decoder.py", line 345, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.13/json/decoder.py", line 361, in raw_decode
    obj, end = self.scan_once(s, idx)
               ~~~~~~~~~~~~~~^^^^^^^^
json.decoder.JSONDecodeError: Expecting ',' delimiter: line 1 column 179 (char 178)

Here is the related definition in tools/filetop.py of bcc:

// the key for the output summary
struct info_t {
    unsigned long inode;
    dev_t dev;
    dev_t rdev;
    u32 pid;
    u32 name_len;
    char comm[TASK_COMM_LEN];
    // de->d_name.name may point to de->d_iname so limit len accordingly
    char name[DNAME_INLINE_LEN];
    char type;
};

Here is the output of print(key_desc) in src/python/bcc/__init__.py
of bcc, there is a missing ',' between "char" and "unsigned long" at
column 179 for the "name" member.

["info_t", [["inode","unsigned long"], ["dev","unsigned int"], ["rdev","unsigned int"], ["pid","unsigned int"], ["name_len","unsigned int"], ["comm","char", [16]], ["name","char""unsigned long", [40]], ["type","char"], ["__pad_end","char",[7]] ], "struct_packed"]

In order to avoid such issues, define DNAME_INLINE_LEN as a number
directly, there is only "char" and no "unsigned long" at column 179
for the "name" member with this patch.

["info_t", [["inode","unsigned long"], ["dev","unsigned int"], ["rdev","unsigned int"], ["pid","unsigned int"], ["name_len","unsigned int"], ["comm","char", [16]], ["name","char", [40]], ["type","char"], ["__pad_end","char",[7]] ], "struct_packed"]

How to reproduce:

git clone https://github.com/iovisor/bcc.git
mkdir bcc/build; cd bcc/build
cmake ..
make
sudo make install
sudo /usr/share/bcc/tools/filetop

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/dcache.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e9f07e37dd6f..08e91738e3de 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -70,15 +70,17 @@ extern const struct qstr dotdot_name;
  */
 #ifdef CONFIG_64BIT
 # define DNAME_INLINE_WORDS 5 /* 192 bytes */
+# define DNAME_INLINE_LEN 40
 #else
 # ifdef CONFIG_SMP
 #  define DNAME_INLINE_WORDS 9 /* 128 bytes */
+#  define DNAME_INLINE_LEN 36
 # else
 #  define DNAME_INLINE_WORDS 11 /* 128 bytes */
+#  define DNAME_INLINE_LEN 44
 # endif
 #endif
 
-#define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long))
 
 union shortname_store {
 	unsigned char string[DNAME_INLINE_LEN];
-- 
2.42.0


