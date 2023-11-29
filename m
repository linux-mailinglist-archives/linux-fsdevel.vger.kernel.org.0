Return-Path: <linux-fsdevel+bounces-4201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650377FD996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3012826A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4232189
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB89194;
	Wed, 29 Nov 2023 05:59:14 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SgLDl56bJz9yj8G;
	Wed, 29 Nov 2023 21:45:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D15BA140EF6;
	Wed, 29 Nov 2023 21:59:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXWWQ2dl9huYAQ--.12390S2;
	Wed, 29 Nov 2023 14:59:01 +0100 (CET)
Message-ID: <cf0c24ce17817e3b4fc34bc151543aa1f2921ece.camel@huaweicloud.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com,  mic@digikod.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  selinux@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Wed, 29 Nov 2023 14:58:43 +0100
In-Reply-To: <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
	 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
	 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
	 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
	 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
Content-Type: multipart/mixed; boundary="=-dQHfNo6Rgr2qySNqlTbY"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXBXWWQ2dl9huYAQ--.12390S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKry3Cw4xXFy8Xry8JryftFb_yoW7tr45pF
	W7Ka1xAr1kJry2krn2vF45urWfKrW8WFyUWrn8Gr18AF90vF1Fqr4UCryUuFyUGrWDJw10
	qr129ry7Z3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C267I2x7xF54xIwI1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC0VAYjxAxZF0Ex2Iq
	xwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4
	xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxUFl1vDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5MP1AACst

--=-dQHfNo6Rgr2qySNqlTbY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-11-29 at 13:27 +0100, Roberto Sassu wrote:
> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> > On Mon, Nov 20, 2023 at 3:16=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> > > > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote=
:
> > > > >=20
> > > > > Before the security field of kernel objects could be shared among=
 LSMs with
> > > > > the LSM stacking feature, IMA and EVM had to rely on an alternati=
ve storage
> > > > > of inode metadata. The association between inode metadata and ino=
de is
> > > > > maintained through an rbtree.
> > > > >=20
> > > > > Because of this alternative storage mechanism, there was no need =
to use
> > > > > disjoint inode metadata, so IMA and EVM today still share them.
> > > > >=20
> > > > > With the reservation mechanism offered by the LSM infrastructure,=
 the
> > > > > rbtree is no longer necessary, as each LSM could reserve a space =
in the
> > > > > security blob for each inode. However, since IMA and EVM share th=
e
> > > > > inode metadata, they cannot directly reserve the space for them.
> > > > >=20
> > > > > Instead, request from the 'integrity' LSM a space in the security=
 blob for
> > > > > the pointer of inode metadata (integrity_iint_cache structure). T=
he other
> > > > > reason for keeping the 'integrity' LSM is to preserve the origina=
l ordering
> > > > > of IMA and EVM functions as when they were hardcoded.
> > > > >=20
> > > > > Prefer reserving space for a pointer to allocating the integrity_=
iint_cache
> > > > > structure directly, as IMA would require it only for a subset of =
inodes.
> > > > > Always allocating it would cause a waste of memory.
> > > > >=20
> > > > > Introduce two primitives for getting and setting the pointer of
> > > > > integrity_iint_cache in the security blob, respectively
> > > > > integrity_inode_get_iint() and integrity_inode_set_iint(). This w=
ould make
> > > > > the code more understandable, as they directly replace rbtree ope=
rations.
> > > > >=20
> > > > > Locking is not needed, as access to inode metadata is not shared,=
 it is per
> > > > > inode.
> > > > >=20
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > ---
> > > > >  security/integrity/iint.c      | 71 +++++-----------------------=
------
> > > > >  security/integrity/integrity.h | 20 +++++++++-
> > > > >  2 files changed, 29 insertions(+), 62 deletions(-)
> > > > >=20
> > > > > diff --git a/security/integrity/iint.c b/security/integrity/iint.=
c
> > > > > index 882fde2a2607..a5edd3c70784 100644
> > > > > --- a/security/integrity/iint.c
> > > > > +++ b/security/integrity/iint.c
> > > > > @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> > > > >     return 0;
> > > > >  }
> > > > >=20
> > > > > +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init =3D {
> > > > > +   .lbs_inode =3D sizeof(struct integrity_iint_cache *),
> > > > > +};
> > > >=20
> > > > I'll admit that I'm likely missing an important detail, but is ther=
e
> > > > a reason why you couldn't stash the integrity_iint_cache struct
> > > > directly in the inode's security blob instead of the pointer?  For
> > > > example:
> > > >=20
> > > >   struct lsm_blob_sizes ... =3D {
> > > >     .lbs_inode =3D sizeof(struct integrity_iint_cache),
> > > >   };
> > > >=20
> > > >   struct integrity_iint_cache *integrity_inode_get(inode)
> > > >   {
> > > >     if (unlikely(!inode->isecurity))
> > > >       return NULL;
> > > >     return inode->i_security + integrity_blob_sizes.lbs_inode;
> > > >   }
> > >=20
> > > It would increase memory occupation. Sometimes the IMA policy
> > > encompasses a small subset of the inodes. Allocating the full
> > > integrity_iint_cache would be a waste of memory, I guess?
> >=20
> > Perhaps, but if it allows us to remove another layer of dynamic memory
> > I would argue that it may be worth the cost.  It's also worth
> > considering the size of integrity_iint_cache, while it isn't small, it
> > isn't exactly huge either.
> >=20
> > > On the other hand... (did not think fully about that) if we embed the
> > > full structure in the security blob, we already have a mutex availabl=
e
> > > to use, and we don't need to take the inode lock (?).
> >=20
> > That would be excellent, getting rid of a layer of locking would be sig=
nificant.
> >=20
> > > I'm fully convinced that we can improve the implementation
> > > significantly. I just was really hoping to go step by step and not
> > > accumulating improvements as dependency for moving IMA and EVM to the
> > > LSM infrastructure.
> >=20
> > I understand, and I agree that an iterative approach is a good idea, I
> > just want to make sure we keep things tidy from a user perspective,
> > i.e. not exposing the "integrity" LSM when it isn't required.
>=20
> Ok, I went back to it again.
>=20
> I think trying to separate integrity metadata is premature now, too
> many things at the same time.
>=20
> I started to think, does EVM really need integrity metadata or it can
> work without?
>=20
> The fact is that CONFIG_IMA=3Dn and CONFIG_EVM=3Dy is allowed, so we have
> the same problem now. What if we make IMA the one that manages
> integrity metadata, so that we can remove the 'integrity' LSM?
>=20
> So, no embedding the full structure in the security blob now, move
> integrity_inode_free() and integrity_kernel_module_request() to IMA,
> call integrity_iintcache_init() from IMA.
>=20
> EVM verification of new files would fail without IMA, but it would be
> the same now.
>=20
> Also, evm_verifyxattr() would only work with IMA, as it assumes that
> the latter creates integrity metadata and passes them as argument.
>=20
> Regarding the LSM order, I would take Casey's suggestion of introducing
> LSM_ORDER_REALLY_LAST, for EVM.

I attach the diff v5..v7.

Tests passes with both IMA and EVM enabled. I did minor tweaks to the
tests to take into account the possibility that IMA is disabled, and
tests pass also in this case.

Roberto


--=-dQHfNo6Rgr2qySNqlTbY
Content-Disposition: attachment; filename="ima_evm_lsms_v5_v7.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="ima_evm_lsms_v5_v7.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2ZzL2ZpbGVfdGFibGUuYyBiL2ZzL2ZpbGVfdGFibGUuYwppbmRleCBlNjRi
MDA1N2ZhNzIuLjA0MDFhYzk4MjgxYyAxMDA2NDQKLS0tIGEvZnMvZmlsZV90YWJsZS5jCisrKyBi
L2ZzL2ZpbGVfdGFibGUuYwpAQCAtMzg0LDcgKzM4NCw3IEBAIHN0YXRpYyB2b2lkIF9fZnB1dChz
dHJ1Y3QgZmlsZSAqZmlsZSkKIAlldmVudHBvbGxfcmVsZWFzZShmaWxlKTsKIAlsb2Nrc19yZW1v
dmVfZmlsZShmaWxlKTsKIAotCXNlY3VyaXR5X2ZpbGVfcHJlX2ZyZWUoZmlsZSk7CisJc2VjdXJp
dHlfZmlsZV9yZWxlYXNlKGZpbGUpOwogCWlmICh1bmxpa2VseShmaWxlLT5mX2ZsYWdzICYgRkFT
WU5DKSkgewogCQlpZiAoZmlsZS0+Zl9vcC0+ZmFzeW5jKQogCQkJZmlsZS0+Zl9vcC0+ZmFzeW5j
KC0xLCBmaWxlLCAwKTsKZGlmZiAtLWdpdCBhL2ZzL3hhdHRyLmMgYi9mcy94YXR0ci5jCmluZGV4
IDI2NjBiYzdlZmZkYy4uZjhiNjQzZjkxYTk4IDEwMDY0NAotLS0gYS9mcy94YXR0ci5jCisrKyBi
L2ZzL3hhdHRyLmMKQEAgLTU1Miw3ICs1NTIsNyBAQCBfX3Zmc19yZW1vdmV4YXR0cl9sb2NrZWQo
c3RydWN0IG1udF9pZG1hcCAqaWRtYXAsCiAKIAllcnJvciA9IF9fdmZzX3JlbW92ZXhhdHRyKGlk
bWFwLCBkZW50cnksIG5hbWUpOwogCWlmIChlcnJvcikKLQkJZ290byBvdXQ7CisJCXJldHVybiBl
cnJvcjsKIAogCWZzbm90aWZ5X3hhdHRyKGRlbnRyeSk7CiAJc2VjdXJpdHlfaW5vZGVfcG9zdF9y
ZW1vdmV4YXR0cihkZW50cnksIG5hbWUpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9sc21f
aG9va19kZWZzLmggYi9pbmNsdWRlL2xpbnV4L2xzbV9ob29rX2RlZnMuaAppbmRleCA5NjAxZGYx
MGVhMjguLjI2Nzk5MDVmNDI2MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9sc21faG9va19k
ZWZzLmgKKysrIGIvaW5jbHVkZS9saW51eC9sc21faG9va19kZWZzLmgKQEAgLTE4MSw3ICsxODEs
NyBAQCBMU01fSE9PSyhpbnQsIDAsIGtlcm5mc19pbml0X3NlY3VyaXR5LCBzdHJ1Y3Qga2VybmZz
X25vZGUgKmtuX2RpciwKIAkgc3RydWN0IGtlcm5mc19ub2RlICprbikKIExTTV9IT09LKGludCwg
MCwgZmlsZV9wZXJtaXNzaW9uLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IG1hc2spCiBMU01fSE9P
SyhpbnQsIDAsIGZpbGVfYWxsb2Nfc2VjdXJpdHksIHN0cnVjdCBmaWxlICpmaWxlKQotTFNNX0hP
T0sodm9pZCwgTFNNX1JFVF9WT0lELCBmaWxlX3ByZV9mcmVlX3NlY3VyaXR5LCBzdHJ1Y3QgZmls
ZSAqZmlsZSkKK0xTTV9IT09LKHZvaWQsIExTTV9SRVRfVk9JRCwgZmlsZV9yZWxlYXNlLCBzdHJ1
Y3QgZmlsZSAqZmlsZSkKIExTTV9IT09LKHZvaWQsIExTTV9SRVRfVk9JRCwgZmlsZV9mcmVlX3Nl
Y3VyaXR5LCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIExTTV9IT09LKGludCwgMCwgZmlsZV9pb2N0bCwg
c3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCiAJIHVuc2lnbmVkIGxvbmcgYXJn
KQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9sc21faG9va3MuaCBiL2luY2x1ZGUvbGludXgv
bHNtX2hvb2tzLmgKaW5kZXggYTJhZGUwZmZlOWU3Li44YjBjOTZkZDdjOTAgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvbHNtX2hvb2tzLmgKKysrIGIvaW5jbHVkZS9saW51eC9sc21faG9va3Mu
aApAQCAtMTI1LDcgKzEyNSw4IEBAIGV4dGVybiB2b2lkIHNlY3VyaXR5X2FkZF9ob29rcyhzdHJ1
Y3Qgc2VjdXJpdHlfaG9va19saXN0ICpob29rcywgaW50IGNvdW50LAogZW51bSBsc21fb3JkZXIg
ewogCUxTTV9PUkRFUl9GSVJTVCA9IC0xLAkvKiBUaGlzIGlzIG9ubHkgZm9yIGNhcGFiaWxpdGll
cy4gKi8KIAlMU01fT1JERVJfTVVUQUJMRSA9IDAsCi0JTFNNX09SREVSX0xBU1QgPSAxLAkvKiBU
aGlzIGlzIG9ubHkgZm9yIGludGVncml0eS4gKi8KKwlMU01fT1JERVJfTEFTVCA9IDEsIC8qIEZv
ciBhbHdheXMgZW5hYmxlZCBMU01zIGFmdGVyIG11dGFibGUgb25lcy4gKi8KKwlMU01fT1JERVJf
UkVBTExZX0xBU1QgPSAyLCAvKiBBZnRlciB0aGUgbGFzdCBvbmVzLiAqLwogfTsKIAogc3RydWN0
IGxzbV9pbmZvIHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2VjdXJpdHkuaCBiL2luY2x1
ZGUvbGludXgvc2VjdXJpdHkuaAppbmRleCAxY2Q4NDk3MGFiNGMuLjc2NmVhY2NjNDY3OSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zZWN1cml0eS5oCisrKyBiL2luY2x1ZGUvbGludXgvc2Vj
dXJpdHkuaApAQCAtNDAyLDcgKzQwMiw3IEBAIGludCBzZWN1cml0eV9rZXJuZnNfaW5pdF9zZWN1
cml0eShzdHJ1Y3Qga2VybmZzX25vZGUgKmtuX2RpciwKIAkJCQkgIHN0cnVjdCBrZXJuZnNfbm9k
ZSAqa24pOwogaW50IHNlY3VyaXR5X2ZpbGVfcGVybWlzc2lvbihzdHJ1Y3QgZmlsZSAqZmlsZSwg
aW50IG1hc2spOwogaW50IHNlY3VyaXR5X2ZpbGVfYWxsb2Moc3RydWN0IGZpbGUgKmZpbGUpOwot
dm9pZCBzZWN1cml0eV9maWxlX3ByZV9mcmVlKHN0cnVjdCBmaWxlICpmaWxlKTsKK3ZvaWQgc2Vj
dXJpdHlfZmlsZV9yZWxlYXNlKHN0cnVjdCBmaWxlICpmaWxlKTsKIHZvaWQgc2VjdXJpdHlfZmls
ZV9mcmVlKHN0cnVjdCBmaWxlICpmaWxlKTsKIGludCBzZWN1cml0eV9maWxlX2lvY3RsKHN0cnVj
dCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7CiBpbnQg
c2VjdXJpdHlfbW1hcF9maWxlKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBsb25nIHByb3Qs
CkBAIC0xMDI4LDcgKzEwMjgsNyBAQCBzdGF0aWMgaW5saW5lIGludCBzZWN1cml0eV9maWxlX2Fs
bG9jKHN0cnVjdCBmaWxlICpmaWxlKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW5saW5lIHZv
aWQgc2VjdXJpdHlfZmlsZV9wcmVfZnJlZShzdHJ1Y3QgZmlsZSAqZmlsZSkKK3N0YXRpYyBpbmxp
bmUgdm9pZCBzZWN1cml0eV9maWxlX3JlbGVhc2Uoc3RydWN0IGZpbGUgKmZpbGUpCiB7IH0KIAog
c3RhdGljIGlubGluZSB2b2lkIHNlY3VyaXR5X2ZpbGVfZnJlZShzdHJ1Y3QgZmlsZSAqZmlsZSkK
ZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtX21haW4uYyBiL3NlY3VyaXR5
L2ludGVncml0eS9ldm0vZXZtX21haW4uYwppbmRleCAyMTU2MDg3NGU1ZmMuLmZhNTQxNjZlMWEz
ZCAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2V2bS9ldm1fbWFpbi5jCisrKyBiL3Nl
Y3VyaXR5L2ludGVncml0eS9ldm0vZXZtX21haW4uYwpAQCAtMTAzNywzNyArMTAzNywyMCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGxzbV9pZCBldm1fbHNtaWQgPSB7CiAJLmlkID0gTFNNX0lEX0VW
TSwKIH07CiAKLS8qIFJldHVybiB0aGUgRVZNIExTTSBJRCwgaWYgRVZNIGlzIGVuYWJsZWQgb3Ig
TlVMTCBpZiBub3QuICovCi1jb25zdCBzdHJ1Y3QgbHNtX2lkICpldm1fZ2V0X2xzbV9pZCh2b2lk
KQotewotCXJldHVybiAmZXZtX2xzbWlkOwotfQotCi0vKgotICogU2luY2Ugd2l0aCB0aGUgTFNN
X09SREVSX0xBU1QgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIGFib3V0IHRoZSBvcmRlcmluZwotICog
d2l0aGluIHRoZSAubHNtX2luZm8uaW5pdCBzZWN0aW9uLCBlbnN1cmUgdGhhdCBJTUEgaG9va3Mg
YXJlIGJlZm9yZSBFVk0KLSAqIG9uZXMsIGJ5IGxldHRpbmcgdGhlICdpbnRlZ3JpdHknIExTTSBj
YWxsIGluaXRfZXZtX2xzbSgpIHRvIGluaXRpYWxpemUgdGhlCi0gKiAnaW1hJyBhbmQgJ2V2bScg
TFNNcyBpbiB0aGlzIHNlcXVlbmNlLgotICovCi12b2lkIF9faW5pdCBpbml0X2V2bV9sc20odm9p
ZCkKK3N0YXRpYyBpbnQgX19pbml0IGluaXRfZXZtX2xzbSh2b2lkKQogewogCXNlY3VyaXR5X2Fk
ZF9ob29rcyhldm1faG9va3MsIEFSUkFZX1NJWkUoZXZtX2hvb2tzKSwgJmV2bV9sc21pZCk7CisJ
cmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgbHNtX2Jsb2Jfc2l6ZXMgZXZtX2Jsb2Jfc2l6
ZXMgX19yb19hZnRlcl9pbml0ID0gewogCS5sYnNfeGF0dHJfY291bnQgPSAxLAogfTsKIAotLyog
SW50cm9kdWNlIGEgZHVtbXkgZnVuY3Rpb24gYXMgJ2V2bScgaW5pdCBtZXRob2QgKGl0IGNhbm5v
dCBiZSBOVUxMKS4gKi8KLXN0YXRpYyBpbnQgX19pbml0IGR1bW15X2luaXRfZXZtX2xzbSh2b2lk
KQotewotCXJldHVybiAwOwotfQotCiBERUZJTkVfTFNNKGV2bSkgPSB7CiAJLm5hbWUgPSAiZXZt
IiwKLQkuaW5pdCA9IGR1bW15X2luaXRfZXZtX2xzbSwKLQkub3JkZXIgPSBMU01fT1JERVJfTEFT
VCwKKwkuaW5pdCA9IGluaXRfZXZtX2xzbSwKKwkub3JkZXIgPSBMU01fT1JERVJfUkVBTExZX0xB
U1QsCiAJLmJsb2JzID0gJmV2bV9ibG9iX3NpemVzLAogfTsKIApkaWZmIC0tZ2l0IGEvc2VjdXJp
dHkvaW50ZWdyaXR5L2lpbnQuYyBiL3NlY3VyaXR5L2ludGVncml0eS9paW50LmMKaW5kZXggYTVl
ZGQzYzcwNzg0Li44ZmM5NDU1ZGRhMTEgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9p
aW50LmMKKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2lpbnQuYwpAQCAtOTQsNiArOTQsMTMgQEAg
c3RydWN0IGludGVncml0eV9paW50X2NhY2hlICppbnRlZ3JpdHlfaW5vZGVfZ2V0KHN0cnVjdCBp
bm9kZSAqaW5vZGUpCiB7CiAJc3RydWN0IGludGVncml0eV9paW50X2NhY2hlICppaW50OwogCisJ
LyoKKwkgKiBBZnRlciByZW1vdmluZyB0aGUgJ2ludGVncml0eScgTFNNLCB0aGUgJ2ltYScgTFNN
IGNhbGxzCisJICogaW50ZWdyaXR5X2lpbnRjYWNoZV9pbml0KCkgdG8gaW5pdGlhbGl6ZSBpaW50
X2NhY2hlLgorCSAqLworCWlmICghSVNfRU5BQkxFRChDT05GSUdfSU1BKSkKKwkJcmV0dXJuIE5V
TEw7CisKIAlpaW50ID0gaW50ZWdyaXR5X2lpbnRfZmluZChpbm9kZSk7CiAJaWYgKGlpbnQpCiAJ
CXJldHVybiBpaW50OwpAQCAtMTE3LDcgKzEyNCw3IEBAIHN0cnVjdCBpbnRlZ3JpdHlfaWludF9j
YWNoZSAqaW50ZWdyaXR5X2lub2RlX2dldChzdHJ1Y3QgaW5vZGUgKmlub2RlKQogICoKICAqIEZy
ZWUgdGhlIGludGVncml0eSBpbmZvcm1hdGlvbihpaW50KSBhc3NvY2lhdGVkIHdpdGggYW4gaW5v
ZGUuCiAgKi8KLXN0YXRpYyB2b2lkIGludGVncml0eV9pbm9kZV9mcmVlKHN0cnVjdCBpbm9kZSAq
aW5vZGUpCit2b2lkIGludGVncml0eV9pbm9kZV9mcmVlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiB7
CiAJc3RydWN0IGludGVncml0eV9paW50X2NhY2hlICppaW50OwogCkBAIC0xMzcsNDEgKzE0NCwx
NSBAQCBzdGF0aWMgdm9pZCBpaW50X2luaXRfb25jZSh2b2lkICpmb28pCiAJbWVtc2V0KGlpbnQs
IDAsIHNpemVvZigqaWludCkpOwogfQogCi1zdGF0aWMgc3RydWN0IHNlY3VyaXR5X2hvb2tfbGlz
dCBpbnRlZ3JpdHlfaG9va3NbXSBfX3JvX2FmdGVyX2luaXQgPSB7Ci0JTFNNX0hPT0tfSU5JVChp
bm9kZV9mcmVlX3NlY3VyaXR5LCBpbnRlZ3JpdHlfaW5vZGVfZnJlZSksCi0jaWZkZWYgQ09ORklH
X0lOVEVHUklUWV9BU1lNTUVUUklDX0tFWVMKLQlMU01fSE9PS19JTklUKGtlcm5lbF9tb2R1bGVf
cmVxdWVzdCwgaW50ZWdyaXR5X2tlcm5lbF9tb2R1bGVfcmVxdWVzdCksCi0jZW5kaWYKLX07Ci0K
IC8qCi0gKiBQZXJmb3JtIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgJ2ludGVncml0eScsICdp
bWEnIGFuZCAnZXZtJyBMU01zIHRvCi0gKiBlbnN1cmUgdGhhdCB0aGUgbWFuYWdlbWVudCBvZiBp
bnRlZ3JpdHkgbWV0YWRhdGEgaXMgd29ya2luZyBhdCB0aGUgdGltZQotICogSU1BIGFuZCBFVk0g
aG9va3MgYXJlIHJlZ2lzdGVyZWQgdG8gdGhlIExTTSBpbmZyYXN0cnVjdHVyZSwgYW5kIHRvIGtl
ZXAKLSAqIHRoZSBvcmlnaW5hbCBvcmRlcmluZyBvZiBJTUEgYW5kIEVWTSBmdW5jdGlvbnMgYXMg
d2hlbiB0aGV5IHdlcmUgaGFyZGNvZGVkLgorICogSW5pdGlhbGl6ZSB0aGUgaW50ZWdyaXR5IG1l
dGFkYXRhIGNhY2hlIGZyb20gSU1BLCBzaW5jZSBpdCBpcyB0aGUgb25seSBMU00KKyAqIHRoYXQg
cmVhbGx5IG5lZWRzIGl0LiBFVk0gY2FuIHdvcmsgd2l0aG91dCBpdC4KICAqLwotc3RhdGljIGlu
dCBfX2luaXQgaW50ZWdyaXR5X2xzbV9pbml0KHZvaWQpCitpbnQgX19pbml0IGludGVncml0eV9p
aW50Y2FjaGVfaW5pdCh2b2lkKQogewotCWNvbnN0IHN0cnVjdCBsc21faWQgKmxzbWlkOwotCiAJ
aWludF9jYWNoZSA9CiAJICAgIGttZW1fY2FjaGVfY3JlYXRlKCJpaW50X2NhY2hlIiwgc2l6ZW9m
KHN0cnVjdCBpbnRlZ3JpdHlfaWludF9jYWNoZSksCiAJCQkgICAgICAwLCBTTEFCX1BBTklDLCBp
aW50X2luaXRfb25jZSk7Ci0JLyoKLQkgKiBPYnRhaW4gZWl0aGVyIHRoZSBJTUEgb3IgRVZNIExT
TSBJRCB0byByZWdpc3RlciBpbnRlZ3JpdHktc3BlY2lmaWMKLQkgKiBob29rcyB1bmRlciB0aGF0
IExTTSwgc2luY2UgdGhlcmUgaXMgbm8gTFNNIElEIGFzc2lnbmVkIHRvIHRoZQotCSAqICdpbnRl
Z3JpdHknIExTTS4KLQkgKi8KLQlsc21pZCA9IGltYV9nZXRfbHNtX2lkKCk7Ci0JaWYgKCFsc21p
ZCkKLQkJbHNtaWQgPSBldm1fZ2V0X2xzbV9pZCgpOwotCS8qIE5vIHBvaW50IGluIGNvbnRpbnVp
bmcsIHNpbmNlIGJvdGggSU1BIGFuZCBFVk0gYXJlIGRpc2FibGVkLiAqLwotCWlmICghbHNtaWQp
Ci0JCXJldHVybiAwOwotCi0Jc2VjdXJpdHlfYWRkX2hvb2tzKGludGVncml0eV9ob29rcywgQVJS
QVlfU0laRShpbnRlZ3JpdHlfaG9va3MpLCBsc21pZCk7Ci0JaW5pdF9pbWFfbHNtKCk7Ci0JaW5p
dF9ldm1fbHNtKCk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTE3OSwxNyArMTYwLDYgQEAgc3RydWN0
IGxzbV9ibG9iX3NpemVzIGludGVncml0eV9ibG9iX3NpemVzIF9fcm9fYWZ0ZXJfaW5pdCA9IHsK
IAkubGJzX2lub2RlID0gc2l6ZW9mKHN0cnVjdCBpbnRlZ3JpdHlfaWludF9jYWNoZSAqKSwKIH07
CiAKLS8qCi0gKiBLZWVwIGl0IHVudGlsIElNQSBhbmQgRVZNIGNhbiB1c2UgZGlzam9pbnQgaW50
ZWdyaXR5IG1ldGFkYXRhLCBhbmQgdGhlaXIKLSAqIGluaXRpYWxpemF0aW9uIG9yZGVyIGNhbiBi
ZSBzd2FwcGVkIHdpdGhvdXQgY2hhbmdlIGluIHRoZWlyIGJlaGF2aW9yLgotICovCi1ERUZJTkVf
TFNNKGludGVncml0eSkgPSB7Ci0JLm5hbWUgPSAiaW50ZWdyaXR5IiwKLQkuaW5pdCA9IGludGVn
cml0eV9sc21faW5pdCwKLQkub3JkZXIgPSBMU01fT1JERVJfTEFTVCwKLQkuYmxvYnMgPSAmaW50
ZWdyaXR5X2Jsb2Jfc2l6ZXMsCi19OwotCiAvKgogICogaW50ZWdyaXR5X2tlcm5lbF9yZWFkIC0g
cmVhZCBkYXRhIGZyb20gdGhlIGZpbGUKICAqCmRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9tYWluLmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9tYWluLmMKaW5k
ZXggOWFhYmJjMzc5MTZjLi41MmI0YTNiYmE0NWEgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L2ludGVn
cml0eS9pbWEvaW1hX21haW4uYworKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9tYWlu
LmMKQEAgLTExMjYsNyArMTEyNiw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2VjdXJpdHlfaG9va19saXN0
IGltYV9ob29rc1tdIF9fcm9fYWZ0ZXJfaW5pdCA9IHsKIAlMU01fSE9PS19JTklUKGJwcm1fY2hl
Y2tfc2VjdXJpdHksIGltYV9icHJtX2NoZWNrKSwKIAlMU01fSE9PS19JTklUKGZpbGVfcG9zdF9v
cGVuLCBpbWFfZmlsZV9jaGVjayksCiAJTFNNX0hPT0tfSU5JVChpbm9kZV9wb3N0X2NyZWF0ZV90
bXBmaWxlLCBpbWFfcG9zdF9jcmVhdGVfdG1wZmlsZSksCi0JTFNNX0hPT0tfSU5JVChmaWxlX3By
ZV9mcmVlX3NlY3VyaXR5LCBpbWFfZmlsZV9mcmVlKSwKKwlMU01fSE9PS19JTklUKGZpbGVfcmVs
ZWFzZSwgaW1hX2ZpbGVfZnJlZSksCiAJTFNNX0hPT0tfSU5JVChtbWFwX2ZpbGUsIGltYV9maWxl
X21tYXApLAogCUxTTV9IT09LX0lOSVQoZmlsZV9tcHJvdGVjdCwgaW1hX2ZpbGVfbXByb3RlY3Qp
LAogCUxTTV9IT09LX0lOSVQoa2VybmVsX2xvYWRfZGF0YSwgaW1hX2xvYWRfZGF0YSksCkBAIC0x
MTM4LDYgKzExMzgsMTAgQEAgc3RhdGljIHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3QgaW1hX2hv
b2tzW10gX19yb19hZnRlcl9pbml0ID0gewogI2VuZGlmCiAjaWZkZWYgQ09ORklHX0lNQV9NRUFT
VVJFX0FTWU1NRVRSSUNfS0VZUwogCUxTTV9IT09LX0lOSVQoa2V5X3Bvc3RfY3JlYXRlX29yX3Vw
ZGF0ZSwgaW1hX3Bvc3Rfa2V5X2NyZWF0ZV9vcl91cGRhdGUpLAorI2VuZGlmCisJTFNNX0hPT0tf
SU5JVChpbm9kZV9mcmVlX3NlY3VyaXR5LCBpbnRlZ3JpdHlfaW5vZGVfZnJlZSksCisjaWZkZWYg
Q09ORklHX0lOVEVHUklUWV9BU1lNTUVUUklDX0tFWVMKKwlMU01fSE9PS19JTklUKGtlcm5lbF9t
b2R1bGVfcmVxdWVzdCwgaW50ZWdyaXR5X2tlcm5lbF9tb2R1bGVfcmVxdWVzdCksCiAjZW5kaWYK
IH07CiAKQEAgLTExNDYsMzQgKzExNTAsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBsc21faWQg
aW1hX2xzbWlkID0gewogCS5pZCA9IExTTV9JRF9JTUEsCiB9OwogCi0vKiBSZXR1cm4gdGhlIElN
QSBMU00gSUQsIGlmIElNQSBpcyBlbmFibGVkIG9yIE5VTEwgaWYgbm90LiAqLwotY29uc3Qgc3Ry
dWN0IGxzbV9pZCAqaW1hX2dldF9sc21faWQodm9pZCkKLXsKLQlyZXR1cm4gJmltYV9sc21pZDsK
LX0KLQotLyoKLSAqIFNpbmNlIHdpdGggdGhlIExTTV9PUkRFUl9MQVNUIHRoZXJlIGlzIG5vIGd1
YXJhbnRlZSBhYm91dCB0aGUgb3JkZXJpbmcKLSAqIHdpdGhpbiB0aGUgLmxzbV9pbmZvLmluaXQg
c2VjdGlvbiwgZW5zdXJlIHRoYXQgSU1BIGhvb2tzIGFyZSBiZWZvcmUgRVZNCi0gKiBvbmVzLCBi
eSBsZXR0aW5nIHRoZSAnaW50ZWdyaXR5JyBMU00gY2FsbCBpbml0X2ltYV9sc20oKSB0byBpbml0
aWFsaXplIHRoZQotICogJ2ltYScgYW5kICdldm0nIExTTXMgaW4gdGhpcyBzZXF1ZW5jZS4KLSAq
Lwotdm9pZCBfX2luaXQgaW5pdF9pbWFfbHNtKHZvaWQpCitzdGF0aWMgaW50IF9faW5pdCBpbml0
X2ltYV9sc20odm9pZCkKIHsKKwlpbnRlZ3JpdHlfaWludGNhY2hlX2luaXQoKTsKIAlzZWN1cml0
eV9hZGRfaG9va3MoaW1hX2hvb2tzLCBBUlJBWV9TSVpFKGltYV9ob29rcyksICZpbWFfbHNtaWQp
OwogCWluaXRfaW1hX2FwcHJhaXNlX2xzbSgmaW1hX2xzbWlkKTsKLX0KLQotLyogSW50cm9kdWNl
IGEgZHVtbXkgZnVuY3Rpb24gYXMgJ2ltYScgaW5pdCBtZXRob2QgKGl0IGNhbm5vdCBiZSBOVUxM
KS4gKi8KLXN0YXRpYyBpbnQgX19pbml0IGR1bW15X2luaXRfaW1hX2xzbSh2b2lkKQotewogCXJl
dHVybiAwOwogfQogCiBERUZJTkVfTFNNKGltYSkgPSB7CiAJLm5hbWUgPSAiaW1hIiwKLQkuaW5p
dCA9IGR1bW15X2luaXRfaW1hX2xzbSwKKwkuaW5pdCA9IGluaXRfaW1hX2xzbSwKIAkub3JkZXIg
PSBMU01fT1JERVJfTEFTVCwKKwkuYmxvYnMgPSAmaW50ZWdyaXR5X2Jsb2Jfc2l6ZXMsCiB9Owog
CiBsYXRlX2luaXRjYWxsKGluaXRfaW1hKTsJLyogU3RhcnQgSU1BIGFmdGVyIHRoZSBUUE0gaXMg
YXZhaWxhYmxlICovCmRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW50ZWdyaXR5Lmgg
Yi9zZWN1cml0eS9pbnRlZ3JpdHkvaW50ZWdyaXR5LmgKaW5kZXggZWYyNjg5YjUyNjRkLi4yZmIz
NWM2N2Q2NGQgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbnRlZ3JpdHkuaAorKysg
Yi9zZWN1cml0eS9pbnRlZ3JpdHkvaW50ZWdyaXR5LmgKQEAgLTE4MCw2ICsxODAsOCBAQCBzdHJ1
Y3QgaW50ZWdyaXR5X2lpbnRfY2FjaGUgewogICovCiBzdHJ1Y3QgaW50ZWdyaXR5X2lpbnRfY2Fj
aGUgKmludGVncml0eV9paW50X2ZpbmQoc3RydWN0IGlub2RlICppbm9kZSk7CiBzdHJ1Y3QgaW50
ZWdyaXR5X2lpbnRfY2FjaGUgKmludGVncml0eV9pbm9kZV9nZXQoc3RydWN0IGlub2RlICppbm9k
ZSk7Cit2b2lkIGludGVncml0eV9pbm9kZV9mcmVlKHN0cnVjdCBpbm9kZSAqaW5vZGUpOworaW50
IF9faW5pdCBpbnRlZ3JpdHlfaWludGNhY2hlX2luaXQodm9pZCk7CiAKIGludCBpbnRlZ3JpdHlf
a2VybmVsX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZfdCBvZmZzZXQsCiAJCQkgIHZvaWQg
KmFkZHIsIHVuc2lnbmVkIGxvbmcgY291bnQpOwpAQCAtMjEzLDM2ICsyMTUsNiBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgaW50ZWdyaXR5X2lub2RlX3NldF9paW50KGNvbnN0IHN0cnVjdCBpbm9kZSAq
aW5vZGUsCiAKIHN0cnVjdCBtb2RzaWc7CiAKLSNpZmRlZiBDT05GSUdfSU1BCi1jb25zdCBzdHJ1
Y3QgbHNtX2lkICppbWFfZ2V0X2xzbV9pZCh2b2lkKTsKLXZvaWQgX19pbml0IGluaXRfaW1hX2xz
bSh2b2lkKTsKLSNlbHNlCi1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBsc21faWQgKmltYV9n
ZXRfbHNtX2lkKHZvaWQpCi17Ci0JcmV0dXJuIE5VTEw7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgdm9p
ZCBfX2luaXQgaW5pdF9pbWFfbHNtKHZvaWQpCi17Ci19Ci0KLSNlbmRpZgotCi0jaWZkZWYgQ09O
RklHX0VWTQotY29uc3Qgc3RydWN0IGxzbV9pZCAqZXZtX2dldF9sc21faWQodm9pZCk7Ci12b2lk
IF9faW5pdCBpbml0X2V2bV9sc20odm9pZCk7Ci0jZWxzZQotc3RhdGljIGlubGluZSBjb25zdCBz
dHJ1Y3QgbHNtX2lkICpldm1fZ2V0X2xzbV9pZCh2b2lkKQotewotCXJldHVybiBOVUxMOwotfQot
Ci1zdGF0aWMgaW5saW5lIHZvaWQgX19pbml0IGluaXRfZXZtX2xzbSh2b2lkKQotewotfQotCi0j
ZW5kaWYKLQogI2lmZGVmIENPTkZJR19JTlRFR1JJVFlfU0lHTkFUVVJFCiAKIGludCBpbnRlZ3Jp
dHlfZGlnc2lnX3ZlcmlmeShjb25zdCB1bnNpZ25lZCBpbnQgaWQsIGNvbnN0IGNoYXIgKnNpZywg
aW50IHNpZ2xlbiwKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlY3VyaXR5LmMgYi9zZWN1cml0eS9z
ZWN1cml0eS5jCmluZGV4IDBkOWVhYTRjZDI2MC4uNGUzZGJlZWYwOWZhIDEwMDY0NAotLS0gYS9z
ZWN1cml0eS9zZWN1cml0eS5jCisrKyBiL3NlY3VyaXR5L3NlY3VyaXR5LmMKQEAgLTMzMSwxMiAr
MzMxLDE4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvcmRlcmVkX2xzbV9wYXJzZShjb25zdCBjaGFy
ICpvcmRlciwgY29uc3QgY2hhciAqb3JpZ2luKQogCQl9CiAJfQogCi0JLyogTFNNX09SREVSX0xB
U1QgaXMgYWx3YXlzIGxhc3QuICovCisJLyogTFNNX09SREVSX0xBU1QgYWZ0ZXIgbXV0YWJsZSBv
bmVzLiAqLwogCWZvciAobHNtID0gX19zdGFydF9sc21faW5mbzsgbHNtIDwgX19lbmRfbHNtX2lu
Zm87IGxzbSsrKSB7CiAJCWlmIChsc20tPm9yZGVyID09IExTTV9PUkRFUl9MQVNUKQogCQkJYXBw
ZW5kX29yZGVyZWRfbHNtKGxzbSwgIiAgIGxhc3QiKTsKIAl9CiAKKwkvKiBMU01fT1JERVJfUkVB
TExZX0xBU1QgYWZ0ZXIgTFNNX09SREVSX0xBU1QuICovCisJZm9yIChsc20gPSBfX3N0YXJ0X2xz
bV9pbmZvOyBsc20gPCBfX2VuZF9sc21faW5mbzsgbHNtKyspIHsKKwkJaWYgKGxzbS0+b3JkZXIg
PT0gTFNNX09SREVSX1JFQUxMWV9MQVNUKQorCQkJYXBwZW5kX29yZGVyZWRfbHNtKGxzbSwgIiAg
IHJlYWxseSBsYXN0Iik7CisJfQorCiAJLyogRGlzYWJsZSBhbGwgTFNNcyBub3QgaW4gdGhlIG9y
ZGVyZWQgbGlzdC4gKi8KIAlmb3IgKGxzbSA9IF9fc3RhcnRfbHNtX2luZm87IGxzbSA8IF9fZW5k
X2xzbV9pbmZvOyBsc20rKykgewogCQlpZiAoZXhpc3RzX29yZGVyZWRfbHNtKGxzbSkpCkBAIC0y
NzQ2LDE0ICsyNzUyLDE0IEBAIGludCBzZWN1cml0eV9maWxlX2FsbG9jKHN0cnVjdCBmaWxlICpm
aWxlKQogfQogCiAvKioKLSAqIHNlY3VyaXR5X2ZpbGVfcHJlX2ZyZWUoKSAtIFBlcmZvcm0gYWN0
aW9ucyBiZWZvcmUgcmVsZWFzaW5nIHRoZSBmaWxlIHJlZgorICogc2VjdXJpdHlfZmlsZV9yZWxl
YXNlKCkgLSBQZXJmb3JtIGFjdGlvbnMgYmVmb3JlIHJlbGVhc2luZyB0aGUgZmlsZSByZWYKICAq
IEBmaWxlOiB0aGUgZmlsZQogICoKICAqIFBlcmZvcm0gYWN0aW9ucyBiZWZvcmUgcmVsZWFzaW5n
IHRoZSBsYXN0IHJlZmVyZW5jZSB0byBhIGZpbGUuCiAgKi8KLXZvaWQgc2VjdXJpdHlfZmlsZV9w
cmVfZnJlZShzdHJ1Y3QgZmlsZSAqZmlsZSkKK3ZvaWQgc2VjdXJpdHlfZmlsZV9yZWxlYXNlKHN0
cnVjdCBmaWxlICpmaWxlKQogewotCWNhbGxfdm9pZF9ob29rKGZpbGVfcHJlX2ZyZWVfc2VjdXJp
dHksIGZpbGUpOworCWNhbGxfdm9pZF9ob29rKGZpbGVfcmVsZWFzZSwgZmlsZSk7CiB9CiAKIC8q
Kgo=


--=-dQHfNo6Rgr2qySNqlTbY--


