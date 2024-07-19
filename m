Return-Path: <linux-fsdevel+bounces-23990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE429376F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 12:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A441F22856
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0F84A57;
	Fri, 19 Jul 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QT9uwvEr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZgoT6SwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DE42076;
	Fri, 19 Jul 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386787; cv=fail; b=Bw2HLs6R1brexHH2uen84LrCd62a6TDEWQ7xGNus/3RPxWq3I28XxpKKHFU4pg7KWKte3o0nbxFO8Vp7YULrSm8n1G42C4YTbo6g3WmEvDvLsuyDhYYBqNOQV8+qUJMlzfr+4TIgdGGEHcGO3I4w09c6eEJ/oK1WRZZA7eXRAn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386787; c=relaxed/simple;
	bh=TSIrenrE4rqMqsmPxWQWOtey24vTrn9a1EUBRVK0l4k=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/2BACbTLvwrMyVsAvcL6muKCR7PhDbUF1A0ps45nhSjlXQEE5L+qmAGMW+RM5NXw10kpW41ZyR/1DNEtKzSSj5t5B6+JXScfkBh0ufr4WDOPAkHgQWmi51jEiNxtlwAjlkJVjtAoglVwwXQtszxbLKtHSmB1n6BDszSx1Fh6qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QT9uwvEr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZgoT6SwB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JAuSMO010970;
	Fri, 19 Jul 2024 10:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2Zoe+geT3cVofau
	I116wKK+ugSXAbxU+2pmWl1TSvaE=; b=QT9uwvEr/ibC0ZODkgsxJyretti5RIV
	Tj7YX0hCPDenlE2h5+tLe+kRXPfNym5z0iV7ckWPlh6HK5R5ls3IdHiRbKvQvkFZ
	5wjlmZXRRGRdgbNaD6eCc83OinmN7Q7QdfyfU7jtvWnZyFc6LCljCSItSoRUAZk5
	tc6r7P062VUIVbFDNNJdxO5TsRZMsK17djTPk3MixGGw+P5jwSJg0kGuNKS1cc6n
	dfyqKNFV+0znABz939mBSf0HWHUPL6JzY0+4JzrTVVk9eEhy3TmqoRRc/6ys2ru6
	67f1dMGsRMD0VPQR3yFlSr/alAzWo/OVXrFKQz0L+CamSTspRIpel3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fptgr05f-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 10:59:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46J9qi9d031782;
	Fri, 19 Jul 2024 10:52:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf107ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 10:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1bZIg3dJshkSVbaESBN3ct979MnylH1yfEd0GG+GeYk6mQAlwsRhFIBoCd1cYuZkv5YPLly08HZKUPTnXtwtwPF/P/TV7Svw2ovnNmc9tayF8Sf2wJspQ4s8S6uHYV08WkWON2HLnHeGnNxHbfgjbhRsOvJoRuXtHejS/bGEFe/AfWZ5bvVapHfo3SZFBugjccTCxpv8G8ixc5qqHQ9amaHLyB3eNgeWnyCx+oTrIOf2nUhbDRcIrROpiJNT0+LBcKTryeDIHiPL8yw4xZ+rciSMRwqWwQ5JV3h77FqpZXuYq62+c/iVFWPU94oF1SREDh+36KIUkJy3pr6OocRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zoe+geT3cVofauI116wKK+ugSXAbxU+2pmWl1TSvaE=;
 b=YCXClfJXX7Cl6nMtrZXNRixjdAN2luhR/f5m1YRIzGMdSw2H9qcqeTxXNu13H/ZCWPYSVkBy2bnJHswSGd4Ud6oCXSUxT1/Yr+Xv4fWliV6JWECU0wSm0uDBXoBGOYyAWSnNJNBLG5Ut+da+e1ueuDxhsVxf2u90M0ufoku1QBXsVKYUH0t0z4ieMLikr07k72GgJi+BtupOn0X1IhH5GXaOgvowNhwx8vzm+oxIq968toIxdRXVGeUfqn03XNEZ0U63Q9vpE+ZueNifu8TfhUvVt6UsU8rFHecKyeIMMkqTNxK5i9hJgMujfajo5Rl1nGcEBQRsbqg2DNJRqDuQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zoe+geT3cVofauI116wKK+ugSXAbxU+2pmWl1TSvaE=;
 b=ZgoT6SwBjb7iiCjg660Im5WDHDX2Fj3bLVaQD+NYB5FKp1iTfLh84UtB3aBwobs0Kj0GWfC5I5a5kUZgvCS85qaafawfP9qjKgrkG0xVqYaZbOB7tK/4+Wfbqq767RcfC/FowYLCpFslFg2kNL2VKBALgQOkxk9kttEb7uC00tc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 10:52:05 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 10:52:05 +0000
Date: Fri, 19 Jul 2024 11:52:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 0/7] Make core VMA operations internal and testable
Message-ID: <8768fe2a-e4f7-4831-b608-cb3d21556534@lucifer.local>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <8a2e590e-ff4c-4906-b229-269cd7c99948@lucifer.local>
 <20240710195408.c14d80b73e58af6b73be6376@linux-foundation.org>
 <3sdist4b5ojz2iyatqgtngilrkudb63i7b6kp3aeeufl3vrnt6@p4icz5igbsix>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3sdist4b5ojz2iyatqgtngilrkudb63i7b6kp3aeeufl3vrnt6@p4icz5igbsix>
X-ClientProxiedBy: LO4P302CA0007.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f67596b-c2fc-483e-f3fa-08dca7e0d423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Z8pYPC2/MTVa3VHQf24QgzlBDeOfqhw0NYApQBHKJYUdTDNb/yh3ZmyA480m?=
 =?us-ascii?Q?pYgAaQAjUxorr72giAI5kUSKW7Q20ckOg26wSZUd6ECVoAQteS8xVdHIbdBB?=
 =?us-ascii?Q?26jdSpnMoOvoT2Q1tjWgOg5ovzVtqbSJ4zHWFV60Kh0Equuan6PGzrp6hiX3?=
 =?us-ascii?Q?7OqGHBdmx9t5Rfn+gSW6+6RB0QYisg2U73P1rKlIZDWmD9AxfpRSE4qHfmgt?=
 =?us-ascii?Q?otyRNL9apR69pViwR759iQf/h8EXBCfH3vS8fSxrDa3jVgP3WV/5u7dZ0OSo?=
 =?us-ascii?Q?lOZ9B7s1TBCxuNJUl217FvBha9trbk64jT8Ed9NJVFiK38+IGAWXzK+G6CUk?=
 =?us-ascii?Q?E8DEMUIuCXClHo9HvWWhqf1sLZFuAiFgJDUL38nKbCMGhOf+K7Gtdo1aUO/Q?=
 =?us-ascii?Q?wZnMi9sdLQKRWyi1wNQT5eK4bKrmC48EI2fOXT2KeinRbVIrSJsf9ND8EnCy?=
 =?us-ascii?Q?E3VMRWKDiEZ2kjZRGovKNIk0GhAc1YAGRJ3/HtIeFTOTTJPE2smXdw8ebaAe?=
 =?us-ascii?Q?0MGGv2+J7tgjcWAzgbK9UFKghY9QO7xXbzprnpQkmm/fyFNhMIjZchON82z8?=
 =?us-ascii?Q?BSCTYzeYeG8UZdmTOPzKleHTSQfWSB8ac0bnXGVebFwRdUwd/yJPtWttkWPz?=
 =?us-ascii?Q?ott7By+o/Rr3o7SlnINjTeP+XOrQ4KHY4jlSm7tZwgMSYr/NHPgqbsXMLHqE?=
 =?us-ascii?Q?09vbSmGHlKbpRAwoQEdT82dhIjCTEbaBAUaEKI138kZsPCoAGBAQozEy6lbF?=
 =?us-ascii?Q?Ks/qkQBSVskrfqpmZjUJvzJh3ZVI/rxNAwW1Vpu3GvAeFACG+UoPJIe9QfNI?=
 =?us-ascii?Q?3rXZEyW8brqbTaKqvna1SGSmI3XJyhquaVjkfLX2+HCM65febKnYKRC012Ws?=
 =?us-ascii?Q?T/QBLn111DK79DHgXLAobqBx1t7zAPVfNkvT0MGapQlY0inSaM7sUHJAVsh5?=
 =?us-ascii?Q?FucQEkLq8I+Wl0OtVFdrSdRJ+3WsJi1krsI8z1OVhb7hooZZ3nxqHS6o5lZ6?=
 =?us-ascii?Q?aSviRquyi7zmLf+/cqfyeEg6x5Xszht5SsDx5uaxOwiqBI3dcksEAx9gUiPC?=
 =?us-ascii?Q?+CWqBgD1mrSVJT0kTdusMp3uADdZZtRhhkafFyxNEubwEmdNauUcuWZHowGA?=
 =?us-ascii?Q?4h7rb9U0kkWh6QiqQhp0ybPk7OuECl2mXw8wawp6x3zvV0qiSYJEfr22p9fJ?=
 =?us-ascii?Q?5B0JdBuPmfV/J7DzwBUZL+cKi5z8cac+DLA8wEh/POKCEsSFJoZVjgPjqzzF?=
 =?us-ascii?Q?UGF0I5sghPfnM0MAcxUxwyFR95LWd2K1N/thuI4clBLdlARacblLYM2Q8Ykp?=
 =?us-ascii?Q?XgULc4H7OzKWOZ9BH8555KSYjyD7VJvJaw7R4Z7NwR/AUlZq3kW/AuNK17fn?=
 =?us-ascii?Q?FVOYkPjRceGzb+v4TlMU3RlQavyz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GsdpG+D7AL/syywhHeRxtTDI5IqoUe3nsNehjPZb6yJoiTz0ctH+BK9QnDlV?=
 =?us-ascii?Q?Gb9OYRIfPfMK/3wFBtP2kABOTsfQClmmoEXC0CIzUU9JlaJD7Z3hRVN3qO70?=
 =?us-ascii?Q?k5Gi57Ymqct6DmREYpFincgxE10ofoscd4Dy5ZC8BqC0Ll+otHv3Eyni4/Aa?=
 =?us-ascii?Q?N/8kXDUwxzBQw48XXweSQ8BbGGy6VjsG4aGTOTSbNTqM04IAz2akS4jO861y?=
 =?us-ascii?Q?w2DNWxwriYPzWrfKIJBi7RWsnJF4b2QtKRavcxRusEey/BEWi2i6ud06hhqt?=
 =?us-ascii?Q?gz2Hf89GQS2zMC606KrzL/gQTEbr4wcZvdrvHAmp2TVH5U2RXE8UL0gXtV4q?=
 =?us-ascii?Q?TgJ8K3G9AOKaSoxKTMpeUG/esgXeOzmR60s1CdVPHGZPxJkCoKCVqoL1h7Re?=
 =?us-ascii?Q?LVvRIbBLEzETxrsQk3MQkI2NPiev7M6jd6IoDeCE9yBrmcy8wUiBlVK74tN+?=
 =?us-ascii?Q?IObqq13KAprcr5vT49LcYeHj90MUCGPGyJ3q7RTk7rSp80r/k2gbLsTGSVsg?=
 =?us-ascii?Q?lAjp21UVJjfp3hq5RprenIUqiYvX4FzsUY63fZUYcK+oOWZqsGtppO1piBJV?=
 =?us-ascii?Q?1JyNqCAAQ8VZ4an+22sPwTk3606PbF5BxBe5t+OZyevw28HIQ7x7xO3i9+au?=
 =?us-ascii?Q?jOWRXToREe29BY75v/DkDXAOubbi+JlcF3xnt51wtRb3Ree/+vTQmLrhozvR?=
 =?us-ascii?Q?cJqb8jI32dyRm0L/vFaUtDJxKpPvkgY57nkSbI8Hi0HmkmEDn2SoFE+FJHL/?=
 =?us-ascii?Q?Po3947tJRMd0uYY7VQyY0S99GMfl1OndufQnG0iTeFOr4DqY/Bc9o997Orf1?=
 =?us-ascii?Q?MIfhouVDzN/qgT//f25/4PQW8q8Ug3ld4+MQGJLmhQkyNGuJypSnM2VU4Uth?=
 =?us-ascii?Q?9z9w8qs0+/jMECMzsq9+8MOtRKdb0OzVpGn3iEqP/s9ojgv7Cavl4FMKwVO7?=
 =?us-ascii?Q?PiAkkd4gdXTrBfI46D2hgqxllNkKGbHDdDlAwK1QmiNVhGSr9p2bvOJa7k9H?=
 =?us-ascii?Q?YmA+uKt5qCVXtNXMlryDFiQM3S1ffIlJgbqUtBbtNNdTGG9xCRejdffBUNiZ?=
 =?us-ascii?Q?KzXbKjp3f9Tr/dRq6P41LjgfpnNh8kJuMYF5mz+X5yySSYXep3iWhHh8nhWk?=
 =?us-ascii?Q?5CXMTjV1tweEo0XcB1/HAA2LQES4B2soVPfZA6KTD5RRFCxaNYhVSw5Z/ydg?=
 =?us-ascii?Q?++vqfzI4lZSoeiROrYRAFshhWqZa1Oh1DTQ/4ENh+so9G5ltMpcjXT/ZyDW2?=
 =?us-ascii?Q?z5mnIS1+Ea3MLMaHPktfEpsyArUMbHJS+UJk5IcQTJqr+fwdu4T+zibz/Nqi?=
 =?us-ascii?Q?pAX+qdBpDPtE0inBSILKDOtj2WPp/Z9T/CwIpPbab/pZ4M2t0uEA/Bc7ovJe?=
 =?us-ascii?Q?8loQh2mI3w73SRf6TXpV0vG9RNjZAfs4Xj24sIADmzc6D2isUbk4cGTMjhy/?=
 =?us-ascii?Q?9dcuu4QMOk3Q3fKXDFMrSx9APoMeApz3heFlf3oZKzHE3hYEqrmHSGl0yBIq?=
 =?us-ascii?Q?5I5Q2a/l7+xUBVCZY/w5G93ihOY5XK3OfgN6D0nZS79BqwGqoC7b6L6OCiIl?=
 =?us-ascii?Q?yjz493twb6ghKAajoqe0O29+RyM6ebq1ea4R1P21OweiOvbdq5+F2YlcbCSt?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JXKkiIt919S4w+rAsIb3NStd7QxxUQRPwUTqW+8R4nK7zy1fnClO3huW7UyaIEsTKqSLTd5fhRDn860JdeVIcWoqloLGc3PTwJZ2pi8V/bL5VLcHs3a93hnEFjdBSVkaoHsRo8+f2fa5ioAc22hLWrXPs9uNW+U0I922epVvaE+hSJ9FZAluOXUDAkFLIzl0cpiNj4H1dHb5GKWxWtl6t/Ss5zb28Suomlip8XcoVhutAtUPy0IJV/MHgWf06y+ErmlRdIiZR0uLn24NMK6s+nDEj+6gqdKWEdmtV/BrkUDiW469bgTErxFWhvxJyCuTgqfXfeKq119EZ2XesFCXd1RZ7qet5XfToIPhkg1tBZkR2dL6bIkdDkkxQ2rVD/X99ZfLtArcyr/nQi2O1g+N/oiAODzatMcAoDImAl/2SBQCKlXdD66VA8p+pTM4RDbxhXF4RmUeqdDRU84Ye/TZL35EjzVIeXhZDr+0klDfAHCzp6bDrno17vQy5xalI5zaVdPs1jgZFEV1Rs/kaYs3tRjzPFIsra/m1C4x8flC6CHAsGHgmUmc1t8UJvYCOrSyZscs7Yxw+0ZRX2JQFNPQ10+gPbOi9jnW7UUXMvT068k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f67596b-c2fc-483e-f3fa-08dca7e0d423
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 10:52:05.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Rn2sZSW2TErldHr6V+noOHL6gZEXRpvkuU48tutSK0xyjHjuZoTS9wyKL90vLS/+eH8HnZrFPI+1trAFSqlH+z2u1fGng3wUzSWHJd+bbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190083
X-Proofpoint-ORIG-GUID: afEk7pIQSQP66I--F56PJNEOIRDuJ9j1
X-Proofpoint-GUID: afEk7pIQSQP66I--F56PJNEOIRDuJ9j1

On Thu, Jul 11, 2024 at 02:00:15PM GMT, Liam R. Howlett wrote:
> * Andrew Morton <akpm@linux-foundation.org> [240710 22:54]:
> > On Wed, 10 Jul 2024 20:32:05 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > On Thu, Jul 04, 2024 at 08:27:55PM GMT, Lorenzo Stoakes wrote:
> > > > There are a number of "core" VMA manipulation functions implemented in
> > > > mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
> > > > expanding and shrinking, which logically don't belong there.
> > > [snip]
> > >
> > > Hi Andrew,
> > >
> > > Wondering if we're good to look at this going to mm-unstable? As this has
> > > had time to settle, and received R-b tags from Liam and Vlasta.
> > >
> > > It'd be good to get it in, as it's kind of inviting merge conflicts
> > > otherwise and be good to get some certainty as to ordering for instance
> > > vs. Liam's upcoming MAP_FIXED series.
> > >
> > > Also I have some further work I'd like to build on this :>)
> >
> > It's really big and it's quite new and it's really late.  I think it best to await the
> > next -rc cycle, see how much grief it all causes.
>
> Yes, this patch set is huge.
>
> It is, however, extremely necessary to get to the point where we can
> test things better than full system tests (and then wait for a distro to
> rebuild all their rpms and find a missed issue).  I know a lot of people
> would rather see everything in a kunit test, but the reality is that, at
> this level in the kernel, we cannot test as well as we can with the
> userspace approach.
>
> With the scope of the change, it will be a lot of work to develop in
> parallel and rebase on top of the moving of this code.  I'm wondering if
> you can provide some more information on your plan?  Will this be the
> first series in your mm-unstable branch after the release? iow, should I
> be developing on top of the code moving around for my future work?  I am
> happy enough to rebase my in-flight MAP_FIXED patches on top of this set
> if that helps things along.
>
> Thanks,
> Liam

Thanks Liam!

I think best way forward unless you feel we should take a different
approach Andrew is for me to simply wait until the end of the merge window
and at the start of the week after rebase on 6.11-rc1 and do a resend?

