Return-Path: <linux-fsdevel+bounces-77634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FBr2JKw5lmmicgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:14:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BF15A94B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D773302BDED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9F630F819;
	Wed, 18 Feb 2026 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hnM1/BGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802772620E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771452838; cv=fail; b=AUUFjTc06XPr7KAfEiTXwGSY/5W1PdzIgdLjNO3NK65Xfs3sdE9PEiPcSoJUMXmkvmb3pdElGwA1I9DF/xwCkdZzRx1Iw8cN4kieQrqdZbw79JSbEWtTVv4ml7oprYP6+koPYZfn1Gho/c3Vk7cB4JUxQZ6SgdLCLREALDwr/Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771452838; c=relaxed/simple;
	bh=eaO5xPDSkVM15Sqz2MddyF6fT3RTFO/Ka3crfIb3vgQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nnDL0+V3ZapdIPZh5EI1DRxS4jsJhCzMBI1hV18BhX21T/MO5vaR3LScPX+JGDROkS+81tyf3+4xw1/6Ebf000oue7FDoRQTHqbPH6w66eq+5vLD/MBxkqo9y+fuxvM22V4Hvm8wbxt7a1Vnq3bEQ3Qc8uDirojvy/hwSyiDOvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hnM1/BGY; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IH9dZh1695691;
	Wed, 18 Feb 2026 22:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=eaO5xPDSkVM15Sqz2MddyF6fT3RTFO/Ka3crfIb3vgQ=; b=hnM1/BGY
	0jb8SZEdl+GcQ5YqVO5Twob4y+EscB8gCRn34bbd0ryHA5LrDDWzh1dOmwBHKUpl
	0uSy3vHhLpXqQ+0cKbpCZZlt78DWxnA5Z7s2bHWsn7uOn0sVV0NRaWQN/IMxJdcA
	MkejP6mEhQmIomJ07kWgVENOD05kujm4YL/qlGwl9pl7O7sC2DQJ407GsASEwS0I
	Nt4H2QcjPBL2sE49xwpH5sG+g3c3Z2bQSocsAF5vaj+o7U6t4y4Xt2tQP1dAREkI
	WdpQv62o6cxm+kqUEpP89n/edoY7zVJPBjMOBPdpw057p3CBB3ZLzB6Fl9Ed2+yi
	hktui0Ms1eA5BA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s3d4r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 22:13:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COlgJ+p8gPZPHfedJQSpAqkrEvkEuXL8tb9MiteQPAa09q7wVMjKxLI62eGvWLGZfniEyXWM5/VnR6i4E9NoNkZXEgrU1gshRHyI6DVNXoO3L7wjvq+N8b2d6HbV0YDI2E0trGHaIdV8+ZQyjgnm89U09wqNT6/lfoOJ35pmD9svWiD5wfj8Qrf6Mi8EBki0DaFqMIhC7BVaONh9Ia5TJKNQ44l1vw+a/ohj8uR+lMGuDis6HwKPdnQJnMTKwfovjnc+5iy2gm/Swp6On0mQopJwMLVp9eUnKAcH6o+x+/JoTUN5IL56g+RwEWALrIAqznjd+MBDjAh3186E30CY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaO5xPDSkVM15Sqz2MddyF6fT3RTFO/Ka3crfIb3vgQ=;
 b=Pm3g7re/ccdksYrCjyODYHxiU+wiIz6l4aFdv6fTCT/wW0J+ssmWBTFTacbUFQq4C20UGErORNpIg0cgSF5pULu2k3MMspV1XVbDxUSy3EXO+naLVjNNML87iKI/WG5wEtLbpyYzXS/woEtBtMShMv9EzN0SOt3Qj7QDJfZdGRUgHsTXPDW+LZTtwgOean+6PSFD/tXFGEIZPn58PqA1EEVx9czdN2gEbuzTd+wZkOxR9nWcTjcf0POSdCa2kxfqUV6GxzqvSuQtxbJhCFU8GieW4o42uLWuvABjsm+5Iltt8Yv02uC8znD58PopNh/u5gPh+1Yt0k86FbONERUbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6096.namprd15.prod.outlook.com (2603:10b6:8:12f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 22:13:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 22:13:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v6] hfs: update sanity check of the root
 record
Thread-Index: AQHcoNqUGUxPEOL0eUiJ92/9YIW5hLWJBfOA
Date: Wed, 18 Feb 2026 22:13:38 +0000
Message-ID: <9d32b07f725600d01bdb301ec0311330a6891ad5.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-3-contact@gvernon.com>
	 <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
	 <a31336352b94595c3b927d7d0ba40e4273052918.camel@ibm.com>
	 <aSTuaUFnXzoQeIpv@Bertha>
	 <43eb85b9-4112-488b-8ea0-084a5592d03c@I-love.SAKURA.ne.jp>
	 <75fd5e4a-65af-48b1-a739-c9eb04bc72c5@I-love.SAKURA.ne.jp>
	 <d1e3e3f6-e0c4-4e70-8759-c8aa273cbe37@I-love.SAKURA.ne.jp>
	 <ade617e7-553d-477a-95e7-aa1598b6a8c9@I-love.SAKURA.ne.jp>
In-Reply-To: <ade617e7-553d-477a-95e7-aa1598b6a8c9@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6096:EE_
x-ms-office365-filtering-correlation-id: 0e4f5964-504b-4407-b25b-08de6f3af765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEdsalhET2Q1Zk5vdkl2ZzRsMmZOVlQyV2hKZ3JaUEMvbXQxUlpudGV5MXNP?=
 =?utf-8?B?UXZoejIwdjEwdnBlbytqMEVrZGR2anJ3UDFkZGdZalFteVRmdGJvQWYzWGRH?=
 =?utf-8?B?TGQwY0Q2RGZ6WmN1V1BkUmVCd2xheWtoWFNKOUJ6NTdaeE1VN1ArWnZIbnll?=
 =?utf-8?B?S1RLS3VuRmk0REF1M2pFR0xkOGZEdWhPcmVUSEJOcDZOVXV6ZUlNbnNEWGly?=
 =?utf-8?B?cGt0YVdzQkRTb3Fhb3lpTkVtSmRkVU1qWWpjQlo0ZjBaWmRkMFkwVU9zNUZy?=
 =?utf-8?B?R1Axbm14VVJQcFRpbFE0ZndiZkJBb1J5ekpUWGhoWGtGdmtxODN2ckViVmdz?=
 =?utf-8?B?ckJXekJURWliVFV4UW1SMGtPeU1yOVM5bDlVcXcwbFJzUXlzNVhvbWNKSzRL?=
 =?utf-8?B?WC9ZYmxETnZrM2dMRGJDUHUyS2V6R2tRbDVLWFl5SGpNME5CZWxDYkx3VWx6?=
 =?utf-8?B?SWFMSUd1cmNqRXV6dnkzQzU2SnRGQyt1NXp6QVA4aSt2UDdWbHRTZFgrN1hk?=
 =?utf-8?B?Q1N2RHE2a1hVc3JIdVdXci9rK3UrbkV1OEFwV0gxSlZFUEsxb1d5cFlYM1Zo?=
 =?utf-8?B?NnVOL21VVjlibTQ0Wm03L2YwSFdueFVzR3RiMUVSUnJoWkVmV2M5aTJqT0lD?=
 =?utf-8?B?Y2ZCcW54SGVZOE1oRjFORWhYWi9yK3JJaG51ZW9zSFNYNW9vcC9PTllyRCtu?=
 =?utf-8?B?ZXpMSkZ5TFpBV1o5L2cyMGlRYnJBRjVIM1NwcVVlV3IxejJFbWFjM2hyQUNF?=
 =?utf-8?B?MEV5VVVhczR0Y1FZaFAzdVNkRTZCbUxIWUM2Q2g0M0w2Q050OGZxemw4QWRP?=
 =?utf-8?B?cWUwWkxjOEpzTGtOa3pKeGp1Zm13bDQ2VGcyZlFRNkRrcnd1ODN2TVA5Q0Fi?=
 =?utf-8?B?cnVaY01CMmpFMlNUUThSNUZOWW5yWFUvbUttbVkrdU5EdmdaQXc0bkxWaURs?=
 =?utf-8?B?eThuSm8vQ0thVFNOWDFzSnYvZ0I0bEhwUkNOYkpOOFN4dHVlY3FkWUtSNnNB?=
 =?utf-8?B?dTlPdzRKbDM3UnBLT0RVbXV1ZkxJS3VDQjJ2T2hySmVuWkJ3K2ZwT09INzk1?=
 =?utf-8?B?enU0MnhaWHZuUjVsK0JMOHJ0YkNUeEFDdUxrNHVGQnhmdGFWMGJXaG5CcGlX?=
 =?utf-8?B?a05NaTIxdUlHbFFzOXRpUzJKeTgveXduOUlIUTVqL25Ldkd6am1MSlRNYW8y?=
 =?utf-8?B?cjVjVkxuWXB4a3BXMDBxcjhsUjJpZzBwMWpXbGJ3QUY0bTVHN0t6STlNZnVL?=
 =?utf-8?B?anBkVVYxWjdCTnVZTlFIQklxYzlSenUzakw3bm9BQnB6UXFqbWorTUdpdGxp?=
 =?utf-8?B?TEFPZmxJcGxXSVNLc0lIcm1SKzdkUUFudGlGMzF5M2loUzlUSEw4aDJyN2JZ?=
 =?utf-8?B?aEhDaExHM2x3dHdjU21hK0p5TkxoNHRnVHhDVHh2eUlGZmk5NGR0WUpYNGlj?=
 =?utf-8?B?YkRNVEQ0RUVnb25EOS9LaFE3Y3pxRlExQU0yQUsyVG5sNDFNU05SaS9qL1Mw?=
 =?utf-8?B?UlBQcG9rUDl5UjZ5Y3RMcVNRY0c3MElwUHNPczFIT2MxZkFnaDhlR3NkNzNC?=
 =?utf-8?B?Y21VSVpxa0ZoSDM0NWhRNVRXTCs3UWRPZHVwT05lUlF2alpaV0xGOTZabVdk?=
 =?utf-8?B?aXdtU3ZlS1oweXEwNWtmWlk1Q2x5MTBXQ0NHZVJmSENaa1k3UnB2dWVBbjU1?=
 =?utf-8?B?NnhORDFrRkREZGxoZ1BraFZmSWdQd3RwcjVzZ0tuNnVQa1hFZzFRcmUyYnRK?=
 =?utf-8?B?TnoyeVFRb1ZJR3dVVE9CcUhwZkJuTmN6czAvTGo2QkU3SjcyQnJ2UEk1VWVU?=
 =?utf-8?B?TkFYWGRnMVU4UlVuOC9Falk2QzFEUzdTZ0gxdGN1emRyOHhPUW1uQk10WjZv?=
 =?utf-8?B?UWg4M1piUk50T2R2ZWdMOHVUMVVQbEdGNGVPNkRaYW4ySUwrQys4MjFQUlpF?=
 =?utf-8?B?a0xYVEhjdFdJQWpGT1oyUnJpMGZwb2ZTTVh1NzY0YzBZdExFRTdUWm5STmJo?=
 =?utf-8?B?VVpkQ2FCODhGTFc4QXNwVUtiRE11c096UW85K2NjZEZwTVBXRmc1WjF4Ymkv?=
 =?utf-8?B?UGw3LzAyckFLUG1xUzI2NU1sUHdBL05QdmJxdGFwZG9wZVoxdHFaT1A5T3Vm?=
 =?utf-8?Q?vBRBuP6KPF2+mn0Iwcr6Ejl6h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmZTZU54ajZCMTc4ODNSeWhya2sxZWdEME5laU9Fb2FISmdkQW5DTS8wN1pX?=
 =?utf-8?B?U1hMREd2eWNUc01HWmdMMlFkcStLYUY4Y3gvOFY4L0RPZ1M0R3dKWE93YlJF?=
 =?utf-8?B?T21iS3dLK1lWY2ZYSk5FNXdNajNmWXBkN1hIbTlXQnRxRzNWTW5sRWE2djF1?=
 =?utf-8?B?OHg0dWhQVnk0Z0R0clErRlQ2d2pIdUdTcWpDaXE4NFgzYmZ2blBFSFNwU0RR?=
 =?utf-8?B?UXRGc3IvQnZSWE5nWUgyZDRydkNmaThzK01qNG42cmcvd25Hd3NXQXpWOGJz?=
 =?utf-8?B?ZjhJTXNLTmFwMGdmQlRoOGZEeFFOYU9zajk2SlNCbnBVYk4yUnZYVnB6eDVv?=
 =?utf-8?B?WktEeGo1RFBTa3V2aGpqeW16dW1FT1ZSRkJ5b2hJQ3N1Nm12QkJnWkc4SWYw?=
 =?utf-8?B?YTBxYVp1c3lvWnl5VDhnRnFCSWt1TVM5aHl1bFlYUForN3M0QVZhRkNjNHpX?=
 =?utf-8?B?SDBwQXVSMkViYW9xMWZhN2RWQ3VqbzR5SVFpcG1LMWF1ZHhUb0xJcHZMcUJs?=
 =?utf-8?B?ZUVTZDk3V0VqdGZyWFd1bjZOeTMweXZDdnFBS2g5VFJOMVVqeXU2ZTVMaktr?=
 =?utf-8?B?OHo3YWtFOU1ZZ0NmMHkvbmZ4Ukw4UHNiYk9nVG9DSStVdVZwenc3Wm4wKzgz?=
 =?utf-8?B?VzUvMGFWWGpES1FheWZoZSszcW9tbG5veXgrSTR3ZUhiMGV3K1B1ZUtSWG9N?=
 =?utf-8?B?N1RKM3RIYXdsMHBsZlhJYXpHVWk4ajZTV0wrOE5OalIvSEVYS0Q0SkNTZ091?=
 =?utf-8?B?dDZESGlmd3FURjFjUzA5VnVkTFVkTkFLYWdFS3pGdFh2MlFWNXZza0dsdFQ5?=
 =?utf-8?B?TE5LZzM2SmRPQTJMWHFvalFjMnRmOGEyMnI3eTY2bG1MTGRjZS9rbmdrOS8r?=
 =?utf-8?B?L3hiKzA3WittMEk1QTFEQjdsa0U1Tk5veEZqY0RRUkFoc1F2L21tUElxUjJI?=
 =?utf-8?B?MlZub0FzN1BJVEJqWkpZR3JwclhBSTIrTk9rYmc1ZzBsNDBoZDZXZEpIRmJu?=
 =?utf-8?B?TGpQaUhWOUdOKy9aK1pVSUJ3UEM1Snp6UUNWdUNremV0SlRiVkRuRHZCUXZo?=
 =?utf-8?B?ZmV3RldDVk1BYm1ndmR2K01Fek4zc29Ram92Kytic0lORk1MZllNUk81dmZi?=
 =?utf-8?B?QTRVRnpBdVc1VWJWZThvQldUTDE5dEtYUjN3bmpHWHBudUhSVWEvZTVKb1la?=
 =?utf-8?B?VnM2dkFRNXBTK0hYRDl5VWlVTzZZQTRpZXgxZ2lUYzNCNC8xRStkWnFNMmxK?=
 =?utf-8?B?Y1JGemZLTDVSaFJ6c3JDc0hsM0ttNXluZDRKbWsxWC9UVDJnbnpYb0ZNS0pD?=
 =?utf-8?B?UUlLREszV05UMHZFakZsTmpJVzl6U1BTRFBkMks1ekVEbmRIUXUrUC94Wm94?=
 =?utf-8?B?MEFueERYZkEvRXBBV3U0SWNEelZzVXVkR3RyM1lwbDVRRGU0eUI1eVFLbjYv?=
 =?utf-8?B?QlFUZkh2cHV2SXRTdWdITXQwVW40d3F3RC9VczRITzhUU2NDUXVXb29BQVhO?=
 =?utf-8?B?VjdEVUJjWFJ2dzVkbzFDMS8vT2hEbWdvQmRYcUdKZ3lJUWJwY1YrNWliek5T?=
 =?utf-8?B?ME16RzJvd1hJaGNJdlRwTlpFMDRRUXVLK1BqVFRlaW1nVC9BWSszUGlTQjZ4?=
 =?utf-8?B?a0pBcHNDSjJsOWZBWmd5dWVieWIvOE8zMTJnYjdGSXJHb2tUYS9YK3c2d1dU?=
 =?utf-8?B?cGt3UXFsTGpaTnQ0RWpLbUUza3lyeXgzRlJqN3ZVLzA1SnRPSlh2Q29rYnlq?=
 =?utf-8?B?TWtOKzlyRWl4ZWdRMHRJNG1oYytRMkljcEh1TzJRZnRRcUZ4VGlaRms0TUNi?=
 =?utf-8?B?b3JpT1hSeTlTclNiVktlQ2xyb2JXMCtMeENqNVI0MU11VnpqUzR5dTJ1NXJG?=
 =?utf-8?B?VGg0SFg0Y1R0cWtnWjFhZjA0aVhJT1VUbEE5dmJndkk0RDZJRHJwVk05clRP?=
 =?utf-8?B?NU9sN28zTnBuVFU1MlMzWGFkNWVqVExER0ljQXNEcnNYTmZGMk1lMWpUYnUz?=
 =?utf-8?B?TnlkTTBNWmIwMGk1aEdFUkJjdmdQc2JJWGQ2a0prUEpYbXhYUmZkQmo4M2Z6?=
 =?utf-8?B?bjNIelk4S1R0UFhSWHhLUjEreHNYSmlTNWVzNC9PSEJ6M3lUSmUvNDh6NGNv?=
 =?utf-8?B?V1VZUytlZFpjcTdTQWtjc3dIUEdvRy83L2MvN1AzVUEvc2J2YjFEcFArSzRx?=
 =?utf-8?B?cnQ4U2RCQUViMk5adERvaFd1Unk4SUdvZ00vQkQySm1DOHYxcExTSUdiSkZO?=
 =?utf-8?B?VzdvSlAzY294UjZBeUNuT1I0MUtiRDJaMmVYaVBVbjZvZHpxV3AvUVhWT3Vz?=
 =?utf-8?B?SHpRS1dEYUJnOTZrWjJiSlNQaDJMcHUwMm9xQmxRMUpLOVlSQXpva0dzWUp3?=
 =?utf-8?Q?hEPzMSYLxnWzcjeyt9pbaoI7TiijeGO/N9hgI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <238DEE0D1958334AA7948FDE70263DB0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4f5964-504b-4407-b25b-08de6f3af765
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 22:13:38.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOX6hdeE3Q7MQp1IVulMeQUVEgDjEkVk1qswdc+ETjOW2aLQuHzMkghhGNT0x08NAn/KXa+Pvuw1lW4gvYpLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6096
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69963994 cx=c_pps
 a=5QB7A90Jg1Mn+JdiV6um6w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=3HEcARKfAAAA:8
 a=hSkVLCK3AAAA:8 a=0wepqBKUCjkCF5gvq0UA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=fDn2Ip2BYFVysN9zRZLy:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: Ygi__sN3S5EuYjKY4E-4oa1LxR_ZwylZ
X-Proofpoint-ORIG-GUID: Ygi__sN3S5EuYjKY4E-4oa1LxR_ZwylZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE5MCBTYWx0ZWRfXzdD4m5oIE/mC
 X3BYgQxP9AQFoVfyKbUtW0pxRk9EXFRATzXeikdv1V+x6DhMf2kgNF+i/W/jU9Ii8yBzmJZWpCl
 ZPE17vtXaqNx44S4XTPiXQth7SFwbYQ53Rvrst4bn2oscoV8R23jHyBcEaly5wwGQfMsrjwgI5Q
 umyP4bNIPdGt1bVwWrWH1UiiB2Y6+6LczTXxUag6IqDz2VY+zJ2lmG0qYqKwLdfQcy096W91MgS
 vnQ6D9xTg/FiUUdKA1LiDZM5mpYOOlJeO8kmLkgJzw/gJrZ6vIJWzbNWnKpoiS+Myzu+icAsDHY
 UmszWK0lkikRPsJ3Zim9PY9LL4uQmjUkF41BQ3MGH2TU0jMNLj/+HeKT3fMhIaxKyHGQk6VwGcb
 HnulF9v0zmif/lC9hd24GZhOOnPRWNpwtn3pbjImrTknLNqY4M+QWNk5rvF4FUIrOlypwH3PvLu
 xWzceHNsX8ObpUJQJ7w==
Subject: Re:  [PATCH v6] hfs: update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_05,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-77634-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url,appspotmail.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E07BF15A94B
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTE4IGF0IDIyOjI4ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IHN5emJvdCBpcyByZXBvcnRpbmcgdGhhdCBCVUcoKSBpbiBoZnNfd3JpdGVfaW5vZGUoKSBmaXJl
cw0KPiB3aGVuIHRoZSBpbm9kZSBudW1iZXIgb2YgdGhlIHJlY29yZCByZXRyaWV2ZWQgYXMgYSBy
ZXN1bHQgb2YNCj4gaGZzX2NhdF9maW5kX2JyZWMoSEZTX1JPT1RfQ05JRCkgaXMgbm90IEhGU19S
T09UX0NOSUQsIGZvcg0KPiBjb21taXQgYjkwNWJhZmRlYTIxICgiaGZzOiBTYW5pdHkgY2hlY2sg
dGhlIHJvb3QgcmVjb3JkIikgY2hlY2tlZA0KPiB0aGUgcmVjb3JkIHNpemUgYW5kIHRoZSByZWNv
cmQgdHlwZSBidXQgZGlkIG5vdCBjaGVjayB0aGUgaW5vZGUgbnVtYmVyLg0KPiANCj4gUmVwb3J0
ZWQtYnk6IHN5emJvdCs5N2UzMDFiNGI4MmFlODAzZDIxYkBzeXprYWxsZXIuYXBwc3BvdG1haWwu
Y29tDQo+IENsb3NlczogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91
PWh0dHBzLTNBX19zeXprYWxsZXIuYXBwc3BvdC5jb21fYnVnLTNGZXh0aWQtM0Q5N2UzMDFiNGI4
MmFlODAzZDIxYiZkPUR3SUNhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16
YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09cTQya2R4SGl1M2xLYzZYNEpheUU0
UHI3SW1pSTB2dXZLajloVXNqS2lmRkZTSXJIYXRFSHI3N05BWEM3d1BrYiZzPXJFVmVhZ010dDll
VDhRQ21hOXdTMGNHS3Q0MG92NDRnODl5MjhZXzZuRTQmZT0gDQo+IFNpZ25lZC1vZmYtYnk6IFRl
dHN1byBIYW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5qcD4NCj4gLS0tDQo+
IFZpYWNoZXNsYXYgRHViZXlrbyBhbmQgR2VvcmdlIEFudGhvbnkgVmVybm9uIGFyZSB0cnlpbmcg
dG8gZml4IHRoaXMgcHJvYmxlbQ0KDQpJZiB5b3Ugd291bGQgbGlrZSB0byBmaW5pc2ggR2Vvcmdl
IEFudGhvbnkgVmVybm9uJ3Mgd29yaywgdGhlbiB5b3UgYXJlIHdlbGNvbWUuDQpXZSBoYXZlIG11
bHRpcGxlIGlzc3VlcyBpbiBIRlMvSEZTKyBjb2RlIGJhc2UuIEFuZCBJIGRvbid0IHNlZSBhbnkg
cHJpb3JpdHkgaW4NCnRoaXMgaXNzdWUuIFNvLCBJIGRvbid0IHNlZSB0aGUgcG9pbnQgdG8gYWNj
ZXB0IG5vdCB0aGUgZml4IGJ1dCBhIHdvcmthcm91bmQuIEkNCmFtIG5vdCB3b3JraW5nIG9uIHRo
aXMgaXNzdWUgcmlnaHQgbm93LiBNeSBjdXJyZW50IHByaW9yaXR5IGlzIEhGUy9IRlMrDQp4ZnN0
ZXN0cy9mc3Rlc3RzIGlzc3Vlcy4gDQoNClRoYW5rcywNClNsYXZhLg0KDQo+IGluIGhmc19yZWFk
X2lub2RlKCksIGJ1dCBubyBuZXcgcGF0Y2ggaXMgcHJvcG9zZWQgZm9yIHRocmVlIG1vbnRocw0K
PiAoIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9f
bGttbC5rZXJuZWwub3JnX3JfMjAyNTExMDQwMTQ3MzguMTMxODcyLTJEMy0yRGNvbnRhY3QtNDBn
dmVybm9uLmNvbSZkPUR3SUNhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16
YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09cTQya2R4SGl1M2xLYzZYNEpheUU0
UHI3SW1pSTB2dXZLajloVXNqS2lmRkZTSXJIYXRFSHI3N05BWEM3d1BrYiZzPTVpOVJLSC1uSEIy
ZUlYcWtDbWl2T01TR3NjQkoyTVJrT2VyWWw2Qmw5ek0mZT0gICkgLg0KPiBUaGlzIHByb2JsZW0g
aXMgIm9uZSBvZiB0b3AgY3Jhc2hlcnMgd2hpY2ggaXMgd2FzdGluZyBzeXpib3QgcmVzb3VyY2Vz
IiBhbmQNCj4gImEgdmVyeSBsb3ctaGFuZ2luZyBmcnVpdCB3aGljaCBjYW4gYmUgdHJpdmlhbGx5
IGF2b2lkZWQiLiBJIGFscmVhZHkgdGVzdGVkDQo+IHRoaXMgcGF0Y2ggdXNpbmcgbGludXgtbmV4
dCB0cmVlIGZvciB0d28gd2Vla3MsIGFuZCBzeXpib3QgZGlkIG5vdCBmaW5kDQo+IHByb2JsZW1z
LiBUaGVyZWZvcmUsIHdoaWxlIHdoYXQgdGhleSB3b3VsZCBwcm9wb3NlIG1pZ2h0IHBhcnRpYWxs
eSBvdmVyd3JhcA0KPiB3aXRoIG15IHByb3Bvc2FsLCBsZXQncyBtYWtlIGl0IHBvc3NpYmxlIHRv
IHV0aWxpemUgc3l6Ym90IHJlc291cmNlcyBmb3INCj4gZmluZGluZyBvdGhlciBidWdzLg0KPiAN
Cj4gIGZzL2hmcy9zdXBlci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL3N1cGVyLmMgYi9m
cy9oZnMvc3VwZXIuYw0KPiBpbmRleCA5NzU0NmQ2YjQxZjQuLmMyODNmYzljNWU4OCAxMDA2NDQN
Cj4gLS0tIGEvZnMvaGZzL3N1cGVyLmMNCj4gKysrIGIvZnMvaGZzL3N1cGVyLmMNCj4gQEAgLTM2
MSw3ICszNjEsNyBAQCBzdGF0aWMgaW50IGhmc19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gIAkJCWdvdG8gYmFpbF9oZnNfZmluZDsN
Cj4gIAkJfQ0KPiAgCQloZnNfYm5vZGVfcmVhZChmZC5ibm9kZSwgJnJlYywgZmQuZW50cnlvZmZz
ZXQsIGZkLmVudHJ5bGVuZ3RoKTsNCj4gLQkJaWYgKHJlYy50eXBlICE9IEhGU19DRFJfRElSKQ0K
PiArCQlpZiAocmVjLnR5cGUgIT0gSEZTX0NEUl9ESVIgfHwgcmVjLmRpci5EaXJJRCAhPSBjcHVf
dG9fYmUzMihIRlNfUk9PVF9DTklEKSkNCj4gIAkJCXJlcyA9IC1FSU87DQo+ICAJfQ0KPiAgCWlm
IChyZXMpDQo=

