Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7B4E481F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 22:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiCVVKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiCVVKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:10:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950434D9DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 14:08:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxRTa014390;
        Tue, 22 Mar 2022 21:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R1hg3bDK27qdA9MBhOC5NFBJba1AgsQ5TWzgKnNLjzI=;
 b=N+WDjyFNrIBVREx+nc3wqxckDQqAGpvyIBTctyIkYRW34uR0nf9Ly3OkWcZnXk+BCQTt
 6zSO+3SZu1Da9qNQIpVgeZsslUu8YIDCUR3eluBn5nA1lywOWxCtFOXVJMnBOKmfvYUB
 OJgWxACpJMKVdAA4zEh11byJbITR6FuX05G/KJVeO4AaMRqWOeQJ3VJJ8TPOA0azYJav
 NBEsWZOtgvgpKxsfGcyCHfyGhjFVdXbq7JBGXoWw1MagHOWOVf4z6klESzoRTiDAZ+Eq
 DL4u5pWJEX5vU7wNOhSBaJsuoiZn/cOLxY3eXYIhKepdzSWc/fPQCH/e5i+MrOAaRF65 /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1ys7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 21:08:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22ML5JcT002049;
        Tue, 22 Mar 2022 21:08:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 3ew49r7yrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 21:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxwWcrnFPzh6GKfoUPHl22D6zdYnmNlC8XixUElUYjHqOHaES22jjLEHFUl9qBSv3FAmIVoan0GWP2Qhfu5DcbSSFTcdF+6e12af4+O4KsP/vmkRB54BcAoR6eBx8zCN+9XYFUJ/kkjJThxCuWlkQk6iP5/yNPT2jhp6KxgxJWncQEKiFLVcjADSLXAKJd617oF+xQUEYbfveK7MnARr2gGO+hQBWVgokAbAbjhm3FW/NEXy0FbcLBvYM0QO4KS0DiTTAduWtXhAHO/zwPYwxZ33DNH4JJPZQtSEoGZRj+V14YqFTkDkUfkBIpNnxZIwhegi7JYAnnYO9mvAscx4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1hg3bDK27qdA9MBhOC5NFBJba1AgsQ5TWzgKnNLjzI=;
 b=cu3Fpy85wZDCjsdmIVoQLNw9sa5HCt2T/QjQyR2Lhsc0aHo2M5Zixp91nMyTMpH8mJHG/YJf4PgS0mF0T2M6V279yPSgg9FyrNR01NHjIGD2Z5nM5pWhd0pruNlY9eoKSKmnDvGHCRDiU1tpvlz4a65DAS9PJONvI7WDoLBrC4G8L1VIub2P6ku+QIWzubqfDpgYBBwEp0W+mEK85bf2UfNYkoskZxvUvtA2sJuPgvMrxELG9ZVVuUqX2zQkfsyEzqQl425B8Nl4Z0TzQ6SSWvqkBH6aS7fu7KT6FvtaxRylElUve6GJWT3azfDFcSUl4YZbBEnpwYeFOzTQXmXlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1hg3bDK27qdA9MBhOC5NFBJba1AgsQ5TWzgKnNLjzI=;
 b=bTSocYqg1mxb6zaIeEqttow7FVal1g9dbh0oGuBZoGNnGpDH7oNcOXAbKH3wf928FYnbcd2vqxYi5VPstY0FjGe0Esm/BqVeSuh7FaEKK/Ulex2ITF20Fq/+eXGNyqoy65t4uoNcKJJzy1ONssoMDyDzYnNvIbj3BCzAD1zJZew=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN6PR10MB1490.namprd10.prod.outlook.com (2603:10b6:404:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 21:08:06 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6075:ab9b:a917:ecc7]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6075:ab9b:a917:ecc7%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 21:08:06 +0000
Message-ID: <3a7abaca-e20f-ad59-f6f0-caedd8450f9f@oracle.com>
Date:   Tue, 22 Mar 2022 14:08:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
 <YjnmcaHhE1F2oTcH@casper.infradead.org>
 <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
 <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
 <YjozgfjcNLXIQKhG@casper.infradead.org>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YjozgfjcNLXIQKhG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52041997-5afb-4a80-1bbe-08da0c480f5c
X-MS-TrafficTypeDiagnostic: BN6PR10MB1490:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB14902A5892C6127FDFE32C0DDB179@BN6PR10MB1490.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFNPeS7zk/TTRL8r/MpKMIC0wCFRWWd5A/jhD2yY2Avme2ffEMnPQY4/mHNnobEDffNUOmHdmt0ZjvpfUA4RnZET3E4BMvtnCMmK13z1dBo4yP/r5+TVJd1+d2HWhhzdgBkax4JuQFk+CSsshC3bkgGdyE8kkfWP/WSs4poXHqEe6n/TZb35c1Gorsc0HlWukASEyJFUZclyLb7JGNOKNSHsF+EmGPYFfGQBzerccLCmDvivC7/6c9VYwfYnFFzPWYq12LSWrw5ZraP7ql79IzYUSu4/KirKSIS8Ro4ThCOho5WFXoqiCwry5nZprXojdw9f1UEcRSjyWQ7TJB0X8FEPoxa/igoEN6LPqWvDHKm/nYo1+vXd7Vly2ZNLnsFkc5mAD783q6yraO1i0fB8d6wYtxQmGRibbJLTHCEeofoTC9i6Nxas3TG0nA0/Gr4K6yVi91WVLqFdIi66JGM7xsUOKTkaBzO+yFmsW7jD/QvLAzxXJUFGKzYfZ3gGWn73cpMM5iKcj6bsBQVY+RZBKOy+JF1fuahB8KYbVcbcQhU2DIW9FC884o/W+33z2wn/ENUNvewmK1DBoKkMzG+vfeOcom7LJFXJPwOMHmMjua1+zQ90KD6JL/lfBrrre0x0Q8pV83q1ycg/Gy487Wbvt5azAbtj9BhWom2Wmuv+vwS/OstE6gD3FXISuY9to0cacRSHff+TYLGz1iqGBGnv/JXMBtOiirIdoanE5U/v45H1cAUcMBjmk0OJAvcsTu2Hp4ScVC3U1p6axMS0QAx1eC/1xZEueOfdGr7BrgZvyT1iGua3pgCNlvTjeG0lDE7mefrqLTD3jwklz+PaAT1RFwXnmAK3dnQy9aezdbaoPS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(110136005)(66946007)(54906003)(966005)(6486002)(38100700002)(86362001)(66556008)(31696002)(66476007)(2906002)(8676002)(316002)(4326008)(53546011)(26005)(83380400001)(31686004)(2616005)(6512007)(186003)(36756003)(6506007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtGc0RFTHRrdjRZeEpabHlta3hGL2tMZXNOK25ueHBrWTlFNkh3Z2Exd3Vm?=
 =?utf-8?B?SVNwNEZyd0s2cXpCOUNUTjgyWUtabG1EUFYrRzJlUFh0YVR3TDJmVm9UWW85?=
 =?utf-8?B?WkRwOUJYRnY0WW1HYzR2Z2JIV3VRTGhGUVZxTWNGQ2Raa2lOVzNSa1NVN3hT?=
 =?utf-8?B?VmZST050UUlTc2NJTjIvb2NDNC81MVBOSXNjam5GWldaT3JRUFdFTUYvV1pI?=
 =?utf-8?B?dUY1djdFaXR6TmFjNCt5YlowLytTeUdOdzB0c29yNmppbnVjL1RRRHRNZ01n?=
 =?utf-8?B?N3lmcGVSdzBoZ2tPVTIxM3dWVzhsZjNYVUtDNk9Jc0NaQmlUQWNhUnRtMm1F?=
 =?utf-8?B?dVJXcHRmc3UzTnZqU1NGcDZ0OWsyQVppcG14cTFnS3B5MWpqcFhIT1lWSjN1?=
 =?utf-8?B?ZmhZTGlCZnR2Ry9WUWJDK3VhNWM1azlUWERDOXpvQjVsNUdsbkxIZ09Bc0Nh?=
 =?utf-8?B?M0ZRRW8rVFdVM1gyZzB0VWdlVFAwbzBkejFIa0ltVGxZZmo4dXhScG5hN3JH?=
 =?utf-8?B?T2FxUXdjOVNwUkVDcGpKZEp6VjhCNmIycU1lMTMxYWRJSE03MFp4OVBmVFJv?=
 =?utf-8?B?WnhDajBKQmYvWE1SOTYwNXloUFY5akMvSmJVbWs3ZFVsRkM0cFJSTUl3RGJk?=
 =?utf-8?B?cnpqVXd0d0RidHhIUU5IanJyVHA2VXRjN1VzRXpCa1lxdklHanJzbEoxeHdo?=
 =?utf-8?B?LzZqWVVRU0ZxNjhSMnVHWXZHWVNtc2tkWEJReGMydDJCV2hEWnJsdXBlWkJz?=
 =?utf-8?B?VnhPeGwxVC9FNlBPbitodTV1RTBlZVJBaFFmZHNlQW1ZOE1KZ01XQ0o0dnJo?=
 =?utf-8?B?RkhXaWFBSnFXeWZnUWdEZDRHNzRvV3V2eXpia2FtQW9OUytKRFhsYVJ0WWh3?=
 =?utf-8?B?cWlJcCtEREhXKzJaaW5MMjBiY3ZlMVF2RTBHS3FsRjlLZlN5Uk1mZlZ3ZHlw?=
 =?utf-8?B?QlZWa0YrWWlYeUhIeE5td1k4eUhpdTJGRnZ2ZWpvVGthcE14ZmNyL0dzckZx?=
 =?utf-8?B?cThhTzZ4eDdFK0FDMVVhTXBwY0FpRzVxR3J1bDdUWHVldWNtUGVnYk9wVStt?=
 =?utf-8?B?eDdrZlo2SW5QelpLVnViNVJZc0d0K2lmL1FXK1NScnJxRXdhY0VOVEFJak54?=
 =?utf-8?B?ZXdlcCthUnp4MVFkUko2VVRVZll0a0Q2Smo4Zy9XV0hVYU11NklzTHN4NzR6?=
 =?utf-8?B?cnJqL2R3ampqTDYxc1FLQUM2am9EZ1QyL242YXB1UzgrU3czWkhIMThSSFIr?=
 =?utf-8?B?akgwWFUwWVIwZW1CMUNEbm9oODVtWkExYW5STk1LUXFGNnZoVC82MGhVR2ZB?=
 =?utf-8?B?ZkZSTHgwQW1ZTE1iT0YzRUsweVBOL043LzdMYWM0MjYvQktFVDVUUVZ4M1R0?=
 =?utf-8?B?M2pXM0g4SWpjUUh6cDFuZjdnUXlVNWZsYndZQk5aekw0eitaUVVTcmVZd1Np?=
 =?utf-8?B?VjR4a0pqTDF4Sld3SVN2TERDeUI0ZTNFTHFMZGxWWTZpYjNHdkZzSGdBNUdp?=
 =?utf-8?B?cXY2WEhjZi9HTFNJeGxoUEZwSWFHWUJVZjdBLzNaaFBDcnFxL1YrRHBpaHY1?=
 =?utf-8?B?blFiL2xha0N1MVlKMnpQNWNiL05NUjl0aGVhWmhTZERqcklEaUtIcjBDSXY4?=
 =?utf-8?B?UEVOYlIrU2RZLzQyNkZWSkx0bFpRT1NlMEIwT0ZhS3lIbTRjOFBNZ3ZJRll1?=
 =?utf-8?B?UVF5SzlLeDdjZGRaeFUrZnIwZ1pXZDZLUW94NU1tR2pkamtTTHJVY2szRHJl?=
 =?utf-8?B?WUw1bTdhUUF5RHJEdDN2aHJ1UFV6bXU4STJ0MzdQcXMrbUVkU2VFNWRjMWEx?=
 =?utf-8?B?RzEyTVhITTJucmNrWnhvcHB5aVR1NERpem5TTVVTdytINHFVSDQ4d0N5cWow?=
 =?utf-8?B?cDNjcjdzb2tkY0dyeENpRkx6M21NU3FHOEZMVW5XaGtCRmxqMDhTSlRQVzZt?=
 =?utf-8?B?cmszVEp2OS8veDU2cU5yOUszemxCMWJ2RUhjNVZ4Z1Bmdnl3TkZCVUxxSjZl?=
 =?utf-8?B?MnNaYjI0N0tnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52041997-5afb-4a80-1bbe-08da0c480f5c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 21:08:06.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi+JMk3Mq+tLDLbrMexPoeJsQ24PLJlRUhVKWLhrG9yxUSzSv8v6Hgv/ufFJPwNto5r2vM4V/wELL//CTp2M5U3ABkSvQownJ+qEFptC6ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1490
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220107
X-Proofpoint-GUID: JYM_A4w-7jUggLIXftvoaMbLofTxF_mw
X-Proofpoint-ORIG-GUID: JYM_A4w-7jUggLIXftvoaMbLofTxF_mw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/22 13:37, Matthew Wilcox wrote:
> On Tue, Mar 22, 2022 at 04:17:16PM -0400, Colin Walters wrote:
>>
>>
>> On Tue, Mar 22, 2022, at 3:19 PM, James Bottomley wrote:
>>>
>>> Well, firstly what is the exact problem?  People maliciously looking up
>>> nonexistent files
>>
>> Maybe most people have seen it, but for those who haven't:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1571183
>> was definitely one of those things that just makes one recoil in horror.
>>
>> TL;DR NSS used to have code that tried to detect "is this a network filesystem"
>> by timing `stat()` calls to nonexistent paths, and this massively boated
>> the negative dentry cache and caused all sorts of performance problems.
>> It was particularly confusing because this would just happen as a side effect of e.g. executing `curl https://somewebsite`.
>>
>> That code wasn't *intentionally* malicious but...

That's... unpleasant.

> 
> Oh, the situation where we encountered the problem was systemd.
> Definitely not malicious, and not even stupid (as the NSS example above).
> I forget exactly which thing it was, but on some fairly common event
> (user login?), it looked up a file in a PATH of some type, failed
> to find it in the first two directories, then created it in a third> At logout, it deleted the file.  Now there are three negative dentries.

More or less this, although I'm not sure it even created and deleted the
files... it just wanted to check for them in all sorts of places. The
file paths were something like this:

/{etc,usr/lib}/systemd/system/session-XXXXXXXX.scope.{wants,d,requires}

> Repeat a few million times (each time looking for a different file)
> with no memory pressure and you have a thoroughly soggy machine that
> is faster to reboot than to reclaim dentries.

The speed of reclaiming memory wasn't the straw which broke this
server's back, it ended up being that some operations might iterate over
the entire list of children of a dentry, holding a spinlock, causing
soft lockups. Thus, patches like [1] which are attempting to treat the
symptom, not the cause.

It seems to me that the idea of doing something based on last access
time, or number of accesses, would be a great step. But given a
prioritized list of dentries to target, and even a reasonable call site
like kill_dentry(), the hardest part still seems to be determining the
working set of dentries, or at least determining what is a reasonable
number of negative dentries to keep around.

If we're looking at issues like [1], then the amount needs to be on a
per-directory basis, and maybe roughly based on CPU speed. For other
priorities or failure modes, then the policy would need to be completely
different. Ideally a solution could work for almost all scenarios, but
failing that, maybe it is worth allowing policy to be set by
administrators via sysctl or even a BPF?

Thanks,
Stephen

[1]:
https://lore.kernel.org/linux-fsdevel/20220209231406.187668-1-stephen.s.brennan@oracle.com/
