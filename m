Return-Path: <linux-fsdevel+bounces-28901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27853970319
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FA51F21128
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB915F3F3;
	Sat,  7 Sep 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FO3wToLe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rLjjouMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765992E634;
	Sat,  7 Sep 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725725386; cv=fail; b=ElZ4abgx5tDVHEUAZ28NM9PvJAe3+fpUS6IQUODh3X+QyXtprtGm6Xmr5CanGalqFruZqH+IBZS3bOWtdeNTucT384y/f90DDPg/qXhe9/dgfIckayMe3PUQBAVlVFdG8JcKBmkdFEwd6V6S0KrtZjDJ01EQ+G2ATc4JcVnbywk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725725386; c=relaxed/simple;
	bh=MLgtJK+vR4bVnXVldA2EP/0ssk93so3tOEjtIMygE4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LxyfKzPHPLh4whm9lwnFFrAWZcJYWR4JMLwnYnS737lTCh+g5yI9wPyXmwTJ7aA7YCTwIlfdc5sEVMJmS4K8E2b+W0RSfZDji6fU2UDaoqRr6hN8LP+y6LDA5aRkN3/UKIJYFZIvbh4aeGvZbCoYReUKzONffsff5MLcQssWbts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FO3wToLe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rLjjouMI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487DYEij003779;
	Sat, 7 Sep 2024 16:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=MLgtJK+vR4bVnXVldA2EP/0ssk93so3tOEjtIMygE
	4A=; b=FO3wToLeeECRm67b44jZlB62Zid2UzOzOTu5tnLAnN9IguEAMQUZQOi/0
	00DeewCSOYH55GUYpTOxoN2u1DqeEm8XrNGaAguxJSQbuxYGQui+5Gab6Ppqfezd
	Y2jffm7geMAspPSX/AtDioT3mjjCg1Go9RK4omA0qSt69kV5OoY0Sm3JTlZ1tbWa
	OzGK8Z3z6MHcASRkUh4MBElMVCKl7DUQ2O6mgFX0JoNFwavIG3y8FpahThyNmkKq
	C1ttb6oFYAmzOf3qCKYcKVGuBk0nM7OeK1cSy6QXlJbhgkHM5W3z1mzc80hk0wkU
	zX8Bk4K//2ZjRhZRM9T9Zk8TBpeQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcgesu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 16:09:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 487BvYYl004967;
	Sat, 7 Sep 2024 16:09:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd95unkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 16:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDHmoJUCg8Res1DPBui2zR3I7iXa3Do+0ei04Rm9IsRc6QdEC8OxVd4XOHXG3Mbo4PLtNtsv51FXAuC7bZ5tqothkaLTLP2gao+QDjMv3NifCpEv/M15bFwN/nmLXMVni17rCoxTZWlU93/xmZwtUkW85cmXZYV3gL9Ct8TTq+S7NZdPXcLz8jZN06ZkElrOfETQHGQ2QPC13DGBNQcVe/plYt5umqn7HBbjdD+6c4Kyq2x5xw/bEeG1w1Y5hZizD7P4+Vr1VOrRGsndqMXRgwlhNiNlTs6A9U0vEc+tlvSQcgqgU/RiuZ0Q5V9gwmlkXjL8mMgOo+HZyHGRgyu7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLgtJK+vR4bVnXVldA2EP/0ssk93so3tOEjtIMygE4A=;
 b=u++7pFc4KOBWuMn8Yzf1ugGgQl92nEplUuyzkN+0bDFMNj2LYwbKQqugg1/L8Q95ycpEaPiRzECARHTLPJDv+XugyZ4VwXypfU77MCXJ3qpWolDwbgW8RXViEE3sScWwNYIhBTxtrwbeHajJUFI97Zw0ochPw55lgO+6gUCK/1HTB21oAIbZJKUS9vAFp0ouA81502C/ibpetdnJVdXqckroWQ/HK9Oesu/NnChFU4XgTdsCZjZOyArUwl42gcgLrv0DpQ0L/2BLHTVPilWHhI+AHZqbm8T15/MvjGzjl25S021QIIf6YjOn3twMWs8W4+wUjbuTnRoEb4RSquOz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLgtJK+vR4bVnXVldA2EP/0ssk93so3tOEjtIMygE4A=;
 b=rLjjouMImnjAlNrmNJP7peSXFYjWPlqaP3+54fE75FnVH1guVs2eCPc0PFrRs8CUgjuCf3857QPCxKlDTbRwx11jwuk4WZMDHg+2UXtuYbCrzHob7Ok06sG9NU93GbfLAuuZCgcAi+u6dlVGiszSRs7SzjA3pzIikeupOuKWhhQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6279.namprd10.prod.outlook.com (2603:10b6:8:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 16:09:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Sat, 7 Sep 2024
 16:09:33 +0000
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
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAbZ+AgABs/QCAAJLIgIABm82AgACaigCAAQPhAIAAMy8AgABAEoCAAAoaAIAAC72AgAEM8ICAAA59AA==
Date: Sat, 7 Sep 2024 16:09:33 +0000
Message-ID: <3862AF9C-0FCA-4B54-A911-8D211090E0B4@oracle.com>
References: <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
 <172566449714.4433.8514131910352531236@noble.neil.brown.name>
 <Ztxui0j8-naLrbhV@kernel.org>
In-Reply-To: <Ztxui0j8-naLrbhV@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6279:EE_
x-ms-office365-filtering-correlation-id: 5ba8f811-26b4-4b89-7dc0-08dccf577694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkU5dTBVUzlxNkNiYkw2ZFBYTUhIODhORG9nSHIrRndBemhka2N1VlR1T01O?=
 =?utf-8?B?clp0VTVXQ0N0a2gxSzErWE42V0VpRXhETXJGNUVkWWg3NjQ3TWM5V0FGNHVa?=
 =?utf-8?B?V2pHdmxrVVhWWHl2cGpjYTJKVi9ZNTdlUnJVNTlBakxLdWc2NGNCQkZzSmY0?=
 =?utf-8?B?VzN6ZU1ZbHVXcmpPQXNpNUNjcFNKUTJsMzFPTUtndGVCbjliVmk1OENBODhv?=
 =?utf-8?B?Q2xoY3MyRVF3YzZlM0VRMVdJLzI1b1hxMmNjVHlNbDRJdExvWmxsSGVta2xW?=
 =?utf-8?B?QXFma2lpTDRYd3lkL3N1Rkpia2RZQWhyTTU2N0UxR1Z2TG5vNmlCc2U2Y1di?=
 =?utf-8?B?OXlVTXR2a0pHUWtIUG1zclNMU3AwMTM5ajhWV041UitHUTRjU3phLzRuS1Rv?=
 =?utf-8?B?aytNbUhxd0VpRnptWVp4ZXVxT3V6UzdlWkpxcUg3TS8wcDdwcnpuTzhsenV0?=
 =?utf-8?B?TEFkWkw3Yi9yQWNyTXBMdVgvbVFhMWxwSFN3SHlmVnpBcFVQMTFSc1lwVWo0?=
 =?utf-8?B?WHE3cC83d3pFRldJcm9hbHJGUjB6dHVmeFp6T2oxajFMdmtJRzdkaWdONGtX?=
 =?utf-8?B?bUZFdW54MHNNUWZJYWtETEo5Tk93ek0zZUhNTWVZelBEb1daNDMya3F0dCt1?=
 =?utf-8?B?TWw3NU8vS0loNVdPN1JrYWx2aWR1QStOWEg3OWdXSnZPTEV5WXBXTld1Q29N?=
 =?utf-8?B?M29TZzZPWTdzeGJETTVQeThSY0tVMEhUOGlQekEzdDVOMXZ1cEtFbHAzVUdy?=
 =?utf-8?B?b0Yxbjc2ZS9JZXM2QWVrMXdkM2ExZWx5K25SNFpjRUtjaHlqbHBuWjQ4RVRJ?=
 =?utf-8?B?STBTK1FhcEE5U2JnT1dNM3cvQ3hqVVREZFoxMWdkMVV4TGNjZFhlK1ppbDNv?=
 =?utf-8?B?Z1ZNMlJLUStCVUNLbm5meFl6UjBXYUlIUDBFcEJhM0JNOVNacnFHRlRLcVll?=
 =?utf-8?B?dG04M2VJUEgvMm1MZlhRSzZrVjlReXlVWW8vcFhXYW1lYnlRZHpzRlVVQjNO?=
 =?utf-8?B?UXhtaEVma0FIOVY0NVpucDRZZkdRcXBvKzFNNjJTbVZRcExjVmpZSkFYcTZn?=
 =?utf-8?B?VzFUNHBhVmNxdWE0VjArNzB1anhvbWV1NW1lVkNaQUZoanVvTlF0Q3lNNEx6?=
 =?utf-8?B?NDhPa1hHUUxUVUFKTDJLUTF4RVJzd1I5SmxCZVE2NHBkZkF5djRIaVNXVVlC?=
 =?utf-8?B?ZHV4Zk9Ba0RpRDRvK2FQWTJjR09XbHcxdGJoZEtTdjE4Tm1PbHg0NzVZb3FS?=
 =?utf-8?B?RDYzdUUrenlQYzFzbDl2emhnL01wWUhOZzZUVWxDcEdKVXZSVzgyMEc2NkJW?=
 =?utf-8?B?YnRGM3FhdkdaUVhVbnJndnJPSnUvS3J1SDFKaDc1NWprdTQ4OHE5UkovdW9N?=
 =?utf-8?B?REVvMmZYUVZ4UGFtME56ai9adjdXek9GbzFpM0c4ank3Y0taMzRqV2paTWhR?=
 =?utf-8?B?aE1DRHJKOXE0WHpiQUMwZ090czJlQVhqUVBmNDBNYWdaOXBQYmQ4QjEwV3Vo?=
 =?utf-8?B?RFpxRFlBTTV3Tm5UeFZVSWh1b0F5Y1VlK1NqekNOK0luQzhmSDdjNEVnN3dD?=
 =?utf-8?B?WDZ3alhtVFM4VTRoTnVqUy9DYjB2QnRFVWd5dDR1RlhUTFQ0Q0I1Tk84dEZX?=
 =?utf-8?B?b2UvTzRTTUc3ZUU1YnB1aXNtVjhZSFgvOVgwaUFHRXU3KzM4NFhBVDFwdEE3?=
 =?utf-8?B?akZQUTE1RlRKcmxSNEVhVzJ6WTJubDlVU2pJT2t1MWVDRUdWZkE4WnByaW91?=
 =?utf-8?B?dFB6eXl3ekVCZ01BKzZrVGk0b0cvMW5pQnNWa09QbUFJNkJPUGxCVG5XTFlz?=
 =?utf-8?B?N2YrUG9hWDM3Y1dHOXBWcmpBNGVCdEJWK0xZdFp6VDdzZTIzSzVxUnNGdEFx?=
 =?utf-8?B?VjBGN2FaQklzdi9mSFlXWlgwRElNTDBjeGh6Z0k3dFlzb2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVJrMWdyTyt1NXVBNDlaZVZoa2R5Z2VDR0hibHJ6TzRhbGU0Mk9PTnpiR3Vm?=
 =?utf-8?B?VmFEVk8rMUZmanQrTDVDdFVOcy85eXFuZ3NGQWZsQ1FTMk4zdnFxLzFrWCth?=
 =?utf-8?B?VVBPN25wek1LNCtFSzExRkxLMHRYOFBheURnbVgwc3E2TEQvZVJkKzZFUmZ6?=
 =?utf-8?B?akVTSWdmM1Z2Rm54bjg4ekNDYkhIemVlOHNyeDZyQnAweUtuWTVhYXFtbDJ1?=
 =?utf-8?B?dTBUd1NPL3hBbkY5R08ySnZXSmhZY0hEOURQeE82OUptV1orTGt6RERvbEln?=
 =?utf-8?B?bUhMcjVoMW1SRnp1MWl1OFlZZzVNVVlVMUlJajVUZTY3TDVyNU9JSW95ejgv?=
 =?utf-8?B?VlJyQ2JEbThMUFdjOEFMSUZjYmdvcmFMRWdBVENxZDh0amYvYnlSbytDbG9t?=
 =?utf-8?B?YmVEZ00xajZMRk9xQnlaUTdnR0h3cFBDY2FrMk80b1lGL3VUaFdFTFZYMEVr?=
 =?utf-8?B?dWdQY2FhSnphTm9nNXZyWWZUcytPTVpXZk01MWNBMDEwOFdkcDM1VkVqYUU1?=
 =?utf-8?B?RkhIckR1RTJiMG8vQkJSenhZdFYwcEM1My9pNHBBZG9oYmRPUVN5TlhHeWlu?=
 =?utf-8?B?TXZ3WXl5L1djaC9VVHNhR0N6YXpoNUpJZWhZNzVOVTBPRGFBYll4NmppUmUw?=
 =?utf-8?B?aGdFdjB5WnRnWlhuTzcwNDRaeVc0T0wrQzdOVE54QzlRRElvYXNIdEJlMzRM?=
 =?utf-8?B?SU95dzZFZ2sxUGYxR1lGdkQwb3VrVHZ3RUFaYTlSUWlqNlBEQ0FyWVRJKzJW?=
 =?utf-8?B?bUdPRjZ1bWhJb0FxYTJUdWo2alRUa0NJM2FzbWVsOE0rWDBSa2VnS3dvNVpl?=
 =?utf-8?B?ZUN1K2U3VXgxb3NDS3o2NmErRU4vb1pFU253ZXUyUjZ6cXFYK2FyYVhPN2cw?=
 =?utf-8?B?YldXWVA2Z3NLUmJSM1VzdEk1L1FuQzFSZysrb1RxRTVyeXBsN2Z5MmhTbEd5?=
 =?utf-8?B?YjExUTNvZ05CMklmYkFXbW5XOW5jaUJnWVJvR0NwalR0SjRtalRhRitUSzlk?=
 =?utf-8?B?dytnWjBZeEJpM1M0L0FGQ040Q0Y4eFBuTFJ1TlJNUWJpV0s1SlRNR0hRN1Jv?=
 =?utf-8?B?cjk1NW1JQUV0eXhrZ21LZmhZZEFpdDNBYUQ0ZTlPZitxMFdPUUM2LytZVHMv?=
 =?utf-8?B?VUh1ZTdQVUFqMmdnaGdWOERlUG9mdS84MEM3TmpIUDdJMlRkWlhzU1BMUjZG?=
 =?utf-8?B?YjNhREx3cHJCblJMQzJYWlVYNlFmcWVVOEM3TmlkeEFuQkl0RXhqZ1RyMlJV?=
 =?utf-8?B?TjIxRXdBRDEwdXVqVGlZSFVvb1FhT1p4NW1xalhzUldJQjFWaHRMQkpUOE9l?=
 =?utf-8?B?UnJGVWdwVDZTMTJSOG0vN2hLOGQxblhUUWcvVlFCd0w2UGhoOTB2cnpFUEoy?=
 =?utf-8?B?Y0YxUUVYdW1aaFppb0gzK0gxNy9ndG1uYUlOQVZMRm83aDVnTGFiaEt0NDlK?=
 =?utf-8?B?SllkYkpXRE4ydlRsajduYUh5OGZBQVZiYnJsS2N6UE5LTkNVeFFOY3Zvbnpz?=
 =?utf-8?B?WmhHaWM0VGpVYzZTMmhUN3h0ZkJ4U0VlUUM2V0tjOUI2QW5wR3gzd0lJaUJm?=
 =?utf-8?B?K2NNMGJyeURWUWIxUklGbU43VkEvd3hjTkZpSVdnVTZsMG8rZTREaWpSSzBm?=
 =?utf-8?B?bENzRHcrTTlIZ25ZVFh4bHhvMi9rRjlCWVFIRTVLTzY0RlpRdzhSMDFlMmF4?=
 =?utf-8?B?UHFSM3pod3hIQXR4RVdZMzZJaTI2aXdraFYxb2twY2dRN0JXUDZXd05BWjRR?=
 =?utf-8?B?aGZpakxsekRmNDFCNGpqd0ZlMzBrRHdJNFJRR01vS0Fxb2hoUTFMcnF0bno0?=
 =?utf-8?B?dmpUcTlRUmdQRUVzdHpTNzFWNlprQTRNUVJIZjZSZTZ3NzhHQjdlc1hWWlBk?=
 =?utf-8?B?cDM5N3M2RHJBMjBONVNGNXdsLzFqcVQyMmNvenMrMWh4TktFZXNMNHprbEl1?=
 =?utf-8?B?L3RPSjgvNTBGN2hUVUhPa1JtKytlQmF6ZENkeVl1WURIZHpneWxYMlBWM2NO?=
 =?utf-8?B?am1OQmZ5MnNaQmUrUVRqUENCbTNnTTl0b0dqNkp2aTZHWnQzQVpHSnFRR3pj?=
 =?utf-8?B?OGt2U05tMDMzNEVGT1hyd3kzUkMzMU5YT043WmRrZWVLditDRksrdGMxNXBq?=
 =?utf-8?B?YlYxSWF5UlpZMllodlZoMTZrSDRPMWI0eHMvTTZKcjBaM041WGFoOGxOQXI4?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD03270B5DE2804D894EEEB18C4F1241@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FN5+ld382+5s6QJ2D7ogd8Sb2HOKNQkIAfr+E6U8PTJ1ktFbi9+Yd5XGkYjmJzzPWuf0w2783bJU4RaxLVi13Y8gvQH7n/9JZFy6C4Y2Hmm4Slkn4ufytWWYGrUJBEJDF7iRmAaD4xqprWAguWYxabpsdM++Ut7FN5jj6Xt7v/93Fqb77A2J/3X8c79SojAAgUC23FJn5v8gxZdmMqDiZLnmb2hJYdOApZGs/LPedWmEN2+lH//fUkilj+Ah5sG6qnPjka0YX109NpV+UcoarseCmqmmrEOeM1JiAtbJaaxIfSHY3k7UUx0w6k6C+eMdpSQMVCRJdNQS0U9LF8EImdL7kMvapZYDyRqEo1rNXFEiRuTUqDw1zPl6wk5fiq3RBj09RzaqUqo2KQDd2Q8mYyEEt2ONLy/7sceCdPM18F4X8nVZ0/FlPT4lId2ZYUV3mYzWD6/Ru7ONsSriP6utn5PF1EscRN4mBsjFhsJ5HKA/BQ673qVYJsAAtrkLos/gt+DIEbV+KniFFaqvB65MZRgTd6xqgmjhmQx1OuQEafWOFDKfKEVwfM68qI8U8CSAAa1ofQ9nRLrtoYCT9hhMlz0xXebCrWkF7UBWqNYDpWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba8f811-26b4-4b89-7dc0-08dccf577694
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 16:09:33.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPz9nDM/FdsilEDjnKUzCK7LoxhW22amg1fK5DeUoAfkSl2Q0qGY4pb0V0YPSisABr7vetsV7kM30DNVfyQd8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_07,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=812 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070133
X-Proofpoint-ORIG-GUID: EzUi31S6ko7GJcKRR63rKUcoYq2GSP9k
X-Proofpoint-GUID: EzUi31S6ko7GJcKRR63rKUcoYq2GSP9k

DQo+IE9uIFNlcCA3LCAyMDI0LCBhdCAxMToxN+KAr0FNLCBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBSYXRoZXIgdGhhbiBoYXZlIGdlbmVyYWwgY29uY2Vy
biBmb3IgTE9DQUxJTyBkb2luZyBzb21ldGhpbmcgd3JvbmcsDQo+IHdlJ2QgZG8gd2VsbCB0byBt
YWtlIHN1cmUgdGhlcmUgaXMgcHJvcGVyIHRlc3QgY292ZXJhZ2UgZm9yIHJlcXVpcmVkDQo+IHNo
dXRkb3duIHNlcXVlbmNlcyAoY29tcGxldGVseSBpbmRlcGVudCBvZiBMT0NBTElPLCBtYXliZSB0
aGF0IGFscmVhZHkNCj4gZXhpc3RzPykuDQoNClRoYXQgaXMgb24gdGhlIHRvLWRvIGxpc3QgZm9y
IHRoZSBORlNEIGtkZXZvcHMgQ0kgaW5mcmFzdHJ1Y3R1cmUsDQpidXQgdW5mb3J0dW5hdGVseSBp
bXBsZW1lbnRhdGlvbiBoYXMgbm90IGJlZW4gc3RhcnRlZCB5ZXQuDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

