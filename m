Return-Path: <linux-fsdevel+bounces-74126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 718AED32B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A13E30EE2C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BD392C44;
	Fri, 16 Jan 2026 14:31:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737A1F239B;
	Fri, 16 Jan 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573885; cv=fail; b=okxNq+d0Sgy+amZG3r+PhBTsnF2PIdt2aRQok4QmhrU9lFgki1jK0QmLh/mSrL/ijiiu15Q4+JrI4+C32FxnL6PS9VKFiWp9lWylARE13PSEqlTJYxSxdBXNKag/NNudSQ3wIiZg4zEwpfF3n7DcCqAxDt5gEwHEZvD4B3dymWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573885; c=relaxed/simple;
	bh=97YCiviNAKQtKNr1rhinhJAtjcr8mjUk+ga2AphfTUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xgm0vfe3ffXwMja/Yq1cXbOz09kJXlCpU42gJ/fMIHm81mYQmC15ckdEktx2uDsdToUZdhFmEJacIe3MrSnIZzgBhhlgo/yS9qYlnIJkd6a90BMKQrqh0/l85kpZIALMs7TDOlnsC6zOJamj0DNU8WGmIHXcctj74/wzxjn8hU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL5pEfMNHKUMwYZbolmn+8BWM66ciQzJzkSjojmM4gvyk5CD5drBijmJSrROJJvQ/sx+aX3H1sikNXVyQX+zMcvtFhYpMBUHDfH9DOYQBaMV4pmRlrP0U9fhJAE4qzKDiJ+HzJD+VLNPe49IYxTPCoACLH2Pi5UIAIptMhkvNw9qcx+dNXb94exAxi2LSQU0FlEeJ6WfdH4ZZ5AQH6wnAARrbnSeCfu/LJ8MzaRNTOM8n/gsg5JyPDdRcBIONO4P5xwxKHsqSDUWFR3N7G5uQvnK9Y5Exu9iKNi8NoND75vxD9qALvVcsBHh61N4o0cKnUE2SPoXaDqNofLOOtYphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97YCiviNAKQtKNr1rhinhJAtjcr8mjUk+ga2AphfTUU=;
 b=p8BBJBZPCgtbxe7pS7+y/FYNNqEr0TEEld/mc/iz/CcdIli9PY5ZsJeAmDbi7VNLsCYWTlzkVr895C0BCgPX38qLs8aWCcXsOmOVuwHVavN+vpeSjxZh59OmjxN+8nK40Nv500pXT4s9N26rULKVfxJwB5VYzXdWUfxB1LLRuv21+OUL//gkDthTTJPCTIbl642LqkmqZUZm4vKL9Ue0HC9gZ1Zd+We+NeuZdS1b8TDWyxyFUHZlGU0epjf/xxJmuSkidB1yzrzrLgS35tDC3W0bN+LhB68HLrjnqanYe6LC5wZ8uxpPSFc5oi4UP9TwctPyPw/d+APxCvxeuy81tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO9P123MB7682.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:31:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:31:20 +0000
Date: Fri, 16 Jan 2026 09:31:15 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, oleg@redhat.com, akpm@linux-foundation.org, 
	gregkh@linuxfoundation.org, brauner@kernel.org, mingo@kernel.org, neelx@suse.com, 
	sean@ashe.io, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <b4ggvwwbxn3a4i3pyt6j27yl56yqyjlhylm57kjcgfr3esim7y@5l3mygsbfuqo>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
 <20260115205407.3050262-2-atomlin@atomlin.com>
 <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>
 <6531da5d-aa50-4119-b42e-3c22dc410671@intel.com>
 <zkl42ttlzuyidy2ner5sjfbg5b62l5mcmlcmardd534y2p2u2q@vz2w4nbwvbhf>
 <2cab00c18ed7499e5ef143c7f3198c61d56ede25.camel@surriel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjcaijzai7ohrcje"
Content-Disposition: inline
In-Reply-To: <2cab00c18ed7499e5ef143c7f3198c61d56ede25.camel@surriel.com>
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO9P123MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 843bc24e-8a7d-456d-6eed-08de550be9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3IrK3JjSEtETitUWUtFV2dWbzA0OFlzWHZ3SVJSYWlNSUNIbSsvL0xiS21O?=
 =?utf-8?B?OFFPSGhhdURvdHdRZWJ2UlZ4bjB4K3pjR2hMNmFJTmdxclJLdG5Db1cxMkZq?=
 =?utf-8?B?azJYQS9mTEhhWlFyekM2UytYcXp2Tm5UUFpiczQ3SEtRMHh1WjZ2Nm5TMHpm?=
 =?utf-8?B?R1VOWWJXSWREdHFCZ0dqdzUxZE81NHRJNVRYYkplTzJWbCtUQndzbThPbkZW?=
 =?utf-8?B?aUgvSlR0R2pnbThnbitqdzZFZlNoaEpUbEEwdU1xQ3VlYkRGaksxajQ5d0dW?=
 =?utf-8?B?SVdYelE1VTZmSFB0QzdHQUNXKzBRKzZxUExwOUx2dVRKbmhKalRCbUlRMkR4?=
 =?utf-8?B?SXY0bk44T2ZEbWw2cU9uWUJOTEFJc1VZcGVQcjlELzhIaE5Vd0ZzL1NBK2tl?=
 =?utf-8?B?RVQyNUEzMXcxRmV4bTdDZmNiRHBnVTU5cUhtRjJ6ZWs0UFFrakwyR3JXdGZq?=
 =?utf-8?B?aVJ3Zi9tNHc4cmpUbUtRVXQ3V2VlQUNMOHNWOFc3dzE0RGQxWmw0b25CM1Bt?=
 =?utf-8?B?dHUzMytNK29yYWt1aEN2cDlBYyt1VEQxa2tkd0UrbFB5SG1IbjlrcUZOUzE0?=
 =?utf-8?B?cmdBQ1JtL2NlbkpnRzJiRXI4a3VUbXRpVlV3TE52OSsvTGo4OHQ1NUpoc2Er?=
 =?utf-8?B?Uk9rb3lOQzhkNlBaNmJ3WEt5eXI0VFc4aWVCMU0vNGFJT1BiSW1PK0V5c1Fq?=
 =?utf-8?B?MjQ3ZGkxRWgrbEZpcG1YVEFMbUhUUU5tdlFVTGMvUnBvdlVwcDJTUkFuNGZi?=
 =?utf-8?B?T09Xd0thbkw5UHV5M0lTTVZ5cUFDOWdVeEN5QUE4T3ZvM3RTeCtBZ21QUFBl?=
 =?utf-8?B?Y0xRNFFYN2xyTEpDUjdFeWswY25KOHNQSGZoSUVpN0JlcnhkUmJMWCtVdURU?=
 =?utf-8?B?ZzY0RnU2UXhOdDRncG52MzhVZDBOaitNcnk0YzFJWUk2UDhOVEdCSXZXamJD?=
 =?utf-8?B?VTFjZk5NVlM0ZTUwWjZ3NHdGRi9Zc3lWVUdVeDBqdEdVSUgyeXhpMU5USTBN?=
 =?utf-8?B?Vnc5RVZONzF2WEI3MW1EOVRkSmZnS3EvVFZBdVR0NFFkRmxEeDFZTzhnYzNK?=
 =?utf-8?B?YTFtaTltajVJajVzUzhMakRnVTdncWg4MktIek9HS29UV2NTdkw0cGFYMGdL?=
 =?utf-8?B?ZmM5VDNiMXFMZGJFVDcxZE9oUmZPSWJnNXNJdi9xb21YdG5LNXNsV3NJYm9j?=
 =?utf-8?B?ekQ2UU5FRGUvbnBzTjZkR3NucWhtRU4weFFLR0szTStRQlVhd3dxcXZ1bmgx?=
 =?utf-8?B?cTgrTllXMWlMYVNncHBDRjA1MUVaRFc5ZGRwZlV0NndJUGFvNEc0azY5R21j?=
 =?utf-8?B?M3J6YlJYVG9lMnIxdTY1cm1yQjlDQ0IyU0lRbUNQWG5iYTFvVnB4R0FXSHFQ?=
 =?utf-8?B?THBjWkx3SGprblc2emN6bTVHT3pQZzBxMDhKQ3AvQmcwRWpESXA4dXpwWEt5?=
 =?utf-8?B?Q250VlVROGpPVXlhOXdkMll0QjI3L1Zia2dkaXBFbzVqZXlNSHFaRTNTQTB1?=
 =?utf-8?B?TnhpK3dUMlNwQ0w1SjVTVURiRlVPY0YvY0o2OUF0QkM0b01GdFM4dkUrN1JO?=
 =?utf-8?B?S2p4cXFrZ0NhVGhHSXlXazhjSDBQbjdtaXBJa1IvcDhqc3pxY0h0akZRVlh0?=
 =?utf-8?B?ZkYwNytQMlRMQUdzNUg4aE54T3k0dEprR0doUndDZytQbXdSTkhuYjgzUlEx?=
 =?utf-8?B?L2ZSbDVQSlhUbU4vamdFWEtYNm10ZjZJZTE3QVlPTjZmVDVHdXFwcTVCRzhB?=
 =?utf-8?B?ZU5PUXN6amEwTzRRV0NZVGc4TisxeUJuTTFNNHlFNnRvVHpPbDg4SGlwQmVZ?=
 =?utf-8?B?bnBaYVh4VTVaWW92eXUwVU5hdFliZWRwbzJseThhMVlCUlNFV2lOVXBOSExy?=
 =?utf-8?B?eGZuOG1DdjZReXZ2OTc2NkhxRWNSQTVFdmJtQ1BJdHAxRTJ4VmN2MlcwVldo?=
 =?utf-8?B?aFJPc1hLM28xN1Vna3FOS0VVN3ZZOEtTdmEvRThqN3U5L3dYdjJ6aDRpVzgz?=
 =?utf-8?B?S1B2a3JTRGRXN0lQWTZvK3BxTk1wL3BONkFSU1RHdXlXbktFbjZESHRUcy9t?=
 =?utf-8?B?M0wzZkRUNGNlbk9wMXU4c3Eza1V0UGlTdWxiTGdNQllZZEozeEFtZDNrMUJu?=
 =?utf-8?Q?YQ5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODlybjNlYkM1OEsxSjl6N3d4Qzd2WWNZQ3JDZE12Ly9sa2h4YjF4OTRvcnhO?=
 =?utf-8?B?TEFjaW9IOGVDdW5RUnJzWEpzdEN6TFJEdEprdGsxS3BCRFpVSGJBcnc4NlZB?=
 =?utf-8?B?MnpCLzl6ZXpHanpVRW04Snl1VkNycjJVOEpoUFNId0U3cW81YTA1cWRzekdF?=
 =?utf-8?B?U1RKZ2FuaTVuVW9xSGJicjRHd1VRQjBIa3NFVnk0SlQwU0tEMjMyeDJDNkZl?=
 =?utf-8?B?MmE5SUF1QUNvS0tSNnF2ZWluYzJLYnhZdEJhWmtERE9KUjNyT0NpMHJsRkl4?=
 =?utf-8?B?T1FhTmd1aTJ1dFRjSVAwN2FrOEZ6UXp1Ymo1bXcxeGdieFZ1SEswNEprUWl0?=
 =?utf-8?B?eWRQdVdCOG1neWw1TThXa2pmY2VlR2cwNGpMeC9ROEt5MVdlendxWWxwN0h1?=
 =?utf-8?B?blZyWlhaOTJ2aUpIRHpCdThFd3VVWlEzdGVPZ3pyY3Y5SnplNGtWZHN1cEFO?=
 =?utf-8?B?QndCOE5WZnpSazNRN3BwMzJudnhXL3BMcG5UWUhwUDc0MDVpSDhSbzliY2Nh?=
 =?utf-8?B?QnhvRlZrOUt0S21pL0dpSmhET2ltRzNuVndQV0hhTmhlNXo4YVgwcHVQZ1J1?=
 =?utf-8?B?Q095R2prei93dTFNSlh4d3pUWWFRZGgwckNYVENKa0dXck8rOG1FVzkrMTRp?=
 =?utf-8?B?dWMxamhNZzBUNUtXM0xrSjV5UGRZV3NNTFF6L0doZENwR0xEazVJdUxpalVi?=
 =?utf-8?B?bzZGbnluQmcveE1TU0U3aGpaOTdEVkRhQ1BDdzBENEpGQ3NQV0FDTEpCVjZL?=
 =?utf-8?B?Ym5GR1RydlQ1SEdUZFRpek84TWVMRW14T2cyYlNoaDVqem5xdkp4R1pIK25W?=
 =?utf-8?B?ZlZ3VS9oV0JBZ2MzbXA3UGZWZmRQcDdNaGJIL01EaFhxRytYbi9DbEd2UFVy?=
 =?utf-8?B?a0RFVDdLbW1JOTB6cER1TkFtZCszN3lKUzF0TWptYldvM0xSMnNOcG01aXg2?=
 =?utf-8?B?SjZQeDZoa3JacnlOdkd4bkRnYzVvTWhWZmkrZU5ZSzZNVnZMbmpYL1VXbTlC?=
 =?utf-8?B?bHFZbFh1Y0lYcWZySXRRZE9lVjU4Yy9PVjh5QjgrMExpRC9TdytJMStGOWc0?=
 =?utf-8?B?bUxjQllxeE8xSEwvdWw5WWJuN09ha0JkWmhFN3k0YTlMRkRCR09Ua3VELzQr?=
 =?utf-8?B?bVdLY0hpL25PVVYwZ2o4czkyZy9BaG1wS2pkY1hGY0xEY1dFMHZSenRkNmli?=
 =?utf-8?B?TnlnNWU4UGVyWU5LV3h5cGJmOEd0MWJFaEtHQnRYM1hDTVRNbjNjK3k2OXMz?=
 =?utf-8?B?ZWc0TzNTRlNQTThmY0lLRkpBOUVwUEQwQWlJUkIzcnExSE9GUytFTDhmNW5y?=
 =?utf-8?B?UkZHRnZjNG5vMGRpR2owVldFdHBNU2ZzOTB0QXYrMTlCa0FPRlNGNmFjSTd1?=
 =?utf-8?B?ckFzcURXTlFBRTh6Y1ZxaEFMMWwrNmxydWhGbFR3b1lJdDdwcHlJSVF3QSth?=
 =?utf-8?B?T2ZORno5WU03bk5nZWVUVjhrdmNzR1pZYXhLc2p6WWQvWnhyaTRuY3VBWEFl?=
 =?utf-8?B?MEZWRU5wNUNiRkJIdUtMTC85S1ZtVDBsUExydWM4QTJQK01PYjBjckxCMnh4?=
 =?utf-8?B?SnJ1R1FVVy8yNmVueVBVUWszSVpOSDhLK1plU2xZRDc3MXNhYzlKV3RIY1dS?=
 =?utf-8?B?SEszbDRxTVpid1RQdmRPYWJ6d0VEc0tETlpyYUtiSkVaaUo3Vk93Y0lvSDhZ?=
 =?utf-8?B?SU5wellUTGdqcG9PT0ltc2tuMC8vUkFvbEhuZGhmamszZ1pUcnhlNXhCRkxj?=
 =?utf-8?B?ZUJqUTZXRTdnQnNoNTNIdFk2cHJuVkV5VlBkRlpLbWpBT2RYclV0UFhJMnM3?=
 =?utf-8?B?VndWS0xORTVUb3h2QlF2bFdpa1JtRFVnc0t3T1kzaW8vNm1nVmhrMEpsR25C?=
 =?utf-8?B?akNUSGhxL2o5ZlNzclhZWEZoOFZNZ2ZTZ3ZWUDJPc1JaQ0VKWDhtUUNpeHln?=
 =?utf-8?B?KzRwTzZIdlR4NUpORUYvdENGZlc4alFucjhCZlVZZWFPbmljMFoyZHlvdjE4?=
 =?utf-8?B?ZExDUVhkOVU0aUNPc0t4R1lMbFhjZTRCUmlZbUJhTnpsYnl6d0pkRmhUQVQv?=
 =?utf-8?B?TlFyY2FSZTk5czRTa2hEUldsTlM1ZVlYRy9PbE1rdUtrTVZkb2N3ZCsyaHA5?=
 =?utf-8?B?RVBpK3VOZ3J5Y0JsdDUzOFBRNStZNjd2c0ZyeHMvMWI5Y2ZkZW1kUkZkeFZW?=
 =?utf-8?B?Qm82MUZzN1NPYjA4anFUcjVhWE5Uc1dUUFlnbWs4bE1IV2tHaU1ieTNqNG9K?=
 =?utf-8?B?Nmdad0NyV2NMR2wvbjBqNUNhS0xKbDltK3l5bjZCTWIzYXpvMnRGY2cycFZs?=
 =?utf-8?B?YksvY2FJc0ZQNis4Y3dvYmVUZFpITis1WHRqRnRaaEhtRHFyd3FUQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843bc24e-8a7d-456d-6eed-08de550be9fb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:31:20.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSwNtkhOXgTEvLp3hVsopuZHMkNEokXaQTwzAlU+SD2U5XU7Q6u4XrOfCITTXRpiRNoUwhbW6JxD0MuidiiM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7682

--gjcaijzai7ohrcje
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 09:27:44PM -0500, Rik van Riel wrote:
> On Thu, 2026-01-15 at 20:53 -0500, Aaron Tomlin wrote:
> >=20
> > Based on my reading of arch/x86/mm/tlb.c, the lifecycle of each bit
> > in
> > mm_cpumask appears to follow this logic:
> >=20
> > =C2=A0=C2=A0=C2=A0 1. Schedule on (switch_mm): Bit set.
> > =C2=A0=C2=A0=C2=A0 2. Schedule off: Bit remains set (CPU enters "Lazy" =
mode).
> > =C2=A0=C2=A0=C2=A0 3. Remote TLB Flush (IPI):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If Running: Flush TLB, bit remai=
ns set.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If lazy (leave_mm): Switch to in=
it_mm, bit clearing is
> > deferred.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If stale (mm !=3D loaded_mm): bi=
t is cleared immediately
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (effectively the secon=
d IPI for a CPU that was previously
> > lazy).
> >=20
>=20
> You're close. When a process uses INVLPGB, no remote TLB
> flushing IPIs will get sent, and CPUs never get cleared
> from the mm_cpumask.

Hi Rik,

Not close enough :)

It is good to hear from you, and thank you for the clarification regarding
X86_FEATURE_INVLPGB.

You are quite right; as flush_tlb_func() serves as the sole mechanism for
clearing bits from the mm_cpumask, bypassing IPIs inherently bypasses the
cleanup logic. Consequently, in this scenario, the bit is set upon
scheduling but never cleared, as the hardware-broadcast invalidations
circumvent the software handler responsible for maintaining the mask.


Kind regards,
--=20
Aaron Tomlin

--gjcaijzai7ohrcje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlqS68ACgkQ4t6WWBnM
d9bxkQ//Vpm4tNJAZqP6CqI4wA9weliiIUHs4abgr+6bVXr5nSm9Rbx1PeTZ6TOC
HoTjBOoUkaPNQ9seD6yvpW5r5PNtxsu0vrJoyyoDoAvxZkUeCCziHtlozuRYtqWA
Mac3YKHPA7OYJ4eFY0DklwAOjoGT+TXd1hjr2S1vYwmJMF4FFPRNppRYXgMLF8Jv
s+YVRgcoIf83aiXM14d8z4XK6Xn86T6Uyptr9j3HQJsVZnIX7cbmvy2w1lpfaeAz
0bmk/lL+h91dTTjaZM6Kstgq+wG32B48giSOqlrFIVRS+4wz+KwWOgmqdpjo3r3Q
PuIYFVnpfUNVRvA3WTlUObRX7f3zLSSxgkoB8Z+SaYPIfH11ua3PTbpZQB98N2M8
euEmphBxAj06mbu58v8eZWvHDgGVwa38IEiZ1WgHaUkhyfDTmoHqZ+BWAN1O/Rtl
eZgy/yjvEhTgnr+ua+wU8cw12b95joqeUoICCO3boxtJP6yGHSERxcr3/Qc8guti
dpOc+HEAV6SaIaLi8woMy+CcIXmnJ25jU3ByYfZoM1wNuQhlGxg4tmWKtKuDu3pq
OiYbt1cs2gwcLIgSIcdqLOGQMYAuBGHIdUqrGZ5b+IpaBKToY1W7K4aFAmccmwEM
okCR8LERdFQEEevNQd/I9box6Iox4VxumXFxIDdXwK6c2kwh+1I=
=YXgi
-----END PGP SIGNATURE-----

--gjcaijzai7ohrcje--

