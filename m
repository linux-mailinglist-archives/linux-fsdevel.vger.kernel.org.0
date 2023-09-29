Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D57B3064
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjI2Kbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjI2KbE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:31:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31A1BE5;
        Fri, 29 Sep 2023 03:30:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK99CD018488;
        Fri, 29 Sep 2023 10:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SZdlAGJgif7bi9hd/N+V+m2dYauG9SN9sLhiG5qfhNw=;
 b=HjHlrVICxJAIQyyhe9qY/cLiwotBonwhRLVeCiiBglAHOxGBwrUrL2X/YJTOkt+P5IY8
 K75HIOslKXEPBrYPUcY1T+R5SHHTZUalty0+E7PlzpVH8P0Ed0IeN17glskjdja7DYaW
 gFUP5Z+z10qkXksuNOPpXjlH+IbbPtLOZQH2hyOADyTxpBgfBrXBJ6D7hYCLi44OKBGu
 Qzc2x072tMOAeOUlfYkKPFcSCEYqjA62oTV4luDugT4IoVBmGJMKRSXqjq5ptR1n8q+b
 5paylTKjn2anlXH1/gy61BPQng3vPgCVCOJNC0PqTCFSfz55wYr+YmIStGXPYcj8qhf1 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xec9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOI015821;
        Fri, 29 Sep 2023 10:28:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ael+ikAYKUZ8JonMsLDSA6nXztazpRxU3bKel35unf0tqs8vX/zEUlP4CohZUadQVgQJYQIpto07H3LYzuNiX5gK4faUhHyj3SovH78vskgDuqX8PRmg2QOggkYHWgiPUOFNgLnNVxF9BHcC0UdFLcoZoOBPQDZOnLhUrgPx5EitMPh81d4La0HV586d1MMu/DxRkS+VLTqpxvVfM1/8VEGDgmu2SAi+xtZCtRlCawxM2sYGIp0wCRPrqj5kfQwdtdzQ3WCdXHcRSAG1OFSJ00nE9wfJr7d1glk9BtB2R+e0EJUZDCSkhQk+F8+fqFcMGEIkLilUxUge8fEMFhoTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZdlAGJgif7bi9hd/N+V+m2dYauG9SN9sLhiG5qfhNw=;
 b=aLFBhlZOb4TVJUtypTdUbeuIVfPnvgzdybX3rdNItM+En4iY2egyzk1HA6/iG2oF+vFEZABjCQdqw4QQ4mDIlV9Nth6KfJnAB+SmtaiudkJ5RiLAdN3wajrzpg/ScYGZxHdmNXmxYyjvDVPrN+2u5LsvFFhNRViJ0OVNZsZVWAUx5HqkAi0pXrbe/XJbKj2mrFMfXXF7ZGkXz1zsASUq241FSSRxr2N0ghlZcGOI3+OEb/gimE/l4N/3u4NWt4BjVPt4yOshsi716xn4TBAslqffcgvpvD3ZHyI1EqOjoeGnEJaUMcv91UHqd3VSf3jWTNIBxC3HlqoJyvnenPOYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZdlAGJgif7bi9hd/N+V+m2dYauG9SN9sLhiG5qfhNw=;
 b=qOXutB/bsE0qOolwc1ACHNVbdS6CH5e6WgLgAzkdOE1YjsqLUXDWToj3q2rtntPaqHXPAPBvQlGhl93fwpPILIbRPOCfKtTTUCJ5kzFU0m2O+0/iEqB2wEeeKRcLDPpNa3sQvZOQgrrb9xZEXWwCWlDGnqpcF5ZP2hlx4tsU6qI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:29 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 14/21] fs: xfs: Enable file data forcealign feature
Date:   Fri, 29 Sep 2023 10:27:19 +0000
Message-Id: <20230929102726.2985188-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:510:e::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e9f45f-a58f-439f-9b20-08dbc0d6d292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /efZYJiTMcqxDJUJiftvrDbEAYpfXxQLBYQQjiZmjlCyrhccsBBQGSVVT+TP5Xaap+tRWniqLlZorv2duFI6QRuaVUc72u9dSUtauL/DzPs5UFvALe653TTLCuANSkgp/VAU0NEj+DaGwhuMJ7prWSrF8tRKvoXsSw79WkipiWNOJIyMxUGXUbQLGpG/OMfkQebua6z42go9s8TxLV7Q6IcVY8dR0dXh+7cbhIztmkV+9bfO/sm8RJArS6BRzdPLyv/d4bOi/tJ19R1Rbe+cj80v1n8RBl736KZT4Ohs7pIGTOKzBeJ7QQXFzP2lDUvV45M6m+GK+tpn9OadPeXCNa37Klx5dhKnH4Ri/YeXvtx0ufidE+R1EdKB+htGmOhMS7QILeKh8vd6AAP76NycWrBsAK6RwICktg9c/kqVujYaavtaT8cokRraLw1DsOPwBi531AzVx/l8AJt0V7CGq91ErnMBYD+PKr1NlPEfWMw9OkGvGz+fJcV7Q2wFr1Mi44JT1cL4zNVkNg3+inm4tdNvR8KSNKgoRESpCQuKcoF9lXnoLQs33TFfgbdjpuaKRy4F4Zl40duAOvZB5+rsY3lz9XruyxfF3A36W6sJBrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(4744005)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0LZCo45SHFvzdAPerTAUj5NKq8ovRMrgIMnAUMnKE0ZJfUEn9jxO+OAphrR?=
 =?us-ascii?Q?d5GvK4GCr9TataGqJbKy1W42GH8ppHkB0Rz+WEou+OlcHMRx7To3ALJXXfzJ?=
 =?us-ascii?Q?QC+qWe/i3v6/+UeaReFRf4dJ6N2ledDa0HjN5DFP3TgXdSvtj4xZyLywwaTe?=
 =?us-ascii?Q?BMr0kEvHTQbaj0vinGJrSHi+Sarh6ew0SQV6JJHwDrL8NLzIqRpj5IfvnDrF?=
 =?us-ascii?Q?fwwl/2La1rwc2Z9o5kh19KvBnynUWbdsFaAGwYh2hKtjXSkcw04x8GwSCNQy?=
 =?us-ascii?Q?ge1fzzgTlh6OpAZ3npPYouPJYJxsweEaH4X2H434dNRi0z7uIm50XnW3e6AR?=
 =?us-ascii?Q?lkLpm/I8RGdFR57O3LZCek1nVSmoQEa2Woi84GbDjF4vvEoUhGz9Q1HowyjR?=
 =?us-ascii?Q?RtCYlAysOJ0qpDeSc1HiQLwqybIXkQ7eOBuuI6qEyGC/jY46MxR0CMC5YIkh?=
 =?us-ascii?Q?SBbIuv8fPP3r5Mtwrj+5UhFZhRCcFz0LE5sB0f0JxTWeAwEXKiZzM4sInmze?=
 =?us-ascii?Q?8P1jo1PcE6X7dDsomNuTReYnEhXsPd2D0wLkInWaAHGoh6HLJFi8/DrlvhjF?=
 =?us-ascii?Q?WwYMKQj0vgnFKLLa3914FHuTuX/lsEuvmfM78sz+/huTjXrNRKO+cJt0kUYX?=
 =?us-ascii?Q?4IO27OACLqX4oBde93LNp2lBZ8NbpYADw4vBMb82806KCmX6VkYnmEc4jWWD?=
 =?us-ascii?Q?V0xB/A0LqJ4RB5Tl4l6MKboMF1KfZZzzjSXtkfnPAmumAYPD1nie/ZFxDt1D?=
 =?us-ascii?Q?7yGIWyxH470pVqyUZepX42zX+UIbC5n0o7AsYv6AYf0QilitZIjJrSw6py2+?=
 =?us-ascii?Q?wFhzPjnFXWQOWxVYT8HQ/vhuq645/cpBih3imYr7DYAA4a2MqodeJywlYm9c?=
 =?us-ascii?Q?6cB0jEyVH7fA72sVxH1RYe1kjKANBN0EsSsfp2J0QvgDoxdHHqo6R3j+uJyJ?=
 =?us-ascii?Q?V5lpMLomwKKLJ1kz69sbz7VYHSjh8nmkV2Va4JsHKt9BFtiuq5yhjVoAZn1g?=
 =?us-ascii?Q?ibX0gjyzNDE3kEm3QPLM4C4Pp6cAtfzyspnCEINKUw+JiGP2Wnv1zd8l85yi?=
 =?us-ascii?Q?qb/G4FSysTg+iog/5j/FUccbUapupAAIIcfZigZpanTdCbS+M/ckcSP4qOcn?=
 =?us-ascii?Q?BgwYo8zL8+Le84W6aNjg80yeO7ogv2ZryXzzA4Tz3lFHhCiqjl+E41ngTyHO?=
 =?us-ascii?Q?kSyaLva/mLSHZUt0LZN4yvrQkcDnuW4Nekl23LUsrRdvY4onpDfOkry5vi4U?=
 =?us-ascii?Q?sMEccJZHyHv7neixLJs8lQSsxN7Rvk7tuxYOrpkEcDxtrn7mAPDRo33pHZX3?=
 =?us-ascii?Q?8Av81bVl1oPQAheiXUj01VGImfvNAZbKy4iugQBUDXSxX7wtcFddZBTQqLZS?=
 =?us-ascii?Q?GO+4Pg7LGjI9/EwQVqSr5862GfkRWDgbns6hIc1zmwZGlgEUEGcGLR+SmB4z?=
 =?us-ascii?Q?Gjoc+bGOrhc+o1J8PbAYGdlYi/EkIWQ5nNfeRMbN/xBdVhE8gACHsfXfY3qj?=
 =?us-ascii?Q?C+hIsmPljmQCGEdD2gVtzaiUL3Q6wfC2v/FXZLbST+Q0CGlOt2ozOi7yqOic?=
 =?us-ascii?Q?chCGDTxRgDL7nZUVNqp2vyiHhQnSd17uc3tfofKkTWy6Nd1FxC883VKW87bx?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jqzfosesHfx6SYe1fBOd+7fsbTJClZ1tacjMDw+mp1F2IFVBIyFtJYUqF3Zv?=
 =?us-ascii?Q?66tQ3iEnD1ESlUt2rVpZ6mnf8BeJclqRl/1Su7BQpBDtwVsPUsCEP7HLyeL6?=
 =?us-ascii?Q?VDmeajIzrB5Oek34j3M8mz/TmbUTrUl74meLdAAkGeYZB25nSf7DVq5rOBQ1?=
 =?us-ascii?Q?O7Q4ukBQHOOTYmWVPBYvWczTKdNgwUqmP8ZV3LeJfX4wX/5w81OaMdtauRg2?=
 =?us-ascii?Q?pdPIVwC9gAZB3Nb5jDJlYxW7YJwRYU8wf7FkZ7tTgbrL9ZaSeYC2vItOS5Jx?=
 =?us-ascii?Q?6937wOaEVzrjA+/KfxAwqkJbn6/7ISQmQEEeQImeR+CN2PnpLzT10CmOLGHP?=
 =?us-ascii?Q?K8+r6uq3TYSL4bsAB+om/VY6euT5Bo7YKPbqfxoLxfFMGlEdCmCmYSYNhR7L?=
 =?us-ascii?Q?ajti8GXV49xkRtQ31i8Peerbshw9t2vCJJr1xhV3/jrWPXpGzQhUjZHzvcq0?=
 =?us-ascii?Q?BWLFoj6eYec/Sl0xNHHt00U3GCYL2XOp7yx2XTTwTp1KKYm7FbqA7P3HLwb7?=
 =?us-ascii?Q?9lrTmqsLycZ9gTfS0jXWkFcG4kt9pWIPMjA0bR17vFqZdnvJGOTwHlSxTWC/?=
 =?us-ascii?Q?HDyUT1xFLmI69kUNURsmSzZrrFK8kyXAPisBCJrPHMhpPUnI2YJVSYBhZTs3?=
 =?us-ascii?Q?pABdsDrP+czrYzYigu5VQMUgpbs7n7jbDiiydh3zRVPct63XKCn6xZ6SDwoR?=
 =?us-ascii?Q?kcOmcWFJk2ehu9+7Pxg4rFggbtse0+hqIl6A+kLUUh373KQItcF6de9GBk3a?=
 =?us-ascii?Q?IW4Yo7/HfCUZ2dTr9sNDg94EcbL7jWYWRLunsu8aBMzWPNDsorEZ6KsoeGi1?=
 =?us-ascii?Q?sMw+qTiaE6/PXDw4gf1bOtC9uF9TEc8/3/NCO+UI47qYFtXapn3oSHCmmzhf?=
 =?us-ascii?Q?/sBbO0u5Ut0sRiI8DU89b8yE5FrOvmns6lA35DBywwdYJ3qfrjwP0HV7uYOM?=
 =?us-ascii?Q?w+gv3hxbOxFzUhgOC+5zVAyYV1ggrInDYPoLqbII1/W6setrdJu/qVx4Znx/?=
 =?us-ascii?Q?IjsIgohLJgA3VKAitXH6nrduy9PDzjm7YSENwLRGdJZEAmEICXdgXCPXD5o9?=
 =?us-ascii?Q?Qtddc+HLDza0vrLx8iDl9dO4+4Dkeg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e9f45f-a58f-439f-9b20-08dbc0d6d292
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:29.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pCSGmxEfVIoe1jYR8frQ5JUo0FSYqxyqNKP6NcMWEjqM1Ux9VDW76rtsu3YEN9HAeiTqD6v4DOrF2W1mJUYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-ORIG-GUID: gUJpXeTPaXHyQL2TAQlCuA2LJp9mx2dj
X-Proofpoint-GUID: gUJpXeTPaXHyQL2TAQlCuA2LJp9mx2dj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index d718b73f48ca..afb843b14074 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -358,7 +358,8 @@ xfs_sb_has_compat_feature(
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.31.1

