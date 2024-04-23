Return-Path: <linux-fsdevel+bounces-17505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F48AE606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578B02833C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C4129E9A;
	Tue, 23 Apr 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L9brbfHf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P2cnzsmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F5128834;
	Tue, 23 Apr 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875215; cv=fail; b=BYJ97naemIdQXAm/uFjhS40MZYtfpMc11XocXb6k1xl9BiMzTopRXPDNQ+by1z/Fb9NJgFlVvHpEnYkfpHpzp0bKfMSFUPeK8gQcXRIjZ0gaCXksECbuDuju0/Wq4BiV6UJL1rGL1gZx72j31HJtKIPuQ+wtw/OkT4UjOqRH6Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875215; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=siwH6FKRhoS+fumpo8QrWwJhgoOWMuMdtol1z1IfkblLhwGp32PydagT4J+ypEnTR6xiewiDsHFpCVCG0uxxpmfitDI11yUaf5Pb/r/WnOFdOTNDf73EaqXmE7zg3jAkojNTXhBdgtoyX59Y829qH+5rAn2+BN6r0bbsGqFJ9Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L9brbfHf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P2cnzsmH; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713875213; x=1745411213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=L9brbfHfQcWDhnTqfY9o1ZFbh3qo8d0qwvjrCAn+nux3gTdTySw12p+f
   NIuFgDB04ekc89rsJUFfO7Bc1e9FteeDkRh40bdeSJW3Tg63o1qG5wSk6
   HLHIrF1RmZuTvJU17OAj22LEI8q6AJME/jPvojs2keU5656aS2A1ySjHp
   RxvHNcDv1y9DRJXreOOXcfp09h4oQcIlaO6trADHUjTBS0ckS3aILj3W0
   s/vBG5Uro2WxvpHFhVQTEjcLij/uyq1LtsGugZbSbrJnNNuhWrf3GkEGf
   y2okfzwlgoScTwJqA9hSQxajRArp22SpjaNI5gdIFuLGJlQ26Ml1qu65j
   Q==;
X-CSE-ConnectionGUID: TvQfAGvTTjmA/wogtFq9xg==
X-CSE-MsgGUID: 0pMBGqB/RLeWmQmDf4ooYg==
X-IronPort-AV: E=Sophos;i="6.07,222,1708358400"; 
   d="scan'208";a="14655120"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2024 20:26:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlQcdCsLsEEQ3arMTDQXkm9SDerSckbKIVLdHsslUqADckKu7VJYIbV7ZrOzl9N9pOO0xeysBmYSaD3hJy6vUXXlCA7iCBXXm+dYu03uh5Pg5wEqBKawBnJqDsma6l6QoLS49YPZR25ylrKg9qQEHsG37it+oGCtZdsLzU33cnyoX0aPbb7bFq40kC7c9BVwnTBvyZ4D+nMOAhbEmRY7r6TLWo3tvzn7v/dDWbTLcFRZc8ucyeH5MMIZJb310Yrqeq381UOaR335UfEdWMG++BVTn5kKz8jDAMtilWHwykZhOQgZagzQbzDjnCq066nH9Z0MXC1L2xJExmfudiuNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZLFyuGhXL9wXfOowuG3AVsg82FJCKsgXajCtZsOVk5txzwS88/yXVHI+7bwMEelhNEy4ts6yS0TM2LhlPrqCZMKG7osG+j2gmiGUCXspsBWP7KnHf+a7UKCSKMhNhhWRuMNXSHZsaNScltwu8DStsaChQpH0GBeB+TpG1GrIH1OAHvXwkuDV84lQnQY2nPUzJsNpkJkcCYrt2cPkybJbGfxnxlWsAePj0HO52G7OJ6ZmxAuhxTMD3xeMITtRkFbkeObGMHBmdFIMvhwKw09tA38c4qcDqunNjZFeIILxXYXP3ugFJK/U2Nf7NccyGZoYBmlju3zjDjzO0RbFULlavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=P2cnzsmH/n9pSQ3AEPFcOYXoIJcYaf5aoAAoGfjVdi5UqJoaCD6BfKpjvBuxeKAlWxriq8NyP/sCQoo84MWiQOh1ADpyqDIgw/ykty5H1L+IkIV2+fSCYrxEKQRrmvtg1zwls9+4O7qKPdmZ/avi+nDfWzqD8YGRhAdbxwvX2K8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6983.namprd04.prod.outlook.com (2603:10b6:610:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:26:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 12:26:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/30] btrfs: Use the folio iterator in
 btrfs_end_super_write()
Thread-Topic: [PATCH 03/30] btrfs: Use the folio iterator in
 btrfs_end_super_write()
Thread-Index: AQHaks2rkpocBLYhQUWwmVQffRIgbLF1zWwA
Date: Tue, 23 Apr 2024 12:26:50 +0000
Message-ID: <414b694b-d3ff-43a5-a997-6efd2596d52b@wdc.com>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-4-willy@infradead.org>
In-Reply-To: <20240420025029.2166544-4-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6983:EE_
x-ms-office365-filtering-correlation-id: eac86d75-3b33-439e-7cae-08dc6390a6c1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Smc1Tk9ZYW9KQ3F6ekIwMVdVaEU5ZncrMHY5TkhzWjR6ZmJ1bnJGalI5MFUr?=
 =?utf-8?B?SkVUNDBiaFNDSmFWSjZpSjliVllCY3JoK2FxVHJTbFZzZ016UlExb2R1OEtJ?=
 =?utf-8?B?akVoTkpkdXpvL1FSOVhBWXhsdXJrU1RQanZpdUVzcmhXZXZzNDVUN0hLMUZK?=
 =?utf-8?B?TnorNlVWd1NQdS9VY0I5aU11dzhGdk5udmErNXNBMmtHK2FzdDF3emI0RFE2?=
 =?utf-8?B?MjR3ZWIxcG44Vko0c1d2K0dIZm5pYzV6Zm5mdnl2TEQ5YUhieE5QQ00yWWRJ?=
 =?utf-8?B?M2xVV3NWQll2d0MxNXBaeXliMjRETmw1RkVBanU5U1UzWTJKN0hPTkhydEt5?=
 =?utf-8?B?bndVL0NKMjRSRmt4NmtpcDc5c1cyN2ZvWDlqVEordVA2ck9kNmR0MTZHMFF6?=
 =?utf-8?B?UHFNWUFaZUNmWFh6U1hEcHZCeitqeGg5L1RwcEZ6ZmpWaVE1OXV5a3NSWXBq?=
 =?utf-8?B?aWlDU0FJQTFNa1lDaEpYMFBRQkVON2hIc3VyeGpQSGZ1VUVvKytaS3c5d1Nh?=
 =?utf-8?B?b3dNQllpMDJYaWhoejl2R1BHbzFXMzQxREFkQnYrRitYRzhJSjlxNXVpaVli?=
 =?utf-8?B?NVhrNE9vUkhRaXFCNiszZktKWGthY3FPSngxQVVrbEE5RFRuYmNORW9xUmlT?=
 =?utf-8?B?elRxYkxQcUF0OVRBR1lvVmZkaEZLWktkSEJsM2YzeGhJY2lXRzFCdXhVaUds?=
 =?utf-8?B?eGN2RGl3a2RERS9nU1poYkNUQ2FGeXJpN2N2L08xMDlZVTdlc2FvbnBwYk1X?=
 =?utf-8?B?QnBML0dpemM5OXFTalVObFh5R1Z2QVNLT09sVGNkQ0tWbXZzRURCRFZNR0Fs?=
 =?utf-8?B?c1ZGUzhIb3B5MzdEVHpNdkpiUjFMTStIRzZjS2hmSmh3ZW9rYzlteVpvcW9G?=
 =?utf-8?B?WW1OZmFOU0JuTmh3RDUyd0ZnQ1ZRa1hqY1FPQVRzaGRqRUNWTE1oczZleGVF?=
 =?utf-8?B?UkJZQ1JaaGZWS3Q1VUsrSGNMdk10ZlpFVzB3NDlQVjFONm5CTDV6ODU0TDI0?=
 =?utf-8?B?d096RjNGbm5GNHBJWGc2WjBMN1BjRjFaMERyZWhxUnE1SEdnTUJpTEdsanhz?=
 =?utf-8?B?ZTFaQll3dGlObk9mbG4rU3hBT0RIVWI2ZjVDeGpkeUszMEpkUlE3eXZjZDF4?=
 =?utf-8?B?RWtxU3haRnR2TVQxWnRWdVNIODlydkRDcGs4UVhWbG0ybDdjemZ5azBEV1A1?=
 =?utf-8?B?S3kxTmFnY2pOSTIyc2JTRGRkMzRabWJpOG9qZUtpaDg2SFhGb29VOGhJNzhv?=
 =?utf-8?B?N0xpME5LTWkzQjVLVDdFaFFRbE1oTytwOHlDcWwwOUluU2RpdG10MHlYT0FG?=
 =?utf-8?B?bVo3QStEd28rSGFnQ25jeFdpSzd3bnVld3QvczkxZlFySThETjF1SDVsaEgy?=
 =?utf-8?B?VzZxYUpicm1vN3V5ZHFQbkI1VEhoN3Z1ckE3MVhzNytKNzQ2RURtZmxsaWtM?=
 =?utf-8?B?bTBKSDBwNzg1VXByMUpvaElRYjdRVDZscTZKMDduRzZYYXlnMGM5aWEreHZr?=
 =?utf-8?B?ak44L1dyNEdSVjMycGJDRVFDc2Q1ODA2RHdIQzRJeks3K0JTbkFPajMyalhF?=
 =?utf-8?B?cEszR3VLTFRsVGR6V3BkWUpoYWIvbEx4WEtCNWQ4dDNnN29NQjV6T0kzMzFI?=
 =?utf-8?B?b2Nnc1VKd01NUlFDblNxS3k0VE90ZHA0djJYaGtEZ2RvbzFyZHlBNFljdlN2?=
 =?utf-8?B?WXVCS3M1S2VEcW9iYWVkT245ZElvaHNKZWZJRkxpOFo4dCtLTkNIMUtvOEIv?=
 =?utf-8?B?QUJxZE51NEZQcFlzVWVTa0Y2dzVieDQvUVJKdUtGT2xZSmxNdkZoQ0dwQUMr?=
 =?utf-8?B?MTYxWmEzZlZ6dTNWNUozUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djBYZ29laDQxN2g2VWZmTmhrQXMyaWwvMEpVWUxSYldWUm1xd3Y4ODlxMWlW?=
 =?utf-8?B?VDUzRjNrdk52bXMrVmhOajJlaUxETTlSNVZSaGcyS3lwWHNGMXROUFdNT3Mz?=
 =?utf-8?B?bHBLMFUzZ0k5eklrLytiWEdxYjROOEkweHk3ZDQ4QWxXMERIZWJJcUphRW9T?=
 =?utf-8?B?MkNORStnTi9naklvNUVXUisreExNakhjMitJNEQwd2QvYXI3QnM2Q2JLejJi?=
 =?utf-8?B?cUFwQzU1TjJEZlNaL0JPOVlHVmgrZWhPNkpiRWlqbUdPcjdxWFlkNGxSc3hu?=
 =?utf-8?B?d3RCZjZUV3lMcUJiUHRoVXZjbFZLN1VUeFZlWnBvd1hhenFyNjZpQ1ZHMjg3?=
 =?utf-8?B?QlJYYjdnYXoxeit3czZDQUF3Y1YrQnYvb3EyempPd1pCcHZ4MkhyY3lwN1FB?=
 =?utf-8?B?aHVVcnc2VXErTjBhN1owSkRDNTVHbWIrc0FHaFI1SjhKY3kxa1hBNlJabHVH?=
 =?utf-8?B?Z3NmcFRRU0U2bGkrZ0lvbjVlWDdLVU8yQUwyMjFUenZHOWJkUFJKa3pYUXlq?=
 =?utf-8?B?T0hxeW50aEhzLzJlV1RTdU1jVWpoZzNZYm5ySSttdkJlRlJKVnJTMkxQN1hs?=
 =?utf-8?B?Y20wTTBLVzJqSFowR292TVpDZVJ2eUx0OENsUCtBNENxVnFEY3dHc1RuSmMv?=
 =?utf-8?B?a3AreC9QNWM3Y1pjbHlMdHhXbDBYL3ZPaVA5V2NiRWcrRUJJcFE1eE1HRzcx?=
 =?utf-8?B?di9qSC9QUXJGL3dvTmtiUWZlMDVHb0RVNERWZmJNKzhOYUpZTG5wR2M5UjRH?=
 =?utf-8?B?dDQ3QXlpbU5CNlZEYnhCRVJ4akRIbGhMeG5WOE1xaExDTms0dThodHNuZVRS?=
 =?utf-8?B?Q2FvRFAvQVBPZFJQNVNOMExmSlNJUStEWGc2dG1yMHNKUGhhUmJPVzBBV2pU?=
 =?utf-8?B?cXpiOHZXNFVNVWpCbURoelZOcDUrL3k5aDVkNkU5M0J2cDd5RnV4cjR2OG9V?=
 =?utf-8?B?RXFyZkM1cFlDa0FDNS9HWHhmUTJDV1JrTmUxTTE3aXFkQWJnbHZMZk5mS0tj?=
 =?utf-8?B?a0R3ZCtUdk5RT0MxdWJWSkZSNXVnc1VGeFhaR2xvb2tVVkhQU0dUQ3IyMmd2?=
 =?utf-8?B?anY5NitxNHJWeEF3NlpxQzJlNnBpMDVycThNWERrMEovTGN0OGFHWkt0RFRx?=
 =?utf-8?B?QTFNOEpaVmhiZGtOcHFtanJEVlJtQnpuTVR0cEUvS1JtM3RuTE9jN0JqSVI3?=
 =?utf-8?B?VWlVejRVbUlIRTNKUTNEZzBNU09MRGh2ZTNNMnczRCt6dkphOFpRbFh0U3Rs?=
 =?utf-8?B?VnRVSmo3MXBKZGNrYm1raDhBeTNQbGJrdDhsMVhKRkc4dTgvT2xnOWRwTFhG?=
 =?utf-8?B?ZUdtQ0RhNkMzSHVMUWdlNll1ZVg2aGhYQ0xxN0pOekEzcjQzbFdXMWRGaFRH?=
 =?utf-8?B?V0VGUnowNXl1bHRac0F6S2x0M3h1WVRPSk4vZlJQSGYvVFB4Qk02STBRSDVH?=
 =?utf-8?B?a1pEaEZIS25DQk8rRmtEU3V3Wk5WQ25idXA2SDJaTlk3a01BODhIZXVZY2o3?=
 =?utf-8?B?UzBkYWlKS0RKR2dVRDJqdnJUd0FpYW9FbnhuZTVQdEdRTER3MVRYZER1cGt6?=
 =?utf-8?B?TnV6ZDVJMDVkU2p3dWFtZ0RwVnF3Z1ZrTlBkbE5meEM5eVdZSWpZMytZdUdS?=
 =?utf-8?B?bEg4WTRCdnpLQkhoaitzTUdyenlHaHhjZWZQRFhqcCtlR3JZa1paOXFKY21x?=
 =?utf-8?B?YmlKWm1GRFpNYVZRY1cyRXFreDJDUkdJUlZBdWM3elRGWS9qdE0rV0lZYkZa?=
 =?utf-8?B?L0d6enAzK3F6VDlPc2xIOVNBaU1NUWMvZkVCMEIyTGRBdHhvRkxRa0pSMm0z?=
 =?utf-8?B?dk5rNGVxZnlydXV4UWhUSU5vV2ZRVjJURllTT244MnJxMWgyOWZhVUNUb09l?=
 =?utf-8?B?YUI5bFJuRVRjN1hiL2lJWUJJK3dzWVVxaVc4VUJpQjdZZVoyWHkwcklsZjFX?=
 =?utf-8?B?UHI4U3dML2JOL3h4blBHNWlZRmgvZm5wM1d6N2N5ejJBU25SUmtKQ092RXFS?=
 =?utf-8?B?VHJCNWVqeURTTlYvOWJ6Tm9Gbk5qZ3krcm81b01Sb0M4V25PSFBaeWE4Vmky?=
 =?utf-8?B?THkwcHA3K1FkWjhqdmNyRElZY0h5bE55VE43ai93UTlJTFZ6MUJjS1V1cXNV?=
 =?utf-8?B?Z2lKbkllZzB5TnR4WExOUFordzRrUFBqN01BRUJYZjRFeDBBTWQyL2pBNDY3?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15D246ACE3FC234EBB3CA3EB7DB44652@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f865HCy7KenJyMLRWKd+puTgvUYfNtVhx0BRpeEf9IAZzatXlH4VvhxOGAeAyy3dhiFx7D+j4mrYin3qbmACNBTkpbz83OuUnBt7ahkzvpYyqGI3eDW/wc8pQ1uNYxPq9P/Ndes2uBgUxb7EEDc5QyEgN/tUT71LRY6722aqIToaUk0XuieIi+z9gXIo5BiY6fkQSSxbeNq1M4tBVKJY96v6u4aYxXChZtw6/DkWhhq3DdqYylnzMEE4EyFUA7LXKfaaWWTLJUH0O1eZ2Ba+26RmOXCnluamhw/lpWEzGsj4Y0UP43khGCL6FhJzR6lyaAMxAUgBzj3qjp4XJU81BynSbPfMtvHnSLRPQz7t/t07J+qim/8SMY/gCMx9W5ws4jEvBUdymVFWBHNHA4tB7WjUsi+WcLHsaF8ACOahxnNrTDRMRSuTO5I2ptE+0qgUDr1o0dFo771RI1CGATBew9G7xzd0hqg5T8BrKpaucFD0Rrq0OmV/waX+cQ62RT+Rnlfft5ZtwgKhCKimD26Exp+oqdKbWtp/GVLGkycHW9tkK70BkKOPX+8S0gUHlIRG4uhMsgrk00cIEP5WUR+8t2M9TOuDc0f4inZ+q0RedQeu4m8B4/BDDn8ieuyNewbN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac86d75-3b33-439e-7cae-08dc6390a6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 12:26:50.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVY6OnBM+uaS8x6D6nsvSOgvKsTZ1eE95LjC14wreU4e+2CURvCMnxXneDokMmotZfd5q0iklDZ3XxqvcIPKL4gILo0TXoi53ydCoN9JrSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6983

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

