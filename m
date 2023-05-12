Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD74700E95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 20:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjELSUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjELSUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 14:20:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0202107;
        Fri, 12 May 2023 11:20:05 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4Rqk028673;
        Fri, 12 May 2023 15:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=w3OIoR4bZ0JvLJwzOGzbkukqfS1O9kjnvdUZTitMDIo=;
 b=2AmsH3ej7KRoSUEaAuwDzqmeH4Ir4cC4x7dTa4BnTlRRZJCHjcZZDWPbgRIFONGC3n0u
 f/MPQ7bDVd2YkewLPmraw/FWJPb+242s9R5ZQx1qusWBv6Jwy3xDEQCnl0WsrqVih8OC
 Wb3w8v2x/l6IMAwdGi15vWUZcswwtuJFBum8rJkT+L5gvkzAMGXU2EIQ+ke42/tR3CHQ
 3+TM1fMo4Q/+TniBuZv6rVfZElhC/OQhAlz5SsFigCVds4nSwTLQjubkUOucwFiHJXEq
 i6Pk7Pr/97Ro95PPFJUy+Rt45pIO9HmEELlKJ8XMBaIYz2Oa8+HpfJtNtMBJP0xiVwt1 WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77djxp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:30:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CESDLE018568;
        Fri, 12 May 2023 15:30:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mc286-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDgznobq9bl/uvmYO7CkNgSDl+CXVK8zVI8+GQZT+WIGKsrEMvBFfc0B8WVnn0n98Q82Nh1+MJuqB/Lz+AN8PN4XNv+qREvkBNfXlHy602S90X1SjERO9g0aiakK39riuaXKoB1z4P+rt5MKkwWHQkNap+fd+fl6U0pbP9XMToR/XXKX/LgRQQzO9kG5O9TadQBpMTYnqWEiYjqA6HPayyZwNMI0E+EAsvV4W+xr74epVggG0QZXml5bTyz2e1LWC5IQN70KhOBk43nsAMAPWEMDkze3goi7hzg7+/0b438K3VgrPNcP2Q8MCLxWDLE62lqJJzU89ieV7j294J+fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3OIoR4bZ0JvLJwzOGzbkukqfS1O9kjnvdUZTitMDIo=;
 b=YOHFCKRqGTSmGr8pL0yy87Qc1DeKFtXio9P9ZAljLsqz10v/sqmu/Wuzx5AlvOiDDv5Z7bZYJQEJSJTqrdShUUicrYa2R+uhFyfHfuKSmpaO1YpBr4NmBfpIk8l+RKYHl2FpMW9JsGb0uUWnvfW+PmF0uf5+KGfKTdA6GYIx6Cx/MKw/N7spYa7c//C6/cyB+E5k+NVcMRaL2igBGLAboafbpPJ9UAGadeY+zGRCVpx2xW1gIZvVe/WHY8ByN2cxPjc0sDa5z+HstAN+W5vRn0ua4FriOyMwa09h2Czsu55VaUKQnFXE4kWdSuvY809IbWzgY3WG8dBIteqYV3sQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3OIoR4bZ0JvLJwzOGzbkukqfS1O9kjnvdUZTitMDIo=;
 b=H0g0/lNMv/3GVIvrhNR6QMudKYOon++HkXh1c1ZtYiNbZuYtZZM5tg1vba6AkB6zSMHjvd6VNvPp9iWOzL2krNpgPExfno5JJWlc4ZX+bqRn4iiJEdbyElpBbwNR5XObV3fFcL32Mqd/EsMEn538980Slr04yKDZNFTaxQ0pxjc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4830.namprd10.prod.outlook.com (2603:10b6:5:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 15:30:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 15:30:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
Thread-Topic: [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
Thread-Index: AQHZhFGlvZOKjlmTnUmOAzZOqVQ2669WxKcA
Date:   Fri, 12 May 2023 15:30:25 +0000
Message-ID: <DF034103-6AFC-4696-BFD7-20039F1A4222@oracle.com>
References: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
 <1683841383-21372-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1683841383-21372-4-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4830:EE_
x-ms-office365-filtering-correlation-id: 2c233de8-b3de-4d14-5460-08db52fdcf1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /jOAy8Pkzl1QwKKsPGBzPaLkmvVo877yOv3thN4uksrvKkdUeKnicbJMBX2kJY/JO8DLYjXYpaLBEwnkJFN9+f2i3ZhutkdGrma54x89GxKmLyn866752vMCpIFiSX8XSOH5lG81Owki1OVNbJb3fAs/MFe5SycNquqaGjnHE8nPTCftJethQHQ0iqtlP/io35BHX4WPdtrVMnMbrevFNxHM0yLGvBtj3X7QQpmaZ7KwFZNP5JE5/nnAuu2ME33Hzy8OkhuXJAM4QMEKKAicqcp6T97lHbPzybjLt8032t0PlLWRlgMY2y24VTpvTqm5PzuCuw7YgN/XxQMP5/FvYBip2WNv4k/nCUfVy1sFr8en3fBYYMNuel/KWeFBpGRSKDJgpPqaSQH/6VyhjakgJTF8FcvYit+EsC/Qf6ZdWXY6GrG40Ut8IzmeJyNjRwZ6nlbC4Uk2ip1FMuJoES8CbaFepWPSLiOsQPz6Ub7bRprXs8DjOe8sNPSNjoDkZInbpjaIU+8FBA+D2uaAeio91dPGuWPiBh7qtE5Z+c0lyLwvAF7NBsl7f4XWD0wikayrVDO1ksv+2a5dm4t4++SYjDbChUudjUlv9IvQxQqplFbhG/PmioRIDY7O4/qOrHNNH4rwWaDKzUXyC9dx4/vOQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(38100700002)(122000001)(53546011)(26005)(83380400001)(6512007)(6506007)(2616005)(186003)(33656002)(2906002)(4326008)(8676002)(5660300002)(6862004)(8936002)(36756003)(478600001)(37006003)(54906003)(38070700005)(6486002)(71200400001)(316002)(41300700001)(66446008)(91956017)(86362001)(66946007)(76116006)(64756008)(66556008)(66476007)(6636002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9hu/rcJHYcHI1OHQdEx6+Pc0HxTa8GaFt0qNLdhqu9t4CmbzRHWxMvue/LUc?=
 =?us-ascii?Q?owjO/f7hP4PF4iLbrGBcdU7TcmPLH2NMapdrMVEQoL3AmEvFX0YlIs1z4NAt?=
 =?us-ascii?Q?ryResHRYyEL56/Xr4BoHtM29dbkRZz7YakCtbWGy9J9UWPzy5aNG1katkZil?=
 =?us-ascii?Q?q5/X1Vuc7KPvQRTq5YTJWojRAwYu/CHtidPuQsAr87V0lJnO3IR+20m5GtuP?=
 =?us-ascii?Q?4qKgcUbYcmI1LDg8YzftPB7zu4Dpww/WAOTRYartgMhG5DFKGmK5sJt22gkJ?=
 =?us-ascii?Q?OVFueApNtEVVg06jbPlY8ifHNIPVlXpTKdESCS2TL7HgSNMjLEQVDAlYmT+M?=
 =?us-ascii?Q?tnj0/a0uAfQsWn5Qxg4aR9+HQKM8piowvxBHaAbyvMyyso4YorSebrL/NeDx?=
 =?us-ascii?Q?pqoQQlxC6Ek/0rAIdKKf3gjjctXZkPM5LRHh6qABftb/TFjQm5/ArDwsCjUP?=
 =?us-ascii?Q?RdQoiXuWJLMI1si2mS0VPZSguoFtQsWuUy5UShvM25FulodDqBVMfMaU4jZt?=
 =?us-ascii?Q?XVAH4kHLIQyBeRVLqOW6jqYWknZQNlwcHYSs87bc02VENxS4U6DgOB28sXlc?=
 =?us-ascii?Q?76vf0d/X0oFZAYWGZsksdBwUdMfZmd/2LczCt91LbhE+cUcmHDhQ/vlEN9a5?=
 =?us-ascii?Q?bNdBmH83kDpHxXvDdWZYeTPQ7g/oZx+cWsyTO8TaZ/3E5x3RUwgex1pXS1IG?=
 =?us-ascii?Q?F4LCW0nWOiaW1G0dx/SOS8osnGCiuDEk0zQNpYBXFIuRlhiROpRnWLF++lQS?=
 =?us-ascii?Q?nhIhH5EQ0a0kXW9JXscYUeNlAEAxRj9p3ldIoDpKqPHF+Sn1WbTqsBrU1iF4?=
 =?us-ascii?Q?AwGaHd0WDLZTdkrnI0pXwlVT/bvfSRf284LbcfE90by1AylVBq60sLdRXNkS?=
 =?us-ascii?Q?GZH/VbRLdBhPAv22HpUINinz7IivVqeS+YvNIp8kStD1cgz3EibPvV5u52vQ?=
 =?us-ascii?Q?1qvak3PUmVzw1VCIQvhLEacJSCa8XhX1rEQSHcKwl0/qGi/XJlWk3PcB7Rlm?=
 =?us-ascii?Q?ms6eEDfuPCVTZBWOcWfLTlDMFgIi0Seq4/sRy2PamRRyBjf9tB0QagiFjlyP?=
 =?us-ascii?Q?hRYWjtT3khczHvPQxTrajg/bI9jUjLJBol19ez9an862aeu6uQ93heYyyAYA?=
 =?us-ascii?Q?tRP3rNq/QIJH408kGOhnnZlBEK6vh/kVipcVqCWLTQmNuJk6YGUJTAc0Q8ew?=
 =?us-ascii?Q?LfHCBYiZUu8Yxht4Jb6B3DONCDov/ZOz5YaDxV6z2/rUHS78tZtvbxxWa2ys?=
 =?us-ascii?Q?E9GBsmN3nmr5Oyo0fjt7pxBZ+GCdBM69WZkbUQRbSOUVnog/gOOICJJ8RxeQ?=
 =?us-ascii?Q?m/i+bNeb1outIBkY94M+UZNR/B30DAOj2c7sXltJB+3wUXQNWksdk2mrR917?=
 =?us-ascii?Q?g4YI5NoXsLWBO0rfTdSI3HH3YLWViOm53um8yH+HNeJPl/fGwpiv+I4cigwl?=
 =?us-ascii?Q?nHWXidLjcaJFmAcF9so2rzI8KZYJ0gdMVhFRhE01iPXnsYKuADxJX75disZy?=
 =?us-ascii?Q?5+mv8DcK0vyBXc8nOv+Di3DkEVmkn1Euok3JWzNUtGR/B1P/UFXmRiYMA/Wy?=
 =?us-ascii?Q?kzpaa4MZ2EFZyAM24ASwJKUpaLwM9YxN8kGIcGRJ5/khRZj6qyDFXu9Ux5KP?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DF8D8216178274CB5B192744E7652ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HNGmKJa21pH6Gi0ZHKHGbRvwtj2vYZCHQoIzxjtLF1t2RjnDu6nCnt1wQYhtLnBPnm91JE6Zr03yVTgqGIA8D7Kv4+ANwrXxMipxEOGLNna0f6ykq8UUKNYLGRMtkP1Lds2pFmA1RqunJrwqihYjymAcmKIhLy2f5np4chSAzqLKeWCt6LQTLaPPc3EDzACzIhB702RqksOmBe6/WIgyQC5lcQqikwewGdUqJwFyXEZ2oZWwoWTpyHCFx9QwfnyDbJB5ZQSVpyp6aBgTr6zEpyUqlgqV3m3nOdtFJ1WjdtqDXNl8IncYhnWww7GDwESmlS2ER5quswCXEpLCfvkEqxryrXGhuilY/e7s7gcUqOOoWo+YOZbBcyY6eXyxFrRUYGUm86qwZiCd5RnO8ziRiUJpoF5Xyl7evvzbRZS+9MnqqgnQGTJuNVQImJwPM4Hqtq5tqvt4Qnm/SpIj//SxJK8zv1fk8XKaZC9GxXcHsvQT4t76rhHqT6DtwoNysb+8c3YfxnnFR/8OyNcyyuPBdDsJ9x7uGYClOgFF0msefq0rm1zHpElfAy85ePomQ+frSIn1mP/YxmV7N4XVfQRl0zwSvlW8i6/pYEBXqMJRwp9x+7/jRrETPxAusb/aUt0tySLNtK1FDSjcOfdyrpbp7KqMcwLDkxWDTggpTX77zghoHhFlOsslT9fu5AV7e/6nOC0EsUfG3qWTRbmCM5M4mTxV2AsSZuosOulUIbA2nNqZIjp83VQWEjueUnbvu02CmYZFLF8MrmnfLaxoe5zuEQlVR8AoRQYtZLkT9D53VRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c233de8-b3de-4d14-5460-08db52fdcf1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 15:30:25.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pa1Ct5mp3kPDv+YeiPsvT21fJB9t2qFMS3+Q8dndxidbAwbX9ruu2UvAL7LTclC2EC/K7F/wbbk9zIu5ygVZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120128
X-Proofpoint-ORIG-GUID: mQj7pJlgyvBwnXqjzfmfnWFFJk11Sm3I
X-Proofpoint-GUID: mQj7pJlgyvBwnXqjzfmfnWFFJk11Sm3I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Dai-

Jeff's a little better with the state-related code, so let
me start with a review of the new CB_GETATTR implementation.


> On May 11, 2023, at 2:43 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Includes:
>   . CB_GETATTR proc for nfs4_cb_procedures[]
>=20
>   . XDR encoding and decoding function for CB_GETATTR request/reply
>=20
>   . add nfs4_cb_fattr to nfs4_delegation for sending CB_GETATTR
>     and store file attributes from client's reply.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4callback.c | 117 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
> fs/nfsd/state.h        |  17 +++++++
> fs/nfsd/xdr4cb.h       |  19 ++++++++
> 3 files changed, 153 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 4039ffcf90ba..ca3d72ef5fbc 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -87,6 +87,43 @@ static void encode_bitmap4(struct xdr_stream *xdr, con=
st __u32 *bitmap,
> WARN_ON_ONCE(xdr_stream_encode_uint32_array(xdr, bitmap, len) < 0);
> }
>=20
> +static void decode_bitmap4(struct xdr_stream *xdr, __u32 *bitmap,
> +   size_t len)
> +{
> + WARN_ON_ONCE(xdr_stream_decode_uint32_array(xdr, bitmap, len) < 0);
> +}

encode_bitmap4() hides the WARN_ON_ONCE.

However, for decoding, we actually want to get the result
of the decode, so let's get rid of decode_bitmap4() and
simply call xdr_stream_decode_uint32_array() directly from
nfs4_xdr_dec_cb_getattr() (and, of course, check it's return
code properly, no WARN_ON).


> +
> +static int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen)
> +{
> + __be32 *p;
> +
> + p =3D xdr_inline_decode(xdr, 4);
> + if (unlikely(!p))
> + return -EIO;
> + *attrlen =3D be32_to_cpup(p);
> + return 0;
> +}
> +
> +static int decode_cb_getattr(struct xdr_stream *xdr, uint32_t *bitmap,
> + struct nfs4_cb_fattr *fattr)
> +{
> + __be32 *ptr;
> +
> + if (likely(bitmap[0] & FATTR4_WORD0_CHANGE)) {
> + ptr =3D xdr_inline_decode(xdr, 8);
> + if (unlikely(!ptr))
> + return -EIO;
> + xdr_decode_hyper(ptr, &fattr->ncf_cb_cinfo);
> + }
> + if (likely(bitmap[0] & FATTR4_WORD0_SIZE)) {
> + ptr =3D xdr_inline_decode(xdr, 8);
> + if (unlikely(!ptr))
> + return -EIO;
> + xdr_decode_hyper(ptr, &fattr->ncf_cb_fsize);
> + }

Let's use xdr_stream_decode_u64() for these.

Also, I don't think the likely() is necessary -- this
isn't performance-sensitive code.


> + return 0;
> +}
> +
> /*
>  * nfs_cb_opnum4
>  *
> @@ -358,6 +395,26 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
> }
>=20
> /*
> + * CB_GETATTR4args
> + * struct CB_GETATTR4args {
> + *   nfs_fh4 fh;
> + *   bitmap4 attr_request;
> + * };
> + *
> + * The size and change attributes are the only one
> + * guaranteed to be serviced by the client.
> + */
> +static void
> +encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_h=
dr *hdr,
> + struct knfsd_fh *fh, struct nfs4_cb_fattr *fattr)

Nit: Can this take just a "struct nfs4_cb_fattr *" parameter
instead of the filehandle and fattr?


> +{
> + encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
> + encode_nfs_fh4(xdr, fh);
> + encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap))=
;
> + hdr->nops++;
> +}
> +
> +/*
>  * CB_SEQUENCE4args
>  *
>  * struct CB_SEQUENCE4args {
> @@ -493,6 +550,29 @@ static void nfs4_xdr_enc_cb_null(struct rpc_rqst *re=
q, struct xdr_stream *xdr,
> }
>=20
> /*
> + * 20.1.  Operation 3: CB_GETATTR - Get Attributes
> + */
> +static void nfs4_xdr_enc_cb_getattr(struct rpc_rqst *req,
> + struct xdr_stream *xdr, const void *data)
> +{
> + const struct nfsd4_callback *cb =3D data;
> + struct nfs4_cb_fattr *ncf =3D
> + container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> + struct nfs4_delegation *dp =3D
> + container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> + struct nfs4_cb_compound_hdr hdr =3D {
> + .ident =3D cb->cb_clp->cl_cb_ident,
> + .minorversion =3D cb->cb_clp->cl_minorversion,
> + };
> +
> + encode_cb_compound4args(xdr, &hdr);
> + encode_cb_sequence4args(xdr, cb, &hdr);
> + encode_cb_getattr4args(xdr, &hdr,
> + &dp->dl_stid.sc_file->fi_fhandle, &dp->dl_cb_fattr);
> + encode_cb_nops(&hdr);
> +}
> +
> +/*
>  * 20.2. Operation 4: CB_RECALL - Recall a Delegation
>  */
> static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_strea=
m *xdr,
> @@ -548,6 +628,42 @@ static int nfs4_xdr_dec_cb_null(struct rpc_rqst *req=
, struct xdr_stream *xdr,
> }
>=20
> /*
> + * 20.1.  Operation 3: CB_GETATTR - Get Attributes
> + */
> +static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> +  struct xdr_stream *xdr,
> +  void *data)
> +{
> + struct nfsd4_callback *cb =3D data;
> + struct nfs4_cb_compound_hdr hdr;
> + int status;
> + u32 bitmap[3] =3D {0};
> + u32 attrlen;
> + struct nfs4_cb_fattr *ncf =3D
> + container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +
> + status =3D decode_cb_compound4res(xdr, &hdr);
> + if (unlikely(status))
> + return status;
> +
> + status =3D decode_cb_sequence4res(xdr, cb);
> + if (unlikely(status || cb->cb_seq_status))
> + return status;
> +
> + status =3D decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
> + if (status)
> + return status;
> + decode_bitmap4(xdr, bitmap, 3);
> + status =3D decode_attr_length(xdr, &attrlen);
> + if (status)
> + return status;

Let's use xdr_stream_decode_u32 directly here, and
check that attrlen is a reasonable value. Say, not
larger than the full expected array length?


> + ncf->ncf_cb_cinfo =3D 0;
> + ncf->ncf_cb_fsize =3D 0;
> + status =3D decode_cb_getattr(xdr, bitmap, ncf);
> + return status;

You're actually decoding a fattr4 here, not the whole
CB_GETATTR result. Can we call the function
decode_cb_fattr4() ?

Nit: Let's fold the initialization of cb_cinfo and
cb_fsize into decode_cb_fattr4().



> +}
> +
> +/*
>  * 20.2. Operation 4: CB_RECALL - Recall a Delegation
>  */
> static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
> @@ -855,6 +971,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[]=
 =3D {
> PROC(CB_NOTIFY_LOCK, COMPOUND, cb_notify_lock, cb_notify_lock),
> PROC(CB_OFFLOAD, COMPOUND, cb_offload, cb_offload),
> PROC(CB_RECALL_ANY, COMPOUND, cb_recall_any, cb_recall_any),
> + PROC(CB_GETATTR, COMPOUND, cb_getattr, cb_getattr),
> };
>=20
> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..92349375053a 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -117,6 +117,19 @@ struct nfs4_cpntf_state {
> time64_t cpntf_time; /* last time stateid used */
> };
>=20
> +struct nfs4_cb_fattr {
> + struct nfsd4_callback ncf_getattr;
> + u32 ncf_cb_status;
> + u32 ncf_cb_bmap[1];
> +
> + /* from CB_GETATTR reply */
> + u64 ncf_cb_cinfo;

In fs/nfsd/nfs4xdr.c, we use "cinfo" to mean change info:
that's a boolean, and a pair of 64-bit change attribute values.
IIUC, I don't think that's what this is; it's just a single
change attribute value.

To avoid overloading the name "cinfo" can you call this field
something like ncf_cb_change ?


> + u64 ncf_cb_fsize;
> +};
> +
> +/* bits for ncf_cb_flags */
> +#define CB_GETATTR_BUSY 0
> +
> /*
>  * Represents a delegation stateid. The nfs4_client holds references to t=
hese
>  * and they are put when it is being destroyed or when the delegation is
> @@ -150,6 +163,9 @@ struct nfs4_delegation {
> int dl_retries;
> struct nfsd4_callback dl_recall;
> bool dl_recalled;
> +
> + /* for CB_GETATTR */
> + struct nfs4_cb_fattr    dl_cb_fattr;
> };
>=20
> #define cb_to_delegation(cb) \
> @@ -642,6 +658,7 @@ enum nfsd4_cb_op {
> NFSPROC4_CLNT_CB_SEQUENCE,
> NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> NFSPROC4_CLNT_CB_RECALL_ANY,
> + NFSPROC4_CLNT_CB_GETATTR,
> };
>=20
> /* Returns true iff a is later than b: */
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index 0d39af1b00a0..3a31bb0a3ded 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -54,3 +54,22 @@
> #define NFS4_dec_cb_recall_any_sz (cb_compound_dec_hdr_sz  +      \
> cb_sequence_dec_sz +            \
> op_dec_sz)
> +
> +/*
> + * 1: CB_GETATTR opcode (32-bit)
> + * N: file_handle
> + * 1: number of entry in attribute array (32-bit)
> + * 1: entry 0 in attribute array (32-bit)
> + */
> +#define NFS4_enc_cb_getattr_sz (cb_compound_enc_hdr_sz +       \
> + cb_sequence_enc_sz +            \
> + 1 + enc_nfs4_fh_sz + 1 + 1)
> +/*
> + * 1: attr mask (32-bit bmap)
> + * 2: length of attribute array (64-bit)

Isn't the array length field 32 bits?


> + * 2: change attr (64-bit)
> + * 2: size (64-bit)
> + */
> +#define NFS4_dec_cb_getattr_sz (cb_compound_dec_hdr_sz  +      \
> + cb_sequence_dec_sz + 7 + \

Generally we list the length of each item separately
to document the individual values, so:

1 + 1 + 2 + 2

is preferred over a single integer.


> + op_dec_sz)
> --=20
> 2.9.5
>=20

--
Chuck Lever


