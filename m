Return-Path: <linux-fsdevel+bounces-17415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946ED8AD17B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48642287D7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD11153BCD;
	Mon, 22 Apr 2024 16:03:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555815381F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801803; cv=none; b=FdsfPUczEZsiEuFpQhMFoVucxeMIEADxjrbqZlAw5GaakfttKhNEPovq6Xd0TJjLcbx/VwQEJBvc8ws5661upxIGaDGRDEtQNQmEXwIvGYO4Iv68oK4P83fxxU9mtx3k8oJAMDLAnx7+bZ1lVsO5QEjtrBun0V8CG0NFIDvq1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801803; c=relaxed/simple;
	bh=hh8ouUMiAQsQfPMwczwIEslCVLxDlaoNTpj8lUAzi0c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AV+ovqfla63Ku5Dpbnw/QQ0SQf7V5fogzkXMIQx+//mAg5cbS7qZ9EwlaQsZtLzpoAREecWMvwhEB6Es1qh7nuYXJx32to2PBfCLgoyCj8AB3ko+BrOIQeV61vxx/poQTBilWHT/+eHnIZga7Bls/T3rQvFMVVB8LEw91HwKV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0794A647A80A;
	Mon, 22 Apr 2024 17:56:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SFHviUkNw3uX; Mon, 22 Apr 2024 17:56:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4C5EB647A826;
	Mon, 22 Apr 2024 17:56:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K_Bb7Bo__69m; Mon, 22 Apr 2024 17:56:22 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 24B77647A80A;
	Mon, 22 Apr 2024 17:56:22 +0200 (CEST)
Date: Mon, 22 Apr 2024 17:56:21 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <244721678.14228.1713801381992.JavaMail.zimbra@nod.at>
In-Reply-To: <75dbe998-231a-4dd3-70de-d98bf8ee3349@huawei.com>
References: <20240420025029.2166544-1-willy@infradead.org> <20240420025029.2166544-15-willy@infradead.org> <75dbe998-231a-4dd3-70de-d98bf8ee3349@huawei.com>
Subject: Re: [PATCH 14/30] jffs2: Remove calls to set/clear the folio error
 flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: Remove calls to set/clear the folio error flag
Thread-Index: um/sGrkRiOSYuM6dehxH/fnGn/zIhQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "Matthew Wilcox" <willy@infradead.org>, "linux-fsdevel" <linux-fsdeve=
l@vger.kernel.org>
> CC: "David Woodhouse" <dwmw2@infradead.org>, "richard" <richard@nod.at>, =
"linux-mtd" <linux-mtd@lists.infradead.org>
> Gesendet: Montag, 22. April 2024 16:46:37
> Betreff: Re: [PATCH 14/30] jffs2: Remove calls to set/clear the folio err=
or flag

> =E5=9C=A8 2024/4/20 10:50, Matthew Wilcox (Oracle) =E5=86=99=E9=81=93:
>> Nobody checks the error flag on jffs2 folios, so stop setting and
>> clearing it.  We can also remove the call to clear the uptodate
>> flag; it will already be clear.
>>=20
>> Convert one of these into a call to mapping_set_error() which will
>> actually be checked by other parts of the kernel.
>>=20
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: linux-mtd@lists.infradead.org
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   fs/jffs2/file.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> xfstests passed. Looks like the change is harmless.
>=20
> Tested-by: Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

