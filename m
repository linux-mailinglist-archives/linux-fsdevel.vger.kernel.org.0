Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D337B7B64A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbjJCIqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbjJCIqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:46:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3909AC;
        Tue,  3 Oct 2023 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3FR+XsUkAb07K1BsVq2myWzXOMLFKW2bf9kUJfgJso=;
 b=lZ2lksXhDK5uw9p/vLR7uXp8ivWY4qjD425YWW/ouRf7tL+7GbDeFZYHCRASIk6n8iAJV47wmY/YIbnjM5T+o4QAfGv+wTJuGpDE1Leq7EGSgu1cTeZlzthuXvCU0bXb7BPjXMHWyc0lD+WTDCw4+ZxAZwgcqL182RIJyjW6mqw=
Received: from DB7PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:10:36::23)
 by AS2PR08MB8383.eurprd08.prod.outlook.com (2603:10a6:20b:55a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 3 Oct
 2023 08:46:27 +0000
Received: from DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::43) by DB7PR05CA0010.outlook.office365.com
 (2603:10a6:10:36::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Tue, 3 Oct 2023 08:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT011.mail.protection.outlook.com (100.127.142.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.24 via Frontend Transport; Tue, 3 Oct 2023 08:46:27 +0000
Received: ("Tessian outbound ab4fc72d2cd4:v211"); Tue, 03 Oct 2023 08:46:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 74118f93a405798c
X-CR-MTA-TID: 64aa7808
Received: from 52bafdcfe683.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A54C3ABA-CB31-4A35-8381-D2F938FA5FC2.1;
        Tue, 03 Oct 2023 08:46:16 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 52bafdcfe683.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Oct 2023 08:46:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt0RuRQA74jRHar8hfIU8lWwKaxJJdgG7jU4y66nEz9F2dES0A07DTYyVA9YARASp27b+3J7SQ1r7vaULpD+ify3FzLSaLTimmqBcCGjBoVTkvW3dzlpW+3L5QJjaCdeW3Z9KxaFENt1wCtoJ+4KCh5MO2Ke3ZgnWTTlbaLgjUlWjXrWq/BFbWVWfVNkO3f3TZT4cas3VGeyk19TlN3ehO8SqmbQsU4g41ELgk49sv+wE2ZiKM/D2z1TF38cZBJdIejMfa+Kjn61R3AmzCQ60zfD+ljtiX5dVlZMVHTJr6EdjpejMDy+EXIbtorNAqanBBLkvjdY/eqWwIxhGO6jcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3FR+XsUkAb07K1BsVq2myWzXOMLFKW2bf9kUJfgJso=;
 b=ciZ5mG++PRC7FIN/Iy2iHL3l5ro6QNpIJ2VtESA1Zcu3pdn8eWFdfiOBxcRsLU0pGZ59n40gCs4DdH4pXsWo20ABIhYvinj3dRzFny04QGZLKGc+8CruI35Bfa8wLtwqY76JZst+8hN7+VgezkHh6T4HTQwdoyeQUuMrx8YlY9amvDpunvLmhfyJtUUeCaLfIkgKzyscIALCZAJ294KrPlylurdD8p00lew0+OSWaOd137HX/6ysG0JeVfbXc1I9wc/azx6QWiTgs+gNGLirxVT7qwfDT84jDIYBj8KnbyNwKKUriwx2ys+R1C4Rz4h89rRxk30efmO214sswyS/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3FR+XsUkAb07K1BsVq2myWzXOMLFKW2bf9kUJfgJso=;
 b=lZ2lksXhDK5uw9p/vLR7uXp8ivWY4qjD425YWW/ouRf7tL+7GbDeFZYHCRASIk6n8iAJV47wmY/YIbnjM5T+o4QAfGv+wTJuGpDE1Leq7EGSgu1cTeZlzthuXvCU0bXb7BPjXMHWyc0lD+WTDCw4+ZxAZwgcqL182RIJyjW6mqw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB9219.eurprd08.prod.outlook.com (2603:10a6:20b:5a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 08:46:13 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e34a:7a41:96db:8aba]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e34a:7a41:96db:8aba%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 08:46:11 +0000
Date:   Tue, 3 Oct 2023 09:45:56 +0100
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <ZRvUxLgMse8QYlGS@arm.com>
References: <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
 <ZRWw7aa3C0LlMPTH@arm.com>
 <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
X-ClientProxiedBy: LO2P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::20) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB9219:EE_|DBAEUR03FT011:EE_|AS2PR08MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b8dd71-f44d-4926-bca2-08dbc3ed3b62
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lwz41uy8E/+WYL8kGSYOQ7mGoDrnRSVYD4GEiKcfSwpcMkhTiU2OvEIShlAK/0Rn8kKzfIwUPAMvNSZ3kwd5qUo4tFhzEXYDYp2R4X1ciXWgSi82QZEGxcG5VGpZyPeNViZom/Lyqk4g1qiMh5R5x0NK3kEaH5lWdu7NYCjtTGsBzL5i8zvNZQC0EwL9143mKDhTFjEHV/SeOrQlWrrCbL+t6+0qCPhvDkTNnznixNI7Ex82DjnirYqZ83iSw3/cYW5bo5WINLQ/2ZEJKwJYBbeLfoSZw3bvh5WLX6bS2HWWHYseErTct5OpUHcHcBuVQko2g4TYWJppYzuTIltaBsSTraiq0rhIkxUsSd2oiQoIdHYjzKFQGy//A4/2NItSpmFcfY1lJ7I5/Aj+CaVy6+O4wZiNjA/j4L+nvowg0YrGcl3Xd2aUjbOfjJa4A5zemg+SskQy0or+qhnwb4VzxWEYEap+ugQ8b5W0yxYbfiep935qeI9+mBYyW/LDz7yl7GGfOB0PWumcBx4391y7Qq3b54j2pygwE3hpU+ISirp9Pw+bH1HXCs1pQDmzv/Z5
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(8936002)(8676002)(4326008)(26005)(2906002)(478600001)(316002)(66556008)(66946007)(54906003)(7416002)(6916009)(66476007)(6486002)(41300700001)(6506007)(6666004)(6512007)(36756003)(2616005)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9219
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ced56863-5bee-4f49-b9e1-08dbc3ed31e4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cB1zBN3bkRX4sDAE1bFONfZKIjgtXhs0nC9CM1wxYZ6D59SHcCxF/AHqYE5BL185Rt09AndqcvAuzev4rkmfRbTq68TBzM5aL6nOj/7FDb1XRVSMB2ADqFR4fkRTPlXKUKKpjzuvkcI2750Gfjon293p/zGtCU3rW9YhrSjpt8pCuRErSK80kbLUrJNo7Lg5egotrt7CPMr+0hQG9Unt2SqmKZXyzcHYUR/I6JM3rMt04sSsUadH3qBe81cp9Wm1hP6r4dstRXhSwrsVS1mMIUCOd7qTTemHGsQr0BJWVh1/pgCM7r8c8Fuy9JupGDJ9j+0FOppXdLMYDTCP9oCMs5vJNFxB611Mqj6aNxZkj0rce5yMyqLNX5UB8GyGEqX4ZC47I1lyYYWN1zxezYZCiKNZvypc3WqGtQvAg63rTm6BXz4pnvUwhrEQj93lDjXbkLB3pwJGj4K/259S5N292RVWhrcLR2XAhpZsZmk8IcTivmr44LD5bYR3lJ3E5tNJCHgMU9ZlO5WLKQWJ+vG4JO+JDUOXAfHwQkGbNmMtXDk0uHyul4tIRuCH7xGgz6PBPTWBhU4eb1i8tYdAjngslUYEvv3Y3HRqElwEIMcRFXBUXLAVxuJUncHJ2Rpu+G0aJAuIMDbSHew5bSXmDZ04emc6QLkUWPNlWHbsMneFAIAQRS3j65N2Zn91ay9m8E8OIENlmk0EJLjn9OzP9EqmP6SXE6C4CSj/n57QMhQz+3eDTU9UDOajEnWxqL5DfznG
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(40480700001)(36756003)(2906002)(5660300002)(450100002)(107886003)(36860700001)(83380400001)(336012)(41300700001)(6512007)(4326008)(316002)(2616005)(8676002)(6862004)(26005)(47076005)(8936002)(70586007)(6486002)(81166007)(70206006)(356005)(54906003)(82740400003)(6506007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:46:27.3111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b8dd71-f44d-4926-bca2-08dbc3ed3b62
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8383
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 10/02/2023 20:49, Mark Brown wrote:
> On Thu, Sep 28, 2023 at 05:59:25PM +0100, Szabolcs Nagy wrote:
> > The 08/23/2023 14:11, Catalin Marinas wrote:
> 
> > > > and there is user code doing raw clone threads (such threads are
> > > > technically not allowed to call into libc) it's not immediately
> > > > clear to me if having gcs in those threads is better or worse.
> 
> > i think raw clone / clone3 users may be relevant so we need a
> > solution such that they don't fail when gcs args are missing.
> 
> Are we sure about that?  Old binaries shouldn't be affected since they
> won't turn GCS so we're just talking about new binaries here - are there
> really so many of them that we won't be able to get them all converted
> over to clone3() and GCS in the timescales we're talking about for GCS
> deployment?  I obviously don't particularly mind having the default size
> logic but if we allow clone() then that's keeping the existing behaviour
> and layering allocation via clone3() on top of it which Catalin didn't
> want.  Catalin?

clone3 seems to have features that are only available in clone3 and
not exposed (reasonably) in libc apis so ppl will use clone3 directly
and those will be hard to fix for gcs (you have to convince upstream
to add future arm64 arch specific changes that they cannot test).
where this analysis might be wrong is that raw clone3 is more likely
used as fork/vfork without a new stack and thus no gcs issue.

even if we have time to fix code, we don't want too many ifdef hacks
just for gcs so it matters how many projects are affected.

> > userspace allocated gcs works for me, but maybe the alternative
> > with size only is more consistent (thread gcs is kernel mapped
> > with fallback size logic if gcs size is missing):
> 
> If we have size only then the handling of GCS and normal stack in struct
> clone_args would be inconsistent.  Given that it seems better to have
> the field present, we can allow it to be NULL and do the allocation with
> the specified size but it should be there.

i see, then try the original plan.

> > the main thread gcs is still special: the size is provided
> > via prctl (if at all).
> 
> Either that or we have it do a map_shadow_stack() but that's an extra
> syscall during startup.

an extra syscall is not too bad for the gcs enabled case.
