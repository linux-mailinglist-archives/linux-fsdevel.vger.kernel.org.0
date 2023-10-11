Return-Path: <linux-fsdevel+bounces-83-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617877C585E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602591C20A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F1208D8;
	Wed, 11 Oct 2023 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D810951
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:57 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C468F;
	Wed, 11 Oct 2023 08:43:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S5Gv93w7mz9yGdg;
	Wed, 11 Oct 2023 23:31:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX8JGOwiZl4p0FAg--.29227S2;
	Wed, 11 Oct 2023 16:43:25 +0100 (CET)
Message-ID: <b9e204c1b34c204133059b87a9a307ae5bccb84b.camel@huaweicloud.com>
Subject: Re: [PATCH v3 04/25] ima: Align ima_file_mprotect() definition with
 LSM infrastructure
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
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan
 Berger <stefanb@linux.ibm.com>
Date: Wed, 11 Oct 2023 17:43:07 +0200
In-Reply-To: <443fb4da33eb0ac51a580e8fd51fa271a59172ef.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-5-roberto.sassu@huaweicloud.com>
	 <443fb4da33eb0ac51a580e8fd51fa271a59172ef.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCX8JGOwiZl4p0FAg--.29227S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1ftrW5Xr45Kr13urW7Jwb_yoW5Kr4DpF
	s8Ka47GrWxJFy09ryIqa47ua43K3yIgw1UXa9Ig34Sy3WqqFnYqr13JF18ur1Fyr9YkF1I
	vay7tay3A3WqyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5TqEAAAsd
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 10:51 -0400, Mimi Zohar wrote:
> On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Change ima_file_mprotect() definition, so that it can be registered
> > as implementation of the file_mprotect hook.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  include/linux/ima.h               | 5 +++--
> >  security/integrity/ima/ima_main.c | 6 ++++--
> >  security/security.c               | 2 +-
> >  3 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 893c3b98b4d0..56e72c0beb96 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -24,7 +24,8 @@ extern void ima_post_create_tmpfile(struct mnt_idmap =
*idmap,
> >  extern void ima_file_free(struct file *file);
> >  extern int ima_file_mmap(struct file *file, unsigned long reqprot,
> >  			 unsigned long prot, unsigned long flags);
> > -extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long=
 prot);
> > +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqpro=
t,
> > +		      unsigned long prot);
>=20
> "extern" is needed here and similarly in 5/25.

I removed because of a complain from checkpatch.pl --strict.

Roberto

> Mimi
>=20
> >  extern int ima_load_data(enum kernel_load_data_id id, bool contents);
> >  extern int ima_post_load_data(char *buf, loff_t size,
> >  			      enum kernel_load_data_id id, char *description);
> > @@ -88,7 +89,7 @@ static inline int ima_file_mmap(struct file *file, un=
signed long reqprot,
> >  }
> > =20
> >  static inline int ima_file_mprotect(struct vm_area_struct *vma,
> > -				    unsigned long prot)
> > +				    unsigned long reqprot, unsigned long prot)
> >  {
> >  	return 0;
> >  }
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 52e742d32f4b..e9e2a3ad25a1 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -441,7 +441,8 @@ int ima_file_mmap(struct file *file, unsigned long =
reqprot,
> >  /**
> >   * ima_file_mprotect - based on policy, limit mprotect change
> >   * @vma: vm_area_struct protection is set to
> > - * @prot: contains the protection that will be applied by the kernel.
> > + * @reqprot: protection requested by the application
> > + * @prot: protection that will be applied by the kernel
> >   *
> >   * Files can be mmap'ed read/write and later changed to execute to cir=
cumvent
> >   * IMA's mmap appraisal policy rules.  Due to locking issues (mmap sem=
aphore
> > @@ -451,7 +452,8 @@ int ima_file_mmap(struct file *file, unsigned long =
reqprot,
> >   *
> >   * On mprotect change success, return 0.  On failure, return -EACESS.
> >   */
> > -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> > +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqpro=
t,
> > +		      unsigned long prot)
> >  {
> >  	struct ima_template_desc *template =3D NULL;
> >  	struct file *file;
> > diff --git a/security/security.c b/security/security.c
> > index 96f2c68a1571..dffb67e6e119 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2721,7 +2721,7 @@ int security_file_mprotect(struct vm_area_struct =
*vma, unsigned long reqprot,
> >  	ret =3D call_int_hook(file_mprotect, 0, vma, reqprot, prot);
> >  	if (ret)
> >  		return ret;
> > -	return ima_file_mprotect(vma, prot);
> > +	return ima_file_mprotect(vma, reqprot, prot);
> >  }
> > =20
> >  /**
>=20


