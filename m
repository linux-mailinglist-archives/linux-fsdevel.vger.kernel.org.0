Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8744A36D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 02:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhKIB06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 20:26:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17182 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243469AbhKIBWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:22:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8Lmt8T029494;
        Mon, 8 Nov 2021 17:19:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kEe1gG5PhKBw5O/hvKp4ft7lMouVA+oZMvUv97iPlXA=;
 b=KQFDc0UxBOELTRJuxCzhLho6wmuY+1PvSSFv/XKtSSs+pa6eXmbyewLYX0h/mQ6Neyx2
 G4pRTuS7Sk7FLRoJrdIzyU2++bNHxHZkg8fscUrYXLnBT6KxoyfeDiHRprcM7yQvrY1s
 E7c9qBnfgavIeEKF3HrnfbedUo+rnLTmlsw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7c4rs9xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Nov 2021 17:19:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 8 Nov 2021 17:19:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8W9a2BtLAwFj6T++NjQK6djmuEqVhANXMSYbnsgKN1qXTMKv5BL6olQOeE8IHaxbKQ1O6m/Z+64d9DxxXOI9KpsgfjAy0KPU9IW/TulZEK9yiKu9iy3WFU/ofs5XJzX7spW2N/98ap6kpZu1cAmU8W+r3D0GqpZeFSMyoHa6CAVEBuUgoRCDjOXzl/35yKAHrjrWsFFV/He2mMQhlet89NOpWe9BT9MEaL2D3RGIlBmwjHbNG78UEy52mHghGJH99QoAQ19aixczL50hiGeMPIMSD3/+V5IdT6AbpQFiEfdh2T/kIy9iuxjHWnRui7dWHINNPtiP8UMBu1S95cKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEe1gG5PhKBw5O/hvKp4ft7lMouVA+oZMvUv97iPlXA=;
 b=aaZhfnj2xtl8UQFfd+gwbGN2+VdvdMzQTP8ruEf/xdWnqmkbpTZPb/sT8dTeMchxyKrio9ZbTMR/jne1RKzHtUvlIZu88HIDL3aZdt8HOyFoIxbIl8pCfB3FA2DxSMGl1pLLjUZrEGUvZoapv9clXi7rdGwdmpBj4ScYdmcMoZI6BA2+L+ZNzYtCMV0hHg21V1vKfXlR57yJqhSLGJ8U9p61DH05jTikAsiA86oOEODilIsr78UZxEWpKoGK2OQ9oKbPZls5ll1C5suvAXgQMBuFDmlBB+leGDBqdznjy1bBwmPUJGrlfAG5wbEIVd7WaHIFtSR9vzWWMcIH3ZPHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4866.namprd15.prod.outlook.com (2603:10b6:a03:3c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 01:19:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 01:19:11 +0000
Date:   Mon, 8 Nov 2021 17:19:07 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mina Almasry <almasrymina@google.com>
CC:     Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, <riel@surriel.com>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] mm/oom: handle remote ooms
Message-ID: <YYnMixe3zW4UEau0@carbon.dhcp.thefacebook.com>
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-4-almasrymina@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211108211959.1750915-4-almasrymina@google.com>
X-ClientProxiedBy: MWHPR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:300:d4::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3f8f) by MWHPR19CA0014.namprd19.prod.outlook.com (2603:10b6:300:d4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 01:19:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f588c90-0b19-40a3-70d2-08d9a31eefb7
X-MS-TrafficTypeDiagnostic: BY3PR15MB4866:
X-Microsoft-Antispam-PRVS: <BY3PR15MB48666A2F360B4FA38B39EB90BE929@BY3PR15MB4866.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTxA4Cl1gpT/Zw2PAiW32aOHgm1woWF/GtFFO7wVPwPLnHEnDwQ15ZUNql3XTUlK7BwMQccj6JroaB2budWPC/lWW5KzTDXsAf/EDklivzSovR02RkLNaPfKdFlJp3Y++rPEzSOS/vaKqO8m+rV5NVZbNK+23aTNXsoTFaS52vQz6QYjPQNQp1RUYnOCd9cPIS8870dnKezwWA3BXz1bY/gZli8xweN4KAQtRau3kfh+5JsIrrL9QwCShgjbn0cYZxkD3vnsmamki6mMOCLwD49tfumYILVzry7VFOkva14ytMumCTrq3v8Pg80shoyhCDI3J4ON6IEWbL8ZHSU7xTep8uSpcCetnnvyD05pkauyxTZ6pJsvYR06EZvoeluUW+byHsSpsCHCXSGi3G3V94n68u2Ra+8Z06XTDFkziJnxvx1TsXoes1Rtdnzd1zoAvPGZqYsH6370rJsLLDIXk7IO0UodFv6Ppr8tZn18WWokkEsWD67syn9lKn/+ec0ipKHPiVFu7MbahzuKqfd8qnhZvM41JAxYnNRXmBp6lAmz03Oxo6zoZqGYh0ol2AqLHn+kcsF7Yv0I65e17kl83kpr2gq64h8/ShvPSt068Y0w3r8nnMs3xYOuExTpQxp+y+ZpP/wlS9ww8ap0Ei+46Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(8676002)(508600001)(6666004)(186003)(66476007)(38100700002)(6506007)(5660300002)(54906003)(7696005)(4326008)(55016002)(52116002)(86362001)(66946007)(316002)(7416002)(2906002)(9686003)(8936002)(83380400001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ddeh5nTrLnYuNkMmEq08bQ8LZp+KnN3xV52VeIOy4IX2qxTtEWwCpQryPTPJ?=
 =?us-ascii?Q?OcHpi6jAQIHl/0XOF52GGwsll2v+5JESIQ53DTq9kxYfsrHOJRMLTqhne/Qz?=
 =?us-ascii?Q?R/BlOb9xssRxgFTaOtd+FXh1unIUoWhi/ki7qaNXvToGFu3Ad/9O9c7rXkvn?=
 =?us-ascii?Q?DypnQmtBQdjF0VL+z+A6kwWoVp+o5AhgTpYGraq22WUe0Q0jybYI1Qse1UQj?=
 =?us-ascii?Q?cS71v+y8y5FColXEsvMBGGr7J1KcR30Wb1Qtz4FUk+1G9gWWW8RbERgkOh23?=
 =?us-ascii?Q?dAF2DPgXPiTzhVi75Kgeyj+x4liGX19HHZkoOP50+YOZn7PA72NSStJoiOFG?=
 =?us-ascii?Q?bfyk60ygZqxWSKHTegfFSBIJpkznLxL9xFfbvOs9GYUw5w57MlfZewObWdLp?=
 =?us-ascii?Q?QiKcq4JRwmEUv6BpUZTxCDR8PGKilmT4+f2qGSM/GcR9lUauKa5PMZQR1iKx?=
 =?us-ascii?Q?m07enHIllMb6jFNEwiHbmRQWNUllXpFsjBXBOmzT36kiG5sKgZwuw4/aYnnG?=
 =?us-ascii?Q?plzqJ+eILchueISAUrwuESzFkYBPua5ODrWfccFIK3e1Fhuu58+RX/VPx8NJ?=
 =?us-ascii?Q?lj4zY6rJ3iI1UQxG6EOLxMl39D2FimnVHyVEB3Dk/9kzBK+YymCtMauSUL28?=
 =?us-ascii?Q?YCkCvuH+0XgtXZNN1QIwSnl6UxoQM/IaK5jeCxF/8jgX+P24XoXurJG3lTnC?=
 =?us-ascii?Q?n7o9bw9h/Nz1mUjfjQjjWRaTOd+Ymkx8dlGXdlf/pBw/4QqOBw7uZhCoA/b0?=
 =?us-ascii?Q?cHRzWSOkm1tA6QYvCJLNl+9Z+WWiUMxPg7bcLSerraPZ3JCrtSxUxTFjTeHk?=
 =?us-ascii?Q?suDswyS2bx22dnepUHYJXqaPzEcJTG8EdgT/VLusy8ofWmNFk+Q0Wu5O0NDu?=
 =?us-ascii?Q?n7w2bhIJYNCoBboOuTPbOQlWFnyDxhcDbBfkgukGGEDQsy1BGYwUZHM4j3Xr?=
 =?us-ascii?Q?R8OViNmKSFuAyIABsSKMeEwf0k9P7RsOkAIKs1ErBQ50K70eslVOiMv4Nggg?=
 =?us-ascii?Q?bfEd2fV/ISTjH81osV55WAIXXg/yVCBJ+npXDBaP3PeH+YrfUsrAjj16jrxa?=
 =?us-ascii?Q?iKicOugPpLzTZLK3HotREUocfm8UMp2QLuv2TUXomBGP/qcik2QWX1n1GqBQ?=
 =?us-ascii?Q?Bzo6I/KJr5ZItq3Pp/uwT8RFlZu+4omqzUSVPLN+/ca8qoO5RV3RhSH5kY+y?=
 =?us-ascii?Q?q9ofj1cWfy/OWuBb0RUB3ahvxtYA/K7JmywEb4gEA3vb5GXmslcKt5nZRO+y?=
 =?us-ascii?Q?AVW4HN1Q4Z7G/hWypYC+mebcxRMyDkedmtmnWMmvDiuWnaxArBFkGd7woy8o?=
 =?us-ascii?Q?r/AGPsuppeGAtOwFXouoT6HP6z8187B9xzFsh9jBxhVvkEXblrhYcx1ZkzMw?=
 =?us-ascii?Q?unuqedO/vmGi3HWmNuAjeYcoh8CrgRQDoW0D02Cf/HWTYfwtgVflDi3b8Iz5?=
 =?us-ascii?Q?9EVFmaef3GQsyHMRWs2SF3ffYnnW69IxKA8SuOa5U3Lvj8aAqFrvhrx3nFcw?=
 =?us-ascii?Q?GxQzfifnYMG7U3tTKnUTOmcgiHpuWceLgxI9AYyQof1oddE/nGJnpuahNOpa?=
 =?us-ascii?Q?qvEzugokJr2fm3PANRsRkqhYMGacQHD8uSOsa5pd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f588c90-0b19-40a3-70d2-08d9a31eefb7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 01:19:11.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbZRUkxFOCXkuHne9iwmnvRoVobHzVnKoo3VNs5qh5h0yB7FtAqgeERYqRKYCHKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4866
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8nKyS7pPGzUSzswA4GrC_eamSZBOvFEv
X-Proofpoint-ORIG-GUID: 8nKyS7pPGzUSzswA4GrC_eamSZBOvFEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=888
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:19:57PM -0800, Mina Almasry wrote:
> On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> to find a task to kill in the memcg under oom, if the oom-killer
> is unable to find one, the oom-killer should simply return ENOMEM to the
> allocating process.
> 
> If we're in pagefault path and we're unable to return ENOMEM to the
> allocating process, we instead kill the allocating process.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Roman Gushchin <songmuchun@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: riel@surriel.com
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> 
> ---
>  mm/memcontrol.c | 21 +++++++++++++++++++++
>  mm/oom_kill.c   | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2e4c20d09f959..fc9c6280266b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2664,6 +2664,27 @@ int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len)
>  	return ret < 0 ? ret : 0;
>  }
> 
> +/*
> + * Returns true if current's mm is a descendant of the memcg_under_oom (or
> + * equal to it). False otherwise. This is used by the oom-killer to detect
> + * ooms due to remote charging.
> + */
> +bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
> +{
> +	struct mem_cgroup *current_memcg;
> +	bool is_remote_oom;
> +
> +	if (!memcg_under_oom)
> +		return false;
> +
> +	current_memcg = get_mem_cgroup_from_mm(current->mm);
> +	is_remote_oom =
> +		!mem_cgroup_is_descendant(current_memcg, memcg_under_oom);
> +	css_put(&current_memcg->css);
> +
> +	return is_remote_oom;

You'll be probably better with mem_cgroup_from_task(current) within an rcu read
section?

> +}
> +
>  /*
>   * Set or clear (if @memcg is NULL) charge association from file system to
>   * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 0a7e16b16b8c3..556329dee273f 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1106,6 +1106,27 @@ bool out_of_memory(struct oom_control *oc)
>  	}
> 
>  	select_bad_process(oc);
> +
> +	/*
> +	 * For remote ooms in userfaults, we have no choice but to kill the
> +	 * allocating process.
> +	 */
> +	if (!oc->chosen && is_remote_oom(oc->memcg) && current->in_user_fault &&
> +	    !oom_unkillable_task(current)) {
> +		get_task_struct(current);
> +		oc->chosen = current;
> +		oom_kill_process(
> +			oc, "Out of memory (Killing remote allocating task)");
> +		return true;
> +	}
> +
> +	/*
> +	 * For remote ooms in non-userfaults, simply return ENOMEM to the
> +	 * caller.
> +	 */
> +	if (!oc->chosen && is_remote_oom(oc->memcg))
> +		return false;
> +
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {

I'd move both if's here:

    	      if (is_remote_oom(oc->memcg)) {
	      	 if (current->in_user_fault && !oom_unkillable_task(current)) {
		    ...
		 }

		 return false;
	      }


>  		dump_header(oc, NULL);
> --
> 2.34.0.rc0.344.g81b53c2807-goog
