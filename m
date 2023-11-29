Return-Path: <linux-fsdevel+bounces-4202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60507FD997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8D2819C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD232C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kWS4BNLH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZR8COKef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD7B5;
	Wed, 29 Nov 2023 06:05:06 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATCiwJh031981;
	Wed, 29 Nov 2023 14:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=4nZzrzbzdm1h5ou9n6hainLvzUC20hggsIqBV6eVhdA=;
 b=kWS4BNLHpz3tX9gcvwPn3OpKyhTjt6OBkKiihlwqDq8/55kj+3o7pCOS/WjhNNJ3XuaG
 ajFvMj5FvOUIWXq/xPdhAqtjltQJnd87f8OM6HlITufXsPfFTJDfVcVerQVEiKCcMTfK
 b8l7OYijTvswUwcB/8eNxIH3ijXTmcdSezQFsqEuedPl0UWjYTeLmZMtIuFiCJEoXrbr
 I/td+uZmjpF5GteSLj5oA7DQTsa2h4UheAdNAy29KKMJiTJuZnezKK0aE6ep1y6eP5lr
 OTcQWfg/c0oF7IciUCBpd+Qsmk2bmtxHutnpqvrQGojaVAMU4evx5BO+iyOHnhQw4jDy mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2rr11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 14:04:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATDA7lD026966;
	Wed, 29 Nov 2023 14:04:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cev11x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 14:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzW5dyDrn6LrL8t41K7nmqYkFyl1Kd6gXrR//NebPdTV3LYQZ6qLezelXD4qvi8qPr4AsIwpA1+ahRlFHwUukbzwqdjvOaQBW3uUltgVBG0Xf+a930Mg0BQeuflTLnCdTGMJMkeddPgZEzWHvD4Mukn9mokvQdZOMR4O2c9C/HLPowO3q/mpPAX/2cN0MxqhdnLXQVPHl2wPGYghWV8vdmrtjmLV2BWh4SgUYz15QtHzTc2meq+1jfuyNiCzef45MiPO8ZnU2j6e6e3yPy1LQQHvTdygzfKKWDdgjn5vkMS3Jvk2cmULp2/VtkYVuQE6EpL88uAjkhRusQAkUVlAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nZzrzbzdm1h5ou9n6hainLvzUC20hggsIqBV6eVhdA=;
 b=k4DKH/BiHEIIuEuFhdfj+uNyaLY+cZasGLUh5QSCdwcBkZF3Cd1n2UD6+WZF/ZxEUiNXdYwujRE1ehQJpHtB+eeq2a8sJwszAw9zLDxTOoho1n3Gp0a0INR+AOLHon86dOZyZrp9pk9qZ1YWdkj0MR5E/tJsGdjKuT3GLVOS45zKMvjZG8+PXXtkYNyRf7CTd5y8jPpvTP+sNZvitbwTkvVslWdtuHBoXHPZO4b7DgW5N9sGOF+LKudDKLQgRLiglJcA/sl4DFTP1SlpEU2o5WoG63mYf0O+ve2RecvVj0T6lX6ms/R9WIXXeKw0nArg/5yRWIsLNbVPZG8mbRMvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nZzrzbzdm1h5ou9n6hainLvzUC20hggsIqBV6eVhdA=;
 b=ZR8COKefZha3E/+WAYoPvW1Tx6L9kHiaDUSysIumHp/c7r1+6He5fgr6PGl1GrFzJb9NCN5cke2MQDFfzWaW8ZUqIj3pCfs0m3o1qB1/Cg7R+nTM650nBGsflzmRdOX5YAiRDV4rSBEibZjJPWM6ADCCeTL9F6CR7ZvPEA3SQww=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 14:04:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 14:04:50 +0000
Date: Wed, 29 Nov 2023 09:04:47 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <ZWdE/7bNvxcsY3ae@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
 <170121362397.7109.17858114692838122621@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170121362397.7109.17858114692838122621@noble.neil.brown.name>
X-ClientProxiedBy: CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a004e39-46f8-402e-0245-08dbf0e42713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jnxI0cXXiPZNT6yBQIG3kVBZJhLc6+FosT4/41A8z1bqU/bySCmr11AfYz4gMjHatFqZnW12QE/h8FfWRTidEfmBp6bE89fuzncvnNYjbExnUAu21Oz56GONdBK9c6vOx6j5y93c7Y7gPhSPnqBKqqbyPHN9dwmqCWiknXNmfFxQkPsGY3qBn8tHYtRL9IGlcn0WdZ3RVpn9yCnKempRvkl+GEFsdFQPuKdcmHutNCIkRwLSaskq+0VX63tzhDmOmouVZoSaqn+M99GPbwMGChRxJEpF6MOqPVR+ODx5gyXkG+/HJRWiy4wWgewoMvIN36o3EhBSduYahNi1pIRY60G7zLKk0bW0rsUrxIm8Iw9JRoK52QCFEUsP5zV2VJZWmgNfuDx7uOwckpFIPiEDSyOme2kGC7tGR/kBNjp8cVSgOirKD36cyq8VToFWXStdxgRRKBdr4hcjePHpmGVC/97972R/kkuRdn4FsUnoKjnXNbOlRMbmjbYi6Se345HgMBekSK6uzh/dOuYJFG/pb0bEzin11sBPJP1Mt08j35U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(6666004)(9686003)(6506007)(5660300002)(4326008)(8936002)(44832011)(6512007)(86362001)(6486002)(6916009)(66946007)(316002)(54906003)(66476007)(66556008)(8676002)(83380400001)(966005)(38100700002)(478600001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IZwjB88xynGRwjtnFjx673sUT+r16iugIpwMD5x68yKUcu8dFFjrTSapWjug?=
 =?us-ascii?Q?K1uBRsMBwOaLNqJ056x76Sakf9/9GppLDckGh620Uaj+6w+Zfzzd0fpe3fYj?=
 =?us-ascii?Q?iGPnWbmWRXtqzZHLnTP6Gv4WR7dYwRpbM25xDkHSkaLRpCQIXjVxRm6DtOCi?=
 =?us-ascii?Q?4WK0Sc+48o3c/xLf5+DzeSwEF+F53Hf4c1Io8fwRdxcpWBrvqxrR3wqpo5EN?=
 =?us-ascii?Q?cNgeZH/A6BtgM+0lCYE4dVSkN0wntqDerXNlLWOzs2HEsFDS152zekqvACpX?=
 =?us-ascii?Q?p5dUt+aielRBZmPBmsFpeNUkRsyPSefpiYwSu87nZtBDL5Rh52a/GDyvhY4s?=
 =?us-ascii?Q?xVivuFAiSqP6TSZMwVgMvj14z/cFCiKCFp54S+XDFGhcjoNAS6+iJajw584N?=
 =?us-ascii?Q?oyz7a0L1IQHirwRaZeygpxjKpHJXZ0N+7p+tGjoCXRTKqLjc9JPiJsoItzvO?=
 =?us-ascii?Q?a8LCMf6tv8STlsCP9H+03KM0YGmsgXHxY63b6Ce++Zs1og3eE0D8kznVvnUI?=
 =?us-ascii?Q?KEjLzpH+lwHSx+drim5U0plu+1kILVEYq0HqjiHwnjY2tuSC7XllU7cLmSmp?=
 =?us-ascii?Q?NrK5roCquwxF2d9d6Xx+ZLpIjjOoffUwxl5y44sDxUz9or5syAZDR5ywRXmH?=
 =?us-ascii?Q?NwkxDOzn9sUbyGvMgL0Xa+rxlEVzbHHAstsLwIBxC2S5lrh/Ho6YOcKdCsLB?=
 =?us-ascii?Q?jOM/4xsfRE68bMAwf0dYaA72Y8mcdI0/BenEs+YDbk9CPQWNG3sdj0Vg9yao?=
 =?us-ascii?Q?HXI0APvbhMD3GVf99V7RDk8/rt9dyQ4DszefmGUG4oaSNKPRv+f0yOlt+ebd?=
 =?us-ascii?Q?MMW/k7ovY+dgPUvZt9eGq01tgDgKOBEBvRUsbEJzknFfRP5W8SK2JBrFRbIo?=
 =?us-ascii?Q?P1yggNw2sxOGO6RIlXoZRVSmsk7iRIoAw4d9sJX+A1a0EQ2ZgFUYQ91Qek5A?=
 =?us-ascii?Q?RqBCem7mAH0fnsbtPXNMrHeX+CYusreVr35MQ26E9TXAs2PO3NQgeE8IVjRj?=
 =?us-ascii?Q?jmLtuU4TlkbBEN+V9n/WsriWUzGLs+sVYaeMM1FIrW8pjtGQoJBacI4OLaK8?=
 =?us-ascii?Q?Msz7Y2mS/xW/kSkZQJCVU19SpvKy2rXuX3e09n9JNikiAevWwapUsSTtjGcz?=
 =?us-ascii?Q?elhbDT/tQEZq16z+S7KXiSp2sZ5jmlSZ49hC9GaBhDHGOa0TmT6ZJz3/yukz?=
 =?us-ascii?Q?2H2kGnRjMlQ+Wg2g6LIaR9d+qteV88UAbfj2o2J8iDiWDPgKCTovW3VVlWsD?=
 =?us-ascii?Q?IWluPnlpNpPJT19knjFH87j+jIfIAZVh3E312cPJIYdQ5b/NEutDpWd0EZXj?=
 =?us-ascii?Q?lFuAm1S/wPqskIied9pjFhKkBeN7AEQQOq171kOHlZp9wQdP7tk+M1lIq/32?=
 =?us-ascii?Q?jE2vJz4TQmkuoDxeLXb0vRBUYVHCX4HYDpjP41wOoLUBAd6U1Hv2jx1FCUcs?=
 =?us-ascii?Q?K/iAd2uUDx08eygoK+bHKF/+o3ItHazS+W47OqKAkp6cgb8kboy8S3iZkVoE?=
 =?us-ascii?Q?H+Trc4ltEWIDmB2DEtFozfQY4rdSYdOwHnEX9BsKy3kYe+KEGAixKo95GMJa?=
 =?us-ascii?Q?NTKIJKodBh0u01wbw7zkMgnjgtGIaL/WQogfnyPPPGFh8T0F3LVjAjbYDvaS?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NnvZxhgPomjoihP8BHYUD/sbl2wdOwLCqwuNCSntX43ktTnxMrp9MZvypd7GZzRC5mUFsZAH6+2jeo9RdCqIQMrsqqDbpJkWtA8iXiduz13tpmb2zaxrWGphKM6K5n5WPQ7gWYiBa9OPMTeE5LkVo1GtsEMGXLt0Ugx6HfMujYQTG2SehuUw0ha4W/Jdd9VhV6F5MYYyHeCyeR9lSRK/1RA6Jk4aA61sk3raQghLBHu6PNYU++0QYYNrvmeXdzqbdzICy/ltlxjcBJVtcajgcW3GCVW3G0uPdgYkjE+co3P8gfz2wUqaeNB4v7ky6hz8xa8ClMiyHyYDVbLqz61H+iDFatSr2gBYtqVb8c2D90ROCFPv6oC+8g1lX7D3ZzvCzy2G1rNIPD3DxwxKNu/tdY/Ro0Qgp+OZvWIRiS0CYWU43qMsJNqkV35AfZKZPkVaal4NpH5kyROG7q/lqhTQY3vXzQiNrggOfEypmilvy/tECj2Eii191Dqynf0+52M3Ssbphp8eLtQ4Nib26SWxd26jCevbDalsdL6EPA1gqsksRqwEYB08NuNzSQd5bP+e4IsNBFLLRksgx8BWhU7NNsJ+uioTq0kLbNwF7BrRLbnUJO9xMRjN2E85EcKIVtFAkJEOD55PRM78Lchg/mIjSgRLOmaKhMeGdJipqC6zFzYMhVlbJ5IwDNqzq54CH3i32WapA+w0hxHJYztsZ8VR9WKqR0Vmbj2D10U9JEOTKn3YhzNJQN3EaKFe1ZM/oA3RkCFqkxvAxNiYYvoYiJ453/V9Q06kh68Sy3um3/aeE+OLPIqHanSj6BFahBHf1T5QPn4HsvLKv5nMKC6dv6P+J92QAYb4Z39xjsBQJpI+OQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a004e39-46f8-402e-0245-08dbf0e42713
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 14:04:50.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soq+mCS5k/ZF/taMRR76d5mq2+DEoovH/uyik/UjbYOixRThAVONJNtLHioM7Rd3bZHXCkzsYmrEHpbf+6r4ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_11,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=907 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290106
X-Proofpoint-GUID: ur_Nf2njMmzub_d6eMIXyC_itP-9m2N2
X-Proofpoint-ORIG-GUID: ur_Nf2njMmzub_d6eMIXyC_itP-9m2N2

On Wed, Nov 29, 2023 at 10:20:23AM +1100, NeilBrown wrote:
> On Wed, 29 Nov 2023, Christian Brauner wrote:
> > [Reusing the trimmed Cc]
> > 
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
> > > file cache and so probably is calling filp_close more often.  So maybe
> > > my patch isn't so important now.  Particularly as nfsd now isn't closing
> > > most files in-task but instead offloads that to another task.  So the
> > > final fput will not be handled by the nfsd task either.
> > > 
> > > But I think there is room for improvement.  Gathering lots of files
> > > together into a list and closing them sequentially is not going to be as
> > > efficient as closing them in parallel.
> > > 
> > > > 
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
> > It seems less likely that you run into memory exhausting than a DOS
> > because nfsd() is busy closing fds. Especially because you default to
> > single nfsd thread afaict.
> 
> An nfsd thread would not end up being busy closing fds any more than it
> can already be busy reading data or busy syncing out changes or busying
> renaming a file.
> Which it is say: of course it can be busy doing this, but doing this sort
> of thing is its whole purpose in life.
> 
> If an nfsd thread only completes the close that it initiated the close
> on (which is what I am currently proposing) then there would be at most
> one, or maybe 2, fds to close after handling each request.

Closing files more aggressively would seem to entirely defeat the
purpose of the file cache, which is to avoid the overhead of opens
and closes on frequently-used files.

And usually Linux prefers to let the workload consume as many free
resources as possible before it applies back pressure or cache
eviction.

IMO the first step should be removing head-of-queue blocking from
the file cache's background closing mechanism. That might be enough
to avoid forming a backlog in most cases.


> > > For NFSv3 it is more complex.  On the kernel where I saw a problem the
> > > filp_close happen after each READ or WRITE (though I think the customer
> > > was using NFSv4...).  With the file cache there is no thread that is
> > > obviously responsible for the close.
> > > To get the sort of throttling that I think is need, we could possibly
> > > have each "nfsd_open" check if there are pending closes, and to wait for
> > > some small amount of progress.
> > > 
> > > But don't think it is reasonable for the nfsd threads to take none of
> > > the burden of closing files as that can result in imbalance.
> > 
> > It feels that this really needs to be tested under a similar workload in
> > question to see whether this is a viable solution.
> 
> Creating that workload might be a challenge.  I know it involved
> accessing 10s of millions of files with a server that was somewhat
> memory constrained.  I don't know anything about the access pattern.
> 
> Certainly I'll try to reproduce something similar by inserting delays in
> suitable places.  This will help exercise the code, but won't really
> replicate the actual workload.

It's likely that the fundamental bottleneck is writeback during
close.


-- 
Chuck Lever

