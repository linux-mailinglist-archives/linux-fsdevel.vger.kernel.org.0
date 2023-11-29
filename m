Return-Path: <linux-fsdevel+bounces-4133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F17FCDF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 05:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A9928308B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DC6FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rbp8kiCs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LBRg/JeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C241735;
	Tue, 28 Nov 2023 18:46:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT2iBHo000301;
	Wed, 29 Nov 2023 02:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qjMDuqejG0fhl915Icj4cyCk/jiH3IgwnenTVQD+2qw=;
 b=Rbp8kiCs/HzhTHVWY6+MIXw8jZ4wNzjc9o/TT/lIsKWkKagS2XM1ggUAl480Z0UKle+1
 2+SzB/kduWF9Lr2kHIq13rnlZean6xKEFjE1OITiGSNWhuF4TuxfFUTn0klquzPbBcss
 oZk1aoAS/TU7Sxngq8lfpqedZt+FFP9z53SRlZ/4A0NUQpPpKGHc9HprAQn3B3MABS5u
 CcxRiBdq7EZFL60hK3QAmv1xHJamFusg1l65CcyvsX9EjSWWOrwXKf9iL/p605DSMcdt
 Z+FXJ9Xls82p0K9l4BwXq+O221046MF03p0saP25QsJo+pBfkobc3/LpxVb88QB3Pgzc tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7beyemd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 02:46:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT2ipC1026975;
	Wed, 29 Nov 2023 02:46:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7ce3y38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 02:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWhuGh8NANKghIfqIXzlG8z9btm4ObTZcO8mSpSeduH/koBVTMy+cXAWpMV4KB+2m8pPG+ctrw1b46hKXNMwxbXs1xa/mwV347ae67HDQnXCicER1WIW9+oBgSNF7l4T1bbGcV7z6U4d7+Nl5e0LpootiZbwpTzXEZzxR6fK+jz7kriomznBvJh3v4DtrPNYewiiXmHpukRnGyDjYSvhPhumjoS+NpfCJDmzeJAXvEb/hnM2zJfI1FHOtr9uS/qYK26pph1P8i6D6dunW4WGD2zCSYNxC4Lc3B2zm0vzWCKJ/SqmyR6IN2eI7x5iYuvXbZ4X73i5dfSFfCn+/yw2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjMDuqejG0fhl915Icj4cyCk/jiH3IgwnenTVQD+2qw=;
 b=nI7cqTBo7LNfoHAgSMUAbG71AAQIg1RZvgZyfdPj/tXjDGdNSGXkr5gXx9V2xJv+g7s4MjWI4LSD6J/KsG328SdHyWDvpa6b7oJittfSXJ7S6ZeZkODDSVJvleXJ0YzPqisN4Zf4RgFMpklsuiDaeHptvVccyGBDffyVo3G+EUpojZMSfeK1E1GppqoWRHEnMN0kE8wPBOmjFNGeeiJ5AQYtzT+eeryAfFj5VNLhbdO1yVd7W7p0fvPJ/6uCAvoixw4rvyDU45E37AtKYkJXxPDnPrQuzuyMxo9rgtj20/aUmGAMclCraZ6hkdUHXrs1sM3PWgjsHSXYMhHKmEll1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjMDuqejG0fhl915Icj4cyCk/jiH3IgwnenTVQD+2qw=;
 b=LBRg/JeIWBFkkalbPP7AbAPglYYm3mh6VELGRpUWXwCgm8fCl5CjLGrox4le3bqxfIVpLT6Kehxhf4ZM1ipJTZiJtW35I518sQ5cibS8SxdSRXibiVyt2VSpNqmS3zh/yd24uoaMy5/YlxqIPdv6SHWVcQ+Y5uiXUaOKQB/IeaI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4456.namprd10.prod.outlook.com (2603:10b6:510:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 02:46:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::995d:69a3:a135:1494]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::995d:69a3:a135:1494%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 02:46:04 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmu1s5iw.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
	<20230929102726.2985188-18-john.g.garry@oracle.com>
	<20231109152615.GB1521@lst.de>
	<a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
	<c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
	<20231128135619.GA12202@lst.de>
	<e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
Date: Tue, 28 Nov 2023 21:45:59 -0500
In-Reply-To: <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com> (John Garry's
	message of "Tue, 28 Nov 2023 17:42:10 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: b707e293-a7af-4534-20b5-08dbf0855415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OpIMKfP3REgRnEE32A8++gX64prNhl7OphpfaZX2KtLlmsSBuIySUIFocRw+s2j0YHPdPwBQIvIK9a2sk7re7FDEYuBx77cLxpvmE+gSTD57XAoSQEKFQ4rRWnPLpIRYd2IvjBtPRneToI2swgpTSqYhUD6MPldxmblus1nUUBfj98+g3zJAkdUk2tNsiMVzWckVEpNJNugCK67pcIx9BMWxO0IPs86JntPe1oufhO/+NXnvMfJtVqorLfZCy+G0V2zMPxVf62T24HgDyMlUVJawjrv1PzMWVcHugqHHjf9hd4V9dCCTqPbm6O1u9rG8AR/m8VK5Se5xgGeF1MTUgxZ0w2i/5IWpD5u25ThkWw6L/JjbU6R2Wa7NFUkoyQ7byyEcn1zkSg1LqeQgoRKbcCM906+C9mx5TutdAwz2F/aATJZKYj+kRxyAA8mbGKYetJjMCPHrA9s49DqGCOoKrB2rvH05uGuTf2TLy8ZLtSp57OV3bvzN3bosI3oxwY+YOaabb/pXTuECV0+1mRyaQGn0rnt19SNqw0HKK+xIviICPJhobd5zeX7P1HTcDzMX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(41300700001)(86362001)(4744005)(83380400001)(5660300002)(7416002)(26005)(2906002)(66476007)(6512007)(36916002)(6506007)(8936002)(6666004)(8676002)(6862004)(4326008)(478600001)(6486002)(6636002)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V1MtxbWBqF2dHWfJG6krDDhmTshqHRwUt1GK7h1D98E4RtVc0ocCgdmLPdFQ?=
 =?us-ascii?Q?cb5gJ4BLeei9nb8uPjjsm4w27cAaO5z8FvzeFDMazxZqFds/lNKcbewERbXO?=
 =?us-ascii?Q?l5l0I8xXNj3LtC44ciNDXUIGKz2WuR+7lG9u1H7XB5KwDFG14DbT789JGuDJ?=
 =?us-ascii?Q?2BG42sycxwIUdVmPk/jPrz1z1HoYon2kHz0HQAcGj966DDaBiGo9C84RIImN?=
 =?us-ascii?Q?eMy4yYoXNNfc6T9HNnuJ9HMreynUzRGYmBcPe8FNUxB773yPtI0O1erzpW3H?=
 =?us-ascii?Q?eq6Q1hcuZKThMrTWVwNHTm1z87vxYu2ud86M6mUie5BrRcrSWPEU63EcLvJs?=
 =?us-ascii?Q?Ia6uvzKufjVSOyxxMJQJNPitCQtkueFZWUgSRQ+C2EuVsz5z5Pb8UPVVGbw/?=
 =?us-ascii?Q?rbxsY5mqivG6Y9b5HCf3VTnzduFksG/zDPp8WeGi4W2X7acZCj7VTXMVScko?=
 =?us-ascii?Q?7/N5+pIitD4QdPzkHD1W+pQ2lkeWtyxKkstl2QnbpaaHOYEbbp8CCkFDj6DC?=
 =?us-ascii?Q?K3siH6mv/rfLZ9U/tKdd1ITGGq7yrc6iQW+uohiEAskI4VLtGvXIcGrKZ8bt?=
 =?us-ascii?Q?qUU1ctouAqrM/ZqMXeuUsGYUUPyKfovkaL2wPz1hmK8o820YiZp3JMVb2Nd2?=
 =?us-ascii?Q?b8GEu2tqT3hcmDP5k5W7u3IAwbBDshi+Gz4arlWfuRTXTzMg2EAaUhhhst+T?=
 =?us-ascii?Q?M1ICzTHzxPY9hNjNgJ/TFBeXEA6vKe6lHx+KbIoDML2IkMY+dsKa+q52/x4/?=
 =?us-ascii?Q?pO8iWSUf+d1j5A1ebiBGOb7tI8CD6+5q8sm0izwuM2wE94Mf1ynUFfRMpYYo?=
 =?us-ascii?Q?dg64sOWjOuQISgxtV+ctgi7Q46MHYqFLM8Q8oB4N710pAjq3PYZsbP1g9u2B?=
 =?us-ascii?Q?npwyY+MwSvktgerL/JJZpF5OjpnPqduOD8idgvoQgDaeLu93nVByCgyYlLw/?=
 =?us-ascii?Q?Y8zQSf0SWW68Y2ehiJ3wAGtwfDRmlJmOLeb/o8Izith1TQ+/cccMuoDpuZB9?=
 =?us-ascii?Q?VirYsviQJlkbMWPDj4lElMgYPvTB6LGFmMoqxlWBfGR3E7tMA+zW7u5xcnTv?=
 =?us-ascii?Q?Yfb3RCP50HGJ1eVAdBCH+HsIKjpG97zVb5gv/UXZgkal2wVWyE9JzpKOsQyi?=
 =?us-ascii?Q?zHIdjGfMKETUfv6FEjQbbFsYcvWME2EuovLucp2VlsJXQJeFZIoTBf3kTVf0?=
 =?us-ascii?Q?1tIARPQFVQYNfUywp+tc1lXide1lrZxC9STX9gGV5sszQefsFv5KtNAl57vw?=
 =?us-ascii?Q?7jHmyzEy2lSlOqDZ7pI4uHOveH+go17PGdc7PrPd00uNZAI/Pg3KYygEg6Xz?=
 =?us-ascii?Q?+q9qSyWuz7oliEUtnWKOQx/2fnGMexiAOq5aARj5B1K/EmZVLZqUjmgAFcpc?=
 =?us-ascii?Q?5kWybFZ95LT/sy4OEFyi/DJpcLaQTEO+bVAJ4hRp3/3Y84EAkq5JqhetxkiA?=
 =?us-ascii?Q?WBTGee4MIk8XrAnsPsBS2ibILJZM/wt7yBmqjXYvEDThlOBxEyfGFWhCP3Bm?=
 =?us-ascii?Q?gVaUoYZyfngsh8G1Pac1OjfJ0AXk2EeUwconVdpSGdbFF5fpPNMhfsc+EO/U?=
 =?us-ascii?Q?i3VHuhexwH6kcL/jlR/gpgTwbUf31QeLZvtgzq9XdZA5Nge/DrJXFiyD/X4O?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?xye/n5Cf5frT5vu/ieXt3LCDqixxNsoMraeepNtHCP4bPMyfv8KTCeRdFWaL?=
 =?us-ascii?Q?i5eL1RZRnqY3yBQahnXMWPrk1AOWqrGGVhv24vhqcaan2e9UP8pJqXnXBhWI?=
 =?us-ascii?Q?QDxQ6UcRq5K6FKasRxwJUZPeFZB07vdf31jUKL4+/+xESGQM72Ei03yumU6u?=
 =?us-ascii?Q?WuU2bokE6Ug16FZK+izMrHNFbOb104vrmQ8eUYoZi60QKwfilcZuPQ8pb3HZ?=
 =?us-ascii?Q?g5Tnm1nsilX5Zkrd83LoAAAOFfrpL31aejD4Ga4zTxYYJe0sGpKN5IYXFDgE?=
 =?us-ascii?Q?WimAf6e5Hm3bKBQCx5LD/B45apULAuz3N/KKsPKjBEqObyKgFolno9pyrID2?=
 =?us-ascii?Q?6HkQpq8QoNzMXYFvrCNanGCh/kpFmvTsy4vP4Vm0WEHUQNJFrMB8sgGQV7q0?=
 =?us-ascii?Q?rHFozj/Czr3ATp6vR5AsWkP/U3Ut2qMsaOTphzb+upkOguA1Q7on6AdMkedH?=
 =?us-ascii?Q?6oO9lotLP+1SamwwqSbgx9pSvZB8uQiwtjbLfh3BNoXPgRQyCygVaSo2zNos?=
 =?us-ascii?Q?h4oup41SuwF+jRlD2w7hQI4Lr5Iti3jS/REfQYGPc0ytb3IQTCdgmKYcj8vb?=
 =?us-ascii?Q?MunhkkGx571/PTmFmyGwPbj9eVc9KjQL3RXu+bTYdImSN4ewt8FiQ68z2PM4?=
 =?us-ascii?Q?DC8MINIZ86kWIWJMzfFlf/HzaBoVnDXnwKGVipxCBa+qwmnKC6LHZteZXmLx?=
 =?us-ascii?Q?hq8ataNRSJKYjY/pHF5VoiM1Sc3gZ1h7geWR+EXAe6LrXIMr/qbR1itKEcr2?=
 =?us-ascii?Q?RbWTYhLjH0+cpjGQscXONyvFmSpxz6voG43gIkcmaHWabnZIAin5hWFfEfnu?=
 =?us-ascii?Q?yoKafqrow2UXWMruvtnsxJI4lgGVyTNsJJPRRQDmL1rim/ejO/iR6PkZztSo?=
 =?us-ascii?Q?0BcgaAy3N3CSz224UooI66ws7e6zqX4ZE092C4BbRc2OuwzpmjXzKI1EVTUH?=
 =?us-ascii?Q?3h8NIVd3AuDBt88B0DI+WkCzo67EzRB3AzXbFHF2j0mGR53hpijw9e1ch6wz?=
 =?us-ascii?Q?ra8vELTdsaeQCdrWHRd54nREXDfbiW5EM3ZiODefO19QQOWwNtMgNYZLz6m/?=
 =?us-ascii?Q?yv97oaJgT5bb0mmBtDLH6qRlPnV35g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b707e293-a7af-4534-20b5-08dbf0855415
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 02:46:03.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BQd5dI5UqeRkgEAFGP3arHiRCLmpnmuSJogZX+ZI9cjv7Lxn/7mYeTQL+IwIy2uLbIuXBy2P5iVBcMkso/6yXoQ6w79ODLiUEZknyJo1Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290019
X-Proofpoint-ORIG-GUID: Mazf-Bsb0Ddar-grvBr76tftpfPdW5RC
X-Proofpoint-GUID: Mazf-Bsb0Ddar-grvBr76tftpfPdW5RC


> b. other FSes which do not have CoW support. ext4 is already being
> used for "atomic writes" in the field

We also need raw block device access to work within the constraints
required by the hardware.

>> probably want to do it for optimal performance, but requiring it
>> feeels rather limited.

The application developers we are working with generally prefer an error
when things are not aligned properly. Predictable performance is key.
Removing the performance variability of doing double writes is the
reason for supporting atomics in the first place.

I think there is value in providing a more generic (file-centric) atomic
user API. And I think the I/O stack plumbing we provide would be useful
in supporting such an endeavor. But I am not convinced that atomic
operations in general should be limited to the couple of filesystems
that can do CoW.

-- 
Martin K. Petersen	Oracle Linux Engineering

