Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662405BA3E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIPBRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIPBRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:17:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2205.outbound.protection.outlook.com [52.100.0.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90A7757A;
        Thu, 15 Sep 2022 18:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4zNsTA1GtSbc/0kAsfDc0D42MqMUxzKoKQxE+jbb4HFKt0l1Xa6OySfaHegb1mGJyat185df5zerzg05KYlbuS2xLe6QJgBNvAwOYT/6SHtRQFFfT1zPeQXkZneWVhz4QNh2WbINDhHSPVdJgvK2ds3KTAFlXPI7klef5eDdM6z/mOEA1nafD8f/uC1JJJ/v5BUiQooqnBHPszEPRvMSAip1wDuVdIttjpHdbKFE6oPl+c6nrOogdqTNY0VCsFAEOOI4Bbv9ygbY49M8QHFT8LjAhQ+UuAwgyv4BbRtH/RBqVjdPyPoTEry00wHj+00dgoJ52sn9V6btFE6mlebYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=ABF4zgQLqPSYDA3/AOmTmGs5pbxsOCLrHKldFkHAyKG7Eb9cDwIhH6cPVvalVW27VQ/GOR0WWe75cAGbXNNME98XP8O1A5Y/2r7W9M5AmB0RgHQ1ggFSuMtcY34fo/iwYY+WMWaEqd3mdi7tgLGpqQh8JIlWBPodeEUHR7PEWk9paY1QEKp+A44rnl+beLFnRAgLbbLrnMmJQpwjd3EjMynNffn9W0DEfSQMjtHyqTiKwm/qg8hSF8FW+RVQY+vfGA/YRFiPyNddJmy/v4iYAbcqYEXC0ex5AXseQpzknyjuRygZR/bXjPdhoGBKwf/ihIA2b1PAeTshDafVBOyXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 45.14.71.5) smtp.rcpttodomain=mail.uni-mainz.de smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0089.apcprd02.prod.outlook.com (2603:1096:4:90::29) by
 KL1PR0401MB4130.apcprd04.prod.outlook.com (2603:1096:820:21::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Fri, 16 Sep
 2022 01:17:34 +0000
Received: from SG2APC01FT0020.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:90:cafe::13) by SG2PR02CA0089.outlook.office365.com
 (2603:1096:4:90::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 01:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 45.14.71.5)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 45.14.71.5 as permitted sender) receiver=protection.outlook.com;
 client-ip=45.14.71.5; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.159) by
 SG2APC01FT0020.mail.protection.outlook.com (10.13.36.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 01:17:32 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-02.prasarana.com.my (10.128.66.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 16 Sep 2022 09:17:02 +0800
Received: from User (45.14.71.5) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 16 Sep 2022 09:16:27 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Fri, 16 Sep 2022 09:17:13 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <b6ddaece-1ca6-43f5-8952-0fc7d50aeeb1@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[45.14.71.5];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[45.14.71.5];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0020:EE_|KL1PR0401MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad405e9-5ae2-43d1-aa10-08da97813b2d
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?FHqI8+s7pKKRlS69NfkDlp1BxodDyoLQZMN7ITGboB71dh486cANKC47?=
 =?windows-1251?Q?1kYhoZSVY9O6IgjlubSS0jLTtf3V9SK6sqkanngfUQ/Zz4DSZY1HOClW?=
 =?windows-1251?Q?ntReVrwe8DBG1jzuoM8kimh9zadoh5ZbTRkPc46r11pB8NN8DEaDbZyq?=
 =?windows-1251?Q?c94xsQGITRm4Ub4NhZQzwlUCZwbw0Z5cgoLuKXoSIS+bY6LQNTlzuTv8?=
 =?windows-1251?Q?Zilwj1VupMrGVJ5MHKDIGpmA+f2jUvCZlGzLDwVJKbsJtTukkRAgan5P?=
 =?windows-1251?Q?qtsh+tRTtnJJg5mkNhv1sZO2IOt3Sn2mEXLvcC8r+qFhF0sHnbntOP0m?=
 =?windows-1251?Q?Pqy9sPZ5M1ukYPP3QkDAbYa40wB+prhusbZE0aiToCrXJPQ4B90OUmU1?=
 =?windows-1251?Q?Z+yrIMtvD38sw5oUqYfTdhttdrhmTLKC7ENigvomCFB6l6gUX9LTdQs4?=
 =?windows-1251?Q?HmzwAPWCQEMxBqpQDXE1ZzAyESwCn12NftDmcco8RmV1YblR22RF7yym?=
 =?windows-1251?Q?5NuKJa/PUPUuaOx4nAQNHHgwiC1SqG2fAecociulPUJ9Z58Q4xa8R6D5?=
 =?windows-1251?Q?3AnB1YHozvT9pD4bprgQzMRh0cyDU+DJPonD1vXYk/GAa51nysO4ODKE?=
 =?windows-1251?Q?qcjq9iUTE8DmC4nhN5ok6tYVgiqDEU885P9bnGV+/yDRwZiWfyZYyI96?=
 =?windows-1251?Q?a3k/I0RBGpA2s7FvvjakB5qS4KymcmE6uKjWnnCSDoca9G9debA/Z2Qu?=
 =?windows-1251?Q?di8gzhRgRIzN0pWeN8c/rAjH6xaeu3mj0cd11lskX/qBwf7JOrGiZ331?=
 =?windows-1251?Q?99utJAGwP6vqDh141fsr2q+c7JYDudamBAi0WjqHSjSg81AOP0LFM/TY?=
 =?windows-1251?Q?zGaQhSDiTQWT9bwFAQxGY7E5ZKgrzl8+Pp9gPbbt/Mkkq8vSTvbPAv8S?=
 =?windows-1251?Q?p6QF0P+L+MQE9YgqjIm/DdHCmbN9J/RFxnZZPU1cJV6LoWi2Aa5aR6yV?=
 =?windows-1251?Q?gnqsrOACuT2B5QHPGCvYyIJQYcYDZbvJRXYBgNwNPiIWVi48nU2GWvP+?=
 =?windows-1251?Q?A8Fk/0LV6OtLSLNmSpnazPhzco9KgJCSxOI/XiJDNWM1WJ7U+G4cWoju?=
 =?windows-1251?Q?UFmjSzd/XaXEoVZLK79nlBXMYOWxAAFQ3ZpS2F1ahwcOJQE09xZh1Jv3?=
 =?windows-1251?Q?PTF+b5aMPsmmgmmbpucQMey3UR+15oFAUI7bEgbEj7D6iqk55VP48EAs?=
 =?windows-1251?Q?PfC3X2qOo4OIy7J7wsqwrHVXVpuLlsDuD10exlN5lcteVtv8sgGKLbpX?=
 =?windows-1251?Q?qZP8PZXW+QlbgjYwDt1b76z8HM8PJ8ficinjDlGO/NRizKRX?=
X-Forefront-Antispam-Report: CIP:58.26.8.159;CTRY:JP;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:45.14.71.5.static.xtom.com;CAT:OSPM;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(66899012)(81166007)(31686004)(4744005)(2906002)(5660300002)(40460700003)(82740400003)(7406005)(7416002)(956004)(31696002)(26005)(9686003)(40480700001)(6666004)(41300700001)(498600001)(86362001)(8936002)(32850700003)(156005)(36906005)(316002)(336012)(35950700001)(82310400005)(109986005)(8676002)(70206006)(70586007)(47076005)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 01:17:32.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad405e9-5ae2-43d1-aa10-08da97813b2d
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.159];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0020.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4130
X-Spam-Status: Yes, score=6.2 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5049]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
