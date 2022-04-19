Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF32506853
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbiDSKJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350473AbiDSKJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:09:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE625295
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650362821; x=1681898821;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=LnTHESvP99ghBq2u2XvQwLCzjrBw/Ch6qO3wzun0uApPXXg67LmItu3l
   LGgXuI2MRVCCJf6KadKqtRwaLhk47ZhsCOJtXye6SrtfywMvZuiFmopgx
   JhC2f2LPIQ3gfwmjaxt24+hPfAFeRfRNByDyEgk3TK54nJu0z5ICcHst9
   GR4eqFLqMRKzg0ri/6Ax7wbnaYEk3RMUQtZ15VcP068K+p2lWxnoIYmhI
   xywdGqvx708yDcSSng3r7gi4Ak9V0f6WZ3ERWc/z1Kr37VBSuXMfdUgCZ
   Kj/pKLJqS4CIY1LOulaGoxGm5lVGiSuWYIrWacgxMbpUnSPTswz34Po/U
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="199147549"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 18:07:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW6LDUgMx847nyR9k99j2ad/xbEkJjo4NIgsO/oCbEXX+AKiuXDhw3adYMxMq3jUCe1x1+Evwps/zEPFOYvk7pUGxuXi1yp5kNhaf8zpTDQ77n8QrpEuYUxAkED7siRTgox13rdp2iiaFnVFbasnVPANvnAHOoP3jkXioXhMVMYe4Ujb08qcJApr6LbhCozrKHC9ACCu2YpJgwAFnERv5oDBrfGV+h9Hr2sNGwDn2N5xjXOx86Gq8Rk+E3nT31AdGjkonlT1stUUBdeFqvOQrroYJ629LRuVhcalVq+Tjcaaa3DWXlBIkYMYQkx5trFa9FiWGdhRtWrY0GJSXp/0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=doJraF1sCT1NeMpoWbh81juJhK5CkIYSNcHURZak3Qm/kP+mp/IhykepiC+9uPl+ZsDZBFvKp70hg8O23jCmpDXoQ2sr1QSorB4T18z65X5e6NeQPaGN1loExAWMuWFeYj2qLqG3KOC4jqFbbx/lr06hlkUUpnOiukO7/TFUNMJvRhsaGgENZSeeD+tp66018gNQAip4TYCjlYNMQmAvsQMd+RJrCJWKh7ICh5zJ391cEO+zyI6zR7SCeAmZP2iYgFyZ3oI4pb5RpqZJ+VD4fbAc2vC88BVBgB3AMzdRs7gGcSl/D7/MSIPsxqT/kR7oWEMNJlrpuwnuxWxOrl6oPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=au8kr1itn0WuarDiBYh694NSwSnTvKSQAdEfqS/sGhr1lPSzbIoMfYVTVXArXAcXByc1FKB6zjPETaCiYkcxLouyPIJ++gKywMFX7XHxpHlqMBX+OpDddxuxwoKqFGLfj8V+GcEB7GSzNAXHJp6XkNvirg69TX+hTcy26OKNXes=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0294.namprd04.prod.outlook.com (2603:10b6:903:44::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 10:06:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 10:06:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/8] zonefs: Export open zone resource information through
 sysfs
Thread-Topic: [PATCH 5/8] zonefs: Export open zone resource information
 through sysfs
Thread-Index: AQHYUsFZ7Tr7uETxzUqWBD3CbQXknA==
Date:   Tue, 19 Apr 2022 10:06:58 +0000
Message-ID: <PH0PR04MB7416CA2986F8E38222984A019BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-6-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 910935b8-1d5d-4783-eadb-08da21ec5701
x-ms-traffictypediagnostic: CY4PR04MB0294:EE_
x-microsoft-antispam-prvs: <CY4PR04MB02946D14D1034C6CDBE162929BF29@CY4PR04MB0294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgTuUMLI/aOgiJ7wPL4w0HDfZ33q3/Z2rLvy+JOdgUSaSz+0YycN0y0hXn9bEsfBdYt9sG1UaLcmRrwX6OEBssQ4663gdzXFXTvkpF0AYxYSjzsSuDOP0RjWmhY1WDzcBknJ50CJ9qSS/JvyKdj3TEEwBqQ4P33bhhaLI45jc8aMYLIWBe7262SFIsySocZgUWd2GPSKlz5QWj88FokGQhVmAiPztp9RIbijEvGyxg8PNSWXq5cVD/fjv8VKaY9ZCd3BW7ey1OxEpVX2gMo0xWAq+MZylJsYzFZ+jO8CXC9CpQB79ZsuSGhrTkOvw1RgPoY/0ziIqI5zqO1aLpL0YW9oK2/gjGdx0QMTh9UR33fbrD5P1Dy/cNLYGPz1PbepV3Nu9BPgxnYYyoCXTfwiAu2N6eB9z55K7BbNh4f1nyTJV3c3p60L7RPMo7IwFgkYph9QyC/ffia9GZBVBwcDLE6kzA+mLRlEsi5UVpCTjmDbgqeT6CO8bhxfxKcg8vO/xZqRPwx/0/Kest5AfVOtDQ6TihtQjLa4u9t4QIs+6aS3pR2qlc/CmbhrZL7ZwclumRuKZIoitg2WYyqJhUmzqjnz/4eTXgK/8UHPLekYFoy/FEkBFVBpR5DsV1e6WhRt6cPI9lfP4buNEN9APjJnqHriKQo/oxDzLSWH4q9YJVvWQlA9wAoUTuuHmFLcqHMhAmKT10v1rFCQ78EXP2KMgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(33656002)(91956017)(52536014)(2906002)(66946007)(76116006)(9686003)(19618925003)(38070700005)(55016003)(558084003)(66556008)(66446008)(64756008)(86362001)(8676002)(6506007)(66476007)(5660300002)(7696005)(82960400001)(4270600006)(110136005)(186003)(316002)(122000001)(508600001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sisLvpEwX+aN885I8xohq+0eJJftTfNUhjLB6X0tF5jJl7lLIx+NJdop7zoJ?=
 =?us-ascii?Q?mI4j1HHRHsdPMr8jbztfakOIJw2WOauMwCXhjOF3jANAbQm414uKWJjfu8PX?=
 =?us-ascii?Q?SdWa+g1h80FP+RNDIIlJbkxkj8ytpWKpGB4lAzSYXr6FsLcFt4rW4qvueDE8?=
 =?us-ascii?Q?Owop4ASzKyfj020ydCul9IGJxyVELwsnEDvbgc4sWGXIuXeXQD0WkoOU4jlB?=
 =?us-ascii?Q?h2UTtmHPq79V+rPP2rljV1yyefrSq/ydoUDHFHMKQQSz95zLJnDdFapkThms?=
 =?us-ascii?Q?rKXsshYi8uYaRxam6gC5S2cvRyQug0dGMA8/He0af6ev/d4aQSd8SnnTF2IT?=
 =?us-ascii?Q?vDiBoPb0mWSTP8e6FPjrRwhem//hg2iQZhMYPMo0JEuSZYGkI65YhDuo9gsG?=
 =?us-ascii?Q?5RpRnmrLEg5NuJvn6HECrqFoj3q8OmDra4f/pyVIsSo81FWkxgePeo8FLudC?=
 =?us-ascii?Q?S7r2y0p5J49GAYIelD3Ab51+a3IAOoPw0of7uk+Nte1YbIu+J75sOOF5Kalw?=
 =?us-ascii?Q?0byyEOeU161LPpmkihzJQcYbsyK8tTWdX1TGn0Sc24XYBYSWVOAXe5ucmaUp?=
 =?us-ascii?Q?VNs1SHSK2Gktu1A4BN9CPaoOGTaExq31tV07mTzGtBDKMIln+3v3DPEZPxvf?=
 =?us-ascii?Q?fHuzY75OQJNhYXt2763kMjRCnRmpE6sK+n/wUAUDV6C7GrpzOycmk0YUHUoh?=
 =?us-ascii?Q?jUlgMButpt2ZGTM3ENK4YR2KaKzpT7enviG/lHVH6AXV8hBUjq683E54gFRB?=
 =?us-ascii?Q?51TayiWpJy+9MifgrARbDjLYsCNww+D14oDtq5YT1RZhyON7anxUXjz2fzId?=
 =?us-ascii?Q?gPgv1yMcYQQ51zF8nD0E4SNeIpKak7oF7po4YcLImuy7ovTuuhz+AQeOLLdV?=
 =?us-ascii?Q?qTLa45PXXuKxNOeHy7BoJ7chEdVS/tfsQC1m4lT30SduGC+syUF+nOYEuKFS?=
 =?us-ascii?Q?8iQDwTG448NlVEehOtNxAg5+5xzQJKf8KnAGUIhsfoaK52r4n5dIMmOxYA13?=
 =?us-ascii?Q?O65uak18BC/gHGCdV/r+YK0VZ+nz8U2uD/4QQSNfIEuDD9EuQDkm9BzIPSpT?=
 =?us-ascii?Q?SBq3JeYfnGugIpOP49Kgy/MkbaMvimgzxlUsqhol7inozmedMt19kNeaATlT?=
 =?us-ascii?Q?k2kguzljW6WTWS66GvTLfzJ7Mqwdp6XX1ziRrIFrrzxCrtCOG5ToCGCCfAna?=
 =?us-ascii?Q?d1JyPkozjyv1ZBL8GAWFeb6vyYh1U8x1ThiFITRSWallHPLHEtqb/6fpeiPN?=
 =?us-ascii?Q?DbZStRRAtOMP6u19rGOOQry3ceRRB5l9Gpjh/5cInF2ClZgmrOS4PXv6r34g?=
 =?us-ascii?Q?AxpftHs0UCyz4rMZUMVJL44ykRZfA+mLk0AhmHyPPMdS8nt6ZEjJ4tC6M3hi?=
 =?us-ascii?Q?8/DIdhhGCNWStjFx77CWirUfD2tdb3rq8yYiMTdyaNk5DpLUjDW1+lq9o2q8?=
 =?us-ascii?Q?kiv8m8v2iYm/Fqjqo9JgaNKI5Wuxlw04DRXUKf7cGeJ8fxtymSPpK/mhKzCB?=
 =?us-ascii?Q?K1vryAm6IsY61S1huLa7U/zNjg5rLotFqrj4ItiGWBCf7Q1txtO23Wnxc+uY?=
 =?us-ascii?Q?SK+CrlQNdayJYkLEHT1R/M4gQ6RpCk3FnhnmUB/J9MYLHJ+zd3nY9NS8aSd2?=
 =?us-ascii?Q?S97TazzgMFfUCsAfsNNqDjhc2hi+SbLH8+dN7TDcsVxsePs8eJy2DkyW5N81?=
 =?us-ascii?Q?kCaVVIePVHHuEaDwz+O5IAAmBYZM4kKb8qFLhUXJQAeorYlJeX/Csdt3f2+m?=
 =?us-ascii?Q?+DewXGyLVoJMUpVbxAqYPuL0ML6llRmeeYmujBjxCS5w5WZQ/pCF5aDuAX/A?=
x-ms-exchange-antispam-messagedata-1: CioT1VsD3WZTU/xR87f1y0XWzyX6a8VKiTk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910935b8-1d5d-4783-eadb-08da21ec5701
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:06:58.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXdw6UK7LraDqOVMSjG7sWfN0JRq5y91WhisX9STf6Bd6OG1FhNsgl5GOq3UBGIocwmWPndqX1Q1e0GZ/cQhEaGq1XADCb/9fpFGB8GjHak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0294
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
