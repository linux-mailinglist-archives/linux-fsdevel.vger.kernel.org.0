Return-Path: <linux-fsdevel+bounces-13887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CC875204
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B67AB2617F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D212BE97;
	Thu,  7 Mar 2024 14:36:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E941C65;
	Thu,  7 Mar 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822205; cv=none; b=g7B2k/su1VDiRVUmy1+yzIa55goG7MeKx7TmEB8iFYpcmSrwdw2BKG85w3IV9vgxO+WXysoM9wPa2n9vegO1WNhNtzc1FrojK3t2is0PZNVXpWVrL+RSZNIsMEX7uGb1P0dmGguogzCsYmnvS3AnBlpNptBmDrQAm2xUkvdJyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822205; c=relaxed/simple;
	bh=fBgd/xX7Uh3OPchqwmFNdogp9X5rg4dHxjtoKMkjoqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ehuXXjYUDTO6ExlxOwqnoxybXWhfB9uOBzfQogqlM8jreWd+CT1NA+3avsyHyv7r0k+pZY1hGdbcLCwzmvPahqpk25N8I7R8pIHrDKBV5KAdO6TdoPsW33yBBkRG7p5/DhqW8tutZkv1Vfmoc30o9s8q4a1HdZaAObGwnPqV9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TrBFK1KkJz9xFrK;
	Thu,  7 Mar 2024 22:16:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9CC6B14061B;
	Thu,  7 Mar 2024 22:36:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHvhfi0OllmZnkAw--.17428S2;
	Thu, 07 Mar 2024 15:36:29 +0100 (CET)
Message-ID: <5a08af42118541c87ce0b173d03217c3623adce2.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: Change vfs_getxattr() with __vfs_getxattr() in
 evm_calc_hmac_or_hash()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Seth Forshee <sforshee@kernel.org>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,  stable@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Date: Thu, 07 Mar 2024 15:36:14 +0100
In-Reply-To: <ZenPtCfh6CyD2xz5@do-x1extreme>
References: <20240307122240.3560688-1-roberto.sassu@huaweicloud.com>
	 <ZenPtCfh6CyD2xz5@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHvhfi0OllmZnkAw--.17428S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWkZFyrZryUuw43ZFy3twb_yoW8tr1fpF
	WYkanrKrn5Jry5Cas5GF4DAayF93y5Xr4jkrsFv340v3ZrXrn7Zr93Wr13uryF9r1xtwn5
	tw4qqFyYywnxA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5cYAAAAs3

On Thu, 2024-03-07 at 08:31 -0600, Seth Forshee wrote:
> On Thu, Mar 07, 2024 at 01:22:39PM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Use __vfs_getxattr() instead of vfs_getxattr(), in preparation for
> > deprecating using the vfs_ interfaces for retrieving fscaps.
> >=20
> > __vfs_getxattr() is only used for debugging purposes, to check if kerne=
l
> > space and user space see the same xattr value.
>=20
> __vfs_getxattr() won't give you the value as seen by userspace though.
> Userspace goes through vfs_getxattr() -> xattr_getsecurity() ->
> cap_inode_getsecurity(), which does the conversion to the value
> userspace sees. __vfs_getxattr() just gives the raw disk data.
>=20
> I'm also currently working on changes to my fscaps series that will make
> it so that __vfs_getxattr() also cannot be used to read fscaps xattrs.
> I'll fix this and other code in EVM which will be broken by that change
> as part of the next version too.

You are right, thank you!

Roberto

> >=20
> > Cc: stable@vger.kernel.org # 5.14.x
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > Fixes: 907a399de7b0 ("evm: Check xattr size discrepancy between kernel =
and user")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/evm/evm_crypto.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/e=
vm/evm_crypto.c
> > index b1ffd4cc0b44..168d98c63513 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -278,8 +278,8 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
> >  		if (size < 0)
> >  			continue;
> > =20
> > -		user_space_size =3D vfs_getxattr(&nop_mnt_idmap, dentry,
> > -					       xattr->name, NULL, 0);
> > +		user_space_size =3D __vfs_getxattr(dentry, inode, xattr->name,
> > +						 NULL, 0);
> >  		if (user_space_size !=3D size)
> >  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n"=
,
> >  				 dentry->d_name.name, xattr->name, size,
> > --=20
> > 2.34.1
> >=20


