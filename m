Return-Path: <linux-fsdevel+bounces-32658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3AE9AC9B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7F91C216D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732E1ABED7;
	Wed, 23 Oct 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DZz0rI2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0681AB6F1;
	Wed, 23 Oct 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685490; cv=none; b=WK0NRJfx75+F8jwrxVZH7T8aYwwTwVVl3pKIt/ONUVveR89AaokZycj/QJVoRp+BlPVAUskyFLQm3W6fMA0kXvP4TdUGpMnd0YpLoBjjSZAE0CLFllBTYSwdLr1ClRJ6J+jO22JS/ty88olSanYOAX82O1jzCguCd3Dh4My4Pe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685490; c=relaxed/simple;
	bh=3rQj6fEZ/iZQD71N4a8ZhNCGI4KM2C73FPxf49T8aSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwQT8tSItvy9gkICKLPTTNVfrzLg8u6BZP6fdEZPiaoUPg/1jO4w+9uQpSbHl+SdYDkZkqro5gkRN8WlohCFl4iGlSMucns4cY3q/qgke6FWE5q4iqVIYCUnB4vM3dmy2IP2Q58qIT7c3B7TPxUV0zvWoDTv8AzB05qyPTVnYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DZz0rI2h; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729685471; x=1730290271; i=markus.elfring@web.de;
	bh=3rQj6fEZ/iZQD71N4a8ZhNCGI4KM2C73FPxf49T8aSk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DZz0rI2hh5JuUP0tcmEpgojxSzhtAcRzjFCWQqQH/oBICvbro9NuE9rrJrUJnXLZ
	 d9CVwAs7YtfwDwPNnKaxEhERzYb/ujSfdyKXSdKhwMIGQ4mu8zn4fMfKWEXLa+X2e
	 rR12qVzCRADzR5SDQZuT5RPy7e4bPUOXTjlLlPyBLpmhiu7mtEC/RNsRLBxc6UY2q
	 iYDsq3rEmGWlnJttHLBqzJSlDW3l5RBQy1Eh03jhCbEN8nBR5kntqh0WoZkzzXwF0
	 yN98zgastub5Qhn2FphFIUTxWKYmn/AwfefNrx2rKL1ne+I1cdX+tYfMmeNuu0yva
	 nQZahcTpQufmKVPH0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1tVnNA0APn-00MYss; Wed, 23
 Oct 2024 14:11:11 +0200
Message-ID: <3a94a3cb-1beb-4e48-ab78-4f24b18d9077@web.de>
Date: Wed, 23 Oct 2024 14:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sysctl: Reduce dput(child) calls in proc_sys_fill_cache()
To: Joel Granados <joel.granados@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
 <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <y27xv53nb5rqg4ozske4efdoh2omzryrmflkg6lhg2sx3ka3lf@gmqinxx5ta62>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFyknJdf395MNGzbt8czznwldS29/evKPpb3O5cDjb3kVIiHWSl
 uS4fEYVnOSk/ugfbqc+0bcTZBh31WW668Shn19Vwd9mWF7Fj/x0ZeEMznYABIomhLRE8JqM
 WAUkOjPg17wL2bkS2/2rO2uEHFDeJJ4FxIo1xGXeiRZ8ORLm+5AP0DdlKaEW69rScyLMoAO
 7xXW/Lwe3fOuUf+JzIgng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RupwDlTdcTg=;YENjC31zGYBLO77iYX204OFMcQM
 +mrsX1whDKydsWFDWY2imTZt8j9nJWgweOGbbPmM7IEmPPD+zozIH5IBU9qC9p7CZwH9pOVyr
 iFWvzkGsWtewYW0bVFrhhN9LoO0vDTW4bYMCqHz1cFA3QAbpDCZLXNKrTN921VBqN8KDVhiN1
 kHTbULXWgRUteMiQToD7bMhyFhGw/2qJbU0M+tPd40av6Vd8UzFPjgGvvXoy/Lzoif7u9RDaF
 ekf6PMbYPEl460Nbn7Zlg1Jh6WkoSvGdi7uj9a/tHLGoJTQVio2jaGnm3BC+PEhv12+F8lyrV
 DIosV1ZTP2qNcde2cNnUuXzYcG7U4ZXOcmlyYCNW12kyYMTMA119kPVmyBabHp+0kI4twFKzy
 fmFIKG+Qv6Kl9uqrX+VDSiy0xILP9YPDymTA2DVZjd4Of+Fn4/iM6bmJ/AMx1eWadECdvvyLd
 /wZnbPUOOAPrsFGFHsWPNPVai60jpDeSJ5GEZ+18+oR4Vm+x3Vxd2SwBg6dt4EpKI/ECLJbfD
 DmFfsFmuzdSx1ksrgToi2XSOqteDWk5LrJNPGiqcxFQygC0R8KIMwYJ0TGmxT62Z4L6vc2ObH
 ARZ9qXZtHYhM7wiyvUB5dJa2xgALhU8ev1WNKrY7BQeHBwgCWUf3p3JAr0T+Wq+1Vl7Q5m1SP
 +fL0h7wkCZl+WytRgV3AF2rDZbRfQ0GkAXWCjztZI5IpJ5ZlhYGyJiTKM3TDgBYyRUICgqqzY
 P6abOVoi/p+CNHGh07qcnOkSozNjVk/eT/LO9BYHmEawRZgJVoQ4qe2sdVZh+C+BUxx3VsVL5
 /qdXWzeDp+Z1+3X9Q8O/Wigg==

>> A dput(child) call was immediately used after an error pointer check
>> for a d_splice_alias() call in this function implementation.
>> Thus call such a function instead directly before the check.
> This message reads funny, please re-write for your v2. Here is how I wou=
ld write
> it.
>
> "
> Replace two dput(child) calls with one that occurs immediately before th=
e IS_ERR
> evaluation. This is ok because dput gets called regardless of the value =
returned
> by IS_ERR(res).
> "

Do you prefer the mentioned macro name over the wording =E2=80=9Cerror poi=
nter check=E2=80=9D?


>> This issue was transformed by using the Coccinelle software.
> How long is the coccinelle script? =E2=80=A6

A related script for the semantic patch language was presented already acc=
ording to
the clarification approach =E2=80=9CGeneralising a transformation with SmP=
L?=E2=80=9D.
https://lore.kernel.org/kernel-janitors/300b5d1a-ab88-4548-91d2-0792bc15e1=
5e@web.de/
https://lkml.org/lkml/2024/9/14/464
https://sympa.inria.fr/sympa/arc/cocci/2024-09/msg00004.html

Will further development ideas evolve accordingly?

Regards,
Markus

