Return-Path: <linux-fsdevel+bounces-5513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A0880CFD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F842821AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FC4BAA3;
	Mon, 11 Dec 2023 15:42:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E772CDC;
	Mon, 11 Dec 2023 07:42:07 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Splxf4jp1zB03Fq;
	Mon, 11 Dec 2023 23:28:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B5020140489;
	Mon, 11 Dec 2023 23:41:59 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnInO+LXdlFG9ZAg--.22283S2;
	Mon, 11 Dec 2023 16:41:59 +0100 (CET)
Message-ID: <6e05677355d6d134dddd11da56709b424b631079.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>,  miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com, paul@paul-moore.com,
 stefanb@linux.ibm.com,  jlayton@kernel.org,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 11 Dec 2023 16:41:46 +0100
In-Reply-To: <ZXcsdf6BzszwZc9h@do-x1extreme>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
	 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
	 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
	 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
	 <ZXcsdf6BzszwZc9h@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnInO+LXdlFG9ZAg--.22283S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWfXryxCw1xWw4ktw1fWFg_yoW8Cr4rpr
	WSva4IqFs8JryxZw4SyrsrX3yF93WxWa15Jr45Krn7A3WDGr1jgFWDJ3W3ZFyIqFyDWa1j
	qayUKas7ur98Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5d2AAAAsd

On Mon, 2023-12-11 at 09:36 -0600, Seth Forshee wrote:
> On Mon, Dec 11, 2023 at 03:56:06PM +0100, Roberto Sassu wrote:
> > Ok, I will try.
> >=20
> > I explain first how EVM works in general, and then why EVM does not
> > work with overlayfs.
> >=20
> > EVM gets called before there is a set/removexattr operation, and after,
> > if that operation is successful. Before the set/removexattr operation
> > EVM calculates the HMAC on current inode metadata (i_ino, i_generation,
> > i_uid, i_gid, i_mode, POSIX ACLs, protected xattrs). Finally, it
> > compares the calculated HMAC with the one in security.evm.
> >=20
> > If the verification and the set/removexattr operation are successful,
> > EVM calculates again the HMAC (in the post hooks) based on the updated
> > inode metadata, and sets security.evm with the new HMAC.
> >=20
> > The problem is the combination of: overlayfs inodes have different
> > metadata than the lower/upper inodes; overlayfs calls the VFS to
> > set/remove xattrs.
>=20
> I don't know all of the inner workings of overlayfs in detail, but is it
> not true that whatever metadata an overlayfs mount presents for a given
> inode is stored in the lower and/or upper filesystem inodes? If the
> metadata for those inodes is verified with EVM, why is it also necessary
> to verify the metadata at the overlayfs level? If some overlayfs
> metadata is currently omitted from the checks on the lower/upper inodes,
> is there any reason EVM couldn't start including that its checksums?

Currently, the metadata where there is a misalignment are:
i_generation, s_uuid, (i_ino?). Maybe there is more?

If metadata are aligned, there is no need to store two separate HMACs.

Thanks

Roberto

> Granted that there could be some backwards compatibility issues, but
> maybe inclusion of the overlayfs metadata could be opt-in.
>=20
> Thanks,
> Seth


