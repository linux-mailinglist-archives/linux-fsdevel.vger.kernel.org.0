Return-Path: <linux-fsdevel+bounces-49482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A458ABCE98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18240189A361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308025B1C5;
	Tue, 20 May 2025 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fb5GiyHQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o1Y4Htan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA525A34B;
	Tue, 20 May 2025 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718783; cv=fail; b=uvVFZTrZ2o5jUgqsQadpDGodY30Lhn7YLES2aeK0y7JnGL1c3DpbXWaIW2jXFrlb6i4N80LKnJ8ZCbHsqMKk2HxltgxWo7U/Rz9RMQlZoskWho8JQFP5Dxuxi7AL9RXt84ul65ySALXkw1g4uqIpPK6+b/oI22MXfRIrciRN2ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718783; c=relaxed/simple;
	bh=ghmNcsiA7oZpKmPeloeS41bNxS3Ox9wb5Zi8yz4QT9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aNI55w9knZWPVfyNsr6LG9ENGDyCEFLo5R7M5+xBPjEAUaZP7bquArmrFBlb72Zr9Fw7hRRWys8cFdmqpP6uAhEzcNFuciIlyAkFnw7yyks+jlE2OV69m7NX7wVPdrbuCNnWDEyX0h0jR+tRzCO1HRXzlPCXELiBEydBwS1ZYgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fb5GiyHQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o1Y4Htan; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K1NEmO011925;
	Tue, 20 May 2025 05:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UqlKZDervD1kmQgGiU
	9UW99Z1Yje1U7x0QMHJN+stYo=; b=Fb5GiyHQzKcEeadRJT5yEPHZtl18CcMhfI
	k/bqBkijdDqnJ3eazYWKuCbgnwicAmMqt1yK/U4AYSHvQLntXMxGD3liyYxAuXJS
	Zv+O/I15CiVSAEBN8siTxviFNG7VSCzbVd9Sje4qDRiJlakZnwQaOs2K2gnVlhz6
	mbq3Lpg5y49imR+Nxo9ZM4BLt1xBbcQJLmKimG8VhMq37uPl1pA7XIquB1V9xBSu
	lC42UmKbTGLdsFuOweYgN1M0Lx9CAuCkrSMMftOnqGrIOBlE+5HNnCejy2dClqUC
	jIzwcJ8RI6UZp1PTYIKJeNgkVZ0YYJylLSHPKb6Bgju/996Je6DA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdew8d48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 05:26:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K33wYU028877;
	Tue, 20 May 2025 05:26:03 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011029.outbound.protection.outlook.com [40.93.13.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7gvv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 05:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/tvKfAAjfY2K7t98z+/CEJoD/63FImNyDAeK6YbG5ub3AygE3V7QCq0ohrtZXZvn4C6DZU/qQXx0px3Co4QYm7/GPfInfklssrmtOkAvYB+Rx9M2poMuVdUAIcabEQtZXESArg5O2s+q1OcYVcLArg6ZxdfmpQbKFCGWDKU+t0pziU4y7mlpjdK4U22Zna7J2R3gDaP49ixK2Sg1sOuRbNRgnIED9722LioyX5AiNvbx85IIs6bJO9XIw1HBXiWyouk+Mu9D2su2V0yGUr0MXyeO4Y31+tvTtOK/Bcex5HXJc+6Y8PU81nDW1xBbKORD+7fwJ2KEreW9O+YAFRV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqlKZDervD1kmQgGiU9UW99Z1Yje1U7x0QMHJN+stYo=;
 b=kp9HehUo1jr8qdT2SQVW6BcgUc+uNPxL2+YjfIFya/NgllhcfRXdxkU2JHwnOW4EIc4uBp9OZgMUXRR3NH1mXpUsQqsKt0aFmeUssTePQOhuKFXCGma/xZC6bC4NcW9zsNzEUmp4ipiVbPgm0HmLuLCD1bAYxcdnZ/x/2KPEuqMtUApJ6bQmF89j3MCLLkE2uNnkJbjgLKfSojDf6J93AFTVA5rt7uH59W6MLGZ2dYaoP7skQB0MXmx47pndngcPnt+mQNsF5J3ngQlJANJwhS1GperTyTT3V9op6k1hAQZeD5KGabwSX5FXaze6Y0bm446PvUL76YzCm/2FaZf04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqlKZDervD1kmQgGiU9UW99Z1Yje1U7x0QMHJN+stYo=;
 b=o1Y4HtanCl8F5fb/UDCO7i5dEC8AsHjK6BvJotK3PVxcMgVl9AnWW2vU0wLN/B25pJl1PsFS2ck04At8oaQxWgjFRUDRYT9XnvSZDkdIEuA6OAngeQv/hyDobCZZLxOuPos1wrxImtbFsinc/z+oyvbBzsVrdkU8eI9By8nVDa4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6796.namprd10.prod.outlook.com (2603:10b6:208:438::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 05:26:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:26:00 +0000
Date: Tue, 20 May 2025 06:25:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <d8111fae-7bce-41ba-83d4-b460650e9962@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
 <20250519145707.8f9189a6f845be89d13f6afa@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519145707.8f9189a6f845be89d13f6afa@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 05187bb8-bc02-4133-2f15-08dd975eceae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L88T1eoSr7r/saqpc260RXnr81EyVhs2t50p8K+ZwMHuQNWat0LbER+efr89?=
 =?us-ascii?Q?Xf9Qoc7RjwwMkzsJV+n4cQjGXiDsmk6VgSlY2QK3iJCUdHGQPgjpo5U0cVGq?=
 =?us-ascii?Q?MACDTrjkaGW0kcIff3QKLmPo5+lQJaNQEGqC2jaYF6lqDk26cvxuOT8mI7TY?=
 =?us-ascii?Q?IXqJpCYPRRcgBLqhl7uccHifP/8XsuLJ4CTTd/wg5tC3qvCpKYhePRrZMc3B?=
 =?us-ascii?Q?65ua0eUyAIvRGr6xdnV/vVwMqt05rB5arvNRLeAlBwyfM+yF0CQVNIYlO5Uq?=
 =?us-ascii?Q?RtnhC1/ItQd7Pvh81nKfUjvl6RtGj1BnIYPzsr4PCQmrGco6RrZKNPHs2XTu?=
 =?us-ascii?Q?up8SyJeIcY5sJPVfHD+ptvwZdON35BkNUxKdlP11rR7E2IreatLCLtdrJXom?=
 =?us-ascii?Q?AP43H6Dn5r0CpUoAKS2poso6fqtsh7OkG22jbzQIXZyHamw2PRjzxmIKbGrR?=
 =?us-ascii?Q?hFeb0pB7hlnR68L26MnYzdCd66tygmZmnVTLdBZ/Sa+ajrErMvM+sYrQadMT?=
 =?us-ascii?Q?WopWj8uxSkfsI53wFj97wq+/7IXC6ewnpPa0sLPCYiXYlc+cO8V3XtpGMEBw?=
 =?us-ascii?Q?1CESiatNqBa2Q8vs933w+b5ueCEnMi5/ak7g83+FkT1fZMmHKPVVnYjInujQ?=
 =?us-ascii?Q?xhC4t83+cIorvG4ZGshaF2fhb8KCBsbXzPBfne/fEkSwrAWNJvPN79PQ4wEr?=
 =?us-ascii?Q?TMFi6TMcO0z36T5YLiyTjUUGUTPMNHh8v06/OAyNpBSVEbYMFY82olyvzjJS?=
 =?us-ascii?Q?Wq5m5u13OFXNZPRCZZnyAa++of4DUeE177GLFzdNZ56sA68s6TZ8vBa0CkHd?=
 =?us-ascii?Q?4maJJSWH1Zyx8lMFAORkV3xMhZ7PW1MnNTtp+CUe10Rf3f0QZuel4Pc2omqG?=
 =?us-ascii?Q?tTAfeavI5Ir9arwSsF3bNlyjHMUdsBRnULt+VH0PEIiqqp/uyhW753FjzErJ?=
 =?us-ascii?Q?RRZUQJWS9QBoGseGq4mKUvLqeOjIDuOMuqCphdMx/dsEgUNp4kjlESnClA5w?=
 =?us-ascii?Q?wYs4r96TyeLQuPdat04ZLIziq6OMDjeZtiKLqgkYdAmfNBYy+ZwHLc7ZqWTn?=
 =?us-ascii?Q?tpuCEeXFHp2Nggum10imq1Y4YcaQFveobTwkcSqYimOnNiajG7iWPNHKH22j?=
 =?us-ascii?Q?uQPB2b+Oz1bIOVqIfhPUzEZnZyVhFKLqz1jF+Bu9Hzn2/vDM2/7HBHh7rWFU?=
 =?us-ascii?Q?yJAJqp2RtpIkHtkAvenU+VMREzMCyF62s8y4CfqCbEAyW3wwZ4ima73EFtyt?=
 =?us-ascii?Q?WLwPv8pcC9OO1EUdiQcHL18PmIkpSsn8Yug1sToB0/NfOXs49fYjZ3D3+dlw?=
 =?us-ascii?Q?RJ0vRG6V/KKgtd9032HRfqbW3n7hOQUZcjH82UhMpyJW9vgusz6nYmHCsokp?=
 =?us-ascii?Q?G3coBpmp/mYIml9kewBq8zsLJoZd6vwD8UzTLx8qeqhlRqJFxPZrFcbPJLWf?=
 =?us-ascii?Q?hj98bYFWlAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TnWlqjzj5n+FkCAFKFCKuCzYd6qwMw4pH90HTUsdo13kbuZRqR1sfz20aaHg?=
 =?us-ascii?Q?1pcq292ci41YxOyC0mVJ1Pvabdiwa9Ci5hs68nLfoVnQGwunxgEq7zTThudA?=
 =?us-ascii?Q?EmBxzGrQduNbW+CkzjFRIQcsj4cU4lTnzHHgOYgHAo0m6i65C4FKS71F7yVA?=
 =?us-ascii?Q?XNZnyXHRPHF+r3Dv3oELI17BGx1f38zZAmhTHLNFDAeQxM3QWArdJ3f/zeAZ?=
 =?us-ascii?Q?ru9vRDrMCFXE/egeFXdY60+SfvFEpdxOR22HM404FnbKbiKu949mDBoXg5VB?=
 =?us-ascii?Q?Anuu0p73qyU39ntYGmSdRzrvao51qtmI5q5JVkvYI81vvy2mgNZqy7nGHlP8?=
 =?us-ascii?Q?S/g+ufGAoR6sNiSkFmcD7NyyjoeMn0CAJqSsUXjyTtcGxEQggUfj+Ln4chqa?=
 =?us-ascii?Q?jFRuolnqlJC+QF//gAp09NsEDsf1hyQBkmFx6Mnm8uKH0+l8W9n7jlENVmL2?=
 =?us-ascii?Q?5vUucNqYkVY/iqBQMCnt2wPojr7xoJwm+OhvS9E+yhAavlsD2kB9Sid2mJVe?=
 =?us-ascii?Q?F6qXADDdQ7+noYH+ot1zYXyr0sGQCt3p8R1uuo1iyh2faK7cWWSUtXfObkqZ?=
 =?us-ascii?Q?fMGcZIMcsxazgeMgfjqAc0dvqnfpioyYHCwQuMw5bi6Jyv4tk0TPxDZRRpZm?=
 =?us-ascii?Q?GC8PUfHJ1le93WLY5SHhpZV+1Eo80JvVvC8gAhABVtZDsu4MdN3l6bwXqD6P?=
 =?us-ascii?Q?VeYF67mHGnJ9ibpVLaWaAOImkbJkqsJ9ZAZphFKwuhTktxlFSAqtF++QzadY?=
 =?us-ascii?Q?wpYRTCn+yIH6I37G2Jc+qoPmNlGRlpTrTMvaLwHmwDAr6uHUNupNeVoeeWaO?=
 =?us-ascii?Q?X2sfcn29Gdww66/LHgyIbvyLEC8gd+G+3yGKu66oqRsfIDf71mjaoPvNPv2l?=
 =?us-ascii?Q?xWd0t+3VrFkwDDm0JsP3ovBfDoS6G/rlVGAjm+W8BwDxsOkINfWV4mF4uD3K?=
 =?us-ascii?Q?AZAnIQxRPfx1WYumK5Dbhc2leK8UvYW8PwSk0FxlVhTPgEl+4TlfBvK2/n1j?=
 =?us-ascii?Q?6Ott8vbTFEPlvB7RDOLMrm/1don77xtgbrZwSqvNZdIazpNlnsHcrvk4aGXM?=
 =?us-ascii?Q?tFbaudhEl2ltWOvUuisQisoT1FPVbx06vhmt3eeXafxjS5jD2gxNIUBoGFoo?=
 =?us-ascii?Q?lZe1CKzUNgnSahmBEtnJzzI2fMJlU6MQmrQ+G33kbHz0WTzcjmY6EWJrTqpl?=
 =?us-ascii?Q?H6HHkSW4cbU0mjDzWZ/dD6RnVVgT0bQ8pjlskFjF2k8jNrrA25DA+esy6/c0?=
 =?us-ascii?Q?N4L1UEH0G40ZvC6/Sd04M8YFgQtGu1pw664vJy5cqUtNuQKjBDALjRgEc+L/?=
 =?us-ascii?Q?hfkHMoMcN4VNM51vSL6qaNk9v5yfGq5/h1TVwBGXdpLryyh3t2+L3QkrrmrZ?=
 =?us-ascii?Q?yRNvG92FVS7a30EIKbiWRxomQkm26LMIPYSHv47r34VsQhVSZofGK73OmBDH?=
 =?us-ascii?Q?WKL5b12sxO5R98+K0uzOWVgAcutKF4RENYPJkjPbr93uPveELu0z6GRP8oXh?=
 =?us-ascii?Q?Kx9dVdchv1iisXZrKwvOOQtThT4PYgSKmQ7CsrLJPCsYLXUL8ML/WWBahUHA?=
 =?us-ascii?Q?igO4nQaLnAOInLtPJ7Jy3xyT7/8jHzM/3Z5MYjWKooJokUexQePQZTY5YRZ4?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VrYEL8ZoNRukZp8Qo92U4EL9S8EjGrgBps6STxSbNxpZFoI9Qa7afCWnnmHyDP9G4beoVyj0Atllk0plMPYBMlDdI8GB8muhGbrY45zGN4nvfrVxX+hzWbHb8wUTeB63RDKruZbcrAho/TGJpMWBa8I6qy0Dap9wkJWJuNXHbTiluckePQqnDrM+cR9lo1Tnt+2Lw9jqXgDn1oD5ZwWizPpJEzhZNbA9YhQAB2zHQTRa3Tau2X96xHO8NFbseyFDNP0YjjQVxA0ConTke77qomR2jLpDIyfjcO47Dv9MeecTcrejNGFt2p2EKLtZQYQ5HfAtNPqK1lgTbDFSZK/Pz+aZkzICSIXKoDVxlVAFZGCgqfSD5CRvTWLf0ae+wmzDIaLZxtwLrUx8UbehRNOikLVt5fdWaJVlQfWjUp1lxaT6++Da5x4HoH0hm7xnpcjPpTFZXY7BMRXDtRRzR550DGHgzCi01KoI/Fh6s8hD9X8jkr3GF0d+TWFPJEIMyF8upRGIkZvDHjRBVQe3Arj4qichZh+upmIAjGqX5tee2Cn6UICl1XiiYF4qdIgregeKQyujomc79xAXc9A5RnpNle3NJw7EgjYHlGCJpfO2eZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05187bb8-bc02-4133-2f15-08dd975eceae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:26:00.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFHoeOoJ8FWqIuqiSxAEXPa6XfYQKCLZpv8wFKSHft/bczrNymUQn1iidCBkNbJDU/Gr9+tr+zD+9R2LMy9xfJSDGN5yhPwyU4kMn1Exj3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200042
X-Authority-Analysis: v=2.4 cv=Rb6QC0tv c=1 sm=1 tr=0 ts=682c126c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KsYNjs20_3EQPYuu2-8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: riDNzzYD0yYAeMlhc__zWBv4_DKmzQWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA0MiBTYWx0ZWRfX1aMvpM1L8dfV m0slM1WfjjRBwmtHNntH1C0m7A/7xLjDxiTJ2fWVG0C7+coEKhmeCozu3PPBPzseu4Uy0vN93rQ B7610b9ImPbfw0z8pyVBfbhCVy5uNgUu1ZkDq5Jla4jW/Y2hfuop1YRSbxICm55gUpA93w1Mzya
 uLmKsOm7S+RN1xVdZ3+bYhf2JO1pSDNftLVJOaah6bbcxG9PBdbO0EU5FTDCwPaz4fEOnyqOkTN zGM9EonYk1PnSXW+JS52sgrMKbV94R4FSwj4MUf1jpWgi9B6vXbRCCjqmJ3fIs5vjpykk7ZX7U4 1HSMoWqoks148xDM5r3bQSY4xTqY/hLnroulAsmgyHzmo0mq0pS2OfcH0VryZF2WIS/Iyf8Ypb/
 Ehi0EAeJ9LNoUMM4LLeltkX/k4TAyihxgodl9ekRwLCaO/cN86e/AEBiiIRRHg7Ucx14EAp2
X-Proofpoint-ORIG-GUID: riDNzzYD0yYAeMlhc__zWBv4_DKmzQWy

On Mon, May 19, 2025 at 02:57:07PM -0700, Andrew Morton wrote:
> On Mon, 19 May 2025 19:52:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > CCing stable is likely not a good idea at this point (and might be rather
> > > hairy).
> >
> > We should probably underline to Andrew not to add one :>) but sure can add.
>
> Thank deity for that.

Yes this one would be a bit... grim :)

>
> I'll await v2, thanks.  It might be helpful to cc Stefan Roesch on that?

Ack and ack.

>
>

