Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411B4B1681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiBJToL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:44:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBJToK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:44:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F3EDD1;
        Thu, 10 Feb 2022 11:44:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIgTCZ008856;
        Thu, 10 Feb 2022 19:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fBjoAlPa6KBaTsXrLhrPLetGSNVgyCPlH4jZjL62j9Y=;
 b=PcyH14dQ3Cn+vwHN4BYFaZaCGJUBifmuCurvXidQV3ItGsnxTmAILNDI/SCZx+3+oMMN
 9iqt+9x3RHY4YSZZWo3/Q9TNWJvuRVXbxgVW7ECP98YIATGthZbmBe/zTYUSnXMEdqnp
 TFMoWgzQ6zRdV0o8FPVgtxx4qc2yRz7900GFXHG6u+mhUBRWBLdAmiw3MsYF5QE51xvL
 2EGXNc9gyJuAKvm+ZcHIJpcHOQNoWfGDYy7Iuw/9saModzz4QyyeN5DccbOOuL5nyLLJ
 Ub3wXb3CL422TYxYMgPZBHxbmnadMdxxwRhjQW8ixkdHTceL7/XvCCbgu21ubjcUn47l 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgsd67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:44:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AJfu7q130520;
        Thu, 10 Feb 2022 19:44:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3e1ec5pr5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 19:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGCFIZjglHzdQNUBzmBNXZnsBBXW/G16iJyXnQkVyJzO7q7qtrzgbPyg922vo83QW+qCLgYQ/l5+44JMV/3j49pcFTQ7uRxxeBTsXka2AzxBELXa3MyafyAsMNfVvS2EWvon9iL+x0lZrh9cO8uz8v7VdjHnEud3rRkKjAj4H9MIn+XZp3KYU8O2NwY+qu+c5MzkWJQodaKOf54GX/c68KRmoXQ3LBadYGu0+JBP4INJ9EjSICGA3gpX1Gu96TlfhqopYgVS+bai3dJt8RfpuVYnvjXviE4DFlZ6ppnGBTTLD0wuHNuU5TT7n72MW9WnhZOLoL2G7nZm8wDu9hdmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBjoAlPa6KBaTsXrLhrPLetGSNVgyCPlH4jZjL62j9Y=;
 b=coSkFTnr9EySqarHroQdbnDLzFvJHybLL0Fw2ytEI2Zmv0Lq526hfwS5X/CPZCsT7mvOIOp7iE+rBqmO6SjiootqUrkc3cis2DGQKPSFa6ildWbymaG0I6Y8YirVF6lNluVoMKMhW23FfG1S9WExkk3Fa0ktIhcAgMzIcfyXQZPpxS5hpwA4Xt7FMyTx9D+JGKggbkHpveO1eUoPs749MjbrF3x5Y+jZC0HFC7xml+ZsH4sdA3AmR05RsqzIuvTjKz1KtsHmshPWQLPYhqUx7j67nJA1lM9lBovZMFLsnPqCrZO3i0wnQW7r49EStud/7HF4jkvJD6FTzJqm8yMD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBjoAlPa6KBaTsXrLhrPLetGSNVgyCPlH4jZjL62j9Y=;
 b=v47wuAssG8QzresMl3YpBnR94Io87FhyKDjYdxn+RTocvkV2fCo+pXzw8RvNEzzJfOOEeb+XuZ5iDbCZsk8bFWGIzYKJ0iTSAkGsgD6/Yg745F+LQGxEyMA4KoAeKDQI8pl8JSGxRpT/YwjhCqLFS3zBn5o3TGg3QPAbwueTCfQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CY4PR10MB1269.namprd10.prod.outlook.com (2603:10b6:910:5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 19:44:03 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 19:44:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Thread-Topic: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Thread-Index: AQHYHjn6Ujwua4SbTkavmYzo8J2MF6yM1pmAgAACGACAAFdVgIAAAKEA
Date:   Thu, 10 Feb 2022 19:44:03 +0000
Message-ID: <E7CBF516-9DE5-4AC6-AFB1-148188C74699@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
 <20220210142143.GC21434@fieldses.org>
 <c069bb1b0ec50358fc4d093ebd7482c7484d77b4.camel@redhat.com>
 <47535edd-9761-f729-1d6b-f474a31eeafc@oracle.com>
In-Reply-To: <47535edd-9761-f729-1d6b-f474a31eeafc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c163ba58-7f1e-4e0a-0a7d-08d9eccdb155
x-ms-traffictypediagnostic: CY4PR10MB1269:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1269F89937EEE8C4FED0D221932F9@CY4PR10MB1269.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EdJwJbzq1iglV7ZfMDwmnPs3hE3SJ4ltCuJOyvphWd6oEKCJ7xBN1wuAO90ok7jnlcjwJPZ6E3SK6h6xct9edw9DCsEYkmYWS+EKGU9+xEnMOctKrNdaFf4rPRNsCoTfMUy2iSa457Q+xCqW4In+eIa94Y0/Gxy6wgnfTY06yPQxsHCoL8OuCK6vWSL09n+OyG1s/lPOMnBM9H0bkls449h0yRQxgESNt0g1SFHqq+NbMY6khGFGG2IarOBFaDJzJMnUb062reX/os+guSZyhj46jeBRZUzPqfwbzjVRcu9zoAGiK5FjiCB6S1NtPSVhtRR6EGF53jubIVTvuMkLVcgkDuthYnI14KjJ59u0UdFDrkhCWjVNYv+sFoX08SCCjc46v+RWPy3A9w8ugQSN/bsfiQ6BNi5afK9JrTefCF1xktMBnpOnx9zC/NepjB8gVKbCUe6g3dV9zvcYgj+5IoE31TrrT04PNgucIwYm3Npxfbg9t/gQ+uhjB3MADCvLuOFdys+6TUE0gDYtu3e6sPaDVbdeptqBz7kSqjwveBivGedcpa+Mp2hxRP9PJeom16NmIhrfE/uMiAF1KDinucxEyYeMbLelvKBk3eihLvuPlZy0wZi9o3lOWM92A3wM+xcUAUOlWSAigqh8lhrn0ytBAWqizAP6EJL17yDplft4tgwb01rjTmW2oWU5LspbKnyPSn4JcBfnfrPnx3l+s1doj+BFktk/mRNF41lVbaSGKcWjyNrwyc89LH6O5Gv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(66556008)(66946007)(8676002)(64756008)(6506007)(66476007)(71200400001)(36756003)(8936002)(6862004)(508600001)(6512007)(53546011)(54906003)(37006003)(66446008)(4326008)(76116006)(2906002)(26005)(316002)(2616005)(6636002)(86362001)(38100700002)(122000001)(186003)(6486002)(33656002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gG4+4cine7fIVBTWt//WFtlUGXhYoCNHdCk3jCuxU0nR1gM7ES4glVkcuePn?=
 =?us-ascii?Q?6o7NymcovXf+r6svjcOL/f8hMqxwAL6S8bh+/NEY4w9MKFQm4aS75zvUiaL6?=
 =?us-ascii?Q?yATDG3+6c7tQA27SSPGj0lgf7A4G3D1B9aj3NCOfXoIsLk5EMK2uWuBuE9UQ?=
 =?us-ascii?Q?RVZ70DaRcfc4qa03mgnYIiaW99iob+oIT5BZld5iTQBYOYCIRJZd4xbSj1Jv?=
 =?us-ascii?Q?Xb2iVZDcTz2o9sQXbR0U4aksu2crbY/miU8cdjP2gsPdiqvzVYYDrZOm4E2v?=
 =?us-ascii?Q?s3pknuULz7lmr6MuSMHzBBJJVIgnhpDBtb4LwU8TphVWU3SpdQd6xUkVzI+G?=
 =?us-ascii?Q?1irjq3pA6MCLEgVF/js0J9X+KcEVKA16ncwlCyTLj1Uhop5pnNwA4clqI9xG?=
 =?us-ascii?Q?i2GiKAMQhPP/si6ibaBqD7UDaWjTWOR5F/7UVFP8zbh05E8DJfkQKWrC0pAL?=
 =?us-ascii?Q?dm2yQwdTRYaEFGChV4AVrZfz3L3AMfwUpMXrle22vH4KmcQ6AO3g+g6p9fNJ?=
 =?us-ascii?Q?ZRHVKO7MvDUoDWqzsCt2P3ZEUcs3mjNM6r5/rR8v2D0LJNWCpYhA3ZHq9NkC?=
 =?us-ascii?Q?fN+U+ZQYpY3w0DogQ+Sk3IwaCpHSJmPPzvS8Q4KSu32qv+psZiVorhtWfbAQ?=
 =?us-ascii?Q?V2yA9W4e1w274FkQK4SeG73KMPdTEMnws+HKnUzT9+ilbzvewi9Iq4ly6nBM?=
 =?us-ascii?Q?aPg70keWhuaUpIC1F7C2xXTESLb0XbsIvrLGYZfdCQbkouX2eBsNaXq8vYgG?=
 =?us-ascii?Q?+WWYo5e1ooVcOkF3q58s+lqrylWaTFD64LWL+T6LERIO0E/hNYbUBLJthe1K?=
 =?us-ascii?Q?n3NNN4pXdLolNkY7+3lGivLDOWhe817XJ07EpGofgPZ7K81DWxbnEUu5fBKG?=
 =?us-ascii?Q?BX64vdCeNF1++baVMyMNV3KRZZtuUjKHhAJzYE4ZoatOwEaWHWoFK7ohCdfS?=
 =?us-ascii?Q?vTKJsvY5XiUrH5KY/m6dgccAa2q11582Au0x5XhbyYbUGVM5lRk2Qy5X01TQ?=
 =?us-ascii?Q?SY4IGB4x0K4evEzxMFSZhrrCf9wBP4dOtzt35nK+A6wr9jVWgz2smZ37//gJ?=
 =?us-ascii?Q?Ao9vlEnnPyZW1JVeWvanXf8nZXimp+Dmjcm+Hna/mLaAUj1pAf3oeADfmfiN?=
 =?us-ascii?Q?XIhbkt/xAlWGQ+WU3N8h3scoGO3RxtWHPCegTiDXKEqsqVs9BJjM5VLLYwvq?=
 =?us-ascii?Q?asWdRAHp/rySm/YPi8nhZGkncC7FOrEd5ipJRI+NVPX8SCDwVJnpbcJx7y4n?=
 =?us-ascii?Q?IBTxc5LTuLo7oIxXQLA8rsxd546RJmWKwm2o+qWLiAV/ATuDDl5n9Js0V4aa?=
 =?us-ascii?Q?rJVDaVpAxrydnG/YQR4gVkZBsPI9b6yDm1Ae6tm+n7mf0OpnD+U1kzmplo+Q?=
 =?us-ascii?Q?3kDNCTcdR/M0pEiv4q4dE7fHq9I1N8fLcrTK4S1pKNbUh6JzdkaCZVxys+oN?=
 =?us-ascii?Q?YLIxyoB9MBhu5af7l6SNkFWunbfLi+P2CRuD66kjzqMpwoKUtuQmrJT/LS8a?=
 =?us-ascii?Q?XWFosx0RXPwi8CGv00lQNxwycVes/R2adC8ow4C/uPSALnauzEgtXXyZN1ta?=
 =?us-ascii?Q?mFnKoBO5bT9roW8HhCSIsu3a835w3CGhuwRQsoeMQ2dlshcMXa5JiIBh8lhQ?=
 =?us-ascii?Q?tq7nKLUrwkI4aVGfOds9Cxk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2D10CBDF70ABB40B55C1E972393B60F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c163ba58-7f1e-4e0a-0a7d-08d9eccdb155
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 19:44:03.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIaLPKkuozn/PQoVxhAgc3PCWrvgkXNpAge5gqAlsCEBaOzWrYGOTyX8fh/xsuT06GZOuhNa53dAutgCXpu57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1269
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100104
X-Proofpoint-GUID: cXPUAkDteflTuC021wVuyav-DkrvCPMX
X-Proofpoint-ORIG-GUID: cXPUAkDteflTuC021wVuyav-DkrvCPMX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 10, 2022, at 2:41 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 2/10/22 6:29 AM, Jeff Layton wrote:
>> On Thu, 2022-02-10 at 09:21 -0500, J. Bruce Fields wrote:
>>> Jeff, this table of locking rules seems out of date since 6109c85037e5
>>> "locks: add a dedicated spinlock to protect i_flctx lists".  Are any of
>>> those callbacks still called with the i_lock?  Should that column be
>>> labeled "flc_lock" instead?  Or is that even still useful information?
>>>=20
>>> --b.
>>=20
>> Yeah, that should probably be the flc_lock. I don't think we protect
>> anything in the file locking code with the i_lock anymore.
>=20
> Will replace inode->i_lock with flc_lock in v13.

To be clear, if you're fixing the documentation, that would need
to be a clean-up patch before your 1/3. Thanks!


> -Dai
>=20
>>=20
>>> On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/fil=
esystems/locking.rst
>>>> index d36fe79167b3..57ce0fbc8ab1 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -439,6 +439,7 @@ prototypes::
>>>>  	void (*lm_break)(struct file_lock *); /* break_lease callback */
>>>>  	int (*lm_change)(struct file_lock **, int);
>>>>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>> +	bool (*lm_lock_conflict)(struct file_lock *);
>>>>    locking rules:
>>>>  @@ -450,6 +451,7 @@ lm_grant:		no		no			no
>>>>  lm_break:		yes		no			no
>>>>  lm_change		yes		no			no
>>>>  lm_breaker_owns_lease:	no		no			no
>>>> +lm_lock_conflict:       no		no			no
>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D

--
Chuck Lever



