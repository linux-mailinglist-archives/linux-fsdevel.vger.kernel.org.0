Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1D4B772B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiBORRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 12:17:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiBORRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:17:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426AD6394;
        Tue, 15 Feb 2022 09:17:28 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FH3vUO026647;
        Tue, 15 Feb 2022 17:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3TMb60UD1czL8CKS0wtp2PouhYLyMra4tG71r70TAZE=;
 b=eyehmBOWBR4tKsi5buk01TkVnF7IWxcLsOGXpuP6ICP5BNJp3z3HfsAa1FVVqmakBt8V
 QF7uGLTl6YrjgpeE1KOrNwNMgBQx1w9ePxelfav2M5p+h078aSwaXeOHn0R8ek0KbtTh
 0qcDj7hrDXylMlXnDm8XrsGfpHaWnKUbsd7SaSIpcxnrvxfRuZE66epZQpKELtqWLH5t
 jh3wdKvJLYNrt3ewmgjvMWJZ4NjyspGCsITI6Ie8vFrwYvcHTez19fpywj8RY7uJBG2j
 gBr7OsMmnmksp7o6QNMHSqSyQKEdfBSuSX1APR3vODuJutSTbcjnp9FbKC7UBI0rBIIH QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0j297-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 17:17:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FH64KN061438;
        Tue, 15 Feb 2022 17:17:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3e6qkyhx0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 17:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zeq/dquriaudH+anpxQPVbjvDLUf/EDsjCl2t5i9+Gb/0UiD35Ro/JLROcddKairEN+m8jtlzrFQAuHrHtIVeDHvTCnue0FD4yWnQWjmWZOflbIeBffbaUULBKJlGvazx7zcge5ZMHCrOmW+9qtcVzTWJABJWbZy9GY2mSlMunukqC+GW7Ga5xVViclxNubQA0rqYbEMlGY6flFG5127GiIp+/8+sD5NbYtZU0/Kyz2XtIL4p9HkIzA7hcd+L4uomOeMSSQMUVh0Eej68rvXNJxVVeUiMPvgMkWvKewT0Pkt7IxO0St42U4MUqJfcs69s1u2875yhZWanXLraXiT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TMb60UD1czL8CKS0wtp2PouhYLyMra4tG71r70TAZE=;
 b=LUV/zQkvojJOUcptyccVekULqYH593D06E7kBMZTsjYMu3+2wcZphAq0mTXy0U9u3b9Q7VYo31xGgqX207NmKi24u9O7wz94bAnpifIl4bGHYDgwms4YrqvFJYMJew0VE1sa24xlDb7yruFaliInlwfMOKBqPraoPapSTCmqMfutIe5mJ9gllQ+k9Ih/160EU8vQ7H4imyeaTs6gxJoYSbV1hnzrOk+cfvSyVp4quC5HicFfplG//dwhtDQ3RGZSydsDx4EN6wnXLw0G3YkUr1vVDc/sWWrNK/WbWLHIahrFtWZmfVsBDHsadDYJm4gnZUWS+37GndTn9zzFnTlQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TMb60UD1czL8CKS0wtp2PouhYLyMra4tG71r70TAZE=;
 b=NF4TX3x9QCVSvbUcZLK8K2GJTW3XLUGQkUF+2lZpAvAcBVhe1xSOBOBs9jZXHAV9vgsqsGDUjZdWXAMTSEd6w+AOZLYRYwejVDpUg2588lLFJ6akTpfa3n/hPomdagCxl9JthMYA00imaafHn9htu1L5rfByuPXDCaOqXLyyFus=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3121.namprd10.prod.outlook.com (2603:10b6:408:c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 17:17:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 17:17:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYIDwrUbH4vFbDYkeTHocB/S7pFqyU304A
Date:   Tue, 15 Feb 2022 17:17:20 +0000
Message-ID: <FFA33A13-D423-4B15-B8D4-FFDF88CFF9BE@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
 <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b84532d4-2270-4c6d-2942-08d9f0a7069e
x-ms-traffictypediagnostic: BN8PR10MB3121:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3121981E47B27BCCEA7D6B0593349@BN8PR10MB3121.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b8hGMovb+WNEsf76aFJZkHqSpeH3Wrad1MxR5dh2moqLlibfWk5JSrz6XI5F+hkP0VPUqtaQ/PMgWECKHt3bt050mmFz7+xVeubPcLqQCA1RApBu4OAwEfgZwe9nNI2JGlQTH+y3iUnJT3rba+orofP1up57arRSF1lPhgt1cBNLcsgWA9df9SdFuVCzW5dWtAwUqYxaF6xPh6v7jhapefjaVcJdQySNe1XQa8sOUAtxQEb6spc1yuTnE0e0xI4lo0zjIVnGfVsB9qnVj2b2M+6zmk49QO3B10H0XPJcaxKexawUfT81cpOZXwuD/UdTP4S+KXxWGdRfKX6M3Bv3JFSPNiukAk9viJdZFpzkTQvkuVbKNeoyCqXIOCIbfwKiL8yCmeikIsHqwPvMPFCjo4hpsjlcB3RlbWhoFitH+SBqYCe7CZhRvjJ9btTXk7XKO+tQwtL+m53HUz1gQPxyrd024Av+yKJHBMqpDMpxXKvVB6F6nw8if6ykmQLe1660TlGfw1TLiLkAUJ/xNAepVw49BEqxuKemE4RrIfNIAl7Xq1tsmLMw2VMzjJ5KYYqNXzkxQ98VlVLmPMUEMsa8O0I46s+dTg8o7ILcsdAxMA36Uf+NrGDt9c4ndfKuuSqfsLCF20KYWXIhMaBZRN5my8ZZKxrzlN9E8tpM9/ojgaZ7y4BLPQy+jFdN/cBPtOBtdqs5U3MGq3dvht65SeLhcwCo3xW7kxuf09HcPpGgCF5ceiyBwT+7PWJtwcOOpZeOf1xMH/1CvVCHYTGa+vGw4mMYHfcATcfEDzY+zh/bKzse5AYzHyz3NMGU22bXqkLKwn3eiMa5qwNtyaH6qDfUTEWkHHILVkvofDYlZaqffI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(37006003)(54906003)(6636002)(33656002)(966005)(6512007)(6486002)(6506007)(71200400001)(83380400001)(2616005)(186003)(53546011)(26005)(5660300002)(91956017)(2906002)(36756003)(4326008)(122000001)(30864003)(8936002)(38070700005)(6862004)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(38100700002)(76116006)(8676002)(45980500001)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G744bkSyd+eRIfxm4ng8rFAlEx49sQLwzJv3FOks+lDFq2lEAmQto0Xgz1pi?=
 =?us-ascii?Q?GOcqDSy2AhB6djI3agcuBE+3vq58d0AAHo4GjqB1aTSsPs/iV1XLSl19y6u/?=
 =?us-ascii?Q?OFcOsyMUqkV7vOSt2qN/nW+5QFVVTW1hVvSzDyYf4tdbj/Z/IxiqORdGNgEe?=
 =?us-ascii?Q?4FQE/QQluvTooplw4q225NCsYn8JtBBeTFvpuGykBCkbpr6H823kRrriD9Yb?=
 =?us-ascii?Q?/zGXKTkv2ZNKhKJRpLo5uSBiCemHztsBFF7E+sLlarK80sGqxJLfuKX0LQwd?=
 =?us-ascii?Q?SxNxrBSVdfnGNqY+gWRtBVfDKb1sJrkEh8XB/gta9hMVIN5tWWaK2iw8f/9p?=
 =?us-ascii?Q?rwXlsWho+hJx/JG7p+3T5LpgnfkKhStlDEJYdSyv/2qrpnqbgdUsbF/ZsYAF?=
 =?us-ascii?Q?1+iypuT18PKMhx7NCma+je5jhKU8n0WswIU2bF6dqfWgQd4XhXkSxxFTR6Ed?=
 =?us-ascii?Q?MDK20e4RDX1WauCCZhLMOe7U1F+VAmtJ0z9tpl3n9SxE6Xw96k0yI4t/WMk9?=
 =?us-ascii?Q?PDGpTPYD+o0208El0i1LSTKZxQXX4aW+wcMg0rwFryitHp2YYSLddAKnj6SF?=
 =?us-ascii?Q?8bcZmmIaiXvoRSI4ojV8dDLQaMkVSWDJNh/ZzWr13JVSdH3rpqkmKK5kNE+w?=
 =?us-ascii?Q?jw8aRIjtQgtsU9oOkN8X8MsZMI8cy30E44he+K3uDYCUsqHs60qjfX7VpiC0?=
 =?us-ascii?Q?mCUtUVDhRf6PlnTjjlEAj42PjR6s5IVrTmfClIjSHfHckS2YA9GFmTEcqKFW?=
 =?us-ascii?Q?EJZkalOPBDWHYvMQNNrGLY8sUQpzP7qhpKMIWX+6rQ1n/yIybBAWxlDl+qQU?=
 =?us-ascii?Q?4pgkAhxS2o0WLfcUniyIVgicWH/0JtK5u/BcInl2x2FH47XZ39exrCvgAJkE?=
 =?us-ascii?Q?roWhI16Q1zPCFlKTX7Q5yR+lcrCb8IkPa2XBfaUUu1g/4y7+mkNcPC2wYZuX?=
 =?us-ascii?Q?Cb0sMu+MFwEsjkNVa8PGabQgJXtzBw49ELLiGTG0yLSjfgi8iBbNOQdRSMVF?=
 =?us-ascii?Q?ROMJGCwQxw9rT5Za2Od30kvBXDf16yvRNIbIkjumnANNXzaCf2HP4LXBU+6U?=
 =?us-ascii?Q?5tIhTgIs/+pC+7kxKsFLu2bnrkhX7v3YemS9YveNDUgX2iUHBKytl1Lr0LaK?=
 =?us-ascii?Q?D1KFyZlcEsHsGFOkKrEV6486NFFAjEKkA3D7PcVGW0rXY/djNfozbmWY+jBx?=
 =?us-ascii?Q?5NOXkN9B3wKKqiaCOLtcFRpQVG2EcwFxbpN+UvywCDHw5bJLml/45KE1lTav?=
 =?us-ascii?Q?2kZRQsAPJxkmf7ETM+gY72eqO1M4yL/PoSFVI+Yvi9uYWTTcVLo+sRp067FZ?=
 =?us-ascii?Q?KwPKM1BL3w68WTGKvzFEN9fqmf0bRJtpnuVXlQtRcY2y4KKVynVKwkiUN4TX?=
 =?us-ascii?Q?vBBz3aBo/F54ChlWXM3qsnxGhtq5ip3KjxmMs4UFGFVZWkIIykIYIzqBq9dZ?=
 =?us-ascii?Q?rQSwvuhIMBBMv8GGfzC8CPJ9U3+cso6p023gjogJAukRDmSckKwQ3FX0rb4s?=
 =?us-ascii?Q?fNyEv6/MTcWCKE3Bv7ayA1zPfEQoK/OayPCZJWSkcTRfR9EmJMLINvsafc1s?=
 =?us-ascii?Q?VHJxeY7Vz8jQCZRNijtIwblAmW0AFIEc7rK1cAr3aSYT4SatiINv/x2rRD0B?=
 =?us-ascii?Q?pELaVo9eeLkNt+IO49D+pHE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DCBC14421203546A8C8DF1DDDC9F7CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84532d4-2270-4c6d-2942-08d9f0a7069e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:17:20.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEUOh90wbkTLuhXnDd3L9G7f1EyebNHxr4eBzOaKE4PS1DAdP/bPJKoHbjTJ5WJbrzjZdSgzkf8DKDv54Wfffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3121
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150100
X-Proofpoint-ORIG-GUID: b2FCXlRg4zdsxf_M4tVk2MduAzoW9e1a
X-Proofpoint-GUID: b2FCXlRg4zdsxf_M4tVk2MduAzoW9e1a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 12, 2022, at 1:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently an NFSv4 client must maintain its lease by using the at least
> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> a singleton SEQUENCE (4.1) at least once during each lease period. If the
> client fails to renew the lease, for any reason, the Linux server expunge=
s
> the state tokens immediately upon detection of the "failure to renew the
> lease" condition and begins returning NFS4ERR_EXPIRED if the client shoul=
d
> reconnect and attempt to use the (now) expired state.
>=20
> Problems such as hardware failures or administrative errors may cause
> network partitions longer than the NFSv4 lease period. Our server current=
ly
> removes all client state as soon as a client fails to renew.
>=20
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recogniz=
e
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
>=20
> The initial implementation of the Courteous Server will do the following:
>=20
> . When the laundromat thread detects an expired client and if that client
> still has established state on the Linux server and there is no waiters
> for the client's locks then deletes the client persistent record and mark=
s
> the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
> all of its state, otherwise destroys the client as usual.
>=20
> . Client persistent record is added to the client database when the
> courtesy client reconnects and transits to normal client.
>=20
> . Lock/delegation/share reversation conflict with courtesy client is
> resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
> effectively disable it, then allow the current request to proceed
> immediately.
>=20
> . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed =
to
> reconnect to reuse itsstate. It is expired by the laundromat asynchronous=
ly
> in the background.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 440 +++++++++++++++++++++++++++++++++++++++++++++++=
++---
> fs/nfsd/nfsd.h      |   1 +
> fs/nfsd/state.h     |   6 +
> 3 files changed, 424 insertions(+), 23 deletions(-)

Hi Dai-

I've applied the first three patches in this series for 5.18.
I also extracted a small fix from 4/4 that should be separate
and applied that too. When you resend, please rebase your
patch(es) on my public for-next branch.

I am still concerned about the increasing size of this patch
and its complexity in some areas. Generally we don't apply a
single large patch like this; the changes are broken down into
a series of much smaller updates. That makes review and later
debugging much easier for everyone.

Here's a rough example of how this /might/ be done:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dnf=
sd-courteous-server

Others might have different ideas of how to split this up.

I'm gaining more understanding of how this all works. The
sections dealing with share/deny access are still somewhat
outside my wheelhouse, so I'm depending on others (Jeff or
Bruce) to help out in those narrow areas. Breaking this
large patch into smaller ones will make it easier for them
to review this work surgically.

A few more comments below.


> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 32063733443d..b837ff97e097 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1935,10 +1935,33 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *=
sessionid, struct net *net,
> {
> 	struct nfsd4_session *session;
> 	__be32 status =3D nfserr_badsession;
> +	struct nfs4_client *clp;
>=20
> 	session =3D __find_in_sessionid_hashtbl(sessionid, net);
> 	if (!session)
> 		goto out;
> +	clp =3D session->se_client;
> +	if (clp) {
> +		clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> +		/* need to sync with thread resolving lock/deleg conflict */
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			session =3D NULL;
> +			goto out;
> +		}
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			/*
> +			 * clear CLIENT_COURTESY flag to prevent it from being
> +			 * destroyed by thread trying to resolve conflicts.
> +			 */
> +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);

I plan to come back to this in a subsequent review once
some of the lower-hanging fruit has been harvested.


> +
> +			/* let caller knows it's courtesy client */
> +			set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +	}
> 	status =3D nfsd4_get_session_locked(session);
> 	if (status)
> 		session =3D NULL;
> @@ -2008,6 +2031,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->cl_openowners);
> 	INIT_LIST_HEAD(&clp->cl_delegations);
> 	INIT_LIST_HEAD(&clp->cl_lru);
> +	INIT_LIST_HEAD(&clp->cl_cs_list);
> 	INIT_LIST_HEAD(&clp->cl_revoked);
> #ifdef CONFIG_NFSD_PNFS
> 	INIT_LIST_HEAD(&clp->cl_lo_states);
> @@ -2015,6 +2039,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->async_copies);
> 	spin_lock_init(&clp->async_lock);
> 	spin_lock_init(&clp->cl_lock);
> +	spin_lock_init(&clp->cl_cs_lock);
> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> 	return clp;
> err_no_hashtbl:
> @@ -2412,6 +2437,10 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 		seq_puts(m, "status: confirmed\n");
> 	else
> 		seq_puts(m, "status: unconfirmed\n");
> +	seq_printf(m, "courtesy client: %s\n",
> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
> +	seq_printf(m, "seconds from last renew: %lld\n",
> +		ktime_get_boottime_seconds() - clp->cl_time);
> 	seq_printf(m, "name: ");
> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> @@ -2832,8 +2861,22 @@ find_clp_in_name_tree(struct xdr_netobj *name, str=
uct rb_root *root)
> 			node =3D node->rb_left;
> 		else if (cmp < 0)
> 			node =3D node->rb_right;
> -		else
> +		else {
> +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> +			/* sync with thread resolving lock/deleg conflict */
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				return NULL;
> +			}
> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> 			return clp;
> +		}
> 	}
> 	return NULL;
> }
> @@ -2879,6 +2922,20 @@ find_client_in_id_table(struct list_head *tbl, cli=
entid_t *clid, bool sessions)
> 		if (same_clid(&clp->cl_clientid, clid)) {
> 			if ((bool)clp->cl_minorversion !=3D sessions)
> 				return NULL;
> +
> +			/* need to sync with thread resolving lock/deleg conflict */
> +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				continue;
> +			}
> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> 			renew_client_locked(clp);
> 			return clp;
> 		}
> @@ -3118,6 +3175,14 @@ static __be32 copy_impl_id(struct nfs4_client *clp=
,
> 	return 0;
> }
>=20
> +static void
> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
> +{
> +	spin_lock(&clp->cl_cs_lock);
> +	set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +	spin_unlock(&clp->cl_cs_lock);
> +}
> +
> __be32
> nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cs=
tate,
> 		union nfsd4_op_u *u)
> @@ -3195,6 +3260,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	/* Cases below refer to rfc 5661 section 18.35.4: */
> 	spin_lock(&nn->client_lock);
> 	conf =3D find_confirmed_client_by_name(&exid->clname, nn);
> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> +		nfsd4_discard_courtesy_clnt(conf);
> +		conf =3D NULL;
> +	}
> 	if (conf) {
> 		bool creds_match =3D same_creds(&conf->cl_cred, &rqstp->rq_cred);
> 		bool verfs_match =3D same_verf(&verf, &conf->cl_verifier);
> @@ -3462,6 +3531,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> 	spin_lock(&nn->client_lock);
> 	unconf =3D find_unconfirmed_client(&cr_ses->clientid, true, nn);
> 	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn);
> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> +		nfsd4_discard_courtesy_clnt(conf);
> +		conf =3D NULL;
> +	}

I'm seeing this bit of logic over and over again. I'm wondering
why "set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);" cannot
be done in the "find_confirmed_yada" functions? The "find" function
can even return NULL in that case, so changing all these call sites
should be totally unnecessary (except in a couple of cases where I
see there is additional logic at the call site).


> 	WARN_ON_ONCE(conf && unconf);
>=20
> 	if (conf) {
> @@ -3493,6 +3566,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> 			goto out_free_conn;
> 		}
> 		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
> +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &old->cl_flags)) {
> +			nfsd4_discard_courtesy_clnt(old);
> +			old =3D NULL;
> +		}
> 		if (old) {
> 			status =3D mark_client_expired_locked(old);
> 			if (status) {
> @@ -3631,6 +3708,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *=
rqstp,
> 	struct nfsd4_session *session;
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct nfs4_client *clp;
>=20
> 	if (!nfsd4_last_compound_op(rqstp))
> 		return nfserr_not_only_op;
> @@ -3663,6 +3741,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst =
*rqstp,
> 	nfsd4_init_conn(rqstp, conn, session);
> 	status =3D nfs_ok;
> out:
> +	clp =3D session->se_client;
> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
> +		if (status =3D=3D nfs_ok)
> +			nfsd4_client_record_create(clp);
> +		else
> +			nfsd4_discard_courtesy_clnt(clp);
> +	}
> 	nfsd4_put_session(session);
> out_no_session:
> 	return status;
> @@ -3685,6 +3770,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nf=
sd4_compound_state *cstate,
> 	int ref_held_by_me =3D 0;
> 	struct net *net =3D SVC_NET(r);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct nfs4_client *clp;
>=20
> 	status =3D nfserr_not_only_op;
> 	if (nfsd4_compound_in_session(cstate, sessionid)) {
> @@ -3697,6 +3783,13 @@ nfsd4_destroy_session(struct svc_rqst *r, struct n=
fsd4_compound_state *cstate,
> 	ses =3D find_in_sessionid_hashtbl(sessionid, net, &status);
> 	if (!ses)
> 		goto out_client_lock;
> +	clp =3D ses->se_client;
> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
> +		status =3D nfserr_badsession;
> +		nfsd4_discard_courtesy_clnt(clp);
> +		goto out_put_session;
> +	}
> +
> 	status =3D nfserr_wrong_cred;
> 	if (!nfsd4_mach_creds_match(ses->se_client, r))
> 		goto out_put_session;
> @@ -3801,7 +3894,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct nfsd4_session *session;
> -	struct nfs4_client *clp;
> +	struct nfs4_client *clp =3D NULL;
> 	struct nfsd4_slot *slot;
> 	struct nfsd4_conn *conn;
> 	__be32 status;
> @@ -3911,6 +4004,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> 	if (conn)
> 		free_conn(conn);
> 	spin_unlock(&nn->client_lock);
> +	if (clp && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
> +		if (status =3D=3D nfs_ok)
> +			nfsd4_client_record_create(clp);
> +		else
> +			nfsd4_discard_courtesy_clnt(clp);
> +	}
> 	return status;
> out_put_session:
> 	nfsd4_put_session_locked(session);
> @@ -3947,6 +4046,10 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
> 	spin_lock(&nn->client_lock);
> 	unconf =3D find_unconfirmed_client(&dc->clientid, true, nn);
> 	conf =3D find_confirmed_client(&dc->clientid, true, nn);
> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> +		nfsd4_discard_courtesy_clnt(conf);
> +		conf =3D NULL;
> +	}
> 	WARN_ON_ONCE(conf && unconf);
>=20
> 	if (conf) {
> @@ -4030,12 +4133,17 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	struct nfs4_client	*unconf =3D NULL;
> 	__be32 			status;
> 	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfs4_client *cclient =3D NULL;
>=20
> 	new =3D create_client(clname, rqstp, &clverifier);
> 	if (new =3D=3D NULL)
> 		return nfserr_jukebox;
> 	spin_lock(&nn->client_lock);
> 	conf =3D find_confirmed_client_by_name(&clname, nn);
> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> +		cclient =3D conf;
> +		conf =3D NULL;
> +	}
> 	if (conf && client_has_state(conf)) {
> 		status =3D nfserr_clid_inuse;
> 		if (clp_used_exchangeid(conf))
> @@ -4066,7 +4174,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	new =3D NULL;
> 	status =3D nfs_ok;
> out:
> +	if (cclient)
> +		unhash_client_locked(cclient);
> 	spin_unlock(&nn->client_lock);
> +	if (cclient)
> +		expire_client(cclient);
> 	if (new)
> 		free_client(new);
> 	if (unconf) {
> @@ -4096,6 +4208,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 	spin_lock(&nn->client_lock);
> 	conf =3D find_confirmed_client(clid, false, nn);
> 	unconf =3D find_unconfirmed_client(clid, false, nn);
> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
> +		nfsd4_discard_courtesy_clnt(conf);
> +		conf =3D NULL;
> +	}
> 	/*
> 	 * We try hard to give out unique clientid's, so if we get an
> 	 * attempt to confirm the same clientid with a different cred,
> @@ -4126,6 +4242,11 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
> 	} else {
> 		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
> +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT,
> +						&old->cl_flags)) {
> +			nfsd4_discard_courtesy_clnt(old);
> +			old =3D NULL;
> +		}
> 		if (old) {
> 			status =3D nfserr_clid_inuse;
> 			if (client_has_state(old)
> @@ -4711,18 +4832,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	return ret;
> }
>=20
> +/*
> + * Function returns true if lease conflict was resolved
> + * else returns false.
> + */
> static bool nfsd_breaker_owns_lease(struct file_lock *fl)
> {
> 	struct nfs4_delegation *dl =3D fl->fl_owner;
> 	struct svc_rqst *rqst;
> 	struct nfs4_client *clp;
>=20
> +	clp =3D dl->dl_stid.sc_client;
> +
> +	/*
> +	 * need to sync with courtesy client trying to reconnect using
> +	 * the cl_cs_lock, nn->client_lock can not be used since this
> +	 * function is called with the fl_lck held.
> +	 */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +
> 	if (!i_am_nfsd())
> -		return NULL;
> +		return false;

As noted in my general comments, this change (and the one
right below) is a stand-alone fix that I've pulled into a
separate patch and already applied.


> 	rqst =3D kthread_data(current);
> 	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
> 	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> -		return NULL;
> +		return false;
> 	clp =3D *(rqst->rq_lease_breaker);
> 	return dl->dl_stid.sc_client =3D=3D clp;
> }
> @@ -4755,7 +4899,7 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compou=
nd_state *cstate, struct nfs4
> }
>=20
> static struct nfs4_client *lookup_clientid(clientid_t *clid, bool session=
s,
> -						struct nfsd_net *nn)
> +			struct nfsd_net *nn)
> {
> 	struct nfs4_client *found;
>=20
> @@ -4785,6 +4929,9 @@ static __be32 set_client(clientid_t *clid,
> 	cstate->clp =3D lookup_clientid(clid, false, nn);
> 	if (!cstate->clp)
> 		return nfserr_expired;
> +
> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &cstate->clp->cl_flags))
> +		nfsd4_client_record_create(cstate->clp);
> 	return nfs_ok;
> }
>=20
> @@ -4937,9 +5084,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_=
fh *fh,
> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> }
>=20
> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file=
 *fp,
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> +			(access & NFS4_SHARE_ACCESS_READ &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> +			(access & NFS4_SHARE_ACCESS_WRITE &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> +			return true;
> +		}
> +		return false;
> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * This function is called to check whether nfserr_share_denied should
> + * be returning to client.

Nit: The Linux kernel contributor's documentation recommends
that short explanations should be written in the imperative,
like so:

"Check whether nfserr_share_denied should be returned."


> + *
> + * access:  is op_share_access if share_access is true.
> + *	    Check if access mode, op_share_access, would conflict with
> + *	    the current deny mode of the file 'fp'.
> + * access:  is op_share_deny if share_access is false.
> + *	    Check if the deny mode, op_share_deny, would conflict with
> + *	    current access of the file 'fp'.
> + * stp:     skip checking this entry.
> + * new_stp: normal open, not open upgrade.
> + *
> + * Function returns:
> + *	true   - access/deny mode conflict with normal client.
> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_ol_stateid *st;
> +	struct nfs4_client *cl;
> +	bool conflict =3D false;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		if (st->st_openstp || (st =3D=3D stp && new_stp) ||
> +			(!nfs4_check_access_deny_bmap(st,
> +					access, share_access)))
> +			continue;
> +
> +		/* need to sync with courtesy client trying to reconnect */
> +		cl =3D st->st_stid.sc_client;
> +		spin_lock(&cl->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		/* conflict not caused by courtesy client */
> +		spin_unlock(&cl->cl_cs_lock);
> +		conflict =3D true;
> +		break;
> +	}
> +	return conflict;
> +}
> +
> +static __be32
> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
> {
> 	struct nfsd_file *nf =3D NULL;
> 	__be32 status;
> @@ -4955,15 +5182,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	 */
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_deny, false)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}
>=20
> 	/* set access to the file */
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_access, true)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}
>=20
> 	/* Set access bits in stateid */
> @@ -5014,7 +5255,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nf=
s4_file *fp, struct svc_fh *c
> 	unsigned char old_deny_bmap =3D stp->st_deny_bmap;
>=20
> 	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>=20
> 	/* test and set deny mode */
> 	spin_lock(&fp->fi_lock);
> @@ -5363,7 +5604,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 			goto out;
> 		}
> 	} else {
> -		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
> 		if (status) {
> 			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> 			release_open_stateid(stp);
> @@ -5597,6 +5838,121 @@ static void nfsd4_ssc_expire_umount(struct nfsd_n=
et *nn)
> }
> #endif
>=20
> +static bool
> +nfs4_anylock_blocker(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +	struct inode *ino;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +
> +			/* scan lock states of this lock owner */
> +			lo =3D lockowner(so);
> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> +					st_perstateowner) {
> +				nf =3D stp->st_stid.sc_file;
> +				ino =3D nf->fi_inode;
> +				ctx =3D ino->i_flctx;
> +				if (!ctx)
> +					continue;
> +				/* check each lock belongs to this lock state */
> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +					if (fl->fl_owner !=3D lo)
> +						continue;
> +					if (!list_empty(&fl->fl_blocked_requests)) {
> +						spin_unlock(&clp->cl_lock);
> +						return true;
> +					}
> +				}
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> +static void
> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist=
,
> +				struct laundry_time *lt)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	bool cour;
> +	struct list_head cslist;
> +
> +	INIT_LIST_HEAD(reaplist);
> +	INIT_LIST_HEAD(&cslist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (!state_expired(lt, clp->cl_time))
> +			break;
> +
> +		/* client expired */
> +		if (!client_has_state(clp)) {
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +
> +		/* expired client has state */
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
> +			goto exp_client;
> +
> +		cour =3D test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +		if (cour &&
> +			ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
> +			goto exp_client;
> +
> +		if (nfs4_anylock_blocker(clp)) {
> +			/* expired client has state and has blocker. */
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +		/*
> +		 * Client expired and has state and has no blockers.
> +		 * If there is race condition with blockers, next time
> +		 * the laundromat runs it will catch it and expires
> +		 * the client.

Is this comment still true? I thought the laundromat now
turns such clients into courtesy clients.


> +		 */
> +		if (!cour) {
> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +			clp->courtesy_client_expiry =3D ktime_get_boottime_seconds() +
> +					NFSD_COURTESY_CLIENT_TIMEOUT;
> +			list_add(&clp->cl_cs_list, &cslist);

Can cl_lru (or some other existing list_head field)
be used instead of cl_cs_list?

I don't see anywhere that removes clp from cslist when
this processing is complete. Seems like you will get
list corruption next time the laundromat looks at
its list of nfs4_clients.


> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +
> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
> +			!test_bit(NFSD4_CLIENT_COURTESY,
> +					&clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +		nfsd4_client_record_remove(clp);
> +	}

It wasn't clear to me what was going on here. I did a double
and triple take. But it looks like this is the spot where,
instead of removing the client record and destroying the
client, we just remove the client record and leave the
client in existence.

A more explanatory name for @cslist would help readers, IMO.

But maybe this code can be reorganized so that the high-level
decisions are made clear and the technical details are
shuffled off into helper functions. I don't have any specific
suggestions at this point, but I'm going to continue thinking
about how to make the laundromat a little less cluttered,
possibly as follow-on work.


> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> @@ -5630,16 +5986,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
>=20
> -	spin_lock(&nn->client_lock);
> -	list_for_each_safe(pos, next, &nn->client_lru) {
> -		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		if (!state_expired(&lt, clp->cl_time))
> -			break;
> -		if (mark_client_expired_locked(clp))
> -			continue;
> -		list_add(&clp->cl_lru, &reaplist);
> -	}
> -	spin_unlock(&nn->client_lock);
> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);

There's already an "INIT_LIST_HEAD(&reaplist);" right above
this hunk that is repeated inside nfs4_get_client_reaplist().
Either one (but not both) can be removed.


> 	list_for_each_safe(pos, next, &reaplist) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> 		trace_nfsd_clid_purged(&clp->cl_clientid);
> @@ -6021,6 +6368,15 @@ static __be32 find_cpntf_state(struct nfsd_net *nn=
, stateid_t *st,
> 	found =3D lookup_clientid(&cps->cp_p_clid, true, nn);
> 	if (!found)
> 		goto out;
> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &found->cl_flags)) {
> +		spin_lock(&found->cl_cs_lock);
> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &found->cl_flags);
> +		spin_unlock(&found->cl_cs_lock);
> +		if (atomic_dec_and_lock(&found->cl_rpc_users,
> +					&nn->client_lock))
> +			spin_unlock(&nn->client_lock);
> +		goto out;
> +	}
>=20
> 	*stid =3D find_stateid_by_type(found, &cps->cp_p_stateid,
> 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> @@ -6525,6 +6881,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
> 		lock->fl_end =3D OFFSET_MAX;
> }
>=20
> +/**
> + * nfsd4_fl_lock_expired - check if lock conflict can be resolved.
> + *
> + * @fl: pointer to file_lock with a potential conflict
> + * Return values:
> + *   %false: real conflict, lock conflict can not be resolved.
> + *   %true: no conflict, lock conflict was resolved.
> + *
> + * Note that this function is called while the flc_lock is held.
> + */
> +static bool
> +nfsd4_fl_lock_expired(struct file_lock *fl)

I'd prefer this guy to be named like the newer lm_ functions,
not the old fl_ functions. So: nfsd4_lm_lock_expired()

As an aside: I harp a lot on names and on patch descriptions.
Open source code is meant to enable users to make deep changes
to the software they use. They can't do that if the code is
obscure or poorly documented. Thus I view naming and
descriptions as nearly as critical as proper code licensing
for open source projects.

But also my memory is failing. The source code has to be
easily legible a year down the road when I have no
recollection of what it does or why. :-)


> +{
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_client *clp;
> +	bool rc =3D false;
> +
> +	if (!fl)
> +		return false;
> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
> +	clp =3D lo->lo_owner.so_client;
> +
> +	/* need to sync with courtesy client trying to reconnect */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
> +		rc =3D true;
> +	else {
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +			rc =3D  true;
> +		} else
> +			rc =3D  false;

Couldn't you write it this way instead:

	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
	rc =3D !!test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);

This is more a check to see whether I understand what's
going on rather than a request to change the patch.


> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +	return rc;
> +}
> +
> static fl_owner_t
> nfsd4_fl_get_owner(fl_owner_t owner)
> {
> @@ -6572,6 +6965,7 @@ static const struct lock_manager_operations nfsd_po=
six_mng_ops  =3D {
> 	.lm_notify =3D nfsd4_lm_notify,
> 	.lm_get_owner =3D nfsd4_fl_get_owner,
> 	.lm_put_owner =3D nfsd4_fl_put_owner,
> +	.lm_lock_expired =3D nfsd4_fl_lock_expired,
> };
>=20
> static inline void
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 3e5008b475ff..920fad00e2e4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>=20
> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>=20
> /*
>  * The following attributes are currently not supported by the NFSv4 serv=
er:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 95457cfd37fc..80e565593d83 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,9 @@ struct nfs4_client {
> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> 					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */

The comment is a little obtuse. If the client is
actually expired, then it will be ignored and
destroyed. Maybe "client is unreachable" ?


> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)

Maybe NFSD4_CLIENT_EXPIRE_COURTESY ? Dunno.


> +#define NFSD4_CLIENT_COURTESY_CLNT	(8)	/* used for lookup clientid/name =
*/

The name CLIENT_COURTESY_CLNT doesn't make sense to me
when it appears in context. The comment doesn't clarify
it either. May I suggest:

#define NFSD4_CLIENT_RENEW_COURTESY	(8)	/* courtesy -> active */

Nit: If I'm reading the header file correctly, these new
definitions should /precede/ the definition of
NFSD4_CLIENT_CB_FLAG_MASK.


> 	unsigned long		cl_flags;
> 	const struct cred	*cl_cb_cred;
> 	struct rpc_clnt		*cl_cb_client;
> @@ -385,6 +388,9 @@ struct nfs4_client {
> 	struct list_head	async_copies;	/* list of async copies */
> 	spinlock_t		async_lock;	/* lock for async copies */
> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> +	int			courtesy_client_expiry;

New fields need to be named cl_yada. "cl_courtesy_expiry"
maybe? Also, please make this a time64_t field.

Or, would it be possible instead to compute the expiry based
on the time of the last state renewal? Then a new field wouldn't
be necessary. I'm not sure, on balance, whether that would add
or reduce complexity.


> +	spinlock_t		cl_cs_lock;
> +	struct list_head	cl_cs_list;
> };
>=20
> /* struct nfs4_client_reset
> --=20
> 2.9.5
>=20

--
Chuck Lever



