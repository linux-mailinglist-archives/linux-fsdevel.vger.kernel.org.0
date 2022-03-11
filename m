Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB14D656D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350141AbiCKP4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 10:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350119AbiCKP4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:56:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133E14A6E2;
        Fri, 11 Mar 2022 07:54:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BFp6Yr031164;
        Fri, 11 Mar 2022 15:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6HIG7rNoQrih35D4U3E44J0jVh4DptJLHecmpDFx3kA=;
 b=DWj0EK2HGBqwG4VSHpTlrGRD2xBdqMMxhA6xAfz2fB2wbFWd3smm7tHujYYwXNhxXc4P
 4g3M9Q3vXn2fUPr0gBbtleX9Tm7sBzUElTdOjqT+LbE24Of40k7WFjmv+TEjMxxAkJ2p
 SOXB9KKYOlKYm0QFEvIapkCvOGgmqP2fCQKdTGV6KRRgzf84hyCy6elZCpeabzsO8GtS
 l7i7dpugPyk6tvZy/t2B9CTmlbpuCHBkdtw3sXkxyQC72+zW2QZtvFqPv3zvhSSDGa/2
 c0UyD5H3whB39JqDpr2eQkGnomBCVRj1nbhbcOFjPu/d83lmH0uIdM37b0D6be3kYhBK PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2ska0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 15:54:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BFjkYM056316;
        Fri, 11 Mar 2022 15:54:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3ekwwe5yvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 15:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWW73lq7OcDxyKHz5Hqfb0sGDGUG4deuTg/TJyd5To47V0J8qp5BxKNngpTOhk1x9TBThPOhJ6HSxX5u5/Mo1Vh/54ISoQK+vVntK+CJjolBF31JE/qRxxzc2r0O/LmpEp2+EagIEZUeD4laPvbDXkETdHMPEBBfePoSwBCDcFqu/9zpBoDMRgRRD52Yk1ZcXiM3LIlC4DlzT74dMkvne5K9o8uLjjisO1EKkANogXl5vlEU6I82QI3q+raBpVGLIXnyCE+g8K1EWY0VUt4q0Sii99yRGh5BBDPcrhDKoDh39svoQiXFq0keToRYt7GWr5bN/Dz/8gJzQsW0BP25BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HIG7rNoQrih35D4U3E44J0jVh4DptJLHecmpDFx3kA=;
 b=Uu2xokAyyYPCD0oDfD5i9IXPuxhFBVmzQIHRbvpS7g+C1pxaJkzlULCkwmA1hg+/Fb9O3tnzqe74pzwpELHimqi6llKFKNU+ZilUYyBeY5jreQ9ob7HwXqHvQsSyuktKTb82qBCrxPmPViSvmJsm6rHBoIrXrtAtzQyVpkFe2xaW/oJKX7ViJJ51CiDf1Q4De7AC1VOteG8kB6MuqO3VFZVk5100nmE3SpefIARl/nQhZLTjzpKiVH/qhvjlg6t042UvBqvQesHc+2SwVQSQg2XR4hNuC0lw9F67ZTDWV11bzKARJ51JIutY6w38xwAkjpK+pdhPCGbGqHW9y3Ux3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HIG7rNoQrih35D4U3E44J0jVh4DptJLHecmpDFx3kA=;
 b=VvC0dIwGbDZPI8LD14s3xTM/GcjrOi0qkayOCwZr2eSew4mXWvNRwr4FuNoO8XW+Zlu8mU5hYMc4XAHQaHSZsCDIxpKHIno6IfLnQ9V7pcyYlGhc1NMWNmrMo4bNmKxmyfKWIyr0cWfIjPhB+O+mAULkEaG/Pwt+w69lAHTfj1c=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23; Fri, 11 Mar
 2022 15:54:39 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::1422:288c:c410:93bb]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::1422:288c:c410:93bb%3]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 15:54:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove reference to the removed config NFSD_V3
Thread-Topic: [PATCH] remove reference to the removed config NFSD_V3
Thread-Index: AQHYNVv43IyubEb7xESELjAt08Pu/qy6VecA
Date:   Fri, 11 Mar 2022 15:54:39 +0000
Message-ID: <54AB09CE-9345-4C8C-84F8-FA5C8D9F9EB9@oracle.com>
References: <20220311143941.9628-1-lukas.bulwahn@gmail.com>
 <9A70DCDF-2F9D-4020-B936-380D919421D4@oracle.com>
In-Reply-To: <9A70DCDF-2F9D-4020-B936-380D919421D4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef7385ad-78ce-4891-b839-08da03777309
x-ms-traffictypediagnostic: MWHPR10MB1677:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1677623D931525EBC2F7D91A930C9@MWHPR10MB1677.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScLbG7apisz2GHV596rFoUtnP/s+7RP7ezoEDLAvSrJv/WkE0NQKPH7Nc1xE01sTDnOHg2vZnBnKOGqfqoM6dO0MApHzDOIl9HUGhdz0j8GBl7kBoN1fbK1M6R5IG9vhCyctX770KDJxPVxceS9UWTflqne/eYhJzIezA8mkZJaal20Huy1rALj2m8qMcIuSLg7lChD4JMEKeaUPUy92LwfAmo2JTAopBmZVDesqNpGj9rebfQPELGePOXXSXUgUgjZrCG7tOy4XmiiqSDVBqcgZBgGaoUMCRa78emL+mGeq7qSO/9jvg928RvOMgvJHwLstLgFEvF67Ov6EdavTv47l52xscpud+QazCbBG7LzGDNqk2OmxGp6bicj/CbGVAaRBvYJwKYOhNRKnLH8JDWR3yK4rnw2F3fO9zCIWGLboP2Y9gnamcYQLIj5IUKEZVL78xKaF3qO3HfrILrS9UC8D8t0tFXmGuf2PKuVl8gJ2N39QLSO9rW3TDRr1TpI3o6YyEmY8/rRGdoQJGA02d0wZ633AXZ4eNlpMOLLiX2V8omiNN6ixOkPSRHbEFb3L6uKfDOKv0gVxYSbgSRZ9IHcJdmfx3oN4a5cfjBXNRoXPhAOERxMtArlbFYNcxvEqxy9pJbV8TGeK+wvOmZiztIci9DAxO7fR9t/J+vOGbfzQpSrnZziGQs46ajKW3DR+iPAYZunk7sneAho8HqAiOCKgm/Dns11DuuwBBQE6GtYIkZDA2F9+5RJX5C2YGb5w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66446008)(66946007)(4326008)(6486002)(91956017)(8676002)(76116006)(33656002)(5660300002)(38070700005)(8936002)(508600001)(86362001)(71200400001)(2616005)(64756008)(6512007)(36756003)(316002)(122000001)(54906003)(6916009)(53546011)(83380400001)(6506007)(2906002)(38100700002)(26005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?01L/6RMCw79U0wA+SmkMo7hswWlPfDSVRZAps0AU1v9wN2CCjYlbUOisPZKe?=
 =?us-ascii?Q?aM1dQ0HTtyZ8FVgiwVuys23u0SiQHm04IEErGMGJsPatAjnrFXpGtl6THhsJ?=
 =?us-ascii?Q?qC8mGyr3jpeDVapPJzIrIn26w9hP6A/E6shzxgqgZ359E8iPS2jzl8Fvpp/Y?=
 =?us-ascii?Q?Y0nuTa0Qt0z5ZE+PJC3AigIBZOj4fQ+OURXxxNjiHdtchMA0WaIfK8t3H/Kd?=
 =?us-ascii?Q?3XkmiMcbqB/RJENz2+4gUCXHH9bXZE8mh8Ttn+PT9p60dgUCZtEShHPHW7nW?=
 =?us-ascii?Q?3tVsD1kL4orvgV8ZILLPNhi0GR9/CmrNXlU3fyrk6oMWAroQYZZ8YOzJc/69?=
 =?us-ascii?Q?XCCsI+2ccKZb68eTIOi7qCIX+A5x4kjO9BDWNtlY9vwBaO3ZYadpavvJKduA?=
 =?us-ascii?Q?0AV0fRbVd+dN+rosXJNmZnaAk9RJrkMYMSnXKaN8Z0K/rwMg4E/knZ7WNanp?=
 =?us-ascii?Q?tiKxsMTX41EaiCzu13MKI8KnPg6QpYKHT7XRu/paZJ6OsHPNEO63mvdF0jVc?=
 =?us-ascii?Q?ftcQhu5pdqKzSDvKojYl0lK72Y2e8H/qjSFZdwv82ZP9WdsAUKu1HWlXiYeS?=
 =?us-ascii?Q?+oiEamwOy8JZwZUG8yX+VbPHlS8XQDiC951lqtj+HZtKSJbtqfRU8fYFXDEE?=
 =?us-ascii?Q?QfbPHr8RBtEhNCQ7ND13D04nDewTnqbbUSSoAd+b1Sthxzknmz5KMS64kcl6?=
 =?us-ascii?Q?C01QRktnhO7myMgxB9eRTXuMPFiH70ka9O/scFYP/vA1GUZbrfjVjsEmnhX1?=
 =?us-ascii?Q?eoy8zzjmRvycdSv9YEriLAE/QTQQnohediDgX7M5NIMgNG9gVkwVODPD59+q?=
 =?us-ascii?Q?nmNYxlcV2rrNXJcHwY45Qlx5xC4DpDv9Q6B2hxCywUQomWGGPANvLrrbBMEN?=
 =?us-ascii?Q?1l0mUxqER6lqCE52voU3erb9f1DEI51cNRo00v9/1WbyOFZRxn4AX3uw0CPf?=
 =?us-ascii?Q?JRQhu/Tl5MU0AZqsDOuhZiS3DKJ1sTVuLwoKFy0VhGhZ3Js5ot6W5Yj3D5KL?=
 =?us-ascii?Q?wJXzDThY43TMnvRO3+BIVNMIEKCKzP4NjnI/2RKv9YkUFokTc9cwqtnsQeMf?=
 =?us-ascii?Q?o7tKvQ+4W/UJSOu2oqUzPZtiXzOFtEHA17Uu3qobKoZuQbNzCI6kDAVZzefb?=
 =?us-ascii?Q?Mx63yQx1ZaA7IoxcGkBbk1lt1kj3Vp+Wawf39kUlWU7i0yL6T2dkySw3srji?=
 =?us-ascii?Q?fhKGYeWstLPbzBKb0uwWAq7UImT0D7kO3rkwOkOhXchBDpq0GUs1Xq1OB/X4?=
 =?us-ascii?Q?AMNfGwmaZ+H9iwS5wrcWNNhiiHAAT013ZxkgtF/DpTSUjwHykIsQu9qzSkOU?=
 =?us-ascii?Q?PWFo+nqESUzcxwVDLPr+rBEmMzk7hjYqD6eMpS/j4JzpSIBwa/ANC0FLxIEm?=
 =?us-ascii?Q?gqMn8mtluPgFDRfbV6vT9eYO5LIWScu6xLlxS6N78rgnvr2TisSXU03bNgMM?=
 =?us-ascii?Q?DEH/3d3EvaZI+kwpUCx8rPVnsM4NbpmaUJUbICFmeMxFURK3ymfNbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CAE6DBF132D7D40BF865402525C9E30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7385ad-78ce-4891-b839-08da03777309
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 15:54:39.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qK43Y66Sj07mFz898/dy0tmXA7CwTkdnJGAKubjXwrGDuZGOqwxgnC9EYYQiGlGYypjIB9GPREqoK8nfrQC7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110078
X-Proofpoint-ORIG-GUID: LvBPGt-D3kIi_ygPuCi4L6_7MIjJfufW
X-Proofpoint-GUID: LvBPGt-D3kIi_ygPuCi4L6_7MIjJfufW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 11, 2022, at 10:23 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Mar 11, 2022, at 9:39 AM, Lukas Bulwahn <lukas.bulwahn@gmail.com> wro=
te:
>>=20
>> Commit 6a687e69a54e ("NFSD: Remove CONFIG_NFSD_V3") removes the config
>> NFSD_V3, but misses one reference in fs/Kconfig.
>>=20
>> Remove this remaining reference to the removed config symbol.
>>=20
>> This issue was discovered with ./scripts/checkkconfigsymbols.py.
>>=20
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> ---
>> Chuck, please pick this quick fix to your commit in linux-next.
>>=20
>> fs/Kconfig | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index 7f2455e8e18a..ec2cf8ccd170 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -344,7 +344,7 @@ config LOCKD
>>=20
>> config LOCKD_V4
>> 	bool
>> -	depends on NFSD_V3 || NFS_V3
>> +	depends on NFS_V3
>=20
> Actually, I think:
>=20
> 	depends on NFSD || NFS_V3
>=20
> is more correct. LOCKD_V4 now needs to be enabled whenever
> the server is enabled, since NFSv3 support in the server is
> now always enabled.

I've squashed this change into "NFSD: Remove CONFIG_NFSD_V3".
Thanks for reporting it, Lukas!


>> 	depends on FILE_LOCKING
>> 	default y
>>=20
>> --=20
>> 2.17.1
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



