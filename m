Return-Path: <linux-fsdevel+bounces-57992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7C9B27D77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FD9173959
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4A2D8382;
	Fri, 15 Aug 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwfKlMGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mrQpk8aE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868A27147F;
	Fri, 15 Aug 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251295; cv=fail; b=r37Qs6cP/GKLx9+XG7mrcupGIIUGNlV6VZeD375r+E0XPneIMtonyNxM1FcFPK0kMAg6t+GmiMY42tQZ2/YrHtkTcjQTWefnC7N7SDtQBw7RrVM33RBgeSOKWlOo4DmYaT39GPGvqwnxVyDpB9iK6RKzpgZy2LXpVFzx8ylslJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251295; c=relaxed/simple;
	bh=1KOKpHDOKIAbNlrZn+cI1IFVSfxytra2cwiJ1VR/l9g=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKEx0ASOtveyIG+J8SnJ9Ijr0St8SxjMTsB0cl/CsDT8yTTwPnb8a3afMHu2qu8NrkYg8MSpBaSexrqQUbB5X3RcFAnMUt08UvdEgBW5B3ZUR624EH7shprb9EBupRttTrq5loUlmQ5+57fM+kkBtP0bPH1xzURJexJPxN8XUVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cwfKlMGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mrQpk8aE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F8g5sO010379;
	Fri, 15 Aug 2025 09:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W3Xrc/DVc/S92zw2x2
	Y8LGP9Rz9xq6nPlwiy5UW19UA=; b=cwfKlMGQLghIA/EaXvEqBcSR+CxBj6PK0B
	kRpJJA8s9Q1gJ5zMDQEJO3IQoluqwVBgZhZFm22w760WJOUHGU3bfee173AmMM5/
	boUEX4/CIIychQMUPKWfT1Jx1Pl/HU4u1BSrVg26J8OzjbGbRjk9r8Zn520MixxP
	rQTdPWfNy0280mo3lxquSwaxxFuHHPlB0dZu/uxLKOFoGYhjBjaOdvM+xICet5pa
	LA7UBUKxwiutDLetM4RjJFQ5UwEvyOTPiCkklipY9gGJ38bJfkA0UK4YzTz0zkvZ
	41auv2kC59rFEetp5DTla7vl1lGAK7jAb1twOZayK7RQ/eXiEdww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvx3k47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 09:47:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57F7J5kq030396;
	Fri, 15 Aug 2025 09:47:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsdteyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 09:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD1nMITJN3KWGtyzqwbfiWuGXQ5h6HhYIv3LzBEIZZmBBPaXoU46V3v0lFfQKpys54MdpgX0Ta1fZeKVd+LObP2Y+mVLPJ2ZTRvSNkIvMX2mW/clHw1+zSrJm3LHpNTLZ0FE4UEssLj07CYuiQAIcFOyLY5ha3Ree2MR0NNuV/SYhAw2WcZquurPRN4W/tpsXDgXClVrzS1GaHW8hq+7rOWffIWSGloDks6duIstSeC40R12KR+mJ/eer2JrzXgtUzbk6tWkJNnSyhrSWYXAqJTxRRuiEDcDzakZcKd5I1dUGWpvksQPDjRQpdeGrNLHAM/xOPdJFETpmmwiKY169Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3Xrc/DVc/S92zw2x2Y8LGP9Rz9xq6nPlwiy5UW19UA=;
 b=lN2coCK3k0tP2qTVPZ43JJDu/JnOTA6FYVmhhvk28RgJQC6Rh4XGPgTFu5nxyJTwgoFeQ2mGBN88O08XQ5luNKqEAypzjPdBEj1V5tUeskH6fseTq4uaCovwcf1doJj6V42mtdsnseIopt4BzQPqzlj1ZnyCPzVAdfCMnD0YBNiHwxx+wNb0ffn9oNjGat7adDe465R3wrnW2KHeMp1Y+fEURsEdOYhjzxq5f0L/Rpd809ysvyckciGhe49mSZgYSU0P3KyL0AtS/V0Yf+ppaasbwpJpFyi+g4TzlLDWgu2sAq4JObp9iuUBk6mXKclTcxtUFIoL000DmkLA5IDR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Xrc/DVc/S92zw2x2Y8LGP9Rz9xq6nPlwiy5UW19UA=;
 b=mrQpk8aESonKAiy5FSDnpZ16zqLRdgcn2gFGYUSaA1Wr0zFUaxSElo0K6LpNLygHnoJHqXxDEwa8cPJPuyH05V0ae6vXJa+2IuNPyJj02TXeW314w8jVtyEmXaGERiT8rybCLs6f7gCqbhJa+2ISAA3wjSeuPOXyeheaBFv1kEs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:47:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:47:53 +0000
Date: Fri, 15 Aug 2025 10:47:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/radix-tree/maple: hack around kfree_rcu not
 existing
Message-ID: <0a3e9837-0e45-47db-9e24-2f9099ea6075@lucifer.local>
References: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
 <kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
 <20250814180217.da2ab57d5b940b52aa45b238@linux-foundation.org>
 <wh2wvfa5zt5zoztq3eqvjhicgsf3ywcmr6sto2zynkjlpjqj2b@bt7cdc4f7u3j>
 <97e3a596-ca5c-41ec-b6b2-8b7afafca88f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e3a596-ca5c-41ec-b6b2-8b7afafca88f@lucifer.local>
X-ClientProxiedBy: MM0P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::8)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3a7743-e2e5-4a08-e0f8-08dddbe0ce24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6jmnOSXAU8s+FZA5ej8XaK/jhSN9ei9t1YXoBRhWseJRfrV90/7/OTQqS+l?=
 =?us-ascii?Q?uVR3cnCDRVW+Vtwa2Ji4SZvWM7AMOo6Zs61btlYPjVaiMsJNGeOGojFLFk/D?=
 =?us-ascii?Q?L5jc36drnrOB6W5AQafcFntVIXbWpgCVZJ85C0t7Hv880ACZCj1yH6r8Rgvk?=
 =?us-ascii?Q?LV2uAFzJgOTcINuTqbvGVJK8Gcm8753Lh6KsHzZDKDRoxXcJYf+Mw87zuBvn?=
 =?us-ascii?Q?BqYv6MJy5IBIzk0LLVh6gQRNFU6pdCyVpQB4giuta62PCLSYigF8cH2DCQQZ?=
 =?us-ascii?Q?3KwsGRUoYdiB1jgkTFIlAi9+q3HLOml5/2bN4XV5IvUOW+MLu4FvEVTDU81M?=
 =?us-ascii?Q?SX4BiymeErcQlr5OlspoYRfvL+U/YmpJaUPprqwpHyrUre8w1od8/9XoyV/5?=
 =?us-ascii?Q?IaHNEV2O76FuR8+Q2x6/zEvjiXkp7JciFHrQuoy4f6KTAJCR7PJPVZDtFbh8?=
 =?us-ascii?Q?NOReOCOxekpSBopEpbsHD5GdOe+O8oBZMr+tEA1uV/oylt1Yj/lzb8I5pUWT?=
 =?us-ascii?Q?bSRkSmh5YiIWiMni462MLDRnzn1T0g7jzRdsv8fWxpNjqFgRUUGpdF/4sBle?=
 =?us-ascii?Q?5usR0/mG1mWbJviB9URhEq1rBsjry+H2iscRplFnZHsDukFJH599PfLuoXuv?=
 =?us-ascii?Q?/OjEKYkdIzqMojnvw8hy3uyspruBkbiubJ6LQzz7qXkxwaRDmxZaUmlrezBO?=
 =?us-ascii?Q?K16+0Q3fHI1LjhxM1gtA+57WGUk1IY8iSiQm0AqsWRHckuWe2+kwn1a2yYFn?=
 =?us-ascii?Q?YsSYWn2qLTL6BdjFSahd4LbeTps/QEk7r1wT9ddFJH5RGYAfBU4w+qftBK1w?=
 =?us-ascii?Q?f9OkcJaLKpkGCuB6e9h7oq4xlT4RM3vAvam26ZWUc/cG0JJNhfgaNTHESu8M?=
 =?us-ascii?Q?fS6a6e2JI8z3rvyUxs8tMGu/6cJ+i/GcGw4385CoXceNKbPDTTAmSo6Q7SPC?=
 =?us-ascii?Q?bsT1tcdEg4PiANSTl+defULuneWgYJqMqSittvAR/Y09KJRpOlLV5hTVoqc3?=
 =?us-ascii?Q?0wgQCE0BbxNpCsS0dA4G3YVWAJI8jm8Q5qyBWF1pLJxnJulOTVp6pzIY5yRI?=
 =?us-ascii?Q?1wcoft4ceN0YdpyXVQBJqpRhEz4klG7irdvKHKH6DRaG9eWjBXKmesEvBcHr?=
 =?us-ascii?Q?ZISZnKsDUv/Y1B4dKZSlErFbYQ6LOMWFXfLPrjD72HHhKOh3OFcLcwv8m6qB?=
 =?us-ascii?Q?Bf3Aqu37tM35fpjLNTmJ/kJ8TX6uCYnVvfT8Eb6aXGXA6s0e3LA5a01K+h4N?=
 =?us-ascii?Q?i5bBEUL9jkj6cWdcEm7L0DNSbL/oJh5jQftpvFd2rZKG3NhkksQC18luR/LD?=
 =?us-ascii?Q?IyHpsOXvdidfeBMjvoQRgos+Zalc/OCbP4Iw6OINACfNUxGqQX8Oen/1c3+f?=
 =?us-ascii?Q?qdlh3Af6lCEXkPgXv3OsTbYbVbw+mw+hHy44DJOkPhd3eMnTNUVvmQ8PlOcQ?=
 =?us-ascii?Q?eSOEZsAhm5MTY9XP+z4SXI8Fy8Ak04/ZfyZaSOMBQqknpMGZZvDkAkzO/UKt?=
 =?us-ascii?Q?GgTEa2KAOmraw9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9/YBb4toS8mDK+9NlEvUZeXse6wlGLeCDl0IEyxhmFzlX1vbSSgDXzazIY/?=
 =?us-ascii?Q?lOFg/4Odvf8e5amBDlcwSO6ms7JRH5Z7BvMwgG814Yl0rwYt2MtvhOJgXhJL?=
 =?us-ascii?Q?xTmuYFBDgIE539SGLuXEH51mCBY4tUzr/V4/s87/m8YwkSKOa+ga2b2JSRmg?=
 =?us-ascii?Q?CunNjBbzgIYgkTiFmRptgvzdArYGmzesIRo3kDdvtvNlcuDB0hA2jWGyve6v?=
 =?us-ascii?Q?smTEyGcY8A1Bi4lz0H4aHNS4whv/eOgEkV6hHZYI+acfyav7m2MVmVT8bRny?=
 =?us-ascii?Q?KSh1jSbMGochMFTyOxvyUMsDxza0sl5wIIVNvhsuGEmpYh/sIoMkB1o0q4mu?=
 =?us-ascii?Q?nAwXjsud9h/lvmBCyDeFa4YWd00CRq3Q1kgyGQRczTSvCNh7vVwIxPHh3LOL?=
 =?us-ascii?Q?zpFgvTrurRnZsaplUGhLzzkdgblAb1Gv/gIdhdnrZCXFqqsbpaAdk6ZWOMik?=
 =?us-ascii?Q?mBsbXa385tDMg8mFtMlknX9JKYTsbTwi2DumilsSTqsjprzMj4bPM8uBZYH7?=
 =?us-ascii?Q?TDQgu5aKZ5ebL5DwT3tamOi5y7L4FCvohaKDq40kt7BLQNSBkpfoBCyWoBDo?=
 =?us-ascii?Q?GvllkBkK5QRN4nl3i8fmZcwB9265iKunx5jrvfq761etPKPRP/XyJDwItZxq?=
 =?us-ascii?Q?L+iqr6rP18hGQdOOzF299IyFWm77qRIRgGHAvzMHF7BRb4jnv9Fz13ylnEOY?=
 =?us-ascii?Q?/ECqHWiMkhIuQYh+8DjjCEuQBD/Hc/ftnOIUhiPs9w1LalL5WZxzJao8meus?=
 =?us-ascii?Q?whVfQIp5BBtO551+xmcYmzGHDBzhpVZqNkaHKgwiFWWaEB9bubluKaRu2RX9?=
 =?us-ascii?Q?5vLJ3xtIdlhhSE+kZvqye8HIlQR5kddZlzY+AgAjINPDXotpecQF33aTMUSM?=
 =?us-ascii?Q?RD7o7t1sgH9IxwLFQTCG7WxvPtPumgDhjcFUI85n2s8Otye80Dckg66ABhte?=
 =?us-ascii?Q?Bzg8pQkOMxXLnLgHYzFyEwOvvtnfFpMyO6E/PhW/b5AVcXBu37ZuzpIyIOle?=
 =?us-ascii?Q?Knmaochu+gN6ZpdHyKWHF1OpKmg+PdTVX+DhLpEmQekEzHWKTxwiZR8pd8Ll?=
 =?us-ascii?Q?gosf7u70NG207fikWz0gUsylcz/mOhVSHAEOD5IkvzdwfH7F+bxTQGlQEd5o?=
 =?us-ascii?Q?KAoD9NjAKRnuQVZAYR3BecNUJR+/4TTxYfKXgdTbIbDkEwRApU8zs+ZOR09Q?=
 =?us-ascii?Q?hl9EvN0xOmM5qUSCu2USfOUk8cs+EeN0yR1HBDl/PrQOB0/Pt+SCOszaL7GB?=
 =?us-ascii?Q?P86qArbUzLeKk4K/ocLBVk570lsRBXI6ekukbcw3O0SG9vwLIrDn8gPSB0bx?=
 =?us-ascii?Q?Jjx2fNsFdYGi8msLNd6Amf3Qbbl3xr0LVVTZg53Ibq/ocrLpjc8TAxEuwt65?=
 =?us-ascii?Q?J7uBdp1pys+QOEXievIRgRt4rGc2hTLAj4mu40535MnCUIKQ3iR0URxma1UM?=
 =?us-ascii?Q?L3LzNPEA/p4Mp6t02OsdkmHcavsfkbNY91b/l66btnr8nexaK02z98v9o+iH?=
 =?us-ascii?Q?YxCSyc8QFnlG9WD9IiyX2nLCtYvFhQLmP6bNqOQD52QiwSVEARqqQzxES2fl?=
 =?us-ascii?Q?imaGjGJb+h1xGqp8nhT5PVMKOV1znWMW6czYaanqTX7iKzhp+DDDvCXHferY?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qnykYZML41JNjS9vEd5pKspIfh/2j2AN+M6KiLaj1hMPg8a+Al/RintNEMm7tXS6W5TijAns/P+qFKs9806Hc3uyHIG6hNf5R/AOWm4A1dwtXo8LAXvyJyguy90Ia4+9NB1K8yAbk0VzsAfxsfODF6sgv0vOqHnc6H2xpHEcxr+tgm21PIjsr2JBz+fZQR99o0tXHD4Nek8EFqUR765LnkcjuprBmieiIkSzrVZqV9UUw23p4ZaP4CdLCWSGI3CuWONRz2OpP5Tdq7ILGtzl//fe1t9KYA8zCoh806/3I+tPweQexaRHNfq3jDh1CYPnnEY6e+dfl6yT3RMxS0Mqf4RiSpY0m7OWwfN8vFWMezefw2pRc0FwjLKUvYzLuNQEWljSK9y88W4CkFgyClcrYUv2Eb6S8HmWRTOf83WRf8uysj7XFJCIKQTvtExws0vomaGVYTXab7B3GNkGhrp/2O/dl8r2GheVoAtKDE57RuYdpLX603gkZkrh5bcIAwBeDFBMtl4lIMuPG5Q7BDV2cCkRUtVCP1rHhoRXwT5dxs6Ed92aRXjnmLUwbQ0IMR51qsW/nBZy3kERrqfDtm/Y3q2dRawZAXzha1OdkeD3DJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3a7743-e2e5-4a08-e0f8-08dddbe0ce24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:47:53.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZlpraM+I+kgr+6ZbQI7r+V88rWXRVv2odr98wB2+QbYeGXyTOWH/IZ2ubHchR22dE2j3MTO7/axqzFbFBRkoa4VI5bz8mWWgpFT2Yg/f6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150078
X-Proofpoint-GUID: rA59Gxm28YTgY3MNpaHZnynNlwyK63a_
X-Proofpoint-ORIG-GUID: rA59Gxm28YTgY3MNpaHZnynNlwyK63a_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA3OSBTYWx0ZWRfX2iNUWbX6b4su
 49dhnntBlhmehnmHtOrZOt+QsHH8NBQUv9Sjf+sNlCW9X2Wu5qDnnhVfiXGZusorrzkh2Y/5BEf
 EKyvxw9F9mBWf/liAZizqvuPtI9isaCDOBIfgVfgU9Bj5aN4lN1duaG3ovH+x/4anUBzJ91jOln
 2Y7hY9pZfWi0urgkpzhnzVknkakv8WZm9iAu7TjLyruCOkrV68mHMAQTXKfkGBtB9rJCrfANu0A
 CR3JOtU/VINMrTjlWVVkAnnCEwWmNw4csS3nW6D/gqHixaUiToMfMaq9GCKxKnpoD1KM+J0CHOJ
 I7Axt4MSC5OZ9yy87XHa2vQ6LWSfY3xGTpQ2tUkPuxDYbgMb4WY5soqWDaVv1D8Ap9MW6XU2bBZ
 12ZnvjBCeiHo3PqAIYVU+116QRdeC323OGyDeLPgnTbufP+lT+muamrfveWdsmetZ/jpetZj
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689f024d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
 a=APn3Q-FPb2jb5AWkj-YA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22

On Fri, Aug 15, 2025 at 05:28:02AM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 14, 2025 at 10:09:15PM -0400, Liam R. Howlett wrote:
> > * Andrew Morton <akpm@linux-foundation.org> [250814 21:02]:
> > > Well, can we have this as a standalone thing, rather than as a
> > > modification to a patch whose future is uncertain?
> > >
> > > Then we can just drop "testing/radix-tree/maple: hack around kfree_rcu
> > > not existing", yes?
> > >
> > > Some expansion of "fixes the build for the VMA userland tests" would be
> > > helpful.
> >
> > Ah, this is somewhat messy.
> >
> > Pedro removed unnecessary rcu calls with the newer slab reality as you
> > can directly call kfree instead of specifying the kmem_cache.
> >
> > But the patch is partially already in Vlastimil's sheaves work and we'd
> > like his work to go through his branch, so the future of this particular
> > patch is a bit messy.
> >
> > Maybe we should just drop the related patches that caused the issue from
> > the mm-new branch?  That way we don't need a fix at all.
> >
> > And when Vlastimil is around, we can get him to pick up the set
> > including the fix.
> >
> > Doing things this way will allow Vlastimil the avoid conflicts on
> > rebase, and restore the userspace testing in mm-new.
> >
> > Does that make sense to everyone?
>
> Sounds good to me, I didn't realise that both the original series at [0])
> (which introduced the test fail) and the follow up at [1] were intended to
> be dropped, I thought only [1] but dropping [0] obviously also fixes it!
>
> And it looks like Andrew's done so and tests now fully working in mm-new
> again so I'm happy :)

OK this isn't the case.

Can you clarify that you want to drop [0] and explicitly reply there asking
Andrew to drop it just so all is certain?

Because right now VMA tests are still broken in mm-new :(

>
> Cheers, Lorenzo
>
> [0]:https://lore.kernel.org/all/20250718172138.103116-1-pfalcato@suse.de/
> [1]:https://lore.kernel.org/all/20250812162124.59417-1-pfalcato@suse.de/

Thanks, Lorenzo

