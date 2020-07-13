Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB95621D26C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgGMJDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 05:03:50 -0400
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:20292
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgGMJDu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrxjN2ft9U71wkSwlzLHkFGEI7ypBJzl1KgvaJaBPOC+M7TFLSChfXzhDPTb09UAZ/STIhl4VthI9Dw/w0FiX0mssSDdMtavIf9bSyS22WX2PL0S/tiwuEqH0M+2+i1qB34EzU1slL8rivO17MrYFHMXChwCnUWB458s7uUcd4m2HWH4kiCpgtmgPRkY7SR/GihcBtHvNEpNLMZKrdyqsAPn7aYJNHXwJzRheWZugBZbtNJf2XmJZyAmWnuaLFdAWHyXbe9QyMa1k1thIvCbzGITI0bAEG9oQZozr0JBm6JhWRSB+qJUUxrtH/S6z0oJb1zgP08sglOrTXseSvVjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=intwFnpnQOajolbVn3hE29bRAEuMrZyiuQE9wYcVe6Q=;
 b=DpReJcNniJ/O/ufaxrPTcdeb/AaXOnkd7oUsEFGnDLLphjVTz6bYSlBqIViVdfptRP7L+pZ06x+qI3WszlwCdQsBQW+5ASBsLm5vE6agOTH8AGfaBwW89U7KZiKKEL6SiJDtKXAnrbd/Nrv9LA/YLgjGKE8uKzdzn32nL4cs6czL8AbVluf2/pWWZknzuEXXDuKaAJOzlp4dkhA1Jxrz+5h6TFqdXVonHndbx8cKpDHRverL1gdXZEd1bXCpxTesDE4vQiIIMkzPefMPYAQJ6G4rblI6T2Vxs8VpQYOlRRFRuliVDP2P2k4iugDpdFf0IO5R1l60hNygWVhtmrRWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=intwFnpnQOajolbVn3hE29bRAEuMrZyiuQE9wYcVe6Q=;
 b=ATDAO3aswavXvXkEdaXpKNqGcyZ7SEPciyLEdq3JByRtHT95z5H10SXWH3KtR6Fpfpb9UgTUbZYoDExhJ1g3iklA9G1C5qO1JY/Wq+rLbya6odZIgJ8bsNUhGtCZNt6Mnm0o8gq5GyIVELmXeQ7xFDiMY/482vOIKIJ5vk7EyBc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB5026.eurprd08.prod.outlook.com (2603:10a6:208:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 09:03:46 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:03:46 +0000
Subject: Re: [5.8RC4][bugreport]WARNING: CPU: 28 PID: 211236 at
 fs/fuse/file.c:1684 tree_insert+0xaf/0xc0 [fuse]
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mszeredi@redhat.com
References: <CABXGCsPPoeja2WxWQ7yhX+3EF1gtCHfjdFjx1CwuAyJcSVzz1g@mail.gmail.com>
 <CABXGCsP3ytiGTt4bepZp2A=rzZzOKbMv62dXpe26f57OCYPnvQ@mail.gmail.com>
 <CABXGCsO+YH62cjT_pF1RMqKD86Zug4CiWzv6QATe_zhEp3eaeQ@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <30a611e6-f445-494e-dab9-d7a5c17c9889@virtuozzo.com>
Date:   Mon, 13 Jul 2020 12:03:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CABXGCsO+YH62cjT_pF1RMqKD86Zug4CiWzv6QATe_zhEp3eaeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0086.eurprd05.prod.outlook.com
 (2603:10a6:208:136::26) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR05CA0086.eurprd05.prod.outlook.com (2603:10a6:208:136::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 09:03:46 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf73866-ec1f-42c2-d88f-08d8270ba6a1
X-MS-TrafficTypeDiagnostic: AM0PR08MB5026:
X-Microsoft-Antispam-PRVS: <AM0PR08MB5026876AAE310FA625C61832AA600@AM0PR08MB5026.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3IxsGtYipng3MNUXhvHwuUCnzG3RhupyXsuI9qVpb7+afmi87A5rGttdptk0HaEZb9/Bg/niUEIMYQubosHg6N8VksegmSqUv6BP4NKDOWEa16MxD5PSB5HG4rJZDhNuKh6m+eiREyEmVurBbLRMWvqr9TTB7wsquQzLiRafbFy0t75aBgxpzKh1PBBrd8I6tO1Ek1IhxSsDpx6UVgUc+//1i/sE2hwMUH6fBhzlSFPczV5jQroZNiaNaqZ1Y1lgvterW3zWFPEEKioxHJs7gS8k5CaMWrBQAVCEjFwuT8LKoOR+QwxQH+jGCJl3408e/H1H4lgZKq5HP0qxDGOVrZdDKQyzLZpTR5ZJgJASjwqpVsVLuBnPwN5MPZVS6KAMhFYfyoPfcZvBtifjpj6MMpHycWsKdnIT0lu5Hhk6A1VnyXaaPCaU+nVrTxNsN+Va2rhkmy/XLryGPp3IF1ahw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39840400004)(346002)(366004)(376002)(8676002)(66556008)(66476007)(66946007)(8936002)(2906002)(966005)(26005)(52116002)(16526019)(4744005)(31686004)(956004)(53546011)(478600001)(186003)(86362001)(2616005)(83380400001)(316002)(110136005)(31696002)(5660300002)(6486002)(16576012)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UqpuW61leJ9WmBNDxemiSYDm7tcEbmnEX7gcHFVNGtI0xLmTgjIDnaGBIHu/n9Wx501FTbJbUE6g2un3T/WBXJDIeL+GzKsXGiBB5B1yStt5HWpIF3KluuqENZ37KpwwIEn4P3huJKoa5f8wcKtWfdR/D9S328XebMG4uuMgpfEdNabPsI21sgt681PrEfnZl8/6N8N/bIdlLE0l5j85JZo0PzeWFUX+BB3cSOduQQqyRyyJH4z+VnEnp/obmKhtnG2bui+HfSt/LacK8KmPP+Y379dp100Wj1OAHCnjtaHPxWQG2sluGnDhLyHjcYgs3+hOa52e23GdJXS6DCe4zK/zAh64HN4KbJ/EbSvjiQeVQMSXph4xa2fl97w9iEMIh+er56wNzIE0iSeBSrpI0O9P0huA7lYHtnsZXQQ1o9yNSqhXffhW+JTLEfGHR+srZIqhi2FQ+ZY4AY0GJj3SJ5N165TfnyT3v3GktTlpdRs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf73866-ec1f-42c2-d88f-08d8270ba6a1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5140.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:03:46.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Is1CIzUx5WJ7zHurkCYcAbnH63zTvvGC2CLKLyY6Q3e+ibZGxRosixihIKNdN+hMIh3Pd+1LHx9MDn1fRWaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5026
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/20 11:02 AM, Mikhail Gavrilov wrote:
> On Mon, 13 Jul 2020 at 12:11, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> On Mon, 13 Jul 2020 at 03:28, Mikhail Gavrilov
>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>
>>> Hi folks.
>>> While testing 5.8 RCs I founded that kernel log flooded by the message
>>> "WARNING: CPU: 28 PID: 211236 at fs/fuse/file.c:1684 tree
>>> insert+0xaf/0xc0 [fuse]" when I start podman container.
>>> In kernel 5.7 not has such a problem.
>>
>> Maxim, I suppose you leave `WARN_ON(!wpa->ia.ap.num_pages);` for debug purpose?
>> Now this line is often called when I start the container.
>>
> 
> That odd, but I can't send an email to the author of the commit.
> mpatlasov wasn't found at virtuozzo.com.

Reported problem is not fixed yet in 5.8-rc kernels
Please take look at
https://lkml.org/lkml/2020/7/13/265

Thank you,
	Vasily Averin
