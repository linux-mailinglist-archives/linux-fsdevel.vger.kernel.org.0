Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0B7B3073
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjI2KdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjI2Kcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:32:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BB1725;
        Fri, 29 Sep 2023 03:31:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Qm2019170;
        Fri, 29 Sep 2023 10:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OrC0Fag0ZjCnhamzeJYJ/FvefehU9bX9q+eUQrZEQEs=;
 b=NCjQsYbiSAh4CJZhaacYGiW/099XpY9wTpQaJDoneRjV3nQn8/pH5ErvZwKEexVv9eK2
 uHOJtLGXPIKrm31NwujZDaIPbZJY66k875NVfdj+QbejNVInbAjqWOlUsSlRlbK/8Zmr
 FYz7EHfwF+l+BFdDjm18O9vIXxUZxTwSdq4ss75n9RLEHbU7t+T59lPo95320MmP5LLe
 KDB0/zQcunLiwrn/FvQ+p54HBr3lAPNE0IciG+E70HVpPYsZbSn9s0a4vDDNzszWPvaf
 KvuYkay4bvZSHt4mt1G//y0b86k2rovp50wj7Cp7n9p30RZMQ69gwkc0tjCOhNXt1/Sc rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjupeua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOK015821;
        Fri, 29 Sep 2023 10:28:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YliTM+k3/iND38EAUYvw49/R5xwF123gZEusoIs7QQ3uP+g69SuumUhmV2C5YbzqaoZUPisfjpexqSn0fyDOfzXObD6+3kp2vFyWQ/H4pJ443HrKMudwHl+YU3/fVmDn6g/hP9kAE4oV3K/S4uFroAX4q0G0MdPvMv/h0FX+VA1XEZCHMWDE/opWfOslPsas6FoiAyCnKVwz4ImfFrtoRF3ijxxviSojwgQfP07BzSzl8vZ9C4zkMeJHOd4j2kOD5Z05IbKFHkiPPfMt7xVAGhd8e82xF+i0LmNX1jwv7RHaf8+rNDZZnmEdHV9v/Ej2thmlW8bZRGhXeqipvevifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrC0Fag0ZjCnhamzeJYJ/FvefehU9bX9q+eUQrZEQEs=;
 b=TmiIKyF2ykdF/XcD92JcADRaHiTWMr6NqrFerXvokJQE+XhLBWwiLH6SnTQ+PqgiJO+xcDHJQyOArvD5nB6NySN/Q1wLO0zXceFGtUf9wuHzhRHUOYJIAFlYByAYGIEvNAMsaoHgNQbcK5guAHSrrncbtXZMw7Z4udnX893bP3gVfgDPeHChjyoxL2ywcuOQgVOhQK/Ik/se5xjZqkiek0rZERtQhCdx9+twmCddbTlt797R9KlFaXzXrXPbSIphlql6BVcgP4ldYEdiQaYvWqOtB14O/IH93YQyjWZNACsVZHBQcgnTtqfAQEAtsBgU3vCn82Irkq0jNOJEFJWDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrC0Fag0ZjCnhamzeJYJ/FvefehU9bX9q+eUQrZEQEs=;
 b=xKjRnsUHgca5qZ2pyG8dLjYK4fwZuh+KUlopt13N1cfONRVA2aH6eJYGyObfnnIWhoIe+FNdpPLbGV1VC7lpGD6fUhklV9TLB6Xp2TBcXSKecZDdedXKYuGEaQYIdpnUEeEGPDQ7G/GsWF0GPATnxDwvAjLagez9+y+bVViCRKA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:32 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 16/21] fs: iomap: Atomic write support
Date:   Fri, 29 Sep 2023 10:27:21 +0000
Message-Id: <20230929102726.2985188-17-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:208:e8::46) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 383b42ad-69b3-45f2-080e-08dbc0d6d49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+l/Zxaj14nlW9/VzcHyKU8nOotITwEPOT2RE8UrsTx/Jdd51zEmZtNm86KM+guA+XwYDc+C9PkXl2+Lg/C7tHAxXPp8RFXKlxXY/Gl+CV6wnDEVhhMlg80Ja2ZBQnH7Q/Xb4Q3kNqSKYQ6FG1yT/l8XtsXtImceoSvgKrDRI9EQwK+GK7pHa6OIyGgOgbB9AekxTt64JAZg/fY+frS3FfyQ3hNLEKlCk4W1Fc76ykkFMVdutRCfUMYiD+Is95E8Rsp4q/FfQUhZBxu3X4HVNVlv7Kn2AjL9MKrqcWQhjP+EtkDT+kwu932a5ub0J3S22PcfGB8jVwuW5iBdeCUqH+te0Ihzbeaox3o8GOtg8cLHn6p7Sr0+4xOuTl4IZ6KLrnsdHverVIMuyotLHjneBe4Nvvyk2XMrChYqD5MxzsqD3zqaeDaXXyIIEydqZkfUnEk9E2J5FpINU4TixIaBnB1Se5WXAebUPe51lbyveII2puiieUtM3TVcrMeNHTAJDkzWjw2DuSb/ysXcVS+yBvwZFRAP3n9bhxKlzOSTXzG6rN1SQkIihni3vpSFMK6/QtBFrJ9l8fvcYOANxYFvLm9Rp8z1SMerl7ysKxJU7/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNPXJTCSzkrabwHBNml+spNrxC3nWk2bzSazVJdhahhmFWJkOvrBk3a3kwP+?=
 =?us-ascii?Q?+Ajk0Hnz1anbTs2/wnUS7TjODZkt21WYsKSKsKaJ96tdSlKTyns//C9AcUHX?=
 =?us-ascii?Q?Nls98jRBPYf8TzNVZMnH2V61pV0vM0hUHlGaqZ+3gAsauucsBoIL1RwlB83l?=
 =?us-ascii?Q?a7f6mow8eEgGAMkzq/LbfBmcHRGEuhLrg0R/iefcuNn1Wq27JiAGy2KM5lYe?=
 =?us-ascii?Q?J43MxIKwuLmAkgEoxBNZy5ObPTJC4e48WgSWx2flEeyV78BJThhEnUKYB6yT?=
 =?us-ascii?Q?8uEHZfHd99cCQCJwJTXYfGYgoaCqnWkcoBhzjy95PdP/HdFa2Yx8K9zCmgTK?=
 =?us-ascii?Q?UuJ74TbvUcPSP4ceHA3G94nhgtTstogcOKnO/AN8H4rdA+A/6ueDuqmKOqk3?=
 =?us-ascii?Q?OjG+DxY6tsAxbcxIWX4KBRkkClmCtU7kf0Wgd6e7oGF8cicXPVoh1C5kZpS0?=
 =?us-ascii?Q?+fS30oZHChZZCGJfdVTMS/rcVhfLwklvt5XbQieAy7X0txUXLW6SX2v0l4XI?=
 =?us-ascii?Q?Sy9iRb/69kscHUNvKmbTMn/+uC68/UglKN5vXnCPX7yRQRldZxIJGjpbGgbX?=
 =?us-ascii?Q?x6PmaT9hf3lLB4KOVP4iV1Qr96msWMily3GiBjI/6HDCoKAp3e8t6tNrxwrz?=
 =?us-ascii?Q?wG2uWEmDySWoDvyWDmG6614v/tiGypWtBwq95TGMCotDcgYDWCRNUxp+sYQ1?=
 =?us-ascii?Q?x3zB6ll9n/wSTs+quIIl9ginSKuToEeHbvCHfNhjbC+MCqfvCLig6V0X8xCA?=
 =?us-ascii?Q?O5NIXf1cy0vm3fRNaF5TYxm5GxwnODGSdGPmA15jGvL+//12Oo0Xj73urZ3g?=
 =?us-ascii?Q?9g7OCPkFTeZ2O57I0n9R7ISGLmzop6d+PNL7pBpJKyZ3+IFV8K3oN0BTOarM?=
 =?us-ascii?Q?sYyK3Ly00+HHkEYVd2hXIafoTmo8CmQRG8DytuUQH46HYqLiH/kOCNwRlN7p?=
 =?us-ascii?Q?JePsDLzc7ZlDETr9O7HfFRKDrcezRHcrvw98pog0FzoRXL+LHCxFn0Zzxaaq?=
 =?us-ascii?Q?Xt16u1W5jitJBNK8yw1Ng+WwVojPyINSN1+EqXqmn9ReAK9wWdwj3uaiEaST?=
 =?us-ascii?Q?cagbJlCcnVqmFTeHMhi2oN1xucMUFvexcdOmMZJCUsr69kZLjswLJx14W3h1?=
 =?us-ascii?Q?q46Pm/euknIbeg4qGCZKl2+FuHkqjASVobWfNMOFYEcY+U6418fmC3Dccjic?=
 =?us-ascii?Q?nSmCpU490DERq8UlnoxA52x04YZvKxTbiSg6qTb3UGOSMZcgzq6fr5nwqu9o?=
 =?us-ascii?Q?BPxkej4rnbPAz6sq9Ppb/tE0GWm7RcbnkujK7DdRYVQsFE2402SUEXnux981?=
 =?us-ascii?Q?DvfSQyBTXTxFsk1eJtEWnkTrcd+mP9/ZxU3eoLDwLeeHxQd5D3DTH5dKhM7q?=
 =?us-ascii?Q?TZqTLLRbVDQ+OAtZQxDHn3AS2GdnL+gsPrqmBjFJdd8RZdfRjcsWESzt0G6d?=
 =?us-ascii?Q?XLLrSOqE6gUJIq6x0csTFG0rxliIrodOiWRhKanJRYoKkBV6IXaDnOXjVGI0?=
 =?us-ascii?Q?nll6+5gx/V408EQXkDTra6gyVi25ozNDHDlumPfhGfrx6vevOPPXyxBwgAzW?=
 =?us-ascii?Q?uM6K5P8cFGaId9SjsW3E6KPt3urYoIlTxpw5jQdGa1d/Lo0jj9LGbPN5k3nM?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Grnk3kujeMIHgRe7RQV1G+/ebuozQVC9WxBIGq1DQZQa9/uN9ALbqh0T14mA?=
 =?us-ascii?Q?+7CTGzPorw9IZ6JGAU5clFACU4w5N6toLupQcayOO0f+rl54w/9nwVjVlL4U?=
 =?us-ascii?Q?5hXhUOzzXdGN+NHJdjGbGG7FS7CUty4AAvFY/yVax+OZ4rB59TLoBPkP3izk?=
 =?us-ascii?Q?UrgMRKzAGYiYI1Dzj+wzzp4P+XwwHqMdrfFDK0cf0IgF1bOaCtdWgXAwAQiB?=
 =?us-ascii?Q?x7pK2bJJA/xU2KLh36UsVIFjzJOq8763j2ywUQuRFdWUQllDU2GMRH58Nqfn?=
 =?us-ascii?Q?ZwWZIKtFThuiyt0asg9kuNEOQxG/P1sPuAaPe6Lo2jrVzFWGCUP8P0aLlBMo?=
 =?us-ascii?Q?eYIg2XYEpddfIOX3EW4d1RjHFtMqouj2fmjUI4K99Wvc1AsprYmqeCekeKJH?=
 =?us-ascii?Q?Xy4hdt7ZmiwHdaX7od4nnXFcQDIb9rG+Am//bpFbuJtZB6wvGelQXUQ9KjT1?=
 =?us-ascii?Q?zOfxbtBQwz20Og7xB4o5PvkhpEModr+8peC+S9oaduiqF7n0o/WMyBbtOfg3?=
 =?us-ascii?Q?vuqyPmNnZcIJ3XEVXdX3uQcgSpvu5kom0sFQRNRKXBOuxYwbYXfuTrxkAPP9?=
 =?us-ascii?Q?u31oKo//3ujeXDu/jVtyB4pPATNTAebMyxMot/Qn2RQcnAYSowaqu405/MDn?=
 =?us-ascii?Q?VKstliXYwC1XbkvtAqSRJ7t4YHr6yrKV3jwUGWP6eRjbqdnHmB8PGYwkE4WC?=
 =?us-ascii?Q?gmUbdLRvlIrEaduxsJD8tOU3XkgYIJYA+pOcEEhb++xW9lPiMWO5nmeGompf?=
 =?us-ascii?Q?DrjbDBX8W8QxPPpIhTlteNF7KObjwHHA0kIz+Svyh6GDqY81DEpX8giiff0x?=
 =?us-ascii?Q?TFqmofY4ApM4ijub+gOaPGU4LRXbGgppXQlmxYUAMLIkr4KF+feg6kIps/LN?=
 =?us-ascii?Q?MbkckX2UcQxTVDYk5rYJ3DCcIoVEveWbJNtP/6CV5a2Kj5Uyyiev92Z6NREH?=
 =?us-ascii?Q?3A0q0jmJEIhO/6qcKbwDQBBDkQrOQrLH1w9ha8SGd4syGThRWrP1HwfLNcSl?=
 =?us-ascii?Q?JUlyXEUXGdZOmQfRWJCiDX1ADZVb9aMhxg6+kEqBu+vBSMV8xuXY7JZN2DyV?=
 =?us-ascii?Q?NKAD+o35nDgG2ZDJOs2Thqcp361p9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383b42ad-69b3-45f2-080e-08dbc0d6d49f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:32.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBHHDiO70GV+qQzoBPfBMWAeRl1jyDuxjg0PQmyM7YfQPMnvYx9ZuFGxx/kiyi+rYtHA1Qx1T1ThJWwcNk8ZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-ORIG-GUID: O3--EyqDIB_S5tr5MD9r7oO-2NTzyimq
X-Proofpoint-GUID: O3--EyqDIB_S5tr5MD9r7oO-2NTzyimq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
bio is being created and all the rules there need to be followed.

It is the task of the FS iomap iter callbacks to ensure that the mapping
created adheres to those rules, like size is power-of-2, is at a
naturally-aligned offset, etc.

In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
is not dirty nor unmapped.

A write should only produce a single bio, so error when it doesn't.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 26 ++++++++++++++++++++++++--
 fs/iomap/trace.h      |  3 ++-
 include/linux/iomap.h |  1 +
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..6ef25e26f1a1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -275,10 +275,11 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool atomic_write = iter->flags & IOMAP_ATOMIC_WRITE;
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	loff_t length = iomap_length(iter);
+	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
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
@@ -381,6 +389,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		if (atomic_write)
+			bio->bi_opf |= REQ_ATOMIC;
+
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
@@ -397,6 +408,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (atomic_write && n != length) {
+			/* This bio should have covered the complete length */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto out;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -554,6 +571,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 	loff_t ret = 0;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 
 	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
 
@@ -579,7 +598,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
 
@@ -605,6 +624,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
 			dio->flags |= IOMAP_DIO_CALLER_COMP;
 
+		if (atomic_write)
+			iomi.flags |= IOMAP_ATOMIC_WRITE;
+
 		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
 			ret = -EAGAIN;
 			if (iomi.pos >= dio->i_size ||
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index c16fd55f5595..f9932733c180 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC_WRITE,	"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..5138cede54fc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC_WRITE	(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1

