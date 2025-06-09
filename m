Return-Path: <linux-fsdevel+bounces-51029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433EEAD207E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A53A5929
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAEB25A62D;
	Mon,  9 Jun 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pyK5ejpz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XxnrPbdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE51624E5;
	Mon,  9 Jun 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477726; cv=fail; b=TALh/d0z3d/vz5fP8SGBdcJism7zB2ee1uNepCF/jJQXwixwEkVbXKKo1il3v5mW2K5qejDtZAjobNzvakN6XQBeOnevFYn0EE4KXxWByWIAlSqRO4katy5UNcbvkJwbkPnB/MCF/qhMQjneWAh3d13461L5Rb/fiWXx/w2SDhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477726; c=relaxed/simple;
	bh=LttUGVJ8zb6KrQXzJDHc2IeHVtO+vIVo4gilcW+CSVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bh9ALUaSlFqGTVya8xDphNiIkuBPluEVKld2rtM1KkQYzGMhSaWq7HBEO/2CsvTqmSS1iGBS1iRmOwg483umDuWlYS+xGCQAGd93UJNNIT1vCY9gIERwGHvq3rUSu64SMJegzuwoO7k+MDmffZGm9fshmgOJ7hhSs8AwVXtSMJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pyK5ejpz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XxnrPbdF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593j1sR017417;
	Mon, 9 Jun 2025 14:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2tHxgC9OSSCNpSvHUK2yVDSTcw+TTI2Wfuj5MuBB6Zk=; b=
	pyK5ejpzL+tcJyYRSOGJbxHlcTUa+wZ8v37IUtt8+BppkG1CGaq6UFHqMnjdIYkF
	xTBcg0G3jgnWBFmBnfWwqExTAMFtvSf2GDa76zPYeDw0cIuUJ5fS/Qgabq6dKrKU
	5hIpcMlEIQwBP1mj18EO9g5Qik3iPS7q1lox+RRdOCTpuqonp7yFj2RH8N81Qo5Y
	Ew7wKePaA13kDJ6mgf3ighWg66uxqbwL/82L1z/in35tW6LpzWFGR3d6RMwHqx1N
	QQgvCba1fCOmjlM8Bb/NHX+oFWf9gOR8k6DPkx1I0dwg5NnNvCIm8wnRY2ryPDdE
	GFwXqiDidjzg2oD6C7mS0g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74t7e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 14:01:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Ds4Pv003191;
	Mon, 9 Jun 2025 14:01:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7fkpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 14:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vygEyR8nCXthuRTdfHF0wgZN2G0CAeeWDfpXm4Hy0vWj6sc6w7bwvd21WJWS8l1xB0inGnE6va07oxfT5dcvIUi9lf8EBcxjiq3EOSuJBGgNbAKe5M8S801NCDGHpKfhmwF0taagPr+PkSHdVcZHnPDFJGXzrd+K4LcehiyWFp49n1eXL9kuUZ9FANq1qCQmpu7y0+SyDUQs3ZPWyuhY6JRyg8ljP22C3KZGeoF7Vn7BrXtYvGGx3cIX9AZgROKg2zNeL6jyK7iFcKTR5aalqQ2XXXzMspZ0yzm8+CqbCesHEwfDhfrlfGJhGtYcTHmrhfLQFQZCnM9M5EhLTlj6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tHxgC9OSSCNpSvHUK2yVDSTcw+TTI2Wfuj5MuBB6Zk=;
 b=LSMFokzRNYoYwabL93Kj+5iL9FuOOD0+MnW/DVAZyuhKUwEz78tKgGYssR7JGjUCuUDRuaMtwKK3MpCPbgMwqS4wehHVN7xWtl0XjOIZgWZmOBu1oyZAweiMLNK/+ZKE+wzr8U7nVwO8PYq43E4zUe7SjkhqLhXqLgCw5rLzuom2P5jpE0aK6VesJJvHU5PHWtknPECZGeisko/wjQj/K42usBaRZ2+MFVCYr+wGW2LgWEuXrMd+eZlDZlN9BW+S3J9ZXHBOr60IKe8o1NMB3v12qc8ll49OTP0grOx/QMOSmlJjh/3AF4cvbuggAIFKXseiyT+VaoswQf2tJNhkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tHxgC9OSSCNpSvHUK2yVDSTcw+TTI2Wfuj5MuBB6Zk=;
 b=XxnrPbdFjW5/Ow3msAdg3FxN2+E3qgdC9AymJG4APKOsHpvsv6KZ3TvTPub6Y3H0I9+Mnue+lItEmbjjjRsAItYcoADv4kTG/Okb1cmA5sGerDogAvvyQKne24IZHdQvIDkbc/leAcyFAhjTkAPRgxmpZJ39bLGmGwl3Qpi2md4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 14:01:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 14:01:29 +0000
Message-ID: <e5c5fdbf-1e4c-4fa9-93db-e23b04e0452c@oracle.com>
Date: Mon, 9 Jun 2025 10:01:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] exportfs: use lookup_one_unlocked()
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
        Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250608230952.20539-1-neil@brown.name>
 <20250608230952.20539-5-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250608230952.20539-5-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: aefd51c8-3be2-471f-b064-08dda75e21a0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SFE2ZHByRFc2MmZwK1hmZ2NGd1Q4R2VLSDFnYzNSVjVyWHpMRktYcm1QTHps?=
 =?utf-8?B?aGZoWGxFYVRpNGRMbG9LSnZjamV4bXZRbk1CMm5WOE5ERFQwQmJyRzFqSlFJ?=
 =?utf-8?B?SVF0aUhmU0N6anJMd29RL0FMeS9CMXAraTFpV1lrRDBkUE9BTHNKWk5CdHBz?=
 =?utf-8?B?U0w5b1Rtcm8xRldKanlwdHpSRVZNU2VSMHA2UUNON0dVMEtPbjlFNllsMkpE?=
 =?utf-8?B?S25GUmgxOWpvTzVvOFFqOW9TY0E3OU1pMnppY3Y5bG1Tc1M5bUhEanJoMUk1?=
 =?utf-8?B?UFE0RUo4dWY4cmk1RzFpRk4yenJzVVFKOWpPS0lpVDU3MnRBelNmRGpYWmFD?=
 =?utf-8?B?OGY5UGY2aWFyek00dDdDOWZ3amQyVFo3STUwNG5LUHBPREpRK3p2c1czUG9I?=
 =?utf-8?B?bkgwU2VFSTE1SVE0Nm4zakZVVU92NExWRUtpVWUyKzR6cHdZNDkrZGt4ckpm?=
 =?utf-8?B?bXFkRHJCZ1dDU3FBbWZEOHJCZ3RKZkh6MUZMWkFaZE83d0NmR2RTbWQ4WklO?=
 =?utf-8?B?VlhyL1BZQURmZ0xteGNPS25RK2hZck1kd3daNHY3a2ZCMWJ6T3IyVkRiY05T?=
 =?utf-8?B?YXBjS2R0ekJJYW5xTzAwVmhUK2F2V09XQTFGVWw3bUN6L1Y1TnNHTkdUTnRz?=
 =?utf-8?B?TU9WSTdlV055NXlGU2ZaMnRhb3R5MFhPcTZBUFJrNHhOdHY3YmV0cjRlOGsr?=
 =?utf-8?B?b05oYWZ1Vm5mcnl4bTFTajdya1A5WGtOdFlrMDdObklMaXdHQ3JSVGg0R3Fy?=
 =?utf-8?B?d0NvV0lnM0dxK21hRXQ3aWJXK1loQmpNekVQTWpKc25Ld3oxYmVGZU5kNlRh?=
 =?utf-8?B?MWhJRzVQdnRYR21xM2VoTjVWKy9qNnZRMmRSMjJUZFA0K3MyY1k1eHh1THVN?=
 =?utf-8?B?bGN1M01OTWlRS2hJVlh1RXNxY3RzaEcwQUZoWXpNcUlHUjdBWWs2aFBjazZq?=
 =?utf-8?B?NjNUcDFtKzEzODdhN2xxbTlhQTdGaitWUXhnNWNKOWpYV0hvditqRDBmV0la?=
 =?utf-8?B?U3JCQlEydUV1bkZTZ0ZGc0luZDM1c21rRytGWlFENWRoNVBNRU1YcjZTNkxF?=
 =?utf-8?B?Y3pQelRSZ3pWbnRMdm8yZnVWZWNTSCtVZmhkamhoeUNQNkxRZ1FwUi85KzFX?=
 =?utf-8?B?RUZSL2diSFY2dHh4TWdIMHkwbm5oODZndXQ4STd6bHRhNzJ6bWFNZ1ZkUFFN?=
 =?utf-8?B?MGNsQnpJUVM5MzBicEdsd3NhbnZCQWs1ZnFueWNQK1RwQ00xQVVrbS9xSHVN?=
 =?utf-8?B?M2lCMnNIcytCT0xVUVN5QWZLMWpjTHdXT3J2amVETFc0Z1ZBNTE2ODI1UGJT?=
 =?utf-8?B?UVVPN2xHcHZQVmxxRm1leXVteUFlZjdjTURuUlBya0hGck9PbTNTVjVxdU5O?=
 =?utf-8?B?QnBGd04wUnpOS0UrOFg4dHpLQmdlTzV6T0xrbTdVb1IwVWdmNVhLb2VXWkVL?=
 =?utf-8?B?aUpobW5QNmhlNHRSbDNuWTF5TnJRamh4N1AwMUxTclhRU2pUUjBHWUh6NWhJ?=
 =?utf-8?B?Y0l4djdwblhwTUkvNDk4a3QreUZlOEVVaVFERm1FSFN4QWFEbXFtWXhkV3pW?=
 =?utf-8?B?WGx1L1lOQUNxZEh0V0FGVmNpMXBtWFllS2FnM3hkMjE4Y2lDaE9Zc0Q0bDVs?=
 =?utf-8?B?SVduV0UrOGJjSEpyM09CMnphSjB0bzRyTjlTM3BUeExOL0p1aFZxaDZ3ZHdF?=
 =?utf-8?B?bEpVb0NzYk1rVVJkd1BQQjlwQ3g0eU8ydURJMHk5VllPMDRzeTVmVVBXN0Rj?=
 =?utf-8?B?UlI1aU44UHpmRS9ER0pkbm03blAzanM2TTdUejRaYVp6bmxyUmk1dEpUbENt?=
 =?utf-8?B?bzZRMW8xQlJ4bTJzeTErbnpjd0JieVJuTXJOaWZ3cmNhME42UmxEQWdUUXhx?=
 =?utf-8?B?N3NUeWpaNTN2ZmRBWVAvcEdhWExPbjU0c2UrMGtvUlpHN0RFMGJ5cjlSL1Rr?=
 =?utf-8?B?cSt0bEFYalFUMDU0NTE2Q21hZEI2NWZsbGQzU1ZQQ1lGL1czYkk1a0RPT212?=
 =?utf-8?B?QUFHSjNlZGR3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?clRpd1p5NVJEMDJ4bWN6VWc4TU5QNWNTNGVQS3hCQ0prRUl2V0tYTzYweUx2?=
 =?utf-8?B?dDRjNGFUa1dxc1Ava3l2YWlQUjB2WElybGc4RmplM3hQeXY4S295RWF2bEVq?=
 =?utf-8?B?aml5WlBxbFBPTFNqVll6U2dVckVZTUFzbDRQYlhiakdJQWdlYzdac0lPdWJX?=
 =?utf-8?B?YXltTTZtNU5NUkJEdlR1QU1oNTI4dHFpYmNkZmo2TnFPMHNma2FhME9CVlMr?=
 =?utf-8?B?R2J3Vjh2TjVKOUpRMXYySE1QNGs1K2MvL1RsYnc5eWkrREIwMjVLMWJYNTZu?=
 =?utf-8?B?cGsvcW5LeFg3bHRURDErWkhDRHZIWXB1clQreEdkUjRZSkNydTcxeWlueVds?=
 =?utf-8?B?ZGpQRkZRME14U0ZvWmtzNDJ2YUFkL1hhQ2w5Q3JXZW90cXU4MEd4ODJFRFFW?=
 =?utf-8?B?SVV2dUVvNGs5QlRMNm4xRnJMOXl5b2dzVEZLQll2Z3d2c09sT05tc25zUGh0?=
 =?utf-8?B?clBXNUJXZG9SdkxLcy9mdzM4NDJvL0lQc0hqdHdXa2FBdTA3ZDBQWUFDcmgv?=
 =?utf-8?B?V2ROY3BrcnBNWW1TRUZqOVMyd1lBakF5Y2JjZFFzTXlaYXozL24yT1d3Slg4?=
 =?utf-8?B?ME8zejhVYlJ2REFzVFNKKzZxRUd1WXVNOGtXSHYza2dpRHB6MkpnSlhGMk8v?=
 =?utf-8?B?UmFFeUdCZTBlalMrNHptdGdPdnBWZTNsckVIKzZMQTNpWlZlUTMvTGlBNFpk?=
 =?utf-8?B?elhnamJzY1BRc0hpT0UrRWQ3b3YvZ0RWT0xVMUxNaFFrRndyd0VTUFRPZ3po?=
 =?utf-8?B?WjQ0SHdvNG1PUWxMbldrbm5zcnhCeVJKSENRWVY2a0dOc0oxYUhKNGoxNXRP?=
 =?utf-8?B?Y2llMkVCdFJxN3VnRHNrQlpRRmN1QmN1cGhaRHppVStTMm9FeXIySjJETXNl?=
 =?utf-8?B?TzV1QUYxdUtmU013YmdCV1pJSmxndFhHd1VtN0MxTG8vWTJGKzMyMVpleDgv?=
 =?utf-8?B?VjdYbGJvTDRQcFJtdmw3VnFsOWY5ZlJyaWJkUjBreVZobXRreE95NmhWZVhh?=
 =?utf-8?B?cFp2cUEvRE9wQlg3SVIxUTF6aDZwallaWFN4d1lEalplTGxpTjB5ZnYyWlRn?=
 =?utf-8?B?WThqNTluTDZwOXBjM3RJTitLMU9WNytTZVNwUmNmNWswcUt3NCtRTUtsR0RB?=
 =?utf-8?B?UEFUL20vUjN5M05VTUNUOUoxdTVzWkZWWFlURDVhK2c2UDNVUFpsd3dQMGtJ?=
 =?utf-8?B?ZlNsMzVPSEUrQ1Mwb1BvRkpTVmZmQWt3RDlRTWg3OUZHSHZXZmcwckEzWGxE?=
 =?utf-8?B?WVR5cnJJR2FqZ2ZzaWVRODF4L2xzWUtmbE5HbnpvaTFNMFp4UzRmbTc1RTFw?=
 =?utf-8?B?L0dVYmNyQ0cvY3RHdzAxZCt0SEtpNDl2WnEza1hwRGw0ZndzSzgzRTNCa3JB?=
 =?utf-8?B?NTlheFVtb2FWZlRiVzc0Wk5naVZib1VZVDQxMzRQZzl6VGZsZTMxZmJ2dTRY?=
 =?utf-8?B?bDJJcjYvcGNreVdWWW8yRXlZS3psK1pGQlRMSGVDZlNsbWJ4bjVmSUVWbjZH?=
 =?utf-8?B?ck9QTWtmTTBneDlUMzlTdDMwZXJFNkw4cWdVZXhGd3ZrbkRxd09zd1lzdFVs?=
 =?utf-8?B?ZGZGbTRPT0JaNzF5Ty95bnlqcFlXR3JjVnB0Y2hLS2ZmRXZpMHN6OUtNc2R2?=
 =?utf-8?B?T0dpZllucHVBMGNBN3NidnlIc3IxUStGRGt6akVXTlovV25uN2xaWGp3cXQv?=
 =?utf-8?B?UjdaaTJnajJqay9uSGc5cXNrTlF5U2JGTDFxZHVYQVlqYW8zcHJpZFNOQlBQ?=
 =?utf-8?B?Smo0K1FpSGpkRzI4blVPZjhVZnBSQVQ2d1k2WkxneE8xUXljZXhxSlg5MU9C?=
 =?utf-8?B?R3VLa0dzdVpNZVNNMnNhY0dLeVZrSEY1c3NqOTJQUWc0N2hBTjd6S05tRTRa?=
 =?utf-8?B?YStOQVhuenlXOU54bDBha0t4OGtOZ2RSL1RCaVlrd0QwY0trOW1XVG94Vksz?=
 =?utf-8?B?Y1JFeUEzRWFTVTlEZzNwd0hzTGs0Unl3UWsyVVYrdGlCRWt3UTNtUlZMZHJT?=
 =?utf-8?B?cWpjaXRvYnZqNCtjVE50N0tMdVBpaHQzQU05ZHRVeFJzbDBZdmxNeXgyc2tp?=
 =?utf-8?B?Z3BXNWZHY2dzbFFqZ3VTN3JtS3ZPNFdic0YwWWVUYlExdnpPdkNQWjIrbWRv?=
 =?utf-8?B?eFRqZStsY1Q0VExVZi9CT1J0ZVpWTG9NTE05MVZYYXJHS0dvUitYSW5SVEhQ?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1HVHAMaYJ2sgn7439G5iXgZxjAHKFUkkwsESyIaVmgdKqbfLTmXOIRS+QjmdQy8Avy7at5ThMykaqetmPYDtS0cuIhiAxuHBdfjVEw3qPEbdmVAg4W9SAPCFg6N4E3nglzVvrVDFfdPtIYEs3cZRbmOAnV8AXILNuk2LJZdYBLuxrE9Us1nbzNm4hyQhhVyRa+OFLhfHcuGqvinCDZ+dl2k3CJgtD/seaSKNHZ+Gs6RmPw1XIY0NDZoMPFKy1T3ZkQflfIjwHlItjZGQcDWjkcJhH+DWXEDdWA4UycheCr9TDenk+KDc3L8QhS0/dbWogcZhTIuUVgYPyIhPWqXO0aaTkluqUgnar3B9Jle9WC9i0nDlbSd4NYMH56uRerPgOHPRHq5sXwstreR6lfREVm0oseRXuopzqAXAUQKlGiWV1bBaxbp9JCXRnYAV28mEA+Q9z1vOe+DSQx8f4+fCHfXgB+jB2XMiCecJadMOjx0fLHEzwFZrKLFZPbT/nQ51iKXIkc02BjQEzUxvNAzbvkQitOOow7jd9JBD81KGg82hYRi5HBkn3hMMqCTdabocjgImmMf3kKg5DCMeuh0DtJEmRYTHvN+FLHqMWIg4ESM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefd51c8-3be2-471f-b064-08dda75e21a0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:01:29.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB+21G3hS6KFv5srUQbbW2ll2tJtB4wzdRsXQ7W/IWeJJvHb9eHfJSCOsS7A1kmf7JekdrCeUmdOLXyqFBsE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090102
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=6846e93e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oYNp23nUh95SHHDdSrcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: lI_BOMMIFK3QVyuCbywa65zCggYz-MPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEwMiBTYWx0ZWRfX0aLu3fzsteO3 b2ZqJX/SAKEn35HxQwEMuZyDGtqmmf7RiKT3BgATiMnZ14EVUXZCrfvNY88Yqlna0TSRsACO/+2 9epHgz4n8IKe1MxgIZk5orFvYLHFq7q1iwQCEM8bcWWF+tUN7zWs79U4qxXEkpGpQsL1oeUcYKq
 8amudHGdGaTEvjVUPZvBm+KWJIgv8k4TAPdlsExa39Tbg9SPeMq5nyoJtsTKX36q516yT+tzvT7 U/L4hqwC91UqFhZ2s6NWpFD4/3BwmEQ4OurN7WaRayCYQyonpAmP6QvXXg/Exk+hyar+1mBXIFR iaK7n9OfjxeDdTMrNjNPW2Gro0Gejdex3yvEs23QPAT+oPPeBA1YDq/XmfmfDJ9Ul/hrOHS6xk8
 v14NNIlr9LE0PKPbZUlHlNjQjI3IZxbbmKBf+jUFBDg1LgtB/ItJO8olcBf5MGrSqXtNfALi
X-Proofpoint-GUID: lI_BOMMIFK3QVyuCbywa65zCggYz-MPe

On 6/8/25 7:09 PM, NeilBrown wrote:
> rather than locking the directory and using lookup_one(), just use
> lookup_one_unlocked().  This keeps locking code centralised.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/exportfs/expfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index cdefea17986a..d3e55de4a2a2 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -549,15 +549,13 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  			goto err_result;
>  		}
>  
> -		inode_lock(target_dir->d_inode);
> -		nresult = lookup_one(mnt_idmap(mnt), &QSTR(nbuf), target_dir);
> +		nresult = lookup_one_unlocked(mnt_idmap(mnt), &QSTR(nbuf), target_dir);
>  		if (!IS_ERR(nresult)) {
>  			if (unlikely(nresult->d_inode != result->d_inode)) {
>  				dput(nresult);
>  				nresult = ERR_PTR(-ESTALE);
>  			}
>  		}
> -		inode_unlock(target_dir->d_inode);
>  		/*
>  		 * At this point we are done with the parent, but it's pinned
>  		 * by the child dentry anyway.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

