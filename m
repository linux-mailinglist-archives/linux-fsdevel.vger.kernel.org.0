Return-Path: <linux-fsdevel+bounces-28911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5F970851
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0651C21802
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28706171E5A;
	Sun,  8 Sep 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UCg2q43f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jf7WuahH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F616D9C1;
	Sun,  8 Sep 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807937; cv=fail; b=Q0FEfIdqh9GDxnGev/GKdR7cQgUdnwPtttRPcUR3HiHRuXbLeg1ngBEG9XQRdhZ4MeMKK6eIEMuKx7lwLTvVLCa/yCW0J3gh31QCsodWxzVepFDISgpm+QqroEYRvzDuqcc0LTTxJxsPC3pa7IbDEUJQD7y6XM7A1Lnmi0LWesg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807937; c=relaxed/simple;
	bh=T80B9Oxmk7AVPgW9QJGlRRQGUCJvIDZCkxyR4MaS5i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOjsI0uWMdQHg1vTcASMLQ9CCfvT4C0rf8dGQcGIbrs7apVlfi/tqHt3vitBshpJpHWNT/TgvXG8CqqypkfjX1bJ9AZDoOkLrM8UhKiLWGVzSeM9y+VV/goAa6pr7DgEbIgSbVaD7p7LC8+Jg7BCaT2kCQw/uOT/gZ9HR8u/M4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UCg2q43f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jf7WuahH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487Na8j4013498;
	Sun, 8 Sep 2024 15:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=T80B9Oxmk7AVPgW9QJGlRRQGUCJvIDZCkxyR4MaS5
	i4=; b=UCg2q43fiNTZbW2ZjHFcFs8+QVogRQDOnoB6Zh+q2T+tiDO6kS0eIqoDi
	us/OS9SKTMXJw5PRARcYiTG6D+LQVpvoYoYh9B+zGpPDknS54Z+bcF2G3+k3ECWb
	JiGEmHXePNtU74HPR/GB+VDedhoWsaYnyg4XsbMspMLJXA4iRRORsiEc32jrYDrh
	ffd1LOJotS5p07UQDg7mwHShsV//HSYKbVCDl6OxCySN4kBnwPcCzoTSJmwoqNhp
	w8oDCeFb41Vk+/UAr4+pZyN0aFQnhTgsmLaDVM8anIJZlw5x5Jn7/QtlA1do362m
	pPL5aD0twgy97Md8wU7fCGsHLvguw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2hdut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Sep 2024 15:05:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 488DRt1c005456;
	Sun, 8 Sep 2024 15:05:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd96c8gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Sep 2024 15:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdWbEntQRaoKl9Pdwe0ZCdzUjuPWCyAVxVkb9uAeavf9IXE79NhWK8w387hcoa9qKIDKStSEDHwQBGgx93LF3z8t9xS6a7x3qOjIDaE4afe2+oCvUaJP9gP3vLHZ0dQwpPsCXafFW5uLaIx8VBF4z+oy8m6K+vTo7POLNe+O4rcCyhlF5jS6cu2+p27GJoeGtuymYkPEwkOYKF0E6djGcjqPqNFpBAbTKYPQNlApQxEa8EI29Rn35yY46wLXV4nLIu3QqXFmHSfQWWLYDn3eIBokTEmrH2AzOH4wXxqZr2dVr974DKf0bOysC1XIFchXKJ4Whj8yHtcFJBQDXLlqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T80B9Oxmk7AVPgW9QJGlRRQGUCJvIDZCkxyR4MaS5i4=;
 b=pYI2a0HMsrcTS8GwAChgGeCjDWVoDrWaJZ4ZcvrNh7e1NZ7Ro7kBLbQiMf4+Zrib8yphvLbLAHU0y4R78lMT2qGzozN5Zs5uYo0bq/7QPXXlJ0kD6T2O8ynVvNSgQaUkW0MYn9IPqDugzeRRcFxeR4RLQ3IkXZol6OdNLkgz42PAGnnAggZxrI/+Xv54iZOCdoBdyQdv3CiO0S/ngHGOev9TTc0Mr+q9TGjaGTBZ7+ko0jVcpnw6v5UCEgBZnfN2LWpnZrRhNuepZltTuYNueQg+g67jlTvl+ZU6jOyveasfvcHU0gmkJ1zGmEciiRFeajRraC6sc0SWzmvk+Y8VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T80B9Oxmk7AVPgW9QJGlRRQGUCJvIDZCkxyR4MaS5i4=;
 b=jf7WuahHkTRJMuiuo0RM8M03QsyRC+p+0jAUEAkEgpdE+4I0PX0/PnjT2D4lIIUpoTytQ8QFFjg9TTG8zWi7TrcG/N2GKHfRbyx0bz2LVDDaF/CdBM7XmuIUnQCmJa2o0mCEJnDLCT0KdxtGH3AX99ZLBbjOfohDPJOuujgVFTQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.9; Sun, 8 Sep
 2024 15:05:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.022; Sun, 8 Sep 2024
 15:05:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAbZ+AgABs/QCAAJLIgIABm82AgACaigCAAQPhAIAAMy8AgABAEoCAAAoaAIAAC72AgAEM8ICAAA59AIAAMeyAgAAirgCAASvMgA==
Date: Sun, 8 Sep 2024 15:05:22 +0000
Message-ID: <F906E84A-7FFF-4275-A2A7-C5DF0C6A648F@oracle.com>
References: <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
 <172566449714.4433.8514131910352531236@noble.neil.brown.name>
 <Ztxui0j8-naLrbhV@kernel.org>
 <3862AF9C-0FCA-4B54-A911-8D211090E0B4@oracle.com>
 <Ztykk5A0DbN9KK-7@kernel.org>
 <0E0ECEE2-AAC5-414E-9C77-072A91A168CA@oracle.com>
In-Reply-To: <0E0ECEE2-AAC5-414E-9C77-072A91A168CA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4332:EE_
x-ms-office365-filtering-correlation-id: 0b6374c7-e94b-467d-6eac-08dcd017a93d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cy9UZ0s1NHlIeExFeUhEKys5T0VWbDk3QXg1TUcxWWxTdnZLN2RsREMyMDR0?=
 =?utf-8?B?ZDZ3MnRuY0NheFhnWm1GRVNsNG9rVzdKQ3hBL1dmUXF2RFRKa0gvSXA2Q3FW?=
 =?utf-8?B?cXp4K0hXc005NW5DSGF0aGoya0M4elB4aUxiRDRHN0JFc1k1NWJQR1QybWR2?=
 =?utf-8?B?Sm9wdUkvRTE0RVBUd3Z6NUFwMVdwTTFRcWplbGpnZWlicUhwU3pweGxocFl0?=
 =?utf-8?B?YlprUzN5amk2ekZObUZ6cVZRd3M2WXlvRm40QU02NTM3cVUrQTU1QlJtVnRW?=
 =?utf-8?B?S1NEd2lla2sxVlhJTmdRUDBYZFJZMXY2L2VaR3d0Z3N6L0V1bUdhaUd2WDVa?=
 =?utf-8?B?QlFJcUh2Wm12eEZjeFhxZEsvK0wzTlA1cGVobW1hNFNZQTlMK1c0SnRxSit3?=
 =?utf-8?B?OS9XZy9tbHUvOXNtN1ViWUkxL0dzM1VReFdnODVUMm9HUlN1VzhMQ1RMWno5?=
 =?utf-8?B?YUYzTyt1MzlqQVFrTHFvZU9vYzBXSlpVYnZCQUlKY20ycUoxREZwdHRNVWlT?=
 =?utf-8?B?MlBXYTV1bGJrdjVmRDFNM3dpNDl6c243SldhOVV0eFRSZndCZHQ4TWpDdWhY?=
 =?utf-8?B?Q3BrcVlZQkFTNXJNUE15NGlpQURlSjB0bWp2M3VhREtPczFnRTRkaWhjNUth?=
 =?utf-8?B?dEdOeGNSMDdoV2R1cmVUNTNlNVZ6eEZaU2dXZUZPeU9acFY3RW9sMWZNM1JE?=
 =?utf-8?B?ZnROd2MwY1ZURERaM1VFdUJWWis2bVpEVnhBNkpjdEppZGJSbTd1b3BvNlJE?=
 =?utf-8?B?Y0JEVHlpMjJGdGdEZTdpZFRYR09QOHlRaTlCOThacElaUXJGSmwrZmZGTkY3?=
 =?utf-8?B?b0w4eUZoSjk4VERMNmtpdFB2aDlWZEYzNUQ1SHMrYXIzeC90U3VCcFZzd3lt?=
 =?utf-8?B?NGMzMUpCMVRCcVZpWGJTUFl0TVRIWFBFRno1SGNYWnFMNU9QRFdmYzlEN2ZT?=
 =?utf-8?B?NEZsMStSeEExSi9QQkFEenR6cGJjRUxKSGZ0aFNqdEtqdnRtV2h2Z0xHOTdK?=
 =?utf-8?B?OFlhTjFUaVJYRXFxR1k5Z3p0bjNGdm1FWVZJek1nRHlwRFZRMFVFVnMxNC9o?=
 =?utf-8?B?NDhRVzlhQXBKMEs5NnFranJCTEZrdkZ0a2REUEtlY2F1RGMzd2tYb0E1M2FF?=
 =?utf-8?B?TzNmQzF5QzhaTTlhY3FLbWVKanc1eUxPaGd2Rm5FZlZJV1hpVXZiNEFkelpt?=
 =?utf-8?B?U2xnYzNOWEFOTlB0cGR3Y1dRWnhIS2w5dnQrVU1NbDVXemRMTG5BRENKUUp3?=
 =?utf-8?B?THFMVTgwaUEybk53RGszc0V3Ty82QU9MTFd2Wk9aVXU1UlBaS3FUNjdObk1p?=
 =?utf-8?B?bWNtaWEvQWQ1MmdnWGFNZDE2eU5EWWxpMlZJb3RKSkp2L2ZEVXV5RVBQRjBF?=
 =?utf-8?B?RWpYcGkvNHFnclRrOFpGR2Nubm4xR3AwQkpaRTZLSTNQZGtnb1RjRmVRc1VQ?=
 =?utf-8?B?QUphWkh3UGF6c052Z0VlOEY3MVMwVWtmUFNnVndOOElMR0Z0R1crVXpub2Z0?=
 =?utf-8?B?NENKYkRrYnFyL01DOFg3bkozUjFJMkc1R05FRzFhU0ZSclJJR284OUZwNURy?=
 =?utf-8?B?ZVhoOHIyYkE2bGhLaHIyZkZXQUFFYzR1Zjl0Umc0K1ZNT1FvWWJhVXY3UkZi?=
 =?utf-8?B?a2VCTWZNcHVPanlIbVhOUkNPTEhWQkdqaUlrYU0xclpmaUxtbUU4MlY3RmdO?=
 =?utf-8?B?YmY0TEFBUXZ3dCtlWTl3NGh4VWgvdDJzamJJbGxQSFlsL0dPTGEzWGMvYlhI?=
 =?utf-8?B?U212UEc2eFBRMjVFSS9vclZLVTJBVXRlUk1DbVR2RkhhbnpvdG9KVmc2QXpM?=
 =?utf-8?Q?mrpjOMNQsZYCKu4YkzzpaWRWR0VtC6RJJtVrc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cG16aW15dUtiR3RzUWdRM0lJVTg3bVV5YWxKZityZE5kUVJxQXFKekFMaXpE?=
 =?utf-8?B?TlNCNG90YmZsRjJkZVhEVEJweFZmTkRNK3VGUlp1Vk9Qd1k0MG9qajhRZUhX?=
 =?utf-8?B?bmt6N3htckhqY1poTTIxUHFxek5ZdGhhbktCUmlzOEpzc3VVdTZPanhLVU5y?=
 =?utf-8?B?QUl0WDkya3Z6QllVUmxtV3J2WCs0RzRDRDRaUDIrcndEK2xNbmZZa2dUQUt4?=
 =?utf-8?B?Y0hGcWZQNktOVUhJTldXRUE4S1J2dGxtYmQyMXVJeWhUMWJnbzUwVHRzZFRk?=
 =?utf-8?B?MVpGYk5abVgrdUdSQWk0NlRPRHpGV2dHQUJsZkZPV2RpS1ArYUhyU0pVS1pW?=
 =?utf-8?B?dC9mVG10N1lQczNEMHVhOHd2dUtZaGRwanJPdXRKNzhqMXlpeGtNdkFIWW9U?=
 =?utf-8?B?dG5ZQjhmcDBQV1ZaL3RsaW9aaExjMVIxY0pVTjlMSUVOczc5eGFHSUNTQ28y?=
 =?utf-8?B?MkhWdVBtemV0MjRoMVlxWjlaSnRoRUI0eG1PNzlHYnRFYzl2UkFuVHN2OVdv?=
 =?utf-8?B?UTRIQit5THJHQkJBVlF6ZEVwNnpYakpycExoblRjL2RtL3AyTUQrQithc3Zo?=
 =?utf-8?B?QkhmZHNyVDBQaE53aEY5ejF2Uy8rWXBlQTcyclppcU41emdIQnBZTVdRZGR5?=
 =?utf-8?B?ZTFyckFHY1diK0dqY3dnWld4N0w3MmIvVTB3OFZJWUdaeWRYMlg3aXZORGJv?=
 =?utf-8?B?SDF3YVZHK294SFdnQWtaUG5aSnJnVk56OEFUdTlSMkdSZEJmZTFpVWxSbzcy?=
 =?utf-8?B?d1lPQVBTTy9ZUnoxempuZUlCdGZzZitGbmdHeHNkQmtHc3ZjcHBoek1iaGxs?=
 =?utf-8?B?dm5pQ05XOHlLOXNpWTlmek51WHo4d1IyTU1PM1F0QUVEVVZ4czY1N1YrK2dE?=
 =?utf-8?B?M3ZETlFINVlaSlNYb0tLemxZOSs5VE9tT2h3TmxRRlArVVh4QW5LcGdOM1Ur?=
 =?utf-8?B?eFdYeUw4RnI2SzJuSHVTM25uSml5LzlIQ3VEeEpSV0ZySnkxb2I2L0FaSG1I?=
 =?utf-8?B?K0hIcVVFcy9LcTJTWlNTTm5zWkM2aEtWMHN4RG5RbUYvaGhudmZTZExaMWYx?=
 =?utf-8?B?OEhnbWFiUXpXVnRSTUFMZFUybHA4TUJUUTQrcVBnVXFyWldiaGxYZGRpV1hS?=
 =?utf-8?B?RnhOaDh2REpnVFRNRHRQdWhTUVYzL1k4eDYvbVZRRkx3dWo5cXIyYTh4dnNW?=
 =?utf-8?B?OXVnQzgreDhuNHFoWFkydlpCUGZCOER3ZzkwN3ZTSUJ2cG95WDAwcjJheW5R?=
 =?utf-8?B?S29vNzdKckhXeEZaTVRmSzhmSUVWNzEzcTA5UFNhTXY5c3JVOTJTclBGTXdT?=
 =?utf-8?B?NlVEaXdZQzNLRnZrVW9kY0pLZnZya2pyakc3dEw1cW9YOVRFWktCVmFBR1hu?=
 =?utf-8?B?UmZEMklBeHJVL0lzbVJGdkgzRTVkUG5pUzhES3dwc1ppNXZSajhPMitxV3JT?=
 =?utf-8?B?dFoxN0xUVWNRcW9JRWJ0NllyR3puenRPeW43NHk5aGRPVkd0d0VpT2RKcHVz?=
 =?utf-8?B?R1NYdDU2Y0xIbVkxOUVvYy9RalVLUDZIWHRNR0IydXhMQkJFVGE0QXE0QW5M?=
 =?utf-8?B?NFArNUxzNWVZN25RWWpWZVdZallqbkhpTkNXWnRVWHIzVGdEOXpkVXBqbGg3?=
 =?utf-8?B?TGRlYlZXd1drM3ZaeHNKeUVKb3hINGE1b3JaK0NaRXdDSWdoVDJuTENSK3NF?=
 =?utf-8?B?ZHhobG96WHZmNzl2ZlMyN29sYm9tRmtOdXk1SklRL1Q2amtNRG1tOUp4Yzh2?=
 =?utf-8?B?NTdOaktGVWxaS0M4aW5ybkhGZCthWERrUTFJOWh6NEhyK2NtQzlUMWN3QXQz?=
 =?utf-8?B?L1pJL1BjREVJS2loRk9vVFJYaWNRbDVYS2RtQ3ZJOWZoYTU3VFJFcmkyQlVq?=
 =?utf-8?B?cWRHcmxNdkc2SFRKNEN5bEsySkJxMTRieHF2Q2t6bnNLUzJHMlRaM0FWY3Zj?=
 =?utf-8?B?RXpIOG90Vm8yVFdpSGxGelM2Wkd5bS94ZWsyelQzZEJOc1dwWkZvdk1vbmxl?=
 =?utf-8?B?VHRxNStGaGFZT0pZTTFmS2RLeGdWemxiRGpJc1lnaUdsRnV5MktONGFVZllT?=
 =?utf-8?B?M1NyZmtjZ3M1VkNucjc3NHhLbWlPMXllckRndllUVVR1MDhudHV5NXVZaDNC?=
 =?utf-8?B?Q3dia29FblBEQ29tOWJxT1kvTXFOZSt0WlVtSG82L1lSZ0lrTG16YTBJSVpT?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43CA0626154AC42B6770ED2DEF87991@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jHjtKJe0NdYBQztWeae5t3eNavSxlJ/R3ANt7OqQzIjvZMHxPKtoC+/zHduNwgGkdYdS/vcWJqaLvAuM/xryaiy7mMpMJ/TO3/13RkrE7a+3pAZb0s4o8UsWeniwSK7rf1Pv43ii+Roz5qqQSvntsBHnYShw59m/PJ9bkKUAGMGYkf2srvqnCd0/HjPhaOtywcymuO1KD4H0HtD9aSOlGJnm60euqRR9tC8OigSwG2DAHkQ2I4A4o4ygxQjjNsBJC3FqUgXPEDNjSn2sTji/qWYfTJ3qREcXEEQWNtleTkZTwHD8MMvEpINFfLLdGcdhqgrOoumcl7m0QW8CyoE+8PNfaE2wx0aGqMSrvVjNk627b+z/td8sV9Ws/qnU9Xn0Gjvp04mScQk2EKKvmvnkv2mNsP86d9xDjfhjshfVmq5V71XC+rAJr4qqlq7TQJI4o4SrO2UqqUl+ONLKPilMaCbRaAjOqPPm0hNQ+7M2CXceiZKRZVdgrunkyk320E5oV/i6aWCNiDOdiEdmiPvmL/gwmZLALoGVJcmtkgeOAim04RCIphEdqLVxtp7J4bfLYTQ18Sw3BXXRwWlAhacw9krWGLZC7d9bfwE0nzUDhgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6374c7-e94b-467d-6eac-08dcd017a93d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 15:05:22.1355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/cDEL9s8/CRrbcVcX9jT3zt1lut+wpzfm7l1U7FdB/+vsxYMdlgqYIWTm1ro034kQ58syqMNzkmF7X7dVyrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_05,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409080127
X-Proofpoint-GUID: xVsPQlVX4XIUZ6i8wwHUK2rTkC4xjBNq
X-Proofpoint-ORIG-GUID: xVsPQlVX4XIUZ6i8wwHUK2rTkC4xjBNq

DQoNCj4gT24gU2VwIDcsIDIwMjQsIGF0IDU6MTLigK9QTSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVj
ay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiANCj4+IE9uIFNlcCA3LCAyMDI0LCBh
dCAzOjA44oCvUE0sIE1pa2UgU25pdHplciA8c25pdHplckBrZXJuZWwub3JnPiB3cm90ZToNCj4+
IA0KPj4gT24gU2F0LCBTZXAgMDcsIDIwMjQgYXQgMDQ6MDk6MzNQTSArMDAwMCwgQ2h1Y2sgTGV2
ZXIgSUlJIHdyb3RlOg0KPj4+IA0KPj4+PiBPbiBTZXAgNywgMjAyNCwgYXQgMTE6MTfigK9BTSwg
TWlrZSBTbml0emVyIDxzbml0emVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4gUmF0
aGVyIHRoYW4gaGF2ZSBnZW5lcmFsIGNvbmNlcm4gZm9yIExPQ0FMSU8gZG9pbmcgc29tZXRoaW5n
IHdyb25nLA0KPj4+PiB3ZSdkIGRvIHdlbGwgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIHByb3BlciB0
ZXN0IGNvdmVyYWdlIGZvciByZXF1aXJlZA0KPj4+PiBzaHV0ZG93biBzZXF1ZW5jZXMgKGNvbXBs
ZXRlbHkgaW5kZXBlbnQgb2YgTE9DQUxJTywgbWF5YmUgdGhhdCBhbHJlYWR5DQo+Pj4+IGV4aXN0
cz8pLg0KPj4+IA0KPj4+IFRoYXQgaXMgb24gdGhlIHRvLWRvIGxpc3QgZm9yIHRoZSBORlNEIGtk
ZXZvcHMgQ0kgaW5mcmFzdHJ1Y3R1cmUsDQo+Pj4gYnV0IHVuZm9ydHVuYXRlbHkgaW1wbGVtZW50
YXRpb24gaGFzIG5vdCBiZWVuIHN0YXJ0ZWQgeWV0Lg0KPj4gDQo+PiBDb3VsZCBiZSBhIGdvb2Qg
cHJvamVjdCBmb3IgbWUgdG8gaGVscCB3aXRoLiAgSSdtIG9uIHRoZSBmZW5jZSBiZXR3ZWVuDQo+
PiBrZGV2b3BzIGFuZCBrdGVzdCwgaWRlYWxseSBJIGNvdWxkIGNvbWUgdXAgd2l0aCBzb21ldGhp
bmcgdGhhdCdkDQo+PiBlYXNpbHkgaG9vayBpbnRvIGJvdGggdGVzdCBoYXJuZXNzZXMuDQo+PiAN
Cj4+IFN1cHBvcnRpbmcgYm90aCB3b3VsZCBiZSBzaW1wbGUgaWYgdGhlIG5ldyB0ZXN0cyB3ZXJl
IGFkZGVkIHRvIGENCj4+IHBvcHVsYXIgdGVzdHN1aXRlIHRoYXQgYm90aCBjYW4gcnVuIChlLmcu
IHhmc3Rlc3RzLCBvciBhbnkgb3RoZXINCj4+IHNlcGFyYXRlIG5mcy9uZnNkIHRlc3RzdWl0ZSB5
b3UgbWF5IGhhdmU/KS4gIE9yIGlzICJORlNEIGtkZXZvcHMgQ0kiDQo+PiBpdHNlbGYgd2hhdCB5
b3VyIHRlc3RzIGJlIGVuZ2luZWVyZWQgd2l0aD8NCj4gDQo+IGtkZXZvcHMgaXMgYSBDSSBmcmFt
ZXdvcms7IHRoZSBpbmRpdmlkdWFsIHRlc3RzIGFyZQ0KPiAid29ya2Zsb3dzIiB0aGF0IHJ1biB1
bmRlciB0aGF0IGZyYW1ld29yay4NCj4gDQo+IFNvdXJjZTogaHR0cHM6Ly9naXRodWIuY29tL2xp
bnV4LWtkZXZvcHMva2Rldm9wcw0KPiANCj4gUmlnaHQgbm93IGtkZXZvcHMgY2FuIHJ1biB0aGVz
ZSB0ZXN0cyAoY3JlYXRlZCBlbHNld2hlcmUpOg0KPiANCj4gLSAoeClmc3Rlc3RzDQo+IC0gdGhl
IGdpdCByZWdyZXNzaW9uIHN1aXRlDQo+IC0gbHRwDQo+IC0gbmZzdGVzdHMgKGZyb20gSm9yZ2Ug
Qm9yZ2UpDQo+IC0gcHluZnMNCj4gDQo+IC4uLiBpbiBhZGRpdGlvbiB0byB0aGUga2VybmVsIHNl
bGYtdGVzdHMsIENYTC1yZWxhdGVkDQo+IHRlc3RzLCBhbmQgYSBzeXN0ZW0gcmVib290IHRlc3Qs
IGFtb25nIG90aGVycy4NCj4gDQo+IFdlIHdpbGwgaGF2ZSB0byBkZXZlbG9wIHNvbWV0aGluZyBm
cm9tIHNjcmF0Y2ggdGhhdCBpcw0KPiBnZWFyZWQgc3BlY2lmaWNhbGx5IHRvd2FyZHMgTkZTRCBv
biBMaW51eC4gUHJvYmFibHkgdGhlDQo+IGNsb3Nlc3QgZml0IGZvciB1bml0LXRlc3RpbmcgYWRt
aW5pc3RyYXRpdmUgY29tbWFuZHMgb24NCj4gTGludXggaXMgbHRwOg0KPiANCj4gU291cmNlOiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cA0KPiBEb2NzOiBodHRwczov
L2xpbnV4LXRlc3QtcHJvamVjdC5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvDQo+IA0KPiBJZiBr
dGVzdCBjYW4gcnVuIGx0cCwgdGhlbiBuZXcgbHRwIHRlc3RzIGNvdWxkIGJlIGluc2VydGVkDQo+
IGVhc2lseSBpbnRvIGJvdGgga2Rldm9wcyBvciBrdGVzdC4NCj4gDQo+IE9yIHRoZSBORlNEIGFk
bWluaXN0cmF0aXZlIHRlc3RzIG1pZ2h0IGJlIGFkZGVkIHRvIHRoZQ0KPiBrZXJuZWwncyBzZWxm
LXRlc3Qgc3VpdGUgb3IgdG8gS3VuaXQ7IHN1Y2ggdGVzdHMgd291bGQNCj4gcmVzaWRlIHVuZGVy
IHRvb2xzLyBpbiB0aGUga2VybmVsIHNvdXJjZSB0cmVlLg0KPiANCj4gQSB0aGlyZCBhbHRlcm5h
dGl2ZSB3b3VsZCBiZSB0byBhZGQgdGhlIHRlc3RzIHRvIHRoZQ0KPiBuZnMtdXRpbHMgcGFja2Fn
ZSwgd2hlcmUgTGludXggTkZTIHVzZXIgc3BhY2UgdG9vbGluZw0KPiBsaXZlcyB0b2RheTsgYnV0
IEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhIGxvdCBvZiB0ZXN0DQo+IGZyYW1ld29yayBpbiB0aGF0
IHBhY2thZ2UgcmlnaHQgbm93Lg0KDQpUTDtEUjogdGhpcyAidG8tZG8iIGl0ZW0gaXMgZmFyIGVu
b3VnaCBkb3duIG9uIHRoZSBsaXN0DQp0aGF0IHdlIGhhdmVuJ3QgYmVndW4gZGlzY3Vzc2luZyBh
IHBsYW4gb2YgYWN0aW9uLg0KDQpBIGdvb2Qgc3RhcnRpbmcgcGxhY2Ugd291bGQgYmUgdG8gcHJv
dG90eXBlIHNvbWUgdGVzdA0KY2FzZXMgYW5kIHRoZW4gd2UgY2FuIHNlZSB3aGVyZSB0aGV5IGZp
dCBpbnRvIHRoZQ0KZWNvc3lzdGVtLiAoT3IsIHBvc3Qgd2hhdCB5b3UgbWlnaHQgYWxyZWFkeSBo
YXZlIG5vdw0KdG8gYmVnaW4gdGhlIGNvbnZlcnNhdGlvbikuDQoNCg0KLS0NCkNodWNrIExldmVy
DQoNCg0K

