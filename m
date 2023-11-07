Return-Path: <linux-fsdevel+bounces-2259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADCB7E4183
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0001F28117E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E830F8E;
	Tue,  7 Nov 2023 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0E30D14;
	Tue,  7 Nov 2023 14:06:33 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5EFFA;
	Tue,  7 Nov 2023 06:06:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SPqRl5HJjz9xrp2;
	Tue,  7 Nov 2023 21:53:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXU7REpltbY3AA--.54899S2;
	Tue, 07 Nov 2023 15:06:02 +0100 (CET)
Message-ID: <563820b8fd57deb99e6247b6cdb416c4c3af3091.camel@huaweicloud.com>
Subject: Re: [PATCH v5 00/23] security: Move IMA and EVM to the LSM
 infrastructure
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 07 Nov 2023 15:05:44 +0100
In-Reply-To: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXBXU7REpltbY3AA--.54899S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr43Aw43trWkGFWrAFWUurg_yoWDJFWrpF
	4kKa15A34kJFy2k393AF4xua1S9ayrWrWUXr9xKry8Z3W5tr1FqFWSkrWY9ry5GrWrXw1I
	q3ZFy3s8ur1qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5YblQABsj
X-CFilter-Loop: Reflected

On Tue, 2023-11-07 at 14:39 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

Hi everyone

I kindly ask your support to add the missing reviewed-by/acked-by. I
summarize what is missing below:

- @Mimi: patches 1, 2, 4, 5, 6, 19, 21, 22, 23 (IMA/EVM-specific
         patches)
- @Al/@Christian: patches 10-17 (VFS-specific patches)
- @Paul: patches 10-23 (VFS-specific patches/new LSM hooks/new LSMs)
- @David Howells/@Jarkko: patch 18 (new LSM hook in the key subsystem)
- @Chuck Lever: patch 12 (new LSM hook in nfsd/vfs.c)

Paul, as I mentioned I currently based the patch set on lsm/dev-
staging, which include the following dependencies:

8f79e425c140 lsm: don't yet account for IMA in LSM_CONFIG_COUNT calculation
3c91a124f23d lsm: drop LSM_ID_IMA

I know you wanted to wait until at least rc1 to make lsm/dev. I will
help for rebasing my patch set, if needed.

Chuck, Mimi, there were two conflicts during the latest rebase:

d59b3515ab021 - nfsd: Handle EOPENSTALE correctly in the filecache
68279f9c9f59 - treewide: mark stuff as __ro_after_init

The first one required to change from 'goto out_nfserr' to 'goto out'
in the error path of patch 12.

The second one was automatically solved by kdiff3. It was because of
this change:

--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -23,7 +23,7 @@
=20
 static struct rb_root integrity_iint_tree =3D RB_ROOT;
 static DEFINE_RWLOCK(integrity_iint_lock);
-static struct kmem_cache *iint_cache __read_mostly;
+static struct kmem_cache *iint_cache __ro_after_init;

I'm running the IMA tests for every patch set version. So far, no
issues detected:

https://github.com/robertosassu/ima-evm-utils/actions/runs/6774439916

Please let me know if I can help with the process.

Thanks

Roberto

> IMA and EVM are not effectively LSMs, especially due to the fact that in
> the past they could not provide a security blob while there is another LS=
M
> active.
>=20
> That changed in the recent years, the LSM stacking feature now makes it
> possible to stack together multiple LSMs, and allows them to provide a
> security blob for most kernel objects. While the LSM stacking feature has
> some limitations being worked out, it is already suitable to make IMA and
> EVM as LSMs.
>=20
> In short, while this patch set is big, it does not make any functional
> change to IMA and EVM. IMA and EVM functions are called by the LSM
> infrastructure in the same places as before (except ima_post_path_mknod()=
),
> rather being hardcoded calls, and the inode metadata pointer is directly
> stored in the inode security blob rather than in a separate rbtree.
>=20
> To avoid functional changes, it was necessary to keep the 'integrity' LSM
> in addition to the newly introduced 'ima' and 'evm' LSMs, despite there i=
s
> no LSM ID assigned to it. There are two reasons: first, IMA and EVM still
> share the same inode metadata, and thus cannot directly reserve space in
> the security blob for it; second, someone needs to initialize 'ima' and
> 'evm' exactly in this order, as the LSM infrastructure cannot guarantee
> that.
>=20
> The patch set is organized as follows.
>=20
> Patches 1-9 make IMA and EVM functions suitable to be registered to the L=
SM
> infrastructure, by aligning function parameters.
>=20
> Patches 10-18 add new LSM hooks in the same places where IMA and EVM
> functions are called, if there is no LSM hook already.
>=20
> Patches 19-22 do the bulk of the work, introduce the new LSMs 'ima' and
> 'evm', and move hardcoded calls to IMA, EVM and integrity functions to
> those LSMs. In addition, they reserve one slot for the 'evm' LSM to suppl=
y
> an xattr with the inode_init_security hook.
>=20
> Finally, patch 23 removes the rbtree used to bind integrity metadata to t=
he
> inodes, and instead reserves a space in the inode security blob to store
> the pointer to that metadata. This also brings performance improvements d=
ue
> to retrieving metadata in constant time, as opposed to logarithmic.
>=20
> The patch set applies on top of lsm/dev-staging, commit ba7ce019d3e9 ("ls=
m:
> convert security_setselfattr() to use memdup_user()"). No need to merge
> linux-integrity/next-integrity-testing.
>=20
> Changelog:
>=20
> v4:
>  - Improve short and long description of
>    security_inode_post_create_tmpfile(), security_inode_post_set_acl(),
>    security_inode_post_remove_acl() and security_file_post_open()
>    (suggested by Mimi)
>  - Improve commit message of 'ima: Move to LSM infrastructure' (suggested
>    by Mimi)
>=20
> v3:
>  - Drop 'ima: Align ima_post_path_mknod() definition with LSM
>    infrastructure' and 'ima: Align ima_post_create_tmpfile() definition
>    with LSM infrastructure', define the new LSM hooks with the same
>    IMA parameters instead (suggested by Mimi)
>  - Do IS_PRIVATE() check in security_path_post_mknod() and
>    security_inode_post_create_tmpfile() on the new inode rather than the
>    parent directory (in the post method it is available)
>  - Don't export ima_file_check() (suggested by Stefan)
>  - Remove redundant check of file mode in ima_post_path_mknod() (suggeste=
d
>    by Mimi)
>  - Mention that ima_post_path_mknod() is now conditionally invoked when
>    CONFIG_SECURITY_PATH=3Dy (suggested by Mimi)
>  - Mention when a LSM hook will be introduced in the IMA/EVM alignment
>    patches (suggested by Mimi)
>  - Simplify the commit messages when introducing a new LSM hook
>  - Still keep the 'extern' in the function declaration, until the
>    declaration is removed (suggested by Mimi)
>  - Improve documentation of security_file_pre_free()
>  - Register 'ima' and 'evm' as standalone LSMs (suggested by Paul)
>  - Initialize the 'ima' and 'evm' LSMs from 'integrity', to keep the
>    original ordering of IMA and EVM functions as when they were hardcoded
>  - Return the IMA and EVM LSM IDs to 'integrity' for registration of the
>    integrity-specific hooks
>  - Reserve an xattr slot from the 'evm' LSM instead of 'integrity'
>  - Pass the LSM ID to init_ima_appraise_lsm()
>=20
> v2:
>  - Add description for newly introduced LSM hooks (suggested by Casey)
>  - Clarify in the description of security_file_pre_free() that actions ca=
n
>    be performed while the file is still open
>=20
> v1:
>  - Drop 'evm: Complete description of evm_inode_setattr()', 'fs: Fix
>    description of vfs_tmpfile()' and 'security: Introduce LSM_ORDER_LAST'=
,
>    they were sent separately (suggested by Christian Brauner)
>  - Replace dentry with file descriptor parameter for
>    security_inode_post_create_tmpfile()
>  - Introduce mode_stripped and pass it as mode argument to
>    security_path_mknod() and security_path_post_mknod()
>  - Use goto in do_mknodat() and __vfs_removexattr_locked() (suggested by
>    Mimi)
>  - Replace __lsm_ro_after_init with __ro_after_init
>  - Modify short description of security_inode_post_create_tmpfile() and
>    security_inode_post_set_acl() (suggested by Stefan)
>  - Move security_inode_post_setattr() just after security_inode_setattr()
>    (suggested by Mimi)
>  - Modify short description of security_key_post_create_or_update()
>    (suggested by Mimi)
>  - Add back exported functions ima_file_check() and
>    evm_inode_init_security() respectively to ima.h and evm.h (reported by
>    kernel robot)
>  - Remove extern from prototype declarations and fix style issues
>  - Remove unnecessary include of linux/lsm_hooks.h in ima_main.c and
>    ima_appraise.c
>=20
> Roberto Sassu (23):
>   ima: Align ima_inode_post_setattr() definition with LSM infrastructure
>   ima: Align ima_file_mprotect() definition with LSM infrastructure
>   ima: Align ima_inode_setxattr() definition with LSM infrastructure
>   ima: Align ima_inode_removexattr() definition with LSM infrastructure
>   ima: Align ima_post_read_file() definition with LSM infrastructure
>   evm: Align evm_inode_post_setattr() definition with LSM infrastructure
>   evm: Align evm_inode_setxattr() definition with LSM infrastructure
>   evm: Align evm_inode_post_setxattr() definition with LSM
>     infrastructure
>   security: Align inode_setattr hook definition with EVM
>   security: Introduce inode_post_setattr hook
>   security: Introduce inode_post_removexattr hook
>   security: Introduce file_post_open hook
>   security: Introduce file_pre_free_security hook
>   security: Introduce path_post_mknod hook
>   security: Introduce inode_post_create_tmpfile hook
>   security: Introduce inode_post_set_acl hook
>   security: Introduce inode_post_remove_acl hook
>   security: Introduce key_post_create_or_update hook
>   ima: Move to LSM infrastructure
>   ima: Move IMA-Appraisal to LSM infrastructure
>   evm: Move to LSM infrastructure
>   integrity: Move integrity functions to the LSM infrastructure
>   integrity: Switch from rbtree to LSM-managed blob for
>     integrity_iint_cache
>=20
>  fs/attr.c                             |   5 +-
>  fs/file_table.c                       |   3 +-
>  fs/namei.c                            |  12 +-
>  fs/nfsd/vfs.c                         |   3 +-
>  fs/open.c                             |   1 -
>  fs/posix_acl.c                        |   5 +-
>  fs/xattr.c                            |   9 +-
>  include/linux/evm.h                   | 103 ----------
>  include/linux/ima.h                   | 142 --------------
>  include/linux/integrity.h             |  26 ---
>  include/linux/lsm_hook_defs.h         |  20 +-
>  include/linux/security.h              |  59 ++++++
>  include/uapi/linux/lsm.h              |   2 +
>  security/integrity/evm/evm_main.c     | 138 ++++++++++++--
>  security/integrity/iint.c             | 113 +++++------
>  security/integrity/ima/ima.h          |  11 ++
>  security/integrity/ima/ima_appraise.c |  37 +++-
>  security/integrity/ima/ima_main.c     |  96 ++++++++--
>  security/integrity/integrity.h        |  58 +++++-
>  security/keys/key.c                   |  10 +-
>  security/security.c                   | 261 ++++++++++++++++----------
>  security/selinux/hooks.c              |   3 +-
>  security/smack/smack_lsm.c            |   4 +-
>  23 files changed, 614 insertions(+), 507 deletions(-)
>=20


