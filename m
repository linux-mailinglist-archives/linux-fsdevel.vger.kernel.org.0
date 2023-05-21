Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB570AEEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjEUQKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjEUQKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 12:10:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6A1AC;
        Sun, 21 May 2023 09:09:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LBvUfX012380;
        Sun, 21 May 2023 16:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Dk/jp9zmtwW74/I4AQBx41ww9pIE0d74CwilQZhhaJQ=;
 b=SVwIJoeWo6Lwq53PEBwoYLxnCUG+w1LxUQeQ132ACWzTFQNfTapsmTLt+Wev0VPSOi98
 Teu5oOPo0bdd6jTUfVu0fvwmmuwvUc5iWq7SjzRi3vH6GvaOeY4unVcs7v+9xun30JKF
 GP0GqFcy2RaSaIRLcq5+fnYbrwbvjkmI5NM62fy51TZFp/QexKNAyj9hLU8nxcbfR3yL
 hxOvYrKhZiB64fJUV1Gg3bFaV+1VTeDdOrp7XbgoH+s7sq+7Wuv3j678CgyqwQmg5MF+
 JU3IS6dI0MX/sLodSddXAIaTysUwA0pjjkrIsWBPiWQtt4+uE/MrHhCMCcNCrLfcdewb yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp421bb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 16:08:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LCA7nl028528;
        Sun, 21 May 2023 16:08:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2nufn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 16:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHQeGpDTZNgy8QoyWHM7syKFe3C33gN74Azt2CFgSqhieZRpRIWRWx/OdAdIaKalpQuY1rJ9+X74VCJtiBIFe6WS0IUpL++bOJfeDKdKNRUe9M/tUFCUq8bvXttoYJwGgFh260nrKp/NaoQZuzWt+OBhgf2vAG5rTTqhRyf/Q7bfSy/Gll97g9BPbppa0eOse3r255+uUeXgd9OGI9tHI/MJ5UMHnXYR7xyiKUCmqfviOfFVaZg0PDkIloPkAYkGDDIgUWnptUzyIDQmnaBJcg9Q2VjWs3pe/G5G4WqqLx09Kk4OwGNp9SRFJA6buUPA0dY2DYZcQF61m/D6L6Jm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk/jp9zmtwW74/I4AQBx41ww9pIE0d74CwilQZhhaJQ=;
 b=Ik1vM59bbAE51em7RmAjCI9t5RxBWzOCjgs5v1GH4m7sHaG6be1QqP8FsdSPpp5zlduwkwFDHcvMv6OCG6wKrzJewj/Ido+VamfpCKUefAXex7DIVyHdpAalRaJaaQhB66oB88OorNq75yd3sf1aofyDSqiZ4nenOYgGA4sHMkSlEDgInyOIzYB09R2BmV4EoOEMsU/iRHoBmcfMNzsI5w0cICJIfdxu09nxuO+SMy0iTsKs/EcoM+TGc9ExO8agYO8K7bZcipe67D6kBJdqdCJg7dofMGM5j0xpkMAQhdKnOyIp+ZkC1lAAqSrxODMaHOgDq3qV2+JGXuy1vh92ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk/jp9zmtwW74/I4AQBx41ww9pIE0d74CwilQZhhaJQ=;
 b=GqvZCp0brTJthK7RIcgs+hrDdzFZe3VUN80HpJqc8ji47KCr1SbVhxaCYb8kcxI+8W8mPReJ/9Rj5IONU+7V9SwgY7k2YDfrabXAaXPk3HERTzXcwavp8ZwfTWR6Ld/L5BQbrwdTRgYb8M/kpSdc8uFg1m/Nf9CJ1IK+wQuQ0F8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 16:08:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.028; Sun, 21 May 2023
 16:08:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] NFSD: add support for NFSv4 write delegation
Thread-Topic: [PATCH v4 0/4] NFSD: add support for NFSv4 write delegation
Thread-Index: AQHZi2MuQlxuYswqqkO/kMJtpCH6Ta9k5kIA
Date:   Sun, 21 May 2023 16:08:55 +0000
Message-ID: <22F9F1F6-7AAD-4273-8437-20FA6051E430@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5234:EE_
x-ms-office365-filtering-correlation-id: efcfa243-3e75-412b-d834-08db5a15ad5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hga515yw9DQxJ/hIc8pAs3t2wyJpTswGIFxKcEVub4xYpqFFEjBqVujugicIXEiupQsnzhLfz8g3ntzg6U/IRdz62Q+qRhMG/XogAtVSR/VPlmKwg4UZQwD5wn20Ga/z3zBfh4EzKHoEPR59kgJ125uM6KxYWxV3v3iB5BJdKiLs2X1OweeA7gIijzf3KU8+SqzOJvi2KGZHkMlH22M5nhyi+2qv87kWEU4yqdNLUSLBVl+3iGifq59iBt99Tqr8h7EEdJl+MRf/mUrz4IMTrrTCfb2W/oHAIxxOo2FWxk9S4RiaQJFfqyZIvXEN3kWn2OMl8WptcU4XunVLWmsAv21OvC/NZfU6I4nET296JAaOnL5H/Q6U998I7OJfLOSNnX6Kx6F68McUsG6pIz+6ZgHe0QHNzeQhgxnLKJx98qe1p+6X5ySFiwAmKxMKvgZyp/QeL7Ekq2ULvcYkuQlBaxN/0NZmO7jq0YleDHjZbEOnHeOIH4SGqSy3NgUIaXS/0y9vcwhAyFXC0zpebaDB01AVzTrt+IZ2FKhoKAk2M3iTg1Pe9FU2vUsP+x3j0yA+v3eezWtvMfoiuHTNVBP1/ITfsFi/jNmTiS7o3GatHkz/roIzxbZ6/kvhJH4lCXpTxyLK8Q5JG6PFCYSOwxtqWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(478600001)(186003)(54906003)(66446008)(41300700001)(5660300002)(110136005)(71200400001)(26005)(66476007)(6486002)(4326008)(316002)(64756008)(6512007)(6506007)(8936002)(8676002)(53546011)(2906002)(2616005)(83380400001)(91956017)(76116006)(66946007)(66556008)(122000001)(38100700002)(38070700005)(36756003)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fC2UwBuIV0vczv6C/96msWkVbUMMHt42nXzhYrNtVxbrw6iuailfuZnWrquo?=
 =?us-ascii?Q?wG/4uiycdIW0YR9htrFTbnrhJPQ/R+OR8EQUfd6V3GVUBUTD9P05gSYe6G3d?=
 =?us-ascii?Q?pujpOHsDxqP4iJDgCxKY6dGUndgtubtgVXBwRWeGm0R9zoBbqUHV5xk3PfrB?=
 =?us-ascii?Q?BBRwJAFC7zKWrKon1bV6pkYmocM/DkZki6rZFA4ztw/IAfcjat4k0LoYK+oU?=
 =?us-ascii?Q?Hea2UhG/dJKqqC36RAPj7TB3n6vfglPOk4n+Bc3J7oki7WlbV3ae/iL+CaB0?=
 =?us-ascii?Q?ySGQl1/MWhx+vkUQJG2aISnuZ9KfYOpwNjbsfzxPE7fOng0ojiZxzQXKtZ2G?=
 =?us-ascii?Q?xsi6pZSI/DM+ecS0aPzBprW6hGhO4/lbD9kQuEthOZTOScMgD3Kseva6HDtZ?=
 =?us-ascii?Q?U/fVsV6jut5j4XrOT+RkkMO+UIM3WS5x0M+LeMs0tU1/AVXJBpzTfVUf+/2G?=
 =?us-ascii?Q?pJuK0DQX2mcabsRfdZ4HRp3+A1607Et5go87tO/ESmOrJ6+J5CTPzEoKnZFa?=
 =?us-ascii?Q?PHeADkgQuOqZN3NCpPU4cq/CbGQCBJi3JWRnyU9dHwBukbsi4rjTTnVPyJdM?=
 =?us-ascii?Q?C2kFrPLbFu8/GM9dD7Va1S4RIXZWid07C3eVgW8/v8GKlXtFrrLvWjgAMfIR?=
 =?us-ascii?Q?k1HOM+rBS5Hzf53MXj3mMyGmGR4CLlCYHLv80hY8x7KKVpSKJmeit4BW+ISY?=
 =?us-ascii?Q?dsOtpuCbODMCMaFxqY2HDPh9BMK+xbwGEDhUbDTd5ujwEVNn0dYcERvWx+Is?=
 =?us-ascii?Q?zLANjTjrsEuQXZ2anSUqGZOO2+OsCKWlNW1HUi/EjmnjZUON2pdM23f+Yepg?=
 =?us-ascii?Q?UxL+mQT6802+rdv74aGVyJHqNA2QIjMfGFukpiCADHQuyDNGCE6i1BFkg1JT?=
 =?us-ascii?Q?em0brPmSl5imxBoPHw6kJQoS+b7CsCQnHGMpj/mfu1+CNh5x+fVNJit8gGux?=
 =?us-ascii?Q?Eq0KojQuzLCIo0cmkJ7kVsHZ7+SNh6RuQqsV7UBhFv0gmfGIKrR0i+STWqqd?=
 =?us-ascii?Q?2Ik+L4cNw96acyRcwEvO7KcMJT+VysQFCB5r3dwgnWZvOPktrN3jb/ru/oGj?=
 =?us-ascii?Q?ghxbAYzGkNnJPN6pkUl9jTUZLc8io7AXyhBtn3DAZs9pINK86u7Rb9PvQ3zd?=
 =?us-ascii?Q?JwX14bFB0gEvnnvKGLzyHBBce+YCrA9u+pI1LsVi2NPsAI8qU1s6UycUMZ9Q?=
 =?us-ascii?Q?v/0Mnk/29Q/KtSPlh9TsaRyJCZJ52FLkl03QeNS84thryY6FTlohRCedVIsz?=
 =?us-ascii?Q?w3ZmaBIaWJ6A5SPhflhUfIgXcm0MQsM76BVuhZd83HYARJfxZG3ylHR07BGZ?=
 =?us-ascii?Q?TdoNxtD5ioo3VWeZYtJQYRjTH1ENBWHodpQWnPzMjbXP+KqVQfHdC5gueFAU?=
 =?us-ascii?Q?kQtRNsCBVr2fOjbs+cis9V1SAkEy3Yu9PcZJ8Gks7NZB/d3Fjmybd9mleR2A?=
 =?us-ascii?Q?IgVrEFhZQziqXW9g4PpFzfxuRwyV7FM82B3nGOOVIh2y0lTqpjnI2/dPOkUG?=
 =?us-ascii?Q?aAs/0aIGQTdOB0RgoM5qbCOfhLYNWI++OrZgc7JwwBAONRj87dNqjAZN5SVR?=
 =?us-ascii?Q?Eu/rZkVWO8OqIrhntYtR/8DA3Rybp/N8A8f8I7vGEgNonnet+eyIwu47Nl86?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFE365589195304DADAE38F8D28A3459@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZWo91PxRDUHRlVoDAd/uKqCyy1z7BIjeZfaunFbQM/epg2TtTl9ZX4UhwHHc9D/XiP8CbebVyG7EQAFVRHjl7snRCyB60AvcpmDLhSErsbr8KsIPEzKSFGnyjIldpjMuKhT095P1Momev3a4TwZWhT4nG9E0mHESwwPVIVIaCaiNTYI155JicVYthkscETHu8tXhJwaYBvQKi5nE7anA3gRMxSlmO6jowCYaijbyYJixoHpCirs/RXL11vr/kId1PuM8GOAerusYmWPXPA2HFIjfyz08TyrmGr75+haOP5PVxmevCdF/JLbMLnN93cIA9AzNW+DSzDAcYIbz6nzV9PVuimhC1oVIWXLXaGpEZCq+fe7ROG1zf0tttN7+JUMsGBIb+N4YWVLxXy2eHSxZP4BV2gXfLv3YO2JtnM7DtGpF7c6NUYrEazwL3OrSVBNYv7UWk6AX/MQGyv0GZR4zw8k+fDbYBr1znZwbIfXijKVGUKHctY6xCyqa+VEZedyVwg8Bt5xxFficGr9SBJ+O8PFyFdfvWJNKHqBP/PHBJz1Cf28RS0ry6FWaqQBaWLAX6LQI3YlM/drPMt5s44QH6O5Tu/JI0HYRqiAneglTHjS7qb1idcGNvMeHX8ccENIpGp/5u168HphDzhzbUjRQxFSZtvnHktV64dUndhai/dOoRkCiC+ZkCovkNN/u5X8vSZjlM3ZkOy/kojHseIIn2CrGTzaN5IDqtPPtBl5bjZXLiviYrm4wOeROZADNN26ZzbLp4s8Ot1wFaHvw3wx6Bp0dzKvgmESSaZgB1SlVoEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcfa243-3e75-412b-d834-08db5a15ad5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2023 16:08:55.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQv+yBzNcb5Sa513k+6ZatRJvYV+vR5Yl2pLUKjrqzEJiz1jpeYScFFRcdJCm/YgP0ms7JU01gaGVrVFsSnmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_12,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305210142
X-Proofpoint-ORIG-GUID: 9g-bQyE6I_bhS6XRiR0P7KV_CqzkIfYh
X-Proofpoint-GUID: 9g-bQyE6I_bhS6XRiR0P7KV_CqzkIfYh
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
> NFSD: add support for NFSv4 write delegation
>=20
> The NFSv4 server currently supports read delegation using VFS lease
> which is implemented using file_lock.=20
>=20
> This patch series add write delegation support for NFSv4 server by:
>=20
>    . remove the check for F_WRLCK in generic_add_lease to allow
>      file_lock to be used for write delegation. =20
>=20
>    . grant write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>      if there is no conflict with other OPENs.
>=20
> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change, try_break_de=
leg.
>=20
> Changes since v1:
>=20
> [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
> - remove WARN_ON_ONCE from encode_bitmap4
> - replace decode_bitmap4 with xdr_stream_decode_uint32_array
> - replace xdr_inline_decode and xdr_decode_hyper in decode_cb_getattr
>   with xdr_stream_decode_u64. Also remove the un-needed likely().
> - modify signature of encode_cb_getattr4args to take pointer to
>   nfs4_cb_fattr
> - replace decode_attr_length with xdr_stream_decode_u32
> - rename decode_cb_getattr to decode_cb_fattr4
> - fold the initialization of cb_cinfo and cb_fsize into decode_cb_fattr4
> - rename ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>  in fs/nfsd/nfs4xdr.c
> - correct NFS4_dec_cb_getattr_sz and update size description
>=20
> [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
> - change nfs4_handle_wrdeleg_conflict returns __be32 to fix test robot
> - change ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>  in fs/nfsd/nfs4xdr.c
>=20
> Changes since v2:
>=20
> [PATCH 2/4] NFSD: enable support for write delegation
> - rename 'deleg' to 'dl_type' in nfs4_set_delegation
> - remove 'wdeleg' in nfs4_open_delegation
>=20
> - drop [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
>  and [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
>  for futher clarification of the benefits of these patches
>=20
> Changes since v3:
>=20
> - recall write delegation when there is GETATTR from 2nd client
> - add trace point to track when write delegation is granted=20
>=20

I'll apply this series to nfsd-next. There are a handful of
changes I'd like to make (with permission):

- Squash 4/4 into 2/4
- Apply 1/4 last instead of first
- Add Jeff's Reviewed-by at least to 1/4 and 2/4

3/4 gives us a platform for measuring recalls triggered by
GETATTR. It might not make any difference if we add a new
counter for that -- but a tracepoint could also do it without
altering the kernel/userspace API. I'm still pondering it.


--
Chuck Lever


