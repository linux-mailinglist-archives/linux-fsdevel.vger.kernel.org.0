Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF67B76C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 05:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjJDDBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 23:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJDDBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 23:01:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C00AF;
        Tue,  3 Oct 2023 20:01:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4MoW004010;
        Wed, 4 Oct 2023 03:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=46A/Qc+WL6H0itGU4C2yS5hhcX657CVyZKMDMDHxwaU=;
 b=uDV9CLp47y2to6G8SXNpJy+lKGdLE7FNbYSFXLX2+CLVd6FNncjVsnT62mIPx1JdkBgc
 G3QeVj+IOP/vAgXwScI2BzxDBedRZNuMWlPr1YJkoL+KVMq0JkVXC9QL9+x6S9dORYBA
 /nsqassYYCn4xs33GXLjcCrxmeR/hgghm9NxT8huOq82TpZsRsw/vRo8Uz1052G+j9og
 v5YBNzDMQJA7ZzvSSj8Bj7THyVJ/M5fzp+SXBtKKtMf2O1KjjFQuRlSBCFl3QK7DzHBo
 smPC02H2f0HiNMcgh9xFnCBg+Bk0PTNRBDVqp4+kiGZkVChGDUQnXJn1/hPdXT8e65PV bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ue2vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 03:01:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3940V4c4033659;
        Wed, 4 Oct 2023 03:01:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4754u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 03:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX3vcPvFnC0UZwEmxWL8O6raLMVg/ZsEZfrhjXzZX6rfHOTR6eJZoVFN0DaU/kLCV+MIfyfr9XsGhxu1t55pgNbtDenfE3PSZ9e4YHa1E+7LwpsalrnOG+Pj/2GevhZdbx7yk73Gdv59sGP41MUjZIa670y7DVDbXefisw7OvkVrBKRLbgrqTemBYsnJWpDe5+5hNWEqVBa0lc4S0MVSkEEYlq8boqoi2tHj9hX0whd/9Bymll/dEEE5LuY3sK+sfG5dXq6gJdOagpLf241OpA+2hCtucnsbvQcfdbW1xWVWSUSdgWzB8IQIEliOjHjtLd+5CrDvlvGKV+bSYSLp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46A/Qc+WL6H0itGU4C2yS5hhcX657CVyZKMDMDHxwaU=;
 b=CSy6/VT37csITyY/2xGc2FrYJSDcSs8zMJrQjgJ80Kvszdi/iGhA3IkkT42dEzBsiuQVCnMZyj38tFuTsoVnX6WITadRx08P1uexvdtPSa6fFX+lBxJIcyZcsOy1PtesfT4tx6UThOsp/YN1ken9l18CDlpgd08f8/iwX4SLJedOJpmDsUnH9ATNwCIKhUpjl/Va1VBYeVLzcaEGwj/b28JsixLA+6dUi9pHdXxmdWWk1ErPvCPwEvHdoZis5eHdtGHR9hCNKgZSSZHD+KSSSq5IuWG9tT4MokUVn1TURKxQic1SL3gprWup9rXZmH04pQ9KxPszJlYO0VCS945P8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46A/Qc+WL6H0itGU4C2yS5hhcX657CVyZKMDMDHxwaU=;
 b=PysLnoH03qms6o5vv48UFYfiB2P6SQQXRQDcvZ5tLr7xPYdEMKK/S9sPZxt0MjbT/o8hPdJ03j6EwGmcLTvTP5UtAN4VuUdP7KKCJ9Ub4uj6FxZC467/enhfG+XLqSrvG6ktWXd8gH2dLDuE4WDEKrXAjUDtc/R8kOTbh1JPiM4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 4 Oct
 2023 03:00:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 03:00:57 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/21] block: Add atomic write operations to
 request_queue limits
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-2-john.g.garry@oracle.com>
        <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
Date:   Tue, 03 Oct 2023 23:00:55 -0400
In-Reply-To: <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org> (Bart Van Assche's
        message of "Tue, 3 Oct 2023 09:40:45 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: c5960c78-380d-44f7-ec3c-08dbc48621d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbpvPWraQVCY6Hw750M+laLOdwDmvFUgKjuC2fm1Dzvb8mj4AfjptAp3QT2Z8Bp2dvHrLJvjoEAxD/J8+4+cxGusON2i4zjF1S2dKdL9BsEMHrc8m++DD53ARMIbIc9Xb/SibBn3qwrAftcLRpO9svZKAaOU4VP6+FnyB5QhFbkLI1A+xinYa9bj37dOlf2UTEcKIn4mr4/96cY1xtPRP1LpZs02qrg0AAFIEk/uXbS6mtkGvh65+omQLndvLDglFsgQctHo8faxTRTQ9c2WYuuVcB61c2fXC0wOqTqSIDMlEFgcusiS0wAQkzf9vTs/lRnVxyHB+lLiPzNbwnW8Kpu6uA6FXuX8H3VVCQft/Lx6tENIEQQF48jmhvL6N2oyXQYeWDJAOTb/q9EGjgs9Ss5HkLLavNFbp26EMpPNi9N1heU06iVoEPLeDZOvAAgscJZOF1wyLViWuBbeoiyVlszHHFpStdwEW2Rg3gPbBi4kQLqWAtGcY5aqP54xaI2cB8TKL6LjIqCDL+XD0NIklIZZxemERzxSNwE8JVBYynXW0gULirhLCCaQAiIsc0GW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(26005)(6486002)(6506007)(36916002)(6512007)(54906003)(4744005)(41300700001)(7416002)(5660300002)(4326008)(2906002)(8936002)(66556008)(66946007)(66476007)(6916009)(316002)(8676002)(107886003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZraY1LpisS7i17bwvkPFJDREAFQ32FZsCX2MEoPpYQbKtfy3DQpYqr+Nuw7?=
 =?us-ascii?Q?gOjFSlCo3+aFk+Myy6yuQOhv2ELuHTxgZXvbRJyACURV1NdDKym/EcGHvD97?=
 =?us-ascii?Q?9JbjNOg9duGkmtVgdB/sgf3Dpvba6Ms9AF2aj89xPIrCBf+F5f0P/XcdTLx3?=
 =?us-ascii?Q?BU1hiWnJBx/n4uhSx/jAOgZeAyfcv4xLEnq8YqvWu4cFJ3XB3Ssv8iCX2rBj?=
 =?us-ascii?Q?LaUpHqjCa6YNVHoSd8hMNH/lmi9RwnRzjvduLajthRJ0QJJbYl9EHl6w9j3q?=
 =?us-ascii?Q?xIEYl3yk4oNiV0oNJVI3Unbs9h9+XMIP1h40VuS+3U+13MkceVJ9ncy993eM?=
 =?us-ascii?Q?oRoWKrSpcfRg0qdEXxJQOSxzDMk6glvJjjz+wTCnca1LOeIbxrXh6bue35zg?=
 =?us-ascii?Q?4L/T1UVe2wVSAVlVjap0UuCs8TSPoaSkjZvDECJ3YDjwSUIaWwmXOd6zjowo?=
 =?us-ascii?Q?TcwxmGEJYt+/6/ccW/63QAeQSloA5rcsjeLnFm1ME9mZ4xsiBs1ZV/lKEV6H?=
 =?us-ascii?Q?QawBbatoe7Z2Rs0xxxD1BRuk/eve1t+2CbJALq31i1PbnL1cXothCloZuEgk?=
 =?us-ascii?Q?srhiQkUkB4cMSiLnygiU5+pgchnscifdEjjuilMtL91Jalh5KZcXngLMMqyG?=
 =?us-ascii?Q?cvpFAs7Xyzt3/w/xnpRfEji7EJkukuYtHwrLUalVTS9S+c1UM7Q5ru4Z22xh?=
 =?us-ascii?Q?aZz2om4x22otNzjMf9uDvVnVp4BRwKQE8bI7w/LTkEvMf+Soy265xjQDrC/n?=
 =?us-ascii?Q?XsVy7p4DJTPR8AKpVhwFp295oPJgOAJNFSGO13jZw4wD8+MnW3iJpnBMRYhZ?=
 =?us-ascii?Q?jkhEdKHj92r1WwH4jEtQbFdwMCA3hJxWiLa+tKysW0l56uPy1yAIT/wgNYtn?=
 =?us-ascii?Q?rJlxd8OckyPEbdjzTYS8HDCwUz8RSDa1eS+/3urIIbAPXaEbtHiUA3d9Goh4?=
 =?us-ascii?Q?z4RXWs06MqKMHdlDnr1dLh8QrFiQ+/dWQ0ZzGejD+DLHB/Hp3HLtagajjnVC?=
 =?us-ascii?Q?ft33n8yXwULOljWIamp2IhyXb/Dme2OxCOB9hMTQx8wL+2V4LrCX1iVJdusv?=
 =?us-ascii?Q?+5Ws6PHgsVDaxA/huRm/V667znlPX4Vu+35BZ/Ao5Az57JmCcTpybOiZ9Huq?=
 =?us-ascii?Q?HRlCDM1wKwdCEZvYMnKjhNfuCJbAGcsQUiXhPRiQw62BM3XYCfgTgT4TtDJ7?=
 =?us-ascii?Q?KslmvnNUQz8gbqwXpvCZTtbJOV9xFQcsfPwddBGvpJ8Sqw3mzz2eFei7yaCx?=
 =?us-ascii?Q?G+X14yy3FgwBhOQPELOI8XLzeIQZOlZu+q1TW5OYTedg6cYJxYlIReT5XFX4?=
 =?us-ascii?Q?iWJ0vEI/AIXY7RpExqSRThQQT6VHJJV5xI9wnuoAZXCbPK3EhriZrgyLweho?=
 =?us-ascii?Q?Jvt4ePIwZxLjARoqakrieMwvPUnjl5pr7d2jeP4PCNSYkmBXFBF6qadfMLcz?=
 =?us-ascii?Q?xNWl1Rl3aXJjHQLtuIFQJtXY8uSxhiNmg9qWAqUPgkQ4rPfUHS8/w2TeDoBu?=
 =?us-ascii?Q?clLFFxaM8li6ogT3SYsy2f8GynC50g5fv+VZzd8hMDBHShQRhTn1mNonwIV/?=
 =?us-ascii?Q?qJpRiEx3OqcDQcTE/g6ULRrs1LcQ5kyyZBBBMJZoRfykKwc9SbB1NpKoXNdW?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KS+Rah9UG6tVgcsNnDGCOPJrUEl0KUiAMu9uarUtWpi2O63fagn0fXLXEzIr?=
 =?us-ascii?Q?AWTK6x/d900YW4mss7hPh/ach3l1b7mYjGDIi/MRWeoeuLTzOV7nOHLXvQPa?=
 =?us-ascii?Q?fCLfOqS9ebjfZ5S7Kl7PkZh/GznFQLuXYbbo3cKWihzV5RaieBa5yoTbNZvt?=
 =?us-ascii?Q?zaWfZz3y/qvtfmIml31AX/wsj/kahCBg1TUpha5YikXFVx89Ad0t1cFeww5O?=
 =?us-ascii?Q?nVhXXPQBmMIgsBA702rhoOXKsGVk09LDXF606L/7i77xP0+6TZ42pZN0iEqE?=
 =?us-ascii?Q?T2LO/ZEITzdEw+mNMX+al0KPZ2Vp7F52/85hbnkaVAHX7GnAo98q+ki/254E?=
 =?us-ascii?Q?UHT06E4sZTDKKeszGeNVwvwyjWCIdotZ6Vg5DNwvIvi48d4Y1AMmC/FL06vz?=
 =?us-ascii?Q?NbmVtQM42vBlinAvFM52X6nFa4Z9hbyshHKvIfb491m42tIo1iloxLREikKq?=
 =?us-ascii?Q?4jz8EqTrX0HBi8jT+sQwUw+AFRxQ18LSVyen1Rz3hFM90ts0NkeYIscJwzkc?=
 =?us-ascii?Q?7zYYLI8LlFY06/DuZNSc1b1fgQByAoqsjVheQu/WYf8E+G91z2FO59tjWyoB?=
 =?us-ascii?Q?bPXNnPxmO5LrZ6FKlFKewCa9IvvNgmy2yslYodtT0njbjV8HG7ac325I5ga6?=
 =?us-ascii?Q?uHwgG6MaeMIYooaArkjNcZgpoHKhGGWhS79ih6owCc4pXtu/8+UxLFOXhXWP?=
 =?us-ascii?Q?Lyt9IcpygrXcwSycdWdh2LDU0tErRuFScyTaBieMVIvbJJxhn49BJaKdALVE?=
 =?us-ascii?Q?ccVkgFc5W2RJVyA/MGjf6qfPu8tTZchb+5A3YdvDn6vyQAnyLKooj8xIzOEx?=
 =?us-ascii?Q?X3OKZ6E9nSTEaO5MOpLwOy/LRjnhn05Bz/YGCE4nPSw8304VjUkOWlzHPIzs?=
 =?us-ascii?Q?s+W4GGayVDK6JPcY7YZds92dr+4hFRzGpiP1w08B4qeCLScp6C34XUL5BYJr?=
 =?us-ascii?Q?dwVyvpkNNbZhnBEqXDlsuvVUOBkM3BoaHTGcbequGVPmOG15+CGoBcFoyCfm?=
 =?us-ascii?Q?WsPbHTr3OjmWmI3tJIC2g5nqiYAivMiGx3lif59szQHKEzAVW0J1GR6UVHPd?=
 =?us-ascii?Q?TQ/XymYhtGufNHjDHczgpUUEwtFSkr1sUUuMdWwE6wcOpZRC2Q4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5960c78-380d-44f7-ec3c-08dbc48621d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 03:00:57.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiyeXDRxfgTsIBrjOJSyaIaf+XIg5j7FamJy7OSeEBnx7tz4ihCvJXAXBgRGLyhuPLZgbJqRoMaF1pZjTlgD/scYc0yai/v3iKHDRwensIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=836
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040020
X-Proofpoint-ORIG-GUID: lshOhupD7wAs1tbQYs5n1oqrGPGDFJxP
X-Proofpoint-GUID: lshOhupD7wAs1tbQYs5n1oqrGPGDFJxP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

>   also that there are no guarantees that the data written by an atomic
>   write will survive a power failure. See also the difference between
>   the NVMe parameters AWUN and AWUPF.

We only care about *PF. The *N variants were cut from the same cloth as
TRIM and UNMAP.

-- 
Martin K. Petersen	Oracle Linux Engineering
