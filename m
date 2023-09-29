Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75137B307F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjI2Kdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjI2KdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:33:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F4E2D4D;
        Fri, 29 Sep 2023 03:30:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Tnb022482;
        Fri, 29 Sep 2023 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Hh+sabUZxE5t2AiX2F92C3C2r0/XAU9GCIRsPHsFTZs=;
 b=Gma7xSSZfduChzJi3RPPJ+McYgYEzaknUCgHEPQgoH9MKFurBqYn7/k5EDl6snbG51lq
 E5+vTypnr+dZd0WU+PeS/N+U1gpzYLsX/7t6x2D+5mlc4viVg1axsVpc3QrzSKKk5PNZ
 2Hj1V4DKBHagRIAuYdLEoVQYIIPYsYL1/+0C5epfKzQh39IRS9BwUsRAj3AiORcyF5cd
 r79Jz5yIbwfRZQLTWcpbcxoPx3Ld3YoJeTLwtcP6H1ylmwiFHUeDjG2g7vtGFniDgeeC
 KlpjW8n6ZYxqEWjnJbS120Zr34YWVs5iwhUsOgkDsnXXt1UWgAlIYqyBtEeMoS9yakqp Xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbpbqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TABUBD013823;
        Fri, 29 Sep 2023 10:28:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbmm66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqqH+lRomskUYQzXI1b2vxADsKcHXpGt5Ih2pIC1JMRqRv0B06Lh8nWjrZ7dIqO+6PmaKduNRQgMi8mnSLIwXb61u2ibGww9tzLPgwc3QHe6fXpvM5JjEbHZthOc5reVKmxiJ5z0xrQlRJDbnYXkcMAH78b0K5cY9U36q+cwuGrTuvT3vKB9+r80X83CfjMSIGinGBiugjN+3trRxkrohsoA7fK/qJ+Q+ymP1gpmapkUTXUv+7tKPjMiL85AP/Nnqzkft4vn28FTeQW+wZ6NZxsX7F/ujXHUG1hJBb8+NcfalREODyHGL7iMG+aeLMTVtV/q1ituDe20mctU4odLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh+sabUZxE5t2AiX2F92C3C2r0/XAU9GCIRsPHsFTZs=;
 b=i6EBr876oZKMm2pYB7+bbtRy9x7In5IqWu7vvFbbZsPCo9WlMdpSl/CJ2lxMrMF8JaCq0zKde0Jg+C7MFW5K8xHyQiEM4Gt0+a6a+D9J9dmC61eYLR16OoIK7A4VE0/G0U5+fzs8nT+dWqxhwRSKqHohEampr5/fBT1YUFSVJv9nmrTuuEf6CrqU9ooKE1lcLLMVLFYExBQenXHNm1Lkde1iBk/kwnSFdcquJoMMZtg0oUdPLMnRQ9V40/nFH+FLZsadEknInXmMO9eKk5pk9edtcHd8VRkKW3TbgR9618wZQCQM/YJD5O4mvkahK2Oijx8UJJGiYocJB1HDTw1AEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh+sabUZxE5t2AiX2F92C3C2r0/XAU9GCIRsPHsFTZs=;
 b=YzglmD9q30v9imVn5xBhAjMUEMZ0Bi7gtf49lP+xTlcIX96OdCaPkYA/of27r0NfTndygZz3E1MrVhRhhLiNlYpYqZHeMPDO3inXODaq/CLp47fpCHMy+fyoC2glLKRasQkD+79M495ZPnyiNjvbbIuCdZk8j5eO9bABdTcTQA0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:06 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 05/21] block: Add REQ_ATOMIC flag
Date:   Fri, 29 Sep 2023 10:27:10 +0000
Message-Id: <20230929102726.2985188-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b4c389-a7e3-4d3e-b064-08dbc0d6c53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxgFImOCVtINpTKD8krUJ7umirg4r1OibYnawZ8zqSA1IZUb9P1xYck0bY3GBuDYQFqKWGn9jvFnos+d11kB+oOFVdsQDVz07m/tZ8o49u9BrvIofo3xXETeurUB/7ArJ18LmKjYzH4c5cgBPciNV5pvtTQ695E6S2zs9C6XhmhIXVMUmEniXQFa+fRVoJCqQNmQYlZ+zreCs6oRdE7mtLrp2+V67GGwfefutoIpIgdXl97LYcAQh93sM3tv1xzLSYeOFb9hk5Ukw3ewrQA2bjYJGaVpvPddOTjZ36gqNpW5D/MQxlYMeK7envG2gVt9M3QFcQB5Qz5XHxh+9w3wGDOKXGIinZEZaZo/tuUqYbGhB87xu2fpU8kYJjlgSkwBBnrbaU/Uin3it5T4EOtrlMZF+RG5RyPpaQcDCyfnRWdIp9yHDKbf8vEu9o52NkDOq7uN/9DGjoJNu7YjxJpaReJgsaG7K6yThykHs+XCy82a8jOlcrr220WGRrUZAZJZ2a+4gf+nGjttMGorMQh5mt3HhpjcDQU6wir1WrFA5AKw6YjfF/p5PSmsjZ/q5HeRlLm2FZyKJmtNybzjNJ9KZ1bl8q/Mn0RtWdn9egO38hA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(54906003)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBadnKgVVmU6/v/HZgKrBwHVv447xrhff9ygR96b4kmAumXF/uwI5onc3GFw?=
 =?us-ascii?Q?TTrhfi4xpZ7mcXok1cCKyT6NHqfggIGCy9ubZsl/DuFzgF2N18JhoTe+gtEv?=
 =?us-ascii?Q?9gQqP9poAu0MEzV0HacKdV5GbZgnFJNZrCPdYMHlVYRe1px9TLGGSSawvrqj?=
 =?us-ascii?Q?tevIqh1s1O3Mb+XorKJ1EwQb4MI7Y6vHYwmALf+EM8PhAthgNSuAI4UCd0sU?=
 =?us-ascii?Q?1o30S30roaaXeJrsnhYNBVpxd7+lypvRIiujWYQLROVaLPf17k7+Bjfzs4qV?=
 =?us-ascii?Q?zj3RPslvz3BVe2h0KMShcxHiImWHztqZEAU0XZJ5e/pyS06pEVwjbIylKKjE?=
 =?us-ascii?Q?dlF5ZNLLCBWGgA0/hkvg0THDxeL+APKtHuugU9Pw9xC5iS74x7i2egulfY6q?=
 =?us-ascii?Q?30k2VcMXCyUTLEk2klLR3Ijs8bX+uKDQZ6Xv9J79U71CyRlZ4MzAbXPoxCr5?=
 =?us-ascii?Q?/HAcFchP9ZF60nW7qeYfezryuxc0YBlmPsyG0FQ9BVgMeeVUESoNRMPJWRPW?=
 =?us-ascii?Q?cQxRaorlHpIqQHza99FXjinRs+vaaLs8ETM7bNCva8q6CDUZPaB/9/l4iq3t?=
 =?us-ascii?Q?L9Ye73nT4imAB6XVb6df5pUWjnbV9vgnf6tpu4YAV/GWgYEfeiEuM4SehLjd?=
 =?us-ascii?Q?4/irKZ71Xrdi/2zxrIqHJgtIeDoS6K1jxR23MqCZebqRWK2XqFRgEkmD1/OR?=
 =?us-ascii?Q?/2zc8qTXitrL6URgy+mM+HjkNm4eS93M/KVb6GkhWkFXE6HfeN1jW35LV6wb?=
 =?us-ascii?Q?EAEWPkweMDPR/DPSBJqHM516azgX2JUhfEHnSqAHX+H1+xpEd1UyHSBWoU16?=
 =?us-ascii?Q?zUg8O2ok3J16YBB9CwAM0HtvcEO/kyR1NuRpKkUPIY8SVcD5M2oPUlH2i1PS?=
 =?us-ascii?Q?/VjUgdinqCP2uSi3fVl4CmjlKoBCxH3V3gG1zLzTdKPRR3lVKHqNRbqMavLI?=
 =?us-ascii?Q?SR/uIyWSvvg2w/L8L2Q/6l1BIWDa/MjL8ZRe7RqtJjT3uyMM2G/srhv7Romx?=
 =?us-ascii?Q?9OoytIS4NzD0PLKnqEyhkRHqxOV65yjRnp1llmw9v5EidZTq0L20FByS/Ljn?=
 =?us-ascii?Q?F7h0Q8QuoYOxLXn1jmrelmFoqsgUIhT1TZMDdweZ1jqqX4dJ4olhCQbZ1nlE?=
 =?us-ascii?Q?wk6J2dlGb6uAqXVCaB2zwV6KLkyaNgkGINXbnkTRg2TW6QyjO4bcSYPzGckY?=
 =?us-ascii?Q?KsjwyEpMIXRKDYZMyW3IUyJ4au9b0qhPPpbW8LttHcUCad9c/Fl0dXAGULyR?=
 =?us-ascii?Q?LiU3B7bxeSpT6pb9nJc8JmY9DdcP4K6yNQRUqbfJjHJAX3g/dHvC2ef5kw5y?=
 =?us-ascii?Q?NVENX6zshQJLAKpE7rW4r0xbCyyKKaULZcYAYTmJlOMulb+kgDTyXyW384lv?=
 =?us-ascii?Q?ISc82igcWREGpTawIm2g/tum3cfR62dCq6ZniOQ+cZ0wBsIgWFmz6Bk0s0yh?=
 =?us-ascii?Q?hu3hiMsAfqpkfRVzSesB7w0RDFjY1r0cm6/qMMJbaIkS8HlWl3C41Y1JcsGR?=
 =?us-ascii?Q?qXqABPajxdcLFN6wHQwtRe44rK+cIdvASrQ1NncP9zBVRYVA8MtLX7lXuOEF?=
 =?us-ascii?Q?URQmMWfDqBccnd4QiVsbzd7FMcYVjFDoClr2Tp+kUP7rtpM5MV3FU0rJjAnd?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nR7/HShnQuOC3QSUT8MdW8pYTtfaxWzJHFAAUxj2tDMrgj7CKAXk9l27HEJ5?=
 =?us-ascii?Q?kEt5qu8/2NMc3ur2kUfbJZQiNw7ilndfbz6sB3BHMbNhzPE95ZKEyzo9xS7U?=
 =?us-ascii?Q?jPWu11WQUeNR5ml9m1eA5+E0WpYZEeObhqwvc47BZcFjnG8X2gSK6cF4D1uR?=
 =?us-ascii?Q?u2BQO7fp1S0Nf/8PyOoz90rjWsRiZRsLl22SmMgY2jp5pXccOsgTkk259M7p?=
 =?us-ascii?Q?askua+eR+gKflemYQs+CNfC1vtsKtYXBZ659IQGChfaXry5N0TeD+AwIXYL8?=
 =?us-ascii?Q?ggY2PMMcE7nfGbsqBo6PcorVJgaj7eKkro+b6Djv1dW8reg7SyZFV7ATElJJ?=
 =?us-ascii?Q?mYrjGxkpBWqrizlXwq0vs8MEXRxTDewCmDEemKzpjiw62AEQ/NieTANaeb6/?=
 =?us-ascii?Q?aEEhUFJbc3Ejb8d5tUfo8MELTEpmTdHE1xxO32OiFlqtQjTOY8QPelP3c3WX?=
 =?us-ascii?Q?zPHDdGcBwt8tm4pei7qvIr2pDtczQQ+izWZGKI7NTngJ9BHuKdRTt9jvhvaI?=
 =?us-ascii?Q?I8HmdSb37D4lATny3ko5e3ENeeLrTUY/0uKc623FaqxeAPQtesanf+dH7Hpm?=
 =?us-ascii?Q?haWb6YF2YFpHNp5uYIVbvYNyWBiWTF5WvqADTD3sBjEQtwkiKtyIgdwmHp1s?=
 =?us-ascii?Q?x/Lm452MA67BEOvHax8hfENHEdiuRFvycWQyfCsxG7Cv3iyODRZ85IxgYmbz?=
 =?us-ascii?Q?RURFJcA76p3qETsXEF7wtvh97rHjoOqydF9ANc0mbsHXrEr1829NHluxPBdr?=
 =?us-ascii?Q?aFkw/UH8tEeT1DxzwY4pKwPm9XSDEl9cRAp4JHdrTYf2S4maRnBNYVaNFqUI?=
 =?us-ascii?Q?EjiUqzvgbmiPL239oSRnd5vkO1Bae4nTWbFWFgDd7T/nwPh/Wa8MMdIB6nib?=
 =?us-ascii?Q?7p+gf9rErdS3nGp0/ZaNfA9Z55+67x4jRp1RzbczbIoZgmtT9uzjmKHee6BV?=
 =?us-ascii?Q?L9VWsmyTm+eMLlJGPD1J0nCqfl0OiIAwSdJ+LT8jAvMrQ2InnH8sP6F9770O?=
 =?us-ascii?Q?99Qxteu+kR2RptOa9Ml3irtwg9qFVtAJZgI+Q3mP94xg8rH6CkpiLteghnrm?=
 =?us-ascii?Q?IR9l8c8R3ocGbpILDGbcdFj9ZrqoxA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b4c389-a7e3-4d3e-b064-08dbc0d6c53a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:06.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzRdQidvWD+zsF4H4LryETgguHAhOwzkxCFwi2lrbOO0h4/FfxXc/zxX2oSNuUGShNv47h0zGZ/RGJATXS9pqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-GUID: GNX09taFMZ4gaOV11LxQ5sjX4Ms9OD5G
X-Proofpoint-ORIG-GUID: GNX09taFMZ4gaOV11LxQ5sjX4Ms9OD5G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add flag REQ_ATOMIC, meaning an atomic operation. This should only be
used in conjunction with REQ_OP_WRITE.

We will not add a special "request atomic write" operation, as to try to
avoid maintenance effort for an operation which is almost the same as
REQ_OP_WRITE.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..4ef5ca64adb4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -422,6 +422,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 
+	__REQ_ATOMIC,		/* for atomic write operations */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -448,6 +449,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
+#define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
-- 
2.31.1

