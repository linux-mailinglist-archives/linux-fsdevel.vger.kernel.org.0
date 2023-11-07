Return-Path: <linux-fsdevel+bounces-2265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18387E430E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 16:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35271C20D46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E931596;
	Tue,  7 Nov 2023 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VixJUz/r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fH7zVCZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B32DF72;
	Tue,  7 Nov 2023 15:14:04 +0000 (UTC)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F59CA5D4;
	Tue,  7 Nov 2023 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699370044; x=1730906044;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=QdGlmmYovxloso7kzvBz8xdM4FXSFafPsl5ek5TxfQM=;
  b=VixJUz/rBtS9wPrQP9KWB0P0X44BpWb7WeSpLjG5aZQ6y3o+sHGXeFBH
   ITlp0cpSLT9TRz2l4CEcuvWJinmekcAkemem+A6uMzuVCWEHqm5yTRVa7
   hyguL8M31QtaA1sSr/nwcvDpsuPD+JbiKxQec8cL8xjXvHlSLwgGHq8aQ
   DLQTjoq/oV/ksqpuy4QeozO1LTnDrDP9Zcd7Mh77eeT0HVMaBJXUKqFQh
   7IxWD/CAFKtLJA14Nj6YSYG9B/SVCRfAsM/tmxp9JisvBNMK309xgz9Io
   BYJPSgsVImuYSnDg/wibDhQGGKFxQTiEeDBFHgHYGKAO196Bb1toueahG
   g==;
X-CSE-ConnectionGUID: T7aGJkAfQ/eCCF8/2zZYbg==
X-CSE-MsgGUID: sGXnWr9VQomzcSM401AUrg==
X-IronPort-AV: E=Sophos;i="6.03,284,1694707200"; 
   d="scan'208";a="1678631"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 23:14:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFt13YshTUv/UprYnj2aNPxYqVwGnOSd2BRmuXSQ38UvU2Rqo9LO9l5UZA0gD6xbwXzLrWJ9GfkMMxC30D1AMYUll7UHl7e8TvtgY46F0p0kKgeOibnckaGOiA71BVUJXZ8f4jKCvzI5cSnGDu45UQ+QP7i33XP5cDqk9owfjEMnbIob0Je4kAbaU+ZdkZVQC53JBupKVGoo3cFBAphW/w3NosbDI3NvOM1om9raDaYy3nRnyUyO/e2H0wYgkLSVFHY5x9aKFMR2eNsrWc+xIvKVv+OsUL5YLAvSatnCrtK/Qm3PhrYftOqysIi70SxGLzclaL7mMSv5k4cGaHWS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdGlmmYovxloso7kzvBz8xdM4FXSFafPsl5ek5TxfQM=;
 b=IWnvnt26/3wiTGFUPcdqW0KUkEwlErhMkI9oR01TTtT+wo0Zbno8cn29eVzAJ+z9hqL3m7E9ohqCNyRpFh51yeX4cMX4Ye1I3bIvT2BoauSzLzmz3PDOacWRCFeJJbW/KoO+WBukc9XwMXuL6qA9eNYUfkBt9lN9NB+RdetBG1xKI5Ebor6NaT84I78yMezM6uTGPpGbVScffnR/rGMOlHC6db2Xq9/zBcovcB95NRVLyJxSQ0lUGkSLR6nNcqLaBagBvMIBypp7eE1eyDAWNtH6cU6/ji1tz/XorUpslnBvu1r8jW+rdY1+PSTE1yXuSbrapji9nSlSH6l6Mkvm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdGlmmYovxloso7kzvBz8xdM4FXSFafPsl5ek5TxfQM=;
 b=fH7zVCZjd/Fa+54pb91M1nXlevOJJwh8SJmb/5Sf5uqogAZ+Ly7JcmPTDA6+3Ws7a9ADVXvMRO23DrI9MDyeaKp/uYRqvSkPDNA891ulhHeestt1s/hBrAA3XUhYmoLZrzqgbWfR6OTYD8izHIlVQH1TOiqrFbbs0RhI3hQ4nME=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6593.namprd04.prod.outlook.com (2603:10b6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 15:14:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d52c:c128:1dea:63d7]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d52c:c128:1dea:63d7%4]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 15:14:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH 04/18] btrfs: move space cache settings into open_ctree
Thread-Topic: [PATCH 04/18] btrfs: move space cache settings into open_ctree
Thread-Index: AQHaEP3W4/dDABzmlE6WbCpU9HUKLLBu+BYA
Date: Tue, 7 Nov 2023 15:14:00 +0000
Message-ID: <2396e9f4-88ef-40c3-acfd-e1703a487a91@wdc.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <93c7e11e73d40b30cd086b0b32ad8b7a86060442.1699308010.git.josef@toxicpanda.com>
In-Reply-To:
 <93c7e11e73d40b30cd086b0b32ad8b7a86060442.1699308010.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6593:EE_
x-ms-office365-filtering-correlation-id: e03816c1-e289-4b6d-8ddf-08dbdfa42c19
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d7qwiSkTGgr01mAyaKfwZnfkJHvxK0gTKX8wBc03+qCgzl74rqiDQO16jQQfMG2Cq5ebtY3z43civx3eaKB8BBmpvFATdM+7wXOA7uBko3AZYIPmUy5+fMhewbbvPbxqOydcbMXrHc79ZiW9+wsgKaC1dndfwiRDgqdNStC8rXdrPmVum/CGwLdH0utsf64dMOPnTSsosGmeMzTSVzpUSkqjesCzXWxK1lu+W2lneyNBxCY8CL5efDnrTJuTUWwoFkv14748Y9BbJtaeX9lAcbaXZ691c2HBWCjQb8hEq5Q7FabW1La0yx4M7N+Qp5sWiEu2Y1h2c73AwsbWuXq8UENufJeUSXGdV0t1td7ShEDwd9ItpiVwwTFZrujgFyKkCq3E2EWUGYOQVit0u9nULXG3MO+gnoARadVKZl4pkNNIE7gfCuSofIoQHzxC1ENYomEzIOnRT+mwQFCaYtqTwECtf8YNMoaYH72leAIMxr71ukOSdrTv0eaUPGRiuBA12GV8WN2o9qMNUrDnJoEYzhsfPuj7/QdIO7ATHcky+oOu/b7EJqqaBvwtDIh0Fn9TRGmPQvMavIsjI0ytQ7lYwsTE8VDhMuiypHRFUb9huDjNScJWzdEtV5bd1dbk6izt+tQBa/DbyNa74bMU1ZSOdkA+Aq7uPMbGYSiBu0Q4VAo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(31696002)(36756003)(38070700009)(8936002)(41300700001)(2906002)(86362001)(4744005)(8676002)(316002)(478600001)(110136005)(71200400001)(91956017)(6486002)(6506007)(66446008)(76116006)(82960400001)(122000001)(5660300002)(66556008)(38100700002)(64756008)(6512007)(66946007)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUpGVll5Y1h5Y2pCd0xtTnNibHlBdHo4UWpHdXJURGJxdGFSZ0VLQzNXaEFa?=
 =?utf-8?B?REpwUnBQbXN4ZzFaVjhab2JPbXd5WmFoZkkxS2xGZ0VKMi9ERXNLMUxheUgw?=
 =?utf-8?B?VjdiNFdEeE52bG5hY2U2UnpNeDQ0Tm5qY0V4MkhMNjFYN1ZwNnVDRDVoT0pX?=
 =?utf-8?B?K1h1WTNxM2xkTFR6Q2gxeVNrdStGemJPb0ZyWlBEMko2SHhMd1FKc3ZheXFF?=
 =?utf-8?B?WWxuc0VuU24xYjVjNlRZQXpXWlNIQVJZbDQ4WHlYMDc5QWVMcUd4b1NYT1dP?=
 =?utf-8?B?YzVtNHU0WXhoSWdaWUl3dU9scGxKK1Q4UzNLZzlyYTV2TWsxMFR4cnIvdTNZ?=
 =?utf-8?B?VkhQWU94bnVoZmkzSXFTS1FheUJkZ1F2Tkd6dGh4azd2QjB2VDhIRFZXemVy?=
 =?utf-8?B?U2ZhQTdHZUtYcDNBdkYwUGxFVkpHa0NlOEE5RENRd1ZPL05FcjRDaFBOdmpL?=
 =?utf-8?B?VHdXejJXTkNpWXJzdlFEN1hCNnB4dXFlQ2JVamxYVTdGK0VZcEFjamVqV0RX?=
 =?utf-8?B?L0FZQTRWSGkvd1F3UzVTbWV6aVcyWDhaS0UxZ0VhQVNOZnJqZUFWZlBZMDZJ?=
 =?utf-8?B?Ky9ZR25qZkNnb3V6di84ekFoallhOFJGUklUeGV4Uis1aEg5Vm12ckNrenNq?=
 =?utf-8?B?QUJsVzZpaCtFQWxBUUd3V3VPaEhqTy8wVTdZdm83TE5saDBWakRNRXBmWmlM?=
 =?utf-8?B?eXFERFptSWNsWjVUVGo3ek9KT0JpdEF3V1VBUG9vTjFYRGIrdExiMWxWbEpS?=
 =?utf-8?B?U2JsbkRmMDJGUHFSMHhCYnFXZlZWNi95Sm1XU1VQMFZzL3l0YnlQSU81ZXZv?=
 =?utf-8?B?TytjNUVtbjlzYUVIMkFDQUNNU2x1a2JoMCs5Sk1JRFFxZWlQYXZYbHJwMTUy?=
 =?utf-8?B?eVJ0TzBrM01rUlgrQWdEbUVWODlJRUhpZFB3ZndNTGpTcWgzTGsxaHFvRUs4?=
 =?utf-8?B?MVNXUitjMEtpd0x6c0tFOFlLalNYNHlXeUJvUFYwdWpENWdZcTZLRDRGV2Rm?=
 =?utf-8?B?Qm9jSTZCazNDa3FQTkloMGlGYTJVSDljU2U4R3ZjejByMWNCUUZXeXJ4bTZS?=
 =?utf-8?B?M29uWlFINTkzSk1GdnNjcUhWMjAyTkVqam5tTXkxWGtTNXZ3cUw5MzhybUd0?=
 =?utf-8?B?Z0ZBV2JxNVVZSldaSFJKSDZwNkdRMkJKWnFWcktScmhFZ1o5eitFK0J5ZDNu?=
 =?utf-8?B?UnZZT0NLVzE2aU1kNzBzRjV2R2VSWWFCZkxsWkF4clc5RTdyTmVHZXYvQUEw?=
 =?utf-8?B?dkV4RUNFdjFkRDJYS2p2bkxRMVhsc3JOVlF0bnMwWTlIZDlWUzJMMVFGQTFp?=
 =?utf-8?B?S0hpNjZGelgyT1JMS1UzOG5DZm1YdUVuaTQzKytZNDIrcHEyVFJqRmxKS0cv?=
 =?utf-8?B?YWlrNmRkNVQ1bDNMTnhZOW5Od1RjS1FSSDFyUmRnbVZ1STNWazN1L3V6QWE0?=
 =?utf-8?B?Y0xqOWhscGJnN0hiQUJKK1h1bWFjb29vWWx2RkdSanRSNmNwZGhVd3FWWXor?=
 =?utf-8?B?b1RObGJCYVJWa3NRUWpPMEs1d0wzNU1ZUzNpdFVidUgrRmt5QXRWRE90ZzNI?=
 =?utf-8?B?MnZhakNNM2ZuWWdaSFFxQzgvWERPUHVqaXdHMW9nY1pMdFY0OUpVRmNiSnJW?=
 =?utf-8?B?d0pKd1lZelY4bTJucTA3SEsvdjFPblZTMkU0djBqZmo4WFE4bVFIYjhWUVR0?=
 =?utf-8?B?UjFpNEpsR3JiNXlFZHBVUHVyczlPWjQ4c2ROUm52RGFVeEliUkUrR3BDVld1?=
 =?utf-8?B?aXpETEI2a0I4T0F3ZTY1UThBamJOUTVHcHltVEdRTERXQ2MwNjN2emV4N0sz?=
 =?utf-8?B?MDVPWG5uUThBdDVRbENBaGJCODl6aUtxRWNoemlua0gwYk94NmdsamJ4WWND?=
 =?utf-8?B?QTA1czduaVAybEFtYVRnRnZkdW9McFpnaGZLQTVGbitGTXNCdU1LYVY3QnBz?=
 =?utf-8?B?TDU2Q2k4MFpXRU1GVW1YdU0xMDZ2aUN6akFOZHFpL2hUekJQYXRVQnA2T1F3?=
 =?utf-8?B?VGdCMzIyemxTMGl6RVlFenNnY0tVNjNhYU5JU04rWjJ2Tm40TnV1M0F1Sll6?=
 =?utf-8?B?aG8xeVdLek91RUtsd05BOHE0K3ZRdGZ0RnpiUDBEMXRoWmhLb0xVWVJKS2kr?=
 =?utf-8?B?R0I5aERNelI3Vk03a3BveVFDVEVCR00yVW41TkRaTUZlaXJlVUFTd2p3aEEv?=
 =?utf-8?B?MFpXSTR4eVUxZVRJY0hjMVBpSEZkRDRDMjhmUzRJN1Z0QWozYmFxdXd1a21P?=
 =?utf-8?B?RzRPTy9XcGFkaVoyQVBQemxZSlhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A35E61057297B5428F2349C85500C302@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGjETKiEwEsUM67A1+pkxIf1Awgt0aBZ0fZ8wKmc7AZ1DuyDujBxIf0jtjZNlLG+58OEHecFHfwEdk8+j/q4PFIOcl1BTYsndiVT9+LJrWawi2k6K1K0qAc3OJjN7GV0x5D0lrYzb2zgXRYbVzWMigtjWElKUQrTYOKNHldO+Mk6wlGSBn2YNxa4AuO1gPO6CPEiL3jF4TPb9QvW5WyEEydVxh036+j/nJn+H6imh5iko/KhrtNfbXlWVZ3c1cLluUx3d8O2TPdtM5PPbr2ZzEZTAlS/gj3lx0HDjBLVwpOOdmltQk8PBwNARfh052r3Gary8lwpSQ573jNF1j75/GJulCAyji1HT8jufiFL3xKpvMkt1D8HcQzjS+XhHxb8zmIka6urajg1zoma/ekdnN3ecCtwTtpPUzAhPnB3IupE3MI+CR9bnnBlVmtB47Ooj7LgZPPqYmn4gPPZDwTuRuHcUfLPrZNB6IJcCS622Hdm5p5qlTf9DvupUhVPggDSfffAnzn+9cOi4/8giFtUmWfG6YtZWptBLweQZGw4yXoEqXS7bgX1gPBw37bRsxTMdNUJYUcLfPjrn/tVD6giN5bPB3OxMiXDeLFgscDYj0nasCL3r7GBD41Dsi/NF7bwZlUbg1AeivIxtjMujY04ey9vPBAc5T00y82+EbVSMs05CtkxKc/jMJ4ONqKNZqlkbW1ZLy3IbRiRRQvZVSglxjV+xDQ8Qa9nROGoNXNO+cv50LhKE6DDh6YXPZMAoWs6iUzBBTpryC+z5RCW9XUOVv45+z/hNma8OupRS5i8YEpf0TGjBxy6GT1Vt/W73Tpe/k97DAvPrOo0d0t1y2jUZDNGARJYDu5XHR8iOm4eHpC059M68WGDnvMgoiTz/XOS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03816c1-e289-4b6d-8ddf-08dbdfa42c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 15:14:00.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1trPuJfJcpj6Scr31pdJl2YiIFvkciCX3uZTf5vqiEgGIkbOYEWWQ/ncUxWJj2dUj5jO+XIgpPCpRXq9CSatV7HJa08plbCiGEgdATrBCmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6593

PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZnJlZS1zcGFjZS1jYWNoZS5oIGIvZnMvYnRyZnMvZnJl
ZS1zcGFjZS1jYWNoZS5oDQo+IGluZGV4IDMzYjRkYTMyNzFiMS4uZGQwZWQ3MzBmYTdiIDEwMDY0
NA0KPiAtLS0gYS9mcy9idHJmcy9mcmVlLXNwYWNlLWNhY2hlLmgNCj4gKysrIGIvZnMvYnRyZnMv
ZnJlZS1zcGFjZS1jYWNoZS5oDQo+IEBAIC0xNTIsNiArMTUyLDcgQEAgaW50IGJ0cmZzX3RyaW1f
YmxvY2tfZ3JvdXBfYml0bWFwcyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJsb2NrX2dyb3Vw
LA0KPiAgIA0KPiAgIGJvb2wgYnRyZnNfZnJlZV9zcGFjZV9jYWNoZV92MV9hY3RpdmUoc3RydWN0
IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pOw0KPiAgIGludCBidHJmc19zZXRfZnJlZV9zcGFjZV9j
YWNoZV92MV9hY3RpdmUoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIGJvb2wgYWN0aXZl
KTsNCj4gKw0KPiAgIC8qIFN1cHBvcnQgZnVuY3Rpb25zIGZvciBydW5uaW5nIG91ciBzYW5pdHkg
dGVzdHMgKi8NCj4gICAjaWZkZWYgQ09ORklHX0JUUkZTX0ZTX1JVTl9TQU5JVFlfVEVTVFMNCj4g
ICBpbnQgdGVzdF9hZGRfZnJlZV9zcGFjZV9lbnRyeShzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAg
KmNhY2hlLA0KDQpOaXQ6IFN0cmF5IG5ld2xpbmUuDQo=

