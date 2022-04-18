Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001B0504A65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiDRBUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiDRBUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:20:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9113E25;
        Sun, 17 Apr 2022 18:18:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23I0gdem009092;
        Mon, 18 Apr 2022 01:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ymeOZB0c4T67SayVeYEQHgI5cc+39g5UFnQ98z1OA50=;
 b=yV/+VHVNQkbkpNNnsfav5c495a1T7/hzFS3aG8w5BYj9fZHI4pd8itiSIjad2r8KPRnx
 sKtunQpcTkK77Ok9iOYx2wFxcF+meifkrgNE5EB92unAjMr43nR4Wsbjrw2NWvCXMal2
 RLUSoq6/QYxX6gg/zogKNkeHhn+2/TA+d3yHmGnUdRAeYQwF8UeOSpMqIVm1CIjfDI/H
 4W0bXgcCqLB+QwblSHPj4z0xS7rBIRDUHZEoqX+fTh8TR4e5FJ1Ya1BIKQwtp2PWdOi4
 fWgOJ0k4bONrT7jtlhLSG/mGb8vc0juY71FWRcI+zmcVB9oJL9rTnS8bKLVyD4YpJkIE bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2j6e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 01:18:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23I1BkPY021008;
        Mon, 18 Apr 2022 01:18:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8741u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 01:18:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjhapu8LciR/bZ6AHM8++z8981F6NOwqYkOXZ/ehTDJvem/Krg3xAcHrP6HTxrH0BRqg1Ap1k2r4aK8YwoMB3WrgdByK+XAXvKs1dtFlL7W0Cv0/43QyIQW5sBxMpSNj+5DgzeA38AK2z1SqG4NXZTXVTd0JLl2V6BJ1cvYBLkvO5yV4gegFHA3Evmq41UyF4jRuMYyMjEWMvhU8cgpbzLxwonbw5yRJU8jV9gS5IQrgAdbrcjAxzjASQLasi+WcRdKkvUEb7P+hBD3/Wpm+3zHIdx/yT66WlY7AxBpk/ftneSdYDLyx2TSTneokJoZKDMJVzsL0Z22n3mOYxCwz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymeOZB0c4T67SayVeYEQHgI5cc+39g5UFnQ98z1OA50=;
 b=eaOCVbYzvFBu5RKN9GV3DEZkA0wItlP1lB40yl/kYpY9xX8PZsLYOpkMOv9bE3E7ZP5Pn7xIdvp9Z586NcCfOvvQ0CndeAUEWdJZUeO65DwuF7cNB7HRF5GmMqEjd1AvpVjYsZ8kdXyf+VzSTNfPA2LxaSPfHGyOcc3rCBcpITyMj6cRUxCN6JQuBUqy4M3DpY9XZawv8PCK/C5KY+/5egevM70/bH5kpnTTpxf2JcpIOyH/H75JPE8UJYx8ml6tWMDmBQONkAB8S58H4CZyhse4ux5PjWsynjx3qN/M6OcKZbb6a43y2nqZVtpXRYfv5eYzdL9poTMG2wLWpWoi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymeOZB0c4T67SayVeYEQHgI5cc+39g5UFnQ98z1OA50=;
 b=T25SukEC6t5i8QNmOgFAQzc+GRXjYKc1b4dEf41QLMcp/W9VjDfFpr5HKdAZs2Q31NpdXU7j9pN0rIjv8vL2BUZ9JYyEEuf+xsoqFlwjsletJ1X6Qjjy+z3Y8QPUdOnUWG4oAPeWEOiH6l4kLUXE1MBYe4HlwnsgPuzxWDqnSbk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR1001MB2110.namprd10.prod.outlook.com (2603:10b6:301:35::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 01:18:08 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::52b:f017:38d1:fd14%2]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:18:08 +0000
Message-ID: <34e69305-f11c-2a42-4903-14b1acc5ab41@oracle.com>
Date:   Sun, 17 Apr 2022 18:18:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org> <20220417190727.GA18120@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220417190727.GA18120@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:806:23::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e392465-fd25-45ab-7f51-08da20d94c04
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2110:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2110897F2649F7EA2C2836C187F39@MWHPR1001MB2110.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhQUKVqa5d7ANAqpnRUhPVuW6/MFo6UDN5jz0IEFElCSPJufp4E+U0D2HDBB+kPCIylcOJA72zuTsiijPJtyW7gMK+Bf6h+bEYZ4QVnlZIHy9uhgugm0cvfZsJO3ckIDz/GLgZd6hhDxjAZ2epRNY+/bww2FSFR4NnUJfgNG7FpZYzraCKUvyEQ6K41AwEmDi3MVqur5/gWf9p2GYkwcgbnwoepHA7cAYVyc8atnqIn3Gc/F//U3jqXGJC8kKPkLDxBgZNrO5KBeVFyVDhLJdnEvbg9bQhsGMGVT6fcnkjBRwEsQZpNs5wVMMARZeY1dFHDsr0EB92dma7CNQORehSAQBVeeCHuk/hQyQrzR685MC55X7sdSd070OYbBBtGSS+QH6qvAAz6CvK4vYigfCxaQuDVOyLP/A65UYikEvM5aW/FLv+r7Q/jfepBDXscipx5pXaAt07nu8nhqdD8r8k2ET+h4C2tWHEtlxWjn+41wM1xzkGMFd/sjuTpXVX4SzK89sfzH2FzN/V2K6/yLfCy8KquPqbbMUH17y4X7/6ffcsAwdmdaU8rxwdWS3JG/Rs+pYeTepjj+5b1fv+wynA0hKbNFZq8G9clGvf2xE6dnsmUCN5JDgONwIaaaVgkJVY2sOVYp17mnrOpcGIoKyVj/ZQkANMdLSr+WQSG9x/PScBoTUBqLOJZSdwx6C9rH7rYv/sFqBMjMswQKBpIDJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(2906002)(8936002)(2616005)(6486002)(83380400001)(54906003)(6916009)(38100700002)(186003)(31686004)(26005)(36756003)(6512007)(5660300002)(86362001)(508600001)(15650500001)(31696002)(9686003)(4326008)(8676002)(6506007)(66556008)(66476007)(66946007)(316002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXhGb1ovSEc5b3gwKzFaWWJCNmhnMEFXREdBbGJnOERORDdkcU1uRlpsUEhr?=
 =?utf-8?B?dHpMMW9IUjVTZ2tzSFM2bmFrNFNPdGRaM2Z3SDJJck9OOXczZ2YrYjlVVnFx?=
 =?utf-8?B?R3IxOUM4RjIxSU42ZU8rUTRFV0syMmFZeDcrNzJ3Qk14UEd1RE5XcmZLa25n?=
 =?utf-8?B?OFlJdG9nZFc3OGRGalluQklWeXN2cTlkTkJjb0dKUFVSM0drSHJaaGVnQXJh?=
 =?utf-8?B?czNaZW10bmN4RTZkWUppR3hyMGp6d2NiOEdHVytHaEVja0hYazFHbnM1bFJh?=
 =?utf-8?B?OXZsMXNCM0xzdFBITFo3WWdNWnducVllc1EzRW0xVlBPR1NHWlZVVWhBcHVB?=
 =?utf-8?B?amNDdmZScjBKMFc5Y05GUXNiTGlTRSs3bUpaSnl0d20wdHh3aFgyOHdLTTlH?=
 =?utf-8?B?bE1taEpSSXJmZnBiSWdxRWdXb25hRzFCdlF5aUxIbk9IMXZNL0dUTnlTMzMz?=
 =?utf-8?B?TEhXL1JEOUJoMWxYZzJub2JtL2x3emVtL2FHTVhhZGV3VUZabEVEa2RFU1JJ?=
 =?utf-8?B?azZuRjRqN0VpeWhDdjVHYktTblN1YXJkMUpOa283UTZwVlBpakpGZDhhQ1VK?=
 =?utf-8?B?aHExVklJYUdXMmJocWNFSCs0OXA1SUFoNk1RTEp4c294dHMybmcySFRoTUJE?=
 =?utf-8?B?Zlo3dmxndS9aWGc0QU5QVWRTR2JzK01QUXd0Sk1FVjZVN1gxMzg1OEw4ekdP?=
 =?utf-8?B?WjhNZTM3c3V5c1JyL0tLa1hBN0pyRlg0aFlYZk1EcmVuN01xMmFlb0ZJUkd0?=
 =?utf-8?B?Z2dvQkcrVXk4SUg2ZEt1ZUpjYXlVd1FuM1lNU0orejNvVTFuYW9aK3ZIcWJm?=
 =?utf-8?B?M0c4VGx5eVp6V1g2dWd6YUtGV0FWQmpuaVNXMHFDVHk2TExTbjFVOEdaUUxy?=
 =?utf-8?B?V1k3enVWcnVZcEZPZGNnVDBUcHVnT2w2NVF4VUkzTlVhKzh6T29CeFQ1R1VD?=
 =?utf-8?B?VjRnbEo0ODJ4STNHNHc0TVZpZkh0MWFOdUoyVTYwVkdxUDVyRWhqN011cFAy?=
 =?utf-8?B?YUxQT1JlKzE2RmxSVzhkUnE1VjVpbG00ZDRXSHZVL0tVVzNJaVpRdlF3dGRE?=
 =?utf-8?B?am01Q1hLZDhjbDdERlRiclptdjg1d1hieHZBUXh6UlN2R2RtVjNwWDNKRFNM?=
 =?utf-8?B?ZENmSDR0YW5pTTZBWkZPL0k5TjVLM1lnME80M2M0U3F0MEhHZE5UZzVkcUVC?=
 =?utf-8?B?Tk02TGNQdE8xTFBNL2tsK0ZKQVdVRmFWSTQwTHRGN1N3dHlOcTdsTXNidzlt?=
 =?utf-8?B?NHRTSG5SUHdTeE1NT0h6d0pBVVk2NHpkdi9BQ1hrYlIyMGovTmRtb0tOcjl3?=
 =?utf-8?B?Ry9xOFU5M1FvOGZ6K08wbDhlUStjZEYrZ1EvSi9pMGFDYTdrOGdzM3ZQQXBB?=
 =?utf-8?B?RWlDTEtoYmhpalNHd2k3eStHSlFJbUpGTXp1K0VJbzhUR0xydy8yRTF4YU84?=
 =?utf-8?B?bkhna0R3RXpZWFg1NlQ5L1hiOE9wR1dKRnUyVEdUdDVzRTl2bFF2OVVUSzh4?=
 =?utf-8?B?a3NoTWtaTU1HK283TzQzUEVUVGZwWkh5U203N05BWWJNbTRyQzRTUUxpaElu?=
 =?utf-8?B?cFZBWk1tNlk5d0VyeVlnNjZPZitZT0NYTkNwRTJYZ3N6T1lxUElUdG0yVkR6?=
 =?utf-8?B?Y25vYzFobWhkSERLSjVYdFdZS0cwVlBjYTk5cG9KY2t0cVVMOGhoWWh4V1hj?=
 =?utf-8?B?OWJ6QXBnU1dITFNET3ZWUnJzYWNpcnFjak1VdDN2L3pmM2hWZlVUWjJ3YnFl?=
 =?utf-8?B?WDgxU2wxdER2QXI0VVNnMXpkdXl5eUhvTzVMZXdqT2xlZENXb1R5dkkvaFlF?=
 =?utf-8?B?Q0dLcUcvT2psa3hxZHo3ZmkxTGRFQW5kQUkrWFk2cmVhSEJudXhvaStQaE81?=
 =?utf-8?B?VlNLQldLY1ZLQ2VqbVRQTHRxcitiQjNaZTg2N29xNkNvdlJBUXRjZ0FRT1F2?=
 =?utf-8?B?NDArNlBFNFAyWFFEaGI2VWdIMTZlYUJnbFVzbEJVYVhaL0o2a2NCQkFieElJ?=
 =?utf-8?B?MTNvdXNhM0poRlEzQUlLNXM1RFFDNnpSK0RXWW1zQUNqd0dpeFBkWSs4ZDZU?=
 =?utf-8?B?V0RmRTdDVm5PRVQ4eWZNM3N3YVB0eE0rNWZZazJuNnh6dUpJWVlPKzllTEtj?=
 =?utf-8?B?NlFyMjE0Q2NJNExWeWw3aWlYQWU2OFp2QzkvUHdaTTQ2TVFFc3QwdVVEREp6?=
 =?utf-8?B?aDFzNzlLbC9DbTZyUkljazNjejRXTnQvMVVnUmVEQlUwMmViMm1mNFJDUVlt?=
 =?utf-8?B?Q0dNNGk2WFlCNEdNbUU1UDc0dE4rUWdhSGhFZ1llbzB4V0ZlbU5JM3JjNEkz?=
 =?utf-8?B?RlJvSDBGdmQzd3JTck93SWNMQ1pnMEwvU2cyK1BKbW4rSE9KU2dQUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e392465-fd25-45ab-7f51-08da20d94c04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 01:18:08.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpUgKcc95gVbQuFY6YsJ1crJ8rEWzxGXEDC04+HabQ91UUqx+HSy1rQfhM7CLWXzRROifC04BWbNj/cftEx+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2110
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-17_09:2022-04-15,2022-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204180006
X-Proofpoint-GUID: EMF69LQPjIWgnBPlcN3tubvarjLy0YAn
X-Proofpoint-ORIG-GUID: EMF69LQPjIWgnBPlcN3tubvarjLy0YAn
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/17/22 12:07 PM, Bruce Fields wrote:
> On Wed, Apr 13, 2022 at 08:55:50AM -0400, Bruce Fields wrote:
>> On Fri, Apr 01, 2022 at 12:11:34PM -0700, dai.ngo@oracle.com wrote:
>>> On 4/1/22 8:57 AM, Chuck Lever III wrote:
>>>>> (And to be honest I'd still prefer the original approach where we expire
>>>>> clients from the posix locking code and then retry.  It handles an
>>>>> additional case (the one where reboot happens after a long network
>>>>> partition), and I don't think it requires adding these new client
>>>>> states....)
>>>> The locking of the earlier approach was unworkable.
>>>>
>>>> But, I'm happy to consider that again if you can come up with a way
>>>> of handling it properly and simply.
>>> I will wait for feedback from Bruce before sending v20 with the
>>> above change.
>> OK, I'd like to tweak the design in that direction.
>>
>> I'd like to handle the case where the network goes down for a while, and
>> the server gets power-cycled before the network comes back up.  I think
>> that could easily happen.  There's no reason clients couldn't reclaim
>> all their state in that case.  We should let them.
>>
>> To handle that case, we have to delay removing the client's stable
>> storage record until there's a lock conflict.  That means code that
>> checks for conflicts must be able to sleep.
>>
>> In each case (opens, locks, delegations), conflicts are first detected
>> while holding a spinlock.  So we need to unlock before waiting, and then
>> retry if necessary.
>>
>> We decided instead to remove the stable-storage record when first
>> converting a client to a courtesy client--then we can handle a conflict
>> by just setting a flag on the client that indicates it should no longer
>> be used, no need to drop any locks.
>>
>> That leaves the client in a state where it's still on a bunch of global
>> data structures, but has to be treated as if it no longer exists.  That
>> turns out to require more special handling than expected.  You've shown
>> admirable persistance in handling those cases, but I'm still not
>> completely convinced this is correct.
>>
>> We could avoid that complication, and also solve the
>> server-reboot-during-network-partition problem, if we went back to the
>> first plan and allowed ourselves to sleep at the time we detect a
>> conflict.  I don't think it's that complicated.
>>
>> We end up using a lot of the same logic regardless, so don't throw away
>> the existing patches.
>>
>> My basic plan is:
>>
>> Keep the client state, but with only three values: ACTIVE, COURTESY, and
>> EXPIRABLE.
>>
>> ACTIVE is the initial state, which we return to whenever we renew.  The
>> laundromat sets COURTESY whenever a client isn't renewed for a lease
>> period.  When we run into a conflict with a lock held by a client, we
>> call
>>
>>    static bool try_to_expire_client(struct nfs4_client *clp)
>>    {
>> 	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>>    }
>>
>> If it returns true, that tells us the client was a courtesy client.  We
>> then call queue_work(laundry_wq, &nn->laundromat_work) to tell the
>> laundromat to actually expire the client.  Then if needed we can drop
>> locks, wait for the laundromat to do the work with
>> flush_workqueue(laundry_wq), and retry.
>>
>> All the EXPIRABLE state does is tell the laundromat to expire this
>> client.  It does *not* prevent the client from being renewed and
>> acquiring new locks--if that happens before the laundromat gets to the
>> client, that's fine, we let it return to ACTIVE state and if someone
>> retries the conflicing lock they'll just get a denial.
>>
>> Here's a suggested a rough patch ordering.  If you want to go above and
>> beyond, I also suggest some tests that should pass after each step:
>>
>>
>> PATCH 1
>> -------
>>
>> Implement courtesy behavior *only* for clients that have
>> delegations, but no actual opens or locks:
>>
>> Define new cl_state field with values ACTIVE, COURTESY, and EXPIRABLE.
>> Set to ACTIVE on renewal.  Modify the laundromat so that instead of
>> expiring any client that's too old, it first checks if a client has
>> state consisting only of unconflicted delegations, and, if so, it sets
>> COURTESY.
>>
>> Define try_to_expire_client as above.  In nfsd_break_deleg_cb, call
>> try_to_expire_client and queue_work.  (But also continue scheduling the
>> recall as we do in the current code, there's no harm to that.)
>>
>> Modify the laundromat to try to expire old clients with EXPIRED set.
>>
>> TESTS:
>> 	- Establish a client, open a file, get a delegation, close the
>> 	  file, wait 2 lease periods, verify that you can still use the
>> 	  delegation.
>> 	- Establish a client, open a file, get a delegation, close the
>> 	  file, wait 2 lease periods, establish a second client, request
>> 	  a conflicting open, verify that the open succeeds and that the
>> 	  first client is no longer able to use its delegation.
>>
>>
>> PATCH 2
>> -------
>>
>> Extend courtesy client behavior to clients that have opens or
>> delegations, but no locks:
>>
>> Modify the laundromat to set COURTESY on old clients with state
>> consisting only of opens or unconflicted delegations.
>>
>> Add in nfs4_resolve_deny_conflicts_locked and friends as in your patch
>> "Update nfs4_get_vfs_file()...", but in the case of a conflict, call
>> try_to_expire_client and queue_work(), then modify e.g.
>> nfs4_get_vfs_file to flush_workqueue() and then retry after unlocking
>> fi_lock.
>>
>> TESTS:
>> 	- establish a client, open a file, wait 2 lease periods, verify
>> 	  that you can still use the open stateid.
>> 	- establish a client, open a file, wait 2 lease periods,
>> 	  establish a second client, request an open with a share mode
>> 	  conflicting with the first open, verify that the open succeeds
>> 	  and that first client is no longer able to use its open.
>>
>> PATCH 3
>> -------
>>
>> Minor tweak to prevent the laundromat from being freed out from
>> under a thread processing a conflicting lock:
>>
>> Create and destroy the laundromat workqueue in init_nfsd/exit_nfsd
>> instead of where it's done currently.
>>
>> (That makes the laundromat's lifetime longer than strictly necessary.
>> We could do better with a little more work; I think this is OK for now.)
>>
>> TESTS:
>> 	- just rerun any regression tests; this patch shouldn't change
>> 	  behavior.
>>
>> PATCH 4
>> -------
>>
>> Extend courtesy client behavior to any client with state, including
>> locks:
>>
>> Modify the laundromat to set COURTESY on any old client with state.
>>
>> Add two new lock manager callbacks:
>>
>> 	void * (*lm_lock_expirable)(struct file_lock *);
>> 	bool (*lm_expire_lock)(void *);
>>
>> If lm_lock_expirable() is called and returns non-NULL, posix_lock_inode
>> should drop flc_lock, call lm_expire_lock() with the value returned from
>> lm_lock_expirable, and then restart the loop over flc_posix from the
>> beginning.
>>
>> For now, nfsd's lm_lock_expirable will basically just be
>>
>> 	if (try_to_expire_client()) {
>> 		queue_work()
>> 		return get_net();
> Correction: I forgot that the laundromat is global, not per-net.  So, we
> can skip the put_net/get_net.  Also, lm_lock_expirable can just return
> bool instead of void *, and lm_expire_lock needs no arguments.

okay.

-Dai

>
> --b.
>
>> 	}
>> 	return NULL;
>>
>> and lm_expire_lock will:
>>
>> 	flush_workqueue()
>> 	put_net()
>>
>> One more subtlety: the moment we drop the flc_lock, it's possible
>> another task could race in and free it.  Worse, the nfsd module could be
>> removed entirely--so nfsd's lm_expire_lock code could disappear out from
>> under us.  To prevent this, I think we need to add a struct module
>> *owner field to struct lock_manager_operations, and use it like:
>>
>> 	owner = fl->fl_lmops->owner;
>> 	__get_module(owner);
>> 	expire_lock = fl->fl_lmops->lm_expire_lock;
>> 	spin_unlock(&ctx->flc_lock);
>> 	expire_lock(...);
>> 	module_put(owner);
>>
>> Maybe there's some simpler way, but I don't see it.
>>
>> TESTS:
>> 	- retest courtesy client behavior using file locks this time.
>>
>> --
>>
>> That's the basic idea.  I think it should work--though I may have
>> overlooked something.
>>
>> This has us flush the laundromat workqueue while holding mutexes in a
>> couple cases.  We could avoid that with a little more work, I think.
>> But those mutexes should only be associated with the client requesting a
>> new open/lock, and such a client shouldn't be touched by the laundromat,
>> so I think we're OK.
>>
>> It'd also be helpful to update the info file with courtesy client
>> information, as you do in your current patches.
>>
>> Does this make sense?
>>
>> --b.
