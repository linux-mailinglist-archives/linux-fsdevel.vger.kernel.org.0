Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BB6F5FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjECUOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjECUOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:14:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE579868F;
        Wed,  3 May 2023 13:13:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HoZBw024257;
        Wed, 3 May 2023 18:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OcyJ+a6tyPNcEvP+YkBvZeGoC+dB+2mNvr7EYk6ZqjE=;
 b=TtbE/ZhmEe5xe7QF+dT/hsc72oQxm9FmVwOR2+Rbm/J1xC4OodVzrxveUovf4D/j7px0
 EzBn0uI7FnlUjU3X41gllfV1/7zUpfOfZwkkDmXKgvnXDIxPiM58y66SiZMPOeSS8iRb
 ss5WGCsX3JkZ4A5AKkx1atU4hsSuKFHPrfXJ+4PRewx+9/yWpHJlqfbdYeTSkpoVijdY
 ZZnnTY5vc5NjyIN3+zWT2fC5zrDKGMCw98SDnzXZaJk6glIEBEPSqnXdxLXfeyPwhxjA
 2HoPa1xnAwH2feMe9PEDOz2X2R0RzwMBtOtMsAErXwjbNmRlumartNtzyF75ugLeheho TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1r3pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HKboL027453;
        Wed, 3 May 2023 18:40:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdsjpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzjJtIxBVoEa8kflOW6D5iGkKmK9m8rbZpmJ4Fsf2u+ogmd0GiC5PrwgNIb/nzImYs3nK8cNaEPbkeHXQXyDdflL+wJkDpWgl2MxYh1MZxqlDSTnpVz1jGgt9AlWvzjTvsnSIsPi4NZxCqYeE3QgpZkiiN9Idrzx8bFDHvXYRQ6NvAo4Oi12AKe2YdUUcSLz+e6gVXu8t8jvugtm1Cki7KCSQN3qwlCBFy73rzKk+8VcYyDNqlnmXSLaulMslrOW3OMpB5FCMZ9JDvnN9q1pyHwewpy8wnBRVzjJnCGh9YoYtdM4XLYXa9yHLkDbFiozJy2fL9Nc3ZVF3KvbH7wTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcyJ+a6tyPNcEvP+YkBvZeGoC+dB+2mNvr7EYk6ZqjE=;
 b=fZHoOfFh/BQ20VlxUlEE7FzRD6W90mQtoEjFgD3n9eFzFS8JItodQeQOYH/12SduNa19mifvmpYB+yedCcQfrPiFEsLaTvpFZ/5p+5Vvr13xlWCdZFkMD2VbO3KIQEeN+vu5Al+685cA/0n7q5Ni6Xlk/ET1s7HDPNfzqN8YXlWT6NqmWzPehlCnuy/wLhvSGBmK0wBe3OUsoGWNWI2Sf0LDgcxTlqDoNYjQDvwZxJJGOTcQccYnnh2V2y3NUiVzsZ3iuQiQpqibkGmfOJP5O0nLzc1w23nSl4SgzZuj1FWidCcY43+4ZCmgFtIwtMqjVL4i8KofbrIqpS5llHOdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcyJ+a6tyPNcEvP+YkBvZeGoC+dB+2mNvr7EYk6ZqjE=;
 b=CBCgLq2NT5CXefEzGwLqv6vW7Zg4lZZwwVLzC0CcXBrw/u/YrgGF3x48UQHCb+U2UYCwfNgSFoDcQPUBpycBk2qeIvtDOKbhK4tc0jI5TcHoJ21yGbKiAIuOHj3dpLXRUFSNGC677QJt4Bt3bW0xcgbTsF/m9ZMmI47Fo6sJR8c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:40:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:40:11 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 15/16] scsi: scsi_debug: Atomic write support
Date:   Wed,  3 May 2023 18:38:20 +0000
Message-Id: <20230503183821.1473305-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0085.eurprd05.prod.outlook.com
 (2603:10a6:208:136::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: a165a73d-6232-4b38-06c5-08db4c05d3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX5HYHPmDVGNOZ5TKxlobl5vDDyyU4rjozTneLCjvMUdGrYA0S0eLwlxmuJa9ZkoKtLdHXT0U0V8WPrf8P/XKhhmJ0hFVX6z6ynBB7iQUSNwLnLtXxVvVzRN1p1ANvBQHuWCIWLQrLkpE6fVP8Y4W0Ofxs7eOn5ptw27zkkArS2bMvbtmMQH9kU3ND62L16ARdIORMXwVCJNLxfRjRw22Mnu0UhXxYc2GclVKXPfxD0PnJHMYe+u1hz4fyvO8sfuJXd5N9ROxqlDWuovTWmllxNmhoPTviLxqahVRx9nkI8XtaDAQBs9/zYJYNoKfrA0YwUXgDZKdBaZV2730TlIEORsgLX2PrjnGwi6ficSHq2vsfGCBNmIBnCToWm+rbEK3X5RV3PeWuDa+0c5wnck0WpG0BTnH9fOR5Qmw07NVWyuycV5q+OpwUU6Zt9HnWfIqC2bH1RTC8SoBdzsDB94F7hrMebIe5BpQmi1o+dhqJNAOT1UFNY+mzR40dvrYlZlrXkV/5RLI8oLIWRmzLbpB4y0ov0yqiiCCQsd3pulMj9A26wp24kBnO/f0R7xmn5DWxOtO6Hv+VCSOQ4dgdbH0N82nE6QALZpZy0w3mj0qp/YM5OfDzDXvpjci+xs0TKj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(30864003)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iKGupQ8HmBm5Q2KhKon8uko9qEwDV1/DWQWhsWqoWFwfgpBHUbNgHU8gJ7t?=
 =?us-ascii?Q?gE6pu6FXuY7hRpDfl7p9n26OjU6h/XQ9zJf+cFBsh+lJuPVlm8enijQHabsT?=
 =?us-ascii?Q?ypt4LzWo5Z+YfD78d5cgwg22FpLs33PHfLNmvqBfJQIaX5zNZIPkR3Zo7yoG?=
 =?us-ascii?Q?+bpNSXnoZwtsQAiTW91SQjFFZzHCgwlV+FSRuvLfKjCn/2HaHl1JGN03/myO?=
 =?us-ascii?Q?b7Hbl4wEk9thboG4Yqm7SlloFAjL5Ccv+EizsAJBrYN3vZnua0JhYfCeJ3tv?=
 =?us-ascii?Q?43wCq4VYCuAEsVRGmlU5IHa8KvLpJkCUDPj6X+0lWwUST37kbaGiGZi049Q9?=
 =?us-ascii?Q?syTeEoFkvuOs5lz8N39212yAVcyyTdQI/5B1grrv/76ZcynCQKKj+sLnDTpZ?=
 =?us-ascii?Q?NTgQ16G/83J7YyKNcDYvagg27GFOQ7YvYi2sdJTe/WYGTERM/qnGp3UkhL99?=
 =?us-ascii?Q?Yq1eazA05Dc7ELiI38GuTwqIVAYWelrl5J9VcuFRg22t1NW+bT17IR9Eqp8H?=
 =?us-ascii?Q?J4HH1s1yQxQzKJSIWWwMgn/ss1Wlh5rBrCGnsh0ieavz9l494+KPpGYDjUQM?=
 =?us-ascii?Q?cBEFfrNE0JC52Efzb6BGY2jPPGkgn316tfMKZO/8kSdUNbAcQ8TqpGlVvYDs?=
 =?us-ascii?Q?GiMEYZFqa4OY0ZYZLCT62a1POK0AN4YC+RJmp0kiknlvpANCiqbvAy/DUYEJ?=
 =?us-ascii?Q?B7141FxerG2rJqmps40ibS7jOH92x3i5xbg2B2hA+MLIADSIjzPfZ0tJv/es?=
 =?us-ascii?Q?s+RwvGdSjan8f3qqUF9LW5mh3UR7w34JhiXmgF5puwdC/1YyRH6RCAJWsKaR?=
 =?us-ascii?Q?FwS6FdM0G47v0VQ8L+rhmFJTaT9QfsppFXO0MXwLUR23UjHw6wSO57IudUMJ?=
 =?us-ascii?Q?edz9uCzVQDt9c/mBP352J+jLQQlSh+GdTZWyr1AMSzSOCehPkkiMGz/A+iNh?=
 =?us-ascii?Q?1dKYTAxGMAy/b9B10N+62Y0wFNYf3ntbsqjOGfAxt39S8szPtMRd8M7r/Plk?=
 =?us-ascii?Q?pigmJKF8SkkKWXF/0RACfkZvg2/df7FV/oWOkIzZHAot4yOhyKrmrbU5aqQ/?=
 =?us-ascii?Q?KM4vykhaelaUQauPH7zEP68ZE+/k6s742bnUeRLTSHP7npFdLoF3806mAOqM?=
 =?us-ascii?Q?jl9TIKCwDTAc+Ale2dUwFjPjL5PUOUJFYBaB/oma2ChwIk4el+MpENMG+oqe?=
 =?us-ascii?Q?cfUMZv4Uc4KM4FAdDBLaNNnBCwVsbqqG54C9Li+GvUKRRjjtsRzV5jbWZTLS?=
 =?us-ascii?Q?0japCcAFIvzPu+UIiwjBPIaMZxnsg579EuioyIv3o+eDcCHhEuJh67fpWjlR?=
 =?us-ascii?Q?j7ClRRtBbOj3CdfsxMbgVtZge+9N0rwHTcTKe5OnZ0j6XbKDElneGNhe/AbO?=
 =?us-ascii?Q?5jhBiMbqfBdnw0kyEB5lBcrUKeho7LfyR5lzWQjf21/r+H41P8Zjs0VEh374?=
 =?us-ascii?Q?rBTraF8ek13Mpj2o9268CPPaNAhtZ51RmpAbKOERGBodsVKBwYHPHQfjyBwr?=
 =?us-ascii?Q?MqTxYQCEQWDGYnsCow1AOcACKhCKKn4E0S0nO/CmESpSpIfutus6UlPYXekm?=
 =?us-ascii?Q?r8bOthFeuaNj0ScV25atqyldcjAmEpPyD1YpxpGIX86uR/Mz/a0xIghVaRly?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?67xAg3i2vAXiWG5yD2BQzXyw/RyTo5E2psNMvgoARj6JHkGaNDt83H84rbQ3?=
 =?us-ascii?Q?81ytITpt20e5Q3h7IeSHVid7D6s+eLwAGoemNry7LXzHxHTh1L5FTrCIHgK1?=
 =?us-ascii?Q?flzhfOPDPfJh5MpiNnZDdlx3R0ibDuuNWfnDjcfuxnxi7vW1tGoaGQsMOWUz?=
 =?us-ascii?Q?J71R5/ElzO3e0ptadzTVqPcyRe6oOEb6IGaCPvigdTho0SJOPcScODwEhB3T?=
 =?us-ascii?Q?l6YM47OQUt8McDiSrsaUvnxJpJ9a7C1QJf+nN24KInG6CviLLVKreyj2+9SG?=
 =?us-ascii?Q?X4HcC4AB+liC1OI91NRa4EzGHMGiSdFVNYeQyu1QHLejy2SHG/HM5oXUB54e?=
 =?us-ascii?Q?rABCGw/TClAsxTVbohFhxCLz67avfSBwL6KFVNWQCLzFcWe3qUpo8eDXByF9?=
 =?us-ascii?Q?woq9cTnO7ENUcFMc+za2rr7aGm6k7NSIfXKZ8M1n3HBjR66NjP+iPs1bfi3J?=
 =?us-ascii?Q?dVBxT35Nmsf25eIRp5mT+ej68fptXp5XJomZoIGWyfkTC89luW95BMkexBFp?=
 =?us-ascii?Q?cCL526gbagJi/zV/Oy7ole9Ce6yt/5A3tFTyJ/WIsuYWRw38nWpjfUwn5/pr?=
 =?us-ascii?Q?bM5lXRjogulCkJ58T1QtIJ1vDzdKEPGWOYN08fmj8QFBLnODcdXJBVduPAG0?=
 =?us-ascii?Q?mCx+ltEpYchg4RBzcKYMI8FwhXHBgEL3irUK9+cy8llRTK7F7vz7gwrYUZZN?=
 =?us-ascii?Q?sUwxkohUjOq6v638wVVVEQnyu5BsnHX+3udpGTwJRhCYrAoI0BgMol9fjhtz?=
 =?us-ascii?Q?0nLFZlE0HB/cHwBFOEBjranKDcMOq/vpGByiwBYsxIWTbmUUZtZTdlKvuGKh?=
 =?us-ascii?Q?7kwkJqxj/o9FVPBozrpJdKpqPnKoAFyfaW9bD+J/R0f0qfy1AEwD8Z1MvVJ+?=
 =?us-ascii?Q?8FKsE8kPZ4p5j6QYECASrR+EmTInOenY4uLuZhQKsBoSUjK6CWMJlgprlpLm?=
 =?us-ascii?Q?iTgJIIWF+IohT+1f8YJYn1H003lf2a/e2SG8Odx6+svxmrlZ2t3/5W+iQsN9?=
 =?us-ascii?Q?DIi63wdAASryZ/hE/YAnZ0N8t3U6cyxpUgOi4+kmiCSgW8L7KJrBz//K3h1y?=
 =?us-ascii?Q?Ny1Wx+/h5Q47h3blR+aRQ4b0qPS+tl7K3LkpX/DysBUxcOIvvOH2ovoKUE2D?=
 =?us-ascii?Q?mUSfwW3y51RS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a165a73d-6232-4b38-06c5-08db4c05d3b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:40:11.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwP3Iue5NV6cEBZgrAm+crqspD8+jX3aotqZwqIgoIi99Mqjyxiaw+L725pGg30/3lteqfdvJxqsB3QFBaICig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: lTpLyZ2WGXYzdCtCoHqsde8L1IXPLP00
X-Proofpoint-ORIG-GUID: lTpLyZ2WGXYzdCtCoHqsde8L1IXPLP00
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add initial support for atomic writes.

As is standard method, feed device properties via modules param, those
being:
- atomic_max_size_blks
- atomic_alignment_blks
- atomic_granularity_blks
- atomic_max_size_with_boundary_blks
- atomic_max_boundary_blks

These just match sbc4r22 section 6.6.4 - Block limits VPD page.

We just support ATOMIC_WRITE_16.

The major change in the driver is how we lock the device for RW accesses.

Currently the driver uses a per-device lock for accessing device metadata
and "media" data (calls to do_device_access()) atomically for the duration
of the whole read/write command.

This should not suit verifying atomic writes. Reason being that currently
all reads/writes are atomic, so using atomic writes does not prove
anything.

Change device access model to basis that regular writes only atomic on a
per-sector basis, while reads and atomic writes are fully atomic.

As mentioned, since accessing metadata and device media is atomic,
continue to have regular writes involving metadata - like discard or PI -
as atomic. We can improve this later.

Currently we only support model where overlapping going reads or writes
wait for current access to complete before commencing an atomic write.
This is described in 4.29.3.2 section of the SBC. However, we simplify,
things and wait for all accesses to complete (when issuing an atomic
write).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 593 +++++++++++++++++++++++++++++---------
 1 file changed, 460 insertions(+), 133 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 776371080762..0555aee30ea1 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -66,6 +66,8 @@ static const char *sdebug_version_date = "20210520";
 
 /* Additional Sense Code (ASC) */
 #define NO_ADDITIONAL_SENSE 0x0
+#define OVERLAP_ATOMIC_COMMAND_ASC 0x0
+#define OVERLAP_ATOMIC_COMMAND_ASCQ 0x23
 #define LOGICAL_UNIT_NOT_READY 0x4
 #define LOGICAL_UNIT_COMMUNICATION_FAILURE 0x8
 #define UNRECOVERED_READ_ERR 0x11
@@ -100,6 +102,7 @@ static const char *sdebug_version_date = "20210520";
 #define READ_BOUNDARY_ASCQ 0x7
 #define ATTEMPT_ACCESS_GAP 0x9
 #define INSUFF_ZONE_ASCQ 0xe
+/* see drivers/scsi/sense_codes.h */
 
 /* Additional Sense Code Qualifier (ASCQ) */
 #define ACK_NAK_TO 0x3
@@ -149,6 +152,12 @@ static const char *sdebug_version_date = "20210520";
 #define DEF_VIRTUAL_GB   0
 #define DEF_VPD_USE_HOSTNO 1
 #define DEF_WRITESAME_LENGTH 0xFFFF
+#define DEF_ATOMIC_WRITE 1
+#define DEF_ATOMIC_MAX_LENGTH 8192
+#define DEF_ATOMIC_ALIGNMENT 2
+#define DEF_ATOMIC_GRANULARITY 2
+#define DEF_ATOMIC_BOUNDARY_MAX_LENGTH (DEF_ATOMIC_MAX_LENGTH)
+#define DEF_ATOMIC_MAX_BOUNDARY 128
 #define DEF_STRICT 0
 #define DEF_STATISTICS false
 #define DEF_SUBMIT_QUEUES 1
@@ -318,7 +327,9 @@ struct sdebug_host_info {
 
 /* There is an xarray of pointers to this struct's objects, one per host */
 struct sdeb_store_info {
-	rwlock_t macc_lck;	/* for atomic media access on this store */
+	rwlock_t macc_data_lck;	/* for media data access on this store */
+	rwlock_t macc_meta_lck;	/* for atomic media meta access on this store */
+	rwlock_t macc_sector_lck;	/* per-sector media data access on this store */
 	u8 *storep;		/* user data storage (ram) */
 	struct t10_pi_tuple *dif_storep; /* protection info */
 	void *map_storep;	/* provisioning map */
@@ -345,12 +356,20 @@ struct sdebug_defer {
 	enum sdeb_defer_type defer_t;
 };
 
+struct sdebug_device_access_info {
+	bool atomic_write;
+	u64 lba;
+	u32 num;
+	struct scsi_cmnd *self;
+};
+
 struct sdebug_queued_cmd {
 	/* corresponding bit set in in_use_bm[] in owning struct sdebug_queue
 	 * instance indicates this slot is in use.
 	 */
 	struct sdebug_defer *sd_dp;
 	struct scsi_cmnd *a_cmnd;
+	struct sdebug_device_access_info *i;
 };
 
 struct sdebug_queue {
@@ -413,7 +432,8 @@ enum sdeb_opcode_index {
 	SDEB_I_PRE_FETCH = 29,		/* 10, 16 */
 	SDEB_I_ZONE_OUT = 30,		/* 0x94+SA; includes no data xfer */
 	SDEB_I_ZONE_IN = 31,		/* 0x95+SA; all have data-in */
-	SDEB_I_LAST_ELEM_P1 = 32,	/* keep this last (previous + 1) */
+	SDEB_I_ATOMIC_WRITE_16 = 32,	/* keep this last (previous + 1) */
+	SDEB_I_LAST_ELEM_P1 = 33,	/* keep this last (previous + 1) */
 };
 
 
@@ -447,7 +467,8 @@ static const unsigned char opcode_ind_arr[256] = {
 	0, 0, 0, SDEB_I_VERIFY,
 	SDEB_I_PRE_FETCH, SDEB_I_SYNC_CACHE, 0, SDEB_I_WRITE_SAME,
 	SDEB_I_ZONE_OUT, SDEB_I_ZONE_IN, 0, 0,
-	0, 0, 0, 0, 0, 0, SDEB_I_SERV_ACT_IN_16, SDEB_I_SERV_ACT_OUT_16,
+	0, 0, 0, 0,
+	SDEB_I_ATOMIC_WRITE_16, 0, SDEB_I_SERV_ACT_IN_16, SDEB_I_SERV_ACT_OUT_16,
 /* 0xa0; 0xa0->0xbf: 12 byte cdbs */
 	SDEB_I_REPORT_LUNS, SDEB_I_ATA_PT, 0, SDEB_I_MAINT_IN,
 	     SDEB_I_MAINT_OUT, 0, 0, 0,
@@ -495,6 +516,7 @@ static int resp_write_buffer(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_sync_cache(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_pre_fetch(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_report_zones(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_atomic_write(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_open_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_close_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_finish_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
@@ -731,6 +753,11 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 	    resp_report_zones, zone_in_iarr, /* ZONE_IN(16), REPORT ZONES) */
 		{16,  0x0 /* SA */, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xbf, 0xc7} },
+/* 31 */
+	{0, 0x0, 0x0, F_D_OUT | FF_MEDIA_IO,
+	    resp_atomic_write, NULL, /* ATOMIC WRITE 16 */
+		{16,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff} },
 /* sentinel */
 	{0xff, 0, 0, 0, NULL, NULL,		/* terminating element */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
@@ -779,6 +806,12 @@ static unsigned int sdebug_unmap_granularity = DEF_UNMAP_GRANULARITY;
 static unsigned int sdebug_unmap_max_blocks = DEF_UNMAP_MAX_BLOCKS;
 static unsigned int sdebug_unmap_max_desc = DEF_UNMAP_MAX_DESC;
 static unsigned int sdebug_write_same_length = DEF_WRITESAME_LENGTH;
+static unsigned int sdebug_atomic_write = DEF_ATOMIC_WRITE;
+static unsigned int sdebug_atomic_max_size_blks = DEF_ATOMIC_MAX_LENGTH;
+static unsigned int sdebug_atomic_alignment_blks = DEF_ATOMIC_ALIGNMENT;
+static unsigned int sdebug_atomic_granularity_blks = DEF_ATOMIC_GRANULARITY;
+static unsigned int sdebug_atomic_max_size_with_boundary_blks = DEF_ATOMIC_BOUNDARY_MAX_LENGTH;
+static unsigned int sdebug_atomic_max_boundary_blks = DEF_ATOMIC_MAX_BOUNDARY;
 static int sdebug_uuid_ctl = DEF_UUID_CTL;
 static bool sdebug_random = DEF_RANDOM;
 static bool sdebug_per_host_store = DEF_PER_HOST_STORE;
@@ -880,6 +913,11 @@ static inline bool scsi_debug_lbp(void)
 		(sdebug_lbpu || sdebug_lbpws || sdebug_lbpws10);
 }
 
+static inline bool scsi_debug_atomic_write(void)
+{
+	return 0 == sdebug_fake_rw && sdebug_atomic_write;
+}
+
 static void *lba2fake_store(struct sdeb_store_info *sip,
 			    unsigned long long lba)
 {
@@ -1510,6 +1548,14 @@ static int inquiry_vpd_b0(unsigned char *arr)
 	/* Maximum WRITE SAME Length */
 	put_unaligned_be64(sdebug_write_same_length, &arr[32]);
 
+	if (sdebug_atomic_write) {
+		put_unaligned_be32(sdebug_atomic_max_size_blks, &arr[40]);
+		put_unaligned_be32(sdebug_atomic_alignment_blks, &arr[44]);
+		put_unaligned_be32(sdebug_atomic_granularity_blks, &arr[48]);
+		put_unaligned_be32(sdebug_atomic_max_size_with_boundary_blks, &arr[52]);
+		put_unaligned_be32(sdebug_atomic_max_boundary_blks, &arr[56]);
+	}
+
 	return 0x3c; /* Mandatory page length for Logical Block Provisioning */
 }
 
@@ -3011,15 +3057,242 @@ static inline struct sdeb_store_info *devip2sip(struct sdebug_dev_info *devip,
 	return xa_load(per_store_ap, devip->sdbg_host->si_idx);
 }
 
+
+static inline void
+sdeb_read_lock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__acquire(lock);
+	else
+		read_lock(lock);
+}
+
+static inline void
+sdeb_read_unlock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__release(lock);
+	else
+		read_unlock(lock);
+}
+
+static inline void
+sdeb_write_lock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__acquire(lock);
+	else
+		write_lock(lock);
+}
+
+static inline void
+sdeb_write_unlock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__release(lock);
+	else
+		write_unlock(lock);
+}
+
+static inline void
+sdeb_data_read_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_lock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_read_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_unlock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_write_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_lock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_write_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_unlock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_sector_read_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_lock(&sip->macc_sector_lck);
+}
+
+static inline void
+sdeb_data_sector_read_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_unlock(&sip->macc_sector_lck);
+}
+
+static inline void
+sdeb_data_sector_write_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_lock(&sip->macc_sector_lck);
+}
+
+static inline void
+sdeb_data_sector_write_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_unlock(&sip->macc_sector_lck);
+}
+
+/*
+Atomic locking:
+We simplify the atomic model to allow only 1x atomic
+write and many non-atomic reads or writes for all
+LBAs.
+
+A RW lock has a similar bahaviour:
+Only 1x writer and many readers.
+
+So use a RW lock for per-device read and write locking:
+An atomic access grabs the lock as a writer and
+non-atomic grabs the lock as a reader.
+*/
+
+static inline void
+sdeb_data_lock(struct sdeb_store_info *sip, bool atomic_write)
+{
+	if (atomic_write)
+		sdeb_data_write_lock(sip);
+	else
+		sdeb_data_read_lock(sip);
+}
+
+static inline void
+sdeb_data_unlock(struct sdeb_store_info *sip, bool atomic_write)
+{
+	if (atomic_write)
+		sdeb_data_write_unlock(sip);
+	else
+		sdeb_data_read_unlock(sip);
+}
+
+/* Allow many reads but only 1x write per sector */
+static inline void
+sdeb_data_sector_lock(struct sdeb_store_info *sip, bool do_write)
+{
+	if (do_write)
+		sdeb_data_sector_write_lock(sip);
+	else
+		sdeb_data_sector_read_lock(sip);
+}
+
+static inline void
+sdeb_data_sector_unlock(struct sdeb_store_info *sip, bool do_write)
+{
+	if (do_write)
+		sdeb_data_sector_write_unlock(sip);
+	else
+		sdeb_data_sector_read_unlock(sip);
+}
+
+static inline void
+sdeb_meta_read_lock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__acquire(&sip->macc_meta_lck);
+		else
+			__acquire(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			read_lock(&sip->macc_meta_lck);
+		else
+			read_lock(&sdeb_fake_rw_lck);
+	}
+}
+
+static inline void
+sdeb_meta_read_unlock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__release(&sip->macc_meta_lck);
+		else
+			__release(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			read_unlock(&sip->macc_meta_lck);
+		else
+			read_unlock(&sdeb_fake_rw_lck);
+	}
+}
+
+static inline void
+sdeb_meta_write_lock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__acquire(&sip->macc_meta_lck);
+		else
+			__acquire(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			write_lock(&sip->macc_meta_lck);
+		else
+			write_lock(&sdeb_fake_rw_lck);
+	}
+}
+
+static inline void
+sdeb_meta_write_unlock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__release(&sip->macc_meta_lck);
+		else
+			__release(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			write_unlock(&sip->macc_meta_lck);
+		else
+			write_unlock(&sdeb_fake_rw_lck);
+	}
+}
+
+static struct sdebug_queue *get_queue(struct scsi_cmnd *cmnd);
+
 /* Returns number of bytes copied or -1 if error. */
 static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
-			    u32 sg_skip, u64 lba, u32 num, bool do_write)
+			    u32 sg_skip, u64 lba, u32 num, bool do_write,
+			    bool atomic_write)
 {
 	int ret;
-	u64 block, rest = 0;
+	u64 block;
 	enum dma_data_direction dir;
 	struct scsi_data_buffer *sdb = &scp->sdb;
 	u8 *fsp;
+	int i;
+
+	/*
+	 * Even though reads are inherently atomic (in this driver), we expect
+	 * the atomic flag only for writes.
+	 */
+	if (!do_write && atomic_write)
+		return -1;
 
 	if (do_write) {
 		dir = DMA_TO_DEVICE;
@@ -3035,21 +3308,26 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 	fsp = sip->storep;
 
 	block = do_div(lba, sdebug_store_sectors);
-	if (block + num > sdebug_store_sectors)
-		rest = block + num - sdebug_store_sectors;
 
-	ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
+	/* Only allow 1x atomic write or multiple non-atomic writes at any given time */
+	sdeb_data_lock(sip, atomic_write);
+	for (i = 0; i < num; i++) {
+		/* We shouldn't need to lock for atomic writes, but do it anyway */
+		sdeb_data_sector_lock(sip, do_write);
+		ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
 		   fsp + (block * sdebug_sector_size),
-		   (num - rest) * sdebug_sector_size, sg_skip, do_write);
-	if (ret != (num - rest) * sdebug_sector_size)
-		return ret;
-
-	if (rest) {
-		ret += sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
-			    fsp, rest * sdebug_sector_size,
-			    sg_skip + ((num - rest) * sdebug_sector_size),
-			    do_write);
+		   sdebug_sector_size, sg_skip, do_write);
+		sdeb_data_sector_unlock(sip, do_write);
+		if (ret != sdebug_sector_size) {
+			ret += (i * sdebug_sector_size);
+			break;
+		}
+		sg_skip += sdebug_sector_size;
+		if (++block >= sdebug_store_sectors)
+			block = 0;
 	}
+	ret = num * sdebug_sector_size;
+	sdeb_data_unlock(sip, atomic_write);
 
 	return ret;
 }
@@ -3225,70 +3503,6 @@ static int prot_verify_read(struct scsi_cmnd *scp, sector_t start_sec,
 	return ret;
 }
 
-static inline void
-sdeb_read_lock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__acquire(&sip->macc_lck);
-		else
-			__acquire(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			read_lock(&sip->macc_lck);
-		else
-			read_lock(&sdeb_fake_rw_lck);
-	}
-}
-
-static inline void
-sdeb_read_unlock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__release(&sip->macc_lck);
-		else
-			__release(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			read_unlock(&sip->macc_lck);
-		else
-			read_unlock(&sdeb_fake_rw_lck);
-	}
-}
-
-static inline void
-sdeb_write_lock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__acquire(&sip->macc_lck);
-		else
-			__acquire(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			write_lock(&sip->macc_lck);
-		else
-			write_lock(&sdeb_fake_rw_lck);
-	}
-}
-
-static inline void
-sdeb_write_unlock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__release(&sip->macc_lck);
-		else
-			__release(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			write_unlock(&sip->macc_lck);
-		else
-			write_unlock(&sdeb_fake_rw_lck);
-	}
-}
-
 static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	bool check_prot;
@@ -3298,6 +3512,7 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	u64 lba;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u8 *cmd = scp->cmnd;
+	bool meta_data_locked = false;
 
 	switch (cmd[0]) {
 	case READ_16:
@@ -3356,6 +3571,10 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		atomic_set(&sdeb_inject_pending, 0);
 	}
 
+	/*
+	 * When checking device access params, for reads we only check data
+	 * versus what is set at init time, so no need to lock.
+	 */
 	ret = check_device_access_params(scp, lba, num, false);
 	if (ret)
 		return ret;
@@ -3375,29 +3594,33 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		return check_condition_result;
 	}
 
-	sdeb_read_lock(sip);
+	if (sdebug_dev_is_zoned(devip) ||
+	    (sdebug_dix && scsi_prot_sg_count(scp)))  {
+		sdeb_meta_read_lock(sip);
+		meta_data_locked = true;
+	}
 
 	/* DIX + T10 DIF */
 	if (unlikely(sdebug_dix && scsi_prot_sg_count(scp))) {
 		switch (prot_verify_read(scp, lba, num, ei_lba)) {
 		case 1: /* Guard tag error */
 			if (cmd[1] >> 5 != 3) { /* RDPROTECT != 3 */
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 1);
 				return check_condition_result;
 			} else if (scp->prot_flags & SCSI_PROT_GUARD_CHECK) {
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 1);
 				return illegal_condition_result;
 			}
 			break;
 		case 3: /* Reference tag error */
 			if (cmd[1] >> 5 != 3) { /* RDPROTECT != 3 */
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 3);
 				return check_condition_result;
 			} else if (scp->prot_flags & SCSI_PROT_REF_CHECK) {
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 3);
 				return illegal_condition_result;
 			}
@@ -3405,8 +3628,9 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, false);
-	sdeb_read_unlock(sip);
+	ret = do_device_access(sip, scp, 0, lba, num, false, false);
+	if (meta_data_locked)
+		sdeb_meta_read_unlock(sip);
 	if (unlikely(ret == -1))
 		return DID_ERROR << 16;
 
@@ -3595,6 +3819,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	u64 lba;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u8 *cmd = scp->cmnd;
+	bool meta_data_locked = false;
 
 	switch (cmd[0]) {
 	case WRITE_16:
@@ -3648,10 +3873,17 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				    "to DIF device\n");
 	}
 
-	sdeb_write_lock(sip);
+	if (sdebug_dev_is_zoned(devip) ||
+	    (sdebug_dix && scsi_prot_sg_count(scp)) ||
+	    scsi_debug_lbp())  {
+		sdeb_meta_write_lock(sip);
+		meta_data_locked = true;
+	}
+
 	ret = check_device_access_params(scp, lba, num, true);
 	if (ret) {
-		sdeb_write_unlock(sip);
+		if (meta_data_locked)
+			sdeb_meta_write_unlock(sip);
 		return ret;
 	}
 
@@ -3660,22 +3892,22 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		switch (prot_verify_write(scp, lba, num, ei_lba)) {
 		case 1: /* Guard tag error */
 			if (scp->prot_flags & SCSI_PROT_GUARD_CHECK) {
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 1);
 				return illegal_condition_result;
 			} else if (scp->cmnd[1] >> 5 != 3) { /* WRPROTECT != 3 */
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 1);
 				return check_condition_result;
 			}
 			break;
 		case 3: /* Reference tag error */
 			if (scp->prot_flags & SCSI_PROT_REF_CHECK) {
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 3);
 				return illegal_condition_result;
 			} else if (scp->cmnd[1] >> 5 != 3) { /* WRPROTECT != 3 */
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 3);
 				return check_condition_result;
 			}
@@ -3683,13 +3915,16 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, true);
+	ret = do_device_access(sip, scp, 0, lba, num, true, false);
 	if (unlikely(scsi_debug_lbp()))
 		map_region(sip, lba, num);
+
 	/* If ZBC zone then bump its write pointer */
 	if (sdebug_dev_is_zoned(devip))
 		zbc_inc_wp(devip, lba, num);
-	sdeb_write_unlock(sip);
+	if (meta_data_locked)
+		sdeb_meta_write_unlock(sip);
+
 	if (unlikely(-1 == ret))
 		return DID_ERROR << 16;
 	else if (unlikely(sdebug_verbose &&
@@ -3796,7 +4031,8 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 		goto err_out;
 	}
 
-	sdeb_write_lock(sip);
+	/* Just keep it simple and always lock for now */
+	sdeb_meta_write_lock(sip);
 	sg_off = lbdof_blen;
 	/* Spec says Buffer xfer Length field in number of LBs in dout */
 	cum_lb = 0;
@@ -3839,7 +4075,11 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 			}
 		}
 
-		ret = do_device_access(sip, scp, sg_off, lba, num, true);
+		/*
+		 * Write ranges atomically to keep as close to pre-atomic
+		 * writes behaviour as possible.
+		 */
+		ret = do_device_access(sip, scp, sg_off, lba, num, true, true);
 		/* If ZBC zone then bump its write pointer */
 		if (sdebug_dev_is_zoned(devip))
 			zbc_inc_wp(devip, lba, num);
@@ -3878,7 +4118,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 	}
 	ret = 0;
 err_out_unlock:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 err_out:
 	kfree(lrdp);
 	return ret;
@@ -3897,14 +4137,16 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 						scp->device->hostdata, true);
 	u8 *fs1p;
 	u8 *fsp;
+	bool meta_data_locked = false;
 
-	sdeb_write_lock(sip);
+	if (sdebug_dev_is_zoned(devip) || scsi_debug_lbp()) {
+		sdeb_meta_write_lock(sip);
+		meta_data_locked = true;
+	}
 
 	ret = check_device_access_params(scp, lba, num, true);
-	if (ret) {
-		sdeb_write_unlock(sip);
-		return ret;
-	}
+	if (ret)
+		goto out;
 
 	if (unmap && scsi_debug_lbp()) {
 		unmap_region(sip, lba, num);
@@ -3915,6 +4157,7 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 	/* if ndob then zero 1 logical block, else fetch 1 logical block */
 	fsp = sip->storep;
 	fs1p = fsp + (block * lb_size);
+	sdeb_data_write_lock(sip);
 	if (ndob) {
 		memset(fs1p, 0, lb_size);
 		ret = 0;
@@ -3922,8 +4165,8 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 		ret = fetch_to_dev_buffer(scp, fs1p, lb_size);
 
 	if (-1 == ret) {
-		sdeb_write_unlock(sip);
-		return DID_ERROR << 16;
+		ret = DID_ERROR << 16;
+		goto out;
 	} else if (sdebug_verbose && !ndob && (ret < lb_size))
 		sdev_printk(KERN_INFO, scp->device,
 			    "%s: %s: lb size=%u, IO sent=%d bytes\n",
@@ -3940,10 +4183,12 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 	/* If ZBC zone then bump its write pointer */
 	if (sdebug_dev_is_zoned(devip))
 		zbc_inc_wp(devip, lba, num);
+	sdeb_data_write_unlock(sip);
+	ret = 0;
 out:
-	sdeb_write_unlock(sip);
-
-	return 0;
+	if (meta_data_locked)
+		sdeb_meta_write_unlock(sip);
+	return ret;
 }
 
 static int resp_write_same_10(struct scsi_cmnd *scp,
@@ -4086,25 +4331,30 @@ static int resp_comp_write(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
-
 	ret = do_dout_fetch(scp, dnum, arr);
 	if (ret == -1) {
 		retval = DID_ERROR << 16;
-		goto cleanup;
+		goto cleanup_free;
 	} else if (sdebug_verbose && (ret < (dnum * lb_size)))
 		sdev_printk(KERN_INFO, scp->device, "%s: compare_write: cdb "
 			    "indicated=%u, IO sent=%d bytes\n", my_name,
 			    dnum * lb_size, ret);
+
+	sdeb_data_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 	if (!comp_write_worker(sip, lba, num, arr, false)) {
 		mk_sense_buffer(scp, MISCOMPARE, MISCOMPARE_VERIFY_ASC, 0);
 		retval = check_condition_result;
-		goto cleanup;
+		goto cleanup_unlock;
 	}
+
+	/* Cover sip->map_storep (which map_region()) sets with data lock */
 	if (scsi_debug_lbp())
 		map_region(sip, lba, num);
-cleanup:
-	sdeb_write_unlock(sip);
+cleanup_unlock:
+	sdeb_meta_write_unlock(sip);
+	sdeb_data_write_unlock(sip);
+cleanup_free:
 	kfree(arr);
 	return retval;
 }
@@ -4148,7 +4398,7 @@ static int resp_unmap(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 
 	desc = (void *)&buf[8];
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	for (i = 0 ; i < descriptors ; i++) {
 		unsigned long long lba = get_unaligned_be64(&desc[i].lba);
@@ -4164,7 +4414,7 @@ static int resp_unmap(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	ret = 0;
 
 out:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	kfree(buf);
 
 	return ret;
@@ -4277,12 +4527,13 @@ static int resp_pre_fetch(struct scsi_cmnd *scp,
 		rest = block + nblks - sdebug_store_sectors;
 
 	/* Try to bring the PRE-FETCH range into CPU's cache */
-	sdeb_read_lock(sip);
+	sdeb_data_read_lock(sip);
 	prefetch_range(fsp + (sdebug_sector_size * block),
 		       (nblks - rest) * sdebug_sector_size);
 	if (rest)
 		prefetch_range(fsp, rest * sdebug_sector_size);
-	sdeb_read_unlock(sip);
+
+	sdeb_data_read_unlock(sip);
 fini:
 	if (cmd[1] & 0x2)
 		res = SDEG_RES_IMMED_MASK;
@@ -4441,7 +4692,7 @@ static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		return check_condition_result;
 	}
 	/* Not changing store, so only need read access */
-	sdeb_read_lock(sip);
+	sdeb_data_read_lock(sip);
 
 	ret = do_dout_fetch(scp, a_num, arr);
 	if (ret == -1) {
@@ -4463,7 +4714,7 @@ static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		goto cleanup;
 	}
 cleanup:
-	sdeb_read_unlock(sip);
+	sdeb_data_read_unlock(sip);
 	kfree(arr);
 	return ret;
 }
@@ -4509,7 +4760,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_read_lock(sip);
+	sdeb_meta_read_lock(sip);
 
 	desc = arr + 64;
 	for (lba = zs_lba; lba < sdebug_capacity;
@@ -4607,11 +4858,68 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	ret = fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, rep_len));
 
 fini:
-	sdeb_read_unlock(sip);
+	sdeb_meta_read_unlock(sip);
 	kfree(arr);
 	return ret;
 }
 
+static int resp_atomic_write(struct scsi_cmnd *scp,
+			     struct sdebug_dev_info *devip)
+{
+	struct sdeb_store_info *sip;
+	u8 *cmd = scp->cmnd;
+	u16 boundary, len;
+	u64 lba;
+	int ret;
+
+	if (!scsi_debug_atomic_write()) {
+		mk_sense_invalid_opcode(scp);
+		return check_condition_result;
+	}
+
+	sip = devip2sip(devip, true);
+
+	lba = get_unaligned_be64(cmd + 2);
+	boundary = get_unaligned_be16(cmd + 10);
+	len = get_unaligned_be16(cmd + 12);
+
+	if (sdebug_atomic_alignment_blks && lba % sdebug_atomic_alignment_blks) {
+		/* Does not meet alignment requirement */
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
+		return check_condition_result;
+	}
+
+	if (sdebug_atomic_granularity_blks && len % sdebug_atomic_granularity_blks) {
+		/* Does not meet alignment requirement */
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
+		return check_condition_result;
+	}
+
+	if (boundary > 0) {
+		if (boundary > sdebug_atomic_max_boundary_blks) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 12, -1);
+			return check_condition_result;
+		}
+
+		if (len > sdebug_atomic_max_size_with_boundary_blks) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 12, -1);
+			return check_condition_result;
+		}
+	} else {
+		if (len > sdebug_atomic_max_size_blks) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 12, -1);
+			return check_condition_result;
+		}
+	}
+
+	ret = do_device_access(sip, scp, 0, lba, len, true, true);
+	if (unlikely(ret == -1))
+		return DID_ERROR << 16;
+	if (unlikely(ret != len * sdebug_sector_size))
+		return DID_ERROR << 16;
+	return 0;
+}
+
 /* Logic transplanted from tcmu-runner, file_zbc.c */
 static void zbc_open_all(struct sdebug_dev_info *devip)
 {
@@ -4638,8 +4946,7 @@ static int resp_open_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		mk_sense_invalid_opcode(scp);
 		return check_condition_result;
 	}
-
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		/* Check if all closed zones can be open */
@@ -4688,7 +4995,7 @@ static int resp_open_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 
 	zbc_open_zone(devip, zsp, true);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -4715,7 +5022,7 @@ static int resp_close_zone(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		zbc_close_all(devip);
@@ -4744,7 +5051,7 @@ static int resp_close_zone(struct scsi_cmnd *scp,
 
 	zbc_close_zone(devip, zsp);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -4787,7 +5094,7 @@ static int resp_finish_zone(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		zbc_finish_all(devip);
@@ -4816,7 +5123,7 @@ static int resp_finish_zone(struct scsi_cmnd *scp,
 
 	zbc_finish_zone(devip, zsp, true);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -4867,7 +5174,7 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		zbc_rwp_all(devip);
@@ -4895,7 +5202,7 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 
 	zbc_rwp_zone(devip, zsp);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -4962,6 +5269,8 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 		retiring = 1;
 
 	sqcp->a_cmnd = NULL;
+	scp->host_scribble = NULL;
+	sqcp->i = NULL;
 	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 		pr_err("Unexpected completion\n");
@@ -5717,6 +6026,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				if (kt <= d) {	/* elapsed duration >= kt */
 					spin_lock_irqsave(&sqp->qc_lock, iflags);
 					sqcp->a_cmnd = NULL;
+					cmnd->host_scribble = NULL;
 					atomic_dec(&devip->num_in_q);
 					clear_bit(k, sqp->in_use_bm);
 					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
@@ -5837,6 +6147,7 @@ module_param_named(lbprz, sdebug_lbprz, int, S_IRUGO);
 module_param_named(lbpu, sdebug_lbpu, int, S_IRUGO);
 module_param_named(lbpws, sdebug_lbpws, int, S_IRUGO);
 module_param_named(lbpws10, sdebug_lbpws10, int, S_IRUGO);
+module_param_named(atomic_write, sdebug_atomic_write, int, S_IRUGO);
 module_param_named(lowest_aligned, sdebug_lowest_aligned, int, S_IRUGO);
 module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
 module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
@@ -5871,6 +6182,11 @@ module_param_named(unmap_alignment, sdebug_unmap_alignment, int, S_IRUGO);
 module_param_named(unmap_granularity, sdebug_unmap_granularity, int, S_IRUGO);
 module_param_named(unmap_max_blocks, sdebug_unmap_max_blocks, int, S_IRUGO);
 module_param_named(unmap_max_desc, sdebug_unmap_max_desc, int, S_IRUGO);
+module_param_named(atomic_max_size_blks, sdebug_unmap_alignment, int, S_IRUGO);
+module_param_named(atomic_alignment_blks, sdebug_atomic_alignment_blks, int, S_IRUGO);
+module_param_named(atomic_granularity_blks, sdebug_atomic_granularity_blks, int, S_IRUGO);
+module_param_named(atomic_max_size_with_boundary_blks, sdebug_atomic_max_size_with_boundary_blks, int, S_IRUGO);
+module_param_named(atomic_max_boundary_blks, sdebug_atomic_max_boundary_blks, int, S_IRUGO);
 module_param_named(uuid_ctl, sdebug_uuid_ctl, int, S_IRUGO);
 module_param_named(virtual_gb, sdebug_virtual_gb, int, S_IRUGO | S_IWUSR);
 module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
@@ -5913,6 +6229,7 @@ MODULE_PARM_DESC(lbprz,
 MODULE_PARM_DESC(lbpu, "enable LBP, support UNMAP command (def=0)");
 MODULE_PARM_DESC(lbpws, "enable LBP, support WRITE SAME(16) with UNMAP bit (def=0)");
 MODULE_PARM_DESC(lbpws10, "enable LBP, support WRITE SAME(10) with UNMAP bit (def=0)");
+MODULE_PARM_DESC(atomic_write, "enable ATOMIC WRITE support, support WRITE ATOMIC(16) (def=1)");
 MODULE_PARM_DESC(lowest_aligned, "lowest aligned lba (def=0)");
 MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> flat address method");
 MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=1)");
@@ -5944,6 +6261,11 @@ MODULE_PARM_DESC(unmap_alignment, "lowest aligned thin provisioning lba (def=0)"
 MODULE_PARM_DESC(unmap_granularity, "thin provisioning granularity in blocks (def=1)");
 MODULE_PARM_DESC(unmap_max_blocks, "max # of blocks can be unmapped in one cmd (def=0xffffffff)");
 MODULE_PARM_DESC(unmap_max_desc, "max # of ranges that can be unmapped in one cmd (def=256)");
+MODULE_PARM_DESC(atomic_max_size_blks, "max # of blocks can be atomically written in one cmd (def=0xff)");
+MODULE_PARM_DESC(atomic_alignment_blks, "minimum alignment of atomic write in blocks (def=2)");
+MODULE_PARM_DESC(atomic_granularity_blks, "minimum granularity of atomic write in blocks (def=2)");
+MODULE_PARM_DESC(atomic_max_size_with_boundary_blks, "max # of blocks can be atomically written in one cmd with boundary set (def=0xff)");
+MODULE_PARM_DESC(atomic_boundary_blks, "max # boundaries per atomic write (def=0)");
 MODULE_PARM_DESC(uuid_ctl,
 		 "1->use uuid for lu name, 0->don't, 2->all use same (def=0)");
 MODULE_PARM_DESC(virtual_gb, "virtual gigabyte (GiB) size (def=0 -> use dev_size_mb)");
@@ -7079,6 +7401,7 @@ static int __init scsi_debug_init(void)
 			goto free_q_arr;
 		}
 	}
+
 	xa_init_flags(per_store_ap, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	if (want_store) {
 		idx = sdebug_add_store();
@@ -7279,7 +7602,9 @@ static int sdebug_add_store(void)
 			map_region(sip, 0, 2);
 	}
 
-	rwlock_init(&sip->macc_lck);
+	rwlock_init(&sip->macc_data_lck);
+	rwlock_init(&sip->macc_meta_lck);
+	rwlock_init(&sip->macc_sector_lck);
 	return (int)n_idx;
 err:
 	sdebug_erase_store((int)n_idx, sip);
@@ -7573,6 +7898,8 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			retiring = true;
 
 		sqcp->a_cmnd = NULL;
+		sqcp->i = NULL;
+		scp->host_scribble = NULL;
 		if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
 			pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u from %s\n",
 				sqp, queue_num, qc_idx, __func__);
-- 
2.31.1

