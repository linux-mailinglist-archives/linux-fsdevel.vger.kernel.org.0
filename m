Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52CE70AF0E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjEUQac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUQaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 12:30:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE458B4;
        Sun, 21 May 2023 09:30:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34L9tsDO014254;
        Sun, 21 May 2023 16:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wRMTtFEp6Fmaw7u+xmn4KXulO3s6wl4d2AvRstVdkfI=;
 b=mhb3Q7hgPKENpDVjsRxEVKZTj078V1h87qxSQzQmeqkcJ4/8GVVTdtab+1JSwnkquwD3
 2FcWasOELFc9yg46UQw+EuyTZN/ra83uQWbp27l4m6XY1QvP+u77J8cB08iICsbfIMoG
 J2lycHONlK5gu87+lVcCdQ9fm+CF+4ur9bAqktLn2dtr4ZZpjo6wKxhVgJuIrd+71cH7
 Pmb8Q47unBMKkMqTJHy2+iwEZm6xVINWg7YzN0Ehw9TnDe66jJk9cRizuNpNg16AeNEA
 xkU+8OYDSg5nyiYyE8WNx/IwjF+5/dRMWRVcYbT00zBIz8eIKNvtCsn4pZBNF6pC59dJ ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8c9chd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 16:30:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LC9GIx028906;
        Sun, 21 May 2023 16:30:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk28kry6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 16:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1YL5SMlEK5n24+XnA+4msrpVHP9bH4kxz+EzPtePufJ8bJigER8XqFtFIHCqbi5RQJkxjEh1NKnEVOuFYpY2Opz7Gb6dLLJKUgALdS8FT81jUU8hr+74zW+/gRTvuG8d8mvPTtagu42qoqH+MqDEB+A/BA2Tg56wjwqCN7h9Ddfnu4Rv5GR/3bBB1/io+ydzyHiWkkBhUuqYe/XfNpYd8+MQK1QjU+QBMzot4dOP45/rTWRwjwuV/tCSP1uSlwnSG+U7l3eWwA2ypj1yUrDHEMoqhMLf+JOW5X6HTineBquWUPKOtOuCLo0c2AAQYEBx11jeqSEEZ/0ttOydeiv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRMTtFEp6Fmaw7u+xmn4KXulO3s6wl4d2AvRstVdkfI=;
 b=jiLJ66bQW8gHWmdFo5IFSGc9DUQWnLSXnm4DgEStTuKiQlCv9BWAkcLhHMdvBU/iKuCZyYvaQwKbTfFfFNKcpWZmyHzunibl881ypKyxY9SnH/LJCuDsKX1XrfPREDhm+k6q8n5/fgHTG0r7DZoy7xxlJr2ZRqs/hAVWBRloriE6uhfrl4wRAbc/lnCsMEqazMTLxMmDdy3tnl2RULR9ODDnLTfQjRnU+c3HBe7jZwlLVywuc4M6GTZazNhFTC/aYEEbWwnwaknjA5aLp6XyEyZON+XZm7kO7oiZWLbp1hWD2WA4G6Q3LHmI2EhtkLF3RD/udWUpuep8zZlMVZDj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRMTtFEp6Fmaw7u+xmn4KXulO3s6wl4d2AvRstVdkfI=;
 b=tX/MKDFeD+u36jXoVomlzs1nW3fdPqWgKV5PWSwpKWvVCTLS/MrfAXGauztv7VtGkEFo/P2DBHSpHfdRNbXY+1dCJ96OLQ45tGeCw4rkePxUhBUYCX8MmzftsbgGEa+dBobvo8ZBMywbi+3oB9CZKYMDVqy+DM049pMAYU4WL+4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6800.namprd10.prod.outlook.com (2603:10b6:8:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.23; Sun, 21 May
 2023 16:30:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.028; Sun, 21 May 2023
 16:30:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Topic: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Index: AQHZi2MvfY9rMGGqoU21jeDHID9K369k7DSA
Date:   Sun, 21 May 2023 16:30:11 +0000
Message-ID: <9E3C351E-F7F3-4D39-B43C-7F2E7FE8E84B@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6800:EE_
x-ms-office365-filtering-correlation-id: 7ea8916b-d765-47a3-2c5d-08db5a18a657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dOtAERHA2OkrjhuIHmFrCpPebPZDGaw4Ut+3WP2oG7krYX+8KLuNGFEqmm6UoTLgshSzzssGdYNuNsGoW2xXwweYwwqyTLJT2X5CxGallJ5Zav4yUNdpuWxUycHAzXI3BhMLDY8oSK5vMmsqjXU/yucZd6bS5JZHoOdcEaW/xJ8DHVtmpGFvS7Pz5v7ILdfjYtVQK28RFQm1xysGq34jXDvhHiB3yI/DjJzwZDs9fFJHrfShjTqOxTpUv1LE3WdOQ5APmIrSzYV2cuJLZtaxEcCsmoTkhANhXECF2t+cgd3RVPWjdeMU3y7JVNU35g1fgarF5meFi5VOasp/xjns6c3+5CsjBNIzeD2Ey2a2wLcgf3tmgRrjdkyzdy8YI+/6vKSx9OgSNtI4zj+99uCh/1CvPu8C/7ibIBFZQBE09NmIuZ8WThowjhhDmjnCQgKoXGzgcPsF9DVkWOKkImxkKh+CzQic9Vbrnap+XYYPIHkW/4389f0O8i5pAOCTcnLtbjEXwIIWXTqJJVSrFfQ8HreOu1TOWpO8v3LIMp1GlK7v+UZfz7l5NN24Is6UbFfJ3CMNZvvtDcYsU5jwmWDbjCO/PdmXDY6PtuHXCOSxAzxDvMvFEu7D+39A1A7tf2m6LPMIbUtysojgcilCmJd7yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39850400004)(366004)(136003)(346002)(451199021)(66446008)(2906002)(71200400001)(38100700002)(6486002)(122000001)(83380400001)(53546011)(6512007)(26005)(6506007)(186003)(2616005)(6862004)(8676002)(36756003)(8936002)(38070700005)(54906003)(91956017)(76116006)(37006003)(478600001)(6636002)(66476007)(66556008)(5660300002)(33656002)(4326008)(86362001)(66946007)(316002)(41300700001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ges5jaZubEvyRpJTTJmRDue52rd0R/1U5bDfl7GIdtmBSwUJ/6j11otE1g89?=
 =?us-ascii?Q?DohuMB1xUtrF3AfT318x4uelYt2DUZpbQwSOqeDekCnrujBCUh/2bZJ/Z+SU?=
 =?us-ascii?Q?dqTccwSwbpxw31n71xxy0EeLrFrz8fx40lKgCBGzcVtGzNeXgmZ/rvT7H4kw?=
 =?us-ascii?Q?4G5GWOs+GIzK+3M83NlcZQXdyhvj0vZLdCBpfkXumAOP+eeBag294TxLAmoF?=
 =?us-ascii?Q?UWs6rYavRHt2KJwfvAmeQ8LCH6ubF8dPfZIyo6zhlNA+TyTjDF95cBxcrY0I?=
 =?us-ascii?Q?F2KEf06ioeY7tUmvP6kuH7td20gDOP1sGvYqhn4m22T4wXbJ9V1g1Hvtia69?=
 =?us-ascii?Q?p76jp1AUtkvp2/1BAS6rfusbqrTYzNC7KzY5jJn3F4rGg7gOpETRACQwcfiB?=
 =?us-ascii?Q?dvT6u6tRuBnBdNGjHAboCNRCtRfFwMSAPIaJQpJ3e4HeuuI5PjO3hm/KGfNy?=
 =?us-ascii?Q?TKWs3yoU34Cbng55LWsdWx7G0nZfmdsCUQ7JJsVEGXEgf6ayvsBSf6GBxeA1?=
 =?us-ascii?Q?Ni6HimOmUkTSUI4HFWBnh+wUV5o3/DWDt0HUChJaexpPL8ewhsoj1IaQXY6D?=
 =?us-ascii?Q?6W549f0w2lScGCuVSI5ztAyqzH9Adueb8x8fJ9wWxQVB3gluls600TQdn7wg?=
 =?us-ascii?Q?NM2lT7Apr12fHGiWx0lUdFusaI1swB4CosJDe+oDLknP8doK/ZeqwEW4dr9q?=
 =?us-ascii?Q?xJPVY7WTCK/+R2BUPQdHs9LIsEpnaxoAm7oltjxFhcCa6FmDV7BwddoyeV09?=
 =?us-ascii?Q?rZznYjI4EG2qRp+jAggHcubCY+qz6uOlTJDytRtQrHa32LqlUgr6+c+5pqyk?=
 =?us-ascii?Q?3pegRj93ZwZh9616FXNq1+2vkp3ga3LZrK/m/amF0GVAJAJ9N4/tccO2FPGB?=
 =?us-ascii?Q?fgcwJIKSi/YcztPSRcImuFkhfQMgmdjVAMtpohaa/lhYtl4Tc+YKk8xWR9KM?=
 =?us-ascii?Q?f/oM+Z5OA5IivNBzMNJv3JIGyoxe0Ggl+oLk+Mj6Qun5ny8X7bzcNllijPpP?=
 =?us-ascii?Q?tPH8WPOKuEJPchr66nBbabWg5abMPnSHCcqMgcDLGXErzFH9LdOgEI5pt02s?=
 =?us-ascii?Q?c7PGFEoPqUGcedMOaNGFF6IcmfWwT/Af96JV0dj5hC92YKd6XRfxjuIjyLc1?=
 =?us-ascii?Q?flVqC8logB1IhKLJeXt6XkIPWsnQlMf2XC0SHK+344rPze/Ki/NMh/ZqHoP4?=
 =?us-ascii?Q?DLv+o1l18WF2mtyNspEF0W3T2yuar6Rfie0yZraHHsT5/AcySb/dB2RmfnBj?=
 =?us-ascii?Q?VvRTVN2ofpPjZZ5+TCrwrOc4KW9x5VgHmIrb4uYWDOd6Ff5f5P3MbM+fQ8R6?=
 =?us-ascii?Q?EmP2WeA+9C7wUWOLk7jGjxJ/xJ5LR+jVn7AlWDhfKf80K6q7mOkc1EheVtBO?=
 =?us-ascii?Q?IEC3BEWR7dM7G9ZBH8hfs4fpqtscBQoKg6Nr8FCCFmZTwMPa2jqHGJyin/F1?=
 =?us-ascii?Q?AgQKf/jGpWEFYtauxn1JLTYogZJQKwXctAR5BDogdCFNytlcHQdZpa0TK04k?=
 =?us-ascii?Q?3+sZL5dLn0zvJ9uofS+d2JlrPQsG3+MqzsU/RwaKjw7zEhFqbuqdOi2AOhpS?=
 =?us-ascii?Q?oYNY0cKYQ00tjxXoRhhe8Nn9AxIsHe2MJewW9Lb2YxB0onwJdQqTlTaJ4hnq?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB2729DC24EE764385A076437D6D11D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l5sVDwxPT8jLIg5zNXEJcwZXfmJBE1lksrzHecHBZZXdBXnluQr1a8fpyYGIUMC/hhohtye68sjLFw5MTeAB9Eg8rHuUojaNzBrpsj+wMWgYHkMO45o5tdfY0XwZ0nVMmIv2UokGHALfCSMxXpNTn/tm6wuRvOU8mqLHXnKT+mzb5csXfDzeUJG5vJ9C/nwgcVhbwwvwtELeZEkGgeoJlO2JKYDJ98zF6ZJmZwDJWfDzEeLHJsjrKso55aTWHHkHaq+qtyDEIIyBJXrbNk5SC1kwzZtAvzuJ4yeUOVR5QThHBuJTV7/xsaZuFBiWPDEuaLV9PZmt+ETnUWkxA+UAEJKFvk/1D71xa+0n5Ck2RiNj69SosfT49uIxU7B5SvAF6OqL13dO2HafUwR/4qmql6xsV94z+suyyDTJocMLijsst09MXwpBJJezHcy73RBx+T6L5xklPozluL+mmRJEnY/EyFZAVguUdBDL2GVqn5UB45923tkxcuf2SQDClPj0fyFlt67mATUJGHIqZ0Cdppsmjg0X9bv98LHhJipwq2wqkNPU6abJN+Kndi8FsBghCOA5qusJfiZvEONPBITFJelY46uMVDra2Gkd/7hj8HU50yLLdcsSV7/801/BST0zmsZ+8DufBI6x5odyzMg/rr2Wf+N6vF4EsivvFTHvy0uueq1H+SqvD72LumAnwCIpEbfI/X49aBi6/7l2a/L7RwGTbwjIosOzL7/A6LMjvvD1ZKLJ6PE9I9W11+aV08cwFeQbzS3V1EDD8vBfTRVlEl2Fuy/Y90854VB23SOGmqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea8916b-d765-47a3-2c5d-08db5a18a657
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2023 16:30:11.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YVxHdMlEqqURek0bux0XLwQOMK6mrBC1UgE2tK9zU58L+dH09Q0mbL/BeDJFE3BJrHUKZgLtqCL2DPJKPykjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_12,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210146
X-Proofpoint-ORIG-GUID: 5fRpDLv-X-4KBMn-3Ltn2Hs8AAOSdwIz
X-Proofpoint-GUID: 5fRpDLv-X-4KBMn-3Ltn2Hs8AAOSdwIz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 20, 2023, at 5:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled and NFS4ERR_DELAY is returned
> for the GETATTR.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..e069b970f136 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bm=
val0, u32 bmval1, u32 bmval2)
> return nfserr_resource;
> }
>=20
> +static struct file_lock *
> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
> +{
> + struct file_lock_context *ctx;
> + struct file_lock *fl;
> +
> + ctx =3D locks_inode_context(inode);
> + if (!ctx)
> + return NULL;
> + spin_lock(&ctx->flc_lock);
> + if (!list_empty(&ctx->flc_lease)) {
> + fl =3D list_first_entry(&ctx->flc_lease,
> + struct file_lock, fl_list);
> + if (fl->fl_type =3D=3D F_WRLCK) {
> + spin_unlock(&ctx->flc_lock);
> + return fl;
> + }
> + }
> + spin_unlock(&ctx->flc_lock);
> + return NULL;
> +}
> +
> +static __be32
> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode=
)
> +{
> + __be32 status;
> + struct file_lock *fl;
> + struct nfs4_delegation *dp;
> +
> + fl =3D nfs4_wrdeleg_filelock(rqstp, inode);
> + if (!fl)
> + return 0;
> + dp =3D fl->fl_owner;
> + if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker))
> + return 0;
> + refcount_inc(&dp->dl_stid.sc_count);
> + status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> + return status;
> +}
> +

fs/nfsd/nfs4state.c seems more appropriate for these.
I'll move them as I apply this patch.


> /*
>  * Note: @fhp can be NULL; in this case, we might have to compose the fil=
ehandle
>  * ourselves.
> @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
> if (status)
> goto out;
> }
> + if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> + status =3D nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
> + if (status)
> + goto out;
> + }
>=20
> err =3D vfs_getattr(&path, &stat,
>  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> --=20
> 2.9.5
>=20

--
Chuck Lever


