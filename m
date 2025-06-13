Return-Path: <linux-fsdevel+bounces-51539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A042FAD80D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 04:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5AC1898EBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC41EF36C;
	Fri, 13 Jun 2025 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="b7VhTqRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819E1DF742;
	Fri, 13 Jun 2025 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780773; cv=fail; b=sdGdPqTPHsGHeCv1F4RO+mad1dp/s/6/PALgzIUp2LNdsf7lBPjv/aYvhiPg/MYbO3+mYGuJRqveW+/flGNRDD0kSIEcL4YLPguQz+IEPKILEMVMqV5C12cypd0E1+NRWYkxf0wExjldX9KJod3IwwQORY9dhJQK0fZF5XpLvPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780773; c=relaxed/simple;
	bh=W1CRATotGCmltmCMBWdhOWEETTBYziCXjTEucjEk2BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A2PyuUEzfO84I+TqqJi8c/tcLokYeDTdJ4CqrnIDWsBHXI3O5t7PxX2FGEFNZBiFJCCrUW1aupPwFbVsapIJZr/OkuleaQyX1MCvvFsivnLVTT9+baU0pEAavIa0GKyrMS/TUAthG/jdDbG84uMTdjTa3Nb9Wnxx5eQog68mJok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=b7VhTqRZ; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749780770; x=1781316770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W1CRATotGCmltmCMBWdhOWEETTBYziCXjTEucjEk2BM=;
  b=b7VhTqRZaTYZbBMoy7gucvREoydJ0gPSMe+Q1/UL2PQn8LvLdsKeuZVx
   zomjD8zTHu1q/ideRVSmdJfjO2cK88IKZcY7NDwIGszy01ZsQM4jArt9i
   CYbB31wBectoY7s2uRDVcdxSZHiTxW47sszvarBon0Fbb4YMBpyZ+hv1a
   6bEsIfgK73Ix9nmJQnCc//aaQVIpYIRNWd7SIWd226hqBBbHKCPmEx7kO
   ur8TuInJ/v7IC9zUC55WHxOPZgPv8VxcJfWf9gEAVxiZPUUIqlNdn0f0U
   mTQE2yjPqNXG4LCV7CXV6TZQUcQ+Scr7glvPGWa7n2e63fjxZ2u7wCpAO
   Q==;
X-CSE-ConnectionGUID: fKiyK7oaQsOiPqauqmRtaA==
X-CSE-MsgGUID: B2xp33jGSMKV5ySxSMxK9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69822473"
X-IronPort-AV: E=Sophos;i="6.16,232,1744038000"; 
   d="scan'208";a="69822473"
Received: from mail-japaneastazon11010016.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.16])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 11:12:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfYC53LlEk+dcA8GEQhUBnTtLJolSaqTgfYgs1Bh+SgV6jxmMH90lcnZpHS0IFhGNYiaSvT32aDwMUcFraK0Rn6j106mXLAKEuQAHx2ioTDZbO20QyoENvCOM7Z4ycVxCM/RYlVehV+KGawVgMho1NJoHbrem+iVK95HNg6gxKEG5AmDbBUy04IIHoppSr0q5VIxqpiNkyvApD577+JnvH7OQcj6z9GGr3F6fNdjji+b2DitELW/XTEFmKUHrwqWBVqD+/pZDnzOPzcZOIn5suVpPCtKekeOh9LT2OZ8W4n2dgO7dqLitSHeuRN8Oq5HCxBf2hEMUi1efAxOE+XxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1CRATotGCmltmCMBWdhOWEETTBYziCXjTEucjEk2BM=;
 b=cWhcsmTtdPADm+UlkJkjv6+d3QZaRRK0t/9uH1+eAx6VN9oIDrx0ZZkbxQQ8o8zS0idkUp5Hd+X9dtCN9riLDfNffvt90uWCz7Jeewe+j/pN/Z6Eb2EGYUbqUakkjbyedR4B2ZmB5RVHPuMa5eEfCRjSGtZi4BCymlfHT65bBvAsueFpTR/OXDi9+3QSx8addN0K9bxHaWhuM1RfrrR3BzQtHkjVuWlSx1ZC9kY28ebxeO2AE70HmIZqYlLF5fUH+YTP8dKryzRPELOWHdSZVKWuqg+M2UtbYKhaAHyJ7jg/cewOWtvsij2FYlsjaj0NRwMzDAoIBIG1OdPmfclsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB15814.jpnprd01.prod.outlook.com (2603:1096:604:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 02:12:37 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:12:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Thread-Topic: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Thread-Index: AQHb1NW76oeHF2NVEUGw97u/oRYO67QAZ5YA
Date: Fri, 13 Jun 2025 02:12:37 +0000
Message-ID: <aac45d58-afca-487c-8d14-62d5e7fd490e@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB15814:EE_
x-ms-office365-filtering-correlation-id: b4dec450-52f9-4ed0-823a-08ddaa1fc479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODhFbGhxMDhGQ3Z2OG9wZUVxQVU3azlTSWFqckdDOUtkWmlRL0dTNmQ3RWdK?=
 =?utf-8?B?L2hKMWswMzVNT0dYVmhqemhWYU5wZmpqMTZYWE9JaXg4bForUGMzVU5CZ203?=
 =?utf-8?B?MnVKTkFIQjlFekZIczd6THJOa3EvdGRYTVFpRnEyampDS3RHdmh0Qm1KRkRj?=
 =?utf-8?B?eENWMjQwZXR2dTdNQUtUZDlSaU14ZnNQU2RUdXQxM1k3YWtWK3FBTm1GNUJ5?=
 =?utf-8?B?N0FnZU1MY2J2cjlQK0EwOFE0YVFHc3RnRnVrbXE1azlKb1ZBcFhTZDVGNzYz?=
 =?utf-8?B?YmlOVmFFOUpVN3VNVWRJT0RCVTg4Mk1CVTFDY212VDR3NE1UaHU5T1Z0UkFw?=
 =?utf-8?B?UUw4R0NOSVducUdKSUU1SE9iYXc2WGdrL1NUN254NG92aE5BcmFkYXdZRU10?=
 =?utf-8?B?dlU4NDRhRXZkUEtVVlAvS1YzUUgzSXJhVGE2L20ybEtJZHJaUlUrM29YRFhw?=
 =?utf-8?B?c1BEbUo5dzhITFd0aWdtc0hKR1BSeXNEa1pLc1BQNkR3dmRaR2N1bldlME9n?=
 =?utf-8?B?ZFVzZFNuNnIwWHpURFVXc2phck1aaHNyYlpBQ2xrQURrNjNBaG1yT3F2ckNs?=
 =?utf-8?B?WGtOWWVzVkdEd1NzMTg1VGlKMkZSVjduWmgvSXRua2I2eTlLejh5OWFLWDRW?=
 =?utf-8?B?Z1FUM3JIM2FHOFB4NGxNT01HSFArQ3VzR0w0WmFEZTlIOVdzYlJDS2lhRElL?=
 =?utf-8?B?SUtkUGx4cVBUVXI2M3ppZys4WDVZRTlBUmh3SjZaWEJNZnR0ejhHbUM3SkVL?=
 =?utf-8?B?cjFDbUEvM3doYW9KUFBrbFJOQzBqRWxCSkdaQlZnSFRKK2RUOWx6OUsvYUo0?=
 =?utf-8?B?aGlja3Z6MFFKamJhNTF2cldXRCthR0ZoN2ZEVjRiNGRVa2ZjdTBiRjJHODdW?=
 =?utf-8?B?WVJ6SUx4S3BzYThMd2pTUXJvRWZGOFQ4UGV2bHZiakFNU0NUVVp2RFRXckY0?=
 =?utf-8?B?ODNnb2RTc045b0FqVDU0TTdNdXpOYTROTXVQZGdab2RybEJLK1FqNTF5cEIw?=
 =?utf-8?B?UHMzUmwwNFZmTXVRdDBYN1NuYWtTZjBlSHRQNVVWQjRsb2trbWQ1SUJtSkhN?=
 =?utf-8?B?Wi9HazFFSXRmRk5YY0pZY3VNekt4MWkxaHM4eTh5WXJVWkdaeXdwM1NxNnlR?=
 =?utf-8?B?TmZWQm9aTWZabytmd3FySXVLcFNIQWdKLzl2QjhraTRvL0NWUkRxK2UzMDlW?=
 =?utf-8?B?M20yOGRGeE5MZzVRV0NsdDlOc0EwVmFuYWk1RnRtamNpNU13NmNjemxISnkz?=
 =?utf-8?B?K1ExajdVQ1hPQk9aODZxREFRUVoxeFNvQnVHM3JNbis2emN3RVdOSFFUSGFU?=
 =?utf-8?B?L0ZvV0YzdzR1VDM0VXFsNE9hSXRreTRPUXF6ZHRtb1FJbXV4cGFDYUpuTEI0?=
 =?utf-8?B?YjBMMmZWSndaT3BsVW05bk5hbzA4bldIOC9qZ242NGt3SW5hNjhOeVRWdE50?=
 =?utf-8?B?SCsrS0tJZDRJWFUyYy82UDYyWHhIemVqQTVVWmVvR3M3Zm5HaStYS3BZdXlN?=
 =?utf-8?B?ZVNSUUpZVmZKWFJIU3UxZUcwSUp1ZU8vOGNnY001WWdETUxwOU56aDRmVTZP?=
 =?utf-8?B?Q043eDFsWmxwK1pzSnM4dXVKd0VYZlRKRWQ3YXJTaHNHVHdmVjMwN2w4Vjc3?=
 =?utf-8?B?VnhjelUrbWJQWVQwck8ya3JOS1Z2eVZKanNFdjNZdFNHOUJXUmFDRFJVVDdq?=
 =?utf-8?B?aFhwUTZZdkRIQTFaMmFRdWlnM0RWVjJYOXAvWG5qS0RDT3FKMXZ0cG1WV0Ry?=
 =?utf-8?B?TDJydEc2ekhrNmNqL0QzK2R1V0xsSU0zdnVkN3VpY3ZiM3VRWnorR3E4eHZo?=
 =?utf-8?B?QktEbFYwNlRzMjNWUmVZOXdzQTNKTVJDN1BVZjNRL3paQXpZSXNoTDBYbEd5?=
 =?utf-8?B?UVRJVlV5WlRiWkpaN04zS252UTJoS0Q4eEpQNW1kTndwRnZPWUw1dE0ra3F1?=
 =?utf-8?B?bUs3bnVaUnhCd0JGNnBvbTQvb2hkL1FIbWM5Wmo3WVVsbWRKeHpHaU84R21V?=
 =?utf-8?B?QzM5am0xMTAyT2Nmb1A5VmlXcUsyNldkSnNzby9Ea3Z4ZWNOZ0JackRoREJ0?=
 =?utf-8?Q?geA9vB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW5yTCtOM21tMXR4ckNCYldhNUN4ZlN1c1JkWHNPN1hBNjB1b0pLSXg0cVhn?=
 =?utf-8?B?MFVSaHlVeUNJTndBSm9LbGx0aGtPWWN0QUZ0ZTY0cjBhOWtkengySHVab3I1?=
 =?utf-8?B?UUorVEVGUHNzaXFUQkVjQ01ZRjFsNGdNOWE1QWZhSGJRNDc3TTFudGMweE9J?=
 =?utf-8?B?Z1lGb29lVmRwUDZoNlBQYVExR0Y0U1dtZlRJbnB4eFJ4T2R4T2NLcGhUUzE2?=
 =?utf-8?B?SHd4bEcxWVQ1UU5MbmFYNncvNi9aT1VoZ1hhejJuZVlYMzJ4R3Q0RndJcUYz?=
 =?utf-8?B?bW9kV1RaTkNlcHVzLytLWDhOejVLUnZNVlRhSmFuVU9yZldOTGczbUNwUldQ?=
 =?utf-8?B?enlkZ1ZaV3orcHc3OWkwbThyKzlzWGxmbFFVZ0M4SVhDNnNMZmxuMEtwdDZ4?=
 =?utf-8?B?enlpTWtiR0tIaktsN1ZzbDRzZHpha1l3RUJMUlRpb2VUcE9ZYTFNWXF1cndj?=
 =?utf-8?B?WS9XMkNFdTdaNitKU2VGOGlTUG52eExKeTFkU1VITzZ6UmNPbU5FWWQ0cWVS?=
 =?utf-8?B?MHgxVm1HaHZVb1dRZ09uZHlwVUxEdkRUcVVmbk5hdEdLT2hjVGNqMExnbElG?=
 =?utf-8?B?ejhodjJDVUhQVEUrUXRhRzg4cDhTQnB1amorTXRmaHZScmRBOGJrbTNkUXRM?=
 =?utf-8?B?U1NwbHF1ZS9HK0lod1BCdi9GblFzMm1kWWttWE0zZGtKVkhBZ21CVE1sZlBk?=
 =?utf-8?B?bnZyS3ovNFdJaVhaa00zbkNuMEM5WVRvcXU4WEFza1V3RExxVm02VHpLdy9N?=
 =?utf-8?B?a0w3U3U2RDZGclRsajB0U0tMcUhmNkpzUDRwb2N1TExUNWphN3NGNVFqVER6?=
 =?utf-8?B?RjRRSENheWxVVHJKdzA0dzJyLzJGc3ZzSHMvYnE0OXAxWlVlZTJpUDk2emRZ?=
 =?utf-8?B?Yzh2MUZnKytOZlpjN096c3dwQlhURTQ1SVlxNTZuWTFPZ3I2djdETG1PVTYw?=
 =?utf-8?B?eVlsd1JaRlhvSThvWkNyYmhYZXo3LzJ4YmJEWnE3WkVkY252SVozeHdqV2hB?=
 =?utf-8?B?Y2ZPY3hESno4S2RvN0RGWjBCOWlGc05PQ0FJbnJSYXNYM0MxTFJnYm9ldGxC?=
 =?utf-8?B?NFlFZm95QlNGN2FhY0hLNHhnbFVVU0NCdVYwbWVYc2hqYmFGellwNVB2SEZk?=
 =?utf-8?B?WGI4V1FVTlgwWS9yUjBtb3ZLK1FuUUJyUEEyTDgxeC9ia0F6WTVYQ29vZUtV?=
 =?utf-8?B?Y21ZYjlodzBrN2Z1MVVJckttbWltQVVld3BmV0Q1QkRBRFpUY1ZQTTBjR1Nl?=
 =?utf-8?B?T2QzQUxpTk0vNnVBRElON3RMWEdzSHA0VExweHYvcyt2VGFmdGxYRzNOb09J?=
 =?utf-8?B?RVprdmc3Y2J6NEpRQzBFSnJ0M0VHbkZCWHZOcm5HR1IzVXlSSkgwSStpdVBr?=
 =?utf-8?B?Sng1MURFSEtMaHNmbHh1ZlV5ZXUwSytaNDBhVUtmWE9nNW1WUURadk1WQXY5?=
 =?utf-8?B?U3hwMGxJVHJlQitmM3hjdEhkdmJrejZmaFQ5NTBhU3JKM2J3ZXRxNHNnejhF?=
 =?utf-8?B?eVdMNU9XWTlleUI5NlpLN2lUV25ZaGltRmhXSXVYZFVMYnB4N1JhWUVyL0ZP?=
 =?utf-8?B?ZllPbnlvblpVR0J5b29RMXhzdWFJa0RzWEVzb01Ha29aajE1ejRYZGZBeTJV?=
 =?utf-8?B?Y010N1U5VUFjQW9MQ3A2V0NCaWJ1MnU4WFJkVko2aWx1aVE1N2JFdUVJd1FH?=
 =?utf-8?B?R2YyZ0U3eVJBZzBlZ0JLWFREQWxNOFF0bHVNYnlUZ01kSEdldkdPeEIvVUZ4?=
 =?utf-8?B?L3EzV1hQb0hENjBMTXZJbzVZbVdWblNqQmV1Q1dPM2dFTkJNeWdRcDBIeHky?=
 =?utf-8?B?SnNLRDQvcVJybTBrbGdmWmdmNnJNUjZzcGtMeEdUaW9RckVvSzZQK09nc3V1?=
 =?utf-8?B?TWlZa0d0VHN3c0ZpdE1zVS9wbkJkUnkzRFJzdGc5NlIyb2d1UFBUZEVFb2Er?=
 =?utf-8?B?Yk9SaTkycFdXcFlmNk9uaGpEcWxUdFpSWHh0MDVSYzZGdk5hekFROENxa0ls?=
 =?utf-8?B?U3ZsKzdoSGU3R2VzeE0wZUFFY2JEK0prUjJHZFh0MHY4ekc5VmRYVmRBUVZG?=
 =?utf-8?B?THJFR3B1WnFwOEpMWU1IVlJyajZ5NW1yVmFzTnhrRTJJbG1oSXpERGIrZ2F6?=
 =?utf-8?B?N1kzOVh1WWtka040RDhFOE1QdUNLMDBQYi95b3M2Q1ZZZ0x6djlOL0dmcTA2?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE265008EAC4E64E8A8390ABA8B9A33B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sm9ku1wq1TAsA6KFr2Oi/+FzT5SAfzr/O03YPzWezSM5rtnuMlb409UDG0KRnwvXJUuSarsCZFNGEkRnao2vYKMlccGhV3qg2JZFa9poLXWkVyzbjo3UBi37hVfwh4U7M2CaGHWWiaKbFLVRH0VhijR4EzFfBNyWMLQEiTTUk5N2GLfL24qppv7yZuJKc4IbiBI4EIQkAqnmalBZz4fcIBlnML7MfZZQM/b9WOZdC1fgJjmPDfPE3e0z1gJCw+gbbx/mWd3rEnDkmtJ2pbcgeoWs65zF7/bhlRX8f41X6jJwrKvLa6kMJHidEvEpv78veamjnwC3LFpczYTlQ1qaDPrEsv4lo3YZG68RAnj2wiTSxsiBtaQYPTXiwQ+/AdxGURjuUqcJlvVML09huIdMUtvthcHXFeZBloKfTShOQ1T/rzeV1XJvDHhP+SxUbjFiA03IaymtxzU/GVFF3GKFCMaQtLywwEOA+EQHtSPjKPe13UCI7SBLdKd4/l2i8v5NmBsOuXEqPVyem50HwLJxmnH+0SNGXm6L83KX3laQ3e8uEctNCIv9+IehK0s6PqSo0R7RgTLsK7baK1FgCoEh8se2YxHMCjMRsTIcqq1YLzl8iu7cnCGPQJZrtj2NzVnb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dec450-52f9-4ed0-823a-08ddaa1fc479
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:12:37.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dkl8tGvmq9YuwRokKNtg8SR79+IpCD6tUeCqxXsKjrpkFkSDZLX3sz62VfrdwItgjX+VUV60BAQ4i/cQDzyT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15814

SGkgU21pdGEsIE5hdGhhbiwgVGVycnkNCg0KSSBhbSBzdHJ1Z2dsaW5nIHRvIHVuZGVyc3RhbmQg
aWYgdGhpcyBwYXRjaCBpcyB0cnVseSBuZWNlc3NhcnksIG9yIGlmIEkgaGF2ZW4ndA0KZnVsbHkg
Z3Jhc3BlZCB0aGUgc2NlbmFyaW8gd2hlcmUgaXQgcHJvdmlkZXMgdmFsdWUuIFdpdGhvdXQgYXBw
bHlpbmcgdGhpcyBwYXRjaA0Kb24gYSBRRU1VL1ZNIHdpdGggYm90aCBITUVNIGFuZCBDWEwubWVt
IGluc3RhbGxlZCwgSSBvYnNlcnZlZCBubyBpc3N1ZXMuIChBcmUgdGhlcmUNCnNwZWNpZmljIGNv
bmZpZyBvcHRpb25zIHJlcXVpcmVkIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbT8pDQoNCkhlcmUg
aXMgdGhlIC9wcm9jL2lvbWVtIHdpdGhvdXQgdGhlIHBhdGNoOg0KMTgwMDAwMDAwLTFmZmZmZmZm
ZiA6IFNvZnQgUmVzZXJ2ZWQgICMjIyAyIGhtZW0gbm9kZXMNCiAgIDE4MDAwMDAwMC0xYmZmZmZm
ZmYgOiBkYXgxLjANCiAgICAgMTgwMDAwMDAwLTFiZmZmZmZmZiA6IFN5c3RlbSBSQU0gKGttZW0p
DQogICAxYzAwMDAwMDAtMWZmZmZmZmZmIDogZGF4Mi4wDQogICAgIDFjMDAwMDAwMC0xZmZmZmZm
ZmYgOiBTeXN0ZW0gUkFNIChrbWVtKQ0KNWMwMDAxMTI4LTVjMDAwMTFiNyA6IHBvcnQxDQo1ZDAw
MDAwMDAtNjRmZmZmZmZmIDogQ1hMIFdpbmRvdyAwICAjIyMgMSBDWEwgbm9kZQ0KICAgNWQwMDAw
MDAwLTY0ZmZmZmZmZiA6IHJlZ2lvbjANCiAgICAgNWQwMDAwMDAwLTY0ZmZmZmZmZiA6IGRheDAu
MA0KICAgICAgIDVkMDAwMDAwMC02NGZmZmZmZmYgOiBTeXN0ZW0gUkFNIChrbWVtKQ0KDQpPbiAw
NC8wNi8yMDI1IDA2OjE5LCBTbWl0YSBLb3JhbGFoYWxsaSB3cm90ZToNCj4gRnJvbTogTmF0aGFu
IEZvbnRlbm90IDxuYXRoYW4uZm9udGVub3RAYW1kLmNvbT4NCj4gDQo+IFRoZSBEQVggSE1FTSBk
cml2ZXIgY3VycmVudGx5IGNvbnN1bWVzIGFsbCBTT0ZUIFJFU0VSVkVEIGlvbWVtIHJlc291cmNl
cw0KPiBkdXJpbmcgaW5pdGlhbGl6YXRpb24uIFRoaXMgaW50ZXJmZXJlcyB3aXRoIHRoZSBDWEwg
ZHJpdmVy4oCZcyBhYmlsaXR5IHRvDQo+IGNyZWF0ZSByZWdpb25zIGFuZCB0cmltIG92ZXJsYXBw
aW5nIFNPRlQgUkVTRVJWRUQgcmFuZ2VzIGJlZm9yZSBEQVggdXNlcw0KPiB0aGVtLg0KDQpXaGVu
IHJlZmVycmluZyB0byAiSE1FTSBkcml2ZXIiIGluIHRoZSBjb21taXQgbWVzc2FnZSwgaXMgaXQN
CmBkYXhfaG1lbV9wbGF0Zm9ybV9kcml2ZXJgIG9yIGBkYXhfaG1lbV9kcml2ZXJgPyBSZWdhcmRs
ZXNzIG9mIHdoaWNoLA0Kd2hhdCBpcyB0aGUgaW1wYWN0IGlmIG9uZSBjb25zdW1lcyBhbGwgU09G
VCBSRVNFUlZFRCByZXNvdXJjZXM/DQoNClNpbmNlIGBobWVtX3JlZ2lzdGVyX2RldmljZSgpYCBv
bmx5IGNyZWF0ZXMgSE1FTSBkZXZpY2VzIGZvciByYW5nZXMNCip3aXRob3V0KiBgSU9SRVNfREVT
Q19DWExgIHdoaWNoIGNvdWxkIGJlIG1hcmtlZCBpbiBjeGxfYWNwaSAsIGN4bF9jb3JlL2N4bF9k
YXgNCnNob3VsZCBzdGlsbCBjcmVhdGUgcmVnaW9ucyBhbmQgREFYIGRldmljZXMgd2l0aG91dCBj
b25mbGljdHMuDQoNCj4gVG8gcmVzb2x2ZSB0aGlzLCBkZWZlciB0aGUgREFYIGRyaXZlcidzIHJl
c291cmNlIGNvbnN1bXB0aW9uIGlmIHRoZQ0KPiBjeGxfYWNwaSBkcml2ZXIgaXMgZW5hYmxlZC4g
VGhlIERBWCBITUVNIGluaXRpYWxpemF0aW9uIHNraXBzIHdhbGtpbmcgdGhlDQo+IGlvbWVtIHJl
c291cmNlIHRyZWUgaW4gdGhpcyBjYXNlLiBBZnRlciBDWEwgcmVnaW9uIGNyZWF0aW9uIGNvbXBs
ZXRlcywNCj4gYW55IHJlbWFpbmluZyBTT0ZUIFJFU0VSVkVEIHJlc291cmNlcyBhcmUgZXhwbGlj
aXRseSByZWdpc3RlcmVkIHdpdGggdGhlDQo+IERBWCBkcml2ZXIgYnkgdGhlIENYTCBkcml2ZXIu
DQoNCkNvbnZlcnNlbHksIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCBgY3hsX3JlZ2lvbl9zb2Z0
cmVzZXJ2X3VwZGF0ZSgpYCBhdHRlbXB0cw0KdG8gcmVnaXN0ZXIgbmV3IEhNRU0gZGV2aWNlcy4g
VGhpcyBtYXkgY2F1c2UgZHVwbGljYXRlIHJlZ2lzdHJhdGlvbnMgZm9yIHRoZQ0KICBzYW1lIHJh
bmdlIChlLmcuLCAweDE4MDAwMDAwMC0weDFmZmZmZmZmZiksIHRyaWdnZXJpbmcgd2FybmluZ3Mg
bGlrZToNCg0KWyAgIDE0Ljk4NDEwOF0ga21lbSBkYXg0LjA6IG1hcHBpbmcwOiAweDE4MDAwMDAw
MC0weDFmZmZmZmZmZiBjb3VsZCBub3QgcmVzZXJ2ZSByZWdpb24NClsgICAxNC45ODcyMDRdIGtt
ZW0gZGF4NC4wOiBwcm9iZSB3aXRoIGRyaXZlciBrbWVtIGZhaWxlZCB3aXRoIGVycm9yIC0xNg0K
DQpCZWNhdXNlIHRoZSBITUFUIGluaXRpYWxpemF0aW9uIGFscmVhZHkgcmVnaXN0ZXJlZCB0aGVz
ZSBzdWItcmFuZ2VzOg0KICAgMTgwMDAwMDAwLTFiZmZmZmZmZg0KICAgMWMwMDAwMDAwLTFmZmZm
ZmZmZg0KDQoNCklmIEknbSBtaXNzaW5nIHNvbWV0aGluZywgcGxlYXNlIGNvcnJlY3QgbWUuDQoN
ClRoYW5rcywNClpoaWppYW4NCg0KDQoNCj4gDQo+IFRoaXMgc2VxdWVuY2luZyBlbnN1cmVzIHBy
b3BlciBoYW5kbGluZyBvZiBvdmVybGFwcyBhbmQgZml4ZXMgaG90cGx1Zw0KPiBmYWlsdXJlcy4N
Cj4gDQo+IENvLWRldmVsb3BlZC1ieTogTmF0aGFuIEZvbnRlbm90IDxOYXRoYW4uRm9udGVub3RA
YW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmF0aGFuIEZvbnRlbm90IDxOYXRoYW4uRm9udGVu
b3RAYW1kLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21h
bkBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBh
bWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTbWl0YSBLb3JhbGFoYWxsaSA8U21pdGEuS29yYWxh
aGFsbGlDaGFubmFiYXNhcHBhQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUv
cmVnaW9uLmMgfCAxMCArKysrKysrKysNCj4gICBkcml2ZXJzL2RheC9obWVtL2RldmljZS5jIHwg
NDMgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9k
YXgvaG1lbS9obWVtLmMgICB8ICAzICsrLQ0KPiAgIGluY2x1ZGUvbGludXgvZGF4LmggICAgICAg
fCAgNiArKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDIyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMg
Yi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+IGluZGV4IDNhNWNhNDRkNjVmMy4uYzZjMGM3
YmEzYjIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICsrKyBi
L2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gQEAgLTEwLDYgKzEwLDcgQEANCj4gICAjaW5j
bHVkZSA8bGludXgvc29ydC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9pZHIuaD4NCj4gICAjaW5j
bHVkZSA8bGludXgvbWVtb3J5LXRpZXJzLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZGF4Lmg+DQo+
ICAgI2luY2x1ZGUgPGN4bG1lbS5oPg0KPiAgICNpbmNsdWRlIDxjeGwuaD4NCj4gICAjaW5jbHVk
ZSAiY29yZS5oIg0KPiBAQCAtMzU1Myw2ICszNTU0LDExIEBAIHN0YXRpYyBzdHJ1Y3QgcmVzb3Vy
Y2UgKm5vcm1hbGl6ZV9yZXNvdXJjZShzdHJ1Y3QgcmVzb3VyY2UgKnJlcykNCj4gICAJcmV0dXJu
IE5VTEw7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGludCBjeGxfc29mdHJlc2Vydl9tZW1fcmVn
aXN0ZXIoc3RydWN0IHJlc291cmNlICpyZXMsIHZvaWQgKnVudXNlZCkNCj4gK3sNCj4gKwlyZXR1
cm4gaG1lbV9yZWdpc3Rlcl9kZXZpY2UocGh5c190b190YXJnZXRfbm9kZShyZXMtPnN0YXJ0KSwg
cmVzKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgX19jeGxfcmVnaW9uX3NvZnRyZXNlcnZf
dXBkYXRlKHN0cnVjdCByZXNvdXJjZSAqc29mdCwNCj4gICAJCQkJCSAgdm9pZCAqX2N4bHIpDQo+
ICAgew0KPiBAQCAtMzU5MCw2ICszNTk2LDEwIEBAIGludCBjeGxfcmVnaW9uX3NvZnRyZXNlcnZf
dXBkYXRlKHZvaWQpDQo+ICAgCQkJCSAgICBfX2N4bF9yZWdpb25fc29mdHJlc2Vydl91cGRhdGUp
Ow0KPiAgIAl9DQo+ICAgDQo+ICsJLyogTm93IHJlZ2lzdGVyIGFueSByZW1haW5pbmcgU09GVCBS
RVNFUlZFUyB3aXRoIERBWCAqLw0KPiArCXdhbGtfaW9tZW1fcmVzX2Rlc2MoSU9SRVNfREVTQ19T
T0ZUX1JFU0VSVkVELCBJT1JFU09VUkNFX01FTSwNCj4gKwkJCSAgICAwLCAtMSwgTlVMTCwgY3hs
X3NvZnRyZXNlcnZfbWVtX3JlZ2lzdGVyKTsNCj4gKw0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
ICAgRVhQT1JUX1NZTUJPTF9OU19HUEwoY3hsX3JlZ2lvbl9zb2Z0cmVzZXJ2X3VwZGF0ZSwgIkNY
TCIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvaG1lbS9kZXZpY2UuYyBiL2RyaXZlcnMv
ZGF4L2htZW0vZGV2aWNlLmMNCj4gaW5kZXggNTlhZDQ0NzYxMTkxLi5jYzFlZDdiYmRiMWEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZGF4L2htZW0vZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9k
YXgvaG1lbS9kZXZpY2UuYw0KPiBAQCAtOCw3ICs4LDYgQEANCj4gICBzdGF0aWMgYm9vbCBub2ht
ZW07DQo+ICAgbW9kdWxlX3BhcmFtX25hbWVkKGRpc2FibGUsIG5vaG1lbSwgYm9vbCwgMDQ0NCk7
DQo+ICAgDQo+IC1zdGF0aWMgYm9vbCBwbGF0Zm9ybV9pbml0aWFsaXplZDsNCj4gICBzdGF0aWMg
REVGSU5FX01VVEVYKGhtZW1fcmVzb3VyY2VfbG9jayk7DQo+ICAgc3RhdGljIHN0cnVjdCByZXNv
dXJjZSBobWVtX2FjdGl2ZSA9IHsNCj4gICAJLm5hbWUgPSAiSE1FTSBkZXZpY2VzIiwNCj4gQEAg
LTM1LDkgKzM0LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwod2Fsa19obWVtX3Jlc291cmNlcyk7DQo+
ICAgDQo+ICAgc3RhdGljIHZvaWQgX19obWVtX3JlZ2lzdGVyX3Jlc291cmNlKGludCB0YXJnZXRf
bmlkLCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcykNCj4gICB7DQo+IC0Jc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldjsNCj4gICAJc3RydWN0IHJlc291cmNlICpuZXc7DQo+IC0JaW50IHJjOw0KPiAg
IA0KPiAgIAluZXcgPSBfX3JlcXVlc3RfcmVnaW9uKCZobWVtX2FjdGl2ZSwgcmVzLT5zdGFydCwg
cmVzb3VyY2Vfc2l6ZShyZXMpLCAiIiwNCj4gICAJCQkgICAgICAgMCk7DQo+IEBAIC00NywyMSAr
NDQsNiBAQCBzdGF0aWMgdm9pZCBfX2htZW1fcmVnaXN0ZXJfcmVzb3VyY2UoaW50IHRhcmdldF9u
aWQsIHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiAgIAl9DQo+ICAgDQo+ICAgCW5ldy0+ZGVzYyA9
IHRhcmdldF9uaWQ7DQo+IC0NCj4gLQlpZiAocGxhdGZvcm1faW5pdGlhbGl6ZWQpDQo+IC0JCXJl
dHVybjsNCj4gLQ0KPiAtCXBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoImhtZW1fcGxhdGZv
cm0iLCAwKTsNCj4gLQlpZiAoIXBkZXYpIHsNCj4gLQkJcHJfZXJyX29uY2UoImZhaWxlZCB0byBy
ZWdpc3RlciBkZXZpY2UtZGF4IGhtZW1fcGxhdGZvcm0gZGV2aWNlXG4iKTsNCj4gLQkJcmV0dXJu
Ow0KPiAtCX0NCj4gLQ0KPiAtCXJjID0gcGxhdGZvcm1fZGV2aWNlX2FkZChwZGV2KTsNCj4gLQlp
ZiAocmMpDQo+IC0JCXBsYXRmb3JtX2RldmljZV9wdXQocGRldik7DQo+IC0JZWxzZQ0KPiAtCQlw
bGF0Zm9ybV9pbml0aWFsaXplZCA9IHRydWU7DQo+ICAgfQ0KPiAgIA0KPiAgIHZvaWQgaG1lbV9y
ZWdpc3Rlcl9yZXNvdXJjZShpbnQgdGFyZ2V0X25pZCwgc3RydWN0IHJlc291cmNlICpyZXMpDQo+
IEBAIC04Myw5ICs2NSwyOCBAQCBzdGF0aWMgX19pbml0IGludCBobWVtX3JlZ2lzdGVyX29uZShz
dHJ1Y3QgcmVzb3VyY2UgKnJlcywgdm9pZCAqZGF0YSkNCj4gICANCj4gICBzdGF0aWMgX19pbml0
IGludCBobWVtX2luaXQodm9pZCkNCj4gICB7DQo+IC0Jd2Fsa19pb21lbV9yZXNfZGVzYyhJT1JF
U19ERVNDX1NPRlRfUkVTRVJWRUQsDQo+IC0JCQlJT1JFU09VUkNFX01FTSwgMCwgLTEsIE5VTEws
IGhtZW1fcmVnaXN0ZXJfb25lKTsNCj4gLQlyZXR1cm4gMDsNCj4gKwlzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2Ow0KPiArCWludCByYzsNCj4gKw0KPiArCWlmICghSVNfRU5BQkxFRChDT05G
SUdfQ1hMX0FDUEkpKSB7DQo+ICsJCXdhbGtfaW9tZW1fcmVzX2Rlc2MoSU9SRVNfREVTQ19TT0ZU
X1JFU0VSVkVELA0KPiArCQkJCSAgICBJT1JFU09VUkNFX01FTSwgMCwgLTEsIE5VTEwsDQo+ICsJ
CQkJICAgIGhtZW1fcmVnaXN0ZXJfb25lKTsNCj4gKwl9DQo+ICsNCj4gKwlwZGV2ID0gcGxhdGZv
cm1fZGV2aWNlX2FsbG9jKCJobWVtX3BsYXRmb3JtIiwgMCk7DQo+ICsJaWYgKCFwZGV2KSB7DQo+
ICsJCXByX2VycigiZmFpbGVkIHRvIHJlZ2lzdGVyIGRldmljZS1kYXggaG1lbV9wbGF0Zm9ybSBk
ZXZpY2VcbiIpOw0KPiArCQlyZXR1cm4gLTE7DQo+ICsJfQ0KPiArDQo+ICsJcmMgPSBwbGF0Zm9y
bV9kZXZpY2VfYWRkKHBkZXYpOw0KPiArCWlmIChyYykgew0KPiArCQlwcl9lcnIoImZhaWxlZCB0
byBhZGQgZGV2aWNlLWRheCBobWVtX3BsYXRmb3JtIGRldmljZVxuIik7DQo+ICsJCXBsYXRmb3Jt
X2RldmljZV9wdXQocGRldik7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHJjOw0KPiAgIH0NCj4g
ICANCj4gICAvKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvaG1lbS9obWVtLmMgYi9kcml2
ZXJzL2RheC9obWVtL2htZW0uYw0KPiBpbmRleCAzYWVkZWY1ZjFiZTEuLmEyMDZiOWIzODNlNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kYXgvaG1lbS9obWVtLmMNCj4gKysrIGIvZHJpdmVycy9k
YXgvaG1lbS9obWVtLmMNCj4gQEAgLTYxLDcgKzYxLDcgQEAgc3RhdGljIHZvaWQgcmVsZWFzZV9o
bWVtKHZvaWQgKnBkZXYpDQo+ICAgCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHBkZXYpOw0K
PiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQgaG1lbV9yZWdpc3Rlcl9kZXZpY2UoaW50IHRhcmdl
dF9uaWQsIGNvbnN0IHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiAraW50IGhtZW1fcmVnaXN0ZXJf
ZGV2aWNlKGludCB0YXJnZXRfbmlkLCBjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcykNCj4gICB7
DQo+ICAgCXN0cnVjdCBkZXZpY2UgKmhvc3QgPSAmZGF4X2htZW1fcGRldi0+ZGV2Ow0KPiAgIAlz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0KPiBAQCAtMTI0LDYgKzEyNCw3IEBAIHN0YXRp
YyBpbnQgaG1lbV9yZWdpc3Rlcl9kZXZpY2UoaW50IHRhcmdldF9uaWQsIGNvbnN0IHN0cnVjdCBy
ZXNvdXJjZSAqcmVzKQ0KPiAgIAlwbGF0Zm9ybV9kZXZpY2VfcHV0KHBkZXYpOw0KPiAgIAlyZXR1
cm4gcmM7DQo+ICAgfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoaG1lbV9yZWdpc3Rlcl9kZXZpY2Up
Ow0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgZGF4X2htZW1fcGxhdGZvcm1fcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gICB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RheC5oIGIvaW5jbHVkZS9saW51eC9kYXguaA0KPiBpbmRleCBhNGFkMzcwOGVhMzUuLjUwNTJk
Y2E4YjNiYyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9kYXguaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L2RheC5oDQo+IEBAIC0yOTksMTAgKzI5OSwxNiBAQCBzdGF0aWMgaW5saW5lIGlu
dCBkYXhfbWVtMmJsa19lcnIoaW50IGVycikNCj4gICANCj4gICAjaWZkZWYgQ09ORklHX0RFVl9E
QVhfSE1FTV9ERVZJQ0VTDQo+ICAgdm9pZCBobWVtX3JlZ2lzdGVyX3Jlc291cmNlKGludCB0YXJn
ZXRfbmlkLCBzdHJ1Y3QgcmVzb3VyY2UgKnIpOw0KPiAraW50IGhtZW1fcmVnaXN0ZXJfZGV2aWNl
KGludCB0YXJnZXRfbmlkLCBjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcyk7DQo+ICAgI2Vsc2UN
Cj4gICBzdGF0aWMgaW5saW5lIHZvaWQgaG1lbV9yZWdpc3Rlcl9yZXNvdXJjZShpbnQgdGFyZ2V0
X25pZCwgc3RydWN0IHJlc291cmNlICpyKQ0KPiAgIHsNCj4gICB9DQo+ICsNCj4gK3N0YXRpYyBp
bmxpbmUgaW50IGhtZW1fcmVnaXN0ZXJfZGV2aWNlKGludCB0YXJnZXRfbmlkLCBjb25zdCBzdHJ1
Y3QgcmVzb3VyY2UgKnJlcykNCj4gK3sNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gICAjZW5kaWYN
Cj4gICANCj4gICB0eXBlZGVmIGludCAoKndhbGtfaG1lbV9mbikoaW50IHRhcmdldF9uaWQsIGNv
bnN0IHN0cnVjdCByZXNvdXJjZSAqcmVzKTs=

