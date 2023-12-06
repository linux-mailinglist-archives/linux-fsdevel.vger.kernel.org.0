Return-Path: <linux-fsdevel+bounces-4956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34EE806C47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101331C20974
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BD2DF67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cgP78Lhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C345DD62;
	Wed,  6 Dec 2023 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id; bh=bSXEOtYvTrwoUoXd1xh88uMJIjGpO/qF5Wv13PfY9Rs=; b=c
	gP78LhuN7x6FQstyZBJFesSlH0rZOkb8F6XwZdNye+SDrAo+BA/+Jt7UMHCgoSE1
	gPVi888MJxHGdM2MmK7F7c4+hZMQbebG3ZSXxoHMNH/JkSqGxKvzGY+O/u9IsVkT
	KaUC9SG6usfmg2b9Tcz+MuNRYa32SOZ9gnV4qgz73o=
Received: from smtpclient.apple (unknown [223.104.132.42])
	by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wAHD6+kOHBlnYMHDA--.36351S2;
	Wed, 06 Dec 2023 17:02:30 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Hao Ge <gehao618@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fs/namei: Don't update atime when some errors occur in get_link
Date: Wed, 6 Dec 2023 17:02:18 +0800
Message-Id: <C295D5E9-ED04-48AD-AA4F-70803429D289@163.com>
References: <20231205-endstadium-teich-d8d0bc900e08@brauner>
Cc: Hao Ge <gehao@kylinos.cn>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205-endstadium-teich-d8d0bc900e08@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: iPhone Mail (21A360)
X-CM-TRANSID:_____wAHD6+kOHBlnYMHDA--.36351S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyxWryfGr13Zw43Cr17Wrg_yoW3Xrg_uF
	sY9a1vkw13JrW5A39rWF4Fyrs0qa93Wr1UJ3s8K3WUZF43X3ZxJr1rGayfArnrX39rKa4r
	X3Wjvw1qqw13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0nvtJUUUUU==
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/xS2Bgho+Flc67gXv7QABs1



> On Dec 5, 2023, at 19:07, Christian Brauner <brauner@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 05, 2023 at 03:17:33PM +0800, Hao Ge wrote:
>> Perhaps we have some errors occur(like security),then we don't update
>> atime,because we didn't actually access it
>>=20
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>=20
> We didn't follow the link but we accessed it. I guess it's not completey
> clear what's correct here so I'd just leave it as is.
Hi brauner
Thank your for your reply.
I just thought of a situation that user access a link failed due to some err=
or(like permission issue),maybe report some error to user, actually user don=
=E2=80=99t get anything,but atime still update.
Maybe your are right,after all,we still tried to visit.
Thanks
Best Regards=20
Hao=


