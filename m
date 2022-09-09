Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD35B3B37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiIIOzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiIIOzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:55:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D246179A52;
        Fri,  9 Sep 2022 07:55:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289E0NCs017767;
        Fri, 9 Sep 2022 14:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3XBPztA9Fym5YLdmafA8BsJ9Ur0fRTewongR8H4fSjo=;
 b=qzfMUIYDicvIHkTRV5I8Psza4nhE5nRQ84/6cWH2E7RRqWIXueBAHQvlLQbABEbGn4s9
 mn84gmhVhMGxdUa22Au+PbdDpWDxsWndDQenlfbY9ASViKKJNhjV4vPnXbLeSvpqYGn2
 W1NuluMmlJHAn5acMTLr1k/E3F04IRcM7BWh7/QJJ0KKVj5RKIsLvEK1tCUXdzf9Qlva
 fAeLaJUtvRSFLO5mMFfTE2p8AEjD+ak7i8JY5i97uGMLxN1Ddlz4cURt3PQOoDsS4NE9
 n+Scnhb7olhEhdXRL6a5Tq+t75/GdNpYR0yTx18KU6peyfBo6eld6qlM0iZvqrq5LTPB wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1qjjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 14:53:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289DfsLY005862;
        Fri, 9 Sep 2022 14:53:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcedn6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 14:53:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlWDZDuL2R1v8Q4Vgeg3ZE3a4MvplN8Lj75JLDxSVhkiplV1V38YmulvxzJJEFAe18/4BBVOxf5gnBky4lZnIT8YA8jAuELc8by8dvC9JPxYyMXa95M2rhhgnMQ6AS6XGSoqjiz7o40X2jvtaBpGzPM2d+dGkEAoGwPNpEVTXsL6O2yEBQZmB26kLqGMmViFVbCCRLJhwSuOc+f/pXAPvcNuLKE5mb0vijuQ0/i0y+zkrtyl6ugwKA5LIhF/jINVF3+tdkGfuEnbNAyQHubyhkMFL8cj/WFnt2o4VcnNMfwkFFGLy2aeKlIjh4h2bm77yR53APGac73DX3ZK0sm3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XBPztA9Fym5YLdmafA8BsJ9Ur0fRTewongR8H4fSjo=;
 b=KPy0hZ/KWA9Wt2VJqF2dvxybo4f27B7C85Wv0fYnOMEQVeruGUeK3HyeHJzXbgOu6NmmIyxwkVzJamc2zFmKmtZDUq+UJAH45/mh5mf27a9k0Vd5L89I56/TfUh1qZau/bj4DMnfZdDNv7/Jf+GJGikrgCS8e6Scao0CoZNOWCfBTXXkVHtlfm1Sx84F0QmUMUgnSL8qmTzOM84Dff4BnA27b6ILFA6m9Bx9EpHuqG1H6ff562xtdK4nNNsXCyqNLyINGRzQPCTjxQ68WanVsuS0HcNLD1fUh6vSPqO49JoFaazjJTvuRdCBNXLBCMJM8yShUhJkAfYbuQruXE8d8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XBPztA9Fym5YLdmafA8BsJ9Ur0fRTewongR8H4fSjo=;
 b=gMa5md3WejeWgswZQCB5Toh72dO4bMzkmO4BliJMlw0X3lQIxISVwdMga1EqF8Y00gQ3sSbdREjGzVqWrZ57I3uiFxPYwM7OdXVLdIXooC86foLTq7Cd0NBCHhvMGoI/IjdJoiUIZZ9wYgzZ0v8o3O7d+dmTpo0P/imkkeNp3jU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 14:53:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 14:53:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Theodore Ts'o <tytso@mit.edu>, battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Does NFS support Linux Capabilities
Thread-Topic: Does NFS support Linux Capabilities
Thread-Index: AQHYw36p6D3ymO0jXE6pVWwFMO2Oyq3V+t+AgADZ3ACAAEBOgIAAG/CA
Date:   Fri, 9 Sep 2022 14:53:55 +0000
Message-ID: <2A4AED07-2D8C-420C-9203-A2ABE9EA81E2@oracle.com>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com> <YxsGIoFlKkpQdSDY@mit.edu>
 <20220909131355.GA5674@fieldses.org>
In-Reply-To: <20220909131355.GA5674@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4334:EE_
x-ms-office365-filtering-correlation-id: d6f96510-14ea-4d77-4136-08da92731e9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0MAIXNBFPl6DXDrQ4+D1WvFFiTCcukGkQmnhejlfET9DEr23ovUjJJOVlJQ+6Pl3h6qcDK7k8G3ENL50uYtE8G2jiSJPKZA4rFg9LySmMm2wzF7QxTa9/2gyyMo7bOWSwiOgMK3D2xN72l9IYSuLNJLq4IlRF52q813AV4LOO3137wOfZaHYBBGVLvRTbhy+Up6vP3inaT/Ix6D+8XGkVYPRlVjWpDK+3K8Q2ssZcA/4sow6KwPTbrYRHMFBcZBY1X0jqDwYyJ+aL6a9L6Qt9UAVfs3g2kQO6/iCQcV4EYvf2AjTOwxR0KGiTb5BXtfrBlyln7q0vfw3R9TW8EDNyAZOGwMzay2Q4i3qQcOg0VqRU3xnymajxIiO3OYF30C2o1yLsZx+TeWKj3el0NyvJKWsnBqAbZOnazxhKDBCpHr5TglYkVSc7CXfnbhkX6mD1FooJo+7DS6uSYRPKcEvXtmXMgOuc08MOMAeCehZcurarqBppa0ugEyIIc9/fk9N4PPvQzmM42tOtUGK0L6ghQu1T6Y00tAY6R4Av9MXJsSfH2c8x8aLnBzhvXR1G2fFDxBmWTGbXUsXIXviCJDGcyK9L73oHDwyhn6jB09fnognkkLTQc9D3R9DpqtoTSQlmeOCrm8AiE1D3/JTcavARqFiGVYK0vtuEOzQlzZludKPJ24fdt81G//V+hYGeQpey+YX9Sw9dWxXXIQAX3vBRzKC3WoULgTPIsAM0fB2GNJCpW97wYyfZBI5CcPGinHLrFSeOiW4yLPmLPyp3nCV/CAQdk7hwaV3n6aGZB7gko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(366004)(376002)(136003)(53546011)(6506007)(26005)(6512007)(71200400001)(41300700001)(33656002)(6486002)(38070700005)(478600001)(36756003)(2616005)(38100700002)(186003)(122000001)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(8676002)(4326008)(91956017)(6916009)(316002)(54906003)(5660300002)(2906002)(8936002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v9W6GYbILKYJXD/+4M1nY/eDkr+Pl2WMx+/llh1p6JYU0KKIzhbIe27Fv+Xm?=
 =?us-ascii?Q?wWnDsg9BCdJbwsGHPytNnCbCNOMV33JRMzFJ1CfK3bR8UU8JH9baNKGI2w7S?=
 =?us-ascii?Q?32lC0m3Fqv0J2wlVWYOooShni+T/wHLVW74hH4YrDe6jJJXOqMp6KyB+Br4p?=
 =?us-ascii?Q?CbOrlKDk2naGlDY36Gma/IpcgHZC8liAgQR3RdSB3a7WupDiq5RMOlhWwvGN?=
 =?us-ascii?Q?HgHh4QQeeZYQak15rCL32VZpbI0m8LhqcPVFr4sN/iBvYtDpLsJuyIbArX8B?=
 =?us-ascii?Q?UNNMbqyrJndz4hFxsQ9jlUsFLZK2CkvovJ3mkWXIjJuKdzHrcPx0grYnguoj?=
 =?us-ascii?Q?pF2e/4AXdRiEZmMFbKmtFpYJNyHQcemXRp+diYtUEAzDgCxD9aCQNkhY+ncl?=
 =?us-ascii?Q?oDd5qQmKytaSiJtctpsP6RO3IK9u8lKU0TQ+Rnh2t/MacHABffMz7cya5LHi?=
 =?us-ascii?Q?x55QN5dbmkMVi8KV6n8X2B8wpg1EvhgMe+cDnrdoNWoIR7bM/c9ST2SnOaUX?=
 =?us-ascii?Q?TrRRMK9AWixNCqwXRpMkm5BCUDI1x3Tqj7vwRd0rNrFt9f4RZR76cf/h1iSe?=
 =?us-ascii?Q?jMqfilMitxBfk2WYDeGdF+UL5RYDxOhwd/P88xCaDxpXk5vydIWWo0SR6heJ?=
 =?us-ascii?Q?k5IrG1EOvMLx+QTmYsLU07JrqqNRX15+BttyhAuRwt9x8CWAebft3w33pdwH?=
 =?us-ascii?Q?NhUxarz+stVuj0U92ZQ1ZjkhnxDNbgAdswF4IDip8U667StizSJkhrjh20hq?=
 =?us-ascii?Q?hsk9tAqUT8CdX2KXCh0J2h3qTltxF0L8lA1pBJ+IX9+3scv7Xt8OEK/KNy7T?=
 =?us-ascii?Q?T3FJee6lxfctmF01oxJVvQxb9JHnCgBB2Khu/gpHhQewTq2tSom/2e5/9Wzy?=
 =?us-ascii?Q?qhJA+HLE8eqkP8xFkVHXP3DuhfKncILOVdW8xGA0Q2K08Mn6huihDVRvOFz9?=
 =?us-ascii?Q?KH5wF5zr1uaGp7ZTe/jQbTAiT1inEOXASOu/YsWrlRe2JHj/AJ74lpKf8RnK?=
 =?us-ascii?Q?JI1juW1ftiHbA+rVmL3wDVV2XEyyAOvPkOkdHeHeI2b6Hu7H7ZZBJQDlICls?=
 =?us-ascii?Q?7KELfQjN0vgBiUSaS091PudLJH3CUy6u6TYMs023cJCttr/8uoOnelz62zBq?=
 =?us-ascii?Q?JKGBrIenmi4B6O1G6Aq8rAj8M1807Tpz2HMU0IHAvfF29CcwZTcklEEKCjdV?=
 =?us-ascii?Q?Gwoe/eLM65XrirOVgazipJpL4N8kjzvZkOFoNSSD3ySGIkKvENxFrSqZYrFy?=
 =?us-ascii?Q?fCv2AhcpV+ZpgldQZ0RY7OUt26Z7mzV+aqigBDcbmS9JUXd5inhDF1m8q8YA?=
 =?us-ascii?Q?h9tyPNqSFV1pglPHeWos9mc5LSAt83K2K866k1QS7kLOknXxp2CSYEAcKqgf?=
 =?us-ascii?Q?BhnXnSdN4il9d8ddPrcDVLXO20UjsWLKmXsXK0ALkLDvSBlOYZdkDwjL5JXT?=
 =?us-ascii?Q?K2rVvkLo2kTuhiSfHxr4IO6OCskMdRQVpU+Fu3cHiwkY5jo/S1l/OZ3BdHVS?=
 =?us-ascii?Q?mccRY1VceONrfV4KnBNrDQPCK85OSF2xCdntLDQktmuQBvDoyhWay5LjKywH?=
 =?us-ascii?Q?QStoFAOPKVDB+i8zptkan1hiWKPJ7rRtz6k17hUdD/XRRVARoiNpa0bVnP4T?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5473F61FA5B6FC4E85A6A9F8EAA3FB3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f96510-14ea-4d77-4136-08da92731e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:53:55.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6SDel5TPt9gpzEw18z4NvQuthgbtdLgwXHDycHZzFA1wYLWe/e16bc0/MfdTS619rqCRCivf+ZJWNNoeLNcTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090052
X-Proofpoint-GUID: BEY5naz8geP6eV-DOmS6-SNiS3ymcWoo
X-Proofpoint-ORIG-GUID: BEY5naz8geP6eV-DOmS6-SNiS3ymcWoo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 9, 2022, at 9:13 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Fri, Sep 09, 2022 at 05:23:46AM -0400, Theodore Ts'o wrote:
>> On Thu, Sep 08, 2022 at 08:24:02PM +0000, Chuck Lever III wrote:
>>> Given these enormous challenges, who would be willing to pay for
>>> standardization and implementation? I'm not saying it can't or
>>> shouldn't be done, just that it would be a mighty heavy lift.
>>> But maybe other folks on the Cc: list have ideas that could
>>> make this easier than I believe it to be.
>>=20
>> ... and this is why the C2 by '92 initiative was doomed to failure,
>> and why Posix.1e never completed the standardization process.  :-)
>>=20
>> Honestly, capabilities are super coarse-grained, and I'm not sure they
>> are all that useful if we were create blank slate requirements for a
>> modern high-security system.  So I'm not convinced the costs are
>> sufficient to balance the benefits.
>=20
> I seem to recall the immediate practical problem people have hit is that
> some rpms will fail if it can't set file capabilities.

Indeed, that is the most common reason for a request to implement
capabilities for NFS files.


> So in practice NFS may not work any more for root filesystems.

"may not work any more" -- well let's be precise. NFS works for root,
but doesn't support distributions that require file capabilities on
certain executables. Thus it cannot be used in those cases.


> Maybe there's some workaround.

The workaround I'm familiar with is to use a local filesystem that
implements extended attributes, but store it on network-attached
block storage (eg iSCSI).


> Taking a quick look at my laptop, there's not as many as I expected:
>=20
> [root@parkour bfields]# getcap -r /usr
> /usr/bin/arping cap_net_raw=3Dp
> /usr/bin/clockdiff cap_net_raw=3Dp
> /usr/bin/dumpcap cap_net_admin,cap_net_raw=3Dep
> /usr/bin/newgidmap cap_setgid=3Dep
> /usr/bin/newuidmap cap_setuid=3Dep
> /usr/sbin/mtr-packet cap_net_raw=3Dep
> /usr/sbin/suexec cap_setgid,cap_setuid=3Dep

Yep, it's still a short list.


--
Chuck Lever



