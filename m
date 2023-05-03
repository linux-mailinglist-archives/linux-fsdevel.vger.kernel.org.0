Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE76F5F9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjECUDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjECUDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:03:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDF18A5F;
        Wed,  3 May 2023 13:03:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HowO3000746;
        Wed, 3 May 2023 18:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Uqi31ACeum0CeAaKd9sxHafDpmMy1GFIOFs8LzI2cOs=;
 b=mDA2U0pMxz3Z1pE84jLtGiOFOEfs1zcDjyMBve7uzUXkiWhdGCPtPo4vu81cETkQdwBD
 vv5vJmzW3A9aiTglpGKzQ4SYRLFhPF3/vPgMd/dYbjd9Ytz3XxmD3LEu9FkVcef4zckj
 wHyHug3yUg9LNv2yGUYzQcJumHw9yd29+uEFqxm5Q9naTGasg+YKbsvkHh5HAAojYquj
 A4hinEx/GIUCk7US02VpMjf5W99Tv61wUNlWfvpB7u+usI2g6YIYBn10kvgV/WNKwbHb
 cjcgnPRgtC0e56zoV0P8s3cVdwYWlsoUltZKPpfzcDxCua/ZabCoz05A8onC00qFM2FB TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv0184-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HEbSH027489;
        Wed, 3 May 2023 18:39:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdsj4e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apjeap5SoiJfBN52A4vNa/9Urj2wuUsv4tS7JgACa+8ifPFL3S2yWJWRYDs7hVfIHRvf3Mh/Frnpoj+JIiJ+7Xo6xIv3iOH7s//V1mqFGZPxmIajqofCCGIbMHzFb425SG6gz/ffH3edFdvIDF/6tbyFVgs/qjBBSYWWXs5aAu7hwxyhLxcwHdo6O6/cx7SbgDb3h5eKdTh9gUUwwS9Kq/rH7ucGYjyagCduX2FA72nA6GkxwT3Q2XqJaHrWOSAbKhFkIxlLbjAe4dK5QCrSqqikiLLBB7utAssIwskZJNqW0pL8/khpwddwjIDH3/moZ/lUyTDPK6ztQ//z20NFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqi31ACeum0CeAaKd9sxHafDpmMy1GFIOFs8LzI2cOs=;
 b=YEd2lfz0y0ai8Wn5533ZIDJlDuEq0YTjwiJtgTnS7UMHv1U/u33FchSpgja76OeKEg7/y5tp+mK4M1s8v5s4DtJtHHuLE25Uo1APp0vGv7a3aFZIc0ammM9clMtCjUQmRULYL3VMpJr91XpHTDaGzZxKbSw/ReMp1Auule4zn2WktgZyX9ktvcVRU6YHqOWX3ptLlkL2HZydSBMPvlnKuN4QTkBUOUMhEyr2l/8w8EAn2V76DL5fCIczbkc3fAXD10DnpAX/LpGLKEBEJ5CY9FOivjiaAfWfQyavaiJaRL3bJMPeF9TdCILgvDLKS54543RHa4Z0Juz2B6H+ccmI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqi31ACeum0CeAaKd9sxHafDpmMy1GFIOFs8LzI2cOs=;
 b=Jag26nUKIufb3b9m7ArTC+tRTycfwT4VXXkl3WmPrYvL1n0uJz4A/gFStAYs9XQaB5VD7HMF/Ngfn7QmSG1y/XYJeMPdUBMpiQpMRySLQqsD8cdOoa3Ut8dTKllkLxC9z/07eclX20YLXYP9BhTBCMd+V9yewTFoOKFWZNE3Xhg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:39 +0000
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
Subject: [PATCH RFC 09/16] block: Add blk_validate_atomic_write_op()
Date:   Wed,  3 May 2023 18:38:14 +0000
Message-Id: <20230503183821.1473305-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 66df7b92-5960-48ff-8ec4-08db4c05c0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0y/8JUiSCgu9U0d3TqAfEStIiz+yD2iOBZyHhGU7iinxrL2uQkRKCWgOcPYI1p7ymPyOGWNTOrtR6w9tX74VlLsjFbXxPS5WFaUrq8SwEhR77HVHcVEFVilica+TQ0hkY6Trf1Kqol8aLg27AI7HM6PA5kCFA7cfFP7XJSlwyy2v4rdBMgKudwZxZ1jAXkl4w6oamfld4nPPYq52yF5Q7SDFkLLsH45KukxIk89LW0dVr8bYeNbJvdAbC0DdDOenWLRRg051aOah6s/7jIICKwxV8jrDF1TRGlmnHJX+c7UyzbWIpyC/wbkleWN/sckzFKQne4gKuy6TKtQFpEFT/LpgQJtgcNap+dFsHP4zfCxzBYPGR5o8qnYR0/zSfMfNe2sORVnVoQ0U/m65WmE4DgE9+S/71+g4juwbpiRnf67TYbYkiEUv75VAqLi9IKbaSOMYBGM4jvAT99KtjOFE9nXlKptlzDGTPOb3mnZ3b9enfVYCm/iEMNpceHfozDog2kE61L6p934vne/yKU8Zx5sfguwtJcfzbVSwPoxQgssmjJ80FAUA5YoyZvjPHj2cqzaokcFpcWUbfUeD4lIfUBKV9/BSl/AhXDqm15lF/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqOzxhnvpCvBNV9cv7nnWcuS8LrFXvbOm5bgFMA53/PLyAxPC92NhaP9QoV+?=
 =?us-ascii?Q?xycOAhnuU1s7hqdGqwd8ZMzgqQHJsLi7SuXXcNqgaiYOgvtC7R73aE/FcF9E?=
 =?us-ascii?Q?tHP1gDjgt0WAf7o1Z5HxfuBRkrrDEIlYPAY6VMaTkuImUDXbclvcOidrQKmG?=
 =?us-ascii?Q?wvX+Kki9O7wPP1v5S4gteIpyQH7YG6INsyp1hHk7SG/ARaOuWmvacLgXECfD?=
 =?us-ascii?Q?kyW9mqdbXx6RMt3ydPG30yUOBTpy6uXfcFYv+r7YIhScAirvaBPPHCQ5kkq8?=
 =?us-ascii?Q?lVCPAnWrBNFeP3ZeS00ucXc1weuZ4bM/AVdbQMECx8EEwUzCexhHex49cyLF?=
 =?us-ascii?Q?0EcL24SSRB6bChwE8EBiZ+zsmG/a4dAa3W5nnOfl8YFFxiTkMTu1Fb2qF2AF?=
 =?us-ascii?Q?BHIJ3i5z7y1mKfiSFWOAfaipBu2BfUnRZbmWSOLuD5074insDuLpXwXri2NR?=
 =?us-ascii?Q?fqEBRyD/Wkp6vRqPEKjKde/sZGSzIwwK+SDm9ybNb6hsrfe/cADExsF9kgPO?=
 =?us-ascii?Q?HxlygY7pSrkJINFf1x2ai3SrKStKn3zHq3vK7sS2zkiR5KeT5gxiP5k95vkf?=
 =?us-ascii?Q?VvaJtfnsqvUG2+pXczZYzZtzC4zDW7DaX2NxpGkCLM54YtYQIEl66JRgoT/g?=
 =?us-ascii?Q?QxnK7dMbf4TSNnzrJdv3p97q8xFK41ICoxFBOY2J1p4DB8549mWgcItGBPoV?=
 =?us-ascii?Q?cZeZfZ44J9vpWrXTYBuFbKOjBQGN71eTUi3KUkpPrtdySOprEA09/icQnnf6?=
 =?us-ascii?Q?9ECVF8Uaqjh3OYXOzsUE/8mCerYyKOlPI1q7Zm+zWuOiqbqXWi7a591kjRcb?=
 =?us-ascii?Q?g1zKoTwjyRdnaMrHQR50Cf2kkNv9hT/9o2oVPHU5l3uXyYTbo5/LH6dGBiiN?=
 =?us-ascii?Q?ULsfTm4kInNyqfxYh9eSqdqIYxcQ+F5ztrKNVcHtqOVNChr8fYflizstzbC7?=
 =?us-ascii?Q?XI+jWYJPvUc+Oh7Ar45Nj4Jz7lYG5cCV3z5SNuG7nkD07qBp03x2p1Dhk5Oa?=
 =?us-ascii?Q?iBvnH87dKsAIht17prsv/bZX8g4UG7y5rG6Gnh7YU4BMMd2FaQUxaLIPXdsL?=
 =?us-ascii?Q?71jssPN6PGNCRNh9QI3CYH3ox9oFmsRtxkinak4G3sCGpvaFgzqkfoDM+BHV?=
 =?us-ascii?Q?wuX1vI30q/aUhoGwBOqgoVMbStOirAuK1HA14M1MYBI9COWkQJlDFHOwzLxD?=
 =?us-ascii?Q?rsVb6ehVPisgBqn5/oKkanstELIN57OPadwdZ3BANEQ6nI53KnV8cY3OB+nl?=
 =?us-ascii?Q?L2uEsa2BH/r4A0iNuP6FuER2H+3Xzs4cOz9tiP+Kx5fCEvxPFrHgkSJHmmtZ?=
 =?us-ascii?Q?wuWt3BA7qFs34N1E3349LkEz9BmwDb9AtxSmGBvwiIC2VuS6SAwMGmFx4sq9?=
 =?us-ascii?Q?YGtnBedNTJlRGVsQAjOQqTKlQ3wBykuLFcHB961ry3tAVTMhjp34L62/Jk2N?=
 =?us-ascii?Q?YobixtM6IIkibt3KOhtRoTD85wTmfSiiLsFepoBSRvyXwtqDrPjuOuaF87kr?=
 =?us-ascii?Q?1qErAHYP4iSey4ike/1Z2zNQrn93gF7CkhwkklDEBxLenjJIeFcEESihZ/+M?=
 =?us-ascii?Q?w6HmGDqVGNlFXkRhg/qnLKLG8fD98hcdGmURNk3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Kohvrn3oGkxox/AhRwZ8zA4N5Q98SPOf6nwMKSz95BXTMOnjragZLV/w03bZ?=
 =?us-ascii?Q?ypv1QuhGUnVZWXpwDaVc6UztPfq8LloXBpKMmmTQvaqrID1XheY6Cq/AAYX6?=
 =?us-ascii?Q?jHJHueuPEUF5K0pPeBg7nIfEp6Defy0fiGZKJKaKwEgvwNVOC9nPmCze7nEk?=
 =?us-ascii?Q?w+2glZqqeV11YC1rdUpECjNhM+C1mkO3to6NX3A9v2kM/pbCo/1BrEUhePDq?=
 =?us-ascii?Q?LJaJWogGFPlbMmwVirDUw9QEajs68p0XbYuRlkBvFP5GzvCzLIWHtCicIpgW?=
 =?us-ascii?Q?XSNqxyTz7iusNKgIm9w37hk93fyKroEghaQPdVfdzht7avtgp5S8JPzN4Ee6?=
 =?us-ascii?Q?u7++2CaTrfn9NNRRAa1XQyF6124KteHKGQEOOGPk1sNsfMgCX4mb69jL9OEB?=
 =?us-ascii?Q?rK8ozowFGgmdgZ7u/kvJWMWSItdgU8ShO6cjN0BBemWe973KbDOMLw1Rtssb?=
 =?us-ascii?Q?hn3cElXbSpmWB45pF6QDmG5mgI/di08I+inlLz/FBjMfbe+gmLLKdIHu9pDI?=
 =?us-ascii?Q?beOtRSj/npxXOtRIhmfdK302RCKlFcBi55qUN3ofI/+ALfBZA3Dr+2oAQeYi?=
 =?us-ascii?Q?9nf33oWM0U0iqBAUmWc5qAxbDyb1K8d7CYwWXqZOpXVI87Ak/oN2lbtq74ng?=
 =?us-ascii?Q?IdqDwwP4BB905+gXLispUlckOJC0WaUrYxqhKQPxyRgLgWFBPiuOKUk1m2C/?=
 =?us-ascii?Q?Ijbos2H1oMgTAxd4y3NHDUWUQcleWlIB6UIdcIhx1OtS8qqrAqKeGpmWMPX4?=
 =?us-ascii?Q?3W3YGfRgT9Q5JeppjlQsoQl/9j9eG7lEuwOaOUOYjutAxsh+Y/HUz5X2XcqB?=
 =?us-ascii?Q?cjiZu8q0/ofQJToc+oHNIQWtdvN0fJf6mXWJ1SGvFYEZPlfQ4IQITFxy2icy?=
 =?us-ascii?Q?xW7SqiDqVTI1Hen+XifE9an0fXmrti/IzqCdZvT2CM3QCN+0yobcFfPoKxaX?=
 =?us-ascii?Q?sdgu4Ogi3PWH1MwOkaom6HPjDcDsiym5b1wRz976fpEsn/dI0+A9uw37Aq85?=
 =?us-ascii?Q?UJs/cQ1lBKT2PpeM8KOdzzAKsyEjx0Vj7FLIvU0t38uQ4tZcTSiIA/yDA2tg?=
 =?us-ascii?Q?OwmD4no2vZDpm9ngVohnMoiphSwPl66t6MKJ2FqqY0L1OfWiBxpZY5aCRmyE?=
 =?us-ascii?Q?zWzsVspSY3Rs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df7b92-5960-48ff-8ec4-08db4c05c0da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:39.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpmqYbHy8//MJlKdiuEubg+PPIjk0bLp9y6MOCmbJhLccNq2k4qSkHkwirpRHcjlmLR8qlQEENzk3feQc3AGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-ORIG-GUID: vIfSSdPp-NrN1NAR2gTgwLEFpUhWkGP3
X-Proofpoint-GUID: vIfSSdPp-NrN1NAR2gTgwLEFpUhWkGP3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Validate that an atomic write bio size satisfies atomic_write_unit_min
and atomic_write_unit and that the sector satisfies atomic_write_unit.

Also set REQ_NOMERGE - we do not support it yet.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 42926e6cb83c..91abf8cc2b62 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -591,6 +591,27 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+static blk_status_t blk_validate_atomic_write_op(struct request_queue *q,
+						 struct bio *bio)
+{
+	struct queue_limits *limits = &q->limits;
+
+	if (bio->bi_iter.bi_size % bio->atomic_write_unit)
+		return BLK_STS_IOERR;
+
+	if ((bio->bi_iter.bi_size >> SECTOR_SHIFT) %
+	    limits->atomic_write_unit_min)
+		return BLK_STS_IOERR;
+
+	if (bio->bi_iter.bi_sector % limits->atomic_write_unit_min)
+		return BLK_STS_IOERR;
+
+	/* No support to merge yet, so disable */
+	bio->bi_opf |= REQ_NOMERGE;
+
+	return BLK_STS_OK;
+}
+
 static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -770,6 +791,13 @@ void submit_bio_noacct(struct bio *bio)
 		bio_clear_polled(bio);
 
 	switch (bio_op(bio)) {
+	case REQ_OP_WRITE:
+		if (bio->bi_opf & REQ_ATOMIC) {
+			status = blk_validate_atomic_write_op(q, bio);
+			if (status != BLK_STS_OK)
+				goto end_io;
+		}
+		break;
 	case REQ_OP_DISCARD:
 		if (!bdev_max_discard_sectors(bdev))
 			goto not_supported;
-- 
2.31.1

