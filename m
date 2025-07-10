Return-Path: <linux-fsdevel+bounces-54532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA6B007C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CDB64519E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C62E8DF5;
	Thu, 10 Jul 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m29GxZlp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kd+2Wmuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8A2E7F39;
	Thu, 10 Jul 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162740; cv=fail; b=iIt2IXzyQGTc1yvfkK99mSsYWrVQh5gQ9/xz6PXqAx7IDeT0MrmOT19JOt4qGrkE90VZVdrWgCo/RWKNxvMg9Qxgub9qhkoa+ihw/OY6Ta/jJKso+CD6zfvkm6rBw72GwMN4eRVLPxD3mAZPIyYEkxEVAaqQOgL+rrXx+rs6dCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162740; c=relaxed/simple;
	bh=M+h6lQRtOP9BtXSSjt3ZQdXZJp3t6ZmzBxqtOdNQWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEtCXiJzMPgqyhAOONzDmn9Q6oQkh1wpXlf603yrBlhh5rJuOwtJhB2ngI8p+GVlzFithguX/uLorHcadbbnJ511OrIF6GlZVd7Fh0a7z4E+2ELB1HHwIdMYQdNxvQZaNMBdifqFLFwG6E8E0t/HlJGekoS9LhK4mOeQ1qlyPvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m29GxZlp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kd+2Wmuk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFVpro024073;
	Thu, 10 Jul 2025 15:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b3xD7vw8m0RO/Q6K5JRIt6mRvTK1wpxk31Jp9CN8r84=; b=
	m29GxZlp+uGqDsMkipFWlBOLSoQE5pznHhzOkM/taGbft27w7IiATPRfFaprJB4c
	hHtHNkVEUfAWSHCDF+HtPW5Vymi4n0SOXhfANY5lkVZWRGAdNybjcA8p8wpwcDA5
	nMJXOirwx6z6ZETIqZ8TyFeEOWJsR7uHMZ5caDyswjaKoE25ajIOvXabTydpLl/u
	pXZg8TQr0ugDz/AWsZWiOMoMhjK6CnPmHLfYXdzSDwicVFoWKoyV+Ie9kQ0BdCZE
	zTbgFsKzARdeVxq/keEIidUqTiAfvda8So+bPIBxRH5rMn9Q8BnX4lsSgg3LG2uq
	luF6KTjanXcOUXbW5O6jDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tg84g1ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFOOlk014362;
	Thu, 10 Jul 2025 15:51:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd8053-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wukvdq3YZMBXizOx44NEepYxgEq6dutp0JY56jhQ2pBCKgwJmXCx6bSlR5BeNLZkRKqPaSOZteoSw6iL0HDpAcZDpRv7Q3fNpRe8tIMqetVwPxcWuMO8Zuc4rIk7qdQQl1O3Md9TlgPLJGVvxSP7Mzp1LpB4OZk+Yy15IJg09+QOa/0oR++2zkMbpywdWK4Rg+yJEoF+74j79erMz6nqbBzkiNwLURsip/F3/EuvNdLKv4S3F1AW6OtRKghShGKFkirqUSO/Wuw+hSSr/s4OPvddE4LoLmVz5DY4mQTFDnp4Drzmx1rY1mymL6lWqlPFYUvz5gCKzhIuuXkFlIQWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3xD7vw8m0RO/Q6K5JRIt6mRvTK1wpxk31Jp9CN8r84=;
 b=KsQnTWXLT49Tsz7116h5z1cJ+z4Dalg8oRZjj9AKl4L9Qia0Q4yIQjcIeRHphCB2kvrZqCibMr7iCseiUtPfSp3me+Txo+NcOYx7YcKTOjcdc1FP254eIG/HnuWMqigRcaRvNlmspPbfste9ZR4muJzrr884YF6c45FDVXecmQ8dRjl4ZEug6UrkdHzD28yaY+B+R0/TnFZ81WOohIqpZXTg/i8nCxCsSEq5bNWHUBzE/8YAwX2ds7QY4btllNQm/0EUYVOSiYUNkYJ5Zm4sn8eVl5CBBFJwbvGwMpI6cTQAGCZzgX9bMTvjmjPe2I1fj4amQeqYsYMGpVxswtg1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3xD7vw8m0RO/Q6K5JRIt6mRvTK1wpxk31Jp9CN8r84=;
 b=Kd+2Wmukb2eZvQheO7DxVgJUEtUVUvK0VIhkCo1lTqwO22FbbI651A/s/Iz3Ld/MJLFXLvmgiDEjlqA+LM5iHUyGOSE62RinmsRbfuQtNBEz5qaf/55q3Y06Q07CPNJ8lNYmiJONpOGQXhSbp/0k1fEs5YllDv1TwCi0pLnvl8o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 10 Jul
 2025 15:50:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 07/10] mm/mremap: move remap_is_valid() into check_prep_vma()
Date: Thu, 10 Jul 2025 16:50:31 +0100
Message-ID: <093fb54b5dc0c4e21abcfebb57060f9a016af216.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0492.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: dc41ae75-4ffb-414a-bbc4-08ddbfc98f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2uPdzyTLBDPgAmF3WWDjT6xDa2W2PUGNNLpupSunjZodEGrKXDRnkITrsTy3?=
 =?us-ascii?Q?GCgGQdEb5yOKuuL52tt0hKroLwBc2si3c1TYTUvbWXqbSu3eHtT5K6sMHjGL?=
 =?us-ascii?Q?xndpNmqHfyyZkqgE2FQZ45ohCF9+dtv47DFPpMzaTAUnIlfCBTySdXeW0hL2?=
 =?us-ascii?Q?/7TU+qcdMy41hT8Jn297ds1YQv8gt+xXLf0v2CcrENbifvvorDPlhAZ9nwhz?=
 =?us-ascii?Q?GBfIaJj0Yg16TG2CNBdGP96ufXUfrmQAa/u1kCn0hyc4Cp0BBgDfqcux1g7B?=
 =?us-ascii?Q?aDSrB3W1IfqLuuWPMw177TAX064dgGwQf3UToK+w8Fd7b2JEh/R+RTTdaBM/?=
 =?us-ascii?Q?parQMgEqm3OU5ITWz43u5llx8UE7d0rfI1baaqPFJJmNRr77BtGXjb6sF+H4?=
 =?us-ascii?Q?K3RvQUTiK2Na28GgnJER/LSlHcPAgBHN/svOXnk4dFIqbqMDjkc0AkjQVlEf?=
 =?us-ascii?Q?RsfGhT0cawzq8TltwRn8/NZd2RKt4qFS88g49LWyrzKzi+TiCa3D4YhdVby+?=
 =?us-ascii?Q?CGzJ5bjcOObmIh9TFFHys/jtsJ+PBQNp4ecntsfynZ+vCazSnkg9MPWqc194?=
 =?us-ascii?Q?BX26Ki02lK7C7h5QUirkfDcxZ62CAM4OcIaGKCfTJKa/yIrWtWgwenHi7Bti?=
 =?us-ascii?Q?qlSlbO57J02JcX0PmOQHOGVZQ46bPGjbKWTmJ+ZdUZrBjy/9nQWSEAhS0VJv?=
 =?us-ascii?Q?tAsUH1eKpjrSehX0D78HTa6mPost1VjyfmUo8Ek2mJcIheXJbXRGNvwH5g1X?=
 =?us-ascii?Q?RhFfVFtsOEUo3HlFgY+wTp9fIjCz3MEL4kLcsGbNggasaNy0IcmzCzI4megE?=
 =?us-ascii?Q?rEzfLfCrdgqjdUVn3mr13KMT7KIyoc25MlS186DAQYizWTF/9f57+thnFKwx?=
 =?us-ascii?Q?mV7dqJM7s6rVy6GMQLtyNIBP9EJuP8yWcx0Q1ZWBwh+4ThxQMrNaX2iLLZzE?=
 =?us-ascii?Q?K7djbIYuMY4b4Tc5TyNeNI40l3lUzw12ezzcBDlh29A4MhqrflCyQCRS9bV1?=
 =?us-ascii?Q?y6PuR04K34nLYAgdbzMHE9F4ONhkeg7bNRbV9HcuT95l0SCfFH+yvnT9cO2/?=
 =?us-ascii?Q?jT7XnD7mpb8zmUsyotf1Rp1TtrRBep8DmTqcHht/nYWdgVF8eQFJEQImjmy7?=
 =?us-ascii?Q?Ra3Vme5t3Nr1Ard5wLGIro52UueSRvhsWoU1kFlmfzpEos0ZMPkxKM1yq4ET?=
 =?us-ascii?Q?9OpvSoCPgyCiCn3dLv4BFgsYeqTJeLlWw9AcLOUMQNMwuBP01HXi5EwKKkLX?=
 =?us-ascii?Q?YRubX5A/M7wCnYaC6hQ8XygmGWx6dQF8E5i3XR60IDntMY1rXKsU3sN3Wrpo?=
 =?us-ascii?Q?stL8wM64q9QaYBRdTsle/vw/q16rwGagKL/qLuqUZNO1G3+Omzw0iNtrX2/I?=
 =?us-ascii?Q?vaZyrQB5HOkls+/qZlRN77JRc0Y01Wqz/Gp1qidWsazpl4TCilfKOUdLwUJk?=
 =?us-ascii?Q?sgUJYJYzrW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phdKExDwQpqQ7bPHyeAVoEuoQlDZ1izR7EjBhIDZvCG6E1izzRpxKX5890Ar?=
 =?us-ascii?Q?fr6ak6B80KpVhnNeXLmQqOld5Q/EoLZbRHjrqlvKU+6nt3qgQLMBk1rymCqC?=
 =?us-ascii?Q?+GlYXO7uU7Xktj61GhnBS1vzgmfNve54HUJO/pFxbtM5pYy44is3p0bkjN0o?=
 =?us-ascii?Q?1DxRELxQnbd9hzJW6n4wxD6xTVQ/ry4t+O8+Jghptd8qZ76dtVp5xnpjrOMi?=
 =?us-ascii?Q?7IH0ZmluTtunGdqG4oh9x86eXeE3fwtnBR0xelaf9SpvGuCkugctA9HYf5Ja?=
 =?us-ascii?Q?SaxhEhT6mV0TdzKKqJuinn+mrxlmxPynbub4Lzv8QHsDDfbhCAoGuet2t2D0?=
 =?us-ascii?Q?tHJVbyOELRF3WvAHmfvja7oxaHnCKl93pb8yPaawHTKIRhgi7Bs/QLUmbadU?=
 =?us-ascii?Q?XRSzH0pLynhka0YD8n9l9UXK3+FLSimRPdwjx52tIaI9RSdKgsIThlVy5Qzk?=
 =?us-ascii?Q?pnmGwgraJ+aYn85MMNMsq6Dlr+20pxSgQM0Z/591IlVpl/aTsYIbqJ+pJElX?=
 =?us-ascii?Q?xkKFvqoolRyI+2MQ8f0b/7tU5r+c8x4RJZdrRTWyZLh/3Y3Q8WKcPq1kUvsV?=
 =?us-ascii?Q?DZYEG/eho/UT5+bqO7pKQZYnzBEv61c3LNe9wgokm9As637YY6XEMCxISQ6S?=
 =?us-ascii?Q?v1vHkrH84p+DCQvLvpRGP0MhS3ildneAvpq03SPX1pem0YopOmlLj9zRbfEE?=
 =?us-ascii?Q?wDVwg+UZ6W3dVfjhP5EYl4lY0fht701bTRSIrAI45lLcqrnVlE0havc4z+WB?=
 =?us-ascii?Q?X+ALJ0BRG7H67C+VRR5Iksf8t28N65r8H0hS1RLLsaGUIQEwwhlXu3o4H0zJ?=
 =?us-ascii?Q?gajAQNctkQBIqTZe0Wwl4c9Wx7LD8mos4GGHl1w+48q32uBOLoDbmfuu0enH?=
 =?us-ascii?Q?3wonafPRs19v7/UiW3AHTmPsUmC+oI1+gHDx49raOcT6E6sz2ONBG2rwsFbC?=
 =?us-ascii?Q?pK5cFM0/5By+SFcnl0UdNvoomajhTCJvp7wNtAG6qJy0tkHUJBif2//8D84i?=
 =?us-ascii?Q?7ehDDlrm6YCE2hZwzcH54pIDjgAxn5hDEK/kvj01Qt+2M5P6VZNVeOzdFHAp?=
 =?us-ascii?Q?SU+B1C2FOFstabq/fr9olcxY+02cccH8t2GhKD2iP/8gzjkm+Hq866qj5KKu?=
 =?us-ascii?Q?vTlIATOEhLNoGPiBG6B0OVThjL6ZhacEeZK1+Y/+ZD+ouHmBegfNTFnK/roO?=
 =?us-ascii?Q?YlS2oxXypd+kMhaIuvEcqO4pVcJP553UYUCd6YPiHS0cB5588poeEzX6V69C?=
 =?us-ascii?Q?RhGzDfbM3cvEvatKLWJW4rJPkkjD8GpbOh3PbkhY/cfCZj5hy6wIEAhXW2a4?=
 =?us-ascii?Q?4xC2m2A/8aibxX+h9TxqMQUPkWZ9AocKbc4z7HA5jAd19GOZBJzvFp5iUsJB?=
 =?us-ascii?Q?X4kTszNn/KX/aYNWv/a4bU0WeIck8IMo/ORXMFCqJZyKa6dIsqgqyYtKffA5?=
 =?us-ascii?Q?VS6B+oFLoA+rIiyuCk6us6A+qeQKv+PCA3/LcJkex/iyHjGSfCFNAcKrShQg?=
 =?us-ascii?Q?+uXBt1nUIzyo/31dyrDmne4kI9zvKbgs1UMHA4DHW9Uojli6WvQVyhbGw8pT?=
 =?us-ascii?Q?v1vwAPoXiDn+WXgD6vKgFzP8FCh4Qo9Qf15vY/Mz1BYQUfMqlTENvjDoFrPX?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yu6zeWWv5WjsEPl4wED9ssdhS7UGSIr4PkSLKzdDLtrwKpy3q8szF0fJAUllk9plVasKNnWPNClQuTT34rCrUt6Mh9/TD8Ppr9OkJbKcE1A406BB+xmD3waPzW/TZ03WtxfHvEMxLjgYI8PlD5m6iWT9JFeJ0wHfah375ZPcAlxWer3Zo2Ie8Jga4AV4EIBrG5rdd7E5EIX57mzSzBnbk7PHo4hxfBVf4Lx14812OPe1rp1bb6Hhb13sPHwy5yqeR3o9ouXGom7JohZmXPOT1y0E8ihVCuYtyKEvs/jVMUMMkcdrFxm9bM53o+muvlhHoLG7NRsGevKEnogKmRHF3vLgr/TiwBDytHF5yBkmjFH+bzFU+klgiYF1xIE5jyMhsSCjSmRecqLAGUSPIz4W+uRrSI9D8SGPB4U6FaaM9nkODSytaWc4XDgKdDie3HEjvvJeuAsS3Xt5LCs5l9iH4YqM8x3II3pVVjx94YJltUWsf5fnxWuoQEx0iqwtjGznW9stHZk91u5RTTBxJPwSFue8OYWUnTwn9vkHLkuz7/+vnY4xqL6PTq0M60eID0C/RscR4xGuqVk66Kb0/ErfMZpC1ri1ocoZy6Fl6bYyyXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc41ae75-4ffb-414a-bbc4-08ddbfc98f80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:57.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7eO1B6M+JEpsOsxcxVKY86wl2tZE8MbNqaorWHemPERD7ygCpmsEBudF5iieTfnCWV5sRqYJHS1oBn5RUk5OxE4g0g2E1s60eSbIESxY5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-GUID: vk0LbvcJzpBh9VKIrDMk61mazqIeMIke
X-Proofpoint-ORIG-GUID: vk0LbvcJzpBh9VKIrDMk61mazqIeMIke
X-Authority-Analysis: v=2.4 cv=X/dSKHTe c=1 sm=1 tr=0 ts=686fe166 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JNHyDlmCLAJVxX-Ft_0A:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX2BH9H48Q12Tm /D+3LCNEz/7LLqDedx4Zvf6ja//lJKc0t0rZdUXX2Vm9i9Fmo8RSys/a2JoKtg/KK9PA50YhLgD d0swSYUDt50qu3c/XRleFO+tZmOFiA/fV+3oa3mYDMc99D6gNPKVrCFlTZJkrFswOv+F0x93gsw
 uGRX4vaDGj6NTQiJHpbuX/LdfShzrAifINggtZjM81M/xe/EtqbrXor85hCqOmU8fJgTflU/4Rh sN75gO2pyNxNJTrE8Clj/oDnOQTVR4vD9RHBKkQfiBqEMQRNuJSEmXhaEh4p3GVTFdMy/C7nkA8 Kr4iQ/b9YtLqxH5q/Y7xzhfIjltFbMauE2lHCzWoHSIr/dMJAkYMrzo5F57FWdB17sg2T9hrDyM
 msdQIM7h9vYGGnEEc+GxaK+HibRnGCoVaT/QdJLH8fqPr9sDlgOWC7MfwZzfcM4tS8nP5FHm

Group parameter check logic together, moving check_mremap_params() next to
it.

This puts all such checks into a single place, and invokes them early so we
can simply bail out as soon as we are aware that a condition is not met.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 273 +++++++++++++++++++++++++---------------------------
 1 file changed, 131 insertions(+), 142 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 116203766ce0..3f8daa3314f0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1308,64 +1308,6 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	return err ? (unsigned long)err : vrm->new_addr;
 }
 
-/*
- * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
- * at the given address.
- *
- * Return 0 on success, error otherwise.
- */
-static int remap_is_valid(struct vma_remap_struct *vrm)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = vrm->vma;
-	unsigned long addr = vrm->addr;
-	unsigned long old_len = vrm->old_len;
-	unsigned long new_len = vrm->new_len;
-	unsigned long pgoff;
-
-	/*
-	 * !old_len is a special case where an attempt is made to 'duplicate'
-	 * a mapping.  This makes no sense for private mappings as it will
-	 * instead create a fresh/new mapping unrelated to the original.  This
-	 * is contrary to the basic idea of mremap which creates new mappings
-	 * based on the original.  There are no known use cases for this
-	 * behavior.  As a result, fail such attempts.
-	 */
-	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
-			     current->comm, current->pid);
-		return -EINVAL;
-	}
-
-	if ((vrm->flags & MREMAP_DONTUNMAP) &&
-			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
-		return -EINVAL;
-
-	/* We can't remap across vm area boundaries */
-	if (old_len > vma->vm_end - addr)
-		return -EFAULT;
-
-	if (new_len <= old_len)
-		return 0;
-
-	/* Need to be careful about a growing mapping */
-	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
-	pgoff += vma->vm_pgoff;
-	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
-		return -EINVAL;
-
-	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
-		return -EFAULT;
-
-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
-		return -EAGAIN;
-
-	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
  * execute this, optionally dropping the mmap lock when we do so.
@@ -1492,77 +1434,6 @@ static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 	return true;
 }
 
-/*
- * Are the parameters passed to mremap() valid? If so return 0, otherwise return
- * error.
- */
-static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
-
-{
-	unsigned long addr = vrm->addr;
-	unsigned long flags = vrm->flags;
-
-	/* Ensure no unexpected flag values. */
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return -EINVAL;
-
-	/* Start address must be page-aligned. */
-	if (offset_in_page(addr))
-		return -EINVAL;
-
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!vrm->new_len)
-		return -EINVAL;
-
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	/* Remainder of checks are for cases with specific new_addr. */
-	if (!vrm_implies_new_addr(vrm))
-		return 0;
-
-	/* The new address must be page-aligned. */
-	if (offset_in_page(vrm->new_addr))
-		return -EINVAL;
-
-	/* A fixed address implies a move. */
-	if (!(flags & MREMAP_MAYMOVE))
-		return -EINVAL;
-
-	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
-		return -EINVAL;
-
-	/* Target VMA must not overlap source VMA. */
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * We know we can expand the VMA in-place by delta pages, so do so.
  *
@@ -1714,9 +1585,26 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+{
+	struct mm_struct *mm = current->mm;
+
+	/* Regardless of success/failure, we always notify of any unmaps. */
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len, new_len, pgoff;
 
 	if (!vma)
 		return -EFAULT;
@@ -1733,26 +1621,127 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	vrm->remap_type = vrm_remap_type(vrm);
 	/* For convenience, we set new_addr even if VMA won't move. */
 	if (!vrm_implies_new_addr(vrm))
-		vrm->new_addr = vrm->addr;
+		vrm->new_addr = addr;
+
+	/* Below only meaningful if we expand or move a VMA. */
+	if (!vrm_will_map_new(vrm))
+		return 0;
 
-	if (vrm_will_map_new(vrm))
-		return remap_is_valid(vrm);
+	old_len = vrm->old_len;
+	new_len = vrm->new_len;
+
+	/*
+	 * !old_len is a special case where an attempt is made to 'duplicate'
+	 * a mapping.  This makes no sense for private mappings as it will
+	 * instead create a fresh/new mapping unrelated to the original.  This
+	 * is contrary to the basic idea of mremap which creates new mappings
+	 * based on the original.  There are no known use cases for this
+	 * behavior.  As a result, fail such attempts.
+	 */
+	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
+			     current->comm, current->pid);
+		return -EINVAL;
+	}
+
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
+			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
+		return -EINVAL;
+
+	/* We can't remap across vm area boundaries */
+	if (old_len > vma->vm_end - addr)
+		return -EFAULT;
+
+	if (new_len <= old_len)
+		return 0;
+
+	/* Need to be careful about a growing mapping */
+	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff += vma->vm_pgoff;
+	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
+		return -EFAULT;
+
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+		return -EAGAIN;
+
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
+		return -ENOMEM;
 
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
-	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long flags = vrm->flags;
 
-	/* Regardless of success/failure, we always notify of any unmaps. */
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	if (failed)
-		mremap_userfaultfd_fail(vrm->uf);
-	else
-		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
-			vrm->new_addr, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!vrm_implies_new_addr(vrm))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(vrm->new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
+		return -EINVAL;
+
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
-- 
2.50.0


