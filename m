Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A923FDFB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbhIAQVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 12:21:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51422 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245229AbhIAQVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:21:00 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181FnO2A010491;
        Wed, 1 Sep 2021 16:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=81CVOkDvOYzBcX2nuN7gg4GCc82vu7HwjTJyy3a9VjA=;
 b=O2uilR8sXZc/HDAq54PjJwEALxlz76d8o5dCyca4dPzh+fXbl9ugvrzqeUuUXUA7yvq5
 8ctsOuhL2EN3i6Q9fW2vgj6CpVuCaax+4NiSZCmDoeyE0CyA+nmnfoiSe9L/yzvx1tXW
 EHaokb1sskI5w3KxprOhHoU+EgDDmIv/QnW9A+U6FQlJsiYfDtgrtl3JMro7r3Iarsu0
 5w1kkXe9O0ME+cOhA/+Tos7wtJ+Bemlz2US+4RUSEkUWMtZdK/2HPRpY/PPADMBmLqt+
 hirXO1S7qYns3IR/m4bUKe9GuKN0r37TSK+wwiS7Rm5Sq1fNeUdRBk9MGcrmV4lh4TuB Ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=81CVOkDvOYzBcX2nuN7gg4GCc82vu7HwjTJyy3a9VjA=;
 b=eIbBCf4IK4Q8/gzFKwex/xghWONpZRtPq1y92DAs08yUF1WMOC6Rn0m6/vPDNL1I1zTw
 kUWHWUAR/d2A+wOZRT3RqeYpSZR7nXHbRMGNCN+zEqqGwm+a4dwd+ogVO+n05BGrFuqH
 CIrbJwqhI/r0mYwB3biewnZAkv5/Ua6RBH/zPZFUVpDGkw8fo5KI0++t9rPA+lyWWiqP
 z1+W1hIQtlPPXq3V5cV4W0AoHfKl3cVI+XtcxlRhK7AitOGrdBPDLCJWWOZsuk9IOUfM
 X4RrjhzsWGIUWSKRfOZroiuLxC8AYkukBcxVCU2AmsV5h6WRLuDH3XJK+iD5i1Ef6kTF 6g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mn5ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 16:19:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181GFreJ129427;
        Wed, 1 Sep 2021 16:19:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3aqb6g0n9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 16:19:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpI3JqOW5UuRg+NNjhbSz1YzvYCJJb44GA3IiyAGZW5pwaJger2kr7ukJvSJTVJJxaw0/cOaKjJpXUMZz+zWuMopO+AfhlwqPf6dWjAdi+jh8HwmDdhGSXrTv92+U+S9XIYX2kj2SX9ltkGf4+8sV9mKdu7bqTp41+vtXgBkvJgCk8j5Q0g4rqsJE+XrHlxtFzy/WIJRYRJinIpuSXxUTCZ115a08jtvJqdAdgXO/tfEMCSa5YQf3ZzICW1sEc7nKPB16xgrjNLft1j7pbKk0+R7v6Fzpp93R/z8WF8Ux8BGT31a2X0zPwMGlB75cDVUmKmx31lZad4fCU7m7Z2fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81CVOkDvOYzBcX2nuN7gg4GCc82vu7HwjTJyy3a9VjA=;
 b=ZFsd77vzugq7O/UmkLHlnAlWk8PGsrKrqtY1uhuiMHbA2J0MJ83eubBJ3RZgeqD3aEeBNdhAZOmUYi5N3ZiKrWx+tQNdnv/J57lw8VGa8pIYL2sgJAfD0wr5McK7cW9OfQk4i9Z/L7h4Pweu+MEMsvQOQqrsMeXfJ2U5WUzuxQcYaG4Y8CTT/aFxaNC3LkjwNBkbuma6QJgmqqa5T2TrCQgMl6IBlgXiDB5kIwxIuy6Lv8pieM1gudIlrTM+fNYuQPXVPbSvC51ffA+zUh+POpBbIvsfvIMrSLAMCssyDShyHzLVuXJnx49NUNYeQMfSjnxT50kuROjU0sK/xEOaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81CVOkDvOYzBcX2nuN7gg4GCc82vu7HwjTJyy3a9VjA=;
 b=J6FMQvrGwJqy5MfRfiG0Uqv2oSZy5B1xtkg7s+6cljbVAQGS895LXGZ8i8FldAFhRUG7o6ygFxeeHmMADdOH8S1XJG0fzFIqADF3Ytm3fP/UC91WtYbjopB6pobe0i4Hi1+irwEzupNWtx1ZkagH+fg3Q1yxgxYHY659w/5qCyM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5066.namprd10.prod.outlook.com (2603:10b6:610:c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 1 Sep
 2021 16:19:34 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 16:19:34 +0000
Subject: Re: [PATCH] namei: get rid of unused filename_parentat()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901150040.3875227-1-dkadashev@gmail.com>
 <YS+csMTV2tTXKg3s@zeniv-ca.linux.org.uk>
 <YS+dstZ3xfcLxhoB@zeniv-ca.linux.org.uk>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Message-ID: <f6238254-35bd-7e97-5b27-21050c745874@oracle.com>
Date:   Wed, 1 Sep 2021 09:19:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YS+dstZ3xfcLxhoB@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:806:22::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stepbren-lnx.us.oracle.com (148.87.23.10) by SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Wed, 1 Sep 2021 16:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a72b2e3c-03df-4d7e-ed6b-08d96d64494e
X-MS-TrafficTypeDiagnostic: CH0PR10MB5066:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5066AE79139E170EFB514364DBCD9@CH0PR10MB5066.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAY6WdUXF6vr5YI+3Ss48L06jTj+xyqatvZJdMlLNCooBj6CnwxS3JGzxSiiWmqDvjtW89C4heu8T/ErjpgVITym3nqpQwlD8v6iVau76vz8vt44U6sYrlyjXRxKy2vzLIesJhvJHVpkmmhHu8Qs56E9Vob35uu8OY4BQCLjs9ZBF9o58z5g++6dFs3XgY9qFGsOCKXCtxuNLIWcFoSQpVrei5gAki6AT2OhwQGjgcXa4luJTNM7198NB+pRGU7RWBfxJBC1SW0LBA8tm0Py/c52QDEidod/jcFDxxnCLXXFwLbGwyr+Cc3sjWNZlhX1sDjHRNPDeIwUCE64zscSq6UjunTqv4Iw0RwpMmCNPrOeqk0A7UkMPasgbHciB3QBTXTSV5LCwt7aAhwDZOfuAjAahAmTTDo2MtDdaHYF/TzAPZPnBk191j/DF424MFy1yl/UM8KYn2fuuXgfcFlWLSEqH9ltcKSW+v7fRLnXORQDnK4CqfPdLYMWKd6FOkQNP8AK8KW6E4U6J6gUhuF7+MZR9fylV5M1Ylo9m3DKJhtxvYUeoOXaxh10wl6iaKPlTEZZgbsZoaCPHimFz3QiuSe8yu4uKDi8ZikxdarnoF3mWqsP4Mk6zlPbmXxvZaQA07be9WXOUZ74OeJ3ogGZHDqARQOUu/FEp7gXXW2O4ySrJgQnLVBD6MdN8GC4NbN7+T1alOUxH7qzr2rmmOkNCb6FWSAzN3mOSVOgoX/rf5kgHDKxd5ifa6f1H2/Y00j514ztkcj8MSZ5VwSPiw7nqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(66476007)(26005)(38100700002)(5660300002)(478600001)(86362001)(36756003)(31686004)(66946007)(110136005)(186003)(83380400001)(54906003)(2906002)(316002)(53546011)(8936002)(6486002)(956004)(8676002)(31696002)(66556008)(4326008)(2616005)(7696005)(26583001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG8zVkl4MHNjTWNxTTF6VjdwTmpxUm9HY0czOTFyRjdkVTY3SDZxTk9KWFlU?=
 =?utf-8?B?QlFzWkRaKzRDL3VYcUFBTVVQS1ZiV1hCbStGKy8vMHRLbmd1QUJMU21jN0FE?=
 =?utf-8?B?OG84T1BuRnFTVFNkUWU2c0MxaGNBTEQxbXZSbXFVUW5IVDFpNy9hZWttdFVD?=
 =?utf-8?B?ZXl4TGxHOXpQZjVCdTJqRG5qdFNVTHY1dE9LdW51K1lWa0xqek9FTVdDS3RQ?=
 =?utf-8?B?T2FzRmNqdmtDMDRTMjB1M3FlczBzdUY1a3pYUlkvTDZJYjlteENUakF6UmUx?=
 =?utf-8?B?M2JUTno4N1A3T0NhN0cyNkVTK0s4UDVCaFcyZUpBV3ZrblFzNVl4YVVObDhz?=
 =?utf-8?B?dVptNHVwZzlYaU9JUXgyRHFrbDZTOW5tVzR4NW9TUDFjRkw2R2dCQXB2eXdD?=
 =?utf-8?B?VU9pRHQwb24vaGo1bUh6YlBBZ1FRZnh6QndrVzJMYTU1UmhYaVBrTXVSdTlX?=
 =?utf-8?B?UVdyaWsrQWlzMnBPSFZUM3NYNkozL3JXM3o5UXJEOTNrUy9wVVhSRm5zUjRa?=
 =?utf-8?B?cG94Zm9VV0Y5N3pIeUJickwrczgydDZUdmlFa1o2VDh5dDBNK2g1anpvUzhE?=
 =?utf-8?B?Uk1QQnhxRmN3aExQbmRybXI0WEFNQjdpQWJSbHRXajVEQk9tcEJmbEdtN2ZU?=
 =?utf-8?B?RmRuUEE1eGtNeVhWdXhDa3BsRS94SGZaNHZZODdFcDRkb0tML2w1eGFVQUx4?=
 =?utf-8?B?WDE2Q0RsS2FqZHZzbkY0Z0VZZ3YrR0JzbS8zT1kxbkhlTWd2bG5XYlF1Q0ox?=
 =?utf-8?B?SHdoMXFnZWRIQ1ZLeHlHV0w0Tk9BTG56Y3A3dGV1VTRoK3hEMW81cWNteDdi?=
 =?utf-8?B?VEg0bk9NdWF4K0QzUjBSWkxFaUw2aWJmd1hxbDRxOHo4cWsyWGFHbUpvQ29O?=
 =?utf-8?B?T01YQ0ZWdWVvNjQvYUpKNWd4WGJkeXQ3MHBxcWZBc3o0QmZ1YlA4eEtYMWlY?=
 =?utf-8?B?a2t6Tzh6NUcxd29meURVV0FzZ2ZRTSswYlRsa2hGdFhxdVlMdC9NeHl6TkRh?=
 =?utf-8?B?MzYveWFKNTgzS29nTzJSOUk2Qm9aSEo5T0FoM2ZCUytoVEtBZWhMKytKL2pW?=
 =?utf-8?B?NFNMblN5RmdzUGRDdExPMnNINDdDa0kveFg4d3J3MHZLM3FDbjFlaWt1M0hj?=
 =?utf-8?B?R1pNZWxtNGtXMUN3RlBOWFFNMnNFOGgzbjAyL2dDTW5aQ2ZRVkoxcXFuZ2Z5?=
 =?utf-8?B?b09RSEVmNlErV2paYysyQ3pYaDlZdm1DZExrMm5UdlR0K1VTU1ZmWnlGKzdL?=
 =?utf-8?B?TjNDUmwvZDRNdmZPRC9QcHhqd3R2a3NmM2x2YUhyeWxIUnlDeWZlMVVxODZP?=
 =?utf-8?B?THc3TlBuMVBST00yMDlxVUNjM3htRVVsb2lXQkdYQ3A4ZXlaSFFBcjRwZ3RI?=
 =?utf-8?B?UGNJVE4rS1BDekVqNjRDODZDWHNJT1Q5elZvcjJXeDYxNUV2djl0dDFmRkVG?=
 =?utf-8?B?WFMrYXpld0o2aU16Y3dVc0R6WHkydW1LbGVHVjlyRVBnRC9sOU55bXd2NFNp?=
 =?utf-8?B?NnNPRHhibzZJS0tKRTJlaVFmZkxQTjZib1NLcWUrZU9vN1NRVjhvRzlPenFw?=
 =?utf-8?B?V1J6Mzdwa3VlZjBBeENKd0FjTlo4WGpLMkZTNVNTNkdYMTMvaEJ0SVVsTWJ6?=
 =?utf-8?B?eEExcVBYV3NrVjBTdjJOeE56aHhkVlQ0M0x4UjVxQ09mMXVOVXZWK1dmRkh2?=
 =?utf-8?B?VXcySTFESHdsTDVUaFVJcWZUL1dGN0VQK28xOFo1Z3dYeFNIdTh0UXlhQytC?=
 =?utf-8?Q?7OE8V40T+WZy33IGfnNi3/hFpzgpE6I6Eja0qrj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72b2e3c-03df-4d7e-ed6b-08d96d64494e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 16:19:34.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8B6wypgs8MvTM9dKDC6uqF/ODcCNCOdRZGFKEKQX7SK4RLc2DMkz+6jHn62lUCO/Q56jhirqTyEyPPBkXSOvU/osUx/Yc4g6w0tMsuhQ5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5066
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010095
X-Proofpoint-GUID: Y0hWBgA5nmhcSiDlFF8bBuv1rsxy1Htz
X-Proofpoint-ORIG-GUID: Y0hWBgA5nmhcSiDlFF8bBuv1rsxy1Htz
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/21 8:35 AM, Al Viro wrote:
> On Wed, Sep 01, 2021 at 03:30:56PM +0000, Al Viro wrote:
>> On Wed, Sep 01, 2021 at 10:00:40PM +0700, Dmitry Kadashev wrote:
>>> After the switch of kern_path_locked() to __filename_parentat() (to
>>> address use after free bug) nothing is using filename_parentat(). Also,
>>> filename_parentat() is inherently buggy: the "last" output arg
>>> always point to freed memory.
>>>
>>> Drop filename_parentat() and rename __filename_parentat() to
>>> filename_parentat().
>>
>> I'd rather fold that into previous patch.
>>
>> And it might be better to fold filename_create() into its 2 callers
>> and rename __filename_create() as well.
>>
>> Let me poke around a bit...
> 
> BTW, if you look at the only caller of filename_lookup() outside of
> fs/namei.c, you'll see this:
>          f->refcnt++; /* filename_lookup() drops our ref. */
> 	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
> IOW, that thing would be better off with calling the current
> __filename_lookup().
> 
> Might be better to rename filename_lookup to something different,
> turn __filename_lookup() into filename_lookup() and use _that_ in
> fs/fs_parser.c...

The value of Dimitry's original patch was that the calling convention 
(i.e. whether the function calls putname for you) is clear from the name 
of the function: __filename_lookup doesn't call putname, and 
filename_lookup() does.

I think what we're discovering is that maybe the double-underscore 
version isn't all that useful, and can be quite confusing (leading to 
refcount increments like we see here). It's highly unusual for a 
function that's not explicitly a destructor of some kind to drop a 
reference that was passed into it.

Could we just standardize all of these filename_xxx() methods to leave 
the filename reference alone? I see the following uses:

filename_create(): 2 users in fs/namei.c, trivial to change
filename_lookup(): 3 users in fs/namei.c, also trivial
filename_parentat(): only user was fixed in my earlier patch

The cost in each function is two additional lines, in return for some 
clarity about the calling conventions, rather than creating more confusion.

Stephen
