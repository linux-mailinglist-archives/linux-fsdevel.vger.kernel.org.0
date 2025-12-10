Return-Path: <linux-fsdevel+bounces-71069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B74CB38FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71393304D0EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931AC326D43;
	Wed, 10 Dec 2025 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AzvhSBag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64382266B6B;
	Wed, 10 Dec 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386589; cv=none; b=t4SQqjxRA4EWKJqgsPYqssMFleqVywYC9335sN9EmSTmmROTlgoukLCu6YI6F8PJ0F06EGszHBvOlZS8+0d3Q/xX54jEMWfI7T+ARf+/0KI1odZfGH+b2OJVWyCM2vgAzSolLoWuCOUaP0rXMznqwErUrnCHAmMUbR3Xw237frc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386589; c=relaxed/simple;
	bh=9JTr69RdhU9rW+NM91qWRzQwBCqL9UHvArTuH4xQpVY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kpVfxl7en7a2zI+2t8RQztBohRJmhIj8+UqIofHBWrBJ/D4HlMhxYHUtk334nxpOsSNgYdKes/Xg+rBuqGpT4awud9hlfDTBD7EQvGORN21CwOoTyYwcyhjPPJ7FHOCjyhTQ0f7WDv9ZsSbBSeafXPRwdH06sSvkQPZqdZavniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AzvhSBag; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765386584; x=1765991384; i=markus.elfring@web.de;
	bh=kIOTL1oMLg9IyhvPI7kx5T8TKQmjTALxKNlEXoDdPKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AzvhSBagItajkWDO/hws39TjIyl+5E7QTr4nErO7EsDRYxLbzbrtkQ8pXNgAcTcc
	 Jy77uybMD2r3NNVCr9VWjfGu09yeA9dDxT2I2TvMBfMFAP5ib7Nr+QEm6hOvzeXaQ
	 9cDyPRnRrL7Caadzei2wAfRIlBrwYRQZBd7M9KK4kuvjiWOXbFtovhgfttC8Q58PD
	 j8fFzjL8dsz4Hpm6NDNh6NviE8gmgmZ4ZC+EZ5sHn1dA1ue11HBTXRWtVo5coztOh
	 Doq4UagXL+GMvCchcU2OPLzLOimJJhnlBCldDf4oKpny4RtdAAVC/Mqz64MoI7DXU
	 ac/sxbt3KNmT6R0cYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.204]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qvH-1wGYSz1hsT-00rV9x; Wed, 10
 Dec 2025 18:09:44 +0100
Message-ID: <67b5e999-2380-46db-aee1-a81df3ceeb36@web.de>
Date: Wed, 10 Dec 2025 18:09:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-fsdevel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Yangtao Li <frank.li@vivo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251209021401.1854-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] HFS: btree: fix missing error check after
 hfs_bnode_find()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251209021401.1854-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EolGGP2kwURVrJ0IiqMs1D+dB8gt07l9DolDKyUD9pHtSmzid21
 KjB4nJLFF98j0mrAKl62WOuSlBS8b5ex36kWZUU9f6GfYxisWUEMtSPaZLo0OpUxZzl/ZjQ
 pWi01AOE3trL1l6WN23CoFYnS4/zUJMDnPQT6WRUqSyuNBNzMzhHkaLe4m1HGpKe1QwDPGe
 inzvqKrqNWqSD/7rMPJ5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+83DRPQnqYo=;xkvloXI4B3wQrkhMaSMHyeP7dDm
 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
 na17tW7vYJipvew0ldHVyPA6D1dUhFqIUvDNJj

> In hfs_brec_insert() and hfs_brec_update_parent(), hfs_bnode_find()
> may return ERR_PTR() on failure, but the result was used without
> checking, risking NULL pointer dereference or invalid pointer usage.
>=20
> Add IS_ERR() checks after these calls and return PTR_ERR()
> on error.

* Can an other word wrapping look eventually a bit nicer here?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18#n658

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.18#n145


Regards,
Markus

