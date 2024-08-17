Return-Path: <linux-fsdevel+bounces-26186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEA79556EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850E31C211CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC48149DFF;
	Sat, 17 Aug 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P1Mz4WdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jP+DqKpF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E461422D2;
	Sat, 17 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888120; cv=fail; b=C7zAQKSoE8+SuPAOkX4RXTdvDddqFPL74nc4d9TVbQtnQJqappZjZGWesclP4kAao4p5S9m5J0XsD4b+AoNsF/NWzKbTgsrqk4YLyJnKYpmC/xB3MYzT0Uz/IoL/EGg1+5U7OTAvd/h05y0XmwIwyOTSzXc8jWYcNIaWhzIkkV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888120; c=relaxed/simple;
	bh=yZU2c6ZG/1+aBwlyF3buJrRHxCW6Pis0wdP9JmmYCSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1Y8XHFEC9cIi3XRo7o7td3E0Aw8p4BlSPojZazZinwmWejKCzqQFC31ZAlbJSZUzsM+WqnNstAc+69yq2OCzCkv6/o1EPfWfjIpSwFDAwXVz4Y9g0/hGl/U/EJqQkP9WAvGF8b5OTAsGofCppbJY+QaksM/vvO8UCg4POlIHI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P1Mz4WdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jP+DqKpF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H9lR6g025828;
	Sat, 17 Aug 2024 09:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mg3KwTuBisyad2RTZuLAwDfvThje4Gg1zyutjcECz5g=; b=
	P1Mz4WdNWbAhOqFBaHRMPX6U7U2MD4Xb1Hg5yaEHp3KNDl1Su5MRIPP+Q2wwq+6N
	Ie4ohRV+p9ZDDHbJiWdy0Uw/QI1cgiThT7wjqZRgodeLG15rgmgAziYMnuTp6HuW
	07V1KcOZnNZn7Elxmn2RUKs5YSbUpZBFWV/F+m0P3z/qnu7LVxPjk9KnA8dD1kEd
	ZYGqoD4fEGtZFt9OwzeqgwxqH0UuP6prGMhbY5+zUquVTO4NziXhvyyDR4u61B+1
	p5nkB5yXira17kE7tmcTJSx2hYUkuHVBIS/7OvqgDXAumcUz1S54rO1gAHRlh7vF
	waSv8yQVu9tpyBBSJhfzzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6g87dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H87Ykc037368;
	Sat, 17 Aug 2024 09:48:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5f26w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CETiqKKMNkWKAO2BeGMkWbAiHqMbWA6NVRUVuZD4pliNNC7wWOfSn/susZlKsDFpK1MKLG9KxpJfSZtgIr+BpEM3Xko3jd/dcmch4IKu9whheTuDdEX5UnJJRsjcX0afU90uPyWYa+jPlLNv6pnyCxovqfotCLgqWsfRs2Hvr/z0wcgU9D2DGfdi6Fi3lr6lviFxJKRFJ9SOFVVePpFGETjYIg6NL3sc1NWSV36cq2zgtSCp0nnlZh1KMpcPNeYHfsLRXqh3TZhNVfD+Q2h1xCLnIkAfi9hWSPqnB5popIVzFtPGaiwaOvxwdOPSb85prCd6k1wmHztgMhdDbGwNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg3KwTuBisyad2RTZuLAwDfvThje4Gg1zyutjcECz5g=;
 b=XK9K1JarNjEtzfkc76wahSipCkTvK+63u7oNgo/jrvJ56jBEdjy7BjAVJgYTsrD+Q/ityYfIu1jC/oCRGMtbw50oaKfG9rxpiDQt7XZJ5SxXZ+llKajCKTLA9qd0NCl4XU7C6eJsD9T3klGgIid14u/qk65qezr3x5ZD88M6d3JU6izsiPdHcJmlhPFRyk7Yn6xdUChwkrgfeC78yTj2R/vz2sdLw/tr423lFlFobsba/w5ES1iwxxxiKX20nRkuND9GBrks8l5OfVpBO22HUnD79mlnfW24vyFiGqotVUGgHc0KiHXOXxUL+5zWe8mTtzGJuAx7Q1JXQzP1vu1OHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg3KwTuBisyad2RTZuLAwDfvThje4Gg1zyutjcECz5g=;
 b=jP+DqKpFqIYIVyuKqxf6THoTlvgLiBwl1QbV9LL8OeOrtp3TqtfyOG5z/KTMewbbA6ttPTsvMo2GlTKneML363AWhbzsLR+5bK8I1owAWeVgRAX9iWU56Sop5Sdv4dN30gD8VZKP7Gtt4kOTwjnOJf7uz6p7eykqPvnFo6Qc3Co=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 1/7] block/fs: Pass an iocb to generic_atomic_write_valid()
Date: Sat, 17 Aug 2024 09:47:54 +0000
Message-Id: <20240817094800.776408-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6044c2-6fdf-4640-30cc-08dcbea1b8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GE7hjsw1+e9YzuKdGPSlUH1jgrOFGbu6znM8v2ft11ofuYGGP9UDDs700eKs?=
 =?us-ascii?Q?fqDgpqnns+gFvgoAPROLWTSx9raokR4IfKEXIfgjGon1h+bz8KfWYcXoPL+M?=
 =?us-ascii?Q?ZKOQfNQOxhFNVPR59+YR9M/J953s04qCSfoP7ZV4Vx05XpdVJm4vEEMnaqe6?=
 =?us-ascii?Q?l9Rw0xAPdBdx/P6f6aP7cb1Z23Cpm2ZxjZKjF0RPeGjI60nBFe0uF49gmob3?=
 =?us-ascii?Q?3zxy/AgrTQp914eH9EYxZEtiCxF9IHqavVyR9CxsL+dd7CK5b3+4NQMmiPsj?=
 =?us-ascii?Q?1ba31zP/+H8teqAPBf3nWb1pMN57ZbDugsWDm2aYjA2/B+/rhuCm+OzgxUHr?=
 =?us-ascii?Q?WJjh9MfSm7M2+KGKlb5bXR7+bxNvXIkOepvfm8kpv3StX8mQSsPLe0hvvWWH?=
 =?us-ascii?Q?hbi7g/I/k5VohdJbNoXbOD/IXBG5aYuFaQuWK0gbbgKnLoGZU6VHCHfhHlWl?=
 =?us-ascii?Q?pwz+qlVSV/EOQ9+dWxuXpjuDP1h6AujkGzpzQpociQXCujx5AmnKwNI1ZbHC?=
 =?us-ascii?Q?8qch9GTm6tkDTVfKUATlo0FJrVSjjtQLciCm/fQL4ucfp2D3U+ojQ+O4ZTbg?=
 =?us-ascii?Q?Mofv9y7U/IqVPwuZfNc2vf7AEKaOHRzCUymLNmrvT9F91bE8+V+fdF6OCQdU?=
 =?us-ascii?Q?8MwY8ul8vgFbkAqHkqeOxQcR9WSS6On9iFoNwdmsyG1jR2AAhRWax5V/JoX0?=
 =?us-ascii?Q?PvTDt2jIK2NmY5+C3I6bdBjv+jATrKyEdVWgFRqXxYGGhiFCC9WRCTa/FZec?=
 =?us-ascii?Q?XcoOPrEQnTd2A9tZRM9eMHlDUzxxwW7ggORA+T86qJOyKXgSzHZh6feWa7+r?=
 =?us-ascii?Q?yEeyIHq1KOyCWNl1lERGNklSjMyvkDBfXZjMC9YuBXQjMmvS019Ggkm/gp5O?=
 =?us-ascii?Q?dxy/TIUPBkqJc3wE9sQCBzfCa163tIqETjAJQUw5m+o/s/GNRDKuwr/bGcp8?=
 =?us-ascii?Q?wcFQYBUjKRbA7ElIr8xNQEN2ES8P0YbC+BGGuWNLoQEp6MtUyL+A6t1XoS0q?=
 =?us-ascii?Q?pSho73AuWmQHgB+i+B6sI4XuV37sOLrva4tgj10K5M8edAN1lsSUCrCGEUCI?=
 =?us-ascii?Q?bZfdLcQamcZ4w0s0yVVXpP5j2E3h2ogLc8fqpGwKdH3jWCqgZXVueDdNWNUp?=
 =?us-ascii?Q?d2BFUb8EJPES0kuB4m+DiTAMxQyueswYlNw0XE/G2nE/HSeuZ51uilOXT4qy?=
 =?us-ascii?Q?nxnD6wIxQlc+D12D+iIfQ7/yzhfYlnLw/CJFSOxYJSlo7VX8w8+40npPuyZr?=
 =?us-ascii?Q?oEvfs80mIYSv3NhXl8a8ej2mZpa5f7kGAx0hIHv5oOjPtAzxtNJ2SJgwNw7K?=
 =?us-ascii?Q?wf1wCAvlPBGfqTEuxMTZ+k45?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXwlUCGJQxZH6mTgBg3z8ocF+DmzoPhs1+WAthcgC/en/aKmTxC8X0mX3y5o?=
 =?us-ascii?Q?1M7VWxZNfLQMXemG0ZwR+zSJGBXJ+lfeewiBNWXCrotoQg0fCVt5ZAQH4di6?=
 =?us-ascii?Q?0Ha5h2u9YGt2go5tP8S/XEICdkXT+LsNq6jajP3Iv4qFM2XznzZ39gNA3owJ?=
 =?us-ascii?Q?VA2/49S8GOEzdbhJrzCOYSEF0K+FRaQpzMSev6OW6a0aY8+FUvYRsCd9zUXr?=
 =?us-ascii?Q?hHMmoV6gHXuSi3FMB2a4r9KCFVrebIvuOvmX5UckijvL0Fy4A/Y/e4X0htcy?=
 =?us-ascii?Q?7qfrWKymzszxBkUYZhNW3KSoN0MFJvHbXLBr1T4ocvy38kzZrUX4lugHFdm4?=
 =?us-ascii?Q?8y/MXgyr5JK/WbhM7P+dOdYrwOTENFgxXfr7xe4VBZrRuu3gIz8ep0rHa8FH?=
 =?us-ascii?Q?h6oc739QAUSjQJGBEXY/48meOp0+T9AyIHxBVW4fRAcf0BJXu2Dq9nYdBS4+?=
 =?us-ascii?Q?jFKUesA/BiLSEKG7x/BksH5jsX80DAXKoBJieOtB32mGbP3XeOJ9KHQ5jkz6?=
 =?us-ascii?Q?REGwUZUiqlHCweI5resISm8uIDCWoacLKMYrGe63xh28+usma2KHtahDxOXW?=
 =?us-ascii?Q?yK3d1IWOEIpBlIrUGJw8Q7gWPd1RfkCIMolWRYrcCaJXFQzuE9T6/wcU4u5b?=
 =?us-ascii?Q?V88Me9TTgzHyrQLuOPn6YWWHCYPr+Bm8TTbxFNITJY+9Zyaw7VBGRQTFMizD?=
 =?us-ascii?Q?GCVIE63pswMya+8ndh8tpdxfltEAvszhD99bpsLsytwcljGiCYkEPjrmrnVm?=
 =?us-ascii?Q?YGytLfQrAcUgFHcJuAYOrKerhlIEtWaH3cnuVQ7gB7GTL147kDhZBRPl8Syl?=
 =?us-ascii?Q?EB/NmBMh9pQXqLwM7lj2aXA0ObXZhHaOL38rJ8pxaPCqeJwJIOJTb4tdDvMN?=
 =?us-ascii?Q?/i8mCmmDwU0fTz9RRdrsj3zk5un5ZROSxVhvxKnZm0VZ7ujI9rSUVSlLYwLn?=
 =?us-ascii?Q?BecVBDN9wUVkOJ/5Gc5VomoyWGQ6wiXZqVwxjdKMN8O90rF94uQQ66U7AtK8?=
 =?us-ascii?Q?qLAk9ewqm2Wvz1T12PQsyYOIatROK2GhWrS/+42vhNMzkC4zg6atydWNu3lS?=
 =?us-ascii?Q?D8LgBV9i9eJf4w2Dby38T+g1URJzfL1l+SXdzOiIZApeIb9KEySKUFu1Bwsl?=
 =?us-ascii?Q?nw9lXbz6/Oa9HjOyzYQ9yNBXDGXar26WTH5PRE2+cPwXjdXNdS7pvyABczla?=
 =?us-ascii?Q?FiVn0y177Q47rUsuFjask+JDzILbu8Y6msNVtvaPEq2vOw9Kt+DfoihKkK3u?=
 =?us-ascii?Q?h9hzVPb5gJa6xyouSymJbYbJE49hH8XAue4EoLInCGRc/XaH1bP8QA6whY3h?=
 =?us-ascii?Q?pRzoIY5tpGXsAN6F4neh6sEmvWeGMWwKMscarlJT2NB3l4Gm9vhRyHIm0huY?=
 =?us-ascii?Q?G0UBTJzFMiengAnCI5CgCQ1TA74WJmApmVX6nC9G3Ts9PhMA78d8w2PH038i?=
 =?us-ascii?Q?cxiAaHqjdCXifXQdycVUClVKXWL57kN4rYK4i1zqfxEWY1X+AuGZRBDpFSaE?=
 =?us-ascii?Q?lzQj2yGBvVgNR2LfzWegVbnj06DjS5q00I/Wl7F+n7xVirPVae/E9VCofYWk?=
 =?us-ascii?Q?e4E97MHbt70Uw4ZBsnT770WQUN4E0XsbMeN+jxBfX/mpsiZO+XWvno+HINnd?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XwDAsu1QouN1Hbj1bTEPdXSwzg2ZISyrPd0OL1ADP1gxGVTiyjjMiCDv34rfUdJpWQdwik7kgAy0K8s2lLF8zIaQxbRpgUAiww05sNVzJ0VnhFe+cia3Z4lcUuisM/K16yzSN74lix6WjDPTP7PaOpdzdTayABCzGCn4OLSGvQJAoLA7D3QP6evmYrNGl2U/XNoKMu7tTHmpbcq/L/QdKldG9HaylleY4qWhKYELh5iIkomBbwVNzFwNtoyLW02ruOJz8hC/k9mWBtr3zq2Inz854Gh2VQNVyrLliswDxSV5vBpsGnZO2a3A0HmufH7zzNse6ZCny1NpPSecRQV0ygLFOAHmx20Fuymlxyk2la6MIZfz7HgKrJUYPQXXFJ6SkVS+OPYVdabASUHVZU3ECPcTg121Xospnlr338B6BOPsvBDuLPTN37fg3N9Evx0AnZ0i2ZCaOZ/Xl3hLLijs/SdJ/MSXjqW5hrefzOnkHr5mJMneU9Xl2NkJVfF2loX6Q0pbex0qiYccqbxOxQ5RHc3d44ln2Yeg6aWNSvJtJZKzVExWt95MjRS39vsgMKfsmV3tXlmF23BPPkF0CMuJJfWbi/3MQqfOBv/qXJ0B0nI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6044c2-6fdf-4640-30cc-08dcbea1b8a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:17.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRzeb9zzySxO7vw0sFJ53D6Xa7qC3/U9T3h/HJ2kniv0MUX3HNVMyuOPUFa1YVcTI3ESfJ2H+AIxWbxHqtpueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: W8BgnJckfdoRSMBYskF3QcKPfAS8Svc9
X-Proofpoint-GUID: W8BgnJckfdoRSMBYskF3QcKPfAS8Svc9

Darrick and Hannes thought it better that generic_atomic_write_valid()
should be passed a struct iocb, and not just the member of that struct
which is referenced; see [0] and [1].

I think that makes a more generic and clean API, so make that change.

[0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
[1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 8 ++++----
 fs/read_write.c    | 4 ++--
 include/linux/fs.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9825c1713a49..1c0f9d313845 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -34,13 +34,13 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 	return opf;
 }
 
-static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
+static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 				struct iov_iter *iter, bool is_atomic)
 {
-	if (is_atomic && !generic_atomic_write_valid(iter, pos))
+	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
 		return true;
 
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
+	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
@@ -373,7 +373,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
diff --git a/fs/read_write.c b/fs/read_write.c
index 90e283b31ca1..d8af6f2f1c9a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1737,7 +1737,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
@@ -1747,7 +1747,7 @@ bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
 	if (!is_power_of_2(len))
 		return false;
 
-	if (!IS_ALIGNED(pos, len))
+	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return false;
 
 	return true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..55d8b6beac7a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3657,6 +3657,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos);
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


