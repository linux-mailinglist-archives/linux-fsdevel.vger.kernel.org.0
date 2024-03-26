Return-Path: <linux-fsdevel+bounces-15346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8588C4C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C1630814B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746227F7D7;
	Tue, 26 Mar 2024 14:10:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1E768EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462236; cv=none; b=BBUB1+0SLBDYp1G9Z1j6YgAz3RZx+3A0l0okxVoUGPSf6fGFqncly8nLoKI8D/Kredp3ICANTwNEridonlWS2VYM9JFvjEGsMQrTXpjOBBjRYrujvgRJFgSZzDGGaBBpuyyUgTr3JJK/RbA5F9NmRxQln3tFGLEuJQknvpTFqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462236; c=relaxed/simple;
	bh=QOSPNzXN4omO8m/l0C9esFwih2AJniCucjpTT7kc/2g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KRZ8IDPKgz6sWEH2C1ifTCIt6uv9IllnolUX042yk8AaHGSEOXwoxUGom4nydENp3deafKWKNTuY3FIjDhuazE3ISe3Xq63xUuKNhs+cQ5Fd98nSr2yL5PRq+phzl0BqziCwhOb5S77KeWdwr0VmX3Krt0WflIHDhaDl+kxQdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 62092644A91F;
	Tue, 26 Mar 2024 15:10:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5ADS77W7NZdl; Tue, 26 Mar 2024 15:10:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0562D6450975;
	Tue, 26 Mar 2024 15:10:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rgs8DqVLzHbZ; Tue, 26 Mar 2024 15:10:24 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B7560644A91F;
	Tue, 26 Mar 2024 15:10:24 +0100 (CET)
Date: Tue, 26 Mar 2024 15:10:24 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Richard Weinberger <richard.weinberger@gmail.com>, 
	Ezequiel Garcia <ezequiel@collabora.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <815707414.105612.1711462224601.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLik9B0spBUYOVSekAns+zf=-zemit=DoVt0r6Us71p=Gw@mail.gmail.com>
References: <CAOuPNLjQPo8hoawK73H7FOVitQHp21HHODExO+7cguGrtURKWg@mail.gmail.com> <321330094.101965.1711390802883.JavaMail.zimbra@nod.at> <CAOuPNLik9B0spBUYOVSekAns+zf=-zemit=DoVt0r6Us71p=Gw@mail.gmail.com>
Subject: Re: linux-mtd: ubiattach taking long time
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-mtd: ubiattach taking long time
Thread-Index: 49zEOnfSaCF4BioDpzC0tXhOf7BsDg==

Pintu,

----- Urspr=C3=BCngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>

> Is there anything missing here ?
> Can we increase the pool size ? Will it help to improve the timing ?

As long you see "scanning is finished", fastmap was not used.
Usually a fastmap is created after ubidetach or writing more than pool size=
.
=20
>> Speaking of other techniques, you can improve scanning time also by
>> tuning UBI for your NAND controller/setup.
>> E.g. transferring only the amount of bytes needed for an header.
>> Or reading without ECC and re-reading with ECC if the header CRC-check f=
ails.
>>
> Sorry, I could not get this fully.
> Is it possible to elaborate more with some reference ?
> Do we have some special commands/parameters to do it if we use initramfs =
?

You need to touch code for that. These are highly specific adoptions.

Thanks,
//richard

