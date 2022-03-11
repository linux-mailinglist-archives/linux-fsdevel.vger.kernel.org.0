Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374F4D5E55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 10:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbiCKJYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 04:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbiCKJYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:24:36 -0500
Received: from mx0a-003b2802.pphosted.com (mx0a-003b2802.pphosted.com [205.220.168.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D250066;
        Fri, 11 Mar 2022 01:23:29 -0800 (PST)
Received: from pps.filterd (m0278966.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22B3ehmJ005462;
        Fri, 11 Mar 2022 02:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Q5wvnU47cNNRPU3V481aLVb+rtloYqTGJfrugq6vR+o=;
 b=nM0np0dTNftXy/ileOy+1tDM3iuAytdfjOBjvLy4HiNXnAsktbePSe6fAbsoZqyK64r1
 ihnDyCj4DHExopWr5wAYsZUOxODrg/YOlTYbS4fFKOtzX69aZvGd7pW+ocm+Jrm8FEHg
 sl/jWcYfxd3waWCLGdv9YiCYLl4lv30hwtK2uISDtr6MQuD97hNjOVDQ28/LTlt2+j68
 2BfLnw1cOOo/zzGS1ZgV+dA4DO0MP4sEJmnGftKSbNqU7qvfb320KHaaLP8wurXrvqr9
 xo1Awmy7LSY7Lr04cWey0MOYYlzjm3CCss+F/joe3tVefzgQdP/2hmCYHvHV7xE2CxEw 1w== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3em5bgpx79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 02:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwNzg387IOqA+Alk8oJbjaBT/oaOdIwj3DEMsPxV4ukVUoDebvl/DH+5YApuFp5JcNk2lmAKACHUVq5VVDvYW09WKbMfzxptx4O3IHAcYkmRICk9V8Cg8tnIpJR2PdkilMn3NFfp7KCPoz1apLJh9zrEXuAGMXCP0IV0DL7+3jEVSWWClEpQpQL3IZxTeDMOqYAbq5nkewYRHpMfMkO+3rJqnWP8f76J3kJkwMNOkA1ddRa0oy2VSNJrkiCMXNLo6zK3Sk2jQd6AmvG/fxI2MKQQESS9aD0pTKMLiGHDvmSpoSOnUgewEYY5xIT3fwGxDOqf04YYT6U9d7iDnFc2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5wvnU47cNNRPU3V481aLVb+rtloYqTGJfrugq6vR+o=;
 b=jbIkw+Y5MRu/VuDhdnYqFC+bZHTT4JzlyR3irqGrgiyu5Ag5IRlhBTYSkXZlzJLAP9DOctd/ZCgh7SPGpRgTCFjtXclzGbwvz662mipoVBQRzu70VPz0LeomOSibrwScLrHQ6ncq4lF1/oc90pw5/PAwd+mDQrPpb56GRj5iInr0I7XetxcyYrz2FeQNDMM/bLh/g8kXH/fkujfLVnZBxEFREat3x5MWWY6jnWKCuwBHY/YWY0GOxIftMKRwvoTIyUrHdBWAhvWMJ8LsJJj29pwuNar27C8w4Vxy1YbAoM8MIBYgjcAP1cuZx4gC7V8ChBkPBZ4CY7gSe3yusX+j1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by CY1PR0801MB2282.namprd08.prod.outlook.com (2a01:111:e400:c618::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:23:13 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.024; Fri, 11 Mar 2022
 09:23:13 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM213hUiroX0Mx0m03tMAg0KZ2Ky4fWtAgAAwFACAAEsrEIAAq+gAgABHedA=
Date:   Fri, 11 Mar 2022 09:23:12 +0000
Message-ID: <CO3PR08MB7975906A41E28FCBA0DAC41BDC0C9@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <20220310142148.GA1069@lst.de>
 <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <YirYvvIBW+XNGvxP@sol.localdomain>
In-Reply-To: <YirYvvIBW+XNGvxP@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2022-03-11T09:22:06Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=fbe66a85-b0fe-40f2-8775-25f085a93321;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9cb5e77-0b1c-40b8-c94d-08da0340c426
x-ms-traffictypediagnostic: CY1PR0801MB2282:EE_
x-microsoft-antispam-prvs: <CY1PR0801MB2282DD79B788004B7BF857EDDC0C9@CY1PR0801MB2282.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysp3x3xYVuV/gWNbbAR9qnGrVNi5nrhlr05KnNZ8zMPnqQIb4HXkJZmYvdbH498z1JRoKx0m9bwuOS5oH7Q0aUM8sUZgPc9neCwjWsys4kaNo5mPtit0yQUMw1gn7OrSvGWw7kkS8JQlpgRtrIvsmwmc90vlpSIAJAftVmb4tPl/hzYVdno7XQAznjCU3CvOHWbxwcbZdxIq790A82Rqg8SUSGQgaAPiD4La+YLcH0DrgnlSbK5q6PAlnXo1ogL1+amxR9skq6RZXJG+iSkQvWF1cyjgQESl9x8h7EPm0viKD3GAe6se4oJBE6W9y1ZbK6tvW3WtmJLJYzfVfdVQy2VDzLq3lO2VI7w0eN/cGz2Qho9icbjc4nVve73LDjyZLu8fMX4YTiPsrwRNSebTXHeepwVePTPY/XUAQTGMUG87RHPtWYjdqB9brWn1veiqlWBgZIez5vpaSfG6BjNOUUZ1SlIUagPy75OkI37HyI6Go/1A1aNwtsNBs+4g5hQGgEWZ20lPYHx2E30GwQeMbQOqNmvLjkM5c1cQINDoyAoLhTU+3fEjTLAorkYwrqFyGIW2N+XQCLViUhLmGcXVy4hMxuvFHB4EZz5VmW0mfoyczeN5kL+sf/RGFo3JI8BaQ/cB6TTD04iB5j7tXp95SGv0Sq1Pgk0xtjgIqK8BB3rOu5jSt7S2CmBxjsBXr9vHmI6tPIufTU+k9J7fFWVe4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(33656002)(86362001)(76116006)(508600001)(66556008)(66446008)(66476007)(52536014)(7416002)(316002)(8936002)(5660300002)(64756008)(122000001)(66946007)(38100700002)(38070700005)(186003)(7696005)(6506007)(26005)(54906003)(4744005)(9686003)(71200400001)(6916009)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZx//c4u/Aj/sB8dHT4oFuKN2AiFgwGzHzhoLm7n5KFOvq2Jdvuh6BWnvFXL?=
 =?us-ascii?Q?iSYNR1Lv9AowL9+64ziIS5Yl/+LP9V4ZYaPYcnFJR41xgKO2ffdIXe3xIMzO?=
 =?us-ascii?Q?ow9dlmyKf3NvMZJwIfxcfsl6tWi9fpTI7VplvzqMA3O4zf7y4KQhF0Fn/xXS?=
 =?us-ascii?Q?9Ah9SulUl5W4qpyD/hpl3FdM1K7EWNy6k/5yZywh2kUeGs/5s2PelMXafpwQ?=
 =?us-ascii?Q?Lwj7dJC3vq8he5bVToRyWJxvtlznlEOaWe9DdAW4KaahCz/6nmRNn3vwDkhN?=
 =?us-ascii?Q?SpCh3sJ3jCVTbjn4DTAvkI1VOJ7bXXu5uwNfjwCxPfCwEWh2eSMB6TMFDaYc?=
 =?us-ascii?Q?zJTw+gzp7cjHwMjHH0IHshzASR9z8rIpWz9/4CLJ8AmH8KAKwPtUsEnj3EB9?=
 =?us-ascii?Q?BXicOsjDa1kHsoIHJHqmvqz+ranCIzS0mA8CVH4DivZQKHkWO2h4EYOI60Ul?=
 =?us-ascii?Q?ros0m/waDqha3xbcrDdi4+4lFgnUfbpo0vEyHhkwVMqNaf1HRCli4ntTOaNH?=
 =?us-ascii?Q?xgFwCGWoq66MamrACcoLEOtVxtc0g3YtyQzty83Va2E5t5Fmpy7DQhAM7+Zq?=
 =?us-ascii?Q?djAtI74Y9hL5jUNEa7oGWvfpwCTVTwdBUecluCeyU7oL5OX4XLP7n/WHqP7I?=
 =?us-ascii?Q?vRsY4UsqMhZgFvWWTqpHF1ASYRHJ70FWvsBLV9TQG3FQwCXba0kzHeHNcU2A?=
 =?us-ascii?Q?wnNqKhKbNS93aZgcAiAST470oZWw6ParcjCRlGf7JQeZf5wZee//wY7VSX/T?=
 =?us-ascii?Q?5wrsp5lD9+Z505xhIvIxiVNS4FTfmimmUMDh5qhO/lNIh4Sao6dzCjpL3dHj?=
 =?us-ascii?Q?rPxosN2PoB+vZV7W6UkJ4z/Jdc3VV9ZhZkcr6DHA7lej/yWXNFIxqeL3VDVt?=
 =?us-ascii?Q?BFVuYh7aKTnVj/Qon5a5gnRK3fmKJigydLFqD6N6Nd+94RnSlsJnNnDHTZ3s?=
 =?us-ascii?Q?Sgpx5ykY363ZovThBUacEIEthSi+YNnIu6+AD7YoWo8oRkk2vWBw8Gr9S+EQ?=
 =?us-ascii?Q?MoYqlwedJobXyBvGJ8aTGfO+H/9J6WJDdGkHs71HGCIljnRMaCTbIa+dorE/?=
 =?us-ascii?Q?vJ1cX2dRCFAcLkq5BKZzEmAOHaHftujSSZLEzcI9y1t5GqGpTm3/tuq0dl3J?=
 =?us-ascii?Q?zWH9qCI6fO/vfNcZ3OoDf81KvlhUgsEPPcmXjixugCvWwFcS28Snx6B7zNU8?=
 =?us-ascii?Q?CXyxxHLr2ONpqKsqjAQ3bk7sH8x+gxxlXx2hnEQcIS/X8M/LbvVoZZ0bTQgS?=
 =?us-ascii?Q?GQPkf4cYmUVZ0Ie+zE8C/qPNK52sLzzLBQt4X9dAFFSCPocwC3441MoMjH9O?=
 =?us-ascii?Q?KZPttfOULsm+yOtwsn6r1GIyJvwrsTaqg8xNs+F/bRPMr/kTcoaEM1fjCpgf?=
 =?us-ascii?Q?SdUBWdYZm2YpbLX7JLnClZpdweWoDaUkt2rxQrD8XtIb46CqPh2tQie3L6Kz?=
 =?us-ascii?Q?hqiYy0B+xYyeRlHDQQbu3hI8h2ZEGWXl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cb5e77-0b1c-40b8-c94d-08da0340c426
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 09:23:12.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nreBQUcm5XntFem8X4CSehHZXcp82e5anvKahzbSDHC7jptyvuaBujJFR58RRaigv9BnBlWFGz9YvDcdTFGGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2282
X-Proofpoint-GUID: fJBtJeweGgxYpCNH7zPgw-KBJoqAtZpx
X-Proofpoint-ORIG-GUID: fJBtJeweGgxYpCNH7zPgw-KBJoqAtZpx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>=20
> On Thu, Mar 10, 2022 at 06:51:39PM +0000, Luca Porzio (lporzio) wrote:
> >
> > Micron Confidential
>=20
> This is a public mailing list, so please do not use this header/footer.

Eric,

I am sorry, sometimes it is hard for me to cope with all the company proxie=
s/firewall.
I'll try to make sure this won't happen in future.

>=20
> > it is used across the (Android) ecosystem.
>=20
> So why hasn't it been submitted upstream?

I'm not sure about this but I am open to fix this for future.

>=20
> - Eric

Luca
