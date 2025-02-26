Return-Path: <linux-fsdevel+bounces-42703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD5A4663A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA1016DE52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858921CC42;
	Wed, 26 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3D3DLJt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VIi+nQmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0B21C191;
	Wed, 26 Feb 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585420; cv=fail; b=GsQvrb6F22Dp9dPoM8ACctn3UZLuUNIcdxrnYUWqsDgH9QzGmro2L97s7Y1eoMBrzRiPi5iuCu1zqZDLOTZm050Kny9GtKqJ+HNjlWma0sPolSzuqivUL/o7Ew2H+Sb7PpoyUTKGB/1CIuoRb28yC290qteknR6J/F4rx1nG9xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585420; c=relaxed/simple;
	bh=RekmO98krN0n4UP+gNisfnUx3WbStwxiSDGr6dzHQu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YiNC8irpziLcpAscSMmr3dEtjFOI1IdE61DQ/UEa2RBkUAgFSWote8fnbM6VT3jV7VJKNvEkrnROEcp6+yX6HdZgRZdmIv+Lo1wTX3f9VA3zV7S2EZ8IW6mhz+XeZzCBK1t5vw6vNotQjtsZF4Twx8hKwNzWId3FjeqOW98EQWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y3D3DLJt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VIi+nQmi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtbc6009872;
	Wed, 26 Feb 2025 15:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YVHo4F6rsU0nkWHObfKUC9LyuwEZ3nC9E+YnS7G5Ajs=; b=
	Y3D3DLJtz6rbqXJoHs5J78tCVV+rXdSkaz0ImwGwCiTiJJJ2TRSvrEnX7REFhvpg
	09uKCeRrGKjQDK8V02DoTd0ctp5EQ4we08hQ3bddFv3lwDtO0YgvVXagEBKSqr6m
	TCc4duhhsmHHe9SrJbVDq5HW1qk/EWZUp5Uyy+A399gRC56w/5F4DermB0Rj6gse
	ixxDHEHylzaOuP+PPOIKchX5DfwsplPhd1c/utYA/pzNCb0Uii36MqWaz/Xfp25f
	bcbFPFL8KophBNpoEccdYUdD2ooJnlLh5YdCWRQ80I+rOtXoL+UItRwZvUfj/lAG
	T/Hnq6PW+f9yfLf7muUCHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdhghm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:56:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFUfql010032;
	Wed, 26 Feb 2025 15:56:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ak4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlW++sS5fxO9gWWhtsMUBvQ3k1O62oKGYt0h/aLny2B0Ur3DjgUNI4FsDHNK97mdHEr3ImafIEN9rFSySvSUmYuXZP+4yFMUmDDLBT7VjIck8udRbPCG3+KyqNFSg64o2Pz5sxuhfmv3QSNXd0C1CoV5JooRoUjGA2IbAiNCC8vbK/pD76mTqKu+Q9H04DHnNCZ43GmDsCxM0TMYz3VyqL5FY3qYoNDDZHKma0NZIx7uD240Vu84Dnoh0oAfLJ6zhTD2sOfIwhY46hxQmF7kLK+VRkVXAgvmhFGpg8r/p7OOPdqCAVzwqRfDaGI7rNvM7a6ewxDoWFB626jB9ew3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVHo4F6rsU0nkWHObfKUC9LyuwEZ3nC9E+YnS7G5Ajs=;
 b=mx63US/nHJuFYHnhJC8ukfY+T3hCEh7LPBNG4HjGN704dDHwh5zQSUht+ssBSiGrwSpnW4DarAZkulgForxonGI+HDZrS+3Q0qtgAY9yBaFKs+GRNOMtQi64Xw7sbl8f/rbjyyT55kyYHghRTuL2goRsSU+d/rn9pjhu92rPbG+VCoRrYeQi6eQfHV4MHP6pzG3qC3zVVOo9cR28Hg+HmYt6rtSQ7X49VA0hkdBqYCKl6IzFKhAQpp2HvGLVQGYBB9BS1UxuWrriP+wtfS0BXhwlmQV2IHSnLydLiUt0xRGjRfF4I8yo/cwMIrDR7eBo+lGX+S1UFBVFMKVr1DmjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVHo4F6rsU0nkWHObfKUC9LyuwEZ3nC9E+YnS7G5Ajs=;
 b=VIi+nQmibkanBNMsTOEUxZs3TrXK+3dr2t1zXteSaaXdRqsuJoeKj20cT+igGgMrFCjpVSXJb9AnMHYifZ8xqR1BzvKLP1ZnOvia5q8wto5k5P5QZcd66MT/psczhKLp9eDNfec3mekno0OLzwuPyTitrlTWVCZBfiWC3RhMyOY=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 15:56:49 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 15:56:48 +0000
Message-ID: <ed3bb539-df59-40a2-bbd9-0d2efd36ba07@oracle.com>
Date: Wed, 26 Feb 2025 10:56:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, regressions@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
 <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
 <87h64g4wr1.wl-tiwai@suse.de>
 <7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
 <2025022657-credit-undrilled-81f1@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025022657-credit-undrilled-81f1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::20) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: f22e98db-7cc4-4849-a166-08dd567e2d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm5Pb3grZWxVRXQvNHJlbUp3ckJDS2ZWVUt0Zmx3R28wZEN2UkNWeGVYMTFx?=
 =?utf-8?B?ZDJpeWlocnNVbzFFaW8yTE9xYVYzRlNLOUdHZnZHOHczTHpkWFB3NlN6QlFj?=
 =?utf-8?B?dm1TNUxndTMvYVFoOG5BSWt1OTladG50a2pQVThpNkNrRldnSWlCZEdSQ1Uw?=
 =?utf-8?B?MGNjL2xKTnhSL1FURjBRcmFzZkxacU9mQVV1T25LTkh4elZSTTBTRzJQYkNy?=
 =?utf-8?B?QlcvbUlaNjlEZTcwZlBQNzRMNTJnaXRwandXT0tlUjF5cVFwem1mc0M2aXkv?=
 =?utf-8?B?QkxTUWdOSkxlbzdaR0NXSEZLdWs4aWVwOStSRUU1VFRzRUpucDV1V3JIWTJL?=
 =?utf-8?B?SFFtZ1NHZm5WV2FLZDdjRUV6Q3FsWTQ3ZTZuOC9MUGdNaUtSMk9jYWlzMmp4?=
 =?utf-8?B?eFJRK3VlQVl3cFZhVkRVbXFJMURaMUpWZVR1NHNrS2Ixd2RmQnlNTTdSd2Nz?=
 =?utf-8?B?SEJoVDdtRFpyUFdxbmxzTUxrYjBEeGhoN0kwd1VNbkF3Qk1iZXZBOUdNWGc4?=
 =?utf-8?B?c210ZTZ2YllvbFZTR3hRLzZISXdDTkMzUFhyS1gyTUdHK3hTS1ppUGUvS0M2?=
 =?utf-8?B?ci85Uko5MkJzOXVoNml3bUhTR0dIVDNGR1l1SFNDM1UveHhDTC9yL2FJMFlR?=
 =?utf-8?B?anNxMUxyUzlqNVViZ3lEb1lxdFFZUVd5TGpUOUswSUU5aXJFOU9GUW1XRlFH?=
 =?utf-8?B?NUV3VWpSSStDaHo2b3JIS2tqYkJSSXZkMEp4R1Y5a0NPUkFkbXIrOUNpdjg5?=
 =?utf-8?B?bitoVnU3QlBUbUZLS1puQ0ZoWUpIZS91eG5vWGxlTitBQ0dTNFhndE9wOVFF?=
 =?utf-8?B?VDZiZ2VSWG0veE5oSVRvRFYrbmxsUFFEemo3UUdWM3FUZXhxUFgzT3JhNVFh?=
 =?utf-8?B?OHJsV1ZrbHhzVE9HR1IxMlljVzRhZmovRGFndFRyWGJFNExhcy9yblVYUnpt?=
 =?utf-8?B?R3Z2OFhBcVpXcU9CV2tGRHZXK0xwU3BDMExGRXVDcTFRNlNUNUF2czBIZXRD?=
 =?utf-8?B?QmhtQnUzT29YVC81OG4wNTREdk1aQWFyTjNLTStIR0VlUlJCRXIyYzVrWTk4?=
 =?utf-8?B?ZUVNeHFyaVF6T3Qra3kvUDhabmgrWjNYclpvQjRnRXovaW52bDVYbHVuRnlF?=
 =?utf-8?B?OE5HWk41SGYxQUhTU0VUSndhZHQvN2VEQjFLOVpuTkt0NWdFN1hMbU1KYk5m?=
 =?utf-8?B?YlRaMU54MEh5WS9DSk5nVDZlQnZzcFQxM05NUkFQNWJuNERQZmlhTjhNRFFx?=
 =?utf-8?B?SmttZFNFOFIzODVEVHhENzA5R21GaHBoVVNUcjRoWFI0cUFXQU05Vy9JTEtY?=
 =?utf-8?B?RERZZHQxUHh2eXV1WHd4MUhNazVFdmdXK01oSGlIejBJYWhwZTh1bVdJWDFp?=
 =?utf-8?B?bzZVYXNibWZ3TmZyYTNIR2VWVXpuUVN0Y0Zsc01LZU5tTS9UblBiMEZ2NTlr?=
 =?utf-8?B?YnBHaWc2RGVod1U1b1pZL000UXlpRUhUZy9qSWkwbmx4cU5TaEZLalpmd0NW?=
 =?utf-8?B?cnMzM2YzS01HLzhIem9RUjVNQjV5dmhwVHZ4VG82TGVDMzZHMXBVMzlLeUpQ?=
 =?utf-8?B?OWJnWW1uWnArVHYyN1d0T3lrRENXYWdFeE01bi83TmpkMHpCeGdCN1kxdUtC?=
 =?utf-8?B?WXg4bXRZcU1aWllDZjhpWmZQVzZ6cFcxcmFpVStWQWJFaHBSZXFwb3kzU1VC?=
 =?utf-8?B?b1lDZlVxUUg4MVJRVTV1MUxlbk9MUWNWZEpJV1IzZHppL2RSbTU0S0JmK25V?=
 =?utf-8?B?ZVBreEkyZ2V4bXRuZzlIOFNxSGwveVBxYThKdnNoYnNBdnJsL3ZVMys5ZElo?=
 =?utf-8?B?akFrdytTTlBpY3h1dk9Cdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmNCaUxTUUI3azFTbkJEcC9kc1l3bXFhempmVGZkeTlRUTBFOFRrMnQzeXhC?=
 =?utf-8?B?L0FURFZiTXJiZEJ1N2dmL0RZajZrSzg3b0UxYmxvMEJoU0VRSmtCQkExMTli?=
 =?utf-8?B?dERFSFRNUGUwREpZZlNyazR5dDJndkNZcmtTUnZsZjk0d0tQQzdobk9xeVRj?=
 =?utf-8?B?ZXBSbUswclBvRjEwc0poaCtMVFl5Kzg5QmcxSDBZQ3RJRlFZMlBzUllFMHRX?=
 =?utf-8?B?UERhQW40ZkVnYWRJUmhFcUpBRjVxVktMUFB1d0hDY2dpcnY0RTJtSzl0bEN3?=
 =?utf-8?B?enFNaG9KTy92WGcwdktoeERDQk95emkzWXgvbUNPU0h4Q0x5c2pVVWZKUWpT?=
 =?utf-8?B?ZDV5YlprZlpqNWRUSnNnc09GNlF6cmhPa2hSVVF2aWRSU0VvK25HcnZNSVhJ?=
 =?utf-8?B?cmJaUmZTaTBnQzFzWlJYVWFjck1VSmNGUjlwdDdEYkplMVVQcStwMy92WHdE?=
 =?utf-8?B?WUtjZ1BlNWJ6UTdkN1pIQklEZGY3NDh5ZUtvSkRKM0dDZEd4Qklld3kwenFW?=
 =?utf-8?B?T01aa2VXSlNRVWsrODFQbWtSNUpKY2tYVGFyVWRxNk9FTWNZSnJyVTlJRWZy?=
 =?utf-8?B?T2x3V01obG5uRENyeHNtOXhlYjZ4YnYyN1RTZDNlZ2ZNRTRneHVKS0dHVTlX?=
 =?utf-8?B?K3BiV2krNjFsYkEwWWZnNitFRlRaN1IycTlQM09yN2h1OHRBbzN1ZUZ4cUlo?=
 =?utf-8?B?MGU0VkUyL2JlMkl2bXJwdXNrekM3L2k5SUJ5Vi9wNTEzQ1pIVTh0MUdXL3I1?=
 =?utf-8?B?RFVPczc2dFcrTForRmV5OHF6K2RLanIvU01YMkNBSUhZZ0E1NjhmdVZ4M2Qy?=
 =?utf-8?B?VnR2aC9XeHg1WnlqMHlqZ0hEdGFOTHJobS8zRlAvS1ljaVA0ZXd1bXU3SC81?=
 =?utf-8?B?MFpQaEV6Qi9PMjhHRTR4UjRjYmZmaFdrUXlmZStYWUJrL3c4TXBEbll6YnJS?=
 =?utf-8?B?ajVRbHA4VlJPRGZQdVFXaVl0K1U3cWVOVUl1MnRzQ2Y1U3k4emhPcis2QTRi?=
 =?utf-8?B?elNmTFZBK21QUS9mRGdGT21aV0kxWUYybVd0ZE9FU2pwRDBPbXhLUU9nWHZl?=
 =?utf-8?B?Yy9WamhUTlN3WWY2MjB4QVZVTUljekF3dEFJOEFyb0J1a2tFa2ExcldGOTlN?=
 =?utf-8?B?cG54a2tPMlE2ZXVGRWVlbWZKd1MvL3kxMlRLWTVrR0xmdlZkU3ArdGx4R295?=
 =?utf-8?B?SVlzblIxOXV0MXg2VUZRRWU1MzZFUGQxa1ZIN0g1KzJ0V2RhSTdydEdnTDI1?=
 =?utf-8?B?cVZvM3NVYWZKUDU1NS9QcTdyMTVPQ0JIeDMrL0NUeDU4ZDNlRlVaeHB2MS9B?=
 =?utf-8?B?SVR1N2FyYXVvWUcrd1BuSFB1azIrUlEweGtHWjNuTEJaU1pBTTVUS0tSQmdU?=
 =?utf-8?B?U3I0WEdzcUNIQnU2T3Jydno3SlVKT3IxQXdtNHJLN0VxYVdHVWd3T3BVODFW?=
 =?utf-8?B?SnlyZHF1T1RuSnVudWczZWVZelJYQmN3MjBoak9CVWd0eXY1bXFXK0lEOFJ4?=
 =?utf-8?B?WThhSU5TV05QeTNMZmN3YTZrV21qNGhrNzBnQldmN2piK2pKQkVla2VaaDlS?=
 =?utf-8?B?R1djYzBjL1ZiRHpwazE4UWRkQjlEQ1Zjb3R2aHZUK3JGMGd2SFNGSW1WK1No?=
 =?utf-8?B?MVlrL3RjR1JvRUlRaUlSVFZvRHREdk1xb0pNcWpkY01rZ210ZWdPMGwwSDBq?=
 =?utf-8?B?ci9WRGdRQmtZL3N4VEwrcXcyOXd0UWdHbHFWOG1SSElCUmJxOUMzbm1GaUMw?=
 =?utf-8?B?VkVROCtFSHFGYlZhSGR6c3VmRENjNGlMdTc4a0FPejhTWTBzNnBSQkkxNnBK?=
 =?utf-8?B?YXkvU3Mzc0Y4Y1R3QkcwTzE0YUQzZjFraE9MYTlNRUNmcktKOTVrNE8rWVlp?=
 =?utf-8?B?MmIyeWtlVDZyZDJVbHJLUURRbFZqQlFkdE5KU2lHNEIxTjlPZVdNamFrOVJ0?=
 =?utf-8?B?SjdHekFTeFNnK3NDRWVCeStrOGt0R0YvclM4RERXY1RaSWxIYnd6TXh0WjFX?=
 =?utf-8?B?YTNKbzFuN1FoeTJLTkFyT0o0emdoU0JHUkRpZ3dkdzhzeEQwZ2U3Zzl4MnJw?=
 =?utf-8?B?cFB6QmJwN0k2VzkyVzFvVXU2S0U2MzJrd3hqa05BZTE4YUNtVUpGb3RBVzA2?=
 =?utf-8?B?SCtvQ016NndsSmttUUt5ei85UWRuNzJZSGdVOGUySklHQUUrOWRuMHE0OGpr?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0+lApv6wcXlx0dvYiLYGhNh/SMtlDA3ALqkBAVTHfLcGvtR7R3dBFGPfMVeWJDcqVV5zq/h1sX29OGFALRwYXE1pkKBiUPbLbAuspf104gu1m17KuJkR6PtBMf3Y/Pygs1F47Zxp/IHUYUgao7R9cRpTU7jJCeLcs3AjHodC0gGjVCu5utuQG/Bq2kc0GWxKoDSH+OvDdG/k3oOQYxIcrmTlegnOGFIFUItUAOSGhnutQEMFdUFtaUAzhB0nBhUb6TRCnD68h03pPsWQ273P08PRg5o+AIoYb+S5581bipBmToHP9oXqiXCgDh+YGZgGvuA9cdiUFnp7ClUqWQbmkTdORtx82hNkB/VieXbl1GeJBxLzPP5moIZBlHts5VOpa2kNuIkGsTU5lKIyOkgMzzGpfKWQOlonKJ8dD8SbjVmm+RfMbT83DikTufmyPKl6vCAzB8z1hxwEai86uuK9zXBTkxLXhGTihqCDk3qEJzUB2HmFAWFY62F+zBum5Zb552xACH4+8yDa8aODxflkNmzvZof8XcK0j3XtlYIDKKjURLZ+gUCq4NCxD5b73khwtp3vbVy45ipA8W/lk+oXfbIuKhh8BUFSPONaMZxebxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22e98db-7cc4-4849-a166-08dd567e2d63
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:56:48.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToAC2kB9JX93EpI+OBV62PNj5n8cfou1piThtfiEMbFBoQVQmPcc0X4KPNkI5YU0YgqbNsCZ+VsQ0OQOaw0w7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260126
X-Proofpoint-GUID: 0bg6MYuZP61ndt-xQxE7r5UMMlEAips9
X-Proofpoint-ORIG-GUID: 0bg6MYuZP61ndt-xQxE7r5UMMlEAips9

On 2/26/25 9:26 AM, Greg KH wrote:
> On Wed, Feb 26, 2025 at 09:20:20AM -0500, Chuck Lever wrote:
>> On 2/26/25 9:16 AM, Takashi Iwai wrote:
>>> On Wed, 26 Feb 2025 15:11:04 +0100,
>>> Chuck Lever wrote:
>>>>
>>>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
>>>>> On Sun, 23 Feb 2025 16:18:41 +0100,
>>>>> Chuck Lever wrote:
>>>>>>
>>>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
>>>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>>
>>>>>>> Quoting from there:
>>>>>>> """
>>>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>>>> working with Scaling.
>>>>>>> ....
>>>>>>> I am using VSCode with:
>>>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>>>> """
>>>>>>>
>>>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>>>> to iterate simple_offset directories").
>>>>>>>
>>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>>>> release is still affected, too.
>>>>>>>
>>>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>>>> of a graphical application like the above.  Let us know if you need
>>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>>>
>>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>>>>>
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>
>>>>>> We received a similar report a few days ago, and are likewise puzzled at
>>>>>> the commit result. Please report this issue to the Chrome development
>>>>>> team and have them come up with a simple reproducer that I can try in my
>>>>>> own lab. I'm sure they can quickly get to the bottom of the application
>>>>>> stack to identify the misbehaving interaction between OS and app.
>>>>>
>>>>> Do you know where to report to?
>>>>
>>>> You'll need to drive this, since you currently have a working
>>>> reproducer.
>>>
>>> No, I don't have, I'm merely a messenger.
>>
>> Whoever was the original reporter has the ability to reproduce this and
>> answer any questions the Chrome team might have. Please have them drive
>> this. I'm already two steps removed, so it doesn't make sense for me to
>> report a problem for which I have no standing.
> 
> Ugh, no.  The bug was explictly bisected to the offending commit.  We
> should just revert that commit for now and it can come back in the
> future if the root-cause is found.
> 
> As the revert seems to be simple, and builds here for me, I guess I'll
> have to send it in. {sigh}

Note that reverting also reintroduces a CVE.


-- 
Chuck Lever

