Return-Path: <linux-fsdevel+bounces-58085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F44B291CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2D9204104
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 06:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C3215191;
	Sun, 17 Aug 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YJXbc96U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KmEIq6Ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A813C8E8;
	Sun, 17 Aug 2025 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755411267; cv=fail; b=ReRwmlGwBbpcHf2bIcBvn/Z14cRCXDkjjpUvaGy+7JKT8+oBUR/FjrenIg4pb9uLE68/fHLk9+igdQj++cKuwKttO10MzfsXrtpsmQukUF/LjQdH5uHEKqpguTJI2bdmuzEQ9il5ifXFYP+7c4SsBNywmH4wgOrieblMgqumsNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755411267; c=relaxed/simple;
	bh=1KRWQ/aXiG27mNkeYnJcWRRXau76wyzKnBhvQcj8OMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ouSiFds/6/iT5CmBhwZVU4FJ9P+PqFRiF5NURt9vH1PirIWKAhKgkka8RWF4PktrNUvHYZBQyERHdV1dTCPglhzScWsvaB938A6PBeNqCJkryhfQmUPcoqctlnIBmH80NYLc+Vk/+MerqHw4vc9y5P4OM50Q1/mT961l9iIGMr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YJXbc96U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KmEIq6Ug; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755411266; x=1786947266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1KRWQ/aXiG27mNkeYnJcWRRXau76wyzKnBhvQcj8OMs=;
  b=YJXbc96UM6hk2aVXhBM30vGmkda/fdiAcci40LOAMKnySPs7a/bgNYSo
   2Ctv5q1iS4BtEiPvcADB0oV3GOTbetK5M7/B/cc5eRNmL5QDmU6trkiJG
   HknExW+VHloxz4GV+6X3qtQYeBjl8EI8efnJpqMCz6+CUiG11FcpdrJXt
   t11Kc2glL3+Xc2v+iVrIwNL/3M2g6YdKDCS2qPgFmPUuPcyAD2beKz7gL
   cjrPmKoFLUiYD/6/8BYJpfV7Pn6Aik7GL27A5QU6Mykf7kASOP1qmpXWQ
   W9asVsPHj4Y4gEaTp+FO6CbEtx9BQmCSIaP3IuLlrqvLo98ygx+iDAece
   A==;
X-CSE-ConnectionGUID: Njdl4gA1QEesNgfrKnZbIg==
X-CSE-MsgGUID: M0pWI7SHRQm15h1S8k+VPA==
X-IronPort-AV: E=Sophos;i="6.17,293,1747670400"; 
   d="scan'208";a="105977819"
Received: from mail-dm3nam02on2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.48])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2025 14:14:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr/pGfhaF6xGEYmZ7v7oFRDK5x8be2u9Bu0XYuvDbbu4ITJlqfdMcOR4aUlnWl3wCZksfIyttv/c4gwsnZImP/IqG6p8jG6nGG1fORvejUinftGpSelz2yJk959T7wv0tqTHLNkGxJU419wJbk9WqEnuztYdJ5fdmC+kzxo2JqSRTj/ncdw71USw2CghGKu9MvOHkoCCsMzGE88rw293fu4iWssTaICPnJWTseUTrZfsHJpGLYcosXX7BJ2OO0UwezVxvQCD3v08oLPIb3iDlN80c+EM/R8dbaDc1r7425ca9Mn3wwP5AjrfRTLzpXMKvuSfk6jGiuRkPd1ratTB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPzkCWmPyMKuQ4BVYiSGiDyXzJQipJCH9KXIFRU37Uc=;
 b=vRLFoxrPwTJOldwTqWjQHerajVoUJsSMYdRpeFrIbIK18ljdZc66yDB4/ji1SGYB7AnBV0+Oh+G/J1woYRcIiFG5Cdhn43SmYqPZN6ufgNAPERMNF58Fm1I4XlgCQdIyjZ6V2OwAaqslFVMLq/E2nDJ0Qj/70xqJw0ha9W/RIgNiHGRggKDjU/yspxArLwBEP1QE7Hk17Jty/6zAV2wSD5qDHrawsV2WpDrILYMHRFyiMEgfbvzEKl3qngfEhuDHzCePo2Jr6u6zPUL19EtYh+atlNbtku3KlNthyhTYqJgYJ9jTonYWjsH/qP03wa6QiRrR4fdDJQK4gCuZhoaQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPzkCWmPyMKuQ4BVYiSGiDyXzJQipJCH9KXIFRU37Uc=;
 b=KmEIq6UgDMXMZ+JZMK4LF+H9sdxJBcxzk+iZhdkQZgPrSsEXDs3XY4ha0iDL/zkgg7q82IIp4GNTLfoOwFAV4MmNkRlbDwSDYjopPT5iia2xya4mWqkko+kn4KV25DvZPlnrhVZ2JFkXlraKAmq+oooEht9GMImfnHwCk5jjHfw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7838.namprd04.prod.outlook.com (2603:10b6:a03:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sun, 17 Aug
 2025 06:14:15 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9031.018; Sun, 17 Aug 2025
 06:14:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, hch
	<hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>, "djwong@kernel.org"
	<djwong@kernel.org>, "bmarzins@redhat.com" <bmarzins@redhat.com>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH blktests v2 0/3] blktest: add unmap write zeroes tests
Thread-Topic: [PATCH blktests v2 0/3] blktest: add unmap write zeroes tests
Thread-Index: AQHcC/1OQIE128Ii8kqCJCV2Ih/mG7RmZFOA
Date: Sun, 17 Aug 2025 06:14:14 +0000
Message-ID: <7dswufawxmyqblokjesulhdexqld3bx7sycgmylbaeqs43ougk@25rseyqm3beg>
References: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
In-Reply-To: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7838:EE_
x-ms-office365-filtering-correlation-id: 9d0e5bb4-8ad5-4e54-1737-08dddd554a8f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e94JCdTQ0LBMAphJ1R6VswSqOkE+HdEM3pNQKXaD8zKrV1o7FG50HyzktaPD?=
 =?us-ascii?Q?y/5CldEhVLwTJ9AsITxVq1lHzNgvEgvneQQdyszmjOwNZmYkB8pPtyBPYtSG?=
 =?us-ascii?Q?L5qCgIipWg7E9QyFIDHNaEkkTyZ/WKoeOLcXl6pAdWb6xIqZvCzmNWBoxt+s?=
 =?us-ascii?Q?xYhv1HHkvy1kUEJrKVHmqAgNzZt44budLg7oGbOxqyEzrMVEYRt3viCqWls9?=
 =?us-ascii?Q?9FjfR0rtfqrCLfC5MdQwANyJWC+ZNvst5P1IHTllWBBNcNzrbLV0tihQgdKz?=
 =?us-ascii?Q?GowOHpesBQDeJwohBhFEpo71KKWbCY7EH6Uy2Nnn6DDDwJ9SNUMVd9gfTCos?=
 =?us-ascii?Q?JYzPRyaTXA2Nl1stRLzj5YRRkCmr8F2K+AmHi1C9zE2MknNTNtaO0u5JpVzl?=
 =?us-ascii?Q?14+gnI9bvUX2e4MXLxg6VY/mY5MJyDBiuvIhKDH7DlFdNIeidauAWgDp5Z3N?=
 =?us-ascii?Q?9RZb5LI2+Fc6vIKrNdfe0ObKWfPO806AP98uuBzQGm4uvTfav6cITUSmbvy6?=
 =?us-ascii?Q?2KIj48QoBIP7ETyg/41d/eh1QsxdCT/fbINzVPqhdbJW6gR2iriSfPP54qib?=
 =?us-ascii?Q?nMAxSis6KtlJprAC4vtMGxCDwbj3fwbKKc2R1uROD6Tb3LTPCU2b03QJz7SU?=
 =?us-ascii?Q?bguj+WFiik5N9+Tb4TMcaD60z1Ozyg3gJ5/VdFKw+Cybap1q/KlNk/UoIxlK?=
 =?us-ascii?Q?MJovarUcmU39rHpSepR2dMQvJenDoFSf2GKYbDCdyhWz9xpTKkr5XH+/OOEp?=
 =?us-ascii?Q?Z0L2CzKTgyWqZjYwrfnz72ZgFmmrdnAyY45oWGrGBve8EzXCUDoaHz9YL2kT?=
 =?us-ascii?Q?6N1kqhwcAQx/OutWxgzPzp8SwoS8heYuYkn7w2PDNeaeDLHIFAFw+GgfzpTP?=
 =?us-ascii?Q?Su3zKBl9F8S++rQVD8DNJ7UW6YgvTpWkKoryuWOyeAyt8zbyYVyHAHLIE3zo?=
 =?us-ascii?Q?TuYK9sYC42gtkceWjzeRkqxdFFQyEWZj2INT7oEoywIiwDbg9sK6IbBql7Tq?=
 =?us-ascii?Q?aojQf8js5K/1ZS9exA/S/P+ahOpPvCDrEZRRUV0ba7HQp45IrQ697x3/k+Dp?=
 =?us-ascii?Q?v1+JpqWQIQdFgIDztfT+osqTJP8QFtjBhvOhcq0M4pj51TpswUm0MZI+iKFN?=
 =?us-ascii?Q?w5lytXB4/KJ/VD1H+/FjkSTdRuyiZ+FHt1VSuYHRGJdHYFo1vie4/OjMplog?=
 =?us-ascii?Q?RkrTOFwSvcOn9v49PHMS+rnKmES0eJsGPcyMD0ozvNRLGX5H0SHFZpgMQq0l?=
 =?us-ascii?Q?gOMJfPG0Ioju7N6WasC3DBy2C0P0rbfzCTVAwryd7fgqmqcet0YFaM8MqGFP?=
 =?us-ascii?Q?JBoWcXpCuZ76nt+p5C0CovXP7OehgeoEpLnFTrHtoOPnwFkM2jWBmmbXOCBb?=
 =?us-ascii?Q?wiq8TQ9bWaNpkVTYkMmoPkRb+6KmXDjmOC/9RceXuWnd0E2xpB2G5mB8+CUU?=
 =?us-ascii?Q?CJTHFzGINui/xyhTgU3fxTlDo33Fv6bIMwB7PUj0FIklTyvODRl4zRF/mG4T?=
 =?us-ascii?Q?N7bzJLq2Ryo/Ztc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TSDSWOplMQ6kFp8rpvO30uTGsZhJEG1V46PpPGGqEqDQzZzNoBhlhnf1X9O2?=
 =?us-ascii?Q?vTxfq38q0+6UsP6UV1rVa0DY0BpI/h7N6LfJM2p9YPMUDV6SsIB/etuoFPE+?=
 =?us-ascii?Q?T42VmJcs0kIYDNow9ce/3bQkGM7hJ/PEaqB60Ed07fZtt3aB93Af+p/VToUo?=
 =?us-ascii?Q?wr45IC8vJsMpubHnVR0JUPiiqLYUnBV+AoPf4vfF7NPX0BUNGkN5YqE9l2OG?=
 =?us-ascii?Q?TiC9+6rmHMQuhA8vixueNZYYr7bO4pWCT/zxDl7KSVUVPsgLjaRbewoKmdOc?=
 =?us-ascii?Q?vweoOb0zJB3n3YUEjSjsmrZmKGU3M2bG8l7buRk4NNDsGjBKCOT0mcWlkH/j?=
 =?us-ascii?Q?OFFzO81ELfWlh7nqR4foXU4MotxZFBFecZgWBb2hskQwJKmCoqMlpmse05T9?=
 =?us-ascii?Q?Rw6QbiB/KLuvJ7uyOi3CyuAaQIK8oHzZ6dIvQ9uimJ0C3adg73Q7RikFmCGC?=
 =?us-ascii?Q?QJrpwbFZMpsRCtleaxLAiuqKBy4SwDZi+F4mBhzaOzUrUwD6G6e2fdMt23wt?=
 =?us-ascii?Q?s807gtLAHFPqULFDkv1zc6dc451Pzn7D52FcLatp5IKSWhDI6ArGS7yOGLRV?=
 =?us-ascii?Q?EAyJW012CTyH3hIKAO57cJzNiaw+D1PICflxa8/b9+OCuWoE/JJkd2qNXkAo?=
 =?us-ascii?Q?zLnhDrClFYYMfuKHdvCb9FxNcQwVhCRuGH7dKrito/uGg7m6VmvAmnSOxYuR?=
 =?us-ascii?Q?U+iInIADvmfjTAI6sSQrdeljsARudRPgdQ7aA5HuwagrTzbvupsA2ZNTVGUd?=
 =?us-ascii?Q?XAGzEE+8YUjrRON0ADFQCqqU3Bs+37C3egBns2mDXWvQBbpHydm/txRucy4Z?=
 =?us-ascii?Q?RJavPYjrjeWJWaP4WJ2eyfGvlhTmIcxKTK0A6+Ucqj3m3MXX693zwlSWnqDA?=
 =?us-ascii?Q?tHvA6L528KgYzs5ltECLtHtH8IBUybq5n/GmPQ7Imz0tgBfEOEBTaaXMD4IG?=
 =?us-ascii?Q?Q5Vu03XOikQ01dvJ7McKopBlGA5FSca9tAOSefQD+MeWlimNNw4TjEwOBPrB?=
 =?us-ascii?Q?aeOdLhMztjb12rAYslqPnBL1cC0juce5I7C+Kc450jdmOEofO8jWonpScq/K?=
 =?us-ascii?Q?CF3DEShyPw2URS6gGzzGnbh4CKYQ9VShOaN9GMYyiLNVhxUjomvnHye7rt02?=
 =?us-ascii?Q?n+4K9bNE2qHmYESx3SmbrkRpVazXiT2wUd0KGLtlncy4wCD+sGPk38lmFFrq?=
 =?us-ascii?Q?hqi+k2FEz05FV4AvT5T0qfZKfY2+VNg+eaXPA4gCcsSZMkt5D/uBI6mXxqH8?=
 =?us-ascii?Q?v/N+31gXatj5sS97clTeoOFRNAraQTpWSTvNZXf7+I11Gje4SOPPVQJgwgrm?=
 =?us-ascii?Q?VntbE9uFs+ykHtNowqsCxMJyMn/cc92Ey6fOT89mzo/GnRLG/ISuQ49Mec7m?=
 =?us-ascii?Q?JL7q02DuDHD2StlLUICyie7D245KgHgJa0zchxhQbcZ6EVB9hQ8gKShmR9zP?=
 =?us-ascii?Q?Ilg4vUvtf9H08hdq9j8CaSS78orDU4Pcw/hKOvxsStvDh0pW/uV7St67NYFU?=
 =?us-ascii?Q?FUH0zmbk+vw6ItQYiFeGbDYTdZ8Kt2591wfgJTj/3ZP1gJpdRPczsgdjV+z4?=
 =?us-ascii?Q?Nh8npjyAp4rXU3fgAK7+AOORaTQixn/OBO8Ksdvr01V4F+xdmiB+7OOPJZAk?=
 =?us-ascii?Q?cz8rn6N8AA/ZHvGelvaixV4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <270CDC7B314FFE4EBB79CFEDCCFC8511@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1WLh6to2NbCDJIJPTqR1sWjv5Y0vo/IOIZHAU3FkMZhPSWU/+2JZo2yqYNxGRCwfmPtsSbemcaEgCbmba+zN7e84w2NO8xuQc0NVklo6z2FWJtl5eb26jU1o3mqt/gR5NxR1V4AHOX//wI6Gb2OjbmZYw/7KMJ931dA3Zcn1B1FF+k1i/dDPVPT9BDb2VTMXo+qzSAPH9V9uPw8ImC3bDU9tZGf8AZ6A8LFhvTH1CnsGBda/eOozEHaPB64MAxi+ullRJY/Xzed+HfFAqbF5CMPIVaey6DnFYw/zA0X3eJm3YR0Hrx1PCM4j2A4LRtL1po7pnVeBWkK1MmW/dkiZQaJq1qX38ouTxzBdj4SENwgseTkHssUg9qSnNRSaIoPf1MmpxQYBIW1GewX4hbdJ0r48sR1ksiceb+Q5gNczpqBETdT01xd6wTuS39t7fl73V8xLfyfGrmworUwpl3FUFlk8BIZYmUUzGBVKr3LnmIdwZv4EACsLb5OJGlFhaurqFCAAXmy/AEeUo/2iM2cXhulY1373AkzxDVKMjz66OoXzcrfU8UvVGnjYQ1hHct3gpe1Ls83P60+xztS0P/vnNyrIyPBS86VgE7rY6USlkC08EMuQYwSFw0FFBWEpFFvm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0e5bb4-8ad5-4e54-1737-08dddd554a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2025 06:14:14.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG08+llA9X+h/qtAiyVNEqyiijZK8n/ScneyX7betQul0jKuyaezRy9588WNIDLXM4m2s7SdQhQagpaXH7WBSC9URxVyq7P4sS8RiKdaevk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7838

On Aug 13, 2025 / 10:44, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>=20
> Change since v2:
>  - Modify the sysfs interfaces according to the kernel implementation.
>  - Determine whether the kernel supports it by directly checking the
>    existence of the sysfs interface, instead of using device_requries().=
=20
>  - Drop _short_dev() helper and directly use _real_dev() to acquire dm
>    path.
>  - Check the return value of setup_test_device().
>  - Fix the '"make check'" errors.
>=20
>=20
> The Linux kernel (since version 6.17)[1] supports FALLOC_FL_WRITE_ZEROES
> in fallocate(2) and add max_{hw|user}_wzeroes_unmap_sectors parameters
> to the block device queue limit. These tests test those block device
> unmap write zeroes sysfs interface
>=20
>         /sys/block/<disk>/queue/write_zeroes_max_bytes
>         /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes
>=20
> with various SCSI/NVMe/device-mapper devices.
>=20
> The value of /sys/block//queue/write_zeroes_unmap_max_hw_bytes should be
> equal to a nonzero value of /sys/block//queue/write_zeroes_max_bytes if
> the block device supports the unmap write zeroes command; otherwise, it
> should return 0. We can also disable unmap write zeroes command by
> setting /sys/block/<disk>/queue/write_zeroes_max_bytes to 0.
>=20
>  - scsi/010 test SCSI devices.
>  - dm/003 test device mapper stacked devices.
>  - nvme/065 test NVMe devices.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D278c7d9b5e0c

I applied this v2 series. Of note is that I amended the 2nd and 3rd patches=
 to
fix the shellcheck warnings below. Anyway, thanks for the patches!

$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
        tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
common/rc:679:7: note: Double quote to prevent globbing and word splitting.=
 [SC2086]
tests/nvme/065:44:7: warning: Quote this to prevent word splitting. [SC2046=
]
tests/nvme/065:44:7: note: Useless echo? Instead of 'echo $(cmd)', just use=
 'cmd'. [SC2005]
make: *** [Makefile:21: check] Error 1=

