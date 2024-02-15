Return-Path: <linux-fsdevel+bounces-11708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE48564BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418D5286497
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B43131E21;
	Thu, 15 Feb 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C61MpsSz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GVRTPxs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB58131746;
	Thu, 15 Feb 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004772; cv=fail; b=W7QAW3g8MNqNhJpcLYgYXeeS6PN62Otuboi4j/iRSx4CDxT9nuU9x4q0jNdXtmZu8yxxnemm06IgE1kNeCFMjZshs/PeTTy8/v90/BPhGg9+GwvQhbZx7QMpUqV1F5vPhi/Oa7YmKAZ8G4OMJnAjRTyC4MSUQXbcYWuYTei/5wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004772; c=relaxed/simple;
	bh=lEE+8yUzJTeDgSbkJan8kedk5LvUBRSxdbtobvbBP3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ha2kSq4rnKLWj2KIn15aMXW+VGfmB5F2PaEbp/T0AidqBVRTBwkkWA3anY+HH3gwr1jVvBWoLB7PYKYs0c3kz5shXG/tvYyJTPrfgneMg+t4x3Op+HOfn2qPt3ktFAayxU4AN+TyWE121wxtpSYpqJYqGsGidPGv2Pu1OJGRMCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C61MpsSz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GVRTPxs/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FDIM0N031505;
	Thu, 15 Feb 2024 13:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=5x3cakAt53GmBJAaI/WQ2McRDfkB+9VqPm1IodOY7QE=;
 b=C61MpsSzIvM+n+3+QJUumij227bk8U4nrFdqHON21suoBRw5D8Pgs4blNfmppSOp9rAL
 4uFHLbQe3TYOij6fkkxk9JUGRE4YY527DLe41hhl6R/7xDMXo2BE5pSnC0YgQKy7g2yP
 MvLwXV6R07DWE/OK2/HpglRN9TOcraqPJgL75rubr2yqIxo//NUdMh5iIp9UEUAYbkhq
 OOuZJJqoNv5TlzbFcDBmJaerYxP1NezNzUuCvkAefKPLcml3FIlKcFS+aMxDBIBO/GqI
 3IW/69zx1vJd3/HXaMzU9T+YLJUihi56w8zUlqgjbY9DimPgJ4oxeAuwnr7gU5rNHi1e RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppj5tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:45:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FBwQqO013876;
	Thu, 15 Feb 2024 13:45:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apdcv0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNZIfFAqF2tS1HRr2plv6qDsmd+1TP0gAv26ysg7/9Di9s/hdeEyhOmi5JM+yJTC8D5/mC6s9h1WywmodKf7zYwVH4tsNk0FUurtoxTrlgT6txXKU/5Qnct+QJPsyjTaxwdHde5GcCK4iwl4YObIyVuT9Qq3lPSf5YpKb3y2DfLXQf9s5Kc6H7tPyzflySVZ+mHioF0K8pdJRFVM1L3yDPAj+XS/IbDgvueCCegykq0/rIcO86uuWiESGrzreTzLmb42s/AQOePzPQP8mK/XGYsNiYKffduB0lbirR1IOZcH6uCvv1LNitjLJJVqUGDdFZJmPRISb0t/MQNRKSwh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x3cakAt53GmBJAaI/WQ2McRDfkB+9VqPm1IodOY7QE=;
 b=YbYm7NGJxiV1KxHrR0D71dedtLRl0PDFgWsoBYCD0+ZB61u6TySEdLHF5+uqeRhIrLmRHb5yidAvdYdMJVNSdadqKJsM/9itNJQh5nA0Z1p/fLrvnPm2eeZJB1e0WmE2FJXDDOBp27vtGV34T7UkVz5goQNQ5rtZUmUozgsWjLFdgW2abvUzYTRquaMYjoqeCGyxlTMn3cfQ+u6Rc8TBZqeECVUuA9nJyeMY1frEu2T790TQunFIe9DsGVwD4CzTtlJJdUz0ZzOkj2SvYK9prufe3RauzVibnVFS9SiY9TbJUB+5Ohw/5q2ypqfPPHLD4eIef19mo/SB1CXvZVLaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x3cakAt53GmBJAaI/WQ2McRDfkB+9VqPm1IodOY7QE=;
 b=GVRTPxs/kvV2PyCaHC4F0OEbuG0+2MSyza5C9iDnb1Js4of/+fvIQ5isOXLxM94QEQFNLj0qbWu9INPXfpz0ovtzTn17keEFwTIkfyXznra3eh1H/vP3ut5ZJlV8W6GJEfx27dXh5TDOLiaBFbHICasXp8OQIsjUtxKT3Oh6ytU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 13:45:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 13:45:36 +0000
Date: Thu, 15 Feb 2024 08:45:33 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        oliver.sang@intel.com, feng.tang@intel.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
 <20240215130601.vmafdab57mqbaxrf@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215130601.vmafdab57mqbaxrf@quack3>
X-ClientProxiedBy: CH0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:76::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f3cd21-d20c-4c15-ed59-08dc2e2c6352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pwyJjmlJhw/DSIukprIOduhD+siKIZDzFVjLSz4tJz4hZCSMSTMvrh7uNPvuhC4bIt3anrDjqsXkZ8Z6mTXEEkcZ9POn0v2WwU4Du7OMJQHUSLVYzOxSWkIVIPDl+oMhV/cHyTYQ/FGYeVqRfRRtH9w4Zxrvnzuw4Bqkp6PSAMVZN55LjOMS7W1bZeew9u6nA3gUOaSC/LIO7Ei6QGNFchlZNCZQKZY1IA/OpOGcXsN9v5rkLEsGCn5xslqg1ZXh5jd5kAv5FvzVKEcnWh4HUTxcPJV0QdClG92/ZsuspWV7uhc8HvEYI43kxF886IBftIWZMXwbADAbMvFUHI0B0yqDk9MlAUdkgq891I1AiXmcmpkUVjSSeRGU8bH4DEggNuM41qZHNuE+H77EukilHizXKfOj6pMwg9N467XDautFxqQQBzDXfm/i72K4oizQMKdMlqNfd5u2p5QCUAxrKW4Gqw0XJzLKii0r4q7mJMEcJp/w8VvVC0RvoKC998MDTocYj2AzBrCkjOidRr4UcGvv1cZRKUZ8K5S/9mIhXEA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(316002)(6666004)(6506007)(478600001)(966005)(9686003)(6512007)(6486002)(5660300002)(7416002)(44832011)(26005)(41300700001)(8936002)(2906002)(8676002)(6916009)(4326008)(66556008)(66946007)(66476007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tQ814FoLzxSgejTEzjN4zb4tBCM52oW6gNnSsLsHpuw/BIiyK754YYuyAocP?=
 =?us-ascii?Q?dKHx11IYg64B3g7IEdu23e3JGLh1U2MRdQYPDjK7pzVz+hrhfFNA8gzOURXB?=
 =?us-ascii?Q?cORSaKKcbSVaooD7gIKtuiLnTmVrd2cBewQFWQrQ271rqinJnYQUfYKZt7cf?=
 =?us-ascii?Q?uQjkVbv5NU/YBMOeKxhlgSrI/1hesfLcs76LX8fd+NV22n/E3M+hfiphufMV?=
 =?us-ascii?Q?kN3t7pZl9yhXFUtIsT2zW9ChrSPanC+Gu+keI4E/Ge2tGxa9PdHEmTRr+9Nl?=
 =?us-ascii?Q?5MO8fxvjmXuRCge7kNZtwxc+K2BEjPZ9RxlFjtbwwEO1/Zxw2cNGW7kh5bTm?=
 =?us-ascii?Q?Quhg70vvkuUebM6zS4JVFUu/MrgSfLDWupbzBTxKwXGna0Ko/IEjVqlZ8sMM?=
 =?us-ascii?Q?NDo+Fba7/jjYoQIjiP/9ZcHx9fktetKH77HX5EmVn56fptito0iG3m/obMTH?=
 =?us-ascii?Q?uw3yIV+mu+ynqYnB3DHcR8OINrsGajHmkv54iTiq/KFWuBMhTLIY5vx+UwRu?=
 =?us-ascii?Q?jNsNRrDIrOrX+hkq1E72WLeYZM7D9GycEtFzDZa0E2j7W+z7as6MmqnCy4cL?=
 =?us-ascii?Q?l45zKgCti0mQyxUEqmUVrbo9hq07iaU94KeGZUXOLVsrRT+knaJeCxAsBUpn?=
 =?us-ascii?Q?zjhDOCe3lk3EFP9NxgH6zxLRyQTOxPqs0lQ6YB4V9I61KBvGkCupQxE+7oLW?=
 =?us-ascii?Q?elRJ1dSFw7VnHzpVFgpsMCAcNVgu85omte7qE7DfgN9fJiuKn97hxiRV9kwR?=
 =?us-ascii?Q?svlORNehUTuFmYMCNyWeTvOIJVA33BqGsnked6R6PYdcxhHWsiKaO/iGQuwX?=
 =?us-ascii?Q?vL10m3D43rqVGj+R/lt+GVBCXhD+6wrC7krif0Y9TkHApRxgoN227Ac2HeIb?=
 =?us-ascii?Q?ZnHUZu5dRDzHYFCaxIYctjZqk1eBSPUtEjXVuAjQIxBVsaDb4qbQ49A9x+8s?=
 =?us-ascii?Q?kOqJLobRsZzK6kzmOSMs9WffUXEbx3Yb8t2c/rInpgiVQou0+L83rWc5bMSt?=
 =?us-ascii?Q?FjzXBv2lZ/LHKRTBxAgOdquo51tn/wM9LGqe/U+RjN7xbEW5wjcHVj2F92Mc?=
 =?us-ascii?Q?AtO/bLjk3vkn9NYiiGVUG+UimqYEFX7LToGur+C/R6qI8uF/1X/VkbXWhB9W?=
 =?us-ascii?Q?xucfd5kIz+odS7loOS/0TvmJi+TMR9Y7kT1mgtAR7naB7kftu7DFZUmffp6O?=
 =?us-ascii?Q?c+XFqKZgkmXV9OU5lUhS0DHOk7UXkjUte+UD+Ifc5Kt4Kvb3owdXoRW9yUbq?=
 =?us-ascii?Q?xr3PxHFy9ZeUOeZAlXhIw7UiDkZg3uvNppb5buu2G8AFL3eQFAiAL1G5gDxO?=
 =?us-ascii?Q?sHYAvKFWMM8D9EB5uO4dh1It0dYupl+ymjVsMvza58PCQ++TdYl5l+jHat/C?=
 =?us-ascii?Q?vhSBx94QDFRo+6hGzj3xU+E3Lr06PEVJynF64t79i5NLMzGzYT291KZ7vRwd?=
 =?us-ascii?Q?X4R2dJRaegp/J3k/RwQXNhNJSRHgOrwclQxm3dJxOkF/uGcv++cjDx8WNjVn?=
 =?us-ascii?Q?O0RP91ZqWhime04MHTjABnRncd1U2q6SU36v3s1pyfAGC+0cxJmtl7n4kK6x?=
 =?us-ascii?Q?sNZWGJ6Uyw1Hk9ghEQ+ldWyMXaB5j2xH8CBMwAqqeouhORCCe6u2wzjDPBba?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lr/9Rkc4+GhvJ6GxkyZfTBzy4gRcVhAUhbtb5yLDEpCREETTonTescH9rQnOylj5dbLQ0ewLrrMtKh+Hogu9fY6wkUrthrBM+SSuTVvjcw32jGaddrmB704OyS9r62o6WVMSU2Io5S8nTRf+OttdE71CKhQyPzxigx1arMMuNx9Fn3zOXXuj/6eVApUdOWyAxB36TaAnoeJHXQr9kFp+0OY8VmMy7tJZGhnZ79L1sN0ZndgVCRWBsEfTYSk1y3AmbfRQge0sePC42LAbmmHtSiE4vrLsyh5DVbXSEgpt5lJik9G91BAl4Jp8W5TsdXJ1FQ/GyIdmAvd2iG9XYg26eAGA71v7hJhc+k8MR9tTnp9ud+r09EWnfz1+3t8S8vEK6LNbzmR9FjTGRIZECU3znzovONxKGCY5/PFf51Ov7LR0b/4GTbTxza6ffD4ksr1OqqdfBSC/K2nhelCJXmMX39sdBR5doWF8FVEHLCmIhV3hqRz6nIOiF9otyWWmywLrS8SNRq3+Q40pWnd1JA6LcfinwS9Phu1IJ+ww+AVlU62iaUd1FOJ95y84X70qEy+DlRpsMlVLS2Z59+wnJXyCZ+vuiCuKZevniVubOZTk+3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f3cd21-d20c-4c15-ed59-08dc2e2c6352
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:45:36.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGan2fAT5BhhrpsNOGENv+O5sy0UPrmh2qwMXVg/n1qxG4krX7qdl/Qj+rKT99G/FwsKQ/kqaukt1NPZb5oqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150110
X-Proofpoint-ORIG-GUID: Bm9Vk1I9WdXTyXqWsCnf_FOrM1PlTkiL
X-Proofpoint-GUID: Bm9Vk1I9WdXTyXqWsCnf_FOrM1PlTkiL

On Thu, Feb 15, 2024 at 02:06:01PM +0100, Jan Kara wrote:
> On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Test robot reports:
> > > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > >
> > > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > Feng Tang further clarifies that:
> > > ... the new simple_offset_add()
> > > called by shmem_mknod() brings extra cost related with slab,
> > > specifically the 'radix_tree_node', which cause the regression.
> > 
> > Willy's analysis is that, over time, the test workload causes
> > xa_alloc_cyclic() to fragment the underlying SLAB cache.
> > 
> > This patch replaces the offset_ctx's xarray with a Maple Tree in the
> > hope that Maple Tree's dense node mode will handle this scenario
> > more scalably.
> > 
> > In addition, we can widen the directory offset to an unsigned long
> > everywhere.
> > 
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> OK, but this will need the performance numbers.

Yes, I totally concur. The point of this posting was to get some
early review and start the ball rolling.

Actually we expect roughly the same performance numbers now. "Dense
node" support in Maple Tree is supposed to be the real win, but
I'm not sure it's ready yet.


> Otherwise we have no idea
> whether this is worth it or not. Maybe you can ask Oliver Sang? Usually
> 0-day guys are quite helpful.

Oliver and Feng were copied on this series.


> > @@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
> >  	if (!inode || !S_ISDIR(inode->i_mode))
> >  		return ret;
> >  
> > -	index = 2;
> > +	index = DIR_OFFSET_MIN;
> 
> This bit should go into the simple_offset_empty() patch...
> 
> > @@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> >  
> >  	/* In this case, ->private_data is protected by f_pos_lock */
> >  	file->private_data = NULL;
> > -	return vfs_setpos(file, offset, U32_MAX);
> > +	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
> 					^^^
> Why this? It is ULONG_MAX << PAGE_SHIFT on 32-bit so that doesn't seem
> quite right? Why not use ULONG_MAX here directly?

I initially changed U32_MAX to ULONG_MAX, but for some reason, the
length checking in vfs_setpos() fails. There is probably a sign
extension thing happening here that I don't understand.


> Otherwise the patch looks good to me.

As always, thank you for your review.


-- 
Chuck Lever

