Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590867B5E37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 02:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbjJCA3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 20:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJCA3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:29:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D793;
        Mon,  2 Oct 2023 17:28:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392KdNQp005388;
        Tue, 3 Oct 2023 00:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6QvIPHNqeMyV2IyEmPX3DMXV01W9GXDY9I4CdTt1Kck=;
 b=bhgBJazvTugocxLFyjVkUIyICF6pW66nsoXpszbawN7b1pslU7509ANei3m8bH6CH7sM
 CzSrsi3tsybQn7krjkkm9kcs/R7cU/CwoX2TtZEnG2S0owBOXD7YLMbmvgPLIgCxLZXr
 1Eif6asf62wW5jZNLVJsbvFBbCFCoRWoOQUZAJSFEHkgF1z7A0oVMFUhhaYs6q2BqoXl
 yHREIAN00XCaiq2qR0dgvIKP+X/oW2BtM/5ohAMBUiYfN2mSMTQa0+lzUPflhahMeiJP
 PqZVid9jD/uXSbHMyPFyBmJEsyjY9hazM5iefU5icj1PJzv6lMBzhckepyxcz4KyCRvj 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdumj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 00:28:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392NAftr033639;
        Tue, 3 Oct 2023 00:28:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45f4cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 00:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrUDPaMltm+vgzqZQcXmFo6H19ukcJRwHKBJS/x/pcLjxVDTRMWTMADi5i+N7zpzLjCbmppztXauPcRZR40eKYFQxE6n8K2xcFVZX6w1ik6fS36RqfY+5rBpJofcsTCCxIIQIOcTw5gcEJIsLUTClwu8rnbqj5mKDEbU79kv4zEFxHhDRHBXFOg46Vi72eLYJcteoOCos5juLPdFx/x9RihZ8jYn4rqkmzsc5vD/DxehGtP8LnBsKatmWML2/YVFrr368Vayw+DvGYj8IOToYBPHlt2yBvZ6ukpUkCsG3XEHVbrprmnxX79/K5CG7MD2SF5AUpvTgomqnKosRY9/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QvIPHNqeMyV2IyEmPX3DMXV01W9GXDY9I4CdTt1Kck=;
 b=V9I8ATaWbpz0kXwolq1g9LDGOnjiTGqAxMiOR/zYy9aety9gS7br7dpdAr2VGf+2rE3yt+i5+79SbWUi+b2RW/HJPenrgyMKwR8eGCNE3lWH2Y44IVrRhGrnUbMY0kVXsUTV0sys8Eh4taX0O6CMzzKz03otaBLGlkITlZUl22PVat73XAzcs+D7I+5yKqlPYYZWN6YMAXErBlABeH3n759xy/FYlGtN35ltDKRt5PcCAXDtWYbSTOp9EMCO3lBMrhZpOYTkljpqyf/Fq+CrEUC3fnUlTpAFSFjETNFQqd1xIHSmvwbXFqPGyruFpuSptt/GZ5ZSxq9i6RrBTvL54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QvIPHNqeMyV2IyEmPX3DMXV01W9GXDY9I4CdTt1Kck=;
 b=lvxUB798sSfe+Y0Yr/wAAJfMtbJjbgxCYu45z4Bo95L6w7TKHWjxKT1W2OpLzTqVrDuUinWgQNhLpNgYQXzfrjOaYsRncnRKNJrgxX3ymRbma7Ijpe8eO5Np272CyEsKBVtmW3HlsEqknNSKsol+r67LSv6zYGI30v18kvPexjc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 3 Oct
 2023 00:28:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 00:28:07 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0mctv2d.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-4-john.g.garry@oracle.com>
        <20230929224922.GB11839@google.com>
        <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
        <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
        <2c929105-7c7f-43c5-a105-42d1813d0e29@acm.org>
Date:   Mon, 02 Oct 2023 20:28:04 -0400
In-Reply-To: <2c929105-7c7f-43c5-a105-42d1813d0e29@acm.org> (Bart Van Assche's
        message of "Mon, 2 Oct 2023 11:39:00 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0098.namprd02.prod.outlook.com
 (2603:10b6:208:51::39) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a24cf0-2042-4a00-b893-08dbc3a79d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRX3MbV7IwZRIH6RgwLSZIS0qQimt8j1gKZvm3hY6pK71Mq5kGtt6PiyVhWKKi0hdNyWDfQqPHP14DP8ntJB3XpRI1lfgWiYVaPmDTQDqu3eqLqYkIa2NlvEeC7FzLAHX9ifVB5eUHHLbZRnzshsJWs4Yq9IyDmLYou3uv+qeYQAJvXvTT99ZiHhaa0/QF63V7X9jqcs8TaKh3XPa81JloUtAjA5brJuo0P3pMRpR0GhOf8P4ygtmcuQ/YJGxINFEuBVZeh8+uWcekN8Y8xwN74Ezn/555y86TXgw/a20fhSBor+dOvTy2nbl5tjY3h/1NgWoZN9pB1mSiMbKsLxh7CGjfKEog2N65R2y35BNOFMxJsrbDwowLExPBIE5Avoxhd6/3/JLsl9G1E711ZtC7b1vv7qxrHcCLjFyiEVMqn6ZOMsS26Nu0NNR4rLQ02ZA0QBOetPeyIt0AhQs3lPKAxoQxivU5FfrZVhg4zNTrQaVrbDjC4FCZhXOyK5CIDC3frhLv3fQNiERnrtP9MfY8z541b+9F7OxKTYG0UZkZEVSUwmlr+npC821YW/Yg79
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(26005)(36916002)(6512007)(38100700002)(86362001)(6506007)(83380400001)(66476007)(4744005)(5660300002)(2906002)(7416002)(8936002)(316002)(41300700001)(4326008)(66946007)(54906003)(8676002)(66556008)(6916009)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LTP04/r66SVpTSyM719txTEQrzuRWcLWSCy1Xw0S8D7JX14Hy1JsIgah/r7M?=
 =?us-ascii?Q?U2usGey0AtqujaVMAcD+ibEVVaYSlOQs5kAw3C1c4Kie7jZ2JxBZEzNS7Uoe?=
 =?us-ascii?Q?JxYcvjXvaB8oPT48W22112aHhBN7Ns+BPZ7IHA2qTJtEX1MiixBovmPhzKfe?=
 =?us-ascii?Q?HXMVkt8RZlPeu5ujZvMD+eVkjf1ceBNhQoMAlYQLW01OjqYmPm0psqSW/FIY?=
 =?us-ascii?Q?apvx4XzijuGlhJ0909IzqP/v64bsy30ymIkWWIwzJmlehUn6I+g/1pV/sVsG?=
 =?us-ascii?Q?Kyiya1loPmXz2lSVu78asbf9A+FPHpDnN8G21xz4uBT4H/cSExHsdjTXvXd6?=
 =?us-ascii?Q?C6OMWIw1lIyzPUYhcEYrICCwyth8tMHSXpitHOJV/sE1+Lu7EquCX5bZfgY4?=
 =?us-ascii?Q?tWawO5VXUYlX5Mf5IVhAXAGMvlyfRnccI/SFLTEEVayJTHxAyfmvtTerDnp/?=
 =?us-ascii?Q?0UZdOx93TgHWM5CD3tlkTWw02r8emvf4wPYb5tdQXLSQ91Tak++OLpR5WmB3?=
 =?us-ascii?Q?In/LY4GxOW8NVgOhT9IOqkg14llMzs6v19D6N66JQfisPQEcqnNfdeOSMkG1?=
 =?us-ascii?Q?ta2vwjHzrVHToD5O298iMOp/kgIAzpUHPiaidkSsRnsXOXX4pMMJYivU89fN?=
 =?us-ascii?Q?8CiRwVBVzyYZ++dmxlFFOIhmBE0whJ2iUXstS8kSxhX5q+8iF8p2DgZBwd5w?=
 =?us-ascii?Q?xcLHY6oMzF4fW5hAebOymsrWt2kJ5H8YxWA3FFv6Lu6FNiQbkywx1go8DL3b?=
 =?us-ascii?Q?uMSr56Gp9oNQ98wAeWjs45upXOvuG6BhKAV/Cgji1GVU/hbZXkeutAh9loDy?=
 =?us-ascii?Q?9NrjMuu/882MNV1/WkdAYLaqYoCCoQgamLpG9pheXXUQQW5tPcxXOZzIRpSQ?=
 =?us-ascii?Q?rc8wH+jCSH23qxD53UQWlrrqlqukBVqWZK7EKgNwdD4rNX29SNXrItUGcrrJ?=
 =?us-ascii?Q?IkSKZ/7elqvwi6CDV5t5GHZt5299dmUIDivq6tGgAEEtD+gGVNvCT8mrsJB9?=
 =?us-ascii?Q?KlGpxrcw1AfMmoQvu1AwwUZ8dtFEBFoCreoefSMLKqQ1mhamCGSwd4oFQRJU?=
 =?us-ascii?Q?oVV6UiJkAk9J2CEScaTzJus03c2o/f9HmBxRKVIs5xbY94w438tVWbgjGb1i?=
 =?us-ascii?Q?prxy3PwCNQBnTosKNQFcLI3NavvHfA1eONztEw8Ub3ABfE2sah1/95sPRGSd?=
 =?us-ascii?Q?VUrf1/hblSrLMn5hi+zCp2rD0glXtgHoG+pjgGSi6WyKZUATKmfWoFbdSgdg?=
 =?us-ascii?Q?ugNJOOzkXpnTC5Ucg3FCSdsz9Pn81FWWU0OsQSaThZ8oizInLVV2XE1jvxbb?=
 =?us-ascii?Q?iWagXo8riNeU66n0MmfCiO//URj0W5pr/srDnmxH3Okge+4S0JLac6ltmNYK?=
 =?us-ascii?Q?3wYyxdQ6O4u6IpyLhDqxD6zrX5EiITDQhPT2I/VymzyIrShcJMF5QfNgR0dZ?=
 =?us-ascii?Q?kk8PDESLssRadBJb3789oxrYsUZ1Aj6nfP0XqoZlYCrfkmu/F15PAxWA+WwM?=
 =?us-ascii?Q?10DdmTT5sEIy5vv9LDc0jz/lotHmtoJH3TAD8YP9ompdtg62nLOdTSKsgfEF?=
 =?us-ascii?Q?QYpUSLnQ5Pih7KAHIsCSm+82wBOP8unEvVRDySZtLS9EbshaQBlwT1hwuMyY?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?R/KLtKsxHQPnFHR+YnNO3TNpvCKjKbt4avRNTmyrQSkB6LY8GxlA7gSaZbFS?=
 =?us-ascii?Q?EbkkaOwanq30byKmsEe2KXmO2CnRX3SWfb84OR22WwWHh26qBMgSDm9G2u+K?=
 =?us-ascii?Q?tQM7Yz2LQlNK42cyZkUEEkpWt/+5UFJ/j7RgONObuAL/1jca8qvOhWJqM/Uj?=
 =?us-ascii?Q?pV442I6q66+VVXAMqceGETwBP3dXFqm7DZsr8Yd4dewSkW/md5p9OfFUwS9x?=
 =?us-ascii?Q?Vnl2V1iUpZYtg2/SlGlVLTQ8MW+XyQsJMTWFAYavBqs9enjWOCKYmPdU05uh?=
 =?us-ascii?Q?jksSijnYYTim2EgLSQT6z69x5hIIZekYC848Vri2rC62ezHyngaxLCcvpFX3?=
 =?us-ascii?Q?qG6mE1Weu5DF1PykJkct0tojsuvqQX0VK0UU+fmGXAPSvMj6rhY+6hC7h6Jl?=
 =?us-ascii?Q?kP/kEud9xFcZONV6yg03dsYl7CgHPGwD2+goNgvhN2j7Vdbw5JlWiwtkMEbi?=
 =?us-ascii?Q?vNSlPXe6sYMqDr9wyAcWhE+Ik0XotU5jfxlsj0beopHB6a4P8uIqoDqer8xy?=
 =?us-ascii?Q?2ZaM6wbKF87MqmD7Fq7TaJeuOQEKem1drcr3WLaoUpLsmWTcQMudoQGrf5YL?=
 =?us-ascii?Q?T+pj//+BARWxSYsrilcpiPF/WsMGrdIurISRrErIKP1e/62XIXG7l+DKRK2m?=
 =?us-ascii?Q?5TyRw1wGBYVpteiQxfeQzOAQSRaw9mXIzzTbjXFWZCnvQn6OyIUs8FGAjEWA?=
 =?us-ascii?Q?rB5wdBbXWSWc6zkXYEggkkhC9ztuCTBe7p0IFlmLosdpWzRz52IX7D4MOmn6?=
 =?us-ascii?Q?h8+rQs2gpLCXFiksZHG7PRc5jvEltGvqpTPOTNca5RC7XXUWdjaT6BCCxfpC?=
 =?us-ascii?Q?bElch1D1uxhenGVsZIYt+tuvfCKoyv99Is7ynJRUG4NzYw6qeMhmFgBGtR10?=
 =?us-ascii?Q?7Hgnszq7uug0t7o24TlhYbnMvFoXRxy5d3OP22EWjtJtrrbLqSrVFTQa0URt?=
 =?us-ascii?Q?svUtRJhSqxPnIzmun9zwgzvsv1BrCmmuFJaJ9yYEeWvIrxW8abldrkIQ9nI0?=
 =?us-ascii?Q?u/TfLVMr8TM8uthxxrVasET/DfZlubKNeVPy/C8U/sfJu9lpdy99FmYXDOTu?=
 =?us-ascii?Q?gNFixFsdV31UmzJwAUiBGnO7+UInxzBHZXYOhyhv/k9ohvnAmtM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a24cf0-2042-4a00-b893-08dbc3a79d06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:28:06.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2smFVYfy1KCCNXZDNmiiCBgvtN5y6Snj1n3au976nEAZQ1aEQcaTNBVuGS1uGryU3bbNPpc32+QJhtmqFcDFlBlGZodP1sSvE+dl4ctwRhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=760
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030002
X-Proofpoint-GUID: UNZ5l6D30a6U0C0vgV9pTldPwA4GMiwL
X-Proofpoint-ORIG-GUID: UNZ5l6D30a6U0C0vgV9pTldPwA4GMiwL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

> Neither the SCSI SBC standard nor the NVMe standard defines a "minimum
> atomic write unit". So why to introduce something in the Linux kernel
> that is not defined in common storage standards?

From SBC-5:

"The ATOMIC TRANSFER LENGTH GRANULARITY field indicates the minimum
transfer length for an atomic write command."

> I propose to leave out stx_atomic_write_unit_min from
> struct statx and also to leave out atomic_write_unit_min_sectors from
> struct queue_limits. My opinion is that we should not support block
> devices in the Linux kernel that do not write logical blocks atomically.

The statx values exist to describe the limits for I/Os sent using
RWF_ATOMIC and IOCB_ATOMIC. These limits may be different from other
reported values such as the filesystem block size and the logical block
size of the underlying device.

-- 
Martin K. Petersen	Oracle Linux Engineering
