Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E428033AC27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 08:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCOHXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 03:23:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27385 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhCOHXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615793013; x=1647329013;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uuIJpeDyC+Yk8zPFqEekqhnGgKeTw/QLNH9wytSEhRo=;
  b=GuLZxZ5Mg8fbqvKPcQwS23T7Pc1j3K3MVSAGbzKRR5UUbrEDcb8WtzMP
   hwD2AFVkY+eERF8OAjYfFIoBuDSOLC2v7BDnJvb9dEpw0mz9LOd/Anv1D
   GxlvQii3q8Fli0aTz+B5VHCiiMrbYO5xa+3w2nCaaWy2+TLifIKhGque/
   hwrSJQMd4h22uyhgbRzb0CL8jpoWC3SQLxoUT1WqChHA5plEuwS1TNw+8
   UNMOV149RP+Y6oJ9sEG7o+Pnw5lIA7ax1v5dfUBrjRMc7+cBDRQo9dnZy
   V1bwgDBiBJ/kvuVGd87e5rMTR38v5OgV+5lgbe4HG9kHeYp5zY47elQ4n
   A==;
IronPort-SDR: gvmOz8kUdF+C7kv8njQLVHtLH1uT+KiC8cRDtt4C4rje6u3jaienAkqmhi8YJP7JLQ9eIqDOIn
 h6TllJVuxAI8W6/mJ6IewzBHFelMGGN8kIzukhU8BHpHKvEm3D+M7Eb0+09OoJA1LiMYcsbIlF
 crS/JlyfojptVexT/VRV8KKFHefpAWdBW2KIgka3WvPT3EYbC/bMlwqO+qi6+JOowR41WnbJDG
 SPS9rpzcfM4zIi7Gvi2ahpkRY+wzeS9wTnE8yizo9C0LVQuPK3oNsZCOEt+bQMUs8c8AKjvtJ8
 49I=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="163295853"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 15:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJsmeRxe8He8bKrMGhONPDSPaLtfOQMCpTXpZXq7C/PPNn7yZ2mtOB5iyksVWVRcH1zW+mwIH1pOnjfhirIgy5JdiEnzS2bPpsRhd4yLaeNXUF6Liqyo/refjOfPyXorCczre82a9c8F9p4zlqcqe0E2ryDf7XmPEry+5zLGP1w1n8l7xVBLL4oHvd8tufpvyp82OZ0EeQL9KDmW81/RwL7AtFnMj4dNcYH9muLx/TPTf9w/Obe3grLqG3YtmD0KG2+ZqnW3RBF3N6jfbXfhgEVbnsyDlOgeidFRSVlG+AsvN1YNhF/TktKAy9dLY3ZJma7vyDjOhngPYpRY3+axPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuIJpeDyC+Yk8zPFqEekqhnGgKeTw/QLNH9wytSEhRo=;
 b=LAog+uQ+XIgUl10qxQbErAAu6f1SKZIn2J+5aMie4pOlPS1ZYpYFmZUyUbySuztJYbc1zctHShR3CTzxpGGQ1A/qbPKprIBeQqH7BjbIB7IsiohbPZ4AeHyl6QO8h8zyQM/0WEBm6WDpIaNgkneTivIPK5WjwQCwmSAabDZagPe4Omr0WXtZBI1YMMPGoAmX6DzUDVeh0QtOYvan4ZEBgQMaMZ7ffaf5jkuY6muMPzg3r6TI37UKoIJ4qTjqO+vO0VTCW1AHUjg8SZoIN2/R5RtDg10iBhakRsNpG36OZKLoSE9YfgtF75pKYTqI9EPIMSDN4O2YVrKACbeG2YlaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuIJpeDyC+Yk8zPFqEekqhnGgKeTw/QLNH9wytSEhRo=;
 b=cQbHryyL+DiLyMKNPagDJf6yOFsR21MCccjqrFnbMl8Ai6wuU4gyXk/rXw5qR4LbimBRhv8BLLKPB14qLOYeyrXxXBK75xYN2/XFz8kX1inD2c9bUmuNZML49UF9FRJqXXu9EROdK/g2xaJ5LqmJ2iRO46msjcKi3aQu3WYIEFM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4738.namprd04.prod.outlook.com (2603:10b6:208:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:23:30 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:23:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zonefs: prevent use of seq files as swap file
Thread-Topic: [PATCH 1/2] zonefs: prevent use of seq files as swap file
Thread-Index: AQHXGU5Qaa/T0DwpJECPzYLinFoHfw==
Date:   Mon, 15 Mar 2021 07:23:30 +0000
Message-ID: <BL0PR04MB651408289E9CB93DBB09334CE76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210315034919.87980-1-damien.lemoal@wdc.com>
 <20210315034919.87980-2-damien.lemoal@wdc.com>
 <PH0PR04MB7416B66AA60FAAE2B48CCEBA9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:85a2:35e9:2c43:32e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91ce9104-f30c-463c-f621-08d8e7833c24
x-ms-traffictypediagnostic: BL0PR04MB4738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4738E2F203153A6363619A5EE76C9@BL0PR04MB4738.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Cg0fsjw47C50qCqdR5daPan3/zEK+rf0/xk7GDvKRMmA0ob0X41VwIGO3UhlO2Bwjgsm9rrKJuKITWYQXkY87DF2GG/4mRe+v9aL+FNTMyBiFaIwn4HWPVgFZgwJrvnA2g/Q2Zu9c2n8Ov6Sy2YCqxooJZGmpyFNtN8DCcZpucpLisyCTnz5m43+m+BEs+fmNlcRCEmE9jpJ62EyYvvgTUSB44GdE4g+F4JkEGW3Hmm/lPOFuEldZf+v0xIOtn8pvNbxOHi7X6wGB/RTT5YM9AJAGI8khfWSDqugx4k4/lqSxYVjc6l0lWBZ8pZE6eelv8LG6LZ5Le7xac0lmISnIu/falLmhT6RmQaXukrb67J82cLLPJMnuU4anrha25JNCQU+w/1xSUDxRzDh3XeJkpjfU/uT3FUvJizpGIlJm0y5YNhBNVWTVkSXGabe5IYVG5RV4fz9AJjQrDoagjBb1bQChm0L9Cdz1WxNUaJX7MoRzjeZuBJSP9jc69aeIG+blruBYkJRrMyUok7X5/fhSzl1rZcl+vOKGvZOEbv8qPfkYZPPf1BQFOgoOuSpTp0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(66946007)(76116006)(64756008)(66446008)(91956017)(8936002)(186003)(5660300002)(66476007)(66556008)(52536014)(8676002)(7696005)(4744005)(316002)(33656002)(55016002)(9686003)(6506007)(53546011)(86362001)(2906002)(478600001)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UNHJ0hNUEz4MQwtAki4UaJEgAaNiOmlQ1doKKVKH4AfIen9GRhtThU+1oa4E?=
 =?us-ascii?Q?AWPzkjOf77S5zHHZz0UipgdPuzhh2RVpfSfnAulSiZ4gUVjSoB8k6LLt6UUj?=
 =?us-ascii?Q?sEUecQc3UrO8GEYXU8uDhOXzzNfzTYJKvjOhSEEXoWcijFGx+85xF/jUZM94?=
 =?us-ascii?Q?BIW0IFBKF+hZdxohWLMDDgjAKVT2Cd/Y1DoNL4nkmFUBLjjJHyTX+FbA609K?=
 =?us-ascii?Q?F+TZg+Rp95mq9aayPomvYD6elYjqkxL7BsZr5ks6T+sq0QL8BqEELo0peoWj?=
 =?us-ascii?Q?gxjIn+Wr8KLKpgrrWtMlPZFyyp/MskMLfvnyg6G8cXyOXESyMdFO0R9sxj9E?=
 =?us-ascii?Q?ZNL0Go8KNfdt69hSDgUoM1F1nsXuDkprowygwXuw2wMxZNe2YHoyUBRGrTWd?=
 =?us-ascii?Q?2CQfPggKz0EqkFjhkh1ReYIQggXJQ5PXiiVYrh/xtLRpF5o3en8SsMfZD0mR?=
 =?us-ascii?Q?ar6VhPfS5FjDqGXhBUJ6ocMfNiNuJ9CEj2xpIR1NunBcY2E0vzeKeQ1FaZI2?=
 =?us-ascii?Q?qwSNxFQ98sbmgSjDv0AkIATyXvbpwE90NPRSyrWvfOHVWiAtBQFsBPWQEVvA?=
 =?us-ascii?Q?RXJxrhZstsBuh/z79+5sc4lPM0jCIcBcjLMb8SzeylSEiFyCqiJqsSzpsxuJ?=
 =?us-ascii?Q?Zww+pUAVkOlAwtXttVI5u3X8R3m7IsbA3iUHyEOZcvCrFlTfjFV8c41897Ax?=
 =?us-ascii?Q?j1m38ds0LNFKItJ/5qUWftNDd/OOr9Oov3/ibznIqvsRGTuMnPmWzlUt/nkQ?=
 =?us-ascii?Q?hOYFoZzTZkRCkMU6v/nIzakVtT7a0u6ba9Z1WKPqHMjPE6c6KNEaN/Uffr+d?=
 =?us-ascii?Q?i2bbzoj1eJrgoSfYAHL/JnAyk5ddS5AHSKAByazZvIp1YLvNKVXOrABVJTuo?=
 =?us-ascii?Q?ewTLuDsy6YPnG/TS0jBs4/qUdHxz63wXbnazuuHrcsstTEN3GKWOmCb8lQTi?=
 =?us-ascii?Q?4GoJD1QNI4QngQZWVIaxJHN+cOZOTrL0kUobktwEkizc96cmtoOpnB5f06Wc?=
 =?us-ascii?Q?N/tdQsvaa/NzgueK2ggA/WeKXrLGeCBthbCbSiiK5EQofRrYaXVKbvMb0nGt?=
 =?us-ascii?Q?gywERswFEFisS1pjlQoZa7R5j2Glz6Zrxj10b/smSzyziGcRkBrj0qz6Ub7q?=
 =?us-ascii?Q?DMoxEMU4fP3grbLQefPRoPNudAHDgrezZWAz4Ed/k4vWd6wmxw4ckGXHXwip?=
 =?us-ascii?Q?zgPXAn0vH2ngILmkda2kKHg4fG7tg3kZv2eTALmkbPiWPP6YBTV+fCUVN0Q7?=
 =?us-ascii?Q?S9+8N31SCftmH4TXEz/IZ40jNrrYcJKFCt6NnDdHrEo1/r3H6JlT7XB0TQoQ?=
 =?us-ascii?Q?+TOWCvrlKJZaHYjaHXnVqUYSh/A8pnRNVDahEHOfPh2KOeJNtG4qYzMYnsQw?=
 =?us-ascii?Q?nCblBzYO+Rt9zX/2X8GanTF/wYGvm8Gg5AwSU73c7XaXb0D+oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ce9104-f30c-463c-f621-08d8e7833c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:23:30.7268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMKxAnT8FnZEkLMMMm/o4xmzSOdu+leunptDan7e6XXGlbatNlIHvxBwhO4Ard/TygHU5gefqWmslUthcmaOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4738
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/15 15:46, Johannes Thumshirn wrote:=0A=
> On 15/03/2021 04:49, Damien Le Moal wrote:=0A=
>> The sequential write constraint of sequential zone file prevent their=0A=
>> use as swap files. Only allow conventional zone files to be used as swap=
=0A=
>> files.=0A=
> =0A=
> That would be super useful to test in in zonefs tests as well. I can take=
=0A=
> care if you want.=0A=
=0A=
Yep. Adding a test case for that.=0A=
=0A=
> =0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
