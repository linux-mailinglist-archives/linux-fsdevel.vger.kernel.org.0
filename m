Return-Path: <linux-fsdevel+bounces-39111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C7A0FEF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C843A6FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28712309AD;
	Tue, 14 Jan 2025 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="r2Hgzmzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230622595;
	Tue, 14 Jan 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736823310; cv=none; b=N8ZHaZPjq91gPhqN+zbmDIjqHmcBnPyAzDxC8Ckeu5CgrH1YCZ9tC9jN/d3R/7Xmre4sCP3Y/hVTHDwKYl6pQWyeoc20CbDHdW8ohzbg//qDJVPoJzR1eI5y/9Zd93yt2nOpwAEK4+NVUqkBCVER3lYjziPFY7rpxgkctKrOIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736823310; c=relaxed/simple;
	bh=PaKr7Wwc2GwN4w9Jy+tJQI5lOx/4SZaHH9XFSlg5jmU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lsoSJxHAnn1EPPaoSODlwkIaod51vtFYnoYjhj4LHIOyLJH+5Jtw1EHQjEGJma061nwpoXdv9GqrOOmLHH84Ke1Eg/U3AnDYDoM+XPjZUzrOgCnonI/6e4lQcxeupnCwWdU5P7hPjiQj9VwNrEDEzenw3oxM1QvrPibFnUrM1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=r2Hgzmzk; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736823290;
	bh=PaKr7Wwc2GwN4w9Jy+tJQI5lOx/4SZaHH9XFSlg5jmU=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=r2HgzmzkXFyeJ7evzwVSl4qMbO1WID83qp2Ybr7GbqpCRNJxMpQhEgKTdPZk6fFne
	 SeWMhjQvBLYBo73CFqmHdJ4D46zIJucAGhzY+aDIjUy0laQiFESCtjM3GxbC69wISt
	 hrFrVPp8j4etiDN/FVBDxAmGCw6uPdwb+1AKhWkY=
X-QQ-mid: bizesmtpip2t1736823289t735png
X-QQ-Originating-IP: ZoHuCDREEWZlGPbrFJszZTyNCx7XvTGfBtua0YZ3rZw=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 10:54:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12455661124939741486
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
Date: Tue, 14 Jan 2025 10:54:36 +0800
Cc: jlayton@redhat.com,
 tytso@mit.edu,
 adilger.kernel@dilger.ca,
 david@fromorbit.com,
 bfields@redhat.com,
 viro@zeniv.linux.org.uk,
 christian.brauner@ubuntu.com,
 hch@lst.de,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 brauner@kernel.org,
 linux-bcachefs@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D732181A-26A9-4D11-9B2F-FE0CEC18A6D1@m.fudan.edu.cn>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MQ+wLuVvI2LQExZhOW1NPqOq+eRcfyCG0v8nPm7383SJeL+zsqr7VYZ5
	2vr1L2ViWNOUEj7gnbLCtZDnY5y8bmUxg4DJ+1RhmuvtjGl1/vw6BHBeKW7l0+3d5+z96Y2
	sIAih55/2buRcTNgmt045R0Se9WB0RbWY4fpqx/+6ZrnWX16fMjHWi6hf+BKNKVzKBrXbwH
	U2w+F2OaoAsMJpLIHs2Io68Jjelrs9e/aqd7adX0I+rbpplEA0sz3xHMF4kJjfy1Pl2F3po
	X0N4f9Ul1eKZQPEZiY+tzMRuILMUKfc/MrmffUlygUgYuG8xjVC0lHdOfLxCryO98m+vSaZ
	PRQg4MR60dRKBDUin+rD4+v38HHwIQTHnavyg/mrQUOgzfNzDThjft5yIBTDLujZka2I6BH
	rJkadSEuSs9rfxOa2h5GB4oTGXjMRHrObD/+gNustn2OjycfDt2bb2V2UjRoEAKjsMOvRME
	gKbk9zE3WVe67jw/OKMupP31Vy1tFx5reNO4D9EXAApTg0g1pVdDXgfn1B5l5NXIU2VLoYA
	JcrOYVHJs68xgvkg2OP81Ftk2irINGsDDOnBaaZg9pKMtz1qe4njJDRWEuangmkDDPqdOp6
	fnmhNOX9BA5mWzSbN5gFqFJCIwK3VicV5zG750rG+ENH6ZP7w/oxOx7b4ARJyp1orxaz0Qz
	JLLr+zkLh4skN4tGEWOicasll8eP4AY5E/gYloCChvXLE0gG64p/xj1P0n4jMd1/mqvmSEo
	V4QinlojxrFV0tVBtdD7nlwtW0gEDc2CQL3TRr0JEJ6FEM9dafDW+RTFB9zC7XLOZbnvuKq
	LXv6w7Z2wJxv0fGQXIXf7nt2nQMgrzwjTuIXKMWN2A0xPKLVD+ltzWytmZD5cZj9qbAlDqs
	pi7r+wRIgBwCJKWmG8GbqjpXL0XTr2ClbLm7ajKeTrHMb9O5nON313Zycln6e4Kf9LwaMUb
	jP3I4z15jKzVOIWz0sLv7HwsLMVwgoNN3NGZAVgjvqdNzZE2vEYmyK2fL9GU0DOMhrjY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

>=20
>=20
> Hello!
>=20
> First I'd note that the list of recipients of this report seems =
somewhat
> arbitrary. linux-kernel & linux-fsdevel makes sense but I'm not sure =
how
> you have arrived at the list of other persons you have CCed :). I have =
to
> say syzbot folks have done a pretty good job at implementing =
mechanisms how
> to determine recipients of the reports (as well as managing existing
> reports over the web / email). Maybe you could take some inspiration =
there
> or just contribute your syzkaller modifications to syzbot folks so =
that
> your reports can benefit from all the other infrastructure they have?
>=20
> Anyway, in this particular case, based on locks reported by lockdep, =
the
> problem seems to be most likely somewhere in bcachefs. Added relevant =
CCs.


Hi Jan,

Thank you very much for your feedback. The current method of determining =
recipients is indeed less structured than syzbot`s mechanism, and we =
have only improved the method of generating the seed, and have not yet =
entered very much into understanding his infrastructure. We will =
definitely consider taking our approach from `syzbot` and not have this =
problem next time.

Thanks for pointing out that it may have originated from `bcachefs`.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Kun Hu=

