Return-Path: <linux-fsdevel+bounces-67000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC57C32F9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF23B4EFDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E62E7F0A;
	Tue,  4 Nov 2025 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZAzBnIY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A4D27E;
	Tue,  4 Nov 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289552; cv=none; b=mCsxX0gvZp1phCN0hI+EzC0+fO2gHktQQf/RUIVA/FUmIAq3jtzj6M6Qn95ntQK8Tef5laDmNFKiS/2VdnfPqjctb3ekpdEFkWcSsMMbYhMYDrxX09wxOJXqZo8cDAiZYEo8LujAlsuEoUZruJNHzxx2NEno1KkkdGwX3syqHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289552; c=relaxed/simple;
	bh=LdYsf6Q7sFeSDFSuH51djFML5cRsgTGNO7mFPwkyuQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQL5IBBJwDYATrUr23aDurzN65fevh/mPUxibT58UWFs/W4wBakHKPTuz9W0p+9evXBGrZbsykP/gSe0lisu8dZTb3xjX7llWLG/h7s8Mq3Krv+XkL2lz/UEk10xzutvdWNoqHr6ELZLQ0jsDlCJqNuVFdI1JJdFzkwbdPGJZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZAzBnIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B27AC4CEF7;
	Tue,  4 Nov 2025 20:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762289551;
	bh=LdYsf6Q7sFeSDFSuH51djFML5cRsgTGNO7mFPwkyuQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DZAzBnIYM52HWvkY+QUubrczjaHQy63871/6iqVPYU5syzGZhLPHWkd7bAyB1EXAQ
	 e6YJgvOYrHalnGG30BObgCdzYZnEGxLYpRpjnRFo02FlAKdm76SQzwPUxrq9t+pkHs
	 9NScWe5EnfDzdynwha1DzbIwiy0fqLN3m7zYC1iUAgPZ2u9yRT4CUwSe4w+c0Hv/Wz
	 azFPsiw2dx7RCkEdyP0Qg7CM8RFFHg8f2xcKRqo0e/tQe9fc+3qZUh4u9TUkINUpQD
	 j4aAjEaGmEHhP8Wua+cI9w5H85500IQWbu9cHCphBnVFIleR2F9cUli7PnVFlOMjn6
	 z1/U6jJxFmaKQ==
Message-ID: <e40a0d9c-7f38-44ab-a954-b09c9687ea88@kernel.org>
Date: Tue, 4 Nov 2025 14:52:30 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] platform/x86: wmi: Prepare for future changes
To: Armin Wolf <W_Armin@gmx.de>, viro@zeniv.linux.org.uk, brauner@kernel.org,
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20251104204540.13931-1-W_Armin@gmx.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251104204540.13931-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 2:45 PM, Armin Wolf wrote:
> After over a year of reverse engineering, i am finally ready to
> introduce support for WMI-ACPI marshalling inside the WMI driver core.
marshaling> Since the resulting patch series is quite large, i am 
planning to
> submit the necessary patches as three separate patch series.
> 
> This is supposed to be the first of the three patch series. Its main
> purpose is to prepare the WMI driver core for the upcoming changes.
> The first patch fixes an issue inside the nls utf16 to utf8 conversion
> code, while the next two patches fix some minor issues inside the WMI
> driver core itself. The last patch finally moves the code of the WMI
> driver core into a separate repository to allow for future additions
> without cluttering the main directory.

One question I have here on the patch to move things.

Since Windows on ARM (WoA) laptops are a thing - is this still actually 
x86 specific?  I am wondering if this should be moving to a different 
subsystem altogether like ACPI; especially now with this impending other 
large patch series you have on your way.
> 
> Armin Wolf (4):
>    fs/nls: Fix utf16 to utf8 conversion
>    platform/x86: wmi: Use correct type when populating ACPI objects
>    platform/x86: wmi: Remove extern keyword from prototypes
>    platform/x86: wmi: Move WMI core code into a separate directory
> 
>   Documentation/driver-api/wmi.rst           |  2 +-
>   MAINTAINERS                                |  2 +-
>   drivers/platform/x86/Kconfig               | 30 +------------------
>   drivers/platform/x86/Makefile              |  2 +-
>   drivers/platform/x86/wmi/Kconfig           | 34 ++++++++++++++++++++++
>   drivers/platform/x86/wmi/Makefile          |  8 +++++
>   drivers/platform/x86/{wmi.c => wmi/core.c} | 34 +++++++++++++---------
>   fs/nls/nls_base.c                          | 16 +++++++---
>   include/linux/wmi.h                        | 15 ++++------
>   9 files changed, 84 insertions(+), 59 deletions(-)
>   create mode 100644 drivers/platform/x86/wmi/Kconfig
>   create mode 100644 drivers/platform/x86/wmi/Makefile
>   rename drivers/platform/x86/{wmi.c => wmi/core.c} (98%)
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

