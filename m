Return-Path: <linux-fsdevel+bounces-11658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54590855BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 08:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A710CB25E0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29EF1119C;
	Thu, 15 Feb 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fTBQUGYf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a8TO3gKq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F512DDAE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983828; cv=fail; b=sTVMcQMrcE4wJoqstTjnW7DYiDa3ALK8GNldW8VpOq7jViBteWbacOZoe+TfK1z6p1Um8YYlG4sdgyPYpmg0X4vX0KC6HVHCoRt72RRgf4hrmrXjh81eDPtsV9VKSBrLonkUlpTG7bCkR9vf7L5s3DVdaS2gc+qXceaLUeir/dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983828; c=relaxed/simple;
	bh=cfPPXqBvEyfgSsgewVyE4mqIZO7gL3Bd73Rg/PhWN/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1wqPrqZlSqQIY/i45LgdW8mEEEwIGiNaUwRGmsNcZG5sEZhcUqqgKu0g3uSa//PxeHPlFtN77K2OBeYrDiEWum0TYtZ4NHTmgG5bLkVwU612kFYXKdk18cQKMb+5VTxMYC++RvwRvBfUWBmbsiggQxMtmwjk8zcnbgOnq9i9ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fTBQUGYf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a8TO3gKq; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707983826; x=1739519826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cfPPXqBvEyfgSsgewVyE4mqIZO7gL3Bd73Rg/PhWN/w=;
  b=fTBQUGYfpRDJw84mLITmDQPpzEV8s08tApr4KHQ5I0ipTNSxP64qwMeQ
   Y9B1RmrongQkE7S5dHzoFcG3L1NHxTxuPy9Qq2WZ/45oIw+KdKJuFW8Wt
   n+q0Rmlkd0qYNcFfJP8P1clB5vPpzz4aLkatjeW+/ThDPHHp+qRDyOaHF
   jhUS4Rwf86cF//pwwTpNtfgAhr0OT71DE8EpwIVPHsxfc2MtqZTkvPDNN
   6bnJdKx93bKFdxtXYVngQhGTJcXqaPxyXoXXsiM6FonOzkKd8JOHAfa27
   m/7NZmfwmQGVHmS82Vd5yLZHnen7IxgLTZh98eD3He+z5CG8c2MDQ4oPd
   w==;
X-CSE-ConnectionGUID: 1lB69NoISyWi+zohrRoALA==
X-CSE-MsgGUID: trwK8EQCQqKIZkDF1bbdyw==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="9219087"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 15:56:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqiA+9/TvKoB633hkWB9HFLw/vgjIZch38J9ZchDyLs0Q1te4dFtDOFo9Gi9riDdbQ01lU/G+Z7CV2T4gcfyLb2GXWqvRIT/i4wV04NXekfvRe/npBFu0dGUFauTK/uo9Ui60einW0BLGSDDdHbSzqYpy2jC4iudATfUoPRN2rKMVPvVkKslG7w13BJsHddTdEwWqY4QQXXZpOsXvvQiiXL/sdVA2W/cGZIXGbHCqGwJb5Ys7oRhNYkp/+rZpO0kmO3LTNfRAke1VXUQ6IkYpFvLwK/XmniZdlfmBspDfyVMPlNnfjVxnbwRBG+hqjW7SHCzBUDTE1JwIjpu8fvywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djxztakzkSgs8ecni/HCsYAQ8eoCZWtOZpTwwZLag3c=;
 b=LHk9ttuG4zMYxVvUJhrCKvVshXlGQ2oDrKt4aRn0dn5b3kOjh7XfADvoMAXtd/HuTN7Fg4qttmAF6K8uT/I6UOOlq6DhLqx9/l/Aiv6ZTtwRZebW/jeAFrbID8kpq4QE4/sk3leAJzd6gznshOnmjEJQlQTfOch6gzeA6Gk/npSR5nMijxL35tyhHYtL9NMW3bEq4Ohx4sqZRgYbQJphODNlje5Kmb8aCDnlR4UDkUP4CGxsCZ6XCk6q2akPgmn5V1nm+Cr2EPzPzLus/qd//fPbLJ8yurGTy1i4NeJlHOO0OuL0cildfLmtcB3KAYjWX++1sjGsfuDFeK8sBG4CYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djxztakzkSgs8ecni/HCsYAQ8eoCZWtOZpTwwZLag3c=;
 b=a8TO3gKqi1QIVgnLaJL5m6eq6kOSFvaw3pBX2Onf077tispxCgdzmX4dHmC2FN5dhKjMdAhn6T9bn6+KPq24ISzyBLY1/XDlLS57QNPkeujvXrPnX9naPYRPOvfl2AzCnsoml+VXGqHbKQWVBR1RupC2Ljp5eUehBoaLaOjOsxQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB8652.namprd04.prod.outlook.com (2603:10b6:8:117::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.27; Thu, 15 Feb 2024 07:56:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 07:56:56 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: Improve error handling
Thread-Topic: [PATCH] zonefs: Improve error handling
Thread-Index: AQHaXxFqpJWAUQIjPkSxCbiiuvZaJ7ELCvOA
Date: Thu, 15 Feb 2024 07:56:56 +0000
Message-ID: <bte7id3meuwhjz2f363dqnjzcymrspeymegbb6qvsb6tjidmab@jfw5eta2ntu4>
References: <20240214064526.3433662-1-dlemoal@kernel.org>
In-Reply-To: <20240214064526.3433662-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB8652:EE_
x-ms-office365-filtering-correlation-id: d9438595-b991-4f81-db2e-08dc2dfbae41
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hAh1qU0OJ3rMorEkHFZFgdSqpizpsfNREcmEYilrvW/di2Z/1IZAXmjj560UWBBLu1qWrTFRBPSDvoQ+HFSwWKMIwlAAbf2x8KI3XhoLotfINRoS1sMfo5w0/4b4JDlTe2T7tkkOsHalycqquc3kXGhduq05UimfY/8Ntsk1LaclcNdb55quyp+/UZsk54s4wY7anbhYt8yapQ8dTpDnH3luM0T5MjR9J2ZrpRlOxnKL9MJy/3Y27E8pCYIUkfPIoRzuqL2ZdU3bmMs5+0N4+sxdG9VjMSgfhApkQLbQlrOBhdhOHIfiVWf5oBRWMMcTTifV5XsLsaO1vRcN0KjnBoK334QgNziHjank+JBaIh0sfttHw1FFp5+5eB6Mr1ksC+nGJfvFcVPxTx/xevnubEGrHJDls9fmpW5N5JP0P9BQFddGyMCNNCZeaNjEM/xxs8CfiLG8iE+xXO5n9n4YO9zanD5dUdeu3VaHOtghPSiD7jdvjif4yuJJNxY4biSrAQokA74xlmSRNUWJl+1wvPU5w2M2LdPlTdxiUgOlCwnL9/gNEYvMkPloAtClCbLYc2TN8hUmSWb7LCGmCFY0T96KQfCUu6i7tUSvC2XjMSkSbU5+lNIPK3YUkdd9qe/n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(122000001)(44832011)(38100700002)(83380400001)(82960400001)(4326008)(6916009)(2906002)(41300700001)(8936002)(76116006)(64756008)(5660300002)(66556008)(66446008)(66476007)(66946007)(71200400001)(6486002)(478600001)(26005)(6512007)(6506007)(54906003)(316002)(9686003)(38070700009)(86362001)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M/BGX86pnSpXpkLaQYCDpiZwAkEzOJT8ot0oxva8To0T5GjOaDKw8X6usiUT?=
 =?us-ascii?Q?CunvumtygEwvPJytqf3HBLwQ1eTmrjfgBp4VX4wLK0GFnfvVGWsQsTcMDFkM?=
 =?us-ascii?Q?CjuMA3OiXJLYv5Qy3AIL6SyshthdRUObEGQg28xh41IHJqxKm7B367TlrCfq?=
 =?us-ascii?Q?0IuBb2DSBxud4rrRPC4Pe0TEdy38lXG31Un0iohGe92AB2ImmAs+jA1sYHod?=
 =?us-ascii?Q?aHgdNobTLm46WIMMNnWVwPh7Ex9S6adhIKY0UBDlTtyi3MVmHlQRpnOvH4TD?=
 =?us-ascii?Q?mOunhItqpguqpWvb6I/nfuRJQsbCvXpH+zsGWHurZlZE0RVcdoE3JNhnb5ya?=
 =?us-ascii?Q?ommAF69/IOvxe/irh1WE+RoQn2biSUjF22Sm2cWBUH4G55Yuzucjx0FEJBQc?=
 =?us-ascii?Q?F/H4lYs+DDYBe8GsYMIE3/UvY22H4bJ7SfeiAvlpVtbUDaAi3N7Mp7RzOV0B?=
 =?us-ascii?Q?FVTCS75w3htm5XrwAQI+fxTbcVV1/KxT6+Ti6cjpfc8kQx3QhOhvgnFIoNVM?=
 =?us-ascii?Q?HtjkxQCdsNAEirDsrXfSj88nrBGJCXeEHYIqmur7rqHZQzP7XJBuIBXVR0qO?=
 =?us-ascii?Q?3MJk790filmrhVhSAm+V1RVPi6IAD1qFT0oMO2sF8uhuhHS1hOXcKRHQClsI?=
 =?us-ascii?Q?E0ekPeaAPFjgYqg444b4FyEanT6iO3pjDZVJqFH0Nif21aWrzAtl0hSVUrCc?=
 =?us-ascii?Q?kfxKHd05N4phYxrsh4TxoKjA/qnEFSM0ximNZ5xqjAUhBxRyvd3pGOkSRsCq?=
 =?us-ascii?Q?rjyGZ65mIiZHuU1Un80eU4xRHplnprW1t/tEa/79n9Alpr/AxzdB/LQKdGqe?=
 =?us-ascii?Q?kGFH7IbvfJijpA3HQylCghz7H64s1dS/TcBKBsBWhxc4kYysZ+T5vNprC/Jd?=
 =?us-ascii?Q?yqB5oOJNriwunqGs0v8WHOZIByfFaBak50SiaoK3ez3KfuRcyjGrlK17Ibnd?=
 =?us-ascii?Q?Msi09Umul55+w8K09LJsXCYjjX61lyN7hOC0nBV7cmBpuqoLr31ZDYpoFgCI?=
 =?us-ascii?Q?2/5caX0Dsv1cKzlcfbbu544CqRI/FduMvjAmSUIIHCpMrMoeVix9BrZSFfkb?=
 =?us-ascii?Q?fzU3wfm669LMhkq/DRPfhEmsJTD88vt1LtVumYQgKMl/oFQ0Fg8sMxrX2E5H?=
 =?us-ascii?Q?9G8kWZz/y5/Tdo1StLn13QkincFIaQ3N1qnm+SjU4gPoOYRcwVZN06qpha1r?=
 =?us-ascii?Q?eyuxlo+JKIxSYsO2bqo3qwWLajrG8WVXSfsH+BYbUWzYldAp/gNrBaFLBHu7?=
 =?us-ascii?Q?r66z7RBDk35LUoiJ6WnyUxUEKc7H3FGSODSKZJuX7HMIKoMMel7ak4Nm1I8L?=
 =?us-ascii?Q?SIhaCd3kpA/1B6YBZbRLQiQvPV1vDureTbY9h4e3Jcl+jQ7XCIZ0VV4b/dRi?=
 =?us-ascii?Q?RGBVpjzATExyCY/Gax97ZKezqeXmD5UwY5dCQl+1eaVe2Dv6Xnxdap5EsUiB?=
 =?us-ascii?Q?UD4B7sV1xg4DreP7/8qORa0F3Ip0+dYej/WeC5LiZ7JsJyQNbjv29F4F62Yy?=
 =?us-ascii?Q?tKAZ6aSaxiZNxbJxG4ylC7nkDEIOFI4LVzefaqeNmZH284NAizQB5ECHvuWG?=
 =?us-ascii?Q?pEOwrk1AsQparrHSJ82Exf47Gzi7nb5TwNiHHAKiff8yXQApkFrQAyIHqU00?=
 =?us-ascii?Q?dUOxLSsvLVFAwZ61sCk17I0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <246B9CA593D47546B62F4F82889875B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j5BiZA2zVJPPEF10i4fxgDObWON8F/Lq3aQWhLJZ6jSLrpWA4tymdbBgmIKR5CfHIA7q0AwBybuPSCvo01juod0loMB85zZwHZ9BpeNHW7mm3tWoRQOPIsgCPVji1EKXEPQYw7U/gNlvYB+tZS6wrcEWL+sxjqmKdHTC1omsjgq9WyQYnVv7g9SquB8YEux9Ec9IRBoUgHdKB/ecXYlM767B4WY+Ot0SJyYtUTpqlgieSXYJi/MRBHbRdEsB0r9B/QRCE3srrKRmZxGj7hNO8/m4ei2hmqKBP9Dxp9ygztTJI8d02WW7MZ8Yyh3yr2qXlySNkdyr7ZxKcDcQQx5AZ2vN336jDvHqg1wZFv6NQhcSZT59eeE2ESqHIPXW/Adxv8OiSx3v4T9lqmReOcigcEehW0v4FTbGE1jmmL+bQDA4WSEzbcWA+k4iFW2M0LW4SfGwr9jI0xsP5XaNj4LPKuI0f9VdgMWRfyOnmU0kQGYgMDcV4Wb+HyKQBF1cLyin/HR0uiiLa6Y27Byg+g7D0u0OewHiBSEGxo/HvUajbtZEgoEtg4+FBG3kz/HbvQRte+dIkUJ34V9h9eOTLhvAixrrMDi0Kvs93GCnrk/QkA+Qu3Cl6x/U2GRsKsTZYAJR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9438595-b991-4f81-db2e-08dc2dfbae41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:56:56.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlC3ztlz3pte0+QNckIFCByv07RlWIQv6/dKSD6QaaYIW2LcrcuEdLXaFu4eVGS511w501PyEazNaW27VlXmsNEZigoorfQUzciamKS2LzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8652

On Feb 14, 2024 / 15:45, Damien Le Moal wrote:
> Write error handling is racy and can sometime lead to the error recovery
> path wrongly changing the inode size of a sequential zone file to an
> incorrect value  which results in garbage data being readable at the end
> of a file. There are 2 problems:
>=20
> 1) zonefs_file_dio_write() updates a zone file write pointer offset
>    after issuing a direct IO with iomap_dio_rw(). This update is done
>    only if the IO succeed for synchronous direct writes. However, for
>    asynchronous direct writes, the update is done without waiting for
>    the IO completion so that the next asynchronous IO can be
>    immediately issued. However, if an asynchronous IO completes with a
>    failure right before the i_truncate_mutex lock protecting the update,
>    the update may change the value of the inode write pointer offset
>    that was corrected by the error path (zonefs_io_error() function).
>=20
> 2) zonefs_io_error() is called when a read or write error occurs. This
>    function executes a report zone operation using the callback function
>    zonefs_io_error_cb(), which does all the error recovery handling
>    based on the current zone condition, write pointer position and
>    according to the mount options being used. However, depending on the
>    zoned device being used, a report zone callback may be executed in a
>    context that is different from the context of __zonefs_io_error(). As
>    a result, zonefs_io_error_cb() may be executed without the inode
>    truncate mutex lock held, which can lead to invalid error processing.
>=20
> Fix both problems as follows:
> - Problem 1: Perform the inode write pointer offset update before a
>   direct write is issued with iomap_dio_rw(). This is safe to do as
>   partial direct writes are not supported (IOMAP_DIO_PARTIAL is not
>   set) and any failed IO will trigger the execution of zonefs_io_error()
>   which will correct the inode write pointer offset to reflect the
>   current state of the one on the device.
> - Problem 2: Change zonefs_io_error_cb() into zonefs_handle_io_error()
>   and call this function directly from __zonefs_io_error() after
>   obtaining the zone information using blkdev_report_zones() with a
>   simple callback function that copies to a local stack variable the
>   struct blk_zone obtained from the device. This ensures that error
>   handling is performed holding the inode truncate mutex.
>   This change also simplifies error handling for conventional zone files
>   by bypassing the execution of report zones entirely. This is safe to
>   do because the condition of conventional zones cannot be read-only or
>   offline and conventional zone files are always fully mapped with a
>   constant file size.
>=20
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

I ran my test set applying this patch on top of the kernel v6.8-rc4 and
confirmed it fixes the problems. Also I observed no regression. Good.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

