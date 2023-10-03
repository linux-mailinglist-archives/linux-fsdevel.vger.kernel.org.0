Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523207B7144
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 20:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbjJCSrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJCSrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:47:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD34AAB;
        Tue,  3 Oct 2023 11:47:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4d4x008511;
        Tue, 3 Oct 2023 18:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kEoxkJbxATccStmHfvO04XZnyBMbYvtCUZEclPyo8j8=;
 b=XFW50IbvmcFawOSeC5fH6L7YSH/yXv/owoIq0Ru0fmo/2QcBse7cfZ3Fhns5I2k1tN+Y
 RzdPgJ3nwqfMqlNdRdAzKeqOazFfA6tM/eM+QuPKhgUr7kt7maEcJQopnY8wADh19yS9
 wl5nLrMOcbXO6EzieJhYHedoGAiAXKe7YQpDyGGjEp1yhZ9xfI70gwjC4jrPy6fsdTz/
 J2esPmwdxkUh9QA/7B8x57RZXjq0vfw1IXDIqyg6OpmS7npExNSeB7THyf2LPiO2jcuT
 iCNZ8gJmnRJ1h6ZQSuqsTE8ccyDdhyzCvk9X/cOqe7w5sdGpZO6Ja61OX9Q2gO/Ey7JK zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcdhbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:46:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393IKK1g002864;
        Tue, 3 Oct 2023 18:46:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46exy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDartqG9Wnjfh+QEgBgrkESce+SWSepe0Ok3HDrL+0zno0Ttl05lm+6omCCz9oUtW+VXUjg5Pjn5cVxxfePrDIo+//RKykJ6jusUVFJ3IjUTZvJm2qMYnWecLkq0ThR1ufy1XvqXvjJpcuO9tcDtSRnK8VkxdWi3X3TAzgdpfG9dQlFqxjMLK5stCykP1yzD3F5vBj83n3LKLWZqG3R7vmRKzKsqfkoyzSsKI3K3h8g/dLOMHSEK0ugqlQyXcm1E9WEmy7uRzQRgQmLzMpJiPs92rJNUfDZM0kuDRIDQ8LiXWfsiojKSvjclmAO3zpsM1b8V2e9ekYijdmJ7HpHChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEoxkJbxATccStmHfvO04XZnyBMbYvtCUZEclPyo8j8=;
 b=LOpJSOZtQlAoZKDJAZAo9jaXhFpjSq2B959TNcI/es5Wku0fC45FFUY1C4YdUeJqBL45dZyG9EK60YpSMkwICW8lbBQdA7mJdptGeerEfZdJR5INPv+eh+t+MlpuAkX01W0ks9Vq4uE80UKshRXokQXci5QwI5LeRYWJd6jtyEbbs+L04uDMjXwNaFgQb/KakDwmeAUh+NM0JSCn0NU4se4PKlQDf5snQbEORjE4NptmlhztsJrYKw/SUw7HPC46gZ0rXyUaGgZ/RxMFkBcMdP7Z8ziiVXNjPrY8u/+96QySOy7xeo/bbvqoa3Y3gKT7WP41Y2QZYj87yWsgNycmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEoxkJbxATccStmHfvO04XZnyBMbYvtCUZEclPyo8j8=;
 b=eUBcJ5SvH2swBcdCkBgNiRrzEbkwAVhopnuA1n078pf+Vwzn44Fwtc+1QoPtggT5e7T4RYQ0B3FA1bz420ASo+GgRl0rLcEOLlr/LtgeLplMMo7BMZAR5R2RzrLMggo7GZQzSc1iFiDWs1TXSCnijvi7mRDbujo3TJBS5ytwCQE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7855.namprd10.prod.outlook.com (2603:10b6:806:3a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 18:46:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:46:28 +0000
Date:   Tue, 3 Oct 2023 14:46:25 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] maple_tree: Update the documentation of maple tree
Message-ID: <20231003184625.lqnfmgc35o7pgeff@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925035617.84767-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0481.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa66120-177a-435d-3e17-08dbc4410db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uquIuWBmWzNNEXcTBNzOj3WYosDElWUQDhdccVOZApt819TFFdwsK6+N6fOoXQaN+74QIPcp8KtEiHDtvqnD6Z7yLr7TT9UYyncaz/A0JQUET+uJB1/gVrkpPLNVz3r8KfXPTPt9ZN9/SB5SFEglTmupVMcd68IFkuBM6IpMaSEulbVOZhEnQd5pOK0vXz/oSgHTU38j44oz0CXJEkhnc8c2TaYQLQccSlNiGc/3SltMLN8D6WEpWAp+LXa6nvTq2L5by4D565zwNv66UtPR6O838T1HkmzslmMsN9HmV9mQzTAJWGWdq/P/EJfkJOebXNRwfpoxft+nov/cvsDKbLOP3kUP7x/aMtnGHXkF4QOledXit1kH/PO+sI42iUrYKv7UQ9s+Y+fstRgUYZfb+t7uJP5i+1q4VzT9twcb8Y5lW3H+98zlV1j+PwDmvXNpR/GLakDMj2gxxDvVQ/U5zMeRUcBthJ0vts1dJl7+4iwWtb+wEpFUQGiIABlJSB7PNv7goeN23KgQaUhM7c7CO52GJd35Ou7YkvVvfrfYOds9DxvFkafRRww9Xj+M3aXZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(9686003)(6506007)(6486002)(6512007)(478600001)(6666004)(83380400001)(26005)(1076003)(2906002)(33716001)(6916009)(8936002)(316002)(66476007)(8676002)(66556008)(66946007)(4326008)(5660300002)(41300700001)(7416002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ma8rQCG3USQhtfKKYCNJIRAo4kvJRXqGl2A4PqM1m+/BYQiqYUKT8oM2zoC+?=
 =?us-ascii?Q?mWVmrhcSURgRx+ANceXPqAezI/YOwZt42vmGOjRzAFM9kF7MvLsVh7+ilXHG?=
 =?us-ascii?Q?Gw6Thd9ONXbRxHL5hBm8CZxZItqqTTI589sP6NV6hQ8By/uE2TX96QW34sR3?=
 =?us-ascii?Q?agxCs3g7cDQoVBnsYvY44a/0pbzrLreIhmx7I1+u5FlK6LULCMttjDe96RCQ?=
 =?us-ascii?Q?T6FADqqXYFhBfwAmzJtO23n6FkAXvxFXUNXdI8abIlgfkw8t7aJe+0jHgRlt?=
 =?us-ascii?Q?vWhika61gTYDesj2ixK9xaD/vUwKkjQxPz5uxum3HvXnC91GeNdmmZs3uGGm?=
 =?us-ascii?Q?ub40ToLa9R/bK/t8td+t1VPGTMy0UFRoLG3OqgUHuToHs/ZzpLbKs7Ke4psz?=
 =?us-ascii?Q?McPxEoHIDuAfb6uNKQVm/f2Lr5dRVyboi9oCShfkjITFx/AXrV4oLNK+AiKo?=
 =?us-ascii?Q?DDiC0OVF7xtOoeCz7MYDesG0w+Q5xzLfK6Imfgxu/E73zKVkFjolY/FYb/bi?=
 =?us-ascii?Q?CsGNVxKPXnEq5qDdZB9/c/D4SYaLpvAsDAPHHBQgq1qglG4PpG9nvuBPZDIb?=
 =?us-ascii?Q?NQliZIFCFFbT/2P8MGoyBr9O6aM+6OfMf/oo1vCZFr1hO/RKZ3gHXzixosWL?=
 =?us-ascii?Q?ZnmgrcVYWbFvf7grqwPNcwGGbj2hiPimu068xQyrCtShQDU84iCNCFa3VSBo?=
 =?us-ascii?Q?IDsFPtGq45BeqfoNVoTq+CgM6wLFSYWlLFLYai3et2d6MtgLiGDg78MYpVt3?=
 =?us-ascii?Q?2f3qEweoloStRMtPnGgUFFLb2xqgy7jNnURw/HOwJo/E7EKNh39mwPSEFd1L?=
 =?us-ascii?Q?XZVUCe7M0LFu7Vczg1guiXVxXxU7pJ8amiv8gz6GE1uTKWSN2LezTKz8nPQi?=
 =?us-ascii?Q?8s3huYPTBXbLFEuJ9EbADdCUt822LHFrhp3+Nh1EElXSOp7uHLw/zFP3X/b4?=
 =?us-ascii?Q?jcyMupAgmVKnqUsZ8k2U0kHaJ1nM/E8uPtgyhOj0mpshrMaxdSsKyewY7R9c?=
 =?us-ascii?Q?CN/2HOdN9vG4nRtPaiotR500bPl2uZRBq3B//AKRGwfKz68a0AosZnc5jjFF?=
 =?us-ascii?Q?HVs9/vZDlIhHQRkREqr382qkzJTi/Dq+8LdJMJeMr0ofUkRwl6lmgLlcbbox?=
 =?us-ascii?Q?nefxwVEk9XVKx4yUQy9PJJAZzG2IHja4Srw8R59lvpG3GqdO0nVmFclvKwM0?=
 =?us-ascii?Q?54Q4SLP886pH7REF3ZtLdYjVEy4NAN71RlfvAOaJbWPwKyjreYyNNklOdr96?=
 =?us-ascii?Q?arLN+vWmpSy3x300ykZwk+zJzc4VJqg4JuqrCInKk+J7T8+Q2yi0FjRszakg?=
 =?us-ascii?Q?PTplkctl4Xh/0oN/e2uFS6q5aOxoRC4KnO3D6VSpRVGUsjgzgy/5PfJYUsH7?=
 =?us-ascii?Q?KgMs3HoNRB7RPGsoLcTnoLPwpo8D4vb6efFnpjtMt49XhYw197MB1cgYzqBc?=
 =?us-ascii?Q?mZbRBDyxLu1y9DjCdW/HNCnX1up0wck1YLJEZXSx6/zA3EdHmZrnn0wt2XyB?=
 =?us-ascii?Q?NTGNoiILxXkZL9aE2Tu5gwFTuLnauvB8fJoqe6YXTp5YwLoWsHCNFdkL4TI2?=
 =?us-ascii?Q?14ENgQw+nK98vPwVE8W7MIb/UE70shxG/CKbDeJ7kkN5zzZXsQGUMPJA4wHL?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sGpCIkvN3/+SEde+3rdaoBiHCqvom0dfJEqu4Ixw149JwkmSiDr4TyS1vHF9?=
 =?us-ascii?Q?Zx0vmsjCo48yCcYTatl+J08j81S0uE7/zxu1LnJcOYg7sEAvwcZ6n8DOaf/g?=
 =?us-ascii?Q?CNYM6TPfo+apIeF4XihGt8W3TtIRVG4BmlnGBR7/VhOF4QIs8UHxgYF2MKFz?=
 =?us-ascii?Q?TSpZAEUlmokjIaiAQEHsgnguUG3WaK14s8NBJOpDagK2At53u8d6WfUyivgY?=
 =?us-ascii?Q?REaUYu4dqp+PWCfDmFh6EpGiIT/LYtPCcVvyRWkocEh3OttMUYRhFkSHJIY0?=
 =?us-ascii?Q?KgyUn7NSbgwXOWChoiQpbhn4QsXhNBJ1iP1wNxEt61IYKPsRJ/K1DBsM1Pql?=
 =?us-ascii?Q?oWjDA2ushLXaLITbUsNdtF9a86PhS99ZfnhxGLahoWUy5d68XVSJpUkfSUX0?=
 =?us-ascii?Q?Lo4+AzRxxV7M6uIQkMlfEUjlpVhaHmhle1pvdULU12ulAA0HXzhUonSoN2bN?=
 =?us-ascii?Q?mp1JsOKdXO8bQYKs8MMnWX981c/PwC86+5xmx4DletTrRaGq3akuSKsBhrFP?=
 =?us-ascii?Q?C6xsSgNjzWSe9KX/XI7AF4TBTpLzdEqs5uWNpNAV1Q+SIoSwXRcFEzK9jVzJ?=
 =?us-ascii?Q?uSBfVV7SHhlPpkXpqeS725SGB4aI6N1iY5fAQHIlW4hvoQWKzivXv4ao83el?=
 =?us-ascii?Q?9nnlXxJwmPdMzOXnynqXqeZKMv7Y3x2owzlTW5MxLTSu//toI4oZJal+AbId?=
 =?us-ascii?Q?KGWr6GhBXvXXrEjFeNkhiwZOAqHev2//EjAYImPRnuP9q/IZS9j8n04gIo8B?=
 =?us-ascii?Q?F/YiKR7fWTvM80XCgsql+8nRmYx7w3JMOQbuxCoc4QDZn12VBcgbmhDRcuMv?=
 =?us-ascii?Q?jdVNAbtKSNA+FgcBB9yP9LegQhvrgCX8jg5kCM+o34tBwzPSUcRMfpzXJlK1?=
 =?us-ascii?Q?SwD6aeG/OCf3n+dzwHNCUdThqYQWOwleQJyKHyZ+YHH2wPFjZkaP28vNwDzA?=
 =?us-ascii?Q?s+xKDy5AaAaJdV/1w88ya4RIT6fyqVLxoJXCPO0cQY3VbDXOi9p82GnCn6lF?=
 =?us-ascii?Q?l+6FnB12/1BkhyK3JrgchzjyJJi6V1U/kgTXF0Xinl5d80j0Vs+TtEMiPb5l?=
 =?us-ascii?Q?Dc7MVPexcKDJUysGDu6mIBOgFU8nQK7KO1gdYizQslyUIyJ2CnUC94GzLJ9N?=
 =?us-ascii?Q?/K46IiHAtUnd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa66120-177a-435d-3e17-08dbc4410db6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:46:28.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhB+WM1+4PcVobMTbcGTGVl4V68MV9wCURSCvnIaRYAZ+YqN5AaA3/bOlst4U07ibIBK7Uw14T4bWEjCIuW/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=804 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030140
X-Proofpoint-GUID: 2n-nSG2vw5WkQXGvbLzv8eRxMQirqdNT
X-Proofpoint-ORIG-GUID: 2n-nSG2vw5WkQXGvbLzv8eRxMQirqdNT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> Introduce the new interface mtree_dup() in the documentation.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  Documentation/core-api/maple_tree.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
> index 45defcf15da7..3d8a1edf6d04 100644
> --- a/Documentation/core-api/maple_tree.rst
> +++ b/Documentation/core-api/maple_tree.rst
> @@ -81,6 +81,9 @@ section.
>  Sometimes it is necessary to ensure the next call to store to a maple tree does
>  not allocate memory, please see :ref:`maple-tree-advanced-api` for this use case.
>  
> +You can use mtree_dup() to duplicate an identical tree. It is a more efficient

"You can use mtree_dup() to create an identical tree."  duplicate an
identical tree seems redundant.

> +way than inserting all elements one by one into a new tree.
> +
>  Finally, you can remove all entries from a maple tree by calling
>  mtree_destroy().  If the maple tree entries are pointers, you may wish to free
>  the entries first.
> @@ -112,6 +115,7 @@ Takes ma_lock internally:
>   * mtree_insert()
>   * mtree_insert_range()
>   * mtree_erase()
> + * mtree_dup()
>   * mtree_destroy()
>   * mt_set_in_rcu()
>   * mt_clear_in_rcu()
> -- 
> 2.20.1
> 
