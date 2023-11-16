Return-Path: <linux-fsdevel+bounces-2949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA187EDDF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D4D1F23F00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87328E38;
	Thu, 16 Nov 2023 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B7196;
	Thu, 16 Nov 2023 01:47:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SWFBf6RNHz9v7cG;
	Thu, 16 Nov 2023 17:30:34 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHuGHy5FVlZM3CAA--.37379S2;
	Thu, 16 Nov 2023 10:46:39 +0100 (CET)
Message-ID: <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
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
Date: Thu, 16 Nov 2023 10:46:24 +0100
In-Reply-To: <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com>
References: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
	 <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAHuGHy5FVlZM3CAA--.37379S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DtryfZw48JrWfKF13twb_yoW8Ar15pF
	Z8t3W5KFWUtF17Grn3AFsF9a4rKrZ3Kr17ZFZagr10qrnxZr95KF42kFWY9r4DJrs7Ary0
	ga12gry3WryDZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5KGKgABsL
X-CFilter-Loop: Reflected

On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > In preparation for moving IMA and EVM to the LSM infrastructure, introd=
uce
> > the file_pre_free_security hook.
> >=20
> > IMA calculates at file close the new digest of the file content and wri=
tes
> > it to security.ima, so that appraisal at next file access succeeds.
> >=20
> > LSMs could also take some action before the last reference of a file is
> > released.
> >=20
> > The new hook cannot return an error and cannot cause the operation to b=
e
> > reverted.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  fs/file_table.c               |  1 +
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  4 ++++
> >  security/security.c           | 11 +++++++++++
> >  4 files changed, 17 insertions(+)
> >=20
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index de4a2915bfd4..64ed74555e64 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -385,6 +385,7 @@ static void __fput(struct file *file)
> >  	eventpoll_release(file);
> >  	locks_remove_file(file);
> > =20
> > +	security_file_pre_free(file);
>=20
> I worry that security_file_pre_free() is a misleading name as "free"
> tends to imply memory management tasks, which isn't the main focus of
> this hook.  What do you think of security_file_release() or
> security_file_put() instead?

security_file_release() would be fine for me.

Thanks

Roberto

> >  	ima_file_free(file);
> >  	if (unlikely(file->f_flags & FASYNC)) {
> >  		if (file->f_op->fasync)
>=20
> --
> paul-moore.com


