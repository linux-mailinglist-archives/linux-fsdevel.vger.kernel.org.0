Return-Path: <linux-fsdevel+bounces-156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D557C6661
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 09:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B171C21058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE27FC14;
	Thu, 12 Oct 2023 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1EDDD5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 07:30:07 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8689D;
	Thu, 12 Oct 2023 00:30:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S5gts4LNtz9xrtf;
	Thu, 12 Oct 2023 15:17:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCn_5BQoCdlXCMQAg--.31200S2;
	Thu, 12 Oct 2023 08:29:34 +0100 (CET)
Message-ID: <16c8c95f2e63ab9a2fba8cba919bf129d0541b61.camel@huaweicloud.com>
Subject: Re: [PATCH v3 02/25] ima: Align ima_post_path_mknod() definition
 with LSM infrastructure
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 dmitry.kasatkin@gmail.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, dhowells@redhat.com,  jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, 
 casey@schaufler-ca.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 12 Oct 2023 09:29:16 +0200
In-Reply-To: <8646e30b0074a2932076b5a0a792b14be034de98.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
	 <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
	 <b51baf7741de1fdee8b36a87bd2dde71184d47a8.camel@huaweicloud.com>
	 <8646e30b0074a2932076b5a0a792b14be034de98.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCn_5BQoCdlXCMQAg--.31200S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWfAw4Utr48uF48Gw1Utrb_yoW7CF1fpF
	WkJ3WDGrZ5Xry7uF10vayYyasav3y7tF1UWrn0gw1ayr9xtFnIgFsa9F4Y9ryrKF4DCry7
	XF1UtrZxu3yjyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5Tu6AAAsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 15:01 -0400, Mimi Zohar wrote:
> On Wed, 2023-10-11 at 18:02 +0200, Roberto Sassu wrote:
> > On Wed, 2023-10-11 at 10:38 -0400, Mimi Zohar wrote:
> > > On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Change ima_post_path_mknod() definition, so that it can be register=
ed as
> > > > implementation of the path_post_mknod hook. Since LSMs see a umask-=
stripped
> > > > mode from security_path_mknod(), pass the same to ima_post_path_mkn=
od() as
> > > > well.
> > > > Also, make sure that ima_post_path_mknod() is executed only if
> > > > (mode & S_IFMT) is equal to zero or S_IFREG.
> > > >=20
> > > > Add this check to take into account the different placement of the
> > > > path_post_mknod hook (to be introduced) in do_mknodat().
> > >=20
> > > Move "(to be introduced)" to when it is first mentioned.
> > >=20
> > > > Since the new hook
> > > > will be placed after the switch(), the check ensures that
> > > > ima_post_path_mknod() is invoked as originally intended when it is
> > > > registered as implementation of path_post_mknod.
> > > >=20
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  fs/namei.c                        |  9 ++++++---
> > > >  include/linux/ima.h               |  7 +++++--
> > > >  security/integrity/ima/ima_main.c | 10 +++++++++-
> > > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index e56ff39a79bc..c5e96f716f98 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -4024,6 +4024,7 @@ static int do_mknodat(int dfd, struct filenam=
e *name, umode_t mode,
> > > >  	struct path path;
> > > >  	int error;
> > > >  	unsigned int lookup_flags =3D 0;
> > > > +	umode_t mode_stripped;
> > > > =20
> > > >  	error =3D may_mknod(mode);
> > > >  	if (error)
> > > > @@ -4034,8 +4035,9 @@ static int do_mknodat(int dfd, struct filenam=
e *name, umode_t mode,
> > > >  	if (IS_ERR(dentry))
> > > >  		goto out1;
> > > > =20
> > > > -	error =3D security_path_mknod(&path, dentry,
> > > > -			mode_strip_umask(path.dentry->d_inode, mode), dev);
> > > > +	mode_stripped =3D mode_strip_umask(path.dentry->d_inode, mode);
> > > > +
> > > > +	error =3D security_path_mknod(&path, dentry, mode_stripped, dev);
> > > >  	if (error)
> > > >  		goto out2;
> > > > =20
> > > > @@ -4045,7 +4047,8 @@ static int do_mknodat(int dfd, struct filenam=
e *name, umode_t mode,
> > > >  			error =3D vfs_create(idmap, path.dentry->d_inode,
> > > >  					   dentry, mode, true);
> > > >  			if (!error)
> > > > -				ima_post_path_mknod(idmap, dentry);
> > > > +				ima_post_path_mknod(idmap, &path, dentry,
> > > > +						    mode_stripped, dev);
> > > >  			break;
> > > >  		case S_IFCHR: case S_IFBLK:
> > > >  			error =3D vfs_mknod(idmap, path.dentry->d_inode,
> > > > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > > > index 910a2f11a906..179ce52013b2 100644
> > > > --- a/include/linux/ima.h
> > > > +++ b/include/linux/ima.h
> > > > @@ -32,7 +32,8 @@ extern int ima_read_file(struct file *file, enum =
kernel_read_file_id id,
> > > >  extern int ima_post_read_file(struct file *file, void *buf, loff_t=
 size,
> > > >  			      enum kernel_read_file_id id);
> > > >  extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > -				struct dentry *dentry);
> > > > +				const struct path *dir, struct dentry *dentry,
> > > > +				umode_t mode, unsigned int dev);
> > > >  extern int ima_file_hash(struct file *file, char *buf, size_t buf_=
size);
> > > >  extern int ima_inode_hash(struct inode *inode, char *buf, size_t b=
uf_size);
> > > >  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int =
size);
> > > > @@ -114,7 +115,9 @@ static inline int ima_post_read_file(struct fil=
e *file, void *buf, loff_t size,
> > > >  }
> > > > =20
> > > >  static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > -				       struct dentry *dentry)
> > > > +				       const struct path *dir,
> > > > +				       struct dentry *dentry,
> > > > +				       umode_t mode, unsigned int dev)
> > > >  {
> > > >  	return;
> > > >  }
> > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity=
/ima/ima_main.c
> > > > index 365db0e43d7c..76eba92d7f10 100644
> > > > --- a/security/integrity/ima/ima_main.c
> > > > +++ b/security/integrity/ima/ima_main.c
> > > > @@ -696,18 +696,26 @@ void ima_post_create_tmpfile(struct mnt_idmap=
 *idmap,
> > > >  /**
> > > >   * ima_post_path_mknod - mark as a new inode
> > > >   * @idmap: idmap of the mount the inode was found from
> > > > + * @dir: path structure of parent of the new file
> > > >   * @dentry: newly created dentry
> > > > + * @mode: mode of the new file
> > > > + * @dev: undecoded device number
> > > >   *
> > > >   * Mark files created via the mknodat syscall as new, so that the
> > > >   * file data can be written later.
> > > >   */
> > > >  void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > -			 struct dentry *dentry)
> > > > +			 const struct path *dir, struct dentry *dentry,
> > > > +			 umode_t mode, unsigned int dev)
> > > >  {
> > > >  	struct integrity_iint_cache *iint;
> > > >  	struct inode *inode =3D dentry->d_inode;
> > > >  	int must_appraise;
> > > > =20
> > > > +	/* See do_mknodat(), IMA is executed for case 0: and case S_IFREG=
: */
> > > > +	if ((mode & S_IFMT) !=3D 0 && (mode & S_IFMT) !=3D S_IFREG)
> > > > +		return;
> > > > +
> > >=20
> > > There's already a check below to make sure that this is a regular fil=
e.
> > > Are both needed?
> >=20
> > You are right, I can remove the first check.
>=20
> The question then becomes why modify hook the arguments?  =20

We need to make sure that ima_post_path_mknod() has the same parameters
as the LSM hook at the time we register it to the LSM infrastructure.

Thanks

Roberto

> >=20
> > > >  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> > > >  		return;
> > > > =20
> >=20
>=20


