Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9A7B5193
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjJBLlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:41:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73820BF;
        Mon,  2 Oct 2023 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696246898; x=1727782898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/HWTCa+jY9irvZgNvY4kywbms1fJaqUDdLGr2Fp1QXI=;
  b=ZBSPaojunyEP5910QWcIoYzvEp6MhnwvKtv6SGzcS0wQxk2ox+jlmpD2
   2naN1b46Qg8mxJwgbWEGJ1CU4LB74tLK81wdhuxzfl70/QJnyc6Rww918
   Wm+r2CJcefkbekgcA2VdLWJrM6d4ByO/gJ4FTy67nG3JmU7tCUzcaPxZ2
   jGHAh8Pw3+VwDfiilZwlXQM7w3s/jc8HomERsKLGNemShY0uE9SLcDYtD
   oNK2cPZi/+p6gGe/wBAixatveROIiW14otiuflXM47I5l20kIEvijwZoD
   hyvB1TM0Rl1Az2uOwsX37lrdUm3r2Kx31LV63eZpQwIQViPUPAto+ySFl
   g==;
X-CSE-ConnectionGUID: W9HrpXwgQP+CGcyE6KX8sw==
X-CSE-MsgGUID: dhqMxwQMS862ScE3n0H3tA==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="350844166"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 19:41:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awgijlyN+Xzu/USrMn0JVNUVIi3kA2+Zu2GWj5TVm2QI1/MJgT8AOUCiwhQ6nV0MQr7mOO0ZTmKZkagThkvnoodjH4Y0X+/A6cqsJ/P0RVoo3oaBH4Z9Gucq63VCJOXgm0FuVR++iv9qf0/p6rRUj7HuJ6L7WwhWkqR2L7ytVeAdBASNS3bErANdYFAwRyYizy1ZMyiT6EMSJ/Lv6icKoAfm1DaKwJrlP6qZXpxjv0g5VG7kJIfrQMG/auW+cum+EnhdjJVqfisIVi1nURCxFHcI6MwtbAzebc43mURjceg6mTsrp7kY/N1MQ1T49k3CVD7I8xxFLV9T/pG5KSA/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KTdXr5bpd9hXPxTFqy+Ii2ixMSSCE4BAZCPi1Dzn9w=;
 b=gmDC2ddacpm1gaUPgUbo+OA8TbikKzURHBn4jDYvQFhscJKU67oEoYwrzc7gExmD3KkkWLRjwvnx6lr9eggl2b5FZnFmquOCPOWcvNoD5rgnbUiH09ylNKf+uR1c7fWNJJmvlp1b8W6hTUPg7yENAnBtSqenqHZEmmc1Ffyk3yGtNQlMzTua6owH/gpK9IxdB1nvpVAHkH3iTomfAqEQKlTZ5WDPS4qDiaTrZGcH9cshiz6D5iBnRSGaiK6m/kjtXqhW9GdNJY01igSHPW0zQCUtKU1UwoUtz90wpZ39ieooRW5LpwFpo2uDwLtCg6wjaqwhCtgP/mI86FbM8r1sOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KTdXr5bpd9hXPxTFqy+Ii2ixMSSCE4BAZCPi1Dzn9w=;
 b=rfdjdL73B8evCMUTmETSzVPEHtoX9O+zK/LZtsh2Q8AupJj114XgLHGwf3zvQDlMN2TUfkb/sIS2sNg6SuijGgaV+tP3FHqAz8UAd8KYcGkLnE5kK7dDQ8beZc1dG+TGEJVPVY5DqdPn+XuyypVutXWjC10Wp8eNboxcTR5vBaw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY1PR04MB8631.namprd04.prod.outlook.com (2603:10b6:a03:523::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.17; Mon, 2 Oct
 2023 11:41:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 11:41:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH 06/13] scsi_proto: Add struct io_group_descriptor
Thread-Topic: [PATCH 06/13] scsi_proto: Add struct io_group_descriptor
Thread-Index: AQHZ6/brHZLJtdYI5kGHo1P7lCy6prA2ci3g
Date:   Mon, 2 Oct 2023 11:41:31 +0000
Message-ID: <DM6PR04MB6575C0B9DD2DA055A67EE72CFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-7-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY1PR04MB8631:EE_
x-ms-office365-filtering-correlation-id: 0f7a0ad5-99f0-4a72-6f5c-08dbc33c85a3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uMPVEEwsNNN06JI7N9k6p8iOOFj/MaFbkO1oWxshzkC4kC8yGSjptwfUGlHcz6iqqZ1b6BuekunYZdOQhVyBGYG1MeH/N/f+gj9eyiFxYPsW/HLtRKXsJeOKtA804WMVjeHVIcYlRNk73mFkJQV/X65MNJdagEi3uFuYQHIjK2in9un2UuPS5zgOgxGK+UxIAlQb76RN/SZQPKfrThBSwRMlmBRP2fNp8OLug4dGg3fXTNhUBdxPLqjOksR4Dy3yJrR4DZsI7HDG6ws7avCstq9aF6r+O8UpRAq3Rr4V827B80PSXhhnXv/rS1SvGmatLEXW0ive6x2YkVSZX2BSXanUrca8dhYwx2yjO6UP23DiLZ7Ej2Va5WWq933J9nBYiU8uyVjBSgwoSF2sCPhFKu8HVx7A/sCz/wMyteb7kKPSJceznX7Y30uDIBJNDCqRSuwkGzCJiKTCzPtScGkW4iIKLcvLqXhlU46yw5mhSA5CWQ1OVYKiZ8iKJzd6cMMiBFvQ3jNwpBenV2ymQfXPJ8DNk8QMBvfJtoXPGHGm7IiY+rFyA3mrKXgs2ckMqyCLHwpviMjTzlW0VjWhzbEp5Iudy/AnjAG7593E3U0erUszpm3t2QuIpI8dUHvK7vc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66446008)(316002)(41300700001)(2906002)(66946007)(54906003)(110136005)(66476007)(66556008)(64756008)(76116006)(9686003)(8936002)(52536014)(8676002)(4326008)(478600001)(71200400001)(122000001)(26005)(7696005)(5660300002)(6506007)(55016003)(38100700002)(33656002)(38070700005)(82960400001)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xTbncHIMv79Yk8Q2upvG4+WGzbkF/HPIWTH5VIMz3dx1bZEZDDIVpD82ugBH?=
 =?us-ascii?Q?absOlZJr75SkYsAUj4FVfgpnFwsCbg0Pmbg8EIe6yBSmO7/bPOcABIo4157a?=
 =?us-ascii?Q?qQ1V1yLiGN6Qe7q5Fb8Tdfv++g6hfaqniDdnbnvNBhj4egewvR4PEfARxrO0?=
 =?us-ascii?Q?mZ8WJXRsr1mkr3lcjv1DayO6kyzbyKSL2af1cUGOM1M4HdCwSU7onadc0AmM?=
 =?us-ascii?Q?cYK7sexBzazWDm1RBZLWylmpuByqus2jXkkvRCmgeRvLpcXGwofm9GBhHxmm?=
 =?us-ascii?Q?9yhlOSSjsYfZpt3vLVIn7lOx8uSlgPQVScTE8WYfc5MXkahgiicMIDZ5fTSU?=
 =?us-ascii?Q?enDz+P01fD6CqLtlo7KnpPTuy6LMmVgb1tSrSGGly/MrDB68qRz2AM2rSQ9K?=
 =?us-ascii?Q?bRzKbTwa68VUc8Xb4kFphmDcn2+++zW8d+TJTDqvcUwKFtDziWNT1I965Haa?=
 =?us-ascii?Q?SdLPIHvRFEDPd57FbcD2FdmykeqBmDbUK0244Wvszd6KY/5J4QmaDonMWCIY?=
 =?us-ascii?Q?S9v/OS5ftMSKNE+hbHul9zpoMcLIyanx3ilawVz5KzAOTuaO5AdDF5mgZRm2?=
 =?us-ascii?Q?d2CSFTVJ1CIRddYSCtzd+20q+lxCZenqi5WvfIcEbtaQ1cCST58J2u80YE/x?=
 =?us-ascii?Q?Ie6xsPilt/I2WTPYYRwtDFizxbHAvB6I05cg+U4p7jDyL5x9yGqhyHv4FNWO?=
 =?us-ascii?Q?gt+JlfulM8bZOxeFfAQ6n34q6WsANw14Ofw3Z/s6sQ5IQE9oQO8qevc1TbOa?=
 =?us-ascii?Q?ehkYQ1UF+4aiB02QFvEgoiWjZZiDoQ2c+MZ6iQtG3ME0YtjlqlilF1EygkAS?=
 =?us-ascii?Q?ICPbSeHF8epxUwbtvKbtJWfPd3f26FvAyiA2uy//dzHaD54LyZLp98AnoSXs?=
 =?us-ascii?Q?8R2qSjGNJqjLLoitDAW/fOGujBdVCY03ZaisJSq5QINxbYuuGPMlt1AzAkEY?=
 =?us-ascii?Q?PVoa4Ye0o9A1UWKf6KpW95PYK5auWjOZBC+XkpXZHadBSS978DvfsLIJ0JW0?=
 =?us-ascii?Q?IozZUA9uyjaA4V79WmGUOOnmH70IZE/n0FrBnE7PdeS0cS/0C3FgIi1HVea4?=
 =?us-ascii?Q?sxiccCqt8Omq9l/WR/ymtKgNJxoWRUPtxteF8CzPpgMNFJjsW8ibgVk8WDja?=
 =?us-ascii?Q?yLX7RIkRfrvR4zgj0BrWjKePQTC/Sb3J6+ep+tPJe3ruysKgOuYELDAMXcJb?=
 =?us-ascii?Q?eywlJEKAhOQVEshckgurZSAQBwYxVEh/ZMKh0CJjYrbSy6AYHFs1wJMiedFK?=
 =?us-ascii?Q?0/zKWxR4GpsAoNaUW6s1bauoT1RxDWOSdCdgd9ZQgyyWYpAuRoYppQvgAbCx?=
 =?us-ascii?Q?JzxVQOux47PSSWbWrf1MjNsE/eoL3BuL0iCAcnDFVlpBQ11TP7JyKFYG0R66?=
 =?us-ascii?Q?yE4BUTimheFqtMToTebxwsGfu36nFkZqd5T4tYZEH+aV6Eyum5wcHkFIE1im?=
 =?us-ascii?Q?YQmXLP6u1d61R8zMiSEOCNN4dPfd3DJ64Clt7eS4ZWzpL13Ee28D2+JoteOz?=
 =?us-ascii?Q?kqD7L6R1AspQwxiwLcVp34Bf3mRdo/hoQ6hV4CTCi5MxO8SUOc5sN5HnsAPR?=
 =?us-ascii?Q?U2J5qm/ZD8TDSESWAYFWKLNcSIJJrZV54hIAP+n4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RGwZQ+1LSSMFNs7mYnma4+tM3Z3c4IZ8++h8zQFkF51fNcVHQ5LR+BuU+RSNrFtt3Fy6AoBSvgqbP6mu1rl3hGvze+31JmppN1fTarJY3UoikYRfgxQEkFoww0I+kL756cbyGZRpwwMYWBYP17/lm6SVKRLoO7VFp7F/YvcSVCHrEAqoC5RHrglHzqBzV9I+tqyAZXuHyPrJ3D2yU7SFsr/tdbaBL/86kqI8zKNDin3ONqkNtqNfNPMWNQvVPLy/g54O/X64M5YKAybQVYPvziINo/iGt8+fnF34D6GsmyaXEkRju0U8OxqC803a5w+BSrbXTlcr9dFB9mL7si0jvmJcTP8jx0pMOesiN6hY0qJM3NH5hp8XV3O80aFiU2qSOnXSE2ZNYWjq3XC/odLswJkTHblYAUCyduaqDJShaB+B5ILLEG1uIGMQSHOrINmgBoclBLcf+cqmHYwhBBRYVmFHCD+0RmPzWKPEIkxprLnkagjzWzBv8bOYjnfh1SywdZhqnZi0iwajaXPnx1X10aoQ/AwvrXrpqjbrClWODKWSGvR8Wdao0xmBkRFoe1ieblL4fu1Ed7lOFk4caxMPpL8F+ftqzo1HrqCN8z6JhxQsMbRLW8EnSu5/JdlvSaCPjUiNc1V6qONYRvK4cG1kSXkuvVtMEH8iZEIMQd5zzjPCFq2HePV8fkCsI3dpWtRKOxMyQ4Nc/2mmp7ZtVeCYnIEKvCz6EUG++rPtFv629Od/WnpSb0SQNxPRgfTl0qemeG+GsycfMApcVcddtv+algEo3hetfsht4JIQYT9krk9CKLq3UrHEVdq1RDHyQUZIXeRaREg6PwQStLAZMTHgUH88bAy/v+5o+JmXQ4Qc/N7xKdZwQ+CYYVisIF/FXX4jBRs6MODUEFiLKphEzBDD2su4D8PCx9IDeqTl9uVCwXk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7a0ad5-99f0-4a72-6f5c-08dbc33c85a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:41:31.0253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8igpYdZlr143K4COsjpDbNqBDzt7znMQo8YFxE4Wv+86yjsJBMf+YWveJRag+mmhbnu4sieWFVQODBteR0uZfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8631
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Prepare for adding code that will fill in and parse this data structure.
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/scsi/scsi_proto.h | 40
> +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
> index 07d65c1f59db..4e3691cb67da 100644
> --- a/include/scsi/scsi_proto.h
> +++ b/include/scsi/scsi_proto.h
> @@ -10,6 +10,7 @@
>  #ifndef _SCSI_PROTO_H_
>  #define _SCSI_PROTO_H_
>=20
> +#include <linux/build_bug.h>
>  #include <linux/types.h>
>=20
>  /*
> @@ -275,6 +276,45 @@ struct scsi_lun {
>         __u8 scsi_lun[8];
>  };
>=20
> +/* SBC-5 IO advice hints group descriptor */
> +struct scsi_io_group_descriptor {
> +#if defined(__BIG_ENDIAN)
> +       u8 io_advice_hints_mode: 2;
> +       u8 reserved1: 3;
> +       u8 st_enble: 1;
> +       u8 cs_enble: 1;
> +       u8 ic_enable: 1;
> +#elif defined(__LITTLE_ENDIAN)
> +       u8 ic_enable: 1;
> +       u8 cs_enble: 1;
> +       u8 st_enble: 1;
> +       u8 reserved1: 3;
> +       u8 io_advice_hints_mode: 2;
> +#else
> +#error
> +#endif
Anything pass byte offset 0 is irrelevant for constrained streams.
Why do we need that further drill down of the descriptor structure?

Thanks,
Avri

> +       u8 reserved2[3];
> +       /* Logical block markup descriptor */
> +#if defined(__BIG_ENDIAN)
> +       u8 acdlu: 1;
> +       u8 reserved3: 1;
> +       u8 rlbsr: 2;
> +       u8 lbm_descriptor_type: 4;
> +#elif defined(__LITTLE_ENDIAN)
> +       u8 lbm_descriptor_type: 4;
> +       u8 rlbsr: 2;
> +       u8 reserved3: 1;
> +       u8 acdlu: 1;
> +#else
> +#error
> +#endif
> +       u8 params[2];
> +       u8 reserved4;
> +       u8 reserved5[8];
> +};
> +
> +static_assert(sizeof(struct scsi_io_group_descriptor) =3D=3D 16);
> +
>  /* SPC asymmetric access states */
>  #define SCSI_ACCESS_STATE_OPTIMAL     0x00
>  #define SCSI_ACCESS_STATE_ACTIVE      0x01
