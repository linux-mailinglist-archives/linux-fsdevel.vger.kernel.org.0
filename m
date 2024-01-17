Return-Path: <linux-fsdevel+bounces-8136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE482FFDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB71F2634A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 05:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50C749C;
	Wed, 17 Jan 2024 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Oihdwk+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516D7465;
	Wed, 17 Jan 2024 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469680; cv=fail; b=mqOWY4i62XH5Cans5+yyR+pajWu1JTUQudrM1nEfQc9I8Qz3nLsTEmaANAFZFlWm9TCykFt+Dxeb9brhBxA/AGhRh0sc+8MYU/xgNT8Of+wR074ulisi7xOhot7OI5DYM1OgRiz3GYBlc/oFQ3ghSC2+DeM8jzwTnY5njJ51tjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469680; c=relaxed/simple;
	bh=MaeesMtai8VBPFZmKWETZ7JOiyqx5lnqIHHu1i40Odw=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XoPnxCXB2nO66dEvYc2hHmXmpv/n30QERXtpqAl8CelVFry+Cd6jRaZavQtLEIoMaY+C+JvixSJ+UL54nIvZApRtBm7D2XBqMQ5aTQyS+hiIR5k5cTG2G5/l1PMoglruBpTdeNxhpKDH6NW8sAdS75SWId8Exi3hM6ttKEhQUS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=Oihdwk+5; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lenTI7w6mzwljz5rjAp+Pm5Yu09oDFRiBzfhRk1IT1HoAuZinmqyYtMlKIGFV1EhTA8dyeDzZ4Xglz3s21FCQy+z8ySEmO/G2N/s9qBhRckF3S1s+y9wsLbsx1+/ki9rK9+WxdhXG5S7c6f8NTfUWUIKXL2s0SNqoFSmr5Ekt2OkripqhbgK1LQfcaFRnpRMO8OaPl5VpLClu27YWeeLHsBZpbQ00nmWef3nwEO4ocLD+91BHespj++ZjzsKq7efZkkeowLzENueufqYcGfq3RAF2/Hdp/3ybegf7xdBg3cm5xAtBBRvSUDYjpB1oWO+s9l1TgEGBj5hfd8eL8W+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ofhxTBhKh/2c3ubigEju8FflxDMZT8Wkc71mwgQUMY=;
 b=GQlf9R/rw7xnWAvjA3YFBlY/Yzc6vsmltVD0HD/tC0GrrvGQGaY6kyP35PJOkAPJRruR6rXkZWjOuEjw+YoUby57/P53QyVo7tOhqF3wr7JbbR/e6CNkMSwtQP0SQVzTjG8G3kuICeLaYP0bQS/phzj0z8VQtehxePS08TyaaJRpIMN+cNg2+y752QqxvtHlsv0GOCZq5ATEgRcAgQLW8sW46ttn6cL5v5a2TEKQa9pgiH03EzdxIovBoRbX5/yE3rzAmn/i9s8/XcfKX/ufZMP+z9dvBOACV6Zdgfxr6rYFEzdVDwPN2dO/KGFAs3zyy514AAQOLS1Rg+axQz61ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ofhxTBhKh/2c3ubigEju8FflxDMZT8Wkc71mwgQUMY=;
 b=Oihdwk+5GczWLhSrTAf62NUb3eWmv+cwrGtwzcyDHQru4KgcKNgVj4Z8jY4UGRUygUlzCo9LMj2JEWTiHKw27l1grHw/wBUnwlorOVHJXkD21aUaDBLS2FCKDLfyuagztxGbCxdENhyBjU2As3J+WRBanBXygbfMnoXiJabd3wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by LV8PR17MB7136.namprd17.prod.outlook.com (2603:10b6:408:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 05:34:35 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7181.027; Wed, 17 Jan 2024
 05:34:35 +0000
Date: Wed, 17 Jan 2024 00:34:30 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	corbet@lwn.net, akpm@linux-foundation.org, honggyu.kim@sk.com,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, mhocko@kernel.org,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for
 weighted interleaving
Message-ID: <Zadm5r/23tonKeXB@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
 <20240112210834.8035-4-gregory.price@memverge.com>
 <87bk9n172k.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk9n172k.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: PH7PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:510:324::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|LV8PR17MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a242b1b-7932-42d3-d387-08dc171dfd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xA3W3aVtXyY0ubDLojiLBjfriOcmi48tLMUYciaKwykMqzpp5mncdN8Jh72Q+plkBL8zaumV7EAC4Xm3Z5DEk6L/tCnS6zZK8QYOZPVSa2m0582WB2Kd0sdS+zy8onXC+TBdCXKRwfXMCDTxDTgpl/IW/zBMlcNLEREaeFvUu4WUCzOYBc7pfNxjnNmyNgbjLXySBe7Me5Gz3wIqxX1GVNtg3m7eIiIxIF3afQiUiXHMiJLzMyRpsOPP7SWsZKGPYMdrKy6aB2x+TLn2hhLhakyx8uXOEzCIAJJ3dqxk+E+eFjhVICy/YV5NdxqRjHVTaLg8VjAhH8vIslKdfCXFCLbsN0vy7A7VsXPugsUdS8kQnB4Grc6dbo54KUBavH3cffVUJJ59fn8Elf4KAKdSJwLng/48KlyhhbMtuvFnFcDpRmnNdbYU+HiH74YuxSdpZEeA4Z6rLX7/KijCi8v13RQobico5IznqpEJEQ/TQEafvk8AHGQXMZZ9rzPzQzwgfUQerfXsvXgvA/2zLnsEm+JSiZPNZPc1F6mAQybzgoYOMK1oP+GVmfbiwvO+3Fq7hgrOE1g1rDrSocfN5BHijRv+bZmLJ0KZtJVzSdHnE9nbEtjx07NOyFUdga/y55up
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39840400004)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(38100700002)(26005)(36756003)(2616005)(83380400001)(6666004)(6512007)(6506007)(66556008)(6916009)(316002)(6486002)(66476007)(54906003)(66946007)(5660300002)(2906002)(44832011)(8676002)(7416002)(4326008)(41300700001)(478600001)(8936002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpHPWQqch53Mq7C0Tb2p7t4G0BxCv1FIgRxSvVvKSSvyTOwyGStdpcHHSxmu?=
 =?us-ascii?Q?rv3l6QiC5yMEnJM8mcdz220a4sWrhsK1ILtpeIGzFyZeaANXYhyF15xJTHVk?=
 =?us-ascii?Q?/i/wXuMqoiGU172buUl7eFsbMnC+Ka5F3lKW/VGAxJf417xHin1Fcwy3MwfH?=
 =?us-ascii?Q?vJb82hnySk26i2HE1VA06QIDPld3XNFpuIHgjuVQNB8KHdtwyj8QullUAHyD?=
 =?us-ascii?Q?OLMm5OOf9ZjVxElnzUWH2BVID/qlgN2pMPYhh7wxF2L2S+Cl38wvL8+jFFzP?=
 =?us-ascii?Q?6NN4Yg70IjUeiaY7KyMbOq1uOfr9QBtM65LwEx6tQyPxzX5Gi8xOMbgFCvj5?=
 =?us-ascii?Q?uQK9PbKST9KgbZisItiVOhLkDVj3iyCYSXGLAdUZDI3hvNafiSp7XeE9f56r?=
 =?us-ascii?Q?pDYsWHgr9lS51k4UA7mbp1PVM490gndpgD80iClLj/o4LFqTASFhknsnzLCU?=
 =?us-ascii?Q?qDwFSBmAGpCcpvnIHfVxJnr0sPX1nqJk2BCDavSE6myKFEBPL/SyXWVt7CGb?=
 =?us-ascii?Q?O2mja3ot1sZVOZxsjF0p6WZwV/uzO2cU/Bfi+SS1Jk/glp1NDtOS2EAdRr9Y?=
 =?us-ascii?Q?guAZLlSy+jJWxYQvbVHspWhYOcW5nVJhYuX8zhF5HAOuwG0hzOMMQ21/2pie?=
 =?us-ascii?Q?UjZ4ZWBiRVAEIewSyOqy8o+R3JO/gx+4Z8rWa5udBpNCOZVDIkvWf2lTUS+R?=
 =?us-ascii?Q?cUQ5ABYVP20Tt5tS1xNoaPlWHX3FB/GfUchSl17xPsaaTka7AEx9RGX+RobT?=
 =?us-ascii?Q?NDzBtQcbOdE3yq/RVCqMMjxX18LJfSOmDtOEa3iFIxohH1E11UXdYxyszGqJ?=
 =?us-ascii?Q?k9mUSoH/rJXUmXDBPwkPCEZe7cz1SrSkJ2PIBTf8GBsEvvSXZOoisXsWmv9+?=
 =?us-ascii?Q?ymh4u4qT/QmrQ/Bw5KWzUDYgc4rku9tyUSSKkjTCW2UEqnq8j3ip4Wk8u43J?=
 =?us-ascii?Q?KqRRKUeZBpQvPb6vevkYssK6+cy1xxzgBiQeaoaTJ8PcfSHxaZIDf5m2Li5f?=
 =?us-ascii?Q?qQOODXTjm2Lq38rBzLB5R8hZplxbAKjKT4CW4T8EG3oXI/pqjOJ7rxMaCTyS?=
 =?us-ascii?Q?vycqnKh/kQLJK0cdWfAAFnXcSY53exp4OCfD/02zuhyOb8Vkbfhd6IGyqFr7?=
 =?us-ascii?Q?WLIYZhd6/rCrTLGW5zz0hDI6s/1+6dF3sgP+Kinep5wBzZMxs9vSuUDhNML6?=
 =?us-ascii?Q?gc2WgNRJUlhF+c94yTsj/Eb1HONlAcRR14IiIhqRJ8RSE8+BnCSn30OvAvKS?=
 =?us-ascii?Q?x4fJG3psUJmOTAyrYQUxilkUqaRbLjMyrn7EMG30fsdgFdg4sS3jl3oa6ues?=
 =?us-ascii?Q?aZn8ay092DYb3fDRlWFy/GVN4gFn54CbviN1qw+5HNY2S22+l+Jct4+VTrlE?=
 =?us-ascii?Q?GCFEsuZeHtLuZXZs0/c1tjJfHxOYHFE24a7P3remK523FhaNfKddQiMnKt2O?=
 =?us-ascii?Q?M5WHFy2jEWnLeB3i7hDOGr+87+gNHiIFHjvqQDe0rt3++luLDmWiUTFAGmP1?=
 =?us-ascii?Q?Md3oxyXqzQ052kZd5vBp0u2U1ggM5+XOOJwMN9it4wvXHo5hEvq/eyadKknY?=
 =?us-ascii?Q?78O4RfT4fqygHfv2tNo1xvTK23Nd6Hk2OBIh9ThB54rdOCxgCLuPbAyN0nEs?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a242b1b-7932-42d3-d387-08dc171dfd2c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 05:34:35.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWVH8ELzzRkQFjRYJ8JQCv3LmSJbcktQnRvLXDivYHXXO+0DTUb5UD9BTR5JU3eNyX1uKII2+1KYUjt2A9CNlUofQ+P0Pka0AZn1FgLWe2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR17MB7136

On Mon, Jan 15, 2024 at 01:47:31PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +	/* Continue allocating from most recent node and adjust the nr_pages */
> > +	if (pol->wil.cur_weight) {
> > +		node = next_node_in(me->il_prev, nodes);
> > +		node_pages = pol->wil.cur_weight;
> > +		if (node_pages > rem_pages)
> > +			node_pages = rem_pages;
> > +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> > +						  NULL, page_array);
... snip ...
> > +			if (delta > weight) {
> > +				node_pages += weight;
> > +				delta -= weight;
> > +			} else {
> > +				node_pages += delta;
> > +				delta = 0;
> > +			}
> > +		}
> > +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> > +						  NULL, page_array);
> 
> Should we check nr_allocated here?  Allocation may fail anyway.
> 

I thought about this briefly in both situations.

If you look at alloc_pages_bulk_array_interleave(), it does not fail if
__alloc_pages_bulk() fails, instead it continues and attempts to
allocate from the remaining nodes.

Presumably, this is because the caller of the bulk allocator can accept
a partial-failure and will go ahead and allocate the remaining pages on
an extra slow path.

Since alloc_pages_bulk_array_interleave() appears to be capable of
failing in the exact same way, I considered this safe.

> > +	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
> > +		return alloc_pages_bulk_array_weighted_interleave(gfp, pol,
> > +								  nr_pages,
> > +								  page_array);
> > +
> 
> Just nit-pick, may be better to be 
> 
> 		return alloc_pages_bulk_array_weighted_interleave(
>                                 gfp, pol, nr_pages, page_array);
>

Wasn't sure on style when names get this long lol, will make the change
:]



Probably v2 thursday or friday

Regards
~Gregory

