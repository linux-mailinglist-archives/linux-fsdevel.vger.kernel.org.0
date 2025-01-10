Return-Path: <linux-fsdevel+bounces-38896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB310A0984D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56AA3A9261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727AB2139CE;
	Fri, 10 Jan 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="EWLtKxVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474A567D;
	Fri, 10 Jan 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529509; cv=none; b=upqIxZ6Pabb/IXapp52A4vrKP+lecR7XJEhf5CoND9LJ6iqYCWugzrblHqlLB6qw9PwY/eoTdD1kAqYUPYjbemw+Dw4Zd3aLe4FpK1wSSSD3Z2Gf1Nn9STBF3Dk/opel5nDbdUesCpyDJjzIfejElho7/NgYvA7KNQGnInDncmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529509; c=relaxed/simple;
	bh=gA9CRd3z1uUx2WIM7oWWXA4uJ9d3tU6j8Qd0j11Qc24=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OUv1vD1Ddk8JBnniXRL+bWlSPEtTVEwvPLQccQPH/j4kG/Xhw/2v0Q8avddrtzxIh9ObOR7pRKCbn6ulFT8eFBlSvAUS/ecozYhZes9MEj3KzR7JSWvqQiebdfedIcWH+QLDc6DDPDqpSGkfjNjnwK243HcTgKP7/PCQE7sRS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=EWLtKxVb; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736529438;
	bh=gA9CRd3z1uUx2WIM7oWWXA4uJ9d3tU6j8Qd0j11Qc24=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=EWLtKxVb2XBckbxnfAGZzGksOYvqdjBZ1fbSw3YJNd+DQjgpJlER8gCAn1yo5Ppfw
	 tEXCdVpwT+jJJ0AIOzOayHqvpQF0APNOZpt556QcxtuRsvjA4/BSsrKdY59detz9uR
	 vRCkwydo1C2BByCVSMTrHwczVw8UMtx2atXwg94k=
X-QQ-mid: bizesmtp85t1736529437tgd5c9wi
X-QQ-Originating-IP: rfRVqPL4txtl60iWvUuhxU77twpo5FTl9NnQ+pIfbug=
Received: from smtpclient.apple ( [202.120.235.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Jan 2025 01:17:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14616802370816495427
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
Date: Sat, 11 Jan 2025 01:17:04 +0800
Cc: viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 gfs2@lists.linux.dev,
 Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
To: Andreas Gruenbacher <agruenba@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MDN2VRNR2P4wNAmzXcTo5GwdpyYF3irlID+jkbcBHceoYXWS0P1gGAO3
	BvHXr/ll6yfk43HjlNgXybu6fvE2M4unh9cvrgk1pXvucjhs1B8g8zSNopv+fuYlQBRuN8Q
	B0Y1nzO0aHCpH8Hlig+yhRBv+ql3cwxWGruFVq0MCuVLepicOM+1w8cqfEIEvPe7dc3OMRt
	ELJ5ofXb5eSIDx3qNHDXytFhJEIp0YG6pxbB10cc77klS/T7IoU1fibQjW/UgvjthDOjQIP
	JN1v3kM81D3KHtRIZkTpOfFiRygKxHwjFvXApU/kwnxBxVvZd8SJv+oSUYrZ9Jo5saPb/71
	PaMqvMXPrPIFnT8Zyg8ijczIUqOQkxGBwKZhkcAH82qdL5xqZ+UW06r+5LUOhhRc0jlL/Ai
	P577kurLf9mz3yQXArgR7xDJknd00oLxrZWR8opkK0K8Mlv+bCAh050R3Ndz0xJNMzLDqPS
	S9CGYEI0Cm7/Wv0TArgL4zxF/+Zaq1QCYyLB0zv5AC7G8u/croIX0dxgyIeC7zvq/84sHmM
	Wzfbt4yspVrVk23Y1M62HAuVwgjCImVZw1ZxhpusVOIMQAbFC/bm9bOUp/R/dskVkagAjY1
	HT7hk9SJPSCLiWtWnqXsuNm0mr/FDmjvA1IL7GfzUQfR3PBNdwGoA/GKuZOy5kZQ1VhMSZi
	Fch83e7D1/PBMJEZNIbkWIa2E8viECmT3hDCM3r5vJSh5RIfLEotKd0mKHxVNX1Cwr9I4nn
	MoQVH4LmeLfaP4O8SuYJ+p+qNxcVRdbWS60WLC6olCbLRcawE+6QOlgVaCnFAPVgYeVaUOr
	tAkTd+Y4FLDzVglLiOnAstYQpqthxEoINygHBd/AnYW4adwcQDXPoMcyeVvLtzjauYpIkWC
	ALyPD4sZDRwOUB7SOXdX+Ms+OFjVl97OxF2fGhKy3JL5MI3SLF2yBG2KEl5qE+6a/5/DQow
	EkpEY/yElPP3wU0O/ctO8wUau
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0


>=20
> Thanks. Based on the crash report and the reproducer it indeed looks =
like
> some mixing of iomap_folio_state and buffer heads attached to a folio
> (iomap_folio_state is attached there but we end up calling
> __block_write_begin_int() which expects buffer heads there) in GFS2. =
GFS2
> guys, care to have a look?
>=20

Thanks to Jan.

Hi Andreas,

It seems that iomap_write_begin is expected to handle I/O directly based =
on folio, rather than entering the buffer head path. Is it possible that =
GFS2 incorrectly passes data related to buffer head to =
iomap_write_begin?

Could you please help us to check the exact cause of the issue?

Thanks,
Kun Hu=

