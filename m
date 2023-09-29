Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B227B3023
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjI2K2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjI2K2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BA1AC;
        Fri, 29 Sep 2023 03:28:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9bvI023136;
        Fri, 29 Sep 2023 10:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5Yri2Hpansj6Fbkf29Fj7VdpbnPQlQs84jW6qRSp9Ro=;
 b=HZHsYvJsCMWfaP0LXRIQUJjfsLnyzsXpDCBFaW/qQgdK177QwDGr4XFgNh5nG9Ruy4Rv
 iW3CwBna0XYMWW2a7feXXXhcmbq2QoCIfU6l64nGLDlUkTNdYIbVQgH/iW9rQeOnzYOW
 Mky47rVGT6Qfla7rgQQTc36tfUEwJ0lxUTkaudO3zcFgI1B/OKxbzuhQo1GB2tbQNWLI
 FzJ7pRQ2fRWgCV2IB1Jn8DgSoXh9lbs6xF/3AsXX5JxFersO5hzBBReiFSZUlkSSRZc2
 /lRIOa8kjPrZw4BYAKGE2Mvm1/Kq7GecxiGv5lSWYtIq/Hv+VwowCllac+bFKK/eXQb0 zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc6k52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAIC3L015784;
        Fri, 29 Sep 2023 10:28:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKVOlEpDeI/obMsnqU6eym6qZ6j7CMRbHDqECOSOoeA9PIca3nfnv1ORflX8RmsxaSMkZ8gVR9Zs5KizYL2E6slQf1addg9fAcnI1iWMsAKLtgaiDkCMUX/FSeAMt/Gi8t+RJOqcRNj/f2MVm3EAvsVvhKM8zP5eC3hXCN0h2ZOeQjxBi/nio9Os1IPuDZjpeE5oBoFv5QCzReGTnfZZkz1J+PQZu2sdjKNfilel5+YqV76tvY5Dy2GfY/G5D640nURX0Iydj030vAQtT7w0pBDcjxtMzcmDwWUjckScHsHivArYefRac/OKw2jAq2oQR5slb/mjvbS59lS+rBKYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Yri2Hpansj6Fbkf29Fj7VdpbnPQlQs84jW6qRSp9Ro=;
 b=BxYA4/6eS5i+R9KEOGG2PtRBaXSRPcCtv2lFwdGOgy6NLYgqpps9T/Hu5+39hZ50jXJwIqNFIIqt6r3i0Kp4hYX1HlIsiMA38yf7FeBwSdE1ADIAgSzCfhOIscZQnt1n3a3yOiQGyXUYhbpe5VG16MCxapG+f2kb/8NwDMkSHWQZruneQ2LHoGhMdRuUWCwcY5WTWsFP3UEdJT+yo/p8E94DljACk8t9R/r6vK5hooQGPaiarepxTMazzf46nUKZwmkZOsx/huo0YydfYzGUVmPUbt7qyd4PRPi50JlQtYJ7YTjUBgMHlz7mpM6sqF+/toa+2ILA+/CtEHgtv1ZthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Yri2Hpansj6Fbkf29Fj7VdpbnPQlQs84jW6qRSp9Ro=;
 b=k0PFSglH5+1FxyJDn8kUczQCrL9EFtqBMFbNU95uloNNM3prIS5oEVG7X4pNd2SrsncMYnq4fSXiqSOXgFQKniUAfplOA1BddnPX61yFradWnMvWH9Q5BX0ion0MN6PWVgt9vnHsAMIMoJtL2xbe1Ou+BAZ+/tAIM/vq7DFth24=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:27:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:27:57 +0000
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
Subject: [PATCH 01/21] block: Add atomic write operations to request_queue limits
Date:   Fri, 29 Sep 2023 10:27:06 +0000
Message-Id: <20230929102726.2985188-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: bf63e440-3065-429c-ae18-08dbc0d6bf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MH/2gzfrjLY60lLGxzG8MBnb5JKj+4ymSFlRXy5ftSlWO7jHkGZw+GCPTOYSp4fVzvR5QFT2jhoFbowsQp4tBG7Zhk0RGg7pqC1HqXcH2LEMIxihCScONXqU67VqtbFTVS/fjbxRTOPbA2FyToxG8Lb5bw0wySwqD+h9L05fMbGcoRE0O8UEACxAe4WhgkD0wBM9Gy3nSc5NY+0H3c+8rEmV8H/PkuiHExS9SwL544CvI6cQC5kPSe7LRrP5gkDkHhg3EVPv+YHWkygLfke9CcQSkuy0WpCQXFBmNlhpceRueRrc+npVtSMPwCVwW0+RuaDXe4lXGbVjNpIwMX0iCoolb8ZmeSNbw4713DgG4lLOk5wKfepXL6HmC1kErndBXa1NkiuXa/X1T+EAH/35p3NCuZwLNXN+oXh99U3g35wY9qwm9ChTb0fP6eLaWB4wL+x2w/MCQ/rZ1BXHm5kBKeV8WBqm8iBG6ma1+fzSQKz2MIMVBJnNvLr3uL5s0q3mOI77qdgMwZwUF5j9ekl6z0ldqkw4dLXqLUt4Jp0WD6hmKM+wbWrqwJ9dgPY8yrXqi6BQf8QAx21T6a4sikNK1DlOb6ILWpVuKDKsxD6H6Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(54906003)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZaVAfIth7xQypef8vnnST+hVglXzGWAVA0/fxpzGGl8hfG7GTzgCo3S/cbp?=
 =?us-ascii?Q?wCJ9fKwIE2LItGqkonuvJTqYd3Egs4mdZV9m8+OO4eJVB3NiR9tpEVaTfs5y?=
 =?us-ascii?Q?0DU2KXXmRqWt9rwUbCNmu7y3pE8iEgXaspl9hYUzmKTGnOTuWd5Dexx0qql5?=
 =?us-ascii?Q?ZOcDdFeBHGIGZ2DzBrd6ZmO+1bajEyn2WpfqTu3HNt33j/8OVh5lf2jQrc74?=
 =?us-ascii?Q?FDM5HNeQK2GWwiIwSWuWCExr60g8k74m0CNKiz7cag9I/1crCHc28u/YYJhQ?=
 =?us-ascii?Q?DXash6LrQWqaXlVWaOlZiDbi2y5siRuECjkR7YdJGcqW/DqkFrK9vrYoLKYi?=
 =?us-ascii?Q?XTjSXabwTI3RR1Q6QPauLoDIS1GMJr3DViagJlkgwzkhlhI7idaZV1Mt+zeY?=
 =?us-ascii?Q?oVdqPoeBYMrdtjLvB4ajb0NhalEAsCf6bFZtFiVNKBrIOJsMunbJb5xpU81t?=
 =?us-ascii?Q?Qg5Pnq6zatrUNXaLrsFYacCijh0xKPGLD+4uhVsk14/IZnJOF4QAC7uXbJTZ?=
 =?us-ascii?Q?RbbyeiWf6WJxSuDDSLPPn1bypL0V7nmAd/yQ2dqaVNbp3qxEo/cfFtEKcnh3?=
 =?us-ascii?Q?bPV3QOmvW41nVQVt878g/d1XgSyNfiWNqmfJHV4pjaFopIwvYSQzPfy24efD?=
 =?us-ascii?Q?r+D+53tYppjeL//a3rSwIT3YSRqYz4ybU/mS0bdYhkqGYe5ljZqeIxosY4v6?=
 =?us-ascii?Q?y6pi6v06DbUeYdt9Px3gpWTYwiF+p+EM7JvpVxWSFEO8e1H6hBEPyw0fQYKx?=
 =?us-ascii?Q?cwoWja2eS5eXu9qfRMZRGZ76v4BWCN+k6h/GOdsz5oG66X+vDynS0pIB5OeA?=
 =?us-ascii?Q?D8h+zPlNbGltJ2yTc3vDOrjyHXAERaeAnmdwhrPBhYfjc4HMH1spsbYudsvk?=
 =?us-ascii?Q?hphVSip/01t/QaUHvtC+Heh4RBE2UpZX905JxADYx8lkiQpNPlsinrB68FwR?=
 =?us-ascii?Q?A9o15GL4622ZWosvRGjnaxReHP/SQm6x3EGkDPwMFAIsp7xei2gy0Xf5uFm8?=
 =?us-ascii?Q?sLUqRuBD2ONIIJ6B+OD3SJ8g/qrI5Ir02Xq2OJQX+7gCTCSQ7hYtpsDr5HkN?=
 =?us-ascii?Q?qvfHBzrN2a8P3z+3B7322Dx7ZGUZVpS4p8hO1aU2rRkf5tcvy7ZIp9+Obn6g?=
 =?us-ascii?Q?vIE+bawjeXbVqMkl+n6LsZADk/19Bbqf9JBwC/KBJrZZ7+VZpDWVrObMpLLb?=
 =?us-ascii?Q?/mV4bN4QPwuQOS7aybKnCc9AFyjUZUbIgNcRxxvxgRzx69PAXMsKrjYKfyib?=
 =?us-ascii?Q?aIjpQIxr32bwC5o0DVvd1mRAD61i926VviWR9bK74QgPcRsAphDs3ZEHHvkQ?=
 =?us-ascii?Q?Ii3i+7ygiBBGgc18Uv0A3B/huBV2TkjaSQSZb6fc5scxswk2e+yZA1LdB3Nv?=
 =?us-ascii?Q?3MkMTzGUWYPeiS0K2GJGMKx3S/7ZgAIWpRMXBjzYGydEn3n2BARno52G1Zzg?=
 =?us-ascii?Q?AlyK28rNzhviSkLLZPtonQwy954Z07eJU3HQ9T4tZ0XNdzRJtzISbvhkRxGZ?=
 =?us-ascii?Q?HheOrxBsdVMFr2+dGJsg//5udjGjFpH5woJwUH/HgwchbNiia3ItEui/FPy8?=
 =?us-ascii?Q?144R7ayuHEo2ZhKGJzM1ToDLOBC587AV1GoDzhvHHWjMBHyBi1zXDbhz6iz5?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GTlDs7k9kljlQ8cslDD4/hokpPiZpni8T0HoAGsXY1Iw+ICIx9eceVNoEpHR?=
 =?us-ascii?Q?l/4MGI71gEfTnlnLpZTZgg93SAQ0NiXve+8VY+b0r/6I3PpEqBmNc4DoF91u?=
 =?us-ascii?Q?cl/dJzHjrzMxLBMOtZRMtFWvKTFykPsGk7MXRd0FH6DV1TJ9WlWvWJ0tBmtd?=
 =?us-ascii?Q?h0s97uFKMEW/GFJx/XlgKnv4Hqy3NMreEDpY+5Ttp/kGJBxqaBabP2+yvgEt?=
 =?us-ascii?Q?xIY+TvcYnVd/i2g8PLGwJvLUIbCkx7oHrghstVuXUB/pHBDm8nXPrSfpPx7/?=
 =?us-ascii?Q?BcacF/wJQM1mB4iLH1Wv3I2XWgLpmMnCux3D0Tty5eeGsN15Ruv/x2mdf4M8?=
 =?us-ascii?Q?nlaTAyA56GSxzQPzg0Ev4V+kf44DtuwhejFaUQTcKwmdTZR3a47hfURRu2Sm?=
 =?us-ascii?Q?eCOvxr56kTTwGFWPvaJCPgj1e+p/u8tDyJUFDhqGaXtfeO79sjLE3jY8xTFI?=
 =?us-ascii?Q?KnZpZoZhgLkcbPPXXxN+5HiSG1U+ruzAI4TWmA0qLJQ1QfXkMBYsKXqkKBU+?=
 =?us-ascii?Q?4i6ZH3y64We6gP0QN8eS1O+eumg2nTAA/86RPpgeK3E1U+AoDcUvj4K5cGgH?=
 =?us-ascii?Q?LxWH+abMqdP+YmBlNZgMcNuT+Wy4lBKbKHjX0wgyN1vLBQzDjak1+sRnikKi?=
 =?us-ascii?Q?B+qEDLAtPTVLTKfmeFmJF3SRExXSBR860pk5PXRr27dEtqtPqACEn+URrgYX?=
 =?us-ascii?Q?NSgYUKfVJjX75divrwvcRAJRDfA5WnBcCjOKWGBUqx03IcIrkZso/ec+KUq0?=
 =?us-ascii?Q?plpZosWSRV0atSENvKnLblT6g2FXA3o5mGCGF7CCkPbjZqjTLDG6nrw9jcKd?=
 =?us-ascii?Q?KMOBCr3ThuggzeaqtbmolNPZWq0GLJQEDEh+eqhR6X7NTgvyhOnoIvLUF+EO?=
 =?us-ascii?Q?Xb8RyT2iEuXt4JmnXByCQUKJ4oTN1o9YBqyyOg+fsNE2NET4ZzzlHwoypkzF?=
 =?us-ascii?Q?qIlgaC0ko/OMGZMQJqK7xrApN/1o3xYwUth4N9B67c/4Nzt0ZIxgB2kLhtLo?=
 =?us-ascii?Q?X0LfGPGLZWjmUyac/tO+3KnZJYFCqQ5n581PPoiE4/IvL1/wkiBOa3ZSfRzj?=
 =?us-ascii?Q?f6KhsjIidqbBpSCKDFw1uwp0n5kyAw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf63e440-3065-429c-ae18-08dbc0d6bf9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:27:57.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk9jEqvciOzu0r8Miz6IjJzZZDh21UyD//iEFTKc1Fm6i9mq80CGVDCMH2gcdDw7gX2v1N918N1+/Wl89jLMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-GUID: j5PJEXBrdo4uGWBgFceyLihEs8yhOECT
X-Proofpoint-ORIG-GUID: j5PJEXBrdo4uGWBgFceyLihEs8yhOECT
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

Add the following limits:
- atomic_write_boundary_bytes
- atomic_write_max_bytes
- atomic_write_unit_max_bytes
- atomic_write_unit_min_bytes

All atomic writes limits are initialised to 0 to indicate no atomic write
support. Stacked devices are just not supported either for now.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
#jpg: Heavy rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++
 block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                    | 33 +++++++++++++++
 include/linux/blkdev.h               | 33 +++++++++++++++
 4 files changed, 168 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..05df7f74cbc1 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -21,6 +21,48 @@ Description:
 		device is offset from the internal allocation unit's
 		natural alignment.
 
+What:		/sys/block/<disk>/atomic_write_max_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the maximum atomic write
+		size reported by the device. An atomic write operation
+		must not exceed this number of bytes.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_min_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the smallest block which can
+		be written atomically with an atomic write operation. All
+		atomic write operations must begin at a
+		atomic_write_unit_min boundary and must be multiples of
+		atomic_write_unit_min. This value must be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_max_bytes
+Date:		January 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter defines the largest block which can be
+		written atomically with an atomic write operation. This
+		value must be a multiple of atomic_write_unit_min and must
+		be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_boundary_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] A device may need to internally split I/Os which
+		straddle a given logical block address boundary. In that
+		case a single atomic write operation will be processed as
+		one of more sub-operations which each complete atomically.
+		This parameter specifies the size in bytes of the atomic
+		boundary if one is reported by the device. This value must
+		be a power-of-two.
+
 
 What:		/sys/block/<disk>/diskseq
 Date:		February 2021
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..d151be394c98 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,10 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->atomic_write_unit_min_sectors = 0;
+	lim->atomic_write_unit_max_sectors = 0;
+	lim->atomic_write_max_sectors = 0;
+	lim->atomic_write_boundary_sectors = 0;
 }
 
 /**
@@ -183,6 +187,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/**
+ * blk_queue_atomic_write_max_bytes - set max bytes supported by
+ * the device for atomic write operations.
+ * @q:  the request queue for the device
+ * @size: maximum bytes supported
+ */
+void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+				      unsigned int bytes)
+{
+	q->limits.atomic_write_max_sectors = bytes >> SECTOR_SHIFT;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
+
+/**
+ * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
+ * which an atomic write should not cross.
+ * @q:  the request queue for the device
+ * @bytes: must be a power-of-two.
+ */
+void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
+					   unsigned int bytes)
+{
+	q->limits.atomic_write_boundary_sectors = bytes >> SECTOR_SHIFT;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
+
+/**
+ * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
+ * atomically to the device.
+ * @q:  the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
+					     unsigned int sectors)
+{
+	struct queue_limits *limits = &q->limits;
+
+	limits->atomic_write_unit_min_sectors = sectors;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
+
+/*
+ * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
+ * atomically to the device.
+ * @q: the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
+					     unsigned int sectors)
+{
+	struct queue_limits *limits = &q->limits;
+
+	limits->atomic_write_unit_max_sectors = sectors;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e481262336..c193a04d7df7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -118,6 +118,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
 	return queue_var_show(queue_max_discard_segments(q), page);
 }
 
+static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_max_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_boundary_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_min_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_max_bytes(q), page);
+}
+
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->limits.max_integrity_segments, page);
@@ -507,6 +531,11 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
+
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
@@ -633,6 +662,10 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_atomic_write_max_bytes_entry.attr,
+	&queue_atomic_write_boundary_entry.attr,
+	&queue_atomic_write_unit_min_entry.attr,
+	&queue_atomic_write_unit_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..c10e47bdb34f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -309,6 +309,11 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		atomic_write_boundary_sectors;
+	unsigned int		atomic_write_max_sectors;
+	unsigned int		atomic_write_unit_min_sectors;
+	unsigned int		atomic_write_unit_max_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -908,6 +913,14 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
 				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
+extern void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+					     unsigned int bytes);
+extern void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
+					    unsigned int sectors);
+extern void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
+					    unsigned int sectors);
+extern void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
+					    unsigned int bytes);
 void disk_update_readahead(struct gendisk *disk);
 extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
 extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
@@ -1312,6 +1325,26 @@ static inline int queue_dma_alignment(const struct request_queue *q)
 	return q ? q->limits.dma_alignment : 511;
 }
 
+static inline unsigned int queue_atomic_write_unit_max_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_max_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int queue_atomic_write_unit_min_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_min_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int queue_atomic_write_boundary_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_boundary_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int queue_atomic_write_max_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_max_sectors << SECTOR_SHIFT;
+}
+
 static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
 {
 	return queue_dma_alignment(bdev_get_queue(bdev));
-- 
2.31.1

