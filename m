Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54C703E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbjEOUPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbjEOUPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 16:15:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CE130DB;
        Mon, 15 May 2023 13:15:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsNFw031491;
        Mon, 15 May 2023 20:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ndO6aNfvwuWVJ8Oz3wzofRRnss23/DatF7DCkqpTO8s=;
 b=xu/ZuQ/pDQVFozQiq8RRgX1rCwgYuu+gDQdl3HTZ3cvVP6nxOKJDj4S2jjsPkkN8UJ+L
 RjbbcczzLFzRqEe7RBiYTyA4WKU6ZazAnsurIh7mi8puid+DMRFyCqtIFkfqm0g2jJOO
 anJoKs4AfB3ValA7hCWrCyi8xOB/5fDAETs6qQ0VlHbjd7gzlTCtLY+CbFx2/Zln5xsA
 uiGoH1bxZ7xs71P1y0/c2Qvegm1EmnwUSs6I1V5dYcLrlVMUb/cnKBTweEl3VShPVnAI
 K8XzdomjcPCTVGLqoNeu8uVliGNDO/lVyS0PWkzN9xYsTAeIz5eoIxIc8QuSxSy9pata Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj152165g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:15:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FIas2h022164;
        Mon, 15 May 2023 20:15:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109dqw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcOsWZN1HMEQuhi0qNPT7hbkfw8HHBbyUMqtrUp27JMMksUPIzkXLIFTqlyMMQjFl8eI0skr2AzQu6yE4VoHbsbdqrxYa3EQ6whEM2nK7HGqYorrz8kW6YEfXkESsF7m8DZaVfGcMPYuxYUtyC/UkW3drqEYSD4AJRu47GtTY1X0oMzBYb3YbV1lJXw4FEdfKiK4pPIPvStlTm3TAIHWvLZxxe9x5G6QZ3X840GCDdUmTQ35s+/ENyd6zFvBdUjbiN3wg4D0RCo5EQ/DJ5SrYGg7kZz7Bg/5ww30JYAY572vt5hBhfwXWNkxASlKVjuDA8XUYihKpFJ7uZ1D+/g1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndO6aNfvwuWVJ8Oz3wzofRRnss23/DatF7DCkqpTO8s=;
 b=d6fpnpJD/F8iZTW/Sh66hTwC5mjeqFGeg6D7VT1N5+UXFwBA//WehVrKGLlLSg1Z1kPbVZYMFa3B1FBRuGLI857ZVWLSW9fbV31eEdUqFXV5HULxcOgKjsIqmuK5Xj2Ek5G4AaAjsc1C98o+Snn1u2Rxfp4WcaBHfhn18Q89355uKJV7+ukOto+XNRtxRmlzl/jM25iQNXEHV6LBKQf8lv67kmQDL6dLQGm1R9Zlf+DfDD9M+HjtJxBrIS9APdK5RLnK/aicSVGWVqCkpExhQ6HDYluyYYlN2ZuRQUNMNR8CEXe1bD0JwcNEYYwCdA1QWF3JiiwlLufYRL955+ULOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndO6aNfvwuWVJ8Oz3wzofRRnss23/DatF7DCkqpTO8s=;
 b=KG+7tyZk/zI6C6RKX7fsoiwJy6Ki+5CRHAwkabkR5iDBfqCaLBYed5+rbVKDOFu6Q/aejxaR3OMvEAY7OoNGqpSVMREqBepvw7kxqelEWPBs/FbSEeiAYir0lGvqp4wjTeE8f3wSt4ap5FJBB5l79Y+CFzTArd5lIpjlAqTGQ/Y=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY8PR10MB7217.namprd10.prod.outlook.com (2603:10b6:930:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:15:11 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:15:11 +0000
Message-ID: <b9d95b8c-227b-0ec4-0a7c-22773574eb23@oracle.com>
Date:   Mon, 15 May 2023 13:15:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
 <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
 <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
 <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY8PR10MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 87900499-b010-4483-7787-08db558115ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3btXpR5X7iMWUCUjbrPXz6ROp0qZf1mMQz2YGAEd7AsWHhq5Xm0vmIJoQFW7dTf1CfVqSeSIZUctb9oBU4+EGkyu7aeY9bpTDAqo1AJ123w3Ge0mbjuXAM1LxkFKivHIoQZogtPsdlbwInjPEOLQXmdRTYzSLDifOZum6nyKdGlUljKb2jsqLJX0+fKVpiX7qCfYkLsmNxN0spf9VvP1hx5XyL5oGo24vpb2L7JqFfA23IWAAte6wEV6ZL4mEFY7MiAyK2+Lmuox4UJfLbM5getOYIi6pwwVZ//GQeXZkm9zvtXY2vynSR8TJnK2rmH7FhqaDZRE5H1wtZGVC5tSqFLHKoYLckoL+hUwxlGs6I3jB9jvD+9i+5BfqnMRPW1ovSs0uIR+OxbBE0XiIF28VRSqebNZOXhGSXYjV3UmRxkHLwSsuca7VE6mLfaCLILkwvtQzaQjA7PPCAUDizuj677C3T/TCCmCFmc5SzmNLIKRPsf8SnjbmaIk0VDQubBOllTidv2R38gujMxVZNjcn8gCTjNwLhsJ2H3JufyyHWP7ummjarJKogLvEtCReH/Lw7mIC2Ji9JwmDrfvQTWUrVnXP19mjJrS9PK46UZXyGU2vJW/ADR2npHsdgArVf4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(31686004)(83380400001)(4326008)(316002)(36756003)(41300700001)(38100700002)(6506007)(53546011)(6512007)(26005)(6486002)(478600001)(9686003)(66946007)(66476007)(66556008)(2616005)(86362001)(8676002)(31696002)(2906002)(8936002)(5660300002)(110136005)(30864003)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTc0WlVNSW5ObFI4eGV6Sms2T0gzYVk3MXdBQ29jczZXK0drVmVxU2VJQ0k1?=
 =?utf-8?B?dHk4Zmp0QVJmNG54TVBqdkp3UVNHNkZNNm0wUVRvcWo2TjdyTXlwUTdQRlQz?=
 =?utf-8?B?UTkrOTFLWDZmazBKdnN6QzNzVW4wQWVaakpwTFFGdEN3YjlYVjM1STdIYUFF?=
 =?utf-8?B?Y1VaakdmNUZMVUowNUZNRWhpVzVwdjlWeUZxQ1J5Q1laV0pQdkR4VVc4SFNk?=
 =?utf-8?B?S3JVTk15MTN3cWdPelJNeEl5Y0xNU2Y5TUxKNUlOdFNnN3BiRHUvQWErdnJq?=
 =?utf-8?B?dWJhTC9XMnhMSVhsV1I0djlPMUdleDBmQlpIQWk5M1JnY1R6Y3FESURhN3U3?=
 =?utf-8?B?NmlpeHF5L2QxR0w1ZTNNN0NvWHB0NUdVejBiTzkzdzd3N1o1OG1lZVRvN3Uz?=
 =?utf-8?B?MjNmU0JWN0w2KzY5SjdHa0RoK0NKZXpENGxoOGxpK0tqV1ZHUy8rVE1mdjY1?=
 =?utf-8?B?NG1BVklqTzdYdjBCbTNXa2ZhNUwwV0ZoSzdhM0NkQTBLL0RsMTBaT0NWbDRZ?=
 =?utf-8?B?YXZ6Sk8xZE9JWFdEN2YxTzU4ZHJCTjAzL2JJNEFQeWhjcmJUVVhXMXp3Zjlr?=
 =?utf-8?B?MU5DaENQY3pRcnNEZTR6Z0dNRm93b1VXVTdyZzdMME5qSEk4YnZwMzR5b204?=
 =?utf-8?B?RG5GanduUG5DRXZuSWdlaU55akNGZDI5cE9Ga05aT1FKcU5YaVBYaEc0WDRt?=
 =?utf-8?B?anltNzV2UmxvZXA1UGFjYnFZZ21Cb3h0V3Z6WmZBcjJQWHJBc2NGMHJwaXM1?=
 =?utf-8?B?VFpVem1kWkxETFdsSEFSODZxMDBRekRmVEFWUXpmNE1acm1pOFR2Z2M2aVdv?=
 =?utf-8?B?YjNaaURWYzVMNzJqcndudnk0TkEzLzdBUXJ6OTFXa2NYUTIwY202c1VxdERz?=
 =?utf-8?B?K2lSUGw0QzN3dFhoTkY2YXRjM0o5Wm44Rkw0aFdYKzkwQnBqVmN4cVVKL0Zt?=
 =?utf-8?B?V1czazZiUng3YkV5anczQ0pCSnhLNkttN1ZiOW05aWdrbTNDNlpkc1cyMHlT?=
 =?utf-8?B?SE1BT0hyRmpkOU5VcHVKVjNmWkVVbEQ1T0dXVi81T1BUcDdDcUdmT05OVG5s?=
 =?utf-8?B?UllwdVNhR0hxTCtVSGQ4RHN6UFhnS2FCQ2kzaWl6U2lqUG1FM0ZncXpCSmFz?=
 =?utf-8?B?aTQ2SDZMa3BhZzBTWFdnU0g1em9PL0pXOG5mWHBhRkNGREZJN2dROEFPbTFQ?=
 =?utf-8?B?YW9jRk5jUkFwaTZpMGZBRnFVdURDMk52a1dHOXM0WjFtaU40QklkMDloSlAr?=
 =?utf-8?B?UC9RRCtwY0l0YkZ4NExsYVFWNDAyWk9SOEV3ZzVWUjd4K3hMbEk2Mk9ZMEZm?=
 =?utf-8?B?dUxieWI0WU1MTVZyODEzTG9nOW1iVUdPeGoyVDM4VHJaaldodks4WWkzRTUy?=
 =?utf-8?B?MHprSWlsLzBBUllXTVN3cjMxSXhmdlp3MHVoME1taU1sdUluWXBNUmFWWmRF?=
 =?utf-8?B?RkV1QW4rdkRsL2dYWjlucE4wV0YwWS9jTjNwdnJhdjR0bVhPTlJJSDNIM0xN?=
 =?utf-8?B?czd5U2pFSnFyVEtUbGN6M2xHN1ptczQ0VlpHOGc1RGNEclJpbzloVjhDWG80?=
 =?utf-8?B?bUhzT0FjcXRPMkxaaXB5b0RzZEo1Y2JBVDQwSll4RFhJbzAzMHRBWGRYK0Rq?=
 =?utf-8?B?SXUvYWdLZVZNazREVzJWWkNVS3hYNlk5Z1NtWGFnVDQwQU9EQVFESjJoc3ZX?=
 =?utf-8?B?MXhuVjFsUW9XTU5ramxoNXkwVjFVaVllVXd1NUVpbzBMRGZOMmN4clJ0NEZO?=
 =?utf-8?B?VCtlekNyS2FuVDBsREt2aHI5TWdRbmRKcTZNd2dvejJ3djlEZFBFMVdRY0Yz?=
 =?utf-8?B?dFNnRStIN1lHbTRLUlVjOUg0ekx0N2tnZkJNOW1PeFRiTmN6RlFlaWJyODQ0?=
 =?utf-8?B?YTJ4akloUU1XQUMrVnVDeGJUZ0NJR0J0aHVTMDFEZ25uYy8xOVdHejI2NGpF?=
 =?utf-8?B?SlFvdXp6VStmaHdIcHl6dGRzWXdiNGhFV24zcmJjRnRsVmdqeGdJOHJPdFVB?=
 =?utf-8?B?WHBDWFduNEI4TjNPMkZsbWVZN2ptdWpZbnNpSlVLSkZ5bFh6aSsrc2hINWQx?=
 =?utf-8?B?cnZNRlNuMUZkNEpjbmZ2dHY1eWZGVUUreG5pdzRhVlNvYjVHRWJCSS9nc2Fi?=
 =?utf-8?Q?v0M4QcKRjKMAeWqiUZ6+tm0NT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UqAT+y1lUP0i0TSll1M+/jlDlgysXJE39IT3Mz2vhsQegpll8KOfk8FP0/eYv3rNQ0r7d8kH/uhntx1ctJvE2aomecdhAZFCA3RbojSdFSEwi7UmUeYiNJGH6GQTzjxfYE6EiDDeaeUPmegR0lv7Zkg1gobdsJIQTYlkr+c4CBrId3xAltl1ZyVZqQpLKcajBo+36DcHFqw8bkXm/TAcylxfOImqmA+vnrBcKDsm47JOfqcSieqqd+hUR5Ld0fZeaJ9OJWKbgfefaHbEotQGamaLUXlG0U5nkomqrSGrL/Zo5UPNoBjQcNR/azk0xtMJC/IBRmPaepC3NakfwRLHn1lKTvJ1R8NgGBsojSGn6Q5lnx6JL8HyXMegGzZ+H1N3e3DyGreEOsJ53y9DJ3OchLpWtj05Z5AIkYDZsBl6kkbtZPGGeTmJbwT0a4w64iPEGeEXrBYrf/GrHXGEta1pdL/x1fhu6EzFlmwsNBB0gYX9Qq+342KMJOgGNDf3YCP82TOzU1Xkh2WzvsE2pYGpi7S3YpCdaoQYkUIjH/QqXb00CFKwnKHXcLmIBppj5YYS1OHQKOmNFYb+u1zpI7MgqVa6aZNhDBWfoGFfiJQHRT5ESOKjZ9dLzQ0aVOQgMrOCeWgngSyRtGbwJtenzAYgJN+ibR4qzyexACNTIWb8OPtwFk2WaNtO9rUkzXql+7KmzsnneRYdcotI1rzgrMBaR0wo4VL9v5z6RybjRbC/aQJYOH9UfC4b5X5DCoYIz4heDAT5JweBEPRSqQ5dLk4vnD1OPKh3Kc3l7fj+tO/635jF61OwmMgDU4eDmQCgsyLN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87900499-b010-4483-7787-08db558115ca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:15:10.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgmvMgaZE8II5JoJfIUBYu7Qs8M8Fjhpqc9PwIUaA6PlRxL64Zqjf+pgyzx/SL1I2GFKeVVSbsE9yEpl741MTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150167
X-Proofpoint-GUID: -9aY8wkekMK2yoKsL8yiAO2FxUTs7tBx
X-Proofpoint-ORIG-GUID: -9aY8wkekMK2yoKsL8yiAO2FxUTs7tBx
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/15/23 11:58 AM, Jeff Layton wrote:
> On Mon, 2023-05-15 at 11:26 -0700, dai.ngo@oracle.com wrote:
>> On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
>>> On Sun, May 14, 2023 at 8:56 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>> If the GETATTR request on a file that has write delegation in effect
>>>> and the request attributes include the change info and size attribute
>>>> then the request is handled as below:
>>>>
>>>> Server sends CB_GETATTR to client to get the latest change info and file
>>>> size. If these values are the same as the server's cached values then
>>>> the GETATTR proceeds as normal.
>>>>
>>>> If either the change info or file size is different from the server's
>>>> cached values, or the file was already marked as modified, then:
>>>>
>>>>      . update time_modify and time_metadata into file's metadata
>>>>        with current time
>>>>
>>>>      . encode GETATTR as normal except the file size is encoded with
>>>>        the value returned from CB_GETATTR
>>>>
>>>>      . mark the file as modified
>>>>
>>>> If the CB_GETATTR fails for any reasons, the delegation is recalled
>>>> and NFS4ERR_DELAY is returned for the GETATTR.
>>> Hi Dai,
>>>
>>> I'm curious what does the server gain by implementing handling of
>>> GETATTR with delegations? As far as I can tell it is not strictly
>>> required by the RFC(s). When the file is being written any attempt at
>>> querying its attribute is immediately stale.
>> Yes, you're right that handling of GETATTR with delegations is not
>> required by the spec. The only benefit I see is that the server
>> provides a more accurate state of the file as whether the file has
>> been changed/updated since the client's last GETATTR. This allows
>> the app on the client to take appropriate action (whatever that
>> might be) when sharing files among multiple clients.
>>
>
>
>  From RFC 8881 10.4.3:
>
> "It should be noted that the server is under no obligation to use
> CB_GETATTR, and therefore the server MAY simply recall the delegation to
> avoid its use."
>
> As I see it, the main benefit is that you avoid having to recall a write
> delegation when someone does a drive-by stat() on the file (e.g. due to
> a "ls -l" in its parent directory).

Yes, that's right I forgot to mention this. If we don't want to recall the
write delegation then we have to support CB_GETATTR.

Thanks,
-Dai

>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++
>>>>    fs/nfsd/nfs4xdr.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    fs/nfsd/state.h     |  7 +++++
>>>>    3 files changed, 148 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 09a9e16407f9..fb305b28a090 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>>>>
>>>>    static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>>>    static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>>>
>>>>    static struct workqueue_struct *laundry_wq;
>>>>
>>>> @@ -1175,6 +1176,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>>>           dp->dl_recalled = false;
>>>>           nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>>>                         &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
>>>> +       nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
>>>> +                       &nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
>>>> +       dp->dl_cb_fattr.ncf_file_modified = false;
>>>> +       dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>>>>           get_nfs4_file(fp);
>>>>           dp->dl_stid.sc_file = fp;
>>>>           return dp;
>>>> @@ -2882,11 +2887,49 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>>>           spin_unlock(&nn->client_lock);
>>>>    }
>>>>
>>>> +static int
>>>> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
>>>> +{
>>>> +       struct nfs4_cb_fattr *ncf =
>>>> +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>>>> +
>>>> +       ncf->ncf_cb_status = task->tk_status;
>>>> +       switch (task->tk_status) {
>>>> +       case -NFS4ERR_DELAY:
>>>> +               rpc_delay(task, 2 * HZ);
>>>> +               return 0;
>>>> +       default:
>>>> +               return 1;
>>>> +       }
>>>> +}
>>>> +
>>>> +static void
>>>> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
>>>> +{
>>>> +       struct nfs4_cb_fattr *ncf =
>>>> +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>>>> +
>>>> +       clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>>>> +       wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>>>> +}
>>>> +
>>>>    static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>>>           .done           = nfsd4_cb_recall_any_done,
>>>>           .release        = nfsd4_cb_recall_any_release,
>>>>    };
>>>>
>>>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
>>>> +       .done           = nfsd4_cb_getattr_done,
>>>> +       .release        = nfsd4_cb_getattr_release,
>>>> +};
>>>> +
>>>> +void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>>>> +{
>>>> +       if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>>>> +               return;
>>>> +       nfsd4_run_cb(&ncf->ncf_getattr);
>>>> +}
>>>> +
>>>>    static struct nfs4_client *create_client(struct xdr_netobj name,
>>>>                   struct svc_rqst *rqstp, nfs4_verifier *verf)
>>>>    {
>>>> @@ -5591,6 +5634,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>           int cb_up;
>>>>           int status = 0;
>>>>           u32 wdeleg = false;
>>>> +       struct kstat stat;
>>>> +       struct path path;
>>>>
>>>>           cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>>>           open->op_recall = 0;
>>>> @@ -5626,6 +5671,19 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>           wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>>>>           open->op_delegate_type = wdeleg ?
>>>>                           NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>>>> +       if (wdeleg) {
>>>> +               path.mnt = currentfh->fh_export->ex_path.mnt;
>>>> +               path.dentry = currentfh->fh_dentry;
>>>> +               if (vfs_getattr(&path, &stat, STATX_BASIC_STATS,
>>>> +                                               AT_STATX_SYNC_AS_STAT)) {
>>>> +                       nfs4_put_stid(&dp->dl_stid);
>>>> +                       destroy_delegation(dp);
>>>> +                       goto out_no_deleg;
>>>> +               }
>>>> +               dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>>> +               dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat,
>>>> +                                                       d_inode(currentfh->fh_dentry));
>>>> +       }
>>>>           nfs4_put_stid(&dp->dl_stid);
>>>>           return;
>>>>    out_no_deleg:
>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>> index 76db2fe29624..5d7e11db8ccf 100644
>>>> --- a/fs/nfsd/nfs4xdr.c
>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>> @@ -2920,6 +2920,77 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
>>>>           return nfserr_resource;
>>>>    }
>>>>
>>>> +static struct file_lock *
>>>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>>>> +{
>>>> +       struct file_lock_context *ctx;
>>>> +       struct file_lock *fl;
>>>> +
>>>> +       ctx = locks_inode_context(inode);
>>>> +       if (!ctx)
>>>> +               return NULL;
>>>> +       spin_lock(&ctx->flc_lock);
>>>> +       list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>>>> +               if (fl->fl_type == F_WRLCK) {
>>>> +                       spin_unlock(&ctx->flc_lock);
>>>> +                       return fl;
>>>> +               }
>>>> +       }
>>>> +       spin_unlock(&ctx->flc_lock);
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +static __be32
>>>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>> +                       bool *modified, u64 *size)
>>>> +{
>>>> +       __be32 status;
>>>> +       struct file_lock *fl;
>>>> +       struct nfs4_delegation *dp;
>>>> +       struct nfs4_cb_fattr *ncf;
>>>> +       struct iattr attrs;
>>>> +
>>>> +       *modified = false;
>>>> +       fl = nfs4_wrdeleg_filelock(rqstp, inode);
>>>> +       if (!fl)
>>>> +               return 0;
>>>> +       dp = fl->fl_owner;
>>>> +       ncf = &dp->dl_cb_fattr;
>>>> +       if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>>>> +               return 0;
>>>> +
>>>> +       refcount_inc(&dp->dl_stid.sc_count);
>>>> +       nfs4_cb_getattr(&dp->dl_cb_fattr);
>>>> +       wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>>> +       if (ncf->ncf_cb_status) {
>>>> +               status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>>> +               nfs4_put_stid(&dp->dl_stid);
>>>> +               return status;
>>>> +       }
>>>> +       ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
>>>> +       if (!ncf->ncf_file_modified &&
>>>> +                       (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
>>>> +                       ncf->ncf_cur_fsize != ncf->ncf_cb_fsize)) {
>>>> +               ncf->ncf_file_modified = true;
>>>> +       }
>>>> +
>>>> +       if (ncf->ncf_file_modified) {
>>>> +               /*
>>>> +                * The server would not update the file's metadata
>>>> +                * with the client's modified size.
>>>> +                * nfsd4 change attribute is constructed from ctime.
>>>> +                */
>>>> +               attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
>>>> +               attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
>>>> +               setattr_copy(&nop_mnt_idmap, inode, &attrs);
>>>> +               mark_inode_dirty(inode);
>>>> +               *size = ncf->ncf_cur_fsize;
>>>> +               *modified = true;
>>>> +       }
>>>> +       nfs4_put_stid(&dp->dl_stid);
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    /*
>>>>     * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
>>>>     * ourselves.
>>>> @@ -2957,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>>>                   .dentry = dentry,
>>>>           };
>>>>           struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>> +       bool file_modified;
>>>> +       u64 size = 0;
>>>>
>>>>           BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
>>>>           BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
>>>> @@ -2966,6 +3039,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>>>                   if (status)
>>>>                           goto out;
>>>>           }
>>>> +       if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>>>> +               status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry),
>>>> +                                               &file_modified, &size);
>>>> +               if (status)
>>>> +                       goto out;
>>>> +       }
>>>>
>>>>           err = vfs_getattr(&path, &stat,
>>>>                             STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>>>> @@ -3089,7 +3168,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>>>                   p = xdr_reserve_space(xdr, 8);
>>>>                   if (!p)
>>>>                           goto out_resource;
>>>> -               p = xdr_encode_hyper(p, stat.size);
>>>> +               if (file_modified)
>>>> +                       p = xdr_encode_hyper(p, size);
>>>> +               else
>>>> +                       p = xdr_encode_hyper(p, stat.size);
>>>>           }
>>>>           if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
>>>>                   p = xdr_reserve_space(xdr, 4);
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 9fb69ed8ae80..b20b65fe89b4 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -121,6 +121,10 @@ struct nfs4_cb_fattr {
>>>>           struct nfsd4_callback ncf_getattr;
>>>>           u32 ncf_cb_status;
>>>>           u32 ncf_cb_bmap[1];
>>>> +       unsigned long ncf_cb_flags;
>>>> +       bool ncf_file_modified;
>>>> +       u64 ncf_initial_cinfo;
>>>> +       u64 ncf_cur_fsize;
>>>>
>>>>           /* from CB_GETATTR reply */
>>>>           u64 ncf_cb_change;
>>>> @@ -744,6 +748,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>>>    extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>>>    extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>>>
>>>> +/* CB_GETTTAR */
>>>> +extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
>>>> +
>>>>    static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>>    {
>>>>           cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>>> --
>>>> 2.9.5
>>>>
