Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584A73247F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhBYAfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 19:35:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhBYAfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:35:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P0OfnT187844;
        Thu, 25 Feb 2021 00:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1MFeS0U+Khi95zmt9OhQUEMylerL7n4+Tuxols/VvYc=;
 b=cmtzwPsUqHaaAZQaQjZCEHiA3VLjv3ZYEkyvMZ7rtIbnXoB5Refh6YYCxiM5cufPwQQU
 qcqRQ/a/YsVly8vBqykxec1ABLMba2iWzrYT4Ua94altCFvH62CFesHTbZsTRDiQHVgJ
 xYt4q8YCIRnSlMAi9JkbNJbJigP2dcP5WeXUdbUCECaidQ7GLP250vxoqpyLJTohT7ZS
 4L11QqOArrGC03CIXjGqZb44hV3itERA0vptxgXTae3oVl6E9m3W1mUYex3Ax2sCp2wK
 AIqq7l76AuufmHrguukF4T8Wws6DXanE5quUoTWEQh+VdFb17AwF2H/qlcD+JEMzjNMq pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ttcmcsu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 00:33:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P0QZoj181514;
        Thu, 25 Feb 2021 00:33:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 36ucc0j5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 00:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctESuY9UOqSmMLteQ6gkSfPWLnS6j7v6PXwKtoVtDcNc9+tWg1qSq0bxYosOTg560/60pqJgbdcFAQwuPc4+n95n3I5LHKjwAEuVcAIqzT5Mtaqu+hlKfW6nZzy5kOuDddiPzDnuZ4h84mkY9QDv5yCKTIJkZTD33b3rO3lHXoXm2b3Ad63P8/2sG5UDZTzziD2yvAjkUt9oM+nznIW5TyXE6pG/niY9GupWBSh1OhW9gAY4YRdy4ToH232sHr2MDMCFjfPaE3q9R84c1TR5FLEmu27QxzWh8AKvmHwsp0ff3Tu4J+ucKbQI7327aoPa9u+UxBCH0HxQNb1GEbsdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MFeS0U+Khi95zmt9OhQUEMylerL7n4+Tuxols/VvYc=;
 b=i8ysAp3IgESZSrfLJKGFdYLlEU/uLrEyZdL1V8U7NhddisHlsM5f9ToOVCBm0MrCg7ZqWOXjTRhB31EGWYOuKAwRdoX8HqeH+1k9v8xKX000DDkFqyshevxkzj6mfK4p42Q5xFqYjQGpKYCTK7K3agL5YTdu9Jqgr+M0zNvXV+Nh3ecreqdodNx70BoNCC22Nrr7WlvmjzE+YuO5P5083wlRk/AWpK5go8oWRnK/kR5XxlWBz1U0b7/+Mdh5nYBWHy5N0TxNBk7u0TxwE1VlsyviehhNp5+FgzNRXEDkYnawdbBYKQZSSfoL5VEDJO8YO9FTk203c9CQm7QjJP5OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MFeS0U+Khi95zmt9OhQUEMylerL7n4+Tuxols/VvYc=;
 b=sM9JxlGxK2IM5Xe/Ubc3/p+zTuOR08Gw5O2j3AvPLz41AdcDgrRF/lmY3f7QiOWUDYNEFThIglP3ARZ50HxxtqYBoN+ibAM96OvzmN7hJldxiz84ss+/m8GqOqqKpnz7EVEdMV33g5VdlXej0j0hBn0Q0axWfo/Uzgxoj2UNrt4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2951.namprd10.prod.outlook.com (2603:10b6:a03:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Thu, 25 Feb
 2021 00:33:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 00:33:54 +0000
Subject: Re: [PATCH v7 2/6] userfaultfd: disable huge PMD sharing for MINOR
 registered VMAs
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-3-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ad7a9417-2172-499c-c3a6-db78f2212f4d@oracle.com>
Date:   Wed, 24 Feb 2021 16:33:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210219004824.2899045-3-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:301:2::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR12CA0040.namprd12.prod.outlook.com (2603:10b6:301:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 00:33:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297862a9-46a9-49fb-1f1a-08d8d92507ff
X-MS-TrafficTypeDiagnostic: BYAPR10MB2951:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29512BDC917FBDCA0C3FFD04E29E9@BYAPR10MB2951.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9RWqvTGsspZ8G6ot1w0B3NZNf4RQ4nkW6y+NtWBWQfSk/QvUasS9WTchrAYwxUnR7z6X4FudtVrJR5W09QSHmmdiqE1ePmtDVjksq85WpiLqdNIPSCf1vflQO5bz6/tSlOvogTdvAM+iUgduwDYjzqEmsQ92Ih38HTaeeIC3Djpxk7Lta/E0aX92KSoxATxoGkEbHByJPhl5qzthC8tYtvMtSu5VhmJ23YqVXQ5/u6RH8gyz2FaGdlI7Rc6VQfXVZcRCHGxRG8e8LrLUr4lyHES7YfiahgCQV4i2QrdnvJlUf6OpkF8rhA5D9rDwGsAVhW7H9qDS6WwMasMnfoQC8N9TzJF4to1y/yzTot2eKmIFgAIuWZevhkEP9hwIU+lNDA+vG9uLT3/7F2lD/mL73cFP46JrilTPoc+ve/EEY+05DKSTk05LsAECp3sEJDcbDR5o1tZLN2KWpYIXt3DhjLf2a3046Uoy9W2KLbMDa1yIOZR8kpj3sAp/j+4YsiIP3WMk73ykyi5yvqK7SAmUtM1J8PORjgQagrdHdLPn1kwAQl14/V7dDEkR7DJJNIU9G7QmahnvhH4Bnjz9KZLBUq40IinePmKDl+xRpxNUCi5UzzMscv9ZlUe/8GNKEtKQofY4FFBfD8O3B89/M6ENw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(346002)(39860400002)(31696002)(478600001)(44832011)(86362001)(66476007)(186003)(66946007)(2906002)(52116002)(4326008)(53546011)(16526019)(7406005)(956004)(16576012)(66556008)(7416002)(110136005)(5660300002)(36756003)(4744005)(54906003)(26005)(83380400001)(2616005)(921005)(31686004)(8676002)(8936002)(316002)(6486002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WFErekVIQWZXcTVidVlMc0todzBlV0NjMytRbDFsNmVrTFkwRXdEVzRjR3Az?=
 =?utf-8?B?LzhmVEk0UmpmNm9pRXpkM3g5VlVqYmVnbnRPeVNKMVhRZkxEZlVCYlZhQWd4?=
 =?utf-8?B?UUJGOHN2aEpPYW81eXpPOXliOC9PWnJsUktZdG5HNVRPQzJwWHl4ZElGeURm?=
 =?utf-8?B?eXBhUndtRkwrQnBxL3k4bDlTcFZwVVJmVGlqWVRmT092V0FrWmpiMDZJRkMr?=
 =?utf-8?B?RUwzQkVvV3lKb1lSOVlEVVo0U2U2VnJDb1FuTVoxUysvK2FrTktQdmdZbWl4?=
 =?utf-8?B?MUFTNU1tYmZCL2tYNGhScDNORlFpUjArV3dnYnBwVFNxakxkNk96dUNKY29z?=
 =?utf-8?B?c3JRcnVOai9CRzc0bElOM1lRSWxiTnhhNEMzQi91YVZvemQxWXdzdlMzNERO?=
 =?utf-8?B?bUdvTlZoQ1UybHNHa01ZMlFtV2dPb0ZsOTY5SkhOaWFZWGhuMktBZHVzTU9q?=
 =?utf-8?B?ekgxeHh0UGd3QWJISnd1My9lajF1a3VTaUl4OFpmRzJqMDBrdmlvbHVQUTda?=
 =?utf-8?B?NFNDSHJRRlhxOE4wcmw1YWd3MGw2RmREZGsxVjg2bEtjNFhIMk5XQUJtZjlM?=
 =?utf-8?B?ODFWcEFnWkpmUEtWYXBmUWYwdG5PcXdGblVyeEFYKzBNMGFKVFRlRGFFNmJ1?=
 =?utf-8?B?NVpDQ3RlRGxnTHZBWXdUaFdKME5KR2dTWHQrS2dVM0VPQVJ1ajhoL2tzeFNY?=
 =?utf-8?B?UUVEVEFLdWc3QkRqVTVqdGppa2REVGR2ZkpmY1BSVFBWL0xuSjZURzk0UlVy?=
 =?utf-8?B?S0VwcFZudlQwcUVENVVTblhyU2VVcFJ2QmhsVWxxdlpaNTFpQVc4MWhTTGlF?=
 =?utf-8?B?WUR6bWNkVzRMa2pKY1F3cXlPbnFLdUZDbW5pZmY2dUQvWnBFL1ZJUzhkVlpw?=
 =?utf-8?B?NGk3WkdSZXJnWjlVeisxVUJiSUpqRitjbnVIZTFjZitUZEtNS0loa1kzQk1W?=
 =?utf-8?B?UllKMk45d1BYcnlPWXpnc0JwWDIyTnFHbVZtUUFwQ2lkbHlESVZDMXFvQTJH?=
 =?utf-8?B?VHdleXBRRm4vb3hGNVhZcHR6dEc1cDZlNE1Hd3JnZWpvUTVaUVJrNlkyajVW?=
 =?utf-8?B?cWtUZ1hnYVRvR2NCbnlOQTNUVmplU3VpS2xacmJ4UU1uNmV2aGtWU1dGODR0?=
 =?utf-8?B?bWlna1FvUjgwOU5QLy9lbXJsbWtpd2dBc1h3cThKMzJvMTQ2bzlCb3QwdSsx?=
 =?utf-8?B?Qm1qbzBCU2pjWW8xWHk4RjlIcG43L2NWQlZWSHE5WUQvOUJPZnkzN01mS2tl?=
 =?utf-8?B?T0VFUWdtUDM4TjNBL1cwS25saWVhZ3RwVkt5ekJGQ2RXeXExcXc0SmZaQVpL?=
 =?utf-8?B?WWtRSHFOQlRUNVhhRVpZVnNXam1SQ2pBUm1td3Q1TDFsaWVRZmdQVnQ1VmZr?=
 =?utf-8?B?aVU4M0RybmNzWUl6VzBJdFRWMnVjRU5Sa2g1bU93aDE0UEs3L24xYXVhSWlM?=
 =?utf-8?B?bElKOUxJTFhTZWhLRDFyc2U0dzRhanQ4M0kyUkxPZjhtMXdvamRVMFRkR05a?=
 =?utf-8?B?aEJ3enY2YUVTYW1PbjU5N0hZTk1teEtTRk9pT0R2YlFIK0xuOTNvbDNoNUtP?=
 =?utf-8?B?bjNmR0xTUExONVBaSFdvOWk2MHZGOEpxbjZEMmtISWNYYnBINW9DOTF4bXo4?=
 =?utf-8?B?WXNDSFI1c2lsdnc4em9Lc3V0cnRIODlYc1ZNTnpuNDErK214K1M0d2xmblFu?=
 =?utf-8?B?QWtLZVJ1WnpVbWQ1UmU1MnFoZjNOaW8reUU1cHJHMEtheTJNOUwwTWVndnBL?=
 =?utf-8?Q?Gfkv1m69i8QyQqHrYix5ZjpdVcdiNly4I0ZyX3r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297862a9-46a9-49fb-1f1a-08d8d92507ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 00:33:54.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z8Mesx0XZnn6wrgSLnFz/ZVhKMTnYRgVvihEHxx+QH1jv6NNuIik/LF0tGuvTV+Gv9nMy40AyLonwHH/sBTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2951
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250000
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/21 4:48 PM, Axel Rasmussen wrote:
> As the comment says: for the MINOR fault use case, although the page
> might be present and populated in the other (non-UFFD-registered) half
> of the mapping, it may be out of date, and we explicitly want userspace
> to get a minor fault so it can check and potentially update the page's
> contents.
> 
> Huge PMD sharing would prevent these faults from occurring for
> suitably aligned areas, so disable it upon UFFD registration.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
