Return-Path: <linux-fsdevel+bounces-77326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fU/sBCy0k2lW7wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:19:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7C14840F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 01:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2773018779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4C242D86;
	Tue, 17 Feb 2026 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKZvBgy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731E25776;
	Tue, 17 Feb 2026 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771287588; cv=fail; b=T7HVGBsPBeMbRb+aL8klczu5A4Zl+sUOA+1G4UXSYsdofZ054QkXhv9ZIc1R2Z30GUXr8uMfFzpSG5ryaP6dfAmN4QM6N7q5H1fp5KNhPwImcd2UezmacHFBSBSG4h+ZBewAckd4NBAPjhezvlJ1JVhFOTjHxchawYp9oEZTH+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771287588; c=relaxed/simple;
	bh=6kD+9xW3mcoMdzowIoHs+xMeo+iebp0qfmTa2sNZifU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DKUbDpcOqni7EqiNF94owo2vRNZG8ysLpeHw1oJLdQRlgnXnGpOjUcF2lVe5t1PSc+/8WDDHF+jy6QF7nkoK6Ld8AUtgwDVp1HcBTzQuHGPdDrLagapG8iBJPEa2jwjvLk8GMc3fgO+0nsr7XssYfK6vi90inWtDnr4QFkCrXrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKZvBgy9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GFZ1mJ3723169;
	Tue, 17 Feb 2026 00:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=6kD+9xW3mcoMdzowIoHs+xMeo+iebp0qfmTa2sNZifU=; b=hKZvBgy9
	IjJ4/upS2fMpPE0T9nmOnuh0TgVQDB6CX7Mlqzjn3PmR9/aXLBqIpkmtygxKFSsE
	35nxl5uF39QsaHGojR12j1EWtdxadMGRkQe0PmZh1pSq/63Lzg7cDhkaPIQ0Hf5X
	PTGdtzOKBmy+2ZeqqiwaZzorFoG0SsfgWmrgwIFoNrSTmt358zgX1R0x6cEXZVHg
	fyfh9ZDF9uMwtH8DAJKGAL32LJEbd7cwhpdu0M9hCXonBgtKv0exV9MBuhDEXVHh
	KAX/p3jSbDG/MJGKFyUvq0u/tAWGO1pMPbQxOy3hgsRqhIVeI77QtLKvcSk2Z1cR
	B9MyZ6lqrSEPWQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rssxx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 00:19:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clZ2kt4srxLHjrZ7Pw4VQBz1SFKiaymum5acgrCdS0AcZKf97Rxq1v3oLlYHYkFrgtiKKAGgu55I+M2ZwOAx/8Je6TNEoHTGmV6jujmpzU6V59+QXFjBD/PPRchNykQP+je25WM5kkAyZ5NYkcmVzKLTucYM7HIwI6p987+S8gEovA7YBtR5wTwrmzxHJMUAnEUmqCZxDEZCCU6l/d8uU+/JKHMa66TrBKv3xHW59BNBcMcFwFsH6i/PYU8ZeFEjfszvefw9fWIGe79U+QPA67zFmhyu3gLOK4FqzGacz6uU9Exzn4md69De4Jgl1KBHakju6qLTxbADr3iXEdlClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kD+9xW3mcoMdzowIoHs+xMeo+iebp0qfmTa2sNZifU=;
 b=XTOaTrhHfPSHGigsdM2zkJgkRsnc5NOtempw7hMEeAs21Nx9hq8tPiMsXmRsCOBZx8niwFApmIrdfn5sSYEIT1ILR+rXjUl3vktjF6PVy2J6uG3ngWEsuPJx4B/uj7FazR5o19/egV38bsZ43nqhn0Y6zf0SS1KNGR74lQ4KYYS2vmJ/RbDhspqwSIXvo7uLO6dhXKf3MQe/M6GxbDDx8sdK4yiJmU2v8krDa0w42nG0tDPv8S/fIkgXubQJPYMio5BIMW1jBHEJqDunyBDvu0947i2UsZN1idiizl14bJnasBKWW5eK05lCzL2GPSo0oDXECoYEKXOSDmlxhC85qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5492.namprd15.prod.outlook.com (2603:10b6:208:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 00:19:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 00:19:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v4] hfsplus: fix uninit-value by validating
 catalog record size
Thread-Index: AQHcnUfdXV3PMPYAIUuVZyES/Z7XzbWGC56A
Date: Tue, 17 Feb 2026 00:19:34 +0000
Message-ID: <d28f5840ba4ae273fcb0220f2e68d1101bd79d4b.camel@ibm.com>
References: <20260214002100.436125-1-kartikey406@gmail.com>
In-Reply-To: <20260214002100.436125-1-kartikey406@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5492:EE_
x-ms-office365-filtering-correlation-id: c670cea6-b14f-47c1-49c4-08de6dba3ac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmpoZ2t6akJ2L1JTZVVjWHh4a2paL2VpRHVVNEl2QzFMelBxWEkrV1NzSDN1?=
 =?utf-8?B?Y2pCbWJ5Y0EzeXdONW12VHlTQWxsNjlsK3lyc3p5MFUrOXA4cjljbW4wdktO?=
 =?utf-8?B?cktNRmdkNXRwN0Rmcit4Y0hxVGxXYy9JRSt6OW9YbUpva1VaUWlZdHBqZW43?=
 =?utf-8?B?UEhXd3d3TU1mREFiNDI5MVgrRXl5QnVaeUsyNzhveW9RbS9GejJXc1lDTkRG?=
 =?utf-8?B?OVREV1MzaC9xdjFLNG5KOEdycE5XRDVHTFFmMU80NUJlQjI1SFNqTDV2YUh1?=
 =?utf-8?B?ZVhIK245cjViRGdoT2lvMXc4clZiQzFXTUM3NFNJamhKTFdNbS92S1A5UWI4?=
 =?utf-8?B?dU0wcGNBWG1kSUdxaWp6VW1KL3hqRjV1T0VvQU40WENscGliSGRvWGZDRG1M?=
 =?utf-8?B?S05YcTlzTWRaaFlReTJvdzF6K1lZVDhEQmg0dDFUbWNXaERVdmtmU3hKaFA4?=
 =?utf-8?B?b2pnUzNqdWkrZ2E1M05scUhPV202S1J2V3lkQ1hyek56ZjBkU205SGJwQWU0?=
 =?utf-8?B?ajRpa0Judk1xNzRJenlTcW9JeVNqdW8waDFwZUM0TDZsTjFRUm9qZGxhMHZK?=
 =?utf-8?B?UnFNOUtNZXdmenoxMWZGcVo1OWNrRXQ0M1ZTMm53OGp4Wk8yZ24zWE10SnQ4?=
 =?utf-8?B?MjhLRnRmN3dwb3BndGcydVlWSVg5N0JBZDZ3UjlJSllJam1lN29nZjZGSU5k?=
 =?utf-8?B?SmM0QXpzSmU3eFR0SWI5OGNMYWVYUXY5NDQzWjFyS3JRa0gveEhzTWFkZG03?=
 =?utf-8?B?eTNPbGlVNmNuQ05rUTRLejd4T0dFNWZQeUJESHNhdUFFUzhHc1ZBMTIzQTRJ?=
 =?utf-8?B?WDByaE9GODFtTklQSWlFRHcvZDVpbFcwTnJ6WXR0YkV4V3lUQkwzbk9BdTFG?=
 =?utf-8?B?UGRqaGhkM1E5Z01VZHphaDdWRFU2VFhEQ1ZJcnNGRDVMVXpsWmVZUDVyVW9F?=
 =?utf-8?B?VTZzZDhjWlBKQVVYR2xCalhxeGMrMDFaTVRJNmJsYzNRNlNxTURiUm5FU3dp?=
 =?utf-8?B?THh1anBmK1FjaHhVdG9kOTYrdVJNcmFPRzArdmo0bno4OEZqbWlxYXdRLzBS?=
 =?utf-8?B?aEJtWkM3eTlYMnNGMEJHZUZHRDhQY082c2NySGRKMGIvUDI5REdVd0dQYWQ1?=
 =?utf-8?B?SXBKRTdlVkdpSDFJOForbW9hdTV0dVZvblJDUTh1QjJ5cVNiNW5UdVFHUk9S?=
 =?utf-8?B?L1RlQXlQTGlNNnkrZ01uQ2MvTm4zTlQ1cnQxT1ZSU2FQcStKTHg5SDJDSmxI?=
 =?utf-8?B?OTNJS3o3R3B6WmVDZW1naU1ZWW5pcDJWTnE2RnVYTjAvZVgwQ2xaZEEwVDZo?=
 =?utf-8?B?dWNwekgyYjVmYjR6VHJNTHprMVFwUGc2VnFrTlJPTGNpeDZVUkszWE1Ub0kx?=
 =?utf-8?B?N25BMUNtVDJUZUlnd0N2YXBrT0g1b1IzdHc4cGw0YWhZZXZjOVZvN0RjU05P?=
 =?utf-8?B?MWtZV1lYS3lYMXR1bGExNzZITjVwK1V1STBoSk5aNUI3YkluL2hZTXlCRXpE?=
 =?utf-8?B?emd1a0M3S2k3Mkpkd3MyYmpUS0NNcGNlRUdjZGJqaUtrNzdtM2sxNXUvMFVL?=
 =?utf-8?B?S2hCaFBGZEpaS0lkbFdGRWp0cmhhL0k3ZG1mMGIrRWNVa1ZhT1pJZkd1MTNU?=
 =?utf-8?B?OVVEWjhXR2gwTU1SVUE0QjZLVW0rOE1pdEVROHVyMFhDNDBWOUY3R0tmZU8z?=
 =?utf-8?B?MVFSdnBjc2lsMXhKR3ZWaUEyT1h2UmcrcmQwWWEzeDhSU0YxV0NyanI4Sm5j?=
 =?utf-8?B?c2RnbVNmNjRMUlJMWUI3YVhId1Q2djFpaEQzd1owV25OcGNUWm85Sld4QjRK?=
 =?utf-8?B?NmVrVk5QR2lEeWRKdDRuTjFaWDYwNzNVUThsb1AxdGRRSGw3aW1QSEUrMTVt?=
 =?utf-8?B?Y0pud0VEZmxVc0hRZmR2U3dCMllHRHpiWEZkRVNTa3p6azV2OW02d2RIUkR6?=
 =?utf-8?B?NlhhYzl3Qm5zMitiRjVXR2VrUzZuL1ZFL2RPSVFmdjFjcXFsQndiRXdHRzhj?=
 =?utf-8?B?ZEJvV0Q5KzNWZjc2UkxpREM0TUdXN2lVWWFET2xEaDV5UFNWWXkvODJWZXp0?=
 =?utf-8?B?eVl4Q3lETDlGZm5LQUl1NG96alRKZVFrOWdibEt2NW1PMnQwSEp2UjU0STB3?=
 =?utf-8?Q?loqyF1sWc3AbeRcALrRrwwhx7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEJlOURMWkU3N29DWmNybDNFVnJkOHN2STBmejMvVlo0czRFV3dieFFqZ1NS?=
 =?utf-8?B?bXlVRFc4UHcxKzJTbXFDSytwOWgvVWpkOStyYnNFVHNpUVZNZWkvVnpBa0Fk?=
 =?utf-8?B?cTdubGxsYVpocXFMbHdtNWQyWUFta1l2djFRRFIxZkFJUStKcTRGalBRWkNJ?=
 =?utf-8?B?bWlBcmdQNEN6NDR6ZlVwOVFXZ05QbW9xK2JRS2wxZHY1NElXRTdqZlJ6K0Jk?=
 =?utf-8?B?all4ZjFadUorRFNGUnFnOHExVkdOYTdZNy9SaWRsSGpKSmV1aWJwSzJ3MGk0?=
 =?utf-8?B?aFEyRERuY05qcjdKdmR0RElZaEpVSTZOWWZYMXd6STJlNnMxNjJkN0tHWkc4?=
 =?utf-8?B?dFcvWVdiT0NGU3B5M0RtUFlZbVVWdTVaUEcxSkM2UFFPcEkzSmhPZkY5T2hj?=
 =?utf-8?B?NFlQcmRYQm9JVklKNnNrQ3NPTEJoMCtqQ0dHUWRuTTRJaE5vRVE5T0dPL0Yx?=
 =?utf-8?B?engwNGF5VTM2SFV4bUE4a3NqTmNoNUhvQVdxS3daUEpjS2NjSkFPQjFvYkgw?=
 =?utf-8?B?SDV2Vm13Ny9wMnQ5ZjhJRnB0ZkpFaWNpanFPTXZOc0tOWUFMOVpHOXg2Znhv?=
 =?utf-8?B?Ums0Q3hoNUV0Qks5NEVwZDQxZ0o2Smk3eXF4WVhwTTJSWTVXYzB5clNIT0NH?=
 =?utf-8?B?RXdoOWE5bHc4SEMvRjlyZTZoT0xNRDVuRDlVUlM5K1EvYUNjM0VzY25YM3VH?=
 =?utf-8?B?aUhGckQ3cVpIYWxrK2FGMkc4Z05ZNUVuV1pPaldzeTJGQjJQcHNCTGtDb3lT?=
 =?utf-8?B?a1JVanF4VWJncCtkeW9HdzNCT2xmYXYycXJDZTEzTldBMmY5SkdIRHJSRDY4?=
 =?utf-8?B?WUpGME9xWFY2TzlhWVBJUHM0VWZ5bytYWHNUYjhKc0JSUVRTSUNCbmpRSDEw?=
 =?utf-8?B?YnBEQ28vTmdvU3EzTE8vMW91YXRLbDJUMzZDOFBnVTBNOExTRnFvOERIeWlj?=
 =?utf-8?B?NlR5dk9ES25vb1hhbEJmVFFUUnFVM3ZVRHd6Kzd0U1dlTUdScVlRSXA1eUZt?=
 =?utf-8?B?UWVRWDVkNVpSWm9Nb0R2SWN6TmZvbjhYUTVyT24xZ0JEK3JEZ3hTMGdQRC83?=
 =?utf-8?B?cnlkVk1tZGNFb2ZPRThiZGE4eUt3T1pQRWVVNEFYT2MvR0FFY1FSWnFkT3V2?=
 =?utf-8?B?akUremRMd1NkZVlJT3A3Q0hLcEE5ZmVnWHZVcllDZFpjTE00S09xQ1R6akYr?=
 =?utf-8?B?UVFQT0cwY0paZXJwK2pVTGlvazgrVDYxSjJCQ3hzV2JoOGFPOTJTYTVVckVh?=
 =?utf-8?B?OGlhWCtmQmJObUNjUUFPVzUwWEl2b3J4WHcrMEo1ZGpMU0FURFAxMVNsYjdU?=
 =?utf-8?B?ME9CQUdYNW5ET0VkaXVrMUJ2aUdUOUphazEzTEpZTUhrcjNIRTBiOHVYcHRj?=
 =?utf-8?B?cDZKNU1uc1JtS1lRQUJOd0JHUURuUG9vcmdpakF1bm5XaGdzY3hLR1V5RGRz?=
 =?utf-8?B?ZjRwaXVEekRxTEhvT1AxRFBnNW44S2RiVVFFcUhwTTFMUnptL2J3Ty9QN0RT?=
 =?utf-8?B?cW56elpOQitmdWVtanJGQVNwMmNTMGxiOGphY1V4NUw2K2pmK3lZMlM0Q2Zx?=
 =?utf-8?B?eFJQb2g3U1BJSmptSytta29OTTFJWVltU0ZySUdxcjdpQ01NZDdCdnZ2eHgv?=
 =?utf-8?B?NHV4L2VXaGdtNSt0SW9oQlUzdTNWYUlTYmRQdEZtamphb0N1dDBFa1pwdnNy?=
 =?utf-8?B?cXVxalE3RUJLTFhEVFhaRjVGNG5DdU51eS9JNWhMSTcvSFZJNFpMUnZOR3Fk?=
 =?utf-8?B?S0VVMUV6dDJOYkI3eU9JS2RKSjRrN1kwVlY2NG5meGJzVnZzbnVObENZcXIx?=
 =?utf-8?B?d1dUblBRS250VFJjYUZFYnNHdE12SThybW5ibjNTbU9BdzRKY1RPSHZjU1hH?=
 =?utf-8?B?RDBkenRkRGVZSzJNdDR4Z1JqZjByM3RnNmhrS0VjcENxQkF6MFpHTmVuYlla?=
 =?utf-8?B?UmJHemRGb1I3OHlZOWw1anorZmNOZThLem1aRFltQm9uUXVFelZPZzI1OG0w?=
 =?utf-8?B?MlFjMHJjSDNTaXhzcTRrUkcxaWdCUzhXVnhNdzlxMFlhSDlOZ0lRbUJCVUZ1?=
 =?utf-8?B?Y25nL3UxTmlBcDdmZ3liL254a2RCQ0JzNEtyaU5rL3liV1g1dGhlOGxFRUsr?=
 =?utf-8?B?Rnd0TklxMFM3ZUpCM1lDR01NQndGNE5taFI3TzFBc0pYa2tMYkVmVlUzSHQ1?=
 =?utf-8?B?dzJ5bjRiV013djIwLzg0c2x1bXdMVnduVFN3NG5HRUppVmdRTit3bElITUdj?=
 =?utf-8?B?cmFQMW5ocDhtcy9GUGJmZm9xLzNqOFlTcU9sME1oZ3N0VGU2dC80dzVhaHdo?=
 =?utf-8?B?SjVGVFR6YXRnaTYyc1ByODdsckVIYlZyUnlMNnFuV2YwN2s2Z3d5dWpRQzY3?=
 =?utf-8?Q?r0lafqO0u/cXsB9KcOj7KEd5cEQGdUroBWU8K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BFEF1D7BCFC894FB1DCAF273F4FE9D2@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c670cea6-b14f-47c1-49c4-08de6dba3ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 00:19:34.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bfasc4hVwom3nngRNWYWefaS4CYZYbgs37QHRWsNfYBIsHMa6buUXwRLOCt9IommgmYvkOeoiiOjRdZkVp7Cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5492
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6993b41c cx=c_pps
 a=r4SLCykQvtwIPvheKTZvSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=b_IiuD9Wi6I2DJurEOgA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: GZyJC-KMta4iosoPgSpbSZt2MELiuPSu
X-Proofpoint-ORIG-GUID: 0rC8MlVmviq2UKE2E6kdwrp6hhLw4fRt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDIwNyBTYWx0ZWRfX373N+ooFf2cU
 5yMylTOkfY5EUraWCZXeF3Z9Ca4TbGQ3zEVs/eu4mWUjnywYiLlyHdbh43mWoOI7T9wHQK0jfuD
 BYYrojlgU6qihwupxMk+H1n10QofedycTr04cyPEy+nV6aoD5GXRL7uoqpBCoiZ5FRfeX1GNpDK
 RkafKi89msrqZV5txdJoInm5SzXK9nCReE1c6E/+QOFOOs9g6cTZDUCpziRxGlO18jlFkX2lOCe
 NxL3y1u1+aHKJ8O7N1BWHHVplFJ4IVDnKGZ7MzA1Qev+enJ90Oz15wKPgS9OhkTl+BqVl5v+zfT
 B0/qh/a+q84Wh7XGZf++64SQYF+1aDpn5O/RRR2wwFA5x+QZPIbZCqKKkfVo7cZaberUhISjNk2
 gTlHat3jUF1771DALD7Bia/Ob7jNrjYsVSxTRHwxeM+ULx6Ixyh780wOzQ5EX0W5ELY2XSDkcUJ
 sQHEG+szqOD33EJESLQ==
Subject: Re:  [PATCH v4] hfsplus: fix uninit-value by validating catalog
 record size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77326-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,dubeyko.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AF7C14840F
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTE0IGF0IDA1OjUxICswNTMwLCBEZWVwYW5zaHUgS2FydGlrZXkgd3Jv
dGU6DQo+IFN5emJvdCByZXBvcnRlZCBhIEtNU0FOIHVuaW5pdC12YWx1ZSBpc3N1ZSBpbiBoZnNw
bHVzX3N0cmNhc2VjbXAoKS4gVGhlDQo+IHJvb3QgY2F1c2UgaXMgdGhhdCBoZnNfYnJlY19yZWFk
KCkgZG9lc24ndCB2YWxpZGF0ZSB0aGF0IHRoZSBvbi1kaXNrDQo+IHJlY29yZCBzaXplIG1hdGNo
ZXMgdGhlIGV4cGVjdGVkIHNpemUgZm9yIHRoZSByZWNvcmQgdHlwZSBiZWluZyByZWFkLg0KPiAN
Cj4gV2hlbiBtb3VudGluZyBhIGNvcnJ1cHRlZCBmaWxlc3lzdGVtLCBoZnNfYnJlY19yZWFkKCkg
bWF5IHJlYWQgbGVzcyBkYXRhDQo+IHRoYW4gZXhwZWN0ZWQuIEZvciBleGFtcGxlLCB3aGVuIHJl
YWRpbmcgYSBjYXRhbG9nIHRocmVhZCByZWNvcmQsIHRoZQ0KPiBkZWJ1ZyBvdXRwdXQgc2hvd2Vk
Og0KPiANCj4gICBIRlNQTFVTX0JSRUNfUkVBRDogcmVjX2xlbj01MjAsIGZkLT5lbnRyeWxlbmd0
aD0yNg0KPiAgIEhGU1BMVVNfQlJFQ19SRUFEOiBXQVJOSU5HIC0gZW50cnlsZW5ndGggKDI2KSA8
IHJlY19sZW4gKDUyMCkgLSBQQVJUSUFMIFJFQUQhDQo+IA0KPiBoZnNfYnJlY19yZWFkKCkgb25s
eSB2YWxpZGF0ZXMgdGhhdCBlbnRyeWxlbmd0aCBpcyBub3QgZ3JlYXRlciB0aGFuIHRoZQ0KPiBi
dWZmZXIgc2l6ZSwgYnV0IGRvZXNuJ3QgY2hlY2sgaWYgaXQncyBsZXNzIHRoYW4gZXhwZWN0ZWQu
IEl0IHN1Y2Nlc3NmdWxseQ0KPiByZWFkcyAyNiBieXRlcyBpbnRvIGEgNTIwLWJ5dGUgc3RydWN0
dXJlIGFuZCByZXR1cm5zIHN1Y2Nlc3MsIGxlYXZpbmcgNDk0DQo+IGJ5dGVzIHVuaW5pdGlhbGl6
ZWQuDQo+IA0KPiBUaGlzIHVuaW5pdGlhbGl6ZWQgZGF0YSBpbiB0bXAudGhyZWFkLm5vZGVOYW1l
IHRoZW4gZ2V0cyBjb3BpZWQgYnkNCj4gaGZzcGx1c19jYXRfYnVpbGRfa2V5X3VuaSgpIGFuZCB1
c2VkIGJ5IGhmc3BsdXNfc3RyY2FzZWNtcCgpLCB0cmlnZ2VyaW5nDQo+IHRoZSBLTVNBTiB3YXJu
aW5nIHdoZW4gdGhlIHVuaW5pdGlhbGl6ZWQgYnl0ZXMgYXJlIHVzZWQgYXMgYXJyYXkgaW5kaWNl
cw0KPiBpbiBjYXNlX2ZvbGQoKS4NCj4gDQo+IEZpeCBieSBpbnRyb2R1Y2luZyBoZnNwbHVzX2Jy
ZWNfcmVhZF9jYXQoKSB3cmFwcGVyIHRoYXQ6DQo+IDEuIENhbGxzIGhmc19icmVjX3JlYWQoKSB0
byByZWFkIHRoZSBkYXRhDQo+IDIuIFZhbGlkYXRlcyB0aGUgcmVjb3JkIHNpemUgYmFzZWQgb24g
dGhlIHR5cGUgZmllbGQ6DQo+ICAgIC0gRml4ZWQgc2l6ZSBmb3IgZm9sZGVyIGFuZCBmaWxlIHJl
Y29yZHMNCj4gICAgLSBWYXJpYWJsZSBzaXplIGZvciB0aHJlYWQgcmVjb3JkcyAoZGVwZW5kcyBv
biBzdHJpbmcgbGVuZ3RoKQ0KPiAzLiBSZXR1cm5zIC1FSU8gaWYgc2l6ZSBkb2Vzbid0IG1hdGNo
IGV4cGVjdGVkDQo+IA0KPiBBbHNvIGluaXRpYWxpemUgdGhlIHRtcCB2YXJpYWJsZSBpbiBoZnNw
bHVzX2ZpbmRfY2F0KCkgYXMgZGVmZW5zaXZlDQo+IHByb2dyYW1taW5nIHRvIGVuc3VyZSBubyB1
bmluaXRpYWxpemVkIGRhdGEgZXZlbiBpZiB2YWxpZGF0aW9uIGlzDQo+IGJ5cGFzc2VkLg0KPiAN
Cj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtkODBhYmI1Yjg5MGQzOTI2MWU3MkBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tDQo+IENsb3NlczogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLTNBX19zeXprYWxsZXIuYXBwc3BvdC5jb21fYnVnLTNGZXh0aWQtM0Rk
ODBhYmI1Yjg5MGQzOTI2MWU3MiZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1x
NWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09SHNBM180dXdKS21T
UzgtS2hfS1NTTlpEZElKSjM3ZlFnMVFrbjhITlZ0bHZPV1RSVW90V2RYLVlVLTZCRzVFayZzPWFo
U2lOcDA5WHRrNmZaNEoxSEtOVklLR1lNeUFBQjZwQjB6U01NTHVpRFkmZT0gDQo+IEZpeGVzOiAx
ZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikNCj4gVGVzdGVkLWJ5OiBzeXpib3QrZDgw
YWJiNWI4OTBkMzkyNjFlNzJAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBMaW5rOiBodHRw
czovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2Vy
bmVsLm9yZ19hbGxfMjAyNjAxMjAwNTExMTQuMTI4MTI4NS0yRDEtMkRrYXJ0aWtleTQwNi00MGdt
YWlsLmNvbV8mZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4
Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPUhzQTNfNHV3SkttU1M4LUtoX0tTU05a
RGRJSkozN2ZRZzFRa244SE5WdGx2T1dUUlVvdFdkWC1ZVS02Qkc1RWsmcz1tNUtBVFNlY2pfTjU5
alJ5Y2txV3dUREhMV3NBay1TQTRNY0ZpVVRweUhnJmU9ICBbdjFdDQo+IExpbms6IGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwu
b3JnX2FsbF8yMDI2MDEyMTA2MzEwOS4xODMwMjYzLTJEMS0yRGthcnRpa2V5NDA2LTQwZ21haWwu
Y29tXyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUx
X1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09SHNBM180dXdKS21TUzgtS2hfS1NTTlpEZElK
SjM3ZlFnMVFrbjhITlZ0bHZPV1RSVW90V2RYLVlVLTZCRzVFayZzPUt0eGQtOEU4NDhLbzNTS0ot
aFoyX1ZvYTVDQklDU2FZbUdZMWk5Rm5MNk0mZT0gIFt2Ml0NCj4gTGluazogaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdf
YWxsXzIwMjYwMjEyMDE0MjMzLjI0MjIwNDYtMkQxLTJEa2FydGlrZXk0MDYtNDBnbWFpbC5jb21f
JmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdt
blEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1Ic0EzXzR1d0pLbVNTOC1LaF9LU1NOWkRkSUpKMzdm
UWcxUWtuOEhOVnRsdk9XVFJVb3RXZFgtWVUtNkJHNUVrJnM9S2NNUF8zS1k4U3VLUkZoaENyamFL
ZlVKOUNlNG5iaF9XdXVZbC00ZHl2VSZlPSAgW3YzXQ0KPiBTaWduZWQtb2ZmLWJ5OiBEZWVwYW5z
aHUgS2FydGlrZXkgPGthcnRpa2V5NDA2QGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4g
djQ6DQo+IC0gTW92ZSBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSgpIGFzIHN0YXRpYyBpbmxpbmUg
dG8gaGVhZGVyIGZpbGUgYXMNCj4gICBzdWdnZXN0ZWQgYnkgVmlhY2hlc2xhdiBEdWJleWtvDQo+
IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEludHJvZHVjZWQgaGZzcGx1c19icmVjX3JlYWRfY2F0
KCkgd3JhcHBlciBmdW5jdGlvbiBmb3IgY2F0YWxvZy1zcGVjaWZpYw0KPiAgIHZhbGlkYXRpb24g
aW5zdGVhZCBvZiBtb2RpZnlpbmcgZ2VuZXJpYyBoZnNfYnJlY19yZWFkKCkNCj4gLSBBZGRlZCBo
ZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSgpIGhlbHBlciB0byBjYWxjdWxhdGUgdmFyaWFibGUtc2l6
ZSB0aHJlYWQNCj4gICByZWNvcmQgc2l6ZXMNCj4gLSBVc2UgZXhhY3Qgc2l6ZSBtYXRjaCAoIT0p
IGluc3RlYWQgb2YgbWluaW11bSBzaXplIGNoZWNrICg8KQ0KPiAtIFVzZSBzaXplb2YoaGZzcGx1
c191bmljaHIpIGluc3RlYWQgb2YgaGFyZGNvZGVkIHZhbHVlIDINCj4gLSBVcGRhdGVkIGFsbCBj
YXRhbG9nIHJlY29yZCByZWFkIHNpdGVzIHRvIHVzZSBuZXcgd3JhcHBlciBmdW5jdGlvbg0KPiAt
IEFkZHJlc3NlZCByZXZpZXcgZmVlZGJhY2sgZnJvbSBWaWFjaGVzbGF2IER1YmV5a28NCj4gDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gVXNlIHN0cnVjdHVyZSBpbml0aWFsaXphdGlvbiAoPSB7MH0p
IGluc3RlYWQgb2YgbWVtc2V0KCkNCj4gLSBJbXByb3ZlZCBjb21taXQgbWVzc2FnZSB0byBjbGFy
aWZ5IGhvdyB1bmluaXRpYWxpemVkIGRhdGEgaXMgdXNlZA0KPiAtLS0NCj4gIGZzL2hmc3BsdXMv
YmZpbmQuYyAgICAgIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gIGZzL2hmc3BsdXMvY2F0YWxvZy5jICAgIHwgIDQgKystLQ0KPiAgZnMvaGZzcGx1cy9k
aXIuYyAgICAgICAgfCAgMiArLQ0KPiAgZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmggfCAgOSArKysr
KysrKw0KPiAgZnMvaGZzcGx1cy9zdXBlci5jICAgICAgfCAgMiArLQ0KPiAgNSBmaWxlcyBjaGFu
Z2VkLCA1OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL2hmc3BsdXMvYmZpbmQuYyBiL2ZzL2hmc3BsdXMvYmZpbmQuYw0KPiBpbmRleCA5Yjg5ZGNl
MDBlZTkuLjRjNWZkMjE1ODVlZiAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9iZmluZC5jDQo+
ICsrKyBiL2ZzL2hmc3BsdXMvYmZpbmQuYw0KPiBAQCAtMjk3LDMgKzI5Nyw0OSBAQCBpbnQgaGZz
X2JyZWNfZ290byhzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQsIGludCBjbnQpDQo+ICAJZmQtPmJu
b2RlID0gYm5vZGU7DQo+ICAJcmV0dXJuIHJlczsNCj4gIH0NCj4gKw0KPiArLyoqDQo+ICsgKiBo
ZnNwbHVzX2JyZWNfcmVhZF9jYXQgLSByZWFkIGFuZCB2YWxpZGF0ZSBhIGNhdGFsb2cgcmVjb3Jk
DQo+ICsgKiBAZmQ6IGZpbmQgZGF0YSBzdHJ1Y3R1cmUNCj4gKyAqIEBlbnRyeTogcG9pbnRlciB0
byBjYXRhbG9nIGVudHJ5IHRvIHJlYWQgaW50bw0KPiArICoNCj4gKyAqIFJlYWRzIGEgY2F0YWxv
ZyByZWNvcmQgYW5kIHZhbGlkYXRlcyBpdHMgc2l6ZSBtYXRjaGVzIHRoZSBleHBlY3RlZA0KPiAr
ICogc2l6ZSBiYXNlZCBvbiB0aGUgcmVjb3JkIHR5cGUuDQo+ICsgKg0KPiArICogUmV0dXJucyAw
IG9uIHN1Y2Nlc3MsIG9yIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4NCj4gKyAqLw0K
PiAraW50IGhmc3BsdXNfYnJlY19yZWFkX2NhdChzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQsIGhm
c3BsdXNfY2F0X2VudHJ5ICplbnRyeSkNCj4gK3sNCj4gKwlpbnQgcmVzOw0KPiArCXUzMiBleHBl
Y3RlZF9zaXplOw0KPiArDQo+ICsJcmVzID0gaGZzX2JyZWNfcmVhZChmZCwgZW50cnksIHNpemVv
ZihoZnNwbHVzX2NhdF9lbnRyeSkpOw0KPiArCWlmIChyZXMpDQo+ICsJCXJldHVybiByZXM7DQo+
ICsNCj4gKwkvKiBWYWxpZGF0ZSBjYXRhbG9nIHJlY29yZCBzaXplIGJhc2VkIG9uIHR5cGUgKi8N
Cj4gKwlzd2l0Y2ggKGJlMTZfdG9fY3B1KGVudHJ5LT50eXBlKSkgew0KPiArCWNhc2UgSEZTUExV
U19GT0xERVI6DQo+ICsJCWV4cGVjdGVkX3NpemUgPSBzaXplb2Yoc3RydWN0IGhmc3BsdXNfY2F0
X2ZvbGRlcik7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgSEZTUExVU19GSUxFOg0KPiArCQlleHBl
Y3RlZF9zaXplID0gc2l6ZW9mKHN0cnVjdCBoZnNwbHVzX2NhdF9maWxlKTsNCj4gKwkJYnJlYWs7
DQo+ICsJY2FzZSBIRlNQTFVTX0ZPTERFUl9USFJFQUQ6DQo+ICsJY2FzZSBIRlNQTFVTX0ZJTEVf
VEhSRUFEOg0KPiArCQlleHBlY3RlZF9zaXplID0gaGZzcGx1c19jYXRfdGhyZWFkX3NpemUoJmVu
dHJ5LT50aHJlYWQpOw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0KPiArCQlwcl9lcnIoInVu
a25vd24gY2F0YWxvZyByZWNvcmQgdHlwZSAlZFxuIiwNCj4gKwkJICAgICAgIGJlMTZfdG9fY3B1
KGVudHJ5LT50eXBlKSk7DQo+ICsJCXJldHVybiAtRUlPOw0KPiArCX0NCj4gKw0KPiArCWlmIChm
ZC0+ZW50cnlsZW5ndGggIT0gZXhwZWN0ZWRfc2l6ZSkgew0KPiArCQlwcl9lcnIoImNhdGFsb2cg
cmVjb3JkIHNpemUgbWlzbWF0Y2ggKHR5cGUgJWQsIGdvdCAldSwgZXhwZWN0ZWQgJXUpXG4iLA0K
PiArCQkgICAgICAgYmUxNl90b19jcHUoZW50cnktPnR5cGUpLCBmZC0+ZW50cnlsZW5ndGgsIGV4
cGVjdGVkX3NpemUpOw0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvY2F0YWxvZy5jIGIvZnMvaGZzcGx1
cy9jYXRhbG9nLmMNCj4gaW5kZXggMDJjMWVlZTRhNGI4Li42YzgzODBmNzIwOGQgMTAwNjQ0DQo+
IC0tLSBhL2ZzL2hmc3BsdXMvY2F0YWxvZy5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvY2F0YWxvZy5j
DQo+IEBAIC0xOTQsMTIgKzE5NCwxMiBAQCBzdGF0aWMgaW50IGhmc3BsdXNfZmlsbF9jYXRfdGhy
ZWFkKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ICBpbnQgaGZzcGx1c19maW5kX2NhdChzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1MzIgY25pZCwNCj4gIAkJICAgICBzdHJ1Y3QgaGZzX2ZpbmRf
ZGF0YSAqZmQpDQo+ICB7DQo+IC0JaGZzcGx1c19jYXRfZW50cnkgdG1wOw0KPiArCWhmc3BsdXNf
Y2F0X2VudHJ5IHRtcCA9IHswfTsNCj4gIAlpbnQgZXJyOw0KPiAgCXUxNiB0eXBlOw0KPiAgDQo+
ICAJaGZzcGx1c19jYXRfYnVpbGRfa2V5X3dpdGhfY25pZChzYiwgZmQtPnNlYXJjaF9rZXksIGNu
aWQpOw0KPiAtCWVyciA9IGhmc19icmVjX3JlYWQoZmQsICZ0bXAsIHNpemVvZihoZnNwbHVzX2Nh
dF9lbnRyeSkpOw0KPiArCWVyciA9IGhmc3BsdXNfYnJlY19yZWFkX2NhdChmZCwgJnRtcCk7DQo+
ICAJaWYgKGVycikNCj4gIAkJcmV0dXJuIGVycjsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZz
cGx1cy9kaXIuYyBiL2ZzL2hmc3BsdXMvZGlyLmMNCj4gaW5kZXggY2FkZjBiNWY5MzQyLi5kODZl
MmY3YjI4OWMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMvZGlyLmMNCj4gKysrIGIvZnMvaGZz
cGx1cy9kaXIuYw0KPiBAQCAtNDksNyArNDksNyBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqaGZz
cGx1c19sb29rdXAoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4g
IAlpZiAodW5saWtlbHkoZXJyIDwgMCkpDQo+ICAJCWdvdG8gZmFpbDsNCj4gIGFnYWluOg0KPiAt
CWVyciA9IGhmc19icmVjX3JlYWQoJmZkLCAmZW50cnksIHNpemVvZihlbnRyeSkpOw0KPiArCWVy
ciA9IGhmc3BsdXNfYnJlY19yZWFkX2NhdCgmZmQsICZlbnRyeSk7DQo+ICAJaWYgKGVycikgew0K
PiAgCQlpZiAoZXJyID09IC1FTk9FTlQpIHsNCj4gIAkJCWhmc19maW5kX2V4aXQoJmZkKTsNCj4g
ZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oIGIvZnMvaGZzcGx1cy9oZnNwbHVz
X2ZzLmgNCj4gaW5kZXggNDVmZTNhMTJlY2JhLi5lODExZDMzODYxYWYgMTAwNjQ0DQo+IC0tLSBh
L2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oDQo+ICsrKyBiL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5o
DQo+IEBAIC01MDYsNiArNTA2LDE1IEBAIGludCBoZnNwbHVzX3N1Ym1pdF9iaW8oc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgc2VjdG9yX3Qgc2VjdG9yLCB2b2lkICpidWYsDQo+ICAJCSAgICAgICB2
b2lkICoqZGF0YSwgYmxrX29wZl90IG9wZik7DQo+ICBpbnQgaGZzcGx1c19yZWFkX3dyYXBwZXIo
c3RydWN0IHN1cGVyX2Jsb2NrICpzYik7DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgdTMyIGhmc3Bs
dXNfY2F0X3RocmVhZF9zaXplKGNvbnN0IHN0cnVjdCBoZnNwbHVzX2NhdF90aHJlYWQgKnRocmVh
ZCkNCj4gK3sNCj4gKwlyZXR1cm4gb2Zmc2V0b2Yoc3RydWN0IGhmc3BsdXNfY2F0X3RocmVhZCwg
bm9kZU5hbWUpICsNCj4gKwkgICAgICAgb2Zmc2V0b2Yoc3RydWN0IGhmc3BsdXNfdW5pc3RyLCB1
bmljb2RlKSArDQo+ICsJICAgICAgIGJlMTZfdG9fY3B1KHRocmVhZC0+bm9kZU5hbWUubGVuZ3Ro
KSAqIHNpemVvZihoZnNwbHVzX3VuaWNocik7DQo+ICt9DQo+ICsNCj4gK2ludCBoZnNwbHVzX2Jy
ZWNfcmVhZF9jYXQoc3RydWN0IGhmc19maW5kX2RhdGEgKmZkLCBoZnNwbHVzX2NhdF9lbnRyeSAq
ZW50cnkpOw0KPiArDQo+ICAvKg0KPiAgICogdGltZSBoZWxwZXJzOiBjb252ZXJ0IGJldHdlZW4g
MTkwNC1iYXNlIGFuZCAxOTcwLWJhc2UgdGltZXN0YW1wcw0KPiAgICoNCj4gZGlmZiAtLWdpdCBh
L2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBpbmRleCBhYWZmYTll
MDYwYTAuLmU1OTYxMWE2NjRlZiAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+
ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBAQCAtNTY3LDcgKzU2Nyw3IEBAIHN0YXRpYyBp
bnQgaGZzcGx1c19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19j
b250ZXh0ICpmYykNCj4gIAllcnIgPSBoZnNwbHVzX2NhdF9idWlsZF9rZXkoc2IsIGZkLnNlYXJj
aF9rZXksIEhGU1BMVVNfUk9PVF9DTklELCAmc3RyKTsNCj4gIAlpZiAodW5saWtlbHkoZXJyIDwg
MCkpDQo+ICAJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiAtCWlmICghaGZzX2JyZWNfcmVhZCgmZmQs
ICZlbnRyeSwgc2l6ZW9mKGVudHJ5KSkpIHsNCj4gKwlpZiAoIWhmc3BsdXNfYnJlY19yZWFkX2Nh
dCgmZmQsICZlbnRyeSkpIHsNCj4gIAkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiAgCQlpZiAoZW50
cnkudHlwZSAhPSBjcHVfdG9fYmUxNihIRlNQTFVTX0ZPTERFUikpIHsNCj4gIAkJCWVyciA9IC1F
SU87DQoNClRoZSBwYXRjaCBsb29rcyBnb29kLiBJIGRvbid0IGhhdmUgYW55IHJlbWFya3MuIEkg
dGhpbmsgdGhhdCB3ZSd2ZSByZWNlaXZlZA0KcHJldHR5IGdvb2Qgc3VnZ2VzdGlvbiBob3cgdGhl
IHBhdGNoIGNvdWxkIGJlIGltcHJvdmVkLiBDb3VsZCB5b3UgaW1wcm92ZSB0aGUNCnBhdGNoPyA6
KQ0KDQpJIGFzc3VtZSB0aGF0IHdlIGhhdmUgdGhlIHNhbWUgaXNzdWUgZm9yIEhGUyBjYXNlLiBG
cmFua2x5IHNwZWFraW5nLCBJIGFtDQpjb25zaWRlcmluZyB0byBtYWtlIHRoZSBiLXRyZWUgZnVu
Y3Rpb25hbGl0eSBnZW5lcmljIG9uZSBmb3IgSEZTL0hGUysgYmVjYXVzZQ0KdGhlcmUgYXJlIG11
bHRpcGxlIHNpbWlsYXJpdGllcyBpbiB0aGlzIGxvZ2ljLiBXb3VsZCB5b3UgbGlrZSB0byB0cnkg
dG8NCmdlbmVyYWxpemUgdGhpcyBiLXRyZWUgZnVuY3Rpb25hbGl0eSBpbiB0aGUgZm9ybSBvZiBs
aWJoZnMgb3Igc29tZXRoaW5nIGxpa2UNCnRoaXM/DQoNClRoYW5rcywNClNsYXZhLg0K

