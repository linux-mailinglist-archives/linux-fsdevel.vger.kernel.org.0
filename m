Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70D50E15F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiDYNT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiDYNTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:19:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9A11903D;
        Mon, 25 Apr 2022 06:16:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P9sgDG027852;
        Mon, 25 Apr 2022 13:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k/L8zUMW5fy9evrU8BDs8BxWZLw/PBJzOSnX4QbOddw=;
 b=zRpyYpKIGfRyleBFhmC7dNWXJpwkMYQ6exEMDzMET4l+26kgcLzph5TFYgKwLtEjUbmg
 fYbUrHTzgjo/l+IlDJNbAgjNYbDYBdIBxjoHeLW7HzZ735n7o0vL47IqWIrFbGT8+Nzw
 /8pGA+VW4zgflzbh9MpIDDP9wxbR0Dj6wj/x56sVu1BiXfhSHKSG2rpKq75f9bkNiGzY
 05yctXqZid+3K4t+RxoGj19XLYCEUyKWml3fQfB1hjfASySAEFMzadYo7Lv15ADlQXJj
 d1erP5xbDwblUNruivUdAWC1llhStrH/6FLZ5chrFSk4Cj6aIoCDFsGwS3JBLZa34CMb Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9ak490-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:16:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PDC5m1023651;
        Mon, 25 Apr 2022 13:16:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w2kct3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ0lh90mzhixpzecQFFy4xiLRu0GtW2JrYzhEQjh6psT+NCou9h/le5mieKbCN9dDS1gMVn8/o+pj13EF7QwcMh384EaZSy75pFPRzi6D+Ur7Peo6EAJ+1W1zWWej6A3SUJsJ+hEVHjlPm1+dZjsVtckpoK0JJbFc8OnmWPwixYGnSjSw+Pf+bTPqdg98EkaoS6Xucsdd20Bnoi5OJOWneFKpFJ3G7tNh3ZFbBS12g7bhQzNo7FwT5xgaISGLca/urzbZRFasVhnI4S8Nz4H6iZVEt1NATe3x08Co1Q8Teq7XNz2oDinq9qpFX2xS8RqUsPl6UQ9++s+xkPnFeKAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/L8zUMW5fy9evrU8BDs8BxWZLw/PBJzOSnX4QbOddw=;
 b=BuO9YU04SQ/p3O/fRXzgoj9FQFY6JdEPqv8irXN2S6UM/GmRhmLfpktZ1p4YEVNevlVmijYJ2ft979rHAf39JvkvPLqH3wBF1uwJl9rrkW8ubMNsDiDOjbhyxupm8wc013KTkk2+/oGVkEMQ+iDS33ijawKx2ZJOCq0Fir93cOHSusMp/P4n93wLxrL8PkH1gArYZalmLwlfXYrI73xubvN3TgyDpSMEnEfkOeEauRm6PDYo+gUAcOEncVXTZSjgJI8lBoFcikKZ78wj2IpJGYMzQM/5YX4dIS7YcZbtsHo2nWtACLThMrRzhfCYCj6LP86ZBVCAq1wbb4uiMNlrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/L8zUMW5fy9evrU8BDs8BxWZLw/PBJzOSnX4QbOddw=;
 b=BKFsl6T2R+wb3f2yAkY+szT5Gk1DmU4KF2js/EPnLQSnyH6vMXZDVANgMQ1mo9i/l4b3fcozWbzsMufPUavL333S9PVV/CHZN2ic3zQWwoNts15vyNStYE+RnqkL/l1Vrbnr3FcWH21AEToXtBzWUZn102okzIfaAgPRN6Ct3vA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2622.namprd10.prod.outlook.com (2603:10b6:805:4f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 13:15:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:15:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v21 2/7] NFSD: add support for share reservation
 conflict to courteous server
Thread-Topic: [PATCH RFC v21 2/7] NFSD: add support for share reservation
 conflict to courteous server
Thread-Index: AQHYV0Ilw4jb0ZDRd0W7B73mSAlhEK0Anq8A
Date:   Mon, 25 Apr 2022 13:15:59 +0000
Message-ID: <C0354D9B-B980-405E-B70A-16A8D9761D7F@oracle.com>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1650739455-26096-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eb66227-8b7d-4a15-f99f-08da26bdbd2d
x-ms-traffictypediagnostic: SN6PR10MB2622:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2622295E240226AA2897714E93F89@SN6PR10MB2622.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3d54XgiqihB7/Rj3/BdDTq6FDWs2hbxHtZQp1S9P91WXZAhVdOSuxz0ZFYXHVvDdCx0udXIARvGOp2ppzoXm5iDAGVUMZzJZlf0rOxqu0U3quo3Jlam7jKazBM1Fx0egP9hgQfoompzu514cSsQ0FXFe3ed+i7Htk8Rs0u/ZawQb5Qc0AbLET62/iSlw6LdBluz6P+Vg5gtQmE+ezrD+VTTqMuleWTTGXkvhabWOceJCPFhK6sePYulepq1ZyAMAHVCiS7k3aEBmzAJtRMp8Qq/UNj26Bdm73ybvhMIGV/A1+31AOezzsdH5BHcRAGWk1cv6nSVzDsr0ejpnK1mLcUUKFTvHnnk3Hlzep3qvQ2ZPiuvJiw8qUd//CBmxkZHxEawzqkekV5trLT/C7ACCYsg1HzTYsNxkwjBLyxLUoSJRMMkUD2+42FmFW4W8Npn/fuDZ1F3eFssEkyVKxkWTxQY/oa3zsMGi1oxroTCu6l1zC5tFFqCwAXFdr5AfsmDq2qqOk4pSf2JaQWJ7Lq0NA2ieRYF7i71guHkI0XJ5hOELMWpnLr0vsND33WV+yBJK67v3sRbp7fgaaWo43OKiOR1Trbs7a4pxRR3Fu4pgPtgdE0xr0LYoggRbBxeOOideqLOz0qzC8CKsHYKwf4wmdBeXScLRZFXist/2URAsX4BDgj6pVo6DpkGAum5/ZD8T+OanTkTKyt4TY1AcdGyDT1pp4EPRS7yLtLkhZXFCQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(2906002)(71200400001)(53546011)(66476007)(66556008)(122000001)(6486002)(86362001)(38100700002)(38070700005)(36756003)(26005)(6512007)(186003)(76116006)(66946007)(2616005)(8676002)(64756008)(66446008)(6862004)(4326008)(91956017)(6506007)(33656002)(54906003)(8936002)(37006003)(6636002)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dxUjd/D5dCv0bNMHjEZNtEGV19LHcGE1G1GLgvBfsPkAZOGmPXAIxHwvaMDi?=
 =?us-ascii?Q?gXNUhyp8nKI4FNG63gZy3ha8NX5RcqsBulUXHnPxHamdHi6Fg5X7aCwzw/SW?=
 =?us-ascii?Q?AVbaar87pqryoRUXvxuZCbeDizcoPyMD+RYjfjFh28QzQGdmJKR+52JNnpFk?=
 =?us-ascii?Q?Wkl25E6G/ykRMvvtm/w8VnHmIxSr94CIFR6ujUhUUTlWxDkyedMman7QgwLa?=
 =?us-ascii?Q?WhTN5Uji/ETU5erYQPT8X5c1wlsybFW4PB/vfnhcw5G0K9130B1GmsMaWl60?=
 =?us-ascii?Q?NuQtmGHj3b5Sd/QLctllMY/2RvqGsbzTCbFkR02YD8BHu4AT4xWO8QquPo2G?=
 =?us-ascii?Q?XoSTc5oHw40GybGpuMI8aUAQduOdEFWpOBF/tpgSYOoiqg/V+AjMvW1B4hfp?=
 =?us-ascii?Q?2dO6ArsWSjv8r/iqTYheCR5IAX0sd7fnrYBcNbTMJ4lTYxUjrOhr8IGEMNpd?=
 =?us-ascii?Q?BZB9ef9QRlVwPquTWIE1e119k26TLHVN/WM5rtFpomK+ThQQviqaKGc46eAf?=
 =?us-ascii?Q?ZYoEKooCFmJ/KqtsKnelQ3saDtIoO6gHpkMfixJ/BE4uRpn4JjQ+ZG5fGtJo?=
 =?us-ascii?Q?uzx1cobjj8AGiBspW912j8tpbfGa052WQHdHw4GBhWznuNv0Wdg7OrYtDmU2?=
 =?us-ascii?Q?z4pipaZVve/B/rTO/qCECQU8bs+MBnF86p1xONiD9ZYsPgaKUqyhDwGr7lCb?=
 =?us-ascii?Q?2uiCem2Co0JD73lNdnQ0CV1QqvHFvUOhrzJx365tRK59TsG3G9fktMnYbJ5z?=
 =?us-ascii?Q?Dp0PJZWnhCEgNDW8cs6p7/5q90Lpeo9i5ZHpEjyW8/bOZpQ5mcioaWXLFS6U?=
 =?us-ascii?Q?8yHwQK/bvbCVP+98xlxq6UHuOXIboCWU/hnArjckAGDyAJJzXrYk+SI95HsS?=
 =?us-ascii?Q?qG+yRhv8pxXxizlGSlIgYM9nlOujQXFVUdNiLretyTQNf5oxo96SV/f+0fid?=
 =?us-ascii?Q?nwuqtlsCwwwcqvSxR3MwATTP2B/8+Q806Ul8TaMIHPjt1Crc+EgkcL3gS8Nb?=
 =?us-ascii?Q?YjvWxnHkJH3MOQllOPDMOyUnAQ9qu9QnC11VECXu+ZX9aUAEdTIFDb698L5p?=
 =?us-ascii?Q?1gwS1sEKy10JPG9mUTxpPD4nNfWbTDjI+g5FPSv68PPWK7CsA0lnmYAy/1zU?=
 =?us-ascii?Q?oSdZk95iSKfIXdmtRUd+w/xkePtm5hWT5teIaVh4HohCqkA0zLW5f4+n8d7h?=
 =?us-ascii?Q?FW+hM3SViDgaVPlFO7EB268q0+Q7Xmm4FQpx5cT1Ss7ipbbvTZBzEoaQ3dni?=
 =?us-ascii?Q?W0Cwy/XBUZ2njtbFVtSM8KtRgY5hd6mWSnkNKJY4xGU7OmfFWQsvrRmVqaMt?=
 =?us-ascii?Q?cq+uVzHx2EWdMlXdbMH5d1xFUjwKWXuN8MpAZ/Fl9ZQ/lgX5qxXzD4PPctv9?=
 =?us-ascii?Q?ppcV1nXW/txx3e7a8oc+8xUdOerrt1Ij+5zA/q6wsN6kdOMsznXVqiHkleXy?=
 =?us-ascii?Q?5KUnsYyyR84ylooqSXP83LB/go4/Cb4SIC5tHpJ/j2pV29sMyda2Zww1BXTu?=
 =?us-ascii?Q?XOBwTrexQOxgIMNnjUTd/1rRE3InonwWnfyri5iTfVG8SGfpi3GGn+ICTjN9?=
 =?us-ascii?Q?E8DKGL+IYNgM+wNtFxXXOfdpMcTYCqr+oSCZxAavSgVwFn5TPdK0p0spyydu?=
 =?us-ascii?Q?6H+0KTy/g3VrDbqk1fPairnuT5ggC8iyCmF+yB/JIXcQNmiCy7fhE1UKzXfe?=
 =?us-ascii?Q?YdzDvv1xjYMFOhaVeBgCa6FjNoMjh0Fk9LlXPj1QD0c2huPAYNEKdjLltv5F?=
 =?us-ascii?Q?tmAIBHaZHkWjVNcaz2cRvIOfw0T3+x8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <177F8CF6DD082F4191E1560C0A8A46A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb66227-8b7d-4a15-f99f-08da26bdbd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 13:15:59.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nnoJ4K240jz6CDQLgEfLOZFFfGHOYpAVqUowjqO6DdWgEEdcnQhnHH9BeiVE3tikGybjYKEerNNujCpzE1iTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2622
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250059
X-Proofpoint-ORIG-GUID: A0AJ6sGzA4kTdEqXXnfuPZ8V6WXV9ljb
X-Proofpoint-GUID: A0AJ6sGzA4kTdEqXXnfuPZ8V6WXV9ljb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 23, 2022, at 2:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch allows expired client with open state to be in COURTESY
> state. Share/access conflict with COURTESY client is resolved by
> setting COURTESY client to EXPIRABLE state, schedule laundromat
> to run and returning nfserr_jukebox to the request client.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++=
++---
> 1 file changed, 105 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fea5e24e7d94..b08c132648b9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -700,6 +700,57 @@ run_laundromat(struct nfsd_net *nn, bool wait)
> 		flush_workqueue(laundry_wq);
> }
>=20
> +/*
> + * Check if courtesy clients have conflicting access and resolve it if p=
ossible
> + *
> + * access:  is op_share_access if share_access is true.
> + *	    Check if access mode, op_share_access, would conflict with
> + *	    the current deny mode of the file 'fp'.
> + * access:  is op_share_deny if share_access is false.
> + *	    Check if the deny mode, op_share_deny, would conflict with
> + *	    current access of the file 'fp'.
> + * stp:     skip checking this entry.
> + * new_stp: normal open, not open upgrade.
> + *
> + * Function returns:
> + *	false - access/deny mode conflict with normal client.
> + *	true  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_ol_stateid *st;
> +	bool conflict =3D true;
> +	unsigned char bmap;
> +	struct nfsd_net *nn;
> +	struct nfs4_client *clp;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		/* ignore lock stateid */
> +		if (st->st_openstp)
> +			continue;
> +		if (st =3D=3D stp && new_stp)
> +			continue;
> +		/* check file access against deny mode or vice versa */
> +		bmap =3D share_access ? st->st_deny_bmap : st->st_access_bmap;
> +		if (!(access & bmap_to_share_mode(bmap)))
> +			continue;
> +		clp =3D st->st_stid.sc_client;
> +		if (try_to_expire_client(clp))
> +			continue;
> +		conflict =3D false;
> +		break;
> +	}
> +	if (conflict) {
> +		clp =3D stp->st_stid.sc_client;
> +		nn =3D net_generic(clp->net, nfsd_net_id);
> +		run_laundromat(nn, false);
> +	}
> +	return conflict;
> +}
> +
> static void
> __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
> {
> @@ -4995,13 +5046,14 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc=
_fh *fh,
>=20
> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file =
*fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
> {
> 	struct nfsd_file *nf =3D NULL;
> 	__be32 status;
> 	int oflag =3D nfs4_access_to_omode(open->op_share_access);
> 	int access =3D nfs4_access_to_access(open->op_share_access);
> 	unsigned char old_access_bmap, old_deny_bmap;
> +	struct nfs4_client *clp;
>=20
> 	spin_lock(&fp->fi_lock);
>=20
> @@ -5011,6 +5063,14 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *r=
qstp, struct nfs4_file *fp,
> 	 */
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		clp =3D stp->st_stid.sc_client;

@clp is set here, but the value is never used in this function,
even in later patches. Possibly left over from the previous
revision of this series?


> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
> +				stp, open->op_share_deny, false))
> +			status =3D nfserr_jukebox;
> 		spin_unlock(&fp->fi_lock);
> 		goto out;
> 	}
> @@ -5018,6 +5078,14 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *r=
qstp, struct nfs4_file *fp,
> 	/* set access to the file */
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		clp =3D stp->st_stid.sc_client;

Ditto.


> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
> +				stp, open->op_share_access, true))
> +			status =3D nfserr_jukebox;
> 		spin_unlock(&fp->fi_lock);
> 		goto out;
> 	}
> @@ -5064,21 +5132,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> }
>=20
> static __be32
> -nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct s=
vc_fh *cur_fh, struct nfs4_ol_stateid *stp, struct nfsd4_open *open)
> +nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
> +		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> +		struct nfsd4_open *open)
> {
> 	__be32 status;
> 	unsigned char old_deny_bmap =3D stp->st_deny_bmap;
>=20
> 	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>=20
> 	/* test and set deny mode */
> 	spin_lock(&fp->fi_lock);
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status =3D=3D nfs_ok) {
> -		set_deny(open->op_share_deny, stp);
> -		fp->fi_share_deny |=3D
> +		if (status !=3D nfserr_share_denied) {
> +			set_deny(open->op_share_deny, stp);
> +			fp->fi_share_deny |=3D
> 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> +		} else {
> +			if (nfs4_resolve_deny_conflicts_locked(fp, false,
> +					stp, open->op_share_deny, false))
> +				status =3D nfserr_jukebox;
> +		}
> 	}
> 	spin_unlock(&fp->fi_lock);
>=20
> @@ -5419,7 +5495,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 			goto out;
> 		}
> 	} else {
> -		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
> 		if (status) {
> 			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> 			release_open_stateid(stp);
> @@ -5653,12 +5729,35 @@ static void nfsd4_ssc_expire_umount(struct nfsd_n=
et *nn)
> }
> #endif
>=20
> +static bool
> +nfs4_has_any_locks(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +			spin_unlock(&clp->cl_lock);
> +			return true;
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> /*
>  * place holder for now, no check for lock blockers yet
>  */
> static bool
> nfs4_anylock_blockers(struct nfs4_client *clp)
> {
> +	/* not allow locks yet */
> +	if (nfs4_has_any_locks(clp))
> +		return true;
> 	/*
> 	 * don't want to check for delegation conflict here since
> 	 * we need the state_lock for it. The laundromat willexpire
> --=20
> 2.9.5
>=20

--
Chuck Lever



