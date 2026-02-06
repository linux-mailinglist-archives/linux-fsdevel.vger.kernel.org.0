Return-Path: <linux-fsdevel+bounces-76642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEYLM4pDhmmbLQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:39:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 487CD102DBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4413B3022918
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C530DED7;
	Fri,  6 Feb 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X1gUROMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F2309EF4;
	Fri,  6 Feb 2026 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406718; cv=fail; b=FhKuIMIXQJkhNJ6G9dGkYPDgQaS0V+PrzWxqC4VrlQmUs+278UQeEksUwUDBWq5QIHSKSp56BBSm28aUIJAucyyaqhLUXGPyAubqhcRAILqWdB5MD2KZ4vN0/R1if3rrPGMQvc28h/f93NCzpgpg4MrVgrq2QQrp7tX1lu7p6X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406718; c=relaxed/simple;
	bh=inanp4+9cqkh5db5nSJ3IlDRXq5Aew3ACJ+jJvUBc1I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Afjrl7tiiFRbf1nokMsT7uV1FfqIxUsOS85X5gU/bxaHViIV9EAS6XdsUYaVKjx061T1MsBPkxdCa0bapgzY2tnpOSpKF1pV7tJWFAV+YpIXvgkNA6UQPZa1E5QOSJu1U7ejeFo8LQSJQ5zW+LbxdXkLyHq+2KOVQBg/rhGe58A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X1gUROMQ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616AhgXj032516;
	Fri, 6 Feb 2026 19:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=inanp4+9cqkh5db5n
	SJ3IlDRXq5Aew3ACJ+jJvUBc1I=; b=X1gUROMQ3yOdQRxCkEP8yhPoun4ncVT07
	5qXNIk008GlFzCsyhSjwDzkxS3v05EMzjAOhw74ALjY417qJdG8Js/ZogbVs/E5A
	g6ZZ6PFPZwJT55Qick5SAVTNnrOu60uCwni/Jw6N9pmkGRmxWLgN56E2pojKOS0Y
	qG/oNpcJJ9c2sQ8nf1jkICUcjdJLbix7quC3xFgEfml0tgO5ZDXAjwNvDUcKQP2N
	o1G1+0Stj9qngpRbHFzZkga+sMHpgvfWeTdW60GtdUHzJLrVz+ZRQLdUPHEdlbg9
	sg4e1rF26Mar+BqmPkejbI5B30jgCgDkVQdKZRO098SCkXIyH/tVQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986w7jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:38:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xho/vUg3GYQzCi1xEJK2TTvtWVauWr6iHIl810+gNCwF/LTtH4jsbisenRApu2h85/bz4XXRo2UxFG0htZyRiTLbW/4IGm0QwkEZSspZuFvxGMMzCyoh7q3emsnfBVj9B7eP36NGpc+SoMxH52kEBYblEAHNT/PJ2iW37bkTfq/Du1ISGcadBiPYJsrKYdo4QWWSioHINHFvwo6K0BTw2t5i2xtiDHS7EUQjDC6IrbP/fKN1z5ffpoPrzSJGbIQLSzXq/wOxNO7diS1f3rVhkFzf4UhACevy8TPy4m+OG+zh+PfepaqhVadmlNa7eD4fW7NFhUz/Quyghr0JoNwetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inanp4+9cqkh5db5nSJ3IlDRXq5Aew3ACJ+jJvUBc1I=;
 b=SDDx9SfNhVSVnXq86MssO3Xfx19WMqDa/bPWJlMRG5uOynEi5VNyAoAL1IPhCqwPu7ZmuDEXnxe1mlIm7aVyU55e1ycZDYt6KF7TD14c6B8CjktTPBaZhF/QD7ue0VR2TzU6ZTK9ecVbt5A1fX8kymOOOEmddHvH1LhbTU/4H08pQ+z1DTNjXgKCzGk9V93gfdHgRnuIe5yUTvjA91h4vxF9XZixerNc71sM6p/WAblr9qWDndaMKyJuPC5LewdIa1sGahlyxcrVnX7Eq44xS93G4T5evmQQQH8MVhxYE6S+5nLa72+0NyJkWctia+9chykf7fBw4i9eiTBKskNxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6599.namprd15.prod.outlook.com (2603:10b6:208:51a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 19:38:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 19:38:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
Thread-Topic: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
Thread-Index: AQHcl6AqIZ7MB3V3T0Kp7gdR9aR7gA==
Date: Fri, 6 Feb 2026 19:38:28 +0000
Message-ID: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6599:EE_
x-ms-office365-filtering-correlation-id: 163f708d-3e5c-4739-b4a7-08de65b74d4f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2ZLRjB5Y0U1NG9nb2ZwRzhoWmVlaVRDRjZMVXF2S3FTYUhldVUrWFdrSFA1?=
 =?utf-8?B?cEpCaFBaTHc3Y1VnOTJLdUxLcStxanliRnJ3cWI2SzVyYVI3M2s3T09ta01H?=
 =?utf-8?B?Yi9KcDBEK1ZEYjIrRjRnR0hhOTR5UldPU0F1clJhUDIvd0Rud00vQmZGVHk5?=
 =?utf-8?B?VGhJMzhkd1RpV2lUTnZpUDAvWmlWZ1FkTjQ1MmwwMzYrdFJWR003Wm1hZTlL?=
 =?utf-8?B?NEM0SUxETjQ1TE5OaEZUbUZsZFg4UUp6TGV5R2JHYjNrdmFLWFhqcTFwZ0dz?=
 =?utf-8?B?WlZjN1FjdmVQNmxETzR6d1hUdWlNQTFyZFQ0enk4WG1PMkIrdnpNWTRFSWE2?=
 =?utf-8?B?azgvMlByZWxYTlk1VUpxbDVLdCtpNmE0OHVnNFlmWkh1QXFJakxkK05TTkth?=
 =?utf-8?B?RTlzYk1scFB3MmJSMjdJZlZDaWh3MEt2cmFBM3dkL2c3VDROcHlCK3lNNW80?=
 =?utf-8?B?SkxtSnl4SXFVM2gyNGR5Znl5MjlZUkh1QXBObHBhUXd5TURYQVZxNmxKNnZQ?=
 =?utf-8?B?cGh1WXVKcTZmQVJEalFOa0tSN2NENzRGa0ZUN2FFOGExWG9ZN2R6Mkwwc296?=
 =?utf-8?B?Q0d2RVdOZm5SSGpMc01NOHVmUlBiR3ZEaE5jTSs3UVYyR2pPSmRtWWtLY0Qz?=
 =?utf-8?B?TEdLL3EyK3pvMVh3a1I1Z0ZFN3ZBai9DTWx4RDZjQmd6d2hWR09NVHBaTlBn?=
 =?utf-8?B?NHZFeHlzQjZBc0Y5dWtYTzhaOGdyYWJsSFV2NCtPWjFDWEhTOHk1QXRpZ2Nm?=
 =?utf-8?B?ZHRKOXBqMDgxL1Q0T3lDQlNqS0MvRlBMQ3NsOC9pRUhpVkE4WlUrRUxMQzRs?=
 =?utf-8?B?ME1DTE92aWE3NE1aUThGdU9yZDE3QURYcnJTZFNQa0FjUVhDK21ueEJmY0Qr?=
 =?utf-8?B?ajc5ZzE0Ri9CMWJTNFlrTlpPa2ZRSzJRTjBmeXdEY04rOTZrekZWcEQ4aCtp?=
 =?utf-8?B?YUE0TmJJelpRbFZNSGhlQnBqcDJKYXhxNjJHaG0vczUyL2hVS0xKV1hnTlI4?=
 =?utf-8?B?dWhNcDhZbmp3TzBOTGJ2Z0ZhV3hoNDBiMkE5MjRXa09DQ3J4Z2FNcmRYU1pl?=
 =?utf-8?B?K1dSYXY5N21QQkU5ZWNqUFhZbEtIZGdUK20vRGZ1V1dKc3hHRlF6alVTRjZS?=
 =?utf-8?B?QnBmYWQ4NFVuOHh3d0ZwdXRJUnBtL3F4NllwQk5GS0FMbUVmNHE5Q0YwN2lB?=
 =?utf-8?B?MG9ZSTQ1UkZVNFdyYm9hNnViWTZzU3F3TFNwSnlpZll1TlpCdUlleUxvcTVu?=
 =?utf-8?B?L2xGK2RiZTBmUDJIYkdSZlA1R2tJcDRMVVdRbWY3SnVJa09XOWNyYnlnVjZV?=
 =?utf-8?B?NGtGbDJ0NFVwZ1diRFJzU3drNzJlZjlYc05BV3p4cENSNHp6MFBQWGcyMW1r?=
 =?utf-8?B?OTFoMFhHRVBuVmFmYWkrRnV1TVl2UXFqQ1N4ZVQvYTZlbkpja016eVgreUZG?=
 =?utf-8?B?N1NCYXhZMjhscmRyNGdsNC95UWZHL3NzVFV2TDBuS3ZyS0xoMDlPNTVUeGxR?=
 =?utf-8?B?MTdXLzk3MTc3SWNWQXhKYjNodURlT2V3MHBYd1lmSFMvaTc3UDJrMHZYb0pH?=
 =?utf-8?B?TzZObDlZd0wrVHlXNk90azhweWVjNEtDaUFJcnAwbEVOcjZyWXUwY3NNbDY1?=
 =?utf-8?B?dFhkK29HUWdxb29SbnJGaXRnSWJjLzE1U3FRL3oxcVN5K2JFR21wZHJXejB0?=
 =?utf-8?B?SjZsREk1UnZKdXF1QXY4RituNmJrblhBRzVrS0ZVcGVnNzNlMkM3TS95SnlO?=
 =?utf-8?B?VDNWQnNmVnVhYjQ0akVzQ3VZYnVBaEpIYmNoV25MN3ZtazdpM3dNUXdRUDM0?=
 =?utf-8?B?UFJhVnAxbGdVZXdwSWM1Uk0vZDZVMkM3elE5TzJremV0Y254NEo1cVhVQVAx?=
 =?utf-8?B?c3Uyd2Fsa3pBQ3NSNFMyemtOc2grV0UxaHdSNkJrMGVSQlhVazlldllPL2lJ?=
 =?utf-8?B?bEhvUUxSaTNZVVpIWHY4eW1BTDlSWHhNKytMbWdGUVR6ZTY4eUR2TkZLVkxn?=
 =?utf-8?B?ejhwVElJeFQwbjhYYlFPT2JKTzVaSXd4VmtpQzU2R2E0dnYyZys4TS84MEF0?=
 =?utf-8?B?blVVL1dQdDNFWmJKTExFeUo4enM5MkMzU09TMU1EQ204TkFoeWFVdUt3TUxE?=
 =?utf-8?Q?MiG2y7GNj0wJWw8BSayoXRqYH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1RPUGtkaUtzQXhGWVFGQ0l0VWtqcitpVlBCUFVta2RsME1vN1hNLzNVUU5U?=
 =?utf-8?B?UEFFYWpuWnMwTWd2SFg3enk3U2w5ZkorQjNNSlozaDUvTFRscm0yTlovWVBn?=
 =?utf-8?B?cjFGSDlwMCtUQWsvQlZ6ZHdhdEpyVDJ3dUEwblNkdzJQbWdnUzdGell6cUxG?=
 =?utf-8?B?L0RwWWk4d3BKckZSWmQrTXNwU3pldDk1enJnSGM2Q1NkTXBzbENHMk1SQllv?=
 =?utf-8?B?NFRMWlh1N3FCUnhqVTgxOGllM2NqcnFUOUMyVlJLVytCanViR1paZUJzVDhl?=
 =?utf-8?B?U200b0dzVmlaS09FWEhITVBlYWx4MU9uazJlRysxaVNJdU51aXFQa0FzQytx?=
 =?utf-8?B?aktrcDVJejRzYTBmTWhpMEN5anN0TEc0cGhEdFJKbm04dEwyY0MwajFyM25m?=
 =?utf-8?B?TDVOSjBiRElrR2hwRmtIa0x1UVVnV1gwUkIxOGx2OUNEQnVGdmxsUlc4WlRO?=
 =?utf-8?B?LzBKeFo0enJGc2QvR2cvTzBYTmRjblpIUEVsbmZTTytIQk1sNmhYUkwzemMy?=
 =?utf-8?B?UXQ4UVAzMlBJTUlHcXB1UHA5VTdTWC94SDhuVkJnL0l0eUFLQStvaFdDWXQ1?=
 =?utf-8?B?ejkrVllCVmI4eUZobllmVXVWZ2JhS1o2Um1uTWxCM2cxV0xGV2Z0MjFSNkFH?=
 =?utf-8?B?SUMzdVpvSnN6clBEV0RrcFpJcTRQWEZGS1NXYkxFSDdLdFUxWWlEcjgxY3FG?=
 =?utf-8?B?VDk1MllnMzBndUVhdHdwdm5rSVJhd1FMb21WOU9uS0hxTmk4WEEvUXpJUG4v?=
 =?utf-8?B?WDFTTm5IUVZFUVZLeC9yb0tJRC8rTGhCVWV0Z1RISFI2bXBsRFNaZnd1VE05?=
 =?utf-8?B?TG9MOVFiYUFoZkd2bGU2ZnVZTmZCRktrU3lHWWdOL2NESm5RTlFnMUJNdndK?=
 =?utf-8?B?L1UrY0hNUE50WVBxNDlSeEwweStMWUtKQ2dFb1B5N290YVROOWlsaDBodURT?=
 =?utf-8?B?WitTOEVwUFlpaHRMeStqVHJHd2tHZ2M2OGs5QVBoQnU5UE5uKy83YktET01x?=
 =?utf-8?B?cThhek5jSWI5UFBWT3p3WExSUFd3OXArTXY2STZ4eSt0dUxTdnhyNG1oZHpT?=
 =?utf-8?B?L0xNUW0zTHM1TlA2TG5VVTM1ajllSEMzdHVUS0plcTJpMmpWc3BBL0IyNlNt?=
 =?utf-8?B?bzhHeUZjZ2NPenMzTEJJZ2NtWnRoTjZHWHFnckZjZzhsWUdyaEF1cCtEc0xw?=
 =?utf-8?B?SXpjaHp3Y3pXNUpIdzA3bDF3OVpIOVVpYU5KcCt1NG5rcllKYW1OdW5CZmY0?=
 =?utf-8?B?MXdyc0RnZU8rMUZjK1BCQTI5VzloOHdRcm8yc2JIWUE1M09kOHRzN1o2V1Z0?=
 =?utf-8?B?VGNDSEVQRzhnTzhHZVNIdVg3TGU2MWd6ZFdWSHk1MTV4aGdBOHcwYmZ2clNs?=
 =?utf-8?B?YjliQ0prMlJjSDBKbUNWVVRCOW9Sa1MxNFFYeStJbGcycXBCSjdRQ0p3ZTBH?=
 =?utf-8?B?M3ZJWkIxS2ZQcFNvd2lwaFdKR0p0MEZkd1F2RmFldEVvRTFtRlJFZXd3dE1S?=
 =?utf-8?B?VHZuWTY1bHh0VWNMSm5Ubkh6Yzh2ZkMybnVHMFR1UHdvb09SUmIrWmN3QytD?=
 =?utf-8?B?RCtIVnZDS1NQSVRpMlpYQm5uMEFYSGlnV2FuRHlLL3hBVHloR095MHVsT1Ev?=
 =?utf-8?B?K3lWSnRlTzZVNVRpUDJqUVM4ODRhcERSS0l1THRiMHpBaHlCK1VMSFV3T1Vv?=
 =?utf-8?B?THJDY0lhNG1HWmphV2ZMc0ZQanFHVlRBR2dQd2JoZ2tkY3d5OVV0QWF5d0dH?=
 =?utf-8?B?SksxK1lCNnVUcmlJVW5RazI0djZkelo1Q0YyQWNhMVNlUWtHWHBOWEkydmJ1?=
 =?utf-8?B?b3VuNFZ1aHQ3Z0U5MjdSS2tXNjdJazB6dnowaFZIaEJvZTZLRUs0b2NONkxE?=
 =?utf-8?B?MHVRa1pMalRwekFoQUJ6a01keERlSzRyQUVMZ1I1VmhhSEdYd3REVHU5MHhM?=
 =?utf-8?B?MUYrQkNOTE9OQnVrK0hTVlIxbkxSMGJYN2E2bHA3VzArN2FVNm9lQ1ZqL3Ru?=
 =?utf-8?B?S0g1dU1hNUl0YzhNU2JHaDBQREFEVUlaSlZYVVkwOTgyQmd5T0hYMkZKVmFK?=
 =?utf-8?B?ZDdrMDVJQzNCcHo1ME1sNXl2NVFoMEhLZGFUL1Bud2pvT2IrUkJPL000Z25a?=
 =?utf-8?B?Um50aS9VUExkMVNLOERmOGdoNVNnRTVsYlVNamVWZzFiNWkvSGQvek5telJL?=
 =?utf-8?B?bURCV0pxdGEvMUR3aHgwUWZucVU5TTVzdFVOZU1FR0hCTlRReDVGR0lkWGNL?=
 =?utf-8?B?Z0VxYm5Db3NkS0MyVjdud3ZuNGp1NzZsc0JHMXZ5NG9FTlFZa2YvWk9RaVhK?=
 =?utf-8?B?WWIwNytqQ0dhaWRwU1V6bElTUW02dGhIRk03Ukk3NWI2TmswT2hsSkwxdGxL?=
 =?utf-8?Q?iIS5vsG3CfpuZPwU5MstEnAiPN8X2eWlCT0uS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02B84FE496A12940AFE0FB5299F9D2C9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163f708d-3e5c-4739-b4a7-08de65b74d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 19:38:28.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQQYUzUkBV7Gz2uOQvJUwDGwRKb+z7xEPIMBq1eBBgx4tLygIl7SBiQfIlsgETdiRkwycrkRwZaFPKsmf/5Urw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6599
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MyBTYWx0ZWRfXwuHCATLVUyp0
 2L5I+MLiHhtbxN1ybC9r2mvtSx7CAMrygbVeLdGLRgyffInNFrnf7uhnJ1nknFtasLHUE09PXhD
 jKui1qpQhjkHwQ94WrSuHU6vEVwf2br57xNpazyEjK/CEvSR9KRvXep4ncEuG2nEiRIrFr9TKX+
 6Y73lJ73ET6t309HeHDfXpcicSu0Qvabebu4VSARgegxfnCY02ABW1MFMBE1OSwclJEZNlojv0A
 /fkChXUe1z9qTF605sVzKLUVF4KusF8EYEerUjeUA5YWOUcxttVsyZ/xGLkacPwW0Gur7aJ8YDb
 55QTC5Ncm8OTwfHriuGI5qpYDo1wiZwhkbSRCzN7MkZoJa32O6EJz0oEcNzKzQS5vj3B3eHThuR
 EPmGdz6Lad3gOp/G5PaF3T0qiJBzTdBY7HPlAz3mXvvJUExmC9bQIr0W12MvPxfVFB/Tiqm/PVl
 cBX/mvA2j+HAcJbyxMA==
X-Proofpoint-GUID: VyPkafEUW_wpnAWbB8v_-Qbb5wZqH7KL
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=69864337 cx=c_pps
 a=nYaA4L0hYP7ZHAKl0WLIGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8 a=vnREMb7VAAAA:8
 a=NEAV23lmAAAA:8 a=pA4VHx6yWjUMLQsOUrUA:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: VyPkafEUW_wpnAWbB8v_-Qbb5wZqH7KL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76642-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 487CD102DBA
X-Rspamd-Action: no action

SGVsbG8sDQoNCk1hY2hpbmUgTGVhcm5pbmcgKE1MKSBpcyBhcHByb2FjaC9hcmVhIG9mIGxlYXJu
aW5nIGZyb20gZGF0YSwNCmZpbmRpbmcgcGF0dGVybnMsIGFuZCBtYWtpbmcgcHJlZGljdGlvbnMg
d2l0aG91dCBpbXBsZW1lbnRpbmcgYWxnb3JpdGhtcw0KYnkgZGV2ZWxvcGVycy4gVGhlIG51bWJl
ciBvZiBhcmVhcyBvZiBNTCBhcHBsaWNhdGlvbnMgaXMgZ3Jvd2luZw0Kd2l0aCBldmVyeSBkYXku
IEdlbmVyYWxseSBzcGVha2luZywgTUwgY2FuIGludHJvZHVjZSBhIHNlbGYtZXZvbHZpbmcgYW5k
DQpzZWxmLWxlYXJuaW5nIGNhcGFiaWxpdHkgaW4gTGludXgga2VybmVsLiBUaGVyZSBhcmUgYWxy
ZWFkeSByZXNlYXJjaCB3b3Jrcw0KYW5kIGluZHVzdHJ5IGVmZm9ydHMgdG8gZW1wbG95IE1MIGFw
cHJvYWNoZXMgZm9yIGNvbmZpZ3VyYXRpb24gYW5kDQpvcHRpbWl6YXRpb24gdGhlIExpbnV4IGtl
cm5lbC4gSG93ZXZlciwgaW50cm9kdWN0aW9uIG9mIE1MIGFwcHJvYWNoZXMNCmluIExpbnV4IGtl
cm5lbCBpcyBub3Qgc28gc2ltcGxlIGFuZCBzdHJhaWdodGZvcndhcmQgd2F5LiBUaGVyZSBhcmUg
bXVsdGlwbGUNCnByb2JsZW1zIGFuZCB1bmFuc3dlcmVkIHF1ZXN0aW9ucyBvbiB0aGlzIHJvYWQu
IEZpcnN0IG9mIGFsbCwgYW55IE1MIG1vZGVsDQpyZXF1aXJlcyB0aGUgZmxvYXRpbmctcG9pbnQg
b3BlcmF0aW9ucyAoRlBVKSBmb3IgcnVubmluZy4gQnV0IHRoZXJlIGlzDQpubyBkaXJlY3QgdXNl
IG9mIEZQVXMgaW4ga2VybmVsIHNwYWNlLiBBbHNvLCBNTCBtb2RlbCByZXF1aXJlcyB0cmFpbmlu
ZyBwaGFzZQ0KdGhhdCBjYW4gYmUgYSByZWFzb24gb2Ygc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2Ug
ZGVncmFkYXRpb24gb2YgTGludXgga2VybmVsLg0KRXZlbiBpbmZlcmVuY2UgcGhhc2UgY291bGQg
YmUgcHJvYmxlbWF0aWMgZnJvbSB0aGUgcGVyZm9ybWFuY2UgcG9pbnQgb2Ygdmlldw0Kb24ga2Vy
bmVsIHNpZGUuIFRoZSB1c2luZyBvZiBNTCBhcHByb2FjaGVzIGluIExpbnV4IGtlcm5lbCBpcyBp
bmV2aXRhYmxlIHN0ZXAuDQpCdXQsIGhvdyBjYW4gd2UgdXNlIE1MIGFwcHJvYWNoZXMgaW4gTGlu
dXgga2VybmVsPyBXaGljaCBpbmZyYXN0cnVjdHVyZQ0KZG8gd2UgbmVlZCB0byBhZG9wdCBNTCBt
b2RlbHMgaW4gTGludXgga2VybmVsPw0KDQpXaGF0IGlzIHRoZSBnb2FsIG9mIHVzaW5nIE1MIG1v
ZGVscyBpbiBMaW51eCBrZXJuZWw/IFRoZSBtYWluIGdvYWwgaXMNCnRvIGVtcGxveSBNTCBtb2Rl
bHMgZm9yIGVsYWJvcmF0aW9uIG9mIGEgbG9naWMgb2YgcGFydGljdWxhciBMaW51eCBrZXJuZWwN
CnN1YnN5c3RlbSBiYXNlZCBvbiBwcm9jZXNzaW5nIGRhdGEgb3IvYW5kIGFuIGVmZmljaWVudCBz
dWJzeXN0ZW0NCmNvbmZpZ3VyYXRpb24gYmFzZWQgb24gaW50ZXJuYWwgc3RhdGUgb2Ygc3Vic3lz
dGVtLiBBcyBhIHJlc3VsdCwgaXQgbmVlZHM6DQooMSkgY29sbGVjdCBkYXRhIGZvciB0cmFpbmlu
ZywgKDIpIGV4ZWN1dGUgTUwgbW9kZWwgdHJhaW5pbmcgcGhhc2UsDQooMykgdGVzdCB0cmFpbmVk
IE1MIG1vZGVsLCAoNCkgdXNlIE1MIG1vZGVsIGZvciBleGVjdXRpbmcgdGhlIGluZmVyZW5jZSBw
aGFzZS4NClRoZSBNTCBtb2RlbCBpbmZlcmVuY2UgY2FuIGJlIHVzZWQgZm9yIHJlY29tbWVuZGF0
aW9uIG9mIExpbnV4IGtlcm5lbA0Kc3Vic3lzdGVtIGNvbmZpZ3VyYXRpb24gb3IvYW5kIGZvciBp
bmplY3RpbmcgYSBzeW50aGVzaXplZCBzdWJzeXN0ZW0gbG9naWMNCmludG8ga2VybmVsIHNwYWNl
IChmb3IgZXhhbXBsZSwgZUJQRiBsb2dpYykuDQoNCkhvdyBNTCBpbmZyYXN0cnVjdHVyZSBjYW4g
YmUgZGVzaWduZWQgaW4gTGludXgga2VybmVsPyBJdCBuZWVkcyB0byBpbnRyb2R1Y2UNCmluIExp
bnV4IGtlcm5lbCBhIHNwZWNpYWwgTUwgbGlicmFyeSB0aGF0IGNhbiBpbXBsZW1lbnQgYSBnZW5l
cmFsaXplZA0KaW50ZXJmYWNlIG9mIGludGVyYWN0aW9uIGJldHdlZW4gTUwgbW9kZWzigJlzIHRo
cmVhZCBpbiB1c2VyLXNwYWNlIGFuZCBrZXJuZWwNCnN1YnN5c3RlbS4gTGlrZXdpc2UgaW50ZXJm
YWNlIHJlcXVpcmVzIHRvIGhhdmUgdGhlIG1lYW5zOg0KKDEpIGNyZWF0ZS9pbml0aWFsaXplL2Rl
c3Ryb3kgTUwgbW9kZWwgcHJveHkgaW4ga2VybmVsIHN1YnN5c3RlbSwNCigyKSBzdGFydC9zdG9w
IE1MIG1vZGVsIHByb3h5LCAoMykgZ2V0L3ByZXByb2Nlc3MvcHVibGlzaCBkYXRhIHNldHMNCmZy
b20ga2VybmVsIHNwYWNlLCAoNCkgcmVjZWl2ZS9wcmVwcm9jZXNzL2FwcGx5IE1MIG1vZGVsIHJl
Y29tbWVuZGF0aW9uKHMpDQpmcm9tIHVzZXItc3BhY2UsICg1KSBleGVjdXRlIHN5bnRoZXNpemVk
IGxvZ2ljL3JlY29tbWVuZGF0aW9ucyBpbiBrZXJuZWwtc3BhY2UsDQooNikgZXN0aW1hdGUgZWZm
aWNpZW5jeSBvZiBzeW50aGVzaXplZCBsb2dpYy9yZWNvbW1lbmRhdGlvbnMsDQooNykgZXhlY3V0
ZSBlcnJvciBiYWNrLXByb3BhZ2F0aW9uIHdpdGggdGhlIGdvYWwgb2YgY29ycmVjdGlvbiBNTCBt
b2RlbA0Kb24gdXNlci1zcGFjZSBzaWRlLg0KDQpUaGUgY3JlYXRlIGFuZCBpbml0aWFsaXplIGxv
Z2ljIGNhbiBiZSBleGVjdXRlZCBieSBrZXJuZWwgc3Vic3lzdGVtIGR1cmluZw0KbW9kdWxlIGxv
YWQgb3IgTGludXgga2VybmVsIHN0YXJ0IChvcHBvc2l0ZWx5LCBtb2R1bGUgdW5sb2FkIG9yIGtl
cm5lbA0Kc2h1dGRvd24gd2lsbCBleGVjdXRlIGRlc3Ryb3kgb2YgTUwgbW9kZWwgcHJveHkgbG9n
aWMpLiBNTCBtb2RlbCB0aHJlYWQNCmluIHVzZXItc3BhY2Ugd2lsbCBiZSBjYXBhYmxlIHRvIHJl
LWluaXRpYWxpemUgYW5kIHRvIGV4ZWN1dGUNCnRoZSBzdGFydC9zdG9wIGxvZ2ljIG9mICBNTCBt
b2RlbCBwcm94eSBvbiBrZXJuZWwgc2lkZS4gRmlyc3Qgb2YgYWxsLA0KTUwgbW9kZWwgbmVlZHMg
dG8gYmUgdHJhaW5lZCBieSBkYXRhIGZyb20ga2VybmVsIHNwYWNlLiBUaGUgZGF0YSBjYW4gYmUN
CnJlcXVlc3RlZCBieSBNTCBtb2RlbCBmcm9tIHVzZXItc3BhY2Ugb3IgZGF0YSBjYW4gYmUgcHVi
bGlzaGVkIGJ5IE1MIG1vZGVsDQpwcm94eSBmcm9tIGtlcm5lbC1zcGFjZS4gVGhlIHN5c2ZzIGlu
dGVyZmFjZSBjYW4gYmUgdXNlZCB0byBvcmNoZXN0cmF0ZQ0KdGhpcyBpbnRlcmFjdGlvbi4gQXMg
YSByZXN1bHQsIE1MIG1vZGVsIGluIHVzZXItc3BhY2Ugc2hvdWxkIGJlIGNhcGFibGUNCnRvIGV4
dHJhY3QgZGF0YSBzZXQocykgZnJvbSBrZXJuZWwgc3BhY2UgdGhyb3VnaCBzeXNmcywgRlVTRSBv
ciBjaGFyYWN0ZXINCmRldmljZS4gRXh0cmFjdGVkIGRhdGEgY2FuIGJlIHN0b3JlZCBpbiBwZXJz
aXN0ZW50IHN0b3JhZ2UgYW5kLCBmaW5hbGx5LA0KTUwgbW9kZWwgY2FuIGJlIHRyYWluZWQgaW4g
dXNlci1zcGFjZSBieSBhY2Nlc3NpbmcgdGhlc2UgZGF0YS4NCg0KVGhlIGNvbnRpbnVvdXMgbGVh
cm5pbmcgbW9kZWwgY2FuIGJlIGFkb3B0ZWQgZHVyaW5nIHRyYWluaW5nIHBoYXNlLg0KSXQgaW1w
bGllcyB0aGF0IGtlcm5lbCBzdWJzeXN0ZW0gY2FuIHJlY2VpdmUgTUwgbW9kZWwgcmVjb21tZW5k
YXRpb25zDQpldmVuIGR1cmluZyB0cmFpbmluZyBwaGFzZS4gTUwgbW9kZWwgcHJveHkgb24ga2Vy
bmVsIHNpZGUgY2FuIGVzdGltYXRlDQp0aGUgY3VycmVudCBrZXJuZWwgc3Vic3lzdGVtIHN0YXRl
LCB0cmllcyB0byBhcHBseSB0aGUgTUwgbW9kZWwNCnJlY29tbWVuZGF0aW9ucywgYW5kIGVzdGlt
YXRlIHRoZSBlZmZpY2llbmN5IG9mIGFwcGxpZWQgcmVjb21tZW5kYXRpb25zLg0KR2VuZXJhbGx5
IHNwZWFraW5nLCBNTCBtb2RlbCBwcm94eSBvbiBrZXJuZWwgc2lkZSBjYW4gY29uc2lkZXIgc2V2
ZXJhbA0KbW9kZXMgb2YgaW50ZXJhY3Rpb24gd2l0aCBNTCBtb2RlbCByZWNvbW1lbmRhdGlvbnM6
ICgxKSBlbWVyZ2VuY3kgbW9kZSwNCigyKSBsZWFybmluZyBtb2RlLCAoMykgY29sbGFib3JhdGlv
biBtb2RlLCAoNCkgcmVjb21tZW5kYXRpb24gbW9kZS4NClRoZSBlbWVyZ2VuY3kgbW9kZSBpcyB0
aGUgbW9kZSB3aGVuIGtlcm5lbCBzdWJzeXN0ZW0gaXMgaW4gY3JpdGljYWwgc3RhdGUNCmFuZCBp
dCBpcyByZXF1aXJlZCB0byB3b3JrIGFzIGVmZmljaWVudCBhcyBwb3NzaWJsZSB3aXRob3V0IGNh
cGFiaWxpdHkgb2YNCmludm9sdmluZyB0aGUgTUwgbW9kZWwgcmVjb21tZW5kYXRpb25zIChmb3Ig
ZXhhbXBsZSwgTUwgbW9kZWwNCnJlY29tbWVuZGF0aW9ucyBhcmUgY29tcGxldGVseSBpbmFkZXF1
YXRlIG9yIGxvYWQgaXMgdmVyeSBoaWdoKS4NClRoZSBsZWFybmluZyBtb2RlIGltcGxpZXMgdGhh
dCBrZXJuZWwgc3Vic3lzdGVtIGNhbiB0cnkgdG8gYXBwbHkNCnRoZSBNTCBtb2RlbCByZWNvbW1l
bmRhdGlvbnMgZm9yIHNvbWUgb3BlcmF0aW9ucyB3aXRoIHRoZSBnb2FsIG9mDQplc3RpbWF0aW9u
IHRoZSBtYXR1cml0eSBvZiBNTCBtb2RlbC4gQWxzbywgTUwgbW9kZWwgcHJveHkgY2FuIGRlZ3Jh
ZGUNCnRoZSBtb2RlIHRvIGxlYXJuaW5nIHN0YXRlIGlmIE1MIG1vZGVsIHJlY29tbWVuZGF0aW9u
cyBiZWNvbWVzIGluZWZmaWNpZW50Lg0KVGhlIGNvbGxhYm9yYXRpb24gbW9kZSBoYXMgdGhlIGdv
YWwgb2YgdXNpbmcgTUwgcmVjb21tZW5kYXRpb25zIGluDQo1MCUgb2Ygb3BlcmF0aW9ucyB3aXRo
IHRoZSBnb2FsIG9mIGFjaGlldmluZyBtYXR1cmUgc3RhdGUgb2YgTUwgbW9kZWwuDQpBbmQsIGZp
bmFsbHksIE1MIG1vZGVsIHByb3h5IGNhbiBjb252ZXJ0IGtlcm5lbCBzdWJzeXN0ZW0gaW4gcmVj
b21tZW5kYXRpb24NCm1vZGUgaWYgTUwgbW9kZWwgaXMgbWF0dXJlIGVub3VnaCBhbmQgZWZmaWNp
ZW5jeSBvZiBhcHBseWluZw0KdGhlIE1MIHJlY29tbWVuZGF0aW9ucyBpcyBoaWdoZXIgdGhhbiB1
c2luZyBodW1hbi1tYWRlIGFsZ29yaXRobXMuDQpUaGUgYmFjay1wcm9wYWdhdGlvbiBhcHByb2Fj
aCBjYW4gYmUgdXNlZCB0byBjb3JyZWN0IHRoZSBNTCBtb2RlbA0KYnkgbWVhbnMgb2Ygc2hhcmlu
ZyBmZWVkYmFjayBvZiBlZmZpY2llbmN5IGVzdGltYXRpb24gZnJvbSBrZXJuZWwNCnRvIHVzZXIt
c3BhY2Ugc2lkZS4NCg0KSSB3b3VsZCBsaWtlIHRvIGRpc2N1c3MgdGhlIGFwcHJvYWNoIG9mIE1M
IGxpYnJhcnkgaW4gTGludXgga2VybmVsDQp0aGF0IGNhbiBwcm92aWRlIHRoZSB3YXkgdG8gcnVu
L2VtcGxveSBNTCBtb2RlbHMgaW4gTGludXgga2VybmVsLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K
W1JFRkVSRU5DRVNdDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwv
MjAyNDA2MDUxMTAyMTkuNzM1Ni0xLXNsYXZhQGR1YmV5a28uY29tLw0KWzJdIGh0dHBzOi8vd3d3
LnlvdXR1YmUuY29tL3dhdGNoP3Y9RTdxMFNLZW5pWFUNClszXSBodHRwczovL2dpdGh1Yi5jb20v
a2VybmVsLW1sLWxpYi9tbC1saWINCls0XSBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLW1sLWxp
Yi9tbC1saWItbGludXgNCls1XQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZl
bC8yMDI2MDIwNjE5MTEzNi4yNjA5NzY3LTEtc2xhdmFAZHViZXlrby5jb20vVC8jdA0K

