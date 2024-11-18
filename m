Return-Path: <linux-fsdevel+bounces-35056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E69D07B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5C51F2187F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F117993;
	Mon, 18 Nov 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="SFOVDr3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C19286A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895361; cv=fail; b=ryYwEoPJo8AUBCgEDxKg3z2BYIWFdEMFN3iKDTy7ePYj1TinMQ7xF3lhjbC1aVXgCMOWQsQG5EWTr6X5apgiKoFsdaxmRt3Nup7ihI4in0DU2DI31H76Q+m0Hfu//V5xiWGHiqZdh+x8DUAwXhjiVGiqYAX+EnsZbROLTPCLFOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895361; c=relaxed/simple;
	bh=JAWdN+uzREyOMv6PuS9IagPUa30B53PRl9rwKzZIAk0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gXHMXez4QzGh0d67UXcltN23ocYSo4cPxsyQYdPntxviPdmnpT2Lm6NWh0K+TQCtoWJQwZtn1MjTVKzbjkuEuEJVvuLPwSn5gWBDdN1rxFlaifoMymEgQod8eq3DvItazrqKHBeeB6Cgws0FJFhm+zT1/6+t0nDyBBveYSt9xOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=SFOVDr3f; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI0RsiN008585;
	Mon, 18 Nov 2024 02:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=JAWdN+uzREyOMv6PuS9IagPUa30B5
	3PRl9rwKzZIAk0=; b=SFOVDr3fjhxnTxTuBKQ7kg63kEUMRoXkMD5d6HEaZfdH8
	TvfCMBUUsunwtKlEkf612rI19ZbYL1ctAbWpDVqo2qM9EAJm3QWIqqg+8kRXrNlP
	3868RL8HedcDDCiZpzopaLJDnlDvpbt8dBH/oejUQbB6nJ1l4qUTqway+oZyDQpV
	F3kO1+Z0bap9a+zQ1IAgjtTb3c0qTPszDjgoeLgb0fKUCyt14I1NCx7fYRYmgfqb
	W6rMPLwp5gvZYD+UDrT77crAqqJVFCMkESw1laTVN5bD5C4485go2PcB4/Clvujy
	rNQsFhmLcGpsAfzj8rCcJ4lC2xqgWpihD2wRJ35hQ==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xmbes3sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:02:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A82+3vMfbIHeeSgXZlzjchiirHqSLHf4qCrOqWz5ngQvhMteA/iz39nDcZpe+yUMYCPvrGNd1k3O/9XB9VQXpaYNIbwmOezib8t7w97n1UMFV1oOQ6fGo3b2cWjcUhQsdpIL1cCo4YAMr04CvvMeqHuXAwFLsGGUMBc0bmIsI8VlAo7AaS2RQmij2dQCMv22HJH71LQNKKoDIJcUE44RmGwGAU/+wzBpCrS1ULnIN7Wyx+zOvulknaiYNrbfyE/W0UZUafHu31pYK6WuAxnBXnVs5YbCk3G6LK88AhssVN/B9c52gWFwtvT8uDo1F35z5htkhlXuwzYiWXy2Orxatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAWdN+uzREyOMv6PuS9IagPUa30B53PRl9rwKzZIAk0=;
 b=cawC/HFy9XICZUpDuFDBJib7yBUt048VLFskWIjS8XD04eLApMXU8F6XQ8aiFimo5oRwEfPLIcEGjSz66z+XkVERrACTUyMZMo2o9yoc6Arzy/OVDTrWQMJRPROcp1avYQ3guBuqtdeN1Y6ZAnWAw97sj4ZOP/xFTZ7sF33G1YHlFhdkN3cLoohtHZ6rdgXA2kmv7uI1Qgo0N05tVphiE41jIemVLnSt1YaBD8QXtlmj7zpAHAfOMu3K7BJVDvXuoKJ/EH9rqaLP8ynJL/GzaRuLZfEvbx0u+xu1zMzdiiPx2fCTwRxmh2x6xfPuUon3H7VD+0riRwrLteYdVkgPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OS8PR04MB8100.apcprd04.prod.outlook.com (2603:1096:604:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:02:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:02:19 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 7/7] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v3 7/7] exfat: reduce FAT chain traversal
Thread-Index: AdsE8b4Rg6sTcpHXTLKC6v4wl4SyRA0a1tqQ
Date: Mon, 18 Nov 2024 02:02:19 +0000
Message-ID:
 <PUZPR04MB631639D613F463AEBDE647DF81272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OS8PR04MB8100:EE_
x-ms-office365-filtering-correlation-id: ee62788d-d1db-4717-e92c-08dd077508e0
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlRaYkpwTUJsWU5NYnptSjJKSmFMRllQeTZsYk9acGJZZURuNGlQM3dwb1RH?=
 =?utf-8?B?eXZBQWZnTEhHMVdNdTdqSHZCRVpZTTJNamJ4U2JQSHdoU2tTWmFoUGdSOFVj?=
 =?utf-8?B?VEdVMENsSkN3LzF4eVFzQis0UUxoZEZlVkVIZ1pURHgrSHZZY1RmdXdBUHJp?=
 =?utf-8?B?UVBNWWlXMGN6dk9EOXI4MGpCWmsxTjY4ZE90eDdQNldKYTFJaWJkNHFwcENp?=
 =?utf-8?B?empERXV1RVpSRUZzbGFTUE4xKzhVbmxWZTBQOXhxM05zbzNkd0t3aFFyS3k5?=
 =?utf-8?B?V1F4MUJGRmxQTUtRQmlycjNJMnpvWjgvdEQ1RytQSUFpRStsN0ZKYnlsbGNF?=
 =?utf-8?B?di93bkRYVFpDZGo1YUhBTUNLa1dFV1JSWFp2NldCR3RaMW9LaGQyNElPMFBO?=
 =?utf-8?B?dzBzRlRsT2pkdWI0cnZpVFBGUlhLQzRlWXVkZlhDT3VYdnJVWWtZbDAvazY4?=
 =?utf-8?B?TU81c2ZBYUpENUJRKzZOUzluOWRHcEsyM1RLM2wzclFzVDB6NStnL1gyeUdZ?=
 =?utf-8?B?TVZQQWxvUDlFZlJwZ0RkVDFaV1J0QzRSdU5xYzFpSlQwYjhtTDYwRVRPVko2?=
 =?utf-8?B?bTZkTDM3RmNvSGFCVExyMHliYitUUW4yZnF3b3VucmJ1QUI1K1FvdHkvRWtn?=
 =?utf-8?B?bndVVFYza1pSbnIvYkYweTZMcnZYUTFCMGs1Q3ZJVWNlR2sybERPY012c3Qw?=
 =?utf-8?B?VnRyNnYxaVVleVVLSThkMm9reGhSSzdYV0FqeUJkQWdIdFJhU29Nc2I0R21X?=
 =?utf-8?B?bld2R09yQUtrTDJSaThJeGZiWjYrM2UyVU1LWGNTV3ZtbGFUVHVoOWw4Vm5Q?=
 =?utf-8?B?d2RTc1lpejU4dm91VEw0VDgrMXp4bmp2alJUaCtwamNLQXRBdG5ZVmtIRUJC?=
 =?utf-8?B?cllpSmF2aHJKMWNnb3Q2WGZQeU84bFpXOGN0dE9YMWxTNk1mVUtRbWVmVHM5?=
 =?utf-8?B?M1VtNTJ2RDNOSldJdkZPanhtWWxtVU5CT1AyOTRpTm9XSy82ZVFYM1VlMkJK?=
 =?utf-8?B?TlIzT1B0RzJGbElvK3R5dUtIai81bHU4UDdVNUhhRjNTQWVKZzJQSTNhaDRR?=
 =?utf-8?B?SmowR3BRRjZaTGRvU0RmY2FXRXdodE5iMWFheWlrOGZjNUFMWHo2SjhzQ2My?=
 =?utf-8?B?QTJkNUZQWkRoYW82QU9kY3hFODJNLzVkKzgyRkZDMzM3Y1NBd2tqcCtLTDVL?=
 =?utf-8?B?MXBkMzNHUmk5UnZXbVBpNlNobDlTenlKa3dLcUhZVWptYWVGNzF2emJnaVFN?=
 =?utf-8?B?bXBIR2hkSk1GWm1jdUYxd3dsYjlUSXl1bU5hUlZjbmVpYlZQalVpanhQRnR5?=
 =?utf-8?B?UEFjZ3dnSkZXUWcwZWl1c0tEbXlWSWxuQmJSemVlNUcxYjQ4bDRtbDE3czFs?=
 =?utf-8?B?bTF4UWVKZ3QwVjE0L2Q5M1RZeHQvZ3lqejZnVWFMY1pkSGthVU1ZbGl3Rzln?=
 =?utf-8?B?MlJodVdrTjAzL2FRSU5NWHFTMldFQzB3WVBrallWVVZZZ21VTVdZNmgrWVYy?=
 =?utf-8?B?TUYwcUprVEFxZCt4WWdLMlRNcU9mNGVybXhoZWZUZ3JWektqZDZmM2gyVTV2?=
 =?utf-8?B?aG5uNVk4Y0E3eTU1VWhEWXM2K1JtTHVmTzRVNktDczVOK0R6a2dCVEE0aEpP?=
 =?utf-8?B?T2hRSFVlRzhCWVB5cHJUZ1dpNVc0N1A0UnlUeExaMFFPM3EvWnl5NllUQzRl?=
 =?utf-8?B?aGh4L0dXZ2dtL0Fud3RiblpsWk1oZWpmQk5sMmdOYzR6cXAzdk1Pa1AwNWpR?=
 =?utf-8?B?OE1WZXQ5NTdmSEM0ZVU5UkdwK1Q1TGJHR0RYVE40N0lsQ1c3aFZTMkJVTjht?=
 =?utf-8?Q?2lmGvkAu7BOUuVeLvaJhZ3S60gIDxflmwlPqA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bldwQkQyaXJRd282bmFBdExLZDdTMGtrd2k4MFhXQ1NVYjVWdWNnUjhPc0FQ?=
 =?utf-8?B?TmIzM1BhSWNDR2tMVTRWb0U2TlQ0MW1SbDRvRTRJV1ArMHJVWUJDbThyNzVl?=
 =?utf-8?B?SHUrK2xJM1BieThzbXZxelJwZHg0elVhaCtpWDhwdTFuOXpsQnRBcjFIQ1dx?=
 =?utf-8?B?TlVLSStqZlBvell3eTVFZGFjUk80dGQ1WktOSjNHR28zYzluWnRZdDFBMUNH?=
 =?utf-8?B?akVhamljS2M3VEQrc2JCbnY2dnRoQUpEQWVjNjYzaVQyUjVocW52MjlHUVZS?=
 =?utf-8?B?bnpUb3RWT0lxZk9hZUx3RkhtK3ZRSkZZSzU5QU4yS1hpTm5nRmwzWmQxV1po?=
 =?utf-8?B?VTB3WlJWYmZhUitZTmVGSm1JekFLV1pPdlBoY1BGalFwYk5keTRuRkxwQXBu?=
 =?utf-8?B?empRUjh4dHhCM3FlV3B1U0Y0S2t1VE5hTFF2SWJQNVl3SWJXY2Z3TGFlbVNZ?=
 =?utf-8?B?dG9MMFQ2dUg2VkRidmw0cytPQzBKV252NmJrcjRJVXR2cGZsbXJvbnNlamhl?=
 =?utf-8?B?YzlYalhoTExkdktaMWVtd3dRc3BYUEY4cTBWOGgwVS93UEM0TThsK2VHM1lu?=
 =?utf-8?B?TCt4bm15S0ZzWW1MeE9CTGtVRi9lQ204TEsvKzBIMEV6Qm5ERU1nVlJrMkUv?=
 =?utf-8?B?dHZJQmpsR0x2a1dRS0k1TEFnZnhqUmhSYTA1bEdpWmJFL3NMZTQyWFlvMVNo?=
 =?utf-8?B?Nm5pTGZzR0NPc09FQTNibGwzamtBUktEQU43U3paanFrVWRQQ1FLamdxckJB?=
 =?utf-8?B?dzNzcTlhU0pZMlhkSkRhY2V1VE1KbmRZRkNyZWV4RWZ0L1I5TjgvaC9tcDkw?=
 =?utf-8?B?cTEvdHdYaHlTcEN4K1YzRUpJWWFTcHhZd1Z6WXIyRGpHQXJXeGpUb2RwVEtW?=
 =?utf-8?B?UXBYZmQrVTJnbHY2NTFqMlA4UTBTeE5GREZWelYyNElWU2lFRWlOUEJNZExN?=
 =?utf-8?B?Y3FzT3JjQVFUcmRWV01ycnNWS3YvQXdPc2lKeU1oVENjYmt2Z2VwcmpxcmxJ?=
 =?utf-8?B?RmV1UW50VHhWaGYrcVZCbW0wYzFxUmJwb3NxRGxCZ3NsVU91ZlJaOWgySFpC?=
 =?utf-8?B?ZXY4VHYybEdQaEVSNmRsV2pTS3cwUDRuZThSQ0dIUU8rdU5RMGJOUjdwSThZ?=
 =?utf-8?B?dkIwMWljalMra1g5T051Y0FId3czd0ZOT21mQ1R1dEhwUk90TkRXaDZ3ZEF3?=
 =?utf-8?B?Y2dIQXB2YVViMTMyeXkyL3VKY05xODdhS0tvUFF2UXh5TWEzamxQYUxIWGdM?=
 =?utf-8?B?a01pT2VZaVUxaGdTZ1FVU2l0WXV4RkJVQlFmd1JVMG94ZHpMVFpjV3FqcHBq?=
 =?utf-8?B?WENBeFdOdUcvbUxZd2xuZXpOMHE0SXhYKzFxQ3A1OWV0Y1YvTzJGOXhpRFRi?=
 =?utf-8?B?SVRMVHY4Z0hNcmxwUmYwVU5uVnZpeG5WUFVyUUxkSm00VE1rOHFPc2R1Tmkv?=
 =?utf-8?B?S3VqcjE4THJMRlBsT2g5RHhmWVNsSmdsemNnTlhrZXdvNWVRWWFLL0NkREQ4?=
 =?utf-8?B?K05PUGhINlhlWXVFL3prWlUvUUx0TUFyN2hIY1RVOWdDdW50ZU16ZTRibjc1?=
 =?utf-8?B?ZWlTVURQS2s4NEVPaitWTkQzcDZmVGhITkIzSWsyUTg1eWRVZC80TmlrU011?=
 =?utf-8?B?SkdDOFhtRnBwZUY3WE1zM2ZwaXVHMXZhclRvRVQwdDM5YlltZjdiN1FWV0VW?=
 =?utf-8?B?YU1hTFRIQWt3N1dkdXlNeGQ1QnJBbG8rVld5ZVQzRFd0Y3FTZ3pWRDNwaitF?=
 =?utf-8?B?ZVhiUzJUNXllNVNsZVVoN3dGbWxQREpKRWlwNWZJdUtuSEp1b29VUURKWExC?=
 =?utf-8?B?YWNQSHRodmI0M2xveFAzQ2RFYVVDL2RndXNwZ3h5Q1FoM3NDY1dNR0d2TjJR?=
 =?utf-8?B?QXE4V0U4WC9jRlNtVWRqVG5RSFBXdW9WdWh2SE1zS1J1bGh0eFJEMlo1MGho?=
 =?utf-8?B?dXNnS2RVVVZHZTlRRTl3MmpUbGlZM2RoRkZnK1NodmtEUDF3TGFmbm5DUHZV?=
 =?utf-8?B?TnhzK2dHYzVVeCtramdQUm94MGxWeHlpODFodXJVY3J5RENhQU8wT0tpeTJw?=
 =?utf-8?B?RnJwVnQ3NTVyR1EyMndoQUdZQ1ZCOVN1TDhMcjZGRld4Vk1aS0ZLMWxISG9F?=
 =?utf-8?Q?MhTMLAN36SDLx8bRMc2IGx6M7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hYlej/y7hgnoD0mQwYMNg5P19cm4QiOhm36/aBBgR2K7ZytxrVwmhQvKhtuYfoq8TXFSMZn+rgluWasxrmdPlpIYhfgCR1tku31juTtZbYcAq5eU72H6+oHy3RPVLC9/G06dwWrkxHimKfCHZjm3/ywDa6x24iolNBKyN0nwDkMDpE+czlHqYsQL/P0IpWjvYBakYSE5g7j9RXg1UoIRWVmoH23CI9Khq85sHmVShWo8sSyV8wXFUM7whE93jLwbCkxTP7I8hehAozlJ5LoP968Ka8zafT1DvoYJNqBDJ/AAAF2Z8K338NBK0/mREAaTySaYFNZwU901qb4gepH0Sli0AeYcxBjuJvuWIDFOFv4EQu7N/z2gQ9TF/v0NrmF8WzMCRiUICaAVklSAnum7T02fRKGqpML1zfyi+woknu2QG7HlsFGoMhxL/B+diAxxyTrcWM6HHSKPdkFbB+0A41IR2l7ALvof2RjyNsx4Dttn7HS/9kY8a7k3xzOI4FFyRGZksm7K4L8NVZt44ZVQZZGP3RESPy3NoFCDVTDNVFiRswfq2XI4+bo713cTkx9V++ZQZKXhzZ+78NetQ9WdtvLvJAhaiOe0O/fDUG/g2brzrKZkvciRQOTVmwWFm8J0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee62788d-d1db-4717-e92c-08dd077508e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:02:19.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ks3SFl5pRITKYirAkQoiYBGh9a+SquYybBRTIbZgn4mYGdMbubI1AecSDLotFGdfLTuYVVM5ZYbNelnROejXuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8100
X-Proofpoint-GUID: TaMVQaQd7pwa7CKOCv9GXwzwoZXwt3R6
X-Proofpoint-ORIG-GUID: TaMVQaQd7pwa7CKOCv9GXwzwoZXwt3R6
X-Sony-Outbound-GUID: TaMVQaQd7pwa7CKOCv9GXwzwoZXwt3R6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

DQpCZWZvcmUgdGhpcyBjb21taXQsIC0+ZGlyIGFuZCAtPmVudHJ5IG9mIGV4ZmF0X2lub2RlX2lu
Zm8gcmVjb3JkIHRoZQ0KZmlyc3QgY2x1c3RlciBvZiB0aGUgcGFyZW50IGRpcmVjdG9yeSBhbmQg
dGhlIGRpcmVjdG9yeSBlbnRyeSBpbmRleA0Kc3RhcnRpbmcgZnJvbSB0aGlzIGNsdXN0ZXIuDQoN
ClRoZSBkaXJlY3RvcnkgZW50cnkgc2V0IHdpbGwgYmUgZ290dGVuIGR1cmluZyB3cml0ZS1iYWNr
LWlub2RlL3JtZGlyLw0KdW5saW5rL3JlbmFtZS4gSWYgdGhlIGNsdXN0ZXJzIG9mIHRoZSBwYXJl
bnQgZGlyZWN0b3J5IGFyZSBub3QNCmNvbnRpbnVvdXMsIHRoZSBGQVQgY2hhaW4gd2lsbCBiZSB0
cmF2ZXJzZWQgZnJvbSB0aGUgZmlyc3QgY2x1c3RlciBvZg0KdGhlIHBhcmVudCBkaXJlY3Rvcnkg
dG8gZmluZCB0aGUgY2x1c3RlciB3aGVyZSAtPmVudHJ5IGlzIGxvY2F0ZWQuDQoNCkFmdGVyIHRo
aXMgY29tbWl0LCAtPmRpciByZWNvcmRzIHRoZSBjbHVzdGVyIHdoZXJlIHRoZSBmaXJzdCBkaXJl
Y3RvcnkNCmVudHJ5IGluIHRoZSBkaXJlY3RvcnkgZW50cnkgc2V0IGlzIGxvY2F0ZWQsIGFuZCAt
PmVudHJ5IHJlY29yZHMgdGhlDQpkaXJlY3RvcnkgZW50cnkgaW5kZXggaW4gdGhlIGNsdXN0ZXIs
IHNvIHRoYXQgdGhlcmUgaXMgYWxtb3N0IG5vIG5lZWQNCnRvIGFjY2VzcyB0aGUgRkFUIHdoZW4g
Z2V0dGluZyB0aGUgZGlyZWN0b3J5IGVudHJ5IHNldC4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhh
bmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUg
PHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFu
aWVsLnBhbG1lckBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCAgNSArKyst
LQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgNCArKysrDQogZnMvZXhmYXQvbmFtZWkuYyAgICB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAz
MiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQv
ZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggMjQxNDllMGViYjgyLi5mZTBhOWI4YTBjZDAg
MTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBAIC0x
NDgsNyArMTQ4LDggQEAgc3RhdGljIGludCBleGZhdF9yZWFkZGlyKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIGxvZmZfdCAqY3Bvcywgc3RydWN0IGV4ZmF0X2Rpcl9lbnQNCiAJCQllcCA9IGV4ZmF0X2dl
dF9kZW50cnkoc2IsICZjbHUsIGkgKyAxLCAmYmgpOw0KIAkJCWlmICghZXApDQogCQkJCXJldHVy
biAtRUlPOw0KLQkJCWRpcl9lbnRyeS0+ZW50cnkgPSBkZW50cnk7DQorCQkJZGlyX2VudHJ5LT5l
bnRyeSA9IGk7DQorCQkJZGlyX2VudHJ5LT5kaXIgPSBjbHU7DQogCQkJYnJlbHNlKGJoKTsNCiAN
CiAJCQllaS0+aGludF9ibWFwLm9mZiA9IEVYRkFUX0RFTl9UT19DTFUoZGVudHJ5LCBzYmkpOw0K
QEAgLTI1Niw3ICsyNTcsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X2l0ZXJhdGUoc3RydWN0IGZpbGUg
KmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KIAlpZiAoIW5iLT5sZm5bMF0pDQogCQln
b3RvIGVuZF9vZl9kaXI7DQogDQotCWlfcG9zID0gKChsb2ZmX3QpZWktPnN0YXJ0X2NsdSA8PCAz
MikgfAkoZGUuZW50cnkgJiAweGZmZmZmZmZmKTsNCisJaV9wb3MgPSAoKGxvZmZfdClkZS5kaXIu
ZGlyIDw8IDMyKSB8IChkZS5lbnRyeSAmIDB4ZmZmZmZmZmYpOw0KIAl0bXAgPSBleGZhdF9pZ2V0
KHNiLCBpX3Bvcyk7DQogCWlmICh0bXApIHsNCiAJCWludW0gPSB0bXAtPmlfaW5vOw0KZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRleCAy
OGNjMThkMjkyMzYuLjc4YmU2OTY0YThhMCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2Zz
LmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC0yMDQsNyArMjA0LDkgQEAgc3RydWN0
IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSB7DQogI2RlZmluZSBJU19EWU5BTUlDX0VTKGVzKQkoKGVz
KS0+X19iaCAhPSAoZXMpLT5iaCkNCiANCiBzdHJ1Y3QgZXhmYXRfZGlyX2VudHJ5IHsNCisJLyog
dGhlIGNsdXN0ZXIgd2hlcmUgZmlsZSBkZW50cnkgaXMgbG9jYXRlZCAqLw0KIAlzdHJ1Y3QgZXhm
YXRfY2hhaW4gZGlyOw0KKwkvKiB0aGUgaW5kZXggb2YgZmlsZSBkZW50cnkgaW4gLT5kaXIgKi8N
CiAJaW50IGVudHJ5Ow0KIAl1bnNpZ25lZCBpbnQgdHlwZTsNCiAJdW5zaWduZWQgaW50IHN0YXJ0
X2NsdTsNCkBAIC0yOTAsNyArMjkyLDkgQEAgc3RydWN0IGV4ZmF0X3NiX2luZm8gew0KICAqIEVY
RkFUIGZpbGUgc3lzdGVtIGlub2RlIGluLW1lbW9yeSBkYXRhDQogICovDQogc3RydWN0IGV4ZmF0
X2lub2RlX2luZm8gew0KKwkvKiB0aGUgY2x1c3RlciB3aGVyZSBmaWxlIGRlbnRyeSBpcyBsb2Nh
dGVkICovDQogCXN0cnVjdCBleGZhdF9jaGFpbiBkaXI7DQorCS8qIHRoZSBpbmRleCBvZiBmaWxl
IGRlbnRyeSBpbiAtPmRpciAqLw0KIAlpbnQgZW50cnk7DQogCXVuc2lnbmVkIGludCB0eXBlOw0K
IAl1bnNpZ25lZCBzaG9ydCBhdHRyOw0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9m
cy9leGZhdC9uYW1laS5jDQppbmRleCA4Mzc4NjkzOGYwNmMuLjgzODg1ODJjMjUyOSAxMDA2NDQN
Ci0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC0yODgs
OCArMjg4LDIyIEBAIHN0YXRpYyBpbnQgZXhmYXRfY2hlY2tfbWF4X2RlbnRyaWVzKHN0cnVjdCBp
bm9kZSAqaW5vZGUpDQogCXJldHVybiAwOw0KIH0NCiANCi0vKiBmaW5kIGVtcHR5IGRpcmVjdG9y
eSBlbnRyeS4NCi0gKiBpZiB0aGVyZSBpc24ndCBhbnkgZW1wdHkgc2xvdCwgZXhwYW5kIGNsdXN0
ZXIgY2hhaW4uDQorLyoNCisgKiBGaW5kIGFuIGVtcHR5IGRpcmVjdG9yeSBlbnRyeSBzZXQuDQor
ICoNCisgKiBJZiB0aGVyZSBpc24ndCBhbnkgZW1wdHkgc2xvdCwgZXhwYW5kIGNsdXN0ZXIgY2hh
aW4uDQorICoNCisgKiBpbjoNCisgKiAgIGlub2RlOiBpbm9kZSBvZiB0aGUgcGFyZW50IGRpcmVj
dG9yeQ0KKyAqICAgbnVtX2VudHJpZXM6IHNwZWNpZmllcyBob3cgbWFueSBkZW50cmllcyBpbiB0
aGUgZW1wdHkgZGlyZWN0b3J5IGVudHJ5IHNldA0KKyAqDQorICogb3V0Og0KKyAqICAgcF9kaXI6
IHRoZSBjbHVzdGVyIHdoZXJlIHRoZSBlbXB0eSBkaXJlY3RvcnkgZW50cnkgc2V0IGlzIGxvY2F0
ZWQNCisgKiAgIGVzOiBUaGUgZm91bmQgZW1wdHkgZGlyZWN0b3J5IGVudHJ5IHNldA0KKyAqDQor
ICogcmV0dXJuOg0KKyAqICAgdGhlIGRpcmVjdG9yeSBlbnRyeSBpbmRleCBpbiBwX2RpciBpcyBy
ZXR1cm5lZCBvbiBzdWNjZWVkcw0KKyAqICAgLWVycm9yIGNvZGUgaXMgcmV0dXJuZWQgb24gZmFp
bHVyZQ0KICAqLw0KIHN0YXRpYyBpbnQgZXhmYXRfZmluZF9lbXB0eV9lbnRyeShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLA0KIAkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwgaW50IG51bV9lbnRyaWVz
LA0KQEAgLTM4MCw3ICszOTQsMTAgQEAgc3RhdGljIGludCBleGZhdF9maW5kX2VtcHR5X2VudHJ5
KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogCQlpbm9kZS0+aV9ibG9ja3MgKz0gc2JpLT5jbHVzdGVy
X3NpemUgPj4gOTsNCiAJfQ0KIA0KLQlyZXR1cm4gZGVudHJ5Ow0KKwlwX2Rpci0+ZGlyID0gZXhm
YXRfc2VjdG9yX3RvX2NsdXN0ZXIoc2JpLCBlcy0+YmhbMF0tPmJfYmxvY2tucik7DQorCXBfZGly
LT5zaXplIC09IGRlbnRyeSAvIHNiaS0+ZGVudHJpZXNfcGVyX2NsdTsNCisNCisJcmV0dXJuIGRl
bnRyeSAmIChzYmktPmRlbnRyaWVzX3Blcl9jbHUgLSAxKTsNCiB9DQogDQogLyoNCkBAIC02MTIs
MTUgKzYyOSwxNiBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmQoc3RydWN0IGlub2RlICpkaXIsIHN0
cnVjdCBxc3RyICpxbmFtZSwNCiAJaWYgKGRlbnRyeSA8IDApDQogCQlyZXR1cm4gZGVudHJ5OyAv
KiAtZXJyb3IgdmFsdWUgKi8NCiANCi0JaW5mby0+ZGlyID0gY2RpcjsNCi0JaW5mby0+ZW50cnkg
PSBkZW50cnk7DQotCWluZm8tPm51bV9zdWJkaXJzID0gMDsNCi0NCiAJLyogYWRqdXN0IGNkaXIg
dG8gdGhlIG9wdGltaXplZCB2YWx1ZSAqLw0KIAljZGlyLmRpciA9IGhpbnRfb3B0LmNsdTsNCiAJ
aWYgKGNkaXIuZmxhZ3MgJiBBTExPQ19OT19GQVRfQ0hBSU4pDQogCQljZGlyLnNpemUgLT0gZGVu
dHJ5IC8gc2JpLT5kZW50cmllc19wZXJfY2x1Ow0KIAlkZW50cnkgPSBoaW50X29wdC5laWR4Ow0K
Kw0KKwlpbmZvLT5kaXIgPSBjZGlyOw0KKwlpbmZvLT5lbnRyeSA9IGRlbnRyeTsNCisJaW5mby0+
bnVtX3N1YmRpcnMgPSAwOw0KKw0KIAlpZiAoZXhmYXRfZ2V0X2RlbnRyeV9zZXQoJmVzLCBzYiwg
JmNkaXIsIGRlbnRyeSwgRVNfMl9FTlRSSUVTKSkNCiAJCXJldHVybiAtRUlPOw0KIAllcCA9IGV4
ZmF0X2dldF9kZW50cnlfY2FjaGVkKCZlcywgRVNfSURYX0ZJTEUpOw0KLS0gDQoyLjQzLjANCg0K

