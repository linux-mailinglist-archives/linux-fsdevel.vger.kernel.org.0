Return-Path: <linux-fsdevel+bounces-11790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA27857291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61ABE1F22EA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87FC4C96;
	Fri, 16 Feb 2024 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OLVsuhF1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pmg85TU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC9800;
	Fri, 16 Feb 2024 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043558; cv=fail; b=DvjNnw4c0Qb1jIl3qJgRGeN26Ut8b6EU40/Mg4+8zr7jL0greFP110DS580BX0WIiI6ZXlXIn06wKb4EEKXBbShs0WTJ0762AOhJmO1oLDjiMlZn7t1TSzStg5pw5MBCeiHacTJLtclegUtttp4qEtq2QGVuo3yunMAo+zeMVd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043558; c=relaxed/simple;
	bh=QE9+XCd1AjOQKTybmxbIh7P5xFMSClHaE1SYPXHtcw4=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=f3vLfvBhcyVoi3aIY0tlM8AggmFAKaBpWsbStRAn7TuCRBAV4e5kiL9QrWmYUzQR01AuNrnVyTb7uLjreHTgk1DrX4SOz9aVHZW4mnHomE7x8CUWTnIFkrpbf/62I5Xm7pWRWxTUZgeVURetRnXbK0RBCKPu5jvyG39uGbE4WbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OLVsuhF1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pmg85TU/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSIAA032679;
	Fri, 16 Feb 2024 00:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=hmSh4wc4kAn4QgIfoTuIMee61d5fGaldQYe4/6t2XiI=;
 b=OLVsuhF1Gd5vkaC5E0XaDaOe6J6SOu8F/J53PsoY1eSn2VNOUOYyOvuGzpBWhUo3Ff+/
 g7pQD1H7/gdaS7J5lG78QPl3HpYaDaiiM2RacDpVsN2kwNapbr6OJpQQQUP9nfdtvM1W
 Gw0bsrwUU4chSTwodJApmMGfq0ULKrLw8IA2+hKD0rh5T3di7FB+kmh5SGKelofQSOYs
 sxlVrbn9Hhw9co2Tsd2+l6fzT1WVyity12r7+ncM4jB1r9dRbdPgd2HTtksLXOl7LgQF
 zRiccvWxbshvdvFqsE88D/bpcGU3knYvRvK6rb3vVtEtHgniEzVeLSr/+6cqcQwcj9VY tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0kqhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:32:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FNDcN4015015;
	Fri, 16 Feb 2024 00:32:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykbc6tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npvMZvKm6wLs0YYI7UkVXAGCZmWoUOXPbYpbe0vpxLqG2Mk1NnjNodSaB0OHqKZ2Za2J5squS58iQeOLRhe3RKyIthIwoLd4/9QVi082G52rtiuoy+rTiSfvwx/uiVy1x+UTxWTc/cy3jMqRAFlpH4uJ+7nnd/sik9XF0ly+xrDVWSPShi0Gn9pBgmrw4kLUs7xGSv/7/YVdzrKeg1gRrX9i6macDgT9gMZC6gYNj//nFqNUoTPh6tKOS7hKPd0tHvBM0XWH2PlIc2RFaUN7b/wFaJcpQHH5F8JArLdSV/e+yhBJFVAbfOhBQnJJHP9i7BmqqeYuR7Mi5bMo3+rSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmSh4wc4kAn4QgIfoTuIMee61d5fGaldQYe4/6t2XiI=;
 b=K/XZEJV5e9Uv2jgiMqoYDV6BahZCMlzhfeeR2xA3pr5JRcDnQ4uS1zL4Q/ut2lOSFQG1QcoGV9VkPUyGMSHXQq1OWjQISwoRpgG7co6R9eVQ21gYG6UOzMg1XTRZBTTwEzzxXYwMKxlhXKlA5AMMPv7w/p6E+dldvNamtk8ckQ7bC4q2uzbU4Bybwh9ygGgWh/tciPgM5YFVaO1AV/o6UCwHby8H8HSQ0wp2ToFSq7NNOzW199B+Zr/U9vD8KoVRKmm11pUHVIQqPlzSBPxa9gElycucqbu7l19+14TGDqk1guj3SSQFzmVplYBy+bFUSOIcAGvjHcrby811D9+phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmSh4wc4kAn4QgIfoTuIMee61d5fGaldQYe4/6t2XiI=;
 b=pmg85TU/ZQA+poIqhtFZWs3vLnSENIdjRj5uHoTORNdlC64BFJSAVnEh9tQ40TESndJ/AY0KyhBjznp0I2GzRN+Njt2EE3vBr3islHAC1V8nIgbs1gKDyQypqJ6pcSHiFXL6OLbuMCWf0kos6UwJHeIfqPNNRGBhPzDqjY3HxKQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 00:32:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 00:32:17 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph
 Hellwig <hch@lst.de>,
        Daejun Park <daejun7.park@samsung.com>,
        Kanchan
 Joshi <joshi.k@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1plwxckrn.fsf@ca-mkp.ca.oracle.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<20240130214911.1863909-12-bvanassche@acm.org>
	<yq1h6i9e7v7.fsf@ca-mkp.ca.oracle.com>
	<7e3662b4-30c0-496b-be19-378c5fab5f33@acm.org>
	<yq15xype6k9.fsf@ca-mkp.ca.oracle.com>
	<424cd3a3-dc20-420c-a478-958f1aa2f1e6@acm.org>
Date: Thu, 15 Feb 2024 19:32:14 -0500
In-Reply-To: <424cd3a3-dc20-420c-a478-958f1aa2f1e6@acm.org> (Bart Van Assche's
	message of "Thu, 15 Feb 2024 16:22:04 -0800")
Content-Type: text/plain
X-ClientProxiedBy: CYZPR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:930:a2::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ee0778-e0b6-4beb-75b2-08dc2e86ba80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mjJ+/OCl7dwsdLPrLuGNki0068/AGW53sQraO/WU5FHUC92qKdQGu+BTINFFNsV4SvUtj4sOaAmTERmWMSRB70cvzZPL4K4/mV1gaijHVPfUdoxCae+sLu+l5F2Ql0pjMAgVfzgQX6VMA4pR8weYIneKUjntcwAhIQWqGt77nQt5v2QZxY2mkZqHmLKEEg3rZ1DfIon7UZ74SfX3YkcK+RvKCzGTI7CrG+EPCCYiGiQP9QkugZdtPOBEVU8Ya62yD3BgbgFcPv1BIELoXZHhR2Y1Z/tpVOpb8QsaiJ947s5jbKmOX2IVCnwzghG+69ZFUQcsIKEq1rrY2KbSaBij5Mx4gOsFfOpO3eU2rRWyJsh9U8FsbHQOLySOOjXkoIUlWFeuq2dkaHRxwTpb+wXGSQ9/zW88zxDQxQhsRJbifR9dVwxNqsFSahYkSi+OZvUxE0noXJs/0HHqlMri0yhfUb9QdPyTyTaKenZHQ8IGzggUW3aUU71CU33zVc9tXdHRnTxZapX2p1YWBZoXYBxcpOmcvCgiIxhAtiiFtj+ca73Jx1Ky29MjxNoo7vCmiM6y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(66556008)(66476007)(66946007)(8936002)(8676002)(6916009)(4326008)(7416002)(2906002)(5660300002)(4744005)(26005)(54906003)(316002)(41300700001)(53546011)(36916002)(6486002)(6512007)(6506007)(478600001)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H6AwN+8ylJgfsVgMfZTSMD4HQwYfpRU/dSsr1khLH7uNU3SR13acPtpQLew+?=
 =?us-ascii?Q?LFm84G3EBD05wf2WHIIvnvMNG3FJTrprMl0AD/Q5USR+C2CrbSXBK/Se+gIL?=
 =?us-ascii?Q?yAVZjPsZrcZIdrSSpxmT7xS8NlcJJ+2F7/ZIQUp/1CmP5SmsEEzWcspQ7ue7?=
 =?us-ascii?Q?cqz9w/dUL/psZZNgjBbCmB9/igYjcQvXGaeepoP715zKbTtjE1+vDzIwqSQU?=
 =?us-ascii?Q?hcV0IvKH7JR8I6O603Rs4Aj/1WYrNmspJBM9et/7swxwC8izkxPDB3SX2saq?=
 =?us-ascii?Q?YHHQcOfH8Q+Wl6AflKCrSGrnj4OnYsABw6b/3yWDumKyCWPqn0GvbKQ0KGmS?=
 =?us-ascii?Q?p882nqwucc9NwDbNI5ICh5z2I2+8Yica65cwKhWQPIYidiHyoqL4Q45BOYSg?=
 =?us-ascii?Q?GEXX9utttyMLXtvsr0fzviGMYxK9g9ooA3y+JaCS0rbEdWYMrfv/R/6s/B5s?=
 =?us-ascii?Q?wagexTfai5EKsoCmj15tio5VPHNvja3KKZAJMzGVJENcCpkjbyu55vqduom9?=
 =?us-ascii?Q?hheeVwnfWvxKbYs90IJUXwVWn4dHkWHy2i9HxyeMCCil3xvBcz8/xfWIeKUd?=
 =?us-ascii?Q?gFcVsq64OR8I2aKuFHzCF7fJSIonrHo4V26W3Ta8ZBFkKv5ALikyD/ivTul7?=
 =?us-ascii?Q?ikU2/FwF+WCFQYB8zcFzPn3hdPVKRKYMEAr92wWq+JsClQ3EhujRjOofw4Tk?=
 =?us-ascii?Q?uSCfhHXpoYFPxAEjDu2aJ+pw63kZeIgGQoHV6kHhbMb/1YxZEeqggrIfiVTe?=
 =?us-ascii?Q?yXRyy0cOkfkx8L+BQ9rAdBsbwFr15jw0qeWHMcxOmaAV1XMt/fB3W8hsHrpZ?=
 =?us-ascii?Q?Zjxpjrzjsy0ObV9pbbJbhE78I5m77J6frFNgmia1cXgKpai0dUqJRhS5wUGw?=
 =?us-ascii?Q?PQrx2axbwTUWDmajWNhKhkbOOY5Yuoy+ftf0Ad5MtjR3KocG/pnwUJ4Ek36J?=
 =?us-ascii?Q?lvUI2ijC/0NbcuanPlYCnLp3nvd8431pJohKcXOMQKCuGENCJ2AufpJaSADI?=
 =?us-ascii?Q?W1qTOkiAbDbrzmIpq6UsDOIYvOXuOZWDHPd7pVozKnKEyJeVOPFQPWt07rpa?=
 =?us-ascii?Q?clVP5j3jRukHe/Nniy15/jUHjvAwUjComV6ecV+uxvgEjy69ivpxstPuuAK5?=
 =?us-ascii?Q?eLgE1opX0ukd6Oh4QkXwR0spmzrpHSCQ0pbO+yRp+yBlPXeJj/YcTz5Zr6V8?=
 =?us-ascii?Q?ryaPSWVejdnP2fuydS/RRGbbpdGGALaIGH6t589WkSqupvN+EAvanPUM+JwY?=
 =?us-ascii?Q?pg2+5rMxMJ3iL9/FTGUNmpg73dnSparB19hAel0mpBEgUw/+cHT/ivc3Kg1V?=
 =?us-ascii?Q?nUWWZQdS9qbMLOERBgy8vQbPytpdD2M2SQnMNiY3G4Zx6hwHLgjpCxNLbrCS?=
 =?us-ascii?Q?TeC+00Zd2+wy4Jn8h6yNiBz0gIqZfEvxW350H3Xo12ValP2BgTIqirqyoz3s?=
 =?us-ascii?Q?eEKgDLO56szaq1gegZc4sXtPp69F/rGyiIIPQaMule9nL8nM1DRs58OkXa7k?=
 =?us-ascii?Q?/25nFQ08Uza8NF39if7gSl5nDRv0EQYu+iroRSRzSo3WiLB9syPhWFB+WG2z?=
 =?us-ascii?Q?uVZbUOruyASdPtqzijLBDMHqK0bkO7eDUw0Y01p04q41IwaHRYI2IVf0UWMP?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IpskhIE4NfAb/5Uu2FMue3W5vTN0+57fNSwuQy93V4sJVjcuw/YgJMTvb4Wd/srqWXzyB3WQLKAiuB280gF26s28WQg8PCXlH4ggPPmJprun75bxc8A6jd0IBxH6iKfHEtS0RiH4jBNbzakC4jy+sJz3uRV93K/GinU3yZ4tQof8b2GDXcRbIVZfVgTLX7LIwveqHTqTE3QMBjNJi2kn4qoAtWK8Ci0zp8q7ZC1K9kp11GO7NlSXyEC3q3tVGe0tPV3Nt3msHaN4DJeaJBa3nuAaeAu82katWTe6tDQjpzqeYCuCCHpLDIiFiCzFo5mnlQTtkGnhMh7F2EkYNcankz1ISHfiG/1UwavNq5CXUew+JV6UxSV/RI0ljkY6EABr1w9no7iJnvqGVBYlJ+HVOdUiti4mLWh6Icfm+0oLZiV6nRWIGB3FoyBOpfPlb9itg63zwUhSCWbTI0bnOctMx9Q5BRtqkY4V7N+fgSs9XIUbVqmdUwsz1DclDQJQPfx0e4AeCGejQU64/ck8jFKmehHVv/kK5T2vgP7YDNDX+lDVy/iHFQZyvCAF3Q0ZDP7bNlZe1+CrgaZLBqWLbg5ElZWY4wL5kB+owyZRYdaNjEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ee0778-e0b6-4beb-75b2-08dc2e86ba80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:32:17.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzsuDnvbo/gfzDUSxUxi84568GwRUCfS4/xDnM6E/8bDxHSpr3kG2VxijZv410TESwbzvCwW5R2ECrJdCoz/ofrWCOowOM8791RQAo3esRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_23,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=972 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160002
X-Proofpoint-GUID: dLIt7VLA4RpKULJwRQd9dYYCBZxYwV5-
X-Proofpoint-ORIG-GUID: dLIt7VLA4RpKULJwRQd9dYYCBZxYwV5-


Bart,

> On 2/15/24 14:00, Martin K. Petersen wrote:
>> Another option would be to simply set use_16_for_rw when streams are
>> supported like Damien does for ZBC.
>
> Setting use_10_for_rw may work better since devices that support data
> lifetime information will support WRITE(10) while it is not guaranteed
> that these devices support WRITE(16). As an example, WRITE(10) support
> is required by the UFS standard while WRITE(16) support is optional.

Sure, that's fine.

-- 
Martin K. Petersen	Oracle Linux Engineering

