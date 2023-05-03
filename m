Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3A6F5E18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjECSk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjECSkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C92526B;
        Wed,  3 May 2023 11:40:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpCg3009519;
        Wed, 3 May 2023 18:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XgtMElOSqEBdxUjAqAlOSvt9wkZcvJU1MNOymN72JhE=;
 b=VGwv5DVAs/nHpIVn3wrddsQEx/URi04m1kuU7e3UkXSfa368QFyuPlxnoxRQyCMsxS5h
 623WQ+zuSvl3yTYUYN8t0nU8k9wZsAItQkB4ct6cvhCfXWvTRRWyWHrWihtXr1d/d9Ls
 G9IiRu7Y/JHhjY9dcnxxByQgJotdrTW8Y5xxbPp0yGZecgWjKXjwJvjK6YAgcnqBdy2L
 GeOE73nfybfH0iYZfFuSmYwAvZqRlmAl/D00hFReF0Jg84DLxr1HyL0wJkR4MMSAybXE
 dikdaVt2DwQ7l/eOei7LCfW/dtIvv857rcM8mmfcft8pT9lVmFg4AFgqkrmO/DilwFs5 oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburg869n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HXUgp027022;
        Wed, 3 May 2023 18:39:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdscfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR0ET8K4DMfkD2B7JhETag5SIWHDSaMNLgUJ/5OnMuuIAFxY3hSks2FLZ1WURrK1O94g6krNJFCeJMPFQ5z+XQXqVg52HjdWjpc7bRJY5OxQMYGqwjxL3FN66H31vDQSPZ69b6tnHbuwDREMErFdUFTWGWdRz8d3Esyu7raHbbDKP7o4ZGMUdfpo87itLcNKkeEFEHoXoHaMx32/IkJD7LL1a0XmtjqStqPzem4WZ0dWxr78pgosGf/kX/uHZC9q66cqabH+/w3Y+fCNa6YSV/UvieiwEqllDsAU6l4LVaq6MaxNL9qcH/Kn8/4M3dbXf45723vVK1OD4wxc4P/n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgtMElOSqEBdxUjAqAlOSvt9wkZcvJU1MNOymN72JhE=;
 b=ZmdB4PnVJwFo1/H00FCovyS4O25bumQ1Y+q6+iuiEB7R0Dg8OYch4/ohgpezGKttWZhhmK53HVDiPw4qDYr+Dl2qZZgEXJLuf+QRpdbSCqH+rHvz+SRBOY4MqBeb/nLH1BR3KYBelnPp+arYxGRod1U2D1dq/AiwJTKorcRK0KPqMicN/dYAZgATQbTMREyiJB/M9w5Yx+7W6zXZy2sfuiNkIZbtrFltwgqz49RCRfYI6VKH2qH6oSA7IIw0BizsfPVvHigS9NT34GVVjmqZiGxPJ0RLWobwsCDN9yNNIhWiOUNMcElx0Xzwwzr0JMPHXw4MvpXWOIy/eP8DnzXQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgtMElOSqEBdxUjAqAlOSvt9wkZcvJU1MNOymN72JhE=;
 b=0KuYzJItN3zCN80yRcGIkzQ5C5T2BqDC14/vKNQGQ0nkg3WcF+xsGKJ1/2iFf6bflsFBFoTqZMrS0lzF4UPRCCMR/BT3ACOX26c3Ikp/vWiFMgiSgcbaJuzGeHB5uocE0p92691W5MKOrPJbAYUhIxfBRQ0BZlu1HWEoUeot11w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:31 +0000
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
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Date:   Wed,  3 May 2023 18:38:07 +0000
Message-Id: <20230503183821.1473305-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:8:56::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e0a29a-5755-4916-9500-08db4c05bb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msn8JTpMI37mPGavQkmuzfKtLe/ErSM82GOEjNtQw6DSA5n5Jj1OLLN7IAATHjvS7gJksV7K1P2jb5nPjSoVAqZoKlT6Z77jM8SSqH5sVYGIZ1Ikwi1T5j7draf5YS3mE1VHDRK7omjxr+2E8gDXdVe0EVcTyGrKbWPJb9KAC9L9Dge+wwyM6UZ88+AzIXsyjdJLzmQPt9p388cST59ap0T2IqY9yLaYSbDyCEbBCJAylGbnEl4bhXMxPrC4d3V/NKuNmKp8MgTEavySXVIdecXJRBP+GfXLvzMNAvJvo+RhK8VvFfCByEyWWiLB03KE3DPyxOddqKnyV/kV7kMnOE0Wowq9r+jSUwXKFeKsTU6y7bH6Y1gaMTDcaB2BesWeJmgHgViCQ8qA57rRMd2oSdr4VMcELYwlTCyouoCzIVdP7LUJhC/0h6EA9SCzs36QGraYKaLeyGheTNH+VYeOeHG2ifZVSQrNsNuhKsSq6OlWyMsJB6t6NlTA993Zi4lUZ4NNf7FydQaftKhn0z8BLoha3rya07Nq9BxQJwNGhM20waGXeVpi4lWlVUURvvSPjX4rfc3v+IMPGIotPlerYOdYAPVtnR9z5irB/4jUgVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(54906003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLG/h6KPI1pLESz+5cI0+OYXCfyccvVceYBeVGAyTMa6pIxMy+drR8pDGNlz?=
 =?us-ascii?Q?YVM1+iyK3LbH1N7hfCHoaDmN4USmDyirO/qGAgPJQlPsNeeVbGUBZ2let23o?=
 =?us-ascii?Q?8EHM288Zw07G42OWZ6ZIUYen8bio/BzLbblp4xnFPNEoEs9HRMDlJEovBRN1?=
 =?us-ascii?Q?JtevsoB7LHBJ0w9q40IegUPXVH33qqMRfjzAZO6mls39SV73HiVON5dOmgb7?=
 =?us-ascii?Q?tAboZeJeIFv5z4sXC9ya1xE+c6VwsP5+8Ba6ccCYWRYrDve59MAAkgJzYRQZ?=
 =?us-ascii?Q?EQVttllRHxJyBksciIxeM7RReYvwndxaIxZGVslWBZdIRME+rmFzTdI+KTP0?=
 =?us-ascii?Q?FLHNSzG+X3pDXXWY9AqCya8JAvFBTfEMIdMd4EeoGhnocsbO+I21cTHmUNEj?=
 =?us-ascii?Q?dFXS3nbHSwUhFvMi9RKPAFMEbOKA/GUjvJ1jbyfNuuvHrk9jhEUw7i/9KYtl?=
 =?us-ascii?Q?tfQTWtqvqgNBIaA0CvOZ6QO+kdrt3ceS6g/dgev/Q38RXxPQe2TLlTRYotRY?=
 =?us-ascii?Q?Rr1sF7nR4cOqCNSvBxqh2UncSIlIf6QMJBnEq1pe2BVZMyteTBpeMCxsquWH?=
 =?us-ascii?Q?DkOLv9AbSiX6CcnXQmNZmrR+Z0Vah1QR7k8XwshsAbvYImTO7q45QKCDBN9Y?=
 =?us-ascii?Q?BDvHaQNkQmjxuaj0Hc/LIzjfFBy+rMZn4Ic9U7bWw2jGt2UDkLg++1BMCfga?=
 =?us-ascii?Q?eAUZLLikZO7fqT4rNNczlRplNBrPkwY7sIugI4NwL0wBVB+xCgDOET0mDKwI?=
 =?us-ascii?Q?bmy2Z24IEVQU/cp1JXRua3hc9FAjMhfhSwdEho1b4MKYtBZgJaeA+b5XkfKY?=
 =?us-ascii?Q?4RIne/7lvaSDOI9kJofwxJiWNfiOd1WgfvDZJVMnApKOIjTouCeIRlRsZCHL?=
 =?us-ascii?Q?OktUd5wRBcqPt55AYAmaR64zgmMr/jz9ithoU/wgyMgumkQxXtZzp3/WxOrx?=
 =?us-ascii?Q?AdQGg183XEy26VdQVQ4tosG1IRJkbWgYP78q0sSird+0jyBgaRk0XHPotwqe?=
 =?us-ascii?Q?fec06L6LVcLZf1i5lMH4qyZ54Ko79sdNfKuLzxsk1wAazcsGYqVisaAkWrPu?=
 =?us-ascii?Q?cxooHob8yjgnUSUrNPuSMl77S3sfZR+MQQSUD+nDCbKYM5BgRMSTJ3lD/7Zy?=
 =?us-ascii?Q?A0Y0+ZvY/tjUi+AGCxqvsy/xM7RblDOZ5uzQYuAEAxHFEHdmw0JFN1k1bWmH?=
 =?us-ascii?Q?eBsvuGPIWzzZGeZ84UHeP6RA0WqzrzSrLrIK8Dy8XCG1ZEgmeMQB2wS5FNpz?=
 =?us-ascii?Q?BJyWfWWt4pLD82l/Wdgyik4ozmJexCQTX/GGRrI083eh58c4wO8GT8RglMt3?=
 =?us-ascii?Q?3xcgeSJUbVlH1GA06fpy2FdS0A4FGLx7MuUlzB+G92JQoO+2Lk7wT4Ufsm7f?=
 =?us-ascii?Q?uxYDQuJl54r2Ac3HX5NRbGv60epq5a1OuZ09fPEOBb2t4pyLtXfVah77zF1T?=
 =?us-ascii?Q?ZE+NT01r54dYeqwsvDRABX5aM20a3L0mBRv5i1lIaDtiLPYm5UQhd/EKayAq?=
 =?us-ascii?Q?PHq67eTP6l3gxmOl7gPPqa/cC7jmgGWf50WNUXGC7c1cYDCsKzOf5VqWhwhB?=
 =?us-ascii?Q?4GzopSv4QIfmfUc0QupjTxjerZfSlFGptBWHa83aKbQxY/PpKcz2XARe3o31?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Gvi0wPUixmJxTQMog9XfLftIWTE9NYO6cnsDAEV+8nHV1UfCeS8yK4IblhsO?=
 =?us-ascii?Q?J65Nc/uXSwqR9e52T/e4kD8EQrBlsxmnBKPMp2+Z/jaXHQK5LFASslO+nRAk?=
 =?us-ascii?Q?EZS5syQH/5MWZmTLk78GrqRr24SGvVLOw5V6VKxOy1POxDaWA0UYHwNln2D5?=
 =?us-ascii?Q?3/b+Ft46H/HNYk/Kqjhj1CgwjS0UWTVpqGGyWlyIS+iCXvwV0gVHEb4KANoJ?=
 =?us-ascii?Q?x5qDritjI3sHNXKY5AcyonxrgOnEQovVnf/KVVO+HDLDy8bQ9YFb22++1M27?=
 =?us-ascii?Q?tv3a1VyudHpG5+SuPjzZMFmrQ+p/HxYEKR0suX22C21ctOqu2wJ//ouTj6Fx?=
 =?us-ascii?Q?K4vSPUdj9uT3l75sReL30hIFAOMp2FF/fydojtxJFKQRIsixPpFyLN5RS5uJ?=
 =?us-ascii?Q?pVKYVANw8WEj78JviiwPyCu4W7/u5h70ZN0e3oODadPp146AHRfTgaMDKKWa?=
 =?us-ascii?Q?2kzBpDizdxjC3iIE3VkekkGv36S5oygsXvsLNtkEFi88MkH70wv9JZzxPOJ4?=
 =?us-ascii?Q?eTCkglImbU9z8SfZCGQcPLrGOM8RnWCzkWOzxYSNPfCR0e4SHLRX94q2KkeM?=
 =?us-ascii?Q?YTunzM7ZFo2ErSVUKqV6QshBRCIid/JnQKlxGXw72vvq5b/OvpA69r3nS8y4?=
 =?us-ascii?Q?tTo61zFcp+RmOabaSvWaPUvG++ZUasfYURtYANSB3fV/Lm7i0N8EAKfkjEW2?=
 =?us-ascii?Q?G/thFZrKeDJz+cRXLr3btzAIs+mIgrki9RHFsR+mO32lChaIZviTINa0Gzui?=
 =?us-ascii?Q?C06ZIWXakVGR59pMs7r1hFnt4LgLv0M7Ccdni/H5AJba0ssRabfb7NAc2c5A?=
 =?us-ascii?Q?MCwyPAchGxC3uQXLNqYq9Hh1xuzCpXSt8t5z8/DVoP+kAip3GAqmyus40mJ2?=
 =?us-ascii?Q?9KBOFpOiD8zbxv7qdLcDc3i2EsRmA6O1U1ifvHXDM4MLAboxz+UrJvVMR5dG?=
 =?us-ascii?Q?EdCm+lMPjW08c0wEicbU9QgOdqPP8rHR50LAX1CN9ZDDWT3JFqx4kQ9EL3u4?=
 =?us-ascii?Q?4ppNtmjxy5S86FcmfLXKz/ekAyBmIuW7GNRaWY6Ipc+y8nzsAvQzCtWz0MFq?=
 =?us-ascii?Q?73X0faRQYU7JTcvNQBUITfvr2OrAkLl7eRtj/ags9UKoCtxSs/KLpUTQiqbV?=
 =?us-ascii?Q?QrDwMhyCKCou?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e0a29a-5755-4916-9500-08db4c05bb90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:30.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SQ0UYKfpvth7JE8pX/l6Izk3Um5HwZ6cF0FP9hidA+aFYc08+iBf0OquNSDPqBWWFeZFmvVpdfbaOi6l/mPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: ni2Fet1Pq0gaFvSxaD5rQsQlvtFNb6Gi
X-Proofpoint-ORIG-GUID: ni2Fet1Pq0gaFvSxaD5rQsQlvtFNb6Gi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support if the specified file is a block device.

Add initial support for a block device.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 21 +++++++++++++++++++++
 fs/stat.c                 | 10 ++++++++++
 include/linux/blkdev.h    |  4 ++++
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  7 ++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 1795c7d4b99e..6a5fd5abaadc 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1014,3 +1014,24 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 	blkdev_put_no_open(bdev);
 }
+
+/*
+ * Handle statx for block devices to get properties of WRITE ATOMIC
+ * feature support.
+ */
+void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!bdev)
+		return;
+
+	stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
+	stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);
+	stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+	stat->result_mask |= STATX_WRITE_ATOMIC;
+
+	blkdev_put_no_open(bdev);
+}
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..d20334a0e9ae 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -256,6 +256,14 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 			bdev_statx_dioalign(inode, stat);
 	}
 
+	/* Handle STATX_WRITE_ATOMIC for block devices */
+	if (request_mask & STATX_WRITE_ATOMIC) {
+		struct inode *inode = d_backing_inode(path.dentry);
+
+		if (S_ISBLK(inode->i_mode))
+			bdev_statx_atomic(inode, stat);
+	}
+
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -636,6 +644,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
+	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6b6f2992338c..19d33b2897b2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1527,6 +1527,7 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
+void bdev_statx_atomic(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
@@ -1546,6 +1547,9 @@ static inline void sync_bdevs(bool wait)
 static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 {
 }
+static inline void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
+{
+}
 static inline void printk_all_partitions(void)
 {
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..dfa69ecfaacf 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,8 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_min;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..c99d7cac2aa6 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -127,7 +127,10 @@ struct statx {
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u32	stx_atomic_write_unit_max;
+	__u32	stx_atomic_write_unit_min;
+	/* 0xb0 */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -154,6 +157,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_WRITE_ATOMIC	0x00004000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -189,6 +193,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.31.1

