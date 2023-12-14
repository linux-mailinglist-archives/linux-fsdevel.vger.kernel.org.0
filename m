Return-Path: <linux-fsdevel+bounces-6034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5602C81269D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 05:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1345F2828AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 04:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA186110;
	Thu, 14 Dec 2023 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NyNtB44S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DuQdkZIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32647B9;
	Wed, 13 Dec 2023 20:35:10 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0SEvR009683;
	Thu, 14 Dec 2023 04:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1GBcMPwGDIaxPTXtjVZnAevLkR7jfTRLsRJf0QZNV80=;
 b=NyNtB44SVhV86XBZ16IZDJUsBcR16Qs1qkKPC1L4B6kMNsm4l5hxvFSkvEVJvcDUxKUZ
 IKtLKzk6IC7U42VpwDPudmXMF+Q1pAf88POM20MJzT4DhAq/ClISvIF0ylD0+p338pPA
 pkcZeV9mZJbdwN5r/lcifkuQh5skWiJVHm/wT12EofFfD0dGf+4Qk+I71129YIhz+F50
 A9s0Pb7Jwfnwm9UF1WqhIp630e3BD9rpA0f9eOeutr4kCDSc8hXf99E0PRMrKv1pj2/n
 rjCRCrMa6Yk8tQ0MA3nlDnSdvkV/hVAWBx1ne/Jxap7tffKZY3qluy69CDyRpv2wyNLJ WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu29smt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:34:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE4URX0013052;
	Thu, 14 Dec 2023 04:34:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepfqk5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 04:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMp8tDRH1wcoujgkZ1nFYNs1Ex3rC6VbpXFK29JnS6vFTEV/5TFBsTfioQmZjq3ByAkuzLeL5HFs6Z/ZH9wC2jnp3ydO98M0Pajt9RyOELsv38+DRF32ZS+SLZ8GQRcsUyvnfN8raESCVcXOsrR6Z8rhAu54G4mNkFvxD1d1UP5+6ylS3tBk6cUTLg/6SaedPxuvm97D+zpnBPBghfHOG3uVPSqso6kdGxvKDZBr9PBihXIkbSWT4JITVoJwDF8CWzsA1mFCyOj47c0nbv0BcwEwvxXITHLU184rjZGNaCThIEjZOY3F1Zgf/Bs2scOPN53dZ4fwQr1EDis5llx3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GBcMPwGDIaxPTXtjVZnAevLkR7jfTRLsRJf0QZNV80=;
 b=DduMJInB0lLshXcocLPGR+tGobhIpeoecswDQze87l5TYDVv2hG64zFUYm2Zd/2423Bs5xqCqBSw+LBuiqwPOB1xyEBvbSnOm0oois/PjowLlTvbxgjRAZpyHz+JMpJ1BIzVgxbgifCO/iGldO53TRi7o1B4ZOEmbZPfRIuau8ifnu7UpGwAyVFkXrcpGzSUWQFK4jsF5iuZNjVPuSpTy9rlsqFaXTiDjynzC/LRcZ4c+xBwwvOdgQTkTIgJHahZJ1CG7bylUUNO7yN8gyeQtHuAje9g5RURW9HpYe/C5TRuoDwFL227kZqLreK449hNIXI76BoHsW6qLLJzHfpkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GBcMPwGDIaxPTXtjVZnAevLkR7jfTRLsRJf0QZNV80=;
 b=DuQdkZIrVk7rRiQOE81/g1FFqHrkvoybhmHZsKGxhXwjA3hkn6PRno0yP5F2F2kktbb0Ot5OL2Ya5cKkOarmwtUey8jpr3XOkg8bW7umPigpXo7Au8J1qywqHHdILGdCJGtB0G3p5nND03duDG9rS8BLw5Uq/10wZgMkmawYN/I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 04:34:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 04:34:39 +0000
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
Message-ID: <yq1il51flnj.fsf@ca-mkp.ca.oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
	<20231212110844.19698-2-john.g.garry@oracle.com>
	<ZXkIEnQld577uHqu@fedora>
Date: Wed, 13 Dec 2023 23:34:37 -0500
In-Reply-To: <ZXkIEnQld577uHqu@fedora> (Ming Lei's message of "Wed, 13 Dec
	2023 09:25:38 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f95380-e308-4315-ed11-08dbfc5dfbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SHWT8m+0+3TVKX46iqHWgnQwEiq3JB/ffwC8HsA5+DDfOYzKVnCdAQmv0FM2ccBXCZeZHaIC8Iek8cEVjvpLtA98WIq8D/VNvwBCmOTJkglMjQPPyPCd+OWUKP3s2yRPrD9NcaeV7WSHXWrZCdv3db9vI74X4241kgwT64FWGpfnzi6XNWERVP1jtr+4CAxvH4FFJoGE0H9n9uju80Tb+xCTMc/fU2l3WfMZa5lP3iRJ8MPfQMCbHsrm90BJ5cT0ZTUEDnRnl/32JgZx+eUKYJpUFdLRyPoUzrEGQ5VDgz8/b7It/d5owDtSjslSwko3omN9M6DAU1y3jjAEjhmTW8ldkp1RvaWptITKqdrGsKFtNOx3IAXLGyQZ3Gf2hriyhbClKwZ4bw9mECfFUEhAje4JGeepsyz8WxOzeSr+Lh+TgmFyobc/jh2RmiU29Lf53PKqibHrOPF70YW4f1iX1bYZAabGGCxCK8pohQsq3Vo5XIbFhNB+h7QF5ydLa/qdVMAUit09poqmR/15pzuSKuogR9SPowOgJHElt8aLtxrfpG+aVeV212BE+25ym6z0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4744005)(2906002)(7416002)(86362001)(4326008)(8676002)(8936002)(316002)(5660300002)(41300700001)(6486002)(478600001)(6512007)(107886003)(26005)(36916002)(6506007)(83380400001)(38100700002)(66946007)(66556008)(66476007)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?du34uuax/nkU58dxoXn7xm17iJGAT8FVT1T7LgGef7BrHMJDBqhkQ+vk61cl?=
 =?us-ascii?Q?40DyChZHXTlTxQONbQiujFVEkqkngRoRZXss0yCvyCQRHRuy/gX6Q7mtLhIt?=
 =?us-ascii?Q?gZS79qPsmd4T6S1Zha5IYFerw6+rwzeAbCLF/+SZcZc5ouWdzm26dfp+dbwL?=
 =?us-ascii?Q?ECtGwsJwDF5absD58D9aq+re57g/mFWZ36eVEoJZhqoCfwDY9XzweMf9xjip?=
 =?us-ascii?Q?kDClkaRdFcgEeGyXMd2fhxWgCvw8ZJV8VgjygPSGvTNqfsTvqWxDKjilnVyz?=
 =?us-ascii?Q?UX5Uhfw6vAvbMp3Iww7IntITAKJagkLj0wxE6YlPArSPncmerf1WhrmfX/SF?=
 =?us-ascii?Q?L/wML1iD5ghrExwZTr/1xdDQLkG6LUtjBhVQCPMvKkWYGxICCi6NhFWMjkP7?=
 =?us-ascii?Q?tyHhTVOhpMuCAzvk6/oMhT9S9wmVYPCs10ZF9VErH6RWky+3bXG7j7IAr5kz?=
 =?us-ascii?Q?+fwjvPESPbJlw8xevmPLzATY566NLPbc0XTcR1TivFlzGd7mAAIj+ZiQQQaC?=
 =?us-ascii?Q?ggLCl8moOUztu6tY7VqIKQDL+wrNaznPOWTK6R/ydaXKGFQ8pkdd2ReDQc5s?=
 =?us-ascii?Q?tw/YE1NOyjBiNLicz6ua41eUmShrdFlB9DvswEL1CKafS0tNnPmyFsmG6AhY?=
 =?us-ascii?Q?0dh4tykHO+3PMaAxGnlu9vTsGyCMlyS2DWwZH7wDBwaWHsFrwe2s90rUtv3c?=
 =?us-ascii?Q?NPBOcF+Yoz7h31cFzx77PFwjSfdYOoSYBo/aPByYroUXXg8eGL2sHrWYNWwy?=
 =?us-ascii?Q?QawKFC0p/4J9+Wpr4rtbBeN8X0dRSeH3egwT6asms+kiMST9PK3ALWtuVxTB?=
 =?us-ascii?Q?hI/VJeHFTtsx5oIKQWhKNWMWuE5P/75PBy0Hcy+zRiAHdPn5HbxRCffCJWK4?=
 =?us-ascii?Q?0A6Ck9re8x1qp7Vd9tVmmTq0pC6ktvZuXAhT3r5PtbDGLrIJh0kyoyH+5IXz?=
 =?us-ascii?Q?HUlYRRnyp5OE6H4CzMwHRBhQ7LR5tjKbqFQlOTstRKJV7vknOGWMbWpit873?=
 =?us-ascii?Q?qc4FfW4fvS5PP63/jXUnJuCteinmvR8/hzEWDUQc2R8HBI3ootNO126hkNGU?=
 =?us-ascii?Q?6xMkfUWtMWLA9P3Y6Lhhl9QyEzrgr4CCRt1446N5BB29pp8LYNNTbJ+o4qOy?=
 =?us-ascii?Q?m06FHgJexU6H3046KFl8iWHkf3LyypXc9QOZjkonMWTy0qeMg+qCnadfaOCo?=
 =?us-ascii?Q?5dJY1Au8uMyDrw3d7O5/y1RM3hxSJdRKGFLEtNQczlmWSAOmvx05Ulw3JRb1?=
 =?us-ascii?Q?M4+aj/bRdjFpx1PtuYxTM3wXIpZoCYUrXo92mE8Ev02NZllJZ5tZQM3xR93q?=
 =?us-ascii?Q?Uofl38d7HBMTH1V9l37tkRqujwtKDQ/hZmfdbFpbe40mR85+weC8iXpieEFI?=
 =?us-ascii?Q?ROAdapRuUMDoaj+EL2NRyzeVCA3MZ9hID5hQuLUdNeXFh97gpkpNrKcEd4P8?=
 =?us-ascii?Q?ZB0bO3gJnMLe7BG1WvG/Cf3bWq6rmgdhjM4Whxl+1DGn3xMc5lYnnqAutDza?=
 =?us-ascii?Q?mMA8aEbh5Vq2cP2HSpanzEBWhDWFt33meCWGwW0eB46IR5FcLpG7/8jn/r/D?=
 =?us-ascii?Q?2mubmNV94OHrsjUVugybRp7XymTlOs1bOAA74Ig9hMGNAUbawxkRw2RQe1Tg?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GTo7gIznNzRromdPyZ+g/oWRKlV7ER+AuXsPX4Upf5DmKSbSAGulx2QxVSb3/mX/5iRCAs3bp22Jk2qf6++l9jQQPt49HSeYbqareTCI8pBFejZ3Vu8P5PoEppfprCitx3rbbjn8g95/Na/V1swh4WDc3lXTEU4xbjMQ0E58tFkSGb3X8+jUZTJN2i8DJgT5+ejmv+71cqCtySlKC7S1aPpGp9x4YyixX7D5ET+1jYgRYOHNc/CkANJv1yKPmxrf8WcOJhTo8BlfAqOHKtui36QIMUTssR7wZSfeXD/JrrL1HntJrW7Ze40PvmcwT/OaSnI0qeO7m02T2nsSf7o+0zFh/lm5pWrKTdKragFghu9owZDfWBiEaZ/S82xWM3typpsb+BGhH6BRD+nhCRlAsid89pDMTwLR9Crutp/LieRCkKRzvKpXqPOAPWkVzliG6+Xgws4+2RBtd7+zXbIFl850LVQqr83zqrmc4SOwUUJJDNjLMFS49ZDGOaaJHjeAwgqhdpYfOwXNruv/e0cvV69Dg0DkjiLrN+iiH8P0qdGwOFQ7Sqf2Mxm3r1yB23+317uS56CoGqdvg0an/gWKQLNAZ8bfn+ysq2fpyWKu9+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f95380-e308-4315-ed11-08dbfc5dfbcc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 04:34:39.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qBumKp/KCl5PT6Ljx0beDAZKUBiOiTfIByr9YITgHLbePrhrgH+H9YuoTqFa4y8qB6piuhD+H+QN7NVCJ4KbfVjA1eyRIaXS0UYWKLo548=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=782 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140024
X-Proofpoint-ORIG-GUID: 2okomzqzP-A77CCi_1M0DD3yTweOsuvC
X-Proofpoint-GUID: 2okomzqzP-A77CCi_1M0DD3yTweOsuvC


Hi Ming!

>> +	lim->atomic_write_unit_min_sectors = 0;
>> +	lim->atomic_write_unit_max_sectors = 0;
>> +	lim->atomic_write_max_sectors = 0;
>> +	lim->atomic_write_boundary_sectors = 0;
>
> Can we move the four into single structure and setup them in single
> API? Then cross-validation can be done in this API.

Why would we put them in a separate struct? We don't do that for any of
the other queue_limits.

-- 
Martin K. Petersen	Oracle Linux Engineering

