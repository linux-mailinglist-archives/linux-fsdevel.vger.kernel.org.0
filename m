Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB11325C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBZEgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:36:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28006 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBZEgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314167; x=1645850167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZJFuCNnykkBJVWI98Ve3mnELUVomH2j47YXFsD1436M=;
  b=H0K4nD60+3cYIyYAv3zdv7eaoJmlwiea/4W/mxdyEOyvSEKb56Hi+JxF
   BJC+FyO8FmDhzSVC7GM6n1HYhJJt/YB4zA7mUDs3xDVu/APKplcWVe4/v
   P9sMEC1aG399QQdatTwo28rtDxRpkiPB340kaC87rJiOkzNXWAJirndBH
   s0sxWpWhR8AC60mexhBRSL/do6+BHeR2mIdHmLZlojmDAcpo0nHg8bW3s
   Q7f6r3gXK1r5/MFOd7paURmEWYOIoeh19/dcx0raud4Y8i90yQVJKXYWJ
   lzV1XuFMIHW+YixcZ43zuaxRznw+xpM3t7i7faKOwdaL06wdZznm36QfI
   Q==;
IronPort-SDR: Xc6VVQgtqr9BfeZveSjsdHVe7mlL+GxNWBwj7NDoh/6jdfrRa58mywiuOnD6oZBh3CRpggig/u
 FsKwgcLWgaoGTopyv43vwfC0G1P9Bc6n0CywljxflthKUeWCJGPZAQGJLJHlDkB+I4Iy0aWfLD
 BlJxHDDptGaFygSxSLZygjlX7q4MEeXoLT+YQ8h5kdVdkNjSIcVZQcpLCR3nZCCJWSHKUZ7w04
 JXLAgLo9E9PJf6Gty4qFbKFZGvxyQTrh9+iDYu+ftewKSM9QAtyNIsgmETVt+XRcB5y3LWa2Es
 2pI=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="160843514"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:35:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by8JujjcFbFfs9pt1D96NN045h0Rf56lzAftrJemzi93qTyxRw5qGA6wrxVKVaoCSfYiadcfOtFlVOiuYHt9arSmSvYbNpGbIE1hgudxsL6wJQL6Hg4SL4sfoQ7hHFT0dHbW7yXqJvSpDOXqtDI9z3u20/t2m4hcCtKofBdhW7bUhbf2G5AXpwF4S9RCLmmR5IvWMgaDljkHHME/DtSMyv6rIVZ4YTx0vEfyXBQF82e13CIlHZpdcQ19lLnZSd+Lopnkstii/SCus2+RezMD29diyq6XzUNvrUDB5yN97zOGQ4m/GozGXMHGwAM9/k2Z8eBIob5jIwJcsUnhgyXIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgww/jJmGaWApM4mkuMZx+Wg7Lid0cZ+yDyKqREABp0=;
 b=QjBfNMgh40yhUzz7mQr0+JP1VdHEQlyGNSoLY6vbWXER485eul/1RelGW/8ZL2HZaOsg2PrbfmW5Mo0EE8+QBg48T50S2LCP7SvXSkq61gS3eNUU0AuOAkLfTygGtAMMMx+ReFTzGzNyZzA2kAR5G4GM47RdI371vnh/oa9OKUgS3QsWjdYpZw382nYXgSylW47YKLLgux472uum+1PaO415Se72WxvPwd/yLiAZxwwG+jn2LS7FiFnxHBg5Mm2AzhndNRGWwkZFSIdiAZsBpk2sk6WcGEC0dPUscHgMsbETEQZr8IRwxkynHEiUINIEkbQTCMFLohiugPhdOEpa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgww/jJmGaWApM4mkuMZx+Wg7Lid0cZ+yDyKqREABp0=;
 b=uFVEv0iHjP7eYhN9dXyNtJAJR8ZDVkrdNN0EAC1coWV3c7eRikhfeYapvtN3iVYuvsZSLPQl6lpulKQYgU48oTY0C+ztsxHKn6DXSrABZRN8WqyEQsI+7CwmrqqJpLvYrbxsW867tNndBk1ODBtLRmH/zyt2LKKyvdx6UCt+z60=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6515.namprd04.prod.outlook.com (2603:10b6:208:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 04:35:00 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:35:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/39] blkdev.h: add new trace ext as a queue member
Thread-Topic: [RFC PATCH 03/39] blkdev.h: add new trace ext as a queue member
Thread-Index: AQHXC0RKsDb0aOkhokqh91Hkczh/sA==
Date:   Fri, 26 Feb 2021 04:35:00 +0000
Message-ID: <BL0PR04MB6514239208CB9630B1D7B1B1E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-4-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7815d3bc-81a5-4607-22e0-08d8da0fe0fb
x-ms-traffictypediagnostic: BL0PR04MB6515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB6515F37BD1C26DA10A167EB6E79D9@BL0PR04MB6515.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8z8ZeC1YIaEicFf5AAndaUTdZKzyyVLP/YsKSf5Vj9ENPcQ/2o9LTITz4sbRZUlYxfZ3sx4StBQVY/Sp9PDsjPyWNRWWa59rF9amY7XA7VZ5ncaK5p12xL8ZvsG5bL3iDf9aV0jVw8Cmx7HyX+csQJkAlXDWYuFGuU1o2lwGC4jpOEpENJJ34HUB4j+wDgVPVS5mmoDAXkya6tjsARi97ucOmY9tfH9fmivqhzwtSbc5GWcmQTB7KlasWxctVnrTZbnmGPIZnBMDnWZu56KnxF0S8hHottY7yNwf+WTBGdejwaWpDE0r4Z2J+NJopUo5zcuXX28uoVouXqVaKwP4GCKvQ96pX9Pt9lDCffhfuqDeUzX2wFJh4iyT9zFJJM6zl5Eb00lV4K0HB495aw8jvkMgVP8vnfUKcv2hyPR6Qetnm/4swLLWJnJyswoHKJxoDabt6mX24jfricecLosBm2MLbqkTsGHlM1czj8aUYICb5n8q4KtW882O/FsdXJy4Tc5ghiwl5Wax41nIleBDUhm5oZy9M1h+Vf8yPmyo+a88Is/1brQFIQ+RfuHWLs/w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8936002)(5660300002)(71200400001)(52536014)(86362001)(54906003)(4744005)(33656002)(921005)(186003)(110136005)(316002)(7696005)(8676002)(4326008)(6506007)(66476007)(66556008)(66446008)(66946007)(76116006)(91956017)(64756008)(478600001)(53546011)(2906002)(9686003)(55016002)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QkiuJxQ8Q9EnlBpRWW+a/IGmmnZnF7wPc3D6zG1EnamdI5XEEaAktmkKPE6q?=
 =?us-ascii?Q?fdA7pxLu0B+puN9X8vziN7Wi+2MNjuDoWPB3c9k1xYH+3ElQwTCDnY1m36T2?=
 =?us-ascii?Q?Ual0XLNuQ1fCyPrsNEcxp+D/RRWpj6OeLS6Xuli1KQ1hm1QXp+x+jpoG4hYc?=
 =?us-ascii?Q?RqTBde1S+izzrTxazlKqWOOyVMGWTZggLrloNTC4JbWFJQj/SkGzvVH25/pU?=
 =?us-ascii?Q?GKfyNTlVvrt2bICbnxpuuaq4LZ7O2xFmjpqrX3Z0OSdwp51WIaFyyvA2cDeK?=
 =?us-ascii?Q?td+LF6DG/xgMHIAMSSuu3xrskzhm69m4/ErMxgNHF3dOwOGCa/vg+YGFlxre?=
 =?us-ascii?Q?e9EfgtaOamCKPLvunz2wOwpIK4oOVfcvp7cSxtr8V7FBlpgclNTR8Iiumc19?=
 =?us-ascii?Q?lLtZlOtCJ4zNUcUCNWd3zqPnnLPlrBZoDMGJt69PHMp2TKBKJ2pnlU2dsAAn?=
 =?us-ascii?Q?1sEdGuVgNPRQ91gRNZ5C/ugyF00T20EI5kndkvMjuMU4bofCfNoUyAAj+Gsq?=
 =?us-ascii?Q?RFpzRZ307AoHqyHw2PPKKYC7mOT21WDkm5NK5tI8TuhavRaWjaCqJSJ+dS36?=
 =?us-ascii?Q?KDNdoz0wQFR/9s7itoKHrBvrHmAr8+CltSjvTJ5dc6ZCxBsB0NbjZSJEPI6b?=
 =?us-ascii?Q?mt2GYgHgo0PRhK61TIAjPJW5DrNFnI/iAx6vANABhQsEZtnJawkBeOL9xg3t?=
 =?us-ascii?Q?f//7minepzDLTVHcMCegrgovkurX/6/NG0ooKh6Yv7HDbuZd5vZmBenEDocK?=
 =?us-ascii?Q?6Fn2qyBQSC2bJPpuGVMLoTXL9P9+uXe60HRhbfPSTNrPfrAAe9D+zU1JzIer?=
 =?us-ascii?Q?TD7EHWKXoYuhr8oh6NkTUlL84KDfDbNLyDg5gawHx87/vPhijFF23c3W5ALe?=
 =?us-ascii?Q?VOX1jY6PTXJ4h4zhUcaoDe60LXYPQQ1YfjLNWu1vsldJQD4chtv8LE0mJ+rk?=
 =?us-ascii?Q?wHSKfmtj9+i8aO+bOLhIKHRylmZ7U6SSFImIKyW9nlqVt+wF1Vf4rObP8NJK?=
 =?us-ascii?Q?hCh3rH+7oEfkdWQTqjnzBZIPl4eIvfVzmsoSwsx29ZuJqiAVLLTq81RaHV67?=
 =?us-ascii?Q?cCwXgME5ckjREvZA86oJXJhSKhlQkNOQlGStfqfVAJk7mfpA0STk/t/f2Ld8?=
 =?us-ascii?Q?SBDMSxOvEZLHmvBeq6hHRyCAvclC+os3gbvcExQM1GeRQsG1P6DzFWo48LKK?=
 =?us-ascii?Q?JcmKdTFt+pBkbYUWcYv0V/hPcGPmhRGUnkUJoq69p3rrfJIHK4pOLipI1Co3?=
 =?us-ascii?Q?PEwiNAcnA47aCCn1i/qE3jOIxltc3RWsBeehI2Jc75LW9mkjBbSFtB1cmtNh?=
 =?us-ascii?Q?OhhZ82foOWSN/SwCFvTB4O/1kvVZnfT1FD01UV4TyDw01iH+ikGICxZMYeeN?=
 =?us-ascii?Q?OFMq9dWrjt3FYUuqMExpvNOjnMw6HzMqwanrMfB2VXthVfL3uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7815d3bc-81a5-4607-22e0-08d8da0fe0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:35:00.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AE3EoX4iCI1cTxLKYOw1dgtYGsAJ2BGRxXndzWqWVhdBihl0+BqUqao8kiIG+ZQLzCyhPovheMLA6lektILpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6515
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> Update a struct queue with block trace extension.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  include/linux/blkdev.h | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index c032cfe133c7..7c21f22f2077 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -533,6 +533,7 @@ struct request_queue {=0A=
>  	struct mutex		debugfs_mutex;=0A=
>  #ifdef CONFIG_BLK_DEV_IO_TRACE=0A=
>  	struct blk_trace __rcu	*blk_trace;=0A=
> +	struct blk_trace_ext __rcu	*blk_trace_ext;=0A=
>  #endif=0A=
>  	/*=0A=
>  	 * for flush operations=0A=
> =0A=
=0A=
You lost me here... why is blk_trace_ext defined in addition to the existin=
g=0A=
blk_trace ? Why not extend the definition of struct blk_trace ?=0A=
=0A=
And this patch should probably be squashed into patch 2.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
