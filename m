Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47CF12AEFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 22:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLZVqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 16:46:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbfLZVqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:46:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBQLRVaE001848;
        Thu, 26 Dec 2019 13:45:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zS8a9nKL4i33iCJ63GUEBAywzbZYWl+7Q90BY8/CtPs=;
 b=amCGGn4h8l3/dnw8TGU4aZ7f+Ph6z1Rdi9aeHcrUGsr6sjF/jCmSIPP0bzcYH4qSIX6n
 V9h2zWs1PbEv5AfzePjL5Z04sGJOlPIbDdxwb1CuzCktDXaYKJmvSYiy0EEt0jdMasrR
 hF8qLKA03heGNQ02Qy1CBCe115bsa3B7kiM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2x3mexg0de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Dec 2019 13:45:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Dec 2019 13:45:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5apCpSc41bRf+exyV0/w2UA6vNSGs2e0wobyMvTblJfHKmKf/+SXjQ/fUbLZvwMPa6qo8id3/f2AeQZzbXxVwH2BhzgAjg5YoiIYbSuUtq/FoD73MbDdXdtjHKvq9XSGI1AIyKPdxoh5pO6NiKOo31www5AGdWBKflJnD2CuHXiILlQrMQBAoy9W13tgW3l+6c0xAB0pcgpMImX58jN052N8sdilp4vUsjiePQDo8IBLKoiFV1cRrU4yDtmSNXVBrgt1gybatP0EJigNFm93wsw947sdC+G7gcCEa5pHib0M0N3qNNS3SK75T4bDyiNFUMgnD9/RgWeMEc0qv+Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS8a9nKL4i33iCJ63GUEBAywzbZYWl+7Q90BY8/CtPs=;
 b=C+Uv62PHjkFJKs8JlBA9IuEz1dvgfBo6JQV1lB07JKoxwMQ2U3r4QfjF84hS9NsPXL5/RwvyW2ePQgLgogxuBD6FZORWVH6ZSNKDF7wliSX2hiAgp7p3oDYPSnLiOliJAWlr8RPvAiXC+jTENOfIGhKiOmUvHAIv3toElhgev7LiIJGGwgWeD8TGJxGSMM9riDbzuUTbe4SuW8gKLMSsfcE32nwp63VjTNNKvJN1TUSY8MDtiSwIQEN2aoWZzHkIbCvDuuyDh+5x813AP4VRVHZHHDyb8jFGiHxwKkXaHU+KS5f1e88znRvLjF1wqJ5Ic7OZBYqsgOXdc50OrVvKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS8a9nKL4i33iCJ63GUEBAywzbZYWl+7Q90BY8/CtPs=;
 b=G3h3fct9pQ/BXC/ACWKEX5ZbqZ32K6OKw/9wV2cH4PaJmCUp9/aREzk+vxtotbInkbLBsS9iU9p2wDqDwey9TjKsGdErRev5wUvI4KFFd/rDDSkU4DFvCngXz/flpS9TpUNw5u+DKIEIt93pvZnAPEByqFl6E1FmiFNeIxn7n6A=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2632.namprd15.prod.outlook.com (20.179.156.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 21:45:43 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 21:45:43 +0000
Received: from tower.dhcp.thefacebook.com (2620:10d:c090:200::d272) by MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Thu, 26 Dec 2019 21:45:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH v2 3/5] mm, memcg: reset memcg's memory.{min, low} for
 reclaiming itself
Thread-Topic: [PATCH v2 3/5] mm, memcg: reset memcg's memory.{min, low} for
 reclaiming itself
Thread-Index: AQHVui+JkxyXvqLwsUuIRVCDk0gPNKfM90GA
Date:   Thu, 26 Dec 2019 21:45:43 +0000
Message-ID: <20191226214539.GC22734@tower.dhcp.thefacebook.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-4-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1577174006-13025-4-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:300:ad::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::d272]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afadda9a-b56f-4733-9dad-08d78a4cf513
x-ms-traffictypediagnostic: BYAPR15MB2632:
x-microsoft-antispam-prvs: <BYAPR15MB263213CB28B1069CD97A8943BE2B0@BYAPR15MB2632.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(86362001)(8936002)(4326008)(7416002)(66946007)(66446008)(64756008)(54906003)(71200400001)(478600001)(316002)(81166006)(66556008)(66476007)(81156014)(8676002)(2906002)(186003)(55016002)(16526019)(9686003)(5660300002)(33656002)(1076003)(6506007)(7696005)(6916009)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2632;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ucbw57nVRRZ/3+nuNBqWTJIEa2iDS4oRcc4658LRrtOaZbt/vSbWfyfzSOXMWW1pLUGvLFxFa50P+N1OKvfr9e7WNI/phWmfsqhYSizhqCj6B+UtKD31BXbUrK3vZShAw2iZ7iQ03qg1kdTz4ZBkkxJZwPzY8a3Ipq3F0zW97QhAimBMY7kQ/kac0iVWwTz5AmXbZWmfguACvk8v/n0NMSmEOA/svsH+zaQ5nYWRiH0CizEGoWqM5JCgPJJKciP/+jIPHBPZALQnXgCtyzJvTEboxGdZoEXhjg1dsxpEtxhkSfWDz/1K/xMeoanT0bYdZNx6gXm54rjpNNIZ3jMLbxG0uFVPbhkb7xQWCgVaLIkIiIy3PzJLXqnoTnuHhW4x96Fu1yBbvwk9MThQIhhAAQouf5e8HjrsFr9JoF6TeZEmK64WwpmDGCOrfNa3WOh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FAD88BCB709D042800CDA71ADD12D2B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: afadda9a-b56f-4733-9dad-08d78a4cf513
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 21:45:43.2184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PM25cMbLKdCX/rGqpRyk09+KkIbHNyAlONxQTdqXU/MjWbyqGSrx/AY5Ymg1x51A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-26_05:2019-12-24,2019-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=816
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912260191
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 02:53:24AM -0500, Yafang Shao wrote:
> memory.{emin, elow} are set in mem_cgroup_protected(), and the values of
> them won't be changed until next recalculation in this function. After
> either or both of them are set, the next reclaimer to relcaim this memcg
> may be a different reclaimer, e.g. this memcg is also the root memcg of
> the new reclaimer, and then in mem_cgroup_protection() in get_scan_count(=
)
> the old values of them will be used to calculate scan count, that is not
> proper. We should reset them to zero in this case.
>=20
> Here's an example of this issue.
>=20
>     root_mem_cgroup
>          /
>         A   memory.max=3D1024M memory.min=3D512M memory.current=3D800M
>=20
> Once kswapd is waked up, it will try to scan all MEMCGs, including
> this A, and it will assign memory.emin of A with 512M.
> After that, A may reach its hard limit(memory.max), and then it will
> do memcg reclaim. Because A is the root of this reclaimer, so it will
> not calculate its memory.emin. So the memory.emin is the old value
> 512M, and then this old value will be used in
> mem_cgroup_protection() in get_scan_count() to get the scan count.
> That is not proper.

Good catch!

But it seems to be a bug introduced with the implementation of the proporti=
onal
reclaim. So I'd remove it from the patchset, add the "Fixes" tag and cc sta=
ble@.
Then it will have chances to be backported to stable trees.

Thank you!

>=20
> Cc: Chris Down <chris@chrisdown.name>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/memcontrol.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f35fcca..2e78931 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6287,8 +6287,17 @@ enum mem_cgroup_protection mem_cgroup_protected(st=
ruct mem_cgroup *root,
> =20
>  	if (!root)
>  		root =3D root_mem_cgroup;
> -	if (memcg =3D=3D root)
> +	if (memcg =3D=3D root) {
> +		/*
> +		 * Reset memory.(emin, elow) for reclaiming the memcg
> +		 * itself.
> +		 */
> +		if (memcg !=3D root_mem_cgroup) {
> +			memcg->memory.emin =3D 0;
> +			memcg->memory.elow =3D 0;
> +		}
>  		return MEMCG_PROT_NONE;
> +	}
> =20
>  	usage =3D page_counter_read(&memcg->memory);
>  	if (!usage)
> --=20
> 1.8.3.1
>=20
>=20
