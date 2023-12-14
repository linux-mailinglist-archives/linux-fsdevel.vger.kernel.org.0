Return-Path: <linux-fsdevel+bounces-6071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924EC8131E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E2F1C21A9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774456B8C;
	Thu, 14 Dec 2023 13:43:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3A123;
	Thu, 14 Dec 2023 05:43:04 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SrY512nMhz9xHMk;
	Thu, 14 Dec 2023 21:25:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 230CB140380;
	Thu, 14 Dec 2023 21:43:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAH9XRXBntlq8WIAg--.2939S2;
	Thu, 14 Dec 2023 14:43:00 +0100 (CET)
Message-ID: <d6b43b5780770637a724d129c22d5212860f494a.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Seth Forshee
 <sforshee@kernel.org>,  miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  paul@paul-moore.com, stefanb@linux.ibm.com,
 jlayton@kernel.org,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>, Eric Snowberg
 <eric.snowberg@oracle.com>
Date: Thu, 14 Dec 2023 14:42:44 +0100
In-Reply-To: <a9297cc1bf23e34aba3c7597681e9e71a03b37f9.camel@linux.ibm.com>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
	 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
	 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
	 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
	 <20231211-fortziehen-basen-b8c0639044b8@brauner>
	 <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
	 <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
	 <59bf3530-2a6e-4caa-ac42-4d0dab9a71d1@huaweicloud.com>
	 <a9297cc1bf23e34aba3c7597681e9e71a03b37f9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAH9XRXBntlq8WIAg--.2939S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw18tF1fWry8JFWkGF4xXrb_yoWxGr1kpr
	W5KFy5KFn8JF17Jw4ay3W7WaySvrW5GF1UWwn8Xw1DCFyq9FnIkrWayr45CFy7JF18Xw40
	ya1Iy3srZr98Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5OlhwABsM

On Tue, 2023-12-12 at 10:27 -0500, Mimi Zohar wrote:
> On Tue, 2023-12-12 at 14:13 +0100, Roberto Sassu wrote:
> > On 12.12.23 11:44, Amir Goldstein wrote:
> > > On Tue, Dec 12, 2023 at 12:25=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > On 11.12.23 19:01, Christian Brauner wrote:
> > > > > > The second problem is that one security.evm is not enough. We n=
eed two,
> > > > > > to store the two different HMACs. And we need both at the same =
time,
> > > > > > since when overlayfs is mounted the lower/upper directories can=
 be
> > > > > > still accessible.
> > > > >=20
> > > > > "Changes to the underlying filesystems while part of a mounted ov=
erlay
> > > > > filesystem are not allowed. If the underlying filesystem is chang=
ed, the
> > > > > behavior of the overlay is undefined, though it will not result i=
n a
> > > > > crash or deadlock."
> > > > >=20
> > > > > https://docs.kernel.org/filesystems/overlayfs.html#changes-to-und=
erlying-filesystems
> > > > >=20
> > > > > So I don't know why this would be a problem.
> > > >=20
> > > > + Eric Snowberg
> > > >=20
> > > > Ok, that would reduce the surface of attack. However, when looking =
at:
> > > >=20
> > > >        ovl: Always reevaluate the file signature for IMA
> > > >=20
> > > >        Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > > i_version")
> > > >        partially closed an IMA integrity issue when directly modify=
ing a file
> > > >        on the lower filesystem.  If the overlay file is first opene=
d by a
> > > > user
> > > >        and later the lower backing file is modified by root, but th=
e extended
> > > >        attribute is NOT updated, the signature validation succeeds =
with
> > > > the old
> > > >        original signature.
> > > >=20
> > > > Ok, so if the behavior of overlayfs is undefined if the lower backi=
ng
> > > > file is modified by root, do we need to reevaluate? Or instead woul=
d be
> > > > better to forbid the write from IMA (legitimate, I think, since the
> > > > behavior is documented)? I just saw that we have d_real_inode(), we=
 can
> > > > use it to determine if the write should be denied.
> > > >=20
> > >=20
> > > There may be several possible legitimate actions in this case, but th=
e
> > > overall concept IMO should be the same as I said about EVM -
> > > overlayfs does not need an IMA signature of its own, because it
> > > can use the IMA signature of the underlying file.
> > >=20
> > > Whether overlayfs reads a file from lower fs or upper fs, it does not
> > > matter, the only thing that matters is that the underlying file conte=
nt
> > > is attested when needed.
> > >=20
> > > The only incident that requires special attention is copy-up.
> > > This is what the security hooks security_inode_copy_up() and
> > > security_inode_copy_up_xattr() are for.
> > >=20
> > > When a file starts in state "lower" and has security.ima,evm xattrs
> > > then before a user changes the file, it is copied up to upper fs
> > > and suppose that security.ima,evm xattrs are copied as is?
>=20
> For IMA copying up security.ima is fine.  Other than EVM portable
> signatures, security.evm contains filesystem specific metadata.=20
> Copying security.evm up only works if the metadata is the same on both
> filesystems.  Currently the i_generation and i_sb->s_uuid are
> different.
>=20
> > > When later the overlayfs file content is read from the upper copy
> > > the security.ima signature should be enough to attest that file conte=
nt
> > > was not tampered with between going from "lower" to "upper".
> > >=20
> > > security.evm may need to be fixed on copy up, but that should be
> > > easy to do with the security_inode_copy_up_xattr() hook. No?
>=20
> Writing security.evm requires the existing security.evm to be valid.=20
> After each security xattr in the protected list is modified,
> security.evm HMAC needs to be updated.  Perhaps calculating and writing
> security.evm could be triggered by security_inode_copy_up_xattr().=20
> Just copying a non-portable EVM signature wouldn't work, or for that
> matter copying an EVM HMAC with different filesystem metadata.

There is another problem, when delayed copy is used. The content comes
from one source, metadata from another.

I initially created test-file-lower on the lower directory
(overlayfs/data), before mounting overlayfs. After mount on
overlayfs/mnt:

# getfattr -m - -e hex -d overlayfs/mnt/test-file-lower=20
# file: overlayfs/mnt/test-file-lower
security.evm=3D0x02c86ec91a4c0cf024537fd24347b780b90973402e
security.ima=3D0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52=
e6ccc26fd2
security.selinux=3D0x73797374656d5f753a6f626a6563745f723a756e6c6162656c6564=
5f743a733000

# chcon -t unconfined_t overlayfs/mnt/test-file-lower

After this, IMA creates an empty file in the upper directory
(overlayfs/root/data), and writes security.ima at file close.
Unfortunately, this is what is presented from overlayfs, which is not
in sync with the content.

# getfattr -m - -e hex -d overlayfs/mnt/test-file-lower=20
# file: overlayfs/mnt/test-file-lower
security.evm=3D0x021d71e7df78c36745e3b651ce29cb9f47dc301248
security.ima=3D0x04048855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485=
de0c6839a4
security.selinux=3D0x73797374656d5f753a6f626a6563745f723a756e636f6e66696e65=
645f743a733000

# sha256sum overlayfs/mnt/test-file-lower
f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  overlayfs=
/mnt/test-file-lower

# sha256sum overlayfs/root/data/test-file-lower=20
8855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4  overlayfs=
/root/data/test-file-lower (upperdir)

We would need to use the lower security.ima until the copy is made, but
at the same time we need to keep the upper valid (with all xattrs) so
that IMA can update the next time overlayfs requests that.

Roberto

> > It is not yet clear to me. EVM will be seeing the creation of a new=20
> > file, and for new files setting xattrs is already allowed.
> >=20
> > Maybe the security_inode_copy_up*() would be useful for IMA/EVM to=20
> > authorize writes by overlayfs, which would be otherwise denied to the=
=20
> > others (according to my solution).
> >=20
> > Still, would like to hear Mimi's opinion.
>=20
> Thanks Roberto for all your work and analysis.  I'm still looking at
> security_inode_copy_up_xattr().
>=20
> Mimi
>=20


