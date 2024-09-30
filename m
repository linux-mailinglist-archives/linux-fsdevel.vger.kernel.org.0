Return-Path: <linux-fsdevel+bounces-30353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6E98A39D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717ED281E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD718E76B;
	Mon, 30 Sep 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cSR5iW8Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w/uV0eox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9818DF60;
	Mon, 30 Sep 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700916; cv=fail; b=dJUpayNRfjGcFgAhKdmHm/Biu+vUL85eOZWVtR5gEWE9iQ0oj8MkzHkHR19Nsz1dyaTvH+MXDJo245gke4VqM85I+ImVEgfDc7spyc0U1RoQywy8V/Bchd2gZtXwMu6Rc04/Tl0TzbkvL4NoxxGQ91mWAba08pYS1KyFydtbBRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700916; c=relaxed/simple;
	bh=4y+aBRSSwUP+bluyyGBumPMTLP/ee6J3f/u9WXq3rt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQ42sYn6lsNMStPJtEaucF01P3ykiQIUNiRAlkbg5Bt+MrpvK0ghzynYAGC5OqP4oLbbfjQ//pIV34toeP6hkXUys4I8A+vVbrgZdf+UNcj35NBJJLeHvJ98Blp515mNpyzCLX1/vgQpvBABjQnWnQ52YYxVVaBmhbSiqFsf/iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cSR5iW8Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w/uV0eox; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCTdo0019500;
	Mon, 30 Sep 2024 12:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=FUOhCn0Njr+8xziK/5aS0j4Dp+pPlpxhwIK9zNn7GvM=; b=
	cSR5iW8ZPYdTjvp+uXjjij6XuX2K9JTUAOL+OMVda6J5DR9j8NwGxNcGO8LQwywB
	20SnWvNJUqYGFcZ+TGYjzb5f1VQITF2UuURZR7eTIs3NSFv+B5woOQblmLUHT5iL
	4iMAVS5udgoRAkFwcQusVJzszRa++vuhuQzsolMyXwClIZQeCdK7N1wS93anYB2q
	xYmZjAcM/sz3kdw0PagQsEv+eOaQn1KlMrADGSfsnixDSMF4xr25epbpm507cAea
	AKLmuRxBej8hMeUWpLb3GKPDfkjhJNzaBqmbHnqaGPJCNbGbtV/Ig0+cC8GcW2Bu
	KLlZR6KOqZU8/i6xUToymg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dsu6qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBv00l017265;
	Mon, 30 Sep 2024 12:55:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8860b7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRoMBlQ4AfAcu0ePUolg1nps54Qnyhjcqwl+p9buijCAhNkxHYT8CXMUxfFaTXXO5cFXKh621TXYY2SX8TTpfXmdKEXTRSUkcGvJr8hO7EfotHlhQjUsGfVgHSepvkBOenSlovobXjmUDKHs9d/MueTQKXkuZS+RM71dyyRF6tNx2Ttxsjf70eV2PCDjwb0rzFiBRESoPhMcLWjzFXvrjh7T0rlQyPIjZrddYNjeSHNpS5F6y2vRDnu/tzCKG+KnjOBeTL5OaX1pDeOpR2saFGRUsimcBBIplG3XR7GMY/NW5fk06AeUEs/9kwiqZHTZGZ91aEynULzedy/Rz4WaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUOhCn0Njr+8xziK/5aS0j4Dp+pPlpxhwIK9zNn7GvM=;
 b=hLSoUK9cr8hpwzGXfXWuT/AbNseXsnxv5pT5e2Tnu487B2PRzC3FuWgs9d9DFMoSFBt+1nYMbefH0G/QvN/v4s3FVHIIN+k1J5Jngqt+2qwgNskHfjKWf/TIl3woHAT2Q0jYTnd9uvx+CaBDBzZL8Nrgwdfp9JnTaD6mwOdtwPc3BgbnMqhnztX6RA+eDz0h8LMPMSLHfZUTQywY2aptitntEO9Yn9VDUQj9b4nHNRpOFUVn77oPSqpF5pZUCLh92lpNzXpngyKkyS2dF++r9rOkp7OWAkF6vIIUSEnjeNIh9BQEJ2USILn45dzRzz1LXXu+4hv5Re7z+DBpIQ7H0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUOhCn0Njr+8xziK/5aS0j4Dp+pPlpxhwIK9zNn7GvM=;
 b=w/uV0eoxPMxEdY1Av5SmwUEbXZxTX2Mn63gH9XTjNyE7KB0yiVf+/b2gOKTNJRa8iYSh7VNuvdzykDer1j7sK/CVRvxkK710/I4mafRwTcQLx8gAg1zQ2MuWaDxlein+c18cr28eK6mnBPKfeyYMEl3y40B+o/Fc6dURw4lYjH4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:54:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:54:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 3/7] fs: iomap: Atomic write support
Date: Mon, 30 Sep 2024 12:54:34 +0000
Message-Id: <20240930125438.2501050-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: abbcbcb7-f9e7-4422-29cf-08dce14f1615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tlMkXzFl7GUTc1chowxXoXXyzhYIOb88zPx5m4GydQW08nsjdzPgxogR4ScQ?=
 =?us-ascii?Q?cmz4X5kmfT2b7nw6oq/W4n7ZZwfAPZ20ZIL07HCO4mq4AFCpAQOxgzZDTOna?=
 =?us-ascii?Q?bc87TF7tn6OsDVs5LkXIkIOVog6Ch7kRZo9s9xeHN5om+7Cvxbl45sCOkOmy?=
 =?us-ascii?Q?ZZWPNcwV2sQtqQ5jzf5zU3EHb6zCilrQDslGfMzD8S4Xr+NosdAAQbn44CU2?=
 =?us-ascii?Q?VaP/9wLBw5JieYF14FsLDB55c9ggPfxW+dQHy1C1rHFx8EzuOripFEs5Xh0B?=
 =?us-ascii?Q?RCW/6JlkOc1s+ejR7E9h6XE1qw87RsYuQIPfS33XHzNnpC/zIMuFppalgbwb?=
 =?us-ascii?Q?GkecWdU/Wj44n2LAzxLta1YXpOkLCNnvxbqRYCEucGI6V8pzT6ZeNG49jLRy?=
 =?us-ascii?Q?dkfBvLHbx18t6Gpqf4Kz8LaJI4Z6zOslnZerzMxUnxOMZvI8NWsUyfYj7Jr4?=
 =?us-ascii?Q?laMfzjLEIsNnQi0H7rWQswaT5gDUwaKpEwQ7mjGl6FXjXo7rk4U64PSWUnM7?=
 =?us-ascii?Q?wlsE34Q7mfXQf3eUfG7so2SrPDqOCOpb6lBHzKAXXGp2HjS5Ja0n4x7iHZec?=
 =?us-ascii?Q?Wfp66F/nfO+XFyyEvtv9LVKbx6Z9qz45X7LMNX2aFed+eAAxaG881nKhg2io?=
 =?us-ascii?Q?Hp3Z7V9MIi2To5G8+SpEys3MPgPxWHe6OtkxrFmTcehSmKvkaFcjv0RyzTng?=
 =?us-ascii?Q?qFNDu5VDJUOkKaL4zndexszoDX6gZ5WW0jTVm4kc9kcfJZJISavzcG6L8ejb?=
 =?us-ascii?Q?9V1oZ5tStAY/tXe+Bex/dMi/FV2B5DV2t8JY+ot8lmm1EUcrnVgo8ANeEDOR?=
 =?us-ascii?Q?r5KpP2g2YraL7gidoF6GF4ouSGO15plvOQ1rQehRUpafUoZC7p90KMyB2Eer?=
 =?us-ascii?Q?u0ZT1mmUrd1nZb9hBQJWr91mJja/PGAqv+aDqVT4fSzDn856lyxoZCYLmhUk?=
 =?us-ascii?Q?y/AvP5jj/gR4SLhJ3WoCzbfiBkMGYTfXTaV5EWh62JJEX4NxlMTksF/neBpw?=
 =?us-ascii?Q?C7dbffEGz2fE0P6YEo1uU8lz3tS6HBzjk6IpqxLLR5o1z2+nbAWfat7bo+3n?=
 =?us-ascii?Q?YE1WQ9vON43/PvMKzwlzCtkcliR6rIlAfU0DmuUgpc60dLR9rIv/O06IBZWB?=
 =?us-ascii?Q?SBc3eELHsSq+NgU8bIXak5H2lsImgSXWZGoBw1g25aPV/eOwF4ny6WZAR+Mu?=
 =?us-ascii?Q?2dbMQgGQ13o6AQcNJ4yYiyFKLtc60uTH4CD+ermbnugS3nbZ3C0uvC1eledU?=
 =?us-ascii?Q?aj3/Upiwh54Vlh1yEQUVZEW8UGO4gbmFFOQ8ILXLDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsSTV9+Cpw4aWPd7EQ9w5vLos5VYODn1BjupyZyFUCmPhBbfcAfly4OfnMbt?=
 =?us-ascii?Q?7ceCevi+Wccvq/MfA7EaDCqjH7HeMEXwEf8vQp9uJHOglwg1eRrOP+6Yzi7Y?=
 =?us-ascii?Q?Qnc1YRRT+9AQfw7mGsSglXppTDmG0DRNGOO1IeHEURUwqO+i2x/F9hwbNrgu?=
 =?us-ascii?Q?p40KejFJvUUnQmKkBtP7e04SvI+847c/SFO7FXM9KJOIiYBAhi+CPNkMwh8b?=
 =?us-ascii?Q?V+BoYhaPJr9yLVw/MeUQnOuUb+w7gZfuWG5+0VMbcD34JenGZMQp3SuWEF7n?=
 =?us-ascii?Q?ay3qWoVrajUalXWYHj0+fymiZZY7BNgcUsNxlYqrn+NmsSaJnx59PtaCfLZn?=
 =?us-ascii?Q?fIDQafhkBDAR2P1ZQAAkpQo4RP3sLEV1eA1fKCnWlsHE+b9kO/NETRvgx3XA?=
 =?us-ascii?Q?i+kYfkThuix9/wExCiiVAdkPFchYDke+sk6pk92js2NLEYalz7N4e+gs7Zvd?=
 =?us-ascii?Q?wRiiMmErPG4CerqLS9Z61IEoRCXVqMfIg9JDVLiyYgq1BpQ1lr1RzswT9Oz9?=
 =?us-ascii?Q?tI7vIKcbJM8KzqnrDTn60ropUgq9qxQIKrlUBWXjo5GWafizQds9VjQO9kRt?=
 =?us-ascii?Q?ZRG5ZudGHKoQHXHllhbZE7b0okw4Fc/kXhKe50YCpBwV2Xv4DF9r9r661ISR?=
 =?us-ascii?Q?0+wPjxAYWLKcCmR31v9eadHdtS+h/lnbIe1AOXp9SRiMXywKHGhHj4U/Dd82?=
 =?us-ascii?Q?nLT1mfhOOi4QAdqPgTeelhrhbL0WQn+TQHvrqjtURLmQg5dFuOP6mA5FOPQ/?=
 =?us-ascii?Q?eP9P/loUAyk+xUXYkUooaKGHrDNZc0vYsYXFyvI17jjOEkh/IRpYSdDlkoZ8?=
 =?us-ascii?Q?8w27OY422oKRi5kuu6OA8c8ADc561f+x7/WUcZxLsFhp/AwPSFsbZ8f7jpkS?=
 =?us-ascii?Q?mUVFzQR7foRxnr0uZ3MeK2UFAtIklEHmX8Hvx/yznSPAcuFPOAszaxOzDYtA?=
 =?us-ascii?Q?JIM7x/1Dtd+ZBHgOeCefWTfh9+j05mmX/AIKKqXiGX2WJhnawSDrsD6qQu79?=
 =?us-ascii?Q?Hzdr2Lj8RcjrlxFczghkzMmd+OOPa2ui3UMKBXBSa/Ce3swQAUpcIYrfDmEI?=
 =?us-ascii?Q?PC3iUBEsu3X7eMIgWA2xcyAFMmRu1ygmy66FZPMPbJawUWcNYMHKN8vmR7m7?=
 =?us-ascii?Q?XOuiA8eNElakaXuC70UucJ8sG3vfIL8GSWhYZICYaK0RvlNibPdHH9hiOUwm?=
 =?us-ascii?Q?bbLnscXdxklyAeKwr4ZKlnNNdEW6r2MuRt4UWeR/0oJPJVtVLVIXg/M+IFa+?=
 =?us-ascii?Q?yWyu293RwBQXgnEygBqf+R4dzBBy+T/4lkLzc2mmMoFui8kRSG/cmGUmeigv?=
 =?us-ascii?Q?1BCUz5Ea91QXPj03Qw8QnrKbPPBtGjbhQ5nlSKgI198r/uH9OcGrhW0xlUv+?=
 =?us-ascii?Q?9bktHZFainzEcphEITLiFz6oflwUtrXGAd3wYnszkqu3UnyeKXfg8D3QFYNu?=
 =?us-ascii?Q?4B2/BZOcx3SsLU5sJ5jAJojTBYbrIbBhfjFIKsGLZRgqdGm35h8XR8Q0Q4Bg?=
 =?us-ascii?Q?GaTgk8UtIah4iMbJL+i6qEe24OdiW5p834LlFKs/4iKeKCfqoN+ufZ1hyJjs?=
 =?us-ascii?Q?acHO5HuMdrR2RjUM/W7cuP8dgcjpKVQDxsxss4FOJNbyBoDmKVXuS0XANxDa?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jKSfB/P0DBM+xhjSiO165IKEfJJIoGHDfyyffjJRKupetw2dPI18Hw0LiE7dmlZxIlAX4ogNfg+C4nr2KMaZ/0cuIYDmv3cUuHvHPZkmQ2HM38kWil6wrKBlo5hNxDc7QW/rECI8T9R5V6zjTupEX+vQcuOlqjye9PRHlvVpLNCKPGncGE7IS04By6p0Pujwp5cWw8g63xJKs23uDtmrWZ9mOzpD5SheIBlWoEqQHPB2Fa0qbFTdFoHQr4Z46gV7D+eE878USyxQ+0ooWwAqeHlwQ1otcGPKBed45SvGs9tSfBvmJla8MikGViIyaEh18Jp2oERxdGmWaM+Bs1YBNWdtO9cWDUEp9O3M3Dzv0rGzk3Gtu6TKiLzzid7OYy1SIPMgehodmNhErVK3k2u1So0+wx9F2t3C0c8Aj5J9tlYVaTEzzjr4itvgMFrgqTmJ9ldjJO4sTY7m0QDf7eY4wN8EewZzDUDXGtIzvkEgu3mxvbBx9CmZ52souyFtqnvXzLWlw/A9Zmat7Q36btniaKUdwv9jYYIs04WWKcBgVU/ah4PzjXtihI4fHUJyrIokR4kaR6FTpyiXP7TgdQ+AjUvzm95tJZVtM+Yq77bgTZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbcbcb7-f9e7-4422-29cf-08dce14f1615
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:54:57.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/PrWyxL7ViTm6YqD0xCz8WsZ8VGX5mIAizIrPVn5W/r+kHR/YfyUNCk3lDw90xJQkb2rVwjVIZAcyKyUP8tcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300093
X-Proofpoint-GUID: XflJs80bZOPsT12w2lxigMxFMSAka-1y
X-Proofpoint-ORIG-GUID: XflJs80bZOPsT12w2lxigMxFMSAka-1y

Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
flag set.

Initially FSes (XFS) should only support writing a single FS block
atomically.

As with any atomic write, we should produce a single bio which covers the
complete write length.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Maybe we should also enforce that a mapping is in written state, as it
avoids issues later with forcealign and writing mappings which cover
multiple extents in different written/unwritten state.

 fs/iomap/direct-io.c  | 26 +++++++++++++++++++++++---
 fs/iomap/trace.h      |  3 ++-
 include/linux/iomap.h |  1 +
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f637aa0706a3..9401c05cd2c0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	loff_t length = iomap_length(iter);
+	const loff_t length = iomap_length(iter);
+	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	if (atomic && (length != fs_block_size))
+		return -EINVAL;
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -382,7 +388,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -415,6 +421,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (atomic && n != length) {
+			/*
+			 * This bio should have covered the complete length,
+			 * which it doesn't, so error. We may need to zero out
+			 * the tail (complete FS block), similar to when
+			 * bio_iov_iter_get_pages() returns an error, above.
+			 */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto zero_tail;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -598,6 +615,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iomi.flags |= IOMAP_ATOMIC;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae..c7644bdcfca3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


