Return-Path: <linux-fsdevel+bounces-2948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF37EDDD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5545E1C20931
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B52942C;
	Thu, 16 Nov 2023 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A15187;
	Thu, 16 Nov 2023 01:44:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SWFBc0RMwz9yTL7;
	Thu, 16 Nov 2023 17:30:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD35HQ65FVl8FXFAA--.37511S2;
	Thu, 16 Nov 2023 10:43:37 +0100 (CET)
Message-ID: <b0f6ece6579a5016243cca5c313d1a58cae6eff2.camel@huaweicloud.com>
Subject: Re: [PATCH v5 10/23] security: Introduce inode_post_setattr hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com,  dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com,  eparis@parisplace.org,
 casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan
 Berger <stefanb@linux.ibm.com>
Date: Thu, 16 Nov 2023 10:43:18 +0100
In-Reply-To: <231ff26ec85f437261753faf03b384e6.paul@paul-moore.com>
References: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
	 <231ff26ec85f437261753faf03b384e6.paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD35HQ65FVl8FXFAA--.37511S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy3tF1ftF4kGF13Cw4rXwb_yoW5Wry7pF
	WrK3WYkwn5GFy7Wr93tF43uayS9ayrWr1UXrZIqr1jyFn8Kw13tF92kw1YkrW3Cr48G34F
	qw129Fsxur98ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5aFLwADsI
X-CFilter-Loop: Reflected

On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > In preparation for moving IMA and EVM to the LSM infrastructure, introd=
uce
> > the inode_post_setattr hook.
> >=20
> > At inode_setattr hook, EVM verifies the file's existing HMAC value. At
> > inode_post_setattr, EVM re-calculates the file's HMAC based on the modi=
fied
> > file attributes and other file metadata.
> >=20
> > Other LSMs could similarly take some action after successful file attri=
bute
> > change.
> >=20
> > The new hook cannot return an error and cannot cause the operation to b=
e
> > reverted.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  fs/attr.c                     |  1 +
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  7 +++++++
> >  security/security.c           | 16 ++++++++++++++++
> >  4 files changed, 26 insertions(+)
>=20
> ...
>=20
> > diff --git a/security/security.c b/security/security.c
> > index 7935d11d58b5..ce3bc7642e18 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2222,6 +2222,22 @@ int security_inode_setattr(struct mnt_idmap *idm=
ap,
> >  }
> >  EXPORT_SYMBOL_GPL(security_inode_setattr);
> > =20
> > +/**
> > + * security_inode_post_setattr() - Update the inode after a setattr op=
eration
> > + * @idmap: idmap of the mount
> > + * @dentry: file
> > + * @ia_valid: file attributes set
> > + *
> > + * Update inode security field after successful setting file attribute=
s.
> > + */
> > +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentr=
y *dentry,
> > +				 int ia_valid)
> > +{
> > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > +		return;
>=20
> I may be missing it, but I don't see the S_PRIVATE flag check in the
> existing IMA or EVM hooks so I'm curious as to why it is added here?
> Please don't misunderstand me, I think it makes sense to return early
> on private dentrys/inodes, but why aren't we doing that now?

My first motivation was that it is in the pre hooks, so it should be in
the post hook as well.

Thinking more about it, suppose that the post don't have the check,
private inodes would gain an HMAC without checking the validity of the
current HMAC first (done in the pre hooks), which would be even worse.

So, my idea about this is that at least we are consistent.

If IMA and EVM should look at private inodes is a different question,
which would require a discussion.

Thanks

Roberto

> > +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> > +}
> > +
> >  /**
> >   * security_inode_getattr() - Check if getting file attributes is allo=
wed
> >   * @path: file
> > --=20
> > 2.34.1
>=20
> --
> paul-moore.com


