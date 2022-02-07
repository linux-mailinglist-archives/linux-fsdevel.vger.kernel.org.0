Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4904ACB06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiBGVNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiBGVN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:13:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C783C06173B;
        Mon,  7 Feb 2022 13:13:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217IMZq9007554;
        Mon, 7 Feb 2022 21:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tAymtZJNnEYjpH4ntGztc5gbHR82kjqYMLR8GesyNBU=;
 b=ftDRAPY1nMBGtEMnATr04IblTnP/TKmkAQ6w6sR5s8NUl4Eg0cpVWd7SsY6ft/F0H/Xh
 WpC7d21kPFFdqHdswV6LHrhw0lI/zadH/2DRdepT5jz/k6JlStPy3e6d9joeCwv/0ZID
 +8CJC37c9CRSPPUHsdNpuUkEKg3wxQqXFLMpG0sLjgvDJj5Sy6ogZ5BmXmpinoBKHHS+
 5WzS9rPgoi5Tu6qtuCWq/nBq4//vEvNj5bSOl6D/zspuViWWkjNbvH4aw99mWfXlwPAs
 4ZBXbZGUU7S+iEjXEf/5QyNEmHTeJp0PCMpskiy5SU6q6DFGIZQvfBrRoQ28i3xeFs1L bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368trty7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 21:13:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217LC1iv020954;
        Mon, 7 Feb 2022 21:13:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3e1f9e0dv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 21:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bytn5jKiJ81ibQ15olHkhOVfQ8e3lP3gnrNhHOD8CYebt96qwLPKw0EMZ/eSntvn9mJvArlTIMUVOmQjvEQDYKviBDRkxdJFRGgdr15JYY2C1iWdwVRsxovD+w4yk9ibBTT+s5DJYrwqkJQmgmF4xXFTtxBNLsGnN0R2fXm92BdQYaBwzvLYq3hSw6A/rIhZnEXaDLsNKV4ckVtP1gAy0xqQNaeKxnThg2n704+vp7PSV8BJ0PHi30O2XK8304qFFSCIa6K7FLM300xlapnJilFyxpbokMCBVDm0e1zJb8GEOMjjD8cIETR2EVKZqRyq8QxhK8czFixKgoFnmVNLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAymtZJNnEYjpH4ntGztc5gbHR82kjqYMLR8GesyNBU=;
 b=kZPPH3nVnGOfYirSqyJz8b0lpBQbELOQz6aRlcIP5gTQmbv296YVv5/ZBmqWJGhNSB799HyDqrDS7mADCvMLHvmg52Rox9FYDuvzR3gohrdSkJ4guGs36o6S+kXd7FMbpxyJhCvvmqMICwdx5HSjBzHG2SFd7qpT9ux3gQ0uV2+V5mlHsfCMctSsvCSplJ19i/LDtpzewHWnGYbDNfJ9KAkWzDuob0eRrZ3t/tIDF1zP+oZ5k0KirqRr8rWS7s0BDldJyswNN5bwPu5cEbS0IcMY8gt8UT7L5JcgYl24+xVcsL0e37hwiX4Ufqjdubzvh4ovRcTZT9L5zaZENCD3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAymtZJNnEYjpH4ntGztc5gbHR82kjqYMLR8GesyNBU=;
 b=Yuar1gf/aFAHXCM5bvs+YqKs5cjnasssuSqtZZ+X//TKJyntMbdkFmjgqhcRA8Kjd5A7vfWfnI1nStjIU3EPPNDiQY4/BNmUmwqdRMQywG/OOrC9o/bKZDsXfdQmZPo4b8NcO0ya2oXOC4gjsfJcZxivVdE28yOoDqdJ4WZML1Q=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 21:13:18 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 21:13:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v11 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v11 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYG6Dj6wpeypQdekCSVDVzqn0rf6yIf/qAgAAX0YA=
Date:   Mon, 7 Feb 2022 21:13:18 +0000
Message-ID: <3A9EBB5C-2030-4181-9B3C-70B4F835B204@oracle.com>
References: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
 <1644183077-2663-4-git-send-email-dai.ngo@oracle.com>
 <2321052ae1347a263ae03bbdb2c3cf04ba652338.camel@kernel.org>
In-Reply-To: <2321052ae1347a263ae03bbdb2c3cf04ba652338.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edb525f6-ecc9-4b96-26a9-08d9ea7ea9fb
x-ms-traffictypediagnostic: SJ0PR10MB5583:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5583B1953076481C4970E475932C9@SJ0PR10MB5583.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MZbuEkTXKZAxpBF0f40D1ltWMfIIz1IWOMSQ7Btl0EB2oiiz6FonaPvJw/VBS0Ebz08F0hIm1WGb2zADSDJr3PaRVzoESwOaye7TFm8yl306sErq4Ay2RZebdbe3koCIY7PNWtlTUjgMDUg0trcJwSq/+ElWJcoOAO8O82M+ewN7yG4+4RTqHVRlwrfnij/77c8wFLJYwTQlaGmLVQ/WLRyFnQyGkFyLsWy34ODOiC361pli+Bt3pn0hv3vx1MYO/HVdwF8/mNIpZzfbv4jrwdFSPXMXoE2wztckry0HPPMuGhYljMJgaMM8KycTlLTFiqNiecjZMY2X3EvptsTtrx4tl2KMqJdfNU1nk0HHEIay7IUS8Y1ipS9zfzli64NvXVECTfAvIM+tqtH7cdQbw8Zk2GSvpwGdyU4giNjWngHENBknX8a3BRwIRkyTwFryhk418fDlyqQTf8vXu4mJdeXhpX4KlxTlSQ+IBS3f7/MwYW3A+ioZWX4deNIB2TT8VYvTmfS5cX+2oti52DtT9l7wdLFcjoA0HLnWwrSDdDrpjj6734BfvZYbD7IDTPRJCVDNsdB7QwmTyP/QZiCLV4suzJ5LYBMVkigV/60eK1T/liw9zR//l0D9MFIfymvfiK/IpvEdNt1Tdl9nAwYbza9SAQDBkuRkNdhul02m3OoikKcf3JjYifotUKvI+UwPPzdxWfMjJv28wBEI90aDdAdGugHUSi6U8wiEClfu9DxduD+ASWsCu0xc+XzdCLU5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(53546011)(76116006)(2906002)(6486002)(6506007)(86362001)(83380400001)(66556008)(66476007)(64756008)(66446008)(66946007)(4326008)(316002)(54906003)(8676002)(6916009)(8936002)(71200400001)(38070700005)(38100700002)(5660300002)(122000001)(30864003)(26005)(186003)(6512007)(2616005)(36756003)(33656002)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O3My1Y/y/KztZPpCcH24QRdMMx1CduUqPA7StQR8k0GLTZ32P1WQbO3gSz6W?=
 =?us-ascii?Q?ptLK3+DNrlwJfU83k55XFHyljDeNNKSwG5niJFw/RVwShDOD/VttUxO/Y/4v?=
 =?us-ascii?Q?6op+oX7yRDHNoA8G+xeEtGkTkVwQWPkg0fZtpmLv2Wx06fcxe3F7Vy9BaIya?=
 =?us-ascii?Q?a89jgoSYOP0/j3YPCmCfmdfdZfFUddRAs1CGLVh6nUhQ1yvhb45B/1hOp1qG?=
 =?us-ascii?Q?xOqcTfW2ASROK8lpg3SiSeCrCjGAY+LHaQGSLndkIToMP564UMowYwVFphtT?=
 =?us-ascii?Q?44sMqMbysCECcWucY6pt9o5XmMNCEsaPxu++5zGVYqNfxlJM75xgTXHjy+3p?=
 =?us-ascii?Q?65+g/qCoR1+7IWIyqBIb6ndsSkI5rY/dtmNGVKr6ux3kg0lKCRpotTDi89+h?=
 =?us-ascii?Q?I+w4ZzqJQQOkL1O6eRyDVvjAt6fNyywwL1Tu/qJ1sJ6OpZCW1qykBXk3iGwb?=
 =?us-ascii?Q?r8Bkb/BugnvBcOsnJPB39q2NNA5I6knjcmnDbYF/J50gh70LAB7I0vb8LBoY?=
 =?us-ascii?Q?C/8cJdPu4Dx6ubKnxAONmqICpNREtokjWUhXnM1n6zSxzI16dUxdvCfuavKV?=
 =?us-ascii?Q?TJdwO862OdXRvYlu6kt7LNQ4utNvEDnW2CV875UzVkhynrDfSlmwm8zJUHWZ?=
 =?us-ascii?Q?60sDt1KKP0IGdiv7JkK/GWnSH6IFnue9WARGWicMM1qhLVtgS1aoU/K7Rjma?=
 =?us-ascii?Q?hEgICH6/nQ95k6ATI/jVwEZMqsCmBVLDBeTonJbBsl8VzubNVxZvYGoiei5B?=
 =?us-ascii?Q?1bLiLZ1rMLATn5MSPCFCP2rmJ3WJh4HrGNARDMdoMC3f4SzSVqqd99AU6oFO?=
 =?us-ascii?Q?CaYXonNfNrre/snUZqxyBnQGQhEK9DMgBEyjucpa0Ad3y4A8iGz/pLpQ4HQs?=
 =?us-ascii?Q?638pbggRiWMFBGFDhwzyCLskozyRsMnMAx7qzfuL7mJRYt+LBMVRUosls96a?=
 =?us-ascii?Q?DTVhs3WbnJ2/AUebq5ZWH3rFWcSg9y8M2kD2yVfG6iv+W5U3XZnOOxDbtV1E?=
 =?us-ascii?Q?Znz5kfQw5dB3I9MKRPN3uyJ80VhTJMTvuvleQUCT4jwEVht2SAPgS6/j5paz?=
 =?us-ascii?Q?P52Y8IUFVDUYAeA4Xi7yI9wCWN43UBKZxrhFgOYw3F+5mt/11K6uMKgcSXxL?=
 =?us-ascii?Q?AtGepI3hkaMubHwmH16iMM8P+fLGyyQc4lpxHia/Bl9fPqKIl8nBi0oW5Y+v?=
 =?us-ascii?Q?rIEdClbpliJgq8L/bNj3zoNK8YLTcmMIMvnQ3SjNTSIyBkF3TWaWzXGUdJQs?=
 =?us-ascii?Q?jM+kuVXL7cIVQ9AljuWj6P/nvE7RG8USkTs5BUeHkCny5U1nwCqNo5MudKHd?=
 =?us-ascii?Q?QN09TC4CGga8qPwIof3ZHZedYPAvRc3bf6p0MCJ2Ah0N+ubDxt9i8z6E1ktb?=
 =?us-ascii?Q?OtT+SWQMG7XygHepwkFhhVp4VqwQm2Rf2rEo2zm2NBv+7borvzzRmQtjy+4c?=
 =?us-ascii?Q?jPktQvH3VIdXgLXgfiI8dfdKeLTzQtWYhFXFYto1iZQARFioD81z6/qys1Lw?=
 =?us-ascii?Q?o0rLpzI+AfUY6FvmPdvtKFWBoSfQZPzv0zsmTh8MeYkQBafHeWUUWOluDrIZ?=
 =?us-ascii?Q?4U0dbF5Q+hBE1YRsff02pXuRwjkg5ifhdVC7fVSERfAjcxax1jW0HxElm1Tn?=
 =?us-ascii?Q?jFjJvMAdO5S6AsT9K16Gc/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02B165983AFF414EBFCB4A3CDECF707B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb525f6-ecc9-4b96-26a9-08d9ea7ea9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 21:13:18.7130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19gQVnP/3o8iZxV7NHSf6NtMvlF0NrIQb0YCWXjorjkiFQXjdS9U69rJzLk2gMtvQGMHNe7mhAJ9EXqkXpahhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070121
X-Proofpoint-ORIG-GUID: b8_fjrufZPMQcHri_0rN5piwQnGJqK_s
X-Proofpoint-GUID: b8_fjrufZPMQcHri_0rN5piwQnGJqK_s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 7, 2022, at 2:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2022-02-06 at 13:31 -0800, Dai Ngo wrote:
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If th=
e
>> client fails to renew the lease, for any reason, the Linux server expung=
es
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client shou=
ld
>> reconnect and attempt to use the (now) expired state.
>>=20
>> The default lease period for the Linux server is 90 seconds.  The typica=
l
>> client cuts that in half and will issue a lease renewing operation every
>> 45 seconds. The 90 second lease period is very short considering the
>> potential for moderately long term network partitions.  A network partit=
ion
>> refers to any loss of network connectivity between the NFS client and th=
e
>> NFS server, regardless of its root cause.  This includes NIC failures, N=
IC
>> driver bugs, network misconfigurations & administrative errors, routers =
&
>> switches crashing and/or having software updates applied, even down to
>> cables being physically pulled.  In most cases, these network failures a=
re
>> transient, although the duration is unknown.
>>=20
>> A server which does not immediately expunge the state on lease expiratio=
n
>> is known as a Courteous Server.  A Courteous Server continues to recogni=
ze
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>=20
>> The initial implementation of the Courteous Server will do the following=
:
>>=20
>> . When the laundromat thread detects an expired client and if that clien=
t
>> still has established state on the Linux server and there is no waiters
>> for the client's locks then deletes the client persistent record and mar=
ks
>> the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
>> all of its state, otherwise destroys the client as usual.
>>=20
>> . Client persistent record is added to the client database when the
>> courtesy client reconnects and transits to normal client.
>>=20
>> . Lock/delegation/share reversation conflict with courtesy client is
>> resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY=
,
>> effectively disable it, then allow the current request to proceed
>> immediately.
>>=20
>> . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed=
 to
>> reconnect to reuse itsstate. It is expired by the laundromat asynchronou=
sly
>> in the background.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 459 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>> fs/nfsd/nfsd.h      |   1 +
>> fs/nfsd/state.h     |   6 +
>> 3 files changed, 425 insertions(+), 41 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1956d377d1a6..5a025c905d35 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1917,10 +1917,27 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid =
*sessionid, struct net *net,
>> {
>> 	struct nfsd4_session *session;
>> 	__be32 status =3D nfserr_badsession;
>> +	struct nfs4_client *clp;
>>=20
>> 	session =3D __find_in_sessionid_hashtbl(sessionid, net);
>> 	if (!session)
>> 		goto out;
>> +	clp =3D session->se_client;
>> +	if (clp) {
>> +		clp->cl_cs_client =3D false;
>> +		/* need to sync with thread resolving lock/deleg conflict */
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			session =3D NULL;
>> +			goto out;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			clp->cl_cs_client =3D true;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +	}
>> 	status =3D nfsd4_get_session_locked(session);
>> 	if (status)
>> 		session =3D NULL;
>> @@ -1990,6 +2007,7 @@ static struct nfs4_client *alloc_client(struct xdr=
_netobj name)
>> 	INIT_LIST_HEAD(&clp->cl_openowners);
>> 	INIT_LIST_HEAD(&clp->cl_delegations);
>> 	INIT_LIST_HEAD(&clp->cl_lru);
>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>> 	INIT_LIST_HEAD(&clp->cl_revoked);
>> #ifdef CONFIG_NFSD_PNFS
>> 	INIT_LIST_HEAD(&clp->cl_lo_states);
>> @@ -1997,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr=
_netobj name)
>> 	INIT_LIST_HEAD(&clp->async_copies);
>> 	spin_lock_init(&clp->async_lock);
>> 	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>> 	return clp;
>> err_no_hashtbl:
>> @@ -2394,6 +2413,10 @@ static int client_info_show(struct seq_file *m, v=
oid *v)
>> 		seq_puts(m, "status: confirmed\n");
>> 	else
>> 		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
>> +	seq_printf(m, "seconds from last renew: %lld\n",
>> +		ktime_get_boottime_seconds() - clp->cl_time);
>> 	seq_printf(m, "name: ");
>> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -2801,12 +2824,15 @@ add_clp_to_name_tree(struct nfs4_client *new_clp=
, struct rb_root *root)
>> }
>>=20
>> static struct nfs4_client *
>> -find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> +find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root,
>> +				bool *courtesy_client)
>> {
>> 	int cmp;
>> 	struct rb_node *node =3D root->rb_node;
>> 	struct nfs4_client *clp;
>>=20
>> +	if (courtesy_client)
>> +		*courtesy_client =3D false;
>> 	while (node) {
>> 		clp =3D rb_entry(node, struct nfs4_client, cl_namenode);
>> 		cmp =3D compare_blob(&clp->cl_name, name);
>> @@ -2814,8 +2840,29 @@ find_clp_in_name_tree(struct xdr_netobj *name, st=
ruct rb_root *root)
>> 			node =3D node->rb_left;
>> 		else if (cmp < 0)
>> 			node =3D node->rb_right;
>> -		else
>> +		else {
>> +			/* sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return NULL;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags)) {
>> +				if (!courtesy_client) {
>> +					set_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +							&clp->cl_flags);
>> +					spin_unlock(&clp->cl_cs_lock);
>> +					return NULL;
>> +				}
>> +				clear_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags);
>> +				*courtesy_client =3D true;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			return clp;
>> +		}
>> 	}
>> 	return NULL;
>> }
>> @@ -2852,15 +2899,38 @@ move_to_confirmed(struct nfs4_client *clp)
>> }
>>=20
>> static struct nfs4_client *
>> -find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool s=
essions)
>> +find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool s=
essions,
>> +			bool *courtesy_clnt)
>> {
>> 	struct nfs4_client *clp;
>> 	unsigned int idhashval =3D clientid_hashval(clid->cl_id);
>>=20
>> +	if (courtesy_clnt)
>> +		*courtesy_clnt =3D false;
>> 	list_for_each_entry(clp, &tbl[idhashval], cl_idhash) {
>> 		if (same_clid(&clp->cl_clientid, clid)) {
>> 			if ((bool)clp->cl_minorversion !=3D sessions)
>> 				return NULL;
>> +
>> +			/* need to sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				if (!courtesy_clnt) {
>> +					set_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +							&clp->cl_flags);
>> +					spin_unlock(&clp->cl_cs_lock);
>> +					continue;
>> +				}
>> +				clear_bit(NFSD4_CLIENT_COURTESY,
>> +							&clp->cl_flags);
>> +				*courtesy_clnt =3D true;
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			renew_client_locked(clp);
>> 			return clp;
>> 		}
>> @@ -2869,12 +2939,13 @@ find_client_in_id_table(struct list_head *tbl, c=
lientid_t *clid, bool sessions)
>> }
>>=20
>> static struct nfs4_client *
>> -find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net =
*nn)
>> +find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net =
*nn,
>> +		bool *courtesy_clnt)
>> {
>> 	struct list_head *tbl =3D nn->conf_id_hashtbl;
>>=20
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_client_in_id_table(tbl, clid, sessions);
>> +	return find_client_in_id_table(tbl, clid, sessions, courtesy_clnt);
>> }
>>=20
>> static struct nfs4_client *
>> @@ -2883,7 +2954,7 @@ find_unconfirmed_client(clientid_t *clid, bool ses=
sions, struct nfsd_net *nn)
>> 	struct list_head *tbl =3D nn->unconf_id_hashtbl;
>>=20
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_client_in_id_table(tbl, clid, sessions);
>> +	return find_client_in_id_table(tbl, clid, sessions, NULL);
>> }
>>=20
>> static bool clp_used_exchangeid(struct nfs4_client *clp)
>> @@ -2892,17 +2963,18 @@ static bool clp_used_exchangeid(struct nfs4_clie=
nt *clp)
>> }=20
>>=20
>> static struct nfs4_client *
>> -find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net =
*nn)
>> +find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net =
*nn,
>> +			bool *courtesy_clnt)
>> {
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	return find_clp_in_name_tree(name, &nn->conf_name_tree, courtesy_clnt)=
;
>> }
>>=20
>> static struct nfs4_client *
>> find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net=
 *nn)
>> {
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->unconf_name_tree);
>> +	return find_clp_in_name_tree(name, &nn->unconf_name_tree, NULL);
>> }
>>=20
>> static void
>> @@ -3176,7 +3248,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>>=20
>> 	/* Cases below refer to rfc 5661 section 18.35.4: */
>> 	spin_lock(&nn->client_lock);
>> -	conf =3D find_confirmed_client_by_name(&exid->clname, nn);
>> +	conf =3D find_confirmed_client_by_name(&exid->clname, nn, NULL);
>> 	if (conf) {
>> 		bool creds_match =3D same_creds(&conf->cl_cred, &rqstp->rq_cred);
>> 		bool verfs_match =3D same_verf(&verf, &conf->cl_verifier);
>> @@ -3443,7 +3515,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>>=20
>> 	spin_lock(&nn->client_lock);
>> 	unconf =3D find_unconfirmed_client(&cr_ses->clientid, true, nn);
>> -	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn);
>> +	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn, NULL);
>> 	WARN_ON_ONCE(conf && unconf);
>>=20
>> 	if (conf) {
>> @@ -3474,7 +3546,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>> 			status =3D nfserr_seq_misordered;
>> 			goto out_free_conn;
>> 		}
>> -		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
>> 		if (old) {
>> 			status =3D mark_client_expired_locked(old);
>> 			if (status) {
>> @@ -3613,6 +3685,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst =
*rqstp,
>> 	struct nfsd4_session *session;
>> 	struct net *net =3D SVC_NET(rqstp);
>> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>=20
>> 	if (!nfsd4_last_compound_op(rqstp))
>> 		return nfserr_not_only_op;
>> @@ -3645,6 +3718,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst=
 *rqstp,
>> 	nfsd4_init_conn(rqstp, conn, session);
>> 	status =3D nfs_ok;
>> out:
>> +	clp =3D session->se_client;
>> +	if (clp->cl_cs_client) {
>> +		if (status =3D=3D nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +		}
>> +	}
>> 	nfsd4_put_session(session);
>> out_no_session:
>> 	return status;
>> @@ -3667,6 +3750,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct n=
fsd4_compound_state *cstate,
>> 	int ref_held_by_me =3D 0;
>> 	struct net *net =3D SVC_NET(r);
>> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>=20
>> 	status =3D nfserr_not_only_op;
>> 	if (nfsd4_compound_in_session(cstate, sessionid)) {
>> @@ -3679,6 +3763,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct =
nfsd4_compound_state *cstate,
>> 	ses =3D find_in_sessionid_hashtbl(sessionid, net, &status);
>> 	if (!ses)
>> 		goto out_client_lock;
>> +	clp =3D ses->se_client;
>> +	if (clp->cl_cs_client) {
>> +		status =3D nfserr_badsession;
>> +		goto out_put_session;
>> +	}
>> +
>> 	status =3D nfserr_wrong_cred;
>> 	if (!nfsd4_mach_creds_match(ses->se_client, r))
>> 		goto out_put_session;
>> @@ -3783,7 +3873,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>> 	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
>> 	struct xdr_stream *xdr =3D resp->xdr;
>> 	struct nfsd4_session *session;
>> -	struct nfs4_client *clp;
>> +	struct nfs4_client *clp =3D NULL;
>> 	struct nfsd4_slot *slot;
>> 	struct nfsd4_conn *conn;
>> 	__be32 status;
>> @@ -3893,6 +3983,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
>> 	if (conn)
>> 		free_conn(conn);
>> 	spin_unlock(&nn->client_lock);
>> +	if (clp && clp->cl_cs_client) {
>> +		if (status =3D=3D nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else {
>> +			spin_lock(&clp->cl_cs_lock);
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			spin_unlock(&clp->cl_cs_lock);
>> +		}
>> +	}
>> 	return status;
>> out_put_session:
>> 	nfsd4_put_session_locked(session);
>> @@ -3928,7 +4027,7 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>>=20
>> 	spin_lock(&nn->client_lock);
>> 	unconf =3D find_unconfirmed_client(&dc->clientid, true, nn);
>> -	conf =3D find_confirmed_client(&dc->clientid, true, nn);
>> +	conf =3D find_confirmed_client(&dc->clientid, true, nn, NULL);
>> 	WARN_ON_ONCE(conf && unconf);
>>=20
>> 	if (conf) {
>> @@ -4012,12 +4111,18 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
>> 	struct nfs4_client	*unconf =3D NULL;
>> 	__be32 			status;
>> 	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	bool courtesy_clnt =3D false;
>> +	struct nfs4_client *cclient =3D NULL;
>>=20
>> 	new =3D create_client(clname, rqstp, &clverifier);
>> 	if (new =3D=3D NULL)
>> 		return nfserr_jukebox;
>> 	spin_lock(&nn->client_lock);
>> -	conf =3D find_confirmed_client_by_name(&clname, nn);
>> +	conf =3D find_confirmed_client_by_name(&clname, nn, &courtesy_clnt);
>> +	if (conf && courtesy_clnt) {
>> +		cclient =3D conf;
>> +		conf =3D NULL;
>> +	}
>> 	if (conf && client_has_state(conf)) {
>> 		status =3D nfserr_clid_inuse;
>> 		if (clp_used_exchangeid(conf))
>> @@ -4048,7 +4153,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
>> 	new =3D NULL;
>> 	status =3D nfs_ok;
>> out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>> 	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>> 	if (new)
>> 		free_client(new);
>> 	if (unconf) {
>> @@ -4076,8 +4185,9 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>> 		return nfserr_stale_clientid;
>>=20
>> 	spin_lock(&nn->client_lock);
>> -	conf =3D find_confirmed_client(clid, false, nn);
>> +	conf =3D find_confirmed_client(clid, false, nn, NULL);
>> 	unconf =3D find_unconfirmed_client(clid, false, nn);
>> +
>> 	/*
>> 	 * We try hard to give out unique clientid's, so if we get an
>> 	 * attempt to confirm the same clientid with a different cred,
>> @@ -4107,7 +4217,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>> 		unhash_client_locked(old);
>> 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
>> 	} else {
>> -		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
>> 		if (old) {
>> 			status =3D nfserr_clid_inuse;
>> 			if (client_has_state(old)
>> @@ -4691,18 +4801,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>> 	return ret;
>> }
>>=20
>> +/*
>> + * Function returns true if lease conflict was resolved
>> + * else returns false.
>> + */
>> static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>> {
>> 	struct nfs4_delegation *dl =3D fl->fl_owner;
>> 	struct svc_rqst *rqst;
>> 	struct nfs4_client *clp;
>>=20
>> +	clp =3D dl->dl_stid.sc_client;
>> +
>> +	/*
>> +	 * need to sync with courtesy client trying to reconnect using
>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>> +	 * function is called with the fl_lck held.
>> +	 */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +
>> 	if (!i_am_nfsd())
>> -		return NULL;
>> +		return false;
>> 	rqst =3D kthread_data(current);
>> 	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
>> 	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
>> -		return NULL;
>> +		return false;
>> 	clp =3D *(rqst->rq_lease_breaker);
>> 	return dl->dl_stid.sc_client =3D=3D clp;
>> }
>> @@ -4735,12 +4868,12 @@ static __be32 nfsd4_check_seqid(struct nfsd4_com=
pound_state *cstate, struct nfs4
>> }
>>=20
>> static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessio=
ns,
>> -						struct nfsd_net *nn)
>> +			struct nfsd_net *nn, bool *courtesy_clnt)
>> {
>> 	struct nfs4_client *found;
>>=20
>> 	spin_lock(&nn->client_lock);
>> -	found =3D find_confirmed_client(clid, sessions, nn);
>> +	found =3D find_confirmed_client(clid, sessions, nn, courtesy_clnt);
>> 	if (found)
>> 		atomic_inc(&found->cl_rpc_users);
>> 	spin_unlock(&nn->client_lock);
>> @@ -4751,6 +4884,8 @@ static __be32 set_client(clientid_t *clid,
>> 		struct nfsd4_compound_state *cstate,
>> 		struct nfsd_net *nn)
>> {
>> +	bool courtesy_clnt;
>> +
>> 	if (cstate->clp) {
>> 		if (!same_clid(&cstate->clp->cl_clientid, clid))
>> 			return nfserr_stale_clientid;
>> @@ -4762,9 +4897,12 @@ static __be32 set_client(clientid_t *clid,
>> 	 * We're in the 4.0 case (otherwise the SEQUENCE op would have
>> 	 * set cstate->clp), so session =3D false:
>> 	 */
>> -	cstate->clp =3D lookup_clientid(clid, false, nn);
>> +	cstate->clp =3D lookup_clientid(clid, false, nn, &courtesy_clnt);
>> 	if (!cstate->clp)
>> 		return nfserr_expired;
>> +
>> +	if (courtesy_clnt)
>> +		nfsd4_client_record_create(cstate->clp);
>> 	return nfs_ok;
>> }
>>=20
>> @@ -4917,9 +5055,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc=
_fh *fh,
>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>> }
>>=20
>> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_fil=
e *fp,
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * This function is called to check whether nfserr_share_denied should
>> + * be returning to client.
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved=
.
>> + */
>> +static bool
>> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *cl;
>> +	bool conflict =3D false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st =3D=3D stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +
>> +		/* need to sync with courtesy client trying to reconnect */
>> +		cl =3D st->st_stid.sc_client;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict not caused by courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
>> +		conflict =3D true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>> +static __be32
>> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>> {
>> 	struct nfsd_file *nf =3D NULL;
>> 	__be32 status;
>> @@ -4935,15 +5153,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst =
*rqstp, struct nfs4_file *fp,
>> 	 */
>> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status !=3D nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status !=3D nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
>>=20
>> 	/* set access to the file */
>> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status !=3D nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status !=3D nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
>>=20
>> 	/* Set access bits in stateid */
>> @@ -4994,7 +5226,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct n=
fs4_file *fp, struct svc_fh *c
>> 	unsigned char old_deny_bmap =3D stp->st_deny_bmap;
>>=20
>> 	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>=20
>> 	/* test and set deny mode */
>> 	spin_lock(&fp->fi_lock);
>> @@ -5343,7 +5575,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct=
 svc_fh *current_fh, struct nf
>> 			goto out;
>> 		}
>> 	} else {
>> -		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>> 		if (status) {
>> 			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
>> 			release_open_stateid(stp);
>> @@ -5577,6 +5809,122 @@ static void nfsd4_ssc_expire_umount(struct nfsd_=
net *nn)
>> }
>> #endif
>>=20
>> +static bool
>> +nfs4_anylock_blocker(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +	struct inode *ino;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
>> +		/* scan each lock owner */
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +
>> +			/* scan lock states of this lock owner */
>> +			lo =3D lockowner(so);
>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>> +					st_perstateowner) {
>> +				nf =3D stp->st_stid.sc_file;
>> +				ino =3D nf->fi_inode;
>> +				ctx =3D ino->i_flctx;
>> +				if (!ctx)
>> +					continue;
>> +				/* check each lock belongs to this lock state */
>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +					if (fl->fl_owner !=3D lo)
>> +						continue;
>> +					if (!list_empty(&fl->fl_blocked_requests)) {
>> +						spin_unlock(&clp->cl_lock);
>> +						return true;
>> +					}
>> +				}
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplis=
t,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +
>> +		/* client expired */
>> +		if (!client_has_state(clp)) {
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +
>> +		/* expired client has state */
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +			goto exp_client;
>> +
>> +		cour =3D test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +		if (cour &&
>> +			ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
>> +			goto exp_client;
>> +
>> +		if (nfs4_anylock_blocker(clp)) {
>> +			/* expired client has state and has blocker. */
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		/*
>> +		 * Client expired and has state and has no blockers.
>> +		 * If there is race condition with blockers, next time
>> +		 * the laundromat runs it will catch it and expires
>> +		 * the client. Client is expected to retry on lock or
>> +		 * lease conflict.
>=20
>=20
> I'm not sure what's meant by this last sentence. If the client is
> reclaiming and there is a lock conflict then you usually don't want to
> blindly retry to get the lock.
>=20
>> +		 */
>> +		if (!cour) {
>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			clp->courtesy_client_expiry =3D ktime_get_boottime_seconds() +
>> +					NFSD_COURTESY_CLIENT_EXPIRY;
>> +			list_add(&clp->cl_cs_list, &cslist);
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +
>> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
>> +			!test_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		nfsd4_client_record_remove(clp);
>> +	}
>> +}
>> +
>> static time64_t
>> nfs4_laundromat(struct nfsd_net *nn)
>> {
>> @@ -5610,16 +5958,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	}
>> 	spin_unlock(&nn->s2s_cp_lock);
>>=20
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>> 	list_for_each_safe(pos, next, &reaplist) {
>> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -5998,7 +6337,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn=
, stateid_t *st,
>> 	cps->cpntf_time =3D ktime_get_boottime_seconds();
>>=20
>> 	status =3D nfserr_expired;
>> -	found =3D lookup_clientid(&cps->cp_p_clid, true, nn);
>> +	found =3D lookup_clientid(&cps->cp_p_clid, true, nn, NULL);
>> 	if (!found)
>> 		goto out;
>>=20
>> @@ -6501,6 +6840,43 @@ nfs4_transform_lock_offset(struct file_lock *lock=
)
>> 		lock->fl_end =3D OFFSET_MAX;
>> }
>>=20
>> +/**
>> + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %true: real conflict, lock conflict can not be resolved.
>> + *   %false: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_fl_lock_conflict(struct file_lock *fl)
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc =3D true;
>> +
>> +	if (!fl)
>> +		return true;
>> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp =3D lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +		rc =3D false;
>> +	else {
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			rc =3D  false;
>> +		} else
>> +			rc =3D  true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>> static fl_owner_t
>> nfsd4_fl_get_owner(fl_owner_t owner)
>> {
>> @@ -6548,6 +6924,7 @@ static const struct lock_manager_operations nfsd_p=
osix_mng_ops  =3D {
>> 	.lm_notify =3D nfsd4_lm_notify,
>> 	.lm_get_owner =3D nfsd4_fl_get_owner,
>> 	.lm_put_owner =3D nfsd4_fl_put_owner,
>> +	.lm_lock_conflict =3D nfsd4_fl_lock_conflict,
>> };
>>=20
>> static inline void
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 498e5a489826..bffc83938eac 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>=20
>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_EXPIRY	(24 * 60 * 60)	/* seconds */
>=20
> I wonder if we ought to consider making this tunable?

My general preference is to avoid adding tunables.


> One day seems fine for most current use cases, but this work makes it
> more feasible to use NFSv4 on something like a laptop. Currently when
> you lose state then you hit all sorts of problems if you have things
> like locks, so I usually don't bother trying to use long-term NFS mounts
> on a laptop, as I might suspend it for days at a time.
>=20
> Now though, assuming that the host is working in its own area with no
> conflicts, you could suspend a laptop for a long time and not worry
> about hitting those sorts of issues.

The purpose of this limit is to prevent the server from running
out of space over time.

I was thinking a better approach might be to set up a shrinker
to deal with this situation. But that is something that can be
done down the road.


>> /*
>>  * The following attributes are currently not supported by the NFSv4 ser=
ver:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e73bdbb1634a..a0baa6581f57 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,8 @@ struct nfs4_client {
>> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>> 					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
>> 	unsigned long		cl_flags;
>> 	const struct cred	*cl_cb_cred;
>> 	struct rpc_clnt		*cl_cb_client;
>> @@ -385,6 +387,10 @@ struct nfs4_client {
>> 	struct list_head	async_copies;	/* list of async copies */
>> 	spinlock_t		async_lock;	/* lock for async copies */
>> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
>> +	bool			cl_cs_client;
>> +	spinlock_t		cl_cs_lock;
>> +	struct list_head	cl_cs_list;
>> };
>>=20
>> /* struct nfs4_client_reset
>=20
> Nice work!
>=20
> Acked-by: Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



