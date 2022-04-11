Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DD4FC1DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348480AbiDKQKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbiDKQKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0511B792;
        Mon, 11 Apr 2022 09:08:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFDfCB018418;
        Mon, 11 Apr 2022 16:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=8P178QoyGPQDMPSg8arws/itBJ406wm7iSMh17Tern8=;
 b=l+HL3Qg1M5NZs6chg9BN8TWSIryllhRAFBXgRz6B1Ivy8Ny/2sCSbVhNex67Y9MVVTQu
 Jli9cYf8wzPRxUGKJsvvtKEtUawT1KTmc7/XBnXH4lC7uvoh6VrrniJf1KN6gtGhe7g5
 +S/IEl/dpC/pPJWPaNZDWo6lmWcEMaNUHBZ+FlLUV/jvo1pL3Bfit2LaIHIylmjT+OE0
 MqJjFYjgspM67tSxElsNRh+B38b1AeYZOkjC3vMT35XdPoMvkJ8W5yrEwVDElaWBSetH
 wuo7ClXkcNLlZfj4jZ7/kFK5BQT7NrAXHW1nHFBfMwFOrakzOpUnjiCLMWwE7zVeBa1j EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1c6r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1Lew006155;
        Mon, 11 Apr 2022 16:07:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1uvhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WORFC8O+xgDsjx/XBgAtO11S5rj0aHdyoFwqMRQmrrOunY87CIFo7LC8zq0zIEYs/SYESNCECpAj7uvxi7BGOZlGFQZdQhfogBrepjK9hBEKO2k0PG5UR5e4sAycz09tAcVqFz/aGLfovqUkatt5RFIcxwzhJ73CVfknS4DMmAUyH5B1ar/SmoA1xpgEi4+XRi9tU2cmSfOmjlFcMsYh2ttL9Huv37E1LXiFmy1s5osuO4G1rxkqzPd92Pu6TUzLgZpF4e2GT/ui+E1tY/gE3MKR09ZIjyxNo9Bza2hyk9t9y35oh2/Xmj4leAEfuH5rBhegLuhgpaD9ltTAqrfLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P178QoyGPQDMPSg8arws/itBJ406wm7iSMh17Tern8=;
 b=WBOEkgymXx+7Wy3ncP5CBy1r21P2tP+FQrLc1lk3cimQZiCjmx0jLQBa0KVa59eOsq/Wrdc1SfCO8T/kami5/kABDGVmysUejvXXIXClByAsOAH0vrVKwhiLr9N3LBmGx2yYq6ghNgGXGoqUH0VG47tAn8Z1bPHelnXc6Ac6JI3bLhxoQY1m/5EpjQ9Yteu4D08D8jVmindw9ZyIj87aL24ybXbz4VOwbbPQBqJ1O7uiItj4Jcv7IJLj0T+9mQRyB/gi/OGYkJQ0Ax3edP8Z26fR5ginVzK2S1h0H2HVrIhCjEz/RctYv2CJE2CY2nqUifIBTJRommTKR613SWH0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P178QoyGPQDMPSg8arws/itBJ406wm7iSMh17Tern8=;
 b=dgcsg5oayF4lwY6mLcMJu0psgpavFnkC4ELa6pB2h2YAobps62slyFsVMtQZfyyx2xXIi1fG12sPmOIOy/gfkn0m0fN3NjtwZ41BXfQKdFJWfZigM/buwpg/f/dPIgL5WBsZ20cUeY/4duVBB2BFtEptM3/M5ujam8O6jy+L5Ec=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:05 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:05 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v1 06/14] mm/mshare: Check for mounted filesystem
Date:   Mon, 11 Apr 2022 10:05:50 -0600
Message-Id: <652c19b08f7cc510f70b48bfc9d522ca6fe74fad.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a94e878-f19c-4d3e-df90-08da1bd55246
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4564EA80AECFFACF0EBE331A86EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYCizQyNVBoPC3G4IK16YPYIy9iGswkh70usTjQSMEdNB816Q06FVEDD9CxGMXsfJJoVN6gRm32ZzBvTykXMG947LokNPJv3qR4beadWjI8+2dhuBFy9VLvq2kbX/qc65MTZbMl8sHxHZx3h+opq9ImfaCCW9HywQtRgDkUnjOKv547HJ7uiU8AeUXIMrhbW/rLLv7QDYHWxqr15yp7k8Lxqr2PONpRU8xDoIKFynxjDcSFeM/aEoffiVjVpWXQBfLF7Hh1xSmJzG4pfuwgsQwElugV2+aNLn87WhpXbVo7gKtvcI9ejbAbAaeXqLMwa7JuqvFGE/R90sjVVq1DaJh/VzHOrK3KuPr11UJ30HiffmGfZXxKG3Ek2GrQUFktdDmMWbL/OVpcccdUffFPVbpzKpukFvp463S0OE9BglHI1DtXnHbXxXewvXSHvTnjhh5GnLCtLCZxPn67I0kWjxN9OF+OxFy5iphCesdauIf7KAC0QDf65d+s6X+gXRdf7dBc09vXdZgad/SVh6gQpLDgmYUc50vl+JAzU9Xebye3QHVeu8zyOXG/JmzrumHOxzAjZnv7+17E1PlZaVTul/8JZTteNEsacxuaq/qu9s0P/neWK9n/CTorxA50pJlDKMtMKjeCahYF9a6YCUTSIzSRbuW6YaqfQfiuM4JTo9fB1XZIjSl1MB76uYcgXoUEfFstIjBEjr1Q6XigNPDIy9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(4744005)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GsgJFkIrnFGULmI4JYJGCdqCIbyCD7KF8oBV9r2YNHGzNL1TJF2LsF2T7GVX?=
 =?us-ascii?Q?dnOKHAe2ubQo48RLh4k+dJoKRCmK7XRg4uGwfxZENWDVyaTk6EoiPeqQZ96x?=
 =?us-ascii?Q?ygUO9b02hJ8Wo3SgZENH78ag9UZQgFWPFbQWhLiW+r+aLvUy3Zq2s13TJxhz?=
 =?us-ascii?Q?zAwS8Q/LJnoz3n72Z6Vk+YyzPlQA3GodW7R9nUutFIZRvuSogJ9hAPUEkuQ+?=
 =?us-ascii?Q?b3eSRFziKNwDeR2y6jSjfcFcdktrDCCiGCN4p6v3nwuGoCsX6hnB2yEFNyB5?=
 =?us-ascii?Q?U+O8AoFfAZBVIvcy/d5TJpIQN2CYu0OlEQD/qjy7ktZ/BAt69qJw0/WPJm7/?=
 =?us-ascii?Q?zZf+6dgjXG03RwHvCcAT/ZltpNsPJ3CufJQrLa3qn66midE9YV4xXD/1D2Wk?=
 =?us-ascii?Q?yLDqMQslXOfD/1/Kkwcv3NmFGZIpZItfKnkH/LifM/xouAgOG0bfKgaAHqd5?=
 =?us-ascii?Q?LyY8x0/j790a/pAkr0cE5oW9QXiz2809HBYyZAp3D9jPjZI5tMfFgADaAgGT?=
 =?us-ascii?Q?dM6Yml/7G6vo/oKQq4Cltxk0g0VSQL+thfGsgzFecPjX8miEosJBalnGE3tR?=
 =?us-ascii?Q?8uOaeTq0+H8OAMRTARlWxwfLAxZ7DydfX0oWizlagVfCPDZ7IG+ccztAMPWG?=
 =?us-ascii?Q?mWGIdaGa4AjTo3PMkZbmIg53Pd0h9mFw4Z7ZVtnaxyB+8+DGtRkYD21w78Sg?=
 =?us-ascii?Q?IpHLnyIC+g/hGHQ0cTJUhKUXAkLQFuVESeNcsIpkLrGtEIkTOJLuiOBDK7Lu?=
 =?us-ascii?Q?Ew1KAaahbjFpu6UIVo2GK1He3qD61Nke32/ZH79C02vbiWEz8ETo2cTowYPN?=
 =?us-ascii?Q?tYurrVy6n7yctgfpn+P9wvdEb+N5QmOFS95NDaoZjbtQBDAah5YJlihzzrDM?=
 =?us-ascii?Q?o5RR+xHl39LBCl/peuFpBR9a2u8+twEqg0dvktbnDbyXqwxqeZOXU/BDnIh4?=
 =?us-ascii?Q?0AiFsveAxaPaLVenUq+F/IXw94cc9oejFNSdmMtay/ZFNMoLs33w2fMXFrrj?=
 =?us-ascii?Q?uUkpiDNFUBWgvufBrStoLfTtLJg8wCAvWBC6EBSzRpwGHDl8kt9T8LD/8N8X?=
 =?us-ascii?Q?2pjYUvX7O3LMKJU6yErHfAhf5dykGkaWaZ2fBMBryXyB+fCw/K6mstSykjms?=
 =?us-ascii?Q?+v4wUNXF0Ey7F6WpO6LboeyPo6ssnO/T1dx3DIswf+aCKcs+mRNhUN/Yenes?=
 =?us-ascii?Q?lcumFiiFtCevwWaMcU9PKJG75MqRsau5EtHMxAck2dVo5RzQhBftr/+5VjrE?=
 =?us-ascii?Q?yclPe3UiBoWOJ9GCe3o3onKh4wEKhIekXYGZ33t6aRKnCVPKTTP554/OoPr8?=
 =?us-ascii?Q?PAsy4k8IdaRvV+YloV4L9C+pBnTYbi7Pyq0skPK5zwci6gdQSjOoIiF49s0m?=
 =?us-ascii?Q?p9SL/MPw+NrmpDmcS0ePHx+xAxZVI8Ah7knlkgQgDsREYKRcK3fLrm/v0Ai8?=
 =?us-ascii?Q?H36bBucIG380vqPr4FzarIzM74/l5JnKA/7uoq64o2Ji+7ydjBPvq+ilbYJE?=
 =?us-ascii?Q?dR5XE+ZBwziRx2bvRav3ZJr58Djng0yrJiIavanY0/5d+cJZcWl4hP5I4jZd?=
 =?us-ascii?Q?OioABi2oGfAUWbcncYKm0EuUW8/0RTL/KEkagujp37co6o2lqacWwBkune5g?=
 =?us-ascii?Q?3tN4Go2nhGwGPbddMA/SBg2PRcIeK6ANslORywArR1KrvUn+A2D7gfexVcWq?=
 =?us-ascii?Q?oFILWnNSS59Ni3CuQLsHiEHgphVXbFxSSV7yDx/8+SEc8e3ZyCHkUZk3lOIG?=
 =?us-ascii?Q?dmoSBsrDeg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a94e878-f19c-4d3e-df90-08da1bd55246
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:05.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvtDlOx3bSPgTVJC32OR2UEQDDpeH5iKJHcYPz2V87oQlUVGW81SlZfWAd0mrtgRh7VBYAuIHmyucDXcp+BhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=895 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-GUID: tFRCoNMVrDviBIWRJoprmPPzkO7X8M3F
X-Proofpoint-ORIG-GUID: tFRCoNMVrDviBIWRJoprmPPzkO7X8M3F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check if msharefs is mounted before performing any msharefs
operations to avoid inadvertent NULL pointer dereferences.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index 85ccb7f02f33..cd2f7ad24d9d 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -176,6 +176,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	struct qstr namestr;
 	int err = PTR_ERR(fname);
 
+	/*
+	 * Is msharefs mounted? TODO: If not mounted, return error
+	 * or automount?
+	 */
+	if (msharefs_sb == NULL)
+		return -ENOENT;
+
 	/*
 	 * Address range being shared must be aligned to pgdir
 	 * boundary and its size must be a multiple of pgdir size
@@ -260,6 +267,9 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 	struct mshare_data *info;
 	struct qstr namestr;
 
+	if (msharefs_sb == NULL)
+		return -ENOENT;
+
 	if (IS_ERR(fname))
 		goto err_out;
 
-- 
2.32.0

