Return-Path: <linux-fsdevel+bounces-67967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267EBC4ED64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600D418C1724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34932FFFA4;
	Tue, 11 Nov 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtKsVABV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dB1qQAkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D136A011;
	Tue, 11 Nov 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875931; cv=fail; b=dafon0pumUOw8bzgk8WMtmIEqfrJm/4iy02vPfz3SbhP148qHZGm7u9NZGgjnBhORYeHMJxl6cqxiUbZ29IjnAVJHqqBNfBdY/Xo0hbkfcPdNqghSL00OUBowuBi/360wjj+hrQiOHvHTF5SH/58gT4KN1IEJAMlB8yYY0U5M5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875931; c=relaxed/simple;
	bh=eLuehc5snz0Zi1+L72Ln9sSYZ0DsC26ODPFIkXYRyJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+YUU91uC/AXdryR1LrgqK7UYRwgWM/07Z6fNR5sTs4JB+thaTXUxwLCAj4TB2iAVMwa7RIDqPtJZFCuzge7I4z4F/mVQ+uxnxxp0SKiRjK+I1kdQkpUFUqXZyn1XJCceL5Idy7BvFM+KMFLF5c49l23xet0MBS+xKz3AqRLLo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtKsVABV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dB1qQAkq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABFNUiK029860;
	Tue, 11 Nov 2025 15:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J9PsgQ/xQsOyAu/ud0y56gleSXLEmTqKJ0Czf48ZKWo=; b=
	WtKsVABV6Np6NS5bAKDbqQpHbqpyGtqKwhVfhiOYWSR93/IVqdY9wvKCuqaUiszu
	6iuM3JFGgGDJntq2hqidtTRD6xIKwNiDqky9tcgHMt6dx4COze1ND65JNqkbJ0a/
	+0ModnpEp/gPTA+8Cg/j8HG/RpG4MrC4HPjbV/yY0syQyP3sLKPdwGH6I+loMtlF
	NCUFh06E45Y0tcfif5KrwDNN9c28pYhPXG7x7EtE343QU3onojn1sMwoWzC7oRaQ
	XPVn+34Jr/9tkjB8Wrq+xfRbFNHbMlDuGzG4VxXvnUha1GnqqKEe2oEnluh3vIEu
	13nxjj0cHPEHzZPLy1ywvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac500rd7u-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:45:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABES8rF040109;
	Tue, 11 Nov 2025 15:24:34 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va9n947-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3JwAsD63YhKmUa3sCAJwZ7+UjgjF44E+bAod2cQQNnFKkFC0ACIzxgWKdHf+2eDABpzjdLrHHjgBKEw+uTc/JBYjokeiWt4YL+gKbrayQxFiNlssH/FV0LewQIbcDEgrqm8yUzZf8VZGV+gIq3vXPpIY87UqjOhWgFfZimcPIZeRupPiuigpdtYPJBmFHkDw/HHQISnWDOG2wYlq99qiDssxYGwWA/PlgwJgQKOQmxvZ8910v/HI6GROvs46q76l8Y2PLJkAVrwrPC7Yb7BdP0n/mMKtAgPT1Uu8Q1dlic/tFB4pb4mIKMvnKkD552/00gwG/6L+6lgwrEEZ0R9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9PsgQ/xQsOyAu/ud0y56gleSXLEmTqKJ0Czf48ZKWo=;
 b=h6FUjcyi25f0Nae2jDKUFaNsToODB9u7UXL9o+FCNlDIV7rgr6i+DACZe9E15UBSmRLr6UIualBLXJmwqfI/TDmGEUB14a/Trj/skb8RTwr+DQDx0LZojwtyAGseGdG/3H5QsKQuzgoYLeR73qWlV/wSxdJXK0k1E8iJYBLgjB7LpSOxo4dNqpKyEWsXIKpBO+yQSP2j/cF5Tvhn7NkkpJgZivrBxQn1fFxVw8uQkemc5wZ5l+yEhHpLY6KvkcjNrqyPSlj4TQYXj/B1Itu8LZZ3TA/A/uB6jF5TVK07X9wflKHpnSXvZNm+mTnA7BM2IFM6o5JlJst1dMyttJ2Jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9PsgQ/xQsOyAu/ud0y56gleSXLEmTqKJ0Czf48ZKWo=;
 b=dB1qQAkq2/pd9xUeEcqOUM5I6TBx7z9EnnyphzEsiN2gAZO6XU4FbeskExFZM1GINi9hiL6yZ2cRz61sL5/WPnALeYHsytRSys5c49Z1w2TT/t2GYR/bBZbajk5PQk305V2ycAGYNmps+Ho2AwVG1Ow4emhDsZi4/Q6ut5twmq8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CY8PR10MB6489.namprd10.prod.outlook.com (2603:10b6:930:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:24:30 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 15:24:30 +0000
Message-ID: <e38104d7-1c2e-4791-aa78-d4458233dcb6@oracle.com>
Date: Tue, 11 Nov 2025 07:24:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20251106170729.310683-1-dai.ngo@oracle.com>
 <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::7) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CY8PR10MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 04de683a-73fa-4a51-81b6-08de213668e3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S3liN2s5VFdsTnBTL1d6ZWxkc0x2MVJhdWJxdG5lcDVGSXdjeDdQSTFGc01D?=
 =?utf-8?B?Z294ME93d2hvekc3RjAvV21XYXFTTEc0NWc4ekVQVmxoUG5nU2RpTmNvQk9E?=
 =?utf-8?B?YWxlU2JPOSthZlJLSkphcWc0VXh6SWxWRTFwU3pNd3JaMzRQeFNlbVlLRmZx?=
 =?utf-8?B?SkZmMTJRT0s1cWRiNlFuSkYzUklNcjY2SjhRMVU5TklxT0N5ZWYzRUk5RHRE?=
 =?utf-8?B?d3k0Rkx4ZjlSQWVvQXU3ZnhrY2tFOFVHeW8ySHRqdHR5OWRPdlJaTGYzMVFu?=
 =?utf-8?B?Rk50eXdVdFN3NmVadGZDRWtKVytDRUc2SVZ6OWpScnAyZXRoOE9vZHp0M3ky?=
 =?utf-8?B?b0hFdEV6L0tZOElxWGhac3FHZnVtcTRJeVZPUUJ1MlRhOE1WYUNEMUdXOGxM?=
 =?utf-8?B?NHUrOVQvdVBDdWlWOHZtU3Zzbm82MEtadjJ2b21PYk80dFBVaGJRL1VhS2la?=
 =?utf-8?B?TVVtaks1QzZjTkVudFdmdFRYOEcxVnh6SU1YQnlUL1pLWGUxVG1RTjJZKzJP?=
 =?utf-8?B?Yy9meCtCZEdTUGsxVFZGV05IMExxaGJ4eDd1aThJSVFHQWlVcDNvVmdDWnho?=
 =?utf-8?B?anpJeDQwZ2FLeEl0UUNqWjQ4YkhWSGZLM3BMeFp1OVh5dVA4Y0FrL0FTc2g5?=
 =?utf-8?B?azdFZGdPVTRCSURCMGJ5ZlBFN0FDcmpLR3J4cmozUW1mNUtjNjZqNXdXNlFM?=
 =?utf-8?B?bVlWdWNjYmlobkVkb3BHbXQxV2RtRTRXOXZjanBmWWFuZmZBcjYwZ1BEbGRY?=
 =?utf-8?B?REVWRWN3WUlUdGQ2S1ZreE5zdHc4RzZ4QzRpb3A1UVNJKzV4cm9kT1p1ZTNI?=
 =?utf-8?B?NWMzOFlaT0JBNkhGbVM2TW5SZ2lxSk5sV3Q3TGo1SnZFbG5ORHVQOU9nVHM0?=
 =?utf-8?B?REQzQWFUWkg2N0s0cGVyV2lZSVdnVUZvZHQzSzVSckJXYXcxNEN3L0xDbThs?=
 =?utf-8?B?aGgycTlESWlqeUJoZ0JXSHZoUW11a3ErcmlCZVBmTFRFcjFSalIvUjRJYlN1?=
 =?utf-8?B?L2FhZE1jaGp4UmEzVVYveGRWMkNvVXV3bzVRQzEzc28wWFdYbTNOQzQ1dVFz?=
 =?utf-8?B?ZVpxNDN1UFpSaWR1dkV2b2FMMkhUcjlPM25nUFBkMzRiaFhpMUZzNWY0T2hK?=
 =?utf-8?B?b0ljNm5jdlBIbEYwOUZSL041SzJDOEtyUkNyQUxMZUZvUFAwYW9nbTROaFUr?=
 =?utf-8?B?TkRyQVNSYWZnZVFOR3dNVmdPaEo5UlNjOFVwWkNRdHlWOVVFODRxbWJhcFlU?=
 =?utf-8?B?Ui83anN4K1NxM0ZzMDBQUU8zRUJ4RFRDYnUzbzdudkEvTVhhTzBkb3pKaVZt?=
 =?utf-8?B?SndONUhuY2JENmc5U05XTmtObXFQRHlySHZBWEpXZ3dXZ3BEMHNLTCt2RXll?=
 =?utf-8?B?bW5zeFB1S1V2NG9iM0ltZGNyMklmZHlCcWpCa05JUiswekcxQnZzSnNWaDNI?=
 =?utf-8?B?ZXkrMm5JZ0dsc3dtN1h6RjNEQjQxV0lkTlhoNFk5TUZyZVJ0ZlRsZnJiWGcw?=
 =?utf-8?B?aDFpZVIvRHhKZHF1RUZjdE1POTliWGc2OWMxanVFeDBBOGt1b2RpekNHTk9N?=
 =?utf-8?B?Y3NMa3lvRC9iYWJMYUpPVlRoa3NCVUR0ODNLTENEK0tVN3dKTFNHZkJGUm5B?=
 =?utf-8?B?QXJ6NGxUdzRKNEJZMzlTSGVQN3JKbFhOZnl6QXVuTmJESWFPdEhJTVlsVTRv?=
 =?utf-8?B?cWk1SzlHK2c1UEh1ZldZT2lLcU56MXc3WTZsWGNPY3RiZFNFUnlHdm5PVDFQ?=
 =?utf-8?B?SUt6NFN1OENpM1VkM2MrYlBnSGtPQUtnZHh2ajZ3cGhhVGNCRktMNFhtaWxu?=
 =?utf-8?B?YzBuTlNkdng4bWpIUjd0dkJtdjl5RExrS0h3bGdQWEE3ZTZ3RjU0aEs2ZlBE?=
 =?utf-8?B?M3orTVVLVzIvNlRhNndYWTJhTFZJZG9JU3l5WnE4MmVLTFE4Qys4eXJYYWp4?=
 =?utf-8?B?Y1psR3JERkcyQUJlYkF6STJZNGpvYlV6WmJjWFZNTkFKRnVoUFFmNDVVVWJF?=
 =?utf-8?B?S1Y2K0hVOEFBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NkpObmpqSnV1cTVNV3RnRTBLR1d1eUR1OURLQ2ZQTHlRekdBL3lHeG1FdEM0?=
 =?utf-8?B?WVIxZWRRckNSK2dlbkJuWGUvNFVJYkZONHUwRyt3Y09LTGJra1Zlbk52UkYv?=
 =?utf-8?B?RG1oOVJGMUl6ck0zdTNIRnlYOEZESFFscXo2UU1VcHgySVhBY09WKzdyck5p?=
 =?utf-8?B?WW9BdEpRM2tDbXFQZVROUmVwcEZ3eitIK3UwRXZaMEtqY0FrenBDYnQ2eU9v?=
 =?utf-8?B?R1g3NWVXSEN3VUljYmkycWJJcGpzNHB4UHpQUU5zdjlLQWVMdzFMbXhDV3pD?=
 =?utf-8?B?U2RiTGNKb0RVaGFlZjJPeElvcm45MGIwRTJJbjVsd2tjeXpVRlhsaStzNHFZ?=
 =?utf-8?B?T08zZkdJTEtOQkxneDl1K1pYWnY2SHkrYUswOFpEVXNrRXRaWFd5YTNMcXNh?=
 =?utf-8?B?RnM3OUNGUFJFcGZCZXBKWVpHYitqeFZJTFJqbEdHVDlSY3huS21KMzNZWVc0?=
 =?utf-8?B?M29MVDhTK0UwdEZsRU9iUVZrZmF0ZjJIWEwxQ1BxdkhCWkR0ZUkzbnUreWtq?=
 =?utf-8?B?NVRLc29Cbll2ekx4UU52Kzh2YlhtYUp2bjhkMW84N2wraktGMlVDT2w5NmFj?=
 =?utf-8?B?a3IvSlgvRHk0ZWN3YklkSG9yb3hzeUFZYk1EWk1nSzNuNVI0MU0veU41cVBW?=
 =?utf-8?B?aEF0R0lOT1FTbXQrb2I1T2IvdVV0OTZkRHBDUDE4U2JBTmJlNzQvM1ZpY3F3?=
 =?utf-8?B?TEp1LzM2VGZLb3Y4aFlmTlluOEJHaVpHVEMvUnJNUDJkNVZnM0xYL0JwV1lu?=
 =?utf-8?B?RVMxZWJZR3cvZFplTnhSbzN0RDN6bWZVWVRldEJnQjRjM1F1MVhSVnBFT2ti?=
 =?utf-8?B?clJnR29vYzRCL0NQT1FTTHMzeUVRZDNVWEc0MmNjK2thby9DdWVaU0k0b3ln?=
 =?utf-8?B?aE10bFAwK294ZWFnMHVSNWZoRWQxbytBWGtTcW83TGZmeSs0OFRpYVFuaW80?=
 =?utf-8?B?WUVYT0hDSzZ4Nit4SWRKS1pmWXQyVUU1Vm1XRW9GU2FCZ0JFbVZxMVBxSVZW?=
 =?utf-8?B?ZU5kcTlUaHFGT0lYazRYMXBDU2xxYkcrYkljYXpQS0FiWVBFamUwVS9RTFB1?=
 =?utf-8?B?RjFXQ2dvTnIxMmQ1SVVTTHBsa3FoRzBzYVVLTTVsa1A4azNhUy9xNFBoSkR1?=
 =?utf-8?B?QllyT0FhU202WllLVHJEV1NZWERrU1p3ek02RzEyTnZnUjQ0RXdmTXJNWEVw?=
 =?utf-8?B?bUZtUDMyNUdoQ0RCK212eXk1M0FySEhYZklBOUd0SFlSaTZrU2NPUzUxL2c1?=
 =?utf-8?B?MGw4V2NYVW1OMzVVL3BCY09tL3d6WDlHTTdoL2RVVTNCTi9vWXpvbTdSOXB0?=
 =?utf-8?B?ZmhEOGdsSlVEdEhhM2VHV1B6elhTNkFHb1orU09GRUttNmd2NUFLS1ZkaWRW?=
 =?utf-8?B?NlhCTjY3ZCttQUdNb0hyVThGRE9XUi9FYXVWMElHLzNSeU5RN2N1YVpBVzQ3?=
 =?utf-8?B?MFN6eWM4TWFMako2cFNrUS9QR2Z2QWhJS3A5TkJCZGxZZkczYmpTOFhxRHJt?=
 =?utf-8?B?RWZ0aHVESlIrZE5ObmpXZVNKTDUxOTkySHJzT2VTNGFPSFkzL3krQ3RMS1hU?=
 =?utf-8?B?elBiYnFhb2hiZ1JCKzd1VDN1TW5VSGpSeDhoaWNJMFFpclN5VjJhMFhxVW1p?=
 =?utf-8?B?NzV2L3FuS1NrclRKc3VzS2xkaEo3OUFyWmYvd015d2V0Q0ZIN3ByY0lmdEFl?=
 =?utf-8?B?dFRnSGFEY0pQSGRoK3VOYVhUbmZ6eXJITkJtd25lOWFsZVNlSTI3VnF3U1p5?=
 =?utf-8?B?Sm4zL013dDBpREF6Q2NLOE4yWGYwRUphdUJTM3BNRjhLNWJ6ajlmRWJkdk1L?=
 =?utf-8?B?QVNNMm53NDQ1T1duUHFzWXlIQ01kZ2l0RXpYZUQyODR6Z0s3VzBzd0xUZkRS?=
 =?utf-8?B?YStYalRBcFpXTUdyeFpFZFFxbHpyUVZqaXVFWTVFWlgyMENVU2tFRGlQZDFm?=
 =?utf-8?B?ZUtMS1RMZi9CcGpFbXRVWkRMV3pIRnUxMnEzZzJhSVhLak5jb2sweG1pTWR2?=
 =?utf-8?B?aTBZcEVQdDNmNko4c3hLYnB0VnV0bUk4cm9CU3pTRy85YTJSUWJmSFlWWHd4?=
 =?utf-8?B?OEZaTDcvTW5PajVpbWU3RzZQNEVwb2p1THMyUE1wOU1haEE2bVByVWsrQy8z?=
 =?utf-8?Q?WlhBab4BCW6s5gLehIn+8fyPR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x/K63dcNHsff+c/iyOZAlBj+egLcgvoFfUdQdoOrcztu0leoMi+E5rss+LCs3125X2LB2o4kPJKGhzWNaUq0p2O7C73LSng68WCWSQxyZp/eq/+q5TxdhoLBlCkke3S+cc5D8P03kgRQZT5HZN6y+p45+o7hTBrK1U4f+0RKDSRypJZoDaei6Fg/Vgqyy0EdDlZc9So62WFOUUPlTjn0djd5mZeZ3e6k0tD2iU58E+XtAgpYBaJM4mvLfExWejtNavqGcREQyw1jeVHExMWmyIzbLuKpVuQStA3/YNKpxCeDpdHa9PRVXSC7ddG3WMo/GvmVRgnD7xDtH620RrAHWevs+/+dN/Tf1EmGhfJ0fWKaFcjhbqMjkHe22D4TDd23D1fiTpcRknshPpWJ5x78K8Xr3UPorpx5gkSDSYqdhCeqOLJgKBAB/FvyH1DahggHHaedwT4ltVgqqFku+T+rScTZ3nHlFUVUK9vCp8QRx3kPAk9qBKaU2ylh/fxKtDzCPLdDM2MCq086a6yIDHFO7tY6JjwEgmERcCxQesT3tbMbCbUv4tSBdjXWglg2uTyK2TiFUomiLMU0JnGrVFkbjRhbLMDokgEWVcNbf/wQqWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04de683a-73fa-4a51-81b6-08de213668e3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:24:30.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9+xMKXT0EtvVeyzkQ+EV/jME0IHRJAFN3D8GX41K2odNm9xNwKgx4vuexDrnoIgt6wkXIhrKhRE1Nq4FYk98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110124
X-Proofpoint-ORIG-GUID: coqdWtB0QmkYGBB9MBkFLqK9JBpauQ_o
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=69135a09 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=bAtOpodHQcU2mEQE6GMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5NyBTYWx0ZWRfXzh6FK4d8hU1S
 G/yiZfZCfjD/nxoSr+7jr02TpqSyB1yUa4B8t9cEB5QIt0pCLfKEfeY3b6gO5zwRsqjyp6Kwu0y
 4c4fEsYXomC3t8j6ACL8nyn/t2bvcur/nlkwE4Y0VfS953/OLoXtIdxCoJQL//djFPl+ctKfWda
 t5TrRjZroSp5Mm0J9MKYF4u207nNaMQHSvaTspFEpd4K4z0t5t5agvCCspTBRIiFlS/OZXSpi4W
 TBpbn/tgjfESFMsSkgVTZn/B+Sw0QJu4ndIwTqn9vlFqt+t/vHh38xwP5PdsWFme6DKDvvyRZCw
 uA9CgRjR4XhjsJhSUMCij45z0GsYevZsMyAgbc6gmAD0HTIp95PwtnCgEhHEdqu6yJUaYKHXpMZ
 o/N1ywGmNU+fq3nQNcf7jT/LsEg4TQ==
X-Proofpoint-GUID: coqdWtB0QmkYGBB9MBkFLqK9JBpauQ_o

Hi Ben,

On 11/9/25 10:34 AM, Benjamin Coddington wrote:
> On 6 Nov 2025, at 12:05, Dai Ngo wrote:
>
>> When a layout conflict triggers a call to __break_lease, the function
>> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
>> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
>> its loop, waiting indefinitely for the conflicting file lease to be
>> released.
>>
>> If the number of lease conflicts matches the number of NFSD threads (which
>> defaults to 8), all available NFSD threads become occupied. Consequently,
>> there are no threads left to handle incoming requests or callback replies,
>> leading to a total hang of the NFS server.
>>
>> This issue is reliably reproducible by running the Git test suite on a
>> configuration using SCSI layout.
>>
>> This patchset fixes this problem by introducing the new lm_breaker_timedout
>> operation to lease_manager_operations and using timeout for layout
>> lease break.
> Hey Dai,
>
> I like your solution here, but I worry it can cause unexpected or
> unnecessary client fencing when the problem is server-side (not enough
> threads).  Clients might be dutifully sending LAYOUTRETURN, but the server
> can't service them

I agreed. This is a server problem and we penalize the client. We need
a long term solution for dealing resource shortage (server threads)
problem.

Fortunately, the client can detect reservation conflict errors and appears
to retry the I/O. Also, the client will ask for new layout and in the
process it re-registers its reservation key so I/O will continue.

>   - and this change will cause some potentially unexpected
> fencing in environments where things could be fixed (by adding more knfsd
> threads).
>    Also, I think we significantly bumped default thread counts
> recently in nfs-utils:
> eb5abb5c60ab (tag: nfs-utils-2-8-2-rc3) nfsd: dump default number of threads to 16

This helps a bit but if there is always a chance that there is a load
that requires more than the number of server threads.

>
> You probably have already seen previous discussions about this:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com/__;!!ACWV5N9M2RV99hQ!Pq4vHQs-qk71XjZ0vOkONTD7nxkuyUUEKTBsJJ0L_OrFWudokphCyc2V0q0_OrNoGD3KnsgoHKp7rb_lDcs$
>
> This also changes the behavior for all layouts, I haven't thought through
> the implications of that - but I wish we could have knob for this behavior,
> or perhaps a knfsd-specific fl_break_time tuneable.

There is already a knob to tune the fl_break_time:
# cat /proc/sys/fs/lease-break-time

but currently lease-break-time is in seconds so the minimum we can set
is 1 which I think is still too long to tight up a server thread.

>
> Last thought (for now): I think Neil has some work for dynamic knfsd thread
> count.. or Jeff?  (I am having trouble finding it) Would that work around
> this problem?

This would help, and I prefer this route rather than rework __break_lease
to return EAGAIN/jukebox while the server recalling the layout.

Thank you for your feedback,
-Dai

>
> Regards,
> Ben
>

