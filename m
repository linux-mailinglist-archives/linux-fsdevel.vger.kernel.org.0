Return-Path: <linux-fsdevel+bounces-4789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E587A803D32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C621F211D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14B2FC20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pb4GGLKu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HGHzN+KJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D748C1;
	Mon,  4 Dec 2023 09:12:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4H2hp8027301;
	Mon, 4 Dec 2023 17:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=AoHYJuHv3HFWgkPysOw7JVbpf3A98guKwrVwnBhdwKY=;
 b=Pb4GGLKuNRP/iAXpG35gX1DfAJIXbMDtoL6XrA8q+yLCaJ40Og5Ft+WaMzVpJ3/fwmao
 AaPUjDeA6e0l2slIU/BzzaLI4LqZ2Ih/XUTdPjufYOg7JHGhk8UIEQ4brE04zcwp+zdz
 gncQe5yI+QCMjXteOfrKWIhonRu2JrLQ8EsCdXMFAzsMzbkyBZPEnrQA0Fiy/ATH9DlO
 V1WJ6BH7dphpjRzgfgng2C2AAq52EyOgpM3sKXuteZlwa3jyu7onRsVaSj6PKjm6NXVv
 pg+jO72Cn6FVXAfUEDHNJGtxyJXzQlQA94vVwMD8Mo1Acp9x9DTEZQkQCGMsFjZUAaTD Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usjt9r0vp-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 17:12:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4GrT0j005300;
	Mon, 4 Dec 2023 16:58:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15uwue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 16:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UML5Fg8fqCY4XS89Udb8uS8TbLL6i9H0NcGFEStZeLXJzbMbr9i+IWB0H7bO+kgbBx5ADhjtI02pQeJx7uXoetHO/KvuS+Uc9O+kn9nX5Qn61xUGWyl5eTWSoxzlF88qf0uqXPTO2SI5n1xUlUW77phLhDa0z7r+bYAdmyVhs8oNDeBl1GY6gdSSFnaIPsX5isbWC9LDF260d4s6H4zFB4kPJwmaHDBytD2tbhliAu+P5RCQRnm6eZ7hNZRbtW9V/Cw1yW1OBrQHffm9SG6vGueqLMGQAYjvLf0rVX0IK928TJbvk9gN/FNiu/hSx4R21q0QwEfoxzXPsN96t7UO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoHYJuHv3HFWgkPysOw7JVbpf3A98guKwrVwnBhdwKY=;
 b=eIYMudVWFue4KgWHjtDz2jZ0OrDswhswZTmuVr97Skzho1j15a0VeMBuCggAV8rxeNuge4hQ+O5sOsFCuh1Hyyf2AFhamiunK953y8piW068HIN4me7N6bRpsrp8EKbxSUm4bx00XEpNhyEgnQlhNSeLFCMNTes1ad43HcVaR9xJuEDZ0uLBvxTP76uoPELWIcQUNPFoIq1nJCRn76xcxysd5UBYYLv7MEYzOOqy5MO27ygiGlmakXDZf5FZxNGBzZ1Qtw4g1T80WDoVw5PWOtqGC8/9HTgvVao7Ui/mFPzggT7pw+4HBsVxEzo2qjyUztMpcUQXqcVjcId5axGf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoHYJuHv3HFWgkPysOw7JVbpf3A98guKwrVwnBhdwKY=;
 b=HGHzN+KJ8LDdNRQjJcjpwAOX9me9bbGSzjWxkAcKz1Cci8U8yTW/7vKkCvaxLGXL9/ou83pa3R1ykfkZtJa7IDcUthcoqgQQnLajVolGyHgAcdyj0RJq8jGNzR9L4LYsWKSrBDv/3z2tuhtgbneIuKydccCCAzbqNMvUK2wD0Lg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:58:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 16:58:28 +0000
Date: Mon, 4 Dec 2023 11:58:25 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: Don't leave work of closing files to a work
 queue.
Message-ID: <ZW4FMaXIbJpz9q1P@tissot.1015granger.net>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-3-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-3-neilb@suse.de>
X-ClientProxiedBy: CH2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:610:57::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c3f1c0-c6d4-49b5-9ba0-08dbf4ea3c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	75CC0/bShipfDrEBdY7qk4bqblQ7berOlpvh7ttSxF5IA7gXbUjdShv2Ro6x7rgmRzmqi8NTXZlMHwB3FIjqkZ7oDCyZkMYZICGufNUg+drk5FxsAkKtdIfvGYXgQJoc6iaJuoDwAEeRXXXv+m/EvymveQQpU1WmsANsWv12hgU6I5iiBsM1gveFBUNF/wCVrbX+PESevXeKJyvX+76Twkhiu3R32pU9lNLMo9ySEzVeHxc1RYMu3byEqtvm10ZeZeR+QtoNwzXXmnSpknLtjPJ0O9wCEEVK8k5RJH8gjJi4KuJiTHx62BhvKYlIx/8m1z+zoevKXR+pZfKa7nCTfj7F87LCj9sjiKyxOl/6xXfgViuoEH7LtvFJRjjRCGgTjUwCTuMWchgpZdmROkWvwUuSJqKTqjzc8zW8PBeB072WP5rSqtIVdpRxpnes3ZZeIaWUgd3eC/9HoI+ZhLYe7Ja/XHm84x8BWyUuRwbcZLRkDZOx60GRWTP4UYif1cFa2l51ibV1mlgAsRjmsqDuk8rOVpeJPxgO/7hhTNo6yRffqEd4rDb3xRFIiB509nQ6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(66899024)(7416002)(6506007)(30864003)(9686003)(6512007)(26005)(41300700001)(38100700002)(86362001)(83380400001)(6666004)(2906002)(478600001)(44832011)(316002)(66946007)(54906003)(6916009)(66476007)(66556008)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eeEKo1yHajbTEm8KrwVMuShcFGzzVWhsN+CICldlG0uay0swykTtfSg/ta+E?=
 =?us-ascii?Q?dAytDB1MX1v5TVYx3ukj/Lyo2NmPi/bdpOrUiBa5LZmCXvN53ohuCx22fBvx?=
 =?us-ascii?Q?UMgUgxQpBGwdhsogprew//IR5wLC27a64shQHknnIt4Sg02djDWTgLHSqhj+?=
 =?us-ascii?Q?4wlHu623Euww9qz14HIsjA0Oy+MfpLwjUr7nQQoXHMItyM9g2aUxekx+ggFT?=
 =?us-ascii?Q?BP0VC0zEA+OaZP9SEWJOnZVH1eDrKR6wZZmZPuO21VC9A0GcOEXAkv0FuCnf?=
 =?us-ascii?Q?48HSlZxK0kV2Oa93YBTm5QXxZvyru8tWqMhRKY3OvtySioco0rKTWvBDztm5?=
 =?us-ascii?Q?Cf27wLhntVAow1UfNMAgQJcOAj80juqlWnIGCcTuW1d1iEePSnJxOzJr+ZaK?=
 =?us-ascii?Q?kX6G79WXxGfgZ9WLg1++H9dAPACkdCLqhNy6QE2mKxh87x07tpZfNRMPwi0q?=
 =?us-ascii?Q?O6y2EN4KnR+zd+wr3UIaBMQJuHJWepvAPMEdDnyGirYmSoO5PFclmE0L8rpm?=
 =?us-ascii?Q?uzBzKJO02lubMlhYKK6bJ0hPm2tzLKC3JBgWO6WVFdlVK2yX+ESPRcYSUfxU?=
 =?us-ascii?Q?OGOzqnNl3NMrXTFufa6EBeRzLnQszyYSV8hBsbIbGPmrOdOW3T5ak8NLIhJL?=
 =?us-ascii?Q?aXkSC8aKqbidxXeXY/eavasYeQvbPYBa+sZNO7tOPbZ+Fv7n9Z1NCaRslg1t?=
 =?us-ascii?Q?HkBeoBNUikb80nE9s9Td+T3iIZvpYlrXggD/1RvTTfNY0AIcK2xFQomS70yZ?=
 =?us-ascii?Q?VNAx6rYvOAto0UbvZnBg+LO062/0pV9X3q/9fkCg2AXyZIArY3eX0eBuL1Nl?=
 =?us-ascii?Q?XA2JL3mf15PIQ5ll/BTJJl+1sxR2XsTBFww5s6XcoPO9xazyWXrOBLohM98S?=
 =?us-ascii?Q?dvVL2v8eFjy6l2r4z0kFDK3HvdSo9fkY0NnVFgkZ4TlYgaiowBwBYEdBNwh4?=
 =?us-ascii?Q?Q3wOiTprRzw+16sVg+qW6N9tbGT5tZ+7xyRSbdeGkJT4q3TJj1sr03h4h8MZ?=
 =?us-ascii?Q?LUzJOJaHTihAOk67oE8CyuVVTukkeWJFSCscxZbEcGAadyAxcGs/WXpHxbCT?=
 =?us-ascii?Q?wq+CKKT366i1xHV5H8qV2+CHZuBNxFNMbW43q7eWGPX6Kx7XMo90aiTVV+un?=
 =?us-ascii?Q?gL4fq7QofDvt4nt92JgT2Cs1/LITzXsYDXwavwDT1UuXLeVMQDRh1VMALYkK?=
 =?us-ascii?Q?44wc21f+uVd4G3mXuzQZ/Htu4brL5nm4zEQXg3lpiKH4YVY5eKc4YMd3XdjW?=
 =?us-ascii?Q?ytt8ZgVB0pOuWr4g6P50w2FhFDps28ZqscBY3V2q+49g9A+zlZAQZgbK1yGY?=
 =?us-ascii?Q?D4ss39D840cZk7Yas+IW6Lk7bk8uyTxIA3n90INVeeT1g9parOM/xuzh4MZj?=
 =?us-ascii?Q?5lwoGBnn+IJN28r6kAHY1pF3rw0O2v0LUmNbRejAGjjW0E1tOjzZeiyam3N2?=
 =?us-ascii?Q?+meZHpprY8rSv1zP5fPVbLineWifRIW+Bk/UctBOU0Nqobwm9KOF9fpcpouO?=
 =?us-ascii?Q?Z+dQAmMZZ8qRYEQDMyiLBVZgOp5018jh7aO808tkq/CC5LocN76cF4IRuGLd?=
 =?us-ascii?Q?FoK6bfpZ9XBq/Eh2mbg7Vowet3ElhMq5szsa0X4H2sQTi3wsqpFzhXKWiv3V?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?cIDudV7Cq8CXntvnjYFg7je5CPyrAK0uheYtd42X6NuG/s26I5IdQGCo79Lx?=
 =?us-ascii?Q?CeIur7zxU2yyQnIYsDtsa8RcH6p5ZSNyzz6K2tzPTtQ6lj79G8z4V+ASJ1AA?=
 =?us-ascii?Q?GQBckiGbC5fhfxlq++o8OKw7xZuLe/7U1LJ05WT6RDBispmUlGRBhV4fvmp5?=
 =?us-ascii?Q?nda0b61S2Lu4sCdRsNj8FHwMtbXsBT56XW8ATlcP/RYhSIEHO80eOb3IO2qE?=
 =?us-ascii?Q?tqmsfFW3T2MLTxi4bLi6Jbh5nWziF68MHh/5pcs4+nz5VRzt+PyH2OBKtDaM?=
 =?us-ascii?Q?7IT1+RPXwzntnuUp42sKl788ysQFGthmjRqFCp9lq3ST5pGsADrNA9c82Paa?=
 =?us-ascii?Q?RNgayA5Fy3k9AxvByVMpBth/oAzYSTIvexiwSdjzlWCqa3h3JmzQUzmGaj8N?=
 =?us-ascii?Q?l4CQQ09gCSRt0z3HMKyITTJLNlRkX46gWmBXyHxFIxa441sGgFp++cVR6BL5?=
 =?us-ascii?Q?/RMZW8DWLSb0Qi4/xPUe1rRxP3YxqzW4SJTdf0bgarRnpzSV6B7eXwhZszzR?=
 =?us-ascii?Q?glwZi2+3/nEaMQU0l2o7wKtLO5VcmfRdhJfiWPl4xoCt2zS3sZdD+mhF8Fkh?=
 =?us-ascii?Q?+AbZOMLiZukwESq8vnsz4GSceL+BlTpq6CfXwqk2RbKg7fvD8txAhjv875Bi?=
 =?us-ascii?Q?SyLlmAWrzmaOVkckbxiajIOi6FhIVFsH5mRHVuuNX2ReHSiAR3w8P0S4DdM5?=
 =?us-ascii?Q?eNSRkKoNrY44F9uci1y4V+QeYFXpKrYmN1zVTkJ7/xofFKRHeVvvR97x1bzM?=
 =?us-ascii?Q?CRsQqfNM0sGjXhZJ3nH5/BxzuAUcdtTUm2t3VZlBiezPXkqUnQ9EgdDH4xlC?=
 =?us-ascii?Q?DYrlzb9ys0iQDtYTZcI6Z/qik74ZtQKjb4028NpI7yipGAsOP06gy7zD90Wr?=
 =?us-ascii?Q?wWxe94rW/UQ6OPNBboEXTVdMH1ls8g0yR9ybUHuaAb8LplMI3uZLa/K4PKws?=
 =?us-ascii?Q?u+4xo0JxEtI7sC6KAs4bYVyx8gH8zmkw8nNaFBRQWBU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c3f1c0-c6d4-49b5-9ba0-08dbf4ea3c9c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:58:28.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BilEkox/M2rzQrRWQadHxPf6xFJuvGqsTxUUhH71Qczsb56Iy8EpM1qtJp/tZm+BwoFCMU8gQmRsK1Wa6UI5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_16,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040130
X-Proofpoint-GUID: qJrIisbvPQ5NEVynmPtiIEnxW6awplyb
X-Proofpoint-ORIG-GUID: qJrIisbvPQ5NEVynmPtiIEnxW6awplyb

On Mon, Dec 04, 2023 at 12:36:42PM +1100, NeilBrown wrote:
> The work of closing a file can have non-trivial cost.  Doing it in a
> separate work queue thread means that cost isn't imposed on the nfsd
> threads and an imbalance can be created.
> 
> I have evidence from a customer site when nfsd is being asked to modify
> many millions of files which causes sufficient memory pressure that some
> cache (in XFS I think) gets cleaned earlier than would be ideal.  When
> __dput (from the workqueue) calls __dentry_kill, xfs_fs_destroy_inode()
> needs to synchronously read back previously cached info from storage.
> This slows down the single thread that is making all the final __dput()
> calls for all the nfsd threads with the net result that files are added
> to the delayed_fput_list faster than they are removed, and the system
> eventually runs out of memory.
> 
> To avoid this work imbalance that exhausts memory, this patch moves all
> work for closing files into the nfsd threads.  This means that when the
> work imposes a cost, that cost appears where it would be expected - in
> the work of the nfsd thread.

Thanks for pursuing this next step in the evolution of the NFSD
file cache.

Your problem statement should mention whether you have observed the
issue with an NFSv3 or an NFSv4 workload or if you see this issue
with both, since those two use cases are handled very differently
within the file cache implementation.


> There are two changes to achieve this.
> 
> 1/ PF_RUNS_TASK_WORK is set and task_work_run() is called, so that the
>    final __dput() for any file closed by a given nfsd thread is handled
>    by that thread.  This ensures that the number of files that are
>    queued for a final close is limited by the number of threads and
>    cannot grow without bound.
> 
> 2/ Files opened for NFSv3 are never explicitly closed by the client and are
>   kept open by the server in the "filecache", which responds to memory
>   pressure, is garbage collected even when there is no pressure, and
>   sometimes closes files when there is particular need such as for
>   rename.

There is a good reason for close-on-rename: IIRC we want to avoid
triggering a silly-rename on NFS re-exports.

Also, I think we do want to close cached garbage-collected files
quickly, even without memory pressure. Files left open in this way
can conflict with subsequent NFSv4 OPENs that might hand out a
delegation as long as no other clients are using them. Files held
open by the file cache will interfere with that.


>   These files currently have filp_close() called in a dedicated
>   work queue, so their __dput() can have no effect on nfsd threads.
> 
>   This patch discards the work queue and instead has each nfsd thread
>   call flip_close() on as many as 8 files from the filecache each time
>   it acts on a client request (or finds there are no pending client
>   requests).  If there are more to be closed, more threads are woken.
>   This spreads the work of __dput() over multiple threads and imposes
>   any cost on those threads.
> 
>   The number 8 is somewhat arbitrary.  It needs to be greater than 1 to
>   ensure that files are closed more quickly than they can be added to
>   the cache.  It needs to be small enough to limit the per-request
>   delays that will be imposed on clients when all threads are busy
>   closing files.

IMO we want to explicitly separate the mechanisms of handling
garbage-collected files and non-garbage-collected files.

In the non-garbage-collected (NFSv4) case, the kthread can wait
for everything it has opened to be closed. task_work seems
appropriate for that IIUC.

The problem with handling a limited number of garbage-collected
items is that once the RPC workload stops, any remaining open
files will remain open because garbage collection has effectively
stopped. We really need those files closed out within a couple of
seconds.

We used to have watermarks in the nfsd_file_put() path to kick
garbage-collection if there were too many open files. Instead,
waiting for the GC thread to make progress before recycling the
kthread might be beneficial.

And, as we discussed in a previous thread, replacing the per-
namespace worker with a parallel mechanism would help GC proceed
more quickly to reduce the flush/close backlog for NFSv3.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 62 ++++++++++++++++++---------------------------
>  fs/nfsd/filecache.h |  1 +
>  fs/nfsd/nfssvc.c    |  6 +++++
>  3 files changed, 32 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ee9c923192e0..55268b7362d4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -39,6 +39,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/seq_file.h>
>  #include <linux/rhashtable.h>
> +#include <linux/task_work.h>
>  
>  #include "vfs.h"
>  #include "nfsd.h"
> @@ -61,13 +62,10 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
>  
>  struct nfsd_fcache_disposal {
> -	struct work_struct work;
>  	spinlock_t lock;
>  	struct list_head freeme;
>  };
>  
> -static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
> -
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
>  static struct list_lru			nfsd_file_lru;
> @@ -421,10 +419,31 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
>  		spin_lock(&l->lock);
>  		list_move_tail(&nf->nf_lru, &l->freeme);
>  		spin_unlock(&l->lock);
> -		queue_work(nfsd_filecache_wq, &l->work);
> +		svc_wake_up(nn->nfsd_serv);
>  	}
>  }
>  
> +/**
> + * nfsd_file_dispose_some

This needs a short description and:

 * @nn: namespace to check

Or something more enlightening than that.

Also, the function name exposes mechanism; I think I'd prefer a name
that is more abstract, such as nfsd_file_net_release() ?


> + *
> + */
> +void nfsd_file_dispose_some(struct nfsd_net *nn)
> +{
> +	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> +	LIST_HEAD(dispose);
> +	int i;
> +
> +	if (list_empty(&l->freeme))
> +		return;
> +	spin_lock(&l->lock);
> +	for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
> +		list_move(l->freeme.next, &dispose);
> +	spin_unlock(&l->lock);
> +	if (!list_empty(&l->freeme))
> +		svc_wake_up(nn->nfsd_serv);
> +	nfsd_file_dispose_list(&dispose);
> +}
> +
>  /**
>   * nfsd_file_lru_cb - Examine an entry on the LRU list
>   * @item: LRU entry to examine
> @@ -635,28 +654,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
>  		list_del_init(&nf->nf_lru);
>  		nfsd_file_free(nf);
>  	}
> -	flush_delayed_fput();
> -}
> -
> -/**
> - * nfsd_file_delayed_close - close unused nfsd_files
> - * @work: dummy
> - *
> - * Scrape the freeme list for this nfsd_net, and then dispose of them
> - * all.
> - */
> -static void
> -nfsd_file_delayed_close(struct work_struct *work)
> -{
> -	LIST_HEAD(head);
> -	struct nfsd_fcache_disposal *l = container_of(work,
> -			struct nfsd_fcache_disposal, work);
> -
> -	spin_lock(&l->lock);
> -	list_splice_init(&l->freeme, &head);
> -	spin_unlock(&l->lock);
> -
> -	nfsd_file_dispose_list(&head);
> +	/* Flush any delayed fput */
> +	task_work_run();
>  }
>  
>  static int
> @@ -721,10 +720,6 @@ nfsd_file_cache_init(void)
>  		return ret;
>  
>  	ret = -ENOMEM;
> -	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
> -	if (!nfsd_filecache_wq)
> -		goto out;
> -
>  	nfsd_file_slab = kmem_cache_create("nfsd_file",
>  				sizeof(struct nfsd_file), 0, 0, NULL);
>  	if (!nfsd_file_slab) {
> @@ -739,7 +734,6 @@ nfsd_file_cache_init(void)
>  		goto out_err;
>  	}
>  
> -
>  	ret = list_lru_init(&nfsd_file_lru);
>  	if (ret) {
>  		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
> @@ -782,8 +776,6 @@ nfsd_file_cache_init(void)
>  	nfsd_file_slab = NULL;
>  	kmem_cache_destroy(nfsd_file_mark_slab);
>  	nfsd_file_mark_slab = NULL;
> -	destroy_workqueue(nfsd_filecache_wq);
> -	nfsd_filecache_wq = NULL;
>  	rhltable_destroy(&nfsd_file_rhltable);
>  	goto out;
>  }
> @@ -829,7 +821,6 @@ nfsd_alloc_fcache_disposal(void)
>  	l = kmalloc(sizeof(*l), GFP_KERNEL);
>  	if (!l)
>  		return NULL;
> -	INIT_WORK(&l->work, nfsd_file_delayed_close);
>  	spin_lock_init(&l->lock);
>  	INIT_LIST_HEAD(&l->freeme);
>  	return l;
> @@ -838,7 +829,6 @@ nfsd_alloc_fcache_disposal(void)
>  static void
>  nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>  {
> -	cancel_work_sync(&l->work);
>  	nfsd_file_dispose_list(&l->freeme);
>  	kfree(l);
>  }
> @@ -907,8 +897,6 @@ nfsd_file_cache_shutdown(void)
>  	fsnotify_wait_marks_destroyed();
>  	kmem_cache_destroy(nfsd_file_mark_slab);
>  	nfsd_file_mark_slab = NULL;
> -	destroy_workqueue(nfsd_filecache_wq);
> -	nfsd_filecache_wq = NULL;
>  	rhltable_destroy(&nfsd_file_rhltable);
>  
>  	for_each_possible_cpu(i) {
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index e54165a3224f..bc8c3363bbdf 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -56,6 +56,7 @@ void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
> +void nfsd_file_dispose_some(struct nfsd_net *nn);
>  bool nfsd_file_is_cached(struct inode *inode);
>  __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **nfp);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..02ea16636b54 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -13,6 +13,7 @@
>  #include <linux/fs_struct.h>
>  #include <linux/swap.h>
>  #include <linux/siphash.h>
> +#include <linux/task_work.h>
>  
>  #include <linux/sunrpc/stats.h>
>  #include <linux/sunrpc/svcsock.h>
> @@ -949,6 +950,7 @@ nfsd(void *vrqstp)
>  	}
>  
>  	current->fs->umask = 0;
> +	current->flags |= PF_RUNS_TASK_WORK;
>  
>  	atomic_inc(&nfsdstats.th_cnt);
>  
> @@ -963,6 +965,10 @@ nfsd(void *vrqstp)
>  
>  		svc_recv(rqstp);
>  		validate_process_creds();
> +
> +		nfsd_file_dispose_some(nn);
> +		if (task_work_pending(current))
> +			task_work_run();

I'd prefer that these task_work details reside inside
nfsd_file_dispose_some(), or whatever we want to call to call it ...


>  	}
>  
>  	atomic_dec(&nfsdstats.th_cnt);
> -- 
> 2.43.0
> 

-- 
Chuck Lever

