Return-Path: <linux-fsdevel+bounces-66330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C124EC1BFD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEFBB5E291A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B72F6924;
	Wed, 29 Oct 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t5CmFmH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCC1F30A9;
	Wed, 29 Oct 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752911; cv=none; b=G4QA7VtC+vVnPeOzEm7ugjpmSGXhkDdmdZ231ulf4S/RsXWApSFgrj+fsmbDjznAONo6pE8uZWc42U61n8A0RSlvO393zTD/3b59T3E+Qc/xlFXsxGQBbk25cUy/wQJ3Z87cHjE6v9DprjUZMhMqMnMb7NxHaiTBKVi5Fwwcqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752911; c=relaxed/simple;
	bh=ORggRG7XLphs1kQMYY+pAGuzz7PShwMTXh/OgtED/r8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Zzv0RQdxT2TvejaSbg0fUygilpjvFZ8llB27WqPz/Ock5lNTbeD7ByoXHYEZOKqBYFHnNIOkhuiLSyc+wAFtOFXz/T9ouqWFpvhMxP6h2nnXrtg6U0wdFftx4HUT4ebdWt16NjRdtEGDabe5dZdpxvivc0OB88efNlqbuaz2I/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=t5CmFmH/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761752896; x=1762357696; i=markus.elfring@web.de;
	bh=ORggRG7XLphs1kQMYY+pAGuzz7PShwMTXh/OgtED/r8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t5CmFmH/rZHNLDBsJ8Q7MnnEONRIiVU8UMfZE5NZx53JkvCEVHA/OdiXSQdC32EM
	 PkK7pEorjXK40j9MM4HZHpgL74vKZsMGqjYi5EGMoboTEqg+Q5QWIp8vMs0CO3pOt
	 ugy3hrRtTdohzsvsgqYkniDmWuJTDjaEe1A376cWZPcfYhnL0NdY2V5GYjvY0fP2S
	 N5CvWS+4rxPDWLkagEUO6JAvo4lVVh7vm7vM++lb/PZ+UxQiXTUPoWyhj+GmZZhYr
	 QGS4x4wVkbbQlknOWd/hRzias12Dmmqst/dfZjikao+fJ3f2tSofEpOR6RChwqgWn
	 iTSsMJtbc9ITdlvmzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOdp-1w1R4R2q3z-00hs3W; Wed, 29
 Oct 2025 16:48:16 +0100
Message-ID: <53cf045d-e3f4-451d-a809-8714d00add70@web.de>
Date: Wed, 29 Oct 2025 16:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20251029134952.658450-1-mjguzik@gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in putname()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251029134952.658450-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PLSUOweGdhevhmj0ntWcsdqoK74qTUTA4I63IHuyLe734rEhYbF
 pB3c3rA3+Ogaqzu46WRGxQ5fNuD4t4GAkx2qlKigsMJX8QRweILQuX7GqcfyyuH2w2Xk4t7
 Im8vGOXy6c+8PuiYQE4qWbP7Cs8cvsCBL7b71bKfcraJ+Rn9WBeorNu6EuzhGVDWi6Bl3x5
 O5S+n/WZXacYbqUBu5wSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ojacwNjdiU4=;voKfmcn/jXB6jnv1tjKTVZEJYnN
 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
 Mzr8bKig1NhpQFBWStVoJaq8rY9PpAb2XNk=

=E2=80=A6
> I verified this straightens out the asm, no functional changes.

Would a corresponding imperative wording become helpful for an improved ch=
ange description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc3#n94


How do you think about to refer to predictions for condition checks?

Regards,
Markus

