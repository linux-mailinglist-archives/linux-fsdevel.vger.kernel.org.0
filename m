Return-Path: <linux-fsdevel+bounces-39851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434DA196DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF7416B18F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A698215058;
	Wed, 22 Jan 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6bE9aXz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qF+PIjK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4021422F;
	Wed, 22 Jan 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564644; cv=fail; b=O+zQvQldA+wMpw2Oz2h26QpodJoK1/Hs1isiFyMbV1nBTK0Z2w44h9ko7cPg7AeocW4MTO69Y+C/a9zRUebFdXpdhHIkyjKDZkRB+Vbn5jVSfFu3tIFRDU92oQWCmypLiiQ5EWak2R3RZ5YhMiPQoRgH6i++OV5kJDAlLEcN6LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564644; c=relaxed/simple;
	bh=oXnTqHWtL551jUgqqg+OvKDDLSzPyyXh/ewjAdNa5EY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VsVelQEDt/T7z6NHwSChkfXbN4fGnQgquoDH/fBTYW10zrYm2NthPGtAcbX80yxNFV806cpfoXzvz1KpyOp6HpUebzx3ptmtxavNCC1PWGkKxVw3DaG1NGVezvxZMWQYrFn0vkGav95kQXGpHo0EZNJtN9csS6rnXoI/66z+SAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N6bE9aXz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qF+PIjK0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGXegV014927;
	Wed, 22 Jan 2025 16:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+NeC96qRN5vBxjwiZyGnh54ioe2NF8id0lh7/A2T1Uo=; b=
	N6bE9aXzXBJrvx6/N/FRiHw5dgU2HE+9uv5SrCs9YiKBtPg/uz9cTWTIbsGn/Mtu
	Fpex4t00Y+8fLD5dsskoLiCU24nseyrLb3aKKa3x7gzZKBc9oZCD6FYQWulSaWWe
	n4B8tO+pX5fyWwtbeCVQMDW3tmXmcGnIrLhOaweAfVpv3nTrZI7twOkY/dm5GoMc
	NKy8S4bDoUNIEH8zmoXEKraZnU6bYKWdrMNqHdjU5RdWsxivFOxypkXsBeh4c9zl
	omSaDVJFBnlh2peUV0lC0saWLAh5L9v/9N1ADMAuAGhaEA3ErrxHR8bZQipQk7Ff
	GVZzZGcTdo1r8269OSwhcw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qm0511-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:50:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFjECB030587;
	Wed, 22 Jan 2025 16:50:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44919427mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkmTZnQFiNK0LWXof83qJUYdqzdhBus2/XpHetCezuH+zwdjCJ+pGukInqJyVxsU12fKFf3N0oEuo7xuRaxU+yZBXKwMYiBhWGMn93gEQVFkHQfBt3RwfqYmFqzwvEOKRLoo3r9rFHXpjD4GzG1mnHGoA35DNLvq5ylSaLDh8bPr+PeWaqi8j7Bzl6gPlL6vCMfFhAMYFCeYotDUSbf8LhbHIvKQiuzSqeQZ3IpMtjhIwte4ycU6n9fPgyrk9hbiB0VNCUAgp2gZmljwPKpZjFOZ7w4z/JXMI9535m/Qm9yZE0zdGZaT8EeLFA4KUsob7Ca3VO+Px3cur5Z9fnkUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NeC96qRN5vBxjwiZyGnh54ioe2NF8id0lh7/A2T1Uo=;
 b=CodmleMBXN8q7YE7q+SsYC7TJHk35xLzllgzibZicZX2Lz5ev3u0VzvnSck9oxB/gt2LDasZJNmY4W8QjzL6prkA802JkrxDH3HbyOB5S+HtpIslXyg6ybSQzopfpWfseoLEnqyiVcz5Wyo2aJIsOwqpd4rU4M3HUCtf0JzXvkPSuudW7RS8YmYO/z44LJ5Hf0tG64izWf+gBbFaOqeribVyGXgra9t2eh77CYZzUKEG5mhXgaCScvDkVwZnAWTEXy2DF7z1tLTfekdmu4MKD0FQnN0YrMpd7ulBqjxR8q6xSyXEhRAPjK/8Yu+haUozLdKjsp56BUATpSHCzynY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NeC96qRN5vBxjwiZyGnh54ioe2NF8id0lh7/A2T1Uo=;
 b=qF+PIjK0P75jqbL5t/pDFmpJa+Sea0/Srd2Ug5nY7Ui/PZfV1SZtpA70HLLcicqhNM0UII2HwnZBMK2RAQpldUVsiJvirZOEaDkXA5+8zphZTuFJX+84Q/x/DCyixTRnCqS2iqyF6gZgWRmSjQGtFZw2AHXDIxHnxXxaR+DI+R8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 16:50:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 16:50:24 +0000
Message-ID: <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com>
Date: Wed, 22 Jan 2025 11:50:22 -0500
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
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:610:b0::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b00bd95-e454-4765-1b43-08dd3b04dd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0R1YnZ6Z3RVWXFJMnpLUGV4a2RWSUZFZEovb2grMkJlN3BLd3R2eHZOVDdj?=
 =?utf-8?B?cTJINnFWaTZ3Z1pISEdtUnNkNDd4V1NNSThGT28vUTZDdW5ac3FSbXdxQ3Zq?=
 =?utf-8?B?dTdjM0lUTzdkTlhZZDBKV056dzhwMU9FZys3SGRwZGdxMUZGMm15VlRoaWQ4?=
 =?utf-8?B?RVhUSmRLRURFcW5vSnRpYXNRa0ErWTg3eGd5cTRZWVp6T01rQ0pqY1c4V1dW?=
 =?utf-8?B?T0FNKzJpWWFoUlNoYUt2bXZaVjN2UWVuNUQ5dzFFaU13eHptMEM1ODI4MjRl?=
 =?utf-8?B?M1pRY2w0QmEvd2k5cUxmMWZSY0ZsZXZKbmVHZ29GSDVWZTdPTUcwaHdaMDhF?=
 =?utf-8?B?cEFVU21NMmoyS2JwMVUyS3Y1V2xYOVg5Q2RnL2dMWllGU1RkaGhpeWlqemFG?=
 =?utf-8?B?YW0yMUZJL2JPWDVQa3BhWDhMMk85VlZxSmtOd0QrdFN0Q3BmVU4xVzJiMlpK?=
 =?utf-8?B?UHRSWkJuMnBlN0V5T2xFSnhwN1Z1L25PbDA0aHJBMVF3eWJpc1BoNGNlekh5?=
 =?utf-8?B?TTlweUEweHYvd1hUTTdtd2wxNVVINldlSWgxcmpUdEdySzM2ZGhEY1NxZFl2?=
 =?utf-8?B?UUJvUGVZUkcwQkQ2TmhBcTVuNENOSkJJY0VVcGRiV29RZTlLMzJaZ3RlOXlS?=
 =?utf-8?B?NTVWTlBWUkUxTlBuUGc5c2Rta3ZNOHZnS1JzY2oybGRSWVJidG83OXhDcytR?=
 =?utf-8?B?MkJHRnNMSXE5MzZrbjJPZDZMenBPWEZZL2hXN1NTQ0x5RmdsQVQvOVFXQUV4?=
 =?utf-8?B?VmtvK0tFTEdsU1lvVER6QUxLbytRd2NwcHBwR25RVW5BdllaODFzU1pmZVhq?=
 =?utf-8?B?Z3MwYm1jczkzS0NwTTQ0eXRqQmJxSXJzaWpmQzVSSnlFbXFIei9mRlE5UWZZ?=
 =?utf-8?B?cnBzYWVQOXpyTGJHODg1cklROUlEbGV0Qjg2MEVvRVdUL3Y1TXFlajV3b1Vm?=
 =?utf-8?B?bmN3cHdlZFdOVTlobk9qTGFUSm1vZDd4VVE5SzZRbS8yUGVWZmRFbG9hekly?=
 =?utf-8?B?bENRL3lSemVHOTJ2RDAzSTBFYUQyR0hrSGdZUFpESzYrYTdETk8yeG1uTVM2?=
 =?utf-8?B?UkdjL094WG8wYUNnTTRWdkdTbVkxV2hmN2ZNb0F1a2ZTNDlQN280dExDTk50?=
 =?utf-8?B?V3dOM1NhK0VwTm00a3VRT0ptRE50VHFuV25vSjNqNHZFQVRMMXJKU2xWTnNR?=
 =?utf-8?B?ZEtpQnFOc0F6VDhHSTlUazROODBmUkh3WmhubmpNaTN4OTA2NlpFclhiVTQz?=
 =?utf-8?B?N3lKVUdiRGdQVHg0a1hESDBkWW5OWmRHeHd0Z3l0bVdtR1VQUHBzWWFRU3hE?=
 =?utf-8?B?aEFSODJDMTVCY0duWHhMQnVZcnNiS05WeGgxRjZZZ1NsTkY5cFo0bFpmSy9x?=
 =?utf-8?B?Ykt4bFFQWGZkczExeG1HSmJndVFwK2VZMDZmenVmNjNzOWttelh1ZFhuTnh1?=
 =?utf-8?B?UFhSNWZKU2M3K1oraUo3YXVSbHI5OUhtc2xDYTEvMTZpSDBjRWpQcXJ1WVg3?=
 =?utf-8?B?cCs2WHcwSG9teGZKVWNvR2k0dlJKRnJMTVBEb3R6SWdHSngyV1lDQjJlM1ZB?=
 =?utf-8?B?c2ZHak1yVW9pL0NsZkxCOWhXd2JSTTZmai9PR3lTV0ViZXVIUEZBTmYrQ2FF?=
 =?utf-8?B?NGFzeGhrbVNnTEVJVDFSYjlaVE53c3lReGc3anBtMHJxVVQyTy94Ny9RdXhu?=
 =?utf-8?B?NUhSN0s0bzR1cTdwN0ZvWWN0NEFhRGhwTzUxbVdDZ0Y1N2JwY2VKN3l6blBW?=
 =?utf-8?B?WDRDZVJaNFZVeHEyaVFaQWlGU29YTnNhQ0todlBpMDQwZUc0Si84UzZtTnh3?=
 =?utf-8?B?SS9JMzh3dEUrR0lQeWhCLzNnUkNMdXRiZjdLbUd6c3RobWNLNm1nSEdkSzVr?=
 =?utf-8?Q?b6EvrAAJoAXC1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enJBUTFUdys0dDhRdER5Z08rOWZFc2tkVXNPMlFvVnNpdWViMitPaU1KbVJE?=
 =?utf-8?B?bWEvL1dBSGVPQUdFYWJ1K0M3OUZRZXVaMTRmbG9HNFllZEJSRHRQKzhlbkRl?=
 =?utf-8?B?Z0duTFEwbTBjU3B0bEozSllOb0tyczBRWkk1RWVFZ3BXVnF1VFg2NXpFR0Vq?=
 =?utf-8?B?bE9EMUxXZmlPcVo2Q1Q3UXlKc3c1QWpJa3Q1Z2JrdjhoaUtiempRSGR3NDFL?=
 =?utf-8?B?a2dmNnU4M1FMT2VKK3NicTRsSDNsQmVaQy9oenNKUURkZUpvcTJuYnY0V2lS?=
 =?utf-8?B?UkVDTStqVkdRamdPZFRXeHVETitqYTI5STJydkluYWdRV1VGWFhZOFZsTmJH?=
 =?utf-8?B?N0V1M2pGL0xaRko3bjhSaHlSLzRnUlJrdC82d2hHcEVBbFJNYXk5SXZYdEVU?=
 =?utf-8?B?LytWKzFyT1ZLOHUwb2xMSzlsZmN5c3hSejFRbWRCeUUrb054aVBmSkxPZlJh?=
 =?utf-8?B?RXE5UThyUnloZXlDUjIwclVCb0wyMEh1TzdDM0pKdXAvZEkwZUhZTjROcnZB?=
 =?utf-8?B?UWxIM3BWQ2Q2T0EzT0dvSXBqY1BhcEdaTE9JdFVDL1FReiswVDVkNVVRcWJn?=
 =?utf-8?B?UFh1cVh6Nm5mdkdtaHgrb1l4OFdtNG9hNGxkek9oNnZMSFpOUlFIUFdOZlZy?=
 =?utf-8?B?aWp0akU0d29RVHJJQThrcm1Cd01vYjRrTjhNTzJLRWhJUTV3aVQ2V3pOcEI2?=
 =?utf-8?B?SFdjQUZrR2tXV2FnS3RWaUZnbkpZNnJvYU80eGxZKzdZTnNJZ09naExZMi9D?=
 =?utf-8?B?WnFYU09FS1BwblZGc2R4aDBrTEplbm90alNiMVFpMUsxWHRKNEt5VGtPS3BZ?=
 =?utf-8?B?Zm1jbkY2VWZ0bnJ4VTRkeTRBSnJTUk5GbXRqd09JN2lleFlDRlVyVGRGVHRL?=
 =?utf-8?B?NExKSm9YUVJNd29sN2JDdDc1a0huc1dwYWhwUnlGZGFETlFIaU9FclFXYnEz?=
 =?utf-8?B?SUdxYkZZbU9zOTZGc0RBSWIxRWoyWVhQOHp3OWl4VEZuSWNvRlpxbkpVRW1y?=
 =?utf-8?B?dnNSVUkvWlJOVEZhNHB2L2dVTEFIVmZrKzRaRXlUYm9mKzhzQ2FYY1B3QW5n?=
 =?utf-8?B?aWtyUnlYRnFweHF6aVNOTmZnczY1d0dUU0ZiMFVOK0Z6NDdPQlZocC9HMDB1?=
 =?utf-8?B?M3dPUjEyVFlGNi9Tc1M3SzZETjVvRXVZTkxwYXFtdlBQQkZaSnBnK2dBblJt?=
 =?utf-8?B?bE1tTW8rNFBQNWV3d1dRWlI0S1paeFNFUDJXQkJHRDhucGhteU9jb0owZ09R?=
 =?utf-8?B?blRZa1BjM2dwTkdkcDJSeVhVMDF6UUgySFJIcGV5SnJKalZaMlRZVUhJY0NU?=
 =?utf-8?B?WmxFZ0Nqd1dZWnNtQWZqb1cvNng3T0ZTVWVGMnlRZGRmd2R2WXpyN3BlZGpq?=
 =?utf-8?B?cjFjQnJBMUxudXk2ZHRCMW40akRXeDkzMTFCRmFLdGJyMC9EMGNKRVordkRl?=
 =?utf-8?B?VTlNQzVhaUVoM3MwR2ZsWGJpUXdaVGRYRTlOUmxKYVZLVW1zSjFmZUI2VWl6?=
 =?utf-8?B?a0c2MWZmL25hV09MOGNkWVBYMlZodjh1SnRXc1lMNk9ONzNTelJ4OEdSV1Zn?=
 =?utf-8?B?QjZTOTNZRmRHWGhMY01pcTNGWS9NVGo1TWZwa09WbWM4RjlhUG5SQ2V1Snh1?=
 =?utf-8?B?ZGpOWkhyNzhqT0xKRENNUTFRT0txejlNdkNxNWFETHpmU2RsamxFOG9sb0lB?=
 =?utf-8?B?dnE5R2YzdE51aDM4T2RTVTZsRitCOXk4TEIxeTlvTUNNRE1kWlhHVmw4MWZx?=
 =?utf-8?B?SEcxUmt1dExPRHorbzc0N0JrZjZYN3RCNXRpeFR3Y0VjYVh4bGRMend6Syt3?=
 =?utf-8?B?RUREWFJJajQxWnQvTXFIdHFNOVhFdFRLdUlhbTBYYVYyZVJGRWw2QitNN09C?=
 =?utf-8?B?eGFlUnI0SS91NExPWVNlZ2dMdXAyVWdDUkEwNVE2MDhGYUI5bHJhZGNyWGh0?=
 =?utf-8?B?U28zMHZnRjZnS2tiVDlweXNidE5TOURQcjM2Y1JUekp2dlFYbTMyM1lzOGpV?=
 =?utf-8?B?cG42dTRDZVZsVE9BVVhucWFMYS9lanBZVHJSa3FsR2d4Tlp3RVUrem9UYW1G?=
 =?utf-8?B?Z25TaEttNmllSWVYMU55TzdOY2c5TDJBTXVVMzJtRzVvMC9WdTRhektyd0E3?=
 =?utf-8?B?QkVHdTFZOTdoMFB3TUpNbTZVZ0hGVGR6SFZNTzlRWDhpVDhPSzRkMTBDUGFV?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1mMmc571wLGuspJQcs/kppj2C2Ua0Gs/HBuqMDr6Rc1/ia4S/YXNjmO6S5VMiPFk/mbxp0grrDCp445+D47rurTU+WjU400+IMxkjt77gznSQFi324M06O++USSXnIonBjxTnT6BU3um9O7V694v0qpvDj/U5eXRMAguKmNtT3ikMTjn2lSMzX3TDhSbZ0XE1qVD//3ohhoYhbOo6zuKF6QKXnJYwTdmzvWNdczkumEWThVWk7WWjXPy9YpmmPCsGs8fxLwZQ2gG6273A4OFl4z2tSA3W+XJM6DDjVhWtjUKu/yr/WxylWLaoo4DXqaGX8wScwlVPv9qLpQY6hsWDyROaVKXDlZgig9MuLZp0VaTThoaB4xXUoHSpOLP9qO2xzxc528cnI1g0uzsprRf5ylRtFGnPPS7YTMdYOY+k2I8XNNktFH9n1MdCMMhVrbib14y1XvbzH29pJgpluYvd6ceE1Vs7MKH5hiYuQg6riXYgksiXX5M21F1Kw3ZhuuFmUQ+uUXGfvJXOcLjGy2jWI7fnS8RJoWT4s5tKZjTqxyCHV2IX2V3siOyvr7bNoRki3qX5aufixoQzOPYUbd7VLRVLCy4F1LJ8ck53LPT7cY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b00bd95-e454-4765-1b43-08dd3b04dd99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:50:24.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMWYK6vcJwbd503AJn84mpvV1MvUZkb2SBYEiO/sUSZjfZqJ6QJGCx6YDUjTssIufshm6O1K7bqeFROndK9Olg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220123
X-Proofpoint-GUID: vLy6NUIooplcT2YbI-pOWe8H6ZXR2Wg5
X-Proofpoint-ORIG-GUID: vLy6NUIooplcT2YbI-pOWe8H6ZXR2Wg5

On 1/22/25 10:29 AM, Amir Goldstein wrote:
> On Wed, Jan 22, 2025 at 4:04 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/22/25 4:05 AM, Amir Goldstein wrote:
>>> On Tue, Jan 21, 2025 at 11:59 PM NeilBrown <neilb@suse.de> wrote:
>>>>
>>>> On Wed, 22 Jan 2025, Amir Goldstein wrote:
>>>>> On Tue, Jan 21, 2025 at 8:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>> Please send patches To: the NFSD reviewers listed in MAINTAINERS and
>>>>>> Cc: linux-nfs and others. Thanks!
>>>>>>
>>>>>>
>>>>>> On 1/21/25 5:39 AM, Amir Goldstein wrote:
>>>>>>> Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
>>>>>>> mapped EBUSY host error from rmdir/unlink operation to avoid unknown
>>>>>>> error server warning.
>>>>>>
>>>>>>> The same reason that casued the reported EBUSY on rmdir() (dir is a
>>>>>>> local mount point in some other bind mount) could also cause EBUSY on
>>>>>>> rename and some filesystems (e.g. FUSE) can return EBUSY on other
>>>>>>> operations like open().
>>>>>>>
>>>>>>> Therefore, to avoid unknown error warning in server, we need to map
>>>>>>> EBUSY for all operations.
>>>>>>>
>>>>>>> The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
>>>>>>> to NFS4ERR_ACCESS in v2/v3 server.
>>>>>>>
>>>>>>> During the discussion on this issue, Trond claimed that the mapping
>>>>>>> made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
>>>>>>> protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
>>>>>>> for directories.
>>>>>>
>>>>>> NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
>>>>>> file system objects. Here's what I find in RFC 8881 Section 18.25.4:
>>>>>>
>>>>>>    > If a file has an outstanding OPEN and this prevents the removal of the
>>>>>>    > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.
>>>>>>
>>>>>> It's not normative, but it does suggest that any object that cannot be
>>>>>> associated with an OPEN state ID should never cause REMOVE to return
>>>>>> NFS4ERR_FILE_OPEN.
>>>>>>
>>>>>>
>>>>>>> To keep things simple and consistent and avoid the server warning,
>>>>>>> map EBUSY to NFS4ERR_ACCESS for all operations in all protocol versions.
>>>>>>
>>>>>> Generally a "one size fits all" mapping for these status codes is
>>>>>> not going to cut it. That's why we have nfsd3_map_status() and
>>>>>> nfsd_map_status() -- the set of permitted status codes for each
>>>>>> operation is different for each NFS version.
>>>>>>
>>>>>> NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMOVE.
>>>>>>
>>>>>> NFSv4 has only REMOVE, and it removes the directory entry for the
>>>>>> object no matter its type. The set of failure modes is different for
>>>>>> this operation compared to NFSv3 REMOVE.
>>>>>>
>>>>>> Adding a specific mapping for -EBUSY in nfserrno() is going to have
>>>>>> unintended consequences for any VFS call NFSD might make that returns
>>>>>> -EBUSY.
>>>>>>
>>>>>> I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove(),
>>>>>> nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
>>>>>> trigger a warning.
>>>>>>
>>>>>>
>>>>>
>>>>> Sorry, I didn't understand what you are suggesting.
>>
>> I'm saying that we need to consider the errno -> NFS status code
>> mapping on a case-by-case basis first.
>>
>>
>>>>> FUSE can return EBUSY for open().
>>>>> What do you suggest to do when nfsd encounters EBUSY on open()?
>>>>>
>>>>> vfs_rename() can return EBUSY.
>>>>> What do you suggest to do when nfsd v3 encounters EBUSY on rename()?
>>
>> I totally agree that we do not want NFSD to leak -EBUSY to NFS clients.
>>
>> But we do need to examine all the ways -EBUSY can leak through to the
>> NFS protocol layers (nfs?proc.c). The mapping is not going to be the
>> same for every NFS operation in every NFS version. (or, at least we
>> need to examine these cases closely and decide that nfserr_access is
>> the closest we can get for /every/ case).
>>
>>
>>>>> This sort of assertion:
>>>>>           WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
>>>>>
>>>>> Is a code assertion for a situation that should not be possible in the
>>>>> code and certainly not possible to trigger by userspace.
>>>>>
>>>>> Both cases above could trigger the warning from userspace.
>>>>> If you want to leave the warning it should not be a WARN_ONCE()
>>>>> assertion, but I must say that I did not understand the explanation
>>>>> for not mapping EBUSY by default to NFS4ERR_ACCESS in nfserrno().
>>>>
>>>> My answer to this last question is that it isn't obvious that EBUSY
>>>> should map to NFS4ERR_ACCESS.
>>>> I would rather that nfsd explicitly checked the error from unlink/rmdir and
>>>> mapped EBUSY to NFS4ERR_ACCESS (if we all agree that is best) with a
>>>> comment (like we have now) explaining why it is best.
>>>
>>> Can you please suggest the text for this comment because I did not
>>> understand the reasoning for the error.
>>> All I argued for is conformity to NFSv2/3, but you are the one who chose
>>> NFS3ERR_ACCES for v2/3 mapping and I don't know what is the
>>> reasoning for this error code. All I have is:
>>> "For NFSv3, the best we can do is probably NFS3ERR_ACCES,
>>>     which isn't true, but is not less true than the other options."
>>
>> You're proposing to change the behavior of NFSv4 to match NFSv2/3, and
>> that's where we might need to take a moment. The NFSv4 protocol provides
>> a richer set of status codes to report this situation.
>>
>>
> 
> To be fair, I did not propose that in patch v1:
> https://lore.kernel.org/linux-nfs/20250120172016.397916-1-amir73il@gmail.com/
> 
> I proposed to keep the EBUSY -> NFS4ERR_FILE_OPEN mapping for v4
> and extend the operations that it applies to.
> Trond had reservations about his mapping.

Well, Trond said that FILE_OPEN is wrong to return if the object
being removed is a directory. It is the correct status code if
the target object is rather a regular file.


> I have no problem with going back to v1 mapping and reducing the
> mapped operations to rmdir/unlink/rename/open or any other mapping
> that you prefer.

v1 doesn't fix Trond's issue, IIUC.


>>>> And nfsd should explicitly check the error from open() and map EBUSY to
>>>> whatever seems appropriate.  Maybe that is also NS4ERR_ACCESS but if it
>>>> is, the reason is likely different to the reason that it is best for
>>>> rmdir.
>>>> So again, I would like a comment in the code explaining the choice with
>>>> a reference to FUSE.
>>>
>>> My specific FUSE filesystem can return EBUSY for open(), but FUSE
>>> filesystem in general can return EBUSY for any operation if that is what
>>> the userspace server returns.
>>
>> Fair, that suggests that eventually we might need the general nfserrno
>> mapping in addition to some individual checking in NFS operation- and
>> version-specific code. I'm not ready to leap to that conclusion yet.
> 
> I am fine with handling EBUSY in unlink/rmdir/rename/open
> only for now if that is what everyone prefers.

As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
correctly. NFSv4 REMOVE needs to return a status code that depends
on whether the target object is a file or not. Probably not much more
than something like this:

	status = vfs_unlink( ... );
+	/* RFC 8881 Section 18.25.4 paragraph 5 */
+	if (status == nfserr_file_open && !S_ISREG(...))
+		status = nfserr_access;

added to nfsd4_remove().

Let's visit RENAME once that is addressed.

Then handle OPEN as a third patch, because I bet we are going to meet
some complications there.


>>>> Then if some other function that we haven't thought about starts
>>>> returning EBUSY, we'll get warning and have a change to think about it.
>>>>
>>>
>>> I have no objection to that, but I think that the WARN_ONCE should be
>>> converted to pr_warn_once() or pr_warn_ratelimited() because userspace
>>> should not be able to trigger a WARN_ON in any case.
>>
>> It isn't user space that's the concern -- it's that NFS clients can
>> trigger this warning. If a client accidentally or maliciously triggers
>> it repeatedly, it can fill the NFS server's system journal.
>>
>> Our general policy is that we use the _ONCE variants to prevent a remote
>> attack from overflowing the server's root partition.
>>
>>
> 
> This is what Documentation/process/coding-style.rst has to say:
> 
> Do not WARN lightly
> *******************
> 
> WARN*() is intended for unexpected, this-should-never-happen situations.
> WARN*() macros are not to be used for anything that is expected to happen
> during normal operation. These are not pre- or post-condition asserts, for
> example. Again: WARN*() must not be used for a condition that is expected
> to trigger easily, for example, by user space actions. pr_warn_once() is a
> possible alternative, if you need to notify the user of a problem.
> 
> ---
> 
> But it's not even that - I find that syzbot and other testers treat any WARN_ON
> as a bug (as they should according to coding style).
> This WARN_ON in nfsd is really easy to trigger from userspace and from
> malicious nfs client.
> If you do not replace this WARN_ON, I anticipate that the day will come when
> protocol fuzzers will start bombing you with bug reports.
> 
> If it is "possible" to hit this assertion - it should not be an assertion.

I know some people (eg, Linus) do not approve of this code development
tactic. However, it's not a BUG() and the NFS server will continue to
operate.

We are using WARN_ONCE() here. We'll get exactly one of these warnings
for each boot epoch that encounters this issue.


>>> I realize the great value of the stack trace that WARN_ON provides in
>>> this scenario, but if we include in the warning the operation id and the
>>> filesystem sid I think that would be enough information to understand
>>> where the unmapped error is coming from.
>>
>> Hm. The stack trace tells us all that without having to add the extra
>> (rarely used) arguments to nfserrno. I'm OK with a stack trace here
>> because this is information for developers, who can make sense of it.
>> It's not a message that a system admin or user needs to understand.
> 
> It's your call. If you are not bothered by the bug reports.

I expect to get bug reports for these issues, because these are real
issues in the NFSD implementation that need to be addressed, as you are
doing right now.


-- 
Chuck Lever

