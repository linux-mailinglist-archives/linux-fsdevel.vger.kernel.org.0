Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E649870828F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjERNYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjERNYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:24:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816CBB;
        Thu, 18 May 2023 06:24:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Io67006515;
        Thu, 18 May 2023 13:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X15/zuhDkJqu7mrT/+65aCkMoNCH2DkFvFPD/cMK1js=;
 b=0Ft5QnyWO3k2JoZJKqdzlhJ9jHQtX2m0f9kPgDM5iN3EdAodnahYGHfPtL1wKphMSkzq
 18qfUOZmIb5AxGg9OGZhALkC6+gsExchlOkYt3M659DgbFG/9H96ZpsxV4yotYLsUJdD
 su6nEVQ+lAohv7Z7nFcGt0DqdH2g1MNB66g6ZlBbgFVCQaIJ2a51dO6I6C5F5irqacrs
 emZuoHIMXqIDiycvNWgbW/3yBOe/oASLnCru576CsaY2zmU7JvfBL4otREerMLvUsPEs
 O4xS4YG0n4zYX2qakRhB3XWWfxRl/cOJbdxnGvc1fKqK0lpC6AtUtp+ccFzH2sTgPXjI cA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye7v2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 13:23:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICFRY7033869;
        Thu, 18 May 2023 13:23:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1078py2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 13:23:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLyiXRoMLmu+b8wCtfjIuFPD0Zww+I5El6WsBq9A2AukpESs8GySoj59BzhrZO2ymr2vYJk8/2jjZalOXL5QnWbprDpOKQAN/MAc6s1a60U/WMjfKrwq2JZGC5bE8AoJ0N+XqvzrJYM+z2qw/hBJ1rN7OOFekSYHHD5V/lfPFpcfschxEvhJSINXpqOZ7mre93Aa4zztcvr0jxuzV7sNl1eWkj8DItX7dxauAEIsP+c7Un+xIHp9oRvwjHDdLIJojiJ5f8bGCm4mWjSDmpS3yMZ3gXYUMtZrgndbQEGzmEWcokZg7crbLD7LhW7pulInYN+7NhEroq+NdY0e+8gIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X15/zuhDkJqu7mrT/+65aCkMoNCH2DkFvFPD/cMK1js=;
 b=gRTzdCqRchdYlZU/65hN4pdL3cMDH9kzmiF+4XlmBSnLv5Qir2gIIKuDrS5DnQ7dEyHbeFs4mKvZ9rlDYtOXHUNDNQaNrAUJHF9Y8rr7xaq5JngPi5KS1oGHTAQzaAoGbXJvpznTNcrPp5Rp8PDafb5VD0XkqEk7i9bke8l6GkOp1KWsNs2MuEB0yqmOvq0HtSPoA7tr45x5mtNS+0E61kC+GLUPt+uZLAwVEl5ETN+Ylf90khQhrJwMjfRLg1MeYLX9sr20op0dhrKkOBUIcrqhaYhmduW+s3H888hoDin/36KjXNjBsbSU12v+a6vEpFJ7QB/lc20SS7OF50zWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X15/zuhDkJqu7mrT/+65aCkMoNCH2DkFvFPD/cMK1js=;
 b=Ivlw0AjLUc4+BPtUq39pNS4GM4AQ5V0Vws4lVSuwn37vMjCUIrqIhnpkj+tr3uIgejBmb5MWlaivP+8QbO0HfvruWF2CSH6XpRrlstGt1MC1Y6UQOOkp+hzX2rerbnjlg5YFHkOv2/BqOAHXYllqQDwWxWZrsJqu5rOiPoOkfYI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6443.namprd10.prod.outlook.com (2603:10b6:930:61::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 13:23:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 13:23:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] NFSD: enable support for write delegation
Thread-Topic: [PATCH v3 2/2] NFSD: enable support for write delegation
Thread-Index: AQHZiRjK2+pv1cqK90qCm9rFy+BQfK9gBbuA
Date:   Thu, 18 May 2023 13:23:51 +0000
Message-ID: <1B8D8A68-6C66-4139-B250-B3B18043E950@oracle.com>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
 <1684366690-28029-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1684366690-28029-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6443:EE_
x-ms-office365-filtering-correlation-id: 12994bfe-49b5-41fb-cdf1-08db57a31f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZDEN622RtJave2wbgqae1PeDLu3g9BeiLtdXArbQEkGFLdGmr14KLfodheJqS0x2fQlp8yApP7LqDEYD7FpAks0sF+BwrFJDPt2KWzEO7tzpw3DQaN0kp8hJGVSV7sulYyjmrAkUWEM8CFZIcnpHp8iK7IllOClhlgGtaGmWm/38yBL+fPkF/OgnZP9AJUbjif5taqkFiwZ3/2IDxjEvhKrFgOE/iBwhI731sgGY3v1vPAtzPOEeftYos0NJqyvdaeWmzD8xacqQk0dSMu8ioZzGKZxc1TnXJEbUZoRwleR1wQakKKJalppPBz0ilKKByw1IiW408KdraQ4n/as4y15vOxVvWtxPVebCKy9xt8w7v+gMMNYa0Lh5o7d1VmeK8ON2ChO8JhZ3vKjh4yr9RrZ49Tc+IfpjyQCkNVQXLIDEUzSTOzR3pgIBX2SEZZX571zAl2fVTc124OCFlGXXhe58BdxIB4x67LgBPaCtm+wQSMXmXW7RCMyW9MkDqXMK82HV9hn2PMUKQfdCa2yon7qtFdLglAhDjrjSC+0jvVjibJcPCLxmkcuxbsjsayUgvt/h6ikmNjRvveiTjKmQ32EJnOv15O9byoWHRy1dD/KD5RA/AAbUCcLgLSUevKYwTbM5eTmerH/Zov3S152Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(6506007)(6512007)(26005)(6862004)(6486002)(8676002)(478600001)(186003)(36756003)(316002)(122000001)(6636002)(86362001)(91956017)(2616005)(4326008)(5660300002)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(38100700002)(54906003)(37006003)(33656002)(71200400001)(53546011)(83380400001)(41300700001)(2906002)(66899021)(38070700005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zwNVQWaRHFx6SHAxUDMsje46dw/PAZwavGUJDH/faQXitpCXH9MSLC1b2iln?=
 =?us-ascii?Q?kV2SuWYGUFIBfxRielCFYSDsEdGDyqwmOLwWRMIpwmgD9ZO0Pw6mB7ONRGXi?=
 =?us-ascii?Q?LqTjfbRKG7h/ycYXp2Bvj0jjqmzOX4tdxaxoCi69Lpe8iOs0l2flmJtC6np0?=
 =?us-ascii?Q?M2r4MwwVbWE29fsnqmZnsffZXx4qdyU7HeFM6wF3rbcDNkGTBokOWNT+s87D?=
 =?us-ascii?Q?wKVF14dcxwX/z+neLUb48NICY2J3xTKD4Z0nEFItW8uDH1QXB4wbs+YKBTi7?=
 =?us-ascii?Q?/y8spoHVVN6mQFJpUXVibSOaxC/qa25pXmf6YBBm9Y5RKiuQPUJ2uZnUx7G5?=
 =?us-ascii?Q?ocxQknU6Mq2PSxpUwMu333AId/f9s+ZosZeEEtI5/O83ES2jRWkb/MTX8tbc?=
 =?us-ascii?Q?yKn8I90giKv6HL0GfvvLxJyeRnh6GDwD6WHf5sE4+fQu3teOfLeePVJD9XMG?=
 =?us-ascii?Q?+sZsdnsYkpB/K0XvBU9n+stjapc6Hy0lp5kPHN5zENRnOKlKpT41mHTyL6PM?=
 =?us-ascii?Q?oCPDisuHdXFlpLIp7xJoRVBF+UNh4tyBQOMnOev3ZiwM2cIESlgrWwSti8LC?=
 =?us-ascii?Q?nmmSvHUTRR9dIn862h93uWu/35qLvGKPsRSQJ+fqoLHszwChd+GmmTWd4mIr?=
 =?us-ascii?Q?vB14nCCkh0X40IF6eKmMS+4Rskul74VsqV0kG8uZW+it0QIDjTeQt/TTeDLW?=
 =?us-ascii?Q?hlfFcw/OTLZNdP9dxJYziXT2/cqAmtrjvlJnlAJb6eGkAfwncVC6bu6FJg7u?=
 =?us-ascii?Q?1tKp6RkYhC3ZT11R0kuS3aelrfeAOe7G/wKXKmOr6ooUVUH0/vfwOYl8vyzR?=
 =?us-ascii?Q?KRWhz6nbkA9gvQzFCf7W4Crk3W0yfgqYak+Zt9Y9teFwOV0wg1Byn3TvnWte?=
 =?us-ascii?Q?frCcD+mPHymgWhglQSmX0g7wZlxmVaAd0NG/blxB5s998695q8yfvhSQsgJv?=
 =?us-ascii?Q?RO/AJSuy9HlrHQEK2Yl2caLTYdWtGvNQoXDqL7M823sroIkngsDJQFxe2+89?=
 =?us-ascii?Q?GQSfKMPZPOFFul5DtPV/Ibhsin5MruU6FiYzAm2p+kN3Rc3j/f1e0X7vk2Ks?=
 =?us-ascii?Q?34uBsSGumiXXVTJ1+UiZQPzpvSJXjREN+wl0/3OFghq62uzPyCnVjZd33Wt+?=
 =?us-ascii?Q?4h4vxp8Nlxy2IpGgmd8hARI5Z2NDx7Tp0Li3vomLp21Jh3BG7h6eqj5b3P9T?=
 =?us-ascii?Q?h7Eo2Hitfy985NHhCll0wd1P5uLgxiuXGqeEQrtCO54z/0//MWaAkDpDrrmP?=
 =?us-ascii?Q?aT1mGr5/7vX8bTUMDgG0PsAu2LkIjsxQwfkGk//Co6EbhomDY1kdGnm6mQYD?=
 =?us-ascii?Q?kofTV+pmKkOynjS8UJ3gFUwxAHpmBgLRnCOTCGQNHQ2VeZFZwBWw/QIYutjb?=
 =?us-ascii?Q?Xx89CfGReCscSpi2wtqwoQVKAGsBiLIqENNCR145L3hYukzpXKuV8SIO17hU?=
 =?us-ascii?Q?F+t0V4gZerebdc4LbZZJhkimGekOzyjKlJontaydLeE5YbH4YwtPMG2+QdEy?=
 =?us-ascii?Q?oWw68GCiuhBI6YXbrSpBAx93FUDXY7r9Bh3gMcsugPIiu0G3thaQTvZqJvVj?=
 =?us-ascii?Q?+2S+oMSgEou7Z5Q5BmvKt5/KFqkybQAz1SRrObe35Ub3BF45hEXcCiBzOrij?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8D52FA260A96542A052BD2DB470A43C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yc44M89Nah9A7MlGMpdFu0adrPRiO+Lp7X6MMFbit3WOfIUBWm3dOYiTGro3szC80N76s1FH1fOpkIMyz6NHWyX1XQqLmBSTS6FblqamojyJWzPd8RV6zvYxCZJbamzCUiucfDHbZ/9f0ahGz6Dc+CxRnC980uNk2eeynIxspxdbsa73lWVA5g8XxQ1wx1rDf4He/XMszLQ+kMqkS2UEKkQFLLJC7IwjLtqIw10E5kNl7T6kz0BFL+oI52drFd7GWXnSeJSy11c4gmIshB3ErF03paNbcmLnUjX4oyvYkLh/LLTXTvHYvtbX3hWhQUdV//xIbGcbwUvZQEAJqnTCZ00Vb/6yn97A2XMaDcNPb9kFrnToeQQ4QKID9TEDaMcVkTRyB4LLg9ov1v4n1BtWEkSaJCL5ErWV6qRYFg5kCY/vQ5+wWqWUjO0JrunKovT62DtbBmQs8TSllQyblkpSfK7cg2GEHlJYZxLVy5PVSgeQCMRB1f7ywz4H3/j/rYQGV7Fj1GP+cLCLoVJf33C54jrhsFyz11HMc+4N81WTx26miz7eZC3AU+oa0dOOqx1OlLPp4A3hishz0/4iihd6OU22NVh9IbOFIv8R1UyHoEqusGsdKjr6wjeK0NiuHyfaHnJVws2djX7JfNwV5uVkcFibk3A1unWmSKB0LXWlXuefFM6Q9HgXqZO1G6XezNUGbfb1Aiqw+JVZbkN9nvWm7xxUSiMIzwozp6A3WddCnRSnv7hGvXE2hH05A3Ln0HZKlhaypZofhAzI+Y+kI/xnWu6u/oDcjgsIXcNj7bA2BCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12994bfe-49b5-41fb-cdf1-08db57a31f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 13:23:51.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7Vf+lcLPC31t1LJwKCnngLYwyX8br7Dx9SBSnc3W5ZJHo2GFb0Isi1r5fjesLGqzyn/TLoSI/u+5z9Rleb6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180106
X-Proofpoint-ORIG-GUID: eQ8YYIuzrS9Sm-0DE4nrp7V2O2Xfqb9Q
X-Proofpoint-GUID: eQ8YYIuzrS9Sm-0DE4nrp7V2O2Xfqb9Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 17, 2023, at 7:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
> if there is no conflict with other OPENs.
>=20
> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change,
> try_break_deleg.

Very clean. A couple of suggestions, one is down below, and here is
the other:

I was thinking we should add one or two counters in fs/nfsd/stats.c
to track how often read and write delegations are offered, and
perhaps one to count the number of DELEGRETURN operations. What do
you think makes sense?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
> 1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6e61fa3acaf1..09a9e16407f9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>=20
> static struct nfs4_delegation *
> alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> - struct nfs4_clnt_odstate *odstate)
> + struct nfs4_clnt_odstate *odstate, u32 dl_type)
> {
> struct nfs4_delegation *dp;
> long n;
> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nf=
s4_file *fp,
> INIT_LIST_HEAD(&dp->dl_recall_lru);
> dp->dl_clnt_odstate =3D odstate;
> get_clnt_odstate(odstate);
> - dp->dl_type =3D NFS4_OPEN_DELEGATE_READ;
> + dp->dl_type =3D dl_type;
> dp->dl_retries =3D 1;
> dp->dl_recalled =3D false;
> nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct=
 nfs4_ol_stateid *stp,
> struct nfs4_delegation *dp;
> struct nfsd_file *nf;
> struct file_lock *fl;
> + u32 deleg;
>=20
> /*
> * The fi_had_conflict and nfs_get_existing_delegation checks
> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> if (fp->fi_had_conflict)
> return ERR_PTR(-EAGAIN);
>=20
> - nf =3D find_readable_file(fp);
> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> + nf =3D find_writeable_file(fp);
> + deleg =3D NFS4_OPEN_DELEGATE_WRITE;
> + } else {
> + nf =3D find_readable_file(fp);
> + deleg =3D NFS4_OPEN_DELEGATE_READ;
> + }
> if (!nf) {
> /*
> * We probably could attempt another open and get a read
> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> return ERR_PTR(status);
>=20
> status =3D -ENOMEM;
> - dp =3D alloc_init_deleg(clp, fp, odstate);
> + dp =3D alloc_init_deleg(clp, fp, odstate, deleg);
> if (!dp)
> goto out_delegees;
>=20
> - fl =3D nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
> + fl =3D nfs4_alloc_init_lease(dp, deleg);
> if (!fl)
> goto out_clnt_odstate;
>=20
> @@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> struct svc_fh *parent =3D NULL;
> int cb_up;
> int status =3D 0;
> + u32 wdeleg =3D false;
>=20
> cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
> open->op_recall =3D 0;
> @@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> case NFS4_OPEN_CLAIM_PREVIOUS:
> if (!cb_up)
> open->op_recall =3D 1;
> - if (open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_READ)
> - goto out_no_deleg;
> break;
> case NFS4_OPEN_CLAIM_NULL:
> parent =3D currentfh;
> @@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl=
_stid.sc_stateid));
>=20
> trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);

I'd like you to add a trace_nfsd_deleg_write(), and invoke
it here instead of trace_nfsd_deleg_read when NFSD hands out
a write delegation.


> - open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> + wdeleg =3D open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
> + open->op_delegate_type =3D wdeleg ?
> + NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
> nfs4_put_stid(&dp->dl_stid);
> return;
> out_no_deleg:
> --=20
> 2.9.5
>=20

--
Chuck Lever


