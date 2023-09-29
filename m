Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53277B30CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjI2KoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjI2Kn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:43:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3D2D52;
        Fri, 29 Sep 2023 03:30:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9a4R023082;
        Fri, 29 Sep 2023 10:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tPL7+u6xDDgxB9EABLArA1FPAVoUubruW48wl7gOW+k=;
 b=xqZdfZdifjT6ibJpJSZbDYr5qvTlg2gEUzjUxZZ9dHUGtdWtQdBnuCbu6YgiCbFGjomy
 6NJsA9QULwnoCu12IzeebkW8lC/sLELFEuCi7hhpVAkAfOsdNDxRbR/o2GMeLvCSQxGK
 gUuFbhPzJIp61Bc47q7YpwGjS4UsOg6BimTCedhG+xYl68UJnn1eK18jwZd5BpKVLCZR
 v9axkT6CZYE9kKwVmQpXGlwP/mT88fbTJRR2W5pJfoPW5IcXmlvMt/r3aHf7sLFsw/s6
 jMPMUZBJ6wrjImynIy2UvTWFiXvflIuwlzPs9Qo85aKxuN7AyKhJGUANusH5Vr02UugU HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc6k58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TANkCA015849;
        Fri, 29 Sep 2023 10:28:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOZDnLPWl9B4jH7rbsRIYzK0nB78qFN6eXp/YWYDkEWXAIaTDgXqBtEig4q1Q1SHpKjmFAM70HuoJUvNqK+KEWkHPtY2LEPouZy1Q49t8JHhPiP2NKq/qg83NKaVy+8Rp9YuQFq4cMmdASzvjQOAmACnx3xN7X6TVPJ+yYG8Zau0hjk6wQzBEXEJPS7zKiFyMXTey88NtouNqkwkqEa5pO0BE6qEb/Zc5WCmr42EUXcfHocCRAN67KOzaK8ziCzrrQnnacclm+xmy/gBN0Hs62yNtAknx0FZALK7bGYVbq/pcJP6pgHbPlA/1v/xkJDcN6KL6qVBXqEPIImPFV/cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPL7+u6xDDgxB9EABLArA1FPAVoUubruW48wl7gOW+k=;
 b=EiRb1zexKxqDakp5cAFRtXZGg/q4Q6rnNqKn7FO3b9zqdPuBNkDnODqCEM0JTyDPzSrxV1pnbAz63Ul1l6NS+yubbuc9GLvBMnBVWRHxXQcBAYWHHk5rwc+elTawDgrfwhftHFXEc+gJIR9b9H4XlQr9CqAKDrBV9Sx+pxJp5byETPTPIwRsNZV5BwuGP1+zToZCkUFzWPjmqo0D70L8TmxhFVQ4+gUH/4gwH0ofhvCq1GECUczySOtZT4d115+z3Jab8hLv6ZtefLXg2pplt09WeffWpw9UAOia2qNpkQLWQQbyoTRzOM/aeuLhpgjTE1l3IXhWs85xc7W6x16T5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPL7+u6xDDgxB9EABLArA1FPAVoUubruW48wl7gOW+k=;
 b=yGTAlhB4yqyukV+OLvh2KNY3DGiplSm1pbF/tVWHQaLdpFP2JHZG6XUIAOSRG78Dz/XMeHmzkGbcnIzlPSWdbOSBBSOnnVbweV8Fzfb/lZAMSkwR04prsWaCwT2Uvy4+jMzCj0wu9qrzr1aKNyV2MoCUh3/u92kI+6BBWZeNYbk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:09 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 06/21] block: Pass blk_queue_get_max_sectors() a request pointer
Date:   Fri, 29 Sep 2023 10:27:11 +0000
Message-Id: <20230929102726.2985188-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:510:23d::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d98b4e-6d0e-4181-cc71-08dbc0d6c68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aehTGb2vUA3Xvgtlb/sMl9t1fMTrC6g+7Z57zoz/vM17IYuWwh7Z+PCd8xA6DNN8NynoIO5M8IarhYsjX5TPjHRZ1OcZbta5dwJvBDloikoYqvXKWpQyt6ZBotNGu2QIgrtxDwvVXoCLP3e7dsONK7csEC8fH1r3Gc5vg2ipzkoGNS6zvrz6X8Yrfsxh+m88YO+Xhim5Vde11/yMTqaAYcmKUtb/6CJ6Bnwh/ZRKeXDAEMLwP5v34FnF8G1CUeHoqpQdXjU9nKr794B+xxjGC1Sl6fgFVnKLoVOT2KS2n+5AyxH1AWwOZ9EZGqADeIu73502hZ7+WTMaAH9twkZL3sbK5wkUNkbUhlsTv7qBClP4iboHCv2MeNIlYOKqXas/f342o7Gh4+3XKtHU+Jp3uON2lAU3yBGzSRywXrNZCvzB6frADy/fP6gd2+4GeSRLkOvPU5XjTm7p8KEhN9fDp5aPRJnwYkzqbIIEZNrJf+cGgDgjAFdJnP5GPMoJp+M694GOTNzL7XtT5HYd1/+xx78pP3WPmGDpXLFG+lOKYJwrLESweZZwW/u33KWtrntAOYrLe9YRhiO9XQhntwlYGca1JSJZRuPMFj25beK/Qoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExUGDIH/EczFoc4lWrjlGLt6yKUu9fcBytJ03WDU54akgs1+J1lzD+Uy/B4s?=
 =?us-ascii?Q?+VKFUlHRKzIUF2fPWJ0RkODpNlJHIl4e0Teo2jpyQ7ApA37ymsgi8iOljfms?=
 =?us-ascii?Q?lOMF75PafQeHTwgnMVRZshn4yNBbiGfXBASpxsbWNrAR9zA+xNFToX0YLnWw?=
 =?us-ascii?Q?3zYsaErsAsMCyUYS+3wOvca+D+bSm0wtTZoYk8YbLkm3qnO3SyVfQouHF9dz?=
 =?us-ascii?Q?OTBhk2SZFgC0IhnfsWjbaMglMgYUJUiZwAuZ1Anf3xYsj+y4UH3oe5Ql6SsW?=
 =?us-ascii?Q?YfbxA+hdBGtiEZiqskA/rrqfGnphxzKFYdfKKyN4F43lkilkkP2rgO5KnEPQ?=
 =?us-ascii?Q?q98UpdbFPQ367cvygkD+HY/j019Sy5iwgNZY/gJ6SR9Ic8egnk7Et3OaG+1Z?=
 =?us-ascii?Q?CJvyWdOaIsqUZP0Vwgi4IdQwRFv5/BzrjWV+QOv7FJWc/77GkgvZskieIMxU?=
 =?us-ascii?Q?+b/AQeYvwPpoU6ZD92SKhXyBkkIBkHAX9dEPQibB4K+FFoOtXGCTGnfVL27p?=
 =?us-ascii?Q?cXEk4qoWvgmJhptvb/TckUsEqD+j7nxgv4wgMloeKgfZN+14J+3BWUOJ+ZhK?=
 =?us-ascii?Q?OaJrkXLT4DDEPREzdmMFZDiIm9DIMepr9KloKf1PW3Dwi2IFyKbN0yNdg70I?=
 =?us-ascii?Q?/uni2yBETn+qVaEpu2zlr0ivssFNinfKf83tqaeQqlk0OI3IYH958YzmRFn8?=
 =?us-ascii?Q?Z4GY2qCCGD/NMXIfZgGYf2I6iOcSJT2DcEQEduB+2RMPZAtAf0fLNVbRD2Uu?=
 =?us-ascii?Q?02eEuLm8ZdnmQhQVjFFZ5CRTXDIEwRiwi6hKIrGI9w8tW0JPkJBW/I1azE3c?=
 =?us-ascii?Q?7xlsTyqXucU/jhVR7kMvBmgT0Yg2sFDH6yeFwdUSyvgysKJX4ds240GsMpAf?=
 =?us-ascii?Q?d3akVn5iIjha8U4YAz9IW5zwrfkydPuS+L2Y+uwPndUX5ycqu/dyuBzQZase?=
 =?us-ascii?Q?2dZxxlV32YW3yt2TsZN1cTdIoe4ClDWVjQ/rTWEIICshx/7avfvGL8f6Hrkq?=
 =?us-ascii?Q?K0nLcVbWCWpID5+74yHTXcpFWS0RTFG4YPDbL9bo7wNqp6UQSSsdJ0PgUi9+?=
 =?us-ascii?Q?kZQNCXCEYzrVt3Ekz5N6gKWGp65k6hNCYz91pmS6baLVh5dHb2c6z3hytG8U?=
 =?us-ascii?Q?J3upb0Of+u8RKjYpaq5kr5fllo8YNgJOwP9EVXsZRJIL75/KaDSAV9LkpyvW?=
 =?us-ascii?Q?NwR6WgrjTvUp29xCfcZGhhDos3I9BEWNmcIr7G7AUtzdZ0PnqRVtb51pwynY?=
 =?us-ascii?Q?VX3wwbD/NZEKTEE4NuRmYUnegRonJYm3gK73nnxxe/0UzcDFnQg6cUWBPVVq?=
 =?us-ascii?Q?VrYSp20LEaF5vu4iMvynOqAFrTPJ7BSluioaLwmnFOeBocVFr6L2OJcHfo22?=
 =?us-ascii?Q?Z8KdpinGdWGb8zxVf/wdaqfObKAr9kpr0ksd29C5pUwLNkUpDKv1GBKnnt30?=
 =?us-ascii?Q?Rf8/EThzkjVZy4k0vgXy+uUbo+RbMQpI02DsJdBdz5RB/JA7pDDRkyfLq6ht?=
 =?us-ascii?Q?6xNNXT4zZkLvMmcecKuVlNXam+MZIvW+0JxPRi+1j+z6iS8phY+F2tWvDMmq?=
 =?us-ascii?Q?GtPwkP3Vc+T8ZN136+m6vjfcYDAVZSMDper2PP5nOqZrgfnx1qtZoun/WQo3?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?v4CRRh4k94ym5UGSOuJ1qR+KMZYInySTkpp6TOG9d2XE4+VR18z78T1E/6D0?=
 =?us-ascii?Q?HHcwsEaPxGYyAvvz0mXBAEg/DodABDBc8eDjlgV9Abjv0OnRN/fWyHgv7M0p?=
 =?us-ascii?Q?i+gGnvLYMAg/nxI1TJMxOhvMacZ+hsJhZUnrn6hFrMWQiORRBN55pal0DTKs?=
 =?us-ascii?Q?I62U8i5rfmfZxO89+8VUCvMA+K8JXOfJtXnewNzMK5g/Fbz2WcfptCjtr2VO?=
 =?us-ascii?Q?+b/so9aUN+Q7S61uz5og9vSQ1Ub68kMhtZNbPGKfK45M5ueCZ7s67QWic4+q?=
 =?us-ascii?Q?7vTsdmitNCdAJB3Duqqc87qjfaYrJmhIM9JPYOh2xG1U1ApLofOFaaeumTsc?=
 =?us-ascii?Q?fkjpGLSeUbfzgVOl2JPZfMaafgB1LMhIRh9ul7J54s53kvDFU9ktyWbEb0i8?=
 =?us-ascii?Q?JeFZuQpE203eUTJGWyJ7C6X3524p4oPSXJfp2pmPsm5V9ga0FaLxQV8nQxLz?=
 =?us-ascii?Q?2SWqLasbOzF5fgmmciyBeF8s+2nKHRWHAmYoeG/uN3MRwUnyK56bszQfIVAs?=
 =?us-ascii?Q?mKiT1PyTKltuCmeErZBINLgeT+VQlHkDgcz5G5uAL8Zq+5OBCmNM+QbJ6wm1?=
 =?us-ascii?Q?K4bCZEFRvo5buhBRWZXraq+mVK51XddcQ70rkP4wC761HORYvKvKiBKWYfCG?=
 =?us-ascii?Q?4+uN0W6xjQS8JaJBNR9Rjmb5Mgh5uBHJrW2sfpk2ZRhB9ieOZU+XMYhFLvqs?=
 =?us-ascii?Q?r1JolZp0iDGtzf4Sgl54s0id+/B4LoripvxC1kq2eORtzrTGyMsMbKbDM7KG?=
 =?us-ascii?Q?nx9Gfqrrf5/h3gpraWPdp4djXkK0DXuaWgssOl3SduhX9kO7re4O1ouylxbG?=
 =?us-ascii?Q?qg8C0h3xMvVr1Q1O0w/M2Qd6HrUlOwsy5fCEDNkOHdnrSKzu4SFg7sRxiZmx?=
 =?us-ascii?Q?krcMH0Oa9cHTR8PDE9RqT70C2WDr0nNSbMHDapKaTmjLF1if9eqvcGQryxsp?=
 =?us-ascii?Q?vZ74QdnLkfL4UK24IhhecRn0920O2e18DpzKCUd90QO9Nzck+RwhsMEYBngP?=
 =?us-ascii?Q?HO+mAx5dfZlZsDdPXTDurjVcB0l2epzfyD4O5CqwARDT8F6xrtlXqMxHscIX?=
 =?us-ascii?Q?r6zmgoCy89G9hRAXTiY9IpUR9Xw1lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d98b4e-6d0e-4181-cc71-08dbc0d6c68a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:09.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rug3f4/OgGNnTD+nnSYVuitwda7y9+0PW+8hmj8wdpe6KdU2PCf9ddB7o+u7lOVWb9d/YOiOyvQx7E6i0G5+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-GUID: l_TcCT6UQQkf77YA7LaM9UHM5Orn4nzT
X-Proofpoint-ORIG-GUID: l_TcCT6UQQkf77YA7LaM9UHM5Orn4nzT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently blk_queue_get_max_sectors() is passed a enum req_op, which does
not work for atomic writes. This is because an atomic write has a different
max sectors values to a regular write, and we need the rq->cmd_flags
to know that we have an atomic write, so pass the request pointer, which
has all information available.

Also use rq->cmd_flags instead of rq->bio->bi_opf when possible.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 3 ++-
 block/blk-mq.c    | 2 +-
 block/blk.h       | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..0ccc251e22ff 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -596,7 +596,8 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	max_sectors = blk_queue_get_max_sectors(rq);
+
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..21661778bdf0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3031,7 +3031,7 @@ void blk_mq_submit_bio(struct bio *bio)
 blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_sectors = blk_queue_get_max_sectors(rq);
 	unsigned int max_segments = blk_rq_get_max_segments(rq);
 	blk_status_t ret;
 
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..94e330e9c853 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -166,9 +166,11 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 	return queue_max_segments(rq->q);
 }
 
-static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     enum req_op op)
+static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 {
+	struct request_queue *q = rq->q;
+	enum req_op op = req_op(rq);
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
-- 
2.31.1

