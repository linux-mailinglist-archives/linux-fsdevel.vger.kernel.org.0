Return-Path: <linux-fsdevel+bounces-20134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A141F8CEA74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE9AB2101D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC486214D;
	Fri, 24 May 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQ2B6ajJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZkCgNSsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E18405D8;
	Fri, 24 May 2024 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580094; cv=fail; b=r0SKFswUeGAxuakc1d/tfMAzxdT6W7qtSfeb8mdgAue1AYuCj81USilVDyz1VbiMUfsTZD/jV1QtrPfu4/j5dMAx8kB8T3Ed7PvnXoa71bk3OrZeWVkWzax/vgm4pcG5WEgeu9uAQs9pJVh7Nore3RllHyrVo4zY4mSxL58KY74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580094; c=relaxed/simple;
	bh=1/2nX8Rh7ynsdf/T4LLj3Oxvpx6GoPCmaE3FKZ+8iBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U0JXuVSk3M3ZJ/TqDB9sYtaNn61EOzfMaQtmUx+gV9WajYzm9QHtQWnKE0ZbzAOfKD9wC3xJBt87X6NNo6+20JA1ysbAJk6SeC8dRByrb5A9+h7m4ax+ZiH/VvR300Dqk9l12CfXyqYbSjj0B1uf3dzG8/ZfY8SWpBhQkGLyBaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQ2B6ajJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZkCgNSsP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OFxjW6015807;
	Fri, 24 May 2024 19:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=UDkfchUPvq6tCcG5gnRJN8JuRa4ol6nNDtNxhnhMoHs=;
 b=BQ2B6ajJTI+imWCkxHb11wXNJ5MCN7Ajj0c1MkLX9nJvPZas5n4yzvcFA7YM1p4KwqcS
 +/Z+x+QsIKX93x0hNa1snkF3bGacD/1r4t7cJmgp/FuDu2A0k6j88HFe+Sg6HfXlw0fA
 Qns4U5BQYXr6loL/aoJpL0fAw82QZMKSG5x5rLT7wqC6NjdXKd4VPVDuaYET7X7r45AL
 6aYtIm88OspWP62sfsS3/pVptf9i+vwr7/oejZE+VR7cLRypCb1HqfivjWGdYzqd2PRD
 3vN1/ukf0avCNkoAdXx5OgEUrARIEqQAZ5ihg58c/LhtlxuRoSB0Dg4jkRLpRkJ7ZBO7 bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8dd749-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 19:48:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OHk7i6002776;
	Fri, 24 May 2024 19:47:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsc9hq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 19:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoTTxizRAUs4yks44pRl1xxAGpTZLYQOCF2MH+ryX4N0InPjWluLpMPDp9ntVDf5PIplt3fU7PVUxZ8x98IxyapLo07z6aL3AYI7EkJYVbvciaO+LSERzmFzXOQEDa8RJv9tdhFIsb/bhLxE5E9ib+Q6ZzDDwJ9LEggdBwbFTR6iZBSb43qWPgMOtvuGZp5IHXAuu6ABppDxI8WnN1p4x4TWlN7rDHfMSMWYbLivz94o/TtpVodtQajOh8Tualsx9rvA+PSGBd96CCzJlXOc9+aVHTnSPX3wqlBmZydzqeVo6m82uLnQHUBLBGvKq122VfQv3tlO0l6rkQwPLmocIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDkfchUPvq6tCcG5gnRJN8JuRa4ol6nNDtNxhnhMoHs=;
 b=UOOBjLwTZFThSgvoXWNfEoG0HSjIYFvHJ9/3LXAaAgPYgGQoGoQfC3h+epzYAJrONEfWEG1wsgXnTBiuvwwSPmzFVe9imzzO1XG3iVV4a4tj47GSV7a8tw2DT+ZXlLv67BbMYNVvExgPEJRCzZUyEs6015tfWUcHYIGaoUPsbXZk2n0q6v+LKJ8Rldmt9c3C/Z6APtTP5keqz/4wml9RyNoeSXnEZGvhjV7D1om1mijEDrBYsP77pG+Weq6VwSBUZkuYJQtmsP5gaWWLCyaS96icln6kYDUH4NoV9R58KlpuMxQ7R5E2T7O2JtYV4127RXsSjjOcvKOTE42G2zCGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDkfchUPvq6tCcG5gnRJN8JuRa4ol6nNDtNxhnhMoHs=;
 b=ZkCgNSsPNfjSQ+eds+rP5oHHpd35aMg8wBMPtIVPCcZ+HYp5rvfYdrYgyUfaCwDMFV8LLn1Yz1kRgOiBQyecT6OVaew082aIRwjvgIoS92/W8D5ou4xMnZx6y5iNNlYgFPyrhcnuGDINDJ7O0GNB1/8Zvc5P6oYMFDfXwDmUiOY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 19:47:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 19:47:57 +0000
Date: Fri, 24 May 2024 15:47:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
        surenb@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
Message-ID: <eciqv22jtpw6uveqih3jarjqulm5g3nxhlec5ytk2pltlltxnw@47agja2den2b>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	surenb@google.com, rppt@kernel.org
References: <20240524041032.1048094-1-andrii@kernel.org>
 <20240524041032.1048094-5-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524041032.1048094-5-andrii@kernel.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd20e36-7e66-4db3-97ee-08dc7c2a6909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?unclG7a8ECgFmEpcb4bDZcRxHgfULoRRBis0bG1Fq/GQxVNSuAQqkcAMQz2j?=
 =?us-ascii?Q?2mRSgzC8Q0trTzqZMPXcy3hK4t4D/OAUbnm6OEVR1K3HC6hGwDNvXJZtUSJN?=
 =?us-ascii?Q?KDyHqV8vfhoB5BR6m4Yp+I6Elws77dV9f9sS0qaMwt1kNFzzbpmbL8Lnwxe9?=
 =?us-ascii?Q?+EbIzeYmNuSu2XhgBYHiVOo6Ptv/gPBndiFPLu6/1BUCRTqOzwnry1OkZw96?=
 =?us-ascii?Q?aE1nbIwyjluOiFbMxiodSgEyCByRVEw6+fA8tCusF3KeJ3AzCmpOvgbJf7VF?=
 =?us-ascii?Q?PRfsSdfsNJMfthc7cet4+jL8+b8pRWHM4DHHI5mUnbBEM4+NTYVFbP8YWc+E?=
 =?us-ascii?Q?92U/vDgF3gAAGMB9Fwvn+uZTjAclqyTA2rMCMxOWHlYQWFrSxo3188MfA/fD?=
 =?us-ascii?Q?A2AIlwg2Goq4uXLlXDNS12weJ4AZ91mvAZRVDkNBhvvhUOTF8mg31L1Wp/Cp?=
 =?us-ascii?Q?Ao4wxIjc3bH9lo6qnnYGOrOxCXGeFEgh8i2QYKeFfvQIp6vxunT86fsZei2W?=
 =?us-ascii?Q?THiCnIeYacu3zjGZTJnMWOIsSucpLBAzGipglr//9FT8hk019VukkNFp98gW?=
 =?us-ascii?Q?PuXk29SVVXw9Flo/wNmiFW3584QWK31hyYV4kWQvIWb1bCvZwVnbHx+7gH5N?=
 =?us-ascii?Q?9S/5LrfgBApbYOdljEAiVXEE0bHdTUnXJlgEQcYoEsjjNVNW6NVG9dYq6KrR?=
 =?us-ascii?Q?y3aR+9bBtvQEW5zQSX5TT66pB0qEByfNliTGiWgd4vx0UeBMy10UKqWsSvIJ?=
 =?us-ascii?Q?gGrACXcO7EXZxWV+X5B0rCbdCTP7LKuCiVZ0h1T44mfhkWZ3ucgxJj1ZBwfP?=
 =?us-ascii?Q?x3bdPoWu4q58hb82iyW+bWP+nh6gIfAmitoRjD3SR2cEvTuTe95WAH3inM2b?=
 =?us-ascii?Q?WMKo2M5o4nHTsg+MQ5yzMCjB6dRtGJoLUIpfiWEKgp+rcbFUjy5l3jfgVTx7?=
 =?us-ascii?Q?Fzd3I+DUllaSCoJ98bHn7x3Af9jXSNXAARZUeaaFw8py5shv9NGTWAT4+WLj?=
 =?us-ascii?Q?WRjKHmGvwHEvBcWaJBlDLfrwjntA9gTFYVZ7lY9mFgODW3qh95iKA3vLOND1?=
 =?us-ascii?Q?PuQZROjkVrRc2jqLBqkGcVF7y6Ep7I47qLyh2ZyZfPeS0e1UYAdA6OdXV5+7?=
 =?us-ascii?Q?6qCE7xptItnaxViShFWvHmOCZsJFV+Z4teCZMESBJ9HJGYm9NItZbE6mCdmC?=
 =?us-ascii?Q?uxYPKaiSgihYD6FdqJ9rQjb4z2ZOpI+wz1ba6LuEFphLSi0UVK0rhi3kxBA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Elny6J+ub8maRPvqLBanPrCj7OTDVuwzA2BZSJRNYRMRYxozQwvMIRj0ogUj?=
 =?us-ascii?Q?iBojQiZXceeMtc3dc0S4RDDxEXn0EtnDiFrgdaISGPsxTHpYrkvgdRw22Q1v?=
 =?us-ascii?Q?KIWeMM4YSDWW37SIQUi8DtyZHIawJidc8H+kiCFOp7nZ+SJ9TC+iF/XrAmpQ?=
 =?us-ascii?Q?X0EJOiPOXMKw+HVzeFpG3M5uSkfUr3YeTsWfaThmjLgwqCA5Dgit2unylG7H?=
 =?us-ascii?Q?tfIB048bhQJ5dxoywoSymNAqWsgPwY5zBj21W7Q6y7U14vZu2ORqpPUeinVe?=
 =?us-ascii?Q?d0RIT0Lm2au3vKkKiqLg2AlbT4qpNUFmfYSqJUYAI4ltVcrmdQQSpl/Y25zm?=
 =?us-ascii?Q?midnad5BRunjwkQYgoTxLoZcWYQVxy6MBAGO5Z62JXcMZeqyvkoXSoXK5f1R?=
 =?us-ascii?Q?gyjIPmYnQdCnKDT/n5055DkEei2QfDsksxoHy+quFH0TKnUCSfcjGE4ECga1?=
 =?us-ascii?Q?NFXq5e5Df7AM1C5mYS6NvBaRZzdd7URu6cQ9pouf7//5eGDk2BTIM3rWHjQe?=
 =?us-ascii?Q?QcK2iGWs/VP4fhU4t0kAi8jWxPLNTHwR9tWWN/66wEn+owYqVmXSYE9PXUGB?=
 =?us-ascii?Q?CaJ/dADtzx/vhaIuXR7vx3zqzis1eUzHLOyOT/XlfAk5Q6/hdDzrR0/nGh1i?=
 =?us-ascii?Q?Cn+xiLFXlh/w27LFTEKPeB4THGaIS8ze6rgFhiGKkx5n1QJFfAPSE4InKSDF?=
 =?us-ascii?Q?AkryGOMTGnTVbEV67bOdxX1sSbhijS9yuKl6QdK7R3nddYTe2dJl3YzrEQO+?=
 =?us-ascii?Q?JCW/2v2EkHRo3Awf0kLbPhfogT03mcD3IsG/ZhEr889GCf7jxwIytiM6szF5?=
 =?us-ascii?Q?4LdwmPOyX1ygyRi5d4vwp8aTwDZ61ytZQ7MepvsSz9fT3PT6mo+FK7eQnVkf?=
 =?us-ascii?Q?Y5MyZtDunpjLG05Z7bYDGcLSpHr9jVqzzbKed4KLNWx/eq1FnXH0x6PYZIU0?=
 =?us-ascii?Q?+aSuuDnarkF2dPLW4wBq7l+tmugpJBfQQfDw6A2ZvelMNg8CeN4dsNFMgQ4R?=
 =?us-ascii?Q?Ngv01vgHJUm2I5VhKLSqRM3QX2zR4cdJQQvtA53L0WpClX+HJ+bPWMZV7RH9?=
 =?us-ascii?Q?kXHypaUW8v/ob57WUaA9hya3bggYgspnDh4MEmEzQNjCebtxbsvVMqSfpcio?=
 =?us-ascii?Q?rZvp/35PHO/ZBl6aYu7Zt+5ZD1EqwfBTwklFIbU31dPc5Azohz+aw//Q++96?=
 =?us-ascii?Q?lsOorpLC9iHB+FzJAaxtXDvmQoIL+z7s6XcNzYwfUZi7D0otEDQmF9wx+93m?=
 =?us-ascii?Q?ytV3NF9EdciH88avEAu2W89CimYjwkfmXwOvojYSv4YNmTKro828883OHaMQ?=
 =?us-ascii?Q?+6szpXk3OVQAXFvodixXxs28aKev5sjX3yOVXGCoDVGjqfrYNelyOIeIFM3f?=
 =?us-ascii?Q?5U8tyMqYvyNwDljqvB5Is5lF7J79EgpZLml2wjG7ZyrxshgTYwm7FVFcte+v?=
 =?us-ascii?Q?vZPZPxhieIYe9c0otS8qHj2HSqtScspdPj6Z9C4nPrSeSYkWRS+lU2QbiOXY?=
 =?us-ascii?Q?TJiYFIvM0+948PCy3m9bxtB/BAVE/Rh9XrKgbhWRJbLdpPXGRYn6cPE4MESA?=
 =?us-ascii?Q?gT4GyDsL5XJ0A2wQ/nS8Sus5pSJpq6Xzswb/0Yb0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3LZ3cCkw6e4ImEWC6JPKpRbqTO/H/7vFMyAZ4EznNuC5g73PTWk2guH+ZTsSGLI2nNVCCve2QvkBAHWyzU6vjQpHTm4ZkB/yw762XvGc+reK81PYE20L7h7zwbHmS2CRTCvD28KCazhvR6X2+yAsWKm84Cc29bONrHXtFhsWBTl1Ytc+6vr7A0PglMH6Y+HBNE96uYn3w98n1NItVXXARp3I7Ww+6wYpPfVRSlfx9xFGj69KIgUxlsejX0GKVtQeQBa1GoMy2XQgiwTSNrw6EPQDhtPDcrZk8Fs5RAk1OUUwPxtItq1InqapbiMEfyZnoNbTOpS1u/YM92HJN5pL5XC3IvpvFCcDjmCPAnEYkBjU3KhoVC1zjX2rlaaMS2poJgzilrtWYWPotrGaPDqOylUC6H3Q08Nd982nj/ZGiQPyk7IrqbT1l/5eg4vtB4AlnyWykzx0xG47gKQ7cln2uaBsGM5bCV+HZVZAFY1nCtWc+BB30Oa4Ny/IJrhteuaUJpUtRb9clnwJV1Z/W8NfwBCBKA1Q1ltAkWWxTn8rbYJhn2XTuRKHurPZVJbYZeFzq6XTkXi1ImtvSmrv4CX2EZqiz6smJW6wOZtW9PMiNGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd20e36-7e66-4db3-97ee-08dc7c2a6909
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 19:47:57.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9ZBQyrJ5fOguzZNBumcdIlsXQhQRsuldUT4HSJOg45h71JETL/tGiXuT+jWk7dnY5DYHFoZyR+qqODRMidfTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_06,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240141
X-Proofpoint-GUID: w3uL61oMjZN1wQjJx8Js0jPZPsckErqj
X-Proofpoint-ORIG-GUID: w3uL61oMjZN1wQjJx8Js0jPZPsckErqj

* Andrii Nakryiko <andrii@kernel.org> [240524 00:10]:
> Attempt to use RCU-protected per-VAM lock when looking up requested VMA
> as much as possible, only falling back to mmap_lock if per-VMA lock
> failed. This is done so that querying of VMAs doesn't interfere with
> other critical tasks, like page fault handling.
> 
> This has been suggested by mm folks, and we make use of a newly added
> internal API that works like find_vma(), but tries to use per-VMA lock.

Thanks for doing this.

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8ad547efd38d..2b14d06d1def 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -389,12 +389,30 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  )
>  
>  static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> -						 unsigned long addr, u32 flags)
> +						 unsigned long addr, u32 flags,
> +						 bool *mm_locked)
>  {
>  	struct vm_area_struct *vma;
> +	bool mmap_locked;
> +
> +	*mm_locked = mmap_locked = false;
>  
>  next_vma:
> -	vma = find_vma(mm, addr);
> +	if (!mmap_locked) {
> +		/* if we haven't yet acquired mmap_lock, try to use less disruptive per-VMA */
> +		vma = find_and_lock_vma_rcu(mm, addr);
> +		if (IS_ERR(vma)) {

There is a chance that find_and_lock_vma_rcu() will return NULL when
there should never be a NULL.

If you follow the MAP_FIXED call to mmap(), you'll land in map_region()
which does two operations: munmap(), then the mmap().  Since this was
behind a lock, it was fine.  Now that we're transitioning to rcu
readers, it's less ideal.  We have a race where we will see that gap.
In this implementation we may return NULL if the MAP_FIXED is at the end
of the address space.

It might also cause issues if we are searching for a specific address
and we will skip a VMA that is currently being inserted by MAP_FIXED.

The page fault handler doesn't have this issue as it looks for a
specific address then falls back to the lock if one is not found.

This problem needs to be fixed prior to shifting the existing proc maps
file to using rcu read locks as well.  We have a solution that isn't
upstream or on the ML, but is being tested and will go upstream.

> +			/* failed to take per-VMA lock, fallback to mmap_lock */
> +			if (mmap_read_lock_killable(mm))
> +				return ERR_PTR(-EINTR);
> +
> +			*mm_locked = mmap_locked = true;
> +			vma = find_vma(mm, addr);

If you lock the vma here then drop the mmap lock, then you should be
able to simplify the code by avoiding the passing of the mmap_locked
variable around.

It also means we don't need to do an unlokc_vma() call, which indicates
we are going to end the vma read but actually may be unlocking the mm.

This is exactly why I think we need a common pattern and infrastructure
to do this sort of walking.

Please have a look at userfaultfd patches here [1].  Note that
vma_start_read() cannot be used in the mmap_read_lock() critical
section.

> +		}
> +	} else {
> +		/* if we have mmap_lock, get through the search as fast as possible */
> +		vma = find_vma(mm, addr);

I think the only way we get here is if we are contending on the mmap
lock.  This is actually where we should try to avoid holding the lock?

> +	}
>  
>  	/* no VMA found */
>  	if (!vma)
> @@ -428,18 +446,25 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
>  skip_vma:
>  	/*
>  	 * If the user needs closest matching VMA, keep iterating.
> +	 * But before we proceed we might need to unlock current VMA.
>  	 */
>  	addr = vma->vm_end;
> +	if (!mmap_locked)
> +		vma_end_read(vma);
>  	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
>  		goto next_vma;
>  no_vma:
> -	mmap_read_unlock(mm);
> +	if (mmap_locked)
> +		mmap_read_unlock(mm);
>  	return ERR_PTR(-ENOENT);
>  }
>  
> -static void unlock_vma(struct vm_area_struct *vma)
> +static void unlock_vma(struct vm_area_struct *vma, bool mm_locked)

Confusing function name, since it may not be doing anything with the
vma lock.

>  {
> -	mmap_read_unlock(vma->vm_mm);
> +	if (mm_locked)
> +		mmap_read_unlock(vma->vm_mm);
> +	else
> +		vma_end_read(vma);
>  }
>  
>  static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> @@ -447,6 +472,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	struct procmap_query karg;
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
> +	bool mm_locked;
>  	const char *name = NULL;
>  	char *name_buf = NULL;
>  	__u64 usize;
> @@ -475,7 +501,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>  
> -	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
> +	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags, &mm_locked);
>  	if (IS_ERR(vma)) {
>  		mmput(mm);
>  		return PTR_ERR(vma);
> @@ -542,7 +568,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	}
>  
>  	/* unlock vma/mm_struct and put mm_struct before copying data to user */
> -	unlock_vma(vma);
> +	unlock_vma(vma, mm_locked);
>  	mmput(mm);
>  
>  	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
> @@ -558,7 +584,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	return 0;
>  
>  out:
> -	unlock_vma(vma);
> +	unlock_vma(vma, mm_locked);
>  	mmput(mm);
>  	kfree(name_buf);
>  	return err;
> -- 
> 2.43.0
> 

[1]. https://lore.kernel.org/linux-mm/20240215182756.3448972-5-lokeshgidra@google.com/

Thanks,
Liam

