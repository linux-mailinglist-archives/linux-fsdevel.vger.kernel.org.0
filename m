Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6077B3040
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjI2KaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjI2K3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:29:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197A2CCB;
        Fri, 29 Sep 2023 03:29:05 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK90H9009532;
        Fri, 29 Sep 2023 10:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=krqal+86NnUIkwkCtgxlVFAeJivw0zNnHUoY2Q+7HrA=;
 b=TjsDokSPEK3Zey2aMfguC1oYvgnMv6KUGRcSVYKs5sLGwoKl+ttL0btuCHBr7yPCkQuB
 1cXr+tk9C7BFfHX7WYjCmzQBcXyimTxS5/Ix/cAKaSWBnE/4T/R0b8lNF2YW0+wuUrap
 5iNTR9W9fqSFTxN0ouoBqBnaKKaLSrAgmwSMwiwmWNj9FTMagnAiBc2g1DvIgCcjHe4K
 7ZZyk1w/2W6426jCjjhia4SZ6zPHeZ31mb9oYTfT5KTXyh7H548XWk3iOOA7vLYw9fRo
 GEkELbf68TokTYLSi6tOUShyJO+3zQ0hWg+GfrvJ0Kav1CrRwGsaW2X2qjXBq1t7CkRj gA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dpjkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOM015821;
        Fri, 29 Sep 2023 10:28:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhQ4+Z/IXerOKJuTXD76qYeB75V4wYa0/i9bwVuL/Ex+D1eiwzMBS643eL7RP7BShM9YrYDCeX2xW3dUKQOYT5pD0e4NNkaDuIDUjmP9ndV11xocX2pDVXaJ6c0MpJlDNezR0x3jQkdLu91hFbKkj21kOJ4DmNTYrNbD0ol8E1aWRiV98zKvVcPGvaHo7ZNhrdX4j3x+TpPtrdFt44fRtR72m1Qhw0SLg4OJLGSi/I+xe8LVj422UW1KNoSzOsOCrykGSiwUVC/VhcwJJET0loZOzMfZ22kkuwML40poslPLEcig3E3wSVTMYACIIuVaSFlQnYVQf4G2c3agZKSioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krqal+86NnUIkwkCtgxlVFAeJivw0zNnHUoY2Q+7HrA=;
 b=PAWr8K/iafdcegaEJGWm3IzbUGl63FyUM9n8j6ubivFhUu/byC2IlGwyf5XdRGo6zqOohSjDEAHHXtQvL+Ckt9DiLoaIdTQrdqKPwhI2dJE05fZ6cw0tGnr8+zEbJJJvb+t/sNY62IY9Y4Z6hYSsJh192q829oHSueb62ufhPaFyAU4gs02qCVz9aWbLcb0e3XCXVtHV82a+01bpdHG4IJwznDSGKMOnsrIr64kYBqq1FRCHcCAZJEF0UYrPT1xovqu8ALUuagIHP+JECTPekQ7MKkxJiWOL5u2RmK3uFF+5u1e3PlRooR91c4fWqBw5Ip2w3YAsBocehUQnG3Y2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krqal+86NnUIkwkCtgxlVFAeJivw0zNnHUoY2Q+7HrA=;
 b=OmMhnr7vUWs8dhKLjWG718q1EdQOqOCkapAI9DI3BQ8gkCnnjezcSvb5RlfhbVX9xoELr2aAiCcKbV0VsaRhcW16XrxTEpgSGZV0mS9lxWXuusoi1HRmEmtJTIQhmLsSTr/L+cgwMUkTQ7jP9Bvsr/olrHEdAqWt9OBQ1dGq+3o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:35 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 18/21] scsi: sd: Support reading atomic properties from block limits VPD
Date:   Fri, 29 Sep 2023 10:27:23 +0000
Message-Id: <20230929102726.2985188-19-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:208:32f::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b42816-48d6-45cf-44fd-08dbc0d6d634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqY69rwdWXoJ9gEgNp8v/5Ndpuf3uA9cG8D/5XLbWa+Oa90CtA3KSnw3J/ryaxE1f87GjBAr3sGwt68BEvfRDint67fxgqM8g9iGSCNgWZqgqZWQWQVZL7aOieBG/ffBJgvm7jhpkSz50giMNhC0MrA9xVmALoXlfyeDpXrAB6KnIw148zpE3V6Wc+5K4gjNBcAtgsY+t/lxdQWvCj9zNXKVGLYU4Q8hk37Z/v+w2V3akQXCNspBhQdZJcXjmLU7ELfxojjvJLdjEdg5jV+36Yy9JE4OkIn9WRnlERLXteDy6JRY0MihWIffrMGLMXivlKQB8TXtRMdoVqaWSq8hNObt1Qw52OiMtN6yhtVRknORp2EQ7oClrJz1nAaN3eGSQraiEYm+2XJG5aM4shf0C9Mocgj/1kIXwTs9+QbMIgDEJR2KvbDYbFdZzOFbS4bhpbvZ0D7jqysmNvyWS2VUcNnS/NIk9qYTFhGWsPbPF0nrKAIYouOaRodnz9VVRTvi10KQSO0QXUdubQLcBsm2GdqQNp6gr8jz7aJUnqDRATyfYNdPmeAOmnZv6ayvGsx1VdHOEiPumlkgNVP3g0UiTLCekeVLS7U+p5oaGnk4Mh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4uIl2yHs4MA5QIT0uoB2kD3KosVmG0vQ6Gq6OXbyBcHNSmKSgJRCkSdItGV/?=
 =?us-ascii?Q?HlHRFIMvMQqSYhf4oRfUFPiW8WZld0bFhTOLpt8PPLsuFXcf8vieCa3uCctd?=
 =?us-ascii?Q?50KRQZUuDAkamywqrwlecSCSGYFxFpZQFLWbGSU2hXRCApuXrPvqb+X4rOHU?=
 =?us-ascii?Q?gMqeB1EbHWAgeqXItYQ6t0c92BDZJzdr34ixIVqA3kEHxNAI0ivu+04Ii5g6?=
 =?us-ascii?Q?HSA5i1wmVmYAVL/kzJE5IKP5uHoEeFLyFm9JURK2JgqeojQrR2e+krpCZw9Y?=
 =?us-ascii?Q?gYPq872Y9gK+cig7H0XnFXxNt5bviVyQ3weh6hyPMc2RR8jIv5ec34bgBdmo?=
 =?us-ascii?Q?f0Motp1KiBh0ZGxDCN3zEofZQB1Hw9lpJLqFCpn6kRjWJ1EuG7qI9h8Cokfw?=
 =?us-ascii?Q?iYnOpeQPIuTpST/yQQmhhvEe3AggbWwnoj2/RlMO/ljUBBE5z0d662T6Dtrv?=
 =?us-ascii?Q?l1ZBFRGTDP8GnEk4njrCD2qoXZ010gDJSpSArWybOq2tJtsJEPwERFrKAmfn?=
 =?us-ascii?Q?uOBxUczM1LtZRTZN48mvyvfTcBIwwe6vuEPDN2Mhdc1Ujp9qUZBecju+nFlo?=
 =?us-ascii?Q?mEq5i8g6DhYd/iuyEIgHVO7xphZk4lxsP8iJxUxzRtgTgMLPU5qMehA3qun2?=
 =?us-ascii?Q?Vn/SWvYgkikMFzORWV089wNisFl3OWSgn8PhjYnbVE+sBN4UD6YWpJvLHRgU?=
 =?us-ascii?Q?OFoxglXHsr4XUvj6Zwb90HVOESt+rCOzeatq58eLmVXl1h6v3ICQAwxbx3mk?=
 =?us-ascii?Q?Lwv2rMZjkueXBzBNN7mFKWRL6Fw/bVBKj/xZxaD/34BW96BqxY1UhiBytTjX?=
 =?us-ascii?Q?nxkGJTxl7qCBe+tkiJO2nCdxoh1K1XPsmVuiuXQ0Q7G5zqeiFIw0E12GjKY3?=
 =?us-ascii?Q?28t9AOr48S+zKmowisESO2NfXgKkSOtt4u4taegxSwDxh2+icBxKL3tsv+QQ?=
 =?us-ascii?Q?PEmmX6dn7dHKhkhMJ8AEu2bBlCWI5UH8Z1LSO6NwENAw8urTI93rMF0noqD8?=
 =?us-ascii?Q?hBUmgkH2vsz5G9DMzPhbQHUa7kywF5eMusf7WxNhndC+JXUklDz0UgK++zB7?=
 =?us-ascii?Q?uvtdBqQVVy8enkm9JLdVMyNBYGNp4uOYgzClD3bYuwGz3rjyQATcM35au2oE?=
 =?us-ascii?Q?WRNK7rZ/DYTo8b4OihbDSE6fzpLv0/bWHIkgXWs1oBOaRHmBiBmDBf+6cvJO?=
 =?us-ascii?Q?BKqIYE4CvoeBLg1QJnjeec2bHeNm3A+bUoiDKrCz5hu1akj+iBOWVwSRJQTl?=
 =?us-ascii?Q?qtvMGDyk0qg1TIIjP6KgnyEfyMANuP9oogqmBXQXEo5Eds6e+r8082fR59EJ?=
 =?us-ascii?Q?EBmasRkzmrvX2HtahO+YSEgpEc6Nqfhh4Qg8nKmMs9P/s7Y8HwykbBq8irVm?=
 =?us-ascii?Q?t/qcTMlwpt3qyfPT+F0XO9BuGJA4EzhuqiQlG85sVe62dx/5puYJqG6Lap+A?=
 =?us-ascii?Q?XwCMtSDi0p39xQDtBZrzhxadTbJA2kH1Mn/PS6eh+0dpx+y4QOcAHw17AWwH?=
 =?us-ascii?Q?gpwj7hTflp6DKKJcWkJ6nkghFP0J1qS8Lauxx2U2mYWbfeCw4kj1Mzw31nj2?=
 =?us-ascii?Q?RR0T6lesxVEzwekgt6NzEACEIj/LJhbCcjm/dDIJwGksjXIN4qeZb8ZdP40L?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5PHVw5f9bz0iXIq3+lOsLc2PWqZ8wW/4llpGlWtdx1suBBjRHluFNeGuei7S?=
 =?us-ascii?Q?TLV6qz0NYQi2nHGkq3idyeffO1RR0sSKv4dZEU7TlW2KyMyP7lXsCZjnWbnG?=
 =?us-ascii?Q?QHxyGcE2Ttf+x52BsgayFgyxwk86GZbA+eerpzFCIk+vesDv3cfDyogW1aH1?=
 =?us-ascii?Q?x8a+5RqBPZ4FWvzhiAANys3Tb1d/pMeF53wi1GlZpaxJCYvXvhsWggG3VoZC?=
 =?us-ascii?Q?GZT6SFGWuwJxToTPhEASX7cAwGbCvsnQ/Ml5dgN+x1b6Z773M5SZYKM9738j?=
 =?us-ascii?Q?pb8vWs2krWfbi71dm/8FF4tLAmpDJ0FDT/DypqXPzcQEXk3n5kYDbH+tRQoN?=
 =?us-ascii?Q?/RaeNrXPfT7YxXUXNyrhWznKCSHRX+kiY7sBPA3gNOXT44kyKAzjizITqrwy?=
 =?us-ascii?Q?b7TESxcYAA7qxhCFFweCHxF3EFLHMTcaTBzMxFKfXlB5+H68dLpm3FE1wPES?=
 =?us-ascii?Q?wOcQp/nFxOF8ES0Y53vAf+2PcBwAwhCRiGC48ugoKreVHLVBps2jeQJA6fpe?=
 =?us-ascii?Q?7cO6a/USueD+ugWvHQKz75LbA2//nHM++y6tQARP8Zg69cQWRtamzAopTx9Y?=
 =?us-ascii?Q?vQf1a5IXVRJ/tFRDJ44vfqFMdfEGlqv7jijNwPHdMFOvQEQYPpkRdlNm9ZLm?=
 =?us-ascii?Q?De8pG5gP87SCt/J//9/WUGA2Dg3+wb4DL7ZqXmw5bGA9tsxaDXKh3ReT/SPD?=
 =?us-ascii?Q?xTMGp2UpDHd7xvmNs728QDkDKgXhNlZEQglH+5Z6q5D6fXptWeFsO+7iRk8y?=
 =?us-ascii?Q?eBJfSeqvMTfxEyPHQ+UchkaZPouZ3sCvS3o1VBpRJJIVe3GGzj3EYcH+K3Yn?=
 =?us-ascii?Q?gtbU6T47d2qo8VLuWInb4YZzGfdzMz+BDzopLOEmSeziTnAAps7Y8FGuOa4E?=
 =?us-ascii?Q?VeNlgwdL0JWb9jU1urL+MlRu5/ZeXNbOYAEZFKujzHEaAvtYDGX2XuZxRlSo?=
 =?us-ascii?Q?t0KZyD4apLbJP4ClKaOsUZ0mVJ2HbU8wR9ryuRWUFTOLxvvTHfK1cgWdP5ye?=
 =?us-ascii?Q?JaxtALaGwgJdmMUUCReb29RxNplpbAV/x+nyoT8/8HWCrq/JVBuOS4dz8jlT?=
 =?us-ascii?Q?IYehUlRriQUYSDXv+8ZMgZpW/wUROQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b42816-48d6-45cf-44fd-08dbc0d6d634
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:35.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw46ov8IGNuGOxpO50sHZcTwL0+Eka6j+0WUJSRob4gOM0nUvxz7LN+iAZ+PM1nYAz+kp+LdU+8bdEQSsG7A2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-GUID: lK41I0H_UzrvAAdqCgf0SJ8kO4SZFEdZ
X-Proofpoint-ORIG-GUID: lK41I0H_UzrvAAdqCgf0SJ8kO4SZFEdZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also update block layer request queue sysfs properties.

See sbc4r22 section 6.6.4 - Block limits VPD page.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/sd.c | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/scsi/sd.h |  7 +++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c92a317ba547..7f6cadd1f8f3 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -837,6 +837,33 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	return scsi_alloc_sgtables(cmd);
 }
 
+static void sd_config_atomic(struct scsi_disk *sdkp)
+{
+	unsigned int logical_block_size = sdkp->device->sector_size;
+	struct request_queue *q = sdkp->disk->queue;
+
+	if (sdkp->max_atomic) {
+		unsigned int physical_block_size_sectors =
+			sdkp->physical_block_size / sdkp->device->sector_size;
+		unsigned int max_atomic = max_t(unsigned int,
+			rounddown_pow_of_two(sdkp->max_atomic),
+			rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
+		unsigned int unit_min = sdkp->atomic_granularity ?
+			rounddown_pow_of_two(sdkp->atomic_granularity) :
+			physical_block_size_sectors;
+		unsigned int unit_max = max_atomic;
+
+		if (sdkp->max_atomic_boundary)
+			unit_max = min_t(unsigned int, unit_max,
+				rounddown_pow_of_two(sdkp->max_atomic_boundary));
+
+		blk_queue_atomic_write_max_bytes(q, max_atomic * logical_block_size);
+		blk_queue_atomic_write_unit_min_sectors(q, unit_min);
+		blk_queue_atomic_write_unit_max_sectors(q, unit_max);
+		blk_queue_atomic_write_boundary_bytes(q, 0);
+	}
+}
+
 static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 		bool unmap)
 {
@@ -2982,7 +3009,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
 		if (!sdkp->lbpme)
-			goto out;
+			goto read_atomics;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
 		desc_count = get_unaligned_be32(&vpd->data[24]);
@@ -3013,6 +3040,14 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			else
 				sd_config_discard(sdkp, SD_LBP_DISABLE);
 		}
+read_atomics:
+		sdkp->max_atomic = get_unaligned_be32(&vpd->data[44]);
+		sdkp->atomic_alignment  = get_unaligned_be32(&vpd->data[48]);
+		sdkp->atomic_granularity  = get_unaligned_be32(&vpd->data[52]);
+		sdkp->max_atomic_with_boundary  = get_unaligned_be32(&vpd->data[56]);
+		sdkp->max_atomic_boundary = get_unaligned_be32(&vpd->data[60]);
+
+		sd_config_atomic(sdkp);
 	}
 
  out:
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..bca05fbd74df 100644
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
-- 
2.31.1

