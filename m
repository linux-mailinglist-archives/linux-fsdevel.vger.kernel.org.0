Return-Path: <linux-fsdevel+bounces-75663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFuGKY9IeWl0wQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:21:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112109B5ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981C7301D33B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5122EC0AD;
	Tue, 27 Jan 2026 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Abm5E7a+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C872E1726;
	Tue, 27 Jan 2026 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556095; cv=fail; b=VG/ShYXnosMnJExN8iCQkoxyW9nGlmhTmFaJIkxJp976/6yzNwZKFrEYRQMBOfEbH3FYx5A46NcrX5meRfIAT9wsf0dV97VkavnVUKng6KUVbP5VuV4Lsn2H8BxjmQ8VZgygoMkD+mrGA9qX/HPbDwLKzSnp9pTq4/8FNSFZQEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556095; c=relaxed/simple;
	bh=9MQ6AfoVVcd4gNQ5gB7A2qsQ41f4adgrUw8W26RcgdA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rIgNkPwA7OUi6e0yWDjxFY+7JYT6TG4TkNLMEDBXUY3YD4hBi3fihpwocrMIOWg2uyywqQpkfv8DefiJHBs50C6sXa4OrNoIKxDG2RxlaI7npLKO6cbLtYJFDp+gIHdiR4AvwvLDjl7szm985MdJrhdM6/yf1C8Vif4gBq9Mgq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Abm5E7a+; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RGeVWN029492;
	Tue, 27 Jan 2026 23:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9MQ6AfoVVcd4gNQ5gB7A2qsQ41f4adgrUw8W26RcgdA=; b=Abm5E7a+
	O4wIgjtLJzWhNJW64g3l0RHSrjFxWlAD1MtGZSVzTjxYEHAnzvVJq7k9bMGi+gyN
	p+wsBz4prY71LZMVkgjzkWIdJ+TUnE3t5n/SIm1TBD6Pwndy+aiSsUDKrfDFI0nP
	sdwwGpcH3Ec2+PGwPOPCII07oBG2uFgl592T16VeKt5WC95rHKXc8GYjRHgqbj0M
	ymFJe2BS++wd7njzVMKB2zObmyPTaZ5nWnrqStFimyYgWmkcsuHOpD48MfU+HGIo
	nJEolBB5NL/E3U+tXwVNaG6IrGVvYn3I4u4qhiuCKZeNVO3qIkCKdckEBRg5Krb6
	WTqSPM5MmQDpUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk7088e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 23:21:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RNGlww027806;
	Tue, 27 Jan 2026 23:21:27 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk7088d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 23:21:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXx7w91JX5BcXCCBksaBAvZMkBp2JDpVrLK12sRgWL5MYQxrhGUqN8zjShaOxWZBDihTQo0ddUWXJ4fgI5TiGiQwQ2QxZeNnw4vgKNJptUB/dzVNqfeQRz4NLO0CYUbGA/UtVqaYvDR3TGEp8CkYZFj0k0fBQtH9w7xxR6qNqjPCARL3H6pLXv6EAh6iZYV96TzIsWbbJmYyw3TITZrtoZL8MjQ0ZBO/1k9C2YjVqIPph1HCMlK3f2+f1yengSvrwrCuVHUK0iBhouqXN5zeOFpxNaky9EXTBU5UN4KLLFB+VBDlGicLqS0r5PlsITIZgNZVli0Jb5M56TmEr3GxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MQ6AfoVVcd4gNQ5gB7A2qsQ41f4adgrUw8W26RcgdA=;
 b=P549UIVfkzQYp9I2yyDzBm4EnpZby3s5H6Lvtip4VpOhsGEQ9J7qEAwu9WdO/1sL164VJ1YOFFkqtqmZ78wJHGCbILYoiBLcDqTKDJpq+T0BjgfsBP85lY7vzX5DfGysq56U1yaVlyHHqGHM6X599gGIT8jtqvx6rsQubvOS82ePnec0TGgbA3ixBWHfmyXkMf2UeriV5BTfmNBeCllfqDyo4gAo5VM0pZ2nMYyW0vxE2fJZXJkhd24F6u1lKshxLh6Lvqd40xlFkbp5w3JEUkPdFJb8I+N8vqmup6ENEhUSw00E17PhbQ0vX/CXKlQHAbTO48z6tmJ4sp7p051pfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3996.namprd15.prod.outlook.com (2603:10b6:303:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 23:21:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 23:21:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index:
 AQHcip7gBQv9tICp4U+VJX3elcUj9bVdDvkAgAHwkYCAAWlAgIAAOTuAgARP5ACAAMSKAIAA+5yA
Date: Tue, 27 Jan 2026 23:21:24 +0000
Message-ID: <eac09a9664142abbc801197041d34fef44b05435.camel@ibm.com>
References: <20260120051114.1281285-1-kartikey406@gmail.com>
	 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
	 <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
	 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
	 <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
	 <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com>
	 <CADhLXY6fMO51pxc1P00F3g9PccNvXwOPd+g0FxeHq1FYGR3Xng@mail.gmail.com>
	 <31dcca48613697b220c92367723f16dad7b1b17a.camel@ibm.com>
	 <CADhLXY54yiFoqGghDQ9=p7PQXSo7caJ17pBrGS3Ck3uuRDOB5A@mail.gmail.com>
In-Reply-To:
 <CADhLXY54yiFoqGghDQ9=p7PQXSo7caJ17pBrGS3Ck3uuRDOB5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3996:EE_
x-ms-office365-filtering-correlation-id: 231a41df-6ab0-4d13-6c0d-08de5dfaca1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2FVNGxRUUs5VDN4RUxsYWY3R1VOMUF2WjNPT0FMS1dVVGpRTFJ4eFN5VlUx?=
 =?utf-8?B?TFN0V0pGaVJsenJPZWVnRlBzOVNzK3JhaGg3STJPWmRiaWhNTnVLZm1QenU1?=
 =?utf-8?B?WjRBVmhicXJoNnJaZVYwcFZuOE9SMGhKUzMyMEtqanZSZERUK3psNHFSbFVo?=
 =?utf-8?B?VXFtRStxc2FRQWc4WFIwQXNkNVgwZmFKWStQK05MNkdOWmhHdDlDc0YxSWlu?=
 =?utf-8?B?R2ZLVm9Lc3JZVmo0U3JOeG8wMlVUYlpsMnpWNG5IdXlrSS9kTEovRHhnN2w4?=
 =?utf-8?B?Vk4vS2N2SDJXbnBCY1FBd2VnTkxxTXkzM0JKS0pncUpiY3c3b1N1UlNKZURE?=
 =?utf-8?B?SVBHd1ZoYWd1K3ZEcUl6RkJTcTgyc2VRR2hMRGhONkQvaERnNjdING42N0lu?=
 =?utf-8?B?Wm5BN3djdTd4T2N4bWZqcFFITUdEa3ZmZFBBSFJXaGtQcG9kcUdER1BPeTgx?=
 =?utf-8?B?Ulo4bWl3STA5MWlsYXorUFNtb0dwbi9PcHh1K3lKM25EWFdyVGdmY3BqenVG?=
 =?utf-8?B?WVR4cDlkQzlZbGlYL0lQdnNGazdqU3BIWDQvenlZOXhFNElOTGFqQm9OZmxp?=
 =?utf-8?B?RVNqS2doZDJOekNwYzdjVDlrN1JZWDIrVDNiVnJaQXM4eGVWZXJrSy9Db0cw?=
 =?utf-8?B?OVpCRVFSYStnT1pybDFOMVVIaWdtN2s4ZGxNV2luVWwxaDhCbExmdzdmR1dq?=
 =?utf-8?B?Q1RrUW1GZVMvcUxBcnY3LzFPdlJoNXhiQVpNZjB3d09QWEpQWnBpb1l4bFpw?=
 =?utf-8?B?VUM0bHJDMklPMk1LVDhyeVNQMnQ2R3BJN3JFQm9wYndiY0RkMjhvNTlxdTZX?=
 =?utf-8?B?YVV6cExmYTNoVWgwbU0rSjV6emZFa0JpMVVWOUIzUExZQ2dTTmJPZjY0WFE3?=
 =?utf-8?B?dFREaTB0N096dHpJa25ZbjZ5MW9vRnYybU9QWHVZZmdIbzdrelEwOXBueGlF?=
 =?utf-8?B?RmJYckltMXh5UTB5N0NienZYRVI1Z01yQmR5MGxmUXBIamxCbmYvNEFyZFdN?=
 =?utf-8?B?WU9hSE9RZU1vL2pWTTZFamRQODE2NkNnY1NBNU9iRnBwL1o5OVczWXREYmZx?=
 =?utf-8?B?QWtqaWo1VW5MMEgzUXhPZ1F2VG1ZN3lVcHRHMmZRaDJ2TlQzRHZLaGRjUmE5?=
 =?utf-8?B?RG03ZGJ4cThrVTRBWDBLQURwMVQ5VjRtMTgrMWFQOURJS2E1RmNWRys4THE2?=
 =?utf-8?B?SWpjejV6YjFuZkIwL0xmcEZLcFZ2TUpoQU1QS0NaMTRCQUtIN1RjN3Q0NHNw?=
 =?utf-8?B?K29lL2VTVHN4cXhPcVNtWlhueWNKUjBLdVJoeHMwbEp4bzJCTU5wUVFIcGYr?=
 =?utf-8?B?WWVoMWQ0dDM1NHQ1dUJrVTZ2RXhZd3NlcnNzZ2VkOGhwM1RWT25XNSs1MTk5?=
 =?utf-8?B?eWxDeDBKNWhma2xhZjhoTC9VZG52dXd0L0wwU2Z1WmpKRnZZNlpGWVNXWGJK?=
 =?utf-8?B?ZWE4YjNtQnR5dkdPR1Q5VVQ5eml6TDhjOVg2QTV4ZkhIZkZjUEhpaDVXcjRD?=
 =?utf-8?B?eW5jbHRCcWFlREtJR1liekpsK3pmQ1pJUEVDc2FkVTNsRC9pUTVGOGh3MFpu?=
 =?utf-8?B?c3FjR2FUV2diR0ljbVAweURCcnFLUlRkSzE4V0ZhenR0VWx4eGJ5Y2JyOHBu?=
 =?utf-8?B?KzRkY0dkM3ZjdW1jZDFOeTNuNTQxTVFqZWZxZGhRWmI3a1l2akZwQVNyT25U?=
 =?utf-8?B?dUNYKytkNGpYV0UrSEkvQXh4N0RIOGNpdHpWUTY4am9KRGJTNXRRTVBsTFRX?=
 =?utf-8?B?TXpJRUQ5ZVFaTEFYNFJtU216K1NDa21JcUJJQk16cG1aQWhzYldVTzJEYXR6?=
 =?utf-8?B?c2RkVEZpZEFweSt6MFVMVW9rMGF1SkF4cTd2V3o5RTFmSUNscXI4MHQwWmYx?=
 =?utf-8?B?dGlMZVlnMS9TSVZLUElMV1V0U3NlU1VPcXF2L1dBZlhicnVIUVFJemZZT2lZ?=
 =?utf-8?B?dEFtVWN1anF0OE5oK2t5cVhhWm93YzhidTk4NHAvbU9aZjMrL1lGMmZ2c1VJ?=
 =?utf-8?B?eXlCcTNIcnF4VmhHT0FJVFY3UjlocGZYVS82TTI4K0txQmFLMzFPR3c0eWRm?=
 =?utf-8?B?L2dacVd1RXZONGczMWVTQnB4SjZrYnEwaklwcXNUTmFlM0dTNGRCWnRZWnlu?=
 =?utf-8?Q?caqcvLnYeF46oGI43RqeYAOU2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1VPNUVnVmdIcXMxVnR2MUwrUmJYSUpER2pnbjhJN3hQTXVxVWlxb3p2RnZZ?=
 =?utf-8?B?WWs3cm5YR0tNaTNnNW9pUGc3TUprdTc0anlBR3RBQzlLSXNmUVJLd0l0RG4r?=
 =?utf-8?B?TENlQlBuTlR5a3VOV01DaVpBUDNBdjJlQkh3MFh2OXZ1OWhJeVFha25PS2ZY?=
 =?utf-8?B?NmRZZDcxNmJyWkl2endUMlgrTEdMT0FENERYUERBajRycHF3STVRbmZXTWFt?=
 =?utf-8?B?amFaUFJMK3JvZVgxYUNDaTN5ekVxZkVHU2xLYjg0MjBsMnpnU2djTS9BMG84?=
 =?utf-8?B?T3RUNWVOZ1JjMEIySTN6ZGFYN3VOWFJNdW91Z1hpY05uZitwaGdPck5mNkps?=
 =?utf-8?B?aGlWSHFRTlkrclFqTTJnNTZOS1M3MU1GSUZQL3gzS01uUlVHaDlQNWZQdThF?=
 =?utf-8?B?T0ZFVVhuWmROUURIVUF5M3g2cW9SV3krdkVwNkVqc0FFcmtKRXZNSG8rcFZZ?=
 =?utf-8?B?R2poUGtUbm1NS3Z4YnBsWDk2U3FhMzQ2d05NNVdTcGVlK1M0N1dVZWdTeU1F?=
 =?utf-8?B?NURoRWpxTGt0MGxtVzNtSFl2Q2t0M002ZWc4bUxhV1JNOG1obzl6Q2VFSVRr?=
 =?utf-8?B?dE5MNDdaUXpPSmZSZGRSMXpaR2JqcG9nWEs3dGNUd3pleVBvdXQ3RDBNYzlj?=
 =?utf-8?B?NHdQMWhJamtkUzM2aWVmS3FEampVVkpYeGc0NXV4RktQSlhjbnB6ZDZtQnhp?=
 =?utf-8?B?NjhvckIrZ3IzZzkrMXVzZHZKQm5wNTZpSmJQdzlrdFJ6QVNMLzN0c1JQUmov?=
 =?utf-8?B?TGpGc0pDdkxoUGNKSWxSc1RYaStYbXEwbFIvQThFM3VvdEdLUitqUnhtaWtl?=
 =?utf-8?B?dWVNWnpmQldDNUxJdGlKNHp0VTRRRmw0Q01FRVBRaUZWamNLN1djQVZmblps?=
 =?utf-8?B?RVFyODBrRDBmc2k4RW1PdjJoR1lmRWp2R3k1U3dZNW4zOWo5djNQVUhRTnM0?=
 =?utf-8?B?Vi9tcHRhVGZFRDJzb3RKdlJsU1pZYWo0NWdVYWlwVjdCZ2RHNHhaWjdSZGtz?=
 =?utf-8?B?MGpxVmpMNGtpUy9GNXdsa01EYnRtWTMwNG8vSVdXMTFXTmZYeUdCK2lVbHFJ?=
 =?utf-8?B?S2JMZGp1QVdxSmdPSE83WEdIWksyQmZpTlFnNWJudmxvc3JkenhFZWdkVFBR?=
 =?utf-8?B?djJjUnlOVW4xTWNrdTZ2RjZpQ2ZmTWxjOElsazlzakJQajZhbkgxeXFNWUhy?=
 =?utf-8?B?dVd1aHBtOXRJblI4eEdUTDdzcXloTXk0ZHRnNTJHS1hhbXpqYjJKV3VKNW5E?=
 =?utf-8?B?TXlKeEdKVFQ2aE9MM3NYQUpwanNjbFJqb2l1bFZ0UjMvTDV5SXZrR2szZWts?=
 =?utf-8?B?VXU5TjJXZzNHbXlYMnJsTWZSS1MvNytGVVF5NjFUOURMMWtJSC94QmxLRkFF?=
 =?utf-8?B?RVRaV2xIbFlueTRYL1J1V3lsbnhIUThseHE5N0dWNWpPKzFGM3JjZ0JHUWYx?=
 =?utf-8?B?RGxyUHRPVTZHMlJuSEpjR0dFbU5aSWVMK21kUmFDenloSkY0eVZGZ2U2QWRk?=
 =?utf-8?B?VDd1UlJoQU5LQklHTDZ0WGpPeDRtVkhFVFRzby9JVkRyYjBYS0o0S1lFQ0pu?=
 =?utf-8?B?bEt5Ri80c0ZIM0tXQkRnbmoyWU45ajUxL0Z6Q0prTWFCTHV0cVNVbXlDWU5v?=
 =?utf-8?B?NURBbm9rZVdibkZXKzRGbDBDWFRHbTNoeStId3dMWUJndTBBc0RZUEp5SnhM?=
 =?utf-8?B?dzAwVlVNYnZtOUhmWW43elZUZzRVQWp6UXd0OXFHdjRmeWNZbitpOXZsMnpo?=
 =?utf-8?B?ZFpjMGdqRTl6RXJ5bXV4bUZ6RmtMdW1uTHJFVWtLalBKRnlrdXdxaVNIYlBQ?=
 =?utf-8?B?ZkRnM0FDcDgvdkNaTS90bGx6TmdjcU1OL3JDZ3N2dktqNWhPQ2l5QVN0UFJN?=
 =?utf-8?B?OFUvaysvU0dxRi9peHd1SUtsc1JURytuazBwRm93ZzNWMEpFVVJhaW96U2Fk?=
 =?utf-8?B?WjM2UURIek5pQmh4TEZVZ1dINnk3QUlpdURtWkxwSmU4clFwdzA1aG1GdTBE?=
 =?utf-8?B?Rk5YR25kOHJ0YlJHYUp5YVlHTXVlbUlPcEQrZFBkdjJyYWhWN2t3TnZYcmFq?=
 =?utf-8?B?WUJ4ODVUWWVFdlpWbVhOL0lySHN3QVNVZnoxOHBZY2JUTmlaLzM0N1R2Wi9j?=
 =?utf-8?B?ek9hdmpUbWtWMituT3JuZk5ZcG5MODZsU0pLTlZtRExlTU4yZkxoUkVWUThw?=
 =?utf-8?B?cUw0UzN4L2grVTdodWRraCtNbUpLTnpENHVwNzdCcVByYXJORS9vb3B2dGdW?=
 =?utf-8?B?NFVIdk13Z2doY0lWTkxha25GOUhNb0pVcVJITkdQTzRlelVCQ3BpTmhzTkQx?=
 =?utf-8?B?WUJwWk1ZaHRFODZtVmlja01VZWZick1SM1Axb3ZkMHF6R1RrTlA5M0RvdUhL?=
 =?utf-8?Q?gvBKr/4dMQf/V2c1EApj03CHfwbEGq6y/yFc5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CADC34F119318479C86B9C4F2F59055@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 231a41df-6ab0-4d13-6c0d-08de5dfaca1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 23:21:24.7149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaOk2QAvIlRDkeFd4GlNL3HBHZ41DRfzudxRX9Gdjl2Kf+ihwpkB/E2Os38Rt/9XgRUCP8sc6TaFKRuzXXrR2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3996
X-Proofpoint-GUID: _0_unhrApwhKuPaqhXCcVei3ORSgJi7W
X-Proofpoint-ORIG-GUID: nWdvrridq_rQwMwG8Ev29yZ40bEm1Vq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE4NiBTYWx0ZWRfX4wvkEmiKMmRz
 e2yC8fePiG1yYT5zkwEn/MjEAxK2l5EhrRIciL8mMYnmrm/25qylJuDCV8jZZzTw/P5Hj1AcB9S
 2u3ksD1j4ekU2UjWRLFk1n0/SH3U1n3glb0T27AjcEh545bcdXtqKBSHFqIObgBdswYzQBvOPIa
 X9yPlTDJ6r3P+gHUqJnbrVEamQvd1FlK2xBlj2wmMsZuVrfaCfivvhMZu+NTkWODQIbR4xNDsg1
 2wJzwWu8IQUrxYw2di67xvfM1mXFA3skDfJzw9bBz5VcFdnN3UBiH/8B06V08e/y/43M3CDwEcJ
 9KY2uQxzL6rQ1z6Bsku5i8nxP+ThWQ/rTCctI0qdqgwpRbGTpK/dHkXbbKXCWh/FKwxxZIyfR3V
 gU5CkdIAH+ZL7BCi8kB00ItMuUgSgdJgJRKXedhOvVaTH79/zFGBvPS+qzdQ0pqXW2Qj43Xhge5
 zVaaqeSQl+28S21z6qA==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=69794877 cx=c_pps
 a=QnLLxHS9Rj8Jz4O0ufpOyQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=n52MfBnzP6b8ingJQxIA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
Subject: RE: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270186
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75663-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 112109B5ED
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAxLTI3IGF0IDEzOjUwICswNTMwLCBEZWVwYW5zaHUgS2FydGlrZXkgd3Jv
dGU6DQo+IE9uIFR1ZSwgSmFuIDI3LCAyMDI2IGF0IDI6MDfigK9BTSBWaWFjaGVzbGF2IER1YmV5
a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+IA0KPiANCj4gPiAN
Cj4gPiBJdCBsb29rcyBsaWtlIHdlIGNhbiBzaW1wbHkgY29tYmluZWQgdG8gY2hlY2sgaW50byBv
bmU6DQo+ID4gDQo+ID4gaWYgKGZkLT5lbnRyeWxlbmd0aCAhPSByZWNfbGVuKQ0KPiA+IA0KPiA+
IEhvd2V2ZXIsIEkgYW0gbm90IGNvbXBsZXRlbHkgc3VyZSB0aGF0IGl0J3MgY29tcGxldGVseSBj
b3JyZWN0IGZpeC4gQmVjYXVzZSwgZm9yDQo+ID4gZXhhbXBsZSwgaGZzX2NhdF9maW5kX2JyZWMo
KSB0cmllcyB0byByZWFkIGhmc19jYXRfcmVjIHVuaW9uOg0KPiA+IA0KPiA+ICAgICAgICAgaGZz
X2NhdF9idWlsZF9rZXkoc2IsIGZkLT5zZWFyY2hfa2V5LCBjbmlkLCBOVUxMKTsNCj4gPiAgICAg
ICAgIHJlcyA9IGhmc19icmVjX3JlYWQoZmQsICZyZWMsIHNpemVvZihyZWMpKTsNCj4gPiAgICAg
ICAgIGlmIChyZXMpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXM7DQo+ID4gDQo+ID4g
SXQgbWVhbnMgdGhhdCB3ZSBwcm92aWRlIHRoZSBiaWdnZXIgbGVuZ3RoIHRoYXQgaXQgaXMgcmVx
dWlyZWQgZm9yIHN0cnVjdA0KPiA+IGhmc19jYXRfZmlsZSBvciBzdHJ1Y3QgaGZzX2NhdF9kaXIu
IEl0IHNvdW5kcyB0byBtZSB0aGF0IHRoZSByZWFkaW5nIG9mIHRoZXNlDQo+ID4gcmVjb3JkcyB3
aWxsIGJlIHJlamVjdGVkLiBBbSBJIHdyb25nIGhlcmU/DQo+ID4gDQo+IA0KPiBIaSBTbGF2YSwN
Cj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrISBZb3UncmUgYWJzb2x1dGVseSByaWdo
dCAtIHVzaW5nICE9IHdvdWxkIGJyZWFrDQo+IGNhbGxlcnMgdGhhdCByZWFkIHVuaW9ucyB3aXRo
IGRpZmZlcmVudC1zaXplZCBtZW1iZXJzLg0KPiANCj4gSW5zdGVhZCBvZiB2YWxpZGF0aW5nIGlu
IGhmc19icmVjX3JlYWQoKSAod2hpY2ggaXMgZ2VuZXJpYyksIEkgc2hvdWxkIHZhbGlkYXRlDQo+
IHNwZWNpZmljYWxseSBpbiBoZnNwbHVzX2ZpbmRfY2F0KCkgd2hlcmUgd2Uga25vdyB3ZSdyZSBy
ZWFkaW5nIGEgdGhyZWFkIHJlY29yZC4NCj4gDQoNCkZpcnN0IG9mIGFsbCwgd2UgaGF2ZSBzZXZl
cmFsIHBsYWNlcyB3aGVyZSB3ZSBjYWxsIGhmc19icmVjX3JlYWQoKSBbMS0zXS4gQW5kDQphbGwg
dGhlc2UgcGxhY2VzIGRlc2VydmUgY29ycmVjdCBsb2dpYy4gU28sIEkgYW0gYWZyYWlkLCB3ZSBu
ZWVkIHRoZSBnZW5lcmljDQpzb2x1dGlvbi4NCg0KPiBIZXJlJ3MgdGhlIGNvcnJlY3RlZCBhcHBy
b2FjaDoNCj4gDQo+IC0tLQ0KPiANCj4gaW50IGhmc3BsdXNfZmluZF9jYXQoc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiwgdTMyIGNuaWQsDQo+ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBoZnNf
ZmluZF9kYXRhICpmZCkNCj4gew0KPiAgICAgICAgIGhmc3BsdXNfY2F0X2VudHJ5IHRtcCA9IHsw
fTsNCj4gICAgICAgICBpbnQgZXJyOw0KPiAgICAgICAgIHUxNiB0eXBlOw0KPiAgICAgICAgIHUz
MiBtaW5fc2l6ZTsNCj4gDQo+ICAgICAgICAgaGZzcGx1c19jYXRfYnVpbGRfa2V5X3dpdGhfY25p
ZChzYiwgZmQtPnNlYXJjaF9rZXksIGNuaWQpOw0KPiAgICAgICAgIGVyciA9IGhmc19icmVjX3Jl
YWQoZmQsICZ0bXAsIHNpemVvZihoZnNwbHVzX2NhdF9lbnRyeSkpOw0KPiAgICAgICAgIGlmIChl
cnIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiANCj4gICAgICAgICB0eXBlID0g
YmUxNl90b19jcHUodG1wLnR5cGUpOw0KPiAgICAgICAgIGlmICh0eXBlICE9IEhGU1BMVVNfRk9M
REVSX1RIUkVBRCAmJiB0eXBlICE9IEhGU1BMVVNfRklMRV9USFJFQUQpIHsNCj4gICAgICAgICAg
ICAgICAgIHByX2VycigiZm91bmQgYmFkIHRocmVhZCByZWNvcmQgaW4gY2F0YWxvZ1xuIik7DQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gICAgICAgICB9DQo+IA0KPiArKyAgICAg
IC8qIFZhbGlkYXRlIHdlIHJlYWQgYSBjb21wbGV0ZSB0aHJlYWQgcmVjb3JkICovDQo+ICsrICAg
ICAgbWluX3NpemUgPSBvZmZzZXRvZihoZnNwbHVzX2NhdF9lbnRyeSwgdGhyZWFkLm5vZGVOYW1l
KSArDQo+ICsrICAgICAgICAgICAgICAgICBvZmZzZXRvZihzdHJ1Y3QgaGZzcGx1c191bmlzdHIs
IHVuaWNvZGUpICsNCj4gKysgICAgICAgICAgICAgICAgIGJlMTZfdG9fY3B1KHRtcC50aHJlYWQu
bm9kZU5hbWUubGVuZ3RoKSAqIDI7DQoNCkZyYW5rbHkgc3BlYWtpbmcsIEkgZG9uJ3QgcXVpdGUg
Zm9sbG93IHlvdXIgbG9naWMgb2YgdGhlIGNoZWNrIGhlcmUuIENvbXBsaWNhdGVkDQpsb2dpYyBp
bnRyb2R1Y2VzIG5ldyBidWdzIGFsd2F5cy4gOikNCg0KPiArKyAgICAgIGlmIChmZC0+ZW50cnls
ZW5ndGggPCBtaW5fc2l6ZSkgew0KPiArKyAgICAgICAgICAgICAgcHJfZXJyKCJpbmNvbXBsZXRl
IHRocmVhZCByZWNvcmQgcmVhZCAoZ290ICV1LCBuZWVkICV1KVxuIiwNCj4gKysgICAgICAgICAg
ICAgICAgICAgICBmZC0+ZW50cnlsZW5ndGgsIG1pbl9zaXplKTsNCj4gKysgICAgICAgICAgICAg
IHJldHVybiAtRUlPOw0KPiArKyAgICAgIH0NCj4gDQo+ICAgICAgICAgaWYgKGJlMTZfdG9fY3B1
KHRtcC50aHJlYWQubm9kZU5hbWUubGVuZ3RoKSA+IDI1NSkgew0KPiAgICAgICAgICAgICAgICAg
cHJfZXJyKCJjYXRhbG9nIG5hbWUgbGVuZ3RoIGNvcnJ1cHRlZFxuIik7DQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTzsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGhmc3BsdXNfY2F0
X2J1aWxkX2tleV91bmkoZmQtPnNlYXJjaF9rZXksDQo+ICAgICAgICAgICAgICAgICBiZTMyX3Rv
X2NwdSh0bXAudGhyZWFkLnBhcmVudElEKSwNCj4gICAgICAgICAgICAgICAgICZ0bXAudGhyZWFk
Lm5vZGVOYW1lKTsNCj4gICAgICAgICByZXR1cm4gaGZzX2JyZWNfZmluZChmZCwgaGZzX2ZpbmRf
cmVjX2J5X2tleSk7DQo+IH0NCj4gDQo+IC0tLQ0KPiANCj4gVGhpcyB3YXk6DQo+IDEuIGhmc19i
cmVjX3JlYWQoKSByZW1haW5zIGdlbmVyaWMgKGRvZXNuJ3QgYnJlYWsgb3RoZXIgY2FsbGVycykN
Cj4gMi4gV2UgdmFsaWRhdGUgc3BlY2lmaWNhbGx5IGZvciB0aHJlYWQgcmVjb3JkcyB3aGVyZSB3
ZSBrbm93IHRoZQ0KPiBleHBlY3RlZCBzdHJ1Y3R1cmUNCj4gMy4gV2UgY2FsY3VsYXRlIG1pbmlt
dW0gcmVxdWlyZWQgc2l6ZSBiYXNlZCBvbiB0aGUgc3RyaW5nIGxlbmd0aCB0aGUNCj4gcmVjb3Jk
IGNsYWltcw0KPiA0LiBXZSBpbml0aWFsaXplIHRtcCA9IHswfSBhcyBkZWZlbnNpdmUgcHJvZ3Jh
bW1pbmcNCj4gDQo+IERvZXMgdGhpcyBsb29rIGNvcnJlY3Q/DQo+IA0KPiANCg0KQXMgZmFyIGFz
IEkgY2FuIHNlZSwgaGZzX2JyZWNfcmVhZCgpIG1vc3RseSB1c2VkIGZvciBvcGVyYXRpb25zIHdp
dGggQ2F0YWxvZw0KRmlsZS4gQW5kIHdlIGFsd2F5cyByZWFkIGhmc3BsdXNfY2F0X2VudHJ5IHVu
aW9uLiBBbmQgeW91IGNhbiBzZWUgdGhhdCBpdCBzdGFydHMNCmZyb20gdHlwZSBmaWVsZC4gDQoN
CnR5cGVkZWYgdW5pb24gew0KCV9fYmUxNiB0eXBlOw0KCXN0cnVjdCBoZnNwbHVzX2NhdF9mb2xk
ZXIgZm9sZGVyOw0KCXN0cnVjdCBoZnNwbHVzX2NhdF9maWxlIGZpbGU7DQoJc3RydWN0IGhmc3Bs
dXNfY2F0X3RocmVhZCB0aHJlYWQ7DQp9IF9fcGFja2VkIGhmc3BsdXNfY2F0X2VudHJ5Ow0KDQpT
bywgeW91IGNhbiB1c2UgdGhpcyBmaWVsZCB0byBtYWtlIGEgZGVjaXNpb24gd2hpY2ggdHlwZSBv
ZiByZWNvcmQgaXMgdW5kZXINCmNoZWNrLiBTbywgSSB0aGluayB3ZSBuZWVkIHRvIGltcGxlbWVu
dCBnZW5lcmljIGxvZ2ljLCBhbnl3YXkuDQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTktcmM1L3NvdXJjZS9mcy9oZnNwbHVzL3N1
cGVyLmMjTDU3MA0KWzJdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5LXJj
NS9zb3VyY2UvZnMvaGZzcGx1cy9kaXIuYyNMNTINClszXSBodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC92Ni4xOS1yYzUvc291cmNlL2ZzL2hmc3BsdXMvY2F0YWxvZy5jI0wyMDINCg==

