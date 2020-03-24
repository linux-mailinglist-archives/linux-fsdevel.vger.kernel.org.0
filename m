Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F283191532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCXPnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:43:20 -0400
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:6067
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbgCXPnU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fla4sXaPad55Nij6ZzXNP1ZOBrwBbcC5iu0t+8KKT4=;
 b=XqiHYJigOLsJh0RvO980q3krI5r1UPuFX+Ge+O7+TmEox9qP1jSeySImy3TiGohVa6TZYnURNBlo7tu80alaBxTWnr2nPhrE6jpRS3jNFN/rm7GC6k57lCqa8yTs8xa6xpEgGEv7ahyJvfdwdDcneA0RQZ0ZCiLPtBTlHByVtmo=
Received: from AM0PR0102CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::32) by DB7PR08MB4601.eurprd08.prod.outlook.com
 (2603:10a6:10:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 15:43:15 +0000
Received: from AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:0:cafe::d3) by AM0PR0102CA0055.outlook.office365.com
 (2603:10a6:208::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Tue, 24 Mar 2020 15:43:14 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT028.mail.protection.outlook.com (10.152.16.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 15:43:14 +0000
Received: ("Tessian outbound 88ba19940385:v48"); Tue, 24 Mar 2020 15:43:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6690d2a80a708ad5
X-CR-MTA-TID: 64aa7808
Received: from 5c87364f9cf0.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FC568FD2-1ABD-472A-915C-5C8A3C80FB6C.1;
        Tue, 24 Mar 2020 15:43:09 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5c87364f9cf0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Mar 2020 15:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/BFiRwrACG7uytRWnw50hjG6bqsUl3chkpD33AO0f4aq9GPIrreBf4DJ3HEgUCeAkBoblutsnlfbfNZbMs/B2975NSwsxRTV4N31Sjcaq1tCPgfS6HReEY8o32apwPAG2EjWJOaosj/reKzHDdTvoUgoc9tKCno8nPr2MsOKzJoO9x8LY8A88NmCQdynTnE/4QsdNM45NoLm1FZ+34/SJdtmPJyi2q8EYNfm3P4dwNAD7Ib0wOJtnfa37AUyMn0sT5OwvP2dFpjqvZHgBfksKwfhjp8vE6zfUe3HWlSlzzEFkVe8nR8CEUwvUmIynAM0M8YEhiQmT5wOJzN5rtX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fla4sXaPad55Nij6ZzXNP1ZOBrwBbcC5iu0t+8KKT4=;
 b=BTh7mY+dgL9uc4knbPqz6O2hquD2g/LQlfP1Fn8vejgZskR5A4jLDI5GVjM4himbPP0mx3B+DpxxCo++Xsch+Z8EjphRqMZ2nLa4JPtr6Dj5AOSZ4ecOta0597OMWzy0p4INmNiWfE3orXDyvo6qx1RLYf570wYt9Z4rh+oEgApfVjMCdPaE77LeMY2YCqNB5aJKSq59zOstieAhLpFyEn8heRQJvlffD4J5kRPKzRsSFPLvKTfQA27gwrssft3KTDKealik6kkwz5/51D3/2obTfDM7HOId9Vm5ApFbgT0Zef1MRlaP73V3NoO3fbvIhBV2uqUGTpkWqP1lvya9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fla4sXaPad55Nij6ZzXNP1ZOBrwBbcC5iu0t+8KKT4=;
 b=XqiHYJigOLsJh0RvO980q3krI5r1UPuFX+Ge+O7+TmEox9qP1jSeySImy3TiGohVa6TZYnURNBlo7tu80alaBxTWnr2nPhrE6jpRS3jNFN/rm7GC6k57lCqa8yTs8xa6xpEgGEv7ahyJvfdwdDcneA0RQZ0ZCiLPtBTlHByVtmo=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (52.135.167.23) by
 AM6SPR01MB0057.eurprd08.prod.outlook.com (10.255.22.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Tue, 24 Mar 2020 15:43:06 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::8937:3724:2930:ee81]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::8937:3724:2930:ee81%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 15:43:05 +0000
Date:   Tue, 24 Mar 2020 15:43:03 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
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
Message-ID: <20200324154302.GE27072@arm.com>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
 <20200323122143.GB4892@mbp>
 <20200323132412.GD4948@sirena.org.uk>
 <20200323135722.GA3959@C02TD0UTHF1T.local>
 <20200323143954.GC4892@mbp>
 <20200323145546.GB3959@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323145546.GB3959@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 24 Mar 2020 15:43:04 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9be292f9-c3ac-4696-4043-08d7d00a10f9
X-MS-TrafficTypeDiagnostic: AM6SPR01MB0057:|AM6SPR01MB0057:|DB7PR08MB4601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB46019A5C09FDFE6FF975237BEDF10@DB7PR08MB4601.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(44832011)(52116002)(2616005)(54906003)(7416002)(186003)(16526019)(5660300002)(956004)(36756003)(316002)(26005)(37006003)(33656002)(66556008)(66476007)(86362001)(55016002)(8886007)(7696005)(66946007)(2906002)(8936002)(6862004)(4326008)(81166006)(6636002)(1076003)(8676002)(81156014)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6SPR01MB0057;H:AM6PR08MB3047.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: A1Jtn34/+YB9dSxMHQ7EISovEjQ7jir+WLE3hBXSuQReQjdqF9RlXXb3lNabgDmef8yiyqNucbPOnF/nDn7LKTgvng4RTiC9SwMEeyXnAj1hF9hKDJRvqtxJN5oNuKaPZA+NqxpDgyfrd0Yrtr2mfFhowDpzHjHPiLZCdEPPh3xG/niGXPkHju3Ni/MpCSdngFhc4LLxhrHAWcGSuttKyY5dZuKJOV4IJ9q7pXD57cvmOntZG8ubQfUXAjz3b2UI7QWbICptfLt1Un2FXaBXAfxM3GXuk4O5uxsO2IEaQbM6LkvCsioxJte9cpe8jVcHrvFv+KNrFmPEiavE2XxlMsTSqC/eWXZC53m9rzmmMiGH4mib2wFPKKhUlaliyZmWLkQ3euEH//NDfSNQ/wLOUejSY/fzadWzPYxe4m8XofgK6Rk+Sw3ZkMyjtZxdxZze
X-MS-Exchange-AntiSpam-MessageData: vuWyBS9Xoef4twMPtmolp3Igxu9csJMYAhyDfrBghReZcdLb1dSM3d3mGkgYHDZtcQWM89/xLapLG+iLp//1lhqHhrrjiMfcmL3xuPNQd6HzVQS8Jsn5osafv4HFrP+1Ib664SeIlqTiuurnwzlClA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0057
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(356004)(8936002)(81156014)(8886007)(16526019)(2616005)(478600001)(7696005)(956004)(186003)(450100002)(4326008)(8676002)(26005)(2906002)(5660300002)(86362001)(6862004)(44832011)(47076004)(37006003)(54906003)(26826003)(36906005)(81166006)(336012)(33656002)(1076003)(55016002)(70206006)(6636002)(70586007)(36756003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB4601;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f9842d1-533d-40f9-7bb6-08d7d00a0b5a
X-Forefront-PRVS: 03524FBD26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKfp8SAPWmw44RaCUC26oXB0bsi/R+fQrJgrjV1a9mXXTtTL3uGGA/pnZ1S+J7X8aFX37cwiGH0eIv1lUqJsnjJ2TLjx5tfF6FY3sV/HnsBA6qyI99CXV7U9tW4wjWLVqt+4fUk1zLxghSbgIpbYiX9Utt03dYsWKYFMcgkjtL74c19MFca0bVOKXAlRKmZS2lR9/2DLrQvwdmSmwTqpki3LzPmSGbBrEIdRii1dglvA5bmQ9rm1d8J4ROF6BhV/NdwZhe4yL09L/04gN81RtablrbfI7w+i8UeUu0BDu2Ds/6DiDiddtNDMmvHQp+gRnJ0kyK22oOKTYxNjSYEiEgbeU5ceCudWC2CVsHq0ML+/c+T9mzFXvTxi+V7y1dWHM7nRjGFXprfFT6yw3xduJt7ArGyYMjjlG8LsvjU2xO8+VDROWLrkghsD4NeuSDcW2ZCuOMS8W/DCcFDp86q2W8+dsPjNLsZ8r+njobDc/drIUGlB0Hh6quzfqkG35Tv9aahpc0qPujoQ0UmwBkEiZg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:43:14.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be292f9-c3ac-4696-4043-08d7d00a10f9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4601
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 03/23/2020 14:55, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 02:39:55PM +0000, Catalin Marinas wrote:
> > On Mon, Mar 23, 2020 at 01:57:22PM +0000, Mark Rutland wrote:
> > > On Mon, Mar 23, 2020 at 01:24:12PM +0000, Mark Brown wrote:
> > > > On Mon, Mar 23, 2020 at 12:21:44PM +0000, Catalin Marinas wrote:
> > > > > On Fri, Mar 20, 2020 at 05:39:46PM +0000, Szabolcs Nagy wrote:
> > > > 
> > > > > +int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> > > > > +                        bool has_interp, bool is_interp)
> > > > > +{
> > > > > +       if (is_interp != has_interp)
> > > > > +               return prot;
> > > > > +
> > > > > +       if (!(state->flags & ARM64_ELF_BTI))
> > > > > +               return prot;
> > > > > +
> > > > > +       if (prot & PROT_EXEC)
> > > > > +               prot |= PROT_BTI;
> > > > > +
> > > > > +       return prot;
> > > > > +}
> > > > 
> > > > > At a quick look, for dynamic binaries we have has_interp == true and
> > > > > is_interp == false. I don't know why but, either way, the above code
> > > > > needs a comment with some justification.
> > > > 
> > > > I don't really know for certain either, I inherited this code as is with
> > > > the understanding that this was all agreed with the toolchain and libc
> > > > people - the actual discussion that lead to the decisions being made
> > > > happened before I was involved.  My understanding is that the idea was
> > > > that the dynamic linker would be responsible for mapping everything in
> > > > dynamic applications other than itself but other than consistency I
> > > > don't know why.  I guess it defers more decision making to userspace but
> > > > I'm having a hard time thinking of sensible cases where one might wish
> > > > to make a decision other than enabling PROT_BTI.
> > > 
> > > My understanding was this had been agreed with the toolchain folk a
> > > while back -- anything static loaded by the kernel (i.e. a static
> > > executable or the dynamic linker) would get GP set. In other cases the
> > > linker will mess with the permissions on the pages anyhow, and needs to
> > > be aware of BTI in order to do the right thing, so it was better to
> > > leave it to userspace consistently (e.g. as that had the least risk of
> > > subtle changes in behaviour leading to ABI difficulties).
> > 
> > So this means that the interpreter will have to mprotect(PROT_BTI) the
> > text section of the primary executable.
> 
> Yes, but after fixing up any relocations in that section it's going to
> have to call mprotect() on it anyhow (e.g. in order to make it
> read-only), and in doing so would throw away BTI unless it was BTI
> aware.

note: on the main exe only one mprotect is used in case
there is PT_GNU_RELRO (or DF_BIND_NOW) to mark part of
the rw data segment read only. so if PROT_BTI on main
exe is ld.so responsibility that adds one more syscall
to the program startup (not a huge cost).

(currently executable segment can be mprotected by libc
in case of text relocations but those are not fully
supported and won't work under various kernel hardening
schemes that disallow exec+write mappings)
