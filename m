Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41EE57A87B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiGSUsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbiGSUrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D827599D4;
        Tue, 19 Jul 2022 13:47:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JJnuHL031787;
        Tue, 19 Jul 2022 20:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ecc0CNntQ4AiG8Vfir21Jn4VmXaWzx2DVy1S66L4FuY=;
 b=ksL0/vJaCAEl48z34ZR9tG2AbPkc+CMYwpx+V7SWlbdu+WBYhvZr+9ltCu3tgW6qJqOL
 7upLKoQzOWCrnVtLzdT9finTMGVAMyclEJQVAQnW1KEzbYwgHL85VrC09YPj1gbzTw4K
 OXCoI3wjfEfFBWqS1pcNiwEDvTI0vdYu9wj0V1YZX8JHPXok4KllFbaYxZibKmqgnJue
 74NC3bEdyBaDZDB5fOP8o2FSNTbvVqxwSpliddG3V7CiVomVdaia1pMYs6GxU49v/FVE
 +KbE3V1ZzbrD4gMDt8FrbjFltsfmglFvG21MLQdhfW0j0Z0gZNZsZfkvTFfD84Fa51Gs xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtfqt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 20:47:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JJA7K0016382;
        Tue, 19 Jul 2022 20:47:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1emw2hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 20:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3XJOqZJEByKfnrXx8w8jZtjL/bketjfdq7/MFE2G4RAl2/m4PrW9rDc7pb2LXlLViamzzmdI3unlUa+7a4TB3jT90+hVXeBg7EWHI7jrhLZ8Rf0/ouOFTPn++EmhIpM3H56fNMbMKQtmjDVqoSz95O+4BsDFZ9hzTS3Sxmp9HhXQH2jzXLQQqrR9PiVKm7Ab6O1Z8beC/VTZj8OFoSkiyEMdZFwI60EdzKD8Hdw30oU/0S4YwLy9ipTr2mIYLvk8OwS184jY904jEB1M1MSaszS70kLCuV0Pu6y6LhZs1bvXAvUkEDqCdSqRX43JZfl1CbN3GyqxtnvawSopJ5deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecc0CNntQ4AiG8Vfir21Jn4VmXaWzx2DVy1S66L4FuY=;
 b=RvqtmxT+cQUhANNZzGiFIYTSNbCafR7JSRlPXVw6cAyibFHjCDGOdyCBFYHrDX/VVPFYGUJZCSW2pV3/mpahW0iUBG6iIqetubCY2stGQrRrokfZwzUV2gystAzEGJMvfFI26PhME5Ox7CJI08ceZucPGQdfcW2q6PPC8roCzTOpT13PJmpamq+UXpJvsDGFhxppFFe0bu+pgFauKYWcvVfwbis51yw2Z3ae5oJhz5UEJlLbI+9sShT5+1WI+/Ebd+H5uzO30qv0vfEOTMZ8KbiMdxaz4kbMldsRI82cCWnr/l50W641FOXDQTl0AVCs83RQ3Scy3A0Cg3OlIasnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecc0CNntQ4AiG8Vfir21Jn4VmXaWzx2DVy1S66L4FuY=;
 b=FbD7h/CC7VYYfEClvUHgwyMEVgwtdsL5PReoACJx46n0O2yi6DEOGBfK5qOy1vz+T/nz+Papt2J9+8GjkJeknO7h92q3WCBFrjlMNMDVK2UfApJjr+on7gcu6DIt73wiVDmZrePWpwtWrXCwCbGPdDIDnDK4/4012fhyivgxfOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5201.namprd10.prod.outlook.com (2603:10b6:208:332::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 20:47:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 20:47:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34AgAOLZACAAqAVgIAAMx4AgAAGf4A=
Date:   Tue, 19 Jul 2022 20:47:34 +0000
Message-ID: <1D37AF7B-DE7E-410A-A41A-880D0AB416F9@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
 <CAFX2Jfmm6t8V1P3Lt9j2gE_GFpKo51Z8jKPvxdbFoJfVi=dn9A@mail.gmail.com>
In-Reply-To: <CAFX2Jfmm6t8V1P3Lt9j2gE_GFpKo51Z8jKPvxdbFoJfVi=dn9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b95b8c2a-6f90-4db8-b879-08da69c7e84f
x-ms-traffictypediagnostic: BLAPR10MB5201:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nfDcrzMFtqqC5AR2FL9TTBBqIjuUPJ2E01qlkrRdOb6w16TpmRzNSP7TvzNukKfeqaM9XmO9ZaSRsMUjF3yOQRxCmdDagmyl5psm+BsDKJDiaJAhwPCKbeU0bxd0lUx/PNL8zKuUqmnsslb+poXOXwz0h+n8H1bTscrxSlbgEqTH+g2nSOB0baUngWxFfk7Zo8weP06cllu5cUFaLyR8madxVzftiXeG3asEzkHaE+qflgE4XDDLIR8exgqUxi6Ayxm3h6PWfJfYYlQTX13Vbw13scDqk4HbYY61xsLSYQ1KS9fjCPpLZ08HN+efqz6NFkI3lkOJzxtliW/D56J5gbfOvziWDoD3S6QGV/r7mtICyxVzZRcdZParqv3zrwx0jBuxgVMLPWCt+e1XXDaqk43XuySTXN8K/F2qqOqNmWZ9gEXAt5mOprm9sjQPXppFHMx0tZnkOcUGyXawFioMDgPhvxLVRUUnTwFCq2DEgeoAnYfE6I+Y3U1myJmJo5Xxjlx0dg1Sb4DY/JXO7etRthsKgjmU7dT/E8ITKLZpv6vtfE+800k23FuesD295MhexZatQasxjY5HwDiPbfOUlNvZDEqTImcnP2+Fj3vrtKD6rk3JP5ef5r5MRSVWth2Unl8IH9bAXA0eaZsdVwEW5CRaVWwPCori/63B8oH4xJ4VpNAELQvE//VO9OfJie+UPSR+fK9PBqY04o+cxnRMkaROz58xO89i0AGwZQRfU3NqoNvp5335lP2cHWYqyInbpR6F+cdx7E9oR1uIj0cljnG/bJ4Vk16wudyS8xBur58LYH5iCFW4fIUmw/YLT8DN/xKb/9TDTDPDnxgbjwhpJFtXM+lfXpoRM8yd2ptXGObtjWCEzghLrGCFipn3bsZH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(39860400002)(366004)(83380400001)(2616005)(38100700002)(45080400002)(38070700005)(5660300002)(26005)(186003)(2906002)(6506007)(8936002)(53546011)(478600001)(122000001)(71200400001)(966005)(86362001)(316002)(64756008)(54906003)(4326008)(8676002)(66946007)(66556008)(6512007)(33656002)(66476007)(76116006)(91956017)(66446008)(41300700001)(36756003)(6486002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gQLnNt17XwyNQJfjh+/LttxosJINrbUDO7yknfEPV86H3jOkwJsj4myZPtsM?=
 =?us-ascii?Q?7sqCm05hEONBKWCRSKmAmcHiGj54BDJpsIJ6V0dUCYaDLucjeEoPYFrBStMw?=
 =?us-ascii?Q?NwvoenYt06P+VKQ09ctIwyOsNlCe3y/O44P5o+FfM2Shk/il/6Sx3DDDfhNp?=
 =?us-ascii?Q?eLveGEhSd+11LrmAXHGvRuEgx86s8GrDCKJT0HRuBK9QRByva4FrqKwGm8vM?=
 =?us-ascii?Q?QzEJADPKtcevfDhVqAnx7U1F3AFllgpA0/LUG8uExOtI+H3rHVPvOs+r8Buo?=
 =?us-ascii?Q?YYQZ14IK8a3KjytyHZdfYuU2aIoofYHpgTnoJteMmvobGD+ASck+/ijWJDhP?=
 =?us-ascii?Q?6pcPqHqSB9518KfmB8rhPfNBhfCaTOInPczX0UOImOnhBkwIZ4Uy2VK8fMTv?=
 =?us-ascii?Q?TvItgsbToDnopfYtUgwGYQl9WL/zA+uqyxntHgJvKwpz4sFjwdTs6qKEb52F?=
 =?us-ascii?Q?O/Xvnnwte6RTKq0XY9PIe7gL6qlscqKAumTJ/Ce5X0eNpMAC+RCSx3/hCMqB?=
 =?us-ascii?Q?S687z33m2wZcVHqLQFnscYPIQjJ+d4PZGOy6EY69zz20tmgmBbI42TX0MUWz?=
 =?us-ascii?Q?sGObX+AzJwztjZkIfVIVwwgQmO91dogDvBbEREbkvsz5FT5qj87ZH2BDFH/z?=
 =?us-ascii?Q?daFhf2x4TF8599ZR/34tbQddoAzYQ078s6Rf+l2GW1R8/zAo8GuR9/HZDE10?=
 =?us-ascii?Q?5oHRF/rY07iFlH+wXKwHPDQleyiUVBgO3FkAKw/JJcww/aqCsy2oZjGukxAv?=
 =?us-ascii?Q?W2ot0J7kYX2aCc134n9KZJaDOajUefhVmfaQ4yiLn4oredzCE1PpbDALQIBG?=
 =?us-ascii?Q?dlGMqkly1E6ei8YmQNdEUg0zEz25aG5ykoS4Rx3reGm9H0u0Xv5frJGY/7iv?=
 =?us-ascii?Q?VKLg8O5OpAFxjzcqO/IlyOAQrP/7HNYMTzuMVImq28pvk5uE7udlp7hZAVJ5?=
 =?us-ascii?Q?SkFCYyf2ZC98mMExMM9dKpVTdm/aB+dWOrezAOrRs8IOh9kkxXAzWiThvuoX?=
 =?us-ascii?Q?SJUxi9Y9+21o9Bevb1Bluwpc14kkLf4jpr/LljzWyv36VrUAE9WSxbvBG4iq?=
 =?us-ascii?Q?+oDocYawOT2kKfY9RM+eEpIfHVsATazSxtqVwP/ig6/KEcOyYRRX3/mtf2Gt?=
 =?us-ascii?Q?N4nqa4YK8i2PIWAJb6uvYA+eoV07PFkuzNMbCSKryVWu+iIpNAJhF4QYqHXI?=
 =?us-ascii?Q?9mBB0cP3fttpbPrvvop2XyvYUMVvTEKxw6g4B4tOdmgx18w13x37CxuftiFH?=
 =?us-ascii?Q?bN23jEdIgj6KfrBOCYVynC7mpLfCSQY0QeqR7WEL526eHqdzf08IYYHGhQyI?=
 =?us-ascii?Q?V5Fmg6Q3H+cpPpgzYrerdFrNcqxts023TKWaA31mNlv4WvYwS+cCgX1p5n1N?=
 =?us-ascii?Q?i2X2RIbjpZpbMzycvEV6CCtSvrbr1J0Uf3EHAdZGs9poX0H2JM7UtKmxtedA?=
 =?us-ascii?Q?YqlJLZR5vpXxoJV7s8YLOFUnfcLUie6k50soXzWWdftsuryIIaMzABklrGtk?=
 =?us-ascii?Q?rrujtzspbuuYcFFkczBtJi4pU5hPqzUUsbTOlv/3WpnAQJ88EZnvje750awP?=
 =?us-ascii?Q?Aigxertn8yAjOJCKZKVo47wICknaqABe8GpJ2nClf/bh2J65DQSU4vJg2Yto?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B363769A243AC449F33EDCA7672E8EC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95b8c2a-6f90-4db8-b879-08da69c7e84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 20:47:34.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0A0TTDCFUp/lruJlOhOSPBtobdCkQHdxxStOOPTQZSVKEWQrqeFh8aQhPvpxfp8fMFnbuotPyhwdybR8rqRfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190086
X-Proofpoint-GUID: NeLoXz8UEVblKgk5HlCn80yBGR0C8rw3
X-Proofpoint-ORIG-GUID: NeLoXz8UEVblKgk5HlCn80yBGR0C8rw3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 19, 2022, at 4:24 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> On Tue, Jul 19, 2022 at 1:21 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jul 17, 2022, at 9:15 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>=20
>>> On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
>>>>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>>>=20
>>>>> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
>>>>> + struct nfsd4_read *read,
>>>>> + unsigned int *segments, u32 *eof)
>>>>> {
>>>>> - struct file *file =3D read->rd_nf->nf_file;
>>>>> - loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
>>>>> - loff_t f_size =3D i_size_read(file_inode(file));
>>>>> - unsigned long count;
>>>>> - __be32 *p;
>>>>> + struct xdr_stream *xdr =3D resp->xdr;
>>>>> + unsigned int bufpos =3D xdr->buf->len;
>>>>> + u64 offset =3D read->rd_offset;
>>>>> + struct read_plus_segment segment;
>>>>> + enum data_content4 pagetype;
>>>>> + unsigned long maxcount;
>>>>> + unsigned int pagenum =3D 0;
>>>>> + unsigned int pagelen;
>>>>> + char *vpage, *p;
>>>>> + __be32 nfserr;
>>>>>=20
>>>>> - if (data_pos =3D=3D -ENXIO)
>>>>> - data_pos =3D f_size;
>>>>> - else if (data_pos <=3D read->rd_offset || (data_pos < f_size && dat=
a_pos % PAGE_SIZE))
>>>>> - return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_si=
ze);
>>>>> - count =3D data_pos - read->rd_offset;
>>>>> -
>>>>> - /* Content type, offset, byte count */
>>>>> - p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
>>>>> - if (!p)
>>>>> + /* enough space for a HOLE segment before we switch to the pages */
>>>>> + if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
>>>>> return nfserr_resource;
>>>>> + xdr_commit_encode(xdr);
>>>>>=20
>>>>> - *p++ =3D htonl(NFS4_CONTENT_HOLE);
>>>>> - p =3D xdr_encode_hyper(p, read->rd_offset);
>>>>> - p =3D xdr_encode_hyper(p, count);
>>>>> + maxcount =3D min_t(unsigned long, read->rd_length,
>>>>> + (xdr->buf->buflen - xdr->buf->len));
>>>>>=20
>>>>> - *eof =3D (read->rd_offset + count) >=3D f_size;
>>>>> - *maxcount =3D min_t(unsigned long, count, *maxcount);
>>>>> + nfserr =3D nfsd4_read_plus_readv(resp, read, &maxcount, eof);
>>>>> + if (nfserr)
>>>>> + return nfserr;
>>>>> +
>>>>> + while (maxcount > 0) {
>>>>> + vpage =3D xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
>>>>> + pagelen =3D min_t(unsigned int, pagelen, maxcount);
>>>>> + if (!vpage || pagelen =3D=3D 0)
>>>>> + break;
>>>>> + p =3D memchr_inv(vpage, 0, pagelen);
>>>>=20
>>>> I'm still not happy about touching every byte in each READ_PLUS
>>>> payload. I think even though the rest of this work is merge-ready,
>>>> this is a brute-force mechanism that's OK for a proof of concept
>>>> but not appropriate for production-ready code.
>>>=20
>>> Seems like a step backwards as it defeats the benefit zero-copy read
>>> IO paths on the server side....
>>=20
>> Tom Haynes' vision for READ_PLUS was to eventually replace the
>> legacy READ operation. That means READ_PLUS(CONTENT_DATA) needs
>> to be as fast and efficient as plain READ. (It would be great
>> to use splice reads for CONTENT_DATA if we can!)
>=20
> I remember Bruce thinking we could only use splice reads for the very
> first segment if it's data, but that was a few years ago so I don't
> know if anything has changed that would allow spliced reads for all
> data.

That might be a limitation of the current NFSv4 READ implementation
rather than something we always have to live with. But yes, I think
it's true that splice read only works for the first READ in a
COMPOUND, and READ_PLUS CONTENT_DATA segments are a similar
situation.

Even so, IMO enabling splice read on the first segment would cover
important use cases, in particular the case when there are no holes.

'Twould be interesting to add a metric to see how often READ_PLUS
returns a hole. Just a thought.


>> But I also thought the purpose of READ_PLUS was to help clients
>> preserve unallocated extents in files during copy operations.
>> An unallocated extent is not the same as an allocated extent
>> that has zeroes written into it. IIUC this new logic does not
>> distinguish between those two cases at all. (And please correct
>> me if this is really not the goal of READ_PLUS).
>=20
> I wasn't aware of this as a goal of READ_PLUS. As of right now, Linux
> doesn't really have a way to punch holes into pagecache data, so we
> and up needing to zero-fill on the client side during decoding.

Again, that might not always be the case? But OK, I'll table that.


>> I would like to retain precise detection of unallocated extents
>> in files. Maybe SEEK_HOLE/SEEK_DATA is not how to do that, but
>> my feeling is that checking for zero bytes is definitely not
>> the way to do it.
>=20
> Ok.
>>=20
>>=20
>>>> I've cc'd linux-fsdevel to see if we can get some more ideas going
>>>> and move this forward.
>>>>=20
>>>> Another thought I had was to support returning only one or two
>>>> segments per reply. One CONTENT segment, one HOLE segment, or one
>>>> of each. Would that be enough to prevent the issues around file
>>>> updates racing with the construction of the reply?
>>>=20
>>> Before I can make any sort of useful suggestion, I need to have it
>>> explained to me why we care if the underlying file mapping has
>>> changed between the read of the data and the SEEK_HOLE trim check,
>>> because it's not at all clear to me what problem this change is
>>> actually solving.
>>=20
>> The cover letter for this series calls out generic/091 and
>> generic/263 -- it mentioned both are failing with NFSv4.2. I've
>> tried to reproduce failures here, but both passed.
>=20
> Did you check that CONFIG_NFS_V4_2_READ_PLUS=3Dy on the client? We had
> it disabled due to these tests and the very, very long time servers
> exporting btrfs take to read already-cached data (see btrfs sections
> in the wiki page linked in the cover letter).

Confirmed: that variable is set in my client's booted kernel.


> There is also this bugzilla documenting the problem:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215673

OK, then let's add

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215673

to this patch when you resubmit. (I used to use BugLink:
but I gather Linus doesn't like that tag name).


>> Anna, can you provide a root-cause analysis of what is failing
>> in your testing? Maybe a reproducer for us to kick around?
>=20
> The only reproducers I have are the xfstests mentioned. They fail
> pretty reliably on my setup (linux nfsd exporting xfs).

Then, the first order of business is to understand why you
can reproduce the failure easily but I cannot. (Hrm, I think
I did try to reproduce on xfs, but I'll have to check).

I'd like to see READ_PLUS working well in NFSD, so I'll
try to be as helpful as I can. There will be a learning
curve ;-)


> Anna
>=20
>> I'm guessing you might be encountering races because your
>> usual test environment is virtual, so we need to understand
>> how timing effects the results.
>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



