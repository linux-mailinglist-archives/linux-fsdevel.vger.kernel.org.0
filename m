Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5057A515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiGSRVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiGSRVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:21:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8C20F49;
        Tue, 19 Jul 2022 10:21:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGv4uj002392;
        Tue, 19 Jul 2022 17:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nMjs0i8HfimjSyjAbms6BlU5KKz+sozCupPPfjhxcKw=;
 b=YvOWsDQQgBgSkakUfvcbaBKnV4Mi/V3koTTKVFVH4SGNKjYiU5eFCzy2ye79+cenm1MO
 qAPbqjahFDznrF52ZdnARw0EQTJYgR7ahFBvY201s3vP9Ufb5UPhhHm0cyrGjt0Tiwng
 LGMH8UH0oj7YxO36l0XYcPWpHevj/ayREAbDUazNFjGKKXLTsG17UkHY7z1+UsPmaoST
 cj/jN/2vh7cuNQPsz8DhjmkF2dRBWHHqOvvdEPQMxeM/w/L1epZrVVtpETk1jHRPTLv3
 QpAS2PkJi0bbwO96Nv+VQz/5P07Vypp9IGfOLsxFxtErce5myzgtCV8dhw4WiH5ExhvZ nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a73t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:21:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGIYPI007821;
        Tue, 19 Jul 2022 17:21:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3jrs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb3lwnEG3vJ6GcHFKgXo4UedfMPYvsS40TsmZUcKsurxKz9GFRcqXrZghQtZjIfIc+tsHWwbs5ay+271tYzWhhdgmjreDKxldfPZXYq6LFxOn5Rxbf3Dh5w6Wt7mg45RtDDf6oE0fX/I9+IjxjHWqA/LRXxw1ZqTL8rpB8If2TgzVP5JqfDHgypaJaaJFmQaSKrTlaGp9jNVZbLNwtK8BXwNIgoZCJtvABcONGgqC9RBN3bgddstzFS27PWbX/Byq9qmyLIwZkHN6F+2WajEZP9x78PBjyc8WCxE/rC8Lg44ldlvzL+0Tk5WCFoDZTzGRitbnUOVaNJPh2A8/m8Lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMjs0i8HfimjSyjAbms6BlU5KKz+sozCupPPfjhxcKw=;
 b=hgJupe7Vu0vx/BhBpFHcGZ3//KSW8ljn1G9iRpfG+cyAmEHOnErd4THwN8NLv9NLkNxP3wpOeCbnfJIH6oNUoB4uLnMlqxEzDpb60lnpVYD0zkNx+sRNi09KUR82gKer+Q/s787Kp0Q7ebtzv3PkMmQekL2SZenbxr6SXPrTT/FgS7CqxAFbwfSCBkD9nQWb5Cul55xCr8FZBBFF5z/jIbE4BCLexb11PB/3rmOLYl43SFhtIkBONbhw2YKbOpEqyyinQheYjDCwofv/ZRgB0lVDVp0Q8YjiIIsY3/dLI+qFwmac1YKkY6NVk9FpAq79sBEK8vNqdwHWZcRMC8P7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMjs0i8HfimjSyjAbms6BlU5KKz+sozCupPPfjhxcKw=;
 b=FtUvS9Mykkyrgx7jfNQqwVFa8Zj5+SfSUZnZvfGv2VG5mcMDq/Oug8SLpDneENldmrCYQKICUWfIt5aOIQebZLb10DEzWm/LILVhl3LVpkFDdcfXXdajtxpr+dH+OzmQpeEiuCz7DTDIHW9zj8FceqCvJnHhs3cuN51Wmk5T1oo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5427.namprd10.prod.outlook.com (2603:10b6:303:13e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 17:21:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 17:21:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34AgAOLZACAAqAVgA==
Date:   Tue, 19 Jul 2022 17:21:21 +0000
Message-ID: <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
In-Reply-To: <20220718011552.GK3600936@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93018004-fbde-4dc7-11a9-08da69ab19ba
x-ms-traffictypediagnostic: CO6PR10MB5427:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzJDQBk5+dyAakDR9+qWhk6CYgEFE32AhN6rIopg8qZjybE/LaFL1O9mxgqeXVflYoHFP4JnL0w4aqvAp5iyBXPO7xtGt11P48wRfpSjdLKsocLSLm0Eh4UPF+c1Z3pHhptUBTkO2pccpIdNSbi3agKhIY5D3qQ/7n+ajWmCGSjBt94wDn2XDgNoXsxQ5Em9vZFj5xHbobfrLDzwj3D/N2GeKhZ4VQ+/oET6OkJAdfvcs5sNSzaLmgBJn9eV106P090gIYWbw62cOR+adxXBREa6U+IHwMVzhQyoD+DZ5hz1RpZj08+/hQxHPsR8aPCEGuosUEx/hA8izKsluqFA3Aizf0muCX6yYXHjA4fUVH3IXAX1HgnXNTzJBMpEV64vqEUtIpJDqPa/7drTL7+2Pf6koaboGqgww/4MSOAx8T/VlxPHlJPHSlDn7VAie7SEIEIiJfI0ar0ljNX66ZiEz12owWRN5S0PN+0Hh/wS+2L9sNZA0a6CIS2qrNdUNSqoR7e6eb/eiu049LEXAQLn8YpgAcE+/foyiXljcE4vEruJUmv0/JQgEhRcP1rgpBEfAE34MVVTicSIIe2yV/y7SDMlZ/HaU4uKtywbJtV1wtmmPXnqHvt7u6pI43ZWAZ8LdeGNb7YYOBHJxPdzLH7RXO8U5LFz9zAwl023fNAfHxBct2Cm7s8cZ5pBOJ0lHKOQf1fQNanZ5xAJdEjjDN9or0V+Y1UQPC/vuzZs9OirBBW5BquT9RaaGjyAGpwvRDsYn3PwEeBa1lvRnaicvVVywn5XEFClaZojEaxjMaknRfWBSkZLwQSsrz/KwWV2yTcuti0emPIeZb8dGVXT9LTTAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(366004)(396003)(8936002)(91956017)(5660300002)(4326008)(76116006)(33656002)(6916009)(86362001)(2906002)(54906003)(66946007)(64756008)(66476007)(36756003)(316002)(66556008)(6506007)(26005)(186003)(71200400001)(478600001)(6512007)(2616005)(6486002)(53546011)(38070700005)(66446008)(8676002)(38100700002)(41300700001)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JddBxqbPAQHtFKH8ZA1q6weSaClQfEIZDbKnIxb5ECl3V9xaW/ylkzYuZCC9?=
 =?us-ascii?Q?msm8GzHpqyOUk5XhvIgMcmKkZ15s8hIqVR2sEVSBVXKydrKEG17y7ddlOeEL?=
 =?us-ascii?Q?/4h9gq7oQwwfVriqwOCjR5nnSOQbcZOo3qmKQnPAMydyrFqbZx54qNxs/SLL?=
 =?us-ascii?Q?cpAHH1v/JfZYOv+72j/QjNgbU9J/WgOFN6YKY+KQDl/G7UGIRjZ1LaOptTOw?=
 =?us-ascii?Q?phQqrHbApZPE8HJbn2DgbFtancM4CtnKXCjNOu3tz7fR8VA+/DZMLCuqyf9G?=
 =?us-ascii?Q?VSeRdmcRu/GPj5t9KfGck0RX/sPQWuDmjWYg9VzFlC3X8drl+iCMfQktJeCi?=
 =?us-ascii?Q?7oGD+jIGbG2N/92noqww06SaZYTMSxyd4yDZkWwszxNigTGxzbsV56v1pXrQ?=
 =?us-ascii?Q?KwwbAHx1NQf6WfrnpOK1wtOUfgLiTAUADKeGiVBSM+Rfdmbo7+1qXXBxrjJc?=
 =?us-ascii?Q?kbPmQBLcVGRKwgJYYfMl0VTJK30kVbFmYCZF9veSmUGlNzjBOjQkHadRjEu2?=
 =?us-ascii?Q?jQLR2o42JOjFxP2UXYwGjWwiGHEWwQLwvajM5U0uY1Q2HSlEnVw9Xd1XOqQs?=
 =?us-ascii?Q?RBkbrnfLEbsuyEjmd70awAAjkmKNI+YhVACYrOKsWKCnPkQkO59Ni9zKz2T/?=
 =?us-ascii?Q?h3XbyHfmkUeOAHnzGDAWH0MsATyHt8+xY4l6sv+MRmrOPReYnNkdk3AA1FXJ?=
 =?us-ascii?Q?COrMNMTkQnaLfiQBHnpXnjf9jWzNsgbFkRy0PHMkkMD3Y7w3Bwje2/Slkbar?=
 =?us-ascii?Q?YM+FS00LjMdCHrULgoc1i1w2JAMg2sxzeel0Qg/0fZu5HlzXZnaCktnTcbDE?=
 =?us-ascii?Q?WMVH1OAWk5brl3SZNohpEY4XOWdYeEUEsVuDnbS2DF8prVDzZeouO4N6xEG9?=
 =?us-ascii?Q?iUBx06feufDEKFdgWPd+UmRXBzuwku3jQY3IDV0xDWXAVJbfsFRIIO8QOo4f?=
 =?us-ascii?Q?J4SRVtApUL4DcvQD1hYcR8IQ3U8JKq++36LDtQRMKK/iBJwhSuYh1gXHFt7F?=
 =?us-ascii?Q?vpTh5dajO14tCdSEcQeEozZWKng0UZEWBV/0m7cGxZApedoz963zkfJd+W5i?=
 =?us-ascii?Q?lpiGvy87/zB6TVBEBe9xsubWA7eEm4f/GBYc+K0Q26Z2x9DcgtGjPTU8QbOH?=
 =?us-ascii?Q?zzhp4FxtAr48zc7Q9BBUbJnJ94SjlfvX36tvgIjMLtZ5I07H84bG2cAL8ODD?=
 =?us-ascii?Q?Wq6dsVau3BWluVna7WYZJpybBcy5zpQPlBY0ct4JzakspT4IYGKFUrynHgDZ?=
 =?us-ascii?Q?vfQdqeQPt4VSOcTkZKgEPSyQZF0fsmuIcZSFpTK3hLH2PJlsNNBGqei3y5ON?=
 =?us-ascii?Q?2+tmgrGXtn720byRpMA4I86+vs76x5ZKbEN0uVt5qNPaaPJ/PuXpiTDqXcNL?=
 =?us-ascii?Q?z/hB/viapu/SiA4AHctzMTqh4gDxwDTVeFVpFKzFRc3xhPaSXkruUMoSBc/p?=
 =?us-ascii?Q?+xPfOf/An8CylS0Cb6JFGyK/gZE7/WFB1nFlseMSSTc/mm0LHhr+3YhYKmrG?=
 =?us-ascii?Q?3KgyIDFENuCX6ipQ9Dgf2vMJd/Sn7AF6PLPFu0VmVDfsBRk50nvqRemH2rB4?=
 =?us-ascii?Q?rFjpeVqUoeOTa6LzR/7eL4fyEMUYtXeiez9pqSUYXkMsdiizmTrFfqVtzCJw?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <797188907B156E4D82A33F9FD7DC435F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93018004-fbde-4dc7-11a9-08da69ab19ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 17:21:21.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYcLexYhG6pcQDHQF8vWEwN16MxE15e4k29PqNk5XxXMq3/rClP1kdYd7YFukoAU/OZ2WXYu3ynb/C1YzAFhgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190073
X-Proofpoint-ORIG-GUID: svGtsTBVdlo0Q2ec8WMNgdvoM3ydpPL3
X-Proofpoint-GUID: svGtsTBVdlo0Q2ec8WMNgdvoM3ydpPL3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 17, 2022, at 9:15 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
>>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>=20
>>> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
>>> +				struct nfsd4_read *read,
>>> +				unsigned int *segments, u32 *eof)
>>> {
>>> -	struct file *file =3D read->rd_nf->nf_file;
>>> -	loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
>>> -	loff_t f_size =3D i_size_read(file_inode(file));
>>> -	unsigned long count;
>>> -	__be32 *p;
>>> +	struct xdr_stream *xdr =3D resp->xdr;
>>> +	unsigned int bufpos =3D xdr->buf->len;
>>> +	u64 offset =3D read->rd_offset;
>>> +	struct read_plus_segment segment;
>>> +	enum data_content4 pagetype;
>>> +	unsigned long maxcount;
>>> +	unsigned int pagenum =3D 0;
>>> +	unsigned int pagelen;
>>> +	char *vpage, *p;
>>> +	__be32 nfserr;
>>>=20
>>> -	if (data_pos =3D=3D -ENXIO)
>>> -		data_pos =3D f_size;
>>> -	else if (data_pos <=3D read->rd_offset || (data_pos < f_size && data_=
pos % PAGE_SIZE))
>>> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_siz=
e);
>>> -	count =3D data_pos - read->rd_offset;
>>> -
>>> -	/* Content type, offset, byte count */
>>> -	p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
>>> -	if (!p)
>>> +	/* enough space for a HOLE segment before we switch to the pages */
>>> +	if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
>>> 		return nfserr_resource;
>>> +	xdr_commit_encode(xdr);
>>>=20
>>> -	*p++ =3D htonl(NFS4_CONTENT_HOLE);
>>> -	p =3D xdr_encode_hyper(p, read->rd_offset);
>>> -	p =3D xdr_encode_hyper(p, count);
>>> +	maxcount =3D min_t(unsigned long, read->rd_length,
>>> +			 (xdr->buf->buflen - xdr->buf->len));
>>>=20
>>> -	*eof =3D (read->rd_offset + count) >=3D f_size;
>>> -	*maxcount =3D min_t(unsigned long, count, *maxcount);
>>> +	nfserr =3D nfsd4_read_plus_readv(resp, read, &maxcount, eof);
>>> +	if (nfserr)
>>> +		return nfserr;
>>> +
>>> +	while (maxcount > 0) {
>>> +		vpage =3D xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
>>> +		pagelen =3D min_t(unsigned int, pagelen, maxcount);
>>> +		if (!vpage || pagelen =3D=3D 0)
>>> +			break;
>>> +		p =3D memchr_inv(vpage, 0, pagelen);
>>=20
>> I'm still not happy about touching every byte in each READ_PLUS
>> payload. I think even though the rest of this work is merge-ready,
>> this is a brute-force mechanism that's OK for a proof of concept
>> but not appropriate for production-ready code.
>=20
> Seems like a step backwards as it defeats the benefit zero-copy read
> IO paths on the server side....

Tom Haynes' vision for READ_PLUS was to eventually replace the
legacy READ operation. That means READ_PLUS(CONTENT_DATA) needs
to be as fast and efficient as plain READ. (It would be great
to use splice reads for CONTENT_DATA if we can!)

But I also thought the purpose of READ_PLUS was to help clients
preserve unallocated extents in files during copy operations.
An unallocated extent is not the same as an allocated extent
that has zeroes written into it. IIUC this new logic does not
distinguish between those two cases at all. (And please correct
me if this is really not the goal of READ_PLUS).

I would like to retain precise detection of unallocated extents
in files. Maybe SEEK_HOLE/SEEK_DATA is not how to do that, but
my feeling is that checking for zero bytes is definitely not
the way to do it.


>> I've cc'd linux-fsdevel to see if we can get some more ideas going
>> and move this forward.
>>=20
>> Another thought I had was to support returning only one or two
>> segments per reply. One CONTENT segment, one HOLE segment, or one
>> of each. Would that be enough to prevent the issues around file
>> updates racing with the construction of the reply?
>=20
> Before I can make any sort of useful suggestion, I need to have it
> explained to me why we care if the underlying file mapping has
> changed between the read of the data and the SEEK_HOLE trim check,
> because it's not at all clear to me what problem this change is
> actually solving.

The cover letter for this series calls out generic/091 and
generic/263 -- it mentioned both are failing with NFSv4.2. I've
tried to reproduce failures here, but both passed.

Anna, can you provide a root-cause analysis of what is failing
in your testing? Maybe a reproducer for us to kick around?
I'm guessing you might be encountering races because your
usual test environment is virtual, so we need to understand
how timing effects the results.


--
Chuck Lever



