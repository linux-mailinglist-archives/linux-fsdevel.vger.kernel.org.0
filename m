Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF136F5E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjECSko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjECSk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0850C72A5;
        Wed,  3 May 2023 11:40:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HooCI017481;
        Wed, 3 May 2023 18:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=lvqx8GUfu4cSwEIYiUW6w2zBGGM0MZkm6cA9ZdS9qqE=;
 b=TEiRPVkE4l/q6studKoxHheT/timOUUagFAPXeaNzH0ISv95JhlVb5lTF/nrQhOnwkeQ
 WX6nJZQjZhFkinsnRu+FXXIif6JaTQdwstvrqiQ9D18us807ueT0rfpvvH1HuUYYOWFP
 VaJc9TxJPNI3Bk4JQxHQ9DlcABONUQtVrMx6Oe1HFH815HKbePn5SpG98oR5F0NWVeoZ
 ZMHNfdShUg+1wJM9jGVMkwACWNKxjdRj8h5v3b+ZFSuZR5XW20eA5hdStVlEFkjsztP7
 Vn3b7eiIAUHfpsKMcfs7TRApx5PSFqqkWk1khC55Twebv46ZV4QN4cKD2CdB/dwWtPQV ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aqygn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343H3gfp010067;
        Wed, 3 May 2023 18:39:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp805p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1i5uqp58yWLmTE8L1Ui2Eloy6hhQ/smBUIdWB6Cm6gPbvOxbOOCwEqs+PI/U5R+yldrjBuhjfWdr+d4g4gwo+x9yawnzfniZcKEZtLjn5vfg8n3iGsYbu7NWP3G2gsfpuHm7A7hLHdmvoVQQBSDPUzovbpOVwgk8QFWVxjg43eMj9yEPqgV4vql6hc1x6tVV4+04AV/fWVDP5DHpgLYhfKzv4yXrGavnF9UHks6nhFutjetnR/3BWMLiZ8rvPYh/Ee04qTNq1F8J1ddXdb462OGGIdvikK18V6AGyxMT9uyYQPaN4L5As8CE4pNi6aZABL0QeHbtO3gud32BBCBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvqx8GUfu4cSwEIYiUW6w2zBGGM0MZkm6cA9ZdS9qqE=;
 b=gplbmRlUOcQtsJdU0l2NKkKWKWs69dcxWBB/VopL5OsXVnbrey86lJDU5dFY+6GnU+g+uvhux2HrLtYg239j7X3iiklJ7GmLYL/ykJrG2zaI9x0bnKQ4ZeyOQjLMmv9fW4xlipyzYY0iqgiNwqwRY7F9YIfGwlvG6HhSadbCR+eYjO+o4OIErLcqPAbHgcGgiQg3z1yuLcnsbcFdZticneno+C3NYTL/qY9aCI5U+Njh5VJldosz/a69wdpBchqz07dkarhwII5foIJlHjugJNrI7n0syDrV2AZSRaMu44J1fZvXtDwDWQ0xWT5RRfBqDv7Dvq9ICYXL0vwQ/t83Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvqx8GUfu4cSwEIYiUW6w2zBGGM0MZkm6cA9ZdS9qqE=;
 b=Ax4gGPsthr5syLZPDQohteRXIkobI94mhlim+FbzwN8d17Ekk1PGiR6m+e2IG0xq1OZ9j4qmZ+Jw81TgTv5PfRFk7VadIwSe4yYkMyqkMzhixP0VBYNuIIaEv4rWp5vZzmyoFnq76LgfIbx+i+zdlTNQtKKHcL0Q9jdN/JWdfNY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:39:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:50 +0000
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
Subject: [PATCH RFC 11/16] fs: iomap: Atomic write support
Date:   Wed,  3 May 2023 18:38:16 +0000
Message-Id: <20230503183821.1473305-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:208:122::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d74b584-661f-4046-d34e-08db4c05c6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVUfWohHGOhBwq/Cc9WZtHvMtqQR8PmS3BPKGggrhNuIiQKxYIVAueULLqI/QZvZTIL2t0omFYAWXvCP/M8tjv0wUC7Ieuf3J3b+GFq+/DJGPCcIjsNFuq9Yw9Js9iYPLgSX02Ipr7gx6c1rvzNur642JD1pD1Qv/Zr4AHlA8UgcjunEHmWk0wc++l2hPJQ6EYfe46of/60u+DP4Gem8VgXdgIoehQjUlPR+gW6DnKal2pVGI/7deuepGvi7iVybc0XAXioeLY1a47g5wEskSNnL2ck1kR6dCeu7FwQjwCSWYv9qRSr0kdAS9W3B6THHxgFejCFrjFq9I2Bz4ppJEbo5DB/gGmeje5inxj/HATXisYfqiVGNQXQ+NpFv2WTmQrqnvmLrTB9vmkDr6olNdspHNDMjS3sRrHYPI6Kf7zSf/njQqnb/qTPC4n4AkIAmJNcUYRbVLrI5YCMGATbMAsqD9+C4GJJy0vIDdmidnOcAbX66sLrq1TEoEjgT8YlRM5gCc2dFc7Zlox45YHYBJrfAWv4YGNywy8zFkuw2IqPFdf5G7AizCEuRG4u1Zl6fjRrUK5SHYYwBMB1K8hM/oNY2HMa51CrccqohiKY4RDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(107886003)(6512007)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(921005)(4326008)(316002)(66476007)(5660300002)(66946007)(2906002)(7416002)(8676002)(36756003)(86362001)(103116003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gaGPNPmBDoYN5/X48GUnB86NI2crtTSw7+pf2cm8P+bra3+pZBDFGeQDXuuy?=
 =?us-ascii?Q?w7OxugOKD8l2zU77HFhmbXkabBzahuzwIL119f3ARbHp35nHcP1wleEMZtU9?=
 =?us-ascii?Q?uLFWOKxV9T4Q85E7f3kimcn8WZwpO4SFSil1n6YJNxwNMCIunXQoSPXSLwdj?=
 =?us-ascii?Q?rp29ky4tJwovQ7gQLLDN11IwNOR+6zaOgqHmfYUaylNCgnd8FZZUuDUgNFYT?=
 =?us-ascii?Q?bY3ipGabjAR5/7gECJ5sEM4K2ot3wGsodZhUkR3ci5Yw4ufPwwGCvs2RyJtU?=
 =?us-ascii?Q?6G/raZYoRrW8UJLZca3UNYp8fRwbqWW+BzKQy1pGKzF0OF0QXQuSZHMGhc/7?=
 =?us-ascii?Q?X7CGvK1rp2kmtpC+a8byZMdXBOkpjHEXT3Av25CPzjhRuHoSKf7xheNMH9Ty?=
 =?us-ascii?Q?vUyL09ga/yublcRYBbMHw8RvQkGM2qR+VZ+Ylbww6Q6ySbSH3kYiXC+8vnYn?=
 =?us-ascii?Q?Sfql6NHvieKyZ1a7a6A+DiloSvHmr5uBYoYg80YG0zIsffBYgQ6yYF0p2X9Q?=
 =?us-ascii?Q?HAqrpGATB7MIPlEPp236SMOf/LNIORmbFFWIrPJqAVjJPN30ObSYh9hHZe1j?=
 =?us-ascii?Q?GjiDFIwh39uvR+ifz+bhcZ3okFR66Hi/VsYTT2IrEI9bi+a8tmLeCYFnjaB7?=
 =?us-ascii?Q?QNDnSR9J6/pFIfYeOvOl5PA1TUGs+L45zYPfmGAaH5cs/V26Vv2R9/lr18MF?=
 =?us-ascii?Q?2YWbKpdG1kJ9HacQF0htgxzvnXbADUhomLiN66oRsHXe9jGgq1BYTznYwCzT?=
 =?us-ascii?Q?DfgmUfj0YxWyg6vmi0AKmoCVV+YoYO+81wrAzjhQSs+QSxjqHI4q8KuUzRsg?=
 =?us-ascii?Q?aV2AYoJLbys7bhOGN8wqg6JraW8+MWiPGO5I9em8/1gDwCGTBXFG8hXxOYvf?=
 =?us-ascii?Q?RAe+cKh9q66aTJeUHrxSwZqTkQVjEGl/DvhYBCwUnt8ev28DKiFUkO8gl/qB?=
 =?us-ascii?Q?z24ciIHHjp6hOaWk2O5AdWzK2tVzSERue8aMm/tjzBQbYHKhL/4y+2gKiq1b?=
 =?us-ascii?Q?rQ/GyjgNnAxWJ/eaLgdwVfA69ihfT6Jtvl43uq4WIk2mR0beRFqQHczvyE+k?=
 =?us-ascii?Q?xKa7yergOgkwLg1pfbZdA6b7EmFhUgAP7msYBKjL2yexPN4tIY4oanKLaNwr?=
 =?us-ascii?Q?dc7CYXRbB0Gt33clCse1YSzgbCFeP7bzbZiHyzFMYuEb0FkqRgMksk8XXeg2?=
 =?us-ascii?Q?kikYBcDUqj4IFJGKzO3LDSy6cy3/AwJrc+fzGhOv4gF3aYf+7SQyeb8vxVKW?=
 =?us-ascii?Q?uepG+vuKkb3I072Lkxi3AMQda7jY3IXco4VGW912g7KVgVliv9iLJFqZESew?=
 =?us-ascii?Q?P9jGSNsuvGhqz/Ar+nO8u2sSrLJebPSh1W+w70XehUubgbJBCroE/uumb9+7?=
 =?us-ascii?Q?OiwMaWFZsbZ2/ZQFsgY7By3TgcJudmB62YJh1f775VZKZhSqX+yt9CdKnbR+?=
 =?us-ascii?Q?CHNKfACTOkVPrKTd9D0FzmHVSkWNcDPqG2ALs1tkYlYJJj9jNmj19OiOBD9t?=
 =?us-ascii?Q?KHj1dtpfhbVuqsRFY5cp2iYIQHYwctrsvzvRNWHK/+O6k30TlIMJIKiHgBfu?=
 =?us-ascii?Q?18Q+4oKa4Yq/GrPpobqgNIog9Kd8qAfNjveXnr2p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?j52HxmKGBG1Eqp+w0BJGkAixvVXOPYPgZCNkYnwIQ+pa85We/iVmg8RRce7G?=
 =?us-ascii?Q?qrALdfjynRnaZLMeMfRPrHMrUz5Tvi1DpI9q9u0J/AgKxw7WxwKLG76F+rrx?=
 =?us-ascii?Q?vDbc0z3iF+eT+BqK/S+1jk9J7Ji0sgmPAY9zyC3JLjw850iaEL3CWZaRU4Td?=
 =?us-ascii?Q?N7vz7jN8LCISKBqMbyjycAsdG/3xwi809Hi/xlwJlNlTFj2eRmdyYYF7Rgvu?=
 =?us-ascii?Q?XtXbQ40m+sTFRQR4tBTPxhBmZgi7e/6BZy60kNWdTshWzco6j3vUBRX5OpUu?=
 =?us-ascii?Q?EaVhStfose1ODgr54SwfrmDs4Mk6DT7rpw69FNsEuhFEcHtFlh4ch0DfwyDr?=
 =?us-ascii?Q?Gq4hR/juXYwWiVIb0faiwXmQDLJOwXpgCUgBic2mXwgNn5k99/MmcBG7O3a4?=
 =?us-ascii?Q?Mvr4L3CBGfVlIyv/fl0ka1pmF7XWQAcaI95Z/H2EvIhIMsszCTqhxeyOnUyI?=
 =?us-ascii?Q?ovJMZriXmINTKyBqWHW2yuO3ddttbtRv3tSTxSdCQGsN6iFfwDXzu5MtaiYk?=
 =?us-ascii?Q?zQ61ZxdeRPSA2WaTyuGieLmLevNNutjFpLDljQJKociiv/rDEpAnG2QUTMz4?=
 =?us-ascii?Q?zAQciV9AV22lkLVVJh7p1KaQwLDVKwZo4uYDCLTm5OgvFdW6OzaWStE4zChf?=
 =?us-ascii?Q?cHYc+75aRaaRsDUcnPIwKiycaTGSDvWtOQhPkjwK+ZLO4p5wA15zw6qFS+Ic?=
 =?us-ascii?Q?QhyirnlqlVfiZDHBnOcWk0R3Fl40//HhR1SBtZefF84C68bkM95EoUIz66cf?=
 =?us-ascii?Q?9n8FpPzk42Jfap0KPGOPWT4xIE6vQCRrE6zfFeelZWDR/2JmdvSA4zxhW4GJ?=
 =?us-ascii?Q?wg/BfjsEQ5lrigCPSbf3g86bDZOpCRLM2nhMvwifBJWlGJWpyKfJqVUGyPYK?=
 =?us-ascii?Q?SGJGh5NCsnWFs28J7XDSXN/kEjcchON5ABUOk+ypXwX9H+ZYbZfHMuWA1LoU?=
 =?us-ascii?Q?gRbNNvsvgJ4PZi5C6xk5zo81ZUoJAfIuuSsEdje/sTtueLLHbrzqTNece1nC?=
 =?us-ascii?Q?PVrMCbhxdf4oX0s+VZUi0yd4sbaKioWJ1pFiceUWwoppzbKmFyuDteACJXzG?=
 =?us-ascii?Q?BRIWvZW2T9P35LD4kWAtjhCbLehrai4lQLv4xT7nqu6p/tp+jK3xaB0PcSDK?=
 =?us-ascii?Q?XLW2bFVTF4Ae?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d74b584-661f-4046-d34e-08db4c05c6ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:50.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qMKPZ4jI0QWpQ35W5ip5hGmB7ND0/KA2g5S9UciZSr+yBvhOQIRRFeba6fOKGPuzZQGVfNY7JyaniW1Ubi9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=971 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: wcMl6Sz-pT9PVe-ByDhJaESc_Gyt4HsL
X-Proofpoint-ORIG-GUID: wcMl6Sz-pT9PVe-ByDhJaESc_Gyt4HsL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to create bio's whose bi_sector and bi_size are aligned to and
multiple of atomic_write_unit, respectively.

When we call iomap_dio_bio_iter() -> bio_iov_iter_get_pages() ->
__bio_iov_iter_get_pages(), we trim the bio to a multiple of
atomic_write_unit.

As such, we expect the iomi start and length to have same size and
alignment requirements per iomap_dio_bio_iter() call.

In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
is not dirty nor unmapped.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f771001574d0..37c3c926dfd8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -36,6 +36,8 @@ struct iomap_dio {
 	size_t			done_before;
 	bool			wait_for_completion;
 
+	unsigned int atomic_write_unit;
+
 	union {
 		/* used during submission and for synchronous completion: */
 		struct {
@@ -229,9 +231,21 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 	return opflags;
 }
 
+
+/*
+ * Note: For atomic writes, each bio which we create when we iter should have
+ *	 bi_sector aligned to atomic_write_unit and also its bi_size should be
+ *	 a multiple of atomic_write_unit.
+ *	 The call to bio_iov_iter_get_pages() -> __bio_iov_iter_get_pages()
+ *	 should trim the length to a multiple of atomic_write_unit for us.
+ *	 This allows us to split each bio later in the block layer to fit
+ *	 request_queue limit.
+ */
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool atomic_write = (dio->iocb->ki_flags & IOCB_ATOMIC) &&
+			    (dio->flags & IOMAP_DIO_WRITE);
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
@@ -249,6 +263,14 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
+
+	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
+		if (iomap->flags & IOMAP_F_DIRTY)
+			return -EIO;
+		if (iomap->type != IOMAP_MAPPED)
+			return -EIO;
+	}
+
 	if (iomap->type == IOMAP_UNWRITTEN) {
 		dio->flags |= IOMAP_DIO_UNWRITTEN;
 		need_zeroout = true;
@@ -318,6 +340,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		if (atomic_write) {
+			bio->bi_opf |= REQ_ATOMIC;
+			bio->atomic_write_unit = dio->atomic_write_unit;
+		}
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
@@ -492,6 +518,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
 	struct blk_plug plug;
 	struct iomap_dio *dio;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 
 	if (!iomi.len)
 		return NULL;
@@ -500,6 +528,20 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
 
+	if (atomic_write) {
+		/*
+		 * Note: This lookup is not proper for a multi-device scenario,
+		 *	 however for current iomap users, the bdev per iter
+		 *	 will be fixed, so "works" for now.
+		 */
+		struct super_block *i_sb = inode->i_sb;
+		struct block_device *bdev = i_sb->s_bdev;
+
+		dio->atomic_write_unit =
+			bdev_find_max_atomic_write_alignment(bdev,
+					iomi.pos, iomi.len);
+	}
+
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
 	dio->size = 0;
@@ -513,7 +555,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.waiter = current;
 	dio->submit.poll_bio = NULL;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
 
@@ -567,7 +609,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret)
 		goto out_free_dio;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (!is_read) {
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
@@ -592,6 +634,32 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	blk_start_plug(&plug);
 	while ((ret = iomap_iter(&iomi, ops)) > 0) {
+		if (atomic_write) {
+			const struct iomap *_iomap = &iomi.iomap;
+			loff_t iomi_length = iomap_length(&iomi);
+
+			/*
+			 * Ensure length and start address is a multiple of
+			 * atomic_write_unit - this is critical. If the length
+			 * is not a multiple of atomic_write_unit, then we
+			 * cannot create a set of bio's in iomap_dio_bio_iter()
+			 * who are each a length which is a multiple of
+			 * atomic_write_unit.
+			 *
+			 * Note: It may be more appropiate to have this check
+			 *	 in iomap_dio_bio_iter()
+			 */
+			if ((iomap_sector(_iomap, iomi.pos) << SECTOR_SHIFT) %
+			    dio->atomic_write_unit) {
+				ret = -EIO;
+				break;
+			}
+
+			if (iomi_length % dio->atomic_write_unit) {
+				ret = -EIO;
+				break;
+			}
+		}
 		iomi.processed = iomap_dio_iter(&iomi, dio);
 
 		/*
-- 
2.31.1

