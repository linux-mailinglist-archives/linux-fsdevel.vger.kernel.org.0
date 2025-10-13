Return-Path: <linux-fsdevel+bounces-63931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70910BD1F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB6694EE032
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E12EDD78;
	Mon, 13 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iLcKxmYj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YTghn5wi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759382EACF0;
	Mon, 13 Oct 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343148; cv=fail; b=npseHh92A68ZluETN2GupmbwdG+xwRHhdAmGoDhqNCzKcxJmt4nK2cD0AsLMCTYUWgtOaV4QQt4Ir4hq2+stcw93qTQWs0IXtpjy4NFwfyepFEc663+G5DFYBDYJw5o1Q4hir9D2LGTni14mGAkPwEFytGiZY9Hnf1E+VQJjMkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343148; c=relaxed/simple;
	bh=QEP8+JThITTWJeb3AXNN7iCfUhWu5MvnQDU+55VclbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMDb3I32Rpg3bDCJCqaULH36rA6KVRcwFt2x68rVh5G9k66Z0JuoQGKZgwommk6sDAx1AJjLAAvk6pt9GCENxxHZw5uVanXA8ubq26DmNdiWbchoESX7ETmWDox4tPKteeY5sV6z9wosHEOBZeBkZJOSoONO2dMesPhP8BpwwWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iLcKxmYj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YTghn5wi; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760343146; x=1791879146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QEP8+JThITTWJeb3AXNN7iCfUhWu5MvnQDU+55VclbI=;
  b=iLcKxmYjEq2IjVw7aKKfRxhKRvGcuVlICzbq4tdlwdNvRMxUkEUtkRZD
   dX1c1awRZEeCBZ9+5da9RHI1sFpFetfKn2aL9Am7Yjs8QFgF+fYMOYB4y
   A64iD+yaJc+3RdQQM3vOpyo+Tuvj3+vylRKtsaqrfzDwv1tWVJ6GFHlaF
   Ie3eau46wcVZ2H+Lf+m8Hh5MkIOLYHyn5P/Cjze322n6nqe0l3P0tzLfB
   vCJB7chhYtudz00p5u8LPUZFAeF/76vtWWfbYcj31LuAlOyMorZ9bp3Ub
   gEGSs/ajyzTP5stpNj/xN8TiI+vGSMPxBnksdwSYLvCjWdcVNCYU9HnRS
   Q==;
X-CSE-ConnectionGUID: 1VnNiSn5QvCbsDlh/ov2Mw==
X-CSE-MsgGUID: oLjDA3nHSfaTITRF0CjfVQ==
X-IronPort-AV: E=Sophos;i="6.19,225,1754928000"; 
   d="scan'208";a="132776238"
Received: from mail-westus3azon11011044.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.44])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:12:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBXlpjAKfSQt4iiTDnWGJ8/ynUqaE1BX5ma7Z4j4inAMyU9qX3WfTUxiBVB/4rpn4FPXTfKZ+qlII2nrrq8px2dzT/S4ewUwTBaSbaH3J1jOsiv5wS6RRoJRqpzFIJo1dzaVaVYJjoiL2e48ETkoL8zn+eR38MACV6saMqjrMRrzW7sZSOhtfITcARW5N63H5lZkneMFWLa96A8aPn/sNWEsdo1ZmHCPXOBdo9GEuwzDG23coE1C+yKmhHrhy8rpYjk63l5hnpnabCytmP6842KBhCIxjzXnybSm9dqPwtVMBIVpa+Os8GAXYfEi3ed/sZbqqKGWHZAGz6IxCTvPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEP8+JThITTWJeb3AXNN7iCfUhWu5MvnQDU+55VclbI=;
 b=BAJK7u4ba/BaUqRfKGDwbsKVp8RJVFuWQOqLp7/rzoLyN/daNhwQ51huC4DgNsEjRwK2vDiTXDBMLXMbCpVNR/7I6rOV0NaBwLRvVz3rDkOv4FixFHOEYSG5HMWL3eANSpHoTdsi/5dyQtVNEEg2dldNgy4v97nFlmrIl4eBMXdzKksTI7W3/xMf0OUh8NkCJRTmXh0xuJMc1X/wUCxju93gxRJKaHvQqJqSsOVBdyiJx4umEmxrLIJnwB9r+gbM6FZjG6FK+ggsJluFSnCOkUgmkZQLgdywHUcT/P62Jspor55meEPgfQwJVyRNsKzowFEAyGjZXrutplShZFv7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEP8+JThITTWJeb3AXNN7iCfUhWu5MvnQDU+55VclbI=;
 b=YTghn5wiaMW4L+AeDQzAfkmgTKwwAhymZPPo544FtpBUZPCagjd61plJYGxUpUUMjABFiLCHZNj8ThfgXKUIf0hH7726jLP4nmiYMxN6aRy48ZFXt8VUMcRaTvKrXgDK1ruAAvCzGXEUJA/7RtTLQ6PLNdmKarm7r2J/OA8uTfM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9431.namprd04.prod.outlook.com (2603:10b6:208:4f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 08:12:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:12:16 +0000
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
Subject: Re: filemap_* writeback interface cleanups
Thread-Topic: filemap_* writeback interface cleanups
Thread-Index: AQHcO+1GxDsb984h8U6EnOHXlipe1rS/ulIA
Date: Mon, 13 Oct 2025 08:12:16 +0000
Message-ID: <bf280a12-28b2-445a-8ed2-cc63d4c57a36@wdc.com>
References: <20251013025808.4111128-1-hch@lst.de>
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9431:EE_
x-ms-office365-filtering-correlation-id: e519457b-60e8-4a7b-6acd-08de0a30392c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnY4T2VUQWY0MHAvY2ZMZ3MxbzVkVk5IcVMrVGJZQzNmMU4wR2dUd2FZYjBU?=
 =?utf-8?B?eXFYbkJFWldkdWN1TDJEU0VjR0sxanFhVEUwWllmc0dLVXlCd0lTRjFEcEpQ?=
 =?utf-8?B?N0NUMWtGTTFJb0JGZm4rMEZJaUpGSTVucVJqN0dZNFFRb09LY0k4eVEzd0hj?=
 =?utf-8?B?djRtdmtnUGUzQjg1aHlnbFZiVG9NdUhPUi9GcmVIZzI2RWI0MDBraDNPQ2tP?=
 =?utf-8?B?emh3em9QVy9PTm85M3d6bVdmT3g1MFRQL3pVMVJpMkhBOG15WFF3VjRTcS9a?=
 =?utf-8?B?NE1iSUpkZ0R3K290SWxZSG5peER3a0tzbXBZZXAzVlBXcnEwTFJWSEZoaXVq?=
 =?utf-8?B?WE9waTc5dDc0NzJYMEFDOHlkR0xVR3RZckM3V2I2bFhDTWhSNVNGaWhsMERR?=
 =?utf-8?B?dk9QUlpiTDhvdHlrVkxkaGNxUEx4d0tNZHM4VVlzZFFJZnM5bGUveXl1UW5o?=
 =?utf-8?B?MHc5eDFyNVp3dnhaaDFXclIwa201bzRHOVMzenlYZ1A1UzRJVmltYTVRZmVh?=
 =?utf-8?B?SXF5a0lWb1BScERvek0yd1RSRXgxZXBEcVdxR1ZXME9sbXkrNEtCSGFwMzh5?=
 =?utf-8?B?UU00YnFwRzRHTHI3d0k5K2VPbTJDamhkd2VBeHJZSTZMV3RFUSt5OU9GVGd1?=
 =?utf-8?B?eTR5NUJZRXBGVkJ1M2dLeElzdEk1bC9vMVpIeUpRRW5sOUpmYm96T2EwSWIx?=
 =?utf-8?B?VGt3SHdBNTBPdnU4OXFwTEFwUDlkZjRFWENUR2MzcStRT1RLSlpZRTJNS2dL?=
 =?utf-8?B?RjBISzgwR3BTcUM1MnErYmVKY1crK1pndTRWWjAwYzdoU3BINlBCSzVnY1dH?=
 =?utf-8?B?MDIzYXR0ekR6WXdmYS9JUldETlg3MFMrdnNFZWNlS2VzVFBxYTR5SkNZVzVE?=
 =?utf-8?B?WDRjTmxkS25XZlZhL0FPdjZWTy94ZEl0RStGSHpDT2RrOW81SlNlQUczcWpQ?=
 =?utf-8?B?YU9NK3AwNTExSGY4N25mcDNsSDRjWFlieVRsa2xqVnZ5ekV3cmRmQW1MaHJ0?=
 =?utf-8?B?U1JKUjNXeVdkLzRLaHlTNEdXY3NzbnRmUHh0cFNBeDZ4VkNFSTMzZ2NtTDNK?=
 =?utf-8?B?ZlNJZGxRaGpQcnd0Ym56ZmpHQ3RGQXBTZElMSXRqc3U5UklYcjE5bFZnSlAw?=
 =?utf-8?B?Q0IrZERpRFZyTzlWcU1WWVRFelowUUlJanVEZVp4SC9XRFVzNldlMEFmU09o?=
 =?utf-8?B?a0ZNM3dvdllHUGVlWGVkZU5hbVpnZmxrd2Y5dVBDZnRtdmdtZU1TSnZYNjdJ?=
 =?utf-8?B?eFB2NFNUV0k4a2lLdzdSaFhYTTY4U2ZZMU41SUNYemtoYmxBSjkrc09WMkVk?=
 =?utf-8?B?QUJ4cFlPd1QwSk9tSGo5TFQ5MXFCcmJjeVp4ZG9KTHpJNGNXaFErNFA0WHVE?=
 =?utf-8?B?QjV3UGJOY3lzZ3c2YjNwNXQ1bDRXRUVjVE1od1pJekhzZ2p3d2JXaldxVkRM?=
 =?utf-8?B?S2oxM2hiaHUrdndtN0N5QW8wVkc4TVhpUmNNeHNNMW9sb0kzcFpORDNsU1NP?=
 =?utf-8?B?MkJyWm1XQ3oyY0xsMkhDZm5uamlLWFBydk13YjlaeUdsR1M4b2FlUlRHdW9M?=
 =?utf-8?B?TXNzczI2dW01eEJXNFhkZTAralRHSjJIM2pRY0tMRnBOMUc3ejgrN2hWRU5D?=
 =?utf-8?B?S0ZDTWdYckZKVHMrZ0lNRE5EUUZkekFmK0ZHSXhtRVZUL3lpWkdqY1VNZ05r?=
 =?utf-8?B?aUNPMzQyZHNBeDVCSDFyVVdpY1kzb090NWpHUmw4NXM0aVNCdTNsSW5oMXh0?=
 =?utf-8?B?Z2R0clR2YTBhVzhNME1WVXNKZVFuU3NhTnZKV0F0blFaNjFBSjQ2SjlucklP?=
 =?utf-8?B?NHFtSkVtSWwvQitoTW9MNDcxSUZTck0xRm5hOU8vMFJNUHNKRTg1bEpTT25v?=
 =?utf-8?B?VlA2WEVRNHZaMlFrVng1OTJ0V291QmJzQm5rZ2JLSmNFN3l0aFJRTHhyc1d4?=
 =?utf-8?B?d1VjOWM2ZFJpWWF3cG5lemhqVE5nUC8wenErMzdmQW03YWZJNWdNVDhOVnV5?=
 =?utf-8?B?VXlJS29NZ0Z2NmRld09xQkJlNzRkZklQU0s4YS9qdzFERjJOd09yN1N1Zjl0?=
 =?utf-8?B?V3N5RzdPTkpEWXVqQmpSYWdxU1BiYmFOY3VGQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHJaR0tVd3VvWjJ0aHl4N2dWbGM1U0dWNkdaQ1ZmNytPcWJzMXQ1c1hOV0lF?=
 =?utf-8?B?T1FhOWNmRGFEN2hUZmdvUFdwUm50Sk9jR2tWT0NFYUp4aFgxR0dlTmw4Zm1h?=
 =?utf-8?B?bjdheHpnMkJ5dGsvSCtORDA5SFZacjFkTkhJRGRHR1BPaFArZlg4aVRGL3VU?=
 =?utf-8?B?Y2tHSkkwbjViMUNuTk1JelBaWTJkN09JTFRZWldrSEp1NEprQ0JHZENMNG1C?=
 =?utf-8?B?M2NLVUVmVGZFWFcxMDE1NVpqa3daYy91UDJML0xSOEwyU2pyRzlBb0t5TUJW?=
 =?utf-8?B?MjJzVVdBOE1Yeko2OEl1bTFWcVVIcDd6aUwxWERWbUdtRGprbUYvcEI1RG1Y?=
 =?utf-8?B?MjBTanZaT3pDa3hmYkpZaCt2VHE2bS9SVVl0aGJPbmlJMVU1UU0weFV3NEJS?=
 =?utf-8?B?S3VBM2p1cktwdVRIeE9TRDZmL3B3cU5GSWo3Tm1JVEJmVTh3U3UzUG1DQjhX?=
 =?utf-8?B?T3p1Wi9DbkRUOHJ4K3RlNDUxaEx4SnVnZmxZSjgySEdObTlrWVZHTUpMT1Vm?=
 =?utf-8?B?RHM3NUtNcEROSlZuakhCL2dIT05QdVBLSm1lTDRERERxSVBOekY0Yk5kazVw?=
 =?utf-8?B?cDA2N3E2STdYNW5WeGdwT0YyVnIxcTdDWTBvQmZEQTdZd0RicGMyWkl4WURZ?=
 =?utf-8?B?L3RkYi9zVnR4Y2d5bFg1UEdQblMxd0VSSEhxSG82Q0NCVitZTDNEck1VdFZh?=
 =?utf-8?B?ajRzVSt0V0htd0F4Sm43QW9KZEVGSDFwZWdiSW9zN1k2NkdPVVJnSmY1VEU2?=
 =?utf-8?B?SXZ0ZHRuclBCb3hrNUFtS0J0Q0lTbmZuQTBHUS9DcmhUKzZTVlNwYlcwRzdw?=
 =?utf-8?B?Y0dqY1drOVpZSDNVc2UyRWdjY3c5Uk40dHlEUXNnZmozOVhJT3N6akhaeS9H?=
 =?utf-8?B?NFA1L0pXclFFbzR5Yi9qTnJpL1dXclpJYXcyZGUvVW5mT3BEWFk1eUphL2xq?=
 =?utf-8?B?dG90SEVLWDRTTVo3Q3JGczJmU2lEdzR0bnZhVmJUajRpNGc2K1FUZVV4N290?=
 =?utf-8?B?UTd4NUxyamtYcEx6ekRDZjVadGg0Z3NjU0RJa1RBYXhraGEwZTlnT1lRQmtm?=
 =?utf-8?B?RnlCZG44Nkh1U3JJRThSYTJLWlovR1hnRHVMbVVPSHRXd2FGcExZTTZqbzI0?=
 =?utf-8?B?dzdvM2E5NzN4T2xYVmwyTnZkUVoxa083TXZFckNyeThZNlRFcHJPT054eHR4?=
 =?utf-8?B?UjNsS3RTYlZrTmJ2QzU1ZjFOdlY1anZGbEFNQXFwSDJUKzYyT1pqdTJSc2ti?=
 =?utf-8?B?NXZ0L0tuYnBFY1Znc1M3UjlXMGtTaVoxZEVsQmsrcysvSnNxQTRJbEpKVzF1?=
 =?utf-8?B?eGtPVkJvTGo3OXEzYUZaUUJyUXZ4WGJQSnozL1NYU1FrV3FDUXNyNzk4MWM3?=
 =?utf-8?B?UXFsN0IxQlZzMUl6UExjdTV1UlVxVy9CRzlHZkFvSllkaFBkc2ZrWjJOeS9L?=
 =?utf-8?B?R3B4QWJzNEQ2VjQxRS9LWkxhcXFkR01Kd2tUVE9TWFI3QkluRTU0anhLWjJt?=
 =?utf-8?B?N09qWEQrdGk1d2NxeXVka0kvNjJyNlVqcGY2am11alJnUmNsTHlxcGYvWjQw?=
 =?utf-8?B?VjhFREYwQlBnakJ0RWVwSlo5NWM0b1d2RlYzNmIyNlYvMExpZGJZZS9adUYr?=
 =?utf-8?B?YVVFaHZhd0NDaDdTdDFtM2JKUUdpelVPeDB0RUZ1MnZRVjU1VzRPYldydGhX?=
 =?utf-8?B?bVEva3EySzN1eWpxNmtJMmZQK0tNZTgvb1RHN0F6NWMxYmk5eWI5V3Rid3o4?=
 =?utf-8?B?NW5LMWhQNjBQOVluYmVQbk5qTFJob1d1eXNFRjQxK2xJcnJkMExUdWxMc2Nj?=
 =?utf-8?B?WEZtZEE0bjFxMTkzekw2QzdQWjlMWDE1NGlmK3V4T0VWUFdtWUNOMEZkT2lN?=
 =?utf-8?B?a2pnR25lQ01ORDJ5anhZczdJWHZvajUrZVZwUlgwRUM0RmFJTGk3bXVEZ21O?=
 =?utf-8?B?WUd5aFdxaklJbWF2TWtpR3NmZXp6dzVldzBsT01iNTlpWS9jY1ZVb21vUksw?=
 =?utf-8?B?TGZ0bEUzNnVnN29KYTV4YzA5eWNhRzdEVEgzdGQ0dHNPbGVMRHgzUzlxb2ha?=
 =?utf-8?B?NXhLU25LOXhtMUlXSDNUWEdDL1laeW5oemU5a2lGdGVsUUxxSWJkamRyTEVS?=
 =?utf-8?B?ZHlJTXNqWU80bHVEYWhJZVMzYkVYK1AxamJZakJtNVJpdkd6RHpIUWlWUlVi?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BC2F70E63BC6F438001F749882B65C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	znshNhAWrtE/QXK+7mhRwLVFn5kCJXkc1OQ7J/3EGmk1O+jQz31a8QqywOSksX7dp75z/JqBV+mPiMbgSaNNv3f9rwizXjwmIkxY5bKtIzCNjYi8tgZaB4IbrcgFkJBvlzjFjLOAdMcF2zWggRHQDZ/Z6tYSBC5z6vdu1+cfYz8cuqkkKwoNIvAZIY5qWOTIKB/M1+gavUUHX6WVZMa31kt/+w+mSjz04srlLuOIhUoSbOrXEvMviRoeioR7h/Fi2/vd44aUQPE2bjFw5CwvCeGFrOpDkLAjbzevFO6AKmBalPKkbgDYaQ1ohzSjgz1x+RImfg2eRddkxDXI3pUJ+dMkFHHYuwjr/Crv0bZxx+pgfjOaQQjmLEjBjtsK2mC+H7p08AUM74wJ2xPao71/Kt0UzGPvsgNq8ahX3BAZqL1PA4vmEarcSS6ojIwDlpq+P/YTMNS84eIzgVSSWRKtwScj4Tfee8G5U2BvMzsnmQYEEvMizNWM/zDepmUlMUBqtMpn32uCEPlO4W8Grxe3CsChlvX39B7b2nNj8J+6OQmhD85cXRpes1LV3WrCFXWhy34pG2Llp2/9uPsbdArx1NLO+nTrG+/CfYXy1AJU6yM475XwyYUb15TYrWWPAW93
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e519457b-60e8-4a7b-6acd-08de0a30392c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:12:16.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvjwVE2GmsGa0CWZPhZGKCaDSt7scdAeGkK0ZIJ7soXYvJj4jH8fPhG0NGgYiPmONSy5KvQtK30TEa4PRPJt02NQo/ii2uN///v2UmDUkl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9431

T24gMTAvMTMvMjUgNDo1OCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIGFsbCwN
Cj4NCj4gd2hpbGUgbG9va2luZyBhdCB0aGUgZmlsZW1hcCB3cml0ZWJhY2sgY29kZSwgSSB0aGlu
ayBhZGRpbmcNCj4gZmlsZW1hcF9mZGF0YXdyaXRlX3diYyBlbmRlZCB1cCBiZWluZyBhIG1pc3Rh
a2UsIGFzIGFsbCBidXQgdGhlIG9yaWdpbmFsDQo+IGJ0cmZzIGNhbGxlciBzaG91bGQgYmUgdXNp
bmcgYmV0dGVyIGhpZ2ggbGV2ZWwgaW50ZXJmYWNlcyBpbnN0ZWFkLiAgVGhpcw0KPiBzZXJpZXMg
cmVtb3ZlcyBhbGwgdGhlc2UsIHN3aXRjaGVzIGJ0cmZzIHRvIGEgbW9yZSBzcGVjaWZpYyBpbnRl
cmZhY2VzDQo+IGFuZCBhbHNvIGNsZWFucyB1cCBhbm90aGVyIHRvbyBsb3ctbGV2ZWwgaW50ZXJm
YWNlLiAgV2l0aCB0aGlzIHRoZQ0KPiB3cml0ZWJhY2tfY29udHJvbCB0aGF0IGlzIHBhc3NlZCB0
byB0aGUgd3JpdGViYWNrIGNvZGUgaXMgb25seQ0KPiBpbml0aWFsaXplZCBpbiB0aHJlZSBwbGFj
ZXMsIGFsdGhvdWdoIHRoZXJlIGFyZSBhIGxvdCBtb3JlIHBsYWNlcyBpbg0KPiBmaWxlIHN5c3Rl
bSBjb2RlIHRoYXQgbmV2ZXIgcmVhY2ggdGhlIGNvbW1vbiB3cml0ZWJhY2sgY29kZS4NCj4NCj4g
RGlmZnN0YXQ6DQo+ICAgYmxvY2svYmRldi5jICAgICAgICAgICAgfCAgICAyDQo+ICAgZnMvOXAv
dmZzX2ZpbGUuYyAgICAgICAgfCAgIDE3ICstLS0tLS0NCj4gICBmcy9idHJmcy9kZWZyYWcuYyAg
ICAgICB8ICAgIDQgLQ0KPiAgIGZzL2J0cmZzL2V4dGVudF9pby5jICAgIHwgICAgMyAtDQo+ICAg
ZnMvYnRyZnMvZmlsZS5jICAgICAgICAgfCAgICAyDQo+ICAgZnMvYnRyZnMvaW5vZGUuYyAgICAg
ICAgfCAgIDUyICsrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gICBmcy9idHJmcy9yZWZsaW5rLmMg
ICAgICB8ICAgIDINCj4gICBmcy9idHJmcy9zdXBlci5jICAgICAgICB8ICAgIDINCj4gICBmcy9l
eHQ0L2lubGluZS5jICAgICAgICB8ICAgIDINCj4gICBmcy9leHQ0L2lub2RlLmMgICAgICAgICB8
ICAgIDYgKy0NCj4gICBmcy9mYXQvaW5vZGUuYyAgICAgICAgICB8ICAgIDINCj4gICBmcy9mcy13
cml0ZWJhY2suYyAgICAgICB8ICAgIDYgKy0NCj4gICBmcy9qZnMvamZzX2xvZ21nci5jICAgICB8
ICAgIDINCj4gICBmcy9vY2ZzMi9qb3VybmFsLmMgICAgICB8ICAgMTEgLS0tLQ0KPiAgIGZzL3N5
bmMuYyAgICAgICAgICAgICAgIHwgICAxMSArKy0tDQo+ICAgZnMveGZzL3hmc19maWxlLmMgICAg
ICAgfCAgICAyDQo+ICAgaW5jbHVkZS9saW51eC9wYWdlbWFwLmggfCAgICA4ICstLQ0KPiAgIG1t
L2ZhZHZpc2UuYyAgICAgICAgICAgIHwgICAgMyAtDQo+ICAgbW0vZmlsZW1hcC5jICAgICAgICAg
ICAgfCAgMTA5ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgIG1tL2todWdlcGFnZWQuYyAgICAgICAgIHwgICAgMg0KPiAgIDIwIGZpbGVzIGNoYW5n
ZWQsIDk1IGluc2VydGlvbnMoKyksIDE1MyBkZWxldGlvbnMoLSkNCj4NCj4NCkxvb2tzIGdvb2Qs
DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3
ZGMuY29tPg0KDQo=

