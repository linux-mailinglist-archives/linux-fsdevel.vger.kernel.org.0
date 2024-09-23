Return-Path: <linux-fsdevel+bounces-29826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB397E75C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DAB21341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7F418FC75;
	Mon, 23 Sep 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SW3WLpz9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y1SrJf+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513C18F2D6;
	Mon, 23 Sep 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079405; cv=fail; b=pIU5UOjF0eL+kPD5yLUwicua1KL2sVM9cRQuSLZTzqUDTiks4kIOihowNxU0SMFi75tektXYJzRfkeaDn7VTZ+OHd0qFpvFh500RocBOVbtAZY7gQhyoYgRS5pwPcd4QmoA33Y/R/z+5Q+d2dYOYh0I9rpXkRRDX2B8qLf0UqJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079405; c=relaxed/simple;
	bh=VCi8+wj9yeloY18krWhs4op9OS/QMjF+VmpqfxvkESA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bS+T1dj1yDiFI15PtIS8Wal2AWqXMF0/NSHkrhTo+u9pyOr0nC3zB883DZtk+vINdbhEUix1GUk6sd7OrfxYdWaKNEMD7fa2xznKPfHu8VPGac/7oL1GoSoQaVcKWKHQupfA5TsSZKcQyLRmA/+4L61+V2HgZxNwFxYO0baL7tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SW3WLpz9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y1SrJf+M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7tuj7008323;
	Mon, 23 Sep 2024 08:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=0RCja1py24IzTmnlvDKGhnZ/eIJ2IMMESR7cFb/7+lI=; b=
	SW3WLpz9jUfDHmXMJMaksnlYT2Bi2uijG3AhygzmAKK+/VuWG4CQpC0w6I79sP18
	GhGw7R6JmS2ayTY5+yn6Y7Ndxa1xmuPtjMH+awrNj8xNXrjmZRRjhDrCZ5ItIDIZ
	8x5fmUSxK9vsBGNNzjTVTuuh9SLaO8qhPBolG9QWzm0UuwCtlHHNldZg9EdjeRkz
	J74X+VenoapvV3mT89+nddkrf0ExVxShRNjoCr5eNELfN4OSAvNhQdSpkDwwSX2u
	fiMwGGh/48k28k5CtYIezKmDuQdl28KR30CbK9maN6XU/SzpMNR9GI/7kbmZTx3w
	bSKnTcvsyoOZk1V6YkAOBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr1432f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 08:16:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7j604030906;
	Mon, 23 Sep 2024 08:16:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdqpx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 08:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZU34aqpbDWHYt7v4AyeulmY3Iazg+nQ7AlUlip+aY1P8Xx/hORtRH/DRsfdLyfXstyWnSfgpSagkPYWz1P5kPV5vrpek1UOeFkrcLnZA+OQfYQzp9BnJVc9HSlj8tYZmTiyqfhcoqCVowpZS895KA6/Rom3Gkq9mSanZN/jMDi3+/9tM+oMK0CPfNaKpaQ4uKOMZGNmV8slkUmx4uIE5g2kin8YKcJSRs9KsT67U9Nh2SLqhRkO3ZCaM1HAoprJolK8/x49ll2uQLxRSPvpuAEGnbaHElzGjyfAFhySMWAqbuJ2hbCBwAd9jV0titrWGBMNIvAhYZazwnQl3MRk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RCja1py24IzTmnlvDKGhnZ/eIJ2IMMESR7cFb/7+lI=;
 b=T/Y8aevLbTe3gRKxclEkycbb/g8oLpg/KFUGWH2ont8Pv2wsBjz7QdWMBF7v3BkM1IzPARkmHeDFbqvFzXYIiuyLK71ZtaPgGjeBx4OIjsCM26UxAajzrQ/MQ/5/F2wNE4ZBbfBtlSPunD54wUipzmWixpMknDFUeowK5F/CdcrBHTd2xGWwxSD43aVFfNCmT6vcjSAlnAJvGPcwQlcdPtZMvwJUzXi1Iw42f3n/Tyghl7oPc/YooFGxxGLm8ZRI3Btvonj9pvjICUteuA72d/2jNtQsst/1gktBEuzJGwNVaxaEFn+t5ZfqMC/avQrYjS4v73N9POKIKQhmDYPjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RCja1py24IzTmnlvDKGhnZ/eIJ2IMMESR7cFb/7+lI=;
 b=Y1SrJf+MeXhVEg76nn1g/j3RvhDULOOE/M74L4asY4Odf1IjhB2OGaHLu2tRXMSHc22wzUmp6bGKbkskStDIg/6ShP+PlUXBDoK3rnuxiRLVX7WjE9p+/W8cvlRZaTwwiKcgAIKi5sKjYFJhJDxXsSgB2pFAL0vUXPYutZWhUCc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7256.namprd10.prod.outlook.com (2603:10b6:208:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Mon, 23 Sep
 2024 08:16:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 08:16:27 +0000
Message-ID: <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com>
Date: Mon, 23 Sep 2024 09:16:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
 <Zun+yci6CeiuNS2o@dread.disaster.area>
 <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com>
 <ZvDZHC1NJWlOR6Uf@dread.disaster.area> <20240923033305.GA30200@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240923033305.GA30200@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d4b7fc-4a7e-443b-d6f9-08dcdba80525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3VvZDNPYlR1SXBhR1k4cThRMUd3aGMrVktEbkphd2JNbEpVUnl2NStBanpi?=
 =?utf-8?B?dWZOVUZnK3hJdjBZaFJHNEtvNWNOYU4zTERlWWRsbWxvdEl5VE1ybC9hdjdi?=
 =?utf-8?B?SzVmcFZPTHpDMWdzSk1oS0R4TEJYWWtTUXJnaGlZT3IxbFBjb1ZxazlqQkFq?=
 =?utf-8?B?QlVLeTQwazhEcGhhUWE0bHM2K3FodGNWSklYQVhvTlNmZkIwL3B6L3JnZ2pQ?=
 =?utf-8?B?RnorTXkyQ0p4VmpiWktBdEpXLzkvQkttckljOXFNU2hZZGViRmJQYzhLelpM?=
 =?utf-8?B?VlJNWmROL2RhV3Y1dTMrMGVycXlLSXIzREtlU2VLQWJGcW45eUFHMGpCWnAz?=
 =?utf-8?B?amtQMkk4L1dKR1QvcFVZMENLWWdQQ0tuZ1dFTjRxVHhTMjhqZzdGWnVUdEIy?=
 =?utf-8?B?YzN6bFgvZTAxTXZxQW9yVXhGOWRWMDJzN2RVTG9QaE1PTDdDQ1hOd3hkV2xE?=
 =?utf-8?B?SWt4VzlWck95eUdPSyt3eWNQeUp0Q0Y3Nk5iZnp2OXpsQlRwWjFUZHZYZEhT?=
 =?utf-8?B?ZUZSWnFZek5TN0pMbVhCUW51YVl5V0ZBWTJ1cGwwWHVzNUFBNkY4K2pVOWJs?=
 =?utf-8?B?ZjNSYzIyZkdqa2FSOW1CUWpQUEE3N3dNenpuR2VmbjN5Wi9Hc1Zna1RtTmxy?=
 =?utf-8?B?S2lBQWZyT21BN0tGcUwwdnhRZFNyOXRlRFB2bzRzWmdKdjh2dXBGZk1TWm9t?=
 =?utf-8?B?TDhoNlZPek56RnZ3MkJkemVrWFNYTitrRjUvRjJ3VTY5UXV6OGlvTE1mdzlj?=
 =?utf-8?B?ZFRYaWpseCtRNm4zM1Vxc1pUVTZ3MzNVdTVRY3Jrdkpaci95N3c5cHB4cTBS?=
 =?utf-8?B?Y21DM2t2Ym1WVk9qM001bnVqV251S3YrRnZKalpET0N4QmhKNGpkcFVhODFt?=
 =?utf-8?B?bHdCNWswMmtoZTN5ZVZmYnV5UU5pYUcvZzdyZUxkRUg1U2NDMlh3bE82UWU5?=
 =?utf-8?B?YmNOVjUreTE3L0xsdllrcmdFZ3FMTG5MblRnZUJEOVlQemdRMzRPaXEzL3hv?=
 =?utf-8?B?eW1CZklJZ3lBYmlkS1I3eVFaZXh6a2tETngzckduUEtaUFh2VXJCWnRmZkFR?=
 =?utf-8?B?TXRiczlCdVN6MHdaS2haRFdlYXVuSHZSMnE0Z2NtamVZOHpzMnpZMXEyT0Jo?=
 =?utf-8?B?azBlRU9IZCtkSzg1Zm5aUjVLQWp3YU8xSzJHSWladVc4YXR6M0YyVEt4Z0dQ?=
 =?utf-8?B?U3lZTmhQMkZGVmNWektJcjJuVGZVVmw2QjI3MVorVmMxSFJ1STNhVXhMUHpy?=
 =?utf-8?B?RXJCTkpXenM3cUNrYldMWVo5d1VSamJnK1d1V0NCTzJPYUloNkRPRytsV2RO?=
 =?utf-8?B?dVA3eDRhWEtiTTl3TGgweTlBWHBaL1A0OFp6RHV3a0FmUzF2bzB2NzM4WEtF?=
 =?utf-8?B?cGx5KzY2b2F0MnFSd3pTb1hPd2NNejNvdVkxalB0K3JBSUo3bmNJMXdvMVJv?=
 =?utf-8?B?UGJVb0Y0Y3ZlMVdFbmJ5dTN3UUVyZlFjRHUrcDE0WTBnT0ZqOXJqOWhLRFBO?=
 =?utf-8?B?dkJBTUp1T1MvK2szby8veEZIY2J6RXlSUlRTL3p1c3dETXl3VWVVTTBCMUlQ?=
 =?utf-8?B?UncwT3B0MUpPUEtZY2RGZXVCTEZsckRZemhDSUxXNVZFNGJJMG9ISFJUWHhH?=
 =?utf-8?B?dmtIZno4LzdMVTJQUlRoalRZSWdNd3VyU1VXamptNzNYSldNcFRaMlFMTW1P?=
 =?utf-8?B?WDdwR01XNGhMcjBMb2N3UVpRNnpuSUV4bDVSbEtSQlJBdlN4WUw0UEhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzhMaWVsRFhJUi9tWm45OEg5ZGw5RW9nV1hNM1lEMVBqbWk1NU5tVm5xckFa?=
 =?utf-8?B?bVF3SVdvSTZQcXU1Y3FHY2JReVczNS9iWFBIYXd4T3I3c3Z4cWhoRkNiaWp0?=
 =?utf-8?B?d2tDQzBFai9MYk9YL21vSkl5VVV1WGtDMnFlQ3lkanJTYUVtV3RrZmRmNmQ1?=
 =?utf-8?B?RmdGQXFJUTVYd1NCOU9ZYnRyVzY1YVczdHJadlhZSndzNklLSVhmNDduNjdR?=
 =?utf-8?B?N1dkWXc4MUdZNzJ1NmYyUTVqdUpGNURVNUc0QXc5bEtzSkNnb3VtSk1RV29w?=
 =?utf-8?B?eHpUVjJaSEdvUFIvZmhlYldQcGxkTTF6WHg2MzJ5aWEvTU9hREovU1d0Mjlh?=
 =?utf-8?B?V1hYcks3VXJQazhVeEhHYnkzS0tmYzc0aWlsVmgxbCtYVWYrVjZXTTlPNkxq?=
 =?utf-8?B?UFgxVnFxUlZBQ0hWLzhYdmpndk5vRzNXOXliMWVHYXIwWUZPUjBubUFOdytS?=
 =?utf-8?B?dnJqVlQ3aEJGR1BWTVVpRWxXbVNuNnY4MU10bUpXd2ZwTzdPUW9FOUNWbysx?=
 =?utf-8?B?UlNhWGU4UXV3VkRycUxJMnVyYnJyUS8zejNReGdsSDlkTWZFa1h2OWdtVzBu?=
 =?utf-8?B?TG5VRERrcWxKbU9SSG8yOTExUzBpd0x5WjRqTGNrWmpXL29mTTljNDg4ZUpQ?=
 =?utf-8?B?ZDlRSG1VMTRwRTJtckE5SlJ5dDdINCs5WFhMRHB3c005c2JaUGNwNmFGcUxu?=
 =?utf-8?B?OGxiOHA4azk3NDVja3NxNGh3TDV5WGtmUVJlZ25iRWo1SE56OTVnMEhZbHZW?=
 =?utf-8?B?dDBKY3Q4bHpRMCtqQ0U4OGswM0FrbElqa0JuT245d01taE5STGFZQWlhbmN1?=
 =?utf-8?B?d0pkdzdjYTd6eERWRUdmMDJDbWxnMGs0V2Z2cnljUTJhc0VOZklRUDZxQ3FR?=
 =?utf-8?B?V3dnbDdDdHppV3p5UTk4SWhmenJtaXhZQmxUVzVBK1RzUHAvTFo5a2dvclYy?=
 =?utf-8?B?Y1Z2cTl2QTlCdGZXenFMdUNtaHQ5MVR5VU9kQ3NmRCs3dVg5RnJxZUxMR1Av?=
 =?utf-8?B?a2lERUZNTks2Z1NSVTY4VklTbC9objM1cDdLTEsrNWhRY0t5VHFSTmZYQTNG?=
 =?utf-8?B?eDEwRGFGSmdlcXlYYTRTT1QyZGNWWXp0dm5UV3RlZjlkZnp0Q2cyR05ITjVx?=
 =?utf-8?B?U3JLUzlYKzJ4KzJsTGVVcXZKUHN3cnpkS2hOUVltY1NWTVRRN3RZb3gzUWRL?=
 =?utf-8?B?aEdmd2pWSW9LM3cxTTVrWm9Fays4WlUrT1V5VTdRNzd4Nzh1WDh3aXJGYTdt?=
 =?utf-8?B?Q0ozODRzVzhYMEZQU0tPQmtOMHRjNVVCZStJakZwbmkvbVI1OHJwUVlFVVMw?=
 =?utf-8?B?OU1wZW5JMGZOZUZxaTBtL3loR2pKbVR1ZEthOXNZQ1BZdXN4cml3Mk54ZVRU?=
 =?utf-8?B?b1FoanZvUzBoMXAremUxK2R6K00wUWJnSDlQQlZ6UFVmQmRWQ05EL2NaZnls?=
 =?utf-8?B?T1hVUzJzcUZaaG9EemtnbjEwekc1VGVXeHYyaE5GRWpWR2ZHZmxnT2lSYndk?=
 =?utf-8?B?UG95VWpEejU4S0Q1ekY1V21tVndlVzh4ckZ4VlJLczhoR0hXRGJYM1FjS3R3?=
 =?utf-8?B?RTI4VVpZUG9MT1Y3TU1PL3ljMmFxVUF2QXNZWkI2dE9aVGxKYUdGUlZmV0lq?=
 =?utf-8?B?eWpJZW1ZUDhDWXRBMndDVm1Cb3Fvd3d5YjJvaXNSTjdiZWJtazlGK2d4cmVX?=
 =?utf-8?B?eUI0NkFIejBrUjRnbEl0ckcvVEN4YThiVkRyUk5ZU0lPandCMDFkS1pzM1Ax?=
 =?utf-8?B?RHRqaUl5d3MzOFpSSk40N09jV2ZhS3Rab1QrM2ovUnJyQUVrMnNvVE9EdUVC?=
 =?utf-8?B?NnRjK3NaRmNxZDVGYVpvWDB0UnpUeWJZaThoeks4a3ZLamZjKzRFMTdobEFI?=
 =?utf-8?B?cU1YQ1hwMTJsa1FselYrdHBCeXNreXQ0L3lJTWMzVjRhTk0wNW5zYkQ2eHlu?=
 =?utf-8?B?WGJIck8vY1NzcVNncXNXZ3hxU0IyTndPdlF3b0FDdHRySzhGRkZjZHEvT211?=
 =?utf-8?B?MFEvTHhjQmlrOXFvbEpaL3ZObXU3Z3hxNXMvZ2piQThrYXY2QjNBSEpXVm9N?=
 =?utf-8?B?S096TXJZajFQTjUvQTgxV0J2S2lzOE80RnhmL2g3cFhXTHZlRzh6eEV6dWJ1?=
 =?utf-8?Q?f/vgKa87xxmCxt/XaPkIl6MBm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	teURxd/DcbEYrmjIuIpg11nuVnCNWZvEBCm181sP0i2Pl8psy6UKImRG3aV7iqoAfbDh0mpMP1UfVoxVMVjh06roh/3A+wNHE9lZY1VFJuUyCY5V5qmx5cyb1TvSfcfb/VBXG/N1902ZuNpDCfcUbwp7TceohM/h7diIVEWSiLHl4MPoYXmrF6qmFA4yQCKhUnwxIY7MzPHCKVqzoemD3OOOkruxdS5EJaLteA0PPziiNNHGXN4/UfdKsYjtrEAX5SZjnJnLJP+fMdbmkCU2QAbDJBEUH0f92g+noE2dIgykYRbwRDuhmT8rLGgFExHs5zUKv06nmcxXg0oWjO7pJQUWvE9efdWNw92uZHxPccX01WH3qVhqFvvyiq6T1hSNRviQBkc6+VZpq5Gz5rqbmYFBNXMwS0hdBsUjPMbozLzereehN4fYcQwV61NA32Ov2TzuX+mASAyWVqfkE8WTANe464llBnlaPEXFEmp0ONeeeju5We7QLlyOCW0Fnj8xoy9yJjWgCyhLtebx+F23qnS+CKxC6wwnHgd+AE598q2E0eJ9Y/7bFd6LPE8GkGhMOgp205iOh/3BCADsWRo9VTGLILsNerSan0qRNyaROwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d4b7fc-4a7e-443b-d6f9-08dcdba80525
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:16:26.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MRtHRWt5NOS89iWeHRcjByD/c9Pdb7yFCUcTDMe0onYgkyebxHVOz+4UPiFida6ImqQ40UQrn5EFkCgTpfPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230060
X-Proofpoint-ORIG-GUID: 7IoTKgt5Gz-1FRASDC951-x5GyfS5JaG
X-Proofpoint-GUID: 7IoTKgt5Gz-1FRASDC951-x5GyfS5JaG

On 23/09/2024 04:33, Christoph Hellwig wrote:
> On Mon, Sep 23, 2024 at 12:57:32PM +1000, Dave Chinner wrote:
>> Ok, but that's not going to be widespread. Very little storage
>> hardware out there supports atomic writes - the vast majority of
>> deployments will be new hardware that will have mkfs run on it.
> 
> Just about every enterprise NVMe SSD supports atomic write size
> larger than a single LBA, because it is completely natural fallout
> from FTL deѕign.  That beeing said to support those SSDs a block
> size of 16 or 32k would be a lot more natural than all the forcealign
> madness.
> 

Outside the block allocator changes, most changes for forcealign are 
just refactoring the RT big alloc unit checks. So - as you have said 
previously - this so-called madness is already there. How can the sanity 
be improved?

To me, yes, there are so many "if (RT)" checks and special cases in the 
code, which makes a maintenance headache.

