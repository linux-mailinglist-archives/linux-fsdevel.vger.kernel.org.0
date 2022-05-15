Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51752FEC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344472AbiEUSVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiEUSVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 14:21:08 -0400
X-Greylist: delayed 892 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 May 2022 11:20:55 PDT
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02hn2208.outbound.protection.partner.outlook.cn [139.219.17.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB3396BF;
        Sat, 21 May 2022 11:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsWSdy6D4S8GM6amHVFAdJw9mKOpuT2UoJ4ivYo27P3sdS9SFLwUBBLqug3qM1EHYBiFWJcYFF2COtPH1OU8JHbcIJ5gcmuNOofCzmKkA6slpapo0GHlUD8PMju5b1ilgE71lii6iWF3d9ztHggoO/xBHKABwHW+Y5Gga8L/SHaTe//Umz3LHxCQoQaE8B/Y6JyVgvsY8XXPzTG3gHyAtyDP4zRTBv2nbDfyqVlbAfoRPSruwxu8aYh6mBEo4LdZhKHFIWmR+kG6Wk2iFRFSwTlbdzwvpphMH058AvLXdCXTuE/WoRQHg3rrrEkGRbTGlGicl7Ti7DRcTNDQUVY26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=My4foqrXfrAl19jpW+u9jyOoGbO2lAmKp973MLgPFy0tsr5f3c5G/Vl0W4wXYz3+Nj7jOJiPuX9clnJN53OkOdq/Uuuli+KDKKiqpcbUNga7q0Zclt39xENQpyteD8PjuYybrd9wRWjXN0YovCDNCdiNqkjSHnZVBl3ZrPSejl8kcnOr848pucPCk54SZLZ8goUO94IBfI7R1D3OWsEx7jY08g7JgrULo1qJIxH1R7MU7I5SBXDFSdSZh5dRWQOs7eA5yT1nnRx5bK6nnA+3KlytRqI7jklKJ0aV+FWrL3jKXSZNw0a8UcES5nrw+H/JGnDaEIgr/5jHAP+CGXO3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=HXwhDdnvOnuZZJVIVLD3rDu66HZfftCUpLJzsDkLNdkFTdTdF75DGmIn1GYcWMtZuKvU6OXuzW/0ij1ttGHlLKL3bkMzDig57EAujcX1c3VA84xlSn+lsB6SQtoTCfge3ydIEwtJc2ReXLdsQKCQJm8t6przEhwStMNsTXxSEkkN9aYUUThYH3tPJ9fU5zZSaOXIErvCiSUepGqm2dsNJ9cL1001rMpO6xRiAGqLArKQiTqrlAXwRR0BOdONidLRfz6GX2DbpbCbgfmZg/2fzIs+ncEVKz8Mweo1QX49mex5zHWIzrDbP/XsyUhb+q5DnX42KDDSwluHI1VNqYJt5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85) by
 SH0PR01MB0635.CHNPR01.prod.partner.outlook.cn (10.43.108.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Sat, 21 May 2022 18:05:52 +0000
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85])
 by SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85]) with mapi
 id 15.20.5273.019; Sat, 21 May 2022 18:05:52 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE..
To:     Recipients <tianjiao.yang@gientech.com>
From:   "J Wu" <tianjiao.yang@gientech.com>
Date:   Sun, 15 May 2022 12:39:13 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: SH2PR01CA041.CHNPR01.prod.partner.outlook.cn (10.41.247.51)
 To SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85)
Message-ID: <SH0PR01MB072995B7B6AC48105074341C8ACC9@SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d75fa357-05a8-4735-2198-08da366ff740
X-MS-TrafficTypeDiagnostic: SH0PR01MB0635:EE_
X-Microsoft-Antispam-PRVS: <SH0PR01MB0635CD83B887562D842E4DFA8AD29@SH0PR01MB0635.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZzJFkOvAwcLFTLVSEkR0xJnaLO+P7yosUoDsxdsMK6uiODsOKb6bYnCirV?=
 =?iso-8859-1?Q?2ADK/DAx9p4bobvP+4dXv7sGjdznUR/Daht90eRbojLmL9ASzk+qCJWfq0?=
 =?iso-8859-1?Q?Hmui6V9aIK67vU8EEVH7kZTigndE0L7MYuLwJRZnT+wifHL7VSru8/jJ1c?=
 =?iso-8859-1?Q?/rQ8z236sBFu9u3zuIcE9o0NncK88NWBY2SeGGuo5Sb1mEwC4YR21YTYXS?=
 =?iso-8859-1?Q?V8bCaHPcHK/o3Bz4M/AdJ0Ujll1UIV83TvmRRHPeZ5ljPBEqvIofTbK8Gb?=
 =?iso-8859-1?Q?Jt7fLP8UjYE6YarISWor/+3sd9MmoaAad8ypfSfU3jp+udzXEyo54wGQK4?=
 =?iso-8859-1?Q?v0n+JKXXIrUOExZP8117MQzx+LwgbDPMcllQ819vQk5DIBohOjdcRCcNbf?=
 =?iso-8859-1?Q?WQQgayiu6zHYY8aCKINPy5HvFZFsq0DEXHhDs4Nssuno3ZnKTr4FuPp4O3?=
 =?iso-8859-1?Q?BcX9PSwxTXbqW1DBnqZov6YyW1pqXlF75f6erVVUfDe0hBDU7JgrEBuE7r?=
 =?iso-8859-1?Q?niunrm78KbDqeH8J55tJdtffMqmSSBiEfJZEI/u2tTA1J7V4cO6JZ3qZcM?=
 =?iso-8859-1?Q?44/YEmYQ/vH7+ewnAS5Qs2BChYYOPfoYtrNXUYdFkOTy3VdHxQabQvVssH?=
 =?iso-8859-1?Q?5pXVLywL3UkPm2aLj+yMHr1DoXh8/vvcDMuJZdsEVvZDZPsW+t0Tmavnho?=
 =?iso-8859-1?Q?PpgDBDIKzufv4lIzQvOkcfwINK5lUI/B1LLEySeo3dgHkeDlRvgBC2MU/R?=
 =?iso-8859-1?Q?e33MkFCSm7kyTD7KxCM9REdFW6ycPYrtaX7QvGoSvmliplXKYuSa68dtUS?=
 =?iso-8859-1?Q?CIM5mG/KaQymnIGUpTu5gWFsYyCwNdtfLTJXFGW4BaxdjeYkzeMRZOLWsv?=
 =?iso-8859-1?Q?P0oIBmtwurAW9vLNjXUUOhpXM/hNJj5NsgDqCiWT8iNxArwEHEUrZGLWJX?=
 =?iso-8859-1?Q?COXla6cdVZ8JI8AER71PJUXn94CvAlGAl3i9gUxoLTv1NiQJgs8jfiMiMz?=
 =?iso-8859-1?Q?mCntKmG6aKuWT8zQPgn2uRnm+58sszWAx+tm2zfGFbqQv40ICb/lWEZ0UO?=
 =?iso-8859-1?Q?Ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(7696005)(9686003)(4270600006)(26005)(3480700007)(52116002)(38350700002)(38100700002)(2906002)(7366002)(7406005)(33656002)(6200100001)(7416002)(40180700001)(8936002)(19618925003)(55016003)(558084003)(86362001)(40160700002)(6862004)(8676002)(66476007)(66556008)(7116003)(508600001)(6666004)(66946007)(186003)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AEI14rdRvhy3W9Pt+DPUgAhYOAUuOdl0WrmfsIBJsRFocufYuCpX1I3xR/?=
 =?iso-8859-1?Q?mBLa4HgRiLMxxHX0yiZeWYQnigm8rGTFucXDKPH/CURLUzTTzKREhaw/lD?=
 =?iso-8859-1?Q?I0ktjiS8fcnA7fNKQYmjE0cgr5fKyMdpVUUAhhkLnwW8BlOmeA+diHQ+vC?=
 =?iso-8859-1?Q?E0CfYb+KWlpwqmMYTs77shJeO2pmnONEzoMUCTLZIHbyC8cRXq5O1LRqnQ?=
 =?iso-8859-1?Q?NTbNGweZbvwFY01orXMc6GW10DOEgDNv/2w/ueDXcRJ7znYd93NPw7bIsJ?=
 =?iso-8859-1?Q?odS2L/EyG3o/fZ+4LFcy9LyE2Hom1/FlJjScRbCTTIk6ezkydpw2/r1sRt?=
 =?iso-8859-1?Q?/68R1/s2UQndECajk2kv+Ldy11N1lrqEc3y4/1cnqIkiCUKhTGvNjS+6er?=
 =?iso-8859-1?Q?5bHomIEPpv6hXmXq2MJygVqPiE5yZwQ5E94wrqgFNVSXxnVFAQClVWvFwS?=
 =?iso-8859-1?Q?fJb/tKjo3zuEU1ZbHeEespRdg4wg8igfMEfTWrT3GyEavX7FBMdJNxttad?=
 =?iso-8859-1?Q?1WPcm4h/xFKZOxKGqDtfkNUGXF25w9Gp5jWx8pqooAnwwUyHRHZKizDepr?=
 =?iso-8859-1?Q?b0s9SudjoSAv74jrh12S+VINaLKJ3N6jSRU6SkwpVqqWmD4mvelYfoPpre?=
 =?iso-8859-1?Q?Zf43M7wrdOgZqndpXYTEHTLDA22gyyuqwfI+JMf5BA/PtpzwXPbvBtJKiS?=
 =?iso-8859-1?Q?rtPYO8D78k+ARtTl20IokQy9/3FIV21F5fwn8Hqn1w2Lr7wXNNRttopmyA?=
 =?iso-8859-1?Q?VNkrHosUZoEx36EghQXct6D3dksKk1t/xYaxw5ckXt1b0YB932VZqiaa1h?=
 =?iso-8859-1?Q?w/7eJaEII0qoCw1DOSsut70z1wN+LJSzZ5P+KCMcCbbPexYP8hhjbRUpC2?=
 =?iso-8859-1?Q?7AsSbQiEUtRxfJD9RLnJeQ181PBCs/SIUl/NEjbx/H7ok1xMpYk6nlQGnC?=
 =?iso-8859-1?Q?acv2kiGbiNvXgc224Pb8Z3pjA+AjraPaFhfC0B32i+7hVrrOiXrVGaiiFN?=
 =?iso-8859-1?Q?UomexBTUSrfCuI8yAd0zh2Y72rf+V8DyeyW7+H748efvGcX0ZIscw2dmDd?=
 =?iso-8859-1?Q?ork6/YJo+vjPp0WPwHpQRtZw0fY3a5mbFdewHzWhhgEuxGavmIjKea4uZY?=
 =?iso-8859-1?Q?ypgsrX5tVpLmrUeCN5jwpPrp7FZBsIMPFW+JIIeixdfiZn2nHVNYS/sJyk?=
 =?iso-8859-1?Q?+C6luw0/IB7qdhhrPtyT7/BwqaB6ZqB5i+6aYvTveo/972T43swrFZpkIZ?=
 =?iso-8859-1?Q?geAxbCcfEECO3VbLPT8h4/HLA06JfTDmSZ5cgMuoq6dCONY0Hhv6jtZuWM?=
 =?iso-8859-1?Q?7KnINGjXVIU5i7j9dnpriHTitfUzLHvNzkV3ioKVVvCwyOtc+Yt4SR4XGa?=
 =?iso-8859-1?Q?N7tWYjshV/YIsU9myiOZYSo5bR2dWajK0v3pQmGMYTP3uLSyMZamIZlXK2?=
 =?iso-8859-1?Q?F7a4TzsWWi++cxRhjUEqF78q6T7ofbg1ljF8uJYBKNaPgB3Ch3v11Jliry?=
 =?iso-8859-1?Q?wL6OxYl31Z+f0sYnD1RTsSxVN5uR3kXdJZR2UurFpWWflRzy5S2QGHuSYc?=
 =?iso-8859-1?Q?I4yaeJdNCqrt8SDtv/rWOHOgpSjR3OBa66zayI0riHpNe+jlhMOqY7Q0Qx?=
 =?iso-8859-1?Q?he0E0X8u9SHn0CHLkUiZF2M+HBqVLAVzc8BKqHF9oYj43HBjO0RO9rQywB?=
 =?iso-8859-1?Q?f2/beO+ZEAIQFTa+bA0LllBnkqgIl8Bj4Y6tJMkV8q5M6rz+ajQ8MRj85w?=
 =?iso-8859-1?Q?OZwS2eMO3TdA2cB9/V10G6WDw=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75fa357-05a8-4735-2198-08da366ff740
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 12:39:34.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqrsEwP8JcnBdvDFdyKNPJ7p+R5UHpVs5nuiGtpT4Vw6GKhuyRZEeDiB+ToT6+zsmH7LRAHDk8IEFftkn4UgoHKgp2YtFFFFD0i53mRy1/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0635
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_96_XX,
        DKIM_INVALID,DKIM_SIGNED,NIXSPAM_IXHASH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4953]
        *  3.0 NIXSPAM_IXHASH http://www.nixspam.org/
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  3.4 DATE_IN_PAST_96_XX Date: is 96 hours or more before Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can we do this together
