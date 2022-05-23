Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B75314C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiEWPDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiEWPDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:03:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E705B8BE;
        Mon, 23 May 2022 08:03:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NEuIln016400;
        Mon, 23 May 2022 15:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SFXziQw7Zwvspax3VQBJqYW36Xm4cPTZa56USGx4Nzw=;
 b=nQxRoNnizBAICJ2hsCOzOTmOa7GPbOkGvE2BEwMwb5uLIyjNPBoGCKs6lwUlliNdeULG
 F1DrsWg02Q47UmYDg90gUQKWA1qFjEHkyNlcs1b/anOJOqSM2OEF0Ze1GyFqJQG6cR4S
 5uEB10L8Pm6akNwC//tGxgyFw67N9crsR/LQLewoT2rqlPFSWbUFeOUkRPX0fJHLbDVf
 dXqGo0HlRnTygy0P7cGrgp8a4FcFZoiGCSDcQA11ZEHWPxlY+/NglHoREyoShxEAlI+6
 GDwivvh/FFxbXKttsd/N7Yic0lsk5Qt01ZokL7WPmc1GVWzfEFEzWEt0r9YthfumzpPC 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya3jys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:03:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NF00sp017756;
        Mon, 23 May 2022 15:03:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1ebam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1ZH+K9GtowF3ZigJGrXi2aN9AyCwVnYtf6GbwPo8uuDGmTxiUMUa9PTzGLmpNsahkb9b8a0dQMtQqCPiP92+AA7E3gVgpOXLtK8FwE3hy3lSlXOCwE8oAIsYDpPtXxiKKLYhnmamqP9L7EVGQdpl/K6CKF9ynqg9CfZqdM7rMn7ZNceulKag0lP1bXfFstn5XyF5IOdiYCZ+QJy0erLPh38F4kUqAIGnL1M6vaz6iqu2ZoNIuVrZc8rTzHTsN9RhrVEDbrXhgQhbJcAdZeYtYYCIsgSAaSncmC2MD+Gova2efu3/Y0dNOu5aCdVl+zSs6UROt5lcG1nIOwteceH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFXziQw7Zwvspax3VQBJqYW36Xm4cPTZa56USGx4Nzw=;
 b=DeySm9anwmYg1u6rD0u/kHBkBkoqONtNVK6qoRkAHUE5lBkXfjoBu5HV0MtA/WO12EhXbU1ye1c7x61ldDXPpzi4ADv42v9c/KUetcaY7iqrLjEOPuBegzzjt9z7yqnhQ6I/wIUnOgODNy/AenVxR5Dr71nmXOlm8FE8BE6u12yo9ZejsJKGZypxTKg7xaba8TjM/7OvlYTFiFED8Di1knQPbvdSX9oluri4xkXtVzk6nxKLwhKJWAbv4RNim7fRqqb2W7JjAkFKnN2B3gcUXMicqs/PeuslT8kHJZqGpuy2BDblnPmZrGdHvDXBnRJiOTBCq9U4Sste/qrupYd9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFXziQw7Zwvspax3VQBJqYW36Xm4cPTZa56USGx4Nzw=;
 b=DUEPiESUaVm6PtDj5CizE07F34rtI6KSsCdTkqPuW+s+KtIRszXX31TFHsqAeWZZojyndJZx34cQw/xeokG7uAGUBzFMFV1YtcscPPlUM7ePyIAGYFU/Rk1xvDZJ9c1gEPNo7TDgL/AFQ60rVH1DW0f7lcp/b667PLh0QJMzJF0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2876.namprd10.prod.outlook.com (2603:10b6:5:6a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 15:03:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 15:03:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
Thread-Topic: [PATCH v2 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
Thread-Index: AQHYZ7EJTA/DslvAXE2acX7m7V7Cp60snQaA
Date:   Mon, 23 May 2022 15:03:05 +0000
Message-ID: <F6FE6E49-0A61-4044-A454-0386DCF3E172@oracle.com>
References: <165254610700.2361.2480451215356922637.stgit@bazille.1015granger.net>
 <165254629346.2361.2854636099340313544.stgit@bazille.1015granger.net>
In-Reply-To: <165254629346.2361.2854636099340313544.stgit@bazille.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c3f8cbd-4b8d-4025-5a6e-08da3ccd572c
x-ms-traffictypediagnostic: DM6PR10MB2876:EE_
x-microsoft-antispam-prvs: <DM6PR10MB28760D0236ED58D9E6DB276593D49@DM6PR10MB2876.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlL7OYq9c3GCx8vlC5KLc1pkfqt7c2tZJNkxqjo8MDYf2qVv/pOzEsV4/wXUF3KJCIDGpWvw/tsNHEddVaW3VVPibZcTNK2ODdx3RTwbLcMUhRJMpPuxznHkXY+O0ADOKiYfCDKDwNNdbrMZ4ZUM791Q/Fr1HmGmxMR0dEFqgW+G64ZjBJTWysOWI4unUVgjafBg52SeFnRnSqiXnDvFYfG7uG2hYJSfN1bwMo8vIOWqz6BudpBbsOtLDHc6iYpZgOhwAbzVpZG66kAldrBIWCrLc2I7nM7YA5POEXiPGy9P95ggvn/jGIrtMjPneK0G0WarmBEbQ8WfpkkIBFa5MBs1HNZ3F/pOML+7QJkzbPjy4xUv1t8HoFyiVcv/RPCegd7iZOGLCgUxX59V5h/LPgfRAhY5FF00/84dvtQByFXW0fmje1jOQjRMhklCoxaXxFgffx0k6odOlOPfCDT1PoTNfdkMN/4XLE+gLN9asDgBmViOykhnVh0z7te8tF15gVfZPxSImrnartau1tVWJNhEFIoaz2ApdSHRAn6tEiyFgjHfeVdx1FR8WweX0YKSBgjO+mst7sfI7GctXk1ATPOVcLK6h7nB6jbOT08dDIAbBBn+ggccdFxD1JbbOSi38q5sqM8ZbgG04Cr/L3qF/a8YSIl9yivZaiisk+UWde2Z/6T92i9VFX/ibE9c1tN+tdQA/W8bER7LThb/vJ4cd1eeMGm5cBWJabuILDsBsqZzgcQkyfoCaMbImUO5C0v0nQ9ThqBJQl0t4g1qxzClxyWQtJk3pJqV2E30cdeX2sTfxWRqgCzdVpISOzEUlTrUBx9qAs19gfoHENnjLfByTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(2906002)(8676002)(36756003)(83380400001)(33656002)(4326008)(186003)(316002)(54906003)(76116006)(86362001)(6916009)(122000001)(91956017)(5660300002)(6486002)(966005)(6506007)(6512007)(38100700002)(30864003)(38070700005)(66946007)(53546011)(508600001)(71200400001)(66476007)(66556008)(64756008)(66446008)(8936002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?29qNAtFEITC7ib3UxqmFLowNNukxJg71cFKEY7ddDwYbmxWq8ZoSnmbc5Yh5?=
 =?us-ascii?Q?kfJKWlqYcbEW/nbC0+qw4FVbcSblevXCdirmpJExR83xpCQ+IVsufYmeuoOh?=
 =?us-ascii?Q?5oHZXgk0GfF62cNHbdRikY946afZFL3gNAcYNwY2OlknFaXWX7yT+T+7fOur?=
 =?us-ascii?Q?AOTwg7ULknhTGQb0zztr0OijZOgRsHQHGFkzDH1t2wMDQFySIcfXWA0PLIUo?=
 =?us-ascii?Q?IPRfAuFJ1k1GIAUreWt9u91hPndRhj6KrS/nZcIQtsER8vbVq9OjiEbn/687?=
 =?us-ascii?Q?7X8E9v1mSXHCjyNaqBW+DSWIHskcndRjCZmbB+AFTYKicrXryF7hklBqrSZC?=
 =?us-ascii?Q?z4ZqPJpz9ygC487SkuSffLUopP08MTf7cPWhEPiD9ljugGDXXhce5Bfb0aoj?=
 =?us-ascii?Q?ArXKlTHs9i7Vk+PXm58dGloTTEAN9ZXSYKdlpUwTTA49QJvuQClxntPJdfcJ?=
 =?us-ascii?Q?vYBfm5ZdSaJbCu/NXYWyqgP/Yv9mO9mHuqrHq/an2OPDXzLWjQWBHGnqojzV?=
 =?us-ascii?Q?de/6B4Xa9Gx3MX89o8SutlCZ84f9KIDWNWP9WOhYxXNqGEM3gJiBYyO6RVdu?=
 =?us-ascii?Q?Q37nxBj426cRvEdVLPKxQXjtt4l7EWzt74XQNFyinMFIoIyzX2vXlbsQNqOX?=
 =?us-ascii?Q?LlbrVisQo/codKuUmd3CVvdrfraioVuqI1PDqDTlvzjexBNS46qlCaxUG+bk?=
 =?us-ascii?Q?EtPsP0c8PCiQcCsu+7nxc6J86WOafO4On6eIJ03TCULhyORlyv6tX9cVSKzX?=
 =?us-ascii?Q?vz+bZkKn0k9opXmWQ0le5Alo4RVlPsP2FXo2YLnA5InKJryCdhROhSnZaOIB?=
 =?us-ascii?Q?gou8tPa91X44GJnZrjWcWV6jxCkSjkQl3Lqton5U67pxl1zPmuPJg5h9hwhf?=
 =?us-ascii?Q?SIWH1HE9ll0Yb7EvBRclM60FD0A57ZXQbnSj07HtdchTkplxMBaugP4Ej/vR?=
 =?us-ascii?Q?Pr+7KASB8Yh+SmGFVw9LQlRKVuh/+ssjPS2bhyib8HAww+GW0B50f817f9Ca?=
 =?us-ascii?Q?0ZruyXWpQmRy9rZ+qnvclxjvrws6GmIsTlIsqtKrjoHNZol5TvfEUVHMqShb?=
 =?us-ascii?Q?0V3lYQQEL3PHb7hyadNJ6UtPJjyqYogpo6Cpv7vM0O1Ps39BnbWfoGKePr7i?=
 =?us-ascii?Q?D88RxDrZ1IZ9YWkMgGi7JaVa0We00aoyirBN7coEeu6xU5+eAuGhZ9qDLItF?=
 =?us-ascii?Q?fRE89wEYG/66gWx7J98JA4wH7A4tFaOWSbsOQMt8wRaWQooq70hT7jUunNCP?=
 =?us-ascii?Q?T8C/2pII8r0zmVFVDYus5w5DY4X1TNJnfcBgRRSdcqdZ+Yr/v5KMZTQ+kGWG?=
 =?us-ascii?Q?aJCqZb9j6qZDY2Vsp0x6PWtxOP6tM+vQoALqW+udHCtah45uH8Qp+7QigRAz?=
 =?us-ascii?Q?nEm0TshQ+jJ7TC7LPClwbsNisncLoszGgxygdn98umZqi+dOL9sRhJYDxYPh?=
 =?us-ascii?Q?zS/baCWpKbYfCocle6Pown8bp8QBCXEQimwlBKAxJSx0x7NUc0OsacIpWxbq?=
 =?us-ascii?Q?Urf07PDC/1eMHtAUPgezTOaCiRHMeDxg+yPMxIKLlPRaFVqvh8ueeGtlQpvC?=
 =?us-ascii?Q?T7pD+59UbL+slUVFh7IDG0I77UzQdjGlkuJ/FmaIL36xAwOwdAQZBxSIgMoe?=
 =?us-ascii?Q?rjzdUTCqjt1U1PtcRDQ50BUKod05u22CpDIarKukHPkUZcgFKYwJzH2ZxVwP?=
 =?us-ascii?Q?k/QiWzZn1DqEbFaXx94a2MI/dmCmCvB6FMbuSItJKB/4voZgsz29oXRYXuEP?=
 =?us-ascii?Q?Xuryme7Q5E5Vi3E4UUr/pgl9fVr9DB8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C41DFBD2E3004F4281AE82503033CAF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3f8cbd-4b8d-4025-5a6e-08da3ccd572c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 15:03:05.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1RS+yHeN3+VquBqroGrRZwl+5W0oD8hRCkiXIYL9r2yU3fRWaDJEOjp2dmOy9O4T5LkrrYN5RtCndR+Z7xQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2876
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230085
X-Proofpoint-GUID: 2td625BqOXbW69LM6UbHwygVDtjeenjU
X-Proofpoint-ORIG-GUID: 2td625BqOXbW69LM6UbHwygVDtjeenjU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 14, 2022, at 12:38 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> There have been reports of races that cause NFSv4 OPEN(CREATE) to
> return an error even though the requested file was created. NFSv4
> does not provide a status code for this case.
>=20
> To mitigate some of these problems, reorganize the NFSv4
> OPEN(CREATE) logic to allocate resources before the file is actually
> created, and open the new file while the parent directory is still
> locked.
>=20
> Two new APIs are added:
>=20
> + Add an API that works like nfsd_file_acquire() but does not open
> the underlying file. The OPEN(CREATE) path can use this API when it
> already has an open file.
>=20
> + Add an API that is kin to dentry_open(). NFSD needs to create a
> file and grab an open "struct file *" atomically. The
> alloc_empty_file() has to be done before the inode create. If it
> fails (for example, because the NFS server has exceeded its
> max_files limit), we avoid creating the file and can still return
> an error to the NFS client.
>=20
> BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D382
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Tested-by: JianHong Yin <jiyin@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Hi Al, any thoughts on this? May I add your R-b ?


> ---
> fs/nfsd/filecache.c |   51 ++++++++++++++++++++++++++++++++++++++++++++--=
-----
> fs/nfsd/filecache.h |    2 ++
> fs/nfsd/nfs4proc.c  |   43 +++++++++++++++++++++++++++++++++++++++----
> fs/nfsd/nfs4state.c |   16 +++++++++++++---
> fs/nfsd/xdr4.h      |    1 +
> fs/open.c           |   42 ++++++++++++++++++++++++++++++++++++++++++
> include/linux/fs.h  |    2 ++
> 7 files changed, 143 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index dc9166136796..764c2cfc49a4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -912,9 +912,9 @@ nfsd_file_is_cached(struct inode *inode)
> 	return ret;
> }
>=20
> -__be32
> -nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		  unsigned int may_flags, struct nfsd_file **pnf)
> +static __be32
> +nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
> {
> 	__be32	status;
> 	struct net *net =3D SVC_NET(rqstp);
> @@ -1009,10 +1009,13 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> 		nfsd_file_gc();
>=20
> 	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf);
> -	if (nf->nf_mark)
> -		status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> -					    &nf->nf_file);
> -	else
> +	if (nf->nf_mark) {
> +		if (open)
> +			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> +						    &nf->nf_file);
> +		else
> +			status =3D nfs_ok;
> +	} else
> 		status =3D nfserr_jukebox;
> 	/*
> 	 * If construction failed, or we raced with a call to unlink()
> @@ -1032,6 +1035,40 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> 	goto out;
> }
>=20
> +/**
> + * nfsd_file_acquire - Get a struct nfsd_file with an open file
> + * @rqstp: the RPC transaction being executed
> + * @fhp: the NFS filehandle of the file to be opened
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
> + * network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	return nfsd_do_file_acquire(rqstp, fhp, may_flags, pnf, true);
> +}
> +
> +/**
> + * nfsd_file_create - Get a struct nfsd_file, do not open
> + * @rqstp: the RPC transaction being executed
> + * @fhp: the NFS filehandle of the file just created
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
> + * network byte order is returned.
> + */
> +__be32
> +nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		 unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	return nfsd_do_file_acquire(rqstp, fhp, may_flags, pnf, false);
> +}
> +
> /*
>  * Note that fields may be added, removed or reordered in the future. Pro=
grams
>  * scraping this file for info should test the labels to ensure they're
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 2d775fea431a..b72efcb088ce 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -61,5 +61,7 @@ void nfsd_file_close_inode_sync(struct inode *inode);
> bool nfsd_file_is_cached(struct inode *inode);
> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  unsigned int may_flags, struct nfsd_file **nfp);
> +__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  unsigned int may_flags, struct nfsd_file **nfp);
> int	nfsd_file_cache_stats_open(struct inode *, struct file *);
> #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 99c0485a29e9..28bae84d7809 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -243,6 +243,37 @@ static inline bool nfsd4_create_is_exclusive(int cre=
atemode)
> 		createmode =3D=3D NFS4_CREATE_EXCLUSIVE4_1;
> }
>=20
> +static __be32
> +nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
> +		 struct nfsd4_open *open)
> +{
> +	struct file *filp;
> +	struct path path;
> +	int oflags;
> +
> +	oflags =3D O_CREAT | O_LARGEFILE;
> +	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
> +	case NFS4_SHARE_ACCESS_WRITE:
> +		oflags |=3D O_WRONLY;
> +		break;
> +	case NFS4_SHARE_ACCESS_BOTH:
> +		oflags |=3D O_RDWR;
> +		break;
> +	default:
> +		oflags |=3D O_RDONLY;
> +	}
> +
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
> +	path.dentry =3D child;
> +	filp =3D dentry_create(&path, oflags, open->op_iattr.ia_mode,
> +			     current_cred());
> +	if (IS_ERR(filp))
> +		return nfserrno(PTR_ERR(filp));
> +
> +	open->op_filp =3D filp;
> +	return nfs_ok;
> +}
> +
> /*
>  * Implement NFSv4's unchecked, guarded, and exclusive create
>  * semantics for regular files. Open state for this new file is
> @@ -355,11 +386,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> 	if (!IS_POSIXACL(inode))
> 		iap->ia_mode &=3D ~current_umask();
>=20
> -	host_err =3D vfs_create(&init_user_ns, inode, child, iap->ia_mode, true=
);
> -	if (host_err < 0) {
> -		status =3D nfserrno(host_err);
> +	status =3D nfsd4_vfs_create(fhp, child, open);
> +	if (status !=3D nfs_ok)
> 		goto out;
> -	}
> 	open->op_created =3D true;
>=20
> 	/* A newly created file already has a file size of zero. */
> @@ -517,6 +546,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 		(int)open->op_fnamelen, open->op_fname,
> 		open->op_openowner);
>=20
> +	open->op_filp =3D NULL;
> +
> 	/* This check required by spec. */
> 	if (open->op_create && open->op_claim_type !=3D NFS4_OPEN_CLAIM_NULL)
> 		return nfserr_inval;
> @@ -613,6 +644,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
> 	if (reclaim && !status)
> 		nn->somebody_reclaimed =3D true;
> out:
> +	if (open->op_filp) {
> +		fput(open->op_filp);
> +		open->op_filp =3D NULL;
> +	}
> 	if (resfh && resfh !=3D &cstate->current_fh) {
> 		fh_dup2(&cstate->current_fh, resfh);
> 		fh_put(resfh);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 97c83c29d4ca..71c8f3f5e19b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5093,9 +5093,19 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *r=
qstp, struct nfs4_file *fp,
>=20
> 	if (!fp->fi_fds[oflag]) {
> 		spin_unlock(&fp->fi_lock);
> -		status =3D nfsd_file_acquire(rqstp, cur_fh, access, &nf);
> -		if (status)
> -			goto out_put_access;
> +
> +		if (!open->op_filp) {
> +			status =3D nfsd_file_acquire(rqstp, cur_fh, access, &nf);
> +			if (status !=3D nfs_ok)
> +				goto out_put_access;
> +		} else {
> +			status =3D nfsd_file_create(rqstp, cur_fh, access, &nf);
> +			if (status !=3D nfs_ok)
> +				goto out_put_access;
> +			nf->nf_file =3D open->op_filp;
> +			open->op_filp =3D NULL;
> +		}
> +
> 		spin_lock(&fp->fi_lock);
> 		if (!fp->fi_fds[oflag]) {
> 			fp->fi_fds[oflag] =3D nf;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 846ab6df9d48..7b744011f2d3 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -273,6 +273,7 @@ struct nfsd4_open {
> 	bool		op_truncate;        /* used during processing */
> 	bool		op_created;         /* used during processing */
> 	struct nfs4_openowner *op_openowner; /* used during processing */
> +	struct file	*op_filp;           /* used during processing */
> 	struct nfs4_file *op_file;          /* used during processing */
> 	struct nfs4_ol_stateid *op_stp;	    /* used during processing */
> 	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
> diff --git a/fs/open.c b/fs/open.c
> index 1315253e0247..117355ae6bd5 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -981,6 +981,48 @@ struct file *dentry_open(const struct path *path, in=
t flags,
> }
> EXPORT_SYMBOL(dentry_open);
>=20
> +/**
> + * dentry_create - Create and open a file
> + * @path: path to create
> + * @flags: O_ flags
> + * @mode: mode bits for new file
> + * @cred: credentials to use
> + *
> + * Caller must hold the parent directory's lock, and have prepared
> + * a negative dentry, placed in @path->dentry, for the new file.
> + *
> + * Caller sets @path->mnt to the vfsmount of the filesystem where
> + * the new file is to be created. The parent directory and the
> + * negative dentry must reside on the same filesystem instance.
> + *
> + * On success, returns a "struct file *". Otherwise a ERR_PTR
> + * is returned.
> + */
> +struct file *dentry_create(const struct path *path, int flags, umode_t m=
ode,
> +			   const struct cred *cred)
> +{
> +	struct file *f;
> +	int error;
> +
> +	validate_creds(cred);
> +	f =3D alloc_empty_file(flags, cred);
> +	if (IS_ERR(f))
> +		return f;
> +
> +	error =3D vfs_create(mnt_user_ns(path->mnt),
> +			   d_inode(path->dentry->d_parent),
> +			   path->dentry, mode, true);
> +	if (!error)
> +		error =3D vfs_open(path, f);
> +
> +	if (unlikely(error)) {
> +		fput(f);
> +		return ERR_PTR(error);
> +	}
> +	return f;
> +}
> +EXPORT_SYMBOL(dentry_create);
> +
> struct file *open_with_fake_path(const struct path *path, int flags,
> 				struct inode *inode, const struct cred *cred)
> {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index aa6c1bbdb8c4..b848355b5e6c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2640,6 +2640,8 @@ static inline struct file *file_open_root_mnt(struc=
t vfsmount *mnt,
> 			      name, flags, mode);
> }
> extern struct file * dentry_open(const struct path *, int, const struct c=
red *);
> +extern struct file *dentry_create(const struct path *path, int flags,
> +				  umode_t mode, const struct cred *cred);
> extern struct file * open_with_fake_path(const struct path *, int,
> 					 struct inode*, const struct cred *);
> static inline struct file *file_clone_open(struct file *file)
>=20
>=20

--
Chuck Lever



