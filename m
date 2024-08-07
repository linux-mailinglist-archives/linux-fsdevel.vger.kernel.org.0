Return-Path: <linux-fsdevel+bounces-25296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282794A7BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE4D1F23C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9201E672C;
	Wed,  7 Aug 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7jcbh1o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RMo1G1oc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5E1E2101;
	Wed,  7 Aug 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034048; cv=fail; b=twuIIha40Dc5QQwTgYOT/B6cPUQSCV6h1q5nmcKcDRDN3OVglLVrTI4mVlC689CC2oO4jl6JA1h6Y/QhphgL/meWHUkrvsqPb0RqXUp6A4iYdkM9msh5FQ2COEAe6TDUImFT4ZYvGsU5SOC+z81g+epde4/RaGGSrhetXvlBe/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034048; c=relaxed/simple;
	bh=plE9rcLTsAkHjXjAmnm/6jpvB9znnX7VSLGa/SCDOok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u1GhkXCuI6aGxCZnuoVcPqy6RB+9wKi7Sti1tLyy0fUuSR24pCTt6HsRU8y3J6n8k4080S4XwZYXh5MTD+IUxPgqio6hZaF4OxW8Jmau2pO1rYw1J7buCUcrzBVq1ZRa40yxgdP1vJ9l5qAUs7JleMT8Do/q6uwxSPVmzHcO15Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T7jcbh1o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RMo1G1oc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477ASU8X009979;
	Wed, 7 Aug 2024 12:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wJH9mEk22H9o/RgKOvhkCEye25f0wiLhEPgxrMjuXrY=; b=
	T7jcbh1orPQmT1lQa8kiEqv5meAmd9nUbuKiTK+BOtRA7SyzGugo2hGJTfwrojYM
	Bohg62aaCrqCD2Ke3iZilV6DIrYFWfBcaHaKSaVefFHHjaTIlQpKw5MGF80/2Qr0
	IEhG7i5ZbgtwES1fcm3ZArtTFA2RJenxXuDEnMv8qQDr38nlA614IU4yt/f5lNYn
	KK8oHKZbis49S/4PzJuT8czh1c69vxPw+gUnmXVrFFKIJORGA9fWkpKcF7esURZF
	s/D01nZO/8URAz3TXy1WpZTw2d+488sW+t2+oC+mUnTweoWxH8FyojtqNfghjuAy
	LDMkcy74Z2WDn3qfI5BqUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcffhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 12:33:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477C66gj004697;
	Wed, 7 Aug 2024 12:33:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0g0tt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 12:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRzm4qa0fDRw9DEOg4eWi/vkMKEqEt+fu0PMYxe1K9diuq9QTSSC52ZDhyV0OfeM3RRNqXJyby6kYJ4XbSZ8a4E1pXaa5KfCvc6pyV24ruUq9NUG3iF+oNq5eSVFGODtzlpsS9Mb0gbXH4fCowi41KPsURVdoxXAB/+Vrr3uKeyil0eWs84Ai8fD4XxWc72n0B914zSyceKc4M8onqWP5LvGKhgl5jXCJ/Mb+pp3GCTk3Ikrb8lkc2w+AJ10gV2VqSGGhJOHIGipLF+cm+8EWzhBPToWAPjcwzQIs047bTtFpNsr7yOmY7a9s/xbK8Sl5Kg3iQ6duQnuAKyvlYP+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJH9mEk22H9o/RgKOvhkCEye25f0wiLhEPgxrMjuXrY=;
 b=PDVzXAZCajHQTEFWX7Termr5R5zOJXWMhEjR+OE+A6L7sqBzhJBgnQ5s8AX6089L5PFbQ/CynX6Mtuaxoi7MOFbwy8srVSzSESr4kucnFZesa4ylIBCziCkzL6opkiMpuJW7zJ1bMuNDGsLi5EvbomTe3RVjXX3k01bV7IVfVBS5fZx5mwxxy3JAc5cK/hC6rPjY0i9359eaeBz0T/57sGRgPJmRV0YCRtdSeyiqzdbIupJXfJSSofNEBH91UqWXTHrDHamSpojuFPzMnfZ7xOSA1LNFvNSex/Au4qfzZ5SzKkw8uq312+z45qvxN5i029r7ETMfolLJsWyJdKYbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJH9mEk22H9o/RgKOvhkCEye25f0wiLhEPgxrMjuXrY=;
 b=RMo1G1ocQRU++UzYRaM9bUSIXVQsZHfMGCgNRCM9+yn6LhmmR/N9yes2TdqCBOvxJb5OX6FJ0IQbVBEi+tpUwycUzXImL7sDujLswCbjRj7dvyx8cxH1Dl/lnT1RnDh0zawx3pslkFbPS3Uht3prxpjxlPyENV64jKRc/4TKOCQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 12:33:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 12:33:53 +0000
Message-ID: <f39d240b-7abe-45d6-9d87-553ce8c6cf41@oracle.com>
Date: Wed, 7 Aug 2024 13:33:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] xfs: Do not free EOF blocks for forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-11-john.g.garry@oracle.com>
 <20240806192441.GM623936@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240806192441.GM623936@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b80986-a4bf-4774-f1e0-08dcb6dd32d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0hDNnlMOS83RUo0UWROWkY1QnJhZitiSk5IOXZlUmg0M2k2YzNydFpaUnZr?=
 =?utf-8?B?bURSSUV0Q0ZoYjhQUk41MlBIWmNzUHRMZy9pdThmeHo2Tk5yRXpLNE5UcDd6?=
 =?utf-8?B?Zi9iTUJEZStjMVdIN25QNFlUZWswRS9KZUM1TE1lQkZhLzRKUXl3aWk5RkxE?=
 =?utf-8?B?ZWVtdzkwL0RmL2thOFVxaHRTbG0rYlYxZ1hLK1dXblg3NlV3NUJ1ZUlPSGtm?=
 =?utf-8?B?cHFxeHNWOHFoOS9uZzFJUVRnS1ZnTDF3U0UzV080WlBYUHlpMktMODVLMUo1?=
 =?utf-8?B?Z09vMWtkYWlFclUvVitESklnaFZMWWdFL2lHVHE2VUF2dThmMER1MERJYzRO?=
 =?utf-8?B?ek9PcURyOFBDSXE2Q2VoenRETG5EQVVFemdrWXEzd1VHMGN5YlhGcjFTWHpI?=
 =?utf-8?B?Q3FoTDN3QXlZK01NcEUrYm82V1k1Y0VxTEo2TlN0RUtUc0M4MXV2ZDhXbE9V?=
 =?utf-8?B?M2MwbGw4Z2Q0N2xlQ2pCWXA3ME5aYW9aZ1JhQldDbUFYZnQ3eWhJZmtYS1RL?=
 =?utf-8?B?SGdmZmFSMzE5Nm5rZlVKVkJMN1hJc2xtNlNtc2x3ZzJHQ1ZHaExsREtFSjlW?=
 =?utf-8?B?ZVBpQjRvdk15b004VmNzRVhmd0M3NnU4UGRkWTY0NDQzQmlheHBMTVc2ZUpp?=
 =?utf-8?B?TC8wVHJUUzR4anR0cE0wQWl6azJvMVFQNVJtVmJEZ2dPYnV3UVo2a29HNnNk?=
 =?utf-8?B?YVlrbDQ0cXVpa1JSMnY5NHRyZ2Q4dElaZWgyUEhoOHUybW5ZZEw4cVlJaUlV?=
 =?utf-8?B?RWJicW51a1dwa3p1MjZuZU5SN29sRmoxQkVtdlE4UDFxdTU2Y3hYTm9EdXhw?=
 =?utf-8?B?NitHSU1JdHY2VitvajRpOVQzYXNZeFI5Yk1pQnc3amZTYUVibENCQjg4blV3?=
 =?utf-8?B?dDFYSUtzSTBsYytZenZXWnYrQUJTTE93N2N5RSt1UjlGblBId2dGZlFnUEFk?=
 =?utf-8?B?QXI0MlRHUDVNUEM5NXJNdTR6Q1c2THhmVm1jT2JITDFveFZFSGdndVV2bmFu?=
 =?utf-8?B?YzNqOFFuVkI5a2lsTk9TdlJxWE00UHhwc3VZMGJRSlFYNllKVzFndlJ5WDZw?=
 =?utf-8?B?RzZFRkxOWnNieEwvVFpDU0RVekhld0pzUkZTTlZ5bEVLQjQzN0t1ZWVscm4r?=
 =?utf-8?B?TzVuVEhybElxUWh2clYybkhId1lpQVRRV0pybFVFTis5T0xPZVhKdjEzdFZn?=
 =?utf-8?B?TE9hNW80OXluZENJYjFxMi9yNUZIZHJibzEyaXVXU01RTlBSeUpzSVNMdWs3?=
 =?utf-8?B?VlllVHN4V3BxT1FCWGg5TnNLRHUxaXhveTRLelQ0RDhvdzVCUkcyR2N1diti?=
 =?utf-8?B?MXY3VXA3OHhOYUFGL0hwSXZkRm8yby9KcWlROXpqNFZDTUE0aHlKZjNWTXB4?=
 =?utf-8?B?UjYybHdvWmJLLzFmelhyZGozdUJmSzdicVJIWUJhK2JDd3Evc1QrL29GOHA1?=
 =?utf-8?B?RzNDelJEa0gyQml0QWdDeWNMaDllM1I4MnJpK0YzU1VUcnBNZnFvMkoyQWhP?=
 =?utf-8?B?ODJLT3k5RUtDKy96TUxzWHUvYkg3dWNxeXhXN3ZzSEZqTnR6Q2VEZDJjU1Q5?=
 =?utf-8?B?Q2U2RlRVUm9tQ2tielJVbnowTmx0bWpJNWFrS2RhbkRURXBHVXhKTTlGTUFZ?=
 =?utf-8?B?TjNDck1pY2Y0N1gwclFYSWFDY21LV2NmMHc1RExxeWV2amt1VWRRQ0d6SFFQ?=
 =?utf-8?B?TDRWZUlYVytIdVgxNHkvVEo2MmRpSlhyWlBOUlBNd2h2QkJIZkErT01kTWVF?=
 =?utf-8?B?K3hRSTJ6VlJWWUVabFNPOWhnRUFKK1R1Vnl6TUM1QmhBalFTb2NkZTIrTXo0?=
 =?utf-8?B?ei9VVURaVitGZlgzcWpuQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDRId1AxTm4zd09kbkViNmNTbXpBVklqOVdsWFVjTUErT1lFQS9zeDRodnZ1?=
 =?utf-8?B?U2FoOElEWDRpYi9JQjBPMGhZR2JaTjV5bTFjQVFkSDZvWU1janU3RUQwZ1hi?=
 =?utf-8?B?NW41a2VHN042enRVSldOTFkzMEh3ZTRjbGprcnNab0c1c0t5WHdTQmlpcXhs?=
 =?utf-8?B?SjEraUtIOHJqeTdRZDYzNyt5NVpSc044R21ZNlhPbFlha1ZmalZUMThWSklz?=
 =?utf-8?B?ditlczJ6TmE5UlE0TUZJNjVrTmRsUkZkbmFBandWWWJ6MGlTMG00VzY5VGto?=
 =?utf-8?B?bWNzSEYwTmQrSW5TdXFUbGRSNVF1ai9SVnZjeWNwZTVOUEVKTTF6eUlOZllC?=
 =?utf-8?B?NEFMVkpOeis4T1cyY3lmb1ptZWFJeGZocWp1UkRic2NsMExCSjZrODNiTnBl?=
 =?utf-8?B?Qm8xTVVoRG5OMGZlaGVXUUM3VXhwZUhyUmt2aFVraXJ3aU93cjFPRTE5T3h5?=
 =?utf-8?B?MngrM215SUlaT210ZlpxWFVTWVhmdFpDWlEzSVZobDk5MDFGVWIyMVVQTW5P?=
 =?utf-8?B?cG1LaysxdmJJQXdSN1hNTDloUFkzMURKNkNFdTBPUDQyOVpTRXZ0c0pVTC9C?=
 =?utf-8?B?cy84WStSK3gxU1FzRkFuYTl4OHgwbXIwa0JhMHVRUmtoaEw4VlpEOUlaQ3I1?=
 =?utf-8?B?WlhKT3dMRCt2Y3FWUTAxOENPcVl1ZUUzSTVORURLYjNkY2JRaEpjQVE4WlJv?=
 =?utf-8?B?T0kxVFR4dmt3U1RHdE5IZXRzK0ZwUHBYYSt1ZUhUdWFhQ1JVOEp3bUJlVzhI?=
 =?utf-8?B?OVRZSmxlWGZ3VWdrbzR6aVdaZU50M2RtbEgvNmZHMGdVcDBoUlo2d2RwdHVC?=
 =?utf-8?B?YS9aaHpEN0gvZjF0NkNGcXoycElxWVpGUGM5TzNvNGlKSnN2WmhRTlo4WEV1?=
 =?utf-8?B?bUprWlRVL1NOREtlRVQ3eDI2blltekZMMEtDalR1RkwwNGdLVllBNEVYS0hL?=
 =?utf-8?B?NzRyWG84NG9pK3BTLzZ2ZEI4eUt4T0xDQ2IweHhPT0xCZ0luUEx4ZlJZNlFY?=
 =?utf-8?B?cUpLVUtFYXdOZkNrS2wwL3N6RG5mWFhFekRaUWc1SS9ONHAzaGllSnJ1c05i?=
 =?utf-8?B?VGlsRWtiQWFKM1I3VmhoY3hjNnZhaHN3U1gyVVVnaUNjVktheHdUWE9heVp2?=
 =?utf-8?B?TS9MSFhVY3ljTHNUbW8yeit3TG9BQlNhYW5UTTBQVEp4YlVqVVhMRUJpVldG?=
 =?utf-8?B?SjFhbHpkbDlKRDBpT1BGd2NxSjUzOG1YVGYwWTIwN3dFM3o1SVc0eGZaZ1ky?=
 =?utf-8?B?VXBqK2VLbjhSWm95Zjc4dlNTa1h6SnFtdU9XajJzZEF0U0QwL1RwR3BiZkJo?=
 =?utf-8?B?WEJFRzBzUmtjUmVsTHVIazZ2NkkvT2liSVcwRnh4MXIxVDBtcXNxT0lYQUlZ?=
 =?utf-8?B?OVVKaEgrYVhzQ1hhT2cxRmYvTnRHZ1RWbWNZMWVGclcxeEYxbUtHV3JROEgw?=
 =?utf-8?B?a0pzREZKMzFZRWpNRlkrL0pBcXVBU1ZOZUFla3MzVjNVUmoxT2U1clhuQzI5?=
 =?utf-8?B?eXhrOEVPeGp2YWxYamRTQmdOZHJFdDg3K1lPUTh5aklwOEx2REdlOEYzMXlE?=
 =?utf-8?B?blR1cmVIckhUN3c5NkFuMmJOeE1nQitHSFFFL3ZUU3YvRkt2L2pYNUJBNmpP?=
 =?utf-8?B?V2JYZzQzUjNZaGxBQ2UvdGRMVTJtUFRJRkdyOWNFWmN0WGU1Z3hzaEs2VHlY?=
 =?utf-8?B?VCtScUxXVmxaVGh5bG9KWCs2a0h5bjFqMnNMNlRSY0dNc2FITDd2VEVHSmlG?=
 =?utf-8?B?UGFuN2MzZ0JqSjdGcWI3QzFyc1VVTlc4T1RscGl0TjFsVmRCS2Y1Z1drS3hu?=
 =?utf-8?B?amxOREFXdkFONnFKUlJNK1lOY2VlczI0RDNDZTNPUnZHVVRSRmVvR1E2VFZi?=
 =?utf-8?B?YkVKZ21YeUJEaThQOUVtRjExUVUxYVJYNGZpZDNmUE9zeFEzZHNqZDM5QUps?=
 =?utf-8?B?S0tZaVU5dzFrV2UxNjMzOVl3TTJpUGlCcXc5M2lZalBBNitBZzNQbzBwTlM4?=
 =?utf-8?B?dG93NFdTcklxOHF0aDJTL2FFRTdIeGp3THhaRnJRbUJVeGE4aFl0Q1NCckcy?=
 =?utf-8?B?cE5tTEtHNSt1WG9BdGZHbGZqUmF5ZWJxYzFVYWpkdlpFckZXcE00RUtaWU1R?=
 =?utf-8?B?eFgzUXdLOUw1SHZwWHB6MHJ1ak5PUWo3OVNveW1wU3Zibm1UZmIzOEkzem1E?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P0iyDs65LIc4jcAITY961C3BgeNbYcPyQbmrnpmsqDUi+xzC+QNUdWHvFpn8BJz2FVeVGKRdyt/ltCWg8P+vqIoQdgcd7uiNvDAmUe5IsPFt62U23/Yk2t7uB+1iKbiggNFifz7QWT3VZtd+iq/+MRCJ8QVlfxd8ZgJEBQfQsJ+iHZtefdGlcO+nYWIhhc6c2DZWrqHzffy5ILPhoLAhrpG++5teWs8u4WeQuEkCEz5xXFU4wcCiR/ZT3u5UZ81Gd5okUWdYaYB/YXFbqcOUr0znXfYxaAGBsE2Z5hNmeqUC0XbTPfKD4dEQod6nVRaYVd26pYkDsNcdeSEusbOd7QvLeb3vI8TPjzIiMHkTiMNUaIfXKnzjvo0GZUuTQMccMMe3kyl7FxoXB9AGQdZlCKxHdjkHKki/iamyj6nwhjlE7oJZZX0+BmKgC5IE06o4kLE05IT27dAp+3NbdgTRyJn8Clpk7u6b1y0CR2xQhw0iWxx1S2Xx0XA6JkXq/502mxtySfUQp9D8bRVr17EGC6KKAYi1IHNX8Cc3Vq+J4qQVlnq+HHSR5F6swxuHEL5vNDRQ591343O1gUVuNLFVe+vgB3SLbbQad+9LoU8+q8Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b80986-a4bf-4774-f1e0-08dcb6dd32d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 12:33:53.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YIAQjFh+RWnmwiSKKXwcDYHZb2hDJgrwuS9JhFjEaTEYJixH83Jg0u51rfuqd0d9B9G1zdLGIBFy3LjQXVUNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_08,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=860 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070087
X-Proofpoint-GUID: vi16l93aRF8mk6U0ZXWQf4oowgMDpVfB
X-Proofpoint-ORIG-GUID: vi16l93aRF8mk6U0ZXWQf4oowgMDpVfB

>> +void
>> +xfs_roundout_to_alloc_fsbsize(
>> +	struct xfs_inode	*ip,
>> +	xfs_fileoff_t		*start,
>> +	xfs_fileoff_t		*end)
>> +{
>> +	unsigned int		blocks = xfs_inode_alloc_fsbsize(ip);
>> +
>> +	if (blocks == 1)
>> +		return;
>> +	*start = rounddown_64(*start, blocks);
>> +	*end = roundup_64(*end, blocks);
>> +}
> 
> This is probably going to start another round of shouting, but I think
> it's silly to do two rounding operations when you only care about one
> value. 

Sure, but the "in" version does use the 2x values and I wanted to be 
consistent. Anyway, I really don't feel strongly about this.

> In patch 12 it results in a bunch more dummy variables that you
> then ignore.
> 
> Can't this be:
> 
> static inline xfs_fileoff_t
> xfs_inode_rounddown_alloc_unit(

Just a question about the naming:
xfs_inode_alloc_unitsize() returns bytes, so I would expect 
xfs_inode_rounddown_alloc_unit() to deal in bytes. Would you be 
satisfied with xfs_rounddown_alloc_fsbsize()? Or any other suggestion?

> 	struct xfs_inode	*ip,
> 	xfs_fileoff		off)
> {
> 	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);
> 
> 	if (rounding == 1)
> 		return off;
> 	return rounddown_64(off, rounding);
> }
> 
> static inline xfs_fileoff_t
> xfs_inode_roundup_alloc_unit(
> 	struct xfs_inode	*ip,
> 	xfs_fileoff		off)
> {
> 	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);
> 
> 	if (rounding == 1)
> 		return off;
> 	return roundup_64(off, rounding);
> }
> 
> Then that callsite can be:
> 
> 	end_fsb = xfs_inode_roundup_alloc_unit(ip,
> 			XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip)));


Thanks,
John

