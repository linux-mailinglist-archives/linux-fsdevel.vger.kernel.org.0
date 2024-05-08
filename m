Return-Path: <linux-fsdevel+bounces-19100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4448C009D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9055D1C24394
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA80127B65;
	Wed,  8 May 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="T7xueD9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786061272BB;
	Wed,  8 May 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180884; cv=none; b=nZscJYOpU709RsCX9Ybwd8L4pKcSUPUzeU0zCl8wCPJs9LoHwh52gL0yVlkiovi3+lVVC+40xMC2wtq2Hkdux9SnLF64VgZN00neh7y6mHfb/tIS6+zo3LhmxSoSeVUdoFR6t4k8VQaF9bWT9uY0iYmxL0FNoF398Xe/UW0Dm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180884; c=relaxed/simple;
	bh=8hHikQJgKvHrF6+f83Hf7hW04VKGZyT8FIIZHg2JC88=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=axZkfccJO8olAB2dU8ydhxfDZHecT5QRcJaANBJSKwKepbcirsDackmjrziOO3qZ7ZC2zzxI4Ph32caR3r1EVBpK1zBPK7iuxRx0DPG4jKtQCT0hsEjTUooF+EVspdCZjPddEYZfOT1dD2m7UlgK3MLFCR0KNcNA+BZSoyVnkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=T7xueD9W; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715180541; x=1715785341; i=markus.elfring@web.de;
	bh=8hHikQJgKvHrF6+f83Hf7hW04VKGZyT8FIIZHg2JC88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T7xueD9We+EV7NMRzFieIVmDcOAqa4EH2FwMGOtod5U3f+vdiEfRzeEceAtDB4k1
	 qjdSON+Z9a8WiqlOKBl9unTGiOms/7K4M4a3/JbKukPFmDlX/FPQctUFnPD/YNPsi
	 CEbnrmmgNudxryF7mYYMdhubz0pOKC49EFNmEDgxQYmMtT786faX9+P6V265np4/p
	 rxTPBLypBogyJuNHUqm42cHter328/Jrs4KNi97ABDYwlLGQQx5QG0NJSqLJG8k1x
	 fLDkXQbz0NjML8xrWwJMULHD0OPCh64Y9oajsWG8E1VLpq4Csd/uMR3yfJ+9Z3Sr1
	 Bx/uHhj4PtczwGtMhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nmq-1rzDYf18Ga-007qvg; Wed, 08
 May 2024 17:02:21 +0200
Message-ID: <34c08d45-a0fe-49c9-b7ba-de6a79d46ebc@web.de>
Date: Wed, 8 May 2024 17:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Yu Kuai <yukuai3@huawei.com>, Zhang Yi <yi.zhang@huaweicloud.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>
References: <20240508061220.967970-3-yi.zhang@huaweicloud.com>
Subject: Re: [PATCH v3 02/10] ext4: check the extent status again before
 inserting delalloc block
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508061220.967970-3-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3bhoIr5hklyJjfO6yQONug9t3uau7D9hknXlpPWcdyJLCwtBz1
 X0JBciOtO6QFCY7nGG5nZsd7eCMgfgF1BY/EWkLZmoSNxqatE6jLKbZHvODMOiVHk9vyeSf
 px0/lWQZd/oRx+GEVIfwrxGU1LvV4TdL1a2i2L9zyxlbdwor7gT8udJs1p29ZZh4BzMyuhM
 94Gv6AkPsMtR9+OymzzYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zd6Rz4IAoAQ=;IlMHiD3mE+kv8VkXfvELousQr3H
 czyT66RkzWwCJlAFrIUXiduc37YMO7ARkFJvMkhsR3GF6GWJpdxdfbkTd40R4vRcTZzHeJGds
 7k2ZECVfYyibjABGf6rfhPbmRDPJC21HYlEJvbnjqc1tyxeh8s9eIY+CSBtjJb2m5uGI+buoM
 z/IuFRdiaJDxVLA2zi0u7lnJHWWQuLlnHwNS68sbXfxbYlTTBWc+5Su0TQofcyEk9mZDcczlg
 3rk8huvYYL7fhpqfTUxU3GrjRpBK3JCT/7tBJzrN5ExF8jBjvmUqZOavP8B5USLYTi0JGFbJw
 0yJORcSNuRi/h1gPO6MO8oqYmUzZXMFUPUzXlO/1H7Z3u3ndstyMnve7oYNJdYkQGn43xKC/K
 iUhUT9UiPmfRqwhsherXWr8oYMYV7SjPE7w6YkbEG48we7fiE4R76DBH/JRYT3FHkxlyUaO2Y
 d1wRq5rFN8W52rmgUeXXRbO7b1SuB+EARlk64zHuzCXZxCPx0rwafMQiRpFgmf5rw0eVJ+2DQ
 irkC1wQPTKpXqHtuN0xkn45bPRwKo11J4YctfIhFhDV1JgKPfW3uVbSW6SR2xSAVNvBojOVtZ
 zogXYiJy7bcKORDYgEbsramlT5PkN1uxq/3WGYf+KXwo0gKrEvg8UL5K680uv3r5unmZEMuWp
 3NtF/yfuE6i7XGGe6GH7jwPhvzOpBENG4GFPe2MDy8NNOxSTD2O4xG4s8Lpyu1WRKSJ9A9vu7
 7Sigyxzla53lTMRARvHAxB3FKTrI0V9ivW41eDEQy831hoLmvmyckiQiB7vTve6OA2esnY7HM
 lYyhc2uSlT4qtWv/bfXZLADLgTTHolUjJyyujZRLP6Ob0=

=E2=80=A6
> This patch fixes the problem by looking =E2=80=A6

Will corresponding imperative wordings be desirable for an improved change=
 description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

