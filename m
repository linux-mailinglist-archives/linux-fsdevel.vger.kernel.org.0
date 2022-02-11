Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40E4B1FAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 08:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbiBKHxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 02:53:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiBKHxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:53:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67DBC1;
        Thu, 10 Feb 2022 23:53:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21B6UMxM026345;
        Fri, 11 Feb 2022 07:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=oIAJW//g2ZqHRL56nbP700nwWhdEQ2BDBDKwROqscF8=;
 b=NCX4yI6OMeNAYtIftpPqmVXALHoQDkeNraARiCUGi6y5sfiC9mZHE2pJcCtGOwftnZPx
 FcAy37vW8fIQ/t2Wma5q/a3uefBREZAWvGdyyfVh5TtROgNIEG0K1YPZULPWwsJ+4HFP
 xa9OYt1xNsXvtZP5x1JUvzwFco4zKRsbTO6uR61j9l0TDqNdlV7rbzhr/ytpm/dJ3hd8
 i/TdxWG4SmCI42dqtpBl/Q8HQgafxMjSsqjhSs1NtobeQ3BzrgfNNlrsVhdTo+rMU4OD
 BjXMCiiAXLwmzfDJsI6q9kwsxSeolroX0twe8gjPJsoierXm42ogsdY+JPba2aJzkU5A BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e54ykj0t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 07:53:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21B7aDOZ031582;
        Fri, 11 Feb 2022 07:53:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 3e51runqx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 07:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcix/Qpt38FfZfdnpSi7y9wka5b/McVyY2xnsp9lXEINj2crFp06mBdHFl/zVlmJyL+jxtzyqgkGPlxdrgdVk72Zy9spWOIN9kq04NSbcklylAIPPprm/RWfE+JHRwoHv5ap7zkQBnVw9QJWy3F0e8sFQOzOf+WcfksNY19xIskdtdWaYVTiKjb8yWZoytZ01UpISS07XBYTaI5DR6CzowRtLr0J03Ebgc9HqvmI5A9919K1OAj2YaieU8364bwbevRo8lCYBaPN7rMP3WAURm8nvpfTI/+ZxALBSIbh2sZl9BscICQ7QG0j+dfx3yWJFbGX2Ik55/SH+zJ/cmJZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIAJW//g2ZqHRL56nbP700nwWhdEQ2BDBDKwROqscF8=;
 b=VEYXCqo7e78rOByWCK7KuNI8HCUwAdLyObFufz3Lsvokg0DsqPX8o5WGnKDq8FdW1/EinT156q2Z03UY6vDZWMGQnAkaozX/cR2mldm75U1q7TRPyv3lkDriwcNPKix2iJKcYJzYGzymIeXVt+HrJ5aSxuQBm+AgnwblUl30A956PwiupevsnWRHT6Xpp5rGz24zNP8kIdyDfQK5Autod1mOvp11Y+vUKwXhji7m5sdnV68oPYwboJaMglNggsTNkODbIdzyuK5Wox2s6120cdu/gSLvnTesTpska78Njgrik9glebutaKe+9ylU9vTl73BsEkaabVLsyAMIA45yJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIAJW//g2ZqHRL56nbP700nwWhdEQ2BDBDKwROqscF8=;
 b=ShAR7scnRq/uYUT1ed5otp2Pr4+3ofWbNOtj4z2QQqrq8ePrUM3WsHlsmuYYhEc2Us2ewKAjsgu8QOVtQvwNRWY6BOj+Ss6c0G226fpJR/85wJwTMTzfnfzmlCJ9Q1SxYaett/MO7nW/JbQyUk2X0kcOAldiY/0SgCULYENzUI4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4678.namprd10.prod.outlook.com
 (2603:10b6:510:3b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 07:53:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 07:53:03 +0000
Date:   Fri, 11 Feb 2022 10:52:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Nitesh Shetty <nj.shetty@samsung.com>,
        mpatocka@redhat.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, javier@javigon.com,
        chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com
Subject: Re: [PATCH v2 07/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202202110625.4yHrKaUn-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-8-nj.shetty@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f2d716-6fa1-49a9-bf5c-08d9ed3387e9
X-MS-TrafficTypeDiagnostic: PH0PR10MB4678:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4678B8A6EF3E41B10D4BC98A8E309@PH0PR10MB4678.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jckA214sVkRP4Imgn2X4hw1G0C4aMv3MS09/b6IV7wgrSCucFkrvgwkIs8U67wfwfOHpfYEqINwlaGSsecnfSmo9p4FlG3cnQBZDJ/LKV2RIo5DnPDKB8sLfQKB3XyY+14fDQlIT5PEPjPYtHqhlbO5Gc1Ge0oEhm8Pb1BlzCtJ0BFXmM9LSXcE4wzZGj+WiiqYGCpAhqMfhFPHjGzve/Khy/3VUSl9T3IcFYjQcaoR9/xA7jQf0gIkZLcrORTOwc9CG33IXsDqhPcIJ0+kjuJ5TlQeMDR5c+doBedWAVwc3sVHcT7r2/3Z7QTW7E/rjq8Xwhh5Fcgd6IltFsCcKRoD9MRhqIUEl8u2adVaTZTlJ0Ou9QitHUuK+ncicnmzS59VbZ/6XCrArw0JiK3PIgfmONe3QTU5YIudeI3yCWY2FnjW7QoXGedeWQFWSqsrj2afJiaX4ZvRyRBex+TZ+6jBe5sLHqW9+tvvjUc8KSCmfPNnfCa1kFvYgLgbUQr7/9MJ7tcT0S2gBd/kTq4pgtcdiFngkieCliRbeviaMeP1vetY7ihiA0Lr9n66iFxjSKT8IEOIsntx5T4xqCG0GaLutfAwJ0e8mNVrE+krc5DPu1hnZfR/gUs0KGVvRprgP0tb9Oyeg46G10Ukh2ulzMhbY5s5qZUOCTJ2Rgy9AYkXnnu7gM5zboRx72gt3DMi+jJwgHKasFaRjey8s/hiIYHQ44+hJRb+psgbsXSd+hLal4Dk8XKr3Qr3ZaqOPb3OXUf+Nr0E0427a/jYQvL2N8/HKqUFJiTUtt2t35Gq94CCwV2+G3yk0eDI82zxE0Y8VCOsik3U5LtNXIF9Y/uTBDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7406005)(7416002)(1076003)(5660300002)(83380400001)(44832011)(966005)(6486002)(4326008)(26005)(186003)(36756003)(2906002)(38100700002)(52116002)(6506007)(66476007)(6666004)(8936002)(508600001)(86362001)(66946007)(66556008)(9686003)(6512007)(316002)(38350700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztkRW/iGFrDPjwIzkPnF7gsYVZEcpDWZ/vi//eBsdmY11M0db9VEyyy0hrwv?=
 =?us-ascii?Q?BnxqOW5POcEYQwA2iDzY2MbFklZ4Et9vzSwetOqiGQfpsLmXKetSHxjHCEL4?=
 =?us-ascii?Q?nwfWYngd3yHQ6umxP1DWjg+P9OBUNvqczySgzRKIhXf6A4uLQUUd88cuJsgS?=
 =?us-ascii?Q?EDry8xGcyP9pTaiV7P5mIwpk/GL95rDpE9vluCtLGKH7Ep3YKwNMCfduq6Fv?=
 =?us-ascii?Q?KHpgyyp8t3AxADYuZTKRs5FtnqIJZu0Wz5PnpembehsxgSvtP6e7rDv1IiPZ?=
 =?us-ascii?Q?itulDmPUWEOP7MNvZVuED1Ee9AHiPzgfiWj1u+j/r8XBt4wul0do1XuzN+wR?=
 =?us-ascii?Q?dH6v/oD005t34TazGUi5fz9J8mrByyvEiOv2rvaHkcEUOjt8F//zCCOQ8Nbn?=
 =?us-ascii?Q?wRosGB27AVLiVGWPwrlasexk+wuaBz/SHBX5OD11QHicdvIgOGBb8E5cj3ru?=
 =?us-ascii?Q?iUpD4KbEMicy9RJ1QH3KMQWITULKPJbzQ3OFrvKjMc418nbp2L96b4lzOfv0?=
 =?us-ascii?Q?zoY27HwZeiB3vkndWVeSc+PfHpBqDnx8X0ddOGUq904e1Cy5q5bm5ST1rQ2b?=
 =?us-ascii?Q?OAYwvBd0LfTfnZp3fEXOGLrWoshx2a+p9QW2NncQBkoNO3LT633fFp25e7i1?=
 =?us-ascii?Q?LpmUYDIuqdG+ruXeTPJXqQwh5X2/x8H82lHjpYKJadXOxKGk6ZfUH1QADO/t?=
 =?us-ascii?Q?vrOVu453itlQ5IB+TjjjziHd4owA5Cv9CWZNL2M9A93LtP5XI+SNrYZNa8a5?=
 =?us-ascii?Q?hee2ak7VLGVAJYHLIm4v73VaXuDPFZu6yncmICD666UsUDT96KsaBq/YZz0D?=
 =?us-ascii?Q?3bRY0HLBBW0ds37gP6e1irXv0/eTapkYhgolT0xLrsVmy00GMm1pP96KsqIj?=
 =?us-ascii?Q?4Y1l0PmzVq2pzqU1l9Xj2i9LWr2p90SU2/PsHggrLNb3YcBPPO1AqqjUdVi1?=
 =?us-ascii?Q?nfRbaKsriIGRvf6lHA2q6qSf/IwK8keHS0LWkO4Tx/nDRn10pPzO47kyfdB0?=
 =?us-ascii?Q?Dx6UWcmgHLEKXyxDOAyeQIGq+12Z7V6095FbuMCd1UyGcsC1q6slve8mOfcd?=
 =?us-ascii?Q?w/8xULmXhw1wm98DefiyEVMU+5m8hJfmlYvH6Yj3VmhB3qlGkXi7u8mSWUXz?=
 =?us-ascii?Q?gMhm7AWQ9rPY583xCx5CZ4mW4Jk4iCckrQnR+A4rB7MKkSKlaIsk8kyv2pCH?=
 =?us-ascii?Q?ZezAH2yAEKqrpw/YByVmz/JFTkHL/BjR3s8T+aDi2HDx73AFqp7soaGFv+YV?=
 =?us-ascii?Q?4RcRtRRnTVA21iMXM+5rU0Uh8BUb/NhQm/KY0RGyktx50GHpsUSdS3MFDBqU?=
 =?us-ascii?Q?/wQyRcJVUB35bwS/XDMWuw0Ew+9ZRBBNFO+dO/s0r67xBzN82T1PHeTY8SZ5?=
 =?us-ascii?Q?qf9l/gB4UbM2KwON7FhwA2d0lXF7MQjaCms0TIvuPSPixYCRBVRGMoymh9O1?=
 =?us-ascii?Q?VVhE7IcqRoh0lokfFoWZSKrPP+DXHbLvS59wFzNC1OGfv/P0aXCoTR3wHuFZ?=
 =?us-ascii?Q?V1u6BVwbOsr/zT77ibaKoDT4k9uQh5865XlVMXnkdNRQ7jyUM8SpuvBDryaZ?=
 =?us-ascii?Q?yLy4uwxnNORIyd1ulN6hwuMqKRWlBycJnfXev55s3UWC/ILSX91qIRZGwKBK?=
 =?us-ascii?Q?HEevpkAIoyKEFfr7Afm+N/T1APbW3+ywjOrK3bdPbXEYEni8vSYQRRbZTP+S?=
 =?us-ascii?Q?m1vrag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f2d716-6fa1-49a9-bf5c-08d9ed3387e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:53:03.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y+6q35SjiESwkRF1QQ5GWcyY+LsZOcaltqiBhk0mp0BbZxv0N0Bq+gQa0rwRQPr1qyPQaac5+BlKmnRxZObPCz9oYXjPfhY/+cnNbU3jk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110043
X-Proofpoint-GUID: 97uPyqHBrH6igV0xHRqF695kSRTJa9Uy
X-Proofpoint-ORIG-GUID: 97uPyqHBrH6igV0xHRqF695kSRTJa9Uy
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-m021-20220207 (https://download.01.org/0day-ci/archive/20220211/202202110625.4yHrKaUn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/nvme/target/io-cmd-file.c:377 nvmet_file_copy_work() error: uninitialized symbol 'len'.

vim +/len +377 drivers/nvme/target/io-cmd-file.c

6bb6ea64499e1ac Arnav Dawn         2022-02-07  350  static void nvmet_file_copy_work(struct work_struct *w)
6bb6ea64499e1ac Arnav Dawn         2022-02-07  351  {
6bb6ea64499e1ac Arnav Dawn         2022-02-07  352  	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
6bb6ea64499e1ac Arnav Dawn         2022-02-07  353  	int nr_range;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  354  	loff_t pos;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  355  	struct nvme_command *cmnd = req->cmd;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  356  	int ret = 0, len, src, id;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  357  
6bb6ea64499e1ac Arnav Dawn         2022-02-07  358  	nr_range = cmnd->copy.nr_range + 1;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  359  	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  360  	if (unlikely(pos + req->transfer_len > req->ns->size)) {
6bb6ea64499e1ac Arnav Dawn         2022-02-07  361  		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
6bb6ea64499e1ac Arnav Dawn         2022-02-07  362  		return;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  363  	}
6bb6ea64499e1ac Arnav Dawn         2022-02-07  364  
6bb6ea64499e1ac Arnav Dawn         2022-02-07  365  	for (id = 0 ; id < nr_range; id++) {
6bb6ea64499e1ac Arnav Dawn         2022-02-07  366  		struct nvme_copy_range range;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  367  
6bb6ea64499e1ac Arnav Dawn         2022-02-07  368  		ret = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
6bb6ea64499e1ac Arnav Dawn         2022-02-07  369  					sizeof(range));
6bb6ea64499e1ac Arnav Dawn         2022-02-07  370  		if (ret)
6bb6ea64499e1ac Arnav Dawn         2022-02-07  371  			goto out;
                                                                        ^^^^^^^^

6bb6ea64499e1ac Arnav Dawn         2022-02-07  372  
6bb6ea64499e1ac Arnav Dawn         2022-02-07  373  		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
6bb6ea64499e1ac Arnav Dawn         2022-02-07  374  		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
6bb6ea64499e1ac Arnav Dawn         2022-02-07  375  		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file, pos, len, 0);
6bb6ea64499e1ac Arnav Dawn         2022-02-07  376  out:
6bb6ea64499e1ac Arnav Dawn         2022-02-07 @377  		if (ret != len) {
                                                                           ^^^
"len" is not initialized.

6bb6ea64499e1ac Arnav Dawn         2022-02-07  378  			pos += ret;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  379  			req->cqe->result.u32 = cpu_to_le32(id);
6bb6ea64499e1ac Arnav Dawn         2022-02-07  380  			nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) :
6bb6ea64499e1ac Arnav Dawn         2022-02-07  381  					errno_to_nvme_status(req, -EIO));
6bb6ea64499e1ac Arnav Dawn         2022-02-07  382  			return;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  383  
6bb6ea64499e1ac Arnav Dawn         2022-02-07  384  		} else
6bb6ea64499e1ac Arnav Dawn         2022-02-07  385  			pos += len;
6bb6ea64499e1ac Arnav Dawn         2022-02-07  386  }
6bb6ea64499e1ac Arnav Dawn         2022-02-07  387  	nvmet_req_complete(req, ret);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

