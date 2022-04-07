Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657074F8B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 02:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiDGXrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiDGXru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:47:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A414FFFC;
        Thu,  7 Apr 2022 16:45:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237Jv8fQ005378;
        Thu, 7 Apr 2022 23:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mjiKmG+XN7uJjpAiiJamHdmADPIFDL+/tVWGiL1btRU=;
 b=etktji+kTFQBeUYW+WoMmWD6V3ICEzfG39NAWhsBD8406hIS+pvdPPscnZTZ9MRoiw5g
 6cGe6z4Ru2MYZLZxG1dDVyyHLuM55f9Wqb4wCnvGzzNJwDmdrmLbVdqgQcXfww6dXuAH
 3KLt3Bkh/YIfC0Y/mga7nfi6IDfHFbpPnHGP8i9BlBPgfzlddq4Ragw+AVoa9d0xROWZ
 rW9vBRezW5pmHzZump0ndU2TeMa3UUDKae+CBRWP5ByC8+/pCWSX88Tt2SajfKtUOp+Y
 EKCpbYzWo5TCZ/zGR+tSyRxcOw/bSY/7mnzbXQCM+c7jCW5cgd+/6RK9y72KGgcSl6Gy Sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d935dqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 23:45:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237NFvcN031735;
        Thu, 7 Apr 2022 23:45:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y87wk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 23:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdidiGkQpqa1K19D2aaMFiUYo8jeHTPHu3dQ0dAX7Mmc8on/OLn3K1mYxngueDokybfQ+Y3Nw0g5oI2FJl+IIE1hngUIXgo0QlRkvupRTopPGsUthKJ7jMiuvRMNq5585ryU3pijm9SewDqleCD2tgKjksFuCl6EUNIPqqUCeyikxH5ZxWSInw3Gb1y50Us1nYYeItFID5iUxl2WdzpuDwNaAi5SHVGBQ/bHslsMqph709Hd4KUPSW4Rvnr78zXlt08s7zibEnEzWRjjhHPgze669tT0cnHDtYURp89AUbZ5RTFx0TaZ6Du7qzzDD80X/uHCgaWAcPvNtLPpN25eGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjiKmG+XN7uJjpAiiJamHdmADPIFDL+/tVWGiL1btRU=;
 b=VgT2qA2gQtSmOiGigEeFNN3KdM0IxP4KqRjqPac9jQmyylCG9CGXBxto4UCZAKmm7N6WQIoS8/al+vUq8NeQN9DrrXYlJeH3LevQddzlOdBVzsTLPxtdP5QsO3whwabcUMH7qnFMufGnOqEf7qwdpumeRZADLH7UJ7W7Sf97rzLCE8cfDO0Nfkm9Outk/oypQYOlnNcACNe31jrVtCTSLkweLML/js0ds6u9SB9NK4BsLntVyICS6YyrIYjvssh7Uzs8IzXrE8ihQLYpGCIRCD7rZD2AOz+mFUwtb1NOMB0U9Zmp5CmaKRwQhu5MELimORRVWk/q+llcFSdCBA/54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjiKmG+XN7uJjpAiiJamHdmADPIFDL+/tVWGiL1btRU=;
 b=tCBeDO/qCH/FQUECxQE+RjvYeTOuNM0foe2Zj3ZF3TAyfruevOKrq/H4VrICXumbNVLVUbu3xNQOu+63R/Jo4eQeD06yDp1oQVvDHFheWeetWy94kpbHPizfl7osm7NcQNei0Cbt/4YfwJJRyH6bu1IEXXVN/a9sb25xMC0OzYc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3690.namprd10.prod.outlook.com (2603:10b6:5:150::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 23:45:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 23:45:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
Thread-Topic: Regression in xfstests on tmpfs-backed NFS exports
Thread-Index: AQHYSdpNL2d3Xru4B0OzHZJ1LCngEazjlm2AgAE//ICAADMPAIAAFfQA
Date:   Thu, 7 Apr 2022 23:45:31 +0000
Message-ID: <0017C60F-0BD8-4F5A-BD68-189EEDB2195C@oracle.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
 <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
 <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
 <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com>
In-Reply-To: <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58fd2505-94b1-4119-c5ed-08da18f0b3e9
x-ms-traffictypediagnostic: DM6PR10MB3690:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3690608023FADCAE8C02C07193E69@DM6PR10MB3690.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+xCesYxp0ahg1LkvZ1dFLAt96DMpM75XZJ1Bhw3A2EYxOfUebi26tx96+vLxkrweEEuV3DMBMPGU3WRwqLAq7dPIspUc6WkciJHaUrKKYy/GqlDsf7+8YzqRsd7tFin1N8SUSyxvHJoFA74dOPUg+CKrUvxoTk6PclPpH2GykE0V5W55ds3R8G+QEbZETQPghNVm2MC72snGW13+zgyAex2OF++Vx7HMuUIi1V//7Rw84zaHfuD4od1oQldE3d85ni40nDziackC+kdqBixc9l8iq/SkfL39LcMmYtNKJwstmkS53yI0PbgWlGyRSo0/v59UOl7s2g+lHvQOf7Akhys2+VCOf7v+UklhI7omZusWsv8lCEqgHKCFhuhdhPaUuuQG2V7sqy+oTDNnImdZDIKkUnN/NM7ff+AYET52Ur+u8dKotwKKuxkNlek8IXxGRhBP4/Vwv0QWpjlKJY9d8c1gtblEX20szdp+0zRAi8h8fNO86OAc4929wPRfsP5KPLvfpw6oYZHa0WIKQiW8lsVEI0sqJiGTJzfZkP1uHqs3LbeNihfbHlwM91CdOXnPL2AsIVVxibC138w2r5AfCnADzkuVF+LoChG+gOcxYUdqGvnNGPIq8JkDnSeHvuVniXjVu+eo9YU3EtKkJ7aTxSn2bScVaiTZoGd3t8DrX/FoIOtDpZ8JiPItYO9PZjVyMUT1bezvk/J79w4cA1BSNTGZLPwgVSROgWwbk60KIMScANuRjTrOoo0Gva1c1pD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(76116006)(53546011)(91956017)(71200400001)(6506007)(508600001)(6486002)(2906002)(122000001)(38100700002)(8676002)(66476007)(4326008)(316002)(66556008)(66446008)(64756008)(66946007)(6512007)(33656002)(2616005)(83380400001)(186003)(8936002)(6916009)(86362001)(5660300002)(26005)(7416002)(54906003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tnruoHhGzcb5TGWy+65FEvkj1Nefzcbsls//cNkXsSkvGHCIohbuoSYbd1Vn?=
 =?us-ascii?Q?EkNp2+cQV9PaK/IZOw23HeE+CutKwpRe69wkglhi5n+94DPeVQhDPIXfGXIG?=
 =?us-ascii?Q?y7d1TZ8DYT31VlECgKv3gxjjIjlcZU13jiMvItjRk/2aZAXBtWYnzKy9UlJl?=
 =?us-ascii?Q?5g22E5jpxrFE4ztVnpu/NXjHMAKQjyg61gSmbuSW5yDNKWeDHOffBWAbDFks?=
 =?us-ascii?Q?Lc/l31j/DOo5jHtmnOrRjTiPRMnDSkN1EkbzkzEvS9W3oOytUS+3BLa0y9se?=
 =?us-ascii?Q?dbCd7uetcBTujLTPUYZRHyz3qCxk9ClN0T7bG4zfseX5UYIlrmdvBgWK0//3?=
 =?us-ascii?Q?UwrPk9YgwX2I8OLePPMoANL4nMQbpFgnJX+FE26imapicNUfh5qlqZpqghBX?=
 =?us-ascii?Q?C6vG+jruJ3/AJfCOEulYstgSnXQD2y2kEPZW0HcPkhGpTYhI84xiw4f2yb8w?=
 =?us-ascii?Q?qDJSAe91dwkbM/a1+B0bwroYBbjeyuFCLsYB3L+t+qmLdQh8oX5M7Sx7SSs2?=
 =?us-ascii?Q?2N1qlam/hSQK1bzEEhkRZUAQDuqk+murYjJO21Eyy8I/KRSAsBAu4uxeG0TT?=
 =?us-ascii?Q?u+RDwqc6zReKHl1YP+BDtc6T2WqMU2Fe7mPzkcZBLsHXknkkmA8HPVjVEhmr?=
 =?us-ascii?Q?l98sGWAuxI8nbfig3pJVrQZA/S4fUIqu/HwgxFjM+CKJ7cLNGnyQdop9AjjH?=
 =?us-ascii?Q?Tqrv7PXuaCdnvwBkDB+6RgTHfsI4hyiMHnE1Udv97HIUUFVUK/daF7PTi2cV?=
 =?us-ascii?Q?ZB4rrTI1h93Za0XdHguKbi2/nDCeYUDnSf7JJut675irQHV8hOMf184rIlvr?=
 =?us-ascii?Q?y13JYXNlP8E3mmDSMeX+8mH3viN/YQKSePM7lGgV68mhaliXx0Z0IKGTO+PQ?=
 =?us-ascii?Q?392soLViS8gNrhvTFnEmappaDA8w/zrHF5tQC1/b0JtxtAneEbSflXsdG6na?=
 =?us-ascii?Q?zbeqtcWkWbl95dTCV4Dkufq59a0j60PluStx7OCAmbTClkYnCHsXBGuU33G8?=
 =?us-ascii?Q?zf1+TrvVLlkm/jGQ0aNAoUKCs2g+Lr231lX2dK9nnAAQ8dL35Kc8reqBDG4Y?=
 =?us-ascii?Q?lX3QjTjVpcIJT1zAAj5BR2RDyJ4CrFgmazk350ImbImJ+1wMYcQ3Fp8la4Ii?=
 =?us-ascii?Q?qCBwqk30tI9+qHMbs78jUP4zHoqzpufPNxB915IUuDy88/ACL/5lVkexLg72?=
 =?us-ascii?Q?L0Sey+P/Cw3RtA4JceLtxnAKXPsk7zbv6f17/MvkNu4uIoFscmDICGAjPX9M?=
 =?us-ascii?Q?P2EZtniEumfMdvQpJe0B1ycRqr4iEKGI1RXlftxqDOuDT80SVhpsgKldBJ6/?=
 =?us-ascii?Q?Twnsu1kRvsu/X4wkIhqyBne3HLsgIAgdoo3pGAr9bdj3BzqrQY6gGHtd/4V4?=
 =?us-ascii?Q?9o/+8hZ4jFjfguDkFcBX5aXfAgiBhGrlnQFDVZ08QDxOeiHkpZ5laPqjDdSe?=
 =?us-ascii?Q?zAgvtyI9VbfcY6eUKSLYLojU/sC/zantNqR5aQvrTdpIbRGB/5hFIWeyXcb+?=
 =?us-ascii?Q?uX7eppejp/B4fU+V97VdnBEAQcDl3UiAwyZSL9+w0gmjnv9IgZcWNBP1XjRZ?=
 =?us-ascii?Q?GwkRUbrw8Z/JhnbRy3WR6KT/dKL2NkEyJs+MNMOu96pBnSjbW5bEFiO0r3W4?=
 =?us-ascii?Q?Qt6FbrC3Rx/zGbjVpR3K6TWmnfxsCclHLilYKWtQrbdSwe+A7YYANhW4lPkj?=
 =?us-ascii?Q?0UGDvb/mJWqB8UY3ELtlyb7OPzkGaAkEYJVl+bbPRtJeoqW3cdlpRpNj/atH?=
 =?us-ascii?Q?3HdFnOFALc2NtRoA6RVgLZ2guB/gNG0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23A691C2654DA44D9C1A67A6440C0475@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fd2505-94b1-4119-c5ed-08da18f0b3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 23:45:31.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfE1XUvbiUEUKAiHH3/C9243OFYDffr9f5tHKlCfJoKLdKBvn7+wB/pAJ3otlilFWAEnOqILFembkbxcRobJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3690
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: DzUqBRGHRozXE8_9gRN9swpIJBnA1AUM
X-Proofpoint-GUID: DzUqBRGHRozXE8_9gRN9swpIJBnA1AUM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 7, 2022, at 6:26 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> On Thu, 7 Apr 2022, Chuck Lever III wrote:
>>> On Apr 6, 2022, at 8:18 PM, Hugh Dickins <hughd@google.com> wrote:
>>>=20
>>> But I can sit here and try to guess.  I notice fs/nfsd checks
>>> file->f_op->splice_read, and employs fallback if not available:
>>> if you have time, please try rerunning those xfstests on an -rc1
>>> kernel, but with mm/shmem.c's .splice_read line commented out.
>>> My guess is that will then pass the tests, and we shall know more.
>>=20
>> This seemed like the most probative next step, so I commented
>> out the .splice_read call-out in mm/shmem.c and ran the tests
>> again. Yes, that change enables the fsx-related tests to pass
>> as expected.
>=20
> Great, thank you for trying that.
>=20
>>=20
>>> What could be going wrong there?  I've thought of two possibilities.
>>> A minor, hopefully easily fixed, issue would be if fs/nfsd has
>>> trouble with seeing the same page twice in a row: since tmpfs is
>>> now using the ZERO_PAGE(0) for all pages of a hole, and I think I
>>> caught sight of code which looks to see if the latest page is the
>>> same as the one before.  It's easy to imagine that might go wrong.
>>=20
>> Are you referring to this function in fs/nfsd/vfs.c ?
>=20
> I think that was it, didn't pay much attention.

This code seems to have been the issue. I added a little test
to see if @page pointed to ZERO_PAGE(0) and now the tests
pass as expected.


>> 847 static int
>> 848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *=
buf,
>> 849                   struct splice_desc *sd)
>> 850 {
>> 851         struct svc_rqst *rqstp =3D sd->u.data;
>> 852         struct page **pp =3D rqstp->rq_next_page;
>> 853         struct page *page =3D buf->page;
>> 854=20
>> 855         if (rqstp->rq_res.page_len =3D=3D 0) {
>> 856                 svc_rqst_replace_page(rqstp, page);
>> 857                 rqstp->rq_res.page_base =3D buf->offset;
>> 858         } else if (page !=3D pp[-1]) {
>> 859                 svc_rqst_replace_page(rqstp, page);
>> 860         }
>> 861         rqstp->rq_res.page_len +=3D sd->len;
>> 862=20
>> 863         return sd->len;
>> 864 }
>>=20
>> rq_next_page should point to the first unused element of
>> rqstp->rq_pages, so IIUC that check is looking for the
>> final page that is part of the READ payload.
>>=20
>> But that does suggest that if page -> ZERO_PAGE and so does
>> pp[-1], then svc_rqst_replace_page() would not be invoked.
>=20
> I still haven't studied the logic there: Mark's input made it clear
> that it's just too risky for tmpfs to pass back ZERO_PAGE repeatedly,
> there could be expectations of uniqueness in other places too.

I can't really attest to Mark's comment, but...

After studying nfsd_splice_actor() I can't see any reason
except cleverness and technical debt for this particular
check. I have a patch that removes the check and simplifies
this function that I'm testing now -- it seems to be a
reasonable clean-up whether you keep 56a8c8eb1eaf or
choose to revert it.


>>> A more difficult issue would be, if fsx is racing writes and reads,
>>> in a way that it can guarantee the correct result, but that correct
>>> result is no longer delivered: because the writes go into freshly
>>> allocated tmpfs cache pages, while reads are still delivering
>>> stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.
>>>=20
>>> But unless someone has time to help out, we're heading for a revert.
>=20
> We might be able to avoid that revert, and go the whole way to using
> iov_iter_zero() instead.  But the significant slowness of clear_user()
> relative to copy to user, on x86 at least, does ask for a hybrid.
>=20
> Suggested patch below, on top of 5.18-rc1, passes my own testing:
> but will it pass yours?  It seems to me safe, and as fast as before,
> but we don't know yet if this iov_iter_zero() works right for you.
> Chuck, please give it a go and let us know.
>=20
> (Don't forget to restore mm/shmem.c's .splice_read first!  And if
> this works, I can revert mm/filemap.c's SetPageUptodate(ZERO_PAGE(0))
> in the same patch, fixing the other regression, without recourse to
> #ifdefs or arch mods.)

Sure, I will try this out first thing tomorrow.

One thing that occurs to me is that for NFS/RDMA, having a
page full of zeroes that is already DMA-mapped would be a
nice optimization on the sender side (on the client for an
NFS WRITE and on the server for an NFS READ). The transport
would have to set up a scatter-gather list containing a
bunch of entries that reference the same page...

</musing>


> Thanks!
> Hugh
>=20
> --- 5.18-rc1/mm/shmem.c
> +++ linux/mm/shmem.c
> @@ -2513,7 +2513,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)
> 		pgoff_t end_index;
> 		unsigned long nr, ret;
> 		loff_t i_size =3D i_size_read(inode);
> -		bool got_page;
>=20
> 		end_index =3D i_size >> PAGE_SHIFT;
> 		if (index > end_index)
> @@ -2570,24 +2569,34 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
> 			 */
> 			if (!offset)
> 				mark_page_accessed(page);
> -			got_page =3D true;
> +			/*
> +			 * Ok, we have the page, and it's up-to-date, so
> +			 * now we can copy it to user space...
> +			 */
> +			ret =3D copy_page_to_iter(page, offset, nr, to);
> +			put_page(page);
> +
> +		} else if (iter_is_iovec(to)) {
> +			/*
> +			 * Copy to user tends to be so well optimized, but
> +			 * clear_user() not so much, that it is noticeably
> +			 * faster to copy the zero page instead of clearing.
> +			 */
> +			ret =3D copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
> 		} else {
> -			page =3D ZERO_PAGE(0);
> -			got_page =3D false;
> +			/*
> +			 * But submitting the same page twice in a row to
> +			 * splice() - or others? - can result in confusion:
> +			 * so don't attempt that optimization on pipes etc.
> +			 */
> +			ret =3D iov_iter_zero(nr, to);
> 		}
>=20
> -		/*
> -		 * Ok, we have the page, and it's up-to-date, so
> -		 * now we can copy it to user space...
> -		 */
> -		ret =3D copy_page_to_iter(page, offset, nr, to);
> 		retval +=3D ret;
> 		offset +=3D ret;
> 		index +=3D offset >> PAGE_SHIFT;
> 		offset &=3D ~PAGE_MASK;
>=20
> -		if (got_page)
> -			put_page(page);
> 		if (!iov_iter_count(to))
> 			break;
> 		if (ret < nr) {

--
Chuck Lever



