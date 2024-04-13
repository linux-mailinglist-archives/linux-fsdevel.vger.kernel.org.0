Return-Path: <linux-fsdevel+bounces-16874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191438A3F37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F63B21625
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1656773;
	Sat, 13 Apr 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="wDETBzqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F81865
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045608; cv=none; b=MoRT1t1t+hOKVOOW+7hrf1ZVYmXT7PdZkJbOCAAOLEsXze9JPiV4R4xUyDiJetJrXhOz+diiQyMK700Drl2UbukODiWZKeIhAOPFrAhmNakhjNVTHoBBRlUiMixOGGhZAq5H0/b4d2ICY4pf1VMDqiLQXvdjBJGL98/zd6kKG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045608; c=relaxed/simple;
	bh=esXBYGqq/qMSfCxYB3tN+zEPEVo0kQQaCv9LwpRJ444=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HST0IEUPcfk+P6YB6QVdDxzE/Z7CWRDLgmdP9nGUCLNWs0mlv0gDWVD1yCYEfFleEkGvmQ5Edyy7q4ZYTP6aZwUQxMdfmr19n5KfElzh8+JgDcYu+gF17ig/TzQSJs1/n2pAffAw8EfgZ9NoCDsrL4ljx7WjN4jIrL35yevLcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=wDETBzqT; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1713045596; x=1713304796;
	bh=esXBYGqq/qMSfCxYB3tN+zEPEVo0kQQaCv9LwpRJ444=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wDETBzqTeki4m48VAl9E7k37RPVHOZlmxFUXT7hTVUS4K6fY8wcZNyniDSzQd/7qe
	 0Et1KY7ohEWTVVS3UgDAtuyyfeHRcw4Wq2ZIXCLhjrq+qadrZkHEtyYpS26n6Cmx/a
	 iACRUhhPRMCrxiZdJyiuV0mj/Ucgglwsm7FD9OSQZsVz647VutFxlwEArusE22gXuy
	 f9sDxnI1jXnhYF3BXLf/AxqPrfSUQ6TcQGFuzQ0qa69U6nhisj3n7Dn/uiIXzHwH8i
	 noWoW1chQb7+hupM5eh3Ci/poHDFWszFF1XaGM7+zg4hNuuH/2mA2WOx0EXWhupjqp
	 HwVMZNs+ICzJQ==
Date: Sat, 13 Apr 2024 21:59:49 +0000
To: Amir Goldstein <amir73il@gmail.com>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: passthrough question
Message-ID: <Fqj2n-eKCjb0dH3kYjvOkIPnDr7D36XgK59hlvgbnOQ1i1lJ07Cdrec0-7uEfn5Lp7u76rYm30CVLtrkQ-0D9jMj31q8wnKSHZ_csn2KdB0=@spawn.link>
In-Reply-To: <CAOQ4uxiw+VNJmthwjQx5-NEZ6yaZbeO4HOiuzOaG33DE=YBm7A@mail.gmail.com>
References: <67785da6-b8fb-44ae-be05-97a4e4dd14a2@spawn.link> <CAOQ4uxjOYcNxNf2S0yFxBgV9zPMhOQOxY72v5ToCxCPJ2S0e+g@mail.gmail.com> <03958bec-d387-494a-bd6a-fcd3b7842c6d@spawn.link> <CAOQ4uxjNF4Kdae5uos4Ch9qBvmAC2kSH58+wVr=F865XhVZsNQ@mail.gmail.com> <a54405ff-d552-420c-88e9-941007c7f0cb@spawn.link> <CAOQ4uxhnSDshQmjn-39Q9TbMJLZiWiYXf+8YLVqB7nPW1L5fBw@mail.gmail.com> <G2XhehibMSoDHBWhAJVS3UfIT1-OlMgYkwAgTu5v2ys1BIUCznJ1B475OEKLBFf6M9gnlpXqFIkrsWRmofllLba2b7cRogWLODZQ5Ma748w=@spawn.link> <CAOQ4uxiR7BHP4+PNx0EBo8Pg4S9po7sDP50ZMVq1aN3zpk=z0Q@mail.gmail.com> <CAJfpegukxxb7SOYW_9T5zto9nUgzRgaxVFDzEi_qz1z9A0zkMg@mail.gmail.com> <CAOQ4uxiw+VNJmthwjQx5-NEZ6yaZbeO4HOiuzOaG33DE=YBm7A@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, April 12th, 2024 at 5:08 AM, Amir Goldstein <amir73il@gmail.com>=
 wrote:
>=20
>=20
> Sounds good, except returning ENOENT to user for open with zero backing i=
d
> is confusing, so I think it has to be EIO like all the other illegal
> passthrough open replies.
>=20
> Thanks,
> Amir.

Been at the Texas Linux Fest past couple days so I've not really had time t=
o look at what you've done for lookup yet. Will do so soon.

RE fh: I think adding a "fh" to more of the protocol could be useful. I fin=
d it extremely convenient with file lifecycle management and if it could ex=
ist for node lifecycle too that could simplify server code. This just came =
to mind while trying to rework my server to use passthrough and haven't dug=
 into the code to see how plausible it is.

RE FOPEN_PASSTHROUGH and complications I've found: I've found another pract=
ical issue. Granted this is a "me" problem in how mergerfs was designed but=
 none the less a, I think, serious issue for me. mergerfs is multiuser. It =
runs at root, multithreaded, and will seteuid to ensure the syscalls it mak=
es are in the user context of the client app (where appropriate.) Unless th=
ere is some API I'm unfamiliar with there is no way in Linux to open an exi=
sting fd. Instead you are expected to open /proc/self/fd/%d. But in my case=
 since the process is running as root /proc/self/fd/ is owned by root:root =
and mode 0500. While a chown will return success on /proc/self/fd/ it has n=
o effect and a chmod fails with EPERM. So non-root can't open the file. The=
 only thing I can think of to do is to store all the details about the file=
 and on future opens open the filepath and ensure it is the same file befor=
e returning back to the kernel otherwise return an error.

