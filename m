Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD91326ED3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 20:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhB0TxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 14:53:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59196 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhB0TxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 14:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614455587; x=1645991587;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M/OLRCty40J9XFievtDFl/OAh2hzJg/YIqHGT8J+2j4=;
  b=Tx6pcvrHxb18ADYWWzuZzAl/4z+HKsisakb0T0KPurdNf1yh3x9FcFF1
   NMxuamF68o8w/PyiqHIJRrEdWZL3Co/LkOehPvwTpPUwT0i6EVx7oZJEO
   W683uDvkOt8IWnRTxiTBveWxu8U+LODZqsS+rajNZdgSYdvES08w8TNUR
   sJ1u4VJRPvEPW6Y2T2wVUx2UND3TjTOyowQy3aOuwPjM4pv2B63eGU5VP
   XqJvZ4r+p+O936qAjo+WeIFftra9RnHeOytHeim4+JUZ5cIQseans+511
   8Sjyql+9sgpPo8zXzQh5ZWATZxMPYnQgeXUSdgHCEybCOv6md6XW216VJ
   g==;
IronPort-SDR: YMQ30CfEgG85iAvpEFD43tCgsbCXchP7vwdHTHQ5666SLDpeRZ/UBEyFxGrPO+Qw0fufbV5+UC
 eRhz5Gjh0m4JEhwnuGxZxN/g3jeSc4AcHdQYMOBSQjrbiqjPuvOug63OTopqClc+oQU9HbFqGz
 AY+DEMBWK3V5zQAz3LZ2PTY0l9+i2xEgx3kLBvinKoOl4npxiyK3G4Gp72eNZu06XGm0Ef4MhE
 stfX5gpyWJNw4nQ0JL9Dz5exwjTvXZ0cwY/86a1G6Qwurnub6Z6+N10358T3F8WUlwDtUrFPBY
 4nE=
X-IronPort-AV: E=Sophos;i="5.81,211,1610380800"; 
   d="scan'208";a="160983789"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2021 03:51:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRsmHZM4R4nP6OnBG/O3zoAMSAW6oL8bPoOcVGIMMtfWp45lRGluR+1ffJaQJVxthap9nw9eRhVuzqSLK8ph3b250rYjFWqjqeqsku1jbEXZezdG3N7FYpL7xyfLhurCPgVA4vta3hUDi8HlWziRdrOel1Ccl+w1niqgk4b4Bu5nC830X0FrbHclQCWLDSPlGWkDFmVd+2QYiuF+TWNtcFYJsq4A2o3KYfA3v8lmKXTTNYqsr11mf5WjSg5KD4OThm5d650hG9qcEcpe5Iwh479DPxj3+VOxrojFhMy4Jhp0A2V88q3YT9QyzMITYsvSGPLZRf3HMna1cRqa10CnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD52JyNGpBwxF8pid88g55E9WZwyWdto2E8GSk7ZQg0=;
 b=hDNnaRNutj2hxqx7BG8cyjGLyGIYIOdm6zvfcqxgpfjidZtsiQE+SEbjw1D3RQIJN4IYb+RRPIGpko+zUATZNYnFh1FPV/qflygQPUeHYs3tAAkZ8OL0pOr6/SbRSQAWsgxqLL/IOalBVLWtG88+sYdYO5ixpHGjCYo2YZiHLshkwp5UPsg5wS2f66R7g3mDV5+otlqKLptIXAQXAljls8jDfExLXFSlOXawtDuzS3xSBkWTrp0weUE+rvOkcWO8+qyIJOuxNylYuibi/DrLPtlRwm8ttBgiafKQJKnKIKujYtAjUg8JpuDUB0Hc4XKOq47ExsYoNxKJqUfcqxF4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD52JyNGpBwxF8pid88g55E9WZwyWdto2E8GSk7ZQg0=;
 b=j3IwVCBpoXJXKw1MbVMJB6vyFA7ygPhaQDnview0OmZkdabsouhG8nR2rfp1uzv2gs4xa+wtKJnj9/GAq4gYhCemII4eSbikrROsFh+GglW7Mmh0PAlKiWK3b4t4opzyJQEciKbEcH0pfKzbfykhs5uPYu7k14b6/DuxL5oU6Ds=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5893.namprd04.prod.outlook.com (2603:10b6:a03:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sat, 27 Feb
 2021 19:51:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.020; Sat, 27 Feb 2021
 19:51:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>
CC:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [blktrace] c055908abe:
 WARNING:at_kernel/trace/trace.c:#create_trace_option_files
Thread-Topic: [blktrace] c055908abe:
 WARNING:at_kernel/trace/trace.c:#create_trace_option_files
Thread-Index: AQHXDUHnzYyhD4IqkU+G7Zy6VLI44g==
Date:   Sat, 27 Feb 2021 19:51:14 +0000
Message-ID: <BYAPR04MB49650C1C244E99AB1FFC590E869C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210225070231.21136-34-chaitanya.kulkarni@wdc.com>
 <20210227114440.GA22871@xsang-OptiPlex-9020>
 <20210227094916.701a8a50@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c8c3ad8-2467-4922-d8a0-08d8db590a28
x-ms-traffictypediagnostic: BYAPR04MB5893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58936CBB15D007064D7D997F869C9@BYAPR04MB5893.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NL1Zubj+mb4wElhqgSIwRCX59CpbGsnc3IrWY5F88L7+WFDs2m2+kNcTD8fXRablpAOa2qfumUjxOkIltMQasYmSwY/8hissCO7AoYtwkNmgQJoS1kbvHXgteD5BZqMePfH5xTweOqQT55ORna4yURu7QdmoydvoZCBUr/zHxQBpTytb1fvH1Bl2MU8IFs4WoYMNtRH0jqzPfyE0yncubNB6Tqb5EDtsyA0hY7ycwYr4opklsecIUhKTItqb85jaT/VBjW/mdXev5W0e0OJQEhHf+yviVZZc1DqoWaAJu23+KQD+jeX1IIkp385TpUKZZoxODuCJ8jOD94bI1rDuZpSQ+IMQ7g7IsVHfHCaQHZyyYY3ze4zHimLUecK2O/5aUclhatWwO5Eq9riA4vKpXrayfo9LQrlE8OZq9ogzLOyoAGx6YCF2LpOCoK6gh5/tAkUe6VezGgwC/fJVFnqe+mYW9CGXYR8rVexQEsw8zfIZvjPrjtAHcc+TjnYpXYT1VyYdfC5zY5FRcQYSRRryWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(5660300002)(71200400001)(45080400002)(54906003)(7696005)(9686003)(8676002)(52536014)(83380400001)(316002)(6506007)(33656002)(86362001)(91956017)(55016002)(186003)(26005)(2906002)(66556008)(64756008)(8936002)(478600001)(53546011)(7416002)(110136005)(66946007)(66476007)(76116006)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MuzTfOGSGqYqOIisft0JceIVzuDeX26p+MBs08+1aule6SA50dt/Oo374j8k?=
 =?us-ascii?Q?wRuUM//qkLuGovWzwCIxetb1ADInP00CiziQKdhx/woAn4AA9zgO1nOBwB+h?=
 =?us-ascii?Q?IC4LkIW0pY4Y+SI+dwa9nQSPe4xSfbUT9gI1GPBfrfpJfCvS2AW++qYLIU29?=
 =?us-ascii?Q?EWw+XvP0RyehVTFjH6EB77kTAkbNxBQMMz2GH4q1OIIE+PXEweHr7LsVE2Zi?=
 =?us-ascii?Q?SeljuG+tT6HTJPcDJ4AB6Xy++Qu5E4sknWWqL3YqsSS2LXAYu+BYyGduS7un?=
 =?us-ascii?Q?/MvoIC6f6JVbbHY0b1qRFpCkLLqQmqc1xTnxzRZeph5gVJbRLx7if/qVIJUL?=
 =?us-ascii?Q?5uvI94phwh40faSL14t704KVhM0E7eC2Z+nymkU8reIhWfhIVmyBLusarwV9?=
 =?us-ascii?Q?O0efyHQEwzmQZfHGVttaQO09i8nEiUzyt1RZQD6UKB2urehIY8frMpIYbJpi?=
 =?us-ascii?Q?0v1UsL+5NPOEaX2liPtgBJ/rD8jYHLkojviVa57cqivtk2IA13jclV0XHyex?=
 =?us-ascii?Q?dd1ds2QALi+8+pUEpH8Cm900IK1YMWykGn/eN3p06dLQYFik8n/pPUCt9+8R?=
 =?us-ascii?Q?LFU/r+2ooyeb0BFdIMexjimmH+Jv0CWfMOUcMpSDrcqJTqxlVABYgop8wmGI?=
 =?us-ascii?Q?jqHZTxSUnhAweLOVk02RKuRAXTQVVETBZxMdRvOf29TMeRVwfgDc2KGZuiJS?=
 =?us-ascii?Q?Fb9O0JCtnpPMA4SgKEINWzcvEr/W8ZFCrgzSCFiZetYOh5VR/Ztv23FkHgdm?=
 =?us-ascii?Q?RNwALKjNHOts7iUbmOiXp3f7j2B1n4Id6rXjzS0EbESbUTAfN0sCKF8NqlHj?=
 =?us-ascii?Q?w7Bp2nURJgXbXjwqp+SiHF42WPeroF1NfmeE0gEhG+QKrt5JqfMtkMAJ/nxE?=
 =?us-ascii?Q?rxsljRMYSHU7sJxI0PNLPfkKM363Uyl4fsm4txdIm1CHl6oSgWVM3Yy0BIWn?=
 =?us-ascii?Q?TXWkbN7rPPU97BIEpINjeQsoVls1URECgAwq+zCAXGFfaNabnJ+N4S7TgJcg?=
 =?us-ascii?Q?ZxlbvOjRAwKRsrUGmS+hde6tzpJBL9G88pFGTziA/rZiY9BNPkrMmn+br/yh?=
 =?us-ascii?Q?zU0w9w5KCVOfXW+QeZT7+/kQMwkgxkEIh1ykSsvBtJsW9e4F/0B9YWemd5ao?=
 =?us-ascii?Q?exLOHSWJNYzoEsmlU18Xyjej2kwJYjralZFK7Ee8CXtxilQmsGvs/Eocsieg?=
 =?us-ascii?Q?lClLsS04WQlWK/rWcYUpWkCf2flrqGKxh0o1+BMoGP7H2bwy02u9bnYFVprd?=
 =?us-ascii?Q?/uda34L4mqt4X7QXK19e9grvowho8mFpmpzOtdSnrulkEJSZfOR3jewYGUkc?=
 =?us-ascii?Q?pIkPHqo4d06TplqFVq2XAscG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8c3ad8-2467-4922-d8a0-08d8db590a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2021 19:51:14.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5G3N9bmR9EOAXcuQCfs+7pVNqKjKHqCjctMYtP0529oUjN4myC7X9Cljq1mdfMBOxEPejRI5LwvlD8ESeJRB0g8pkiPWWhH8Oa3thl1AUCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5893
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/21 06:49, Steven Rostedt wrote:=0A=
> On Sat, 27 Feb 2021 19:44:40 +0800=0A=
> kernel test robot <oliver.sang@intel.com> wrote:=0A=
>=0A=
>> [   20.216017] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:8370 creat=
e_trace_option_files (kbuild/src/consumer/kernel/trace/trace.c:8370 (discri=
minator 1)) =0A=
>> [   20.218480] Modules linked in:=0A=
>> [   20.219395] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-09341-gc=
055908abe0d #1=0A=
>> [   20.221182] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.12.0-1 04/01/2014=0A=
>> [   20.224540] EIP: create_trace_option_files (kbuild/src/consumer/kerne=
l/trace/trace.c:8370 (discriminator 1)) =0A=
>> [ 20.225816] Code: d5 01 83 15 2c b7 08 d5 00 83 c0 01 39 c8 0f 84 c7 00=
 00 00 8b 14 c7 39 72 44 75 df 83 05 10 b7 08 d5 01 83 15 14 b7 08 d5 00 <0=
f> 0b 83 05 18 b7 08 d5 01 83 15 1c b7 08 d5 00 83 05 20 b7 08 d5=0A=
> Looks to be from this:=0A=
>=0A=
>> +static struct tracer blk_tracer_ext __read_mostly =3D {=0A=
>> +	.name		=3D "blkext",=0A=
>> +	.init		=3D blk_tracer_init,=0A=
>> +	.reset		=3D blk_tracer_reset,=0A=
>> +	.start		=3D blk_tracer_start,=0A=
>> +	.stop		=3D blk_tracer_stop,=0A=
>> +	.print_header	=3D blk_tracer_print_header,=0A=
>> +	.print_line	=3D blk_tracer_print_line_ext,=0A=
>> +	.flags		=3D &blk_tracer_flags,=0A=
>                           ^^^=0A=
>=0A=
> As blk_tracer already registers those flags, when it gets registered as=
=0A=
> a tracer, and flag names can not be duplicated.=0A=
>=0A=
> I could fix the infrastructure to detect the same set of flags being=0A=
> registered by two different tracers, but in the mean time, it may still=
=0A=
> work to use the blk_trace_flags from blk_tracer, and keep .flags NULL=0A=
> here.=0A=
>=0A=
> -- Steve=0A=
Thanks for the reply Steve. This is still under currently discussion and=0A=
I'm still=0A=
waiting formore people to reply on this approach, if we end up having=0A=
this as=0A=
a part of final implementation we may need to fix that.=0A=
=0A=
>=0A=
>> +	.set_flag	=3D blk_tracer_set_flag,=0A=
>> +};=0A=
>> +=0A=
=0A=
