Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543A3CEF1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbhGSV2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:28:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9850 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346630AbhGSSBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:01:47 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JIcDD5026108;
        Mon, 19 Jul 2021 11:42:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oWD373n3Ta6ex8I1fquInmV4UeOMPNPE/XHoLyuo4B0=;
 b=AlAzIMGNWOHJW3TluuAYFMg38V0klIKQSgmP/P8V6PoSnzshQxHlKlk24O+oTj7HiMYQ
 FaXZuoh+wGRtapnOvGwoJR+V8i3YGbM6g4dFc5HFG/ZtjfA7uav2E+dA4WWT4UHtu9vM
 Tcunl8nMHDO925d5Xn9dF8fLOU5JuDcOWbU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39wame1rkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Jul 2021 11:42:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 11:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SriSLriX9aSRDz2iXHduo/99L/Na+K4EVkqTB6Y5+EQ0K4GAQcx9kFmUWG2u18YsyG1NHL4yZE13fNKJu8kH4CTSmIYrfmBBHqEEIR8/WmDvhgpXVQocagPQhOhK8OunCibdDy8CJ6pfmSI09+DxrwiUuDasLCIpCB0+NGM19Gsxmf4Y1f2zlUjm90XZYOLYR3wvB3gs3nO5AdE1G7Xz+lVsEPdPoB4mBM3ajWtXihEL9P1Qv0tHtk5kkXIhJS+w7WSzjgOgbffTGfVM2imo3vTPYYvD1fVJbIMh5VEXoxgRerDPbJFDiajgqZSbn4Ma3d/V3b3Jf86TL1aNV6jG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWD373n3Ta6ex8I1fquInmV4UeOMPNPE/XHoLyuo4B0=;
 b=YBcmr15yRXKoGQdPFsxAY26nIKS3woUJ87FmsBWO/s1XiIX4Fe8P4JIxnpw2Wru9pQusRl9/xJMSPnf8BxB/SBBv4DRuveOApAIoh6G27zcDcEkjoSlyC8s6dDaU7LQY5pn2S7H3p3HK0DXENQTAbwUlDeUk3KCSo7aArgCV+GFg/290sy/k2eIfTVaCxbivH43kxFwZ6xzfDkc4J4HNXCOBwGWt+nVYYFFpYERc6n8nyn3+VIw/dOlqUleA6xFv0QglIpoSZ9+lNLAPNrv3/tTRqYOsfZ889Od3h/s2j5ntSK8AG8I08YAMguK7vrxj4E2BLiqy6Q+HYHTPClUa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4867.namprd15.prod.outlook.com (2603:10b6:a03:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Mon, 19 Jul
 2021 18:42:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 18:42:10 +0000
Date:   Mon, 19 Jul 2021 11:42:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] writeback, cgroup: do not reparent dax inodes
Message-ID: <YPXHgGqTACx5QiRK@carbon.lan>
References: <20210719171350.3876830-1-guro@fb.com>
 <20210719180441.GH23236@magnolia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210719180441.GH23236@magnolia>
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:41d1) by SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Mon, 19 Jul 2021 18:42:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0080674f-8407-4895-cae4-08d94ae4eaeb
X-MS-TrafficTypeDiagnostic: BY3PR15MB4867:
X-Microsoft-Antispam-PRVS: <BY3PR15MB48678E0215ED5796ABE33E3DBEE19@BY3PR15MB4867.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ89LeWlMkI74nnXygBylxUVrGUp90Cx6u7M2us/4I5bJQ06b1Y85iurxG3oIZQCnEIz0nurcvdV/eVGJcYEmrUd9+f62TsXDXkaImLyzxGP/FwUC5uvB0QsZtnUzGkLCjaDb4MCdpKtaiPWJ3smYx/p4NfzNgetku/YGju28sTJcMwoqlcQTZrSRoaphzSFPbOmCUMlcZNIQ016z/YO2vJnMw9KmiaJqQIwMkVObDQQTR+RvhbkwCrTHHJ/XZW/iQ98J87wfZ4EWNeGoX8j1tPveNGd4vqtFRRhut+mTbWC8zSbXACQ4hhiialLE2AwZe+6OHQMNX1P2n7w/SxMvUQvHIQ5NTg/woqow7+gusXW0/LhOPErUh13JTyCrwQFowW95i9B7OjSk4MCNOpKZ5TIhplzKXfAPgWyHPDyLNM8r4Bcxb3iMUmqsCK4sWBq+w9RyLF3JFyW4MNR10hX/1Q4uv1VFIgt4YnmcMeSOAX1Q4pqWmv6u+BhszRrmltAIHlFcZIlK0LVgbBzjhFytyu9xUR62iajCbnnZ/zML86d1WV+BSjqqBj2imVFTKlblitx4DEFL1+ojMeeKj+1COA7pVe8MpQ2OMkz/F7SNdH/zMLq77tc5JceWxJmJapx/nfhtVZM80fnvc+bialKUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(54906003)(316002)(38100700002)(6506007)(186003)(83380400001)(8676002)(86362001)(52116002)(7696005)(8936002)(6916009)(66476007)(66556008)(66946007)(45080400002)(4326008)(55016002)(8886007)(5660300002)(478600001)(2906002)(9686003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3px+NAdNg7ojlVxJ+/hRURTGqa3bc8BIK2G/TOC7AvbhN7sfsayRJP/oYOz?=
 =?us-ascii?Q?eBzetggw9kHncDhOVoHwGp95QgdyY7thd11kPWJvUgYH06GJxNk1lLTLibMJ?=
 =?us-ascii?Q?MgHDvs/Hgrrd5VVVC9bvwLMVJ+LlwoqtkP4Mwbebq9TeQh6sFwhYWu9/FokM?=
 =?us-ascii?Q?n8lHvLz4DGrPOYnxjVbsoYVDiuoBqcdqv0rSntHGxtrbzUlOyCpya01coJLo?=
 =?us-ascii?Q?wjmB7yzYosDypBeR/+JCwwuib8sPW4XCmFwhYlLrZwvZlxnx4cztPg43Hpzi?=
 =?us-ascii?Q?BeAVUGPfSfGbkp6tNdhFqbsPD8szxM3NNJ13NgHNgvT5tCVO9Ye69apVvJBN?=
 =?us-ascii?Q?1x9wv6ezVCFrZ1Ujs2hjWaeF56tiJnEN8gSx4qPdcuYEbRl2p574mEeUQDVL?=
 =?us-ascii?Q?TAudLVrmRhkjjaxCxxQqZrOOin6mu7IndJn5iWv7JUbY+C54gt4Pn3Cy0EFY?=
 =?us-ascii?Q?plwTU/W/l5mXT82lxep8/41w9/iMqPkTawu0OXaH9BvIJJghVTAJ6MTm9dvV?=
 =?us-ascii?Q?JptLumsYQa4gHEpF3yEhekUNCQVYUNsh29HyrdNR/lGqweceXbHDqXIdcQLa?=
 =?us-ascii?Q?31Lu8v6AyWK6NRI8IMBSSMEdR2isKXVoue+leA5FoO5iim965GvbxX6musT+?=
 =?us-ascii?Q?mVJj9S2OHRGw1odv214/E9HAiIUKeevGgMyIO5O5J+gyZvHWpfmmJThEm1D5?=
 =?us-ascii?Q?+FGgwWID3OAn+Hkvc9I8ilBbxNAXCvp9RinnNM44eTsDv5lqx+mlWjLu+g3x?=
 =?us-ascii?Q?odD3bsuH18szGvD5P1U6LSLcur+V6TvppLGrCpFBWW+MVpFWCwiCubV3MnIq?=
 =?us-ascii?Q?8bKeUu8HIeqeciUsBLTrT/c3fR/WHeaNL0kHatPaQajiicUBgAdFs1UMWgHT?=
 =?us-ascii?Q?oWzcVq/FVgc5UcYmF2iTiqG6vWHM+lf4yLkvJvM+ve23+p4sUsZh4WgqNgw8?=
 =?us-ascii?Q?8cz0bdXFqaeQ3ffPIOhYxP+Cc76qG07cyV1lEHrO9by7HnJCrhCMXJ92rqGo?=
 =?us-ascii?Q?EB5eAey+ViCnn+lgQdI2k7EdKC5K8UgfcPto7cuxI6BrOYQVHqzOcwMppmyh?=
 =?us-ascii?Q?eAUya3yroJURfw5TZaz0Wtuy1AzPu+kZVazBv2ZepCuGoVBAMIp+mdCDXBH+?=
 =?us-ascii?Q?owVzN4+RBjKus949WBxoaTQfEjnw9escnnCNOaCXLZNykwA8ghTucNtNnkYK?=
 =?us-ascii?Q?q4eQmSBsrWqV6vHXz7EsLIHlIzH1CpnFmkoh6oQdUk5SpK//YHArTGhmkkSD?=
 =?us-ascii?Q?BTZwX9cuJSdBiDcWDdAzJ2aRdkadzSyA31s9+Llq+8rcEaDG7s6kmOCp9Wgh?=
 =?us-ascii?Q?kV2n/ojXWinU3Blqg5ZC01/GLlQAibIctOe7ETN1Wvxs9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0080674f-8407-4895-cae4-08d94ae4eaeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 18:42:10.5855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzPinsy9pudQUWH8j8JRNjEop6l69U+eTcLjzR1ERe5fOksHk2q5S7MjwLX7S8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4867
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: VXrDmt50PHkVdVNtSGp_OszQZofrqa58
X-Proofpoint-GUID: VXrDmt50PHkVdVNtSGp_OszQZofrqa58
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=983 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:04:41AM -0700, Darrick J. Wong wrote:
> On Mon, Jul 19, 2021 at 10:13:50AM -0700, Roman Gushchin wrote:
> > The inode switching code is not suited for dax inodes. An attempt
> > to switch a dax inode to a parent writeback structure (as a part
> > of a writeback cleanup procedure) results in a panic like this:
> > 
> >   [  987.071651] run fstests generic/270 at 2021-07-15 05:54:02
> >   [  988.704940] XFS (pmem0p2): EXPERIMENTAL big timestamp feature in
> >   use.  Use at your own risk!
> >   [  988.746847] XFS (pmem0p2): DAX enabled. Warning: EXPERIMENTAL, use
> >   at your own risk
> >   [  988.786070] XFS (pmem0p2): EXPERIMENTAL inode btree counters
> >   feature in use. Use at your own risk!
> >   [  988.828639] XFS (pmem0p2): Mounting V5 Filesystem
> >   [  988.854019] XFS (pmem0p2): Ending clean mount
> >   [  988.874550] XFS (pmem0p2): Quotacheck needed: Please wait.
> >   [  988.900618] XFS (pmem0p2): Quotacheck: Done.
> >   [  989.090783] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tail_blocks)
> >   [  989.092751] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tail_blocks)
> >   [  989.092962] XFS (pmem0p2): xlog_verify_grant_tail: space > BBTOB(tail_blocks)
> >   [ 1010.105586] BUG: unable to handle page fault for address: 0000000005b0f669
> >   [ 1010.141817] #PF: supervisor read access in kernel mode
> >   [ 1010.167824] #PF: error_code(0x0000) - not-present page
> >   [ 1010.191499] PGD 0 P4D 0
> >   [ 1010.203346] Oops: 0000 [#1] SMP PTI
> >   [ 1010.219596] CPU: 13 PID: 10479 Comm: kworker/13:16 Not tainted
> >   5.14.0-rc1-master-8096acd7442e+ #8
> >   [ 1010.260441] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
> >   Gen9, BIOS P89 09/13/2016
> >   [ 1010.297792] Workqueue: inode_switch_wbs inode_switch_wbs_work_fn
> >   [ 1010.324832] RIP: 0010:inode_do_switch_wbs+0xaf/0x470
> >   [ 1010.347261] Code: 00 30 0f 85 c1 03 00 00 0f 1f 44 00 00 31 d2 48
> >   c7 c6 ff ff ff ff 48 8d 7c 24 08 e8 eb 49 1a 00 48 85 c0 74 4a bb ff
> >   ff ff ff <48> 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 48 8b 00 a8 08
> >   0f 85
> >   [ 1010.434307] RSP: 0018:ffff9c66691abdc8 EFLAGS: 00010002
> >   [ 1010.457795] RAX: 0000000005b0f661 RBX: 00000000ffffffff RCX: ffff89e6a21382b0
> >   [ 1010.489922] RDX: 0000000000000001 RSI: ffff89e350230248 RDI: ffffffffffffffff
> >   [ 1010.522085] RBP: ffff89e681d19400 R08: 0000000000000000 R09: 0000000000000228
> >   [ 1010.554234] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffff89e6a2138130
> >   [ 1010.586414] R13: ffff89e316af7400 R14: ffff89e316af6e78 R15: ffff89e6a21382b0
> >   [ 1010.619394] FS:  0000000000000000(0000) GS:ffff89ee5fb40000(0000)
> >   knlGS:0000000000000000
> >   [ 1010.658874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [ 1010.688085] CR2: 0000000005b0f669 CR3: 0000000cb2410004 CR4: 00000000001706e0
> >   [ 1010.722129] Call Trace:
> >   [ 1010.733132]  inode_switch_wbs_work_fn+0xb6/0x2a0
> >   [ 1010.754121]  process_one_work+0x1e6/0x380
> >   [ 1010.772512]  worker_thread+0x53/0x3d0
> >   [ 1010.789221]  ? process_one_work+0x380/0x380
> >   [ 1010.807964]  kthread+0x10f/0x130
> >   [ 1010.822043]  ? set_kthread_struct+0x40/0x40
> >   [ 1010.840818]  ret_from_fork+0x22/0x30
> >   [ 1010.856851] Modules linked in: xt_CHECKSUM xt_MASQUERADE
> >   xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat
> >   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables
> >   nfnetlink bridge stp llc rfkill sunrpc intel_rapl_msr
> >   intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
> >   coretemp kvm_intel ipmi_ssif kvm mgag200 i2c_algo_bit iTCO_wdt
> >   irqbypass drm_kms_helper iTCO_vendor_support acpi_ipmi rapl
> >   syscopyarea sysfillrect intel_cstate ipmi_si sysimgblt ioatdma
> >   dax_pmem_compat fb_sys_fops ipmi_devintf device_dax i2c_i801 pcspkr
> >   intel_uncore hpilo nd_pmem cec dax_pmem_core dca i2c_smbus acpi_tad
> >   lpc_ich ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sd_mod
> >   t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel tg3
> >   ghash_clmulni_intel serio_raw hpsa hpwdt scsi_transport_sas wmi
> >   dm_mirror dm_region_hash dm_log dm_mod
> >   [ 1011.200864] CR2: 0000000005b0f669
> >   [ 1011.215700] ---[ end trace ed2105faff8384f3 ]---
> >   [ 1011.241727] RIP: 0010:inode_do_switch_wbs+0xaf/0x470
> >   [ 1011.264306] Code: 00 30 0f 85 c1 03 00 00 0f 1f 44 00 00 31 d2 48
> >   c7 c6 ff ff ff ff 48 8d 7c 24 08 e8 eb 49 1a 00 48 85 c0 74 4a bb ff
> >   ff ff ff <48> 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 48 8b 00 a8 08
> >   0f 85
> >   [ 1011.348821] RSP: 0018:ffff9c66691abdc8 EFLAGS: 00010002
> >   [ 1011.372734] RAX: 0000000005b0f661 RBX: 00000000ffffffff RCX: ffff89e6a21382b0
> >   [ 1011.405826] RDX: 0000000000000001 RSI: ffff89e350230248 RDI: ffffffffffffffff
> >   [ 1011.437852] RBP: ffff89e681d19400 R08: 0000000000000000 R09: 0000000000000228
> >   [ 1011.469926] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffff89e6a2138130
> >   [ 1011.502179] R13: ffff89e316af7400 R14: ffff89e316af6e78 R15: ffff89e6a21382b0
> >   [ 1011.534233] FS:  0000000000000000(0000) GS:ffff89ee5fb40000(0000)
> >   knlGS:0000000000000000
> >   [ 1011.571247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [ 1011.597063] CR2: 0000000005b0f669 CR3: 0000000cb2410004 CR4: 00000000001706e0
> >   [ 1011.629160] Kernel panic - not syncing: Fatal exception
> >   [ 1011.653802] Kernel Offset: 0x15200000 from 0xffffffff81000000
> >   (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >   [ 1011.713723] ---[ end Kernel panic - not syncing: Fatal exception ]---
> > 
> > The crash happens on an attempt to iterate over attached pagecache
> > pages and check the dirty flag: a dax inode's xarray contains pfn's
> > instead of generic struct page pointers.
> > 
> > Fix the problem by bailing out (with the false return value) of
> > inode_prepare_sbs_switch() if a dax inode is passed.
> > 
> > Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > Tested-by: Murphy Zhou <jencce.kernel@gmail.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> 
> Seems to fix the problem here too, so:
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Thank you!
