Return-Path: <linux-fsdevel+bounces-11065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F0850935
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 13:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC054285980
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243315B673;
	Sun, 11 Feb 2024 12:31:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B95B200;
	Sun, 11 Feb 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654674; cv=none; b=lE9w7LZQPIk+IVIbCuv1Ay/WDVSMDm7IhCcIEdyEztcs2lqzf/mr7nhLxwpifULuTyKS85Bl+BAQL8VNusIM2NDroTCF2InEowAMz0d4HKx7rs351LnVXMtaaktv5M9hmtE0IWAFZ28FdvKQSoAuD+bn01UUvre+LBHc3gFl3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654674; c=relaxed/simple;
	bh=d+Kuqw4yFYGmeMYBAOquzrrEZIHFiAcHSdD0ITJCwtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuUdB5zSI8StkxNxsmHN9Qt/P5TdoQnOIGjdsa34ITMQEiPlMy/EJmgy2HFO+Jcem1sMFSrj8RS8bK5c5q35QzvJqOgMa3jyqKb/T8gjkrGGnB9Bs82Zfvsv2G4WW4dFAharkV8alve7YUSr0z6EJW76bVojybiSXHrH1LD779g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rZ8zF-0002V8-KE; Sun, 11 Feb 2024 13:31:09 +0100
Message-ID: <bdea4053-b978-489d-a4a2-927685eee4a8@leemhuis.info>
Date: Sun, 11 Feb 2024 13:31:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 0/5] fs/ntfs3: Bugfix
Content-Language: en-US, de-DE
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707654672;89208475;
X-HE-SMSGID: 1rZ8zF-0002V8-KE

On 29.01.24 09:06, Konstantin Komarov wrote:
> 
> This series contains various fixes for ntfs3.
> 
> Konstantin Komarov (5):
>   fs/ntfs3: Prevent generic message "attempt to access beyond end of
>     device"
>   fs/ntfs3: Use i_size_read and i_size_write
>   fs/ntfs3: Correct function is_rst_area_valid
>   fs/ntfs3: Fixed overflow check in mi_enum_attr()
>   fs/ntfs3: Update inode->i_size after success write into compressed
>     file

Thx for working on these patches that recently hit mainline.

The last patch listed above afaics (I might be wrong there!) is a fix
for https://bugzilla.kernel.org/show_bug.cgi?id=218180 (~"data added to
a newly created file that uses compression only becomes visible after a
remount or a forced cache drop"). That regression from the 6.2 days
sounds somewhat concerning, hence allow me to ask: do you plan to submit
this fix for backporting to the 6.7.y and 6.6.y series? If not: do you
think it should be save to include those there?

Side not, while at it: are any of the other patches maybe also worth
backporting?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

