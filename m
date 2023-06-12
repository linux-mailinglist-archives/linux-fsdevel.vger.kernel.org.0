Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A172CB3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbjFLQPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjFLQPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:15:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC2F1713;
        Mon, 12 Jun 2023 09:14:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CGEClP007656;
        Mon, 12 Jun 2023 16:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OKuZRjR269+WNCMR22G91/3fSsocCvkUVVf+002fbjg=;
 b=k/LBM76gId4vOxI4JAooXD+aS4BjM6N/JpyHZ+QJ4qn+T7kjRWYbeom18RHTIXdg32NF
 4A6idzMk7Y/2lPFcM/3vi/H2I0OicnRGYBpIgKZhBucpf5vHmG1zgsVr9ru6GxXtHh3R
 jE2d2hJsY1styHyHw9M1YSjIvIqN6iSiwMSEgTHOMNIDU2rTp8vXCIFed3OYUtzfS1kA
 ILPlAsEtQzp/G94rbrTO/Z2l1Gevk4YpVKN3aeQ4dwuLqxs9CWx/dB/1PP1mPgJNV7i4
 JpFomssNI2eeIET/4blcV+DDuGQhQWBn8oQDMW9LyG+A/Gi7uhIxJVQoqFZuQTIUEzII Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqukb1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:14:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CEnbkV008307;
        Mon, 12 Jun 2023 16:14:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm97wtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcESEvXMWjAo0dIHom5KDnTtjliqNwZ9aEFF0Zv99Lnua7o11jG4BnOwDPDxtszC50ZG5lkeaP+d1l7yS6iPqplC4DtzoyJr6kBwh9InTJ1NNqyQyegTyZ9tWHQYF2pWLGr5I2JCb5iCW7aR7YrChxvAF//0H1RhTjdem9vQx97eD4GvyM7qEqRciUg6BP3s7iGaTP7HQvIy1Z0me/NNDLdFKUAtfIpTcMyn1OevLpFSPR+G+8AsUbXtDbQQh+j+5+GXYAVMqOGz3J/0rTCdnKOTDi6ys+E1hbARxIqIFWQo+e57Hnns+4Yz+MZg7ZYhEM0Fp1BjcX3SQuthuZcUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKuZRjR269+WNCMR22G91/3fSsocCvkUVVf+002fbjg=;
 b=BfQMtlvmY6lQXItXrnB4y5YOZxDo+iXdERvVX7c0LwF4G1Pwp9FX3kcyGs7Akvva9C7HR96vNyT9eYChT6HOUpy3ILKqoq4MdvI+NYUJkKZs6bbPjDCPySalyjwOURr8veUijAVHdGa6hhN1rb89g7KIRQjruHLDeNeP6FoHx9rfbKTsHgu4aB7YKLet6fldd0vgKs+CM3Q4lNJIOofK32mvmEagkVQbVLwDD62LkOXZamjzrPqX+jm/UlYGK3FyRD5pSCP5WON5TIqjnHuO2k9AvNcv/MZeJs3ekmLagVoquYP+s9lBceqQH+XBsVZQCL9s+IwBTRN/9/QBNOV9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKuZRjR269+WNCMR22G91/3fSsocCvkUVVf+002fbjg=;
 b=hkSmTkyCam2QwQqYtoNX59syW/mkK/0EYZcXrwoA9dII8qijuC+okN7F8dQJvXuE7qSs5kCfc+pZgfOsysKNsqNE9uUwglg/mHHL/KO4navX/TZatxpIo7iZPAEq7YnbhBR/khGtpwcUiic4xvlQ6M2ajW+hGz5uN3IajV7jURo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4314.namprd10.prod.outlook.com (2603:10b6:5:216::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 16:14:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 16:14:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] NFSD: add support for NFSv4 write delegation
Thread-Topic: [PATCH v5 0/3] NFSD: add support for NFSv4 write delegation
Thread-Index: AQHZjQiGGnVjALUvL0WDtPiLH09u56+Hd+OA
Date:   Mon, 12 Jun 2023 16:14:46 +0000
Message-ID: <A60CDEE4-ED35-4907-8989-499ECCD40EA4@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4314:EE_
x-ms-office365-filtering-correlation-id: efdde1c9-ebe7-47c9-494f-08db6b6023e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ne7hckfYj5JYFM0Wflipt9ZIQ/QnDZusToLS5rlSG5RbyvgGmKkz7R+MvDVhVlQenwUNhZOdqA5tpSumRjk2M2WAJWtbF3qqAw1I6YTZl3D5FYwKr3hPsOTsRSNIMuSYWP0MlMcSx1Z9WZXsQwv6OsjTkmlZ2OFWR/NFRSXk9oP/1OjtzhQnj7PPVj/23hq39uHIenHpKs633fqmdT+YFVU63OgWJp6XM1tmhFFHFvO/+3jKMIYEL6CkPj4VAct7D0DRkVQXDbb5579F/gz50EcZfAGE5QsaRHyYLjAlO9t+J4i7vn4iBJSe0pai6wvYBZpFp1fOm0swj6/UKbrIAljuvi1nDzOJso1r31VqtklHWeatrW0mPWR0BGycBUpsyTdLEhBFeI6L9extcKxo4/MG7lIMJsG98xGUATUqzl2+kC/XoyZeJH+lYBitHqU8MWjGvdIQAcf9IMzugCQXpD2DEgTtojRIWxhVbiDp5tfs2yzMzgvWBZEhguZqsx5JUwwwBFOy/Pwsya168tiv66qjFBswzXoskN+i8AvK8JCimT4KvX85wdkhwgDVKqOzpzhEcHMKYW5P/v2eJ4B+e2AZ0JXeWFqKailtyIsoOMSxiPfrztuWM3ITbO80dDaiCrrmY2ugY8ejfGRBDG+Pug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(8936002)(8676002)(91956017)(5660300002)(4326008)(66556008)(76116006)(66946007)(64756008)(66446008)(66476007)(316002)(54906003)(110136005)(2906002)(41300700001)(71200400001)(478600001)(6486002)(122000001)(26005)(53546011)(6512007)(6506007)(36756003)(83380400001)(186003)(33656002)(2616005)(86362001)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u+pwvvvGMt9+6R5ZUEHcVgPdZEis6tB6QR+siaAUrzfys/+ilyRad9Sj8E6V?=
 =?us-ascii?Q?sXfbLiQj1Nsy5fMVmlL5+gcZMIaD2ANJ2F6I3iF9pF24WEhOYXS3xlD7nUm2?=
 =?us-ascii?Q?rLyNnotSb4lztaGZ8JHcnsal+SsLDcx3mxPrZQzHfr21Em9VsJJY/P0Ls4tL?=
 =?us-ascii?Q?sHAWpVOS5omWMuHQwKqeHbYw3EZx0y0cJqulQTtiI5x66ueLh9iZ5qQ3+tbO?=
 =?us-ascii?Q?WvYtulO46NStwMr1tcf7G2VbhEzonpDqOyczv9KVybxEUhlwN61l4PFTRDgp?=
 =?us-ascii?Q?f8l66YCoqbIesp+0IaV7BuXnAhaIGa6JaxQMm+52me3sReM+KQO+MOSIeXVP?=
 =?us-ascii?Q?UbJ8NqHE1isLvbyA7Rk4aaW03VB6sjVBlEOVHOjdql02cdwbUYfgp16WIoRH?=
 =?us-ascii?Q?mvIawfd4or5TalRBxXMmAkoYJOGgu/rDRPkHP6UwUqakT+bkoyZoUruXa39M?=
 =?us-ascii?Q?DzdMAYB/0SAWvjHYSq2K1Sqln7555vEWU91CzmeK7MbCWsCoLZlngdeiHq0v?=
 =?us-ascii?Q?BDoJF/Rkn3VbAKqFIYFqdUwTH1zzkzho5nPPJRcey7f/fVzz6G5VJU0oa10M?=
 =?us-ascii?Q?wWqGS0f3Oes/Ph45P5dFNLUSUjmTd65218r7N9gSiMEoyy7ET/fjiwR1p/Yx?=
 =?us-ascii?Q?zCO0n6IxmWdRg97o57P/mC5NCOBh8md5/yD2OJ08r+acErJR+gXPynYiVJIg?=
 =?us-ascii?Q?TycRZWIkror+UJEjrEjAwkgzmxfEnpe1A9+Pvqel4LblpzBb8cAA7a04FOEs?=
 =?us-ascii?Q?q5AL5wO1XA3+KqSjAFc1D9Ue5A+WlmtD7Ju8eD1Z3IX4Xx9GqP6+xxig5cBc?=
 =?us-ascii?Q?1t/GoMTvTxHlp+N/LwtpHA3KykyBE0pbYOUhEKGVd/VAMm2sA1ViBkyfRyG7?=
 =?us-ascii?Q?E/Lr5Cxe2zJoOVTSBayLQoksnmYVCjV7OuDW9w/cC5oVWjZBBJAOVcZOGuXw?=
 =?us-ascii?Q?XWUegAlyhJwKkaRF8FoP2D0ewBR8CKYekHcBZWRlZ0TWk6RsgBl/QgZaPnze?=
 =?us-ascii?Q?He6W1Dc+6WhZOp86AV+0is7qoGZ74LYt7s63kGlbxdx9E6nqaXyYrqw83JkP?=
 =?us-ascii?Q?j2soOcyqjFuR0OYHPv5gbZjJ2CYsKfKiA0JDkbn5L8YREWNgKRKw9EMWRtlV?=
 =?us-ascii?Q?ORLLDTi1SA6BkWg2+TEwDgiV2NuIzO4FeP0TDYSCQJYfr3oQlKEC+Oenaskq?=
 =?us-ascii?Q?MAUCXBuBoNI9b3KD7m+/7CFrGQMfnPG8J7rtQxWbgdaceq4E2we7sGJ70To+?=
 =?us-ascii?Q?3+G6sCCfTyROYsk0PGnZMDwrMcGzxSVuAcXzgUYKsou/MME9/nIxwbrTaFld?=
 =?us-ascii?Q?5ecR2jB/RXTSwLfEzzdpjgm0D8YE3evkTBwWoH87oVUQVhvWA1o7swqySy72?=
 =?us-ascii?Q?Qc3w28MLzUQvHc46doSUaEgEOMye7bFl/a34W0yoemVgksd+cChK830gZxOx?=
 =?us-ascii?Q?Hp9bFvj1TK8sWJEu/aCaSf06bT3ejSaNYb9toACzUKxS0LmFbkXYC2xHKqOP?=
 =?us-ascii?Q?dzxkJuWdq4cl+bC3U33ufPyleCYwFiR1AGLhHVBR7da1nYWik0PbMBcQr6I7?=
 =?us-ascii?Q?rQFJwX5MDZatrOx4NkmiWkAhlbVvPxqVxL/Vxx+znwDTu227WVwCmtn3+Tjc?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9ED304FDAB068F4FA4FE0C8A2C4DDBF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eM8hzvQjXj1UrLjEdBKQ32dXveZCs2Ett4A7ZoUFqozo3lczy5F0fzY8sQVnGF9ZZYQf506NLJo6h2D7fQdPO142ASda9SuLUffLcaiQ8ghkyTJJNxS/nTsqBMVZ0kg30Dhi4Wz1Z7TYN90whntukzoNGPCkQeLL+AabFFs2m1FFt2qusYcWHckgBY9YpRFx6fgyF2z5w+/SOj7h5/YQAIhVbOLBgH+KccmpF/nHepXYx6z+7EY9T74sDjwUkBpWCPrK2IYZHA/ncHcu0wpW4N4FzRKMRuRnSwvGI8XrvqvlIVbsNCq6VbUgqxXnJSnepdzclw0Gq8a6iTz4wGu2q6Ih0pYtWWbtnlX2Dv7ZhadsgiEjo05xbedyp0ba/BnW7eEXUBFD9Fg2199dLMlXxox3vYqwxzDYrsmuEGDfbVAVIruEVqqhAmiq/eIe87dvb3Kj6gIXhuZ9QjOFqnZ6Yy9QmsdEnw1LIc4/H6Y2WIwMxnd34U1hEkNnihTcW72o5UpOET1nVhWd597p4SatVl23fwWBS3ohzQzAMEupFbmqnRnBTlDRkK7VHZuPM6+JKQz21qPtHQBT0tEVo32AUclcSymMrIobU5jZjepglME6YNX8bPqwN6r0+tQEQ6431l8+dOia+elvEFGUSqbhj/dPh5Udts0fZ7nzIr4j/RmpX+5A7eww0QhZCBA6fQaTAPpKvlwYHZhrChYt1DSyx3GC5f1yt5RbltgvTXTsTpcsbMV2xAZxEbfJTmPyiFIkQioNpoDht53yne6G5Jv0N6f6Sf6g4pmMW/r138TcmkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdde1c9-ebe7-47c9-494f-08db6b6023e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 16:14:46.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm3/teM4jFE//fz7xksDnpBM8XNEhsa5xTGCe3jA2Av+cT+r4nbeFHlX7IoLVpp/Rjn8qACsfFhuSCQxkSsONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120140
X-Proofpoint-ORIG-GUID: GSPHzeAsTVM41ITOWohoLc2mPr7lrubk
X-Proofpoint-GUID: GSPHzeAsTVM41ITOWohoLc2mPr7lrubk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 22, 2023, at 7:52 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
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
> Changes since v4:
> - squash 4/4 into 2/4
> - apply 1/4 last instead of first
> - combine nfs4_wrdeleg_filelock and nfs4_handle_wrdeleg_conflict to
>  nfsd4_deleg_getattr_conflict and move it to fs/nfsd/nfs4state.c
> - check for lock belongs to delegation before proceed and do it
>  under the fl_lock
> - check and skip FL_LAYOUT file_locks

Dai has identified a few non-trivial issues with the latest set of
NFSD write delegation patches. We've decided to pull these out of
v6.5 and try again during the 6.6 cycle.

Thanks to Dai for his focus on this, and to testers and reviewers.


--
Chuck Lever


