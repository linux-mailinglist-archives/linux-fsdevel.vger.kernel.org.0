Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC1325CB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBZEtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:49:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36809 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZEtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314949; x=1645850949;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=B2b2HeYc+siWPMQQipx+Kecmz4utFu6BqEkbPzYXuVQ=;
  b=qK2vQ3h7kyKth4vN/H5/qWTstgOw8emW5bpcfjZ40njEz/aKrp/k4rSF
   MzwBCMnGB9C2Jg7AxMBhdIAGWeBNb2PztHjie18OTZRQKwEvOUOZTlc8y
   jiTj06lo4tizKKm08HHXXsem0t9AM8eZO7SKkUzznlsBXVwJfAGbXc2wM
   laJxg3HS89hkiVKPdPC3AD/PxbW/JhCP2+rC0pyKexXnwRuYfS/L7G6tU
   4wkXcygignuVrwMBzp8uI66L0c9wwAAuh207P7PKps61/8x1kHpR7gNhp
   6CD6mMBAJuy2wN3XbszKXexf1pEkJOVTUjXFa+MlaLi5seDbuH9GdY3Tv
   A==;
IronPort-SDR: UTskCjqEv2luP78ayoRMbamVX8AJoNXXayjehP3KLUraAqvOI1bIrYso59oCMq3514yYk4Mawv
 5gtxAlDg+f7Z4DHZNQESuyi3K4PT84d60gW5czG4u4BZH/fVEuSre1aOUF9aBcitCkbEqPd5Zo
 2CxtljRFH7aEkqcEtDloW4FALF0R7l7ZFy03h5IhZ8b0IR2MeOHmKmi9r9tWXdqcb1ZlyLFFGw
 hnHG/gddWkklroNshBhOx66wasBW+S5MXSTx56JL/8HDhJC7C6jij1ONZ+7HQiEFVetbNKlWDk
 5Qs=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="271419679"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3FcnkXqpWpij4spYT7IZidD+7ys8SaWb7WuvCQNwftzBPXO30pnz8z6yb6zF0byAkgYk+wpFi7CEsPq49KGc7PeM9IXIxgSS5BgOuxT22g5tCqnJ7XzKBMazOrPaIh1//Mkxgh8wp9dSkPAvdWVoK7BnD2+jjkEFQT71hxWgLVYv0JhbCNzayK0aL33T85wItVCsfq5wkFnFDalOmLwCygycpMH+PmvMSFVNfLMT1ch8tk2Cf9IAWC34u+SGkELkL4OEA1MaxU9hCO94XGdzBekZ1mqYIsvfSY4PVds0y5HlBjDhxsq37BMgkjPmVXZ/2HylOK8sWQGnEpXVjTm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqsjJng3fwc7UlahgAOOFLrd/TZxzT6HT/D5XIwy35g=;
 b=Vmu62Sq1Mn3YCoVFxPzhb4x5bhoehOuU/r4MIU2lnZ1P8LKEiLviH7/1jmY274gSjgJ1k+XDeJw6fSXwXd7MA5gqFIqgRE8IV6XB+z31M/KyN97Ceo7DBrr1xbqpfRLsR+Xby7KSQZmQ485hosT/n5ttxP33sGyzRgJ+7GHKt82+vu8XKHmgDIYmijkG6CIL0PC3aDkQ5UPdwDOnlJTSMXQ8leg8LgzAz5nSOTm8591iTH/glLYRZzmcO6lygDeca5ncaXLeLK69opbFj9ixxdRTwCa2Q1O/LjUZ51cDqfkWI6CuW4ngkvlNo3YieJRVsqvMf18fzK0WILij+HzFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqsjJng3fwc7UlahgAOOFLrd/TZxzT6HT/D5XIwy35g=;
 b=L9BuvSIZ81NcUaixsHOoFtiTSuYjj6kFeQw/2frSVlfKrCAz30IRc6NtfEWx3bYqunppdywjKtZPlT7IpMJOS9GaNYQNk1d3RQwDl94E4+7fKDuoUBaPhBJNwAKVY7GZvV7TzS2yrrd1dKRd5qQ1bdiYZRE0FsjyR9LTWqFHNms=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4913.namprd04.prod.outlook.com (2603:10b6:208:5e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 04:48:01 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:48:01 +0000
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
Subject: Re: [RFC PATCH 09/39] blktrace: update blk_add_trace_rq_insert()
Thread-Topic: [RFC PATCH 09/39] blktrace: update blk_add_trace_rq_insert()
Thread-Index: AQHXC0RsXa0O1KlLxEa+vUXZe+IePA==
Date:   Fri, 26 Feb 2021 04:48:01 +0000
Message-ID: <BL0PR04MB6514F1C8A41EF215C4ECAB68E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-10-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a898658c-737f-4281-4718-08d8da11b24f
x-ms-traffictypediagnostic: BL0PR04MB4913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB49139B2456B53F4963575217E79D9@BL0PR04MB4913.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXXFGuUK7ewWG46aOvN46K/2LC65kC7JR3fAHD/YfuApmffMJv1VNl1F6GbJXnzbDJwG5PhCeEqKws9QnKpxuxEPFnl15bN50vaJ9EyAE7YNGVfYU0ThAbrDnGh5w5V1oF3YoT14SiZJMILfZdvkhKPXA887wzkAwN63Yn8PCEuSjul2EV2MU8NcMNqna2q679htB6GX8xdiCCUwxogyzpB6f9ww4LVMVqQueQLBt0XqUjldPfpU+j/tS6wcoSAAmh0jZ1eCDQEiQk6/uj/f8gqBRZwsd8/L+1PPCE8t7+VqHFrPZ02j0kvyci+CebUS4FEabr75FSbaoXb7k8YqgTHmkBM4eO7oFKMvTE2OBcI4ASWvqMgrpFHICOSuVvck/C52f6UPDWRk3WsFotFJRRDyWM7YxBYk4GRQocLc7FCcH7CW1vqWmlg/OmkGk4ZqtFLJtrD274MDujRZHnVx0fkbY2eYqj85hC+Lv9r6I+iNxb3EMwMqInP0NrOW+/bnbANd+F+AUmR7OdJHlt2JzgW0rVnk7L2MaOYPwrLBqcK01lS/DtttxRuqRU/ziog5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(478600001)(64756008)(7416002)(86362001)(8936002)(66556008)(66946007)(91956017)(76116006)(6506007)(2906002)(8676002)(4326008)(55016002)(54906003)(71200400001)(9686003)(66446008)(186003)(921005)(33656002)(52536014)(53546011)(83380400001)(66476007)(316002)(5660300002)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/0K89fdb54jlSKvGHfqYYwug7ombsQ26oRhBwBg17G4qN42gEg33e+0VlNmU?=
 =?us-ascii?Q?XwwXHxiS8DzH2u4BwpdnsE0p0OJ0Cr1IJ0xqRMMTiVjYcGSJSnSTIcY6xT5U?=
 =?us-ascii?Q?SDKtLFnbZgLx2TNjdOaMm9matc+jDogjzfgKrSXlaXinBxnrZYdtlGKv3ODx?=
 =?us-ascii?Q?yQUpCsIvTgJQcmadCagz+EzXKQqYbRNaGZqtmQ2BvPEFp6cAaCrA4K03TUz/?=
 =?us-ascii?Q?X/7jLfcPsR7U9ux20ntfUHXAbuSCpbszGa+NuhIuz6muAWxLwZrofE4UeoFY?=
 =?us-ascii?Q?iqa5Uf88jWGl4JmKQ7eoJj0yuVlF4yghNu95QtUmf7j8UOBuEtXkwSBzlMuY?=
 =?us-ascii?Q?HBVpSsrmQE8TpxU3Mt+NxaYg+nUXjIb6B0fbJDnYz+/GititOTex2236ymsb?=
 =?us-ascii?Q?nedV4mZenOt2Sc9psnzS7lYeFKH91hZNs+40MsajL2dIhTD1LU8Rd3/kAr1N?=
 =?us-ascii?Q?nl71NRv1gSnAHfbmpUUhsXpr+EAhC6uaNSVz22+h/XMuvkxCRzGa9VRAk0mZ?=
 =?us-ascii?Q?yuPYFmQTrzZVDZFEtqDkq8yRJZFbMv3/9XxyMsYut6h7kspNmSD28VLQ22we?=
 =?us-ascii?Q?jqxRkSKsApL3Sauemi/tpNCykWUBbfaqPhbt61GfutaMkISXn9JbDWE7Fk98?=
 =?us-ascii?Q?Cx0ynbCd2x4VukkUjf/hb8Vt2FCCsscqhwrp/4PWJny9scxkfbX3kN9BPhQ6?=
 =?us-ascii?Q?TvMAlUJN06dX/2niww5eD4Ud9fmVIlx1IeH4EvNWHMkGJaybipviY1qoZc7y?=
 =?us-ascii?Q?9ekB3mvuEt0lCDUsDkVbNFML2k3C3ANHJebq38Rv14RDsRyaAJim+epUKQg5?=
 =?us-ascii?Q?q4rJlm4JW+0RFS5PXEHhE4uOsClkJVk5CrPxr4Ikm+DUhs7zCzQWxd2DCAfu?=
 =?us-ascii?Q?M8c5NgwnDT0DO5NEDuG2Mwg5pTu4eRnijukE+lNs99CA2VgSWIoAesALmTB8?=
 =?us-ascii?Q?llkSNO8k7CN0EpuUPboF4KrlQvywY8OHEPDFW5Z6VoHSFbDiBZibc18mtnC1?=
 =?us-ascii?Q?ZePqSXbrpbPoPWnU9EqTKO43w4tKoKbnVHFICIqUboRRoIdJZiOy573uTRoL?=
 =?us-ascii?Q?j9UV+R1qX5xT69uyNHvMYjcxC5GibQVg/RW2iHlWIcoPeMhGnZWoF08okm9Q?=
 =?us-ascii?Q?jjrU+b4bHMNr/Zfh2Iag7q2eeUzKzGTOczrmzEkgwc10GeYO2kGpC7G/3ztZ?=
 =?us-ascii?Q?RF7nO+QbeI1ywDQoE2lLCpJaXmUC0v8hw6CschwGcEMv5eCETVvZ+OpAx5nr?=
 =?us-ascii?Q?nhlpCNH7sbqDz9x6sVTVtXjzGlPvSNbj2Lx72Ucw9mYgRe5rYzbGQX/MWYlw?=
 =?us-ascii?Q?bgZwZjU+Kyd/eahWB5jTbroR8iWK5Q98ZWlu2/IOTtY4cf+CHnmFdrbqbYc2?=
 =?us-ascii?Q?pFK8ogchCPsxeTeAn+2HCq3xIbsXx7aA/aItDZKHlV/DgL2Bqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a898658c-737f-4281-4718-08d8da11b24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:48:01.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aq5XQntVYRYer9fn9v6Goce+Jzc3H5RaQBUy5aMkJADk/8GKpJiYG4BJFvanegbsx+6r7ZEpy78nCugjAuG7Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4913
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:04, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 20 +++++++++++++++++++-=0A=
>  1 file changed, 19 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 280ad94f99b6..906afa0982c2 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1134,7 +1134,25 @@ static void blk_add_trace_rq(struct request *rq, i=
nt error,=0A=
>  =0A=
>  static void blk_add_trace_rq_insert(void *ignore, struct request *rq)=0A=
>  {=0A=
> -	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_INSERT,=0A=
> +	u64 ta =3D 0;=0A=
> +	struct blk_trace *bt;=0A=
> +	struct blk_trace_ext *bte;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
> +	bte =3D rcu_dereference(rq->q->blk_trace_ext);=0A=
> +	if (likely(!bt) && likely(!bte)) {=0A=
> +		rcu_read_unlock();=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (bt) {=0A=
> +		ta =3D BLK_TA_INSERT;=0A=
> +	} else if (bte) {=0A=
> +		ta =3D BLK_TA_INSERT_EXT;=0A=
> +	}=0A=
=0A=
Braces are not needed here. Removing blk_trace_ext and reusing blk_trace wo=
uld=0A=
make all of this unnecessary.=0A=
=0A=
> +	rcu_read_unlock();=0A=
> +	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,=0A=
>  			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
