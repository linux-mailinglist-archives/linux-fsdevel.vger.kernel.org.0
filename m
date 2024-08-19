Return-Path: <linux-fsdevel+bounces-26313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C757D957345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556E41F214B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05B4642D;
	Mon, 19 Aug 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+0Vn6R1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NQaD+/P8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1C13B2AF;
	Mon, 19 Aug 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092211; cv=fail; b=n3XTfTVtC/09OK+M6M16H+pMVJBNbhlbB+eM6M3IlEL45nZn1CVGWMUmkM2FTUY+WLlzS+W62uuhTtwcxyNWsOjiVa3i99nmrTL6KCZ4GshcJOVQu0RU5K28TCdYKgw3IGJBzwCIrYthz6KOLkrJ7yintRtw1PYpUVgBERPkXTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092211; c=relaxed/simple;
	bh=m4ih6efs3jJh1naTXTvr1dt0DHEChfIzklx8ntFYjA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OP/jYmEn01u/4hbmpLqlLNFrD0HxGEWDmEYHkCGhgtCkTWWT9g5HoCcRo0XeTDUXwOQK7oYLowfxeeSLiOesd7G0wSEjrQSH6UK1/mIjgqA5Yab33hjRNJt/mICkQEmS0z86kaNU+FgWed4038/eifxPRuQnOt48OKMjGZs8lBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+0Vn6R1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NQaD+/P8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JIJvMc011241;
	Mon, 19 Aug 2024 18:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=m4ih6efs3jJh1naTXTvr1dt0DHEChfIzklx8ntFYj
	A4=; b=n+0Vn6R19GFS3AGcXYEPG/aL5/SaTOCeyClM9bWz0pi0N34sZCtCj8Kzl
	PJPa2i/4OcaxFT0jYHZFeCQAO3uk/XrgxVXfDYzquclS6wSO3k0QCBxnvmzJ13CA
	e3G9z6pvNCfJzftql6R3698566MGbicBCMeKkYQ23GsoCsyT9p11M8eaqOJSjOVS
	2rlX/bQDfHFQm3hpnLamNaQykC089xPTOG/qhRW9xtv8Orcfsc+2JTsgVPVDPL8z
	Ii5FtrWRS/NGOKPO5mH5J/pAPLdJhX0IsGhq4i7xnN2wtiKN/5vrx+vWWFNq91+C
	1FqZ2gOO0nURx47TwctZTRGcjqfLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67b97n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 18:30:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JI5XLo003190;
	Mon, 19 Aug 2024 18:30:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h8qxyb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 18:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC+X9GVL2wiOVJsZ5k8k3MjXLNO93ElCViZgvrCNIqtzvKrBvjhvWilXZRB1/hQqvs9JgUBOwx6sfGFtYbyUv/55x3LER63eqF27RoWii5gghYBZmil2Gh9UP8oMet425a1sTWKqjBDH6aCgBMvASLZ0AxqWNIGb6tNOAO2c+s7huD5U+1NhtHEPTh2ZU41h+Y+NYAvrpnKZaY5DdBzaaVfMtlEYzaWuwyc87Un/UPEeK1nHGI0WqKqVIuMyP4odrWZTxGmcrp+H2ROGp73D6xc9Ne4xbrhMSk/WNWGEx/hswW590Lah1EyE05Wj9j7LqXtSwVlBaiZxA8bmWin5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4ih6efs3jJh1naTXTvr1dt0DHEChfIzklx8ntFYjA4=;
 b=Yx6ci34+V8w3j3yrhdQH+888Q8/NVP7oYK1r9Xi6ML+jmdEcH1FWEm6m2yyRiECiUPGLWwebzKLx+Tkd7jpVJGASXHIZ42KAAxT3cEjKFMtdc9ydJGcZOP52HTqnJGua4c4vk1orKVNU3fgs9jseJgJ6NcsM/ztVzzmDVv9D5y2K6Ma853cQ8TcZ4a3UZaZ4XnR5jNpIO4OwpGjjenzA7JpZ1iq3UD56fNW3uxdFKKVdJh8TU/9LO4p1K4IYD2zwN1T8lwPAtFxnx2hTHWd+Ak/c5CyxpvzMrluXohCzG4zuvVYmG8xP0LQQKrdM9Sa4KrNN+xao9eFMwD86HORSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4ih6efs3jJh1naTXTvr1dt0DHEChfIzklx8ntFYjA4=;
 b=NQaD+/P84+K4nowYekPgltctpIE0pT0CStTvp4Mjxin+F1UPT/loLlUiZ9ro+uu/u+aLlYpcJqAweagqfjP4lprLBcOK9YeQLmdRY0jrOBWwhxxZ1NzTBQ8FIOi1oLBTtlVivmY9ejwzCSKSM48Hu5VCSllhC0y4gUKLwIzPTH8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 18:29:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 18:29:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v12 00/24] nfs/nfsd: add support for localio
Thread-Index: AQHa8mQtiiugcfJoD0qX1Hb11FX5MbIu5sGA
Date: Mon, 19 Aug 2024 18:29:57 +0000
Message-ID: <D42F5EA1-5C20-4576-A85E-1183AA192448@oracle.com>
References: <20240819181750.70570-1-snitzer@kernel.org>
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4499:EE_
x-ms-office365-filtering-correlation-id: d71a6079-b0f2-4107-3c56-08dcc07cede0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFp3M0lzRXRMbDZjQys3Nk9NaGR2ZVlWYlAvS3piNEVKd0pyREc4eTB4aDg0?=
 =?utf-8?B?S1ZwVnlybTZ5eFRJQUhmenVsRFkxOFNzcGxqS0xPWkV4THE4cHpITWtWQXQ5?=
 =?utf-8?B?TFArNDExTHN5bnZ4MU50d0VYOFFuY2pZV0c0SG9IdVlYWnh1Z1dvUHBkOWV3?=
 =?utf-8?B?R1M2UWt6ZTFUNlM4ZlQ1cTVPczNNWEZTNWdpazhYdDFrSTJCZzZjVHpsdVBB?=
 =?utf-8?B?YWRDU2haTWFKZTlDdUpPejlOczJoRDNNQjJ6Zmp0UGZzQlNQZk9MK1NQMHpz?=
 =?utf-8?B?M3pYM0M3QXVrU2NEcTFwUnJkY3pUQURpUzNTVnFlSGhzRFdPRHY4MWRiVVBS?=
 =?utf-8?B?N3FDQjVMN0FrcFdmK3BOQmV1YU5HcVB0anlyWlVoWlJISnNYQ0s0ckJGNFVV?=
 =?utf-8?B?dEU5Vml3bkEzQ2N6dEVkclY3VUlZTVdtTHRrTHRIZDNxWFhhelRyMzNXYU43?=
 =?utf-8?B?Wlg3T2hyMU5mRy95TWN5bGE0ZlZNaElOcU5nS0xadHlIK2ZzQ1BJdWhXV0lR?=
 =?utf-8?B?eFhDS2RBdnN2REJ6MFZnL2tqbk9tZWVKbjVlVHByeXd3UVhDK0hKaXhEQzdV?=
 =?utf-8?B?d0tFK2pkeWVPQmZ4ZzFOdjNZallHMzU1ZFVLdy8zdFdXVFBqWDllSFdzUmFj?=
 =?utf-8?B?RUIzWTNobDl6aWJMQVYwL1BER21kZnB3OHBUQ1VVUEdNUVE4MUtuL0RhZnZD?=
 =?utf-8?B?THFBdng0VE0xbVZwY0pBejBOWnV1TnJRTWp1VWVmdjFjZUZQUExiVDBkTVJt?=
 =?utf-8?B?NktZWTlsL2x1UFliTzlrbnNybkpwallmQVJNOTdKQzFoN09HbkpTNEE2Q3F6?=
 =?utf-8?B?WXRpU3lycGxNZ1NHcmUzYUR3cFZYUUoyTWJib1hCZDVmcFpBUTlENEdEeFlX?=
 =?utf-8?B?KzlmYlcwdTZwUjlYb2RYYWpSN0Jla2hjQldyWEhsNHVkSlJTSWx6cVRsaGZL?=
 =?utf-8?B?bit2dUhZajNFdnpZUFNPTURWbVRyMmsyWjN6R0E5VlBUdkdHK2kvdjI5L240?=
 =?utf-8?B?TDlSNVBLdElvbFk2Zjg1UytRYjBJRXR2MElLbk04VmlTZ2VsUHlweUlWVjdv?=
 =?utf-8?B?NWpad0xwV2hqZldUcGlydW5UazBBNHJ1cjQza0pudk5wVXBkN2ovVGpnYjY3?=
 =?utf-8?B?cVJZanZYeTJlMEFNMXc0WTVwNmU4RG5JVHp6ZmttelExYWthem5QNUdOeGhp?=
 =?utf-8?B?K0FjaGlmUDFTbUM0VVJORG10UlREdXBoVnpHT3NscUw1Q3p1Zm80aHhRSzlr?=
 =?utf-8?B?a3U5anBvdVZsSHJ3a01kMkw3SzBMUkJKMElYd3lHT3EvT1I3dW9tcDlwek1v?=
 =?utf-8?B?S3JQNlp4ekJyOEpCV2dhV1hsK2FYN0YxZjdkcXJXMHUzVlVpN0Zmc2xIN0x0?=
 =?utf-8?B?K0Y0N21LMEY1YjY1aGFkdE9RWlBpUEJaaW9DblFjMG93NXFHUW8rSm9BaUpH?=
 =?utf-8?B?cXBKU0pZa3dVbUxZUDdhWXlwTTVyZEY1QTlYOVFOcDQ2QmFWbGN3THhodm5U?=
 =?utf-8?B?bGgweS80cVhIbjE4czRheVQrdlNoaEkrSkdtS1F6NXJkQmp5clJNalVLVVVK?=
 =?utf-8?B?emVLdEoyelJEdEQyMWVKdks0WUlGWDVJODdoQitHSllCQ21qQ2RBWjhWNWpX?=
 =?utf-8?B?emlZUHJRWUcveWJ4RHExNUt3VnNpNFVQanpnb3F3QlFyazV2Z1pXQmhxR2RS?=
 =?utf-8?B?MkIwZDhJS2FJTmp0dVZUMElIQXFiU0hEYVZFVm5EYUtCMHc0MG1aYzVJcWlz?=
 =?utf-8?B?MHphNmxNZnliT0FET0dwakFONEpocTBTaVphRU9ZclVtdGN0UVFOQzJmREFn?=
 =?utf-8?B?QXIrcVBPUkluQ2ZZdURxVEpkMk5HSStGVno5ZUVnYTBLelhFVGdTSTdZTGxV?=
 =?utf-8?B?RHpLOFRWcWk1YWY5K1NjcjNHNnMwWUI0UGtWbFp6dERpL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzh3Rkd6cVFWUVZSWXZ4ZHBiRFAzcndGWlJ2NmNBYk1CVmNSdGFSM1c1NXhh?=
 =?utf-8?B?ZjVSaVNyZkh6dTQzQmd6bzRLTmZXdTFtNmNlNnhwMmE5WFlCeUs0OTliVjFQ?=
 =?utf-8?B?TS9iTXVnNzAvNU1DMEJ3UCtDbFppRjFaK2RFN3YzQUY3NFdLQWd0ZTdHWThQ?=
 =?utf-8?B?RFgrUzNvZitCWVV3QnVwY08rdXFvY1IybGxaNERzNk8wTlF2REpkcjRQMzZM?=
 =?utf-8?B?YUw3Y0M3RmJoU1pVQ0dEaWMwQUo2WjZ2SGh5dkoyNjIvTkFNeDUrbDEyanM4?=
 =?utf-8?B?bWFVbVY2WWQzQnZOT0lEOTJvRG80RUFzWEpHWXFHNkFvb0k3TXg5ZTRDeDkv?=
 =?utf-8?B?dGpGYmg5V05XcXZkRzVidHZNVm5iUkROSzROeEJ0WVUxdG9aYkIzYzFmS0Ni?=
 =?utf-8?B?UkZERGwwcC95ZWljTGI5empEdEtjdnBhelllMnAxczhQemwrbGt0c09UMGpw?=
 =?utf-8?B?RTBsOFlObUpuRzlaMHJzQWpGcFRtTVJlOHlCd3dZa21qbzVDTnlxYktpeURG?=
 =?utf-8?B?RDJUN04rSVlPY0I0N0MrMGM2cStoTGhaNzVTdXpTOTNjWjF2S1lFTFpGZXpw?=
 =?utf-8?B?TXdqbjNxTktBdFBCbXRiZDBuTk54d1VCSy9QYlhYSm9hSGFnK0RtZEtoanBm?=
 =?utf-8?B?M29HMmxaVGJDcm9tU3pxd0JEMWxqNGJOR2pqNTMweGtyRk02L0t6WHVpc0xz?=
 =?utf-8?B?U29hU2dHTEJSbENWVzFzYjhwMHRzbkJVcjZ1MDVNRFRERWI2NUdTVDg3N0Jv?=
 =?utf-8?B?eDNSZzU4eU1JUkVMZFkrU0g5ODN0dHdJd3RsdElZT2NxSWJwZ21uMXhPeTR2?=
 =?utf-8?B?eGFxVlNPMFFXb0orQmtEcWlRRnFTQ2Zzd3NoQVNnaUpuZkd1Y1R1YTJxclc0?=
 =?utf-8?B?M0tuNHl1TW5Odjd3UmlLZTV6OVMvQk1tZUx0VnFsN1BYSERQcGMzd2xBMVln?=
 =?utf-8?B?aWVmb1A4eGhvQ0hpVHZ3dmQ2dkN3L0hMSVQ2YWxOZ21CaWZBc0w0SnpjNVBV?=
 =?utf-8?B?cE94dWg1YzlGTnhjaXh1OUJQTU55UnZJWkJGaWVxMjJpeWJud1Vha1Ftak1D?=
 =?utf-8?B?UE12ZzM1VWdlbU5HMjB0ZWtqMnZEekJiZXhSeUpxZDhDL0xuZWQwbWUwMFZN?=
 =?utf-8?B?Tlgyb2FCYWt1UGlIRWo2ck0zQlZKOXZXTG13Q25lZ2dFTkZZV0dsTkYzalNy?=
 =?utf-8?B?SndPb0VseTJFL0xlcFF6M2wxRnE5cFpxYktlaGxJdUorSFN6U1FtYmY4NzVx?=
 =?utf-8?B?VDZVZlJ4ekZQd3dkOEN6Z0NhMGhkMzluYlZmYXNXYmtkL1hxWVhsaWxNTHJN?=
 =?utf-8?B?bXpHTzFHS3Vyc0tUcE90TUQ4dFIwZzg1ZnZrNUxjOUZNb2h4cGVuTWRSeW85?=
 =?utf-8?B?ZnlhUFRtaXVGSmtNenNuYzRMSDlTaDJXRWMrZU9IUlhEZDNZdzdmcDBUckZp?=
 =?utf-8?B?alp6Umx4YWZWcFRTVHBpNXBwd0JkZFEyTjVMWDJsNEtGVzFnd1lVS1NFUkRQ?=
 =?utf-8?B?dGRJZ012WFY3L3lITXdQb0IrNFBHKzZWZk5DcUVVTFkwVkIxL1FiRyttZktF?=
 =?utf-8?B?eFhKVHVZRGQ0MnhRTmtxUDdGSWdHYnJqSDRTVUlDSWNQb2pCQjVhYkV4bi9x?=
 =?utf-8?B?ajBJZ3lwR3VvbTNvVkZyOHFBTTErUXRWNHFRMG0zc1RHRHQrak12YnhJYmRW?=
 =?utf-8?B?VnNMZUk0M0JxTHhXS2xEM0pLclc4Q1VhRC9mWTFPS3ZtUGI4SEw3dlp5Z1Bx?=
 =?utf-8?B?U3E3aXRVWUZPYlNZTVc2NjRjK1cveDRBZzhUakNWNWtEcWlhTVJzaUVOenZ0?=
 =?utf-8?B?dnZsdERVSzQvWFJ5cnJ3aWdMRnU1MkUzOWthZlZacGdPQmhWYktsZGVSU0JU?=
 =?utf-8?B?SkxHa1I5L3RYeU1Wc1NuUTdMR2hZWmxvZ0VRSHI1SmxCemFxRENVNHpxbUlU?=
 =?utf-8?B?VEVyWGRibmZyTUhuclczMEkxZHhHeVREcGFZVTJ1SU85WVlGR2VZL3dONlh1?=
 =?utf-8?B?bTI2SGx6MjJQWGd2Qmp2dlV1dDA3OEJhODBZR2MzZ1hnRUxsUmlqUWpqWFdI?=
 =?utf-8?B?Mk1sZFFZcGZ3dVUreWVHZlNzWnVadzZGVzhSZXZDdEIzMFM0T3BRc1cwb21o?=
 =?utf-8?B?WktEalpKbnduZ1RLOUl2RHYrUUNZbnZLKzQzc2NhYlFHNmdiTG0yUXFlYUxU?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4511495A3FE6B1489741723EC2F46D87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EzHwlStlaFjpcq6HqjVCEmYaEUGFkrZp8A8upcyHeoVLDcvemhLvCKisPm4JtAlZd8FkeJwq4lIWzp14RUngSXK7IPlQh90umDTmk5gxby+LaI+KjbcA/pYCIxSuMbiFMInxMboi5KjReP5IqlVfXAKxU9xoqgW9+AKvYP6ZTNQni31qluuONcMp4CQNfcxqHqz7l+1U0w4ItyJSZwal0b0DEZvTD42iCSMe/SicqlJpdjQ+bfCLNKIOXthfi5KBpMyOqhTaZ4bH6fngWQDdhhRnuCbWjkh8+0klUoDWu42NZf8ufZSn7US4Y8Xj+MUW2X3/yBraJ1CV5uRUyJTyFQlDCIjsAv9h7Z/QAwJ9/0D604yZWn8fDI7h57IkbIpLmYArpSMEt97t3qrfuyAInpMtxZRA7YSRU57FnXct0j5HRGYy/6Zy51lhfdEfPKoeFWQfZHrQqE60cdfjqEtpA+rTfWWAuPLUZkdvhQUCakZ+A5Edc56gPAfdUtcqfQygUFjLJy/RhZHJxrg+5rn1/AMbi0XJOPnc47qaf5DWwpkENs0LazJou0raUG4YgKWZJSbXaHxuPEvBINhwsdHhPg6H+zmNIxUT3I8snmvM5m4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a6079-b0f2-4107-3c56-08dcc07cede0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 18:29:57.9097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuBwCIlLp/EP3dm0Evnf1jq8cjfH/Yjx3DtL9sSC38DxlOOq90gephiQPWz5PdGFx4eEG57LTRDQeoSfGdnXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190125
X-Proofpoint-ORIG-GUID: SsV8ymbpxtU3RbAeEX06hs-_V-v4uU8J
X-Proofpoint-GUID: SsV8ymbpxtU3RbAeEX06hs-_V-v4uU8J

DQoNCj4gT24gQXVnIDE5LCAyMDI0LCBhdCAyOjE34oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IFRlc3Rpbmc6DQo+IC0gQ2h1Y2sncyBrZGV2b3Bz
IE5GUyB0ZXN0aW5nIGhhcyBiZWVuIG9wZXJhdGluZyBhZ2FpbnN0IHRoZQ0KPiAgbmZzLWxvY2Fs
aW8tZm9yLW5leHQgYnJhbmNoIGZvciBhIHdoaWxlIG5vdyAobm90IHN1cmUgaWYgTE9DQUxJTyBp
cw0KPiAgZW5hYmxlZCBvciBpZiBDaHVjayBpcyBqdXN0IHZlcmlmeWluZyB0aGUgYnJhbmNoIHdv
cmtzIHdpdGggTE9DQUxJTw0KPiAgZGlzYWJsZWQpLg0KDQpMT0NBTElPIGlzIGVuYWJsZWQsIGJ1
dCB0aGUgdGVzdHMgSSBydW4gKGV4Y2VwdCBmb3IgcHluZnMsIHdoaWNoDQp1c2VzIGEgc3ludGhl
dGljIGNsaWVudCkgYWxsIHRhcmdldCBhIHJlbW90ZSBORlMgc2VydmVyIC4NCg0KVGhlcmUgd2Fz
bid0IGEgY29udmVuaWVudCB3YXkgdG8gaGFjayB0aGUgd29ya2Zsb3dzIHRvIHJ1biB0aGUNCk5G
UyBzZXJ2ZXIgbG9jYWxseS4gU28sIHRoZXNlIHRlc3RzIGFjdCBhcyBhIHJlZ3Jlc3Npb24gdGVz
dCB3aXRoDQpMT0NBTElPIGVuYWJsZWQgYW5kIGEgcmVtb3RlIE5GUyBzZXJ2ZXIgLS0gaWUsIHRo
ZSB0cmFkaXRpb25hbA0KTkZTIGRlcGxveW1lbnQgc2NlbmFyaW8uIEkgdGhvdWdodCB0aGlzIHdv
dWxkIGJlIE9LIGJlY2F1c2UNCktlbnQncyByaWcgaXMgYWxyZWFkeSBoYW5kbGluZyBMT0NBTElP
LXNwZWNpZmljIHRlc3RpbmcuDQoNCldoZW4gSSByZS1lbmFibGUgdGhlIGx0cCBORlMgc3VpdGUs
IHRoYXQgZG9lcyB1c2UgYSBsb2NhbCBORlMNCnNlcnZlci4gVGhhdCBzdWl0ZSBoYXNuJ3QgZXZl
ciBiZWVuIHJlbGlhYmxlIGZvciBtZSwgc28gSSBkb24ndA0KdXNlIGl0IGZvciBub3cuDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

