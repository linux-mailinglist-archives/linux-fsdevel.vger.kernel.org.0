Return-Path: <linux-fsdevel+bounces-78667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKdsAeP6oGlXogQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:01:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5F1B1BB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7962300B8F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59F24677A;
	Fri, 27 Feb 2026 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zqe/Lch2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC526ED2A;
	Fri, 27 Feb 2026 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157661; cv=fail; b=FmYGyhb0+IZ8mmtUzu9EhU1W9qtbJTMjjM2MGm00NV3Qa2nB0PtasjOj6aHA0nyLLGBjco53WQCSLnsjXBsKbpFmGxLPmsMV1BW+IJAWp/eDLKVcq/bg9eAlHvSxaSZCbVSKR4eBXyHMPtNYfnURpC8f9/EDcAE074QvzIleYVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157661; c=relaxed/simple;
	bh=uFDFa8Pn7BS2jkfv7v0rnhYMeX4Yv49ep2h9DC/6ffA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U5MqxgPfWQhuW34gROrCjWaM0JqBUF0qiVKBnKlKewBYIzyW+2+hDX4uWpljHH/55XWLNwb8ruVs6orvzgNCZy+25BajQs67+bCxGgksH6oH8GE55kr2IuTgXEHpOuB4hWz+1UvXaRy0o6dq26hNTw279/+iPqFR8ziFW6S+fgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zqe/Lch2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772157661; x=1803693661;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uFDFa8Pn7BS2jkfv7v0rnhYMeX4Yv49ep2h9DC/6ffA=;
  b=Zqe/Lch2DtAfyPfhMWEtU6SV5FysFiOzrCxQ9SaIyXiWPseCe68LBS0g
   k+Jqg7xACz7qBM/1jL/t3QVSf8mRluu5GXvOJp0ZU07UyPj9Mpk9npnAV
   LRBCwq6v4aNjdS/9+W2RUEyYYmK81QQk1ABgjSAhOvVm2MvbiBmh7si64
   uWrxmrvwXCo8pgt+ApKkM5xRTiSxHhOg8IN2LHPJwhPS7PtIVwUvk7l/E
   jDR8nxZtLtxGh4+/MMW0oiehZF8UZID7JKUhREYn7waxBbnpk49QrduOx
   MQD0coGCFlZLYV/D30CbWP5jG6tqDQsjxmnIzP7FOVNy7kqLKbddmIqzO
   g==;
X-CSE-ConnectionGUID: MMp3Cno3R+Kwi4lGmIyZpA==
X-CSE-MsgGUID: fiUNBtILTayxxpjnzehzGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73109577"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73109577"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 18:01:00 -0800
X-CSE-ConnectionGUID: KSCEr7OpR9OyQTs8RxQ7oQ==
X-CSE-MsgGUID: /fI0mhs2SP+S4nHf1lOERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="254529386"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 18:00:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 18:00:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 18:00:59 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 18:00:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/15wweGQBqb0kD1j7gR2r0cQzEz4Kx2a+E5/6kYtkkD8i0JN2mPYg1pySByxfCAVKX7a2zTRBZxJO2QO2eD380CFKb8nPGT37su5biYRF4rMM1TLtuzovG/Yl8QaoeWtDn9/CvmiyhS3IF/9cR8MqE7DuTkRNo/Swkm7lyGRgvKppEgqmc5jxaLTZ+nyZJSdfpx97jtYFfZEZw5FKhLlmelrnxM/ni2ip3StiK5yBQ+muv7BkUu1LglB739frTBf3xPNehiskApDUp24PdApNPVqE5zD6eZNnog2ugK9DROYDyGDNoxIxz+1AbyBGCl1XW7OjW9KpAxlHARPGKJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRL2idku3GdvxZYIrN7Wzlf68xGVsdDZwc3RSCJPg5w=;
 b=iTmlnmDXoRombHBR3I/d7lnIHzXZTTlmaBOVJwU4lCcSata+tAlhek94xYBtrgfkp0aAN7EW862w1fF/gGzjyL4n/LwAhqj5bMkF08xvszoSz8VOm4r937utYI1PjJBnYD1FmvmJHEf071CBHMOETZlOomBmMSp2C685eUQS+Ru69IL9iVwhAlUbYpnpK02O5aNkOIDRCm5klCrac/t0T8mgFIm9GeReJP5CqBusD6ovUI2KMMWJOshmdgqgNBEnT1LBQuDMmLHB9v+L0DrcyTfpf8f9LvnfoTdIPVLruaTUr9ECoIJ95gV3TXlwknrRRZNOhApgitbgzJP+yXEZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 02:00:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 02:00:52 +0000
Date: Thu, 26 Feb 2026 18:00:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: John Groves <john@jagalactic.com>
CC: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, "Dan
 Williams" <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>,
	"John Groves" <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
	"Jonathan Corbet" <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, David
 Hildenbrand <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, "Joanne Koong" <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, "Bagas Sanjaya" <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V4 1/2] daxctl: Add support for famfs mode
Message-ID: <aaD6yQLiyZznfAxr@aschofie-mobl2.lan>
References: <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
 <20260118223629.92852-1-john@jagalactic.com>
 <0100019bd340cdd5-89036a70-3ef5-4c34-abf8-07a3ea4d9f92-000000@email.amazonses.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0100019bd340cdd5-89036a70-3ef5-4c34-abf8-07a3ea4d9f92-000000@email.amazonses.com>
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ebfab2-e205-42d4-1159-08de75a408dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: Yi2bCy6OfIdMuk3V+PakWRR7g+LsQbdoUrWkMNG07DFE+IaJqJ9liWyi+g1UJsM7KxzSb9fyS+0ZaxhCS04zZyc7GSCQc33QAHZ5kncUa3hKMusocq9cajN6nVPbSx35ENFpMCapOxsKpWOazdN7iif3XaIIZmaZjpX2lpjW+1vNHjGrt4Fpuy3Kyy0PAc0qUwuvzwfqfkWQPdLB26JexCPOG466T9JvfHdI7SIp438rX4q2nz6yzFGLufZ9O/8iSeC39VX4QVxg7kDxzTlGyCYl5g7peHhb32ytAfN5bw6kndHDbiUj/MU+ZseFkMdF7ObSS04eOU3blFNoRbRu+hh/XREiY/RvtHgF+EbXDAbPJnWD0MF6zwhMjGKzr6jQnPn/0q14m1AqoTTnBphnPTEjy8EI8iVRgtevM/53pYEBEIudvYiWdQAK//BFLVRX8/TJ7zEJzxGxx8c8J8RtVLtNZe6Rin6nZRf2f3mx6uaRDcf8R20R7Xrq4vYR8fmsIS5i4VoQ5/2MhV1U1vOLLVe2VXXZZujXsBpwuMGBoKQuxkfSdLUUopyllLXxeb7IWWrDqH8eb9jWTAG/sz6+vVtloOm94YbZE/QlrTLIbarmW42QfcZzaoevQOjNiTQabj3NX6dKJJdfLiBrEniaugTX10j0cyjB4xW+R1VR4vQPhN95XurcWDM2wqwFtTMb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhEWVJNamMvNlpMRVlGS0pMOTRncVBxem9TVlBjMzdIZjcvUFAvdGd6Um83?=
 =?utf-8?B?cUxjd243R01adGViQVZZRmh6MXNZQjFMNlVjczd5Z0VDT2d0amtHd09NSGRl?=
 =?utf-8?B?cmtVZnBtOWdXMWJEdEVkNERObDNCd1VxSy91c096b0VMMjg1VGZoelhhN3A1?=
 =?utf-8?B?Qi9zeTBHWDdyREllVDU5ZlF0SWVnMEhMN0F2ajA0eFdRUjkwaEJIN3gxV0wr?=
 =?utf-8?B?dlpuNnhpTnNsUitTVVlmbjFXK3RjVmRKZXc3bXQwdEpRZW85cHp2aDRHVlJk?=
 =?utf-8?B?NG5NL1A3cDNCcW0wYUdaTkdtUGt5MUhYYVVwdk8xeUhWcnlWMWpxRCtQR3ZE?=
 =?utf-8?B?NXNYWTdrTXpOSEp3cFRhSXkrdW9XZ1hjeGE5UGVlejI4a25PNVNjNE0vZmp4?=
 =?utf-8?B?VXlJYXVNU3pWSDF2TXZVWnh4KzA1dGVORkZSWjBJZUFQOFh3SzdXRGkwZGRa?=
 =?utf-8?B?ekU1Yk5yVlVOT3pWYmFPVVJPc0FBVGlBTVdsSmQ1TUo1NU1Fb0RITVJjUmRm?=
 =?utf-8?B?ZjIxeU9PTVhtTWxOUW1qSmJzNmF4aXZrZUNGem1PWUdiWEtDbGlqbStsNjdk?=
 =?utf-8?B?RjI0d2R1alU4SlhQdGpjcENmQWxlRDZYbHl0d0VodVdVUUR5bFI3SmQvVXcr?=
 =?utf-8?B?RHZLTU1CZ1RvTG9na3lUWjlGTGJkRnFaUDlvUzhiaEpuL0FQbHFXYkd5cHZp?=
 =?utf-8?B?N1QyYjdnTlM0a3RWZ3FFOWJ0Q1NkbEk3YVlOM1RpY1VxZm4rR0FmcVIwR2Yw?=
 =?utf-8?B?a3BtU0NhYTl1Wk45M3B5M28zVC80ZUtvWVkrVi9lRVRiYlVvdEpINjhyNXI1?=
 =?utf-8?B?UFBkcmZaaVpFVWV4T3R0bXcxY2NCSjJlMTNyVWFod2FqTWZ6TkFPMy82aytC?=
 =?utf-8?B?dHg0UDQrMThORXJzT0poN0NDbFAyblBiRGJEZDVneitGYm9zdVovRXlyUlho?=
 =?utf-8?B?MFJOTEFIYnF5a2tsNk9pM3diYjJjejQ1dkZldUtoU3V0SUJ5cHJkZlUyMjBy?=
 =?utf-8?B?ZGVxd1JQeStwa1gwSkRNRThGUzRDd3JUT1dBWmJHYy8ycVRYaDNUaVRPbzQ2?=
 =?utf-8?B?NlpySmgxRXErNU04bFFZMUtIVG5BODNRaEN2SHh1M0ZEWmZUUWFRdXVaRU9R?=
 =?utf-8?B?UnpSZ2lYT2liTlVFT1hiSWhZQzFWTmVsRHZNOFBUS2RXVWtxSGJPUkV0MUN5?=
 =?utf-8?B?UXUyQnR5ZThRT2JpT3B1UHBaM25hMGczQ0U3L3VuRE5KUDIvWXJTOG5CSVJm?=
 =?utf-8?B?M1pWTUdpOHJNb2ZuaHJJYU96WFk1WnJzeDRJNWRzb1pyc2w4RnYxQ1ZnMEIv?=
 =?utf-8?B?VTZXL1JkamNaTy9OcHJRWGRUYWc4L1hxaFJrcWtXWXZ1UlZoai9ybnJiOW1p?=
 =?utf-8?B?Y2o0NkM2VmpBclBGZCs0S2ZpSVBMQWRuYmRHSEt5T3VDKytYSmtUdWJlSklU?=
 =?utf-8?B?Q2c1cktWZ0pDZFhXVll3SGZkU3luTFdIdk0vTmRuZ0RaajlwT3haRVpVaWUz?=
 =?utf-8?B?WEQyd0htRXo3OVVaTDNtb1NKemRJT1BGOFNYaTBTNUk2U1Z6a0VMa1hsS0Vr?=
 =?utf-8?B?amY5REpKUm0vSGR1Y3g2cFJkUW5iRjNrbEpIVWVzSmNDdEM3czViVk1adHpn?=
 =?utf-8?B?RnN5czJkVURGZGVnZ1FwYUMvSlhDLzF3bTZIQTl2bFdXd29vNlRLMi9STFNC?=
 =?utf-8?B?bWpLeFVTOTJXS3pxN1k4NWNWck1lMDNDNnpuTnU1MWtTQ2pUZHdKUG5oS3dl?=
 =?utf-8?B?eG5nQU1DYzVzdlZMZVZVekJZQ3B2Z3YwblhaNGNsaGtBc3M2R0doeWx1bHdN?=
 =?utf-8?B?OC9KTS9wOE5xRDBZaTF1TFBKOHhoZnpONThBWk0yRWZVbS9wbXhCYUpaWURl?=
 =?utf-8?B?dXBlNjhJV2NIWnVYa3MzcFQwYU9GQ2NQOUpYeEZKWlZNOXkzcXAzcG1sTDRW?=
 =?utf-8?B?K1pmZDJoS0RndWkwN1EyRWtZc0hsK2dCcHZrQUVndmpTSE15WkVKMEtHSWZ5?=
 =?utf-8?B?TnFLR3lyY3JvSkhQVU5CazNldzlYc2x0UjMyS1NDYTJtVmhPK2owbDQ0UHIz?=
 =?utf-8?B?eDkyUjgxeDhvbzJVNTZHaytVZXFpb21hZCthb0c0NUd3azVDTm1OVjF4ZDl6?=
 =?utf-8?B?MTR4S21DeG9ESmlBblVseU1mUGY1TkRsZVNYSUNwaVdlMG1tMW1mTm5DV3d6?=
 =?utf-8?B?d25FTjFCZlF2eWRVUTVURkpVWkNIZEVLSWNUenRTLytzMFY0dU5pZlpuVHpM?=
 =?utf-8?B?dnllNGZMNHd4STFWT0tBeXlYWjRsUkc3Z3cvQnpudWtRNmVoVU0vRHN4K29S?=
 =?utf-8?B?R28yb2R2cGxFV0FzMjErR2NsSWMvYTNzbENtWW9Rc2ZUQkZBSE5hTDdjY1Qz?=
 =?utf-8?Q?2jTZTrVSB9lKJWiA=3D?=
X-Exchange-RoutingPolicyChecked: BcxTHFht9obSukuG5kL2l/ITVqh+bJjTp2N5fF76ciujmqmqljujENguMn91mRqdYynu3dnhd2GvMj7cdc36bRGrKbI//RcZ9kXkKvatE8zeUIzRtOp6cjV/FaWKeEyC4kryQZ9ThxqDRG3DbF5P4pwwu3rI9vPFHjlqvHIyyIPm48jw9mdqNvhLEJscd54hQso5I+v8XJT1zVsDFqhVddDdtxwBJgEzSoal8RZTDw3a6gnN/pbd+zGCMVQOzKiWUsAq7AEazVRomnb+XeT7iw1ZooRJ51dT2ffBIH+7u7RALNVYdmT4e0iYZKJjysFpNTINKHFXXfqFbtcnygZvEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ebfab2-e205-42d4-1159-08de75a408dd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 02:00:51.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa7zOwzUSHk22ZQW6UpYkDozKDwJvjaD4G3Eelk1nlgRkuaEUoK7YPMwX5AKTPTU8zn3kSIFbfOUxwfmcD8a9Yd5sxjYTKtQCK3BeifVTZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-78667-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 33E5F1B1BB9
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 10:36:38PM +0000, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Putting a daxdev in famfs mode means binding it to fsdev_dax.ko
> (drivers/dax/fsdev.c). Finding a daxdev bound to fsdev_dax means
> it is in famfs mode.
> 
> The test is added to the destructive test suite since it
> modifies device modes.

Make it clear that it is added in a separate patch. (and assume you
can drop the destructive part too.)

> 
> With devdax, famfs, and system-ram modes, the previous logic that assumed
> 'not in mode X means in mode Y' needed to get slightly more complicated
> 
> Add explicit mode detection functions:
> - daxctl_dev_is_famfs_mode(): check if bound to fsdev_dax driver
> - daxctl_dev_is_devdax_mode(): check if bound to device_dax driver


The precedence check (ram->famfs->devdax->unknown) now happens in multiple
places. How about adding a daxctl_dev_get_mode() helper to centralize that.
It could be private for now, unless you expect external users to need it.

daxctl_dev_is_famfs_mode() and _is_devdax_mode() are nearly identical aside
from the module name. Refactoring the shared part into a single helper will
also make it easier to add a daxctl_dev_get_mode() without duplicating the
precedence logic.

> 
> Fix mode transition logic in device.c:
> - disable_devdax_device(): verify device is actually in devdax mode
> - disable_famfs_device(): verify device is actually in famfs mode
> - All reconfig_mode_*() functions now explicitly check each mode
> - Handle unknown mode with error instead of wrong assumption

Wondering about 'Fix' mode transition logic. Was prior logic broken and
should any of these changes be in a precursor patch that is a 'fix'.


> 
> Modify json.c to show 'unknown' if device is not in a recognized mode.

I think this means disabled devices will always look unknown even when
the intended mode is devdax or famfs, but disabled. This seems to
change the meaning of mode from 'configured' to 'active' personality.
Can you detect the configured mode even when disabled?
Perhaps a man page change about this new behavior?

snip


>  
> @@ -724,11 +767,21 @@ static int reconfig_mode_system_ram(struct daxctl_dev *dev)
>  	}
>  
>  	if (daxctl_dev_is_enabled(dev)) {
> -		rc = disable_devdax_device(dev);
> -		if (rc < 0)
> -			return rc;
> -		if (rc > 0)

Please check the return code semantics.
This gets rid of the <0 vs >0 distinction. That means a '1' skip
becomes an error return to the caller. Is that what you want?

Previously, we had a return 1 from disable_devdax_device for
“not applicable / already in other mode” and I think that is now
gone.


> +		if (mem) {
> +			/* already in system-ram mode */
>  			skip_enable = 1;
> +		} else if (daxctl_dev_is_famfs_mode(dev)) {
> +			rc = disable_famfs_device(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_devdax_mode(dev)) {
> +			rc = disable_devdax_device(dev);
> +			if (rc)
> +				return rc;
> +		} else {
> +			fprintf(stderr, "%s: unknown mode\n", devname);
> +			return -EINVAL;
> +		}
>  	}
>  

snip

>  static int reconfig_mode_devdax(struct daxctl_dev *dev)
>  {
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +	const char *devname = daxctl_dev_get_devname(dev);
>  	int rc;
>  
>  	if (daxctl_dev_is_enabled(dev)) {
> -		rc = disable_system_ram_device(dev);
> -		if (rc)
> -			return rc;
> +		if (mem) {
> +			rc = disable_system_ram_device(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_famfs_mode(dev)) {
> +			rc = disable_famfs_device(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_devdax_mode(dev)) {
> +			/* already in devdax mode, just re-enable */
> +			rc = daxctl_dev_disable(dev);
> +			if (rc)

disable_* helpers print an error message on disable failure.
Seems this should too.


> +				return rc;
> +		} else {
> +			fprintf(stderr, "%s: unknown mode\n", devname);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	rc = daxctl_dev_enable_devdax(dev);
> @@ -801,6 +870,40 @@ static int reconfig_mode_devdax(struct daxctl_dev *dev)
>  	return 0;
>  }
>  
> +static int reconfig_mode_famfs(struct daxctl_dev *dev)
> +{
> +	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	int rc;
> +
> +	if (daxctl_dev_is_enabled(dev)) {
> +		if (mem) {
> +			fprintf(stderr,
> +				"%s is in system-ram mode, must be in devdax mode to convert to famfs\n",
> +				devname);
> +			return -EINVAL;
> +		} else if (daxctl_dev_is_famfs_mode(dev)) {
> +			/* already in famfs mode, just re-enable */
> +			rc = daxctl_dev_disable(dev);
> +			if (rc)
> +				return rc;
> +		} else if (daxctl_dev_is_devdax_mode(dev)) {
> +			rc = disable_devdax_device(dev);
> +			if (rc)

and here too...the disable error message.


> +				return rc;
> +		} else {
> +			fprintf(stderr, "%s: unknown mode\n", devname);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	rc = daxctl_dev_enable_famfs(dev);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}

snip

> +DAXCTL_EXPORT int daxctl_dev_is_famfs_mode(struct daxctl_dev *dev)
> +{
> +	const char *devname = daxctl_dev_get_devname(dev);
> +	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +	char *mod_path, *mod_base;
> +	char path[200];

We have PATH_MAX for the above.

> +	const int len = sizeof(path);
> +
> +	if (!device_model_is_dax_bus(dev))
> +		return false;
> +
> +	if (!daxctl_dev_is_enabled(dev))
> +		return false;
> +
> +	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
> +		err(ctx, "%s: buffer too small!\n", devname);
> +		return false;
> +	}
> +
> +	mod_path = realpath(path, NULL);
> +	if (!mod_path)

Maybe a dbg() level err msg here

> +		return false;
> +
> +	mod_base = basename(mod_path);

Please use path_basename() because of this:
https://lore.kernel.org/all/20260116043056.542346-1-alison.schofield@intel.com/

Give me a minute ;) to push that to the pending branch and you can
work from there: https://github.com/pmem/ndctl/commits/pending/

snip to end.

