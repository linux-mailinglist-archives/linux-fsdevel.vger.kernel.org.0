Return-Path: <linux-fsdevel+bounces-29199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CAC977035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F0B1F22061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5031BF802;
	Thu, 12 Sep 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJR1wqmV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xr85o9uF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045F13D530;
	Thu, 12 Sep 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165060; cv=fail; b=Vkbp5FpQVrh3y2/pytmWXCEtM+ntVEkXHsZYjR4mxA4lF5VHpp3KeS/7T9k5RdU53yYU29s4BgWLzx2Xn+6ca3vZkrS91wjWbHS84+t6ySHB9HsUW2b7SWk99kSsP9jMEJhPPJp7olFXuD6NIAWqifGvGUKLPEOkUz/X0qqEIps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165060; c=relaxed/simple;
	bh=Y+dyFtY4D5dMAPsKtgidUoa0FExzsZp0Nsgr1s/NjlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BsTg5mR1s/ONjSrXlfqvnrY+Lk5e37CvVE1E0ifL6ist+uVx9YSHyRha+xNZr0JhVDdmVLO1G4SQtYDJYhNu4CYavA9v3xyzksH9D2RxpRAYiYm4e0NJu7rQ2uVRZkMwS1ylbG8SWj1/pSZ0Zr3F1dcCZG/31ibwiozRNdAKz8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OJR1wqmV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xr85o9uF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CDtWaS016492;
	Thu, 12 Sep 2024 18:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Y+dyFtY4D5dMAPsKtgidUoa0FExzsZp0Nsgr1s/Nj
	lY=; b=OJR1wqmVupcOy7JvdXGG9N01ld9APGyV+id9iVXWj4snJhwgiQESo/+fq
	aT9PesmA/65DWbuL94QbnBBlp6Mf5kSfYIng5/C+DYSZgZ2WpNI77D8nna83hFRO
	NNnNaQc3wYpGk8YpcI86tWl4xQSZRamuP85LzsGjKUtr5KHnG6cdPOhulxpNqjde
	hhDAgWV6ny9A1I3e8HasBhTcWQFRDLUwfG5T+0Hs5x7h+k8vWNJ6snz0vQHA9rZr
	3y3jhcXt548ih0c889087SUNRVUdVIC8wUoPG1pmUouDngnBR7U87VD7KEY/vftf
	iwZuPPEXpKkeuNsSvlpUvB/WZipsw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbuud0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 18:17:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CHv0H1033533;
	Thu, 12 Sep 2024 18:17:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bneb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 18:17:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvRoBYQQdvops+2QO0k/TuACuJaUZTw012knxaGzU7rDcDuYTrqYnf3QZDysHjOW0sxde4e1FA6vaBf3XXHArW30FqBmXuemKN2rb5IiuqbGQDTwBZ7InrSa2TNbBt5rnVMez6pVzSWtvZHBWbGIe+oy+ulIeDD3OzgnYKfMMSAck/cBk4jtZyQ1x4kfAYIdNX815FJRtKusRYAho6AVTXj4ydYxRH9hFLcnZZSda/O2sKv6owLGureSyY+LibVo53G7O4MCfqWb96jTvU+Pfp34WcdzXBwiZVeo9zlNl94A/SEBSSB2MeuhzLL6MZxSveax2ia7AbNzm83j6dtotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+dyFtY4D5dMAPsKtgidUoa0FExzsZp0Nsgr1s/NjlY=;
 b=EsVbrYfo3RxdoqTogfAEWsLl+MO+NiefDrR9Fo3fXeIVWVy7zWoTECjIvDuuJy5YBRpwuJWonuhMdRcKkDVn2l00G+BIOnw8dWXMQHfcW37ldDQ8mk1wNcYhuCcIpHrRsKZ32u+ylSnbaYhs/ZTEeKh//zlynZUwRG3+QxF6a1wYuyOcXhiAX3/twDhGaayK6LxPJIW88v21qOdeK0YxfLCD72ww8Ulyx/diKQIBoP/AXXTqRsmfD5UTtFBPHwMSo6PfEFFhkZEaPtyll/6uDKyQcMvvNVSFq+eRYx0v9nEiuML6cTD+gKHgnacN2hZKk4DKjg9P7uG5o+kyWxLsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+dyFtY4D5dMAPsKtgidUoa0FExzsZp0Nsgr1s/NjlY=;
 b=Xr85o9uFzZEEc/BtDL7ytq9QYWlyrFEf2KZJ5z/mYx8aMOqtrlBwE8Flkx+Uilv36WxJB+UWe6eZqiXnHbT+jUt7xTfB8E3rf8k8v/xtU5zlNsgK+perP8E50+KpMySSC3P1U7Py/yNAwJ41gN4l5gKt/nTb36mA/BlSCxb/JTc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 18:17:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Thu, 12 Sep 2024
 18:17:06 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Neil Brown <neilb@suse.de>,
        Trond
 Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mark
 Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi
	<joseph.qi@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
	<jack@suse.cz>,
        Alexander Ahring Oder Aring <aahringo@redhat.com>,
        Linux FS
 Devel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        "gfs2@lists.linux.dev"
	<gfs2@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Thread-Topic: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Thread-Index: AQHbBILbIkQ42h8MOEqBVgYVsg2/vbJUL3IAgAASXICAADURgA==
Date: Thu, 12 Sep 2024 18:17:06 +0000
Message-ID: <D0E3A915-E146-46C9-A64E-1B6CC2C631F4@oracle.com>
References: <cover.1726083391.git.bcodding@redhat.com>
 <244954CF-C177-406C-9CAC-6F62D65C94DE@oracle.com>
 <E2E16098-2A6E-4300-A17A-FA7C2E140B23@redhat.com>
In-Reply-To: <E2E16098-2A6E-4300-A17A-FA7C2E140B23@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5055:EE_
x-ms-office365-filtering-correlation-id: 2aeeab0b-6a65-47c6-8e78-08dcd3571bfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWxIdVhSMGlUd25ZcG5nK1I1T1N3S2ZzUGZyS1JyZnBjQm05UDJmZ21aQ0xn?=
 =?utf-8?B?TSs2VUZ4aExVWkxSaVVlWFEwTEtXUXBQcDlXUDRjNUl1QTJQMEIxWU5UZmtz?=
 =?utf-8?B?ZjZVU0E1aWp6QVR2VDhpckx0NXQ3blNUTXJudzlyZVBNdkR5RG9zR1k0THVG?=
 =?utf-8?B?RTY0TFhiWWdMY1ZWb05tTWs3dTIzaUFLbXFNb2hRV21kVjJyeVdGM2RDenpU?=
 =?utf-8?B?eExhZVZPc1F0Zjk3aVdrOWxaWm1QUEJRVk0vQzhGTy9tMU1WSHVITFJ3bk5u?=
 =?utf-8?B?U2NkaSsxOTJ1Z21lZzhyeC93b3hpelZRalZpdzVHZ0lXNVNBY09RLzBpMzFE?=
 =?utf-8?B?bFdqbmhGSjdNc3BIa3BFTHBwWEVKbXorM0ZJRmF0VjJDbEZoaFN5bmp4byt1?=
 =?utf-8?B?dEZvamNZaVVIRmJKMG9QZWhtNGhpUEZWalN5elVLMDZudE9ER0FiNEVJbkR5?=
 =?utf-8?B?QThqbzJiZnZ5VG9PT1I3c2htN3Y3akNhVkRlS1daZTE3TjhldUZJQmxBVVZ3?=
 =?utf-8?B?Q3hxelRMNUVqczc3TlVja29LVHJmLzBjWFFJdlBiU3FKR2k3cFhEWldRcXZ5?=
 =?utf-8?B?a2tjSDkwMlNBaHBVVVlPWlE3RDVlUUE4SEdKcTJOaTVsaEZlYS9GM1FpWXVK?=
 =?utf-8?B?cHovN2F5T1pQWFVqRHA0aFhwSWJLRDdoQTdEbjJrRHM4WTFtTnpBQmRrNzMz?=
 =?utf-8?B?UGxZaW9ORXpONUQ4cHlYZlZKUHJ2YU5kd1B3TEV0b0k3UHlGZVpxejlNZDVO?=
 =?utf-8?B?dlRjOUFya1Z0RmtORWJjb3l3TWFla2lNelBjKzlTZlJRWkMwbXlsVmVYTThJ?=
 =?utf-8?B?ME9KdmhJNlJjc2Z6ZGp1Qi9pQVE1d2w3WkFna2NpelNPcW1sd3ZxNEo1NkFG?=
 =?utf-8?B?RE9jUWc4NVJieHV4UXN6SmIvbVlnQkF3aU8rZVVlWEtmQTJ5MVdaOHFyR3Vw?=
 =?utf-8?B?VlhKbU9EU2dBZmhKcWpYengrWm1uSlNFS1ZmUXgzQzhQdGJtTzdWc3V1b0V2?=
 =?utf-8?B?bGd4bXFiVC9kY1BIUWhuUGZ6LzJBcDZIWVB2NWZXc0lOYmxxRGI1TSt0R2Nw?=
 =?utf-8?B?MTRRL2FKcE9pMUFOYldMaUhEbGpiSGZ4aWFtRWVxb2RvTXRGMzJ1ZjZqUE9i?=
 =?utf-8?B?WG1SZkVkNHNjNkE5bW9ZZS9YTFlrdVQwVFloWHR5dnZ5QkF2TTE5d0FCYzc2?=
 =?utf-8?B?bm9FRHJ0YWF2U1VOaGtHc3dyL2dSVmtsUm9POHlsQTRQWVMxNHZDcmNxOEpR?=
 =?utf-8?B?MzN0UTBsREcwY3B0RkgvVTRqbFZKRWttTHRyTzR6RThnTy9kZnU2M04vVDlu?=
 =?utf-8?B?YmkrSnUyS3dwbStzT0l0NW5ablQwM2ZyM2k4TFMzdUxjS2pQRXlxUTduM1NK?=
 =?utf-8?B?MFpkSkxaZFZPNVM5V0tvci8xbzdFVHBhbjNIZ0kxSURSc0NpcENUQ3pyeCtt?=
 =?utf-8?B?NC9sNWlaNU8xN1UxenBqVUVDTVZaMzE1R1NyOC9vb3F6RldjYWdsNTVxaTU2?=
 =?utf-8?B?Yi9OZmZ1MVpLcUN4OEJlVjlUN0JCU3R0Q0hvZnY4UE9zclc0YVkwWGM5ckNj?=
 =?utf-8?B?Y2RBZVFpZmdGNzVHWG5jeStjNWxuOElELzRqYTYrb2I4Ry9xd015UnlOZFcy?=
 =?utf-8?B?b05rb2xWbnJuWityNzlkZTFCdDR5MHN6STdwTE5mU1VpWGRlcVRxR1BJRVdk?=
 =?utf-8?B?YXhzN0V4M1RBaHhPTXY2clRpcFNhd1diT3ZTTk5nZHROQjZka3RLa1gvd1pv?=
 =?utf-8?B?ZStYRS9TclBXZzNCZkhETEhwOW5TaURwTlBJMmk3cXYrMXpBc2hIZlZpQXBx?=
 =?utf-8?B?TnFueDByRmtSV2tPSVNOV293Q0lNK3F2cWRzSFpOQ1lBTXhMcnlkMjFEVWFj?=
 =?utf-8?B?SENxOHdqdnlvUUxXS2dudUpMMndHYm5Bb1N3KzUrRkxVVnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVlZTFh2OEVQKzIwaFNjRnJRMFNsR3FNb1p4cHdUUGh1bXErZ1BwOUZCQlpP?=
 =?utf-8?B?YzI2U3FlbDRkcnpEZFFUanBFaXpmNTREV1NsUk9RY0FTaDRCQjB6NEhZVUQ1?=
 =?utf-8?B?UDdlVlVXVi9Qd20vTnNPandLQnNnNGlPdWxXc1N6NnVWWFl0RGpGSDkvZEJn?=
 =?utf-8?B?ZFV1RTA1eTZRaUFEZVcrRmVWYk1sS3dhakpGUlgwc0FyNGo3c2lZS1I1T1Fj?=
 =?utf-8?B?TkVtY3BQNU14NHhic0p2OXJJdFNOeThjKzllakdQSHVZTkFoVlRkbXRTZm9m?=
 =?utf-8?B?SXJtSTZrNXRqWVBiUjNlKzVybDlKakJNL1FXWWdHK3RwaVBxUjNIOTVaWGht?=
 =?utf-8?B?Y3NhSWtSZUNGNE5laDh5S1NDaFUwdzN6R3NzeEJmdDc0dXREUVlKVHVpeGdo?=
 =?utf-8?B?V1ZkKzExdGMxZ3kwRDJsSERPbHVzSHdLekZJM0Q1SlczdnROZTlaVHVoWnlE?=
 =?utf-8?B?N0cwT3RZZlFNRUtnS0NydDR4MlpVYnREYlEzVHN4ODhQM0RkUDF0ZzdZa1h0?=
 =?utf-8?B?bkdFUjQ4bHdlWDJlb21KbjZKYytUeWNScFZpTVJsclFlalFvU1BFckZubnh4?=
 =?utf-8?B?S1puZ2FqR1MyVXVqUitRRCs1SUhNdWcxcHJyUUhWZXFFZ1VDbW1qUjdvNWN3?=
 =?utf-8?B?Wmo0Wk80VVR1VjAxQS8yWDczbkc0cGFnSEwvZ0Fna3lNOTk5ZFp2NTY4RVdU?=
 =?utf-8?B?R0RzS3RDWHkwY2U1bXBIUHBhTXdVbUhEUmlRRFQ5aXliMHhVTW93TVNYNkFZ?=
 =?utf-8?B?UlFnN2t1Vk5IT2dmNHJ1SXNrN2ZvVlJvMG9HV3ZIeU9TRW9rTUNQSnBzZU1Q?=
 =?utf-8?B?eHNCUDFQeG9CbzRzZ0xHUDJjZnJWR2wxRmVDSHZIQTZIR3czWmI1ZE0zWnV5?=
 =?utf-8?B?WWYyQmRydVRLZS9pWXFOcWN3YmtGbXIvOUNCc1Z1dGc4NWtUd1lWZlZLZEQ1?=
 =?utf-8?B?bTJkdDdwV2lVMTR3N29BMEIwTmJ1aStUbFJQa1luSmNxM2FUZEozSjNGdzRk?=
 =?utf-8?B?cjNqa2t1Q0pHMmxmUjFOa01EQklRMGkxUVZZWHJ3dGZDSWszbnlaelVjOU03?=
 =?utf-8?B?RC9JS3VXcEdXM3QwYTlMVXFLclVlam5nU21Fei81ZFhtcjM0TW13T1poNExr?=
 =?utf-8?B?anYzYmRvNWJ2cy9lU0Qybm5kQ3hWaFo1SGh6RU5HWnFtNGtnVVcwK3JVaW9O?=
 =?utf-8?B?YlpNZUtxTmVuOHRVeTNJMWRLeWNaRUxzWG8xcVMxOTVqZW5DbTFoRkorWVJr?=
 =?utf-8?B?TFNhNjl2Sy9uMzcxOWVIQmdRK0lyR01zUS9MUTM3Wk9RRGk5S0lMTStlTUJN?=
 =?utf-8?B?WGIyRGhMVVJzQUh1K0lFMmZaZmpvejBpYzA4ZUVoek1tZ2hCZVovYlJiWVdN?=
 =?utf-8?B?MjB0SzU3MDNqQi9XTS9Xd2xHWXlFQzFrci81bFRpbEthTU5lM2Z4b1puWHRw?=
 =?utf-8?B?TEJIb0ZYYlR2SDlrUFRKVzlocjYyNnkxclVSTXExR25YNWk3bEgyS241YjJq?=
 =?utf-8?B?QXpjTDBCVlk5T3BsbFRrSUJpUUFLZW0vVUdzQzlTOU05amg0S05GcGRFK3pE?=
 =?utf-8?B?c3FzS210cmk5RDlYUUYrR0x3UFp2YkNlQVM4NWdNYU1KSXdzekNtTTRIb0hH?=
 =?utf-8?B?ZUdiTXREVEMwSEFrQkNUL2JoUXJtcnIray9vSDJqYklBQ0dxRjZLN2pEWldJ?=
 =?utf-8?B?dUE1eVVhU3NWOHEzdGdUU09QTE5OeUlmSDdRejQ0MEg0VHo1ZHlNQTNrMVFO?=
 =?utf-8?B?ampJblFKbWJDWlZKcEdlSmdBbXUrY0NYUjljMStUQXYzSzVsS3p6TzQ3b0Mw?=
 =?utf-8?B?VXFyV0FjTFpkbjN1SGQyS2FiU3ljVE12NHFWRFpGa0ZqR050NUF6cURUOWdt?=
 =?utf-8?B?MnY2TnVuVFJWYzBOaktiOGR1Z29UdjJld24wVGVXYjJMMEVuRU9lWVBWVGxq?=
 =?utf-8?B?b0Q0Nk95cDd6REgxak1tU2E5Z3hYdkgrNUlzQUl0V1BMck5lN2g4aEkyMUgy?=
 =?utf-8?B?WHpwSWd1QjZORjRZenN0K0I5QXA0Q3hsOE9maGdrMmZweHZRVHBuNW9tOFBW?=
 =?utf-8?B?dDNIbCtMY0szTFA4K1dVNnhHNHo2L012WmJ5NUFDUGdhNE4wd1JmS2JSQVU0?=
 =?utf-8?B?SURUNlQwVklnOWRMS0NBMjM4RGJMdkE5RzZpdTFnenlvTm82L0c5aWhxSTBx?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1D275096F5B7540A8F210047768286F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9X287ABUbi8/68ROyrTCwSXqAtxjF/rxA/fK7R4ty0n/olPujL8nGHTOQ2Q6nAd9YtJb4CV9bGPxUWF1pUZ3oeQL/eI7eznI+mre5qKjnRQPNU2UoVAR8YCoqde5sxEq8gCi2dUPtU/rzCLAo9zvF5KqwWxluf4B8hfHIsLTURtLlfbhuV4Lu2p4X/0PP6myDZVqvT3kaRdaKrXQkPA18XtKwseGvoG8dd84//26BdgH1dmVbwtBJUX12dc1p6vCDzF+Kr15BuWRtziDhXgmF9dcTCP+NSOe2gOEoMNrwHDnr/GanRl/1lWMptPHHJcRGNDqmTPhwh+AH9VY3DmYx+djsjmhknGoMw014rn1X++Wxr1VduzoqXG3GgTPtGrttTl8mY+8geVsd3vDlV2mVM+qojQgbNTHl0ut5YSrWG0seAUx60HcrSMohJTIMpCcxS30MFOdP5duhDs1Ti/8c0ocWoM/aJyp4VJfXIKK6fZ8Hv699hfCysMmBBhjEmgv3y1HDRJ2kN9XooBPhxq3sn8OhYo/UYzTgQC4/0yKc2mj+LABtS/q/OoCruHrZ74glLKjQp/NkgWM1tY7SaCCV01nhCOVI+3M0I63N2PBmrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeeab0b-6a65-47c6-8e78-08dcd3571bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 18:17:06.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWl0dqSs+Y8l5LXsbzHW9/HSmHHnlRQvsMvXnseL+6CRwxqIpcHjZHb3Pg6LGFf1VL7U94yWXTVZjhujoxR+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_06,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120135
X-Proofpoint-GUID: aTiBclOLJY98ufp594yq0ZHcBbSfRhqZ
X-Proofpoint-ORIG-GUID: aTiBclOLJY98ufp594yq0ZHcBbSfRhqZ

DQoNCj4gT24gU2VwIDEyLCAyMDI0LCBhdCAxMTowNuKAr0FNLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEyIFNlcCAyMDI0LCBhdCAx
MDowMSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiANCj4+IEZvciB0aGUgTkZTRCBhbmQgZXhw
b3J0ZnMgaHVua3M6DQo+PiANCj4+IEFja2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJA
b3JhY2xlLmNvbSA8bWFpbHRvOmNodWNrLmxldmVyQG9yYWNsZS5jb20+Pg0KPj4gDQo+PiAibG9j
a2Q6IGludHJvZHVjZSBzYWZlIGFzeW5jIGxvY2sgb3AiIGlzIGluIHY2LjEwLiBEb2VzIHRoaXMN
Cj4+IHNlcmllcyBuZWVkIHRvIGJlIGJhY2twb3J0ZWQgdG8gdjYuMTAueSA/IFNob3VsZCB0aGUg
c2VyaWVzDQo+PiBoYXZlICJGaXhlczogMmRkMTBkZThlNmJjICgibG9ja2Q6IGludHJvZHVjZSBz
YWZlIGFzeW5jIGxvY2sNCj4+IG9wIikiID8NCj4gDQo+IFRoYW5rcyBDaHVjayEgUHJvYmFibHkg
eWVzLCBpZiB3ZSB3YW50IG5vdGlmaWNhdGlvbnMgZml4ZWQgdXAgdGhlcmUuICBJdA0KPiBzaG91
bGQgYmUgc3VmZmljaWVudCB0byBhZGQgdGhpcyB0byB0aGUgc2lnbm9mZiBhcmVhIGZvciBhdCBs
ZWFzdCB0aGUgZmlyc3QNCj4gdGhyZWUgKGFuZCBmb3VydGggZm9yIGNsZWFudXApOg0KPiANCj4g
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDYuMTAueA0KDQoyZGQxMGRlOGU2YmMgbGFu
ZGVkIGluIHY2LjcuDQoNCkkgc3VwcG9zZSB0aGF0IHNpbmNlIHY2LjEwLnkgaXMgbGlrZWx5IHRv
IGJlIGNsb3NlZCBieQ0KdGhlIHRpbWUgdGhpcyBzZXJpZXMgaXMgYXBwbGllZCB1cHN0cmVhbSwg
dGhpcyB0YWcgbWlnaHQNCmJlIGNvbmZ1c2luZy4NCg0KVGh1cyBGaXhlczogMmRkMTBkZThlNmJj
IGFuZCBhIHBsYWluIENjOiBzdGFibGUgc2hvdWxkDQp3b3JrIGJlc3QuIFRoZW4gd2hpY2hldmVy
IHN0YWJsZSBrZXJuZWwgaXMgb3BlbiB3aGVuIHlvdXINCmZpeGVzIGFyZSBtZXJnZWQgdXBzdHJl
YW0gd2lsbCBhdXRvbWF0aWNhbGx5IGdldCBmaXhlZC4NCg0KTm9uZSBvZiB0aGUgY3VycmVudCBM
VFMga2VybmVscyBoYXZlIDJkZDEwZGU4ZTZiYyBzbyB0aGV5DQphcmVuJ3QgcmVsZXZhbnQgYXQg
dGhpcyBwb2ludC4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

