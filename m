Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B77325C9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZEh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:37:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28158 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZEhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314245; x=1645850245;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O8eePrWMU0apoq1yHTgzBTI5ilL5nQV1FUMj/bF3CE4=;
  b=N8hSuy8kC6sT1dMhA1/8qkswIzPQnzYcxHZ6yJiVM6mc4p7D2VWNzcx2
   LxyRLEFj3C+XgNNkGwLD46ZjTa4Lv7KoR8NbGvVN52OdgSjnBrFcMMj1T
   cLevV+AdRgfzbRi1U6B9AK6davgsawH15Qxm0UWi+HviPWi70HMFd+xYx
   5d9F7x0BtiKQHcuEAUcnTnbIgU5GslJaAn4sXZhz7F8aVaBJLuWfcd3Nz
   9w58SRuliw0zoiwYNesWiQjBb/32wLWfImsHo+a6TxYPM5zGUzUUPxl1F
   CKJgK7rI5i9xIKxw2WkzNB8KIRZK250TTD8kA/TLMz8WOpvLpAb5X69pI
   A==;
IronPort-SDR: x1zZJCP+424ceJbwInLupDRvfedzjRfRsxet+cMx7Jua4ACabN8jS/IWsAbceGSTfjl62mv0JU
 IPFPEy059Qu3bVWoly+x1q+FKVwIDDurLj/eCTm49/3EDGJdpKo/33BjcrH3Yh56KvjgqPmduV
 AyIYL5F5ff0nDsB4hqI5wTGZJ27oQ0cbuZLApzNr9l+rF+E9aHZv6XvX9HtoxY3yboLeHk9SQZ
 r+P7QZkIH+axh7S2n8UDeHmhqkRO7DcqyTK+UK59BAuwES+lFzaj+I0Hg/S/zcEIFuVcrwR34+
 ooo=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="162024150"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:36:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezql/Nas3ahVD7r+cONlBe8LkM8r87lfpNgwcnug1PStOznQ0ICmmgXQwByXxBmQfoST2CngkwE7LvGTCr3DytKs6FKIJTj4Kzzham/tPCfq5TmjiC78FjHF6HiSp+3pv0bL1UjPPRQ/aGqYXLlinVRh2pm3Zu+cQibOFkhgBPBBUI5p0zh+tn9aOJhSkQaqvyrcjgTIMqWXlSxjg826n5k+qswQ3BxIWnKjeY2XKCPwAgP5H4jQq9yKL7DQJj203PmOP4Jvu0v9xvhqaemK87oDzGIbYUj33i9q0JZQ4rdJAKwhgFYqY4U7KoIqyU0tdjldwVLMV+ibyS6p2BU30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox1coCkPM3YoiuwPXsW9GSJM/TGxKQrWgN2sezEiWdc=;
 b=bd63YpNM+GeBv1IbrS91zBF6RN7tsEUlSOn5C7E2qFDtG3DQiGbU7Jefn2Vw4BQo29OVxIs0dhZkq9W1aloK+EZWJsrk6YbLnKUfMYX1GR5AOtXYxCdLgpb90a+wR2sNZBMtPs9jY3tWyVZQtHOhrfwGrMk4eSaNU8+XZoohoYRx1CUGA6A3FgxPHUnJ1GcyR7orElB0uB6G2zDfv+/VL7SM8xgs1CikZXSHKjXvi2If88S9FClAGfhkG/tF6L+6e7f4W2sOJdjnmo3WqB3wLOvZNtXOTmimkBGKmZ41T44OpWh9VHL1NciY64HVEfh3vOFndtKHmK4M0IHVjbITNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox1coCkPM3YoiuwPXsW9GSJM/TGxKQrWgN2sezEiWdc=;
 b=OolE1ejM0fBz3CUirbeXMpguq0noxQ59y5e6osOE8dHW6lb4gXJjF04RJYE0aDzvtDINr/Ba1axtdMHkl5qeW/PQNcF+bzJ1ajtkRdVtdnMKM0OnuPrBXNZZIQYgPW9jCCPt3vU0MOgOMrwpmlsFAA1+6hMM6HB+8Ar1Hwk9coQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4531.namprd04.prod.outlook.com (2603:10b6:208:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 04:36:16 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:36:16 +0000
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
Subject: Re: [RFC PATCH 04/39] blktrace: add a new global list
Thread-Topic: [RFC PATCH 04/39] blktrace: add a new global list
Thread-Index: AQHXC0RSGk+APCgsrE6Jg5j2BlV9Lg==
Date:   Fri, 26 Feb 2021 04:36:16 +0000
Message-ID: <BL0PR04MB65143756FE0FF3E7F4875C27E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2bb859f-4e71-4d88-393a-08d8da100e1b
x-ms-traffictypediagnostic: BL0PR04MB4531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB45313823B6DD7DC1DE07F3F5E79D9@BL0PR04MB4531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkqVYC1+0blA0zSE+dgmySJaYtrBMoLViYi831KWt+okHgTctbwvpcd3EVAXoVMqSellnamm7HEdwYdY1yQB6egagBuqpcqyxvPSexqeOYNpY9AH1Us3RI9ESt/ou07MsHqzh3AuE1RGvwBylhQJBBAQaDFB4z9sqB+YwCTLlO0+lVykIsIxXq3+FEPQlLWBzakLmhdN/6Zw4YCD6rzxXQb/TYnaB7qNIA6iTKgE0e34jIhNlYWxTfETpHdOoHkyNx2X50qE4TlrIOCm46cgvGWCT594TZSKdRWc0OewBZx2rlg3CBOlbLwj8QS/i+mdjGnzFW1V26I2hbCbeT4R2PHvaSDbIeCYbfaOzw+KKXIBjGwF8kV3k0wRAohmYSbRHN6S/YRlyDn//SVhlVWfCVs1nq1GCbhft4jgbOLasYF3p013tDFr+oihA2Rh7LyhkaUg0LJI+iuCpu+IK+Epr1AMFNYp+KcltT9/IOI6DCNyxbcR/R1/QDoF8QlET32iYEYF5eocxSblZkIgR1yFMe5PNTJ57X/glKIhzocoxCdFN19AC74FqMt/F9V18Coq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(71200400001)(921005)(66556008)(478600001)(66446008)(66476007)(91956017)(4326008)(186003)(8676002)(5660300002)(2906002)(4744005)(76116006)(6506007)(52536014)(7416002)(64756008)(53546011)(316002)(9686003)(8936002)(33656002)(7696005)(86362001)(54906003)(83380400001)(66946007)(110136005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XRhOsByru/F0n+nc1RAtXdfH+tGpGDQfh8hQ0nIsWYKFyiKMWRh9Fjuywcu6?=
 =?us-ascii?Q?2PS648hyslGxdEZ8iMqbdD92fOYBa6xUAqDMxyi6Za7b2x6SpaZrZANgRCFv?=
 =?us-ascii?Q?O60qE7c/O/OyXe8LfpvxBBKdtL6+YjvGXMLD1ta5Aja+x3Xo53tBlUPa9iu6?=
 =?us-ascii?Q?AuHNRjYNDpwr+QE+GoyE6UqfBbahkGsumbFFZ4VyaPe6uXwTy7dEfw4LWOk/?=
 =?us-ascii?Q?X7nzHSsl1G4DVHD0ez3rnujYOrpagkENGTnoEF5R1J2bhFXVKCbjZcWC6S1T?=
 =?us-ascii?Q?4vtl+bDApVsWg2oG4d0ZcIKnza2yePWXl0ow7tDe3IodBaeYERcUjDmxzxgO?=
 =?us-ascii?Q?D4B70fsPR9aRzBWkk1XGP/B+ApENZO2oq9li+bY9+YoWA49FT1qAmE3A2T0w?=
 =?us-ascii?Q?vXn2UiWbPQO3M8HAf4ByD1X6iQPNSOuZubZPB7+rBwfTzc9To4B/ohdcBIX+?=
 =?us-ascii?Q?KjsEUczMhzUKx+PNTG9SAdXoZoOV4pSg0gPHScgfjya0KADDvUa25/DDSHfJ?=
 =?us-ascii?Q?X63cQkuzVAt4K3wthRedF0ywpbHBM/AyiJHGaG4D5Rfp43K0nkVsZc1pT08n?=
 =?us-ascii?Q?kbYisfkgUOIRkmzJcneJwKsZsb0tGfrF7x/47NPiCfVUvEqDbiA1JMXqhwB/?=
 =?us-ascii?Q?35LSDD9R1iiSEFp2Yt5hyn6RqIOQJzJmuCjYgNcguDvzaVt1hWzPFBJARPCg?=
 =?us-ascii?Q?V2uPcnXCcskLIcytApJ6h/7J/gWgrmaTVGNc0X/HMkBkDVupOL1i6Oreo82X?=
 =?us-ascii?Q?JkRoDRSycj+66zX1f9QO9es7jtV4shbXDZKM27+7CSm8SAJWlYqEWh/rM+ov?=
 =?us-ascii?Q?XNA5uE6kIyORRjmDEoHlK7N64zsVfEn38f+WT73O0GeAEzKLmajo95DefxdJ?=
 =?us-ascii?Q?zxtmJqHHMVhqTLR+KxaVzM55wTRKm2j5XlwHgbjE4i6peifIFTO1HJpxKJ3L?=
 =?us-ascii?Q?zMKu+lj267n0+k5ux3HwgRqWIBYN8vxsWRJcHTBgGRmM2xmjRBC2ykTG5/0O?=
 =?us-ascii?Q?+RvCBhUFWubhQ9i+mYbLuDVRZ1KR7FFSeouZakPwL2L6zGuEgkZxDx2LkRFB?=
 =?us-ascii?Q?berR1EkOjPVTNQBMlBh297vyUEh2oKgCMhEbDbgiuO+vyzEN2L23yX+Sla9A?=
 =?us-ascii?Q?UaEDjBEcHA36MYlcQtb6Y4EAi+Pad8Gz5j91r6h1OLocz8g9O23Wm6fvNDqi?=
 =?us-ascii?Q?PwBeUcfKeKoBkzEPljP20NaOrzLevlHpPW/PN2jSrLmn+b8iQQsPRF54wLGS?=
 =?us-ascii?Q?LebYMG9FTIbqpAPwSGirnvqCn2EqsewR/fEA4+C/q5F+9eOAxjiEbZpjdIuW?=
 =?us-ascii?Q?HGvBOFYhvTkdsZl5pa0/AdPBZPf+l0tcGfLhHpG7oAKJ/sqZ4sIstsreUrfu?=
 =?us-ascii?Q?BoCWHo5nKDikinbhyPhrNZI3u6Het686n4D5tnXL9iTsUWlHhg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bb859f-4e71-4d88-393a-08d8da100e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:36:16.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peohRV1HSCSTTIMgbKKIzjyc+yNNgBTb6pjsFJ9i0P1vYAm4Tx+Vq1KhSUXWDzO+vgpjvjhye0Z/iApTYnUPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4531
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> Add a separate list to hold running extension traces.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index ca6f0ceba09b..e45bbfcb5daf 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -36,6 +36,9 @@ static bool blk_tracer_enabled __read_mostly;=0A=
>  static LIST_HEAD(running_trace_list);=0A=
>  static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);=
=0A=
>  =0A=
> +static LIST_HEAD(running_trace_ext_list);=0A=
> +static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_ext_lock=
);=0A=
=0A=
Why is this necessary ? This is not explained. Why cannot you keep using=0A=
running_trace_lock ?=0A=
=0A=
> +=0A=
>  /* Select an alternative, minimalistic output than the original one */=
=0A=
>  #define TRACE_BLK_OPT_CLASSIC	0x1=0A=
>  #define TRACE_BLK_OPT_CGROUP	0x2=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
