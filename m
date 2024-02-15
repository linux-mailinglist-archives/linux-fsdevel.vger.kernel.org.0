Return-Path: <linux-fsdevel+bounces-11761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42832856F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE2728113E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB864141988;
	Thu, 15 Feb 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aZQcCl+6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PPzmcxc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202113B7A7;
	Thu, 15 Feb 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032832; cv=fail; b=uVPgKRgGkGM6e4IyIP5iAj0CTPmWpxhD1V0r0iHjB+9g3xXWd/5OBqSSJcWay7+3zf+2aCQuyZ+J16VKqxPlG4mRqGi4u56a4YxciD9GnMUx8TiTyHL7Mh6/SFAD3sJ8IE3YdRtUDdZiBeh79xTSWfOZpVxIPkdMNcvtnOGOeZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032832; c=relaxed/simple;
	bh=HINdgyLxHVKa6659t4ymYD1yQl16866/DnIPK/AI2wI=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=tNxH+A8CrppCbGKn+ZqIe78XCFvtwVBmdupyz9HYnOUF3hYrwkD234c2n2tyy/6LaVxSGe4C6eiOH+BCOBY2XX0zTOSBL9S6+JNy5ApTsWnyESifGozFchspPW5OCzle/9SeqCtH1b/U+3AXWMSsgD0OjPABSiqRUWKH3XcSlcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aZQcCl+6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PPzmcxc6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSLTv019552;
	Thu, 15 Feb 2024 21:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=lfVhtZs+Flcdz13lxdnIQLY3aK67wAhuGYshMMgSNRk=;
 b=aZQcCl+6jH3YvLbzy5vdn8rThCjcAKfPEED56X0gHxjC8N4zHHv4TEtvfquKTrvzpqkm
 1gbyC2a+pjmBgCCULXRNyL87inndKTE60/Y67b/krTFoIGmaIpsBvLDzF75G6JmNaaWS
 Rfb4kKLrXtMrtRTSTkbfFB1aM1zcPqIcbvW5+qWQKvThq3B5Xaf1/LsJaqIJQYa6wdoC
 yzQLeCOA1rRH2ebpF2f4u7nOj7qte9Fwg3P2pRpzm/9QAOlREiKLPhMdNmSMnFNOXFZz
 blIhscZUCqnt9lf9gUJ83V/uTGd8P4rgMhFes1Leey3LPaSajWE/GP5Dj9j44qkCOyFc Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w93013ang-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:33:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLJtpk015015;
	Thu, 15 Feb 2024 21:33:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb5w49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEDf7P6fjhuvwS9B+cqPdJ6vrr9fvWDdxWjW+jqp/QRWhbwAA4SaS2alZ2rT5sCsF4gFOpQFqCwcAFu032L4CLQeuRYmGxnMn8qEQeFfM2xGRVMnStZD+tQmvFGyDfWdNm5IZ5idFve0h3mh/viOkU9lV/vKF97kUu5ORoScNoYy/cS1VYweULUNbxi5vfkBjiO+JjDNjzpPc7iilgmf+aokgo9Llw/hguY42nMM/niqaS02qCb70xrkq2EY9YuayH1jH0WYb4GLxS+P5XbiessBEYOxOtWL/HJCwlgObPQ+L7uX/Qne5bdL/fXFyQSXuYGSCBAErwMbQnCFXHSezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfVhtZs+Flcdz13lxdnIQLY3aK67wAhuGYshMMgSNRk=;
 b=eT2bZXVQoF8DPsl8kvhYPAAyt+6hCCCbvqP1w47ZSwP+oClPrTmmOEfK+hOmLODrolhWMW4LLSsK09f7O34RSqclbGAxSJGWi+tbAUAvGVMRUwnHypQXJy67vBz34J3wwlUMVnDSf/cUKH7k6hJXPBBZwYQoMAxzSqMWZHV0g1+9o0XUg6kgNs7YX7hGMfdoem4GXTJa9u4P/LFv+Yd2V8rR681Mkr9K/z9Pyp1dM8uxy4yLeDDlklIYbqp0ARv77zxE/ssS1vKFoyD4wGWwFksXqrqOUJcMP8Py5EA2SQIrtVnTYT1itFxynScRVbx91ZSqMU9Dhjc9NUSjaU/SFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfVhtZs+Flcdz13lxdnIQLY3aK67wAhuGYshMMgSNRk=;
 b=PPzmcxc67QJtCVhNi7qqoB/fWHONCqBatYg25eQoA6rAKgIwA2OXm0g7syuNkj7ZcWs+/rl3FhKXgQZbgmXn60z1ju92W1+yng95z/MqGeT8VEEkmOgKKj7ZatYVEEA9jK3oGlkBu4qZosP4QHjs6AB66OC0hp6k6UmAFgNu0bA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7245.namprd10.prod.outlook.com (2603:10b6:8:fd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.39; Thu, 15 Feb 2024 21:33:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 21:33:21 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph
 Hellwig <hch@lst.de>,
        Daejun Park <daejun7.park@samsung.com>,
        Kanchan
 Joshi <joshi.k@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6i9e7v7.fsf@ca-mkp.ca.oracle.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<20240130214911.1863909-12-bvanassche@acm.org>
Date: Thu, 15 Feb 2024 16:33:20 -0500
In-Reply-To: <20240130214911.1863909-12-bvanassche@acm.org> (Bart Van Assche's
	message of "Tue, 30 Jan 2024 13:48:37 -0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:208:fc::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdb660e-d19a-4fed-0e68-08dc2e6dbb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JJBCW0W5O5D+e6aKkKqU0ZarbD2nwbLMv7bl8VYXc/hif5JrZT1hr9K6SSlsi8rTmuRUfI1mFwONvw6JZYA2ibhkHrldUwxdafOiCRye2r0VRhL41VVd1MmgymT6+7RuyNfH6FjEadsDkGWUa3UT2+Uf8JYjAMEwLjOyfFQ0+BsH5/ZX/UL5zRhZt9UmpLTw6PQhtC2uRssCmcJVuJN5DlYL1mXrUJT+EGdjeBuhj4GDXhq6lsGRm4/5SrAGTu7NvDx5TRkI6oCYxLsEPvvfB4sC5EkrneR4VzNPR6BtxB7y8eVBu7TtsdheYovhWSxs7Kb1cIUR3PBIEpozTwkp2x6lQpp5Hz+t+ggs++vXFjTn55IW13b50pwIPfBLTnKATpCLVPF1CD0lGfpRuTl0j85SRIOuj14rFH203AIhEeHZKzIZvOpMXdzeFL0WLERST9KVefYj74j9lEzDQAvgKU0GbQl8Ii5XZcjnv/51YNsuNUchih1MxS4PtpSfjYNJpOQ3RoyQPDGoXQ3K+zzeDYesZf+SmjGqBKEs5tsSSk74tS87eginMJ0sS5ma5QVT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8676002)(478600001)(66556008)(66946007)(66476007)(5660300002)(7416002)(36916002)(6916009)(8936002)(83380400001)(54906003)(6486002)(6506007)(86362001)(38100700002)(26005)(41300700001)(316002)(6512007)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M2lT+Li1YiCMAtUnTT7hPl8s1aj4EZKDRWL7kPt+pejsfRB9oCm8fn/DhamY?=
 =?us-ascii?Q?dZPG72I87SxZUafeHDYdQ2FRAqDbCch5jsBN7SDm1A9auiypTaazidWr5K7D?=
 =?us-ascii?Q?RCBH0XpEZ2vkSbiFI6/g0zTtK0xsBsxJF2LNBFCkLk+T3vFSrJdVB0EQEyp9?=
 =?us-ascii?Q?X6fZKjo1t+mZMvfkAUqXxygPl8NnZmzyr5oAAeOg11Djql743mmEhaCp7SDy?=
 =?us-ascii?Q?bu+BuOCVsXXmgGtrQl9/YDEiF9zdIg496Udc7Rc//dvjfOwxeGuWdsuzdDQ4?=
 =?us-ascii?Q?2MFXH/rJZFIuodMZ1kzVgw5HjCSxvXUtGR4fbwdOQIv4rGnBzxwCjNZvt800?=
 =?us-ascii?Q?RWOfgxGFB4HtTgmfPQa0sIjy52xQRklOkL/QiVD+z+Q+0bTAzn8ewsn5mDW2?=
 =?us-ascii?Q?Tcw+HbA227wvmGoBh7UBVlqymcUEeGa38WddsJ9xClnyFlerLrCw7pwlOYZN?=
 =?us-ascii?Q?+nCiSlhR3XjrMiHfjiZ65MqbQrgfXU6/6Y2QsRfsoLsFBMXOtNHwCdf7MyPY?=
 =?us-ascii?Q?ltu4/OsI4XZvop0Aqbp6nwUAPi+BFgZs6qNvQ3eqic/RBNhG1cARmhqpT4lK?=
 =?us-ascii?Q?H+9pk0JbcsjAKb+Yn1D16iPQRi69xYr9ikiDJjfGjWAE5EKrBOxm/VsyXWsB?=
 =?us-ascii?Q?Vc7EAiuKw/XBH7ZVfZEAqoeKVFKwBxceMrFsz0a7L3Nk61DGtE2LXtxDP9c+?=
 =?us-ascii?Q?qo78UpVx962NrcQAg+Xv0qGyAYZ1+3hYy+VjY5/rxslZgHhYBsExOuvhN38J?=
 =?us-ascii?Q?Rlp0KmNPAC3cgot6+ApGWsm3cyC1BhuA+vSQLAlLyrPfdZL/5A8LUGdbZX88?=
 =?us-ascii?Q?grXHFlt6cKJ+cMiko1ce8KWbxz7qKkAJg/YMC5p0+u1v729R7wlKTYZjC5QM?=
 =?us-ascii?Q?Gz95H/+6DmQ3jhRDqD6PP3zhZnMoVn6HriRRlVp5R6AXsmijyGzF6Jlv1aCm?=
 =?us-ascii?Q?HhhjUQi5KneUbLgcvVjN7TO7XoH6JJavRS+zoFbXUlXkRYF1b+DsxqlyJnn2?=
 =?us-ascii?Q?qjO24b0wOHc27w0axV8v6TU6Fcbr+j/oG+spWs9qrP1ORQ2gBUAp5vyMW0lP?=
 =?us-ascii?Q?lgIwYoJHVXxpw3sFJ2x2X38jVELwO1vMiqJl+veR0Fe34Qyk3zTB/LjxOcng?=
 =?us-ascii?Q?0rxRD91SGu17C31o6Dsa4BYgsVXBjQ/FxaWeAiIVa+igxBf8/9wGT4PXdyJ+?=
 =?us-ascii?Q?/nUtvLw+Xys+kWagoVx7bndAYeoO+OXzVuu9LJpFCvnA2xF+6I5kW/9vYQYH?=
 =?us-ascii?Q?WbTpkOx1WWhzGvbVDnI1UtD1L7nzoH1gjnHCcvzRVGhVB/gESfYBOthHwuGK?=
 =?us-ascii?Q?MRK6Mhka8lj6aPcmzJSasTMZYAEx8BgEw3kfJuBnG+GYLAIxOHB3waZUDnc/?=
 =?us-ascii?Q?KCJhvB9nUphzAdJl3EokXqzAZ8idKg8SlWLc/LW+Cf7VI5Zw9cHIXHku0njX?=
 =?us-ascii?Q?rVtKTnK90cSUp/cJsqPpyD/MbpVgvnOv0aWeI2mfpvkwGFBLtNgZv1/NT8Jt?=
 =?us-ascii?Q?vUuO3sMYf0kGzSXnehCNfgdHfSr2v3JDc63qI6wu5jcNGj0Vc0bLZVvWqJgF?=
 =?us-ascii?Q?lLVAQbavj9r/v1ZPQ1zeMrqlWrFfm76VGkZlDNdyVOMVnJ+91EtCA0QsaX0T?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2H0t/ek9P/a6P2q67TvMfI446FI6GKOCoKNJMO2uME6WFjq1S3hYChEqaFxqu7naqmXBgKDZUVaq1MfmOt/DpAx12WIp1gvVu0+op/m5P2/rB45hOeLbVfTjQX0OxWvPSwwSRkC6bZ3npBFxPTiZEAfawNayK5qQifHxBUFbyAxv/cwLH8PCrOBFlaXJMuU9gNRNRNspxcuwYbwx5U+8Jsz3Foe5W+McdPbl1rBT6hr9De7ylS4od4FcJv5awiKlcXUqQJqDwsZgP7JgMrRuhrtxxzEBZsxvGCXOe5Unqz+Qc5bssopwQbMkZ2fyS0sMPnXz9ueaNzgg6Tf7Yde8Vu6s6AASrSTfPbi19sUZ7fqgWYGqHNJBptgNEvdheo+tpYU66cdBK1SDjgLkSwMLIYOD32zWhEfK9uhX67D2mhfvwDprls+GVSfP5U4l4BxxAVYozokknY3vB6rTGJtvKQlHPSQ6Nr6ilRpUuxj3xDOM4I79ROx7o7w75HWY7ZEhvhFGdwwCbJ6mhjZwssxOfNi61EsCS9mTpY0Gl6EK4YQ0DibWOescrC23ZIlJ1hOcg+jtQvidaZWGIgeIEm1tqGVk4tAvxTSTGGaAbyFrlMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdb660e-d19a-4fed-0e68-08dc2e6dbb96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:33:21.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baqjXFcrZlac10LrAMEQH+kKYUbTS7FlEVLJ3GfSrV83GuWzMXkzp3x/zIhLiv6zR41dP6WcmTKCiK4eejxRytXyrhtHBeoJ2MUe/ZT5kig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_20,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150170
X-Proofpoint-GUID: dRzp0njdsP8RuqtuzlcvJ12NfwRQr1V1
X-Proofpoint-ORIG-GUID: dRzp0njdsP8RuqtuzlcvJ12NfwRQr1V1


Hi Bart!

> @@ -1256,7 +1283,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>  					 protect | fua, dld);
>  	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
> -		   sdp->use_10_for_rw || protect) {
> +		   sdp->use_10_for_rw || protect || rq->write_hint) {

Wouldn't it be appropriate to check sdkp->permanent_stream_count here?
rq->write_hint being set doesn't help if the device uses 6-byte
commands.

-- 
Martin K. Petersen	Oracle Linux Engineering

