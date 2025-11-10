Return-Path: <linux-fsdevel+bounces-67671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D3C461A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C13B1894061
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218DE3074AF;
	Mon, 10 Nov 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YkVWwa2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A926B756;
	Mon, 10 Nov 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772648; cv=none; b=FbiQx4hHAZVFgIbCWYLpPEhOMsNvIpG2C3WbZBH0RpKKutlGYaONvjv4Qhb4TYNPuhw8yy4NLJtjSGCCSFe0L5geLTMqI0vGNLZe3WolSV3eMFWdQ+xDZzT5V74R2x2Rr0uVPS3w95zMxGwf6HZgXD3CCmnfk3ujYrrNOTzrSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772648; c=relaxed/simple;
	bh=r5jQ+yIu763oKhNAZAGzUhjRb6bKpvQX6ufqYs2cyLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1jIiCGjVwm8VVUNtaVTbti/3S5mHmPHSnRjP7o2ZxLp/RV9OigPKCnZ8zMZiem93gfj/IMYLT8v/P+2Ojvxg5JNXtAgSNfOXN1aAbIgmIwdaiKjSCajiDAxreTsUNHMos0wTQUqwhrIJ7WaDuN+K157hvRoqoZtBuwQc10VfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YkVWwa2J; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762772638; x=1763377438; i=w_armin@gmx.de;
	bh=r5jQ+yIu763oKhNAZAGzUhjRb6bKpvQX6ufqYs2cyLo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YkVWwa2JkguC0sLOiygbuDB4GSwk/1IHV/lFyJ7BJWxks/63ZAztW7DyHiRiJGrx
	 IcfhQPw2yATzCJgb0xcm7mVti7HFlFEY9B/RGVr/WQ06a5xCyjz4N8c/InGOvZ2oh
	 nIaED+ojkw8Ey69iuMlnKfarXf2dJAE8ywagu57PWBUkgQvXkKcYFXgG+IULfJrbq
	 eG1NptZz85V4YFT9m5T39Fghb6wd90dyd9maank+z+wX2lp8IBGC0JIavG+VrdtQ+
	 YOR8nl+uumViNmqCxasxrn/5PY6uJzFUtyv1/prDL3OoqPKh7KmU78fihrRyBIJUS
	 2poc3+Y+/ZjYy3wkjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.125.152] ([141.76.8.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1vLiXS2Jqu-009oD9; Mon, 10
 Nov 2025 12:03:58 +0100
Message-ID: <126f3332-ce35-46d0-bd81-a66528f92032@gmx.de>
Date: Mon, 10 Nov 2025 12:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] platform/x86: wmi: Prepare for future changes
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, Hans de Goede <hansg@kernel.org>, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <20251104204540.13931-1-W_Armin@gmx.de>
 <e40a0d9c-7f38-44ab-a954-b09c9687ea88@kernel.org>
 <17515e4d-6e3b-4eb9-99eb-840933315d55@gmx.de>
 <6dcc3eda-f06a-22b3-fff6-f4805f709f5f@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6dcc3eda-f06a-22b3-fff6-f4805f709f5f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/8UsP9ZvpQlvhj1Ls8QLljj+ow1HHmtXxWLssPjTT72dfn/q+tk
 4Nr8nIUoGFE8slK/8Z5puO8zC0gsNPGkAS1cSDK8IjUdfQL50rL07/Dj8pcJLZ5L3RxQzb1
 jop0t3FuEQDayIO660tgLc2f/Sz4De6t956cNI4AJR0GdO6m4FnHAMOicZj8ZU8eXGqHL6z
 hpNQcm59SV2I/52JUqOSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V1ph19vAYaI=;yHbIt97/+aAtBZJjfEPYJHr6MDe
 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
 JQJ5l5w7xRtLQXH7U=

Am 10.11.25 um 12:00 schrieb Ilpo J=C3=A4rvinen:

> On Wed, 5 Nov 2025, Armin Wolf wrote:
>
>> Am 04.11.25 um 21:52 schrieb Mario Limonciello:
>>
>>> On 11/4/25 2:45 PM, Armin Wolf wrote:
>>>> After over a year of reverse engineering, i am finally ready to
>>>> introduce support for WMI-ACPI marshalling inside the WMI driver core=
.
>>> marshaling> Since the resulting patch series is quite large, i am plan=
ning
>>> to
>>>> submit the necessary patches as three separate patch series.
>>>>
>>>> This is supposed to be the first of the three patch series. Its main
>>>> purpose is to prepare the WMI driver core for the upcoming changes.
>>>> The first patch fixes an issue inside the nls utf16 to utf8 conversio=
n
>>>> code, while the next two patches fix some minor issues inside the WMI
>>>> driver core itself. The last patch finally moves the code of the WMI
>>>> driver core into a separate repository to allow for future additions
>>>> without cluttering the main directory.
>>> One question I have here on the patch to move things.
>>>
>>> Since Windows on ARM (WoA) laptops are a thing - is this still actuall=
y x86
>>> specific?=C2=A0 I am wondering if this should be moving to a different=
 subsystem
>>> altogether like ACPI; especially now with this impending other large p=
atch
>>> series you have on your way.
>> I know of a few WoA laptops that contain ACPI-WMI devices, meaning this=
 driver
>> is indeed not x86-specific.
>> However i need to make some changes to the WMI driver core (and actuall=
y tests
>> it on a AArch64 VM) first
>> before moving it out of drivers/platform/x86.
>>
>> Once i am actually ready for this i would prefer to move the whole stuf=
f to
>> drivers/platform, as drivers/acpi
>> IMHO is better suited for core ACPI drivers.
> So no need to put it under drivers/platform/x86/wmi/ then at all. It
> can move directly to drivers/platform/wmi/ and you work there towards
> making it non-x86-specific.

OK, i will send the v2 revision of this series soon.

Thanks,
Armin Wolf


