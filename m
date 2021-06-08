Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9558E39EAA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 02:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFHAWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 20:22:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34606 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhFHAWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:22:30 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15809tTS004509;
        Mon, 7 Jun 2021 17:20:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IVK68f95zn6CENMdKH0iXxJ7dtkbyJAbPipxz4l/l/E=;
 b=Gg1bYcOKcOdtfQqzOfxhB2mIkAHABhPFYmTzTxy0cQCOkeHMLV9ZpQTw1TF/p8g01Ork
 hivXUndjD7iJl7RI/msjvt08SirvOXIejt/gUVpLzFfSa1+HpmTr+7lvgTpJkWzXpiak
 FTbzwRLwiS0tVKCi6Nh+Fy4fU95+28a1zKU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 391rhyhvud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Jun 2021 17:20:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 17:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiwPU2DepKsC8LGqByvr/AImdMK2kmrdRiOJBntJnvm425N6q9PE4S9+XVxTy4l+Wsud5RoSlgCA+EMPRlHSauZEO+Y/H1q5JVm9uBOoCH15F8rwZqbyFBY23eHgBv22rOx7YVN5usEwFrJpiZ+TtbbuF5cef9tNT/k8zEMk3EipBXrdFfZpcev+tjvbUXcU59pWlceqgL4rGMebdxd5f5BL7pflTend+9ueeuNjmTB7nnlMGFeOGvCAqFTHzN6Tpb/vbB+dvvBOHU85vHKHTpaUbJ5EtRN52KyQ6vm1ajXYrX1spbnhqJoO0TiHbISFiI4cG2sQiIXiituhO2oJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVK68f95zn6CENMdKH0iXxJ7dtkbyJAbPipxz4l/l/E=;
 b=M3ku3Wnhc/It1cHEiaLwkRCGAZr7E5mptorMdnuKaBP1gCavBqY2xBkCLBYotVZhHagPVmzqhYJ6cxQeBGRuG7vPLcq6OTkce837iSrnRGv0k7e0A/46/tglFwt5ImmQgw/tIPkZj/JeY23p5FSESBh/Q0QsEyEbyZpPKB1Dgx3fPpga9gsH4iTCevuOIRMHdSmJ+puf45OcD9JQFurHyn8X8s3f5yZ8d3QEopEsYN/fB2QDMTMdi43f2LTx463oU8E7W1qSFLxdy50e+L/AdJQBI/UW9Kr/GVJUvyrnhfo4p1VKnJwzHN6vWt1Fw2SjflvGMjdJTCWzkSxm1jvj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2712.namprd15.prod.outlook.com (2603:10b6:a03:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 00:20:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 00:20:29 +0000
Date:   Mon, 7 Jun 2021 17:20:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YL63yf3oIuLDlxNF@carbon.DHCP.thefacebook.com>
References: <20210604013159.3126180-1-guro@fb.com>
 <20210604013159.3126180-7-guro@fb.com>
 <YLvt8f+r7aFkmluG@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YLvt8f+r7aFkmluG@google.com>
X-Originating-IP: [2620:10d:c090:400::5:2c0c]
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:2c0c) by BY5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:a03:1a0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 00:20:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6dc09d2-6527-4cae-b199-08d92a1338b7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2712B03BD919E14EE4EC06C6BE379@BYAPR15MB2712.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BR+tBukYmg/zo2oUEuaIZ1i2p0v3t7ErgU1bjYA1eINhLWF7ax7LW0ECek/x7qhG23PTKZD4bsPK7MuNRU60psDWF1vms8BTuSzsDitDSeRKbcKSZMjZQdDoCvtP8bGsAF46mOL1+pkx5fBxPCpOicQTttyst3u9gvDqK1uq+Syff2bQXDxPCegtZKTdfXf9tbf4w6NQ/0G2V2Re8K4mVx6AG6vVzUW+DlW5lI8GcSD01TE858PWJ5amolsPeL2MflAov8nMgymDcFN6dCgIqPsJBUEjEs8A+Acz5SUz7usSmry4pcxDJYku1xLs70pF8j+kkxCyY4culEkT6vDJzz5t0WVy4/JrCCqX0P1JaEllzslz/xWAqNjSsjbwEhJUKYKyVZyq3CBYDGKVnHe9bFbPt11SMXPdXjhgPueE/Jjd8yEKHZV1SSKpQ9jQ0u4zwN1TIa2GtM5y3QwwDc4kbYUIbqDFnNy4ZGmz0EXYhV1HP1mVkEn8VEShkVo76Ljk0ZZD8HMw7ubplLIe66IWWWwdUIR8pYLH4SqJs3QQ42V3iR6U2vW2vpvgg3f0FCwvd8W0j2ZwxVuQBrDCs0y2lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(54906003)(316002)(66946007)(186003)(8676002)(5660300002)(8936002)(66476007)(66556008)(9686003)(478600001)(7696005)(6916009)(83380400001)(6666004)(6506007)(4326008)(2906002)(16526019)(38100700002)(52116002)(55016002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k91FgOR8WleEEEJo22Bpncb4AiV4qSB96mutp1vY5HZ4ADEe8ZA+NefUlpFH?=
 =?us-ascii?Q?o8xNdxP7R9yzSRKJxx442Qzs0WKyjV6jCpdsbV+ESGB0l0nIzUgGii2v91mi?=
 =?us-ascii?Q?bp3kemq7JpQ5442ji5gNysZCFhZtqvUCpP3gGV1eGwYWIZeaBN/1rPfYpjwW?=
 =?us-ascii?Q?hNJ8Ur+XRDUY68qSJvz5Nef9mhFYA6bj86Vqgl/CKFH2V/3xCVWpAqGn4kWa?=
 =?us-ascii?Q?T4PVYXV7FmzGWNZO7BN65kJsZHh0HakhpIfr2yhOAIcOVmf3W7alz20ooph9?=
 =?us-ascii?Q?nmsGEnFK3aIkhXBzVmpOjizM40sm8C3IaCpodL3KvSxXzUZr05/A7JgCvq3H?=
 =?us-ascii?Q?r0B6Su4mccNV02WalXt1Q39rSAb8fD4meC+DTEqct7A57DwFOQGCxm6x47Oj?=
 =?us-ascii?Q?2PTor8MvMxohVT8qOlVLsb7d67ZOb009rYk1KfyYNWe5yPqSFUUsYasitPDs?=
 =?us-ascii?Q?1yJa7mVDR8GDGCbPhC68erRsn96w+RJ3LIAFbHzoYyTPZvqwpgVVqcq+NHkK?=
 =?us-ascii?Q?PgIBOuGoUraN0+f1N7BVtJU4viSQFvaujoRFlCYc7f9LQtHJ+fc81nPV4/1D?=
 =?us-ascii?Q?AdzwRxlE5IBDEkSoD8D7CTpQZH7rPcngDcrnFk7BmWnSaA1fNCbgOCJ/yTn4?=
 =?us-ascii?Q?e/bp2+FEHoTtdTOIweP8QQ32vNKfzjBm1Tpkm8PICy5bZaTFh8b/CKEBKr4g?=
 =?us-ascii?Q?087Yg7IUK2FoXz1K/DS0oc3d7AQ8r/qY88hQvxvgn7Uzn1EWeMW002yu4AEi?=
 =?us-ascii?Q?mFrn7DT72NjBpnnJ2hlTj2N73SOsDyLOxbmlGtPP66vzn3dk94XmtG0NGycz?=
 =?us-ascii?Q?MgaVwoig77JAcMdAsvIUW7L6CojSXYwvW9BswFQlBPQBRJUQYl9qoIn4FHDU?=
 =?us-ascii?Q?dy8mETH7JfXVWNZyUge1HgxmAwU+56c8tyrMKV/jPPaV+UNvAdwFcpVidb6s?=
 =?us-ascii?Q?DmV+fUEzwWu61IDmrmSIjYZE0khWjdISWAJb9VZKvvrowNupXVqTnUhkgDI1?=
 =?us-ascii?Q?gLddw0GUhLrl3x7UIIMSeBOV/tyXs6wBzNSs2IWcL4Od6Ci8dF5q85uvbESK?=
 =?us-ascii?Q?om0Gnyz3cP2ce7M4PRy1lD7Kl2hLmTISZHxtS4xuRD+JsxtYSpNZIzFBaA3B?=
 =?us-ascii?Q?v762orD+KqNaEytzoWqMsMr5eTGS29YfC6vhGUsjmA2mV9RK/seWhFUn8Myl?=
 =?us-ascii?Q?BOSYpoQQbt7yCreRjQV7WN0uoqNiBEl0fJFkxAswy10GpsyG2Ic4nl4U7exQ?=
 =?us-ascii?Q?6OYS8x3RHH/UVJPLRJ+yrZakKEVLNaplx0x1QLwCEaKkSbuRQ8rj57A+v3k6?=
 =?us-ascii?Q?0c0SmqXYJm2oS2gokAYl4vqnQ4tw6veD0wp8SZFy5AO/Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dc09d2-6527-4cae-b199-08d92a1338b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 00:20:29.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa7egUtFcnZnPbsAWbw1C48OpIxChjiaeBSjclcI8E7Pdyu67tscSU6KMYlQ6mb4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2712
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3rFgCFOYt_YULrstMiecIdB1w_ggVOT5
X-Proofpoint-ORIG-GUID: 3rFgCFOYt_YULrstMiecIdB1w_ggVOT5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_15:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=423
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106070161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 05, 2021 at 09:34:41PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Thu, Jun 03, 2021 at 06:31:59PM -0700, Roman Gushchin wrote:
> > Asynchronously try to release dying cgwbs by switching attached inodes
> > to the bdi's wb. It helps to get rid of per-cgroup writeback
> > structures themselves and of pinned memory and block cgroups, which
> > are significantly larger structures (mostly due to large per-cpu
> > statistics data). This prevents memory waste and helps to avoid
> > different scalability problems caused by large piles of dying cgroups.
> > 
> > Reuse the existing mechanism of inode switching used for foreign inode
> > detection. To speed things up batch up to 115 inode switching in a
> > single operation (the maximum number is selected so that the resulting
> > struct inode_switch_wbs_context can fit into 1024 bytes). Because
> > every switching consists of two steps divided by an RCU grace period,
> > it would be too slow without batching. Please note that the whole
> > batch counts as a single operation (when increasing/decreasing
> > isw_nr_in_flight). This allows to keep umounting working (flush the
> > switching queue), however prevents cleanups from consuming the whole
> > switching quota and effectively blocking the frn switching.
> > 
> > A cgwb cleanup operation can fail due to different reasons (e.g. not
> > enough memory, the cgwb has an in-flight/pending io, an attached inode
> > in a wrong state, etc). In this case the next scheduled cleanup will
> > make a new attempt. An attempt is made each time a new cgwb is offlined
> > (in other words a memcg and/or a blkcg is deleted by a user). In the
> > future an additional attempt scheduled by a timer can be implemented.
> 
> I've been thinking about this for a little while and the only thing I'm
> not super thrilled by is that the subsequent cleanup work trigger isn't
> due to forward progress.
> 
> As future work, we could tag the inodes to switch when writeback
> completes instead of using a timer. This would be nice because then we
> only have to make a single (successful) pass switching the inodes we can
> and then mark the others to switch. Once a cgwb is killed no one else
> can attach to it so we should be good there.
> 
> I don't think this is a blocker or even necessary, I just wanted to put
> it out there as possible future direction instead of a timer.

Yeah, I agree that it's a good direction to explore. It will be likely
more intrusive and will require new inode flag. So I'd leave it for further
improvements.

Thank you for reviewing the series!
