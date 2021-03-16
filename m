Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FBE33E242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 00:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCPXkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 19:40:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13547 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCPXkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615938014; x=1647474014;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YFXzwexujLxNrSpBxDp0+uyATgkNsRCiCcqXoNQniDM=;
  b=eg6OkOKVrF83V5pIr4PvugH4WtxAnkgC4fxPvIsiVl8G3GBUDoGvHMI2
   J+H+RBLCKuiTECU055rv9QZzKR+IBzMnIFDN/8sxx9shDZ3Wc2FXYWLB+
   qSDzWzDNuEWdFBwJ/Tbzdc+2u3mph6mUjUBCRS9Hz6tdW3xZCk0n3gUQF
   rsdeNNW4M25wE++UpGSaRocDaH8Zebx6KaZetxQq6Qsv0K56UrbPEFL29
   JG20exYv5rrcOzVTTPFDYBBDHbXf+uGqXa59EpUbRNfRifm/K4yZv76Q/
   3DamXGL3c1nmAPCiVhz+Jweb5GtdccBB68Zs9D3ANKGehZ0BTbwYstCa8
   w==;
IronPort-SDR: n5tFkJC9zKjspdIXGRrhyxoQQsCcc2PMR6KCzJB0rI3kxphFml+xKmFvU3b3MxcTRyxlMIyozw
 rF28mjYnfYmf45a9EBSP7OzGicj71EM540jtdJDTEgP+pTCutEIWjQ79q8pRCKNfFyUVlIp0wm
 9gB+NIYZA20AXwXqiRMauLo+jL65MAxtau9CkEujtvUsPYa97wyE4rmupb24OQjOL7FdXQaV3W
 pX1WC9nTXWi4h02OfTv42uyV3Lexve++QvwoLZk3H5k6x692RoldkL213hF1pOUVs48dxgWQKO
 414=
X-IronPort-AV: E=Sophos;i="5.81,254,1610380800"; 
   d="scan'208";a="162283054"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 07:40:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZID5AwxcbB/iVUx2GKNXzw0EHzpAKpxMIifULvlE5dIrJdz/Ss74WaoPBKn4E+1eBWLo8E9AqIfYGmndj0D70YPq0rXC2Fz34ohHXp0TPx9QmKy433yXNdoyhLwn4eN+8ZdxxeWSWBC7XYcmaaEVdRQM7o5hqaT8j8g2LIsOS38WKXWsYeJbhprGEfiCvDjcmEkr7zgq+I0iHvyrHttD71P6azdGZ7QydXbp7Dy61g1kN4+u1JpyF+hj6Ntsn0ebuDv7QCvF/mzs/S934hluGkCuN5oUFwgCCMplRZjewT+wGR4/3VD2OvN35B34xe2btHsMrHqIYKjMpc6QhM5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFXzwexujLxNrSpBxDp0+uyATgkNsRCiCcqXoNQniDM=;
 b=nFbao75QpU6va6QWFCEGdLog2LmwxAFMFqPOhSpNSJadtJ4FmX+5DCc72nzioR9h9VvPSy/GijPbiyH3CNL7F51HO1nxWcOjQy1br94UpgUY+3ITP7XKH52SbqlC0skyvuFWis8EvDUleMHNqb2Ea6Xlco2+nX8cWMN6i7CuyMQMSoZv9UkM9K1ppCGv1Qo7vdmoJhwW/u4Kp9A/GSg9Ej80rLddMlrdi8yo3ZUagjJMIm9xL5OWgIOxGmfpIXBgvMcnmqsqLdCp/KBbrqbdIGwbbnG2h4jNKkZsolOpUjP4VZJFDKI1vIsL9dOyUPcyX5HDWuJ3zoNgMs9XcF3pLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFXzwexujLxNrSpBxDp0+uyATgkNsRCiCcqXoNQniDM=;
 b=votpcJ2e5Q5i2HWIkzL9BjP0d0couqkK3pzQsLgjc0mXBytmh5AyHMewceN10J5r+TD2U4uV/fXQ80j58ejUvQfpjwvyvtKSpvvAsLGSzLEdn4HC+5IPWvD3LPnsoDwBbSHibAX6tYPKp3AfDPjFvzLsoB7X8cC8yY7V2mz9/ao=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4135.namprd04.prod.outlook.com (2603:10b6:a02:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 23:40:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 23:40:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] uapi: fix comment about block device ioctl
Thread-Topic: [PATCH] uapi: fix comment about block device ioctl
Thread-Index: AQHXGgJOxdve13zcBk2LvYJ+ZUMmQA==
Date:   Tue, 16 Mar 2021 23:40:06 +0000
Message-ID: <BYAPR04MB496541D87DF4C43ED0D887CE866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210316011755.122306-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c3aed46-8d5a-4b38-8997-08d8e8d4d44c
x-ms-traffictypediagnostic: BYAPR04MB4135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB41358477332A2E848228B72E866B9@BYAPR04MB4135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/tMnmI/dCoQaEg6HjAww/0fHTuWWw63u8TnUVaZesA5FhfsAT78ygIiOaOYKSAd50SPdMUs+tJOXPnyG+2ao1ifkJsCSaSQuaWLxFyQCyAbjGeVJ1DddiB8Hl26YUNtjecQi7ipPnAXNnJu6mB9nUiOI3JKPfqT+YgQHCoDQjaiAmivQ/HNGA/Wk0uysLgfwkDmZoGkpC80sXy/eB/k6/fZOBLYCFo61VNIYlCna1E9X092lj5auLhioWc7pujK4C3UWO1dsRF06MPZK5cAUwCAyynk3Ef8J1Cub4H/dMj2033JxQFclVk3/591Gp2lkNoI3J7hdPztEMeAbfvL28mLKReWrBDajc93M8q4QYfvkxTc+Urz7O8XIYTmArpuFSNQPA0xNal0BCwEpDeGfl3plar+rWMUP+Zy1F5C5V+HrT6ljnNom5oCKTpfB7WMv9okiPtRNW1zT/RtxnVQkcjz7ydCKFhKnZtgWDDt3OcHwmXWUUQNe7Z0g5U80MdCwL9W5lzbB61bfB4tMxZqshcAAbAkRFcQ0jaqewTfUEIQlb4+nQa1zkZkJPT1U9Ql
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(26005)(8676002)(9686003)(66476007)(8936002)(186003)(76116006)(71200400001)(83380400001)(478600001)(4744005)(33656002)(5660300002)(7696005)(52536014)(64756008)(110136005)(2906002)(86362001)(66446008)(316002)(55016002)(53546011)(66946007)(6506007)(91956017)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VI6hb3H4tjjqVQQEhvdar/mEfs9m/cqYsndIz/Wn0N0/lh5/7vayvHkfBfZa?=
 =?us-ascii?Q?6v0LNouIJmjeYk7FyYoFW0Zf6QzZfFJ5MucQiPshc+OSx/FeZNtWRJAOAd4L?=
 =?us-ascii?Q?mcL2xZmPnbuR3cfQMcFpX42eo5tnOjJC4hebWzpbhcjLch+iAidNIRlrhrEt?=
 =?us-ascii?Q?s9Tj9d7NnlkRnqHuDIgOFCnsS9SgqRnm4DpxM/zVUe+758fZDeBISTnunGmU?=
 =?us-ascii?Q?kvbndq5gsnksdPa+AqdLr3ror9V2hYw3+QuA5LexDEIZUJelDDE9fz2Sox0T?=
 =?us-ascii?Q?ZxmUEYqtKYpPzzHWfVkQ76g7g4mDDz8ot6T95S1R0kAiS17tQ8j5OndQUG/o?=
 =?us-ascii?Q?kkkdslMDikQr4ismQ8/36fajYJR5nAhJJtNxwo58BvaQII4Qe0oTH90dzvCl?=
 =?us-ascii?Q?5DFVd1BIDULJKL3DFjxJ3U3HrGLTvKHvkCSfkGnGVrFPdpX8p2BTXm0RJsXf?=
 =?us-ascii?Q?piGwvPAT3YYfJOwaf/iyAsc5j7AOq7q3PDRFVrp8EyIQtJyytEjixIArZJQx?=
 =?us-ascii?Q?k+ht+D9iurjModk+b/6cvTrQpm67UUV7FCjH4YAAYX6+xll4T8oBXqyib3TK?=
 =?us-ascii?Q?Du+qMChxyj1oWgvZPUragTXY5SL8vmCuk3PKPd9iakc8Em7OaApSM+5m/rco?=
 =?us-ascii?Q?fJOO6SDKwbTG1iTMCx+LV3r6EInEXsW64P3/WI/UsYPsc/S4/4uRb0G7kPvo?=
 =?us-ascii?Q?WyVnKiMzR7WKKAOzCu/t7qO3pTLwR8MGiZnlbmyJoRFOjagskMp9c3W1/6Su?=
 =?us-ascii?Q?HevwJSQA94di1da6w530gx+PQOe1vLWAcTXcSv8qdL4ZJ0r5IlyYFigEgsV7?=
 =?us-ascii?Q?jCKRQvweIsNN/oBEfNcmrqLQ0TM49unKEUYHcAO1R8UAwbrBJB2w3d0M7kfs?=
 =?us-ascii?Q?b0jL57WuznBOc/mULLmUA/5p6bVDRGNNJmmEEkZ1L/tMB4S1sVke44pD47Sj?=
 =?us-ascii?Q?1Kr+FK7QieaWgEt/J6TMU5D3VbFbnVGWBMHkmzsvGH2CDxcCPRwV6NNSVdq6?=
 =?us-ascii?Q?WOIva5oYjys6AjJxAgOUYXxsIvnihPH0kNBuyWyvMwh6dtINbN7uZkkDNLvZ?=
 =?us-ascii?Q?gie5/Ub5Ko7gZ8rwkYWdSUAhGJWVkNu6/cZCJoYQbLVAU7vTML06MKq55Y1a?=
 =?us-ascii?Q?JDnNc5VCUeRJkCUrHpAojlSz6eJ/m9ogf1YyWCVQE3hJt6rYMw2s0v5aaOmw?=
 =?us-ascii?Q?xdFbpmvmJD8F3ksCcXz3IkpqIpGjBqTucU9sNBMuZw3NBwyEN9DzBkxIRnSI?=
 =?us-ascii?Q?2nrfUE8iAlyS/uw13C/9oiKzVNQ4Ec5bRZcWqrOhrYP98KnVpeQkLalY3gnR?=
 =?us-ascii?Q?h+d5yu/Q5XLwTMGByemutQws?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3aed46-8d5a-4b38-8997-08d8e8d4d44c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 23:40:06.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61n9Z+ZXa/yftCmj8jBw5hq+WsOdqyzY14Mki9RggIC9WubYH6iy+xzcTE/o6FqJGbmtgHvTbJPCvLuEEBEtX7+EzI2jy7+3MWc7hMxNUwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4135
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/21 18:18, Damien Le Moal wrote:=0A=
> Fix the comment mentioning ioctl command range used for zoned block=0A=
> devices to reflect the range of commands actually implemented.=0A=
>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
I've verified that blkzoned.h contains the IOCTLs in the range of=0A=
130 - 136 in uapi/linux/blkzoned.h.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
