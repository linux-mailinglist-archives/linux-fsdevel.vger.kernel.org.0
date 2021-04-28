Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5093136DCA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhD1QEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 12:04:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhD1QEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:04:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SFjujb158799;
        Wed, 28 Apr 2021 16:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nXRB3tr9Jl8lpianMwr0iVTzZ3wV3dxY/QpXFiI8qCQ=;
 b=OYnSU02YOaCQsHAJB1tHb3yCT5Ckcfme1xCij+LKxkfZRzDFHEexL5PwLBbkMD8HBvIY
 uSeYrgxBXwkK1FjyOU5w3fGrvo1m2KvGAuqELl+9dqaaQKO+FbfHgnwdoFpZ19B9p+fY
 LGm5OcJF9Rr1npF7iQgETEjO0YO9CdwL+iQ8YkjJpcvW3iEhKjiMDVfJKxTgcHE4K1a6
 P3hs6YgSdGnLyW2b1jJdL0pOMmEMYisNUpVVrX82B3Mw02ANv2jLbtaGfXNGqFt/3uzI
 S5t7AatKQvw2VP71HqIo7GV00X92zMTYAabN/pDvcAfEN8myarzRRV4pjKE9bejyR/kF Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 385ahbsbpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 16:03:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SFl9CG079985;
        Wed, 28 Apr 2021 16:03:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 384w3uvf2c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 16:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRtg7JdR+6ZKcBKMsA+FllEZLHDasipBWFt4ji4tft1XG1E7sAecE02e8uVGhTu+0cpjy0p0sgOG4CtMaBO7IOjrWqsESVCMeKQh2LPxnCobvn0hXb/CNJHhO1iY8XcyIw7EYJnL7yT3Ouedluw/1wr2aV8JVUX/MAcQRhJp7PMwYk/Tyr0aQvgahpqpT0PWJ1qPtV2Yc8AWCLK6WiOCsarO5du6UNBHXhgGWJLnpPskZSSCBOlgYDcaYgCeVhXG2BpbHuOybsvoOuiuCpeFDpoMXayhc8mpo1zLnP4Zg2hWg8BBQ8txY6Bokjfah86M9SJ7ynvLtwkIW3q7nHBu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXRB3tr9Jl8lpianMwr0iVTzZ3wV3dxY/QpXFiI8qCQ=;
 b=mye/Z+K7vnUR2ETPMcwf2bKeYvhkx0UqHaZTWr66nU7yProCvj0AJVRaUZY4GqRwhFnmE697EGXDmZqmkzKFbFHKBa3FvSooAivICBo7H2GyK5RIDj84Kl6vR44VkZ6l7SgrtWiQacrfef8RYcz2/QkgjySf1mbdOGV7/xpZOvJ+nST0aCIU7aps08Y70tCUY1gLjR1NwSZzJspOoDH2I90rpJ92oU/8QYur6ZZT1GBqThRKMAjZ6+XMs1VvIaHoozrFQ38mY3UR74O+isCfhldP2g7jZ88WSONk2t0k2S3nab6WtihrXZyzCGsJ/Q1J4Frfk3NgODyWSTcPXeuIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXRB3tr9Jl8lpianMwr0iVTzZ3wV3dxY/QpXFiI8qCQ=;
 b=FF62ISTOrRustz63B9omu9SOyW2D2yjbZkqCu7NJxz46ZHCxhcCaelXdMqQFeqmLEO888a22kG5WaHye+2kuHbxsMe7vNZO+zaaEYiL9FcExyWFK3ovAP1dmnAFbisdRc61lvf1PqtTShBXRTrhwr1jEvZ5VvFAqZrg/u20eyaI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Wed, 28 Apr
 2021 16:03:13 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 16:03:13 +0000
Subject: Re: [PATCH 3/3] gfs2: fix out of inode size writeback
To:     ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <20210426220552.45413-3-junxiao.bi@oracle.com>
Cc:     rpeterso@redhat.com, agruenba@redhat.com
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <3d364174-53dd-ee07-ac3a-6ea57878f8d8@oracle.com>
Date:   Wed, 28 Apr 2021 09:02:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210426220552.45413-3-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SN7PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:806:120::22) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-154-52.vpn.oracle.com (73.231.9.254) by SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 16:03:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d3c761-a299-49d2-c8c5-08d90a5f20b2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4543FC5D560AE0C24A610B4FE8409@SJ0PR10MB4543.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xImvS80fBsQvBsUCEOMQVFYZIvYrmYhIF75CxTkz9bWKkVzmi4uN/IaLLi8y6WuCjh0F2w59hWUCF7ascc9g3BE7rftidp/MoYtDns47uzx0M+Xp0FRwWCxPptdMeGzgclXfGQ4IFfwKqJqtCkzQhuIkGU/9rK3t6NMKbmKEqXAtsRntRwom/MHJTwyeyUezx4fp6Os3Q0gxiBY2KWr1Z1WOIr9oZ+xrl2NK/EZylE7QU6gnXK/p/0WHfThzwfESLvdhGkN2lQBE4hoshDbjZPj65pkVdHvVurQDfDCkLfKlyDgQerq+hV9400rumbF4LNvTN/5sODhKGy0ELYgJLUpjRksbVQ2TxMOZPIf40uqWEHC8uxjavXuzyrekHDsLQls8OFZxWW7SoaulNc4Op6vodhuda6P+V2TByekPRwQgoQONZlw1+qmTgrroogIWd/rG0YKX6DSoeQfJ+x/Ri80L74AatXWTxZGuNQdillvj1yqNpHZiTH9fYy0eM6mRhosjY2f9X8NwF38i/78U0FPsXG7tvaO5zXt4Ef5pcdwEYEdcG9zGr+N5yJBnq/ZC3IcuZc1kHvV4rz33obJ4dn4IxI7in79hoPFVBz+xx4qzGCNHZQZffkIfqRHgIB+0ygpLlz5+dS89nfcbBvFovaG+6Kw1bfO1LW++MZX5Sjp/+HLN1uncCCwTi4C+MG5w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(396003)(136003)(956004)(84040400003)(36756003)(316002)(2616005)(8676002)(83380400001)(38100700002)(44832011)(16526019)(6486002)(31696002)(186003)(4326008)(86362001)(7696005)(2906002)(66946007)(53546011)(478600001)(8936002)(66476007)(66556008)(4744005)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YlhTa3ZXK1pxQmxtQWhVYXZLTzhrWWhtYkR0N0ZIVERzT1owNFluUXF1M3Bn?=
 =?utf-8?B?dXJ3UW1BZTJZZEhHUG01Q3h3Z0NWcDl2YldQeFBwN2tnM3E5Z1VJOTRRWFdG?=
 =?utf-8?B?cVY5VEJ3MHZQckZIeGlqVWo3aTVkaHhKeUltaGVLL3NCQ1c1MHBIekVDWVpT?=
 =?utf-8?B?M0hWUnpNNGphVmJaSjc0UVJxNEE3b25sdGpFcXYvZUJra3RYUGVFcVFsdkhI?=
 =?utf-8?B?dGlwdk5GanZ1a0pTcEZ6d3YvNHFmZWlEd3VveUZoY2tCNGlXN2EvRGxMM1ND?=
 =?utf-8?B?ZWVnMkZ5K01TUGtyZnZRZEV4cXAvcmFJeGxWOHpaNTNhWlQ4M0NhWWJYMHln?=
 =?utf-8?B?MEo1T0tCNHBNTk9BMDNHUlk0Ny9Wc0F1ajJLeUoxMlhMdzc3T2RSdTNVemhn?=
 =?utf-8?B?KzM4K3lXV1pOTE9ndHR1UzQ1NG1YQy8rYzgySzNHMW0rei84dXB3cjd0ak9D?=
 =?utf-8?B?T3RnTXpmOFowcWJxWVFQcCtCWVEzZjc0cFVjdW9ub2NFb1NzdUFDR21ZdGEz?=
 =?utf-8?B?MUo5U2Ixam90YU5OemN1QnZEc2hmeEp1eHVXMFJ1MVUwMXplZzVQVUxCdDE0?=
 =?utf-8?B?VUxFNE0yMnBvMWsvbFVsZGU4WWdHMFdNcUcvbEQwWGxzRVoxeFl1M21SZ1Js?=
 =?utf-8?B?d0lKVGNqcnFFWHhuZ3ZWY09JOWZhL2crOENqZnRlUVkwWUljMXp6S2tKZ2gv?=
 =?utf-8?B?TGpsVE9XNWRNRFNENXh5QjB4cDJlMzdPTzNMTTc4Ky9uU1RiUFc0clBtZ3ha?=
 =?utf-8?B?YXgxbXdiL3hQaG5CWDFTTWlNZy8yY1kxeXpNVnJDQUljaVVqNUFqSXNKaXRS?=
 =?utf-8?B?cnpaNnIwN1Jobnl6TCtQWmQ5SUswSG9PSkpUcFp0QWtMWnhLOVBaOUFENDdq?=
 =?utf-8?B?cmZJdnlrT1FhNTJ0djE4OXNNekYyRHdvdURISGFwckdYeSs3SDFsSWFmOTJG?=
 =?utf-8?B?RlRRVTBBb0x2ai9HT2c3ZVBLYkd6OUoxc01pcTM3d3ZzNU9URHEwdVF6U1Jk?=
 =?utf-8?B?L3RxaU5ZdUwvbVlEODZpRUhZTXE3dEZONHBVYnpnTEFQblF3Qk8yNDNOcXBq?=
 =?utf-8?B?Yys3UnZlWWN0RW1nRzMyZmFybDFKaHNVR0Z1SEhjZWpYWXRJQlcwNlRBTTIy?=
 =?utf-8?B?dGh3UWVneUxBZ2sxSzljc2k3Q1M2czhDNytTQ3ZsanJEWWpBVW0rd1BOLzRt?=
 =?utf-8?B?Z1VZS01rNGtIS0dJY0RUckV6OTVtakF2R0pqNWkxdnV0U0t1MnhLY250OHgx?=
 =?utf-8?B?dHBCdGpLVWQzTndnb20vSFovM25Jd21GK0lIMzNkRnRmRmVEbkw1V1JocWlW?=
 =?utf-8?B?Vy9OVWFrR3FIbnMrWVd4Ymtvbzh5dm1rZHdvQW4vMjVtR2svRDB1d0hsSDFY?=
 =?utf-8?B?d0tSczVCc1VrRisveE9lV0tadVdjVFJDb1dmbHhveFhreVRTb1hybDNGMUNI?=
 =?utf-8?B?ODMxZ25WejA4SnJXU2x4ZVBBNDFBRFJTeFlTSGVSMm9xQ3l2NGhGOW91Qm95?=
 =?utf-8?B?ZjAvWkk3TlIyV2xoVGI2Ky9IREtIVk5YZlY3MGN3dnIyRFVobTJ5NnllRTgx?=
 =?utf-8?B?UTI1SXJVY3ZwbEVJSzZoWmdNZ3RGZlN1bHIwTUJUZmhUbzNIdnNDZWU3MTNV?=
 =?utf-8?B?NmczY3pDMVVCdkRXRDNhYnRSbzJrTjhsSEJxS0g2cGQ5UjdJQXpnQkY0eTUx?=
 =?utf-8?B?TFA2aDBqekNJZjVyRnJwMWVxTnY0RUtPU2tIaUJXSFVMamFsR0lqUWxMaEZv?=
 =?utf-8?Q?vppZLpm6Ho24fqUGKlloLEYj30RJNQwkK2D1mxk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d3c761-a299-49d2-c8c5-08d90a5f20b2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 16:03:13.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZYrHrqhxWh6iK/wdJ2nV25vg1/mMfzUo/w6jGon/GeH196JRsIW6xOSfx4PS6j3kbUq8msiqg7dQ5xio7BuBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280102
X-Proofpoint-GUID: fZZDLjTh9W7Hp5ZJLtZ23FNYyP7BMqQp
X-Proofpoint-ORIG-GUID: fZZDLjTh9W7Hp5ZJLtZ23FNYyP7BMqQp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280102
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bob & Andreas,

Can you help review this patch?

Thanks,

Junxiao.

On 4/26/21 3:05 PM, Junxiao Bi wrote:
> Dirty flag of buffers out of inode size will be cleared and will not
> be writeback.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>   fs/gfs2/aops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index cc4f987687f3..cd8a87555b3a 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -133,8 +133,8 @@ static int gfs2_write_jdata_page(struct page *page,
>   	if (page->index == end_index && offset)
>   		zero_user_segment(page, offset, PAGE_SIZE);
>   
> -	return __block_write_full_page(inode, page, gfs2_get_block_noalloc, wbc,
> -				       end_buffer_async_write);
> +	return __block_write_full_page_eof(inode, page, gfs2_get_block_noalloc, wbc,
> +				       end_buffer_async_write, true);
>   }
>   
>   /**
