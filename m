Return-Path: <linux-fsdevel+bounces-5663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8A80E9C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675081C20B17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28675DF3F;
	Tue, 12 Dec 2023 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dsiBiY09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SAPQKOIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C31DEA;
	Tue, 12 Dec 2023 03:09:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hiwQ004107;
	Tue, 12 Dec 2023 11:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=QsIaQSQ10+kf+HtOvgYV+0Vtu3ksOr0hxsYP642ebaY=;
 b=dsiBiY09VRGUGy8/LFrYQPw9RE+5PiHSyZohCRf8AAbW5XIjBY8s2rlzMb4vCrOvTBdM
 dUBqrjVUTJRVKqcyNuoZVig+F8bKDxKemk+qY0TIcps4TLxpdAZVHqIRyBFBDt1FWaKw
 qElCghpSQXrNxjU6+rdPYP/JtOqoKT4DQXgp8sx0540R1oOygm7MJqKeMYykQCl4Il9F
 IrTkrwiheD+QzK9XZ2bKJK+o6ze64g6uFjIWv33YTbwJL1V7b8gqHG265QwD/2rvSPoj
 ZNnFhcexejB++VdzGsuqupCiSYQJhoLr24l1AqR+vxZPn8x3JykDkWcflf4kMtws+fnB NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu5bhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwIar018681;
	Tue, 12 Dec 2023 11:09:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d55k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biyuqB1znf+YA6Ww/DGAdkKCZFsG1OaNNEOgVixJ83sl1SgXiAOjoxJvWBT398yIGRXT8KGClSQcY35GYEvUMxcrtw5eu+Dh8KDX/uE+fWkQNZalxPdlYHv1gZJBEd8B87riCrW8azyz6Le44ScJqG6Gb1vmGkuhxApxZ3+TQPcVuWh9uP9JZj/59kDwbTsmsskDAjEk+O/bOll1HKuEhtsJcT7hWYrCPbXo0Yl0TAj3qn7zVdfxcJHh1P8dVIm0VEoXfJodAdzcTxNTYuQSpvwtriW0iRaknkhr7nzlj2WzLd+6ubnSzPlZpdxNO7C4DO4qq3iu8vKA4AmMi4tcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsIaQSQ10+kf+HtOvgYV+0Vtu3ksOr0hxsYP642ebaY=;
 b=cHyaNwiPwXZB6vUbR/nW8Avx8eB6JAj8+I7FMvPjUE7qgvjfRcd+04ebEQvIlh3Z0biTt8E56Inctvupd8fZ46IIR8nEWgfdNzWB69FtcKhazQCyex8d3KRn9fX7CDxMGbzvXmwyQ1SOAJEJV489LlhVJHs4huqB6u/to1Vdpz46cWlAuS1La8/LY+m5OlZwbdzUeKljbzR7B5xMc91nuK29QJJihRj0i/SZYVXhlVnM5b8hSlZ4Jv4WbNcxBHo5MN1+dBgjjpqZgUn47WHpzmvEuLtddXXfpMyWbzm1jxf29mw6T9zWRwSxrptsJbEMv1D5rkWvOku1e/Xh38bQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsIaQSQ10+kf+HtOvgYV+0Vtu3ksOr0hxsYP642ebaY=;
 b=SAPQKOIK1Y6hKBQS42EHXriOLgFQvxk5xBX68JwJBUUqsLrHugGNJUGM6T2yEDQvE2Uebu4kjb848iUKNuwWeVPwKmpz45rsDPhGas+2s4xM564+diz9G1XF6Ozrzs+m5/rVdsu+rprdC/6CkLoXloJ3dR9JlQIkVBH1FzWEcgc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:18 +0000
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
Subject: [PATCH v2 04/16] fs: Increase fmode_t size
Date: Tue, 12 Dec 2023 11:08:32 +0000
Message-Id: <20231212110844.19698-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:208:19b::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7657232f-660f-43bf-c272-08dbfb02c921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JyygQuPpki0xctdwshaMOhPKHQeQLex/5qSEFjoOlhzDg7cmAvOEf9mPz2vyRe2S6+AWrEaLTODxI+S5wAvhgql78DqCWevFcEnWlZaPTsLSS3WBxGsZxPsHbc1zJeR9WA1dhYO7HuMBv1h9oNzbfDzez9hspsUItKotRZZI7RWR2zmLQfIZe1c1sVXK2lHbiIKByQfOjqdwyY9OPceFRj0wgZON52hfYo9G+kOC9YdNHPk5U1jnxt4oBkvIHs1gsgTS9Ak5mkmdKfPDmlblAXHslCW94s5BRKY4fTw9a35m+LG7pTBoowV8kK4QfHiMG/5zmdULXJc/bNI/jQIeiSOJdml2go5RhbZnOcHTkGxpEsWXFA4hSQb1jJabdobIdigNGJ0z+6melj4lhZLG7l5YzsdhCP5XGud6G6rUV5zSFgiV4IiGAp+Jyq/rd5KYKCabYZ6eCSu2BUIF9gn5oXXWgoIeUQwcTtsfF6W4F97SCi9Zf6y0jO0fAibe8JPl3Z6MBAG8ONdxY1qtSjDb/Q+2Xj558yb+KYxpLfdJ+ATK4qjnfcy0Ed/WLnfB3vsh+jF1WeZE+iJ5RnvBv+55EjFOEgMt/CjRNxhYAe9SU1U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jTTzRuh1XIYH1V3leFJ9NYWzecnd4f3h9cyW9rpoUUeWQpw6rVNrcozri9RP?=
 =?us-ascii?Q?dbqsRP6G34IDUWXpqnVR6FSnD4uJVqzE9RsvxfSU/WZJe1vVHWcGn+3Br4dO?=
 =?us-ascii?Q?MxFPNGMP0w328FirSnvZTBDbMIjTSAAek7lD7Cy9Z6Y7MMfVKBt8OvpcjVMB?=
 =?us-ascii?Q?C85kQRz+CQIeAJhNiOO7TUacXsp5La9scl+6Rwfj99Y7zvCvOTtXUQs4g7Ir?=
 =?us-ascii?Q?R9WMsvgVZdWyxQGbusAaXYrN8b0HZegHeddXejXNQ60MEQWhCU5gYcjbsjZZ?=
 =?us-ascii?Q?YpFXUaaTO0OgSqhb6IyISnBghxY5S0d9sIt8N57y7gxoKd8jFubKJUJOTo7J?=
 =?us-ascii?Q?XRnHx5kHabVFzhMHX00z2yyJ6qNLR/BHRR12VEpK/hCmVFySeG2y5QgooEqr?=
 =?us-ascii?Q?TA23qOem7Y7h1nkaSUOOTbBN6xBTmXlhrPgn7e2KUVyAQsmDU7BcIbDf7Sus?=
 =?us-ascii?Q?TpqxD0FuX3a+BsxQuEc9nGmDFUE78yNKFTx8NwhEICncVa9FmkrnoPIKQjvh?=
 =?us-ascii?Q?Hk79uokm3PqYHsuH+gGss7FY4CLK5ncTrg5Bj9zDo7moX9H7VgPXdHd7lCF1?=
 =?us-ascii?Q?dyWZONvuG57EUsrCf4mQge5lmcS9kV8EZwGUhUgTqDpZ6eIlBL7yRYTcWMpR?=
 =?us-ascii?Q?y8HkwwtumCXDp8vEvxu+HsIPXx6HS2ZlmKD+D1DVl6KdiogLw/8tVe46SxAA?=
 =?us-ascii?Q?d/9r7RvKG4gTLlbaDz5TEjBUsY511nInFihL4tqqEujwXOS/oQDsLmU/zx9V?=
 =?us-ascii?Q?VF3Wj9fGp70NsqSB9SZidiIH5pxPZOVRrMZuwPq5Ah6K3cvu4ePqaw2U6fH4?=
 =?us-ascii?Q?XY4wzc9abLXxDgTL2Ig2wTTieZ6tVBk7wFGsoY5HSF3xho+FmksVxJSWwsuu?=
 =?us-ascii?Q?PGKchUYldeKF/YD6alwR+x61UhSp/VZhH4qNx0CxOGXh9TyvPgeX1i068NqG?=
 =?us-ascii?Q?Ad3ahXqN+TYf0AN2TQAyrauhPg5BsplLdutIKbHr1tQBFMy2lmeCQ6VaDUfs?=
 =?us-ascii?Q?bZvqaM75XHMA7kUbjBs6tJA6OAcUY/qkIPyWXnuDlJp9hfZVUlGyOaNGO83o?=
 =?us-ascii?Q?mE9kATkdgthkOl3BTgApp7u/7bRFVzqXI82xUQ8cnjy/ABmsb87OgyNsQkdw?=
 =?us-ascii?Q?MrZCdgnWaafPcEzJvMdRR9o4tWnj4aY6vpPXWXMOxssDcEwZKnerrdc/iHwe?=
 =?us-ascii?Q?A0aIXf6xyv6b77mAroCgREP2sRb9TegvXgBIHe6WXs3oOsb+zUngiFk+AS4h?=
 =?us-ascii?Q?1pnmYONAW4kQ9MVvpoGNn6IjjqNdgfucL+zfF8ZAYDR9/YjCEcDuK1MCoIkd?=
 =?us-ascii?Q?WsYLzmgzzEe4HgAvkxWXf2raP20UqkNk8p4EyVdkHsPzuAoK+2RrDQXHfPDq?=
 =?us-ascii?Q?l409e+qCxs6b8ZTNqtA7iyX1MWNuQJb9gDZ4nN1lsiBrZsWDM+hXtcXTIQaO?=
 =?us-ascii?Q?Y1OgtwnzPSBAcLhTxomt7khLrC47BJP3pm2AJVuajtST/b8kVcQx0UwQR46d?=
 =?us-ascii?Q?5KHQx4hg1S0leH93/iBxWobHxHehc36RTLhG1fJ7/nj8/dah6Pkn5H0XG3yO?=
 =?us-ascii?Q?ErqBLSs913qM/7xQiMaCnzshs9A+RPapqySiTgM1HZgeHaph2c2LjvtKrw1S?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vgKHwCzJrGfLjjlOsGbTglujxYg+tw358fh4Nf33gHNLv/7THJhFpkvl7CMnpQcjm5pILUeCodKO9P8C5TPGAAWV+OuvSPL5HccO+v4UgTbx5lHz6PYknNjZySwisPOoOfnAKx/d155v0US4M+L4D5hmBliEpErU2Uo21zmYU2XEhpExm+G7nZDEJHJ+zsqxXS9fV114n2xr2LPsHH8N1LV7cB2mEAhQsHYanknzQLKCYDr5l71UwhZ9NbuAUDC7U71UjJgfXRrHysG6Ugmy/Qx9CHszweZqcCV6I8DzEQcuBKKOsjkFPpbbHHEgwfA6yuzziE18QNZu2SENZzRaM/Rt54yqcD7vm+93SQIbXBhx5WQuiXW5v1SZ0lCO0M+q5At2d1QNeglBY+81r1lrKwfXBzkVBaBNDg4D6VjOYygO2t2Yhg2JZicgMwPB1Gsi9Fb3UcD9/n3WXJzUKLOJ9IwAMtkf2WiWJSgEMnQkz3HtyX7RhFImX/Xf7M+dksSid5KniJF3AS+vYINDtK1wEIuzGzRkHYooRbS83kzau1Hii64HLW/aNU+kCPCcukF4tqs42onW20sC3497BxzIEl5rJ1XqPO+qq0xGUhV2viM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7657232f-660f-43bf-c272-08dbfb02c921
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:18.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAU4+dEiOkNZK7qbq9sKhn1PxHPYL9sXqmBIgDpx/t6+GQb40yf+8Qr/NzCzIgpxOAU0vi6ZhQVU5Rb/DtyUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-GUID: P28bIBxBDMzJ2l0uxtjFOenkqUGGZokq
X-Proofpoint-ORIG-GUID: P28bIBxBDMzJ2l0uxtjFOenkqUGGZokq

Currently all bits are being used in fmode_t.

To allow for further expansion, increase from unsigned int to unsigned
long.

Since the dma-buf driver prints the file->f_mode member, change the print
as necessary to deal with the larger size.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 include/linux/types.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 21916bba77d5..a5227ae3d637 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1628,7 +1628,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 
 
 		spin_lock(&buf_obj->name_lock);
-		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
+		seq_printf(s, "%08zu\t%08x\t%08lx\t%08ld\t%s\t%08lu\t%s\n",
 				buf_obj->size,
 				buf_obj->file->f_flags, buf_obj->file->f_mode,
 				file_count(buf_obj->file),
diff --git a/include/linux/types.h b/include/linux/types.h
index 253168bb3fe1..49c754fde1d6 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -153,7 +153,7 @@ typedef u32 dma_addr_t;
 
 typedef unsigned int __bitwise gfp_t;
 typedef unsigned int __bitwise slab_flags_t;
-typedef unsigned int __bitwise fmode_t;
+typedef unsigned long __bitwise fmode_t;
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 typedef u64 phys_addr_t;
-- 
2.35.3


