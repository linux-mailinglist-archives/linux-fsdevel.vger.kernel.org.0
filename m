Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54417BB491
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjJFJxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJFJxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:53:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E8D6;
        Fri,  6 Oct 2023 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696586024; x=1728122024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WRNKfhCjCvZNndYC0/UOCH5oYENPM5XyEQ0j5W8gceM=;
  b=DaATIL/2lXlaIM2oc6pTTfSUiR+31nRH1xGGf7lbdzrweiGz+DsVVDtd
   Su2aE2QGjjsb2DYSUWdmwLgoVFvkMhG/veKxsRTL/9RkVSwCSIv7ZtrKC
   42ivZOKghvawpn2on1J3jvvXcw0AK71ZNqGj77BBcoS6+PLFQIrhQuLV1
   dX4SkUHzD5haPX11rrqVsFh5O3T58GcnQs2S4VklX7BSTXsGWDHB+V6b8
   xMdAst04iJYQBg5OYftCIK+II+26Ew5V1PJQMGPXo6e4yQ6aQx7kfr+RG
   D/KeUopGhPx+XK39VB5KxjGG/4OfuhdM1JKCcOCnRqTv14AWwgkUtCFp2
   w==;
X-CSE-ConnectionGUID: EFFc/r/6R7CBdWvCuqjajQ==
X-CSE-MsgGUID: PH4vZpUYQk+GOzEsyGMiUQ==
X-IronPort-AV: E=Sophos;i="6.03,203,1694707200"; 
   d="scan'208";a="351234065"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2023 17:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFdfoRxTe1bMieyEYDUrzRHuW7pnKsSPxw9rwan+RRDicfu79Xb6q5hzoQCUeW+5gWqs8JnkDdZy/1xFvpcYs7DZZVx5RsiMWABIjobfdfwuklBeExqKsJoA4JcAylaWnYej0R2QOs3az8EK8sZUGqHlq5otXWFJEXi66mFNvcTexfdMQeGzNWkRIlVmeWa/naBKAs3G/LYXu499p5+OU5vgR6UeUs4rVdvu8RBOl832ez3hoSLFjfB08Jmr6Ow1LaHKKT9SErx5bJctIH7IhiOkKImkyEx52UpfXnf27/pKmxDQRu1eLE6s+aojNdEBpEOlLl+okbZTiDYfVcxClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nXKXYcCju1hNd91ys3k8CgKrbMEQ2fx9uRAvo5n/YM=;
 b=mfZeHQvvfK7g59+JSp53RADgYpUpvk2L0lrnDJnCGNCdI9HkHHSbIgDLAG9B8FU84jaVmJNlDBIgqSFWQSU270lgezTfd/pph1bcGYrtUd3pYez2r3sUQGsE/GggrkP5cilKoEzHWXT19cZDGebvn/22nzrgRKiVx8pQU6DGneEa7+UyJJGgS5b7Jq5+I4KDzyXhcbv4JgxxHDMQW5MUBRvg0EeFGyDMncyS9Idl0ZqD0cDDpSIm1cxpypZ1xJdW72eHZKTuJ7Dg24J7GTXGv72cMTsZRttVtyCDCnVeRUXK5TNWf7tUcXt8CtZ6Bctmf2pB3HOhjMeM1P4JERsVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nXKXYcCju1hNd91ys3k8CgKrbMEQ2fx9uRAvo5n/YM=;
 b=jI48I0lW5e8m3m9uSRaZZiR6wjJwNqPTOFH3bJHRIp6oo1ek6qpZNR5jdjLhDhhQrS/OBitlDPWuxRmXdFUGP9xU8vKQNIcHExuQhci+Tpez5+tOMOe4b2b6bbADAjF533wzVMhSmm2k3nGbmEcM6ywAj9CEvvqxWRBW15GgpQg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB7016.namprd04.prod.outlook.com (2603:10b6:610:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19; Fri, 6 Oct
 2023 09:53:40 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Fri, 6 Oct 2023
 09:53:39 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Thread-Topic: [PATCH v2 03/15] block: Support data lifetime in the I/O
 priority bitfield
Thread-Index: AQHZ98QEzxK1K1BQ10ix4dd17lPdvbA8bDoAgAAaL4A=
Date:   Fri, 6 Oct 2023 09:53:39 +0000
Message-ID: <ZR/ZH7hKcc56jg4L@x1-carbon>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
In-Reply-To: <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB7016:EE_
x-ms-office365-filtering-correlation-id: 25d02e20-66b2-4f70-cd35-08dbc6521e02
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBUhB1ZNBBtUJ1XEiwnplwQrd2U1n/0nBi5NQtzEMecxNesk1LqHPde1scRZsiQS6I5bNfua0zn1EKCpxLdhjUD8gQlXIKpA0UR7unhxQmLs3keBqNO2nXHbTPoGNceCBUSNxQQUcy8xN9zulCso4PHBRFE/DrEuP6CMSXFYMZJTFazmxNmFSgkTeH4PHXCxDigy93ttIXDIihoTFH22QTHYtXS1pewncwH5Tu8w0vP+VwDQMl93zYu1FK+r58CcePfimlIFGSGRNRlD2VLj9LpeILakb41dAphw8W+AqmZSkeFLftd6F/QJYPY9Fyqt91fUu5qudNbTaKqHr00k2IPQpP+xMyFv47bqEbRgdk26/iqmgKWx2OLgei/UuusZ/6AwXepIkPWMZVUld42Utm3sk98n6+pXMGn2qWxigo3OFuTsXS1wiKA2mR+DVDAym9U4TLroH0ds8FGS9P3WUMzKew3X+HCAuY/FAiYtmSzL88vAjd4i4gpH2+3JtfLj/Wxr4jqgiKk5qFaqOddRDJu1bEQA84vp+cYQOOk+IAXFScPkj+B2onxqRu5zcI4Tb3TVZl18JAzJ8hg5lp90NDHFIyv9v82VFFMKuQS7CNbabCtomt0as2RWrbBD8Isg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(83380400001)(38070700005)(71200400001)(26005)(38100700002)(6506007)(33716001)(2906002)(6512007)(7416002)(41300700001)(316002)(6486002)(9686003)(82960400001)(4326008)(6916009)(8676002)(8936002)(53546011)(478600001)(54906003)(86362001)(66476007)(64756008)(66446008)(91956017)(66556008)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cut1nmZsT1TI/lPEuQPQjMTssvyn6W7yP1L7YHSF5CrvtKjNrToJ8H52Afo2?=
 =?us-ascii?Q?gahuBWX3jnxOrUPN3osTS09NiKRJxlRQ1LtTbYoGG2rxbj02CJsXf1NtQwMf?=
 =?us-ascii?Q?dWGl9RwoXEZBNSjkJ+oTdnXwshHnVzWXegzpBwFZe+C/hh+kG8e81HUUpaau?=
 =?us-ascii?Q?E1LXhjUxeXJUahxptpM+JKmk43tGbiju7QIftctxp5C8lLuMEWeHpWiPixNM?=
 =?us-ascii?Q?D6JwNj+ABd4LRn4QRkjc1UQVbQICQIdgVUIC8rrNbuB6XN9yhrsQbHFAj6SG?=
 =?us-ascii?Q?wepVVOef/0Nb1ZbH83NuWD867otn3uLI4vAcC0xPrltJ/AgjDe4CPKLelPV/?=
 =?us-ascii?Q?l1mWgVsXRNiyQFFs/QXD4SgkeRBHvOy/LH0SJFqhiiiCPtj0USP+LLKH9V56?=
 =?us-ascii?Q?/MTA0Amz2SOizgNooHrxPt8dfbZqNLyqwbt/AC0Z/py59WdxwJZzie0+P9cx?=
 =?us-ascii?Q?MwS9Cjof1rrWVfw5trc0T/tQ8nzsm1xPOuSpIb6slLw2QeixTE6XIyeikJFV?=
 =?us-ascii?Q?+uDQVtWKV5Y3scggO4BafTppSVXsAh49+H5lyGarkLzF/XST+hfhprsdKBAO?=
 =?us-ascii?Q?3aj5dA+baLFbQcTsbYubMCwzszB1UlPlW4Luh56spVxjeCe3zFMs2buS1f3d?=
 =?us-ascii?Q?1JlKncEBYISEayDtTMEKJBxS3uqD8QsAZ1UGpXRBdWWc8Roqsm5EUUSqVVPt?=
 =?us-ascii?Q?1iokoMKXY229Dwq5r9neEkcWJ6Uxh6cw36HUO6dkGcW/FHkVs2LybDHiSiUO?=
 =?us-ascii?Q?OqaEt4dH9ddy9pBOuPSaUx3f8bjSPhJ7ul6uesej/2rcpbAIiP1fhyMhbnRp?=
 =?us-ascii?Q?MkyYiVpKbQRzvVWjFxUZzkYZpWxkjFPfq8HnF5beZnEPSybJrv/Y9PXixmGU?=
 =?us-ascii?Q?wk3/Zk3tLlMBNzkxLnUf7gEQUi75pTQnglTu+Qk9u0lLSolyEJFsutrkYLya?=
 =?us-ascii?Q?+HD5qM1tlE+MftECsuT84voNFCHCZMLKJlzY5RZ1CGA76LpWqn4/VWK3VDhq?=
 =?us-ascii?Q?g4Lz9KpKmi169p2ZfXuMAUY5OrmrwShmiWvbx5rQxpGnvC1OdbtF0G1uJRAp?=
 =?us-ascii?Q?y3m6p1wQ16nzcrTBhBjQTVcXANCDAqNuWIlVCrlJyXAGHWFSh+t/QhNqDS7X?=
 =?us-ascii?Q?j95wUk6bY7Y0OvjV6Um15Ji0S62aEhssrqv7elgz2XvyKXDPEVQ/rRplGG73?=
 =?us-ascii?Q?WQCp5SDQI4xVj0IW6RERWvTMUMg7uVEfQh6wvgHigKMApkZooqhYiaJAxiq0?=
 =?us-ascii?Q?Ici15XGJclEwNDLgKTWn5MGB7Yk1O0hCsv1+1kdpYwFM1dEkF8Ndexylwo4z?=
 =?us-ascii?Q?SkKsgJaXm93GanpYww8qsRn0Z6GMDVuLtg0YwsP+IOPZzqoUnIFL9iaTxImK?=
 =?us-ascii?Q?Q3cEUjJsvmnYZ5QucyRWdYc0sGZQP0csdgOCoxSzt4sOUVArub8E6qLXWE+k?=
 =?us-ascii?Q?aCnNqJzLKy+huy5ujvcZPEWtNZVMOLJXNfwm4px85Ej1TRgU1T6gl8anfzeA?=
 =?us-ascii?Q?6+0D+1D+UFoOeNg5lAMNHnccFFkiEmMx6PmkPInpKJdEEWq8MKzI4qZ4ddyg?=
 =?us-ascii?Q?B056myd2ut//U9ypPVm1AOSz0ac6Erip2+MftU9X0kJyzM5NRznNpQ/qlsZn?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BC814E5CCA27945AFD3A7FEF86D78A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qaarbyE/sfeFkAnLKo/OZ4X7/JClavvUsulk4ssz3kqkN7+ylHOpVk5U+d2r?=
 =?us-ascii?Q?PrpMDEXqyoo+OaZN22O9SrdPYWtZ2VRwQv9f1jTFFOmWOO2+k7KT3gtQ6lXK?=
 =?us-ascii?Q?ISJksmuMbtyLfNqHP20bJrLXnzgdqkCdh3k3VAfZvBueqP+bXbrRcPdf4J4U?=
 =?us-ascii?Q?smq5ZZIly1N3x9OzcvbNKTqjXFPU9AR7MTNgHaAffFSeC3LPlDWB+7GWJNzB?=
 =?us-ascii?Q?8FGMaEeQ5AD38cE3/d0mx60IFv6mB0qjSUOfhjJYbvZtLN+nqnDBmwZ77DKW?=
 =?us-ascii?Q?VVYgSfmO0qGt2gawUwUUWBWcYfeatFvzNYOz12dIvPOSdn+uXUmx89x+Bhox?=
 =?us-ascii?Q?aLHGDH/jq1CH4PlSNd5U58uXFCP2G5oPAKN6h5FZtLsnz50/jXrqqTL09u47?=
 =?us-ascii?Q?tmhlZusLodmvvB1BPRPBxmWRH2SKhPkI4QYQc2GjXtyyosouJeGFbFNOLgtg?=
 =?us-ascii?Q?BzuduOH4rtTPdEWO2xMFHZ8i4HLLXMlELRJ3o06yKVstOyD75zV4E7On9muh?=
 =?us-ascii?Q?2XsdVW1i/dRum4ST2drJvuntlRN1YzS53gMr5wsU9r250fHhNThfD5Dr6Rwn?=
 =?us-ascii?Q?muRFpVZdDwGISzZmDnkgjXAgv5UL0bZioI4htEAS2tsYxw6iV5uQ8IOWFjeb?=
 =?us-ascii?Q?uQVVKxtOYUvAkuXfI4DjuXHhcfKOHe+BZbKXreuO3FzIEEj8cnE6mnMSROb3?=
 =?us-ascii?Q?IL7RWwkrtchLaQ5V0fR9WEsFBTnWMJ6ZUQFF+kt80UZRmUC1YtF75EL8wH+7?=
 =?us-ascii?Q?XMRU/V089NRZv0JyPR+GNmL/M9W27qw6P2MUZ40RynksEQ1WFRWZCUM3wpbi?=
 =?us-ascii?Q?cT1uA0VO2b36Kd+DnbEI1NnneDxRdkSsjtSgrQjooWreENUe3SuElciyBnQg?=
 =?us-ascii?Q?4jRN5LQqEY2L4RQmnLqNz09VnF6EEb/sfcoVm1+z1tsR92Ws0xBlqHyoLAWZ?=
 =?us-ascii?Q?NsnAaIBu7+UFKkzGYfxrwtDO9s5sZeI4QLweqk0Hp+I=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d02e20-66b2-4f70-cd35-08dbc6521e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 09:53:39.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWNFZ3oaL3UzrEB/Kcg4Nqj4kUz8acebwH32DeaLX+e0M1W74DuN+QX9CcM3A9G39XlXhtYlQO67PKXrW25HFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:19:52PM +0900, Damien Le Moal wrote:
> On 10/6/23 04:40, Bart Van Assche wrote:
> > The NVMe and SCSI standards define 64 different data lifetimes. Support
> > storing this information in the I/O priority bitfield.
> >=20
> > The current allocation of the 16 bits in the I/O priority bitfield is a=
s
> > follows:
> > * 15..13: I/O priority class
> > * 12..6: unused
> > * 5..3: I/O hint (CDL)
> > * 2..0: I/O priority level
> >=20
> > This patch changes this into the following:
> > * 15..13: I/O priority class
> > * 12: unused
> > * 11..6: data lifetime
> > * 5..3: I/O hint (CDL)
> > * 2..0: I/O priority level
> >=20
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  include/uapi/linux/ioprio.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> > index bee2bdb0eedb..efe9bc450872 100644
> > --- a/include/uapi/linux/ioprio.h
> > +++ b/include/uapi/linux/ioprio.h
> > @@ -71,7 +71,7 @@ enum {
> >   * class and level.
> >   */
> >  #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
> > -#define IOPRIO_HINT_NR_BITS		10
> > +#define IOPRIO_HINT_NR_BITS		3

Can we really redefine this?
This is defined to 10 in released kernels, e.g. kernel v6.5.

Perhaps a better option would be to keep this defined to 10,
and then add new macros that define "specific" IO prio hint "classes".

something like
IOPRIO_HINT_NR_BITS                10

IOPRIO_HINT_CDL
IOPRIO_HINT_CDL_NR_BITS
IOPRIO_HINT_LIFETIME
IOPRIO_HINT_LIFETIME_NR_BITS

lifetime is really a hint, so I think it makes sense for it to be part of
the "IOPRIO_HINT bits".


> >  #define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
> >  #define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
> >  #define IOPRIO_PRIO_HINT(ioprio)	\
> > @@ -102,6 +102,12 @@ enum {
> >  	IOPRIO_HINT_DEV_DURATION_LIMIT_7 =3D 7,
> >  };
> > =20
> > +#define IOPRIO_LIFETIME_SHIFT		(IOPRIO_HINT_SHIFT + IOPRIO_HINT_NR_BIT=
S)
> > +#define IOPRIO_LIFETIME_NR_BITS		6
> > +#define IOPRIO_LIFETIME_MASK		((1u << IOPRIO_LIFETIME_NR_BITS) - 1)
> > +#define IOPRIO_PRIO_LIFETIME(ioprio)					\
> > +	((ioprio >> IOPRIO_LIFETIME_SHIFT) & IOPRIO_LIFETIME_MASK)
> > +
> >  #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >=3D (max))
>=20
> I am really not a fan of this. This essentially limits prio hints to CDL,=
 while
> the initial intent was to define the hints as something generic that depe=
nd on
> the device features. With your change, we will not be able to support new
> features in the future.
>=20
> Your change seem to assume that it makes sense to be able to combine CDL =
with
> lifetime hints. But does it really ? CDL is of dubious value for solid st=
ate
> media and as far as I know, UFS world has not expressed interest. Convers=
ely,
> data lifetime hints do not make much sense for spin rust media where CDL =
is
> important. So I would say that the combination of CDL and lifetime hints =
is of
> dubious value.
>=20
> Given this, why not simply define the 64 possible lifetime values as plai=
n hint
> values (8 to 71, following 1 to 7 for CDL) ?
>=20
> The other question here if you really want to keep the bit separation app=
roach
> is: do we really need up to 64 different lifetime hints ? While the scsi
> standard allows that much, does this many different lifetime make sense i=
n
> practice ? Can we ever think of a usecase that needs more than say 8 diff=
erent
> liftimes (3 bits) ? If you limit the number of possible lifetime hints to=
 8,
> then we can keep 4 bits unused in the hint field for future features.

I think the question is: do we ever want to allow ioprio hints to be combin=
ed
or not?

If the answer is no, then go ahead and add the life time hints as values
8 to 71.

If the answer is yes, then life time hints need to use unique bits, even if=
 it
might not make sense for CDL and life times to be combined.


Kind regards,
Niklas=
