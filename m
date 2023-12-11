Return-Path: <linux-fsdevel+bounces-5501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37880CEC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CE01F21813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB94A984;
	Mon, 11 Dec 2023 14:56:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533528E;
	Mon, 11 Dec 2023 06:56:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Spkx31B9fz9xrpQ;
	Mon, 11 Dec 2023 22:42:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 2D5B1140429;
	Mon, 11 Dec 2023 22:56:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3c3MKI3dlUupYAg--.22303S2;
	Mon, 11 Dec 2023 15:56:23 +0100 (CET)
Message-ID: <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>,  Seth Forshee <sforshee@kernel.org>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zohar@linux.ibm.com, paul@paul-moore.com, 
 stefanb@linux.ibm.com, jlayton@kernel.org, linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 11 Dec 2023 15:56:06 +0100
In-Reply-To: <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
	 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
	 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3c3MKI3dlUupYAg--.22303S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4DXryktF4rGF1ftw1DZFb_yoWrZFW3pF
	WYka4UKrs8Jr17uwnavF47Xa40y3yrJa1UXwn8Jrn5AFWDXF1IgrWxt3WUuasrXF1kX34j
	q3yjk34fZ3s8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5N17wAAs2

On Fri, 2023-12-08 at 23:01 +0100, Christian Brauner wrote:
> On Fri, Dec 08, 2023 at 11:55:19PM +0200, Amir Goldstein wrote:
> > On Fri, Dec 8, 2023 at 7:25=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >=20
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > EVM updates the HMAC in security.evm whenever there is a setxattr or
> > > removexattr operation on one of its protected xattrs (e.g. security.i=
ma).
> > >=20
> > > Unfortunately, since overlayfs redirects those xattrs operations on t=
he
> > > lower filesystem, the EVM HMAC cannot be calculated reliably, since l=
ower
> > > inode attributes on which the HMAC is calculated are different from u=
pper
> > > inode attributes (for example i_generation and s_uuid).
> > >=20
> > > Although maybe it is possible to align such attributes between the lo=
wer
> > > and the upper inode, another idea is to map security.evm to another n=
ame
> > > (security.evm_overlayfs)
> >=20
> > If we were to accept this solution, this will need to be trusted.overla=
y.evm
> > to properly support private overlay xattr escaping.
> >=20
> > > during an xattr operation, so that it does not
> > > collide with security.evm set by the lower filesystem.
> >=20
> > You are using wrong terminology and it is very confusing to me.
>=20
> Same.

Argh, sorry...

> > see the overlay mount command has lowerdir=3D and upperdir=3D.
> > Seems that you are using lower filesystem to refer to the upper fs
> > and upper filesystem to refer to overlayfs.
> >=20
> > >=20
> > > Whenever overlayfs wants to set security.evm, it is actually setting
> > > security.evm_overlayfs calculated with the upper inode attributes. Th=
e
> > > lower filesystem continues to update security.evm.
> > >=20
> >=20
> > I understand why that works, but I am having a hard time swallowing
> > the solution, mainly because I feel that there are other issues on the
> > intersection of overlayfs and IMA and I don't feel confident that this
> > addresses them all.

This solution is specifically for the collisions on HMACs, nothing
else. Does not interfere/solve any other problem.

> > If you want to try to convince me, please try to write a complete
> > model of how IMA/EVM works with overlayfs, using the section
> > "Permission model" in Documentation/filesystems/overlayfs.rst
> > as a reference.

Ok, I will try.

I explain first how EVM works in general, and then why EVM does not
work with overlayfs.

EVM gets called before there is a set/removexattr operation, and after,
if that operation is successful. Before the set/removexattr operation
EVM calculates the HMAC on current inode metadata (i_ino, i_generation,
i_uid, i_gid, i_mode, POSIX ACLs, protected xattrs). Finally, it
compares the calculated HMAC with the one in security.evm.

If the verification and the set/removexattr operation are successful,
EVM calculates again the HMAC (in the post hooks) based on the updated
inode metadata, and sets security.evm with the new HMAC.

The problem is the combination of: overlayfs inodes have different
metadata than the lower/upper inodes; overlayfs calls the VFS to
set/remove xattrs.

The first problem basically means the HMAC on lower/upper inodes and
overlayfs ones is different.

The second problem is that one security.evm is not enough. We need two,
to store the two different HMACs. And we need both at the same time,
since when overlayfs is mounted the lower/upper directories can be
still accessible.

In the example I described, IMA tries to update security.ima, but this
causes EVM to attempt updating security.evm twice (once after the upper
filesystem performed the setxattr requested by overlayfs, another after
overlayfs performed the setxattr requested by IMA; the latter fails
since EVM does not allow the VFS to directly update the HMAC).

Remapping security.evm to security.evm_overlayfs (now
trusted.overlay.evm) allows us to store both HMACs separately and to
know which one to use.

I just realized that the new xattr name should be public, because EVM
rejects HMAC updates, so we should reject HMAC updates based on the new
xattr name too.

> I want us to go the other way. Make the overlayfs layer completely
> irrelevant for EVM and IMA. See a related discussion here:

Not sure it is possible, as long as overlayfs uses VFS xattr calls.

> Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
> https://lore.kernel.org/r/ZXHZ8uNEg1IK5WMW@do-x1extreme

I will also read this patch, in case I missed something.

Thanks

Roberto


