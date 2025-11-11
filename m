Return-Path: <linux-fsdevel+bounces-67788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF9C4B277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 03:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C9F4EF8DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 02:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B067342160;
	Tue, 11 Nov 2025 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bj4g4D61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF401341AC6;
	Tue, 11 Nov 2025 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826554; cv=fail; b=n5uA9rfVk+J7aYMpXzZFyn+wxClnzZuYsfS5SDcL+K9OqbohynyXbmRaliZairMAwFH7WD2rcsZ+b9MX9PE5wE90EhevYy6OpNvDoRfgXwr6cfrq0e4ffp8J094jRT4Kxi14Svp+WlJ+ntR4yLwKuaifpRkn4OpIk8TZ/8v57D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826554; c=relaxed/simple;
	bh=IZkKI+/XVIKLR8UBCyEahPOwRLn3XOpU4z2VHJ8R+mw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=psgnxL/DyPZ0it3mIDWKMCQGCZ4BGQjtVs+65+9m2vpMZZK+YsONix8o5KgGvh7eC/QYpgramijOr4FWWKRGuewFxBTfenRSSvtY9+97sPACyk6MIPdbk+yT2a2WKBBXqNCz6PxdxB0epJNxUEgh5SL7Xege0a7xyNIwWuVpeM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bj4g4D61; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD0cC6023821;
	Tue, 11 Nov 2025 02:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=IZkKI+/XVIKLR8UBCyEahPOwRLn3XOpU4z2VHJ8R+mw=; b=bj4g4D61
	oevhmIU+EHrCYS7ATjhl6JlH36tatXU9+wNVYj1vcS99fSFohBQYwpi2AUEYvTpn
	ldAdOX0Q2XrvjzK9DsEMzMyh15n6F3T3pSmaQXXYTwoPWLtkCvuEjSqu7db7p58M
	5SHgT5TZ7ZZi+efbgsKDm1k7yJue6+Kvn5WerLFnUcfoAhjW+WDJAXsAHcEvO7zK
	rRbmhQt2yHo3AbcRgDaUw+5mXx+obmzXiBV/b0P1se7khRIgPZJESCGfMUnwgaOr
	pJKmPknmMPwyi21moBOQtdml9tm8Fc2l0E1ZaScomJSWACzB3aNPiD1BAeIsut45
	KHXVueXdGOOgaw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwsuhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 02:02:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRAw7poNvlma/4zEGocllXMOD9yKAEDdITbWuxJ8wudE2xajEjrxEnZVmzLnrZtYDx8tb0JAhZgbLM2I7eypA/GgQiGyzDWYpYFhhRivBKxXnBL/a/CAS7kc4BzRiifj7Z8feFE97ShkrZpU0cJhH25WIwhDz6EnKOwl4/PqNR3nr9fIdwX1+WXMZ+ZRujfmuKt6fitoTBfPlcD3G6KwbmDWGRQvXPMYeQQNXPlE8PucMGDIC0o6l475KS+1gd1P+aD19JgMrx5STSmzVljJO7jcP1bzi+XKWPvf9W9WHGiYtVagPyfVY0ezMh/Z3FBcH/GsGRAEPIaWVyvJk48ytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZkKI+/XVIKLR8UBCyEahPOwRLn3XOpU4z2VHJ8R+mw=;
 b=lmGCVTcGgpYgnr64v2vc6C2TxogvQNycEEYwmLcmrXERSLdORt2azuYS4UC8QnBVTQ/7JbKlbkLHta6xtoQtuB3/h4iLJ5Hj8ioxagWr2rMdXKvpnl1pfTiGVAVI2b8UzYTmlSI8t7XYK/VCIpIKS+sUGfWaWyCeGW+0ReQecCfLQwa3AKN8T00jr9O+mQUh3d8in2lMr0eKVZiEfx3FSDzM1dYHW/EOWoyd8MBrBSmgdsp6KtjL5ucd9VU/zqfRdCfRsnSJpbOgVHqFfgwCqKecwAR+a3Eczq4/YUyDVD9iFM9LPd7ROAytJngvxRaPOs8tgTZjwUZ3dw2SRs4q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4685.namprd15.prod.outlook.com (2603:10b6:510:8a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:02:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:02:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Zirong Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "wqu@suse.com"
	<wqu@suse.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Thread-Topic: [EXTERNAL] Re: [RFC] Why generic/073 is generic but not btrfs
 specific?
Thread-Index:
 AQHcT12Yh6lLNevRjkO1oS1HPlyWxLTmIW2AgAADsICAAAXVgIAAEAgAgAKWlwCAA4PEgIAAZ+sAgAACcoA=
Date: Tue, 11 Nov 2025 02:02:21 +0000
Message-ID: <3bc0ab251ee04e16f12b18014c33eaf680cd5c3d.camel@ibm.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
	 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
	 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
	 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
	 <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
	 <20251108140116.GB2988753@mit.edu>
	 <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>
	 <20251111015336.dz6um6vqpp3qxn3h@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20251111015336.dz6um6vqpp3qxn3h@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4685:EE_
x-ms-office365-filtering-correlation-id: 576b5db0-9157-45de-d315-08de20c65a11
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTlBODhqdGJiSEFjeTREUWdUTGRHSWQxVXhzeXJKVzgxeVNUWWJSenNrMHF5?=
 =?utf-8?B?TjhIZTE5SmhaVkZJby9XRzhkUmgzZ3k1ZGFlOHV4bVovZ1RUcTV6SGEwcUQw?=
 =?utf-8?B?cmR4ckRjMnZXekxnME1jRXQ1emMwMkFVcDcrUHF1ZXgrY1VXajZrS2dma09F?=
 =?utf-8?B?Z1A5aFJ1SDRoc0RhZGpmMHROMkUyekFtRkFzdGNnRGpNNm42elQ1c0hDME02?=
 =?utf-8?B?NnRpbDdUVHNRSGdEQlFDTzUvTDMxd24zS2Q5NUtmck9XbVBGQ1UxYXI2VVN3?=
 =?utf-8?B?TlU1dnNJT0dscFdCY1lOUGdpVW5YNHBia2lMYWwxak1LSXZZU2VETDQ3U2ZF?=
 =?utf-8?B?TlFhQ2NRazR0L29PUVFvQnJQUGViWUp1ZTZleUpuOXAzRXA1TWFuaHRFTXpz?=
 =?utf-8?B?VkxkMHljc1hPa2ovZWpnUXl3UTdpWlRTM1ZPWk00QnZ4dG1XTjV0ZjA1YzAx?=
 =?utf-8?B?Tm8xTTZtRUUxeHNWWDhOMmg0eDVqckNHVlduanNlZzVlNE1uSVlUZlJncXdZ?=
 =?utf-8?B?WUlKQW84dm4xb2IxV2tOeVBHV2x2My9xbmoxZ2xGN0FtM0pWdnRORFE1TTZR?=
 =?utf-8?B?UDdDVzFHcXd3NjZQcnhiL25PbFdzYm5Na3pjaC9rbjVQUkJtU2h2U3E0Rm95?=
 =?utf-8?B?dHFTeXZXaXFCQWtmOHpESjM4L2lHSXFBcmdHVy80UnBGUWZxS1VQRmdpMHJS?=
 =?utf-8?B?azhJbEx3UVYxaERpM2ZMbDJYbE12UFVyako5YU9EUTNRcG0wNjNtNlEzSjI1?=
 =?utf-8?B?REN0M0tDcktRc1lzcnFNMGMxZFdMWVJTWmZnb00yQjFwc1NBeDF1bDdabFZV?=
 =?utf-8?B?azdtSGhRTDVMUmg0MWNvRUhUQ0Mrd2h1SjBmMk4waFVHRFA2cWRjVDROeUpE?=
 =?utf-8?B?UWVlcjdSUUx4N1FNR2lidXJqQjRVL0wveDhFUG5zY0R2UmhoMmJET3JEdUlC?=
 =?utf-8?B?MFpFU3B4SG12K3Q2bHkwVG9NQzdKQXFrM0ZRTndNcVZQNjdQcUs2M1JORW5u?=
 =?utf-8?B?QzlmaDJBNWIrc1hQakhxZHRMLzF5anR0SjMvV3JNLzBuNW5seTZQK0ltNnBZ?=
 =?utf-8?B?LzZ1RHY3RHdTVk1UaWpRYzBzYnVCU1FRem4zNXVkdTBWL3c4YTdTSUY1NVhU?=
 =?utf-8?B?LzVHL0dsU3hqTWtscXhVTit5MU4rRXNDMXVHSm9kTkZwMHFIN1gzY0Y1SWsr?=
 =?utf-8?B?ZkpNMHZ0akQrS1F1L2VKLzE0MENibzZveDhLeWZOYzlBandrVXZsd3FLTHhi?=
 =?utf-8?B?aitVSzUvYXZiNlloZGdUTURVN3oxMHpCS3dFY2VIY3ROVXFWcTVNbmZPUk9J?=
 =?utf-8?B?ZEpMTk40UXdNZ1Z0SU5kQy9ZdG9KRWNvQitsam9HQlRadlhKclh5Nk1CZ0p4?=
 =?utf-8?B?UGZkWDlyejNFNEt3eVRPM2ttZXhlYUd1cml0dUV5b0tiR2ZmYjdiemt1YS84?=
 =?utf-8?B?aER6SitNUnNlU1RoN3R0MndSUWsxZ2FNbXFSYW02c1RlOUcxazFxbE8xRzJU?=
 =?utf-8?B?SGdvL2lmVExPL2pScUZUWGdhMXZsRzU1aHkrL2I0OGcxcVJ2MHNLVitlbzJD?=
 =?utf-8?B?TXphQndhUjFsYlNnTTdXV204eDUrMmdGTU1tMXMwY3NVdG9MVVpyOUQ2ZDR6?=
 =?utf-8?B?YmpqTTgxVTJtOFpwcVpkV3VQekNBWXhKd3E0WVpFSCtERXZqdHdKako5RE9U?=
 =?utf-8?B?Y3BTeDcrZnVWdnpCdElVWjA3S3R5QTgyV3VIWWJXRCt2NXJRN1RqVXRqMkJW?=
 =?utf-8?B?UnhlY0VsM0crUnU1TTBOVUNmYWZIdzRhYWZ5a1JtOXR1NmE2eTRRZ290Rm55?=
 =?utf-8?B?VWtTMnFzWUx0WExvQTREa2pjZkpDUGVxbkdzRzFQaXVpTmZOUHBjQTlGVjFV?=
 =?utf-8?B?N1pUMStZa2dNN294Z0VWenVlZXBiRVdTM0NpTGFQbUNNY1R1alFkdGw1b1NO?=
 =?utf-8?B?MnJmWm41WGFoVUpJb1kyZzVSZUJtaWNYb05oZEpGQjNIMVhkVDl3V3hHcWg3?=
 =?utf-8?B?VVZqOUk3S3JBc211RGpDZGhtUG8vT3ZSNVhVMUErNy9QQ0RnVHpNcTJyU3RM?=
 =?utf-8?Q?nS7u3u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjN4TTk0ZEVTL3hVR3cwR2hvbzhnUEMyRml4bUJ6UWdDVjdJU1FRcGJySi9T?=
 =?utf-8?B?bUY1aWFGTnRjRExBVzNQcldnQVhHRFJNNTl6Ukx4TTkycXlXQ29nU3laeGJC?=
 =?utf-8?B?ZUNPMGdUaXduVVVLdHltMlduM1Y3VDg1aU5lVWlZQVVnRTgvcHB5VWxhTmZt?=
 =?utf-8?B?ZjFsSWo0ZTZlNkpOZ3hFZmhZaGRqSGJrUDloSG10YWFDNitBbkpKUnpLRlhJ?=
 =?utf-8?B?dWwwTWpKYjJCcUZoMndPakx6RTBMcGhpdE1YNC9HUWNqWjRFSnJPSm1RRVlz?=
 =?utf-8?B?K0ZYYVdoK3ZnMUpRdjl6Q2ZhZHdVV2ozMVFPa05TNzgrbjlJcFpkTHdTSEEv?=
 =?utf-8?B?VW82K3BUNElQRWFsWFkvMEVYZlV4MnQ2cEFkWEh2N0pyVXNQSUdyTWlHNlhz?=
 =?utf-8?B?d1VUemNiMnh6SE1QeVF4cTRwOTIyUHRuVWU1MmVJdzJLaVBWYkYvWFp0YytO?=
 =?utf-8?B?bU1GbFlJUHNYaXdVbnJFVTB3ajE2SDE5MlI1eGZzQUI1NG1mNWIvWDN6UGVr?=
 =?utf-8?B?ZmNma0tmR3J0YjlUOVFGeEdSOHdDREx6dUpHczU1Njg0MmoyQ1Jad2V4dzN0?=
 =?utf-8?B?aUdZS1NmMGlVZmk3RXRVczJDdm1DUC9LRURzb2E3UE0vQ2Y2ZWU0Zmo3Z2ZX?=
 =?utf-8?B?WlRXcG9yUmR2bUhLb0pSUzl5a0FFR2NmYnVuUW9jRnRDZS9paThYbjdXMDM2?=
 =?utf-8?B?ZjJGb1UrUDRTU21oYkgzUVAwQmhkeHljaDY5ck9NbUduV2pWck9vVlozUTYz?=
 =?utf-8?B?QWNvMnNONUVpQXlpQk9sWnY4VGY1UUJsYmQ2R2lrWHZQbmNrT1dBNFAyR0Jk?=
 =?utf-8?B?a0FtTnFDTzJrdlZnMFpxS3JMRU9oZ0lzZlFwcjU3bzF1dUY0d1JSSXRSazVE?=
 =?utf-8?B?alRPUFJsem9OMnllKzcrNmdKOEJBMU1CY05OSmFvR2NaR1dONlFlMkVvNEJ2?=
 =?utf-8?B?c01Dd0hiY0czQjgvVUZsYWtyVUhEeTNXMG16RzNvN01rZkpSWENNcm1lT3JL?=
 =?utf-8?B?RFpiNEV6R093T3NsZ0JvNVIzR3oycW1QMHZydjFLS2ovU2l5aWdwcWY5YWZC?=
 =?utf-8?B?NjRrZ2c5amdXUGR0VHRoWTMrQlBXdkdTZElWL1NMYXJyVVY1b2ZYdStubkh1?=
 =?utf-8?B?NkcxQWtMNTFFQmlNbVl0anNxdzRMZ1R5TWIzd3c1eVF3YTR1eUtFUVpCVHVS?=
 =?utf-8?B?YXZMTGZmTjg4dG9FNkRJUlNFU21UalpjNXM4bHI1aUltT0VPYVRaSXZ3MlhI?=
 =?utf-8?B?U3M2NGFNdWxmTCtuQnBqbWtLNFdBUFl5RkVCVGs5ZkpVL2dTS1BCOTR1aXNh?=
 =?utf-8?B?TDU5bjNlVUFLMzduQ2xUWHdsaVJ6QjBiUWNuem5WZ29SNmxtK3dxQ2svTnl5?=
 =?utf-8?B?TWd6TVNZY2RKUVZxNzc3M0JsWkdIVm5ibU4wTnFYS3d0Z0k1aXVDZUE5L0Yx?=
 =?utf-8?B?RVh5WEhCeUZjRlBMdFQwMExZSmV1Y1VWbXpmLzhSWElMcWFlVXV5cVBLMVdl?=
 =?utf-8?B?ZmxFc0tJOXo0VXhHVUlaMm82b3M1N3YremRPZVpsUllrbjFORm9qaEc3eXdh?=
 =?utf-8?B?YzBaTmdKbmtpaFN5blhBOXdjTXdtV0d0OEVUblg1RW9BakVSZGd0eFh3a1NJ?=
 =?utf-8?B?RGN2Zlp2a0Rxb3Z2aXg4UzIwWlVEdkE4ZVo1M2kxbnl6U3dLOTk3MlZLSTRl?=
 =?utf-8?B?S0poL0NZcmZCTytVTU5IVXlYb1FNOWlqUjY4b0I3WmVCS0g0M2FrR3dWQ3M2?=
 =?utf-8?B?OWExQ1k1UHZ6UEdwREpVRU9mdU1hcUtyRlZXVjV6ekg2cXVhUEV5aW5Ea3Iz?=
 =?utf-8?B?OENnV1VQRzdQbDk0TEFwRVUxNVp1bFhSellTQUJvNXdNcHc5K0c5aXRWL0ph?=
 =?utf-8?B?dG5kUXg2YlV3bUxsZElqd2xnZ05SeWhOd3Q1V2Nzb1kwQXROeU9sQW1XWEVp?=
 =?utf-8?B?QXE2eDg3TlhiaDF1QVFrOVlwOWFLNWxuY0F2bU9US3N4Vk1TaEZ5ZG5jbjNW?=
 =?utf-8?B?K0JEOForR1BsNHRBQXZmR0lYTVJPTjNwTG5CeHBzWmQ3bVN2MHUva1pYbHlP?=
 =?utf-8?B?QUViQ2ZRaW5YNW1qaURsOFl4T0F3dC9YVzFhZ1IwYnQ1U0NiVSthSmpjMGlV?=
 =?utf-8?B?MWhrUm5RdHg0T2xPYzlUZ3c1bVVPaWEyZWlZWnBSNit2YVR1eUsza0t2U2sr?=
 =?utf-8?Q?vLOv39Ss0s7KsJ4pL6xUOMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC69A802658676408350BDA9DAA9C242@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b5db0-9157-45de-d315-08de20c65a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 02:02:21.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aacczEjim8JZyBt8FV8WCEDsF7AokpDkV8Do5WunyXNcHSwp564O+5ycE+YOrCZx0YYEhzcn/Yb13BbRWQNCfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4685
X-Proofpoint-GUID: rT81hVebxIkCQrcgv5Q8fdBbhfGv3cqG
X-Proofpoint-ORIG-GUID: rT81hVebxIkCQrcgv5Q8fdBbhfGv3cqG
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69129930 cx=c_pps
 a=E0//De2tebslxPhFmdrqCw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VVDmTYZAMHM-HQEtKQYA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX9XBidW7tgz/f
 CuVxpdnmqkop5lSgG8AZ+6V6e2DofGZnUT//YW41Ao2lVztForvTCQwO8HafAx8EDviwJjTfZ5x
 iq69e3ub4auj7qe6XeC0Wb7YeZjcRMECBtD9IlDsepUqLsoVopQ3MIbJBxImmN+dZ+/9ahMxe2N
 XpLE/JcwuM9FglIn+abO8IP2X/7Uw9NjcKMm6rBmJA880IwBaXSDmoMcojLBHfD700Xr1uoHyKI
 V15lVITEGna+QRqwXrkhzbxyHBdL9qstlKe6r79NKwAUFqKaJxySe/VLjMEw0BJ4BPyr37BQonV
 dQ9CIMLsSXLzpM6d/6PluIGIpP3OoisLbxRGmlVz7glzqCFqbhSiUKGg/fJzigL4miDPCIGHU13
 jYjqv9HVz9F720vFmUx9wrnXaB72rw==
Subject: RE: [RFC] Why generic/073 is generic but not btrfs specific?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

T24gVHVlLCAyMDI1LTExLTExIGF0IDA5OjUzICswODAwLCBab3JybyBMYW5nIHdyb3RlOg0KPiBP
biBNb24sIE5vdiAxMCwgMjAyNSBhdCAwNzo0MTo0MFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gT24gU2F0LCAyMDI1LTExLTA4IGF0IDA5OjAxIC0wNTAwLCBUaGVvZG9y
ZSBUcydvIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBOb3YgMDYsIDIwMjUgYXQgMTA6Mjk6NDZQTSAr
MDAwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGVjaG5pY2FsbHkg
c3BlYWtpbmcsIEhGUysgaXMgam91cm5hbGluZyBmaWxlIHN5c3RlbSBpbiBBcHBsZSBpbXBsZW1l
bnRhdGlvbi4NCj4gPiA+ID4gPiA+IEJ1dCB3ZSBkb24ndCBoYXZlIHRoaXMgZnVuY3Rpb25hbGl0
eSBpbXBsZW1lbnRlZCBhbmQgZnVsbHkgc3VwcG9ydGVkIG9uIExpbnV4DQo+ID4gPiA+ID4gPiBr
ZXJuZWwgc2lkZS4gUG90ZW50aWFsbHksIGl0IGNhbiBiZSBkb25lIGJ1dCBjdXJyZW50bHkgd2Ug
aGF2ZW4ndCBzdWNoDQo+ID4gPiA+ID4gPiBmdW5jdGlvbmFsaXR5IHlldC4gU28sIEhGUy9IRlMr
IGRvZXNuJ3QgdXNlIGpvdXJuYWxpbmcgb24gTGludXgga2VybmVsIHNpZGUgIGFuZA0KPiA+ID4g
PiA+ID4gbm8gam91cm5hbCByZXBsYXkgY291bGQgaGFwcGVuLiA6KQ0KPiA+ID4gDQo+ID4gPiBJ
ZiB0aGUgaW1wbGVtZW50YXRpb24gb2YgSEpGSlMrIGluIExpbnV4IGRvZXNuJ3Qgc3VwcG9ydCBt
ZXRhZGF0YQ0KPiA+ID4gY29uc2lzdGVuY3kgYWZ0ZXIgYSBjcmFzaCwgSSdkIHN1Z2dlc3QgYWRk
aW5nIEhGUysgdG8NCj4gPiA+IF9oYXNfbWV0YWRhdF9qb3VybmFsbGluZygpLiAgVGhpcyB3aWxs
IHN1cHByZXNzIGEgbnVtYmVyIG9mIHRlc3QNCj4gPiA+IGZhaWx1cmVzIHNvIHlvdSBjYW4gZm9j
dXMgb24gb3RoZXIgaXNzdWVzIHdoaWNoIGFyZ3VhYmx5IGlzIHByb2JhYmx5DQo+ID4gPiBoaWdo
ZXIgcHJpb3JpdHkgZm9yIHlvdSB0byBmaXguDQo+ID4gPiANCj4gPiA+IEFmdGVyIHlvdSBnZXQg
SEZTKyB0byBydW4gY2xlYW4gd2l0aCB0aGUgam91cm5hbGxpbmcgdGVzZXRzIHNraXBwZWQsDQo+
ID4gPiB0aGVuIHlvdSBjYW4gZm9jdXMgb24gYWRkaW5nIHRoYXQgZ3VhcmFudGVlIGF0IHRoYXQg
cG9pbnQsIHBlcmhhcHM/DQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IFllcywgaXQgbWFrZXMg
c2Vuc2UuIEl0J3MgcmVhbGx5IGdvb2Qgc3RyYXRlZ3kuIEJ1dCBJJ3ZlIGRlY2lkZWQgdG8gc3Bl
bmQgY291cGxlDQo+ID4gb2YgZGF5cyBvbiB0aGUgZml4IG9mIHRoaXMgaXNzdWUuIElmIEkgYW0g
bm90IGx1Y2t5IHRvIGZpbmQgdGhlIHF1aWNrIGZpeCwgdGhlbg0KPiA+IEknbGwgZm9sbG93IHRo
aXMgc3RyYXRlZ3kuIDopDQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IGZzdGVzdHMgZG9lc24ndCBo
YXZlIGFuIG9mZmljYWwgSEZTKyBzdXBwb3J0aW5nIHJlcG9ydCAocmVmZXIgdG8gUkVBRE1FKSwg
c28gaWYgeW91DQo+IGZpbmQgc29tZSBoZWxwZXJzL2Nhc2VzIGNhbid0IHdvcmsgb24gaGZzL2hm
c3BsdXMgd2VsbCwgcGxlYXNlIGZlZWwgZnJlZSB0byBtb2RpZnkNCj4gdGhlbSB0byBzdXBwb3J0
IGhmcy9oZnNwbHVzLCB0aGVuIGFkZCBoZnMvaGZzcGx1cyB0byB0aGUgc3VwcG9ydGluZyBsaXN0
IChpbiBSRUFETUUpDQo+IGFmdGVyIHdlIG1ha2Ugc3VyZSBpdCB3b3JrcyA6KQ0KPiANCg0KSGkg
Wm9ycm8sDQoNClNvdW5kcyBnb29kISBJIGFtIHdvcmtpbmcgb24gaXQuIEN1cnJlbnRseSwgSSBh
bSB0cnlpbmcgdG8gaWRlbnRpZnkgc3VjaCB0ZXN0LQ0KY2FzZXMuIEkgaGF2ZSBzZXZlcmFsIGlu
IG1pbmQgYnV0LCBjdXJyZW50bHksIEkgYW0gZm9jdXNlZCBvbiB0ZXN0LWNhc2VzIHRoYXQNCnJl
cXVpcmUgdGhlIGZpeGVzIG9uIEhGUy9IRlMrIHNpZGUuDQoNCkknbGwgc2hhcmUgdGhlIHBhdGNo
ZXMgd2hlbiBJJ2xsIGNvbXBsZXRlbHkgc3VyZSB0aGF0IEhGUy9IRlMrIGNhbm5vdCBtYW5hZ2UN
CnNvbWUgeGZzdGVzdHMgY2FzZXMuDQoNClRoYW5rcywNClNsYXZhLg0KDQo=

