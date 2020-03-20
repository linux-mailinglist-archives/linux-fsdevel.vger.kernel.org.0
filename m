Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307B618D5F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 18:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTRkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 13:40:18 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:3968
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbgCTRkR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UXMyLHPRI9LMRz6KCwfVqkpzIqzfZoCZnMBdG+JWB0=;
 b=n/PXHMpMPm9Bj8Sj2kZa8zCdaT7EUgpxtvBoRoQFSTCxqWdLQ8aBNfmpO5odrH2nJvuuMfIHCrhWSCeTD3jzbbJxengPe7JUn1xsRaWaA/OL9mvcb3BXKjBIPya77kowadedJxJLvKUWf9Rd54s+34AwqH1ZNS0coAZRW3WUMh0=
Received: from DBBPR09CA0023.eurprd09.prod.outlook.com (2603:10a6:10:c0::35)
 by DB8PR08MB4028.eurprd08.prod.outlook.com (2603:10a6:10:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 17:40:08 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::4c) by DBBPR09CA0023.outlook.office365.com
 (2603:10a6:10:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Fri, 20 Mar 2020 17:40:08 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 20 Mar 2020 17:40:08 +0000
Received: ("Tessian outbound f88013e987c7:v48"); Fri, 20 Mar 2020 17:40:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d6cbd01de5062be5
X-CR-MTA-TID: 64aa7808
Received: from e67c07784683.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 51950004-4DEF-4479-ADFA-AB04BA3CAAEB.1;
        Fri, 20 Mar 2020 17:40:02 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e67c07784683.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Mar 2020 17:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVteRUTsdmT1xKsDJwkVuSwDfvGDCEn8itpCq2fhTn/3dYZC0ryT5+k/2ErlJoVl16tLB5H4YcnXR1JMr8kHzTmA85hlqTkOhTayVIV7tK+D8BvrdCasbrjrlfGrRFnFWV0FB6xlY2+BYBruRxFnvfz0+53R9HIOT+H+v/mL8JZIMS5NLieTcJDxJ0on+KgXqSHN/WKrS8a+ccHB1JTv61f702lF57k/GFz/aEPwOf+ndv25zlK8N3opXsW/rGFQOJlJ8TGi4ZMmkd8/gbqiDPnyEDPIgVdHASnMtDV9cR2beO5ZYKXH7EOkT8K2L3UzoY/gVeAkMRwQWGVash8y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UXMyLHPRI9LMRz6KCwfVqkpzIqzfZoCZnMBdG+JWB0=;
 b=cLg1A33UaCsP+nRsEphrbIEEBNtx9sbulAItuaSDodOkQ3vT2Y5uIpvB+LgUnbF+cggMlhwKJOpkHnxC0e1b6uEhhgDY7bBge1nZdNPBz74lsJtvZmoU0n3EchPCLEvLQpO12mDeOH1WHab+PmwWg876Seb7dUakm4eboFHrC3fKbnxoeO/fgu3gxwsI/33nnxDWFSyPYmUClDrmrN3r1v7Zfw2P2wY4vDGyeM9pN65/CUzutdtdgRqrXVy+IU6pC2PqbLiJEsmS8qpA3tHeebnU6JR2GO/AwwWvaZ8oGEO6WnqZBi6zJniOXWA84f3p+Q2X8J/OMOdufBkLIjVUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UXMyLHPRI9LMRz6KCwfVqkpzIqzfZoCZnMBdG+JWB0=;
 b=n/PXHMpMPm9Bj8Sj2kZa8zCdaT7EUgpxtvBoRoQFSTCxqWdLQ8aBNfmpO5odrH2nJvuuMfIHCrhWSCeTD3jzbbJxengPe7JUn1xsRaWaA/OL9mvcb3BXKjBIPya77kowadedJxJLvKUWf9Rd54s+34AwqH1ZNS0coAZRW3WUMh0=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from DB7PR08MB3292.eurprd08.prod.outlook.com (52.134.111.30) by
 DB7PR08MB3466.eurprd08.prod.outlook.com (20.176.238.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Fri, 20 Mar 2020 17:39:57 +0000
Received: from DB7PR08MB3292.eurprd08.prod.outlook.com
 ([fe80::d48a:40f:822:6a0a]) by DB7PR08MB3292.eurprd08.prod.outlook.com
 ([fe80::d48a:40f:822:6a0a%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 17:39:57 +0000
Date:   Fri, 20 Mar 2020 17:39:46 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200320173945.GC27072@arm.com>
References: <20200316165055.31179-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316165055.31179-1-broonie@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM6PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:5:134::38) To DB7PR08MB3292.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by DM6PR13CA0061.namprd13.prod.outlook.com (2603:10b6:5:134::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend Transport; Fri, 20 Mar 2020 17:39:51 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 941aff2f-c862-4991-c166-08d7ccf5bba1
X-MS-TrafficTypeDiagnostic: DB7PR08MB3466:|DB7PR08MB3466:|DB8PR08MB4028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB4028480A8E156060D0339C1CEDF50@DB8PR08MB4028.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:972;OLM:972;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(81166006)(8936002)(81156014)(54906003)(36756003)(8676002)(16526019)(26005)(2616005)(186003)(316002)(6916009)(1076003)(44832011)(8886007)(33656002)(55016002)(956004)(4326008)(52116002)(66946007)(7416002)(66476007)(66556008)(2906002)(7696005)(6666004)(86362001)(478600001)(5660300002)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3466;H:DB7PR08MB3292.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CJyxLAlsdNdFlj8RN/dp5y/VTVKzXpvthb2yKv2zVtnSixdilLbd1uAD0K0E1iRKlnZhb26rjhO/Z57qzHGwBJJ8P/0Ak+/160isp54pAhtaldEdmV/ky9bm0uiuGxv+qmS+yGXMIpz08NvB9ATbk3yge6Cv8kNR0PA9Biot6k/wCcefIY3aTLtIvwqm0RYiN/uvbbVyg/9Alakt6mlzzklS1QJ4tTxU2/1XPLRNhwzG0ALpF305sTT9K83fJ0DxOzPyHuJY3ovpc0k1yVtZe/8TEYPc7RpgXZTDk+a/EUqbIHMuemYNgGSCGyXVlN9a7hWrhAt9PeW/NkNV8qFOMO+myS0hGtvIVeIvC4WY2C9Ny6GmOLHbAwJlg9ae11rFwwioj3oHfY/mBSMTaYmTLIwpSs8kYXLWgwwJkKTtbFJySXwx2DWjOEICl0sMpGRv
X-MS-Exchange-AntiSpam-MessageData: 4hdYRuvkSHlR2jS5e1Kos0u+pH5XN7wWisGglvfxFrdWLrYGng7KV7uGGryMspqMKwSSGdeU58FXBaBGakFTjCK/bOlG48U7XlBVZ4BoCjuBpnbLcpsQ7cnCIf7tqmdHVpPyVf9aEAIXhAVlQ7V7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3466
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(199004)(46966005)(8936002)(316002)(450100002)(33656002)(5660300002)(26826003)(4326008)(336012)(45080400002)(478600001)(36756003)(1076003)(2906002)(70586007)(6666004)(7696005)(47076004)(8676002)(8886007)(81166006)(16526019)(186003)(55016002)(26005)(70206006)(6862004)(356004)(44832011)(86362001)(54906003)(81156014)(956004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4028;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4821911d-6d4f-45ca-ada0-08d7ccf5b51b
X-Forefront-PRVS: 03484C0ABF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaThnNBUYWIoCL+SDFZi2s9whrInbmvebDefRAQqPEBx/fh830BIptijkUSGaInHwYqqhKcJ6JfculXi48t9WdYugSJQqGgdmk9opiq+GgTjUm3bhqpS6U79K4N2N/V7tZBBb+3IANO6T2q5DfCLvxbur+Ko9TusGgEveXKSu3TrfVj7Tsrhzdg2CUtwC50RBZERS+9EDt7GNXTuILTtKdHEQQyRoAyMLLCZl55Wrvr+/ecz4wtJwDt08trx1l2AGPEF/VGFqvKjCntFRh0bk2AuqTM+NtQWlfYggAPV3aYHiBa4hjQn93UGvLdCJIiRh22qkliZQRs2qWFSQf26v6KYHgnPyAW97xkgebW/fxRFlC/AcVZaFb6y4GzDMcrW0p3fHF1OeVRtGbnZRaeBHJAYREFerfdrZ+RM31y9wrlFNg5VgQclsipmWRqxOJW8hAWlg2hH4iyY6GQkxDbb3c+qJLsnijAOKI/7t6lopK97M0fW9tATNAGTL0SCJ+ZYOG6tknLWjN3UIoHUvToGzA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 17:40:08.3088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941aff2f-c862-4991-c166-08d7ccf5bba1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4028
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 03/16/2020 16:50, Mark Brown wrote:
> This patch series implements support for ARMv8.5-A Branch Target
> Identification (BTI), which is a control flow integrity protection
> feature introduced as part of the ARMv8.5-A extensions.

i was playing with this and it seems the kernel does not add
PROT_BTI to non-static executables (i.e. there is an interpreter).

i thought any elf that the kernel maps would get PROT_BTI from the
kernel. (i want to remove the mprotect in glibc when not necessary)

i tested by linking a hello world exe with -Wl,-z,force-bti (and
verified that the property note is there) and expected it to crash
(with SIGILL) when the dynamic linker jumps to _start in the exe,
but it executed without errors (if i do the mprotect in glibc then
i get SIGILL as expected).

is this deliberate? does the kernel map static exe and dynamic
linked exe differently?

i cant tell looking at the patches where this logic comes from.

> 
> Changes:
> 
> v10:
>  - Fix build for !COMPAT configurations.
> v9:
>  - Move Kconfig addition to final patch in series.
>  - Add patch from Daniel Kiss adding BTI information to smaps, this has
>    a trivial conflict with a .rst conversion in -next.
> v8:
>  - Remove a redundant IS_ENABLED(CONFIG_ARM64_BTI) check.
> v7:
>  - Rebase onto v5.6-rc3.
>  - Move comment about keeping NT_GNU_PROPERTY_TYPE_0 internal into first
>    patch.
>  - Add an explicit check for system_supports_bti() when parsing BTI ELF
>    property for improved robustness.
> v6:
>  - Rebase onto v5.6-rc1.
>  - Fix typos s/BYTPE/BTYPE/ in commit log for "arm64: BTI: Decode BYTPE
>    bits when printing PSTATE".
> v5:
>  - Changed a bunch of -EIO to -ENOEXEC in the ELF parsing code.
>  - Move PSR_BTYPE defines to UAPI.
>  - Use compat_user_mode() rather than open coding.
>  - Fix a typo s/BYTPE/BTYPE/ in syscall.c
> v4:
>  - Dropped patch fixing existing documentation as it has already been merged.
>  - Convert WARN_ON() to WARN_ON_ONCE() in "ELF: Add ELF program property
>    parsing support".
>  - Added display of guarded pages to ptdump.
>  - Updated for conversion of exception handling from assembler to C.
> 
> Notes:
> 
>  * GCC 9 can compile backwards-compatible BTI-enabled code with
>    -mbranch-protection=bti or -mbranch-protection=standard.
> 
>  * Binutils 2.33 and later support the new ELF note.
> 
>    Creation of a BTI-enabled binary requires _everything_ linked in to
>    be BTI-enabled.  For now ld --force-bti can be used to override this,
>    but some things may break until the required C library support is in
>    place.
> 
>    There is no straightforward way to mark a .s file as BTI-enabled:
>    scraping the output from gcc -S works as a quick hack for now.
> 
>    readelf -n can be used to examing the program properties in an ELF
>    file.
> 
>  * Runtime mmap() and mprotect() can be used to enable BTI on a
>    page-by-page basis using the new PROT_BTI, but the code in the
>    affected pages still needs to be written or compiled to contain the
>    appropriate BTI landing pads.
> 
> Daniel Kiss (1):
>   mm: smaps: Report arm64 guarded pages in smaps
> 
> Dave Martin (11):
>   ELF: UAPI and Kconfig additions for ELF program properties
>   ELF: Add ELF program property parsing support
>   arm64: Basic Branch Target Identification support
>   elf: Allow arch to tweak initial mmap prot flags
>   arm64: elf: Enable BTI at exec based on ELF program properties
>   arm64: BTI: Decode BYTPE bits when printing PSTATE
>   arm64: unify native/compat instruction skipping
>   arm64: traps: Shuffle code to eliminate forward declarations
>   arm64: BTI: Reset BTYPE when skipping emulated instructions
>   KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
>   arm64: BTI: Add Kconfig entry for userspace BTI
> 
> Mark Brown (1):
>   arm64: mm: Display guarded pages in ptdump
> 
>  Documentation/arm64/cpu-feature-registers.rst |   2 +
>  Documentation/arm64/elf_hwcaps.rst            |   5 +
>  Documentation/filesystems/proc.txt            |   1 +
>  arch/arm64/Kconfig                            |  25 +++
>  arch/arm64/include/asm/cpucaps.h              |   3 +-
>  arch/arm64/include/asm/cpufeature.h           |   6 +
>  arch/arm64/include/asm/elf.h                  |  50 ++++++
>  arch/arm64/include/asm/esr.h                  |   2 +-
>  arch/arm64/include/asm/exception.h            |   1 +
>  arch/arm64/include/asm/hwcap.h                |   1 +
>  arch/arm64/include/asm/kvm_emulate.h          |   6 +-
>  arch/arm64/include/asm/mman.h                 |  37 +++++
>  arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
>  arch/arm64/include/asm/pgtable.h              |   2 +-
>  arch/arm64/include/asm/ptrace.h               |   1 +
>  arch/arm64/include/asm/sysreg.h               |   4 +
>  arch/arm64/include/uapi/asm/hwcap.h           |   1 +
>  arch/arm64/include/uapi/asm/mman.h            |   9 ++
>  arch/arm64/include/uapi/asm/ptrace.h          |   9 ++
>  arch/arm64/kernel/cpufeature.c                |  33 ++++
>  arch/arm64/kernel/cpuinfo.c                   |   1 +
>  arch/arm64/kernel/entry-common.c              |  11 ++
>  arch/arm64/kernel/process.c                   |  36 ++++-
>  arch/arm64/kernel/ptrace.c                    |   2 +-
>  arch/arm64/kernel/signal.c                    |  16 ++
>  arch/arm64/kernel/syscall.c                   |  18 +++
>  arch/arm64/kernel/traps.c                     | 131 ++++++++--------
>  arch/arm64/mm/dump.c                          |   5 +
>  fs/Kconfig.binfmt                             |   6 +
>  fs/binfmt_elf.c                               | 145 +++++++++++++++++-
>  fs/compat_binfmt_elf.c                        |   4 +
>  fs/proc/task_mmu.c                            |   3 +
>  include/linux/elf.h                           |  43 ++++++
>  include/linux/mm.h                            |   3 +
>  include/uapi/linux/elf.h                      |  11 ++
>  35 files changed, 560 insertions(+), 74 deletions(-)
>  create mode 100644 arch/arm64/include/asm/mman.h
>  create mode 100644 arch/arm64/include/uapi/asm/mman.h
> 
> 
> base-commit: f8788d86ab28f61f7b46eb6be375f8a726783636
> -- 
> 2.20.1
> 

-- 
