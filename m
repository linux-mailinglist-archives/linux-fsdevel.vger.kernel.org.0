Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10B6F5E47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjECSmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjECSki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284E6E8F;
        Wed,  3 May 2023 11:40:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Howes000742;
        Wed, 3 May 2023 18:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+Cp1sxUB/MNfv+6Q3qg8WcBvazGRnue6fiNhdmifPJE=;
 b=cJGMlmHHa8IQXCP0o7UbYmVdhnIOUXeaocLowqo7qSOgvPfij4uJavoNGbObPNil4JJG
 68Zu1rxDaBOUFzVoySqFd4YAGSweNMiU8MiYV5Lw1ufvch5JbL72jI5TiY3yC11N0hNr
 XQHymNdb/mwEa7pSJ4EsEmiw9CVKmsqw0KA/1/Gu0989nEg8cmJoHGXuZxejRkboU1W3
 2Skj5KhFsjR3HznhIiUyiDRDbCeAcDJ+zQGapjWyJcQtJ51C6BOKR+e9PSNFT0vXgGpL
 tltFbxBDufTG88+Ruzi510u0KGqYmSmnpddqAndM/0Zt26CYi01y6nUVpdM4TqUVmzGc TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv0196-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343H6LBT026767;
        Wed, 3 May 2023 18:39:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdsctk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoKPuytrqutrt2yYIQzxP6x7U9PPO2TbzJlmNR+99iyoyG7f7Ni9Of+/xVsmoYW56hn1rsKF85UrGVQL8hEXHQC/am6mRAyquuZOeDHK0v4QnUivirQo0YXyi0g9yLRdVb0GsbfTdPUZ1U7K3a6neUYtRHZgmu/4axw2JU3RpLnSXiqAgDZYGqpHIV50CbKpPbi6AI+VFCnvjCuIFysg81gAbHTLQ6kKfmlZlmzL062pZiZSzTamJkNmHhx/TIZl5vb5XfCfKSZUjxKhLqNecrbJ1bCDmhrxT9Cx9mQ482UMLXGi34+BgOGkk7T4hAEnSfTTx38BcWQtLeBefuuSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Cp1sxUB/MNfv+6Q3qg8WcBvazGRnue6fiNhdmifPJE=;
 b=mJXDVrEy4z2Ww11WD7K0tnCBOgMaU+hx/EYd4fdhW21809un8XifX5oD6IRyJPJwEwmBJC5xru9oLZ6+oAJazK9dQG46+++3+qOB+cluWfmW7n1BthMXz1tvCeTr9NvSNKkP8bWDqaxztVekFiycXrG9fVOjMFEsisUVa2pbB3tHb2uMsvYX7NEfMIB7Q9v5Y1B/QdQ2CuuOHPlRA4lPDY14V3WobotoTFKWRZFw5BXVKVGRT/qn8mX4f0/s3FuuITSANQg1qosiEuyP9iqJVKrlOGEKrj2p0P3bLzSBQuelV1Lr6z1kzirWgNgSg//1TRA8AWKv8F72gYrNmChUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Cp1sxUB/MNfv+6Q3qg8WcBvazGRnue6fiNhdmifPJE=;
 b=jTGcPZ0JKV9OIwFYm9YI2+P+0ajQM6nb6YdhfEyo/9zQeuy2YO1OKSHxeEWHGMLJx07ed/KF4eoX3AvmHqDyge5Jyk2qkkRJxRqG1pcKtyUs5yjcj7I2m84hTDF0z9nb4R9w9av2kqYgLdi0hYtsgdj4k7HEiMkNl+aeoQm0cUc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:39:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:56 +0000
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
        Allison Henderson <allison.henderson@oracle.com>,
        Catherine Hoang <catherine.hoang@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 12/16] xfs: Add support for fallocate2
Date:   Wed,  3 May 2023 18:38:17 +0000
Message-Id: <20230503183821.1473305-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:207:6::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: aac9dec3-7b02-4b0e-2068-08db4c05ca61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Poi53n1FcNLAMu8IjGr21vvw7k3fd4ecunOdubcYANt2tJpJav0ks17z8/UfBF5+052+ELHO8N5vzCBGMJX7DVlySy0yFsjsuSoQv2SbKYm0j2Nd9XpJWoVBXSmiRpvHE1uu8Ys9m4Oik22DGalqn81mZFfku0BYHvHkM1/Qn/lD1is0tjNANLBIXp2zBLQ4/QYoutV03q2quhQAM3X6CdIwNbsmehiNq2T9ASQ21vVyycITlulMTFSaZKYuLqWi65V0PW+6BuhRvYB+o4I/JbF7WPksSiszJlSVXietTpBi00vdhsRpuf8FkhMJJBNf7BqYzzdUvgQhaXuSbfgkV18f1Gf2rd4egRhETivynYtQDbaoa56wwH6euBSIAkzLlqqIqQhc3+HwIOXvZxae2tcHqw3I48uMRLmErYZBsEwHOv9hYg+GBKc/0P2wPCkyrL3InLZJwY7dfl5ILv0dSNrTqgKWBGMN8LEauoWaGnARCH4buelLh8ykJPpIPJAwWuRnVfmhxS4cQN4db967ANda6KZrn07pGRmhRvmrS/qp4UQH6TbwiRYvgX4xkUvshc6mqd2XWw5VvIWiMifNhURrtsHSp5FG1BeZkR6rtVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(107886003)(6512007)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(54906003)(66556008)(921005)(4326008)(316002)(66476007)(5660300002)(66946007)(2906002)(7416002)(8676002)(36756003)(86362001)(30864003)(103116003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cETvpVwgqdsrTiaV6DuNT5rHM0NTmOxFCk0Zmj3zbw6bdOaKJw0mlvixqs1?=
 =?us-ascii?Q?beObC2zl2WfvM4kDpGWr0Juhm9ClXEqWttim1/hLl/iLp2NTXJArQqBMP3n4?=
 =?us-ascii?Q?RMr7PY6UAgxmK2eiM/uNjpPvl9jAXYoL75EakJjWv0xOBu4Kt0Tcc34/E6GH?=
 =?us-ascii?Q?4qBYYnHktV3ZtlHv0feS22MCGDpKGUA7dCq+rxQCngL6gy4tXK6WwlxkMy/H?=
 =?us-ascii?Q?gKlSTtwXjydzr1BrpBQPaPZH1o6bVfwijHsTAbtY78mS+tCyjxBd0Rfm0Lfc?=
 =?us-ascii?Q?e59LsO+p2Ot7ND06STSzWPVhxpr+vI+3bA/MaLNOqVmiRkp+OLTrp4xAOmIA?=
 =?us-ascii?Q?P5kEEWMY8kpoFNk6Pf7tnQu2XYtLQaPKdsmz4gO5TpZwxadIAmFGYwfX6ftB?=
 =?us-ascii?Q?I9RgK71vIOCqV8viIjeSjgwu2RlOWhqNnKQNPfvi5Fkpm3GvqgDTO3wpy19J?=
 =?us-ascii?Q?cmV/7KFDfbU9kHN+uQTv0EAFzqwR6Pmf5KqyQEbwAD8BiNGCm0UDF/1zbQBT?=
 =?us-ascii?Q?mDhbPZZLWDtVVZTbYWZ217S3BCB3d1DjXGPwfMrVzvDiMFkGR1ofCXahouyI?=
 =?us-ascii?Q?usDgaweJD5gmjQ9sG2TbnQAzfP6zof6LGsSOd2wkSpmu/tm0UoXaC02UUkTS?=
 =?us-ascii?Q?g1tGRhaQk9m6HYQLRDuD/5AQ1Zxlw1qzrYZljQx8NXqIX0hkgAiw6iHQX+KG?=
 =?us-ascii?Q?jnCQK0W2JpNh+zrVKJ1zIS7P/bK+dq5JFBsgQ9lfQO2u9MYq6CnWeK4xDNnl?=
 =?us-ascii?Q?bxfcMVWD2kevHPc0LtorkSQuvkqU4Ze6jRGgRUN6bA6CHCYcesRoOC6D+0o+?=
 =?us-ascii?Q?2GkUokF0tX7A6ACH2zK1aJBVj+Jx3PbSQDS3hHZJP7rQdEa/xgrflZibv/ZQ?=
 =?us-ascii?Q?RpxMqoka7jDkJOf4NrlvPOX5jW7HBdDQTx/acIf0hMg+yzDiuAFi6c1oa1qM?=
 =?us-ascii?Q?oJi00jxPhuwCejZC0rUILLGuelqWQcK1MCOPp/NiyH7BDZLvo2Rp2YjSu1PO?=
 =?us-ascii?Q?bXq7tn2I4Alt1yST/vumxU/CkidLIdmo4HMjQSKygaNoDckrq4rb+rryz7GI?=
 =?us-ascii?Q?bTJwo18dBjD4Xb5Vb1BXGHE/kyRq6UK9oO/rPf6kDlTv8o2xC3HC/asqozP5?=
 =?us-ascii?Q?Stz7CoSqRniXWIt/hLdHef+mvhNhmnR1hwYh6r00g25O1mMSL/EyrYw5LEGA?=
 =?us-ascii?Q?81RL06gG049DFUsZdWl37J1s1MkMGHBcTKfoLpzw4UlPeegmXYt2Y3l+MAsD?=
 =?us-ascii?Q?Jo777RZa7LTA1INc6FpOr9Myh2Rog5PB+NqO7S5D6GHSusR2Tf+DRpGM9Ez+?=
 =?us-ascii?Q?hEc1KW1X08Qac7tZmeHpvY6aStbTY64zcjItqpm1RHSwDdzt+jkWXr764ljb?=
 =?us-ascii?Q?9CRRhuok6puinXXdII+vMd95j/p+ci4g2guBsAL2jdErIGqMSteJC/nUwyey?=
 =?us-ascii?Q?nK/I1rBlh34uIlRm4IPsOgCOWsclWKnsmVI7D5xRt8XC+uSSM7U5ZI3STlpz?=
 =?us-ascii?Q?fcZOutSatkL/zu8o/++oNci4lwrYDtv1cJ4LPHxrlGk56yWV/27a7rMwoRRv?=
 =?us-ascii?Q?gL0yn7RxpZGFkTyNHq9eBerC/Ms2qG/U5J1d05dg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dSfR9JZMEYXU+VPWzDzZJfwWQgZOtMHR+Ga/YMU3EHFEnKzmGnYPxJ0T9B+v?=
 =?us-ascii?Q?OREKEz46Xutwvnw7Kxbp8cRpJbtYPfX57K/37SL886w7kFekENarbaHp4ff6?=
 =?us-ascii?Q?Xa9xCamosUhcmCOE6+9Q7El6PnNalW3jnAFWre6gDG0nLyKwCpCp7OlYUBGq?=
 =?us-ascii?Q?8WZ8guB8p508HUUTA24HowCvU/ROnhsfYDw28a7o0UCfDICxXEnMCc082A+e?=
 =?us-ascii?Q?pmhNn2XHj7JiKiC3KKOTHOOYi45fSR/X3XhOsMMPes81mVrop+l65JnR7TCk?=
 =?us-ascii?Q?HMs/sOJKMU5ywvBFEr1VgHaWc+9rWmYqMvYDGKc5YwpqrjU70aggpFD0gH/V?=
 =?us-ascii?Q?qmJXd+2aKmgOwHUSEtVFDrp7L1oS21md6VtKExJGun3sq8FeO1Nd3J9SOoah?=
 =?us-ascii?Q?7bVljWVyOpQZx6Jd4wcxdSs+NMhFwgZyVc1ydPw5urhiG+t467WLB5zIntPH?=
 =?us-ascii?Q?3C6FbctpjDoE3Ts73ZY4eGyAuY9FiVTR9CVqqDJ2kaCT8dAosZeWwxlkGqyg?=
 =?us-ascii?Q?FbWl3H0D+mtT6QCITVs55RZhrzXx1qCmkANWHm5BfD0JbpZwcgW91inxI+2F?=
 =?us-ascii?Q?fCGSLuTpRa1ZYR9QBv56nCMr6ajtP4XFH5t4SCgFpm2fANAnf5i5Atv9o6oP?=
 =?us-ascii?Q?dpbuI2M/++VIezsJgNzylFzWGjY5rjGaxnL4PIuvhAtm+cUf6tOsUGifPuA0?=
 =?us-ascii?Q?8jm0/ZIuzo44b9vbyArOzft82n83EQH8rRtMoLjjhNN5R61jU2HJZ7PlxZuM?=
 =?us-ascii?Q?iWrYkVKtZWKPNvUYX+ILKB9Bd54kLMSN2m68uJvvz25XTuoqyT69ENaIjGNh?=
 =?us-ascii?Q?8pAr41zkggvIGBkrMPxDUKvYpElHfKpYFqVhFxiF7E5EHcJwEn5WJuI7Pc33?=
 =?us-ascii?Q?qHc/hPfohOIYC2DlB4SC+lHfe1CZZLYultoeTor2BUPb4i6tp5PW7doMRegI?=
 =?us-ascii?Q?kKmvp8BIL54ppPLo+azVnS0cuzy0iQM8pwima0cc2IIZ13GS7u/JPptKU32Q?=
 =?us-ascii?Q?fGBNbxiOk5blOfzdPUm0c00wnsKQSwXD9eACnCX7zOQ3DZYtQXYj5JEXv56R?=
 =?us-ascii?Q?z+wSMpQT8PDv2lZJ6GBRkRRQYFC2pF6AXn5KrbyLmSAIDtrpnwYyHsl8/TIf?=
 =?us-ascii?Q?uBO0FZXnr27i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac9dec3-7b02-4b0e-2068-08db4c05ca61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:55.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uN7oGBbexHaDcuEmR5F60qEDuSsdOodfr/9ezHQU8YvZBJg9ibqGRnujOLivUUZJ/4LBRZ1x/yJWzLcsZNPz2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-ORIG-GUID: z5mx54VPjaI4ngAjkrmQ0DUg8PlijNWe
X-Proofpoint-GUID: z5mx54VPjaI4ngAjkrmQ0DUg8PlijNWe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Allison Henderson <allison.henderson@oracle.com>

Add support for fallocate2 ioctl, which is xfs' own version of fallocate.

Struct xfs_fallocate2 is passed in the ioctl, and xfs_fallocate2.alignment
allows the user to specify required extent alignment. This is key for
atomic write support, as we expect extents to be aligned on
atomic_write_unit_max boundaries.

The alignment flag is not sticky, so further extent mutation will not
obey this original alignment request. In addition, extent lengths should
always be a multiple of atomic_write_unit_max, which they are not yet. So
this really just works for scenarios when we were lucky enough to get a
single extent.

The following is sample usage and c code:

mkfs.xfs -f /dev/sda
mount /dev/sda mnt
xfs_fallocate2 mnt/test_file1.img 0 20971520 262144
filefrag -v mnt/test_file1.img

xfs_fallocate2.c

struct xfs_fallocate2 {
	int64_t offset;     /* bytes */
	int64_t length;     /* bytes */
	uint64_t flags;
	uint32_t alignment;  /* bytes */
	uint32_t padding[9];
};

int main(int argc, char **argv) {
	char *file;
	int fd, ret;
	struct xfs_fallocate2 fa = {};

	if (argc != 5) {
		printf("expected 5 arguments\n");
		exit(0);
	}

	argv++;
	file = *argv;
	argv++;

	fa.offset = atoi(*argv);
	argv++;

	fa.length = atoi(*argv);
	argv++;

	fa.alignment = atoi(*argv);
	argv++;

	if (fa.alignment)
		fa.flags = XFS_FALLOC2_ALIGNED;

	fd = open(file, O_RDWR | O_CREAT, 0600);
	if (fd < 0)
		exit(0);

	ret = ioctl(fd, XFS_IOC_FALLOCATE2, &fa);
	close(fd);

	return ret;
}

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/Makefile                 |  1 +
 fs/xfs/libxfs/xfs_attr_remote.c |  2 +-
 fs/xfs/libxfs/xfs_bmap.c        |  9 ++-
 fs/xfs/libxfs/xfs_bmap.h        |  4 +-
 fs/xfs/libxfs/xfs_da_btree.c    |  4 +-
 fs/xfs/libxfs/xfs_fs.h          |  1 +
 fs/xfs/xfs_bmap_util.c          |  7 ++-
 fs/xfs/xfs_bmap_util.h          |  2 +-
 fs/xfs/xfs_dquot.c              |  2 +-
 fs/xfs/xfs_file.c               | 19 +++++--
 fs/xfs/xfs_fs_staging.c         | 99 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fs_staging.h         | 21 +++++++
 fs/xfs/xfs_ioctl.c              |  4 ++
 fs/xfs/xfs_iomap.c              |  4 +-
 fs/xfs/xfs_reflink.c            |  4 +-
 fs/xfs/xfs_rtalloc.c            |  2 +-
 fs/xfs/xfs_symlink.c            |  2 +-
 security/security.c             |  1 +
 18 files changed, 168 insertions(+), 20 deletions(-)
 create mode 100644 fs/xfs/xfs_fs_staging.c
 create mode 100644 fs/xfs/xfs_fs_staging.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 92d88dc3c9f7..9b413544d358 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -93,6 +93,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_sysfs.o \
 				   xfs_trans.o \
 				   xfs_xattr.o \
+				   xfs_fs_staging.o \
 				   kmem.o
 
 # low-level transaction/log code
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index d440393b40eb..c5f190fef1b5 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -615,7 +615,7 @@ xfs_attr_rmtval_set_blk(
 	error = xfs_bmapi_write(args->trans, dp,
 			(xfs_fileoff_t)attr->xattri_lblkno,
 			attr->xattri_blkcnt, XFS_BMAPI_ATTRFORK, args->total,
-			map, &nmap);
+			map, &nmap, 0);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 34de6e6898c4..52a6e2b61228 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3275,7 +3275,9 @@ xfs_bmap_compute_alignments(
 	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
-	xfs_extlen_t		align = 0; /* minimum allocation alignment */
+
+	/* minimum allocation alignment */
+	xfs_extlen_t		align = args->alignment;
 	int			stripe_align = 0;
 
 	/* stripe alignment for allocation is determined by mount parameters */
@@ -3652,6 +3654,7 @@ xfs_bmap_btalloc(
 		.datatype	= ap->datatype,
 		.alignment	= 1,
 		.minalignslop	= 0,
+		.alignment	= ap->align,
 	};
 	xfs_fileoff_t		orig_offset;
 	xfs_extlen_t		orig_length;
@@ -4279,12 +4282,14 @@ xfs_bmapi_write(
 	uint32_t		flags,		/* XFS_BMAPI_... */
 	xfs_extlen_t		total,		/* total blocks needed */
 	struct xfs_bmbt_irec	*mval,		/* output: map values */
-	int			*nmap)		/* i/o: mval size/count */
+	int			*nmap,
+	xfs_extlen_t		align)		/* i/o: mval size/count */
 {
 	struct xfs_bmalloca	bma = {
 		.tp		= tp,
 		.ip		= ip,
 		.total		= total,
+		.align		= align,
 	};
 	struct xfs_mount	*mp = ip->i_mount;
 	int			whichfork = xfs_bmapi_whichfork(flags);
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index dd08361ca5a6..0573dfc5fa6b 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -26,6 +26,7 @@ struct xfs_bmalloca {
 	xfs_fileoff_t		offset;	/* offset in file filling in */
 	xfs_extlen_t		length;	/* i/o length asked/allocated */
 	xfs_fsblock_t		blkno;	/* starting block of new extent */
+	xfs_extlen_t		align;
 
 	struct xfs_btree_cur	*cur;	/* btree cursor */
 	struct xfs_iext_cursor	icur;	/* incore extent cursor */
@@ -189,7 +190,8 @@ int	xfs_bmapi_read(struct xfs_inode *ip, xfs_fileoff_t bno,
 		int *nmap, uint32_t flags);
 int	xfs_bmapi_write(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_fileoff_t bno, xfs_filblks_t len, uint32_t flags,
-		xfs_extlen_t total, struct xfs_bmbt_irec *mval, int *nmap);
+		xfs_extlen_t total, struct xfs_bmbt_irec *mval, int *nmap,
+		xfs_extlen_t align);
 int	__xfs_bunmapi(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_fileoff_t bno, xfs_filblks_t *rlen, uint32_t flags,
 		xfs_extnum_t nexts);
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..e6581254092f 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2174,7 +2174,7 @@ xfs_da_grow_inode_int(
 	nmap = 1;
 	error = xfs_bmapi_write(tp, dp, *bno, count,
 			xfs_bmapi_aflag(w)|XFS_BMAPI_METADATA|XFS_BMAPI_CONTIG,
-			args->total, &map, &nmap);
+			args->total, &map, &nmap, 0);
 	if (error)
 		return error;
 
@@ -2196,7 +2196,7 @@ xfs_da_grow_inode_int(
 			nmap = min(XFS_BMAP_MAX_NMAP, c);
 			error = xfs_bmapi_write(tp, dp, b, c,
 					xfs_bmapi_aflag(w)|XFS_BMAPI_METADATA,
-					args->total, &mapp[mapi], &nmap);
+					args->total, &mapp[mapi], &nmap, 0);
 			if (error)
 				goto out_free_map;
 			if (nmap < 1)
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 1cfd5bc6520a..829316ca01ea 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -831,6 +831,7 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+#define XFS_IOC_FALLOCATE2	     _IOR ('X', 129, struct xfs_fallocate2)
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a09dd2606479..a0c55af6f051 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -776,10 +776,12 @@ int
 xfs_alloc_file_space(
 	struct xfs_inode	*ip,
 	xfs_off_t		offset,
-	xfs_off_t		len)
+	xfs_off_t		len,
+	xfs_off_t		align)
 {
 	xfs_mount_t		*mp = ip->i_mount;
 	xfs_off_t		count;
+	xfs_filblks_t		align_fsb;
 	xfs_filblks_t		allocated_fsb;
 	xfs_filblks_t		allocatesize_fsb;
 	xfs_extlen_t		extsz, temp;
@@ -811,6 +813,7 @@ xfs_alloc_file_space(
 	nimaps = 1;
 	startoffset_fsb	= XFS_B_TO_FSBT(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSB(mp, offset + count);
+	align_fsb = XFS_B_TO_FSB(mp, align);
 	allocatesize_fsb = endoffset_fsb - startoffset_fsb;
 
 	/*
@@ -872,7 +875,7 @@ xfs_alloc_file_space(
 
 		error = xfs_bmapi_write(tp, ip, startoffset_fsb,
 				allocatesize_fsb, XFS_BMAPI_PREALLOC, 0, imapp,
-				&nimaps);
+				&nimaps, align_fsb);
 		if (error)
 			goto error;
 
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 6888078f5c31..476f610ad617 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -54,7 +54,7 @@ int	xfs_bmap_last_extent(struct xfs_trans *tp, struct xfs_inode *ip,
 
 /* preallocation and hole punch interface */
 int	xfs_alloc_file_space(struct xfs_inode *ip, xfs_off_t offset,
-			     xfs_off_t len);
+			     xfs_off_t len, xfs_off_t align);
 int	xfs_free_file_space(struct xfs_inode *ip, xfs_off_t offset,
 			    xfs_off_t len);
 int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 8fb90da89787..475e1a56d1b0 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -328,7 +328,7 @@ xfs_dquot_disk_alloc(
 	/* Create the block mapping. */
 	error = xfs_bmapi_write(tp, quotip, dqp->q_fileoffset,
 			XFS_DQUOT_CLUSTER_SIZE_FSB, XFS_BMAPI_METADATA, 0, &map,
-			&nmaps);
+			&nmaps, 0);
 	if (error)
 		goto err_cancel;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 705250f9f90a..9b1db42a8d33 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -883,12 +883,13 @@ static inline bool xfs_file_sync_writes(struct file *filp)
 		 FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |	\
 		 FALLOC_FL_INSERT_RANGE | FALLOC_FL_UNSHARE_RANGE)
 
-STATIC long
-xfs_file_fallocate(
+long
+_xfs_file_fallocate(
 	struct file		*file,
 	int			mode,
 	loff_t			offset,
-	loff_t			len)
+	loff_t			len,
+	loff_t 			alignment)
 {
 	struct inode		*inode = file_inode(file);
 	struct xfs_inode	*ip = XFS_I(inode);
@@ -1035,7 +1036,7 @@ xfs_file_fallocate(
 		}
 
 		if (!xfs_is_always_cow_inode(ip)) {
-			error = xfs_alloc_file_space(ip, offset, len);
+			error = xfs_alloc_file_space(ip, offset, len, alignment);
 			if (error)
 				goto out_unlock;
 		}
@@ -1073,6 +1074,16 @@ xfs_file_fallocate(
 	return error;
 }
 
+STATIC long
+xfs_file_fallocate(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			len)
+{
+	return _xfs_file_fallocate(file, mode, offset, len, 0);
+}
+
 STATIC int
 xfs_file_fadvise(
 	struct file	*file,
diff --git a/fs/xfs/xfs_fs_staging.c b/fs/xfs/xfs_fs_staging.c
new file mode 100644
index 000000000000..1d635c0a9f49
--- /dev/null
+++ b/fs/xfs/xfs_fs_staging.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Oracle.  All Rights Reserved.
+ */
+
+#include "xfs.h"
+#include "xfs_fs_staging.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+
+#include "linux/security.h"
+#include "linux/fsnotify.h"
+
+extern long _xfs_file_fallocate(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			len,
+	loff_t 			alignment);
+
+int xfs_fallocate2(	struct file		*filp,
+	void			__user *arg)
+{
+	struct inode		*inode = file_inode(filp);
+	//struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_fallocate2 fallocate2;
+	int ret;
+
+	if (copy_from_user(&fallocate2, arg, sizeof(fallocate2)))
+		return -EFAULT;
+
+	if (fallocate2.flags & XFS_FALLOC2_ALIGNED) {
+		if (!fallocate2.alignment || !is_power_of_2(fallocate2.alignment))
+			return -EINVAL;
+
+		if (fallocate2.offset % fallocate2.alignment)
+			return -EINVAL;
+
+		if (fallocate2.length % fallocate2.alignment)
+			return -EINVAL;
+	} else if (fallocate2.alignment) {
+		return -EINVAL;
+	}
+
+	/* These are all just copied from vfs_fallocate() */
+	if (fallocate2.offset < 0 || fallocate2.length <= 0)
+		return -EINVAL;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
+
+	/*
+	 * We cannot allow any fallocate operation on an active swapfile
+	 */
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
+	/*
+	 * Revalidate the write permissions, in case security policy has
+	 * changed since the files were opened.
+	 */
+	ret = security_file_permission(filp, MAY_WRITE);
+	if (ret)
+		return ret;
+
+	if (S_ISFIFO(inode->i_mode))
+		return -ESPIPE;
+
+	if (S_ISDIR(inode->i_mode))
+		return -EISDIR;
+
+	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
+		return -ENODEV;
+
+	/* Check for wrap through zero too */
+	if (((fallocate2.offset + fallocate2.length) > inode->i_sb->s_maxbytes) ||
+		((fallocate2.offset + fallocate2.length) < 0))
+		return -EFBIG;
+
+	if (!filp->f_op->fallocate)
+		return -EOPNOTSUPP;
+
+	file_start_write(filp);
+	ret = _xfs_file_fallocate(filp, 0, fallocate2.offset, fallocate2.length, fallocate2.alignment);
+
+	if (ret == 0)
+		fsnotify_modify(filp);
+
+	file_end_write(filp);
+
+	return ret;
+}
diff --git a/fs/xfs/xfs_fs_staging.h b/fs/xfs/xfs_fs_staging.h
new file mode 100644
index 000000000000..a82e61063dba
--- /dev/null
+++ b/fs/xfs/xfs_fs_staging.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Oracle.  All Rights Reserved.
+ */
+#ifndef __XFS_FS_STAGING_H__
+#define __XFS_FS_STAGING_H__
+
+struct xfs_fallocate2 {
+	s64 offset;	/* bytes */
+	s64 length;	/* bytes */
+	u64 flags;
+	u32 alignment;	/* bytes */
+	u32 padding[8];
+};
+
+#define XFS_FALLOC2_ALIGNED (1U << 0)
+
+int xfs_fallocate2(	struct file		*filp,
+	void			__user *arg);
+
+#endif	/* __XFS_FS_STAGING_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 55bb01173cde..6e60fce44068 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -4,6 +4,7 @@
  * All Rights Reserved.
  */
 #include "xfs.h"
+#include "xfs_fs_staging.h"
 #include "xfs_fs.h"
 #include "xfs_shared.h"
 #include "xfs_format.h"
@@ -2149,6 +2150,9 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case XFS_IOC_FALLOCATE2:
+		return xfs_fallocate2(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 285885c308bd..a4389a0c4bf2 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -306,7 +306,7 @@ xfs_iomap_write_direct(
 	 */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb, bmapi_flags, 0,
-				imap, &nimaps);
+				imap, &nimaps, 0);
 	if (error)
 		goto out_trans_cancel;
 
@@ -614,7 +614,7 @@ xfs_iomap_write_unwritten(
 		nimaps = 1;
 		error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
 					XFS_BMAPI_CONVERT, resblks, &imap,
-					&nimaps);
+					&nimaps, 0);
 		if (error)
 			goto error_on_bmapi_transaction;
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5dc46ce9803..a2e5ba6cf7f3 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -420,7 +420,7 @@ xfs_reflink_fill_cow_hole(
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
 			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			&nimaps, 0);
 	if (error)
 		goto out_trans_cancel;
 
@@ -490,7 +490,7 @@ xfs_reflink_fill_delalloc(
 		error = xfs_bmapi_write(tp, ip, cmap->br_startoff,
 				cmap->br_blockcount,
 				XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0,
-				cmap, &nimaps);
+				cmap, &nimaps, 0);
 		if (error)
 			goto out_trans_cancel;
 
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 16534e9873f6..a57a8a4d8294 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -817,7 +817,7 @@ xfs_growfs_rt_alloc(
 		 */
 		nmap = 1;
 		error = xfs_bmapi_write(tp, ip, oblocks, nblocks - oblocks,
-					XFS_BMAPI_METADATA, 0, &map, &nmap);
+					XFS_BMAPI_METADATA, 0, &map, &nmap, 0);
 		if (!error && nmap < 1)
 			error = -ENOSPC;
 		if (error)
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 85e433df6a3f..2a4524bf34a5 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -269,7 +269,7 @@ xfs_symlink(
 		nmaps = XFS_SYMLINK_MAPS;
 
 		error = xfs_bmapi_write(tp, ip, first_fsb, fs_blocks,
-				  XFS_BMAPI_METADATA, resblks, mval, &nmaps);
+				  XFS_BMAPI_METADATA, resblks, mval, &nmaps, 0);
 		if (error)
 			goto out_trans_cancel;
 
diff --git a/security/security.c b/security/security.c
index cf6cc576736f..d53b1b6c2d59 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1593,6 +1593,7 @@ int security_file_permission(struct file *file, int mask)
 
 	return fsnotify_perm(file, mask);
 }
+EXPORT_SYMBOL(security_file_permission);
 
 int security_file_alloc(struct file *file)
 {
-- 
2.31.1

