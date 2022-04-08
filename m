Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391F4F9A27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiDHQM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiDHQM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:12:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499D3568C2;
        Fri,  8 Apr 2022 09:10:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238Eb8UI014737;
        Fri, 8 Apr 2022 16:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fZEr2Bwib1OY0WEnJRQSNnaxGfpugERL9IEW6cJBxFs=;
 b=lYxy8J+4/vJYzIW+5LIzTwrRNdOvMe8Og43yjYJKPJEdCd+XMm+IMahSxRHZu/e45hVe
 vsjFttLQzYIbxfBjoL+3rjs0CFuzBst6ZBxsktg/ZrAsxs1nu2ycM3mq5et6RQcfA5py
 hhwcSx8/rGvKWdcCh4FP3AxjrNuPpHPihBFoTPZ/QBBf7/iCd2/j2cCuCHvD/kv6F6bX
 A25XcaOlTkswEWdQqQbQ8LCabJkcKRwkQ83G5UeIZgYsvjgrLxSLrDgpQHek2d0DFbrh
 4KkXZUpPpXRGJxpDdrL5nTx0Jxqgnyk8i9hN2XDEoVLTlmAGOnBu5PzIsWZ1Mqljcivt ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9y60d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 16:10:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238GAXMn011445;
        Fri, 8 Apr 2022 16:10:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wspfam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 16:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH7/MhREbKn1s7lFbWQnODl9++ANlCs0nMSiK1Wi+EFcRvXSFVSFu0Q03tHnB+xSlUSzHOjHeWZSHQa4YnRBcVll5wrS2JzXMjkVzYrZouXTPRoFY6YYI6EF21UH+QJIvi6Q6jK0OMlj1AxuRmHTxms06ISP8SkCKheyMC7roIB0g/5CdmGGOz8b38M+qAWiqRFcYWZTLY3UIJxyebIgvUjv/0VudsbfU0Qni8RCZM7fhPh8qF1DnQ8M5dFhfbqytDRyo4H31yoffYDCm3bpKlF6WVHyuONPoew1S/5uhL6LsSpJtv2X11qi8vdowNMqTdo/jmPcNwFY4fuxH/eABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZEr2Bwib1OY0WEnJRQSNnaxGfpugERL9IEW6cJBxFs=;
 b=IP2bsntLLVvch76uTOLxX9aY1RgsNiaTcdMzAeAi9TpG+3PxITAvswoeKxHSuCOf1OhM/HINwBMTVlqc1udb1ORd0PlIr6ApSEETQ1guz1dU28+L5O86uAS9uTyZGssiGftOfY4s+RLbUhTAYH8CdZU7M9PipLBiE8u09RWG9a0QKKGAdTc4A7A9mCFROOA/uvImmvu5JhblxJd3kzjuz/oKXZPxGe/2C0sfVyWBMge5pUIwGSk24SKkUdkR1uU3Lo7457SvzK1uTbCENnbunbqfGEduvx5J6lwK++1Omztup7xkuyQtDgWCLjUNMVT4PoldNkF0hhudVAmEuqHiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZEr2Bwib1OY0WEnJRQSNnaxGfpugERL9IEW6cJBxFs=;
 b=s5zJqbJdtKmX6oUZTWZ8nmZ7Z2PoqCz6ofvYLncW0qDPGkZnZkD1+CVAQBKunMdgecNyOyAmhVKhRx1GtQiW1WOQHd0PkQPy6Nar5ooqe0ucM0P/Sf5BrDW6PvlbikBJvIILZKPw7MJgzRbmRXtgwOZaCDkjFbsqHVF+DKsY/Bs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2981.namprd10.prod.outlook.com (2603:10b6:a03:8d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 16:10:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 16:10:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
Thread-Topic: Regression in xfstests on tmpfs-backed NFS exports
Thread-Index: AQHYSdpNL2d3Xru4B0OzHZJ1LCngEazjlm2AgAE//ICAADMPAIABKSsA
Date:   Fri, 8 Apr 2022 16:10:33 +0000
Message-ID: <C7966059-D583-4B20-A838-067BAE86FB3E@oracle.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
 <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
 <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
 <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com>
In-Reply-To: <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 370684c0-299f-499e-5a26-08da197a4f5a
x-ms-traffictypediagnostic: BYAPR10MB2981:EE_
x-microsoft-antispam-prvs: <BYAPR10MB29817E4A59726560499CEA4A93E99@BYAPR10MB2981.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AF2KDF2MKL1Fm5Y31zLir9QyQVv3OTVHyvr9NVwRApkQgJ0mglvMwiGsiO6TvZ9eXBMzx1TLUkWaIj7HTtLC0Qk91YCmIOa7APj5Xk/gbXxiFDlCPUXWPWZoDVCgY0hZEWQTFNE/8r19T2WdfE0755lK8RmIsVucWchXaclcVgH4nYACGynUymhBjekJVQdo89ya2SqFPWDJWcBnsTPMwF0WlDIOFjvYGr7pyWodATCXYhWV2ASvxwsCqX02gZdIiM7ElnvgPc2C1zdyPSAC9RNeOZCRHAHsfY2L0HivbQs7WMsRuoonucIfQJCEUjtIt1EvBABAP2rrW77VbSa/ENdwjRrwbwHaKBtvHLGBCxBmaovJ8vyNcr1Z7CHfquZuQN/sp2+nD71aTzmrjNzF2ZE1hePQ/2rrFsnVpR6UCA7alKPUWTZYhYULGVzslH9UiIGRW+dzVaNwzO4jQ0mW4rDB4Z833ASAO19Iv8xR5KJygytH36Nsf7o0X1UoYSzD8FYzld3e0DKbDQ+oDPpGYr0xFXSZSKo55sTVDl74L/Thot08iGOPOdpjoi5I6LIWupkCBE7SbpRXjXHSpfbj7noi81g/fC3/+uAcdCPufLWD6N0h7o9iQc73ThgHTFrEFyiiN52HvVFL4veRtx/JF9nLhrDbxuGvefB3qRncLe6sgI8fgiaBqh+bzj+oa8RkOa5nBlrUFDlT48vdtc3VEu5Id2fGs6mWVy9nGBGNB4N5qtusw+Bx/aa25eWXJgW2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(5660300002)(53546011)(6506007)(33656002)(86362001)(83380400001)(6512007)(2906002)(8936002)(6486002)(508600001)(36756003)(71200400001)(91956017)(26005)(7416002)(66556008)(66446008)(4326008)(64756008)(8676002)(38100700002)(66476007)(66946007)(316002)(6916009)(54906003)(38070700005)(122000001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?upXrGhe08YHTb8yov1RldEDL5EtZSeRbZiLu/es0UsovQ2rh72NlqpDVr3H3?=
 =?us-ascii?Q?UG6Z7F2MGBovYALbEQVxqF08v+aY7sJ9OJpb3ePJ5QOEBvmgN0T+a18mrRx+?=
 =?us-ascii?Q?3y1zIinObAwtHEXvnvhXFST0d9+IHeLoMSk32raIlka/SSMMZuHUdhUboJGf?=
 =?us-ascii?Q?dxa7nrs5qC+SJb1i0TDz7mnCWaLULZ1R2Em1LUeZ/6dUB2ZkGGXayW2rtly9?=
 =?us-ascii?Q?JCIINYRzmBm3nt+uQ3zpnwS2ywc3/ZDLxmt3UZ11H6OwjGGOqG+TkPOd375+?=
 =?us-ascii?Q?n7hsS81wD9tMUQcdCyhFqPQNWjMcRn9+4mRdEl3Xqt8KOH5X0s1OdzKoMiuw?=
 =?us-ascii?Q?JT65RvroisfdSZgnQ6vzHE+8l0RQY+Zs8tjJSdA1ML3HAI170olDPk/YqcFI?=
 =?us-ascii?Q?OFiK3wpFCUvqREIOxGcT8PwBCvICcEC++YURuYGTTJZFDHOajuZ9kjklnWDh?=
 =?us-ascii?Q?jQF/nxlXPrxDebYxstLwgnfpEp5YZKbNmCsYXtgUfIQMjTXhNu4iw+fGw+cc?=
 =?us-ascii?Q?hy+MLbzoR+qPmZQRiBEgREynJfVbMQJCLMUj6dd3RBtIuV3J+db6KPEj7wWv?=
 =?us-ascii?Q?7/3HzuSIpHZF0VO44MKvY7ElOMR2CA3cFHiKvLi+wB3ghJUopeakBSLh6n1t?=
 =?us-ascii?Q?OOPXC5vs9kBL/L1GlwVG5KDNiCrBCoAs2agCfIOWb1Knnn1MuoAe+mKk5c9j?=
 =?us-ascii?Q?6W7No40meS+gDshHFeJ+sQ7fb4PMVlWiG/5IZkwfMVWwSK2RRhIUbZUFyE4d?=
 =?us-ascii?Q?5bU8Jv2gsiC6iyhRkbPTWEePQF1t/qHr1mXZHgtqOc0PycxuJgGO7rjkZNQA?=
 =?us-ascii?Q?2ckWZG7SqxBpWCMNS1w80CELui9uEU2FBrYRSjvocBKPFX0WDYJnOm4MDCmH?=
 =?us-ascii?Q?Ke/N156aE00EhmHfuhyuVXyApnfwc+oTB196Hyy/fREYtGx8o+U5kV2nuG9P?=
 =?us-ascii?Q?bg9tvLDsGDl607gq6g1Q8CIowxSshVTLIZ03w20NgVpHm/WlifBU6VCC2jUh?=
 =?us-ascii?Q?2JTbKcipzqRnaNSbX6IrcF0Gv5Ybryg4ltj0Koq8kNtmKKjwrXPBPzQBwRvJ?=
 =?us-ascii?Q?KJKagLR8kzjuVZ7JvYqmGGHFgfZQF7m3JlqppEI+INDh2yokrpyFH0rrKvvS?=
 =?us-ascii?Q?StBBKkblnC7O+Neflgaig8vVT9Ze8VwCdmA7fwoQFMOBDLnO2j9UUkm29mev?=
 =?us-ascii?Q?X2uVKshjMapemvO48uymgpiKz5HgcrKI+mpuPtUdTOgNWo8YlOrQDhaqtwLu?=
 =?us-ascii?Q?PL5Zo3rrp7C4WXhLci6sZdKs4WdC/Z1XZ0LP5frfZR9WZi6nLWHd+CT7LIvl?=
 =?us-ascii?Q?oEIgvLMmrJU1wWELqWaBYsiO2tJOiRamcBIfpkWlqrqdciVvuXnOq3bL6uf9?=
 =?us-ascii?Q?cLbTdwNOIDkYv/inWHwwgYiJserqykaIDaTP/7AlaNsXuXmS8gp/uZhi9cCC?=
 =?us-ascii?Q?DqSs6PRV8AxgvEvYK8OcKJ8BTuYqFolIO3NseG8ztVlZQw7PuEpOkG92+KXQ?=
 =?us-ascii?Q?vTwqU70ybtAveGdjztYc8zntJ5l3g2R5DLElysGD8vPx8g2SwgA0fMn6QTRR?=
 =?us-ascii?Q?Y0NH1jMpJ3ODTfsNJMIbyLh91ZrPK3IYTM0h7fEE7vTI90tG9pZ7h0dXcHNw?=
 =?us-ascii?Q?2NjHHJHz8DuTT9RVbVJN8tETA+3WwG/vFUGicW2NoFUrBUEb9moBw8udJ2AQ?=
 =?us-ascii?Q?YF7GsnbZEod9emuyq90n5pZpGQqId/+BxrbjvY3j4lhicBXNus6CoCh65qeG?=
 =?us-ascii?Q?fPtLAWO9DXj3KeVHHWtMWkCpSUjS17Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6144219C30CA4543B7BD26DAA07DCCC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370684c0-299f-499e-5a26-08da197a4f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 16:10:33.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KP/c8p9uVFd8ozNQ14ruTFd90jm5LPDXFSWi7BWdkZKc8vfBaKy6zEU/KWgFVc3wM8uHa1vixg4sc3dUdXfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2981
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_05:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080082
X-Proofpoint-GUID: IoYjSLULMwcU_fEgMwMybaJ79o6ISwQT
X-Proofpoint-ORIG-GUID: IoYjSLULMwcU_fEgMwMybaJ79o6ISwQT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Apr 7, 2022, at 6:26 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> On Thu, 7 Apr 2022, Chuck Lever III wrote:
>>> On Apr 6, 2022, at 8:18 PM, Hugh Dickins <hughd@google.com> wrote:
>>>=20
>>> But I can sit here and try to guess.  I notice fs/nfsd checks
>>> file->f_op->splice_read, and employs fallback if not available:
>>> if you have time, please try rerunning those xfstests on an -rc1
>>> kernel, but with mm/shmem.c's .splice_read line commented out.
>>> My guess is that will then pass the tests, and we shall know more.
>>=20
>> This seemed like the most probative next step, so I commented
>> out the .splice_read call-out in mm/shmem.c and ran the tests
>> again. Yes, that change enables the fsx-related tests to pass
>> as expected.
>=20
> Great, thank you for trying that.
>=20
>>=20
>>> What could be going wrong there?  I've thought of two possibilities.
>>> A minor, hopefully easily fixed, issue would be if fs/nfsd has
>>> trouble with seeing the same page twice in a row: since tmpfs is
>>> now using the ZERO_PAGE(0) for all pages of a hole, and I think I
>>> caught sight of code which looks to see if the latest page is the
>>> same as the one before.  It's easy to imagine that might go wrong.
>>=20
>> Are you referring to this function in fs/nfsd/vfs.c ?
>=20
> I think that was it, didn't pay much attention.
>=20
>>=20
>> 847 static int
>> 848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *=
buf,
>> 849                   struct splice_desc *sd)
>> 850 {
>> 851         struct svc_rqst *rqstp =3D sd->u.data;
>> 852         struct page **pp =3D rqstp->rq_next_page;
>> 853         struct page *page =3D buf->page;
>> 854=20
>> 855         if (rqstp->rq_res.page_len =3D=3D 0) {
>> 856                 svc_rqst_replace_page(rqstp, page);
>> 857                 rqstp->rq_res.page_base =3D buf->offset;
>> 858         } else if (page !=3D pp[-1]) {
>> 859                 svc_rqst_replace_page(rqstp, page);
>> 860         }
>> 861         rqstp->rq_res.page_len +=3D sd->len;
>> 862=20
>> 863         return sd->len;
>> 864 }
>>=20
>> rq_next_page should point to the first unused element of
>> rqstp->rq_pages, so IIUC that check is looking for the
>> final page that is part of the READ payload.
>>=20
>> But that does suggest that if page -> ZERO_PAGE and so does
>> pp[-1], then svc_rqst_replace_page() would not be invoked.

To put a little more color on this, I think the idea here
is to prevent releasing the same page twice. It might be
possible that NFSD can add the same page to the rq_pages
array more than once, and we don't want to do a double
put_page().

The only time I can think this might happen is if the
READ payload is partially contained in the page that
contains the NFS header. I'm not sure that can ever
happen these days.


> I still haven't studied the logic there: Mark's input made it clear
> that it's just too risky for tmpfs to pass back ZERO_PAGE repeatedly,
> there could be expectations of uniqueness in other places too.

So far I haven't seen an issue with skb_can_coalesce().
I will keep an eye out for that.


>>> A more difficult issue would be, if fsx is racing writes and reads,
>>> in a way that it can guarantee the correct result, but that correct
>>> result is no longer delivered: because the writes go into freshly
>>> allocated tmpfs cache pages, while reads are still delivering
>>> stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.
>>>=20
>>> But unless someone has time to help out, we're heading for a revert.
>=20
> We might be able to avoid that revert, and go the whole way to using
> iov_iter_zero() instead.  But the significant slowness of clear_user()
> relative to copy to user, on x86 at least, does ask for a hybrid.
>=20
> Suggested patch below, on top of 5.18-rc1, passes my own testing:
> but will it pass yours?  It seems to me safe, and as fast as before,
> but we don't know yet if this iov_iter_zero() works right for you.
> Chuck, please give it a go and let us know.

Applied to stock v5.18-rc1. The tests pass as expected.


> (Don't forget to restore mm/shmem.c's .splice_read first!  And if
> this works, I can revert mm/filemap.c's SetPageUptodate(ZERO_PAGE(0))
> in the same patch, fixing the other regression, without recourse to
> #ifdefs or arch mods.)
>=20
> Thanks!
> Hugh
>=20
> --- 5.18-rc1/mm/shmem.c
> +++ linux/mm/shmem.c
> @@ -2513,7 +2513,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)
> 		pgoff_t end_index;
> 		unsigned long nr, ret;
> 		loff_t i_size =3D i_size_read(inode);
> -		bool got_page;
>=20
> 		end_index =3D i_size >> PAGE_SHIFT;
> 		if (index > end_index)
> @@ -2570,24 +2569,34 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
> 			 */
> 			if (!offset)
> 				mark_page_accessed(page);
> -			got_page =3D true;
> +			/*
> +			 * Ok, we have the page, and it's up-to-date, so
> +			 * now we can copy it to user space...
> +			 */
> +			ret =3D copy_page_to_iter(page, offset, nr, to);
> +			put_page(page);
> +
> +		} else if (iter_is_iovec(to)) {
> +			/*
> +			 * Copy to user tends to be so well optimized, but
> +			 * clear_user() not so much, that it is noticeably
> +			 * faster to copy the zero page instead of clearing.
> +			 */
> +			ret =3D copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
> 		} else {
> -			page =3D ZERO_PAGE(0);
> -			got_page =3D false;
> +			/*
> +			 * But submitting the same page twice in a row to
> +			 * splice() - or others? - can result in confusion:
> +			 * so don't attempt that optimization on pipes etc.
> +			 */
> +			ret =3D iov_iter_zero(nr, to);
> 		}
>=20
> -		/*
> -		 * Ok, we have the page, and it's up-to-date, so
> -		 * now we can copy it to user space...
> -		 */
> -		ret =3D copy_page_to_iter(page, offset, nr, to);
> 		retval +=3D ret;
> 		offset +=3D ret;
> 		index +=3D offset >> PAGE_SHIFT;
> 		offset &=3D ~PAGE_MASK;
>=20
> -		if (got_page)
> -			put_page(page);
> 		if (!iov_iter_count(to))
> 			break;
> 		if (ret < nr) {

--
Chuck Lever



