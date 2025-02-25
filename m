Return-Path: <linux-fsdevel+bounces-42550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB2A434CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 06:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A100168046
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 05:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F52505A5;
	Tue, 25 Feb 2025 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="imQYkzEZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQ5Z5Oex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F23D984
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462320; cv=fail; b=K3QjJNKoqwlInyrxh1lyFrGCbCrZkGN5CbRypKr41rvn21KMfQIkj6JRgOL7/7hfzylukTwfnUdYyb3kMVO8i9XhHIVH3q0EO0CBGf3iKYvQWtt6JuvmWLsaeeW2CwCS3B2GXtgCaXzzxzrU1S3Kt7Aj+Kmk+K7HEBOi8I/jqPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462320; c=relaxed/simple;
	bh=7H2wltRyC8wzSoV36qTJoc6W0TpKA60jJCyPJUl7XBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gUTbkgXc/oYtkkbkCcrLybqQl7f2ZnBYX9PQ86m3XFiCVuvWvSie4mntcqlFAL5A14oBfdmYCyJ7K/xd/Y9DdOr9p5fDhSzbccEo89m8oDuh9MlIcod7RJ19z1pYbtHwLCmzVLkyOwZ4/KNsYzhbDJ6Q5yCxPugvw+nUOLdr1g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=imQYkzEZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQ5Z5Oex; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BbpX010151;
	Tue, 25 Feb 2025 05:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rH6jzs8tBExpKZIIHV81sC2+M/2Ya3h7Fp1lkueM3dM=; b=
	imQYkzEZPFlAMgal3kLgo8WCDzsKt+eAPubOUBX+3ejUyfa3xzuQLRiANr6x5NkD
	nAzCcEya47symC8lYt5eJNscWdWnMv4WSVpixT271p8rQEBmSahlTc6HEVOavDY3
	LRCRlo8z4Mpe7Bn45+c6tEub5Jcx59S+kqRCy3feFGX+iLzTqaNUmMKlgoV6ryNB
	cN6WlqgcuR2XVIwXCslAaiiHJhmjw3/B4YggwUnaKtDL4tpF1l1bYS022+xduR2U
	ZwN5r7iQe/wz9L7tp+s8pRvVwCOA7sRDHEp7OUfKR34aH4mT8u2GnKFHeO5ZkoBo
	9VTJ5/i+kZOYpWyZSL8oTA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbm8sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 05:45:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P2YBrf002886;
	Tue, 25 Feb 2025 05:45:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518x5q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 05:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv4qhrv6smO1QCnTKxljaM9esTLHUV2rBfvzj4agaaG5Jngrs5EqxU9ZIJLdspX2kXOBVfIjgWg9HXz1iUE/qxvpPy//HjuDBYtpf4eSk7d33nfmrmSP9vuATVOK7pAY+fgtKKsTVxyzddeomgTY+UpzjKgw4zLId64fMDmVhLT/n8tTPdKGh6Bad+q+uAWw9Ak43L98WSEM4KXpRZTHZY2HBvkLERlo5MJn8tG6csLsTGCZP9hU/UDgGNgImcyeZ+9HpddCTFk/v0BipzcstcV6DWgmwNigGz9+8yTkMmJNiyMrHu5cMaXw4qRfDqSREWwMj4w5rJEoLsjYHTOQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH6jzs8tBExpKZIIHV81sC2+M/2Ya3h7Fp1lkueM3dM=;
 b=aU1WbhirFAnri9mz9d9lc344Z/c21EtY5bpP+fFLqtpm7pSxjLE/imn6AzAvCcqy2L08FIT/goZdeM/W4kZbAF/bR/Ejn3YIm+iYGNNH8kegrNvPtdY5unqh2tgMSGvxHQBlAv0zRYduNhXAHNFEtCeOueGM2abjnV59cpNH4ewvqqMFQhXuwDWnF4ZhjxeA/tAKt99UYI4yCCHXrbedunV95iGO1EiseNVAZ1RAfjLIr1Osx4pZ71OnoriXV5lZgirmFOhPCouxxvNDANecLEWIOrfl0eU87v/k3DMeLEFLHOIuqmBQRXPzTmX6zolxm3iIgHHrUlO1t7a8LqhorQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH6jzs8tBExpKZIIHV81sC2+M/2Ya3h7Fp1lkueM3dM=;
 b=nQ5Z5Oex+a6ZmmlpAidYgVB+GmNq8ZPHaol5syH9GY6Yv7fWrq9eZxRLvecDbRNQwETm3F6TMfbU34fzEZ8GA3KcVGxnW2yn6ZX8ioi8RjqNO4Owdr/uHHN7pYJLvimE5jaT5TaGle0e7dml4iooVgTWiYY582pYYx6JWsKd65A=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 05:44:58 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 05:44:55 +0000
Date: Tue, 25 Feb 2025 05:44:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <4f0e3d28-008f-416a-9900-75b2355f1f66@lucifer.local>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
 <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::9) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 31254bd3-7c76-473f-637e-08dd555f8864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MytkcnE2cEhrSFRzcE14MVV4U2pHaDBQSmtXb09rMVBUdGluM0t4MjhuWjMv?=
 =?utf-8?B?c1VDc1EwdjIwdkg5MFRGNE9WQ1owK01oWUhKM1FtTnM1aDNTRWFESkplQ0gw?=
 =?utf-8?B?djJMKy9VaTc5aFRHY0k5YThJVDlkSkJUVzRYK0lFcnprL0x2bW81SVB0cUx3?=
 =?utf-8?B?eXNXSkNyWXFEY0NJc2NHRUY5cUpjMzJvZ3d2cU4wenAydDBuc3dlczNOSi9V?=
 =?utf-8?B?R25GMExtcnNNWDRqaVZMTVl4UnUrcllHekltbE1vK2xsakxiZDlHM05ZN05X?=
 =?utf-8?B?R2paMERzdzR0bXhtbWJSdUtVUkhHbmxXRnlGSjVwcDhtMmZwaTAxWXBHNlNz?=
 =?utf-8?B?S2s5SW5VNllMREVMNUtoYWJHc2RRT1ZPU0h4T3U4eWI3ZmNTc1k1cUh2cllD?=
 =?utf-8?B?TTBtano1dmNHNnhDampWRGdka2RDWTV3cjZiQjc0NHhmREx2bzJrTWdmU2dN?=
 =?utf-8?B?MldWM1JoUzVCVDhaQmdGZWQ1S1B1OGZvMjZRdjlURDF1dElrMFJ3NjQ2WmtY?=
 =?utf-8?B?NG1RcDVlbm5nbHZpbFJoZ2hIMHgvN3M3bERvZDFROWVOVUFNOG9lSC84TFYy?=
 =?utf-8?B?dVMvZmdLMHZ2a2J1MHlZT2hURXY0N0RnYWIxQnQ3V3BxdHN0Wk4wZjBVcWNz?=
 =?utf-8?B?TlBHQWhlbWZtOHh4YkJjN3NzZDRVL3lhWUQwZkpHU2dWNm82Q0FCWkFoY1lJ?=
 =?utf-8?B?QXlXbkI1cmdlREFqOFFsRkdhS1pDNkZld3h0TDVzZkxjYmFrcWI2NXRzTlVx?=
 =?utf-8?B?cm9mRHFVeEwraVZPUGpaKzI3NEFudDhFNmVSZ2c0clArN2VhTFU0RFdmRlc2?=
 =?utf-8?B?UW9xeWZaWXVObUI5V3ZBaTBOZEVWOExHMmtCSHhCRVRrVFM1MzhMSTBvVGY5?=
 =?utf-8?B?alZmdGVNV21YeFZDTC9xYkRLb0Qzc05mOC9qWHlSbStHc2VpYVNDVlN2QXNt?=
 =?utf-8?B?dHlzL2RrY29lenVWWCtjMjloV1FaVjQxODIwbGJLOXpPWEV1RHRyWnFLbE9m?=
 =?utf-8?B?MEVSOExGSWxYaENDSG9CUGY1V2hzZFh5bUx3eHN4SkRwTkFZeEZZdS9sNEl1?=
 =?utf-8?B?WlVEL0NFT0NiQjd1SDhldjJTQU1pN3Y2ckZrdEFsMWZrL1FxcG44ckZ1QzRo?=
 =?utf-8?B?azVPZDVJclc1QXdTK3p2VWhRZlNZVkRaSmlLK25Zek1HamJvTVNhazEvZ3lD?=
 =?utf-8?B?TWczektYcWxWUFdUMXZ6SzU2dGdtZWh5K0JrV2h4L0ZhZCszVlczKzNlWkwx?=
 =?utf-8?B?cHJRRnNNSWs4d0xkMmdWRFlEamVtUDA4YW5qckMxQ25scmRiQWpqekw5bmo1?=
 =?utf-8?B?UFIvUUp2NlA1S3FLamtudFZ3V2F3d1kwVXJSdldhdU9GRlVmRGJMU0h5SHI1?=
 =?utf-8?B?U0V5SFNmTzdtVVVTd1FKNVRlbTlKb1E4UmM1dUROYUJGTlZKN1FGNHZMRmw0?=
 =?utf-8?B?RHVmQ20vOStYWUlqdkY1WDVKWCtBNkw4V1lvNDlCWS85ZmtadnBkMy83UURE?=
 =?utf-8?B?NkNYMU93Q0ltNEl3ckJvVCs2TUtSSDlpZmFOQlVkbVBpVDIxNkNjaEZJTk9h?=
 =?utf-8?B?cVVuUjlJRmluU1JvK01EcFNJYStsbE5kcGRzanc1VDFXUGFZc2VFc21BbUQ0?=
 =?utf-8?B?ZERxRGRZN3U3Um9MZVMzbER3Y01FZXNUSnBId01UYVd1SWpvQTZVeXZuRWw0?=
 =?utf-8?B?NTIyM2srbHpjTktsWFRjNGt1OUFxamRtdk8vcGhlOUpaaFMwb2c4b3BWS1RH?=
 =?utf-8?B?Uk9TeXZTRnlBUXBYVGU4blV6WlhYTUxJNnhWMjJlRUVMWDB3elVWSUFzcDE1?=
 =?utf-8?B?RWlzOVRNQXBKUWp3eThQT0ZJTDZFaWZDNTFoT01pdGZpcmtXUUo3SEZwZ1VX?=
 =?utf-8?B?bFkyZ1RteDhJUHJPRzFLSTdrcVUyU0hhUnZuQUlRaUc1WUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxwa0hpWjZvZUdMQldVQnZ3OGNnZFFMZDNJK1hzSUxmSXlKdUVJTlVtOXBv?=
 =?utf-8?B?WkcveHpqdVA0WU1iNFZGNDJ2VDBQN0g3MmhOdnZzU1pOQkQ2aDI0RGV6MzRu?=
 =?utf-8?B?QUloQ0t2WTIwVTdCV1gybStRSk5qem5QSld6SFIzS1ByWkgxYmpIZExPUUdS?=
 =?utf-8?B?YUVhTVBEVm4rSGJCeVdFWGVMWHFYd3lOd080cDJuQWNabWpScGx5b21BNjgr?=
 =?utf-8?B?T3c1VWFCa2lLRjNaVmpyVzVNTnFvZlpXR01NdnRybGtJLzNUSWl4TVh3Rm1y?=
 =?utf-8?B?bjVZN1p4S0hka0ZjNFBpRzI5WFh4YWtCVFN6SUtXYjRPWDRFSFpoVDgvVGNR?=
 =?utf-8?B?a3JsaE9QSkxZUVpaZ0tKbk9JN0hDUi9Cdyt6Qzl6OG5XeGZOSEg2S0VhdGZT?=
 =?utf-8?B?MndMcUQwWTc0SkIxTUU5UG9lUjJTL3BlVFZtR0syNlNkWjZVcEo4aVF5aHJz?=
 =?utf-8?B?dHVMSWthMXZLckRQZ01KblJYZXBuREN0OGd3Q3dYbmpJNzNIMDNsSHNFM0J5?=
 =?utf-8?B?YnRhQkZkMHVlQXJVeWpPUFRLWjByeWRMVWRoNWRKbkZQYnlqM3JKbFIzN0lL?=
 =?utf-8?B?MCswbW0wOVNhZUhOSGw3UC9Fbi8yamNTUm52VFJqSFAzS2xmdmNuUDBXTENB?=
 =?utf-8?B?UCtqeHQ4WllFNTVYaHc5UVdXSlgzdE44cnQyTTVZQnc3VmUvTDhWNGFCdGJ1?=
 =?utf-8?B?WkgyZlJuOUtJZUZiNGdrTlVIMVMrZTAvSmR3aUQ2K2xnWHdNL2lsMGIxNm9W?=
 =?utf-8?B?WWdML0dLdTgwRVdjZlh1eVR4VTcrM0huL2pwQWpsWitqZ2NaV2FtSURNTjVL?=
 =?utf-8?B?VzBhVUUwLzk4WjZwNndqNDN4NHQyVXdDVzB5TytLMGU1djJObXkzZVVrQ01u?=
 =?utf-8?B?NG5XZTZFbWFRV2dCK1Z4VFZKMVJwTzVadm1TVGxEOE9vbW13MWlOTUFocWlV?=
 =?utf-8?B?NWswL0hTUmp3NE5KU3FxcUpkNUNvbExCY0FpVUJ0dFdCS3p0OXlXUUYzQ05r?=
 =?utf-8?B?WkZ2RFdkRHYvOFZjcm12YVZQRDdLb2xoZzRtemRQNUpFWVZOcGd6L1BiakpT?=
 =?utf-8?B?cDlOV0MyU1Nib3ExS25GY2NRQVFyRnhqbkhqM1dlZmovaEwwT0l3SlRkYUQ1?=
 =?utf-8?B?a3hoM3dtMU5EeHVVVndPV0dlYVhYd1FSSTYyL3V0aEZJakpGTjlRKzFkK1pm?=
 =?utf-8?B?ckhWa0c4bnc4UzlmdEJUdnIwVjNnREgyUGRtWXlDcXE0ZUxlZFUrUGFNaGxs?=
 =?utf-8?B?VFdzWUd3OHRMWDNjY3lFSitOYzJKTXQ3Q3hzT2NFK3RiTHdLWm82R1MxUVAv?=
 =?utf-8?B?bER1c3BUM0NwRHJBZCtscE5qSnRnT1BVb3NXK1BjV0Yrb05ablU4MUljaUJk?=
 =?utf-8?B?SlY5c0p4U0h2cGJnZVdFcmdyR3VBajJoT2s3ZE9sb1ZGdVVVc1JTQ1FCS2xR?=
 =?utf-8?B?a3o2eWNDWkpMWGw2RElFZGNzL2MzMUxxN2M4TkxJYXlVZnBDZFF0MHArSVVG?=
 =?utf-8?B?alBxRWs4U014MjZGWkJacE8ySWVnZ1VhOXB6ajZzdHlENVVLb3o3Um55Rzcy?=
 =?utf-8?B?MjkyUDh0WW1oMzVncFFLRGdacXR6SndMWlA1VjhwN1RXbHlybHdRZXdjM3Ri?=
 =?utf-8?B?OUJBUmxFS09BVFY1S0lZSjBYdGR4VFJJdElKVHBUYnd5OVFlS3R1M29XRmRL?=
 =?utf-8?B?akVsNEdnR1VVbGNub0JvT1h2aklNUUNBU1pwbVdFWFN6dWptNHNneWVpK05x?=
 =?utf-8?B?cW83Q2ZzL0xDTlB0anI3K2VJT2VpMmY2OXlBOTkzUWE4dEJMLys1aEdIZmUw?=
 =?utf-8?B?MzJKUXhDNnBuSHNYenNJM0lxOEl5djBKaFFDVHJvc2cyLzBFS281Y2cwTFlM?=
 =?utf-8?B?RlNqVkJoeEs0R2VnNDBQbnM2eEhsOTltNi84VTc2OEdSem1OUkM5ekwxeGNa?=
 =?utf-8?B?a0tvWGRKenJKUXhQQUlqdmQ5K1hMTVlGcG5Rejc1Unh4eFBQcVdGS3JieUpa?=
 =?utf-8?B?aUh6NkpjT01WdTBJL0ZWcWttZGVhVGxhNmN6dmZKYTAwL3ZVR0FVUy9udXRj?=
 =?utf-8?B?dkl3UVhuTmtuRGpQTkVRUmt1U2tZZjJ1UWdlQmwxRzRwTUs1Z2dZYXRDTlVR?=
 =?utf-8?B?RUdHOE50SC9UU3h1Tno1RlBYMW8zRDQ0WkptSkFoUVlWSjVoVG1TYkRVN3Rr?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3orMCjXNDZsVRqw5D1d95se3oUti4RVIqZhgEI0EJ45MOa51G7ViLgN6JaJ0NyY/HxV7IlYB79UJwIAdaIc8LGxxsBx3I4OJlDm+1IUI1ugo/s04tSgMALlo79yXEwAlM4SJZKQUFzhgK0BkamDjKoJ0Xps/P8Y8ELsMbtidnLMmvuEXcnmaGfpqpoIoP5Aee0eTT8LxuTY//eB9Oafc0DAWV2E+5aGNRW06Ia7e6Ivz0mKey88UMN/I0cNm8HllrAl9cTmMauPz8Y2wEkxfl/6P2+TQnFXtgTCuswl/RpyKXKOc6kGzKP2vEos0S/hnj0sdftZb+MFmAQhQl6k3PPQOJB1y493HtyLpUa78tLdfj8mhXNgmvPj2VBN3uWKZr+qi+vECaYIadw3I6MfuPt6ZNVxUTF3gDCPtyAvzRodcj50Ag0KDJ9XiZ8oZv5i0aRW0suTV6M/LT6XCDIU68hZbNN/x1eI3pWv+aO2vqNtSpGn0gV1MmYCkXczYC1v/o7AExoJG9Yd87X4IlZo+aKQaCCH2t/P+2+Wwi9VuZPLSwOUwGguexXsgqsbYOhtxLKM019tCT2IrVXt3PvccJ3c3iXyWx9iItuFQWMBjd1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31254bd3-7c76-473f-637e-08dd555f8864
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 05:44:55.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AHHv32mXRHsATV/QFanFO0wpbt+KJMSEwc/fLhsZElIg0G4aBYSMVhWv11M7pgqWub3lh14T3IrkWxN/aTGD3vQgq2xprBxH33k5sp7XFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250035
X-Proofpoint-ORIG-GUID: 4pg0IJbnBgPCPVmagz8IgISIlkdAYluR
X-Proofpoint-GUID: 4pg0IJbnBgPCPVmagz8IgISIlkdAYluR

On Mon, Feb 24, 2025 at 01:36:50PM -0800, Kalesh Singh wrote:
> On Mon, Feb 24, 2025 at 8:52 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 05:31:16PM +0100, Jan Kara wrote:
> > > On Mon 24-02-25 14:21:37, Lorenzo Stoakes wrote:
> > > > On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> > > > > Hello!
> > > > >
> > > > > On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > > > > > Problem Statement
> > > > > > ===============
> > > > > >
> > > > > > Readahead can result in unnecessary page cache pollution for mapped
> > > > > > regions that are never accessed. Current mechanisms to disable
> > > > > > readahead lack granularity and rather operate at the file or VMA
> > > > > > level. This proposal seeks to initiate discussion at LSFMM to explore
> > > > > > potential solutions for optimizing page cache/readahead behavior.
> > > > > >
> > > > > >
> > > > > > Background
> > > > > > =========
> > > > > >
> > > > > > The read-ahead heuristics on file-backed memory mappings can
> > > > > > inadvertently populate the page cache with pages corresponding to
> > > > > > regions that user-space processes are known never to access e.g ELF
> > > > > > LOAD segment padding regions. While these pages are ultimately
> > > > > > reclaimable, their presence precipitates unnecessary I/O operations,
> > > > > > particularly when a substantial quantity of such regions exists.
> > > > > >
> > > > > > Although the underlying file can be made sparse in these regions to
> > > > > > mitigate I/O, readahead will still allocate discrete zero pages when
> > > > > > populating the page cache within these ranges. These pages, while
> > > > > > subject to reclaim, introduce additional churn to the LRU. This
> > > > > > reclaim overhead is further exacerbated in filesystems that support
> > > > > > "fault-around" semantics, that can populate the surrounding pages’
> > > > > > PTEs if found present in the page cache.
> > > > > >
> > > > > > While the memory impact may be negligible for large files containing a
> > > > > > limited number of sparse regions, it becomes appreciable for many
> > > > > > small mappings characterized by numerous holes. This scenario can
> > > > > > arise from efforts to minimize vm_area_struct slab memory footprint.
> > > > >
>
> Hi Jan, Lorenzo, thanks for the comments.
>
> > > > > OK, I agree the behavior you describe exists. But do you have some
> > > > > real-world numbers showing its extent? I'm not looking for some artificial
> > > > > numbers - sure bad cases can be constructed - but how big practical problem
> > > > > is this? If you can show that average Android phone has 10% of these
> > > > > useless pages in memory than that's one thing and we should be looking for
> > > > > some general solution. If it is more like 0.1%, then why bother?
> > > > >
>
> Once I revert a workaround that we currently have to avoid
> fault-around for these regions (we don't have an out of tree solution
> to prevent the page cache population); our CI which checks memory
> usage after performing some common app user-journeys; reports
> regressions as shown in the snippet below. Note, that the increases
> here are only for the populated PTEs (bounded by VMA) so the actual
> pollution is theoretically larger.

Hm fault-around populates these duplicate zero pages? I guess it would
actually. I'd be curious to hear about this out-of-tree patch, and I wonder how
upstreamable it might be? :)

>
> Metric: perfetto_media.extractor#file-rss-avg
> Increased by 7.495 MB (32.7%)
>
> Metric: perfetto_/system/bin/audioserver#file-rss-avg
> Increased by 6.262 MB (29.8%)
>
> Metric: perfetto_/system/bin/mediaserver#file-rss-max
> Increased by 8.325 MB (28.0%)
>
> Metric: perfetto_/system/bin/mediaserver#file-rss-avg
> Increased by 8.198 MB (28.4%)
>
> Metric: perfetto_media.extractor#file-rss-max
> Increased by 7.95 MB (33.6%)
>
> Metric: perfetto_/system/bin/incidentd#file-rss-avg
> Increased by 0.896 MB (20.4%)
>
> Metric: perfetto_/system/bin/audioserver#file-rss-max
> Increased by 6.883 MB (31.9%)
>
> Metric: perfetto_media.swcodec#file-rss-max
> Increased by 7.236 MB (34.9%)
>
> Metric: perfetto_/system/bin/incidentd#file-rss-max
> Increased by 1.003 MB (22.7%)
>
> Metric: perfetto_/system/bin/cameraserver#file-rss-avg
> Increased by 6.946 MB (34.2%)
>
> Metric: perfetto_/system/bin/cameraserver#file-rss-max
> Increased by 7.205 MB (33.8%)
>
> Metric: perfetto_com.android.nfc#file-rss-max
> Increased by 8.525 MB (9.8%)
>
> Metric: perfetto_/system/bin/surfaceflinger#file-rss-avg
> Increased by 3.715 MB (3.6%)
>
> Metric: perfetto_media.swcodec#file-rss-avg
> Increased by 5.096 MB (27.1%)

Yikes yeah.

>
> [...]
>
> The issue is widespread across processes because in order to support
> larger page sizes Android has a requirement that the ELF segments are
> at-least 16KB aligned, which lead to the padding regions (never
> accessed).

Again I wonder if the _really_ important problem here is this duplicate zero
page proliferation?

As Matthew points out, fixing this might be quite involved, but this isn't
pushing back on doing so, it's good to fix things even if it's hard :>)

>
> > > > > > Limitations of Existing Mechanisms
> > > > > > ===========================
> > > > > >
> > > > > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > > > > > entire file, rather than specific sub-regions. The offset and length
> > > > > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > > > > POSIX_FADV_DONTNEED [2] cases.
> > > > > >
> > > > > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > > > > > VMA, rather than specific sub-regions. [3]
> > > > > > Guard Regions: While guard regions for file-backed VMAs circumvent
> > > > > > fault-around concerns, the fundamental issue of unnecessary page cache
> > > > > > population persists. [4]
> > > > >
> > > > > Somewhere else in the thread you complain about readahead extending past
> > > > > the VMA. That's relatively easy to avoid at least for readahead triggered
> > > > > from filemap_fault() (i.e., do_async_mmap_readahead() and
> > > > > do_sync_mmap_readahead()). I agree we could do that and that seems as a
> > > > > relatively uncontroversial change. Note that if someone accesses the file
> > > > > through standard read(2) or write(2) syscall or through different memory
> > > > > mapping, the limits won't apply but such combinations of access are not
> > > > > that common anyway.
> > > >
> > > > Hm I'm not sure sure, map elf files with different mprotect(), or mprotect()
> > > > different portions of a file and suddenly you lose all the readahead for the
> > > > rest even though you're reading sequentially?
> > >
> > > Well, you wouldn't loose all readahead for the rest. Just readahead won't
> > > preread data underlying the next VMA so yes, you get a cache miss and have
> > > to wait for a page to get loaded into cache when transitioning to the next
> > > VMA but once you get there, you'll have readahead running at full speed
> > > again.
> >
> > I'm aware of how readahead works (I _believe_ there's currently a
> > pre-release of a book with a very extensive section on readahead written by
> > somebody :P).
> >
> > Also been looking at it for file-backed guard regions recently, which is
> > why I've been commenting here specifically as it's been on my mind lately,
> > and also Kalesh's interest in this stems from a guard region 'scenario'
> > (hence my cc).
> >
> > Anyway perhaps I didn't phrase this well - my concern is whether this might
> > impact performance in real world scenarios, such as one where a VMA is
> > mapped then mprotect()'d or mmap()'d in parts causing _separate VMAs_ of
> > the same file, in sequential order.
> >
> > From Kalesh's LPC talk, unless I misinterpreted what he said, this is
> > precisely what he's doing? I mean we'd not be talking here about mmap()
> > behaviour with readahead otherwise.
> >
> > Granted, perhaps you'd only _ever_ be reading sequentially within a
> > specific VMA's boundaries, rather than going from one to another (excluding
> > PROT_NONE guards obviously) and that's very possible, if that's what you
> > mean.
> >
> > But otherwise, surely this is a thing? And might we therefore be imposing
> > unnecessary cache misses?
> >
> > Which is why I suggest...
> >
> > >
> > > So yes, sequential read of a memory mapping of a file fragmented into many
> > > VMAs will be somewhat slower. My impression is such use is rare (sequential
> > > readers tend to use read(2) rather than mmap) but I could be wrong.
> > >
> > > > What about shared libraries with r/o parts and exec parts?
> > > >
> > > > I think we'd really need to do some pretty careful checking to ensure this
> > > > wouldn't break some real world use cases esp. if we really do mostly
> > > > readahead data from page cache.
> > >
> > > So I'm not sure if you are not conflating two things here because the above
> > > sentence doesn't make sense to me :). Readahead is the mechanism that
> > > brings data from underlying filesystem into the page cache. Fault-around is
> > > the mechanism that maps into page tables pages present in the page cache
> > > although they were not possibly requested by the page fault. By "do mostly
> > > readahead data from page cache" are you speaking about fault-around? That
> > > currently does not cross VMA boundaries anyway as far as I'm reading
> > > do_fault_around()...
> >
> > ...that we test this and see how it behaves :) Which is literally all I
> > am saying in the above. Ideally with representative workloads.
> >
> > I mean, I think this shouldn't be a controversial point right? Perhaps
> > again I didn't communicate this well. But this is all I mean here.
> >
> > BTW, I understand the difference between readahead and fault-around, you can
> > run git blame on do_fault_around() if you have doubts about that ;)
> >
> > And yes fault around is constrained to the VMA (and actually avoids
> > crossing PTE boundaries).
> >
> > >
> > > > > Regarding controlling readahead for various portions of the file - I'm
> > > > > skeptical. In my opinion it would require too much bookeeping on the kernel
> > > > > side for such a niche usecache (but maybe your numbers will show it isn't
> > > > > such a niche as I think :)). I can imagine you could just completely
> > > > > turn off kernel readahead for the file and do your special readahead from
> > > > > userspace - I think you could use either userfaultfd for triggering it or
> > > > > new fanotify FAN_PREACCESS events.
> > > >
>
> Something like this would be ideal for the use case where uncompressed
> ELF files are mapped directly from zipped APKs without extracting
> them. (I don't have any real world number for this case atm). I also
> don't know if the cache miss on the subsequent VMAs has significant
> overhead in practice ... I'll try to collect some data for this.
>
> > > > I'm opposed to anything that'll proliferate VMAs (and from what Kalesh
> > > > says, he is too!) I don't really see how we could avoid having to do that
> > > > for this kind of case, but I may be missing something...
> > >
> > > I don't see why we would need to be increasing number of VMAs here at all.
> > > With FAN_PREACCESS you get notification with file & offset when it's
> > > accessed, you can issue readahead(2) calls based on that however you like.
> > > Similarly you can ask for userfaults for the whole mapped range and handle
> > > those. Now thinking more about this, this approach has the downside that
> > > you cannot implement async readahead with it (once PTE is mapped to some
> > > page it won't trigger notifications either with FAN_PREACCESS or with
> > > UFFD). But with UFFD you could at least trigger readahead on minor faults.
> >
> > Yeah we're talking past each other on this, sorry I missed your point about
> > fanotify there!
> >
> > uffd is probably not reasonably workable given overhead I would have
> > thought.
> >
> > I am really unaware of how fanotify works so I mean cool if you can find a
> > solution this way, awesome :)
> >
> > I'm just saying, if we need to somehow retain state about regions which
> > should have adjusted readahead behaviour at a VMA level, I can't see how
> > this could be done without VMA fragmentation and I'd rather we didn't.
> >
> > If we can avoid that great!
>
> Another possible way we can look at this: in the regressions shared
> above by the ELF padding regions, we are able to make these regions
> sparse (for *almost* all cases) -- solving the shared-zero page
> problem for file mappings, would also eliminate much of this overhead.
> So perhaps we should tackle this angle? If that's a more tangible
> solution ?

To me it seems we are converging on this as at least part of the solution.

>
> From the previous discussions that Matthew shared [7], it seems like
> Dave proposed an alternative to moving the extents to the VFS layer to
> invert the IO read path operations [8]. Maybe this is a move
> approachable solution since there is precedence for the same in the
> write path?
>
> [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead.org/
> [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster.area/
>
> Thanks,
> Kalesh
> >
> > >
> > >                                                               Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR

Overall I think we can conclude - this is a topic of interest to people for
LSF :)

