Return-Path: <linux-fsdevel+bounces-5673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACA80EA03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8911C20C29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA215D4AA;
	Tue, 12 Dec 2023 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FSe5TA3N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jpxFIn96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A2D43;
	Tue, 12 Dec 2023 03:12:10 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7i7xM008317;
	Tue, 12 Dec 2023 11:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=918OzZyIf2lHbcyEav2kilhstKVFTBfs6SW4lfJSiq4=;
 b=FSe5TA3Nmi6IKX002RUmFPnt+O36RusDH0q2iMh5pN94Ln3obF8SIhz3gEkcDE/OmSE/
 4BxGmp5Lk6C1UwUDT1FcmOk4o9QROgCRq15Cz/2z2nTjA31UlImNdikZveSRLtAE3PRB
 K0g0NJbcRhlsYbP5yeWrcBLf5Nunr2vZCHEMeNnwVP89xW3wFZzBJ+KQ70o/nzGO5fUk
 GWESXwkzEVhcRqRizMJT6nlFluPjQeKNFqHZmAXcTCAXKNIsCRanOPWm7JsGiJK4Gyh4
 vdMluk+FYoUTIvLyhsf67OHmZDherXgyLByTiqjK8Pju/FMXcfJoUxNDjO2UHvUj9AkD WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c5bkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwAk8008220;
	Tue, 12 Dec 2023 11:09:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cwks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpwW2ySTSfKTnbKP/B7yBj942dKx9hQjAx7grQR5QrUCE7XlVpO9VRTg6XaELXO/zpFgk/PZIgIywtWxuAEAYCtVM2PxNWCZ8dpS1BI9gwzBL3QcdgwaY1JknnSGLGG+zazeQjCAdi+6Ulg/AFnZDEBTd1yNKZYyJGNFcYFJLu6Bo4+q+oNXlLi+YkIRmKeIGlXj9KSLGeEmT2kS82kVOnIuijrUfPHJ36ClBFnQIisinqq+5JtzfhbFOJPOBO9tWKdtq+g7GDHWd/2BP29J+TFdtLFWDtASPSG1JsMxWj1FSaBwsi4p48MFxwqKlQ9mCP+BrT8zY8vga3IQQTC5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=918OzZyIf2lHbcyEav2kilhstKVFTBfs6SW4lfJSiq4=;
 b=LO4JhgCT4RiuksPb+5EzwFJYfNAY96Nc4cnZs+4xGpzm4vBNN267lIfdWhK/YGM1iz0aqEQZRg4pjq9SUEK119tn5PMkNEOEl/J+cQbiOPHjVs2K1ARmy/+3TOrIxkWlWUbkaafBOE20eA9dEXn9klmVEatTba8+QjVyv7/2T89YfCrGcWM1bWpvH5VkEU+lS2W/dmcHgTP3zWQyOGAS71wHDxAxT/dmSDwykI0YIGhQQ05xdNbTX2gJr2ZDnbqV6xGXghHvmUVCBi2U8hJPThC9/G+BbfzCms8USQGEHz5lrPHGjaTXw2iaTAXmh9ds/rZgSepi2xiZAfdWolI4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=918OzZyIf2lHbcyEav2kilhstKVFTBfs6SW4lfJSiq4=;
 b=jpxFIn96YvV4ANKFOpxbuIfOfFEx+83IZ4I/IALG05c4ZaVeDyyeEf+lLC6HFx/g732U7JNp+DF4SI/0PhExcy+IncFWVNEZ8Ac1RFB8GbnT0ZaQmpHWd495s/5fnAGHxFgfIJXf0UTd33qkEIOJXoiviLEUcW9dpXRd2tf9mSQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:28 +0000
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
Subject: [PATCH v2 11/16] block: Add fops atomic write support
Date: Tue, 12 Dec 2023 11:08:39 +0000
Message-Id: <20231212110844.19698-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: efa23dcb-72cc-41ed-87f7-08dbfb02cede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QXWURaFRHntAPTBV2PF1+hkirL4hM5N7lUH3K8uQjcQpFPUY10HgVNTeWK+glL6qKrS5tJMTU0XyyCT9bbkpBMq8h+wGdAJpILkms9IEOxhZHJ63xWN81zwNObzvu3lcoxuaKwamYWiXLThmKTVjL66OL/eDPCvfnaXtbJTXVe9OPw7nOdREwmt6FjaT0AAAQzL1UqQnzMEoL8SXalV5bTmYx6Ty+lbBYeBOrayAZQqtSH/FUIo8OrIxwX8ensf25EcXkS6d7hkvE8+okbehJzdHAIaSERQGO+RICwu6P9crzvXa3jT2Jw/M6npBfaCFATNNbdp57xq+RDCiZb0r+tQ6ZgCxlAeQoyyvDXQIAmVYWdtC7sVntUvlpQt8rqv8QiEI/ZCA1BMcX4MaQdcOphkbY2sv2DBGaLbqIn7DzQLgmOo0x4EgEdRP9djjKMe63PEFIEf7Vw/A90IYjEH2gyEhbCjFinwYE5M3yekZGoVnO9wnV4CEhTZpB2+dxqEmvIBiGtl0oaO8YvbMxSNYiupsc+Knp2yQ1C/Yl9TIBVJLTQBR3/1Eg+9nBZs9b5QYyXixBSnY1Q9jUbSBaNXy9Qth4M46bJkTZT0jxYAl2Oc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nocAZu8PuRVhC8JIMO/WR8shiu3zjDMaZpXqHS9Rhe3y1Ivg+IyQouRs/sKg?=
 =?us-ascii?Q?DAiDRFKwuw+Sf2Xwx7aNg8kIqxpk/AOfYdkLFDdiaipDsrt67HSBnS1V4fh6?=
 =?us-ascii?Q?fyu+C14G3ehYWy6IJALr/iYr4ROpQ/K2igdM1dUpS4+EqE6oNrKpEnfjGYRn?=
 =?us-ascii?Q?+2XjPS56Xjr8aluwilEw6wRH0sVMZiufsqw6R6xTQ+nRy924d4cEk6JTiL/m?=
 =?us-ascii?Q?8KVsJyPVZo/YWKDCxzppsG+LEceUH5VYnrO6TnPtARwMBfPv0hhPpQFtmv1M?=
 =?us-ascii?Q?T5FQKwqg2T2oPJU77fy7Q7tWbTk1nQYLdWUYzkcaleFm3m7ilVOK3FRcyPJ7?=
 =?us-ascii?Q?FYRSWCUJ0ryNUh9kYAEH2Sx5piiiNehPcUNgk3ZIXdZ14qECLO3+bz4yyhgW?=
 =?us-ascii?Q?0UnyeaOGAEG38Mhft+y8zkedJxIiiBrs9MA+QYqLHaP9fy1rvd5/OVPTXtgp?=
 =?us-ascii?Q?N2jLKl0/+7z2Pd1YMvQxYrG2XU3Rqr/xAiA1ZrykcbAz7z2k4SFaEXe2NXAJ?=
 =?us-ascii?Q?3V9W80lXRW9BWvSHDdHPzeTQ2bxOvq7rszABi3nhwdiKQ//u8J86ZP0Fh85j?=
 =?us-ascii?Q?pj/Zs0ww4CU+UX9M3C7BODLbUibdBdNQZAcfgsoUX75aFuX9W2CG/0pJnsFR?=
 =?us-ascii?Q?mzSb47yeL94LdIj7cx925og6UT5H74y6hMzIR16+GRbq69BeeB2WHLk9V7mN?=
 =?us-ascii?Q?6Huiaf/WUF3k12AiErrgaH/pOfU85rF9iB6s288PQBYIf95P7YBYqQIbcYOh?=
 =?us-ascii?Q?tuqawo90ksHQJxFxuWZOm0g5kPbHhZjrtx34+mBQvujfpjTTmIKKG/7KxIcI?=
 =?us-ascii?Q?lGhFQgxd+vXhaWK8KOEXsk6YDJ03v430edpin+XyYkVwnhvp8CfCeWZ5LSTZ?=
 =?us-ascii?Q?T+lFo/ES6OycwmYxBkrDC55pepq25t4m5U2nsXWRL43u3p8WuJq5oUStDslU?=
 =?us-ascii?Q?f9fsaJkrNaW1GDGYr044ygxFNjc2zx2ZEPgskI0XbhK1q/AakhmXjxKg0M8t?=
 =?us-ascii?Q?CQ3fSIWbK8lF4AE9PVN86HSrR3StGK2MG05sf5Vnc6AWXlXHYPpQgRVE1F8d?=
 =?us-ascii?Q?RicWJR5yThOi7iLs0JZotlBeq1D2pC6mAKT2Ctb/y/NRy5MlKaSvi7tQ6Qf3?=
 =?us-ascii?Q?GauFQOH37K9DkHQ3h9VzNE6NzZfrTT4RsuvMUqDNiEuhBPbqkcfZ2o2b6Ojx?=
 =?us-ascii?Q?GMriNs8p53QPQ7nCFFjiXQZ+LLQGnJ1QEYpEtAOeWiOAo7or+1tkDaRxG9x0?=
 =?us-ascii?Q?3isetP1UvKb3+3CjW+TZmEdXIMsVl6zuZGCVW+E+UUWavokq/iUHPEN1BK7E?=
 =?us-ascii?Q?Z/K5BdN5P9ZDDp8zTtB74N+XMSNja4+uVtyfsNp8hZqaVc+zhnZzq0/eWH1F?=
 =?us-ascii?Q?xcVaq7nmkPh9bsSlVDmHrWGblKy4eeRVcOib1ARjzEKsLYE/P/cGeEqYUaJ4?=
 =?us-ascii?Q?ZHEi1I8uHfLlPOyEJ1I2sVm8IxSVHC9q3eOTri8DF3+KD3HVhJopmqu+GoZJ?=
 =?us-ascii?Q?8o9cWxVpI6Tu0oo50w59fazFk6W93CbmCGdXOfDXxSks+ThTvdH4lxLAjsLL?=
 =?us-ascii?Q?cNee0Dhg8gvE8VVGGGCSFVEpoKcTtHPV96cXtdsEGE2CNwd49YQAAZSnzBXr?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	87vdRZZ7izbyVbKCniqagp2ZcFTY/jWCiDN9FzlBQ4VBwvz2jFgnR6iYyQN1B73lQnPwdayoH27GTAiIUDAd+PD9bWhmF+Y4BDoX8ZXRYCEXjCVVSTrSTRbsRY9klsCuUONDJU5P24MH2AaaN9yHApEiwrYiZBm8BEaO5ZKHcIKP73eObKS5ct4L1X9nDUdisBX+MqiXQLyewRLQrfiBgQsda0/VqfXAZthuyG//zwjHLrmIpEcD9tG4zz4lbZsVjS52tviDgoDqyu8Mj4TJYQNBvQLoBG6FXQMDgkwiLbK9H+ki5g0ztnA46UnnI7kBKh+3hsSyuw4ukr9IOpVE537dM1KLI/J7SqHbkRdPk/65n/X6Sy3XjhorbaMZwiKt2inxX81fHiXXVIt9AqWOrf9gst/uhcve0MiWeHR3El71fEP8acTesxFvkx6dm7YhxTSfqLLjKzWvDDwpKBIzCMnUnzq5185SDHcNCEceBtILheYEC1oioauzBOg2BF5M8LvNA3TURJBLwhL+cyWNETUIQal6RhLrwzWLJwieMTBa0xfVWLiqlQGxcUrxHFT8Wxg0tawHsWYrKaCGZ/CEyvZSiE7KZTZ6H5J48KdXyeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa23dcb-72cc-41ed-87f7-08dbfb02cede
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:28.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RENRQV1NfBtHclKPyjucw9jaDVHAk4AMS5wWl8s//g/7cJPQdoHhiluVd8O2zfAT9yQ3aouiHX7h+FOV1Qgftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: D_VDOgAfLjlKB2oZyoQIbz2wV8LnhhOn
X-Proofpoint-GUID: D_VDOgAfLjlKB2oZyoQIbz2wV8LnhhOn

Add support for atomic writes, as follows:
- Ensure that the IO follows all the atomic writes rules, like must be
  naturally aligned
- Set REQ_ATOMIC

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 0abaac705daf..ba6a2c5a74b1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -41,6 +41,24 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
+static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
+			      struct iov_iter *iter)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int min_bytes = queue_atomic_write_unit_min_bytes(q);
+	unsigned int max_bytes = queue_atomic_write_unit_max_bytes(q);
+
+	if (iov_iter_count(iter) & (min_bytes - 1))
+		return false;
+	if (!is_power_of_2(iov_iter_count(iter)))
+		return false;
+	if (pos & (iov_iter_count(iter) - 1))
+		return false;
+	if (iov_iter_count(iter) > max_bytes)
+		return false;
+	return true;
+}
+
 #define DIO_INLINE_BIO_VECS 4
 
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -48,6 +66,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
@@ -56,6 +76,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
+	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+		return -EINVAL;
+
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
@@ -65,7 +88,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (user_backed_iter(iter))
 			should_dirty = true;
@@ -74,6 +97,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_ioprio = iocb->ki_ioprio;
+	if (atomic_write)
+		bio.bi_opf |= REQ_ATOMIC;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -167,10 +192,14 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
+	if (atomic_write)
+		return -EINVAL;
+
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
@@ -305,6 +334,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	bool is_read = iov_iter_rw(iter) == READ;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
@@ -313,6 +343,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
+	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+		return -EINVAL;
+
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -347,6 +380,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 			bio_set_pages_dirty(bio);
 		}
 	} else {
+		if (atomic_write)
+			bio->bi_opf |= REQ_ATOMIC;
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
@@ -605,6 +640,9 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (bdev_nowait(handle->bdev))
 		filp->f_mode |= FMODE_NOWAIT;
 
+	if (queue_atomic_write_unit_min_bytes(bdev_get_queue(handle->bdev)))
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
 	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	filp->private_data = handle;
-- 
2.35.3


