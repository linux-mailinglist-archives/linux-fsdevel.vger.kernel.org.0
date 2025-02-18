Return-Path: <linux-fsdevel+bounces-41932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FBA392B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4383B4473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DB1ADC7B;
	Tue, 18 Feb 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="B1+pufK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200D1B0F1B;
	Tue, 18 Feb 2025 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856720; cv=none; b=Sn4Rvp77b16ppaGv61KpXrvsIbvaQKda6peNTc5Dv12Qphd6QAxyYqhen6ojVe7kD06LmpnBkCztzrWY5lisyvF/PdpePqZ8AYzvIYloEu7A7diRU4irrwUbki9Foch1QZJSD1fiCNtrR6FmKzFNxfZPo38tQkyB0sMpRU92Fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856720; c=relaxed/simple;
	bh=N11rjZzQiPEGSuCFU/tAqCmoIAHIAapy31wGHVuHjy0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=urI0xLArFWkTFyoRugGw7rtJw6QSDMxGXGy1db0p2R7jpahLT4mMy8apinjD6yORNnjSaaQkiaQTOY8iwF30ezCGLZWdSpH4SmLtGSwvHp4RNvop9P1XtkTUl1FE1YA3LbbYEDz/I+ShSTP15YBxqy/BhJecnstev4/Arrj1f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=B1+pufK6; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1739856675;
	bh=6nOzRc7JIVCoDeQJNl87XUoLBfr5fYT3xhwLlXDG9lc=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=B1+pufK6Uao+P+ZmDtc/mwbZBpVOD7Ib1vz7J3hWjthVwhpdQpSdB3y8XAJHHzF7J
	 n6fVfdXeOzw7VPEcT2GTa6a+Y96K0GnmVU3psS9oZJBIiOHrtO9UHSC9Al8/3/Oh8M
	 RGxZ4zWjVsQDZukg6/NwbjwNapjrVikdhyA2wMD8=
X-QQ-mid: bizesmtpsz14t1739856674telcus
X-QQ-Originating-IP: uMIN2FVAr8RZaHlv4AxeTxpSEJi2qrgc1Yy/V/gvurg=
Received: from smtpclient.apple ( [202.120.235.89])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 13:31:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14077222618784810693
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] fs/ntfs3: Update inode->i_mapping->a_ops on
 compression state
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>
Date: Tue, 18 Feb 2025 13:31:02 +0800
Cc: ntfs3@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <92E4BFBF-FB12-4B70-9E86-AF9255EAB0C4@m.fudan.edu.cn>
References: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
 <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAL61fhe2h5S4tPpETU3npnGh+GkQJVQomLsEzRzvVJ4ibRRRIqpw+I9
	fXvmh6ogIagknFwQjmZ6pLhQmoGoXycdA2e78mk0GmJoTSjnLMDSRXIs1H/WzZCR+LMrwKS
	JegYpu83de4vnYXzdA9DwRNLBmTPeNRWQ5K76wOGMoBkneudcePfwDxs8SuFeBI5fnUBsVO
	kw+GCtFKHyXkdhF3KKovBLVntIz1Z5ug44s9pYV29zDzvnbMN61NiX19JKOmzlRW00+VcQp
	ANU4bLTXxolhKvVYJAOooKTQSCAKWaoNnKdiScJrqx/+1hGcAzQutMjKL0oAB0IYUA4NrWy
	bWC+5h6ErIib/beIHd3Q2zRe9QVx5yv24/yabw66HvgSIB1UgKQbagrTsW4nwVChcmUx080
	OKnZ9RGw5odq7YwxuJgbohZoAWi2wZATJ5LHPhsxtxGgcoiMvv/6qDWce28y5qcYASwbaOU
	wSOzWQ8LVpNNkti6GrvuZ1alcqVUxGRvIhjbxd0TG8qM4Sp9ub5/Ht7MIN12SStXJ5qPXdP
	YJoFt/ZsCu2YCNtoM6D2Hm6sdoVHKH2i6V7F26T5MW46BCZkZRrP+dlpZDgUuiwOGIz+S0h
	CHwVSyf7hosH28sLcQjB9BYqTPnO/ij1f0MIl48nmDuR8NjGuwefI8uDOJJCWmO8DMLKz5T
	rwHh0gt7kY4HkaMmnUqvSDIhYl0y5lTyi2aD8DxCNbklVaSYbqIObeweI2GHZtU1PTWMt3P
	vRlQzydzQsjjBaVNetoqWaYssWum6+iTKQ78xPgT4vyvGJaIC5+ZEJRILfQsih3ZKTnhIma
	kxNBJC1GvVOonN9BbXn5WhfvYoJzUVjtZR+TI5mk2/QOu890ih1TSgXDWDnqdd/bAPXI3j/
	ZUJ2QsdJ+Bd8FjvWVwbQvIPJmq7RIJZYSvLKD9IBnHJSjjFH3zrExyCYBPIA6qZclu5U1G+
	pBpjTp6RnHz1QnkyDzEpebEI3eSuBRHuYDK8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=8831=E6=97=A5 21:18=EF=BC=8CKonstantin Komarov =
<almaz.alexandrovich@paragon-software.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Update inode->i_mapping->a_ops when the compression state changes to
> ensure correct address space operations.
> Clear ATTR_FLAG_SPARSED/FILE_ATTRIBUTE_SPARSE_FILE when enabling
> compression to prevent flag conflicts.
>=20
> v2:
> Additionally, ensure that all dirty pages are flushed and concurrent =
access
> to the page cache is blocked.
>=20
> Fixes: 6b39bfaeec44 ("fs/ntfs3: Add support for the compression =
attribute")
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>
> Signed-off-by: Konstantin Komarov =
<almaz.alexandrovich@paragon-software.com>
> ---
> fs/ntfs3/attrib.c  |  3 ++-
> fs/ntfs3/file.c    | 22 ++++++++++++++++++++--
> fs/ntfs3/frecord.c |  6 ++++--
> 3 files changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index af94e3737470..e946f75eb540 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -2664,8 +2664,9 @@ int attr_set_compress(struct ntfs_inode *ni, =
bool compr)
> attr->nres.run_off =3D cpu_to_le16(run_off);
> }
>=20
> - /* Update data attribute flags. */
> + /* Update attribute flags. */
> if (compr) {
> + attr->flags &=3D ~ATTR_FLAG_SPARSED;
> attr->flags |=3D ATTR_FLAG_COMPRESSED;
> attr->nres.c_unit =3D NTFS_LZNT_CUNIT;
> } else {
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 4d9d84cc3c6f..9b6a3f8d2e7c 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -101,8 +101,26 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, =
struct dentry *dentry,
> /* Allowed to change compression for empty files and for directories =
only. */
> if (!is_dedup(ni) && !is_encrypted(ni) &&
>    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> - /* Change compress state. */
> - int err =3D ni_set_compress(inode, flags & FS_COMPR_FL);
> + int err =3D 0;
> + struct address_space *mapping =3D inode->i_mapping;
> +
> + /* write out all data and wait. */
> + filemap_invalidate_lock(mapping);
> + err =3D filemap_write_and_wait(mapping);
> +
> + if (err >=3D 0) {
> + /* Change compress state. */
> + bool compr =3D flags & FS_COMPR_FL;
> + err =3D ni_set_compress(inode, compr);
> +
> + /* For files change a_ops too. */
> + if (!err)
> + mapping->a_ops =3D compr ? &ntfs_aops_cmpr :
> + &ntfs_aops;
> + }
> +
> + filemap_invalidate_unlock(mapping);
> +
> if (err)
> return err;
> }
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 5df6a0b5add9..81271196c557 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -3434,10 +3434,12 @@ int ni_set_compress(struct inode *inode, bool =
compr)
> }
>=20
> ni->std_fa =3D std->fa;
> - if (compr)
> + if (compr) {
> + std->fa &=3D ~FILE_ATTRIBUTE_SPARSE_FILE;
> std->fa |=3D FILE_ATTRIBUTE_COMPRESSED;
> - else
> + } else {
> std->fa &=3D ~FILE_ATTRIBUTE_COMPRESSED;
> + }
>=20
> if (ni->std_fa !=3D std->fa) {
> ni->std_fa =3D std->fa;
> --=20
> 2.34.1
>=20
>=20

Hi Konstantin,

I wanted to follow up as I haven=E2=80=99t yet seen the fix you =
provided, titled =E2=80=9C[v2] fs/ntfs3: Update inode->i_mapping->a_ops =
on compression state=E2=80=9D in the kernel tree. Could you kindly =
confirm if this resolves the issue we=E2=80=99ve been discussing? =
Additionally, I would greatly appreciate it if you could share any =
updates regarding the resolution of this matter.

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu


