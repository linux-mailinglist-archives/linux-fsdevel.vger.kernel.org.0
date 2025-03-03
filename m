Return-Path: <linux-fsdevel+bounces-42983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80494A4C9A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AD81893EDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4AA25C700;
	Mon,  3 Mar 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+DtPf0f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jfrpEdJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D325BAD0;
	Mon,  3 Mar 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021941; cv=fail; b=dG9LNeykqzv+dzQpUOfdYROdBEFM1SN23ZprVOgpF4hMrvrdr8YdgeX7zdzR5aLZDle6BZfeJlLPOpksm47Ak6YtFH5QowmC4esyjGtVknuCD4ndE7mrPp4nmsUnfwHuMk8A35HOefE1eUt3i8LE2X/Rv4SMrEiG2FJH/7Ga6Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021941; c=relaxed/simple;
	bh=X6aItIDTNHMD6TStqCry6vNZ7gxH9G1tNVneMFOnSpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUzWHKcT1sAdIOHdTl+sOt8xzIzWmgqY1K6rQ5AiUhum7jHbN+jLniMQqC2loIuQKynR/Mw/bj7yK3AF2BfSaOtuckhX8HCQxQDnxknAuft6O2zTLNRCjcw8xktjUiSVbsy1FkU1wJqtuVi/cw1xJvyrFl8NYeqjeeWwTlCpuLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W+DtPf0f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jfrpEdJH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GAnN6022695;
	Mon, 3 Mar 2025 17:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XxXApDfz5ClCC/MC/45bon3RNS7G1xBAjBvohm+5nJI=; b=
	W+DtPf0f5PvKuJU7jJqGBHBBNHLKh+nsXVN8tkv7tiqG9D5L1kpYXwoxRKnNFXds
	e5vN6Iicxyl/WF1qB6t0GN65ii1AqLx+M2fJFfKHjensDCh3rVjk4eLVCeFB0X09
	Rf4qCyu7+0Y+lN6FBXc3bwat/hcHNLZE0UtAkzUolAfaVOAZ13q3DomU+hCfUa3O
	s31ftanNggo+yXZ0vCAxBWzPVrU1cjhwfVVugmH1AWPB5KeFNML7MsgJedquTJTw
	RAUbyzdoA7Pi6oYBaxbrCY8hx14txQZNGiRHyzf7QP2LdCJ7Uy3ATJYaozJMEAWr
	zIphonOuKJSinIM6jlcqYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hb6hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523H5el9021872;
	Mon, 3 Mar 2025 17:12:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwtrcpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyOQ/EhgI8JT4jWX+GNs+sDQwuTSrDkPVGDfWmOQGZkKf7GJXMueNV42Ir6EvPPHJ+93aytKf3YM2Q8w98pKKK3TXpfa9sD1pcoQDeP6PeAJFLsIUUylhUbbqcmA1R+a/aOudDeg4jobuCtFlmQ0OVgjsLBLeP9euG6dtfYCuFg8GHrmzLniJFjDhpLwb/ru2UNsdWLKD4YX2e1oyrKCcF2U9UWCpNhewHEL7rIfXDkvgG8x2OliwlitU8cDq7xWiyjVaUe45aWZF9UYGyJUfiN3vUB/JL8LAw2J1T8uRcu9KVE0jVodPcFMj6m9PpnpxT2l3EfUniU7X5hT05DNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxXApDfz5ClCC/MC/45bon3RNS7G1xBAjBvohm+5nJI=;
 b=oDY39XP0WJoN7JoHayPigiB2KDx5pfMs8zxpfwAiI/YZGfJ9T9T2HcErtFRUP/JmPQ7jOmqk/+jQjDNW89YJ66DhHez1Wbp/jmAfS0nm4o/cPagMjFoqCKI+4s+my8cggC3cfQGi0WR8Al1ckmoc5qYyc32qLCTuVBpU/wQbn+KvzsOOTCE2Z4cXDa7hHIhaCTaG2LuW8KWZ1j4s5qJgzeowGeifbNPSZvKFuQMJ6XpMIPyQhBEFY3MVWvVGlR7vwBQeNbFXQGd3uyCw1z5A3B8QnzI7FQcsntlHMTMUTDCp3tROz22LLawHWJTGAzYEmNGSCkFjBZhenmy6sKX8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxXApDfz5ClCC/MC/45bon3RNS7G1xBAjBvohm+5nJI=;
 b=jfrpEdJHFQjbMwh293jQ5++oqxFUg91R9eIIXb+T/cccc6psQARHvi4jWxQQKMJrXavltqUKIahHdGVVwG/zyEyhlam4yvL7WjX0wR5VVSXF8h9Mcafk8fdb39TTFPVSP2jGoAxRYE/dCdnL2s4ub8XZFa8Lxn7vf6tt1q2L6D4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:12:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:12:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 10/12] xfs: Commit CoW-based atomic writes atomically
Date: Mon,  3 Mar 2025 17:11:18 +0000
Message-Id: <20250303171120.2837067-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0494.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e56240-4d64-4980-8e78-08dd5a7686bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XqUAsJRcesGac42VC1KXD7xkOg+rSfM0xRhlkgPDIEI1Gd2mlLg4qYOLYyGC?=
 =?us-ascii?Q?6//5r0GCspqc5Hn7OEh3cKLLx7pNcSmLoi0M9QiUJ07oQ28VQJexe4UmJGjg?=
 =?us-ascii?Q?4R9GIe0ZzHejsUiIwoGr1Nzltw4++TNwd3Ip40ncFWec5r/TVf2szLA8IRUb?=
 =?us-ascii?Q?TZKx9IRp2VQ2L8bslGeJ65WFElLmcLpV19p0cmlv3b0vxGmj2zPOR8smdTjQ?=
 =?us-ascii?Q?Trq+O8jMRd71pabyLchg4CV8C3/Fs4O/12hIrdAZCafhNMbwj1FElIVOuav/?=
 =?us-ascii?Q?X8VERSNDTOwvMMxiBv5DSjvVjAHgUAX9lB6QKk0yUsFc0W1S2Qdea0v0sEq+?=
 =?us-ascii?Q?FZaSzv7MR5AuOoEJ2kvwC876yl+lgpw6pRuZgUL7TJQFElgihVckB4nRUGML?=
 =?us-ascii?Q?IDTYIOL6wlWqQkl7442mHdiApaEOaEhteC9QpZYbE4DAzxzyQdJsxAW5vDTW?=
 =?us-ascii?Q?DCk6FiVCmQdmQuvpTS9B4MsUpVBaJVXb2krd0M8nIdvydw4dVtFKp0mLJ/wB?=
 =?us-ascii?Q?57sli66gCSWqawVUYDR+yXueRuEA2/o9BTaqIiAjsfaBvVOYgQ4lm43nWrs5?=
 =?us-ascii?Q?xhTimo58QnWdFabaQuZu3oZIXwHZ5p5ghrd09o7z99fpOQkarAw1BzCcPyh+?=
 =?us-ascii?Q?26y7p1EWem6JIc17NoejnnQOQgBlix3EL7hbBKaS9608FMxhmfe31Cj8bv/X?=
 =?us-ascii?Q?S/Ps6NBg2wmi346KB9rqfojJcOHnlUNmcg37crWl51jBxtmw6Ps/FOIi18Tv?=
 =?us-ascii?Q?h//Sht7sdsCUHYaItk17WHHOw4zevVTmjcUHnichLbIlQocLXjUd63dBeh82?=
 =?us-ascii?Q?ogi3QkyZN0CEHz7+Kl5978vTrRN17tEnPwWzZgr5fArUkjQenmfJPIHntHIk?=
 =?us-ascii?Q?fXO/mjkKCt5Bu6V6NXNtCXnpXFIsDyCJ/Nl85N7MZQMfpP9jahpWNPg/Llj/?=
 =?us-ascii?Q?0bUU9ddZO86/U0fTac7cTb6zmLjt8Olj3jx+rYrybYJnXyTbQYuJjS1D97QN?=
 =?us-ascii?Q?DOzihNo29Z4AWrEdIWfMt/17JNiUS5KB1NBT8noZKeC5omcH4/2oivvQwvNT?=
 =?us-ascii?Q?0WQ0QhITMypRv0DTxldv/NQQJlmtrfwl1bTbyCO9wg0punX1iuOfxowKGLXb?=
 =?us-ascii?Q?5McWG1+bp22ilqmEIOlMemxHWtfoEBLnYnyhWvgQENNE0s83J93DLdLzYyJC?=
 =?us-ascii?Q?kv46OoP+jypPD8/1rPztegXY13KyMLeYqrXhDJxdVlaadALJRSE1lChA4CZ2?=
 =?us-ascii?Q?f+2o8Owg50dIOFGTW08/PLjVGRgxTwJR4Gt8Z5P9smaLaaq8W3QsbUcANsEb?=
 =?us-ascii?Q?UjKJJ59okci+5bpZO/aNs4bRAVhbeKV212UVCAJOTH2n+wjhK6P1cfDZi6p6?=
 =?us-ascii?Q?nK5txJnb0JwGQKZCK6NE2seLrHSZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOqX17l35BCm3LF4ugLdWSs6dQaUq6ZzzlZTgCvyj2cD1Ektv4vzlY+mBWTZ?=
 =?us-ascii?Q?sqWfqvqTAPTm9xbbgW1/2dkmsarM7k8V/fFP+wRu8m5kEo/WxZ7YpKJh1c/E?=
 =?us-ascii?Q?Sp6J9eVI2sv20lv3yL0nkx3vwqrUcTSfeSJzsZoQGGMmDBFU1ZbiCaviChNR?=
 =?us-ascii?Q?7qWW/Wmism40KmL8EINCyhqnHNYhqKAHGvk+VsFSLODjKSANnEaaUHbDDsSR?=
 =?us-ascii?Q?P1kMMgiTxF5E6VK4VfVyX1y9ist3EdYn0AhhILYwVebxsPAI3LiH21YOJZ3F?=
 =?us-ascii?Q?oO1+TXUNDHqJ88aHtipj8HGjbOlcr3I9S5QfSXMVoNESaiJFdB8d4wUtep9h?=
 =?us-ascii?Q?Fo4dSJTmV6QgtoXKEd0OurAcTifO+DTvno6yzFrJQn/FmPQY13OfqcbBJj1v?=
 =?us-ascii?Q?c9eXsafYEfBfM36bNZFwa1Y/64uSn2NZhj8jhFlfTUVpJKlrzMK45IQp8Hul?=
 =?us-ascii?Q?jKwG+BM2skUsLpR6K4ek7AavCB9eEQNPrk+XOYs9GC3AM7UXfMk0d+teORqY?=
 =?us-ascii?Q?PAx87SPKwNjUvpHvoajtf6LfT380JFuL+hSsDySmTEa05N2KTeu4VfNMnJv7?=
 =?us-ascii?Q?Z8yAAFuPUebpwLPZqFBxWD3Swm+dkngONAAJOoE8ihS1VZ8SChySGpjpjWla?=
 =?us-ascii?Q?x27vCBtkUKi8OB9h6XZDOECE0Ng/Ss29FuaU0e3988HHl6pUSIuAdktt6RPT?=
 =?us-ascii?Q?e1A2r9nnPGMjMjgbQRPwnN9BKYpkTzBCzN5JDTj9sbgUcFoaX0ooCyp4GGoQ?=
 =?us-ascii?Q?HumrhlQHcepvQOQbpwR5oisF4F3TtALAznxaXxRAZSJp3hkrUBCazNVl6Sow?=
 =?us-ascii?Q?kqnQXsG1k9oS5yMtE/sP+jE4VsblfVMlrUIydMvSO1yIb1kgx5rKvgqsmuG6?=
 =?us-ascii?Q?JSgDd1pzHlEVSiBGm+KDt22tpVkxvywCGpbsyLP2InwpaoMMYmvxVY0we5fi?=
 =?us-ascii?Q?w5+oi6iNi5Xvsj+tnWL+BXf1Q3r3JkWFsxXP07uPGGqrV22nn49yUXC7XJNz?=
 =?us-ascii?Q?Eyq+wenSquFi8/xidMBYwDuY3mFvv97KnkDwXJ939v1EHzHPdXjgYyjmITK7?=
 =?us-ascii?Q?j9EznILIMLBu7ggOJ6HrzlLRMN2x6dU+41qh/DfiRbM5yw+jsnEH2COLtJKk?=
 =?us-ascii?Q?0Y4CZqI8TrGPO2sEyh10+8vw9SVf8aQx94DWPiWryjeigfVz4L/6Qosk50SN?=
 =?us-ascii?Q?YeUfpOVEYfJIU1XoIYqWnTDtve5ENxp5mxo7ZCCUvAnwdLxk1HY/MlI0aBYe?=
 =?us-ascii?Q?hkvOpQdUd7IEI/wjbCcTHBdx4vIREo5wA7jdG/BYw75zlQwnk7aZ+dJtD1tS?=
 =?us-ascii?Q?O/B6LR3/052k1ZI5YB7bA50im3wXVTjjeKGO2d3XqzFkMsOJJfwzYkL+ES0r?=
 =?us-ascii?Q?74wYwWYK+VYBAurgLnNtJKHyl3Yd6cS9PAYwrJCAHnFzK90pOF3O5Pjp+wnc?=
 =?us-ascii?Q?bQMG5Bz/Pys6Xq61CMBrqy04fuvJ39n8mXomtfl3QWWHrLBfWkt80FIodP7h?=
 =?us-ascii?Q?B9g2VaJ5hGfxW6A7N/y5KupwAJ7eEUPvtLrwdShh2ByPK/ZSHNcMY795ViS9?=
 =?us-ascii?Q?KkHhSySivfv5D9yao0SiWtvM+M3/JnH8rPkZM5iY2KU08b3T7YyNJz5haC0O?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9XY6Txlga7Gm9rWuz45lkLDVHKB6sWbNx76wtwnKzNJxM+9xLoCUM2rJX3S8rmBpXqfNU6Bw87yNlMtAcXRqKQyCYmDx+9XwdDU+/y6mQIjrVOqnl5oqg8AbE2eDlS3rgP6liKhKzNlu3EAx/QO7/HrON4RCLtBITTvGqrrhxeIWgxdoe/klLNWvFTWiGp/GvO8C6q8Mr5j/jJ4jcccQ/YX3lQ/UEHy+wQseTLw6rzpBG5kmq46QosLfw6BqjPt+N52gWKxdlU92njQPeERvkXRP9LwrcmlATGTDs7zj7stC5BRvHwezshlH3MOBv36G2q7KBGylh6c9z45aiPcwFLtF+To3EFS8HHl7dEqHVG2jwjXrtCzgYUrjLI2273Zu3bZntKfq5GWnOBpX4yOBngm4/MTt6Iruv3iiGqVyVchKOX1HUEZXYLrq+LWOjU89/lOLTztOnQMhi+XuzNGUnOvAGmnwiDBRi8dOSDVXSZsFyDMYPU3IWP0O7vDW63K0mdfmsGtcJeIA8hjsSjbNJ8GfwSFqt50Z+laFW2Kx19lK1vPDOzz60FN2jm1+vocRfZUJYdoXPQ4WgFlrTm18zxJQBbTQD4w2Y7vtUeC7bRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e56240-4d64-4980-8e78-08dd5a7686bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:12:07.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZI8HCJdAO48kGaV508LjhMYzQ/AICu51JzRj7FcUVS5THsKfHJYMgVS9hcX2s2gyI/meMRxs7W0t76qW5EquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503030131
X-Proofpoint-GUID: RJCdgmzwVcNgtlBcDsdSUvxBlGhJi8ra
X-Proofpoint-ORIG-GUID: RJCdgmzwVcNgtlBcDsdSUvxBlGhJi8ra

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 ++++-
 fs/xfs/xfs_reflink.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  3 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 70eb6928cf63..74806c8c004e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -527,7 +527,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 97dc38841063..844e2b43357b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -987,6 +987,55 @@ xfs_reflink_end_cow(
 		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
 	return error;
 }
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
 
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index dfd94e51e2b4..4cb2ee53cd8d 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -49,6 +49,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+		int
+xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


