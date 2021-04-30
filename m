Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6E3702DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhD3VUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 17:20:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50178 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhD3VUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:20:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13ULB4Gl103878;
        Fri, 30 Apr 2021 21:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7KREpgsb9McVJUEpPlL8+JPKscvfYu8jGw/dqewVgGQ=;
 b=c+ZsdcORtc+8QPOpsgcHnMcPqHh5TF/JXldsXRmBBu/8UQvPff5Jh3X7JUNkFxBDNERR
 YmXGtk870PZn8DQ8t9IxRLIgG76koD/OgmWlRbPzUs1jsaP/06EEHox1gnJd5p1DW4Xz
 /Zhl0byePeTDPMukkE9tl3ZzXUHyrpZIivAgbFyTkXodTiRrvJmnV0DjgwK0ow3TXf66
 EfPUmCKzMBduG7CKPTXTQh4lDx2d5dr4P/J7n1a0oDMhd+NpuK5K4cT2vX8XsatgzSWF
 92SuIsRnA0i2HMc1WnWvwld4aQsS5Y1WEe2vwGcH8U0X1p45TfgZV2hR6IstgismWxuy CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 385aeq9155-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 21:19:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UL9xLc068716;
        Fri, 30 Apr 2021 21:19:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 388s411c7f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 21:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSSHtIpBKLOZnM2yfvnmUPECsprCbQ3TU10Rx/wljHBglwCqXY5G9hCAMtQoKNRL+fqboJnURpbAOb3zUADurDQDxdu0TCWZF57UMWZVZ1BuYtDrk7ryEfjIb8TaZvv9mZ7lrPWqArLJCj89dYsAT2AnHNRHugxxXzB/E1/mX6madXaDjajhkCMLY5NRnV5ZA5hLAyTNB31d+l3F4Hh15V3wT6AkzNZ+/3c+zMekMjGVZb+fiZ5VhM1wC17rHLL+uGSrXeYzfuY41eWrVImMe7pnqeo0gmfd6tXPf7e8XBFmIMy8RISzyne1b+ljwE1gHUKrFzPvIa+b7+1X47Z+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KREpgsb9McVJUEpPlL8+JPKscvfYu8jGw/dqewVgGQ=;
 b=kT4FR5u9WV6+tACaDOKJNdNizVzFxuHV2neP7dpmWLpqgh4oSW1rxeiphY8+nWmDNJ2OrYG4lCafZLOYGv75t74xVnsFBO+bn4rzDq8t8xqw+6TEJjOD4HG2OgY5aMEibJ4mQnIfiUEOlLpBe9YCHIxMSPi/RQGM91J8gWV+m2J09qI3NY6a15oUBX/Jqzat0gMjHoKE3O7Itc8KnT+/gSZbXP54jo0b3VKS5BfFk1/b09IwEriMm0nPG5JKiWZvi3vuJLMY+vR6OGCe9NtD0PLyCi7N/z+UQ2JaNqVGJ/wek8y/jC6oeABFBplFE8+ugwile4O1gBN6J0fxK98/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KREpgsb9McVJUEpPlL8+JPKscvfYu8jGw/dqewVgGQ=;
 b=QwWUOFG/Ole14qYIkfise8vXThf8pdQVYHZoNCi4lzI58trotMzWPOGVZFphQd3k4ruUHMkhROBC0rTq1kq6ll0oFyfm+KcMHKQgVYXuE+v/YsJcRQ+QpKfME31/M+cg9YMNZrkMDJwtP92Fl4OKFQVIITVRqkSb6dxV7xsUKoY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB2632.namprd10.prod.outlook.com (2603:10b6:a02:b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 21:19:18 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 21:19:18 +0000
Subject: Re: [Cluster-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof
 writeback
To:     Jan Kara <jack@suse.cz>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>, ocfs2-devel@oss.oracle.com,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <CAHc6FU62TpZTnAYd3DWFNWWPZP-6z+9JrS82t+YnU-EtFrnU0Q@mail.gmail.com>
 <3f06d108-1b58-6473-35fa-0d6978e219b8@oracle.com>
 <20210430124756.GA5315@quack2.suse.cz>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <a69fa4bc-ffe7-204b-6a1f-6a166c6971a4@oracle.com>
Date:   Fri, 30 Apr 2021 14:18:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210430124756.GA5315@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-227-62.vpn.oracle.com (73.231.9.254) by BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Fri, 30 Apr 2021 21:19:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210107aa-c664-4f86-e8f3-08d90c1d9d50
X-MS-TrafficTypeDiagnostic: BYAPR10MB2632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB263203A9594C867FA80AA7C5E85E9@BYAPR10MB2632.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFB83sxsjFMxII6+ZfK7nnTvBIplsAk7xkGaCtYmJDRgDUwrnTQlqpMSmmyMS8RlMr0HJbkpWZ/Ki1SyUKo7SIBsGwFYUYFtE5olBzk4zsPTuu/7NGfFcIal0w+bclBLDYA5EY3OanVNa35NvJjngzjgy4stiuSmpFGGjO95JJdXjOS1YwJ18spGIUOi7Hi2hIsS/bGeLYClhrDYbJPBzx/oqzlsDMuXFYhYC1RQDsUvC31/TWBBCgP33R+RXRgKE3OCaj1wijqL2lpPUcBSdiW/iHoEkPBX3GovILzPEhexB4p6zBUC6oRPZ1b00d+KU7ZrRu78lEgoFnQ0ThOGoXhZ/2bCmc2ZsdZV4LQ4q4KJ4jVO46rOt/Cc7wA17oyhjGlYCqxicfaKVdOmW3zMtZByjX9zRhDtF+Hf9yNiwZqf+sMDH0Pr0kfQTAILcFqat4bsGrE8tk0iCWhDnz1cAlP7qOKR/LpcxwAmJGV6gP/MlmKU0Xt6ZBPZQiLnq4YQ7j91fkIrTeGz2lN/l13SM+8mSBJv9IXrhTQkhEmRE+faqzrxPbNdhoBDAin0cLu+Vo4Z+YhjOktEzt56E3lUcMFyu8JwmrjNDz1Ehtl/eT1wfDQ0MsKUKWT+4sh6BfsPz25xSmDW0Gjp+tIe1e91AkEJW1dSWCARI2xLr0sI1nnJDbudzq+IFZxRTQ9dkp2L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(83380400001)(53546011)(2906002)(6486002)(66556008)(86362001)(66476007)(8676002)(36756003)(66946007)(5660300002)(956004)(4326008)(2616005)(7696005)(6916009)(6666004)(478600001)(8936002)(16526019)(31686004)(26005)(31696002)(38100700002)(54906003)(44832011)(316002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QzlSdDJUL1lHUHVaVlVoZ25VM3p1dXhhUlYxTkNsSXg0UmM5a2lnS29MZWRk?=
 =?utf-8?B?MndZTy9FclhjZVZBakVQOXZJSzJBYkhNcUluMDhEZEMzR08vNzJyaFk0VzJP?=
 =?utf-8?B?NGNZN0lYN3RDY0w3Z3cyWkNkYTBtaGlOQkpqTXFFbGRhWU9BRlUwRW9jSk45?=
 =?utf-8?B?SlJOaVFVdEFHYVk1VWdyTk5SWGJFV1ZLc3ZFbjVEYUQ4TXd0TzNOd0EzNE5r?=
 =?utf-8?B?dTFDbFFuOWhuc2Vxei9BS25ZZEkvYXRnSWh2d2V4YXVVWklyWitYNzYzRUp1?=
 =?utf-8?B?akVoMG5OY0dCRWZSVHZNUWFjaC95OWxRMHI5QTB4akd1MGltRzRwY3RJb3lu?=
 =?utf-8?B?ZTFtUTEzRytvMUoyM29NS2gxdWF1NFpWelFWZGY2MkRzMlBVU0lxWUFBSUwv?=
 =?utf-8?B?Lyt0VFQ4b2paaXVIWjFKcWFWc29IRmVDWTJNdGZUSndoTlVMNno4dXhDTjEw?=
 =?utf-8?B?QjNEbmhMTGtkRHUrT3pNVDJKT0VrZUxpcUZFcGdsTEYwRFlZbzB3eThGV0lX?=
 =?utf-8?B?SkljZmttUXlUUDhycjVwUUdZeWd0d203bVQyblJYeVlqdDFrLzdiUm1HWXNC?=
 =?utf-8?B?WjIyVFo4ZFVHRlJGNUxLZkJ0TVBLeUsvbk13c0k0ZFpaVDdnSTRwaFVOUE9y?=
 =?utf-8?B?cVg4YXVjWWFQKy9YY2QxVFZ2UkdFUFlNL0tzeUp1TXVheG5TNmltbjg0NEl5?=
 =?utf-8?B?dGI0THk5aTZjQ28wSnhwT1B1Q3VnVEpNSHlxcSsyeDNqYTQzdVF4R25Rd25n?=
 =?utf-8?B?eTdNeHNVZStoTDlnU2xOcERTZFpBaFloT0MrM3h5cXU4RXJMZUxUZThsRXBJ?=
 =?utf-8?B?bnkrZjNONkJPWFdLWkovczVBMWhISjVPNTNPcytOMWM1U0l6N012SVV0QmJk?=
 =?utf-8?B?b09hNHYyOFNkZHg2TW8vN25HZXU4ZVlPMnp0eUxvdWlLbnJZV0lJWkowcUlU?=
 =?utf-8?B?Qjdubm1neWJlYWhXcGFYVHhRTFd2ZGVaT0RDQStSNGZHTXdYSndnUkxZU0hm?=
 =?utf-8?B?TWZLRUNMVFFEUjAzeWp5OTNPMnFjZlBpNU5EeXhRdFZtcVo4MkhzTlpIa2Fs?=
 =?utf-8?B?S1RCTVpURGdmakpKMDNINDNEOHQyd2ZhNEkrSGNQT29xZ1M0NHpiWnpIM1Jy?=
 =?utf-8?B?MUh3ak13VWxTOGh1SFBjN1BNaFJkR1ZqTFFuUU94QnN5WHZTVTBVNlNKOHgz?=
 =?utf-8?B?SnpFdUFGKzV4UGdQVXQ0ZzNRU2dTd3N3N1lQcXcrL01OV21LcHRqRjRuSjB4?=
 =?utf-8?B?WkVaNGxRWVJVU0JvRExoc2luaE5VY2NUVndRQjdsSndlMnF1ak9RaUJOT0tJ?=
 =?utf-8?B?VGtyZTF5c0xTRlNXdFA2N1RPNjZBdVV0TmtNOHlseVhDOGk0WEowVFYrZUV5?=
 =?utf-8?B?Si9CTFpMUFdyOTBWTngrWUpzbnNlbTJVSURQY0o3SWFDRnYwM3R0SGNNY1F5?=
 =?utf-8?B?dDV3Wm5ZNW1LQ01GQXFxVmxtTW1wUXFrRVRIK2RQUnYvY1NvVnh6c2YzRVAz?=
 =?utf-8?B?ei9TdzVkd2I0QzBQRmNSSmlva2RxZXgrSFlRZk53dTdaT2tkMEsyYzFtb2FC?=
 =?utf-8?B?TWhlZmFiay9kcHZJajZ0OThsK3BiM0s5REk5SlVjazROdjBCOHZ1Z2t5UnYz?=
 =?utf-8?B?VmgwMlM3UG9NNjJ1cVF3USs1NTBURXlzR1lpbnhTWGJjdTFoSk1tZ0tjbEti?=
 =?utf-8?B?NTdEeHIySFRpN3BhQlBoZkZNdERuS1hOc0lCaFVsSGZ2KzNPdnROSEVib3Nn?=
 =?utf-8?Q?mYZ8Aeqd/cDJErwJCy87miQTCBioEi9Y11jZHm4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210107aa-c664-4f86-e8f3-08d90c1d9d50
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 21:19:18.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TznfTj39CDQx77AxWj1vphPpxFv7Klqbp3ISzjgAQTxEs8mFhgBXD0iF2viHxh7K7kRz9IKEmW/XdXQqCE52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2632
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300149
X-Proofpoint-ORIG-GUID: 2gjyF9MMw5Rnechfm5Wl52B0LQtWOSkW
X-Proofpoint-GUID: 2gjyF9MMw5Rnechfm5Wl52B0LQtWOSkW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/21 5:47 AM, Jan Kara wrote:

> On Thu 29-04-21 11:07:15, Junxiao Bi wrote:
>> On 4/29/21 10:14 AM, Andreas Gruenbacher wrote:
>>> On Tue, Apr 27, 2021 at 4:44 AM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>>>> When doing truncate/fallocate for some filesytem like ocfs2, it
>>>> will zero some pages that are out of inode size and then later
>>>> update the inode size, so it needs this api to writeback eof
>>>> pages.
>>> is this in reaction to Jan's "[PATCH 0/12 v4] fs: Hole punch vs page
>>> cache filling races" patch set [*]? It doesn't look like the kind of
>>> patch Christoph would be happy with.
>> Thank you for pointing the patch set. I think that is fixing a different
>> issue.
>>
>> The issue here is when extending file size with fallocate/truncate, if the
>> original inode size
>>
>> is in the middle of the last cluster block(1M), eof part will be zeroed with
>> buffer write first,
>>
>> and then new inode size is updated, so there is a window that dirty pages is
>> out of inode size,
>>
>> if writeback is kicked in, block_write_full_page will drop all those eof
>> pages.
> I agree that the buffers describing part of the cluster beyond i_size won't
> be written. But page cache will remain zeroed out so that is fine. So you
> only need to zero out the on disk contents. Since this is actually
> physically contiguous range of blocks why don't you just use
> sb_issue_zeroout() to zero out the tail of the cluster? It will be more
> efficient than going through the page cache and you also won't have to
> tweak block_write_full_page()...

Thanks for the review.

The physical blocks to be zeroed were continuous only when sparse mode 
is enabled, if sparse mode is disabled, unwritten extent was not 
supported for ocfs2, then all the blocks to the new size will be zeroed 
by the buffer write, since sb_issue_zeroout() will need waiting io done, 
there will be a lot of delay when extending file size. Use writeback to 
flush async seemed more efficient?

Thanks,

Junxiao.

>
> 								Honza
