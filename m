Return-Path: <linux-fsdevel+bounces-66903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D9C302B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBCD4FCEDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55C2BEFED;
	Tue,  4 Nov 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EojySN4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCE72605;
	Tue,  4 Nov 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246877; cv=none; b=ugYUlIGNHKfBilmdhImG9VWPndzJQZrPnM+tRKUs0hweKWtqoWdfmJxsfsjE2dqHj+rqGPRWHB3TTNy7UNY+u5eVgreue+tHLAxboVhMo0bCkKr3C1NRnhtBzBlPIUQiTdZ4gBzfJdTn/o5B4UN9dkwBYePK8lXcHjF7/qXsUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246877; c=relaxed/simple;
	bh=UCqspKvuGFqHWxG698yzoFnfxlIZdBjD27JjaClsYNg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Efiprh+doH9Y5bWoCemN4VXICqboDfOMgsy8z/4eRGLnzITEajl5kZ3LUcR6+kLwBhStpMz9nXfZup739XteGOL4AokxyPzWZERUcB8pRB99O5ElqyKFcsJ07iF5aNmgKkylWq52wnKEtaPbw8ghRiwsaxjoyO2HkeARALSn14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EojySN4o; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762246867; x=1762851667; i=markus.elfring@web.de;
	bh=UCqspKvuGFqHWxG698yzoFnfxlIZdBjD27JjaClsYNg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EojySN4og5jcWtGSXmStgcqy2yalY1uM67B29EotKW0AvRJ1TDV7kHfZxddGoulu
	 ruU2wnKtxvvlEj8k5FoOYrf4zak+jrxQ+3FsF6Foa7pw8p/tUJm01Sf6RXmeHa2dP
	 7+Ct9DckB5AK+nglfjEFoBKhyVLVHaXzUkgAkUV9lFcvpibCShno3ON4UeUz4WP+z
	 omX0e6CRq4X3k4b41ctExW2p0PcgHAFtnJjbDzpQFksGzz2RZ5+s1lMRa1RblMEWv
	 Y/bHAoD8r54O+w5GSvzFY2lVBHm2REsQra7x/YpqDmovV/8H8v75yyfGMtuTd2qPs
	 pkMPPAp6l0nyEuzZ2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1vuT3p0uZx-00eAi2; Tue, 04
 Nov 2025 09:55:32 +0100
Message-ID: <f6509ce8-72f9-436e-82ca-dc7bbf601bb3@web.de>
Date: Tue, 4 Nov 2025 09:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] unicode: Completion of error handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ocf4noJcdAYgUVvf2UdDP7Ho6e3T3DO146mj5NumU7dlsPPcJhV
 M29qPTCXfPSDwMMelKEqnBDu5SG2nK+jlxrLMrv4ZDzUBF/qjkTcJukG+tLhrZ86hZtLa/7
 S32bTU5Ond6ntSIRc8X397ig7a/2IrwsOw51Yl7oELjHp/OJshAbHtOIEsat7MtcgjWX4P9
 l37u/idi4AaSCFGywYq7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7MerS+iU8P0=;ix36Mv9ExA5sv6/qMWEh8F2tN0L
 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

Hello,

It can be determined (also with the help of some source code analysis tools)
that error detection (and corresponding exception handling) is incomplete
in this source file.
https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/unicode/mkutf8data.c
https://cwe.mitre.org/data/definitions/252.html

How do you think about to improve affected implementation details?

Regards,
Markus

