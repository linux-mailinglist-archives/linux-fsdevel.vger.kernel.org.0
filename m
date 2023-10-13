Return-Path: <linux-fsdevel+bounces-243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA727C7EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 09:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B020B20A30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0F101EB;
	Fri, 13 Oct 2023 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343BD51F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 07:39:05 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2EB8;
	Fri, 13 Oct 2023 00:39:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S6J2l2TKpz9xrtb;
	Fri, 13 Oct 2023 15:26:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3Q5Tr8yhlfkQgAg--.14800S2;
	Fri, 13 Oct 2023 08:38:32 +0100 (CET)
Message-ID: <893bc5837fea4395bfb19e35097810ec7e425917.camel@huaweicloud.com>
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
Date: Fri, 13 Oct 2023 09:38:16 +0200
In-Reply-To: <102b06b30518ac6595022e079de92717c92f3b8e.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
	 <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
	 <b51baf7741de1fdee8b36a87bd2dde71184d47a8.camel@huaweicloud.com>
	 <8646e30b0074a2932076b5a0a792b14be034de98.camel@linux.ibm.com>
	 <16c8c95f2e63ab9a2fba8cba919bf129d0541b61.camel@huaweicloud.com>
	 <c16551704db68c6e0ba89c729c892e9401f05dfc.camel@linux.ibm.com>
	 <2336abd6ae195eda221d54e3c2349a4760afaff2.camel@huaweicloud.com>
	 <84cfe4d93cb5b02591f4bd921b828eb6f3e95faa.camel@linux.ibm.com>
	 <4866a6ef46deebf9a9afdeb7efd600edb589da93.camel@huaweicloud.com>
	 <102b06b30518ac6595022e079de92717c92f3b8e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3Q5Tr8yhlfkQgAg--.14800S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr45AFW8ZFyDGF45GrWxZwb_yoW8GF4kpr
	W09a47KwsrJr15ur10va1Fqr4Fka13JFW5XrWrtr17A34qkryFqF4jkr1Yka1kGrW8G3Wa
	vF4UJ3s7Wr15ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj5D5TgABsY
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 13:10 -0400, Mimi Zohar wrote:
> > > > > > We need to make sure that ima_post_path_mknod() has the
> > > > > > same parameters
> > > > > > as the LSM hook at the time we register it to the LSM
> > > > > > infrastructure.
> > > > >=20
> > > > > I'm trying to understand why the pre hook parameters and the
> > > > > missing
> > > > > IMA parameter are used, as opposed to just defining the new
> > > > > post_path_mknod hook like IMA.
> > > >=20
> > > > As an empyrical rule, I pass the same parameters as the
> > > > corresponding
> > > > pre hook (plus idmap, in this case). This is similar to the
> > > > inode_setxattr hook. But I can be wrong, if desired I can
> > > > reduce.
> > >=20
> > > The inode_setxattr hook change example is legitimate, as EVM
> > > includes
> > > idmap, while IMA doesn't.=20
> > >=20
> > > Unless there is a good reason for the additional parameters, I'm
> > > not
> > > sure that adding them makes sense.  Not modifying the parameter
> > > list
> > > will reduce the size of this patch set.
> >=20
> > The hook is going to be used by any LSM. Without knowing all the
> > possible use cases, maybe it is better to include more information
> > now,
> > than modifying the hook and respective implementations later.
> >=20
> > (again, no problem to reduce)
>=20
> Unless there is a known use case for a specific parameter, please
> minimize them.   Additional parameters can be added later as needed.=20

Ok. I did the same for inode_post_create_tmpfile.

Thanks

Roberto


