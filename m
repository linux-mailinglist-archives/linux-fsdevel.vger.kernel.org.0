Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48971847E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjEaOPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjEaOOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 10:14:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11A26A9;
        Wed, 31 May 2023 07:12:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VDNsDg019286;
        Wed, 31 May 2023 14:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=L24sintIWzx65Mb61quj+lonC6nHG7zxCG6y/BYB4sY=;
 b=PUGTsbVWYKfd1Bv376mvQK7fRmxSjd7t0U2DsfniW99o0B+cFWQStvessGD2nkU3MGOM
 PazBj79Rm9oHf2C/U90cGUSNKYZoNw3e6flSlvokLaeEq1ligVJieKeTtgb4Jr74C6FZ
 6H667mW0v6QBKlePyMJC8rVyuJ2KVLOyGhZDsGow6I0ANJ9vWr5BAQ7vhim1K4ZJH+Tz
 L4o4xBEgUBf6N+zVOVKV/fuyyBaYb71kQXMuIgy9jxt/JGOj9chIfvQWREOj+lrdMNO4
 FrdxN3hbd0Mq965+rqnV45UkIf0nEf+XGjHfFaTmRzyDPDRyPk4wubiJ8u9GZbYZaDIl KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4wxmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 14:11:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VCp75P029980;
        Wed, 31 May 2023 14:11:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6bsfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 14:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo4li5qCgnJfHNUK3bC+0x3qgbBSfNuR1oGhCEI+Og9EfW2pcOjNY61f7zcbCJ4ewPRPF/9xD5kcMSkTiRRw48aMsaXS2EeyzSz0O2o14YQmrBp5JKcXYa/u3lVqyp2VGXidkm8Jy3IG4Yfx6R4xN7VhVpyVMmO/b2mViNOt6HNS3WWnKl6xla/e+Souh9Kukou1sztrNw36rXtw+uMRCVn81DwiV4k2xcsHGQ49Zr13jL3aHHpXBI5RPL+sJbdoP5E+HJ5MLYyEekDRG6Z09jOFzCCrkZgR74ozuNLUut1EBd0GMHbq9AKRAGvmi3VBsCFJHlcK4pKVKoGVkcnovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L24sintIWzx65Mb61quj+lonC6nHG7zxCG6y/BYB4sY=;
 b=Bn+mj58Q64Olpw6LQj7ZV2A4sQm3IO1mwtGh0RdMaEyZus0qjuuHuS4xi3Mc5bdwA4XloVsN0TXMF0726i/SrC91kQH7Ft+JwA1iE3aODS0wjrsU7VCXP+fhwmndQU94kP4Ef5UPhGsuin8tLyUfREMVd5a+0/Uj0qBsD/lVe1lI3XUoH1rHHYV81NS73rTyI0/xWHPEHwkPPrvdIx2zYMlJ4f4HIRggZUNaWQitk9S6wJG9qUPLFDYzHxvHoo1aZ1DBpFnhMCGi0QvZYCtMG6tjgCD15g54PDl1tdGQvv5E4YAF2GakkQoGfQ9KJOR7ICyiNxetlWgBJeskkbN1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L24sintIWzx65Mb61quj+lonC6nHG7zxCG6y/BYB4sY=;
 b=MlZPvR/vqakk05w0GhtwlYQmauLI7S2XvErjhrt8suNLKH751jS435DVzhy8hAe5/qs1wLLbMGYA0mhmBFXzLVvSL9OPX3pOlq0kftAMddwyuLvD0Jj/DN1w3uYZRHZARYmctDnem3HfPfxDJ+aEBkGALHfURiH1AVddhblVk30=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4872.namprd10.prod.outlook.com (2603:10b6:408:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 14:11:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:11:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] NFSD: add counter for write delegation recall due
 to conflict with GETATTR
Thread-Topic: [PATCH v3 2/2] NFSD: add counter for write delegation recall due
 to conflict with GETATTR
Thread-Index: AQHZk2iM/5IJL5ftd0GsJEfCpKWdgK90Kg4AgABClAA=
Date:   Wed, 31 May 2023 14:11:10 +0000
Message-ID: <83FAA7C3-38FB-45B1-998C-5FC6E6DAC881@oracle.com>
References: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
 <1685500507-23598-3-git-send-email-dai.ngo@oracle.com>
 <f932fb72d0cb418d910bfa596ce2d1065d3d8330.camel@kernel.org>
In-Reply-To: <f932fb72d0cb418d910bfa596ce2d1065d3d8330.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4872:EE_
x-ms-office365-filtering-correlation-id: b7181b68-31c9-404f-a987-08db61e0e2c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBg9ow6IsYFvNpyZtAY1Y3vmPxpxjKaf6RuVP4HKTIL1eQHiNO+fQ3h/rEyM8Ed/7O8dz4kOIZztJUwDLVdVpY9YehzMXhuMmacCefoU2WopSRT7qtiZutejqD6vEdxKipnGeTuRYkX1hrfrLtKICz+4NxhkVhpQEaRo28AcefzzswUwcd5DE29C2IfBLbZjYHIKJUHxKJ9Ch5uVYvcDxn5PM6ycHHhFzopJDuwf40D4Z484x8R5VbSM6LVOxY0kqtjJ4ehJMe5RXMYi3MvCm3UvUc21VNPRPxxx/1VUrT4iUZlWos1m/NE74W+7ZlKWFoFQug7avdBVhREQkPQuZJ0EaGgRP075gde+el2KOESJuqalqfLNtzNQKox4Eby5c8nlLDI1/VpCrA0utudlka9y9AuQcmbhg0Pdk0bZPD/ummDgCQI8zZoYDlQmbjsr4IcKIgWm93uSpJvClrGyT33/Bjs5HWpDpZvqxed27e3iujoNNEBu1On73YJ6weqDE1jxb5LEEeKBLuNVeuH2vhQb9pDwnOWpoCu66wrqOW4COLoRHRoIUKPw+7KkbF5kWEfFcKf0j86YFhrfFccEe2GP4byCakPed0NBbxfJ+Zhs4xcrxihqXtrLaoCDGnXIof3FCttMzRu7QFotPVx4SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(36756003)(86362001)(33656002)(54906003)(4326008)(316002)(66476007)(66556008)(76116006)(6916009)(66446008)(64756008)(478600001)(91956017)(66946007)(71200400001)(6486002)(8936002)(8676002)(41300700001)(2906002)(38070700005)(2616005)(122000001)(5660300002)(38100700002)(186003)(53546011)(6506007)(83380400001)(26005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?78keWrnY/LJROqalcY/kZrhym9HVWqJ8nuiLvc35uoyXX6Rz29GxO7yj+ZbH?=
 =?us-ascii?Q?U0V5rl3T9VDI2hZrhvA6p76JgtX8TDqyihZWm/zgpSdYD5KgZwI/2Gh9837R?=
 =?us-ascii?Q?lagdw2nS7KhxXRX/2hFuU5N7+cmSMNshklGWT7mDztxwZDWKtfjAUSdxJ8nN?=
 =?us-ascii?Q?fzZpM4OeSo5yipQrngdSJV+W3YE4pyAMFtRSekrfus8XtNV7l4/+lUWYah0l?=
 =?us-ascii?Q?z0um7t6t9vmdy4097FHeA6DXcyovxwcD5u8uCWpqiAWZNGZwnfk0++nVDZ/Y?=
 =?us-ascii?Q?jSK7R0Xr0uS01gdkmyVUasXgqqLU4cddTG21mz4wZXeetaFgtLimx2/8D+7g?=
 =?us-ascii?Q?pdrwKP75m+aYYg2jz9q8KdOSu6j1POJfFGn7R1ifwAGRXcEImHqAkOZESPs6?=
 =?us-ascii?Q?U3REm299hlEuRT4bUUdEn3eRYKCFhkF+DQbAiQYaGTi6AfNMfvTts82Jtsp2?=
 =?us-ascii?Q?rLvcqEWGufC3UcLriAp0GTCNH91LkKNQrw+wNXKdv/R3UTS0fhsBZ+wLreCm?=
 =?us-ascii?Q?LHWaI5c5VMVf5C3wBrJfCa0Or50WvGAxzGyejzjoSSkQ8U1IWWMo8b9cT+Xx?=
 =?us-ascii?Q?K0uQYHJn09yAp0z4bK1Ky7x41rIMKGMin9WenzZs8cTdFwV5rgnlLNvFFhee?=
 =?us-ascii?Q?rWTzyelcBJxHmtW5bwsZqC9FgLkUvqPr/AGebF976MvOFMAkMJjaqkc9xP2Z?=
 =?us-ascii?Q?Zm4vODZg8lg+GWnAGDdAqrOf8+DER92PqclaEB0I3OqWLZOOp4LthTEL2s35?=
 =?us-ascii?Q?kcBUmsRZoR0ka7XmeyjmnLweTBcApF8QNXY/Tt4b3AhLbNlce1BvN5FIlRWz?=
 =?us-ascii?Q?HK+uHzLfKAhTeRM2j06/mIeM/O+YGe8migI29VgYyBiuCwfWEsPpGS36AElX?=
 =?us-ascii?Q?oZY7J6vkudbxZc6wlsDXeTQ3RzHUhUkxlE9D10BB0/d5koIjNX3TBeiLg6MF?=
 =?us-ascii?Q?XJMTgP03mrPpcdTBsVR6FTtgoTNROiia4pprRHh2DnArNJbHawhuWOK5aesC?=
 =?us-ascii?Q?D+yVae1K+5ojo5C985mr4KTeilt9ybSBYcmmvbOGaSCSw38iOohmsq6cmhsq?=
 =?us-ascii?Q?CCoFSKcW0MvHkWggYffGB5KvpYoNcrMF1odW9gxMdcJ5nTZb4LYny9SSmcb/?=
 =?us-ascii?Q?SNpQmqor6xGfSF1tkYZWL4gepJEMufQa1QX4HVhKiNT0QRjrzdkQO7M1cSHd?=
 =?us-ascii?Q?/W6tw5ilIUK8ElhccsJGfJnARR65pXwzXb3s8dU+63t6TusnBtvSUaSBDNEF?=
 =?us-ascii?Q?b/mkuxClgYzQahct6BXNvVVuoM0shlqgTLbdtnXyLCNgJwu5JTsPbQG8wCg1?=
 =?us-ascii?Q?fMrgIhImz9hF3YHiQf6XXp6lt2lalPmR+6z9yp5e7mI/QZNs0hYaN2KvgZL+?=
 =?us-ascii?Q?8hCiAmBGB7ni8//ESAKnpIt3g82N4vd+8mpfoDxwAgy/dSMTQ0k9tHxKwFet?=
 =?us-ascii?Q?GWYltltmMustE8artMf13wNQAR8jFtqgqRErWkPgIrOtQJea8yYznUd/IGfm?=
 =?us-ascii?Q?aergWOzfcqaWCd720cvRhjgfrt6a4BlglHWADtFKNjnF4gzi9nl6qLXIGa1H?=
 =?us-ascii?Q?DhSSLFNTSLxauIwKZIu5MY6/DfvO+k8KDjfyoY9Q5C5SXMPtq5acHcpsNzXy?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95A520249B217D43BA88DFCC0A888B13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4sp5nhWabI3IkCt5SNUHwtF/J9uP5+mX56H6z1jqKLDf9ZJY2CrdJf98SwIeH0KJ/cAmorywbv93jhRYWvA8aoo2ttRIT5T4RZGy0FGzXMU4VIUJ1yWrGLtjA5FWcjn1qynexiT8fp9YqasAHbcg0ENJ923N5Q8y0DBv3KW1qCayWxqv0sv6qVdW6n4UeYpUDr/J8NH5mnh7WLtWt70RrdglLQ7VI19WG+2PfmdrAW9RaDCogpzIYvJ9lvfoIEVaKAWlNTVX7WPFhWM7NtBxqVQlSGmAV53stMPA14yA4uL8RxW1+JsUIZKc0mZrhcfOgUvE7A1i7VSBEojXCjRP/2mGlESX5SytnlNJ9seN2fN/h4JyGsS7h8FzAzOxgPY9jy3IecbU9KZ3RFCl/U4SMU010t1cTXMea1HjpF40NXYg/Xh0xIISZg9kQXyopbH57dPy6kB2Y81BRmDW/ueEhpEF0IOONTX3FUQQlgNzeMrMhQ3GH1JNx7bcOTVL5KIkuRVgubA0pdkinBuBMg3H7M/Odhas+Bpf0S169kqV1FD3+U0KAw0d7JUhQbdLLTUGl53c/c+JFgm/5+qn7lFwPIa5VPCY1h2mKNIoRdO98xCXis25lWdBqEzos+4vC8g4BH9S2I70Hc3VcnjAJTLZ2YTFVYdyqXtrEhiiE30MDNIRVj1IyjXpgoj184oLSo40wK173iv333AGhzz8jyf3xsah67dzH2GUjO1ze2b2a+Nvwp+9Lo49PHKxIuTO5Fk+BIJtgs0WRhnlj/izmBOZdtwETSuAMYymXowScYKnXG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7181b68-31c9-404f-a987-08db61e0e2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 14:11:10.8392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdNHFQkcGGK4rAk8PwoSQ33MXzw2phDfE4ftTHXaZalJejf1M9gN3yCyGXOiGXjIDzaX/5H1i3AmN5dIscOTiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_09,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310122
X-Proofpoint-GUID: zdriQfTdwznAaaPguzbKsfSqh-b9N59a
X-Proofpoint-ORIG-GUID: zdriQfTdwznAaaPguzbKsfSqh-b9N59a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 31, 2023, at 6:12 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-05-30 at 19:35 -0700, Dai Ngo wrote:
>> Add counter to keep track of how many times write delegations are
>> recalled due to conflict with GETATTR.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 1 +
>> fs/nfsd/stats.c     | 2 ++
>> fs/nfsd/stats.h     | 7 +++++++
>> 3 files changed, 10 insertions(+)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 29ed2e72b665..cba27dfa39e8 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8402,6 +8402,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqst=
p, struct inode *inode)
>> }
>> break_lease:
>> spin_unlock(&ctx->flc_lock);
>> + nfsd_stats_wdeleg_getattr_inc();
>> status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> if (status !=3D nfserr_jukebox ||
>> !nfsd_wait_for_delegreturn(rqstp, inode))
>> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
>> index 777e24e5da33..63797635e1c3 100644
>> --- a/fs/nfsd/stats.c
>> +++ b/fs/nfsd/stats.c
>> @@ -65,6 +65,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>> seq_printf(seq, " %lld",
>>    percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]=
));
>> }
>> + seq_printf(seq, "\nwdeleg_getattr %lld",
>> + percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_WDELEG_GETAT=
TR]));
>>=20
>> seq_putc(seq, '\n');
>> #endif
>> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
>> index 9b43dc3d9991..cf5524e7ca06 100644
>> --- a/fs/nfsd/stats.h
>> +++ b/fs/nfsd/stats.h
>> @@ -22,6 +22,7 @@ enum {
>> NFSD_STATS_FIRST_NFS4_OP, /* count of individual nfsv4 operations */
>> NFSD_STATS_LAST_NFS4_OP =3D NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
>> #define NFSD_STATS_NFS4_OP(op) (NFSD_STATS_FIRST_NFS4_OP + (op))
>> + NFSD_STATS_WDELEG_GETATTR, /* count of getattr conflict with wdeleg */
>> #endif
>> NFSD_STATS_COUNTERS_NUM
>> };
>> @@ -93,4 +94,10 @@ static inline void nfsd_stats_drc_mem_usage_sub(struc=
t nfsd_net *nn, s64 amount)
>> percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
>> }
>>=20
>> +#ifdef CONFIG_NFSD_V4
>> +static inline void nfsd_stats_wdeleg_getattr_inc(void)
>> +{
>> + percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
>> +}
>> +#endif
>> #endif /* _NFSD_STATS_H */
>=20
> Personally, I think it would still be simpler to just do a CB_GETATTR.
> We are issuing a callback in either case, but recalling the delegation
> seems like a less optimal outcome.

An NFS server has to support either CB_RECALL, or it has to
support CB_GETATTR and fall back to CB_RECALL. Some clients
might not support CB_GETATTR, after all.

Either way NFSD has to handle CB_RECALL properly in this case.


> Still for an interim step, this is fine...
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


