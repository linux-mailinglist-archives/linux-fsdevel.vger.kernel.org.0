Return-Path: <linux-fsdevel+bounces-72264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441ECEB534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79A6F300D40E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349A3101DA;
	Wed, 31 Dec 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkpVMKxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5A2C0294;
	Wed, 31 Dec 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161266; cv=fail; b=dmF1gFnNefpAiXEQGO2D+sSUQgkSrdIWRMmv7Cm9RByF55MLGC2qY6C8QZo5kIrr2ztPPJ+DKAvQYIsxLOWEYHvomlnw6Vm34GQVB6jk9lqyTvU+wEOMDnQRL5oYSScwXiumAbvFD4PfJWIRViSbl3NpHoyQeZ5kqZScBZU0O0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161266; c=relaxed/simple;
	bh=Ib4Rfc6MhJkhZKnSxyddkOmHxJMj70LO5oaN+HIOX9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWcMujzG5QaDCWA+sF4vCE4dBv/geIeAJBmMVMUZjO7WlLXjycOvHUfaQVeC/NbVlBA+RjhaNCd3+Uj8pT/Ri9kGqHci5eOFwXSrcDsvM9CFaA+n3XU5Sf8v8nNSUluFqpZvQ5Nni4mvFuj535Yif3sKDNu2/jy0DmTGR0f7qQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkpVMKxZ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767161265; x=1798697265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ib4Rfc6MhJkhZKnSxyddkOmHxJMj70LO5oaN+HIOX9I=;
  b=CkpVMKxZdiJPz9uzwJ/s5fTSobGaNriXXAzAvA/A2ANxSFPe/SQlKNZ9
   dBPF9MT6h0HGHNvJQGVxt3MLwyp07X+rKxJad1BuYvo4bPoZYSLc9xEdz
   cly7h6GDfJs+BnmUrpJdCtn/qFUagSCnh7mtqcae8lV0QTNKO7kevHy+C
   2+jFNjx7Clt8Rm3twr72viXUlxl5d3/X7BsHZ3/AMiaXY8U/NXnvnKO1w
   umEqge63/gt4HLudwnJDeLmh1GQEA77TM6gxCFt7+GzAvaxd3L0eDUHpo
   brIqM4zny4ZCrNUmNN98l1lZhu8Tt0ASjsihMkHhc3e+Xj8LS+oHzjtS7
   g==;
X-CSE-ConnectionGUID: enTp6PxNQEGLPSxFWP4Hkg==
X-CSE-MsgGUID: Ep0IX38vQ4ewpCiagwKOMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="79462664"
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="79462664"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 22:07:44 -0800
X-CSE-ConnectionGUID: zwSwtLdjRlKwPksphq7VEw==
X-CSE-MsgGUID: JYe5CwDMS96cg8bqg9qrqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="205855793"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 22:07:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 30 Dec 2025 22:07:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 30 Dec 2025 22:07:43 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 30 Dec 2025 22:07:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpfuiHbbT+d8HfV36w9Iwbul0Jfjs4rmPCC3B1kHNKKiDdqsJmej/4AHGITaYKd58joSL6yMocBVMMqxekfW84VLnWwc3ysm9/UzGFg7QSdw4cTW+uDoqtJliPMGIc0vwHTTyEikzi4yehM2kKGvw6Yjls2q9bsIRcYT9ntjtFxeCCkj8/wr37H87X4ORu2hpsAFVsJ6MQipfGsVQUzlgowDX1RT28A+dWa7RDyups9bzlMEOMwr5nvkkeuOjjhUYQ6hXzkY9eoNLWK4PKootvGF3jOoC9kh7xE8y9uff4znjjfSfPlMk8FCGeOvQCTUzkireiPxpslT7sBC6aXknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQTxjolhX7DA+N6N9uEh+HLRQXh8SOnD06jy2Rg3ce4=;
 b=nAaZNrdznRQkzdzEVEoUbb2qz3g+Os+IabhwE/51s9zcbkZ5A0pTq94t1rsBiN4oy76tjXXR1hyLp7cJP6J1LEVzDeOPF2VUfQdriU+gD5F3lh0my0H7VYEw4rl2etGqidhVwFkElp5j/JNRYL9UkuUSXp8bhHSP7xH8ZBPaMV6N0M+MAreax59c3xfZU5/Q1mrxSL1LeDGIzfqtt2tFuNMHsEMhckyCFQDfjSV0Iq6PUnMW65DyRG38SUK/HBJmj2HZdn7KAMEN+bYJMNn7vz1Ecbh55O3KesZO4kRv6OqKKOHgfetgtT1EarAoBCrYzN4tSRkDsdKKT4VzSjgvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 06:07:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 06:07:39 +0000
Date: Wed, 31 Dec 2025 14:07:29 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Eric Sandeen <sandeen@redhat.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	"David Howells" <dhowells@redhat.com>, <lkp@intel.com>,
	<oe-lkp@lists.linux.dev>, Alexander Viro <aviro@redhat.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH RFC] fs: cache-align lock_class_keys in struct
 file_system_type
Message-ID: <aVS9obo0ufC70yJR@xsang-OptiPlex-9020>
References: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ed7630-dc46-49d4-66fd-08de4832e70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Fe17kkr0dRAczCCAcQmFa5g/bZ+rDzFIegp+dI18i3fnxxBj2pMDkAvqRLT?=
 =?us-ascii?Q?4X1pY9AXn5mf2XNccRIhRfIF6RETEJqhDXWsWYNqvu0fYr8ZHaKzA9/fmHBA?=
 =?us-ascii?Q?cTuiSSyYREPDEpZ47Z1avZ+Q4lp4VtUhBWB0vZE6MDoDojDvvtPvv3YkVM9J?=
 =?us-ascii?Q?kHifnCRISAINKp/E2GcRrAaLn1oL1BoJfENpB1JQ1Q6a+iwTBF2NmtcZ3+GL?=
 =?us-ascii?Q?URtnYQOfdivJLO442IziBClTrYqWWdXB/jkZpbjTc1AYOyApwohTuC+lAnps?=
 =?us-ascii?Q?ctJxuA3jT8Qn8inKYc7/SoT5qzIyD9DySjNmUTIndqjqzo8X+mgAJnE5ppeQ?=
 =?us-ascii?Q?1HHvCRDtudcEsnbxR1DSwykyFvdiwd7iZIOBW/e8luSLA9f4StdHfTaHYAnO?=
 =?us-ascii?Q?IFBZUM8vEQW9yNz18fQ8K/EqXcX/dcdG4P+EAvyCQDNJB5Sa842cn8v4qC7Q?=
 =?us-ascii?Q?XfW8/B4inq15eQGMfkt/kqGgTyMqfe0aKWhgOcvTlUn/AFX4Aqi+vfsZ7+wG?=
 =?us-ascii?Q?Lto4QB9acBUs0qOzzHZ1etxFyEqtIJPF5Lw12BILXARVnkah5iSnEmsnKgw7?=
 =?us-ascii?Q?XszEpSMZP63Su8nEHBxQx9pD53BT6W/SmbAqHTvSh3pX2rVrNWAyClqIhDIW?=
 =?us-ascii?Q?m/R6o9hKMJ6RdxCDKqGdzery1MFDgRcJyLf5dd9BOk7xeVGixVXrD5boRkG9?=
 =?us-ascii?Q?zzN6qiUZ3HuDrSXKJEK51ueuiYOOSMut5TuafSdYy8B6sNmXdRSkmW079qob?=
 =?us-ascii?Q?W7Oq6Bg84H81Uh25spo90Dq3DixtVdkoBNlfJ/0gu/CBYsVp1Fa1LHB4Jfwn?=
 =?us-ascii?Q?Em/gVxdhvIVW3DkBPKhXAyhJDlwJ/9bX109wgYgeYMLGIRakKtgEcvPt5orO?=
 =?us-ascii?Q?UBlueoGOoNeZ54unwz/QoiOIp1DmiXdvjEkuILR7H+FhC2zuUikr5tJvrUan?=
 =?us-ascii?Q?hS4q1WarWSwNeT2Rz2ICSjRz508oF4lJ8BmMZ4MKVubFaIt1ndngGOQYzL3S?=
 =?us-ascii?Q?w9b1OET+fAzz595mnqOPoY9MXVwW8Dppc1aQFfkQGj9QAqinHntRe0PRr97/?=
 =?us-ascii?Q?8EpSHpG0oegyktiMlAYtZZEmRrv8YxwS55tHGRNlzWYcWgYa6lGEewqO7zms?=
 =?us-ascii?Q?7S1j4fbw9nT0JQVZ76BK6sI9Rp6lOQh6QhGRv+aNAiDhCy08MKGymAdLyPSI?=
 =?us-ascii?Q?WX9w+yNaTflIps5OEaAAIG9HN6v6dmkls+bOva/uJs+FX7bNW/9lsTbsM9ci?=
 =?us-ascii?Q?tT+dJy1bXYg28JOU+E3tcsQ+uxM9l+xGJydOPHEQEFCtZaqu+tT1aYKMDRQz?=
 =?us-ascii?Q?KruIDI3KuJkfKMKiJ7OH5yarutAHvEqpKSXOkan0gl/zDXkjUThHr4Q5f188?=
 =?us-ascii?Q?Z/2K11p4d0hUoib81tiyGdUnjr9045Gbxbc6ogQUQcOWHNvt8d4pEFEKHWwe?=
 =?us-ascii?Q?+imb3VXLyfuuf70Gn8RKA+eDnutXsSuWcly63YfYVzaDM5MGwjDd0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1TCXduCfqZiUN3IuNNaKakHMVwTk8dLjiPVdw8IB25PDTWhio4L/ruL9zMRr?=
 =?us-ascii?Q?4yPxaZ86oKKzA1IT36+o6AzAezRjUlTmhvEirjnrnpcv3162wx7wJCNWVdKL?=
 =?us-ascii?Q?wfy4yHFgEs5JNIc1eTNW9TjYGqNbtU5uYz4gwbhci4REvUC9vVEvWqQbOnqy?=
 =?us-ascii?Q?ebxse+w7luSq+5VBERAOprDjcYf4SAmdSPx67yBcLdOwY+XWw5UPeXp8jLPp?=
 =?us-ascii?Q?yiJ/6XT21alpuVtVKgmi/LmjKYokuHqpYiy9VcOl97vBi9oYcjUDFS6g+fQG?=
 =?us-ascii?Q?wFAZsj2Ja2aV9nflI2oczpjjnciF09O1kJedA4vbRU9XB7k3Zil2ehjMEqPQ?=
 =?us-ascii?Q?fZkbIiRsTCSaLqG5jHSKnBjdZ4tN/C+oZbWRU+Raz7rlwScYemnWGGRDMcDF?=
 =?us-ascii?Q?v+trWDDix9CSbNONEG/ch9LevmsEYTUZCbHVjrYEP9rmMUF0MPTdMLJXw3AC?=
 =?us-ascii?Q?S1o6OM6JIBSJ0UaVpGywOmftYtD2TUi+RQn52cAudKMWu+PL3zVoI22wCzLg?=
 =?us-ascii?Q?c3H2npBpGzJ+AWN8MNE4rY2RKFzMQl+N2CJlmYKJpnNDikH0vIpR0iDDWar8?=
 =?us-ascii?Q?0L9QH3cicO0bMa7DlC7Zwrsol2dayZfVC07QVuy3RGX1RbLweueEYn8BAvlk?=
 =?us-ascii?Q?DsvD35ftjSP0NlIie1j3z6zfGkqiWoHVb4uERRCT2a9QyygWwbdSxoxf66Wt?=
 =?us-ascii?Q?vFn8CXvJAWvIP4TFJdTp3mf1Kcsc2jAltmq316YF47KsPFUTLO7/onbr0Rfb?=
 =?us-ascii?Q?JCws+z4v+QWpId8FjxA2mnzQNdh3hSygkain/fHIa3iLVHQPAR2xxN0aJedd?=
 =?us-ascii?Q?Og9EOOUVH5Lbl8QEwld7qAutGxJNFfk9c/pimySUys/ezr7DDzJRc9lheLad?=
 =?us-ascii?Q?pob11Hf881PMwRUFL5bpR7wZwHqJFVTvPu3GI/14FEmijdwblFNYYTjMwaK1?=
 =?us-ascii?Q?8fGt4EmQKJrqOBakPBsojNiL19aRxHO60D9cLtNjGdv1y6DrdiiOmzbdkhcD?=
 =?us-ascii?Q?KtysMGMOnFoYCB/tTyi4HJBeeCD5HUJ9YKHYc5bGz9hkVe81aAEzNBA2f/W3?=
 =?us-ascii?Q?WVmzYrw+t6S3AqS90MITqsZIma6kZrEhR3+S3ZrN1JMPDv4u8+ozrwF3ptZx?=
 =?us-ascii?Q?huLEirEwlwFaQoMaSx0XDPs7n0/waf0A4UqoGy149Ycj7VlnnGnhTrYUwsBY?=
 =?us-ascii?Q?gZ/EHP9oLtjqhe4R8CVEgsyBEBwEX3OWLZ9DHGe4iwiqIdNUKvaLfQu23nck?=
 =?us-ascii?Q?Ds4kyC235wo7hEf9MtgwEp1bRBY/PV+O2RUQh9YsYVJ/OEVwVhyvSd1cekOf?=
 =?us-ascii?Q?i/iMKWSWN6cwk6hFUAecHF6d6POBU2Tx303FM8G7XmogEBG43RWW5nkgtOQq?=
 =?us-ascii?Q?COJfLwx6mfi0t/HNiMGiBhEGpo6YWhGPi+U3fJD1WsaPNk2cYAPtC/cyT6U7?=
 =?us-ascii?Q?fHczubBIiKmsiCN7GkkqzBWGv2qTM2u3wNuy8IGCRZOe6rGt5MVrJZNCgaKX?=
 =?us-ascii?Q?os7WbBi9molww4BHCR7nU3rwtc8AbNs8qclLe18+QEAfVajb1G/6SZAtnuHi?=
 =?us-ascii?Q?4qdNwWcW/3iUpbUd6co7jdHiVCthed75mau2CdkMENOitH7bFQ0+AFF7txxY?=
 =?us-ascii?Q?hsGGPW0HkQEzC2xkTSjsE1yQCB6HL86Ju2FhQqLpfu8AjJ5ESxevU/Mv9Lfg?=
 =?us-ascii?Q?cA3apFHqk2vB2AqzrgH6e+oDXbIufZVSASgkuXhcC9kBW0Ff2Ze1PTzsDn2p?=
 =?us-ascii?Q?T+NCQt8p/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ed7630-dc46-49d4-66fd-08de4832e70e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 06:07:39.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5eRqrNB3s4n/8ntr5IU/NTWH5PJ0g7mP/1g4fK8FToxosVNV+55TW1tEN1voH2WEBrwjlE5yBuPU+LGd9me1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com

hi, Eric Sandeen,

On Tue, Dec 30, 2025 at 03:07:10PM -0600, Eric Sandeen wrote:
> LKP reported that one of their tests was failing to even boot with my
> "old mount API code" removal patch. The test was booting an i386 kernel
> under QEMU, with lockdep enabled. Rather than a functional failure, it
> seemed to have been slowed to a crawl and eventually timed out.
> 
> I narrowed the problem down to the removal of the ->mount op from
> file_system_type, which changed structure alignment and seems to have
> caused cacheline issues with this structure. Annotating the alignment
> fixes the problem for me.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com
> Fixes: 51a146e05 ("fs: Remove internal old mount API code")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

just FYI. we tried this patch, and think it can fix the issue we observed.

we applied it on top of 51a146e0595c6, so:

* a474b9ba68671 fs: cache-align lock_class_keys in struct
* 51a146e0595c6 fs: Remove internal old mount API code
*   d5bc4e31f2a3f Merge patch series "statmount: accept fd as a parameter"

results:

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-14/i386-randconfig-2006-20250804/debian-11.1-i386-20220923.cgz/1/vm-snb-i386/boot

d5bc4e31f2a3f301 51a146e0595c638c58097a1660f a474b9ba68671230bd0a712a0f9
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :200        100%         200:200          0%            :200   dmesg.BUG:kernel_hang_in_boot_stage
           :200        100%         200:200          0%            :200   last_state.booting
           :200        100%         200:200          0%            :200   last_state.is_incomplete_run

> ---
> 
> RFC because I honestly don't understand why this should be so critical,
> especially the structure was not explicitly (or even very well) aligned
> before. I would welcome insights from folks who are smarter than me!
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9949d253e5aa..b3d8cad15de1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2279,7 +2279,7 @@ struct file_system_type {
>  	struct file_system_type * next;
>  	struct hlist_head fs_supers;
>  
> -	struct lock_class_key s_lock_key;
> +	struct lock_class_key s_lock_key ____cacheline_aligned;
>  	struct lock_class_key s_umount_key;
>  	struct lock_class_key s_vfs_rename_key;
>  	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
> 
> 

