Return-Path: <linux-fsdevel+bounces-5656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A880E90C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E611F2190F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A385B5CC;
	Tue, 12 Dec 2023 10:25:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE033AC;
	Tue, 12 Dec 2023 02:25:10 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SqDsS5rb0z9v7Z3;
	Tue, 12 Dec 2023 18:11:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D8C3F14093A;
	Tue, 12 Dec 2023 18:24:59 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXlHTeNHhlEChmAg--.39609S2;
	Tue, 12 Dec 2023 11:24:59 +0100 (CET)
Message-ID: <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
Date: Tue, 12 Dec 2023 11:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Seth Forshee <sforshee@kernel.org>,
 miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, zohar@linux.ibm.com, paul@paul-moore.com,
 stefanb@linux.ibm.com, jlayton@kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Eric Snowberg <eric.snowberg@oracle.com>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <20231211-fortziehen-basen-b8c0639044b8@brauner>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20231211-fortziehen-basen-b8c0639044b8@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBXlHTeNHhlEChmAg--.39609S2
X-Coremail-Antispam: 1UD129KBjvAXoWfKr1UGw1kGFWkuFW7Jr4Utwb_yoW5Wr48Ko
	WfW347Gr4rWw17JrW5uw1UJ393Cay5JayxtFy5Krs8GFyIvry5Cw15W3WrJF15AryUWrWD
	twn7t3Wqy34DX3s5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj5eLPQABsd

On 11.12.23 19:01, Christian Brauner wrote:
>> The second problem is that one security.evm is not enough. We need two,
>> to store the two different HMACs. And we need both at the same time,
>> since when overlayfs is mounted the lower/upper directories can be
>> still accessible.
> 
> "Changes to the underlying filesystems while part of a mounted overlay
> filesystem are not allowed. If the underlying filesystem is changed, the
> behavior of the overlay is undefined, though it will not result in a
> crash or deadlock."
> 
> https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-filesystems
> 
> So I don't know why this would be a problem.

+ Eric Snowberg

Ok, that would reduce the surface of attack. However, when looking at:

      ovl: Always reevaluate the file signature for IMA

      Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the 
i_version")
      partially closed an IMA integrity issue when directly modifying a file
      on the lower filesystem.  If the overlay file is first opened by a 
user
      and later the lower backing file is modified by root, but the extended
      attribute is NOT updated, the signature validation succeeds with 
the old
      original signature.

Ok, so if the behavior of overlayfs is undefined if the lower backing 
file is modified by root, do we need to reevaluate? Or instead would be 
better to forbid the write from IMA (legitimate, I think, since the 
behavior is documented)? I just saw that we have d_real_inode(), we can 
use it to determine if the write should be denied.

>> In the example I described, IMA tries to update security.ima, but this
>> causes EVM to attempt updating security.evm twice (once after the upper
>> filesystem performed the setxattr requested by overlayfs, another after
>> overlayfs performed the setxattr requested by IMA; the latter fails
> 
> So I think phrasing it this way is confusiong. All that overlayfs does
> is to forward that setxattr request to the upper layer. So really the
> overlayfs layer here is irrelevant?

I guess you meant (s/?/./).

The problem is calling vfs_setxattr()/vfs_removexattr() which makes EVM 
verify those calls. If overlayfs should be irrelevant, then it should 
use calls that don't cause EVM to be invoked. Otherwise, from EVM 
perspective it is equal to do an xattr operation from user space.

>> since EVM does not allow the VFS to directly update the HMAC).
> 
> Callchains and details, please. I don't understand what you mean.

Originally I wanted to analyze the stacktraces together, then for sake 
of brevity and (I thought) clarity, I decided to not include them. So, 
let's go through them.

  #0  evm_update_evmxattr (dentry=dentry@entry=0x6b6b6ba0, 
xattr_name=xattr_name@entry=0x60b39cf0 "security.ima",
      xattr_value=xattr_value@entry=0x653a7742 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302o\322", 
'\314' <repeats 36 times>, "@x:e", 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_crypto.c:358
  #1  0x00000000604f011a in evm_inode_post_setxattr 
(dentry=dentry@entry=0x6b6b6ba0, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima", xattr_value=xattr_value@entry=0x653a7742, 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_main.c:753
  #2  0x00000000604a36ff in security_inode_post_setxattr 
(dentry=dentry@entry=0x6b6b6ba0, name=name@entry=0x60b39cf0 
"security.ima", value=value@entry=0x653a7742, size=size@entry=34, 
flags=flags@entry=0) at security/security.c:2286
  #3  0x0000000060232570 in __vfs_setxattr_noperm 
(idmap=idmap@entry=0x60ea0250 <nop_mnt_idmap>, 
dentry=dentry@entry=0x6b6b6ba0, name=name@entry=0x60b39cf0 
"security.ima", value=value@entry=0x653a7742, size=size@entry=34, 
flags=flags@entry=0) at fs/xattr.c:239
  #4  0x0000000060232778 in __vfs_setxattr_locked 
(idmap=idmap@entry=0x60ea0250 <nop_mnt_idmap>, 
dentry=dentry@entry=0x6b6b6ba0, name=name@entry=0x60b39cf0 
"security.ima", value=0x653a7742, size=size@entry=34, 
flags=flags@entry=0, delegated_inode=0xe1003b18) at fs/xattr.c:296
  #5  0x0000000060232829 in vfs_setxattr (idmap=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b6ba0, 
name=name@entry=0x60b39cf0 "security.ima", value=<optimized out>, 
value@entry=0x653a7742, size=size@entry=34, flags=flags@entry=0) at 
fs/xattr.c:322
  #6  0x00000000603a4440 in ovl_do_setxattr (ofs=0x65366008, 
ofs=0x65366008, flags=0, size=34, value=0x653a7742, name=0x60b39cf0 
"security.ima", dentry=0x6b6b6ba0) at ./include/linux/mount.h:80
  #7  ovl_xattr_set (dentry=0x6b6b7dd8, inode=0x6367cbb8, 
name=0x60b39cf0 "security.ima", value=0x653a7742, size=size@entry=34, 
flags=flags@entry=0) at fs/overlayfs/xattrs.c:69
  #8  0x00000000603a4698 in ovl_other_xattr_set (handler=<optimized 
out>, idmap=<optimized out>, dentry=<optimized out>, inode=<optimized 
out>, name=<optimized out>, value=<optimized out>, size=34, flags=0) at 
fs/overlayfs/xattrs.c:233
  #9  0x0000000060231bd6 in __vfs_setxattr (idmap=idmap@entry=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b7dd8, 
inode=inode@entry=0x6367cbb8, name=<optimized out>, 
name@entry=0x60b39cf0 "security.ima", value=value@entry=0x653a7742, 
size=size@entry=34, flags=0)
      at fs/xattr.c:201
  #10 0x000000006023246e in __vfs_setxattr_noperm (idmap=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b7dd8, 
name=name@entry=0x60b39cf0 "security.ima", value=0x653a7742, size=34, 
flags=flags@entry=0) at fs/xattr.c:235
  #11 0x00000000604ed684 in ima_fix_xattr 
(dentry=dentry@entry=0x6b6b7dd8, iint=iint@entry=0x651d2008) at 
security/integrity/ima/ima_appraise.c:101
  #12 0x00000000604ee4c8 in ima_update_xattr 
(iint=iint@entry=0x651d2008, file=file@entry=0x6a3c76c0) at 
security/integrity/ima/ima_appraise.c:624
  #13 0x00000000604e32cc in ima_check_last_writer (iint=0x651d2008, 
inode=inode@entry=0x6367cbb8, file=file@entry=0x6a3c76c0) at 
security/integrity/ima/ima_main.c:180
  #14 0x00000000604e461c in ima_file_free (file=file@entry=0x6a3c76c0) 
at security/integrity/ima/ima_main.c:204
  #15 0x00000000601f3cd8 in __fput (file=0x6a3c76c0) at fs/file_table.c:388
  #16 0x00000000601f40c4 in ____fput (work=<optimized out>) at 
fs/file_table.c:422
  #17 0x000000006007d87c in task_work_run () at kernel/task_work.c:180
  #18 0x000000006002f294 in resume_user_mode_work (regs=<optimized out>) 
at ./include/linux/resume_user_mode.h:49
  #19 interrupt_end () at arch/um/kernel/process.c:108
  #20 0x0000000060049bf8 in userspace (regs=0x632b1360, 
aux_fp_regs=0xe1000020) at arch/um/os-Linux/skas/process.c:499
  #21 0x000000006002ee94 in new_thread_handler () at 
arch/um/kernel/process.c:136

Here IMA is updating security.ima at file close after a write (frame 
#12). The overlayfs dentry is 0x6b6b7dd8, the upper dentry is 0x6b6b6ba0.

Issuing a setxattr operation to overlayfs causes the latter to call 
vfs_setxattr() (frame #5). From EVM perspective, this is just a setxattr 
operation on the upper filesystem, so it processes it normally (we are 
already past evm_inode_setxattr() which succeeded, now we are in the 
post method after the operation).

What evm_update_evmxattr() does is the following:

		rc = __vfs_setxattr_noperm(&nop_mnt_idmap, dentry,
					   XATTR_NAME_EVM,
					   &data.hdr.xattr.data[1],
					   SHA1_DIGEST_SIZE + 1, 0);

This is still done on the upper dentry:

  #0  __vfs_setxattr_noperm (idmap=idmap@entry=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b6ba0, 
name=name@entry=0x60b39c34 "security.evm", value=value@entry=0xe1003923, 
size=size@entry=21, flags=flags@entry=0) at fs/xattr.c:226
  #1  0x00000000604f0e06 in evm_update_evmxattr 
(dentry=dentry@entry=0x6b6b6ba0, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima",
      xattr_value=xattr_value@entry=0x653a7742 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302o\322", 
'\314' <repeats 36 times>, "@x:e", 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_crypto.c:378

Everything good until this point. EVM just set the HMAC on the upper 
dentry. Let's see the next call to evm_update_evmxattr():

  #0  evm_update_evmxattr (dentry=dentry@entry=0x6b6b7dd8, 
xattr_name=xattr_name@entry=0x60b39cf0 "security.ima",
      xattr_value=xattr_value@entry=0x653a7742 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302o\322", 
'\314' <repeats 36 times>, "@x:e", 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_crypto.c:358
  #1  0x00000000604f011a in evm_inode_post_setxattr 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima", xattr_value=xattr_value@entry=0x653a7742, 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_main.c:753
  #2  0x00000000604a36ff in security_inode_post_setxattr 
(dentry=dentry@entry=0x6b6b7dd8, name=name@entry=0x60b39cf0 
"security.ima", value=value@entry=0x653a7742, size=size@entry=34, 
flags=flags@entry=0) at security/security.c:2286
  #3  0x0000000060232570 in __vfs_setxattr_noperm (idmap=<optimized 
out>, dentry=dentry@entry=0x6b6b7dd8, name=name@entry=0x60b39cf0 
"security.ima", value=0x653a7742, size=34, flags=flags@entry=0) at 
fs/xattr.c:239
  #4  0x00000000604ed684 in ima_fix_xattr 
(dentry=dentry@entry=0x6b6b7dd8, iint=iint@entry=0x651d2008) at 
security/integrity/ima/ima_appraise.c:101
  #5  0x00000000604ee4c8 in ima_update_xattr 
(iint=iint@entry=0x651d2008, file=file@entry=0x6a3c76c0) at 
security/integrity/ima/ima_appraise.c:624
  #6  0x00000000604e32cc in ima_check_last_writer (iint=0x651d2008, 
inode=inode@entry=0x6367cbb8, file=file@entry=0x6a3c76c0) at 
security/integrity/ima/ima_main.c:180
  #7  0x00000000604e461c in ima_file_free (file=file@entry=0x6a3c76c0) 
at security/integrity/ima/ima_main.c:204
  #8  0x00000000601f3cd8 in __fput (file=0x6a3c76c0) at fs/file_table.c:388
  #9  0x00000000601f40c4 in ____fput (work=<optimized out>) at 
fs/file_table.c:422
  #10 0x000000006007d87c in task_work_run () at kernel/task_work.c:180
  #11 0x000000006002f294 in resume_user_mode_work (regs=<optimized out>) 
at ./include/linux/resume_user_mode.h:49
  #12 interrupt_end () at arch/um/kernel/process.c:108
  #13 0x0000000060049bf8 in userspace (regs=0x632b1360, 
aux_fp_regs=0xe1000020) at arch/um/os-Linux/skas/process.c:499
  #14 0x000000006002ee94 in new_thread_handler () at 
arch/um/kernel/process.c:136
  #15 0x0000000000000000 in ?? ()

This is the relationship between the two stacktraces:

  int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
  			  struct dentry *dentry, const char *name,
  			  const void *value, size_t size, int flags)
  {
  	struct inode *inode = dentry->d_inode;
  	int error = -EAGAIN;
  	int issec = !strncmp(name, XATTR_SECURITY_PREFIX,
  				   XATTR_SECURITY_PREFIX_LEN);

  	if (issec)
  		inode->i_flags &= ~S_NOSEC;
  	if (inode->i_opflags & IOP_XATTR) {
  		error = __vfs_setxattr(idmap, dentry, inode, name, value, ====> 
first stacktrace (frame #9)
  				       size, flags);
  		if (!error) {
  			fsnotify_xattr(dentry);
  			security_inode_post_setxattr(dentry, name, value, ====> second 
stacktrace (frame #2)
  						     size, flags);
  		}

Now we are back in the post method after the setxattr call issued to 
overlayfs. EVM treats it no differently from the first setxattr 
operation on the upper filesystem, and again tries to set security.evm, 
this time on overlayfs:

  Breakpoint 2, __vfs_setxattr_noperm (idmap=idmap@entry=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b7dd8, 
name=name@entry=0x60b39c34 "security.evm", value=value@entry=0xe1003b63, 
size=size@entry=21, flags=flags@entry=0) at fs/xattr.c:226
  226	{

If we were in the upper filesystem, there would not have been any 
problem, __vfs_setxattr() does not call evm_inode_setxattr() which fails 
for security.evm and an HMAC as value.

However, we are in the overlayfs, so we pass the setxattr operation through:

  #0  evm_inode_setxattr (idmap=idmap@entry=0x60ea0250 <nop_mnt_idmap>, 
dentry=dentry@entry=0x6b6b6ba0, xattr_name=xattr_name@entry=0x60b39c34 
"security.evm", xattr_value=xattr_value@entry=0xe1003b63, 
xattr_value_len=xattr_value_len@entry=21) at 
security/integrity/evm/evm_main.c:571
  #1  0x00000000604a344f in security_inode_setxattr 
(idmap=idmap@entry=0x60ea0250 <nop_mnt_idmap>, 
dentry=dentry@entry=0x6b6b6ba0, name=name@entry=0x60b39c34 
"security.evm", value=value@entry=0xe1003b63, size=size@entry=21, 
flags=flags@entry=0) at security/security.c:2191
  #2  0x00000000602326e8 in __vfs_setxattr_locked 
(idmap=idmap@entry=0x60ea0250 <nop_mnt_idmap>, 
dentry=dentry@entry=0x6b6b6ba0, name=name@entry=0x60b39c34 
"security.evm", value=0xe1003b63, size=size@entry=21, 
flags=flags@entry=0, delegated_inode=0xe1003988) at fs/xattr.c:287
  #3  0x0000000060232829 in vfs_setxattr (idmap=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b6ba0, 
name=name@entry=0x60b39c34 "security.evm", value=<optimized out>, 
value@entry=0xe1003b63, size=size@entry=21, flags=flags@entry=0) at 
fs/xattr.c:322
  #4  0x00000000603a4440 in ovl_do_setxattr (ofs=0x65366008, 
ofs=0x65366008, flags=0, size=21, value=0xe1003b63, name=0x60b39c34 
"security.evm", dentry=0x6b6b6ba0) at ./include/linux/mount.h:80
  #5  ovl_xattr_set (dentry=0x6b6b7dd8, inode=0x6367cbb8, 
name=0x60b39c34 "security.evm", value=0xe1003b63, size=size@entry=21, 
flags=flags@entry=0) at fs/overlayfs/xattrs.c:69
  #6  0x00000000603a4698 in ovl_other_xattr_set (handler=<optimized 
out>, idmap=<optimized out>, dentry=<optimized out>, inode=<optimized 
out>, name=<optimized out>, value=<optimized out>, size=21, flags=0) at 
fs/overlayfs/xattrs.c:233
  #7  0x0000000060231bd6 in __vfs_setxattr (idmap=idmap@entry=0x60ea0250 
<nop_mnt_idmap>, dentry=dentry@entry=0x6b6b7dd8, 
inode=inode@entry=0x6367cbb8, name=<optimized out>, 
name@entry=0x60b39c34 "security.evm", value=value@entry=0xe1003b63, 
size=size@entry=21, flags=0)
      at fs/xattr.c:201
  #8  0x000000006023246e in __vfs_setxattr_noperm 
(idmap=idmap@entry=0x60ea0250 <nop_mnt_idmap>, 
dentry=dentry@entry=0x6b6b7dd8, name=name@entry=0x60b39c34 
"security.evm", value=value@entry=0xe1003b63, size=size@entry=21, 
flags=flags@entry=0) at fs/xattr.c:235
  #9  0x00000000604f0e06 in evm_update_evmxattr 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima",
      xattr_value=xattr_value@entry=0x653a7742 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302o\322", 
'\314' <repeats 36 times>, "@x:e", 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_crypto.c:378
  #10 0x00000000604f011a in evm_inode_post_setxattr 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima", xattr_value=xattr_value@entry=0x653a7742, 
xattr_value_len=xattr_value_len@entry=34) at 
security/integrity/evm/evm_main.c:753
  #11 0x00000000604a36ff in security_inode_post_setxattr 
(dentry=dentry@entry=0x6b6b7dd8, name=name@entry=0x60b39cf0 
"security.ima", value=value@entry=0x653a7742, size=size@entry=34, 
flags=flags@entry=0) at security/security.c:2286
  #12 0x0000000060232570 in __vfs_setxattr_noperm (idmap=<optimized 
out>, dentry=dentry@entry=0x6b6b7dd8, name=name@entry=0x60b39cf0 
"security.ima", value=0x653a7742, size=34, flags=flags@entry=0) at 
fs/xattr.c:239
  #13 0x00000000604ed684 in ima_fix_xattr 
(dentry=dentry@entry=0x6b6b7dd8, iint=iint@entry=0x651d2008) at 
security/integrity/ima/ima_appraise.c:101
  #14 0x00000000604ee4c8 in ima_update_xattr 
(iint=iint@entry=0x651d2008, file=file@entry=0x6a3c76c0) at 
security/integrity/ima/ima_appraise.c:624
  #15 0x00000000604e32cc in ima_check_last_writer (iint=0x651d2008, 
inode=inode@entry=0x6367cbb8, file=file@entry=0x6a3c76c0) at 
security/integrity/ima/ima_main.c:180
  #16 0x00000000604e461c in ima_file_free (file=file@entry=0x6a3c76c0) 
at security/integrity/ima/ima_main.c:204
  #17 0x00000000601f3cd8 in __fput (file=0x6a3c76c0) at fs/file_table.c:388
  #18 0x00000000601f40c4 in ____fput (work=<optimized out>) at 
fs/file_table.c:422
  #19 0x000000006007d87c in task_work_run () at kernel/task_work.c:180
  #20 0x000000006002f294 in resume_user_mode_work (regs=<optimized out>) 
at ./include/linux/resume_user_mode.h:49
  #21 interrupt_end () at arch/um/kernel/process.c:108
  #22 0x0000000060049bf8 in userspace (regs=0x632b1360, 
aux_fp_regs=0xe1000020) at arch/um/os-Linux/skas/process.c:499
  #23 0x000000006002ee94 in new_thread_handler () at 
arch/um/kernel/process.c:136
  #24 0x0000000000000000 in ?? ()

This is the stacktrace before failing. It should be clear now what is 
happening. vfs_setxattr() (frame #3) calls security_inode_setxattr() 
(frame #1), which calls evm_inode_setxattr() (frame #0).

Again, the final result is that the written file has a security.evm set 
by the upper filesystem with the HMAC calculated on the upper inode 
metadata (setting security.evm from overlayfs failed).

So, next time we try to read the file and EVM attempts to verify inode 
metadata (frame #5), we have:

  Breakpoint 5, vfs_getxattr (idmap=0x60ea0250 <nop_mnt_idmap>, 
dentry=0x6b6b6ba0, name=name@entry=0x60b39c34 "security.evm", 
value=value@entry=0x0, size=size@entry=0) at fs/xattr.c:431
  431	{
  (gdb) bt
  #0  vfs_getxattr (idmap=0x60ea0250 <nop_mnt_idmap>, dentry=0x6b6b6ba0, 
name=name@entry=0x60b39c34 "security.evm", value=value@entry=0x0, 
size=size@entry=0) at fs/xattr.c:431
  #1  0x00000000603a479a in ovl_xattr_get (size=0, value=0x0, 
name=0x60b39c34 "security.evm", inode=<optimized out>, dentry=<optimized 
out>) at ./include/linux/mount.h:80
  #2  ovl_other_xattr_get (handler=<optimized out>, dentry=<optimized 
out>, inode=<optimized out>, name=0x60b39c34 "security.evm", buffer=0x0, 
size=0) at fs/overlayfs/xattrs.c:224
  #3  0x00000000602329f3 in vfs_getxattr_alloc (idmap=<optimized out>, 
dentry=dentry@entry=0x6b6b7dd8, name=<optimized out>, 
name@entry=0x60b39c34 "security.evm", 
xattr_value=xattr_value@entry=0xe1003858, xattr_size=xattr_size@entry=0, 
flags=flags@entry=3136) at fs/xattr.c:394
  #4  0x00000000604ef2d0 in evm_verify_hmac 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima",
      xattr_value=xattr_value@entry=0x653a7840 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302", 
<incomplete sequence \322>, xattr_value_len=xattr_value_len@entry=34, 
iint=iint@entry=0x651d2008) at security/integrity/evm/evm_main.c:187
  #5  0x00000000604ef77a in evm_verifyxattr 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima", xattr_value=xattr_value@entry=0x653a7840, 
xattr_value_len=xattr_value_len@entry=34, iint=iint@entry=0x651d2008)
      at security/integrity/evm/evm_main.c:416
  #6  0x00000000604ee3f5 in ima_appraise_measurement 
(func=func@entry=FILE_CHECK, iint=iint@entry=0x651d2008, 
file=file@entry=0x6a3c6cc0, filename=<optimized out>, 
xattr_value=0x653a7840, xattr_len=xattr_len@entry=34, modsig=0x0) at 
security/integrity/ima/ima_appraise.c:522
  #7  0x00000000604e410e in process_measurement 
(file=file@entry=0x6a3c6cc0, cred=<optimized out>, secid=secid@entry=1, 
buf=buf@entry=0x0, size=size@entry=0, mask=mask@entry=10, 
func=<optimized out>) at security/integrity/ima/ima_main.c:374
  #8  0x00000000604e458d in ima_file_check (file=file@entry=0x6a3c6cc0, 
mask=<optimized out>) at security/integrity/ima/ima_main.c:557
  #9  0x00000000602050ba in do_open (nd=nd@entry=0xe1003c90, 
file=file@entry=0x6a3c6cc0, op=op@entry=0xe1003dd0) at fs/namei.c:3624
  #10 0x000000006020b0e5 in path_openat (nd=nd@entry=0xe1003c90, 
op=op@entry=0xe1003dd0, flags=flags@entry=65) at fs/namei.c:3779
  #11 0x000000006020be8a in do_filp_open (dfd=dfd@entry=-100, 
pathname=pathname@entry=0x63321100, op=op@entry=0xe1003dd0) at 
fs/namei.c:3809
  #12 0x00000000601eea16 in do_sys_openat2 (dfd=-100, 
filename=<optimized out>, how=how@entry=0xe1003e20) at fs/open.c:1440
  #13 0x00000000601eed8e in do_sys_open (mode=<optimized out>, 
flags=<optimized out>, filename=<optimized out>, dfd=<optimized out>) at 
fs/open.c:1455
  #14 __do_sys_openat (mode=<optimized out>, flags=<optimized out>, 
filename=<optimized out>, dfd=<optimized out>) at fs/open.c:1471
  #15 __se_sys_openat (dfd=<optimized out>, filename=<optimized out>, 
flags=<optimized out>, mode=<optimized out>) at fs/open.c:1466
  #16 0x0000000060032da0 in handle_syscall (r=r@entry=0x632b1360) at 
arch/um/kernel/skas/syscall.c:45
  #17 0x00000000600494a9 in handle_trap (pid=pid@entry=2974892, 
regs=regs@entry=0x632b1360, 
local_using_sysemu=local_using_sysemu@entry=2) at 
arch/um/os-Linux/skas/process.c:222
  #18 0x0000000060049bdf in userspace (regs=0x632b1360, 
aux_fp_regs=0xe1000020) at arch/um/os-Linux/skas/process.c:477
  #19 0x000000006002ee94 in new_thread_handler () at 
arch/um/kernel/process.c:136
  #20 0x0000000000000000 in ?? ()

Overlayfs is getting security.evm from the upper filesystem (frame #2), 
but that HMAC was calculated with the upper inode metadata, so when EVM 
tries to calculate the HMAC on the overlayfs inode metadata, it fails:

  #0  evm_calc_hmac_or_hash (dentry=dentry@entry=0x6b6b7dd8, 
req_xattr_name=req_xattr_name@entry=0x60b39cf0 "security.ima",
      req_xattr_value=req_xattr_value@entry=0x653a7840 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302", 
<incomplete sequence \322>, 
req_xattr_value_len=req_xattr_value_len@entry=34, type=type@entry=2 '\002',
      data=data@entry=0xe1003860) at security/integrity/evm/evm_crypto.c:225
  #1  0x00000000604f0cad in evm_calc_hmac 
(dentry=dentry@entry=0x6b6b7dd8, 
req_xattr_name=req_xattr_name@entry=0x60b39cf0 "security.ima",
      req_xattr_value=req_xattr_value@entry=0x653a7840 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302", 
<incomplete sequence \322>, 
req_xattr_value_len=req_xattr_value_len@entry=34, 
data=data@entry=0xe1003860)
      at security/integrity/evm/evm_crypto.c:310
  #2  0x00000000604ef40e in evm_verify_hmac 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima",
      xattr_value=xattr_value@entry=0x653a7840 
"\004\004\362\312\033\266\307\351\a\320m\257\344h~W\237\316v\263~N\223\267`P\"\332R\346\314\302", 
<incomplete sequence \322>, xattr_value_len=xattr_value_len@entry=34, 
iint=iint@entry=0x651d2008) at security/integrity/evm/evm_main.c:214
  #3  0x00000000604ef77a in evm_verifyxattr 
(dentry=dentry@entry=0x6b6b7dd8, xattr_name=xattr_name@entry=0x60b39cf0 
"security.ima", xattr_value=xattr_value@entry=0x653a7840, 
xattr_value_len=xattr_value_len@entry=34, iint=iint@entry=0x651d2008)
      at security/integrity/evm/evm_main.c:416
  #4  0x00000000604ee3f5 in ima_appraise_measurement 
(func=func@entry=FILE_CHECK, iint=iint@entry=0x651d2008, 
file=file@entry=0x6a3c6cc0, filename=<optimized out>, 
xattr_value=0x653a7840, xattr_len=xattr_len@entry=34, modsig=0x0) at 
security/integrity/ima/ima_appraise.c:522
  #5  0x00000000604e410e in process_measurement 
(file=file@entry=0x6a3c6cc0, cred=<optimized out>, secid=secid@entry=1, 
buf=buf@entry=0x0, size=size@entry=0, mask=mask@entry=10, 
func=<optimized out>) at security/integrity/ima/ima_main.c:374
  #6  0x00000000604e458d in ima_file_check (file=file@entry=0x6a3c6cc0, 
mask=<optimized out>) at security/integrity/ima/ima_main.c:557
  #7  0x00000000602050ba in do_open (nd=nd@entry=0xe1003c90, 
file=file@entry=0x6a3c6cc0, op=op@entry=0xe1003dd0) at fs/namei.c:3624
  #8  0x000000006020b0e5 in path_openat (nd=nd@entry=0xe1003c90, 
op=op@entry=0xe1003dd0, flags=flags@entry=65) at fs/namei.c:3779
  #9  0x000000006020be8a in do_filp_open (dfd=dfd@entry=-100, 
pathname=pathname@entry=0x63321100, op=op@entry=0xe1003dd0) at 
fs/namei.c:3809
  #10 0x00000000601eea16 in do_sys_openat2 (dfd=-100, 
filename=<optimized out>, how=how@entry=0xe1003e20) at fs/open.c:1440
  #11 0x00000000601eed8e in do_sys_open (mode=<optimized out>, 
flags=<optimized out>, filename=<optimized out>, dfd=<optimized out>) at 
fs/open.c:1455
  #12 __do_sys_openat (mode=<optimized out>, flags=<optimized out>, 
filename=<optimized out>, dfd=<optimized out>) at fs/open.c:1471
  #13 __se_sys_openat (dfd=<optimized out>, filename=<optimized out>, 
flags=<optimized out>, mode=<optimized out>) at fs/open.c:1466
  #14 0x0000000060032da0 in handle_syscall (r=r@entry=0x632b1360) at 
arch/um/kernel/skas/syscall.c:45
  #15 0x00000000600494a9 in handle_trap (pid=pid@entry=2974892, 
regs=regs@entry=0x632b1360, 
local_using_sysemu=local_using_sysemu@entry=2) at 
arch/um/os-Linux/skas/process.c:222
  #16 0x0000000060049bdf in userspace (regs=0x632b1360, 
aux_fp_regs=0xe1000020) at arch/um/os-Linux/skas/process.c:477
  #17 0x000000006002ee94 in new_thread_handler () at 
arch/um/kernel/process.c:136
  #18 0x0000000000000000 in ?? ()


  275			iint->evm_status = evm_status;
  (gdb) p evm_status
  $4 = INTEGRITY_FAIL

>>
>> Remapping security.evm to security.evm_overlayfs (now
>> trusted.overlay.evm) allows us to store both HMACs separately and to
>> know which one to use.
>>
>> I just realized that the new xattr name should be public, because EVM
>> rejects HMAC updates, so we should reject HMAC updates based on the new
>> xattr name too.
> 
> I won't support any of this going in unless there's a comprehensive
> description of where this is all supposed to go and there's a
> comprehensive and coherent story of what EVM and IMA want to achieve for
> overlayfs or stacking filesystems in general. The past months we've seen
> a bunch of ductape to taper over this pretty basic question and there's
> no end in sight apparently.
> 
> Really, we need a comprehensive solution for both IMA and EVM it seems.
> And before that is solved we'll not be merging anything of this sort and
> won't make any impactful uapi changes such as exposing a new security.*
> xattr.

Fair enough, I'm going to answer to Amir about if we need EVM for 
overlayfs...

Roberto


