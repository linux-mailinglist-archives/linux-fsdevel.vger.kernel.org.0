Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51C732016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 20:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFOSc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbjFOScK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:32:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD630F1;
        Thu, 15 Jun 2023 11:31:23 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJlm6028526;
        Thu, 15 Jun 2023 18:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QPu6yIG38XO78m5RpOxOAg5APIHVRDVuy+CMI9WuV+o=;
 b=Pv9Q+GVO5TQAfW4QFej4w0oYaeTJBQzLk6lmz/dn3x1V7nczzZE+DkeDAYq8uFfMnUcp
 7bZQ7zs1L08OlgKNPpB8cD99MER64WT6YUBS65+xo962zX852wiWPLqa4VCJtIm2IurQ
 00asCfDhmZqSiBlABvs9f6XWGI/cbCrGOKi1MF71ivsfgFVeMNXyuD+iHdgQN0DhXHev
 imWwMYP6i9S/FlYt483ESd/SMe/0D6IoywrNjq1qf+Hu4vvR8z/qdXaS8mGGCzmb1u7u
 LqbeeF+hAynDemLvlYEq3c/MsRV/TjStb8F2zgi9W/0vS+zYyqHYRpZQDVOr3oGQuqMM sQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3btu1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:30:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FI3qqu033545;
        Thu, 15 Jun 2023 18:30:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7a4v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPiCNUqko31/Gn7hPFpc3zf0Ze+Psmof5k4UWSsz95dB+ZiVUqkeCrQXBIhWUBakny6LC8U/aMyG0+ECDQ3mEN2cfRhLuvh5UYIGgRYS9d4N/6jA5nElBSzgkcB2i8x21vMEoeFQoOw4vqdr+a+KGqyBysZ44e2NNVszVoI2jAHcMYJcJG7n8zhqrM/BPEE9Fyu98B/duI9+675MBXrGfu03W+QzjbtQ7JF4y2aQQKxozIdgH3YPnrdaaMFpObd5d3a1xjGvAGZevxM4tGAjtmYQK1rUwcM7DarZrp/AIdUyZjFeTVSQEzqAxIttftT5hQscKQemIX+JqjTc+Ri9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPu6yIG38XO78m5RpOxOAg5APIHVRDVuy+CMI9WuV+o=;
 b=hDHxj5CFbx1qpqdM3637FaxUoNT+yBVX//OaL5EyP1Uec3e35Xu5RTbWZXG2RCo+fvamPKPrex+Virs2ZvyncuNbMYU7WXiDGJbhnsXhcryMgH06UzvWdNLOG2KNCRAxVyWm+Ocsz7hupqAyLHvWp7JXD3AMd6AqTVDsXqy/ZLbUWo8vGPfQjLqXauAJzbYM7a5+Di94N8AwKSyvoo4AVOyiTo+YEDX5oPxAl253wI6nqVClWufGIphtS4k94qAf1KD2fQP7MPtJs24Z73jsR228dXDY961nQhXvqR/neFf91E66m9zyN/V/t6G9WiDL+hiCZZzDTpWUd8f0y7wlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPu6yIG38XO78m5RpOxOAg5APIHVRDVuy+CMI9WuV+o=;
 b=zHluxoAaMoLodwBgVNbVaRTezkmhP84fEEDExrovOG8wb6uFa7WwduFyPoD2CPP2SVeGQKHUjDIvxP3aI9yq7fLsX9BlAikw0HI25bwnQRvfZuxBk9KxOwIC4YQtImFAiaeJuiNp9psR7J6XxjC8XiQ6r7Aulukt/2AlUaRX6rA=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Thu, 15 Jun
 2023 18:30:39 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:30:39 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/11] md-bitmap: cleanup read_sb_page
Thread-Topic: [PATCH 07/11] md-bitmap: cleanup read_sb_page
Thread-Index: AQHZn1W5sDmmI/etAU+mfS1oNvuVa6+MMD8A
Date:   Thu, 15 Jun 2023 18:30:39 +0000
Message-ID: <F5E3D52A-A0E1-4B6B-BF4E-13F52D71DB91@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-8-hch@lst.de>
In-Reply-To: <20230615064840.629492-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|PH0PR10MB6981:EE_
x-ms-office365-filtering-correlation-id: b446a2c0-1f37-46e4-e0ab-08db6dce9e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83Ls2eyGXjO13hs+j1jMeeQ9Y8vLIRJOvXNkFQ4CdBkTjXw1V9Dczv2xBpgMEN0pXRg295PtrBgySixTwSchs2J/LwpanVz8o2RZIAGnha7gZt500atMLN/c9RVd3D3XyYKaeNYvfNDw8cWt14ovUViPkGwbb5hDx9n5WBD3QxkgITdvfzmPhIw4GHYjS+84DVZtctziBuX+afwufxPO4E6oemno1NWi7WjZwZSUF43EYLpL93K/RFeVtCzrNwKJ+ABMelYBA7gXGNAFLbB5T1/qRFcyGr89u71DVs1gZFg1uSygEWAjdrpTBakvot5Fw0zh9rMVosMu3ZrjMAJ20VVkBQFo2lpmyJb2GnW+AOYynSRQVmb47Z8IgPbGwBZGStd2C9LJWMNQJM5oNLc1926Tvt8hE/I8uUyK1SHea3aA2sCfk40MlSZ+7dzj6sUZ8vwTrbxaboFZiBcsXz7uhDe2xdrt4SAEwyd83a00qkmo5axnk9ok1tkfDDJ5wGZTWrVgcgVsSQDdtuR81fPhqvEKfMFt0kQ45DtQ7Nn6nnVu1Yc09BY4Dt/Yzr+2396TQpX7gslg8mPqGcvY7Hom8LtZyUjj0Pc2hncAWvww3S0vYzja31y+80rQ5WuewHgd0sdgN3jigLfU8POq3t08vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(83380400001)(2906002)(2616005)(36756003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(8936002)(8676002)(6486002)(316002)(41300700001)(5660300002)(478600001)(54906003)(76116006)(71200400001)(66946007)(91956017)(66556008)(66476007)(66446008)(6916009)(4326008)(64756008)(6512007)(53546011)(6506007)(26005)(186003)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QPecncBTXyLLReszcVxAmUDdRhRKhuz7PJnylO+1VjCilLddUbGAM/V/xmgy?=
 =?us-ascii?Q?QONkYY5Toig1ZStjuNgHKdxt4rLjaui/LoOnsCJ6fj95a9OsUPxMkIzTnQPl?=
 =?us-ascii?Q?J1SiEJBDoqIHmTLPfHnt6Ur9CreMsQp1kEPEfP74L2kNVwpdEQd8fSaOgvbO?=
 =?us-ascii?Q?loeAdhJDA9On4S5sE4Gc8pAYzHG7PPR04nRTDcFZbzYTS9iTmOtPywn6M18s?=
 =?us-ascii?Q?IC8SvLSnaUgTZU9qhFtfWuSDjzh8m5t3tsIK75ZzLmqZMd+r6QOI/AUFslte?=
 =?us-ascii?Q?odZBVVyAu+8BjFg7zxLemxgLn+uo+Bh2D2jA+40hpW9OpPGS9Gg47Qdg+rqV?=
 =?us-ascii?Q?M064Y3pbUznPaQDivnsjAYnClwmlDQAKn/luU2uhv0ojQAdX98MMnH0qynhL?=
 =?us-ascii?Q?3imCcuawhy0cPZHPiqkK+1Xoex91fX9oEFG7X3byNknvFyducqZJOb11H7Y0?=
 =?us-ascii?Q?Oxeauj/18nwQviuYEUWo0Us2PDmE33IvBW8tO/miUW4qyFmapmeA4gvHkE8p?=
 =?us-ascii?Q?u9jRqxorP1gRHU+o0ev8zlALnrGIruJ3YpY84cMIaqCHJUBKoTG5uqqdfpnW?=
 =?us-ascii?Q?7ix8Yv9N8XxM0Lb5BJ/m7bgGuIN+wEErY6aeMtSoN/0s/iSwNSctb9y2tXXk?=
 =?us-ascii?Q?xaUhVk3z4YTOtjkIFgd3OkJaN1A+eMvLdv0EixXyLeafKp1kCkVwhrV2dtbj?=
 =?us-ascii?Q?rktM2na/Yz4EP3tsyaFUH+GCFoLDHSCfDkvibGQ4SJbVR1VYQeZdL7Zr0uak?=
 =?us-ascii?Q?RoZiI0/gjjqNP7eBaykmMaPoMBvm+XWJ8sKyL3/Y9sXgjg7q8Kn45H2vKk5B?=
 =?us-ascii?Q?VWSQ7Zfof9lX0Lm05jyP2BYYxSVbhYIMjbTPVrSEAe2m55owaR/WPEcQ3ezf?=
 =?us-ascii?Q?LdIc9f94IEUsQd4Z/9TwG+TPzq24PPxYWMAkzh2wg+YTkL1EiDZeS4Ptp6xN?=
 =?us-ascii?Q?jvCnXHclJgJ8VrA/sUAeryqXIBrE91fX7QJbW/8ADY2A4G+uedyuJjYqD3y+?=
 =?us-ascii?Q?F8+iWMNE8CwkKZMjCVOjFJJPh5rqsaCT9+k13zHivTFaMiswDDFM3GTkFZ1O?=
 =?us-ascii?Q?OcLRdTVV86tL9L/2iDvhPquNvlRhORUzUi6nyJzsxMcBvyJQy8unnVqsmHgC?=
 =?us-ascii?Q?mE3G5fYkl408zCekFTsemvJuV6x5dcSBA5bpBYPzsHT+7TIYIz9LXHBw4iLI?=
 =?us-ascii?Q?f3BqR1vwR8lttcvVJ25aoNUzGZf2U8htQOGAF5VyahEnBOuTty0Zv80dNyVE?=
 =?us-ascii?Q?gIE3mxH6+xVLgSG7cXUeLjEH1mWExcZwde5Pa1pHNnO309K7taxDOHgSatuG?=
 =?us-ascii?Q?wMde4vq4aSKWUwRt1qduvm+f+yOcRO9JzH8f5rAXun9ZLoGk4NCHZ7SGZRlV?=
 =?us-ascii?Q?xcC6HHtOdagVI8Zyy95PlKwb0T0H4HLAdFwhVh1b6Dw86ky9nVrrhLfJP+Q4?=
 =?us-ascii?Q?pjUfegMhuezhwENKgQtGd9nD+H88uCLLLGm8ihDjtnQ+4wwZT4BsSMB+9VgI?=
 =?us-ascii?Q?Oat2ttoez8/DQLmE91pA+p7Us7h9LvaG2mGEyfzYTgKLfEyHmhaI9cbfPOK/?=
 =?us-ascii?Q?j4v1h/c7xJoD3LDhkIXwvHs+NWmi3NgRxWKPRwkatUOWxMblm9JLx3Ne/Ttg?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F06CC793BEC194CB64DF83EF0643F8B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JB5jM8dJ84/IjgPHVtcloktLdG57WGMEZqleMWDcLjOSQCgOju1pjNeLHCJmRONvRRpgBJsZvbZc7lK7+rRnN0uoDmVu847VziS004GTHdouVqOsy7ERKSJK0lnmtRmILLMyC7N3R5F7mC94NNvxjbIvdB2xXRnyA7CSYcwwda3zCeEUtjfCE/LbdoxeSfR3EJvCCrs87jDwXmreFtjHBkjqbWWDSKiNLUOj8FqlZbO+itU3gmspzq31gJvik1SNHAiIb4NAjvQ5vmi/Cf7TPjAQEmeR4HcmGj48TnSF9TTDP5HLRvPYy+o/lef4M6TCgtoWH6Q1zMnbpjqsWj2OOf36EkOimCPe/9CcWbcS/yls43ZN0I7V5LU34DYav9mDrUaM04aT02/Tiu0PtyRM3/ENO6B/BUwFUrw6NLzjm4jIzbrnguidLmxaIhr4SnDlIKyYt8ecKTg8iCc622lKlsfAD2ZD8MrMCi7Jhh0xIlXFk10QUZV8bbD8AL8CzR+SLrs8hwVy4ZdPHmRgm3h+FebUL8IRLbKUfw4aS6Ev5JWiQZMmcUsIhVyd6R2xVzogIA2dJSrBgu+A7jagFdRDvtOkAft+SxvIur6iuFb12k0SfAA2v52gzbE+LNHEO9FFUrOU9bZ4Sf5ifx9ybXFpAa06WWuzoD99ziXRBK+A5nAF0Ls4OEwHuC7lYx0vmGpnTGOr5QH1ONqcwK30zjVwMay1IuwF/zhZARlBRPxhHVn2PBfMMb8NOOTxsif6FHiWfTXBkUN8N15T+S/SSuPtBSdzWNRFAZd+nP01xdyYvsja5XYnDZdmdd0KjQc5X1hF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b446a2c0-1f37-46e4-e0ab-08db6dce9e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:30:39.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9IIUbd0gCwDCSMf95rlovqrbd49CBGymGkuNbVb7nfdO7joCHrEk/3TPhVGeXenyq7Fa8n5JnuEh+5po56HpETKTqMuSAXMgIXuXYJ8WOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_14,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150159
X-Proofpoint-ORIG-GUID: LXO4ciyPiwWlRHOgHu6ZeVMPCTVRiv0h
X-Proofpoint-GUID: LXO4ciyPiwWlRHOgHu6ZeVMPCTVRiv0h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 14, 2023, at 11:48 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Convert read_sb_page to the normal kernel coding style, calculate the
> target sector only once, and add a local iosize variable to make the call
> to sync_page_io more readable.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 23 +++++++++++------------
> 1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 1f71683b417981..f4bff2dfe2fd8f 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -139,26 +139,25 @@ static void md_bitmap_checkfree(struct bitmap_count=
s *bitmap, unsigned long page
>  */
>=20
> /* IO operations when bitmap is stored near all superblocks */
> +
> +/* choose a good rdev and read the page from there */
> static int read_sb_page(struct mddev *mddev, loff_t offset,
> - struct page *page,
> - unsigned long index, int size)
> + struct page *page, unsigned long index, int size)
> {
> - /* choose a good rdev and read the page from there */
>=20
> + sector_t sector =3D offset + index * (PAGE_SIZE / SECTOR_SIZE);
> struct md_rdev *rdev;
> - sector_t target;
>=20
> rdev_for_each(rdev, mddev) {
> - if (! test_bit(In_sync, &rdev->flags)
> -    || test_bit(Faulty, &rdev->flags)
> -    || test_bit(Bitmap_sync, &rdev->flags))
> - continue;
> + u32 iosize =3D roundup(size, bdev_logical_block_size(rdev->bdev));
>=20
> - target =3D offset + index * (PAGE_SIZE/512);
> + if (!test_bit(In_sync, &rdev->flags) ||
> +    test_bit(Faulty, &rdev->flags) ||
> +    test_bit(Bitmap_sync, &rdev->flags))
> + continue;
>=20
> - if (sync_page_io(rdev, target,
> - roundup(size, bdev_logical_block_size(rdev->bdev)),
> - page, REQ_OP_READ, true)) {
> + if (sync_page_io(rdev, sector, iosize, page, REQ_OP_READ,
> + true)) {
> page->index =3D index;
> return 0;
> }
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

