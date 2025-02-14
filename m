Return-Path: <linux-fsdevel+bounces-41696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DFA354D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 03:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E4C169927
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 02:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6121E14F136;
	Fri, 14 Feb 2025 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="bISmqngL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E4126BF1;
	Fri, 14 Feb 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500745; cv=none; b=AEjASX/DYe8y0xEBNKVsK0GGdNcvvAqYsY4mSkTrk2Hbh/DDgVaefJQsbpobmujTbA2A5/IJDKEFlzFx8iCpwwK+qv9bWYa055DRXNOQjmoPHREhJbdUwjwJfijj/hlcczbOhNIB46EC24AeMhQh1HbAHo3eVz1wIhSSUysQ3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500745; c=relaxed/simple;
	bh=N7Pn0EHMxbi5fS2utS1dSBrEvZ41q5ipKm8bx/tq02Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MDwSmCVamhq8hW21DqvcnhKbVhBMEtzT2AinBTlbHDTBRzapSexohHgs5v6QDUltt3tcaHicD3y0SaOcUJNvoy9S7vyrOapRgeqneMjM4lgbaKpSgrRI0MFHCId/0QI0fBCcM0thiLDmjLLB88ASaaRF+GYqeV14PKLuldLXGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=bISmqngL; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1739500701;
	bh=N7Pn0EHMxbi5fS2utS1dSBrEvZ41q5ipKm8bx/tq02Y=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=bISmqngLW65GuJF3+L68BHJQxHHf2yGVmmsnpyLlxUNtk153gVvkAqY7bvDxd5DzM
	 HeN4c4JbOG1e1sNdPp9pZ0sPO9nzhh4TCMhVm9CCQuus2a/KRCLjnEMOZZUrXu/5oX
	 vplY2pnKy7de6hzizngr9RsGo1RfH5J56o1ucan0=
X-QQ-mid: bizesmtpip3t1739500700t9v0ngr
X-QQ-Originating-IP: PmkW5tpiknW79/o4jkoUBC+jFzn3Vl7O5uGKqwlUDp4=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Feb 2025 10:38:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1620896532733177375
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] fs/ntfs3: Update inode->i_mapping->a_ops on
 compression state
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>
Date: Fri, 14 Feb 2025 10:38:08 +0800
Cc: ntfs3@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <41833FB4-22EF-41A9-BBE2-E67D2BE91F47@m.fudan.edu.cn>
References: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
 <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NWujniBqiFoNVlUJC4bvMPKna9i3MwE0yZjECMRRD+GpLKVgADnJX638
	Vd5b3J+VdE7Q3mlG8dVVUy0+XIo9gMDe9euX6uCNjo5TpYjTVTn/k4nMF6BfS8rq0xsIJez
	FqkC9IW74vKhvd2ulGn7VrVnUhMdZyB/2PNIbgj1gq7xTMqT/B8SngBOx/1l7FdIRt1+Anr
	MEUjxHg+KvmweyvlNS/lmR7xKkuj+LIas+kINid+R+mCpdJuEsJBeC5NURRFnquMmBZZs8p
	AZpR/Z9eB4WbYaunP1pc27XBo5EB3BJeAD4ztUHEvpkpYGOSD/scmL2baYErj7ZhM8uzCMh
	BOyiJXT6N1+JwxRiJrDwuRYXbbhVY3YUWPsQZ8EYWLyjJY4qEOZnrwZQxEORExqeK+gf3Zd
	Cfh7dNfwt1nR9c0BL0E5uqY1KPju2XGtg8Yo36VrHgJg4JBGzyti1Gq63fktm7xub9H+9WG
	7rIhsHvQAb00YhoFCjX8jrw8lSgVGKbXahZ0OZ6VpX+VgybZJcQOq+vJy6jdtAhaHQz55K1
	dsM25eYyu6Y6JgKh7gX/s/xAODdEe8RCkbaDVMr9wL13fBlBqKARluAgFU0gXRsNRXdpMQH
	rrV/5/H8V3VxO2UJPznY+2WIJWQqXeXDeWyJYfnG7H7PnSlYpzM2MuJCkqUzWU7PzJ17IwL
	OrVhTn2EiG86LpdMFi6rXdnHvnydGhhhBeXedmXdvuVPddnhLB+JdSIdrWqCEXUvjpAC2yN
	o63T4F9ZyCme3M1IqZoIz8VUT66l4YMdkhHH8Azcl++28Km/QUXMSXsAk7NDN0J9DP+cnLs
	Z8JSzEd5aMbinJPbRaymGjWk7pr/D6ecF1OLNFmlE5MIZpoW99DIE1hpeg7l/CbSTyfZ6QF
	R1LhrLNgba9dgR9HG7EjgjV7qbyjg6a4HQO3k4roh8SWXfd9Rkwey1gZUOyvAeF0Dms13Jv
	dTMZdRlhOMbvL86DXpdKs9rdy/3k/hHOcKy4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


>=20
> v2:
> Additionally, ensure that all dirty pages are flushed and concurrent =
access
> to the page cache is blocked.
>=20

Hi Konstantin,

I wanted to follow up as I haven=E2=80=99t yet seen the fix you =
provided, titled =E2=80=9C[v2] fs/ntfs3: Update inode->i_mapping->a_ops =
on compression state=E2=80=9D in the kernel tree. Could you kindly =
confirm if this resolves the issue we=E2=80=99ve been discussing? =
Additionally, I would greatly appreciate it if you could share any =
updates regarding the resolution of this matter.

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu=

