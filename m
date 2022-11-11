Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46B626424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiKKWGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiKKWGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:06:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485302FC35;
        Fri, 11 Nov 2022 14:06:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomD4025514;
        Fri, 11 Nov 2022 22:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5rHfjL80hkEWJJ8TtU2m1j211+gxM+i3Jb8Tj0l95VU=;
 b=FTJMI9tN53yZPC4u1/hWBe1chnw1KJ1Uq1D1w3h5c+HsMpsmwTmgHFN571HBQnWqxQSG
 iUJ8wk4yT0N11u/8j8QTooUH5o3NleixUUZvcRcrdQPg8QNMIeq+C1TvnyaJWFsB2Uxd
 D42rv/UbwsryXgTxVz+3IMO1Z6BecQbKe61IdxpWVl9Vum26/bcLT4zTPW4/vVzsWEME
 JJZeccBSt9rucCe2ybazzZ7N3X/n15PvB49qS76KDUrLQyt3Q5tuoeswL2U7looK28Fx
 alnevECa/nBBrxNo30Mtw+4Kdehje9czVN2RIP400wNkFKDz1FOXi/CHbE7adq+YX4Bo pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr12x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABKlp0C021549;
        Fri, 11 Nov 2022 22:06:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq6v65q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obbd4O4XqcXrjLTb+72AlQTkvnHvMHIJfRL6CTsjeEw63c1pqU5ubuFFU1UwjvXkWjnK+LqTw4VyC1ZGBR/io/7lWqQPZK23QP5QJSQ/G69aNhW8bhgennNMfMmQaI+Xi6n5trcZMk5/YLeiPR74j7LihqM8TCYAiV2OXsk/8OO05NSGZtmypZV3Gn1MQxtWwncAuNjyh3OI1PqknCfOsruKEKHRUooQ67r7EdLWYQZiLK7opOGQ2J7gOxSnXIrrx+wt40EZgR2Qg+n3STzbNcjUL1y0fEokl7MQjsloIgdkGoAifpF0cc6WED6ZsH14D5nTNzeNqooQ1rLd8+6pzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rHfjL80hkEWJJ8TtU2m1j211+gxM+i3Jb8Tj0l95VU=;
 b=DqGBL4AOAHJpnJ3EzpqcKFTrYq7inGPXpP09jzvVvw2lKxDEjOoLGK4WFwiX2cYYm58NWZEpVpmPZYQvBQmSTUzXXJeN6HPSryso4I+qqJH3BiSt1TDzXp6W9R70wbv2SPNBSzrNnplpDWkBq4Q6ZAXpwGOOkLkDWEmAdJ4dHHmzjFLHhqKeGWbM1axQZowoIno0dsVN4fyKQCY8ZmMn2FQMRyVoq569aL7YX3fQu7HIItFt2nvOfKTlawj0d9yLfCGBdgMzMqPvYi+t/sedoE9Ck9tmTAaHi6cfiAO401YdauDopZmvzj5e/k6jt9bW6S9Cg3LGLTrz1PLwRjremA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rHfjL80hkEWJJ8TtU2m1j211+gxM+i3Jb8Tj0l95VU=;
 b=U01iN+B3F3EICuVw1Yn7hAVFCEpt59T0A+6wl/dZ+E9hadagp1g34UHDv4QFWHdue2+W5nHfUf0YhS89Qx7wW3R6u1HWKNYIo5df+OEuHgpmThDFZhsUGcYI/0dl5WDReSRZYlgg61k3ASLmyUMhqAaBTtOZ+tpyAzTqGn1lSXU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 22:06:16 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:06:16 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 0/5] fsnotify: fix softlockups iterating over d_subdirs
Date:   Fri, 11 Nov 2022 14:06:09 -0800
Message-Id: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::13) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: fa412697-3c7d-45c2-53c6-08dac430f430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6mAy7BMXp/qaZimTjCDzUxfIC9SgPCG1GZUsDwcQIoppAsFtTFQHkougtvvraVAUTkvjUVmVkoOfdSspqnXC19/ypk6tTmdS+qHe2OXbl4SRHpGcSxynJySaTwp0ejRXKpcsSKXniBn4LY2Bv6goGYSmEP42B2Ep5Cdp4Hkxx+hn9TF8ahSPx3m1Tdw+bMdiaLGzMqFqFT2FlA85JgasMwauI4FEExgPRB+kbGU33jhBoeV7/sWrKFa72jsHsXNLqfvh0PsON7vv2iqcPFjkIz49DbofzVKr7a6iEVZXqdUYA/RIn1u/QlNlyvlMDyQJpT8IVSGVNBJdJepKFSQdKkTFCDFqdzgGSGFVMDxyxyPUA+4aRL3uEy8yg2IhBiblNJk/06kdTzIn7JzApMRxuHGaWi/Vn9L/4UBQnYxxW/1HzRMxG6s8CjjP73pqRtbKb+M3MFKAwzLNqkH7CTm6Vqnf7IP+HDC9r7Zms7YuRoIOwJLrNtiq5ri/hCKLHO1S+kifrpJMUKsihulMxm6FkcbO01zL+fO9RTf/BezHBim2c20MLJzrW/zWnWs3giRLKVKuBDNw7oYCuESe2BKPcYVgjaTyk0KJffaJY+dEhevnwIfzvOp0ivxgiRdx/kqTmuPL6n48Cc/DsSe2iir9MMUu0xd9VZXJV6CdCVM6PhWS2HOTxxmasnwUjdVZ+knrfx0yePmZnXzJS+I0tx3/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(83380400001)(103116003)(38100700002)(66946007)(2906002)(8936002)(5660300002)(4326008)(8676002)(66476007)(41300700001)(186003)(6506007)(26005)(1076003)(66556008)(6512007)(6666004)(54906003)(2616005)(6916009)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q2pVPbX8UUKVddzcU2NWTU1nL5xbXR6sJ7+UQ2hEGVryZTo68o0lnuJF2GvJ?=
 =?us-ascii?Q?HDyecd5p6b80GsmIaqdXH9PIfYKPIFwOp8dnz4rvIzX45ZyK364zeJsrzGsC?=
 =?us-ascii?Q?iCQ/0yo6gkqTnnXADGD7Mku0ut8jSkNzSWrofD6TaaauqXtOqrcmDSZNJL/I?=
 =?us-ascii?Q?Hp9Iw9WSBXu05djPy94XGZJXNsS6EcVzyE28oRNmMGtroKNQw/hA/v0/oYyS?=
 =?us-ascii?Q?J1+5tZsh+gAYmjS5A8O5nmOQ1OOg1yOr8K8khDKVjhwjj216UCZHXYrUb0h0?=
 =?us-ascii?Q?W+/njUukMGI++s+PaDq91kKLV/dMSb7OwHv/dFp/atHAsMMizkhQxfrAqSCk?=
 =?us-ascii?Q?NuL8yIxcjq3S3vjJZMO54egaa64u+kpFE+XAkQb3ZfrvfdQzieGqLHaloml9?=
 =?us-ascii?Q?/m0LZar3pIq0p+zvnfpsJU4+w5pi2eY2PxbbItBV6Gw7lz4CdgN6efmfo3eZ?=
 =?us-ascii?Q?S3rzODwQ23yT4XlcHfkIdyIuJdDJSGBfIHh2xMpr3fWQiVzdT8gQNuUIfSGI?=
 =?us-ascii?Q?gp65slvxeLk71zoLDIs+y/MbwM5hvanV1PzjY6puZ+BfGJ/i7D6u7jA0pUHZ?=
 =?us-ascii?Q?szy7OClRsqLeoTO2P+AatCpajPg0WasmRoP8A0/RnnYz4SzUbCcPHcvHz6d0?=
 =?us-ascii?Q?Enue0P4R4a7vx5Obpo44pqlcQAkbGM1EsaTAhGIdfEuytbk7h/0aiEndMV+R?=
 =?us-ascii?Q?V8FaiWvuGJCQsGglaatzG5AW16+XhSQVW6UNMYlmr6ptlo+/MY4TO9j53ZIh?=
 =?us-ascii?Q?B3oI9+XMu5YMlLFoD6T8If9/Wv02oXYW577k2Ykc0/qHlBcY7xqJHd+hvJcG?=
 =?us-ascii?Q?z/XbOCWkjSYopwhwWK+8ATYbVcP5FSP5+J7WRZhkAKzEVKktZUwd7fqQ30P+?=
 =?us-ascii?Q?m9v5chTjwl559BN23XTYuYH9aPnAkkcRmz8rNZw+UQ88jtkcumjaUkA32ZTU?=
 =?us-ascii?Q?JEpTjjDvb6ZvZb3s5vYTT0Lc13Caq8HTEkzz1gvZy1ECJBNjgd/6ls81nvKO?=
 =?us-ascii?Q?95evUv0xDkXwG1jgxJt6lBAPXMLZZlLlx5Ef4Smorl5eNFjXjrzV9bBfAw8U?=
 =?us-ascii?Q?Y4qS7apOtC+QtGqbWPixEW5cdcqhq/jzKJ4EEkTMkFx6vQwvipAtDV9LwXb8?=
 =?us-ascii?Q?8NA7w5iAhMwLnSfa8RKjfsGZoqQFIgDhTvO8FgqCmUCH7dfbeAaYeQQGy+Ps?=
 =?us-ascii?Q?4QRO0wAKHiSonPKBVk6250Gu2L+SmlSnPFx7to/1KLJ0u1s8WRpvnqDOpEs2?=
 =?us-ascii?Q?r9DpURzxxA0qtlL9QauFTggBTn1+pSBk5FCDRmWGJGeQ+QQE3tH7vHquhWoG?=
 =?us-ascii?Q?dYcrxLUyqP1C8ksSolHZI4OQXaRODWOVxv8A9VbatjFdaGLURTzQRzZUR86f?=
 =?us-ascii?Q?++3BiIbs1hh6RT/9qUUwF3wHfq9TxiVPjCn9GS77FR9zWCb+yXZF92tJ6q9p?=
 =?us-ascii?Q?h71m7cF82ppY0ZX9A9ucPUJxldZ/6zLaDMxNoGM44cD0xvHv0FVaZyNd44Tk?=
 =?us-ascii?Q?edqchghCCzXrvAUvgz0mTkjuS+66Qr9thYnRQaidUMJ742hF8hrz9ebBhJ2A?=
 =?us-ascii?Q?U47XnZ9FuOqijn2jjEIo6NytYczdE8FmlN6Fz0PtMSFbo/5B+Oo2iDxJdeRw?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: itNf0Ho6ipv1Fohe45jSnKleU3x4hv/MUAfQ7LiGe1Yn+v58Rq7Z+CW00i+7XMqmP85X6cHZKruLtxwny88IhAzngBFs3PQNoNXPprO0OpEBZ+SqjZy7ESkD1NVhZNI05kL+2penycsVoGN3z/bFq9HlbZlozVsTvOu5KoD4PGPzKyNtDY/xHfcb+qkWtNNwj+CpMFjKes7X5/nfTKDKZ/KJtgqlWA4LrJNclUUNnquWlMMgfwLx5Fij9ymh+WHW/XzfYYsrZit5Xz8CuCuIKAlv+NLXWcDBhnin8+KZev3JZx7sL0NzgxJXPqw+LAGEUOuWzOskFjvF5La49JRpxRvaVCH6xGgbQvHa02goDM683tVT0mtQJiWdDHoneGpjp/DuMthMecPOc4Dy08qUenDGqUqh910G8mV6vm3VHDeUK4YxMnvXcq/4yBkvgiGoFCtvEK7aW9zq9uWbhdnW9NV0YmYtXDagn2dqTx4LMMLrc37Jl0dLVQc9AnuwW0c2fbwjm0tMPiVgI8VDNZoFim7km0CUUEPVvnhVkpWPYznAxwlQh3VFnrdREAwA8GdQfT4e8TyzRfIs3od9j/grLKfx7NMAQLjMLMQPhhJnuiFR2uipQF+2aCKfqsd+cm8PU/qtuBsKzjmKEyGnMzp3W775nMPApiQ4WLCqerDhkm2UmkvROKbFVJPO0JMuo/xJUmqYdKc1x2Y6tEh5S+TPBA/ZCpLRMjkGefZjUxIsA5+pI9Ti2Twl45jYN8r+JGAAo5xAFiJAH/ZE7dCQEwD8a+ko0gXt+mLYe0BJmoycVm0v302KTEfAKtUFvNJXh1pOQ6E6IxhKUQGFK0dtV5hiwT3bWSj/ROEceHHlZOiGxt5lLzvmFY3dvb5vYyQezjdIgu8ccx89OE2kRhasW4qoSg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa412697-3c7d-45c2-53c6-08dac430f430
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:06:16.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVkQUr1LtgXyhplUMggJPzIUpvc7ldDEOe9pSVxWT2hjB0N33qBig5xtz3iiX410jxfMylh44eJ18Uua7WjqggYnKh7F48ifWNKFf0OO+AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110149
X-Proofpoint-GUID: XtxHTjlB0mSKn9yIgOE1_uUkdtLdhKp6
X-Proofpoint-ORIG-GUID: XtxHTjlB0mSKn9yIgOE1_uUkdtLdhKp6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan, Amir, Al,

Here's my v4 patch series that aims to eliminate soft lockups when updating
dentry flags in fsnotify. I've incorporated Jan's suggestion of simply
allowing the flag to be lazily cleared in the fsnotify_parent() function,
via Amir's patch. This allowed me to drop patch #2 from my previous series
(fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem). I
replaced it with "fsnotify: require inode lock held during child flag
update", patch #5 in this series. I also added "dnotify: move
fsnotify_recalc_mask() outside spinlock" to address the sleep-during-atomic
issues with dnotify.

Jan expressed concerns about lock ordering of the inode rwsem with the
fsnotify group mutex. I built this with lockdep enabled (see below for the
lock debugging .config section -- I'm not too familiar with lockdep so I
wanted a sanity check). I ran all the fanotify, inotify, and dnotify tests
I could find in LTP, with no lockdep splats to be found. I don't know that
this can completely satisfy the concerns about lock ordering: I'm reading
through the code to better understand the concern about "the removal of
oneshot mark during modify event generation". But I'm encouraged by the
LTP+lockdep results.

I also went ahead and did my negative dentry oriented testing. Of course
the fsnotify_parent() issue is fully resolved, and when I tested several
processes all using inotifywait on the same directory full of negative
dentries, I was able to use ftrace to confirm that
fsnotify_update_children_dentry_flags() was called exactly once for all
processes. No softlockups occurred!

I originally wrote this series to make the last patch (#5) optional: if for
some reason we didn't think it was necessary to hold the inode rwsem, then
we could omit it -- the main penalty being the race condition described in
the patch description. I tested without the last patch and LTP passed also
with lockdep enabled, but of course when multiple tasks did an inotifywait
on the same directory (with many negative dentries) only the first waited
for the flag updates, the rest of the tasks immediately returned despite
the flags not being ready.

I agree with Amir that as long as the lock ordering is fine, we should keep
patch #5. And if that's the case, I can reorder the series a bit to make it
a bit more logical, and eliminate logic in
fsnotify_update_children_dentry_flags() for handling d_move/cursor races,
which I promptly delete later in the series.

1. fsnotify: clear PARENT_WATCHED flags lazily
2. fsnotify: Use d_find_any_alias to get dentry associated with inode
3. dnotify: move fsnotify_recalc_mask() outside spinlock
4. fsnotify: require inode lock held during child flag update
5. fsnotify: allow sleepable child flag update

Thanks for continuing to read this series, I hope we're making progress
toward a simpler way to fix these scaling issues!

Stephen

Amir Goldstein (1):
  fsnotify: clear PARENT_WATCHED flags lazily

Stephen Brennan (4):
  fsnotify: Use d_find_any_alias to get dentry associated with inode
  dnotify: move fsnotify_recalc_mask() outside spinlock
  fsnotify: allow sleepable child flag update
  fsnotify: require inode lock held during child flag update

 fs/notify/dnotify/dnotify.c      |  28 ++++++---
 fs/notify/fsnotify.c             | 101 ++++++++++++++++++++++---------
 fs/notify/fsnotify.h             |   3 +-
 fs/notify/mark.c                 |  40 +++++++++++-
 include/linux/fsnotify_backend.h |   8 ++-
 5 files changed, 136 insertions(+), 44 deletions(-)

-- 
2.34.1

