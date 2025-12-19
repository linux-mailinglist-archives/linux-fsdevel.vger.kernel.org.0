Return-Path: <linux-fsdevel+bounces-71784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BEBCD1D4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC9230C0594
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE6338595;
	Fri, 19 Dec 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8ubbmsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E4285050;
	Fri, 19 Dec 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177251; cv=fail; b=XZVHIZMQGKpHQ0e+Jm0SYFZaGL3A66QidOUSlpX/fHCeGuaxs3PJMQStAbMgeK39ubr69JXRrPCKdAmzNBSbZbzZ1Tra/MYh8320vsZG27Z686SSk1LS6aQMxQq7k1QXU8eeWlpTS1IuPrEjtsvIdm6bfeAd/hsQUMWO3LnFdcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177251; c=relaxed/simple;
	bh=Gp7uY5r+lBZsputjdKjrBCGrn5EjO9CGBCLC0X4Frpc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y5kryQ1V5WbyF/M7p5OXcQRt2qXS8DjeREQr+usTR9ccmo4YCA561wyZzz+bE8ZqjGDEYYWGj+DRws0BJ7Jn0tNw78WsPoK9kovRd2ru8c8nfisQJcIdyTfAltEd3XWe1CPFfcDpGjjXws1xN/GixHBRSSGVw8TqgSpXduquA4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8ubbmsp; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766177251; x=1797713251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Gp7uY5r+lBZsputjdKjrBCGrn5EjO9CGBCLC0X4Frpc=;
  b=Z8ubbmspPsSV88f6Ai8vNU8/gf9Uf8taPXeU0rN8KwM96EezTM/cS7AI
   qqHa010xLiBYXUWCMtwGblign781dOqiAJ1Y9wa3I7Qz2NQ2x5IyLQdSk
   DLrrV1PwKJIoay5ouFEge2+EyR530XC9WzPI26SbYvw90ATB+3u9+u/2l
   jjklRr9dJ8OAtIldW0EKon+Ie4aRGcOnDmiBNiZWXfeczaerrloTF38mr
   XPNrUP7WoR1fa+qO/Zz1jvCkss6Y9n2ujmGWAXZoUw9/7nY69hIqR85Jj
   UrG+YqEQrnb2BN8fYAMqJqV11H3bY0x8LngKIt3/ZWr4IFZhSLkMJqp08
   g==;
X-CSE-ConnectionGUID: aifGmwosRe2m54RgXqSnsA==
X-CSE-MsgGUID: zPGrVJbpT1eD7RuTwui8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68075836"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68075836"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 12:47:30 -0800
X-CSE-ConnectionGUID: Ji/VVx3XTDeb5LgoeexXBw==
X-CSE-MsgGUID: e5VdzkZcRwyJOI8HBzfZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="236381485"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 12:47:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 12:47:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 12:47:29 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 12:47:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPGlWw4R/pGPdnbt/iX7lZS1K5VAbeTlvDVyz+N41eka7sesh8lz0BaZYX3qDMOUlHin6EAbuMcf8aa3ghkMskpUfuwCdi2kpPjUobzpu6y+RYt7uuNwvH6eG/iktgSGbXIjT3Zppm2V/YiOOXwBw2Ast1v7jYYt9uaO/+XEI9dmMe+f7vGKj6rc++NGbJ3hmprSXkfem3WM9gDrldME7aIfUuD1fMG8HKhNVUuAGgv7k6i1Sn3zpsGXs4h3fsBfDy1PdbXl8Bf712r1lvqo80n4txDwdt5Q4RKynTmx+RSeUXyjZ2f0urVmmVAvfjVfjmydlpPnSa5530EK4vysGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXj9SDUHQcYIRQQyeVHZWvpEdLo7ojw4EvTpRKqhujQ=;
 b=VOKhjnOFESIOrntiV9b3izelQ4RHkVy8G1PA2oSlZ5LaUECfS/uU2B98Z+L0hR6ghqH/GvmgeupdS/i9b3011UESURF0FP4ZrSZGNISYFSqegI8Gal0Pjx8T9mQfS9RcXIgTzE3a3YkiH+/DzPXHcc6pF+u6Eav0uBY1WBhE/B8E6N7F5OsTXuNPchMjZX01ezjc7++/5/7SXhft7VSbYzY/C34jOyTFtv9VKNSmZMMH9JhPDL+fYu6U4pulQ6lHqAHt36oMHagYSNu3uzRmW68CH2cjI2GE/05ZgaUxhlVJ/Pc618P2rJUofgYmYoUELh5DqteLDEMqUDKLpPxQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB8942.namprd11.prod.outlook.com (2603:10b6:208:56b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:47:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 20:47:25 +0000
Date: Fri, 19 Dec 2025 12:47:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: John Groves <John@groves.net>
CC: David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, John Groves <jgroves@micron.com>,
	"Darrick J . Wong" <djwong@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>, Balbir Singh
	<bsingharora@gmail.com>, Alistair Popple <apopple@nvidia.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [PATCH V2] mm/memremap: fix spurious large folio warning for
 FS-DAX
Message-ID: <aUW52Z8QJX1mko1q@aschofie-mobl2.lan>
References: <20251219123717.39330-1-john@groves.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251219123717.39330-1-john@groves.net>
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 229d206c-8a16-4cad-335f-08de3f3fd0f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJdUv4b940TkIvj7pzuRiSb7fYiygnmeT45M85Dvsysuk4M4LkVkCuVyLdN/?=
 =?us-ascii?Q?apJ0ywysUjEhTvxJbpw7uWo885HOQrGTge4dJG+uNpkKheLqcPKjZMOAeixZ?=
 =?us-ascii?Q?Bq88wDYsALQuVKGM3rQlvihkFSIhxz3dB0NThfV4nMWAnINLQr0O1h0MrkAt?=
 =?us-ascii?Q?Ku1QGRO54EyeYtaqgeAz83lVjP79N09J7ajtNO1Q7C7OP48LKenjMOxUox9e?=
 =?us-ascii?Q?OX0zgmt5pfmoYcPceB6/Ih7NoqA5sX+ODORJaumi65lh53utMGbApvlAcvwR?=
 =?us-ascii?Q?72E587Ak98UODgzn9K4dcLWSaJdQW9S3Gxpxshr66KwbHFbMs8ITjZgQcV+g?=
 =?us-ascii?Q?2DIZLanIkKpQCceE/qdaEpJuB/+hvAdB6UYr+BqNrSkZv+ejZDN27u8NM+Re?=
 =?us-ascii?Q?g52M668cYB3FnwsMxAuXJ7iuMIC5LQxGNaLVK+1lLaWePSkOO8a1g/GezS7v?=
 =?us-ascii?Q?pZsX/qLQTIWRQq5znlZU/OePBSs5ZyTXj7e9GwZnIC7GApByZiI26jzmgBiE?=
 =?us-ascii?Q?rsDFXtINp9s6QI8i+4uDoYQInQjqBJuUrUl58JqE9F/sG5Y/ZpafLvGnx/pL?=
 =?us-ascii?Q?vmZCRRUXxmN66MtPiyUqgzViD3Ye0SvalSmE+21GTOWM7lVFJzdowpRN8elG?=
 =?us-ascii?Q?nfdXxB+xH1dOEoqT96CCX+lElZfH+bB0ULw7PY8TuLI+w4JE80IEMqI1OIpy?=
 =?us-ascii?Q?YrsikSIwApKaDF1+PUpjWxGkl++8u7tza/vh9/GBUBEtQ6Go9wf7DkDxfw8p?=
 =?us-ascii?Q?JQyqwuPnX5CElBQ8GT0980c2R4fN9U2HNZWlG/D5d565NqWtJduWG7ZXtNRd?=
 =?us-ascii?Q?JZ2MmA8LGlfJgCIKjiNakTmB+r2qXo9J5y/R1c8IcmYgksqp3UfYhqY4f2cz?=
 =?us-ascii?Q?NwYota8N6L1mzxo+ntg4DF/hQS0WI/k1qY+JednoveZB2qYp3xZXT9b8Qtog?=
 =?us-ascii?Q?1jCa3x0kFfX/BvEPePfuYFw2WL7lN38LgD97cqDrIyF88mQLN3bFES2wr9fg?=
 =?us-ascii?Q?TxIwnYtWoPKMgfyUR/um8W5Q+nz+oFGyH0Nn34E4u+sm/iB5963vSrK2VqJ8?=
 =?us-ascii?Q?bHxygdduaB7LXNKgI4ZSocTZTJdjhpWdaum2ufnoJStTd+kP5yY2wtARnK7s?=
 =?us-ascii?Q?yfBUewgsSKDXLVrXFeAqzL/1veh4VXNyPjjXqQ9+1z4oJ6OrDFJqUtA78phi?=
 =?us-ascii?Q?Afcxvq0dwpr0cPbgDRczVxZaAp4CQjNb72ZsD5pO1tn3yXwqKOvOPH5PNs6X?=
 =?us-ascii?Q?e01GsvXC3dggrATIMcMD1GbzWf3PUTOCN8GMX0q4pZnrmv8WpKYCO8c8yxkm?=
 =?us-ascii?Q?KTGK6HNCmrt6ewfi4KU0SBkOJ07rWYSGRvNkpO1LWk7bVUjPRMEtm4H36liy?=
 =?us-ascii?Q?wQumNzw3FFVgG3bFv/mMNZtGZBQOKbpnzA5raIJvxyGRDdO0Rk74xoTS2IQi?=
 =?us-ascii?Q?A/dtS/gICq9pZxPvy1RTlZGeDVVAhReL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvjcE2a/3arcN7FAT1G1itsY9AgwZ8oTL9Op2dDS3Qtu4XnwImZFEJwRfNJj?=
 =?us-ascii?Q?vIgqNb66V/xazA7BzNT0+uaWeLjQb9Y13ARCQAtaRgdqtpUuJdTp4jNup+UL?=
 =?us-ascii?Q?c0lwbWP7BBIKPzgjdqQUbeb+MeLZYSLlZoG/9p1Q+ugAsVhLGUEwuwLiOev5?=
 =?us-ascii?Q?bLXMvQ1zBWA4yY3m68fmMlaozDWRdKfKpv3I9/yuo41HYx2tTbvC8ii5RW1k?=
 =?us-ascii?Q?MFi5PQjmDSzOARyVS4Cuc5bZjR+BxyLENbwYUQpXbLHuBz4gDL/SuUxvnGtb?=
 =?us-ascii?Q?9XUP8bacbb4jFwKTCR5LwjbaxboiRmBXZRu5JUlmx2ESf4kFn8HLwvzVRPod?=
 =?us-ascii?Q?pYhDGXLPcK3I0bYq+KEBvlBThgND/MmPzr56Z0xGN+fSM9XU02WPUGNArMH0?=
 =?us-ascii?Q?OlpAOPcO5TnoyF1/Kv4BvRVbXVvs1p06MLAtNHYQn0UABNYrxNL3zi0k6O4t?=
 =?us-ascii?Q?t6Fnl9lLLmfu87QcM4BCp+k42fmKJ/ENkOBWFWIMQL5gqQnV1NyBYiiCbrbC?=
 =?us-ascii?Q?2eDisp40ttDj/1+P0azN5bTL9CYEiPppZ3N/1HKiM6YdcOe1t1TcvGtLkpSp?=
 =?us-ascii?Q?YU4ilwZNPgmJ3JqxxorDd8G9+G/y7iVvN68cHJMxrywvkjuItCalrCX3k2qe?=
 =?us-ascii?Q?/YNUbZRBqoFe7SsPLEMV3jU8Jqn4x9Bxm8v+0jha+YaNe7WnarEAerkX3TRO?=
 =?us-ascii?Q?ylH+OK5P+lZ19eg3N7eZrntbYm0CHLjWOlP8ClF1FLTvpeWVh/fbIipc28K2?=
 =?us-ascii?Q?fVh45JAyluaBXkFujCYY9ZC5uRK/jI6rqfFkQ9E/KMvMwehQ2kA07OKH9n1Z?=
 =?us-ascii?Q?E7n5Yfuk/LZgCIVWTQpI8tE4m9Uhz4D3kCT3SIJq/mX1xr/ZKMv7pNT/5S1p?=
 =?us-ascii?Q?8UZqzKnmRvheO+u6g4AW+oj9qg3VpdWAFX+NJmTx3B7TAgJyajRtC63Jck7r?=
 =?us-ascii?Q?mf2quXOutdDMWIBFGlknGz9EvaGmnWdPDXRseidQC4NwTAj1y+O4Rvb1AvjT?=
 =?us-ascii?Q?ssUEos3CVJzAA5Wo3DWCUQnkDPoMRlhHkV80ILLlrfYbFrypP9IySKdRSmr9?=
 =?us-ascii?Q?k0HJyn5eHgycqy7OCArCrMW3I2rBo3CHQi+asZgj+5uV/Xu8OQ6G542xTqQ4?=
 =?us-ascii?Q?UeP05udNTMoNr6xWOoATckFs5nGZigUXmMTwY2mnc5vOAw3h1wCQ+eKz5sOO?=
 =?us-ascii?Q?mKGcL38PiczGLPPTKJjC7YH50rzfQs54JXpp0Ch6J2T6ztoiR5TfHGTOmek4?=
 =?us-ascii?Q?jLU+O9/bTSUSVp3eIZGT4Y4xXwZFqV8WpbbuR1vqoNHfM/BiClldHXQlIHGk?=
 =?us-ascii?Q?xc24MTQC6Cyg7nEFlMBWiDF7iSLuvJHkUup1YSYRdT/Km0nD5NWOLhtoC/qs?=
 =?us-ascii?Q?r/3aMYhDKHCripWObY5AptV7cgLBXhXuC20Rp4pW/vwTR0JeQnVbCL14VufK?=
 =?us-ascii?Q?qiZvRt9EjuadK7Dy9BITj+ccWc6JH266XeguT5/iOnIjG1BdIiYr2VQtEJ0i?=
 =?us-ascii?Q?2Ye6iJubYdhL1phvMGe/ahs4xfY0bcxD0jx6X5ZeF91/tI75A2tGa8CnD2wG?=
 =?us-ascii?Q?ZwqB62//H6c8i0Tn0iGnigTzVyDwhuT0mlclw14mIpzuW6AM+hKP0AJQXrxt?=
 =?us-ascii?Q?AiQvbPoCwrbf53yix0NzVEp089CkSDgUyxCKWcNBoKTRLYTb+h+SDiPeBKAe?=
 =?us-ascii?Q?qrr/reGawh2aguAWSbpA/aG6EkhKqELZjUvMvAwEEW15kLCRiSxTU9sE7d5x?=
 =?us-ascii?Q?BYEbzPNfiHbQW3kI7L2Ze004/LieeRE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 229d206c-8a16-4cad-335f-08de3f3fd0f3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:47:25.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmKUtHo/a8CAJRaGTnSSdVorDh2BQTqYTgvUhiFVyZ38qeYJy3NHQp0AxzW5kQs7dQ3BjyeKYcW5tm4RDvbeJSHmUDeO1qBLc6x1HDUxFAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8942
X-OriginatorOrg: intel.com

On Fri, Dec 19, 2025 at 06:37:17AM -0600, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> This patch addresses a warning that I discovered while working on famfs,
> which is an fs-dax file system that virtually always does PMD faults
> (next famfs patch series coming after the holidays).
> 
> However, XFS also does PMD faults in fs-dax mode, and it also triggers
> the warning. It takes some effort to get XFS to do a PMD fault, but
> instructions to reproduce it are below.
> 
> The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> when PMD (2MB) mappings are used.
> 
> FS-DAX legitimately creates large file-backed folios when handling PMD
> faults. This is a core feature of FS-DAX that provides significant
> performance benefits by mapping 2MB regions directly to persistent
> memory. When these mappings are unmapped, the large folios are freed
> through free_zone_device_folio(), which triggers the spurious warning.
> 
> The warning was introduced by commit that added support for large zone
> device private folios. However, that commit did not account for FS-DAX
> file-backed folios, which have always supported large (PMD-sized)
> mappings.
> 
> The check distinguishes between anonymous folios (which clear
> AnonExclusive flags for each sub-page) and file-backed folios. For
> file-backed folios, it assumes large folios are unexpected - but this
> assumption is incorrect for FS-DAX.
> 
> The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
> allowing FS-DAX to continue using PMD mappings without triggering false
> warnings.
> 
> Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
> Signed-off-by: John Groves <john@groves.net>
> ---

Tested-by: Alison Schofield <alison.schofield@intel.com>


