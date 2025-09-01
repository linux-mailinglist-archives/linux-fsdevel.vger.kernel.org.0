Return-Path: <linux-fsdevel+bounces-59731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336FB3D6FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B320C3B0CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1390218AD1;
	Mon,  1 Sep 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QMPm5hd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED81482F2;
	Mon,  1 Sep 2025 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696170; cv=fail; b=P+wsz1hRWgAda+Z1lFVYXwejQ3+xS6Ft4UgCpi5rZLtJhXZbjytF4SQIxb3bX7OJvS5oKVQYX8EFjjlkC98p/mGyvPum+OHPl+M9cnBOYfGghVDzYOOghQEOtvW0UmjD6SY9QaspW+tca6rXVZEoGGf1V7gBLSbzzLC1sur/h4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696170; c=relaxed/simple;
	bh=FITLbKl+Zhejl6e8IK/EjqoxQxVrXIuVgMFiTLVQ1h8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cYRtFcN8IIL0x8xRe6eTQwuB3nY7vIAr5ZZ8YAnoBFFhUxrqlBRfUbOTSL4o/O5AtN0HtsirYffjcAP9Bwc42VbgNSMd88g2vwVKa4lJL+UFCQ04ggPH8KgLt9VuuZfn7nzK9V5BNCy4+5+bOxdI8725xGnnDWEUcF06/jvtF64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QMPm5hd5; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756696168; x=1788232168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FITLbKl+Zhejl6e8IK/EjqoxQxVrXIuVgMFiTLVQ1h8=;
  b=QMPm5hd54OQYGfqb/6OAUnxLx8uk3DytvVOj9v0XfbZ2xTBLBXDxlW4Z
   rHaNL4cupS69hBhYEFh1a8KbbRvIc0GqIAXa4n5cV/7I7b+HJdbgOnRvM
   hYK9eqI7D2X1a/tx5ta6R7pQmhS9KFgLtkxEiUZHr/eZDeh5e03jU3QS0
   O4QJO0bU9piOmVdI577dtrG24DiS91BMl7V3Qvjb3T19Utc2hxLnPdQLy
   5OkW+oDZAn/VAVoxBDHa5PoCjAEveqUEwBugYQTkpNMDEh7cP9S3B20hH
   cgxmISKH/reLLm/glTRCdMJUMf2fJcYUsUgR+NSMfYOdEiSlXDLnfCXJf
   A==;
X-CSE-ConnectionGUID: PYpvYPxvQN2KoePqZF6+Eg==
X-CSE-MsgGUID: 6YGzO3FdRaGEuwKzJI+yCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="165735296"
X-IronPort-AV: E=Sophos;i="6.18,225,1751209200"; 
   d="scan'208";a="165735296"
Received: from mail-japanwestazon11011032.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.32])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 12:08:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kC+MadOGsUDA32g1v+vX1o6BDzseXnj/ZmrT1jixej4khsMCUwUPj9qX72+tcO0hPULX3V/C6jPoH6EmVfP2gWlfZv0tmGIBzr3fMSVhALLWI6bsG2WUXAjrHlgjs5lVhuQgj2LBpDSeOOd59TG6eYZWOHDtjc01riN/oN9QzjUzezkhDS3wNH6+Jbd1GCuKQqu2vPZcneoypgX+OqSP2vjGokWykbOk236qA+oa92cqYspRRIVSw/K41kyPpVONonW97sHSsLPta5wsVoyorqmkU/alAeiZv9veq6WFVERxz9xOIJ8122/l3RAWSCWy3IV7ZTBQERMA+3JePvUe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FITLbKl+Zhejl6e8IK/EjqoxQxVrXIuVgMFiTLVQ1h8=;
 b=FNd055jkYZywEkVLXFb5+0tHYxaDPe6cUX/9Ngs/ggGcCsX9vJIrO8QBQNcTBkrsULblogRTeMKn+8eecx77CSn7m2gRzhdQerbPJEMwwKzpYod+6h+XAy/6Y2y5U/U1tBKYSY58cTXTHFnNbfiEqLDTD9FumYOYYAne08QskK6NUdYIx070uAy3BVQet2uCLtiUDZgzWaIjHHeTVPf7ckc5cFOU3DfYFiAAIwpBtIUsAIPg5i1XUJ8IwBg3NGvymv0w2VV74lLcLZ+Ew8GRcg61V9H1P31NJjnEQ0M9MPxNOIi6+IhILFRVXAv/j7oSguAYJofpmN8AZ5Wcu0BhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by TYWPR01MB11704.jpnprd01.prod.outlook.com (2603:1096:400:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 03:08:07 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 03:08:07 +0000
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
Subject: Re: [PATCH 2/6] dax/hmem: Request cxl_acpi and cxl_pci before walking
 Soft Reserved ranges
Thread-Topic: [PATCH 2/6] dax/hmem: Request cxl_acpi and cxl_pci before
 walking Soft Reserved ranges
Thread-Index: AQHcExbIuPciyhfgxk2D5yYKfGS+9rR9tRgA
Date: Mon, 1 Sep 2025 03:08:07 +0000
Message-ID: <1e4344b9-490e-47a2-902b-3d5e84ca4b67@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-3-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250822034202.26896-3-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|TYWPR01MB11704:EE_
x-ms-office365-filtering-correlation-id: 44c432e2-c962-4633-4842-08dde904c63e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnpjRzRsNVB5cXRPQ3AyTGppRDZBcFp1RFA2NXhZTU5hMDU4YVB5cWJRa2x4?=
 =?utf-8?B?N1RHTEJuaC9LLzlDcEtpV3ZFejFhS2dZaldLN0dmMFZTMGh5djVNV0dSRUEr?=
 =?utf-8?B?RTI2WXBwZnNRbmQydmNZb3o5R3RsU3dKWFVIVXBjY2VNZmYwbzZHVzY2S2w2?=
 =?utf-8?B?MXNMTkVnOW1nRWt4TXhoWm9mU201UkluWHJndk5lMGE0c2x0SG93QjJibHdo?=
 =?utf-8?B?bnRzdzFXY0U3eUJVdExIKzFRbU1FelM2RHZHV0hiWVpvblFZMjdFVlpqOGx1?=
 =?utf-8?B?MnlDN3piNWthOU1EeEM0bFdPNlpxa2dkV3NHLzNFUUwza1lwT2FGTE9OTldF?=
 =?utf-8?B?VlNPY1NmTWxWN3JwNlc3djYrbk5rZzllelNKaFpXUGZuWmdaV3lhMGF3WGhy?=
 =?utf-8?B?ZHluSzhRMHZ3cWRrWnN3eDFYdkg0SWY4MEYxYVFPMStpWkN0bkFKMFlyTG80?=
 =?utf-8?B?REt6cUxhdTF6ajZUamo2OFRhZkJvN1RjMzBLZTVqR2FnSTQ5Y29pR3h0MU9i?=
 =?utf-8?B?cFN1K2J3eUo3QkQzaytwUFV1RUd6dmRDOUg4eGw3V1BuVW5lbUZlbWt6b1lP?=
 =?utf-8?B?TTBucVNkcHR5ZmptVWd2ZEN5eGJqVmFFMU1VNUczWXZoUUlpTVRJMldDMUd0?=
 =?utf-8?B?UXFIeVROWkdBMTBKWHpMaDdZRG5YanMrRThFYmtMQ1RTTEZBY2tEVHQ5MDBG?=
 =?utf-8?B?UHNmTjBGcjhEcFhSdXU5SUQ1cFpwYUxCWVJMQnNmelYzWHFBbzRUNno1SVJD?=
 =?utf-8?B?cjB1TUNYbmhqRGNhdG5ja1lkc3lZcDdkWjZwVGxhTTVKTXUvVm5EdVJDNDFM?=
 =?utf-8?B?TWhHOTJaVU1TbW4xOEFrUE9VS3dzbDVoQzY3bnYyREovb1ozQVRGbHNuRTZz?=
 =?utf-8?B?Q0NxL0h6Tk93RWIyV3d1SHBNVWx1eGF2SmVvZTVjRWJ3TExJajFLbzM5SnMz?=
 =?utf-8?B?QWdUT3lNY0hXZ1dOelZiSXZrcTJJaEtPR2VBT3dobE9CU1VsVG0zQUtKQW85?=
 =?utf-8?B?SWJQcTBScStHaG1icnI1UGM3RTIzc2dIUjBFRVhENm9JbTdNZEkwUEhiVjht?=
 =?utf-8?B?clo5TXNId1FkUnRBYmFDSWNzUDljd25wV3ozakdQMVVUSWhaUkwxWlI1em1n?=
 =?utf-8?B?TjU5S3h5NjRwdzFUcDg1RnYrUmRBc2M4WGhaZ3luQXAyVjFMOGNUazE2RUwy?=
 =?utf-8?B?c29hSGUwemhsZFd5bk5Nc1BvaXZtUy9YVTJ1c0pzcGRVY1hEdTVobXpHaHRy?=
 =?utf-8?B?bU9zNEJaNG1xdnJUNmRXY1hwZGxwb25MbEdEWTdsdEVYTDJCei8vWFBaV3ha?=
 =?utf-8?B?Q0dwOCtQRkxKZktHK2pxSlJNbzdScGFUd0d1M29HZ1h3enFxaEtNaGFaeVNO?=
 =?utf-8?B?d3BTYkhIclJWVURwM1ZXeStGYm9zYUJZM0lUL2VzdUVvNlk2WGFPK29mT3ZG?=
 =?utf-8?B?NGhBTUFMUTFoSmdoK3BPQWRIRXNCdU1GS2Nra25MbUVJczJYckhGSjdTYTht?=
 =?utf-8?B?ZzdJTlIwR2NERzZuUW14MnROV2tPdWo3c0xKODJDM0ZhSFRVRVB4ZDlMcG1l?=
 =?utf-8?B?ZzlpYWkyRGVlcS82WFE0NnIxYU0zMk92M2xUSHFRMHZ1TUtVUGpEdTZWcjlu?=
 =?utf-8?B?MUF6RDRoQUh6ajY5aUZEZTFpY1lIUk4wYy9ZcjRDTE96bzM0ZkhkS3UxSlN5?=
 =?utf-8?B?V0dzS2duU3N4NmxaQzVHblc3N0U5WjZYYys1V1BmOUdLcnBLV0FlSGc3anFM?=
 =?utf-8?B?QjFoTXhWN3RHaFFjeDNRTVc3a2xuQVpxYnBnMXR5bThSRDlTY0JGSDVmVFk1?=
 =?utf-8?B?NTU5c0NHUXBPZ05aM0sxYTZhSGg4U1Mvb1dCWmhkUDN3UkozL0haQTIxT1NQ?=
 =?utf-8?B?amhJWTBZaFl0am1BWm1va05yUkRaMjQ0a29HUkw5L1ByM3hxcWY2ZFprQ044?=
 =?utf-8?B?VkM0REFUTGU3eUZFanNVZE84R3Jldk93WHd6V3hlTkdhQ0puWmdRblFPVUtG?=
 =?utf-8?B?LzAwWFhzV2lHMWpIaGQxeWhSNXNEYlhDMUFQQVl0c0N2c1JocWo5eWtvOHdV?=
 =?utf-8?Q?qguLYG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk1vS2UxTnpkSExrL3F6RTlFa0x2YkltUkpUQVpwRXhQNkJSbGNIWmlOUlh0?=
 =?utf-8?B?QlhhbEVWRVBHd1pQckRDVmw2eUJtK1NEMlBIVGtNMThjbGJhVXJ6NGgrMmQ5?=
 =?utf-8?B?WGlmV1lGTEZ2aC84NXkvNlcxQWZTMTBNV0pGMFQzU1ZNcW1vYlBwQTZFbG92?=
 =?utf-8?B?T0lxdTZjUVZYNDFlaFQ1UUcySHNBbnExQUVrMEF4Q2hUZkRnbWhEdWtGRVBT?=
 =?utf-8?B?emlNN2w2dkkyaVBpOHJ3OHgydTJLdjlzVStaZ2ZUTVlIMVlwcExJK0ppellm?=
 =?utf-8?B?c0VybmdML2RVdGF2YUJLWXlLNnVmQ3VRVDBBa0lkT0xIL2tUTjhGSlBuM0Rw?=
 =?utf-8?B?TXBhUFZhRGIzQTVzOHVNYTUrNUN0SFlIRUlPVzdTdTlsN3k3c01mT1B2Qkh0?=
 =?utf-8?B?ODlpZ3NSZ1JXY0NiWDdZSzRScW5qbzNtaDRtdjZBUXJ1c0h0ZGhIcGc3R2d1?=
 =?utf-8?B?cDlJZ1JqbjJidmlqQjJtOW1QUzlsNXY1VU1FbVZhQ3c1MFRTWlNqYTREMHpE?=
 =?utf-8?B?K2YzK3RvT0RkaDB5Z091eU5mcDRyNWs2d2oyVWVUbzZUaEtTcjJydDVENk1p?=
 =?utf-8?B?MEtqc2l4emhqTmNCcGtwdTM4Vm5pL0cyZEF1c2ZkanNLaHBjdTZBYXdXOHdG?=
 =?utf-8?B?SlZaUG5KQkhaeFpoajBBbisyUU5jVVd6dG1tODRQazZxQWM3dDVaMlJqeUlW?=
 =?utf-8?B?ZFJJNFhxbnVBRXpZNDQ2cUxoenVMbkZReFFhWUFQcnZwN09aVmtUeEtqRmtH?=
 =?utf-8?B?bmJxUlpadE5ncnlYZjA1eUxtSlQwSmE1YjQwQkNJeDJjRGhCOFJ0RmhTWUdy?=
 =?utf-8?B?K3d6ejVveTY5blNjNVFWaEZYVnF3bVFlR3oycm1uOEhnNStROVRZQjhKbHpm?=
 =?utf-8?B?SjhyVmRiTm8vanpVZGRMN1NVeWtyaDRXSDNNWkxCZjY4RUxjeG5kYk0rek10?=
 =?utf-8?B?OEpKcCsvSUJPcXIxaDF3eHB3b2NVSzB1QTQvK0pxeUtZY3pYS2ZSMjlVaWJx?=
 =?utf-8?B?SFhqK0VNUjJSdThqWlJBR1JVVXhJWTFLRTkzTFB4OTREQm9uM24zc25HNWk1?=
 =?utf-8?B?SVJwaXl3ZjhCdmh6dnhjeDh4eUVtYVZFaUM1WlVuRHVCa1FHYm5LalA4V1hS?=
 =?utf-8?B?WVIzeWY0Um5wdUdjMUlQZEY2SGJVRHRjQUpJeGk1bHphVkNZZ21wdGZJSDdP?=
 =?utf-8?B?QzV2cTMzY0hLSkQyY0pRSW5yVmh3RzdkTVRJK2FWZGs2a0I0ZUlXUlJKaUJs?=
 =?utf-8?B?amxpZm0xUkNyK2FSREgyS1R5ZUxFZTRPUWMwMmpseXZVWkJLL0dMb1BFRzRp?=
 =?utf-8?B?T3VIYXpTNU5IRTdtaC9kczJ0UnoydC9xQTRVbnRCSytYUTJOalJ2cE9oRThD?=
 =?utf-8?B?ME94TEhwRmdzQ2xJeXdJNXNlRlNFMm0wUUgwVnBGNTQzUEdKU1ZjTFJZKzds?=
 =?utf-8?B?QjIrNlhYbElRU1ZCTEJZNWpGL1htd0VTYStKUDEyT3RhT3cxeVZ0b0hnL3JP?=
 =?utf-8?B?VXFKTnRQaGRNSWE5VjRNU0s2QXI4ZkJ0Wk1saXR5UnJWTlozR1A5Ly8xVUJM?=
 =?utf-8?B?TjhndmswOE41aDBUWVl6bFFXVW90R09yNjgrQ283cG9WNmZ2aFRNbGJsTWhI?=
 =?utf-8?B?Sm1tOWlocHd4RkxaY3FjK2hPOWpPdUV6OUFoZ2IveW15Vnh4dkNtRlJmZS90?=
 =?utf-8?B?RVJBZVZyV2JiRW80SnpKam1xaUpXMjZwcXRNVElCRFFaK3p6MENuRXd1ZUFp?=
 =?utf-8?B?bFRZS3Jyd0ZieGppblVuc1FGY2R0cUoyZ0FCd2xCdzVlWkYrQUsxRGVJZ2lJ?=
 =?utf-8?B?S1JhRm1Fc25UbXBqZTNjaDUwRVdLaTc2Njlac014YUlvb0xoNGRYTWJDRERy?=
 =?utf-8?B?ZVoxVm9RTE1UOFZ0Z1BTanVmakZWRk5KYUcwVytJSEJsK3paRWdITXFGc3RL?=
 =?utf-8?B?eExKTFN2eHRpak1uUEZveWFpVTRPUmQyeGh4RHF1ZFNxZVAyak1LL2RIVkt1?=
 =?utf-8?B?d2ZTME9ZS2V4UzZVMzdQSmtIMzNlR3lDUFlteWFLNUtzRm5tY0xyNHg5eWNM?=
 =?utf-8?B?ZFBDM1FURHp4Sm5La0tGdnpMWmI4Vm5UOGpBNUJaV0poMmoxd2F0b1JqbWd4?=
 =?utf-8?B?NmdpOHVBU0s2UEdkZ3Z3VHRiR2Q0WnMvcmRIL3RNZTBhMU1hTlllWXBhcTQw?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59A334023EF3204EA2769B3DB3C1F886@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2tXip8+Ytec3b46Re+dQDMrkuM8evxmfu20JXZi4z0ZrTsba0L1J7yaxCgKDby8WleOqtjL/Zopf9WkjSNkAz2KdmLG14FEDRMnEIm6IrRAz3K4ob/yJnQy73bfkUuN9udgX4Ut3Wk3kaPORXTCOei2/DSQJ7vv34WgdHX7PAKVHTHxbvNxcgp85k6i+FqsqWlPnVGNWoZWYXV0ioiet/3My6TySdeeX47KgWRlCqiV7VzIIRMrgLaHpeU+GbmuxyxQiv0wFn774EoQ5ub3DkOqULNTJXOPAqnMqoKqO96gG/TY9W3PCctA22QhFn50BnUNSpRKaoQb4o0dcilfKeNwZu1SoJk2WoNHrIqzUMufKuZKOT+UIqnUKgGL1gKCLSim9k6PNAHJs9CSea3GzLilHp3XX39JdlAKrVJcMk58R8gyzntORYPFBDMAqw/aUxmcZD8ON1SIVe5SDOqgcbZ3S3mBzSe+cQyzHdfzWJ/dALDQYunMaazmLks1iHqGOTwQer8CNigiMYO3A9tJVu9h0aAvLFMi0ikrfpmjJKjFfDRykSbBG1zPFj0shHhxoihTqkEXbGPksYxxLxnWK22lGEXHXQcOJdjtk046FuQi6xvxeJtfE0gHZrRLvB3hd
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c432e2-c962-4633-4842-08dde904c63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 03:08:07.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjO3OQOcizdTWPitAX6CB81tgoDH0hXyyNKkWSelPUE2i/ghiduDQ41nQl8+2MgWLQ8XLNy3zw53yi7Vl+ZOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11704

DQpJIHBlcnNvbmFsbHkgcmVjb21tZW5kIHRoYXQgdGhpcyBwYXRjaCBiZSBtb3ZlZCB0byBwb3Np
dGlvbiAxLzYgaW4gdGhlIHNlcmllcywgYXMgaXQgc3BlY2lmaWNhbGx5IGFkZHJlc3NlcyB0aGUg
ZXhpc3RpbmcgaXNzdWUuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KT24gMjIvMDgvMjAyNSAx
MTo0MSwgU21pdGEgS29yYWxhaGFsbGkgd3JvdGU6DQo+IEVuc3VyZSB0aGF0IGN4bF9hY3BpIGhh
cyBwdWJsaXNoZWQgQ1hMIFdpbmRvdyByZXNvdXJjZXMgYmVmb3JlIGRheF9obWVtDQo+IHdhbGtz
IFNvZnQgUmVzZXJ2ZWQgcmFuZ2VzLg0KPiANCj4gUmVwbGFjZSBNT0RVTEVfU09GVERFUCgicHJl
OiBjeGxfYWNwaSIpIHdpdGggYW4gZXhwbGljaXQsIHN5bmNocm9ub3VzDQo+IHJlcXVlc3RfbW9k
dWxlKCJjeGxfYWNwaSIpLiBNT0RVTEVfU09GVERFUCgpIG9ubHkgZ3VhcmFudGVlcyBldmVudHVh
bA0KPiBsb2FkaW5nLCBpdCBkb2VzIG5vdCBlbmZvcmNlIHRoYXQgdGhlIGRlcGVuZGVuY3kgaGFz
IGZpbmlzaGVkIGluaXQNCj4gYmVmb3JlIHRoZSBjdXJyZW50IG1vZHVsZSBydW5zLiBUaGlzIGNh
biBjYXVzZSBkYXhfaG1lbSB0byBzdGFydCBiZWZvcmUNCj4gY3hsX2FjcGkgaGFzIHBvcHVsYXRl
ZCB0aGUgcmVzb3VyY2UgdHJlZSwgYnJlYWtpbmcgZGV0ZWN0aW9uIG9mIG92ZXJsYXBzDQo+IGJl
dHdlZW4gU29mdCBSZXNlcnZlZCBhbmQgQ1hMIFdpbmRvd3MuDQo+IA0KPiBBbHNvLCByZXF1ZXN0
IGN4bF9wY2kgYmVmb3JlIGRheF9obWVtIHdhbGtzIFNvZnQgUmVzZXJ2ZWQgcmFuZ2VzLiBVbmxp
a2UNCj4gY3hsX2FjcGksIGN4bF9wY2kgYXR0YWNoIGlzIGFzeW5jaHJvbm91cyBhbmQgY3JlYXRl
cyBkZXBlbmRlbnQgZGV2aWNlcw0KPiB0aGF0IHRyaWdnZXIgZnVydGhlciBtb2R1bGUgbG9hZHMu
IEFzeW5jaHJvbm91cyBwcm9iZSBmbHVzaGluZw0KPiAod2FpdF9mb3JfZGV2aWNlX3Byb2JlKCkp
IGlzIGFkZGVkIGxhdGVyIGluIHRoZSBzZXJpZXMgaW4gYSBkZWZlcnJlZA0KPiBjb250ZXh0IGJl
Zm9yZSBkYXhfaG1lbSBtYWtlcyBvd25lcnNoaXAgZGVjaXNpb25zIGZvciBTb2Z0IFJlc2VydmVk
DQo+IHJhbmdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNtaXRhIEtvcmFsYWhhbGxpIDxTbWl0
YS5Lb3JhbGFoYWxsaUNoYW5uYWJhc2FwcGFAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFu
IFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
ZGF4L2htZW0vaG1lbS5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RheC9obWVtL2htZW0uYyBiL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jDQo+IGluZGV4
IGQ1YjhmMDZkNTMxZS4uOTI3N2U1ZWEwMDE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RheC9o
bWVtL2htZW0uYw0KPiArKysgYi9kcml2ZXJzL2RheC9obWVtL2htZW0uYw0KPiBAQCAtMTQ2LDYg
KzE0NiwxNiBAQCBzdGF0aWMgX19pbml0IGludCBkYXhfaG1lbV9pbml0KHZvaWQpDQo+ICAgew0K
PiAgIAlpbnQgcmM7DQo+ICAgDQo+ICsJLyoNCj4gKwkgKiBFbnN1cmUgdGhhdCBjeGxfYWNwaSBh
bmQgY3hsX3BjaSBoYXZlIGEgY2hhbmNlIHRvIGtpY2sgb2ZmDQo+ICsJICogQ1hMIHRvcG9sb2d5
IGRpc2NvdmVyeSBhdCBsZWFzdCBvbmNlIGJlZm9yZSBzY2FubmluZyB0aGUNCj4gKwkgKiBpb21l
bSByZXNvdXJjZSB0cmVlIGZvciBJT1JFU19ERVNDX0NYTCByZXNvdXJjZXMuDQo+ICsJICovDQo+
ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0RFVl9EQVhfQ1hMKSkgew0KPiArCQlyZXF1ZXN0X21v
ZHVsZSgiY3hsX2FjcGkiKTsNCj4gKwkJcmVxdWVzdF9tb2R1bGUoImN4bF9wY2kiKTsNCj4gKwl9
DQo+ICsNCj4gICAJcmMgPSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmRheF9obWVtX3BsYXRm
b3JtX2RyaXZlcik7DQo+ICAgCWlmIChyYykNCj4gICAJCXJldHVybiByYzsNCj4gQEAgLTE2Niwx
MyArMTc2LDYgQEAgc3RhdGljIF9fZXhpdCB2b2lkIGRheF9obWVtX2V4aXQodm9pZCkNCj4gICBt
b2R1bGVfaW5pdChkYXhfaG1lbV9pbml0KTsNCj4gICBtb2R1bGVfZXhpdChkYXhfaG1lbV9leGl0
KTsNCj4gICANCj4gLS8qIEFsbG93IGZvciBDWEwgdG8gZGVmaW5lIGl0cyBvd24gZGF4IHJlZ2lv
bnMgKi8NCj4gLSNpZiBJU19FTkFCTEVEKENPTkZJR19DWExfUkVHSU9OKQ0KPiAtI2lmIElTX01P
RFVMRShDT05GSUdfQ1hMX0FDUEkpDQo+IC1NT0RVTEVfU09GVERFUCgicHJlOiBjeGxfYWNwaSIp
Ow0KPiAtI2VuZGlmDQo+IC0jZW5kaWYNCj4gLQ0KPiAgIE1PRFVMRV9BTElBUygicGxhdGZvcm06
aG1lbSoiKTsNCj4gICBNT0RVTEVfQUxJQVMoInBsYXRmb3JtOmhtZW1fcGxhdGZvcm0qIik7DQo+
ICAgTU9EVUxFX0RFU0NSSVBUSU9OKCJITUVNIERBWDogZGlyZWN0IGFjY2VzcyB0byAnc3BlY2lm
aWMgcHVycG9zZScgbWVtb3J5Iik7DQo=

