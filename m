Return-Path: <linux-fsdevel+bounces-158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A707C675B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C51C20F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E818032;
	Thu, 12 Oct 2023 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1D101C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 08:03:32 +0000 (UTC)
X-Greylist: delayed 1181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 01:03:27 PDT
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9290;
	Thu, 12 Oct 2023 01:03:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4S5hBk5V4Sz9yrH2;
	Thu, 12 Oct 2023 15:30:54 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBnwJGGoydlzkoQAg--.30762S2;
	Thu, 12 Oct 2023 08:43:16 +0100 (CET)
Message-ID: <80e4a1ea172edb2d4d441b70dcd93bfa1654a5b7.camel@huaweicloud.com>
Subject: Re: [PATCH v3 12/25] security: Introduce inode_post_setattr hook
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
Date: Thu, 12 Oct 2023 09:42:58 +0200
In-Reply-To: <22761c3d88c2c4dbac747cc7ddca3d743c6d88d9.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-13-roberto.sassu@huaweicloud.com>
	 <22761c3d88c2c4dbac747cc7ddca3d743c6d88d9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBnwJGGoydlzkoQAg--.30762S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fKrykCF43XF13tw1rtFb_yoW8JFyxpF
	W8Ga1DKr98Kry7C3s3tF48ZayFvayfKw4UXrZrJryxAFsrWw13Kan7Gay8ua4DGrWUGr1Y
	qry2gasrXa4DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5DumAAAsZ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 20:08 -0400, Mimi Zohar wrote:
> gOn Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > In preparation for moving IMA and EVM to the LSM infrastructure, introd=
uce
> > the inode_post_setattr hook.
> >=20
> > It is useful for EVM to recalculate the HMAC on modified file attribute=
s
> > and other file metadata, after it verified the HMAC of current file
> > metadata with the inode_setattr hook.
>=20
> "useful"? =20
>=20
> At inode_setattr hook, EVM verifies the file's existing HMAC value.  At
> inode_post_setattr, EVM re-calculates the file's HMAC based on the
> modified file attributes and other file metadata.
>=20
> >=20
> > LSMs should use the new hook instead of inode_setattr, when they need t=
o
> > know that the operation was done successfully (not known in inode_setat=
tr).
> > The new hook cannot return an error and cannot cause the operation to b=
e
> > reverted.
>=20
> Other LSMs could similarly update security xattrs or ...

I added your sentence. The one above is to satisfy Casey's request to
justify the addition of the new hook, and to explain why inode_setattr
is not sufficient.

Thanks

Roberto

> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


