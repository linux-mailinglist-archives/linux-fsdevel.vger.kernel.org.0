Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE83A1DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFITz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 15:55:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11902 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhFITzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:55:54 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159JrqCK024727;
        Wed, 9 Jun 2021 12:53:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FQeSwqBYlXX2OUV6btAidyxpfyqTQcv817nZY36nqhg=;
 b=gSW2qH32u0MX2MrW1l/n4k7ywmmO7fG3RjuGz5kbDTDMxla6xDiIryrP9i1Y3gquJ2O6
 ZNdHQ1nQQ3DGh7o3KvTCumtgFdTcu+TkTFfKzWCpnYJXNeD9t4F3NrMRFY+w7bVN3jp+
 3wqf3/0PgAxGgrLtofNlQLOipkBIcx/IMg8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 392wj330tt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Jun 2021 12:53:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 12:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0dj/G1nDY8Y2LUeHndY7WfErLkbD8xv7idWW4S+gGLFX3auStV87mrCJqFZuGqNdqTfHVv0Jfg2zCKc5FVkmCOm5730hZwOTU5nW3yMGmbkq/Vd3AUGjCAGsvDbQ7MEX0WZ2vOvbOW2nXMnIpUMF+/J+YqjkTBZ/zvgAxDMUV9zRn0DL85orCHyLQAhxRaU2xO8neXoIc5ZuQHWdz7S4YL0AozLZYPkL9er0WnTTbN2hBUjG6XO6dLFuIUANB+vv9Zt3rHldFQ/JbeIfhc2Gg8U1sH81CMATKp1OZWUMA/I6y7RjqXpwc6YIul2Un8a70E3QFRkwHvOmJ1GNWCWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQeSwqBYlXX2OUV6btAidyxpfyqTQcv817nZY36nqhg=;
 b=FLUucPbrI+5DnsNt/ydkHNXo6YrE/aD1geUwoGwR54OzocxhgjRk4srdQ1X6tbCfEZqFcsYPTLuyJ+ECZPqp095ipnVnkYl5pkuyaS9PbC8kftgg3ZTHcXnXL7y44EfjC8bjjz8HUwrjkFzhd8/4tEBohhioChB7jrNGfro0c0dGz6vk1h7Lr+Nxhxs+kBJnWgYEr5UIGmX5MVm5+wR9meQsGOB2tjgdB0ROqUPJ9Pq+V7TXWzKO2DWmOLPTQQ1CASQA0SKT9IQS+cSgPuCYZrPezcAcPG0PumxgOWSoZpJV7gXRmVaMJNigbNjfEE4Nplx7nVCDvH7JkXWt2XddvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4357.namprd15.prod.outlook.com (2603:10b6:a03:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 9 Jun
 2021 19:53:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 19:53:49 +0000
Date:   Wed, 9 Jun 2021 12:53:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YMEcSBcq/VXMiPPO@carbon.dhcp.thefacebook.com>
References: <20210608230225.2078447-1-guro@fb.com>
 <20210608230225.2078447-9-guro@fb.com>
 <20210608171237.be2f4223de89458841c10fd4@linux-foundation.org>
 <YMAKBgVgOhYHhB3N@carbon.dhcp.thefacebook.com>
 <YMANNhixU0QUqZIJ@google.com>
 <20210608223434.25efb827a66f10ad36f7fe0b@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210608223434.25efb827a66f10ad36f7fe0b@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:4d50]
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4d50) by MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 19:53:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 243ae537-4482-4d3c-313f-08d92b804c8d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4357:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB43573B17F663561F7D00E435BE369@SJ0PR15MB4357.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qY0Ol64g0EY97gMeNjEe5E8SpoDTtgUqVWwu68jV2EKlBVWQ59tV9y3W8yohxmXNlH4bIZvAOkJXGspMDAmXzmma/i9C5vykw2uLfLgGAB+gfHyfBN8bxa37u1fA7Hr20M2lSJt8fgP98dD2/vV1fRSgRLx4S0izyjL9wtuJqM2+silsBlTbio9NqeD6kiBaMrW3/wsNAi59rnPSDrzSlTPTHTbY89yPvB50cHajLkOYV+tDp66a6kft/ZyEDnGeAidriDbDW4do1IgM8/EYgRg8p2Cq9S3uzk3iEZGDBXffrDg6qUUsuZBMSp4KIz88iVuDmm8vCEo5Zr2pGk4FWopmQStOLLKWy5E30pGffQViGQXmoaJ4ivx3LlDHPeohiSY04emp7i9n1YrVPD3TdsJ+JDwrex60UR5Ouy8nIipqRn+6LU5Oe4gxCxCirXHi83qBrfa2ne0G+HOcsUGe4Bnk9vdU93SP82wzhK4ZA3eGtIFctmB3FukCTw8CVM6uLyxLIW0r0O9EmDoPENcDaey/mBBCLlICNtB+pT3vYgOBuW76TwXXNcRKuBd6JwZTH+dCmxC+qjTNxQExAmP3Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(9686003)(6506007)(7696005)(52116002)(55016002)(186003)(16526019)(66556008)(54906003)(8676002)(5660300002)(316002)(7416002)(66946007)(38100700002)(86362001)(2906002)(83380400001)(6916009)(478600001)(6666004)(66476007)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2bla81Fu8zB6KPISGErgG4KXHRjeLo6DpesjMUVJ2wC5RI2vnEkyo3auWss?=
 =?us-ascii?Q?QPUnHS8yR6siojagqoYf4xmYayPXEO5M4LvYiXAoS9cvmNoDKMm6pl/kEB/w?=
 =?us-ascii?Q?+eI4SoECxhDBT9NU8pPyndKtZNkp7K1dIOUB8AKyRrJtninQw0FA+Nyjz9Lx?=
 =?us-ascii?Q?/clyXlTgJB+1knDPHo3CGdlvm7VE3rcyLUuFVCXfokCqE+y1BRCPpT5BZRav?=
 =?us-ascii?Q?bEAWwVWLAYtQCMBvhgnvS5CnGGjbk1VehaLOEqP5nZ4lTcYKvxnfhIbsDDuU?=
 =?us-ascii?Q?eg9Z/aQoFEEvzfpD0n0PX5GblhAXNFpB/fDA9tZMXeEBc1Ep4UauGYYau5/P?=
 =?us-ascii?Q?ZQq25CRVigD2fIVCv7I3SxCIti/8k1HIU2anDdPmw7+sIdpQ9LUSvsgLl+yO?=
 =?us-ascii?Q?CsO8QxDUARQXJBwpQXNerWbzaWAoTyXnUgo3J24RT4XsrNvl366KVdS8KasC?=
 =?us-ascii?Q?xuVuawpVbeR5JC60Gxw8nH0y6xWclIok8uj5OK7Dt3zDT2KvN3w+U5MlVfVw?=
 =?us-ascii?Q?EhHktk7wdBiNrdzUdbd66jWF+E9ZRyxVtKAPEkS4V9kDS1NVoAeiyFNJyTIr?=
 =?us-ascii?Q?Y62q+0bmSAHD/+WD/fVEwzTcvULCQnPnt8eAF+1n9OtpLTM+IrQPBPl48Ykv?=
 =?us-ascii?Q?fA2CimtybIoXmaa9ePHOUG2MHozt6+P9ihc1vKQHx/wI4U/aN/Sdn6b/AOUG?=
 =?us-ascii?Q?TvVWwGYXk6avT4EIoVjIyqPk2mXOPmA3nFYwB4lHLpdwJzjIplCc10seu7Q3?=
 =?us-ascii?Q?quvJbGkbrg1IBcai7rTL6/8fjgPjOXfb+CfiQFQz7Ke1N6kdVy3SUqemtCLG?=
 =?us-ascii?Q?BdHIBjXE1bx3fIL9pWPoZUG5Ywf04gus/CA3C0c75GmzzosjEUs7nYVkQYcm?=
 =?us-ascii?Q?pCtWC91X9iV5Gi0j3e5TQXMQL8NELb8tKJJm9MvBTVW5xj4G6p3osQM8PlUp?=
 =?us-ascii?Q?e8hygvfFYNiHmNtnMRZRdSAV5P9cYNW4DAFwJ8q5+/1fUnO9MFoy/LZuPdSV?=
 =?us-ascii?Q?l0J+ukChBiayFy3O7i2O60wm/Glav/NA9EVZanMKc2KbZcpvSbRGxSjeQkCZ?=
 =?us-ascii?Q?K7/2MvGLYGE7BWRGQRJxuCB3rd2zBcbrJu/txdafAVFD3Wc0EET6FSPN7qMJ?=
 =?us-ascii?Q?IRZvOIMPNqHKonpYwzUDW2QaCGkRWON1yejZph58ZSFL96elKNn0qItEoXw9?=
 =?us-ascii?Q?Gbovpy7xlKISaBCGEtuBteWzD7ZEVcU80fqe45Myyyw1pcpdpO9FFQgfIuYI?=
 =?us-ascii?Q?WPO65OG7C2rjIaw82daaVdsry1goRIbXnxlZovZKRERTaEoMbeJD3+BjxC+Q?=
 =?us-ascii?Q?mGE3LXno+dHx+y8YbN3yTJw+zFt2EWwigFu91Qb21Jx8vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 243ae537-4482-4d3c-313f-08d92b804c8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 19:53:49.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgkJiTKzNf2OQCfx/8LVoR9KvHds0lshk61OaLZyFBtYtO18/iigNhraa9J8iQJx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4357
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 7jafD61RtPESkdK6WvBAJ7sPP6Ty41pN
X-Proofpoint-ORIG-GUID: 7jafD61RtPESkdK6WvBAJ7sPP6Ty41pN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=932 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106090103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:34:34PM -0700, Andrew Morton wrote:
> On Wed, 9 Jun 2021 00:37:10 +0000 Dennis Zhou <dennis@kernel.org> wrote:
> 
> > On Tue, Jun 08, 2021 at 05:23:34PM -0700, Roman Gushchin wrote:
> > > On Tue, Jun 08, 2021 at 05:12:37PM -0700, Andrew Morton wrote:
> > > > On Tue, 8 Jun 2021 16:02:25 -0700 Roman Gushchin <guro@fb.com> wrote:
> > > > 
> > > > > Asynchronously try to release dying cgwbs by switching attached inodes
> > > > > to the nearest living ancestor wb. It helps to get rid of per-cgroup
> > > > > writeback structures themselves and of pinned memory and block cgroups,
> > > > > which are significantly larger structures (mostly due to large per-cpu
> > > > > statistics data). This prevents memory waste and helps to avoid
> > > > > different scalability problems caused by large piles of dying cgroups.
> > > > > 
> > > > > Reuse the existing mechanism of inode switching used for foreign inode
> > > > > detection. To speed things up batch up to 115 inode switching in a
> > > > > single operation (the maximum number is selected so that the resulting
> > > > > struct inode_switch_wbs_context can fit into 1024 bytes). Because
> > > > > every switching consists of two steps divided by an RCU grace period,
> > > > > it would be too slow without batching. Please note that the whole
> > > > > batch counts as a single operation (when increasing/decreasing
> > > > > isw_nr_in_flight). This allows to keep umounting working (flush the
> > > > > switching queue), however prevents cleanups from consuming the whole
> > > > > switching quota and effectively blocking the frn switching.
> > > > > 
> > > > > A cgwb cleanup operation can fail due to different reasons (e.g. not
> > > > > enough memory, the cgwb has an in-flight/pending io, an attached inode
> > > > > in a wrong state, etc). In this case the next scheduled cleanup will
> > > > > make a new attempt. An attempt is made each time a new cgwb is offlined
> > > > > (in other words a memcg and/or a blkcg is deleted by a user). In the
> > > > > future an additional attempt scheduled by a timer can be implemented.
> > > > > 
> > > > > ...
> > > > >
> > > > > +/*
> > > > > + * Maximum inodes per isw.  A specific value has been chosen to make
> > > > > + * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
> > > > > + */
> > > > > +#define WB_MAX_INODES_PER_ISW	115
> > > > 
> > > > Can't we do 1024/sizeof(struct inode_switch_wbs_context)?
> > > 
> > > It must be something like
> > > DIV_ROUND_DOWN_ULL(1024 - sizeof(struct inode_switch_wbs_context), sizeof(struct inode *)) + 1
> > 
> > Sorry to keep popping in for 1 offs but maybe this instead? I think the
> > above would result in > 1024 kzalloc() call.
> > 
> > DIV_ROUND_DOWN_ULL(max(1024 - sizeof(struct inode_switch_wbs_context), sizeof(struct inode *)),
> >                    sizeof(struct inode *))
> > 
> > might need max_t not sure.
> 
> Unclear to me why plain old division won't work, but whatever.  Please
> figure it out?  "115" is too sad to live!

You're totally right, plain division is fine here!
Please, squash the following chunk into the last commit in the series.

Thank you!

--

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 49b33300b1b8..545fce68e919 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -229,7 +229,8 @@ void wb_wait_for_completion(struct wb_completion *done)
  * Maximum inodes per isw.  A specific value has been chosen to make
  * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
  */
-#define WB_MAX_INODES_PER_ISW  115
+#define WB_MAX_INODES_PER_ISW  ((1024UL - sizeof(struct inode_switch_wbs_context)) \
+                                / sizeof(struct inode *))
 
 static atomic_t isw_nr_in_flight = ATOMIC_INIT(0);
 static struct workqueue_struct *isw_wq;
