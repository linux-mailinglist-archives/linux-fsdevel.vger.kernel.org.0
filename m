Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A606F5E53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjECSnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjECSmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:42:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFE7DB6;
        Wed,  3 May 2023 11:40:42 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpRov003935;
        Wed, 3 May 2023 18:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7d+s/0M45qtUO3zYE7BS+D09AQElSGIfbhoIoUYOSpA=;
 b=i+fnpszbJ9CSlVzJ3kgr7FKCwWHAilr03+8Ct4f9MBDCGuvpnCJGgrKVmk7Rhg56M2B6
 KzuQDf/UAi8zd6tR6+0w6Bf7G8mR3Mb3RLGppQhwPiE4bTq5LII6qG8lRaRQT4RPIvR2
 p7vRz3A36xGe6p7Tjeu75kGQkrd+OyeWFEv+WdpGRwRCiXFmmWwrMiEC5YTdd1oqkvAe
 +EbeybNkP2eBzhWAJ1cWtdJmiuvj1QCnuB/gcSREqKwpTWWof/t+EF71jcREASx8RePL
 OF4sBST+4tzCF1DhJdzROBZY269ZAW0FkFP1AcYVAHysTpkerKqf6TDIjPMcpU9WXfcv iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d07pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HKboM027453;
        Wed, 3 May 2023 18:40:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdsjpy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUFHlp2ZltwMglcdTDfK8ZSHh/toFB6hMn9/w1rTl3kqOR9pbPIlBNF8M1BzWgs9nQFnA2fBIgBGO2fh04VAP5rcqQLKVMHMh4KvwxiI4RWiqoTRAjdlXQcADWdsngct3x7rOvTj1yw1pYQV9QSJyH9JP82nye5nLCUbi4Wlo81NiJ3aU5bcIS0C0RWxAnDhLLuQGhI2sH7GbFZx9FrYsuaOVUmiCDILPhImzvRHYgZ5mybNR9+x18/oAnjChiBvqAqFHmsEQ1Y8yD3jtSI4QFPumcFSnLm0bWykSXK3HPyD+Rexqkn8MIECNJTbSVemQyAQ1vriUFmh/pzbUaLgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d+s/0M45qtUO3zYE7BS+D09AQElSGIfbhoIoUYOSpA=;
 b=eskqH3JaXFQlRwJH7lpzIhBmsVeQSgjuoFDo0bB4b5tmP6t4UsXyhRFgaxwzEKIrJFmHSn/PZVyEfXKMZBsEZHFlou89zTfs4wGPzilKz0ublTHIfl0Rw5C3Y1v19Xz5yBhiR+JqSKsbzgf2Qhd0C8VhKwbFZj+eDzZqQ33XIed/9HKM88NBJdPPcGD/1WEamla4xrtomZUn+JP9yXZVVtZVJeiRbQSwpvIKof9axou0/DOsz7qTSpWmi/ST2XnHo/4VKu7nDHMm/oo0YHLrvHflUNPtBYj2iSKWfcumNW9S6DVIjHz4+oQSmJMUlwE4Svd+zhsh73AicxO8uj+ToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d+s/0M45qtUO3zYE7BS+D09AQElSGIfbhoIoUYOSpA=;
 b=DFlcEn/oKAZIztivd2ZwT0wwKO84gYn1g1a9P0sgovaF8MjdiYn5PRmslHZck1en8GP/xJgmtydLVsNdih6odw5fJLpiXwq0fqc8wKjKpZVAKARgJ7vQmAli4mfcPShGJt+drA8mVg9FmTVXwKfBP3kKvarJE77lvaPPe/TlT5k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:40:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:40:13 +0000
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
        Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 16/16] nvme: Support atomic writes
Date:   Wed,  3 May 2023 18:38:21 +0000
Message-Id: <20230503183821.1473305-17-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0190.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 71087c64-35e8-4373-d526-08db4c05d4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jNUHJ3Z4b7xdJ/QTh53jrdGGqCvwNeFZxks8J+rn0y7mDGjIgNUhSuw8hDkPebdkyPgmYXhjez7rGnVC25ulFFzp8GyMJZPVMVia2moU6vaPWPbUUM/NADNAIzYIrR/r34hF1Za1j+QaMyafWjKLrRBeB786dhotlw9jfYzRFPGOnTS4RMgnDWbq7fO0lrkIFyDJ2LJedYftbSHcgBUuRkqXiW7EpCk/2vcU2zuhNcjX30MwVAddCq3ja+2qd/fo9qdVHPAv3foM/xUoKCbOMtk9lQZkmhWxjqoiCcBqLk973mTajRpd6FT1w/u0uM4szAZrhac69eaSmxcpJliGPVR6nRCNQIEjveNYik7y4jzopWEl4OinocgAKbYeF8r5WXWY4etAuOkVj5os3HrCfvtX3OMeB8Ah+XwpOpT3Id50eCXFaq6yQl1it9yKePXGNxSR43jK1fwty7z8PKKl764qvuYxr6CVvkD3Mz91zLoI/3XhA0je+ZAMn/tNAOzDTyHRzgxDsPMbW9whibt50rYtRUT3Vm6AbivEVseuGV1uuO5LHp60UQ2is+eoB10dPpoHIKwuyP7VNnKnQUQdiskaVUl5Eq6eb0ihk3CSn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(54906003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZXe+uQFa6Qkoq5Ku++78nnO4sBQtUCZvBThnhDTdyedttQgBtL4f/qwnzjhX?=
 =?us-ascii?Q?NWWQSJrY2lSqvA+mRpF4DtPWTfzlaiYXL7ggn17TOHH2XCPub8cbWj8LGxgS?=
 =?us-ascii?Q?u4Av44dsGB/iPLhT343BEGNYepIDJ/UMS4WXl9nWIxhabHvZCNnPrjj4RNQF?=
 =?us-ascii?Q?03YGwqaghX8ZlUfubDURH5z53ESwn5zL0bHNxX1C77yNw2HoE7K5W+1wncxN?=
 =?us-ascii?Q?oku61BK4A80+9g1ecedGMNX3IHj76fD3G855ouFODG3395ZolzZbSRPREMwQ?=
 =?us-ascii?Q?n8vDc2hVKN8sgo2ZTBJ8e9Wey8kZsZqDaMibUW0Bt6+IDnCmZcJSP2lpeF6H?=
 =?us-ascii?Q?8kvMzC9845dbPsCRJIB45NeguMo2HJ3eXlj98sIo9mLvpWFoxkHdqHlf90N+?=
 =?us-ascii?Q?OV62x77PaQRo12AJEPLFG9vJs+XrbA/WQ/neUd2Vryt2PJR50kJq0YpWD4dX?=
 =?us-ascii?Q?nSa9JslA8Pay9P7mD1MUwyJ4+GOw5XN062QTkOiPALXQ95Zi0NZeFe+w9Xul?=
 =?us-ascii?Q?73TVCLv0M9sHTfU4ULE7VZw5ytawJ+vqCwTBHjseR/Lagi5JmWblmiWI7q/1?=
 =?us-ascii?Q?oGmcuxz8LK+FySbL+U500Ns16Y3b38pX1RC3DiQZqL/+2Ie4sVqJ1+8SDDuJ?=
 =?us-ascii?Q?A4mVcYXbD9CpQcoT10J+tCxXDQ7y03cfbByD9beHg0uOPIeYPy7QD08x7+h4?=
 =?us-ascii?Q?5LMd0ljl2Qon4+4VJ1ZhH4pEcXyv95UWOZE2/vAwbw+ANce3C0UxeKeUZxG0?=
 =?us-ascii?Q?tAewbtkfqZ0HB5z6fHPXP4fMLJHGN6f7ojHWnuvcMxBHlF86L8IGbg+dM5lc?=
 =?us-ascii?Q?ZKiYr2XAUzbZBta8hfB2Dhi2BiUW51EhSVXIOloVYUqjXsrV5bviDvnmIXkq?=
 =?us-ascii?Q?OoNIqgltnIfcDOKPvVfgNMb5/OGELUOclUsTXxySboyxgvYS9PaaHuRAjl1D?=
 =?us-ascii?Q?tL8yE9ZDyJHhCxRhjnNjPdYTgxdOovmynsnky6eJoTKMsJqFwTq4IVapljDf?=
 =?us-ascii?Q?pOBfpUSt8hCxeICdrEj+XRnMQac0mYoE+MUcR838qg5zP7kj3hhwGSpSjj1S?=
 =?us-ascii?Q?G2fwLfz9ON1kAf7utp8qY57K8GLXEVGmEJk3IISxVB7qXT4C10WZuxF0HjiF?=
 =?us-ascii?Q?aIa/fyLzUNaSrOPtcN8hZvyytM01TxxLm/mi6Epyse6fd0vwr0IQGKRATESP?=
 =?us-ascii?Q?NXBS6AdG4F8Eu+OxiBeTiK0ArL1+Yzqtc8MINEbO/S1qoLSpWlKMOb8CVG1W?=
 =?us-ascii?Q?wwEPwAZMrDC1unWpw6n6WOT5Gjk97OWcdXN2miiwHk/cl8/1gbYXN9MTQcnB?=
 =?us-ascii?Q?8dXiBkoSvIdqHsxZByIKzTo1BE7Fw9WbhT4T9cc/DSFr6a7nMJ8gkbxMG+7X?=
 =?us-ascii?Q?T30xA2GP6ed85cib21SJ+7ZnuAzZSYQfqg+WBDhIJtSZq4DJJOH8zr6r3pQf?=
 =?us-ascii?Q?av7f+iHoBYoxXShswsIvQ2I+6Q/oimVKSsq5ZxJRaHCPIbX4zZbJpLcFEn6t?=
 =?us-ascii?Q?kYrdgPqi/w156uFVnDAOC6OPdWVN3AKR0hQq3+RLz+re+G9lTZtp2SdL3EAQ?=
 =?us-ascii?Q?XdFIm8O8YA9spnidw7yyC5t6DkHko4z3xMT3+QGy8RcInb8x3m0Yp+l1Ozjl?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hyeGoreAlAQq0A8Vb9466Lc8Gz6CQ85rXaUDQlq0BJMqAoviPI6wMS5RaZPj?=
 =?us-ascii?Q?9K4wj8cVIBKh96PeXGqKPQY1s+sdbt29U4EZvGXrQLOz1oChsQA3uKrdA9/l?=
 =?us-ascii?Q?DgMBKTCxQ3XCDGiMWk1lNDlaNYO6w4t6Mt/LARQbohUrkq9SIzpV+uzob1IO?=
 =?us-ascii?Q?fg5xB2mefvDE0NrQhF0f/jHqt85TPc3UjOjyJleY+WHpw6GCFeIpiJQyPi6g?=
 =?us-ascii?Q?9jTZANOZ8NXXqu07xQsj/1DJZQkCTUmYgh49KTVvg79vpLtWAdIhU2cKmKPM?=
 =?us-ascii?Q?ByCaUEfSr9RcAwSndAiKPERJqbH96FSBoUcIAOFRNLdZrtCYktOinxsN/N0W?=
 =?us-ascii?Q?VaW6KBhieNPL7wG13sdfOP4fKkFOUB9mUktqIGyKWaWcAC0vSbYtfsnInWgI?=
 =?us-ascii?Q?5R8la0uIDgKBbpVFuoYOstvGS3udj+olSYQUPkbdX8fZ1OrczypwBsOjddW8?=
 =?us-ascii?Q?9nxOtGQFfKGLpYmrHGKtbcHeDBjbhVUsyn1qtJQ8Tm+aaXkh/cszGFNBjNWM?=
 =?us-ascii?Q?dLKdvkU76s9Zfad649OdT+756yeLHCgQ3E1/W7uPpwVPyV2I1HE1vCm80Sof?=
 =?us-ascii?Q?LdbJ+eOIU0Eh2dCjb/lVr0j6xOwBnKmzqupMWJHdx+J9XvCx9jOxP0Z2r5Oq?=
 =?us-ascii?Q?mcvQE/Z+0hki7WFQDDRABOSVJOjdx5In+qk4kpPYVUlb+Ufkv99aKz2Qtant?=
 =?us-ascii?Q?mi6iiUQsrfdDWpSx39PxPtW7eozLET+7OWPJi5ILHmuypsZOQyAuEURS3HbQ?=
 =?us-ascii?Q?1p91ondKCTN+snJ/t73RjYxfNSGmGL1ShhbCf/gAgUBzxOWVAeu+UE3Ntk9h?=
 =?us-ascii?Q?yfEsiAdBpv3vhXC0Rrcv/1ZJhegMIZL/CAMNM4vqH1/wjMfXpLcn17Gy2UVV?=
 =?us-ascii?Q?IpqNioY7WlKx0m10jkxIAC5jqsZipzzUkyE4oNnO93k3uJIzMmBJyxFhgrwz?=
 =?us-ascii?Q?d0FCMQRXJHJa38BiZUm7REPfeZratcDYVpxjyAxh0t5zGb9oBiorSluVyvob?=
 =?us-ascii?Q?CeeJXy0EvjL5WXszrIimlSgalDnryvvag10bKV79fn24MtiR4Xmh7cOaQGbL?=
 =?us-ascii?Q?ZmY+pRS2aNT0KzQHWU7lVvi4otodRrbixgFE2mv6Y/wJReW90OQ+z7ah/L1h?=
 =?us-ascii?Q?9VUHnWLTGAyf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71087c64-35e8-4373-d526-08db4c05d4f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:40:13.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/Ptbx0+9iNRhWjbGo89NWiDxm2pbPaTcZCOsNJg0+xxSaYMbGF0QUCaNom46x5zPQ6UuqVpbBi7E5AIRjn4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: zQ5jglPpdDNq2kpiiIF0x9YXSnyOTnt_
X-Proofpoint-ORIG-GUID: zQ5jglPpdDNq2kpiiIF0x9YXSnyOTnt_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alan Adamson <alan.adamson@oracle.com>

Support reading atomic write registers to fill in request_queue
properties.

Use following method to calculate limits:
atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
atomic_write_unit_min = logical_block_size
atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
atomic_write_boundary = NABSPF

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a9bac91a4c..289561915ad3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1879,6 +1879,39 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
+	atomic_bs = rounddown_pow_of_two(atomic_bs);
+	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
+		if (id->nabo) {
+			dev_err(ns->ctrl->device, "Support atomic NABO=%x\n",
+				id->nabo);
+		} else {
+			u32 boundary = 0;
+
+			if (le16_to_cpu(id->nabspf))
+				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+
+			if (!(boundary & (boundary - 1))) {
+				blk_queue_atomic_write_max_bytes(disk->queue,
+							atomic_bs);
+				blk_queue_atomic_write_unit_min(disk->queue, 1);
+				blk_queue_atomic_write_unit_max(disk->queue,
+					atomic_bs / bs);
+				blk_queue_atomic_write_boundary(disk->queue,
+								boundary);
+			} else {
+				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
+					boundary);
+			}
+		}
+	} else if (ns->ctrl->subsys->awupf) {
+		blk_queue_atomic_write_max_bytes(disk->queue,
+				atomic_bs);
+		blk_queue_atomic_write_unit_min(disk->queue, 1);
+		blk_queue_atomic_write_unit_max(disk->queue,
+				atomic_bs / bs);
+		blk_queue_atomic_write_boundary(disk->queue, 0);
+	}
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
-- 
2.31.1

