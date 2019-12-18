Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F43124FBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLRRx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 12:53:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbfLRRx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:53:27 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIHpiTu007659;
        Wed, 18 Dec 2019 09:53:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XKlfvqq3AOtoDzitHR1LjkaKJ6pcdYzDHBbKk1Vmxho=;
 b=ZlWLRjOJxcQVhDK0iXtVU/zX0/JDadeOopx7IqZ0U+q9JjIOIFEsv828q9iM9qxDq/H6
 bI8Y9NuqSEGlKML2BIic6gOiv8bdRjzJfsInY1vb9xYrZ/k8BVtevwrSgFSSLSOMNUcv
 WCs3sPsAZSDSsLaBYnHAaiHjMkcxpx/wdlc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wy61t4vu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 09:53:16 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 18 Dec 2019 09:53:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 09:53:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKiELPGjFtHyIEdnM/VEpyDkNdZ+Jkm+i+j3aimeCN+wZUlblrYx2dax80aj65ybSlwZ93uJ4Px3Tzozhv1af2ydSqjUuf2eKt1a33doyr5+YYDsTiJZ3+J0rG20tj1IFTAMST8Lmj77vwWcVPQCJG7HEgfcl9EuKpvphEx4pqGZ4ezhXJqJZB+ki0s+yQk3a9jNSps4CBSyYq6xDRpINFUhUfIKC7Qbr6IPtTlHX467QQv760VfQoT5kv6Aiomk4sBahwIOtuLVGdjXPzb4TXaWo1tda6klT41NxapQSUgEbd+HuoD4lW9KQSBjn5RJJ9vekvqCYB632vEudkgBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKlfvqq3AOtoDzitHR1LjkaKJ6pcdYzDHBbKk1Vmxho=;
 b=I2+Vvvq/Bddim++m4IR9Nn470pyLX93PgbqTFWYN2Q9ZZ5v2BD2+NpqfYbf/1/9ODp6DnvDsm81gTUJW6QYcMpKEX1vxq+HEQVgKXCdx6WRU911wDPBJiDi/wFn1EGFvhKeFl+8704dIU5ZkfH57Y6nGHtQlXG9sExpEnZK5IA7TTV4KKIzqqIJ+lKknluDDQxqpILvLXXITV+uUWeYMpz2ReemK32x4Djf85OjkEa+lTh9rpGk6V0RqTc5n+GOIsFA4oiZyM21PBa+nL4idQxblxca5p6vBAkMtb0k6IZiiG6bv1lVZoztUivbVFCm3k7ShtPshZReHcI/X03an9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKlfvqq3AOtoDzitHR1LjkaKJ6pcdYzDHBbKk1Vmxho=;
 b=IYRJeSIE5sPLFW0IpjW+ZP+cTPxeyxvisEzvE2sXCifNYQ1WqDHSptbF9yA+JEdfdSlOZvkWKhAA0TdurWgI7nSzF2O7/Qrt3wJ7iuRw2BlD706XfQNktB8FLoEQ6ilSPXL+s3/MQn+XAHvjwmOhzGr00W40tZ2EPkz1Mhtrz1E=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2504.namprd15.prod.outlook.com (52.135.199.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 17:53:14 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 17:53:14 +0000
Received: from localhost.localdomain (2620:10d:c090:180::361) by CO1PR15CA0079.namprd15.prod.outlook.com (2603:10b6:101:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Wed, 18 Dec 2019 17:53:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>,
        "Dave Chinner" <dchinner@redhat.com>
Subject: Re: [PATCH 4/4] memcg, inode: protect page cache from freeing inode
Thread-Topic: [PATCH 4/4] memcg, inode: protect page cache from freeing inode
Thread-Index: AQHVtM2JVT6++D5cRUGfCE/h2PHZoqfALmoA
Date:   Wed, 18 Dec 2019 17:53:14 +0000
Message-ID: <20191218175310.GA4730@localhost.localdomain>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <1576582159-5198-5-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1576582159-5198-5-git-send-email-laoar.shao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0079.namprd15.prod.outlook.com
 (2603:10b6:101:20::23) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::361]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fb59031-7fc6-40e0-eb7a-08d783e327bb
x-ms-traffictypediagnostic: BYAPR15MB2504:
x-microsoft-antispam-prvs: <BYAPR15MB25044715ED753935AB20A83EBE530@BYAPR15MB2504.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(478600001)(5660300002)(1076003)(6916009)(7696005)(54906003)(52116002)(81156014)(66946007)(81166006)(186003)(55016002)(4326008)(86362001)(7416002)(9686003)(8676002)(16526019)(71200400001)(66476007)(8936002)(316002)(66556008)(33656002)(2906002)(66446008)(64756008)(69590400006)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2504;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etD9N3tzlJyp2kc9YAI6mn5Kx0kzqAILKwyWfFS23Cst8rjpS4bE1FohE0ptXfrHOtRjUjK3MUbbpIRjuPy6t2BklqoUtwSDYpPPR4nIDZJi5vrM93zgkfogPQVMuCXD2ErGaNkFhsbx3JSfQ+kpEy2S+l79/FHd2EuLhqhuKNJ2QL6ue25OGhRtDK6RyRExLPPGD7J9kOG+yRQYxdJqx9neLCuCPEWvvZ3ImjbAA+LseOHYGULnEfXi4X0wtf3TbPBjGLGhBAMkMMVNQ48+9ZYNuxTpmbgYf0/hyFHjWWbNiDJCXD+K6JOYNKjsXWmDMNZCyE8zs3ksCRZgUED9onP5ygKDrWM9BzA2BTEWk4s7C/OFKc2zjHI81sZH+CFcEuxNkUzuAzyIK0PQLp7l5IWI2uMeebuhb6OzXZow72dKx6OrYI9avpVGHtChfJQiSSttqNYrAFW5Rq//p5262LG8KNmdAePpS5JllVC+orG02qBbLT+x8sHfZKV8ahQ2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFE5B2B37013C44FB3FF3D4B3F38849B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb59031-7fc6-40e0-eb7a-08d783e327bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 17:53:14.5155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jSD09lnez0N9/2xbKFwlMEEBK+qKRcvxq5cfKGOmlvElecG//l5oRhiR7MgZ9Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_05:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180143
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:29:19AM -0500, Yafang Shao wrote:
> On my server there're some running MEMCGs protected by memory.{min, low},
> but I found the usage of these MEMCGs abruptly became very small, which
> were far less than the protect limit. It confused me and finally I
> found that was because of inode stealing.
> Once an inode is freed, all its belonging page caches will be dropped as
> well, no matter how may page caches it has. So if we intend to protect th=
e
> page caches in a memcg, we must protect their host (the inode) first.
> Otherwise the memcg protection can be easily bypassed with freeing inode,
> especially if there're big files in this memcg.
> The inherent mismatch between memcg and inode is a trouble. One inode can
> be shared by different MEMCGs, but it is a very rare case. If an inode is
> shared, its belonging page caches may be charged to different MEMCGs.
> Currently there's no perfect solution to fix this kind of issue, but the
> inode majority-writer ownership switching can help it more or less.
>=20
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/inode.c                 |  9 +++++++++
>  include/linux/memcontrol.h | 15 +++++++++++++++
>  mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  mm/vmscan.c                |  4 ++++
>  4 files changed, 74 insertions(+)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a..b022447 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -734,6 +734,15 @@ static enum lru_status inode_lru_isolate(struct list=
_head *item,
>  	if (!spin_trylock(&inode->i_lock))
>  		return LRU_SKIP;
> =20
> +
> +	/* Page protection only works in reclaimer */
> +	if (inode->i_data.nrpages && current->reclaim_state) {
> +		if (mem_cgroup_inode_protected(inode)) {
> +			spin_unlock(&inode->i_lock);
> +			return LRU_ROTATE;
> +		}
> +	}

Not directly related to this approach, but I wonder, if we should scale dow=
n
the size of shrinker lists depending on the memory protection (like we do w=
ith
LRU lists)? It won't fix the problem with huge inodes being reclaimed at on=
ce
without a need, but will help scale the memory pressure for protected cgrou=
ps.

Thanks!


> +
>  	/*
>  	 * Referenced or dirty inodes are still in use. Give them another pass
>  	 * through the LRU as we canot reclaim them now.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1a315c7..21338f0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -247,6 +247,9 @@ struct mem_cgroup {
>  	unsigned int tcpmem_active : 1;
>  	unsigned int tcpmem_pressure : 1;
> =20
> +	/* Soft protection will be ignored if it's true */
> +	unsigned int in_low_reclaim : 1;
> +
>  	int under_oom;
> =20
>  	int	swappiness;
> @@ -363,6 +366,7 @@ static inline unsigned long mem_cgroup_protection(str=
uct mem_cgroup *memcg,
> =20
>  enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  						struct mem_cgroup *memcg);
> +unsigned long mem_cgroup_inode_protected(struct inode *inode);
> =20
>  int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
>  			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
> @@ -850,6 +854,11 @@ static inline enum mem_cgroup_protection mem_cgroup_=
protected(
>  	return MEMCG_PROT_NONE;
>  }
> =20
> +static inline unsigned long mem_cgroup_inode_protected(struct inode *ino=
de)
> +{
> +	return 0;
> +}
> +
>  static inline int mem_cgroup_try_charge(struct page *page, struct mm_str=
uct *mm,
>  					gfp_t gfp_mask,
>  					struct mem_cgroup **memcgp,
> @@ -926,6 +935,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from=
_page(struct page *page)
>  	return NULL;
>  }
> =20
> +static inline struct mem_cgroup *
> +mem_cgroup_from_css(struct cgroup_subsys_state *css)
> +{
> +	return NULL;
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 234370c..efb53f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6355,6 +6355,52 @@ enum mem_cgroup_protection mem_cgroup_protected(st=
ruct mem_cgroup *root,
>  }
> =20
>  /**
> + * Once an inode is freed, all its belonging page caches will be dropped=
 as
> + * well, even if there're lots of page caches. So if we intend to protec=
t
> + * page caches in a memcg, we must protect their host first. Otherwise t=
he
> + * memory usage can be dropped abruptly if there're big files in this
> + * memcg. IOW the memcy protection can be easily bypassed with freeing
> + * inode. We should prevent it.
> + * The inherent mismatch between memcg and inode is a trouble. One inode
> + * can be shared by different MEMCGs, but it is a very rare case. If
> + * an inode is shared, its belonging page caches may be charged to
> + * different MEMCGs. Currently there's no perfect solution to fix this
> + * kind of issue, but the inode majority-writer ownership switching can
> + * help it more or less.
> + */
> +unsigned long mem_cgroup_inode_protected(struct inode *inode)
> +{
> +	unsigned long cgroup_size;
> +	unsigned long protect =3D 0;
> +	struct bdi_writeback *wb;
> +	struct mem_cgroup *memcg;
> +
> +	wb =3D inode_to_wb(inode);
> +	if (!wb)
> +		goto out;
> +
> +	memcg =3D mem_cgroup_from_css(wb->memcg_css);
> +	if (!memcg || memcg =3D=3D root_mem_cgroup)
> +		goto out;
> +
> +	protect =3D mem_cgroup_protection(memcg, memcg->in_low_reclaim);
> +	if (!protect)
> +		goto out;
> +
> +	cgroup_size =3D mem_cgroup_size(memcg);
> +	/*
> +	 * Don't need to protect this inode, if the usage is still above
> +	 * the limit after reclaiming this inode and its belonging page
> +	 * caches.
> +	 */
> +	if (inode->i_data.nrpages + protect < cgroup_size)
> +		protect =3D 0;
> +
> +out:
> +	return protect;
> +}
> +
> +/**
>   * mem_cgroup_try_charge - try charging a page
>   * @page: page to charge
>   * @mm: mm context of the victim
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3c4c2da..1cc7fc2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2666,6 +2666,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, st=
ruct scan_control *sc)
>  				sc->memcg_low_skipped =3D 1;
>  				continue;
>  			}
> +			memcg->in_low_reclaim =3D 1;
>  			memcg_memory_event(memcg, MEMCG_LOW);
>  			break;
>  		case MEMCG_PROT_NONE:
> @@ -2693,6 +2694,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, st=
ruct scan_control *sc)
>  		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>  			    sc->priority);
> =20
> +		if (memcg->in_low_reclaim)
> +			memcg->in_low_reclaim =3D 0;
> +
>  		/* Record the group's reclaim efficiency */
>  		vmpressure(sc->gfp_mask, memcg, false,
>  			   sc->nr_scanned - scanned,
> --=20
> 1.8.3.1
>=20
