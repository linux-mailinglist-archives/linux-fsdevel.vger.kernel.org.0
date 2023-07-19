Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F3759E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSTDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGSTDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:03:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ECA1BF7;
        Wed, 19 Jul 2023 12:03:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOYrw000502;
        Wed, 19 Jul 2023 19:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yCUU+SG3diqF1Zpg4pTZfZJloHfpP2dw4DrpVUZUnHI=;
 b=GDH2Y5iDd1g2tRMptcOoH+Rm+neNTF0+iKHTafbCWyySIYRbp0xP4WbY3mcX+6y/teuA
 gFldXtbXVuyMpx7WrmQU8IVuN3oYW9PUWkVw5M554So11yLrriYPxzzwCHKrHYKfshld
 4Thr3d1wrKGKdRjgeruAN/+Smxl9QozGRgsrsWmSd1wPZ9y4NeiefENfgl75yTgYW0I6
 WSfJZ9gKDPGKD27otJj+uf1j5fx0IqDkZYB3hS+3hKxSyZWUq5V0ddSzVpUdqBZcQz9r
 e+HMgcC/1K8/yp15s2CkkbqvKXpSXcEzfeloqzJcAeWuRe0cCln1sddBpp9NUSaEcKwO IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78g6ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 19:02:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JIFuF4007801;
        Wed, 19 Jul 2023 19:02:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw73yvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 19:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4jj/wRAkElgauwhXz4BuPcLH9U3U9aeRxrMDXwHn7oUvQejVWd3QZdFC/BcPS1f5ZHofdA6dmGIRrruRosjSY5ODJep4RJGY6s3SSo7KqsHXdTN/co4M4azdJQF60CK5sfaBiLI+8CFoRWpKHOnK8mc0+hjOGfHRnBxCxFJUj3S79kukNCxm5F/EsYHdSQgpEbVt0yJM/kUiR8qkQP1dHxH/5obHnQdSm8qlsra0U+LJDEpsORLaHyFDmZCtwOTsIh11C9irDb/mwmH1L8Khqw7GODp61rTwE8l+dzmMltebJXCfEpyMCZhkqbr5xnYmuvGAvKAPo2W/2v51mzjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCUU+SG3diqF1Zpg4pTZfZJloHfpP2dw4DrpVUZUnHI=;
 b=L8MGQs5n7fyoKZtXZJEekzZ+mS6Cv95V1l+ge8lbboq3AgOc8bprUPxIddHVeCFf9JSJlP7Mx3mi9p64lgVQPnIrUW9JCRy/J79t2e1SGKbEYBjJXSulYGSAKizFl9eVvPmln17bMPijZMYfqd6AGQY7qROo64a8Tjf0jn1JKQ8NTOOzELac7py0Zfxxmvy+B85Vo263zbnc3XFEhMniNw+ZNcAT2IjA8TFQPpNhHrAUNxgsLJg7pKcUBC9mGn6ZlOwDMMX2y3vC7RlGQpMI2I8lwb3VLRkRgsc5N2LjxNOi/olPli1WUb7YbxZDaVcgHCwWCNnW1sos7HENNLKK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCUU+SG3diqF1Zpg4pTZfZJloHfpP2dw4DrpVUZUnHI=;
 b=Rp7azAoEqIn5RqPZxdUiDp6zgRSNOJlaB98RD8quM6B/YA9PI+cWXhiD1ZylDC4QN3Tmqx2oDvobXIUgtgeEM1lWWgvpy8QraH+Pw6HKAwhWIr7kuqhRaWWKLi5Ree3F15pSdfxXSSF3bmEx4wGEULiuJHOw2v8HnhZH/EA5WvY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 19:02:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 19:02:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek@diasemi.com>,
        Andreas Gruenbacher <agruen@redhat.com>
Subject: Re: [PATCH] nfsd: inherit required unset default acls from effective
 set
Thread-Topic: [PATCH] nfsd: inherit required unset default acls from effective
 set
Thread-Index: Adm6c5gGRlQ8evk80kW2LIRQLL6xCA==
Date:   Wed, 19 Jul 2023 19:02:41 +0000
Message-ID: <0FE91AAE-0A90-4856-B9F3-A2CC4B4A94CC@oracle.com>
References: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
In-Reply-To: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4293:EE_
x-ms-office365-filtering-correlation-id: e81a55c7-1d27-479d-9564-08db888aba81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5664RaUoC7o/wfb+571J0H2LOhPA/NYQGVTDa/hY+p3JJkCqCRDjpZc7QDTcP7exHyBIlLpoFvlAvImHULrtAaAcq5CrQIIeTRG3tCthAritRUBf4bi4kFpoTT/bb3HbbahCrJjATHve8eaLH5x5ZDu07og8oRtVtkA+b5cEbibO4Oqn6TwR5nSQHoKLquB3AV+V3NwgJg0OFoSzrlNioNcjopLpgsXDvBe16NtlLsbZp37GXVFLbVGC7t/cQZEm7ZlwaPBYZYNiwLjGe9TpvZW7h7pXrKD3sKgdmP7Gu8hUhocn1Qo8LnEiOR/nWS1KG2zhsUNtRYKpB1ipY4D71W4VdvMJTfDEXlTmR8SUdilav1xtZqPg8W4AQbsZeWh7a+lg4toPQ+xGfjst3mkXjy8CCXcN/AQUqHw/Thk68OKMKyBvWIXMvjmwt/V3YBSJkkKgqbg58Qr6pVuARDljTIbDJzc+XI96OJLKy8g4y3m1snbPKeEzXIn+GLV9vfXXlpGHxO4ib/f77PQGn/ASFT5v250NOxTMJsz0P+6fnZh0+x9TtWRlX+i8ZG5WU5QMcUMLY5lv1TI9/U94cIuWMV12FXw+s7HmX7kf5j4+B9557BijAzDD4Kpx5/tsipvXV+1NdERSSBFzUV9pgOPTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(86362001)(41300700001)(316002)(8936002)(8676002)(38070700005)(5660300002)(91956017)(54906003)(66476007)(6916009)(76116006)(64756008)(66946007)(66446008)(4326008)(66556008)(122000001)(33656002)(38100700002)(2906002)(478600001)(6486002)(36756003)(186003)(6512007)(71200400001)(966005)(83380400001)(53546011)(6506007)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bUBmdrAS96cGaemn4Mkbgydn2/Stvgf7WKO5GRyEDOeVpI9DCyLDy4eNkvvj?=
 =?us-ascii?Q?jitO9gDZ02f3wlsw5VZP63pfplQ7miNCYZI81TmQuGfEwxhGuyyZ0xR0A3uu?=
 =?us-ascii?Q?CRYl00gucIDBgujriO38KGPSIyO5VGkmGUo+2Z2J5tld4z69hPQMXNq/rsaC?=
 =?us-ascii?Q?08CjSyiI2GcBMP/oo/cZG9mHln5VabNiFAiEy5A5tIPMtGHC/7uBUtes9aIh?=
 =?us-ascii?Q?cYbSPCmeu0fywW5Q1vAj6UfSO8oVxtkCI9s/+Le5Mz9nNGvcbuLNTN56XeVt?=
 =?us-ascii?Q?8cDD2ztVW0iV00ZlQg4d8P0SKjdwvDAxt0JpjwBu4XijS8R5VPAmacznNTyq?=
 =?us-ascii?Q?RMescmBdDeAOJvgFqj1TyYhegbPKZl6tEkXMZqxX0zyvoW+d2XZXAkIuzUlt?=
 =?us-ascii?Q?i/i+zVI+8CL9LfYh8lxpqo7EIRv3jM6vf2mdyWLJKJMR0ZZhCzs7E1MNjcZl?=
 =?us-ascii?Q?guYzwiGS/tnBvF2F42reN0Y8K8N1k8Ds0O7Ci/xvR/bpSd3Vhmtxvop2/SvH?=
 =?us-ascii?Q?2rLetOPUAAjMa74iTmkIhmvFG0uA2tUfCbGAB0K8gSLhSHdz+qpkNqDdo9qR?=
 =?us-ascii?Q?v1nvgEZ23+4B8zvN7O5THqescFIdPVUz0lUz8J4Ux1ZCOFmMNsiwfbkV51qf?=
 =?us-ascii?Q?hWuMxK28OKxm4K1zg2vl+4+a++yk+b/hKSTDEzUl2ZqaHQb4vzIdejT2qPwZ?=
 =?us-ascii?Q?3nc+7ZsdfEohzNMJv8acK3Yvh7wEAdt+1iPeNrb9wCbsMAXTGoTY+sD1/WC3?=
 =?us-ascii?Q?QCOijR/DAxpahN7GO7TNbA5beP7RA9KdBjwRJQNdRiw9to9UkPnenhGIq2sT?=
 =?us-ascii?Q?NK1Lp1Af1nvLnC7dz6nB49z8IjbAjExy/Fw2FrXM50FXvHFhJccGPg5XzkC8?=
 =?us-ascii?Q?oiZSjYbgPatTao1c0M7YHmxxbhRr8mgYsJzVI0BVaSPLt3TFclOeAfkpgPBH?=
 =?us-ascii?Q?Cf7GEhLh5eTrq8NDMOwime2Q6v6YvADy1aHae3NT9fJKbL3kSKXtR3UF7KAb?=
 =?us-ascii?Q?nxVEPbTvs+2Axh/Zvw52hwxbZCYBGysq1kYFPGnp5rL8mz13hp3BlzAhndbo?=
 =?us-ascii?Q?ItuOndvIx3Rncw9r6ewKGKcovVhVIAsUPGHBOLYfzs5ynHIq6n9zm/lt6BWY?=
 =?us-ascii?Q?TLKE6D7U8QmpUrvxFC7VZcn+NrkQmXczl84kSsXT/mhsDXeHv2glDJfZCM37?=
 =?us-ascii?Q?raRSvVu3OsiawtnoX23wLhzHVe9MBcpT16wHCE68Dvi189VMCpY8AR7VYxyC?=
 =?us-ascii?Q?X5ohbpNqLsN22LWGVPLz8NkRwyBk1UJisje4VmcGgT60AGmDL0is3FVMKG0T?=
 =?us-ascii?Q?gvr9lTB4QiMlBTdRfjU1LJlH/Y03teDQ1CFzIyD7XjfyqonRlbcD5CC/so05?=
 =?us-ascii?Q?TsVAY/t6ZNOs7l4SMsyy4T4Lf0rISmt+5M0wP+74Z3pcsYWmmVWnHzCvrmgq?=
 =?us-ascii?Q?sbfIbT9LRGo3r5OSwewD80jp0Elh1/eNTnntPrpXuKKM4NOFmmD2TGw4fVdR?=
 =?us-ascii?Q?+oxlVfejLAYqOSxIv9bq6ZOd6OmDP7GTpc9XZTbNsAC88Ge5Y6iQtzobTkcv?=
 =?us-ascii?Q?Ja/04hHd+SvRlh1l+xd0EVGb0ewxWmRN6ThHZFt5/xEi83WZZpOXEmQQ9lon?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53D55AAF6C874648B65E64F63526419B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hdgQavuzjFuPauCIgi0dNOTJiybCqm+a7fvDavfgO2XXUx71KE7fLyWJW2z/?=
 =?us-ascii?Q?6OzMg+JY6nvVs2DDgz65Vcx1t1mgqw8os65u9bU6Q1SIRysiM8KUm3NSKIup?=
 =?us-ascii?Q?Xj9ZTUtF/f5HegPGR3XVLfGujJgghitF9LkniIMSUbW9ihV6nRqHP1YOn2Ms?=
 =?us-ascii?Q?c1B0Oiy23ZMpOtaPu5I8NY/i38hEWAFu8VjRYyggno3xgdy+2EoayELYIwrr?=
 =?us-ascii?Q?C40RFT3HlP/dAwv6OVXKvlJnbYA5UX0Y7ZOHbA89xjW+YGK2vM8vhFsVu88y?=
 =?us-ascii?Q?kHnnLjroE0+YrA3zPFlEufxdZkjZ8i25XfOiaeQ9OqrRfyAOBd4dgE8id1Jz?=
 =?us-ascii?Q?C1qDYJ4NnwznYX8cYurC7exQqsBYXZ9R8kVbeN7CBLm/eKJIdRkJ1eKDNCnN?=
 =?us-ascii?Q?9nihvTfyK5IQKLfeZGbq+EJBpBQCcqNzqPBBTqWFBFsw9EGK8YzzuHZgwiUz?=
 =?us-ascii?Q?YHNYLCJoxuiiM/PyX8DJG4tzE1mMTAATh/9cFm04QTx7jlzJre1TKvo5L23e?=
 =?us-ascii?Q?32dC5XhaxpwLs6K+U+JPky60L/YIKSuDXThXvM6e58BQc/ufgwDqGqlli9+R?=
 =?us-ascii?Q?UaWKYEn/azQVfEUoHd0SdP13+f2nISqwY041AzkIaCHEFua5nsbIwi4u2glJ?=
 =?us-ascii?Q?5sOjGAoB9wE0IV2isHdzO0j7OwYhK8GuHfQM2TnPXgl8UidSvfrOlaYKs0EN?=
 =?us-ascii?Q?Xi1gpb0Au9LXIPm3SOgDSUQt2TwbUvUFL0bwMtM7w0NqtbVzp/xOLvwPEZoR?=
 =?us-ascii?Q?diPFlm5TGUHWbTNSbYAxXlW4MiSD6PVCCIE60L50/RERqOvjUICZOFmEaNcI?=
 =?us-ascii?Q?tmAauQGfevWhsDAzXNK3AIR7qBUUmq6kx6PHv8f4BRQtsfDCA1MA4WLj/Tr2?=
 =?us-ascii?Q?w1tJFDmCrhh7uvsrzy37LegNoFBjaiu7dT0/O8NvmyyAi+r7NhQTySsTzbb0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81a55c7-1d27-479d-9564-08db888aba81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 19:02:41.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3UFKBWlGG5c7vRyDEqe02ml3UoExZteyIxJVOg7RoVFkksUElF8+2MRAvGyRzbJ/bQqM1nqGlqFn3COAglFgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_13,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190172
X-Proofpoint-ORIG-GUID: O2QUItfmUzCvyFhHia5rujdnfesqd8N7
X-Proofpoint-GUID: O2QUItfmUzCvyFhHia5rujdnfesqd8N7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 19, 2023, at 1:49 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> ACEs, but there is no requirement for inheritable entries for those
> entities. POSIX ACLs must always have owner/group/other entries, even for=
 a
> default ACL.
>=20
> nfsd builds the default ACL from inheritable ACEs, but the current code
> just leaves any unspecified ACEs zeroed out. The result is that adding a
> default user or group ACE to an inode can leave it with unwanted deny
> entries.
>=20
> For instance, a newly created directory with no acl will look something
> like this:
>=20
> # NFSv4 translation by server
> A::OWNER@:rwaDxtTcCy
> A::GROUP@:rxtcy
> A::EVERYONE@:rxtcy
>=20
> # POSIX ACL of underlying file
> user::rwx
> group::r-x
> other::r-x
>=20
> ...if I then add new v4 ACE:
>=20
> nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
>=20
> ...I end up with a result like this today:
>=20
> user::rwx
> user:1000:rwx
> group::r-x
> mask::rwx
> other::r-x
> default:user::---
> default:user:1000:rwx
> default:group::---
> default:mask::rwx
> default:other::---
>=20
> A::OWNER@:rwaDxtTcCy
> A::1000:rwaDxtcy
> A::GROUP@:rxtcy
> A::EVERYONE@:rxtcy
> D:fdi:OWNER@:rwaDx
> A:fdi:OWNER@:tTcCy
> A:fdi:1000:rwaDxtcy
> A:fdi:GROUP@:tcy
> A:fdi:EVERYONE@:tcy
>=20
> ...which is not at all expected. Adding a single inheritable allow ACE
> should not result in everyone else losing access.
>=20
> The setfacl command solves a silimar issue by copying owner/group/other
> entries from the effective ACL when none of them are set:
>=20
>    "If a Default ACL entry is created, and the  Default  ACL  contains  n=
o
>     owner,  owning group,  or  others  entry,  a  copy of the ACL owner,
>     owning group, or others entry is added to the Default ACL.
>=20
> Having nfsd do the same provides a more sane result (with no deny ACEs
> in the resulting set):
>=20
> user::rwx
> user:1000:rwx
> group::r-x
> mask::rwx
> other::r-x
> default:user::rwx
> default:user:1000:rwx
> default:group::r-x
> default:mask::rwx
> default:other::r-x
>=20
> A::OWNER@:rwaDxtTcCy
> A::1000:rwaDxtcy
> A::GROUP@:rxtcy
> A::EVERYONE@:rxtcy
> A:fdi:OWNER@:rwaDxtTcCy
> A:fdi:1000:rwaDxtcy
> A:fdi:GROUP@:rxtcy
> A:fdi:EVERYONE@:rxtcy
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2136452
> Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> Suggested-by: Andreas Gruenbacher <agruen@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

As you pointed out in the bug report, there is not much testing
infrastructure for NFSv4 ACLs. It will be hard to tell in
advance if this change results in a behavior regression.

On the other hand, I'm not sure we have a large cohort of
NFSv4 ACL users on Linux.

I can certainly apply this to nfsd-next at least for a few
weeks to see if anyone yelps.


> ---
> fs/nfsd/nfs4acl.c | 32 +++++++++++++++++++++++++++++---
> 1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 518203821790..64e45551d1b6 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -441,7 +441,8 @@ struct posix_ace_state_array {
>  * calculated so far: */
>=20
> struct posix_acl_state {
> - int empty;
> + bool empty;
> + unsigned char valid;
> struct posix_ace_state owner;
> struct posix_ace_state group;
> struct posix_ace_state other;
> @@ -457,7 +458,7 @@ init_state(struct posix_acl_state *state, int cnt)
> int alloc;
>=20
> memset(state, 0, sizeof(struct posix_acl_state));
> - state->empty =3D 1;
> + state->empty =3D true;
> /*
> * In the worst case, each individual acl could be for a distinct
> * named user or group, but we don't know which, so we allocate
> @@ -624,7 +625,7 @@ static void process_one_v4_ace(struct posix_acl_state=
 *state,
> u32 mask =3D ace->access_mask;
> int i;
>=20
> - state->empty =3D 0;
> + state->empty =3D false;
>=20
> switch (ace2type(ace)) {
> case ACL_USER_OBJ:
> @@ -633,6 +634,7 @@ static void process_one_v4_ace(struct posix_acl_state=
 *state,
> } else {
> deny_bits(&state->owner, mask);
> }
> + state->valid |=3D ACL_USER_OBJ;
> break;
> case ACL_USER:
> i =3D find_uid(state, ace->who_uid);
> @@ -655,6 +657,7 @@ static void process_one_v4_ace(struct posix_acl_state=
 *state,
> deny_bits_array(state->users, mask);
> deny_bits_array(state->groups, mask);
> }
> + state->valid |=3D ACL_GROUP_OBJ;
> break;
> case ACL_GROUP:
> i =3D find_gid(state, ace->who_gid);
> @@ -686,6 +689,7 @@ static void process_one_v4_ace(struct posix_acl_state=
 *state,
> deny_bits_array(state->users, mask);
> deny_bits_array(state->groups, mask);
> }
> + state->valid |=3D ACL_OTHER;
> }
> }
>=20
> @@ -726,6 +730,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *=
acl,
> if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
> process_one_v4_ace(&effective_acl_state, ace);
> }
> +
> + /*
> + * At this point, the default ACL may have zeroed-out entries for owner,
> + * group and other. That usually results in a non-sensical resulting ACL
> + * that denies all access except to any ACE that was explicitly added.
> + *
> + * The setfacl command solves a similar problem with this logic:
> + *
> + * "If  a  Default  ACL  entry is created, and the Default ACL contains
> + *  no owner, owning group, or others entry,  a  copy of  the  ACL
> + *  owner, owning group, or others entry is added to the Default ACL."
> + *
> + * If none of the requisite ACEs were set, and some explicit user or gro=
up
> + * ACEs were, copy the requisite entries from the effective set.
> + */
> + if (!default_acl_state.valid &&
> +    (default_acl_state.users->n || default_acl_state.groups->n)) {
> + default_acl_state.owner =3D effective_acl_state.owner;
> + default_acl_state.group =3D effective_acl_state.group;
> + default_acl_state.other =3D effective_acl_state.other;
> + }
> +
> *pacl =3D posix_state_to_acl(&effective_acl_state, flags);
> if (IS_ERR(*pacl)) {
> ret =3D PTR_ERR(*pacl);
>=20
> ---
> base-commit: 9d985ab8ed33176c3c0380b7de589ea2ae51a48d
> change-id: 20230719-nfsd-acl-5ab61537e4e6
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--
Chuck Lever


