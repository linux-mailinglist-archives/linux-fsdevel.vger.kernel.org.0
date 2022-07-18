Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2057846B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiGRNy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiGRNyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:54:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F61C8
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 06:54:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZXrw024663;
        Mon, 18 Jul 2022 13:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aBfy43fpRjkwN0d0gSiB1OEsQdtE3B0fXoch+orJr7s=;
 b=idUdLBYmARo3q8djyni4ndR8bEbIWgt+bzZX+F2xOCfozXu0IR0sojvJ4WqVdqY72zJM
 mWapfsa/1gXMSP12wvHvS4ZqxIUSzABlM97TH0exbRBtDxkk8T7JIEQxXqvZu/0gSrRu
 Yz30hunWgArB5wjjC2GCsXbnR4i9igJuzkkujD3QIaiuFfY3GWD+PdHv5RMfMmS4pUlX
 mjaXEYov3ucuhMLZgCsGuyUVeS0a6xDkGnbX2LFiKzJCXp5Z3k7IYfFakIi8F1942DoY
 cyEEmjTLDhGTjftiZIRVTnS8PYKg7AmX15fSptbmA4vkuGTB+jJZYRN25RRgAxshePzk rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc3bb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:54:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IC6W43004071;
        Mon, 18 Jul 2022 13:54:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3uh5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noPvPW0hvX1kjIsM0NhEvCQ3YLXDVoqT/tKXT/9xbb85bBIgFgapYD083ieZ2A6tuN4FXTP+pnkyEMEz6cVfKXaB515NBVZqtIlilwV0GW/IC9p/AflEgCfSNQUeTQDaHk+5YJhadWKM75IL7Fuf0Z5ZhhlSZ7vfhtBsgT9oSiLv35UxQC9mhjeFQG84QUdypby+NbRc1l6RVBVhvvf9OsDwcYbEMDOFVVYXUsIypNi0z4ehHSfGNApXlSnCoB2U/dNw8YKLGSgWFFJlB3T6luZLp1ucITHCLd6yUPUfJjpnWIVzFmnBBssMk6ykK94WzHKWkd5DqW7kuWYaoGfbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBfy43fpRjkwN0d0gSiB1OEsQdtE3B0fXoch+orJr7s=;
 b=A68uWl0qJORWSQoCBmfPwrTXJ2KdlGtEo+HYTZTZpWazuqKTr3OSV0vYALTRzV2axC6BcGYpedXXDYco7IBkijIgvsRU1nst7j3Xbx4sh3TWiX9bS/QYG7MMPmrjt04JIEBvLz6Z+0JSWxOmKz4sXXj+X42x71H213rGCmSsZNMRvDeJYj+ynt/tgu02D6kpV0J3Z67vutBf+aoi+Zie8Pt+Noi1oLDAjhdmN8QPQXLQ6quaF2YGz3xj9XxoSLxj7tz4bxo6jpfNLb1flbsWpCfjE12C/7HDKi3IMJmQSVHuwzEdmuHZnjGz4Dv3gFGpQ31dx6ootQpefjgMbpMBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBfy43fpRjkwN0d0gSiB1OEsQdtE3B0fXoch+orJr7s=;
 b=EwCIWawUReY6nPRDoFH6imFs+YillttmVQFqxVcCCZlK39wJ0O6BHrEMMfM8B4H2djKgB7Y/XG5t5cZ370F4ZhfVBbdeFxCY8nkdS2bi8ceAgfU2LIDA2eUHtwNM6NrVDWri5NIJc7QOCKjDqm1bT1hl9mKCaDQ0L9k0sglx0k4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2804.namprd10.prod.outlook.com (2603:10b6:208:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 13:54:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:54:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] fs/lock: Don't allocate file_lock in
 flock_make_lock().
Thread-Topic: [PATCH v3 1/2] fs/lock: Don't allocate file_lock in
 flock_make_lock().
Thread-Index: AQHYmZbD9ogyGVPr7k6GMSUhnrrjH62EKIgA
Date:   Mon, 18 Jul 2022 13:54:12 +0000
Message-ID: <BCD9E867-1C1C-4B65-B2F1-7E58C373FB21@oracle.com>
References: <20220717043532.35821-1-kuniyu@amazon.com>
 <20220717043532.35821-2-kuniyu@amazon.com>
In-Reply-To: <20220717043532.35821-2-kuniyu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36fd3695-2d62-4fb2-02f9-08da68c4feac
x-ms-traffictypediagnostic: BL0PR10MB2804:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tqr5TjS6VSv1s/bcKLlDESIxnrXnqJgkogEeqoEVVahnqd/+XNLWsuyChZ4zMcbFEln2aoiUcrgOVi7IuD8ZxnmABRRGwjAluvmneTcmSimGKXuAZAzA7371JiFqwGMAgnxAEpoWYLAVeMYVFvTiysvQcDNnAjzMzvdV/7Q0H1vb7VtM9D5vBkX6AUs/2/ydCcawCgbZJaBLbhHXw4VUhOUs/JHKtIweDoYD22T8ECnr67FPEFTeceMXnJvkn6fUIJ/8H9iVlyMr2vC4irIkPGNb9dg84zDQSEvqNxL4aKJp86q8y9sOKizK6Gcub/+cYvHs4XPBR/rKBfxRu52FNLB6WTALm4QepBEtufTfqnDfe+7Fc/ZjBIwMAl+Beu4N/PZhTk8ED6uF4S075j1F4zftmzneiJyvpuHTB54Rm2Nh20UfOPraFdnFe1LHzbTMlyBIxtQGkpmLFNuk7inGOi5v7dPSsXc4jaBHy0L8kmgBRpxcAhHFFBvaqYMmUNdKO+9ED1bjX3qVC1kzJsMcQgfU215IftjmOfx/CMNSZuiXqNgusxi5amqJtIuVPKJvaJ8muYr1Hn/GhvUYaMKxIjw98cpUFZXjkiE4+cDpBTo8HDYZos6g+3WBioAjCup6DzoNic8JzeWQ3dtumxTwIr3iGmJ1sfv1GSS8+k5mvmJAjdukRhZ3AqdG4v53uEy5hT47AsVqu2kWHzMI3yNxSUjwVaJqQ1IK1Y6znUkSdOKYfNxF9QAStoFq2eNORCDU1pBNVYT3LoOiqs8kXtPloQy4XFBD3LHfkUWR4kfmmyLmLkSPfAFTdKvZT41tkkuxDZFv97Dq7CfCrzNx8NqQsNWGckQsXPG0dbsMXMXVSSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(39860400002)(396003)(346002)(54906003)(6916009)(53546011)(478600001)(6506007)(6512007)(41300700001)(26005)(6486002)(71200400001)(66946007)(66556008)(66476007)(2906002)(91956017)(64756008)(66446008)(8936002)(5660300002)(4326008)(8676002)(316002)(38100700002)(36756003)(122000001)(83380400001)(33656002)(38070700005)(86362001)(2616005)(186003)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6RjiQow92D1QnmgSSa6Z4VKPMhFAWg/9b1N53TNs+mOreJBIQPy8W+1AjM4w?=
 =?us-ascii?Q?tTndAHlhKr+ivp4nCBroBukGaLK8d+j27RF/TGfZBrbkegEg732q9QQtue8S?=
 =?us-ascii?Q?Lw21BvG8ArCHabNlSz0aO9F1QDFiRc+Z2udLcapK92l3vluJV0EoP1oS+C4Z?=
 =?us-ascii?Q?dh7VnGxv7KC0uj3I4K90+y+wvDfIh5mAeui1ObWFmatEt1a4sLgHrz+9nVV8?=
 =?us-ascii?Q?MWOVoRBtsGKgeL1ixDmrtAuSpuoQZQsN6Sl/hBG/1L6Vr5nXquunXfHNsy5I?=
 =?us-ascii?Q?6fNyP4XG4NhXnf/SGbX+KLK8Unnz5ifaGzVZuOUJYMVee6tUcC3yPTw+Fd0e?=
 =?us-ascii?Q?Q9ri7amcF1YIxTLGCC16myn5d3ifNblaIT0eizxNSDjSHELlhZZBjCM2FBxq?=
 =?us-ascii?Q?U2CYmD6l+belNNJT2Vmm7U8DaIR9e4oS85DcEOzFs0rxbAeD/XRxtJ1j1f3g?=
 =?us-ascii?Q?sv2nwvEfAwK6VRyU92+/zONYUOpcJSBwUNnLQVOgDTmxgq7PlnN8VU5GCO3g?=
 =?us-ascii?Q?LxCV05Bs3YuGaqonCUyAzn4DMuaHrGW6yP0jth3rilWBXSyA7G5fFsQClo0t?=
 =?us-ascii?Q?htI1cA9fB+STqSDcQDrSZ+sHDevGRkSnXsqDbSYnFSGm/5UHheJj0ybJyJAS?=
 =?us-ascii?Q?+DFuTth3wvrkd41P72vdpK5Xva5CLVapeZU2lxh8F+HyLL72ZMQPLIWNNi5f?=
 =?us-ascii?Q?h7qJ2frlKp75rHpgvE9CO9UzWrohtF6fyfRimGQVTVrRsbpCWJ+4pdSardFk?=
 =?us-ascii?Q?UadKVaK1hqh1eoGnacvBtJxjsk8QfmSPW0T3LEdbuyuC/8lH1zngYLSuizoV?=
 =?us-ascii?Q?ueHTdVxscjGooGAH0G3FClLXWhVpSlze7i3libjJ2+BW6Ih5vEVZX9nbuacL?=
 =?us-ascii?Q?Xqwn5B3FJiobCGCo+bxRxATUS2pwjxNaJDbAdjUIZdFDb+qvMz+g+d1hXlQR?=
 =?us-ascii?Q?RBVQFmDS22ab9VYBiVVMWMMNC8iwdZAndv3B1P0yQaRra4XhP1/8/pUFhadE?=
 =?us-ascii?Q?YzbF5zocelmpI3R/zo4MaQD9pI4WdeFP1LKMGo2ttgxMKLLV/7uH51P9PD8C?=
 =?us-ascii?Q?hOdJADmZrRTaqjKcm3Lwcz0IOOu/swUQcPqnCwoHgW9/SfvJAi3yq7It5EDE?=
 =?us-ascii?Q?/YhnbrSKzfJNjJvCY3HRxZQp54v5r2YBMh77yV9Olp1F50kpFjbFfT/1P+KI?=
 =?us-ascii?Q?bXPiAKNGHb0rm8T7tXpvMsdB4Mn1jZ3JVGaeshriltH9tXv6BuW3kVxqnu3H?=
 =?us-ascii?Q?F8kiN+6dT1bvvMVertHAOZcsWhTx9qdrD+QVu0TMwNuf0JFNpgkXyUpOny69?=
 =?us-ascii?Q?yRZFlOhA7FpCJGLzlY3BPqRIEd6LZwqgoP4rgbQ57lvFV2aYL0+3XAsWeoB1?=
 =?us-ascii?Q?dkIoAXFMEYoBJm36bWWZ/z/4TwM6WY5p76MG48yJWXO3BkpOsnSBlBb73dhU?=
 =?us-ascii?Q?/LsMfibcYM0EL6EmyaErGyb9QBnbn0+nTB5Eq4fZkPlMaV8is5o7SJo1K7Et?=
 =?us-ascii?Q?mlnL0kHPJ3N6ZhW6wMlzIdn1NnloO4qbksYQoH7/D4HwPvz+bcDO6EczvDm5?=
 =?us-ascii?Q?W/C8kKRDWj0KAE1H5KerRoZrq1zZEQ+xDfk3PWZS1OFRSv1an7Nu4ff4CLtF?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2D4474265871740A41452B80135D6B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fd3695-2d62-4fb2-02f9-08da68c4feac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 13:54:12.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KA0AknN96L+IFHDzvigum10EKMt5eBAra83OZ4B8Ox08lBw1R/OMuEaRXmZENO1ycU/RV5VwFBZ8gVNNMNSC3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_13,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180060
X-Proofpoint-GUID: zbfbWoYJzVMR4yxltErJUFKA8c_cITZ7
X-Proofpoint-ORIG-GUID: zbfbWoYJzVMR4yxltErJUFKA8c_cITZ7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 17, 2022, at 12:35 AM, Kuniyuki Iwashima <kuniyu@amazon.com> wrote=
:
>=20
> Two functions, flock syscall and locks_remove_flock(), call
> flock_make_lock().  It allocates struct file_lock from slab
> cache if its argument fl is NULL.
>=20
> When we call flock syscall, we pass NULL to allocate memory
> for struct file_lock.  However, we always free it at the end
> by locks_free_lock().  We need not allocate it and instead
> should use a local variable as locks_remove_flock() does.
>=20
> Also, the validation for flock_translate_cmd() is not necessary
> for locks_remove_flock().  So we move the part to flock syscall
> and make flock_make_lock() return nothing.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

v3 Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/locks.c | 46 +++++++++++++++-------------------------------
> 1 file changed, 15 insertions(+), 31 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index ca28e0e50e56..b134eaefd7d6 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -425,21 +425,9 @@ static inline int flock_translate_cmd(int cmd) {
> }
>=20
> /* Fill in a file_lock structure with an appropriate FLOCK lock. */
> -static struct file_lock *
> -flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *f=
l)
> +static void flock_make_lock(struct file *filp, struct file_lock *fl, int=
 type)
> {
> -	int type =3D flock_translate_cmd(cmd);
> -
> -	if (type < 0)
> -		return ERR_PTR(type);
> -
> -	if (fl =3D=3D NULL) {
> -		fl =3D locks_alloc_lock();
> -		if (fl =3D=3D NULL)
> -			return ERR_PTR(-ENOMEM);
> -	} else {
> -		locks_init_lock(fl);
> -	}
> +	locks_init_lock(fl);
>=20
> 	fl->fl_file =3D filp;
> 	fl->fl_owner =3D filp;
> @@ -447,8 +435,6 @@ flock_make_lock(struct file *filp, unsigned int cmd, =
struct file_lock *fl)
> 	fl->fl_flags =3D FL_FLOCK;
> 	fl->fl_type =3D type;
> 	fl->fl_end =3D OFFSET_MAX;
> -
> -	return fl;
> }
>=20
> static int assign_type(struct file_lock *fl, long type)
> @@ -2097,10 +2083,9 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
>  */
> SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
> {
> +	int can_sleep, error, unlock, type;
> 	struct fd f =3D fdget(fd);
> -	struct file_lock *lock;
> -	int can_sleep, unlock;
> -	int error;
> +	struct file_lock fl;
>=20
> 	error =3D -EBADF;
> 	if (!f.file)
> @@ -2127,28 +2112,27 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned=
 int, cmd)
> 		goto out_putf;
> 	}
>=20
> -	lock =3D flock_make_lock(f.file, cmd, NULL);
> -	if (IS_ERR(lock)) {
> -		error =3D PTR_ERR(lock);
> +	type =3D flock_translate_cmd(cmd);
> +	if (type < 0) {
> +		error =3D type;
> 		goto out_putf;
> 	}
>=20
> +	flock_make_lock(f.file, &fl, type);
> +
> 	if (can_sleep)
> -		lock->fl_flags |=3D FL_SLEEP;
> +		fl.fl_flags |=3D FL_SLEEP;
>=20
> -	error =3D security_file_lock(f.file, lock->fl_type);
> +	error =3D security_file_lock(f.file, fl.fl_type);
> 	if (error)
> -		goto out_free;
> +		goto out_putf;
>=20
> 	if (f.file->f_op->flock)
> 		error =3D f.file->f_op->flock(f.file,
> 					  (can_sleep) ? F_SETLKW : F_SETLK,
> -					  lock);
> +					    &fl);
> 	else
> -		error =3D locks_lock_file_wait(f.file, lock);
> -
> - out_free:
> -	locks_free_lock(lock);
> +		error =3D locks_lock_file_wait(f.file, &fl);
>=20
>  out_putf:
> 	fdput(f);
> @@ -2614,7 +2598,7 @@ locks_remove_flock(struct file *filp, struct file_l=
ock_context *flctx)
> 	if (list_empty(&flctx->flc_flock))
> 		return;
>=20
> -	flock_make_lock(filp, LOCK_UN, &fl);
> +	flock_make_lock(filp, &fl, F_UNLCK);
> 	fl.fl_flags |=3D FL_CLOSE;
>=20
> 	if (filp->f_op->flock)
> --=20
> 2.30.2
>=20

--
Chuck Lever



