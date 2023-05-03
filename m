Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E156F5E63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjECSp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjECSpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:45:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77518A4F;
        Wed,  3 May 2023 11:44:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpiBh015206;
        Wed, 3 May 2023 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fu8QPAY0g7iFXP4WhzCoh6qJJsySH/11LcV54M/u8sE=;
 b=1eGxo0WLSoeg3+C29obV/6jxXbh2qpyWtgV5xo1I7zAO8q5SzQdnjVGKywb8lZBplyb5
 R0zXDJAWrldmSR/HupVA7ZakQaJE2VAWvzAE65i5FHy8HH8TH9RXaSJQq6iEzM/cBx2R
 +aVLsQSvAoTbJ7WK8BnNAD258Cc16N28kp7fzlq0ZWowxN4JP3FWziP0Zy3JAIphwR/4
 YYR5ld2Y7hY9ZaF/n97vaNwrNplfWpmIFKfpc1/VZS0CBOex0baUPMKlOCkhxLVQW0HL
 c+P2NsLp2MWQS/MyAZtWqH8n227gtLUEqTzrj8r+G+yzXkYCBaSmfSdWatqa9KkqE1Dm Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t14063k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HXUgq027022;
        Wed, 3 May 2023 18:39:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdscfj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8H3v/RMX1M4iQ4T29YbgJsOHfiNNIcBx91dU3hV0+aYAOkfLT6+b8Ph64O2k9EgLX0VyHblAGaQ9IpkVKPNxiIPeYzn8QDFlW/HEnsd/QV5FSvSPpyFXAYe/eq154iiKH2f70zJhaqLLo6oxXAtR5gveMXSbd45FqxEgj5nxKU3th8LhKIcmc0s8M+AdWp0+qi9ttef2gaLLcMLE3wCZyXyXbqgEyCmt5n+JKUkPaIiNJ9plCtJXCiiQ/OsF4gwoudwlx/bxbmBdZkuHT31PbFg2mGkjtaudxy3u0haKnk4D5e0inDoYkFPzx/PV62NMwe0z9m5TECucxe0tt0zUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu8QPAY0g7iFXP4WhzCoh6qJJsySH/11LcV54M/u8sE=;
 b=inIDFHW4COolU1wQAKBW5QWZJifWJNb0j/wdORRcCyFvtnQ87glgkzalfH7f6jtdyrIIVDhZeXdTbar7oFD2Wv4MFTe9+AVyeMETIA/92fe499YGBzOBIj7om1uwo3HFY0DW9FG+raR+lzGgrycfQaW9ruR8YrMF/4WOifqHu+KgKgJYpKoUxspEa+5RulIZDPn2wyFnubueEwu4W7Eb3xA/FVPvKmNrxICLo412tH1CTsVpQx0Zaf9CpgNogWJ1kYe2QfJIMFDBLBTH/q2j+UYFe08rdRjkhh/Pj7CAP9isgj1K1/sV6GDPIt36hpYLIytjmQ9shmzU8fQ6OSIjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu8QPAY0g7iFXP4WhzCoh6qJJsySH/11LcV54M/u8sE=;
 b=nUuvf4x0BdT4XW8x67BS3X57+nZhVdKvlNi5dvFrQMs0PFwNsMHRQibqzUYMl4avKVR2zrLNTlHfn62C0hk+XSdERKN8g61sTMohgLpIMrgHlLKBCk5tXMmiinzyFjkOS+/uHiaHXG922DR+oyeGLLVJK9yFBbvkm+614Y65PtM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:32 +0000
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
Subject: [PATCH RFC 03/16] xfs: Support atomic write for statx
Date:   Wed,  3 May 2023 18:38:08 +0000
Message-Id: <20230503183821.1473305-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:8:56::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 0402ffc9-e9d1-489e-0f70-08db4c05bc35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOUXNbw74GqLiIMZ16a58pJ3tzG2QBOxEjGQFgnSJVdyQFfL+QmjoYXHg8G7nWklX6WT1PbfpLHRp8/l/g7J6Pqk3aW/78RNrPrWoJvLWWhtAkk6q9ZTCdz2x/MAjov8vo6Q8Aj/QmghrYeBUdW7CBf8HiD1TwqpFa0iLg6us+8YdpigzOiI8oN1kJb0ix7TjUkZ1v8EfT9AZsGTzqkWU0+92gCk36vhXM+bDQuir1tuo0m5rF2T9VejXDyPQ6IbV5vKkyO5H9tUbdnuqQEFIlsBEicT3byKOUYH2IHvaQm4spffhr9AyNGyZprG8hVdzyvLXKf8NoVZoxmEK4+fUVpcZweUsj5Z47jICH/QrSfBqwJzX5gBXiSRuEQa1lewHFcwaYZSHaHTEq/TaQSfVqjvMT6b4jUQbU7qUoCj+zozCKErTacCN/E1AVvstPykY2cH1OczZkrmNQ7zv4sfOqMDPN1DxnJylG7YwYkvtxIma1qI/t77ntDF4snbMoC1GyVKXbthyucaDihEJKX/cb3kmhUP7Z0GE4K3OBH3aiBVe9WIMmkGaNgy5ZwzSV5HilMh7W3d/AKcItnwRkguQhUqap5TyUcCzMGfdb1XAbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X2eCAWFYAIQ6DyFPfOltN8kWZZ1aE4DNxybztIy7Sr2E2cXy/GwiIreTr55d?=
 =?us-ascii?Q?HJEI8TVSYcCnVfuDoLEPyCdTR8xBQD3mboH9VehYUrjovL5VsR03OnVTkB3p?=
 =?us-ascii?Q?/r5nUEWn+5RlWoorkOABF2FNrGS6wzAkXmclpMXL1RdGAQPtvStCz1zZ13f2?=
 =?us-ascii?Q?fvIK24x0ioFDTTBJI9K8y15wq/oq5LBWkGXIyFl655LGJVXzwZaVIAhRRt7L?=
 =?us-ascii?Q?YJoRp4LkHRAjNIWMA9MfXw4Znhwi9j+4GzWWmNw5lsZTv3oBtSQ9I5tgQkvh?=
 =?us-ascii?Q?NXKWWnBfYF0dXDiFnSY/r5Mqfcuk8iIdkaCtV2BOevLOGJqHJPpGtbyezs1K?=
 =?us-ascii?Q?RNiLlSf2sdYAHT2B4MarQF1HobvoTy9WzGA2E69gRGwr/U9v8Ju0CYYmp050?=
 =?us-ascii?Q?0PX8vpTd46zRScM6HhytoU7vd96QbD7Dcg0YsyZjfhIsWWEsiU9jB5sW6jAP?=
 =?us-ascii?Q?D7UkroFG9qSSWhX73pf2zJSmcjB1svOdibJR3VQi00KmK0ZjlpU+GPGpmks3?=
 =?us-ascii?Q?VVxAl2hIYQ9kDVnp63/FA/iPaMpRW/xvVgUgK060TzxN9p8g56ZDXIAi4i1U?=
 =?us-ascii?Q?qQAyK6nZlXJDP7D+n5NlPnNVUTAQ3Fm2xNyoJ3pabNR3WNmW4cyzmSmuR0fW?=
 =?us-ascii?Q?E2igVbcAMuPJd52qA3poSgze15MzP/Fn78xvML8K0vQGjPMZAAXxxuO2BOyP?=
 =?us-ascii?Q?Xst+L4lDcPjS10vG+mEGPtTCOYLzd6H9gVeSlLAfvRfy98mS4X8czELZYT8v?=
 =?us-ascii?Q?38n7YeabYkGSmBXDhIc4cjOmDOq45rcKv28RVVTpozIqnWNZOaJim8IDuXJw?=
 =?us-ascii?Q?8RbxK1W9hsObSaNW7OKatbko+9PVSl/XDI00OJkzlzOb/ZxG4wNf4OGpjFUd?=
 =?us-ascii?Q?n3J65V+LNIO6EjA/YVmoKt8oQOioaSQue/IdqMtcQBaGPhsGu/EvaJ6JQaBC?=
 =?us-ascii?Q?FcvDn5EKhcUQcqpado/ZVnVQPipDZq03eTWy5TWX/GyDT0olLvjM1BGiJkX1?=
 =?us-ascii?Q?8J467/lEnbaKAEopxq1X2ieBFSrk2W8dWcfspdrsitnOx3rm5fCnZmQJg0m9?=
 =?us-ascii?Q?1gRyIYYZyczTIr99zxLqPxDELusVFwpANoEVKTLKD2u8WkX/9pQFYL8GaB/X?=
 =?us-ascii?Q?rWvfu5JqTLzLf8DaEwdiM09uv5QiAJpoyT72AQ5FmHXyNRnLq7GTjJIJihLQ?=
 =?us-ascii?Q?91K1EZIIkU41l4gldIGSGwloKj+IEmHDZ4DSrc1Rltsxxl488sXgcJJFpLlj?=
 =?us-ascii?Q?ShUS4kxXlHXBU1l5N6ZybHXTyMDpSFGxqqH/j6gBuHYSGcVis0WSrtB+ae21?=
 =?us-ascii?Q?pWVz2n/eIj8xgwbmdYJ3b5McLG06ibaRGmWIGNtmS3O6z4qEtSOEe2eaL+sr?=
 =?us-ascii?Q?h//SGE+Pk37CvbzjX0GgC5oEJ6EEEDeBuRK5QdjWTOSB1O1eZLjoER+Whu/C?=
 =?us-ascii?Q?UCZdwrU/m/Kwl00s5ebMEvIdZ3pO2UowCJ4LxnzrPvSjELUXVKK914ZpttlD?=
 =?us-ascii?Q?M+91vJEMws9PgAeK8yS6ednbtIZcK/aMcdO+EjwJZeiAPhGPl7SZA5Y6QfG9?=
 =?us-ascii?Q?dAa1FIOZY5C0FtLwACE3UZ27aqUXHlUnADyGiFy15dqdHfxerOIvoOB2UEQ+?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u5qfxalWMjWgmUARZZhEnfz6dWejrh1fNXawfIdbdwyLEyyieW6DveNRMdLt?=
 =?us-ascii?Q?1KeCsRno/eCar08bAUN9nBMalVzNZoHlxG3w6iyoreqyezekBD0OWX0MkDse?=
 =?us-ascii?Q?HNhuF0ngeldOSg1sAx/TC2tkZTk1DeI30lihgbsQDPZvfz2K8+NgZ76dlmhl?=
 =?us-ascii?Q?tmogkDAC0F9tLccuZrmyxwUqLEpMux7Ue1Wd7k2BggDKoOjK1aiaBuS+mg6m?=
 =?us-ascii?Q?r6fMvftiBfIiSrkhQKhm1vIyPwMz3qjuRZc562ftsJuxU4mQjoCLo9cYutFP?=
 =?us-ascii?Q?usALSFW2fpSYg9jMbOJ1/KY/OEoLjyzMJ7jjiDB/qWXiIlIVrnWaaiX3hFtZ?=
 =?us-ascii?Q?FFRahy/CsWNxYZZjz5triiDfUV74F/uRv7ESI/tJJG3TyCzB2BPgg2QKxGtP?=
 =?us-ascii?Q?19/sODaEHu1zBG3374iSSk/ZiJWep05DtAvdcqhbq5jg3E4jMjH9PuH8xSZT?=
 =?us-ascii?Q?JWFRnI/gtuSnUMnwYZwyDj6e/hYg34V6a34J4WnrWkEN9g4TjbO9Ht4Rcpbi?=
 =?us-ascii?Q?1bDvkfN2TMPGrbF110U4U2iNQ9vOpOwJFZc9/x6N6yIbAFRTp7B2z6qPs5Mh?=
 =?us-ascii?Q?UmA2g5u3plhY+F2TtGitP5Yp+1yvhsnOK4+ijzLX6L9qU/a8jb8mGAjJ5y3C?=
 =?us-ascii?Q?xFJYsO0lbHKJwc9tRwR6407DDnz73KSEjGoQc26lodg1TYBdt2Od9ZaCcgTH?=
 =?us-ascii?Q?66mZebbq9nNaeovz+o5eigiaW103xkHXv8WXiQB0EjLKevGxFcPU934mj0cS?=
 =?us-ascii?Q?P36yj2nqJImnDwgX1ZybW0PImfa/F1fQKNmBkTw6lPzLwo+I65TyujCjsdHP?=
 =?us-ascii?Q?qpmDavzOtVhr+dALHVITyIpuUWh0h+hE9sfRR131LbVCYdZVLiSnSyFsiaYT?=
 =?us-ascii?Q?2tRVB+zRDHgjxHBKpjHN6Z7jMm/5lKIqgqWv2txneHFwGzYcx7GUeUD2tAhP?=
 =?us-ascii?Q?Szo9uSuP0USlIkT4ZDqyh7/3V3B1o780YanXSbmnjJGx13l0uGg65DsD3NxA?=
 =?us-ascii?Q?VUXGri3GwJXsEMIopalLyWHNCoIYL2XV/3xDJLRGjMIJfiSW+GEif4AHd0HI?=
 =?us-ascii?Q?eAK4ptGbX4VMhIm1ulhr1+te1wKtusRgXIHBpULCkKpAXcDT7tw5orUVT5sd?=
 =?us-ascii?Q?zeFXeKBFebDA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0402ffc9-e9d1-489e-0f70-08db4c05bc35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:32.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqvcAysLVjjI9nC1zAtSqtpYAfL26fxRNNYjBBDb9NueV7UuPfXzF1UioUk08HboMLMLOqXfaoMzMLggB2HUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: XS2DdTNHYUWUBlfQk_oz1cvgpYwuSfNO
X-Proofpoint-ORIG-GUID: XS2DdTNHYUWUBlfQk_oz1cvgpYwuSfNO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support providing info on atomic write unit min and max.

Darrick Wong originally authored this change.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 24718adb3c16..e542077704aa 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -614,6 +614,16 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+			struct block_device	*bdev = target->bt_bdev;
+
+			stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
+			stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);
+			stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+			stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+			stat->result_mask |= STATX_WRITE_ATOMIC;
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1

