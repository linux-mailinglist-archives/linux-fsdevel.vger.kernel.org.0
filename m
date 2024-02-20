Return-Path: <linux-fsdevel+bounces-12151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C085B94E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 11:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5DB24541
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4763CAC;
	Tue, 20 Feb 2024 10:41:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF83612C4;
	Tue, 20 Feb 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425672; cv=none; b=r9fE63IxaRc/5qL1k3zIPybhd/A0SjJoTBD/LfJLrktDaypHU+kcU+WHanMDF54cSzLZBRHNUmtaJ6WDun5XNwpe12kSpI5bLjsGkawsppIJJFEMOwbhYLKPOuq/uP3vZSnGAROfaHm5jGA7/F1MpjEmPMahWOf7FOwvKnXl+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425672; c=relaxed/simple;
	bh=iiXKTzv5geTec4zJYDsv24Swhq/K+PLTeHsix1h/wBg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ytdr/pBBuk9/L0Vy2AXAj5oIvMkDIbuzY8dRej52yNIe3UllPV82H+SCYqtTA/w564s+c7vgg2oR9Ez3qTRBEwHtCHRBCPMR/WMaXktGM9vhSNX0MUtcs7flkbqc+08kLlraRNVa/KM/63N8my2MHqXTlNxjsSimHZ5Wub2QJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TfFsr1hjpz9xyNP;
	Tue, 20 Feb 2024 18:25:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B355914059C;
	Tue, 20 Feb 2024 18:40:59 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD36hOvgdRl1QDeAg--.11661S2;
	Tue, 20 Feb 2024 11:40:58 +0100 (CET)
Message-ID: <40746a9ae6d2e76d748ec0bf7710bba7e49a53ac.camel@huaweicloud.com>
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, paul@paul-moore.com, 
 roberto.sassu@huawei.com, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com,  zohar@linux.ibm.com,
 linux-fsdevel@vger.kernel.org
Date: Tue, 20 Feb 2024 11:40:43 +0100
In-Reply-To: <0000000000002be12a0611ca7ff8@google.com>
References: <0000000000002be12a0611ca7ff8@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD36hOvgdRl1QDeAg--.11661S2
X-Coremail-Antispam: 1UD129KBjvAXoWfXr1rZw4xXF15CF4xJFW7CFg_yoW8Ww15Co
	ZavwsIkF15J3ZxJFWSkFs7uw4fuFWrXry7Xr4v93y5KF43Z34jkryrAa4jyFZ5Xr43W3WU
	X3srtF13t3Wqgr1fn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYO7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIccxYrVCFb41lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5l4iUUUUU
	U==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj5aCXQAAst

On Mon, 2024-02-19 at 22:41 -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D135ba81c18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De3dd779fba027=
968
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7bc44a489f0ef06=
70bd5
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/34924e0466d4/dis=
k-4f5e5092.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/29d0b1935c61/vmlinu=
x-4f5e5092.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2e033c3d8679/b=
zImage-4f5e5092.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x870 security/i=
ntegrity/ima/ima_queue.c:172
>  ima_add_template_entry+0x52b/0x870 security/integrity/ima/ima_queue.c:17=
2
>  ima_store_template security/integrity/ima/ima_api.c:122 [inline]
>  ima_store_measurement+0x371/0x8d0 security/integrity/ima/ima_api.c:376
>  process_measurement+0x2c6e/0x3ef0 security/integrity/ima/ima_main.c:367
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> <Zero or more stacks not recorded to save memory>
>=20
> Uninit was stored to memory at:
>  sha256_transform lib/crypto/sha256.c:117 [inline]
>  sha256_transform_blocks+0x2dbf/0x2e80 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x75/0xa0 crypto/shash.c:70
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> Uninit was stored to memory at:
>  sha256_transform lib/crypto/sha256.c:117 [inline]
>  sha256_transform_blocks+0x2dbf/0x2e80 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x75/0xa0 crypto/shash.c:70
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:91 [inline]
>  sha256_transform_blocks+0xf33/0x2e80 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x75/0xa0 crypto/shash.c:70
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:92 [inline]
>  sha256_transform_blocks+0xf7d/0x2e80 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x75/0xa0 crypto/shash.c:70
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> Uninit was stored to memory at:
>  BLEND_OP lib/crypto/sha256.c:61 [inline]
>  sha256_transform lib/crypto/sha256.c:93 [inline]
>  sha256_transform_blocks+0xfb5/0x2e80 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x75/0xa0 crypto/shash.c:70
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> Uninit was stored to memory at:
>  LOAD_OP lib/crypto/sha256.c:56 [inline]
>  sha256_transform lib/crypto/sha256.c:82 [inline]
>  sha256_transform_blocks+0x2c35/0x2e80 lib/crypto/sha256.c:127
>  lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
>  sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
>  crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
>  crypto_shash_update+0x75/0xa0 crypto/shash.c:70
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b

If I understood what the report is saying (ima_calc_file_hash_tfm()):

	while (offset < i_size) {
		int rbuf_len;

		rbuf_len =3D integrity_kernel_read(file, offset, rbuf, PAGE_SIZE);
		if (rbuf_len < 0) {
			rc =3D rbuf_len;
			break;
		}
		if (rbuf_len =3D=3D 0) {	/* unexpected EOF */
			rc =3D -EINVAL;
			break;
		}
		offset +=3D rbuf_len;

		rc =3D crypto_shash_update(shash, rbuf, rbuf_len);
		if (rc)
			break;
	}

we are reading a non-initialized rbuf, which should not happen because
integrity_kernel_read() returned a positive value (success).

The other information we have is that the filesystem in question uses
generic_file_read_iter() as read_iter method.

I would add the VFS people in CC, in case they have some ideas.

Thanks

Roberto

> Uninit was stored to memory at:
>  memcpy_to_iter lib/iov_iter.c:65 [inline]
>  iterate_kvec include/linux/iov_iter.h:85 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:251 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  _copy_to_iter+0x125a/0x2520 lib/iov_iter.c:186
>  copy_page_to_iter+0x419/0x870 lib/iov_iter.c:381
>  copy_folio_to_iter include/linux/uio.h:181 [inline]
>  filemap_read+0xbf4/0x14d0 mm/filemap.c:2654
>  generic_file_read_iter+0x136/0xad0 mm/filemap.c:2784
>  __kernel_read+0x724/0xce0 fs/read_write.c:434
>  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> Uninit was created at:
>  __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4590
>  alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
>  alloc_pages mm/mempolicy.c:2204 [inline]
>  folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
>  filemap_alloc_folio+0xa5/0x430 mm/filemap.c:975
>  page_cache_ra_unbounded+0x2cc/0x960 mm/readahead.c:247
>  do_page_cache_ra mm/readahead.c:299 [inline]
>  page_cache_ra_order+0xe31/0xee0 mm/readahead.c:544
>  ondemand_readahead+0x157d/0x1750 mm/readahead.c:666
>  page_cache_sync_ra+0x724/0x760 mm/readahead.c:693
>  page_cache_sync_readahead include/linux/pagemap.h:1300 [inline]
>  filemap_get_pages+0x4c4/0x2bd0 mm/filemap.c:2498
>  filemap_read+0x59e/0x14d0 mm/filemap.c:2594
>  generic_file_read_iter+0x136/0xad0 mm/filemap.c:2784
>  __kernel_read+0x724/0xce0 fs/read_write.c:434
>  integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>  ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
>  ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
>  process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
>  ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
>  do_open fs/namei.c:3643 [inline]
>  path_openat+0x4d09/0x5ad0 fs/namei.c:3798
>  do_filp_open+0x20d/0x590 fs/namei.c:3825
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_open fs/open.c:1427 [inline]
>  __se_sys_open fs/open.c:1423 [inline]
>  __x64_sys_open+0x275/0x2d0 fs/open.c:1423
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>=20
> CPU: 1 PID: 9243 Comm: syz-executor.3 Not tainted 6.8.0-rc4-syzkaller-001=
80-g4f5e5092fdbf #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


