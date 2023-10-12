Return-Path: <linux-fsdevel+bounces-172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCD7C6E6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD81C21089
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76882628C;
	Thu, 12 Oct 2023 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584A208D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 12:46:27 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EBFB8;
	Thu, 12 Oct 2023 05:46:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4S5pvx3ZC2z9y0J2;
	Thu, 12 Oct 2023 20:33:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnP5F16idlsrETAg--.31126S2;
	Thu, 12 Oct 2023 13:45:55 +0100 (CET)
Message-ID: <e6f0e7929abda6fa6ae7ef450b6e155b420a5f5b.camel@huaweicloud.com>
Subject: Re: [PATCH v3 14/25] security: Introduce file_post_open hook
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
Date: Thu, 12 Oct 2023 14:45:38 +0200
In-Reply-To: <2026a46459563d8f5d132a099f402ddad8f06fae.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
	 <2026a46459563d8f5d132a099f402ddad8f06fae.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnP5F16idlsrETAg--.31126S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1fKF1kKrWkJrW3tr15CFg_yoW7KFW8pF
	Z5Ja17GFWkJFy7Wrn7Aa13uF4Sg395Kr1UWrZ5X34jyFnYqr1vgFs8Kr1Y9F45JrZYka40
	v3W2grZxCryDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5DyygABsW
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 08:36 -0400, Mimi Zohar wrote:
> On Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > In preparation to move IMA and EVM to the LSM infrastructure, introduce=
 the
> > file_post_open hook. Also, export security_file_post_open() for NFS.
> >=20
> > It is useful for IMA to calculate the dhigest of the file content, and =
to
> > decide based on that digest whether the file should be made accessible =
to
> > the requesting process.
>=20
> Please remove "It is usefile for".   Perhaps something along the lines:
>=20
>=20
> Based on policy, IMA calculates the digest of the file content and
> decides ...

Ok.

> >=20
> > LSMs should use this hook instead of file_open, if they need to make th=
eir
> > decision based on an opened file (for example by inspecting the file
> > content). The file is not open yet in the file_open hook.
>=20
> The security hooks were originally defined for enforcing access
> control.  As a result the hooks were placed before the action.  The
> usage of the LSM hooks is not limited to just enforcing access control
> these days.  For IMA/EVM to become full LSMs additional hooks are
> needed post action.  Other LSMs, probably non-access control ones,
> could similarly take some action post action, in this case successful
> file open.

I don't know, I would not exclude LSMs to enforce access control. The
post action can be used to update the state, which can be used to check
next accesses (exactly what happens for EVM).

> Having to justify the new LSM post hooks in terms of the existing LSMs,
> which enforce access control, is really annoying and makes no sense.=20
> Please don't.

Well, there is a relationship between the pre and post. But if you
prefer, I remove this comparison.

Thanks

Roberto

> > The new hook can
> > return an error and can cause the open to be aborted.
>=20
> Please make this a separate pagraph.
>=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  fs/namei.c                    |  2 ++
> >  fs/nfsd/vfs.c                 |  6 ++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 17 +++++++++++++++++
> >  5 files changed, 32 insertions(+)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1f5ec71360de..7dc4626859f0 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3634,6 +3634,8 @@ static int do_open(struct nameidata *nd,
> >  	error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> >  	if (!error && !(file->f_mode & FMODE_OPENED))
> >  		error =3D vfs_open(&nd->path, file);
> > +	if (!error)
> > +		error =3D security_file_post_open(file, op->acc_mode);
> >  	if (!error)
> >  		error =3D ima_file_check(file, op->acc_mode);
> >  	if (!error && do_truncate)
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 8a2321d19194..3450bb1c8a18 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -862,6 +862,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh =
*fhp, umode_t type,
> >  		goto out_nfserr;
> >  	}
> > =20
> > +	host_err =3D security_file_post_open(file, may_flags);
> > +	if (host_err) {
> > +		fput(file);
> > +		goto out_nfserr;
> > +	}
> > +
> >  	host_err =3D ima_file_check(file, may_flags);
> >  	if (host_err) {
> >  		fput(file);
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 1153e7163b8b..60ed33f0c80d 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -188,6 +188,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_s=
truct *tsk,
> >  	 struct fown_struct *fown, int sig)
> >  LSM_HOOK(int, 0, file_receive, struct file *file)
> >  LSM_HOOK(int, 0, file_open, struct file *file)
> > +LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
> >  LSM_HOOK(int, 0, file_truncate, struct file *file)
> >  LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
> >  	 unsigned long clone_flags)
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 665bba3e0081..a0f16511c059 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -403,6 +403,7 @@ int security_file_send_sigiotask(struct task_struct=
 *tsk,
> >  				 struct fown_struct *fown, int sig);
> >  int security_file_receive(struct file *file);
> >  int security_file_open(struct file *file);
> > +int security_file_post_open(struct file *file, int mask);
> >  int security_file_truncate(struct file *file);
> >  int security_task_alloc(struct task_struct *task, unsigned long clone_=
flags);
> >  void security_task_free(struct task_struct *task);
> > @@ -1044,6 +1045,11 @@ static inline int security_file_open(struct file=
 *file)
> >  	return 0;
> >  }
> > =20
> > +static inline int security_file_post_open(struct file *file, int mask)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline int security_file_truncate(struct file *file)
> >  {
> >  	return 0;
> > diff --git a/security/security.c b/security/security.c
> > index 3947159ba5e9..3e0078b51e46 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2856,6 +2856,23 @@ int security_file_open(struct file *file)
> >  	return fsnotify_perm(file, MAY_OPEN);
> >  }
> > =20
> > +/**
> > + * security_file_post_open() - Recheck access to a file after it has b=
een opened
>=20
> The LSM post hooks aren't needed to enforce access control.   Probably
> better to say something along the lines of "take some action after
> successful file open".
>=20
> > + * @file: the file
> > + * @mask: access mask
> > + *
> > + * Recheck access with mask after the file has been opened. The hook i=
s useful
> > + * for LSMs that require the file content to be available in order to =
make
> > + * decisions.
>=20
> And reword the above accordingly.
>=20
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_file_post_open(struct file *file, int mask)
> > +{
> > +	return call_int_hook(file_post_open, 0, file, mask);
> > +}
> > +EXPORT_SYMBOL_GPL(security_file_post_open);
> > +
> >  /**
> >   * security_file_truncate() - Check if truncating a file is allowed
> >   * @file: file
>=20


