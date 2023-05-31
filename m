Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013E87188BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjEaRqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEaRqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 13:46:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F8129;
        Wed, 31 May 2023 10:46:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERHx4031560;
        Wed, 31 May 2023 17:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=j5pZsIOUxbkXBMJDwUKnge2SSk427cXkU6/HpVeTj3k=;
 b=HGGpMXLVWmDZBvIvUv2lsDeRyScouPWJ38P38cPIXFeIZ1boo+eNKb+QE6i7qydHU9ZW
 AaERTXDHSclcR++I2M9/DlHSTSyvQFsZ3S7er0tFGSPhzaFxO3SdgsrZU6BThFPGMsYU
 Xc1hMs0sd+ZaREtpK0jODxsNN7A3/sRByy9x4YP56MDcouZKTrMc5auKufSxMMSM4FfJ
 y8JLtVBoz3ijsSxRbiUL4xOaLkAdQSzAPe/3zfh2j6iM/aZfwKhCpn2gh6Bx4KLnO4QN
 VBvv/3GRuAQLoqeBvIUbld2bwkyxWPJMvXjmX7AuzTEcBk7i7WDJ5LO8GZCDa6/6PnMj wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4xh1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 17:46:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VHhWxU014665;
        Wed, 31 May 2023 17:46:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a5y3hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 17:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtEuqsUsYH2L9ri9Oi4DNm8lF7AvByho0zOOJpaNtJ2QigwKSOuvn9ay3HNIlVJZkbnbFrGgMN38Fr+YcivSp1SFCSqhEeFgp764N+u3ZDuYkF488mNbRVYJMv5cmlkJlfu8kXsHprt3aYar1cdgv7lj4+cyL3FM8NkouZ5BOz/d9ozY+yu/MaOo5Cv1WrV9036a3CUO7rvs3+H+ZVDwP501Fy/j546E/IKlawqRnb+8u3b/03+dZ4FfcrDp2RbVSjDH8eO1mqhbJj0g7k/xhWRJ4BqyBbHW9t+kRQSJ8CnGIAQtPbFUO3VHCOgmAe5pQ/8SXxVS57UUax1mBRma/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5pZsIOUxbkXBMJDwUKnge2SSk427cXkU6/HpVeTj3k=;
 b=VImPnoxBhlmj3XCCAID+ELr/s0lYGasXSO8DzLXyb6WWStc7F/k+TF35Kg5A0iCZq/U8wV6T19CcwE1CqMTNpPaHZTsz4nbuQculhikn7GBXwMZMSPY/NpF89///e805ZUB88QVTOf8OJKWya+aYoJydjbuwzo7BykBUUE70aiZ4PgeWvmBEwGu0pGhLmUXaHmYkPshCnge3i37dZr/jFbWTne3vSrvDO2ThS0trpbOZj9wzT+Ol3WJ1BlhRrDZWeoPF43WELc1OlTNYbRLq8QbLrsnPDBwGH0Jip7kYxpgQQZ46m1jjiA2FdQtz1vUjV2V7STlcEAUo0p8P9p40oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5pZsIOUxbkXBMJDwUKnge2SSk427cXkU6/HpVeTj3k=;
 b=knu2hzvAEQd+uxAH2Ky+qNTcAbi8ERZ98Z7AhY78iA4g2o8VtoouwcnvafPK2Rsbq/m+aa3H7iSpEtp9xNHoLIhCkdpuqiNFF132FTqJR26xCxSuef6Zor97mcUHNj/84C5U7xd6HWZitRrbC/aAlw759hcpA7JnILIL4JSWLtA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 17:46:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 17:46:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] NFSD: recall write delegation on GETATTR conflict
Thread-Topic: [PATCH v3 0/2] NFSD: recall write delegation on GETATTR conflict
Thread-Index: AQHZk2iLyRzbFAzQT0S/00T2J29/Ja90qNKA
Date:   Wed, 31 May 2023 17:46:36 +0000
Message-ID: <8D2E4E6B-1C42-4013-8944-BD2236E5EA2F@oracle.com>
References: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4986:EE_
x-ms-office365-filtering-correlation-id: 6c6c1dbe-f48a-423b-ed1e-08db61fefb27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNrH6q4gAuo9CBX+dQO26iK9Jlo0bhk5beZS7FvTv74K4I3dK6YVgrTy9G56Cl7Pkn6VOKGzI2469toXleuOZ172CQno/o7Wu8KFGEssD401DvPIKsoTP+GoUGSHFDdj0Imt2V+dnAhHtASZhlCAwyed0QA95QAIDJimposuiNYA6j2g9of3lsHAXL3M3Nd9258UK1xRX74amtqyNjlf17xgB3jSgXwyzCYgYdBw+qI/fokU7m8xBe09wwPs1tAaz5NPnZG9MgEFAe0y8KJwaORe41hVSl6KyfceypEvshWK0+ydJSnHvQIJRe+Nybs+hWB5GvlslmHx1wuSriWMADwDhrq2XiIzho0ZtsRnMguoKdS9fvWdTmsbPS1woPeWG9L4iwSgZGUi9rlS1Ri8s0+A/1C3uG+Qt2H3IBACBBZXEHgsVkMWrqWbf7FaD0BMZzpPvkD0ybduCgE6dJABEpQti9QotzGgjmdev7Wm8KsPr/IxnYoJtm2c2Jxwxs3zmD8dHJ6sleUbiHNVfq4Rz94xSVCqX5tyqLJLXtYBfxGsG/T/JHL/M9LZJ87Hc7mTgnoDJL3lWEwZcm2Km7w0E+PLzHc2Jw/6ayQhXJKd8RAViQPmvl46ud/z9WhZ3pSadBPluTTkSo8yQ4bkev2gBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(186003)(33656002)(86362001)(54906003)(71200400001)(110136005)(53546011)(26005)(6512007)(6506007)(2616005)(38070700005)(76116006)(4744005)(66476007)(66556008)(64756008)(2906002)(66446008)(66946007)(316002)(36756003)(38100700002)(91956017)(478600001)(6486002)(5660300002)(4326008)(122000001)(41300700001)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qrzQPuoYs7b4hWZNiRMltZkGiWupY4/iOOGCx189Tz9xAfBA07+S9dU2qizC?=
 =?us-ascii?Q?/aVh9CQ9w2ThPmU0VEQEESlUYgIiwAg3PRweb8R4QgrZ/6o1tTW0b/e6nxWw?=
 =?us-ascii?Q?fvU2jAeikMpR3zHPHJ2gPG07cJ0+9M6OJW4HJrsmP7kdAMJ7Ug5uj5LqG73Z?=
 =?us-ascii?Q?bMuwwiqKxpT545aCE4cMSDnxVuOMniG0qKROqtrFOTdEtjk+JTOp0AUBr5z3?=
 =?us-ascii?Q?8fsATyicuN8JGIf4INjhM203JlNtJrqi86bNvPDEmkO4lGi6DcZD24uO1xE9?=
 =?us-ascii?Q?3F0NvQNlJIpi6GmhiTungKbZs9RJngyqlw+gaCnBgxaDtkXTR6ar8uPLeKaw?=
 =?us-ascii?Q?7q9yENv1K2Xt59LbZgbb3Cl1pRvfAeAWtX2uxNLbPQz2DM9MWJzdw+2tChIK?=
 =?us-ascii?Q?OMIBSpczJcZRw7iGXbI55c6SkP0mxFr3R/BlKA1r2UzjNv6qa2fEm51jksMF?=
 =?us-ascii?Q?A9zKzefKFTN09/QxVHsze4NSGytSYTm2iNJtD+NjNjh8zr/akYad5f+JaHSo?=
 =?us-ascii?Q?MG+d9egwtcZU6CV/L/jCKXRs6lYCPAvLuRqPLPTeTidSSJ7C7BUoeFlgjs2d?=
 =?us-ascii?Q?ZayaDMvd6U0+rFpCHbUb/p/EliUKbOsJmGeoWhk5mBIyEmwybUhBIR0i7QaM?=
 =?us-ascii?Q?sCiy7u35cAfAc9r+eq4I4MWftwJ3ONZcRZvBP8FO8z8CmLxS3g3Wehp/eJhB?=
 =?us-ascii?Q?yNGSaDWtpO5PtG4iAF9VaCIMLtCrzStGPwndpMagWw4crTYkP/Tf6CzV8C/E?=
 =?us-ascii?Q?tFOheuBigAWyPRqcH3a6y/a1Tvjag1lZaZdBTnVDHL/BxfBMi5qYZ6luS7ma?=
 =?us-ascii?Q?fNRpVb0e7KCRlb7HugFxOd3AyaDpkdZqcBadQYXEJGVoGZQNW3nvljX4jXI7?=
 =?us-ascii?Q?kOg9mPbTtdnymUdUZwph7+7v4Mc1mS+oU6b4WAZLlOPPPgzidztHVeKZAe9q?=
 =?us-ascii?Q?Nknd/TBJICnPxoENLKKLiJwIo7ZdRmFyUKkW4uMicnI4XXiGeBUFq4jFyrzC?=
 =?us-ascii?Q?XRyF7wcT534EY+wcqUKzn5pjiG43KhfA3hkuc8FpvoBsZg0gPYi9loZ9ArXE?=
 =?us-ascii?Q?wXlMX041ay4CnB8Yi7ndWgiAVccbnkCHADQegVkfkM19DllvASKizQT2rgl4?=
 =?us-ascii?Q?zmvlCXQPUX3upeAuOXgEgm/AxoAJ81jV7k66B1nhmyl+zOaCLF15Dlxyq+86?=
 =?us-ascii?Q?KMlrztpiBGuRGR0Pqv+nttPo3Oq1niN3xG7pQVBz+Sl+a+/4kVdK/559wnVK?=
 =?us-ascii?Q?84imTep13/AMTIFoBVSczdCzrY6sEMCehZa5WHhApKJ49DTjyCtYmN5C493c?=
 =?us-ascii?Q?jnExgl9pwEK63ZzPOuiP52fPfrkXJae0ww6NoZI6GzfZvFwJiCuX4LO21YDo?=
 =?us-ascii?Q?F4s4dY3IELZd98kaDArEfoUtUdVa+usIRSdlqmNGxxzB7GeHwYrvswupfphp?=
 =?us-ascii?Q?ow1/sncCyvKxMT3fs1VxYW6QoP5W9hUNrIMAUKxiGZU7bXdx7Gvho13r6zqN?=
 =?us-ascii?Q?uesSES8p+khOjWolcJ/bvobK4k/w0HZ41q/2nRDq84TYSKIwUfUmcXFF8kLh?=
 =?us-ascii?Q?cB+JapPK/9VHmBtfwDM0qVdKf4OEjy1MqWEePmCqJXKB5BmHdCC217rPNYXm?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B11D3E417435E14EB53256BE377DC34E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2hX9tL8plVlSoVv4Wq3RoZxS1Q20YMzLgY4CHv3fTrPlkOk6HikXZHlRH3PRTmCAONxjbotsV3j915/NGC+DjrXtcsQDJcDjblidU0RAdm0CuLOnqMtgsaLZsxXW4AQZ/3yKg3S7ReAmPJJeqOayZJqEHF8bHxtAhiGvOZYhsVgWO6TqAU6IC+QGRhDArimGX5+N3M6I5uftBxJs2xQ6eD5LKXbuxQvr19E2iu4B56s94l3zDriPWRcOemWxjcsfiE/Mh6bVr4S/G5t3JVO6SJB81O9PA0GKDJDDxapLmrEvXoejgDFmTSRDwjzcGWWBDMW+VQf2xMSKVZ+7zuyGDEE/Wayiy1SkRileJ3ayENwZebOIN/HVf2C9v1/VqC4phVPqe8qL5jc4IWrvrj3EkWRd6Yqm3k9V3LYWVurWH9JR2jMHsAi5KgYH0TXhA/4lZSCgnTYQWiHr+ajPNRcMoIDyb57IF47lKYqA0QuOgB/4rQe5thDxqyM6KNnpKAM/6WFcdKwWnjOh/lvuHKS10awyeMijCuSQGdnRjmFjxF4mLykw2wwYWK0KQpCZhBNSXj31wOOCZkt7CzA5W6xcvAHG4q20y3mr9EbtshLiFq2byXm67Y6nY1e50w+wRyDGYrmqvIWn0PedF/wRxi2tgiNIhhJmpvxQUeb9lkI1T6w/X2x/sGAJGHn1spEjDHWSI4uTkRC/l0VT3Spk449bu26I3HZSxUTt4kMq6XEUU12158DkKU9sOu664nvSdN9R00KxirC6WNt1xCMOjtisZ9UyInFwmtbe+DJde9vYZZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c1dbe-f48a-423b-ed1e-08db61fefb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 17:46:36.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEkUi2g6sCklV32Mi/T4X/ZyEJNH1yLU7wR69r1RUJ+GVcBL4pHPuDJbETbZY7ZK5yfR2FG88ZdUOFVMNscVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_12,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=952 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310150
X-Proofpoint-GUID: 2Ojh3XN00mBAxYpMATPvVQQMy70QbMuz
X-Proofpoint-ORIG-GUID: 2Ojh3XN00mBAxYpMATPvVQQMy70QbMuz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 30, 2023, at 10:35 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch series adds the recall of write delegation when there is
> conflict with a GETATTR and a counter in /proc/net/rpc/nfsd to keep
> count of this recall.
>=20
> Changes from v1:
>=20
> - add comment for nfsd4_deleg_getattr_conflict
> - only wait 30ms for delegation to be returned before returing
>  NFS4ERR_DELAY
> - fix test robot undeclared NFSD_STATS_WDELEG_GETATTR error
>=20
> Changes from v2:
> - call nfsd_open_break_lease for non-nfs lease with F_WRLCK
>=20

I've applied v3 of this series to nfsd-next for merge into v6.5.
Thanks!


--
Chuck Lever


