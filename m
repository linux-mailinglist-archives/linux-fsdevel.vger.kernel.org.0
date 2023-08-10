Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A17779AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjHJNej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHJNeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:34:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38252106;
        Thu, 10 Aug 2023 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+P9sNH71xdSnZ55Qo8IbTCdoxxs3507AZMmWWiXwUw=;
 b=F4+wkQUcBHKCO/A4R1XJta6zjFmSKXiFu9mKNvAJXJD+5dYMfB52TEBZ6ra5Ez+33wCxefCVHGH+N5kqq43Ng9LYKyP+/70CiPEjGLqjCj4xveTZ2nX2lLT6IRVkeIRlEsHWE+SWY18qp7tr56vtklxG8WFt2XAlTTjCQmELJ3I=
Received: from DB8P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::28)
 by PAVPR08MB9040.eurprd08.prod.outlook.com (2603:10a6:102:32d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:34:32 +0000
Received: from DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::9a) by DB8P191CA0018.outlook.office365.com
 (2603:10a6:10:130::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 13:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT020.mail.protection.outlook.com (100.127.143.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20 via Frontend Transport; Thu, 10 Aug 2023 13:34:32 +0000
Received: ("Tessian outbound 169aaa6bf2b7:v175"); Thu, 10 Aug 2023 13:34:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6232d1537c072f4d
X-CR-MTA-TID: 64aa7808
Received: from 4f57aa4cdd8d.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F6073716-51A2-4679-AE41-BE0783E28F7A.1;
        Thu, 10 Aug 2023 13:34:23 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4f57aa4cdd8d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 10 Aug 2023 13:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CatSmqqjzAZCflAR1k5JOY+OJ96XDQulOzQC1575kYhYLTj4QTFtfQas4aOilIt+pqQbF/b/rc3l5jMFeOsfh0Mrkulmx8zBKX+AZGSuVu/oCb0pgCh95J0SW3kULmNoqE0BcZ2SH2MTH9hy3VLukE09xHAUZduu59tlOqSqkoqcwH7A1P+97mNDSBw90t3ASrYGLaQYha8mb4qeVxTlvYZ3XJFXviYprmyXhSypKhC6HL9yAjIKPi8uWcqAkGh/Mgoska5RFt9AGiKoH6CsbukU9FkmrTylA+bFH+DYp/FQxjWV0+8qNTGWBy1EGwGQTe1u1GqLgCx7PzI2t6CiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+P9sNH71xdSnZ55Qo8IbTCdoxxs3507AZMmWWiXwUw=;
 b=MEFpRYa0KQ/mEvv2vLSq+IH4Sn2FzsHR/Ks7ajfKrUGQVjj5kiXInFwhZ7cUoBbpvFC/6J56et8gQ0r1UP71DnfnFPJH5fqfOoxTVsIaSB1dMQfZneXgrBZ+h2x/Va+YQZXhuNZ6JXVEODF9QI7mGZ2eH+JfIJW1vnGoMZjpFlU/5a9f4oUY6z4/6bQfTo6ZvG+msVVI9AjXgm6mbBvWRqLdaysevDjAdbb6dhMXtxQksO0R2GYV1DqK/Q2XDbmSI0G7+1aJjZsye+3eF4V416Ax6SPTtPstIMwU/1GQNWn69kOqlo5oxECrffJ2+i7YmzBTWmOdRcwcaCDfIba1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+P9sNH71xdSnZ55Qo8IbTCdoxxs3507AZMmWWiXwUw=;
 b=F4+wkQUcBHKCO/A4R1XJta6zjFmSKXiFu9mKNvAJXJD+5dYMfB52TEBZ6ra5Ez+33wCxefCVHGH+N5kqq43Ng9LYKyP+/70CiPEjGLqjCj4xveTZ2nX2lLT6IRVkeIRlEsHWE+SWY18qp7tr56vtklxG8WFt2XAlTTjCQmELJ3I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB7172.eurprd08.prod.outlook.com (2603:10a6:102:20a::19)
 by DU0PR08MB9251.eurprd08.prod.outlook.com (2603:10a6:10:41a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:34:18 +0000
Received: from PAXPR08MB7172.eurprd08.prod.outlook.com
 ([fe80::5a76:5272:2887:31cb]) by PAXPR08MB7172.eurprd08.prod.outlook.com
 ([fe80::5a76:5272:2887:31cb%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:34:18 +0000
Date:   Thu, 10 Aug 2023 14:34:04 +0100
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
Message-ID: <ZNTnTGb341TSMuvA@arm.com>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZNSmFmYFHDw3NvvP@arm.com>
 <4e215e53-c7d1-4338-8df9-3f9bf783ced9@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e215e53-c7d1-4338-8df9-3f9bf783ced9@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To PAXPR08MB7172.eurprd08.prod.outlook.com
 (2603:10a6:102:20a::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAXPR08MB7172:EE_|DU0PR08MB9251:EE_|DBAEUR03FT020:EE_|PAVPR08MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3714343f-bb19-4792-422d-08db99a6878a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1u+TtOmUJAeU4mMlYJ++WwKp0ZjgMJfsb2Oh+2S4sGn9ZcSvZU638r2FbTdRMQwmBe5G/jZi1Fx/3iIpOqgmOgYHR+96qrID5w2MoPvWPKFhgxfC0jdItUrjnDomx+Yr35LLYvbtxthEcGZS7oPOdJKlxhG9QXld4XWHyusWOgA/IacC84b53xiiwCVUJGWPg7zp4iQkBUIM9ZdT74G4i0OOn//oqUPJEhC6H5Ail1RGCpa1FoEZjC8rBWOmB6gpg7GmgWNjqeqnHke9IJCBmOFd7nTYDhROopD/6GKTudqEbTcYmfWwsthg3EIPSBU3uECP80JzZVST8mt00FMpySLk27f01ojn5sdIDQkczIWizzTSDvnAV3nn85SRc1jX2V+uQc2vo02vQILlPaG0WWVkpjntYBf1WpmYuNv+IMCn3ooNR39QJFg7io0zbckytpnOJs+dCrkOcslFJT6Fg6py/qncFbsk58jEp8BCrypuoctfil+TLlgbfr0c8140QdP1o3XoIynwPGxoCfLie4j9CpFePYXpbupkulDSf8h+RmkWpEC+VAUNCiRL4qTD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7172.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(1800799006)(186006)(8676002)(8936002)(6506007)(26005)(41300700001)(36756003)(83380400001)(2906002)(2616005)(38100700002)(86362001)(7416002)(66556008)(6916009)(66476007)(66946007)(6512007)(4326008)(54906003)(6486002)(478600001)(5660300002)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9251
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f616eb5a-34c7-49ec-379e-08db99a67f62
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I9ZRMQIfU4v6PqCOsLIcu8GKocjgKh1otJ7fFBM4lwmShl3G8dsHFoacfUZT6zsIrAzUJTvJZoHMfN/bplW5I1OuYTsHweNa+PnglivI4Kbl/vjJHZX2tIbh/oVs+N+UyPhUphHVpzGucBHUqZPA/hTxqguZj7eK1WakDnsjqF3DmZSw+hwc3/4E8FaTLGRnrdD9W2wtTM1gYLJCEP1q3DDyc9jLMWLAT9TpQQrasP6NmMMEJuE493l6eSJ6ah4WkpOBCL5J2yiidNP+TT1/NPbWLmfl1JbB6CZKPA/tjArb3kFkGPFb9VrA6ccsBJgBj12trXxLnWSfI4wUR+BNn0I2fWabKpMMb8Uz8G+kfysAv8vgNXy5MUNRwFvdU+N3qK3k4MVJVJP0yC2G+U5WYinte9CqRhV3qZVNeKI3qWX/4dJF7yNIVLHhfRF03Z+1eW+ZDG9q5nOCE+FgWPeljECPFjTIWe77IcfYAAhkOJN3uRWnPmwMvslgfF51rKQzTB9crQjDEqjmHYeGJMF7ApJBRcrN0CoUHFJw/DtlLWvRERRkEEq2+YY2PCv4a9pfo3c+UPl3TKvoIvrsJ0tEWrNB/twpNlAU9OTCxoi2Bgs17MHxR+zybxgYAc5J07czwCQTd89lbpsP8g7llYcTchMvLmUrhljxHBjh+DAIOBTLdE5hmygZ99jtD5FPSXwzneIoF+eElSBVlU6AzvzTpy8gAWIL3RJBY8jeWh+ROU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(1800799006)(186006)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(107886003)(336012)(6506007)(450100002)(26005)(478600001)(6666004)(70206006)(70586007)(54906003)(36756003)(83380400001)(47076005)(36860700001)(2616005)(41300700001)(316002)(4326008)(6512007)(6486002)(2906002)(86362001)(6862004)(356005)(81166007)(5660300002)(8936002)(82740400003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 13:34:32.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3714343f-bb19-4792-422d-08db99a6878a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9040
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 08/10/2023 12:41, Mark Brown wrote:
> On Thu, Aug 10, 2023 at 09:55:50AM +0100, Szabolcs Nagy wrote:
> > The 08/09/2023 16:34, Mark Brown wrote:
> 
> > > It's actually based on bitrot that I'd initially chosen a smaller value
> > > since it's likely that functions will push at least something as you
> > > suggest, the patches now just use RLIMIT_STACK.  I'll fix.
> 
> > the pcs requires 16byte aligned stack frames, with 8byte per gcs entry
> > there is no need for same gcs size as stack size in userspace.
> 
> I agree that it's going to be excessive for pretty much all
> applications, I adjusted it to match x86 as part of the general effort
> to avoid divergence and because I was a bit concerned about non-PCS
> cases (eg, JITed code) potentially running into trouble, especially with

is that even possible?

16byte alignment is not a convention but architectural:
access via unaligned sp traps (at least in userspace).

it is possible to use bl such that the stack is not involved
e.g. if there is no bl/ret pairing, but if we base the gcs
size on the stack size then i'd expect one stack frame per
bl/ret pair with 16byte alignment, or is there a programming
model possible that uses 8byte stack per bl?

> smaller stack limits.  It's not an issue I have super strong opinions on
> though, as you can see I had implemented it both ways at various times.


