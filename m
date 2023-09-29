Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F207B308A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjI2Kdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjI2KdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:33:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8113F1BDF;
        Fri, 29 Sep 2023 03:31:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9STr022442;
        Fri, 29 Sep 2023 10:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=m+7AvDx9yW5qI8bkPF30T94MYRbkTwt6XcN/+CgEjBs=;
 b=hXrzUSF01iMuOB07c8YlFZsTNu7UySaJm4IKKM0jGIxJbPkoQSYEN93eS4Ic3De2wD3/
 2WiS/BqUkZ16AyAOdwytA1qCRD8Ep+6l/ILug0oi5fVh9cEfcQ7jTwTav0J4ES0jxd5v
 pkpU6CrcgqTAJTee+gGF3cR3qIBKPFZklMFMb8H+f2abeTFo881zrpFlJ0UwL0nKDwRV
 zHzafiikU8GanzKGw9Gh/e4n9HnMeNECC/jg+DdgadwfFxnOEaomwPvOQM/4ooINo+BX
 I+chWtTws8p8BHunD7McCq3WipMHnr8y7uRl0wkx1Q0RCAYcgCId/VbN7h5wiB62DAxx Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbpbr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOE015821;
        Fri, 29 Sep 2023 10:28:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBzIpqvO/ALLBkPujpMZGIEIhRbKVUPPCb0AIqobEr06V/CHyMaV2Kvd9vrqCYkGti1QxdBZ1yfD7OFnCt9ST0Oa7c8WzJypX+Se6tD5ej8KBt9XbHvgKbjAOkwtZdZED4BTL/IP6VuEO0gshU4CqIPgSPhRY+EG60jVbGaeg0IpqHC/NinCSr6obgtoOjklZJl+4tYUVNO16Ene7yudlHEUofUBsXPOb9nduuKixIATXt3Z8puLHtpPr0zBxj+/4YxdA4ougZ8RLoP64EJPN8JDVITzhUBnmh6/eNpWgyuQibH6W7kNRkwYuVRDgaGrOaNC5WQdb/gt1pm5SYPzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+7AvDx9yW5qI8bkPF30T94MYRbkTwt6XcN/+CgEjBs=;
 b=M+TwEOXp9nt0hyB4lMG07DGbRe9HDiMSKS7EeiMrnQj8yMr6kW90fTtgjC3WguAhceQsx9ueDWeyDSJLc+fcCcb0tGbymW24MFa9ftcf5inBUguNcqWUMVicGx7UWeznoYjzUUqMyJGIaEiPiS1ruUbow5yDlH7Du0xQ6KmVpeYXYZSEbE41nhF3CRQWWy5mhuzTsNzgoDXvbjnrPkti23P7eYRgGg8fHjbPqMtZqbUh2qmV6iyQYWBdI4ipMc99/uGNkXlEi+esyVMwfKyDx/d1GpvRkD32CLgktVnP49czs1hm7yHBjFe8wZFGsvOFMtgpDMEqUmanGVQAFFFGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+7AvDx9yW5qI8bkPF30T94MYRbkTwt6XcN/+CgEjBs=;
 b=wY8oKXGn/f3L0f9X7SdTq8BQv7VoobwJswoElyfCNEbOqS3+kMI69QgsRiuUILhjHcbOQGm8IRRckpKTKxynXpkmLOG169ExHJ6Zj9nePwS2JDMR3EJv4MTW8zE8DCuEEKgMGdX3pa3rE8RbbYnLDQ5E4lZJ6ldq0Pw405yFzrY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:21 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 11/21] fs: xfs: Don't use low-space allocator for alignment > 1
Date:   Fri, 29 Sep 2023 10:27:16 +0000
Message-Id: <20230929102726.2985188-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ac4eb9-bb30-46dd-6a95-08dbc0d6cdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Syg2bljJJIPtyHffVkRlpnM6YCFzxI8gtT76q22TxP4Txw+PQqcFX/g74rPy5Bbrmn7S29IBl6JENmABUt67NKV2WSJ6y0eXw2EOAlr/tq3ygnrwCCRphZ8VZFxW8X1OoQJCUqy9Tuf9Qup9+F0LRjsvtZYmGNU5x4O3SdwVVXC9FhRPQYIP0ClqB9mC1NLb5BXYSq3lKWr0EeYO0DlD3ZKgGz1/j8g0TSi8epCe4GommMUXhGi4NJp/dW650FuOEkHDV6DMcqJkxmHxuc3QaY+yagOzfV9loMSeG0TxagSC8DYn7y/L87ULphl3TVsV/PdBH6/JCvzsiCb7K5VjpsIzlc0zZc7y+YQfUdkWMrPDUJxbbjB6J75OlSJ08MhsWMA9hF6YbwD/yTcsd5rZukAwRQHTgm8dLqXQL2rijvurlNPBd0fhAaJri/LGO+BPoZxQP9bX1ZNK9kfq1W7mPGDVthWYez4jirDxgZyxLYlsuMV/g+BqdDO5rK7CFfKgNoQN9UdzibFP4rJPf+sgypeinDOs+hZ1mbaCxyfF3YihtOuhBqWPxwBvM375+u6HyYK3RhYMT3YClIBVOU47RE/wV0BTDjjx2VDimY/Ev34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(4744005)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+I6qjqLuj6cGynD5FlYFq++A1oXkLy2gyLMvGALXBDkVm7CHegOg/K2aDwn?=
 =?us-ascii?Q?Pp/Cb7yJMuHzG9C19YRqc/lPQB49sMzyfXvDi8efzgETI5gsa1/Ww8atdw9C?=
 =?us-ascii?Q?zo2PUplRCmIggao/x+HBBMnM859eziz4kK7LPUN6UA2qzwhTPw++CqHluo4S?=
 =?us-ascii?Q?dHg7WdfeW5nPjQzPcIm0tcdnXQui1wd00I8W5zUN3CtmOIKvGrL6jD1zZy+D?=
 =?us-ascii?Q?8LYwSih5sz4I195v56u8CexC00I2mN0QZqsrOXLpGEXY92fWQ+yMNaQr1gKs?=
 =?us-ascii?Q?AZ8A4FD0QKDdCymNwHcrbL5oouqZ0r7XoEL5Ksc47kXkEuBTjG1+/SuhV+GM?=
 =?us-ascii?Q?/YWq0+QFEh3lzafYP5co7FKuaoLA3FumBXGLs38StK49icJKImSUX8vxl3MG?=
 =?us-ascii?Q?1gwqW9aI1pNMW62zS38++5bN+YutxIyG392Vkeo0BCY49Yq/lj6gWEzRI6ct?=
 =?us-ascii?Q?dNHt7fkUg+nxqCCLu8cAHlO304nkPIwaAXEM8/t8aY2DLHKMplAnPAYrxu8d?=
 =?us-ascii?Q?l2XHnn8rViQehhxxcxEY794facQ3DC6NWg7OonMIhmoq5Hc544NMifLQgFgT?=
 =?us-ascii?Q?1wSuKghF2if4mG0pvMBnaBN2DskSSSlNDC0cKBgyEt6SIxrV1kqRk2uETd9K?=
 =?us-ascii?Q?Jq8hWxda20RYep0TjUh8vvcH1jRp0rekOzcMbLul/J69/uUYdli+14EHhkP0?=
 =?us-ascii?Q?+X4HfzTel6gaw/NU/1cl/wF2qOOgJkQu98FOQLFwNKYGVAPXg5m6Wco++RWJ?=
 =?us-ascii?Q?BapuzoOs/OSQwVo/pL7od79O3yAeL3TKJ/d4LSaZyL6imwTyftQyic/Kx3Kr?=
 =?us-ascii?Q?3z54aFnlezA3BTDSAILmhKPBKq8bT8uYnAd/1cqdMZiGtNqID0y+6lyN2ZZb?=
 =?us-ascii?Q?g8KJlCAeyRYDlQAsBwIVzl3u5DIblSRnvxpikp3aqaX/ZBNo9K14TuHV1ol1?=
 =?us-ascii?Q?JubppNHywhbOSsAhEiQYXrofKb4zNKubpdK5UY6Hnom5X6g9rvxQs3ZfFLS5?=
 =?us-ascii?Q?pEOPNcrzYg8NebHw5liTw+oV8tJLTvX8M4wYFf5Q6AOHEshNj6qhuIM0+K9q?=
 =?us-ascii?Q?HUnYtxIFx6tfuCT6efKPMbP/fswC9IZdhod1vzzjUk13lkgv67fwZDQwPPSF?=
 =?us-ascii?Q?25F5WKjS7eCGzQWm+XdU6ln0ywPCTvoOrSeL3+2XBl6WjpXlDmeEXsypRRNR?=
 =?us-ascii?Q?yV/bz/R2nGnf3TQTzPdj3j7FSgANRysEASk1H+lXUmYOz6ghjGrdJDDi0zMe?=
 =?us-ascii?Q?qDWgwJVgUV9jaw/WLplzrQrnGR/uJT4a6OO4KOXBN/JsfyTjMVK57eMh93yt?=
 =?us-ascii?Q?JXIsSUbvhf8AAPeeoNPX0fwuPgfmj0nEXiu73ywnlyna7RquAISwZiW1Wq2O?=
 =?us-ascii?Q?Ry8ds145RbSBlxIGYLoggxnIXpF9UzwWoSN71FZgTEFNo/66XOLZTsezHJYh?=
 =?us-ascii?Q?EK0sTUtgkcO4b0SBn0pqZr9ZQuUT3zFMwLmkb7RnRvlTAKuEd86UgyGKgcJ+?=
 =?us-ascii?Q?H9gt8ubvQ67g7ul7XmfYKQJTFYK//79vC3hfoKyXLgjWrb00tXKHxVA7FCqL?=
 =?us-ascii?Q?fL+tQvPH/LZQ80Mn8jK7AFtUMelvpiw75pOfyzoLyCstL4XMYAMpJ1LSzRIp?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6n7dxd7pEbhCob6lw2hS3ik0OqAfPm+Gkuu5mG92s5hCWDC50jyyJ4tx5vRb?=
 =?us-ascii?Q?tvYwRIPwx0g5OTEbr41kq4LLTnpMedzdRpvpLFxUj+Mnyj8Z86Kbs6U+uTfp?=
 =?us-ascii?Q?dpLzihgy3fUSoNAdfqsx4qLs8gF/9epdrXtHq/gIA2puTn10P329a3kC8Uhd?=
 =?us-ascii?Q?pbJM23zET9gIcYtEjR2YdkKQR2nK/j3V7FXIG8ViJa8ftTpZ6MojksbIcEP+?=
 =?us-ascii?Q?g13gP5E2hvbtFbctMWkyuiF2aVvluy8K/KC1rHpaWMG4tooX/2O0KezD3JUs?=
 =?us-ascii?Q?kzVY/DAFHcFSlmKPmcvUKZr0mNF9OoUj8z4AID+y6RKPi8BW3J6xl7xTxxG5?=
 =?us-ascii?Q?baOqtNLPJZ6AP3+FJBel2yqZjDeD0+mxt9ZfRy8X9wArzXN16ZI3hdATT1JJ?=
 =?us-ascii?Q?ZW8jxCIyoRqlzkRIE6AqavhL8B8+wS4ns3gTQeGqzgKUciIaeinDuWsVQY5a?=
 =?us-ascii?Q?HC++botV3XhNSmpmuKfWt6c5mY3BNggk2TovTadYZriEPncGrhq8HZQxUNBi?=
 =?us-ascii?Q?UqpQnwLUXy2+22TI5Yl1nei3w400uuR0okye4oUt9f9nWrfxdBiFWS0tFMPK?=
 =?us-ascii?Q?Ugpye2Dz3BWJzqifiMPHv6H7k+uaA6i2nK8GwDqeAXEvAgxeu+mqSETsylDa?=
 =?us-ascii?Q?uP/P5kJ/JnVTl057sPZbg+uh3UZdFL9Nkw4fQP8oj1Zss9u1NuXjYOm0kBMP?=
 =?us-ascii?Q?lxCmgHtJZpI6EKocd8auaOQIFhqpA3PvBiRhj8ZKxSFlnMgz+Gwub52bxo37?=
 =?us-ascii?Q?/ebFcjsW8ZT3vCYKjayl9M4YPe2LDMxtUUXpW6vwWQ329dHod+ypFIf+9pLY?=
 =?us-ascii?Q?y6F5/eesdsiQage8JqdMFGWUNFnYckRZ9tEO6TIFWJ4VDPcl6cBGgF0MnliI?=
 =?us-ascii?Q?J+hSvC6kHQSZEduJt4pClcAYXvJkQJc+N3skkTgr8QjCRL82PjfHpoP8Y4b+?=
 =?us-ascii?Q?EmfCPIVSvNeRYZlzWSqVv3G250wGElb0U21j2As5Hqg6d5Jk7k2GaBYN32PJ?=
 =?us-ascii?Q?/62yNTypaaPWZJ24OTNOESwhmMKpu+VpUbfz2hJ0lvg7gMYGO6vGZMi9pdEo?=
 =?us-ascii?Q?6ULij747HhmRoiR4CeTMFB821uuGfA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ac4eb9-bb30-46dd-6a95-08dbc0d6cdfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:21.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WuKUfrgiUZQCbf1zQI5Er2jw9v6yfZfJoJ36mZKPomh5kf4TVgrm1cEzyihuWAshGyDG/uYMtRjRGHjOZUBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-GUID: 7BWe1edzjEANjQfNHNqdqNIe3xLjJes-
X-Proofpoint-ORIG-GUID: 7BWe1edzjEANjQfNHNqdqNIe3xLjJes-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The low-space allocator doesn't honour the alignment requirement, so don't
attempt to even use it (when we have an alignment requirement).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 30c931b38853..328134c22104 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	/* The allocator doesn't honour args->alignment */
+	if (args->alignment > 1)
+		return 0;
+
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-- 
2.31.1

