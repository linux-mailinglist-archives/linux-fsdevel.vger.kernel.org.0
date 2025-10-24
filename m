Return-Path: <linux-fsdevel+bounces-65408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442CC04CB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428001A05121
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AA2EAB76;
	Fri, 24 Oct 2025 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEl/6oRP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="svbtnMW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE82EBB8F;
	Fri, 24 Oct 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291779; cv=fail; b=cZBDlF1Sw3oQl3kiNlm9NZrAspfvIe3Ct6RPrcu5O0dh63B/V2BHpTOBpwqx8178SWa95hY4mI+CW8QBMIGqMXnqeCevBX3VadoKYu8bQpYvSol3OgZksWIO4F0JOSyHDSJqwyAtIEh/pE3etx+/a9N5IJHrlLX54XXbxCdPju0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291779; c=relaxed/simple;
	bh=Zigb7uAzz/L5UBmBkAqoPlrtqGlJP4sbwHF9J8lWeGA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BhQ53jKwA5bgaN6qtTMjRI7qbCRXLsYe8bnFgRm+excLtUe3UXJ8jwhmV7rnnz8m8LzHI+EdzRD80aWqFJIw7sWfLFpJoJESOLs3U4ValaIcnZlu+QrfkJtkWSNPa2Gdsppvu6hWEAY7kGevioizTzyQac1BuBZYabMONOc7xhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UEl/6oRP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=svbtnMW1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3Nwjt029460;
	Fri, 24 Oct 2025 07:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=sSZYVBFcW/5v7hpq
	9Q73Mb0dFXewwstI6n5IO7o9pE0=; b=UEl/6oRPCB+PGVtv6LpPi8O7azm6SXqC
	cHKMvdHKy67ULH6PE75km92b9l3TIl53539F3J3lYAxlxvLuKR4r1V5WAQgYgMsQ
	Y0Pj+a02oa8RYXD6AJtWt/zRHLE9xC40eRTbqxXpBrXL4rnXNAALbLa98erDWax7
	fpGFQna4YV3eKEEQ0qU3gYdVD298DfQdqbzXNjavoSmfIHUk676VMXTKatHhx/pq
	LNOWp2Ny1F3HWncPFhIqs33lUrH7Nc1aWmxAbqMoK8/MSMfxhT8vzudbT6o5hb5l
	q2KfBifvCdTHB0gXbYWvXdOwOeQgcOxqfmhpH4yfdXEYoXVIvORXww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0v4j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5XXRc025338;
	Fri, 24 Oct 2025 07:41:43 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwka2vqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJF9S5RpxvkEZacBq1Kqc6WW/B+SiJg/sq6N+Oz3E0WnREXu2M4iROzVeM8p43crsJ5DkaxC6xVMYdNbXlboR1YC5JR7L6RzsjVLdYr/lQ9VmlKFd1MNTKiEQdWyq/X0CeyxTokxi2jA7o5gk7yu48GDBbrkhRiIVu/wWf54qFkQNRm63G5K4AqEC3y5ugMHNDcA7nRF71lWXCCqSNmgBJlPn/UShoIXUAk2S/7fb81oHaZY44TQH5lO4A2JhP9RqojrHbZ+TRMWGMnpsQ8ICxO9qz1Ftkmsg0q9GdwyEs9w9ShrvHGYwHAQ9VF2JBprJfznFlC9GFBrgAMHlZQPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSZYVBFcW/5v7hpq9Q73Mb0dFXewwstI6n5IO7o9pE0=;
 b=zPgUUIxgAKvbl+xGvlpKhIL/MSZJ78J0LaJpxAJ2p5DQgy+gaHD56nJ9RZJ/vGn1lQHISm4vZrclVoZA7zI9a4b9hYJqK0hR99XYFPeJQj9OdkVE5GwZHHmGJLBXX0ej9PFgsQ6tpUGIYuQEQ+rkKXU+jMzPHfxa41LQ4gr212oKckMVn2CX8F08jTVIBlQwTyNLX9zZMfrdBV7BtbyfQcoAwD1Ls1g4SO8x54vv9Zec5ji1sWMPxSR3I/w/PY7FcYo6Wo6tboBMMSCXgMPKuVVVmt7Jtv31bvhf1LkOc9ERl2yNDXitNUmdismxuI9XndDobfbrKzvQX6LFMV21MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSZYVBFcW/5v7hpq9Q73Mb0dFXewwstI6n5IO7o9pE0=;
 b=svbtnMW10JpG/NfFRoCNaUUwR1QkGNKbWTVhTbQHmkbEfgdGREzUzevwnq2MwQSMi3c1WCrtL6va9Yia90pfNFvUPKFpEQAwqMFflMw3c0IVrThOXyrMpi+GlaTfogPxLnZa1+XZF2D456hoIH2MvziJ7KyxWdO1vI92ibpQhhE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:41:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:41:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap confusion
Date: Fri, 24 Oct 2025 08:41:16 +0100
Message-ID: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:208:55::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 466332a9-a3f5-4b90-1887-08de12d0c4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJd8n8K0jVbooFhdq54cUvDtgrEXqh8oZqI8bHs7hRu7BMd/o0OMVhIFiC6J?=
 =?us-ascii?Q?axsy0pjL/zbNZubarHJ4ijd9pfrXFb8eDl0hu8zCEWT4o5oSIwx6OqOW/gbB?=
 =?us-ascii?Q?1PBlMYEGHZJ6ByHqKkGyFXMQD1nrGfOUgtYM8y3p8wm0F4jHHetyvd4vSuJ7?=
 =?us-ascii?Q?hFYeR8bhCVVEyaVCEMJMFhHLHbIxIENhcLHBJZ1iKfy3Jd8eBjQqZl+ODilx?=
 =?us-ascii?Q?A3MLFMFBQMvEJBpvynqKH4VagDjmEignztJDjgwGZ6NQvYEo7pAxd/aPBpPb?=
 =?us-ascii?Q?YKtN7bi6dVjNQqfaQVEY44GOdAtZJLEAy7casouHR/4MkyiZI/c8WJIe+gs7?=
 =?us-ascii?Q?OGAztwycbmrwECeMEJlSZcajD+INlfHe+OKxNii33obPrxRfkX20GGDUUHL1?=
 =?us-ascii?Q?BcYenY6HVlqq/B3ZzKCgO47ATYkxkxcmrUXMycEVIsDt0VLoHAGDXyFlXPed?=
 =?us-ascii?Q?4a0Nq0a95K/gzrE9pvoz102AKipaCJsR258LiZ7vLvSALPqOCc5lD2Cfhzi9?=
 =?us-ascii?Q?FBOmkXtakvaqYDO76YBrfakN8WsXrbRWUPA3CV1bfrQY5J2koKmfGjOZicBV?=
 =?us-ascii?Q?UUdpoIUne+qAGmoKw3lHuK1aL5wOHTdmveWrHUIrES8ZMcXXnTYzYkBWiyHQ?=
 =?us-ascii?Q?m3RkSMy5aVtuM/gpyV2mQAMMGcIQweh+rp00hk7G0j/3OoLfPPoZ49ZeMZq1?=
 =?us-ascii?Q?HOVjP1NWQMZHZmGb+jgom0Et8JcmkIp5IcUcMAIEOSDccXyHJUxJ25z7sZX2?=
 =?us-ascii?Q?GDrebg52YfaJHSbLnlKXyc+GTEXnLhchEu69e38y0Ugv2C0UK5dnjoAj25T3?=
 =?us-ascii?Q?gtxxiHhoUQIsYVC3aCRaZuqNlodb1KbfVXK6Qfg5RyvTq6ixUBFmtLcBx0PQ?=
 =?us-ascii?Q?QCG9SREgfJtZJM/6/C23g3HYIN5iyivJ2GB21evpYzZWqHZ9ijoxDhhb/WgU?=
 =?us-ascii?Q?l95tClBHkP2nOiYHpZ+mkeGQYnngIeflqdFQTyLLoic5rGQ5qB6QxEHT06Fd?=
 =?us-ascii?Q?viJcWpN7fNf5QnCE7YZ96s66ZKFAEWVjvHTRtWcMSqFvQNQwanCLBD5s/BXf?=
 =?us-ascii?Q?mFHtvjTMpj7a4Lc4/+4qwH9R9YidibWksulmYbR8R4ZXDyX4gmEKhGw8sX5E?=
 =?us-ascii?Q?UmiiuVqxNxvp4kcncUKo//Y8aLgVF0vjuppSYwaVocUB7TCcVnh7MJLX0V7I?=
 =?us-ascii?Q?ue+Lji+BX+Ws36YuLzZeuLnORFLpLW5t3jp/NDyw+0X24GPjU2vRyyvrjxzf?=
 =?us-ascii?Q?i1S93kmd+J6P8MN1mCmTurNO2+uyIxnIG+cYicVtCBCkp54baaNN5C4Yzh0V?=
 =?us-ascii?Q?F+z0HCQJQdvKSGl7qVKuz+pW+2t+tRDTKrs9lQEtaZciGofLKeIXCdDi40mm?=
 =?us-ascii?Q?As2sTfYqSIGVVR5HQJCqllQUcWfA54Krcmh9aQLL/0ChKL9cGpRpjgsmTpkj?=
 =?us-ascii?Q?VoXmfj9qX4D04VTRv1cFBpQxBW7wsart?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IU2cAbWd2ym0ZnTZVjS2ydsRJmCceqyVBB1eiK77RiF1JREZO8p3SGSy0S+Z?=
 =?us-ascii?Q?CgC+UoAt76qVGLuPuUWXmEtHkmYWfCHb9zcMYnos2NsoBfvj1QKwF+W0Jxpk?=
 =?us-ascii?Q?61Wqw14lut1xCabX9l7GBCPv5sh7FVIef/KihmvLNWHz7sQMixp9BVPzdQIO?=
 =?us-ascii?Q?KDGWBHU1lRmQA2+/eLy9v9ub99BpEVuT7Lm6H4OxsSv8iMfedfGDSqr+eY8N?=
 =?us-ascii?Q?mXnj+/tOoZyrZWACnSZyTTCjp3kk6FgWERdcZbA+y9hCmGsrDTwBH7DQ4e50?=
 =?us-ascii?Q?DTIjjlJG/CgT6S7ACkgJ/OdExqcRXzqgz8ANVU1VubHaDd3WpO9PdHHFQZ+b?=
 =?us-ascii?Q?csFPu7ga/VZXnYioHzJyy4g/9znE85zceEFgy169aZAohdYsjQXfxMo1tU7Z?=
 =?us-ascii?Q?Ir/70yxKLw32YSjbaBTjjV0thUAC0eNYHnhkk7k+Vrhi9SYYFfjS9acwYXm9?=
 =?us-ascii?Q?NM2cY02vBG1RHngB0gh0iN67KvCHqQ5B6073XBIE5SooWXNGa0za4aasVugd?=
 =?us-ascii?Q?VFsn+D6g7FswdvpIibP3R0O5a41zg3+85xycxOvlN2/TYf5WVYZo1a6ygomg?=
 =?us-ascii?Q?f4uTBwFEFOnAtfbmXlIJxADKz3+Gdu9jgSPLDj5u215RoE/jHtvyPwpTHC+W?=
 =?us-ascii?Q?DTKr/BISXk9e5fWm6ubmds9Su1mGOWgssca6zptgSPSoqRLjy4d6NTumgYN0?=
 =?us-ascii?Q?GokZ2kR+27R1Occo/l8Ni7DzxgGpbrs9Bbqq37sQQUPU3xrW75ZZbzEiUOK3?=
 =?us-ascii?Q?H7MScNn6J/snMfoSgbIuT9MgMnhQhxFBkS74Ak5yVvxMsNQUY58vm7yVsk8j?=
 =?us-ascii?Q?2Ygh/hc5JNNcWQl4p3FdFZ4Jq75OKI1bNIfL4hAWCe1g5pquXzgxEYV6WT+u?=
 =?us-ascii?Q?BJ03EY1YDzl9V/t3YqHRybeI8lYn4coDDikP9sdNUK8fzbUXrQgeFSz+yb4L?=
 =?us-ascii?Q?IWlX1fZjIRcL+ioT9PGmtiiFpNMdDjLJ4mlcs3TkyGWNsCmMt5soEHZmj1g+?=
 =?us-ascii?Q?XB/kTkEvfXvfz4nwv20cr6ggFvkGfZkCAQCvNy4KvPNiJBLrIqr08Koz9YbA?=
 =?us-ascii?Q?OGbIn5c+4CbXKWI0lndoHua6YoAFKUac3T8jxHoJs0/FfdXVyssJKAiw6fuG?=
 =?us-ascii?Q?dyuZtdVktVU1no30HyhCmBRfbajdmF+ZfxzcxBIlMPDHYK5yakniNNJc4Ic1?=
 =?us-ascii?Q?1B/ZTU96dKr8IkASb8THgiKgt5kyUyt11czsYpLRWuW+tz2AKSkBTE2fZLHB?=
 =?us-ascii?Q?wZUHDlo437kiSF7RzAx5tVnjf/U9ARzrMjXixA5eapOAO5GO4Ka2YtWQTylD?=
 =?us-ascii?Q?JV+zztZTf3c028HPTa6W5JBo0uoESlxnbY+XMUaIn8lKa+TKVmzTEVEDg2lr?=
 =?us-ascii?Q?9S7CXiuMrMGp6TjhJoDwRvKIKBPWiICliXP8F4ZuVd6X+heKQ8oDsB4R2Tsr?=
 =?us-ascii?Q?0PLvEHD/kFiMyzZSLga4GBAlfLsH7kihbTM6GCFsNGqgvlBUMkPD/K6gfJgX?=
 =?us-ascii?Q?4bafp0mJOHnzqniUxGGyG5Q53Jf/11Uvspwfisc0xIJUjkMrR00oD491hemL?=
 =?us-ascii?Q?3jNPzaxgtWsStEMEcmYEg3utD/o//LQa+JaHsWllda1MaDwfDWRSM+nSs9vJ?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1r/4l7v2A8FLNQgJVLf+7mMD41SeegsCZYRrL0T0M+olEyYcAiGi7tAvP9NF9HCzjXoDmyynRR07ESojvcSQn6d9WRIFhRBD8vkbOzlrxAjyOsaxxOJee1y5nFb+8pSetYzVAIsKSTaxvTNh2sCv8KK8YC6ymNl1kQuZ/NYhO42DEKPB8T6Rp2nkj2LhembpgNh5oEPCGEYv69xZgjP6fAvzxr4E5IoiEGxiza291SV5nxrheRJATujJNbDK6l2YqxjvI/G1fth5rzKt2mHB7QaTQhrgSymomftfzi2OEWe4q5mWXYgWwC+Ry/8zXZFyL8HD2NLPiyLNbklQtHm3lJ94E6TQ1KuNQyBcQVuSxO6yAfjsLhXtAShh0ghzB+SxWIcExl0gClPx+yPtxHtLaETGUybXD55eal7a4ax7sL712ovOMyjJ44415ySXtOk2g0rmbs3GIkXtY2x3QtJxgaiqahdH3MgkexebGyOaWO812j2Q8S9bwwUXZY1ppQ2gHj5pilx74ggMoy5XWPvKSMQtFvXYFx/bQH5Qx/IlUZ0ooP98/wW8SimV+MtbbNU1TQ8422BqVrHx7SDT3umN2H1zX7OAxf3+jZHmW8GtGDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466332a9-a3f5-4b90-1887-08de12d0c4bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:41:39.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ8C1AdC3SH2aWwWBTEG5J0U7kWUPu1gbQxFIQdWB18oFYq58uvq2kIqCfHj2L9gYi/DnsqqpZjsHCYeADK40J7QnwR597qtzpyJNnVBUDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=744
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240066
X-Proofpoint-ORIG-GUID: ZR_Lq4zryPmS_cU3JEuNxosJa__GHAOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX+Eya0WfN+PMJ
 KxJ9eWvsmqWyIA3ObpNqSb32L02IrVF9U2mO2GHsNAKZHVBZZOpDyv+QWfth+gZeHYeydXptZmO
 KzMnyNRVXYoPJVNjSBxG5kPW+4kZjtTMlI6EjNYvffs3T5kAsmzGTodN8cw1gDgJ3t1WcDtbjsJ
 pjxRE4y5+gS3ONvVu8rJX9OfXuFP11vI7UBIiSbnTNU3PWY9tRup3JS+3F/cIjmX9wdHufRld09
 KdFqwf67t2Tr9lcBJL1taUgirHJcOohAmPyXt4Iy/z75J+l6zpwTPTrA5WkKa3vnRdHbyk0sxwS
 fkEqkvheT4DS7iHwHwqeIZ78i+X8OpT+ALOHHwNSJO8+wMLLcFeQb0+bvTWlzPRLiTftbi/uNH0
 iSdgKMabQpqhgVJQKmwYblmvuyL2WR7toiXarb7c8uJxR91AaXk=
X-Proofpoint-GUID: ZR_Lq4zryPmS_cU3JEuNxosJa__GHAOF
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fb2db8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Kg6MBjzDyotcYq-Jm4IA:9 cc=ntf
 awl=host:12092

There's an established convention in the kernel that we treat leaf page
tables (so far at the PTE, PMD level) as containing 'swap entries' should
they be neither empty (i.e. p**_none() evaluating true) nor present
(i.e. p**_present() evaluating true).

However, at the same time we also have helper predicates - is_swap_pte(),
is_swap_pmd() - which are inconsistently used.

This is problematic, as it is logical to assume that should somebody wish
to operate upon a page table swap entry they should first check to see if
it is in fact one.

It also implies that perhaps, in future, we might introduce a non-present,
none page table entry that is not a swap entry.

This series resolves this issue by systematically eliminating all use of
the is_swap_pte() and is swap_pmd() predicates so we retain only the
convention that should a leaf page table entry be neither none nor present
it is a swap entry.

We also have the further issue that 'swap entry' is unfortunately a really
rather overloaded term and in fact refers to both entries for swap and for
other information such as migration entries, page table markers, and device
private entries.

We therefore have the rather 'unique' concept of a 'non-swap' swap entry.

This is deeply confusing, so this series goes further and eliminates the
non_swap_entry() predicate, replacing it with is_non_present_entry() - with
an eye to a new convention of referring to these non-swap 'swap entries' as
non-present.

It also introduces the is_swap_entry() predicate to explicitly and
logically refer to actual 'true' swap entries, improving code readibility,
avoiding the hideous convention of:

	if (!non_swap_entry(entry)) {
		...
	}

As part of these changes we also introduce a few other new predicates:

* pte_to_swp_entry_or_zero() - allows for convenient conversion from a PTE
  to a swap entry if present, or an empty swap entry if none. This is
  useful as many swap entry conversions are simply checking for flags for
  which this suffices.

* get_pte_swap_entry() - Retrieves a PTE swap entry if it truly is a swap
  entry (i.e. not a non-present entry), returning true if so, otherwise
  returns false. This simplifies a lot of logic that previously open-coded
  this.

* is_huge_pmd() - Determines if a PMD contains either a present transparent
  huge page entry or a huge non-present entry. This again simplifies a lot
  of logic that simply open-coded this.

REVIEWERS NOTE:

This series applies against mm-unstable as there are currently conflicts
with mm-new. Should the series receive community assent I will resolve
these at the point the RFC tag is removed.

I also intend to use this as a foundation for further work to add higher
order page table markers.

Lorenzo Stoakes (12):
  mm: introduce and use pte_to_swp_entry_or_zero()
  mm: avoid unnecessary uses of is_swap_pte()
  mm: introduce get_pte_swap_entry() and use it
  mm: use get_pte_swap_entry() in debug pgtable + remove is_swap_pte()
  fs/proc/task_mmu: refactor pagemap_pmd_range()
  mm: avoid unnecessary use of is_swap_pmd()
  mm: introduce is_huge_pmd() and use where appropriate
  mm/huge_memory: refactor copy_huge_pmd() non-present logic
  mm/huge_memory: refactor change_huge_pmd() non-present logic
  mm: remove remaining is_swap_pmd() users and is_swap_pmd()
  mm: rename non_swap_entry() to is_non_present_entry()
  mm: provide is_swap_entry() and use it

 arch/s390/mm/gmap_helpers.c   |   2 +-
 arch/s390/mm/pgtable.c        |   2 +-
 fs/proc/task_mmu.c            | 214 ++++++++++++++++++++--------------
 include/linux/huge_mm.h       |  49 +++++---
 include/linux/swapops.h       |  99 ++++++++++++++--
 include/linux/userfaultfd_k.h |  16 +--
 mm/debug_vm_pgtable.c         |  43 ++++---
 mm/filemap.c                  |   2 +-
 mm/hmm.c                      |   2 +-
 mm/huge_memory.c              | 189 ++++++++++++++++--------------
 mm/hugetlb.c                  |   6 +-
 mm/internal.h                 |  12 +-
 mm/khugepaged.c               |  29 ++---
 mm/madvise.c                  |  14 +--
 mm/memory.c                   |  62 +++++-----
 mm/migrate.c                  |   2 +-
 mm/mincore.c                  |   2 +-
 mm/mprotect.c                 |  45 ++++---
 mm/mremap.c                   |   9 +-
 mm/page_table_check.c         |  25 ++--
 mm/page_vma_mapped.c          |  30 +++--
 mm/swap_state.c               |   5 +-
 mm/swapfile.c                 |   3 +-
 mm/userfaultfd.c              |   2 +-
 24 files changed, 511 insertions(+), 353 deletions(-)

--
2.51.0

