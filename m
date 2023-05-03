Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F416F5E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjECSkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjECSk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC477690;
        Wed,  3 May 2023 11:40:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HomQY017456;
        Wed, 3 May 2023 18:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Oi2uyE8N2356UVchRvEhKFqT4hAg+6Q96AYvmiDM6Cs=;
 b=L65ooSaCQkAjCikP4s2ejqM9+SKS/MBniX7yKWPp7M4j21hkzqSPONVfbFV0lMSVNPGz
 pRItQbyYJG5LiakyaME0zUAPHiyaxhk5T0uA5jW+lex6zI0zJJtkrpS7YsGAfB9tV4WC
 OOSpi9cY+Sph/WyrD24FssYfPO8A03lbdgAJK41BCgHRZcKSNF0WrO8oiMxe6r6oJnh+
 f7odJEL0aXrKG5EDk4QfWBFupgT1ORQJ0EYCUfP/aTawmF4VA/xSiI9UZYbKIL99/Nil
 G4cp2Q83BRSAPNEk6pm2XOzwd4ew3XXNngUdDzUwAndXPvg/VlRe9mnSzCbg6RXa3zWo yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aqyg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HEbSG027489;
        Wed, 3 May 2023 18:39:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdsj4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1nDuP+iSPcd0EB/wPOwHZBI1SBNo5F+JeIma/JEXRi4Yx7lEM8+nlOmGLXwkKieiWsk6mRt3gd4+L5Kg8ZFihM0LQKH5cJMS4MALZ/ZvGuNZy6iwMG+RIA65LSrNuHO+MmPUjCifDYSbDVyBhGIotiZDWjBjDYcDPvaXO6rK5srfM2g92SoAWaFn+/m5OWELSt8H2Y7cq6jCEONPl/RAVrf8stVkmmwlV1mu7GPkcQxExuE1LJdElb3/F09FJenxsxbMtBUFshqXqTaNRLJEvDXwMa3xfV6m2n4yXfM4dc99o/zzNuqyOhFDRLreR9jSVd11DnOSdcrt/cZa5gkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi2uyE8N2356UVchRvEhKFqT4hAg+6Q96AYvmiDM6Cs=;
 b=NKtC3AZWcesgAMRH5PVDiQNUA7CuffzeKORLVyOq9V3yirgDMAMDBc8uiPQdi8+au9w3xVZAWt07gaXNpmoZp0CGvffFdkZ2PJYeSWaiYpmilhOv1L9opa6wU8thCQnFAYK64cawh0n8HRqvXjFzuiXn7qm3YAa+914xcKi84VJwVGpehr4c2g9c8d1+zyjN0IUSJK2JQGyu2vrGluxavy/diKj6n+Twc+cMcGutDrdJtHiTeCxl4n81FagkZH4GhudAIxwcCWFJGQLYCtNChlMu+lBSoOB1kl0Fh3QJy0a3RCcnL7LVnpHBC5sbD4cHV1Pzcp4zwo1yHd3Cgk3Ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi2uyE8N2356UVchRvEhKFqT4hAg+6Q96AYvmiDM6Cs=;
 b=U7ESK5agJ4Ri7EX/lFPJc+SrLORKylmD2/LJN8jV/nDM2WF56+qpheGq9gwFI0Gkx29s1XkskcB3sjSSpbFbTFmyq/942w/G/2bIdqVFgDivx0Tq2jI9p1SvUsjrFQvcQ2ci/1fAVzL0l6qUHeHdh7amu8u5ov9NJh8BNo2rxtc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:38 +0000
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
Subject: [PATCH RFC 08/16] block: Add support for atomic_write_unit
Date:   Wed,  3 May 2023 18:38:13 +0000
Message-Id: <20230503183821.1473305-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:5:120::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 15667a67-8130-479f-4e08-08db4c05c031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZuLT0rkvn0wfJ7HkdahXR8eDl0zmFGByqOS/NrtC+uQDulHj3+Cm2wXSmVf7qWp0qffcnhnwU2uloW77p59IFJ/XRO0Yeq6+UOA0I0iI8vvg015XWGttWwXPXYvaV/WEipAMrBl2B1zmEw/QYb/+GsyjRyphDdJ1qElIuY8VEOWfWij33kDSwK5m/6jcZZstP4BSxCoBScfl1lNO9YAWsXpd/eB1xEoICWMtDU1bieTzSwqZxz2EGAbGl58oxF4h8mqEbWJrJsS/fQg9Iy4/VvPNjI7SZDp7hshp/H3ykEtPFWbeTorORPlFeBnHi+BSGc02sNS9OIdfLisKTE0tuW1032FaWJYF+wRI8+hQCuA81HKUbH8ZlvX1B1cgVfVOSdsoATfo1ubUT31VcBeDC3UtdX8KFDz8qAg2HygUgoIU7yrZMF655N0lBMy8oEXA5Ht+HxiMZEKxnAtHrJDrNHJy5BQqN+EQKnpqfHdGAnfnRP1Af3SMytd4vcdlFe9eQEbJoybl3n5KstQcqr4wCVQhVxXe9FYNAd1MBJhD/aLruJg/WwZtNmHjyAMJarT8bxJ3016+5Gcr67tW3sjmzrS7qR02zcKz9ZyMuWAhyKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYAjRDI5PHPWHCY2VuwVIov6CshdLEKxFlw3RmwGHIs3VY7lsaLJmMr/PsQt?=
 =?us-ascii?Q?ROuJbF+HKsacCNlqN8hTlb+1A1VxBeN3lHaEj8hEAyecAVSJcfbhiRIka6Y3?=
 =?us-ascii?Q?oFWqBND1ALx4hPX3fu2UaAe2JBV82UqgOSxFkoMe7ZtqEWcnqps0DwsuQuxb?=
 =?us-ascii?Q?ec8lPwRiKeziuZ+PY0scGMeEcYy4VKE33ywUCp1pHFIXjxA5mTweJzb/AI02?=
 =?us-ascii?Q?5A/WNW2x5Z6KZkmwMW+wRBeWMewUen++Kl+yjV5pDegMgPZyBC55Cop/BlHZ?=
 =?us-ascii?Q?zzAavkUr7EGciNRi4t141T+eeRXZzOpfxHOmLDBM/RXAUQjjRDeL4PTdnp3s?=
 =?us-ascii?Q?YSU0EbUfLtKD6n2d4KnZH2eqIXGUv4KFnJwvjR63KvZYNdVEYGKSAlVwwsNw?=
 =?us-ascii?Q?T/QHxjJAmQSmUoSIGNZKQpNUSxq2+MWC2tnQPTGolovUINo7sS9MGcqnlJj0?=
 =?us-ascii?Q?khrI12uzNQdj4DIZMHloFwkZcwrJroC6B7AJK2u2Kw2Y0GGAAxJ+HdY6U979?=
 =?us-ascii?Q?v/kwFMYMHcDhabROCsU/brmFaU00Fvp8jfmKZY8adCrv+DgQ5MG1B8SmsAdT?=
 =?us-ascii?Q?uu2dvryYjgB4cRqVKwmyxSiae4kDD4n9wdAP5gFQrJX+juUNlN4AnlWK3EH/?=
 =?us-ascii?Q?ctcFgxD4kihyKKdNuag90UUg7xT3/ozZCmvN+W1Hh2ys/erB4SJsS9XM8yCc?=
 =?us-ascii?Q?pKdFGXh+ICLXQNK9uumKFMIT+ybGQHDp+qkhLssUAqjbQl3nSfbza7CSAo6Z?=
 =?us-ascii?Q?S2Ngmy5LusdW3GjR1I4AQoGd4W5Z3c1Cq6KmR+QAiIgNTi2Lb7pT/96+byIe?=
 =?us-ascii?Q?/NEMnBW/DyozJ3cG2wKRrkzeI5D9qxJqq+E+oNZTw2Z2OIX6sJjHiYbqNKy/?=
 =?us-ascii?Q?hpu5T9eUzKkTGue8qG/4PG1Dq0iIDgJAViDJeaHRlLQQyyUH5nx3jKa5ppfa?=
 =?us-ascii?Q?KTbdkbHF7pctITeHMgcyjcxyxi9ySimWkZspsgWutWYMYIRVP+CKw9hP/MtS?=
 =?us-ascii?Q?DArauy2aIiz/Nuxs/+TR74IhPiCzC/UBimMW94pSiwrNsO+x6wC2qLcesNwo?=
 =?us-ascii?Q?oeXxfRCsxAP9CtU+45VklW2hIuEHwb+tt9XcO8forjMAlpsYomafEWDl4L3b?=
 =?us-ascii?Q?/R0pP1JoYgfv0R+OBfSF5t7vo65iRg4WU4n5gDRQ01ruSvpQ/Ly7noS5JuLl?=
 =?us-ascii?Q?6CQgzMXvG+radellLWgGejdCxvkUZFHHByBcnIqdyizxAJEUd/cdPVFGBt0v?=
 =?us-ascii?Q?Velv60QlBC2dn49yKHJKPxjkiCaZtxULpXZ5XJHyaoq1lZrQCQN0++9F/SwB?=
 =?us-ascii?Q?6+MTEP2e1jX8Nd4AC9VJQj0Nv5MfXaw19yW0iVtFkFBiPUu3ZfwHRoiawiRP?=
 =?us-ascii?Q?2MU88mugk3iVwPTRlMbTzfsnSlek1EJaewSouTuHbJ7dX7/Wuu7hdujb4q0E?=
 =?us-ascii?Q?KI5sBmcgeDBFXS9GXIlZP+I+xi1es/TrkrJi8LsCmZ74sbNgaUHyJwPkKylA?=
 =?us-ascii?Q?4XksPu8xZeWhpBRwxgLhR/z2xmZGENhihdeKvuVMJR4QETmHxjkvSkD2WShR?=
 =?us-ascii?Q?TZXW5cnLzu6cEDQ42aewf0hHoIFzsc3NF63j83m3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4dzgu9pK8PTBUmx6yuLlFSbyrkx9MQyAdjH+cwYtqPLbIcGDmSYNH4QXkIS5?=
 =?us-ascii?Q?sliZr7LqOvX4mA9sRNl31eHfkwSFU82jsaChwClugXcQkUnbgYqVYMr/pZHB?=
 =?us-ascii?Q?juUmyRs3373p5jMOYuDq5+QKhe1y7yg5dlfs+je8GgfhJvZY78GhpeNaoaLS?=
 =?us-ascii?Q?AuSpg9vFbRGr7Db2o8wWV3xX8yqs0bah4M3HR/UPAvgzk9RqXJhGsOrlF0Aj?=
 =?us-ascii?Q?TxjxGm+vyzHF+wARsY6ZepJPsWVf9c7Bto6y9FB0Ujs74inMxw3/f8bPjsTd?=
 =?us-ascii?Q?YgFTfANYtvyCV1H5Ad15SFs8JSOPWQg/j3w6u6rY1HkLqwSYag0FL2rbqDsJ?=
 =?us-ascii?Q?Eob6IXXyCDsA+ZtieCzW8hR0i8kjlXsFMMJWTD02rXoW0mjamrMcmqg2pnUp?=
 =?us-ascii?Q?wcesOFboyJRMjIWLAGGdTt+UJKnr6ZIyJiw0YfZQpEHhPoY/o7C4yhF8pYL0?=
 =?us-ascii?Q?FxDhrYxW2efiwahiJyTwmrDdVnwQht0coQgBc1uAnBGId1mRFjHsdDles9G6?=
 =?us-ascii?Q?IHlSWx0Eadj3MzKmD22eo+ZApAxM/lyVuw2j1DYEnzpOR670fBPAb8AKkPdC?=
 =?us-ascii?Q?jHAtP2eztDNMmfm0XjDhjGTKchATb7MjABS6gSE+r1ZXTUu5uJMuklJKNBMO?=
 =?us-ascii?Q?zqxaAiTNLCbzz3EIwK8EuelEYgiSDz/Bkp6LM/1uW0Ka4H4BD8+QPdk6mYBZ?=
 =?us-ascii?Q?Se+E1bzBvs9g4KFaIyQXobRB9GO0NYQBi1DJN6d9UURpNm41tSQ49RGkdVQX?=
 =?us-ascii?Q?QS3bQvNRvX87MiefbBtehBQi0BNGmTcfVqfJnl4RizVMvCBwL6m2OUEiKNUG?=
 =?us-ascii?Q?CyaY1fh7lLCrJ8s2xiUHvLZqN/qQhTS0J+nRyVMxXoSf80Mqcmd3zBAoSCcY?=
 =?us-ascii?Q?GydiCX88Tw39Dtsq69CKY/RmRUwsmcx8omrZVFWdhnaJbNMXFU0VMKIzTVRe?=
 =?us-ascii?Q?4/hqYNiPc43PjL3S6RhsU0e6KTpOZoE6jJPDsy5eCP9V9+wo98ZeOGfRxRVY?=
 =?us-ascii?Q?nPYPTkn2Kv/e0uGunq6gFpEX3XFIKx3EHLppNK3YZ0ITqvBTIblGOWzMUNYp?=
 =?us-ascii?Q?nBsJcDf82Y+fwZgU+4YwpHMbDy4pJwvbivGrgNXW4rGPSB3hcqUnvwX0L7W1?=
 =?us-ascii?Q?5Vuxgqq3gCeJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15667a67-8130-479f-4e08-08db4c05c031
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:38.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rW7S/kWOds7RDf5vTdI0u4NPgYcBWBUVxfL7U/zqwEoRaVpcFMR2gY8l1krijeFgnOFrBJWSpY4lUT7bz2BygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: XOl-RfO40zUrnz7DfqKJ48yfTMzWQoJq
X-Proofpoint-ORIG-GUID: XOl-RfO40zUrnz7DfqKJ48yfTMzWQoJq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add bio.atomic_write_unit, which is the min size which we can split a bio.
Any bio needs to be split in a multiple of this size and also aligned to
this size.

In __bio_iov_iter_get_pages(), use atomic_write_unit to trim a bio to
be a multiple of atomic_write_unit.

In bio_split_rw(), we need to consider splitting as follows:
- For a regular split which does not cross an atomic write boundary, same
  as in __bio_iov_iter_get_pages(), trim to be a multiple of
  atomic_write_unit
- We also need to check for when a bio straddles an atomic write boundary.
  In this case, split to be start/end-aligned with the boundary.

We need to ignore lim->max_sectors since to may be less than
bio->write_atomic_unit, which we cannot tolerate.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bio.c               |  7 +++-
 block/blk-merge.c         | 84 ++++++++++++++++++++++++++++++++++-----
 include/linux/blk_types.h |  2 +
 3 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fd11614bba4d..fc2f29e1c14c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -247,6 +247,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, blk_opf_t opf)
 {
 	bio->bi_next = NULL;
+	bio->atomic_write_unit = 0;
 	bio->bi_bdev = bdev;
 	bio->bi_opf = opf;
 	bio->bi_flags = 0;
@@ -815,6 +816,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
 
+	bio->atomic_write_unit = bio_src->atomic_write_unit;
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
 		    bio_flagged(bio_src, BIO_REMAPPED))
@@ -1273,7 +1275,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
-	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+	if (bio->atomic_write_unit)
+		trim = size & (bio->atomic_write_unit - 1);
+	else
+		trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
 	iov_iter_revert(iter, trim);
 
 	size -= trim;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6460abdb2426..95ab6b644955 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -171,7 +171,17 @@ static inline unsigned get_max_io_size(struct bio *bio,
 {
 	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
 	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
-	unsigned max_sectors = lim->max_sectors, start, end;
+	unsigned max_sectors, start, end;
+
+	/*
+	 * We ignore lim->max_sectors for atomic writes simply because
+	 * it may less than bio->write_atomic_unit, which we cannot
+	 * tolerate.
+	 */
+	if (bio->bi_opf & REQ_ATOMIC)
+		max_sectors = lim->atomic_write_max_bytes >> SECTOR_SHIFT;
+	else
+		max_sectors = lim->max_sectors;
 
 	if (lim->chunk_sectors) {
 		max_sectors = min(max_sectors,
@@ -256,6 +266,22 @@ static bool bvec_split_segs(const struct queue_limits *lim,
 	return len > 0 || bv->bv_len > max_len;
 }
 
+static bool bio_straddles_boundary(struct bio *bio, unsigned int bytes,
+				   unsigned int boundary)
+{
+	loff_t start = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	loff_t end = start + bytes;
+	loff_t start_mod = start % boundary;
+	loff_t end_mod = end % boundary;
+
+	if (end - start > boundary)
+		return true;
+	if ((start_mod > end_mod) && (start_mod && end_mod))
+		return true;
+
+	return false;
+}
+
 /**
  * bio_split_rw - split a bio in two bios
  * @bio:  [in] bio to be split
@@ -276,10 +302,15 @@ static bool bvec_split_segs(const struct queue_limits *lim,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
+
+
 struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
 {
+	unsigned int atomic_write_boundary = lim->atomic_write_boundary;
+	bool atomic_write = bio->bi_opf & REQ_ATOMIC;
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
+	bool straddles_boundary = false;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
 
@@ -291,14 +322,31 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
 			goto split;
 
+		if (atomic_write && atomic_write_boundary) {
+			straddles_boundary = bio_straddles_boundary(bio,
+					bytes + bv.bv_len, atomic_write_boundary);
+		}
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+		    bv.bv_offset + bv.bv_len <= PAGE_SIZE &&
+		    !straddles_boundary) {
 			nsegs++;
 			bytes += bv.bv_len;
 		} else {
-			if (bvec_split_segs(lim, &bv, &nsegs, &bytes,
-					lim->max_segments, max_bytes))
+			bool split_the_segs =
+				bvec_split_segs(lim, &bv, &nsegs, &bytes,
+						lim->max_segments, max_bytes);
+
+			/*
+			 * We may not actually straddle the boundary as we may
+			 * have added less bytes than anticipated
+			 */
+			if (straddles_boundary) {
+				straddles_boundary = bio_straddles_boundary(bio,
+						bytes, atomic_write_boundary);
+			}
+
+			if (split_the_segs || straddles_boundary)
 				goto split;
 		}
 
@@ -321,12 +369,25 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 
 	*segs = nsegs;
 
-	/*
-	 * Individual bvecs might not be logical block aligned. Round down the
-	 * split size so that each bio is properly block size aligned, even if
-	 * we do not use the full hardware limits.
-	 */
-	bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
+	if (straddles_boundary) {
+		loff_t new_end = (bio->bi_iter.bi_sector << SECTOR_SHIFT) + bytes;
+		unsigned int trim = new_end & (atomic_write_boundary - 1);
+		bytes -= trim;
+		new_end = (bio->bi_iter.bi_sector << SECTOR_SHIFT) + bytes;
+		BUG_ON(new_end % atomic_write_boundary);
+	} else if (bio->atomic_write_unit) {
+		unsigned int atomic_write_unit = bio->atomic_write_unit;
+		unsigned int trim = bytes % atomic_write_unit;
+
+		bytes -= trim;
+	} else {
+		/*
+		 * Individual bvecs might not be logical block aligned. Round down the
+		 * split size so that each bio is properly block size aligned, even if
+		 * we do not use the full hardware limits.
+		 */
+		bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
+	}
 
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
@@ -355,7 +416,8 @@ struct bio *__bio_split_to_limits(struct bio *bio,
 				  const struct queue_limits *lim,
 				  unsigned int *nr_segs)
 {
-	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
+	struct block_device *bi_bdev = bio->bi_bdev;
+	struct bio_set *bs = &bi_bdev->bd_disk->bio_split;
 	struct bio *split;
 
 	switch (bio_op(bio)) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 347b52e00322..daa44eac9f14 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -303,6 +303,8 @@ struct bio {
 
 	struct bio_set		*bi_pool;
 
+	unsigned int atomic_write_unit;
+
 	/*
 	 * We can inline a number of vecs at the end of the bio, to avoid
 	 * double allocations for a small number of bio_vecs. This member
-- 
2.31.1

