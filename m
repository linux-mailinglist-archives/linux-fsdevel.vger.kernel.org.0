Return-Path: <linux-fsdevel+bounces-179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CE7C6FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D696A282B49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C12E64A;
	Thu, 12 Oct 2023 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AA2942B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 13:50:06 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED791;
	Thu, 12 Oct 2023 06:50:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S5rKL74bYz9xyNK;
	Thu, 12 Oct 2023 21:37:10 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnPpBh+Sdls2kUAg--.18225S2;
	Thu, 12 Oct 2023 14:49:35 +0100 (CET)
Message-ID: <fc2fab2a1d3bbf3229374458b9d52d6766c19a21.camel@huaweicloud.com>
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
Date: Thu, 12 Oct 2023 15:49:18 +0200
In-Reply-To: <4c11613696d2ffd92a652c1a734d4abfc489ff40.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
	 <2026a46459563d8f5d132a099f402ddad8f06fae.camel@linux.ibm.com>
	 <e6f0e7929abda6fa6ae7ef450b6e155b420a5f5b.camel@huaweicloud.com>
	 <4c11613696d2ffd92a652c1a734d4abfc489ff40.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnPpBh+Sdls2kUAg--.18225S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4xAF4rZw4kZr1rZF1DJrb_yoW5ZFy7pF
	WYkF47GF4Dtr17Aw10va13XF4SgrZ3tr4UXr9YqryUZrnYvr1kWF42qr4F9FWUJrn5A34j
	vF17Gr9rur98AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5DzlwAAsL
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 09:35 -0400, Mimi Zohar wrote:
> On Thu, 2023-10-12 at 14:45 +0200, Roberto Sassu wrote:
> > On Thu, 2023-10-12 at 08:36 -0400, Mimi Zohar wrote:
> > > On Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > In preparation to move IMA and EVM to the LSM infrastructure, intro=
duce the
> > > > file_post_open hook. Also, export security_file_post_open() for NFS=
.
> > > >=20
> > > > It is useful for IMA to calculate the dhigest of the file content, =
and to
> > > > decide based on that digest whether the file should be made accessi=
ble to
> > > > the requesting process.
> > >=20
> > > Please remove "It is usefile for".   Perhaps something along the line=
s:
> > >=20
> > >=20
> > > Based on policy, IMA calculates the digest of the file content and
> > > decides ...
> >=20
> > Ok.
> >=20
> > > >=20
> > > > LSMs should use this hook instead of file_open, if they need to mak=
e their
> > > > decision based on an opened file (for example by inspecting the fil=
e
> > > > content). The file is not open yet in the file_open hook.
>=20
> Needing to inspect the file contents is a good example.
>=20
> > =20
> > > The security hooks were originally defined for enforcing access
> > > control.  As a result the hooks were placed before the action.  The
> > > usage of the LSM hooks is not limited to just enforcing access contro=
l
> > > these days.  For IMA/EVM to become full LSMs additional hooks are
> > > needed post action.  Other LSMs, probably non-access control ones,
> > > could similarly take some action post action, in this case successful
> > > file open.
> >=20
> > I don't know, I would not exclude LSMs to enforce access control. The
> > post action can be used to update the state, which can be used to check
> > next accesses (exactly what happens for EVM).
> >=20
> > > Having to justify the new LSM post hooks in terms of the existing LSM=
s,
> > > which enforce access control, is really annoying and makes no sense.=
=20
> > > Please don't.
> >=20
> > Well, there is a relationship between the pre and post. But if you
> > prefer, I remove this comparison.
>=20
> My comments, above, were a result of the wording of the hook
> definition, below.

Oh, ok. Actually there is a fundamental difference between this post
and the other post: this one can be reverted and can be effectively
used for access control.

Thanks

Roberto

> > > > +/**
> > > > + * security_file_post_open() - Recheck access to a file after it h=
as been opened
> > >=20
> > > The LSM post hooks aren't needed to enforce access control.   Probabl=
y
> > > better to say something along the lines of "take some action after
> > > successful file open".
> > >=20
> > > > + * @file: the file
> > > > + * @mask: access mask
> > > > + *
> > > > + * Recheck access with mask after the file has been opened. The ho=
ok is useful
> > > > + * for LSMs that require the file content to be available in order=
 to make
> > > > + * decisions.
> > >=20
> > > And reword the above accordingly.
> > >=20
> > > > + *
> > > > + * Return: Returns 0 if permission is granted.
> > > > + */
> > > > +int security_file_post_open(struct file *file, int mask)
> > > > +{
> > > > +	return call_int_hook(file_post_open, 0, file, mask);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(security_file_post_open);
> > > > +
> > > >  /**
> > > >   * security_file_truncate() - Check if truncating a file is allowe=
d
> > > >   * @file: file
> > >=20
> >=20
>=20


