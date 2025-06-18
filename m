Return-Path: <linux-fsdevel+bounces-52007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795ECADE31D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DDD7AC50D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A81F4727;
	Wed, 18 Jun 2025 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d+HtGLNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423C155382;
	Wed, 18 Jun 2025 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225245; cv=none; b=Rsvkj9vtISoawpvxomQlKIK/nqKDk6i/OWTVRSOIX0Ekm4zMBBqA8xs4Ocr0Asbuzu2RLYEpQZgmMxj/KarUflPOh1uwgZe4PDupCT5sI0gslXCckZBsm3TYnJMWzX0L+aZ4zu9d7tTV3LYGCIRg1WQ6Y3QwbZgfVwUC/p3mXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225245; c=relaxed/simple;
	bh=drwRVsq1D9HCEgfVG2exmBXKfcTJ78pOWC0Q/ERY1NM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=n+hpSll1Hmf3y6hQTikgG8NtVrl0YZrZHRH2WWmcyI4oU/Jh8N5yzkpmryXabjXawy/NcjM4oqyHERyMW+YvNmgbZy0q21VaqfFzb+cUxvmU98os2IqDi8QSws2iiPyeTZT4Y68tCSTe7MoErrV95Wt/5BKmo51Mf9C9UayumLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d+HtGLNk; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750225230; bh=iONSASwJQ5J5Bw7IaUISLLS33rv+vLFEwjuOkUKF1lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d+HtGLNkAG2R0nVTJUWX1Z+VGDzPj3EuNxPxHmvXXhzZGgVRJ0rt7Bdk3BQC/CZk0
	 3QSOQarK+sgFhiLH3Trclbn+uqw4rpKXz+sz/OPGSByZw9tE3Qokq1hhhYWOYgphqE
	 gBbvwJa/d6hKuyJFLdFIlbEKf4SAmkWSFchClA4Q=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 89132049; Wed, 18 Jun 2025 13:34:17 +0800
X-QQ-mid: xmsmtpt1750224857t3app1r4s
Message-ID: <tencent_9DDC9378E363A961A3BEA440376237718605@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1j68GC9Fp5X6/vCJwOlXaYoJW1t3bF4LU/BETGZiWftbGA9sH6IB
	 Hm1sd2ZTFxklv7ofJkATHEeYa7Dsx8CtJ9RmG6SC1qb9g9+fy4yFXv39BCMI0cENFJ0dP8weAggY
	 XbBSfpq0NJuTH8wUzbXUdaMpza6QciTZflWb/5eyFnvRt3cFAqu6vCOsNgQ7g0Qm4kHWbJbcyUwL
	 XIutEiNeqmEBVKA8Xq3lykR9T4pIPYcg8d237AazvOlYdYCO/V+CqsrkyXqm/IBC3DfjeGKNvoJ/
	 96EdkRwLTa7mwdEd47H1S4v/hvKvtNd7pFC58Zev7vqsp4mLpAbSBX/YbjeJlui4OrT2HF/AZRqj
	 GjUD6XMAsCKqdCdJgcShq3Ahs7ScuN6WfWCrKa9cGX0ionFAN7OdUf7ZmpFEwchG0VhNK8W4+Wxz
	 V9ujivp5R+EHl+ESeCscNmilhPvPFL3UENnzSLQrElFR/QHfmUOZpd5+lho5Mc5FbxNmtGpiYon4
	 I8G6dCrUDFg16msRtrCBadlZ+CFCLsB8+I4zNCOvq5Tv3sHE2CViWoDEyqIjOw2lmCMoO5uHQSMB
	 QzyAA9ywPeGdC33YcW+NCkrS27pVCfUsCycOG19IjmQwioi9Q6YDROCg3mkuTFtfQtisfPMYb/BI
	 RcyEWcY4YSMjAZZv5HHW3b0r3Qyut7Vglp766oH3ochBwyHQqSek3zFRZP93tEx5Sq3/Iy1i3mUK
	 skpOQDMlD4OigAG10re9i/oLcd9q/RMZQ6Gcyk4QToBPfVecyZ/VQPafJgNabUYZhqsX+jntCR33
	 FHwHjLFsLJCdCuOdTq92IR5mK5rNiyIatoKTIEUtkeB82Mgxram5I7pzIH/4FUv4Nxm8iVXwph/q
	 vOegtQW2gSeO82djukWyZ0I7hsQ0pzbXq4RdOB4LnnOYVKwl7uJL5eXphvQl/yhYADfC3hlFeLad
	 FYMJlCix+0L90kGib/t+wtUD7AO4dRdWP7/HBeQXs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: viro@zeniv.linux.org.uk
Cc: almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org,
	eadavis@qq.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Prevent non-symlinks from entering pick link
Date: Wed, 18 Jun 2025 13:34:18 +0800
X-OQ-MSGID: <20250618053417.1250534-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618052747.GQ1880847@ZenIV>
References: <20250618052747.GQ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Jun 2025 06:27:47 +0100, Al Viro wrote:
> Note that anything that calls __d_add(dentry, inode) with is_bad_inode(inode)
> (or d_add(), or d_instantiate(), or d_splice_alias() under the same conditions)
> is also FUBAR.
> 
> So's anything that calls make_bad_inode() on a struct inode that might be
> in process of being passed to one of those functions by another thread.
> 
> This is fundamentally wrong; bad inodes are not supposed to end up attached
> to dentries.
As far as I know, pick_link() is used to resolve the target path of a
symbolic link (symlink). Can you explain why pick_link() is executed on
a directory or a regular file?


