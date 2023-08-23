Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2F7854FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjHWKLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjHWKKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:10:42 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44303E6A;
        Wed, 23 Aug 2023 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOrDUd+FVk3vNXJqfNKW0UBrz813kwnlFgbS0CSGpQ4=;
 b=UrD5Sad51hJBTozIGdsHOE8HTs+icpKbg/uzZrAqriUEc8rK/FoB/64yetRLJw00Zb4xlQOKy+QQU8Sek3jNrDLVXhdEdDktxwsiJ0ks9ejuFG1gGNDOc2mtOWxdmPjHnyJOYdMh+rv13tpCPtC3eWneIgOFqX75OR6kuXzEBC0=
Received: from AS9P194CA0018.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::30)
 by GV2PR08MB8025.eurprd08.prod.outlook.com (2603:10a6:150:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 10:10:29 +0000
Received: from AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::4f) by AS9P194CA0018.outlook.office365.com
 (2603:10a6:20b:46d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 10:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT010.mail.protection.outlook.com (100.127.141.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.16 via Frontend Transport; Wed, 23 Aug 2023 10:10:29 +0000
Received: ("Tessian outbound 169aaa6bf2b7:v175"); Wed, 23 Aug 2023 10:10:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c34bbbab1685a211
X-CR-MTA-TID: 64aa7808
Received: from b8c08391aad8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 09E88E55-B2A1-47F3-9522-AF7217A665DD.1;
        Wed, 23 Aug 2023 10:10:18 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b8c08391aad8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Aug 2023 10:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4cvyyzLieK88VVTDZa+Rkyhrd5+ty0Fg3XXIPbYauXyuKVSbtrfToQLmX3GYdFv8hLfs7h9oDx/Bt0rPK7k838fFsHqBAP62U8KR3Br3H2rdPFRTEAK62gGJY7XISOsa0r/bT3ZcqsYmDYxV/k2ktI63fD0WlbhbaLc7m8ausMbdxLbfFFf4ryjBYEQkXcD/TAppkwqXga7MrV5s0zJPkOXZ/9UvoL8wJgtMEBKDaocGtcIM5dBbA0auYBXXxRaQimzUK+/OmN7BjUK2D+EWEmrUb9xKSNhWbac5L9pecOTGOmlUo0+fXm7XcmTcdNF3vQBk2JAdr+cVeUKtPyZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOrDUd+FVk3vNXJqfNKW0UBrz813kwnlFgbS0CSGpQ4=;
 b=Afh1kkua85zYo+g3NMohX6ohRzkM6iGT2UsyrmzahMSHh0lluLzCRzMBbAt/BrpNPuhn8apQEh3IkoprvQXUXS/mdBe0E6glCjDE1ikDIT/XFTghU/MdZWKmYA5lpnKTqjCI2U3NV7xYV1aDn0q7N8OdoKTl6rc6mpixIHup3HIHfRrOlP0oxXkkxRawui/UqI1MS2PNWKXRGFnyQRAtnxgs5iX3RDC9EYW+v5ZuajQdQNKnOHtazUSjzfEy/Vt16lscv2ItPv6tixBuIFg98ucdtDVRFFKD2lEfq5hmQoAq6hVFjWYF8UHpL+8jdnKNs4SHK1NHiQeeOfpCumPBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOrDUd+FVk3vNXJqfNKW0UBrz813kwnlFgbS0CSGpQ4=;
 b=UrD5Sad51hJBTozIGdsHOE8HTs+icpKbg/uzZrAqriUEc8rK/FoB/64yetRLJw00Zb4xlQOKy+QQU8Sek3jNrDLVXhdEdDktxwsiJ0ks9ejuFG1gGNDOc2mtOWxdmPjHnyJOYdMh+rv13tpCPtC3eWneIgOFqX75OR6kuXzEBC0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB3PR08MB8794.eurprd08.prod.outlook.com (2603:10a6:10:435::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 10:10:14 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::adb0:61cb:8733:6db2]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::adb0:61cb:8733:6db2%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 10:10:14 +0000
Date:   Wed, 23 Aug 2023 11:09:59 +0100
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <ZOXa98SqwYPwxzNP@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DB3PR08MB8794:EE_|AM7EUR03FT010:EE_|GV2PR08MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1fb4c9-5c88-4d23-6226-08dba3c12de3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4HQ0xxcgBBCPMnhSSd1T6C9csCC9TL4+zs4YYQeuKQc+0W/Z4RiJV5i1qaLdO1LDs1by7tXNfjKADieew0SnN5v22mpikYrpZLa/Mc1pE3qZtzQrH6gryCEkym4IncFvXo+d5FIRE1yUntf+PjjqTuGpf2KJEHS19IDsIVEk4VEFACENmSQcgwFcT8Je0ersGpNPUMCBR623lDPj3eYgbi2Hes+T0rLrO7QOhY9bcmmUi7O4VaqdZBQePX7VPGymTxhLldgIFIJiQxBzYRJgpRHPpFCVDoQxOFZk0jvXRTJq5rlAF0jeh5M1H8krHdRpsHJBdtTS8Lu5nd4slKla8ogREpIwbl4XJAoXkKe0MZEgPVjkXwjgcNgaEOoOwZXPJHjQs9LaK2DSG6lY5rvrEIN5H1gvlrTvoXe9fe0Asfzjz7jiW7MdEc7HZ2VHvBnS0Sx3U/lYNoThzVKYZvmK8SvebDRSQcjrvU/G1AxzwNQNd6B/QwYfAHXSQRvjJL2WJxZbOs3/SvhWfLElQ+lA/7mFg+C8I3LPtL9foB2qQwYyi39BbNmJW6yKQOqh1kVNFQnlT5Qls/OAmigC35eiYg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(1800799009)(186009)(451199024)(478600001)(6486002)(6666004)(966005)(110136005)(26005)(6506007)(2616005)(6512007)(7416002)(2906002)(41300700001)(5660300002)(8936002)(316002)(8676002)(6636002)(66556008)(4326008)(66476007)(66946007)(36756003)(54906003)(86362001)(38100700002)(83380400001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8794
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e78cbee6-df21-40e7-f701-08dba3c12464
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FmsQGRNHpqf7tRen0AqAW2QVEKhxnYdomyBhJMwGVUjcHJ+NF4kmsFd+5g16e5/GT4deWlU7fRfflfRFpVXfwjwgwnULjddVzgtmMchB3jM7zccAMOchPfJpfDstbOXV0KhuVbfrfYxYKj8xFOHRSibxgwRaUz9xTT8ToIrpUgCySYg3rqXLY+SsHW42Z6j8DbgYtzXqwh7kileQFL/hsW5dlhMN8AJl5wi4knzLovmxZCBjLvAE+Q206T8TvcGoCVrOgA8kDigx1maACiAehU9YUC0e2s0VRh0VyjLOUyv/Dm7/9XR4FT91Fbonoamw9eMt051Ggde5kye/eIS2lolRdIjzWax3Q4hbivCfDClvrVVd1QZ6zmWEv5vtgSMDY8yYPf36ju0/KiAaFAC2hPVTkf2dZlvzIn4H8We/Zvyt7DXaPGJRSQYrIa5HthQrv0GFV2408b3owomHAee5jQNUMqr35bXR86uW9OUKYOVtS+MY+v+Q6jUTTNOXn132YELO/ETcf8KF5I8PSB82hjYAu62nnrYv9PyyRPTdCltu5KRN7+KlpM11Ev8VHTFeUMcMK28QWyraZQq+qPoSKnEUxkSEjEUoTmHoEndpr37eNCVED+v1KjMyiKl2Co6nDTdUB1kzWyBuQLy6lq5RPu8/wooMaAxcQokGsd8HqJQqu/AwQt8fRrJ0HoEFjFnQvdfD9XVWLoRVbTQ+kZZQXFG0QPs6Gv5h87Z+4YQyofssVOvqgsh+4X3aF0J2CeQ9lOa+ZuW6/Dav9doSr8+AQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(86362001)(36756003)(356005)(110136005)(40460700003)(41300700001)(70206006)(6636002)(70586007)(54906003)(450100002)(966005)(82740400003)(478600001)(81166007)(316002)(6512007)(6666004)(47076005)(26005)(107886003)(6506007)(336012)(36860700001)(66899024)(83380400001)(4326008)(6486002)(2906002)(8676002)(2616005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:10:29.5386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1fb4c9-5c88-4d23-6226-08dba3c12de3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8025
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 08/22/2023 18:53, Mark Brown wrote:
> On Tue, Aug 22, 2023 at 05:49:51PM +0100, Catalin Marinas wrote:
> > On Fri, Aug 18, 2023 at 08:38:02PM +0100, Mark Brown wrote:
> 
> > > > stack and pass the pointer/size to clone3()? It saves us from having to
> > > > guess what the right size we'd need. struct clone_args is extensible.
> 
> > > I can't recall or locate the specific reasoning there right now, perhaps
> > > Rick or someone else can?  I'd guess there would be compat concerns for
> > > things that don't go via libc which would complicate the story with
> > > identifying and marking things as GCS/SS safe, it's going to be more
> > > robust to just supply a GCS if the process is using it.  That said
> > > having a default doesn't preclude us using the extensibility to allow
> > > userspace directly to control the GCS size, I would certainly be in
> > > favour of adding support for that.
> 
> > It would be good if someone provided a summary of the x86 decision (I'll
> > get to those thread but most likely in September). I think we concluded
> > that we can't deploy GCS entirely transparently, so we need a libc
> > change (apart from the ELF annotations). Since libc is opting in to GCS,
> 
> Right, we need changes for setjmp()/longjmp() for example.
> 
> > we could also update the pthread_create() etc. to allocate the shadow
> > together with the standard stack.
> 
> > Anyway, that's my preference but maybe there were good reasons not to do
> > this.
> 
> Yeah, it'd be good to understand.  I've been through quite a lot of old
> versions of the x86 series (I've not found them all, there's 30 versions
> or something of the old series plus the current one is on v9) and the
> code always appears to have been this way with changelogs that explain
> the what but not the why.  For example roughly the current behaviour was
> already in place in v10 of the original series:
> 
>    https://lore.kernel.org/lkml/20200429220732.31602-26-yu-cheng.yu@intel.com/

well the original shstk patches predate clone3 so no surprise there.
e.g. v6 is from 2018 and clone3 is 2019 linux 5.3
https://lore.kernel.org/lkml/20181119214809.6086-1-yu-cheng.yu@intel.com/

> 
> I do worry about the story for users calling the underlying clone3() API
> (or legacy clone() for that matter) directly, and we would also need to
> handle the initial GCS enable via prctl() - that's not insurmountable,
> we could add a size argument there that only gets interpreted during the
> initial enable for example.

musl and bionic currently use plain clone for threads.

and there is user code doing raw clone threads (such threads are
technically not allowed to call into libc) it's not immediately
clear to me if having gcs in those threads is better or worse.

glibc can use clone3 args for gcs, i'd expect the unmap to be more
annoying than the allocation, but possible (it is certainly more
work than leaving everything to the kernel).

one difference is that userspace can then set gcspr of a new thread
and e.g. two threads can have overlapping gcs, however i don't think
this impacts security much since if clone3 is attacker controlled
then likely all bets are off.

and yes the main thread gcs can also be libc allocated given we
have to deal with the prctl anyway.

if gcs size logic is in libc it can depend on env vars and can be
changed more easily (and adapted to android vs musl vs glibc
requirements).

sigaltstack with alt gcs was a case where i thought the kernel
doing it transparently is better (the libc cannot do the same
as it cannot wrap signal handlers currently so does not know
when a handler returns or the current alt stack state), but
others seems to want an explicit sigaltgcs syscall and expose
it to users. in any case we have no unwinder solution for alt
gcs nor longjmp solution when the thread gcs is overflowed so
this is not an issue for now.

> My sense is that they deployment story is going to be smoother with
> defaults being provided since it avoids dealing with the issue of what
> to do if userspace creates a thread without a GCS in a GCS enabled
> process but like I say I'd be totally happy to extend clone3().  I will
> put some patches together for that (probably once the x86 stuff lands).
> Given the size of this series it might be better split out for
> manageability if nothing else.

i would make thread without gcs to implicitly disable gcs, since
that's what's bw compat with clones outside of libc (the libc can
guarantee gcs allocation when gcs is enabled).
