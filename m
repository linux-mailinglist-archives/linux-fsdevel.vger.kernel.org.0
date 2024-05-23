Return-Path: <linux-fsdevel+bounces-20041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBF8CCFB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 11:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C111F23611
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A223513D523;
	Thu, 23 May 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gnsOhkBr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CO+HE9g7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9413D51A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458052; cv=fail; b=Dw12/6TEIJg4pT3E0eepK0SIf0FViMZHAqZ5EY5nZYeI43xT3BE6NNuH68+xSCC9Byq188873sH5sXWqprN7Xp0mAt43EgfhXM0nlJ4fLGTlHZpUesF1trMQ8ZYeEVvwQHlDRqgHM7FQnEmI/97OCa9+QcRiggTjfrMBwkC0lE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458052; c=relaxed/simple;
	bh=QRDS0OZ7dKEARaYaTPq25kOwOFSbfMiIpigfeEM/O0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/arq0caHiLZYQwaMfl3qtGB+PkBLcMepjsWmUN0ZqsZnYF+6x98UxgJ/7sl0c0mNcbX1PgrFMU2HJcdZKDdMo6BFHOVdHLZoGsRdfz+Lf6W2ZxeyrLCfYdlJ9IeHJ1BdMwPEYB3NFFbqIZ2DHjHn43KcXeJXmKQ65UDfCvPovs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gnsOhkBr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CO+HE9g7; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716458050; x=1747994050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QRDS0OZ7dKEARaYaTPq25kOwOFSbfMiIpigfeEM/O0M=;
  b=gnsOhkBrzBvRJD+I/HKGbFpnZGKypbISKx3b4o5lY/zZOBkujJIhafys
   K6hxzYsOcHCXP4BE4XuDNyZvvXDaqwGU3N2HfJcMLeLOvUK2Pbylm+a9y
   sVe9n6O8ZnP2b3GP7dNdssfhMaAJlOlSJQeG4cSOvPFJw5YOQ7afU4i85
   llpWOi6Si/ZVt0A0hVloL3L5Qk5reCT2WuUt1CQNDRNA6q8DY5y5LvmOH
   P3qBgX4k8z+WECV1ut1IfX27Egh9tN0aVl24AHdC38X3Yydma0IIb6Wvr
   IqpAFpyZcSRaeot6Mz0sBXNHIIZzRMRzwkEQkyervge2L7l0u2KTyKP+z
   g==;
X-CSE-ConnectionGUID: kEd3kJm6TSy6ff2GNrKHYg==
X-CSE-MsgGUID: pJrjXitpScKGg5YgcmG0NQ==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="17891534"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 17:54:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAmgc5GjUHhgOua/jQZRDS5WCxU+RChnzlnVf84qLcA4l3A8ZJS1B1lwyFX2In9VzTBvTgLFx7MWbvU81xZt3jvvTV3bgHAul1B87DPU4h4yOOTPe1i9UWQAKjVktO0XckUNJasDc74SFJqIFuoGfys/ibRoyG4+iTiOVZmL6bY7ZGjZeW7DbnmC2j4gx6+S6dcyScO0jPkmKFnD7IY4O5qFKkXP5wL1eErpgo20P/8CQbTbGQQ9zwRtqV9bFJgPi2JFIfSucPBufNxHkVoalDeBELMuVIN17z0YXvhsvYTgMXBYUuLrebZ/uwiqCPjjIhN7gtz0N0eXwZdm+bu/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRDS0OZ7dKEARaYaTPq25kOwOFSbfMiIpigfeEM/O0M=;
 b=ZYKrCuQgQrILki862jedxtMb7BCIkdfjJqccmOvtlCZyVPtwXqjIlKVH0C6BN55HYh/rO/97iiSkkGo3oRlmhNj81k9iFg+jUq0Ta7NUU/qMiL/ErUn8XLuQRcaWVDuQaGwNwLSLKzC16SG6uCJ6tFr8vngz+QK/JC23X6+7hD/o51qJoafRdayLDAV1H5dk0TDVdT0NA71pm2fYKFwLBPfwdKbpN2YJXoKHGaEB+BokaaThblFIsGCL2oy512MaKfcFlwOwlThi6ezOmGNH37TSCCzaeGz99NrQdAyJ4JlXQdJZYpS+7o/C2tBOZFyQf7tb7NL5aBROoXPIWuM+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRDS0OZ7dKEARaYaTPq25kOwOFSbfMiIpigfeEM/O0M=;
 b=CO+HE9g79BvQfcZOf0V+ieiZfBNnm2YGFDLGGrrv+fX3dLlwmPNRdCR3e5nS2pIIv061z5x9zIQ2W90Wx/y6dYtG0QfBZ5xCq7H/uZ9oYoHSTH/iAlVbcOljgL1ZD7HUYKvoWwU5aSEv7749oEJZDFleW8XQjywj0SIBrnsoX/Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7769.namprd04.prod.outlook.com (2603:10b6:510:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:54:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 09:54:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Matthew Wilcox <willy@infradead.org>, Johannes Thumshirn <jth@kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Thread-Topic: [PATCH] zonefs: move super block reading from page to folio
Thread-Index: AQHaphKEay3/HRu5skyKH+AXaWfCPLGkGJ+AgACJgQA=
Date: Thu, 23 May 2024 09:54:00 +0000
Message-ID: <7839c762-3e2e-4124-a42f-6c15f3d8fea4@wdc.com>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
In-Reply-To: <Zk6e30EMxz_8LbW6@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7769:EE_
x-ms-office365-filtering-correlation-id: 0c7a966b-62b6-45da-8077-08dc7b0e4581
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmRFaDBRSmNRRjZMdjRKaFdiczJmdHhxSzNxTm5TRGNZcjcwSXBiRFh4TFJz?=
 =?utf-8?B?WFRjaGlqWkU5OUpvOWY5Q0tmNklDakNLdXRnZ3hXM3JxZzBWQmZFZ25xdjNZ?=
 =?utf-8?B?czRDUUxQNTBlR0NUQWdBTWdiT2JQVmZlMnNzSGw0S09IK2tTYVI0RkVsOTdl?=
 =?utf-8?B?d1B5aERMVTlGRW95czA1OWFhdUJEWEErQlNrSktjSVlYb1dHamNqYUJFL2Fh?=
 =?utf-8?B?K3ZHaFZrTHFWek11ZEVkbTdwbXY2bmxJc2VvOUpJZWJKQmFTOFJWVG4rTy80?=
 =?utf-8?B?TXQ2a01KdVU2VG1mZnF0aVlXeUxvSWwrWFBKLzN5QVRxVkh3S2pnSDB4M0dy?=
 =?utf-8?B?bUZ0WHg0UkcvanFqZy80cGxGeStJcHRGeUkyWXFGTEJnTEQrNE5jb0ErMUl4?=
 =?utf-8?B?ZVZZaU9ZZEhMb05qRkRZcXMwR1NTMS9La1AzemZJNklhZ003TWJ2V2s0RnE3?=
 =?utf-8?B?MHJXL2xYdHhCaUxMdHVSZDFud2x5TE5wQTExS3YvK2tXQUJSY2VsTTRpMGlB?=
 =?utf-8?B?YXdIeXFGNjdIMkFYelZLYmdMMi9YOFRIVGh4QkFjMlVVdkY3UllBMHJWaVk1?=
 =?utf-8?B?aXlsWVlQNDdEWUdZUnBsWXptMDBPcjFDdWZkYW1McnZCSTE3SzRPdFlmZ1E0?=
 =?utf-8?B?eExnbjJkaGVUY3loS3pxaFd4T0Y3ci9HbXk3M01HRzJQb2R0Z3owK3M3c0g4?=
 =?utf-8?B?SW5nN2Z1VjN6UWxHanVvOUdnMnlReVY0VjgvZ25Iam5JQ2tnUVR0dUVteTM2?=
 =?utf-8?B?REJ0M2JIWjVqRkc5NXhIZlpaeDJ3elo0M0FVUDZHNVJjZTQ2ZlNLazlvM0ZX?=
 =?utf-8?B?ZHppdVBaWThSUlhTQVp0bmJjQkl0OEpLMTBIRmlQYU9sMjdiL0o5SnpHS0hs?=
 =?utf-8?B?MEY4QVlrbEl5VVBXSVllTmR4RGVIaWFvZkQxYnBML3lXWXFHb2lCTWhCTW5t?=
 =?utf-8?B?Nlc3VEVESXF1MjMxT3RNRHFYVFpFNFVNNjMybDFCSEV3K0Y0elJ4Vi9DMFBT?=
 =?utf-8?B?ZzFkblRtaFVCUUtHakczcm5ULytHMm82bDc4VjlrUGpYWWMra016YTFNY25P?=
 =?utf-8?B?WnNMVnBvcy9JTEN2cmtWV29JeHFMNEVFWWxHRmZib3A2NjZBUEVpZ1BqZXVy?=
 =?utf-8?B?bTRIdE54ZjFlZGl1bkZjcG93aTJYRDhGd1d2YVphN29FWmk2b09iMTBHcW5L?=
 =?utf-8?B?akNqaXhDdGZFOTg5SW5USmcxZUw5bldCN2NiT2hFMVpyTjQxdWNiWUhsSWFs?=
 =?utf-8?B?WDZwS01mTDJ0ci94YjJ5ZlVoZ3FRUVdHVTAyempqMDNuT3l4TWxHQ3k0MFZl?=
 =?utf-8?B?czlXalErRDVIbUdXT1hsMGRESTJ0SkROZjZNRnkzTjZTa1E5V1BrbmxYVThq?=
 =?utf-8?B?TjFvbWlib1RJRTRjZ0FJUjFXODdodllzL1h6YUtoWkRkOU9XMzlFRXlmVkt0?=
 =?utf-8?B?ZmhVeERhVkhkNE9raXB1U0ZBYkhYTm9oRTlJM0N6L2o4RlpQZGFnVWZQOEo5?=
 =?utf-8?B?bFRoa0tVaDJMRDFEWFZQZ3hzdnJPeEtwOHoxZ3lvdEhxOVFXM1BZeEJLOU9B?=
 =?utf-8?B?cDZ3bVJMTzdSbGJEM0Y5NjB0Kzhrekp2YmE2dWNKLzRJbVFLY1JIYXZ4N1lo?=
 =?utf-8?B?Y3BpMmM1Q3ZaWFBkanl3NTZtUzI0VklOYXEzOUhyeWZ5WGhuZGdyRjJ1cFZi?=
 =?utf-8?B?N093eW1xQmQ0aEdsRGRzMW8wemV6eGpuZDFDby9rRUJZN0JnK1Q1Z0Ztb1Uw?=
 =?utf-8?B?a28rQ2tNVEIraFFYSXo0Q2hsNkdxNVVCWFdLRjNQTGNYQzlHQSt5UkNadE10?=
 =?utf-8?B?cFVDbFdNcDhSL29mUG9PZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkR1ckFjWTRGbkhtb2tLdDFQNVZLTEovZ21qV1BDWExRMWdSWHBYMDdPamVw?=
 =?utf-8?B?ZlpVclVWT2RCYXRtTEhIelJlZ3djVmEwVFlFM0VjcWRvYmFuUnFqaXMvVXZZ?=
 =?utf-8?B?dkcrZXhxUlNScnUza2IzWTQ4VWRBOVlac2N1d0xYZXFzWHFsMUpZclFVWGpv?=
 =?utf-8?B?Tldtb2M5YkJlbEJpd0d2Q1lRVWZMSmhRSXJsZERLUy9nWWM5YUozaG01YWxH?=
 =?utf-8?B?Mmloa3JuOGgwRGNmTitTYU9vTEg3NmJiTVlxV1NRSXNIVVRoVXRleGV4UzF5?=
 =?utf-8?B?V1V5RnlhSFRlUlJTam9kd0d1ejdXZ01wOTdLemk5YmphS1ZrRWZvN2VlYisz?=
 =?utf-8?B?SVhtOXRtakhranNwclF1NkJIWTU5K0JkSGRjNHV3d1I0Vm1oektGTFpMQ3J5?=
 =?utf-8?B?K0JvM1ZzenBKQVgwWmpDeU1nOWRQelhvVVlYcFAwMTY1S25TL0xJMUlHTVB6?=
 =?utf-8?B?WnpjL1luUE9wY1pLSXhrNitjbXRMemV0V2pZdmI4ODRhbENYS3g0Ty9odStF?=
 =?utf-8?B?SHRqS0FNN0FWT29jUlF2eWord0xDYTFDVm1DZGNCZWd5QmViRHVBNzFTUGoy?=
 =?utf-8?B?Y2g3ekxxU1ZsVXdzSnA0eDJuYWwzd2FBdFhLekJCTEJzcmpjMU9kRHNxVzRX?=
 =?utf-8?B?bDZ3TlhFMDQweks1aVJUNjlGK0JlR2hIR1hRUW5hM3ZUb3R2WmlQZVl1VkVr?=
 =?utf-8?B?NU9CZXhicXQ4NjdaVnU0Q2VoL1BqZ3lFQkdITHNqKzlxY1RVMlFwTzNaVEpM?=
 =?utf-8?B?ZDY0WTNDSkJhNWk2NXQxZi9LZmRJVkxtMXBCazRyVEtkbnpVOVMyQVBMRVFR?=
 =?utf-8?B?aVA0ZnplZUFiUFNZbWMwMFRoR052NXdMVTU1VHp0eXQvSERpSm8wc245eE9m?=
 =?utf-8?B?SkEvb2xoTzdpUk1MZ05nSTFHUjJnT3lUMTBnSE9uKzh6MkwxVWpYQ3JCSE1D?=
 =?utf-8?B?czFyODhtYXRiNHdrOG12ckVMb241QnJ4RUFZZ3pNYTFjcjh4RGtYbi8yQ3F1?=
 =?utf-8?B?QmlyWm9jMHI4dzdnV1dvWmFLOFh2a21oazVCYlBvZnM4QlJDMU42ZkFEQ1lM?=
 =?utf-8?B?VjFiOVRVU0hpMVhpTG4yeitMaE1jMHFIVkoyZUY0alkzL3RoaHlvWFVsRTBG?=
 =?utf-8?B?MitNQ2VyQXI0ZEhCWCtvWkJpSmdYdXJldm1TcXl5eVNhRGpubVRYQmFrS0ln?=
 =?utf-8?B?OENpWVRnL0xIVEh6eWltb0FFNmxCcDhTOHFMd1lCTmVxd2RzSmlmU3hGSlNR?=
 =?utf-8?B?dW5ZYjMxTkJWSTFPc3RNc3hBNGduWkoyU05VMjJzUkRjck5KZnpoeDVjTzAx?=
 =?utf-8?B?M3lCaE12ZURnRnNzc1NBYUdmektGem1vZkxiZnc3NmFkK2Mrcm9nZXUrYjZK?=
 =?utf-8?B?Z0YycXFZc3BNSmtQTlZlUHRVNlhXMlZEUjJZWVhJZFBJc1owTG53ZUxGTEFK?=
 =?utf-8?B?T2dZNkpERUl3cDR3UHhuOFBxdTk2bEZXS1JIc2lSSk9PKzZjRStqVlp1aE5W?=
 =?utf-8?B?NmE5dmFtUUk4dUxNTlkxU0xJY2UwVno0ZGRIOFpLNnhrN2FRSG8yTlRzaXV0?=
 =?utf-8?B?MmJOREsyalgvMGVNM2s3TGtzQ0ZNZDBXOGFVMXdGUmxaQUE4NFNtalJRRFZx?=
 =?utf-8?B?c1Y1OEpTdlU2Q1VJcWQwUmVncFFFZ0lTdkI4L3luSG1XNFJGcGhXbTg5Y2hQ?=
 =?utf-8?B?MmZITGg0aGRPQktiNyt4ZGJaTUNSNVVwbjNwQzNrOWNqYjF4OW1JU2QyVzg2?=
 =?utf-8?B?NmZCQjBRMUlpL1NTUmExN3hOd2FKN21Zekh5bVAwallJZXA0eFVYZmJsNWFE?=
 =?utf-8?B?MjEyYURJNlNlNk9jdzFpdklldkxvSG95OE9YRFZacUxPNklWSWxmajFCa2pG?=
 =?utf-8?B?YUk1cEE1RXRyUWdRb3Q4RDVCb3U4UWhybCttU2NLU3N0N1VFSTVIdnBNVHhD?=
 =?utf-8?B?ck41cDhXVnpFdE93dC9WLzNocThhZ0NiVk1IalJwTU9lOG5tcGtqcTlHblZD?=
 =?utf-8?B?WUdtVGk3eWxMTW1sVVhGY1ZUS2ZwR3Uzb29GTGFyT1ZIRE5PL3hUWnNhWDFx?=
 =?utf-8?B?NmFNYnRHeTdIeGRBREVnSWVYSUVUcWdkSzUva1A3RlNwV0dzYkpHQ2hTWkdw?=
 =?utf-8?B?MkxNZ2M3TnRBY0puSGcrVHBMaXBDZVdpelphZnFrVXk0N2JrWWtmNzdrMHlo?=
 =?utf-8?B?R09jd3kwSWlJWHF2VVhDdzREbDRJVGFPNUgrSDY3YUdlM2ZWaXQ5clZmQkNJ?=
 =?utf-8?B?MDlDa2htQ1NCb0VGVHFKS1ZJOHhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEE6709CF3809F41A57A39B9B4CEE645@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mEZfDhPa9ZBkRf7jJWGYwogRq9Yxgv0rLWD3MmpVcbdpek2YXoExViJWeA0EWppdkJMD3lfiW5UfHSo4mJVIHhml+wRZWVhGl0Csduu0iKEzxPVK9gGAnJapLeBwO11j1iM5JxfxjRiPnWYIJmKdW64XrUACjflUYH8/Y7gSX5EVNFvj2Ih9Ulg01zB4cZT74I1GjJ9wywACe7x3w7i4e6nPiMictsVigXVD51klJWWa82VQUx+56ua1iepybTfVap5VcscPsOrNpRV2Dh5Sh8CU1QHpZnXsxZFeSB9veVt6TcOywjz0ncpq2XllWnp4JHMtWxgkUNEIkJWsDWbQMC4SThnZMRt1RTFr5CekGr0U7eLhmY2snuIGz6awh9YY8gDbZsILvRjJvIAqA2AxNTgXDKRomHOl1rqpx6YeKzdXV2LmhKZEB+BhEWGanqJgIQt2fzA0W3aVw9EDzqNxR5UWK7WsbzD+9z+fkSlY4XitOZ/ynj8I4seQFeQvYnbO5btxrMk8H1rSsMHgJ4pR7JSnDAnYh1OgepR4KinbB91wZ1xod1Z7QSKWi8iYaWxFKhLtfsVW1C0ljrBEmNvqSSn7F1DRj2uWWW93ZKt5DLipHDZuBK0zq0WMNjZWDzQ9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7a966b-62b6-45da-8077-08dc7b0e4581
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 09:54:00.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDUL26JLfkyUERzi8TxkHOzXuunHy7wmVUz9WQ3wAARmq2I8Y4oUgNbXdGy5K6q8Z2WSksuu5YNdLpA28QlkSHVcjozQlhO23DOu++5NP7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7769

T24gMjMuMDUuMjQgMDM6NDIsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBUdWUsIE1heSAx
NCwgMjAyNCBhdCAwNToyMjowOFBNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+
PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
Pj4NCj4+IE1vdmUgcmVhZGluZyBvZiB0aGUgb24tZGlzayBzdXBlcmJsb2NrIGZyb20gcGFnZSB0
byBrbWFsbG9jKCllZCBtZW1vcnkuDQo+IA0KPiBObywgdGhpcyBpcyB3cm9uZy4NCj4gDQo+PiAr
CXN1cGVyID0ga3phbGxvYyhaT05FRlNfU1VQRVJfU0laRSwgR0ZQX0tFUk5FTCk7DQo+PiArCWlm
ICghc3VwZXIpDQo+PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+PiAgIA0KPj4gKwlmb2xpbyA9IHZp
cnRfdG9fZm9saW8oc3VwZXIpOw0KPiANCj4gVGhpcyB3aWxsIHN0b3Agd29ya2luZyBhdCBzb21l
IHBvaW50LiAgSXQnbGwgcmV0dXJuIE5VTEwgb25jZSB3ZSBnZXQNCj4gdG8gdGhlIG1lbWRlc2Mg
ZnV0dXJlIChiZWNhdXNlIHRoZSBtZW1kZXNjIHdpbGwgYmUgYSBzbGFiLCBub3QgYSBmb2xpbyku
DQo+IA0KPj4gICAJYmlvX2luaXQoJmJpbywgc2ItPnNfYmRldiwgJmJpb192ZWMsIDEsIFJFUV9P
UF9SRUFEKTsNCj4+ICAgCWJpby5iaV9pdGVyLmJpX3NlY3RvciA9IDA7DQo+PiAtCV9fYmlvX2Fk
ZF9wYWdlKCZiaW8sIHBhZ2UsIFBBR0VfU0laRSwgMCk7DQo+PiArCWJpb19hZGRfZm9saW9fbm9m
YWlsKCZiaW8sIGZvbGlvLCBaT05FRlNfU1VQRVJfU0laRSwNCj4+ICsJCQkgICAgIG9mZnNldF9p
bl9mb2xpbyhmb2xpbywgc3VwZXIpKTsNCj4gDQo+IEl0IGFsc28gZG9lc24ndCBzb2x2ZSB0aGUg
cHJvYmxlbSBvZiB0cnlpbmcgdG8gcmVhZCA0S2lCIGZyb20gYSBkZXZpY2UNCj4gd2l0aCAxNktp
QiBzZWN0b3JzLiAgV2UnbGwgaGF2ZSB0byBmYWlsIHRoZSBiaW8gYmVjYXVzZSB0aGVyZSBpc24n
dA0KPiBlbm91Z2ggbWVtb3J5IGluIHRoZSBiaW8gdG8gc3RvcmUgb25lIGJsb2NrLg0KPiANCj4g
SSB0aGluayB0aGUgcmlnaHQgd2F5IHRvIGhhbmRsZSB0aGlzIGlzIHRvIGNhbGwgcmVhZF9tYXBw
aW5nX2ZvbGlvKCkuDQo+IFRoYXQgd2lsbCBhbGxvY2F0ZSBhIGZvbGlvIGluIHRoZSBwYWdlIGNh
Y2hlIGZvciB5b3UgKG9iZXlpbmcgdGhlDQo+IG1pbmltdW0gZm9saW8gc2l6ZSkuICBUaGVuIHlv
dSBjYW4gZXhhbWluZSB0aGUgY29udGVudHMuICBJdCBzaG91bGQNCj4gYWN0dWFsbHkgcmVtb3Zl
IGNvZGUgZnJvbSB6b25lZnMuICBEb24ndCBmb3JnZXQgdG8gY2FsbCBmb2xpb19wdXQoKQ0KPiB3
aGVuIHlvdSdyZSBkb25lIHdpdGggaXQgKGVpdGhlciBhdCB1bm1vdW50IG9yIGF0IHRoZSBlbmQg
b2YgbW91bnQgaWYNCj4geW91IGNvcHkgd2hhdCB5b3UgbmVlZCBlbHNld2hlcmUpLg0KPiANCg0K
SG1tIGJ1dCByZWFkIG1hcHBpbmcgZm9saW8gbmVlZHMgYW4gaW5vZGUgZm9yIHRoZSBhZGRyZXNz
X3NwYWNlLiBPciBkb2VzIA0KdGhlIGJsb2NrIGRldmljZSBpbm9kZSB3b3JrIGhlcmU/DQo=

