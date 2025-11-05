Return-Path: <linux-fsdevel+bounces-67217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E629C38265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BABF5343621
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAD2F0671;
	Wed,  5 Nov 2025 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="l7YRl4gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F466287505;
	Wed,  5 Nov 2025 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380620; cv=none; b=NdfPfn/usA7jJcIZiwtCPoblj67fXG6/Ltyp5//XPHFR/CfqfrXGd8d6cmpvrStqRWt2xmYw65rAxRQRDKJaZ4ZHpnRLcRvGGWZyWB0kfGkhSSLR/WJM5eN2VNxR9JvFBseVvnzfd4WGk4AHYWYrav9JfaN+itqy9XN4UEQ0XWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380620; c=relaxed/simple;
	bh=2wQ/AULEjVRZ0RmYgokyGJ8PATYGxIB2adBNIdmJmiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UozNIEv9D4sUBJZ0UHdqsoSOjYuQrtjq+DNDKlRI4DwHrcusi+Te9F229V7/8pWugAOR90C2B7AQVzB2pqPUfccyKgQFOnpvqqDh36NebM6o1q1o8pq3LKh3Tk/cQID9CqnUW2dhHoid8tXRE5OwgaN3XL2sPczJj+2G6I1QR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=l7YRl4gg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762380610; x=1762985410; i=w_armin@gmx.de;
	bh=/Q+Kv1nQi+TzPCqyZZFWZOnoSTCRVKdAdQG2YR7H5LQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l7YRl4ggbFmcEf2+LgMG7qUxhtvE8eGHoVSLqSnISCpjul+s0XPl8r2/xn8APWYp
	 lPdHlXQtdOLahV7U70gC+VNxr6Z/WIqfv251PvXTgwy3Df3F6bbfX8a/06kb8mcw/
	 tt/c4n8oTANfWBY5R7HyKJ4jHG9/UcAdVxF9hRGK++gwN1myKYECTPdlBtoU4OwoG
	 qxslGxm7J1PSqGRfs1Y4+qVFiPsBQ8vhDhrofioqfU6YHz78JwNL7MmShDVICGew3
	 +eozqZmGoc3bzFcBwFKye9tv3AFPHXKPeI76Zo596racxPypJC83KIEqzQX6UNP8p
	 s4IB0x2ZZVYOFG4psA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1vjtQC2MLW-00OjHL; Wed, 05
 Nov 2025 23:10:10 +0100
Message-ID: <8722f933-010f-44c4-9df7-1417207a34b3@gmx.de>
Date: Wed, 5 Nov 2025 23:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] platform/x86: wmi: Move WMI core code into a separate
 directory
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
 Hans de Goede <hansg@kernel.org>, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <20251104204540.13931-1-W_Armin@gmx.de>
 <20251104204540.13931-5-W_Armin@gmx.de>
 <7d0b6d80-4061-9eb5-5aa3-6a37bac3e2b1@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <7d0b6d80-4061-9eb5-5aa3-6a37bac3e2b1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yB0sK00zIFOTpmQA3+yjoxaLm3oZe/EQNLcjRY1ly5FobWsT7Az
 5TL+RsO9nrom/SkayRVNVw5c9RT3+JkpB3jW4jCopajtkPbqF/i9Fl3Xi5OZaeVnjzhwUOl
 mE++AIkpwO9D3aVPUurB7hu/Kp5qMVfSzRCOTrEFPW3qVaT92LT6qEehn+grcEQOL62lY+H
 u52iUQ8C5qkTO+96ZtPuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:phpLWfT0hfc=;CTnuIeJXlVm0AUcvYKh/KT0WO/j
 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
 RKgdbjbv5kqnzFUJTvDzKpwO28/kghRHGfYfde

Am 05.11.25 um 10:41 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 4 Nov 2025, Armin Wolf wrote:
>
>> Move the WMI core code into a separate directory to prepare for
>> future additions to the WMI driver.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   Documentation/driver-api/wmi.rst           |  2 +-
>>   MAINTAINERS                                |  2 +-
>>   drivers/platform/x86/Kconfig               | 30 +------------------
>>   drivers/platform/x86/Makefile              |  2 +-
>>   drivers/platform/x86/wmi/Kconfig           | 34 +++++++++++++++++++++=
+
>>   drivers/platform/x86/wmi/Makefile          |  8 +++++
>>   drivers/platform/x86/{wmi.c =3D> wmi/core.c} |  0
>>   7 files changed, 46 insertions(+), 32 deletions(-)
>>   create mode 100644 drivers/platform/x86/wmi/Kconfig
>>   create mode 100644 drivers/platform/x86/wmi/Makefile
>>   rename drivers/platform/x86/{wmi.c =3D> wmi/core.c} (100%)
>>
>> diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-ap=
i/wmi.rst
>> index 4e8dbdb1fc67..66f0dda153b0 100644
>> --- a/Documentation/driver-api/wmi.rst
>> +++ b/Documentation/driver-api/wmi.rst
>> @@ -16,5 +16,5 @@ which will be bound to compatible WMI devices by the =
driver core.
>>   .. kernel-doc:: include/linux/wmi.h
>>      :internal:
>>  =20
>> -.. kernel-doc:: drivers/platform/x86/wmi.c
>> +.. kernel-doc:: drivers/platform/x86/wmi/core.c
>>      :export:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 46126ce2f968..abc0ff6769a8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -402,7 +402,7 @@ S:	Maintained
>>   F:	Documentation/ABI/testing/sysfs-bus-wmi
>>   F:	Documentation/driver-api/wmi.rst
>>   F:	Documentation/wmi/
>> -F:	drivers/platform/x86/wmi.c
>> +F:	drivers/platform/x86/wmi/
>>   F:	include/uapi/linux/wmi.h
>>  =20
>>   ACRN HYPERVISOR SERVICE MODULE
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 46e62feeda3c..ef59425580f3 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -16,35 +16,7 @@ menuconfig X86_PLATFORM_DEVICES
>>  =20
>>   if X86_PLATFORM_DEVICES
>>  =20
>> -config ACPI_WMI
>> -	tristate "WMI"
>> -	depends on ACPI
>> -	help
>> -	  This driver adds support for the ACPI-WMI (Windows Management
>> -	  Instrumentation) mapper device (PNP0C14) found on some systems.
>> -
>> -	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
>> -	  ACPI firmware to userspace - this is done through various vendor
>> -	  defined methods and data blocks in a PNP0C14 device, which are then
>> -	  made available for userspace to call.
>> -
>> -	  The implementation of this in Linux currently only exposes this to
>> -	  other kernel space drivers.
>> -
>> -	  This driver is a required dependency to build the firmware specific
>> -	  drivers needed on many machines, including Acer and HP laptops.
>> -
>> -	  It is safe to enable this driver even if your DSDT doesn't define
>> -	  any ACPI-WMI devices.
>> -
>> -config ACPI_WMI_LEGACY_DEVICE_NAMES
>> -	bool "Use legacy WMI device naming scheme"
>> -	depends on ACPI_WMI
>> -	help
>> -	  Say Y here to force the WMI driver core to use the old WMI device n=
aming
>> -	  scheme when creating WMI devices. Doing so might be necessary for s=
ome
>> -	  userspace applications but will cause the registration of WMI devic=
es with
>> -	  the same GUID to fail in some corner cases.
>> +source "drivers/platform/x86/wmi/Kconfig"
>>  =20
>>   config WMI_BMOF
>>   	tristate "WMI embedded Binary MOF driver"
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
>> index c7db2a88c11a..c9f6e9275af8 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -5,7 +5,7 @@
>>   #
>>  =20
>>   # Windows Management Interface
>> -obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
>> +obj-y				+=3D wmi/
> Is there a good reason for the first part of the change?
> That is, do you anticipate need for something outside of what this would
> cover:
>
> obj-$(CONFIG_ACPI_WMI)               +=3D wmi/
>
> Other than that, this series looks fine.

The final version will look like this:

wmi-y                   :=3D core.o marshalling.o string.o
obj-$(CONFIG_ACPI_WMI)  +=3D wmi.o

# Unit tests
obj-y                   +=3D tests/

So i think this change is necessary.

Thanks,
Armin Wolf


