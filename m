Return-Path: <linux-fsdevel+bounces-24936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1D946D18
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93901F214BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E918C3B;
	Sun,  4 Aug 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Emc8r4lg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772618028;
	Sun,  4 Aug 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722757172; cv=none; b=QwiW4nckvPIL/akC9Orof+kZSolUtb2wwDmsajziErP/ljXFVjzxdzrOR+aXS73rMKeVXR0SBl6jhK2djNcNJkVRwQ5e6zC8xsYIQHy0J19HlPP9iHRWilQAjtn0Wfnvx1ZFfBEW9wDc11cxK5cYXkUcXK7ladA50/mvBMw2Zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722757172; c=relaxed/simple;
	bh=dx1qsJWwPqbDPWHNQRSyT6YxQ55c4Kz9aQMnwMhOiK0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=bfreXouz4tX7VcToC338ngUiuI/l20hDViaZN8mFTbacN5b0Cm8MDqpfDEKiXDoou7J+NBCAyoloagvXDZw2OzwnDkrFfPhZqnHLKrTfqB2tTd4efUMalu3AqueSERN2ufnC19/RxSCHgE4ehF5Dcp2nky4Mf0y9NtYwOccOjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Emc8r4lg; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=VA7tExR2XPaZPXzIax6ElMB4EKjXC6966mpWAb1KBac=; t=1722757170;
	x=1723189170; b=Emc8r4lgGpiS74tsqEdgVZbpUa5GfpkWoCV0ocE2yTL7nDO8uSUo878CjSx+H
	w26OEaWUeraHvpYKXKFFNDZbxQwrYdmwv1rju0HHeY68BSCbENABLevqYAzNFjOcDDUILqq6PhUQJ
	+lSG+kYts3woDXLueMqNtCNGU2Pw5wt9EbyOX55uXcdwQ75CaM+wZAekMScMYCQe0gyJi2/EmQ2w5
	vsjpBVO4LLjk/pbToN/sG5WdW2/vtTcKoDnymru2OWIRKnFSurQsXqsr6MgMQi1nQegU5YcB8zUIY
	GOcPgSMecknYlirVEjZ9VsBKh3goaQBLHYf1l6EoHl/kw7Eo+A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1saVpv-0005fK-1W; Sun, 04 Aug 2024 09:39:27 +0200
Message-ID: <412463d7-5259-4c99-bfda-1f5f9d2893cf@leemhuis.info>
Date: Sun, 4 Aug 2024 09:39:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Matan Ziv-Av <matan@svgalib.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] LG Gram Laptop Extra Features stopped working
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722757170;ce8c2813;
X-HE-SMSGID: 1saVpv-0005fK-1W

Hi, Thorsten here, the Linux kernel's regression tracker.

Jann, I noticed a report about a regression in bugzilla.kernel.org that
appears to be caused directly or indirectly by a change of yours:

3cad1bc010416c ("filelock: Remove locks reliably when fcntl/close race
is detected") [v6.10-rc7]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219075 :

> On my 2023, LG Gram laptop (kernel 6.9.10), the Laptop extra features
> stopped working, and like in
> https://bugzilla.kernel.org/show_bug.cgi?id=218901, none of the
> kernel variables for the are writable. for example, trying to write
> 80 to `/sys/devices/platform/lg-laptop/battery_care_limit` or
> `/sys/class/power_supply/BAT0/charge_control_end_threshold` results
> in 0 when running cat. The same issue occurs when I try set these
> parameters with EndeavorOS.
> 
> 
> Output of `sudo dmesg | grep -iC 3 "lg_laptop" `
> 
> ``
> [    4.283723] ACPI Error: No handler for Region [XIN1] (0000000011d0c87d) [UserDefinedRegion] (20230628/evregion-126)
> [    4.284919] ACPI Error: Region UserDefinedRegion (ID=143) has no handler (20230628/exfldio-261)
> [    4.286191] ACPI Error: Aborting method \_SB.PC00.LPCB.LGEC.SEN1._TMP due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    4.286773] lg_laptop: product: 16ZB90R-G.AA75G  year: 2019
> [    4.292951] input: LG WMI hotkeys as /devices/virtual/input/input6
> [    4.293115] ACPI: battery: new extension: LG Battery Extension
> [    4.293296] resource: resource sanity check: requesting [mem 0x00000000fedc0000-0x00000000fedcffff], which spans more than pnp 00:04 [mem 0xfedc0000-0xfedc7fff]
> ``

6.11-rc1 is still affected.

See the ticket for more details and additional comments. Note, you have
to use bugzilla to reach the reporter, as I sadly[1] can not CCed them
in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 3cad1bc010416c6dd780643476bc59ed742436b9
#regzbot title: vfs/platform-drivers: LG Gram Laptop Extra Features
stopped working
#regzbot from: Chris
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219075
#regzbot ignore-activity

