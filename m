Return-Path: <linux-fsdevel+bounces-23220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9236928C44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCCF1C232F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881B171E7D;
	Fri,  5 Jul 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzG5cIi8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r6ZTaFz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C0170851;
	Fri,  5 Jul 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196737; cv=fail; b=IUWGSs/KqXEN7Ekq5pdA6UaPKSeqImzPd453+5NkR88by9qEbNR3sHO/bu3w6cO6wyJm8t+0QA5fyfN3akMyMuKn3cqxIPFNI+mXWNEpbxXSoZD4evkqWsoSw9nXQxlizNbkLM9+ks30uxhEQI/xv9r+QgZsmCYsDqeqxox4vQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196737; c=relaxed/simple;
	bh=f2A7X3UBoQTy4IYWo9s2Gvlu1s1yO0GhxLpEXJze4v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHUzJaRjlUIiamZa9V2OtZWl4U1d9TMT6ID1GZaB97+BZjBFzFI6eQaw2PGyjsDVLMcY094uapN211V2lq096fuBlJ21938ofWoeudz1f9GrfHUdzuRHbbd18e/+PeAA03hMvbwikdoSYJXYjzVJXnyH+YJNu5WcF7fObmxNQCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HzG5cIi8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r6ZTaFz+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVML020400;
	Fri, 5 Jul 2024 16:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=G6t5KwLc7UksbTD1WiyeeJFTGHZtuMIma3y1qQt//3Q=; b=
	HzG5cIi8uSN4kLlBRqYtlkapT+l38mUsBuCn3x2otutsUyZ5GlTfT15GnIea2P0h
	h5HshRPueI02SQE/0kZX7Ce+AqJ89scVdtXNYE4fix74/ujVyiYBBKfe34xDZ7Ir
	g5b+ysVQTQESIwgx16I0tpwcv/75lZ7VIocdGWx/Ad2ZOH2AQHYEUNmhf92kVS13
	XBxSPUIt0akAuTnoidN8w1dBjBMfmTsIP9polxcl9jJJwpOiaSiQRgSOBImUOE78
	lIgVrWpdoz55zxbwtp1ZUcAIuygh2xOqCNua9Ewx5Euth9A2UV9n/eoaQGsypsBU
	E/i9XLL9Aju3rlMrLIfKqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attm8gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465Ef4V1023444;
	Fri, 5 Jul 2024 16:25:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12gg44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS3CgFX/pLAR7gez2uGSINB+jPy6t6TBp1oNrWX1NvDi/LF4ecwQ6FbKMpNEAHP9apxewMkOieYnHlVsdm93f5lc0GI2a+pbo8YFME/Bo4tgpUpwHJFj7WdfmamOPAZ3WpNKUAO+divGsFxragWtto/V6oAivwJ6dlzGiGPdh/PSg57dXlzipmBTM0XPxxy3X7dpAzFAYcrRoDUV2y3hskrk/f/WPbUUJer8OdCAWtKPoGffhr226rOQb3tw2335tDhFCdSJ6MciGZslReKa4yLEu9BHjesFpIyxTXcQoMmLm3Deqojn80boUBZ88i+1CH0axp+HKylui1UlJioKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6t5KwLc7UksbTD1WiyeeJFTGHZtuMIma3y1qQt//3Q=;
 b=YivwMod/uUZjF28ogVMijMdLnN73sMNtHIGpM0pvEhij5mRmIMQfyc9JzIH1TqHRS18zrfyJH+nwALImWLZ//WlAvrJ+xlwG8lmyRCczxu/Lvq6d20DtgWsoJE+UeMf2aH/Od23FN6YlLZhHjATTz3gjyK6F0EPUbmaSiJEVj4tFW7a9ITaK5uDxiKBfwCJu7wcvPiDKTJwYh6d/M7nJyEiz5Zysk+BHe8rh+gkNjKTcXDMWGJfW72ZZScAFe60cwXApwgy/zz3NarCrqdBfBVtAzBf3VBfwh6ad5RRBJ4K/k3vcLPdjFBdj4M8WZSC/xq5gNhCu5oSKjJAWicww7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6t5KwLc7UksbTD1WiyeeJFTGHZtuMIma3y1qQt//3Q=;
 b=r6ZTaFz+0VZYBibyPDKyDp9ogSsWDvIWYTM8M43SGzulqJBi4X4bIxUAvQ3VLctbSyOsAXMe3KLDYmnW8zp/tSkOjk3YFHdZBnFLjflNZPJYhSawrOduJx6kejtwBBP5c2Z4AF0WYsp5z65U5pWdYpW0VhheHjbNwikenIwo1/s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:25:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
Date: Fri,  5 Jul 2024 16:24:47 +0000
Message-Id: <20240705162450.3481169-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 228fdcf7-5f53-4bfc-bb14-08dc9d0f112b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f8mGwR3W3prqLQuHrlErnjKZPZ2HAL7MBjlg0XKceqEkHyef024lZPl1tZ9W?=
 =?us-ascii?Q?+UjulmE/baLbmMJ9yPMrTHCJvNytAhm/z3Xd9CvJLLsm3g8Miq2afSsE1Kdm?=
 =?us-ascii?Q?yP+7BWAuovZ2N3J40OgNDYrNr3MPCfaYhF4Ht6Kl2jiXR3+/0xEXKqhrO1lZ?=
 =?us-ascii?Q?M/v02YShLwFgcwoz0Xhwwrw2SZwSyqR2H4H5QGpmsTbIf4JxkjCDJ2vCb5Sq?=
 =?us-ascii?Q?zTPEwPPHwvVPoSS0FzD8Fve4/YxEP7PeLjmw3mGEIVMfl3pjbaOz/UrkxQQv?=
 =?us-ascii?Q?sB2MpCJ5GfeSSV6rloMFKBuBLbnA1EJ8H/79YgapxBhJ3gtvdrLv8IOm3fkO?=
 =?us-ascii?Q?unZnoehqEhq+YDmJHd/SdMJSTY0ie/YD6tGufTAB139apYDgB/1XpNJb5JLm?=
 =?us-ascii?Q?5eZKqxR6Tb4rBB5BBWFKr2uwirL1Y2lCWswrGlcatZZstMaWRqLiX00mC4R0?=
 =?us-ascii?Q?T4JDaZlGH6bTdhAykFfET3805xtGLb8Dq3yeLQ6YkpJwqNALU2Icp8OelYbi?=
 =?us-ascii?Q?uFMZF9KJUnJeFqRH+jz1noW6ior6Vtbv8PggS8IeXlT4cHIjt13V5870qSyt?=
 =?us-ascii?Q?EpdUf47JtNVAoRn8ra6Or55wL+cKLt3laxrFRdXbTuKg5yfGHb+THX66EWlu?=
 =?us-ascii?Q?k1sLfO2i/binUWwg/ZzS+LbJyrFyLx6IPqfSK5/XoU+M0Vlt203aFuJhIOZ4?=
 =?us-ascii?Q?ktEpNDX2FlVcxba4BvuO+OCh2WJ7P6Wy1LRhhQng0bgwaAUslpffJyLR+iBm?=
 =?us-ascii?Q?3NYRJYUPSGTcr3mc4VAAUbArXsKdl+lxlVoIsQKRzT7uYH+mbZILzEbXlrya?=
 =?us-ascii?Q?20b+d9XKWyFCdAzZPEryEEv3I4xiYbcDzU9hkKij5zY+aK+3ENpjfFDBYvP8?=
 =?us-ascii?Q?o428kc1TLojl2bsxeA2lSKQ2MyqW3ks1l476MRrO+0dVAk0Qu/InXH4Qaz/v?=
 =?us-ascii?Q?3EyVgsLG/AlWLfhpA6y5P8MyJal+0kO1UJVngD6zn59WJ1+5Gt4n9D70D4bN?=
 =?us-ascii?Q?/SbitLFkPnKUhVObdAfbtkOZmyI/bOAfle/qSAdCBZwpS5xC9cDM1bnZZGPy?=
 =?us-ascii?Q?obFIWSHox7Nxn+fv0eYKUYEXXA6pHzaOnrGeCmKu5amsAc93abvCwfoltVZz?=
 =?us-ascii?Q?GOq8QwJSbS/PPVAGAmlzatrFa+MG6kWisImIavDCp8CC/7xx5xxUp4go2Ya0?=
 =?us-ascii?Q?2OmwC1dDduVpP5G06ObxaHYbC6a9Y5Lq4ea2MTr88+cYkbyeKmOd07+/MitF?=
 =?us-ascii?Q?OYU317IWKK5OiN1LP1NJj9sRyVp/NcyOsn7J6mZxxiGavFJ1/LMmOMdhtjsA?=
 =?us-ascii?Q?zxIvJdnehY/Esn+seEEueaT375CjZy3tD93bBVpBC1F5qA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HI1GOn68EGkUG8iUnexSc+fvZxeAZmIwPTNDboQvko4nEDuWVRWKACPux429?=
 =?us-ascii?Q?j0weJjYVbM1aY6qcVhQlQEECl6afs+plae0A9oF/5fTRKR0PgU7Sc2LR3l6h?=
 =?us-ascii?Q?+tOr2rSVMHWemw9uV9At58WtgT3VkwnDM74ASkTCD3vbhAXdfyDEvMGIxxVS?=
 =?us-ascii?Q?Nq+kXJmFO1F/F+xM3TqPVotvSWsAxqUKhdacPbrt+iJOH2BkoYS7up7KjuO5?=
 =?us-ascii?Q?Tgzf9CkGoJqvduARFTXbGpBEY0ypMmJwy8cyKdTttJHjuRUf1khfk9wCPzsF?=
 =?us-ascii?Q?7rcWBxyxyHnfN4uw45nFKpIO3EmgJXfGHG3jft2fb1QKutJRuRh5LJbmrSrM?=
 =?us-ascii?Q?R2bG0o0jlQurotIEg6g1/+Ehuc96F6/3Gkm0hd4yk8dVxs4B0RGaKIIBvmdM?=
 =?us-ascii?Q?UN21cPU31MtAEXHJkgDCOYjvH1asbeOT0MTBGcq3FU/MJrDSPxtceAGQmG6R?=
 =?us-ascii?Q?wvk4+hn1+u0BzBWgeqLACLvxs5N7gO04mjiHOhaW2W/K250sTCmityWiDv7H?=
 =?us-ascii?Q?AKl1tBP1le7FFX6kcEemeHM/G8ZtWU9a/7C6TbNMU/1evqg4WuCHD7CeiDKx?=
 =?us-ascii?Q?XeS/KU+NjIeahSrZyvYBidvKHhwGl8vsCfMR35VgYVLlbTttopsWZ2xCOxaS?=
 =?us-ascii?Q?EoPWfR1esK/DDbjnfdG5QE0hQWBQDU9WSyizZz7bDMHuXGtK90yqbw84J3Nz?=
 =?us-ascii?Q?N5HhNEDZIYwBIwW/jz7Rbma0d0+YwmSDz9cO4SDNcP6+TI7f9FZclAqa6neL?=
 =?us-ascii?Q?SzGwuX/+MCR7LljVpCtlZ3sZz/fypUOHe1IPjS+O5AzZBhIHO0/dE02WBJFL?=
 =?us-ascii?Q?JmZvc8mp82qFiTVMi92op9C3mTAle/DaJRlvfQZ9kyewp4mZkaEDFR82KAj+?=
 =?us-ascii?Q?dXJVMfA96foK5Q6ir24SLNzQMsTbtECrmEuK7QzfMqs9WNmIz6Ntp3cZDI87?=
 =?us-ascii?Q?o8lP0Dc4PBVqw1Sr048WQwYwe0AM+D95jBNareYutcbsb5/m5xRTWc4OGmd7?=
 =?us-ascii?Q?r08AuePR8rCqV/A/xSsgQ/AlTHITkTqX7345JROXC5PMJXZELWwmrBthsMyC?=
 =?us-ascii?Q?hSbWeQJltMRkHZ+TBHsgV2U+beHDUoyFQMPKcHP+uJv+omQ/JmdxN6r17a6m?=
 =?us-ascii?Q?ffUdZLZEFYFUpvSKjbJd14QgycyF1H4urbudXm5PWXHDAIfqF4TfX/sF/iec?=
 =?us-ascii?Q?kpD6HflQ4YFDVJP47vCDRCH8qQQbfRbj8jHaSs1wcFPc+JKpBs2r34cKBYG/?=
 =?us-ascii?Q?pRbTGTNHZkYUfliyn5WX09G0buUeGijL3jJB26wkjOHwH4M6+4pJd2es+sjb?=
 =?us-ascii?Q?4+gWFE7McdrQ/66kz3wPr5oMylVrWTm7e2o+Yy1xn8uwj/i+2r13GTZtvcAX?=
 =?us-ascii?Q?wOhiq9KQXokAgqJa40RwW9usY2zuoyiLlop3eRYe5J3/phsjtv+pUFynI5Xl?=
 =?us-ascii?Q?isJ80SD4YRwEMaVGtzvuk/ZTVew6VXmasIA49qaUE+ME597BxRk7GiEPkwfP?=
 =?us-ascii?Q?fcBbisQJ5KjL5R5FmA9Sx+gSkIYWbpJ7sCWwnb9PFD5Mn57g6cfj4otY4e4e?=
 =?us-ascii?Q?9EY5M3shXRI9a15wRvzJvR7j+4o2GS7slwOaaKVUGoHM4BdZcoUs+v9u+D/R?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Q8GAoegXh4k6KXgiO/DZiDm45r8tqkTeP8w+nyRgCFnHNZOgI9OlfRaf1XB0GjvGjqXAoS9cmCUH3wKfp62p8UsbeNNOqaFPMOJ12PGWvN9C0GQqVCpXIkX4jSOCQRJDC7mtKRZu9WkeYOJKQHGvb+Vju8Xz/4RARX6jtb3jETj7hUssWLfD0FwIBjEktA36rFv8ls7OObygJmJj3Iow5Tra/nkzrF7Qw1in7oKTUB+7o6tiXJZHPwvsLebwIwTFboUcrbe3YINRjHTYpaJ1iw+SpSRZtE7JTUyp0pw5FuVEW1RrmFC8/1IkQ1qe3eQpuVY9OZCAUR77Bvo7i0c7Qm7CiIHBkepTMputEjpA5u4OqrFanl2eHrRxqzdtYnuwnbsblt0wwXyWJvG2jMrZ0H7F3rUq4RYLhKIdSZmndlIDQ4xWOwRT8T3//v3ybLewCWYG5d+vRXu3udCjcIwpE5fvMEB0g96o515ViT7UTpsnecms39gy2iXqmrbmKFJrzYOo/jZhuxsP/PrefYRJ5NOFIqXh3pFsAHhxQeMYB7Uhs4JUMwp9TQOHh0jByLHaSyQFP4ZkslIE/zr8jvWTIHIhpJEiOST0oykDEqdfyIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228fdcf7-5f53-4bfc-bb14-08dc9d0f112b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:21.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8PAHCMTEVwdl5LKTtJWAWtc7J+okoZwPKig3tZpcP6KqG15XXVU0Dyris7U3hio8xYcKBIFIFZA0ayq3+iY0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: HNbB-2kQtAcPdXszwt8SDpc3oq2bFI55
X-Proofpoint-ORIG-GUID: HNbB-2kQtAcPdXszwt8SDpc3oq2bFI55

For when forcealign is enabled, blocks in an inode need to be unmapped
according to extent alignment, like what is already done for rtvol.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index db12f006646a..07478c88a51b 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5403,6 +5403,25 @@ xfs_bmap_del_extent_real(
 	return 0;
 }
 
+static xfs_extlen_t
+xfs_bunmapi_align(
+	struct xfs_inode	*ip,
+	xfs_fsblock_t		bno)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_agblock_t		agbno;
+
+	if (xfs_inode_has_forcealign(ip)) {
+		if (is_power_of_2(ip->i_extsize))
+			return bno & (ip->i_extsize - 1);
+
+		agbno = XFS_FSB_TO_AGBNO(mp, bno);
+		return agbno % ip->i_extsize;
+	}
+	ASSERT(XFS_IS_REALTIME_INODE(ip));
+	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
+}
+
 /*
  * Unmap (remove) blocks from a file.
  * If nexts is nonzero then the number of extents to remove is limited to
@@ -5425,6 +5444,7 @@ __xfs_bunmapi(
 	struct xfs_bmbt_irec	got;		/* current extent record */
 	struct xfs_ifork	*ifp;		/* inode fork pointer */
 	int			isrt;		/* freeing in rt area */
+	int			isforcealign;	/* freeing for inode with forcealign */
 	int			logflags;	/* transaction logging flags */
 	xfs_extlen_t		mod;		/* rt extent offset */
 	struct xfs_mount	*mp = ip->i_mount;
@@ -5462,6 +5482,8 @@ __xfs_bunmapi(
 	}
 	XFS_STATS_INC(mp, xs_blk_unmap);
 	isrt = xfs_ifork_is_realtime(ip, whichfork);
+	isforcealign = (whichfork != XFS_ATTR_FORK) &&
+			xfs_inode_has_forcealign(ip);
 	end = start + len;
 
 	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
@@ -5513,14 +5535,13 @@ __xfs_bunmapi(
 		if (del.br_startoff + del.br_blockcount > end + 1)
 			del.br_blockcount = end + 1 - del.br_startoff;
 
-		if (!isrt || (flags & XFS_BMAPI_REMAP))
+		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
 			goto delete;
 
-		mod = xfs_rtb_to_rtxoff(mp,
-				del.br_startblock + del.br_blockcount);
+		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
 		if (mod) {
 			/*
-			 * Realtime extent not lined up at the end.
+			 * Not aligned to allocation unit on the end.
 			 * The extent could have been split into written
 			 * and unwritten pieces, or we could just be
 			 * unmapping part of it.  But we can't really
@@ -5565,14 +5586,21 @@ __xfs_bunmapi(
 			goto nodelete;
 		}
 
-		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
+		mod = xfs_bunmapi_align(ip, del.br_startblock);
 		if (mod) {
-			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
+			xfs_extlen_t off;
+
+			if (isforcealign) {
+				off = ip->i_extsize - mod;
+			} else {
+				ASSERT(isrt);
+				off = mp->m_sb.sb_rextsize - mod;
+			}
 
 			/*
-			 * Realtime extent is lined up at the end but not
-			 * at the front.  We'll get rid of full extents if
-			 * we can.
+			 * Extent is lined up to the allocation unit at the
+			 * end but not at the front.  We'll get rid of full
+			 * extents if we can.
 			 */
 			if (del.br_blockcount > off) {
 				del.br_blockcount -= off;
-- 
2.31.1


