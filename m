Return-Path: <linux-fsdevel+bounces-39861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5709A1991F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AF3188BD3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F092153F1;
	Wed, 22 Jan 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="clTJRxHi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NwALQqXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0269DAD4B;
	Wed, 22 Jan 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573654; cv=fail; b=hBCW1t2LJscyBwILB0Ah/Ka+bRZFBGbvq6yqw44DYh3soMJo8YbPwKrHszAxs98cYJYqCTOCHaFRYyLTNuwEMdwImeb1gDPJumzYD558q5mX8z3XJznyLeMLY31UQmWsBz3o/0EhJR5+uqf2HbetcerdFDPjCUignimlTDRDqBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573654; c=relaxed/simple;
	bh=5xcc9d0GSIwCGp4deEIuuxgqVLRX03UhqJ5L2ZWqPyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4I/zHI4i6QmkEuip1QOwswihNU23Z+Rqma1G7T3IpeB7QDTuAf7TOn6Pg2H53vL4VnSPl1MjDySd7CtlZgcz5F7HEJWKb5MuCzkNGLj2IT44a+x5pjH2F4dQx9HUrIIRYjS5ksWgFkh8HCWdfllhckaLEmDf2aUSOIrdtHmPyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=clTJRxHi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NwALQqXb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGXewi010844;
	Wed, 22 Jan 2025 19:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nnAj4kszIlXbe3FoihoyOsSSzZ1IpA2MPRzrxUgdtPs=; b=
	clTJRxHiqSlvHYyiJRvszdgnQXWOCOeL5M+QW5HXf7z+BbfIKQy1DAhUaR4nfsYe
	/kc0sS9Yn3Q5EM5J2leykmLFLj5orxypT9H8hMMgmYZz31q1+DQuIpvnfPacHV08
	6T/zMTyweadChs9q/7deCnuiEqVjSOmrHWlgM4Zcoei8fiycDDcHLAU9oRhv77gt
	lgu+wylHSM6+GcC/t04JRoWZWeco7H90aPi5cGEOwghRkh+uLzQ4tkevgVb6RScz
	JMHu24dKTq5ZfN66ftAn6fsiJ97AgSp9By0VOY6XiUP6BpnOSjE6K/Pj6RAx2Wig
	CqU67iBC28j7dVBWSySWOg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx17fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 19:20:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MIYKTG030763;
	Wed, 22 Jan 2025 19:20:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fkjjqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 19:20:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT9HK2GNufOUWQssafnJvDDhedJObvaB2m/CLHy5kbjTUTTgClm7YwjOu0i5OOC312wm7nutTz07tRj9YVZWmPs+AUYWwsTGx7eQh5M3J/XKW6YctBGgaq0TPRQc4fi6K/j/JAIPHo80mTmvgJSl5+9SdMkQqIx3/l65dNTmjm0hY6+2LtaTiWEFC3HtVDpxm2ZcLnV4kejJrVeWSIZz/FsxvwnTrsHXL7XdXVQFgSPd29eR8+nG84tSYQh6GGqAoUjqtsmdDqycd0X+YC+WZQtldrqDKSeYtoUmAuXDd2aL4UX9X1RCAKKFykEcvOCXqTMtoGsxZRIg7V9rArZQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnAj4kszIlXbe3FoihoyOsSSzZ1IpA2MPRzrxUgdtPs=;
 b=X9wXcdyWxvHDd2J2KOqIalx+SmPKD/k4y8dNDmA7saDvutNJhzlb61gZZYMhZUUoYn/yyP9AoWQ2SysSNh+6xtPJGkFIlXp59Q6A5QOqJ98KoYODEKsvVWfJigrgaeAeRknJI9l7+jMbEzQqpqjTQxYlkYAAfcOe7YmZ2dVMCoS5PE9Uh5nEQKfSwmVDIgq7E7tMeqgHsnZrQFkEUrDYojTQOxxb1Rf7H4Mojw04TxBmsH1kkbobBM73gxzeIEpyooFyAsCspnmSY4PBfDrKPUsrrhBP7Ev+JyobekzxzO+rTPJZA0jKjHq6KzoV2MAfAEnL2nzanPZXpWUxhyRPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnAj4kszIlXbe3FoihoyOsSSzZ1IpA2MPRzrxUgdtPs=;
 b=NwALQqXb4msHiw6YKPJAwGitccOv/IMWw96p+Y2O1MQLa+hiIaTDw665lpsJQCC2Tj52F0cK5vXHOuoKmPmq9Tjvfk8a5OkZ8dd++HWKDjEIQ2w9S2LAU3uThVsidRdwYfm4A+J3YybyVpBHnllHhv8hvNc9PbemhrF1XOD9/Sk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:20:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:20:39 +0000
Message-ID: <d36de874-7603-478b-a01e-b7d1eb7110d3@oracle.com>
Date: Wed, 22 Jan 2025 14:20:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
 <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com>
 <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
 <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com>
 <CAOQ4uxiVLTv94=Xkiqw4NJHa8RysE3bGDx64TLuLF+nxkOh-Eg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxiVLTv94=Xkiqw4NJHa8RysE3bGDx64TLuLF+nxkOh-Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:610:cd::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f4fa0b-d174-4211-d508-08dd3b19db13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFgraWVucHRyMW44VjNCMjdCQkRucFVjNUdleFhwdmNXVCtRRndkYnZmL1Fp?=
 =?utf-8?B?RmxpZ01UaTlkeTZkbW1lWFpKemZmUndCc3FWL1RCdlJUNEJ6dHFlNDhQajNq?=
 =?utf-8?B?S3BjeVJjTEgrN1JxcW44cGowVmUrZEE5ckRlNURPN0xiMlZVa3o4d3BvQldq?=
 =?utf-8?B?S3cxWmZaL1VES2RGRkRRTUZ3eWtvQzErYU92aWNBZk0yV21NSnF3VmpNTEFB?=
 =?utf-8?B?Y0pCanI3aGFmOWZJc2g4OG9mUjF3VEdzWFFkUWNpODFadGF2eVdYSHVKaXRB?=
 =?utf-8?B?SFdlS2pYYWx2R0c4STJDeWdMa2NqSkJWSThMRGFDTG53WmxEc1JMTzZxT3hP?=
 =?utf-8?B?UnlESGIya0JmTVQ3Z3hLS3BTMGFuMXRSSGEzd1JtcmJyOFUyUVdPMXM1bFNX?=
 =?utf-8?B?N2VwT1VuQzczdHhYeFVzakxrdGljaXlVSDZZMGF2VFA3L2NocGRhQUNIOGxL?=
 =?utf-8?B?ZzQ5Z1cxZkpFaURnNzFBWnBibk1rZzQ2bDQwYUdjSW9Ld0M5WEF6TXAwcWJK?=
 =?utf-8?B?cy92QmZUaWx5MTlWUEJJWkpueFFjN3hNc3pOTW9oR2U0eDZUdG5tSENZaEpl?=
 =?utf-8?B?cUI0bEFDUi9wbWp2VDY5S2FhcFJkNFBZU1I0UjFMWUM1V09jQ0dGZnN2ZmZ4?=
 =?utf-8?B?dDBXNmEyaTZjQVUrRExrc0lKT0wvaENtVStVNUJpL1FjRytRRG83cXE3R3hP?=
 =?utf-8?B?d2dGekg3aXAxb3UzeEh5TDVRS2x2dkxvdDBRNng0LzJGbFUxVUpZTmx0MW9Q?=
 =?utf-8?B?akZhQjJjUCtKclRrQ1R0Y3ZwMG5OQzdsQUZ4dmVJQng2ZVQvU2c3SGZxRzZE?=
 =?utf-8?B?Y2x0eUkzb25wZWlGV2NrckF6c0pDbFhJZzlTSGZld1lFU2FKeFJLUEZ0RjNR?=
 =?utf-8?B?eWU1Q2Q5MUlQdkNYendkbDMwVHJFOWpvVzhzdWpXUmhzd1FSUGEyUXFmUzY1?=
 =?utf-8?B?SnpvcDU2bEdidHd0MXYzVURKV2p2QWFrT1AxQzdvL1ZadkdYZ2FkYmMzcjZY?=
 =?utf-8?B?Tms3dEJodmlmV25BYVdCdERJRXdLWVFobGpFODBJWjVKSmt6WnZkcStBbldJ?=
 =?utf-8?B?LzhDQmplWUJTcktUTEhPbDdwbHp2NHkrZndtdDlmbE1JZG5sVUh6d3lBNzRp?=
 =?utf-8?B?VTRnbVhLalRLc3BmaTZzYXNiZHNyZll1aWpEQlBSTXhtOEhIb3UxME5KZW40?=
 =?utf-8?B?Qm9GSXFwZ3hldEc2Z0xpUW83bnBRQ1hOUE9TRjVwMU5yVEhYcmJ1ZlJ2Z1N3?=
 =?utf-8?B?UUJZZVNyNlBBaDdXazJudFZZRnF1b28xbHhXeThXdWw2dG1NTkZSYVFLS2NW?=
 =?utf-8?B?bjVGcHpkMWlndXBjb2E1TnM4V0t2YkpKemZFRVRjbE1iZXM2dngxTzNxNTRG?=
 =?utf-8?B?bmN4aGRBRmVYQmplZEswZFgySWg4TFRJVGE3RDFmV04vdmJOTVM4ZmdaWjBY?=
 =?utf-8?B?WnMrL3BSMFhkSWgyNE9zWHhvUVg2WHFab0gvSUxCZm9pTEhOVllKSzFmTzdw?=
 =?utf-8?B?cnpSaXh3OGRZSUpjcHJaQStMcnp5L0Vzc1VDNHVYdEpDMEpRZWY5dUZQWG9L?=
 =?utf-8?B?bEhEYnN2cWh5SGNCazFGSmFyZ2JGOGxCODVxYnZHM21ZNURuTUxSMytSUWx1?=
 =?utf-8?B?WkRtbnJUc1ZuRmFpSjF0cjBvbDJycmpwMG9WdkNpbnJMaUZzQWgrOG9tS1Rr?=
 =?utf-8?B?RS8rZjBwNEszUmhscVBqZGtYUWlEL3RKYVp1YTJCT210M0J3bG8zSkEwbHh4?=
 =?utf-8?B?RnN2STY3NU9DelJQYitjbGh2MERPRlFnN2pCeTUvTCtlc1RudFRXNkpFVXlv?=
 =?utf-8?B?MmpwTEpRRitlcEZ6QllmRms4cXlDbkdqb0Z3ZTRqZEtBcndXL1V2LzVVa2R6?=
 =?utf-8?Q?3QFRtasxae0m5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEZ0ZEJGSVVmWTBEcVFvWHViWnpMM3JmV1NBdERBMjM5UTY5R1V5K2pCY1Y4?=
 =?utf-8?B?VlhPOUlVa0xlbUJKNWp6Y0ZxM25LNVVQcnNVWlVvc1BoUFd1VGRpdmp2a2J3?=
 =?utf-8?B?SWptNkk3UE4rdWY1SitCYUZaWll5REdWakJHQUVyQmYraTNSUXo1eEVKTkZJ?=
 =?utf-8?B?Mkg0RTVsS1ljRWFiZk1EVE01MmZVa1plWkhRYklBWXBVUTVIa0EzS0JLbjUz?=
 =?utf-8?B?Qndjc2poUEFOZzFnTEdBWGM0Nk9nUDM4ZWlZdk9BUk9KTHNvT1RRVXFsaFNw?=
 =?utf-8?B?U21mS2RPK3o0WWxmbnAweDBBV1BRNWhBUERWR0UwRlVaVUFaaHVNZ2tjTTlC?=
 =?utf-8?B?bkYxbjVDajR1cEllS1FCSjlnTkNFS1lIdmhKUVMrdVNMbFpad2hIWFRqeFEx?=
 =?utf-8?B?U2NjWDNZV0FJYW9hbmVRWklJZkRtSjBUeXgwUmVZRytpV1ZmamNIc0VDWXBh?=
 =?utf-8?B?NUZ3RHAvNDVLbU81M0k0amNzYWplellCWWMrOHM5Y0gyT1prMURiZUg2aVJF?=
 =?utf-8?B?YWw2OUMrcEw3SVBYRnZxbHFPNk5ZamNtclYycmh4S2FUdXdEYzBOQ2tQaG1I?=
 =?utf-8?B?UFJ1WGszZ3VGUVdlUzFWR3R0ZFN4emlDQXQ5cmQ5NXV6WUJESzFaQVRiYy9p?=
 =?utf-8?B?b0JZOFBoWnR1M2xXbFJFWDlobytURnptbEdNelNzUXdCRmN0bkw2RndKdnBX?=
 =?utf-8?B?QnBVc3RDbkNLNEtoekdobTVvM3UxSmhtNTdmVm9lSEFqeVdQZWNZWTRzVnRw?=
 =?utf-8?B?RGREWDVZeDFhaDZLNHFlVVJwdEFOVGhUSnIrTEpwTVFxREt5RXR6VXdIaG1M?=
 =?utf-8?B?cFZTNDEzSE02Y0MvRzY5d3lvb3pjK3hMbUluWHR6NzlOa1RNUW5xV0VZNXl2?=
 =?utf-8?B?NDllNW1hRnFuOE1FaStMK1pRTko1U2EyRGVLWFhZdUFCQ1Mya3NNbVd2ZU5t?=
 =?utf-8?B?c0NiZFlWR2R5VjRRU1BGWUpHeHVEb2tYUWxXc1JIWTRCaUJJUG92QWlTNTRH?=
 =?utf-8?B?N2k3SXp0dDN0WnBIL05Xc0RLMWYyWWZGVWwyWU5WMklsSXl5cHlTWE96Mjdh?=
 =?utf-8?B?UGh4RGo5azRXdTVQYngzR0hvUzh6QmJYbHlCaDJGNFVSUnVZTUZyTnpXRjdX?=
 =?utf-8?B?ZmhRQmVkcjd6UWRSTEZQU20wYitDRXFsTjZwcjczdFNMMGI2bXM3cXJBUER6?=
 =?utf-8?B?bTBid2xsc2IyY3N4eG4zc29RTGZRamhPcmV3bnRLRFk0Sndnd3NCUzhudHVJ?=
 =?utf-8?B?MEFYY3hkajkrZHVRdzdQRmJHcExTQ0VCVUxxZkRUQUtRZEFaaDArZFNOVWlL?=
 =?utf-8?B?cG5pa1dRdkh6S1o1K3MwUHMrTFNESFNpRFVHUmlBOUJvczNtUTkray93bGU0?=
 =?utf-8?B?TXE2dVdTM1dlbHE4OFZ5YmpRejB2bUxMTVlEanlxQVQyZzlycm5WSWVqSjZs?=
 =?utf-8?B?SFJDRnQ0N0V5YWM0RjB3RXkzWXErTkxaYWU3dTRkQWNqSlI5K0haMVNFd013?=
 =?utf-8?B?REdKU1NKU3NIREJWazJ6V0pkWExMQnVTViszNzAzendnVG9uREJ2MnFOc0l6?=
 =?utf-8?B?UTdza0hEUFFoVURhZW1SM3FZeU1yVlJCNmpwSGFtQUFWbUFQd09yM3RpK1li?=
 =?utf-8?B?c0pEby9jM1ArMEFFQk1LNC8vUDhiM2ZxZXh3YVBSOUl3S0xtQ3BlZ3lINzhO?=
 =?utf-8?B?bUhlNG43TTdxODduREFzdTgwWG4zSFNXdnRXQVcvOGNJWitjbFZyMWxvcGhE?=
 =?utf-8?B?MGxUNDJ6QnM5c0RQYkZmRkQyK0Y3WW9WSEtPRDYyZW1nTUdUd2JhRDNUV0Vv?=
 =?utf-8?B?NDdMYXNWRVpGTEFOdzVCYUlzbzB4V3lCT2VqREU0SjJieWhsci9NalE5Qlh5?=
 =?utf-8?B?clRibzVnV2s5ZWZXRXI2RUlzc0FGMjl6eU1Sd1NIQlVRU1FxZVNEQUhUZkZD?=
 =?utf-8?B?cnAzeFlERTJDdDBZWU5aZWJKbjJzYk16cHhDZnhJbzk4dlozMW1SdlluSGxV?=
 =?utf-8?B?U3ZSSUpyait4UGRFRXV6ajl6ckhZc0VrdmdhaGFrQzVVLzZjdllId2h6b3dZ?=
 =?utf-8?B?cDFpNkU0VVVNQzV1bkRHQWd6MW9Td0o4T3gyd3RSVlRJL2FZSjk0eDc1TlpQ?=
 =?utf-8?B?ZTRLdVJST1JvakNQRkRYbUxMU05LM2YvbkRGcXNheWlMRm15Yk5sYm9MT055?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZGffA0eDcan9NKbeglyr4UmPx63+DDemelMz9wwyZ92HcQRfRa4uA/bDufbnpfbwCpcrqXB29R2JFrQ2/6ED2n13fi2J8eJ6R/huAYq3Vr8xz6lv2y5BUFAn9X/9Bhin7m21HniawlGaCKwSxLQ97Hl7E3hmsEBF261IFBz3YbxUaWDIde4hFFxc6LiXH7oXQZx2jQNbmeaXoMH037HeXkh4yNjmNbwwxrWvl4YGw5FeW2VhmhYF5KmA3W2Kw06uO+OhOe3f1jnhhF5Rv+v7mTvT+/OgeYKaH2FemO6dNEUYZbqss75phQ20XRs5M1G29Ie6hez9OoVxmbr9u7oXlEyZz7pbu9N1JMghWHaxIPOFDIKPxJAjEWdhakKsCdRKZnC6tz8jzIRDMheXm2vXhiguJ6WapzTQ6jjkcHoyKC1TV/T8ryCNuy7YaIuEjn07Gs7b4WALVHjkEI/Q5HlZzMPfbZJnvmcf32CPO3hHC/9cqiyrs/WCBOsu/lg0ljRRSP04fJQaBJJPrwTLHJVq6U324QhxgPOGUOkFCsJbWo5Jf8F2KRl3hlO/agvBKM9O9UpgcFYMYfVYoZQUGAAabqoEluSNN+8D6k4IWcq7Yng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f4fa0b-d174-4211-d508-08dd3b19db13
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:20:39.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIDHCyroVjhBwWFEmM6qsD0m1pqyXtIfSuKXNQjVGWzWCSVNa5lkFPX0dppX6eZ87GohLKjh+pnuLFhkeAnakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220141
X-Proofpoint-ORIG-GUID: DcfhR81bWMJorXvzQ8oy_NkbH2WX-AIJ
X-Proofpoint-GUID: DcfhR81bWMJorXvzQ8oy_NkbH2WX-AIJ

On 1/22/25 1:53 PM, Amir Goldstein wrote:
>>> I am fine with handling EBUSY in unlink/rmdir/rename/open
>>> only for now if that is what everyone prefers.
>>
>> As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
>> correctly. NFSv4 REMOVE needs to return a status code that depends
>> on whether the target object is a file or not. Probably not much more
>> than something like this:
>>
>>          status = vfs_unlink( ... );
>> +       /* RFC 8881 Section 18.25.4 paragraph 5 */
>> +       if (status == nfserr_file_open && !S_ISREG(...))
>> +               status = nfserr_access;
>>
>> added to nfsd4_remove().
> 
> Don't you think it's a bit awkward mapping back and forth like this?

Yes, it's awkward. It's an artifact of the way NFSD's VFS helpers have
been co-opted for new versions of the NFS protocol over the years.

With NFSv2 and NFSv3, the operations and their permitted status codes
are roughly similar so that these VFS helpers can be re-used without
a lot of fuss. This is also why, internally, the symbolic status codes
are named without the version number in them (ie, nfserr_inval).

With NFSv4, the world is more complicated.

The NFSv4 code was prototyped 20 years ago using these NFSv2/3 helpers, 
and is never revisited until there's a bug. Thus there is quite a bit of 
technical debt in fs/nfsd/vfs.c that we're replacing over time.

IMO it would be better if these VFS helpers returned errno values and
then the callers should figure out the conversion to an NFS status code.
I suspect that's difficult because some of the functions invoked by the
VFS helpers (like fh_verify() ) also return NFS status codes. We just
spent some time extracting NFS version-specific code from fh_verify().


> Don't you think something like this is a more sane way to keep the
> mapping rules in one place:
> 
> @@ -111,6 +111,26 @@ nfserrno (int errno)
>          return nfserr_io;
>   }
> 
> +static __be32
> +nfsd_map_errno(int host_err, int may_flags, int type)
> +{
> +       switch (host_err) {
> +       case -EBUSY:
> +               /*
> +                * According to RFC 8881 Section 18.25.4 paragraph 5,
> +                * removal of regular file can fail with NFS4ERR_FILE_OPEN.
> +                * For failure to remove directory we return NFS4ERR_ACCESS,
> +                * same as NFS4ERR_FILE_OPEN is mapped in v3 and v2.
> +                */
> +               if (may_flags == NFSD_MAY_REMOVE && type == S_IFREG)
> +                       return nfserr_file_open;
> +               else
> +                       return nfserr_acces;
> +       }
> +
> +       return nfserrno(host_err);
> +}
> +
>   /*
>    * Called from nfsd_lookup and encode_dirent. Check if we have crossed
>    * a mount point.
> @@ -2006,14 +2026,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> svc_fh *fhp, int type,
>   out_drop_write:
>          fh_drop_write(fhp);
>   out_nfserr:
> -       if (host_err == -EBUSY) {
> -               /* name is mounted-on. There is no perfect
> -                * error status.
> -                */
> -               err = nfserr_file_open;
> -       } else {
> -               err = nfserrno(host_err);
> -       }
> +       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
>   out:
>          return err;

No, I don't.

NFSD has Kconfig options that disable support for some versions of NFS.
The code that manages which status code to return really needs to be
inside the functions that are enabled or disabled by Kconfig.

As I keep repeating: there is no good way to handle the NFS status codes
in one set of functions. Each NFS version has its variations that
require special handling.


>> Let's visit RENAME once that is addressed.
> 
> And then next patch would be:
> 
> @@ -1828,6 +1828,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct
> svc_fh *ffhp, char *fname, int flen,
>          __be32          err;
>          int             host_err;
>          bool            close_cached = false;
> +       int             type;
> 
>          err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
>          if (err)
> @@ -1922,8 +1923,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct
> svc_fh *ffhp, char *fname, int flen,
>    out_dput_new:
>          dput(ndentry);
>    out_dput_old:
> +       type = d_inode(odentry)->i_mode & S_IFMT;
>          dput(odentry);
>    out_nfserr:
> -        err = nfserrno(host_err);
> +       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);

Same problem here: the NFS version-specific status codes have to be
figured out in the callers, not in nfsd_rename(). The status codes
are not common to all NFS versions.


>> Then handle OPEN as a third patch, because I bet we are going to meet
>> some complications there.
> 
> Did you think of anything better to do for OPEN other than NFS4ERR_ACCESS?

I haven't even started to think about that yet.


-- 
Chuck Lever

