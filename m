Return-Path: <linux-fsdevel+bounces-2952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA37EDE32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3921F23E62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E39629437;
	Thu, 16 Nov 2023 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2519E;
	Thu, 16 Nov 2023 02:08:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SWFkc5w27z9ybvb;
	Thu, 16 Nov 2023 17:54:48 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHtXXq6VVl8pvFAA--.44935S2;
	Thu, 16 Nov 2023 11:07:53 +0100 (CET)
Message-ID: <49a7fd0a1f89188fa92f258e88c50eaeca0f4ac9.camel@huaweicloud.com>
Subject: Re: [PATCH v5 22/23] integrity: Move integrity functions to the LSM
  infrastructure
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
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 16 Nov 2023 11:07:34 +0100
In-Reply-To: <f529266a02533411e72d706b908924e8.paul@paul-moore.com>
References: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
	 <f529266a02533411e72d706b908924e8.paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHtXXq6VVl8pvFAA--.44935S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43Kr4fGFyxJrW8Jw4ruFg_yoWrZF1xpF
	W3Ka43Grn5ZFy2kF1vvF45ua1Sg392gFyUWr13Kw10yas8Zr10qF18AryruF98CrWrtw1r
	tF4a9r4UC3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5KGhAAAsk
X-CFilter-Loop: Reflected

On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > Remove hardcoded calls to integrity functions from the LSM infrastructu=
re
> > and, instead, register them in integrity_lsm_init() with the IMA or EVM
> > LSM ID (the first non-NULL returned by ima_get_lsm_id() and
> > evm_get_lsm_id()).
> >=20
> > Also move the global declaration of integrity_inode_get() to
> > security/integrity/integrity.h, so that the function can be still calle=
d by
> > IMA.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  include/linux/integrity.h      | 26 --------------------------
> >  security/integrity/iint.c      | 30 +++++++++++++++++++++++++++++-
> >  security/integrity/integrity.h |  7 +++++++
> >  security/security.c            |  9 +--------
> >  4 files changed, 37 insertions(+), 35 deletions(-)
>=20
> ...
>=20
> > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > index 0b0ac71142e8..882fde2a2607 100644
> > --- a/security/integrity/iint.c
> > +++ b/security/integrity/iint.c
> > @@ -171,7 +171,7 @@ struct integrity_iint_cache *integrity_inode_get(st=
ruct inode *inode)
> >   *
> >   * Free the integrity information(iint) associated with an inode.
> >   */
> > -void integrity_inode_free(struct inode *inode)
> > +static void integrity_inode_free(struct inode *inode)
> >  {
> >  	struct integrity_iint_cache *iint;
> > =20
> > @@ -193,11 +193,39 @@ static void iint_init_once(void *foo)
> >  	memset(iint, 0, sizeof(*iint));
> >  }
> > =20
> > +static struct security_hook_list integrity_hooks[] __ro_after_init =3D=
 {
> > +	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
> > +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> > +	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request)=
,
> > +#endif
> > +};
> > +
> > +/*
> > + * Perform the initialization of the 'integrity', 'ima' and 'evm' LSMs=
 to
> > + * ensure that the management of integrity metadata is working at the =
time
> > + * IMA and EVM hooks are registered to the LSM infrastructure, and to =
keep
> > + * the original ordering of IMA and EVM functions as when they were ha=
rdcoded.
> > + */
> >  static int __init integrity_lsm_init(void)
> >  {
> > +	const struct lsm_id *lsmid;
> > +
> >  	iint_cache =3D
> >  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cach=
e),
> >  			      0, SLAB_PANIC, iint_init_once);
> > +	/*
> > +	 * Obtain either the IMA or EVM LSM ID to register integrity-specific
> > +	 * hooks under that LSM, since there is no LSM ID assigned to the
> > +	 * 'integrity' LSM.
> > +	 */
> > +	lsmid =3D ima_get_lsm_id();
> > +	if (!lsmid)
> > +		lsmid =3D evm_get_lsm_id();
> > +	/* No point in continuing, since both IMA and EVM are disabled. */
> > +	if (!lsmid)
> > +		return 0;
> > +
> > +	security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks), lsmi=
d);
>=20
> Ooof.  I understand, or at least I think I understand, why the above
> hack is needed, but I really don't like the idea of @integrity_hooks
> jumping between IMA and EVM depending on how the kernel is configured.
>=20
> Just to make sure I'm understanding things correctly, the "integrity"
> LSM exists to ensure the proper hook ordering between IMA/EVM, shared
> metadata management for IMA/EVM, and a little bit of a hack to solve
> some kernel module loading issues with signatures.  Is that correct?
>=20
> I see that patch 23/23 makes some nice improvements to the metadata
> management, moving them into LSM security blobs, but it appears that
> they are still shared, and thus the requirement is still there for
> an "integrity" LSM to manage the shared blobs.

Yes, all is correct.

> I'd like to hear everyone's honest opinion on this next question: do
> we have any hope of separating IMA and EVM so they are independent
> (ignore the ordering issues for a moment), or are we always going to
> need to have the "integrity" LSM to manage shared resources, hooks,
> etc.?

I think it should not be technically difficult to do it. But, it would
be very important to understand all the implications of doing those
changes.

Sorry, for now I don't see an immediate need to do that, other than
solving this LSM naming issue. I tried to find the best solution I
could.

Thanks

Roberto

> >  	init_ima_lsm();
> >  	init_evm_lsm();
> >  	return 0;
>=20
> --
> paul-moore.com


