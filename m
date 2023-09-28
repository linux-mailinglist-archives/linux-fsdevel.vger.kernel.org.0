Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB87B2318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjI1RAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1RAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:00:03 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2071.outbound.protection.outlook.com [40.107.249.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A798;
        Thu, 28 Sep 2023 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+fE+7tV/oLB1Wx7LngAySEDb25Fz+qf9JsKa6Wgwp8=;
 b=6PsOF7luCBPMlVptpzby3woQ/x1Q7K/13iDsc8qjIRcwYf1ZXr5f+7qExo5A2e0HEot62nEkdOe/EJUmlla/AKTaAzP0+4E0l5eeLh7S4khdyh1H2DUOllc7G+sBv12E6GqOvtsoHpwcTFGtbCZ9zOkKm9P1DAVXaLTyJhnwUUI=
Received: from AS9PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:20b:46a::28)
 by PAWPR08MB9053.eurprd08.prod.outlook.com (2603:10a6:102:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 16:59:56 +0000
Received: from AM7EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46a:cafe::bc) by AS9PR04CA0037.outlook.office365.com
 (2603:10a6:20b:46a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Thu, 28 Sep 2023 16:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT027.mail.protection.outlook.com (100.127.140.124) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:59:56 +0000
Received: ("Tessian outbound ee9c7f88acf7:v211"); Thu, 28 Sep 2023 16:59:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 96bbd5875f488015
X-CR-MTA-TID: 64aa7808
Received: from ae34f44ea2b2.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DD68AE92-8A84-41D5-A044-5FA316D72A35.1;
        Thu, 28 Sep 2023 16:59:45 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ae34f44ea2b2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 Sep 2023 16:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBmkm46QyVYldy9Ay/rhgbsQXKf86a+euHSgGL2LoAIkhic2ej9dyfn2wUAueruhU7IY+sFPnl+ZI2j2LUZONgxjx4LFPejyxMGeqOz2hhzHM9JMQEwHDUOz2VWDp321oLeh+nEWpv/VwCSRnxceK+WlJ6nFX3Mf391Ij9draJnQaSK/DTGC73qZeZhexkGOyeG5DEBU2imN8G+v9occCZ97xl1jgo8toeJXJ0VU5BpdRHWuFNjfrT96rI7RemvJp6WvaPzyfY0S7Aq1bfKQAaG+B7ByutJgCHyN+VlK2PBmaXJUB6YgBFR15f7P/JYtkgtOoxPo5pwhpgiytEFAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+fE+7tV/oLB1Wx7LngAySEDb25Fz+qf9JsKa6Wgwp8=;
 b=i+Szi7C/Xq30p8PSgo8TcGkAxUO1oLt9JHSHZyBvRMpxzpraE9ltkEOxaGwzYoHbADdTBtGH30eeUNyVNe8+VwmurIZUXSdXX9LV24q8kIUE1T2JrkCsGQlEMvrrDvQd1xAUj/gPKPf4MM7p2BbQH53O+NxKDETKWVwyks0hDeDD7YPM1u7Q5q/L5ysujiMLbuWOEIgO+N1sX9j9hVia2J20LHHz69QjMCBhxMRqfDFn8xysBDcKvtv41Av5j5qn3Jzf2KY4qC4eK8mL4cNDHmdZNZxxPVbNw2xSYwjOj0dcyx/a5LxiE7vgIf+BodKUtkV4aOGJ1Dccea9Z7OrRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+fE+7tV/oLB1Wx7LngAySEDb25Fz+qf9JsKa6Wgwp8=;
 b=6PsOF7luCBPMlVptpzby3woQ/x1Q7K/13iDsc8qjIRcwYf1ZXr5f+7qExo5A2e0HEot62nEkdOe/EJUmlla/AKTaAzP0+4E0l5eeLh7S4khdyh1H2DUOllc7G+sBv12E6GqOvtsoHpwcTFGtbCZ9zOkKm9P1DAVXaLTyJhnwUUI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM8PR08MB6626.eurprd08.prod.outlook.com (2603:10a6:20b:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:59:41 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e34a:7a41:96db:8aba]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e34a:7a41:96db:8aba%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 16:59:41 +0000
Date:   Thu, 28 Sep 2023 17:59:25 +0100
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
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
Message-ID: <ZRWw7aa3C0LlMPTH@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOYFazB1gYjzDRdA@arm.com>
X-ClientProxiedBy: LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AM8PR08MB6626:EE_|AM7EUR03FT027:EE_|PAWPR08MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 4574199b-d25f-4199-c1c6-08dbc04457b5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: E3P97YBo0OgulrlE25F191cxETaPMCVoGGLqJVmqDz6j4DNz6A6D9/c+QRfEcx2bNqJI0qCqinF+71q9iMVyvvrXG9KQbMQ5ph0miQgx/Am2sP4u4hx295kc5QWbpYwdidi9/Dsp/iAtKx4nV4E1Kwat0KVEDaAq6ThuOsUJEondR+XB+2LR7KDenO2TN7dlZSVHCXVZBuCZnnB7O5UEK4RX82jRlOR9Xo2ARr7scIkVa51yYoAfHiZ2yy3iF57zsrKcRCY/oWVoEQwS/an+0LpxJCjX5iVyuPrMZAOvwrk+KCy9+ZxjPhNU4z+iakyEXIGD/Lu4LH9iEHbGFJF/VHUxK4MF4jKr7uCgBOYGB0rtQuyqanv3umRk/sZQl1AdxVIGGPM/w0uYbBHMIZAKvRUM/WpFRXFTP8BsZdWu25HbmkgP6HIpZy70FLcNktojhMCmnyDc/H6CBxkbgRw6eWyYLg4D+XqW76eYVhVr6AwCSMZwywBaePQVOIkXCcOaFYvtYUoB5WR5sFv1LgHgxmSZo9ImRyhQziDIiakvX2gF0jfrIwDahXhC3QP8eurX
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(6512007)(316002)(66946007)(6636002)(2616005)(54906003)(41300700001)(66556008)(37006003)(66476007)(6862004)(8676002)(4326008)(8936002)(5660300002)(83380400001)(6486002)(38100700002)(478600001)(6666004)(6506007)(7416002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6626
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 140f5b10-f0e6-4f3f-aae7-08dbc0444eaa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJmVU7UsPbmynm3PNomXjf5RVFKYS03DYdpev7uNGYboPt7KesnjlKBWxeFMGewfPdb3FbDFUQRmy1dMZsF/vGiw4aIHeeNIR4G/NxXK80z1glVVuw3/TW6/OIomUyRXyIXrhsV/FJErR4M2FhaaI0idY23hfcCUONqa872csoocrJq4okjRsQAhPxpPhnBbsI/uLrrgJ3SAaLBX9qHlpZWr33hvvGx7nZe3eaKMDeVxnMjYV4h0Zic19aFHQJRdBNN8Dgeuko+YCbdvA9bsJ/FxpscYhV2s0hGkv5V5uLaNdUOXCPYC6TqvWXUm+BOJ2L35KBsIBItNhWx1HbuWBjOHYE6DEwLZEVnhWh+LxAJslqc2aBgNx8l6SSKEdAQxpQ4fqPV8if9tTIqXc9ZBEiBuwPykyqJtQxLsb2ICV9XYMqu0e5VunRoCE0+AUrqLLagkoZ+9VFVc9UH2AY5a19pjZbt7heJJzJD+wZ3fSThiKD1E3lcPD+woARu0vBE8b1+0UxzIJLr8Ot7oH5NgN/g4oeroySmnMuSCGNOUkzKROkXMepMfRyM+dbCN9GPAC62RZGqjg0DmpzFJCHJN/aar5HBRcJX6RiMNYTKb626Id2ih4KJFdWbFfur+eLonvKnBSQXFtIq9DXzDorTfRnoILmDoM7vjcznvwQ4YQDkG40AAbVY/vqq5R7oUuh43wMz4mFh21WsRPzH79l7ohmplpL9aotz7ZEGfNACcLzVPv0liqOyJHlepSqnKZHZJ
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(47076005)(6666004)(478600001)(83380400001)(36860700001)(40460700003)(107886003)(2616005)(26005)(336012)(82740400003)(40480700001)(6512007)(356005)(81166007)(6486002)(6506007)(86362001)(2906002)(450100002)(5660300002)(8936002)(8676002)(6862004)(4326008)(70586007)(316002)(36756003)(6636002)(70206006)(37006003)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:59:56.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4574199b-d25f-4199-c1c6-08dbc04457b5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9053
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 08/23/2023 14:11, Catalin Marinas wrote:
> On Wed, Aug 23, 2023 at 11:09:59AM +0100, Szabolcs Nagy wrote:
> > The 08/22/2023 18:53, Mark Brown wrote:
> > > I do worry about the story for users calling the underlying clone3() API
> > > (or legacy clone() for that matter) directly, and we would also need to
> > > handle the initial GCS enable via prctl() - that's not insurmountable,
> > > we could add a size argument there that only gets interpreted during the
> > > initial enable for example.
...
> > and there is user code doing raw clone threads (such threads are
> > technically not allowed to call into libc) it's not immediately
> > clear to me if having gcs in those threads is better or worse.

i think raw clone / clone3 users may be relevant so we need a
solution such that they don't fail when gcs args are missing.

userspace allocated gcs works for me, but maybe the alternative
with size only is more consistent (thread gcs is kernel mapped
with fallback size logic if gcs size is missing):

> An alternative would be for the clone3() to provide an address _hint_
> and size for GCS and it would still be the kernel doing the mmap (and
> munmap on clearing). But at least the user has some control over the
> placement of the GCS and its size (and maybe providing the address has
> MAP_FIXED semantics).

the main thread gcs is still special: the size is provided
via prctl (if at all).
