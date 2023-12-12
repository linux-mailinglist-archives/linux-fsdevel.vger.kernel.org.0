Return-Path: <linux-fsdevel+bounces-5660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8880E9B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33648281695
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AB5D495;
	Tue, 12 Dec 2023 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZfOplo8f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f2RkOJHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD16AC;
	Tue, 12 Dec 2023 03:09:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hlTg020135;
	Tue, 12 Dec 2023 11:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=CMOjv+9CapWMIYf4DkV6dy+PvvxCg+E533Zxy8r0pXI=;
 b=ZfOplo8fhrqlLbzE0Pd7gvuCdhwxlES6e7UEEeBbEIOI0fh2YzSu6tz8NmtSuG1svKwu
 XqqM2O8KwC7/auun9i8yLEh+lMGjiQBfKqqgVxL6OzkHzcBqM9eve4yGIbfPc67nQOLe
 evIp0c60vJSpct6asdx2y3QJ2AcuFrfpxsYPPwWDLTVLeldefrzRiBkciH/ZYXJA2BdK
 GBAyKsQltQRI8fOp6ubGbx6PDZZmE0FgnC9L/mID4ugrHwedCbQcowy56MhwoYUQQsCJ
 Reeype2UzzMOwuZ5aHCOxeO5ZbJM+O6rfC2PozCeMLIahHfuAvIw1b5/F/KNr6CXh/da TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrkrbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAZCin018664;
	Tue, 12 Dec 2023 11:09:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d56w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu6418NMDFTor1JRGc4nJk5Y3bmGvvyVdkqS/BRcZSFPsa/MYI4r+3wguaCQboub31FTBX8r6vqOGgI4qT+aMnE8ugxo+QbCClMpBJqNDG55uj7nGLAKL10tb+0ybbd9bPYgH6PPT2gL8XiAum+gbwMwWyBP5m0k+1MB2Hs9SWOPieLhtHswStsUYHW0Jbxt6cITAac/Jkm23kIhkJpvygZ1Q4ELD0Mi+4FJpGzjB4zzz2uAXN9k/9FRZioOfzk9xY8W+zknchqnfyf6NkSmZOpQ/14JyJZh8TSeK1JJRJZLWhrLy/OKqTvI6HAonkRyN8BHsw/1rLam08PB93FqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMOjv+9CapWMIYf4DkV6dy+PvvxCg+E533Zxy8r0pXI=;
 b=M9yXch3sreLXo8ZBUK9Buw0zKVdKYFjonEgRE+GaJPLyoCbDb6egWOUj/IAuV89A/dNw0kxSLsMzN1W8Fr8jDjrrDG2MfCJnwCrzjceEmQPIQKOVLQcCR2CMxEHjezYMtQdyOEFSNmm/9J7WzCUBR+ebEe3Xcc59mwudWADsdFSMcpmKmlfiVYqTe3w+DoilHwsB7t1umtsg4MXRv2J9+pqfZ4R6FTq52pkqfmupYwohOXyRWG9moEds7eJQaiCaFD0C8JEliT5nhgsCDuOHGAhZf0UO5gYr9orutb14vg6ERUR/3t3HtwmPfk8ElkFsw6zNW155/lVIODv1A2gypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMOjv+9CapWMIYf4DkV6dy+PvvxCg+E533Zxy8r0pXI=;
 b=f2RkOJHKYQRetKNlcuw8VTqx5WS4r0k4SDgEsi/UQ6gcOg0PQKQxChOOMnUTLC7ytoj0HaWRWWKej17m7nQF/Y3TmP1g8lLGBuuKICbzDevLNZrRiItlDSZKGnDgXPGP8+zc/C+dpiSCgVj0EWIcG9KrByBJI8JUwAofnr+KeEY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/16] block: Pass blk_queue_get_max_sectors() a request pointer
Date: Tue, 12 Dec 2023 11:08:35 +0000
Message-Id: <20231212110844.19698-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d83292-1dd0-44ae-16f8-08dbfb02cb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZNefzU2AJY3RuDVqpqMzjsWrmY4J6Tm87zLe5+CYwV9RSmGlagLqo3C3NysSN/KlFZrDVU53U3tkbZ/0CZP4ABpFLo5Pg5ebCTiXZqHlJ4GCLEXyuqEhnbpXOej1yPrk3H1vZItpLnkTApR/38gRdDHjmsF6VdQLwjqQuEupLI97L/Vb/pTof22yB2/KoAwJJT3F3nBIkrO0wVJ7cuWs3xSbdyahsMuEIHi49vrEq2CvoT01Y/q4HMjsOsEBkyg0BX/8Q50LsdGhEW6yvFTeLQM7eu06oJfc3p9U0wz9j7RozUPg3Bgbh5nfUZuRyPVkzD3OQGcE4rj3p45KoXIPBe/hAMNt5cOyaXlzNDZIJf6NfYwoJ5sGa3BrH4BjQSkeaki90OKmakn+KEybyrkRlf4tVOTfX3/ozGhZW+QLlsNbP100feMskxHP96bleqVzh7UdW1adrwerPHUpDVEZ6xHKl8bJvPmWn/ZpN8D/6mP4EVdBn47A2d9km/FKcSOBGnzCuyJjMHng46lfr/TDTBzcE635BSkZD6APBIrripGNOFtaFrRwF9/2ElEidrezrA7HHpSJb8MFzSwwi6Of/k5h27FdL5gjIv9Q+cPta+8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nb8hoA9A2sa/7C9hSNcEFA1psO3c8xI+B3eLBaWz54cFouccrpWJcmfWZcMM?=
 =?us-ascii?Q?oSzt1bXd2D9IR6eBEq2GP0K/t4m68fCPNn+9w9nAEctqyIZXI34Rel56Kfka?=
 =?us-ascii?Q?wptawovBhLHmZkTBCeIChUv9ZR9k1JWNyAMo8TIHJF98bTy0b++iebyJBjQb?=
 =?us-ascii?Q?F7WcmfPXDAMSznWKD/fJm/7RoZ3XDjWAYNtikQHHMTYWg0LIiGBB21qJgM9x?=
 =?us-ascii?Q?X3rTNu2Ymy7nwyl1sNfk0+w9Q7Xtbvz7QUV/08BOPLO36XiQ4JPOTqYMz6Qo?=
 =?us-ascii?Q?iAzpzfTh0II8EfmONXL4YrhimdwXtgJPmI7nXPinr80DWYitFuB3sONlBf3r?=
 =?us-ascii?Q?sr1wvcFSP9wj+0k6NiKKnN60EBoU7uI/hQGERpEA5wv4oIFiP0ccNsczce2+?=
 =?us-ascii?Q?03vE6MhhOHL8mQ4wN3jL9uP0sf+RXRiMJzkXhbAc2kHqsXF3zXui9ZwEGoGz?=
 =?us-ascii?Q?mPy1NQogJ92s5DX5bGX+n7foAs4cxvBDMAUEPpy7z65cKc7uddlVWrN2TaSH?=
 =?us-ascii?Q?cehz48o+WQvbdGDO0M51mCsukKrFMYsH+rBTuBtQjEK7Wt8abE0ZRlX4SEh1?=
 =?us-ascii?Q?/RF+QFfmIDsO4WHDJ7Unv9WgUegs2K238A+vSSxgRQTFlNBdl/cUyiKylO0Z?=
 =?us-ascii?Q?qSysiXtqI7v119bEWDiCfw7Pa0AXsMRzG58I19zjSTFP9uwVCabPf/QqDO0l?=
 =?us-ascii?Q?mkbC2+XYWpX3Uznx87H3Sns1RTCZCkG6MBdINj5u/yZ+BxRiPe/Ol63XwruX?=
 =?us-ascii?Q?Euz3WOzP5mfuBvfCejhyfFwAivH+SadHteiUj3M+LyoK3OGyzMq7df/aCHp4?=
 =?us-ascii?Q?qMyAMZDWOUjQySuTmvlyBvtff4aIyslwSDbjt/2/pAqgyJ8JLLLN4wK+JPYi?=
 =?us-ascii?Q?UnR3qeoDi1wltc1t6HnjnLnuHjBeVeGAMWk6gUjdVR+LDHPg5wrnbHDGEoRF?=
 =?us-ascii?Q?t7NldasOqPpV2FdHrkezv2PhAMpAsXUE76LdL33uyi7hYlxiLew33EsOsKln?=
 =?us-ascii?Q?c/gRU1o+spY9QUVY/v9n9svARi/RAJ3lYdgSnsUVqDqzcSmKI3eQfhGmAyei?=
 =?us-ascii?Q?NOoB+Xh4RALSpr1+X/tRIVcUrS6kaTKq8BhxwKFhaH78lwQVM/Qx3ZM5wk1P?=
 =?us-ascii?Q?uoOKhy2RiWPatgecd4OV7xqQOsy5WgjQAxvIwasGoJW/o1+czRmfADzCwmm+?=
 =?us-ascii?Q?LCM0XhbTVd/vIqQMHuRsUszkbFstC4n3nh8qZG5FPO+rHyLIFOfsgJRhSnI9?=
 =?us-ascii?Q?Owbcm27R+g5b3DyJKjxDr3KIgIsiM3NRc9JzTKCod1845lPu1R3cck4m5Bpg?=
 =?us-ascii?Q?J52lF4UilnfV/Af78REiC07Gau1QQzwShyHQ4iHVRhJbVXDmm1VfB/7QnqnV?=
 =?us-ascii?Q?jEVawCmyrdjoDRWkL6y9/EcyfVH3RyyXx5HKHIK4dSUS5eprUOnr/2R9lHj1?=
 =?us-ascii?Q?YTleNbPeqcNLBWFr/4zd59kybGdd7KS6Zm1L9Ojq/+43YQ8nmUkwkTVl2eqj?=
 =?us-ascii?Q?cp8aspBgVFGbdlOzqVwm0DOatXlBStFfOJed/8YfRwnf93mpHPjEnOY7B/wp?=
 =?us-ascii?Q?YVp4nYFAsVSnuN6I+OXh3KUWFR1d/SplFfflbjUaEvdJNk0CrEF0fVd/M8lg?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f0V1Q87NxmNHqkpoAX3Og+lXk8dNyhKqNt4HgG6Hsp8PqpdaUR9N7CW6DN+fwCrrC6r1zHkAguCK5jE9vzYhqOY7rYQ3EG7ebrg15Lcr/UoWhufvnxQ7GWhoWJC0PbBONcbL4+hlcRm0au9kFXE0azskKkObVBQ0f+Xj0zCX6VNbPR1irOa0UcRRObXUyuywZh1dtQsWCWh3v1i1dTDfkZRcAmXrOJ9Fvo0/7miyixIF36OvLNxs6I5/z5Om8AJZtSPyBG+RYnXrTM4OqJhv2rKRjxw/LtujTr4a+0FXIreFmL8jcSTs5+ebEmIyEdy9UkcwNfbVwwO9O+Wb2UakixWtQ3qc2WoWQH9npwL27qG6ZaouZJ/lRfz9E4bKQCUf2cN2Ej1S9R94yqnXDY0t+o3kxpZPIJvMSs4A1Y44lMDOthzWD8fXMZOoK5W7WPPEW24K6loRRviQexZPxFvo7FYT1nRLYlIb7BDhmFbmPqKJnw0vMWr0R8R1+TwSw4LUFWqGD4BCGW6mD+L58mrrJllLBu5/9NO0UVgh5j3SushiGuHejloQQaCbx+1FrcWSoApyFQUcKq6csKy7xwWaTMdySuQOvUJVDrqFwEgmJrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d83292-1dd0-44ae-16f8-08dbfb02cb33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:22.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgNin03wPXdi70znfEvP4WabT9OHkNVymA47UHypEuVYMpbIYSoYg8dhE3MgEW+s77sAGwZJYjnjJORveDo6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-GUID: x8Mur7bWVVwKpUcZaR43C_HYMjYqNr83
X-Proofpoint-ORIG-GUID: x8Mur7bWVVwKpUcZaR43C_HYMjYqNr83

Currently blk_queue_get_max_sectors() is passed a enum req_op, which does
not work for atomic writes. This is because an atomic write has a different
max sectors values to a regular write, and we need the rq->cmd_flags
to know that we have an atomic write, so pass the request pointer, which
has all information available.

Also use rq->cmd_flags instead of rq->bio->bi_opf when possible.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 3 ++-
 block/blk-mq.c    | 2 +-
 block/blk.h       | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..0ccc251e22ff 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -596,7 +596,8 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	max_sectors = blk_queue_get_max_sectors(rq);
+
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac18f802c027..58bacf9029b3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3027,7 +3027,7 @@ void blk_mq_submit_bio(struct bio *bio)
 blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_sectors = blk_queue_get_max_sectors(rq);
 	unsigned int max_segments = blk_rq_get_max_segments(rq);
 	blk_status_t ret;
 
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..94e330e9c853 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -166,9 +166,11 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 	return queue_max_segments(rq->q);
 }
 
-static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     enum req_op op)
+static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 {
+	struct request_queue *q = rq->q;
+	enum req_op op = req_op(rq);
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
-- 
2.35.3


