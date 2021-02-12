Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E231A6E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBLV3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:29:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBLV3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:29:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CLEvxC015939;
        Fri, 12 Feb 2021 21:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QCD3B3RjWA2ZTc4jzCZz3nA87UXTOUes7dVWbSRUOgc=;
 b=GVP13pIxuxv4Y34Jy9VxpIXSYW/13135S8XKhOdDfHpmeTIDjugp+4zOMNVrU9igQ5Mc
 Wg7NvjwWVC+e1qh6m+CsLzt3SK5YQb1QEnxQU9GUxDtJbwEVmHUzPgJfVjvWQYUAmyr7
 FX0hvNtNNuuD08NHlnuJcdqNLj5xuLnsGKQHjY6o19HiYIlHj6aCz04ZWx27Zx2c0Wx8
 1Rhw/TuNAZw+mdmQPWQLAcNrfFcPDya52Vkczz/6EkBBn9ioQcYh1nfNil/StsoeQ8LI
 sUc0j0OuuIxFa5lQrfgWnavuZfodz0emww6q6d7bmcfFjIRk1uLiMKdXWoGbIi5zv2XH bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36mv9dxvqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 21:27:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CLFCSg110985;
        Fri, 12 Feb 2021 21:27:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 36j52208xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 21:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsx7Lw1T2K3Yh4UZC7SbGr9cMw6ffUqZENafQPA25ctz0/AD+ykgyF8pEP3v+A/DLvHUQXpGAJ+pjzd4fSEBw88Ub1jgdogL9ljiw/meVvQFV/LAFlLIH/iDktCpU3mmElzQKzD3q7uLEl9O8x4AHOlSgb2WU0NWyNPb00oyaO9UnofAfyGuGlKV7q8UFC0MzEnMegk4gcGELFGPaao1IwRM9zxPr1oT3WmgLWkme/i5kKdHnvPXkmABKVGGYR9ZySrfQCo6J9P0etqDwRx8oC+U00nEBHOQgJJpLRzhq20eezra0JTP50PUY3lPmS0FsuWbIiOXAY+AS441yigL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCD3B3RjWA2ZTc4jzCZz3nA87UXTOUes7dVWbSRUOgc=;
 b=IcUIatApekyD5GeoFiaifofycMF58U5OQ/tXzHFMWXSfm1at/3s3FlQLTNx+fMymTzX/v4CLV50jSVTGb8AaVzeF4nZcXNWbAwjIx4DwGWGsqdICi+TcQrgXUIUuSgSOY0gE5k8RZI6VfgA9KeaL+TPJMg4xPIGCeBx87Jz8hQC+KCHbMF7roCwT0Uz4MJLHFGzgz62prtfbYuJDQK1xQ9Yug97FJRb3Ddso3krBnc0lS+U9BJbL5I04ijdowZ3xHls1sBj2j8NHcAJSIgpcpRbnIpnt0NqaypKWn30+px7Y/jSHuMHDzqtBQUjTqe+TCrn3ZdEmA/5Jt7DkUvjiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCD3B3RjWA2ZTc4jzCZz3nA87UXTOUes7dVWbSRUOgc=;
 b=r9vol43nvUGQEGb34oPTQLkz1ylUj4IeN/OhowCNMzpih5O8BIU2uViEWHpVkT+uUVPXzSYOOQJeWrUi4vddbbSGQjQFyzcUaR4/odd2bGHV0kMvNW4XfT2i3X2WaGgMaWvoM0pDkNrrdtr47swXXRjrtfMLU0puK11QzUJBALY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB2030.namprd10.prod.outlook.com (2603:10b6:300:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 21:27:51 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Fri, 12 Feb 2021
 21:27:51 +0000
Subject: Re: [PATCH v5 02/10] hugetlb/userfaultfd: Forbid huge pmd sharing
 when uffd enabled
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-3-axelrasmussen@google.com>
 <0a991b83-18f8-cd76-46c0-4e0dcd5c87a7@oracle.com>
 <20210212204028.GC3171@xz-x1>
 <CAJHvVchJtjpjNUYTGw1m568w_GTK_KMKbu0MLyvK8gcbrs6S7A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4a651313-0e14-35da-0223-8805cd1ac1c7@oracle.com>
Date:   Fri, 12 Feb 2021 13:27:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAJHvVchJtjpjNUYTGw1m568w_GTK_KMKbu0MLyvK8gcbrs6S7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1701CA0016.namprd17.prod.outlook.com
 (2603:10b6:301:14::26) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1701CA0016.namprd17.prod.outlook.com (2603:10b6:301:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 21:27:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d0277e-59e2-4a29-3670-08d8cf9d0d15
X-MS-TrafficTypeDiagnostic: MWHPR10MB2030:
X-Microsoft-Antispam-PRVS: <MWHPR10MB20309136178E5BD7A082154DE28B9@MWHPR10MB2030.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cM4MjhSckt1jj75AGVONXLk8NGfDraucsgPXvPgWz+Lp9gSZ+7UZrYchcDDXybI1FJv4haSJi0GiicmS8FDUtTxELxmYBQmfqPTEScE5t0oLhXzBaL8u18tlRUiozAApEz+oIM5K2q5WG/UhvGRg95KqCjo7xVLRe/1LmCnF6+NjdYhL/+qQuIuqKnWg/4mkOdECL3KdEE5vJ26FPTObPFgrLdA2e7tfQrD+UlT+1+6VT+hhq9tkokJievk/Lu8TFw4dsDezATNZ1XCK1EBd8znqacQovqvtTnn9xUtltPUGU6JUnXZ7vBjn1fsCIMq3Y6/+3NqbmwTXTqbbA0ONsjv3YZaXyGd/VH/wUH4b5/OcvefsAyVK2JZwpNuW/+xuIBlNt5msYwxi62mqTj9/SsCLfydiYo8PXRA1/pFkVxUnOIOjynnwiM/BYe5fhKWZdU9KEi2HX2iq6hHM4MNyZn/1pfUo05QGY4RhMVgXR29vbzh3q5P0nehoScyzwWRVE0gZU2oR0nwR1AJAU2aLAABJVdQt8GRwyeUiiBDHkCbBVd/3vP8Oj3GlMqbAunFtlEZZ2VoCrHfj8hQQJLtDiEzPPTj8c3l5B+wZD8YzKLp0TUrMZ1SoDxjyJzoKB8WokbhCma9XWVJk1W1mvVyRLONS1VK62VJbY4FVqKBoZM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(31686004)(31696002)(7406005)(7416002)(36756003)(6486002)(26005)(186003)(8676002)(52116002)(16526019)(478600001)(316002)(2906002)(110136005)(16576012)(86362001)(54906003)(956004)(2616005)(66556008)(8936002)(5660300002)(66946007)(66476007)(53546011)(44832011)(4326008)(21314003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Umw0dXhURGtXd0owVFVKUzQzdXZRTXBJbXhxUnhjQk5POHI1VXJkUGNHNVRN?=
 =?utf-8?B?UEhJdnk1UldmN1Z4alozT082RyttSzc1YWlMNi9ZR3laTERaRGFHUFo5KzU3?=
 =?utf-8?B?VFJjQWNPR09vK2UySjMyTEdvOWFDV1FCT1lCbDd5eXJTd2xLaHJnR2ltYXN3?=
 =?utf-8?B?Ui9yK0NnQlZCcGZ3c0szRjBudXFlL3EwZ0pBTzhWeWtiNEpYNTlISkdkall2?=
 =?utf-8?B?Qnk2a2M1UWNUSWkrN05kd0xkaGczTzA2SFlHUjFhVEdvdmE0alY1RldyS3Zp?=
 =?utf-8?B?QWl6RWcyK1BoYzBNVSsvY0h0ZnBoMzlPOXVUNEZrVFVtbnhTQ3FCNlg2dmNG?=
 =?utf-8?B?LzErRWM3cVlGOG9OR1pUQUxJQ2JBcTZVN245SjBSSEYrNVYzNG1HM3BoNU15?=
 =?utf-8?B?SmN1b0JpdWk4MGZ6YmRoaXlHTzN5bEFNWXhZRmI1RjJ5K1pDYjYyMGlnVmU4?=
 =?utf-8?B?ZmVXYldjSXNuMVVFQSs4VlpETTZ0VHhDMWdUUXRYbWhaSWc1dmxpZTZER0Zj?=
 =?utf-8?B?Z2Yyd01jeDV3ZTZsdUxaTXlMMHh5THk0TEgzaGdCeG5RMHVZVUVlNDcrbEJ0?=
 =?utf-8?B?eTR1UTJZdUpVWlgwMUNGWmllQUFPbEtnNHF6TEdYSnArQTB1QzAwbnJjSkdE?=
 =?utf-8?B?Z3dXOG51WEEwZG9FRjJmc2NTcmtobEJXQzlzWUt0b0k3OWZHemJKREc4Zy9N?=
 =?utf-8?B?SjhvTUN5KzZ1RE9mVWFDaGdwYitXS1Q1ZmZYbkxRMlVjUWs4NDVWL2tXNlZX?=
 =?utf-8?B?K3VpNkVkWGJtdTRvQ3hkSU5qekNyZXpnZDV6SXU2TzJDdWk2dWVZNkZrY3d4?=
 =?utf-8?B?ZDBUZzlYRW1hMFZaSGlwRFZNanB3bncrQ00vMjdkNi9xRldiUW5SbUhmU3VS?=
 =?utf-8?B?RFQ2TlZpQW50LzYzM3BuczgxNHB1U3F4ODVjc2pNT2ZSTE5lQUNBcUFjMFBF?=
 =?utf-8?B?ZkRHMGZ3MGx3MWpHMGg3TXlGUlhodkZUdlNmNnE0dGJnSTRTU3J6NmkvamR1?=
 =?utf-8?B?NHRPaTU1bGJlMGR5WlBDaURsdTdTN3U1ZHR3blFENDdqR013KzJ3SWVDVnZk?=
 =?utf-8?B?L3FGOXo2eEhTekNCT0s1Y3F2eHVhTllXRWR6Um5vQ1ZjdldUN1VRWHdIQkpy?=
 =?utf-8?B?a1JNTTZnTWVFNVpqSWVQVytvWEZMemtuRnd1QXAveCtjK3FaUjRZS3BQcDYv?=
 =?utf-8?B?RS9qYTAxRG5lKzR6MzZqeTlIeG5Ka3NiRkJwaHovR29sMS9qV1c2OWVaNmdp?=
 =?utf-8?B?Y2FZVEMrOGt3R0RFOWJySzJ6LytmQUVWMERjWjRhVWt5TGFzNGJuOUk1UHAv?=
 =?utf-8?B?aExIVkg1VnVKd0hrUi9pZFZwWGh0MEVxYldHUkFCTWFCU3ZUMVRFai83aTlK?=
 =?utf-8?B?Yy9sT1N1YldzeU94eDhZS0FMVndOSTdhb00yU3RleFpvTDNKSGJjc0tYYlNT?=
 =?utf-8?B?cis0YStGOFlwWnphUkZsY3lXZlJvUGNlMEVMRnhQMkorVDNSVzBFV2FScXZ5?=
 =?utf-8?B?WXhBS0xWTnVsVnFpTnFmakFHa0VSUnlYWEprR2l4ZmJnYnZWS01jdWpQZ0JB?=
 =?utf-8?B?N2trMVlBajBqSm1pcTlYTk5yd1cxdktLZDRVSTdUakh1ZHJlQWs0cjVpcGpz?=
 =?utf-8?B?aXdMaGRQdWFoREltQVE3NUE5VnpzTTQ2NTUvY2FROG5XdHc0aUNJREpjeFE0?=
 =?utf-8?B?VlNGMVJGSEEzYk5lWHhoWFdSUGQ5cDhpN1ZIOU9Ralo0KzNYR09KTmlCd3Rt?=
 =?utf-8?Q?7huXrYu2SejUjxOgbpdtJmUwBxMkpe9bBJcaXGE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d0277e-59e2-4a29-3670-08d8cf9d0d15
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 21:27:51.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZEWD+UEfYph9rKYXhw0oQrf+XoM84sLI1UPydofXzyBoMn+Ke3HUbPwOjRWGmy7yDszYTjySRaYLg4XGKTAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120158
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120158
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/21 12:47 PM, Axel Rasmussen wrote:
> On Fri, Feb 12, 2021 at 12:40 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Thu, Feb 11, 2021 at 04:19:55PM -0800, Mike Kravetz wrote:
>>> want_pmd_share() is currently just a check for CONFIG_ARCH_WANT_HUGE_PMD_SHARE.
>>> How about leaving that mostly as is, and adding the new vma checks to
>>> vma_shareable().  vma_shareable() would then be something like:
>>>
>>>       if (!(vma->vm_flags & VM_MAYSHARE))
>>>               return false;
>>> #ifdef CONFIG_USERFAULTFD
>>>       if (uffd_disable_huge_pmd_share(vma)
>>>               return false;
>>> #endif
>>> #ifdef /* XXX */
>>>       /* add other checks for things like uffd wp and soft dirty here */
>>> #endif /* XXX */
>>>
>>>       if (range_in_vma(vma, base, end)
>>>               return true;
>>>       return false;
>>>
>>> Of course, this would require we leave the call to vma_shareable() at the
>>> beginning of huge_pmd_share.  It also means that we are always making a
>>> function call into huge_pmd_share to determine if sharing is possible.
>>> That is not any different than today.  If we do not want to make that extra
>>> function call, then I would suggest putting all that code in want_pmd_share.
>>> It just seems that all the vma checks for sharing should be in one place
>>> if possible.
>>
>> I don't worry a lot on that since we've already got huge_pte_alloc() which
>> takes care of huge pmd sharing case, so I don't expect e.g. even most hugetlb
>> developers to use want_pmd_share() at all, because huge_pte_alloc() will be the
>> one that frequently got called.
>>
>> But yeah we can definitely put the check logic into huge_pmd_share() too.
>> Looking at above code it looks still worth a helper like want_pmd_share() or
>> with some other name.  Then... instead of making this complicated, how about I
>> mostly keep this patch but move want_pmd_share() call into huge_pmd_share()
>> instead?

When looking at this again, all I was suggesting was a single routine to
check for the possibility of pmd sharing.  That is what the version of
want_pmd_share in this patch does.

I have some patches for future optimizations that only take i_mmap_rwsem
in the fault path if sharing is possible.  This is before huge_pte_alloc.
want_pmd_share as defined in this patch would work for that.

Sorry for the noise.
-- 
Mike Kravetz
