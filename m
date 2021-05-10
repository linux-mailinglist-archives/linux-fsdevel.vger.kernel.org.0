Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBB3799DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 00:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhEJWRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 18:17:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42538 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhEJWRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 18:17:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14ALxlVR003995;
        Mon, 10 May 2021 22:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GTd0DgE/krd4Um6k7hF0vCFQFI8/Rny8IEvsj/LlKSM=;
 b=dehBMnjJVD1dulSs9K1Ps+HJIWJYAZumZjxZFZybqeYMQiPLD5UeUgqVgKU2ysFv8mKE
 5TiuCW2O6zPWcZR5fwRedKpaj5mdHPCpHBwd7jQkqhulSynPXwS3hgW5iQr1jqYjrdJO
 P/ItGejUSS5NE+vnTNhXPv+cg4ATa3oouaTGfbTWCJz5jdQxvPyYOsfcZHNMcdfWguOE
 VIgI+uWdQA33/00whTQJnCopTvHGaS4GsZfUetqWxm+fB0Lfe7jkxyKr8XtRzqrtmp8a
 HThw6dtnbOLDsfpn8IhVULSx7ter81Ju0yHqFHKlsfGNmejhrhOgrcgtJ27hVWQN/o0p OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38dg5bcxye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 22:16:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14ALxZ1T110903;
        Mon, 10 May 2021 22:16:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 38dfrw6j5d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 22:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1Zsl7XM5IT7p0/GpTF48gLdK3pky+9afRV79Kgpf7OqywgK9coD/avElDDXHjcx8EnDn7QakvTmrjzSj9mTkXSYGb/nQbv5YMXDJWWqOOIgbQxtg7zvHsKALXTO3zc36N9htFeVVSSTv+aAK0svA3yBtFVwYuyMC8CGxPTrfqGsixvboqMypuZEqqT/ew8ywPiFpHkGBrZRmrr1Wv2GrtHiKm+FlFl0IPKGiwl11h56WQeIZBujkqBMidOTYoS0mv9rRWnsih49yousn2PAid9jvK4JCOeKEC9ROBMcj0Eo7ChEgVrK2aebAMQ78/0ZWRnOpxU16O30hsZvGq1+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTd0DgE/krd4Um6k7hF0vCFQFI8/Rny8IEvsj/LlKSM=;
 b=e3KyfPGLyZkHircfRAMCALuC+YEVxJTAIprDi88oT+XB9aRBcI6/4IYoxJRq/c06uwTk04DoXv5gHq/HlhSNqMtzr67HlvU7qwxontSJdWQTPUwUcnSpu+bk1IZ7xpXRb/+Si8hd3Rb/nyeRWEI9LSoVsVv4K0/br0ypz3kQ7sTQum10Wm+vX/wTPue3hI+eBudyQaNieH5VEcwzJW8W44FL7IuHkJrNdIpBoMxSlTzCCzN1zhGEodlGNkQuaCmmjMRf6e0qL6CkWbio5XVVXPTQYodbXOqJKo3/0GoRP83160NRexWrvVSfuuC4+vHjL1OBixpNAMBYjU+etFHSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTd0DgE/krd4Um6k7hF0vCFQFI8/Rny8IEvsj/LlKSM=;
 b=RA1TQPsSHaRmQfjO8ju+IsZuDG4ase7tGVdVWry66OZy81Uci3kB3YKjRlgrkZ4esAUvgIYDOzXyz0Hw5AmVdu/3oc/nMeNAUSxFbvJm+ggYoWL4PuY6kqIu/4VLkmie1p01kRvcr4JvkvTf6x/RZ9/V67l7wy6yYp7SImgYPdI=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 22:16:38 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 22:16:38 +0000
Subject: Re: [Ocfs2-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof
 writeback
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <20210509162306.9de66b1656f04994f3cb5730@linux-foundation.org>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <4d120e2e-5eb4-1bbb-cc63-8c3b7c62dac0@oracle.com>
Date:   Mon, 10 May 2021 15:15:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210509162306.9de66b1656f04994f3cb5730@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SA0PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:806:d2::16) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-227-171.vpn.oracle.com (73.231.9.254) by SA0PR11CA0071.namprd11.prod.outlook.com (2603:10b6:806:d2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Mon, 10 May 2021 22:16:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e94c67db-cbfb-49e2-3b83-08d9140147bb
X-MS-TrafficTypeDiagnostic: BY5PR10MB4274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB427462971ADB9F1A83C67E4AE8549@BY5PR10MB4274.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZhRFYVFUqr9WIUa4VkP2KOugeLVZFRuxoLIHXo3utKBJ59mihskMy/dypFk8g/jHFdW4IkhNP/ZB0T6vztIW/JDQEH5uttZf2l060hZ2opRXi9Al4h0ZPqZgnZWVpjE5YaLZw3ng7n1ogDeVZgLzmxqoxthbjxUk7YDY9CaH7NoKEoSfrMg8IcnfDj9sYHsrG4vFzjmF8kY5XzKuIwTiQUYraIKXgAEkaqFtdITjzDflMdFl8IwDCEHurHANuC5Jl1Wx/ayNPb3UyQSi3+AL7ouqYzEjiHyTO3rhgb6EfrshFor2Zs349vd4F8Z7hIgP3gOAi1rXhe7ma4H5QuBY1M6sJM00Xum64QMYbjIGfhAhMPdCx0aX9LykblP1ipFQD1XQY2n61Rsqe63XOqLPtUSc1cnce2e9563PABgDK2b/+/KFJUHiW7MX8ZznSxt1vqEUOY3EO3jQ713IJEXxuMFZjH6N4PKRTo8DO5qsLXCHjaDohd0IOmPhZdNIrpbAvocaSTu6y3bPMixLhnSEuhp1tM2R3jDAL5WxK5TtTxHZmdiIbQrB7o6txm/h0LpKZYn9hnCs4YxTGaMK/yXcS0iTf7MHhaQFVhNyquu4cpp6OJ21KTjS9dYIxSfW46RaZWQ7PkxIr1LkH0rrv7ZlckckCf/aOXTEEMyhgLNb80En3MU4VH3E0LBHe1s26QH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(136003)(39860400002)(5660300002)(16526019)(316002)(186003)(478600001)(7696005)(2616005)(4326008)(8676002)(53546011)(8936002)(956004)(26005)(86362001)(6486002)(38100700002)(66476007)(6666004)(83380400001)(4744005)(31686004)(31696002)(2906002)(6916009)(66556008)(66946007)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cWl6UEE3a1dxWWJ2Zk5hRG5xMmJmTFhVRWt4VnVUMG1GcTFoQWZHamtkVDdx?=
 =?utf-8?B?RXpvZHBobEVROEYyd2NLdDBIMkZDTmd3VjZ1cDFLbE42OUh2Rjh5eExpSVAv?=
 =?utf-8?B?MHU5R1MxSExXTEQ2RUV1cHlUVGs2Mk5ZV09LaXNjN0RDRFZ0SXBYdWpkMFV1?=
 =?utf-8?B?UUZwNklIUEhDUmdCZlNUakdHZHdXQk5jSjYxcTFhRTl2M2NKOUpuWTlPNUxa?=
 =?utf-8?B?eFZHM2ZGZ2VIcW51SFd2TnJHN0MySkF0Mm1YV0t4cjFtbXIzTGlnVTkzd0l2?=
 =?utf-8?B?amxPM1ZCVnh0MjlhTUIvZ1RlbXVzNjV0SEhPVVJEb2VYdmFiYlF4WXFXdHRD?=
 =?utf-8?B?OFU2ZDcxbG81K3dGcmtqTU5PVTlCYlNmN1oxV1hKSGhYMVFtUGE4MFRXS3Zq?=
 =?utf-8?B?UFNnV0grYkNIcXY2SlZPU2JBZXFEKzNXbld5bklWak5JUFNlV1h1ekRJYkll?=
 =?utf-8?B?WWwwamRaenlEa1lMS1JzZkdsTGUrNHVrT0VBNkVWN1djMWZvZlh4NFdmd2I5?=
 =?utf-8?B?SGJTMmQwSnFZS2FQelM5RHF2N2Y0cEViOEs2TXBCbjJXUFEwUldTaiswV2xF?=
 =?utf-8?B?VkxMZG0wb1VxY2hHU1U1QzBJL2c0VkdPd0liTFZyQXQrd3dJOHBrYXNvVmlw?=
 =?utf-8?B?SFNBdGYzcStFTEZUaEx1K1RZK3ZQeFRMMkhiRkxlSEFXL1dtSTlpeUxKQkY4?=
 =?utf-8?B?aUNZRGJPelJMVDJJK3NEV1BWdDFzQ1R0WFZBenVLS2hqY3pnTXUxbEhqRURE?=
 =?utf-8?B?emh3M2l4QzZFNlByZDd0cWl0Zzd0THJXcVFSNXQvTytscnUvblVYc1FINVEw?=
 =?utf-8?B?RXYvOXJNTXVQdHBBaHU3WjI0SCt1cmtodzRsK3ZBbllSQXhKM3BGS0Y2SGxC?=
 =?utf-8?B?WlFSOVRBdVVrNWxRZTgwVnU3RlBEVy8zV0NEcWFBMTQ1V0dWU3BIMWtwRHNa?=
 =?utf-8?B?Mm9yVmt5cW1yaFRTaHFUUEh3NVduMUN4S2dCWXBNeldHczVsTHI4aHBmRS9N?=
 =?utf-8?B?SFA1OGlLSVRVeWtmUllCa2lMcGQ4aUFHMXhuQklGTURvVDB3YkdmVkFjdTdO?=
 =?utf-8?B?b3Vpc1R1bytQcTRWVE1FRHJ1b0hmYkgvZjIvUFQzTzZlMUlaL25kTjI3RmhX?=
 =?utf-8?B?SVFYQ290K0hXQjdZWVV2SGRuMzlyWnczVTFpNnNWYmMrMFM0Q3REbjdlNTZN?=
 =?utf-8?B?Zk9iWVBIWjVEcjZXNWFqUk5KZHhKOVVxTTg0b0hScjRqTmxMU2daUnc2dmZG?=
 =?utf-8?B?NWJkNVJVZkl5ZkxRemZ5TmJyV2I1NkRyUk1Ea0gxaHBVdHVtRHgvaCtBNGdl?=
 =?utf-8?B?RGlGa3NhWDdsWFVBRStqQ0NWOUpxQXErTHpIQUtLZHRPYTY2UTQ5Z0RzaTRt?=
 =?utf-8?B?Yk1zZGxLZVN2MG0wYmg4WEFVd3FERkpWVENQZHNtcUlFZ0dlLytveC82QVBl?=
 =?utf-8?B?VUlsRHRoS2ZNeDY0R3h3a2pLKytvRHMrL0I2dWxWME5oSmtTbDY4VVhMeHpj?=
 =?utf-8?B?S291RlJZM3pRTk5VSUxhR2x0d0JZb0FQVk1jejVjU08wSHpzaFMxdThrS3Z3?=
 =?utf-8?B?K0o1ZURDYm50eHFxOGZoOERHL2JpSExLNnRhRE1LM0lWcno1aUM3bm9KdFMx?=
 =?utf-8?B?LzhzS0tsOGR3V3k2MDVoaDZrcW41WWgwbS9zajZ2ZDQ0bk50T2prTk93ejhH?=
 =?utf-8?B?bktmaU5rU0FMNzVoa29ZR0svbWkvVlhnNTZ4V1lGVXVCeWZiTkZ4WUFiRTRh?=
 =?utf-8?Q?k3RTLaAuLP/LOv5P0JWq3CiRC6OJ4TbAuTGwKtD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94c67db-cbfb-49e2-3b83-08d9140147bb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 22:16:38.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IggfOIr7C/U6W3qrA4B0pjxXWytc9d5kVY6c/BIJkFtYYKrNHHi6O+20F92U6Iz2fEZRKcnuroAit/KyiClmDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100149
X-Proofpoint-GUID: SCtTPBEI5NBDoralwuBxe9Ly-QMdmJc8
X-Proofpoint-ORIG-GUID: SCtTPBEI5NBDoralwuBxe9Ly-QMdmJc8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/21 4:23 PM, Andrew Morton wrote:

> On Mon, 26 Apr 2021 15:05:50 -0700 Junxiao Bi <junxiao.bi@oracle.com> wrote:
>
>> When doing truncate/fallocate for some filesytem like ocfs2, it
>> will zero some pages that are out of inode size and then later
>> update the inode size, so it needs this api to writeback eof
>> pages.
> Seems reasonable.  But can we please update the
> __block_write_full_page_eof() comment?  It now uses the wrong function
> name and doesn't document the new `eof' argument.

Jan suggested using sb_issue_zeroout to zero eof pages in 
ocfs2_fallocate, that can

also fix the issue for ocfs2. For gfs2, i though it had the same issue, 
but i didn't get

a confirm from gfs2 maintainer, if gfs2 is ok, then maybe this new api 
is not necessary?

Thanks,

Junxiao.

>
