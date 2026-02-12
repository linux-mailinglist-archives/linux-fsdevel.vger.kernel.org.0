Return-Path: <linux-fsdevel+bounces-77022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOvKdvYjWng7wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:42:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E212DEC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48BDF309540B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6C35B642;
	Thu, 12 Feb 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J9IX65bB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HYv0Z+6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33B11CAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903761; cv=fail; b=Hc+i3q6pQU1FgibhD0mqZtfw2Sw9xLs+tSQoiiDYs8v2asXKVd3mvhLL6Q43BydwRmkvdQLPgQag7nliXE1jlrLpIwUO9+SMS2Dw7XsOHM/t9TsTu1xmmDJ/yFB9li4JkcX6VdD7sDHfx4TqqpagfSmbDBOZ+e9Z8VAk4fu/qQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903761; c=relaxed/simple;
	bh=n3IEV7k6sPQrrGBL/EZFRXcKg68xQjflwOj3xRgOc6Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UVUq9jh1l/PqmoWO/FVWFZGYEr3e5Ud4964xwvmE9tXZGkm5uB3PFYGxGDC6xHxhjcFf8xkBuyVpUS3+JFB36oGN60oJ2VzodhUNa06ZKJl0Dce6D5T/7cC0cG0zcAOFb8ERLrLwNeNizC8cwoquvbvoZonUuJ+55coNvBpeSr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J9IX65bB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HYv0Z+6z; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770903758; x=1802439758;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=n3IEV7k6sPQrrGBL/EZFRXcKg68xQjflwOj3xRgOc6Y=;
  b=J9IX65bB6oQoKadvQ+PrNbZcDblcvOB9wYrScrQfPnHqyif7UCBX/498
   q23TlF5bUn/TPaGIV64cG5PIE2Zhal+VgRD6VFPC5uOtprUDbAB/1/HrL
   /6WonZu21WAvBh8RCsAkDyicbUpQUcNwvbqUtCMNH/WPVHpXoS5tZRED6
   6Yp5w66qqY9rl21DKL2H/Ewc+zlNCfPUOArYhmUf9f3pMxMzauyHmVOvr
   VrggqV7NF9tWL0dDb0xVbJd1Fxi2yR0qCLCfFyEzFWTE9DxJl0SZdsenm
   +IlC14+qBq957IzhoMJ/ftbOJdMfxDkHfSN0k3alaQt18jDm0fydkSMNL
   A==;
X-CSE-ConnectionGUID: /FyI6v2KSpGgWIHTT2NAlw==
X-CSE-MsgGUID: mkul/7HuSgCNuT8iVhl7pg==
X-IronPort-AV: E=Sophos;i="6.21,286,1763395200"; 
   d="scan'208";a="140615302"
Received: from mail-eastusazon11012051.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.51])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 21:42:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTSpnfNE9tca2tDQcins42s8rNsssajQMr1jvv8PCE/WTbyXW2TpsFFH5pGY0ejiDhEu22Z5q3R+o6c8sFzwIScF31pNq4ySwEAQmo1tStYeDKpUI4Ln9z/kbKb/fLG4FkO8g9y169R7dwVeQOX3KGaP51iQ8fNasp7+pL++kOxwtEqQKcm6ULx/paUvSYZfHgC+LgqzOeSbnDGGf6V8eTk/s0VVj1iw1CYihs2aOFX6unwaIYBAsnrRsxCEcqTyGbgUbV6RSnYVCZYhFZdyh23Y7JFdy8dLks7L+W0qqzRyNh5fb10usF2wEnuicRXPq9b2ot/xdbAw+RLab/3ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3IEV7k6sPQrrGBL/EZFRXcKg68xQjflwOj3xRgOc6Y=;
 b=QX0I12b/Y1oFuiHFFPRyLR6xvDWpA4/AQBlM7WuxLug9gPl4OaduYA7u648BxkhpUCYT7VC0ZULcwqEpPBPmm4s6CKOSYXPu0DT03oWwys+mR4GntE339895HdvjdrWgVj4+8t5YEYHqfFoFbi+MEDDQ+nlfvkQV1w4Y4jd4FxL71AGB1jiaWPxvxIOsQQACaSoyhzeL6NrxxxvZV1EA0SkZII2847AZEu9UqHwzequMJWb/I4eR495kyQ1ZW3XsSOgpf5RdXB9mlYoiDLp9KS/0pj1uMThgCGCsWiSDs61Tk3z55yU6C5bcJZF4009CaiyVmp0TlZ3UdYK8vrdtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3IEV7k6sPQrrGBL/EZFRXcKg68xQjflwOj3xRgOc6Y=;
 b=HYv0Z+6zDlMegadrZJYT38JIHUpWAcez+Pl0W7WPNOgppsDp5+00jKUbpnQ4NwRPxh7axB5NIybeb+/J/lf9uCsQCLzApYeu0WFpjVSJoC1B2o9NwlUAmxoDWm4eKUAOb5bQnI8wOdkaJ9AYPU/adkHd3Y/pYV2McSQIuAttAUE=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by SN7PR04MB8480.namprd04.prod.outlook.com (2603:10b6:806:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 13:42:35 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 13:42:35 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "jack@suse.com"
	<jack@suse.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Topic: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Index: AQHcnCVy0zbMvpaPJEe12Y5TD3XDDw==
Date: Thu, 12 Feb 2026 13:42:35 +0000
Message-ID: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|SN7PR04MB8480:EE_
x-ms-office365-filtering-correlation-id: 26a66bc0-e6bc-49f1-965d-08de6a3c948f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWFZRFBWMCtwcGUzclFDamtGZ2pWRlhvRzVxQmhaTVRTSHRzZHkzOTdlcUlj?=
 =?utf-8?B?SzdEZWY3OG9Bbk5WSmdyMndlM0IzTC9YQ2pBakdyQ2gzcEdnSDFyYnUzdUJZ?=
 =?utf-8?B?MTh6WUNFQnFGWUs2WmZxUDdJVkozd2M5NGpPYzR4dnpBOXNpa0JsTDlmRGl2?=
 =?utf-8?B?WVc2Ujh0UjRORjZ0cTB3WE1Qbk1kTFU4UU5DZ3A1cU5ZcEoxeVN1aXVDNGZZ?=
 =?utf-8?B?VnRSTys5TkhCWVcrN1FGcHF4TUhNWFhWeWVLdVFzZVdvKzI3bXZ3aERzNW1O?=
 =?utf-8?B?YUVxcDlFdW5oSm1ReXdKV0RmRTJJakZ3ZGJEL2FMUjE1djlEMkh3aTNmaTdQ?=
 =?utf-8?B?a2xUbTVFV1dvVmU3UXplRWM3WDI0V1dPTU9JdHBVU0E1SkZObjFVc3NHNk9l?=
 =?utf-8?B?SVRUSng5QmkyQS94VTQ5STQvRmM3OXdrNTFqTlpudjZkL3QzTlVLTGMyVjhp?=
 =?utf-8?B?RS9RdEFrL0plNVlTRGYxVEtLQnNPanl6RERCSkgxODRzNHYrbjA5V2xDQUYv?=
 =?utf-8?B?UHpyODlrYW9NUkdONEM4OW8zZDQ4SVhBdGUxUk93dFFHeTdHQVBQckJxTkZR?=
 =?utf-8?B?UUJuV255TUc3Y0tvNVRLNU9PbjBkMjVIVlM0dHg3bVFNN0ZtVE5uR3pzNE10?=
 =?utf-8?B?R1pCZElXUXBhVTBuVGNNVWR6bFVLV2pGcG0xVFg2bWVWTElPWFcrdkJIdUtY?=
 =?utf-8?B?Z0NKTWZFTWJFbThxUzFOS1JDeDBkUDNERmc0L2hoWE5NejFTL1pNNUQvNWQ2?=
 =?utf-8?B?RldJdnpja3FkQndUWkhaKzg1bGZUMHBKM3dMZkR0YTRsd2NzM1ZmcEdxZ1Uw?=
 =?utf-8?B?Mzl4S2lweXhLZ3R3bXMrREJvWk5YNTdpazB1cU9PK1RyME9SUE5GV2lnWk9F?=
 =?utf-8?B?RDFnTUZRQ3ZQV2dRY2k3Rk5nblUyTXpKNzFvejdvL0ZXVmpYZWM5Q2E2SDJP?=
 =?utf-8?B?S0p1ZlE1R2ZoUE1obFNZcHljVHN3TUo4MkNubGwzYzZTTUpVSEo0RmcxZVF5?=
 =?utf-8?B?OHpLQXdUZ1c4TjRkaEs1V0NNVk9qSTN4Wkx0MjlXL3RKRnR0YXFaQ0lXQnlC?=
 =?utf-8?B?bTJNSHFpWWtJUFpPVmFGVmkvN1VBUnlzYm5xQkFSblc4UVhRMk5TNGU3eWdM?=
 =?utf-8?B?UHBlTmZJUHh2aEl0WjVSWXNJQXdUK3hCTTFlWXZzcERzNUxoQWswQjI4NzZE?=
 =?utf-8?B?SmNYZjJGTEtnRXFoUFR1TXFDeGxkbjlrYTRBTDJra2FVdlB6M3pOZ21oSzhn?=
 =?utf-8?B?NnNYa3A0UmFzcnBYU0d6MTZXRG1lbjRJY0I0TmtHVUFSVVZCdHZwSHlMcDlG?=
 =?utf-8?B?UkxuSDJ2MmtDZHFNdmI5V0ZVSWV0ZXlMYytmZVNXT0FqdUJSWkpTWmI1RVh5?=
 =?utf-8?B?c045OUZ6OW0vdmhKOU01U0hUZHZYQ2RuRTNaN2U0MjlHUzJoOUVoQ0hiZXZn?=
 =?utf-8?B?amxpMW0vekw2ajJDQWVnYzRPSXZNSDNka3NSODlKMVFJallXZXZUSUlpVVRr?=
 =?utf-8?B?UWJHdGxaNzdkblNLd2hQTEFtTzFnQUU1L1ZIRzNzM3YrVDBlVjI3YUxkRDAw?=
 =?utf-8?B?UEZNd2IrWWd4RXo0M21BMkxEcXVrODRRaG9TTzluelJqQmdlZU1rbjM1aU45?=
 =?utf-8?B?eE9GVjNoa0M0R1ZQU3VyQXJiU0JEemFNMG5EWllta0hwSk4wSE1oOTIvYWJ4?=
 =?utf-8?B?L2hKRUxiTFArK2VSbTNZQjVVaHc2bSthUVdNY2toQ0NtanV1dGZJRW5EZ3Y2?=
 =?utf-8?B?M2lLaVdKenpwK0FwemEyTkh6T2NWWXFBc0ZTOSs3THRlR0l6TFpvbERNRjV1?=
 =?utf-8?B?ck1VRy9CeTFlamlnWGw1UW52eHZRSTFZa1A0SU1ia3luWHkxOTFKNFVLQ2NS?=
 =?utf-8?B?a2tuNmE1L09yUm1FeTlKMVRIV1crd05rRXFwbWthQUk4V0tDM3V0WTNtbVRu?=
 =?utf-8?B?bWxKODJVTzNHYVBDb0pKYW5FQXpiYUt3QUlaSkY0UkJkQkl1WlFMSldpTjRz?=
 =?utf-8?B?UlNLY2JFZVRqVGpBNWxEVUE4NzFQTVlEUUdldUZzYVE1d0FRM0xGT2RVQS9q?=
 =?utf-8?B?RDF2NUMyd0JaVzZKRlA4QzVWbTlXc3hJUTdJMUZZTEZyT3ZEQUhvMWlBRXdh?=
 =?utf-8?B?MlhqaGpUTUdDUzBCVDl1SkpQNnlLWGpYTnUvcDhtVEdCUWxlbHlOSEEySlhJ?=
 =?utf-8?Q?IjISmX4GBhd+gB/icaxAl6s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UExCZkpHN0F0L3VHc3pOeEZMVy9EQm8yak9OMGFDdEYwWTQ3MzRJOHMxVEcv?=
 =?utf-8?B?V0JmcTR0cjZJT016NWFKM2ZQM0FWKzc4eS83T1lqdVZ1ZlFERC9ZUjkweXBz?=
 =?utf-8?B?bWVRQ3loQkVRb0QxemdPSklFQXdEVGZCOE9JUnBjeUdFbXFDNjBrYm9xYitz?=
 =?utf-8?B?cGUrTG1xY0hkeW4xbVNTQ0N2L2hnWnpIZGM1bUhGdHIzaHNMNkFFTFdCL1Vp?=
 =?utf-8?B?ZzBIVklXekh5bUx0cGNleHBORVBKcDY3dG5MaG94UkMyWEo1TEk1dHQvQy9v?=
 =?utf-8?B?SUEzWUlGL3JXL0cvVjBIK0QxOGkrdGJoMWhFK3hkaWF5Z0gxSkZnSU5pVHBa?=
 =?utf-8?B?QTZqKzJ4dEpwcW1MUFRsTVgwRldOVEtOSk83NzZzeWdkMm5Xemh3ME4vb1pl?=
 =?utf-8?B?SGpOVjRxSlFxNGl5R0VkeEZoTXhlbEZXMTRHRXYvUHFmTGlIRi9TY0pqMDlI?=
 =?utf-8?B?MUR1cDBudHEwM0tLT2lMV2UrRlBzUDhsUldTUThrUkxxNk5DZVlISW02cDdD?=
 =?utf-8?B?RDRML3lTcVh3eEhPKzBQZGZNY09nY0hIbkF1VkxWcXgzL0c1RWtoQlVjME9v?=
 =?utf-8?B?T1hCclVGbkJzbkZQaHJDK1lNcXFZUktCakQ2dWVOZW4rTDdhWTZqREc3Zi9G?=
 =?utf-8?B?R1RKWVhhbFpVdzVsakloK3JEUWUrMFVlTmVxVnRYOW5uVmdvQ2RrZURtT0RP?=
 =?utf-8?B?Rk9Yd2hWbWU2ZGFHeG41U05FTGFuN2VpbVdERVdRU0VmRmo1YmtSYnEzV2hT?=
 =?utf-8?B?TWYvdnRmWTcyendFS0RtRXI5SXRSL2dqQ2FGQVJ4d041blAvOHY3SUNhNENR?=
 =?utf-8?B?SUNObDJjQ1NJT1kyZUhMaDZYb2hoNVRxUUloZEVqUHc1TzZ4c3pjaVBrb0Rr?=
 =?utf-8?B?WThTTDFYYmNZWWhLWjZGd0gvbjZxMjM1Z2FmNGJVbzQ2bkVaVHBzTmNVMFAz?=
 =?utf-8?B?aFRrWVR1dU5OUzF5d2loUVBxZitBcmhIVmx5SzFsUlZBdHRVYUlXdTFHTVUr?=
 =?utf-8?B?cUxlOFltcnZ5UDlZS2k0SHQxUzBWSUJqUDg0WVI4ZnJhbUNXNVl3cldiNXZL?=
 =?utf-8?B?WTZzaHdrZ3VrdEZNSjd0ZmJsUjlJbmhRUXYvcFRvaHJhOTAxekhsaXFPelJK?=
 =?utf-8?B?d1FvUnJnR2xZa1ZqRGdWaXB2VjQzRHVHaUkyMjZWT1h3cUY4WEprbFNqY2pO?=
 =?utf-8?B?bmxoWTNkRlFtYjdPVUoydW93cDBMZ2xTN3lhVVRVM3ZjUW9OaFpFRVV3dGl4?=
 =?utf-8?B?SlRSMHhsOFo1U3k3dTNjekpFTmVucStjbVpYVVVQMGNuWE1WcDJta1o2TDhO?=
 =?utf-8?B?MStSVDNKaFdTOCtoWk9oUk5sTG1aRU1SOU1LdlFxOU0wQ3RrUkZSOVhtSnNy?=
 =?utf-8?B?S0ZyWDhEYXJFT2pBd2RxZUZKTTBmb2l0a0MreHNPenJHSHY2WEYrNkhFSUJv?=
 =?utf-8?B?b0lTU1R3Wk9kTExrTnhXZUZCM3JUMHd2aUxPcTNsZGhLS2ZLTFZnVmIrSGFs?=
 =?utf-8?B?ZDFRZWxoR3kxZzk5Q0JHRHRiUCt6bjNXVHFZQTB4VVBuMnNrdVBMejdYUjVQ?=
 =?utf-8?B?Ujc1QTZ6dXI3dU5hcHN3NXlSSVpFTHo1em8veXZwRUlqYUd4Z0M1Y0VTL1NU?=
 =?utf-8?B?eW9TR0s1SmR2czRWKzlMSmlXcUNXcEFldXVnSC9SZUFNSGRyakg1ZE84b3M3?=
 =?utf-8?B?UDRxenc2ZDhGU3owZlBNOXR1eTBIc2daS1ZyKzRpbXdpdkVqV213RkJwMlNB?=
 =?utf-8?B?bDZGMjV2Vzl0U3lXWWFsc3RUckVoQmJRRnQ4bkphWU94YmVseEVDVFczRVh1?=
 =?utf-8?B?a0l3NE9xZVYzdHJ6Yi91dTZwV3k5YmdFN2xsSmlnR1dla29rT0RFeU04L25u?=
 =?utf-8?B?UmFXSHpFb0I0MWx4Tm1pMGZpOWtYZE1ncjZObGtrM1haMWx6cmpKOTJzbUQy?=
 =?utf-8?B?OFdML0l2SWtESTVVbjMrWGxVQnFzZTF3cGtzTW5ldkw1bUZpKzg0YldpOHZM?=
 =?utf-8?B?ZTU5Z05GWlRwM0svYTl1VzNWMW5wZ1dvbmVjU1ZFalBOSnlQQnhZMmsrVy9V?=
 =?utf-8?B?cjVXeWRCMWdyUURUMEdPNGhYKzhXV3NHODJDcHNBMEk2L2hQWExRVUtPYjdZ?=
 =?utf-8?B?MEM0ZG10bTZObVVrQXlsbFdMZy93U2JBazR5czg0UGkwVGFCajQ2WDVGL05F?=
 =?utf-8?B?VEsycHhiNGxqY1ZaT0dpNndKd1Q0QVNWeUsxK0I4MzBOZkkxSWhKSkF3aGxz?=
 =?utf-8?B?ZGRKaHFUZGpOUmVBcTVtOTZSZkxHUm91UDlIS2xyVEN3QnA4ZDBOSkpRZ1J4?=
 =?utf-8?B?UzlhVU1yejZUSkQ0K1NTaU84TXE5M2FJZjg2c2JjT0pzU1VJYXpGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC020A84BDF7134DA828F2BCB4397F45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TJ+2gQ3r3o0IJ2dDk6AFjaGLl45CwF5odsbw8wrUlcuXxNeNknZOeAPlcfghAVQxqVDO8pRMldPwEYCNfDWF18G+SB8Zm3Vmi0/tN6R3kccZUDbypmasw+Hex3c+Pph57GYbJsX/LQJ6N6G1rGRqTOTPLl6jRD5SsAk6wIXt2sJ7nopwHLYkLz014PuZ8+vHcqDLC0xXe8aDjFQ4QIy5MQRtmiW0i9simd7T7p2MfVtdwFW6enDlEx6AO2ekV19J8w/AMrSOOMIWjXti37QJQbKR7YsCMtr8ZnYaptFWwQa8Zv/r0hpQgr9KTJjt1K2qFFv+iG6p0bxGpOOpyYMJsncIWSO9LyUjN3vBRWy7EJfU1Lptmdt3R0GdhliFaU3zh4PQeKi4X/duZZ5Yx8GLli9ERQ4lv14dvGcHqHmjfHbmUIxCJXrnguiX+hQCFhljh24uo6M8GCw0aAEBMsDPrUofHNIjpP1RbrQHUxQ9pjd+44YGNrs407uf7VjV/Lfj8HPVI4hjMxwwz+DEOu45+1ziTw0SX1beifYJok0X9Z1nsplm09QL58Glnp2gpW7buWVVnTTjc4kS+oYEaUW9XulpIXupHJcZXGwWxdOr6nN31ArlBAKynysxa2RT1HFU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a66bc0-e6bc-49f1-965d-08de6a3c948f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 13:42:35.6104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+jJqW0AOgpsUlKVMVCiS/pJ7drnYOdgg6af0+HExFFzKHR0bpT7kHwklCMuvM5XqweFIjI4KRnT3FQv7S6IfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77022-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Hans.Holmberg@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: D89E212DEC1
X-Rspamd-Action: no action

SGkgYWxsLA0KDQpJJ2QgbGlrZSB0byBwcm9wb3NlIGEgdG9waWMgb24gZmlsZSBzeXN0ZW0gYmVu
Y2htYXJraW5nOg0KDQpDYW4gd2UgZXN0YWJsaXNoIGEgY29tbW9uIHByb2plY3QobGlrZSB4ZnN0
ZXN0cywgYmxrdGVzdHMpIGZvcg0KbWVhc3VyaW5nIGZpbGUgc3lzdGVtIHBlcmZvcm1hbmNlPyBU
aGUgaWRlYSBpcyB0byBzaGFyZSBhIGNvbW1vbiBiYXNlDQpjb250YWluaW5nIHBlZXItcmV2aWV3
ZWQgd29ya2xvYWRzIGFuZCBzY3JpcHRzIHRvIHJ1biB0aGVzZSwgY29sbGVjdCBhbmQNCnN0b3Jl
IHJlc3VsdHMuDQoNCkJlbmNobWFya2luZyBpcyBoYXJkIGhhcmQgaGFyZCwgbGV0J3Mgc2hhcmUg
dGhlIGJ1cmRlbiENCg0KQSBzaGFyZWQgcHJvamVjdCB3b3VsZCByZW1vdmUgdGhlIG5lZWQgZm9y
IGV2ZXJ5b25lIHRvIGNvb2sgdXAgdGhlaXINCm93biBmcmFtZXdvcmtzIGFuZCBoZWxwIGRlZmlu
ZSBhIHNldCBvZiB3b3JrbG9hZHMgdGhhdCB0aGUgY29tbXVuaXR5DQpjYXJlcyBhYm91dC4NCg0K
TXlzZWxmLCBJIHdhbnQgdG8gZW5zdXJlIHRoYXQgYW55IG9wdGltaXphdGlvbnMgSSB3b3JrIG9u
Og0KDQoxKSBEbyBub3QgaW50cm9kdWNlIHJlZ3Jlc3Npb25zIGluIHBlcmZvcm1hbmNlIGVsc2V3
aGVyZSBiZWZvcmUgSQ0KICAgc3VibWl0IHBhdGNoZXMNCjIpIENhbiBiZSByZWxpYWJseSByZXBy
b2R1Y2VkLCB2ZXJpZmllZCwgYW5kIHJlZ3Jlc3Npb27igJF0ZXN0ZWQgYnkgdGhlDQogICBjb21t
dW5pdHkNCg0KVGhlIGZvY3VzLCBJIHRoaW5rLCB3b3VsZCBmaXJzdCBiZSBvbiBzeW50aGV0aWMg
d29ya2xvYWRzIChlLmcuIGZpbykNCmJ1dCBpdCBjb3VsZCBleHBhbmRlZCB0byBydW5uaW5nIGFw
cGxpY2F0aW9uIGFuZCBkYXRhYmFzZSB3b3JrbG9hZHMgDQooZS5nLiBSb2Nrc0RCKS4NCg0KVGhl
IGZzcGVyZlsxXSBwcm9qZWN0IGlzIGEgcHl0aG9uLWJhc2VkIGltcGxlbWVudGF0aW9uIGZvciBm
aWxlIHN5c3RlbQ0KYmVuY2htYXJraW5nIHRoYXQgd2UgY2FuIHVzZSBhcyBhIGJhc2UgZm9yIHRo
ZSBkaXNjdXNzaW9uLg0KVGhlcmUgYXJlIHByb2JhYmx5IG90aGVycyBvdXQgdGhlcmUgYXMgd2Vs
bC4NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9qb3NlZmJhY2lrL2ZzcGVyZg0KDQpDaGVlcnMs
DQoNCkhhbnMNCg==

