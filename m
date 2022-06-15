Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7C54D40C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 23:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349884AbiFOV7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349828AbiFOV7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:59:40 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01hn2225.outbound.protection.outlook.com [52.100.5.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDAB54BD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 14:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrpuU0DGy+9TZMc1JVi8omG8nXMQSMyzWlw38LCynlHx5XY++HV14iR+qrHBYEZF9mev9llGQaZPF3ybWT1AkTDhXURUrkw3Rb5xECsaPQrZRkyPOoIKqVtmgiMV76Vox+hGAzTPM4jmsiYHnLaoQG0OT0z+hxKCyEjbROBS5cZsmbnChpEo+lJdFUaTWgAUP7cDW/mev40VE0oblXow+qxwBrUH2CU+ehMpUs5FeYXZBW13PGk4qsNPdcNx6y0NNkqOLBsnD8ZOla9N2sH4sJbI/x0axvv/b1HhpTGJ1DNs73Db7Byx4sSKv6mbv+oPwguAKGg6qsa2nBHjkv7fFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=BKDZqkaAt52ONW0BCGf2GUjy1ipV2uSTC48krX6Xq7e+ihMuAiQJXAFy7Bl1KiDm5t7s2y2q4x8cozSIEOo8KEltGTjFLPvWICLPJRzuty0xYCZJfi8lXoO4goLEOO5ounSGzQmZgZsVv4zf5oHs5cZW2OAwEHjzYrmWCKo7zR11ndlXzarV8MH5JLFoKKDPFVgNBbWslAYxjPwJ5re68A4PJ3fuxBJ9h44IDhMr706Wmek34vfER0vU+kgaSrIDlNvYFeF1QVsRua+kq/1bBwqrTTfFe/UBJVjDwJKXcYzKEf9cs0Cx4JYZLwLJEZbtMi5ggpvwVEV0DdXu0gLCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 91.151.71.70) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=solairedirect.co.za; dmarc=none action=none
 header.from=solairedirect.co.za; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solairdirect.onmicrosoft.com; s=selector1-solairdirect-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=H1To2M3lUeyp7deLJqzwzf3GFFLDv8uytNyVPOmfWN40DVYWbJykFSojXSV6el7wI0E6y2VUFdvufSq0L4S4BPVgYMZsmY+4s5D+euu60Iwn199LGDg0BOzW1uOkGX3GJNgtFHhD0h7B/9/MPpzKTTygSq49Ly/pEj/3gRn0ku8=
Received: from DB6PR0601CA0009.eurprd06.prod.outlook.com (2603:10a6:4:7b::19)
 by VI1PR0601MB2543.eurprd06.prod.outlook.com (2603:10a6:800:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 21:59:37 +0000
Received: from DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::46) by DB6PR0601CA0009.outlook.office365.com
 (2603:10a6:4:7b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 21:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 91.151.71.70) smtp.mailfrom=solairedirect.co.za; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=solairedirect.co.za;
Received-SPF: PermError (protection.outlook.com: domain of solairedirect.co.za
 used an invalid SPF mechanism)
Received: from SDSV152-VM.solairedirect.lan (91.151.71.70) by
 DB5EUR01FT086.mail.protection.outlook.com (10.152.5.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 21:59:36 +0000
Received: from [206.72.197.122] ([206.72.197.122] unverified) by SDSV152-VM.solairedirect.lan with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 16 Jun 2022 00:00:12 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi
To:     linux-fsdevel@vger.kernel.org
From:   "Emerald Johansson" <marketing@solairedirect.co.za>
Date:   Wed, 15 Jun 2022 17:59:34 -0400
Reply-To: emjo680@gmail.com
Message-ID: <SDSV152-VMzxxQLj9Kx00047014@SDSV152-VM.solairedirect.lan>
X-OriginalArrivalTime: 15 Jun 2022 22:00:12.0354 (UTC) FILETIME=[49630220:01D88103]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb67c95-00b3-428f-bc6f-08da4f1a569b
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2543:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0601MB25439143F241D89DC69D2C8EEBAD9@VI1PR0601MB2543.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JHCpFA75ALIvmhXUmEHLZX+DgUQqL5H9V9+qjYoyfInpsSvxXjJiDmXMs+?=
 =?iso-8859-1?Q?guRyM8D2bfYFmfdt3t1hXRk4YGml8OUCs62ol63RtGX30FhnRqNoJD44YR?=
 =?iso-8859-1?Q?FuuxOkSdeeFMO9C+Hq7rMRMSelblarsD/BbBAdLabB5+ZJR6yFUK8cCMUa?=
 =?iso-8859-1?Q?8JkO5HZkcYB9NrtXF+s5dLPLqtz8bd/pxcTMQjlvIWEBzlTWFwlunKEsEz?=
 =?iso-8859-1?Q?65UJ7gfa80HfmZrbEg0nkDcrMQnFHdSx8atMKc2YV3FgNxwMYQd11mL0IM?=
 =?iso-8859-1?Q?EF4T+qjJoprCDTDYqyNWrsrO5VDuyRrygUthTNr7KgAjDSa9t80CVZYRyC?=
 =?iso-8859-1?Q?d5fR/SLZVh/egqtyFkJHC4s28G13KhNd7x+YPXfwZRupqRjyhrF7Y6L1lz?=
 =?iso-8859-1?Q?U8idjQMLlp0nhcfuWH+xm50tLXmUdxVoQBw5SoVG1iiClU+54dFjiTvDK+?=
 =?iso-8859-1?Q?GBqd415IEdYZmmFTTx8NA2t+Ofn0DtOErgfoEsEliJhoZQaXn4mUfUjbcB?=
 =?iso-8859-1?Q?UYZv9g3/iMWX8tDCpFJba+XzPP4EXrJ+hcj0mxUAeUXokqlb0wp171hKFA?=
 =?iso-8859-1?Q?jifamGqLc1/dP97Ukx/mkNsd1hOY6shhjzNtcL2QWecV2v3Y+1ftZvwO9d?=
 =?iso-8859-1?Q?VIKPbD1k87RILpdnZmBvqKP0sJ1/DQMJ14knopwU+7x0Y2QgPmgmYoY0dj?=
 =?iso-8859-1?Q?Be2VETjaet5Iv8MMvtIyr4JvyfH5mS0Imy4KBzgIwPA3hCmxGRZxMaE5xR?=
 =?iso-8859-1?Q?3nKo9ZvqqoVhcUq0TefGbvJgd050myUx3zKuo7WSDx9Dtvo3yyAqzrMsBa?=
 =?iso-8859-1?Q?GUo3Anq8DVj0CF2R2YaijH09K0w6fVjv8tXVE5M3uHfk+Et7qEGCY19S+F?=
 =?iso-8859-1?Q?MM8v1ImDp2V5cnilotNMrun04toRy5/n9EcWDYxWNueljcf5xyLxmW5p3u?=
 =?iso-8859-1?Q?EXfnYPp3pyZOX/Rc0opaxijaJs/nghDwRsSyVM9GneBLk3ELkHzyd08Gtm?=
 =?iso-8859-1?Q?Y0sg5tUUUeEJlJpEXxgfFiZ4tHixmrYGzucxUEKWyUQbIVlCrsWMMW1SQh?=
 =?iso-8859-1?Q?mn8BPgahFbM5hRfAYFYxuow=3D?=
X-Forefront-Antispam-Report: CIP:91.151.71.70;CTRY:FR;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:SDSV152-VM.solairedirect.lan;PTR:undef-71-70.c-si.fr;CAT:OSPM;SFS:(13230016)(396003)(136003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(40460700003)(3480700007)(47076005)(5660300002)(40480700001)(7116003)(4744005)(6666004)(336012)(41300700001)(70206006)(26005)(86362001)(81166007)(70586007)(2860700004)(2906002)(316002)(9686003)(186003)(36860700001)(356005)(8936002)(82310400005)(6916009)(8676002)(508600001)(956004)(16900700008);DIR:OUT;SFP:1501;
X-OriginatorOrg: solairedirect.co.za
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:59:36.6043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb67c95-00b3-428f-bc6f-08da4f1a569b
X-MS-Exchange-CrossTenant-Id: 1c138fa9-0b91-4473-baea-5be5feac0f7e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1c138fa9-0b91-4473-baea-5be5feac0f7e;Ip=[91.151.71.70];Helo=[SDSV152-VM.solairedirect.lan]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2543
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I hope that you are at your best and doing well. The purpose of this letter=
 is seeking for a pen pal like friendship and I'd love to and be honored to=
 be friends with you if you do not mind.. If the Idea sounds OK with you, j=
ust say yes and we can take it on from there. I look forward to hear hearin=
g from you.. My name is Emerald From Sweden 36 years , this will mean a lot=
 to me to hear back from you.

Warm Regards.

Emerald
