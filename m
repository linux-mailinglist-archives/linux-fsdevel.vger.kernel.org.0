Return-Path: <linux-fsdevel+bounces-15856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946C894E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C581C227D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5758210;
	Tue,  2 Apr 2024 09:21:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED0383BD;
	Tue,  2 Apr 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049696; cv=none; b=Skl9OK4cL2T3MYA4vbgLMhlWbzLJcS49BdojLgTWGpw54Si6FyyEdehUJbEEk91lrQQfljG+nVnnFJpRl36e7++kd9OR+p+OTY5iqfb+K7RfrrtyM1OCzV61/h1DPI2xLW9XJM1D8uaCkRgUsw1oT/nTCBlXf9eUV2hboR4XWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049696; c=relaxed/simple;
	bh=ZrY+i6Eawe+SZnMjlYCNSaYhAVqh04i7Clug0w902kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7l/zR4sMUbZ5pYbxC7Ql1Cd9/mYHQHMHpLyVHoDKbNSXRr0Lde7P3WBFbKOzCUjxxZpqf7BEFoE6prbQiqgP3+gy+lIgLG3AZM/z2WyxLHYt4EPYSFK+8mvRY+DSfRi0mp2tN0CoKRgC0WJA7QpQqPHEMQlKsTljXaHY0pyywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V825q65wwz9xHvc;
	Tue,  2 Apr 2024 17:05:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BCF201404A5;
	Tue,  2 Apr 2024 17:21:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXECUKzgtmLpxrBQ--.39145S2;
	Tue, 02 Apr 2024 10:21:22 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: torvalds@linux-foundation.org
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [GIT PULL] security changes for v6.9-rc3
Date: Tue,  2 Apr 2024 11:21:08 +0200
Message-Id: <20240402092108.2520373-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDXECUKzgtmLpxrBQ--.39145S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry5KFWrGF1rGr43GF4fAFb_yoW8AF17pF
	sxKF17Gr1rXFyxGF1kAF17uFW8K3y5Gr1UX3Z8Jw18AF98Cr15Xr1vkr1rWryUJry7tr1x
	tw1jvr15Gw1DAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyqb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgCztUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj5wDRQAAsv

From: Roberto Sassu <roberto.sassu@huawei.com>

Hi Linus

I have a small bug fix for this kernel version. Please pull.

PS: sorry for the email mismatch, @huawei.com emails resent from the
    mailing list are classified by Gmail as spam, we are working on
    fixing it.

Thanks

Roberto


The following changes since commit 026e680b0a08a62b1d948e5a8ca78700bfac0e6e:

  Merge tag 'pwm/for-6.9-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux (2024-04-01 14:38:55 -0700)

are available in the Git repository at:

  https://github.com/linux-integrity/linux.git tags/security-mknod-6.9-rc3

for you to fetch changes up to 12d665b7d3fa743ec58160ceda8421d64b63f272:

  security: Handle dentries without inode in security_path_post_mknod() (2024-04-02 10:01:19 +0200)

----------------------------------------------------------------
Here is a simple follow-up patch for the patch set to move IMA and EVM to
the LSM infrastructure.

It fixes a kernel panic in the newly introduced function
security_path_post_mknod(), when trying to check if an inode is private.
The panic occurs because not all dentries have an inode attached to them.

I'm sending this PR as IMA/EVM co-maintainer, even if the patch also
touches the LSM infrastructure itself (it is acked by Paul).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

----------------------------------------------------------------
Roberto Sassu (1):
      security: Handle dentries without inode in security_path_post_mknod()

 security/integrity/evm/evm_main.c | 6 ++++--
 security/integrity/ima/ima_main.c | 5 +++--
 security/security.c               | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)


