Return-Path: <linux-fsdevel+bounces-38925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E7A0A0A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 04:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644471883C27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB514C5AF;
	Sat, 11 Jan 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPmWUme7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5922149E16;
	Sat, 11 Jan 2025 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566571; cv=fail; b=MBnosdC+uX5u54msk9tOyScAp+neaYh1Ce713p3FYxkYEJYW1WPqIi0B6Mt4awJWjRbtQl/f9hHdegkq6Izql+9XMAb5nl5ijGK+w/ZLclPi/Yu+oBn/lcl9Dv6IYFzVmoC1slcdlid1ZvnAxXTit80ASF3RHsuKJQztlXPQJVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566571; c=relaxed/simple;
	bh=g78/J/miIPXOqYI2NML2fT0xSbuNUIq2sURBYKmxrnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skAskYv78b7M2hwosBDtwWl8r/SvkD+my56prz/pSNnSbdAfmlZGnonbJf5vVidZOsiUARrLuYSGY+2mbQ3GTCnp2QAg40dMfN2Yd7FIjKw76+scRn5KDRETiFw3cY2skltBg0p53PVvhWJKan7alp2eQrTWMppdaZySsD8/EPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPmWUme7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736566570; x=1768102570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g78/J/miIPXOqYI2NML2fT0xSbuNUIq2sURBYKmxrnU=;
  b=KPmWUme77r19O0Kmm92T9dEmQQQvH3HpG8Mf1gL5qPiP9S22IMcZIZJh
   5/7IAn9zof3b+Yt7ZBsC1HqwE7iYaJllL5wiBk1d/8PvTuwy6XucW+IbN
   uJpHlCmfsG4nbbGVgQfmDT785DaokSP5r2NSH+KA4iP9YCv4U3h5TzPcO
   GeKywrANcO1M+5yfEyq/ddkVieyteD0h0oXwLGJHUXt/ExInE304iHKH3
   ZgxxviPv8QeXGY5aFa1uEac1aHSICs2twB2yeDGsSEoAQVwq5MCAbY1nQ
   ayJqaUXsqi0znyfF8eA8TwoQP8EFltbqpDYUWI6vWSCdyF6geSQZ7zQql
   Q==;
X-CSE-ConnectionGUID: eP1MRCqZQGO8Nyr1n5CNMg==
X-CSE-MsgGUID: m0lBk2OJS6uY64MxyJSmBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="48238000"
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="48238000"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 19:36:09 -0800
X-CSE-ConnectionGUID: AqV9EqY7Q5a580ncqm9K5Q==
X-CSE-MsgGUID: CkCCl5ZMQ5u0JHOE3xpp6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104792621"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 19:36:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 19:36:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 19:36:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 19:36:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eufqVSvQRf8GH+3atm4X40PopC6FB0R4YMHozu5lrdpI+Cg/1Hv7y0GwFFNamFEW9aagpVKGMzlp9y2BxXbTvgtA2q9vwvPoVUbSqVuINLhV6TC5Jixn/w0UXlV9/+lfc7bF9gc0m7qWG+ia3Zgyp05ZTD/A5jldMgk1hYk2KEloAjrUGbjJVcg18hHA5+cacRaocJbFi84cR2QLDQXbGMWhy2T4SCz8PeHwYGeOmYGpWnQ27+jh29rCvALSZdbfYUUgIh2tPyN/SHKF9fkKUUvn/WXmf+H6NUuDuCXmRQqb4wVHQQ63ttJqYgWnyS9Wk+hlr1RiHdY0C5KSxUl+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBxqOSV+angmDHddWyjD5evPnVpLVNI0FqkRhDUNfQE=;
 b=p2rpCoJf6tYlTVt6/+ZfY57WIcS8DBC+DSqZbxHQKNwntw8CPU8XIY3iY4XNVFH3qEgu0yGdWCg2CLi4dAlQii7daNeOnY/KBTOy0Qh1Off06wB91Deu8zZe7f3izOoY3x7eJU365lIiHQ0T5wSuFaOHI6Vtvos281aMvRnt9Fn0zEGP5+VwZpbvbI+TWuX7me9RO68tZQJvzimY/n4Pc2B8NgAUogTLil0Hc1l8mdej7rZLrvhErmfbPyLW3sZlUXi3UVPEeNkQwBHx76BRUSw/UBmZmK/QPuBVb+fe5VNyTlAWnENOZ5YRtkNgSvCLhy1eqvGsF8rLUYTKTs6z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sat, 11 Jan
 2025 03:36:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Sat, 11 Jan 2025
 03:36:02 +0000
Date: Fri, 10 Jan 2025 19:35:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<alison.schofield@intel.com>, <lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 00/26] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <6781e71d986e7_2aff4294d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <6780c6d43d73e_2aff42943b@dwillia2-xfh.jf.intel.com.notmuch>
 <20250110173048.5565901e0fec24556325bd18@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110173048.5565901e0fec24556325bd18@linux-foundation.org>
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa2035f-9f24-4316-1e46-08dd31f11225
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3TqS+09SoFVO2UdbD4/Vj36oV6f2m4ZaRHDdiRw15u6fmpcgn3hQ7bq6TNcQ?=
 =?us-ascii?Q?saCJNXBpfebU6XUGJCh9+O4hwTKPuRgAab8RTqCy8Gt9g8xZ3+R6druqmlzf?=
 =?us-ascii?Q?EsuNjsfO9/OydkNB9gCOsz2it3VM/6rNEaO8lGvQMTPV4a557ARuZEXX6z2M?=
 =?us-ascii?Q?hYsZXqNk4Rdr8nZg0M/f03I5efDFQ7P1cxrqR0IwvLxvokLR/dyfa6PMe2gX?=
 =?us-ascii?Q?vSiFS1vd5HwLg0MtglBv9JGFCpZz3c3HKqah31Yzds/EC6297ilhGdxz1BCX?=
 =?us-ascii?Q?JuxGSFenaw3GZ+y4DRMFVHg3xDNgZW3EdPRrqWrpYzuVBbaQKDDd6Hq9oILs?=
 =?us-ascii?Q?g6DKz2d2EfzOYhvlXxFgSPsWtsUhWyCT5V/j44tOEZEqCoh3tRg5HArreFTZ?=
 =?us-ascii?Q?NyyEkmy5atlH1tHlibmE7dEcnqUvseBiqXFUL9/y0mgx4U1qzUcJmPYZHnZM?=
 =?us-ascii?Q?EaovN6Dds1ER59jiUsrXKtN+UDw4OXAufkA6lZ2QKOhfegwYcQOkhzUC3+Bp?=
 =?us-ascii?Q?BXXoB2YFuE8bmE3eiDJkbmx4GhfuU+evtfHPx6cGXQNisaAPYyUfX5Li7p3u?=
 =?us-ascii?Q?93IdDDKjvj3zk67uIckWY4ux+6mr8E2B9EHyl6Clper5Nh7yFuf7SUVWgPP+?=
 =?us-ascii?Q?9NVJw5KvDHSleEGn8HYkWexznDe7oV2sK3XLuw7kO5M80m9EofhbB4oCB3Sd?=
 =?us-ascii?Q?t5eVJpBP1n9fNI6btqnkVJbQ/0WPrAliZGJtzEoN05Zv3hk5fPcltDbn+YOh?=
 =?us-ascii?Q?jZ3NsV1IR4GNo6J4jgz4iu7wcPvWCCf7E3sOitHupcdWI0KoFRnu+ffWMifo?=
 =?us-ascii?Q?feDeunpb8P46n0aljuHN3xlgBEgGRMNwRAfsZNFWtcvuWjPQfDGSUgspeQx3?=
 =?us-ascii?Q?tzC/NfE23cdQDqgwDxIFq+LvRAsUwOrojRmeWc/GAebUfRAs6jR4NgeDlT+4?=
 =?us-ascii?Q?DVoLrozY66j6g+nPrVKpx5nFBRoQVGTtGk7XNEFfRAODeHa6ZJ3N9pKQ/0JY?=
 =?us-ascii?Q?F3bd1NhQubECyrO6X/T9r9TJto+yJW0nuZrJ25f9V2zg8YR3Mpd1R5ozNIvG?=
 =?us-ascii?Q?BLISe1n4J+aCd9PjRZbGDglv9ntxVtCQF0+PGGZnyvu9KrnPVuUQkaCeCqka?=
 =?us-ascii?Q?OP8ENAFHtHRxVGCq5Chla2zrBSIEKb9iy7H1o/LC9GB7zrJa0R6ycP9Ea3dz?=
 =?us-ascii?Q?AeDllfqouOweHv4jR1UFcsZpshL8jKjKKpEwsIKsYd873pcnVOu/krynr5rS?=
 =?us-ascii?Q?WqsVVEmOcGp6Te2rz86Ift7Y8NzFXWNs9Jpr7q0dalb3GtCL/1uKkqjW4zD8?=
 =?us-ascii?Q?iGZ9DnOurpT9ss8p4pktRz9WWb887m9DVxZZx9OXkliZkxkTbVCxAO+oXh+Q?=
 =?us-ascii?Q?vrROWcAz9L8S/cVi21xjdhMRhfc9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pXMMpM6JFHwZM+duYL4RDJBY31jSVtalKIJ7EPEEGpRpZDNQkJFh9jsx47qf?=
 =?us-ascii?Q?r5h2+8dlUIX/pDIAmAFYRzcPFiBr2EnBReeV9O0aHnpnKpnkMuwWbN3RfIns?=
 =?us-ascii?Q?VNdrA7IAhNtkbJWisO+aMunZRdqzyySL7Swe1q9wnDo+kt5rQlCiOpSpoKEg?=
 =?us-ascii?Q?4fCeW3TtlxOaFjsCMOr5JhY1A+mLn0AnMhMqeaPbRIWFGX1HU/I7c92s7GjB?=
 =?us-ascii?Q?DJ/0RoQk8tLjHK4IkmDWFqUpas5fi2D25SAQp5SRQIQZ4PMvdTgg/tfI9DHb?=
 =?us-ascii?Q?YMZyft6WYgXWjJO5UsMcO1ePUBsctWI5+D5mALOe7VKWH+0c34bq546PIXl3?=
 =?us-ascii?Q?/KG9NbEiKdT92EGqDxQffm6A1OcFgPl8F+nColnJnhO+IctbQQPFrmhecJ5n?=
 =?us-ascii?Q?xrZXwsnOvT5VurHyG+YwhaKVV+OEl6LztdTlVolnxJ42/EzPGCUHQSyddiBt?=
 =?us-ascii?Q?iIgTWJJp6nu1Th4ai52bVzcSsuSnZJuyF8F4rf6QZDNEGEy+Rx9kuXKeGuV1?=
 =?us-ascii?Q?uQENYpiV8mS7LR0l38kfvPXfuYSSNGDKPat0c846b4QwCz8dHM6iwe2pftHw?=
 =?us-ascii?Q?Pbgh6J4YDRBShqd+jZA11LrMGDVKvOh7dkRWI8WKFqKmr+eeebU0sldMi4Ln?=
 =?us-ascii?Q?3hcPMwWYV+PCv6qKTXCMXfDIrDfIpFdRM9nW598zjO4nF5QsrZd1c3lZs4Xl?=
 =?us-ascii?Q?MpYO4WSwXlAw3fCYkwz7uWySU3pfirAfGrhhUKNIJ8R1THxb6rRaJojiz+dY?=
 =?us-ascii?Q?jP0PlRCOqFJPqPESy8Nh5rOQQrqb+BSuhru4iE57IDfDX2dmSml2KeEu9hqN?=
 =?us-ascii?Q?hiz7YcoUD1GliuOHGOr7JUMA8157bwKkiTGWGrwq7qNlN2P6U0Quy8xa9VZV?=
 =?us-ascii?Q?KqrrrmovNucFWr7RF3qWILAm5vtNwOLeXW6GanL+9TDcbijIsH8wEfpa2vUm?=
 =?us-ascii?Q?vW+fVgGFCzxiKizXBCO/A7Hh/9/c/qdYyMC0Z86UuiWXDZQrLywEFUkNMJnn?=
 =?us-ascii?Q?p1mqAGSf2/rO/KXgGOaiqGeFuQQDalWFaZrP8Zu7W4bSzLNyotsK3DA07Gn7?=
 =?us-ascii?Q?kt2BkCsK7v8gdxtKStKLYVz3WAdtoZh3h6uW7SxqNoc7wojpLKkVXSTUQkFT?=
 =?us-ascii?Q?5XYZaCUKmUuvTYlNlknfPb+FywXGl8Bzs5bjL/87CxM0rAY38KgvgYn/AqOI?=
 =?us-ascii?Q?+cY95tCMJfUGPLKz8WjAj97ThCh1C2Zkxz6/O/H2pjSho6oBQu1cd6MFAy3u?=
 =?us-ascii?Q?/3cRDJbY1NpWAY+4sD5H1XYmHdWS2uk8hEVANNrn7f3WpV4R2ADz8zkBz+ZX?=
 =?us-ascii?Q?4lSzQpGFdsbkGXUG23hDXhZMmKz/3eAmrsdb+m7cvZmh4SNWw0i/gfc3ZHyz?=
 =?us-ascii?Q?el23RynurIqiK1mj911Fco0l6wNK9vAnNEh3m/421+ZPwpihtq3D4o7V0a8a?=
 =?us-ascii?Q?T4+sdFl3JqGHMRSsjqJhQvXaA3Qbv+3DOrogsE9NOdjRtRv451nXHjXlCMZy?=
 =?us-ascii?Q?zQ+wo6C85lT8V4mVh2RJtHafNsODddvhCYjFOjbp54Q+51TgGozt0qlVb4fo?=
 =?us-ascii?Q?O+7+QSbapEkDrM6Eta0T+Hc1CIg+zFLIVjolHGX2k+qjSUpJVgqDa5YaKW7F?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2035f-9f24-4316-1e46-08dd31f11225
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:36:01.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOVI/IuVKYf/ZnHOp3U3snRB4yShCCHafnjTGuO4CI2egWj9RaEZKbzSLjyiFLAKebqSe8bXpwEwc2OzUjhDpDgcsLcximEGcI0MPvmi/HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com

Andrew Morton wrote:
> On Thu, 9 Jan 2025 23:05:56 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > >  - Remove PTE_DEVMAP definitions from Loongarch which were added since
> > >    this series was initially written.
> > [..]
> > > 
> > > base-commit: e25c8d66f6786300b680866c0e0139981273feba
> > 
> > If this is going to go through nvdimm.git I will need it against a
> > mainline tag baseline. Linus will want to see the merge conflicts.
> > 
> > Otherwise if that merge commit is too messy, or you would rather not
> > rebase, then it either needs to go one of two options:
> > 
> > - Andrew's tree which is the only tree I know of that can carry
> >   patches relative to linux-next.
> 
> I used to be able to do that but haven't got around to setting up such
> a thing with mm.git.  This is the first time the need has arisen,
> really.

Oh, good to know.

> 
> > - Wait for v6.14-rc1 
> 
> I'm thinking so.  Darrick's review comments indicate that we'll be seeing a v7.
> 
> > and get this into nvdimm.git early in the cycle
> >   when the conflict storm will be low.
> 
> erk.  This patchset hits mm/ a lot, and nvdimm hardly at all.  Is it
> not practical to carry this in mm.git?

I'm totally fine with it going through mm.git. nvdimm.git is just the
historical path for touches to fs/dax.c, and git blame points mostly to
me for the issues Alistair is fixing. I am happy to review and ack and
watch this go through mm.git.

