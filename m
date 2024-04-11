Return-Path: <linux-fsdevel+bounces-16751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51E8A2188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 00:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA7F1F22380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E623BB4B;
	Thu, 11 Apr 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ob7tGOMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9E36B08;
	Thu, 11 Apr 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872880; cv=none; b=DcYUHSS3tOnCw66cKp+rIjt+QdXOwSA2/nfMmLP1KsRn7k9iK9B4xB0rxratWJ9p30UEYTX7uYMeYQwi/cvr+h/piYBQQZNn+3hSrQ6JrkRlyxg4Dfl2ocLqEpbqItJz7hwiMNJf7Sp6wE2TL39l2fqXvCE37mbWnukPo1ox/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872880; c=relaxed/simple;
	bh=NM0xwOfOPPqrP2VtzG0GkjtWtjUJMwnOvJYOyd6gN+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWeEBirM+YaNQnYrm+93E1GfJsnJRYKrm+VNNakVS9+xZ5+CraTZb7R/XjbVm8CsTxPdLeD58IanGnAkREO1dBQcOqC0Cel+XMzfjea3RCpwyWc2g/hgKAeob8Zke3yoVgG+ZKBIxWruowVE4Y0ifTIKqXwbhGfjxsWuEJ5Wytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ob7tGOMT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712872865; x=1713477665; i=spasswolf@web.de;
	bh=Es4aq1fCqCkuhgezzGXwBgCdQNwTNMw5Jt3QW7YkNQ4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ob7tGOMTEr9KLl5MtAuYODyqpg27vIi04tb3kT0GtVuSabT2nOjlX81YrT99HXz5
	 CkwjtDcBP5qO8ryWAcVHlHLlCbMJFxR4GUgIA4AElV0e2KbPMt03Ym059pGuVtIwE
	 abtft8XU/8ILN13EHZ1T5Fizmwhnlb9ulm9GSX8mSw7CzqgmkvODBXePUGIanMESh
	 WPIL4u1LDCLfpA3hTGtyrWyHcE2PEi+42I/wRfl/gKMrmP7le3Yq3Acv8jSID3R+3
	 FVcPxS9P2Fge6wA3nwiyCTdlq0v2L1EpGrlYJm7xdOOp+idDLvHQIQ06fO3tcglyB
	 bbpEXFLZtSGVMgzxUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVacq-1sMUyr2jW0-00Ra6K; Fri, 12
 Apr 2024 00:01:05 +0200
Message-ID: <b59ce453edfa342b6287f433997bf50ecf39f4f7.camel@web.de>
Subject: Re: commit e57bf9cda9cd ("timerfd: convert to ->read_iter()")
 breaks booting on debian stable (bookworm, 12.5)
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Date: Fri, 12 Apr 2024 00:01:05 +0200
In-Reply-To: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
References: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:czzLFDI6MoMTc19FwbmknXKNOyKHep3DRXUyZYL0HwTYOrQRXLc
 TLik2pYQ7fKrqNj5Ah7PnIOx/9Aum16jh7GuzIsuTWltfxp9Pw44eI2grbni2+gEsbP5chk
 FUBBmCkU88L3woYytrvDSPi4D9KsFjAAKB/Ek5i0ohqCNHbWw7ayEc8vvJB49YX+/UL2z3m
 iFHur+cOCnapW3TvERmYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dUhL6I84lq4=;NouLy+N/SfWRisyDipfUyHeJvH6
 m+WeBwMqpFiKun7JnrI1AoBuv9uJWgacWeRN/VIatfL2DIeReDpimSUQ6Rve05OtZKO5L3Xa7
 06iFE1ln0h3QrkrFV+4JkegGTMHn5wYy5FrFUrWGVxpFPvBPMXYJnxYil5+B6VC8PpS43KOJO
 pNuAg/INJE8XeID8dS4ZfLIohzV68wutn7pvIhSNXArSKhzt1X8akCFKR8koukxhxSD/JCE/z
 JaKNzz/krLA6VX71n3ZlxBsV90vmgTT1q2zRUgR8HbGTHwZJ/O09ZIyKsIHJ7DZ4RtC6WqO3m
 zXIZP9gskAdmPQ6R8IYZa095RwBfLk7TC/PM1NbM2sn0izh05zHmaZ4+RhtUHQVfBZbqhs0QZ
 GadeEkh707AqiYMZssSZQ6LcIRlijshmvlMLlsrQWZ6QZGIFfURR52Tx63P8cfQ5Inc41ZgU1
 eLcGI/OTfjeV6AsILn3SomTMwsVvabN2eXTsu7JTDcB90JS+SwXgMrHIkSZOVOmWizUmQHvLw
 KCaysVydVxOC9EmUtaOffKhrtWxYJ9cZkd2ePdaF1ML66r2KejnXNu0FaTaDHZhXVzsZFpWo1
 3rehAcuAD1jjV2jIc/nQ9Vp8y8BG9S1bX2oLiLohUmYxP2+6e5WJDkNP8puGqyDGMfAOeG8Zx
 yAYRKJiueTwgqSbuKjKJADpCkgDNbrKApLLP8TUkKntWaUDoxbeznMQ51KTDjvzggj62KBUk9
 LkHcKcYmma3xd9CkS81s4MLrbFqz/Oc83JZerRE/b8lOsFofSNpz/fSizQ0w8DZGVzMKZdKVT
 6ouBhJ4g320+/2u9t13bkJk7dJXnbWPb/CUtGhptCwPkk=

These are the kernel messages from the first failed boot, no error to see =
here,
but the machine does not boot properly either:

[    0.000000][    T0] Linux version 6.9.0-rc3-next-20240411 (bert@lisa) (=
gcc
(Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1168 SM=
P
PREEMPT_DYNAMIC Thu Apr 11 09:28:24 CEST 2024
[    0.000000][    T0] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-rc3-=
next-
20240411 root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b6112 ro clocksource=
=3Dhpet
amdgpu.noretry=3D0 amdgpu.mcbp=3D1 quiet
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009ff=
ff]
usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fff=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfef=
ff]
usable
[    0.000000][    T0] BIOS-e820: [mem 0x0000000009bff000-0x000000000a000f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x000000000a001000-0x000000000a1fff=
ff]
usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000a200000-0x000000000a20ef=
ff]
ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x000000000a20f000-0x00000000e9e1ff=
ff]
usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000e9e20000-0x00000000eb33ef=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000eb33f000-0x00000000eb39ef=
ff]
ACPI data
[    0.000000][    T0] BIOS-e820: [mem 0x00000000eb39f000-0x00000000eb556f=
ff]
ACPI NVS
[    0.000000][    T0] BIOS-e820: [mem 0x00000000eb557000-0x00000000ed17cf=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000ed17d000-0x00000000ed1fef=
ff]
type 20
[    0.000000][    T0] BIOS-e820: [mem 0x00000000ed1ff000-0x00000000edffff=
ff]
usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000ee000000-0x00000000f7ffff=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fd000000-0x00000000fdffff=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ff=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fedc4000-0x00000000fedc9f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fedcc000-0x00000000fedcef=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fedd5000-0x00000000fedd5f=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffff=
ff]
reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x0000000fee2fff=
ff]
usable
[    0.000000][    T0] BIOS-e820: [mem 0x0000000fee300000-0x000000100fffff=
ff]
reserved
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] efi: EFI v2.7 by American Megatrends
[    0.000000][    T0] efi: ACPI=3D0xeb540000 ACPI 2.0=3D0xeb540014
TPMFinalLog=3D0xeb50c000 SMBIOS=3D0xed020000 SMBIOS 3.0=3D0xed01f000
MEMATTR=3D0xe6fa0018 ESRT=3D0xe87cb898
[    0.000000][    T0] efi: Remove mem54: MMIO range=3D[0xf0000000-0xf7fff=
fff]
(128MB) from e820 map
[    0.000000][    T0] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000][    T0] efi: Remove mem55: MMIO range=3D[0xfd000000-0xfdfff=
fff]
(16MB) from e820 map
[    0.000000][    T0] e820: remove [mem 0xfd000000-0xfdffffff] reserved
[    0.000000][    T0] efi: Remove mem56: MMIO range=3D[0xfeb80000-0xfec01=
fff]
(0MB) from e820 map
[    0.000000][    T0] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    0.000000][    T0] efi: Not removing mem57: MMIO range=3D[0xfec10000-
0xfec10fff] (4KB) from e820 map
[    0.000000][    T0] efi: Not removing mem58: MMIO range=3D[0xfed00000-
0xfed00fff] (4KB) from e820 map
[    0.000000][    T0] efi: Not removing mem59: MMIO range=3D[0xfed40000-
0xfed44fff] (20KB) from e820 map
[    0.000000][    T0] efi: Not removing mem60: MMIO range=3D[0xfed80000-
0xfed8ffff] (64KB) from e820 map
[    0.000000][    T0] efi: Not removing mem61: MMIO range=3D[0xfedc4000-
0xfedc9fff] (24KB) from e820 map
[    0.000000][    T0] efi: Not removing mem62: MMIO range=3D[0xfedcc000-
0xfedcefff] (12KB) from e820 map
[    0.000000][    T0] efi: Not removing mem63: MMIO range=3D[0xfedd5000-
0xfedd5fff] (4KB) from e820 map
[    0.000000][    T0] efi: Remove mem64: MMIO range=3D[0xff000000-0xfffff=
fff]
(16MB) from e820 map
[    0.000000][    T0] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000][    T0] SMBIOS 3.3.0 present.
[    0.000000][    T0] DMI: Micro-Star International Co., Ltd. Alpha 15
B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[    0.000000][    T0] tsc: Fast TSC calibration using PIT
[    0.000000][    T0] tsc: Detected 3194.029 MHz processor
[    0.000127][    T0] e820: update [mem 0x00000000-0x00000fff] usable =3D=
=3D>
reserved
[    0.000128][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000132][    T0] last_pfn =3D 0xfee300 max_arch_pfn =3D 0x400000000
[    0.000136][    T0] MTRR map: 5 entries (3 fixed + 2 variable; max 20),=
 built
from 9 variable MTRRs
[    0.000137][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  W=
P  UC-
WT
[    0.000352][    T0] e820: update [mem 0xf0000000-0xffffffff] usable =3D=
=3D>
reserved
[    0.000356][    T0] last_pfn =3D 0xee000 max_arch_pfn =3D 0x400000000
[    0.002717][    T0] esrt: Reserving ESRT space from 0x00000000e87cb898 =
to
0x00000000e87cb8d0.
[    0.002722][    T0] e820: update [mem 0xe87cb000-0xe87cbfff] usable =3D=
=3D>
reserved
[    0.002730][    T0] Using GB pages for direct mapping
[    0.002855][    T0] Secure boot disabled
[    0.002856][    T0] RAMDISK: [mem 0x329a9000-0x354cbfff]
[    0.002861][    T0] ACPI: Early table checksum verification disabled
[    0.002863][    T0] ACPI: RSDP 0x00000000EB540014 000024 (v02 MSI_NB)
[    0.002865][    T0] ACPI: XSDT 0x00000000EB53F728 000114 (v01 MSI_NB ME=
GABOOK
01072009 AMI  01000013)
[    0.002869][    T0] ACPI: FACP 0x00000000EB390000 000114 (v06 MSI_NB ME=
GABOOK
01072009 AMI  00010013)
[    0.002872][    T0] ACPI: DSDT 0x00000000EB383000 00C50C (v02 MSI_NB ME=
GABOOK
01072009 INTL 20190509)
[    0.002874][    T0] ACPI: FACS 0x00000000EB50A000 000040
[    0.002875][    T0] ACPI: SLIC 0x00000000EB39E000 000176 (v01 MSI_NB ME=
GABOOK
01072009 AMI  01000013)
[    0.002877][    T0] ACPI: SSDT 0x00000000EB396000 0072B0 (v02 AMD    Am=
dTable
00000002 MSFT 04000000)
[    0.002878][    T0] ACPI: IVRS 0x00000000EB395000 0001A4 (v02 AMD    Am=
dTable
00000001 AMD  00000000)
[    0.002879][    T0] ACPI: SSDT 0x00000000EB391000 003A21 (v01 AMD    AM=
D AOD
00000001 INTL 20190509)
[    0.002880][    T0] ACPI: FIDT 0x00000000EB382000 00009C (v01 MSI_NB ME=
GABOOK
01072009 AMI  00010013)
[    0.002881][    T0] ACPI: ECDT 0x00000000EB381000 0000C1 (v01 MSI_NB ME=
GABOOK
01072009 AMI. 00010013)
[    0.002883][    T0] ACPI: MCFG 0x00000000EB380000 00003C (v01 MSI_NB ME=
GABOOK
01072009 MSFT 00010013)
[    0.002884][    T0] ACPI: HPET 0x00000000EB37F000 000038 (v01 MSI_NB ME=
GABOOK
01072009 AMI  00000005)
[    0.002885][    T0] ACPI: VFCT 0x00000000EB371000 00D884 (v01 MSI_NB ME=
GABOOK
00000001 AMD  31504F47)
[    0.002886][    T0] ACPI: BGRT 0x00000000EB370000 000038 (v01 MSI_NB ME=
GABOOK
01072009 AMI  00010013)
[    0.002887][    T0] ACPI: TPM2 0x00000000EB36F000 00004C (v04 MSI_NB ME=
GABOOK
00000001 AMI  00000000)
[    0.002889][    T0] ACPI: SSDT 0x00000000EB369000 005354 (v02 AMD    Am=
dTable
00000001 AMD  00000001)
[    0.002890][    T0] ACPI: CRAT 0x00000000EB368000 000EE8 (v01 AMD    Am=
dTable
00000001 AMD  00000001)
[    0.002891][    T0] ACPI: CDIT 0x00000000EB367000 000029 (v01 AMD    Am=
dTable
00000001 AMD  00000001)
[    0.002892][    T0] ACPI: SSDT 0x00000000EB366000 000149 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002893][    T0] ACPI: SSDT 0x00000000EB364000 00148E (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002894][    T0] ACPI: SSDT 0x00000000EB362000 00153F (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002895][    T0] ACPI: SSDT 0x00000000EB361000 000696 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002897][    T0] ACPI: SSDT 0x00000000EB35F000 001A56 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002898][    T0] ACPI: SSDT 0x00000000EB35E000 0005DE (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002899][    T0] ACPI: SSDT 0x00000000EB35A000 0036E9 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002900][    T0] ACPI: WSMT 0x00000000EB359000 000028 (v01 MSI_NB ME=
GABOOK
01072009 AMI  00010013)
[    0.002901][    T0] ACPI: APIC 0x00000000EB358000 0000DE (v03 MSI_NB ME=
GABOOK
01072009 AMI  00010013)
[    0.002902][    T0] ACPI: SSDT 0x00000000EB357000 00008D (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002903][    T0] ACPI: SSDT 0x00000000EB356000 0008A8 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002904][    T0] ACPI: SSDT 0x00000000EB355000 0001B7 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002906][    T0] ACPI: SSDT 0x00000000EB354000 0007B1 (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002907][    T0] ACPI: SSDT 0x00000000EB353000 00097D (v01 AMD    Am=
dTable
00000001 INTL 20190509)
[    0.002908][    T0] ACPI: FPDT 0x00000000EB352000 000044 (v01 MSI_NB A =
M I
01072009 AMI  01000013)
[    0.002909][    T0] ACPI: Reserving FACP table memory at [mem 0xeb39000=
0-
0xeb390113]
[    0.002910][    T0] ACPI: Reserving DSDT table memory at [mem 0xeb38300=
0-
0xeb38f50b]
[    0.002910][    T0] ACPI: Reserving FACS table memory at [mem 0xeb50a00=
0-
0xeb50a03f]
[    0.002911][    T0] ACPI: Reserving SLIC table memory at [mem 0xeb39e00=
0-
0xeb39e175]
[    0.002911][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb39600=
0-
0xeb39d2af]
[    0.002911][    T0] ACPI: Reserving IVRS table memory at [mem 0xeb39500=
0-
0xeb3951a3]
[    0.002912][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb39100=
0-
0xeb394a20]
[    0.002912][    T0] ACPI: Reserving FIDT table memory at [mem 0xeb38200=
0-
0xeb38209b]
[    0.002912][    T0] ACPI: Reserving ECDT table memory at [mem 0xeb38100=
0-
0xeb3810c0]
[    0.002913][    T0] ACPI: Reserving MCFG table memory at [mem 0xeb38000=
0-
0xeb38003b]
[    0.002913][    T0] ACPI: Reserving HPET table memory at [mem 0xeb37f00=
0-
0xeb37f037]
[    0.002914][    T0] ACPI: Reserving VFCT table memory at [mem 0xeb37100=
0-
0xeb37e883]
[    0.002914][    T0] ACPI: Reserving BGRT table memory at [mem 0xeb37000=
0-
0xeb370037]
[    0.002914][    T0] ACPI: Reserving TPM2 table memory at [mem 0xeb36f00=
0-
0xeb36f04b]
[    0.002915][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb36900=
0-
0xeb36e353]
[    0.002915][    T0] ACPI: Reserving CRAT table memory at [mem 0xeb36800=
0-
0xeb368ee7]
[    0.002915][    T0] ACPI: Reserving CDIT table memory at [mem 0xeb36700=
0-
0xeb367028]
[    0.002916][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb36600=
0-
0xeb366148]
[    0.002916][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb36400=
0-
0xeb36548d]
[    0.002917][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb36200=
0-
0xeb36353e]
[    0.002917][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb36100=
0-
0xeb361695]
[    0.002917][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35f00=
0-
0xeb360a55]
[    0.002918][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35e00=
0-
0xeb35e5dd]
[    0.002918][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35a00=
0-
0xeb35d6e8]
[    0.002918][    T0] ACPI: Reserving WSMT table memory at [mem 0xeb35900=
0-
0xeb359027]
[    0.002919][    T0] ACPI: Reserving APIC table memory at [mem 0xeb35800=
0-
0xeb3580dd]
[    0.002919][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35700=
0-
0xeb35708c]
[    0.002920][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35600=
0-
0xeb3568a7]
[    0.002920][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35500=
0-
0xeb3551b6]
[    0.002920][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35400=
0-
0xeb3547b0]
[    0.002921][    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35300=
0-
0xeb35397c]
[    0.002921][    T0] ACPI: Reserving FPDT table memory at [mem 0xeb35200=
0-
0xeb352043]
[    0.002957][    T0] Zone ranges:
[    0.002957][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffff=
ff]
[    0.002959][    T0]   DMA32    [mem 0x0000000001000000-0x00000000ffffff=
ff]
[    0.002959][    T0]   Normal   [mem 0x0000000100000000-0x0000000fee2fff=
ff]
[    0.002960][    T0]   Device   empty
[    0.002961][    T0] Movable zone start for each node
[    0.002961][    T0] Early memory node ranges
[    0.002962][    T0]   node   0: [mem 0x0000000000001000-0x000000000009f=
fff]
[    0.002962][    T0]   node   0: [mem 0x0000000000100000-0x0000000009bfe=
fff]
[    0.002963][    T0]   node   0: [mem 0x000000000a001000-0x000000000a1ff=
fff]
[    0.002963][    T0]   node   0: [mem 0x000000000a20f000-0x00000000e9e1f=
fff]
[    0.002964][    T0]   node   0: [mem 0x00000000ed1ff000-0x00000000edfff=
fff]
[    0.002964][    T0]   node   0: [mem 0x0000000100000000-0x0000000fee2ff=
fff]
[    0.002966][    T0] Initmem setup node 0 [mem 0x0000000000001000-
0x0000000fee2fffff]
[    0.002971][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002981][    T0] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.003071][    T0] On node 0, zone DMA32: 1026 pages in unavailable ra=
nges
[    0.006707][    T0] On node 0, zone DMA32: 15 pages in unavailable rang=
es
[    0.006786][    T0] On node 0, zone DMA32: 13279 pages in unavailable r=
anges
[    0.006969][    T0] On node 0, zone Normal: 8192 pages in unavailable r=
anges
[    0.007002][    T0] On node 0, zone Normal: 7424 pages in unavailable r=
anges
[    0.007969][    T0] ACPI: PM-Timer IO Port: 0x808
[    0.007975][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.007985][    T0] IOAPIC[0]: apic_id 33, version 33, address 0xfec000=
00,
GSI 0-23
[    0.007990][    T0] IOAPIC[1]: apic_id 34, version 33, address 0xfec010=
00,
GSI 24-55
[    0.007992][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl=
 dfl)
[    0.007993][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low
level)
[    0.007995][    T0] ACPI: Using ACPI (MADT) for SMP configuration infor=
mation
[    0.007996][    T0] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.008002][    T0] e820: update [mem 0xe62ee000-0xe63e1fff] usable =3D=
=3D>
reserved
[    0.008013][    T0] CPU topo: Max. logical packages:   1
[    0.008013][    T0] CPU topo: Max. logical dies:       1
[    0.008013][    T0] CPU topo: Max. dies per package:   1
[    0.008016][    T0] CPU topo: Max. threads per core:   2
[    0.008017][    T0] CPU topo: Num. cores per package:     8
[    0.008017][    T0] CPU topo: Num. threads per package:  16
[    0.008017][    T0] CPU topo: Allowing 16 present CPUs plus 0 hotplug C=
PUs
[    0.008029][    T0] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.008030][    T0] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000fffff]
[    0.008031][    T0] PM: hibernation: Registered nosave memory: [mem
0x09bff000-0x0a000fff]
[    0.008032][    T0] PM: hibernation: Registered nosave memory: [mem
0x0a200000-0x0a20efff]
[    0.008032][    T0] PM: hibernation: Registered nosave memory: [mem
0xe62ee000-0xe63e1fff]
[    0.008033][    T0] PM: hibernation: Registered nosave memory: [mem
0xe87cb000-0xe87cbfff]
[    0.008034][    T0] PM: hibernation: Registered nosave memory: [mem
0xe9e20000-0xeb33efff]
[    0.008034][    T0] PM: hibernation: Registered nosave memory: [mem
0xeb33f000-0xeb39efff]
[    0.008035][    T0] PM: hibernation: Registered nosave memory: [mem
0xeb39f000-0xeb556fff]
[    0.008035][    T0] PM: hibernation: Registered nosave memory: [mem
0xeb557000-0xed17cfff]
[    0.008035][    T0] PM: hibernation: Registered nosave memory: [mem
0xed17d000-0xed1fefff]
[    0.008036][    T0] PM: hibernation: Registered nosave memory: [mem
0xee000000-0xefffffff]
[    0.008036][    T0] PM: hibernation: Registered nosave memory: [mem
0xf0000000-0xfec0ffff]
[    0.008037][    T0] PM: hibernation: Registered nosave memory: [mem
0xfec10000-0xfec10fff]
[    0.008037][    T0] PM: hibernation: Registered nosave memory: [mem
0xfec11000-0xfecfffff]
[    0.008037][    T0] PM: hibernation: Registered nosave memory: [mem
0xfed00000-0xfed00fff]
[    0.008038][    T0] PM: hibernation: Registered nosave memory: [mem
0xfed01000-0xfed3ffff]
[    0.008038][    T0] PM: hibernation: Registered nosave memory: [mem
0xfed40000-0xfed44fff]
[    0.008038][    T0] PM: hibernation: Registered nosave memory: [mem
0xfed45000-0xfed7ffff]
[    0.008039][    T0] PM: hibernation: Registered nosave memory: [mem
0xfed80000-0xfed8ffff]
[    0.008039][    T0] PM: hibernation: Registered nosave memory: [mem
0xfed90000-0xfedc3fff]
[    0.008039][    T0] PM: hibernation: Registered nosave memory: [mem
0xfedc4000-0xfedc9fff]
[    0.008039][    T0] PM: hibernation: Registered nosave memory: [mem
0xfedca000-0xfedcbfff]
[    0.008040][    T0] PM: hibernation: Registered nosave memory: [mem
0xfedcc000-0xfedcefff]
[    0.008040][    T0] PM: hibernation: Registered nosave memory: [mem
0xfedcf000-0xfedd4fff]
[    0.008040][    T0] PM: hibernation: Registered nosave memory: [mem
0xfedd5000-0xfedd5fff]
[    0.008041][    T0] PM: hibernation: Registered nosave memory: [mem
0xfedd6000-0xffffffff]
[    0.008042][    T0] [mem 0xf0000000-0xfec0ffff] available for PCI devic=
es
[    0.008044][    T0] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.008049][    T0] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_=
ids:16
nr_node_ids:1
[    0.008390][    T0] percpu: Embedded 45 pages/cpu s143464 r8192 d32664
u262144
[    0.008394][    T0] pcpu-alloc: s143464 r8192 d32664 u262144 alloc=3D1*=
2097152
[    0.008395][    T0] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 1=
0 11
12 13 14 15
[    0.008407][    T0] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.9=
.0-rc3-
next-20240411 root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b6112 ro clocks=
ource=3Dhpet
amdgpu.noretry=3D0 amdgpu.mcbp=3D1 quiet
[    0.008442][    T0] Unknown kernel command line parameters
"BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-rc3-next-20240411", will be passed to us=
er
space.
[    0.008469][    T0] random: crng init done
[    0.012671][    T0] Dentry cache hash table entries: 8388608 (order: 14=
,
67108864 bytes, linear)
[    0.014717][    T0] Inode-cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.014776][    T0] Built 1 zonelists, mobility grouping on.  Total pag=
es:
16616111
[    0.014778][    T0] mem auto-init: stack:off, heap alloc:off, heap free=
:off,
mlocked free:off
[    0.014815][    T0] software IO TLB: area num 16.
[    0.030225][    T0] Memory: 3784692K/66464444K available (12288K kernel=
 code,
1066K rwdata, 3580K rodata, 1372K init, 1528K bss, 1350924K reserved, 0K c=
ma-
reserved)
[    0.030332][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CP=
Us=3D16,
Nodes=3D1
[    0.030373][    T0] Dynamic Preempt: full
[    0.030419][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.030420][    T0] 	Trampoline variant of Tasks RCU enabled.
[    0.030421][    T0] 	Tracing variant of Tasks RCU enabled.
[    0.030421][    T0] rcu: RCU calculated value of scheduler-enlistment d=
elay
is 100 jiffies.
[    0.030429][    T0] RCU Tasks: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1.
[    0.030432][    T0] RCU Tasks Trace: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1.
[    0.030433][    T0] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.030612][    T0] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.030671][    T0] Console: colour dummy device 80x25
[    0.030673][    T0] printk: legacy console [tty0] enabled
[    0.030689][    T0] ACPI: Core revision 20230628
[    0.030869][    T0] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.030886][    T0] APIC: Switch to symmetric I/O mode setup
[    0.031460][    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdev=
id:160
[    0.031462][    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdev=
id:160
[    0.031463][    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdev=
id:160
[    0.031464][    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdev=
id:160
[    0.031464][    T0] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade,
EFR2:0x0
[    0.031716][    T0] APIC: Switched APIC routing to: physical flat
[    0.032304][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-=
1 pin2=3D-1
[    0.036892][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2e0a41ca3be, max_idle_ns: 440795356728 ns
[    0.036898][    T0] Calibrating delay loop (skipped), value calculated =
using
timer frequency.. 6388.05 BogoMIPS (lpj=3D3194029)
[    0.036916][    T0] x86/cpu: User Mode Instruction Prevention (UMIP)
activated
[    0.036949][    T0] LVT offset 1 assigned for vector 0xf9
[    0.037057][    T0] LVT offset 2 assigned for vector 0xf4
[    0.037081][    T0] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.037082][    T0] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 10=
24,
1GB 0
[    0.037084][    T0] process: using mwait in idle threads
[    0.037087][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers a=
nd
__user pointer sanitization
[    0.037089][    T0] Spectre V2 : Mitigation: Retpolines
[    0.037089][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fi=
lling
RSB on context switch
[    0.037090][    T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB =
on
VMEXIT
[    0.037090][    T0] Spectre V2 : Enabling Restricted Speculation for fi=
rmware
calls
[    0.037092][    T0] Spectre V2 : mitigation: Enabling conditional Indir=
ect
Branch Prediction Barrier
[    0.037092][    T0] Spectre V2 : User space: Mitigation: STIBP always-o=
n
protection
[    0.037094][    T0] Speculative Store Bypass: Mitigation: Speculative S=
tore
Bypass disabled via prctl
[    0.037094][    T0] Speculative Return Stack Overflow: IBPB-extending
microcode not applied!
[    0.037095][    T0] Speculative Return Stack Overflow: WARNING: See
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitig=
ation
options.
[    0.037096][    T0] Speculative Return Stack Overflow: Vulnerable: Safe=
 RET,
no microcode
[    0.037101][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 float=
ing
point registers'
[    0.037102][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regis=
ters'
[    0.037102][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regis=
ters'
[    0.037103][    T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protectio=
n Keys
User registers'
[    0.037104][    T0] x86/fpu: Supporting XSAVE feature 0x800: 'Control-f=
low
User registers'
[    0.037105][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  =
256
[    0.037106][    T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:  =
  8
[    0.037106][    T0] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:=
   16
[    0.037107][    T0] x86/fpu: Enabled xstate features 0xa07, context siz=
e is
856 bytes, using 'compacted' format.
[    0.047777][    T0] Freeing SMP alternatives memory: 32K
[    0.047778][    T0] pid_max: default: 32768 minimum: 301
[    0.049596][    T0] Mount-cache hash table entries: 131072 (order: 8, 1=
048576
bytes, linear)
[    0.049663][    T0] Mountpoint-cache hash table entries: 131072 (order:=
 8,
1048576 bytes, linear)
[    0.152196][    T1] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Graphi=
cs
(family: 0x19, model: 0x50, stepping: 0x0)
[    0.152361][    T1] Performance Events: Fam17h+ core perfctr, AMD PMU d=
river.
[    0.152378][    T1] ... version:                0
[    0.152379][    T1] ... bit width:              48
[    0.152380][    T1] ... generic registers:      6
[    0.152380][    T1] ... value mask:             0000ffffffffffff
[    0.152381][    T1] ... max period:             00007fffffffffff
[    0.152382][    T1] ... fixed-purpose events:   0
[    0.152383][    T1] ... event mask:             000000000000003f
[    0.152449][    T1] signal: max sigframe size: 3376
[    0.152471][    T1] rcu: Hierarchical SRCU implementation.
[    0.152472][    T1] rcu: 	Max phase no-delay instances is 400.
[    0.153047][    T9] NMI watchdog: Enabled. Permanently consumes one hw-=
PMU
counter.
[    0.153169][    T1] smp: Bringing up secondary CPUs ...
[    0.153237][    T1] smpboot: x86: Booting SMP configuration:
[    0.153238][    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 =
#14
#1  #3  #5  #7  #9 #11 #13 #15
[    0.163967][    T1] Spectre V2 : Update user space SMT mitigation: STIB=
P
always-on
[    0.170912][    T1] smp: Brought up 1 node, 16 CPUs
[    0.170912][    T1] smpboot: Total of 16 processors activated (102208.9=
2
BogoMIPS)
[    0.227905][   T96] node 0 deferred pages initialised in 56ms
[    0.228667][    T1] devtmpfs: initialized
[    0.228667][    T1] x86/mm: Memory block size: 128MB
[    0.234179][    T1] ACPI: PM: Registering ACPI NVS region [mem 0x0a2000=
00-
0x0a20efff] (61440 bytes)
[    0.234179][    T1] ACPI: PM: Registering ACPI NVS region [mem 0xeb39f0=
00-
0xeb556fff] (1802240 bytes)
[    0.234179][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.234179][    T1] futex hash table entries: 4096 (order: 6, 262144 by=
tes,
linear)
[    0.234179][    T1] pinctrl core: initialized pinctrl subsystem
[    0.234357][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.234470][    T1] audit: initializing netlink subsys (disabled)
[    0.234475][  T107] audit: type=3D2000 audit(1712836198.202:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.234475][    T1] thermal_sys: Registered thermal governor 'fair_shar=
e'
[    0.234475][    T1] thermal_sys: Registered thermal governor 'bang_bang=
'
[    0.234475][    T1] thermal_sys: Registered thermal governor 'step_wise=
'
[    0.234475][    T1] thermal_sys: Registered thermal governor 'user_spac=
e'
[    0.234475][    T1] thermal_sys: Registered thermal governor
'power_allocator'
[    0.234475][    T1] cpuidle: using governor ladder
[    0.234475][    T1] cpuidle: using governor teo
[    0.234931][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver versio=
n: 0.5
[    0.234985][    T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000=
000)
for domain 0000 [bus 00-7f]
[    0.234989][    T1] PCI: not using ECAM ([mem 0xf0000000-0xf7ffffff] no=
t
reserved)
[    0.234991][    T1] PCI: Using configuration type 1 for base access
[    0.234992][    T1] PCI: Using configuration type 1 for extended access
[    0.235054][    T1] kprobes: kprobe jump-optimization is enabled. All k=
probes
are optimized if possible.
[    0.235054][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocat=
ed 0
pages
[    0.235054][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 =
GiB
page
[    0.235054][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocat=
ed 0
pages
[    0.235054][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB=
 page
[    0.235054][    T1] ACPI: Added _OSI(Module Device)
[    0.235054][    T1] ACPI: Added _OSI(Processor Device)
[    0.235054][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.235054][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    0.249579][    T1] ACPI: 16 ACPI AML tables successfully acquired and =
loaded
[    0.250654][    T1] ACPI: EC: EC started
[    0.250655][    T1] ACPI: EC: interrupt blocked
[    0.251177][    T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.251179][    T1] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.251983][    T1] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignore=
d
[    0.253356][    T1] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.254197][    T1] ACPI: Interpreter enabled
[    0.254213][    T1] ACPI: PM: (supports S0 S4 S5)
[    0.254214][    T1] ACPI: Using IOAPIC for interrupt routing
[    0.254404][    T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000=
000)
for domain 0000 [bus 00-7f]
[    0.254434][    T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] reserved as A=
CPI
motherboard resource
[    0.254443][    T1] PCI: Using host bridge windows from ACPI; if necess=
ary,
use "pci=3Dnocrs" and report a bug
[    0.254445][    T1] PCI: Using E820 reservations for host bridge window=
s
[    0.254854][    T1] ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.255505][    T1] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.255661][    T1] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    0.255741][    T1] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power res=
ource
[    0.256753][    T1] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.256779][    T1] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resource
[    0.257316][    T1] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.257342][    T1] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resource
[    0.259149][    T1] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    0.259337][    T1] ACPI: \_SB_.PCI0.GPP5.P0NX: New power resource
[    0.265534][    T1] ACPI: \_SB_.PRWB: New power resource
[    0.267301][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-f=
f])
[    0.267306][    T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig =
ASPM
ClockPM Segments MSI HPX-Type3]
[    0.267378][    T1] acpi PNP0A08:00: _OSC: platform does not support [L=
TR]
[    0.267506][    T1] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug=
 PME
AER PCIeCapability]
[    0.267510][    T1] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0000=
000-
0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers this bridge
[    0.267937][    T1] PCI host bridge to bus 0000:00
[    0.267938][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x03=
af
window]
[    0.267940][    T1] pci_bus 0000:00: root bus resource [io  0x03e0-0x0c=
f7
window]
[    0.267942][    T1] pci_bus 0000:00: root bus resource [io  0x03b0-0x03=
df
window]
[    0.267943][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xff=
ff
window]
[    0.267945][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-
0x000dffff window]
[    0.267946][    T1] pci_bus 0000:00: root bus resource [mem 0xf0000000-
0xfcffffff window]
[    0.267947][    T1] pci_bus 0000:00: root bus resource [mem 0x101000000=
0-
0xffffffffff window]
[    0.267949][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.267964][    T1] pci 0000:00:00.0: [1022:1630] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.268062][    T1] pci 0000:00:00.2: [1022:1631] type 00 class 0x08060=
0
conventional PCI endpoint
[    0.268154][    T1] pci 0000:00:01.0: [1022:1632] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.268226][    T1] pci 0000:00:01.1: [1022:1633] type 01 class 0x06040=
0 PCIe
Root Port
[    0.268241][    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.268246][    T1] pci 0000:00:01.1:   bridge window [mem 0xfca00000-
0xfccfffff]
[    0.268252][    T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000000=
-
0xfe0fffffff 64bit pref]
[    0.268292][    T1] pci 0000:00:01.1: PME# supported from D0 D3hot D3co=
ld
[    0.268397][    T1] pci 0000:00:02.0: [1022:1632] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.268469][    T1] pci 0000:00:02.1: [1022:1634] type 01 class 0x06040=
0 PCIe
Root Port
[    0.268484][    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.268493][    T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300000=
-
0xfe304fffff 64bit pref]
[    0.268532][    T1] pci 0000:00:02.1: PME# supported from D0 D3hot D3co=
ld
[    0.268613][    T1] pci 0000:00:02.2: [1022:1634] type 01 class 0x06040=
0 PCIe
Root Port
[    0.268628][    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.268631][    T1] pci 0000:00:02.2:   bridge window [io  0xf000-0xfff=
f]
[    0.268634][    T1] pci 0000:00:02.2:   bridge window [mem 0xfcf00000-
0xfcffffff]
[    0.268644][    T1] pci 0000:00:02.2: enabling Extended Tags
[    0.268678][    T1] pci 0000:00:02.2: PME# supported from D0 D3hot D3co=
ld
[    0.268760][    T1] pci 0000:00:02.3: [1022:1634] type 01 class 0x06040=
0 PCIe
Root Port
[    0.268774][    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.268778][    T1] pci 0000:00:02.3:   bridge window [mem 0xfce00000-
0xfcefffff]
[    0.268820][    T1] pci 0000:00:02.3: PME# supported from D0 D3hot D3co=
ld
[    0.268902][    T1] pci 0000:00:02.4: [1022:1634] type 01 class 0x06040=
0 PCIe
Root Port
[    0.268917][    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.268921][    T1] pci 0000:00:02.4:   bridge window [mem 0xfcd00000-
0xfcdfffff]
[    0.268932][    T1] pci 0000:00:02.4: enabling Extended Tags
[    0.268965][    T1] pci 0000:00:02.4: PME# supported from D0 D3hot D3co=
ld
[    0.269056][    T1] pci 0000:00:08.0: [1022:1632] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269128][    T1] pci 0000:00:08.1: [1022:1635] type 01 class 0x06040=
0 PCIe
Root Port
[    0.269143][    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.269146][    T1] pci 0000:00:08.1:   bridge window [io  0xe000-0xeff=
f]
[    0.269148][    T1] pci 0000:00:08.1:   bridge window [mem 0xfc500000-
0xfc9fffff]
[    0.269153][    T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000000=
-
0xfe301fffff 64bit pref]
[    0.269159][    T1] pci 0000:00:08.1: enabling Extended Tags
[    0.269192][    T1] pci 0000:00:08.1: PME# supported from D0 D3hot D3co=
ld
[    0.269335][    T1] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c050=
0
conventional PCI endpoint
[    0.269455][    T1] pci 0000:00:14.3: [1022:790e] type 00 class 0x06010=
0
conventional PCI endpoint
[    0.269589][    T1] pci 0000:00:18.0: [1022:166a] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269644][    T1] pci 0000:00:18.1: [1022:166b] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269695][    T1] pci 0000:00:18.2: [1022:166c] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269747][    T1] pci 0000:00:18.3: [1022:166d] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269799][    T1] pci 0000:00:18.4: [1022:166e] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269851][    T1] pci 0000:00:18.5: [1022:166f] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269905][    T1] pci 0000:00:18.6: [1022:1670] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.269956][    T1] pci 0000:00:18.7: [1022:1671] type 00 class 0x06000=
0
conventional PCI endpoint
[    0.270071][    T1] pci 0000:01:00.0: [1002:1478] type 01 class 0x06040=
0 PCIe
Switch Upstream Port
[    0.270085][    T1] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff]
[    0.270100][    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.270107][    T1] pci 0000:01:00.0:   bridge window [mem 0xfca00000-
0xfcbfffff]
[    0.270116][    T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000000=
-
0xfe0fffffff 64bit pref]
[    0.270195][    T1] pci 0000:01:00.0: PME# supported from D0 D3hot D3co=
ld
[    0.270259][    T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwi=
dth,
limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.024 Gb/s =
with
16.0 GT/s PCIe x8 link)
[    0.270364][    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.270426][    T1] pci 0000:02:00.0: [1002:1479] type 01 class 0x06040=
0 PCIe
Switch Downstream Port
[    0.270451][    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.270458][    T1] pci 0000:02:00.0:   bridge window [mem 0xfca00000-
0xfcbfffff]
[    0.270467][    T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000000=
-
0xfe0fffffff 64bit pref]
[    0.270548][    T1] pci 0000:02:00.0: PME# supported from D0 D3hot D3co=
ld
[    0.270908][    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.270977][    T1] pci 0000:03:00.0: [1002:73ff] type 00 class 0x03800=
0 PCIe
Legacy Endpoint
[    0.270992][    T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdfffff=
fff
64bit pref]
[    0.271001][    T1] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0ffff=
fff
64bit pref]
[    0.271011][    T1] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafffff]
[    0.271016][    T1] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff pr=
ef]
[    0.271103][    T1] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D=
3cold
[    0.271172][    T1] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwi=
dth,
limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s =
with
16.0 GT/s PCIe x16 link)
[    0.271265][    T1] pci 0000:03:00.1: [1002:ab28] type 00 class 0x04030=
0 PCIe
Legacy Endpoint
[    0.271276][    T1] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23fff]
[    0.271359][    T1] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D=
3cold
[    0.271482][    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.271556][    T1] pci 0000:04:00.0: [14c3:0608] type 00 class 0x02800=
0 PCIe
Endpoint
[    0.271575][    T1] pci 0000:04:00.0: BAR 0 [mem 0xfe30300000-0xfe303ff=
fff
64bit pref]
[    0.271587][    T1] pci 0000:04:00.0: BAR 2 [mem 0xfe30400000-0xfe30403=
fff
64bit pref]
[    0.271598][    T1] pci 0000:04:00.0: BAR 4 [mem 0xfe30404000-0xfe30404=
fff
64bit pref]
[    0.271672][    T1] pci 0000:04:00.0: supports D1 D2
[    0.271674][    T1] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3ho=
t
D3cold
[    0.271839][    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.271906][    T1] pci 0000:05:00.0: [10ec:8168] type 00 class 0x02000=
0 PCIe
Endpoint
[    0.271923][    T1] pci 0000:05:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.271946][    T1] pci 0000:05:00.0: BAR 2 [mem 0xfcf04000-0xfcf04fff =
64bit]
[    0.271960][    T1] pci 0000:05:00.0: BAR 4 [mem 0xfcf00000-0xfcf03fff =
64bit]
[    0.272052][    T1] pci 0000:05:00.0: supports D1 D2
[    0.272053][    T1] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3ho=
t
D3cold
[    0.272233][    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.272627][    T1] pci 0000:06:00.0: [2646:5013] type 00 class 0x01080=
2 PCIe
Endpoint
[    0.272673][    T1] pci 0000:06:00.0: BAR 0 [mem 0xfce00000-0xfce03fff =
64bit]
[    0.273226][    T1] pci 0000:06:00.0: 31.504 Gb/s available PCIe bandwi=
dth,
limited by 8.0 GT/s PCIe x4 link at 0000:00:02.3 (capable of 63.012 Gb/s w=
ith
16.0 GT/s PCIe x4 link)
[    0.273829][    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.273911][    T1] pci 0000:07:00.0: [c0a9:2263] type 00 class 0x01080=
2 PCIe
Endpoint
[    0.273931][    T1] pci 0000:07:00.0: BAR 0 [mem 0xfcd00000-0xfcd03fff =
64bit]
[    0.274227][    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.274301][    T1] pci 0000:08:00.0: [1002:1638] type 00 class 0x03000=
0 PCIe
Legacy Endpoint
[    0.274312][    T1] pci 0000:08:00.0: BAR 0 [mem 0xfe20000000-0xfe2ffff=
fff
64bit pref]
[    0.274320][    T1] pci 0000:08:00.0: BAR 2 [mem 0xfe30000000-0xfe301ff=
fff
64bit pref]
[    0.274325][    T1] pci 0000:08:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.274331][    T1] pci 0000:08:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
[    0.274339][    T1] pci 0000:08:00.0: enabling Extended Tags
[    0.274389][    T1] pci 0000:08:00.0: PME# supported from D1 D2 D3hot D=
3cold
[    0.274423][    T1] pci 0000:08:00.0: 126.016 Gb/s available PCIe bandw=
idth,
limited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s=
 with
16.0 GT/s PCIe x16 link)
[    0.274503][    T1] pci 0000:08:00.1: [1002:1637] type 00 class 0x04030=
0 PCIe
Legacy Endpoint
[    0.274510][    T1] pci 0000:08:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbfff]
[    0.274531][    T1] pci 0000:08:00.1: enabling Extended Tags
[    0.274561][    T1] pci 0000:08:00.1: PME# supported from D1 D2 D3hot D=
3cold
[    0.274633][    T1] pci 0000:08:00.2: [1022:15df] type 00 class 0x10800=
0 PCIe
Endpoint
[    0.274906][    T1] pci 0000:08:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
[    0.274916][    T1] pci 0000:08:00.2: BAR 5 [mem 0xfc9ce000-0xfc9cffff]
[    0.274923][    T1] pci 0000:08:00.2: enabling Extended Tags
[    0.275022][    T1] pci 0000:08:00.3: [1022:1639] type 00 class 0x0c033=
0 PCIe
Endpoint
[    0.275033][    T1] pci 0000:08:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff =
64bit]
[    0.275056][    T1] pci 0000:08:00.3: enabling Extended Tags
[    0.275088][    T1] pci 0000:08:00.3: PME# supported from D0 D3hot D3co=
ld
[    0.275166][    T1] pci 0000:08:00.4: [1022:1639] type 00 class 0x0c033=
0 PCIe
Endpoint
[    0.275176][    T1] pci 0000:08:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff =
64bit]
[    0.275199][    T1] pci 0000:08:00.4: enabling Extended Tags
[    0.275231][    T1] pci 0000:08:00.4: PME# supported from D0 D3hot D3co=
ld
[    0.275308][    T1] pci 0000:08:00.5: [1022:15e2] type 00 class 0x04800=
0 PCIe
Endpoint
[    0.275316][    T1] pci 0000:08:00.5: BAR 0 [mem 0xfc980000-0xfc9bffff]
[    0.275336][    T1] pci 0000:08:00.5: enabling Extended Tags
[    0.275366][    T1] pci 0000:08:00.5: PME# supported from D0 D3hot D3co=
ld
[    0.275437][    T1] pci 0000:08:00.6: [1022:15e3] type 00 class 0x04030=
0 PCIe
Endpoint
[    0.275444][    T1] pci 0000:08:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7fff]
[    0.275465][    T1] pci 0000:08:00.6: enabling Extended Tags
[    0.275495][    T1] pci 0000:08:00.6: PME# supported from D0 D3hot D3co=
ld
[    0.275566][    T1] pci 0000:08:00.7: [1022:15e4] type 00 class 0x11800=
0 PCIe
Endpoint
[    0.275579][    T1] pci 0000:08:00.7: BAR 2 [mem 0xfc500000-0xfc5fffff]
[    0.275589][    T1] pci 0000:08:00.7: BAR 5 [mem 0xfc9cc000-0xfc9cdfff]
[    0.275596][    T1] pci 0000:08:00.7: enabling Extended Tags
[    0.275717][    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.275744][    T1] pci_bus 0000:00: on NUMA node 0
[    0.276538][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.276581][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.276618][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.276663][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.276704][    T1] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.276739][    T1] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.276773][    T1] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.276807][    T1] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.277776][    T1] Low-power S0 idle used by default for system suspen=
d
[    0.279208][    T1] ACPI: EC: interrupt unblocked
[    0.279209][    T1] ACPI: EC: event unblocked
[    0.279211][    T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.279213][    T1] ACPI: EC: GPE=3D0x3
[    0.279214][    T1] ACPI: \_SB_.PCI0.SBRG.EC__: Boot ECDT EC initializa=
tion
complete
[    0.279216][    T1] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle
transactions and events
[    0.279252][    T1] iommu: Default domain type: Passthrough
[    0.279252][    T1] EDAC MC: Ver: 3.0.0
[    0.279399][    T1] efivars: Registered efivars operations
[    0.279976][    T1] PCI: Using ACPI for IRQ routing
[    0.284124][    T1] PCI: pci_cache_line_size set to 64 bytes
[    0.284895][    T1] e820: reserve RAM buffer [mem 0x09bff000-0x0bffffff=
]
[    0.284897][    T1] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff=
]
[    0.284898][    T1] e820: reserve RAM buffer [mem 0xe62ee000-0xe7ffffff=
]
[    0.284899][    T1] e820: reserve RAM buffer [mem 0xe87cb000-0xebffffff=
]
[    0.284901][    T1] e820: reserve RAM buffer [mem 0xe9e20000-0xebffffff=
]
[    0.284902][    T1] e820: reserve RAM buffer [mem 0xee000000-0xefffffff=
]
[    0.284903][    T1] e820: reserve RAM buffer [mem 0xfee300000-0xfefffff=
ff]
[    0.284954][    T1] pci 0000:08:00.0: vgaarb: setting as boot VGA devic=
e
[    0.284954][    T1] pci 0000:08:00.0: vgaarb: bridge control possible
[    0.284954][    T1] pci 0000:08:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.284954][    T1] vgaarb: loaded
[    0.285346][    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.285357][    T1] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.286938][    T1] clocksource: Switched to clocksource hpet
[    0.287057][    T1] pnp: PnP ACPI init
[    0.287125][    T1] system 00:00: [mem 0xf0000000-0xf7ffffff] has been
reserved
[    0.287578][    T1] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.287581][    T1] system 00:04: [io  0x040b] has been reserved
[    0.287582][    T1] system 00:04: [io  0x04d6] has been reserved
[    0.287584][    T1] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.287585][    T1] system 00:04: [io  0x0c14] has been reserved
[    0.287587][    T1] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.287588][    T1] system 00:04: [io  0x0c52] has been reserved
[    0.287590][    T1] system 00:04: [io  0x0c6c] has been reserved
[    0.287591][    T1] system 00:04: [io  0x0c6f] has been reserved
[    0.287592][    T1] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.287594][    T1] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.287595][    T1] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.287597][    T1] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.287598][    T1] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.287600][    T1] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.287601][    T1] system 00:04: [mem 0xfec00000-0xfec00fff] could not=
 be
reserved
[    0.287603][    T1] system 00:04: [mem 0xfec01000-0xfec01fff] could not=
 be
reserved
[    0.287605][    T1] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been
reserved
[    0.287607][    T1] system 00:04: [mem 0xfee00000-0xfee00fff] has been
reserved
[    0.287608][    T1] system 00:04: [mem 0xfed80000-0xfed8ffff] could not=
 be
reserved
[    0.287610][    T1] system 00:04: [mem 0xfec10000-0xfec10fff] has been
reserved
[    0.287612][    T1] system 00:04: [mem 0xff000000-0xffffffff] has been
reserved
[    0.288282][    T1] pnp: PnP ACPI: found 5 devices
[    0.294558][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.294640][    T1] NET: Registered PF_INET protocol family
[    0.294822][    T1] IP idents hash table entries: 262144 (order: 9, 209=
7152
bytes, linear)
[    0.296849][    T1] tcp_listen_portaddr_hash hash table entries: 32768
(order: 7, 524288 bytes, linear)
[    0.296891][    T1] Table-perturb hash table entries: 65536 (order: 6, =
262144
bytes, linear)
[    0.296898][    T1] TCP established hash table entries: 524288 (order: =
10,
4194304 bytes, linear)
[    0.297220][    T1] TCP bind hash table entries: 65536 (order: 9, 20971=
52
bytes, linear)
[    0.297370][    T1] TCP: Hash tables configured (established 524288 bin=
d
65536)
[    0.297564][    T1] MPTCP token hash table entries: 65536 (order: 8, 15=
72864
bytes, linear)
[    0.297613][    T1] UDP hash table entries: 32768 (order: 8, 1048576 by=
tes,
linear)
[    0.297695][    T1] UDP-Lite hash table entries: 32768 (order: 8, 10485=
76
bytes, linear)
[    0.297816][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.297822][    T1] NET: Registered PF_XDP protocol family
[    0.297829][    T1] pci 0000:00:01.1: bridge window [io  0x1000-0x0fff]=
 to
[bus 01-03] add_size 1000
[    0.297837][    T1] pci 0000:00:01.1: bridge window [io  0x1000-0x1fff]=
:
assigned
[    0.297839][    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.297848][    T1] pci 0000:02:00.0:   bridge window [mem 0xfca00000-
0xfcbfffff]
[    0.297851][    T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000000=
-
0xfe0fffffff 64bit pref]
[    0.297856][    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.297860][    T1] pci 0000:01:00.0:   bridge window [mem 0xfca00000-
0xfcbfffff]
[    0.297863][    T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000000=
-
0xfe0fffffff 64bit pref]
[    0.297868][    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.297870][    T1] pci 0000:00:01.1:   bridge window [io  0x1000-0x1ff=
f]
[    0.297872][    T1] pci 0000:00:01.1:   bridge window [mem 0xfca00000-
0xfccfffff]
[    0.297875][    T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000000=
-
0xfe0fffffff 64bit pref]
[    0.297879][    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.297882][    T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300000=
-
0xfe304fffff 64bit pref]
[    0.297886][    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.297887][    T1] pci 0000:00:02.2:   bridge window [io  0xf000-0xfff=
f]
[    0.297890][    T1] pci 0000:00:02.2:   bridge window [mem 0xfcf00000-
0xfcffffff]
[    0.297894][    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.297897][    T1] pci 0000:00:02.3:   bridge window [mem 0xfce00000-
0xfcefffff]
[    0.297901][    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.297904][    T1] pci 0000:00:02.4:   bridge window [mem 0xfcd00000-
0xfcdfffff]
[    0.297908][    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.297910][    T1] pci 0000:00:08.1:   bridge window [io  0xe000-0xeff=
f]
[    0.297913][    T1] pci 0000:00:08.1:   bridge window [mem 0xfc500000-
0xfc9fffff]
[    0.297915][    T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000000=
-
0xfe301fffff 64bit pref]
[    0.297918][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x03af wind=
ow]
[    0.297920][    T1] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 wind=
ow]
[    0.297922][    T1] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df wind=
ow]
[    0.297923][    T1] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff wind=
ow]
[    0.297924][    T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000df=
fff
window]
[    0.297926][    T1] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfcfff=
fff
window]
[    0.297927][    T1] pci_bus 0000:00: resource 10 [mem 0x1010000000-
0xffffffffff window]
[    0.297929][    T1] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.297930][    T1] pci_bus 0000:01: resource 1 [mem 0xfca00000-0xfccff=
fff]
[    0.297931][    T1] pci_bus 0000:01: resource 2 [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[    0.297933][    T1] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfcbff=
fff]
[    0.297934][    T1] pci_bus 0000:02: resource 2 [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[    0.297935][    T1] pci_bus 0000:03: resource 1 [mem 0xfca00000-0xfcbff=
fff]
[    0.297937][    T1] pci_bus 0000:03: resource 2 [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[    0.297938][    T1] pci_bus 0000:04: resource 2 [mem 0xfe30300000-
0xfe304fffff 64bit pref]
[    0.297939][    T1] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
[    0.297941][    T1] pci_bus 0000:05: resource 1 [mem 0xfcf00000-0xfcfff=
fff]
[    0.297942][    T1] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfceff=
fff]
[    0.297944][    T1] pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfcdff=
fff]
[    0.297945][    T1] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    0.297946][    T1] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc9ff=
fff]
[    0.297947][    T1] pci_bus 0000:08: resource 2 [mem 0xfe20000000-
0xfe301fffff 64bit pref]
[    0.298041][    T1] pci 0000:03:00.1: D0 power state depends on 0000:03=
:00.0
[    0.298435][    T1] pci 0000:08:00.1: D0 power state depends on 0000:08=
:00.0
[    0.298441][    T1] pci 0000:08:00.3: extending delay after power-on fr=
om
D3hot to 20 msec
[    0.298565][    T1] pci 0000:08:00.4: extending delay after power-on fr=
om
D3hot to 20 msec
[    0.298634][    T1] PCI: CLS 64 bytes, default 64
[    0.298642][    T1] pci 0000:00:00.2: AMD-Vi: IOMMU performance counter=
s
supported
[    0.298680][  T102] Trying to unpack rootfs image as initramfs...
[    0.298683][    T1] pci 0000:00:01.0: Adding to iommu group 0
[    0.298697][    T1] pci 0000:00:01.1: Adding to iommu group 1
[    0.298718][    T1] pci 0000:00:02.0: Adding to iommu group 2
[    0.298731][    T1] pci 0000:00:02.1: Adding to iommu group 3
[    0.298743][    T1] pci 0000:00:02.2: Adding to iommu group 4
[    0.298756][    T1] pci 0000:00:02.3: Adding to iommu group 5
[    0.298769][    T1] pci 0000:00:02.4: Adding to iommu group 6
[    0.298788][    T1] pci 0000:00:08.0: Adding to iommu group 7
[    0.298801][    T1] pci 0000:00:08.1: Adding to iommu group 8
[    0.298825][    T1] pci 0000:00:14.0: Adding to iommu group 9
[    0.298837][    T1] pci 0000:00:14.3: Adding to iommu group 9
[    0.298896][    T1] pci 0000:00:18.0: Adding to iommu group 10
[    0.298909][    T1] pci 0000:00:18.1: Adding to iommu group 10
[    0.298922][    T1] pci 0000:00:18.2: Adding to iommu group 10
[    0.298934][    T1] pci 0000:00:18.3: Adding to iommu group 10
[    0.298947][    T1] pci 0000:00:18.4: Adding to iommu group 10
[    0.298959][    T1] pci 0000:00:18.5: Adding to iommu group 10
[    0.298971][    T1] pci 0000:00:18.6: Adding to iommu group 10
[    0.298985][    T1] pci 0000:00:18.7: Adding to iommu group 10
[    0.298998][    T1] pci 0000:01:00.0: Adding to iommu group 11
[    0.299011][    T1] pci 0000:02:00.0: Adding to iommu group 12
[    0.299032][    T1] pci 0000:03:00.0: Adding to iommu group 13
[    0.299048][    T1] pci 0000:03:00.1: Adding to iommu group 14
[    0.299061][    T1] pci 0000:04:00.0: Adding to iommu group 15
[    0.299074][    T1] pci 0000:05:00.0: Adding to iommu group 16
[    0.299087][    T1] pci 0000:06:00.0: Adding to iommu group 17
[    0.299100][    T1] pci 0000:07:00.0: Adding to iommu group 18
[    0.299119][    T1] pci 0000:08:00.0: Adding to iommu group 19
[    0.299132][    T1] pci 0000:08:00.1: Adding to iommu group 20
[    0.299146][    T1] pci 0000:08:00.2: Adding to iommu group 21
[    0.299160][    T1] pci 0000:08:00.3: Adding to iommu group 22
[    0.299173][    T1] pci 0000:08:00.4: Adding to iommu group 23
[    0.299187][    T1] pci 0000:08:00.5: Adding to iommu group 24
[    0.299201][    T1] pci 0000:08:00.6: Adding to iommu group 25
[    0.299214][    T1] pci 0000:08:00.7: Adding to iommu group 26
[    0.299491][    T1] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0)=
: PPR
X2APIC NX GT IA GA PC GA_vAPIC
[    0.299498][    T1] AMD-Vi: Interrupt remapping enabled
[    0.299499][    T1] AMD-Vi: X2APIC enabled
[    0.299673][    T1] AMD-Vi: Virtual APIC enabled
[    0.299686][    T1] PCI-DMA: Using software bounce buffering for IO (SW=
IOTLB)
[    0.299687][    T1] software IO TLB: mapped [mem 0x00000000e1e6d000-
0x00000000e5e6d000] (64MB)
[    0.299717][    T1] LVT offset 0 assigned for vector 0x400
[    0.302395][    T1] perf: AMD IBS detected (0x000003ff)
[    0.302540][   T20] amd_uncore: 4 amd_df counters detected
[    0.302545][   T20] amd_uncore: 6 amd_l3 counters detected
[    0.302687][    T1] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
counters/bank).
[    0.303139][    T1] Initialise system trusted keyrings
[    0.303176][    T1] workingset: timestamp_bits=3D46 max_order=3D24 buck=
et_order=3D0
[    0.303181][    T1] zbud: loaded
[    0.312181][    T1] Key type asymmetric registered
[    0.312183][    T1] Asymmetric key parser 'x509' registered
[    0.312201][    T1] Block layer SCSI generic (bsg) driver version 0.4 l=
oaded
(major 250)
[    0.312251][    T1] io scheduler bfq registered
[    0.317815][    T1] pcieport 0000:00:01.1: PME: Signaling with IRQ 43
[    0.317836][    T1] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- Pwr=
Ctrl-
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis-
LLActRep+
[    0.317999][    T1] pcieport 0000:00:02.1: PME: Signaling with IRQ 44
[    0.318094][    T1] pcieport 0000:00:02.2: PME: Signaling with IRQ 45
[    0.318190][    T1] pcieport 0000:00:02.3: PME: Signaling with IRQ 46
[    0.318298][    T1] pcieport 0000:00:02.4: PME: Signaling with IRQ 47
[    0.318398][    T1] pcieport 0000:00:08.1: PME: Signaling with IRQ 48
[    0.318799][    T1] ACPI: video: Video Device [VGA] (multi-head: yes  r=
om: no
post: no)
[    0.319026][    T1] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:13/LNXVIDEO:00/input/in=
put0
[    0.319189][    T1] Estimated ratio of average max frequency by base
frequency (times 1024): 1226
[    0.319203][    T9] Monitor-Mwait will be used to enter C-1 state
[    0.319209][    T1] ACPI: \_SB_.PLTF.P000: Found 3 idle states
[    0.319322][    T1] ACPI: \_SB_.PLTF.P001: Found 3 idle states
[    0.319420][    T1] ACPI: \_SB_.PLTF.P002: Found 3 idle states
[    0.323268][    T1] ACPI: \_SB_.PLTF.P003: Found 3 idle states
[    0.323416][    T1] ACPI: \_SB_.PLTF.P004: Found 3 idle states
[    0.323584][    T1] ACPI: \_SB_.PLTF.P005: Found 3 idle states
[    0.323745][    T1] ACPI: \_SB_.PLTF.P006: Found 3 idle states
[    0.323862][    T1] ACPI: \_SB_.PLTF.P007: Found 3 idle states
[    0.324013][    T1] ACPI: \_SB_.PLTF.P008: Found 3 idle states
[    0.324171][    T1] ACPI: \_SB_.PLTF.P009: Found 3 idle states
[    0.324322][    T1] ACPI: \_SB_.PLTF.P00A: Found 3 idle states
[    0.324476][    T1] ACPI: \_SB_.PLTF.P00B: Found 3 idle states
[    0.324623][    T1] ACPI: \_SB_.PLTF.P00C: Found 3 idle states
[    0.324758][    T1] ACPI: \_SB_.PLTF.P00D: Found 3 idle states
[    0.324886][    T1] ACPI: \_SB_.PLTF.P00E: Found 3 idle states
[    0.325025][    T1] ACPI: \_SB_.PLTF.P00F: Found 3 idle states
[    0.325894][    T1] thermal LNXTHERM:00: registered as thermal_zone0
[    0.325896][    T1] ACPI: thermal: Thermal Zone [THRM] (41 C)
[    0.326142][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing ena=
bled
[    0.339293][    T1] tpm_crb MSFT0101:00: Disabling hwrng
[    0.339759][    T1] ACPI: bus type drm_connector registered
[    0.341800][    T1] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:P=
S2M]
at 0x60,0x64 irq 1,12
[    0.344984][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.345036][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.345372][    T1] mousedev: PS/2 mouse device common for all mice
[    0.345393][    T1] rtc_cmos 00:01: RTC can wake from S4
[    0.345734][    T1] rtc_cmos 00:01: registered as rtc0
[    0.345792][    T1] rtc_cmos 00:01: setting system clock to 2024-04-
11T11:49:58 UTC (1712836198)
[    0.345822][    T1] rtc_cmos 00:01: alarms up to one month, y3k, 114 by=
tes
nvram
[    0.349641][    T1] efifb: probing for efifb
[    0.349653][    T1] efifb: framebuffer at 0xfe20000000, using 3072k, to=
tal
3072k
[    0.349656][    T1] efifb: mode is 1024x768x32, linelength=3D4096, page=
s=3D1
[    0.349658][    T1] efifb: scrolling: redraw
[    0.349660][    T1] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.349844][    T1] Console: switching to colour frame buffer device 12=
8x48
[    0.356727][  T133] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    0.359933][    T1] fb0: EFI VGA frame buffer device
[    0.360037][    T1] NET: Registered PF_INET6 protocol family
[    0.463985][  T102] Freeing initrd memory: 44172K
[    0.470689][    T1] Segment Routing with IPv6
[    0.470705][    T1] In-situ OAM (IOAM) with IPv6
[    0.470733][    T1] mip6: Mobile IPv6
[    0.470738][    T1] NET: Registered PF_PACKET protocol family
[    0.470785][    T1] mpls_gso: MPLS GSO support
[    0.472876][    T1] microcode: Current revision: 0x0a50000c
[    0.473527][    T1] resctrl: L3 allocation detected
[    0.473529][    T1] resctrl: MB allocation detected
[    0.473530][    T1] resctrl: L3 monitoring detected
[    0.473550][    T1] IPI shorthand broadcast: enabled
[    0.474596][    T1] sched_clock: Marking stable (473003978, 1254441)-
>(491155385, -16896966)
[    0.474930][    T1] Timer migration: 2 hierarchy levels; 8 children per
group; 2 crossnode level
[    0.475105][    T1] registered taskstats version 1
[    0.475172][    T1] Loading compiled-in X.509 certificates
[    0.523119][    T1] Loaded X.509 cert 'Build time autogenerated kernel =
key:
d585c95a2505853bfd51f8eba85ec95fff6d0af3'
[    0.524364][    T1] Key type .fscrypt registered
[    0.524366][    T1] Key type fscrypt-provisioning registered
[    0.590489][    T1] ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.GP17.MP2], AE_NOT_FOUND (20230628/psargs-330)
[    0.590497][   T97] pci_bus 0000:03: Allocating resources
[    0.590783][    T1] ACPI Error: Aborting method \_SB.GPIO._EVT due to
previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.591110][    T1] clk: Disabling unused clocks
[    0.591112][    T1] PM: genpd: Disabling unused power domains
[    0.591347][    T1] Freeing unused kernel image (initmem) memory: 1372K
[    0.591354][    T1] Write protecting the kernel read-only data: 16384k
[    0.591573][    T1] Freeing unused kernel image (rodata/data gap) memor=
y:
516K
[    0.632221][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages =
found.
[    0.632225][    T1] Run /init as init process
[    0.632226][    T1]   with arguments:
[    0.632227][    T1]     /init
[    0.632228][    T1]   with environment:
[    0.632229][    T1]     HOME=3D/
[    0.632230][    T1]     TERM=3Dlinux
[    0.632231][    T1]     BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-rc3-next-20240=
411
[    0.733106][  T260] piix4_smbus 0000:00:14.0: SMBus Host Controller at =
0xb00,
revision 0
[    0.733112][  T260] piix4_smbus 0000:00:14.0: Using register 0x02 for S=
MBus
port selection
[    0.733166][  T260] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Cont=
roller
at 0xb20
[    0.733293][  T265] hid: raw HID events driver (C) Jiri Kosina
[    0.734462][  T279] pcie_mp2_amd 0000:08:00.7: enabling device (0000 ->=
 0002)
[    0.736728][  T250] ACPI: bus type USB registered
[    0.736751][  T250] usbcore: registered new interface driver usbfs
[    0.736758][  T250] usbcore: registered new interface driver hub
[    0.736769][  T250] usbcore: registered new device driver usb
[    0.740873][  T280] r8169 0000:05:00.0 eth0: RTL8168h/8111h,
d8:bb:c1:ab:dd:5e, XID 541, IRQ 54
[    0.740877][  T280] r8169 0000:05:00.0 eth0: jumbo features [frames: 91=
94
bytes, tx checksumming: ko]
[    0.753906][  T297] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR HU=
B HID
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.753980][  T297] hid-generic 0020:1022:0001.0002: hidraw1: SENSOR HU=
B HID
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.754052][  T297] hid-generic 0020:1022:0001.0003: hidraw2: SENSOR HU=
B HID
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.754123][  T297] hid-generic 0020:1022:0001.0004: hidraw3: SENSOR HU=
B HID
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.754182][  T297] hid-generic 0020:1022:0001.0005: hidraw4: SENSOR HU=
B HID
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.754249][  T297] hid-generic 0020:1022:0001.0006: hidraw5: SENSOR HU=
B HID
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.880457][   T97] input: PNP0C50:0e 06CB:7E7E Mouse as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input4
[    0.880518][   T97] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input5
[    0.880598][   T97] hid-generic 0018:06CB:7E7E.0007: input,hidraw6: I2C=
 HID
v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[    0.881436][  T254] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    0.882259][  T295] hid-sensor-hub 0020:1022:0001.0001: hidraw0: SENSOR=
 HUB
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.882381][  T295] hid-sensor-hub 0020:1022:0001.0002: hidraw1: SENSOR=
 HUB
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.882493][  T295] hid-sensor-hub 0020:1022:0001.0003: hidraw2: SENSOR=
 HUB
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.882601][  T295] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SENSOR=
 HUB
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.882709][  T295] hid-sensor-hub 0020:1022:0001.0005: hidraw4: SENSOR=
 HUB
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.882837][  T295] hid-sensor-hub 0020:1022:0001.0006: hidraw5: SENSOR=
 HUB
HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.883719][  T250] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.883726][  T250] xhci_hcd 0000:08:00.3: new USB bus registered, assi=
gned
bus number 1
[    0.883806][  T250] xhci_hcd 0000:08:00.3: hcc params 0x0268ffe5 hci ve=
rsion
0x110 quirks 0x0000020000000410
[    0.884062][  T250] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.884065][  T250] xhci_hcd 0000:08:00.3: new USB bus registered, assi=
gned
bus number 2
[    0.884067][  T250] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanc=
ed
SuperSpeed
[    0.884103][  T250] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.09
[    0.884105][  T250] usb usb1: New USB device strings: Mfr=3D3, Product=
=3D2,
SerialNumber=3D1
[    0.884106][  T250] usb usb1: Product: xHCI Host Controller
[    0.884108][  T250] usb usb1: Manufacturer: Linux 6.9.0-rc3-next-202404=
11
xhci-hcd
[    0.884109][  T250] usb usb1: SerialNumber: 0000:08:00.3
[    0.884203][   T97] nvme 0000:06:00.0: platform quirk: setting simple s=
uspend
[    0.884206][  T102] nvme 0000:07:00.0: platform quirk: setting simple s=
uspend
[    0.884250][  T250] hub 1-0:1.0: USB hub found
[    0.884265][  T250] hub 1-0:1.0: 4 ports detected
[    0.884272][  T102] nvme nvme1: pci function 0000:07:00.0
[    0.884273][   T97] nvme nvme0: pci function 0000:06:00.0
[    0.888973][  T250] usb usb2: We don't know the algorithms for LPM for =
this
host, disabling LPM.
[    0.889000][  T250] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 6.09
[    0.889002][  T250] usb usb2: New USB device strings: Mfr=3D3, Product=
=3D2,
SerialNumber=3D1
[    0.889004][  T250] usb usb2: Product: xHCI Host Controller
[    0.889005][  T250] usb usb2: Manufacturer: Linux 6.9.0-rc3-next-202404=
11
xhci-hcd
[    0.889008][  T250] usb usb2: SerialNumber: 0000:08:00.3
[    0.889109][  T250] hub 2-0:1.0: USB hub found
[    0.889119][  T250] hub 2-0:1.0: 2 ports detected
[    0.889499][  T250] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.889503][  T250] xhci_hcd 0000:08:00.4: new USB bus registered, assi=
gned
bus number 3
[    0.889583][  T250] xhci_hcd 0000:08:00.4: hcc params 0x0268ffe5 hci ve=
rsion
0x110 quirks 0x0000020000000410
[    0.889805][  T250] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.889808][  T250] xhci_hcd 0000:08:00.4: new USB bus registered, assi=
gned
bus number 4
[    0.889810][  T250] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanc=
ed
SuperSpeed
[    0.889869][  T250] usb usb3: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.09
[    0.889872][  T250] usb usb3: New USB device strings: Mfr=3D3, Product=
=3D2,
SerialNumber=3D1
[    0.889874][  T250] usb usb3: Product: xHCI Host Controller
[    0.889875][  T250] usb usb3: Manufacturer: Linux 6.9.0-rc3-next-202404=
11
xhci-hcd
[    0.889876][  T250] usb usb3: SerialNumber: 0000:08:00.4
[    0.889971][  T250] hub 3-0:1.0: USB hub found
[    0.889982][  T250] hub 3-0:1.0: 4 ports detected
[    0.890601][  T250] usb usb4: We don't know the algorithms for LPM for =
this
host, disabling LPM.
[    0.890622][  T250] usb usb4: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 6.09
[    0.890624][  T250] usb usb4: New USB device strings: Mfr=3D3, Product=
=3D2,
SerialNumber=3D1
[    0.890626][  T250] usb usb4: Product: xHCI Host Controller
[    0.890627][  T250] usb usb4: Manufacturer: Linux 6.9.0-rc3-next-202404=
11
xhci-hcd
[    0.890629][  T250] usb usb4: SerialNumber: 0000:08:00.4
[    0.890721][  T250] hub 4-0:1.0: USB hub found
[    0.890727][  T250] hub 4-0:1.0: 2 ports detected
[    0.892506][  T102] nvme nvme1: missing or invalid SUBNQN field.
[    0.894439][   T97] nvme nvme0: D3 entry latency set to 10 seconds
[    0.897479][   T97] nvme nvme0: 16/0/0 default/read/poll queues
[    0.899635][   T11]  nvme0n1: p1 p2 p3 p4
[    0.900698][  T102] nvme nvme1: 15/0/0 default/read/poll queues
[    0.909376][   T97]  nvme1n1: p1
[    0.966669][  T249] [drm] amdgpu kernel modesetting enabled.
[    0.966687][  T249] amdgpu: vga_switcheroo: detected switching method
\_SB_.PCI0.GP17.VGA_.ATPX handle
[    0.967008][  T249] amdgpu: ATPX version 1, functions 0x00000001
[    0.967045][  T249] amdgpu: ATPX Hybrid Graphics
[    0.973338][  T249] amdgpu: Virtual CRAT table created for CPU
[    0.973349][  T249] amdgpu: Topology: Add CPU node
[    0.973447][  T249] amdgpu 0000:03:00.0: enabling device (0000 -> 0002)
[    0.973480][  T249] [drm] initializing kernel modesetting (DIMGREY_CAVE=
FISH
0x1002:0x73FF 0x1462:0x1313 0xC3).
[    0.973488][  T249] [drm] register mmio base: 0xFCA00000
[    0.973490][  T249] [drm] register mmio size: 1048576
[    0.973552][  T249] [drm] MCBP is enabled
[    0.977600][  T249] [drm] add ip block number 0 <nv_common>
[    0.977602][  T249] [drm] add ip block number 1 <gmc_v10_0>
[    0.977603][  T249] [drm] add ip block number 2 <navi10_ih>
[    0.977604][  T249] [drm] add ip block number 3 <psp>
[    0.977605][  T249] [drm] add ip block number 4 <smu>
[    0.977606][  T249] [drm] add ip block number 5 <dm>
[    0.977607][  T249] [drm] add ip block number 6 <gfx_v10_0>
[    0.977608][  T249] [drm] add ip block number 7 <sdma_v5_2>
[    0.977609][  T249] [drm] add ip block number 8 <vcn_v3_0>
[    0.977609][  T249] [drm] add ip block number 9 <jpeg_v3_0>
[    0.977617][  T249] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table presen=
t but
broken (too short #2),skipping
[    0.985158][  T249] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ROM=
 BAR
[    0.985160][  T249] amdgpu: ATOM BIOS: SWBRT77181.001
[    0.990982][  T249] [drm] VCN(0) decode is enabled in VM mode
[    0.990984][  T249] [drm] VCN(0) encode is enabled in VM mode
[    0.992536][  T249] [drm] JPEG decode is enabled in VM mode
[    0.992544][  T249] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (T=
MZ)
feature disabled as experimental (default)
[    0.992551][  T249] [drm] GPU posting now...
[    0.992615][  T249] [drm] vm size is 262144 GB, 4 levels, block size is=
 9-
bit, fragment size is 9-bit
[    0.992621][  T249] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M
0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
[    0.992623][  T249] amdgpu 0000:03:00.0: amdgpu: GART: 512M
0x0000000000000000 - 0x000000001FFFFFFF
[    0.992631][  T249] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[    0.992632][  T249] [drm] RAM width 128bits GDDR6
[    0.992738][  T249] [drm] amdgpu: 8176M of VRAM memory ready
[    0.992739][  T249] [drm] amdgpu: 31853M of GTT memory ready.
[    0.992749][  T249] [drm] GART: num cpu pages 131072, num gpu pages 131=
072
[    0.992874][  T249] [drm] PCIE GART of 512M enabled (table at
0x00000081FEB00000).
[    1.129262][   T54] usb 1-4: new high-speed USB device number 2 using
xhci_hcd
[    1.130612][   T34] usb 3-2: new low-speed USB device number 2 using xh=
ci_hcd
[    1.266127][   T34] usb 3-2: New USB device found, idVendor=3D1bcf,
idProduct=3D08a0, bcdDevice=3D 1.04
[    1.266129][   T34] usb 3-2: New USB device strings: Mfr=3D0, Product=
=3D0,
SerialNumber=3D0
[    1.266491][   T54] usb 1-4: New USB device found, idVendor=3D30c9,
idProduct=3D0042, bcdDevice=3D 0.03
[    1.266495][   T54] usb 1-4: New USB device strings: Mfr=3D1, Product=
=3D2,
SerialNumber=3D3
[    1.266497][   T54] usb 1-4: Product: Integrated Camera
[    1.266500][   T54] usb 1-4: Manufacturer: S1F0009330LB620L420004LP
[    1.266501][   T54] usb 1-4: SerialNumber: SunplusIT Inc
[    1.293204][  T276] input: HID 1bcf:08a0 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/usb3/3-2/3-
2:1.0/0003:1BCF:08A0.0008/input/input7
[    1.293284][  T276] input: HID 1bcf:08a0 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/usb3/3-2/3-
2:1.0/0003:1BCF:08A0.0008/input/input8
[    1.343263][  T129] tsc: Refined TSC clocksource calibration: 3193.999 =
MHz
[    1.343268][  T129] clocksource: tsc: mask: 0xffffffffffffffff max_cycl=
es:
0x2e0a24cf65f, max_idle_ns: 440795271781 ns
[    1.345366][  T276] input: HID 1bcf:08a0 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/usb3/3-2/3-
2:1.0/0003:1BCF:08A0.0008/input/input9
[    1.345453][  T276] hid-generic 0003:1BCF:08A0.0008: input,hiddev0,hidr=
aw7:
USB HID v1.10 Mouse [HID 1bcf:08a0] on usb-0000:08:00.4-2/input0
[    1.345479][  T276] usbcore: registered new interface driver usbhid
[    1.345481][  T276] usbhid: USB HID core driver
[    1.397268][   T34] usb 3-3: new high-speed USB device number 3 using
xhci_hcd
[    1.527260][   T34] usb 3-3: New USB device found, idVendor=3D0e8d,
idProduct=3D0608, bcdDevice=3D 1.00
[    1.527262][   T34] usb 3-3: New USB device strings: Mfr=3D5, Product=
=3D6,
SerialNumber=3D7
[    1.527264][   T34] usb 3-3: Product: Wireless_Device
[    1.527266][   T34] usb 3-3: Manufacturer: MediaTek Inc.
[    1.527267][   T34] usb 3-3: SerialNumber: 000000000
[    1.650264][   T34] usb 3-4: new full-speed USB device number 4 using
xhci_hcd
[    1.809130][   T34] usb 3-4: New USB device found, idVendor=3D1462,
idProduct=3D1563, bcdDevice=3D 2.00
[    1.809132][   T34] usb 3-4: New USB device strings: Mfr=3D1, Product=
=3D2,
SerialNumber=3D3
[    1.809134][   T34] usb 3-4: Product: MysticLight MS-1563 v0001
[    1.809135][   T34] usb 3-4: Manufacturer: MSI
[    1.809137][   T34] usb 3-4: SerialNumber: 2064386A5430
[    1.843969][   T34] hid-generic 0003:1462:1563.0009: hiddev1,hidraw8: U=
SB HID
v1.11 Device [MSI MysticLight MS-1563 v0001] on usb-0000:08:00.4-4/input0
[    3.279775][  T249] amdgpu 0000:03:00.0: amdgpu: STB initialized to 204=
8
entries
[    3.279836][  T249] [drm] Loading DMUB firmware via PSP: version=3D0x02=
02001E
[    3.280117][  T249] [drm] use_doorbell being set to: [true]
[    3.280128][  T249] [drm] use_doorbell being set to: [true]
[    3.280138][  T249] [drm] Found VCN firmware Version ENC: 1.27 DEC: 2 V=
EP: 0
Revision: 0
[    3.280144][  T249] amdgpu 0000:03:00.0: amdgpu: Will use PSP to load V=
CN
firmware
[    3.443691][  T249] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from
0x81fd000000 for PSP TMR
[    3.524926][  T249] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta u=
code
is not available
[    3.536157][  T249] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secured=
isplay
ta ucode is not available
[    3.536179][  T249] amdgpu 0000:03:00.0: amdgpu: smu driver if version =
=3D
0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, versio=
n =3D
0x003b2b00 (59.43.0)
[    3.536184][  T249] amdgpu 0000:03:00.0: amdgpu: SMU driver if version =
not
matched
[    3.536216][  T249] amdgpu 0000:03:00.0: amdgpu: use vbios provided ppt=
able
[    3.587190][  T249] amdgpu 0000:03:00.0: amdgpu: SMU is initialized
successfully!
[    3.587550][  T249] [drm] Display Core v3.2.279 initialized on DCN 3.0.=
2
[    3.587552][  T249] [drm] DP-HDMI FRL PCON supported
[    3.588783][  T249] [drm] DMUB hardware initialized: version=3D0x020200=
1E
[    3.621482][  T249] [drm] kiq ring mec 2 pipe 1 q 0
[    3.628043][  T249] [drm] VCN decode and encode initialized
successfully(under DPG Mode).
[    3.628407][  T249] [drm] JPEG decode initialized successfully.
[    3.656005][  T249] amdgpu: HMM registered 8176MB device memory
[    3.656750][  T249] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    3.656764][  T249] kfd kfd: amdgpu: Total number of KFD nodes to be cr=
eated:
1
[    3.656991][  T249] amdgpu: Virtual CRAT table created for GPU
[    3.657146][  T249] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    3.657148][  T249] kfd kfd: amdgpu: added device 1002:73ff
[    3.657170][  T249] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU =
per SH
8, active_cu_number 28
[    3.657175][  T249] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM=
 inv
eng 0 on hub 0
[    3.657177][  T249] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM=
 inv
eng 1 on hub 0
[    3.657178][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses V=
M inv
eng 4 on hub 0
[    3.657180][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses V=
M inv
eng 5 on hub 0
[    3.657181][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses V=
M inv
eng 6 on hub 0
[    3.657182][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses V=
M inv
eng 7 on hub 0
[    3.657184][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses V=
M inv
eng 8 on hub 0
[    3.657185][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses V=
M inv
eng 9 on hub 0
[    3.657186][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses V=
M inv
eng 10 on hub 0
[    3.657188][  T249] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses V=
M inv
eng 11 on hub 0
[    3.657189][  T249] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses =
VM inv
eng 12 on hub 0
[    3.657190][  T249] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv=
 eng
13 on hub 0
[    3.657191][  T249] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv=
 eng
14 on hub 0
[    3.657193][  T249] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM=
 inv
eng 0 on hub 8
[    3.657194][  T249] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses =
VM inv
eng 1 on hub 8
[    3.657195][  T249] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses =
VM inv
eng 4 on hub 8
[    3.657197][  T249] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM =
inv
eng 5 on hub 8
[    3.658212][  T249] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime=
 pm
[    3.664390][  T249] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:0=
3:00.0
on minor 0
[    3.667597][  T249] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or =
sizes
[    3.667610][  T249] [drm] DSC precompute is not needed.
[    3.667785][  T249] amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
[    3.667817][  T249] [drm] initializing kernel modesetting (RENOIR
0x1002:0x1638 0x1462:0x1313 0xC5).
[    3.667825][  T249] [drm] register mmio base: 0xFC900000
[    3.667826][  T249] [drm] register mmio size: 524288
[    3.667879][  T249] [drm] MCBP is enabled
[    3.670679][  T249] [drm] add ip block number 0 <soc15_common>
[    3.670681][  T249] [drm] add ip block number 1 <gmc_v9_0>
[    3.670682][  T249] [drm] add ip block number 2 <vega10_ih>
[    3.670683][  T249] [drm] add ip block number 3 <psp>
[    3.670684][  T249] [drm] add ip block number 4 <smu>
[    3.670685][  T249] [drm] add ip block number 5 <dm>
[    3.670686][  T249] [drm] add ip block number 6 <gfx_v9_0>
[    3.670687][  T249] [drm] add ip block number 7 <sdma_v4_0>
[    3.670689][  T249] [drm] add ip block number 8 <vcn_v2_0>
[    3.670690][  T249] [drm] add ip block number 9 <jpeg_v2_0>
[    3.670698][  T249] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFC=
T
[    3.670700][  T249] amdgpu: ATOM BIOS: 113-CEZANNE-018
[    3.673008][  T249] [drm] VCN decode is enabled in VM mode
[    3.673010][  T249] [drm] VCN encode is enabled in VM mode
[    3.674035][  T249] [drm] JPEG decode is enabled in VM mode
[    3.674107][  T249] Console: switching to colour dummy device 80x25
[    3.674125][  T249] amdgpu 0000:08:00.0: vgaarb: deactivate vga console
[    3.674128][  T249] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (T=
MZ)
feature enabled
[    3.674130][  T249] amdgpu 0000:08:00.0: amdgpu: MODE2 reset
[    3.674278][  T249] [drm] vm size is 262144 GB, 4 levels, block size is=
 9-
bit, fragment size is 9-bit
[    3.674283][  T249] amdgpu 0000:08:00.0: amdgpu: VRAM: 512M
0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    3.674285][  T249] amdgpu 0000:08:00.0: amdgpu: GART: 1024M
0x0000000000000000 - 0x000000003FFFFFFF
[    3.674290][  T249] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[    3.674291][  T249] [drm] RAM width 128bits DDR4
[    3.674348][  T249] [drm] amdgpu: 512M of VRAM memory ready
[    3.674349][  T249] [drm] amdgpu: 31853M of GTT memory ready.
[    3.674360][  T249] [drm] GART: num cpu pages 262144, num gpu pages 262=
144
[    3.674446][  T249] [drm] PCIE GART of 1024M enabled.
[    3.674449][  T249] [drm] PTB located at 0x000000F41FC00000
[    3.674708][  T249] [drm] Loading DMUB firmware via PSP: version=3D0x01=
010027
[    3.675066][  T249] [drm] Found VCN firmware Version ENC: 1.20 DEC: 5 V=
EP: 0
Revision: 3
[    3.675072][  T249] amdgpu 0000:08:00.0: amdgpu: Will use PSP to load V=
CN
firmware
[    4.388355][  T249] amdgpu 0000:08:00.0: amdgpu: reserve 0x400000 from
0xf41f800000 for PSP TMR
[    4.475365][  T249] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta u=
code
is not available
[    4.484120][  T249] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta u=
code
is not available
[    4.484122][  T249] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: secured=
isplay
ta ucode is not available
[    4.484870][  T249] amdgpu 0000:08:00.0: amdgpu: SMU is initialized
successfully!
[    4.485986][  T249] [drm] Display Core v3.2.279 initialized on DCN 2.1
[    4.485988][  T249] [drm] DP-HDMI FRL PCON supported
[    4.486529][  T249] [drm] DMUB hardware initialized: version=3D0x010100=
27
[    4.640450][  T249] [drm] kiq ring mec 2 pipe 1 q 0
[    4.644112][  T249] [drm] VCN decode and encode initialized
successfully(under DPG Mode).
[    4.644131][  T249] [drm] JPEG decode initialized successfully.
[    4.650935][  T249] amdgpu: HMM registered 512MB device memory
[    4.651843][  T249] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.651850][  T249] kfd kfd: amdgpu: Total number of KFD nodes to be cr=
eated:
1
[    4.651960][  T249] amdgpu: Virtual CRAT table created for GPU
[    4.652165][  T249] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[    4.652167][  T249] kfd kfd: amdgpu: added device 1002:1638
[    4.652175][  T249] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, CU =
per SH
8, active_cu_number 8
[    4.652177][  T249] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv e=
ng 0
on hub 0
[    4.652179][  T249] amdgpu 0000:08:00.0: amdgpu: ring gfx_low uses VM i=
nv eng
1 on hub 0
[    4.652180][  T249] amdgpu 0000:08:00.0: amdgpu: ring gfx_high uses VM =
inv
eng 4 on hub 0
[    4.652181][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses V=
M inv
eng 5 on hub 0
[    4.652183][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses V=
M inv
eng 6 on hub 0
[    4.652184][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses V=
M inv
eng 7 on hub 0
[    4.652185][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses V=
M inv
eng 8 on hub 0
[    4.652186][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses V=
M inv
eng 9 on hub 0
[    4.652187][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses V=
M inv
eng 10 on hub 0
[    4.652189][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses V=
M inv
eng 11 on hub 0
[    4.652190][  T249] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses V=
M inv
eng 12 on hub 0
[    4.652191][  T249] amdgpu 0000:08:00.0: amdgpu: ring kiq_0.2.1.0 uses =
VM inv
eng 13 on hub 0
[    4.652192][  T249] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv=
 eng 0
on hub 8
[    4.652194][  T249] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM i=
nv eng
1 on hub 8
[    4.652195][  T249] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM =
inv
eng 4 on hub 8
[    4.652196][  T249] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM =
inv
eng 5 on hub 8
[    4.652197][  T249] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM =
inv
eng 6 on hub 8
[    4.653231][  T249] amdgpu 0000:08:00.0: amdgpu: NO pm mode for runtime=
 pm
[    4.653445][  T249] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:0=
8:00.0
on minor 1
[    4.659451][  T249] fbcon: amdgpudrmfb (fb0) is primary device
[    4.672585][  T249] Console: switching to colour frame buffer device 24=
0x67
[    4.681073][  T249] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb frame b=
uffer
device
[    4.716182][  T360] PM: Image not found (code -22)
[    4.755027][  T373] EXT4-fs (nvme0n1p2): mounted filesystem 73e0f015-c1=
15-
4eb2-92cb-dbf7da2b6112 ro with ordered data mode. Quota mode: disabled.
[    4.991053][  T426] RPC: Registered named UNIX socket transport module.
[    4.991057][  T426] RPC: Registered udp transport module.
[    4.991058][  T426] RPC: Registered tcp transport module.
[    4.991059][  T426] RPC: Registered tcp-with-tls transport module.
[    4.991060][  T426] RPC: Registered tcp NFSv4.1 backchannel transport m=
odule.
[    4.991233][  T437] pstore: Using crash dump compression: deflate
[    4.991273][  T433] device-mapper: uevent: version 1.0.3
[    4.991355][  T433] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01)
initialised: dm-devel@lists.linux.dev
[    4.992542][  T439] fuse: init (API version 7.40)
[    4.992613][  T437] pstore: Registered efi_pstore as persistent store b=
ackend
[    4.993631][  T441] loop: module loaded
[    5.010537][  T448] cfg80211: Loading compiled-in X.509 certificates fo=
r
regulatory database
[    5.010675][  T448] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.010803][  T448] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    5.011798][  T133] cfg80211: loaded regulatory.db is malformed or sign=
ature
is missing/invalid
[    5.012504][  T452] EXT4-fs (nvme0n1p2): re-mounted 73e0f015-c115-4eb2-=
92cb-
dbf7da2b6112 r/w. Quota mode: disabled.
[    5.027951][  T448] mt7921e 0000:04:00.0: enabling device (0000 -> 0002=
)
[    5.034269][  T448] mt7921e 0000:04:00.0: ASIC revision: 79610010
[    5.109736][  T141] mt7921e 0000:04:00.0: HW/SW Version: 0x8a108a10, Bu=
ild
Time: 20230117170855a
[    5.109736][  T141]
[    5.117064][  T521] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:33/PNP0C09:00/PNP0C0D:0=
0/inpu
t/input10
[    5.122183][  T141] mt7921e 0000:04:00.0: WM Firmware Version: ____0100=
00,
Build Time: 20230117170942
[    5.125132][  T524] ACPI: AC: AC Adapter [ADP1] (on-line)
[    5.126686][  T487] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[    5.129580][  T487] ccp 0000:08:00.2: tee enabled
[    5.129641][  T487] ccp 0000:08:00.2: psp enabled
[    5.131172][  T521] ACPI: button: Lid Switch [LID0]
[    5.132862][  T521] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input11
[    5.137041][  T540] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counter=
s,
163840 ms ovfl timer
[    5.137045][  T540] RAPL PMU: hw unit of domain package 2^-16 Joules
[    5.139967][  T538] mc: Linux media interface: v0.10
[    5.157394][  T521] ACPI: button: Power Button [PWRB]
[    5.157470][  T521] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input12
[    5.157539][  T521] ACPI: button: Sleep Button [SLPB]
[    5.165218][  T480] input: PNP0C50:0e 06CB:7E7E Mouse as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input13
[    5.165371][  T480] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input14
[    5.165524][  T480] hid-multitouch 0018:06CB:7E7E.0007: input,hidraw6: =
I2C
HID v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[    5.167160][  T563] Adding 75497468k swap on /dev/nvme0n1p3.  Priority:=
-2
extents:1 across:75497468k SS
[    5.232350][   T11] ACPI: battery: Slot [BAT1] (battery present)
[    5.233905][  T466] input: MSI WMI hotkeys as /devices/virtual/input/in=
put16
[    5.236367][  T523] MCE: In-kernel MCE decoding enabled.
[    5.238888][  T473] snd_rn_pci_acp3x 0000:08:00.5: enabling device (000=
0 ->
0002)
[    5.240439][  T538] videodev: Linux video capture interface: v2.00
[    5.250246][  T538] usb 1-4: Found UVC 1.00 device Integrated Camera
(30c9:0042)
[    5.268960][  T538] usbcore: registered new interface driver uvcvideo
[    5.279677][  T526] snd_hda_intel 0000:03:00.1: enabling device (0000 -=
>
0002)
[    5.279795][  T526] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo a=
udio
client
[    5.279799][  T526] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    5.279906][  T526] snd_hda_intel 0000:08:00.1: enabling device (0000 -=
>
0002)
[    5.279953][  T526] snd_hda_intel 0000:08:00.1: Handle vga_switcheroo a=
udio
client
[    5.280084][  T526] snd_hda_intel 0000:08:00.6: enabling device (0000 -=
>
0002)
[    5.280899][  T523] AMD Address Translation Library initialized
[    5.282987][  T525] Bluetooth: Core ver 2.22
[    5.283006][  T525] NET: Registered PF_BLUETOOTH protocol family
[    5.283007][  T525] Bluetooth: HCI device and connection manager initia=
lized
[    5.283011][  T525] Bluetooth: HCI socket layer initialized
[    5.283013][  T525] Bluetooth: L2CAP socket layer initialized
[    5.283016][  T525] Bluetooth: SCO socket layer initialized
[    5.284911][  T522] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    5.286343][  T522] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    5.287824][  T133] input: HD-Audio Generic HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input17
[    5.287889][  T133] input: HD-Audio Generic HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input18
[    5.287921][  T142] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input21
[    5.287933][  T133] input: HD-Audio Generic HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input19
[    5.287997][  T142] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input22
[    5.288023][  T133] input: HD-Audio Generic HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input20
[    5.288452][  T142] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input23
[    5.289540][  T142] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input24
[    5.289846][  T525] usbcore: registered new interface driver btusb
[    5.289942][  T142] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input25
[    5.291103][  T163] bluetooth hci0: Direct firmware load for
mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin failed with error -2
[    5.291107][  T163] Bluetooth: hci0: Failed to load firmware file (-2)
[    5.291276][  T163] Bluetooth: hci0: Failed to set up firmware (-2)
[    5.291291][  T163] Bluetooth: hci0: HCI Enhanced Setup Synchronous
Connection command is advertised, but not supported.
[    5.297300][  T538] snd_hda_codec_realtek hdaudioC3D0: autoconfig for A=
LC233:
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    5.297305][  T538] snd_hda_codec_realtek hdaudioC3D0:    speaker_outs=
=3D0
(0x0/0x0/0x0/0x0/0x0)
[    5.297307][  T538] snd_hda_codec_realtek hdaudioC3D0:    hp_outs=3D1
(0x21/0x0/0x0/0x0/0x0)
[    5.297309][  T538] snd_hda_codec_realtek hdaudioC3D0:    mono: mono_ou=
t=3D0x0
[    5.297310][  T538] snd_hda_codec_realtek hdaudioC3D0:    inputs:
[    5.297312][  T538] snd_hda_codec_realtek hdaudioC3D0:      Mic=3D0x19
[    5.340339][  T310] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card3/input26
[    5.340395][  T310] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card3/input27
[    6.033937][  T701] EXT4-fs (nvme1n1p1): mounted filesystem 85e13cd1-3c=
57-
4343-a1f5-6209e530b640 r/w with ordered data mode. Quota mode: disabled.
[    6.035563][  T699] EXT4-fs (nvme0n1p4): mounted filesystem d21e6ad6-bc=
46-
4b61-bc20-e4d2f4bf719a r/w with ordered data mode. Quota mode: disabled.
[    6.101205][  T829] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.101209][  T829] Bluetooth: BNEP filters: protocol multicast
[    6.101214][  T829] Bluetooth: BNEP socket layer initialized
[    6.188275][  T773] Generic FE-GE Realtek PHY r8169-0-500:00: attached =
PHY
driver (mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[    6.363505][  T130] r8169 0000:05:00.0 enp5s0: Link is Down
[    6.736542][  T469] mt7921e 0000:04:00.0 wlp4s0: renamed from wlan0
1130]: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No such file=
 or
directory
[    9.577740][  T785] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (local
address=3Dc8:94:02:c1:bd:69)
[    9.693216][  T785] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[    9.697085][   T11] wlp4s0: authenticated
[    9.698222][   T11] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/3)
[    9.725683][   T11] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (capab=
=3D0x1411
status=3D0 aid=3D2)
[    9.753578][   T11] wlp4s0: associated
[    9.867576][   T11] wlp4s0: Limiting TX power to 20 (20 - 0) dBm as
advertised by 54:67:51:3d:a2:e0
[   55.005089][  T773] wlp4s0: deauthenticating from 54:67:51:3d:a2:e0 by =
local
choice (Reason: 3=3DDEAUTH_LEAVING)
[   59.110719][  T785] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local
address=3Dc8:94:02:c1:bd:69)
[   59.611020][  T785] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[   59.633421][   T11] wlp4s0: authenticated
[   59.634543][   T11] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[   59.695669][   T11] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (capab=
=3D0x511
status=3D0 aid=3D1)
[   59.722226][   T11] wlp4s0: associated
[   60.729778][   T11] wlp4s0: deauthenticated from 54:67:51:3d:a2:d2 (Rea=
son:
15=3D4WAY_HANDSHAKE_TIMEOUT)
[   65.750903][ T1189] NFSD: Unable to initialize client recovery tracking=
! (-
110)
[   65.750914][ T1189] NFSD: starting 90-second grace period (net f0000000=
)
[   90.742908][  T335] [drm] PCIE GART of 512M enabled (table at
0x00000081FEB00000).
[   90.742946][  T335] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[   90.919222][  T335] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from
0x81fd000000 for PSP TMR
[   90.999655][  T335] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta u=
code
is not available
[   91.011007][  T335] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secured=
isplay
ta ucode is not available
[   91.011011][  T335] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[   91.011016][  T335] amdgpu 0000:03:00.0: amdgpu: smu driver if version =
=3D
0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, versio=
n =3D
0x003b2b00 (59.43.0)
[   91.011021][  T335] amdgpu 0000:03:00.0: amdgpu: SMU driver if version =
not
matched
[   91.062712][  T335] amdgpu 0000:03:00.0: amdgpu: SMU is resumed success=
fully!
[   91.063966][  T335] [drm] DMUB hardware initialized: version=3D0x020200=
1E
[   91.084778][  T335] [drm] kiq ring mec 2 pipe 1 q 0
[   91.089816][  T335] [drm] VCN decode and encode initialized
successfully(under DPG Mode).
[   91.090002][  T335] [drm] JPEG decode initialized successfully.
[   91.090032][  T335] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM=
 inv
eng 0 on hub 0
[   91.090035][  T335] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM=
 inv
eng 1 on hub 0
[   91.090036][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses V=
M inv
eng 4 on hub 0
[   91.090037][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses V=
M inv
eng 5 on hub 0
[   91.090038][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses V=
M inv
eng 6 on hub 0
[   91.090040][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses V=
M inv
eng 7 on hub 0
[   91.090041][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses V=
M inv
eng 8 on hub 0
[   91.090042][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses V=
M inv
eng 9 on hub 0
[   91.090043][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses V=
M inv
eng 10 on hub 0
[   91.090044][  T335] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses V=
M inv
eng 11 on hub 0
[   91.090046][  T335] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses =
VM inv
eng 12 on hub 0
[   91.090047][  T335] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv=
 eng
13 on hub 0
[   91.090048][  T335] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv=
 eng
14 on hub 0
[   91.090050][  T335] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM=
 inv
eng 0 on hub 8
[   91.090051][  T335] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses =
VM inv
eng 1 on hub 8
[   91.090052][  T335] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses =
VM inv
eng 4 on hub 8
[   91.090053][  T335] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM =
inv
eng 5 on hub 8
[   91.093917][  T335] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or =
sizes
[  205.757123][  T129] [drm] PCIE GART of 512M enabled (table at
0x00000081FEB00000).
[  205.757166][  T129] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[  205.933524][  T129] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from
0x81fd000000 for PSP TMR
[  206.014750][  T129] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta u=
code
is not available
[  206.025993][  T129] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secured=
isplay
ta ucode is not available
[  206.025998][  T129] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  206.026003][  T129] amdgpu 0000:03:00.0: amdgpu: smu driver if version =
=3D
0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, versio=
n =3D
0x003b2b00 (59.43.0)
[  206.026008][  T129] amdgpu 0000:03:00.0: amdgpu: SMU driver if version =
not
matched
[  206.076907][  T129] amdgpu 0000:03:00.0: amdgpu: SMU is resumed success=
fully!
[  206.078162][  T129] [drm] DMUB hardware initialized: version=3D0x020200=
1E
[  206.099136][  T129] [drm] kiq ring mec 2 pipe 1 q 0
[  206.103954][  T129] [drm] VCN decode and encode initialized
successfully(under DPG Mode).
[  206.104112][  T129] [drm] JPEG decode initialized successfully.
[  206.104142][  T129] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM=
 inv
eng 0 on hub 0
[  206.104144][  T129] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM=
 inv
eng 1 on hub 0
[  206.104145][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses V=
M inv
eng 4 on hub 0
[  206.104146][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses V=
M inv
eng 5 on hub 0
[  206.104148][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses V=
M inv
eng 6 on hub 0
[  206.104149][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses V=
M inv
eng 7 on hub 0
[  206.104150][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses V=
M inv
eng 8 on hub 0
[  206.104151][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses V=
M inv
eng 9 on hub 0
[  206.104152][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses V=
M inv
eng 10 on hub 0
[  206.104154][  T129] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses V=
M inv
eng 11 on hub 0
[  206.104155][  T129] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses =
VM inv
eng 12 on hub 0
[  206.104156][  T129] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv=
 eng
13 on hub 0
[  206.104158][  T129] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv=
 eng
14 on hub 0
[  206.104159][  T129] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM=
 inv
eng 0 on hub 8
[  206.104160][  T129] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses =
VM inv
eng 1 on hub 8
[  206.104161][  T129] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses =
VM inv
eng 4 on hub 8
[  206.104163][  T129] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM =
inv
eng 5 on hub 8
[  206.108228][  T129] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or =
sizes


Bert Karwatzki

