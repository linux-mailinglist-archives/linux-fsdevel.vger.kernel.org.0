Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAB6F5E71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjECSqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjECSp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:45:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8276A0;
        Wed,  3 May 2023 11:44:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Horlw003650;
        Wed, 3 May 2023 18:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XFxwhctFWeaHfIn07OmNgC7XPl2+We/u9A/414n8On8=;
 b=iSxZ+Ch55J8sLX7NitnfWCP6Ek2BRJGmcd1zppqbiy8VUs+lHz4aGnQgXgfBuoFG70p3
 gNavzyeWFuZfnZvIq8S/uHvP07vJh7uNV9x4uQFDazT73M1rIK8h8N7EwmUy8OF3WPMz
 0Pg3dL2zKOQlTCl01rqCE9b1XAEwER68FV5y70TAZaPYxfGpQQSbt87ZdNakYQKcejXD
 G/mlNJHfb0vXa3pLCi8H3yR+6D03790V3r1BV/4HRRVP4i8yLqCTD3OjQaEstXJX9P2A
 KVgOVgoJD6nJoiI7FNm7ej4PFvdNSmCW3t+csmsyTk4qF+SiIUiSdYkaAWixfsTyeJ9t 4g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d07n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HxTLb010247;
        Wed, 3 May 2023 18:39:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp80590-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9Y3HfGYDWCqAGg352OGErL0q40g6i3JDOJGU0jaRqV7lZ5Prb7LlcJ65CZk98Gzf0G/LmzfNenNpN6IpAbBuGco7sUygIO3E6Rm8yeTUfz39KjQ7vQ7ncNCwhk+nVM7qoPEXmauJdRJHm/PQrD+a7L6iBVsWuaR44tdMGTUvNkVfum+NFK59MAnN6Ay3gwEMqin0TWPfd6VA+ziL8Uda5/UAKOInf72t1aRGgqvYiWJMFNtjpTCYAenayfUgUSvj2Cu51xibKhn/XpHEOowMKKOQXIZLcQOtAw/1c0kkbhTBwdyTIbbYlg1o2Xqc+npaq1H1S43WchD2UClHG71cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFxwhctFWeaHfIn07OmNgC7XPl2+We/u9A/414n8On8=;
 b=W7RzcDhpQBk9PNiU30ROGHQC6IoVaIOWmH/i7fASFhmAvNw7V8HX60v42cun0LCIFMxPG9qm55LlyVKnTOk0odiPUFPKzWo3DH9Ucrbk+1PbuXTjL51CYDyPV4WVLk0Uva+NlhJ3Pu9cmrPfkcVAfMpQnTmaV/ApKRU8hO0OrO7ZiIazdPlna21HjemqwIySl7aLotZ351W58fNglwjcELgBCqsND9gY2PkLuELRXs7VCqG8ty1xBJWRHf8G38A4SYCwixPAirp7Lou0Pavydygbdu9sIqIaezIV+WFYa/A8MJ+NZ3FyHCOth4UVaF3TIhen3EZHMM+hX7kTDAS6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFxwhctFWeaHfIn07OmNgC7XPl2+We/u9A/414n8On8=;
 b=gXkw62TU1S5gtEDHmK5anwbkjAsilP+VtUU8qUCm/56z60RnGk9Cd8ggCU4v0vJfRNFhrWlBz+EvI9yOhw6pge3axdxHMNWNiD9ntNdqnTjGJ4vrQZ1j2zj8ft/qSAec+cT3Y+qPN9lrGdMwTCvQPEgf1ME12yG88wpDR8TAdu4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:39:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:23 +0000
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
Subject: [PATCH RFC 00/16] block atomic writes
Date:   Wed,  3 May 2023 18:38:05 +0000
Message-Id: <20230503183821.1473305-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b41543-2ed6-4c82-f0ad-08db4c05b6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ThgaGGd+/iwOHcxl8eOeaOh0VAuqMz5Ee0lczqQGm/qYWZOd8DFeDAZtm7t3ycfdT85Sruva8nymLBI/yNsQNQVXte43QKdIVlQ7E/sBwc1+A+oQ2keMvXBWQudfZfv6HGlXfxDXpOONFngov2sAHDIpJrPTyTjkbfhZa6nWT63As7466aYTHD7WGW+F/MQhFai3qYOr7ouXYL89pVDF6rCCfhFFD7MrJAYb9kYBaI4VPgOJ2qDWgK9G8Q1716Q79zMj5g+TcCltIBJ3eharW56PCW+vF+35anMmatXbCc04cfAw2utVMkunazjcZY+FB12bYYfvJExiAb9dlPlFph+kmrpNKRXz7JZUoYXwULuxourWQO4jCvuTW8HRkJNdoMNjfBN+Se5VeWxCDD4KXt3gU5vFZbfj2CO0unIM3a4E6dTy+ttOqpUz+8vjHH3I1wTGcoJbPAb+60KhpucWkb4ydeldbMY9mFOYduoF8HBkn3CafP8FB0hzMlFsoSOP4gkZzFTkwhSL9tG/6oI9FdCopXP/9Tlujir1y9LkGSY/zD5b9Xwyjz0UOH9zqQsBj44ilZQyvX9EWJsxsN60PercOaNGtcEfUu2O+BlPqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(107886003)(6512007)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(921005)(4326008)(316002)(66476007)(5660300002)(66946007)(2906002)(7416002)(8676002)(36756003)(86362001)(103116003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osUl7l1Z/JDEokSzk+Sjgv3+qqAK7zfp3+L+1YQ6PFSL/+4bRCKH+Ysba/3T?=
 =?us-ascii?Q?1YPlbP4xHwJP1y9hVoCuvDBjKIGiOQ2LtPBGXt2Jrcb7SXiT972+cMpiBG8R?=
 =?us-ascii?Q?3OE1hxslNgmgORZbn60vvzpq+WCMWk7YbFImoT2gAzxSSdE3fwNmINkk4xeJ?=
 =?us-ascii?Q?tWhC2hubkJW2CU2Y80GJ2+gcgyv5cUSVhQJ3LtUuY+PZDrEiVCQJLftfOX1G?=
 =?us-ascii?Q?omDnTJTDn+eOGAeXe3w6GEgrtkJ0bttac7rabmcku/lJTQt4V11+QFTLeU4C?=
 =?us-ascii?Q?yfHPrmLnLxz7p//UbtI32LM1WpuFk/4oAa+VCbKKcFpxwhzkSLFc2sZyEygb?=
 =?us-ascii?Q?92FM7D4WDAFCeliGhcFEoCyICF65IgRFSmBEGsnbBjnekGr3Xo0A7tuDh0XM?=
 =?us-ascii?Q?2u095tP2Xc3LG4R4X5+IqSQfBfF45Oowy0/6EE79P0S0ArEAN1R8XnCK3ALQ?=
 =?us-ascii?Q?J8eszMw2TLpY4kB7BlFsBsx4GfLXfxOGlmRHzeculwBhXncuzYSxmidWLuSS?=
 =?us-ascii?Q?cJN5L8ErbUkof26F+Z4q7HUQYBggN9C1TC25Ce5u60Ku1SvAIZjhYtSEZTym?=
 =?us-ascii?Q?DKliScqFLVFOUcUs7XGAoSDgDs78BYnlarwdyIzxlgsEi7oXAuOG+MHaRR2w?=
 =?us-ascii?Q?BEuWlGbG4Lix076sEda9VHTAsbtDScIUfLV7JXQF3q4EanOqh7Qc9MbAGvuF?=
 =?us-ascii?Q?rTahSdWLUFg/6mW+beVEr08QDCFaL0Jh4HXoBLb7Z+qLiaiqj5tCd+eAnsD/?=
 =?us-ascii?Q?t11uLMCAO9maHTjZo+uW+RFmK4JD8pi1ImKgUVAGu7NTzaT3dteJf7IZIEAs?=
 =?us-ascii?Q?GrMxDrSyt3XBsfbOu/KhkkeXtyBPeROnJFbnkuoG9G+bDkHIJ5IRtIBX9ke3?=
 =?us-ascii?Q?ARiYDI/dswpMRGMqF7FK9jARThMRpDgV6IyanW5SZ+Jh+71GAgEWzSOKt37F?=
 =?us-ascii?Q?jW9xuYLxfWvtedLrWmQkCXEwu72NINMg9PtXguqwIjz7G1+wrqayuYSK83SZ?=
 =?us-ascii?Q?JdGY9k7Yoj5vAn30TjndRfpu/jqS6zgxRoidRSD2S/20rIuZvodzrr957jRA?=
 =?us-ascii?Q?DiAWeLtJZWtRnGWTHwn+VHO1D6QAfUknM1+bt/YRnOaBFgTdo6x8yO0qHdpu?=
 =?us-ascii?Q?3FI9ZePMBYJ1IlvYTfrDJQO7vnGOP3RBbedUA/QgZnMJsflkeMone0S1EKR8?=
 =?us-ascii?Q?yOcxvnaF/Ib+pDa3WkkUjZeb6MoaN4lWu2iq7knxiV2ZWgscClq1bL+cxwdc?=
 =?us-ascii?Q?yzCYejOyMS3i1YkpLqkaFzGOCrYn7bMgJyqoTpIUvJ99ei3qqN/pWPOye674?=
 =?us-ascii?Q?h7rgoNOaUO6uYUe79/pyY/6u4OGy+mrgAoIbhcmPzIL6Rf63By1setZramai?=
 =?us-ascii?Q?tXqPRPoGmCTKFxCwMjJeda1Bj2ozjVr3XHewZd2JnCvSXNZdgQ5LHqAIQV2m?=
 =?us-ascii?Q?P0X2JLVo+cKXOvhokAkXWrnO97puCmBEA1wErftFhbGaYMJ/srgGh41TxdTl?=
 =?us-ascii?Q?ZuPGvbkvqWrSqjjPGs49O57TA+7llyRiEFGehyAjQvmGlppPTl1uIRZixU2t?=
 =?us-ascii?Q?7rSgr4OIc81S7/QTTmE2/fNyKoLJK7y4ZJXl+zvaM8yTBrYeHOlH8kId0eg4?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rTCWOpybwro0+L7lnGnygFPRv2ZqLPSJhvZjP8gDJWGJmsYc1hWUYUnDmnYL?=
 =?us-ascii?Q?CItAYsVMv08VsVGikryfGAXB48LE7uTgAD1sqM+34SmxqQO6sRo5UQ7+2O8Z?=
 =?us-ascii?Q?ytuTSU1fJ9FNyNgnzMivbcukwnojolnlrYInIp1Pnu+J064KP9CmvjZTBIX6?=
 =?us-ascii?Q?gl+PTc0J3bw59KpY5arUSymhSa+RXK9und7JVVQkai2zgvbwtDAndnbsfw9D?=
 =?us-ascii?Q?BvU9/I0/b9oHyavoVomrTshs8JRrJhPWvsLlAshea1kj+YGdbolS2DeHWppX?=
 =?us-ascii?Q?Ne62NkpjPlTrfNmbCD/s212DN38KfBiC7HpidMqn4JZt30A4oZx+q1mIcrnM?=
 =?us-ascii?Q?5/pf2IiMQHkcR2ccCMJuQFHaXQ1hestOhf78yuTqOQVSWQgKyu3Ir3/NmmpM?=
 =?us-ascii?Q?ydGp+mX7tlf7/qI9JdJIshg8D0Pvt7IwI8nlF+D0CLnRZV+/cBKhCDy70S+J?=
 =?us-ascii?Q?tQsKi59s5tKuIl0MSZYW1y4IWQ/hsQn7U4FjLeN7VLAxpTC1utNuw8Zm7EiM?=
 =?us-ascii?Q?S7WgK1KanHv/M1ZKkmj/WY+6+Cr5lsI31MBYxpyI4ZeSQR5wSFLqIVZg2zwP?=
 =?us-ascii?Q?AmWVGUqzsHDgRuDsLEBWtUu11tK4HzihKe2Es8m+Ra7k0XEKw5SMyT1V1p0T?=
 =?us-ascii?Q?5mWXHoX6+iliYqY+QNrUL9+rHDmltEknPfpatj21lQUNkzaYY3N2z8rp8Dpj?=
 =?us-ascii?Q?a8/xlDVfSgsyEYf5SR75FYXqk8RWQ9qkV6NU4RylTI56w0E+g1xJzbq8DGXh?=
 =?us-ascii?Q?6ZrUe4IZEH3iibWRsIWjFu6+aY7I6Tqj3eucbzqQCD6z5/kupCmWKJUSf2eB?=
 =?us-ascii?Q?trsc9qUB8se/sg/ucvyRBd4S9qbGOxvZP7La81W2H0nLr+7pPqRlPNaWUexg?=
 =?us-ascii?Q?5wOIQiyvQMtsVze/spTkGGZhgr4xWJb52Dwtm412/zgpU+TPgl0kMJ30XjR4?=
 =?us-ascii?Q?I/1akfk0vDRkd4XvH7UcvM4uj7k3C8CNURoyJTWlfT6zERCyoIctWsXKDMlT?=
 =?us-ascii?Q?CWa4/JCv62x+UaE9LNxKThX+DGdtyLfpkWgET5gRcnz/V/Sz0kJtYmqB6R6w?=
 =?us-ascii?Q?PNQda5+c6bhpIXR4fEe+uEk8nVXmLb0hwGeHsYVizLZQVV9yGizDIK1ie7WD?=
 =?us-ascii?Q?XlajBIb7xvkP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b41543-2ed6-4c82-f0ad-08db4c05b6e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:23.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+WLssMly0kMwkuTn//6FV2YCZRzlNtrBYvrNS1ahd8H5gCyMYywz8Pc8mDXmWQGgTqLoXu2hafsNC0l96CmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: 9nhU4Ogre3yPY_6OmZNS7cjMuCmvDRWn
X-Proofpoint-ORIG-GUID: 9nhU4Ogre3yPY_6OmZNS7cjMuCmvDRWn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series introduces a new proposal to implementing atomic writes in the
kernel.

This series takes the approach of adding a new "atomic" flag to each of
pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
When set, these indicate that we want the write issued "atomically". I
have seen a similar flag for pwritev2() touted on the lists previously.

Only direct IO is supported and for block devices and xfs.

The atomic writes feature requires dedicated HW support, like
SCSI WRITE_ATOMIC_16 command.

The goal here is to provide an interface that allow applications use
application-specific block sizes larger than logical block size
reported by the storage device or larger than filesystem block size as
reported by stat().

With this new interface, application blocks will never be torn or
fractured. For a power fail, for each individual application block, all or
none of the data to be written. A racing atomic write and read will mean
that the read sees all the old data or all the new data, but never a mix
of old and new.

Two new fields are added to struct statx - atomic_write_unit_min and
atomic_write_unit_max. These values are always a power-of-two and
indicate the inclusive min and max block size which the userspace
application may use. The application block size must be a power-of-two.

For each atomic individual write, the total length of a write must be a
multiple of this application block size and must also be at a file offset
which is naturally aligned on that block size. Otherwise, the kernel
cannot know the application block size and what sort of splitting into
BIOs is permissible.

The kernel guarantees to write at least each individual application block
atomically. However, there is no guarantee to atomically write all data
for multiple blocks.

As an example of usage, for a 32KB application block size, userspace
may request a 64KB write at 96KB offset, which the kernel will submit
to HW as 2x 32KB individual atomic write operations.

Since xfs uses iomap and extents there may be discontiguous, we must
ensure that extents have specific alignments to support atomic writes. For
this, we add a new experimental variant of fallocate for xfs, fallocate2,
which takes an alignment arg, and should align any extents on that value.
In practice, it must be same value of atomic_write_unit_max for the
backing block device. This allows the user to submit atomic writes which
may span multiple discontig extents. This does not fully work yet, as
extents may later change and any new extents will not know about this
initial alignment requirement. Another option is to use XFS realtime
volumes, which does allow alignment to be specified via extsize arg. In
both cases, we should ensure extents are in written state prior to any
atomic writes.

SCSI sd.c and scsi_debug and NVMe kernel support is added.

We also have QEMU NVMe support and we hope to share in coming days.

We are sending as an RFC so we can share the code prior to LSFMM.

This series is based on v6.3

Alan Adamson (1):
  nvme: Support atomic writes

Allison Henderson (1):
  xfs: Add support for fallocate2

Himanshu Madhani (2):
  block: Add atomic write operations to request_queue limits
  block: Add REQ_ATOMIC flag

John Garry (10):
  xfs: Support atomic write for statx
  block: Limit atomic writes according to bio and queue limits
  block: Add bdev_find_max_atomic_write_alignment()
  block: Add support for atomic_write_unit
  block: Add blk_validate_atomic_write_op()
  block: Add fops atomic write support
  fs: iomap: Atomic write support
  scsi: sd: Support reading atomic properties from block limits VPD
  scsi: sd: Add WRITE_ATOMIC_16 support
  scsi: scsi_debug: Atomic write support

Prasad Singamsetty (2):
  fs/bdev: Add atomic write support info to statx
  fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support

 Documentation/ABI/stable/sysfs-block |  42 ++
 block/bdev.c                         |  60 +++
 block/bio.c                          |   7 +-
 block/blk-core.c                     |  28 ++
 block/blk-merge.c                    |  84 +++-
 block/blk-settings.c                 |  73 ++++
 block/blk-sysfs.c                    |  33 ++
 block/fops.c                         |  56 ++-
 drivers/nvme/host/core.c             |  33 ++
 drivers/scsi/scsi_debug.c            | 593 +++++++++++++++++++++------
 drivers/scsi/scsi_trace.c            |  22 +
 drivers/scsi/sd.c                    |  54 ++-
 drivers/scsi/sd.h                    |   7 +
 fs/iomap/direct-io.c                 |  72 +++-
 fs/stat.c                            |  10 +
 fs/xfs/Makefile                      |   1 +
 fs/xfs/libxfs/xfs_attr_remote.c      |   2 +-
 fs/xfs/libxfs/xfs_bmap.c             |   9 +-
 fs/xfs/libxfs/xfs_bmap.h             |   4 +-
 fs/xfs/libxfs/xfs_da_btree.c         |   4 +-
 fs/xfs/libxfs/xfs_fs.h               |   1 +
 fs/xfs/xfs_bmap_util.c               |   7 +-
 fs/xfs/xfs_bmap_util.h               |   2 +-
 fs/xfs/xfs_dquot.c                   |   2 +-
 fs/xfs/xfs_file.c                    |  19 +-
 fs/xfs/xfs_fs_staging.c              |  99 +++++
 fs/xfs/xfs_fs_staging.h              |  21 +
 fs/xfs/xfs_ioctl.c                   |   4 +
 fs/xfs/xfs_iomap.c                   |   4 +-
 fs/xfs/xfs_iops.c                    |  10 +
 fs/xfs/xfs_reflink.c                 |   4 +-
 fs/xfs/xfs_rtalloc.c                 |   2 +-
 fs/xfs/xfs_symlink.c                 |   2 +-
 include/linux/blk_types.h            |   4 +
 include/linux/blkdev.h               |  36 ++
 include/linux/fs.h                   |   1 +
 include/linux/stat.h                 |   2 +
 include/scsi/scsi_proto.h            |   1 +
 include/uapi/linux/fs.h              |   5 +-
 include/uapi/linux/stat.h            |   7 +-
 security/security.c                  |   1 +
 tools/include/uapi/linux/fs.h        |   5 +-
 42 files changed, 1257 insertions(+), 176 deletions(-)
 create mode 100644 fs/xfs/xfs_fs_staging.c
 create mode 100644 fs/xfs/xfs_fs_staging.h

-- 
2.31.1

