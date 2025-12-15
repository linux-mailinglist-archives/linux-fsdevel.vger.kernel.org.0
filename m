Return-Path: <linux-fsdevel+bounces-71349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAFFCBE5C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B395C3047932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F642DF134;
	Mon, 15 Dec 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="0eRTIJYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A9253F11
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809544; cv=fail; b=Lp723Iz8+SdTx366unQS0yc1VCHBOH1UsSI4s/IWuNfR3HjtEFwZPafMz1P6uOnhEcQdfME6ylaoF/UI76BMD/PZ1MnTy1g9k3l4WAjEu5hCxmz1FaQw8vR5sE1PH0IyXjr/jOhmR1GOfVa9CxYRuZHdig3eca/pmK88J8SL81c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809544; c=relaxed/simple;
	bh=T/RRMIy1L6eSwVOCOWdxbd4PAGh8k/2e/6HXPn94CjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvmrE4SbFFlAUEJMfaoW1JUmoMIAUqIyPIa36VjOMR2Q3I/9hgGSuGRA77zZjReZRKLPEMjBrcd2/KLXPg+2lPB92plsGG9KHGR4UXLr37P0KfpPqAYOBMfSvemhcP+o7V0RPCB3dSLLYV8bcme4VUbOS7kH+wm495aWmNmwviw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=0eRTIJYO; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020097.outbound.protection.outlook.com [52.101.85.97]) by mx-outbound14-141.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 15 Dec 2025 14:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlwwDekSVW9AtYawnuAO6T1eBRuE8FSt+am1w3jGkVyBBdj6vwZ9UbFVN4rFgL9hhWpEkKsoyhang1dSZGlJRLXWwopeaHPeq17cc16FTmAPoNY4rfVSvgmwMN0mOiTa8vIlLyyXnXVuylbgLNAq8o0BbfK+Eoi85+Jb1OQAMWBDuTVZUiOU1mjIr9+JQU1mfX3m0OJ4ah8mU85yos/iaNeqrjr2ooLR+Vg+h7YqWjjIrygwhf5ntPa+o3PT6PUOhdYqEjoWjujKEizF5+XhdghVo+/DKyHsfdmSc04nrte94uldjyuyq/n0/M8AeeMZ+1w59ZSE5rsm60ftDleBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/RRMIy1L6eSwVOCOWdxbd4PAGh8k/2e/6HXPn94CjQ=;
 b=RkkD8Kq+ZTVnpMabuRIpLdFyv93LQjnovKN08yQPk79OcTZmUA6ZstxVLMP+lFs96eT68QZU/CeAfqi715JF+76V5jvuG99G1J8UwO9PIubQnrTtCFOLzty4JRlvHGGPsK5XSPRPN0H6iopKvcqLt6D5KzU+cxgPDcGSYtvOU+Nq5y15/oVEmKrqW6BplE6nlF47O1u3FYySCzRWA37OI8GtR5Kde37XJ28pTacuQEFlBqVX20d2go0bLT0GdFCvosqJMDYXKaejfvi1GRTFhRAGyFa8qXsnthZHnnSRG6jU2Qqb3xQXFXe3n8aNKpRFjaXDj4U8xfnN+8wKjXbYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/RRMIy1L6eSwVOCOWdxbd4PAGh8k/2e/6HXPn94CjQ=;
 b=0eRTIJYOIEBTpBeqtdl2rygDznKNQw4M5+bv+2YQ35ns27WzSp9WQE47IevO/uAdGlFTv49tDV7ixrxv+CaVQlUZgErcOaQ3v9iHISZ+UUEj4+bM0Jj6mX6QxY2xU9KaQfNhcIF0gCasir8VEdz2SPgx7avjcCPOSpAYA6JDU70=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH3PPF853095874.namprd19.prod.outlook.com (2603:10b6:518:1::c37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 14:03:37 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 14:03:35 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong"
	<djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, Horst Birthelmer
	<hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 2/6] fuse: move fuse_entry_out structs out of the
 stack
Thread-Topic: [RFC PATCH v2 2/6] fuse: move fuse_entry_out structs out of the
 stack
Thread-Index: AQHca5L6jqL2G7XPM0eYhoiTPay7hbUiwA6A
Date: Mon, 15 Dec 2025 14:03:35 +0000
Message-ID: <834d6546-a87b-44b9-8f1e-53346a9bb7e6@ddn.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-3-luis@igalia.com>
In-Reply-To: <20251212181254.59365-3-luis@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|PH3PPF853095874:EE_
x-ms-office365-filtering-correlation-id: 30da085c-5fe3-4b82-d9a2-08de3be2bd41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHlwRnd4cDJEb0FrdW1QaDRId05UZ3k4dk8yZFhRY0pnNnAzMmxpUmpseExK?=
 =?utf-8?B?em9GcXNjNUtsZllueTd2N09lZCt6S2NZL1lCYkc0a2EySnZXM1lHWnMzM281?=
 =?utf-8?B?ZW9Eckpkdm5Objl4QkdQclpzNlNvWE9od2YvZEFRekJoTkV4T25nN1U3cXh1?=
 =?utf-8?B?cmVyL3BaaUNRaDB0d3UzUWdDWUVOeE1sclRCc1FRVWNDeENMT3hOSU41Ri8y?=
 =?utf-8?B?WlIyU2gvRklEWElYZ0cwczJSTm5YVVM0bllIdWxVeUpsMmRIQ2hkallRenYw?=
 =?utf-8?B?bU5nVWxuQzNlZG9YOVY4L3ZYdXYxelk0d0tLalc5b2RFNWZvelNyK0FCZk1F?=
 =?utf-8?B?dDVacXpyZEdYcTJFalhSL0F6aVJoY1A5eU5BdlRLdEJyWnZLZmxvV2I1SnZ3?=
 =?utf-8?B?b2lUVWRBcFNFZEZMUTVSSzBGSEhWc1FNRmhSSFpYYnJ5a2xHYjVYTWl6SzZa?=
 =?utf-8?B?VGwvOG9SOUNNRlBHWVMxcVRleFYwN29rVjlxSnJ1bExZcjRjd1NhN0pKc1dr?=
 =?utf-8?B?dURtYWVkaGc3WEJTQVlhdVpiZ3IybU9HMDdySWZ5ZGYyVzFJWEwweDZ6VjhU?=
 =?utf-8?B?OTBnVENUNkdtaEUxek4rVVJua01sbzVteWtidldUT29HT08wVEpmOStLalhm?=
 =?utf-8?B?UFhTc1JDWVNpRXNQbG5vNWprTDhQTU10NDFxamJad3Qxb3FBZFZoWDd0UFA4?=
 =?utf-8?B?QVRmbTZQUlZNV0g0VGNXUFZNcHpPWlFxUGZ3eUJZK1o1K05hZHBPd2hqbXJV?=
 =?utf-8?B?TEYrYW1MVmRzdFoxTENZMFhZRUNQM1V5SWVDaE9SK0hGVjNZQ1N3UEVLMmJk?=
 =?utf-8?B?dzBycGppcDNhc2REQzlaRzRlb3BaME9zay94c1Bjc05Rb21LQ0h5QllVUFl3?=
 =?utf-8?B?b2pXWWNJWVdDSWdURGtzMlBaZXdKMk5kNGdueTZzNUFyclRoanBXWW5sUFhS?=
 =?utf-8?B?MzVvZlliQkU0ZUJoL09Ta0JjNldFYkdJK3MxWHNmdU9nZ2NUUG5WaStvZlNK?=
 =?utf-8?B?RDc4d3hYNU5XbkNGd24wT0dJQ3pvbVllY3N6V2t2Tzc4OEM3eDRTeEFTdWlK?=
 =?utf-8?B?cVJTSWFjL2tEbyt2MHB1UFl0K2JnQk1VaHVOWnB2aCsyd0E4YUVIWWJYTDFr?=
 =?utf-8?B?MHFlWk92b1VlREF6OXZ5N0wwaDRMQmdzWVlKSk9sbjFoVzJOTFRlTFdnM2hY?=
 =?utf-8?B?SE1PRERDdFdDS0IxWW1sRlFQQkt1M0I0TzliZUJ6VXNUeHB0TjUwVm8xNEQ3?=
 =?utf-8?B?dWw0SFNYWXRUcmVwYyt6bWNWZEVrcEw5YlUvdmpGd3IzYnN1d3JORXNNbGNN?=
 =?utf-8?B?Q0xidGVTbERZbzIzQ1lodWJBY01Uc3E3a1pTNlhNTU0wNlFuYlRNTjdCMkJK?=
 =?utf-8?B?Yko3TEg4NnF6S0tmSFVnS1RBNjQ2dytLbmoxemIwZU1TM1FINlErRG5xMVhK?=
 =?utf-8?B?S2JpdS9SVjA2UDUyVnhlekxFQzhIUUI1ZUxxdm9qbndNbmdhYm8rOFhSNWRX?=
 =?utf-8?B?RWt3aGxUSlZqa0ViME5CVUNJeFRIM0dNUVZoRjVrdGdNM1JLZjVSdTJ4eUxn?=
 =?utf-8?B?T3c0Ym9zVnpwOEltdC8rWTRNay9uV0s1cE9sZFcyRXN5SFk5SHhGNmM2L2dh?=
 =?utf-8?B?WXQ1M0poZGxaZkpsUExuMlppL0FjNjRwTHpjRmtTUE1yM3NGRXRzNHd6a2JH?=
 =?utf-8?B?Skt1MkxVSVBCQmJYRTB2KzhqcUwwZ3JpOGVNQm9JenpQdmVyckRWV0ZoQmRy?=
 =?utf-8?B?QkhqbXQ0Y0RiL3pLK2dCVmRWNlhyYXNmRGQxWGZjelVIRG1mNy9sKzQzV1Bl?=
 =?utf-8?B?dEx0bGwxQjYyRmp4dEo5UVY5K0pCbFFzRHNIbXRZaXpoN2VIRTk2QkZJN05T?=
 =?utf-8?B?RTVjYTBxWkxrcExRWGtnY3doSFV4dkl2NWxOYTl4cHBaWmE2djRKdzM4OEFm?=
 =?utf-8?B?M0ZUcnQ0cUdpZU9NQVVDVGxsTEhHQ1dBMmFEcGpjaGluaUVjQVJNbk9rMWsw?=
 =?utf-8?B?U2lEeVNwZTRkaHcwdWJHZStZTmgyMDRQTkJ0Z3ZybWYwVGRjakQ3NDZKbStE?=
 =?utf-8?Q?WrP8ea?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmdJNE1VekNBR1Flci9XeERiTFhwdUlwcUZYMlFGbTZ4VjM3VnQ4U3VRL2dT?=
 =?utf-8?B?bmhrVERZNFo3UVZTdmtEU0JXQVZ5dldxdVdiTkhPcG94Q005U3loc29HdGNI?=
 =?utf-8?B?STZnVVp0ZGk5ekhIY3lQU1hOVVJQSERwam5rL1B0dUxVQ0YvWUhBbzVTeDVz?=
 =?utf-8?B?TGJZWGM2b09kYW9JL1ZibEloU2tJdnJSemhBandZcGNMUUdoajhDRGlRaWpN?=
 =?utf-8?B?aGRFWHVYS1ZNTlQxUVJUMGY0MDhDc2NOdEV3ZVUzcHVCbjB2NS8yTVVKcWhP?=
 =?utf-8?B?VDYzd2pHZUM5Uy83eUZMVWJUV0ZPN1R2cUplOXZRSWVSRndnRkRUWXBUK2JZ?=
 =?utf-8?B?UFMyT1AvbEZIVkliT1NGTzNmVk4vYmFyTWJJVFQxejhDMnZkRWdvWVpFeG1n?=
 =?utf-8?B?d2xZZHMyWnIxNkUrNGRDbVhlNmIzU1JDa1gwc1YxTDNlNnNzTDViU083L0FE?=
 =?utf-8?B?bG95UGo5cmN3NkJJVVB2aXI3Nm5vLzh6YnQxVE1vUEI4TVA0bnZDQ3FFNWR1?=
 =?utf-8?B?a3phUHkzQXo2V2xJY3VQdTAxaU9neGNvOTY4WFBJYXNtbHpVMUJFbFphaFAz?=
 =?utf-8?B?aUFIUC9YdmpsZmt6RXE0WDBONGJ2WlNGMjZqZldPeDd0YUZINEdOQjVadmY1?=
 =?utf-8?B?SkI4cUE0MktueEZORHFWL2xrNUQ1cjJyMmFyWng1aGhQRmN0aHY5Wk8xdVU0?=
 =?utf-8?B?elQ4NXpKeFlEWmNVdzIxekx3NlJOMXRWZjVsbCszTVl3VGxyVHBKbGNicDRC?=
 =?utf-8?B?di9Vb3lNbUU3NnZIQWZDYk1UM1VoemtCV2IyRXJBQzcwejF3aHhoWXJNVVlP?=
 =?utf-8?B?TmxxZ1hSd1VneXBuWDVPRzdVYWo3aXN0SUo4NDlVNVR1aEFxRFVqVE9Vc09q?=
 =?utf-8?B?bjdDZWR0WDV5cHpOcUQySUxjcWtiOExtMzI3WENmTG9aeWU1cDQxL1MzN1Fs?=
 =?utf-8?B?eWVJVHZpWWtBV0RtbEQ2b25oOXBCSUEzUUNyM0VKcTk0YUlkRWNHcXRLajFv?=
 =?utf-8?B?eDVGRzJOZTZrQ0xuRzkrYkNkaGFoZEQ5QTNQSVdCekhMUzRPVzU5YkdOZE5H?=
 =?utf-8?B?YlU0ZkFBeVpiNWZ0dmVrR241Qk9VN2doeWlCcld6b1prM21HMHppaVdkWUll?=
 =?utf-8?B?K0ZVUzhodGg1MVVKa2U1MzJ6dlNlUUlma0pUWTBLSHlIaUYwc20vejRIMGpY?=
 =?utf-8?B?eDhMSUozYkpUSkFkaGFMencxZmlsaDZFd0NaV2tIYWpCSXdra1lSM016SVFP?=
 =?utf-8?B?K0dubmFXK0VvaDkwS05qbnV4MVVVTy9aU1NnUG91L3IwT3hMbzlKY2MvekZi?=
 =?utf-8?B?ZW1nSFVtU2ZWRmVBMGRBSDE2VlZFL2J5SndMNm1hMmFsYi9NY3JwQjFTT2dP?=
 =?utf-8?B?aVZ1S085QnBKNzhMSWZ2M2NiT1diVmFsMVNjM2dPV1phYnhraTdhNk9pN1B0?=
 =?utf-8?B?ZFNaTi9Lb3RmaXpVaU9LNlFZNGxZdG1XK2M0Yng4bFJHN2RJQklpRHd6a25m?=
 =?utf-8?B?NGxNOGlsd045Sy94SDJRNTR5bU44UkZjY0FBK3IvWlhiOGVmSW1INGJnTE9j?=
 =?utf-8?B?clZVckVVTHNWWHk3Qkp1eVdZL05wNklyUXVGWTdia2FwQkc4eUovelJ1OUhD?=
 =?utf-8?B?dFRiY0h3bko3VyttMWxGRkJwSDBkWFNURXkyK2daaUR4bVF0VVNvakUrN0VW?=
 =?utf-8?B?TW9XRlMvSlFzdytKZTRMcFpWMndIVFg3L1FmQWdaME9lcUZML2FHaXFOL0dT?=
 =?utf-8?B?SG41WFR3d2oyZFREci9RMk9xa1BJTXNORDlxTE9laVNFK0VTTDNDNlIzYUtK?=
 =?utf-8?B?M0R3NXU5d0F5WWJmZndxUE9aL3lpcXY3K3dLWVJsSlFyMnFyVFRuK1M0RDVv?=
 =?utf-8?B?ZFBKQWg4eVM0Wk85dFl1ZUU2dE45K0o2bkJadWZodlhrS2ZIZDFYZ1huNjl1?=
 =?utf-8?B?Qjg2QVhzTnp4VDRKU3VLcXBWdlVwb0RwelBhUFNrY0dxYWpGNkxOMlNVdTNw?=
 =?utf-8?B?a3lBY3FqLzUrQjYyaVljbmdKaTY1cmFEcGRlWmczemRrM1lKbGQwcDVwbkpZ?=
 =?utf-8?B?N3VQYUdRUDdSZzAwVHk0OHV1ZytkYm9LQ1RzRklyUWtvNXo0NzJPeitSaTBV?=
 =?utf-8?Q?sIXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B10DDA5CDEBE4459849E2A6E5D20758@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 m9juskFtduWLBJeCu0RCthvNMAl57Z5wR+057y22E1E1xGPA9dOHvpqgm+RwzKJJPS9VyU5hOwS467oPmkg6zKXMm+9mWJrtG49ov9osP6goM5UfrsGWt5OTelAR1YbPAY0IKWiB69QMYLyBO2Yv7ugPtJA9FaSY/gbwIvdsFIkY8X44wXXZEQCSYUM60jrQ8ZKNue4bzbxzwWq/gAHfYh9fB+Lu1xQsFonSkQo5lb8mVpfq1gAu3JPsZpnPBNHfSb/hqx56L0rolloB8u9PpWhtOo5SSBReFxI9elvczmuMVltwWC7AMsJlYFINADzt+bb5lBZSHjC5Ehguj5pi3hI/XthcF3PnFtRn9y8s7OM8wusaXKzcQC3hEv+ghqvuP5iZnfBAsFXRStdgCh5YzyvAH5IO90dN5qT5lvz67T1OkPLjnNQOIHyH8lOPVGrwUA4MZHg68Kx56snhG17PUYfvamvZ8yQroLT9D7eAR/c4YSRMLl8iN0Pn6bAZCfn/dXy1poxx467FNlfE6oGXZxb+C/dM+PSHI7u1bGqH7Jkv2Sg0UafV/fzVnwXXBeon064q7gYHrwRnWVtMyudLDYLva0MMJXhM8zqY6GSfzhJyoAd9fPVBSMtyBrbTEj3ZRJ6nMMcLMHYeG2vuGc4vBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30da085c-5fe3-4b82-d9a2-08de3be2bd41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 14:03:35.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfGKo7L8PzuV7AFt34OXcL4pock0Y4+wvhasZSxS26SNsXBq4vMzHa8BMO/2jXmCbpmRH6FudOfOYfZklursCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF853095874
X-OriginatorOrg: ddn.com
X-BESS-ID: 1765809527-103725-7672-7041-1
X-BESS-VER: 2019.1_20251211.2257
X-BESS-Apparent-Source-IP: 52.101.85.97
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmhiZAVgZQ0NA4NTHRJCnF0j
	w5LS3NJDnJ3CDN0iw52dDYNMnQ1NJYqTYWAN4vHG9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269682 [from 
	cloudscan17-103.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTIvMTIvMjUgMTk6MTIsIEx1aXMgSGVucmlxdWVzIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNp
bXBseSB0dXJucyBhbGwgc3RydWN0IGZ1c2VfZW50cnlfb3V0IGluc3RhbmNlcyB0aGF0IGFyZQ0K
PiBhbGxvY2F0ZWQgaW4gdGhlIHN0YWNrIGludG8gZHluYW1pY2FsbHkgYWxsb2NhdGVkIHN0cnVj
dHMuICBUaGlzIGlzIGENCj4gcHJlcGFyYXRpb24gcGF0Y2ggZm9yIGZ1cnRoZXIgY2hhbmdlcywg
aW5jbHVkaW5nIHRoZSBleHRyYSBoZWxwZXIgZnVuY3Rpb24NCj4gdXNlZCB0byBhY3R1YWxseSBh
bGxvY2F0ZSB0aGUgbWVtb3J5Lg0KPiANCj4gQWxzbywgcmVtb3ZlIGFsbCB0aGUgbWVtc2V0KClz
IHRoYXQgYXJlIHVzZWQgdG8gemVyby1vdXQgdGhlc2Ugc3RydWN0dXJlcywNCj4gYXMga3phbGxv
YygpIGlzIGJlaW5nIHVzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWlzIEhlbnJpcXVlcyA8
bHVpc0BpZ2FsaWEuY29tPg0KPiAtLS0NCj4gICBmcy9mdXNlL2Rpci5jICAgIHwgMTM5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgZnMvZnVzZS9m
dXNlX2kuaCB8ICAgOSArKysNCj4gICBmcy9mdXNlL2lub2RlLmMgIHwgIDIwICsrKysrLS0NCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDExNCBpbnNlcnRpb25zKCspLCA1NCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9mcy9mdXNlL2Rpci5jIGIvZnMvZnVzZS9kaXIuYw0KPiBpbmRleCA0
ZGZlOTY0YTQ5MWMuLmUzZmQ1ZDE0ODc0MSAxMDA2NDQNCj4gLS0tIGEvZnMvZnVzZS9kaXIuYw0K
PiArKysgYi9mcy9mdXNlL2Rpci5jDQo+IEBAIC0xNzIsNyArMTcyLDYgQEAgc3RhdGljIHZvaWQg
ZnVzZV9sb29rdXBfaW5pdChzdHJ1Y3QgZnVzZV9jb25uICpmYywgc3RydWN0IGZ1c2VfYXJncyAq
YXJncywNCj4gICAJCQkgICAgIHU2NCBub2RlaWQsIGNvbnN0IHN0cnVjdCBxc3RyICpuYW1lLA0K
PiAgIAkJCSAgICAgc3RydWN0IGZ1c2VfZW50cnlfb3V0ICpvdXRhcmcpDQo+ICAgew0KPiAtCW1l
bXNldChvdXRhcmcsIDAsIHNpemVvZihzdHJ1Y3QgZnVzZV9lbnRyeV9vdXQpKTsNCj4gICAJYXJn
cy0+b3Bjb2RlID0gRlVTRV9MT09LVVA7DQo+ICAgCWFyZ3MtPm5vZGVpZCA9IG5vZGVpZDsNCj4g
ICAJYXJncy0+aW5fbnVtYXJncyA9IDM7DQo+IEBAIC0yMTMsNyArMjEyLDcgQEAgc3RhdGljIGlu
dCBmdXNlX2RlbnRyeV9yZXZhbGlkYXRlKHN0cnVjdCBpbm9kZSAqZGlyLCBjb25zdCBzdHJ1Y3Qg
cXN0ciAqbmFtZSwNCj4gICAJCWdvdG8gaW52YWxpZDsNCj4gICAJZWxzZSBpZiAodGltZV9iZWZv
cmU2NChmdXNlX2RlbnRyeV90aW1lKGVudHJ5KSwgZ2V0X2ppZmZpZXNfNjQoKSkgfHwNCj4gICAJ
CSAoZmxhZ3MgJiAoTE9PS1VQX0VYQ0wgfCBMT09LVVBfUkVWQUwgfCBMT09LVVBfUkVOQU1FX1RB
UkdFVCkpKSB7DQo+IC0JCXN0cnVjdCBmdXNlX2VudHJ5X291dCBvdXRhcmc7DQo+ICsJCXN0cnVj
dCBmdXNlX2VudHJ5X291dCAqb3V0YXJnOw0KDQoNCkhvdyBhYm91dCB1c2luZyBfX2ZyZWUoa2Zy
ZWUpIGZvciBvdXRhcmc/IEkgdGhpbmsgaXQgd291bGQgc2ltcGxpZnkNCmVycm9yIGhhbmRsaW5n
IGEgYml0Pw0KKFN0aWxsIHJldmlld2luZyBvdGhlciBwYXJ0cy4pDQoNCg0KVGhhbmtzLA0KQmVy
bmQNCg==

