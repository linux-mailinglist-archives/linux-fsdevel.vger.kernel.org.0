Return-Path: <linux-fsdevel+bounces-67272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5CC39FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CD423BF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3753630E849;
	Thu,  6 Nov 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UniFuA9y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a6dyPszk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7F2D24B3;
	Thu,  6 Nov 2025 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422623; cv=fail; b=uYrFX25sS4vnGGjkZwGVjoasuGE8XbYM6Y7PA4/Ye3Lp/6/cZA+5uT2aBHaSteokKYrsKCEXeKHZV7iZFL9xFdKKtURZAg4DYgGD5BjDoDSPcYvmNbFSme745R6VX6AfaqzOt9w3AfL1abAzbSpVTUSPcd7sviKtX+iw1Bv65QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422623; c=relaxed/simple;
	bh=/1tUw3rWMyH86SU+qXlPidOsYdSfC+as0nVfQDaXSJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmoquZtb1AfqhWwXPQHPvE+IhqbchNE+x09tVwaOhTYk2L2GUCmz8FigdYmEQP5B5tsEb8mnff9MIteYy0L8G/gOVPBW1WvLO306BMf/BU8/v1FDSSspCSW8gwEoI43hbv+3/wxgVX6A+BJ+OMbDNKAC6TzqsnmCO3WYs/hriF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UniFuA9y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a6dyPszk; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762422620; x=1793958620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/1tUw3rWMyH86SU+qXlPidOsYdSfC+as0nVfQDaXSJk=;
  b=UniFuA9yfqlblZiz8fyqX++LVJ1jE1HRYaYy/kfSJX9/TR60u12tGr9m
   FDnKvqDjYunNR5FdS8GDWMzNeUMLvdzoJ4gYUA24nkSDJCLW8kLLTV9Dh
   w+vwycDIunBmFDLqm/N8SmVD3trMfybaBAgEMKsMO4kBepW5CBvV/+HIB
   CwBUErEL4tj/9BOXQ3NGPoA1NdVkzkhF7R9z6Yv+QBt3lYgvhjKHCAKS5
   yrBCiPJukqYjNbNm1K+TH1LUd4QGXxp+aM5NPF8yIBXHT9RrkYoAjnItL
   VcwIV1bGe0MZN7xv5pIg0L2Utw8/Hd54jLJH1lBvXPa1bDULNWseMEl26
   Q==;
X-CSE-ConnectionGUID: Di3CEQcDTaKO9rtOD04D0g==
X-CSE-MsgGUID: vHLqIsIKTo6FkjAqwriHRg==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="134569218"
Received: from mail-northcentralusazon11010068.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.68])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 17:50:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H80ug1lbjjV3kdf4FGyQs/DBqoxR6Ij3gJ0VMijm5E2gJWngpUqJnnyMdupOd9KfXRtzhdyNNUg2cfu14GcmI3krqBcnNBkSNIXCIFnGoghKgvLDR7za3ly+JBbmOIOeGSiPT8EqC6U1Yg8H/Wdr/sdyMA9QADTUBy2tkYemYJbOSDKccC27oNHUyuckDFbEroLxTnJucIVDLv3iyj26Saxj7C1JAoVy2wbTREEXCMKThjwzPcD03PTNWoxPKD54l4DUFsks2KjTIZy//T5NV0F5h31E4z2i8fbyOhEFm4Z4/TOgmZhYciAWjbON2aNutsEnUTI4kTMDo3T0C0GVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1tUw3rWMyH86SU+qXlPidOsYdSfC+as0nVfQDaXSJk=;
 b=yCyfezsruekLZxh1D2xuDsdxInR9iWiGXI70Lt2WfL3g5pObXcNT+L7EZWkGN/KxwB48VQh5cagqWV8AzeFKaWa7TB652qGAVZ44Ckb1hy0r2H6V/fuqasMBJMWIvrMyoquJBSIsjIEyeLudq9hxLuFHtiTem0gVlX77NGzObVrLTRUTcNDJ+iawnlANn4Y7kL5Dl1jSo48hrsxgpndXPV1Z4IYhWPxbp3uInzAmPVgdJkuayp3JFTS4rJS6CMc8/fUOZMxivZW9T1M6w46tO2vjrW4d3zyV+yeKK0SRKSbPY85GeNSlNdMykOgBZSPF807FgxLcgPZwyiqa7IUOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1tUw3rWMyH86SU+qXlPidOsYdSfC+as0nVfQDaXSJk=;
 b=a6dyPszkNESZ+KcJpUdu8zJjO87/X3EbF4GF5fvvnWjdsFWDbhae08OkbrzXnPZwlPrOurE/YNtJbSB8lxpxAOwMTwJfinKe2lD6SJkuYVjjkOoSd7Tju2Ea20PitO/ECCXhdro+JGT01pSaAOTif5YDuWLVfJnBLw0FiBkPViA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL0PR04MB6530.namprd04.prod.outlook.com (2603:10b6:208:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 09:50:11 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 09:50:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>, hch <hch@lst.de>
CC: Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>, Dave Chinner
	<david@fromorbit.com>, Carlos Maiolino <cem@kernel.org>, Christian Brauner
	<brauner@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Thread-Topic: fall back from direct to buffered I/O when stable writes are
 required
Thread-Index:
 AQHcSKPxSP/c6QxZZUWcGwHr2pcVwLTajPwAgAA2BwCAAJLJAIAA5a8AgAAxYoCAAA3QgIAEWfoAgAASvoCAAk+MAIAA8/EAgAB+dYCAAMrbAA==
Date: Thu, 6 Nov 2025 09:50:10 +0000
Message-ID: <9530fca4-418d-4415-b365-cad04a06449b@wdc.com>
References: <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de> <20251104233824.GO196370@frogsfrogsfrogs>
 <20251105141130.GB22325@lst.de> <20251105214407.GN196362@frogsfrogsfrogs>
In-Reply-To: <20251105214407.GN196362@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL0PR04MB6530:EE_
x-ms-office365-filtering-correlation-id: da76491c-07a1-4731-2681-08de1d19e062
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|10070799003|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHRzN3lJSXozdnBua29aWkc3ZTJ2MXBnd1g0TGg4QkdxeTVRbzVoanFUUWlL?=
 =?utf-8?B?QXRFZTlwOHFEcmJBNEdrK2tpdkl1Q0JGeHRzc3NKVnZRYzRTNkhVUno4bDRR?=
 =?utf-8?B?UXBNOU94ek4xekFLVlg5bnlmbWI2NW11b3pVbjdxY2FaaEJrOGlLN09PQU9Z?=
 =?utf-8?B?d3VIdzBUK2EvS3FGNyt6UHYrOFlZMU1tS0xBaE81S2dTTnY3Nk5ldThJL3B1?=
 =?utf-8?B?cUd3VFpEZ2xRVElGWnVNN2M1R2gwN01MSTEzQU8vdWxxdUY0YXlhc29mYUFo?=
 =?utf-8?B?VGwrM3VMZVlubUpwNjlLbkNyakxNak5CTUptQU40bE5TUUU0R0QydUplaVN6?=
 =?utf-8?B?OTJtS3lZWVphR0JFZEVaeFV0UEEwRVNwNDdKZGxPZUJwcTVUaUNmU0RnNm03?=
 =?utf-8?B?dCtHUXZteWY5K1pwSnlncC9aR2pHMHBIYmdoUFJtU2IzbEdHOEQ3QmFTTS9Y?=
 =?utf-8?B?VG5ONFBpMDdGSUovUG9NZkRIYnprTGVWZldpdlJuaTE5eE5pQjJHOWdVbGxi?=
 =?utf-8?B?SGtieElkNjFrQ3JjejZYZnJWUGhoQ3hQdGFZZk9wOWFGSXNHUGQ2UHdnTHNK?=
 =?utf-8?B?SmVKbXNvcnNUNVUxU0JJSnZOYnlrQ2FCenBKSXAybGNsMmphOWF3azF3RzJR?=
 =?utf-8?B?V3VLWWxoSTdRRjVWMGVRUGV3QjYvNzdsTTZCNFRZVjBmUkNNdENITDJuS0Ra?=
 =?utf-8?B?eXB5OU5SZU0zcUhETVdIZnpmM1IxRXEyMGpuNTVERFZIbzRjcEROQU80WCtu?=
 =?utf-8?B?b1pmOUpIZVRjRC9GeURVV2JvVFZQTkR3Vy8vblJ5cU1admF5UGZpTk1XcWht?=
 =?utf-8?B?MkEzVzV1L1R4VHVLNlMyZUlPNnFTS3VwVUpIQ2tFS01zUzhKRDNGNFB5NlVI?=
 =?utf-8?B?ZEY2OSsrbHh4NHBtVmlCV24vSXlNbXUxN2xWZS9zOGZCL1ZkaWtjT2ZKZWM5?=
 =?utf-8?B?dkJJK1hLcU5VS3lXOXh4aWs5ZEp3djhsWHNqNDNjbVdYNHhZK3RZdWRWQ0dr?=
 =?utf-8?B?U3JzOWdVWTlodU9pMW10T0pDbkhLaHpWZHNpNGlla2EyQ0hUZkhJa29zaVQ5?=
 =?utf-8?B?OUx5cnlRYVZVYW1wU0pEdUd3aWNRU1U3dC9JL3gzQ2c0NThnY2NxYm02S3N5?=
 =?utf-8?B?K0pHZ0JIYUxBdVA3MEQ4SzEybXpYWTVpMzNzNjJtbHRVb20xVXF3eS9heFh2?=
 =?utf-8?B?YWVTR1JHSFhjZmpMM0ZDTkhUakMwSUhxUnZjWkFNUC9FUm96Qm1YbUlKWWpo?=
 =?utf-8?B?WFBMYWtRVFhCUWQyTHMydVRoUVRPQU82UHpVSVRXRnQ3a3MrUEtxRFR5SnB0?=
 =?utf-8?B?ZU8yNWlmWXF2MnZMNHRPai93K2k3dzFRbVpPK1VGbmMvQko5Qjh0NGJ2cUhN?=
 =?utf-8?B?ZkU0OGFTcXlLN09VSzloZ0dRSGlQYjlMTVZFVzNNWTNWSWdnN29aQjlsM0Vl?=
 =?utf-8?B?UVhmek9hQW5xck5VMzBvbTdNUU5qcGw1aU1nbksrQkhGaTFTa2l2dGgxWkJi?=
 =?utf-8?B?Y2JRaWtRZWZvdDlldmRMTXN5QnpOOUNqOElmejNTWG01NVR3U3FPQVlzdE0x?=
 =?utf-8?B?bWYzdHF5aFk5blBqekdFdUt4am1PdlJsSHNkUERVNFVMSDJWYUJJbHo4SUsw?=
 =?utf-8?B?Z3N2RWtBYlVtYkNNNHg0U0pvWlZ1cnVsbDR4djE0eFcxbXZCTi9Sc2dvZWVz?=
 =?utf-8?B?WndIblRKVm1ERlBxM0VENmJyMmxsS3E1cC9uUHhLbm5nNm5MNFowWjI1Y29M?=
 =?utf-8?B?SnV5U3FtaDkzNlNMWmVMSUFPQjF0SmhFTVFOYkRvdjFsaHlDTDQra1ZiU0NL?=
 =?utf-8?B?TWhIRm9sVTFPSUdjZG8zOFM3V01zWjB2dHpBRXdtMS9wd29TY2orL0Y3cVBR?=
 =?utf-8?B?YzNicFB2bGdtVTJXQmYrQXFqc3AxT1oxSkdZMXdkNVpuY0FwUUJwVFBxSGo1?=
 =?utf-8?B?dmpZbFNPTDB4bW1FajIzSC9DUzZXbGdnK3E3bUMzR0NsS2M2MzhHRU1laXdl?=
 =?utf-8?B?b2NQMHNPR0ltV0REOFpOMzFJRTM3UjJWVkl5TGYyV0x6SStNQUxTdURJSFRk?=
 =?utf-8?Q?K27cNX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THRQSEt1cjN6bTlBWklDckFtanlmT1BSRGtpcWdSb0dnazFGUWV1ZkwrdDBo?=
 =?utf-8?B?dGw5Wld2WXJwNmhxSmpnZEdaUGFWZXJYejNPeHdYdmVTblRtd0MrUXdhVnRv?=
 =?utf-8?B?OEpSTFZWZjc4VFZkaGxkbkxHTmNKRmc3MUx0RERLdDF6aW9KcmxxV0F3OGky?=
 =?utf-8?B?RlJZdFdGQ0NsTkZXN3hoRXUvTERpMG8zcTlJeHhtRVB3Z2psOFIzRVNUc0ZK?=
 =?utf-8?B?a3lrOG9wNWh2ZitPa25vWXM4b3VkZElJYkhZT1FSb3FIS3g1Si9ock1yc3pi?=
 =?utf-8?B?bUg3TU56OVA5L0xIN3djc29iMVdBRkY3M1kza2dUb2E0Wi8zdkEvZ3ExUWYr?=
 =?utf-8?B?RGVLZ3Z5MjJJZnVDQy9HQko2dm9qUDZnaVFyY2kwN3pXWnZkMnJhZXFOaDBL?=
 =?utf-8?B?alErWFhVelJ0eDNvblgzclhzRWYxNWsrOEZpUXFQRXlyWTlFRy9QM095RWI2?=
 =?utf-8?B?Nm5DZWo5c3RTUG5iNjlhRSs3MTlSb1FZUy9JNCswb2NGYXY4Z3UrSGJnQTZI?=
 =?utf-8?B?b3FJUzFrK0dFWjNPL1g4WDQxazUzbVEzQnl3ZmhtK0k0dlYyRVpPRTZuYS9r?=
 =?utf-8?B?N3J2azFkOW9mZEZ0MGVMMFpPdFVDTlIweGFoV0hwWmdGUnAyRVRNbUNUdk5p?=
 =?utf-8?B?c05YZ0pMbWp3eThtUHZIeGh2REhKdzJQME0rS2NIblFhbERwempPSFpXL1Vn?=
 =?utf-8?B?WFYvVnVLaXJjTS9neGU3ZS9aVTJPUFBJeGw1ZU02WitTdFJDN0xNOVNRMXJS?=
 =?utf-8?B?ODhMa1lsMXkyV1YwUnpVcCs4aVNvUjc3ZFRHWWl1M2h2U20rdklMRXFDenUw?=
 =?utf-8?B?VTBGVWNQNkhXRnR3ZXVQVDB4SWJDQk9kSmowNGtuTzlBZkxnVThjWWVjajgz?=
 =?utf-8?B?czRON3M5TStpS3pzRU90cTVvNGJSYkVjSTFOSktxam56TXp4Szk3a0x1RVE0?=
 =?utf-8?B?V0RDU1lTamlnMWpRZk5YK2daUEkzRGFCMGpOaEZiT0dlK3F6b1M1WndnZi85?=
 =?utf-8?B?ZWRNMTdlcG1lRG1OK1NweU44eGQzdDdZWldOcUVNakpMbVZPZlBWWS9xS2p3?=
 =?utf-8?B?QnBVLzJaSVJvVWJ5OHRVL1NJbkFxRDJNTHpEQ01JdkdNMDRLRmZIbmp2Q3Q5?=
 =?utf-8?B?RStHTkJOUWFUMXJIZlZSUTNJYXF1TTI0YWRqdzRxZ3V5elRUYWlVWDNCaFRv?=
 =?utf-8?B?VVpxWlhIeVBKVjM3SHJzY2t1cEtJYlVuQWFEbkNnVktNVTdFblE1eFNmNmRB?=
 =?utf-8?B?ZWU2bzMzVWplNHNCNXMxaGVqcFlXYlFQdFZYZkhUdVdieUVTK1RqMFViL3BM?=
 =?utf-8?B?NlJjSHdIbXFSMHJmbWZEUTlNTmNWS05iQnNYNXhMbkgyZXBWck80b3VtWVJR?=
 =?utf-8?B?MmNxUjZBNFc2Y090V1dhTS9Nc0NCMlprMU56VWVWSWZRTXZNNkVrSnRDYjRk?=
 =?utf-8?B?LzdoUzMzd1FpWUc0d2tEbkNwVzRRTkU2S1lRVDZ5NmtlSi91WE5GdzdyMk5E?=
 =?utf-8?B?YUNhVHd0aGZEYUFkTzBVQzIxcTNycUJNVXU4cnF5cVJqUzJMUk5HOXBNQlFQ?=
 =?utf-8?B?M005UzVFbFZYcmFvYzAwOVlMbk1ESG1SQXNuVndRV3BaNDdTRXRyOVM4OUxX?=
 =?utf-8?B?V0ZxRFNGVHN1Uit2YXc3V1Btd2xQKzRlRUdBK0ZIUmdpSzdkV0EyZEduYVND?=
 =?utf-8?B?R0lvNUdxQTdRamh0anhGTklHWHNYaUVLNDZBdU92cHFKN1ZFMVhxVEY4UDc2?=
 =?utf-8?B?d2lORFQxcEFzbkw2ZDZXVWJEZ1ZyVm9JWTg2V3BjUkhsT0lNNEh6QVdRUW5q?=
 =?utf-8?B?SDFQOWJHWnlzQ2p1eDVFNmoraWpkTWNVWE9uTWJqQ003Vno4akR6M1JKS2hj?=
 =?utf-8?B?WGJIblJVN3RTc3FXOW8rdVBYdkxBa0NqTVpxSGo3UmlzSHlndkowU2F2MFhX?=
 =?utf-8?B?KzdhRmZpOHZPSkNob21oUER6YWlDdXZ6RWtQV2NDZlJHMlJOS01aQVBIblBz?=
 =?utf-8?B?Y2piNEV3VmNuSEZ0VFd3YWJ1T3pmNFhHU3BMamdrV2dSUUNpb3VuejJHcThW?=
 =?utf-8?B?TmVGem9rYWFwdmxaWkpvUWlITHpJamREUVVQR1lBaTRrSWxMdlU1L0lLNm5J?=
 =?utf-8?B?cXYwV2JXcitIVFNzRVhOTWJSdmhXZjQxb3JZejZRRVBtYnZqVHJZd0RlVERP?=
 =?utf-8?B?RVRmSy9mOW1YSjhjTXpPMmVXYVp1c3FYcUpCVG1xUFFhWlBrOElUMWEwNHRO?=
 =?utf-8?B?SERqWEpCSXpMMDJwMFJpYlRsdERnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96CA13F1DB4D5F4EBFA6D542612657EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6VOU2o3GbETn84IVHFcetJ+lHy3PPLA9KAUcZzUwyegzTXP/a2IkRSbivehbsD1JNyNWB5f7yqFfuns8gfVyuHCP09CKr69o8hXmneX3bwfeJ24XcpaHyURU+4NN2dykrJIuen5VfHWiMrcr+nRzKVXPRvPgUGCVB7EbW6CdMElYEj78ZQqSINr0xedH6hWKtWIVtUxKG1F+IqtcAOPhpHCidhg7+8wXTH441CBfUVTMfiKnUrDUoLBRMoc2Hq9sUtPIYmHcU/JWGzwT+Xhv+NuwCNukWnBYutW65TZFTkg78Kn5tYaOOgrPNnpS12V6qSrDLGRSkHfEX72GNcD3grzXYBqJ3aGvUvkOoFWZIA2pPfWCB2Qz944VkuchLvcdj+pbbxhZUOIYuccIR0LxsM3LXHq1u/QNi8Iayspy+aT9u1CIpwd4AJjRDXpv5IAsNOkBeL9L2KU8VSXx2tDaLIVLkwphFJ3BgSw25Teyiod7V5Ia6Ea2AWiWc/wzIKrd2bnzurIemeWJiCkhQhUv9gmpMqZXE1xXBNXsGBnvCSvptefKQFUX86n04StzmwVZ6oPVUB1f1/Zq+EsgiuO94YFXuHwiOVP3oKOIFSEi9it4S7pCFa4E4g/tXwA6gG7j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da76491c-07a1-4731-2681-08de1d19e062
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 09:50:10.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHnZ6ykjGfTbVPYKinOoHGHiwwyxxVeMvo0wCTAWrfsaJ3+n9LTrVWNviUQ+HfBCzN0kgmIoJ+u0ajuz13oTg4GY4rf+SDBDeaiYvvBDk18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6530

T24gMTEvNS8yNSAxMDo0NCBQTSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBKdXN0IG91dCBv
ZiBjdXJpb3NpdHkgLS0gaXMgcWVtdSBpdHNlbGYgbXV0YXRpbmcgdGhlIGJ1ZmZlcnMgdGhhdCBp
dCBpcw0KPiBwYXNzaW5nIGRvd24gdG8gdGhlIGxvd2VyIGxldmVscyB2aWEgZGlvPyAgT3IgaXMg
aXQgYSBwcm9ncmFtIGluIHRoZQ0KPiBndWVzdCB0aGF0J3MgbXV0YXRpbmcgYnVmZmVycyB0aGF0
IGFyZSBzdWJtaXR0ZWQgZm9yIGRpbywgd2hpY2ggdGhlbiBnZXQNCj4gemVyb2NvcGllZCBhbGwg
dGhlIHdheSBkb3duIHRvIHRoZSBoeXBlcnZpc29yPw0KDQpJZiBteSBtZW1vcnkgc2VydmVzIG1l
IHJpZ2h0IGl0IGlzIHRoZSBndWVzdCAob3IgYXQgbGVhc3QgY2FuIGJlKS4gSSANCnJlbWVtYmVy
IGEgYnVnIHJlcG9ydCBvbiBidHJmcyB3aGVyZSBhIFdpbmRvd3MgZ3Vlc3QgaGFkIG1lc3NlZCB1
cCANCmNoZWNrc3VtcyBiZWNhdXNlIG9mIG1vZGlmeWluZyBpbmZsaWdodCBJL08uDQoNCg==

