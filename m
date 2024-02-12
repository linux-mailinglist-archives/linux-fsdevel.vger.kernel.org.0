Return-Path: <linux-fsdevel+bounces-11092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A7850E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 09:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BF6B22310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7D1754F;
	Mon, 12 Feb 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D9ZLvaPI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fjyb8e/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE813AEA;
	Mon, 12 Feb 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724844; cv=fail; b=eQ6yA+roYRJ99M8SpYZE+QHtDa27FyozSpkCMiBG93JRK/B0OjnRTXZdPhiUozi3Dt19ej3y7DRQ/0Jx5K5ELM0KJ/xyjP9RsQQbnoa/BoJzCO7X7vO1pFVflgnrhOn2vU1j7jSSOIR7PI1RzvUmFCZNW21o15U93juciEGIEQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724844; c=relaxed/simple;
	bh=H4IWJyTah5nat89FwZvZEQUResXECi17Y9fVTfNu5ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIRVYJVElw9U+ch6QFalWNwZM5Brsbmcv8N7Ukg1vNfSIuY0WN1CAFC4UWZ6ZHvwSagSSzvzYsHvfOENDzEFOWcY0MyDtqBDgULGWcR13f1yeoFKJmH0NFrk8mcZE+es+HDb/dlVx8lAwqhsS6hGwhsK50hon8K4gxHzvLS9kzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D9ZLvaPI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fjyb8e/C; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707724842; x=1739260842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H4IWJyTah5nat89FwZvZEQUResXECi17Y9fVTfNu5ew=;
  b=D9ZLvaPIALdGcQh0DMIAe26j1aefzcaxzyU6FMCA0N59OdulJ/epb9Y4
   2+ZmSITjkWqWMavkFJmnOaRGkp5KnrEk50oB0FqFe+0010pRfebAxUXrT
   /0IhlKciLht9U9nxh8YBiUaF+3uFCOwiQWbTRtAHyS4cu93uQ9noQgxbL
   0GHHTs1aCcO7xpZQBmh5eXigyBzdzqpIrge7nIzBVtgxmmhJXsohEkE/N
   I5/KyDRBC1pwGLl7BxiVELpSkT68ePFQLevjE5MOyagvqy3CUmeHsVcai
   MkKcWgTrpezQudv8TuG9OXXAhQIUMMpAmkc9w6N/H3p5jg/ILQc26NfUo
   A==;
X-CSE-ConnectionGUID: 7lCv9ZrZTZy2x93+3krrGQ==
X-CSE-MsgGUID: SksNO0wJQgeURGuxLDBkvg==
X-IronPort-AV: E=Sophos;i="6.05,262,1701100800"; 
   d="scan'208";a="9593959"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2024 16:00:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKURYgfPu8RtOYbJ7RLBSlRXc4TnP70JJSnoHdKOY7WedIV/4JuI9VquPTz2KV1yX7Ley2NxIiGHK4SVNMXDzVCJRl3ol4SlOBqyc6ReXJ/0QhfDs5XgCbpsHgETErmju2aLXE8Ne1xNbV2DWz8gZaqROtXXy+Bjz7F/y4Jx58bwlqRmZCgchc8x2rGJ4SrUvl9sXNc7JGgkGdFqR4y0kiMWnmuGi1cEL7v3ATPziXXslDFPLRhMNnWeAUYA4Q9cLVx0GR5trjCGYY+8PJCBoGaloejD9xcvrWN5Y4Hj4T9P8JMdVMczobpNWh/kEsUYdE6fgRroR/Rh/Nrwq7rF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4IWJyTah5nat89FwZvZEQUResXECi17Y9fVTfNu5ew=;
 b=A49QnjsrWGC/Tlm8f64iSxBSt/LPtJgQP9U8qUjAL8iIB6uljKiDISrXQOQlfP3hknRDy/E6p7O/A2BASuUICRD4NKAiO9qM8sKxm/0DPkM2nQ9ZTQrOpAeoGN9pLJiyzSFXQueSRhGxOqwmNhHizWghnmnuZUi4zoKsnGvB9jotA6UKMXr88sJFrI5rrrvBTPC+eyJFsPa1ec0363AWS5HzQ25rol6cwC9UrpkA+nmqJz/jS/MCztb5BwWFMOTU1jzToAY2N2XasFdgC+1JKamgk3AbrFE/1TlrMzW0vg9maebwMpkymOZI2JEdjahqiCtMbEToaixKAJuGLFBO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4IWJyTah5nat89FwZvZEQUResXECi17Y9fVTfNu5ew=;
 b=Fjyb8e/CAjy3tsH4M8Ol2erYzATzwaRENy4P7noq/x96FG5gekbTeKwZbTOjTmakmDjmliqL/uwhWEREvdXNnlQCPLjx0iGJaIYoUwCaIg+x0JpBozEhmoCAN0XF9qRusz27Q4/kKfAbtuSVGb5SBD+MGtnYEMWRQ0kgIqoRWh0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6874.namprd04.prod.outlook.com (2603:10b6:5:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 08:00:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 08:00:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Chris Mason
	<clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
	<chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Thread-Topic: [PATCH v3 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Thread-Index: AQHaUoghqeGbsLL+DEOdZDv7LZr+o7EGbgiA
Date: Mon, 12 Feb 2024 08:00:32 +0000
Message-ID: <585d6aa1-4dc2-4c40-a865-82f7cd8ae8f4@wdc.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6874:EE_
x-ms-office365-filtering-correlation-id: c9e63389-2a48-4279-1a8d-08dc2ba0afb3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Yu1F3Ex4nyqnVnOZ08wOh6t7/dmFo9Kz6De/DVF7FLGrTt4glL3sJg4mKT8OSEYCotIIo4DOO1RUd+9HsmULoUfiqXPMR2vhU68myITODs3y4ecREz+tbiOMqiFuhxIsBXVYZGKBogyLbaadn6g8Km6FE08qCVCHqE7nR4HH0OEKjoW0L7p0uY/nCzhzUQWcUW3anUwRr513LOvn0FvFARtCN4Ar18w3Kle8NFilD1tOStffP1NQ8zLiGZy8Lyy9FtJd+JpY5Qb9efKw4czQ2jLqwy6qEeDXCXACrPy8eyJCrszIty6o+kbe92FzBWNUjahCraG6KrfhBWs2TkaewNqo+GzsMFztkGRk+AgtrWjv3/F6AZ3LFMcp8911m2aHxJItscJ48H06XN/O+i2HZp+DmO/4Kjv1etsemKSCClmy7Q1SQeux5YnbHFQabevk4XDZu8CM0zJtwKwh7POXeFx1rH0WUmg0r18oWEdH9OlAU9UeMztWRwFTKLNiiB1TWfWFMI3PdKv49G5+MyP8XxQo1wL9J1g5dj7BImkS+30oUOkfnl9jYi/aEuvbthygiEYxvwub0N3ErO89L5JHD+TUzJHGUwcm6aSzy8hAqJz/RfxRT90z8szq9xG6KD0v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(26005)(71200400001)(2616005)(41300700001)(31696002)(66946007)(5660300002)(66446008)(76116006)(4326008)(7416002)(8936002)(66476007)(2906002)(66556008)(8676002)(64756008)(38070700009)(110136005)(83380400001)(316002)(54906003)(6512007)(6506007)(53546011)(478600001)(6486002)(966005)(82960400001)(86362001)(122000001)(921011)(38100700002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWhVbGpCM0ZCNjVpTWF3TnJURXBOMk1jQnBvck5tT0NFTlZ6cmk1NmJUbXpz?=
 =?utf-8?B?bkx4VmY2RXBnY2ZRSUovK3c1aTZLdVRlN2pzdXorNDBuN255TlNHY1pnME4z?=
 =?utf-8?B?NjN6ZGFocVVLa2RpNFRIclQ3NERDUVpYbjgyNWttWTYyM0o4RkNjODVjbDFM?=
 =?utf-8?B?cEJQTHU3enoyaG5WcW56Wmd2SjV1ZHhvYXR5S3QrKy9naHRDempwR1lSQU5K?=
 =?utf-8?B?R3BMY2FzeXNrZkV1cnI5NEFtdkR5aGdBNldTVzVsZ2tEU1hjemhvWGVIMDRY?=
 =?utf-8?B?dEJxQk8xbGdac1dmVCtDWmZXOTFScWRwUE81UTg0QVQ0V1FGcmlVVmVQeVp5?=
 =?utf-8?B?MGFqSEU3alNXVUt3NFk0U1cwR3Y5RERQZnB1UzhYL2RVeCsvZ2ltYnFNT2Vl?=
 =?utf-8?B?QnJUZzFGUHUwSm5xU2k5cDgwdi9EZThPTG5Va0I3T3MzOVp4WkQycXZFL01p?=
 =?utf-8?B?Tjdadk1PUmtTbitORlRRdDh6VkhLbGJZZnF5NUpDS0gwa29URGxhME5DUTh1?=
 =?utf-8?B?clBXa09HejNCVy9TUThNdkcwVU1wQmhNbjJHeFVWQlhEb01zL2JJSFFvZE1x?=
 =?utf-8?B?YmRYWVdTNXN4Mlo4UndwZnJkNHlyODBFMlhpL1BVMUhxaGNON0xreVVMdFRY?=
 =?utf-8?B?S1dCL2sxdU16WWlheXcrRUF2WVlOa0ZUYm9WSVJOcDdOUVlzTWNOUzFOai9R?=
 =?utf-8?B?aVNqN2tFMDRQYVJSWXIyU1FlbUJVRG1nbm11cERBRmd3QkdCZnlmQU9MV2pJ?=
 =?utf-8?B?R0Y0NWVQRmtMV01iTEQ4R1RvOTBIZTY3VjBDUUNHVmY3eWF2eVZ2YmFXS1B2?=
 =?utf-8?B?THF3d3QxL2gzSGRUZ2tFTjlROFJaYytnUWFJSElIcGNsZHNNSU8xUlkzTitM?=
 =?utf-8?B?L1hqTS9OVHhyOWVWMEtORmxvSWhaTkxLTndPSGg2cDJJaC9vTUZtMUFYUEFJ?=
 =?utf-8?B?elBTa0RQcVBlK1J5eVVjVzlyS20rZ1ZZVXRTRzk3dkg1Q3dxSkszOVlXMGx0?=
 =?utf-8?B?Y0I3b3VEUUI4dmxBNEFxaXlNWXl6aGY2TnYyaVowQ2lBRCsxZlNLcjVSYytw?=
 =?utf-8?B?YmRUSldUMmNLOWFVSEszVCsxVGNnNG50Z0dXTUI2ZTRWQU5uMTFiUFo3Y2VC?=
 =?utf-8?B?SGZhUzJoNllKeFJlbzN5UG1hbzR5NlltYjg0MENuUmg3akRqejF6a1UwSmFR?=
 =?utf-8?B?TVgwME9GS2l1UnY2SVRSU2pESU5WNUVSR3JpZGZ0RVFvSUhWRndXMFc3TWU0?=
 =?utf-8?B?S1JOQzZVU2EyMkVDVERwdkt6SWZIYTVYcGlZK3JYWUJXZnZHQ2pnck01d3B6?=
 =?utf-8?B?V01pbGpHaE4zOVFEN0F6UXlaRzIyNldGc0tGRUd2REV4VlpMT3R1clpmc25i?=
 =?utf-8?B?ckZYWTZYaVN3RHN3QWh4M0FUT3EwUCtkY1Y2S3ZVMEk5UTZSbytOQU1uVTMv?=
 =?utf-8?B?dm82dFdneEYwL2NkRXUwVTNWeHhDaXkvLzRTcEI0Qm16dWFLeStjMHA2Vms0?=
 =?utf-8?B?aGp2VmxLb2MwTmtRbVA2U0hOR1JVak1UMHp1WWNRQXRUcXZoZExOVDlCQk5E?=
 =?utf-8?B?b01mckNXeDQyV3ZGUFpUbWZ4Q0JsZ0trejJvZ3dOb1ZvSkJpZkxRQzVwdGhR?=
 =?utf-8?B?SUZXRzhMQlNud0tmbGVqTkoyNWQ4L2tIZVA2MXVMaXF3SFJEaVdLTVA3QXZO?=
 =?utf-8?B?MUlMWjZtVWVWeG02YWJRLy9LTmdVQ0lmanZFWXNvWWZXdC9OaUlMMVM1N1p2?=
 =?utf-8?B?clRuNzYzdHdocVh2U3pRNDcrOGVFNlVSL2Z0V1ZXaFJvV3pmVHo2YUFhcFNH?=
 =?utf-8?B?d2dZT1o3elJSQjJhc2xsTW41UzF1WXVJUlNkZWNxYnlZclgweVdIQlgybzM5?=
 =?utf-8?B?cUdDazBvQXc5ZmpiNW04dE41MnluTms4MGJFVFdNWUF2enN1NTg2VXB6NFg1?=
 =?utf-8?B?STRzaDJPYXphb1JmbWo3QnhMMHNiQWVBWmpGS1dxTElIdlEzTkV4TGpWL0o0?=
 =?utf-8?B?dWlBUmFDcjFORWhveTM0RzRoZzYzb044S29iZTlmUmhjOFNuRGFQL251YzJK?=
 =?utf-8?B?R1RMcGJqTjgzMmExWG9zb21OYm5CSjNEc1lPV0grQ3JYUEFCNEpXM0I5b0pL?=
 =?utf-8?B?L3FIaTcxWlpwbkYzQ1p0QzIvek9HY0FvaWR0TkRFZWRvUEpkZHM1SG1udWc1?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9779686715CF74E9E5B9412961EE246@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KPLRnsyESXP3g06rh7d/qYpQGudX4ajZx68neAe+f/DVKhPdxMQUOeQK7qLC5Rr3ynNbMUH28xq06loItY1g69+8wF07JephXdlvY0qRPPXM/NE0ZIRJMj71uiKJgFBcht0BZMfZk/Szw4tUgctDlfNu4XWNig/+X1f82oIjVsjGpjT0HjpKEfTNXXR5eSr3gDqYd02wN9eQamHKFG6Hzv9bFo6ij+AQ+DcLGgxNCMgjDo01u0j6s8sah42yz6Nc0nFdwRCiJAiglv3t+ebIyKafleZQpENyfXmTC53LRsvdHThfsLb9ckjnZWkSlVrunkX1Qme6xfqwmB5CIEaugqOyjTeIvyCj9fNfbjL+65qpAPKIxvIte3WSN8WwlyqvDzY0RySUpY0MIbksm+N7C1QGPdytTnAWD0Hsslphg3OE3Dj/kimxbh2STY01fcacIobrjLBLScQt3xPf5P5OGLMHpmo0wkVTawNmvMJYKtx3wank7UtHp+TMEpGVcgG9nyQ0qljQOvX218oTOiPqiwmezA/OWUkLcC/s0z14EfM/L/YrMDaY/Ib9Pi+fLP0gdj424kz0NJI6paTbz9U2KilJpycE99xUriW1zbct0YM+beyq4j1xsWavr5IkfMLq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e63389-2a48-4279-1a8d-08dc2ba0afb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 08:00:32.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzWYk3nl7jtJpikmi/J/y4zhQjtbaSpUTieujyA5CqGCIcaPQo/oH4G9cgyhMr3YpxDi9dSanmXsocilJlTG2mPyHFschRp6bFZczYS/8zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6874

T24gMjkuMDEuMjQgMDg6NTIsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gRnVlbGVkIGJ5
IHRoZSBMU0ZNTSBkaXNjdXNzaW9uIG9uIHJlbW92aW5nIEdGUF9OT0ZTIGluaXRpYXRlZCBieSBX
aWxseSwNCj4gSSd2ZSBsb29rZWQgaW50byB0aGUgc29sZSBHRlBfTk9GUyBhbGxvY2F0aW9uIGlu
IHpvbmVmcy4gQXMgaXQgdHVybmVkIG91dCwNCj4gaXQgaXMgb25seSBkb25lIGZvciB6b25lIG1h
bmFnZW1lbnQgY29tbWFuZHMgYW5kIGNhbiBiZSByZW1vdmVkLg0KPiANCj4gQWZ0ZXIgZGlnZ2lu
ZyBpbnRvIG1vcmUgY2FsbGVycyBvZiBibGtkZXZfem9uZV9tZ210KCkgSSBjYW1lIHRvIHRoZQ0K
PiBjb25jbHVzaW9uIHRoYXQgdGhlIGdmcF9tYXNrIHBhcmFtZXRlciBjYW4gYmUgcmVtb3ZlZCBh
bGx0b2dldGhlci4NCj4gDQo+IFNvIHRoaXMgc2VyaWVzIHN3aXRjaGVzIGFsbCBjYWxsZXJzIG9m
IGJsa2Rldl96b25lX21nbXQoKSB0byBlaXRoZXIgdXNlDQo+IEdGUF9LRVJORUwgd2hlcmUgcG9z
c2libGUgb3IgZ3JhYiBhIG1lbWFsbG9jX25ve2ZzLGlvfSBjb250ZXh0Lg0KPiANCj4gVGhlIGZp
bmFsIHBhdGNoIGluIHRoaXMgc2VyaWVzIGlzIGdldHRpbmcgcmlkIG9mIHRoZSBnZnBfbWFzayBw
YXJhbWV0ZXIuDQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWlpjZ1hJ
NDZBaW5sY0JEUEBjYXNwZXIuaW5mcmFkZWFkLm9yZy8NCj4gDQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYzOg0KPiAtIEZpeCBidWlsZCBlcnJvciBhZnRlciByZWJhc2UgaW4gZG0tem9uZWQtbWV0YWRh
dGEuYw0KPiAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMjUt
em9uZWZzX25vZnMtdjItMC0yZDk3NWM4YzE2OTBAd2RjLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2
MjoNCj4gLSBndWFyZCBibGtkZXZfem9uZV9tZ210IGluIGRtLXpvbmVkLW1ldGFkYXRhLmMgd2l0
aCBtZW1hbGxvY19ub2lvIGNvbnRleHQNCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjQwMTIzLXpvbmVmc19ub2ZzLXYxLTAtY2MwYjAzMDhlZjI1QHdkYy5jb20N
Cj4gDQo+IC0tLQ0KPiBKb2hhbm5lcyBUaHVtc2hpcm4gKDUpOg0KPiAgICAgICAgem9uZWZzOiBw
YXNzIEdGUF9LRVJORUwgdG8gYmxrZGV2X3pvbmVfbWdtdCgpIGNhbGwNCj4gICAgICAgIGRtOiBk
bS16b25lZDogZ3VhcmQgYmxrZGV2X3pvbmVfbWdtdCB3aXRoIG5vaW8gc2NvcGUNCj4gICAgICAg
IGJ0cmZzOiB6b25lZDogY2FsbCBibGtkZXZfem9uZV9tZ210IGluIG5vZnMgc2NvcGUNCj4gICAg
ICAgIGYyZnM6IGd1YXJkIGJsa2Rldl96b25lX21nbXQgd2l0aCBub2ZzIHNjb3BlDQo+ICAgICAg
ICBibG9jazogcmVtb3ZlIGdmcF9mbGFncyBmcm9tIGJsa2Rldl96b25lX21nbXQNCj4gDQo+ICAg
YmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgIHwgMTkgKysrKysrKystLS0tLS0tLS0tLQ0K
PiAgIGRyaXZlcnMvbWQvZG0tem9uZWQtbWV0YWRhdGEuYyB8ICA1ICsrKystDQo+ICAgZHJpdmVy
cy9udm1lL3RhcmdldC96bnMuYyAgICAgIHwgIDUgKystLS0NCj4gICBmcy9idHJmcy96b25lZC5j
ICAgICAgICAgICAgICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0K
PiAgIGZzL2YyZnMvc2VnbWVudC5jICAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKy0tLQ0K
PiAgIGZzL3pvbmVmcy9zdXBlci5jICAgICAgICAgICAgICB8ICAyICstDQo+ICAgaW5jbHVkZS9s
aW51eC9ibGtkZXYuaCAgICAgICAgIHwgIDIgKy0NCj4gICA3IGZpbGVzIGNoYW5nZWQsIDUzIGlu
c2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDYxNWQz
MDA2NDg4NjljNzc0YmQxZmU1NGI0NjI3YmIwYzIwZmFlZDQNCj4gY2hhbmdlLWlkOiAyMDI0MDEx
MC16b25lZnNfbm9mcy1kZDFlMjJiMmUwNDYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0KSGkgSmVu
cywNCg0Kbm93IHRoYXQgZXZlcnkgcGF0Y2ggaXMgcmV2aWV3ZWQsIGNhbiB5b3UgcXVldWUgdGhp
cyBzZXJpZXMgcGxlYXNlPw0KDQpUaGFua3MsDQpKb2hhbm5lcw0K

