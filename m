Return-Path: <linux-fsdevel+bounces-38952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D07A0A4CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38079169D7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A131B4120;
	Sat, 11 Jan 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="iAVhOCtZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222456B81;
	Sat, 11 Jan 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736613356; cv=none; b=Jc61pg/KQwS6azXf2HKMGXE0p+ISPTuuEqhKVLA5fcnApy3f/U93KBZK9dtxdSptm3L7DEhViGrOtB+J5KJMey4PGFlYMPJ/gxjGWcslgQJ9bK2EeYhCsVH379JxfMtwvKsJCvwuV6gm+MnmxzqzZsP6cbk5uK7mu36kkXu8qUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736613356; c=relaxed/simple;
	bh=8oS8g8vWlpDoDdc0oVAc4SwCCpbRu7dEKzxSEwJ4hrg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k6hE9vUZ/gFdfhKjTF4WFcoston/ac/hM2shHx8ex946IhnC1Iv++NoZx8nJg/3tfR1fmE9XCdTXmKvdfEPl+2/jB50wXx34aRwNpuzJewce46dQtNisNEbqc71IOhD+azWiVBEeqwGfMueo2E9vc12qLNxuUOo4CoGR72r66+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=iAVhOCtZ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736613300;
	bh=8oS8g8vWlpDoDdc0oVAc4SwCCpbRu7dEKzxSEwJ4hrg=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=iAVhOCtZWTiLLPL5JjCr1M2Lv6eXUWpEYUsMs9ty7t+BnWs3c4kKnOzaEIDfZVEGo
	 vilct67aK+yitzcTt4EqOod4WjkaFBrNl02ujq5E6vOr5eDT2j3db/y0DCNqxBKiO7
	 ryZj4zsgrB5Mj7smQKiqB0Fl54LRVAtelsNMVugQ=
X-QQ-mid: bizesmtpsz15t1736613295t5wfd5
X-QQ-Originating-IP: wH9oQ3ZGUszIRxFRxortNl5zhRpACfpzeLu8CDL70bs=
Received: from smtpclient.apple ( [202.120.235.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 00:34:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16196429251209116610
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
Date: Sun, 12 Jan 2025 00:34:42 +0800
Cc: sj1557.seo@samsung.com,
 yuezhang.mo@sony.com,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
 <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NafziRg7Bx69axgrdcN6XfSltcFUXXQaqrcJifISZEtBl70nk+18+Q8X
	+Pdh3tv81E+dzJB9Vy+oLyVRYWqo9l+QR7q/x8zBu9syCHfjDhWJwYX2CUVC2igr6U6dBks
	AUPPDUS5cYEtuoHgN/Lg3UDY+zy5UW0YAooG0khXRGvHOhSEWTX+ZMIhsNPMoPZt0sShVvq
	INcqbVmPiZbVt+gIlwUdASCht5BRuBN7sobm2XqFf5TxWzwHtexu+nGYTyZIhBR7gRth/er
	Uq1Qa7ZGb3PE6v4jOI8+iPy+1W82iofOjzdVrOJPEZwcbZF+ZcGJL4BEUgr74vFamTfzvMj
	oIf4jLusSX0lEwVVZ1SlmhylXP6qOPM6OnlLBwjh8xKMumoFRfd+yDo2vEveUtMU3CG72/Q
	uvbnzXKOTO/gVsFSn7KnEG4RU/1eImiYWGnYaAwSsyuzEkHJTUZ/yi6VDYzm8As+zmgsMaf
	GDQp1QvqMdIoCzzG6mSPm7PnD2+A2WAwm+uE0vpdoqt/j9GG46Qez3/KqDlw4Yeo/Be0Ljr
	z1QysiwgEgF2dZnhKLSPrXB/AVbsZRRPU+nF+FG3s/8oV1uvHhI/2fghcrre3k2tF7cFaVA
	P7Ck5AetxXhL7CXeVSifRFVnNAqyRvoyqJXv1pUWsIH8M2Ir2oAeGU2Xql3J+36rYNXKcT6
	tIUu+ZFlHx9SxbL/WKWw4+7imhOmbBp/hVK66+MrBKOaRPZ6giFTLqTx561hzaIKUB90WIG
	o91rpRUhN2yXr0i4Sl3csjg7tL7KkKr8zoGQH9RTvX+zY26UGDScIwlU2+mU8nZ6Iqax84W
	BeBc7zkYnvMOJNlCFuMvTpzh9sbqBgfw3GFR4Iovg/zWiPM2DwYt14CT17qBBN+wKVs2ao6
	Y/+KMwqZs1nn12xFM2rsSdALx7Og7RyC9U7FZ1g4i9WXpOgyY0MK5Ta4+96mtIshuf1A4f8
	8/8coy2UJ/99MGss8NBnkmkALX5Uoc9OQvWLQ2VF/XMcSqjHBwAQcWqXW
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0


> Please try to reproduce it with linux-next or the latest Linus tree.


Hi Namjae,

We have reproduced this issue in v6.13-rc6 and obtained a new crash log. =
The links are provided below:

Crash log: =
https://drive.google.com/file/d/1qUmBfpcGeDMHsqBjurhymaH43Jnbvt-F/view?usp=
=3Dsharing

It seems that the new report highlights additional issues beyond the =
original one. While both involve exfat_clear_bitmap and =
__exfat_free_cluster, the new report indicates broader impacts, such as =
multiple CPUs encountering soft lockups, resource contention across =
threads, and potential conflicts with the =
sanitizer_cov_trace_pcinstrumentation. These suggest that the underlying =
issue might extend beyond simple bitmap management to systemic resource =
handling flaws in the exFAT module.

Could you please help to check the cause of the issue?

Thanks,
Kun Hu




