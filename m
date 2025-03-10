Return-Path: <linux-fsdevel+bounces-43609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C8A5981D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991891889E4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8222A1E4;
	Mon, 10 Mar 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwN9sklt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDC1991CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618246; cv=fail; b=G+GgRUFoH1cW05BbMl4oPYt3VaMJrjA2Duvf9/Ov63p0MiE7tgqUBhuKCzdD7JBT/jYYcCEK981si6+GzSDpZaeXBVZsfYyDXRD3Vk9XHqe4GMhHCciXy0QzHQxKI40KHmH1EtNTfEDlIjfOom+RghNkJo5tVvWL8IdBhyrc2ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618246; c=relaxed/simple;
	bh=FZl7GQ2M7nQuz0w9Cv6PFHY8aXwrBH5wbeBCTmDHrtk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pQb0BbSvs+KccVmG1KKIrD1qAVUef4hTyRdhFs5KjzKeaUQDej0sZZRzLOrvgZzZaiy45hEsaDYS78ZJpEb/JZ/DwgiIeNwoU4Y8bKDE4dziQ+1TdgjnLMwev3YW7xtOkI14tNQn1fJIOzGM1g6wzPyO3OYBEtdU+Z3VCbnMUD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwN9sklt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741618244; x=1773154244;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FZl7GQ2M7nQuz0w9Cv6PFHY8aXwrBH5wbeBCTmDHrtk=;
  b=NwN9skltYKDaGK8G95FOe8f2TD8QqdFBkaRynIk0RQFOXw6OfKDrRt1l
   DCcJpAPa4mLiBJOzog4cyuV36VH1VdlE/o2dXYU11rSaFpKmLqhT/TXX0
   GwYybNqwVBSVaQoQBjKS+VnD35URzpIEySnHBQV19qeF9gD/PbU4GvOXC
   Y2HgvNNOzvRiXM0JpNbJEixq8tFZz8abHnB7RPF3loK0K6jZaepAP53QX
   BMQmzFPx+ndFnKDOG69JrWgvsKC6+k72PLVgk7wMJ/Z0z7mx6eIb6ZgNV
   Avycty1afSlMAHhfNbWVAcJ/X3GLuWQ5r+kDdbcuXJTjug1X6MAyrnaQm
   g==;
X-CSE-ConnectionGUID: Cjbys1xkSC6z1IG7swyIsQ==
X-CSE-MsgGUID: ITSyoyqXRDKvWdWa3jJUwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42525615"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42525615"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:50:43 -0700
X-CSE-ConnectionGUID: z4lbvkIzTlWu+NUInE02sg==
X-CSE-MsgGUID: 23C0+uXtRXqw40Oj1PKLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119952524"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:50:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 07:50:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 07:50:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 07:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsmS7RWmw27QbqRzu7rsye3CXkyihXKM4pj411RfUolOQcNfeQi9YF3kI7wmFj5hW8b8eEC/4vYOl0bhc+3yBSoYAiWccpp1UU2QaoHrPCtgFNWS9MwRS5j1ln/zw25Y5VNv0r1MyMSXWf4hNEVhri5e7EudRB258upS+bmsn2kEHpLlL+QAs1URR4GlCEuq4H/EyO5NFwGhVlJvkoFwaJ4D7OfkooRHD+u/Y596hIXCCWW2Ug5cF+u2L9rbFLHNY4wsZ5uUVEWuVsnsYZFS1VJXmXVrwBTDaBIk7IJxXlHESJLqXOmg3Fg+xCwbTRjm8Q//2VzWyWyIi9GIveeMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9zj+3LvO6hQQJuJz9cO34RY5v6hCbi9sSlyxTjMp8Q=;
 b=kyHrAElAaMFRvIpghUTsjG9IccteHK2NHn3IU6t/6HOa/kuNY+uX4cLeAQ3LpAqTsu3UMse5ZbmQumb6LaegBPsSrjFuOc3/oiiASunB7FVQ8M0dGsw6RCYWvj2bkiNRSzQoFGFEHX9lL65MDDhCD8eC45BjiFSKa7K8Y67pSq3SogqvqBqF5I3xDvvUl4qe3QYmvsb08XErZr6erI5vFtfJAFnS48Sn6cV0BYiyWsf4s4/8o0Qu/o72vZwxPSzSv2GnULys2ynfq8FOGCA5iFGu8T0+yYevaa9D8gzUj7wO/C8DePRnquig0Y1ikZ89kQkMlWiIT5OjRoLoW4DP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:50:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:50:09 +0000
Date: Mon, 10 Mar 2025 22:49:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alistair Popple <apopple@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, David Hildenbrand
	<david@redhat.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Asahi Lina
	<lina@asahilina.net>, Balbir Singh <balbirs@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	Chunyan Zhang <zhang.lyra@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, "Ira Weiny" <ira.weiny@intel.com>, Jan
 Kara <jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, linmiaohe
	<linmiaohe@huawei.com>, Logan Gunthorpe <logang@deltatee.com>, Matthew Wilcow
	<willy@infradead.org>, "Michael Camp Drill Sergeant Ellerman"
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Peter Xu
	<peterx@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o
	<tytso@mit.edu>, Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui
	<kernel@xen0n.name>, Will Deacon <will@kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs/dax]  9e9148ba90:
 WARNING:at_fs/dax.c:#dax_folio_put
Message-ID: <202503102229.122fbd6c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KU1PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:802:18::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 53190e17-6cd8-4851-af1b-08dd5fe2dacf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?54dbjKDriADfOK1V/u96JWDPB9bXVPGH0sshlmMIuwM+Cnw2kUOZcEnIW4kv?=
 =?us-ascii?Q?q0y2ipTDkofFi0058ZIZcy33H1+HlVzGadk7ff6fJF4WJkoLPsbN0/5foPyl?=
 =?us-ascii?Q?SUZkVDt44kIMudK1HSPSa2Z06GOf6WjUHwiU8uVatzDReT+/kX9pwaCdOjXz?=
 =?us-ascii?Q?PHixahSyZ9Dzz3m+ELrFmGqcf9OcdSDgFjM9uhYmk6RuIKZlNJX9emz9V/5q?=
 =?us-ascii?Q?MPEsnKziRNXyyTfE4Kaxpt3k/zpY+jiBeDcDqLTCNi9HOpbN10qUGti4/hwf?=
 =?us-ascii?Q?Q+Ff9Ivgh42bTk+peErRnbhLBo7/nN082eh8HMWFzsr8WjYC7WdGlQoznaBp?=
 =?us-ascii?Q?srM0Kb4Sno6suBp4X9eN8EGv4c+SswL4d6RdVDXF5GMBNiMdVuiIPVVjWdq0?=
 =?us-ascii?Q?rGJBamiCDG/68yOIuzzBN31l15MvqDYOsQyQdRUJLD8XFOtm3Et1DUvhksMQ?=
 =?us-ascii?Q?iJKN4HVWCHj1wHWXCGJxMKW0H/AlNsTooiMtxeXRysdcb566ozE25IVWirUW?=
 =?us-ascii?Q?S8njtqHR/7ZymehECZeqmgz9JQb9yfKmKp7/VUgKONw2APZFyPtM8lKdQIQf?=
 =?us-ascii?Q?XUXdRUjpTcj78pnZzi9Pf0SD58RnqxH9HKTJMSw5wztvP3/eLLTOaVNomRgn?=
 =?us-ascii?Q?zzDqXPwnp3OwgoMxwKxxAExqgT1zCHHE8IRNdI+QEnV9kQ5LKuW4TLdAM540?=
 =?us-ascii?Q?jMVYwDDpNI6Dqk2mMFbZUbljUbqEHtDiwtNY33COJHD1CoiXVx5nLHZWHzEY?=
 =?us-ascii?Q?cgnm3Abffv8lBCCPf5sovZ+kpjxrRBVvkLRuymjyIDMXZcuoH9a68tBktlW3?=
 =?us-ascii?Q?8rWgCCqkRrl3rNPhXt0TPAGl7H2groEY5WZIHOZ4zv0mPlvwHyZKawSc5uUE?=
 =?us-ascii?Q?5NXX3BfCEN4FoRoHJCsJdlUb6lOYg1BMYlVhD93jYNOxjFj+E2j/O3CroCAD?=
 =?us-ascii?Q?3jpc4N+d0yFdMOJ8gGSTeiVok/+OE/MeaD9mgxBRddUuZnaZ6Ab5ARm4tQVO?=
 =?us-ascii?Q?+BtI8PZjaRdgsFt9Ygwqh0bsuf8YbVXZR6Z0erMUe8/8ZDYQwD1L54aKSTvl?=
 =?us-ascii?Q?/2SJGlUfN1lMALiNxZSl8Mx9idX/2R+JrMJNtaOIbEB/W69PCqK764RsiPaJ?=
 =?us-ascii?Q?1QtNvjjiU13oQTgYt9EJCrBVmZDDVgLWofMbPn44P6l4nq8Mu6bAujNbdB2g?=
 =?us-ascii?Q?agPxsGNGO7Gg2IEdZKBAxbR9/A8q/9dWzzLjk5Bo7IvyOhc7EeRPZgClW3xS?=
 =?us-ascii?Q?lFRZL5gap8TJ+l5dxxtwOKJV6/jvf0/7HRdkkKsaW3LQ5oUhTipeh2I7nDAh?=
 =?us-ascii?Q?jUynykQNFa/yEl80enO+Mamf9VDILoeLWxSWqheTazlJZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dIuJVyIWBshn9YHlCIE0+eq2EluOrW+FMhupTh+P4f9vKj5xkwUJwM5mFwCJ?=
 =?us-ascii?Q?kIdmp0WWBu3pyqbpCn+OXK8/70mvGz8g/b7eqtOg2VNaHM5qy5EvHNcrW8rc?=
 =?us-ascii?Q?Lw/dRFFOzR7Ws3yu8HiX24SGPtSmVfBOvG1wCyi3hlL+B8CoN13kSyFhdqrF?=
 =?us-ascii?Q?onY3FdHj50RiBjKjB5wtYSrZkjAhJ1PWgmWTBzlansZRDgKBsq23jzPqFj19?=
 =?us-ascii?Q?TMrGfspfwGTWPH+9k3oUZe2ccO+oixweRyjBQXBSu48a2rNKfyrJdkxq0453?=
 =?us-ascii?Q?Zc+nVIH1qcnDgwWhTYUY1MD9iOStQqT6KxtG4jH1VT14EizbEhqKlGLbtlX5?=
 =?us-ascii?Q?RLvLyyl03bC5RdeNcwhYnySbDBosvebhOZoXrC8gQzSXz29an8Rr5iC1c10L?=
 =?us-ascii?Q?1972uAwWZAiYuIHoqzmPOtXlTEL1TB4KlpAf5CmdO66O6PNZndAJUiqbN3vu?=
 =?us-ascii?Q?BHoxSHcrRPLx832x7a184oEsUSzsfsLhMUUCp7kK20lhEiiNd4IHxvAejtSK?=
 =?us-ascii?Q?ryzaNBuX1uH0VRolxH1QbBlVustHUUyHKJvmIz1sd+LIBfVuiGyzfwQciWgl?=
 =?us-ascii?Q?Xs/7RIY8sgASKlCwC5yUD/kJv9rnPJUdlzkPG2/leIuu2p7pqG7+WyY3GE+Q?=
 =?us-ascii?Q?yxPd1rFCEExlhzEaDigPlAFS8JJbZ6HQx2ntNOlA7RILv/mOT/eTQH+d67LX?=
 =?us-ascii?Q?zbYgbsSi2PUoNUSVYhEyjEpaLsT5o7yNE+Fj/8RFoOvBwghcE73aJNJqFJd6?=
 =?us-ascii?Q?D9eE9TvfQ98RWQUMSfQ8ZCG5VR6Ss0HcrNGQAvEMlWVqFt3bZFhZM6wcmiRB?=
 =?us-ascii?Q?NUiQcJrNWdq+yh4iZOpjbQwnK2/8bMxbI996PptLNhQzNDgO/GVNjy5SYzFu?=
 =?us-ascii?Q?U+0/Fc8H14rvVT5FiqHorQ7msW48d272sin0SfuYWySXrnR6P4zfHRzd90vU?=
 =?us-ascii?Q?lghTieInxKc1uBl1fU40+DCk9idg6/P/edYzkBzSF7Y0qDyy5DvsjbBAsCJL?=
 =?us-ascii?Q?ykqeCRVLF/Xo8WuOG5p+wqUf9uKQB9LbuqdR7Mg11zA1xKFcMgzun1VrUE7w?=
 =?us-ascii?Q?VHZoMlo4V9+PG9FzWc6szUvGQikqrh4FgSyobuxgx+yAekQjER+74ueszDPl?=
 =?us-ascii?Q?FZddzV/3MqrGFqOcEQo5zHTy1Es2bG9TBSLmuu5/jEDhbCIXBi6fbNvvJjfk?=
 =?us-ascii?Q?A6dPg2s2E75DIShpTR2s8m+l4F1ULpcvxnFuV3yiyRf+NwsNlRUxPlXh/xN7?=
 =?us-ascii?Q?j3j/j2dsiP0gpgGtiyIm8tfllXgKLlGhwe2IO4ZhLiwDNweWLp3plKZepnG/?=
 =?us-ascii?Q?BBBjZfhf9CkuxgfNx6557Oupy/8wehtkvd0LfyMv8XXnep7FN5o4NKAJ/CAy?=
 =?us-ascii?Q?0vZqHfHyLuplyb5yQ7cAcg9/uK1XwZhEBdwmZjjcPikTG50T6/FPFLYuOOgT?=
 =?us-ascii?Q?nNWvfNwlNOQJbUyPOD+036PP9wfUvALe3utQM430Q2YzUeDZQpiHRv036uXo?=
 =?us-ascii?Q?61lb0bnskOe5261FZPo+CmV8MlPwSz/JOjo2D03OBUAABPOc87uGMQV7MN2C?=
 =?us-ascii?Q?cdrUU30HwrJ4bznJZs+AaCywvH2MbpEGCkpFUWvYO6MVOaaE1MfA8Y2nDmmB?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53190e17-6cd8-4851-af1b-08dd5fe2dacf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:50:09.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIm/7mZmHbO53XPn40NhUnN18Rzcf6cOc5YAii5EeWJIMdwxWHuRR60msgmDsZ5IkDbU1mEn3F1e+Z93UiZJmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/dax.c:#dax_folio_put" on:

commit: 9e9148ba90757a1db81472371f582de2b936b0d6 ("fs/dax: properly refcoun=
t fs dax pages")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0a2f889128969dab41861b6e40111aa03dc57014]

in testcase: nvml
version: nvml-x86_64-c0abd814f-1_20240621
with following parameters:

	test: pmem
	group: ctl
	nr_pmem: 1
	fs: ext4
	mount_option: dax
	bp_memmap: 32G!4G



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00G=
Hz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503102229.122fbd6c-lkp@intel.co=
m


kern  :warn  : [  148.701197] ------------[ cut here ]------------
kern :warn : [  148.702568] WARNING: CPU: 1 PID: 42454 at fs/dax.c:415 dax_=
folio_put+0x288/0x390=20
kern  :warn  : [  148.704151] Modules linked in: intel_rapl_msr intel_rapl_=
common intel_uncore_frequency intel_uncore_frequency_common skx_edac_common=
 nfit x86_pkg_temp_thermal intel_powerclamp coretemp snd_soc_avs snd_soc_hd=
a_codec snd_hda_codec_realtek snd_hda_ext_core snd_soc_core snd_hda_codec_g=
eneric amdgpu kvm_intel snd_compress snd_hda_scodec_component snd_hda_codec=
_hdmi btrfs kvm amdxcp blake2b_generic gpu_sched xor drm_panel_backlight_qu=
irks zstd_compress cec drm_buddy drm_ttm_helper snd_hda_intel ttm snd_intel=
_dspcfg ghash_clmulni_intel snd_intel_sdw_acpi drm_exec snd_hda_codec raid6=
_pq sha512_ssse3 drm_suballoc_helper sd_mod sha256_ssse3 drm_display_helper=
 sha1_ssse3 sg snd_hda_core rapl intel_cstate nd_pmem snd_hwdep drm_client_=
lib drm_kms_helper snd_pcm nd_btt ahci dax_pmem mei_me nvme libahci snd_tim=
er ipmi_devintf nd_e820 ipmi_msghandler libata libnvdimm intel_uncore nvme_=
core snd ioatdma video mei i2c_i801 wdat_wdt pcspkr wmi_bmof mxm_wmi intel_=
wmi_thunderbolt i2c_smbus soundcore dca wmi binfmt_misc drm fuse dm_mod loo=
p
kern  :warn  : [  148.704342]  ip_tables
kern  :warn  : [  148.721353] CPU: 1 UID: 0 PID: 42454 Comm: ctl_prefault N=
ot tainted 6.14.0-rc3-00230-g9e9148ba9075 #1
kern  :warn  : [  148.723223] Hardware name: Gigabyte Technology Co., Ltd. =
X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern :warn : [  148.725158] RIP: dax_folio_put+0x288/0x390=20
kern :warn : [ 148.726771] Code: 7e 48 48 89 f9 48 c1 e9 03 80 3c 01 00 0f =
85 e4 00 00 00 49 8b 6e 48 40 f6 c5 01 0f 84 7f fe ff ff 48 83 ed 01 e9 79 =
fe ff ff <0f> 0b e9 43 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7e 20 4=
8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	7e 48                	jle    0x4a
   2:	48 89 f9             	mov    %rdi,%rcx
   5:	48 c1 e9 03          	shr    $0x3,%rcx
   9:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   d:	0f 85 e4 00 00 00    	jne    0xf7
  13:	49 8b 6e 48          	mov    0x48(%r14),%rbp
  17:	40 f6 c5 01          	test   $0x1,%bpl
  1b:	0f 84 7f fe ff ff    	je     0xfffffffffffffea0
  21:	48 83 ed 01          	sub    $0x1,%rbp
  25:	e9 79 fe ff ff       	jmp    0xfffffffffffffea3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 43 ff ff ff       	jmp    0xffffffffffffff74
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df=20
  3b:	49 8d 7e 20          	lea    0x20(%r14),%rdi
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 43 ff ff ff       	jmp    0xffffffffffffff4a
   7:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   e:	fc ff df=20
  11:	49 8d 7e 20          	lea    0x20(%r14),%rdi
  15:	48                   	rex.W
kern  :warn  : [  148.730733] RSP: 0000:ffffc9002aeff7b8 EFLAGS: 00010002
kern  :warn  : [  148.732384] RAX: 0000000000000001 RBX: 0000000000000000 R=
CX: 0000000000000000
kern  :warn  : [  148.734315] RDX: fffff94005c04007 RSI: 0000000000000004 R=
DI: ffffea002e020034
kern  :warn  : [  148.736117] RBP: ffffea002e020034 R08: 0000000000000000 R=
09: fffff94005c04006
kern  :warn  : [  148.738003] R10: ffffea002e020037 R11: ffffc9002aeffac8 R=
12: 0000000000000000
kern  :warn  : [  148.739805] R13: ffffea002e020000 R14: ffffea002e020000 R=
15: dffffc0000000000
kern  :warn  : [  148.741650] FS:  00007f45f6590200(0000) GS:ffff889fc1c800=
00(0000) knlGS:0000000000000000
kern  :warn  : [  148.743525] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
kern  :warn  : [  148.745226] CR2: 00007f45f5a00000 CR3: 0000000c0b1c4004 C=
R4: 00000000003726f0
kern  :warn  : [  148.747051] DR0: 0000000000000000 DR1: 0000000000000000 D=
R2: 0000000000000000
kern  :warn  : [  148.748840] DR3: 0000000000000000 DR6: 00000000fffe0ff0 D=
R7: 0000000000000400
kern  :warn  : [  148.750714] Call Trace:
kern  :warn  : [  148.752118]  <TASK>
kern :warn : [  148.753608] ? __warn (kernel/panic.c:748)=20
kern :warn : [  148.755149] ? dax_folio_put+0x288/0x390=20
kern :warn : [  148.756894] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
kern :warn : [  148.758502] ? handle_bug (arch/x86/kernel/traps.c:285)=20
kern :warn : [  148.759986] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (=
discriminator 1))=20
kern :warn : [  148.761556] ? asm_exc_invalid_op (arch/x86/include/asm/idte=
ntry.h:574)=20
kern :warn : [  148.763137] ? dax_folio_put+0x288/0x390=20
kern :warn : [  148.764686] ? dax_folio_put+0x1a5/0x390=20
kern :warn : [  148.766315] dax_insert_entry (fs/dax.c:1077)=20
kern :warn : [  148.767757] ? __pfx_dax_insert_entry (fs/dax.c:1051)=20
kern :warn : [  148.769250] ? dax_iomap_direct_access (fs/dax.c:1279)=20
kern :warn : [  148.770756] dax_fault_iter (fs/dax.c:1871)=20
kern :warn : [  148.772160] ? __pfx_dax_fault_iter (fs/dax.c:1839)=20
kern :warn : [  148.773714] ? iomap_iter (fs/iomap/iter.c:90)=20
kern :warn : [  148.775069] dax_iomap_pmd_fault (fs/dax.c:2067)=20
kern :warn : [  148.776430] ? __pfx_dax_iomap_pmd_fault (fs/dax.c:2006)=20
kern :warn : [  148.777894] ? mmap_region (arch/x86/include/asm/atomic.h:60=
 include/linux/atomic/atomic-arch-fallback.h:1210 include/linux/atomic/atom=
ic-instrumented.h:593 include/linux/fs.h:612 mm/vma.c:2557)=20
kern :warn : [  148.779177] ? jbd2__journal_start (fs/jbd2/transaction.c:50=
5)=20
kern :warn : [  148.780522] ext4_dax_huge_fault (fs/ext4/file.c:766)=20
kern :warn : [  148.781904] ? __pfx_ext4_dax_huge_fault (fs/ext4/file.c:722=
)=20
kern :warn : [  148.783187] ? __pfx_pmd_write (mm/gup.c:223)=20
kern :warn : [  148.784361] __handle_mm_fault (mm/memory.c:5826 mm/memory.c=
:6075)=20
kern :warn : [  148.785585] ? __pfx___handle_mm_fault (mm/memory.c:5994)=20
kern :warn : [  148.786791] handle_mm_fault (mm/memory.c:6254)=20
kern :warn : [  148.787909] do_user_addr_fault (arch/x86/mm/fault.c:1338)=20
kern :warn : [  148.789053] exc_page_fault (arch/x86/include/asm/irqflags.h=
:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488 arch/x86/mm=
/fault.c:1538)=20
kern :warn : [  148.790173] asm_exc_page_fault (arch/x86/include/asm/idtent=
ry.h:574)=20
kern  :warn  : [  148.791294] RIP: 0033:0x7f45f6f59b4f
kern :warn : [ 148.792300] Code: 45 f0 48 8b 45 f0 48 8b 4d f8 48 03 41 18 =
48 89 45 e8 48 8b 45 f0 48 3b 45 e8 0f 83 97 00 00 00 48 8b 45 f0 8a 08 48 =
8b 45 f0 <88> 08 48 8d 05 48 8d 05 00 8b 00 48 83 f8 00 0f 84 57 00 00 00 4=
8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	45                   	rex.RB
   1:	f0 48 8b 45 f0       	lock mov -0x10(%rbp),%rax
   6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   a:	48 03 41 18          	add    0x18(%rcx),%rax
   e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  16:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
  1a:	0f 83 97 00 00 00    	jae    0xb7
  20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  24:	8a 08                	mov    (%rax),%cl
  26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2a:*	88 08                	mov    %cl,(%rax)		<-- trapping instruction
  2c:	48 8d 05 48 8d 05 00 	lea    0x58d48(%rip),%rax        # 0x58d7b
  33:	8b 00                	mov    (%rax),%eax
  35:	48 83 f8 00          	cmp    $0x0,%rax
  39:	0f 84 57 00 00 00    	je     0x96
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	88 08                	mov    %cl,(%rax)
   2:	48 8d 05 48 8d 05 00 	lea    0x58d48(%rip),%rax        # 0x58d51
   9:	8b 00                	mov    (%rax),%eax
   b:	48 83 f8 00          	cmp    $0x0,%rax
   f:	0f 84 57 00 00 00    	je     0x6c
  15:	48                   	rex.W
kern  :warn  : [  148.795265] RSP: 002b:00007fff424b56a0 EFLAGS: 00010287
kern  :warn  : [  148.796428] RAX: 00007f45f5a00000 RBX: 0000000000200000 R=
CX: 000055a297c07600
kern  :warn  : [  148.797827] RDX: 0000000000000000 RSI: 000055a297c16360 R=
DI: 000055a297c076e0
kern  :warn  : [  148.799163] RBP: 00007fff424b56a0 R08: 0000000000000000 R=
09: 0000000000000073
kern  :warn  : [  148.800486] R10: 0000000000000000 R11: 0000000000000202 R=
12: 00007fff424b65b5
kern  :warn  : [  148.801886] R13: 00007fff424b5ce0 R14: 0000000000800000 R=
15: 0000000000800000
kern  :warn  : [  148.803216]  </TASK>
kern  :warn  : [  148.804116] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503102229.122fbd6c-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


