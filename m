Return-Path: <linux-fsdevel+bounces-42358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB05A40DA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31265172BF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FB1FECCB;
	Sun, 23 Feb 2025 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gSrCFIpg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="StX+PbtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1A1DA63D
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303100; cv=fail; b=jxY1FEAbcIBplRZi6mpYCWPqDKRtMrI+37BTuGl3PtfJrh0KkvVoiia8NKyVuPMf0uZQiscaHyX/zcRokIS0hpUznXM7/lMqsV+0NZIYikdisVfdBVvpINdbpj1tqIcbk1KqvD31/Cz37fHzQMr7QK71BLPL+93AF/nU3bgkc5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303100; c=relaxed/simple;
	bh=PAxYQh/gAAj6Bl3Gqx5v1Am8XQPSP21lv2dsYp2uQHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qw+hQolVMZ/pOY0IsMSlCskrk5q/GDY62ZrNXo/CPecEvVBi+cDH+YtPPUHRZG0u2PstboK1UeXBIBT3o5C7luDGhgQBeY/WCUDogtlIU6svzRpRe8i1TIotQoXyU+5xUykTRgjgNaefAutDhFxyFQ0wEwLsTiI7W8+FB5Ab5Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gSrCFIpg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=StX+PbtF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7h0oT008979;
	Sun, 23 Feb 2025 09:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8gMPomdNxhEXxxD+GM8BbtZITSxsFqVqykhXoMDFMDg=; b=
	gSrCFIpgOJGtwpjB1+fxk1h9TdYHi9NWnKJYQEutaXIOnsam9EMaDx6zg61sHBg3
	IGILUIlLucD17IPl/A33gzkopaN9zaChKCClna7Kd1Ln4BxbOMAKIX2gA0gStc/j
	+2uuSHY7JZt12GWWgyAYmmBcPGtu9DfYaIFDOS82wqNFkIiTznKF4Vs3hjYDcn0L
	TOz3qlYqlGx6WCX/+x4I73Bq/OexuQ7keY6cHXbCWgPoEfCmbiiR0Aki1ht0+jrP
	NF9W82dP0Qk7zXSB1mL/VYTb0hNJedgYBStLoWbhEAyfvfljvH7UyQpv3rH5yEeF
	2IIwr5M6dbQrAzGoZcnckQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66s91xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:31:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51N7F0nF007609;
	Sun, 23 Feb 2025 09:31:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cn0dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnv+8gc6VReq8taDPcRHTcslHbFfDSKODQah9oBlL2Elcf2i9I/ebPt0JSr5AFLb0ew4+hX9znxGTZoMQWepbNnGkRfbFVI5DfKX8dDEFgLz9lE3ALJIxlaXuDSuGMt8bvyKlw4jXgYgPzEn+qgJEyRG4gc6tvLLX/DRdL3CnJmrO+vw1mYm2LoVyhhQxsbW5qIL4jkPxvCmv8dIwk9T6zhqznxcCphLKwtv9TTbz4iKZwTs4UhfJmUvapESzqpXrF+JFXg31l07gZ1T4ZPGXwe4UwUJnRdD+lPGXtUzfH0lAT5YdiBWFy3J0XIuoppWi2Db43KRrOfuNQWYwEth8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gMPomdNxhEXxxD+GM8BbtZITSxsFqVqykhXoMDFMDg=;
 b=Yl9TirDw7JfEAxZsGtTZkZcQ0wqu2KK+pM+x5yHHbS6yySKEBMFmNZrZ+lr+2ATkcVtJgyE1GjbFuzkjLFxigex5YkVUy/BfcsCN6i3WqslCEfGThmzl+lLANkbNIta1C+XmsnZwZ+5Em4+lWtM9TzQqJlYJLXiStwxhA7Manq+f+cOcHmxkzUVdma9J7Orz1b/YovgF7W+ZYYnqtzxsDkBlA24kWhMVNeRkrx4TYSkhLDMIZ+oqkinFqDlZNVat9hxJQn/9MaR4XjlmIxo+3IIVCcvWfQemQlySeQ7MrUFoq2AiDKGF0fvFiMnq+xUPbwCU3Iii3cRgCDwPJSI2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gMPomdNxhEXxxD+GM8BbtZITSxsFqVqykhXoMDFMDg=;
 b=StX+PbtFcNihu4n4ciJvIzmPHQ6xBggIBx2mqeXb9uFAnnQ+s+tX5zt+wfp5jqKTsXvNrsCcfleVfMd6/bpmJMNvgo0Jnup2apLpZZxuwoqC6nClnC+7LeWhofN0/PQMQyPrax4l0JCYC2IGEE/Ti+x8ec4JhWEAqa4AJduEsaM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB5628.namprd10.prod.outlook.com (2603:10b6:510:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 09:31:00 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 09:31:00 +0000
Date: Sun, 23 Feb 2025 09:30:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        lsf-pc@lists.linux-foundation.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
Message-ID: <31e946de-b8d5-4681-b2ac-006360895a87@lucifer.local>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <dsvx2hyrdnv7smcrgpicqirwsmq5mcmbl7dbwmrx7dobrnxpbh@nxdhmkszdzyk>
 <CAC_TJvepQjR03qa-9C+kL4Or4COUFjZevv+-0gTUFYgNdquq-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvepQjR03qa-9C+kL4Or4COUFjZevv+-0gTUFYgNdquq-Q@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: e23224f5-3ab6-48bd-aa5d-08dd53ecc88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTAyTW1rZnhhRlYxejBUOGoyczltUXZDbWx1VWRBdmNSeWErVW9namZuUkxi?=
 =?utf-8?B?WDdOVytreUxRWlNIcXp0Y2hidkhiMCtUeTlybUFFTlN4RjVtVzRZbFMwdkN5?=
 =?utf-8?B?Vm0zSUl0MGRRUjc3emIwQ096Z3c4dEV3aGxUTXJyTUgyeWs1Sy9xSXlBcHk1?=
 =?utf-8?B?VzVtRWx1TDBicWJVNjE1QnlPbFlEc00wQ1NlNXE3T3E4NzduY1QrcFZtdExQ?=
 =?utf-8?B?TXJwaWlZb2dqZkY2N2VmSmxtTXE0Y0NyVXNJUVNSalVHRFBnZFM4WFREQWdv?=
 =?utf-8?B?bEFXVTBlTDFWUjRlMkcza3plNkFrZlA4U28zemRmRm0zMEdSMFEyZStSUWhw?=
 =?utf-8?B?aDN0YzBXNkQ3d3dmTVlLY1BDMys3OHVtcmxQTEFub25qN08zdGdzM0kxK2lX?=
 =?utf-8?B?cGFkOW1Md1ZKL2wwMkczdnVnKzdXTXA5ZzZoNFlvalpsc0NFTG5XWWtzaGty?=
 =?utf-8?B?THRYd1J5SElCalFucWo5VlNWcDJKa2dhN3Rjckg4bUc1N2laODNFY0xhckRW?=
 =?utf-8?B?WSsyYllKTlQzN01DTkhsVDh4OUE0RzJuY2ptaHMxVlVEemhqTS84OXRhTDRO?=
 =?utf-8?B?c0dGWVpDd2VxSVdtN1RrZnl4T1BFTmxocDkvWGovQ3dkUVluUHk2TytFUmxB?=
 =?utf-8?B?RFdldzVDU3JCQW8wNUQ5MzA0WHlLclV0SmljOXRFTk5uYVUxakJpZ1NIa2xO?=
 =?utf-8?B?TCtXV2xUZTdYM0tPQTgwWFZHdEpITVJ3TENLdFkrcHVvZUFTajZuZExtdm1Z?=
 =?utf-8?B?TEtVc3cxVDhKTWxhWWcwSXcxY3p3N0JxV3MxY05hSUpuM2o0R0h6TzJYcXI4?=
 =?utf-8?B?MnhHU3JxLzFMUWFncG8zRWZnMmxhTnhNajVTMUV5b1pnM01vNnFxT0IwSEg3?=
 =?utf-8?B?L01PQkJvQVNsQW9hNzNHN3E4UytUTlJvNmdyQWUxejBJN1ZWNWVoaG9wOFlm?=
 =?utf-8?B?WXVkSGdEbWN3YituR1c3Y3B6RUYrdVdsbUIwSlk3em9OOTVWRENvRHdaNnV3?=
 =?utf-8?B?eWlaaHBnRjU5UkNVNzZIdnVXRXpPSzEyaUNSYU1oajVSWEJKbWl1RERqWDlo?=
 =?utf-8?B?V2d2Q3BDZzUwckhvOGI5M1hKTVZ0ZzVzUE9lWTVDSG9GSFkzYklIbGFlRFVI?=
 =?utf-8?B?UFdYMXI5VldjTlA2STE1ZFNPRTBTTmd6S2l2ZGErZDAxRktMUlVJK2thVUtl?=
 =?utf-8?B?TXA1ZytkeDJzS3oxSjRVMU1CMURMQzYxM1lkeENKekQzdjBTT0xrMElUZWRj?=
 =?utf-8?B?Ymx1NzNOWHlhU21LTW5FQ1NqZUVZWU5zM3dWYUdQN2JzZ0ErYytrTk1wak5U?=
 =?utf-8?B?Nis4VVRla1JodmthV2RMb2VkK0Y4TGh0S2dtVnFwWEtvd3BVTVZBY2U5YmtL?=
 =?utf-8?B?cUpBWEtxZ1pzUEMyYlhVOVVUUWIxSEs0cHhhVXNFSWc4TTErcCtBRjJCb041?=
 =?utf-8?B?V2FqUGwxcTlDUGo0UnpDaDA5Ri9oc0pNOHRwT01OTVZrWVBzVDg2bmJUUERn?=
 =?utf-8?B?ZStXNnRpK0pMUk9LNUVWSGliKzk2d3hwYkc4U2NQVW9rMEJaZ2JLWS9INW92?=
 =?utf-8?B?QkUva09hR3hFeGlsQmN2R0RySHB5STJYQlYzc05iYXhKQmhWZWdqbUZhK3lw?=
 =?utf-8?B?V3VpbXFReDlkNk9oMC93bTdaUWZNUUxKa2FXWmJxSm55R3M0L0N4UjdGQWE2?=
 =?utf-8?B?akVHQ3k2Rkw1Y2pQd0FFMHl1V2thbHlIS1ZaZ200eTJUelZCVSsrY3htczdG?=
 =?utf-8?B?b0dPcUpTNW11ekt5MUlTRkkyUWRSMmtONGhMWGlISFZoWHd0NzdaN1JjMzZV?=
 =?utf-8?B?b1VlTkJnMDZ2RGJyTXZaNkZ4Umw2a1I1UzR6eGVyanFTRWE0ZU5QWWowRGln?=
 =?utf-8?Q?ZXd2jQ9vEiuTi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlZKcWlXYmxxYnFneVpxd2xNKytGL0VsaDBCaTBsMWR2QmtBdGN1UFVrWEJx?=
 =?utf-8?B?Uk1FazZpZVR3ZFB5OTFtcENGRFlVWlYrT0VqRmpEZ3ZVRG5XcEtpUVJqQmEx?=
 =?utf-8?B?K1dobklDTWN5SkVOTERFS0NvcDlVUlFRL0Ntb2xEenZGdHZHc1g2SnVnT2dG?=
 =?utf-8?B?NFlaSTVBTk1RdWorbTgrR0lWdSs4cDY3cVhnWk13WnJEUm4rOGFrYzJBQWlt?=
 =?utf-8?B?TWdVRmFZRU9sZzdOSGR0SjI4N1hJSHU2TU9MUThMaXAwZFhRSCtPSkxicEFo?=
 =?utf-8?B?MFdQRStVZGRldEsydE9sZXlPdFlaVHZiQy9iSkUraC8yNVZNcEcvN215Q3Z3?=
 =?utf-8?B?VEZDSmNHTXYxWWN6dDdpUDM5a3I0M1hhM3hRU1lnak9Lb29ONnp6MmdMNDIr?=
 =?utf-8?B?QkFUbVczNzhzSkpLcldyTkJ0VFhIeWdrK2JienBocDYyTE5QWHFFWXRWbFBT?=
 =?utf-8?B?NjRQVjlpbExpTVBGazBFRTNlR1liYjZMN3Y4dUlpWk00YnA4d0JGOGMvb0ph?=
 =?utf-8?B?OVpjRDVnOUhScTFOZnJEaHNKOGI2YlAvZDJrUTYyTCtWRHIzUzh4cFhMN0pJ?=
 =?utf-8?B?TXZ5bzFXOWZnQVl2NDczTG9RWUoxWG9lNkIxR2lOUVBGMS8xWHVqa2hEUWhU?=
 =?utf-8?B?U1lwaU5MODNxOTBTdmYvckQ4WGtkU05SMGdNQmhzSnpWNG1CZUJtTElvZFZT?=
 =?utf-8?B?V2NUaXBuUzVtenhvenZCeVRDcFV3N3U5NE14c3B1NG8yN3NVRGhaanpBTTRj?=
 =?utf-8?B?U3JUdUFLZWxldXhIa0UxSUtvOWhySTd4ZHJrVDFiL2NxQVlKQ2IvS0ltdDh5?=
 =?utf-8?B?K2hyaWtzVDJ1N002RFY3QndvTWlrSWRQVndlWG1wOWxQY2lTNzY1MUZhYkVR?=
 =?utf-8?B?MUI0cFpCTlhsZzVrYy9ya042cFBkdlpUdzR0by9JU1ZXS25wQ21hZTJXWmFX?=
 =?utf-8?B?eGd0YitVVmVaT010VVhDRmtSMWdEemNjc081R1c5b0QwMVYvTy9NU0dvT1FE?=
 =?utf-8?B?T2gxKy9mMlBnWkUybWJwS0RrZ282TjhjVnp6dzUvZmVQcUlHbEkxN0g0bEhC?=
 =?utf-8?B?SGIrRlFha3JRREVvNnlTTmFLNUVFV3lNWVdXU3lQQ0RTQit2azVkaFp0ajdk?=
 =?utf-8?B?dU5ZWENHUVVRZWpzUTlyMW9vbGlVY0ZaalNyRDVQM3dQOXJZMHBuODgyaFRz?=
 =?utf-8?B?ajg3V1BCOERIMkFBemcyUk00Q24yZy9EclVQM211VmR4M0k2UndFNGMvUFNs?=
 =?utf-8?B?eGcva1pRaDlBd05tNlBVTmd0YVJnQmxHK2M0MmkvaXFSNjlQQjhmMHpMWG00?=
 =?utf-8?B?cldwK3BUcGFHeGs0OEUyd0xJNDFYTWwzSEZOdE9Cd0RGcyt6YnhHTkd2THpT?=
 =?utf-8?B?K3l0NWM5ajQ0ODhaZUhuekJHV0RERXZRZ3RoM01uTTkzVnFQU3I5Q3JBckVF?=
 =?utf-8?B?RnFTWnFnZXhiUUVDWEg2WUlWT0JxVkQ4OURORWVPRitxWERhUWZXS0ZPZEJB?=
 =?utf-8?B?QmZIZlY4Y256MHpYbUZtL1Y5K2l1RXdLenZJdlY2ZXhETHEwQW1pUG5nanM2?=
 =?utf-8?B?Sm4rR3BySElNVWR4cURhUzM1a3RKVlljaDhaclhyQnlYUnBvczg2TTd6ekNS?=
 =?utf-8?B?VHRnczJhbWEvamxNcjVFM05vTUJtdUFmTlUxQkFEd1hDcERGK3R3UGxxL2N1?=
 =?utf-8?B?eWI3V3NteVNmb0hRa3dpayswMVJTaUFNVStRbjcyamgrZ2srNDdVdFNKWitE?=
 =?utf-8?B?YU9TUkcvR21neWJXU3hRKyttL1RLT1VDTGEzWHJ3bE5FM050b0NLSXJ0ZElV?=
 =?utf-8?B?TDhjZmFDcXB5M3h1czZvUk0yM3N0cGo2dEZhbXEwYWtLMXZETHVSNHRYdHd1?=
 =?utf-8?B?bHhrN0xwQlNpd1JlcElZNkxOb3JKUW1XNGFPK3lXbVNTbktkZE42Z2RpM0dk?=
 =?utf-8?B?VmcrNmsrMGtNNHZDakExK3RIQ1dEL2JvZEZyQk4yMzB5ZUhSOEl1U29IZFhj?=
 =?utf-8?B?bFI2NHFXamUvcmRId2VsM0lHRjJnRkQ5VzlXOWtRZXlEWUdsZFErZXVMSXRh?=
 =?utf-8?B?aEcwT2xWczdDTEFUekxPYXVCUnlrUUEwNG1iMDkyQVVjaEl1Qk16UTY2T0tS?=
 =?utf-8?B?TitoSFgySnZrOWI4RTBucXI3eWNiUTMrTXFZNHV3YVJTRENaYWY2OUtNNzhr?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wtl1dwq18Tj9+evNB4N4Owqv7NCjjSsNw5d4saxyc/LiNZ7Fg+tv88vXXny5GaElVgLpNEUaUIO96+p0Xm0cL/N204sNHI6sqXyNadHwJGmNXoPQnwmNKtqCojvDzq5zf6PqzasAQqBf+nPiXd20kQK3OHDeMYcJerAURDatRqSndwCUy4aqLqWsqK71KwzSVH34gfNTBZoclomNsQOmI55uCPbFT6YB2ncLof8xobIw63ah1gDLddBkGpiUWKXKti4geO3au2U0ctLdtQ1TMURhBhCSMWehO2Zu4Ru07q+G96DB9ocEskyR/VtHDS/3WqpFIiJmFn0noCADECbmGV1orgEU2tnkP9PT76IdB2ztrXwOL3MGKz1Od8EkI4PaIWfzQ28GEPuEg2vU4Mpr55GT4YIBzqIeHLZABcxY7SqROyQgl0sUM9JtBT4A3YtRVdygGPFjiSZTMhn0teKR1vJmeZaO+sxCsY3t8C5UjHFBIvcgM8YJbRyeqjjVY4YcleYZpmjbtP4kpf5rA7bcqlaS5QenvqedcLK8/VdQBiIYn4vWxLX7DeSU1gMnE9qc1oOTUA96JyJ9YJv6RqhiXHuIrZKEQ6SBjoTloCcMhwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23224f5-3ab6-48bd-aa5d-08dd53ecc88e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 09:30:59.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8079yn4eswVWvJqI9ZjPe8sjUJzVEoRjBZZZzmDf8i34l8pNtXPzRQ51uioeW0lvjsTX9sCM/eGCumvXoIWBnjKnbtv1Jk6XpctHhLI62j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502230073
X-Proofpoint-GUID: U3K0DY_hPgb8_UFkmG03kexgP-VFVP2X
X-Proofpoint-ORIG-GUID: U3K0DY_hPgb8_UFkmG03kexgP-VFVP2X

On Sat, Feb 22, 2025 at 09:36:48PM -0800, Kalesh Singh wrote:
> On Sat, Feb 22, 2025 at 10:03 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, Feb 21, 2025 at 01:13:15PM -0800, Kalesh Singh wrote:
> > > Hi organizers of LSF/MM,
> > >
> > > I realize this is a late submission, but I was hoping there might
> > > still be a chance to have this topic considered for discussion.
> > >
> > > Problem Statement
> > > ===============
> > >
> > > Readahead can result in unnecessary page cache pollution for mapped
> > > regions that are never accessed. Current mechanisms to disable
> > > readahead lack granularity and rather operate at the file or VMA
> > > level. This proposal seeks to initiate discussion at LSFMM to explore
> > > potential solutions for optimizing page cache/readahead behavior.
> > >
> > >
> > > Background
> > > =========
> > >
> > > The read-ahead heuristics on file-backed memory mappings can
> > > inadvertently populate the page cache with pages corresponding to
> > > regions that user-space processes are known never to access e.g ELF
> > > LOAD segment padding regions. While these pages are ultimately
> > > reclaimable, their presence precipitates unnecessary I/O operations,
> > > particularly when a substantial quantity of such regions exists.
> > >
> > > Although the underlying file can be made sparse in these regions to
> > > mitigate I/O, readahead will still allocate discrete zero pages when
> > > populating the page cache within these ranges. These pages, while
> > > subject to reclaim, introduce additional churn to the LRU. This
> > > reclaim overhead is further exacerbated in filesystems that support
> > > "fault-around" semantics, that can populate the surrounding pages’
> > > PTEs if found present in the page cache.

One note - if you use guard regions, fault-around won't be performed on
them ;)

It seems strange to me sparse regions would place duplicate zeroed pages in
the page cache...

> > >
> > > While the memory impact may be negligible for large files containing a
> > > limited number of sparse regions, it becomes appreciable for many
> > > small mappings characterized by numerous holes. This scenario can
> > > arise from efforts to minimize vm_area_struct slab memory footprint.

Presumably we're most concern with _synchronous_ readhead here? Because
once you estabish PG_readhead markers to trigger subsequent asynchronous
readahead, I don't think you can retain control. I go into that more below.

> > >
> > > Limitations of Existing Mechanisms
> > > ===========================
> > >
> > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > > entire file, rather than specific sub-regions. The offset and length
> > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > POSIX_FADV_DONTNEED [2] cases.
> > >
> > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > > VMA, rather than specific sub-regions. [3]
> > > Guard Regions: While guard regions for file-backed VMAs circumvent
> > > fault-around concerns, the fundamental issue of unnecessary page cache
> > > population persists. [4]

Note, not for fault-around. But yes for readahead, unavoidably, as there is no
metadata at VMA level (intentionally).

> >
> Hi Kent. Thanks for taking a look at this.
>
> > What if we introduced something like
> >
> > madvise(..., MADV_READAHEAD_BOUNDARY, offset)
> >
> > Would that be sufficient? And would a single readahead boundary offset
> > suffice?
>
> I like the idea of having boundaries. In this particular example the
> single boundary suffices, though I think we’ll need to support
> multiple (see below).
>
> One requirement that we’d like to meet is that the solution doesn’t
> cause VMA splits, to avoid additional slab usage, so perhaps fadvise()
> is better suited to this?

+1 to not causing VMA splits, but presumably you'd madvise() the whole VMA
anyway to adopt to this boundary mode?

But if you're trying to do something sub-VMA, I mean I'm not sure there's
any way for you to do this without splitting the VMA?

You end up in the same situation as guard regions which is - how do we
encode this information in such a way as to _not_ require VMA splitting,
and for guard regions the answer is 'we encode it in the page tables, and
modify _fault_ behaviour'.

Obviously that won't work here, so you really have nowhere else to put it.

While readahead state is stored in struct file(->f_ra) [which is somewhat
iffy on a few levels but still], fundamentally for asynchronous

>
> Another behavior of “mmap readahead” is that it doesn’t really respect
> VMA (start, end) boundaries:

Right, but doesn't readahead strictly belong to the file/folios rather than
any specific mapping?

Fine for synchronous readahead potentially, as you could say - ok we're
major faulting, only bring in up to the VMA boundary. But once you plant
PG_readahead markers to trigger asynchronous readahead on minor faults and
you're into filemap_readahead(), you lose all this kind of context.

And is it really fair if you have multiple mappings as well as potentially
read() operations on a file?

I'm not sure how feasible it is to restrict beyond _initial synchronous_
readahead, and I think you could only do that with VMA metadata, and so
you'd split the VMA, and wouldn't this defeat the purpose somewhat?

>
> The below demonstrates readahead past the end of the mapped region of the file:
>
> sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
> ./pollute_page_cache.sh
>
> Creating sparse file of size 25 pages
> Apparent Size: 100K
> Real Size: 0
> Number cached pages: 0
> Reading first 5 pages via mmap...
> Mapping and reading pages: [0, 6) of file 'myfile.txt'
> Number cached pages: 25
>
> Similarly the readahead can bring in pages before the start of the
> mapped region. I believe this is due to mmap “read-around” [6]:
>
> sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
> ./pollute_page_cache.sh
>
> Creating sparse file of size 25 pages
> Apparent Size: 100K
> Real Size: 0
> Number cached pages: 0
> Reading last 5 pages via mmap...
> Mapping and reading pages: [20, 25) of file 'myfile.txt'
> Number cached pages: 25
>
> I’m not sure what the historical use cases for readahead past the VMA
> boundaries are; but at least in some scenarios this behavior is not
> desirable. For instance, many apps mmap uncompressed ELF files
> directly from a page-aligned offset within a zipped APK as a space
> saving and security feature. The read ahead and read around behaviors
> lead to unrelated resources from the zipped APK populated in the page
> cache. I think in this case we’ll need to have more than a single
> boundary per file.
>
> A somewhat related but separate issue is that currently distinct pages
> are allocated in the page cache when reading sparse file holes. I
> think at least in the case of reading this should be avoidable.

This does seem like something that could be improved, seems very strange we
do this though.

>
> sudo sync && sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' &&
> ./pollute_page_cache.sh
>
> Creating sparse file of size 1GB
> Apparent Size: 977M
> Real Size: 0
> Number cached pages: 0
> Meminfo Cached:          9078768 kB
> Reading 1GB of holes...
> Number cached pages: 250000
> Meminfo Cached:         10117324 kB
>
> (10117324-9078768)/4 = 259639 = ~250000 pages # (global counter = some noise)
>
> --Kalesh

