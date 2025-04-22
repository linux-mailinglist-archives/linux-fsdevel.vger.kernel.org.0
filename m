Return-Path: <linux-fsdevel+bounces-46932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E404EA96998
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B983D189E1B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481E283CB7;
	Tue, 22 Apr 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A33wdfLE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jC1fjq0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBB27CCF6;
	Tue, 22 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324932; cv=fail; b=HOIsiMnUhNTN6hVFiIfm5juWGMHAFvR+Mm+bK7UzZT5IEkAvmW2+PxhtecQLtd+x3qkap7jclhUrlLq/b0iWf04XdTKa/1HuWGuxLWdWUWNI8ncQYT4BXIzdC8QL+qE/s1sFe6RpcO+9lW48LFJWl4d3qXTrzzjRD4NSDXwZayw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324932; c=relaxed/simple;
	bh=XwarE5lozIuD/DoeA3qDqC0eBa2mHAhvraQvBi8WVB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfIxm3M7BJSI888C5HprA/QN9hNGfs17zzpwqCMOopVZ4pa4GMQp7Rtfxh2Z2uZ57uKCU9kXTvIm6sCk0taZTQRgQ/SPolGSgEjwEdjjz0JNAbS/TVV3+DMV3t+L20cjeC/KwkFVsOD8nhDnT8lc7l3wfP8uBz/XPuTV1wndHqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A33wdfLE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jC1fjq0W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3W0k020939;
	Tue, 22 Apr 2025 12:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5Jrk5rO0oKL5JqCtDI8hF+s7OWc6MOeUBncPCr3djAM=; b=
	A33wdfLEIUhjc4pvj88F/vRdpYH4OFqxG57v1G6uxIz6KxUwzrqzaQNC+no+RYTX
	b2XEiYdZJmNEHwXmHu4AeNUq8vYL4eGWf5D7lZ36unUVDnMdjwqdFMvwtlr4XBHw
	CX8yWjZ4IsBDEkQdkFxlT++DVz8FBoUwubyGflJzwjwkxYzYidxXhA0WTaYrDlhU
	HUplpRrBafNptzJ+kPtcvbX6bAL23mIOiEPxWuqqgj5iQLp6ti1og03xv/oI/mys
	9WLvnjelqJpvUJCQLfUBOPmmoo7bapAa58OER7OxpXssQqnVVOYxlLdYOcLFpBCh
	ttfO5SOjeAqFbhJUlrqQjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642race1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MCE6Df010223;
	Tue, 22 Apr 2025 12:28:33 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464299tb5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXcuaAQ2W9S/b/oWih/NUsy677JMzdmz36+egZhL+Tgopb3DPmdPS9/m7fZojxVzrUDGdHzqADDgKkhdbJQGNQJl2bFsYUiwWjq/S/pB6SXVKEPRirDc2Kgc2n0kxwPYbnFi0LmAndxi8rMsrT/AZDh/Hwi6JqdcH0rr7wdCj38PeRjgL5NIiY4qOZUIVldVEHI/zVwx1GBwMivi9IRH5UoTJSa/p17Tccoo46s7H6PzrfLhWQI0rPf2/TR/yo8GrKfMqkhXtd7nkQIEroTz6qWY76qtV9TxSwAxFmt0rNl9/ZeeUAd98IKl7nmzE0NQfN2F7mnT+XtWXw4hiHszSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jrk5rO0oKL5JqCtDI8hF+s7OWc6MOeUBncPCr3djAM=;
 b=Gb0ceNDqcYb/ijfN10Xrkircz4ICldDxKXeP3CNye6uuSDul3I15SSPXDhS3y/JMQpqhpjBTv3etmG3Qll7p3qVOGISnJrWqdoRNpdgZHRe2ZFeYsKNs/+vxXYgBAaamkJ82hs75J3AXSiQCszPg24OFmZTLDcCzyVYz/6WM24EBEpKW20OyZv5ICLUVf4dECCYcHTw7UagCc7E1Ex2MuFNYqNOH+scY6VmLGA5FSbMroTzPoJNVz8o7lUnUgpGYm2bTffG2SaOOhcsDXvlp7LnKtZMdKiCNVNMS2fvMlX0ijVU5amQYv2+Z7gTwRwnBdy7fv7m54aBnVgIEG8xRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jrk5rO0oKL5JqCtDI8hF+s7OWc6MOeUBncPCr3djAM=;
 b=jC1fjq0WbVZpm7EpU1kHnX/xpKG859h5cRRbB9ZLVWcODha9tA3pDJickRiiWmcNKT+pyY1Hb6SVx4uJPx3T7crbnJAYaPQM4qXLleNypg4zPIFM95knTZlbfcDNG0bC/qe2BVPFTbskhLNLc8j3uwoUr4JMzTV5yM2zdhvuJCA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:30 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 06/15] xfs: allow block allocator to take an alignment hint
Date: Tue, 22 Apr 2025 12:27:30 +0000
Message-Id: <20250422122739.2230121-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1e630f-c141-4127-27c6-08dd819930b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMoLY+XGuKUzBiWuIiIkyMnGn8g/LWfvBMM97EzdPp+bJUr3Xp/oCMnLgciK?=
 =?us-ascii?Q?oEDLc5cB/3YY1vCUgWKtJSi5dCoVKW524ClNdQqtq6mp74qy20nDnjUKncGl?=
 =?us-ascii?Q?xX/18eVBFdGI9JIIzT09AkHuiDCasQxBa/dIA0EVgq0sCW7igKr1amhNzJho?=
 =?us-ascii?Q?SutA5UTIw08lkQk7fFARBIB4vucZUElKSy0mkR2JAJmF7xjcm0xAoYpTGTQ9?=
 =?us-ascii?Q?XoQ/Vrdp8jablVyt2/s8dgaBWmgIvEXrh3SYjPiaPS/H8VgYSazTkrcEatuB?=
 =?us-ascii?Q?7RJ5592/6snz2jKmUvw4B/Lw1OqvASZv0FUODMDuie27BA1lUnVeuFu6Ssaq?=
 =?us-ascii?Q?OLWK8kNwEkkunwKm7/bCPgJuOrkA72rc2MCmWpYJD8YuMqJVVlX542N7CUia?=
 =?us-ascii?Q?d98s9gDVSWyGNCfcsvj6OHl4EfzpardQ2GDQNnmB6PuYIzju6fSc7kKaFYhc?=
 =?us-ascii?Q?GlioNzcxTPqk/7I18BACjNYHug7tBgmNwsaFwINX5OH9Yr8UWh6vcDE7X+UU?=
 =?us-ascii?Q?BhVRTFFkr5n2ju999OIZQ2ydP5pSySDGVAOuANDyZobATymqpOYk7J6l1Qjm?=
 =?us-ascii?Q?whY4i09/h4VREbtYFEnAQXj7l+IU/NTHefhrmiEP/EoAeH9IhIn/Dnm1zVIr?=
 =?us-ascii?Q?14cDSiBlGPOyQ2DC7G3/IxrZXr9735jEokhuSr0AH9joIBCOA7FFMPP683fq?=
 =?us-ascii?Q?dClyd6ZZgDmEuPM4gpTo9Ie3kpdh9L9vkDfMxzhJK0fXu2uxC0s4B6PQGxNy?=
 =?us-ascii?Q?O1yhp4mM+M+OcZlzl8XF+UEEtqp9DYLLU2hlMM/ezYuIa3KlcQI8tvIVfElt?=
 =?us-ascii?Q?+Gq2gzqku4HsJA0ZA6u1lYtJOLxqXrZ/E13/Lw33nAOBs28FhOkQyvUTEkap?=
 =?us-ascii?Q?8WI3DBwquNGCVeec8obMjPKkPR1rMZ//ryQ5E/dGY76VWlI7Rf4jU9ZYiqrx?=
 =?us-ascii?Q?J3D5/7qBfVH2h55ZFXoD9La6UYft9wACoZi0wid+d61VLXoBQuBbs93JqoYN?=
 =?us-ascii?Q?2dA0dMv9nT6O9e/hDKFagSXcUaQ5Loh88CU18/NlywccoPdB2Aj73IdDcerJ?=
 =?us-ascii?Q?L301RYXOFPCBvpQhd5D1gxBBr5rOx/CX1C0aFyt6LwiKCAxN+jymuCsbZNEO?=
 =?us-ascii?Q?6V7CWk4PLMa/wqWzWaSMJXFTIgahKPgAOfUQ5X9ZRUEqYt8EEy7BzkWMAe3C?=
 =?us-ascii?Q?MLda1VMM2xnKWhQrO3hruD7eZmAm2IlOS97NqoOofM1DyFwB7vm9IhSGyEOU?=
 =?us-ascii?Q?SlFFSCf3yerM0cLLkuN/vQoMwxm3V0zL1rhz8G4phBk3sTzqqPC6hRTGeBq4?=
 =?us-ascii?Q?6t/USlA6WASDEi7k+I6c79poU/7ROXFQnFi8Er5rnYjYbdwROfUH4NrbMdhk?=
 =?us-ascii?Q?UAOMYQ9sFT5hnILeUg2WWMt0No7keFAFN2c8ZB93NwvN71mgjsnWoFc7cUN1?=
 =?us-ascii?Q?UPkhp5tPbn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1CMuKB2RID0IQA9Sf6129rREjQe3rcOmGo+7aX0iXxdGvI0iZLmYnnG07T/?=
 =?us-ascii?Q?fNP501bICreh54ql2k68mcM2GE+Pv3QWo9krGSwzbsmiFqN06F7APlC5a0Mr?=
 =?us-ascii?Q?s796+qlArVzv0Y+1zStPyjShqoM0FKwKGhuQNnXNgzEAYuDhayzC+5ONn1pK?=
 =?us-ascii?Q?N0WwL3eJwN3c0wJfGxc28ndNyNLd/iOiWfYFPKF3L2DJTlWur3J+6vxG+H4k?=
 =?us-ascii?Q?5sfZhaNhWmD3DjIDu8PJ9xCyqMKO8hw9q+RGT2WPlMtLkT/zPNdGgGnHT9jT?=
 =?us-ascii?Q?K7Sday3Dhw1sgk7nfvXqZOnu4KFzqDVT0GeymgwmqnrheUv9C0O20xGuPuap?=
 =?us-ascii?Q?Y2h+ovDc3lTQ0ZEJiF9NilbZ3xMcHijEAxz4xj5mqqMyJY3dfcusG1GyAxQx?=
 =?us-ascii?Q?kH58fy8b9shVbPKvd9duiDjQ9WdL6hdGwm0/kmk1RBsjpcMgwJGFBm0s+Igd?=
 =?us-ascii?Q?UMzkP7A7dogG6Ebin13xaSWcgRRtHpe9FVvOlvfYI9eKBh2BKUmSGziXrqlK?=
 =?us-ascii?Q?7D2wqxuShCLrLSDMBeIVopDrGyL1K4c9LE2OhZqoJlcE6KdKIZ5C4hxmCKbX?=
 =?us-ascii?Q?utn73XvT2SGlAwbKbpDcOUvtBwN5mkdGmJG/PukHilDnKtfP7ufVTncguITL?=
 =?us-ascii?Q?z+FoWLE7UgDTSm3QhDFM4nKPkstF9xh5aa+C2VDyDw7X9DopU0xyqFTLzEnS?=
 =?us-ascii?Q?SGKgNfkC5mOUrNhn2ODdwbwmyVuHmBJeSlvTK8R74l/QsxW2eknx4LqZBfo+?=
 =?us-ascii?Q?X5zcpXqyE6atngSaBrU2jmQTPAnBfUad/O2ps+4T/4yu68PTE8MLPZylFhTI?=
 =?us-ascii?Q?kr5Q58gUhcE/n8IYHsCCnQebfYiAKYnnrKLBgqcwojt0OG7R15rlNoEKco0m?=
 =?us-ascii?Q?BlhatD8tfHZxDeeyqYVy0lzAFNI7t9SQl4qVoezJsopUmPt2lZIYNLKBzfHK?=
 =?us-ascii?Q?0tku55SnY9AyYjYZpiq4l+t05IKM7FEX3EGGB5wnh48KolyxcPs8Xb1u7+zS?=
 =?us-ascii?Q?4EU7MGvhww5av6Vx6izp9XufW5LoW4v/0oIX70INEoxFKAPXObIWzU4pdgHa?=
 =?us-ascii?Q?pb7rYLk+vVj8pJ9N+UUe+mkf6LzZxZeIBfYjR63cFydHb9H6Qt1Rm5a3eY+L?=
 =?us-ascii?Q?xUfYBA4MIjhY7uZVRzurFh72O+/yQz+YdrI72IUgNdrR+I3OwcheBv0E8bhI?=
 =?us-ascii?Q?s6hBo9KpIKe3Vr+dAuOgG/AwzRub7ePlKYhZj02aaA7lcqsB6tzewcdUkkhH?=
 =?us-ascii?Q?7MHLxsOCrIgbglG6K7xmbf1ApRG2NdEH/O8XVLQXgGEoWhMEJ5WdegdEJrVw?=
 =?us-ascii?Q?jvpWwndDd7qGsJhYUwWugMGQONXSQyoWrxuAU6v8fZYo0pq0c+oHzFjNmC11?=
 =?us-ascii?Q?R7tHFB9B6nIRgew9TNGJ2/tW0Wda1/paAwDK51UP+ZS68+AbPhNH2xo8RmB6?=
 =?us-ascii?Q?Z8HG4juKAHb2uKwnUNuHwnY2+aWbWh9gVZMzwhZvpFD63jfl2EXi6xFr48nt?=
 =?us-ascii?Q?Nb3LkgbtpaNHUrVqDlZ17AG+L/B++eGuQsljoJA0LwjG/Piy1vF3rCGSQ/yx?=
 =?us-ascii?Q?GGTlzFYSFRGEWPbRE/NBd/BHICm7f3TiOxXhfZ2yFeqFhKKGEE8Lukacletz?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wUNOEMop3OCmYgFCk86J01iydnkp7pbrpFlX7CW3BbEJcDg7T925R0dP4VYQ7DDS+Y0jJm+Tu23HC/mPD9Q6dfLORZRWOJeMd9VDNz7xWmGSBPrloK65XGcS4yFPBbaJew/e/bJxU/NsC/AcHYji2opfPpVBT6fRJiaZ88gtSIjeJSH1bf5CFoxbHbDJTHyoEjEK7Jqb3rrkN78eCCbabrf3fgDqcz3vmPuL9nJ1M0v0PmyyEaYdApXYSQfohuunF2kpXODllEc4WnFwszFXq6vPYdyuxIC+6jMkcXzzJUtUFG4xgZA3G4sH7KiBIdoVM/XszQd6cW5hP/8F/V7cTfh4ppLYtoB8uld0bsITVmdFVz9Po8RQp81mnlr7k//dZ8Jqu/7CvJykxHnx69d7FqzOxOqAWGFFJhi6RWdREQG9g44L7qnzp/55rScZvIsZeRPfh5jhEgktoT1jXgJy333AEixENtZiROLTCa8T/1t9AnVHyzArXBY6bGwkMNsT0JLm0lbT7aUCHBVYzPMwxftBif7jF57z8Sy4zYFW8yXchx3h4vx/g5ArHDyEI1BQ1HaD653onnkX9CfYfixHXyLZoTT4xBShHkf/rsAZdv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1e630f-c141-4127-27c6-08dd819930b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:30.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7GGoLBTJodSClcDPQX5hbxhKFkrKSbEBf07WrDOuU4f4KLXo/T9yk+MIckoZSawmjrCGAIfhNP4iw+saOP8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220094
X-Proofpoint-ORIG-GUID: kaBUO2mR4WEwR9VGR3JGDTLeI24a4oBo
X-Proofpoint-GUID: kaBUO2mR4WEwR9VGR3JGDTLeI24a4oBo

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


