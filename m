Return-Path: <linux-fsdevel+bounces-41609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8862A3304B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 21:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F703AA13F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE6200B98;
	Wed, 12 Feb 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jabberwocky.com header.i=@jabberwocky.com header.b="A+ZnTzfQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from walrus.jabberwocky.com (walrus.jabberwocky.com [173.9.29.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236211FF7D4
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.9.29.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390455; cv=none; b=VAXkNjh1xHp0X8d2JOgPRuAtEFBN8J2J2lL4mUp18wVbaXQUbcCpxaeZEL5r4ATsNs8C2uyaRbz7KgDUNWLoX8c4T7+7PpEfw73ud0ClLVGl0sGWNjTw+xHDiiyJojwxKQJrCvVKHm27sWThc+SY2VuPonjbxDnxbZVsyplf3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390455; c=relaxed/simple;
	bh=yAZevf36eAJf6cenxhSRyc4GLkBaliqqUu1z8zX2gtg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=b0OLIvqJFn9A1gb+vDV6fEiXwuyeUUPqHeDNCMpiqq/GCn7UW3GMGfWfaR3llOa9C9q6rvcs8pP82k0ydhM4uGdSfTxCW07DpQ8lt4VIxtWlkHpJGlGT1vibOvVwRqgBnrdXPGZOezpU9aT7+tXhj1CWL3/vvcNm1L3qHLJib0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jabberwocky.com; spf=pass smtp.mailfrom=jabberwocky.com; dkim=pass (2048-bit key) header.d=jabberwocky.com header.i=@jabberwocky.com header.b=A+ZnTzfQ; arc=none smtp.client-ip=173.9.29.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jabberwocky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabberwocky.com
Received: from smtpclient.apple (grover.home.jabberwocky.com [172.24.84.28])
	by walrus.jabberwocky.com (Postfix) with ESMTPSA id E478E206F016
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 15:00:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 walrus.jabberwocky.com E478E206F016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabberwocky.com;
	s=s1; t=1739390452; bh=FScC1dK8eL55mFDve+TzmVmMHFe/tf7ME49AKU9S2C8=;
	h=From:Subject:Date:To:From;
	b=A+ZnTzfQCY+IzPp0HgxLmdAp6AsZlvk1tL5M5nZQA+2Dgnr9KoJFLoKDVi8yx5vZF
	 63fJlaP2xCb2uBn2DGtk+Ld4MpA3Rd662vLiUee3sjFXA5qnQW/h5W4a58qQWTRfW+
	 GbG6CNrQXXnmHfxX5/SDHqPQ//arkgmSYTX0XGPUE0i/qJRwBS1Co6/gP4QTXhDAB9
	 GVOva6TkOmjQybD5P4MioLGs7KtOaH6ATddYsj0SPI4lYFO9CLQtzM81TfahawfFzj
	 Z195Jwb7GdKTvdm94AenrwXA+3YO1i4oUm8s7G+1HzFkZphHeAxIeNcfB+nRCnJKiL
	 TPg3QBI7+bJWw==
From: Daphne Shaw <dshaw@jabberwocky.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Odd split writes in fuse when going from kernel 3.10 to 4.18
Message-Id: <34823B36-2354-49B0-AC44-A8C02BCD1D9D@jabberwocky.com>
Date: Wed, 12 Feb 2025 15:00:42 -0500
To: linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hello!

I've been looking at a strange performance issue with a fuse filesystem =
that showed up when upgrading the system it runs on from CentOS 7 to =
Rocky 8. We've narrowed it down to what looks like an extra write issued =
by fuse, but don't see any reason why that should happen.

Here are the particulars for the narrowed down test:

* The Centos 7 box is running kernel 3.10.0-1160.el7.x86_64 and fuse =
2.9.2-11.el7 (i.e. the stock distro kernel and fuse from Centos 7).

* We run fusexmp:

  [root@localhost ~]# ./fusexmp -obig_writes /mnt/passthrough/

* We do two 4000-byte writes to the passthrough filesystem:

  # dd if=3D/dev/zero of=3D/mnt/passthrough/mnt/cache/file1 bs=3D4000 =
count=3D2
  2+0 records in
  2+0 records out
  8000 bytes (8.0 kB) copied, 0.00174133 s, 4.6 MB/s

* strace shows that this translates to two 4000-byte writes via the fuse =
filesystem:

  [pid  9795] pwrite64(4, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
4000, 0) =3D 4000
  [pid  9795] pwrite64(4, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
4000, 4000) =3D 4000

So far, so good and everything makes sense, Now Rocky 8:

* The Rocky 8 box is running kernel 4.18.0-513.24.1.el8_9.x86_64 and =
fuse 2.9.7-17.el8 (i.e. again, the stock distro kernel and fuse for =
Rocky 8).

* We run passthrough:

  [root@localhost example]# ./passthrough /mnt/passthrough/

* We do the same two 4000-byte writes to the passthrough filesystem:

  [root@localhost example]# dd if=3D/dev/zero =
of=3D/mnt/passthrough/mnt/cache/file1 bs=3D4000 count=3D2
  2+0 records in
  2+0 records out
  8000 bytes (8.0 kB, 7.8 KiB) copied, 0.00227022 s, 3.5 MB/s

* But, and here's the unexpected piece, strace shows that this =
translates to a single 4000-byte write, a 96-byte write, and then a =
3904-byte write via the fuse filesystem:

  [pid 62909] pwrite64(8, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
4000, 0) =3D 4000
  [pid 62909] pwrite64(8, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
96, 4000) =3D 96
  [pid 62910] pwrite64(8, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., =
3904, 4096) =3D 3904

Can anyone help explain why one of the 4000-byte writes is being split =
into a 96-byte and then 3904-byte write?

Thanks,

Daphne


