Return-Path: <linux-fsdevel+bounces-65722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D9C0EFEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B83B5126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC630BF72;
	Mon, 27 Oct 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ii0lOy3z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ipm7zEsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B387081E;
	Mon, 27 Oct 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579225; cv=fail; b=aAKFph05CirdyaycqNst1fs1EXHxY/6efO5+mYLobMe9S11jloHNecTEkT8bJImhmGefZKlbIqh08GddUhSV8BTiqP7BUB33xoiswvlLldgnOu9Xiz2ddncCRo483Awubd22RdDmu+E1NtykV0Kmj6bWJHm69bOnM7LXOWci80w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579225; c=relaxed/simple;
	bh=ofW79vsaTPy4m+pcRVv1/9K+G9xEIZL3cKmjqK1yAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0f0QOZv91Hy1W1vjAR3CD5U3c3DBFpplu/bmSTbqHQFXWZD1NHIlqeTYl7nUWmU3DiDFkWKeUyAnEuP1zFR90PftKIxbo+9puz+iCqPV5luhEVPuqagxUVL0t6/TV0gAHQTxpENf7w2qU52Rab6FsYoTHgo8oxhd0PTsCs4kjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ii0lOy3z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ipm7zEsr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDY9VT005555;
	Mon, 27 Oct 2025 15:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WSYnQBgjtcl4GvR3OJ
	bqYk4X9SSfTP/26wYSxf5+s+w=; b=ii0lOy3zedIn0p8tcvFS1SGWIp7dDyGZd9
	xggiYGQF5kT3XdZ2liAlCXr7ckObQBN8AwgDoN4GgDx+gGCbWQmSF9qS1fheh2+Z
	+8XAILZHUhmuflJu3kGCA+R0l935EOew9VNGwhwe+iVGfKSz+NoWsepbREIvj9QM
	iaCR3JAC+QBDQCMabeWSRN3Im21BsYpFZHddqbp7QCd1ATrB1dIPwR0AwO03kl+0
	K0z0DuJ4+2F/DsJCCeedVZ9gKDBdTYaRiC7VGKBt24+0usrxZvQ5ZDeJDHrpnkW4
	KSqu3FMvlKLomPibgfGf2ye6EhpTGJqbn3izQONpJaSkXLKDlmvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwh848-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:31:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RE15nF025120;
	Mon, 27 Oct 2025 15:31:46 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n076ft0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0yovkXi1vbmcVjbXOgtA2lL7FlEgx8FY/Km5ymMVV5YEhDdTg3ksBXKjTN+1CexLFVOj5PoA2KwPQgATihK3qbKg2W/NcD8lT0DG9Lzm4ydobeYRNpf1XnuD4IFACnn6es2v+6FmwhjItT7/D02w5eQg6+TFIoA8vy5UaxBsxtuCrgIy0V7+bae67iF3qQV6aOSUefJ/Vc7/8MHCdttFLcVO1iZuzcozd8OTRVooy1LOJ0t/FylETJKWBL2xMJQhrWenx22JttsvxBqLupiT2akGa+udM0F0BU3hup9E0SSjL/Vz8N6uBD8k2HIJ6qYqnYa/aGNHajnF0U6PolXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSYnQBgjtcl4GvR3OJbqYk4X9SSfTP/26wYSxf5+s+w=;
 b=KnQb0gryXIp/gmgF6QW5c7ZlfJfCPY2gmHacAYcl8iDdYhCicOFIvHjMQZro2ZXgPbL+kDA5aK4JEZ6ZlzOfwBiYTcAF5yMooHJebtGE92p9xPAHMrtcXbB6tjKBgDkhk1jqKTI2ZG0EvI2ojsl/LxWmq80IHlyAoWYDAplSKYFxEdT7dA7iNxWt7imgrFWS11K0rJEINixqGwP6Inaqc2dMWmPGwgxfDemDrDM8WprpZtGV/K7F3v3XCiYs+5hBuasOBWQumToABEdC2IXtTUrSmg+GICZiKURSRQvwTc4L6o1uJKZgQxAgSk6ATVQuV5Blqu0NFICjykVtMXw2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSYnQBgjtcl4GvR3OJbqYk4X9SSfTP/26wYSxf5+s+w=;
 b=Ipm7zEsrmXb5C5Awbq/0iGSZJFDmjUIL7PJ5ctOM3BAucCiXHJWk4t4B0U3E9jx3E1tk+V9qcRsuzZpeqAwLaC64ozcwNivRIp3NFS3haZW84LbqtW/W45SNlf/CsKG14AA1V26eM1HA6WxyQ1PoTSJ3ccCDyEfL2DUdReffVV0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 15:31:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 15:31:41 +0000
Date: Mon, 27 Oct 2025 15:31:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
        nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio
 is split to >0 order
Message-ID: <c294bec8-1343-4319-945f-8c0936b3f2f6@lucifer.local>
References: <20251023030521.473097-1-ziy@nvidia.com>
 <298f1a0c-a265-4b0c-a5a0-7f916878dcc7@lucifer.local>
 <60D65915-5FF5-4ECA-A52F-8B9FE8F714F4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60D65915-5FF5-4ECA-A52F-8B9FE8F714F4@nvidia.com>
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 47adb341-a13a-48be-871c-08de156ded95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kN7oBf+6lKNsXnIGAl/JiEZJEJUnUpEYaSkcODZCRcgYtvIolFX1oxvz8u+R?=
 =?us-ascii?Q?grT8OykhipCnJwUYCU4/Y+6UsM4OkRajAXfWm8cN+b1guZlvVlR52kwRxv6x?=
 =?us-ascii?Q?QWPmLm2vzSHM6vlXk5CsFXV3LLhvUxVNqy7rSDyE+N871Rl+I9RE7IJ1eBhl?=
 =?us-ascii?Q?gUB5e1qE7Okc1oWWWq82RZFmcGqfuXgUOD9Gb3H5PJ7wHPVmSWAeO9ZMTFf0?=
 =?us-ascii?Q?1vlXwvsQhJnj53DQeJT9zCcaTLc7IuSrpwMNDAFZD9dNfKybmtz7CVPcKLp/?=
 =?us-ascii?Q?rMKEEelIt/VZknPd0s+91Ke5NLHlVYs/PZrdPAvVsZbP15mGuSaqAYpiZ/Kp?=
 =?us-ascii?Q?qu4hThEi4ePX2z+2+BUtn2TKm8vU+fLdfPRYzjRah85nvNakiIfbcf5//ydx?=
 =?us-ascii?Q?L7NLFyVRIr7KSF8Wr5jBI4WCMdJgA4Kd+maVNA+/qoTjLtf682wuW4Qpuwos?=
 =?us-ascii?Q?BG198rweDUUuUUnAn23Kjy9ethfBwZvWzLzjgijynX9beCATCQNjcugKR7DN?=
 =?us-ascii?Q?gKKscqEpuBM6BN5vQqZAyZ/bbMn05TBizDgcqAI3nFEFUKfGUD10FFEHHny1?=
 =?us-ascii?Q?GVjHXRzHYLcrTR5Ue/jGCOK87tHXUmwH50nd4wFDEQ61IYxPdHSE7gzDkMEV?=
 =?us-ascii?Q?2tVrszBllixj4q9yci2erG7XBsTQzeHr17O/egZ3pMnNdZdzStYxZfjMXhvM?=
 =?us-ascii?Q?JA0FJaYPh+//Yquay+sJghUDIvoazZ3VQmVyqEAVp9QpZfms/uX0hO6hQunx?=
 =?us-ascii?Q?wSrBATkeybOX/+w2sBcuFMsKbSs8K2dgtLScLyX6LI33pHlUnOk0U7JHOWZH?=
 =?us-ascii?Q?ApjM1ZdIBNeIM65WhyfuIcUL/74V+HbS6HWk/tRMxYrYFQuSIYbupW+Kt+sH?=
 =?us-ascii?Q?SRBbiYbIdVy/10h8c+7ZANMVpqLJz45g3IoFDxIWq5y/XNOQHazydd7EVBo5?=
 =?us-ascii?Q?XSbvhm4WGkzZUpdYl+O4Lj5nvf7dTHmMre/X//hmYM7D1dZPaNbxnQLQeI+x?=
 =?us-ascii?Q?hKw0tLEegrs9ObL0QUsPVNwIYX+DL/fVw7PiJiB/Xidn8z+aXY/iraYGy9Fd?=
 =?us-ascii?Q?kTDm8mTG8o/fyzwBoYiukgaMnzuiBdaqF8YkDiTGFXSBj9j/Y1sJ8OZhNisQ?=
 =?us-ascii?Q?DKEU7MHM9x5FoCcRCsYNPL3tGozNUglD++2pzpOBubchu1Ms3R6H72OzIbwO?=
 =?us-ascii?Q?RhhD/0/phuvQP5QO3jJKjLBaGVWArTKZKnYz92a1xxcYl6ShwQH5bayk2ZIF?=
 =?us-ascii?Q?8y83cnpMzZ+zKY6w79NIgAupoOzkTxI8qARo1qCLve/QAdo/q5MY9bmLy23/?=
 =?us-ascii?Q?PXh9vwzSx9GiqO+wKZ1VGhaiMtGIhW06SJwKLLwJuY7XL8rzy64sHoNbJqGc?=
 =?us-ascii?Q?FGcwHKjDFPTTBIxle1oT6GjHnWw4GivLVNGw6EH9ITgS9Bcv0FbYi+ofuM4d?=
 =?us-ascii?Q?7vl8MWaK5sg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJpWk8qvPduVKDx00sce8JXo/Fp2Mbf0gG60VofAFHT0o6pt/a5O1N77PniG?=
 =?us-ascii?Q?QW7qHpvfPc40+pUbPw+o5JCIRKhPRRpLXBA0BgSADb+42D0eW4v4gdcNuos4?=
 =?us-ascii?Q?evy5Tv+doH5Rcq/CoxTBmx1TdYDtPbx/PdFj7o8pEnXg7e6QpZ3AB02P1UXw?=
 =?us-ascii?Q?8R/3Z0sXMBUDTfRX9KsOn4nTfpW5yojCiW+I/zVdraXYOwKvwNq5yvs6hFE1?=
 =?us-ascii?Q?+6pNlE8T83qYnt4g+AxsAJad71Y5LRFb9kGg6zDrqgb8YKSP/9069TVwAEps?=
 =?us-ascii?Q?dJwvhCaqC2oB3YRjy+pAAZT6bbC8hCaEG+0PkSNIAmMJjHeAzmhzRnN7L/ts?=
 =?us-ascii?Q?phNjZh0YWgyHazsDgOvSWUdI9OGbAYU0uB5rMSnB6YytJ/Ys36Bku44NenZP?=
 =?us-ascii?Q?VpdNy0cBesLOdcYS9gnXXyu0it8D35+X9Sv+SbZcelJxYiaP5oj/M12j2TMu?=
 =?us-ascii?Q?JdGt66CwMcAGmOYbx7BNXZq8lc1GvDVFO39g+yzFvWWUG7H1Ev9qfj5dNqGX?=
 =?us-ascii?Q?/VKVvE1bpQcGkZq4QjP9pIJPMC0lgI2S+DRijXp0tdBpgft4Of9rZ5YR1hRT?=
 =?us-ascii?Q?NQoWrBNVSGn0RVRHwNaQLhPGf4azJ5w1yitn+p2nWfG5iZZ0Q6LYHli94ml7?=
 =?us-ascii?Q?q6e+tkq33IF9Twp0o01FhFG8SNaiOEu8E/XpKG/wmSOqdQz0KfsFzuO13BE+?=
 =?us-ascii?Q?UmuyByulgcWO7GP7UVDrGmw1fw23q29eImNwHlfzZNi1fNpvxcsF+RrDfeVu?=
 =?us-ascii?Q?c7X2t28Jv1W5xF0UeNi2KDw/Chd6DcjRXLiXepbxUvw+BZWS+hVw18UIJYdp?=
 =?us-ascii?Q?4BFN4ZB+QCyjuv4RJnXFE+fpO8aOtjT1qsHxcubhjWKP1nAs81oKPQGSu5dU?=
 =?us-ascii?Q?WPZBrAIbZKpJ0YAdHC8hLro2kG854tN/zDxxEviCiaB6ptCkgyLy7TG931Xa?=
 =?us-ascii?Q?wXs1XdebvRL7Lz4jvMKKnROEPenZZuUyQ/hZQ1BClZBzTWRucE9zIZ9AfwaL?=
 =?us-ascii?Q?UUDB8F2XyY3yeul6PhSYJywOLxah1+sjeINUs22wJLvpP4XSTwziYiNLe7qW?=
 =?us-ascii?Q?o07myHZ+0nyE9iNlnBn3AYCskibrqBwopr3sPMh/ZErn+S3AXL3MTOELzhNR?=
 =?us-ascii?Q?GNpxLKaj5PvzWZC/oLxOmZCCylvYASlMuqqqqgPCDUw0BgQXx3/5Z1vEpMqq?=
 =?us-ascii?Q?rMrjAig8TaSBjhlZSYhjYErHF8EA0BGvrVQYx5g17/22GQ8ZjJ2M//TpSmVg?=
 =?us-ascii?Q?vAJbbCi8nFhq6kEJnSNgIE4VDg1iM5xGDy62uKgpCgVULYz6215JqenokeXf?=
 =?us-ascii?Q?NbOnuNEZPAi/7XrrOQ+9EHrG7OZGGyttQsVrg5nAuvDceGohd5mAaB1D4HRI?=
 =?us-ascii?Q?DopVt6jq84XTe9ZY+EtJDxUw2pUE5kVTiSwCxClQj3hGBx9uYDgPkFsK+kAg?=
 =?us-ascii?Q?k0QlA0FSOs7LrvGxQxcIyYNOiKh+CnvWwWozD+jgOvaZGwiQfDx9eQKyOGkN?=
 =?us-ascii?Q?MU2VOQpRYU8K8D6zHQz6NUKUWkdvCJlWohGdkikgXV+hkHZovlJjAMt1qVpT?=
 =?us-ascii?Q?XLPdvdINsDPDo2KSjwMH1io9r7YmF+sWkOjEmqsEahZ4713llnx6ZXXpw+Z7?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uFgsIco4t0czE9oh3KGi0eA7HAtbPWaatPPqr8uilVTotMa5rK3gvBGCT/Eq1ZVpyly0B5TmNiHzQCaJe4rOI7pG8F18etrXaeldyHmch8Wax5Wqk93KndPpjFlHWF31pJSZhk9poEeDXeJfiQZR084sIeIpcjif4fLf4wwJZOEsCMV4vhmWJV283iToSBBSMhqMeYnx9L+fDz3sdhn2aDbJ/rLXaR1848Dgm6yw/5CcRH37LM+91vPzZJuJoz3KDBe6IVW8M636+E1GrMo70TEda0a6NPsUwnTQyhHZL1f9b1yEJRUNYc/fdh0ZobrGwplWQaGUCATh2cQUhmkSwmZNXalLh1qaqNiyFkgkM9KNL6+/7EG3irHaU/JRTkf683t0hUe3nP4NkYqyiMbLhQKKBn3pDyYfO1sjd0zpueGKKOPG6yU8OaE+r1M1NqgU7Kg+0/YSW6sfTe8mpWuW4kAE1rV5rboniIp3r9jpEDYfS9OVksRUNDGZkw+B1n955uy3ycYXhsZGjMkCA30A7z9N5z03qxXwxk4zjx9ffB401inYIyREgy6q3sZGvGftUyBTFLmuJHLuTw9aQiYed0VEX+4E6S0vz0zdlklBmIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47adb341-a13a-48be-871c-08de156ded95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:31:41.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmBBFJKSwdaEewkQB51to84Ss1iXCcFD8ZgkDpoTXZybTgJKvd38RnF4kv9LMx+SaKe0/FwAZdbcHHEgmt5beIoITAZCFWzDaetpZmqgtE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270144
X-Proofpoint-GUID: ycnolg3CfFq9xUuFPpxKtyFTKIkkV84R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX2H1tQj8toyvp
 KKGpS72tmafCZQUWY9RQFbmNrFvco7COu0zfsMHluByHpGhJziR8WxlppDXmVfCKUkWq1YWJHrb
 EyB1+yufLlc5EWTSB8/FRisIHGgxN4GfGPvZDtL7zUlC0nEP1g8yS/EGF5OpbesYsaH/Qf0pPXl
 NiY5MeqZrjOWr0NbZVngoIbwNMWP6ZvWxo30AuI7IQY9yfq2QsvhKv61lbKLynzFUhbVoJKmuwk
 NFl7PKPPRfKzz9dREaoyF8bdb3SPeyaMOLETnugkO4PeJ2JlfDu3bZ2MsEIpWuKldsOGXOwEe64
 uybubqMqT2Ey62rSklOhCyVuJ751jK4H5+03CjIKrPZF3JjFvK2Ha7sh6lQSyGZSnQBJZ8SqvZM
 Gvz08BmI3gtThfGdFmyXPz61eE0z4w==
X-Proofpoint-ORIG-GUID: ycnolg3CfFq9xUuFPpxKtyFTKIkkV84R
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=68ff9063 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=jXjzwb-ZsEZO7R3cNCMA:9 a=CjuIK1q_8ugA:10

On Sat, Oct 25, 2025 at 11:30:19AM -0400, Zi Yan wrote:
> On 24 Oct 2025, at 11:44, Lorenzo Stoakes wrote:
>
> > On Wed, Oct 22, 2025 at 11:05:21PM -0400, Zi Yan wrote:
> >> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
> >> after-split folios containing pages with PG_hwpoisoned flag if the folio is
> >> split to >0 order folios. Scan all pages in a to-be-split folio to
> >> determine which after-split folios need the flag.
> >>
> >> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
> >> avoid the scan and set it on all after-split folios, but resulting false
> >> positive has undesirable negative impact. To remove false positive, caller
> >> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
> >> do the scan. That might be causing a hassle for current and future callers
> >> and more costly than doing the scan in the split code. More details are
> >> discussed in [1].
> >>
> >> This issue can be exposed via:
> >> 1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;
> >> 2. truncating part of a has_hwpoisoned folio in
> >>    truncate_inode_partial_folio().
> >>
> >> And later accesses to a hwpoisoned page could be possible due to the
> >> missing has_hwpoisoned folio flag. This will lead to MCE errors.
> >>
> >> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
> >> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >
> > This seems reasonable to me and is a good spot (thanks!), so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> >> ---
> >> From V3[1]:
> >>
> >> 1. Separated from the original series;
> >> 2. Added Fixes tag and cc'd stable;
> >> 3. Simplified page_range_has_hwpoisoned();
> >> 4. Renamed check_poisoned_pages to handle_hwpoison, made it const, and
> >>    shorten the statement;
> >> 5. Removed poisoned_new_folio variable and checked the condition
> >>    directly.
> >>
> >> [1] https://lore.kernel.org/all/20251022033531.389351-2-ziy@nvidia.com/
> >>
> >>  mm/huge_memory.c | 23 ++++++++++++++++++++---
> >>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index fc65ec3393d2..5215bb6aecfc 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3455,6 +3455,14 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
> >>  					caller_pins;
> >>  }
> >>
> >> +static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
> >> +{
> >> +	for (; nr_pages; page++, nr_pages--)
> >> +		if (PageHWPoison(page))
> >> +			return true;
> >> +	return false;
> >> +}
> >> +
> >>  /*
> >>   * It splits @folio into @new_order folios and copies the @folio metadata to
> >>   * all the resulting folios.
> >> @@ -3462,17 +3470,24 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
> >>  static void __split_folio_to_order(struct folio *folio, int old_order,
> >>  		int new_order)
> >>  {
> >> +	/* Scan poisoned pages when split a poisoned folio to large folios */
> >> +	const bool handle_hwpoison = folio_test_has_hwpoisoned(folio) && new_order;
> >
> > OK was going to mention has_hwpoisoned is FOLIO_SECOND_PAGE but looks like you
> > already deal with that :)
>
> Right. And has_hwpoisoned is only set for large folios.

Yup this is what I meant by you already dealing with it :)

>
> >
> >>  	long new_nr_pages = 1 << new_order;
> >>  	long nr_pages = 1 << old_order;
> >>  	long i;
> >>
> >> +	folio_clear_has_hwpoisoned(folio);
> >
> > OK so we start by clearing the HW poisoned flag for the folio as a whole, which
> > amounts to &folio->page[1] (which must be a tail page of course as new_order
> > tested above).
> >
> > No other pages in the range should have this flag set as is a folio thing only.
> >
> > But this, in practice, sets the has_hwpoisoned flag for the first split folio...
>
> handle_hwpoison is only true when after-split folios are large (new_order not 0).
> All folio has_hwpoisoned set code is guarded by handle_hwpoison.

Yup I know, maybe I should have been explciit :)

>
> >
> >> +
> >> +	/* Check first new_nr_pages since the loop below skips them */
> >> +	if (handle_hwpoison &&
> >> +	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
> >> +		folio_set_has_hwpoisoned(folio);
> >>  	/*
> >>  	 * Skip the first new_nr_pages, since the new folio from them have all
> >>  	 * the flags from the original folio.
> >>  	 */
> >>  	for (i = new_nr_pages; i < nr_pages; i += new_nr_pages) {
> >>  		struct page *new_head = &folio->page + i;
> >> -
> >
> > NIT: Why are we removing this newline?
>
> It is a newline between two declarations.

Oh you're right, sorry!

>
> >
> >>  		/*
> >>  		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
> >>  		 * Don't pass it around before clear_compound_head().
> >> @@ -3514,6 +3529,10 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
> >>  				 (1L << PG_dirty) |
> >>  				 LRU_GEN_MASK | LRU_REFS_MASK));
> >>
> >> +		if (handle_hwpoison &&
> >> +		    page_range_has_hwpoisoned(new_head, new_nr_pages))
> >> +			folio_set_has_hwpoisoned(new_folio);
> >> +
> >
> > ...We then, for each folio which will be split, we check again and propagate to
> > each based on pages in range.
>
> Yes, but this loop only goes [new_nr_pages, nr_pages), so the code above is
> needed for [0, new_nr_pages). The loop is done in this way to avoid redundant
> work, flag and compound head setting, for [0, new_nr_pages) pages and the
> original folio, since there is no change between the original values and
> after-split values.

Yup I know, was just working through the logic, it looks right to me!

>
> >
> >>  		new_folio->mapping = folio->mapping;
> >>  		new_folio->index = folio->index + i;
> >>
> >> @@ -3600,8 +3619,6 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
> >>  	int start_order = uniform_split ? new_order : old_order - 1;
> >>  	int split_order;
> >>
> >> -	folio_clear_has_hwpoisoned(folio);
> >> -
> >>  	/*
> >>  	 * split to new_order one order at a time. For uniform split,
> >>  	 * folio is split to new_order directly.
> >> --
> >> 2.51.0
> >>
>
>
> --
> Best Regards,
> Yan, Zi

Thanks for doing this! :)

Cheers, Lorenzo

