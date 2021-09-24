Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB3416951
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbhIXBXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:23:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53658 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240863AbhIXBXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:23:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NNd3po022001;
        Fri, 24 Sep 2021 01:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s8izIOH8/g6Vd6IOyEVFOVE0/6D0WXaLgmUrBxpz4J0=;
 b=QZLYUDUOJgWhUMM4nMLuEfgVsrD+a/BOTNbeV4wZ7njWICxy3gWPzRUW4U4Ka6Lc+5Fo
 eQCZWpKa9HM/+FNSu61qQy5TS6k3IiR8ceQ50u2YPya7YARNYF7Ih9QX0Chz7/38Y7I1
 r1khCRC5GyaZV8xOdazdnIcHwR3uOe++o+F/sX1FnNjed2RKl10GQI5/soQs6t7F3R7O
 dancd4IrN7bO1Mck6f0sFtHt3ON5YaP5Avp2m0w2hUtjAy73YpuF5Z3oeYs9i3Fcsf1t
 nyhFgpi4SPEVAvjolT4wXfczlCaCTjV2cVvPw1JEvvKRz98hvVviql9Wb5rLqfj3OPHb OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93engc8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 01:21:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18O1A73s044453;
        Fri, 24 Sep 2021 01:21:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3b93fbba41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 01:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLBaaoOqLg3qMpMDxCY+5GW46b0IjwNtMSx5sQpyKnAlyN9Z+dZ1P7w3C3b+YHM/4smVIguxjBCQnSj+tESzcKcv3+OtO9VQCMhAetBAZyKzSz+d4/PGiTxayIjSm50eNLnnwbPjhxAG+Zerd8k5X/3nmTgN/grmGZYwgPlGA9933TIKiBOWSaY8lHyrPiUTa9hWiRzIX1JJAd8YaBTD5t5giAORQzgv7c+t40akW2gjLrDJxkutr+idfS4MGYYll1UR8l23aXZwkiXV4QhWSN/M1ukRKBM9dnzqBawVudzYHASYDECxkuxfTgr3WNqlErtsTfHg+U/4WApPH4kRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s8izIOH8/g6Vd6IOyEVFOVE0/6D0WXaLgmUrBxpz4J0=;
 b=X4FT35OzOMV0UntHISzir7USSLhj+QvvKRLFzepV8z01b7do9zMdy/48pnyfgUxmv5kR03HRBM6ego0jHwyF59HisAVm3rnVLS5x/0xKHmyaZtj2/617u1bCtswrKMTMxZbdc7WwNB5bCI0WUifGBsyeDE84KJ90QVN+ly0mf00ILbls/aLmG1lSiFWtQtqvKriNY/vUb4jBgvr+aTIHAuMNBZFrnlC7zAIF7h2U60yxHTCLO4ivoTHxDvPpauFFzAkuVYB/glmRaBcs8aO0Xw3mztDAfbgncAhH+Draou/G1GdUkR9XELgLWXWvJkC4kw0ByuKOOtmMlzTYacYMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8izIOH8/g6Vd6IOyEVFOVE0/6D0WXaLgmUrBxpz4J0=;
 b=xkx7/7wDUcreRa/Ffb6GObas5Mvc2kPwLQ6CmFXNA2XDZ4QjRYoKmSWj+4xhNsmmnVeZYsqQkF3oOmpsm0dtFfEJEKea8fm5y41YpXBobqp4UgLC5CWSolWSe+7xPa8gJqkJUvw9pkFCZNShjSQ1MSlTgqcDvbKxXJ16ff3pOOA=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB3859.namprd10.prod.outlook.com (2603:10b6:a03:1b6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 01:21:23 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%6]) with mapi id 15.20.4523.020; Fri, 24 Sep 2021
 01:21:23 +0000
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <CAPcyv4jF1UNW5rdXX3q2hfDcvzGLSnk=1a0C0i7_UjdivuG+pQ@mail.gmail.com>
 <20210922023801.GD570615@magnolia>
 <20210922035907.GR1756565@dread.disaster.area>
 <20210922041354.GE570615@magnolia>
 <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia> <20210923000255.GO570615@magnolia>
 <20210923014209.GW1756565@dread.disaster.area>
 <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
 <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com>
 <20210923225433.GX1756565@dread.disaster.area>
 <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <09ed3c3c-391b-bf91-2456-d7f7ca5ab2fb@oracle.com>
Date:   Thu, 23 Sep 2021 18:21:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from [10.159.139.16] (138.3.200.16) by SA0PR12CA0018.namprd12.prod.outlook.com (2603:10b6:806:6f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 01:21:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc95a02-767f-4114-9d60-08d97ef99f1e
X-MS-TrafficTypeDiagnostic: BY5PR10MB3859:
X-Microsoft-Antispam-PRVS: <BY5PR10MB385976B6BDB239B2BA05C488F3A49@BY5PR10MB3859.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQzU3hgcfBJGEO2+2GDFeGZ+oCKyVTIkRNWxGhVUSRdNhMUrokupRRvN9lTid60rwKxWlqvIeLG5z1A3PGvrDDP2TAI306ggyqZj3GNldp2SKNnCAzNFgo7/KZGtSKBQbfqwZJBTiP/GF1L3Oc3E5n/TIwm19TFrxwVh53Q2wzcuZXahW9LjMBNx6ZG/7/gALmKSALLOb0Bpb7py3f/ZXK4JRlb5uTiNlK5wHgCALhKApySJKJUSNCCUOBvE1V26aaPu3vzkvNrIQzZvd7OiQzOs57CzgwA4TBcCuCYi9/q22qbDVhqAph/rtVwXunsO5WSgOPVPQvH+p9lid/iJKXdWi8ejubsVrr1gZeJgO8d1PVinROK6Hp+rVIbdme1PQA2w/dDFcQylswCsTtAAkbFXbyZPFAiEPPu6f+wa0pwqDsFHv121LO62CLpN6d2+WNAQTRJAwEZcjimonrtcKt39J1TycNiJuxS5Nwx2RoszHtZwwtgwPXNc8ZR76ijRBh9aX3sfI2G4hNPVRoIGhGJM+y8oorhVqGCA6z4jJK5NswJG8rSoekAq2pP4QXZwcPGNPvRzQDyUNP8L3PKsag2X/FXGt8bcD+XDSTatklyj/BpuCWhHtSikze0uTXJFqxW/pl8KVP+lAoodKrXkwUeWX3bQy7kFlIy8mKzr6i0SlqjWuT6gnxYizr3gPa37xvW4N1Dk5BAGLCWkZSQ9cWKjih/YVyzUuPZGvs33XMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(54906003)(6486002)(508600001)(66476007)(16576012)(38100700002)(5660300002)(66946007)(31696002)(26005)(316002)(44832011)(31686004)(186003)(8936002)(86362001)(53546011)(66556008)(2906002)(956004)(36756003)(2616005)(4326008)(6666004)(83380400001)(36916002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFKRHg5NVMxbE5PQkoyemVHT2xNdGRucG1QeTVHR1VGbVRTRlVncjh6NlZW?=
 =?utf-8?B?TUdYSUtMZ21pWTFRc1dPWitIZVhxdFV5Y0tHTXF6SFk3N3kxR0o0ZFVuSVM4?=
 =?utf-8?B?OTJiTWh0WVNFbEpWMUtCMlBqMDlkNENNcytrdEFZcnlCWEpHNk83bWNodzRZ?=
 =?utf-8?B?NDBITlB4a01sNGc5Ri92ZUo1enM5c0VTQkhVQmRqUWtlakhoaUtIbE10MXp0?=
 =?utf-8?B?Zm95WW1BU3cxcFE2aTdEOGJPT003Wk1RZS9sREtmeVp4V0NaY3RmK050WW5n?=
 =?utf-8?B?b2VWVVZsSzFlQXlkRVBvUURabEtCL2kvTVVaWVVvZHlvOVpDTzg0T3Zxa09T?=
 =?utf-8?B?M3V5U2lkcDhjbFZ0bzBPSW1iUFljMmh6Y1lIeWpJYXlic2h3OUVYam1nWVRr?=
 =?utf-8?B?SmtocG42STZFREQ5R25Vc2VSdGdkMG5KYU5mblc2a296VlRuU1VDMURBUVVp?=
 =?utf-8?B?WUpwRkI3RjZiSWRubDZ0R25JV2JtYnk3QXNZaTZUZmlpUHdtUTFHUXJqaDY2?=
 =?utf-8?B?OHUyZFUvdEZMekVkRE1tWmhCa0YzZGJtNU5aY05LZDcxcTEvemVUMTdCZi9J?=
 =?utf-8?B?alU0R3pWVlMwby9BYWNHbkFiaVQ3aGhnbmg5b3dmc3VwTllwMXgrSStlb014?=
 =?utf-8?B?THJ6YU9yMm9ZZkVVM2VXUFFwcFhBTkM5MzBDbWRmMUZtb0hwMEZpYWRrYjhQ?=
 =?utf-8?B?NzBBNFk1Umo4K3BwU3dKRm9Bc25hWkM0ZXhaQVJZNHN3d0FCZk1COFgxT0Jv?=
 =?utf-8?B?RUVTelhMcE1SMEtnMnI4eHd2bFhWMFIzc1FSbElTbjEvMUdQblh2OTZjTElJ?=
 =?utf-8?B?dWlSQk00bU03NzFjbzluZVcrQlF0Wlg0V3ZFdE82elNRdDZqblM4eWRPY0xv?=
 =?utf-8?B?RkFiT0VWNnFEYW52Z1BXSFVZVTdtZWpuaVJSaS9iYWpyQzg4UVZNNU54WGNy?=
 =?utf-8?B?cVJWVWVSdFNQOFRHNmNsRDcvM1VaRWtjTk1IbDBMSGNYdE0wZ1R3V0hxbkJY?=
 =?utf-8?B?eGdaQnlpZkVsMHdEZDllMDVsZmd5Z3VaNGhZUkpOYUpXbUttbi9HRVIxeWI4?=
 =?utf-8?B?cG1ONkl5NlBmMlpCeWpLdFREV0dLelhWOEU4bHlGSCtoQ0sxZEJzdU9PQlVO?=
 =?utf-8?B?ZmxVZHd0WWdOV00rSmJBTER2dDhZL052TGxNaWlGQlhWSUNDNEkvS1RVdU56?=
 =?utf-8?B?eEV0eCt1dW4yUG44M3V5QTZReUh1V1hMUEtZdmYzWnNqSjl6TlU1eGV0eVp4?=
 =?utf-8?B?WDhRbDdNZVBwN3lac1RYZ2VnY0R6N2FJeFcvcEZMcXVzRVo3TytHcFJNTTkz?=
 =?utf-8?B?K3JjWXdURjBLSm50eEtwOE1aOVpHcjVhZHJLd2lJUmhoc0RjSzdERzRkNUdD?=
 =?utf-8?B?K3d3NlRmRWZuRzB4eFVRQnZNbW9seCtLNGgvQ3dNL1hYSnRPWTNvT3FkdjRZ?=
 =?utf-8?B?S2FiZEpnY0gxTFdFT21mckl0RjVldjBOZzJGUmkrcmhGeWNKa0hsUlFQajh5?=
 =?utf-8?B?K0lQUWcvOVl2NUpYeWZVazRydHBTNUhTR2d5SGgwQkRUZkpFZ2VTLy9WVm1K?=
 =?utf-8?B?bkw3OTFZcUVwSFVCakZpdHN2T3pyQkcvaXZnN1EyVDQxVzZXdUloODdLZHU5?=
 =?utf-8?B?VXZoSWwyb1JRcndLT2F6NkF3dFJ3NDVGaXBtby9zNlRwSTQ3QWZYS3BRajdV?=
 =?utf-8?B?djU0VisySm9NK1RYQnBQZkVpYVh4RGc4cWUyTjBNSUxMaEZWYmYvWTF1bUsx?=
 =?utf-8?Q?Su4XmPcAez6ZPK8re74+R412xiEIgXTIvJ4w0Hs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc95a02-767f-4114-9d60-08d97ef99f1e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 01:21:23.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/il+U8oZVYA7LrPHvvsbFwpSKp2L/XHVVlA56WcazfCpw8NXT1NEadVfId5VjrSfK+xRYrtT/ZJ+rF9w4mL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3859
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109240004
X-Proofpoint-ORIG-GUID: _Zb6AT7RuNBEXZpJgJut7PnvABYODnyw
X-Proofpoint-GUID: _Zb6AT7RuNBEXZpJgJut7PnvABYODnyw
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/23/2021 6:18 PM, Dan Williams wrote:
> On Thu, Sep 23, 2021 at 3:54 PM Dave Chinner <david@fromorbit.com> wrote:
>>
>> On Wed, Sep 22, 2021 at 10:42:11PM -0700, Dan Williams wrote:
>>> On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>>>
>>>> On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
>>>> [..]
>>>>> Hence this discussion leads me to conclude that fallocate() simply
>>>>> isn't the right interface to clear storage hardware poison state and
>>>>> it's much simpler for everyone - kernel and userspace - to provide a
>>>>> pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
>>>>> clear hardware error state before issuing this user write to the
>>>>> hardware.
>>>>
>>>> That flag would slot in nicely in dax_iomap_iter() as the gate for
>>>> whether dax_direct_access() should allow mapping over error ranges,
>>>> and then as a flag to dax_copy_from_iter() to indicate that it should
>>>> compare the incoming write to known poison and clear it before
>>>> proceeding.
>>>>
>>>> I like the distinction, because there's a chance the application did
>>>> not know that the page had experienced data loss and might want the
>>>> error behavior. The other service the driver could offer with this
>>>> flag is to do a precise check of the incoming write to make sure it
>>>> overlaps known poison and then repair the entire page. Repairing whole
>>>> pages makes for a cleaner implementation of the code that tries to
>>>> keep poison out of the CPU speculation path, {set,clear}_mce_nospec().
>>>
>>> This flag could also be useful for preadv2() as there is currently no
>>> way to read the good data in a PMEM page with poison via DAX. So the
>>> flag would tell dax_direct_access() to again proceed in the face of
>>> errors, but then the driver's dax_copy_to_iter() operation could
>>> either read up to the precise byte offset of the error in the page, or
>>> autoreplace error data with zero's to try to maximize data recovery.
>>
>> Yes, it could. I like the idea - say RWF_IGNORE_HWERROR - to read
>> everything that can be read from the bad range because it's the
>> other half of the problem RWF_RESET_HWERROR is trying to address.
>> That is, the operation we want to perform on a range with an error
>> state is -data recovery-, not "reinitialisation". Data recovery
>> requires two steps:
>>
>> - "try to recover the data from the bad storage"; and
>> - "reinitialise the data and clear the error state"
>>
>> These naturally map to read() and write() operations, not
>> fallocate(). With RWF flags they become explicit data recovery
>> operations, unlike fallocate() which needs to imply that "writing
>> zeroes" == "reset hardware error state". While that reset method
>> may be true for a specific pmem hardware implementation it is not a
>> requirement for all storage hardware. It's most definitely not a
>> requirement for future storage hardware, either.
>>
>> It also means that applications have no choice in what data they can
>> use to reinitialise the damaged range with because fallocate() only
>> supports writing zeroes. If we've recovered data via a read() as you
>> suggest we could, then we can rebuild the data from other redundant
>> information and immediately write that back to the storage, hence
>> repairing the fault.
>>
>> That, in turn, allows the filesystem to turn the RWF_RESET_HWERROR
>> write into an exclusive operation and hence allow the
>> reinitialisation with the recovered/repaired state to run atomically
>> w.r.t. all other filesystem operations.  i.e. the reset write
>> completes the recovery operation instead of requiring separate
>> "reset" and "write recovered data into zeroed range" steps that
>> cannot be executed atomically by userspace...
> 
> /me nods
> 
> Jane, want to take a run at patches for this ^^^?
> 

Sure, I'll give it a try.

Thank you all for the discussions!

-jane


