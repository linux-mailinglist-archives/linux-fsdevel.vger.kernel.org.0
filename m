Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589C50C50C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiDVXSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiDVXQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:16:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B51942FF;
        Fri, 22 Apr 2022 15:46:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MIYhRW019753;
        Fri, 22 Apr 2022 22:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KgEw+0HVjksrzULZki0AbI/A03vuojycw3zI4n7x6/4=;
 b=JHMW8pRQQUYlu2Obqgj2b2Xg3NgifKVWgwoS8FR5G442TkQGdvbZikWdIekJN9DbjWLy
 SsPnXjsMRLUPIHymIR/UJ5wK8X1y7Zjvoux0dPsj8R7S5TImudo48H4LbCG1mMS/Y7AE
 V98DOc4dBt7jmrritTDLOcE9jb6uOyGOPlQgntwiGbBWt64OSgKD1JpIe0sJ8SxAJRg6
 8OFHC04YKgMlyzH6u4EPFmWd8uVbtDFGIJQ1u71qPiEGbeW5D1rf5uqwj34g0pF0x/u6
 l/a7ajqtCSNDOxByWROd9kwxSTRRWcJMjYuKqgxlimFlKcajvMGf0q6tGBmk6MmCcBVR cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1fx92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MMeovn007264;
        Fri, 22 Apr 2022 22:46:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fk3awf5sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6irOy5f/Oi2ikKOTHvqcfARM5kmfnCMN0rV7V+ychThVel27Xjd3FvgiaRIjXF8mHky2Boybp3Zeh2uh2XzZiqFKsUqTXfOIAwXaGjATUjswx25KewlDU5sxGFxd5fSGEyC5c4LXps0YQms/dn02feQZ1bEn2TLMBbHxf6bt8F9MKUwGdvx/0uKUZLb4x569VpyRt84uKy9OYwzNWgZTo6d6SmV/kq7f+OlofMpt39wL9ZkfMsBv1dVvcjRUS4KsdsnzEICNKuGOex/YJbwbRhNSQ8UaqVtuw+oHui/TIePIJxM2SZ/OMMcxpqgIWXG/cE8IE5vzYgfCN6F91R9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgEw+0HVjksrzULZki0AbI/A03vuojycw3zI4n7x6/4=;
 b=AfBnRd8hzgafEOcdBT9qII6mmwadTapm1MMDMIdg4zhtvFMu25gJ5cdW9HF5px3TqXU3RZanDd0jGJnFNfxISI15LBpJlKS8cnWEVMEZSPafcJo9VT/SEEy3GPZawmkiFqJWy3UEPEiadaUftdNsyBafWrjBvAThdqEQ/e648eLWgAumAoRURtHRcJh3oYa1di4D3nBMsstGeZgzRprXIYyeD353w+rRQLtdZOupDjx0NgVwiCxg4ex9qGy6dE/QVFVnn5Sfz6L2Cx+SgpP/Jms6T0M97Ac+Ia2+lcYPpJinwW5W4oViVStGUaXGLdph1awPfncO1M633oj6f0KrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgEw+0HVjksrzULZki0AbI/A03vuojycw3zI4n7x6/4=;
 b=vd5TnFL22Mi0AZCS3mY+z2MdjJKN6mEPZYTUrBS++5pjClOUEHs0n5Az3M468nFOl/GOFFkya6Dqxh8Lv1q7LjI4IFjmCm7hv5qAs56Fk1cdfbjyrx6Z520JKV8rAgLljP7pxe50LKAlR1QHHimGtLr3ioMNU5D3ue29ntJEfGs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:46:11 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:46:11 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v9 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
Date:   Fri, 22 Apr 2022 16:45:05 -0600
Message-Id: <20220422224508.440670-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220422224508.440670-1-jane.chu@oracle.com>
References: <20220422224508.440670-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b6010d-abe5-4e8d-0673-08da24b1e645
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550F5F5ADA9E62FEBB4487FF3F79@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M94V3gNL2iescFr8lokSDHrzUJOung8HjMMp4QWlm9H9crLv2KuTOBgPFlCq7QMhTt1UKNcJyO8P4Ww/3KZI6ikPdzC4/gjGXLGkh8frYwUOpBz+io17FIh2lcsUFvGcEInsrbyt3S0zdnBQWcQZDjUzUMtDZZtSG5h4RZ/wxztzPNLWZK9ewD+ZD9tI31/uc2WSJBnyQw7QltyACCc6nZkEXcVeL7S0HnHMiBaprWQgIWL84aiZgdkiM7RJIRvvqdAu9nYjvkAas4wCF38/XxI0IB0wtYlro4UF6P1LwMDEK8V9r4C2l6UetOdpRJ171QdU6GePXG3QRP9beWt3+nfmRkVg4rmc+d1xzWxmFnyefGKNEiX9i50PY7zfyGpOUlTRAWMt7peeR7tLIfXwjXnRK+P2xwEXEopscM3Cli9k7Qw4TCwYCPk/Xi/GHiQULwI5KCNR4klAEkGYJUNy1PNpup1uE58IfCpoku1xOpWwSlYZSGn04AAmG4rUYfw0YlRQX7KR7MyQI1VeDonDSjeZl1b4BdTxBJOv79Pvua5QnRCDOWn5yKQRRMw1IOeIVZ08zjp4rvzFvgFujsv/TCULhNLgLQjsDzHw9CHmdSg3rQ9j4bFIoY6JG6GXirQqxLwftN8aCiGIV4JGaI9InjXNaVtkgjExh0LbSVQ7xQ9TzZ1Ng19ecJLr7z/saFVt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6486002)(8936002)(508600001)(52116002)(83380400001)(36756003)(316002)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(38100700002)(2616005)(86362001)(5660300002)(30864003)(44832011)(186003)(6512007)(1076003)(7416002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u7X3gEZNfk9YdGvgoL74bnv7XosT6gQgzmc5jGBbjwUJvO37rI+JBGLAupwT?=
 =?us-ascii?Q?Yl9K6pQN6JEc+t49Z/lhfb0r3MrVaOnvb/l2dOdiGSqkO6GMm+iOaUkZMeMR?=
 =?us-ascii?Q?JP8D9+SWRL1BL60uvdH56wD2d3hGBgF0UOfNzO0IW6gS0Fdhiq3QvlAbZWeg?=
 =?us-ascii?Q?tZ4foYmaey6udJ3iRF8d+m2TkDNyYM+6Ue6l/lysBOtdLIp0+4eNB9q4M4fJ?=
 =?us-ascii?Q?rrfX8ZQFLvCVqMCq5uexTL2GQx0Rls1EO/WWmz9UZtNOhw5sTGTOE1xtsxpl?=
 =?us-ascii?Q?nYGBeliCx+xsf9yL+mlAi0xya0Pj46wSBcnpdmQcOx63eATAf0Ap1wL5A3eQ?=
 =?us-ascii?Q?CseP8/Zj6hyHLYARKHv2jePBALcYJp8TI7LtND/c5FIuX1nY0/l3uTYzPYCW?=
 =?us-ascii?Q?2XhXHabvV9Un6uBB7l9PS+jxk0x/DRo5SfAeI7aWR8UPuDKWZNNevrLm6uVe?=
 =?us-ascii?Q?rWm5445U+yWt9b2L7Nn9agBuWU41F+O6Yz2UHjLbG5b/UMOGG13mpJDjWtE/?=
 =?us-ascii?Q?2+RnAq3Oh7YruDM4j2jpGZUmqlwgYaiRx4JehbcEWdjs4n/t+r8jMZuBaIAF?=
 =?us-ascii?Q?SGTlEbqfEY/Kzyp1fLS+lncAvqPxFUaAmY67/rXwKjcEtgJPOTdiD8+wYm5F?=
 =?us-ascii?Q?DYIeldKt4siCyHzKNCg/yDTYQylzjFi97IaRq3/5YTD5fWNKcCGBYYToIJZ9?=
 =?us-ascii?Q?B36aI+S1epxPydELxR13+gDvXAcAEYHErrVDUeRSh5/9Z/zc6XcY7/2C1gSz?=
 =?us-ascii?Q?wTw78thRYA7mIXQkNCe3nt9xeU2+aef8Z9ag01J0ei3+MkxnuUJ0XpSbuLuU?=
 =?us-ascii?Q?l40AT/fKOHe0wS4hKwSGgmT0ApTueocwE1YGugEfXXwCa8PBupL7iKvh0mEg?=
 =?us-ascii?Q?7oOEDIji6oQqh6/CtocWPGi+pm2FMgOD515pRQ7BEK6fsAsbcDQPsuzwJ52q?=
 =?us-ascii?Q?QbgAMrQ3ALYM/FasW4S71pOUWDR76Go8nX1rjYjZQEcGLuKbm1/Zy+OwoDj+?=
 =?us-ascii?Q?6RcUREFsiLJz7cG091LWKu+AVA+I2AMlL+D7hsdi7X0QOoCbDk0k2j7DMlgE?=
 =?us-ascii?Q?g+giYIhOAxWXomSH1ePYaVj+akUw6iq7CXKx3Akc6YXTanurBSRoFDyjWdQ+?=
 =?us-ascii?Q?CX3gJcmshI26/vPGJue/jOMQFv975io2Vrx1GkQv21WjWoUt6ofDO+May7sP?=
 =?us-ascii?Q?k2ah0g0ME0/78IjF4xyujL5ntdkBNShvMMqzvYwr4H2V2L/7kuWrAqmNiRQ2?=
 =?us-ascii?Q?fFEsxU8hfw3homx0ROfLenNpNM6Ecn9JgZMQzYfsPnpUXz2te0lKJYTFryxB?=
 =?us-ascii?Q?VxLJ74480qgkkVX/+FeFXS1CHOaSWFxbxz+3+whV3+qtYit9ADnUPtsl6zlb?=
 =?us-ascii?Q?r5uzL6FKnz73/VQOs8FqSN+KNVu5V6zoh4HpVFeeGLc9fisCgpJo400ibbJ2?=
 =?us-ascii?Q?oNYl1UnJPR7lF574Z8y4+dlfgiCHtWzIgEWONqhaJrC5Eb70ryUnbYlbwKDs?=
 =?us-ascii?Q?jpJPjun0ttn+WDFzSmvyL6UiO3kta0K1iVfQHz2Fnzpdl0iWgcoFh2cDNzUY?=
 =?us-ascii?Q?eHUk0Fy5MzBNSMMNddputYxTANW0p6pcUSM53j6DE8UrU1g8argFsPXfPbqT?=
 =?us-ascii?Q?VY9CkP8/dSOv5MwFYbLnk6Pjt3Fp9Xrbfz2gUwr/SZSHA0uHDRr18XoHfcdG?=
 =?us-ascii?Q?mi+dWB3QfsWmHmnz3u6u0M1bDU2Ua6CEOccdYbvWikGR1ne0p/SKXdBYar3Q?=
 =?us-ascii?Q?VhJx8WU6lY4TD84geyjsDQFxQbFHoQ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b6010d-abe5-4e8d-0673-08da24b1e645
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:46:11.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRxzdE8Qjetb9e3SiCpKotSQkfbn7CJN0a6w7eu3GjKCHssUsPpSDictK5YJo81eCkVAtjtSlVUjD4YbjNGqWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_07:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220095
X-Proofpoint-ORIG-GUID: dfRJQj5Op81y4lX6p8x7wGY5IhQEyAlt
X-Proofpoint-GUID: dfRJQj5Op81y4lX6p8x7wGY5IhQEyAlt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Up till now, dax_direct_access() is used implicitly for normal
access, but for the purpose of recovery write, dax range with
poison is requested.  To make the interface clear, introduce
	enum dax_access_mode {
		DAX_ACCESS,
		DAX_RECOVERY_WRITE,
	}
where DAX_ACCESS is used for normal dax access, and
DAX_RECOVERY_WRITE is used for dax recovery write.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c             | 5 +++--
 drivers/md/dm-linear.c          | 5 +++--
 drivers/md/dm-log-writes.c      | 5 +++--
 drivers/md/dm-stripe.c          | 5 +++--
 drivers/md/dm-target.c          | 4 +++-
 drivers/md/dm-writecache.c      | 7 ++++---
 drivers/md/dm.c                 | 5 +++--
 drivers/nvdimm/pmem.c           | 8 +++++---
 drivers/nvdimm/pmem.h           | 5 ++++-
 drivers/s390/block/dcssblk.c    | 9 ++++++---
 fs/dax.c                        | 9 +++++----
 fs/fuse/dax.c                   | 4 ++--
 include/linux/dax.h             | 9 +++++++--
 include/linux/device-mapper.h   | 4 +++-
 tools/testing/nvdimm/pmem-dax.c | 3 ++-
 15 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0211e6f7b47a..5405eb553430 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -117,6 +117,7 @@ enum dax_device_flags {
  * @dax_dev: a dax_device instance representing the logical memory range
  * @pgoff: offset in pages from the start of the device to translate
  * @nr_pages: number of consecutive pages caller can handle relative to @pfn
+ * @mode: indicator on normal access or recovery write
  * @kaddr: output parameter that returns a virtual address mapping of pfn
  * @pfn: output parameter that returns an absolute pfn translation of @pgoff
  *
@@ -124,7 +125,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn)
+		enum dax_access_mode mode, void **kaddr, pfn_t *pfn)
 {
 	long avail;
 
@@ -138,7 +139,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 		return -EINVAL;
 
 	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
-			kaddr, pfn);
+			mode, kaddr, pfn);
 	if (!avail)
 		return -ERANGE;
 	return min(avail, nr_pages);
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 76b486e4d2be..13e263299c9c 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -172,11 +172,12 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
 static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index c9d036d6bb2e..06bdbed65eb1 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -889,11 +889,12 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 }
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-					 long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
 static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index c81d331d1afe..77d72900e997 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -315,11 +315,12 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 64dd0b34fcf4..8cd5184e62f0 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/bio.h>
+#include <linux/dax.h>
 
 #define DM_MSG_PREFIX "target"
 
@@ -142,7 +143,8 @@ static void io_err_release_clone_rq(struct request *clone,
 }
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5630b470ba42..d74c5a7a0ab4 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -286,7 +286,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 
 	id = dax_read_lock();
 
-	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
+	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, DAX_ACCESS,
+			&wc->memory_map, &pfn);
 	if (da < 0) {
 		wc->memory_map = NULL;
 		r = da;
@@ -308,8 +309,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		i = 0;
 		do {
 			long daa;
-			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
-						NULL, &pfn);
+			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i,
+					p - i, DAX_ACCESS, NULL, &pfn);
 			if (daa <= 0) {
 				r = daa ? daa : -EINVAL;
 				goto err3;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3c5fad7c4ee6..8258676a352f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1093,7 +1093,8 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 }
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-				 long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -1111,7 +1112,7 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (len < 1)
 		goto out;
 	nr_pages = min(len, nr_pages);
-	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
+	ret = ti->type->direct_access(ti, pgoff, nr_pages, mode, kaddr, pfn);
 
  out:
 	dm_put_live_table(md, srcu_idx);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4aa17132a557..47f34c50f944 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -239,7 +239,8 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
@@ -278,11 +279,12 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
-		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
+		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
+		void **kaddr, pfn_t *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
-	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
+	return __pmem_direct_access(pmem, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
 static const struct dax_operations pmem_dax_ops = {
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 1f51a2361429..392b0b38acb9 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -8,6 +8,8 @@
 #include <linux/pfn_t.h>
 #include <linux/fs.h>
 
+enum dax_access_mode;
+
 /* this definition is in it's own header for tools/testing/nvdimm to consume */
 struct pmem_device {
 	/* One contiguous memory region per device */
@@ -28,7 +30,8 @@ struct pmem_device {
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index d614843caf6c..8d0d0eaa3059 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -32,7 +32,8 @@ static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -50,7 +51,8 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
 	long rc;
 	void *kaddr;
 
-	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS,
+			&kaddr, NULL);
 	if (rc < 0)
 		return rc;
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
@@ -927,7 +929,8 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/fs/dax.c b/fs/dax.c
index 67a08a32fccb..ef3103107104 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -721,7 +721,8 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
 	int id;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
+	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, DAX_ACCESS,
+				&kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1013,7 +1014,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+				   DAX_ACCESS, NULL, pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
@@ -1122,7 +1123,7 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
 	void *kaddr;
 	long ret;
 
-	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	ret = dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
 	if (ret > 0) {
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
@@ -1247,7 +1248,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		}
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-				&kaddr, NULL);
+				DAX_ACCESS, &kaddr, NULL);
 		if (map_len < 0) {
 			ret = map_len;
 			break;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d7d3a7f06862..10eb50cbf398 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1241,8 +1241,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
 
 	id = dax_read_lock();
-	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
-				     NULL);
+	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size),
+			DAX_ACCESS, NULL, NULL);
 	dax_read_unlock(id);
 	if (nr_pages < 0) {
 		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..3f1339bce3c0 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -14,6 +14,11 @@ struct iomap_ops;
 struct iomap_iter;
 struct iomap;
 
+enum dax_access_mode {
+	DAX_ACCESS,
+	DAX_RECOVERY_WRITE,
+};
+
 struct dax_operations {
 	/*
 	 * direct_access: translate a device-relative
@@ -21,7 +26,7 @@ struct dax_operations {
 	 * number of pages available for DAX at that pfn.
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			void **, pfn_t *);
+			enum dax_access_mode, void **, pfn_t *);
 	/*
 	 * Validate whether this device is usable as an fsdax backing
 	 * device.
@@ -178,7 +183,7 @@ static inline void dax_read_unlock(int id)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn);
+		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index c2a3758c4aaa..acdedda0d12b 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -20,6 +20,7 @@ struct dm_table;
 struct dm_report_zones_args;
 struct mapped_device;
 struct bio_vec;
+enum dax_access_mode;
 
 /*
  * Type of table, mapped_device's mempool and request_queue
@@ -146,7 +147,8 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  * >= 0 : the number of bytes accessible at the address
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, enum dax_access_mode node, void **kaddr,
+		pfn_t *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index af19c85558e7..dcc328eba811 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -8,7 +8,8 @@
 #include <nd.h>
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, enum dax_access_mode mode, void **kaddr,
+		pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-- 
2.18.4

