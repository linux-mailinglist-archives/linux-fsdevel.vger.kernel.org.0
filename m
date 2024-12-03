Return-Path: <linux-fsdevel+bounces-36300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD99E1195
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05072163FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472913C918;
	Tue,  3 Dec 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="mQC3YWX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EDA59;
	Tue,  3 Dec 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195295; cv=fail; b=FB1m9guVL/KPTjVbfWgXEPhl6cs0GUylQx/cFh0H7FTjMYkfFnZ/yEqxICa0k3o1w/9luscLb/Xm3ChvE/MRa7nQqV02+06aiNT7DqGyAeR3bjFNAKdLs5uFJId7SWnWHgsDxYdQ5ypW2Y48uWcPzqdfJoMiTcS2EjB3Ja4FA6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195295; c=relaxed/simple;
	bh=rbChl1a3p5QJfogCFxaINEz1Wk2wIabTduI6/GDbImE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAcbyhqGwzA7YdrU0eFJYj5E17jiZuRieQNTss0jAwxQQHdjm5Fj2v62KJTAXtz2bzJj+VLUIFJEXjoExFdZ88xpyqsKbLY4bi0+yY0NWmwCnWhEhkW5TmWmlW0PW+gpfQeofwkvuOo3CbanspatZcvluh9qc2I0IALj1ekSC6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=mQC3YWX4; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2MihfV024924;
	Tue, 3 Dec 2024 02:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=tqUBnVxzDNH2L1FneCFq5KbfqJPiPYb
	gy9dqQ70oC+Q=; b=mQC3YWX4K5ULtSzQ6eUPKYbKPBt8az+ta2j+tZJQWvVSCuC
	0BZc3QTn4952anAq4v8j9zEbasoMUpy8svb/8jR7F6Vf6OwmvZqZCC9tm0Wy7vjP
	zB1s8tu+4FRrFTfkDy351kojKVCK/58p3kth5u74usCG/p6ljkr2AQ6phofwYhB+
	uZR8nacfKNZRFbHJEqlGRxNPU6K/XsH6La1sxfIqzj6lu7kwDVxahOF88PdR4FZN
	+tqWpdZqXq+aEWjM39/tXQz4n6tL99VvwnG6O3J8AP45+bVKhylW6G6IxyVEzNHT
	ya+72jeVQvj1JtL/pePDPNVgqnXA9fTOVFDvvNg==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazlp17013077.outbound.protection.outlook.com [40.93.138.77])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 437u3p22ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 02:22:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz1F9iJcPgRHwUKggs2eQzaJTtZ4Kn+pIwM6O0Q3ns2gCbDQmsbTLC2OcFI6sztvh3a3fo3BpKzaq/m/Q2ewXwJU+LmOyjeC0e1I18fMLF2H0jlDFgIUoXuURooIHgJAURzBK1QHa5b3/4fhz9c+Eqj4UwlheIf9Zz6B4blHp9zesZX8KFK9Gh4CLTplizK/pgW+SyY9UzUFRDtautZhHFMKHLmz0LP2IIhGqdrfVxSbWWXCOtcNt8o28PRKJMdpEPrEUMZDeTF0sgKGhR3QLAaAls1r2gpL+QlXF0as148vCH79uM+HETJsG9v3SAyh7nEcW9/FWF3Bebc6IEENfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqUBnVxzDNH2L1FneCFq5KbfqJPiPYbgy9dqQ70oC+Q=;
 b=vmfh2DEEjBty3kcp3hsL/ksbif4vE53Ued1dHWGQX7+Gse8mxWdK1ushhZ8n5/hcwGuhLTb0MX98QL4/tuRqcI0cpHivRMlKUnEMv5BV4mzFatJOMZIJO5CzhgD/MNfgZ5LtVFiim2ysqDNhiPuvLR0SBa8zEedCxlnuntu4bECR3UHMc3sdKPKI/5YRZwtlPupTAD1zQabNAqydk1bnsEy3FNUGflBcWjp6CKFuQg3o11ITk9ZGqdmZxmwB8uOJUWsH9neQjAipyCVt4aherDKc/7wJar2iFrtIKhqmLhBVDBZuZrpjVYz58PsI/hc7t4Eiqc5QUwwRFvVUVxvbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB5631.apcprd04.prod.outlook.com (2603:1096:400:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 3 Dec
 2024 02:21:57 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8207.014; Tue, 3 Dec 2024
 02:21:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [exfat?] general protection fault in
 exfat_init_ext_entry
Thread-Topic: [syzbot] [exfat?] general protection fault in
 exfat_init_ext_entry
Thread-Index: AQHbREVEo63qIhNfD0+hb+1WJPqW8LLTywgO
Date: Tue, 3 Dec 2024 02:21:57 +0000
Message-ID:
 <PUZPR04MB63168009E64846094D5BE10B81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <674ceb41.050a0220.48a03.0018.GAE@google.com>
In-Reply-To: <674ceb41.050a0220.48a03.0018.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB5631:EE_
x-ms-office365-filtering-correlation-id: ddb8502a-99dc-4cfc-3b79-08dd134142ee
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JHc5HTbY5Fuh+fo7FvPytu8bhd00TBHs9dmoRhCfTl/Y2AD0SGARjqHIw5?=
 =?iso-8859-1?Q?4GxXKxtO07Mbckdqo2fGK3DfVLvEjWOauuWqYl9txxS0Jgavpx3phC4pSS?=
 =?iso-8859-1?Q?1LkKg9EGO/ATR3XWI2PhOTW5Ed5DD5muAgOnIWQ0wMNtcKvtbp6lkvaVeb?=
 =?iso-8859-1?Q?Gl2gPA1Yg9Us+I1CtcgAO0iBvywPAnsuCdrUkqVHef2VEQPJrQjwJNnebx?=
 =?iso-8859-1?Q?PMszMKwkiLADTqPRHslpLIGZrtFkhKv06fLEK5sXTgcRvVIMaKNsalnrb/?=
 =?iso-8859-1?Q?Um9jUfjKQyH0da4VLTxy972DAHilZt0VaxKulybUQDX7724SBE/Xbpk76u?=
 =?iso-8859-1?Q?aqgsCkxdDdKIIAmPn2lGFWm1/NWWqM+0/xA0OOseg3nGF42X1Q2KdHmQnS?=
 =?iso-8859-1?Q?pUbgD1B2T1ecCXNCbbEXBS34bzRljfJcs74FyIEJoa25UOAf6rpcd6AfuI?=
 =?iso-8859-1?Q?W7SVeuhpBJWx5ooIKlaloxa8s1D1e6/GvkSre8pQ3kyeO2fCgDT8pKq+Yj?=
 =?iso-8859-1?Q?JjpsRGOvDWDte+OStPYsc0vKuarhA1JOc64zSPFT2Fa7FaqBGXR6+SM3lU?=
 =?iso-8859-1?Q?akUqHZIWlfm4V2Ri1VoVT+M0dItBSq28q5Sop7dzyxTdy3y342rEebAKg1?=
 =?iso-8859-1?Q?Zq/AFpMu138byVb5DSKVtEiviwhpB8XiXkK3Wa3W6ERnOAickCWgJz1Ybr?=
 =?iso-8859-1?Q?BrFDqahDb+07tSzB5aTA6dRITA8sM5VUjGeauOLKZqC4U4/8tTaDXPS8al?=
 =?iso-8859-1?Q?krol7FdCexaxiZq6px+ASeIl91zBYNYTTLJwZ2upsLeYjxcQFDV8FLwdIP?=
 =?iso-8859-1?Q?3Rpzs9f2642Dy3zIReDxF0yLcRwiMNQHrRuRXYsq6Bkdmqh++EmLG3if8y?=
 =?iso-8859-1?Q?SpG4X6N1mkTpYFLDANzom7FImJa/R0XB6c2WKnlhHncOpN8/dPYp1+QlbW?=
 =?iso-8859-1?Q?4MnB7tWhif82CRMyJxWkwJdU74/os5QsYsJ7YHdSmumEFr1pMuaFlJPraq?=
 =?iso-8859-1?Q?rntoxD11E2f24KU0PxETQPVs+ijIr6ejGkuMw9hytqqG3ZseLgVHT6aERJ?=
 =?iso-8859-1?Q?PWb1uT0wpnYBo/6uZ22/GrdGwoatSqUOIGICCZvxtLaUCCzXsOMy5ymN3D?=
 =?iso-8859-1?Q?IfYhVjIjIzzNnE5JoMszN4PTxPsD0zR4gjf2L8rE8V6pUeHvaTHRVecwNd?=
 =?iso-8859-1?Q?zXaIQpwX2AC+6w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x7gbBrM5qhjL4nRZ1GoqzdLLgKcAqPWBtiLIvPmbPtHmKxpM99iTVpEErM?=
 =?iso-8859-1?Q?5bSMWI2I9L9x4jO/XCVkNqJ0K8COT5slrJLCZyILOgnm5pWnXf/LgxSbHy?=
 =?iso-8859-1?Q?k3Iei6tz5xsa7sjXwHJdk6iDd5Dq6A4BCLkB/m1lw5vwPUhc5IV5OyySRK?=
 =?iso-8859-1?Q?NA6E2Vi2QPJ2IyMlkm7aEgqDtr7WjIyrrXYxUR/bssw1DkB8LqToEpQAuj?=
 =?iso-8859-1?Q?NKaC6Ip9kpITc8WK/n1zudWSE4AnfFIg4YVrUgeQIcekM+aMSUmXoui5Qr?=
 =?iso-8859-1?Q?WOtGOQ0k/mLZzAaIjVS6hUwBNNcKi7dal03zml09L09+3SO1Ajcw6fO6x/?=
 =?iso-8859-1?Q?evyVymBUml9N8Ij2QAGESkwgyzCs6DSxBR6IlGMPjYrF5bkavpQqc4uxw6?=
 =?iso-8859-1?Q?YGYzR7PPA2VL4xIaz/4QvB4M7eG5xOwT4W3EAWgS+0L76Qr3oW66ajlSiV?=
 =?iso-8859-1?Q?DTU31uDLL0URLs19rqYakhj8OR8qtFAyyt7UeM8upxuW9fD+hm6dvkcXhl?=
 =?iso-8859-1?Q?r2totpNiTQWCIqKFECNw1hASOTDdSLGdyvDW7gW0LO7ecSkgKnpEaMBr8K?=
 =?iso-8859-1?Q?MtI3kIFJSfi2MFI+l5BYmHdrfZkWwGulft2unCexIlzYNGEi/bvbKNoEiu?=
 =?iso-8859-1?Q?yEaAQzoeLuk/GPoqt5q/eMO0/k1Gj8OZ6bOC7j6/noP2bnSq4L2AGLdT/S?=
 =?iso-8859-1?Q?b6ECeijy/wmMyYzbFKfV6oA6m3zqy8U5HMM8HmwE/pljj0W6m6wp8bxYYX?=
 =?iso-8859-1?Q?BEhimgmD0eMcc+IIKMBXP84XbWxBpkyf10hKyu9Bx85mlTG9zMgyRHxpXA?=
 =?iso-8859-1?Q?wOTrB0Kv7k9dSC4YNey0Hj+s3JBZ8bV3kyKyq2Cs3sfxLXcRzzwv3ylwT7?=
 =?iso-8859-1?Q?oiC4vlUvXeeptWKHcFEh1hKf4XYiHrjmeLDvLpUGYyupg5qEsICEXP7gCH?=
 =?iso-8859-1?Q?Lz5iOvSJ0hO6l8aP9/EAs/pL5xljXLU9cCFYy9jT2IuQT1h2ULs1nTEHKg?=
 =?iso-8859-1?Q?t7BTbmQCIQ9iJl+fZpQWfy9KDqZmkI6wJ5rpkPeZZHyQhtaPhFH3zto2KU?=
 =?iso-8859-1?Q?rv9UUYnrDyDNnWoHj6OiE/oO2FCPqVntb6i3EaUpZqB69/Lix95UR4gT0R?=
 =?iso-8859-1?Q?LQ7zk2EhnLj/VQlxMwLr+YCuoriTTZA4a7NgO/jk+L6Vh33TBji/oDekg3?=
 =?iso-8859-1?Q?nsIr5TY+2ZCXsvpKsLNTAf3tVRmc7Ku05v/ymy9TzDMfSsJVvpFZrqhS1K?=
 =?iso-8859-1?Q?vEgFm1iq6+A00Ehd/hBvq2TU9bnKMm7GxGNb3MA6LXbTypiDgQfiye6bgF?=
 =?iso-8859-1?Q?WAvp01yFOq9WBTQ6sbFZKCs18IujThR/AQbNFUURPoMDgtGRrAXGWnO79p?=
 =?iso-8859-1?Q?7+14KIwW0kyid4onIPnF/ec937m4MsvkH6AIN/bKoblGVJhb6mjcuLOisb?=
 =?iso-8859-1?Q?vQ9Y5Y+sbA2y5ZxpxaBc7LCzlo77WmF8+qfq+waMxU6AVbeR4tSftbqSL1?=
 =?iso-8859-1?Q?YC+g1rWINvh9cVDvNopiKhOQcO0vvNyGrA1vnNG4EgCiUFeCcvgJWtduEO?=
 =?iso-8859-1?Q?LmDf8fTu43nAiR4xq+J8joUlaY+1i2fngnQrELWypYyrnl1YTvwnlosAdP?=
 =?iso-8859-1?Q?7yNYVfqt4SOZb9RRpPFm1cnG16T4adgMDwABAGeUu/pC3DnSw39cBn1cIB?=
 =?iso-8859-1?Q?dXmexCIqdovBZ/Ow2Xk=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB63168009E64846094D5BE10B81362PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U4GIAm1kZ/+t6ZlnQrUeKpO4Fa4knXfx55fkYkWjO5W0K9n+pvb+MZYkx12XS2HEetuPM4CxiUUilHHTG5/gOaVgbvt3QK4waJe/cqqHr7/vVUmlOPBIB5iSjrKZO/jUKYZDVcqCo5LY1TWD0ZkDxWUTawp+wNEETPcsvVIAcgAi+KrfFwJqNZcOdt50h9+Hkt1V0/lfAjMHXcyd5oxD3J/72RwCbf/eLzMFDl6XwnIoHVstSwHMJsMQJXx1q/wK7E219yAC6tqBd0zYP8D81r8WBOx6SKdcy29Za8qbC7YaNexIBgompZqbp94Uu2aywZNXSeVFNwe6CqdzdYmC2SlEyJVZ6lMS/g6gCOc8wxtnvIOeG7uAW5AbOe9+ECZYxptK4rG1dlVZZQnOc5O+gk7+GmcIGIqDQHDUnl0vazmvPcXcMBT5XUgUZfFfNStmB6OMUItkxj628da/mw0wIW1OYaupgkM61i/064ijGKlpUOapw22H/cAkxnzaLJsakdt9+x7tbWlOuZb5FXkrcm5bUdJ1rPH/4tpud56OsW71YLiObO4VD0jp5kivfJ42mCYAww/bhTZCeEhKYPNWElJFfyTz34MuP5VQJ5QbkNjAgkrPHCz4u7oD74+Y9U/9
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb8502a-99dc-4cfc-3b79-08dd134142ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 02:21:57.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCtxDwxamXeAG5nnJp4bVkXZ4iYxikvEqkKIIc/QkhIe0BSKNtruhzIg9ry8Dzh22H2E0l4yLVDBSc4JDQHOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5631
X-Proofpoint-GUID: 9syXtJPp9IqOGLBeCQUEpa_EW-n8wLt1
X-Proofpoint-ORIG-GUID: 9syXtJPp9IqOGLBeCQUEpa_EW-n8wLt1
X-Sony-Outbound-GUID: 9syXtJPp9IqOGLBeCQUEpa_EW-n8wLt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01

--_002_PUZPR04MB63168009E64846094D5BE10B81362PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB63168009E64846094D5BE10B81362PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="0001-exfat-fix-exfat_find_empty_entry-not-returning-error.patch"
Content-Description:
 0001-exfat-fix-exfat_find_empty_entry-not-returning-error.patch
Content-Disposition: attachment;
	filename="0001-exfat-fix-exfat_find_empty_entry-not-returning-error.patch";
	size=828; creation-date="Tue, 03 Dec 2024 02:21:09 GMT";
	modification-date="Tue, 03 Dec 2024 02:21:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YmVkYzRjNWExZDVkN2I2YjgxNmViNWY5NTZmNWFiMGRiNWViYTM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMiBEZWMgMjAyNCAwOTo1MzoxNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGV4ZmF0
OiBmaXggZXhmYXRfZmluZF9lbXB0eV9lbnRyeSgpIG5vdCByZXR1cm5pbmcgZXJyb3Igb24KIGZh
aWx1cmUKClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4K
LS0tCiBmcy9leGZhdC9uYW1laS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9m
cy9leGZhdC9uYW1laS5jCmluZGV4IGYyMDNjNTMyNzdlMi4uYzI0YjYyNjgxNTM1IDEwMDY0NAot
LS0gYS9mcy9leGZhdC9uYW1laS5jCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMKQEAgLTMzMCw4ICsz
MzAsOCBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoc3RydWN0IGlub2RlICpp
bm9kZSwKIAogCXdoaWxlICgoZGVudHJ5ID0gZXhmYXRfc2VhcmNoX2VtcHR5X3Nsb3Qoc2IsICZo
aW50X2ZlbXAsIHBfZGlyLAogCQkJCQludW1fZW50cmllcywgZXMpKSA8IDApIHsKLQkJaWYgKGRl
bnRyeSA9PSAtRUlPKQotCQkJYnJlYWs7CisJCWlmIChkZW50cnkgIT0gLUVOT1NQQykKKwkJCXJl
dHVybiBkZW50cnk7CiAKIAkJaWYgKGV4ZmF0X2NoZWNrX21heF9kZW50cmllcyhpbm9kZSkpCiAJ
CQlyZXR1cm4gLUVOT1NQQzsKLS0gCjIuNDMuMAoK

--_002_PUZPR04MB63168009E64846094D5BE10B81362PUZPR04MB6316apcp_--

