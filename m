Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD53310441
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 05:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBEE6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 23:58:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44834 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhBEE6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 23:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612502121; x=1644038121;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/EKSy/0cjI+3beRrlNgrVAqqs/FQXrED/V2CbB64918=;
  b=MV9ptOL55tveELLe0G6ZzxASO774tiACtIPHxtUysBe3FU3jtGfJ/f0t
   m2tmdl0jPneDpzcMOkyYPvyiAG1ZncRyke2eXi9e+2S24ShdCIWyjhqBg
   CNAT2u3PvV4DhRJCHmQhBR7hSusmqgnr08mVkHQE5s6Lf+zRl9m0MANY6
   ZLhgM9SjpR+4zUgBwecKLycG2s7yDYNrpAhXkPV1fpuNkidrvtp3sUpHW
   cmDCBscbubF63HeVgeBynrlze3Nsi5mINpBHA7M+OdOAGlvG5kKGWxJEU
   QAIMkjwoYhtf7Dp2qjrNuRzziEIHt9MT3HyyDvJjMozFEJ+bqIxCqWezF
   A==;
IronPort-SDR: NLmCHBY0YDLWWnkeG4AwUwwZQSSBFAu8WTdMqE/Y7rCuMr92ueGN48eablC41ztqqKBPlwBa0q
 ZGl0fU9k40q1Lnz1K2bF3p0OHgfbOjXB+VGBP7IPCKo4KiLhMvsvYsJu1PRNus8FQmNWaB+xP/
 CAScmGJ5qypruWRsQPBCBnI9js0082QX0Y+T1ehB/ZtaJzr7Cu/tYhhaxxJlyGFK7V4RY2O0p2
 P1ycMrrg04jv8jtTWQ4wculMeMmdzpbFNSs/PLRVKyz0Qk/mqquuwdV1eKkutewGWMoShHwZk/
 wIY=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="263304798"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 13:13:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7yz+BaP60sh9zQCrCXhDZtQvnnMuK2bUh2r1gBzb3OcAhcuT5XRy7otoMEgWRlIKpon0YaoCWgqavg/MmXX3Bf4UT1hrJvKd+91onuff321bFf53r55k5oIHmUVYWxTLeL1l/IZtiHWCKf59OeYj3Lenso5XJzPNi59A1D11kNLdooHXAIVGiNMt8BdjGp2AiwdmIohlO8EYMziwzrMFoe335NaDmM5RiCKbl3+KcPq48zBdn7AlVog2XNxlziw1Mmhf3bN9c8vBiQwkTi9Pyve7vBgXkCFu3PcLPFh8VwplQc7OE7DiQM3j002+ZAHoyuooHa1GqrD62WJf02nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EKSy/0cjI+3beRrlNgrVAqqs/FQXrED/V2CbB64918=;
 b=lYMO5Uk5jm5fEbkEw85iEjiOT+ay5MWknLZ3ahIxiQtwh/eiQ60nzFJ7EJdX7xFrC8RkCzVqiTyUHzSuJ6Se951/D9lmefROHdEbQpREJpC/r1NvVvqDdfad8V8SoSGL7GrAp03wmRtOM0EV+N2xjsvp0v7T4QmQ+njq6eg1m8qZrzvUJrOKisqEKfwkdkwSxwPBEdwxGizi3KKGQApwXjVDJyNduf+xqWHW04SFRiSTYJuTKDExWdBwcsrnXd2/tz9mj960y70i/yjMOu7eyLfc5BNua53uGpYuoW77ieBGSGAFo6zhSq+RVmGXxkweR3ieZxRGyntAdlDoAwTCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EKSy/0cjI+3beRrlNgrVAqqs/FQXrED/V2CbB64918=;
 b=SFRBoTyJGmjf02rSbiFpbWf5fpNgnQcZPZUb5PHPVPdIY6fD5BWhX/aNEOy+037yLEABfbWzq2wrPOxiqZSmTIMNEA3yQgRO+yTyBxdJSrHv2mnGPqp+qcsOep+Nv4aZxzLisGDpqTmXRyworG5URO70lGiLjOxpYf8T5ELjDVE=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6283.namprd04.prod.outlook.com (2603:10b6:5:1ee::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17; Fri, 5 Feb 2021 04:57:08 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 04:57:08 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Amy Parker <enbyamy@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs/efs: Use correct brace styling for statements
Thread-Topic: [PATCH 1/3] fs/efs: Use correct brace styling for statements
Thread-Index: AQHW+3sb8esbC/s2RUmR1UQYt0mr1w==
Date:   Fri, 5 Feb 2021 04:57:08 +0000
Message-ID: <DM6PR04MB4972E287DED6DA5D4435986286B29@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210205045217.552927-1-enbyamy@gmail.com>
 <20210205045217.552927-2-enbyamy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c81e011-2e7c-4ca1-222d-08d8c9927de2
x-ms-traffictypediagnostic: DM6PR04MB6283:
x-microsoft-antispam-prvs: <DM6PR04MB62831A86D9BE499D5E877D5586B29@DM6PR04MB6283.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jb4eDorbXgbGdriVGH+RDnxlGywt6l0VXJbGdEQMuqbirY7VFPX3SjgI1oHiJTor4oHXAeZ7L2NV1kE3Ojol96wZeBla4ApcavfFeN3vK3HmBMByXLin6dEUvsjuITjGaMvBCg/1cc0MkTraIOIH8tuJ06HbpQUpeFbgDz0PgV9yT+g2CyrjtJtswlPH6hApnI0W9Omys1fmZso0788zsdg8UpC7ZpkUvRZ8igMQ/Nxq0TphCTJALXZudyWVckIIUUZ7kJi3Na0lfDkf3MXuAH6EgJHaOxJ4rqY55VoY/QtnYdHtpIRERXx13GZWIMuAA7rcxhC7bUeu3JXvl7PdgGSg1DnhykGJO+OrSiXVqVLZ4tklIpoIB7PjISh3BvOs6EWeIEpS8jvaQd5Ts/m7waCOgZLzziWSOa/fTUgxT90Wd9PD2wAOvXXgeE3mccmk3+iqKTUnVfcVXSHMERYfj6xlpE5iuDNxQlX/Mf8zDn0UzShGRghUSCRmfBFjoH7Pze2zSXMBIGd8lI3ncX4Cyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(52536014)(71200400001)(478600001)(86362001)(5660300002)(26005)(55016002)(83380400001)(6506007)(186003)(33656002)(53546011)(7696005)(4744005)(2906002)(8676002)(8936002)(66476007)(66446008)(64756008)(66556008)(316002)(66946007)(91956017)(110136005)(76116006)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AWDTMzmJE3Lh32Rq4bSLtHlqoIAiKKtI1nJJm2Exd/lIBcc7tuoNk2MaeqmY?=
 =?us-ascii?Q?2LnxVMa4jA+rZ4NLV86BrlEtHwQLCM2P85gvRQB+BdVm4dSCfyqIBrP7WB3M?=
 =?us-ascii?Q?PLwiAg+R9CWDC7OzKqtVhFbUoZHlwlXSZsZG4681WW4LMRQbYPSzktF4lRCc?=
 =?us-ascii?Q?TAzVy6qksEvL9DVFOl1grUgnAa6yjp/5dd5RHxw6Pzk8q2vmoCH6Xy6ywRe6?=
 =?us-ascii?Q?fGvPwAmI0RLfrEBl3L9HJuc7PdDMFBT/ofcigOqrt0X/aKpq0+w6RHqOMyaf?=
 =?us-ascii?Q?FT1ieMrRcd3+6vEJ8yquj5TCrI+XK6NqFOR7OSrVM/oEMFUuIT1iu7UfTZPN?=
 =?us-ascii?Q?Ld3PkNmBEezhJiLD362tA7OMvvjpMpvGYoyfb2JR4teulJMcKwaR0B7+/PUD?=
 =?us-ascii?Q?OSuzy8cmQSvu+h2aAUUcTrvcv0NGTb5C28pTp7OVdV2ecOmvI4M5NB5c7AMH?=
 =?us-ascii?Q?zRX8HKVj7Yb0sWHjSvfXtKUUCGRIEc8OgJ+mP4vgxfhg2rqDRJYq7I5jnFoR?=
 =?us-ascii?Q?znOvooQDSixpki5q+1tEp3SztaKV3haIFwW2Uawkz2BPsaj2IXTCwKxFzjU7?=
 =?us-ascii?Q?k+PDBI4Wl0d4c4RyyY5YUgZi4SHpgpxURR6d2Ca5eG6jJpQLs2yOC4HogX6E?=
 =?us-ascii?Q?ezvi6QU65hPBCI2N15Mz/zI1u+GvqmchIs6YBJdvj3eqQ3YnljDP6n/J2//7?=
 =?us-ascii?Q?e/i6/cQImAAJMMgbA/9fboKIP5ziNwhu6C492VXO6WV/y/dobJZz4OeQaNFv?=
 =?us-ascii?Q?qAUSbAi5D1vWro3R1+HE1D5LZH+1rDyg6vmRh6+IwNW9oFsOarCohNJnHCLI?=
 =?us-ascii?Q?RDbcDvWKTs9Uzojp1MzP2svzRGJVn8jbK8FoEBPEaZkDpTHgizvgc02JvMBl?=
 =?us-ascii?Q?vSjXhdadEIH7Av10eS/DzSMo/4bN+h8cUNU4HUlxNuEDkb284I2/s/ye65IH?=
 =?us-ascii?Q?mbsbcwaOZ2F825WzvyPFnhzPf1ScMBmQWd9DlgT0fsOM/kec6qlD0bRcn2aT?=
 =?us-ascii?Q?6IAKivF3WOfhm89aXDXlMBh+NKzOfb1RZsJLNI/T/UQ7ZPiwHyqm1JSBkZbE?=
 =?us-ascii?Q?yfMmb1+FCkhB9TTl83t1k2v8eYd/N0L0oV8bxAMT3bYVAWI/cOKhWayQ/XN/?=
 =?us-ascii?Q?Zj4J8TRNuWQBwRCYSc/Eppd0vMCHIF9VBrUySSbPLnlyVf40YNbr6DcGKIlS?=
 =?us-ascii?Q?7NvwL0DZC2urLrmuvBI0xG9M6HSz5FRh1M+zCphI2wsXpUd28qSedafLPALZ?=
 =?us-ascii?Q?SFdBSXp62v2A5rsTYqomWEuFQVjUQ3Z8dnB4vwmCRPJKoo5LRb2+InJrEqUW?=
 =?us-ascii?Q?wgE9zHwRAK0EV7ASXkiHHjzy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c81e011-2e7c-4ca1-222d-08d8c9927de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 04:57:08.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bn8C5Fbgpiu8GT6Bv+PFNuhXHHhyz1fxt1cCiQ0uCS9w94Vzes3isHyA/ZQJ62+TgSMU22pCSJN7iFz1udskv/ZyFvpnxEDKTWtjH7Be4Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6283
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/21 20:55, Amy Parker wrote:=0A=
> Many single-line statements have unnecessary braces, and some statement p=
airs have mismatched braces. This is a clear violation of the kernel style =
guide, which mandates that single line statements have no braces and that p=
airs with at least one multi-line block maintain their braces.=0A=
>=0A=
> This patch fixes these style violations. Single-line statements that have=
 braces have had their braces stripped. Pair single-line statements have be=
en formatted per the style guide. Pair mixed-line statements have had their=
 braces updated to conform.=0A=
>=0A=
> Signed-off-by: Amy Parker <enbyamy@gmail.com>=0A=
Commit message is too long. Follow the style present in the tree.=0A=
=0A=
