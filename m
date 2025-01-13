Return-Path: <linux-fsdevel+bounces-39009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D4A0B025
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 08:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD83C7A11E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E1A231C95;
	Mon, 13 Jan 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KGUuZe1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11D231A4D
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736753598; cv=fail; b=IKCKLzLqAYOt/iOiMWJS1Ssu5BDKb6omDFXqAXcTjA60iUwPXZ6Jg3pR3H5HT2QU+30TbSp2vOv+WbojCqdAipoRTE8TT1BkaypFwq9W15HsW/eZ0KSoIGvV9JQ9rAs0+HtGyj2zjWgoS8isRQOhqfx09MbW1CeOTpWHAggYPo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736753598; c=relaxed/simple;
	bh=V88TrhIdij4TayPSHvUO4Jz3D8oQgdR6qETMJwOPcLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmXdJE3IZFV2eS1Z2vqs1siHX7jsf2pKw6vk6R0NVHbpJGQY1bM0GwyM4gXlJ8xdnBJWueQTxoRVPXhCrdNrIRr4QiZyKF9pwEznMOQSpgheHf2pk6grskmain0x33BPR88MiUWFhztsd5EwQDPBq9QjGYjgFkyO1yawIR+63XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KGUuZe1R; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736753596; x=1768289596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V88TrhIdij4TayPSHvUO4Jz3D8oQgdR6qETMJwOPcLA=;
  b=KGUuZe1RbGr+SJxWoAUxoogQf6eLmQS19VUbqEHXxwacNbiLLGXqCFTf
   5HPC1WR/PYzvKwvF4usQniYTcUh04Z5Qx11EJyZ43A+EppHISm+erK19b
   LeqIDEKQQQLJl0xz3snQ7YvOeDzu8AxKbotRsl9Y1bJDiIhyNlisJqzFt
   Y17kZl+HrjbdBQ9uXhdFLdsDUtwtB0xZpvzsjsG18iXwGWV+hgMqxm2n4
   5VhnvvOol6WJjpX9actfmv/C7ZO/PTJ6m0KQHhb33NoVP5+SLYRISKv4q
   a9nKBGg9nRcmq1kBfxksmI4DrB/6d3qgCV9MlwVHmNYDV5MhW7J2OCYoM
   A==;
X-CSE-ConnectionGUID: 2lGcTKsRRh2LagtBo9x6ug==
X-CSE-MsgGUID: oKg1w+PPS6OaKygVRGMx+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="143513554"
X-IronPort-AV: E=Sophos;i="6.12,310,1728918000"; 
   d="scan'208";a="143513554"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 16:32:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+J4YUIEt3wvuGlYZ6ASvdJNhi7EIkecN3q1q5dtGncRxHzmijn31OmyC+P+re1e4AhsimWvymTNsx84Hi3tTQgjCNKnYDLbwREvDOX7WqElSIS+QwxmYco2CQ7iOipUO8qUmcBlfy6L0jWG2Jp6HJq+jHoPRGq3f5s+kuDoXiiJgxO/6eQFmpWSTP8TwjLKP2s9HhQ4uN7PgtB9KWhXvx5fvi2ZrvY7Wx1JM8NDSZ7VJrMi53IjYuzz7wjiYKWXBaNwqjEM65uad5iuT6AfrPVSe2gSw+RSSbvVfnQVj1tV8axTdKsrEdVHJZ+Il2tJJFEOQaYzI8wxwfDvNmEF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V88TrhIdij4TayPSHvUO4Jz3D8oQgdR6qETMJwOPcLA=;
 b=Roy5pi4BJskCXO06M7k46EdBh533diL/SBpgNi8a6Lif2YQlgJiclpEOGcPI4OZ6MypjIlawJe7Sn2hZeVKlU2wqYhA5EhXbvgdBaGI5EocWecnKGWvnbRI1ufwoeqW3XR4kYZcYNoHOkpHfUghctUhxs5PLezJQt2ge/C63Q8iSP1Y5apxBGtnwjNZU6k10owT7NYNqF2sH4UdjTUO9skVE9V1GrA0lpsZtQgo49kINlStWsvjdGsabFg25lpnNke+9wQC74xzkMzItNfyKBE3xUbrwOcrGkPM8jS+XDOeKdIJ1f/u95tqVLAZjHR+aBsRObdLD5P2va5JUj32dnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYYPR01MB12320.jpnprd01.prod.outlook.com
 (2603:1096:405:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 07:32:02 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 07:32:02 +0000
From: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>
Subject: Re: [LTP] [issue] cgroup: fail to mount, if mount immediately after
 umount
Thread-Topic: [LTP] [issue] cgroup: fail to mount, if mount immediately after
 umount
Thread-Index: AQHbWDWOqu1Ezd5yrk+sOYFO39FQ5bMUaglA
Date: Mon, 13 Jan 2025 07:32:02 +0000
Message-ID:
 <TY3PR01MB1207156033B2E75E5D290598EE81F2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20241227080121.69847-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20241227080121.69847-1-maxj.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=a6be051b-bf7e-4d5c-9121-f8009fe07d5d;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-13T07:26:43Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYYPR01MB12320:EE_
x-ms-office365-filtering-correlation-id: 216acbce-319a-4ae8-311a-08dd33a45f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?gb2312?B?SjNrUnJDRi9tQkFtZklqYnZaY2RWd2hPVHcweURIT0o5U2M2ZHJCUnRObjVI?=
 =?gb2312?B?K0lsUmozcU03TmZubm9EMFJQNC84em9RV3pOcVlSUFUrZ1Vpbm5aV3lZN3U5?=
 =?gb2312?B?cHVJRkowODh0bld1M2NRY0JDQytMS1VsakZrSk9TWTdYVjZrQUpjRmhkMHVr?=
 =?gb2312?B?NVpRams2RFVCZmV0TUxvbVNnSStZM0dqek9MbnpCMFpaVWh2T1prbHNma21k?=
 =?gb2312?B?aHZQY2pzeEJGWTFBeTgyQ3QyK1YvZTV6eXlvQ2pieWV3dHA2STVBMGhjZElr?=
 =?gb2312?B?L2lFQzd2V0ZhUE5IRDZpeGxaSWppOFpaWW1UUU9tNDZiN2NXTi9JSHZaUnpO?=
 =?gb2312?B?ZEpRMm9MVnFpaG91aDhJK0JPS1gxZ1U0UHlQWGhxR1FhSjI3SzJFRjlmUUsx?=
 =?gb2312?B?U2RoaHM5SnZNZ3pySWcxVXlUQVI0OUJIa2hjYzkxKzkwYUxtYUJvaVZtQnNs?=
 =?gb2312?B?aGpKekRDZkFzMVlDMENvYWNOMFVEcktTSDBsVnBtSUJDUGY0K0xGNDFMMWZL?=
 =?gb2312?B?cW1VR2Jidk1ob1J6QWNyY3Rrei9SWXExRDVSdWh6RmY2b2l1dUVQd1hyWDNt?=
 =?gb2312?B?MUR5ZXlsUWxqeVUyRWRjTHVmTk9mKzZYZXZXZVFvT3FaUU8yWFBHK3BveHo0?=
 =?gb2312?B?RmVncCtiZGgvWkpGaFF0NElqczJSZ1VyQ1p3QmFqbGE5VDFHb2pYa3lLbDhB?=
 =?gb2312?B?WkNJVCt0MWUyTXY1TnNwUHp0R3lFakdXT1pIK0RyNVF2bk9ZdEYrOWZRRWh2?=
 =?gb2312?B?eE85L0s0VERZVnRaZlkrd085QmozNVY1WHcwSUJrQkUrTC9EdHVNNncrOHRV?=
 =?gb2312?B?WWRWdHNWaldZcTJyTVN2Tnc1dm5TbEd6TkVzT3hsR2h4dmlKUHk4N0l2SDQ2?=
 =?gb2312?B?YTQ1YlJseVRxclN2eE9uVE5MUDQranJ3NE81MUZkdFlHMDZpeGFrQ1dkRVZu?=
 =?gb2312?B?c014MkdrMUxWd0wzbitVcXBJeDZiZTlZL2o0eVJBeWtWc2Q2Mk44YUxZZytO?=
 =?gb2312?B?aDRTWitpNVZXd2s3cmJMMEZGMlVBRzlPU3VtaTJaMWp3T1o2N2NreUw0WmMz?=
 =?gb2312?B?N24yQXFVdkFHdlVEZ0tIZjhvRjlhd1FmU1BMblVJa0tyQzFsOXRkK0lwT01H?=
 =?gb2312?B?QXdGeGcreGdhZWh6Z0lPTmV2ZnFZTDZwTzlMaDdGSWRqbEtvM1BFRnVYY2tq?=
 =?gb2312?B?a3plT1B6UnhjK09SSXQxREJJNHpGRjlXeHBlazBDODRSbDBVdU5HWUJreERz?=
 =?gb2312?B?bkdxYlJwYUl4NkNrcG5aekNxZkduY0VFVXdUeEM2KzJkSFFpMFg0b09qV2kz?=
 =?gb2312?B?UnE4NFJpOGNIVUJ2bmtwTDZqL2RiRWRFQ0tTQmxmb3B5RTF1cnpuTkU0eHdx?=
 =?gb2312?B?Y0J1dmlYQjhJY0V0UEFjbm9YcThlZ0tFbys5UXB6VE5IWlg5SHFiU0JXZzhC?=
 =?gb2312?B?d3VmMEQ1TS9LM2FWdG0vaXdLeU9sbk1Ia2tZanhZSFRXUXJXbUJySElKbUdN?=
 =?gb2312?B?NWhYNWZiNGxlYWhodG1JS05HNmxhb2grWG5IakR0Tnh4ZFRUdFUvR2VNYmRk?=
 =?gb2312?B?MlpPTG4yL3BkN0w1N1E2UG9QK0QwRDFMbWowTXNzV1dIRUQvU256S085MFdm?=
 =?gb2312?B?SWpzT0pHYnJJSGY3S1Jvak5yblJrM0VpOGZtQ1dHejVDN3pJV2xvQjBkUDRz?=
 =?gb2312?B?aVlrTXZUQVBMamJFU0tWaC9KVHdnV2NQdEd3Y0RKdmI4Q2ljTUkwVnRnM0Jv?=
 =?gb2312?B?Um9Qb1A2M2FKOHVvQjJZZy9CRjRIWkt1a0dpaDhPbVYrQWlTMDAyOWk4c1c3?=
 =?gb2312?B?SGFZSXVqcmNSeUsxazJJaEtxVGRJeWIvdkVpVDg4SS9VMjkrMEM2anQrVGw5?=
 =?gb2312?B?MVdHVkZKUzR4dU44Zll3cENwOU1BQVJrdXpOdFk4S3IwdnJHVjJtdUtrcEVH?=
 =?gb2312?Q?yHBjBpiN4yk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB12071.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Sk12b25ucExQUkNMTE9Xdys4Unk5bWFIcGxEMkxMK2UySVVmUlgzOStJa1Rm?=
 =?gb2312?B?Tzh2N1cwcHJJSGdlQmtEcXJMSmNoNk84VlM0NndyOGVGVEZja3BSalBCdWFE?=
 =?gb2312?B?UDdBWWtIVndRckR1K1Y3VUhYZTVRa09ycDd4MDQ4aFBRQjVWcDdTSVY5aWor?=
 =?gb2312?B?L1NtNnRseHpTOVpJSzNHRVpEOGRrb1hpSGFhenF4MUxqSEI3NjZZSXVMdXhS?=
 =?gb2312?B?SFFIb09ob0QxdmFJbmhYd3QrZkw0SDFLeE5pQ09vNytLS1hFWEdpQUYwVC81?=
 =?gb2312?B?NUEzU29ESXY1OWp3OStGUUE5aHBXWVprWFRZVFlpbnRKNVFpaVVXU3hjR0Fw?=
 =?gb2312?B?ZjVYWk9JUjgvR25udW1yV3kvZ1RKRzU2dDNtMUo3cFNaT3NFZmVxU3UyTVJ3?=
 =?gb2312?B?bnUwQVA0NkI0eWRJVXc2R3ppTEV5SENiTStsTXM0TFFMOENNYjl2ZHpWQkFq?=
 =?gb2312?B?VlR2WGNHeFRrSVdTdzVKSFFVOE5tZkdIQ2JuV094TjdZU2VZY0ovTlg3enNk?=
 =?gb2312?B?S1N2Q0VtOUp2dndtcTAwcThRREQ3WXN3cHBCUjdCTlZMMUYvckQ2ck1DNTI5?=
 =?gb2312?B?bkt2UWE4Vm8zVGRLQVA1bGxIUm1XYnpIaW5tTUFRcHMrakMzMlJPbjVBbWgr?=
 =?gb2312?B?NDIraVZCNmxMKzExbVl4M3d0bUlLcG5PVnl5cWYvK3NGMUgzWWtLOVV5Y3No?=
 =?gb2312?B?djg1eGsxZ3NlemlCcnZiOWJ5aUZIUER0ZjlXTi9uWGhKU0ZNRHBrTkVOdHdv?=
 =?gb2312?B?MVJFUnJ3aVhrWHRmRFBrSUtqNXVJYlQvZE1mU2QvT0RnOEQzR0lBbWYzRm9a?=
 =?gb2312?B?clFxNG5YT2QzRUNhT0dVaGg3ZG9zcnJ0U2VyWVNKWXFWYUNOR2IxU2U2RGJU?=
 =?gb2312?B?dGQ1dFBiOUZ2MUFPdjZjMHJVVXdMa2FYbmhPU1dRVzFnN1QzdEJEUHFvQWti?=
 =?gb2312?B?aEJFRGtjQ2RGeE85bDRvdzFtRnYvWk5idzhOOWp4ek4vNTMyNjdNS3F4b04v?=
 =?gb2312?B?NndjQ1g1TklPTGRES1Y2OUpXTFpMUzNQU3lVa01FZjJhdUVXZ3RqT2dXNnow?=
 =?gb2312?B?T1BTd1g1N0kzSnF1dyt0ZFBwMHdlRUtLYzhndWJHNHAyVGExRHBsSTZVUEpn?=
 =?gb2312?B?OWZXcjkxWUt4VGE2cHNtc1pKWWxNNzErVGNXZ3NjY0lhTFZHUDAxZE56NGpv?=
 =?gb2312?B?Vno3UG5BSVRHZDBhNVlTSHA3RmkxNTk2WStUNEhWaTlIcUN5WUd0TjBHQlFD?=
 =?gb2312?B?TnZKdlAvN0xUMEZGUitkZTlNVENoVWFqL0VGVWJBdlBDUTFmcHZTcEJyVEUx?=
 =?gb2312?B?QTZ5ck1yVlB4UEZjdzFucFE3aEsrTEh0ekxVOTJLaDl3ZWYvMExjVnArNEdq?=
 =?gb2312?B?MzdiYjJaakNaVytacWxaU0dDVVdrRjVrSVQ5VVVaeVZZbkRDbEhKRjkyYm5W?=
 =?gb2312?B?QjJtd2wyWEZKWDVaMTFmR05tbGlBb1dVN3MwV1NSc3owc0tOLzc4RERlNEli?=
 =?gb2312?B?RnRDYzJEcWF0aXdrWHRtQkZTZk5LaWNXb1hGT1JkcDhqY2VXOXN1azVDckQ2?=
 =?gb2312?B?V2tQakhicFhRQ3pYaWlrTW5qTzZWei9rb09EU2RLdU50L3ptcitNYXh3c3BZ?=
 =?gb2312?B?VC9BU3BEdjZHbnVqN3NESjMxVmhIVzE4YjVDVmd2R2NBZ3IzcUlZQnc1My9o?=
 =?gb2312?B?cGI2SDA4NmF0dFRST0l0aFlEMkVYVVlxa1JWb3p6Q29hSklOVlZaMFlmbmM3?=
 =?gb2312?B?MlU1YjlXUXNjYXlvc3ptcFNlN2VSdFJmdWZrVmhhcXpyYW4ybUdXbFBiejZq?=
 =?gb2312?B?b3ZsZE9oeWZlRklpbG5IU0hwVTlCSmswWmNkNVYrcXc4TzNOS1YwS2NIa1l0?=
 =?gb2312?B?VFBhVkFjaEZ1eFVDdWtpNzU5SGFoeTVKaHJITG9nSWRNUjlweXdhV1NsTGV4?=
 =?gb2312?B?OExzdFBPSWxOVVBKZm4wOFhqMGNPUUtNSFZBbXQwYTRKY3J2cUZSL0ZMd3ND?=
 =?gb2312?B?U3BBTUZzYzQ3VTYzLzJGYXdkUDN6c0tvV21uZEpwV0E5U0xPT2c1V2NlalZV?=
 =?gb2312?B?NXRjRVNzdkpNTGNld3R6VDFQYjJvTkNRbW51L05oaXVVUkdRVkRKVm0xblNp?=
 =?gb2312?Q?X8nhh8pKN5EHQ9EAnZ70u5USi?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VfoM/xBDhQDtApQ+UzGuYJ7cIBJdGX6ygukfIsjzb0pVW55zHXvfqrZNGyfkl0+N26f/+f00Yr2+QTDKjLAXfWZw3YU6e0D4IFXQLZOQsasBLNISnyGrzCxP3/RhcK5uCplZJ421e8s/yZXnkZBD33kqtaenL3/TSPL7cYRaeTasuUzdHu/ydb5psk288SANoJF1x8vIr0AFhCh65zp4R1EqujGsNChTB/BgMtStXc3tniHq2RsEkAAN2i8qNNwO7aXGURsoekwWlP/4svwFmJWDjkmXRV/ildNjTQnRYa6SWBoZtLzBTtNqGYrv8kMYdLrdb+U17YqQR6a6M+5IAIUWUjGwFUWTkqKj3yZeMF8nma6RPmfYGZyKckfM8BE0rb4WbtV0MOZ8WZma4s29XKNWL41SHx7OtlhWZmbQkUZh1P7/wiDmdPoqdePaw3a3J/nYFTuyQ0xuBGLZYuJhwE3u8YapYrx69NtDHI2iuh3//rdDLNLwCSMkTRiUP4wkbB4rbkDnn2/8gUcvvHtvqRLBdyOC0sT9SOJEeabZFsddyECE2G4Xgd45zV1liED0g72wl1fRrJ4OFCl+KcrMCNRlWznZ9+memuH5+6PQ4pImEa+QdSt8behPnE43aMWu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216acbce-319a-4ae8-311a-08dd33a45f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 07:32:02.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKVhhP8LXd1a7PiZCEqzgXS9j1LK7lbgY6f3i1pwpM74CTTS3MplyKRoQk1ISALlW0xRDnfxgz4ezjhEsRhqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12320

SGkgYWxsDQoNCkdlbnRseSBwaW5nLg0KDQpCZXN0IHJlZ2FyZHMsDQpNYQ0KDQoNCj4gSGkgZ3V5
cywNCj4gDQo+IEkgcmFuIHRoZSBMVFAgY2FzZSAiY2dyb3VwIGNncm91cF9yZWdyZXNzaW9uX3Rl
c3Quc2giIG9uIENlbnRvMTAsIGFuZCBmb3VuZA0KPiB0aGF0IGlmIG1vdW50aW5nIGNncm91cCBp
bW1lZGlhdGVseSBhZnRlciB1bW91bnQsIGl0IHdpbGwgcmVwb3J0IGVycm9yICJjZ3JvdXANCj4g
YWxyZWFkeSBtb3VudGVkIG9yIG1vdW50IHBvaW50IGJ1c3kuIg0KPiANCj4gQnV0IHRoaXMgZG9l
cyBub3Qgb2NjdXIgb24gb2xkIGtlcm5lbChzdWNoIGFzIENlbnRvczkpLg0KPiBDb3VsZCBzb21l
b25lIGhlbHAgdGFrZSBhIGxvb2s/DQo+IA0KPiBSZXByb2R1Y2UgU3RlcDoNCj4gYGBgDQo+ICMg
bWtkaXIgY2dyb3VwDQo+ICMgbW91bnQgLXQgY2dyb3VwIC1vIG5vbmUsbmFtZT1mb28gY2dyb3Vw
IGNncm91cCAjIHVtb3VudCBjZ3JvdXAgJiYNCj4gbW91bnQgLXQgY2dyb3VwIC1vIG5vbmUsbmFt
ZT1mb28gY2dyb3VwIGNncm91cA0KPiBtb3VudDogL29wdC9sdHAvdG1wZGlyL2Nncm91cDogY2dy
b3VwIGFscmVhZHkgbW91bnRlZCBvciBtb3VudCBwb2ludCBidXN5Lg0KPiAgICAgICAgZG1lc2co
MSkgbWF5IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWlsZWQgbW91bnQgc3lzdGVtIGNh
bGwuDQo+IGBgYA0KPiANCj4gTFRQIGZhaWxlZCBjYXNlOg0KPiBgYGANCj4gUnVubmluZyB0ZXN0
cy4uLi4uLi4NCj4gPDw8dGVzdF9zdGFydD4+Pg0KPiB0YWc9Y2dyb3VwIHN0aW1lPTE3MzU1ODQ2
NjYNCj4gY21kbGluZT0iY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdC5zaCINCj4gY29udGFjdHM9IiIN
Cj4gYW5hbHlzaXM9ZXhpdA0KPiA8PDx0ZXN0X291dHB1dD4+Pg0KPiBpbmNyZW1lbnRpbmcgc3Rv
cA0KPiBjZ3JvdXBfcmVncmVzc2lvbl90ZXN0IDEgVElORk86IFJ1bm5pbmc6IGNncm91cF9yZWdy
ZXNzaW9uX3Rlc3Quc2gNCj4gY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdCAxIFRJTkZPOiBUZXN0ZWQg
a2VybmVsOiBMaW51eA0KPiA2LjExLjAtMC5yYzUuMjMuZWwxMC54ODZfNjQgIzEgU01QIFBSRUVN
UFRfRFlOQU1JQyBNb24gU2VwIDIzIDA0OjE5OjEyDQo+IEVEVCAyMDI0IHg4Nl82NCBHTlUvTGlu
dXggY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdCAxIFRJTkZPOiBVc2luZw0KPiAvdG1wL2x0cC1xM1R0
VVRXVjQyL0xUUF9jZ3JvdXBfcmVncmVzc2lvbl90ZXN0LjY4THVHb3NqT1ogYXMgdG1wZGlyICh4
ZnMNCj4gZmlsZXN5c3RlbSkgY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdCAxIFRJTkZPOiB0aW1lb3V0
IHBlciBydW4gaXMgMGggNW0gMHMNCj4gY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdCAxIFRQQVNTOiBu
byBrZXJuZWwgYnVnIHdhcyBmb3VuZA0KPiBtb3VudDoNCj4gL3RtcC9sdHAtcTNUdFVUV1Y0Mi9M
VFBfY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdC42OEx1R29zak9aL2Nncm91cDoNCj4gY2dyb3VwIGFs
cmVhZHkgbW91bnRlZCBvciBtb3VudCBwb2ludCBidXN5Lg0KPiAgICAgICAgZG1lc2coMSkgbWF5
IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWlsZWQgbW91bnQgc3lzdGVtIGNhbGwuDQo+
IGNncm91cF9yZWdyZXNzaW9uX3Rlc3QgMiBURkFJTDogRmFpbGVkIHRvIG1vdW50IGNncm91cCBm
aWxlc3lzdGVtDQo+IGNncm91cF9yZWdyZXNzaW9uX3Rlc3QgMyBUQ09ORjogQ09ORklHX1NDSEVE
X0RFQlVHIGlzIG5vdCBlbmFibGVkDQo+IGNncm91cF9yZWdyZXNzaW9uX3Rlc3QgNCBUQ09ORjog
Q09ORklHX0xPQ0tERVAgaXMgbm90IGVuYWJsZWQNCj4gY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdCA1
IFRJTkZPOiBUaGUNCj4gJy90bXAvbHRwLXEzVHRVVFdWNDIvTFRQX2Nncm91cF9yZWdyZXNzaW9u
X3Rlc3QuNjhMdUdvc2pPWi9jZ3JvdXAnIGlzIG5vdA0KPiBtb3VudGVkLCBza2lwcGluZyB1bW91
bnQgY2dyb3VwX3JlZ3Jlc3Npb25fdGVzdCA1IFRQQVNTOiBubyBrZXJuZWwgYnVnIHdhcw0KPiBm
b3VuZCBjZ3JvdXBfcmVncmVzc2lvbl90ZXN0IDYgVFBBU1M6IG5vIGtlcm5lbCBidWcgd2FzIGZv
dW5kDQo+IGNncm91cF9yZWdyZXNzaW9uX3Rlc3QgNyBUUEFTUzogbm8ga2VybmVsIGJ1ZyB3YXMg
Zm91bmQgZm9yIHRlc3QgMQ0KPiBjZ3JvdXBfcmVncmVzc2lvbl90ZXN0IDcgVENPTkY6IHNraXAg
cmVzdCBvZiB0ZXN0aW5nIGR1ZSBwb3NzaWJsZSBvb3BzIHRyaWdnZXJlZA0KPiBieSByZWFkaW5n
IC9wcm9jL3NjaGVkX2RlYnVnIGNncm91cF9yZWdyZXNzaW9uX3Rlc3QgNyBUUEFTUzogbm8ga2Vy
bmVsIGJ1Zw0KPiB3YXMgZm91bmQgZm9yIHRlc3QgMiBjZ3JvdXBfcmVncmVzc2lvbl90ZXN0IDgg
VFBBU1M6IG5vIGtlcm5lbCBidWcgd2FzIGZvdW5kDQo+IA0KPiBTdW1tYXJ5Og0KPiBwYXNzZWQg
ICA2DQo+IGZhaWxlZCAgIDENCj4gYnJva2VuICAgMA0KPiBza2lwcGVkICAzDQo+IHdhcm5pbmdz
IDANCj4gPDw8ZXhlY3V0aW9uX3N0YXR1cz4+Pg0KPiBpbml0aWF0aW9uX3N0YXR1cz0ib2siDQo+
IGR1cmF0aW9uPTYyIHRlcm1pbmF0aW9uX3R5cGU9ZXhpdGVkIHRlcm1pbmF0aW9uX2lkPTEgY29y
ZWZpbGU9bm8NCj4gY3V0aW1lPTQ0MjAgY3N0aW1lPTc5MTQNCj4gPDw8dGVzdF9lbmQ+Pj4NCj4g
SU5GTzogbHRwLXBhbiByZXBvcnRlZCBzb21lIHRlc3RzIEZBSUwNCj4gTFRQIFZlcnNpb246IDIw
MjQwNTI0LTQwMC1nZWM4MWNmMjEzDQo+IGBgYA0KPiANCj4gQmVzdCByZWdhcmRzDQo+IE1hDQo+
IA0KPiAtLQ0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHANCg==

