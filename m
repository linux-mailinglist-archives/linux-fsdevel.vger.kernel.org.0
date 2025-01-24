Return-Path: <linux-fsdevel+bounces-40036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEFA1B4BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DDE1887BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917F21B1A3;
	Fri, 24 Jan 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="IbJDrV1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CF23B0;
	Fri, 24 Jan 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717882; cv=none; b=rvT8L4mWHcq4YUPU2ZrT3AN37t1KvXnHhUD7L7L4Mp8Ii/surKhEJ8t+3/HPIKXTrtD6seEazzpNrzGf5BHSwKMQA/37yTYwTQdxd6D1UGd07u3G81PHurXs+mgM0xLixndutGM6U7HxgBNoqBKMEHSRwH7DiFSi6OUHzLGfPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717882; c=relaxed/simple;
	bh=jXV/oIF/ZylCayTfX0ppRxL7Cheot7sxRfcwOAbrZu8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GkquEgeD/MSwKwuTYbEjw7NTB1GuMhcI4gIl2+5gypcfeJ/hmTy+H8NCsdF58CFhIVvaTc9tHvHbUd3U+fJFmuMhi5HWrkd7s6soEWqCfncTleL6keeb4fAgVqUE/QkBqAhXblX0OradcjpJ4mxGx5wZinE/DtZsaSeTpjgHhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=IbJDrV1t; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1737717817;
	bh=jXV/oIF/ZylCayTfX0ppRxL7Cheot7sxRfcwOAbrZu8=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=IbJDrV1t0cSNPPX+H4n0MKThMXb9DdwSjt2bWbc8BH0/y3tQj6p4nguHiTmjmqeGc
	 H46QTgxai3TnQdS0+L3OXroF0AWrmzekEorXx0yCxvyPiNozwRqE8o1hApBRyFZ+wY
	 qPEP54Vwfi+8jIz8oBQvQ6JnMSgYMGT05Df8JFjc=
X-QQ-mid: bizesmtpsz13t1737717816tyc0b9
X-QQ-Originating-IP: 0qTqbwYmLcI1aYbTIweNH83PjJgLM3RWv99PACmF5TM=
Received: from smtpclient.apple ( [117.188.120.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jan 2025 19:23:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9749669307990766307
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
Date: Fri, 24 Jan 2025 19:23:23 +0800
Cc: Sungjong Seo <sj1557.seo@samsung.com>,
 "Yuezhang.Mo" <yuezhang.mo@sony.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <71A44A34-D483-4C14-B334-60E0DC7B5835@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
 <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
 <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
 <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
 <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDtUtlvFer7vqOnREqBNBOpCQ3XHupymXGa28ukl9e1HzGAmGYX7ddxA
	zddIaAU7RJuJ4whWz2kUL4wUCBFv3qasWUPJxBHsxhzLD2nrbMVkH3miJtV7IDNnbnlmEvX
	/or9+4vUSSKUUypLn0V0npfbX3kYZiCzhB+4R+jFKlBq10p1fdYpr/dNm8PT067cBhzjM5O
	unLAItlBv4pPMnYBad74leBooHo/oAuDyBDBnGdn5a5ETCspz+z4rwoBwTcZMXit4k95mX4
	OYq1BxUQKCHz+72EBM8AVE2rTuTnxZcZWVofjfXWJm3dTAVJCQXnpfD7SDcVoY8IHFuibiC
	QGDthP6xndja5aXlsP+8t9u5mvsogoH0WmTV6r9OSSyHHTXdAllf1Bjc2xUNqvQkootwu5J
	NSzAE6wYZhPahuLTJeqnyjzpzGqVYJtrgzSSMNntR4kQyrRrfzkn1bTrp1tv6rdk2bH9L7z
	lfchjOQ3if9GssnB7yakVRQMKCtoIUgDl15j+/r99NaQs72rF7kK3vgUXXy79VQadjSxQVq
	n7g8vySqZ7Y9d0m/o+Sh9CCpGpjD62OoMRI+iBfOP6hMR56VXUejI3AiDG36e3rrckgCDmD
	3dV4gDHTgoB30B0aM5T9F9edYnTa3NzKrxGt2L5tflX41Buodq3lQ/CT2sUNK8Gi5Kw7BrS
	zbMI3cWxC/CrwY8lP6+3rTLlVSbfYtB5yvDV0VXT+FtKId+A93FO2vP3zE2OGEXSd9Ltv5q
	xd4f7wiP36uS96knIkKuJl9Maezvi7KzGUXa6YfFKEGLTF0GPwAeNp6DsNy1coTvRtkwFwL
	xWCmfPF3SOWCQZXKDZRLNHwrIvo+WG3k/4KbOK9sng2jMHIOzB24NSEATTeOXd8cTDATbr8
	wE5mcKAvyRQavncchJCuJAUs2iTCL3Ry7b3gBvuo1LMIxAHvP4/TJej03qcOP42Cgg9E59k
	qxrPLYn4I0du01Ah9HVOp3Eo09CQ3lSjXKHWeTazHq9N5fg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0


> Can you check an attached patch ?
>=20

Sorry for late, we=E2=80=99ll take a look.

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun=

