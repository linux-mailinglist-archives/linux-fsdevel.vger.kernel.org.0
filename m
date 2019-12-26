Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51712AEE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 22:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZVXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 16:23:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfLZVXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:23:47 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBQLNeVm031789;
        Thu, 26 Dec 2019 13:23:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=glumFF58Od76IuO8o2RnluNtBpCDywJkVba96fPEHNI=;
 b=HcD5awETI975LMEzELPYMIFGjLTNy7kr/ND+e2j+gVe19xPvelo5D+ChCzHtNNX7qTiu
 nw19agDPifAymfdbYr94MfuQmsVxkBl9Cxa3R+O3SmoqN3bs3V3kNHam2PY4N/oL6oEC
 b3BHgCipNRYDahGdXwI9lfcDv+uFBRDVfwM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2x4wu7se9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 13:23:40 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 26 Dec 2019 13:23:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Dec 2019 13:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZwBlI7NSfYKKwlW6HQe6sKztKO9gqDDpz4NKEAYVyVw3T1GaQ8YRO+5QXMlSExafsRlGi3/ZCY3dBKt/RCWNNY3n9EwoiFWjvSc1n57BYBGJ+ME4Xh+XP+qsC+QBXrdsijgcWuf+AkBkW9MaqWgyRk/d+Bh/FcnLyqYJ1CxlK+z7yZ563B8+EXf+EuBF58/YECodzacyZbT4UbVF21RhHU/IXXsuVOMD5nj17ZoeE1rcyXTtuq33rV5gOY33I4exriDvhdmYGkG68Amt0QtP4gW7gHjtlSRxZ3dwI3c0T5jEYBH6bVkHv37urXQAnnBwoSuFClYHIeuJw3VPhxpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glumFF58Od76IuO8o2RnluNtBpCDywJkVba96fPEHNI=;
 b=GPQ0JYoM7STpAF90+IVVL/ayoQWm8gQosthaglN2J7LKn848CGUX22PuADLT8urfuOKFyc8h3SXjgdEYWGhe6sxKfL3F+zGs/P3uojE2Xn7DIpEgjLS5IhQA5Nu/Z/o+YqfEfpKV1/YOW18ioh2yI56hvoY31FtKO7/jMiBD5gTndpAetGTv+d3mwud2ENbr0s6l1F0AAYbibjBxsL031QPmOjRXluedbXkjhd8Le2mpmLr+HzZZRwMbAuOp8MCP3oM77sDr5v4pUL7WeMV/n1NjnQ9oXTv6gwOVSDSWicrjMbI5tW0cArJMeakAznUYbSEhJ/5kZOOd02dqcQAzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glumFF58Od76IuO8o2RnluNtBpCDywJkVba96fPEHNI=;
 b=DFYphu6EuxAPDKad72OCIpa3g/Qfi86+YvYCkoZkI2Y6jeAmLn7Cpix5Qi88M0Jp3e6efJBgVakKgx6UHhQrfC+Wstfgb7bUQsi/Ogb9Tu7CfuowSRPQq1V4J3GvZ/g+jAUtYZdyjViyb3sntjywscCLna5dgZco0K2gSTEVP5M=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3334.namprd15.prod.outlook.com (20.179.57.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 21:23:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 21:23:23 +0000
Received: from tower.dhcp.thefacebook.com (2620:10d:c090:200::d272) by CO1PR15CA0055.namprd15.prod.outlook.com (2603:10b6:101:1f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 21:23:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] mm, memcg: reduce size of struct mem_cgroup by
 using bit field
Thread-Topic: [PATCH v2 1/5] mm, memcg: reduce size of struct mem_cgroup by
 using bit field
Thread-Index: AQHVui9+mQ0CQvNSAEO1PbEVvQ6xvqfM8QUA
Date:   Thu, 26 Dec 2019 21:23:23 +0000
Message-ID: <20191226212320.GA22734@tower.dhcp.thefacebook.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1577174006-13025-2-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:101:1f::23) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::d272]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c034247-82dd-491f-a91d-08d78a49d678
x-ms-traffictypediagnostic: BYAPR15MB3334:
x-microsoft-antispam-prvs: <BYAPR15MB33347B97F502B160DE7FF299BE2B0@BYAPR15MB3334.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(52314003)(199004)(189003)(16526019)(66946007)(33656002)(2906002)(186003)(316002)(52116002)(86362001)(7696005)(66446008)(64756008)(66556008)(66476007)(5660300002)(6506007)(54906003)(71200400001)(478600001)(8936002)(55016002)(4326008)(1076003)(81156014)(81166006)(6916009)(8676002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3334;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 653g/94RSzXocMlEG/xx1B1fteILdSGdyClU/reVCT1FAyfZBR72ap90/CEJReQoG+dLNaOk9ssGUEo2J2Ix6bn6hQWvGry4iOOSigDpjqdNXqZq6fepeg3oxCZMZJiu3U1zwwHdFjimbf8/tXa3bA0TPZv4QQoHkOvFeRK4nbDqCb5K/5ttP0K3B52I7WNAElfoOqiFwJGXhTCxvO4HvlV8oZAuWWzlU9EQwAFm+kVq+TlI82K9D3dUX1J0UhMfpXx7HqS8dvRidVtinvU3Ix6Gg5tuGXCm1ajohjtd3eAEVqGmL7PuN/fluEkoAnDd+b8IYy0xaI5v82E1jwIIbqQ3RLkangzN7MJ3KltJmdqL9ScWBAV8iqXsn4p7wpEkR/mnjpMVrw6Fx/ftYn9dmtKmp0Wa/Dck0tj0L2yiQBBJUEUQGRrBhDbN0fCRVZSBXGMRv3o85H9cPvVHH8tlCm/b5Ul9jIjx0LXwESzmlqya3JubAcCD6TqJoL9S3dft
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43C071B2364C684A8F796FC8DE9F0D42@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c034247-82dd-491f-a91d-08d78a49d678
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 21:23:23.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kp2pwiSa4Q2uBq5poJlEA1roQ9523vgMGE1dMPYfulNspLzpGtRQqr7qdUCQXh1N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3334
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-26_05:2019-12-24,2019-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=867 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912260190
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 02:53:22AM -0500, Yafang Shao wrote:
> There are some members in struct mem_group can be either 0(false) or
> 1(true), so we can define them using bit field to reduce size. With this
> patch, the size of struct mem_cgroup can be reduced by 64 bytes in theory=
,
> but as there're some MEMCG_PADDING()s, the real number may be different,
> which is relate with the cacheline size. Anyway, this patch could reduce
> the size of struct mem_cgroup more or less.

It seems it's not really related to the rest of the patchset, isn't it?

Can you, please, post it separately?

Also, I'd move the tcp-related stuff up, so that all oom-related fields
would be together.

Otherwise lgtm.

Thanks!

>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/memcontrol.h | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a7a0a1a5..612a457 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -229,20 +229,26 @@ struct mem_cgroup {
>  	/*
>  	 * Should the accounting and control be hierarchical, per subtree?
>  	 */
> -	bool use_hierarchy;
> +	unsigned int use_hierarchy : 1;
> =20
>  	/*
>  	 * Should the OOM killer kill all belonging tasks, had it kill one?
>  	 */
> -	bool oom_group;
> +	unsigned int  oom_group : 1;
> =20
>  	/* protected by memcg_oom_lock */
> -	bool		oom_lock;
> -	int		under_oom;
> +	unsigned int oom_lock : 1;
> =20
> -	int	swappiness;
>  	/* OOM-Killer disable */
> -	int		oom_kill_disable;
> +	unsigned int oom_kill_disable : 1;
> +
> +	/* Legacy tcp memory accounting */
> +	unsigned int tcpmem_active : 1;
> +	unsigned int tcpmem_pressure : 1;
> +
> +	int under_oom;
> +
> +	int	swappiness;
> =20
>  	/* memory.events and memory.events.local */
>  	struct cgroup_file events_file;
> @@ -297,9 +303,6 @@ struct mem_cgroup {
> =20
>  	unsigned long		socket_pressure;
> =20
> -	/* Legacy tcp memory accounting */
> -	bool			tcpmem_active;
> -	int			tcpmem_pressure;
> =20
>  #ifdef CONFIG_MEMCG_KMEM
>          /* Index in the kmem_cache->memcg_params.memcg_caches array */
> --=20
> 1.8.3.1
>=20
>=20
