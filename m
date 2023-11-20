Return-Path: <linux-fsdevel+bounces-3226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C337F1A0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9475A1C20FC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A12111E;
	Mon, 20 Nov 2023 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DDABA;
	Mon, 20 Nov 2023 09:32:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYvKW1Jf5z9xvrJ;
	Tue, 21 Nov 2023 01:15:43 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDHxV_8l1tllXsHAQ--.3416S2;
	Mon, 20 Nov 2023 18:31:55 +0100 (CET)
Message-ID: <1999ed6f77100d9d2adc613c9748f15ab8fcf432.camel@huaweicloud.com>
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org,  stephen.smalley.work@gmail.com, eparis@parisplace.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan
 Berger <stefanb@linux.ibm.com>
Date: Mon, 20 Nov 2023 18:31:37 +0100
In-Reply-To: <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
	 <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
	 <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHxV_8l1tllXsHAQ--.3416S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfur1DZr4xWrW7XF48Crg_yoWrKFyfpF
	s8K3Z0kr4rJFy7Wry8tF1UCw4I9ayFgry7A3y2gw12vFn2yr1IqrWakF15C34rJrWjgF1q
	q3ZFkrs5Cr15Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1I6r4UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrfOzDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apagAAsm
X-CFilter-Loop: Reflected

On Tue, 2023-11-07 at 09:33 -0800, Casey Schaufler wrote:
> On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > In preparation for moving IMA and EVM to the LSM infrastructure, introd=
uce
> > the inode_post_removexattr hook.
> >=20
> > At inode_removexattr hook, EVM verifies the file's existing HMAC value.=
 At
> > inode_post_removexattr, EVM re-calculates the file's HMAC with the pass=
ed
> > xattr removed and other file metadata.
> >=20
> > Other LSMs could similarly take some action after successful xattr remo=
val.
> >=20
> > The new hook cannot return an error and cannot cause the operation to b=
e
> > reverted.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  fs/xattr.c                    |  9 +++++----
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  5 +++++
> >  security/security.c           | 14 ++++++++++++++
> >  4 files changed, 26 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 09d927603433..84a4aa566c02 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> >  		goto out;
> > =20
> >  	error =3D __vfs_removexattr(idmap, dentry, name);
> > +	if (error)
> > +		goto out;
>=20
> Shouldn't this be simply "return error" rather than a goto to nothing
> but "return error"?

I got a review from Andrew Morton. His argument seems convincing, that
having less return places makes the code easier to handle.

Thanks

Roberto

> > -	if (!error) {
> > -		fsnotify_xattr(dentry);
> > -		evm_inode_post_removexattr(dentry, name);
> > -	}
> > +	fsnotify_xattr(dentry);
> > +	security_inode_post_removexattr(dentry, name);
> > +	evm_inode_post_removexattr(dentry, name);
> > =20
> >  out:
> >  	return error;
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 67410e085205..88452e45025c 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -149,6 +149,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *den=
try, const char *name)
> >  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> >  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *name)
> > +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *de=
ntry,
> > +	 const char *name)
> >  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> >  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 664df46b22a9..922ea7709bae 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -380,6 +380,7 @@ int security_inode_getxattr(struct dentry *dentry, =
const char *name);
> >  int security_inode_listxattr(struct dentry *dentry);
> >  int security_inode_removexattr(struct mnt_idmap *idmap,
> >  			       struct dentry *dentry, const char *name);
> > +void security_inode_post_removexattr(struct dentry *dentry, const char=
 *name);
> >  int security_inode_need_killpriv(struct dentry *dentry);
> >  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *de=
ntry);
> >  int security_inode_getsecurity(struct mnt_idmap *idmap,
> > @@ -940,6 +941,10 @@ static inline int security_inode_removexattr(struc=
t mnt_idmap *idmap,
> >  	return cap_inode_removexattr(idmap, dentry, name);
> >  }
> > =20
> > +static inline void security_inode_post_removexattr(struct dentry *dent=
ry,
> > +						   const char *name)
> > +{ }
> > +
> >  static inline int security_inode_need_killpriv(struct dentry *dentry)
> >  {
> >  	return cap_inode_need_killpriv(dentry);
> > diff --git a/security/security.c b/security/security.c
> > index ce3bc7642e18..8aa6e9f316dd 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap =
*idmap,
> >  	return evm_inode_removexattr(idmap, dentry, name);
> >  }
> > =20
> > +/**
> > + * security_inode_post_removexattr() - Update the inode after a remove=
xattr op
> > + * @dentry: file
> > + * @name: xattr name
> > + *
> > + * Update the inode after a successful removexattr operation.
> > + */
> > +void security_inode_post_removexattr(struct dentry *dentry, const char=
 *name)
> > +{
> > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > +		return;
> > +	call_void_hook(inode_post_removexattr, dentry, name);
> > +}
> > +
> >  /**
> >   * security_inode_need_killpriv() - Check if security_inode_killpriv()=
 required
> >   * @dentry: associated dentry


