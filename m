Return-Path: <linux-fsdevel+bounces-76883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIU3K8aNi2mGWAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:57:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D911ED10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F26E302F24F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9C32F742;
	Tue, 10 Feb 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dXE/j0ah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7E202F70;
	Tue, 10 Feb 2026 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753463; cv=fail; b=rHj4KLMY84k2C6iOCcI5UX/gReRNk80MSKhdJCc4BMASc0NWRn5nZJfVvDHPZ1aMGI++JaSF8IrjbBpdyo7SIQ64ZTsawd1Rl7Y+9ViAM/bkJvEJoTXrOCyWafI+Y4vikjxVzQ8MIllzSIj0ZwlV7Xi2YDs0gHjcGT2f8wrCQoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753463; c=relaxed/simple;
	bh=3fcBxgzUQ+ut8Q8HbNUmYX5j2yVHobkOXh/m4CreN+k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HsG5PKrzt2IsjvYvGMkQ+NORx4Xv0Q2rXv3rVyvNl5n+Iin3faGjR9Z8KO76piOsRxu+NkMdxAVuvwMWN9yWIzFuKs0LS1J4EfuDN3AJaIsU+zTTRX1ui+Lry2yx7VeHe0KfyRkbv5Vuw1BX4ph5Mnb69uDRKDidKBF5dCdrf1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dXE/j0ah; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AA2plT470140;
	Tue, 10 Feb 2026 19:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=3fcBxgzUQ+ut8Q8HbNUmYX5j2yVHobkOXh/m4CreN+k=; b=dXE/j0ah
	doyJdNhN9jOKKDnkv5g5E5xJN9hhMLVQ/fAUGfeGgNMur33praPNVe6/8AiePK5b
	VoeD74OO0jJz2yi/RrZW4s/p/jmVx5ehDW9pBedXQkaeSIRCEPqBcu378lO4kbSS
	UspY3IOVHJ7yNUMmQz59vCNV7vZYGwp1rGNc46YL5g6h3J0cR+7oO7P7aoYxL018
	qdAslJ3jP3cz5vvQz062ZLulslmyvbUmCypvyWWI7kSuqa+l6vcDNmq1jvWzHVpV
	udAKu/7G0M5MKCvcqk0CmEd7zwnfFZ0GLeIOeX04CuRcaqdHBks1kSiOR9cP/g4Y
	raz22id6AFJIPQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wuwcm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 19:57:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8kQ0Erz8KC0fdZ0QHxOdZBmAxWXDm26AZ8VbckPRqcCD8ceZLXcMa9evOgnvcZH138KH9dgsyTG56o2jdgdCQOBVGMAJob4kdEGP+3ius8i50gJ7Mcyiq82l14K6FemF5cJB4JA31ybc5bY+0I2E5DbLMH7fiHhZJ580ibqnf1JGgXOBEUWGNXFLIeedyQcjEnCcMyibtsj8qW2VoIgVGgE71rTiXmBc2RX4tMUxuBvBudXfPrXPuTXzRdShJAnAdgLHH4QS8RX6OlcH+9G5vdHFChiPWV3ZcIGJf6OEhrKhRUPQ3YB3YfEsFMqD5AwrhZxk+xbDNraUyTy4OeZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fcBxgzUQ+ut8Q8HbNUmYX5j2yVHobkOXh/m4CreN+k=;
 b=fnCIDD2jjvd3Oeb17Nph5yfPyeqrgGckmaAYZjXd3V4TgBVxc+eTxL2/GIr+cH+MC1KRQ1brIHVwCGcRjLal8sNqlllXAnR0DpTp+GuwrRCZO4TCb0X9hQdGqhw//JGkBNj+KlIEf2P6jIHyqIRm2jCdNLnh/3DFwm6FfyzHMSKMDYRBWeoLVRlXZO8qA1jzYPVQiuCqz+TYVYKrllXOpWj0/IVM2eHlUQKu85PlOW6aOCq65gDjeiTZf/tqXPFZEARGYsQoFyJEYIQxRtk+9LqAjR3OLdTnWu6ttKFXZXKNaCKSRyV2sF1i1fFYl3NqeM6VLzyqbvo8GUNjuyeN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6307.namprd15.prod.outlook.com (2603:10b6:610:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 19:57:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 19:57:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "21cnbao@gmail.com" <21cnbao@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library
 in Linux kernel
Thread-Index: AQHcl6AqIZ7MB3V3T0Kp7gdR9aR7gLV6LZWAgADELICAAFNqAIABGo+A
Date: Tue, 10 Feb 2026 19:57:31 +0000
Message-ID: <3d3bed663019bf93c0f26baf68654568ce8d1935.camel@ibm.com>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
	 <CAGsJ_4wgG6-FvDbLw4De0r_vPO1fTH_69A2VyntabmS6H5ZM8Q@mail.gmail.com>
	 <83e395c84c9bfa52f1abccf12ff6d39547d6bede.camel@ibm.com>
	 <CAGsJ_4wymvTimJrKoq1=PRmX6BMwKp9pRH62cQ_a06Avms-0XQ@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4wymvTimJrKoq1=PRmX6BMwKp9pRH62cQ_a06Avms-0XQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6307:EE_
x-ms-office365-filtering-correlation-id: 93320a3b-abde-489f-a8cb-08de68dea094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1NuQWFLZDAzYmpGY1N6c2lNNHlkemt0VHdqaGJWeGRLL1h2NDVaNnRzRFRL?=
 =?utf-8?B?ZW41Y3NGblBGdHlaSUNhSEZUWGlMOEJ5cFZCY3JCOEh5TDhJdEc5T3c4aTZH?=
 =?utf-8?B?dnliTEZpSkU4SkIySm9vVlB0bmVpN1R1d1hLcHFBUmJNcnZoQ3NMMHFkMHd5?=
 =?utf-8?B?a3hKNllSc3R3R3IzVDREOENnamIySVFYcVlGNVVUWU43cTJ6S0J1WDUxZDc2?=
 =?utf-8?B?Uk1TTmhXNUs1REoyMjlHNHlJYXBjMWlKc0dldkk5MURMdzdZNHpkeFdiWU5R?=
 =?utf-8?B?VndzcDU0ZDZVcHVZQWtRUFVhZDdKQmEzSk1tdTNIaS9nSHhVMVNKKy92cHNS?=
 =?utf-8?B?RUF1RGduZUNkdmRFMGFRem8wQkMzLzFUQ0wyQy9UTFUrUWFTV0gzaHY1ajQ2?=
 =?utf-8?B?cHZ3YVZaUWcweVQ0eVlBYllvVmY4TFpsUWQwalhSbFBQc3FzdncrKzRmb0pj?=
 =?utf-8?B?OTZibjgxbGVVNTR4KzFCc2dhRHhmSGU0R09Db3FGNFNXT3dKWURPLzFUNFc2?=
 =?utf-8?B?c3NUNkFETnJ4c1Q0KzlRN0JKc3JoWm1oOXRWUU1lRlJzNm5zRXFZZXpwbjdZ?=
 =?utf-8?B?TVU3a1AraG96WUNmQmdCVy96RytoL0czcWFrQkF2VGtuM1BRMWRkQTJVSXo0?=
 =?utf-8?B?ODF2QzVUYjhEaEV4a29qZXZSUHdHUGcwaGlHSTJCVUoyRythSE50UEdBTVJV?=
 =?utf-8?B?aDNpcUx6VGcrMnAxUFRtejZMM20zQXBJcmdzTmwvNTlqZVhRKzNUbGhxa3Nq?=
 =?utf-8?B?TDhqYTUxTFFtREt1NnErZGp5Y01qNVZFNVVOZGN4RWhIbG12bXhHM3pJMzd1?=
 =?utf-8?B?eFEwS3lmdWtLWTZXOEl2Y0dUck1kOXdSRTBrb2YyNjU2aEUvaTRPV2ZENFZX?=
 =?utf-8?B?Tyt4VURrSGpoQUQ2M3NDczlDRkdjbmZYQXBnT2E0OTVPYVV2bERWL1VRQkRB?=
 =?utf-8?B?eXBKbWl6MjI3cTBGa0hPeUpGeVV2UkRXS3NWQStQRllXT1BxYm1mVTZQZHdt?=
 =?utf-8?B?dFl0WUNxejhCSWxJOXQvSG9Nb3pIQzVZWWV2Nll0WHN0UzZPVTlLeDVMQ2Y3?=
 =?utf-8?B?UnhzMi82ZTcyVS9iT2pnUlJuN3UzdURGY0JYdFBIYTUwdUQzbFJZV2tRM2h5?=
 =?utf-8?B?bmFJYVpGVHdiY3ZYYytaZGkxVTdoWnVxZmJDTEc3bis1dXQvRVRUTExZNTBS?=
 =?utf-8?B?SFkybUY0SnA1YldyU2tJNWlYNG1uYlJYd2VXNDRQS0hTUGxWb1N0ZjA1VU5S?=
 =?utf-8?B?ZmVnbk5IcXprZnF1RWdQSEhPbXhsSFpNRHNaaWhZUHBNYUtLMnI1emVOcERu?=
 =?utf-8?B?OE9aVmlBaWFFOHV6RzgvRUFQMm1HU0sraEpoWFdEYXdmazdrS3pGZytGNmNk?=
 =?utf-8?B?MFhvRnlzV2o1aitsK2QvNVJDUkFXM0VSZGllcUtmak4zQTlpSUNid1hWbzVn?=
 =?utf-8?B?TmR5STRZZEV3YU9tblFsM29xbi9vRjJwRHA3bDNCQkc1QWs0QlBtN0l3eCs1?=
 =?utf-8?B?c1BrZXNYa0xkVWFNWGU1OFdiUjRnQ0U5K29QN1NQcVRLQmx3ODV2QmtrSkpS?=
 =?utf-8?B?ZEhlaTFnVGdRb1dxOGdPeS9aSkJnY015MC9FVTFUa3RCYjR6RGZIUlRHSGJr?=
 =?utf-8?B?OCtzeDRkUEtuMkV1MzN2Sys2SkFwVEE3TGxLM1N6TEdDcnMxeDl0ajB5RnlZ?=
 =?utf-8?B?bGlIbnAzMGcvQlJNWEVybjN2N0JKRmxXMG80V0FxUitJL3R4aWc0M3J5aGg4?=
 =?utf-8?B?b3l2OHJPUXRZMGMvYk9ybXdIK3VWWXVGUGNKL05QZ0dkM2ZTaXAzNTdEU3Fv?=
 =?utf-8?B?Ykp2NTZLUlprN01uTG9GanZYaXlHMkFUM3ZYWnI3WVJKNkdBemZKTlFKYTQ5?=
 =?utf-8?B?Nk1DWUhHaGsvVVFJaDVYbVp0NTFTRS8reEtnenlETElGYUtoZlRDZnFCUXdh?=
 =?utf-8?B?ZldIOXhVaFRzcWNDdDlyUmlkcWxxOGFWV21EZitLTmhYQnNMOWl6V2hmTWR0?=
 =?utf-8?B?M1lPdlR6OThoQ0F5dWR1YW9WZXRNQjN6MXkzRGtLMzlSWVBMMWkzWUZ0aVRZ?=
 =?utf-8?B?eldKS3RvMlBRWXhyYXhvMVJ2OFE4VjkvR3hTM0xMS00wN1NsUGJKRWF4N3VU?=
 =?utf-8?Q?KAxlnY/c/aOWJHR+FnFUuM987?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTNmcVNsM2RsODdPeFIxcTlYQm9aLzVMY1hVYVVHMWFKMEhtWHRjZHdpeFho?=
 =?utf-8?B?VEpURktjMFQrSHJzRjREdHVLNHdTd0lDdkV5clFGL0hCUzdZUitqVnBDRitB?=
 =?utf-8?B?a0VnM2RSeXRBWCtteVlkdG1WN3ViWE5IVXo3bUYyRVN1OFJTanN4YVluWWVP?=
 =?utf-8?B?eTZuZ2VLR0F4dml6Z296Z0JrMmU3Sm45bG4yM1N6RkhnWkFQb0NnVE1MZTR3?=
 =?utf-8?B?TjZ5N0dBczF6TGVQcmVyOGorMGdzYkxlbE9BMTRLZkZJbktMc3E4YytNM2NP?=
 =?utf-8?B?aUMxaUpMejNsdWk0N2lmd1orRmpCdVlVa2x3VnRrbnNFWC81cUVNd3FFMUp4?=
 =?utf-8?B?VHV3RUwzQ3pnT0V0TjdjOW9BaUMvcnU4Q3MvS1k3K0ZNbWJSWFpUTGZJVVRj?=
 =?utf-8?B?M2cxS2JiNFRLRWw5OFM5SWhLc2s5S3lhdEMvNEI0bExZSFl3RjBPNmRHSkJv?=
 =?utf-8?B?ZmlPWUdXQmxyT0xOWU9wYlk3VXU2RXZhZUZROEdkdlpkQ2lWNnpqYWtBSWJT?=
 =?utf-8?B?WU1Qdy9sQy9OZ2h4UzhFRFZjOWJRamJPRXI4d2QvQ2NtbGVtWWpQc253L3Fx?=
 =?utf-8?B?MjkzLzI4c1VYK01JbHN2N2dCYWhPSDBTMXZHMjRHMTNYMXhDMWdCZXlNUHBH?=
 =?utf-8?B?c3A0UExnRjVYN0VuZ2llT1JFZUZucXowdFFSb1daZnllVnhpekhZdlYwckxm?=
 =?utf-8?B?c2JQM29rQ0V2R2gvNEE1dXZkUXhnckEyUE1HTCtueXdWT28wYUFFeG92TzMw?=
 =?utf-8?B?QkFRMzBUQWxPVHhTMGpUZkFkVjRwNGdQenYvNmRqNjJKOWt0YUhRQjd2MlY4?=
 =?utf-8?B?MDdNZWlRbEhtVVQ1eHc5UWdpcUZhd1pQMmdpYWh4VUtEbEtYd0xHWkZSM0xC?=
 =?utf-8?B?Z0FFTURVaDFlbEU3Ym1HYUtGR3RiVUlSN3owT0ZadlgzaWxPVStXRk1hU2RY?=
 =?utf-8?B?QVRpQmVkQXhWejA1V2NLREoyaFdiN2xTQm1ENFdNQzdJK0l1OGdpNVVhQ2Y5?=
 =?utf-8?B?V3JXa3ZzaTVEOUsyb0dkb09adnZGL2svOXdSZ1ladC9VVWUzekVtUWhwc3Fv?=
 =?utf-8?B?eExxL2pMazl5NVZTMWtFNHM1UEhVVkhtSFlHTFBEalVOTGNsY01DN1BmU0NR?=
 =?utf-8?B?dHZLNmYyNXFoSS9kcHl5anNjWTgyRmpFd1BKU2NmZ0FPYXNpaHBuQzBuT2dC?=
 =?utf-8?B?NlNPVkY2bk8vOVBiSTB2NXBXNUxpM094REJmbytZdGN2OWdMVUc3MlYvczU1?=
 =?utf-8?B?U3hLUHhGMmxrZVNFUGJpemFVQVVqeWdGS004WFpBZ3lROHpBOEhlb25nNXds?=
 =?utf-8?B?Z0lWdFRzMU9xYXhpUDlja2VTcXpIVXFNNjFxT1pvRzgzN3ZyVHZtQWNzT3BR?=
 =?utf-8?B?TmVHQ1NFRGRmT0NMRnpQc0UvL2VzNkE3TkorS2tzRlZjY0IxU2ZzN1hXV05x?=
 =?utf-8?B?NFkzQlpUdGpQZFNKaFpVOW5LSnNzT2hOZGNIRXByUzVyVTlaV1A2YWRwVDc4?=
 =?utf-8?B?dHVwVmN1THBxTnRvSTBpL2QvS0ZDa1F6QjM0cUZScGVrSVhhemJ6OHN5TC9Z?=
 =?utf-8?B?alNveEJZbHh0MjZXUHZwVWc3UENDMWV0dUovYmw5THhjd0cyVWVpQ1IzVytQ?=
 =?utf-8?B?M0ZWelFTOVo4cVpUZ0lQNFdvYk1lbG4zU0VOZ2RGWVlWdDI4NDdMOFJERW5O?=
 =?utf-8?B?aWMwQVgrdFJCc1JsajlLcEFMK3VsQ0hvSG8ybzJtenVsaEJTeU5TbHNXZ2dp?=
 =?utf-8?B?a0pieUYrWThvTzFwaUVwUFo5U2orYk8vWEUyeXFUaythNHVKZFh3dmZWUWJS?=
 =?utf-8?B?cjczYUp0eE45TTh5RGJ6N3JWUUZGaWRFZG1QK0YzUEF5QnkzZ21GYTM5WHJN?=
 =?utf-8?B?bHkzYnlEejRKQ3B2NzVGQTdqZnppUzU2M3VVUjA0N0tzaGYzVDhpQzJLUUlY?=
 =?utf-8?B?ZUtsVmliZWloSkFBdzAzVlVjUldjclEwTEp4c29Ncld6Vk1COGNTVkx2amQ1?=
 =?utf-8?B?VHF2UnVyRkltV3cwQ2ExR3ZwbVIyMGVJV3JPbWg1MFF2d083WnZWemVsZWEv?=
 =?utf-8?B?b3RMR1NwSTZYek03UjUwZ01xNnEwbG41dXBWNU10VjJmZy9JZVg3V1AvTHBz?=
 =?utf-8?B?M3Nha2lNSDFLcXVmK3ZCT3c1MWYwVUNXcytEWnR4cmhGNGtycUFMY2ltUHoy?=
 =?utf-8?B?aExJcGJIb2hUSDExKzBTaVN6bUd4clZ3OVhSMWpLRENraG9VTW8zUUhKbzhG?=
 =?utf-8?B?MXB6QS9yVFVDdVM3elFPWklxOG1yYVcwdW0xV2hSL1drMy8rZlptb3BmUFoz?=
 =?utf-8?B?eCtuYUVRVkVTUEF0dGJnN1hNanRHaStaTFMwMk41WVdZODZJcW9DVVZhaWlJ?=
 =?utf-8?Q?OV2rZgf/qf36X4qZMYfL8iGEnQSzkyt5tB5Fx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE310BDD80F594F968568D68951C034@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93320a3b-abde-489f-a8cb-08de68dea094
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 19:57:31.8342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnSmeDrZaT6rHs3b+H8R/AvlpwsZQdyLnx+jr6hpYxJBN4Gh9onoh0SdVNpoFsyDW0omNwiwqjIRluBoEJ3BRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6307
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698b8daf cx=c_pps
 a=3NFNipLq04N0pvkhkOyhzw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=VnNF1IyMAAAA:8 a=Joeocm82yR4SdU8WKTwA:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: P_zqRWK8DvWqJdQS7amwzMJyWfSFqALh
X-Proofpoint-ORIG-GUID: juG86OVMsKx5pP_ph2VrQDL66fCpWJ2X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2NCBTYWx0ZWRfX7DfRQUJNwm3b
 Ele+A1EGvgIuZhP6u7mbnMbD1OWWuIB/j5t2rjpjfDrEhP759JGolkfweDH1HrEBgX3/31p7JyT
 Hwq5djRxPNulanBD9fG44IT6gtLxAo6ZsTwe7ZCr5xSNwpZaMaExOkAy+mWpSh1dlbqwWB+HXCD
 8B3NRA9uizr72yq+bzen1V61/Kkg5FUcfPPRTy7wsjmpSCuOdOERhHdTUOoNaaXWO6JCdvzpJ+Z
 2C6qcG1a4aYexP9R1HRv4uzKW+lk2ZToDEpO4pJCOF2mJPTx38M/RRMwyT+2yfBfM3uItCWTsa9
 vwa1jJFE0lyBoHMIuH/uqdIBGYTP45BUuOZdiGVGz8PP1TYCOME5D1d47prc+kCD/wCUvZaltQg
 cyb3tzSeL5rud48WQN5MRU2cL3JKTfk3D5QtPsjTvjnDP7mtEkpCqmxe57mE349PQUBqKQBIrIC
 /hlM16moa1Xo2W/72Bw==
Subject: RE: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76883-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 523D911ED10
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDExOjA2ICswODAwLCBCYXJyeSBTb25nIHdyb3RlOg0KPiBP
biBUdWUsIEZlYiAxMCwgMjAyNiBhdCA2OjA34oCvQU0gVmlhY2hlc2xhdiBEdWJleWtvDQo+IDxT
bGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIEJhcnJ5LA0KPiA+IA0K
PiA+IE9uIE1vbiwgMjAyNi0wMi0wOSBhdCAxODoyNSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToN
Cj4gPiA+IE9uIFNhdCwgRmViIDcsIDIwMjYgYXQgMzo0MOKAr0FNIFZpYWNoZXNsYXYgRHViZXlr
byA8U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEhlbGxv
LA0KPiA+ID4gPiANCj4gPiA+IFsuLi5dDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgY29udGludW91
cyBsZWFybmluZyBtb2RlbCBjYW4gYmUgYWRvcHRlZCBkdXJpbmcgdHJhaW5pbmcgcGhhc2UuDQo+
ID4gPiA+IEl0IGltcGxpZXMgdGhhdCBrZXJuZWwgc3Vic3lzdGVtIGNhbiByZWNlaXZlIE1MIG1v
ZGVsIHJlY29tbWVuZGF0aW9ucw0KPiA+ID4gPiBldmVuIGR1cmluZyB0cmFpbmluZyBwaGFzZS4g
TUwgbW9kZWwgcHJveHkgb24ga2VybmVsIHNpZGUgY2FuIGVzdGltYXRlDQo+ID4gPiA+IHRoZSBj
dXJyZW50IGtlcm5lbCBzdWJzeXN0ZW0gc3RhdGUsIHRyaWVzIHRvIGFwcGx5IHRoZSBNTCBtb2Rl
bA0KPiA+ID4gPiByZWNvbW1lbmRhdGlvbnMsIGFuZCBlc3RpbWF0ZSB0aGUgZWZmaWNpZW5jeSBv
ZiBhcHBsaWVkIHJlY29tbWVuZGF0aW9ucy4NCj4gPiA+ID4gR2VuZXJhbGx5IHNwZWFraW5nLCBN
TCBtb2RlbCBwcm94eSBvbiBrZXJuZWwgc2lkZSBjYW4gY29uc2lkZXIgc2V2ZXJhbA0KPiA+ID4g
PiBtb2RlcyBvZiBpbnRlcmFjdGlvbiB3aXRoIE1MIG1vZGVsIHJlY29tbWVuZGF0aW9uczogKDEp
IGVtZXJnZW5jeSBtb2RlLA0KPiA+ID4gPiAoMikgbGVhcm5pbmcgbW9kZSwgKDMpIGNvbGxhYm9y
YXRpb24gbW9kZSwgKDQpIHJlY29tbWVuZGF0aW9uIG1vZGUuDQo+ID4gPiA+IFRoZSBlbWVyZ2Vu
Y3kgbW9kZSBpcyB0aGUgbW9kZSB3aGVuIGtlcm5lbCBzdWJzeXN0ZW0gaXMgaW4gY3JpdGljYWwg
c3RhdGUNCj4gPiA+ID4gYW5kIGl0IGlzIHJlcXVpcmVkIHRvIHdvcmsgYXMgZWZmaWNpZW50IGFz
IHBvc3NpYmxlIHdpdGhvdXQgY2FwYWJpbGl0eSBvZg0KPiA+ID4gPiBpbnZvbHZpbmcgdGhlIE1M
IG1vZGVsIHJlY29tbWVuZGF0aW9ucyAoZm9yIGV4YW1wbGUsIE1MIG1vZGVsDQo+ID4gPiA+IHJl
Y29tbWVuZGF0aW9ucyBhcmUgY29tcGxldGVseSBpbmFkZXF1YXRlIG9yIGxvYWQgaXMgdmVyeSBo
aWdoKS4NCj4gPiA+ID4gVGhlIGxlYXJuaW5nIG1vZGUgaW1wbGllcyB0aGF0IGtlcm5lbCBzdWJz
eXN0ZW0gY2FuIHRyeSB0byBhcHBseQ0KPiA+ID4gPiB0aGUgTUwgbW9kZWwgcmVjb21tZW5kYXRp
b25zIGZvciBzb21lIG9wZXJhdGlvbnMgd2l0aCB0aGUgZ29hbCBvZg0KPiA+ID4gPiBlc3RpbWF0
aW9uIHRoZSBtYXR1cml0eSBvZiBNTCBtb2RlbC4gQWxzbywgTUwgbW9kZWwgcHJveHkgY2FuIGRl
Z3JhZGUNCj4gPiA+ID4gdGhlIG1vZGUgdG8gbGVhcm5pbmcgc3RhdGUgaWYgTUwgbW9kZWwgcmVj
b21tZW5kYXRpb25zIGJlY29tZXMgaW5lZmZpY2llbnQuDQo+ID4gPiA+IFRoZSBjb2xsYWJvcmF0
aW9uIG1vZGUgaGFzIHRoZSBnb2FsIG9mIHVzaW5nIE1MIHJlY29tbWVuZGF0aW9ucyBpbg0KPiA+
ID4gPiA1MCUgb2Ygb3BlcmF0aW9ucyB3aXRoIHRoZSBnb2FsIG9mIGFjaGlldmluZyBtYXR1cmUg
c3RhdGUgb2YgTUwgbW9kZWwuDQo+ID4gPiA+IEFuZCwgZmluYWxseSwgTUwgbW9kZWwgcHJveHkg
Y2FuIGNvbnZlcnQga2VybmVsIHN1YnN5c3RlbSBpbiByZWNvbW1lbmRhdGlvbg0KPiA+ID4gPiBt
b2RlIGlmIE1MIG1vZGVsIGlzIG1hdHVyZSBlbm91Z2ggYW5kIGVmZmljaWVuY3kgb2YgYXBwbHlp
bmcNCj4gPiA+ID4gdGhlIE1MIHJlY29tbWVuZGF0aW9ucyBpcyBoaWdoZXIgdGhhbiB1c2luZyBo
dW1hbi1tYWRlIGFsZ29yaXRobXMuDQo+ID4gPiANCj4gPiA+IEhpIFNsYXZhLA0KPiA+ID4gDQo+
ID4gPiBEbyB3ZSBoYXZlIGFueSBjb25jcmV0ZSBleGFtcGxlcyB3aGVyZSBhbiBNTC1iYXNlZCBw
cm94eSwNCj4gPiA+IHRvZ2V0aGVyIHdpdGggaXRzIHVzZXJzcGFjZSBNTCBhZ2VudCwgaGFzIGRl
bW9uc3RyYXRlZA0KPiA+ID4gbWVhc3VyYWJsZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgb3Zl
ciB3ZWxsLWRlc2lnbmVkLA0KPiA+ID4gaHVtYW4tY3JhZnRlZCBrZXJuZWwgYWxnb3JpdGhtcz8N
Cj4gPiA+IA0KPiA+ID4gU3VjaCBleGFtcGxlcyBjb3VsZCBiZSBpbiBzY2hlZHVsaW5nLCBmaWxl
c3lzdGVtIEkvTywgb3IgbWVtb3J5DQo+ID4gPiByZWNsYW1hdGlvbiBhbmQgcmVhZGFoZWFkLiBJ
IHRoaW5rIGhhdmluZyBhIHJlYWwsIGRhdGEtYmFja2VkDQo+ID4gPiBleGFtcGxlIHdvdWxkIGJl
IG11Y2ggbW9yZSBoZWxwZnVsIGZvciB0aGlzIGRpc2N1c3Npb24gdGhhbg0KPiA+ID4gcmVhc29u
aW5nIGFib3V0IGFuIGFic3RyYWN0IGZyYW1ld29yayB3aXRob3V0IGEgY29uY3JldGUgdXNlDQo+
ID4gPiBjYXNlLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBbMV0gaXMgdGhlIGZp
cnN0IHN0ZXAgb2YgZGVjbGFyaW5nIHRoZSBNTCBsaWJyYXJ5IEFQSSB3aXRoIHRoZQ0KPiA+IGdv
YWwgb2YgZGlzY3Vzc2luZyBpdC4gQXMgdGhlIG5leHQgc3RlcCwgSSBhbSBjb25zaWRlcmluZyBv
ZiB1c2luZyBNTCBsaWJyYXJ5DQo+ID4gQVBJIGZvciBpbXBsZW1lbnRpbmcgdHdvIHJlYWwtbGlm
ZSB1c2UtY2FzZXM6ICgxKSBHQyBzdWJzeXN0ZW0gb2YgTEZTIGZpbGUNCj4gPiBzeXN0ZW1zIChO
SUxGUzIsIEYyRlMsIFNTREZTKSwgKDIpIE1MLWJhc2VkIERBTU9OIGFwcHJvYWNoLiBJIHNlZSBt
dWx0aXBsZQ0KPiA+IHBvdGVudGlhbCByZWFsLWxpZmUgdXNlLWNhc2VzIG9mIE1MIGxpYnJhcnku
IEJ1dCBsZXQgbWUgc3RhcnQgZnJvbSB0aGVzZSB0d28NCj4gPiBvbmVzIGFuZCwgdGhlbiwgd2Ug
d2lsbCBhYmxlIHRvIGV4dGVuZCB0aGUgYXBwcm9hY2ggZm9yIG90aGVyIHVzZS1jYXNlcy4gVGhl
DQo+ID4gZ29hbCBvZiB0aGlzIHRhbGsgaXMgdG8gaGVhciB0aGUgb3BpbmlvbiBvZiB0aGUgY29t
bXVuaXR5IGFuZCB0byBlbGFib3JhdGUgdGhlDQo+ID4gcHJvcGVyIHZpc2lvbiBvZiBNTCBsaWJy
YXJ5IGFyY2hpdGVjdHVyZS4NCj4gDQo+IEnigJltIHZlcnkgaW50ZXJlc3RlZCBpbiB5b3VyIHJl
YWwtd29ybGQgdXNlIGNhc2UuDQo+IElmIHlvdSBoYXZlIGFueSBlYXJseS1zdGFnZSBwcm90b3R5
cGUgY29kZSB0aGF0IGRlbW9uc3RyYXRlcyB0aGUgZnVsbA0KPiBmbG93IGZyb20gdXNlciBzcGFj
ZSB0byBrZXJuZWwgc3BhY2XigJRpbmNsdWRpbmcgYm90aCB0aGUga2VybmVsIE1MIHByb3h5DQo+
IGFuZCB0aGUgdXNlci1zcGFjZSBNTCBhZ2VudCAoZm9yIGV4YW1wbGUsIGZvciBmaWxlc3lzdGVt
IGdhcmJhZ2UNCj4gY29sbGVjdGlvbinigJRJ4oCZZCBiZSBnbGFkIHRvIHRha2UgYSBsb29rIGlm
IHlvdeKAmXJlIGFibGUgdG8gc2hhcmUgaXQuDQo+IA0KPiANCg0KSSBhbSBnb2luZyB0byBleHRl
bmQgZm9yIHJlYWwtbGlmZSB1c2UtY2FzZSB0aGUgZWFybHktc3RhZ2UgcHJvdG90eXBlIGNvZGUg
WzFdLg0KVGhlIFsyXSBpcyB0aGUgTGludXgga2VybmVsIHdpdGggaW50ZWdyYXRlZCBNTCBsaWJy
YXJ5LiBBbmQgWzNdIGlzIHBhdGNoc2V0IHRoYXQNCkkndmUgc2hhcmVkIHJlY2VudGx5IG9mIHRo
aXMgZWFybHktc3RhZ2UgcHJvdG90eXBlIGNvZGUuDQoNCkl0IHdpbGwgYmUgZ3JlYXQgdG8gaGVh
ciB5b3VyIG9waW5pb24uIDopDQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9naXRo
dWIuY29tL2tlcm5lbC1tbC1saWIvbWwtbGliDQpbMl0gaHR0cHM6Ly9naXRodWIuY29tL2tlcm5l
bC1tbC1saWIvbWwtbGliLWxpbnV4DQpbM10NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWZzZGV2ZWwvMjAyNjAyMDYxOTExMzYuMjYwOTc2Ny0xLXNsYXZhQGR1YmV5a28uY29tL1QvI3QN
Cg==

