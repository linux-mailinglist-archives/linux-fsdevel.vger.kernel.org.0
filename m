Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327A7BC316
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjJFXtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJFXtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:49:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DEBD;
        Fri,  6 Oct 2023 16:49:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396LO2tJ028862;
        Fri, 6 Oct 2023 23:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=f/7V4GPOscG4FZ74AixysPK9SejqoXIFuTFl0Y/uaCQ=;
 b=Vc5/AYRlhseeTrW/mCpuXKMtPsWhxUtuEP4rYvbQbDwDSTwbV4ItZhAefxtT1Mc+6+EJ
 Bf/hb2FPC6aeNgOyB6H6qhLPZkFswpvkn+n2vAsc3y6BuHyNoUs1CsCdUMVeCRbN9CW7
 k6CUnQx+WkpU72v9vO1EF5hD3rA+yaNIJ6emLTY8mLVE/ivQdWemlNWqmqdo6HbK08Rq
 TV6BXdI9SDcJKEjpIQTDEjDJ3qmZdvVw9bxDIwjvCzzMfZ8qT7jTtbLdpNfPXIhfuML5
 AvFtRs3F03gf/MpDLA4JkdFET6MyTnNjVEHvchTSvDEhZKz6dyW59dFBf4kWHPKUz3uO Og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3emwuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 23:49:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396M6P9G002843;
        Fri, 6 Oct 2023 23:48:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4b929g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 23:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5j3ttEQY24NxtIENJGMY6YcW8+GNTCdtB+2wWMEZNj3VcMMSgyPNhzGrQ585jvhrRyJ5Iqva3BNb5/RpNGi4BxJ7pIgtvC48NA6ajLXHdV3pOEvFL9RjCTbJ6UG1b/v5wUiimTKnYps75Tjr/ZRl2jsjWQIckOAVmXdXwoX7WVviHjLgrbwRxiv5emeobLdIdpa71m6lboDcFkuaiPgj8kRq0FYAla9o66HXapuE2ycxa/w5zwpoO25ZzHQCuxH+X0FM4ObC0VclH8wsuu78CrHaUUKSiQ5gHyVb5rtJPMNhsR/7rqtUzsgGwLlqyUQqRapywxXgsHS6X3oxkJNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/7V4GPOscG4FZ74AixysPK9SejqoXIFuTFl0Y/uaCQ=;
 b=SXWMhiTY8cvHDw0ywIoJCe5AusQ3yz7Latiiq97nhJDZ9Cq4jHyYfBiV5eTcfdLO7VmYjgG0Jj0HgsKcQbbd9eYK9k9vyqDiNpOtjw5c34ls867++6dVlw5kC3X7Kggt2O7ZALgfKNZ7fbiqSt2HFR1/WsMz8shVzVKDPO8yCFmzN3YtsDYImmQaxnEiP5qTtSY9Y4ImpvTL3+VutnfEz1O8fS6MnmEiuuzPtvozik5EFyPDdNtKDBf8C2/43E7BoS/HDfwSOSh22cmeSHfL+ziRcUI03h6yZaO8x+64w/eH0dBNhhGj924wAzC3yPisw5wYv6itEouTblwv/MjiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/7V4GPOscG4FZ74AixysPK9SejqoXIFuTFl0Y/uaCQ=;
 b=PwU24EU8ht1IZ56/gbR+tN7vFDir5x26c3YXo+twTkuVTYZq75ngZuPyoO8BvGSYd5IwOLhok05QwE1Hz53ks1FC8YwDbizFrJMOI72ozj8m6Ld4ubX/4Gl2GsXYtBI8kWcfT9+r/OAr9YieBKJmD7OKdmK4YYd6Yd6jUMh9IeY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Fri, 6 Oct
 2023 23:48:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 23:48:55 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 18/21] scsi: sd: Support reading atomic properties from
 block limits VPD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qe7qptg.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-19-john.g.garry@oracle.com>
        <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
        <53bfe07e-e125-7a69-4f89-481c10e0959e@oracle.com>
        <a7a24914-4940-4a23-b439-bc8f0ad99212@acm.org>
Date:   Fri, 06 Oct 2023 19:48:53 -0400
In-Reply-To: <a7a24914-4940-4a23-b439-bc8f0ad99212@acm.org> (Bart Van Assche's
        message of "Fri, 6 Oct 2023 10:52:40 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bc7e5e-c600-4d7d-1494-08dbc6c6cd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSjhlboLOt/RURTBKShc4HwCdiY9xMmItYTlJ2fjAE0M+4VpKRXYb17gxoItdUFsnbxS4y0Z8zl5gA4Z+wXPkwAPd5XqHXQrs2veQSxafKqCqasktUQdapExDa5kLxSAoojQ0r5RAn6ClaSIEIC48MXOEHuJIAX5MNO8PBKwmBWJ5ycfRtfpkj8H7kbCVV2NzrnITqIeBZ1SeXEmPRJ3HGeFyLpevRvTdKH1UQcJXsOhj0+KXO3pQkAIAMmA+bKits6iDhtG9Qea+yqpxFYyhc2+NfIlrS0nyz+hReqCJMTyM2CSRFinq04S7Obx7m7idtwd3FJWha4pLa2LrZB3vnO4yFnDNpECKFkNhYW1eGsYEvnE2iOkmu5hOQsAxB5D1bV8+ArNcqnOXWYxNBvIujaLaKMtZvEWUhRg1DGKs14q5QGJJ5QeIZx2Bj5kMa5FjNX7zzbyB3uphw4MUVa8wsL+jPQWVXolHHACq2fBwbZa7nuo/h7vF/8o+xdPrFiuzvguFpuIA0Pp7lNNThJv/UioXiI1L8SmpXDdfeMUGrSijRb23ERtO+CntD7j6nqs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(478600001)(6506007)(36916002)(6486002)(38100700002)(86362001)(558084003)(7416002)(6512007)(2906002)(66476007)(66946007)(316002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBvNMJ2aiX03/sjESb5R84TGEdSXCXjkrXgnV45bKC6fj0y988HgJaIWuEUR?=
 =?us-ascii?Q?CBnW1dJLVLJBxCagZSA3Pdz/h6aVE522cHvCMAEogVKvxRoch5DEYFvXsF9G?=
 =?us-ascii?Q?+H6QrOl8IVZok4I3028/U1KdkKILETUhtMXhNadAbLa8CZQjU+COyhHdn1en?=
 =?us-ascii?Q?drnw7J1XcurMosK4w7CE/IGGIIOE1W1i9/zugwpA+6dnsSnHi2CF1fyJjiSr?=
 =?us-ascii?Q?ywxyfiK7SLNBHa7C/yVhqeCgPtdx5u1LeeOpsGEo1UUgWc0HrkrlmJS63bwM?=
 =?us-ascii?Q?IyHViqQOwtD8c9HHKpjz4T0i6Oa6NA2iE9sCU0Pd2PzkPIenlPjgu8xcBrBE?=
 =?us-ascii?Q?sob8mxPsc546+hJ1vGCgeDdYaouML8G+yYQyeokBmYBkP8L1S/C9at7Uy4TB?=
 =?us-ascii?Q?80S9to8rsa/oiceekDa4KSXbgMct+YEuj7tdxpW80N8dhSUhqE84tAbIduPa?=
 =?us-ascii?Q?u6aYwZbw/nkO82TJE7SK/vIzqDe5t7Y6HTTI6DwwgkJGh+nR0u9UrlQCyxxj?=
 =?us-ascii?Q?KrhH82r3A6LuE/jqfhiIqDoy2b5GLVl+2qZ8zhbjzUqNFnSqmmDK4Tx/w2bO?=
 =?us-ascii?Q?IFh1oJgalePeNsYA5aEWJ0GOH6lQnU1aU3YtCOlVWsON298DM01i0OqVeSa4?=
 =?us-ascii?Q?Gw5cy+0qEc240pZoflXojqktJWCP2XrZOdUGhcniHxCxfxMbb5HgmqsUZOwl?=
 =?us-ascii?Q?FPiMDmFWWKl3tT7diLKBXeLPdA6Q+A/4OHEOi4dqzyYCyUK/vXxTsIilMuGr?=
 =?us-ascii?Q?g0oOZgyHrekqnSylRRdIejBSWl4tZJS1xgqyNjnLBz3+3z55yigbhtc4Foql?=
 =?us-ascii?Q?zv92sldrVurAD8gfT1Wn02luubFBh1Y6HM/Ea7FWFAB1evbWN5LeUF+jhJZ5?=
 =?us-ascii?Q?kImOg7BuqIaImda9oWXxEatZPacaKdYmCADmemZkr2zclIGoM28V/rnUCuN6?=
 =?us-ascii?Q?4yplo67iLDHoMwifE1qVowM0CR+ejSqQ0LQoKfoxhafmEd8n78K+GDhDUZr+?=
 =?us-ascii?Q?i5uxIbhjvQwIy6tQYMVnA/7HS9W/d+cHibhfJNuyfAMnyFvYYdJ8ee4LsC12?=
 =?us-ascii?Q?QLMBVdTHdutm/SMUZbWfsP7GWeRMnI5+IDNZRP0LJ4tHremvXbsg5Tj6zpAD?=
 =?us-ascii?Q?YxnwXXkIhaMuB/OFhUU50skB2BfXlRRsgEbWmlFCbP5w//w4ZuaHRveH3HlY?=
 =?us-ascii?Q?1BRAfzuXjUvwFh3fXEu4ihC8UTznjxr+q3ltSZS/TkBZznZAEb/xqkJwVLPq?=
 =?us-ascii?Q?xcKhxT9F9IrSrh7FQVqR6DCfSq5GtI5a52WtU77Cdwu46A9Qov3Colyx9LaB?=
 =?us-ascii?Q?67vHy73k5CTNXe5Uip2Dcu4DwxAg4WfRmufx9mG8fgXfOnaZjlCcLwcqSBUd?=
 =?us-ascii?Q?1MsCyvdoKv0J3GYta3RyNhvqSS4asXAeAXR4/lSzAjiDI52ufUpy/Ei0qqx9?=
 =?us-ascii?Q?X3wqmJKAfiRSNMlScwBOaJN6kUy4mD0DCzC9qj0f6+ikmCDWUci3Cb5k5xQ9?=
 =?us-ascii?Q?EAQXHyz22b5l+OlEevsuBWkUX/7+cuoGHD3wevFniwcWRMZiuO2UfaLIYjuo?=
 =?us-ascii?Q?dABZH6WZoLT5vSyt+3ineizeWZQuipu9G0nFwYE0sCzSperlmIl1I4OGxFqR?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eB+nI1oKxA3Ufy5B2I6IpCzK6XAOXIg09Mrdy6V/UJ9TaACpRFgnerNpnUg1?=
 =?us-ascii?Q?XOytO4cbc9LJhL0BULMSMtNrGxr2JCsE0armDKasedfKLTrCUZSaeBYnf9+c?=
 =?us-ascii?Q?ct4zs+pTKGzuezdcOds/vHI6N4peJfW1l0RDZSvklcc3kC7Pk5M8XOnVTK6Y?=
 =?us-ascii?Q?rra27F59/xLT0XDRKZ3TL/pdumA3ziFsfFyiszLn8e9JUYPZkItQNmF3y7fV?=
 =?us-ascii?Q?r2HouD/obLMemppQkU5yS9ibfbx4qcnoTzGH+O4QWI5vvkdyfsxyZyrhW0J8?=
 =?us-ascii?Q?e1uXDbgJxHpmweAA3WempaYGDA5/M9X6rMnBxzlgkLPeaZ28knNvt7SqadhS?=
 =?us-ascii?Q?HXD7Ni6T53WF4DuhNAjcflF7B5dRQWqJNpLrOMXdYhVKfYLP9WAZMr/SnDfm?=
 =?us-ascii?Q?sqCirY5lQafBUJh/JkT+QBLHTilH8jJENlnimzGmsHDqebsZllhfM2PO3PA0?=
 =?us-ascii?Q?lf77affbgGoHW7AMb6/9bignw012BixtrH7CniLfJ411gZfbDxk8PHMs6Zhd?=
 =?us-ascii?Q?RD6eCNWfRHuGxUF+L+J34B7NB+2PtXImKbtt+nNYdDbG0xoi0r+f9WPw7Ee/?=
 =?us-ascii?Q?fdN+1QVs4YzarMqcz6WTGq8ja3gqkZ+ZqTeg+AonbIiGsO8GZ/NR79PcOy98?=
 =?us-ascii?Q?M58GBVK61kth67ksEIXtMdOjCr8DiRoeHf0SuQ9PD9cpLWowtjy+hHGGJ80K?=
 =?us-ascii?Q?7dN164ARZkki2TrI/PNp+W29dqYTza6oE2W3BNdnD5249eJ7Dkf54Usw2zaM?=
 =?us-ascii?Q?JaBXlcZRLmc//IwwYgh7i07K6a3UFytYozUGals33di/Y8ZTY0wxS/lejxeB?=
 =?us-ascii?Q?eadPDX4cbmusnfUO5vUzG0KcxBthXDidQ2Vs60miLaRD6njrmeDpukT4FVFh?=
 =?us-ascii?Q?HnNlnHqTbsnZpKviANIJsF+x/uN626IyTx6vazsomCq/HLJ0l0/7QjKewEeY?=
 =?us-ascii?Q?QIRTTlHlDcG9L8eld+i9D2ojov5FHqwpqGjKmoA4rEAk0/JZ0l01YDct+frL?=
 =?us-ascii?Q?wU5DNUUAigxeLTdk1FAvXypiPbfHmOZghB92RMyRRr8fpUDk1KRsev3AdM0U?=
 =?us-ascii?Q?+b3oE8Hdh3Vq/zPJu0AwUeiYcFc/1Bga9c9dEeTRl8UyxkPq/L8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bc7e5e-c600-4d7d-1494-08dbc6c6cd55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 23:48:55.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gvSxVdnuJwZtVXceZxgz4teFwaCwq5GwgmMU+CFk+fHEUUwJjwcbalkvoaMSx2fHP2ti3XWKbyGJMQk2GyDx5IZuttnBeOsZRaHksIeXts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=752 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060184
X-Proofpoint-ORIG-GUID: 7NqGmHuYDhNusafGdRtd62H4fiSjOoyJ
X-Proofpoint-GUID: 7NqGmHuYDhNusafGdRtd62H4fiSjOoyJ
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

> I think the above means that it is wrong to round down the ATOMIC
> TRANSFER LENGTH GRANULARITY or the ATOMIC BOUNDARY values.

It was a deliberate design choice to facilitate supporting MAM. John
will look into relaxing the constraints.

-- 
Martin K. Petersen	Oracle Linux Engineering
