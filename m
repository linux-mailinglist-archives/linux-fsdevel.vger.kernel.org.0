Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9CD64CE3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiLNQj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 11:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiLNQj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:39:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0FBF66;
        Wed, 14 Dec 2022 08:39:56 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEGEZnt019535;
        Wed, 14 Dec 2022 16:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=If+hQIDubvhtmg0K/jReM25P5LLn/inTmDdX2ANxP4o=;
 b=P3wrNQHvVryp4pY+kkc1iPM+36RRX34w2vR9dJ5IxLHpx6cuCN12k7dg3frw6lOki8pa
 kZKetBWYZgGZJbJjCc41/wdtdM3AAZB7gH2lFL0olZkBta/CHSUBc6mEkZ9jcK34k9qV
 ND9hnThghPW53yRzLpCNI5MiFuJ3JGsr9G/+YYwFcQPvy9mjfXgc7V+xrqAAMRGA5uTh
 0Y3eC+FAV/VkTnyI1PXSnx6xbIbES7jdBaegnyF0uvp1anjpEIHaMkmLTS8IxQfa8Exs
 ahrtJ+jNoSwW6u49uJ4NJEpNxb7K5IWNqmhdI3XGxKsLz36mXQt1RLqtZ3bWjVy8SVE3 hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex2rtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 16:39:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEFp7HO003930;
        Wed, 14 Dec 2022 16:39:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyewb78k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 16:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRelkApCb9LKhsAH96MEfiCm4wee70fZ6Bammxe81sOMYGAlrsMlxQBWv2WQTyDMPE8YeUGjo4LxdXR/RDR8HfqmOMaxomgUriEAk6jSdhM+u3Ra7ENzz8bqxiMTbyqacWhLSZ51ETgLPnd9oQzkezR0MK8OnO1viZmwWl+VB2Lp1Lsd3vhNBvf8qfr4YQvK6Sri0FmqeJltCKuTofbDAKycAGca+m45eFgcQyaRCese8T2WoBGi6EgOpJkI1Cxk6WsaRza5UmFk14x+6vbknkkGQbCGiN175oZUCaooa7P2N8Yfrd/nzot3Qmh5q78InQAq0Ca+JwH3m8EzWmPKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If+hQIDubvhtmg0K/jReM25P5LLn/inTmDdX2ANxP4o=;
 b=SIH3/+kpo4M8ruVcfyQsKm4CDvMuTggOTEO7/cbCfq2PA1lCzxXRiKGoYo69jiTJqNB/WWAjVUxD4mleSpqOtueQ2Vn2kedjVLVYBTmpivHhVcJHu0T3axLfK5XWDTEMWsK/6oHaIxTjcA8yjbiz9K74ULw+wpabziSuVYrKEPMCgUFmzqwuyqrMgmS8vneiFdn0+s71jW2jUtywLqZqYe8ULAHM31lZ4HeDjIWLUneg+u9BxmOJymY1GoceYLXxZdHaL/efGg0BP/KPTQdGfpErs2svVu4VtTZ1WiW8J3CIindEQ/xRdXXonChC9H/Hio8s0hERUDor4Fxb1Vytcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If+hQIDubvhtmg0K/jReM25P5LLn/inTmDdX2ANxP4o=;
 b=YzxNdr6o405RUWaasJRESrjbpP5kvOvG1FzJMrqdjKQJfG7y2RgHPuyYDbghmjmcF8oyCqsEj97dFxQN74pD5rJrOWwObkwy+wd/RLC0Yvdr7xgrPXLj09gsq2iyVaAyFWCBgW17xq69ahRAAOxFkGE3T6SUAIG/48vpe0tZfj0=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 16:39:32 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 16:39:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "benmaynard@google.com" <benmaynard@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
Thread-Topic: [PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
Thread-Index: AQHZChf9fDsgUtMhNUKtyOAuOArmha5th9sAgAAYlYCAAACngA==
Date:   Wed, 14 Dec 2022 16:39:32 +0000
Message-ID: <AED37DD2-ED49-4A05-A943-0CFAE5780DC0@oracle.com>
References: <20221207084309.8499-1-richard@nod.at>
 <20221207084309.8499-4-richard@nod.at>
 <92B44C88-61B5-4450-B027-60F9F7A614FF@oracle.com>
 <CAFX2JfmTqQaWf2cB8QY3vTGzrrMStTGmCGWgthoqVJmcwpz8EA@mail.gmail.com>
In-Reply-To: <CAFX2JfmTqQaWf2cB8QY3vTGzrrMStTGmCGWgthoqVJmcwpz8EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|BN0PR10MB4920:EE_
x-ms-office365-filtering-correlation-id: f66db8f7-42f1-443b-545c-08daddf1c6fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gA9P+T9y5VXlANKJFz2bmjM38FlNWuLXVXSfBqwLmLYUOYWtv0kvy0mRR4pslCBeAU/xjYCR0M7NsaVrHJpj9XN6REyBZjcrNqxTloWkTGUy95JtWUwbyijm6oBxEZ6Gw3G4EPIV02FJxKacKPFOqWfCSG7+qj8eK0gwwuvKGqPeYlo9anrvbdVWqmsDzDCUMgdEo2zKJWvib/vBdDccSpYnO/knjRpSKuseOr2JXRjUEhM6UQt9/71i4oyde3AsMopxhVku9w9J4JYMt5zBbNVeQzhYBjY6nYeRPj9sYbhRLuYcsSInpw/CzsKih7ZivGDFunas/9f4m0UcNGV+8C4IIReoVAU5ntLefecLX5N51Pwjblw1x+FLNqHvRBpvtkgjbXAvxTzMT4EF5unkMvgyk/Jr6yvTv0QRzNjhUJIPbkEvi2a6qoEyPnOD5BzVofhP4FPJzD1T1XWaWC/rOjahOcEE+uZr+uNlup17X3a91CoORxonZ1dRgOoXBs8BOlDfTEiVgQXPyp/43visfDki1RBJHwQYd71fmwRVqjnWT6qd+9pHYm6oFIhkzjmJT/m9n7YZeIuDHsaymeCiDNa0LINaahZp86cojaczpYptFt94lJKzQ2ZnSQfkegFquUu011Mdb9uhMC1tmVTZs35Te1+o6zFlfsbZ/Z425SxAtsyEAPCikIAZIwI/vOm3mfebNU8wp2gFQ9VIJfNIAJ/Xa4h3s3LoUxbAXjL50Lc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(2906002)(6916009)(54906003)(71200400001)(6486002)(36756003)(478600001)(53546011)(38100700002)(122000001)(83380400001)(2616005)(86362001)(186003)(6512007)(26005)(38070700005)(4326008)(316002)(6506007)(33656002)(91956017)(5660300002)(8936002)(41300700001)(7416002)(8676002)(64756008)(66446008)(76116006)(66476007)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Bw4fGK8WRAjMkjvVNErnObr0Whivn1c6mV/CJChxfcTWmDfdYio4cVD7ueh?=
 =?us-ascii?Q?oedjGjb5ZEmcCZElZWcPfXvbA8n+6TdDBZo8XFoLR2q3zHL7chS6kTJUdfr7?=
 =?us-ascii?Q?9xOw1LDXH4mpm2SQ9nywNYKN6HfE/47Pzn1SW18xibu5Ke91KCl5HOYZYaDy?=
 =?us-ascii?Q?stDy5cCm87ScjLyjJfK14hLNFV0T/WAp+6jcCi7VINHjb/eb8j3u0htEbGNj?=
 =?us-ascii?Q?G/wcPLaXMe8gEjYJQ18tlYbYEOQsaYApVSsxkw/EIKsz2rIafh/3p9iuX3fB?=
 =?us-ascii?Q?hhFqiFhPLoIVbiSz9qz93ZIKCTCzcP3IB39axrCClrs/EidJSeIRJhe7LHCF?=
 =?us-ascii?Q?VNJ7Ls0eTYqOjHCSdX7jVC8A9x/gsFmHFONrxCKYcFiiDrikd1nYFEQ56Yfr?=
 =?us-ascii?Q?UwTICmkX6dLIEpCWCkC6/9LXUvw/fiGOd1NGcVaWL6mZip5Rj2AaWh5sVsoB?=
 =?us-ascii?Q?R32ucibE1ujrUhlyCPXDlZJqfRe2iaAJU9giRkKsi1UKYeCRKb+7xHSPGJAq?=
 =?us-ascii?Q?53WtOPpZTnMLiydpLvFofKyJ3P1V66ZufdCbk9ZcfabvqZdbRRTiQsgtCcsG?=
 =?us-ascii?Q?4eJ3MItqlB4sUOBkA0TxbPrYA9N/T1MtT2Uz5cdPsfWbSoHj9REIXbH0CAPC?=
 =?us-ascii?Q?vCBjF4wn28y2tJYTEowxWRS6kKqy6k26lBMv3bAIjm6XUePDEvqhMkuxZuFo?=
 =?us-ascii?Q?nwGh28PLPQXNRqIYSykYM3fSGMR8pnD4GdDZnHZ0gVQIA8XYFGdV0wi/I+EW?=
 =?us-ascii?Q?4NYShqgdAy2c1rB51n8A4bujIDi1t++7Z4IPrrhrITDbfxD1PF4idP8BUwEz?=
 =?us-ascii?Q?/d3SvKxVyU0zUc/ru9h5mMl9nmGq9NLxYFjIxcGQW2yFDEmAoQ7IaHqgp0cz?=
 =?us-ascii?Q?dxDwiqkB35yC3xVc2cAQo8xKPnMx8Vf2muIIsgDu0+RdirAd1hSpmwIa5BAK?=
 =?us-ascii?Q?KqsMvP7MtzqD5zA7WKHxt7GU/q+Vq17MlxA+C2Use3LIMmK1OkGLRznCgv8f?=
 =?us-ascii?Q?1y8KERIVkuUAyVQ1r8x/IYXp3hoRGiWjXwP686Yu7SGT0CBSXOuF7n2h311P?=
 =?us-ascii?Q?obm+zn3M0eIvYipsA6PAI53mZEuBExnNBuAzG2NVc3aVaRoao/XJNl4pXRJQ?=
 =?us-ascii?Q?eKH0ghbEmenMoKYzFkn7Y6yWp3MqJl4lasNHnpa0A9JEEMJgiL71PrmnlAy9?=
 =?us-ascii?Q?n/+8ee+1oH0eWtGhHiLk9qJjaKmGCgTc5C8fxmEvj3JCRLvoMMVP95STobux?=
 =?us-ascii?Q?44lIqy9uG0DDuM496fkxBOqzk21xkc316L0D1+tj1JYp2wTPb9UbkPnKSDHZ?=
 =?us-ascii?Q?Y7+MWtAhlGum9Gl8fWUnIe78FvN66Qlj3N67CV2++7GcsTQEq3ej2u4NYu+g?=
 =?us-ascii?Q?6P4bBhTKfPRl3r8f+ibaWZrtDn+vWorLFwRRHRkvf7D//jj1znylY7+p0RTG?=
 =?us-ascii?Q?H3/xK3Ks1fl6tVhZ9mII1sy1j7i4ARZdTqkEHkEsc6tYfQgvYUxNwIc3zs9L?=
 =?us-ascii?Q?eaLcg+hwpK3MU5JeJGyjuPUjG5uPx1KYD5Fdrz00hZLTUtDimh7OMPX8+V3u?=
 =?us-ascii?Q?l51F27a7x+4mOtLtzWrlXcDaKo0w2xV3MLtuIZEggVZg9eJTvruBJvpOHsF8?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C974BCA9D6E95F4A936F03C6F79DD7DC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66db8f7-42f1-443b-545c-08daddf1c6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 16:39:32.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4rw3gYelW8DDeMbb/ho1b5hks+4vxB3MvpEhCSXrkDNMWoU8uCL5iInqm0oJdwwbe3PLYw3ouNtS/RYQ3DsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_07,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140133
X-Proofpoint-GUID: syPPFZeLwkLelbHptxiesC3L7YXMWmIf
X-Proofpoint-ORIG-GUID: syPPFZeLwkLelbHptxiesC3L7YXMWmIf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 14, 2022, at 11:37 AM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> On Wed, Dec 14, 2022 at 10:09 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On Dec 7, 2022, at 3:43 AM, Richard Weinberger <richard@nod.at> wrote:
>>>=20
>>> Now with NFSD being able to cross into auto mounts,
>>> the check can be removed.
>>>=20
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>> fs/nfs/export.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
>>> index 01596f2d0a1e..0a5ee1754d50 100644
>>> --- a/fs/nfs/export.c
>>> +++ b/fs/nfs/export.c
>>> @@ -42,7 +42,7 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max=
_len, struct inode *parent)
>>>      dprintk("%s: max fh len %d inode %p parent %p",
>>>              __func__, *max_len, inode, parent);
>>>=20
>>> -     if (*max_len < len || IS_AUTOMOUNT(inode)) {
>>> +     if (*max_len < len) {
>>>              dprintk("%s: fh len %d too small, required %d\n",
>>>                      __func__, *max_len, len);
>>>              *max_len =3D len;
>>> --
>>> 2.26.2
>>>=20
>>=20
>> I plan to take this through the nfsd tree, thus this one needs
>> an Ack from the NFS client maintainers.
>=20
> Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

Thanks!

--
Chuck Lever



