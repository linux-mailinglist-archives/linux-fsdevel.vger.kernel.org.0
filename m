Return-Path: <linux-fsdevel+bounces-37815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA869F7EC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17AF189446F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE4226552;
	Thu, 19 Dec 2024 15:59:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4453D3B8;
	Thu, 19 Dec 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623957; cv=none; b=T6s7oV8vOjWGoyXWFRAkcNwbBaMzoz5HLBxrmD9cUyWAdOMtQ71bCJluR183h1bZ5iOfj18xIDfrCIyXVI6Hw39cjqgxoHsskv+AOdffg6DKuC8PnymooB1tWmT/omaNibYrBj+wYTKNrAs0UQngTkUFucPCNM7k0K7WcJxnVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623957; c=relaxed/simple;
	bh=ju2mr1duQXKgCD16dzig3TiPnyKVJiihG96mICQIInI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0frv3K91hOnpwz5WADDsqZ+nZrRMWNKQ5sPxVT4UPqtMe+sgIje6ySGKaEcqw9zh7Jl+J7IUEJJbQTjV68jIoBfNg9K49PNU/4CgxTSecMLGMUu16PfAaMyHVnDWIN9mXbiidfcrgik6GL7LhQmIKXpcJsEQBtIZ/bzlPsVlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4YDZ312xl9z9v7NX;
	Thu, 19 Dec 2024 23:19:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 56268140FD0;
	Thu, 19 Dec 2024 23:40:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAX1zd0PmRnk++5Aw--.39435S2;
	Thu, 19 Dec 2024 16:40:49 +0100 (CET)
Message-ID: <ac0d0d8f3d40ec3f7279f3ece0e75d0b2ec32b4e.camel@huaweicloud.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Song Liu <songliubraving@meta.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>, 
	"linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "roberto.sassu@huawei.com"
	 <roberto.sassu@huawei.com>, "dmitry.kasatkin@gmail.com"
	 <dmitry.kasatkin@gmail.com>, "eric.snowberg@oracle.com"
	 <eric.snowberg@oracle.com>, "paul@paul-moore.com" <paul@paul-moore.com>, 
	"jmorris@namei.org"
	 <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, Kernel Team
	 <kernel-team@meta.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz"
	 <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Date: Thu, 19 Dec 2024 16:40:32 +0100
In-Reply-To: <C01F96FE-0E0F-46B1-A50C-42E83543B9E1@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
	 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
	 <bd5a5029302bc05c2fbe3ee716abb644c568da48.camel@linux.ibm.com>
	 <C01F96FE-0E0F-46B1-A50C-42E83543B9E1@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAX1zd0PmRnk++5Aw--.39435S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43GFWxJFW3Xr4DAFWDJwb_yoW8uF17pr
	WxJFW7tr4vqa40yw1Iyw43uryFv3s7Kan8Kry5Ww1xZa45Cr18tr1Ikry8uaykurn7JFyY
	vFnxXFyq93WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBGdjhLgFFAAAsu

On Wed, 2024-12-18 at 17:07 +0000, Song Liu wrote:
> Hi Mimi,=20
>=20
> Thanks for your comments!
>=20
> > On Dec 18, 2024, at 3:02=E2=80=AFAM, Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> >=20
> > On Tue, 2024-12-17 at 13:29 -0800, Casey Schaufler wrote:
> > > On 12/17/2024 12:25 PM, Song Liu wrote:
> > > > While reading and testing LSM code, I found IMA/EVM consume per ino=
de
> > > > storage even when they are not in use. Add options to diable them i=
n
> > > > kernel command line. The logic and syntax is mostly borrowed from a=
n
> > > > old serious [1].
> > >=20
> > > Why not omit ima and evm from the lsm=3D parameter?
> >=20
> > Casey, Paul, always enabling IMA & EVM as the last LSMs, if configured,=
 were the
> > conditions for making IMA and EVM LSMs.  Up to that point, only when an=
 inode
> > was in policy did it consume any memory (rbtree).  I'm pretty sure you =
remember
> > the rather heated discussion(s).
>=20
> I didn't know about this history until today. I apologize if this=20
> RFC/PATCH is moving to the direction against the original agreement.=20
> I didn't mean to break any agreement.=20
>=20
> My motivation is actually the per inode memory consumption of IMA=20
> and EVM. Once enabled, EVM appends a whole struct evm_iint_cache to=20
> each inode via i_security. IMA is better on memory consumption, as=20
> it only adds a pointer to i_security.=20
>=20
> It appears to me that a way to disable IMA and EVM at boot time can=20
> be useful, especially for distro kernels. But I guess there are=20
> reasons to not allow this (thus the earlier agreement). Could you=20
> please share your thoughts on this?

Hi Song

IMA/EVM cannot be always disabled for two reasons: (1) for secure and
trusted boot, IMA is expected to enforce architecture-specific
policies; (2) accidentally disabling them will cause modified files to
be rejected when IMA/EVM are turned on again.

If the requirements above are met, we are fine on disabling IMA/EVM.

As for reserving space in the inode security blob, please refer to this
discussion, where we reached the agreement:

https://lore.kernel.org/linux-integrity/CAHC9VhTTKac1o=3DRnQadu2xqdeKH8C_F+=
Wh4sY=3DHkGbCArwc8JQ@mail.gmail.com/

Thanks

Roberto


