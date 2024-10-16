Return-Path: <linux-fsdevel+bounces-32094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B59A0686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51012B264A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FD207A39;
	Wed, 16 Oct 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inMiyFRi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R3T7EMBw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CE2076D2;
	Wed, 16 Oct 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073059; cv=fail; b=fQiu+56I9x9CW1mIcJWInlpfBucDgERKzmUla5+Rw3trtAXCmIOQAzeWbFU98I8u5XIAXwQndzGX7bfxGQllXK4AswsrfsAfOxOwpmk0aBntdIlhvJIcpjheqjiDqkMfR7BUOIe6BVyR+Cwgorz+UNYqZBeD0eOxVFxm+QlycIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073059; c=relaxed/simple;
	bh=MXdRBkt9h4k25bBTYZJkua5Ybydsg5IdV4X7V2w97IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQAHNyvmVn6nW/PrAqe137iDhJCwKL+WDkhOu+01Mzobfk4VwXy4jvYOulaNiCizr9r+QnA4Jh+tRe0FCBgWO/4ZzYPSVVDKJcqEAShFscABmM6c3TKQkyHHUjU1D/eVSnnx04UH8qHHmZwqDHZEx03B+g9bkh4wyaLiuGIusQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inMiyFRi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R3T7EMBw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tesu008711;
	Wed, 16 Oct 2024 10:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tf4u8+QC/LEyz3zn6cGEP9PhoikUK4o8XoflYwEC1ys=; b=
	inMiyFRiD5NrLIZLkgJ8cXu6QwxHfxTWoheqqwWu2+8KMyvhf4ssvA3wR/DBr7T6
	7yXybDU+iKCtJXuRMb65asEpzeHA86tAaLORi345Lvmjky3T/CRntz3JgtnEbtUO
	gEDPwTDWc0CxOuMnhRH2VBExsk9lkrVxfcLziPy0ORF029+3Yxjc2zi1Alqpohhy
	ysz70IRWzg3eIrkdYI+gpIC6/UItoSYesL/doTWpCRQK7btx99uLQn7+VU+puJMB
	72xrhBMtDnfd+yc4mfiTFQBAjuoO4r6mxd4QMRRWwcLXkCjVpaPK3/zZN+/CH1LE
	JRSRPXZpkbrPBEzNPiUv4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09jv3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:04:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9xbO3026283;
	Wed, 16 Oct 2024 10:04:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8mhss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhP1CK7aur2TD7L2Zfk1vS4W8TYws/R44htLIvpdb1XE8DElhKH5n8MnFr8YTPngKS9/By3NoyzTACEfgOm4WZHllnmiB+e2s34FaKhCNOpZY3z3CA3yoV3KwP9V9b07aDUNiQY4oT+LWqtTuvI6yo2sYciqipDM5g8IbkgkBLIastKMT2smZkg2Umr5D2nzHt9tjXcrBQFWBxbY7GVPyYxGw2xUhs8Z2F5jXZ0WkSkgTGbtJhCrLeQZiklOUxkQabICu+rt2sSET8Ixcenu3bdp6RVnEW+qnsI3w+a8P7/DZkVCSfcgoYu00SBTpSOWKw6i9Rlm5BuzUSb+kKuGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf4u8+QC/LEyz3zn6cGEP9PhoikUK4o8XoflYwEC1ys=;
 b=O88UPvq9fkBPRJ8hzyIndNebIwiDoyF6as8k9dMCjlPmqFI95kCqlXE+ON5FvioOyitL5Hjr8gO87vXEG8yXf/w6V2gygGVS9eLo1i0zqa6WBey6FzyD4KpTlLpiINCNsgT4lR92QKnx1ZhDwYr7mgItPSTh4ZJkUmBBPVtydvcC2iAXwK6qyoRGvjxo6PHn1g3N97BJ+jl7b/lmSql1HdlGKr9qxd5UsX7QljPQS0nlWb5/PQS8QaCtVvzxBTcDX+CeNYxUeo06j93GrGsb9cYGnTUlZyQfQ4+eQHjdqUoT1tCwgVyzMi4F4pb7drNP4ZkM2HGt+DcYntukSzdAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf4u8+QC/LEyz3zn6cGEP9PhoikUK4o8XoflYwEC1ys=;
 b=R3T7EMBwxnWgEmRqTu7I3RJcENS5+aK+EqPPfTMHyvlPc5MH5iHEnEYtdUNU6+Qh1CvjUfkR1VXXGRk+H7ODYXzn1WJSnsRBSZLp65j5LBOJ7yf/eaKliZDFYyo5HWFFuRcJSaHy9yyut7kXXuBn6/+gXcGZdJ1bG4b+Yl5L+HA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 7/8] xfs: Validate atomic writes
Date: Wed, 16 Oct 2024 10:03:24 +0000
Message-Id: <20241016100325.3534494-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: dd159a0f-1093-4cd3-3fb2-08dcedc9da63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LPXFMhGlJ5Ic37uU0finfHiPTQnErR+frXtP4gJ5x6VlHdGz9tGoQfGxT0gw?=
 =?us-ascii?Q?uma8SwgLS5KVzzV8Ygxj4C2cjLIGJn5OnCKlhRCzCUDa3PcuXywC+LXb8PFN?=
 =?us-ascii?Q?tRiew6L4pgiJiJ2p+otMdmyzSgfzlsMgeYIkh+s8PviW/TrYiwqskDCKIx5n?=
 =?us-ascii?Q?Kd5BCXD3M3021VzR1np0pZ72mn+YM/d2ssLWBYOFfSCGY8NcXhT83lLRLJcB?=
 =?us-ascii?Q?lRXSrtC7PMOdjs1IpJjcKDdkglg7+NVAXGz65T5aFewdLapC1VwgEFP627/t?=
 =?us-ascii?Q?XnDIDMdA25uzzwGVENj7b4OgRrh6Nf9iLqVKkJs7IuiYjQfY1HGuKyPhYVX1?=
 =?us-ascii?Q?2A66SAWaR8O4NEYRUg4WdV461eEQ3+nul9apCGdfDSlqbdTbCtDGzHBWcCMl?=
 =?us-ascii?Q?Tpc5wLwtfiG1/41uZuPpqkzwBf5bFrA7QKcjFvH/vDMtSV3T4OnmwJGD77bM?=
 =?us-ascii?Q?2M9rjoXx3lExVWPUH3vD6UFgi/4MFefzWE/lWsp7ZTqZBal4PXu4ntDIFKnu?=
 =?us-ascii?Q?Bz3KrvwTTN2w6PhamCz4PNfhuYL55LvpgQTExhuNLtIG3gg6s98S9EDAocOX?=
 =?us-ascii?Q?b8oQrekpGLBKYAna+LTAIbh2RoJz7Ia61BCRSagxQlVvn84nOWUSq4YxoB9R?=
 =?us-ascii?Q?dCVvwV4cesH8dlsipcJUrpEes6cS+/UO0gDY5VyrbADSkLq+sv/FMHMJLVTs?=
 =?us-ascii?Q?hD7DbqSVkTLffsQni6WZGptWzBTIl1DwGvRJZQkuN1QB3tszCsDjM0nann1X?=
 =?us-ascii?Q?B6QQPoNaNHWWDsuwOV8zFoQJZ4MjrWNP3fpfotVo/pCY+rHs4EF0taaItCKa?=
 =?us-ascii?Q?oz2hNHzfvhwkxVlIzOViudnVjcSylN3lyYd2mR3HXP/01h7baR1LqSCXHK/8?=
 =?us-ascii?Q?FcIRITdWjiDhCQijaXbNiWbSduq+VtT9oSOW2ARthdwf3jJLPJtzbkb/jFIU?=
 =?us-ascii?Q?9isBd4mOtUm+b5XfJWtwszy8nRxaBY6gmHLEBx6FLYljCA6UbNm4jZdz3yWX?=
 =?us-ascii?Q?18KI/z24Uo3ra5icv3u9K92B8fRo2bBLvG8rqdB67iWxImeAyJbsnZ5ciJBK?=
 =?us-ascii?Q?LFCpJhgl1XL5E/LfAD//hPiXCbukbl+791e9D66EkhaQvUA4iBIQ2gtFCk6H?=
 =?us-ascii?Q?bYmrPRrZlDmlLQ0PwBrIJSo/ojyedouU7biRAXrxKAYK/JPSW7ctMzqkke8o?=
 =?us-ascii?Q?TA5gHgTOHfHIm1q0QZTIFj6I6b+/yZ1S0hiA8E7yrgYLB3y/NyPiDvEcaGUy?=
 =?us-ascii?Q?Ys4gWglgXAGvEOIii4Nhsn4g71pNSBaKpWk5Q4s4Bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjGCc21Fz6Oi2AgaV/C5Uq0DxW8hJhmXf3u8EBJAoJLGBAJAsZgMvDiNO5kH?=
 =?us-ascii?Q?iCQdPqu2dpYTa5bHjJxpIzbKmEzi2rDAEJ3fS4UTkWIfjKljy0IRW+zrUxxL?=
 =?us-ascii?Q?uqGfvsS+TSyHLPREIrnedzVmWssoUL4n4vsUA5zGSq+A8n2ZqaNdlNWseZCV?=
 =?us-ascii?Q?fQJ0LQnftDoTiprZBho7+ZNJLgPE/z3woiTUJTXutCBNdoP/fqEpM+KfnEji?=
 =?us-ascii?Q?M9VTQtZ/yr1x1gM1MKSp4LcqFem9I2PXd1YC5mzRbhW+mncxrL2K7RRnANCo?=
 =?us-ascii?Q?qNmAHToECnx82Jdk5oO8HoubqI+UMXkmLZ7qSrd7JMjuj2ZAWL/E8e949hSo?=
 =?us-ascii?Q?LA2/nN4AU4Qx6c221cYladjk+9oq306e0t/VpYUPXqG01/GWscuK2KlbNTEf?=
 =?us-ascii?Q?FY/ZlVZA09ZBUUbWw/cU24YpXzrgc7zaZuhfSWwABTxrgGZHUJsg8gwibw6f?=
 =?us-ascii?Q?AQsVGY4dMFLE0Mrw1fja6f5zMLCvLD0sCUpkk8GH/kdWJkYjEV1/Qisr+Ur4?=
 =?us-ascii?Q?NypdNks1gJTEm4lZy6qEzbFRaJ3vpqdiW1P0AGgUUHDSiUhB8rWqK4yIyqu2?=
 =?us-ascii?Q?Z5wTbxB1soVjnJ5V0RgTrDxs1vz80OtChGTcnFDn5qEJaMAD0mBuW/garaI1?=
 =?us-ascii?Q?Xa2M4pvl0XfStzaAlSNTIX/TeDG0jd1Dad5RsGtTrKXoYvpoDTdU9Es2kSdZ?=
 =?us-ascii?Q?0BBNqM2Kd28tLjW8sQhRJ4RsIiVa1Fk+CcycSYusa4FEYV4ul2g6D/IXAO5r?=
 =?us-ascii?Q?gAmwSiq33Q2Uo43XxNdlVAxshVLYR8SDYC37UGA/pvN/sfFKQ58WsVJsK7Eo?=
 =?us-ascii?Q?NZcwe2buIWLD4G3wZvhCC3GRr88WhSbhkhmCdZ3eLx4te0lJscJb4MaX+FKX?=
 =?us-ascii?Q?mJGYoifWS4E4BVumx/C0fJO2QWW1JKOmKk1JUGam/81nMr4ZTeNuQ6SHFDG/?=
 =?us-ascii?Q?EvVuYmeTypFEC1VynEdgrRYIPZPSsJVMDjPhSVkJV3wSBIWE68RG+x/ZN34U?=
 =?us-ascii?Q?NapnmqYnfEXwO59ho16V+bzVgXRJHz3fd3dFVDtQG1ccUbt7o+v20gY9Ixaf?=
 =?us-ascii?Q?81kWAFN03KadsdwZ9y/u3+zWJbcsOSPw/ZF9sD/U2oTwBK2r+ENAual0fyWR?=
 =?us-ascii?Q?LLXBqxGzhpWElfX7bB5dDY48cXkttm1X1qjdfwDnLJztpkIh06MYDIdqz1Kc?=
 =?us-ascii?Q?Qu5EO/fDDuVJjgHCOoqpSKSXegg8Utn1x0DB5UR+WvIPsUPa2bEJPsBmUQID?=
 =?us-ascii?Q?GNNhqx5gzMCru+LTcYoqKpv9R98ddwMU3216sO3Z0iDhHdwoi0oKc39cAufv?=
 =?us-ascii?Q?cDfwaPoOwdrOsyWVySioKPbZk5atU0qB2BxRaM8UZYTusIKNwP6FkWYf6tuo?=
 =?us-ascii?Q?uXutBLEENkrER3XYJv/nA2av+OjujqVlGRyT2ManbBnOyIY1QbpEtYHIwMpb?=
 =?us-ascii?Q?HaK2e9Svoe8/zk3sseHooyAPFNMb4erJ8hWk2jIqUCUy9WgJc9no/T0PBRHu?=
 =?us-ascii?Q?0AE4el355+q86XPTHD4dZJDsF4suMWQX/q3AYJJ8jSgmcFFyRYuDPIF9ED5l?=
 =?us-ascii?Q?uglLF66t/1SnMFsGnwzTkjcac5Gg30p4pEK/8Fi2odarIc6u4zJWBoj0OZpj?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8NnoK0STg2PyOhW4vNHAch86OWXS+GofjycGzqUv8pLtmDayCCvaD0OFiLkaYoLiRMV+5oB1G9gylSAAq61rq+sEnc7efJlpIopIYr5DSGjKm5paiphH92MrgzU8hDWoKmiYa4Jcl69EKPfrew4pdlylQYqlt6D0/KMS5SMwAE+1XqKbZXd7aNUY6rZwZ7dnOqyMRqlAw32H8S7gxZf/5DwmMO6OaSj9BgkZ610rNZSuMQuchpxpX2Mya66NobHYLKi4Grs3qeBi0uRG22MOg5kCLX9KTDXKW4i4Ud0dqGlISOeEFHud/aYBuNo5gc/xAd5pk7re6ByzvSX8k9L72AlQRV+pfw6dZ3GpDbNFoiA028n2dwCGw+bt0/4Qa5Fp/M32gm/bH6a03RaMrSCHuCNr0fX6XwXFJCxSIHLkSpIZJLxY6BAHX4CUKOnige0zkmT1FdK4Pz+acxITWw5Eozv/KmsgTKokSYDjSwo/Aumv/tVTnuE0TJZs8qfac5WNCvl7Ny/WuaGRUwL6EhHJbKvVDtn7v1q0oV9BfoBu0ap5N8wMITIbHN17+OSnH8kAVO4QDtD4ZWb0MMwviT5QBom2NSDOU+yzbLu6J+sjYM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd159a0f-1093-4cd3-3fb2-08dcedc9da63
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:58.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLj1OMdSOSR1BW0wNwGYukjEE3L2XFowrVnk7m6dTGlWeDs/heW9B+M/p29WkcTL3SymToAQI8/B0bo9TWTvRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-GUID: kbDaolBxtCHRUq1tPgZQghRu2xZwbVFx
X-Proofpoint-ORIG-GUID: kbDaolBxtCHRUq1tPgZQghRu2xZwbVFx

Validate that an atomic write adheres to length/offset rules. Currently
we can only write a single FS block.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_write_iter(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
ATOMICWRITES flags would also need to be set for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b19916b11fd5..1ccbc1eb75c9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -852,6 +852,20 @@ xfs_file_write_iter(
 	if (IS_DAX(inode))
 		return xfs_file_dax_write(iocb, from);
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		/*
+		 * Currently only atomic writing of a single FS block is
+		 * supported. It would be possible to atomic write smaller than
+		 * a FS block, but there is no requirement to support this.
+		 * Note that iomap also does not support this yet.
+		 */
+		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+			return -EINVAL;
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
 		 * Allow a directio write to fall back to a buffered
-- 
2.31.1


