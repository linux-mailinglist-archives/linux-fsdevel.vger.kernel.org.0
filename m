Return-Path: <linux-fsdevel+bounces-47724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD7AA4D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674AE9C39D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348424DFF3;
	Wed, 30 Apr 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgW7mEC/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UrnnpWG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D6238144
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018757; cv=fail; b=FO0+l5KiCNAyCxP2cKyJfqu4B8mGSxz42rQLFSOKBm11gh1t+YY7tKb8O1LrDSUcr60F8Yw7/FsRZ14x1Ct3/eKStXZ0mfCi9Pr4gCzCHYYd3dG//wak3DByFgWRjF5bse30nz4keoUzny0dVRXt7hoTlaB6PEqHRtk+SPxilTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018757; c=relaxed/simple;
	bh=THnqDAX5kWoz5IdZ9KyLdQixFlAaUeVdKfG/vk2hAhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UFTWnakwB4cLULzlx4SRu8Gd4Io085bJYKIprgyguMzqTaVkks4PLaMDlrpXLXqhr3QVJgJFu61iyxO/GCkmPCtwP1IbjyGoypaw57vNUdCXyCKlMlT+LY4TgsgCIrtb7iPIewQQORL39d61syFWUQmksKGVIkCPzk8lGV87FJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jgW7mEC/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UrnnpWG1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UD01m9006324;
	Wed, 30 Apr 2025 13:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JZ/luPcA6ggeHLypFQOKIz66psK8n7hRnSxb71sS1us=; b=
	jgW7mEC/0uMyq4T3/DkcaXDR/eZpcHs0xjaJaVCFWVHXUyfNtaAYXHyTBMfMTYLF
	APKe/Q1InqwZX6gW6c1sXFy3nzij4SxqZ2E2rcsegDs1JiZ43t8mBystVwLck8uw
	tQ38xaBp4sxXq3oFzbTbjmTrQW9duSBThX94hsPJEW3LqgwtcvsZrEp7e2B1/Dos
	I6YIHByGmyPNiidJJsX2fEvLje1wKRWoagICgmuL0auhD6OYaU4RIcFC/BRgo4Vw
	H+/Eur6i2yNCY5yez8OnaSrp1pxglTBy/BYnvDQ8BjFbhPnHifZUcWSiBMwo6ZQc
	vN9PZwVLrmj7AMJXuCH1Aw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uks587-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 13:11:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UCAwtA035447;
	Wed, 30 Apr 2025 13:11:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxb2f34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 13:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWUxHlUzcJvyfFtnwMXXCF8L+SsiQ5r5J7HOtS145weBi/0v84xtzG8Z4VKanYhWmXRQ7vtztJna/XHSDsI0+2eRtJjc3loWacburucYnlIKub8MkYJY7Chfp8bH9BVazxeL4O6KnngRchP2C6TGKisxEPH0lcVJczqxN1gY39MZzTWsePO47OeBvXkdHvilp/KjVn5ymwAEkBd9pk/9F/q7pLT0Xn1VB0WtjZ2eTEwFhTtBjjjruyyAjpQ5Nf5mPtaTqIhuDjHMjRBshYC2lYSjubVe0EvM+WJKiHlEuc6NZa7cviwecJFLh9WhnguhbAtf4KBqJOUawcFguSN+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ/luPcA6ggeHLypFQOKIz66psK8n7hRnSxb71sS1us=;
 b=QrwabQV9gW/WxXONFA8k/cMgjmSvoJPLowA9g1KFvCoVdqNvbIhydfzFouW9MhMaviZxXIVubrN72OUswJhAzQ7HFi+E0hIzkEF40J0yDbKaVabTnRYD2XINETX668svZ1CsXJRxBRluRumn929LWJLL7lTjiNDUWgcFdQtRGrfHNYga0CIvcAHuhj03ymjlXLimkUIzmU6bMEM5iTdVmNbNajb5XY7WMqW4aYnYggQP+ZmkVG4Y5fbXXC056cBRujP/9sBd1y3t6H9w+uk8qz0xbzwk/D/i2X54A/CiVCj03vCbQDxTlYDUiYg5ClvRluHky/6zkmGou8McbfXbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ/luPcA6ggeHLypFQOKIz66psK8n7hRnSxb71sS1us=;
 b=UrnnpWG1NFslylQWyFxG28pyEEv0Ghpl3TOfXFKfHuTwyqPNg4ycs4BuKNxSuvOCsH8K5Rpi6pNCKfiG1Lf0pdSra001SQuSnuUSepegf+8EVSmyPePqwZxi9yv5n4jOsU8+kTsdGFvWgkrYbAbWdHiEfYEvQ1tOClu4UU5/a2M=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:11:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 13:11:37 +0000
Date: Wed, 30 Apr 2025 22:11:22 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <aBIhen0HXGgQf_d5@harry>
References: <aAZMe21Ic2sDIAtY@harry>
 <aAa-gCSHDFcNS3HS@dread.disaster.area>
 <aAttYSQsYc5y1AZO@harry>
 <CAG48ez3W8-JH4QJsR5AS1Z0bLtfuS3qz7sSVtOH39vc_y534DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3W8-JH4QJsR5AS1Z0bLtfuS3qz7sSVtOH39vc_y534DQ@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0136.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bcfed1-649d-4e4e-afe2-08dd87e889e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTA2RVN3TTlZaExwazRNck5EZkd5a2RhaVMxUFF4RlNmamRwUTVRYk5HaDV4?=
 =?utf-8?B?c2JUT1U4ZFJwTXNneC9KaWVaaGxVZEVENExzL2xLWURaaVlodHAwNWFnanJK?=
 =?utf-8?B?SjNpSWZVS2U1ODgyeHNBRFhjaU41aE90blFNd3dpSXZvdUlKNUJtR2JYV0xk?=
 =?utf-8?B?bXR0VUJSL3YyUFAwQjRWUktLT3U3NEw4Z0dsUFZCQ3Z1ZHF2RXRUamxJb2FS?=
 =?utf-8?B?N1Vvd3dJYWRtT0JDOHhwa1JkZW4wSjJwRFU5TzVQR0ticXQ0RnFYM01rNjRV?=
 =?utf-8?B?dUdHeHBvK1doQTVIYVZzeDdBWS8rby93Y2VlRWtxYm5OL0FDQmJ2THhLd3dU?=
 =?utf-8?B?RW80cjBtK3lyZ1R6Um9sUWEzeEtwYnRJamdLU0hqRlN1WlpkTHhJTS8zQkY3?=
 =?utf-8?B?V3oxSTZhS3ZVRlZLTnpXek9tMnc4Sk1UUWh5OHVTdTQ0TlMrWEdnWHNkMUxa?=
 =?utf-8?B?RnZWSlVlN2xIUVRaL29GU2htbXRZOXUySGdPeWR4R01DYmg1RUdZUk1KcDNa?=
 =?utf-8?B?ZjRBekF2c2J1bWVZZXNZaDdnVk5lYTdSZzNqZk9iN0VPOXk1WlpjZ0FkTTBX?=
 =?utf-8?B?RGI2Z1M0cUg2MUdBR3doU0JoSHBMWm51T1FaOGlkM1VIRWNkUlBITGhXdFZ1?=
 =?utf-8?B?VitPdFdjenF1c3VCZTNlMkkrMS9yc3RLaXpBUitNYk1XR3V6SDJDQUhGZnZn?=
 =?utf-8?B?bEJvYmZCcUNhSVAyV2R4VlhaZndIS3J3bE01WXRLL1FFZVpmbnVSU1cvWWR5?=
 =?utf-8?B?RkdlTVlPYUhLMkFuMVhtd0dTYVNEdFNrajJLOVZrbVFMTzVPTUZzQUpTWFZI?=
 =?utf-8?B?c01WaE1iWElhUDMxc0kyU1NCallZbXhIMXNTTDNtZmt5MXBFYU9ZcnA2ZFpl?=
 =?utf-8?B?aFQwQktBME9XT3gwSjdXUEZwVldwWEJpd3NHSFZlci9BVnZUNmluVW5ZNFA3?=
 =?utf-8?B?UnUyVlZkd280YW9mOWEzTTJUNkZWTkJZR0JhZCtWTkM3SUxwNU5DRnJ1cW5K?=
 =?utf-8?B?SUxibTkvVmhOc3d6TTZNRWxJSWcreFk1VHUxVW9oY3pmblZYQU1zeUI5Z3pj?=
 =?utf-8?B?TGpYWnlBdDBHOThDbVdIaXZwbXVCdzdObWllUCtiNTh2bkJRRFhHYnMzbXBE?=
 =?utf-8?B?OWRLTFZBdUJPdGtGTC8rMmV6K0NldFhPWHVDV1p5WGdrSjN5bXpoWWVrWHJm?=
 =?utf-8?B?b1grRTIvYXNxK2ZDL3lPK2lHZUNqTlRqUXV0R0VzVCtQS0NOWFVVRmpJQkxI?=
 =?utf-8?B?MHJ0cmxxQk40N3NXOEdadWQwZ3p2WnFBY2dhdFk5b1p2ZExqMWNpNFVLd0NO?=
 =?utf-8?B?NG90TzlaYThKTlBFMGYvdW5YWXFWRWNTbnI4eUpWR0lPMytjNDJ5RXdOeEI1?=
 =?utf-8?B?RTFUKzV2a0p2YmhGclZtc013VDNyaEs1d1RjNXdRdGFqTEpzSVdjZXlBZ3Z1?=
 =?utf-8?B?QmFyQ0t4U2JZSFJsTVdzRzNIUEFWY3V5WnczZGRpU3M2anRUTWdZZTNjTnZZ?=
 =?utf-8?B?YzBRRXk0bTNpU1l2MmNra3pLeDU2ZWk4bnlnZmxQZTkxc0lhMmVpMzNrYXBQ?=
 =?utf-8?B?RVZuUU53bWVxV0JJRTdydEswSFBnaUgveTJRSEIwZkhydjBBSFVDcnROSE5G?=
 =?utf-8?B?WmRGNmxlcGl0RW0wTHNiYkdqcGszQ2lSNGZUa29IaFNOOFFNSHNTbmg4ZlB2?=
 =?utf-8?B?bTFDMmlTRzlKd1E5VFdGKzhqbkV3cThyaWFMVnlsVHdZMmViSDA0eEhYQWZ4?=
 =?utf-8?B?NlNNQkdhbEh1cVF1UmRvamhTQXhHQVhsVEwyMElkRGppVG1Ud1N2MVN3TXlv?=
 =?utf-8?B?VURNcDdCMnRGeDcrTEdvN29YVGVwWU9XTmxERVdnVkhYUTF1QmNhNG5WeUJz?=
 =?utf-8?B?UmtDK2VuWGZRTnhCSStncXcvZW1iOGNJK2JYaWwzN3VBek5JWUVNMU1OTXFh?=
 =?utf-8?Q?C6ynosMRlnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG9OSTl0bkIzQ1FkMzBXTnZYRnVZck1vUXhBb2pQN015WmdmQmpHbytvVEoz?=
 =?utf-8?B?K2ZiMHg2Mk0rY1lkUHhQNjYwNXRuNUo0NWVoMFMrMzFkbFRmaTNTWXZKdWN5?=
 =?utf-8?B?YlBmbkpxdi9acFZBbi80YlUxOFVtLzhPVVVNU1dYRlg0L0hnSWViZGlpdHVH?=
 =?utf-8?B?T21pVDROZXg3TDFYV1M5d3NVbWdHbnBhUHh3anFpUnNMSWNObXk0c1JQMy9D?=
 =?utf-8?B?bHRSVjN0d0x0UjhSbjkxVldZT0dxRWxpUm92K09Ndnpab1hialFlbXlONVVs?=
 =?utf-8?B?TmRvaktUSHIraUVRZ2lVd2tHNDZscDdraEFRMTV4WGZuS0NHUTA5cG5ZREpk?=
 =?utf-8?B?MnpRWkdDK0lSNERSbURxWWxZKzVqZzZqREVNWDZualZXM0ZJVlBIbTNuR1NU?=
 =?utf-8?B?NU5CV1VIUkc1NEVhWGlqdGE3cXh1YmU0d0dvbnl6VWFhaitERnBIT2ZaUkxH?=
 =?utf-8?B?Z0tLYkREalg0ZTBST1gyZGIweDN4L09CWHhGckxCb29CekUrRzFHWlFKTzkv?=
 =?utf-8?B?OER3OUZMall5TXl6dUlBcW1NcDJ1RUZ5WGJ1SFd5cm9RTlRsZFVxUW16RTJa?=
 =?utf-8?B?RHlqMTlKckxpMFV2c2RHSzdhQVptaU9GdFpvR2JvN3AxNzd2Um16b3owT1Jx?=
 =?utf-8?B?a3hvMEU1Y1QzamF2TUFXT3FwckdtZVh1WUl0bk0yRldTQ21Yc3gvUHYzV1pR?=
 =?utf-8?B?MkF3N0RHUXBOZmgrdTg1WHJ5UUtNdElwTlBnRjcwa2VHWllLOGIzdFhiK1Zu?=
 =?utf-8?B?Wm8zN0RWc3BWK2hVOThYRnNpYXNFMHNWMkNaYjlScjVwRWZ6TlRDekpwdXlw?=
 =?utf-8?B?MWl3MTVLT08zeU40S2FtTUpuemgxbzcyOUFBdjRjY2NOS05XKzdZb0s1SFpF?=
 =?utf-8?B?OW1VUlI4MDQyeUNkSGIvMEUrQ0Z6TEVBY1ppQkdPbDJybDFrc2kyMS9kVlpM?=
 =?utf-8?B?bmNEZnpLakNIeVg3TG5qVUdDc0pZSGZ6S2c3cTFydVZkcUlmSExGWHUvZGVl?=
 =?utf-8?B?dnRzNy9RTGhZVFFHV0NWRHlhODBnMkJnQys3TUMvTWtuT1JaZnRscHlpMHhh?=
 =?utf-8?B?bjl5TnlPSTNLcjZ3RFF1WW91VGh3Q1BrSkdnTndQdkdrei9pOTRJd1h4UlBx?=
 =?utf-8?B?eUkwdzBZMllpYlRpY2RyTktSOVJtRDE0VHpDMEErbUJWeHhNTmxmVnU3c1E5?=
 =?utf-8?B?KzIxRnVBRDc5VmFPcG9OclVnNG01QWhjaWNiTkhic0NNY3ZYckdVQmUzUStY?=
 =?utf-8?B?cTVvNmx6a3pvc2w5aG10RFZ2ZXVKWlJaN2R4SUhLMi9JVG5qZzlpbERtc1l5?=
 =?utf-8?B?UkFiWUVHeWtLd2c0Smoya3lhS0lmZTRVK2tzeHBEWjB3OHFpK0Zqd3hJU0lZ?=
 =?utf-8?B?Wnl0enlCSk9iMU9tYW9KY1BLTHA1c3cySlBXWnhwbUZ1cTUrNGJPRHA3aHc1?=
 =?utf-8?B?aEp0VXdIbmlDZDJsaE5yRVdZVmxwVVJsNTh6OHVzM21qem5TWm9LRWM3cjcx?=
 =?utf-8?B?RlpFbUdUbmQ5Z2JjMlRDd0JnWGxhRTdvK2EySmpTUm9mSzB0Sm5FODkxdUJa?=
 =?utf-8?B?VjhPcmtVV0RpTU5UdjlTZ3VNVUtNbnBONW9McEtpK0lJTEZxQ0t3OEJYODJ0?=
 =?utf-8?B?WlBDUnMzNEFhZy9HdVRrKy8ya0p4YWY5TFY4RzNCLzZYZWtxRlhMZWxVbmZq?=
 =?utf-8?B?TjErdWZ4U1BMUUtLUyswNStTRjV2VUlUdUpSK3RxbzBMR1N2dFpDbit0RW9l?=
 =?utf-8?B?QkVPMkVSeURwRWpFU1Z5OWFvbG41ei8zUXZpOTFsbFZOVUw3NWVubi9NSGU4?=
 =?utf-8?B?Um9PaVBNR2V6ZU5JWXRLYVRYQlJjVWxUS1pPVGFUbjMzK2d0d0RLM1I0WDl4?=
 =?utf-8?B?REtVbjBZejRYakRBWS9VWFhxbzQwWG1paXhOMlV3K2x2dEw1em9NbGFaVzVQ?=
 =?utf-8?B?T1JkY252ODIrNWxlZW1Rb1RTOUF1bEx0bzB1ellFMXNad1BKUnZrZWZsWThK?=
 =?utf-8?B?WEhtWW5aSCtIZEhYNGt0M1N0cUg1NHJWTWV6aStFcWdNY0FBSGFwc0VxL002?=
 =?utf-8?B?U0U3SVd2S0lkTk5VanhzT2lydVk1c2FNeE5uU1h2R3pQSjZLam83MWJLVlhu?=
 =?utf-8?Q?NxruVW70zab2NDaHZYnJTos3t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	910p7LW5ndPs8jDe8uHUe1voyxuXtQ5GPX7S9BvFe6qqieVOQM2f2XSFMEy6foY4QgyiSrQHu3w4E1+RS6FKWgd/jw9nn8rD3uOadxYHUoiYyfcWryGfzA5/KSykwMBEbQANsRB4u4NBEBRsp8eBt05eQYpUIQkenbPvFuMHC9hXvu2U69+E8CD7J3KSqMITh8cOvwd3qkAku8GaoPnQIodz1AT/42ZZ2qxzpjyEc+YWEPobEYyLdBB2vXHY9pRBgG/J8kkWu3fozIUsWwD7sR0gCz23sQ+t0J7XYQs5I4Lk0euXCu2ZGb33fEfsif6ffDN2tdQz/YhaTG4Ux2FS754GZygs30dHMaoyFQ+zkpIbFr52jfYg2thcOFc6yl+xqb4SSsol3Ww5UNLJQFUvhtJqzLnnMG0pU8Q7RwHR7wEuIQwdUr/5rEp1tQ8Tv5FiB5Sb/om/McR+1iYClMIwPpK2PdBwFDPOrFhxmALjW8LyHx/ctyfE/6qU089bfooLEabhctxiJ/Ea8u2DyFjTwbOmqqDg+j35/PkTG6Hwo3SpO8x63xj+V15u7EJ9Ff4fmoWc/EWERB9dc8QWQcmCtamukFrm0A4VaHVW6oXnDgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bcfed1-649d-4e4e-afe2-08dd87e889e6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:11:37.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaKzMs1pe28OvAM4kv4AdMHJyT6jdBkfR3dkco2Jk0cmZAH1w39Vw9x0NPBdv8L2s1x6lce/xBpNWxq3U57FKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA5NCBTYWx0ZWRfX6Ir+exkPMo2e qxR6jALXAu5N4AuFsEoxOmm3wn12vGciKapc+bXFrd4Nb5zWph/JzVX9GrY5igBYJA3PaQGEpC6 7QpN7hIsqVkpp8J+33iSd52szhu2D4yx5B8cGe2jiGV9arkjkW+YweUE2g1fofCGYWp783lE+jd
 OkErJWfpm8rd2loa+Yr/eMP2Rn+RxzF6bxXfw/Fw7PeQcVYrtgXezIqRLQL7nSg8XImdwL1lLNV e4bwxu1p8+2Lkyj0Lf4XvfUjGmFC1enK3E/76euSSqsyyRrCEyUdYNoS+i05EAVmV5UUHW8aYxn T8BtjKd3GL3rEok0cDY+RgdRrzzainAoiRZVQST60qvru7uBhg5j+/YEkpHPsRGdaedILPMCVjZ
 YXrQ5u9W9P+MEEPx7+S2zHWGnv3YCKaPQ99q9DY7QUqZITHw6TfOOVLhJ1WYn8L5/n0n+CnY
X-Proofpoint-GUID: 5Yox6ZvFH_w1oHnSCucJSoJ87vYB8KvW
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=6812218e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hLd0YrPOziyrv8cy7rsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: 5Yox6ZvFH_w1oHnSCucJSoJ87vYB8KvW

On Mon, Apr 28, 2025 at 05:31:35PM +0200, Jann Horn wrote:
> On Fri, Apr 25, 2025 at 1:09 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> > On Tue, Apr 22, 2025 at 07:54:08AM +1000, Dave Chinner wrote:
> > > On Mon, Apr 21, 2025 at 10:47:39PM +0900, Harry Yoo wrote:
> > > > Hi folks,
> > > >
> > > > As a long term project, I'm starting to look into resurrecting
> > > > Slab Movable Objects. The goal is to make certain types of slab memory
> > > > movable and thus enable targeted reclamation, migration, and
> > > > defragmentation.
> > > >
> > > > The main purpose of this posting is to briefly review what's been tried
> > > > in the past, ask people why prior efforts have stalled (due to lack of
> > > > time or insufficient justification for additional complexity?),
> > > > and discuss what's feasible today.
> > > >
> > > > Please add anyone I may have missed to Cc. :)
> > >
> > > Adding -fsdevel because dentry/inode cache discussion needs to be
> > > visible to all the fs/VFS developers.
> > >
> > > I'm going to cut straight to the chase here, but I'll leave the rest
> > > of the original email quoted below for -fsdevel readers.
> > >
> > > > Previous Work on Slab Movable Objects
> > > > =====================================
> > >
> > > <snip>
> > >
> > > Without including any sort of viable proposal for dentry/inode
> > > relocation (i.e. the showstopper for past attempts), what is the
> > > point of trying to ressurect this?
> >
> > Migrating slabs still makes sense for other objects such as xarray / maple
> > tree nodes, and VMAs.
> 
> Do we have examples of how much memory is actually wasted on
> sparsely-used slabs, and which slabs this happens in, from some real
> workloads?

Workloads that uses a large amount of reclaimable slab memory (inode,
dentry, etc.) and triggers reclamation can observe this problem.

On my laptop, I can reproduce the problem by running 'updatedb' command
that touches many files and triggering reclamation by running programs
that consume large amount of memory. As slab memory is reclaimed, it becomes
sparsely populated (as slab memory is not reclaimed folio by folio)

During reclamation, the total slab memory utilization drops from 95% to 50%.
For very sparsely populated caches, the cache utilization is between
12% and 33%. (ext4_inode_cache, radix_tree_node, dentry, trace_event_file,
and some kmalloc caches on my machine).

At the time OOM-killer is invoked, there's about 50% slab memory wasted
due to sparsely populated slabs, which is about 236 MiB on my laptop.
I would say it's a sufficiently big problem to solve.

I wonder how worse this problem would be on large file servers,
but I don't run such servers :-)

> If sparsely-used slabs are a sufficiently big problem, maybe another
> big hammer we have is to use smaller slab pages, or something along
> those lines? Though of course a straightforward implementation of that
> would probably have negative effects on the performance of SLUB
> fastpaths, and depending on object size it might waste more memory on
> padding.

So it'll be something like prefering low orders when in calculate_order()
while keeping fractional waste reasonably.

One problem could be making n->list_lock contention much worse
on larger machines as you need to grab more slabs from the list?

> (An adventurous idea would be to try to align kmem_cache::size such
> that objects start at some subpage boundaries of SLUB folios, and then
> figure out a way to shatter SLUB folios into smaller folios at runtime
> while they contain objects... but getting the SLUB locking right for
> that without slowing down the fastpath for freeing an object would
> probably be a large pain.)

You can't make virt_to_slab() work if you shatter a slab folio
into smaller ones?

A more general question: will either shattering or allocating
smaller slabs help free more memory anyway? It likely depends on
the spatial pattern of how the objects are reclaimed and remain
populated within a slab?

-- 
Cheers,
Harry / Hyeonggon

