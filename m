Return-Path: <linux-fsdevel+bounces-32365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7939A4428
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4941F23F19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF62038D4;
	Fri, 18 Oct 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kopaCg16";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JWXCVVEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D067201273;
	Fri, 18 Oct 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270261; cv=fail; b=AqmUBeOOTJv57wOV2sHSPBdohAHl1yscBmjhVXfl81Xf2gS6OiXGyaIJ8Q465Fn12WVvZyV5SPWDrfFxf8Ieqj6s22fiZMxkQJf7zlIv5AorrdlmUbUvYipTroIKY03cz2sM/bv8CFcXV2nGgPtuz5KHjQVnwsOojpyqDe7thA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270261; c=relaxed/simple;
	bh=Sa1hGWHRTGeKOiSlShlBaYZ+LD5kXHWHZZ8UKlbl9Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zyn4uMwKiG7jf0J4noc3ZIbqAkEy/DnDEa/zJEgunkifxpsTzgnf5Gqafw0AYm7Ly2kjE+irQrgwZOJdtwV0elYVP7G2i2WpP85sLNIV0Kz4SbUyvt2AwqjaQzcvVyh7cX/2asQY8/LE68qgm2fpbwv1jmufoD9Hm/yEZK0k/F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kopaCg16; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JWXCVVEw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBdDF017100;
	Fri, 18 Oct 2024 16:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ci22HYuBuT/Jpcm7K+
	FNohtAwtu7tzNl4VhumklXL18=; b=kopaCg16hUCWLbuhup5Nq1MrOlR+VGYQ/3
	EGaGrAUN7MM/TqhG8uxWl1BywhfI6d/mrvoU0SSF8Xjef6F8+K74xUPYDHzk9Pvi
	4NSSjXJopW5Znczzkfw/2vlVhQeMrMDX11POMbRIQ1kX3np6LVlSZsyeq9Kmp8Wb
	h3Rkq7QGeW9P4T69Ngd7Kzw8uEKL5qqE1KS5MwH5CTQ99MwYE7jtRYUN3Cd/1gzR
	Oabumy+WB4RRl1tqPTpQXVkb3RCvfkK+wYUaZtUjT0WaHVEhnQ0sarhhkVZJuzoy
	Day7T7GoiFb15YeJ380Hn3/1ifLeXD2khPGdetOln+abKI/okdew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnth8qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:48:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IGdsV1013876;
	Fri, 18 Oct 2024 16:48:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbt517-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYcxVxOLXs3YPAfQD1yf1TMKaPZEUAZ8u/o/0fJyw2UZuU3/yWEAuYtiJZLAEDjelhn1AMvEkXLzljg7O4JdH8YXKj4sNB4H8gltLCKc5FScnzZXtvFHSYy377hV/jHtVQfjPyZ+YqH697+gfSFXa//wV9CI75aIRGB0CXcoktNkTba3i4PUrqosn0x9PqKJ4LR2KBG4R3LMc2LOUBQf0ZGjfplPRjVg1Bx0HzDJ1Ug5sRjs85JxTyTgjAqOTHXbcTAsS71+lx3zF65uvCJnPib9HI0iTv6p1Tp1Ln8eiDrdPTsYCvZ6lnG2EUvAWSzoRoPqX3neDb5xNQ0k9Qp5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci22HYuBuT/Jpcm7K+FNohtAwtu7tzNl4VhumklXL18=;
 b=dSUAF7yeCeXL7dUEyBIo/bkPFxGeyhhvEuOX/ifccFLowqlPfGW2MoXw0Qbd1F2NmEGE3fmae2EUK9H7w7XBMcQEhO9aKyPqYd9WpG8SiDCm5tGYg6Mjv5saHee+6mD7zk1vrsF2xbm0rbNsU/9NF3DJ7tGJdjWgZuLHOzb+0YIaDiQ33w2Puxccfg0X/g6yZ71hTFVugaMBlFCPWZWlHAWRo8PeZPi5dS4Nr7/i/oyrQNiXXr26ewWfBOmSFQNLAprfCmM4Ip9ezjqV/WojhZ4ST3QsxA5B8DMs6EdVZQFb4tohbaPYmRH/2Gn5fFIk8P83ngDCaa/j1xZN6oyMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci22HYuBuT/Jpcm7K+FNohtAwtu7tzNl4VhumklXL18=;
 b=JWXCVVEwEe+g1fEcpWhWsU3ZqtKV77pkZ3jOxQsnynuMbhfN/a4icx2JQmIwmKb9mM1sRsiKz5yEuX4nud9CSoVZ+TzBF+7jfrwUJKi2pM/HUFp58zsBpDs6hEKtOwgagsdmCzTQPDVv4ig9Od/sgBtaThpdhpe5dCQ6XIhFT3o=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 16:48:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 16:48:20 +0000
Date: Fri, 18 Oct 2024 12:48:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ebpqwerty472123@gmail.com, paul@paul-moore.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org,
        syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
Message-ID: <mbcl7xg6sg2dbycebfosbiakj6evwft662oaqgx7h2vcccbky4@obq6x72ek5dh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ebpqwerty472123@gmail.com, paul@paul-moore.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, Roberto Sassu <roberto.sassu@huawei.com>
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 158bbcdd-3d97-4c90-67e0-08dcef94ac5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BLQ/gL1sBMAsVOaKCdL/IjtvNl2doHakS/tInChJMk0PhkOanF2XQnUgLbL/?=
 =?us-ascii?Q?n2Qd9D7uF9oX5ZGy4v/qrf23J/0lDc7Tu7x59AjdO5slj1IlfpvBlDfiapfE?=
 =?us-ascii?Q?Yg0I3npoYV8VuT8I1bSuYWdwA+91OyFZud3LUrzrjaCgluSVp9+UbqgOVCW/?=
 =?us-ascii?Q?+DrLuXIGcjxDG4rMIVSJz8MPpC6u5gv9oJuTC3GqOt6jVJ9VCGn6WIW0Vmnd?=
 =?us-ascii?Q?/3IekTniUE1/G0jaASRL/WYNMpWBpjwyQN1w+JoqJkLJcmeRfshvPuCkjc9A?=
 =?us-ascii?Q?XYLGxs1Mq5Rr17+jhpWCTRqlGYiXYmmnd+1dF1QGAaZYRHPcxWWIQSrl0TvG?=
 =?us-ascii?Q?n7BurZjUSGtEfhmKOSDkyX4CXK9IQklijPdBvWDU9qmhlOrJ9uP9OaETiHyH?=
 =?us-ascii?Q?NV6sxHT/YSQ7g3CLI3aM49UklAKD53UVe8aC9NzCgt1v4iJl5RoRB3W3hl/4?=
 =?us-ascii?Q?BK1X/E3exC7SMUm9Drs7Ncp4HoCRRzobjrw/FBOiLuTRAUuC9N5n36WrFWxt?=
 =?us-ascii?Q?PBzN//vRnZidKq/byoUl16QsoXI9VcLJSW7fRJWxowYPJYAGmfDTZTIgLxcX?=
 =?us-ascii?Q?mZllztBwV9YIj/q2fKE3u8+DMhTREJA//Auz+7K9V7W3t/s7CXrq++xInDNV?=
 =?us-ascii?Q?l38YU4vkXX+AoyG2hMHRZ989ziXeLoKF+RYGos95riUH/NSFW3XxyWhioLc9?=
 =?us-ascii?Q?7pmweb5Y26VwumXTWI+G6qDO0/1outn0lDQTwWNeRpXjVPbRd1OzVGsQO2jI?=
 =?us-ascii?Q?piMEdTgP9ehVZ3TdsM2axOYQTbWS2ajI51Elcg5KB/94z9xOxqzvI2T3lyor?=
 =?us-ascii?Q?bIaCTnbnaIajRrL9YLvkQQwXeFzgv9/dUSdM7Fgmi//+UyuFSURYFq8gYuWP?=
 =?us-ascii?Q?+qMLufTeyHgoRgomlNHTDoGG0XWszZbqyV62z6tbK52Xz07Ou4Ax1aNP2ODN?=
 =?us-ascii?Q?tVE3NaBqCw9DkTDVQFzES1v8HswkzYEmW/fQBF+dh0kDo5qJTwW4NUTzDK1o?=
 =?us-ascii?Q?P01t3mWhcW7uWA8Eecd4QBFv+Zs+7+UEmUH35w7DuGIihHgQSj9hus2jZ6Ui?=
 =?us-ascii?Q?4uobEp040jwn0OXcCuW3WIgQZ+HBem8k0BZ185iztIndtTkDVvlQXhnLEP4H?=
 =?us-ascii?Q?YzGLCT2bFaDDZp1c7Stc0Hqw5yae8CfVJFpG78lmT81QlbjPeDbEy/Kd5tVF?=
 =?us-ascii?Q?3/DcSddqFSnksroDKiv4vz3pD3LZFySMe0C1GjUtvmJ30UMhye24miVHm1ml?=
 =?us-ascii?Q?W6xQNSKT4GTtLEqbqVTt26/FhUAhK4mmYf6CDhsfR4DUkC9qXCBYR+Qk6TBi?=
 =?us-ascii?Q?6EEoWCgsoS/hhPGyeXCLidUU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36gej68+uPIKJqm9JsWaBa6k3eP5kA9esoeA9ZNasjI87GSYTiCTxfMc5LdJ?=
 =?us-ascii?Q?AXaS87VN7sV/bYOxC4dHRq/7vYsjyiCWyfyObPiGRPHCWNoBJP30achGZYJ1?=
 =?us-ascii?Q?u2u+fFVKDKK1e4BkMyBRLT4O1EQeN9Ff4hl39JJScwc8yAsgoVSDef/7gmgo?=
 =?us-ascii?Q?zMQq3nI1E1kMbWFO4OdZGMzllOIrWq7+MjVvcKjvjXgSYfh5xBmDIOySuNpt?=
 =?us-ascii?Q?zcjr3Yb93ucCy7BXKiQb8awI3D8733V9kH0zM7j/5bPbXju/zJEwA5HjBCKs?=
 =?us-ascii?Q?C6y1BcraME1ROARAMJoeFyTPl1b1oJ2kWmMSWTcJSx6ShJj5oG1yqs3i9l9K?=
 =?us-ascii?Q?ntb2gxqj+noup++GPkyf/DS7I6o6NaK9l5jlFnAXlRxpaEzWBWS/8+OMoNpj?=
 =?us-ascii?Q?c4B1L310eX32qeykpo0Sc1FKesgDxMMVCoWxJ/S7pgI/f6+5TaLwdAlI1Ztm?=
 =?us-ascii?Q?FG5NywEujmyLo50VvXcqqDV6rHwcpXfemeg+7tXmj4abtgaxycMR6Sv0xPgQ?=
 =?us-ascii?Q?6osTgSTQ/EaOh/fb/bOVuqMMuiU6+zAK33DIAgKTNezxs0FSeaLTCu5cSHXi?=
 =?us-ascii?Q?iSbJLFRX/B7MudZnrSxtWIlVLQdpD5YK82R5bp6bfySx4BXwOyvM7QfUaRyt?=
 =?us-ascii?Q?HF4bfm6Q1E53haRs18neVDH4+tlALhpThwqgioTmnTNNT2HvJ46aGpI/pe1g?=
 =?us-ascii?Q?a3Ys1cXd4iplAwCksaheFttoO2LLjG72NNMprHQJC2/kjRh+R5fcgVnPmmTu?=
 =?us-ascii?Q?Y2ZryuDnhO6wFdDWgdmyinm0ixiLyox8yqZEWKFXiSpW1XxmZhjg3YttsM0I?=
 =?us-ascii?Q?Ezm9q2Z2tQwypT/fO3IM6CYwCkmK56DrkYxXji/RknafeO9SNYPsz1IwOcC6?=
 =?us-ascii?Q?yF5Y3SiaBAVSwYq7l6NV01KVAacJMtGf2Ns5Px3IA6+K9GGY1AydpQvS9Kxt?=
 =?us-ascii?Q?C3kmmilVL7L/WFXXeqMHszyEp+IyfiQ8RapzcoT6B41U/qSpimT5bxEBJadh?=
 =?us-ascii?Q?A6RpUNBxqXaEAMC9/IsmkZIfFm0bONT9JC8EUUgyGCPPKOQ0B29ou/39L+y9?=
 =?us-ascii?Q?+4OrySE3m5f2C7pMYkEpuWAytpAldG4NDNPa9n7SuJNDkh0Apmzr5WimyVSF?=
 =?us-ascii?Q?W17AtfF9+76rbUV4Q8AYu2GJqvxxmtEgwxjcyHoF09GLrm7CiAgZugk6Wr/V?=
 =?us-ascii?Q?Ci+ZfKwUiEtIP9mOdbVI6AhXzqDc9+hgj0r62a8Cxq1Dtp3K/g+DtR+bPipD?=
 =?us-ascii?Q?6yIkHDt8P2RZrvbFCoZzT4qjFmHxdm/FzFFr9dxEWoj9FTE+jMZYX3KYGUPs?=
 =?us-ascii?Q?TsUAVilNXYIdFE/QB3MOOJv6uzlPsldM3ua4B8IULvloKt5balfvOtxBWyEz?=
 =?us-ascii?Q?E0edKe+GoaL+Nj7a5NeCLAo4max3l1fAWwZ1J7+F7Cqhrn8rpw8GwiCt0ArK?=
 =?us-ascii?Q?dvV0V37+TxdRfgFmpzvO9aS+bROn1Rx3x7ibanaDCV15XaKwyfmXYJG3Ix4U?=
 =?us-ascii?Q?1CWspaqYL9W5fhOiaSMREF60WNN0JI6nbdb/tVWM7nM9Da11yvuAgd5C/aiv?=
 =?us-ascii?Q?ESYmNcEYcEJc5tauSjMm08LYVkCGk+bf4X+SboWJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cfsYOEQcHWd0qslibAEICRQ/r5ytwB2wZwtzShvl4DnXIcrL5RzN3CkfKlVXlpq8vx4jUbalmvb96FlFPzKY64SLN08EaE8PJfSUZv7sBQmKabq/+9rU6LGemqxSPi6j6YdH4fqGrPXq0cZnoKIl+RidM5QWzY4t0D+xQ1drbnUXiRe0Iv1fVoNvVee2Cjag9lplHZHs0hTHswD89JpTsJD9k+GRxM5Zqhcd5ULVSVdHbplPgWOQmv50Ey8WelhoQEAUdYhaI1ZaZC0IuRVENS2p2+oU1xUpqz5OspIw7QR7U7/T8sfoxdL9jv4gMvMIaRDstZfv0lgjXSjgPRNTUDk+6ZamyB/Kg+NplIy3H0nxZMmby7SJrdjwFz1OCkx1YD5/kGJ3y6wOQ+vE3SeyhxMk0jmOHaRqQqE3NYT3q1QHMQTiLu7ddEGeEvW0BbDzqXuY+FSn3MHIE053ipBFDUo2fX2KS5b60NUVbMVWmwflMTx26LmmfiQl/GNaROZiwU2hRsKmjEqmkj4k4HKBEznF8mTavykZWKuIacF5L+OiZcwYmN5e+vbIGoGjSaGKRXceQVqwkkrPgQ9r7IIhL0Rr8vloQiUEQy7M0u87m7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158bbcdd-3d97-4c90-67e0-08dcef94ac5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:48:20.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot8h6wi8saDHkrOmAcF00BYbaUzek8dcu5/CVa1v5NwsC2fUoVnCjThzh2xgJQ7yfLwMlQSjZ8r1gWI1kjjy6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_12,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180107
X-Proofpoint-ORIG-GUID: f825sLNnOTbqM8aseSxPNv-bGQ1JE6jo
X-Proofpoint-GUID: f825sLNnOTbqM8aseSxPNv-bGQ1JE6jo

* Roberto Sassu <roberto.sassu@huaweicloud.com> [241018 12:15]:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect().
> 
> However, that commit called security_mmap_file() inside the mmap_lock lock,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
> 
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
> 
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock, retrieves the VMA
> and the file descriptor associated, and calculates the 'prot' and 'flags'
> variables; the second takes a write lock on mmap_lock, checks that the VMA
> flags and the VMA file descriptor are the same as the ones obtained in the
> first critical region (otherwise the system call fails), and calls
> do_mmap().
> 
> In between, after releasing the read lock and before taking the write lock,
> call security_mmap_file(), and solve the lock inversion issue.
> 
> Cc: stable@vger.kernel.org # v6.12-rcx
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
> Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

You really need to be in that list of people :)

Please add your own signed-off-by.

Besides the missing SOB, it looks good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9c0fb43064b5..f731dd69e162 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1640,6 +1640,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	unsigned long populate = 0;
>  	unsigned long ret = -EINVAL;
>  	struct file *file;
> +	vm_flags_t vm_flags;
>  
>  	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
>  		     current->comm, current->pid);
> @@ -1656,12 +1657,60 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>  		return ret;
>  
> -	if (mmap_write_lock_killable(mm))
> +	if (mmap_read_lock_killable(mm))
>  		return -EINTR;
>  
> +	/*
> +	 * Look up VMA under read lock first so we can perform the security
> +	 * without holding locks (which can be problematic). We reacquire a
> +	 * write lock later and check nothing changed underneath us.
> +	 */
>  	vma = vma_lookup(mm, start);
>  
> -	if (!vma || !(vma->vm_flags & VM_SHARED))
> +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> +		mmap_read_unlock(mm);
> +		return -EINVAL;
> +	}
> +
> +	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
> +	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> +	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> +
> +	flags &= MAP_NONBLOCK;
> +	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> +	if (vma->vm_flags & VM_LOCKED)
> +		flags |= MAP_LOCKED;
> +
> +	/* Save vm_flags used to calculate prot and flags, and recheck later. */
> +	vm_flags = vma->vm_flags;
> +	file = get_file(vma->vm_file);
> +
> +	mmap_read_unlock(mm);
> +
> +	/* Call outside mmap_lock to be consistent with other callers. */
> +	ret = security_mmap_file(file, prot, flags);
> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +
> +	ret = -EINVAL;
> +
> +	/* OK security check passed, take write lock + let it rip. */
> +	if (mmap_write_lock_killable(mm)) {
> +		fput(file);
> +		return -EINTR;
> +	}
> +
> +	vma = vma_lookup(mm, start);
> +
> +	if (!vma)
> +		goto out;
> +
> +	/* Make sure things didn't change under us. */
> +	if (vma->vm_flags != vm_flags)
> +		goto out;
> +	if (vma->vm_file != file)
>  		goto out;
>  
>  	if (start + size > vma->vm_end) {
> @@ -1689,25 +1738,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  			goto out;
>  	}
>  
> -	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
> -	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> -	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> -
> -	flags &= MAP_NONBLOCK;
> -	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> -	if (vma->vm_flags & VM_LOCKED)
> -		flags |= MAP_LOCKED;
> -
> -	file = get_file(vma->vm_file);
> -	ret = security_mmap_file(vma->vm_file, prot, flags);
> -	if (ret)
> -		goto out_fput;
>  	ret = do_mmap(vma->vm_file, start, size,
>  			prot, flags, 0, pgoff, &populate, NULL);
> -out_fput:
> -	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> +	fput(file);
>  	if (populate)
>  		mm_populate(ret, populate);
>  	if (!IS_ERR_VALUE(ret))
> -- 
> 2.34.1
> 

