Return-Path: <linux-fsdevel+bounces-3129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D177F0313
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 23:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5F71C2090D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAF1EA87;
	Sat, 18 Nov 2023 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9QKt7eB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W/qp/62C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CECAB5
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 14:12:14 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIIvgIw006958;
	Sat, 18 Nov 2023 22:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kMWIRFPvK7LbFEjaEdzbTZhcovNfVC7xgTmWidyNsSw=;
 b=R9QKt7eBR5xgbktcScGp5QwJ8oK3NAluNisIFD4CYAznOXn7aGYwZyNWymfxFKm0yR3c
 E9x2jQULoLIpqjEvlPyoF42ted/SikFXeWB/pzVwfT5RRWac5TTFYk0zQxwCZOvpylqZ
 B2OeVGA4x6q4zZDyTatu3e/25HTXeypojfeBM+1vPqDNeMHoNK5COuDUp7SgMVL7R5pT
 fqOvxMADfmTkaJgZFCeLO47MVmR71rgGQQqL2nlKq1ndAcOoD0/b1C4jcXe1rDLCLDcM
 fwO+2VOHPpQyoyXwsRWx3hLPRbbCiL8deWoKdLTlwl6/rR8r5SEViU1wqqZzsDPFJr6U uA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem6c8qhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Nov 2023 22:11:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIKsUqB023576;
	Sat, 18 Nov 2023 22:11:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq3sbv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Nov 2023 22:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/Y1MvOFeNYQmZLRJgJfF9phH3B8GRS937CNCOYi2ygZ8VIBUhT6728GNzgYOzUyWSjaix0kgF+vKw9sqTkH4poRwN208KkYXH7bZ5+e8uPJm3WY6tdHvnoy9VYG6flS1L7dp4gm2zl7nlWeo8ANgJ/6C9ySsEJYGKdxtoim7eMt/j3wHLCIVS+ViRV3Nyf8sgMAwvaMsycYdRN+0axMBKJtHAEQAEUJm+5X6ueqJt11H7WZCG107FhDGGY4HMPbrx8fgoTm6eNeH38x4N/Z4+Zlz+JD8X3LTkgPX+HL8GAaS6BWxT2hsMOMFv7ADBYisQ1PoYwWj/q6HcnZS69KBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMWIRFPvK7LbFEjaEdzbTZhcovNfVC7xgTmWidyNsSw=;
 b=AS6i9VRDaiA/loDaAuBGyxx3Vz27zU2M6kFDdA91YIq+o2BXeOYjGnxYPjaq8U+o8KHRFhggj65q8JsvsdMgz9RRoGR4nddrOZflYXUa64blifTKVqx/1W9IjE/1AQca/s8Dzq8mywgwOFP9L2qIvbzNKwU1clNvOxUuPLXwbRUKx1pt5ocFxWp/9GSLA8C+9/+NrLA+jNjZdu0XGKBpz1iJyl2OWhPAQk1gHik2YpsW6SIgFHCiq6hBMfRFU6R42wjeI4WkIkIRfFKdeD+EOL95Jqlm9vzaQloA2aXlXib+Dtw6wEGJBDBVFckMGiZOY7HMuSr0l7AFeb9/moc2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMWIRFPvK7LbFEjaEdzbTZhcovNfVC7xgTmWidyNsSw=;
 b=W/qp/62CNkWMt5GUc6VhF5tXmuUKNq004AjqmunZreQH+xK9meR4IS9EGyx2LP/rn9lwug3K1Kf8u/+l7HL7OzvR754Q1JIMkQH1Wuee6O/pUr8WK177swq3zu2GDi3nv0bMMFZjxToeVUYkZj49Tc/ZpeROfK8+USbhwLVY4Ok=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 22:11:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 22:11:42 +0000
Date: Sat, 18 Nov 2023 17:11:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
        jlayton@redhat.com, viro@zeniv.linux.org.uk,
        Tavian Barnes <tavianator@tavianator.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] libfs: getdents() should return 0 after reaching EOD
Message-ID: <ZVk2m1scRfy4Xq0C@tissot.1015granger.net>
References: <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
X-ClientProxiedBy: CH2PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:610:4d::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 0073815b-ac34-4ba8-4ba9-08dbe8835818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t+hNwE7zlMAkk/Akjyr/Tr3Wikr3qQ4Ln3mO/N6LKBEVIlu9E3rtCRtbkgLHQuXiu2eefGgzvjXoU5pLAf5DqXpGj+ioIDYh5bybSsbRQNcgJqWm0OywOQqLlBegosOjGR7flysh5GE5j1KYAcY4k0lmbcK7d75Z8bRgyjLBkIwILbQdQ9NwXLLCrOAh2G7DFfjSL/OTUrpoD7PUn3ZqYOwc2FxldHUBq8NkvkA1y8CAjhsK14BI3BgXjQrY8W7rpnuLEwwgTDCKTIT6a5bJ2xVd5cmghXJX8wh0z/9dWFehCxgoFhdw2mJp7RRqbIHzbvzQabaq6221i9wKwliJ0cnGhDE/RhPPycwzihToVItzzZje5e46DGmKhmx0XaQ/JBEXW5DwSI3c0FuhGSG0KJzRQo+VvWSFqk04Fvo1no4Ntr2FTOygEpSsgjPpR2zBjrxivHvTWC8WmCKG/DiWljJVLEkF7byPtch5eUmD/kBNvDldGw0lqLOLvUdAXEaD2Z63Vc0t6+9ok/5XedMtLHMv0lpEcj2XcfGGblWH0j0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(9686003)(6512007)(26005)(38100700002)(4326008)(8676002)(8936002)(41300700001)(2906002)(44832011)(5660300002)(478600001)(966005)(6486002)(6506007)(6666004)(6916009)(66476007)(66556008)(66946007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ABcoqHQ/B+nRcf8VMMQm9NjLKfRcszVIGFtkkgyGOAf9eXAxxi2gNXZjFPuL?=
 =?us-ascii?Q?53mkjXQrQgtNHlgNKeP0aGLPpAREX41H3wo3lo3XoaRtdcTtMztcreg0PgPx?=
 =?us-ascii?Q?XYUZ0ia66Qh8UqTneBxSpgoT+aEQp4vlKSpq5jQmkemsqT6s6BHW7zZo2Sho?=
 =?us-ascii?Q?NKGbYCoYh9eZSdteuNOgHsXsE/Q85BTjxAzkiCR3JmXxvUXOHomw590mOsaJ?=
 =?us-ascii?Q?jwaI4aVgTsqtY7Hmr7BfC1vuyN8E42g/vfRvZX39eh6ZQXlJZ2jG9V5HtSTG?=
 =?us-ascii?Q?0TnDjJnHQdUL3+721hRyGbxAHZzXVSx5wcrqFamwj8P9VBizrx16N7w7ezaF?=
 =?us-ascii?Q?rwajPnqqLiFe8IU0tmruIv6y7MZq0REI9xAlXDNaAWj/aQiW+kIMZdcnnGvU?=
 =?us-ascii?Q?coyQY6Dmi0aYiil1qKBJ+KoIOdIrHiynMtcRMmuCOqmpBbozSsud8C203Rj1?=
 =?us-ascii?Q?/xRAQfssLpNTEIXSF0p5n7H7+qGeVA5ElQRfMkyOFtgAtXhxdWwyrXRVBk3V?=
 =?us-ascii?Q?6eMNtM8GgaSRYhwhNdNJhO8otxOU5yJ+Pi0hRAXmB0py1GF5Cyndh4Y0ltmM?=
 =?us-ascii?Q?Ts1mkBP8hn/LusM4uSy69YH/Tq4x3u4q2zFYePu59VKTarq2g982K32AfBJ4?=
 =?us-ascii?Q?ku7K3IdUpEtLX810zKuIuBut9JQXDEc98JuLaHSWt5+ASLdUTsKN51NHpeeW?=
 =?us-ascii?Q?wwzzesNQ0clDbLRzDX76/YqgHxx31nQOlepzzKkxYHh0TTVXuyuoVfLI2Tp7?=
 =?us-ascii?Q?7RuI5GJf2Qtr1xn8wiMOVrRzfC2mHXEVXx5w9SeekjCK8yBzEsY4a3kz0/Fi?=
 =?us-ascii?Q?S+3X3RDe+PZfiX5WpHO5j3ZMbrbSsSstdMcdDz8YaSPwLHfRX0B/NhNzTj7y?=
 =?us-ascii?Q?xPAcX5uBb6597OQ4pplOgpJiYJgshIvrbUAxvyA58yde9nhu+fr5uJXrVcgL?=
 =?us-ascii?Q?2ivIAI2V3YXc2muVueWquLRmuJB9f/zFg6g6xyJk2KAx4WpKfjNcIkOh2U8T?=
 =?us-ascii?Q?bwWvHT5DFZ/uE3zOSM/kLv0HR3R+nNDmWDEh/whvRbER2pf9zW7UVoYBjGK+?=
 =?us-ascii?Q?9sPnRJHg17N+dfNyhoQuXf97yemTBKQcm1wDdAinIeMA1bwUjnfbpw/6mggk?=
 =?us-ascii?Q?xAw7X2D8ge/rcvtgZyP3K8PZxw8kBRkkEngJ1DjbTj3+60HZWAShTGugGRmE?=
 =?us-ascii?Q?c5VZd50wMCi1wLUSCZq+fBCX9kF7y626j+L6nnKqu2P50SGdBz+7/LMgqxKM?=
 =?us-ascii?Q?tEmHw0VS0bUUlEB2kUMrSPkS0BKKEX/dgkG2poHT5Q0qCEFKtnpjSJWEfnbk?=
 =?us-ascii?Q?3YDeKNjn4g/E7NH0ICnlG9dG8bBxA21F0aFdPgdMvGc0H3VFdFUS4l7P+x1d?=
 =?us-ascii?Q?d/+67sjurzZ1B3/xT9A44thWctUCRzKQ9nNlaOuuKnmOMVjJ5QDB3U7FfPT6?=
 =?us-ascii?Q?8MY/qldZTiLagfoe0S0X02v9hQGYEyH6G6RsEGCUMigEKyBkSpoPGnAvjjrq?=
 =?us-ascii?Q?mXOpqz0JaWBcZa0fU5PXHnIkoS8IKLTohPGE1P6XnXNMY0OZNZxQI1+DA60+?=
 =?us-ascii?Q?zelul7GfMHPdpG+CTa/dwtsem3uPTA28y2jNK1YHcM3DjO3lVPgiDfIg9AH9?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?6veT6tHcSNXWZlqvvlOrRban4WyI1qv5531Duok9mztsl7o+bIMbivlPid8w?=
 =?us-ascii?Q?SugLFp0Ts6Rw8kA6fAyBVTU/Gu+TWMru75e4ZWLdvpqDKlivid1VNNsCaz/5?=
 =?us-ascii?Q?jYff0hyMpPQJJflYo7Y6gxEG6s54OPobQZ3E6fHdIE2FPSaJfHNnQteM8kIF?=
 =?us-ascii?Q?rFaaURs7GIsfL3JpimCz1TqOF6d8RUTpdWL0cSR+yPYAThoMIIKbE5X09RqB?=
 =?us-ascii?Q?GA8HGqwWgqDJeqybz6q5SxCbYGETtY+/048daGqJfalnrr/ImkJBA4tGLCZX?=
 =?us-ascii?Q?fAmR0/Yt6jslVTKWsHpCezUAlMDHj3+D3GozQUoEi7PAEZa4MgkfljGppYH9?=
 =?us-ascii?Q?emj6v0QZgiu63H1ZxqmDj85VVmSVcYwMW78aaZl/7fjPSE0axO8VaoSg0fEx?=
 =?us-ascii?Q?ZLfptkzOqUoX99Z6NQyN2lmykZD6TFCHT0B3YIHWuFoy5w51Jkq/m1kpaoGC?=
 =?us-ascii?Q?3WbdwjcgjtweI1HegyDlL6sYA2IABu/REHBVH7Ix5gqokCDl81byT7U5q55u?=
 =?us-ascii?Q?V688JgC56tLPoVavV1KJHH6m19huTqDigz0cZUhCS5ifj3oPW3Kkvau1IlAm?=
 =?us-ascii?Q?MAtZ+67+4fqtLyBNrWMno2VBju9w+WoGtPW/vc0CvoXSPo8dKvStcT30qHVp?=
 =?us-ascii?Q?EVzZcGMt0PfPJZ3Oanem7OZY+3Pi5tyAc1uTq8MGuPrElhrGijBgIljivAsn?=
 =?us-ascii?Q?8hyJN8IaRGtYYHX9gC5aTh8KFL+FWi1N49cYenutFPKOes9W3XfIddGHVR2i?=
 =?us-ascii?Q?+AspllD7L+AfFnZtM5Znl+ldjKw5bEviCYh2Gj7CHZG712U6kQwFInsyuYrD?=
 =?us-ascii?Q?62A+KtvJt7oNFchdU8hFq8SAReFsZgvVOfKymokMHV4PpUOmlXyr/5+dzQW6?=
 =?us-ascii?Q?ByWXPsLjoMjDF5ha5Ccr4uC6hYgLgYqr3oKBnt6DP/fFyJc+KBvdsF5yu8gC?=
 =?us-ascii?Q?nvq7I+5oQwftZ+p3QKQZ78LbTubql6F4rzBTm4fOX0drEFFQ9EW/Ot1BSRsv?=
 =?us-ascii?Q?61eG+/bEdlzqoaQ/Cce608ueGQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0073815b-ac34-4ba8-4ba9-08dbe8835818
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 22:11:42.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMxdddKXtK4na56jh78B55VgFsaAFfFo55So98QfsxVjv9/vZjVJOJZPylNeaO0A3RZHIkH4RxfYtWSK1D11tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_19,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180169
X-Proofpoint-ORIG-GUID: oAFpSftXxJWLpgneE9XAQ6iyqb10PlWy
X-Proofpoint-GUID: oAFpSftXxJWLpgneE9XAQ6iyqb10PlWy

On Sat, Nov 18, 2023 at 02:33:19PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The new directory offset helpers don't conform with the convention
> of getdents() returning no more entries once a directory file
> descriptor has reached the current end-of-directory.
> 
> To address this, copy the logic from dcache_readdir() to mark the
> open directory file descriptor once EOD has been reached. Rewinding
> resets the mark.
> 
> Reported-by: Tavian Barnes <tavianator@tavianator.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20231113180616.2831430-1-tavianator@tavianator.com/
> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/libfs.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> This patch passes Tavian's reproducer. fstests over NFS shows no
> regression. However, generic/676 fails when running directly against
> a tmpfs mount:
> 
>      QA output created by 676
>     -All tests passed
>     +Unexpected EOF while reading dir.
> 
> I will look into that.

offset_dir_llseek() has to reset the file descriptor's EOD marker,
just like dcache_dir_lseek() does (effectively it resets
cursor->d_child).

We don't hold f_pos_lock in offset_dir_llseek(), though.


> Changes since v2:
> - Go back to marking EOD in file->private_data (with a comment)
> 
> Changes since RFC:
> - Keep file->private_data stable while directory descriptor remains open
> 
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9440d55073c..851e29fdd7e7 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -428,7 +428,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
>  
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
>  	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
>  	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> @@ -437,7 +437,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  	while (true) {
>  		dentry = offset_find_next(&xas);
>  		if (!dentry)
> -			break;
> +			return ERR_PTR(-ENOENT);
>  
>  		if (!offset_dir_emit(ctx, dentry)) {
>  			dput(dentry);
> @@ -447,6 +447,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  		dput(dentry);
>  		ctx->pos = xas.xa_index + 1;
>  	}
> +	return NULL;
>  }
>  
>  /**
> @@ -479,7 +480,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	offset_iterate_dir(d_inode(dir), ctx);
> +	/* In this case, ->private_data is protected by f_pos_lock */
> +	if (ctx->pos == 2)
> +		file->private_data = NULL;
> +	else if (file->private_data == ERR_PTR(-ENOENT))
> +		return 0;
> +	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
>  	return 0;
>  }
>  
> 
> 

-- 
Chuck Lever

