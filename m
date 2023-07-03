Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C275745D30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGCN0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGCN0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:26:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81022E54
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 06:26:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DOagX015704;
        Mon, 3 Jul 2023 13:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5B+qdllfx7Af0C4qPPVt/lWAzczq0wUBQwpLG0fT9nE=;
 b=z2fAvEFxXTf58i2M9cRuAtkN87dPXjqe1lybAhYSD3CDLUjgyG/XGs2TkdPwXCQzHwbR
 dfEOIplBDKaZxjagYkfzICtebIiPNHP4mbsUq+092RAz/1OCtcvJJimcLvEPk0D9+Vjx
 ufSkjXGc076ovI8umkGLOsmVbc52LNnrC5BgBI1bdJH91yDkutAwA/bDYvj0Y9yrqBPS
 y1lK13XmBt76pi0Shn9C8XptmQ/3woeKZfH1F2xy13RZwqzAtiazx3I4l1P0Ue3LhzqY
 2b+FSAJ734T0iuAupJpe1K+YPAvbaUz8LRhA2cIrhU7dJggEbVr4AXqG6VgAwOnQAlkH UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjb2bjp8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 13:26:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363BigsF020829;
        Mon, 3 Jul 2023 13:26:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak33ddr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 13:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6H6usqGEvhAPybCJvfidE8rBT5a6Yb0C3vUCpZzLtQOVN303sxm1EHfLpVH6kNX2/cOjQdJ7cBhryxGX+o9Npoyezhh16ZSlTc9FS6o6rBfqwzyH+mxG24EQFkrwRK6W/bDlr03dIavVC4rVzRQelrYtLm+OijPWi4LOZEXoLGKIrN3xGirMdpRHWG7SKXuidcDCQh+AZ9beo+1utTmpjDT2kV/vMg5PjxIJMWJfv654MpXvbjXTY4gndJf0WUAwM1loxbEGRbie2dr08lmYJVRGKC7db22Hthzer+0yWMNV30m3uUwD7F/GrsT/EvwTF27/LrPxd0NkAd6emc14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B+qdllfx7Af0C4qPPVt/lWAzczq0wUBQwpLG0fT9nE=;
 b=iplQe4bKK7PGH3dFROzgTXcL3UhBMALiFxlhOEojsNc+Cz/aQFSpvCmbEMKhF2o+s55tdSLgQBMEhAEePmOVLUgVt+shbr39Yib03B4pGFMdh8nXhWHihjPlQi4dXZO7oJp/X3tN8jrRuimcXRNJyHZuZxQEMwR4yn5DiVsSO2reeXFhvlKUS0OxYw2FO6l0amIkCNE0miLlFWc9OTHPvQnm4MB2mi4q2RKOB/LEyf8DMzbZqZaHnmrW35o88qGmZ9vtkY27AunQaLraB6mwleBG6p+oTbclGFlYq8DAUtbBhk8rFbH7C6eg85tIhVsavgeu6caK7vDWEnmObOaaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B+qdllfx7Af0C4qPPVt/lWAzczq0wUBQwpLG0fT9nE=;
 b=p/xXu4qMCdcD9rxB2CNY2Or9YgB/sawbo4wnwB8h6LFdtSonhkjeMwL0SsKdnTAj81MwTRjdgg2Jl4yQ7q8AN4wIIwKSC7yftHDaDUjfy+J0wHgKZPJwRXgPOQmP4SGtnGpspWyw1LDqyXj2x2Lc96IhhSvm5CC9DWnE1MBoj60=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7952.namprd10.prod.outlook.com (2603:10b6:930:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:26:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:26:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] libfs: Add directory operations for stable offsets
Thread-Topic: [PATCH v7 1/3] libfs: Add directory operations for stable
 offsets
Thread-Index: AQHZq3sl+VgeLNYMGUCf8MhAiThA0q+n4vmAgAAp6YA=
Date:   Mon, 3 Jul 2023 13:26:18 +0000
Message-ID: <1D42328C-CCD1-43ED-8259-DABA1A5A434B@oracle.com>
References: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
 <168814732984.530310.11190772066786107220.stgit@manet.1015granger.net>
 <20230703-semester-geklagt-227cd899b31e@brauner>
In-Reply-To: <20230703-semester-geklagt-227cd899b31e@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYXPR10MB7952:EE_
x-ms-office365-filtering-correlation-id: 63a0623a-6683-46d3-1d51-08db7bc915a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8BWfFYUHArspxwJL02CsVo6bcxC4EII5Zc6vUFP+3/fzjXtnXmdWOSnp/Hpf1QwROQbVKXWwsPS8M1KztmhhVX3IBKW3fP28Bm2yD3fel+Uy5HMD/umABWSp7P1UEceHoioL2WVLPVNE7QKh7vDwBX7GmjHa9AQEMtzK3MCWVAKC6iO9GMyGVweU2NsKQVPQ3Em6sGQNYE6e52tpuwiPCVLa8qTmlMyO0zeuIol/DdyfgwDSo0tDez6uNaK1dp9r90geHW/MyZJ69U0k6Ry7YwHxvIR9/XUkzsCf2NOcaI5DIFeHR/julm24wpL2xQAcp5/VBnOQxLy//FZaUAot4+ZzB0/KYpSJ5RCyoGK57heN6CZ8wqOAAytfeuBctdy6qhd5sp1r3k7v6Vvktc63FU8FLjvDFBxjN66KP+GdJBi0im105N+1y/bFXt5g4ooexJSWaYg57K9/EGycd/6TWJ2vy4cgGtMEUUNNNZz9bs7Qzlx1ZT0Cef6F5Mu9pKXZS+tU4kLyxK9jN8HSJqO3FhKyFI3/mb0EasU3UFJsNh9zRr26UAy5mI16MW4De9mzQ0lMe7emwT54e6Jw1fGkKEdYdF57m5UZekl9jUOHBDkHt5gsZFYcsqoqg08WUPJcgw72zd2kOEEX3jLwnsfBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(316002)(41300700001)(6512007)(6486002)(53546011)(83380400001)(26005)(2616005)(6506007)(186003)(478600001)(54906003)(71200400001)(122000001)(66899021)(38100700002)(66446008)(66476007)(66946007)(64756008)(66556008)(76116006)(91956017)(6916009)(4326008)(5660300002)(33656002)(86362001)(38070700005)(8676002)(8936002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B9gRLnrqNeUB5K9vQO/nrcbvqkXIe/CWHT7QTj2hLJ9QGqLnksQ7URoqffhW?=
 =?us-ascii?Q?BJiF0qWWT1rK+JRWF7pn0z4VDMO7WzdZQSX34S9MPw+BW3SXrEptjZX3wGef?=
 =?us-ascii?Q?bemZeAClevMhLGDw2a49xR8RXe8NHOFIGxppH2ZCqKsRfGb3uoezEGZNsp+5?=
 =?us-ascii?Q?uHKXmeXm1ElFMhkO8y3MNUVCyRcBqjqqdmIJ4dER58VusJr9cui+GGToSE+N?=
 =?us-ascii?Q?e3Ajme+Xpq9QTPZp4bTRL88mQd4XSPGcLO3bIYN2dnk8ucrUbwkesG4t/PAI?=
 =?us-ascii?Q?MPM8H99i37sXWf7MA/G4RYrzYbv405dGr+tpAvSKsD/cS3WFW6X9qIv9B63g?=
 =?us-ascii?Q?OPrV3z8oVFPHVSMKjBHXvLsvBLP4qBvrRXeivHtxP+7B8CilZ8Aow0kS4Qrv?=
 =?us-ascii?Q?Utr8p9jZrBvcc0iXjRwAmDNjuVJy2tAcp9MtaD2wQaVGTd9DQ//MtGW06iR6?=
 =?us-ascii?Q?/ye/R6rBjD3uK3R708IzJr8ihRhRZRcr+51PyFvkwxiRJVh7bgVZX8m4s5Yy?=
 =?us-ascii?Q?xB73Lv6kWU8pzcapeWVPNdQDiLt4UYCTptLHNegU03/uqjPB78R77CrvMQo+?=
 =?us-ascii?Q?P4b3uwzfFB4A2Hpo4WOT/488d3RDjhmCbMBKC7Lc4pctAoVEENnLoSBZsGoj?=
 =?us-ascii?Q?loYp8nNsWW30Dihx7NDs/HWYP6CfxCDl5zRzPKs42tYtGTPWd9nVUrRAlVFX?=
 =?us-ascii?Q?LxY22Nhqxkk+7dlrMvato4luOO/JEWTUcGA800JUQehhn1xOn9X5Yx5OJaiX?=
 =?us-ascii?Q?9tKziIcpoxvSWXUU1m1lrAK3fBciZJ40JkxdHFs5PT07WmN2L6h/TvNGvREv?=
 =?us-ascii?Q?Z8Ec3nJAy3EZBBHK7wW5m0cR5izh4Ae6jIecMZtQzy09InhGZkn9NCtrTBQz?=
 =?us-ascii?Q?6XAlFlzh2jCa8xbyckHYJzo3DIZAQfy8XQPo99lx9ksHFZsc/iYs1vVKrFi7?=
 =?us-ascii?Q?4eNzivbj5ZgmQnUVKLjK6+mgfZKczjGZ/qPbTxivmTSZ1HFjI2ERzioQaIEL?=
 =?us-ascii?Q?ZJjxyZxjM1hWlFZkpeYtPFneCIY+36jzdpj+DkCNAF53X5XuUEiKOh9GZftH?=
 =?us-ascii?Q?QxOkWrLkTjh5v3vFdavf2DXEYsIck9c/azqR+YSUAaej90peMc2WKq1pVikZ?=
 =?us-ascii?Q?Ui9SOaWEkJ8tQeg2hvEntX8yBWQVEjWnf9wbaJBrGegqAclntV4r3CIUNemZ?=
 =?us-ascii?Q?IM7iYT/YTbSpFbjRV+zU9cFFS2iODMBEQAM3A1igNXlI71QG6RTfbcZYV8Ot?=
 =?us-ascii?Q?uIiCCBy4BivgEUHhbBRTTR2pPDTW7a4ofT8tWZcS1zr7PiOTlPj9A8n4UGCD?=
 =?us-ascii?Q?+gW11UxEEPIC54ju9BLHEvLf7OMPaPvW2Z6B/MKIvmfUep8nxogGxJYjyrwZ?=
 =?us-ascii?Q?AkLPkY66pdlx8KgOcVYr7pBaPV1NWdFkp8yjr7BDzxdf0VLyap6hjdbYyuSu?=
 =?us-ascii?Q?QKdO1hLS2iuyCml9ZnKT8+dkmCQB99QpxMj9cjDTtvmQqSsy1xTWk7TnkBPK?=
 =?us-ascii?Q?qqAjSKSkM5hPOUCUtZKGvKriIgA3Sze0ZaNaZ3fkFo+nuolmVLUMWu6Bb4eO?=
 =?us-ascii?Q?lHqe6KcHSBi7JHsFK3JCYeg266si5y7OCaSMd7K8gTmJEpXG2UEFAbvB3hYU?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CFA02F1A5CF884DBA91C73529AF2139@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0AkV6DFEqHkWzE5jm/TIYLwOAbd/oM67XFC1nJ166UDJ7vJ0eoR5HmIg89b3?=
 =?us-ascii?Q?VFK9lP8NNuE/6gZ8XTL0cKCK+zFsk86FJm13P6BDS0YKGYpnrwKRg0iUoa2j?=
 =?us-ascii?Q?u8GQFskJ1UPEbEWt2Si2DzvrQUCLW+CXGb45OeF8ZY6nlx4O591iReiqGgbG?=
 =?us-ascii?Q?rAbPlWyKjXYgKFoJjJBhBPVo3b0/s8kIs1Ac4sAV8koFD+Als0A/7xjFSgoD?=
 =?us-ascii?Q?J3Sy7xAjR1DCuK3FHBiJe6TdyIAMCJsIEnqHATwFQeS/fp3Vk8mxz9d+XZwG?=
 =?us-ascii?Q?ydDa9wRp7SDsGBXV/+zN1epyjN556CG5Hk8qy2Nto9KEM88teNsGy8iCR+7v?=
 =?us-ascii?Q?oOpeZ33Vtm6GKn/SuqwuRBmInC8vAgM5lpZ/PVNyIPj2Tw6OgiFi12UwZ22e?=
 =?us-ascii?Q?XyAJu77jKjgdeVCeyZqHJUsa9eLYy4PNFX11rn9qc8Ao1IfBvyfsA8FZdcwZ?=
 =?us-ascii?Q?aM16dAWsHln4a7p+m6bz9NMdUYmGx9Fe5AeKcg3tHxyghZxEVQVXuIILbCNA?=
 =?us-ascii?Q?6TksNdQtEuJeHaEgf0hi/nvETwn2q01S5t8VGz0NyJKpPTbgurKfhwTQ9/n1?=
 =?us-ascii?Q?FUZ9MJytzskm0/FrvukZ7nUa5k35WuVQuFp0nR254klYYOnqkFlDpZj5OgKX?=
 =?us-ascii?Q?FpXhoDrsElDRWnazdFGi2CPs9L4zt/N0JznnGFYzUO2PK4O16JSyFYENsvR4?=
 =?us-ascii?Q?SsP9yVvhymTYzGiVwGxjZhW2jmtAQ5M18c2QFx4hOmRZBrLKWXeeRbJqibkd?=
 =?us-ascii?Q?VNKF5DY53bnjgofJEq34x9EU6KVNytlcALR3XCFHz96c5QnjGdG6fXnQBDmM?=
 =?us-ascii?Q?6PjYaUGOzViVkV3kUz9pvXwxrJD4oG9O1oOWUz5a2UXGVifzAryNF9ZPs+Xe?=
 =?us-ascii?Q?9ev+rVYgxTmKkJj8ISmksOPtS16dVhHpi/dt7oqYz+MnlV94TriQ50kR6IrQ?=
 =?us-ascii?Q?QWkQCBtxYstx9HplaWK+imqvvZlDLTYiRMtcCCU5h58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a0623a-6683-46d3-1d51-08db7bc915a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 13:26:18.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CPamtqt31cMRJBTyBMcwa68uCFx32EwhJEw4BgnyXjWiW8CgD63JZu1frfreMS8MyGqNnOzNF61cX0IWozdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=991 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030121
X-Proofpoint-ORIG-GUID: BftN6Jqh3SLsKCPJzczT413MXRNHabox
X-Proofpoint-GUID: BftN6Jqh3SLsKCPJzczT413MXRNHabox
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 3, 2023, at 6:56 AM, Christian Brauner <brauner@kernel.org> wrote:
>=20
> On Fri, Jun 30, 2023 at 01:48:49PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Create a vector of directory operations in fs/libfs.c that handles
>> directory seeks and readdir via stable offsets instead of the
>> current cursor-based mechanism.
>>=20
>> For the moment these are unused.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> Documentation/filesystems/locking.rst |    2=20
>> Documentation/filesystems/vfs.rst     |    6 +
>> fs/libfs.c                            |  247 +++++++++++++++++++++++++++=
++++++
>> include/linux/fs.h                    |   18 ++
>> 4 files changed, 272 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/files=
ystems/locking.rst
>> index ed148919e11a..6a928fee3400 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -85,6 +85,7 @@ prototypes::
>>     struct dentry *dentry, struct fileattr *fa);
>> int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>> struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
>> + struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>>=20
>> locking rules:
>> all may block
>> @@ -115,6 +116,7 @@ atomic_open: shared (exclusive if O_CREAT is set in =
open flags)
>> tmpfile: no
>> fileattr_get: no or exclusive
>> fileattr_set: exclusive
>> +get_offset_ctx: no
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>>=20
>> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesyste=
ms/vfs.rst
>> index cb2a97e49872..898d0b43109e 100644
>> --- a/Documentation/filesystems/vfs.rst
>> +++ b/Documentation/filesystems/vfs.rst
>> @@ -515,6 +515,7 @@ As of kernel 2.6.22, the following members are defin=
ed:
>> int (*fileattr_set)(struct mnt_idmap *idmap,
>>     struct dentry *dentry, struct fileattr *fa);
>> int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>> +         struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>> };
>>=20
>> Again, all methods are called without any locks being held, unless
>> @@ -675,7 +676,10 @@ otherwise noted.
>> called on ioctl(FS_IOC_SETFLAGS) and ioctl(FS_IOC_FSSETXATTR) to
>> change miscellaneous file flags and attributes.  Callers hold
>> i_rwsem exclusive.  If unset, then fall back to f_op->ioctl().
>> -
>> +``get_offset_ctx``
>> + called to get the offset context for a directory inode. A
>> +        filesystem must define this operation to use
>> +        simple_offset_dir_operations.
>>=20
>> The Address Space Object
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 5b851315eeed..68b0000dc518 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -239,6 +239,253 @@ const struct inode_operations simple_dir_inode_ope=
rations =3D {
>> };
>> EXPORT_SYMBOL(simple_dir_inode_operations);
>>=20
>> +static void offset_set(struct dentry *dentry, unsigned long offset)
>> +{
>> + dentry->d_fsdata =3D (void *)offset;
>> +}
>> +
>> +static unsigned long dentry2offset(struct dentry *dentry)
>> +{
>> + return (unsigned long)dentry->d_fsdata;
>> +}
>=20
> This looks fine to me and tmpfs xfstests seem happy too. Currently we
> use unsigned long in some places, and u32 in some other places.

The two types are in response to the xarray API, which is a little
confusing (sometimes it wants a ulong, sometimes a u32). I tried
to make the type casting explicit wherever possible.

Your clean-up looks like a readability improvement to me.


> It's not
> a big deal but I would prefer if we kept this consistent and made it
> clear everywhere that the offset is a 32 bit unsigned and that the
> xarray's limit is U32_MAX. So I would like to fold the following change
> into this series unless there are objections:
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 68b0000dc518..a7e56baf8bbd 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -239,14 +239,14 @@ const struct inode_operations simple_dir_inode_oper=
ations =3D {
> };
> EXPORT_SYMBOL(simple_dir_inode_operations);
>=20
> -static void offset_set(struct dentry *dentry, unsigned long offset)
> +static void offset_set(struct dentry *dentry, u32 offset)
> {
> -       dentry->d_fsdata =3D (void *)offset;
> +       dentry->d_fsdata =3D (void *)((uintptr_t)(offset));
> }
>=20
> -static unsigned long dentry2offset(struct dentry *dentry)
> +static u32 dentry2offset(struct dentry *dentry)
> {
> -       return (unsigned long)dentry->d_fsdata;
> +       return (u32)((uintptr_t)(dentry->d_fsdata));
> }
>=20
> /**
> @@ -296,12 +296,13 @@ int simple_offset_add(struct offset_ctx *octx, stru=
ct dentry *dentry)
>  */
> void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
> {
> -       unsigned long index =3D dentry2offset(dentry);
> +       u32 offset;
>=20
> -       if (index =3D=3D 0)
> +       offset =3D dentry2offset(dentry);
> +       if (offset =3D=3D 0)
>                return;
>=20
> -       xa_erase(&octx->xa, index);
> +       xa_erase(&octx->xa, offset);
>        offset_set(dentry, 0);
> }
>=20
> @@ -322,8 +323,8 @@ int simple_offset_rename_exchange(struct inode *old_d=
ir,
> {
>        struct offset_ctx *old_ctx =3D old_dir->i_op->get_offset_ctx(old_d=
ir);
>        struct offset_ctx *new_ctx =3D new_dir->i_op->get_offset_ctx(new_d=
ir);
> -       unsigned long old_index =3D dentry2offset(old_dentry);
> -       unsigned long new_index =3D dentry2offset(new_dentry);
> +       u32 old_index =3D dentry2offset(old_dentry);
> +       u32 new_index =3D dentry2offset(new_dentry);
>        int ret;
>=20
>        simple_offset_remove(old_ctx, old_dentry);
> @@ -414,7 +415,7 @@ static struct dentry *offset_find_next(struct xa_stat=
e *xas)
>=20
> static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentr=
y)
> {
> -       loff_t offset =3D dentry2offset(dentry);
> +       u32 offset =3D dentry2offset(dentry);
>        struct inode *inode =3D d_inode(dentry);
>=20
>        return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, of=
fset,


--
Chuck Lever


