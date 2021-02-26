Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8711E325C95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZEcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:32:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64617 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBZEcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614313971; x=1645849971;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/tPzOpFXA/jqMkfETCsENb9ShOjM80YBW++GuDnjtN0=;
  b=D5l2Z0xxZUqFSLPel5tV0z81Jbd7Iv7qkFEanSH91fcWBsEK6nC09OJM
   QuyTMmOtSMRVR97E+tw+sCOvzFKdZBUvznquKD2dLVTlRqcLJx5jx/mQC
   9FgYxtuwyLWSpWBek4aR0icMy/H8tKVrcF0f58cg0XnLqvQWZ0J2bA0Ev
   2kS/8BHBbuOTRYtu01Z3lhvk7fgWwkqmYqGno6raMUeWoJugjSpOLr25y
   1UyVk3I5cDRhQuQU4Lq5JxJ9uuaRFkJ5wl5eI0OYYwZHd7XRKJpxwWRh3
   gnQPc9aMMaqCFAM89vSC4ZQZC/V9TMz402+BXFoQsZOTm3+yMs8cXFT4l
   w==;
IronPort-SDR: 55feQ7K9iqW7MrJZaW0s5qxfdM5K2SIdnb//4LLGO1QIr3PFWRMMDBL1ApqvmY1N1GJH3Z1xkO
 kn867GsD08YtUKl6wK74P9rZ+UDHxuhgVv39xUhfL2pNFUkuxfEyPLhwZESkbQGZQaNSQ70Hwc
 qD90huLOP6AvE4i5l+Go5pOv9m8jcPxtb0VXN2TbB8Pwn6YHuUG6JBrMKfqDRmN31l2EwNunWt
 o7yvffdqOx2XfnQH6P00pM/L0tA0PLJlc5Q47Rz441LJOHjkJ8m0x8HfMuT69XQMG6UymvCOBr
 I7w=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="165341396"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:31:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEgFpP8s4HwlLPzZnWzFNqaF6obfk5Ds3vKv/ShchzfBLmJhvqgie8oBw7hzip1u/7knc6RD5s62H2ssJQrmxFs4VaTska6W0ytZRLDl4nOE5bs0ry2bRyCPol1tGPYyAnypFC29xyCXxWNtVjN/DV/YxzoodzmjrzZ1DZ4vIVZPyeSSh522eQwO2CkChumSTKhXIWoMnpfav6ke0kg4Z4SqAMUuxEmEN4pRYYDxIu+bsrdmmOjodeZV1qLRmbWLNqbDLJleq/wnJCSIsDWedfZh2AWoLJFq5IB0pmaOFJVj5dGvlKywdHFRBWnFGKlf1cq1nfSgiIGV+WdmDoNT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ezzqdWjIiR05D8xRpJYtzy0a5KKUMTyWJ4U6FFAxzU=;
 b=kiuCvZrfnvShVnuPukk8epmk99gtazbxE+5eJ82pUVLzLeQL4JEhrFJNeqcAp3vJj+lcPnFLI2evXfFDQvvMA1T2PXeYeJMhFkygCCmQTJ6w2oaugml6IMT932p5Rm3URXww316fdyQnZT3bdPPNsaFi2IDTztGVMd23rdU8VO7cmPJhdxEEIcRvJnKa11WIvV2iw5TEjJe9NEazhLBBMw2pOsfgO8AvaLQDoMolwX8MFIFP/oERpCa9wOIEq6wI+KIHIF1RNIfX7ZjCU9ot5NKMfwp72xKZR4YG33sFCMRaBsskk+RFu4tQFzGwFIjH8nrOf2zSPTGgRSrq4Jtv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ezzqdWjIiR05D8xRpJYtzy0a5KKUMTyWJ4U6FFAxzU=;
 b=WtvIPAL7LMsYCWEK5i6xjWdF+/S27MJ7ODUnO1fDTAOVvmfMnbbm2fz8CLAxejn8NtzkZofDHc5QLLZxDT7qS2qE/Kux7rKQs2Dllf0kGZpSbWfBBvbV/94H7HV2SND4Qu5Pnx7dSgYBokzpnWlsReg+zLtOo03v8lZ7FrPqLjY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6515.namprd04.prod.outlook.com (2603:10b6:208:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 04:31:43 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:31:43 +0000
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
Subject: Re: [RFC PATCH 01/39] blktrace_api: add new trace definitions
Thread-Topic: [RFC PATCH 01/39] blktrace_api: add new trace definitions
Thread-Index: AQHXC0RAvdMrmmwOD0C0bI6zwgAdXw==
Date:   Fri, 26 Feb 2021 04:31:43 +0000
Message-ID: <BL0PR04MB6514BA0F684350C024850AC1E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42e72305-3994-4919-8b45-08d8da0f6b9e
x-ms-traffictypediagnostic: BL0PR04MB6515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB651553CF85823ED2AEF49573E79D9@BL0PR04MB6515.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EMZ7IZKFU+GjmbysvBvHMj481LVlJ5X22jxIL//ocj4T9HSYZASCutVysE5UBhynJ1X+Y9mw/BvDK+++DhJ6Hs8GWHP6nAb/RF+NBHG0hXsr4KYKoy4/hm9Hi7u3Qrq2sgVQ5p3q2SczcUAGZgFO/49935wULtR51iXLvHKuswsU7X2gBwfheCczsBofp7CVm67T5DhjH6mido8RcfHzNtQRoQusGTg/4E+5dOVsG9Gk8qkZijXqL/CP/MYF79s0We5Pv3yiWXoHfuzyVaG53EH61t9PS1Wb0TtdpcWJRihj0Ew7cHgUU6mCTS1ihYnr0KJFxCjSPJkYEHEjxHqdFlPM0jxduOZjiNQWW0cLzYkiselC96T2GCYcR0HkN+Aso4At+wDpBapOP3Vw17Q9DuJpBzN1rvbNxEcq+k268eSJTyoyAWPROE8nz/FlWJRu3IbBaGlTN43tdBR0beZ+eVPKMkXsySrMr3o6lOtbepUOSnebiK9PayDJytjUHeMECyvx+s6gAYw2w3nXy1OMJ+hd0cAAzvZJiUSrQyLMbxcP1IWZ3CGu9XNkYPJ1bRM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8936002)(5660300002)(71200400001)(52536014)(86362001)(54906003)(33656002)(921005)(186003)(110136005)(316002)(7696005)(8676002)(4326008)(6506007)(66476007)(66556008)(66446008)(66946007)(76116006)(91956017)(64756008)(478600001)(53546011)(2906002)(9686003)(55016002)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ATEatcuM2kYBmUJflUyl29/F7HKSndPwfVcj+A7+SIV3BCk793lMFJRKVoWl?=
 =?us-ascii?Q?AXkOdIkYW7jjKH2r/JExXl7YHNl1B+h2LYYsI6afMykNKmAxXyeLuoB24+ZW?=
 =?us-ascii?Q?/dY8QLmw/ceZWlEakc1AB1RQfGtd3a6ON4tKf5AESlUycNp6Nrh3IseLI5pn?=
 =?us-ascii?Q?sDZ7gVK8sFY5X5VlrlVVUhNxVO732nOfmqa9t0Et7WJpMbrH5CP4XA6CCNfj?=
 =?us-ascii?Q?STgbXaL5MhM8GZWfOslIrayneKwlOZB0b/vDihaCsjMOsfnZJglLJabWVNVv?=
 =?us-ascii?Q?ORu4AnakSLSWk5UOZ1f4OnTk2DGk3svv2iVOkR+kK+Fj9bNHBtdora14vhUL?=
 =?us-ascii?Q?kF0xoTSglGg8q6IoaJVPn+OUN4gsoQ/c6c7nqnyENr8T34+XticuUJOxpelX?=
 =?us-ascii?Q?X43vB9ikdAud9WlXW6au7bSSNNNcth7ZNtT0D+U8pxEVjc4esbQwvm0otkkz?=
 =?us-ascii?Q?MwJn4PvD6AxPf9oUWPh6basFa+BcvdS1aa9vwBZdo+5lVZB6UJ7vkhsulx0C?=
 =?us-ascii?Q?WCLolVXUwpHJFgMY2Wv94IwQGHIqeF5YcCd6YhJHVMVYPbr5IHjhbnqEcHgG?=
 =?us-ascii?Q?c5h6RD0e4/VP5FHs5LtsSvyVLvLnZYjsTytouFryYuUJFl7oYGWATgox0HHV?=
 =?us-ascii?Q?7rZS8DLL/ADeES9v8D9HDIsRz+uzvSEAbEZXPKsKT4IZV+QI8g2VuRsD5pwO?=
 =?us-ascii?Q?XpYzCIhlVa5DjBuetZvkiG/rAF5IptuEOXSzEy6FSHyHQsgMSlwkjfC2rLt3?=
 =?us-ascii?Q?4n9yR2JrRa+sml8B0UeTnpQ//Y79bfKD1/BiQZQLPXuUbSR2JVcpwmjNJYI5?=
 =?us-ascii?Q?1au4Q+pj+wxxEGP250Ci373yDypGV1xvr+JIsDOXP3IEVtFDJqObElsn/BnB?=
 =?us-ascii?Q?ikAVFwV3aRkhn09dn1ps1fGiRPC6PMMJhWi48Lwuo21vwWcChIeSavWRVxkN?=
 =?us-ascii?Q?RwZFPH9p1rfsk+PS35o2UMujRt9INUKt2nu5zXWeunjZCgUGwK+dLY+Sd18T?=
 =?us-ascii?Q?ZcR5td+h/oaZ5qRiLZZuXUwQsb68DgcMJ8IUkM4Db1hjKbjf7iXRzLfBoCac?=
 =?us-ascii?Q?4TpATiIDf6cWUH63XlESMzllnZjMg2BkK2MIoNhb1jd/tjljbHkUIfeNc7rr?=
 =?us-ascii?Q?JwvmeRCscT/dbyxJC7Xgnayvp/cwdUbHBMNwDhc5jgb8VVMK/SALpoqesZfv?=
 =?us-ascii?Q?TKHeuqjwQCKPIEDOMGLpQduDNaBPiwd28aip8Q7E/VvCWCwAAog3JxTOx/RW?=
 =?us-ascii?Q?uUW2Jq+3Erc+yVBW7xEPMlXLzSOKwdXJlscYabkoKn1Logu2ROn18WItpm5c?=
 =?us-ascii?Q?Z6HX6ea2t/WQ5WstOhrAOHc25hnVVdT+JK+pPvGvFlOaePlXIu/wh09X7iXL?=
 =?us-ascii?Q?evLTg2qgPf0IoQlTNPnBQGbKFH6DRwd0ZgGlzxSNJN2gmGIhgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e72305-3994-4919-8b45-08d8da0f6b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:31:43.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbQYOGcV0RK5M5FthorqUb7SuHOMhaFJz1XDlAs6OhbFNhdVQMBaSlMemGvlvECZluREO6pW5R8jjEPAvh1CYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6515
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> This patch adds a new trace categories, trace actions adds a new=0A=
> version number for the trace extentions, adds new trace extension=0A=
> structure to hold actual trace along with structure nedded to execute=0A=
> various IOCTLs to configure trace from user space.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  include/uapi/linux/blktrace_api.h | 110 ++++++++++++++++++++++++------=
=0A=
>  1 file changed, 89 insertions(+), 21 deletions(-)=0A=
> =0A=
> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktr=
ace_api.h=0A=
> index 690621b610e5..fdb3a5cdfa22 100644=0A=
> --- a/include/uapi/linux/blktrace_api.h=0A=
> +++ b/include/uapi/linux/blktrace_api.h=0A=
> @@ -8,30 +8,41 @@=0A=
>   * Trace categories=0A=
>   */=0A=
>  enum blktrace_cat {=0A=
> -	BLK_TC_READ	=3D 1 << 0,	/* reads */=0A=
> -	BLK_TC_WRITE	=3D 1 << 1,	/* writes */=0A=
> -	BLK_TC_FLUSH	=3D 1 << 2,	/* flush */=0A=
> -	BLK_TC_SYNC	=3D 1 << 3,	/* sync IO */=0A=
> -	BLK_TC_SYNCIO	=3D BLK_TC_SYNC,=0A=
> -	BLK_TC_QUEUE	=3D 1 << 4,	/* queueing/merging */=0A=
> -	BLK_TC_REQUEUE	=3D 1 << 5,	/* requeueing */=0A=
> -	BLK_TC_ISSUE	=3D 1 << 6,	/* issue */=0A=
> -	BLK_TC_COMPLETE	=3D 1 << 7,	/* completions */=0A=
> -	BLK_TC_FS	=3D 1 << 8,	/* fs requests */=0A=
> -	BLK_TC_PC	=3D 1 << 9,	/* pc requests */=0A=
> -	BLK_TC_NOTIFY	=3D 1 << 10,	/* special message */=0A=
> -	BLK_TC_AHEAD	=3D 1 << 11,	/* readahead */=0A=
> -	BLK_TC_META	=3D 1 << 12,	/* metadata */=0A=
> -	BLK_TC_DISCARD	=3D 1 << 13,	/* discard requests */=0A=
> -	BLK_TC_DRV_DATA	=3D 1 << 14,	/* binary per-driver data */=0A=
> -	BLK_TC_FUA	=3D 1 << 15,	/* fua requests */=0A=
> -=0A=
> -	BLK_TC_END	=3D 1 << 15,	/* we've run out of bits! */=0A=
> +	BLK_TC_READ		=3D 1 << 0,	/* reads */=0A=
> +	BLK_TC_WRITE		=3D 1 << 1,	/* writes */=0A=
> +	BLK_TC_FLUSH		=3D 1 << 2,	/* flush */=0A=
> +	BLK_TC_SYNC		=3D 1 << 3,	/* sync IO */=0A=
> +	BLK_TC_SYNCIO		=3D BLK_TC_SYNC,=0A=
> +	BLK_TC_QUEUE		=3D 1 << 4,	/* queueing/merging */=0A=
> +	BLK_TC_REQUEUE		=3D 1 << 5,	/* requeueing */=0A=
> +	BLK_TC_ISSUE		=3D 1 << 6,	/* issue */=0A=
> +	BLK_TC_COMPLETE		=3D 1 << 7,	/* completions */=0A=
> +	BLK_TC_FS		=3D 1 << 8,	/* fs requests */=0A=
> +	BLK_TC_PC		=3D 1 << 9,	/* pc requests */=0A=
> +	BLK_TC_NOTIFY		=3D 1 << 10,	/* special message */=0A=
> +	BLK_TC_AHEAD		=3D 1 << 11,	/* readahead */=0A=
> +	BLK_TC_META		=3D 1 << 12,	/* metadata */=0A=
> +	BLK_TC_DISCARD		=3D 1 << 13,	/* discard requests */=0A=
> +	BLK_TC_DRV_DATA		=3D 1 << 14,	/* binary per-driver data */=0A=
> +	BLK_TC_FUA		=3D 1 << 15,	/* fua requests */=0A=
> +	BLK_TC_WRITE_ZEROES	=3D 1 << 16,	/* write-zeores */=0A=
> +	BLK_TC_ZONE_RESET	=3D 1 << 17,	/* zone-reset */=0A=
> +	BLK_TC_ZONE_RESET_ALL	=3D 1 << 18,	/* zone-reset-all */=0A=
> +	BLK_TC_ZONE_APPEND	=3D 1 << 19,	/* zone-append */=0A=
> +	BLK_TC_ZONE_OPEN	=3D 1 << 20,	/* zone-open */=0A=
> +	BLK_TC_ZONE_CLOSE	=3D 1 << 21,	/* zone-close */=0A=
> +	BLK_TC_ZONE_FINISH	=3D 1 << 22,	/* zone-finish */=0A=
> +=0A=
> +	BLK_TC_END		=3D 1 << 15,	/* we've run out of bits! */=0A=
=0A=
BLK_TC_FUA has the same value. Is that intentional ?=0A=
=0A=
> +	BLK_TC_END_EXT		=3D 1 << 31,	/* we've run out of bits! */=0A=
>  };=0A=
>  =0A=
>  #define BLK_TC_SHIFT		(16)=0A=
>  #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)=0A=
>  =0A=
> +#define BLK_TC_SHIFT_EXT   	(32)=0A=
> +#define BLK_TC_ACT_EXT(act)		(((u64)act) << BLK_TC_SHIFT_EXT)=0A=
> +=0A=
>  /*=0A=
>   * Basic trace actions=0A=
>   */=0A=
> @@ -88,12 +99,38 @@ enum blktrace_notify {=0A=
>  #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))=0A=
>  #define BLK_TA_DRV_DATA	(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA)=
)=0A=
>  =0A=
> +#define BLK_TA_QUEUE_EXT	(__BLK_TA_QUEUE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))=
=0A=
> +#define BLK_TA_BACKMERGE_EXT	(__BLK_TA_BACKMERGE | BLK_TC_ACT_EXT(BLK_TC=
_QUEUE))=0A=
> +#define BLK_TA_FRONTMERGE_EXT	(__BLK_TA_FRONTMERGE | BLK_TC_ACT_EXT(BLK_=
TC_QUEUE))=0A=
> +#define BLK_TA_GETRQ_EXT	(__BLK_TA_GETRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))=
=0A=
> +#define BLK_TA_SLEEPRQ_EXT	(__BLK_TA_SLEEPRQ | BLK_TC_ACT_EXT(BLK_TC_QUE=
UE))=0A=
> +#define BLK_TA_REQUEUE_EXT	(__BLK_TA_REQUEUE | BLK_TC_ACT_EXT(BLK_TC_REQ=
UEUE))=0A=
> +#define BLK_TA_ISSUE_EXT	(__BLK_TA_ISSUE | BLK_TC_ACT_EXT(BLK_TC_ISSUE))=
=0A=
> +#define BLK_TA_COMPLETE_EXT	(__BLK_TA_COMPLETE | BLK_TC_ACT_EXT(BLK_TC_C=
OMPLETE))=0A=
> +#define BLK_TA_PLUG_EXT		(__BLK_TA_PLUG | BLK_TC_ACT_EXT(BLK_TC_QUEUE))=
=0A=
> +#define BLK_TA_UNPLUG_IO_EXT	(__BLK_TA_UNPLUG_IO | BLK_TC_ACT_EXT(BLK_TC=
_QUEUE))=0A=
> +#define BLK_TA_UNPLUG_TIMER_EXT		\=0A=
> +	(__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT_EXT(BLK_TC_QUEUE))=0A=
> +#define BLK_TA_INSERT_EXT	(__BLK_TA_INSERT | BLK_TC_ACT_EXT(BLK_TC_QUEUE=
))=0A=
> +#define BLK_TA_SPLIT_EXT	(__BLK_TA_SPLIT)=0A=
> +#define BLK_TA_BOUNCE_EXT	(__BLK_TA_BOUNCE)=0A=
> +#define BLK_TA_REMAP_EXT	(__BLK_TA_REMAP | BLK_TC_ACT_EXT(BLK_TC_QUEUE))=
=0A=
> +#define BLK_TA_ABORT_EXT	(__BLK_TA_ABORT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))=
=0A=
> +#define BLK_TA_DRV_DATA_EXT	\=0A=
> +	(__BLK_TA_DRV_DATA | BLK_TC_ACT_EXT(BLK_TC_DRV_DATA))=0A=
> +=0A=
>  #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))=
=0A=
>  #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY)=
)=0A=
>  #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))=
=0A=
>  =0A=
> -#define BLK_IO_TRACE_MAGIC	0x65617400=0A=
> -#define BLK_IO_TRACE_VERSION	0x07=0A=
> +#define BLK_TN_PROCESS_EXT	(__BLK_TN_PROCESS | BLK_TC_ACT_EXT(BLK_TC_NOT=
IFY))=0A=
> +#define BLK_TN_TIMESTAMP_EXT	(__BLK_TN_TIMESTAMP | BLK_TC_ACT_EXT(BLK_TC=
_NOTIFY))=0A=
> +#define BLK_TN_MESSAGE_EXT	(__BLK_TN_MESSAGE | BLK_TC_ACT_EXT(BLK_TC_NOT=
IFY))=0A=
> +=0A=
> +#define BLK_IO_TRACE_MAGIC             0x65617400=0A=
> +#define BLK_IO_TRACE_VERSION           0x07=0A=
> +#define BLK_IO_TRACE_VERSION_EXT       0x08=0A=
=0A=
It is a little weird to have 2 versions. Why not simply increase the versio=
n=0A=
number ? BLK_IO_TRACE_VERSION =3D=3D 7 means "support only old trace format=
" and=0A=
BLK_IO_TRACE_VERSION =3D=3D 8 means "support old and new extended trace for=
mat"=0A=
would be better. From just the code in this patch, not sure how this is bei=
ng=0A=
used though.=0A=
=0A=
> +=0A=
=0A=
blank line not needed.=0A=
=0A=
>  =0A=
>  /*=0A=
>   * The trace itself=0A=
> @@ -113,6 +150,23 @@ struct blk_io_trace {=0A=
>  	/* cgroup id will be stored here if exists */=0A=
>  };=0A=
>  =0A=
> +struct blk_io_trace_ext {=0A=
> +	__u32 magic;		/* MAGIC << 8 | version */=0A=
> +	__u32 sequence;		/* event number */=0A=
> +	__u64 time;		/* in nanoseconds */=0A=
> +	__u64 sector;		/* disk offset */=0A=
> +	__u32 bytes;		/* transfer length */=0A=
> +	__u64 action;		/* what happened */=0A=
> +	__u32 ioprio;		/* I/O priority */=0A=
> +	__u32 pid;		/* who did it */=0A=
> +	__u32 device;		/* device number */=0A=
> +	__u32 cpu;		/* on what cpu did it happen */=0A=
> +	__u16 error;		/* completion error */=0A=
> +	__u16 pdu_len;		/* length of data after this trace */=0A=
> +	/* cgroup id will be stored here if exists */=0A=
> +};=0A=
> +=0A=
> +=0A=
=0A=
extra blank line not needed.=0A=
=0A=
>  /*=0A=
>   * The remap event=0A=
>   */=0A=
> @@ -143,4 +197,18 @@ struct blk_user_trace_setup {=0A=
>  	__u32 pid;=0A=
>  };=0A=
>  =0A=
> +/*=0A=
> + * User setup structure passed with BLKTRACESETUP_EXT=0A=
> + */=0A=
> +struct blk_user_trace_setup_ext {=0A=
> +	char name[BLKTRACE_BDEV_SIZE];	/* output */=0A=
> +	__u64 act_mask;			/* input */=0A=
> +	__u32 prio_mask;		/* input */=0A=
> +	__u32 buf_size;			/* input */=0A=
> +	__u32 buf_nr;			/* input */=0A=
> +	__u64 start_lba;=0A=
> +	__u64 end_lba;=0A=
> +	__u32 pid;=0A=
> +};=0A=
> +=0A=
>  #endif /* _UAPIBLKTRACE_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
