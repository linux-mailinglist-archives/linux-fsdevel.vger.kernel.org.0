Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A12576721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGOTIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOTIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:08:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9754648E94;
        Fri, 15 Jul 2022 12:08:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGQO9V024328;
        Fri, 15 Jul 2022 19:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s9IStN9xC7dHVvHwVRsRLrbYYtvfDyQ4ljApgUJsePE=;
 b=mSVOt1Kz+GMP3yIy9fzZRLPymSZrijb8V+6GfK32iaDIjtVBwILKjLYT25iHSKxVFxab
 vbDjgSyRkM9zEoZFLleUP5O8dzGqhhrYigdsujN6J52HfjhkKL20zpyzUc3j0Sj8nP49
 WukeGWbvNowf8jIaG8FgmHo6JLSWdTWsoKrwb1MrjUwIbrSPUgvnUb45O43iZ32cXewd
 fWGxIGsxsYmSOrq79FrWFeS7NmGISrtj0J42CDadiT4aWJJJVZuzHsnvIZtEmQrQCVvv
 0McYX3y+j2FAlDxmvj0HqiQ9mD05/AYeYNlE+X9lhkIIrqb14LEkXL9J65KTPeQwkQs+ QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727ssbkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 19:08:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FIjjP0001972;
        Fri, 15 Jul 2022 19:08:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7047q7hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 19:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJV/GsA8EzcgVGmYXFKjfB76L/k27jYvbsGN//cgBZCa/ptG77NlgrKblzJxnQHM45Vt09vjR+jmfSECzm2P9vLbxbLfkYQ/UH+JMACA56fcHFqFjbTGxu//vMq53ZabgkLHE1X2IfzEOnWmv3Dc867XF8exzBij89Ixce6Wzg4AqjjsUjIw7WSpDMP9NRyJZocUsz7CWhu5Qqqva7F1bBb7mAL/tkMc/5V22em9LAC1J8y8xW50MXv7gxfB9kvyrukO3yxwhLrMxesjz+f2qyoZ8B9pvH0N2hZLuQifOqX5hKg4bFYoXJL6xeMlre10JXRUyv4KPbG4YIbH/OSYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9IStN9xC7dHVvHwVRsRLrbYYtvfDyQ4ljApgUJsePE=;
 b=dtNigjZTWKVLuIXkfZHguFDc/5ujxp2TFXbExM/jCmVrmZThj0mpQVqfAVTDdintu4zvTARMQT+4npwvSiY7KsEi17EeXpqBbRK2dSQjYUqRjfQf9fcblih+/XYWIRDv2PzB2rSolQhfZR3N1gDHO8JCX6gT+Rh6XcKQSI5F8lz0sTx0xVv1R9Zkk3as/eJuOTM7TvouCq17wbmzgWQnqCRq5Be4rFjl3JsPOnqXD8xjUXSIJ4cfiXTxvrpdYL+GDcyb+uqmjv+H6RkJ3+54Xe+0CXAfcjVaPsgen4kLPMu88bAMHu5XExiLuaS8IhvjD5/pol+2/B11bC5EIMLwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9IStN9xC7dHVvHwVRsRLrbYYtvfDyQ4ljApgUJsePE=;
 b=f0dpOjHRmCAKq2FKnC6lqBS7t1NLC0RA4ZozXqZy7ky/cHsyPMaLyZcpfr+lIzPL+NlmNGJY0WhI6bCvvydLH7HBg8GeApYSAsd49MbEIKZWNZ6I5HpIniFBp9S/8PlJz4q8BjHJ6pWftKH7t1DkrWwrf3kfBo60HXrK/8fJ87c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2339.namprd10.prod.outlook.com (2603:10b6:405:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 19:08:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 19:08:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34A
Date:   Fri, 15 Jul 2022 19:08:13 +0000
Message-ID: <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
In-Reply-To: <20220715184433.838521-7-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f4c09ad-b823-49d4-055c-08da66955d81
x-ms-traffictypediagnostic: BN6PR1001MB2339:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcX/S5t2YjznXTJ2sCCgNfH62+8S2etYPjFi2GoM7MWSc1NWpMXz2jxd9KnCNRoNH3jP1i7MjSFNivHZRBx88p9rucXzZCgw9OVcbUZcIwjne1DvCcCqIxayc7nje8dQAxFQ0zMLBhgSRx2liQa0Ul9Q2bhY9p2TU7Jbnz/2VR2uzKv767PvW4l6e2F5rjiZI3d5LwAo73MheX6FEcf7anGPEWWIuldyTd+D6rESoC5HuE7xUW5b6qGHVdD8wpGcuWGAAwW7pJU859Acb5X+doheqjhAtNZgFEqwlP/4376CcUgzw+A6ZYDJA+RwDRVbMkSvDTmsg0P6WKUk0F8RIlf7l7B/P6NYpoz+BQEIy8/emf3C3XqAaH99ZSJQJf/6vyt1oPcO0RvOKBhMZZREmxSzmu3M9Rf0JH3yQdaoOYZwpIiSYT/50ftK4qJpHceyMf4pSl/z0z+4jChJiG59+YtXSNOexK4QNtgb59fVDPHVrpCHSsKosSO516KXto21xgvhm16b0zefdFzSiRKC4fN2wmdpmm2FSYAOGW68bRWreO00P9kUT5EM5P6oFg0+cgHULk4a6r8qBjxSkbbs9X+j6zANC3f035sJNoRB0JAywKOZaTF/44HQzWoBTLwItqbgSK7jEL+X85tHAfSNqKXNNlKoCzkPXq1b946cOxdPmmN7xAbCz+LR9Cwf8rjC3UbTnP4ZNvCEqW9LNQ6gl69CuV2qCZga8WR+LdyoyHFZvnczsgdTD0O2Ez6xk85AvhQDy4LVsc3Z+QmiMxgbEDi23fwYlGBtTZDDaG/5pcOSQhHS5bKVKZSyjPB55jeWBNLYJVDB0mBZyspcF55Cm/nyX3WRJJgLgFdMm0hzuks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(376002)(366004)(6512007)(36756003)(83380400001)(2906002)(26005)(6506007)(186003)(53546011)(30864003)(41300700001)(71200400001)(2616005)(5660300002)(6486002)(478600001)(4326008)(66446008)(8676002)(66946007)(64756008)(66556008)(66476007)(38100700002)(33656002)(8936002)(86362001)(6916009)(38070700005)(122000001)(316002)(91956017)(54906003)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nsx8VanD5rynpxkaTjNzUR3ADujSF94RAja1UiQhdeia0JDNWE28g3GVHKMY?=
 =?us-ascii?Q?jWGy+TsBuz0qR3xykT/OeiCyIQMVmKeF++pJRjQoBL1bERP6B+1LFQrp25Is?=
 =?us-ascii?Q?3TQOWYZ+mtj+h5Y0RtLPLMlKhYXke/r/w2q15OXLD+9IFXFtaDcZsvtHqXnV?=
 =?us-ascii?Q?nkbM68UXy9H4CmPRUJrYqJ7aXgPyav7Z4ZxUe/GfdgdyYnH3dIBcGgtM1Zr6?=
 =?us-ascii?Q?X5uiBRGmm618GZ4+JVbCLQ0FDdSxXlwHsUL8snYmuT9ww3J8+RcYWFf9Cjou?=
 =?us-ascii?Q?raERvy37me4EzSHcfRC2mm6BpnAPoyPLhqyeeFX2KM3peyimcis8UFTv9b5h?=
 =?us-ascii?Q?0FmQvIb8OZM2exRsu2fiYcNzisV5Gts2PKII9sgsr52S0rIbPaaENXX/YPDm?=
 =?us-ascii?Q?M8ZZRqGXLOD9NLALnQFbV0qOKMQ0ev97Hi1M4klDQ3Dlxq3BJGhxP6FpW8+O?=
 =?us-ascii?Q?I1dnjjzzjdht9cS74qxOWHnM6R1SYR8uI8jNnqBbYsrwgE4g454f7V62OIn7?=
 =?us-ascii?Q?GIWNBGSafQ2XidfqBFOPaBu1BBQcpXmTBAAj0y0EAMDVc/RjL9EF9+W1mAQX?=
 =?us-ascii?Q?l8UWcLna87UyT1g16CDj8+hAcQmbtqI0UTqr2wyBk4jYeOroNHL084Wp1XhH?=
 =?us-ascii?Q?tMGaxQ17lVUFsjy7tHtNYNeb4pkKamm2oiSpYhjUgd0qu97VPuBcjp9iBp/f?=
 =?us-ascii?Q?wfGSbMj/bBwbFbhsAqJzx0OtUu2ii0z6bn2mdo1KIvY3Nw8fJ3R3wlic0PMC?=
 =?us-ascii?Q?PLzydyIc+YYeWXPVinr+lpi9fMOe9b/WMtKL2I4LJC+R09BHp2w8cHVp2dGf?=
 =?us-ascii?Q?sJu3jpluibxuIbGD96Ez9LP2jUDY2eOKEiNSusZcBjQbbQ4qeC+a9BSFCswS?=
 =?us-ascii?Q?a3dWPsjtg/rnQiQH9j2d1pWwcBEYlFZMGNq0+xoAB43WMu8LkXrT88jXm078?=
 =?us-ascii?Q?oPlbD3ATSokLsxiC78Zxg63mzSq5gvw70iNRWS9Pz33vcj1HmbWufGfo6MCm?=
 =?us-ascii?Q?7Ko7hcEJgVvA1E+KwIIVjykz9/hiuTHyb/1PgVDuyU3khGQ6ovmGLFYqXKdC?=
 =?us-ascii?Q?cgfUjkwc8dfzAslUPUyhxwtAjaowIWkE/gsw2UW6hjAa//bRIIP7qKY27JSd?=
 =?us-ascii?Q?rLXVy+HKMK1o/yyo1Ibw/f7124oTEcC5nmW0Sz2Ntf8uhc5OOi3NLCGnhTYL?=
 =?us-ascii?Q?s8Kc9KcqakNab+sMRrz3ke6ZHsfqYlmFla4IAzmsGBu5yo8V7nG3hGt1HIYA?=
 =?us-ascii?Q?BSF+4etgxuol1SfG/wlD4P3rGt8ZpUwZuXRhxSfFnfcx8klSB77sJwOu+sXi?=
 =?us-ascii?Q?eszYZF/9TtQRZieMzfs/KJM7qxCPyyjsXzOwOzLYkTbBx8PqjCa+wApgB15T?=
 =?us-ascii?Q?/IRNKgtET+bGujiJsIn6eWbVVXlzbmx+UBJCoTRGYRSXw6pUANCdEnQctB8N?=
 =?us-ascii?Q?28QNlBcdmNHJavQUxxgjWRKqtYtnYRttZ622lEW9xmEivfw0BxYBVNWUozPI?=
 =?us-ascii?Q?mlptbV242DlmH57U4ojY1jT1Ycy8PdkPBx2HFKUm1pAdUgoMpaO79RDekNGH?=
 =?us-ascii?Q?6dkv4dBTxCjx1fE4JU3Pwr0bxjw4jdakc1HaWvoQWOUlG68Ag4WH+FF3w61B?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F5F9F58EE1E074CBFFA4A374A35D1E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4c09ad-b823-49d4-055c-08da66955d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 19:08:13.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhcuS4SGMmi+WhdYZy1XxZDkrq/+WccGKxy0ExOG8oiCU4Y//9KKajVM832Ycta+xDne1IFwOBYlFwP2cWk8xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2339
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_10:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150084
X-Proofpoint-ORIG-GUID: FZfLftvK02dAx4lCMbxNYb5Ml-1pLPIE
X-Proofpoint-GUID: FZfLftvK02dAx4lCMbxNYb5Ml-1pLPIE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Rather than relying on the underlying filesystem to tell us where hole
> and data segments are through vfs_llseek(), let's instead do the hole
> compression ourselves. This has a few advantages over the old
> implementation:
>=20
> 1) A single call to the underlying filesystem through nfsd_readv() means
>   the file can't change from underneath us in the middle of encoding.
> 2) A single call to the underlying filestem also means that the
>   underlying filesystem only needs to synchronize cached and on-disk
>   data one time instead of potentially many speeding up the reply.
> 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DAT=
A

Thanks for addressing my cosmetic comments! Looks good.

I'm still not clear why NFSD needs to support filesystems that
do not support SEEK_HOLE/DATA. I'm guessing this is just a side
benefit of the memchr_inv approach below, not really a goal of
this overhaul?

One more comment below.


> I also included an optimization where we can cut down on the amount of
> memory being shifed around by doing the compression as (hole, data)
> pairs.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4xdr.c | 219 +++++++++++++++++++++++++---------------------
> 1 file changed, 119 insertions(+), 100 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 61b2aae81abb..df8289fce4ef 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4731,81 +4731,138 @@ nfsd4_encode_offload_status(struct nfsd4_compoun=
dres *resp, __be32 nfserr,
> 	return nfserr;
> }
>=20
> +struct read_plus_segment {
> +	enum data_content4	rp_type;
> +	u64			rp_offset;
> +	u64			rp_length;
> +	unsigned int		rp_page_pos;
> +};
> +
> static __be32
> -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof,
> -			    loff_t *pos)
> +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read =
*read,
> +		      unsigned long *maxcount, u32 *eof)
> {
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file =3D read->rd_nf->nf_file;
> -	int starting_len =3D xdr->buf->len;
> -	loff_t hole_pos;
> -	__be32 nfserr;
> -	__be32 *p, tmp;
> -	__be64 tmp64;
> -
> -	hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	if (hole_pos > read->rd_offset)
> -		*maxcount =3D min_t(unsigned long, *maxcount, hole_pos - read->rd_offs=
et);
> -	*maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->=
buf->len));
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
> -	if (!p)
> -		return nfserr_resource;
> +	unsigned int starting_len =3D xdr->buf->len;
> +	__be32 nfserr, zero =3D xdr_zero;
> +	unsigned int pad;
>=20
> +	/*
> +	 * Reserve the maximum abount of space needed to craft a READ_PLUS
> +	 * reply. The call to xdr_reserve_space_vec() switches us to the
> +	 * xdr->pages, which we then read file data into before analyzing
> +	 * the individual segments.
> +	 */
> 	read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxco=
unt);
> 	if (read->rd_vlen < 0)
> 		return nfserr_resource;
>=20
> -	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> +	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
> +			    read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
> +			    maxcount, eof);
> 	if (nfserr)
> 		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount))=
;
> +	xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
>=20
> -	tmp =3D htonl(NFS4_CONTENT_DATA);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> -	tmp64 =3D cpu_to_be64(read->rd_offset);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> -	tmp =3D htonl(*maxcount);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> -
> -	tmp =3D xdr_zero;
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> -			       xdr_pad_size(*maxcount));
> +	pad =3D xdr_pad_size(*maxcount);
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
> 	return nfs_ok;
> }
>=20
> +/**
> + * nfsd4_encode_read_plus_segment - Encode a single READ_PLUS segment
> + * @xdr: pointer to an xdr_stream
> + * @segment: pointer to a single segment
> + * @bufpos: xdr_stream offset to place the segment
> + * @segments: pointer to the total number of segments seen
> + *
> + * Performs surgery on the xdr_stream to compress out HOLE segments and
> + * to place DATA segments in the proper place.
> + */
> +static void
> +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
> +			       struct read_plus_segment *segment,
> +			       unsigned int *bufpos, unsigned int *segments)
> +{
> +	struct xdr_buf *buf =3D xdr->buf;
> +
> +	xdr_encode_word(buf, *bufpos, segment->rp_type);
> +	xdr_encode_double(buf, *bufpos + XDR_UNIT, segment->rp_offset);
> +	*bufpos +=3D 3 * XDR_UNIT;
> +
> +	if (segment->rp_type =3D=3D NFS4_CONTENT_HOLE) {
> +		xdr_encode_double(buf, *bufpos, segment->rp_length);
> +		*bufpos +=3D 2 * XDR_UNIT;
> +	} else {
> +		size_t align =3D xdr_align_size(segment->rp_length);
> +		xdr_encode_word(buf, *bufpos, segment->rp_length);
> +		if (*segments =3D=3D 0)
> +			xdr_buf_trim_head(buf, XDR_UNIT);
> +
> +		xdr_stream_move_subsegment(xdr,
> +				buf->head[0].iov_len + segment->rp_page_pos,
> +				*bufpos + XDR_UNIT, align);
> +		*bufpos +=3D XDR_UNIT + align;
> +	}
> +
> +	*segments +=3D 1;
> +}
> +
> static __be32
> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof)
> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> +				struct nfsd4_read *read,
> +				unsigned int *segments, u32 *eof)
> {
> -	struct file *file =3D read->rd_nf->nf_file;
> -	loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
> -	loff_t f_size =3D i_size_read(file_inode(file));
> -	unsigned long count;
> -	__be32 *p;
> +	struct xdr_stream *xdr =3D resp->xdr;
> +	unsigned int bufpos =3D xdr->buf->len;
> +	u64 offset =3D read->rd_offset;
> +	struct read_plus_segment segment;
> +	enum data_content4 pagetype;
> +	unsigned long maxcount;
> +	unsigned int pagenum =3D 0;
> +	unsigned int pagelen;
> +	char *vpage, *p;
> +	__be32 nfserr;
>=20
> -	if (data_pos =3D=3D -ENXIO)
> -		data_pos =3D f_size;
> -	else if (data_pos <=3D read->rd_offset || (data_pos < f_size && data_po=
s % PAGE_SIZE))
> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size)=
;
> -	count =3D data_pos - read->rd_offset;
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> -	if (!p)
> +	/* enough space for a HOLE segment before we switch to the pages */
> +	if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
> 		return nfserr_resource;
> +	xdr_commit_encode(xdr);
>=20
> -	*p++ =3D htonl(NFS4_CONTENT_HOLE);
> -	p =3D xdr_encode_hyper(p, read->rd_offset);
> -	p =3D xdr_encode_hyper(p, count);
> +	maxcount =3D min_t(unsigned long, read->rd_length,
> +			 (xdr->buf->buflen - xdr->buf->len));
>=20
> -	*eof =3D (read->rd_offset + count) >=3D f_size;
> -	*maxcount =3D min_t(unsigned long, count, *maxcount);
> +	nfserr =3D nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> +	if (nfserr)
> +		return nfserr;
> +
> +	while (maxcount > 0) {
> +		vpage =3D xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
> +		pagelen =3D min_t(unsigned int, pagelen, maxcount);
> +		if (!vpage || pagelen =3D=3D 0)
> +			break;
> +		p =3D memchr_inv(vpage, 0, pagelen);

I'm still not happy about touching every byte in each READ_PLUS
payload. I think even though the rest of this work is merge-ready,
this is a brute-force mechanism that's OK for a proof of concept
but not appropriate for production-ready code.

I've cc'd linux-fsdevel to see if we can get some more ideas going
and move this forward.

Another thought I had was to support returning only one or two
segments per reply. One CONTENT segment, one HOLE segment, or one
of each. Would that be enough to prevent the issues around file
updates racing with the construction of the reply?

Just trying to think outside the box. I think efficiency is the
point of READ_PLUS; touching every byte in the payload misses
that goal IMO.


> +		pagetype =3D (p =3D=3D NULL) ? NFS4_CONTENT_HOLE : NFS4_CONTENT_DATA;
> +
> +		if (pagetype !=3D segment.rp_type || pagenum =3D=3D 0) {
> +			if (likely(pagenum > 0)) {
> +				nfsd4_encode_read_plus_segment(xdr, &segment,
> +							      &bufpos, segments);
> +				offset +=3D segment.rp_length;
> +			}
> +			segment.rp_type =3D pagetype;
> +			segment.rp_offset =3D offset;
> +			segment.rp_length =3D pagelen;
> +			segment.rp_page_pos =3D pagenum * PAGE_SIZE;
> +		} else
> +			segment.rp_length +=3D pagelen;
> +
> +		maxcount -=3D pagelen;
> +		pagenum++;
> +	}
> +
> +	nfsd4_encode_read_plus_segment(xdr, &segment, &bufpos, segments);
> +	xdr_truncate_encode(xdr, bufpos);
> 	return nfs_ok;
> }
>=20
> @@ -4813,69 +4870,31 @@ static __be32
> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> 		       struct nfsd4_read *read)
> {
> -	unsigned long maxcount, count;
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file;
> 	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> -	int segments =3D 0;
> -	__be32 *p, tmp;
> -	bool is_data;
> -	loff_t pos;
> +	unsigned int segments =3D 0;
> 	u32 eof;
>=20
> 	if (nfserr)
> 		return nfserr;
> -	file =3D read->rd_nf->nf_file;
>=20
> 	/* eof flag, segment count */
> -	p =3D xdr_reserve_space(xdr, 4 + 4);
> -	if (!p)
> +	if (!xdr_reserve_space(xdr, 2 * XDR_UNIT))
> 		return nfserr_resource;
> 	xdr_commit_encode(xdr);
>=20
> -	maxcount =3D min_t(unsigned long, read->rd_length,
> -			 (xdr->buf->buflen - xdr->buf->len));
> -	count    =3D maxcount;
> -
> -	eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> +	eof =3D read->rd_offset >=3D i_size_read(file_inode(read->rd_nf->nf_fil=
e));
> 	if (eof)
> 		goto out;
>=20
> -	pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	is_data =3D pos > read->rd_offset;
> -
> -	while (count > 0 && !eof) {
> -		maxcount =3D count;
> -		if (is_data)
> -			nfserr =3D nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
> -						segments =3D=3D 0 ? &pos : NULL);
> -		else
> -			nfserr =3D nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> -		if (nfserr)
> -			goto out;
> -		count -=3D maxcount;
> -		read->rd_offset +=3D maxcount;
> -		is_data =3D !is_data;
> -		last_segment =3D xdr->buf->len;
> -		segments++;
> -	}
> -
> +	nfserr =3D nfsd4_encode_read_plus_segments(resp, read, &segments, &eof)=
;
> out:
> -	if (nfserr && segments =3D=3D 0)
> +	if (nfserr)
> 		xdr_truncate_encode(xdr, starting_len);
> 	else {
> -		if (nfserr) {
> -			xdr_truncate_encode(xdr, last_segment);
> -			nfserr =3D nfs_ok;
> -			eof =3D 0;
> -		}
> -		tmp =3D htonl(eof);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> -		tmp =3D htonl(segments);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +		xdr_encode_word(xdr->buf, starting_len, eof);
> +		xdr_encode_word(xdr->buf, starting_len + XDR_UNIT, segments);
> 	}
> -
> 	return nfserr;
> }
>=20
> --=20
> 2.37.1
>=20

--
Chuck Lever



