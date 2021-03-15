Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20633AC12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 08:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCOHO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 03:14:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12707 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCOHO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615792469; x=1647328469;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=V0CuxTKCoAymdeOwWEWcK/mCZ/nVA/ELzeKQjA1WxyM=;
  b=XctqoZBRMDCxFlROddiMMdeHl8qlkj7gH6mU3HeKnW7yQO9K+lD68y+P
   vBXz0fmST+roQR6SpPkRxEQdrRZoKAPTtFsWG0YOexbrzZQEqckTVzW2R
   7EkFzmB1NPiirzhzkh4I+mvka6YYG69VVhsK4d7MxtZIe/Kj25DeAyg0H
   zKsa6LEmceA3Z0bs1g/kjdc7R0UHjMWTdilebUmx983BA25BvmpV39+UL
   Fm4BaikSQ8q3g3eGG5cQgeN1sWr44Cgp9qBmO6F06gLg0bDA3yacf8qj4
   yHm1L1zh85VDfRehBYxPWtIIhdpaV8PYA9A1Yuvj0DaRaRvjmvtjNVL0F
   g==;
IronPort-SDR: bmzDSkgFYOWZCblHvjXCh9CCS/FRJAip0teM6MHR0NM39jLxTwsMb7x3Z3Px3XoOFK1fnUW6oG
 /yjvTXryiWyYoJmctdfJrVpvXID/pa9zvwGqvtqC841y7fH4cuJVjrZVw0YVJJS6oj1HdWj236
 s1K3mqD1MzSu3r4dqN1qnsBL0yV7HbJDev7GZi8967OFIHmG3IvJAHjVYrQBakpx3oqsWBjfTt
 OFOpd0nHKMj1nihP11spRCi288Qd3P70w24ctHI0CJhywjiRWQhAos+0DI6PNQjwhpxB+wpY2Q
 +GE=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="162127789"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 15:14:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XznP9SFcgS2lUDvKW+RIRCfpAtckD3Dx9qW0NPlhep8Sbr3LL9ivb2tvEN9HnVmZAnhz9SQornqDSr3vaBEink5zG3Cj67Ui/YCdKxxY99g4Jow/fyIC3MCP7fJvvaVk5urJNqG7XaR9/M2+pfhofhRIRIXVYfIWgHza7XHI89CVfp+uQu3vjNzjiF5HPV+bjLTrFXLGq/C0fHVPdI9SfJ7+9Zwj9iPxZA4WgVa8g60PwhzhseJDqg2F/lK4NTQLFYdZeVIy5BKrr86w1Y3axiyysmTPs/Y4vRrtAqsMwLnQwHkUnfMIlVuHc1bPm9GBWocoEXybEMPy7vitqUyFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0CuxTKCoAymdeOwWEWcK/mCZ/nVA/ELzeKQjA1WxyM=;
 b=L+gDTcQyEqRFGHYLU9spqrzIkI4ld8r+fM3ZaB43zU7nAjBxlcM6bQbxDFFlKhtikuRAqpHzXubWU+02lyS80w12zPL4phCO3Ya/RkqzjAmtY0B4Xnean4VFfhbJbGoTaHghgdZYsVtNGWo4+Bu11ARyaiSgXl5tUT/4/e5VLQIWNZcpapW4hLp+vEgQIz5x8ToI13taRqzVcQ5YyhWubOc+x85KUreduteJ+OeK11RBU2eAr9jGdg4UCcpu8PpBIsCjnU4vNkZX4l+iCBAX2AXazX3JQUCrUmzh5Irng3xTInuKpjcDQx8CODnlK9p28j5/of7ecp+4A2ZtJ8B93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0CuxTKCoAymdeOwWEWcK/mCZ/nVA/ELzeKQjA1WxyM=;
 b=Zcg9a/8qrsJXnKByGEigzh/b/sd1/C50+aKcrJWV9A7Em0jHb2mJohh8PvGDP/evV6KO1lysROKuXgVWZlGQFdTwtRShwhJYfAoF9WLbFsRE2+I8l/5cOd8x5H/CQxVQT+VxK91wZrU409hv+/5NJk3Fy+lQY1rQpO9IRb43MaY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7669.namprd04.prod.outlook.com (2603:10b6:510:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 07:14:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:14:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Topic: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Index: AQHXGU4zKEkqYN3HmkWOOzLkQ0PL4Q==
Date:   Mon, 15 Mar 2021 07:14:26 +0000
Message-ID: <PH0PR04MB74169F70B61C4F7BD806E66F9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210315034919.87980-1-damien.lemoal@wdc.com>
 <20210315034919.87980-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:6d29:9a36:82c2:4644]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a10a6ccc-919c-490e-8351-08d8e781f7c1
x-ms-traffictypediagnostic: PH0PR04MB7669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7669A071DE7AA61B3CF9F98B9B6C9@PH0PR04MB7669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKqfS29gsPU7NWX86a1I1DwPWH+JkaPtvrvBmmkMbVHRwJ9Tmo1ylP1e3113pEKxpaHpC+P98zWkKchXjvRH+uoGPS6lfsfQTK63N8HxJB1JNiQuvOd71rJGUcZECVVe/EGN5PFyIiIkMwD+DpwqX6OlkuGhTintM+4qMlQWv9+BShNE3lGH2g00Q9QKl6Q3g7Q5bFhSudMdznIETu3rc3fO68gBK4g9Rfn8DPMJYDmZ9rB+ErT3EGQRiSic+y8hjd7Ei5o18HDTuOcHiiBSHWvDpvo6h1j2y6Hagtrj/02M2ZKtQz+xGOF2gY8cIfkXKXmDnWmVHlRL71FNx1tSD+VlYJ9ekFaNOeOU1Lax/TqAN0DqqtsqjWYuUzbL2MWyGIrRv9oOaTawcM/fQXPIB10AZz1xcy0Bv6YRCAx19oM98nv6Hh2Hq+AlN3BijPc4WuZor0AIyrVr0mNe87ei9XJ6WQ7Wof/fHFD8TNw7Pi7sK61nA9xHukTykCXHX2oqX/PWR5Thb33FvdR1/Ekkf2+hnDJ5egiC1Z9zodHwzfe9GiG1x+WpXRKEsyCnCpN6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(2906002)(4270600006)(8936002)(478600001)(7696005)(186003)(66446008)(86362001)(5660300002)(9686003)(55016002)(33656002)(19618925003)(558084003)(91956017)(66476007)(52536014)(316002)(110136005)(8676002)(71200400001)(66946007)(76116006)(6506007)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FCMcWtRtS9yxnFWjLUvUCPVBEuIz1Wj8zDXd9rhZDetn62t8hrWgEs7YpQTz?=
 =?us-ascii?Q?7pCjlXgrGi7spp/Q/qszOyLncHg9fIr4zS6RDz9nh2AbAziVIL6QvYUqYX3H?=
 =?us-ascii?Q?I4VOhXaJxMf+fCN/TaLKabpWCJmQnS5RgvZpZcedT55PdIc24gEK6pdLsISW?=
 =?us-ascii?Q?7iQYraU555+XPw/dLiM2OEtJkEya3rbk2YPpCC/xGGJ5w87clFnR+Gr9BUEv?=
 =?us-ascii?Q?NJVGG9RvsaLWerpUsPW9B2Klig7hkMuaeiiN/kcc+MjXbqgw7C9EE7mhyX3d?=
 =?us-ascii?Q?oAJsZlBACMe4y9NREoOhXrSv9sJpDFhTCj0qOXA2wzTFAE4l03+3Ht3PKO7F?=
 =?us-ascii?Q?5bneOD7e6uUiQGKTThNIQ2lqMVj60psfOeCvY6iyXfIzG7keG8Oen5XozOrp?=
 =?us-ascii?Q?5w5c7UpsJVjPC78x+cdQINBli0t5M4agx2iny5p3w6WtKF0SKOWqAkAPMbNU?=
 =?us-ascii?Q?kzNIWSL+7lIlFbjnnihGAusuLga/xUanVo55WQlMiiKdk0BkQoe3efJ3vfnd?=
 =?us-ascii?Q?e3zDVegecz5+jj1ctZRMxNbIyjeFvCmrEoLth/V3r1bMtjal0lQe6vbNTgnI?=
 =?us-ascii?Q?+ng/NAeVH3sDoIEsVswIcVu+IldDrbIW+RSniO0S8pMeQZl93H4A1bxAmH4z?=
 =?us-ascii?Q?ZmagnyJRPm441ksHIyVLMJTa8CjfPddhB8jNOrDkbEVChncejQ4rSpemJAnP?=
 =?us-ascii?Q?59kXeD3jlmo239di18A7wK49UZ9U8V8bytFx/1/L1F8LNpkxckgtGpw2iuPl?=
 =?us-ascii?Q?vmzQNL2J9Bw8IE8b8FZ18OXyfA6V4DW1yy35nilumtrplYKmD8e6Hy7C3snc?=
 =?us-ascii?Q?QPcu7qPgU/ufXPAC1Aih6mV2MhsSYJpe3aC6cmHr2KzTItiN+Oz2V9yjZERh?=
 =?us-ascii?Q?rTpat9+NrpbXXxCGPbP4b0XP7JZ2KRZlPStMDiPiKdzuIgUjJ55dhnNmDXlf?=
 =?us-ascii?Q?I9g8Q69NGVYsCab0D6gmLZG/otiEtw+Il9qblFGdSBZveJalxVjcJ5deGTHS?=
 =?us-ascii?Q?DmgSfzxr99QZqShc5LYUJaXlCQyNi288Fo5fRdibJc6d095jxb4M3cPRVKLU?=
 =?us-ascii?Q?rS2fW097s3vsuopo905mfhPQa4e2heclw5wOOvq5M0ww+8nhVycO1vYPIjtB?=
 =?us-ascii?Q?2YEDYkbiUisy1f65xmYynCn7I+roP4qj6j4lvWcoMg0BgtpcGEKKvY/zc9gQ?=
 =?us-ascii?Q?2G+vdbSsjnp6A5/Z52VcU4BESb97eHN43JWfI6RnVWvK5zP0TZIsJ9pjtZjt?=
 =?us-ascii?Q?jYSWqDHl3QTk22ZG3ia+OOHBL5Y7SDTkpHUcXVFbGAgtXrVGkhiBUzri1pPM?=
 =?us-ascii?Q?mMjtEBGNYeD8Xx95+lTUQcVIJwnothtUq9V2/BwnLDuaGGFI1biOLjky9Wrl?=
 =?us-ascii?Q?ikS4xRU9HwQGxpqm1oBNTpZbyIvMBirp5rdGVHsj2cNy4F9yFQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10a6ccc-919c-490e-8351-08d8e781f7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:14:26.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiijdJUHIe9LCspX/UA9K6uL2zjuT5vfJ1ypb+D2+T6ZF+zei0ys48dYrGai6bGm3FQtRMjtAAFWbiWZheDvRqRjwus2/KG2T9OB+2tduw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7669
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <jhannes.thumshirn@wdc.com>=0A=
