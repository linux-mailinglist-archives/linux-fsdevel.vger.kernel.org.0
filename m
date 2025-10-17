Return-Path: <linux-fsdevel+bounces-64435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C5BE7DA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2868A580093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9943126A6;
	Fri, 17 Oct 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gv5dVcj7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dJWKy4Wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55024678C;
	Fri, 17 Oct 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693650; cv=fail; b=rBpJRlrrhjfNzhoQN6v1EBMSdueINiALo4M3v28Czuhx6olwb8D983GZRC2iBh1LRpepja9bsNuMkMJy/ZB3GccOE4Q/VEQjHJzfm3hxY0FBKHvW3VeE6cbmAoI2B92TGCXonygxJ1JIEMKMXxmTsylFE5WGai+YIpXYPxiE8Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693650; c=relaxed/simple;
	bh=YAzI97qVABzKnMm+p9wAwLILc8+SgJCjjBV4+mOJN1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZ7qIsCv90wOn/1KrMFtETd4eWqWrdlST8mNmdP97pES2ZT11ywlG/Fg5gSgpvRyFvfOPWizWMdKcNM7+Ze4G1UvEk7A5GrIqti1QRmG3IIlgij42PNf+HSq3cFIrqHFVj1Ww2Fzsop4SWVEuRn6Ys96Tvj58z1y35Ssx/xwm2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gv5dVcj7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dJWKy4Wb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uCd6007981;
	Fri, 17 Oct 2025 09:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=65I1b0M+Jx5XI1IJ3h
	5RvcoBQzTgV85EpuOD7QLS3Uc=; b=Gv5dVcj7Uejz6ptU4WaqiPIg375+lHSXhX
	dFPw/ujkOsBTeWD74b4BQNyvArxmC0WB59a/3Qh9/dS18A2tQBN4QYtfmJjyGlb0
	fgrLdJXDDrs+dvrT+K5CjCJdwplwlwM6ul7juZgPoXhE6li9ht3jXBtIim1L9gk6
	CGkW8uBbrf5nPfUsfC8JfQE3HIrLJ7dkJUrSGHDbIzNiMEIZ2XLQSQ73HTtga6SV
	H4Sbvy6SyqLed+q+3gQrwRvHD8pkUEeVgXdx3BGkJl/5elX9WQgv9WUSvh/fkJay
	hGCbgp+2/Hn9Crio4GnrRYns3VErIah0LcctjP9Aue8bxMpQrk9g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtytnm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:33:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9CvPm025776;
	Fri, 17 Oct 2025 09:33:15 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpjv3k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/qEANaLnPBU1XugT8pI4ktgZts/hNP+a7dqTdgj7p6kCQKp/M/P97nAgqg+IqSjkoeh+KtmuBXAoAwu5Ua3IJ8FpEixu8WTrKeWjS2oQKZfvaOygUYbFIMydGpd/MzTQjsaPmm4n2baOHwqrzVVxV4FgCI7DmoZ5YWYmIQBQd0ImuFtl4svHnyCSNphEaf0C1PJF4m85KXeI/l3wwp+ws+/brGbM/jD98Ncs06bkxKZwJDL6P7wepMydfUcqsruo3l4h01a62NKnrpCHUzlfTnL//ImITpw78zJYt2REvcXueioYvj+dMZ7wlAVUo4CDGdli71KBwgehF5j6JUjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65I1b0M+Jx5XI1IJ3h5RvcoBQzTgV85EpuOD7QLS3Uc=;
 b=Wg0j/adjd+VXLkYbvRFdey144bK2Mq6sP8EnyWNcLrPyfdNT6ens+TS70g2x5EUNWcXW9ZGtNM3O+vbNV2abDWeHz417qKNm2s3wS36FVBm9RYtpMQ7q3y3Ul9XRCCarUlORKE6K0FRUJ7r4kcIJvi6PZeLd7TtAYZEOscbmBL10Lwkbwe+uJrTGfzzij38a0/mHtiGT9Ld4h5IZ0xMN1kdELnwxLZyfne3xRjPKM6IVf7Tbxhexu1RO8qiiXYztc/Yed5aWZx3bbGIpe/kfs1JtPYkCNNxitH0O02++mTeJxPmwqiA6Euzms+keceugceg/AW4tIsQILTCZVl4xZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65I1b0M+Jx5XI1IJ3h5RvcoBQzTgV85EpuOD7QLS3Uc=;
 b=dJWKy4WbTZukgw0RwQF6UWbDG2/2nNEKQtxqsUGOcoArDNQu0IflxOHxoyLYaf/CnDCbJAUB2XKZyDWkluy1wIsuo2HvaCe6uf1LIiDCnIe0JchsGYObo315zecXLu5d5C/bucT+7/PLwJf/KwAD9teZSy5/S48uwdCnrDrPSKQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:33:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:33:12 +0000
Date: Fri, 17 Oct 2025 10:33:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, nao.horiguchi@gmail.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <03be502e-0979-42cf-a6ba-dea55c4ba375@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016033452.125479-3-ziy@nvidia.com>
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f9b18f-9126-4dbe-1a83-08de0d603109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dhaiAxGU5nbudT08e9AtOCmVR9Xtgw80E1Xzck0UIAVPvM7PH3lM3xnJ+Zen?=
 =?us-ascii?Q?ZBnZDKz7dLNAfXQqRLy4ylfPIBFJviEUKdfs8o+i4YLU7+IxxKVVL2fYLOrW?=
 =?us-ascii?Q?7025kEhski5xhkXsvzEyWkVCJHj83P+PWQxIvN53WPGtQOsNoy3eQ4yC+HQV?=
 =?us-ascii?Q?/BbqJ86jfHIpbj5y+RBDlZRvDIapgPPm0ltjh852wr3xbEgIzzpRpLmN63ti?=
 =?us-ascii?Q?qJ5YiMDm1oEurUYKGo4qbGZg9sZXgwPmlPgMNdiKy774ELi1VtJuuKFUp4MS?=
 =?us-ascii?Q?3dx4ZCxvE5VHyhQMdKZvzhnMQ2y0xIyqDx+LXJA+JH6S0xjmZtfB5OAe3yvt?=
 =?us-ascii?Q?oCfs62Sh6fGksUWYMHrm9VA1B5R/o+58FGHzFffzsKOY4+AAgGLDNEsu04M/?=
 =?us-ascii?Q?pDWNKiaklFk6amjlpQpeiX5j7gbQlk8eWgYCg85K4Bef66qIUELu+t8Ig3b4?=
 =?us-ascii?Q?dDioeJKYvgbfe/OhlIkWo5ZKGABO2USSo0kYqaNE1mg+VSV9g8BOpXYQJrMv?=
 =?us-ascii?Q?Cw8MJ9kj9ZjZKK0z/zb29NbNYk4q3rCNjdAPV8wO86g6VpbayVPZWF/Y8ZKA?=
 =?us-ascii?Q?w8V+RW+7dVJOJSRqADAckLEdCMENX336PA1IJneLqWQAVjJj/+9PDxEnrJeZ?=
 =?us-ascii?Q?VFsjY6EtucTyH9KG5B3fO5VsO2UW479jlCkuS21Cu+1/J7ClHYvPCrgSYdks?=
 =?us-ascii?Q?YkYcQiI06sAtlkrs5MufmkfQzBZG1ZwQfTgV3rKqFTRlpGFcUsXMlEcOMuCM?=
 =?us-ascii?Q?WaomlNruPTaX6xtAVvuUBREC/JyHqjMMIldgyf1uGUIjz1fXmLkVjWmEnvc1?=
 =?us-ascii?Q?OJ5GbNtieRp+F+vt1lQn+yGZpyaw3PVwzREJM2ANkp7fAN07A/za7Y7MGnch?=
 =?us-ascii?Q?v6odcPtwiVQKJqX5wosBM+uSzjkrdWknF9PEdDT6vDZ/ALyORzLpgqw4qGYv?=
 =?us-ascii?Q?KPRiEhNpQ3E78vStJbR6n0vyTt2sELFzCUquW+wN0ddn21AkY8iCE76VWs45?=
 =?us-ascii?Q?Q2dwQ6t8d6DC4BLtwED/gORyjd2wtHqamVa9GsZxrxolneh3yys3gaT5AgVh?=
 =?us-ascii?Q?CsBWRZycCx/Rqj4hPMYQiHdA1lcKuZwiAn+nFnUM4QzOhzpDLGexeCX6M9sX?=
 =?us-ascii?Q?IEF/DFLBqe5BOmpWtmK//L1Rf9ErJLwHfYsd735W3af1IlwGHWwMzilNkEHA?=
 =?us-ascii?Q?YCNxlM24hGyeFo0zXJ6Me/5nSoJ1+AZO2pJSAanZjZIPt6TQKqJg9+CeS5Fv?=
 =?us-ascii?Q?luOnPQCuz69OZyMijB7catLhdBrxsarEvEzJLiIIGo6lLH1axeKx0h+a+r20?=
 =?us-ascii?Q?Q8QJyEzul5UIhB9X0FqHuHK+RvKytIEyylsHL5fmqp+gbKCj0JxZTSYdgBSH?=
 =?us-ascii?Q?fh6LVxmslVBjN0yvogh5T+K5OQGeukkX6EbfF57MdHhJ6a0h3XkcJrvP0pmy?=
 =?us-ascii?Q?Un8Z5rMTNyf+01ykBoFFdhpp2E19ml3V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5+DHeSHCOCARwPf80UAidaRBn0B7eepHYoIltd57fWoffAebDHqTcOVQXKr?=
 =?us-ascii?Q?IkwtXQUXdhGuKD33nf0BeyWES47egth+PxRb9pzWLJWyPIvgYLkryTnfK0ZM?=
 =?us-ascii?Q?zQ2km+N5qtOiFtPO0RKrINH9+G+cxcOEEXHi8HykkhtUgLA0GoggwqVrQUlT?=
 =?us-ascii?Q?Ok0JB1cA2SJbQ+tq8268AZ1MGUywuzAb+Z4cW0Qk+MtAXf+Uypne4GZJXAZM?=
 =?us-ascii?Q?1JqFngUhDOt/s3ywDm9MSu7mP4B8HufwNV1Hr6SYC7HQsrZyL/0cN939TjEY?=
 =?us-ascii?Q?SH5hRMgohAPhEVkxE5vKukPe81Ii9m7FjW4+lRPQwd2TCKblyq3982Wo5iEZ?=
 =?us-ascii?Q?gEM+5bp3Z6olqYKuN13pzc4BnPlHYCpsUaLDC1JuEJ06snQUfMv8zNts+oUz?=
 =?us-ascii?Q?jiqBZB5sAEvd13CRRCw7HSFmMw4MD80X9SALRFgXPY8FXNLg/c3kEuOeiV7B?=
 =?us-ascii?Q?dBo3dK0DT8PKsnC/HxJbsh779J5zZqFm3D50BPLVFhTb+mtbMdW+aWQqfoBN?=
 =?us-ascii?Q?6owv/dwYn7xM3vM8cmMzXkxyrkJmOx2xXSleweXbRh8+0xsET6c/xn3aw0C1?=
 =?us-ascii?Q?at9rqEfZPCK+IOs87IJHcLnRK9mRCACJrHqlIL4nxbtxsbpBinZd/SAhuzqs?=
 =?us-ascii?Q?x+HxaS+xFaRuBU2WCV87+Q/N2apJR84m/T/ReQVqedYlQEsPUIlVLuuVRw5u?=
 =?us-ascii?Q?tf6AveWyjqk3nJvTUXW8DO0xvH53+eb41ZANY8YwUJ7NGL0ebLKVHJRVV5O8?=
 =?us-ascii?Q?VJqGH3jZhyU3xoAlwi+uvnJTSMIUcD5LY4LwnHKNRnAmwh63Or6WLgt8TQfV?=
 =?us-ascii?Q?hAz0pdkcoVUV7nABxDNOqY6IERgJ+3ro2DC0zKtrgQk0O08vgPkKr872ymz7?=
 =?us-ascii?Q?65I1p3pdplS4b8RoGoq1Zs88Ly5OLnEXzlgZDq9SzH+DpMgAIl13Knjhnt7F?=
 =?us-ascii?Q?8EpSqgI1CVkHv9FLd4uG+8I3bq/mO+7xcTtSTZr9z2N9Mg3WEqZaENPBrISc?=
 =?us-ascii?Q?N2zzWfAKeocSlFKSgZg/CFAkxskTdvTXXMPRH09nhKjek0ygx8mOaQdM11wb?=
 =?us-ascii?Q?Eh245yTVeAgr3hHEDObOvvFkx3RU+zCqPHHSkWo7/duWrkEISxhr1I494DwF?=
 =?us-ascii?Q?pm7SAJP4H5qQ1QLJUtDCPDS7pT+MjpR3H6D7CAIlzfbsGq+bnqT2m0s9slmX?=
 =?us-ascii?Q?OSsgBKQI5RqZT3E7O0eaVDhPvMQOZzE9IHU9L4ICtrjlHLluk7LlsepmI9uE?=
 =?us-ascii?Q?SrROlkh2hFhZzscunh3rl8TaYloto8XYefSt7+R7RH7MA76h5lNEM8/2oJUN?=
 =?us-ascii?Q?zqcPdwS+wHZziPP/A4R1/S3YKe8RMxalaefN5WzXj7vml9haLwwUtMw/spq1?=
 =?us-ascii?Q?L1KxTi+YS6I6ggDGfX78r6WxtF3QOzi4984whUXhpHoq77gEJa3N4PNJFbUZ?=
 =?us-ascii?Q?Ba3l0yallyaYNkyU3PDwzIr8ITD9s6e8Nyi9THocQA3FC33Wl7rA3EgfM3k1?=
 =?us-ascii?Q?dRNUd/OwYhFa9Ht0yxsl971VbK8VaxwD9b4WjzDEj/bIc0WKAngvUAHIXuEd?=
 =?us-ascii?Q?fNsYxupVfL6KyfpC1k06mXasaqTmto1RY5xYnDmE/Ib0zDiEMCiOeAZ14tLr?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J61E6MEnX53rBAULv4cW4DAH54cUxpiFTEn8WyUjx70nvqMXGlAnQCZZCKOs36ofClYuGrwVOq9lp2Z0CMt9/8etE8mjOQtKevgu0nYGAlXGCrBCm5rmTY0kidwEr9Q8RA1X4bWihIpB2uVL4d7O2CZOGqJqx01ppQMa4opTD2xqhgti0CkcLLeNQ5LEAW0WaaUd5oDJRQH9VIOox/yo8a5CJ1MQH745qUO0+tmey/W2KDjzLeL5X1Nj7Ox7xJrGUkbDiajKyoABsRNN2e6YG2jDgd18jOIKdsN/9RQLio4V7lc2oqQe7L7y/b0RPTRafrUsyUum3P2s4OUnDFUSJvoIrAvJTz9U+z6UMk+nmzJPXAVi05s0Fm4dMjgkcbTvYlUwLGw4LE+IG6DaOzplpk7K0O43V8H7EOyGBGbBvM1H69VsOTseCg/4+QnsdCm28OHA5QG7r3VKcEQg/bOwbSeQxL0pNjB0Nz64xSXMwBtlIeIYMSEMKaqC4JeIYbfIYzRJP3yaSqijP6+pdHNrvCrHyricZm/U/edU+vXrmcPqOXOujpr630z/JQQt0zFrHem9HKyqQ8Ux3C/0NcP8M+//YZslwRWmoKq5EiIsagc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f9b18f-9126-4dbe-1a83-08de0d603109
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:12.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIBHLczOZrh6k0MP8zCVb4XsDW9dU0ciZ5qqpmn3LzAEysohWRpfNLIkElUuXOjQnB547rTiu/YFsYGEADoSzb+ooWmjB6j7oD0yObzd2SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170070
X-Proofpoint-GUID: wU1cz44xshNHpYTgZy794Fyk-jcjafOg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX27uC+6rW46U4
 PBx5Nd3LWEQO+MjZGcFPBmGX+QZWzG7RHVbrbnHybKp9JhlY20b+gpk22DxP05RNqEkDZGTNSUy
 ZoeqbGx2FRY1XGk/ZHhsGjcGFtyKkJr8srF6nKXaemO/jMm0aAO3CrCiTlixomzYiIOd50pPA+f
 CU3kSao0o0cfexiyZKGSBrMOTXm9QWI1jZpi91H53odUhimFzev+h5js5pLnJ4YDy6cC02N1m7F
 g0rKS81K6OxmYHjJdopVpxrBlbM2yQkogpsw50V+QzufQ+VB4TW45Dc1jVrZVEUimprHxLvoLwA
 Vu5D36+/PrHx4+99jR68cTXBQ9xgLpJP8RnPtElMyLdLSEt3qrXQcPkeS4TIXnSPlT1tBuLTfK5
 1HVIqUXi7z62flxWucoTWPofKm0XAttMT/qvm3cuiS5k4Q2U/ME=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f20d5d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=-7auoy8IQrukDM3GDh4A:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: wU1cz44xshNHpYTgZy794Fyk-jcjafOg

On Wed, Oct 15, 2025 at 11:34:51PM -0400, Zi Yan wrote:
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
>
> For soft offline, do not split the large folio if it cannot be split to
> order-0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
>
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/memory-failure.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..443df9581c24 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>   * there is still more to do, hence the page refcount we took earlier
>   * is still needed.
>   */
> -static int try_to_split_thp_page(struct page *page, bool release)
> +static int try_to_split_thp_page(struct page *page, unsigned int new_order,
> +		bool release)
>  {
>  	int ret;
>
>  	lock_page(page);
> -	ret = split_huge_page(page);
> +	ret = split_huge_page_to_list_to_order(page, NULL, new_order);

I wonder if we need a wrapper for these list==NULL cases, as
split_huge_page_to_list_to_order suggests you always have a list provided... and
this is ugly :)

split_huge_page_to_order() seems good.

>  	unlock_page(page);
>
>  	if (ret && release)
> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	folio_unlock(folio);
>
>  	if (folio_test_large(folio)) {
> +		int new_order = min_order_for_split(folio);

Newline after decl?

>  		/*
>  		 * The flag must be set after the refcount is bumped
>  		 * otherwise it may race with THP split.
> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * page is a valid handlable page.
>  		 */
>  		folio_set_has_hwpoisoned(folio);
> -		if (try_to_split_thp_page(p, false) < 0) {
> +		/*
> +		 * If the folio cannot be split to order-0, kill the process,
> +		 * but split the folio anyway to minimize the amount of unusable
> +		 * pages.
> +		 */
> +		if (try_to_split_thp_page(p, new_order, false) || new_order) {

Please use /* release= */false here


I'm also not sure about the logic here, it feels unclear.

Something like:

	err = try_to_to_split_thp_page(p, new_order, /* release= */false);

		/*
		 * If the folio cannot be split, kill the process.
		 * If it can be split, but not to order-0, then this defeats the
		 * expectation that we do so, but we want the split to have been
		 * made to
		 */

	if (err || new_order > 0) {
	}


> +			/* get folio again in case the original one is split */
> +			folio = page_folio(p);
>  			res = -EHWPOISON;
>  			kill_procs_now(p, pfn, flags, folio);
>  			put_page(p);
> @@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page *page)
>  	};
>
>  	if (!huge && folio_test_large(folio)) {
> -		if (try_to_split_thp_page(page, true)) {
> +		int new_order = min_order_for_split(folio);
> +
> +		/*
> +		 * If the folio cannot be split to order-0, do not split it at
> +		 * all to retain the still accessible large folio.
> +		 * NOTE: if getting free memory is perferred, split it like it

Typo perferred -> preferred.


> +		 * is done in memory_failure().

I'm confused as to your comment here though, we're not splitting it like
memory_failure()? We're splitting a. with release and b. only if we can target
order-0.

So how would this preference in any way be a thing that happens? :) I may be
missing something here.

> +		 */
> +		if (new_order || try_to_split_thp_page(page, new_order, true)) {

Same comment as above with /* release= */true.

You should pass 0 not new_order to try_to_split_thp_page() here as it has to be
0 for the function to be invoked and that's just obviously clearer.


>  			pr_info("%#lx: thp split failed\n", pfn);
>  			return -EBUSY;
>  		}
> --
> 2.51.0
>

