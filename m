Return-Path: <linux-fsdevel+bounces-32413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055169A4BCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 09:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F58C1F2377E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94E1DDC38;
	Sat, 19 Oct 2024 07:17:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745901D7E5B;
	Sat, 19 Oct 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322276; cv=none; b=JFmvLf3Usq3LocFYsDBYf2P//3wbytklJr944VaBa27XAQF8uePs+m3GZcz3ZyBKRiMwpq3KAdIKYh2p07HhHBPE5amzXmoE4dM17Z0BQeB0JCfQ/xDdXuNCRcDdlQr9Gu8lmvFJH0ZffGCcgQuc86PD9I1N6Y8+TmP14KR8rxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322276; c=relaxed/simple;
	bh=8Ci7FKbEJ8wfLsbm3P5p52CFIcHLE48XvNrbxWMT8WY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oomx9dtlasPNtkOkdTcw88DPhfKARnR+SsFW6hTTzXkzWpDCQIcZTqAPTrkX7rRidDG9HI1b4SYDSapRJiwYHI3443LA9YPycKn7K6Sc7gdSwn3wxRtDBv2MFG3Wk2GrMr/Xd55zbEJl0GKlfmgh2tFz3Y1b/QtGlNYzaxbDbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1729322145t2gcni
X-QQ-Originating-IP: MmLkSV7nZrQb/cnEymHleci7bWjXBsTzQKwQIpxawNo=
Received: from sonvhi-TianYi510S-07IMB.. ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 15:15:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11545662678210868571
From: chenxiaosong@chenxiaosong.com
To: corbet@lwn.net,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 0/3] Documentation: update nfs idmapper doc and fix compile issues
Date: Sat, 19 Oct 2024 15:15:36 +0800
Message-Id: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OKKvvo6f47/b1g/xBdGInirOOSnzX73ova/Cc+PhSJRh8qb6o/WAzm9v
	WdLadKDKmeCNlr8RML8LFmu5f7yYvLo2gHbO4eKUozQ62gRBk+cZbSuVUF2MwzU9yDuS+CD
	m2WfHLaRHHKDgDniy26yYiL+rZuqGo2djT4Hiu+94aTNXezOSxO/StiCzVTckYFcis8VSIu
	23RMYKjNGZSlGJQ7+s9BqgMAn9zoFmPepY9yweqebdmuD82AyPVO+Hmp1+iBHX5n/jW4oQt
	rQmjD4DT9NcDRNr5D+PRPw5AfQN+itV4OHNG9sPPMZgHfioZsxEfs31DcS6boOYtFntDSDd
	KT2o+FyU0WBbgXfqBXnAL7zaw9pPF9sYXjj8tvZ93tSDg7GvIwFLrtMTEFWuPV/qcxZqP7U
	rYKwgQsjhg+oxYGuz98UzZIsfmo8YSlvBJQRQfSsdDZw4mizA3Cyoyf0He4q/Tup36AijtM
	usHJ04uSW7c7k6xRZOWkCsBg3bTNHFFUgjsILG2tzTALz4Qx/dzGj4XzkGzl8O0gxsXISCE
	uOs06MoswGU0MuX54c5mVbRLrs6j1ZL7OeaFuGNPcbnTi5gy177LUvN8tq8JSrJKhUvfbU8
	ihpfcLK3VM9GwU/WReMvn6ZNsNEKAIyPwADzgAoaQF1HKEk33iCEub48SP9Jtg6y/dvuKni
	0+4qiX9aqL/pc0j+uw/WQJWSpw4Tn9MTPVJMbq4Cs7RP0JKMpRLjESAX7oZZbgCaSimw7W8
	L9TWfCjEFk+2CaEMTrWd5LsIAhME+ovclfsOOnB+irm/zrtNF5atwikRssyhCjjjUGunfp3
	JrDJ6phh9s8E39O9gQZcKT06W3OGbeYzYQTobXVXCwilFOiVg+/KEzgVZDnyf4sk0m8H1GW
	HrkHhd1UNWzkxdqUxBFrkvBcE7rMk5TDpDeBonYT0dPUrIuC53bgz3QFCXjH0LJDrVUcVjy
	lytU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Keep usage of `nfsidmap` consistent with nfsidmap manual.

Additionally, fix compile error and warning when running `make htmldocs`.

ChenXiaoSong (3):
  Documentation: nfs: idmapper: keep consistent with nfsidmap manual
  docs: filesystems: fix compile error in netfs_library.rst
  tracing/Documentation: fix compile warning in debugging.rst

 Documentation/admin-guide/nfs/nfs-idmapper.rst | 59 ++++++++++++++++++++++++++++++++---------------------------
 Documentation/filesystems/netfs_library.rst    |  1 -
 Documentation/trace/index.rst                  |  1 +
 3 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.34.1


