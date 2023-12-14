Return-Path: <linux-fsdevel+bounces-6035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA128126A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 05:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D5B21147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 04:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759CF6117;
	Thu, 14 Dec 2023 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fCHuL0Sx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="blEfoLwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8B985;
	Wed, 13 Dec 2023 20:38:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0TuAq030299;
	Thu, 14 Dec 2023 04:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=EpNCctt2Y/JE0HgXEiFqq2OBU+CMRul3MLOrYoLTOkc=;
 b=fCHuL0SxzmHI/7WBTZgLg1bC8w26/bmB3IWJDNiOB8gE2Z68qu9rnEFmYdrv42D43AkK
 nMHrt7mld31JEU35b6vtR7cr7+DLXk9Gn2+hVSaI2L2I/P9aca9GDJG7T1ut4Tcky0vr
 d0db1VmQOd3L9KU1+pxiY3ywzb49xD3EkTkZ42c4nimCizm1P6ZDnVpgFnCNVqDaNOuI
 K4DbXHSSoYDGGz2qq74eVXbhNlwQcJf5cFQIEXwDiGBi1t8cIWvgQgxFF3cUotFyOqgX
 Uy5/pU6owqPC2z63dUx2FQUBNXGl1x+LKHAqkkHlwnwrcxxip6S9EhxW9Bi0wej7xmJK 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu9uag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:38:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3eARO008295;
	Thu, 14 Dec 2023 04:38:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9f09j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZQqyYZf2G5YvEhKH1B+xJtYlkA2lw6eF1GBp9bzyx4Yu68l1WwQ40VExM7gxOzC56kYHTzg3B+yDLIA0eX7Qqueb5DwQTA2nFReuiI1g8o0u++fodVPnYn73zCGYlskR4w32w7DtvycY5x/1jEt0WQvpmw15vQdOdFn9LhRriO1BRQXzqDEKFta6K03NA7IIa9ThXvR8uzUWXvYVueh/UKgqDriWkLZmXb83vQlgTquFmRp5Y5pjc/nME691KEPuVq0sEmtHWmFnD4LD8gBRG2oPNSohHEKqwF2UTt+vB6je7PNibImQK8GE81bEgplqAdBZFKQWrMA2FKm7jEjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpNCctt2Y/JE0HgXEiFqq2OBU+CMRul3MLOrYoLTOkc=;
 b=DFAM9eET+YW3E+19pTyEQlVAT3AwaMwRRf9T5gmSHIv3T3TOdmZfqP1fVrOC0Yl53SQXb8LSYwjnPHxQhubt/vcoWWCxXP/JQSbzjfB6zIdFR5YLPAChIkW61qJ4Er3FycGYi/rgFRbuPi3P7l6gkN2H6vNgs5E6kEZzuAZRS8at8uHjBVvvw6DInUiTSOZjxerZ+KQJ6nG7cH9PKaHYEwl03bu3VikDo+eefei9SraQdnLdNA9KtVMIzvbKikH9Rd63IwJENvmws8jb5EKXdSIfq0aVH4IycbOXiwqu++n4YCjHyIMScn5OLtfcp7Lgl8hDbvCyElscE6/bKHX3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpNCctt2Y/JE0HgXEiFqq2OBU+CMRul3MLOrYoLTOkc=;
 b=blEfoLwpt8K5Re3ZVF204DiNsqbQyBLhMRgvteD4JRdvx8xtw9fBqgdPAWmZt0b3LyPfOz0IpTuKT2mJxlS92y03B5+BAjo/We4hFE3HkaJE6ashR05n7Brj4pkNwnkpfkoOG59zvVCFClQGu670Rbu2foUUKV4M0NjpmyUlr+8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB7825.namprd10.prod.outlook.com (2603:10b6:a03:56e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 04:38:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 04:38:12 +0000
To: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, jaswin@linux.ibm.com, bvanassche@acm.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cyv9flkw.fsf@ca-mkp.ca.oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
	<20231212110844.19698-2-john.g.garry@oracle.com>
	<ZXkIEnQld577uHqu@fedora>
	<36ee54b4-b8d5-4b3c-81a0-cc824b6ef68e@oracle.com>
	<ZXmjdnIqGHILTfQN@fedora>
Date: Wed, 13 Dec 2023 23:38:10 -0500
In-Reply-To: <ZXmjdnIqGHILTfQN@fedora> (Ming Lei's message of "Wed, 13 Dec
	2023 20:28:38 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: ece7cc0b-e4f1-4588-41de-08dbfc5e7b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eUDoVCNKybvNjBy+R1zu/CNiL59SQ7n/QxQ8dFhsp6HowrTR12FRBfStml2XrawaOd6M3DcYx+cLqWUdsuS7N0p6bZPYfHjfYSQ9zu3EOygMEF+XVOx0BGwXVZpp9CjjgF58x87csSjzILnfnQ0cee/TWCxzawDH+t3st5bAYppGDVtIM7UOL5Qw+aVUcC9fJs7Ap7LPZ8zFMSY1FT7ioJeu9NDLck5nM9BvD5KqnRdsNdKIAiwoQFhBa1sL666QX+xrT0bbqvlGEiw1bCCiNWV8EF7ssj9mnAqu5UiQuujMSDCl+r0E77wpU0SBJ+qVD8/e9pGFFliadZIa5Tp9hkKvJwjaTVXBv9EfwDTUxqPcPaboGuWT9+7mO+sd4p9IGd+gzaZwDU8/e3TA41uaXXucRIlglqXXdhxW0fofEo5buv07jA12uAM/kgizTAhV3iksoJJICoTRLLH3MrkViE347tPXaDhCD/Pg2lyMtsGpV8IEYtYJLN77YEmXs+NmyYcORYum5Chs6yijXUabszuYAsDNXTL4WWDFWIfwRp8ePW03YlRKCQxLDcAUtD+s
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(36916002)(107886003)(6506007)(6512007)(83380400001)(4326008)(5660300002)(7416002)(8936002)(8676002)(41300700001)(2906002)(4744005)(6486002)(478600001)(316002)(6916009)(66556008)(66946007)(66476007)(54906003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qg8/1ugh5OF27BHO/PFQrfzxjP9qyuOqtc6ljupJxv8BAE7qtRSHyw6usqVt?=
 =?us-ascii?Q?DsXo0WNN1gksLM+3yNjHT2pkF6HlGXJ1ZBmmwfLAZkhCxKJIEw2xu5t0+K27?=
 =?us-ascii?Q?DijRKtXpLeSYzz060rU0cS25OzJX0lXbk3e3QaMlTa6/gbuwBm1BxU7Huhbj?=
 =?us-ascii?Q?yylWHRe8oI+NFHZrUfWAgg4iHtE5D9KyX0MtK/7jCB/QuWLnXHwzOTByfa/N?=
 =?us-ascii?Q?izsDAdxHxBzcZNiEpQZZ8eAVg5qZ5jlyO2hDesrZ2OmIxw48ZjhoXk7glXAp?=
 =?us-ascii?Q?Dt9YxdMjCZxWJEvBnMct7WszMW9gcpuel70tMvEzTjkJ8sRMpm7lFM+jNCwX?=
 =?us-ascii?Q?8JE/xt8XoWyw2WByyHRd/KgwVBlUsktn+w2MUGa1zA2ovc4NCKA771vhWSAz?=
 =?us-ascii?Q?PX1WLxXKQtAw5Cn1jfEiJKPz0v+TACgwMPSe1F8L4oHPLClVUJ6oDeXaNbq9?=
 =?us-ascii?Q?7eEwtwdC3Q4o/kjqOgOsujlHTiB19FKxFa/gifafZI4rx4zBXL9F8tYSFSCm?=
 =?us-ascii?Q?SEykwrGrh5oUkkBL2ze2oblpB0OhYg8nyJfGZRbvCCwKxIIYCBUQy/XVj6pH?=
 =?us-ascii?Q?bupIZDEJlSw7PJQWHsmnjMGqx1BmUUO8bfVL30MKRiqU0fhgJVOITDumgus1?=
 =?us-ascii?Q?a4VPJOTjH0ZFe1/VUeNom4U7hYMeIzhWf7lG9/RaWEZ3dRQhQSSkBLOHihyf?=
 =?us-ascii?Q?zQbDHP05JeQyYzq82Rd4Q5fR3+SxBq2m/XyOpJN8sVLYC4tGIoMgUXWgPZ+P?=
 =?us-ascii?Q?rDCIJLRouRGqSVmh693gl38RSAQQ7qJjLWTv3alH8/hfyuPW2MPukxgw5ZX7?=
 =?us-ascii?Q?6Sm46D8m0K8241G8FNsQQovG2pq5HPOSD3RnGEnTIkdDvuU0xiZiDArHhhaF?=
 =?us-ascii?Q?0fUhWLhDphKXscNVDYI7O/58+1WtL9xeJPM79GqaVmdoGUiAKNfI/pDYq7wM?=
 =?us-ascii?Q?rB8XzAmHIkoA4g/yvWsU6D/rAIhuGuOyvBlNfVwbs9zqbRkvXDfLADk0nuR9?=
 =?us-ascii?Q?+jHX/13JA8KOX0u6w141QG+7hUzNtRGGlXDrDGRME1NfWhAuf6dioo4KJE6s?=
 =?us-ascii?Q?QAjIAS9fA4TBjh+Y+i0mVHgRPnGjqrGgxkY6jDZbe5EvUrCgPFipv3PF3f4C?=
 =?us-ascii?Q?7JloCOYhQI+7A4gd4GhQmF0+rgO4bwRcpkjxvxHBqgrLuINuCwH41pb4+udI?=
 =?us-ascii?Q?cTHOCYck3sQy5BGM5JYGYK2Wkx0QxZgMOPCZy+0Mbu1fwyzjHVzRF1MRXMkI?=
 =?us-ascii?Q?3KbKPtlOfGUAbrq2E6WLW/tzxiqiY9U+S5BhrjDNSRnx4CPLuB/u6Ywtr5Wd?=
 =?us-ascii?Q?TsnFn+c/XF14EalSqXuLw+5Xa/2IdAp6hUzyMmDcD+XO1rWeY2MMYxkE0jgH?=
 =?us-ascii?Q?Lnj2lYnuJ3MkBQS6LJsF1HOD7u4TDKLZ/gMDVGwo47hiyV6B+j909F27x6T+?=
 =?us-ascii?Q?k9quiwCell4VrCguMYrs6wDvIek6CYJkvYwYxl9W0Wedki6Y5hl/EeVu3rQ1?=
 =?us-ascii?Q?QcTuQ1wA/psINIxoz9pyGOJRhwt6hDsYQ431kF8Lux6nfaj8ivZLq8WKVWUC?=
 =?us-ascii?Q?HhPlkrlTvo7mTznPn35UrOJ9rFGK5un3j5j5pLuGRjnKDX5jwM627HFqhJGd?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lipk0/T9X3XWklxFk7rgsUSPc96aB5QXRdVHoms8KcoqCZxEhjfvlwrJmvEhFFWfVeyKHJGTgOb0Rcj3u98uuA7gDx5F9R3y8F3Lm75nXsVeR37vnZkrPNNlxe6WUvNBrwMCi9vCfgnjMSyoDjfxjtR+YNTSkTYEgw7l7gjN8P+Akj87gCKB3em6WsicNGT+0MpVsYRDvKJXfPlGF6cbULjI43yedVgaqx+nMS/BryN37rS5rrmfW7r0XjkuoKI/ety3KzMa2+ZAbFkVzY732Od5eQo160QqrggwvCCUXWAl6EPVN0vVoSERfzKa9HRiVTFMTtmhPCCwf6GKQyZy7Nfm3rouejxHAXZQydeDaXzguLRsDsNJGpw7sTSUkdnuoSmEHBtPccuQW04VwnD5RvnNUN1ukaKgIY5BuitTn9t9pK5nlnAMdIBnzr6UyjNO7r7mhEtvmLUJ/0MXi7+P4uKJi5B9GBGofwZo5c6XpwQE0Jl7ZaO+/USM/PeGs62FkILW5ROEman/EMk0ddNSLs4KYwbprH7VhEyDe9f4/JiICkguv8CwtgPPhlley4P1QtgncqpUyzriSSwqcai1Nvvsp98MRga4S0LZ4Ja1ZoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece7cc0b-e4f1-4588-41de-08dbfc5e7b04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 04:38:12.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fN1F5JhlgDeppon5ZDfIlyWhr3Skwl44hpUzuMNM6YZX+PQOUk6uJD+TZhm1XxTj6pDBVddpSCl6MANoYmVvhG/VHwYwMguEe6IjzVCQB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=990 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140024
X-Proofpoint-GUID: dFdtRkgW3V_OGuf3Aj-w_NCAmqzp7Ccv
X-Proofpoint-ORIG-GUID: dFdtRkgW3V_OGuf3Aj-w_NCAmqzp7Ccv


Ming,

> Relying on driver to provide sound value is absolutely bad design from
> API viewpoint.

All the other queue_limits are validated by the LLDs. It's challenging
to lift that validation to the block layer since the values reported are
heavily protocol-dependent and thus information is lost if we do it
somewhere else.

-- 
Martin K. Petersen	Oracle Linux Engineering

