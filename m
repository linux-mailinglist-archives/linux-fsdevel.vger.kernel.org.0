Return-Path: <linux-fsdevel+bounces-15882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1E895658
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FE21C229C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DA126F3C;
	Tue,  2 Apr 2024 14:12:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0674262;
	Tue,  2 Apr 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067134; cv=none; b=R2b5WHGtlZsriBXZY2cBR4P05AeFyv/qyk6hnODZ/MRqOeFX4iW3WDOiRETneA6fStVBljhLjrfmIpJKM6jH1X21WIR4nJzwMjSONFNl0O+fRRI9784HEk17M+RxQLmcICjGEr8CL1ESU+5KSUs8tQ6/m/MxkbNrCwbG0/lf+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067134; c=relaxed/simple;
	bh=cSAge/wSYO66R2MvS0YwjZezD9EUijLuG5ypGN/S9KE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LvgIpFnL/feIsV7ik+GLGYBHje7fWvL07OGreETHnAAnTNpsoBJulannbyNfB8FXntCNG7FfAvzEzawcLsOpVq3kDla3DxYCzjQVsfxhTfAxtamGh58eM1N7wLzkZz+4tARoqSOOInJ83pC9bi4rsXcDsXe/KLhrxqVZwDiutdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V88Y02kwNz9ttD2;
	Tue,  2 Apr 2024 21:55:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D4AFA140413;
	Tue,  2 Apr 2024 22:11:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnnhcmEgxm0992BQ--.41018S2;
	Tue, 02 Apr 2024 15:11:56 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: torvalds@linux-foundation.org
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [GIT PULL] security changes for v6.9-rc3
Date: Tue,  2 Apr 2024 16:11:45 +0200
Message-Id: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCnnhcmEgxm0992BQ--.41018S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1UKryDGFyfKw4furWkCrg_yoW8GrykpF
	sxKF17Ar15JFyxGFn5AF17CrW0krWrG3WUJan8Gr18AFy3Ar1UZr1qyryF9ryUG347Jr1x
	tw1UZFn8Gw1DAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUySb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5KsUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj5wGkQAAs+

From: Roberto Sassu <roberto.sassu@huawei.com>

Hi Linus,

A single bug fix to address a kernel panic in the newly introduced function
security_path_post_mknod.

PS: sorry for the email mismatch, @huawei.com emails resent from the
    mailing list are classified by Gmail as spam, we are working on
    fixing it.

Thanks,

Roberto


The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://github.com/linux-integrity/linux.git tags/security-mknod-6.9-rc3

for you to fetch changes up to 991c999d8dc76261623c44f9076e427045053427:

  security: Handle dentries without inode in security_path_post_mknod() (2024-04-02 15:27:46 +0200)

----------------------------------------------------------------
security-mknod-6.9-rc3

Fixes a kernel panic in the newly introduced function
security_path_post_mknod(). (Not all dentries have an inode attached to
them.)

----------------------------------------------------------------
Roberto Sassu (1):
      security: Handle dentries without inode in security_path_post_mknod()

 security/integrity/evm/evm_main.c | 6 ++++--
 security/integrity/ima/ima_main.c | 5 +++--
 security/security.c               | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)


