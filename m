Return-Path: <linux-fsdevel+bounces-22821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABCB91CEE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7FA282594
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93F13A89A;
	Sat, 29 Jun 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HeJ2TNs4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B93C36;
	Sat, 29 Jun 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690361; cv=none; b=AI4eJ5nlZ7egZLRonfeDcAW2zYspfUhAADWhh0W8eBayxOZioIqNAJCm/Zrq9lSv6fc9f+HiJGc9CE7OA0N/DyEBDU/jfaIF6ira3nxIeb/+aQEND8yG8r2lcvypr7a5TYi/rYK3NESDTFxE1PNfH9BQRolSxTDlSSzPi+yzvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690361; c=relaxed/simple;
	bh=QKMWqeDHf2w3n6MLyehct0DhfobGcKrKIPPuPKQVW6c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WfxxEIl5X/2JBaB0DhTt6pg7YBdToPr4sL89AE88D7wYvQaqCgr1aZb57R+p5tb16vbW7qzuE4H0NPFSjNPFjjQnrCJv/BB2XBAE9qTWYzKJQvpm6NsBGjWVzT7GY9ja9/XZxoOQAXRcUDTyPOzX0cczK6U0zJxhzMLDmh6OLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HeJ2TNs4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719690347; x=1720295147; i=markus.elfring@web.de;
	bh=M3IoWK/LIS+kUmKmdxCYztphNMAOeDpER4uymuGSzAQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HeJ2TNs4jAuqaEjzLzvn92NkklMA5GNMpLoC7zFPWwcMEOc4QznuqCHFMOTLCdaz
	 S4OtlK1lrG7fVYtGSF9dI9lQvbHPA2pHIqNd7mRRmZgrR+1loTJSfDtIsYPz+3LWc
	 eDrkXSsJMxC3DS+z7VONAdm3yb7fyetElxMpE4Hmk2wtR3+UNlUs+rORhmaUPMh49
	 U/oXIcMPhMR7GlEekd5fA8Jc1l1h3hWBBPRTtOXhbtJj6Py6WAW/SL3VCHLAU5IhD
	 luc81z62suOpMdRRBysVVn562v0LUpq8kXiP7/rb+/C3qPqSqERn75g3Y7u4Sf2ve
	 TN6AsqRawwZGvEVL1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1skgeN0CwO-00Tv3F; Sat, 29
 Jun 2024 21:45:47 +0200
Message-ID: <52d370b2-d82a-4629-918a-128fc7bf7ff8@web.de>
Date: Sat, 29 Jun 2024 21:45:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20240625211803.2750563-3-willy@infradead.org>
Subject: Re: [PATCH v2 2/5] rosebush: Add new data structure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240625211803.2750563-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EimUR2SgooRdIH9/MVJfv1po/8IBkU57IGzVDl9Fcm6V0PXKTmL
 b62LJzeabJF35ttoZpt5U9gL96BZ7Af897wxoPLWJZNztC3Nr8YQcKlnKCK/BON1wZO03wH
 cjzHa3Z8xKVP3AhyGeNRH3j680W9bbhXJmZj76nrNAzwrOTdhrus7lI9gtWWZYz33vRM8Wz
 6N4ySOTS9HYMOnrf/oVUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CoX2l9twqqg=;qKSCIT/jYTSllvTtrT05KhYGM/m
 vHIR5ohSxZlFlnHsQ0xJ7TudUF87p7fJI9Ct/jNBXIXoFR1S9tS5lFOE683yFxSte64L+Jd21
 3cLzdGkLfGQcZM6xZzaxj5cBWUky5RC5ifzsTKKhDqv+xizWkmqWfdaOc3p5GO1i5qrqelBOH
 daSufN8GefbFqKqq0KE9IhTI3FlTO9hH2WWG44MwO9gTHo33i16mP/UtYumUGiQcENfpWrgRk
 KM7WDGHLffqTZihRsXVB2lKyNbIryavikYAWYoYsT++RIg/KqAeZsdfAV6pYMBfqc/wzgVCpl
 6GXya+Yy5yGAUZfuSse3ZMDCwH4FVgm/DQcfrLYOmhD4m+MAkLRGiVDzcJ0mOebJtFDmP/FNE
 1omYDZNr38aqRDtF7sBLNCGVEqNQXSq+7tz5vVRy5LA9EFRmL0LBJhh9nrJMIaKYKMeLUD7N0
 G6Vf0+PLoqF0Lh0GGowtH+J5Dd1cHOFkP4YNJYzcH9+genfuy/R0msX99nf5k1/uLYwbk/dva
 sKSEYwIFB4zmEFsUn1IYHl80lHFh18ZjO6DUzScf+8MONDqGIz7456u1TSx+B1CqMRNs6jWhZ
 D/2lGfqRjgo7ENr8hkuXgWEiJxfaXxDQn+Dt33JgjR69TLZnN0Zfkfu2S12V/0+3WI3QYNuYg
 U/JusHJwTDAwkP6lXwuW+uheRnucE56IoVPM2fZNQjA58xP8jZPxZjq4++KrfF1LPlDhMktAP
 zNez1OKcO8ZANwvl2xir4vxhOPxDnlFHcifhAcUafyOZB/Lz2Nwl5PUngpzIpTq8j7rSShTgg
 6qdgCvktSbIg5qvyrJMwR1Z1l+5XtkMTKhnnp593+K6Xg=

=E2=80=A6
> +++ b/lib/rosebush.c
> @@ -0,0 +1,654 @@
=E2=80=A6
> +int rbh_remove(struct rbh *rbh, u32 hash, void *p)
> +{
=E2=80=A6
> +	rcu_read_lock();
> +	bucket =3D lock_bucket(rbh, hash);
=E2=80=A6
> +rcu_unlock:
> +	rcu_read_unlock();
> +	return err;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(rcu)();=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/rcupdate.h=
#L1093

Regards,
Markus

