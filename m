Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229EE36DC9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbhD1QCE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 12:02:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbhD1QCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:02:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SFjQq6129494;
        Wed, 28 Apr 2021 16:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oWr5/EjPmgh2D59GC0csbcXjhvSjlXIb8ispExuWs7I=;
 b=On/MplA11NSZ4cANB5dHSkAd0jcuEJTr/c9Debc4+UFatSIacdcFpCpwqUvyaBkAz8Ng
 GAv16YM3BCQFD+HRSvHDuFXs1ALvV6Gi9U0baaxAlym+qJAzr/2YKzjCzavclTYCoNay
 As/Rkc431JanCiFNtXqcdAWi7Cm/xxPrvCIf0pirgfSdDgagJyz6Vr580+dGxHdBx8zx
 eNmQxyTmE4DT6fwHJdHYR5a+ooIREstGvAUTRxxvPBd6bQQhTS9OYrOSi+jN6wrtxKI5
 NAmOBMXofnoiFWM3d3CDl9fxylH0mX1oPvEhWaTUL3SfIZ/FqtqEuTJHnNbd5Tvvx15X ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 385aft1b27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 16:01:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SFmBwI105882;
        Wed, 28 Apr 2021 16:01:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 384b58rv1y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 16:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEm1oyoPIbQrDEsMc+KPnuf2gmS4235xnZW7l4/3bv/ljFfjGqyN+5pcVpNAXdXkiyrbtljBRxDQu1VP2H5KefCdsGl/k5e1DsoyCOtvWzrXPcYmp3r4o52IzbD1nFOXaZ2ouWmiGtkfkE+mV0XHAsKOAdZtjm+mWFFGA49VnVdPnkx7RKw4OMDMRRI0/pjlnYYTqal44CJXPKrRU+qzxgUDWpNsA5yG+yBPTlNvDS/hikMCF8qTr7zmxdeP5UpD1jPLbh/i9mUja2Rq1kOPIQgJJeRhgS3tOaK6F1gkPXyGUmtALoplDznBjXVvX/b5kXn9HO0D7b1aFVr5+dvO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWr5/EjPmgh2D59GC0csbcXjhvSjlXIb8ispExuWs7I=;
 b=nfyqcTYZoFYX0NL/noMFSueWaLzF/sKjhzIztrBHX2SiboEhUztIjq6a3dCW69d4wRt3L4gaFafsptnSSmHBJAJc7LpJlgJtNRn9Ymwb5GzHG6Wjxr/HPOrPLVgLElDVCOZ1TnZeMRLvFjHk/gNbtzsI2Kd5N84aYUYZ2hT52Pcabr0IC8WDp40pHGb8puCi5+/G3RAZ7GkbdldkHoZ2aIIuSAwfSQ5NMGx3s1W+zcDF4YHZu+DzYEt/OkJBwCUTWaj4tHuoFFJOc0GQJeP/W8pyE4OyUjWlAUCQCYV2aMgN7nn7RMZD7tkLhU5IpkTCvjvxNcF+L6Hu8rJO1mkOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWr5/EjPmgh2D59GC0csbcXjhvSjlXIb8ispExuWs7I=;
 b=QvuaGu6Wwyp1ZJfqtFc31J3hxlEKiJhq9CCdVbL8iePb9dox4uxDtrDg/ffcVGLuZSeKVcpvKmoWxr9SCUa+WYvw1k78KhIwuvAXmUrZilBb2cdwlwlBXRDC937LpvZ7j32iQl04LUlxJIgGgDSjkCJXKDfCDsXks8DA8qr6iHE=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB3574.namprd10.prod.outlook.com (2603:10b6:a03:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 16:01:07 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 16:01:07 +0000
Subject: Re: [PATCH 2/3] ocfs2: allow writing back pages out of inode size
To:     ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <20210426220552.45413-2-junxiao.bi@oracle.com>
Cc:     joseph.qi@linux.alibaba.com
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <9aeafe69-0bf2-f4cb-431a-1cb4329a178c@oracle.com>
Date:   Wed, 28 Apr 2021 09:00:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210426220552.45413-2-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SN7PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:806:126::32) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-154-52.vpn.oracle.com (73.231.9.254) by SN7PR04CA0207.namprd04.prod.outlook.com (2603:10b6:806:126::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 16:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472ccd39-0bb8-4576-802b-08d90a5ed53f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3574BFF2216FEC68DFD08E33E8409@BYAPR10MB3574.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eI1i3d3wplmklH23e01f10mCru2inLQJahPmLowewchXIf7sybuJ089WkMvlN+6pFHnbXE5m1VZhzavdH+XiWle1nu1nWAEcAoHSea223cd7uElOdbpDvC12wgkWoonjMV5pcuKv1AqPEmX3AUtbKenSBK7DHtkiBoC78hCfrB0UEd+AukeMusrjqf7wXU0DXDrbsqa8yNjqeCVeLzDGa1Irhzb0eaVCyO7A/9/+ASawnnP3Q6TXCs38t5KQXSYINUYwm1dUtorp1h05FmZR6wnqt17sMN7NEQJS7tt59bFGS9u3SESps6XghM0uTGI6ZfmLQqEk3D+oYuPqeOZre9CCMOKJsdgMIqb3wMKEEsSHeR7SfWT/OV7+FzaFBVF60wzfNZsZ+xD2wRmZBmgcm7FnJrdhl7GYzSt5ADuyEaFGGBDZj445QyHPa8lssG4fd1sRiogEzVAyKwhoGVynS3tAImj/b4Hv9+qNvbsKBAl0L/QybV5BFCvOBq4VCmnJ02zqc5yKiMmGctKzqSg19mUM8Wcxn9arTRLafy4OIs0cGYWTZWMO0167baEd9LOYw+AK+n97BK7S6u+Q5wSV19wROACR0xddMgyIGIGc6iBqDNASw7v0pJ5GdISCPra+V5Gu14o+biFY5rJ5nc54hudC5KpVwj9T/WFQ6zXucX23/yqrlUkvLDxM2uEFUg7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66556008)(26005)(4326008)(8676002)(498600001)(38100700002)(2616005)(16526019)(66946007)(6486002)(186003)(956004)(31686004)(5660300002)(53546011)(8936002)(31696002)(44832011)(7696005)(66476007)(2906002)(36756003)(86362001)(84040400003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGF4K2gyUCswN2g2VlM4NWUzYVpkK1dIemQvd1gxdlVBbC80cnJjaEVCT0JO?=
 =?utf-8?B?UXU1S25QdU1XbEZtbjJQc2V1MzhOS1JwbkZSd2QvOUZqK2t6M0RnWHlmd0JO?=
 =?utf-8?B?alhZYmVBSitTdWl0eEFhMXlpOXF1TWxGMmpUdnZzVTRDQW1BK1RIazg5dlVH?=
 =?utf-8?B?aEE2RjFsenRza1M1RmVVQkx5Z1k1eGdrRzJJQUxRZ3VJb3l2M2QxdnR1eXpr?=
 =?utf-8?B?UzIzRkk4ZjFtbHZLUUozdTlTYWpkVDd6SXFQUlNhdUY2MHpNeFVnbzhnc1Fo?=
 =?utf-8?B?bUhacVVydExxbGtZa1NZK1pRUVkwT1FXMmRua2ZwczBWcUlNRExtYW1SM2dK?=
 =?utf-8?B?YjN3NVIvWjM0dUkzc2xLVnBqeEdITWJwOTJ1eDNxSVRmc3dCQ3hWa3hzNXpv?=
 =?utf-8?B?WjVZVDY2dUd5K3hTbUVreUpNcFo5ODF0d1dIZ3BjMW5JZThjTVcrcDRjWEZ0?=
 =?utf-8?B?ZWQ1U2JHV2Z6QlNmcHRiY1NCSEo5c0JBOXozQVdYckRCaVFJYkg5T1BxRkls?=
 =?utf-8?B?cEE1VkY3TXQ1dThUdnBzbldwNWdyV1AvYllnNTRTK251blFRRnRodDI4VXlo?=
 =?utf-8?B?T3RyaVptZ0prT2g0R0JmTzRnQ0lHWk95QWxGOEFZUGxlQXdZV253Vm55Y2Yz?=
 =?utf-8?B?QTF1aFJkWVJ3bmJNeUhxKys2UytJa0lFS0lxUWtibFl6dnZTanU3eGhtRUxO?=
 =?utf-8?B?bmM2VUNVdlpjaXhDNkUzMXVsazg2UVVya2hUcWFJN1Y1ZG9Tc3Zrc053N0Nq?=
 =?utf-8?B?VHlLbHQvcHQ5OW5yUUxXYWRsbERLSUFXUHVVbEtNN1FNZjRJellEeWhab0FZ?=
 =?utf-8?B?eGNPTUZ5SWgyNzNnWjJ6RmtFN1hwWGNoRFd6b29Ka0ZrekNPWitTNG9iNEIx?=
 =?utf-8?B?K0dtbmRoYzJOWEg3eEQ2R1hvNVZyWkFQWUpNWEZmOEY5UUlyZ09USHF0SkUz?=
 =?utf-8?B?Zkt1RURacFVhaWNnbmZsQy9YL3RYb2xrVm4zbDVhVlR4SmVpSEJIbS9WS2Nx?=
 =?utf-8?B?cTh1bi94a1JDSHE0NUlJWFdodlp3ZEZoVmNRNWNFdGxoQ2FuNDhheURtb0tY?=
 =?utf-8?B?WTAxbHZFTFRPMTBVQTlWdnIvQm1JNUNmMEFwYTlvOU9mUUZSdlFZV2laNnpV?=
 =?utf-8?B?SjE3MnoxT3BVNmRzRjVMUHY5b1o4TkJOakVmTXFGOGJSVGNxS1JSY0FscWND?=
 =?utf-8?B?VC8rQ2p4UzcybW84c3hxODkwZE13dGIxR1JDMUFrS0xDZ1J3cWhaRTE1ekJz?=
 =?utf-8?B?U3hzeFdReVk5TU9EaWxNcnA5dEhuVk5jZUlmMlZnQ002cy9ZMGdUS05xRmJZ?=
 =?utf-8?B?dHliNDQ0VkIyWmpQRWJxSzJSYVMrQ1FSLzE5SituRnF1SitjS2U5QVk4Yzhw?=
 =?utf-8?B?V0VOeVBBTWtUdXZKb1IzQkNJMnBXM3lrMDNvWHNlaTdrcEdxdk5DU05TVFVI?=
 =?utf-8?B?V2NhWFdQS3VKZ1IwTE03b2Q2amF4M1VsQ2FTbDcxUVZsZVdKaEVEQWxTQk5y?=
 =?utf-8?B?bGF1Qm4rZm8zSHQvTk44VFBpRmhEemJsUTRQU29HWEZ2cWlYd3lmeXVsUzBt?=
 =?utf-8?B?THpDVzhiUTEwdWEzdjZ0c2FicFBYWm5PajlpMDlTVzJKYldTWmR2RzB0ZXBq?=
 =?utf-8?B?K1RIaXVaRVpPUWdmM1lyK0lnT2FxekhnRVNCRkorbFk2WVFXbkJyaVpDUDJC?=
 =?utf-8?B?bjlTNmhwQ1pvVGJManhkZFdRbjk4NjdSN1pKZVlWZzl0QUNnN3ZvWHJPTGZy?=
 =?utf-8?Q?QEZV3egTFAYJ0wy+mKjTdRqY/Rf37T0myUeyOLw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ccd39-0bb8-4576-802b-08d90a5ed53f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 16:01:07.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z9NQiEs0hTnuMEdV/G5qpqvEBFKL15grlvJ8D4A1iAaCXucz3ZbqD7xJWRaQ5GswjGFKfrb5/HVDXIRuAE4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3574
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280102
X-Proofpoint-GUID: yCLMS9TFTO7cqYWCNnXxC5ssFXQJAlC-
X-Proofpoint-ORIG-GUID: yCLMS9TFTO7cqYWCNnXxC5ssFXQJAlC-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280102
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joseph,

Can you help review the first two patches?

Thanks,

Junxiao.

On 4/26/21 3:05 PM, Junxiao Bi wrote:
> When fallocate/truncate extend inode size, if the original isize is in
> the middle of last cluster, then the part from isize to the end of the
> cluster needs to be zeroed with buffer write, at that time isize is not
> yet updated to match the new size, if writeback is kicked in, it will
> invoke ocfs2_writepage()->block_write_full_page() where the pages out
> of inode size will be dropped. That will cause file corruption.
>
> Running the following command with qemu-image 4.2.1 can get a corrupted
> coverted image file easily.
>
>      qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>               -O qcow2 -o compat=1.1 $qcow_image.conv
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>   fs/ocfs2/aops.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index ad20403b383f..7a3e3d59f6a9 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -402,11 +402,28 @@ static void ocfs2_readahead(struct readahead_control *rac)
>    */
>   static int ocfs2_writepage(struct page *page, struct writeback_control *wbc)
>   {
> +	struct inode * const inode = page->mapping->host;
> +	loff_t i_size = i_size_read(inode);
> +	const pgoff_t end_index = i_size >> PAGE_SHIFT;
> +	unsigned int offset;
> +
>   	trace_ocfs2_writepage(
>   		(unsigned long long)OCFS2_I(page->mapping->host)->ip_blkno,
>   		page->index);
>   
> -	return block_write_full_page(page, ocfs2_get_block, wbc);
> +	/*
> +	 * The page straddles i_size.  It must be zeroed out on each and every
> +	 * writepage invocation because it may be mmapped.  "A file is mapped
> +	 * in multiples of the page size.  For a file that is not a multiple of
> +	 * the  page size, the remaining memory is zeroed when mapped, and
> +	 * writes to that region are not written out to the file."
> +	 */
> +	offset = i_size & (PAGE_SIZE-1);
> +	if (page->index == end_index && offset)
> +		zero_user_segment(page, offset, PAGE_SIZE);
> +
> +	return __block_write_full_page_eof(inode, page, ocfs2_get_block, wbc,
> +			end_buffer_async_write, true);
>   }
>   
>   /* Taken from ext3. We don't necessarily need the full blown
