Return-Path: <linux-fsdevel+bounces-74914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIBLN1M9cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:55:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0D5DAA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3107C0DA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6D3D6488;
	Wed, 21 Jan 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHrr4j5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EB39E17E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026289; cv=fail; b=g8OISSyCxQVblIh8jCqm4E12SA2ezEyuqoX8H7HJ0alkZfNcSCtRRkIDzqvJJ0uCr/Vl/EGGV9XlDotY+LzCotIABVJwGjmf+kdi58N79+ngo3FUde0nz9kW3eRQPlC8JF1l4aCvy3W1zzNSq74BPYPDgHpeNFcvxTYbBtgVqqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026289; c=relaxed/simple;
	bh=qIoFLcl/dflOx+5ggJ0hl0ptzocv+CI3LhYel21U3L0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=d26Uv5NLCV2M7S0/0aGO16+nTSr4R3u6Yf+d+Ie/Pp+nXwZa+/nL4Dha1GZXbROvzyZBD4ZCc84LEojem2Nw8GRW+hsFwiCpxAN9xOrIsp8MDcwOvpKQkSRl9xj9ps54u1/QS9s52MnMCnWoDGYeoKXMNXMCiGyLi2EaTQKRWrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHrr4j5K; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LDJ56E007267
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=kpbj9a5V4lyVyVl7YLRns5pKakFgq26Ccu4yBQeXBFg=; b=hHrr4j5K
	vJkD+d6doS4+3haGp+gqlEklz7gQw8PiQFh7NXN+JWYZ3oyks8+XOkgJvEjA+hC+
	HAMxwG6t937E53gawWy2OXdjypLQUleFGmRC9LL6hhRvInaX/lYD+XsHLLPtB600
	iQVIeW9amOUSMzE7f76M2FYDJKuerbRhx755qsKQPsdSlV7kqfGfHAE7sCeL0FXj
	QvlwhYzgCPvtNzLXQ508wPqR97dJ/KQPLSs6I8so/dZKGwKhXnmLDItuX3P0uqif
	u0S9Vsdf4j1t28sDF/PHQCdmYl6h8nzmtfWvwSh4QJEthl9Kxo18Ozxy6ddgbYxn
	9bv2B0x48Q4TLg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6cud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:11:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LK865c015865
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:11:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6cu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:11:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LK79W4013149;
	Wed, 21 Jan 2026 20:11:24 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6cu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:11:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5oSbTAkgEKziITfoRafdZ/zmYiWDGxRA+3yssuzJytKjwkVw9IyK8z2D8N9eDrHCRDRUCtcZuiX91jjZvoOn59JXgsIroTPclngYYZHT64M5eU6Gboa35X9Tk9H+zlsTHok/jz62hT9cJ8/CWFtgBr23RcAwA+dvWL1ca2fIizS2r5zISvIuEnXgm/LioPBvbCwxF9mcLCTLes2h2PZyNG8lyoNLx3i+2VVjxozD2WOKe5xLTXiLsV8/FG6knFH3msJ/dkR9NpoWxDd3wAxyrDBGysz3cGN+9K3hAV8amiWg6BIApTFngAlUKJZDOFanw36GGNNLADq1AluFKbOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS7PEf88/t+WwqwRmIFxdS13lcCS/kdbhi3Nmfns5+Q=;
 b=Bz6R1XwoAMGrS1urDyjfrjUAT03l5hf9BRDGD3wqckkmQtkfCpnRJvFZxKBV3EfEy3dM7IW5tE4YyuzJh4nQxT+8IxfH7WtZGstdDtQj+YZnmU7HJ0c6OFaJVSbI39AGG+7853fKJLjoxAJBLtSFS540UgW4BtdhMUAWCluspBWEwP1hwp7nzL9k+T3dWGb3il+ouwuZM9mJz4h+u3NOJXvTnXEQh8dAWIlIjLGxwh6+jcjTYIGgO/Ypgl97ZFkBggp37KjOnikkzSHHhX+ZstQ9wFzpyKHMRzbqqRFKFpgXywQMuzrDdZWvCXT74rH+xM8O2afS52Vecb3sSkZUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB5795.namprd15.prod.outlook.com (2603:10b6:806:32e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:11:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Wed, 21 Jan 2026
 20:11:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index: AQHcip7gBQv9tICp4U+VJX3elcUj9bVdDvkA
Date: Wed, 21 Jan 2026 20:11:21 +0000
Message-ID: <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
References: <20260120051114.1281285-1-kartikey406@gmail.com>
		 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
	 <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
In-Reply-To:
 <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB5795:EE_
x-ms-office365-filtering-correlation-id: 0f03aac1-c17c-4212-5b4d-08de59293efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2tkRkROQ1R0UFJzVjJobnZ3dXQ2ZXUxaXYxU1JIaFplUFRUd29TdWJwc0tO?=
 =?utf-8?B?cVIzekhnNmtBV3Yybm83ak1tczVCeTdGaW0wVVFBYzl4VHRRYkpubS9lb3VI?=
 =?utf-8?B?RjNHM0J3YUhWdkNUQlN0S1M2cEZPZVExQjJTN0JpT2dXb0d5dUZKZS82WUl6?=
 =?utf-8?B?akVaNmVFSlFqYnIrVjdzZU45OEUxc1F4OTY5R0hteGZvNWU5UGdJWVhUdDZh?=
 =?utf-8?B?RzMyV055WlhlQk9jUTBWRzVna21hNmdzVlZOMG4rZFp4amtjSHlSUXUyUDl5?=
 =?utf-8?B?ZE5ZcWRHWmNHaFVkeFJ3N09OeW1OUWRlT2RBeVhwSzdxUXJqZmZvYk9BWnZK?=
 =?utf-8?B?YTFxN3U3UzdOVmxtb3d1anFTbWsxaE9PNWZJb0NXY09NdjlPTDFIaERjdnZ0?=
 =?utf-8?B?S0lyUDVHOHkzSFJIaHYxY0k5cFFaUlYxZ2xyMSthaTduc3d4K2lVS0FQZVR0?=
 =?utf-8?B?cHE5REZzc045WWdGS0hlUCt3eGJqWmNyKzR0ZDIrTGh0S3c3M0l2SmZoYkRM?=
 =?utf-8?B?azl5VjRDOFJ2UTAvVEpydWc1QUExSUNrODhKRkkyUlJodGRtK21FMmlxc0hs?=
 =?utf-8?B?YVdLNHBrR3ludWZkRHdTRUl3VzljM3lXZU56MWpVUm1VbGxENmRvSElaQWNV?=
 =?utf-8?B?NHdrdk1yR0NxWGxsRnJyZm1sdzFHL0ErRExXdVk5Y3lOQU9FVW5tbjJSbG4r?=
 =?utf-8?B?aGs5WXFSMGp0K0NrdFFEanRUYjRjam9zbEVkbEhFY0tQdVJaa2lnSDh1RXRV?=
 =?utf-8?B?T2FJdDhzWi9paFE5UnNvbGhua1hsZXRleTYraDZBcmNXbkJZR3czNFlDcjdP?=
 =?utf-8?B?dEdZbzR0WXZKTklYNlJlUUlpODBoKzlPOEJFUzVhNERjTDRDSUUwOTMzc1FS?=
 =?utf-8?B?b1ZLODQ4eFFLcGdzOHRlei9uMDhDWlJTM2dPQkY4dlRrb2NjdjNnMlFCN0R2?=
 =?utf-8?B?Ykk4NzZibnJQeGNIdEpOSG5xa2FiSktBSHZjdUhBRTFYU2JBTjNiVlZvVkFT?=
 =?utf-8?B?ZWxKM2trbndTQ1Z5TUJRNGRaQnFQQ2ZZS1N4bTk2Z3p1VVJiOTl0a0tIOEFB?=
 =?utf-8?B?QkJXTWg2N09qNGI5UHZuV05IbWdWMWoydEQyM2ZBeVNLYnhFUFB3Rk1ObUhP?=
 =?utf-8?B?NDhnaHdzL0FDc2pVWTNLUHhBMXhPSm1YTVplbnVsa0k2WWtacXdiM2ZwTTJz?=
 =?utf-8?B?cFRrNWZ4T1ZzV2ZvNUN4MlMyVFFMMllFWnI1MzBBc3M5NGE5Q3JqOGxQMjIz?=
 =?utf-8?B?bHZnRDY3MUpOM2Q3NjNueVZMRForRHFKeG0zaHZ5QUYrcjhDVGR6enBBd0JS?=
 =?utf-8?B?N0lxMGNyMm00NkxLTk4wcDZSYnUwcUNuVHJ0T2xGUGtIRU03NXFJa0ltblFz?=
 =?utf-8?B?M1hUUFU0bzF4emFKQ2M5bDNkVWZibUZWQTgyRTMwUENLYjJmZHJjZHN2enBk?=
 =?utf-8?B?QUpvN0E5U2hPc0ZSNVVYNlViN1cxczdVcTNDZzREcDN4cWNvcFZVMFp5Z3hs?=
 =?utf-8?B?TnZyMG43VmFMbDZDdEI1NVJkMTJpQUh1ZGx6TW5zaFhkdnpHSGFZcTlmM1VV?=
 =?utf-8?B?MTFQSlNRT2NEeEJnVGxjbzVQOE1vWTk4empvUjdsdlBDME1wd0RCaFVqVEps?=
 =?utf-8?B?Qit1TSt0ZTRYQU5saVZ0eWZVbjR6U2hoanpQUHVxVXpuK3VVYlpMRzBUYlla?=
 =?utf-8?B?VlRIelBqZEpIZlJ6Z3BLSDJIZHdWNHVId3BUeFJQa0prUDJXUGlzZ05qRkRx?=
 =?utf-8?B?YWR0KzEzaGJZN1dSd1NpVm01a1QvTEtzUVJKTXFjbEFCTUFsbDBCWXpobWhG?=
 =?utf-8?B?MDlqbW8wdXVYSUhhcHU2bnZ4VnZ2Y01XcVNHbVJSNWRvazAyYW95ZGMvS3lW?=
 =?utf-8?B?ZHpDaG9Oek9UeG8zS1BJNHlpOXE1enY4cmpac0hKMFhIQnpNbkVLWmdaTDll?=
 =?utf-8?B?N21UdlFwVWV5RjZ3a3MzdmhLUmREQ04yd3dFNUtwS1JVN0l4dkxTWlZ3bjVW?=
 =?utf-8?B?c3luZUc1c0RyOXBqcDNSa3NUVUVXcUR0S0ZybUNUNnhNNU0za0RYc1ZmNW1X?=
 =?utf-8?B?dkdtcEFrcnFObk9UUDhpcXFUMDlxQ1lURzYzMkhRT25zUXhXVDR0NWFCOHlM?=
 =?utf-8?Q?aOiOT3mATBxdRynPXrW9mTkJs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3A2Zm5wcGhFV1VVdGdNMjBuRm4rdm1SNmpyN0tDRER4ZzArYmRJL2wvZTBM?=
 =?utf-8?B?V3hjZys0K3JWVDJzeXMxS2doVmJZVEpRNmtkYVkrc2xJRUtrc0xualpydUps?=
 =?utf-8?B?L3pXbXFTUk1JNzh3L1RiTW9nTTUrcExBaEM2VG53bVpNYXhGc2VCT241K1hL?=
 =?utf-8?B?eUQ0NWJiT1V6d0w2Z2p4K1ZXQzBVSVJ5a3RXSWQ5Q3JjSjlLdm4reGh3MzNp?=
 =?utf-8?B?ZTVNa3dqZlphclA2N2IvOW52R2crd1dnbm1tYTNWejhBN3lOUEljQnVZeTI1?=
 =?utf-8?B?ZU5tYVU3aEFLRDU2d1NucTZMOTJDZ1VMMmNkblJEeUVaZU13L01oMEthTDlE?=
 =?utf-8?B?SGw2VytGY0J0bVJDd3A5RzlUZ1FrdUtDaEMwM2VVd2cvcHZrYWF5eVBkS2dD?=
 =?utf-8?B?WHVFRS85eW9TV0ZrbmtobzRwODQ0K1dMVnNvaHJ4Q3NQaEtYMjNiRXBiV1kv?=
 =?utf-8?B?MW80MklEdEgyMm9EOWxVS3lyN2hVSU9Md1V1a0lTUFdYS3RjUVZGdHRpRk5U?=
 =?utf-8?B?YW1ab1czMGFrbkh5NmdOM1hGbWpKY1pnaVd3NWZ4TlJBQ2VLSTdxS1VxWC9M?=
 =?utf-8?B?OTc4WWdmMXE2bzdhYXJxVHA3SitQSGxra24xM0kwdEZ4c0g3OVVYd1RsOU0y?=
 =?utf-8?B?OXRCZGEydk05RUxtOW92YmtZdStNcVRmY3Z3TW8rdnZabW5iSTI0TVlBemgz?=
 =?utf-8?B?U0RNZm9Obm5vdVkzbXhBR3hwWGVISnBjVW9KY1VTRUIzdE1jWFdqalR1aEtp?=
 =?utf-8?B?bEpvanhKdVZCayszZzRITHdrM0U1ZkthUWZwZGtvVGRhUW5IQ2tIMUdUWUxR?=
 =?utf-8?B?UkcxNXVvdkNJT2dMcC9LSDJYVkVHTTBFM01Zd29hSmpZdnpmY0JCOVdnQWJF?=
 =?utf-8?B?WVpiZlFMWnhTMmlJdGRVQm9zNnVkMmFSMlMyRGxTdnp4RzU4S25rNzgxbGlv?=
 =?utf-8?B?L0dtUll6cGVmMDQzQm5ESHRncTB4S3ltRHpoNWF1cWxtWlZ3aFdEN0JUT1Zj?=
 =?utf-8?B?SVArRjJmNnNhdE4vd2dwbFdvVnJUaGJ4YlF2TzlUTDRDWjZtS2FWWjMxTWUv?=
 =?utf-8?B?R2dqdll5UlRxU2Z0SzFJQ0dza0tjVkNjVEJaTnZja1F4NW1KR3NHRmV4NVp5?=
 =?utf-8?B?QjFjNmtkQ25qdnBlTmRzU2ZVcWtxSklCQzg3TEpSc2x2cGkzOHF4K1BERCtk?=
 =?utf-8?B?YUZPUEhLVUN6SkhrbThSdk0rUFhJa3FMMjRjSWI5d3cxU2ZSZDRCODFkYjBo?=
 =?utf-8?B?ekxCM3lWWjdoNW0xb0VVRE8rNGFDb1REbm9PTWR0NVVZaW0rVHNkUjNxTFh6?=
 =?utf-8?B?TklkQ0NFcTM0ckpkbHkvQ05aMVczVVF0U2w5YWZLLzJabnRQZEtKWnhWZUxD?=
 =?utf-8?B?OE1KU0tpNDhOV2VmUlVhRGtWcUU1L0czZkJJcS92ckZtejZ1SGI1QisxK3JR?=
 =?utf-8?B?M053akJRcUNYcks2UFRVZksrZkZRTXVOZGJtT2lselRGVG9GcWw5eHYwYVcr?=
 =?utf-8?B?OGprWG1RMDdObjdweHJzblRqdFM2U1lRQmVxaUJNL0NOYS9LTVVPL25YS2Qz?=
 =?utf-8?B?Z3ZJUURLMlZueEFLeEwvZGFoN1l0TXdTUXhWLy9oRmxLT0dubHd5QVpMK2ZG?=
 =?utf-8?B?TGs3cEN0WEhrN1BWbG5lTmY0VDFacy9uU292MWpMWUJNOUQ4cDErVWI4TmdR?=
 =?utf-8?B?LzB1NzhYak9FclowRkw0WndCNGU2b1VMZnVDcVNNNEVxZHh3QUJDb2FieXdN?=
 =?utf-8?B?Qm1ldzU3aU00ajZUMXlrd2hvSGxPSTN2OFNRQXkvbUwrYzBpS3VhQ2tSWkxh?=
 =?utf-8?B?TXBCQ3RjL3ZFYU9XY0JqV1FJZERtazdQb08ybWpNbkRIZExTcytlVThLUnlK?=
 =?utf-8?B?aENsMVVuZW5TZnE3a3Bua01kT3hBRHQ3Q2gxcm5mcnBxMFdhUG04ellWaVlq?=
 =?utf-8?B?a3Z3NmhxMFErVlcyWEhDWDg5UXZHb1dZQnRhZUwvK2EyeG9PeEwvc1YwU2Fs?=
 =?utf-8?B?SHp3RjVNSkc5WGdoTXFQeE4xTk80WWdCTmVMcjcxZjZBV2Y4YkZyeHQzRWtm?=
 =?utf-8?B?MTl3OFdxVEl4bDh5QklQYUN5ajJST2w3QW1tbWVaRFUwK3BsdzhMVE85bVVk?=
 =?utf-8?B?cm1jTVdRa3JsMVc4MitJUk9kN1F4bjVhamh2aUhJSTViaDhQTFEwK1dXQ2Vx?=
 =?utf-8?B?c0FNbDBuQW8zV0x4VUoyMzg0RWdCQ2xndFdad1hyMWtCMmNDZjlENGNxTEs1?=
 =?utf-8?B?UjhsZ1IzakJUeHJQUmtKTmdrTVRpZVd3RFp0MTNMSlNKbEFhOENLaUhsdHV5?=
 =?utf-8?B?RkpNSEo2OEd5ekdiemNMNlR3SXpIZHFvSjRwakVjMGV4VEw5ZWZON1U4RkVu?=
 =?utf-8?Q?mxUqPWmTxwU2cGZjLtKIFe7YQHjFHq9sM6zic?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f03aac1-c17c-4212-5b4d-08de59293efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 20:11:21.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xy5ZwiW4mpcDmsGxrspx9y6C2b7gsH85pHsqWUJt1V1oBmaJk4TV6Os9MVZLASSiZMkWQUOX2+rsgw8gyLPD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5795
X-Proofpoint-GUID: UwZmbeIAD2C0CIEvFsMqlqWFaZ1uzTrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE2NSBTYWx0ZWRfX61fKjuOdit7R
 hbuTWSMZjnWSi76JXPfam+Y3ap2aOsay5tonh3GpTYhP3DE1sxXLmNTitiYpJyUWGMiNGXorSPC
 6MhM6WjH9P30X2EPz2KMVFGrfbd1v04cP4EkhbQAIHxEhKrJQikIzvI2kICaOfkT1y/+CLYYFWn
 cF/IRHW8w5+EETy/IUmf5YoSVvYL+B+dMoh8BkJ3nHKnhDSqjZtjZVDv5+bECc4eCp4/Vhplk3y
 9B+LMyvyf/kUSUkWQ0X/sXhVrk69cMniPtNDOAiI8WbUXhZOOWsgs0mawan7ZmWH7QXSpkM+/ig
 JXkXBJkp95ZNooYskxe4ZhIHWvo5f5A3fopySF2YZU/JJdYmESgMh+6SGNFMV/3KHMZfG3u8rns
 FDH0s/ySYknFyGaMyv3zm2r+MvBlzMrzMr88kM7Zc3QxaQ+he8oz9+ZqqNJK8M4UW2Wm8cQZJS5
 nqZ3qffV4KGPO2Y+E5g==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=697132ed cx=c_pps
 a=ETG1guYRlgXENsW4hp29Cg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=5U_RHfAHcWzFRUdZqqkA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: nnmm_PBIobJAevtgM2ZhCO6-FKhym5Xf
Content-Type: text/plain; charset="utf-8"
Content-ID: <910718ACE3D0314D9FD2CF7871640EF5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2601150000 definitions=main-2601210165
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74914-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,reject];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,syzkaller.appspot.com:url,bootlin.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4AD0D5DAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-01-21 at 11:56 +0530, Deepanshu Kartikey wrote:
> On Wed, Jan 21, 2026 at 3:59=E2=80=AFAM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
>=20
> > Frankly speaking, I don't quite follow what is wrong with current logic=
 from
> > your explanation. Only, struct hfsplus_cat_thread contains nodeName str=
ing. And
> > hfsplus_strcasecmp() can try to compare some strings only for Catalog t=
hread
> > type. But hfs_brec_read() should read namely only this type of Catalog =
File
> > record. So, I cannot imagine how likewise issue could happen. Could you=
 explain
> > the issue more clearly? How uninitiliazed nodeName strings can be used =
for
> > comparison? How does it happened? Because, struct hfsplus_cat_thread is=
 the
> > biggest item in hfsplus_cat_entry union. The struct hfsplus_cat_file an=
d struct
> > hfsplus_cat_folder don't contain any strings and strings cannot be used=
 for
> > comparison in these structures case. But struct hfsplus_cat_thread shou=
ld be
> > read completely with the string.
>=20
> Hi Slava,
>=20
> Thank you for the review.
>=20
> Regarding your question about how uninitialized data is used: You're corr=
ect
> that in normal operation, hfs_brec_read() should fully read the catalog
> thread record. However, the KMSAN report from syzbot shows that uninitial=
ized
> data is being accessed.
>=20
> Looking at the code flow and the KMSAN stack trace:
> 1. tmp is declared on the stack without initialization in hfsplus_find_ca=
t()
> 2. hfs_brec_read() is called to fill it from disk
> 3. With a corrupted/malformed filesystem image (which syzbot fuzzes),
>    hfs_brec_read() may read partial or invalid data
> 4. The tmp.thread.nodeName.unicode array may not be fully populated
> 5. hfsplus_cat_build_key_uni() copies from this array based on nodeName.l=
ength
> 6. hfsplus_strcasecmp() then reads these bytes and passes them to case_fo=
ld()
> 7. case_fold() uses the value as an array index: hfsplus_case_fold_table[=
c >> 8]
> 8. KMSAN detects this uninitialized value being used as an array index
>=20

I would like to see this explanation for concrete particular example. We ha=
ve
this as thread record in Catalog tree [1,2]:

struct hfsplus_unistr {
	__be16 length;
	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
} __packed;

struct hfsplus_cat_thread {
	__be16 type;
	s16 reserved;
	hfsplus_cnid parentID;
	struct hfsplus_unistr nodeName;
} __packed;

So, If hfs_brec_read() reads the hfsplus_cat_thread, the it reads the whole
hfsplus_unistr object that contains as string as length. Even if filesystem
image is corrupted, then, anyway, we have some hfsplus_unistr blob in the b=
-tree
node. If you talk about "hfs_brec_read() may read partial or invalid data",=
 then
what do you mean here? Do you mean that length is incorrect or string conta=
ins
"garbage". My misunderstanding here if hfs_brec_read() reads the
hfsplus_cat_thread from the node, then it reads the whole hfsplus_unistr bl=
ob.
Then, how can we "read partial or invalid data"? I don't quite follow what =
is
wrong here.

My worry is that by this initialization we can hide but not fix the real is=
sue.
So, I would like to see the complete picture here.

Thanks,
Slava.

> The KMSAN report explicitly shows the uninit-value originates from the
> uninitialized tmp variable and propagates through the code path. The
> initialization ensures that even with corrupted filesystem images, we use
> zeros instead of random stack data.
>=20
> Syzbot has confirmed that the fix resolves the issue:
> https://syzkaller.appspot.com/bug?extid=3Dd80abb5b890d39261e72 =20
>=20
> I will update the patch to use =3D {0} initialization as you suggested.
>=20
> Thanks,
> Deepanshu

[1]
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_common.=
h#L571
[2]
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_common.=
h#L155

