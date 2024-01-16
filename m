Return-Path: <linux-fsdevel+bounces-8035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC582EB21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2077D285533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786F125DB;
	Tue, 16 Jan 2024 08:47:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E17125B0;
	Tue, 16 Jan 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDhy80gLFz9xvNW;
	Tue, 16 Jan 2024 16:29:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8282314025A;
	Tue, 16 Jan 2024 16:47:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC38CSpQqZlOdikAA--.3968S2;
	Tue, 16 Jan 2024 09:47:51 +0100 (CET)
Message-ID: <3b440f064a1ae04d69f7e85f4077f8406c0eac67.camel@huaweicloud.com>
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Al Viro <viro@zeniv.linux.org.uk>, casey@schaufler-ca.com
Cc: brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 dhowells@redhat.com,  jarkko@kernel.org, stephen.smalley.work@gmail.com,
 eparis@parisplace.org,  shuah@kernel.org, mic@digikod.net,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org,  keyrings@vger.kernel.org,
 selinux@vger.kernel.org,  linux-kselftest@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 16 Jan 2024 09:47:34 +0100
In-Reply-To: <20240115191508.GG1674809@ZenIV>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
	 <20240115191508.GG1674809@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC38CSpQqZlOdikAA--.3968S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1DZr4xZrWxZr48XF43Wrg_yoWxArX_ur
	yqkw1kC398CF47A3sruF1fZrZ2qFW8AF15X390qrnxWayfGa4IkFWF9rZ5Z348GF4IyF9I
	gFn0vF4xKr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5iWWAABsn

On Mon, 2024-01-15 at 19:15 +0000, Al Viro wrote:
> On Mon, Jan 15, 2024 at 07:17:57PM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > In preparation for moving IMA and EVM to the LSM infrastructure, introd=
uce
> > the file_release hook.
> >=20
> > IMA calculates at file close the new digest of the file content and wri=
tes
> > it to security.ima, so that appraisal at next file access succeeds.
> >=20
> > An LSM could implement an exclusive access scheme for files, only allow=
ing
> > access to files that have no references.
>=20
> Elaborate that last part, please.

Apologies, I didn't understand that either. Casey?

Thanks

Roberto


