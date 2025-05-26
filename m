Return-Path: <linux-fsdevel+bounces-49852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B05AC4180
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E38189A85B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B920F089;
	Mon, 26 May 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSM6UnzJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MmkCDW0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F128EB;
	Mon, 26 May 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270090; cv=fail; b=Kn5y5VlUtLKmQkUHnTRWomMdphaOaO1s2C7atufVr6wQOOIdBNSA7gpunOMOOs2bwo8kNQKX/ff2TJ4oISRtBIktRFIj1fHwzGz/81dqUavCsGT8AfDdOSb8bxP9wioulp0xJDlVz1NUoF9SVaie8AX5o3OAS/M3eAl+dRPEPas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270090; c=relaxed/simple;
	bh=ndrS+c6avdtoM9yTP5S70hmBZpMbU2E/T7Vw4b2sZfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CCDbpP6qwscqud8T9mztlpiXK/qMjq3YhqysLCXCEJS3YfZw/SLlGo5cSqumjGq1e9efVYcF1X+LtnrpzLzG3WJobVaIhULOm6M0Pmwhz1Jw3OlC/9FbpDYdIGTuyoORXeEoJp24psJpej8xAp8nCP61yToKVJ9P9BnD1oq0kmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZSM6UnzJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MmkCDW0F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8tvR8001006;
	Mon, 26 May 2025 14:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6pjTQ52HQ4QM077oro
	WWU/mNhJFkrcemZuuncl/JSp8=; b=ZSM6UnzJqNyUEs8JgrYJNie03aGovx0YnE
	XlRtX/TBjannQyz2q49grdHDA031NuHJTmNVxmoZZS55F9ExWcLgZzDyzqxzIofg
	AsO/SyxazpvTL9GFA8wdBdEsnxsDBQXZS6/oI44/IagB96HMvxV5wDu2F8+kJCiX
	X7vJL+YxzKX0xhdE8XWEtsS+Ao3fEFs+PiM7cBlEra9aDy2el4sWtGhrZe9J9TF0
	4hhbIpe39aXp6xRAhsilcewE+YJNONkY19UP2tTKxMwbQEIsFhXvIkHk0fckVylO
	DBP/0sq8Wp1OVf4Sw+UhTCQSnReI2pIuEuY8udlI5G6CiISImS6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46tsexs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:34:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QE2pPw021113;
	Mon, 26 May 2025 14:34:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jebuvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcBXzLzb/vDr+UeXXgWFwFOGdNLOavyt7l6WGOIp3HrI7XfVPbR5MSnIWOXe50jC4M522bkshTEKwBfmAlcwq+Qvy4aanS5hb5lZI0T9XDK7JXNWoQdUZFZviKdLSe2FDgKgmWAnEcD44yFxYbTN6m4amxMmHQCJnmJ14mgHZIIE9wT6vbAhTe7Db/XPmHWqZ/GsZthwSGxA9QMvnQYfcv6ZVIsP/6g+QpDEKCFYlVUpZG2Vv970+V7rRaRM0qdQHjoQUae4wNJi0KBnrJPWz8J9cB6pZan98IkzPd//pp+4JiJ2ORioUFXfqi2BuhvA1Mu8yY6glP4PDWov2N7RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pjTQ52HQ4QM077oroWWU/mNhJFkrcemZuuncl/JSp8=;
 b=XX8t6F3GNyorLSDqym1LMJ3uPeS/jCAnSriVkXZGxLvOlfhMbqifWMzPM0Nfj0TWMxZKb5vu4tImOXhE7p9liFEqLP75DL9B+tXJt98BIfNC2jR6UOnZzpRyNenvdDLjxx/RSdd2E4jRTYwG0AZ9OR1lOXetIa5iMsStWMFioAV/9tRMwpfg7pDhhMKT9F+OBrr1Llfrl1nudQl/8J4bccUxnAJGPghr1LokRXcaLpzVAjjnSJgGM9MVg128rYpRaDF/VZdO1NKgtprSqxKmQe7Q+jRyvb+8Qi0O9bmjGjpV8F2mV+hI1mC884MqLFpyOCNUshj/vq5+JLQQqn67WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pjTQ52HQ4QM077oroWWU/mNhJFkrcemZuuncl/JSp8=;
 b=MmkCDW0FPfuCSzCDwmeKQ7CBJv97Babs+PscffUa/4bIIWvL8SpU0VemOLuAW931f4pRDz1D88va/IF5h+VW+0w4Zj2xcGW5fxTByu1bqgAxQ1nu9Oo9Qtyta8YjbVIWTkKJUq3G8AFrWJQ6ivZO2aEsSWm6poljUie8Tuzo+kI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Mon, 26 May
 2025 14:34:26 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 14:34:26 +0000
Date: Mon, 26 May 2025 10:34:22 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v2 4/4] tools/testing/selftests: add VMA merge tests for
 KSM merge
Message-ID: <3ercsd2qyximw2fo3jozipi7vidwljfykijcxc5slif5hd2hve@kalbrz3uwldh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
 <cbe5274aa4440be230d87a2b48aaef2b6d73403e.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe5274aa4440be230d87a2b48aaef2b6d73403e.1747844463.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0069.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5eb4db-ca49-4b08-1e4f-08dd9c626a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3FLzhmpPcB9Fbtfub1w1nPlcV7I5C5tEkZwuTj2ziUsYgo3ALZVPEUG8sYh?=
 =?us-ascii?Q?FtqYA7Z0nob+oY3j7pQik4H0KZy7UqSJMgp60g9dHw+65HW4A2b22BVIbWgD?=
 =?us-ascii?Q?0AKtvu+Ac7olX0AlKKOGFTiqRAvqhL8yd8JIc5kjQOH4qq5tA1Tcyrd9NHSC?=
 =?us-ascii?Q?d3LfeSgxQ3ncijaCuWFpp9ABpfv0d1Xds2hj6ZJPfzOwymRGfq5PnNdmlcb9?=
 =?us-ascii?Q?4b3aSmdbHv/jOofhpj+m4XZ0AWfhR2FYHsZdNjLe71ANMqzPj/F3oVAk3knN?=
 =?us-ascii?Q?IzzKQpjT9wTVc263uGrBKtcotmjrEvd15pBnnAvZm26LqfxjrQHRklw0r/sv?=
 =?us-ascii?Q?2NPfMzvz7FHz57JVeCRtMg7j6F8UOHz7Emy7Dr+LETjKX6NQtp8d4U2yk907?=
 =?us-ascii?Q?KiuldHCKWyvd8cPpNliXGhclOJ9FHDtReOsxQp6+1tZaMyPSy5fb+CoYTtEP?=
 =?us-ascii?Q?TcLRzc/htrxArgziVNBnsesc4xfz1folxbBUxqDCxhlNKdRydXtuUwRDrQVR?=
 =?us-ascii?Q?R6/KrpdN8yKQmQdZPng9va5BTc6LEvgVNS0U9oXIkidavByrgfibCts8duNc?=
 =?us-ascii?Q?zBVph+TVuh+6lN/AdxaeHy3IpwpiWXo4dCuHB6qlh7xgf0DmRnMprvhtSFcJ?=
 =?us-ascii?Q?Fl5bPlH9GMeJiI58Sr1lm/CLsx3KZ1z4NmXMmI3OnwR0JAm8L6o/PZk2qrjn?=
 =?us-ascii?Q?/QXSFX8NOy2QA5HaJMsFwcpEWVC+qTSO36oNvrTTXVSI/q7vcl7QKrl56RY6?=
 =?us-ascii?Q?qusas/B1R8PmC6fck8pihmsp9h0QGBkqqsZR5iRE/s7aO4C+hmmaoZb/fZxM?=
 =?us-ascii?Q?fC3TFhPl1+rAO7lU1ADbQaZ79Cm+L6kwhAKMXAquT+Jk7ZA8UHSTvihTQqqe?=
 =?us-ascii?Q?WjY9Oghuo4VBikM6JE7Hv2xfWJtqRxS8JxK+fOqteNd8fH6vcTCrf8Yhc9xV?=
 =?us-ascii?Q?x/KAsD5C66C4ZfRQwVDfmUj7l7UZGfzsvRr9glIw6aK17FyNFGB36LYE8sUD?=
 =?us-ascii?Q?7h2DpHdcl2OCuUOqlEaxxjGj9DqN7KqMiGmXKGFeKOC4vtjowREeLAuIheBz?=
 =?us-ascii?Q?uyaqBEtEVMjMwrMM2qd03qwHvGahQHHKLQgJMeeB2P7kvXL4ER1NnZYxG0KN?=
 =?us-ascii?Q?hUzbwN0ISrDZGR9Kt06XX0yPLsr7gKZT0MnVhtA9TAcZiqGJZ5uVY/Qdbft/?=
 =?us-ascii?Q?r9y1IzY7vZhAzylzOa6Nus4LQ+TFyD+cqMBQiBEJ5nPZmMhCJhNA41MQm6pB?=
 =?us-ascii?Q?lYQRi6fmTOCKxo9Q3ubFhGugV9D8GJRyYGe5hoFSruk/QxIOEDQgRBs0mGLY?=
 =?us-ascii?Q?/MCL/jpx1ryU25T14oQcIhb+fbXPiYKyT8dpvjm5rQ/x1H+HpLkirBoCtmBW?=
 =?us-ascii?Q?TXedrIMAIoXYlijH4WYUADjblgTcje9mUtEmCf9m5bN5PZnE9CXhT0GoUF7i?=
 =?us-ascii?Q?E1tb/Eovfis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCmn/HbleIbZIPuq9lZHL2B0gFv9Em0HPcfr2PfKUQBaqUC56LV/75s6xYRK?=
 =?us-ascii?Q?HxtVx7WxAS3BO6gCKeZo8cghcckD88AOT0CbbonyKuezfc7Rm9uQqJhUkDD+?=
 =?us-ascii?Q?jVCLEBc5EpXcyYVG0t6j8No76pr5Y0j9+SfadK4Un5ueXXKDVBGbhcGETnvg?=
 =?us-ascii?Q?V1XhjfSB7y+On3KFse7+yPNcAsO80u08eSjqmYaFopt0/HNIWBX328bBwAfl?=
 =?us-ascii?Q?AOZhsYYw7HIXDUMG5y0ptVLFtePr3ADKMZ98knMqPAfQ8EjTTGoWxpwpG9Ej?=
 =?us-ascii?Q?tzOwaJhtz13qMAyb39DLN3NfJBoK9CmMwopdm5bJcg91YNlfH/enRJD0BwVv?=
 =?us-ascii?Q?LGU8S8lDx0Ldy9yNbz95PcHsvdGVg/p1LLStVBav4LiGJLX+d963PL3L6LLU?=
 =?us-ascii?Q?hGIPDVbFY3/i0/P0Euceo+PU2YbTgD/6FoxvbbqnH81rHhLk6+yynz5PEW79?=
 =?us-ascii?Q?NogR9xxHwqB3Oo7aNPGbmTbifDpm93pdCiofPKXlhvxujU+C3x96cIatzimV?=
 =?us-ascii?Q?BdMeF6e6ROXpy9Wrvr/SwjCcRWJgt4htzumnB/TvALwbWUpObEI5loWbBqhz?=
 =?us-ascii?Q?nHUYKsdFXXNlhJL1OiUtSIqKV7IA9ENKVqTOnrU80VDtlImTEQ2v62mfxkiT?=
 =?us-ascii?Q?QYVFEHEOq2RiqV9F0ksd9VnHKR7sw3mjyjBOtZSOHo3PPACuNdvj+kBrW121?=
 =?us-ascii?Q?S2Or8a+spCHL9y/4L0dT0WQPsh+uI/H+2QkNJKPWbYQCm8LvwPWeFYVyXtAf?=
 =?us-ascii?Q?hwFmJk+9Iga9hdoaW25FWuJFWSJIvTZNHAtiEDW3r/PKSIBBCdyO+IHjJ9mQ?=
 =?us-ascii?Q?fBwR7jJ4NIEp0TR+JsYoeTUuNX0yGMR0VQA8ZdzCU13j1Vg27D6Nu+a3aNKc?=
 =?us-ascii?Q?SkmbFnyr9YYwM/lvT1LWM78YfvAJyboohe+gGQs41zw12hQ6jxnsWpieM00m?=
 =?us-ascii?Q?4gNuuS9HmDyOsi/sGS4LAHwMWCxIaueCWhAbXLuEaMIVZLA6MMMD9uNsvHgp?=
 =?us-ascii?Q?jE1nwlwJ0dD6XZV2sOLScxu4H1wXUFFmeOFdop6BKlqxrFro62z65+rT88WV?=
 =?us-ascii?Q?qz+rHw2UjH3a0x1p068VSi73Rg03r+noSgLLtbKPlmzXsuh2Of7M50UzNFDJ?=
 =?us-ascii?Q?2dZs1f6b+gtnbRx5Za3gZEYsgRMzv2QFn/pw8AvpgUexXA16fErgakVVjdiD?=
 =?us-ascii?Q?gBR5S3MMihZifUjV0OaIJchJrPKkGIdKNrPSn4lC43jrlVZ3WFXChfyP9g7N?=
 =?us-ascii?Q?DBiuHpuHupHyMfz9Fpg7urHrUkg7hkM0nWrQTvRdqlh1rlHg6a2bHu3wm0AH?=
 =?us-ascii?Q?l5Bm8UwQlsgMkjAAPTQFdhxqa2FB+B6atjTKIAgM3QXj9oGJs0BkJw2NcBWr?=
 =?us-ascii?Q?FguUdX511YB9BfeHrCQoccwzvgxSMaZlwRqzxC+qz4yie6fJWIP0DGb9VDL6?=
 =?us-ascii?Q?iN17H0CvI2F9MGmFjCYOH1LYrZDcXe82yZe9+nxbPnIJzeEjl8QVVJZlKEL7?=
 =?us-ascii?Q?wISYC6fo7zlBzRkAc45ERwMJqdOVgxkIkjE6hsOWJoVbbfdgbCno8Lq1rYtg?=
 =?us-ascii?Q?hZRztAl/qBTtbDwvjpFL4W73AndwNM5mYwX0KlR8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vxMWvfnfE2q8NmejdahS8ADzOIdsuzDgKXsmNlIPW8fDuVhbbZyAjCUmM7OV1PIH3nWloFAx7qrUxOZ0bIMP9IZCk1VWOfY9+AG5B6mb4YxA5IIA+lW8RLSRZlEqxBaKhyqH6cjY9G6BSSUaqOij5jj+nY/LRNMc+3dXFJsg8fQl+nk0WTbMBN5ugp9ZOHFn5FR6V/9belXRpug3InJjKqDVPaiVWNEDvzIK1zRxCOeCfeDFpHDfF26tMYHVh4IxcEmJMaZdtWcTSYhsOSqG+VWti2GJLb9260brmRnn7sM8nbE2+wgPoRZ+PyjaTgQacCgYBlIomMzU8VnmNg/5AeMYNVRYaNC2atKFNO4ZcYNxwr+KWNlZQd8G7m8lsBCZ7bpJKsehq5OEZ9X9neG57D5Q9Xh7otNk3bSA1m2kKq70mIp8rTC3bAvsPq5WyP99OJJeao3drivVLpDaqd8PDHmvQCe9cV2m4WfGstgxJ8yzW0II+E4TmOAgK5yAxa/uvglIAjslkFJmEpS5NGGWmTOEmRtAG+6SCIpzqAhQOMAdze7jS8JHZ5/jZ/dqK9ZbHqY26Q1AXJF4MON9mB+g9Y6420uFTHb661nkD4w0hTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5eb4db-ca49-4b08-1e4f-08dd9c626a27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:34:25.9916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXlym/xxynb9kwzAv9+Y2VVNQssG8enI3cyD7J4J+rBQRQtd1bh/n2xlg1skNWkO/w27QjkIPnoXLlfqeeWYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260124
X-Proofpoint-GUID: bIPuexFPzSmVAZ-X1gA4oO5irYh3c25k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyNCBTYWx0ZWRfX5j/LC6aGbX51 itfxqs7YvLakF1QRGimZV0Oz97ubrUdIl9rdVDaFG9E8UZvT4XSe+YI4xg3pCz5ZcWFsz5zGNSu UxSV4kwJH87fVvkMxF1Zj8Rsc+GpADl8WHBoePhSCnCd1HABXsDSOSUZ+2e+jcfskRJKdXlCp1N
 RyrQ9vbNh6RcWWBpzLpsf7L12MkQyeSVzJ8Mez3SgHhzPqh3z0gGBtn8mgg0O7+GIU8WGYVtXVG 282It1hebEH5SzJcmHhmmOUe0T50ERQFheOBTWEx2TvYQbZwhd8jtNq/Wcw40kn1E+w0qvtGir2 ObQCHSlN2TcpHGKw40MP3HfobTYT1M1Lk1375Rn8Of4sf6OCB/1GkLSAOu3oFclcYeYWqI8np1m
 nrSzEl9I8YLvQS5bcuP05sTximqseigNYAxJIZNVXXrrTiIZbCma/64q/CmCqpFJ3TaIs4Xu
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68347bf5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=X-QcJBepILewBkgVfpEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: bIPuexFPzSmVAZ-X1gA4oO5irYh3c25k

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250521 14:20]:
> Add test to assert that we have now allowed merging of VMAs when KSM
> merging-by-default has been set by prctl(PR_SET_MEMORY_MERGE, ...).
> 
> We simply perform a trivial mapping of adjacent VMAs expecting a merge,
> however prior to recent changes implementing this mode earlier than before,
> these merges would not have succeeded.
> 
> Assert that we have fixed this!
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Tested-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> index c76646cdf6e6..2380a5a6a529 100644
> --- a/tools/testing/selftests/mm/merge.c
> +++ b/tools/testing/selftests/mm/merge.c
> @@ -2,10 +2,12 @@
>  
>  #define _GNU_SOURCE
>  #include "../kselftest_harness.h"
> +#include <linux/prctl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> +#include <sys/prctl.h>
>  #include <sys/wait.h>
>  #include "vm_util.h"
>  
> @@ -31,6 +33,11 @@ FIXTURE_TEARDOWN(merge)
>  {
>  	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
>  	ASSERT_EQ(close_procmap(&self->procmap), 0);
> +	/*
> +	 * Clear unconditionally, as some tests set this. It is no issue if this
> +	 * fails (KSM may be disabled for instance).
> +	 */
> +	prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
>  }
>  
>  TEST_F(merge, mprotect_unfaulted_left)
> @@ -452,4 +459,75 @@ TEST_F(merge, forked_source_vma)
>  	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
>  }
>  
> +TEST_F(merge, ksm_merge)
> +{
> +	unsigned int page_size = self->page_size;
> +	char *carveout = self->carveout;
> +	struct procmap_fd *procmap = &self->procmap;
> +	char *ptr, *ptr2;
> +	int err;
> +
> +	/*
> +	 * Map two R/W immediately adjacent to one another, they should
> +	 * trivially merge:
> +	 *
> +	 * |-----------|-----------|
> +	 * |    R/W    |    R/W    |
> +	 * |-----------|-----------|
> +	 *      ptr         ptr2
> +	 */
> +
> +	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> +
> +	/* Unmap the second half of this merged VMA. */
> +	ASSERT_EQ(munmap(ptr2, page_size), 0);
> +
> +	/* OK, now enable global KSM merge. We clear this on test teardown. */
> +	err = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> +	if (err == -1) {
> +		int errnum = errno;
> +
> +		/* Only non-failure case... */
> +		ASSERT_EQ(errnum, EINVAL);
> +		/* ...but indicates we should skip. */
> +		SKIP(return, "KSM memory merging not supported, skipping.");
> +	}
> +
> +	/*
> +	 * Now map a VMA adjacent to the existing that was just made
> +	 * VM_MERGEABLE, this should merge as well.
> +	 */
> +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> +
> +	/* Now this VMA altogether. */
> +	ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
> +
> +	/* Try the same operation as before, asserting this also merges fine. */
> +	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.49.0
> 

