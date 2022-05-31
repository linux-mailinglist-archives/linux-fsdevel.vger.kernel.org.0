Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A575392C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbiEaNzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 09:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345300AbiEaNy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 09:54:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B25676F
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 06:54:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VBFieR024909;
        Tue, 31 May 2022 13:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=skLNGeb57pJ08eNeQ8sUPtJI5U9PKbDeNN1ZrgWeiW0=;
 b=PunxV8Nx+6wXr0hjMH8nJk8TFMhSPC9FwI6om+/WSo8m1XpTIhV6cdhkjLyTjebkC7tL
 fe09RNIzz3DhP8DiGpfgQ7OSetKzn6bCPQGiqF07JmkXPIcvjzR8fStku7yfZMYzTFv6
 09qTNsf2rm8SciL3TfvWbGSVTxYXjV9TnW4gBJ/NrGUHYE6QJ+ZO0akC/hoeAdEAOBDy
 loRd9A59zUTKtjw6JXElKIiWShZ2H1PO9YjsYOkdHt3MMADp/NLsYOTyKORyOhjOlNG/
 TMLGTDk4damQoe65IVPpSjuN/+Jo7/9ziK/i/y0Hspoaz4CGf3Ku79BwsasxiJdhFIXh BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm4u8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 13:51:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VDo6NF007028;
        Tue, 31 May 2022 13:51:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p1nsvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 13:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eML3n3NjdIHMaSZVyFSjunLG74qGri0hKulpKYj6izja+94DqyV5yksLXCVciTm3WoR4OLglChby3CwtrAIYRH033tM3mF81ZezVvD7v1PIJ8QYHbMaMRk6KOzOaJp8egG/j3cpCM99lggg7ODNzjtMhqBEpmCoMimOnLdOWTcDjrLa5GbR1Wqbi2s9+BCiK08LL6y7s+qx30DKLXUBBNwODr6eq79zJ/L34/inRzQomAaEhpVWPWURFqlIHHUFj/7hhG1pafpjIUdoBECDDbIUIH6Ugl82VP6u3jBbsGrAD5B7drSEh9kKSylsFgDJUkffE+sLcNA45GvKuP2bbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skLNGeb57pJ08eNeQ8sUPtJI5U9PKbDeNN1ZrgWeiW0=;
 b=M/vGsVMBtBghIux1T/4XfRfB/ZFM3w84jAKHgVSsxAuU7xfmDDWDNYu/HsCDfmIX9WLzL3dnf2AaoF3c/L7bPXUcnEqqGSrguEIBhzMW/wold/o7Ld1owxmQLf+oTNzYnJiJLwhptBeN8gH6WuLk+JKOrCQvaanFpVdiYOokogJtlG5/2L6HH2RVXOSq7m+TrQXC3z5ZXKvKYNm0a2PYHRHfMbzoOM8bcxW1km2JEcJoVF8DPsClS4IDbBZWyS4/1Yyxn+Kq+l281q0hYKnQ8kXElmMYcXMAknD0sfSzwFQDjg/1VOCquxEjUZ7pC885B/ClnsPJc9U9sTz8w/oeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skLNGeb57pJ08eNeQ8sUPtJI5U9PKbDeNN1ZrgWeiW0=;
 b=Ge6tAqP7o6KUttEP7tCxxzSrYiVZFYMjI1V88Csq4MjykrhLGtg5l98s/gWIjZ6YGq0cJlE+/vrksGAzOSnxQXqtJ4jwU4hlet+yFjVPbZDsFxW/7PrewuB2RCEe8TSPPQJkeVSe1o2Jg5Ng6b9dkFq3XF6Z8iIJ9WDwTbQ6z/8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 13:51:43 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::d09d:5392:dd4c:7a80]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::d09d:5392:dd4c:7a80%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 13:51:43 +0000
Message-ID: <b3b1a6a0-f6fe-b054-c3ad-b6ab0f62314c@oracle.com>
Date:   Tue, 31 May 2022 08:51:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Jfs-discussion] [RFC PATCH 0/9] Convert JFS to use iomap
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        jfs-discussion@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>,
        "linux-ext4@vger.kernel.org Darrick J . Wong" <djwong@kernel.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220528000216.GG3923443@dread.disaster.area>
 <YpGF3ceSLt7J/UKn@casper.infradead.org>
 <20220528053639.GI3923443@dread.disaster.area> <YpJxEwl+t93pSKLk@mit.edu>
 <20220529235122.GJ3923443@dread.disaster.area>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220529235122.GJ3923443@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::16) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 456523c9-f530-47ed-5707-08da430cb210
X-MS-TrafficTypeDiagnostic: SA1PR10MB5821:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5821776C9BC5F182DA355EE487DC9@SA1PR10MB5821.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsbriAYePoCZvgLFogPCTtrcUUDZWS8v9EnEYGqbP/YRvWz3xMen3FcN+kQQFJAh13C+WnqV1xclXGA2BMQ2um2gFMLdfX8AuAbZTu+Y7shFnpP5DC1i3kac5zUAliIBZnSYpqYjmO298WM+n2wcT1JjBfZ+ffLvfQK0MEeREoUj6uOJanT2CtNVl3kmwx1P5Iye9C4X8KC2kluCAa7AQbyOsHh0EeSh9NxiSj9LE9vg3uZ4uxUhMq198hx6041FLfB1Xbw//qE5CEk5eJjeyH0AAzDkLuSHn5bd401jq3vpf+J7itTGw64Jv61L+1J+pDrrSB5qOHr2EbE9vh77SjEUGwpsXw2Yc6dSjsgFQHKhdXYzsZTjpPVv49SfuqUfDxKuda0vAUu1iUZo3smgfUfWasncrRBG9OrCb96v2ZiDTtEGzYBTkG5RyfGaPeQXsLGSffEEcSHw64GNbnpDLdM0izH7E5OBrc/rQBJOpYu6KCRf9AKGVCZhEPM4wITxY/3dBW9VI2OBUcxz/uFl1mqp2R0fnao8fVbyTzUm5eoD7nE5nL56B+vghMpzoPEpMi/UfenKW50TqprSHKi9Yqb1FCFkTBlH65KSWRHv2zjTKAA2mbK5n+Ctiy0JHBKcZUIQEbzLxPS5afHR/kNOjbAOtscq0gd1HmBCWr0H9x0uTHnKhBsKlQ+hpsH+axp5bToxyf3UHpwCCv5oqP+1QzrI9cIyzNs1L+B8R1asZcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(26005)(6512007)(6486002)(83380400001)(5660300002)(508600001)(31696002)(86362001)(2616005)(2906002)(186003)(6506007)(44832011)(66476007)(4326008)(66946007)(8676002)(38100700002)(66556008)(31686004)(110136005)(54906003)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUFhbGdQN1JNK1d6QjBuUGFxRDlXbkJYQjFEMVZyYUdxV2RTQlBMU3Z4bTBa?=
 =?utf-8?B?QWFJQjdTUE16bG0zRDcxRnJock1IQk1QYldOWDBNZ3ovMTYrZVk2SEJvbEM5?=
 =?utf-8?B?eUs1MFdxRXEwdk8zTnJxaFZrYXEzQUEvL0tENWgzQU16aytLR1dwWnhXdnFW?=
 =?utf-8?B?cEMvL3NjQlFPYnBGdlZnREt2bDN3T1IxMGw2REIvYlp2UW5nMmhncGY0dE9D?=
 =?utf-8?B?QlJ4ODBMcXNnaVkzMldWb1JzU1lFT1VIeXgxalJnQnF0WTlVN1JtQnAzWVVO?=
 =?utf-8?B?TU56MW1EVnN6Nmd2eGlZY3dvSklhWHA5bTYrdnB4L1VtZUoxQ3RxSnMxS01Q?=
 =?utf-8?B?U1JGZmJyV1JDZ1hIOFg3bi9nMms4RXI3S2RSVEplSzJ3YjhsMlB6VU01RFdk?=
 =?utf-8?B?VDN4VTM1MHY1bXVmc2pTTHpnYk1MYVpOYldYOFRNWVdFekQ1SmUyMkRFRmxu?=
 =?utf-8?B?NU9WYjQvV25ucDgyTm16VFpsUHlocEdoM3N0N3BFSHB6UkJuVUZzTWlsdFIz?=
 =?utf-8?B?VStsa21uSVpjK21BYVhpK0JyM1NPeGREWnNrZmw2aGE3WGdSQzBDY1AvK1dD?=
 =?utf-8?B?WmtuUmJwVzMwbHNxRnNMZXk1eVJuM2YwNnFWSXdSckI2QkVzRGJLLzIvTnRu?=
 =?utf-8?B?eWdNNjVORlpjMWJFc1ZmZ0w2ZVhvUWI2RU1mTlFuMzdzRkZlYWVaT1YvaEVT?=
 =?utf-8?B?SXhmekc5NmMzSmRTL0dtS1A4Yi9Tc0E3M2xzMXdRbmJRZjNNaDljYWtUL1N3?=
 =?utf-8?B?V2RNRUJjM05ERGtpVkZzZ3lIKzVUZzd0QUFrOXNMUkJDQ2JxeEx2ZllLZUlo?=
 =?utf-8?B?YVFUbnVaUHhxZXI5c1BnK0NzYWZtSTdOdlgvWkJETUJFN3Y1ZWVPNGtlOHB1?=
 =?utf-8?B?SE02N2VrL1RJK0dobVk4THVpQTJpK3RaRkJwYUZKRm9ZaTdjeDdheTkxVFhQ?=
 =?utf-8?B?aWNUTlcybGxrTHB5RzNGOThqNlhxSFNkSk9XbDNRRGMzTjZJdlk3UStWOFpC?=
 =?utf-8?B?ZWNjb0JwWmsrdTNDZW5pR3FKUlA0aTNYU2NqbWI1U2ZuTGxkNnBRV3FmaERM?=
 =?utf-8?B?QXlGWnpHbDlDRHJEUnpheTRSdFJvTms1a29Cd2NWbUdKZzd0dHloS0lHeVBR?=
 =?utf-8?B?a2Y3K1lHUHVOOGxZOGNtUUw1a3B4TEN6c1FLR2NDSUd3bi91SVdWZlFKUTUw?=
 =?utf-8?B?b2EyNy9DdGYwVWV0Z21WUlRnWWJsRXRYRmlHTkI3MkJ5SEMxT2RRY21DblEr?=
 =?utf-8?B?Y1REank4amxsdlFqeElpVG1nNE1PQmhKcm9DV0o1d0kzZ0ZldlRRN21PMlB5?=
 =?utf-8?B?NzJodTAxZzdtcysvY2hUdUZFaXI3NXVHejhGejNGTVJlUGl5aklGYVdvMFY2?=
 =?utf-8?B?eWE0T3F4aENZRDBkc3NjN3FnMTV0K1R5UG51UkRkQmV5WEhSNUMxLy9ubzdk?=
 =?utf-8?B?R3NYQ1M3NjdLZVE3ZkZUNWxCMEhkbXM0TzhDbVU3aHEwdE5hdWtWZ0VrQ3Nw?=
 =?utf-8?B?ZDB0WjFSQVN6ZUhTMHNtbkx0S1VjMitIbStWdUQraGRWcDkzeHJIZG85b1NB?=
 =?utf-8?B?Qm9DN3JRTjBBNXFja2doTXBLaWFQd0djQzNaNXIyYm1DREVQQ2tUZFFnTS9O?=
 =?utf-8?B?WHMrdHVVQXBtSEY3RUJTNHlzbC9RK3B0OXFkb29TQWVwanVweEtvYWc2amhu?=
 =?utf-8?B?R2o4LzBXa2grdEVjZFdrVlFSMkJMRG1sTnR2QW5BdkNySUhnVWRvem9Ma1VI?=
 =?utf-8?B?Njh6S1pETTh5SFpwVDVUanRIYzBkc2xaZHk2MjhqZ083eFlINXdwRlVobDcv?=
 =?utf-8?B?dUlsbGlDeGRvaW9Yallvck9ld0pscFp1VzJ5STd3a3c3WlBrdHl1UEVTWldL?=
 =?utf-8?B?c1EyUXNWSEszZmpDWmV3WWZYdGM4RFluQUZYbG5iZWc2a0NxdThEd1ZwcWpV?=
 =?utf-8?B?STFJTm0vVzVnS3BtZVdkTFlJdEI1TFBuMHNlQXpYNy82TUVjRnA1YjhMK0Ru?=
 =?utf-8?B?ejZxQTRRZ1k2aW1jM3V6YXo3ZFplcEU2QnVYL254RU1waTR2QTYvVzY1c0h6?=
 =?utf-8?B?eXpZVGJVQmtGUnQvTXl2YUhZdWR6RWU0azBrVE04OHpFVldoUjlqM3JzYVJY?=
 =?utf-8?B?WnI4Uk12SlFLVEtzeE03bTNhZjVIZW5lN2YvdDhmQ01hTk1OTTVrM3NZYmlZ?=
 =?utf-8?B?RGJyakx4L1phb1NsY2JsS3NjUDE4WExnV0trMW5aNWNKRzZyNXcxdTB0Sy9M?=
 =?utf-8?B?L3BjNXFhYkFGdFZ6MnozQmtnTTNpRUlGUGRnUlZlSHhENG0rZGtEa2J5aGs3?=
 =?utf-8?B?emFIaUd4NU9leVh0ODd5NVZDdFZ4RFh4aCtJSkdBK1VHWVVIbjV6THFzbDBU?=
 =?utf-8?Q?NJD4b8tTZlLDhdvQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456523c9-f530-47ed-5707-08da430cb210
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 13:51:43.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tZxhczrfwAwTeMsk2ZWZZDpJM69weEg2cagos9oIBYUE9PowVNINYEajhb6CvwENPFcSi3b9sSVs1NayrTuimXaYP3QvA2R5uU4PAs6KjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_06:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=771
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310071
X-Proofpoint-GUID: rPFZ2VMNw7jvvevhFY00G79-ozFh4IMw
X-Proofpoint-ORIG-GUID: rPFZ2VMNw7jvvevhFY00G79-ozFh4IMw
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/22 6:51PM, Dave Chinner wrote:
> On Sat, May 28, 2022 at 02:59:31PM -0400, Theodore Ts'o wrote:
>> +linux-ext4
>>
>> On Sat, May 28, 2022 at 03:36:39PM +1000, Dave Chinner wrote:
>>> The other filesystem that uses nobh is the standalone ext2
>>> filesystem that nobody uses anymore as the ext4 module provides ext2
>>> functionality for distros these days. Hence there's an argument that
>>> can be made for removing fs/ext2 as well. In which case, the whole
>>> nobh problem goes away by deprecating and removing both the
>>> filesysetms that use that infrastructure in 2 years time....
>>
>> This got brought up at this past week's ext4 video chat, where Willy
>> asked Jan (who has been maintaining ext2) whether he would be open to
>> converting ext2 to use iomap.  The answer was yes.  So once jfs and
>> ext2 are converted, we'll be able to nuke the nobh code.
>>
>>  From Willy's comments on the video chat, my understanding is that jfs
>> was even simpler to convert that ext2, and this allows us to remove
>> the nobh infrastructure without asking the question about whether it's
>> time to remove jfs.
> 
> I disagree there - if we are changing code that has been unchanged
> for a decade or more, there are very few users of that code, and
> there's a good chance that data corruption regressions will result
> from the changes being proposed, then asking the question "why take
> the risk" is very pertinent.
> 
> "Just because we can" isn't a good answer. The best code is code we
> don't have to write and maintain. If it's a burden to maintain and a
> barrier to progress, then we should seriously be considering
> removing it, not trying to maintain the fiction that it's a viable
> supported production quality filesystem that people can rely on....

I'm onboard to sunsetting jfs. I don't know of anyone that is currently 
using it in any serious way. (jfs-discussion group, this is a good time 
to chime in if you feel differently.)

On the other hand, because it is not being used in an any 
mission-critical way, it may be a good filesystem to do an early 
conversion on to see what issues might come up. Unfortunately, I've got 
a really busy two months in front of me and won't be much help.

Thanks,
Shaggy

> 
>>>> We also need to convert more filesystems to use iomap.
>>>
>>> We also need to deprecate and remove more largely unmaintained and
>>> unused filesystems. :)
>>
>> Well, Dave Kleikamp is still around and sends jfs pull requests from
>> time to time, and so it's not as unmaintained as, say, fs/adfs,
>> fs/freevxs, fs/hpfs, fs/minix, and fs/sysv.
> 
> Yes, but the changes that have been made over the past decade are
> all small and minor - there's been no feature work, no cleanup work,
> no attempt to update core infrastructure, etc. There's beeen no
> serious attempts to modernise or update the code for a decade...
> 
>> As regards to minixfs, I'd argue that ext2 is a better reference file
>> system than minixfs.  So..... are we ready to remove minixfs?  I could
>> easily see that some folks might still have sentimental attachment to
>> minixfs.  :-)
> 
> AFAIC, yes, minixfs and and those other ones should have been
> deprecated long ago....
> 
> Cheers,
> 
> Dave.
