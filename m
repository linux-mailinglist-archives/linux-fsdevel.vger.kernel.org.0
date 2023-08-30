Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7E78DABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjH3ShC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244691AbjH3Npb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:45:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66047A3;
        Wed, 30 Aug 2023 06:45:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iaYZ020899;
        Wed, 30 Aug 2023 13:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=7OMYOCFlrq1OL+ZZ2gDcFmf9YoQMRai93ySuDmLrS7g=;
 b=osrTPgH3prap4VLIVdwQlMfrknLn2L3RJpmlTF7yIYKIpkjwL1jp6JW1FWxb9k10tGfr
 vvOfJFAFDK39y4+On9fjMeeoogGeqzsbPuXGa9hXgDr9wmAfQn7/fR3SotUreiX/3cJ/
 +o5FJhQDOoSpWGxMDSrcmDdFaadxPw9U1zWhrIQ5qEBaEZuNs60O27sXUyWs5QhgT7oJ
 eOmAeUroUGnc68oEOBnVLFPU7jaKh/6Tht9ceFSoM1taBxGNwN46sKro8WYfjMUdsvOL
 nRn8+alS81Kv1PXmU6yZC8euBk10QsRfDzV8b2Ktmi8u4dmaClHuvNddFOnLksZqFKY0 gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcqdjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 13:45:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UCB5cY001324;
        Wed, 30 Aug 2023 13:45:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssyw3qb3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 13:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpta0r4afNTqYNdTH8Uoge3dSwOKwVS42FKPutoJ6t/071G4xLRRQtpUCPc45w/EPgsg6JTI+yirAGGubSfuFfVdjgfP7MsGcf6+nAl2O9Zgi70cSy0eKMswuw1JQbAeKfZ+QkjQdGpq0xSl4H3Pin7Wp5W1R7u6now4Qpj+5oYWizQGuipaFj0dDXJPqe9iNnuPcMgvpcGDqjuDfwYmSkHRYgcRxe//Z8XGVsrn3RkJ8BXHG1EIyUsKfJONopAER/rSksGxO2/Z6PQ0zC1YfGHmpbC1h7lQ5aCxzsPJ4RoTQQ/xhAu8CKrNVwqPnbRtuuxOBK1ANAusUTJdgXrMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OMYOCFlrq1OL+ZZ2gDcFmf9YoQMRai93ySuDmLrS7g=;
 b=Bd/8tFrc4QN9JJazweAEoByHLHytb1pWpdV1nCkWCsDkYsJdln/FGekiRfHVKEMRtkoVqYAnYIKX36Ic/rUWcq2/vOk+XBmpww26AGlFfFqoSBsEP33NJIudsH1Ahz8lYKxhQ2pvGngE58ABgLlIOKkZMu+H6CNZy48UIuFoFzNQxedvi9zJR4urrJ7wc7hzyMMdMdAf1r2bQYloKgTipE2OY+MAPeYDC3px4XNjAX4qvjyQ2/mYc0ZJXEp4ghB1cB9NIyIz+tkbtR2D0q2UL9B0mkn0MzT1VdlRDsLC7v9SaqEwqnMoYkWuyXXrK4Twe+IKn2BeoNBW9tjR/mBFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OMYOCFlrq1OL+ZZ2gDcFmf9YoQMRai93ySuDmLrS7g=;
 b=dmFnAz/SMz3T/XeI687dlv0u0b31aGxA/IGrC45Io36wFWIExtlkBeOoH2uLBqAMGBbrCNf7+Sq3ip3qV4DHh3mEOI2ciz6uHL8CwZ8TwJfGVuYyBAHaGHn9YXMZe5XiG1y0phE+LQZV7Jn1On8+jHWxkVbQlEzso3K3JG94Fl0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 13:45:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 13:45:07 +0000
Date:   Wed, 30 Aug 2023 09:45:04 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        jlayton@kernel.org
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
Message-ID: <ZO9H4DnRD41I3rVs@tissot.1015granger.net>
References: <20230823213352.1971009-1-aahringo@redhat.com>
 <20230823213352.1971009-2-aahringo@redhat.com>
 <ZOjjB0XeUraoSJru@tissot.1015granger.net>
 <CAK-6q+igvE4y-jEvdrjJHW_PnnATtcZGzCkTzp41dFBhynE+Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+igvE4y-jEvdrjJHW_PnnATtcZGzCkTzp41dFBhynE+Fw@mail.gmail.com>
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ccbeda-63c8-41c7-9ed3-08dba95f5267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /huXeYEyVb8gnaDGjh7Xl5hGH3sz/aW9mWG/CUMNrM6UUAAjX9bPI9zmVR+pg2F1wdHG3eIGMsJG/RB/7AKERDgcjybqEzS+xBZ6RCRInLeEBZFHIk7sHthVT/aPz9ZmrJCBhp18EEmB8JxK7k9dzav9eNrg1O2C3GRu18bY6r7VSsmb9S8DMz23AW3LpnDeUk/0d0NUkusdJpmkKCxr/EkgkCefp+LwgdIzIdbHAZqYT89ZAhkKpvP8HSI779k/5alkSLnCMCMUqQPzgb1yNv3Z9RQchUbkx6VqvgCmThZTqg8bmfYpH24AnftVU7esYKuX2E4ye2XkcunUcBCzM6yuXalpVYrY/d9i9DgimrbRk0L82d/aGE46PlRZe7jsKCc+Pr8i+YsMwHR3r9AHg3vtKHaDP2iTTeO+3xR/zH9PODEWyUaVrQmPhPsdagXC1kY/TAEdQB6wV8LA/jqj3wOjVJeeF277PWyh1CLIXUEHWiClw5ApyvW6cC7oWSKVqGAeaNLlht3G5epQTrlwi3UHjeJQZ94+QtQftGDPv/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(6512007)(9686003)(8936002)(86362001)(966005)(478600001)(66476007)(53546011)(6486002)(316002)(6506007)(41300700001)(66946007)(66556008)(6916009)(6666004)(5660300002)(8676002)(4326008)(26005)(44832011)(83380400001)(2906002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0R5U3M4UmllR3RRaWp4clQxVGtmRzJYMm5yN3RSLzRKN3R2REF1Z0o1d3Fw?=
 =?utf-8?B?bmxOZ2tBbUliTndUUldtOXcwUURaTitHYVZiQXZnMlZBdE83a2R1VCthYU8v?=
 =?utf-8?B?NjNHUjVYTEcvV0ZEWGNtd2p5a1pIcGJ3TFBOSjRMeGFWWkpya1d0bHB4THRa?=
 =?utf-8?B?SnFsN0lDZTFFRmh3OHpqM2VBMTNHeFNMSWJDOFRCWENlK25pMDR6QXRLL0dr?=
 =?utf-8?B?OE5CZHNNZDAxMmtoZXZNRWo3OEJJZUNjUVcxS2hYZTBPNzA1SmdTcGoxc0JD?=
 =?utf-8?B?NWphdkwxL3BoL21TcjJjam9vRWE2MVU2a1VXMDhhZENtNnVNSksyZ2JmRlVo?=
 =?utf-8?B?a1FueVRCY2FxUXFXTkxSNzJ2YjlVZ3NwNzNldytyeTF0MFFmN1ljcVJVNEwr?=
 =?utf-8?B?NXFQZGlpYjluclMxREFtUlh5Yks5OWJ1MWx3VjVvcnNyRHp0UVhQcUhRQVh2?=
 =?utf-8?B?dDJlZ1B0b0twQ0RhMndzdTNGVkpwNWs3aVN1ZDBiL0VZTThCTm8vb2hrUGZM?=
 =?utf-8?B?OTdubHk0VityZi90Q1ByLzJJa2VPamZDSGJ0czU2YWdTUFRvZ3lsQ0xQY2lM?=
 =?utf-8?B?T25xWmZHV1dGaVl4ZDVYNEYwYitLcVU3UGtrT3ZMUzV2SFZ4S0RHNTRGYWY0?=
 =?utf-8?B?dk1wMmxtbUQ2bmFjOHRyRjZBUHRIYmxsWm9xR2RYblNzYnZqUEtMRWR5U3gv?=
 =?utf-8?B?NjVqclNZOXdHU1lSeFMvL29LajFnU05YVE01QXp1dkFsSFJPclB4TDNCMUt5?=
 =?utf-8?B?SEp4TGI3OVowMVg4bDZkMUVBc2huZUFuSTFyTWxBOWFXeXZVNXYyRWpRbzky?=
 =?utf-8?B?OUF3eVRRdkpxS1pSVVNHV1JOZGMxc0ZuaUpzUHNLalhESTJxOGxienpVejhr?=
 =?utf-8?B?eEhDODRrbndhL0V1OUx1M3gzNWc2aHlLUXhkMGNNYVlHZENza0xJeVAweXll?=
 =?utf-8?B?TUpTTUJqeHhTUDJxZzkwa2xGUTVBd0ZVVkFSajJERjZ5RVhPcThVZDdFaFV3?=
 =?utf-8?B?OFM4RVhLQVNyTG9iT1RiS1Y5alRmajRmeSsxMERwdmlTbmlYWEd1ekU4M3VG?=
 =?utf-8?B?dkovVkxvRGYzUWxFTWZtemVmU1FBemFWRng0ZU0wZFRTVEc0aTZLdWkzbEdr?=
 =?utf-8?B?cWZNY0V6bmpoaWlWQVJLZlpIVlFpdzNkbGlFcGdCa2VDZm44MnQycFZ3amwz?=
 =?utf-8?B?Y2tvL1dZQzliUlJCaXFRamhRdUpvTEd1UXN1U3EzMEVHMXlKdDhzU0IzQkxE?=
 =?utf-8?B?ZFA0eXhkVlBqWkVEVXRzQ3pJRDJQWEJZOXgvSXRaWnpEbno2Q2xROVRNWXps?=
 =?utf-8?B?dFpjb2FkajZKQ2t6bkMzemsxTC9EdExpWHNYbTJnTndiUW5BbGVFa0M5R2Ji?=
 =?utf-8?B?ejk3Z2UvbDlWQzdNVzVsNW9qNDNWd29rdGs2WWdIbjdBNlFBbVROQUFXNnEv?=
 =?utf-8?B?b0VFRUg3ZXkvdmVBVk03TXppQUZVOXdWT0Y1MmdhRHlKNThjakNiOHZJTlpj?=
 =?utf-8?B?NTE0N0Y1ZWFkWWlZaWwzaXJmb0ZBYnZxTjlleHdHbFlwRjUwa0phL2g0N1BN?=
 =?utf-8?B?NnVBaXlwbGxBRlk1VDJzcCthUHNjTml4UjQxU2lYV3p6MXlqakJTRmMwTGdk?=
 =?utf-8?B?VGlMWldIRkF5ejEvWnpNOWtwd2xXRE9aOGxEWkdzQXNZdEE0QlBJYXIzYzgz?=
 =?utf-8?B?YmFVSUlhb2ZNQXRvVzdlQ0k5aW5SdWxKNkRRMjZQN2V2cWZBazl1RGtSc0tw?=
 =?utf-8?B?am9BMUUvdDVjTWhkb0thOG9LaDBPRTVOOExiVk4xa1dZMVF1ZEhpcUg3dlhL?=
 =?utf-8?B?UjEweXNCNXFJVDl0OVkxeUh6Rk85NFBEdTZJUElPemoreGtncDUxM1p3REJP?=
 =?utf-8?B?Mld6cWRHRjluOGNxemp4ZmI1b2RMVExOWEgxODNTU2tNdmZ5VzFOZFVLSEhD?=
 =?utf-8?B?YXdJamJFOStwaE9ZbTF0a1luY1oxaWRSaDFzMXE2SDB2SjdaOHlBeFYyVXhz?=
 =?utf-8?B?NkJVZTNXb3hWQllSaGpnN1BJSk1iV3ZxUEd1OHFqdjY1Nk5HalVYempzZkh6?=
 =?utf-8?B?b1BjQms0c3BVa2luM2JpZnZjYS9lYTA3c21HQXJzMkcxbzN3MjJXTzl6VHJJ?=
 =?utf-8?B?cWlLMW9YVUJzMFgxVG1GaUFKWXR6WlQ0Tk10aERDdEJzNko5VzFQd1A2WGFY?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 98UogAr7ADYrhHNAPlhGQu6D7Tg0M/YexPvBicrThQyVv2Tqml6V79clIfBjmcsHJnrIDQxsm1xjDYHaNnVLHNvAjzJpG+cxcmZMs/VvAKz+2AMXdV1siybddhv1sEOR2OOYBdLOhD/bAVap1a/zzisTpBIKzyava0g2QwHYKmOFHLopSmP1tti2yBBRBDlA3VwojXy3S5GVVy+gacsyYy9AiiiNMRsR89T6WpVh5bj70a15DoC9tbBl90Pqfl4QZCdX8Jmv+NudL1MlnUc0BJQbRT24Akbsth0x6LehkcnMPJ0MRW2KSzFmYYirwA2u1UGiSRj8Ts8dlFwdUBsL+vtNfXp8YmRQoZDxnaPj58JA9C2XBH6Al+cTfyBe9zr9qwo18ILig0iy5/0PgwzBD18a2B4H14rYY+F0vg2+OgtGqPiBUDl8mtYFphZdp7S/n1KVa8bGD7AzLcpKcw6Sgpqlfw/Z8o/Kv09x85V/Awj3CJ/Oyd9okVu/mRYA1sKV6y8PYnof1TPmU+PXhl64nX29JZyOAZ0bTX7sX1L6hYd7jsNxSKiHtOxvLrHXRrem6iaOoLrSQpgIfCkC5DoJyMpoxT/dCRYtcpfYo5bUUPdlxoMNSX4O27cDjjkIYXH+Zp2bkYvShYy6EpM/urCZdKmvbbUsj4/5iBLqpu6wSJ9BxDTYbYdiA8NIJXZfAueaDSMp7HIQeU/rrqBTIbKQbbi4I6vLil0Jeqv0jWbSexeWmN4vKnzJSzluO09Y76LdJFZIc/x4HrCU6VAm9P/PnN2OCWGQkOG5gHnHEPMdzoWM4pCAI+aESL+JQKtUedvR4nVg+FeNqLHOkGNjO8nlyqm0FU3K2kVRWwxyGsD7PNDsGt5mV234CYfvQBKb0rXx8OFU6J6KKNErfjGx+eeNYw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ccbeda-63c8-41c7-9ed3-08dba95f5267
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:45:07.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDZWHyUHM+YqXpfIM3o2emGrMGqSbgKJgG6f6ff/0mrPZ/EGSF1vY/XgO1eQh357LROGXM47wfeTiiMRdYAdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300127
X-Proofpoint-ORIG-GUID: 7cOAZbLwQot4Y1xJnv9Pi_FcdF664-S_
X-Proofpoint-GUID: 7cOAZbLwQot4Y1xJnv9Pi_FcdF664-S_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:32:43AM -0400, Alexander Aring wrote:
> Hi,
> 
> On Fri, Aug 25, 2023 at 1:21 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Wed, Aug 23, 2023 at 05:33:46PM -0400, Alexander Aring wrote:
> > > This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
> > > on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
> > > export flag to signal that the "own ->lock" implementation supports
> > > async lock requests. The only main user is DLM that is used by GFS2 and
> > > OCFS2 filesystem. Those implement their own lock() implementation and
> > > return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> > > ("nfs: block notification on fs with its own ->lock") the DLM
> > > implementation were never updated. This patch should prepare for DLM
> > > to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> > > plock implementation regarding to it.
> > >
> > > Acked-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c       |  5 ++---
> > >  fs/nfsd/nfs4state.c      | 13 ++++++++++---
> > >  include/linux/exportfs.h |  8 ++++++++
> > >  3 files changed, 20 insertions(+), 6 deletions(-)
> >
> > I'm starting to look at these. Just so you know, it's too late for
> > inclusion in v6.6, but I think we can get these into shape for v6.7.
> >
> 
> ok. I base my work on [0], is this correct?

Correct.

Fyi, that is currently what is pending for v6.6. When the merge
window closes, it will jump to what will go into v6.7.


> > - The f_op->lock check is common to all the call sites, but it is
> >   not at all related to the export AFAICT. Can it be removed from
> >   this inline function?
> >
> 
> This flag implies it makes only sense if the filesystem has its own
> lock() implementation, if it doesn't have that I guess the core fs
> functions for local file locking are being used.
> I guess it can be removed, but it should not be used when there is no
> own ->lock() implementation, at least not now until somebody might
> update the fs core functionality for local file locking to handle
> blocking lock requests asynchronously.

Can that be handled with a remark in the documenting comment?


> [0] https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-next

-- 
Chuck Lever
