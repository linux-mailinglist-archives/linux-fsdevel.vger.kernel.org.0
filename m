Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0E70BF78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjEVNQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjEVNQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:16:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F8F4;
        Mon, 22 May 2023 06:16:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MCwdMf030503;
        Mon, 22 May 2023 13:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ODZdd4htk/+163hqkGXMa+hxmGcZgb68VXGPCj1iAk8=;
 b=PU/AZJ+nQFnb8+LZhZeMSfBXghfflIfpv4dPrIWTYa/+txmuOHzDK4lrVyBBX4Zy/2s9
 yqAusE3lIRoMOflWbebykeg0XVZsPB3AZ2VM1kLBTf/7+Npq+qahYabVVfHOkntZJlha
 GAVVcjSNAmuIoPUS+XpTodbvNcwqvcgVy4mT0NRZqcmUZd0qMRPDb7A74PlO0tEFp2K+
 j1NMOh6lfF0nbkqrK7F/VcSH1fcLC2VGQ1RgAgnf4AV599DBUkdnIpYKvFq337ZG1C5f
 dgWp0iIEeVOwYit2rMVKXGmwFu4/J8NvqILVk+GijTb/5hTkSSU6mn19eHMDGpehuZzm VA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8caqnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 13:16:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MCLo7u012874;
        Mon, 22 May 2023 13:16:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7ded1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 13:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLonKuwfO2Uvz/nmCznKKSctkQVz4Mz+7dPPYXxt7SdMEtVCctREFH5Ghk5I1sg1oTtq4FMTFiexhOPeYVqnYaGcvayAxoscDVr0E/WkAZz3Q4FS6PZSTED2Xt7RokBl9F4EE+WrXR14QWBZ3xE3z9dnoc3OsRKJNC9uBK4q5D48X+ExF7o3z92DKJcl3r2gZ4nQh8mpIKWIUQWZ8QrMNysjMnw/epGoYQCr9w2vz14rLpOlBTEBxcU7xlIoHj95nsR4rIQR5xArMv5ayYEBvEOdWi3AzLDA8CyP+OrhOeTh4aF9PrnJ8m84uo2OkxV9Vrci6BnGcoVZSkSltc1z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODZdd4htk/+163hqkGXMa+hxmGcZgb68VXGPCj1iAk8=;
 b=GOQ5Y5drXC+99mmn8wGi6eacIg7AUNRVCfCZmx2KUc1i5kvSIbWYq5Xa8cvm63RovhJI2lzDvjpUxW7CXKwOpgKp5d8OWuSRoQodm64lU5+4iyTdQf5TcWNspW88LcEk5M0zkGYW1D8ymwnJL68/OWzAH8GW6S2pyAR9vUaiHQV0gyhrysG/GUGDWkdqol5Le+vVdN5Y/CSY7NLuCq0Mw3jmb/8CRwETyDgUWD9iRNk9aPs7t67uAzsvHsfOldH0kJYoPx7a15U9Dc3+jjaTr3ouUFQfsWYwoFSbed8jx0NqMxN4CBwFQgUIveFQ+tkcE8y88eS7xrQn348Sg/Fdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODZdd4htk/+163hqkGXMa+hxmGcZgb68VXGPCj1iAk8=;
 b=AuGm6uAkeErU45Yi9gvowIhCxyGLysavaUm4ZzCGAkQFvXikj8zYOXgt81uuhCUiU6FieEv84WAuekZOJi4MDF0MwAsernWVke5j7863bSp1TVud4OazwWuOpY3BTXfYEePooo0+OQG71lCKYac2flH1kKgGWsHAqAYKotGkROs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5793.namprd10.prod.outlook.com (2603:10b6:510:fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 13:16:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 13:16:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Topic: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Index: AQHZi2MvfY9rMGGqoU21jeDHID9K369lW5mAgAA/igCAABDKgIAAnGIA
Date:   Mon, 22 May 2023 13:16:06 +0000
Message-ID: <37BFE68F-7345-4329-8D18-4042FEB1A365@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
 <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
 <546eb88d-85dc-1cd5-9a3f-b11f3eb144ea@oracle.com>
 <2eed123d-66fb-44a6-ba1a-c365b8bbd0be@oracle.com>
In-Reply-To: <2eed123d-66fb-44a6-ba1a-c365b8bbd0be@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5793:EE_
x-ms-office365-filtering-correlation-id: c214c331-d7fe-476a-8efd-08db5ac6b377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EIINLhlthLj3sIWAXOK8r+kmLGnS9uc3VJIMIAeA4wnLsdJkJpvG/0PQRTWhcL1OnYR6tGv6CpaBovfG6nfZx5asL9ExEgUjKXkLlldfQS9rmPiN8vgbpaK578OwgOq5hak7vSxTSm2gkOSWYH6z5Zi7spka1OiHkbTPGX1pCPklFcduzI75yO2ue8DKt1FkAXkDYIs/FUUCXOSyuPhh1Gvu9NnEhYdiMLQBZq1L/gbACSDSTiK0skJWPc/dRo+7UiUnqMQTAnMp6tTIQZFvniRc0hNHf5/VW2N1qSLfurp1B35kmYH7PIFFILbDsjrbDdEhpQW7fDJpZz1PdcZScVi7QuRy8IBnPijWN8s9M1AbqSbzUTTd/DoI0/fzce+b5Hk52ojXE4Wnw+L4M4Cv9DTMaeYMM39KztXalyL6+VdQv/10pKSo+CtxUenuK1z5QjyTxQvGgeWU0Dx6DQuOOgGPOMWilexoZAY1GFJ3IlMpPuUUHKLe0qfBwqjKOomtYIHbZU40dA2IpazVFASGhvMegH3SBgv89n6XOiTF8pvv2aJmzqM+CFO5tTgzSMuRMOX9sH6t81oaDEUP3pZgTClDXw2+3tHtnEYIMEDcE6CHXpmb7HQ8CMSDvNLYlW69fAUk1kjg1gWufhnUeqYAtM9YgdQLzdAT3Ju9p3M5Ge10VmoY8jBJr4bOiF5ZgNGDiOALBlIyCs9lSDOLQE+GVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(5660300002)(8936002)(8676002)(6862004)(33656002)(83380400001)(186003)(36756003)(2616005)(122000001)(38100700002)(38070700005)(2906002)(86362001)(6506007)(26005)(6512007)(53546011)(71200400001)(91956017)(316002)(4326008)(66446008)(64756008)(76116006)(66556008)(66946007)(66476007)(6636002)(478600001)(37006003)(41300700001)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UO4BpNNS7OYb+foSlU4waR3tLGuj+gerbG4uP8iQgs0GGbKfYa5yaWoOYS/j?=
 =?us-ascii?Q?O8V16yf6z8U63GpwLpOaoDrhhbkY/B8LysGNLcnITGg5T5rk8vLIiFoh7lSN?=
 =?us-ascii?Q?i97Dxqgtp/zGL/pRTrxNrhUC2sG0ygTYpOEs36wjhee0sAwJ3kUnXG4m2yau?=
 =?us-ascii?Q?Qrg5jwh+beJxXWZvKHhRlSVHV2f7mjH1w36MA5zyVXSCk/Y9Jt6iODy8C34Q?=
 =?us-ascii?Q?Um8lrBeEX6LgKDiRBzKoNF8q4vxvOxBon3TuOybJo5lNcU6N7cYgzOrSvPE9?=
 =?us-ascii?Q?gfmGygaggA6ghJH09qU3Au6cw2aaehOe1JhOB1MTejEuqu3btfe/T8m//atZ?=
 =?us-ascii?Q?x2CrSAAk2Pda5nGIFCfVsnBGhCxMKL0fQtM2B0cZTl1ACghr+wdV+sMlCdWS?=
 =?us-ascii?Q?gr2XwPwKbAg68QVA0KASJxah4cSXHjo2DBVY4qujjlmaeT85LZtXkuxEn0oO?=
 =?us-ascii?Q?alvZ40zhRGBhiXZF/MYOB7U+OecOQiIkQOL1n+uzN0H+X5vjd98gsyJidVtC?=
 =?us-ascii?Q?DQeihyFdt1q8zDu8//y+P7b7iHZvdkU3S82kl8GYDo9UClJ1XpF+4gWHaEg2?=
 =?us-ascii?Q?JMsiX9u+eQ1ZA3r8T4UIzlu0SVTAQVBIxgjmPbQyUCeylZV8T9Mn+UQZrQ8S?=
 =?us-ascii?Q?AUehl8JTd0oePzVd3c6RwVP+gKV0xa5DYU1HqKB2uUykP8i/uTesEsfpN5m8?=
 =?us-ascii?Q?KnVUC9llWHkPlr9JHVXsOkePuBAy8llxR2fJw0nf06g+XznTnk6R3jM2auHD?=
 =?us-ascii?Q?PbDpc5s05O//3k8/CQTeUSpUZxtp9IPNMXqTd4ggKSter4IrD79DbrnHR3jx?=
 =?us-ascii?Q?OyUH6b7Q+rTPU1n1s3WytSOosJY04Wbl6XVnx7KnMw+SSdOjoHbDzBmpu/B/?=
 =?us-ascii?Q?nRTtGvXl4Sf9rubMtp3KxSsybARTypkMnVe1iPNS7M2Kr7k+tT0pzfnPYpGq?=
 =?us-ascii?Q?N2oT9fZW1z6DJqd2NWTJ/MXCp1upJHwMJzTVRaYIGA0ML99qWiD6jISqVhp6?=
 =?us-ascii?Q?TVbGj0NAwhBaiQ8OptuMlTzXiV6sJX9fuN5MHPEUweXKycoM12/+PvG+TOQ5?=
 =?us-ascii?Q?kviLhE4tFiFXc1gAryXVIdk+5g1eB0n1Sz9mdbFJUCsyDrbnMQ91Q1eORCKL?=
 =?us-ascii?Q?pt7uHTE8vJpzD7O/05KZPedGKKInmVg09mPy5ncWiYJOVsLp74JnIgZmROXF?=
 =?us-ascii?Q?twncxAy+KxRdP0NVlVlR3SkpCAdhkYCVlceOLk4deddPHe5Gkw9N2CdUxie1?=
 =?us-ascii?Q?hm3G5i6Vq0ryczXSfwb0TLSzYJ598uaicit5I+lpVaKA5Lj64WQORs1QHttX?=
 =?us-ascii?Q?eIaLlWuhTT40H6jyiAjkJ8ilhh+ypRTORmcgCKA5Ig7Y465lRZtLgmz/hRmL?=
 =?us-ascii?Q?DdbrR+ZyjpVQsS0gE6HD1u9ViYuYyXU4fd0Ma0025eXOweRDgyqi+OgZowHI?=
 =?us-ascii?Q?jDepSAjD8OxcpaUQSVed0mvWNcSvv4vydhn3cfOQTXwoa9X4NJy0sQX0/vVN?=
 =?us-ascii?Q?irKPswWD4SPjhTgzWC7oneLOyfwOey+tHTiaP4h2tS8ntBviBN2F5vt2OZ2S?=
 =?us-ascii?Q?nl5FRYICC4EUiQIjYHAkjZhFdlH8erCbSpLhU5ae1ybVwwQ4avq7UNzDZVNX?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91C67311EB78E94B8A005CC18D8A6871@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1vRvEijbAe2jI835+UrgDmN+ehTUaF/Wj11g2BgdLNIKWGyKC7RDQHf14QcXaFYHjH0qPvpAW93graD6uUxS5Dg0YGT/tn+GytcCdrqpSWXaPMZXr2HmTTai6ea1msnX3KMGT3k2LE9wYAL2Tm3fnOOQHahyY8yXY70LOe2+nFzwSMZDm8jgLGkYbzYrwHk2OG4w0aa0DbnWLdo7UYrJjXDksqtv4HTwNm/QfRtjMU+X4bVhXwdSidJJTePSAUCLTt7qCn6TH7sGSSOse7D/oU7dULQ8JZf8alrpLlnYy/g7m2EfrCYXwdxYhjNTH4Q4b8Uoi/VW1ajcPHLNAeOwBux8KU0Mr1w9CIeKsLNeSKGZTPzOmrV2Ait7xiZYeUia8at/eZsCqAw9RhGd2WJY7WiZ/WtESzS6XWe3n5/25GBYir54MD16DcDcML/ei7eZXShgq8LwvmRK85PJaqhyW+JPdfXdic9iHhk7STzhFrNmuXvB3po8HsPz3U4Saep5J4xz1RxhzZkb+FntaDImtAoih3aPtiUgPu3lC2RLvI6k8bo3Ctq3c8vZOxEECXMXrb+aDAw+IhWPVHlaTfgFfovJ/+WajM2BDh1FPcNPcKegwWwrCubsSk00E0mTmXm9oGgERbT0zmxnQR177Eb3IylH32+p5f69TGPWrdKtr3ZUHkRyUqcGhmJJ2bUMjnM6r8NbtO6/Upn0BJ9Ftz5MQVZNaN2JmI5M70KkmHbCbOD0zViui5WSp2/4k6SmUoKHt8siKqlVkKfpweCFKnFJWe2jsl/ByKcxOufu/B1d7aE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c214c331-d7fe-476a-8efd-08db5ac6b377
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 13:16:06.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiByaCZfpxdImX/DKFxlCNNiy0AzPmzetNLI7eg10206vHBnDkrpRzhLsl0cVSjcIgrEIPNP6HJQuI03rhtiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_08,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220110
X-Proofpoint-ORIG-GUID: l60HKoKsLWmVNnhAjxl1jiq_zoSfkt8c
X-Proofpoint-GUID: l60HKoKsLWmVNnhAjxl1jiq_zoSfkt8c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 21, 2023, at 11:56 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 5/21/23 7:56 PM, dai.ngo@oracle.com wrote:
>>=20
>> On 5/21/23 4:08 PM, Jeff Layton wrote:
>>> On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
>>>> If the GETATTR request on a file that has write delegation in effect
>>>> and the request attributes include the change info and size attribute
>>>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>>>> for the GETATTR.
>>>>=20
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 45 insertions(+)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>> index 76db2fe29624..e069b970f136 100644
>>>> --- a/fs/nfsd/nfs4xdr.c
>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32=
 bmval0, u32 bmval1, u32 bmval2)
>>>>       return nfserr_resource;
>>>>   }
>>>>   +static struct file_lock *
>>>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>>>> +{
>>>> +    struct file_lock_context *ctx;
>>>> +    struct file_lock *fl;
>>>> +
>>>> +    ctx =3D locks_inode_context(inode);
>>>> +    if (!ctx)
>>>> +        return NULL;
>>>> +    spin_lock(&ctx->flc_lock);
>>>> +    if (!list_empty(&ctx->flc_lease)) {
>>>> +        fl =3D list_first_entry(&ctx->flc_lease,
>>>> +                    struct file_lock, fl_list);
>>>> +        if (fl->fl_type =3D=3D F_WRLCK) {
>>>> +            spin_unlock(&ctx->flc_lock);
>>>> +            return fl;
>>>> +        }
>>>> +    }
>>>> +    spin_unlock(&ctx->flc_lock);
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +static __be32
>>>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *in=
ode)
>>>> +{
>>>> +    __be32 status;
>>>> +    struct file_lock *fl;
>>>> +    struct nfs4_delegation *dp;
>>>> +
>>>> +    fl =3D nfs4_wrdeleg_filelock(rqstp, inode);
>>>> +    if (!fl)
>>>> +        return 0;
>>>> +    dp =3D fl->fl_owner;
>>>> +    if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker))
>>>> +        return 0;
>>>> +    refcount_inc(&dp->dl_stid.sc_count);
>>> Another question: Why are you taking a reference here at all?
>>=20
>> This is same as in nfsd_break_one_deleg and revoke_delegation.
>> I think it is to prevent the delegation to be freed while delegation
>> is being recalled.
>>=20
>>>   AFAICT,
>>> you don't even look at the delegation again after that point, so it's
>>> not clear to me who's responsible for putting that reference.
>>=20
>> In v2, the sc_count is decrement by nfs4_put_stid. I forgot to do that
>> in V4. I'll add it back in v5.
>=20
> Actually the refcount is decremented after the CB_RECALL is done
> by nfs4_put_stid in nfsd4_cb_recall_release. So we don't have to
> decrement it here. This is to prevent the delegation to be free
> while the recall is being sent.

For v5, please add this good information to the documenting comment
for this function.


> -Dai
>=20
>>=20
>> Thanks,
>> -Dai
>>=20
>>>=20
>>>> +    status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>>> +    return status;
>>>> +}
>>>> +
>>>>   /*
>>>>    * Note: @fhp can be NULL; in this case, we might have to compose th=
e filehandle
>>>>    * ourselves.
>>>> @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, stru=
ct svc_fh *fhp,
>>>>           if (status)
>>>>               goto out;
>>>>       }
>>>> +    if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>>>> +        status =3D nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry=
));
>>>> +        if (status)
>>>> +            goto out;
>>>> +    }
>>>>         err =3D vfs_getattr(&path, &stat,
>>>>                 STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,

--
Chuck Lever


