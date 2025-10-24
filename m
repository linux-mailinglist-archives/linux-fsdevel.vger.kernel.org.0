Return-Path: <linux-fsdevel+bounces-65416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E11C04D72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449963A484D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573872FA0E9;
	Fri, 24 Oct 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRyMpVYx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TVqRQPck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B32EDD7C;
	Fri, 24 Oct 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291849; cv=fail; b=T7hQj77BR/rIYFyzy33YusQYzlziNT2GXMc9Yd948mcoi4fc/eiaf3DKjL0xCYyamUUFAidc7wuE8tLAmp3HsTEzS8UufIIvTXkFt5vmWA4CcUN5HoQnYMFs9vSsgnU1xOTca9+rTa29/mLToyLp3QMUu5Y9Ge07XFoYNn6lY+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291849; c=relaxed/simple;
	bh=Q/DgZ2+L4UEo5ClGJ8n140rHxLSGvanSf+19YDUPU0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rMdkbnDw3mp04oj2z5n01/kuYkkRPBOPru/WmiISGALCLU8YdzdEKJCsYcGM1yMtmk7Efo38NR1ivKvyBoCBsNbuHXjNpQFB30jNsQ01DDZacG/y5qdHw5DJ14Fd7zQh6qvL4syromiUVrkOBtYUK6JUnpFwAHYpAIN5C3hhLGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRyMpVYx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TVqRQPck; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NKJ2005579;
	Fri, 24 Oct 2025 07:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Kp0za8MBif51tvVUiYj9LdmOxs5E/y4McTtZS/aabWI=; b=
	gRyMpVYxXo7JpU64uZpHf2wH56VqKkd/GZ88813AuVhhbnsI3RCXPFTGkkRBpMhw
	vnYJ1YUvKNO507UqbJ4wzRoXIKn8DuZk/c6oIYsy+TCOwBdcFFXplsMDoZASI3BS
	69OlB/sVj4+G8x8/za59KJNrnF2w+tUW9BT1UqycyPbR5B0fYeWbvofJqQt0il3V
	+8XbO8oC+bkung9e3NhfhZcO3gH0Ld/HVfT/zSPz/h5PuwaF1z4b+NGZ7S1yY3Fu
	KpOaomH61V+W+R1AyQAa3O4C+PwvQuKdP05Sic9VMmGrDYybAPUXqu/4nZZiS8mo
	usYT/H7501TNfTi+zjLDsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv5wm53b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6Fxt3000945;
	Fri, 24 Oct 2025 07:42:07 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfj8e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unEI/QN4Z0YZN/wyLcU0GY5zjYH0DYA+6ZwaIWht0GER5KcnA2dZGaVJ7oR/FGsrvvaM5HY6pzmvFi4wmkYnTY6rGdpFlfEVrif0WBsjXpST74nkEl4Kc7GS88zYJb8TjP4JLVftXb62r9Wc64YTTi/0blOa/dVmW74WlPzVhrgTljAEpSB9UtIHdIOsTp6CxRiN2MH6cHcDZl1yb0lxRgcO4qpUDAV+z754xTOwDkCkQ4kjuQoLQZmVUd+FO3tArBJS2RsCozZXWrWRXymH+Jy4xpp3aPKsUxmjbOHhaV2SpIOtettHAbXL2JIVz5mQGVSv3TyhOoP3P5wPq9WNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp0za8MBif51tvVUiYj9LdmOxs5E/y4McTtZS/aabWI=;
 b=YDVUGgvw5qvNLAIzErqKguOIROpq8GCdXYk1Cc2K72MK+p35p0zcRmiJ1y9USa9Bljeq49KV6WStRO96Rrz2MKO+toW57cR+jlmIsfsaNl3xGPUuDoskVOCHfO89Lj6FXfXZvuVTDgBUfwHm2kOkni0rNA5EYAkquYOCyveSJ94Q4qZfAlvuF8u622GbkekcIsEApkVdU62LWktlJ2+UosMfG2U1JetG61JkF/ZHPIBTaTM+dasWNAGxu+823WqrFJYU5jiLfpoTSKEoGeUjYIvfj3lt2OpKgDLUS3gMyGhgfxqJgYlJ3ipgM3ZSu1h//fK2I0uVRBGsi9BoSDm5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp0za8MBif51tvVUiYj9LdmOxs5E/y4McTtZS/aabWI=;
 b=TVqRQPckD8HPboSS/dqHUnOE0OOQ8n2vjKR9MQehbibeW9mPTtF0pvX0KWEmsoTJm+xqQV6HPuCb+VsJukfRpNYKT1d4qiVSi/gFNiU9Js7PbOx1VizUDYTALoa4gD1N2ozYZJ9xraz/pAnMvzyN8P/1sj/kcHc9VHFjdhVYdkk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:03 +0000
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
Subject: [RFC PATCH 07/12] mm: introduce is_huge_pmd() and use where appropriate
Date: Fri, 24 Oct 2025 08:41:23 +0100
Message-ID: <49cf11ce2b91bb4648fc41c78fc4babf73879ee4.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: f17b9d21-78a5-4af2-73d2-08de12d0d2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcTwOzwMTV/ufWiy5+m8rac2VdEEa/X8zuovBaraV6PQF77O9UYRZsLEntt7?=
 =?us-ascii?Q?xy+WWCBSdFC4x0JGCgHWHZPA62cmKrj7fDOaDBF3f6X2466gG51QGadqQ9GV?=
 =?us-ascii?Q?FVk0n/msWn3vgFJtw+9oD+3Y8crv9k30GKiJKCekGOjdGpGf5BmUrviDLArq?=
 =?us-ascii?Q?ta4wyY4fHG1TPzTEoS2YmVW/ZNTsIY5qjPYEZ3T/ihH/YClVbix0YN5uL5qe?=
 =?us-ascii?Q?S3E859dyYPiTy6jZQEU67xyz/SU+cM78qe/jj28M+GhBi43AUoU1qlSFeyvO?=
 =?us-ascii?Q?vybLWlnRB/rytsdWnGh2p/I+tyNnfXIn9ntEK0Tner36aAOwStDteWfXKqIf?=
 =?us-ascii?Q?lLebmqe2dcpKNyheDFrrh804vW5pAcmkxrIlm3v9+EZX9KkjJ8sMt11w5HPz?=
 =?us-ascii?Q?+pqe4YopWrtYTZ+FxoN4fS90PZfDSeZGOsXfFeny8crwvDHzbWHD5hdd1Zws?=
 =?us-ascii?Q?dr+SUZv1kVTZ8PNRx7NGymEaKGWjlpP+RXKkwBxedxFtOWSzwQmLBy+qrzIO?=
 =?us-ascii?Q?A1j2w+lvcODnz9CbR1GPf1fExOMPuN5+PW+Cp3Wsr5kj235eAgaXGGn8JT4D?=
 =?us-ascii?Q?VDZT1e+fxDunr0RFXPSTxiQLjtu5mXQ2ctXE0Bcqsa0aXxlxs+jLVhPHUNNA?=
 =?us-ascii?Q?Cmfr915HHHcQpgFiB/XBzsFsgbgCXC9XXfezZPpMxPxK9tpg1CnerBmavuT7?=
 =?us-ascii?Q?KhHRftaWUQ1DWbXqy8uBB21orgyKTQb7n06fS2kNCjiV7hMhMYoZlo341zvR?=
 =?us-ascii?Q?ox/RE0JpGsW2NLviltKE+nZNQKAV9HIm7AGPzxftR5n32chNwOhdTtWZjaeJ?=
 =?us-ascii?Q?6JXaIK0FW6dwIsf4wFfztTyKYooULzkaXfNeFojyipWt8v6LDVsvJ7e2Z35U?=
 =?us-ascii?Q?VFYEYDZTSneDIWxTpj6SYFCJeprv15HbT5ocX/hx0HCAm+Kimu/MW5X0exys?=
 =?us-ascii?Q?9KFI7iMyGtlrGciYB+bqs3GomvEMjrgXzimirMuRINhR8GDMB0K6o9P+tz3I?=
 =?us-ascii?Q?gq9dD60XlHyxwIi0Er1ogkts7PDjdA1vrKWLj2haGOQV3UERuG3Ay20uZGDL?=
 =?us-ascii?Q?uOZM6+hMW282VCjNLgjzqcRVWaXNbs0+AoNhrV1EdR/P6xs2lisEbx9eg412?=
 =?us-ascii?Q?221WCmWsT+TIgVf2tHXx31MYcS78V9BLv8vPPpV/qIQ/Ew8+vOgVAIb97hHv?=
 =?us-ascii?Q?Sfk1KZEcDBYDzeuAuP/QqbAKs8YcTlPp8MX28XWWLahrE4z3OTS47lLl39CZ?=
 =?us-ascii?Q?hK2jzzsgCrKuC7QfWF5LSUqaD2xONxSqq1iaZXW2VC5M3tYHLC/z8l1Zad7R?=
 =?us-ascii?Q?F48iewVGOIBSaqnF0ZMT9cBpvqkIwkMai7Zbozayjl2dQz0HKMdFyWZf9Tlb?=
 =?us-ascii?Q?ZrZbttsufm6sSSs+dmlET8e6lgZTbC+Sqx7Ai4DtnRltmKFSK1KrUOZb3ugN?=
 =?us-ascii?Q?lnex55X7564JtPF0sNziY4mHsHeV8//D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIDYfHFxFhIQvBl9y8rscfVYOPqSlnhsch/y33l90/52nD4uGPnmfvJsJQxx?=
 =?us-ascii?Q?zGpj7WS9VK5YMPQYN9/eLpfhVA2YPU04zkPmiUDwa1cfu/MCPwjXbcQyRI1A?=
 =?us-ascii?Q?bQqObL36k0HIQnBfHmLAC47W7/8oNqorWvVucCXXXe0ZHKFTUQ+E+dLMmue8?=
 =?us-ascii?Q?cF0YTDYmqTuLs5ofGlyd8gwH+3uIIP0qT3msYjUasIZu4wxV0BogcHS5boKF?=
 =?us-ascii?Q?Bu9ZGfRFVJE67IetD8kX2MWlpzhsXdaiGaPHK9tJD9WYAPIVW+4zcllcIoH+?=
 =?us-ascii?Q?E92W944+tOOM48IkZkslYLtAOdFcVPTt+Ndr7H/3+4Uh3Q9v0VBfiXxv5c6B?=
 =?us-ascii?Q?yMxwppwuxZJE6PrsfA7xjgR819M9wgVBiSp6vumjW76Wudctp5BDm70nPFzP?=
 =?us-ascii?Q?dvPIZsKdDO6UQF4OULin8BeniToJeLg9FNVCVSnOlHTzIGFDSnD1l26bAGfI?=
 =?us-ascii?Q?ArINQgezH63DDgCddX2YWBBqa9dJXAYcwXe9I9Uo3fMuyBdYn1kBH0Jp0B05?=
 =?us-ascii?Q?gSxX8TnvW5KaUEeO35aDDBflCTl5Y4RxljSCsPWxvh+D0X+K9RCeveSSkzuc?=
 =?us-ascii?Q?ftlm4c7K9XXto1XaLJL96qcmd47vChuBZJcPht4Gl9b+j8s0eGLyHdUBvHzL?=
 =?us-ascii?Q?nfEZx+d6601cKPWurhtuAmL8U/HScEvQDUXQK4/m1tyOPZ9PwTrMlGKY0lqR?=
 =?us-ascii?Q?OpyvVEwAju84+4iBOwz5Dl5urmLm8hasnbvSuwXIvs1+mZ8ewsNQWRBt1Rc+?=
 =?us-ascii?Q?KWcaTnstwL9+oZZ4rKiE8OKJISOo9MLzXU3o4LoyVDh1VK+1FtNShCvNr5PN?=
 =?us-ascii?Q?R67N4SaLtwebbK+4y4lWXYPUMm9ikrjtztf96bbwNoWOyf7TYWO9uAqUfpCH?=
 =?us-ascii?Q?Fw8jZoZAeSr5h0t3kvXkh1NCYAllNYos7iRukzttFA68Z3DMjboyk2SCUPuZ?=
 =?us-ascii?Q?MsmqFE79Uoq3V9kgCcenttnxuxf9bnzbea/FOVCG/BJjCqoINOh9EDvqjQNG?=
 =?us-ascii?Q?Rh+w6icdDLpYBqKI0Gzau5OVG2uLAG6a1/OtQ2rgpYhOct1UnKUrdQ0BzjQj?=
 =?us-ascii?Q?9pWdJFRDYsf3BVz0+h/ytQoP5AW/br30fMwdkqsX1efZeuuD1VaSaHFzDZWR?=
 =?us-ascii?Q?azHzFglYDQdPUDm+eatt88Gb4X3cd5tvqhy20UksZt+0nBM4ndLMTlkFQI83?=
 =?us-ascii?Q?TrA00cDkSD1fVB74KXNPgvLVe3qDAxkqwH5EyceDMw2p0Sw8Q1pNMGMC94fm?=
 =?us-ascii?Q?TkmnBO/hD8sZyGoHvHC8wM2rs1N2/GjIcR5Sxn9K0iewvvpMIOjYJtS+ouLU?=
 =?us-ascii?Q?C0dsD3cnFRSC/M4JUEkntdGLdWQM1GQSRLKY9bApxbKm7OyTIhZ6yMFX17fa?=
 =?us-ascii?Q?QjogFxdADsL09n01SAo/kBEm7b+DeMgkm87jx5na3CIDPNW0/B0MJHUPCxg4?=
 =?us-ascii?Q?hu9TiTTujAbz3VJDFWKDav9qAyOr3gIaS91P0CNKCkgaSsXyWlDqJpIqu8Ei?=
 =?us-ascii?Q?itRKHDPQhb0YH6NRis86+CPchFzs8f04wjpLwNk1v+IzXRgWAX5gVlmP9pGJ?=
 =?us-ascii?Q?bgQ6Ev6xCsfEK+hczyKSJkKVOG4sigxYr8wZgefLKUkGtYbQqhrfSakG3/jr?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DlnDCd6MaPScYKHoYSZJ6G2rUTOs+o/573YJmPSCsMkzsXqlcd2mUCqmc000MtPpsdASUvpzeu2TzjWfdNvdQgolc1wb/8OIe5McEcsa8PbvC5YYMhTeNRmswzklPy/e+g4x2H/COwUi3pNYw9doLfcvpespji392ENP4TDsknlPSj31nqvLKnwV18h0rfhjMCazFPM0Bqogk50KhSeHP6gT9gHfwm+Ksy/IvlLcvxQ7KScs83CeEQ+S61m00fUz4V0C3Ls+tBXg3kbWnW3EcjQj2YrFcDUZiQXPuLmH0SJyZ5euybqJj6WXhlNhvR3DEcRXVTd470PBb5BcNa+pagvn7YP/D0jTMlGkG+mMwZEH6RxJFEEE9/5nLBylIiL6oXFqG4ZZ9OuSgL7Q9yh6JTGhMB9MsCK1Dxw81/98cyJJxY4ZwG25m1KSsBxNdg4ztDk5VVYd+Pg6j+7exxUK3c7Bdg6iKHtFYWpTgIFqecfsHE0+TwDtRvy/DOPXRXZ+UxbqUvF+hGJg2jaXXFxDvq0ai88IZVwCQZvfDZu2krqskWt96JeShzY6MyxYk0ItgRCAl1UcsYisoyyPF7QMl5KKRufj2sN3Fe4+RzA6G50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17b9d21-78a5-4af2-73d2-08de12d0d2d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:03.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB+Ci/wTKW8WCLwsJo93uQ/Ud0NwDPSxymsuoUaVYpfNTQvLsXm/ua1sHzpJi9kp8SUHPyrb6rJhk3ctlPu2vRW0Zpu4ZN7sC9D09eWlZ1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX7UdtA4J+4Jwb
 rRLrfktVJjC9ANZ7ZxzeJHKcYriFPTDgFpEOL40M5by+kpp6/KMYHwN5CQfM9FRPkMGnoSqRxwa
 /2EOt+jVH0GIGUOBkAKmKoi6+FVCuwIdNa7bn9yuvYujXq1tydT/W/c6F1iAtRmMpeeBALPyTV/
 jxTHyphBgAgGICNQo+0mpUi9x1tsr5lxuYqhD7KttKVxpLzYJwEz67Ub12HkfWMgzSGSSMGzexo
 LkIjGn1ofOFpPPJr+kBREjSceoFPW9N5DfkGe3tfG9ji03aBEFoR5NnwxEZ8z8g3I1ZcbPkYK8u
 pIVSYuc0Ch+40umfub1x1s1+huCTW/dUpiBSBnwXZ4W2yFoRTqTUr31Mb/5wCDAu6LRu18iSkxY
 /HcFxU8a0gO3DkctMGXnyy66a38kXQ==
X-Proofpoint-GUID: H6xcx6Ni_T32BexC7wK8w1p517XueDaQ
X-Proofpoint-ORIG-GUID: H6xcx6Ni_T32BexC7wK8w1p517XueDaQ
X-Authority-Analysis: v=2.4 cv=RfOdyltv c=1 sm=1 tr=0 ts=68fb2dd0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=SYrxmX9aDNqaPzm3yRoA:9

The 'swap' PMD case is confusing as only non-present entries (i.e. non-swap
'swap' entries) are valid at PMD level- currently migration entries and
device private entries.

We repeatedly perform checks of the form is_swap_pmd() || pmd_trans_huge()
which is itself confusing - it implies that swap entries at PMD level exist
and are different from huge entries.

Address this confusion by introduced is_huge_pmd() which checks for either
case. Sadly due to header dependency issues (huge_mm.h is included very
early on in headers and cannot really rely on much else) we cannot assert
here that is_pmd_non_present_folio_entry() is true for the input PMD if
non-present.

However since these are the only valid, handled cases the function is still
achieving what it intends to do.

We then replace all instances of is_swap_pmd() || pmd_trans_huge() with
is_huge_pmd() invocations and adjust logic accordingly to accommodate
this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h | 40 ++++++++++++++++++++++++++++++++++++----
 mm/huge_memory.c        |  3 ++-
 mm/memory.c             |  4 ++--
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7698b3542c4f..892cb825dfc7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -416,10 +416,37 @@ void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
 
+/**
+ * is_huge_pmd() - Is this PMD either a huge PMD entry or a huge non-present
+ * entry?
+ * @pmd: The PMD to check.
+ *
+ * A huge PMD entry is a non-empty entry which is present and marked huge or a
+ * huge non-present entry. This check be performed without the appropriate locks
+ * held, in which case the condition should be rechecked after they are
+ * acquired.
+ *
+ * Returns: true if this PMD is huge, false otherwise.
+ */
+static inline bool is_huge_pmd(pmd_t pmd)
+{
+	if (pmd_present(pmd)) {
+		return pmd_trans_huge(pmd);
+	} else if (!pmd_none(pmd)) {
+		/*
+		 * Non-present PMDs must be valid huge non-present entries. We
+		 * cannot assert that here due to header dependency issues.
+		 */
+		return true;
+	}
+
+	return false;
+}
+
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
+		if (is_huge_pmd(*____pmd))				\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 					 false);			\
 	}  while (0)
@@ -466,10 +493,10 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
+	if (is_huge_pmd(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
-	else
-		return NULL;
+
+	return NULL;
 }
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
@@ -734,6 +761,11 @@ static inline struct folio *get_persistent_huge_zero_folio(void)
 {
 	return NULL;
 }
+
+static inline bool is_huge_pmd(pmd_t pmd)
+{
+	return false;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a59718f85ec3..e0fe1c3e01c9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2799,8 +2799,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
+
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
+	if (likely(is_huge_pmd(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
diff --git a/mm/memory.c b/mm/memory.c
index 83828548ef5f..cc163060933f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1373,7 +1373,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
+		if (is_huge_pmd(*src_pmd)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
@@ -1921,7 +1921,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
+		if (is_huge_pmd(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e25ac9835cc2..c1d640758b60 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -522,7 +522,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
+		if (is_huge_pmd(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false);
diff --git a/mm/mremap.c b/mm/mremap.c
index f01c74add990..070ba5a85824 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -850,7 +850,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
+		if (is_huge_pmd(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-- 
2.51.0


