Return-Path: <linux-fsdevel+bounces-5674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CD80EA10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C251C20C45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58C5DF1F;
	Tue, 12 Dec 2023 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f4bx7mSs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hYI5+Vnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46895D5B;
	Tue, 12 Dec 2023 03:12:11 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7iRbN008820;
	Tue, 12 Dec 2023 11:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LOfd5S9ReCEogL9goxCB0fbMXjqtgR8FVaHhYpnjI0Q=;
 b=f4bx7mSsaO+tT4goJUc4tW+Y5K0cEzFYxQrLmf0BN8+SoRI+6699TDm4jlqEPRkdU3Do
 oqodlPxE7nbqAvyOMk0XVSga4ESXQX5j1WnRzK0HEzrDsdrNY5jXd1Ua22BIkMRmbG+y
 6YsMXzoCoOChMcY2UZ/wdBDmwut0Prc1H+urRKaYJ5AG+mGO10q+G8VlTOXbrweKOHTp
 WEBBLOLJVQAGpU7HCXfHdIPamJ2Tk7n7C/jdcjDMFv2uEN/nw26ooiixi5wniYLekHOT
 l5d3+JzdV3159druDVCwRF1c3cRwjFasKb7M9Di2+R7hTuGkDgnKf9Rk9IwSlcL2M5eb xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c5bks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAIQ8v018689;
	Tue, 12 Dec 2023 11:09:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d59h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCiT+FCknxF71c/Im8if4Lws4vUwQJC6lUq1uMYyY7S40eN5JxcvD+qu85jFiqmIk9mZQBDzRbwXh49JgcBZy0IFMGHba3apXXkDc5VONaYhrNEfRgBqaK1SYyIOzC6wV+GjEJCDB/MSrxK8biAoI0fGuo+8JHIs827DGR361/cret7jqCBp1R7k6ALKs9IOhH23sLAvFzadARP99MjAF0mdl59JxztfxkUqTrlZv518qVv5gkCj3XfPzkhqvyO9hEuxt4PhH0Krh4nj/BGFvmGCakvR8dO7YncpdPzQguBM8ioFAnMggX+N3/roegATl89f1xbtu4hvi1sY86/ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOfd5S9ReCEogL9goxCB0fbMXjqtgR8FVaHhYpnjI0Q=;
 b=HF+x1mvWDYX4vbylZJDUaCB9Hm9I6Xm9NAuzlIi0nWPYzPTuoMMphsw6YcHiM9V9CZxJhI/vV7ouX98CB9sDtJdefz/GSUz6W7icQQQ6kQksJE/qXnPokd7lF3OMmsjeHLDLuKR3YIIceOsbgZ5D2loPh+MzkoRy9ibDRNcFLbWcYELMCIuA9uI26PcuM4j/cC/tfcUOA4rGp+BLGhP2uLSghSMgyqub4hJH5lJTeCP7BExDhv5Mm+ILs+kZLW1coGTZDmc8IC3Ubht96Wgz0FKbYzF8Hc6juO0yIVAulU9u4++hveXFJXcgozJ/5FrgkZEHw5Ig+AHjEUXs4UPQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOfd5S9ReCEogL9goxCB0fbMXjqtgR8FVaHhYpnjI0Q=;
 b=hYI5+VndNmP86ecJDhQM9mto5uKxelpu8NzOhhiwP3IZLcea13NvP1NokHtEo7PAMsA9wOAPVpd5d0HRrEuU8/ru+TG5ZAvAwzz6sPmLQNGcMOrmUhHzJnjgmErmb5OFNvUIEG9zREnSlH06lzxGkhCHfHGDf4EzHROtfz+1yoY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:30 +0000
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
Subject: [PATCH v2 12/16] scsi: sd: Support reading atomic write properties from block limits VPD
Date: Tue, 12 Dec 2023 11:08:40 +0000
Message-Id: <20231212110844.19698-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 896c5ce4-2ade-4370-07c6-08dbfb02d05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KVv130Ve3gwxstWtKTmGhd0jfCFzqag9Dmx26jTYBS+qHMCipJ4kh7Y0ooYfvxLg8pnzBgYXAwl+txKgwPBHbye3UC/SbHtAThCvBR7bS1gdgUptPWnc69PitlhcfCqKloCOHfPAw5UJYxTt94pVAHYpelzKizhu6YLdVGSzrlTG/7RMKHm5Gb0fSvZROoh05GhKWdnBnKWo+NobEc0DYLGgtR0Z2JVIIGuWCjrM8ZdYhRq1W2HNFOn5nJcGVvEC4+nGnGHgFi8SEEY4HDl1M94ZUAMSYnjbJKEN06aIvpm4l6XnkySybs5wAnrMTKIcT4oEShJ/pNaLM/M3Dm4Qc7jQwh2MtEW2bPO93S2V0ngYQH8K89Ft3bh+YRCmhQKW4LGc6oniqvDeK0s2iRSgwIZA857/BfseytzVkzfq4uhBcyt5pfwa9wK4rcsvS8Wrtj10LX3V/C/t0UUwhW8wMDY7lOoTo+e7LMw1X4yjsTwZA8/GOlXUdfwjcwmh1kd+tx+ad0VmHVD/7ytZpiqzJkESrIq9mv2d4yB82f+Posd6jDGCQPGxuABgnEGenuUOMK5xOXv7OIkW4S6v9mGoEmaQAbBm6ahYXBvTWnvzZXg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MHllQb3NMD5tB+pyvQeE9kP+wIMLt9LpoZzbGA7BEY1Ab5XTN1l7JZ1f4Nwq?=
 =?us-ascii?Q?fzgAarMUwuTMDOoNRNr+sRViB+d6P4hy20tFHCm+7DBP0d7zIlQQfBFRgNGZ?=
 =?us-ascii?Q?iaJSfeAYhqNPEQE4GHdNwNyIZyjqKe+TKhLMqroNJj/C4LB3dgjo7sKMvKzL?=
 =?us-ascii?Q?i5io8m5ZWL+oEvn+ZAJ73RWQHPuHIExqBsBXlPC8/zEyV3aCAWWdMDrcjk57?=
 =?us-ascii?Q?lutdjhroph9X454xu9AduPj5sWibcyMlautxRrfGY2sMkNByZMsXylxxi5tL?=
 =?us-ascii?Q?MZs4nrMmD8ks06sCakMhpeqVzhGOdwaVO6YGAidGFrYedeKsXQydTYlkkrRS?=
 =?us-ascii?Q?nCB11kmXDCStO5AehhOZZKId50BmxvQtTP88SmBlIM57V/iKBPJf7vvTHpw6?=
 =?us-ascii?Q?JPy8fx7taucpY/q2gm+I1sPJG5P6OLg2tANQZwgnunt2SyzjJBxri4geiwdl?=
 =?us-ascii?Q?6AyeSwFEdBr4W51RpeKFpi4xO6BZ/qYtV250FFk90+a39ALCJ7m91K38NEYP?=
 =?us-ascii?Q?zyStkciCXgosl3EqjPe0NsKaGQV9W/TJCoy3S6zRfZnGr2Z6aCFnwwMD68EH?=
 =?us-ascii?Q?SU8Lb8mtsPT5aVZmyofxGZP0YQArfqAqvYkGJ15yhuLIu4IPm3oJuC5WrkUG?=
 =?us-ascii?Q?CbDx7wYq/yWzOYH6DXES8ErzKFlI/TwsOHb/bCl/2/U7mPBdKqmSKmATiBTv?=
 =?us-ascii?Q?KJONezWthvRP1bskd5ombiP9qS4Ea7VIv8Gfgk6fmzW0rGr52f9S+fDpLez3?=
 =?us-ascii?Q?qzbYf2MQBrVIA+J/NR66WjuPApjAQYN+QFtaVw4QepLTsvPFkkHqRx2Dbf3p?=
 =?us-ascii?Q?0mUzHVloxZphydUUNtxDb7y3yzreobwR2m1ur6aSGm0K/hyhKcTVMMeu0alp?=
 =?us-ascii?Q?l24x6fPeFfQKophI0WcxZqOr1leknltPW9s3oi3ROiUVRtm2e0yvx96zjWUA?=
 =?us-ascii?Q?2DXldvl7UrQL9SYIlcyrj8HvUl1f9qc4dEhk/SgQYUnmoKcbclgxurTyAtda?=
 =?us-ascii?Q?jxd14HtlsJXErJIAIWdFbh94Wz9QWYtUaMPMVLVLRqHdIrdXeHddN56sQAFD?=
 =?us-ascii?Q?79yL8S2ETXrfv29UAQYGZd2m7wxIUF1CnbdPxxLkGkDSvkT/Iy/IJin1UasV?=
 =?us-ascii?Q?PbOEWTfQY/hLLK8sa5Z0cUVtD1i0OxITZvCMgwVksERp6bQ/3XLPlx7Sm8kZ?=
 =?us-ascii?Q?Gb1lS6hZhorBz9SUH8SU525yqSgjKEMDodBondku4CXbDL50Hnv1lWvVzdkE?=
 =?us-ascii?Q?FGr/Tt0GYK0j3fmtiM+sSLhYFg3Tz1HyBREekA0yX5FMn+4rbjtaJBI00bvc?=
 =?us-ascii?Q?f6gC1fTyhWW0nBK16Cc9avGIEE9JlKdFMP084BtVELsyt6luASpRL61ydlym?=
 =?us-ascii?Q?DqGFEhIjb5hqYmCVD9Bq0T438t+EWjGuueYIL6o3dGFI4G7539pbTq1j5hfj?=
 =?us-ascii?Q?0SPurUvw6ZFvxaaVVGnwf+SZG+u5BzIn9V+Rz2YHcSX6NAKRBt4FUONr0hOL?=
 =?us-ascii?Q?5SrfaoPt6DEgAeFg4RohgSLpxc5MaWZQJiqZf5le2RPqSYBxNDNCrDK7zrFp?=
 =?us-ascii?Q?ye6BMyNvdmjLZNmT0AXiYYDm8GuRUBD17GeTNJc6yGCo2eiQ78NcYmf57Z1V?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rpwGO3gOW9BdKOCXJy1BeUGlui2kBc/Imz/vjkvugnL63rOqInUCRM3Jd7yVZALxTLNoV1+j1V382mpr9BMLtKJ8T/9K1/wzI4zBYoMGoqO2jBBDT/nEHB8LWcGPwiXLQfKiNYEcb/F19HN3U23vtmMXj4RjInhO4GyP9TMT23JlsYn/Tl1ggBoh05WnQ/lLOjY+apeJQoFaMALiZryNTEjKCinZ1BJKKs9cjLKjXXdf8bcPUNCypMIIxkAaKXfJyhSLQU/H3yAmJS8738H2wbvqBqCa8A1MDgxQ9Abw3OV+mXT7xI5P/Dh06CoHGue5qQ3T1cNI8JCi7jQouUCsgtpfWRFjyZ3J4+FEAeEJwCYjJDZSuggzRt2c5Oj/Ht5bNNYReki18Ggq3g/bfGsS/MCRtdDe1XeBanHeM0mtiMQbgVcCBl062PRz7R1d22rGiqjfpp6evwrB/GVQXZ8cx/emNYBI6wmfujU/vDt8Jl2lzRNqhQKEAVZO+Qdsn9GrlrJTLM3XOkmyr+CQ+Nw0NGSIDMJlvu/eX0o+ce2JaqFbYiQBayHCtNVnMXuBuC8xFgOT5w+cVmbm9WXgGnUqXpukr7L/MQw/mVZ1zehFooM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896c5ce4-2ade-4370-07c6-08dbfb02d05c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:30.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLTEaG1EjqJzFcSOpZvqpW0A2/YvBNUGb61B7JYYtSWCCAHqVhM8hg7p+aEZFSnwtcWZ0yq0NnmEBaGFvUCAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: TFyAdV_s6EB-i5GP0BZjTJUJfCGOr5Pu
X-Proofpoint-GUID: TFyAdV_s6EB-i5GP0BZjTJUJfCGOr5Pu

Also update block layer request queue sysfs properties.

See sbc4r22 section 6.6.4 - Block limits VPD page.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/sd.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/sd.h |  8 ++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 542a4bbb21bc..fa857a08341f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -916,6 +916,65 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	return scsi_alloc_sgtables(cmd);
 }
 
+static void sd_config_atomic(struct scsi_disk *sdkp)
+{
+	unsigned int logical_block_size = sdkp->device->sector_size,
+		physical_block_size_sectors, max_atomic, unit_min, unit_max;
+	struct request_queue *q = sdkp->disk->queue;
+
+	if ((!sdkp->max_atomic && !sdkp->max_atomic_with_boundary) ||
+	    sdkp->protection_type == T10_PI_TYPE2_PROTECTION)
+		return;
+
+	physical_block_size_sectors = sdkp->physical_block_size /
+					sdkp->device->sector_size;
+
+	unit_min = rounddown_pow_of_two(sdkp->atomic_granularity ?
+					sdkp->atomic_granularity :
+					physical_block_size_sectors);
+
+	/*
+	 * Only use atomic boundary when we have the odd scenario of
+	 * sdkp->max_atomic == 0, which the spec does permit.
+	 */
+	if (sdkp->max_atomic) {
+		max_atomic = sdkp->max_atomic;
+		unit_max = rounddown_pow_of_two(sdkp->max_atomic);
+		sdkp->use_atomic_write_boundary = 0;
+	} else {
+		max_atomic = sdkp->max_atomic_with_boundary;
+		unit_max = rounddown_pow_of_two(sdkp->max_atomic_boundary);
+		sdkp->use_atomic_write_boundary = 1;
+	}
+
+	/*
+	 * Ensure compliance with granularity and alignment. For now, keep it
+	 * simple and just don't support atomic writes for values mismatched
+	 * with max_{boundary}atomic, physical block size, and
+	 * atomic_granularity itself.
+	 *
+	 * We're really being distrustful by checking unit_max also...
+	 */
+	if (sdkp->atomic_granularity > 1) {
+		if (unit_min > 1 && unit_min % sdkp->atomic_granularity)
+			return;
+		if (unit_max > 1 && unit_max % sdkp->atomic_granularity)
+			return;
+	}
+
+	if (sdkp->atomic_alignment > 1) {
+		if (unit_min > 1 && unit_min % sdkp->atomic_alignment)
+			return;
+		if (unit_max > 1 && unit_max % sdkp->atomic_alignment)
+			return;
+	}
+
+	blk_queue_atomic_write_max_bytes(q, max_atomic * logical_block_size);
+	blk_queue_atomic_write_unit_min_sectors(q, unit_min);
+	blk_queue_atomic_write_unit_max_sectors(q, unit_max);
+	blk_queue_atomic_write_boundary_bytes(q, 0);
+}
+
 static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 		bool unmap)
 {
@@ -3071,7 +3130,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
 		if (!sdkp->lbpme)
-			goto out;
+			goto read_atomics;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
 		desc_count = get_unaligned_be32(&vpd->data[24]);
@@ -3102,6 +3161,14 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			else
 				sd_config_discard(sdkp, SD_LBP_DISABLE);
 		}
+read_atomics:
+		sdkp->max_atomic = get_unaligned_be32(&vpd->data[44]);
+		sdkp->atomic_alignment = get_unaligned_be32(&vpd->data[48]);
+		sdkp->atomic_granularity = get_unaligned_be32(&vpd->data[52]);
+		sdkp->max_atomic_with_boundary = get_unaligned_be32(&vpd->data[56]);
+		sdkp->max_atomic_boundary = get_unaligned_be32(&vpd->data[60]);
+
+		sd_config_atomic(sdkp);
 	}
 
  out:
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..990188a56b51 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -121,6 +121,13 @@ struct scsi_disk {
 	u32		max_unmap_blocks;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
+
+	u32		max_atomic;
+	u32		atomic_alignment;
+	u32		atomic_granularity;
+	u32		max_atomic_with_boundary;
+	u32		max_atomic_boundary;
+
 	u32		index;
 	unsigned int	physical_block_size;
 	unsigned int	max_medium_access_timeouts;
@@ -151,6 +158,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
+	unsigned	use_atomic_write_boundary : 1;
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
-- 
2.35.3


