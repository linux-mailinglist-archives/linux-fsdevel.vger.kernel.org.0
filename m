Return-Path: <linux-fsdevel+bounces-42456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA0A42851
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25502168CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435C263C72;
	Mon, 24 Feb 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TKxXMHGt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2Ya3q1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4F2627F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415974; cv=fail; b=L3xu9DABzNqMjXv8AbC2x5LJT5ML8RWRaiCI7MAuwPluZBrBEF1oNaxtDuu9ZkZc74gihTYizj7QI48cyJFnQIIomQYJQfu4MXmA5xVVcScxK1qvTVSkSNuKBLFm6pYUgR0NjKykkvSksGVi1Pseg3PO+iqHYmPPU0BwOD5gnNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415974; c=relaxed/simple;
	bh=npi7EoI79UxSs+pu238Qh/YFI90K1dy3KAKgbKoBYkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSLZBJfETdU+TanPSlvQCtbsaWNPFviEgXtS5DZSWlxBhNBpyRefKW9FKenoKo3/UA3IKC6ggo8I737AoMT8kvq6KhNs6K4rUNxfvZXVQCndVtQAySufNILhdqZ5SVJslG9x3L6Ol/iAHFiGEr7146Dcx8QpLvbxb48vu2Op5lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TKxXMHGt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2Ya3q1D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGXahq014016;
	Mon, 24 Feb 2025 16:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=el/ZL7CdncRVvOBH1xXyqJX20IgYltYs/cwwCy/z90g=; b=
	TKxXMHGtp+FsGIyIOBRLqXpqv20mR0GZKrFj46j7URYbjK1G6mBRHF2fZhopKrsj
	u4bssWjl38WNGjoOGT4plxhZXTATUburmGAcjJ5vcgZc//ark62OWWGhDSzQgYyd
	r3jZGI4XgA4GpFYBUxEr/jymqHlLRqWw9GJ7mG409uY61dGQEZopW1zRcZ4/Q9wk
	6IEspwM98wIZStzGJlpGKYiPzFatCh/5yGf2iIWhVgH4huWLuprUTwEj/NLJcCSC
	kuDSkt0fkxXGsZbDZkSRfnjdQTAV5dqhKzXmDjajiQA8chuVTgTJCVPn1E58hHC0
	stmOQ2bY4TwKQyjtBw4TjA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y560334n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 16:52:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGQLwW012602;
	Mon, 24 Feb 2025 16:52:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5196c3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 16:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lO1jbyNYidzhmF8ZdaMMvw+u/1avdnvqiMej4XJY1UOU11z2MvwzLjIoajkoEukQTJfTeh74Y4SfQl1xQ54Vpp5Rv2eGoEjShkrO616eUd7ujJU9eAp4df6XY5I6ptyv1t7qNVFHteBZopalLT5HPbyIcE6xeDsq8zQMpMFHpITYtoK+Xz7BLOztwH0YyihBfQzdj2wv1Zw/hX7sQQyIXUKL7GSapRjLjSFD9hU3ZzqqCjjlwCjUB9lau1yu85dRJmIYkMItseWBBABljrP1cfvENOtaVelgWqIgWxx1RXTf1B9mas6MS7ZtF4rdNT3/m35/DMCj7ZIggKR5ztdvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el/ZL7CdncRVvOBH1xXyqJX20IgYltYs/cwwCy/z90g=;
 b=kwunfONOxcs0AKK0XRNnjmZn5o9iZhnWDEUipo+np2La1SGlGxhBTwX1Q2bp7L+Aas7ixyNsgXCaEbmLFVEu3EG6fozBDPwjLy3HsJu3soodiQSTF0YCHqO1bTCB3jrkOqcIUGoykemJ9Kdd2d+JnX0dk4zRNflviWGiHP95uvlh/wt/1vJ1yds5j1sL3Bnex7su5oB2f5xEpkz6lfgCSnwlW2ZFsnz1jFCZT4wiEOWpvBFDxFAgxt5GmpDXEEQ5Tak2oRqcS+2ieI70Df+uyCHc+zj84gzq0dZo7KHbWihp1Rmst6uDd6SwjAfer53VAMkxfhdRoXTL5eqSRKpW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el/ZL7CdncRVvOBH1xXyqJX20IgYltYs/cwwCy/z90g=;
 b=u2Ya3q1D0Jq/SD9/IyVCWVEuBpOSi6IJqagyVEwA2o9Du8g5X53ptWY3rb8t9p0Ja/jesoD/m0uvp9GuTGAaNI82XdPFvm0gOppwpqBvjyX6NqdvELiqCBXi21psqNr15Sa/z2E/jjcmxjrhoL8RzDxxtIzsY/G51l+njrMqFZs=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH3PR10MB7140.namprd10.prod.outlook.com (2603:10b6:610:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:52:27 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:52:27 +0000
Date: Mon, 24 Feb 2025 16:52:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Kalesh Singh <kaleshsingh@google.com>, lsf-pc@lists.linux-foundation.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
X-ClientProxiedBy: LO4P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::15) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH3PR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: b8aff8b3-9d25-401b-7ef2-08dd54f39ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjVPTUQrMXhDMFNiRjhQdFMrbFA2eXE0dTlFTlN1cUtIK0l6c0Y4ZjlHRHBS?=
 =?utf-8?B?dktFc3ljNFpWai9SbDJCVXdVUlpHUG9ZQ25mUzl0T281VnFENzFSYVZxdGdp?=
 =?utf-8?B?UTJmcEVnMWpZWTBpNEFWN3B3ZkxaeDlxUjIrSmlzMzNvRWhReVRXbk9USW1L?=
 =?utf-8?B?M2pHQXQ1eXNjUFI2SVAzSTBHTDhKRm1DcnpVbTNLN1ZicUhITWRPM1ZVYnJa?=
 =?utf-8?B?QS8xbloxdlgvRU1kNG1UeFkwYjJMeDF1cjFLWmU0dWxFZkpqR2lKWFU1blIz?=
 =?utf-8?B?RjVSMC9UZFkweTRwS1Y5dkV1dWZtTitWbWVIem0xRnJ5ejRQTjVvOVAxWWox?=
 =?utf-8?B?cm5TV0R6bDdKalo4aWs1OXcyeVFWNjlmcUEyRmhNZ1NJSEJXNjYzTDlqVkZj?=
 =?utf-8?B?bkZHNnV0R3ZzZ0p3YS9DU3l4RUVpV2p0blNrMWdVbmxwM1c0bjZzYVN4VUVm?=
 =?utf-8?B?WXJoQk9aUC9uNkdUb1RBWjJzT210OUViVUhqWlpLZVVUdWVSeGhaUDdhTy8y?=
 =?utf-8?B?TmdZdkU2KzVTSFViOE9xZml6aGVGbDUyTXpORVpLR0NXc3Y3S3cwYno1bkhu?=
 =?utf-8?B?QnR2RktoWlVsU1dNdXYxVEcyM0ZRNThXQS9rNW1TcFhMTExYSlRMelJhOU40?=
 =?utf-8?B?RlJkWmJRR1NoZnp5VThrYytHR05NWS9XVzhHUlJmN1JmYlFKcmZhZ0tNK2R6?=
 =?utf-8?B?OUNwVFREV1dBQkdlWDhPUHFhdHZHYmdwNzZZTnZBSXZlSlZDczJQWVl3RVBs?=
 =?utf-8?B?S1hoeWkyNmROaUIzU2xEVlJzVnN2Y3JZd2kvbWpnclJ4YjAyV2MyVkNZd2NF?=
 =?utf-8?B?TjB1TVBIV2VObEN5YmNFMTJNNkI2S2k3SFFEQ21yNytxeWdxb2dxZ21pZHlU?=
 =?utf-8?B?WjZjM1BGcThrR2ZUZFVoOXkzSjFFVndFbmlsUWUvTGtnWHVoMlFyMkJ4K2c5?=
 =?utf-8?B?blNUL2JUSTlQTHB2M1Jkb1dnSWFwQTJ0a2ZTYTJIRkc5NFVSZ29XbXVEZ1Vu?=
 =?utf-8?B?M1ZWRTVqRFBNOFhSc2gvenBET3JQRlF3T3pMOGQvMVdVNTZGOUxsNzdXZHVJ?=
 =?utf-8?B?dDJQRGtEYWlUTCthL0FkZWhtQjk0VGg0KytXZW9kV3JLR0J4R2lKclRKK2dR?=
 =?utf-8?B?RHY2elZ0cHdKVFpyQyt2ODFlWHBmZTNDdG9qOTBid3ZRN2dxUHBYV2JMaFlP?=
 =?utf-8?B?ZFFCVlBJU0RqckxsYlUrZkh1QkorR0FHNWpzdDJuWGI3SmNlWWxNcktXYmxF?=
 =?utf-8?B?dURoMlNnckplQVJRa28wRjJ4Vlg5UVJMM3RZVjFBZnZWU3RTaXZxUmVKQkt4?=
 =?utf-8?B?SEtQL2g2NnZ3Q1Rna25PbXpEWjNvMitBRnNWQUx3U2c5TlhkRXJHSmN2SmQv?=
 =?utf-8?B?SFhEdDhqZlpXMFdsbVRQckgyTjlhRjk1N2p3RU1zSmxqMktjb1d0c3pBT0RZ?=
 =?utf-8?B?VzdkdGtxTmZqaFVuZlJXanhJdGl5Y29mUE5IenhLRDkwcWlKcmNJRkhhWXEz?=
 =?utf-8?B?VUthY0ROMDhIaytYRVNvYjYzK1Rndk1ySFRSOWh2Z0tpUnBFRFFxbTVJWWUy?=
 =?utf-8?B?cTB1MjlzSERiQkZaL21RWkN4Z3Z1cERpYmZBRCtjM25UUGIyNmcxRzNzOEtr?=
 =?utf-8?B?czF2ZFJsUnFGM0hVOGVSQnppQ1VWUDhFWS9vbk5FT0VLQVJyTVJDSGs4Q1o4?=
 =?utf-8?B?M2hDSWZjbmtFczEvSTdlRW5Bb2xtczZVUnZFQ0lBTmtrZHdhUENJNHgyT2Mv?=
 =?utf-8?B?dDYyLy9rbC9xL05WS28vTmorbHJ4blpmVVY5eDdDdElxdVFYOGNuSXBIOTNH?=
 =?utf-8?B?VTQrTDdPTnNQc2NMbjVLQVovVTd0QWI0NVFQTVhjQjhPV3plUGk4Mndra3BJ?=
 =?utf-8?Q?cQ5U2SLA5or4f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDhsQ2dscW5BMDRCZUtiVTNZUlJzU1U0enk5NUQyS2UzZ01EdEtua1ZwdTlk?=
 =?utf-8?B?c3RqZHE0MFNsTnA5aDdxZ2NqMEU3MzFOVFB0eHllTkV4UW0xRFUwdGxnYk9D?=
 =?utf-8?B?R2Jlb3MvSnFBdVkxZ3pHa294OUtYaUVLZkcxaDdldHd6bnR0amJvL2dLNGlP?=
 =?utf-8?B?MFBHbVluNTlDT28xbUo4dWNINlVZc1pHZXBDRXRudG5ORzN5a2NGTlc5cmVs?=
 =?utf-8?B?MjZsQ3lMRXdGbHhNVVowVVBXdGFVRUdJMjUvWk1Qcnd4NlpqMGhJRXh1ZExO?=
 =?utf-8?B?b29MNGhEd000d0RlWGtLVGh0dWVaZy96RVBPcWlLYmRMM29Sd1dweXZWaFY2?=
 =?utf-8?B?a000R2tIczJ2RXJhZlpiNGMwRnBydWFnbnlidUJwa09zVWVBb1hSTnZtSjBj?=
 =?utf-8?B?NTJwUHNuSS9ETWo0bENVMFRCZmxUbStsQklUTThEU0drNjVPZGZrT3dhZTlm?=
 =?utf-8?B?eGhmUmEySXRnWlk2aTR2Qk9JVHNCMkJBZEhXU0RNUFJWQmdwTmFzT3lGR1Bz?=
 =?utf-8?B?ZUxvbng0WE40SFpYOG1YL3RVSjB3TmJDOHFna1l3SVBWbVpMci9ObEtzUThX?=
 =?utf-8?B?Vnh0bFRLdWs4cXFNckUyd1BndFhMZWM0Uk51dWg1WnFKQVNCOHpwa0tCQWRu?=
 =?utf-8?B?SW1uV2QxRVJoY1NxWktFWlV5eGtBRGpJcUR6a2lVSzVOQVR5bytZRWsySFB4?=
 =?utf-8?B?QVRocUlEbUV0b1V6RDJBbE85S2hma2FoT1hKMHRSSVpscUFzejV6UXlwdW5h?=
 =?utf-8?B?VndwYktLQkc0S3JkSVVpVlp1U3hrRVJxK0NaRzVkU0U4elFLTHRXWnJrQ29k?=
 =?utf-8?B?ejl3dmRSdGdMcExubGRZUmdSQld3TjZqUUJOYjNraFpiTFZjUkJ2eWVaVjhC?=
 =?utf-8?B?S3pzZ29BejR3ODNrSjVjQTJsclRiWXZ6bFdHQmVxa0YwaHRXcHcrd0pJSjVs?=
 =?utf-8?B?WXZTcUFUN1pUeVB2ZzNOWXdwOG9RMFJMNlN2emFVek45OFYvdXFZcXRRUndM?=
 =?utf-8?B?YUNoOVhEVGYyZ2pZbzdxY3A4d1JGNDNoUVVETmlTaDlJVGxBNWlNM0xZdkpX?=
 =?utf-8?B?aDkybmNsMTRtTlNacUROQ0RySXFvR2JFVnpCS0s1NlN1bzdlUnVKUUV4eURh?=
 =?utf-8?B?Zk5JQUIyMTUrUis3d0orQUFTVlBweHBjdlM5WTlDVEMwZzNjZlVrRmIvTHh2?=
 =?utf-8?B?VTFqS0ZpWjdpNDh6VEhMRTdyQkc3SVpMTCtvOHA0S1g5ejV1YktuSENzY0sz?=
 =?utf-8?B?aVNybS9iRzR0S3NHTXBHU2Q5Rk5UMUxzK3E5dDNqaUFHdStRMmlOb3p5Sklp?=
 =?utf-8?B?cGR0YWtrSnBpcG4yeDJWajd5dmhLQml2SFh6Z0E4bDRBR2V5a1B0YmRvQ3pl?=
 =?utf-8?B?WllYMHJkU2svK0ZDTS9BRVRXNk1hZVErbkIwb2JnS01wQllSVGRSSWVUSmZR?=
 =?utf-8?B?RnVJL0ZKcVVyWnBMRFJmcDVYdC9UaFRkR1ZieGdieEVBQVRhVFhXeFBKendj?=
 =?utf-8?B?bk1zaVJ0RG9lbTRLTkkxTnBWR0xHcXVMMHVRN2hjSjJ3NlQxTU9vWHFML0FB?=
 =?utf-8?B?RzduclJZd25iMmIrL3pvRlcwblRGdVdEcVUzRXBBaGc2dTh1VnJzbkFhdys0?=
 =?utf-8?B?Y1J6MWZXQlEyNHBnSjZ2L3dVOEw1L2VCTDNXZjhQWGg3VmtnSkRGY2NJNWJL?=
 =?utf-8?B?c3Z4MXNmRXE1L0M5QnJCZmJvTkRIcis5MUZZNXNsR0ZoWCtaY0w4bE1wYjA0?=
 =?utf-8?B?NHV5S1MwSlpPRlplZUF4STBHZ0RKM0ZMWjVsMlVRU25KTExEUGpCY1MrQm01?=
 =?utf-8?B?MXoyTFE3MEZXR0plVkk0RmtHQkhDcFByRnQvZ0NVZFRCYmtJVjZabnRadlNO?=
 =?utf-8?B?RnQ5Qk9DbVorajNqeU1TU2ppbjVqSXJsdFhBbi8rMUxIODBOMmZmUHJFVVZ2?=
 =?utf-8?B?UXJKNTY1a0JhUG1iejZ0eUswWWtxSWNZK1pISjhlcVZSdlFYamNvWDZrejdP?=
 =?utf-8?B?MVZmZkRWNjBnNktxelNwKzhic3VUdUcwa3BrREdYbyt0NCtGWjh2TUdZMWJi?=
 =?utf-8?B?ZCtFdDlLK1hKZWdjTFhaYWNsMlNRK09EbnlBaWJUQ24yeXN0VS9qZlA0ZjVv?=
 =?utf-8?B?NWI5Q05PSk5tNUdRNnp6bXcwNXBCVW94THU5Zmt6S3Bic1UzME10MzUwZkNC?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EpoyFeYIQkey9JhVzFsVtUCBniYrU81PWQQsxgGkLgl3HmvfuPvuhk0ZIWB19uxjWlLK4SBPdSwDYRu8aQwcKV2tEevqvQp0NjoJX1PrZN90mgbDCiLniLCu2nMZrTFkVbnVaurT+cLPPe/5voQibNgmD495n9REYmovS1uJFf4uehqp53gHpEb/8hWlz0A3Flnt3InOo7LVDAk7mWwCjd6k4XT9IvM25It/lTtCn2uPwYarF6cpQSsoC2c7qNgllC9HhS1OJzmsumVrKwnebYKg+epxkdnxdOKCgHW6kPS36XIcHW1Z6lJ4OzZjPGVwy0Eey7R/kn8R7nL5A5EYd+1w+hHmVjX4gTGJAToUUSgvTOeDtgCYOlB8i9oQPA2c87pVgf1GlsnR2/cLgx6SlQu5viTVvHQnuA7O23NaAyUw3OBLhlf2SDDUaM2kZP5QLamefoAfQzJA1j0BgD0dv9NGuLo4Z9FUHdji0OCUct6e+37qA+OCZO/wK9OTkFFFwx43k9X+IFUJ1Wxy+XozXau8qdgJ3dMAgvePZh92Lb7DMHujgSGreW9Bbl012yRZi5DNZzFv/KOIH9e+FB9P3atGH+GZXSgdiAVbKjuJihk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8aff8b3-9d25-401b-7ef2-08dd54f39ec3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:52:27.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wT/5op/Ta4lJ+BwUPzeGwMUjQRN+BOMeI5FxvPD7cv8oA2hI9ddjCSNgEdXZM1wASlvRtVMFmZJh/dcBqE733LlP9m6XPSyOFbwoRVbNL0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240115
X-Proofpoint-GUID: 8ggskvKkCb20frNNPC111lOHus8cGG8_
X-Proofpoint-ORIG-GUID: 8ggskvKkCb20frNNPC111lOHus8cGG8_

On Mon, Feb 24, 2025 at 05:31:16PM +0100, Jan Kara wrote:
> On Mon 24-02-25 14:21:37, Lorenzo Stoakes wrote:
> > On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> > > Hello!
> > >
> > > On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > > > Problem Statement
> > > > ===============
> > > >
> > > > Readahead can result in unnecessary page cache pollution for mapped
> > > > regions that are never accessed. Current mechanisms to disable
> > > > readahead lack granularity and rather operate at the file or VMA
> > > > level. This proposal seeks to initiate discussion at LSFMM to explore
> > > > potential solutions for optimizing page cache/readahead behavior.
> > > >
> > > >
> > > > Background
> > > > =========
> > > >
> > > > The read-ahead heuristics on file-backed memory mappings can
> > > > inadvertently populate the page cache with pages corresponding to
> > > > regions that user-space processes are known never to access e.g ELF
> > > > LOAD segment padding regions. While these pages are ultimately
> > > > reclaimable, their presence precipitates unnecessary I/O operations,
> > > > particularly when a substantial quantity of such regions exists.
> > > >
> > > > Although the underlying file can be made sparse in these regions to
> > > > mitigate I/O, readahead will still allocate discrete zero pages when
> > > > populating the page cache within these ranges. These pages, while
> > > > subject to reclaim, introduce additional churn to the LRU. This
> > > > reclaim overhead is further exacerbated in filesystems that support
> > > > "fault-around" semantics, that can populate the surrounding pages’
> > > > PTEs if found present in the page cache.
> > > >
> > > > While the memory impact may be negligible for large files containing a
> > > > limited number of sparse regions, it becomes appreciable for many
> > > > small mappings characterized by numerous holes. This scenario can
> > > > arise from efforts to minimize vm_area_struct slab memory footprint.
> > >
> > > OK, I agree the behavior you describe exists. But do you have some
> > > real-world numbers showing its extent? I'm not looking for some artificial
> > > numbers - sure bad cases can be constructed - but how big practical problem
> > > is this? If you can show that average Android phone has 10% of these
> > > useless pages in memory than that's one thing and we should be looking for
> > > some general solution. If it is more like 0.1%, then why bother?
> > >
> > > > Limitations of Existing Mechanisms
> > > > ===========================
> > > >
> > > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > > > entire file, rather than specific sub-regions. The offset and length
> > > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > > POSIX_FADV_DONTNEED [2] cases.
> > > >
> > > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > > > VMA, rather than specific sub-regions. [3]
> > > > Guard Regions: While guard regions for file-backed VMAs circumvent
> > > > fault-around concerns, the fundamental issue of unnecessary page cache
> > > > population persists. [4]
> > >
> > > Somewhere else in the thread you complain about readahead extending past
> > > the VMA. That's relatively easy to avoid at least for readahead triggered
> > > from filemap_fault() (i.e., do_async_mmap_readahead() and
> > > do_sync_mmap_readahead()). I agree we could do that and that seems as a
> > > relatively uncontroversial change. Note that if someone accesses the file
> > > through standard read(2) or write(2) syscall or through different memory
> > > mapping, the limits won't apply but such combinations of access are not
> > > that common anyway.
> >
> > Hm I'm not sure sure, map elf files with different mprotect(), or mprotect()
> > different portions of a file and suddenly you lose all the readahead for the
> > rest even though you're reading sequentially?
>
> Well, you wouldn't loose all readahead for the rest. Just readahead won't
> preread data underlying the next VMA so yes, you get a cache miss and have
> to wait for a page to get loaded into cache when transitioning to the next
> VMA but once you get there, you'll have readahead running at full speed
> again.

I'm aware of how readahead works (I _believe_ there's currently a
pre-release of a book with a very extensive section on readahead written by
somebody :P).

Also been looking at it for file-backed guard regions recently, which is
why I've been commenting here specifically as it's been on my mind lately,
and also Kalesh's interest in this stems from a guard region 'scenario'
(hence my cc).

Anyway perhaps I didn't phrase this well - my concern is whether this might
impact performance in real world scenarios, such as one where a VMA is
mapped then mprotect()'d or mmap()'d in parts causing _separate VMAs_ of
the same file, in sequential order.

From Kalesh's LPC talk, unless I misinterpreted what he said, this is
precisely what he's doing? I mean we'd not be talking here about mmap()
behaviour with readahead otherwise.

Granted, perhaps you'd only _ever_ be reading sequentially within a
specific VMA's boundaries, rather than going from one to another (excluding
PROT_NONE guards obviously) and that's very possible, if that's what you
mean.

But otherwise, surely this is a thing? And might we therefore be imposing
unnecessary cache misses?

Which is why I suggest...

>
> So yes, sequential read of a memory mapping of a file fragmented into many
> VMAs will be somewhat slower. My impression is such use is rare (sequential
> readers tend to use read(2) rather than mmap) but I could be wrong.
>
> > What about shared libraries with r/o parts and exec parts?
> >
> > I think we'd really need to do some pretty careful checking to ensure this
> > wouldn't break some real world use cases esp. if we really do mostly
> > readahead data from page cache.
>
> So I'm not sure if you are not conflating two things here because the above
> sentence doesn't make sense to me :). Readahead is the mechanism that
> brings data from underlying filesystem into the page cache. Fault-around is
> the mechanism that maps into page tables pages present in the page cache
> although they were not possibly requested by the page fault. By "do mostly
> readahead data from page cache" are you speaking about fault-around? That
> currently does not cross VMA boundaries anyway as far as I'm reading
> do_fault_around()...

...that we test this and see how it behaves :) Which is literally all I
am saying in the above. Ideally with representative workloads.

I mean, I think this shouldn't be a controversial point right? Perhaps
again I didn't communicate this well. But this is all I mean here.

BTW, I understand the difference between readahead and fault-around, you can
run git blame on do_fault_around() if you have doubts about that ;)

And yes fault around is constrained to the VMA (and actually avoids
crossing PTE boundaries).

>
> > > Regarding controlling readahead for various portions of the file - I'm
> > > skeptical. In my opinion it would require too much bookeeping on the kernel
> > > side for such a niche usecache (but maybe your numbers will show it isn't
> > > such a niche as I think :)). I can imagine you could just completely
> > > turn off kernel readahead for the file and do your special readahead from
> > > userspace - I think you could use either userfaultfd for triggering it or
> > > new fanotify FAN_PREACCESS events.
> >
> > I'm opposed to anything that'll proliferate VMAs (and from what Kalesh
> > says, he is too!) I don't really see how we could avoid having to do that
> > for this kind of case, but I may be missing something...
>
> I don't see why we would need to be increasing number of VMAs here at all.
> With FAN_PREACCESS you get notification with file & offset when it's
> accessed, you can issue readahead(2) calls based on that however you like.
> Similarly you can ask for userfaults for the whole mapped range and handle
> those. Now thinking more about this, this approach has the downside that
> you cannot implement async readahead with it (once PTE is mapped to some
> page it won't trigger notifications either with FAN_PREACCESS or with
> UFFD). But with UFFD you could at least trigger readahead on minor faults.

Yeah we're talking past each other on this, sorry I missed your point about
fanotify there!

uffd is probably not reasonably workable given overhead I would have
thought.

I am really unaware of how fanotify works so I mean cool if you can find a
solution this way, awesome :)

I'm just saying, if we need to somehow retain state about regions which
should have adjusted readahead behaviour at a VMA level, I can't see how
this could be done without VMA fragmentation and I'd rather we didn't.

If we can avoid that great!

>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

