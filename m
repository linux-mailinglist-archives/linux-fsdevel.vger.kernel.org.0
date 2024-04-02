Return-Path: <linux-fsdevel+bounces-15867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1628952AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1CB2850A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4C177F15;
	Tue,  2 Apr 2024 12:15:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C06CDB3;
	Tue,  2 Apr 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060153; cv=none; b=oi7kSWF7zwXXo8gtwwxEDsVD+d7GWiHmqswvrD2lsnlWdHo3Gwbd6/25hVSim4rG0J8TBGqZnhgrjKpe+P+utMV1Y6gUGqwLzJIiXdWpqYitBAlFt+Qd7Z2vuA63IEyAcisbrCo+WIniy+lUiYZV1uZBxQZOd7rqoF9Kstbb/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060153; c=relaxed/simple;
	bh=aK3b3jUw7a1hW0R0pLU6JDxDOnmP/FeDrYujna8rGOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7YTrTV4ueqnrlZ2IRzLE3dcjObDpZgGBTYhHjRZXzGRCqOteytFI3Kcj+XYP+1Gu7RyCt77QMMu/GhkvxvUQVCgg/gQNJFfeSFlmMwcCA4VMlXA0KFpyl8uzhF3dfKjIvXxNqjIa6C5/vPOJqd6FDjybRBnMhXbu3N27eqo3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4V85sq0CyKz9v7cS;
	Tue,  2 Apr 2024 19:55:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 56197140413;
	Tue,  2 Apr 2024 20:15:41 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAH_BTl9gtmt4V1BQ--.26589S2;
	Tue, 02 Apr 2024 13:15:40 +0100 (CET)
Message-ID: <24c1af6912b53e4da086cff7999be85d35a9ba40.camel@huaweicloud.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: torvalds@linux-foundation.org
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 02 Apr 2024 14:15:29 +0200
In-Reply-To: <20240402092108.2520373-1-roberto.sassu@huaweicloud.com>
References: <20240402092108.2520373-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAH_BTl9gtmt4V1BQ--.26589S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5Cry8JFyxJr47uFyrCrg_yoW8ZF4fpF
	43KF47Crn5XFyxGF4kXF1UuFW8J3yrGr15J3Z5Jw1kZFy5CF15GF1vvr1SgryDGry7Kw1x
	tw1jyFn8Gw1DAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgCztUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj5gDxAABso

On Tue, 2024-04-02 at 11:21 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Hi Linus
>=20
> I have a small bug fix for this kernel version. Please pull.

Ops, there is a spurious 'i' in the referenced commit ID, in the commit
message. Please discard, will send a new pull request shortly.

Roberto

> PS: sorry for the email mismatch, @huawei.com emails resent from the
>     mailing list are classified by Gmail as spam, we are working on
>     fixing it.
>=20
> Thanks
>=20
> Roberto
>=20
>=20
> The following changes since commit 026e680b0a08a62b1d948e5a8ca78700bfac0e=
6e:
>=20
>   Merge tag 'pwm/for-6.9-rc3-fixes' of git://git.kernel.org/pub/scm/linux=
/kernel/git/ukleinek/linux (2024-04-01 14:38:55 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/linux-integrity/linux.git tags/security-mknod-6.9-rc=
3
>=20
> for you to fetch changes up to 12d665b7d3fa743ec58160ceda8421d64b63f272:
>=20
>   security: Handle dentries without inode in security_path_post_mknod() (=
2024-04-02 10:01:19 +0200)
>=20
> ----------------------------------------------------------------
> Here is a simple follow-up patch for the patch set to move IMA and EVM to
> the LSM infrastructure.
>=20
> It fixes a kernel panic in the newly introduced function
> security_path_post_mknod(), when trying to check if an inode is private.
> The panic occurs because not all dentries have an inode attached to them.
>=20
> I'm sending this PR as IMA/EVM co-maintainer, even if the patch also
> touches the LSM infrastructure itself (it is acked by Paul).
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> ----------------------------------------------------------------
> Roberto Sassu (1):
>       security: Handle dentries without inode in security_path_post_mknod=
()
>=20
>  security/integrity/evm/evm_main.c | 6 ++++--
>  security/integrity/ima/ima_main.c | 5 +++--
>  security/security.c               | 5 ++++-
>  3 files changed, 11 insertions(+), 5 deletions(-)
>=20


