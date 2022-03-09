Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8394D3C53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiCIVr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiCIVrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:47:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F711E3D3;
        Wed,  9 Mar 2022 13:46:49 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229KcmI3002635;
        Wed, 9 Mar 2022 21:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Rqu3g4zNhquP0GEmEXa8Q08yakGnnJl1dDFe13zfcLQ=;
 b=DQ0ZLtqpSuCIqhTS3V/xZkUcJitYFmt+Kx8rem5O7q/tX/6ZrfIlNnkQrK8W5l5r10I7
 uSdr7uaeJl7J0cpPTZxlYL3E+w3UzjpO6EQ2lyZA5CLRSstyN8iAugk7U8XvllXJT/F0
 GuzUBlRs5L67vE+Ion3VO5EddKvaTiewtMIoVUYu+1oN/ZBU71KEuGYu3BcG/M9P8lyC
 EK7Oi7IA1PV2L0s/n/Y5OqcX5hCKQnQMmNx4I7E9R6XFNQ/IERzJuultk7xnelQzyTyH
 onZCNunT3K3XpwWlmL0Erwx1yBn7d3Qs9nJ2uOnb5NOB92jA0shEzd+Yto3/oFC3j1oS EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cka54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 21:46:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229LUWBQ012597;
        Wed, 9 Mar 2022 21:46:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3ekvyw6818-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 21:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHAD7Sysz7j9h4ad3OGr0/Sa1mGurMHU9vsoxXzKTm5jUyR9+FoZMp3Ew7MQnI6V5jB6PQrDH/9g8trjuIC3KoId5ltOvn88xaXonWAYmlIHdOCTtKNY/ytGpWCZzGHHb81VRrqqRwMDt9DXjlcRFKgy4wOvC2bG7hMyMdAMtN3bQiQRQSrRIHg3VG1uknIWd8y3/l0YMr1v7opuTYp6gRzT7H3FlStGX+NBsYKKqUqKsT9nL58FRdFCi4nLhU84ONZ715lHg2UMd+CEPb8+jRTKqoqhjOnWbOHMy2OW2thwVmN0c2M7RbbpxoAnCIwzZVQqMCrSsh1O/9SNabqSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqu3g4zNhquP0GEmEXa8Q08yakGnnJl1dDFe13zfcLQ=;
 b=KcPNM7R0sro1mWykbL7j+z8LqJ9FDOmhn1MfvX1LjU6wzIGukKgGbWJa3vfGldk3Mcy00v/MsiQIW5V+r1PHpyeuKtIKZzIj/3tUnzmlAyngnSUwohYnbg3o6FzWH57rpcTlwBa8z6AgnKFMI4Vn0bTV7Y08TFgQFNehMi1MkpL8/6evi6HB4O2nqOrixbdD3A3iozPg8k4F2czT0+Nc+N+1DFP5sM9AQP2Dh07P7jxkFYm8WQG23AHz8B3urYEhhy9SflAFWgy+BA3mAFZjdGwAn59C2j25GeJ1kd5ROrjTbIUn8w+2/Fce2OOFdM4iq3D7Eksm0vUSlIcHmBrHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqu3g4zNhquP0GEmEXa8Q08yakGnnJl1dDFe13zfcLQ=;
 b=w4cKOJGDqhEHLXyv8TbO0ORNFQwsitXXh+1zHL1dZK+mth8kolFMn3pmFiHAFmztiUcCaEQsCe7F14jZRKkf1v3zayyHfYOP29h9Z2qDjkS2YTerg4IamgEYCUU39AjSti9CX75JQyh+K8qpln0uVZ4OQZeSwFKHQWuIcjOevWA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1833.namprd10.prod.outlook.com (2603:10b6:3:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 21:46:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:46:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v15 04/11] NFSD: Update nfsd_breaker_owns_lease() to
 handle courtesy clients
Thread-Index: AQHYMCkuO3+8v2ZQTE6s2XcaoPiYRKy3nf8A
Date:   Wed, 9 Mar 2022 21:46:40 +0000
Message-ID: <541790B3-6B92-4A85-8756-04615222EFF4@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1646440633-3542-5-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bb7efe2-d809-4468-1828-08da02164bb8
x-ms-traffictypediagnostic: DM5PR10MB1833:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1833BB7D72AB807C74684EF3930A9@DM5PR10MB1833.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdxDrcwh+vnIwRVeZh22hXYx0A2R65XqA6xem13W0bTdrIutlae1yO+j4y5x6upXR6OBVF1lMxVJXJ6yEYQqcdzul1orMcB/ijCg/Pd8gObHeEQccRHNoxWdbZTmV0Rq225WVnJEoePjHfLX8NXRT3+2ZdV34o0brx+v9kJQvJ2twlWy3WUHB2yu4kYV4q4fv26Z8RV8avX1FfBqutAYsVyQg2SuRdnhtxWhimMiC/jMRv/DonmnB7GvGdP6dxZqFg/MOkq2B1KPGjqcJ9H1W6tiTXQQ9s2h7BW+R3xU9guqUVxqe9RdQ30PCM8Mvhmdi+YLdtOSXw48aXy90Zrkdd1x6fa0fPpYQL5iQK4zVDFhp1iEbXZdft/LmSRhpYGfYqsKr4Q8ToR/trC6/uiPkH30PQsCPWxA5zIqZZynkUPM9mcHl+DYl1YAdfbo6V+9l5CIvfvp8VUWA1cJLnTvhmi8ucMhaYsxJphfXjllKPy6YJWnVP8RzIjZyPITOo2Nwl3g575jp58FIqum4ZSjx/ptASbtdBH1eQd8pWYmpNfzwkFjroc5tQvEjVX/Rnf+MVDNRniWRaQsRcgDWNR3aJPk9tJSFxfJXzq4/qctQ4zxPWiT8NOr3q/9WFGd0tTewp1Bhg2nw78J421qfAHbsi7OxXwFHKttNkOPtMn/A8+oSbXdJPCznoZTe4T3VT6lWJNgv91n8PaIB+q/io6INfir7N+B7r1hh+yinRrntDalT3zcpxSUdIU75iP73Hgs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4326008)(86362001)(53546011)(2906002)(71200400001)(33656002)(6506007)(83380400001)(15650500001)(6486002)(6862004)(8676002)(66556008)(66446008)(36756003)(66946007)(66476007)(64756008)(2616005)(122000001)(38100700002)(186003)(26005)(5660300002)(37006003)(6636002)(6512007)(316002)(54906003)(8936002)(38070700005)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JMOlYY9XyP51zRz/WMaaXbWGJDHptcMWi54b8/iKpAFpaPNtX7mFtJlhR83n?=
 =?us-ascii?Q?OpEjKuTu/PUGACMPg6+dodwN7z/tvX//UQtdtmktuhTLW0d0TZwLhuDqNkSi?=
 =?us-ascii?Q?StLMixDCyQ4P6oBIX58aaAQz2oy36SIMHvQgv179CBTSJE2Frs+mvSxehKP6?=
 =?us-ascii?Q?ikID3OzjCpl/ieVoYaJiaBFzC5laXgixu/cdBp9eKfWHxx/ymX4xuW3HgxJg?=
 =?us-ascii?Q?wAffE2sIDtQEofMeFpgXAQ0pZbxndlR0dhMTF9QBQBwF6eHeX+omksJ1OjO8?=
 =?us-ascii?Q?DUTIUYEXo1CMxYJRDQQU3TPumHWCKF+DTGURAovJnqITscJvFUuskRmppDf7?=
 =?us-ascii?Q?r6RLciwj37tLxeI8ePfSY3TQ/ESIxjyFLaz4SZ302lnPrCCxVmuXlLDlFQnZ?=
 =?us-ascii?Q?q1VshhtzMcpV2jntZNdSzlYwCLwcTCTaVBxkdPmmJIYXAGfFtcqAwOW6VhWG?=
 =?us-ascii?Q?bsL+gIgiwkGJkcNSntgdsCP36reKw25IMvIug9nWIZAfTWeJDm6F7AtcqqIE?=
 =?us-ascii?Q?bgE1hEvdY9BVh1oLWglht8qnSYBtHZEOyq3XLE8zuxU+ccGD86+qG6KGU5g1?=
 =?us-ascii?Q?b1EIVPoSLb56FsW1+FMToNF7McW2mMkueKUj/oweCfHWNdzKhyv2/QOCl4fG?=
 =?us-ascii?Q?f622PK3sMtUxcTsgSMeyG7qH4lOA4nHPDVBxvv+F7fVQ8U3JKUb0r5n88DkF?=
 =?us-ascii?Q?y/rb0vkbdckkBedfIJMIdr508CC48JXYXSAsmpCiXMClqbPnIqXkgScZxk9W?=
 =?us-ascii?Q?ChToRJYiHYHyNo/uXLHdi/nnvscMULcm3RXf8lIuPrOG+9gyqs6lHCYFkYyZ?=
 =?us-ascii?Q?tScmIKKH7osP7rQdkaLI/Q3G0LucEM82FHjofOBFYi3hoY9zlGy0YCiPm+jb?=
 =?us-ascii?Q?Zl6ZIu7GbxMmqN1SW65lnYGv2+irTIrzbN9ScyDrbP5abIcKNIHxoNio9khk?=
 =?us-ascii?Q?gePbKcrI6052mEHQ+IeFNY2dFvg7DciHdhuZBIoOmYS4HMG8TEZLo0XyehpJ?=
 =?us-ascii?Q?/qX3ywv1WG6ERjqPn3Tp41k9xRlOtoPTOIAnR9iQ5m0HZS6maCWFK5d/hzcn?=
 =?us-ascii?Q?VNnP4Y2SXJunoyUj5X3imGkqfjIlrlvAMNb+SK3BIzKSkwpmS5/z+9uef/tG?=
 =?us-ascii?Q?wbOMUldUpPFJBdcsK/00TMonMKSfOsPYeSkFxDpl7/fai/dXTMZTsgKBoqKY?=
 =?us-ascii?Q?sJM8knGQWHMCL1k8sgYWpBA9nD4njUS2RrBUO0ifsaUQJOBrS5d7l9s6G22X?=
 =?us-ascii?Q?x2pzYXUK8qcdcln27Wv20vGe2lfpCzhxg7Q+Mc5C4ES/E5udgOYFu0Qro2TS?=
 =?us-ascii?Q?g7LMx2o98aBF/YXegXcI96QbgPSXEfMh/Clci0TVmnmK50Za8tlC+5Ua3FMk?=
 =?us-ascii?Q?P4esvHMT6LzH8iRi2/R2VlkPx5ayWzzBcZWqgarBpkimEyENuq7UpMRYxtTz?=
 =?us-ascii?Q?WgUy/azXX00SeCF28Y5RL8na3HgnoMHtCQLuJAPr4PlKmqGqQgMgDKmfwbOy?=
 =?us-ascii?Q?0dt3fV5Ylpxye7g3SOsHTpOMu4DAXJxWfYUwKvL4m2QvwwB5tFmC+LlK7gi+?=
 =?us-ascii?Q?hd043XKfEenzG+2GlMx+vTsQXrk8YZQOA2vrjqCetMPWtrEhgY4CnTNk3Rh2?=
 =?us-ascii?Q?Pn/6pB10uZkKSWkvTiST8HA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0716519731219843AE356EC7E0B64555@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb7efe2-d809-4468-1828-08da02164bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 21:46:40.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8f/yQpbph0ahU1d1Oa9WsDBn9Xtgwtbho14vQEqb3rbGRdRcu2F1z1UrPmR8baW6pvzfdlqCm1cuH+uQZ3+YXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1833
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090109
X-Proofpoint-ORIG-GUID: VUCPmM2yeW2u-68mtrJ9AqgF8orZ0iMn
X-Proofpoint-GUID: VUCPmM2yeW2u-68mtrJ9AqgF8orZ0iMn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Update nfsd_breaker_owns_lease() to handle delegation conflict
> with courtesy clients. If conflict was caused courtesy client
> then discard the courtesy client by setting CLIENT_EXPIRED and
> return conflict resolved. Client with CLIENT_EXPIRED is expired
> by the laundromat.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 583ac807e98d..40a357fd1a14 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4727,6 +4727,24 @@ static bool nfsd_breaker_owns_lease(struct file_lo=
ck *fl)
> 	struct svc_rqst *rqst;
> 	struct nfs4_client *clp;
>=20
> +	clp =3D dl->dl_stid.sc_client;
> +	/*
> +	 * need to sync with courtesy client trying to reconnect using
> +	 * the cl_cs_lock, nn->client_lock can not be used since this
> +	 * function is called with the fl_lck held.
> +	 */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +

Nit: Please add nfs4_check_and_expire_courtesy_client() in this patch
instead of in 05/11.


> 	if (!i_am_nfsd())
> 		return false;
> 	rqst =3D kthread_data(current);
> --=20
> 2.9.5
>=20

--
Chuck Lever



