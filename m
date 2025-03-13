Return-Path: <linux-fsdevel+bounces-43937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7486A5FF85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930FC19C52A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720271EF0AE;
	Thu, 13 Mar 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WHuyG1fz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m89VNyez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5315539A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891334; cv=fail; b=sG4WxX/0Ggpz8X8JmY0oC94xHDtBUOIxcJpcVgKW9wCDnrpSgEUY64b4sCPBcJCWIaop7dWuhaRb297yzybNfRCTFL3oZHyNbIyu+1sPDoiciUVI1wuZeELJYOSmkFQCM92LQkUx/wccwI4xywpOj+nQYRYdY5gVRRvH/UJYRT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891334; c=relaxed/simple;
	bh=Jbq3z9L0woe9kvr0fl8vPzTKRstPNTPS+wT0Cuehy2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YgTsaR9M6JEj5w6XZWGueyO2pYnp3gAh8Us0J4vP/cxtv2BnAP1TVD5mjGuOLG35fQpd4yJPlvOaow5v2+vWe+cTliS9at5MnV3LiWNi1nVaYIQV3fkQorV6pYkg2nENMc55DibLp3vsrQiMfwWkuIKgIBo1ctypGTA3b6KQ1uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WHuyG1fz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m89VNyez; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DIfrwi002195;
	Thu, 13 Mar 2025 18:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Jbq3z9L0woe9kvr0fl
	8vPzTKRstPNTPS+wT0Cuehy2Q=; b=WHuyG1fzt8VTSj2tDz80rdhAGSz0dFXRuG
	lvwAQf69NRqTctd2rVYEWljKn18mAYdDWMhyj/KwZ5L0/s5bgx7VlDs4CfrHVGa2
	aztQ8+BL8+i+U8uvJT6DxQImXPJKdjIEFoGN2N37hyvbvVND/XL9nksOkbtKvlKn
	idxaAZ1boor69cqX1+Ezw++jPI9kTt3Y3GD5VqfMD7c33EekEWhaw/GD+r7+AZqJ
	FJOs1Do1aSKPTkKUaNEfWiqwrPqdmVMZE9FP9MslcyegTrdxJzKDGnMT9IcrYTks
	K7H650Y+782Yzst9HskaKxXP4JnMbxXtAcIHnvJ50vrufno3S3EQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vmxmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 18:41:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DHWIrQ002186;
	Thu, 13 Mar 2025 18:41:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn9428n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 18:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTHJUdiV2CBuh3lvb9tC5NyAx9HuRBLwhqY3Jabvf/7HR+XDFQeui4F7yi0Kq3gq+5p+wACRNfOD41qRAaJxQTdVTaVzOSbR7W6mvbPla3FA+DOMCztLCKrUXSxThjg2zhN0HL3Q9ece2ogl7py4GrcSKtt3bASySAriNPW0JW3qQkqFg2fnQ6DFGTbEzLTehc7sNZ2eZXbmC+EGB26ULlX98f2EB2Z/MBBKjIRJrl9Nya+FL0sZ7Z4O65GrrBVcStYOMiiAQqO7zzgFyhBdN6Vvf8IqbPzmZNRalRRjNQSN/lfbtrTd6OkaZLG9RoPWCWDg6f030su+8iy3rqVSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbq3z9L0woe9kvr0fl8vPzTKRstPNTPS+wT0Cuehy2Q=;
 b=bQ0oRp+yfxUpi2KQym1rPpbeHwn+WgV6Q5bRxmyOhOPMlRHmVbPPZZzjuwzHKvKd1c8UypF3eUqUTfzo6Tc+ZeY2UdkICE75eYSYL8gKRfHsST2We8DdZQ11iEmv/WojYLlYdg1EN4iahadMQ87O9jm02nldTZgk7xVHJ8Tb8UuoG7V1mez9/oHx+CQsbTfe/0/M06iFCsXqIV1SwoJcKCWwlEi4Va5WDyyuUiYHik+dirdZrSfx9QwTYjqWwrU3JJNvANz41H62QZPinxG3U/ooHaXwUkEFA7WS59XSvP2dXi5eugBjvZi1nTNWOFq9YvqbKm4qUSR68eJbRw2o+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbq3z9L0woe9kvr0fl8vPzTKRstPNTPS+wT0Cuehy2Q=;
 b=m89VNyezytKql+CvYdQMj5VCRBbZYVD9YAVufcojdrWIDOEr9qbmWcHOP3rmU14UjvgIracBknOwBmptrbPj39dG+geIgIWJuseK+0haThkHMZqyYiu84mFLWn/qfzMAKhKw8c3zIMg8VEdCe4w3k1GkGB9xpvvkHzxRgLva/ww=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 18:41:43 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 13 Mar 2025
 18:41:42 +0000
Date: Thu, 13 Mar 2025 18:41:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <9699c035-e629-447f-b237-c8fb5c1e34df@lucifer.local>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
X-ClientProxiedBy: LNXP265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::28) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 433b3b4b-4d1c-4edc-2320-08dd625eb2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v09ORgNDKNaLARM0e+T3jhXHWLvG0VV/+OrcU/S6MAIkNuILC4sWt+Cu0Dqj?=
 =?us-ascii?Q?jUFeeK7GCtn+bHVdMifkHqxxef+s34J//CVKl/8T9SVvlBWUvCBGypwAAEQx?=
 =?us-ascii?Q?07vWFv+KBVxR8toCXZBDg66HJYshXAfnoNLeK1Lcx4M4VIz5mpfE/UrOo3Ds?=
 =?us-ascii?Q?2jpmdruO0QRkuYHbbVDKilo/D8frXOrI74pGcyIqAzj+R2+PsJJNpSoEqa21?=
 =?us-ascii?Q?i5VDy91PPdV6o7mbh6Vum88oe69AO8+gJqZdGOXWmlNZGv1SBId1aO5re9Nf?=
 =?us-ascii?Q?nYk46T3d5TPJebaR79RYAcOvn+Z8ZEfVYaRDsTfbgn07nDw1eckDrr9CSnXN?=
 =?us-ascii?Q?FoLCi677w48sVr7Vybmh++4HQPke2JdAg+RrzqxMmVIfQcvq+awEzfDvtUHK?=
 =?us-ascii?Q?jCooDTVMp3PO19jDbxwMGH3fDuvv67PJCja4M4J6TvQm8xgZ2qvQTJ1oAPc9?=
 =?us-ascii?Q?dwzWzLH7ncSa060iK9fT3vdp4ymt/s/c6joJuuZkLpPMk14wcEDxO7FBkMuw?=
 =?us-ascii?Q?+PgcQ1uDD7XIza1XNl3/vdOo1ZEqQAyndSJGwEnJs1QYwAkOWdIdO+UcMECZ?=
 =?us-ascii?Q?nRS6PedLWiqQaC1UnwdKlkZ+ubpfgHi8XToq+stpRjGafe2rgWm2P8MZnDiK?=
 =?us-ascii?Q?X/lS0cyZVk0EW5/lLruHTa5iWmzKhe89yPdBKHe8BEG8vd8BQr+BLatj8O4y?=
 =?us-ascii?Q?y9w1uRjlJQYJSME+WBjufmMpljLjkmdLMH4P0aFE4aKhEX5tAd0YiNbuTaBZ?=
 =?us-ascii?Q?zHkwWrWEzhFpqwbmjVQJyGK5WSvvgCpn9E7KOLbnTYiiEg8h/Jqw/1DCnoCX?=
 =?us-ascii?Q?UrQdJnL8rdl1jiDozY6F58nK9hqEzb8XcdIHg07ThNuRpqGje73HXuK9hBq3?=
 =?us-ascii?Q?jpI/eSSSEXW6t1tZBDAVfkMc0zMz1ZfZthjpW7UjjJ9EYh6Umdq8HmJ/ZrfL?=
 =?us-ascii?Q?vf2q2Ha2W1WlVdDRxXnBsaY/bK4kj1BQkE7Mf2aOoa1bFIxStHamSWN0XQzD?=
 =?us-ascii?Q?AZRjq517iTj6+FAyfdBm0UCyNF+6bConx8yhDHDvJXoG3dbv00h+BkC7kZVZ?=
 =?us-ascii?Q?3WK5I9E1I2o+YhIx6rhPc+ojsdwcgUaxyVvtBqTK3xQrDZYN8QummSK8r59C?=
 =?us-ascii?Q?F8Wslqa/xnLkwZiLD7RyrJUkUKWTeX4zmu1eeWe1X6IGpnq6mfzTOhSqq9q2?=
 =?us-ascii?Q?5v33bd8l6oub3jIxYXSZlcaFiN32gXycqpW7uz4eDDZesYA6GVWlxyhgVKTY?=
 =?us-ascii?Q?dOeAtQvkyHSnXDZW3dk75dcKSMHqgS+ZnmnLWVOQGGOfJ8+o5HGmoBNsDv0e?=
 =?us-ascii?Q?LCQ6vLDC6qQ5Mq7Y6YnrlvYSke9UR0tLbdcFZI6G+73N5zPX4aPqsw6k0DJ5?=
 =?us-ascii?Q?trG5uLdAlpgn8ffd0JInMWwN8k6a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLb9tTgoIr2Pi5HEjRGjX1woAl2zecw8sBLE3xto/GPwVIYyGkbvjwKREv9A?=
 =?us-ascii?Q?t48ju2LmGngncXLpnqbJsWZpftUu0dglt4gb1rfO5wll95EQ4/PjOUpJLEKm?=
 =?us-ascii?Q?HzymvqFT3K4iHAVn+pX/qwBDmM2ecC3QyfwplO/v5nI23P6KZaDINWJPMNeY?=
 =?us-ascii?Q?M+fNE3ozX2xfKc6jP8+6m0CQg/1UUgaRpAFdyoRmBc4I94vl00cHkMw40iYL?=
 =?us-ascii?Q?/fwlmrsxKpuhpuVPRNYi5flqtrma0BBbPspv1/8zj969oE3tWIsFARzVCz3t?=
 =?us-ascii?Q?wZnHZgmXDGwdzmJVFS7SHiodo/KYGO7+QyRgARVMVkd2kDL7O+C206+F9LFC?=
 =?us-ascii?Q?On8Sdi0nyXAagg8M+37HCc93G+rLSoM+HGCclhmGtvBJAPCdwplVUQD6N5lr?=
 =?us-ascii?Q?6hPPdKYYNi6ccvkIx8sDkhQprixgAs7c04q+EwjoD1WDqMyqIk2lSbsgp/Mr?=
 =?us-ascii?Q?XBVm6UuKjquiHne26B/6gXE5VIf8Qp8SCudwC2MJnqphQdJ8hF8XuOj3hEd+?=
 =?us-ascii?Q?w6iCTp1G3ajKCFQdmSBOYyTYbN3FHIf7mpQ1N506lvMmvBtyRSf/YaxqQJcN?=
 =?us-ascii?Q?idWfI3U1cRE7VKCZpCQ8/sDXfdBsE8zEio8bpuE3xMMpcj1gfb3C/ec4tCdJ?=
 =?us-ascii?Q?Kr6lnLIjDYVLkkTGPaiEvgAtGT89AHM3xKbJdiPW85RWfu8Y/pYaFBXY5YR9?=
 =?us-ascii?Q?AYYmN0Y2tlbzIdRx3+9zATDreMYc634F2ggEspSjyk0fvjZHp3hc6/XerOiz?=
 =?us-ascii?Q?gxTsI4BhGNaARnN7ve2saBGuE2KkICRLvdBJC4Gq7WOu63S6aowDwizxO4a9?=
 =?us-ascii?Q?xSPdidGGO5od3POBJ64ettFP6bd1S4q0l20E4dC0uMMzG/iyMBwhthBoBvaJ?=
 =?us-ascii?Q?Dzc0WIoZhWOAk3CahPpr4Ks2WJ36mNqPFwxttxss+xM00QYQ35LvrMl0CDJ0?=
 =?us-ascii?Q?JZTgkcm0lX+f4TnGWDyDrK6SH+PS0etpvd3g7aoO48R8BBuBF3vlTUmZiFDA?=
 =?us-ascii?Q?hXXrCxn+FdchsG6BZlpdXbbh+uwSo2VMKJHwaeC2OrITeZmXYfMYYz6Gl+lr?=
 =?us-ascii?Q?VJh5CmDtpUpAlMpj1dYesHWQWUAzGJgn1w7svN2GkO/WOB+XM6HZ/4ILOpi1?=
 =?us-ascii?Q?R1PiiqWqNJ7hnyN0cZGn2dy6lnEtdkZtm53bz5C7vkdCOBq+Dx3k08TWBNKH?=
 =?us-ascii?Q?QGMwHPBP68QccO2SiB8pnT23NfAELKUNywQGizVzG72xTGwFq3zAJvZfuMyF?=
 =?us-ascii?Q?8dqfmEuCw78dHkw4Y2Bw6sbYmJWunil7o5X7D60C1o1nbrZO860twVXOwH6R?=
 =?us-ascii?Q?HqfAorTPuGLs26Cifr3QM1go16YFzZWFvefIL8o4FwJpDIPCjzzcxjkbveEq?=
 =?us-ascii?Q?BseHqiooRP6CFAWwnMkpCbHQZWia097wz2vNfLM6D29tE+EPhFWHH1uM6Qih?=
 =?us-ascii?Q?It99NsXYXHQQ//aZ5Tm4p0drQMwHtSWWAvPRGwliJLkOlZVfwxHxo+GV6H2g?=
 =?us-ascii?Q?FUwXm/j2EKjyM/V873FnoPnzh3Obnie/IarECqvguzeZD0MnYojzQLnrtetK?=
 =?us-ascii?Q?BFFdwDWr2R4s0mv18hb1eCcQLqrU4dL9g/kJkiQFNVmXjRDGKOGTSsna5+cU?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yZICD+c4u2zR9S/IddxquJJAs4BSn0ZZAaeOSHbBQzhc3g/pFn+vwKk4hB7XKb1+A32vSD1X/HZn3F7ljdTLhmq69jXSggazcu7e9n3nsgzVjyWsnnHg+NCIHixTyATLk8HXD7o4Tj582nrjp/oRoDXwFqcOfx9gZu3Tk6SkMEJ+lV8Q10VZ/ABBnrJknkajNUVMYO8C2ZsrOUJGptzSBD9HGIrawIe+k97txYyGNX+v95dD10mBuk/mgDJLGlEdtGaUSTwiY2nR92SLbbcc8FekpV71pAQJvm371p9etNpjcIZTWXnPmMSHTGm+0OdXx52QzbrohZfFN2O6R16AM82CvfyFpJAZJsLqBFf3TTm6RyEpoFpwA0xgm1Ta2REOPBEkeELmXMWNm0NJNYaH5KS+81XSTTGXAz1ii60yAvAs2bV+7RQeoVamwoD0BTBe5za95/UP5a1C67eOBcSxSR7H62CR4yp22TwqlddQv3cUG1xT1nwYlMmcMq3oUyQAJ0+FVkEBt1tIQOsqnYLwEFEvw4jikMRl8kM1Sxb1L0BoN5z5ZThy4DeMzjencRCabCPcunkjrmkc5IGf8yiZl6C87ycF4MNKd8seZTGjDeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433b3b4b-4d1c-4edc-2320-08dd625eb2ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:41:42.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyIoUnFIX3BBvgWfAP+E9S61mvgHUqhvOKZTl5bkw2i9CZZ3S1IykHaVYEHckPCUA5rppJzi9lJds0W5J7seV6m0l4WksV9Y2pfzBvHcazw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130143
X-Proofpoint-GUID: 9sbSdYDMDWi_kButoc8jHJ8BAZGP-Reu
X-Proofpoint-ORIG-GUID: 9sbSdYDMDWi_kButoc8jHJ8BAZGP-Reu

As with the ongoing evolution of this, as previously discussed, the focus
has settled on merging of anonymous VMAs and improving this mergeability.

I have an RFC series (not upstreamed yet, but should be by LSF) which
optionally permits improved anonymous mapping mergeability by passing a
flag to mremap().

In this topic I'd like to discuss that, anon_vma in general motivations for
it, why it's hard, etc.

This dovetails with the original proposal - bit is a less ambitious, more
short-term 'how can we improve the situation' kind of thing. Maybe next
year there can be more :)

My slides are at ~31 right now, so I wonder whether I could have an hour
slot for this? As I'd also like to have some discussion of course! :)

Thanks!

