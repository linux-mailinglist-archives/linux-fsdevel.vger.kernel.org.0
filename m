Return-Path: <linux-fsdevel+bounces-68571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 663E5C60AAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 21:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D562435958D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F730C37B;
	Sat, 15 Nov 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fqhr8O4z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HPXLet9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3E3081C8;
	Sat, 15 Nov 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763238070; cv=fail; b=DnaaeYV6ZE6i0DlnJFL+4+6JmOPcQsu12Fb/cDv4SzHFRMUBu1jzVxTCQUkUiF7Q7tzyZv1LlRpPvxD+X/860oOGcmXZCceqcT1dj9FlOBX9UyV+lXrRqt8HrL3JGPBtT+SUosx8kNozpAO8p48CEZvNsXTXs5wLCSqHT7bvCmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763238070; c=relaxed/simple;
	bh=qClcOPz3WAiiKogQnktDVyqbzJX73EhEezLVxaOI3jY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTQzPDOzRdj/XTiLkY440gX9HHHweF2qtVhXA3BQKzDr7oMNRCv6H14YQt/FKaZHRwCq+ufdZ8DlA8h7X2kXQqd7VzePx3s/VVijhlgJh30AcOz2aP1EM5t8ABpiBaiRPoiWcoxCvj2Ebg9uyBq4PJeqBThDRgc+Ony84dVBmTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fqhr8O4z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HPXLet9Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFIDYft022668;
	Sat, 15 Nov 2025 20:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vu7ITtB1cxeEZhIrfsEybDbb74RL8MtEuuZmZkyxpEk=; b=
	Fqhr8O4zZ1lV4VZN4E6ACi9RLPPodaWwW/9xNTBUR4/06tISnJvvCqGQcW3FRz+v
	273kI1Eev0/85wwtxZQSfCC+mL6Vm3smKraUnJyMAPK+y19fynNKWcfDFFxGRtQE
	1v8xCtPsX9HaDrtixoGGrb5LvFTlHXdvFrZpy4xgfx1fEXPxSCLqU8heITVW2mFt
	lU576ILQRfpnFeUGNP9rD0kJj1V+jGfd6KzQT0dgK3R8qGx7Cr/JiYz2Lqv9NdQ7
	RoWOx+LvK5lwOFDMWWTBPGdgkZZPwdaEweJ082kMqPq3ulgJFYU2Mzt0b6xFQPrX
	05f4kdlxD4GhsF6NrFuUBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej960fk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 20:20:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFIk2UK002483;
	Sat, 15 Nov 2025 20:20:49 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy69jcy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 20:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=na4Q4HJkh00U4Qdhm2xfh0WfSvGNApfKCNtADx/liItxkxTWWJD0Myr3V3BI8B6wh+6ifNiqRb8I4gZs1spiPLjji0a6EaZZnMkNci9joq4Sr5V/bo+wkuz+xqdRlWt1iUE61o/+IeaHx6KZ7WGGZif4sxFtAMZYCBjczJQwWYvgH9NKx7UloP4abxsmty3eVYkKG2ZiiQxJ99NzBieUXFme26q9ijjfKKYG5BYTvV2zC2NG0bIW6t9AGfjwYPPg9d6fgxZwO5qBTGac6p9t/Fxf68fv0ggvEP1VT7MxbZHTD8RVc3ZJCvYa2LsgrTVtEEkaSQqHUhWvuhJ3m+X0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu7ITtB1cxeEZhIrfsEybDbb74RL8MtEuuZmZkyxpEk=;
 b=m7VOcaguRS6HFL7a50xNImGrW4eD7kkPPSF+hGdNU60/gwzKff39iHqb+2+qtAp2mrlL5H6uoSubArlCGF5ZZqzy3gUrdI99Fj3bJsYyOtLeXk8yw5BJCJLzTJis2JlFjBhSbqi0FLbowXj5OQ7OkAl0fEW57TKdtgo3et2PWfITyXGwpq1hx9NeXgYu/f1qz+yDPNxWcvuV2RtV7rvrNjTAVPX3e2lcoypt/g/tudzgW5wpBHpea1ix7L/4t/HSRomU5YxTzJD7jMzdQZY2XHA60HXwIiSoxZMrOF+3gPKsu533P6Yt3Lt7dt7cTnSErVc1veeLuCJz/onyMGzUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu7ITtB1cxeEZhIrfsEybDbb74RL8MtEuuZmZkyxpEk=;
 b=HPXLet9Zm+DsO6TLSFFNCUqhat5BbUvGd7HEym6H2Qw/lW4CmtA7fd4lHF/AkLFuk2hYokWcQ44icySddfk5N7xOVyQmFZhGFcvigQGMG1XHhUlaBPtV9d/Qy/nIjwFhTSZURyUiHTUe2V8zOIvHJzFr+0sSkNdsFlZ2r82HMqQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS4PPF072D269AC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 20:20:46 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 20:20:46 +0000
Message-ID: <e43b83f1-cc9f-41b6-b659-bb6cf82f7345@oracle.com>
Date: Sat, 15 Nov 2025 12:20:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <967cc3ea-a764-4acf-b438-94a605611d86@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <967cc3ea-a764-4acf-b438-94a605611d86@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH2PEPF00003854.namprd17.prod.outlook.com
 (2603:10b6:518:1::74) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS4PPF072D269AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 61980588-1d91-4649-488c-08de2484757f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c1UwV1lhUHY4MzJHcTZzZnJqS2ZyY25pQzdkcGUzSFZLdkI1bDhhaVFWQ2pK?=
 =?utf-8?B?TE5GNFBoWDZPV09KV2NWclNhL0tjclBXTmsvTWVVY2dwK3B1UnFsNFZjYVdZ?=
 =?utf-8?B?WUx0QUxEc1RUNUxrdjVlVENCSW1PeUZBTkxicWlqcHFUM2hOOEoyVk9YZW9N?=
 =?utf-8?B?VHc4S2VrNGRqTFptcEt0NmJlNFhrMGg1bEVwOVN1cnJBMkg2c2F6Q2MxSTRX?=
 =?utf-8?B?NS9nTmx4TmU0M1RWaXFrZG9ZQTRQUFlMVTBGTk9JZkVmcm4vVlU3RGU1blZu?=
 =?utf-8?B?cmNvNDJnRUMyc0xQY0dEWGZoSkVuVGwzNDEwYWszVjRkeHAwem5Xb3ZoREQ2?=
 =?utf-8?B?YWFyMWlQTjg4alZ2WTdzTkxVMWJERStpelJoY3BPc3RCb0IwQlNFdE1ZNXNx?=
 =?utf-8?B?clVsZjZ2ZUlxK3RQMm1ZbGI1MTd1SHpBWVhqNmpJbndEeHptdVFGSGhwU2lI?=
 =?utf-8?B?VmZYR0lNY3o0dzZqLzludGZUTk56YXlUTG1BWXdsZjU3cVZZdmVQcm5jV2No?=
 =?utf-8?B?QVpJMWY1czdWT2JZUDUwTFJCNDVmN05wWWY1K1dwUVR6b2tCdVZOSUxqL3Z0?=
 =?utf-8?B?bVM5SWJOZXJPQko2OUtTUGtneE5HR1JHc0JRZWh0OEZ4aVVVVGxGNHE3MlFV?=
 =?utf-8?B?ZjBTL2hEd0hUZUNhZW5GUkgwamlpR1ZzNVgvK1M5d3hKd3FYUTlsQVRFeHdx?=
 =?utf-8?B?WExwdlpHaHZKVmEvVjl0czA5VWgvcWZkRGxVa2hGY3JBR1Y2WU5OWHhkQXhu?=
 =?utf-8?B?RngwOCtNMmFESlFubkRXZk10eVBSbGRaOHVMTndoRzJ2aG5NMjJ3YXFJZTdX?=
 =?utf-8?B?V015eHJNVEdwc3FYSE56Y2F4ZFE1TkJHWHBNUVJuaGlaUS9QMzhoNmtrNW1G?=
 =?utf-8?B?L05IcGhBOTBNd0JQQzdEZ0tVMVMzTWNETnl3dG1TcStzanFoNjJJYm1VaFdx?=
 =?utf-8?B?RlRLRlVGSHBMaVVvY2d0aVorOFRFRVR5eUVmN3NWYm4zT09hSCs3aVMxei9T?=
 =?utf-8?B?TStjUHdYRWkyeUtVQXB5RitDMHVzaDVwaXVZV2ovL3REL1dvb3Z1T3ZqUkhK?=
 =?utf-8?B?OExvdDJNVjlSNlRRc2UyOUpCUVNXNUdNaHhCV0JNcUlUbU1ucWxtcnl3UHZi?=
 =?utf-8?B?ZGR5c1BESm5XNjJyZlB0b0s1c1JYOHdDSUtodVNzT21ld2FQWTFLS0pCOHEz?=
 =?utf-8?B?K0xFMjAzVTdRWHhpclFxSDJZOEVMNGlQc3Y0UHpob2d1Rk0wR3dlV2JPM2VS?=
 =?utf-8?B?aFJod1p1SnhDR0VOZi9DcVB4K1d5VWJrN1NXZDljb3AvZzhMTUU4ejV2K1A5?=
 =?utf-8?B?enRxblVEdFlUb21RTUEyWi9VQUxZcUovajhZYlhiVmpzelJBVHJJSGdadjBQ?=
 =?utf-8?B?VFdybHVPRDl4NERmLzFXTzArakZBODhTRTU1MU9vdEt2NkZZMkFaeFFteXVE?=
 =?utf-8?B?cnZmNHRwSUY5bTQwaXp3T1J3NnhPbDZ1aXBESFA4RlJheXJONzBnUHpEYVNY?=
 =?utf-8?B?ZmNlOGtzN3VIRDREenl2akxUb2xOVnBXQXdJK1c2bnFkblllRCtvSE1VVGpL?=
 =?utf-8?B?Q21iQnA1RGpqa2RkZXNMdHRNMjA3eFpvUitUdXprY0c2K25mQ1g1ZnhRZkFa?=
 =?utf-8?B?eE15UUVvWEJOV2Q4cC8ra1k4Y2pwWStkRnViTU5YbDAvdVFLR09YM0k2c1Rv?=
 =?utf-8?B?cm9DVHhsSzJGKzhMVW1LWEppaW9QdGRVMjFQcWdBNUl2cFhvVzZwdFIxa3Jv?=
 =?utf-8?B?UkwxK1Z4UE5ucUs4R0YwOEZJWlFDUEhmLzVuNU1hcldxY1VCUmhwd0VMUjVz?=
 =?utf-8?B?dTFmZUFEaDVBeUU3bVJsZkQvSlRDSW83dTFlY2hENER5a0dVTHBVQVFIVjRQ?=
 =?utf-8?B?WDZ4Y3Vzek9uUTNHZlpZVENRaWtjb29yOE1rTGM2SnY2TGsvNVAzQTZnamRR?=
 =?utf-8?B?c2w2VDFVTEpJVVNyRzF5SC85Ukl6UFU0a3RBejBNV1lkc0RvTmsxUEFnWFBz?=
 =?utf-8?Q?XzkI7Ksj7Avu9RnB0EYz5iWhP7clDw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eXYxZjFrZTJrMjBpNkN0Q3ZJaFVra0RrK1h0cXJuVFdlaytaaWNqQUlyd2Vv?=
 =?utf-8?B?Q0ozemNWZjdlTEM5OXFDeTVoWm9NdHZyaWZOMlcxbzV5WmVjUnFoQno5S1VW?=
 =?utf-8?B?TE1DYmJSbVRRS3dpMDQ0SWViZGc1QkpQYUNSemwzVTB2Vk5IVy9SM0N1TUxL?=
 =?utf-8?B?YmZxWEtFWHlKMzNlZHVLb3JmSEd1aW9EbXBEdE4vcmNWME1pd0hhV3JxS0xy?=
 =?utf-8?B?R0kwMXhhV0liUEdiS3E2a3lBT1lYRjhvK1NPaXdTd0kzU2tZM0dUZW14VzAy?=
 =?utf-8?B?L0FZMHRWSmpRU3lOR3NEcWN3YmlLdkxYQzlOdy9ZOENhd2pmaEFWaXJqaUNY?=
 =?utf-8?B?aXZsYzVWczlMaHY1d1ZEY2grRXROZWlndzlZdWhVSi8zNGc2ZC9oR284UWNC?=
 =?utf-8?B?UWhSbC9sUVlrZ0YwWWc4YXFpYjFQMTBoU1h3aHhlZFprcWlLbGpmZjNnZXE0?=
 =?utf-8?B?RjdyUDZOVGEzUmU4YUVkOE5WSVNZR1BCMkl2OUszWHRRd28zWkFkUzYwelR4?=
 =?utf-8?B?aTVNcVMweWVJZkNzQ1hDc3NwTFJHbWh5VlFWNjBhcmFhN2xJVUcyTDk3bHlR?=
 =?utf-8?B?T1VQR1ZINnE4elJ4c1dpTmVGUnVGSlBXRHU1UEd3emhGUjYxRXoxYjhGMGV6?=
 =?utf-8?B?bktySU5MakljUVp2eVBhOEpXamFnYmJvUEJzVENUWFFSUmVNdmNNZE9YaUxx?=
 =?utf-8?B?cjQ4bFBBNzhZeTRFQ2xLdDRJdjRaWmRSbG9HSnJ3YmxxK3AzS1pzYmJVZDFr?=
 =?utf-8?B?akNtYStZdVkxR3RZZDltelZMcVlJUnUyK0NFRzFUTlNsbzVsek1FdmNyajI5?=
 =?utf-8?B?WlArcGN2TUcvOFkvM3dCdWdaQWxxcGRQdGRNTnFIUjNmam5rb3QweGZGVmlx?=
 =?utf-8?B?Z3JxMkx3VGpsYW5CVXMwQ2pJRVNxWEhqbnVhVjc5MlM4bm54U1VJT2xOR0xo?=
 =?utf-8?B?L0t6ejZhVFR2WHp0VmNGRDZ5VHlQQVlzNSs5cEJpWTVpRGFYNXR4MUhueFg0?=
 =?utf-8?B?aEQ4RkVxdys0YmxvMjJwVlVkNmRHbUR1VjhWYjluSEh2SFhORkpCWE55clFh?=
 =?utf-8?B?Y2NRbnNDUHY1QWNuM1ZSbHdiazlOK09uMGNNWDR0cHJSaEhkM3FaYjRxOWI0?=
 =?utf-8?B?dThOVU1XUDc4c0JyNmpWcHB0T25FZWk2T2diUzJBVDJDaUZCaDVLUWFlaDN5?=
 =?utf-8?B?bXRpQXdkQUl5czUwY1Y3NkJianVyYnJSTCtKZUF3LzB3YzRnWllrNThSejFp?=
 =?utf-8?B?WHVYU2ltU2pCNFNQYW5Nb3ZxdXN1T2lTalVWM05JQnhGSTFDbEkrS1ZIZGti?=
 =?utf-8?B?S3BhenduNk9RQTJaSHZzU3hhZWVkaVN1WU1oa1ZKdStUQW1kTHg2OXQ1cnZN?=
 =?utf-8?B?ZWJMSklnWS9STW1iRXY2aFJFSW9ISEN1V3JPaklDbllrOFhoSlJYQ3B1UzBY?=
 =?utf-8?B?QW5xNS9UQUpoQjVHTmwrTnhsV2d6VjBnOFBGZzZtQXp1ZE9zTHJhRDdaNm9y?=
 =?utf-8?B?WXVHc283V0ZvMnQrK0hhM2Qydkl1d2FSclQ5U2VoeWNXQlVpRS8ycCtVK1Jt?=
 =?utf-8?B?QkhNdkZPcWJqZHBtL1crdVMzeHpwYXJuL2E5NHhTdE1SR0RTcnR4eEtMNG9y?=
 =?utf-8?B?WFF4bTQ3TFc2czg5MGtrTjg1SldHaE82a0UzcHpkK29YSy9ObzR0bHVrWFds?=
 =?utf-8?B?WnlJVGtmVGFUbEMrRU5BTDcrZTNlQTNxZUpGeE5rRVI1ZGN1QjArSXllR3p0?=
 =?utf-8?B?TVJQNWwvc0tFMEl3ek03bmVPc0lvMU1mTXJ4VVMwaGN2czMybUtGYTVvQmNG?=
 =?utf-8?B?Wld4TXh6MlJSdkpxYWNHblhwTVVlY3UyN21WcEg2bWdnV2ZOWVY5cTRiTWgr?=
 =?utf-8?B?S0htY0pTSkhaejhkcmlsV3FMVlJoTkdVQUNHTTVSWEZucDhreE5uWGJvUmI1?=
 =?utf-8?B?TlZQV3U5Um8xYXhJZWxiMkI0Ri9zSWJuL3JWeENqVWFLUDl5UmdjNDFTSE5u?=
 =?utf-8?B?YVg0TFZNVkswcEw2OXcybWZ4d1V6WDJWa1FQWGZOeld0V3pMUDNNOTlYQ2Q4?=
 =?utf-8?B?L0ZISlZWeUdmbHBFbjdMQkU0M0p6dDVYa3doT0dvRTZBeWRNNm4ydGFTUUND?=
 =?utf-8?Q?KhypfFQwaqWGrM6w7l65Pphq6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	syT/PDVrM5c+r9uwyutPO5GsJQBYlo5RBWD601ymb9tJFDUlBF/zWZI6KRtuHF4ieXidRVCWAl0+PFyDsh3GPd9klq2CQGMWsWZE7hzNXbgBecIBj+1u/MhlL4+QY+ePGMrbwuFqwxtRoEvkgpmL1AYbSw7qll3TnLIyqwD2ATXIAIJ+NZXiLLVBnBKXccJAmA+J2mOvSkTjsHnWdFL6lgF8aTWUTo0mysvMye/8lWFtpxodp+7EyUof7eubL0vg2T/jQP4859qg33qB2vpMfxcREJ0cWDNOQB1jr1+iG2odvYvlC+iKGbMsuPen3FmHXD5Xt/hqOZZ9LNyiXMAKQEhWiUpQK2bKVmUgls0wjw58Q0eOSlVrhPtUV40+d2t58nQB9bBAfwXWBButZuyhFOTzinW73ToYtrqSLYFpQsBKt7YaHnVcXsbMUSg7odvEDhAY8pxiBO98TylfppPyufx47667joUBbwL+DRTXxX3sLQxPNP+eS6oh2+3IZIrmRcCt+T9sUsCu5Jt6gdxlYPayEReKkbujtqx0Ap4eoMNG/jO51AkOjrjey967PMSS/iFZRzQZPIFk2dfF0u2AbmeIX5YvQlttLAZwU3aAwxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61980588-1d91-4649-488c-08de2484757f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 20:20:46.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Tvk70a79iabv3QG7OPFuZyQ6K2IVKEV8dQPRekOh6hyI9K2BKfZkNOyR+2H8W+a6kwy92dyQazAFsdLPBL8SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF072D269AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511150167
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=6918e0a1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ea7dN3578Ref1c1bVq8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ry7BASg9USqMNeSdR09R6iJWjiWyzReH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX+AJaHiJEMfIV
 tZHUFdjSm4RH5T9Ia/s4BKN0NxxnAGtiO7j7/ZRx7l4OLXy7kql/latsHwQOjnSyj1nzXRZ8ywk
 rH/xpY+HCZF9RYoS88ecej+BM1B3mb12Y8PXXRAIRiuJ9q4k3cDiU42VXQANselPWLUaUCDLc4I
 IRLpWyDB0XBwnvUgKN8LWBYsxef4o2xfa+gX9Deog3z9rTbDaw9eVC1B7+U68DR54lJmEIws27t
 Y34VvHqoq4BIpEwCb7O4aAfiJy+oeKvQfSK1Xfe0OhKI90hAYReQNnoTbxf1YilvJNyV8HWAYY9
 ygWlY0xWNrsz794W580yHJlPYvMVXpxi7YF4T9mZU4OwzqD9T3FVXcQC/whT1DiGanhvfvLw0w2
 j5ryvIFMM5X/nNgkLelWgP2+tAqK7g==
X-Proofpoint-ORIG-GUID: Ry7BASg9USqMNeSdR09R6iJWjiWyzReH

On 11/15/25 11:44 AM, Chuck Lever wrote:
> On 11/15/25 2:16 PM, Dai Ngo wrote:
>> When a layout conflict triggers a call to __break_lease, the function
>> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
>> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
>> its loop, waiting indefinitely for the conflicting file lease to be
>> released.
>>
>> If the number of lease conflicts matches the number of NFSD threads
>> (which defaults to 8),
> It's 16 now on newer distributions.

ok, I'll fix the text. Even with 16, it's still a problem when there
is heavier load. Prefer solution here is dynamic NFSD threads, but
even that it is not the absolute solution for this problem.

>
>
>> all available NFSD threads become occupied.
>> Consequently, there are no threads left to handle incoming requests
>> or callback replies, leading to a total hang of the NFSD server.
> This is more of a muse than an actionable review comment, but what if
> NFSD recognized that there was already a waiter for the conflicted
> layout and, instead of waiting again, returned NFS4ERR_DELAY for
> additional waiters?
>
> That doesn't eliminate the deadlock completely, but gives us a little
> breathing room, at least.

break_lease is called from many places - the NFS client and server,
CIFS and VFS. Many of these callers do not handle error returned
from break_lease, some don't even check return value from break_lease.

Until we fix all callers of break_lease to handle error return, which
I think it's much more involved, returning error from break_lease is
not possible.

>
>
>> This issue is reliably reproducible by running the Git test suite
>> on a configuration using the SCSI layout.
> The git regression test is a single client test. I have to wonder why
> the layout needs to be recalled and why the client is not responsive.
> Can you elaborate on what resources are deadlocking?

The conflict occurs from these call stacks:

__break_lease+0x333/0xb90
xfs_break_leased_layouts+0xb6/0x2f0 [xfs]
xfs_break_layouts+0x196/0x200 [xfs]
xfs_vn_setattr+0xe6/0x250 [xfs]
notify_change+0x84e/0xf10
__nfsd_setattr+0xef/0x1d0 [nfsd]
nfsd_setattr+0x504/0x10b0 [nfsd]
nfsd4_setattr+0x660/0xc70 [nfsd]
nfsd4_proc_compound+0xc58/0x2360 [nfsd]
nfsd_dispatch+0x24f/0x6b0 [nfsd]
svc_process_common+0x101c/0x1aa0 [sunrpc]
svc_process+0x54a/0x990 [sunrpc]
svc_handle_xprt+0xd99/0x1430 [sunrpc]
svc_recv+0x1ff/0x4f0 [sunrpc]
nfsd+0x24c/0x370 [nfsd]
kthread+0x391/0x750

__break_lease+0x333/0xb90
xfs_break_leased_layouts+0xb6/0x2f0 [xfs]
xfs_break_layouts+0x196/0x200 [xfs]
xfs_file_write_checks+0x2fe/0x850 [xfs]
xfs_file_buffered_write+0x12f/0x8a0 [xfs]
vfs_iocb_iter_write+0x259/0x6e0
nfsd_vfs_write+0x6c1/0x1780 [nfsd]
nfsd4_write+0x2c1/0x610 [nfsd]
nfsd4_proc_compound+0xc58/0x2360 [nfsd]
nfsd_dispatch+0x24f/0x6b0 [nfsd]
svc_process_common+0x101c/0x1aa0 [sunrpc]
svc_process+0x54a/0x990 [sunrpc]
svc_handle_xprt+0xd99/0x1430 [sunrpc]
svc_recv+0x1ff/0x4f0 [sunrpc]
nfsd+0x24c/0x370 [nfsd]
kthread+0x391/0x750
ret_from_fork+0x25d/0x340
ret_from_fork_asm+0x1a/0x30

I have plan to post a separate patch to check for layout conflict
caused from the same client and skip the recall - same as what's
currently done for delegation conflict.

-Dai


>
>
>> This patch addresses the problem by using the break lease timeout
>> and ensures that the unresponsive client is fenced, preventing it
>> from accessing the data server directly.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4layouts.c | 26 ++++++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index 683bd1130afe..6321fc187825 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,10 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent starvation of
>> +	 * NFSD threads in __break_lease that causes server to
>> +	 * hang.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -764,9 +763,28 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>>   	return lease_modify(onlist, arg, dispose);
>>   }
>>   
>> +static void
>> +nfsd_layout_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	struct nfsd_file *nf;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (nf) {
>> +		u32 type = ls->ls_layout_type;
>> +
>> +		if (nfsd4_layout_ops[type]->fence_client)
>> +			nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +		nfsd_file_put(nf);
>> +	}
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break	= nfsd4_layout_lm_break,
>>   	.lm_change	= nfsd4_layout_lm_change,
>> +	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
>>   };
>>   
>>   int
>

