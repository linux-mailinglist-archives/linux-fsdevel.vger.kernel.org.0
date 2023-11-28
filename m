Return-Path: <linux-fsdevel+bounces-4047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088467FBE2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167CA1C20ECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142045E0C8;
	Tue, 28 Nov 2023 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AczbBnei";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g2hiMZS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4792;
	Tue, 28 Nov 2023 07:34:52 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASEhiUN029047;
	Tue, 28 Nov 2023 15:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=nJc9ddEShv2Wb9KIn4BcyvVT6dR9ZdmEEzwQejzSDUQ=;
 b=AczbBneiFfVSGUD3mWtaeyyJtdt27GJMCnckMUM2zCvCJAIj1wVlZZH1VFjVlBmmL5Ui
 MDJ76O/Ec5xBdXhCHRDnM9NxYdOQtBO1wfXOQgPOJ0Hv6gkje2Aol9E4AVoQouXMXO2L
 XQdemLBQAoZ345Y3zgbHVVlNGwCFvioBUtd4mR/Ue1KqhBcJEzRktEHt2fCdwvtpF+gW
 ZnVppa+Q3pqGyfe05xDHpYAp/6m2ooLvVlHNq8OMivWWSYSOVt+gTnEtPYJ35kdXJ5FU
 LTVGYTbownTDxRNZIakoqw2ILuMPHfe6u1+eof7FRpNazjH38bvhX2jcKpuMbXOnNlgL tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd66qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 15:34:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASEEtU6009603;
	Tue, 28 Nov 2023 15:34:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c6tbps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 15:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEy6Qvzp+DQqZngJjUqtMhGPOBrB7NlKn7dXmViNlzlBYnmXT3dxdMCTmSJDDU16kNC/W9gaEoF03D0Fo/SrN/HJWGdAB5opzKk6EHAjI4oVLw54dOKmD7JE140FwmfxDngl8OuYaI+yMPB0E1Ck15abxnZ1Gz5AC4GYa5wud+KAJx2Ok9Lhm0vy7p/qmgPV1lH+DZf4XEq/80MRvpYn6r5bEoujBJcRmyqYXpP3VTN5wRfkvWsKggpwiKgPqgqVApXUfYbKJt+1oB3vEoV/IaEJWrQs3xjZUtgZNjZkefFs8gKT4HpamaQcPIDv8SsdoqHBYi+JmSI16EKSuptOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJc9ddEShv2Wb9KIn4BcyvVT6dR9ZdmEEzwQejzSDUQ=;
 b=jKrz7tKf06B8ePl+5DhbF6D4DL4iIPIjMyKLHudc9Edl+uoIIxhwBz26fYu7l0QC06lT7WBri/phhO8kKaop80Yx0EnllGWHdkN4c3T1NH+DLDKK9eWObtvTmDqUFSTBdEaeeZo7liwIFuxqvAhHhTAOSD3pNZsdGharE12YRsM0HbeMl6JZyM6TBHj6ONLK7s5IMJFgjm+buXCt9WhZIMuLRFN/rKr4zY74vcbu4vxrIyI2Mk1NMAJ3si8tn7lwCx81LKIvoIVD8XbwbylbyrySHN5ciE1on9JhilOL02gPHKgBS26N3Tdf5Htpkk2y1YGys93NauaFXIJ99+T3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJc9ddEShv2Wb9KIn4BcyvVT6dR9ZdmEEzwQejzSDUQ=;
 b=g2hiMZS569H3Uq0o7NfnX8JG7i+v8RFzaMP3u2Mz8r5fB3keIegtJE781SkKNKDgQU3kc2ir7zz65YnniRM5FzNuovFjmIpbu70TABZSACl+PEyszKrCSmDInwyD5WidVaIxBmy7OEzomDDzk389ekMlihqMARszq1ihO6eCDPU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:34:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 15:34:43 +0000
Date: Tue, 28 Nov 2023 10:34:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <ZWYIj7K0KPQFCCdf@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
 <ZWVEcasahyVQ4QqV@tissot.1015granger.net>
 <170114025065.7109.15330780753462853254@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170114025065.7109.15330780753462853254@noble.neil.brown.name>
X-ClientProxiedBy: CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: d604cd8b-6a7b-4b88-d7e8-08dbf0278b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fgAX3s9f9/R/Snd45ckYy02LN5bzWiZcZ3p1Y01/oh1qCDVKvibMeshk3QeFXIRYqLF8SB+7cokZNaki+36kHm60PBFvCjM0kPOwlXVzRHkeWgogM4yqT/zONQhPLuPbkW+bAOlYWrw0jyrAzwD06956Vjh6t1mNWbG6DggRGzYXd88lssJlG7xyo7R/ATdaqE7DAhdsNoVCmboha40R1IPCgDLMa3bqqcZ1zZm8CTbMZtxZy6WjegDUm1MKR+cPqJOTIU+8aCvBMZonewD+IY5hZqPHSqZjIVQxYbpiwLZYxZbWrC9oHM+dE7cgXinYEiebocrPbZZMl1H2ShBYxHfgI1Io1WLTa/2m2o+leMhn+2xTiDkLDlzQy00coH34oOsTkcyIuxr4frfm1CnST9YbdeEJPCaRW9Oql71zkbp3HofK+8bCuLOZ4V6HJ9FFZN/+AGdj83qEIPbza2I59fX7gTKEmILWvAD6yd4FXl9tjNtnyZYj1qc2vMKNXzZ29MfE1W8jRbArqn5Fa4AZWS2MyBqLE7PeuViApsPVYmY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(5660300002)(6666004)(8936002)(8676002)(66476007)(966005)(316002)(66556008)(66946007)(54906003)(6916009)(6486002)(86362001)(44832011)(4326008)(478600001)(41300700001)(2906002)(9686003)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3M3qwhCtEmkEOtHSQYN0OWTH4lapGl8uKqcDLcN92Cy7Zu6leNKEzwnf1LMQ?=
 =?us-ascii?Q?EB2j32l2ZHw4m+ZiiL1q7gHxnJxcRWROiqnLuHX+ZJW5Zamqu5F0nxL78UYY?=
 =?us-ascii?Q?PvKusX9dUcXxnSyv36oRbQmljbvK9c6NqUatOKKT2/qMQ1Lm0eD0/zGnS2OM?=
 =?us-ascii?Q?pr5gMFoHzB0ma+oD/dmZEAEFpMPHfmOjXmNUgj6g1YsYNtggZPkuZXX8B3sn?=
 =?us-ascii?Q?nTbrHU2P68Bg4I0DkGbqSosmnYK/cm+HcSLKpAY8OAsWKEo0hp8WJ6vmQK+g?=
 =?us-ascii?Q?H9TP6+0RgBh6FqlH8vplxv0MWshv6eZxEcr4yh25/TrkgQ0RwJfSr7rjr0ML?=
 =?us-ascii?Q?7FhIPDeE4LmVT1h1G5y6vzvPaS7ccAU4pM+AlkTGUKe6Hcp27Cjw76mAPfhJ?=
 =?us-ascii?Q?BiE58Qool+w+Bzfj7R4oQp+BQB0FRoqI2l8dOwd5uCUGldidc8f6RaRFQgnI?=
 =?us-ascii?Q?AKi9g3ixNA35sUfg78XegU8sTw6Fo3R2sAtsKlOJyvRxxOullj1oE7mmMCRv?=
 =?us-ascii?Q?RWPvGPbFn6puj91vfNAsRLX6EX8qdu45g4hzQ6aacsmOPpYy7I93KnP50so2?=
 =?us-ascii?Q?VptLD7gFlZ/N5bdfKAbe6cn4imcIpZeQ8x7w6FzdYoaGJzvJxJ5uFrZACrkT?=
 =?us-ascii?Q?jMYWj6S+REaB4NNH6h75KgK7jSpptBfPrSqxgorLafK7Rh8TwoXQCWAmBJtQ?=
 =?us-ascii?Q?Ty7sRcIZ78lZvwl6jhL2jZnvt4IiJhJ395BG8jhXL4yrQcp5/C85r3x6tw/Z?=
 =?us-ascii?Q?x7wLQTLTrUYuz4oy7uwRx3ijX1Y8cyX40HMnhLio2eGznYPF6NLRpNs/op+O?=
 =?us-ascii?Q?2tl+Y/7t/AMoFlNjB4wqkfidzIfQOtW2wAXbeuNSr5RzzWc5zNX2JdiZVLIP?=
 =?us-ascii?Q?Pb/t6llKFGpGUz34KcogwZ2nBpwi98itAyweeMwbAvPCwXzzwMEo9KZfY6Ro?=
 =?us-ascii?Q?8OYSHYQMyP9uiHrlkrP7Q9+Zr/aVWJUwoQw/rDrURAXyDKH+a4mCCBgBRco/?=
 =?us-ascii?Q?QPyfoePFh/DuZFLMAltAgjOY2d4Xklt4n25H4rbMQCmDbzeLUc0M001MBJoQ?=
 =?us-ascii?Q?Y6MHJmnfCZ+rkD0ZkXECfcnP37j/o27mq9ChacA9GXKRFVb9d4odjDoOgOIw?=
 =?us-ascii?Q?EcuK9k/oKx4BvBW4SRFCTAhy1qQyWoV+QfPMrRwU8QJayXB3y8adF9aE9DdN?=
 =?us-ascii?Q?W2dKgv8ampH4RMlFUZiHuw8sFyFRXfwl+HMpq/WXxTsdCa04yegpo3LfkxNy?=
 =?us-ascii?Q?5pXlou7FHzlLbGt+zpTJYAbiW3q3/mh71NSzGQjVeeA2BxVcCI2LHdKYB4dJ?=
 =?us-ascii?Q?NRyquDl+KC7Zwkhex0q3nVNeKZRcQq6VugqCbDnCKpShbDq4qU2jrz58Fm1C?=
 =?us-ascii?Q?+TVhtC/YTI7sYyFCyZCT0a0A0zMBm68MHuGjYpkwJhHbokSf5bs9YsqWHh2R?=
 =?us-ascii?Q?yZG6BByVpPWClOA8IbEqwA3gTAQFfVW8CrPDo6auWclDOAW8KYBWJz5AG7Dc?=
 =?us-ascii?Q?mtllnxkjYZ2pcYt7HPzXzmis9sdO6bA4VYi2RclhB0uJJPYjWrCivQRpjYHf?=
 =?us-ascii?Q?ShGRySBoVr5paTLrzjlE0f3P4JHuXy4EODOQmj+F9E8H+mQ/HAdCG7Gcatd4?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VbWE0JHMAoxuUL0O6VyR5nmWrT4W5KLXblqqAYZ8RXgepP+ewbEtc+jTuTWsU8CIr0ibnCvtKzdMM/ubwrnrdwgyLKtB59Rvii65oks6kueKg2XABzj47Q37Lo4/qbmFtLYZteWdylL9hxzl+xfBOTxlYacoUL9ejDjSwVOyqsc/ry0XiCO18ecuzqDPkqlZCtGBO8La9UAUUC2zIp48Fz8ToJ5Vghc6b7qzwoEn1LiJfxoMFoa5igZOVdIHFdBtNx+dxTsUD9DVvjsGhAh+MvnaMofrbHgOmxUEp7y+l5pOPuPE/5tdDmY7ZRfXGvdF5ieDsopam0qZynJqTPUzo3qKMvO/T0MClZtjYgjNjadNb6b4vVKsG5v6yhhWIFitT4JA0O4vp0sQKfWk1vtezFNEl6tKRcHukRXNo+UVBLhSo+WNmr6afFlJlPJQc+OxDLWJ3fCmsBatVl9hvMx16G9fHLlSZAQfTZe04tuMWRVqsKil0SaWodcbWarpX8Dp2SKTgT+hhjFF+UiQs83zxOfyRf1O5OAzOFUuAxCQwAU6PN/3+vKIaeVVxzJTDpDDc9Q73GWOvgFhI0gqH75Z8dmEN/SjUTkYiyAGG3Rey54m4RpT24VPA7K3LeZ4RX03fZ9O0m0LUQ5BadqPlSLeVv86cJRImsm9OWCA1vNTutLDTQm19UY/npknlGlF0zC9mBGIkGb/lKJInhdXbj9mlqAqSjEpbqrj8Qbv7rNDrGTmVg5gpStlcYn1PqCeca7ulBE+kSpeNS7kP8korSvPSleJpnCQJAGwjuNd484T7yDdd+3Bu1NEJr5bOwKt3LHxfNQ3XYSXjgpp2GKSmoAbMwuc3f/2HEx2Ddy37+YNBKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d604cd8b-6a7b-4b88-d7e8-08dbf0278b15
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:34:43.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tfOq6lZe2teTRkYmMRbf91Q0MGzhs/tCneBra0sz+B14l2DJdJeCcuDTgAjOhKRtx0JcEwlFgIjCd+PCGMFmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_17,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=624 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280124
X-Proofpoint-ORIG-GUID: WUhZqWQqZsWX2qESy70LNyxlcHFwVKY0
X-Proofpoint-GUID: WUhZqWQqZsWX2qESy70LNyxlcHFwVKY0

On Tue, Nov 28, 2023 at 01:57:30PM +1100, NeilBrown wrote:
> 
> (trimmed cc...)
> 
> On Tue, 28 Nov 2023, Chuck Lever wrote:
> > On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> > > On Tue, 28 Nov 2023, Chuck Lever wrote:
> > > > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > > > 
> > > > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > > > work-queue thread running delayed_fput().  As you might imagine this
> > > > > does not end well (20 million files in the queue at the time a snapshot
> > > > > was taken for analysis).
> > > > > 
> > > > > While this might point to a problem with the filesystem not handling the
> > > > > final close efficiently, such problems should only hurt throughput, not
> > > > > lead to memory exhaustion.
> > > > 
> > > > I have this patch queued for v6.8:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=c42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > > > 
> > > 
> > > Thanks....
> > > I think that change is good, but I don't think it addresses the problem
> > > mentioned in the description, and it is not directly relevant to the
> > > problem I saw ... though it is complicated.
> > > 
> > > The problem "workqueue ...  hogged cpu..." probably means that
> > > nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> > > That will stop it from hogging the CPU whether it is tied to one CPU or
> > > free to roam.
> > > 
> > > Also that work is calling filp_close() which primarily calls
> > > filp_flush().
> > > It also calls fput() but that does minimal work.  If there is much work
> > > to do then that is offloaded to another work-item.  *That* is the
> > > workitem that I had problems with.
> > > 
> > > The problem I saw was with an older kernel which didn't have the nfsd
> > > file cache and so probably is calling filp_close more often.
> > 
> > Without the file cache, the filp_close() should be handled directly
> > by the nfsd thread handling the RPC, IIRC.
> 
> Yes - but __fput() is handled by a workqueue.
> 
> > 
> > 
> > > So maybe
> > > my patch isn't so important now.  Particularly as nfsd now isn't closing
> > > most files in-task but instead offloads that to another task.  So the
> > > final fput will not be handled by the nfsd task either.
> > > 
> > > But I think there is room for improvement.  Gathering lots of files
> > > together into a list and closing them sequentially is not going to be as
> > > efficient as closing them in parallel.
> > 
> > I believe the file cache passes the filps to the work queue one at
> 
> nfsd_file_close_inode() does.  nfsd_file_gc() and nfsd_file_lru_scan()
> can pass multiple.
> 
> > a time, but I don't think there's anything that forces the work
> > queue to handle each flush/close completely before proceeding to the
> > next.
> 
> Parallelism with workqueues is controlled by the work items (struct
> work_struct).  Two different work items can run in parallel.  But any
> given work item can never run parallel to itself.
> 
> The only work items queued on nfsd_filecache_wq are from
>   nn->fcache_disposal->work.
> There is one of these for each network namespace.  So in any given
> network namespace, all work on nfsd_filecache_wq is fully serialised.

OIC, it's that specific case you are concerned with. The per-
namespace laundrette was added by:

  9542e6a643fc ("nfsd: Containerise filecache laundrette")

It's purpose was to confine the close backlog to each container.

Seems like it would be better if there was a struct work_struct
in each struct nfsd_file. That wouldn't add real backpressure to
nfsd threads, but it would enable file closes to run in parallel.


> > IOW there is some parallelism there already, especially now that
> > nfsd_filecache_wq is UNBOUND.
> 
> No there is not.  And UNBOUND makes no difference to parallelism in this
> case.  It allows the one work item to migrate between CPUs while it is
> running, but it doesn't allow it to run concurrently on two different
> CPUs.

Right. The laundrette can now run in parallel with other work by
moving to a different core, but there still can be only one
laundrette running per namespace.


> (UNBOUND can improve parallelism when multiple different work items are
>  submitted all from the same CPU.  Without UNBOUND all the work would
>  happen on the same CPU, though if the work sleeps, the different work
>  items can be interleaved.  With UNBOUND the different work items can
>  enjoy true parallelism when needed).
> 
> 
> > 
> > 
> > > > > For normal threads, the thread that closes the file also calls the
> > > > > final fput so there is natural rate limiting preventing excessive growth
> > > > > in the list of delayed fputs.  For kernel threads, and particularly for
> > > > > nfsd, delayed in the final fput do not impose any throttling to prevent
> > > > > the thread from closing more files.
> > > > 
> > > > I don't think we want to block nfsd threads waiting for files to
> > > > close. Won't that be a potential denial of service?
> > > 
> > > Not as much as the denial of service caused by memory exhaustion due to
> > > an indefinitely growing list of files waiting to be closed by a single
> > > thread of workqueue.
> > 
> > The cache garbage collector is single-threaded, but nfsd_filecache_wq
> > has a max_active setting of zero.
> 
> This allows parallelism between network namespaces, but not within a
> network namespace.
> 
> > 
> > 
> > > I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
> > > the nfsd thread should completely handle that request including all the
> > > flush and ->release etc.  If that causes any denial of service, then
> > > simple increase the number of nfsd threads.
> > > 
> > > For NFSv3 it is more complex.  On the kernel where I saw a problem the
> > > filp_close happen after each READ or WRITE (though I think the customer
> > > was using NFSv4...).  With the file cache there is no thread that is
> > > obviously responsible for the close.
> > > To get the sort of throttling that I think is need, we could possibly
> > > have each "nfsd_open" check if there are pending closes, and to wait for
> > > some small amount of progress.
> > 
> > Well nfsd_open() in particular appears to be used only for readdir.
> > 
> > But maybe nfsd_file_acquire() could wait briefly, in the garbage-
> > collected case, if the nfsd_net's disposal queue is long.
> > 
> > 
> > > But don't think it is reasonable for the nfsd threads to take none of
> > > the burden of closing files as that can result in imbalance.
> > > 
> > > I'll need to give this more thought.
> > 
> > 
> > -- 
> > Chuck Lever
> > 
> 
> Thanks,
> NeilBrown

-- 
Chuck Lever

