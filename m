Return-Path: <linux-fsdevel+bounces-77183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FbLCdCVj2nqRgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:21:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F831399B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C7FE3001CDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFE28853A;
	Fri, 13 Feb 2026 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/QIx3gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3A2673AA;
	Fri, 13 Feb 2026 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017670; cv=fail; b=r+/IaZQSbqnpFkR/NxjmdLFpvKhDKiSmx9ql1mieKk8TkmFMA8y6rePOQO4nPi/VV993Dvj8IHD5oN5Nv4RzV/CUG19PQOpvyrbXo9Q6cdbgzPHEI5WxKPgyNcN0i2uiiDemQ8qemHO42OY0hECdcMqvOE787Qnb2C2m7hGLtrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017670; c=relaxed/simple;
	bh=YyTSXbuVMTuM4p1S00y/ZTw4L+fUZGEwgPnBt56LfTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rP39Z1bWsP7vUsVOAAHIFM5Qxc82O7Gw0d50EEQgmpJHqCpMIlJwVFzPQ7l90ZGqM+Xkuho5G8tDzf/YpMdmxb1f651/qnhoH8PBUyqZbFfXb0hJWGj4pgPohGSp2YFb9nVcz5XiiEu/v8LngNaTg4I0KG2+rVnLQrd6AhsmSJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/QIx3gq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771017669; x=1802553669;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YyTSXbuVMTuM4p1S00y/ZTw4L+fUZGEwgPnBt56LfTQ=;
  b=X/QIx3gqHZ2CLRw2PDl1dqP54O8qMcWC1qhI/kMvAqs8oDfL/FTDknxR
   y8fOPWC5MIZHlao4322EbHcakIWA8VO6K0YDJ74wId6xi/F7u4gGfEFWD
   7hWZy1u5gWuxZEHBJGMkD+Zn3I4P/WPB7bXAsm1/qWcSO9NpeoVtFC10s
   X+sfgv70i7yArU4b5Q14QAdWNBNiPpytS3tSV/MQ7t5Bspjh9GP1O1DwC
   ui4/zv2yxjYL4taRdFLkvl9NKpqP0Usm8E5akM9LboIY33v5T23H4Zhj/
   wW3OQqF3EDhEbOJ0YGZ0Yi6uKEwR/qY891+9/6skMyfXz9fwf4ovHiflz
   Q==;
X-CSE-ConnectionGUID: CIoYZHOlR3S3kuNXD4qruw==
X-CSE-MsgGUID: S7GQ4mylQOyu6KehBynzpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76052771"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="76052771"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:21:09 -0800
X-CSE-ConnectionGUID: OyHLUB6tQXy2XxJdWgkrRg==
X-CSE-MsgGUID: LD7jSbTDQk+JchYrcY7H5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="212124177"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:21:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:21:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 13:21:07 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 13:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s59x3NP/0E+rQmu5wDfqP1W47iqo/V7amGEZXZwCDCRHMXvYn0SJW/PDpibK3yB0BLTY02Ygz1MHGdbNM9EX8157nMb2+IhpRSdfhUCWf3NK7j5CaBG8JVs0zOINdyf9bc0esM5V+Cyte2ekYvxLKhuXhVMZ+AT1taTkgN8lprgBuCjKBKMqndD4hJjTbEkQzA2nC7bMr6NuwtU8Vj6HPfzRFzh4mrWUt4M/3tZX60BPQ4cl/tVZT8VRpVYkR1cLuF7wguyavTMxl9OIMaxyTcyF+vnSwLdTfUXSLenzSoKIUufKi99XpYtM6PHn1nSD27dxs1ig2gymzKeLpNYXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTNdWHlc7nD/ZYQg1RcugC5GCOdWmGy/MOvLfXXFPAw=;
 b=KYxSfNbf4baLaT7TuLyCqX+s7MRK285ARJ1wn9ovDjlaSTQINF5yh2u4uIfh6R/3G32i+tALeLPXaISeU7boUghieElpWsum79ZJcnT+rt2O4cCJoUXLQY7HP+EqpyHb+qiX6Ssge3ElxzkNpHmZE4qUOFbMThZfoz+dz6vHgFpBdSr7yoEydDnW6K32eoRiVepeNKk8PBo0FNG18QMrqjy6DMYA0a5g/j/AjU4swjxJ9XVzMf24aICxF2fhtj2NdYaHwjojV85CTdgkD5WYPRX/bw2GJPMQK/Qj3nFkh3KKOp4nJ+D8Nedz9iClDRCvls55s5saWmm5e6S6MFSORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA0PR11MB7377.namprd11.prod.outlook.com
 (2603:10b6:208:433::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 21:20:50 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 21:20:50 +0000
Date: Fri, 13 Feb 2026 15:24:14 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, "Miklos
 Szeredi" <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, "Bernd
 Schubert" <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>
CC: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, John Groves
	<john@groves.net>
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
Message-ID: <698f967e877c3_bcb89100f6@iweiny-mobl.notmuch>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com>
 <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: c3aa8902-c016-411d-30b3-08de6b45c345
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R4yXhXuJbSzIfWDe/DoPeL+rjru/Dl/X76CSM4d/uzbzmz4uOcqOvVNmORIq?=
 =?us-ascii?Q?EKcg6xU59CnlX14t7p6eAZYg6ZdYMNxZiPipIFYEPmc3dxLzMdrQh8UURHwN?=
 =?us-ascii?Q?udtxIZOYiNo3d8K9d+ERkXSk0HxEM+rRKQaFjlLXgbgQd+lpQLlEyFfJRswg?=
 =?us-ascii?Q?isP8tr2jRXY69Bjg/lWZ9TERpR8NU9YuflTCl5goFCcbQalAQnAc3cpE8Qi7?=
 =?us-ascii?Q?X81U/fL+QTXBU3F8auoTJPwkoeGY/EwGA72kkSusprx3i826BASiFonRzVEN?=
 =?us-ascii?Q?mBBqjakaoPCvWlA8/k6sxK6bTuPoWQ+GXw7hIXctRrbvCdzq8RN2KiHoRRzr?=
 =?us-ascii?Q?9tS3oHLzuuNSypMI1L+6gbqwxP7IymnvZtnEVvNSuL/1xvtCkCweGfRHD1p0?=
 =?us-ascii?Q?lCbkAEPKRAg3sttr6vQLUg/To+C1337Ar1mwPbE1pepqY4akP4e9vg7FXWIT?=
 =?us-ascii?Q?iQXWZao2esogumh+wTiELCZq0NPAGTyZMONV68nzbfTKIiYp309RbX/a/hsR?=
 =?us-ascii?Q?tSie79qGLje+I/9fcz9bsWkC/1DyKzzV/NF9Zu3DZ0wSI7Gd1MsVkkvYeCp+?=
 =?us-ascii?Q?FfSD8SI02XKH88Tljyu354dErVAqrUBYWBNapNi8sjNaKU24nn55FRZvvR5m?=
 =?us-ascii?Q?dY19mCxzr5DXoapUw+v+PhlA3KOfe6/dEnsF2akhfe6mrlRy3ZuFto0TPioY?=
 =?us-ascii?Q?zSDsNwemgutkKun+M/yhZrQGVm47DaUN+lWKWv0pKp8I2z7SXsJYW8yW7M6m?=
 =?us-ascii?Q?xoeJ08GmYT6I36Mkg9REH5sLLKVkDJ8/4pTT0yCSN7Zg5wQz8bQ12/9RVWk+?=
 =?us-ascii?Q?Xgo4aS5nS27Ce7NJx9zy4HhKA30cklVI7HQ86NRZj2UcIFk3JmQMfvG+m9WC?=
 =?us-ascii?Q?mPsdzkrBvwevHy23SBxOLiQxHn6mR01a/D5MVF/E7q+qXI6kYbM7dKqqNAJM?=
 =?us-ascii?Q?UpuVwvDdBEYXygdrNdGQamvplVyyez5HPEZ2bSKmlmLmtidVFW34Rca6zzfS?=
 =?us-ascii?Q?9BiKblnXlr0AuXbz/gi88QqsHdMWCJtUee7Q8baaJyKIxxADCF2tGACDksSV?=
 =?us-ascii?Q?3jYRCpTK82U05aVd7DNI1JWbKDx9hFQ6XDKrKaIAotm0FR2ms5Z6RSzkQKlh?=
 =?us-ascii?Q?kZtS8HQ7t5EPlkP3z6Wo71CTQ1ffyi8C405uInRvphijb2qFeq8h2/h30N/S?=
 =?us-ascii?Q?DPL8FvzBytHwyVHIIX1ikuZiVupVkoY2iEt0imffJLpPgOJYJXk91tZKTdC1?=
 =?us-ascii?Q?Tjpd2uK2kt9hJ05exUyECnHUBRlGHIY9WGjz5ZDT6qI5XYmi1c033TsW81Ew?=
 =?us-ascii?Q?uACehTjxlB+5E3Q6zXqExHHi5mT3lL3WYZj2E6DrgX3NzLazyR7c9EWl4opG?=
 =?us-ascii?Q?hQD88r5FFSyuqbafJlgngVtN7Gw3Eqz2VaVcN/nXYwXbXNuqdhBkpYzdUZrm?=
 =?us-ascii?Q?tjjK07XaF5WGBnPTeyAevlpRTaKJk0qsr0vPhUOyk4pxeJtf6w3wWFQqbCmE?=
 =?us-ascii?Q?UiYM03+zTo5vYCgc2gpWLk2SXgRSX+De+xrEPqoDkayZ/XC7A7Pu2Z+DtUV/?=
 =?us-ascii?Q?aZyAhSkB0B/ZJrrK5OI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3tAzkJne3MnAPdAtRsRFW5vBHb3Aeyc1ex2hq//ZX1bSQ7siz/5q54EBZFQ?=
 =?us-ascii?Q?lILxSNqbY65g2I6hgj/yAAECvUlYb6pcRhx3p0eE/Phkyk3hidjvm0eTLHEX?=
 =?us-ascii?Q?5RrsFoIAH9W6nbuJuGdYuPVuTMhVLeQNNZ+/ZOHNSQrzqc1VL/3OZFa8vm4q?=
 =?us-ascii?Q?ERS4kqj5IkCxRi4kjC6lg+hmafxfk04nMVdVf5BlOrAfPgoNdYxdoe6js35H?=
 =?us-ascii?Q?Q0UIYUCC2E1gKUZIqrMd6sMWyJjQ+YrZJzQfT7EozfBaXd5idV6Ohu9Z2Nmt?=
 =?us-ascii?Q?64SzQT5JBs0QcdTE/bqJfSxF7u4PURPK44Bw4u9/2YII+M5/yjhMU0+pP4O9?=
 =?us-ascii?Q?3m9bBsVVfsVzBnYQbg5bdGm9GzmPRnaD99OqZIq+lB2k2oXkPoRD/HovlbEW?=
 =?us-ascii?Q?IgdLMwyU6RqGFiZ0+7HCsU56SV3KUCGwwkPvL0348zezVmvlAKeGNP2oBNYG?=
 =?us-ascii?Q?PhzVy/Pwy9C1OaWHtMCk4GPrQCEkROaJFNOqOl7fF8cjTo/uvS6z448eKXJk?=
 =?us-ascii?Q?+U6pIDL9sQmyMqKkgQ4necQ6KcwdwS2hdmSQeLSIbwZtH9fnsSfZ8rBsF4pT?=
 =?us-ascii?Q?b/kWavERj5dzzGtrdj+ydB9qUVicxeRv/slniCpOCjXlkfXlErAKCwHJ6tXG?=
 =?us-ascii?Q?JotFZA3orOXTf+sVURQg1aqKCVexjRmW1qwRzBp3XRTF5eL0FKEZpNpz6KIk?=
 =?us-ascii?Q?LWPem2Fb2ms9Y2MaUVJz+bCHB/8tLk4D1XtwUhpjFClDBk7s4LiQ/6sXUgKz?=
 =?us-ascii?Q?zGsVw4hC1y9mWM1+co1++m1KByIS5iS56Z8sLVrgM7msDzqzKJwsAYZNyrdy?=
 =?us-ascii?Q?cK4bgPa4RALBCZrFfT4xJNFs5d6EcB2AXXRF4lXETY4zi+KrmqjVnKS2+x8t?=
 =?us-ascii?Q?cCYyqHzc21z51iSJkZ6Ru010yZge++osq9a27CfTtz5goDsJ8wLrisEBTHiR?=
 =?us-ascii?Q?CvhVfZIscH3rqJYjVnAsCoS8YrM8KOEZSxLXpOCevFoQbg8NcUNWVxhLAfD+?=
 =?us-ascii?Q?GLbGhi99CKMclEflZTe2jBBksPvEoXVLOSzIV5YBKxEhG5hREHwe6eT9penN?=
 =?us-ascii?Q?cnSfsj6VHB+yF5BVLQ++pHT6XEff/uz1gUKNoNk46odbejyehyqUfozS6Dc2?=
 =?us-ascii?Q?24HHq+zDqw1hOTSK25R8WWg+DsbCj3JLkplxlNiIUjSHhdIdTRZx9lZ74ene?=
 =?us-ascii?Q?YNku/9DRSXtiHPX7v1ig/l6+tt8wceoMhGeNSvWgcAzuW5QoAuQdU0KVSl3N?=
 =?us-ascii?Q?G33EaQYRUBj+byiyjJdamz+A6KQX45OkYgzybqsrTXNvLY7aCEvsx80DbmvF?=
 =?us-ascii?Q?8F8q7wr1Da04WQhPzYR2cYnvCNae7IqlnBxSz7rUhRdu46uAmYZ3ugp37CtP?=
 =?us-ascii?Q?rz9lmYNb50fwgR3+coEqlw/HQXvFT53ri68phR4LrlQeEN+3+i6mhm81bhtw?=
 =?us-ascii?Q?PmiEODPWsSe/bImyWOML8X9cuSadLh3gba9XG97p0RKb6nDNT/pMNLqWmUT4?=
 =?us-ascii?Q?koXEcDa0M7V60vOIBlNx5zSQVWLPk9ygI0qmv4flOF7St1aud2Lvo/wlOUf3?=
 =?us-ascii?Q?1KcB2F0j/K6KSaHi6d/3srPjg2vwFs1n0ld9uFWUsM1/Hmr4r48Eg2cTnEbz?=
 =?us-ascii?Q?HT0SsnJcHdYioxYePaY7Hp75rlnvFLxkLYnyW69XMeM7BlfPjeB7vzSH2Y1S?=
 =?us-ascii?Q?HoT8gdkHVt2uKx59QlYgORlaEHjZftx0z6uV60cNL7+ZBb5YLaIt79wJ4Cbu?=
 =?us-ascii?Q?2h5jNYOAnQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aa8902-c016-411d-30b3-08de6b45c345
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 21:20:50.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYIgH0SWt1Ft+zpLsWZ3oY7Ra11PL3ucLn78+pHOAN5t3fHOa24C68kXyE+WWx/pEPSsVDM3eKIiWzHMQYlPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77183-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev,groves.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iweiny-mobl.notmuch:mid,intel.com:email,intel.com:dkim,huawei.com:email,groves.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ira.weiny@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 46F831399B4
X-Rspamd-Action: no action

John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Both fs/dax.c:dax_folio_put() and drivers/dax/fsdev.c:
> fsdev_clear_folio_state() (the latter coming in the next commit after this
> one) contain nearly identical code to reset a compound DAX folio back to
> order-0 pages. Factor this out into a shared helper function.
> 
> The new dax_folio_reset_order() function:
> - Clears the folio's mapping and share count
> - Resets compound folio state via folio_reset_order()
> - Clears PageHead and compound_head for each sub-page
> - Restores the pgmap pointer for each resulting order-0 folio
> - Returns the original folio order (for callers that need to advance by
>   that many pages)
> 
> This simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while
> maintaining the same functionality in both call sites.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

