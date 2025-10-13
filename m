Return-Path: <linux-fsdevel+bounces-63930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE1BD1F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEACF1884154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7B2ECD34;
	Mon, 13 Oct 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BUXDwIzz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iF5ExF4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1F2EB5C9;
	Mon, 13 Oct 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343101; cv=fail; b=uP+aL/Z9nZD6KjovwM6BCZV4v+RTyWDxe5TuABHo+Ru//sPMzf7nCca+CykcolNWX0I7YfRm93I9kypCLqDcj3Mn6T2OnjZQl/E9UfBjSeBzj/IgbEHkKo9DC/bSxeqVrrTPnPLVPoFKOq6I7t8lvFCS1GpuTqkTchwrIyVqi3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343101; c=relaxed/simple;
	bh=FPVR1nUeEWXW9EoSeTg8tQKebhgnvaKmQuI8+xfVyXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=la9on9+sk1Bdt+GThn1MAxoSi47XY0QzuE2w2zyB7N5+1S1a1PV1lNovmJmkQHQjHcn11O8d1jaDaFR2WZrVu10eDEGo+M1P7fXxAjh0IPPkee08CCGH9+gHQ4NOY3IdphZ+TJvgDtKxKcy5N4GrQAIHRe6P9bHKoaVStogel18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BUXDwIzz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iF5ExF4I; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760343100; x=1791879100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FPVR1nUeEWXW9EoSeTg8tQKebhgnvaKmQuI8+xfVyXE=;
  b=BUXDwIzzohwGtEY4mfHrtLqv91SS2abNJHDxaS4eY4wnm8Sl8vFwe7Yn
   aAXctT/1bDH8JSqOMq5gQTvUZpox5K+nLYgr92wrsTwMYEBLYhTGoLEIf
   2K+HbzxtPJh3AcU0eHRsUecA+GOMDpuQV04F8AXgR8nCiTqWINHl1/NNh
   iNvM0xGHi0BZuOsy7tnTF+V2xKd5uPwUki787Xy1tQun5KgY35DB/DEZ4
   0ijt/lTJdwbumcm4x8wfwI2PSmo2I4cbi7B1wzOYDflREbIuEFM/N5YqV
   2Z5VIUS8MMgCP5p2qtMRw2sVhoR2sO806vx0EZUNRX5K34Bnl9FotKfRv
   g==;
X-CSE-ConnectionGUID: mjLt5jS/SCy46j/svJ74BQ==
X-CSE-MsgGUID: fZV5sROBSNmtOIdbaoks4A==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="130105619"
Received: from mail-westus3azon11011057.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:11:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW797UXdT0uesQHvTzfH2rUhBiKsTrweQuoRDp6gLXzZMSPUyK5f6uDpj/VptapVhAL4+VGxIPFO3BKan+VypcYF74OjhHYB0GUoVLFPQHMki8d1DELIVD6Rs79ytyvKY6BSj6HTxbH+nAu5vPMuXNHRxHN/ZgZzlirCRIWXugObpPbI4iuxErmZX7gXEIFK2UW13kAag3MyHosPmJYzXDcCgxd0y9DXkB14J79TwUUyYMDG25X/NRgh6PCqU4n8uWzAzIg9D16sH2GzMh/+d+oT1RRT3oDfR3Ud4fQP3oOt1DgIbm86xE9qQuXjqZt22k7OCwFygm6l3x893x2cLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPVR1nUeEWXW9EoSeTg8tQKebhgnvaKmQuI8+xfVyXE=;
 b=GTUCZ8xniXA3pmO0K/jTif2KaHmmCxWZ6QOqZzIww0P4qlqY1njsxkITOMuwOlV08U09VMbTlRRomV1rQcxxNGBxZCgzdfM5bRVT1sTIcneyL9o0CMOtPFUWTcUYbTrV3Kpcdk/WjwVDVC0HAAeJj0xo0ulNDlCCyolNFL3g5BvBIO+tHyDoI4np0GEdD9j2DijExFbC4dJI6yFWoi9DjoqTHNior0RhNYgkTwY291JnHOf9DgMhyQzKYw8zIoG6j+mH+y5B/Kso4lqJBvLn/PpFs2YPn7JYN+oSQmE2rmyqYujgJ2fZA6VPhn50gpT7fK1mhFGmqnpRPy6wyBOVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPVR1nUeEWXW9EoSeTg8tQKebhgnvaKmQuI8+xfVyXE=;
 b=iF5ExF4IsRYu3TNpuKIjZ4r0l6xshQXJApYhQ2UM9s7uiOH73FtawQUUZdKVSYwnSMg0Dbxe3lRaROgBGzT1zgRHLFeB9LC2GfvBoiKYG+1EMT9y2LOynmVIhgXsDoXygjgtdbOdGEo/H9hCB27f7P4XmxPNd3erkRQgg5lYa8g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9431.namprd04.prod.outlook.com (2603:10b6:208:4f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 08:11:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:11:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric
 Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
	<linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>, David Sterba
	<dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker
	<jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jan Kara
	<jack@suse.cz>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
Thread-Topic: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
Thread-Index: AQHcO+1dZVuRfbvE/kmu3xObSWGqYLS/uh8A
Date: Mon, 13 Oct 2025 08:11:35 +0000
Message-ID: <aae79ea0-f056-4da7-8a87-4d4fd6aea85f@wdc.com>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-5-hch@lst.de>
In-Reply-To: <20251013025808.4111128-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9431:EE_
x-ms-office365-filtering-correlation-id: fdf32238-7f43-426a-456f-08de0a302080
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTJ0OG9rY0tVdWhkTDduNndyWHQ0MkE1RmJqdHhxNVJSUVMvYm1ld2dkSURY?=
 =?utf-8?B?U2ZyMW5QREhtR2w5Y25DWlFmdXFWZEsrbHNmR25NcjVENXljRFZTSUJtUzU5?=
 =?utf-8?B?aWhxMjE5WXhGSUFWM0ttSEliQzRJNThEMER4eHdLdUd6bE1YTEQ1V3VkK0pT?=
 =?utf-8?B?NGR0YUs2c2FWUDBWNDhhQjNYYVE2ZytMd2F6eFBPRy9DMGF0cjhOV2ZxUXc4?=
 =?utf-8?B?TksyVGpMUXR5N1QvQ0NNY1VvS2NUTkVyVVdUeFQ5WWN3azd0eG45SE1uTllH?=
 =?utf-8?B?eFV2Uk14ODl1WStRdjdPdytCSzlyOWxXYVFvSFloVVQrcjlNRmpibGE3MzJt?=
 =?utf-8?B?VTRZdmoyU1FUZndYRkgrc2ZidDYrNU9DOUFKZVdIamRvdEFXbFVZOTZJamh1?=
 =?utf-8?B?MVVhWkppeGI2YjNjRkxHK3QrcjB2VDZKYzlZMlpqQzhDbmtwb3pUOEFVVEw2?=
 =?utf-8?B?dGZoN1g1ZC9NVmpIWnJsOHc5WC92QXl3NWFrd1ZjU3Z4R3RkTkhqaUhCdFBU?=
 =?utf-8?B?QTEyNnpPeENadWMrT1lEUGdVczd0bThPVXlueWRINVJwdWM0RnMvTmd3d3Vx?=
 =?utf-8?B?eVhLcTY5K00rbWdhZVFxK2FJbnhkdng4NGNLbmk4OUhWUkZaZ21mdG5vUElI?=
 =?utf-8?B?V1R1RHhWc2M2VzB4aUExWmh3ZWNZeU9XUEJ4bFltL1YrZ1JpT2FxSk03ZlVM?=
 =?utf-8?B?M29sVVE2V0ltNFRveEkyK3pET2hNK0psdUF4RVBpclcxSmI0WmJ2UE1QV3JC?=
 =?utf-8?B?NzZ4QTlDSUVSMVRxTDJJWlljNlpTSmhFK1pyNmowS3JmdllFQXNNUko3eS9y?=
 =?utf-8?B?SzQyL2oyYWdxZStESWtwdGUvSzF1L0N6RDlCWDBvT0dGbHlrSDNtb1dib0M3?=
 =?utf-8?B?RHlmUXlUU1RTa05FWXRVRWQ4Q1Nhdk9DUStnYW1QYlJpSXFxYzl4eEpEcncz?=
 =?utf-8?B?SGxIdm81UEg1dGJEcDQ1U0tZOFNuSllzMjhkTHB3UDJEM0VHdC9qS3F5eFFu?=
 =?utf-8?B?S2JHdjJCUzN0UElCaDBUblZUdWNMY25HSGJ1Z2RYOGh6MVl3R3lXNEUxeFZE?=
 =?utf-8?B?L0lwQWNVczBBbTg1T2JNbkxZa3RTc2pqYWlKL1pOL1pmbk5WNkk3b2NLMHRo?=
 =?utf-8?B?bHBDbGI3dVpFbTQ5NTE0TnBuL0RNZWVzY1VzVko0Mm5SUisyaEZXS1NmQWJp?=
 =?utf-8?B?WFgzVWFrRmxlZTFRWTZyRnpsRjFUTnJJVS94VCtQdlltTFhuS2tTazY0QVA5?=
 =?utf-8?B?aDJjNm42ejNEdENjaEpTcEI0WW96Um9zckVJS0ROTGFsVEp0SzNzNVEyamVP?=
 =?utf-8?B?R0k4TjZCd1RRQi9LdmZnOGk3UkliUlluL1pIQm40YXRZbU5DVG1iLzdYdkZh?=
 =?utf-8?B?T0xMSDVTbE5SdnlBMUFiYVM0dnBCaGl1MFNxUzV0dTN4bFJiaFJYWGxJNmpp?=
 =?utf-8?B?bG8rVFBuWHhWTURvaU9IbkVVTGZMTFBNUEVPNEEyOE1rQ0Z6Sy9CampHVVkz?=
 =?utf-8?B?bWpBazdNWCtSNjF4MHNldVcvQVhkSlVTUHZDRjdEZC83eXdDelkreFBhb3BN?=
 =?utf-8?B?UUlUUW1FWmhNMnVZc0o3a0hCS09RVUtkUDV1TklJbjhaSmFyZXdTTEFkVExj?=
 =?utf-8?B?d0F1L3pDVmVEbWswbUI4MHUyWkJzVUhEc0UweVZIdDl6RnBpbkhVd3dhUWxV?=
 =?utf-8?B?a2hZbWZBNTVoUElTWWN1ZGZRRHV3SVZMWGZndmhOZDRsSlM3ZTlnS0FTaW9M?=
 =?utf-8?B?TkZOMzJkZUxjWE1UOWJ2elJlTDRUbTA3V0M2TCszNUdPZ1UwZ2RnMVlrNDQ5?=
 =?utf-8?B?QnJKMHV0eUYrRjUvejNuLzFYS1B4dDZTNHErYU9yZlE4QlQ2b2hBcE13czdL?=
 =?utf-8?B?SldKTnYvUDFwY3Fna0JOcEtzZ1Z3TDlxMm5nRFF5anRyQUZXd2NOb3AydGxZ?=
 =?utf-8?B?Z093bTFlSXV3bmVGV3NxeDlxcTBYQjFzSyttSHd5TGhoWVRWSExlRG8wVzVK?=
 =?utf-8?B?bWNvS2xWNFVoRzU4NlNWb1FqUkZvbEFzTUhzM3ZkeTgxOE03L0E4UE84aUFj?=
 =?utf-8?B?YnY4d3pOWWNCQml3RlkwUCt4eDY0am5TdlNkUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVFldFFHMC9ZUkVtUWZlc2lKZlduSzlldmhxamNGWUU3VEpaelpBa2xLWThG?=
 =?utf-8?B?U0lhekMzSk4xRXBaTGRHMzJlNWlNUXlDenJ0ZDhxWG9aazVINnl4T0R2UGNw?=
 =?utf-8?B?dXN2UjdyRU1vNkhZZCtRRGxVZmFGdk9rS0k3ZmZpV2l3MnBud0sveHUwVDEy?=
 =?utf-8?B?ZFhyemtXOXlRc0NaM0pkUkhESDNna3c2d0JXckEwcmkwazRLdTJxdWFiaFVG?=
 =?utf-8?B?ZkFmZmZPYVliQkExWm1JRnV4cnF4ZXc1aDNUVksrN2xrOWVKV09FMHk3NEtX?=
 =?utf-8?B?ZWxSQzJGWm1QVUFoLzJEMXkvU2lPa3R2Ym11TkVtSXZDUzMwRkIyQkRFZ3Bp?=
 =?utf-8?B?dXhzK3E2KzBLd2hZRjlUMlZjUFBRc1FvcXlQUU82TkxsOUdoZWpIUVNnRTFO?=
 =?utf-8?B?K1VoM1AvTTRkdVMrMXZvRldtaHlzYXc0Sm1zQ1htZ3RpWGVCTWF3eHpSYy9G?=
 =?utf-8?B?NDhocy8rdk14ejk0MXZwTFlFa095cEhoVWx0cVNiSWpCT1VNR1kwOTB2ckow?=
 =?utf-8?B?M2JvRFdkS1RYK2tJMzJvVEt5eG9DelpVMldoTGNxSVlCNjNUaVdTY1ZuOURo?=
 =?utf-8?B?N2FjZnJzaDZrZVVLeFRZSFRhTmRuNHViMTVjd0QvMVNEajZuWlVBakFCRDFm?=
 =?utf-8?B?bituQjNMNU96eFFwKzBDTjgrSzkxN3BQdlQ5NHV2N011R3FZTkUrSTVtQTlt?=
 =?utf-8?B?eFFiVm9ucnBldkErZlExSnZoZXViTEVwV244RExYc1VZd2RIdWVtVHJNVGds?=
 =?utf-8?B?ZFZ1MEltSlI0amRxb2RTb1V4dy9QcUR0bUswWG9SaERCS3lrdG1YRXpiRUpz?=
 =?utf-8?B?SytMeXI0RHUrYXoxM3lYWFJOSFkyNk9Ud2Ixc2FJbHRsVUtmTHJmSm5PMUhL?=
 =?utf-8?B?YjFBU20rcUNxZ21BT3JTODlFeTk0NVNVVEJseTd6bTZDSWgyZ3pIaEM1YlYx?=
 =?utf-8?B?Yk9SbHNXTjcvSnNtUzJ3QytFVTZlb0g3bFd2bE9walNIaXFDeEtQTkxKbWN2?=
 =?utf-8?B?dlc3WDA1cjIxeGZQcU5LSzJSUzBZZXpSaE45bS9QVXQzd1V6NXI1eU5NTmRw?=
 =?utf-8?B?YXpQSHAxWi91dTZWZDBVeUZ2bXlialBxTDdRNnpRSEZBWHpWVE8rbHIvUTJi?=
 =?utf-8?B?bFJ2NjFkUVNyMnByUTZ0UExoRUlRUjZFY0VLRWF3U1oyNmxJYWVBeC8wOWZN?=
 =?utf-8?B?UW1JY1orQXhuUGs3WE1waU9wVk1WRW95b2ljbG9iZ0k1bjVzRXNJS1FmaFVs?=
 =?utf-8?B?ZkNZWnpWa0ViQVREdEl6aG5zNEJteGhUcEFjMTVjeS9MK0lDWVpHVWZ5MllY?=
 =?utf-8?B?UHNLQXUyMExROHpRMkd2SWowcEVEQXlXa01GU0xmaXNrRmVPbngxS21KUGIz?=
 =?utf-8?B?N3dVaWlwVkIwdXQ1QW13OW1US2hDaEk0YWdzYUFSTmtzOTEwem5kWDkvK2hm?=
 =?utf-8?B?RGJIYzhocHZFUkZFT0tEMnNhdUtReEtnL3JJSHoyWmJSQXZOYXQ3c1NOOTJY?=
 =?utf-8?B?WktkbXh5YWc4ZTI0VVo3clI3ZU9ITkp0cnB1U3dxMGNzTjN3THJ1N3VLVjA1?=
 =?utf-8?B?YXFjVkEwRVBGVXJjcHR4YVNxRVAwdERubGwzTTJSUWxUd0E2OEFOYlFtMlIw?=
 =?utf-8?B?MVJ1UU84M3hXU0JxbkxWTHM1OEd6OVlGdXRKMlZFMjZRc0pzTE9QQ2ZjelBy?=
 =?utf-8?B?T0ZBUStTMGZmbC9iVHFZUFBNNFpzL1VsakxvcDBuRTVwTGw4VzRweGowZGRG?=
 =?utf-8?B?c2RZWFdqVUZzNzVCRXltaW0zZDVIY3cveHI1ckxTd1N0aThpMUtFbFNvbjVT?=
 =?utf-8?B?ZmtncDFNZkhkd0N2NXN2Tmo3YkxCTWJhRVdIRUFXYUJxV3VQRWsxYmFHT0pH?=
 =?utf-8?B?dnpGeGFGODNWeGZXQklSNExLVGJUK0tlOGVWUEVjelNWZWVHM005NHU2WW1F?=
 =?utf-8?B?TmFIbndBY3JWSEtFU0hEU3kvZ01ucGZQT2hUUUUxZi9XNlJvK240d2pTaEdh?=
 =?utf-8?B?bktEbnNLaFhaelBYNkxBcUtiTGNEbDArYnNET1ZOVHg4dHE2NnoxMmVUaGZk?=
 =?utf-8?B?b3lrRFpDeEVDaVdKRXBsSmtNMDFjNjNzMWQ5c1RoL2JDcTExL1JGY2Nyektw?=
 =?utf-8?B?ZURmT3BuN2l6ME9BcXFrSWt0NUl3N05EYzQ1bWFoaWc0NWw1NHFGVjdFR1VF?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3AC73DD425CFF40B13D242FCA992F16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lnr4fz6t1WL6ODJg4q/uPquvR5KP2TRXmo8Sc9XC9O8KoLLL+/ngsekF9XfW+YEV/3AbsNGwvoDTKp4uO3F0EtclJjJ0lK4PMA7MdwsWGROI6ekkdOXEPXJBfYePTwLOiyDL8eqTJcFFQj09MkhedmWU4J+Z/bB/rvuYnKRzwCmwn9qyj5AbVIeVPv0Q6EmGAsN1NQ3Vno+qjBOCvMtWWFoGy5IaMil5ZnYwkVhV03A24u8v247Lc9LzumkylZxdHsxiMxBdgeXonl9FLvFmE0xQTsyKvTQrdILSYfJKjPo/WG/ceq8iD+cvO9VqG/mgLDY25Euq3jurue+XM8yUii+RefAiYj51tTJrYEXJy+BKX1sUwB0an326DGX8fkpvBUElsA5JaT1S0SQkwh/pqfswTuAkwd5NTaXAOBJ2Nf2lrCqijbx7c4uK3da/jNBhlKH/G9BsUYzr/9CKQBXRMmTwzXqEinrl72p975WpLQ3Izm6vEkGkR4LUM8L0kThDBI/B5c3ePd4bYJNCZ4uHwd9WhiPK2IoYCEI0ifcA8fUb9ovsws1MtTphMcWbqXWfzul/kmcKHhhUnkW1Wtgf1kr9KXyech75ZoX7rU4ohwB06Z7qUrwM6/romoeMYplr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf32238-7f43-426a-456f-08de0a302080
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:11:35.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+58TAcGItL7X4ro9rFgnk8DRWRh9rF3FwERdKZdiNjWgPyIUa6VFfNFCvDfxo3ZEz9FQTVy7KPVVMgwkoiaj3ZHcbfgsdVK1qDpYqEeIWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9431

T24gMTAvMTMvMjUgNDo1OSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IHN0YXJ0X2Rl
bGFsbG9jX2lub2RlcyBoYXMgYSBzdHJ1Y3QgaW5vZGUgKiBwb2ludGVyIGF2YWlsYWJsZSBpbiB0
aGUNCj4gbWFpbiBsb29wLCB1c2UgaXQgaW5zdGVhZCBvZiByZS1jYWxjdWxhdGluZyBpdCBmcm9t
IHRoZSBidHJmcyBpbm9kZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2lub2RlLmMgfCA2ICsrKy0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KPiBpbmRleCAz
YjFiM2EwNTUzZWUuLjllZGI3OGZjNTdmYyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvaW5vZGUu
Yw0KPiArKysgYi9mcy9idHJmcy9pbm9kZS5jDQo+IEBAIC04NzQ0LDkgKzg3NDQsOSBAQCBzdGF0
aWMgaW50IHN0YXJ0X2RlbGFsbG9jX2lub2RlcyhzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwNCj4g
ICAJCWlmIChzbmFwc2hvdCkNCj4gICAJCQlzZXRfYml0KEJUUkZTX0lOT0RFX1NOQVBTSE9UX0ZM
VVNILCAmaW5vZGUtPnJ1bnRpbWVfZmxhZ3MpOw0KPiAgIAkJaWYgKGZ1bGxfZmx1c2gpIHsNCj4g
LQkJCXdvcmsgPSBidHJmc19hbGxvY19kZWxhbGxvY193b3JrKCZpbm9kZS0+dmZzX2lub2RlKTsN
Cj4gKwkJCXdvcmsgPSBidHJmc19hbGxvY19kZWxhbGxvY193b3JrKHRtcF9pbm9kZSk7DQo+ICAg
CQkJaWYgKCF3b3JrKSB7DQo+IC0JCQkJaXB1dCgmaW5vZGUtPnZmc19pbm9kZSk7DQo+ICsJCQkJ
aXB1dCh0bXBfaW5vZGUpOw0KPiAgIAkJCQlyZXQgPSAtRU5PTUVNOw0KPiAgIAkJCQlnb3RvIG91
dDsNCj4gICAJCQl9DQo+IEBAIC04NzU0LDcgKzg3NTQsNyBAQCBzdGF0aWMgaW50IHN0YXJ0X2Rl
bGFsbG9jX2lub2RlcyhzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwNCj4gICAJCQlidHJmc19xdWV1
ZV93b3JrKHJvb3QtPmZzX2luZm8tPmZsdXNoX3dvcmtlcnMsDQo+ICAgCQkJCQkgJndvcmstPndv
cmspOw0KPiAgIAkJfSBlbHNlIHsNCj4gLQkJCXJldCA9IGZpbGVtYXBfZmRhdGF3cml0ZV93YmMo
aW5vZGUtPnZmc19pbm9kZS5pX21hcHBpbmcsIHdiYyk7DQo+ICsJCQlyZXQgPSBmaWxlbWFwX2Zk
YXRhd3JpdGVfd2JjKHRtcF9pbm9kZS0+aV9tYXBwaW5nLCB3YmMpOw0KPiAgIAkJCWJ0cmZzX2Fk
ZF9kZWxheWVkX2lwdXQoaW5vZGUpOw0KPiAgIAkJCWlmIChyZXQgfHwgd2JjLT5ucl90b193cml0
ZSA8PSAwKQ0KPiAgIAkJCQlnb3RvIG91dDsNCg0KSWYgeW91IGhhdmUgdG8gcmVwb3N0IHRoaXMg
Zm9yIHNvbWUgcmVhc29uLCBjYW4geW91IHJlbmFtZSB0bXBfaW5vZGUgdG8gDQp2ZnNfaW5vZGUg
b3Igc3RoIGxpa2UgdGhhdD8NCg0KVGhlIG5hbWUgaXMgcmVhbGx5IGNvbmZ1c2luZyBhbmQgdGhl
IGNvbW1pdCBpbnRyb2R1Y2luZyBpdCBkb2Vzbid0IA0KZGVzY3JpYmUgaXQgcmVhbGx5IGVpdGhl
ci4NCg0KDQo=

