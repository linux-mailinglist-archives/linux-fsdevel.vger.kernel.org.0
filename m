Return-Path: <linux-fsdevel+bounces-76450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMZ8A0GbhGmh3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:29:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C6F3423
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7412A300B19A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F63D7D78;
	Thu,  5 Feb 2026 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="N07nRev6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022117.outbound.protection.outlook.com [52.101.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C91F63CD;
	Thu,  5 Feb 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298165; cv=fail; b=ULc2sV7HbmqeIJxqTUTT4fJKftXn0gvn5yjkPbch6v9029Uq1ifPh6odXuQGhjzs5105on3RTlVC88+Tv3Jbc6vI2BOuxFrbegYkvM5rhb5ZYKWHypofGTA9MbGCiDm3ZcPLq/Ddw0xY7fVxGAHqBNYU+2+JdtLysUYQnzvMdIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298165; c=relaxed/simple;
	bh=sAiWjQOuErn/ACd2NqScFH9zHxV+V9/QCEpf77e9vjw=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=nYbcgrEcRERQdlYEpjGXf/EFVEiOfMm6hKzQtG4u6XeVk9x1mwjAdmWkHoRVcDCXIymPpdx9ffnGPwyw5XX6fILO6Z7PZJTNVgu7bAM89VVedOh0sJv3Y+W9wCUMeBTpVwdhgQTm0g3yEoy0Tj8t8kkvKcIomUeF6UzOJyO/Uhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=N07nRev6; arc=fail smtp.client-ip=52.101.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smtuzSasVWMuloYktOLbFhDE3NhmehGEk5BkaswkrLzXz68M9oJ6tD3+43LWO1dvy2GKCsD6GcmC95lm8NAVkmXpzneUETqDyMsgeYUTmkiyyDlzgkgZSxfpLSQjh7NZMZnAsVaqqjymSTClcnFuz5fZJXCU/bmDxq8vCs21uBzOZSDQvIA8bDZMyC2YiZSuBy982s5PXpW5n/PylS3gnnxUs8qHyFijMgJVC2+eI0jT3+8G+LTAmGgKWJkQolN2ak3XD5m1OUx9XbLb3lF/KMS26XMIrZBcaw1mO9IHToxEPkG1j5aLIvGTBwbdA5lv47ON2jqo5+dymfGNkMGBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM7h6TDaVhvSa64ov5YSSwaylLDR6nBkf9jlzlUZFso=;
 b=SUz74P2JH3YyrQa2WFAiFxlrQsbCx6FW0REOf+RirTJD7XqGrbHZZAel1sk0OXSlvgmY/xfeXInkKzppB4VoxSJNARQ32UEk/gJkM6XO2vgUjtFx0Lt9MgLa5+Iw3ONJaDR1SX7Y3MNlpb365Xeu2Zr8I4tZVsBInxiAw4lRVJLqTOeWTPCw+ZnwhugrQnfqrIMQsmTEhfTQFnf8/YH4kfNsR7JDwImtvt8qYO1fhnIIqdpkMUmfldQ/Y/DcdVOadaQXQ/RGPpuVodGI+fC9RbH/r8qqSbz7aof93chVpKudaQR1Fyzwb8GSwCIxbjaq3r+qM8DtsB2o711gFDnIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM7h6TDaVhvSa64ov5YSSwaylLDR6nBkf9jlzlUZFso=;
 b=N07nRev6e4W2iS38vBur2Lr+JT3vUTYrvBu5s/QbkteoAUHlA++wgRh9qeW8wDy/37JJB4QrV4GPmjWtz5aOiFJkVBChZ+m5Azvoe880n8knXacGW11LWKrUoRGvNsHM+AeLt4wwiqrMr00I5uiths0zjOAM1XX/IDItVsKYrxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6154.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 13:29:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:29:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 13:29:16 +0000
Message-Id: <DG72BM2I3QKI.1SCBV7WL5B1TG@garyguo.net>
Subject: Re: [PATCH v14 1/9] rust: types: Add Ownable/Owned types
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Igor Korotin" <igor.korotin.linux@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Asahi Lina" <lina+kernel@asahilina.net>
X-Mailer: aerc 0.21.0
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-1-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-1-17cb29ebacbb@kernel.org>
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 975ef89d-3cce-4e35-7232-08de64ba9026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWN0VUgxYlJnVlBKUlBpRTN0MVdHUnJkR2xHdnpxd1FGNXVQM1dtM3RFTFRu?=
 =?utf-8?B?QnZLY21xV2dXaTR0MXFlOTJKZk5kcnk5bkNKTlpiYnFzTU5Gc29ickhxQ042?=
 =?utf-8?B?eWw5bGVxZU5JazFiWU5LeThsSVBXUjA2UlQyWktRdGt5dFdVNHRSVHc2Undk?=
 =?utf-8?B?MElvcGlSMCswMVcxdVA4bFRYWnFGMVR4M3VOOWc3K0gvTHVWUm5sWVJjYzdu?=
 =?utf-8?B?NjBYUHBlL2VNU0VZOGVzNDJDSFZpbEh3YjU0aTl4ZGpHSFlYbDZQNDI4ckw5?=
 =?utf-8?B?VXR3UjRKeW9ENVpUT3lqRjE1V1ZyS0NtL2k5ME91bDZLU0FjMG5oRmp5M1pC?=
 =?utf-8?B?b3ZIQXV5RDBOQm9YaHpaUng0ejBIbFl0Rm9mOURQdkd3dzNhL2N5bnpuTmZR?=
 =?utf-8?B?MFM4dlRCa2JxUlpMVlRnV1hTM2ZsMUIxQjVaL3VBNFE4Q1V4TXNYdzFuUUg1?=
 =?utf-8?B?VjF1bjdNbEg1ay9JUEMxT0poTk4rMlN0OGsxaTkraTMzeEdxVVJGL3BuTVRS?=
 =?utf-8?B?N0VIMUlnYXhqc2xCT1hWYU5adk9zUXF2Q05VLzNJeVZuU0tCaFdNbGM2RXZH?=
 =?utf-8?B?TkxMSzVYUHlDTkxFV3JDZkFYZkhFSkd6cTcwZm9XbVhyeFBFUzdXSW1aMDR4?=
 =?utf-8?B?NHRIT1MrdHZ2bWovdWhOeHNkYlNqUTIxclVTSnhsVXBaTjU2S0JIbGNLZnZq?=
 =?utf-8?B?R2g5MmI5ZGF0dThoZGNwSFdrajdLTWFEOGxETHdodjBvZzlvOXlRS3NHdG9z?=
 =?utf-8?B?cWhvL0lUUmlHSTF6ZjhibnBudVp6R1N0M1Z4UnlkbmVGN3NObnhVbit1eXlW?=
 =?utf-8?B?WStld3pKYmpHbHpSTmFYRDJvNjFEL010QTFVcHRHRjZKc21OMU5tZ1VRRlVn?=
 =?utf-8?B?VE1Jalh4UnVNR09DQ1krZXl6bXAybVp2SEtoVTlRVi9FVDFNTEpTSExmMzZW?=
 =?utf-8?B?Qk1nYWlOcXEwSG1sdWtKOEs3d2VFc0RyWGpINXNsOHNHSEgxQTQ3c2tDL0No?=
 =?utf-8?B?QUlsbHo4N25JbUtQUkhkZ3ZOSUJ4TGFyenptVDQrN1B3UkNhVlNhQS9NRCsr?=
 =?utf-8?B?cHR3Y0hrMkJJb0F6aGh5ZFc2QWNqOC9nNWcvb21uU0VjOEYrV0hIRkdwTXhq?=
 =?utf-8?B?a3hmc0dKeW9TdUt1dVo2am0wZDVGUG9HWC9naFlQZk12MHBubXFKVktFS0ZE?=
 =?utf-8?B?RXViUFZwbmVPRWtKWjU5OFZWQ2Rtblg4K1pSOVlOTlpsQThRbWRwNUZTWXZS?=
 =?utf-8?B?VUI3c3FDaDl1a2tCczR5OHJtTmZzWWNGL2tGaXlmV2VHVXVLVkFxc0k4Vlps?=
 =?utf-8?B?QmZzZkk3YittUThSNW5GUjBPQU5NS2haV3NCTFJ0djgrZFBQR01VMHZvekx6?=
 =?utf-8?B?UVJEaDVLSFBaSEZmaHVPYjRTV3U1TmF2SE42Q3R4WHhZUm5JOFUyK0dOT1NG?=
 =?utf-8?B?d2RqSzZua2xYb05pK2k1TW1rYmJRYmhHZTlsNk9YWHIrMUM4MHZnSWpTVWtH?=
 =?utf-8?B?cUZ5OUE1OUNnZlFtZUlRejROMW9GU2VEZVJJMXFHWUdicDYwU1pRcWFNc1Iw?=
 =?utf-8?B?blhGMFJUWnNqQmRTelN4TEU2cG52U1NNWk5YZlFsOG1MTy96UDRmc1QwcVVN?=
 =?utf-8?B?UXhSMUpsRHZ5WnpndDZqai9GR1FGK3YyaWE3RUk4eEcyWWR4dFdBZFpCUndz?=
 =?utf-8?B?RzVJQ2FST2lXc2VtWC9XUE1zUWErRWlwNHVidnFocUd3dmRRL1dqRElNMWNB?=
 =?utf-8?B?REFuZ3FiS2E2TWtpSXB4QjJGQTJNTnNGazA2R2ptcnZxUFJSeUp2RVFiT2pK?=
 =?utf-8?B?cEdMQ2JDWUFJaTdDaEZBQmpBRmJ5N2lBMTlKbmJMYWJ0QzBzWEpWWTZSVWc5?=
 =?utf-8?B?RTNiaGsrSmU1Y2doZFJ6SXFEdVI1bS9LUEQ3ZEVRL2hJOW12ZHMvYTdGam1U?=
 =?utf-8?B?UlBneWpTQ2IxQThEaXdHQ3FDZFNPOGs5SnJUYXg1YWZzWDlVN0VvblEzWWRt?=
 =?utf-8?B?bXd3ZVFOTlV1Mkx6c0x0b0hkdy9QM2FBa1dNdDZhQzdJbTVDSldoMEg0REdI?=
 =?utf-8?B?bHZnMUpOa3gxWWZ5WFNWK2d5RVhaODlXK3cwT09DWTJnWW5zT2h1c0FsS2FE?=
 =?utf-8?B?d3ZNblFjYjVLOHR5cEdzRkpLTzh1Lzl2ZXE2b1MzYWhRbUlVR2FtRS9pZ3Yz?=
 =?utf-8?B?cXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDdJRGtYbHM4MVA5cUZtUzFEb1Y4dEdWOU5JMXJIYUNxaFhBU3RoNy9uREVJ?=
 =?utf-8?B?ZURrT3Zyd2JoMTdsVzd2ZWNlZmdmR0RhQWlhL3doVC85bnZkb1AxTmx2SE5k?=
 =?utf-8?B?VGdaWXpnV1VxS3NGWE1qRWlBSlZERlVpZnE5RnJuUzhtQ1VoNWdmMVlBWDR4?=
 =?utf-8?B?S1o2QkxFZGRFUEUveCs1OE1HNmlvbEllNVd0Und4ZWhwdlFtWEdOMGxxRVFE?=
 =?utf-8?B?MTUrdk4vY0IvMnRZWkdONDZKajgzcXRDWTB2ZG5LMVp6dW9pbG9STzBITWJJ?=
 =?utf-8?B?T1paVGEvVVdyVWFWdzh4VDZzdDIxVGRaVVowU2ZjTk5NQmFUNDdTVkRqTFR3?=
 =?utf-8?B?Y2xLZlZ0TnZlSVVrVUVQMmFubjM2bEhmQ21mYW1tWngxVXFuZmtqR2d2ZWxv?=
 =?utf-8?B?M1I2MDZxSWpuZWFYQ2V4WlZmSitEaXNaNy8xRmFHdEhyUlZoVVRpUGZ2emJa?=
 =?utf-8?B?VFNkZ3ozd2ZEdWNlVVJBZDdZTU1ObHVmQSs0eU1TOElrYkFoTGN6Mk5WSmtj?=
 =?utf-8?B?Q0VWRG4rUlVZUmQ0QU5FM0dhbDV4TUtZOURlNmVRQ0txM0k2b0RWNjJKTlpa?=
 =?utf-8?B?aHl0NnFnUXRGbktzcTNCak9YcmM0Q3lvSHJ3NHFIUVQrME1ZWmNtNXpNVllV?=
 =?utf-8?B?aEc3ZmlQQk9ZMkV3cGV5M3pVSG5GMllERHNwRWNBOUtzTTZOODlwMUdIcDlq?=
 =?utf-8?B?dENlRTQzZFZTZktHUVlUSE4yQWF6TE1DaTNHaGpwR2R0Y2s0V1hQR3dna2VW?=
 =?utf-8?B?aks4VVdUTEpSVlhCUFNNWkZYRGtjWFFJb09NeTdqbENiclkzMER2b0dSUVhl?=
 =?utf-8?B?Sys3TnFsbCtqQ3BjNC9YL2daczYvQ0tiTCtOSDUwOXNrZDk3eit1a0pGN1Bx?=
 =?utf-8?B?STJmN0NjZzV5V20vbkV5YlRFU0d0QUk4U2hCVjErckI3Vm9Rb2xmcE1lSlR1?=
 =?utf-8?B?MWd4aTNrZ2dxWWxiT2l2eXZiZzRITGR5SUpYY0FFQ2J5dFREY2tKM0ZnMDJo?=
 =?utf-8?B?dmpvL2VQMlVyWlhTSEZxd2N0dXNmR09XNXRqQ0FXNTVQRnlZY1B5N29WQWVq?=
 =?utf-8?B?SUNYUDNKQTAzN1EvMXRxS2xzMERzWEtJc0tDeFBobGtISWU2S1RBWS9LZ2FM?=
 =?utf-8?B?TFNTN1BxSWVmWWlGTkJlb1c0dDhaejJOTHdCVHpnbjh1dS8wRGRMRGxGdUww?=
 =?utf-8?B?dWVXeDNrWDNWSTJLeXhCa250Wm5kNWsrTFhiV0VqSlljOTdPMmV1eUlYbEJC?=
 =?utf-8?B?MnBsZFRhWlk4SHVZb3dEbDUrbFYvRFNwOS8wK1h0SkRuTDZzSlRCSlkyTFpQ?=
 =?utf-8?B?NnNNeE4yMzNmN2dTUTl2SS9YK0hzWUFueFpOcnY5Y3Y0c0tuN3hiTGVGSUFl?=
 =?utf-8?B?d1FCekxiTmVxcXVHbHErdXJEVDRtN211MW1ndzVOWVlRM1gwZUxHN0JtNUpv?=
 =?utf-8?B?SkRLblgyNnk3WUtFd2gzNTRxUnhXN2lWUjcydTliWlZ3b0xmRGI3aFhON0pK?=
 =?utf-8?B?dWZ0bnNRUWZxekxKNWZYYWVLTU8rdGNsck9ETE9TSGo3ckVQeXYxeTN0d3gy?=
 =?utf-8?B?QlRTK01UaFZHeS92SDR5blVwd0Rhc2ZLYU9tUmhYY1ZRRlVKbjc3NjNDeE45?=
 =?utf-8?B?UVU5SlgrelJhWi9STlpRbm1GSWpkV2cwL3c0Z1VYdjc4bnM3anhNa0V5OVlF?=
 =?utf-8?B?TkNnN0paR1kvZHd5ek5qM2RjUE5pbCtuOE0zWG5lUjdCcmZlWlhqMTFiK3pO?=
 =?utf-8?B?dHZlYzJRdTNTSGkwcmsvR0xKTjc0c3IwSnNrOUhFM2E1VHVnR0doNk5icCtS?=
 =?utf-8?B?bDRNQ3ZMQk5ib0JSaWIyOUFmSUV6eVpjWU9wcXJtcG1idFY3WnZ0MGFTZXhU?=
 =?utf-8?B?bmVjc3ZFN1pVeUtNQ0lmcFNLUGtERmsrT0Y0bnR3b3VQN1FxblR2bmMydFpG?=
 =?utf-8?B?ZGF1R0pMTEptOXVtNlR0SE5ibVNKdlZVQTJ5ZDV0bk15SUV1WFhhNzVSd1hN?=
 =?utf-8?B?RGphSHpJT2lyc1RpUUhTbUNJaHZUZzFzd1hDWGM3OUlZMU9ROVhyOWdaTnNX?=
 =?utf-8?B?UHBZTFg5VkJtVlEyTnVvUGVBaXV2ZEQrT2l6SVFkZC96ZmZnVXNQZFNJOXI0?=
 =?utf-8?B?ZDJ6Q1Y5Z1R1bkl2eFFaeWxOOWtSSS9qUlljZGpwSUtld0N3TGJkbXNHbFYw?=
 =?utf-8?B?R3lVZnlhRGVCMno3QWNuY1lwMkpNVjdGRUtDSTh5aldBYytTVGF1T2c4Zyti?=
 =?utf-8?B?bXdVRHI0WGRSK0pkbzJsemRoTVBuZFI5OXFkWE91UGZ3R3c5YmpZV3R6N25z?=
 =?utf-8?Q?xtSONwYeuF6XQhCYQU?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 975ef89d-3cce-4e35-7232-08de64ba9026
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:29:17.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bZy44iNRSYVdI0vSTXqe23t6eDGqMbVhBymOP43dZ5aj11dmR/Cwtu5hLwd8Od7JU9GQxYUe+ZoUvkIG83YtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76450-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AD5C6F3423
X-Rspamd-Action: no action

On Wed Feb 4, 2026 at 11:56 AM GMT, Andreas Hindborg wrote:
> From: Asahi Lina <lina+kernel@asahilina.net>
>
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unli=
ke
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>
> This change is a derived work based on work by Asahi Lina
> <lina+kernel@asahilina.net> [1] and Oliver Mangold <oliver.mangold@pm.me>=
.
>
> Link: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-1-e317=
0d7fe55e@asahilina.net/ [1]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/lib.rs       |   1 +
>  rust/kernel/owned.rs     | 196 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/sync/aref.rs |   5 ++
>  rust/kernel/types.rs     |  11 ++-
>  4 files changed, 212 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f812cf1200428..96a3fadc3377a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -119,6 +119,7 @@
>  pub mod of;
>  #[cfg(CONFIG_PM_OPP)]
>  pub mod opp;
> +pub mod owned;
>  pub mod page;
>  #[cfg(CONFIG_PCI)]
>  pub mod pci;
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 0000000000000..fe30580331df9
> --- /dev/null
> +++ b/rust/kernel/owned.rs
> <snip>
> +
> +    /// Get a pinned mutable reference to the data owned by this `Owned<=
T>`.
> +    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
> +        // SAFETY: The type invariants guarantee that the object is vali=
d, and that we can safely
> +        // return a mutable reference to it.
> +        let unpinned =3D unsafe { self.ptr.as_mut() };
> +
> +        // SAFETY: We never hand out unpinned mutable references to the =
data in
> +        // `Self`, unless the contained type is `Unpin`.
> +        unsafe { Pin::new_unchecked(unpinned) }
> +    }

Probably should be name `as_pin_mut` instead.

With name changed and SOB fixed:

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> +}
> +
> +// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the=
 underlying `T` is [`Send`],
> +// because of the ownership invariant. Sending an [`Owned<T>`] is equiva=
lent to sending the `T`.
> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> +
> +// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the u=
nderlying `T` is [`Sync`],
> +// because of the ownership invariant. Sending an [`&Owned<T>`] is equiv=
alent to sending the `&T`.
> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
> +

