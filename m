Return-Path: <linux-fsdevel+bounces-31724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD999A63D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E77B2396E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9752194A5;
	Fri, 11 Oct 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RNg0WZiM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIw+w/gf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9ED218D7C;
	Fri, 11 Oct 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656693; cv=fail; b=Hs4LOmc3wQZUYIWRPi09VKJihvSk+QHqOVHR5BDdo9e15VjML8cZZm5IHcoKEY5q+AMqURTl1KQPoldtq3aFMiVbsDZBGKpAv+1yNJXidA5/lmayCdxItkLogOPFgjdmK/dJ9E9JnmWwG1rMFis6jMy5thDX/wG0GXyZtHFMVVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656693; c=relaxed/simple;
	bh=TN7P4p7xdbdRmrOmf9RCZkCOUd+mOE4efpu4hhC0psw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfStz6jR8kBJ/LNQHfDYLXbFPmSOZRFuiA83ghQBvfkUuAvsJh8+425ZQ6RwpOZRN4RIVFnKTZtHMMHxO1wuxkjsgzXLq3+HtL+tJjmlXkvu4b2qcVzwEEaEDmjF6oA/B3jBdR+TsRWtOmP+kyHFUKVnY7bRwJINk/wbpMS/SE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RNg0WZiM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIw+w/gf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpWVm029727;
	Fri, 11 Oct 2024 14:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TN7P4p7xdbdRmrOmf9RCZkCOUd+mOE4efpu4hhC0psw=; b=
	RNg0WZiMy33+4Sivn+OHXUqGj3qDW4DR6ZUHCV+JHBEYr8A56u5Lj56v4xI3npO8
	mV4UcuDHaTue8tqjal7Q4gxSbpsBWuDPyttV3p7p/Ul8vKnia61qSMJ92Crz+9tm
	tDk9IOIJJA0FSJsj1htaq8XUe4oQTWxhD9ekvOHR8LPeXMxiutgfU0KB7P5AL8P1
	009L58sVIVhrJiulI2aBHePAOdMXE9kxJ9ljVdHwfw/EQMWkVp9/LmK4PqADcrEh
	bsBcGK0jl/oogrYN97Uqd6ByJ0r7W+PtBno5iBgXZ0ZzpbQmk2Ng43B1FxJS+UYQ
	oMLOFE4rdFirzbkv2XJ7Ng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dvxds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:24:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BE51Be040343;
	Fri, 11 Oct 2024 14:24:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwhpvdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p35fAQC7wmAb3xNmJV8fTdK9wgpFM7cQc7srdq7axPrkPEg4SDWVwTTisL3GajKmG7RAvEzOFuRtTzurRXdzLXZMz9lgzsuuCJ/6tM05LQZXSd9Vr8vUg8DKSF7BDLW6tBDGDTBoBlseBwLrzsqIS/AhL+W5l5R+KZYDtTJfNltxJK/hXftjVQkcfI0O/A2+AD4yWS2+grhB7YXbYCSdSjnrOBUNwbGldbr9nYcpaRtSh3y44YPlTB58SpR/0w2vC460IEneKrpVr1F6Ce2h8JYQIP8uWRVnyxDU+8ywmFNINVGUkqHr4Y1a7QfmTwsUfNZcZW9juF7cfqfNd8LfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN7P4p7xdbdRmrOmf9RCZkCOUd+mOE4efpu4hhC0psw=;
 b=gnI7tsgWcVCQKfYAF3JrSM6F/Q+cOOV6dldrHQLJswUeweQP2U3Fg584fSDPf41NVwhiXNBMc9PaxaPvnjlV+8YjAJbWvaPtzEm5bRc40MrNsaUYmjmigCZAeA+SrItIHb2a5tXBQM3rfFyWxbXOjcL40fVAihmue79W99Cvd+iR0dA/UoR1GO3Gh3ClOeg+ej/tVFDpQPxbsAr/hOc3bbriZ9bLcpAZqBAB9bBlLzs8REFuZeTL2DVNLZaOeGb3C4HstJ0kwyzqGLbzmWc2esR2AoQP8poOLQ7qS6LXrMEMT7C2ZJASxcKJHRtJbCQe/epwOkWhR+JrE2dOc0V9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN7P4p7xdbdRmrOmf9RCZkCOUd+mOE4efpu4hhC0psw=;
 b=XIw+w/gfqjszAfU5MoW3Ckc/iUbX/pHx62krD096wV0jUJ59v9Oy1DmNMX/v82tKrdkCgcEdw4L1TmlhsJs7l/UwiTVC8OwfAI+Y+3+XKJ5gJMso9zo6AzDmU3BXrC5sLLhdlfu5jGW4iUWqs9A6qBPpxj+BMKpVS/q5bzgSdvQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:24:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:24:33 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] API for exporting connectable file handles to
 userspace
Thread-Topic: [PATCH v4 0/3] API for exporting connectable file handles to
 userspace
Thread-Index: AQHbG7wKQIu2WXCvZ0Gg1IHTT7WC0rKBmw8A
Date: Fri, 11 Oct 2024 14:24:32 +0000
Message-ID: <A1265158-06E7-40AA-8D61-985557CD9841@oracle.com>
References: <20241011090023.655623-1-amir73il@gmail.com>
In-Reply-To: <20241011090023.655623-1-amir73il@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6781:EE_
x-ms-office365-filtering-correlation-id: e8f3073e-a336-47d9-ba88-08dcea006d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTlWTTRSSGQ0Y1RXT0xrTWJrQmpvZk52MVFnM25WaldLcjR2QXlKZFRSdlNm?=
 =?utf-8?B?WTBrUnNOQjF0U0ZtWi9ZL3Zwbm9GbitlbzdBWTd1akF6RVFjWTNuWXFnSEd5?=
 =?utf-8?B?aHEzcnI5Yk9KaDRNblloTGg5cEhLcTI4M281MFdOTUNmZjVGTkZhL3Q0RnNH?=
 =?utf-8?B?bWJVNzFDQnRyU0hkOFhPK0hyWnN4T2VOQ0NQL2dRekFTb3VMenQ4Z0RuUHNj?=
 =?utf-8?B?K0hFc05CSTlDeXlmN1k5VkxEa3pYQ2k0NHJKS1RSRC9aMDNyUEJVcHBTWkN1?=
 =?utf-8?B?S0RIcnpyTVdUK2MyMU1BQmJVQm1lU3cvRjRuMnV2N2YwOWlPWEw4NUlISEJW?=
 =?utf-8?B?czJma0pQWnVJS2xuenJiR244U29hblJrdWdENG5OTFJ3R2xicHJWalNVdU1m?=
 =?utf-8?B?a2FvMGcvVEJnZEwyWWNpbjEyNU0zTWpuKzMvMk9iMWhua1F5OExsbUwxSzZz?=
 =?utf-8?B?Y2ZEcFRnN1NNV1hiKzZkQ2lETGxNWlQ0YUVsQnMyd2h5dFl5WDR4YVV2Q1Jk?=
 =?utf-8?B?TG94VDY2WUNVZVg3d1lNZDJDeHFkUjBQOFdpWjA2TVFZTzcyaXlqWmN0c1k2?=
 =?utf-8?B?VS9kN2FwWm9tVzFNU3crK2VKcUpOR0V6YWpPVVJPeTJZNERIZTNPK3VlQWQr?=
 =?utf-8?B?YmU3SGR6VWFKdXZrcG9DemZob2lpeTRlTVh2bXBxdTlOTUNYanJRdTYxak9U?=
 =?utf-8?B?UUt0Wnc5ZlBxSDdISkRHa1Q2ODgwZ1lEQ3dadFF3OTZlNDZFR0JTOFhLbFph?=
 =?utf-8?B?WkVtZ0NKOWxWU2pHYkE1VkdkbHgxM0tNRFlmNXJsblpGR0tHcys3Q05sd25Q?=
 =?utf-8?B?S1NCMTEwMmdEdHFDYkpPckgySy9MVDRaSGsvdG1DSFNZTzNiZytDRnVKTnlv?=
 =?utf-8?B?ZmJISjNYdzVyd3JuVDZURVhzVmhJYUR2VFRVckJ0cmdzVzlSRk9XbWw0Ry9E?=
 =?utf-8?B?MkZ0enNBWGFqZnBGMEFvQ3A1am5TT0ZYcS9OdnBpeFJXNGJYdGxkZi9ISnI3?=
 =?utf-8?B?MDNvdHYvOWxZaFFXZVhjbnVYWldzWWorcjhRSGllNTBFTWpsUThyd2dYazJY?=
 =?utf-8?B?OGw4UENicDRQOU4zaDVJM0lhcDB5bzE3emJqeng0UXVzUFpMdytwalk5aUts?=
 =?utf-8?B?N0I1c254RHMrekpkdWdndEV6bk4zM2ptSmtuMy9ScjRucSttV1R4QzJFZHE3?=
 =?utf-8?B?dlVvT09mRU4zV0hpNmZZT25yL1IrcUZYM2J6cGZFanZpVWU5Sm5CdFJiUnFZ?=
 =?utf-8?B?RnArRFpUSUxEQXlJQlBWZlNkYlZpaG4xeFlCZDhab0ZESWROZTVvd0xlMEdJ?=
 =?utf-8?B?NnFlUTFWbWVMeWM3R3dyaEQyM280cjNQc1F2V09zQ3BmN1ZGa2tXa1g3S2NF?=
 =?utf-8?B?eEV0MWhaSVZSdDdXVFhSS1IvaU1ERmJYY3IvTy9JWENwNHpWaDBnOWx0QnVV?=
 =?utf-8?B?RFJ5YWk1Y01HaW9wdU9YRkhyNUtaUUNrYnJINUk1bG1KaTYzQjkxNCs5ZWxJ?=
 =?utf-8?B?TkN6NHByZktoSGFyTUNsQ1RhQkRtYmNRM2I5ZHB1NGFFKzc5S1Mrb0FhVWpj?=
 =?utf-8?B?c0tSMitzQytySFYwV0FYd252ZWltQ2wvQ0dxVk5wS2gxajNQNTNHODlWZTN3?=
 =?utf-8?B?ZUxPV3RSc2kwdmZhOUhiTTQrZlQ3akp0RS9XMUlNcWp6d0cwY2UvLytJQzZu?=
 =?utf-8?B?SmNkWk1hNkdtUHdtTzA3bHE3cWgvL3dWRzg1UTNGVlp5VXNrcXluSG1lc0xz?=
 =?utf-8?B?RlAvSUJka3ZVTk1IRFViSjM3YWtsbjFocWZkcjBsOTY3aTNaK0N3Qkp5UStP?=
 =?utf-8?B?TDdmcU84VTBYNmVxR3oyZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzBKaWZ1VlpMOUtCWUFOVlpNUjdqY0krbmkxYkg5QTN4SmlnL09jMk1oblEz?=
 =?utf-8?B?Ti96U1plbjd4b2hiQTU3T0FCc1FtWXFpWGhLK3JUWFpBTGZpckllV1RsaEtZ?=
 =?utf-8?B?TlN1Yk5GalhISTluaDQ1blRkN01SL0NDR3R0S1loUlVqTmFjaFR2L1Z3UjlQ?=
 =?utf-8?B?TGN4b3o2d285YUY0NXdCTHRTWVBiNEZtVUR4bFZpODlDcE5yY2RZMjZuNWlG?=
 =?utf-8?B?Mmw2RnpTcTQrK3FiQjVXT0pOSlFiRDFwcVY0L0ZTeDdZK3lzb29LcDhVU1dt?=
 =?utf-8?B?QzV6U2xURTRrdTZyaUVFYTg1ZlpmYUs2TTB3ZGk1K3VabTBxTVFDM3pjaWxE?=
 =?utf-8?B?U3BzUTErTDVIYUJjK2lBNTdySmhQNUcvbDVzYys1NCtGTHBoWGkwbjUzajVW?=
 =?utf-8?B?K3dVQ042NXZPbVdBVWlEam0zVDROYmwyMWNVZzhCSUMrYWJUcUE1cnNhNG0y?=
 =?utf-8?B?TFJ5WFNWY3RUWm13eUFjdjJUVzZxWG8wSzJXSTUremR2SWFpa1RuYnNUeklO?=
 =?utf-8?B?MzNlQzJrUTRVZUN5b2F3WUM0MVdtcmlaY3o0TS83QUZmMHNJWTg5bVBobUhz?=
 =?utf-8?B?TlZXRC9pMnZnWU1SMWM0QzEzK0dXcFZYcXZFOC9YRVFXeEQvaVpYUXgrSWZH?=
 =?utf-8?B?YXJqNktQVmozS2ZPa2NIaWdXcGV5NUlmZyszZVBTSG1mWnpUNFY4VGROUkRj?=
 =?utf-8?B?azZOeC8wYk1oVm14Tnl2d1hweC9VNkIzWmdTY2g0R3FCTmFGV09kN0FjZjR5?=
 =?utf-8?B?S2JGbldSYjhyem9hYzhaQU5teHJXS2FzdjZFQVlqeXl6cHNxeUpteVBMVDhh?=
 =?utf-8?B?S1gyNWVvbHI5WWpvazV4SFZEQjgrWVpkMmdRUnc1Q05pK2RtaVhIYUhKNlBD?=
 =?utf-8?B?NFBJc3hobGVaUThiakR0T1NwYzQ1RUIyN0pYZ2RrVWlkOEZ2MldiL0pPc2Ez?=
 =?utf-8?B?SWgyclRmeWk2aEVUR2wrRDZsaEhEd1g5M05IVVE5R3AxY1NMcGNpQkdGUHp6?=
 =?utf-8?B?Ry8ySTVNM1ZIaHpTQjd6eVdIcjQ3SU55NkUwM2xWdm1maVRsdkhnWTdFK3hl?=
 =?utf-8?B?M2RId0xuSXM0L0ZEbThJUFdsejdLTTdrTm92Tmgyd2Zrb0tNVkhUWkNhRnZY?=
 =?utf-8?B?eDJjOXcyM0RNeDhUVXMwMlJSV2JNY3Aza3RhTmtDdHZGYVJleUtUc3haS21m?=
 =?utf-8?B?cElqcXlPWTRJUEVua3pERWN4cy9RTitGMUMwaDM3TG8xOW9GTnhuWllMdjJF?=
 =?utf-8?B?a0s1RzdHbXlXRitreDBZVDVTamIyTVloRXdVbGQybUFEN1hGd0IvbVAzZlRn?=
 =?utf-8?B?WjVIZ1Z6bjE2K2J2Qk5mQTNtbDc0TmlrRXdVb0ZqakdWUzhNOTJ3Z1puT2NP?=
 =?utf-8?B?RFY5RmRpK3BSamVPMERtSGNQa0lZNDEwNzhKbEtqNm15K0NKOFF0SkFRMXFI?=
 =?utf-8?B?MVhCUm42Q0sweFdhTDJPMEcxZkpTT0Vib2RRdnZyejhpWDdndUJBSGNSQ0Ir?=
 =?utf-8?B?NGI5dEpxUGIvaERkQy9rVmdDZDdZUitHVVozVTl5b2k4NmI4eU5Ib3RuclFR?=
 =?utf-8?B?SXJjNG42M1VrdmZnRHE1Rm5WdnhrR3hjaDUybVRwUm9zMCsxMDNXMlF5aFpV?=
 =?utf-8?B?VHl6dlpsZVZCSXljVUlBdHp4WmFmeWl5NVpDWnBDWDg5cUFkNmZHc3lFNHVm?=
 =?utf-8?B?TWs2b2d4SC9HVTh3WHBDdzFqL1EzRFlVVHVjQVJVekhvRGtaUHNHYWhFbTFh?=
 =?utf-8?B?Z2JtYkdpVEhNeWFGYllNdEk0Si8xbmppVDhUUG0wWWNYeDI0SnFJTHluWmtP?=
 =?utf-8?B?NEpmZm1HRVM4dkZXelE0eFNyZzBDZUlROGtGZ3A1WjZTaFVDVXY0TVdsTHFq?=
 =?utf-8?B?UUVadEZUNGREQXdMQlVYa1RRTmZqUEJpM3l2YWtzOGdEWEd0Y3g5RVA5M3Y5?=
 =?utf-8?B?OURNNm9mWC9VQ2ovYWk3aWF4V09vam5qT2QrejRidHNKZDhjSUhndVVCQjVY?=
 =?utf-8?B?VzgwV1p4RDQ1RlpvWjNmNlNiVDJ3MWdoZW1WMlNUU0tMdW1SOFBkMVhUbWhn?=
 =?utf-8?B?QlRsd3lDMmFTbWhsQU5wMGNpVXlMQTQ3QWlERjJjZlpBaVNhRzVHNTB3clBB?=
 =?utf-8?B?M3ZZcEFyenJQVktEWWJ1TGlIc3daeGdMY0VTZVhOUG9LNWc0a3NGVDFBc0Y1?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C68AD2A5B287E04AAD0350E6D72F6E92@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8KyInfmuMFRBUNMDGwE0YBxB0Pjkeeof0c6rLRipQRV1KO5IpbRVlOEWVF2h6yPxXKHsJAiYrEux1LDzyiK0vOdG1rTGayQKKuIL97bIlsPd49l3iLd7srUlyhFNI5ADYJrxWeRfuxoislj54tIuqLq3IX1de0YmE332ioLUQgBJEjEMprmoa7kiRI3g3oMX321QMkY2FaFRzf6xsGDfoVQvcAt/jnoNHkz/IN3s8gKEaGEGck4PL2k0DiwgTVwMCpXoAZ2PCa4NuCNiWl16WWI2vtqdhTgklHBG8jqdIazqhJFT/6NUn6UMpvUXWGpzzLXEMlbSiJBInj67Acb5gdnVdFy0dnEE/g6rOO7t97STOSruuz2c9h4uvP+i6ASnSfWK0lxE+uCvRUkEVGz/iHnGGhvAp0yH/ZJjxPER8l68L+XZP9HVUxIKxhV8ifyti0n7jd/+P+/ZQLInVYkNNRpvi39B9LtWwnUFzo5WyRjynaXz1rFldT2i8hXCW5KZaDlbEccqz/lRY9XQnlsF3DGkBKtABiYHONFRbAy2V4cTirqdb2W/jMmiK7uDxOGH9JUQuQOuoKIQQ0QJTJEEY3lDJDb/Rb3MHeMIMBtUdGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f3073e-a336-47d9-ba88-08dcea006d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 14:24:32.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyF5idc7CAnfh/nto1+WXzM6SjdD8D03LoBALthISg9XrIQrA+UFDLz5iYcGDV5j8PNd6twjbQORIuLxygoQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_12,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110100
X-Proofpoint-ORIG-GUID: CudFYre7WIeGuoLLUO1Zoo8wG41ZjEBM
X-Proofpoint-GUID: CudFYre7WIeGuoLLUO1Zoo8wG41ZjEBM

DQoNCj4gT24gT2N0IDExLCAyMDI0LCBhdCA1OjAw4oCvQU0sIEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gQ2hyaXN0aWFuLA0KPiANCj4gVGhlc2UgcGF0
Y2hlcyBicmluZyB0aGUgTkZTIGNvbm5lY3RhYmxlIGZpbGUgaGFuZGxlcyBmZWF0dXJlIHRvDQo+
IHVzZXJzcGFjZSBzZXJ2ZXJzLg0KPiANCj4gVGhleSByZWx5IG9uIHlvdXIgYW5kIEFsZWtzYSdz
IGNoYW5nZXMgcmVjZW50bHkgbWVyZ2VkIHRvIHY2LjEyLg0KPiANCj4gVGhpcyB2NCBpbmNvcnBv
cmF0ZXMgdGhlIHJldmlldyBjb21tZW50cyBvbiBKZWZmIGFuZCBKYW4gKHRoYW5rcyEpDQo+IGFu
ZCB0aGVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGFueSBvYmplY3Rpb24gZm9yIHRoaXMgbmV3IEFQ
SSwgc28NCj4gSSB0aGluayBpdCBpcyByZWFkeSBmb3Igc3RhZ2luZy4NCj4gDQo+IFRoZSBBUEkg
SSBjaG9zZSBmb3IgZW5jb2RpbmcgY29uZW5jdGFibGUgZmlsZSBoYW5kbGVzIGlzIHByZXR0eQ0K
PiBjb252ZW50aW9uYWwgKEFUX0hBTkRMRV9DT05ORUNUQUJMRSkuDQo+IA0KPiBvcGVuX2J5X2hh
bmRsZV9hdCgyKSBkb2VzIG5vdCBoYXZlIEFUXyBmbGFncyBhcmd1bWVudCwgYnV0IGFsc28sIEkg
ZmluZA0KPiBpdCBtb3JlIHVzZWZ1bCBBUEkgdGhhdCBlbmNvZGluZyBhIGNvbm5lY3RhYmxlIGZp
bGUgaGFuZGxlIGNhbiBtYW5kYXRlDQo+IHRoZSByZXNvbHZpbmcgb2YgYSBjb25uZWN0ZWQgZmQs
IHdpdGhvdXQgaGF2aW5nIHRvIG9wdC1pbiBmb3IgYQ0KPiBjb25uZWN0ZWQgZmQgaW5kZXBlbmRl
bnRseS4NCj4gDQo+IEkgY2hvc2UgdG8gaW1wbGVtbmVudCB0aGlzIGJ5IHVzaW5nIHVwcGVyIGJp
dHMgaW4gdGhlIGhhbmRsZSB0eXBlIGZpZWxkDQo+IEl0IG1heSBiZSB0aGF0IG91dC1vZi10cmVl
IGZpbGVzeXN0ZW1zIHJldHVybiBhIGhhbmRsZSB0eXBlIHdpdGggdXBwZXINCj4gYml0cyBzZXQs
IGJ1dCBBRkFJSywgbm8gaW4tdHJlZSBmaWxlc3lzdGVtIGRvZXMgdGhhdC4NCj4gSSBhZGRlZCBz
b21lIHdhcm5pbmdzIGp1c3QgaW4gY2FzZSB3ZSBlbmNvdXRlciB0aGF0Lg0KPiANCj4gSSBoYXZl
IHdyaXR0ZW4gYW4gZnN0ZXN0IFs0XSBhbmQgYSBtYW4gcGFnZSBkcmFmdCBbNV0gZm9yIHRoZSBm
ZWF0dXJlLg0KPiANCj4gVGhhbmtzLA0KPiBBbWlyLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MyBb
M106DQo+IC0gUmVsYXggV0FSTl9PTiBpbiBkZWNvZGUgYW5kIHJlcGxhY2Ugd2l0aCBwcl93YXJu
IGluIGVuY29kZSAoSmVmZikNCj4gLSBMb29zZSB0aGUgbWFjcm8gRklMRUlEX1VTRVJfVFlQRV9J
U19WQUxJRCgpIChKYW4pDQo+IC0gQWRkIGV4cGxpY2l0IGNoZWNrIGZvciBuZWdhdGl2ZSB0eXBl
IHZhbHVlcyAoSmFuKQ0KPiAtIEFkZGVkIGZzdGVzdCBhbmQgbWFuLXBhZ2UgZHJhZnQNCj4gDQo+
IENoYW5nZXMgc2luY2UgdjIgWzJdOg0KPiAtIFVzZSBiaXQgYXJpdGhtZXRpY3MgaW5zdGVhZCBv
ZiBiaXRmaWxlZHMgKEplZmYpDQo+IC0gQWRkIGFzc2VydGlvbnMgYWJvdXQgdXNlIG9mIGhpZ2gg
dHlwZSBiaXRzDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxIFsxXToNCj4gLSBBc3NlcnQgb24gZW5j
b2RlIGZvciBkaXNjb25uZWN0ZWQgcGF0aCAoSmVmZikNCj4gLSBEb24ndCBhbGxvdyBBVF9IQU5E
TEVfQ09OTkVDVEFCTEUgd2l0aCBBVF9FTVBUWV9QQVRIDQo+IC0gRHJvcCB0aGUgT19QQVRIIG1v
dW50X2ZkIEFQSSBoYWNrIChKZWZmKQ0KPiAtIEVuY29kZSBhbiBleHBsaWNpdCAiY29ubmVjdGFi
bGUiIGZsYWcgaW4gaGFuZGxlIHR5cGUNCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1mc2RldmVsLzIwMjQwOTE5MTQwNjExLjE3NzE2NTEtMS1hbWlyNzNpbEBnbWFpbC5j
b20vDQo+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjQwOTIz
MDgyODI5LjE5MTAyMTAtMS1hbWlyNzNpbEBnbWFpbC5jb20vDQo+IFszXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjQxMDA4MTUyMTE4LjQ1MzcyNC0xLWFtaXI3M2ls
QGdtYWlsLmNvbS8NCj4gWzRdIGh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC94ZnN0ZXN0cy9j
b21taXRzL2Nvbm5lY3RhYmxlLWZoLw0KPiBbNV0gaHR0cHM6Ly9naXRodWIuY29tL2FtaXI3M2ls
L21hbi1wYWdlcy9jb21taXRzL2Nvbm5lY3RhYmxlLWZoLw0KPiANCj4gQW1pciBHb2xkc3RlaW4g
KDMpOg0KPiAgZnM6IHByZXBhcmUgZm9yICJleHBsaWNpdCBjb25uZWN0YWJsZSIgZmlsZSBoYW5k
bGVzDQo+ICBmczogbmFtZV90b19oYW5kbGVfYXQoKSBzdXBwb3J0IGZvciAiZXhwbGljaXQgY29u
bmVjdGFibGUiIGZpbGUNCj4gICAgaGFuZGxlcw0KPiAgZnM6IG9wZW5fYnlfaGFuZGxlX2F0KCkg
c3VwcG9ydCBmb3IgZGVjb2RpbmcgImV4cGxpY2l0IGNvbm5lY3RhYmxlIg0KPiAgICBmaWxlIGhh
bmRsZXMNCj4gDQo+IGZzL2V4cG9ydGZzL2V4cGZzLmMgICAgICAgIHwgMTcgKysrKysrKystDQo+
IGZzL2ZoYW5kbGUuYyAgICAgICAgICAgICAgIHwgNzUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0NCj4gaW5jbHVkZS9saW51eC9leHBvcnRmcy5oICAgfCAxMyArKysrKysr
DQo+IGluY2x1ZGUvdWFwaS9saW51eC9mY250bC5oIHwgIDEgKw0KPiA0IGZpbGVzIGNoYW5nZWQs
IDk4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+
IA0KDQpBY2tlZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20gPG1haWx0
bzpjaHVjay5sZXZlckBvcmFjbGUuY29tPj4NCg0KQXNzdW1pbmcgdGhpcyBpcyBnb2luZyBkaXJl
Y3RseSB0byBDaHJpc3RpYW4ncyB0cmVlLg0KDQpJJ20gYSBsaXR0bGUgY29uY2VybmVkIGFib3V0
IGhvdyB0aGlzIG5ldyBmYWNpbGl0eSBtaWdodCBiZQ0KYWJ1c2VkIHRvIGdldCBhY2Nlc3MgdG8g
cGFydHMgb2YgdGhlIGZpbGUgc3lzdGVtIHRoYXQgYSB1c2VyDQppcyBub3QgYXV0aG9yaXplZCB0
byBhY2Nlc3MuIEJ1dCBmb2xsb3ctdXAgY29tbWVudHMgZnJvbSBBbWlyDQpzdWdnZXN0IHRoYXQg
KHdpdGggdGhlIGN1cnJlbnQgY29kZSkgaXQgaXMgZGlmZmljdWx0IG9yDQppbXBvc3NpYmxlIHRv
IGRvLg0KDQpBcmUgdGhlcmUgc2VsZi10ZXN0cyBvciB1bml0LXRlc3RzIGZvciBleHBvcnRmcz8N
Cg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

