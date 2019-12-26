Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBC12AEF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 22:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLZVgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 16:36:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfLZVgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:36:31 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBQLTN09028500;
        Thu, 26 Dec 2019 13:36:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9yl0vZB6zXYsdXshurlVu4KnvgnCsluDrbU15igoniQ=;
 b=ViGwB6LeT6yu8iDefABALIz1h/iRowjz8+9tyHJjoIjiTCayjy5h4xD0JGwcGphvC8ca
 6jxgxMrsHr3jeb3MxB/Om1dF9iy5wPeY888QwhZ1wPq7UH4kgDZWJB0vPwXc5wgRQjMn
 CcOueIaHPpFY4Dr/DoD1cKBqb9bC6DYY5Jc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2x4puyjmrd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Dec 2019 13:36:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Dec 2019 13:36:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfUZIJVB9yLn47MTTlsGClo4qPJZi2nkie1oqhYq0wA1GfvTEAsolGTr+r694IqM2phEuKTZZTttZuQluhfAlLL+19MZRpU6keKHPMYAttXSBYzI/PR3IGNkeUHihRGURijMw2xYmN0WbzSs65rfEGnkq2R1/grqFxIWQC6fPH10nswDJN6rcrmWC1FwM/8glLzY0rPzK9lzWC3WTpBC9V04TMvHasYudg5kMUi6Mf5mTX40POS0sd9JWE2Wh/g1kaZYa+dEOcvlgxRSLKiXx1Bmt/XtcnvzWGLnI2tMTl3oM8nH8590Qitj/T993+2w3rzS4HZpYZ+uu/Iy69UTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yl0vZB6zXYsdXshurlVu4KnvgnCsluDrbU15igoniQ=;
 b=Nq5/Y/iDLlB12kGvABqgYjQmqK4r3y7FBJeLCCCuw/MqMnoUniBG1RU/3lulkRZns7wED8pJqymFx2DYFCAXzCaAUM+ja9mLUbA/v6UuEumv9YtFDUtp2J2BLMo3uivuvPvNg14sIJUDHYljb6IsEZqtpXaR5s9W2MEPdEMXZJC4Os9GwsNIFQKeSlL5TkSL1aXpfsDpaxJeaB1Gy0Qmh76ku0sDIIUYWfD2862R0hT3eDxHeZk83fRdPiJUXbUHj6ZkruDSAMH/QOgJ1hKAUNDL86Zyq7KWCGtPEIF2CbjS0SZvTcGO3rzk41cCFUOsjQXrMbKYBGEOxlML0WhBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yl0vZB6zXYsdXshurlVu4KnvgnCsluDrbU15igoniQ=;
 b=MYhfyWbo7ZNEaX1YgJ8Z2TLZhn49IhI8AjTgV9GQkEymfujCfYQLc7IiYp8O/+wkI+iV/QMOpRnfKLp5UHWb+VhfRgcdjuik3Zi1r7z70MOTMjI0/MBV0haXwIW3BS8Ah/ppfdt1S3MwRydTkiHXDQV24a/9xdcsUCqbBnG+hok=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2950.namprd15.prod.outlook.com (20.178.237.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Thu, 26 Dec 2019 21:36:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 21:36:23 +0000
Received: from tower.dhcp.thefacebook.com (2620:10d:c090:200::d272) by MWHPR11CA0018.namprd11.prod.outlook.com (2603:10b6:301:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 21:36:22 +0000
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
Subject: Re: [PATCH v2 2/5] mm, memcg: introduce MEMCG_PROT_SKIP for memcg
 zero usage case
Thread-Topic: [PATCH v2 2/5] mm, memcg: introduce MEMCG_PROT_SKIP for memcg
 zero usage case
Thread-Index: AQHVui+ASibtRWJQmkOInCTxhAakFKfM9KWA
Date:   Thu, 26 Dec 2019 21:36:23 +0000
Message-ID: <20191226213619.GB22734@tower.dhcp.thefacebook.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-3-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1577174006-13025-3-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:301:1::28) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::d272]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9aa50378-7ebe-4d0f-8909-08d78a4ba72c
x-ms-traffictypediagnostic: BYAPR15MB2950:
x-microsoft-antispam-prvs: <BYAPR15MB295024CEEE025E8FE8B10AD9BE2B0@BYAPR15MB2950.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(16526019)(71200400001)(186003)(478600001)(55016002)(9686003)(86362001)(6916009)(7696005)(52116002)(33656002)(4326008)(6506007)(2906002)(316002)(5660300002)(66476007)(66556008)(64756008)(66446008)(54906003)(66946007)(1076003)(8676002)(81166006)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2950;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WohfVM1NpD2E/Zap1fW68kb4xHT6bJ88KAbKowlzd9Hfo9k0SRmaZBBn0KVpAZjDZBtSEhJbE6YSqAPpONCEzMttXA+5EOdovIREvbJghpNw4pg62abmxiDvDDVo+wTift/1b+OkpFHfdq2AnsTuSc4UYAbzHeUPmu+LgqljQbiFmEQUqPf0zjiNUECNxg4Du/ASY7VwERrQUKTcn0vgK0U+3qkujps2hOW4Kxasg/udK33aTftBHAm00brfpSgOzUhmlaJM71tHSEJZZuNrpzBDlmv97zooW3cckjZA3EVq2vSxO9TKNcItSY2M+t+mfMTUPN1vBa2xIdw8Mexk8GJ6z4rNbIQyvBIOPM7utbfmYKVxFLjlpjYgFDbHScU+SkOJOiDXBFZQ7MXWPUgtnDMSMl4d4m2bPUX5W7Ts7U6PeHZVXBqDpVY/9Pxrf493
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9AD53F2A1917148AD84E6F5657AC7ED@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa50378-7ebe-4d0f-8909-08d78a4ba72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 21:36:23.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQ3C2PR1hB4SuVneypIYDQMxwbzSJ6YY1YMBqgdM68EOvTM2vsoPoB2PBs+JWcrg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-26_05:2019-12-24,2019-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912260191
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 02:53:23AM -0500, Yafang Shao wrote:
> If the usage of a memcg is zero, we don't need to do useless work to scan
> it. That is a minor optimization.

The optimization isn't really related to the main idea of the patchset,
so I'd prefer to treat it separately.

>=20
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/memcontrol.h | 1 +
>  mm/memcontrol.c            | 2 +-
>  mm/vmscan.c                | 6 ++++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 612a457..1a315c7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -54,6 +54,7 @@ enum mem_cgroup_protection {
>  	MEMCG_PROT_NONE,
>  	MEMCG_PROT_LOW,
>  	MEMCG_PROT_MIN,
> +	MEMCG_PROT_SKIP,	/* For zero usage case */
>  };
> =20
>  struct mem_cgroup_reclaim_cookie {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c5b5f74..f35fcca 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6292,7 +6292,7 @@ enum mem_cgroup_protection mem_cgroup_protected(str=
uct mem_cgroup *root,
> =20
>  	usage =3D page_counter_read(&memcg->memory);
>  	if (!usage)
> -		return MEMCG_PROT_NONE;
> +		return MEMCG_PROT_SKIP;

I'm concerned that it might lead to a regression with the scraping of
last pages from a memcg. Charge is batched using percpu stocks, so the
value of the page counter is approximate. Skipping the cgroup entirely
we're losing all chances to reclaim these few pages.

Idk how serious the problem could be in the real life, and maybe it's OK
to skip if the cgroup is online, but I'd triple check here.

Also, because this optimization isn't really related to protection,
why not check the page counter first, e.g.:

	memcg =3D mem_cgroup_iter(root, NULL, NULL);
 	do {
		unsigned long reclaimed;
		unsigned long scanned;

		if (!page_counter_read(&memcg->memory))
			continue;

		switch (mem_cgroup_protected(root, memcg)) {
		case MEMCG_PROT_MIN:
			/*
			 * Hard protection.
			 * If there is no reclaimable memory, OOM.
			 */
			continue;
		case MEMCG_PROT_LOW:

--

Thank you!
