Return-Path: <linux-fsdevel+bounces-66519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DF1C21E73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 20:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF4E84EE414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C223283129;
	Thu, 30 Oct 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQSVpKIn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vh4hursM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362E1E47A5;
	Thu, 30 Oct 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851857; cv=fail; b=ssgW0sMREpv6yxxKh4yDumvGVRBQU34BrPPePwJH0upR3pt2OKjRoBmzvOoFfiEcELKFoH7vSFzT9QIbxJBvCcj2f5ug6lZbEOreN1Sc0KzUgOYafL2nM3uNukEq6suiYAWs2DWf+bkZkkkB9BiXegEpb0s/FyHxvX2kfatUk+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851857; c=relaxed/simple;
	bh=LHU20p0tGIlmhPXcSI1HYTTNj6QJsmjEp6Cg2DhyG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1ZQkh7J3abC7mxPAoVL6zuBDMCJ8WibFVjqWR2dQmflTpdaNEilEwIHON1N1T/DpiULgKaBS5yCnS7HVz3UsWF/AK8fJj9/OxNxfssL5jPdJXoA6MQ+Sr7j+rzPXSF2xhoJTFvmbffeNxRqftTQH4E4Hj8bIlpkUUNXmvBLEUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQSVpKIn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vh4hursM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIK1j2025280;
	Thu, 30 Oct 2025 19:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LHU20p0tGIlmhPXcSI
	1HYTTNj6QJsmjEp6Cg2DhyG+4=; b=ZQSVpKInochPVp+gZFiJu2pR2+Z3rcguqO
	cwXLiSViucuye0S1F8tIgjaEAL7/C8fM4JzXgenseAG26c57P//dMTz73NDa4FD7
	ujmvRmowLbIj14HsqbHWkpNg037JgxDGlL5l4eiDaQcx5jhvLm0ZY6ZnTD8Q2e/J
	+/p9PBL+MSh3OIjPA5Azr6tvxgRfR4Ko1nHT8+ObmFvK6hTM9X4DcEzAguSUSiVg
	B6P+QoDy+d7sJEss1K6NY4h/dZWHmlUZy+5Zf4lNiGhwjk2w8b9Iu7aRD41kMnty
	HcPC50pCeieeqB/5g2gvSY5WfdkYghSF5QrFY2hHFKLwL5/gUR2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4d6q04f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:17:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIGTD1023479;
	Thu, 30 Oct 2025 19:17:08 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33w02xgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmOghS9re65ZURrfJxYM7xhhJCbG/ojFEJAI5S/CLSWcVf8mT3f/Iqw90F5KOwQVU8mBkIs/9JWhyQcisFbcLdfpPOc31o/LoAEKzF8p7XbzbmbrDkaagIrraW0Bfc/y23wBA7ApLAt6zvhFZ4tyAFUjmf75EiqUfBn6TAlq46fYqAqxpSh6XE+hNQSipImqpc9XNbWceo/HgAaT3Pv0f/eCMvi0L/c7wiWCRQmW4F46u+Wq4KE8Ih7NRnot/twGt9Neyyuge9Bn4nqLjwpjMJXdifYe8HOA81hFel2beciRwn7XLcfgjxcKRjuuE2c7wYG9rviZVW4lsxSpKxeR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHU20p0tGIlmhPXcSI1HYTTNj6QJsmjEp6Cg2DhyG+4=;
 b=Oh7nrX0VyUa/aXvN2Zy84415+iiNqaY2tXAZzgbgF4vNEdvCdGViP/Pcjeav9nivnZhDLLLNG67MpNv/CDiRjcJCa8TETgeRcl8Rpa8/qDbNqokJ0MHIifyEPSSxjk9sqd/Yk1yiAHSNxqC/SQ3+cDiOCvKga3hcYXyT/rLfXRUzzFy3JWCZYxPjzhI3WPzgsfrLE7eVhqFdZnQEIRT+YLiZtK+WZKwR418KP+PLwhJWbUlj4f6j1JFVzaNzxreFY1K4p5UKJ2WrR9Hi34oFU9TZE1BIhqwUNxFm0q/xcm9ecorvuSAkMe657wI6cQElTayzig83FyGWRtlTMFvR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHU20p0tGIlmhPXcSI1HYTTNj6QJsmjEp6Cg2DhyG+4=;
 b=Vh4hursMDmN7vTk3KyUmpjS6yR/mMkxxhr/MDtc3LRrjiG09CBisiKPyERu1gdRs+yGcCXFAH9p2aLfSDM3ruXZA1e96iaBbAdWUjHewvV4ajiBSBUjdL6dmeRYjhx5BRoBb4+T79lgD+KfH0ulH+vDNRZMvDdrknL/GiLpPMR4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Thu, 30 Oct 2025 19:16:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 19:16:59 +0000
Date: Thu, 30 Oct 2025 19:16:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <6334993b-ead7-472f-bb82-bb7d6f15f3ef@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
 <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
X-ClientProxiedBy: LO6P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d01796b-bbc1-4e42-0e7f-08de17e8e5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kv8HqkXJ9/WUIZj9kfi+ELHqmtZTBMkUR1eeWk+CnX/4fyUnMXG/5E/BhcYq?=
 =?us-ascii?Q?JPlFAg+EJxr73OJRIVsPDXdtt9TonG2Z1F16rlUZnb73x97LnDVor5d3JAV5?=
 =?us-ascii?Q?5MR5E3CI1vmH6Pi6mBWlnQgzwduLSKTuNez2v1BQx6JA96eFbH1RfIuP7SiW?=
 =?us-ascii?Q?GTClR2VNUgahMCbd8erd995EvJR2BSru8Yb0Lf5fohBuyx/SDD39lTe9JuYj?=
 =?us-ascii?Q?eoTLiuYe8krgPq/pYnmuqYVABHIjLphR/sI59T6FjLgao6Hm9NGTbr8qlBc+?=
 =?us-ascii?Q?Cf6sM30uA5+z0u65fRjsY9Al2WwicZ0j2KyQFnuSv45q+/lZcj/1Jo0Lg32Y?=
 =?us-ascii?Q?ynQLKhYeQOu+FeyPjwfVqmW5FKGUeZ24n3AWetGQxN05w0niYXeV76Gk3YHH?=
 =?us-ascii?Q?Amas2LH3iWOSWSwpwDcuzvTIIjYQTDIIss+qrv3jZIzAAVPsLCVohP4TsRL0?=
 =?us-ascii?Q?nHB8b2HAg03YFgnX21t14MnDtVLSMDSuZeoVjSE4meaLTtc1yOAqJbOrqVa0?=
 =?us-ascii?Q?E6T8dlqN2qqGGQ5HKIg7kwqLmp0d9ivnDEceTzdI2q/VowRljL06BL/sBMrW?=
 =?us-ascii?Q?46v3cZHTHUC6djbsJdbCCy7QDtziC7FRDY1iwRZ/cj3HW/9HkycCmZic+ytE?=
 =?us-ascii?Q?MfsYIt2Ez7sBn1TrR5l4Um+Shcun0OIuy8SEfNDpYOEWPWLslcAAeg57WLqX?=
 =?us-ascii?Q?9ysX6eXGqCr7N41cB83v2a1q6kZRvQJ8GFHMjfYhEfVTNJH00l3H+ksVDmNb?=
 =?us-ascii?Q?QFv0wAcOY/Rr7Gm3++JJrYlQVbRDSdXv6cWRIe2awNfWcCvZjh9K0xrM4rMX?=
 =?us-ascii?Q?H3ufbGudSXyLIAWb7IUAN1R9G4Dx9b47ZOQUvcmEwATghd+FFk1eHapN7Du8?=
 =?us-ascii?Q?OlwRuJPL9dKVmEqtYxvrXw2mAEZ1bx2iZA4H6P0WmoNZbrpdFy1MLQyDsVvo?=
 =?us-ascii?Q?3j9AY1maEfoGReKbTz2vO7NWIGEua0ZpUxnmhDjXZEJtim6RauezrxQlgLaj?=
 =?us-ascii?Q?qHWtiVNbWPB0fjsfFoWVXDjBYVHaksCeScRWp95LuH/d6EP+CAkrhKdVi/oC?=
 =?us-ascii?Q?Jz3pLPzpnJ5vGHQhx0dipaBazHfN7KzLVmRvFta8kGMUNBRep1+6+7WwMkdx?=
 =?us-ascii?Q?Af/G3hvt8Ubjm+RT152QEgtfGOrE3YzzKbRgRprl+Newfz/mWLXm+vLgxAJe?=
 =?us-ascii?Q?mauOeCn4iJWjkVmN/NSe7MEFITJOO3CYp7Hda0IXeXFRRi7ERftBnPnZ4ntl?=
 =?us-ascii?Q?XTyaZn+PAsnqsACDuGfo4aUDdPxFvepliQR8Gin8xoTE3er+oFTEEx6aIqMy?=
 =?us-ascii?Q?GWWQpj6Ia1eA8AT9Z9jI4R85ljXJSpRz6bMIsYmXwVEr35vVbWluvDxuC8iv?=
 =?us-ascii?Q?PSrKXVL3KxQgeILZntqOPxhHfY2/Oh0D+qNmAOVwI8oaeZeKFzBgbKbM0QKR?=
 =?us-ascii?Q?3ECEUVC+w5Ax2hnw8ChqzVE9niOh43Or?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njMzN0uDGjSqGFsPKhpHWYHecc+S60W+gaB68kUHGnqorT5c56PYn+ERhnEc?=
 =?us-ascii?Q?iH2ruxuc8MN8Wl543zxKBZC3muf62xC9VZQQeVVzG+tT4fu1IEKab0pIKNUn?=
 =?us-ascii?Q?uesosCxlmKQ7/08jHOxE5CyuB1BMEy/RhH9Iwn4D6cH4Q2Yy9FA7CabBEvF2?=
 =?us-ascii?Q?yetjeZn/n7lMoZwlunQ1T6JSTV9DL+Bm8RTmA+0wQaI3NewwwthNtvHB2uHr?=
 =?us-ascii?Q?QfnfIK8X3XB8TsCqKnv8INct/fdd4YmbYUHm0QECLiuwL6RrVbZn4NCmY095?=
 =?us-ascii?Q?1chsbzXbf/aH1kKD6I9YD/fCemTkDbO7EhfxLon9x7fQJK29sJkp7B1MBuuO?=
 =?us-ascii?Q?Gj5Sz7myWF+u0rGpQR9o/7L5X24Tiw4svC//zyEu7AT+rpRQ+fEvO5e3ZodH?=
 =?us-ascii?Q?GfrsNv5rrn8e+irg8lkjX7jQZbtYHv9V9arFkGquLv76mHOW4KqwR3Af4Fmi?=
 =?us-ascii?Q?ESzBF6xVY9QQ1wfmHR0SRwH+DDndTC3h7R6MxP2LC0JoSG14KL7O2RkKMKt/?=
 =?us-ascii?Q?dGEhTFF4cQ/zJPu9v48pZKAiix5A3m6PyH3ZnidTW77Cj3BuTbrOvksVxG7y?=
 =?us-ascii?Q?IhiqmnfKjPmT6EJvcO1CDZRjmjkPxFjnusYL12w3PO/ousQ1esGRMiXWJ/X9?=
 =?us-ascii?Q?xYXdMz/FxUhXodcYap/i+s8RfiRClgU7+tClrvcbT2eOZ6QGXGfG/KoDn5wn?=
 =?us-ascii?Q?FA3jVWA8QSGeRTxROv2Ps7mIiX5kgQFaQIJ8EjehHvkIs8o2z4PB81+kGgBA?=
 =?us-ascii?Q?vIOJwB/Mlnv2UMiOnBNbduN1IJi8zJ6HIs67CeRHBXaEIMLXiBrNhtaawRjq?=
 =?us-ascii?Q?74zo+i7Iwc9O2dGuZ1biwRxszocQm9JeFopoDoYEi/3Zv6jNWXWe7ihDs+yX?=
 =?us-ascii?Q?S/izHJpNQEv1zhqnpgIJ0Hzp/ua7/IFXtujkOL3VjVMkmsQuYePsNJZLk//v?=
 =?us-ascii?Q?sqxNKQlNFFQojptwchSVP8sLMj2xbNGvsq5xMDz63Ng4pWjilxlpCRqlLjD9?=
 =?us-ascii?Q?NoVq+R2rG0m+mhGuwYA5wXvoUn3zfRDcr/SOqctsWZFEFbA+v065zDq1Mnd2?=
 =?us-ascii?Q?Vb/42zcnkhSw20pLlQQrRsgfzKOTV7n2GVWfNKXhpbIn2Mw5qlCJsdjuAIUS?=
 =?us-ascii?Q?dUEhOg/Azl+sp0Ih8s4ETilvHmei8Jn/Di/CG8vt+nHqe3zM/PNPBSVAvhae?=
 =?us-ascii?Q?T03UYFYP2Rxi1S9oyurpfbG9Jxu8Q+rTz1HIHomWTAZF4R3vpwyp3bfUKf29?=
 =?us-ascii?Q?D9+bYmH7W30ANq/G60PMSx/k5PQFU8Xlt73JtPeZnaUPlxeCPfOd1Mw6jmFl?=
 =?us-ascii?Q?p6RDFpBBvewjD+c5o3qwTnxecVIZcHvyEKegzlCsHlaGaEerQ5qSOZtLvs3P?=
 =?us-ascii?Q?0rt0YduAOoCGOD5rh4gJ5OExtPi5n8zBqBx5pQnW93IOMYMJtcEYk7qLwQq4?=
 =?us-ascii?Q?jpFrI9PuzpPmHO7riCVtsbV4o9/9sFCFrk3c8aSFmc+TbtWVfBLcdFNa6tOY?=
 =?us-ascii?Q?hh2tvGZzM7haevx1CYbPDiCsOEQDyNldoppj8/fGjnEUUuz30T6x1WMGoW6v?=
 =?us-ascii?Q?kyqsRMnYkVMgFxAurW50X8HkpJr3S8tTeteY2ztcmETn5d5wqYe72tj+mgol?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BSII1m3R8ZwI2aeptqmuVm3rog9rFl6uI6c4Ia+pJd/yi/3Yb41V+WblhI0Wb8ZkqLqfnrR9ffYONIBsRL2gVjx6vq03VrpJj175iWysHr82rrs07KtJ8lz6ke8S/dtowuUKtxr7Nj6peyS2AhRBG0GCc51OLA44E2VcNv9fs0ClZO4PYBNe9sXe9i/+R4RhGvREUc6frdEdVNYNXcHr7Iqz9cue5pqaQEKRI9Fz8OzGqRvamFizP9yzq+8aEvW1jHlCnODEpimE2j/t8D0ckokjyUp40P6ByW7Yzqkx9hoNnW9W5A3lEmiVOL5QiE8JlsSDgfVUYnJd88zI3HzjLaqbSd6FxJdwk5OPT50Nxfc3KYCazvh0rQtgHDFrXVmUtOjYYev75Rs6g/bW4Z8oTFzi18gwFLDH+AxfRGD7mwWEo5CR191WwbhOd6otQ4GejXeIdVOU+3XBhp0IqdHZTqF4759IBPaW0Qmz2GvYJBJReT8uA83VW53n1kD+U9wfK7grKBSVh8QHxh0jyzdWqCFwBBAzsZRU2b4ePU13ee9L5AU8LuE8rd6LGjcnydOiHO0/Sn5Bz4uJnCcULGI7pYBq2lABoTWwaqS8Yl88zVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d01796b-bbc1-4e42-0e7f-08de17e8e5d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:16:59.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfD8dckB5loCYyrKSpldkA8x+8xMHR5+WSFOmBm16d0B/6dqOSWVaw5xmf3A5Ml1iezSEYcijS/5vLizWCYdSB7MrOH5falqx4I5mr5HPJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfX+WUxPd/bo4a8
 buvugtdD3YKWBlkJ9VFpozMXKXgqhywEWeeiSBtFBHlACK51j5nriUqJ3Yljm1VM6YIzBab44lD
 EQvi56R6037itkhSexmQc+wi0bwluGjbYsaby66OvL2k1lzYkA1WETqK3O9HI3hrjqvYjSWBiQd
 H4Liv5i0ROdBXDLKRV6ZdQDQPM6UNonIAQOzFTrUSuVbaUmf7B0DHHFPbbA2p6NGmCSQSkrYw0v
 dY82V+OesXnSAV3e526LR8TRHgk88q30iBmaCetPIBeeHVWVi5aeVd/IUh2g7aCb/e9UxYsiwcQ
 eulKE/86S5cB0Rb/scC/WS6aT+3lXY5qAS1gVIFuf+3YPOmQSkT2ofnFVpThPw/Y2HD2+oB0c1M
 FksE6yZVnVKVy6ta3tc0erkLqfSn0A==
X-Proofpoint-GUID: 4nwq5WcHNZEHnw7O8kb-gJRzgiTzjsEH
X-Authority-Analysis: v=2.4 cv=bLob4f+Z c=1 sm=1 tr=0 ts=6903b9b5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bxkbsJtV4hA7KuL9enYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4nwq5WcHNZEHnw7O8kb-gJRzgiTzjsEH

On Thu, Oct 30, 2025 at 07:31:26PM +0100, Vlastimil Babka wrote:
> On 10/30/25 17:43, Lorenzo Stoakes wrote:
> > On Thu, Oct 30, 2025 at 04:31:56PM +0000, Pedro Falcato wrote:
> >> On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
> >> > On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> >> > > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> >> > > > Currently, if a user needs to determine if guard regions are present in a
> >> > > > range, they have to scan all VMAs (or have knowledge of which ones might
> >> > > > have guard regions).
> >> > > >
> >> > > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> >> > > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> >> > > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> >> > > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> >> > > > operation at a virtual address level.
> >> > > >
> >> > > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> >> > > > that guard regions exist in ranges.
> >> > > >
> >> > > > This patch remedies the situation by establishing a new VMA flag,
> >> > > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> >> > > > uncertain because we cannot reasonably determine whether a
> >> > > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> >> > > > additionally VMAs may change across merge/split).
> >> > > >
> >> > > > We utilise 0x800 for this flag which makes it available to 32-bit
> >> > > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> >> > > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> >> > > > bee reused yet.
> >> > > >
> >> > > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> >> > > > lock (and also VMA write lock) whereas previously it did not, but this
> >> > > > seems a reasonable overhead.
> >> > >
> >> > > Do you though? Could it be possible to simply atomically set the flag with
> >> > > the read lock held? This would make it so we can't split the VMA (and tightly
> >> >
> >> > VMA flags are not accessed atomically so no I don't think we can do that in any
> >> > workable way.
> >> >
> >>
> >> FWIW I think you could work it as an atomic flag and treat those races as benign
> >> (this one, at least).
> >
> > It's not benign as we need to ensure that page tables are correctly propagated
> > on fork.
>
> Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improvement
> over the current MADVISE_MMAP_READ_LOCK), together with the atomic flag
> setting? I think the places that could race with us to cause RMW use vma

I mean, I just spoke about why I didn't think introducing an entirely new
(afaik) one-sided atomic VMA flag write, so maybe deal with that first before
proposing something new...

We probably can use VMA read lock (actually introduced _after_ I introduced
guard regions I believe) if we do not need the write lock.

But I need to hear a compelling non-hand waving reason for introducing an
entirely new mechanism like that which is going to violate an assumption we have
about VMA flags everywhere...

> write lock so that would be excluded. Fork AFAICS unfortunately doesn't (for
> the oldmm) and it probably would't make sense to start doing it. Maybe we

I mean, the entire point is fork behaviour, so that makes this a non-starter...

> could think of something to deal with this special case...

If we implemented that I guess we'd have to atomically read the VMA flag,
but a race between the two would be very problematic.

Note that we'd also have to have a new mechanism for writing a VMA flag
(this is entirely novel now) because vm_flags_set() itself _literally_ has
vma_start_write() in it.

We'd also have to audit any and all cases where VMA flags are accessed to
ensure that this new novel method does not cause any issues.

We're also inviting others to do this kind of thing (e.g. drivers).

Seems dangerous in itself.

In any case, since you're now asking for something entirely novel, you
really have to provide a compelling argument as to why we can't write lock.

We can't allow races there or we break forking.

>
> >>
> >> > I also don't think it's at all necessary, see below.
> >> >
> >> > > define what "may have a guard page"), but it sounds much better than introducing
> >> > > lock contention. I don't think it is reasonable to add a write lock to a feature
> >> > > that may be used by such things as thread stack allocation, malloc, etc.
> >> >
> >> > What lock contention? It's per-VMA so the contention is limited to the VMA in
> >> > question, and only over the span of time you are setting the gaurd region.
> >>
> >> Don't we always need to take the mmap write lock when grabbing a VMA write
> >> lock as well?
> >
> > Yup. But at the same time you're doing the kind of operations that'd use this
> > you'd already be taking the lock anyway.
> >
> > You don't hold it for long and you won't be doing this any more often than you'd
> > be doing other write operations, which you're also not going to be holding up
> > faults on other VMAs either (they can access other VMAs despite mmap write lock
> > being held), so I don't think there's ay issue here.
> >
> >>
> >> > When allocating thread stacks you'll be mapping things into memory which... take
> >> > the write lock. malloc() if it goes to the kernel will also take the write lock.
> >> >
> >>
> >> But yes, good point, you're already serializing anyway. I don't think this is
> >> a big deal.
> >
> > Indeed
>
> Besides thread stacks, I'm thinking of the userspace allocators usecase

Thread stacks require mmap/VMA write lock to establish no?

> (jemalloc etc) where guard regions were supposed to allow a cheap
> use-after-free protection by replacing their existing
> MADV_DONTNEED/MADV_FREE use with MADV_GUARD_INSTALL.

First I'm hearing of this as far as I can recall... maybe worth mentioning
at the time?

> Now MADV_DONTNEED/MADV_FREE use MADVISE_VMA_READ_LOCK, and guard regions
> moves from (worse but still reasonable) MADVISE_MMAP_READ_LOCK to the heavy

I think you're hand waving a lot here, do you have data to back anything up
here?

Be good to get some timings with the different locks and some indication that
the contention is meaningful or that this installation is in a hot-path.

Are these users not in any way manipulating VMAs (seems odd for a malloc but
anyway)? Because then you're already having to take the write lock to do so.

process_madvise() can be used to hold the lock over the whole operation
more efficiently for multiple guard region installations.

> MADVISE_MMAP_WRITE_LOCK. I'm afraid this might be too heavy price for that
> usecase :(

Based on what? Provide some data or argument to back this up please. Since
you're essentially asking me to either throw away my series or implement a
risky novel means of manipulating VMA flags I think you're going to have to
do better than hand waving.

Thanks.

