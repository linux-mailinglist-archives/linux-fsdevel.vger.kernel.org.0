Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3003CA1E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGOQJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 12:09:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229531AbhGOQJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:09:57 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16FG4UC8010655;
        Thu, 15 Jul 2021 09:07:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=op0k1tng/kMwQHQhBxCo1cSPIgaZ81K/mPXJ6e3kKZ8=;
 b=OF4xE2Up2EJtZKVkcJ7gZXX8RKdg03WmeZcDdEgX80lBaLKAA55xdfMzHFUElOTHNoW7
 G1Id4wDXP0rrjUALjuWTTajhteLOhRCMyl343VBx5XdygYxazPAfE8F3RoVVGCjuysIL
 NFreHDM3W7QYxXF921JnTZmNUzJxZzoRTMk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 39tfr6asr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Jul 2021 09:07:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 09:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcgO0U7CQoIdn+b1ubahNzPpr+AdT0NlN8L+AUZ63CBotq6M5yVQyqm5zXUFeDUISBqpAGjTi6o92efLf6vZUq1Pf/wsEFFhivYvDV0tRUbfFQXkkaFPcmVydxm0S1DcZcmxLF4rWKN4hOOOXJ0bW+4Vo9+TCFY1oVDUsLaqQlOtdai1lHMaOXgc20rWHokpyJoExSV6b3D3Jqbd3KheB3uqBK1LQDxxTVrFiC0tuq31hGNHGk4u+Cw7nqnMnMzPtyaCuUuIp7PgDxYCZrJvjDJ64loZeG11LV18+SiyqydGy+XuoIyZiVLEgP+5/GWjCCJl75zp0+2qwJziLVxOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op0k1tng/kMwQHQhBxCo1cSPIgaZ81K/mPXJ6e3kKZ8=;
 b=b1jU68InfjnIJqEmGAhefIagkOjMU0uFe9eGIuQ/m9PKImna2ZRbckFMkWQDvMKa+gwbgRxBnTr+kXo+6izhf+4sZ5oGiLQROqYFtRDzkK3i0ZebZ3a/tSZogekiCYXOMQRQqWmHlKCD3acH26NZcs2b3atXwDEeefz44UcnUNONDRV8eELoCHWlcI5rEgINOSuxRnvgDtkN2vRnYN2PWmZlNL+1hNeiAnkmTqx4NGcnp4jdx1CMDSxtuY5jrx7a5YzkwmDw0ERJOiUJ4kaorSg8q2De7kg5HcZMEr3/D39ZgvlPVyZ55IQSS7X5L1rUolsaTPkRQMJB7JHcz1wVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3221.namprd15.prod.outlook.com (2603:10b6:a03:102::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 16:06:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 16:06:54 +0000
Date:   Thu, 15 Jul 2021 09:06:51 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
CC:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:34bf) by SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:06:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae86aded-f23d-4caa-2b0e-08d947aa902f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3221:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3221373900FABF7CED9C436BBE129@BYAPR15MB3221.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+efPOtpbmOL+n8Nt+LtXVIvsESAHE0LotUCIW88B0nAjDFTBV1tuMNr6aXEruQM5VnK0K7m5kT98p7/5x4kY8qXNSyfYKoh/jVe56I2w9xKM1EsOSCLhzpX9LmnupXX1xaL2HH6NrHoVgOCVL2k1W+PIwzKPa9q3JJx4Fdo1hUmR80z04/ebW52+pUZDdnt5ABXI5+pgpTbv5b1qvNZODhUmtZ0dwCc3Xror6bapyMePqVEDWX+jy8lmI81WVRZrOUtEz4IrB+4u44mlPzWJ1G5QgjmFS06i5j6kPz5w08z3Rx6fowRHosWQF9WjAVEltNf0ud44qU/4EYuxZC8Tn1kPJtz9j3G59pkvj7hL2QQ3VaiO0MYyIGWK/YTMhDhHy5uXLQzN0v4dv+WatkOjvMWGzS5Bvw+vMA3aZgDx42QCL05tYXIKGR0N1gsGYXFvxIau6o47JiGKJ5xesTGrkITFs7x1rug9GRJgC3PVr6I+Dnayq5ohPO4BntUMJh1q5bRLgxHQgrGQ7KUOH82cQ2pjGaa8okdU3zdS6W877yQF6WPAi4ISEYf1FDB2BlePBPbTrovfHIeqfR9kZDAZ8auSnlQaWZbCPxBL3zqJ1xQpZdsKp6Rum3Rz6gFpjf1Mz6rotLIgNxoelsSLcbgXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(52116002)(66556008)(7696005)(66476007)(478600001)(6916009)(8936002)(55016002)(9686003)(4326008)(8676002)(66946007)(186003)(4744005)(5660300002)(86362001)(6506007)(2906002)(316002)(38100700002)(83380400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTFPDuYFo7ydmA7Eu+FcCFTV+RlPI6YHC7EZ847cMs3zA4ecDLkC7ekXYbf0?=
 =?us-ascii?Q?DPIGCSs8keMrjdfc42r0C15Q5bMTU/vqZdqNbZ6AxG2/ot7CrchV5V/aKEk1?=
 =?us-ascii?Q?HAmzvo53K5mmWxtl6tDHvigrmN0WtPGSVjr0lqalwD9misFK2VInrbM01tcK?=
 =?us-ascii?Q?+/x5wk0qjR3/NbZxnAWhqiuBTVLNEtBtMD+gKOKa+O+GL9NDjqTkZfD+2uuq?=
 =?us-ascii?Q?nRWNwfAU2ArQcNGw751ifLq4ImjNoOdNSBwwA+ihJ5OLu2wBQyO924TOp1qK?=
 =?us-ascii?Q?xVkvB9ataNLAi9GOUFFVOqsakO0JGo7UYVp5SHXFTZpO2TskxmjL4XE8xLym?=
 =?us-ascii?Q?zqK2Ujagqqqw/ft5e6TO+Mw+vYsvnNZTTXjDzjSu5chxlNGZF4HLdybpCHh4?=
 =?us-ascii?Q?s9hpNuQIc5RGsy8492PH8NVkmiPvepV6N89JJ7lebc0VgFZ4joFAfBR0npf8?=
 =?us-ascii?Q?LUyqD7APmrDLNVMzwD3ROmPIIIRrvK1SSOpGnSAoL26KE8SlfhGQ1AetsZZU?=
 =?us-ascii?Q?Il4HMQFbd/9CcMAKio8oIJ6B1QtMbSkMGwrFrguuvq4ylNrVNXPEGTGDYeQG?=
 =?us-ascii?Q?+lEaiOUEVi/XPO3krto+Isi0dMzZQx1gM6dfU8PXVvJaoX/vSjqMXYVYEYJX?=
 =?us-ascii?Q?usIjZdCvOWOhU9jrBl1He5xH0cvTHvQU8WukVVKli6X9nIGP+4V2/+nVtSnL?=
 =?us-ascii?Q?4EtpQzsRSt5Oi4uhsrC/xIw9fjUG1fWpnP/4KYy84ybTo6jrRkjouvfzrirU?=
 =?us-ascii?Q?LCeYrHptzA8o75r6k1o73nye9zF+VOzP5e5bATyC2SaB5SIWe8d1B7axGaE2?=
 =?us-ascii?Q?iGKPZUr5egocAn8B8ImyB8GMLYVtf5pWdTIi5HucvVJrUj0HQlKqVg2gZqTk?=
 =?us-ascii?Q?3UJSKjA5tJeRpW7RQ7cvJBzdXkm3e2Wl8oOAZBSLuSTSXw1fqcPKzEzFsmQ1?=
 =?us-ascii?Q?C+s2SzuN4RQJnueebrQpMGAnliMKV4dsr8VnRmCJWwvMVHcGv+Lfs1LpZJpN?=
 =?us-ascii?Q?kC1SoW6GC8Tz8qtjHPfDdMdxbAEtw/06xK/p4aKGmx/UN405hGx26t7vmvpL?=
 =?us-ascii?Q?2yxnJ95mDi9zVHaahYsX8lUw4x8+yL0kTRz36elQOhaRWe7hjJoTMREkqPft?=
 =?us-ascii?Q?PA2JzdlM+ObO0DnKmGS0w9g8i7gSRdsVE3IadywPFob0bOOBCaKpmCaU0ACB?=
 =?us-ascii?Q?f8tRqn6tHAgWr9UGTB90vJSGTC5tOtwGS3ZwohNNmH40Mtb+9oLFgbLq2cdM?=
 =?us-ascii?Q?gI5lwANU6jQ65FeCT0u88jFthvwisvmblHqUFv7GngENFEO8ClEFWnwygDcW?=
 =?us-ascii?Q?hQx0+taIIl1F3GQaUvTbFCPRt5eSt9qQA6rEVu/Y9dVZPA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae86aded-f23d-4caa-2b0e-08d947aa902f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:06:54.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pb0neGgdfgJegSmdIqBYyFsjqZUNVw/l74B+QoR/ur/j0Zi8mhNZzCIQcDFruU35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CRjL675fTM5lnsEE_aciNsewgzIPMmL-
X-Proofpoint-ORIG-GUID: CRjL675fTM5lnsEE_aciNsewgzIPMmL-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_10:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 mlxlogscore=891 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> Hi,
> 
> #Looping generic/270 of xfstests[1] on pmem ramdisk with
> mount option:  -o dax=always
> mkfs.xfs option: -f -b size=4096 -m reflink=0
> can hit this panic now.
> 
> #It's not reproducible on ext4.
> #It's not reproducible without dax=always.

Hi Murphy!

Thank you for the report!

Can you, please, check if the following patch fixes the problem?

Thank you!

--

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 271f2ca862c8..f5561ea7d90a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -398,12 +398,12 @@ static void cgwb_release_workfn(struct work_struct *work)
        blkcg_unpin_online(blkcg);
 
        fprop_local_destroy_percpu(&wb->memcg_completions);
-       percpu_ref_exit(&wb->refcnt);
 
        spin_lock_irq(&cgwb_lock);
        list_del(&wb->offline_node);
        spin_unlock_irq(&cgwb_lock);
 
+       percpu_ref_exit(&wb->refcnt);
        wb_exit(wb);
        WARN_ON_ONCE(!list_empty(&wb->b_attached));
        kfree_rcu(wb, rcu);
