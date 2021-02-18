Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A744031E3D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 02:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBRBXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 20:23:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBRBXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613611386; x=1645147386;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6Ma7ww7lDdQTft6q54le2fjym4AY/tkNG75UirmHPoM=;
  b=qgnfS7Y+29upIBXHLrWDA/yWMuCfF88bS5P8rK/RyznHzyvbgemu+pB2
   9NuXdPSAQKp3KyQyFO5WWhvh/GAsO+dLoN4wpKrrSOcYbrMDlOrvdnqHo
   oCACMcLHETEAWvFpn0KLosnTJBEBP7+iy4V05zqSK3xjEwuiToWgmLZKM
   7fF4HJcREvtXXDoE5Zu/4dzga08QQddyFYqmux8fOSfwT53GUnfUmQscY
   mXg5YznbMb0enEpbC4sjLpQMOTblMQg91CCqRy/KwwZFj5SqY17iU/FCT
   nskdrrqpKb+H8qsC2TkdCOQHvaNqZX9BvluXrig/73HmUGmjFfxq6TuKR
   A==;
IronPort-SDR: rOZY7QT62shLuzo8a5NXpWwBdwIGITZEhTtelYH/+X4t6RyBayYAYmVogVNIV82pMnLC4Zw/jr
 hkBGur7PCFo2WlfK1PVVmQTYgd5p0EbULWN1ZZNRZZ7Gb0yV8BCHHiXw1lNf8BuUdzqsGolZtf
 PJZ4BTtwuyLDnY1BQ1VmmRfs894uEOnhfrln2HQUVpXnzX6cIHyyQ0JUOQHU7Q1yelqOsGvho4
 lli2CqpYfFa5zrY80e8ubTMqFXt+A4aTJrNvcwrY3K8LClVOEykdhYKan7kQ3mIJe/PO4djIyE
 swc=
X-IronPort-AV: E=Sophos;i="5.81,185,1610380800"; 
   d="scan'208";a="160234878"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 09:21:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z58PPC45B8G5kPEt7JBvRg/KC6a6HKRJNYruJVYZzqYC621BcYiYNadymIW8A904mrVc2jv3UAgmuDoqepX7F+jq63Wl1OeaaTxTsv3Bbcwvp/FotkkhudzD4mGfZYmy0Qrrt9ROpTsmxEqFHjj8NpLM3Yw/nY0d7tRjFPEJ+wAGEnANYYlq5sm4iULR2nq9684MbOMzkiogW7J8t3rbEnGOScnBiKO4bVSUO+KzYPP68Y1o9PTFS3oJXazUDs9H4y2h/1TuicafFB20V+QuAMk7ORtq4rABeW4PZpwpoe+HifTiLSNKd8iwg3u5xuoBMe/eAmOxEQ3jSZ62vj8bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ma7ww7lDdQTft6q54le2fjym4AY/tkNG75UirmHPoM=;
 b=d8MTr4ZKFsmBfUeOCJJVFVNEymEatKfzxPe8vMqRnZDYBgNFkF4ylYaG0DfsW1EUSeBMTtsp35Vrb5FISyDbdN/3QrgwpEXPAqyv21Pd4rjjBOLbBsCciddAesGG3WattPbe/oIbtQvedzvkQN02ZLrCJGvCcVue9CaIMhny9G7gfx8z4Gj13aJ3vYLDygOm+ljEspyeQxGc5ZuIDcJaHx3jlP/GyCQCUCr8AWdGFCkRRSkcfui/yeVOC0s+K4ehi5BzP/WN8ZyCPaJpi++aGF3RA4fukCChRtm5LdjVrXyJPoR0MieMRUVGIwgopQFIstFy016RSzSh2tm+xjYkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ma7ww7lDdQTft6q54le2fjym4AY/tkNG75UirmHPoM=;
 b=Pklz3Nyv33Y9e+OIAtBOD/0UB+jrax7+w6keFECju74nSSLvjI7Jxmx1LWthe976BSTILcusjv5iQSX+LLhs6vO8kK+yWuc99brksm0ctZ7MnKQgfA+VHanKOq2EG9Ry19pAnNoUuo1JSix3Ov9aGX2vPSv+zz7HMrEeU+flcKI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7678.namprd04.prod.outlook.com (2603:10b6:a03:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 01:21:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 01:21:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hyeongseok Kim <hyeongseok@gmail.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] exfat: add support ioctl and FITRIM function
Thread-Topic: [PATCH v3 1/1] exfat: add support ioctl and FITRIM function
Thread-Index: AQHXBPM4HuAgvKXtPEOUTz1mKXs2jw==
Date:   Thu, 18 Feb 2021 01:21:57 +0000
Message-ID: <BYAPR04MB4965A9B5B0C4998E57864F4386859@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210217060305.190898-1-hyeongseok@gmail.com>
 <20210217060305.190898-2-hyeongseok@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f67ace8e-8c5c-4744-49de-08d8d3ab9599
x-ms-traffictypediagnostic: SJ0PR04MB7678:
x-microsoft-antispam-prvs: <SJ0PR04MB7678B389B4973567009F232B86859@SJ0PR04MB7678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44Q4F2W1YJ4KLScEiRRnaI+pDsYUsg2FS7lqInYou77ITxr6hqn6h97kjnBQHqVHc7eFAMFlDLZEMEinLU3AQaqFMSVvlKMxXZxW1eTuKPDDilnuDKD2/nV3LuGRPNT/4btY06vQve1o/DE2tb0fFLH03bIU0cFEdwV1wkLNBgWqQTwCESfYu1qaLH0P7gwtjjmI5yG1i+21ddYpPpHjks6y3LoxSIzQGiAPlAB8WvwqPEfooyDF5sIJWflEaBsThbfz7i5M7uaj5SJIYshfTEHnpc5gmfdmGurH53eMxe41gkYK9Cr6Ga43HxtxDZ3KQtyekhsBQPeh+Ql9UFAlYPxCapBfeM1xPNbwsSosgLUyxoPleeSXek9ZKM/m4aPhxlrY79yC7k4YpBgFqnM4hw7sDCKLoUBpo6raWgOSLJ8ndTdtHxiX38vefjXZD+MolL5JIRLbCqtJx9XLNwnPru0zmMeUo5CiwMekEHcraORHMX6dhe95a0PoAHH/Gr9irJENPBIAv3LtgB+YTSKw+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(55016002)(54906003)(110136005)(86362001)(33656002)(9686003)(478600001)(316002)(26005)(83380400001)(53546011)(4326008)(7696005)(186003)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(8936002)(558084003)(76116006)(2906002)(52536014)(5660300002)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IxxvGQqHj3lqlGQzFDpPGmLEo9uLiwoiPN6IRt47n4r3ozO+ZOzQzDIUXqX/?=
 =?us-ascii?Q?KUF2LHHjyz1Xouga05UUKhxZsK/dS57cACkPdUDtnZV0iJYtico1rlSJm4H6?=
 =?us-ascii?Q?GrY+z5hW4nxZ/X/Kz67sy2HedJrqYfj8bAHoj0ZmjvYcUoDEU3vt7/OUjIy4?=
 =?us-ascii?Q?iZ4QHZZhVLP5rYKg6+NfU7+OLPrYeZ1VTqaG8bei85BQ6yOaR/eOwL8/cDlp?=
 =?us-ascii?Q?PA+aG8FuLnQMdlHfNmcH0AarkjJcojuNjxbaK6MpWf9v6E/EnVFn0Rrg7pIC?=
 =?us-ascii?Q?zXEUfaTBymevpW5dSQRC4bHjNcrLj/SFE5ehCGttnBZXx0ImuMDW301FNMDr?=
 =?us-ascii?Q?3SzEbMOElCCgx6ZHYmryu6h2jjLUrOmdNdSD/nPHBN5nU6K4/A6EkE5d/SPK?=
 =?us-ascii?Q?x6R+MblSg3ToQhzRSuYnCniYi8+qLKJjK9M3ukpkO+eSoSIqWce3EtZCjVv9?=
 =?us-ascii?Q?GK4zNBhoAS2K07/7ep8V4gaLHedxEF1ZVL0eUTxDzENfXmte63CvyRR6iBJS?=
 =?us-ascii?Q?PJeou/EMYLFUgaHWC1+xoe5LZiXcedk41uwtn6n8XI8nJPe5D3lhyPQ2Yjne?=
 =?us-ascii?Q?+xk2P86g5rGKN6Pi0WPXqbbZeeIOh3xZ1XiupDjifFbwm7oPP/reqwzEVziQ?=
 =?us-ascii?Q?13kR1yNdycCySB9Q3VZqH3I8iL+WZDoo8SRPVqYh46YfDilPuFCtAKE77t8O?=
 =?us-ascii?Q?CtrwwE/fpydeuk8/Q0Q2BViiOVsoOEsfJze/ITwx2udT2mfDooJW++YDiV8C?=
 =?us-ascii?Q?JDoh11igWYO3GbV5WJ1NNI7ATDL9zcL+Ne5JT3ZT/iFSD4USS5ep7FNo7o+i?=
 =?us-ascii?Q?vnwB+ScKEPKCeyiHQkX/iP3hKvKAPFh6+nLi5RNJOWmSzBh2RBAg3el/+cbL?=
 =?us-ascii?Q?hqGdnIqiGXeA132jLIwGRbkMUbugg5Fg6TBOrSJzjmTJRxLiU+s+KCk39zTE?=
 =?us-ascii?Q?rBIl68U3lrbGAWzAMic+9ioWXdhT6euhASQ17ZZSjPehp1BDjwKrAI0dsGHQ?=
 =?us-ascii?Q?cPkQ8wRGkY54H03cOsZ0BljRs9NRWE+AXz9B52584zcx+QN0rTb5Fi7/BzKm?=
 =?us-ascii?Q?EfguWnIRx2iRsXUu5UxgEq8k7eksIbAVxsBd6UvKNsLKRIKG1i07hOKWeA+n?=
 =?us-ascii?Q?x6tvjtZwQD0NCREdrm+ap5jKJbWpGBS75y0VtLBVuZsOMuWtdsylfZ6oT3LJ?=
 =?us-ascii?Q?mRgEjON2cKSmJqhq0FwM1ftsr2MKwZlpbqD2EZPSJFtCZjmxIXDmFB4hKTAn?=
 =?us-ascii?Q?CZasujL2GW8MTDyTVw66jPIPZ21BjI228ikTduoOyTg6qHm3UD0QAaHBO9lh?=
 =?us-ascii?Q?7xIdIdVPgdZXRgcKyfwJD3Kx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67ace8e-8c5c-4744-49de-08d8d3ab9599
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 01:21:57.4625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2l4GyNVPVcemngOM/0rJ6XQCYNI8FM7znwaEqTmiCH5AJ9OnvEOZU7P3w4KB2ZFvvKEpW2eiENo1ej6vJ2Xft1HxnWEKrZK60Jbwj18/io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7678
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/21 22:07, Hyeongseok Kim wrote:=0A=
> Add FITRIM ioctl to enable discarding unused blocks while mounted.=0A=
> As current exFAT doesn't have generic ioctl handler, add empty ioctl=0A=
> function first, and add FITRIM handler.=0A=
>=0A=
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
