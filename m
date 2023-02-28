Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F86A52E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 07:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB1GUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 01:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB1GUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:20:37 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A8C193E4;
        Mon, 27 Feb 2023 22:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeDhcwAjEmTR5zK2gJiJ126CECtUJZzohhvigyC/NjtL3A1FiVJwDcphbZ9mP/TMKBM02wJEPM09Dy7mL56mEEG2uS7BfNfqPI4+E0/tDaCkCqYP+ylogurwSosTJyjPlaXGbg0h4VpC8g6nr/FWd6sCJBOrHtE3dofTQB8lxdXfwYCYSpjGmDQSLtVyKUuYbecxaT8UAMx6BRcASZV7RB7aoAKJoi7advfcNfUhVKXUd4h8+SxEg5vNSj8VlbXj0qSL//IreYoeEtd55HUQDyC1l5oY7oYGtjMy5tkfm0Tag50+Nx4twT+ViENtx4zox0MoMlrqqAiL0WqntujPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aofe97n55yS6ERvM1beGjk21hgdGzpcKTJtAhHrxrg=;
 b=eecwNkgVZb9JOAm5KLSw02ZOGaYfEYLTHeUoOXW0CUGXPkqDqMFZ31zIsEfECEillEqce+70k0JbNkkh9ArW63x8Z1wBEw6AHnCoF/uj2kM3djOjX1DKe5MgAJYuyyS/bAMJRibiUBnNmQWDmD0wvWckRtSxDcbVqdmiObbwP+eTCWRsT2NqEu6uMlJs/0fRLuSpaBdY9X4RQZG5puzC1AYzmzpJ5mDCAQclbpOjoowg0eiweja9VtyS5pWOxZ0PIAcUH7RfLWsCF6zWYVxkh5+32ibQ7zqHHVam4vzy3APdPRl8hY/He6T5ZHMayQjuHopg4EZMQkUl9DQzY8Op9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aofe97n55yS6ERvM1beGjk21hgdGzpcKTJtAhHrxrg=;
 b=tDp58XLcis89BpAC+/BBlo7UbSucoG4XQFf0zrusurSIYB6HbDTOuwKgTFtnYjiH0rS3UVFT/roQYbu7jAVt2/xLaX6qXyiO1gI9optpBuBFrGi4KAiUWKO26EL7gAAdIF1lZ3ym77OwWNjNKNKr9pXNI7o1tbFEjNbSrq/p9cZ3Q0a3sh3ErtbLUAz0Iz8DsJOihf7bhs6GnfkYabDa85ugXMvvDEvzdB0b+6mi84D4ilYIMFcJ7vRR6FDO1sXKzydzQ74kd6D5Q1p/wsQBitlSCfBL6pCiRXurzBzelWPRBGRbaHbTgjFjNkvTW5hX9CDDPYPJKThRcOl8D6ElRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 06:20:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 06:20:31 +0000
Message-ID: <08b4b0c8-3621-a970-d206-d24e6eb81355@siemens.com>
Date:   Tue, 28 Feb 2023 07:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20211216112659.310979-1-brauner@kernel.org>
 <20211216112659.310979-2-brauner@kernel.org>
 <20211226133140.GA8064@mail.hallyn.com>
 <0e817424-51db-fe0b-a00e-ac7933e8ac1d@siemens.com>
 <20220530081358.b3tvgvo63mq5o2oo@wittgenstein>
 <202205311219.725ED1C69@keescook>
 <20220602104107.6b3d3udhslvhg6ew@wittgenstein>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220602104107.6b3d3udhslvhg6ew@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: cb87789c-f033-468a-1299-08db1953e4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Agy+ZBglX85XO2VIORqpUFSgVWBIkKiT86myXe4MDXVyn3JvKllz/nEOQdNUb/LQfRCtKa3bVTjCaBgEeBN+XsU7EFms6MoF3Kyh/bwFreKUjhgVBEgA/Ut/kzqHBXragEvGedRwQEZxbpMHMlL9FYngOwQ0t6TmPtmHQVf4PxvgKjCnKOdrhkdUz6cyBR3J02g0k1XsZJxJ98DVcEAfEi8Uqpu0jJPyJ4imtqnJGTQF8Krs8JZZN1B1tdWIknvOWL84jDuc2web/7jxDiyFkIu7knkZ1/Nsgy1yMxg3zx3hSKqSSobGt31QMLquQ2wq3pS5uMkdLk/pQ0M8lK52J+0/kwTAUm9Hv5tc0XLJt8ZiRjAiOl8x7rIHOH00KiSEY6MmJijvwycj3gJYCIAXUpRbTTozpyMPVOg4dMWJeAQ+sTjydiTcKiuuPuG63O0FdRNrCQ4vQSB8QK5/3t5U6NMtgOi2vEp86b/UfkLnzOYYRoFLc5qbfXVDuWpk+0Sn+vbYyGXjCTx/7FQX6JpGRmjEXwL5Y5F1z0ZRUbZYIkW/1/+EVkfhk+CSrC5dTcHV5jRbJC/QSTsuIGWqcJAmZykdKjJ92vjbuLX9iX4ireKXKdtlzA9BBH2FjsszhichBute3Vn1rr7wDCufaKFv+oGAVCQ2HlTh7vP4S/e72HxriSn1ySvilFAQRN4nJk6gzx8OSKoVipHH/H7frLugy02kgZTAp3BI1sSnKRhxiB42IHOY7Pbt18v+tztGMcVe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199018)(36756003)(31696002)(110136005)(478600001)(26005)(66556008)(66946007)(8676002)(86362001)(4326008)(41300700001)(66476007)(8936002)(316002)(2906002)(44832011)(7416002)(5660300002)(83380400001)(6506007)(186003)(54906003)(6666004)(966005)(38100700002)(6486002)(53546011)(6512007)(2616005)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STB0M212ZjNPZHU1NlU0Tzg0SW9LTlFjR09hZ0dzcmdWQTV1RE84T1RMa01N?=
 =?utf-8?B?K1pRSTh1b0RQMENzWHlBSjNBZ0QreXZ3MjNIR0phcDZ6SS9Xc1hzS3A5dk44?=
 =?utf-8?B?TTlGMFdFMytBMHVnTUZJSnByc0pBMmxJS2RLWkh2TkFvTmMyQ25nbXcyRWVk?=
 =?utf-8?B?UTdiOHFCMG9wMGptNjJ2MU1xNGVCdHNXN0ZVM1FybFpZNGo5QU5qeTJtN2Nk?=
 =?utf-8?B?RVIzV0g4VFlmRWdsd2o3Q3pRTSt3WjY1UVB3N09DQ3Ava2Z0d2pWeXFxZnIw?=
 =?utf-8?B?Rkl3ZHE5NERKTmI5b1RLVHJ6OXgyenlEYjdvdkNZRW5EUzltNE9pb2IrWWlE?=
 =?utf-8?B?OHlpdVFCN0w3WUI5a3NhaGdvTmJtcGk5QW9jMWVCZ3NBclhIR3A2UFZCcUx2?=
 =?utf-8?B?ckVsK2FFM0NvdEFWbk1NWisyOUFJNEFuUUdtUG1ibnJEQWhMcGVpZ3pKVHV2?=
 =?utf-8?B?cmlqSjJmM3VkenRvblNjT0xpcFlKbmIzM3dIeFdmMWppT0ovZnF4eml0RkNM?=
 =?utf-8?B?TDZOcHlaS2kxZGtlS0lIeGlUZHFuV09OSk5IYldrQTl5S2hzaVhDZ1hVQXRN?=
 =?utf-8?B?MFRhSWRrcEhHY0sxSDZtMzAyUGlMSlk1Z2JUcFNRY0RPWWNjY3VuRTl0UkJq?=
 =?utf-8?B?ajhmaWxlOWRuL0FuaGNrQ3Y3YWE4bEVYRTBZbFJ0aVJNVkpLb3g1WXdnSUk5?=
 =?utf-8?B?STFidmpkem5BRXZIOStNNU9rZWFvSXVCckRhMGlTVmljK0xBOHZKTVY4ZDlM?=
 =?utf-8?B?eVE2KzhpWnNtaDQvbzlTTXdzSVlxQ21RVVRVREI1Tk9SbjEzdGZHL3h3SWp2?=
 =?utf-8?B?SHhwaGp1cWhrR2hnUmNUZDFVcVBGRDl1enpHK2hWbUZvQnlYYlNKSmlMWTNG?=
 =?utf-8?B?RzhjenNBMno5THNxSXpZQmJTVVVxNmNFeFdMMWk1Y0dRdThJemVHNGpMcXVQ?=
 =?utf-8?B?eTh3ZVlpUi9PUWFjd1pTN2V2bGh1N21pY3NkOEkrd01yMXA4NDU4Z0x4OXdT?=
 =?utf-8?B?TDdyclcvZDBFSkpLeU5CdGhyTW9TVlVPNCsyaGN5VHQvRjQ5WTNtc2NqYzJK?=
 =?utf-8?B?ZUUxWHJieTlPQ1JGaGVWeXVwd3BPNDZCOVAzalFqUng5NTBMajJqaTFwTzhB?=
 =?utf-8?B?dW11YVpMdzFsbW8zNlQrWkhEUFVQSFNNajE3QlM3Q1VrbXRZMHh1eEZvRTZh?=
 =?utf-8?B?RnNKMDVtVGtVcEp2eVVXSUhqS0Z0U3M0aG0xZEtDT3JMdDNQL3JBUDlTczRv?=
 =?utf-8?B?UFJvN2ZtTW4xZEhjOUZtUXFIejhmOHRReWJGQW1tWWF3ck1XZnQ5WWdjcnVK?=
 =?utf-8?B?QXJtU1hsWUFUTWtrR29sSldKN044SGRyYzZHelFWbmpWMDJpcnptU3BycUlT?=
 =?utf-8?B?WlJZM3NLcVFvaVFkdFl0MWFzd3pNN0FQeDErc2NvS29Xc3RXaGNnajdETjls?=
 =?utf-8?B?bUVMZVVEV05wTzUxbys4aUF4SElCeHlBR1lqdkRRdXdMYWVnb3lHSExJRFQv?=
 =?utf-8?B?bmQyeld2czY5K09NU3U5Mk5kYkdxV01kOWQ3SzlxOVZwZ213UnlyazBneFdh?=
 =?utf-8?B?SFZ0bnlWU2ErQ3VWeWVucVRSUmpzTG5ENmV3RE9PeWVLbmZZOGlWdk5FLzN6?=
 =?utf-8?B?RXViaHltWjBDejZPOVQ1LzU4WEpGYmlmVzAvRm9ybmR0S2ZLNnpFbVJ0NE1J?=
 =?utf-8?B?a0Q3dGRBOXlvaWRuVmJsQ2p0VnpLWmNuZHNTR0FMUGVaUUdZWU5ocVlvSjdV?=
 =?utf-8?B?YXNZNHM1OVNhWUgzR0xXV1dkSktaUGlFSjBDT1hBTXY5MnZERzlhTmZBZFZm?=
 =?utf-8?B?c1RzOUpNR1c1MFgwRTQ2eTE5cjk2TVpTZDJmdy85OGZrbFk3L2RKSlZVMnBQ?=
 =?utf-8?B?UGVmdEZNdmhxYUYvM2NiTEs2UFU0U0xzaisxM1Ztdk5RaE5IalpYMTFCU3RJ?=
 =?utf-8?B?akkzbHc0WEt6NTVGZWEwWWkzcHo0Sm9VWFl3Y1ZrYlBJYkFORjZ4RVJrN2M1?=
 =?utf-8?B?ZGpDUmVZM2wySUhUaHR4NHBYdm84eWZLRGs5UERTaUxGS3RrNVlkSGphT2xm?=
 =?utf-8?B?ZnNUTEZTS01HaTk4U3ZEUmRKRkU0Zk10UVlUNENUbmZlQ3k3TmtvY2s4NVdO?=
 =?utf-8?B?SjB0R3V0aGFwaHJ1dDVMQjBBbnJERTBKenhyUjRsVnVNZHBhMnRQMkdrc3BS?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb87789c-f033-468a-1299-08db1953e4b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 06:20:31.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ceVd1I5Otbxa8MRB0fB/YFxCMhIRFXU8upD4f8SU89eldCNYxAlBDcgA3akttzUtam0paal3hgiD70KC5JE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6642
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.06.22 12:41, Christian Brauner wrote:
> On Tue, May 31, 2022 at 12:24:37PM -0700, Kees Cook wrote:
>> On Mon, May 30, 2022 at 10:13:58AM +0200, Christian Brauner wrote:
>>> On Sun, May 29, 2022 at 09:35:40PM +0200, Jan Kiszka wrote:
>>>> On 26.12.21 14:31, Serge E. Hallyn wrote:
>>>>> On Thu, Dec 16, 2021 at 12:26:59PM +0100, Christian Brauner wrote:
>>>>>> From: Christian Brauner <christian.brauner@ubuntu.com>
>>>>>>
>>>>>> Enable unprivileged sandboxes to create their own binfmt_misc mounts.
>>>>>> This is based on Laurent's work in [1] but has been significantly
>>>>>> reworked to fix various issues we identified in earlier versions.
>>>>>>
>>>>>> While binfmt_misc can currently only be mounted in the initial user
>>>>>> namespace, binary types registered in this binfmt_misc instance are
>>>>>> available to all sandboxes (Either by having them installed in the
>>>>>> sandbox or by registering the binary type with the F flag causing the
>>>>>> interpreter to be opened right away). So binfmt_misc binary types are
>>>>>> already delegated to sandboxes implicitly.
>>>>>>
>>>>>> However, while a sandbox has access to all registered binary types in
>>>>>> binfmt_misc a sandbox cannot currently register its own binary types
>>>>>> in binfmt_misc. This has prevented various use-cases some of which were
>>>>>> already outlined in [1] but we have a range of issues associated with
>>>>>> this (cf. [3]-[5] below which are just a small sample).
>>>>>>
>>>>>> Extend binfmt_misc to be mountable in non-initial user namespaces.
>>>>>> Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
>>>>>> keyed superblock management. The key determines whether we need to
>>>>>> create a new superblock or can reuse an already existing one. We use the
>>>>>> user namespace of the mount as key. This means a new binfmt_misc
>>>>>> superblock is created once per user namespace creation. Subsequent
>>>>>> mounts of binfmt_misc in the same user namespace will mount the same
>>>>>> binfmt_misc instance. We explicitly do not create a new binfmt_misc
>>>>>> superblock on every binfmt_misc mount as the semantics for
>>>>>> load_misc_binary() line up with the keying model. This also allows us to
>>>>>> retrieve the relevant binfmt_misc instance based on the caller's user
>>>>>> namespace which can be done in a simple (bounded to 32 levels) loop.
>>>>>>
>>>>>> Similar to the current binfmt_misc semantics allowing access to the
>>>>>> binary types in the initial binfmt_misc instance we do allow sandboxes
>>>>>> access to their parent's binfmt_misc mounts if they do not have created
>>>>>> a separate binfmt_misc instance.
>>>>>>
>>>>>> Overall, this will unblock the use-cases mentioned below and in general
>>>>>> will also allow to support and harden execution of another
>>>>>> architecture's binaries in tight sandboxes. For instance, using the
>>>>>> unshare binary it possible to start a chroot of another architecture and
>>>>>> configure the binfmt_misc interpreter without being root to run the
>>>>>> binaries in this chroot and without requiring the host to modify its
>>>>>> binary type handlers.
>>>>>>
>>>>>> Henning had already posted a few experiments in the cover letter at [1].
>>>>>> But here's an additional example where an unprivileged container
>>>>>> registers qemu-user-static binary handlers for various binary types in
>>>>>> its separate binfmt_misc mount and is then seamlessly able to start
>>>>>> containers with a different architecture without affecting the host:
>>>>>>
>>>>>> root    [lxc monitor] /var/snap/lxd/common/lxd/containers f1
>>>>>> 1000000  \_ /sbin/init
>>>>>> 1000000      \_ /lib/systemd/systemd-journald
>>>>>> 1000000      \_ /lib/systemd/systemd-udevd
>>>>>> 1000100      \_ /lib/systemd/systemd-networkd
>>>>>> 1000101      \_ /lib/systemd/systemd-resolved
>>>>>> 1000000      \_ /usr/sbin/cron -f
>>>>>> 1000103      \_ /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
>>>>>> 1000000      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
>>>>>> 1000104      \_ /usr/sbin/rsyslogd -n -iNONE
>>>>>> 1000000      \_ /lib/systemd/systemd-logind
>>>>>> 1000000      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
>>>>>> 1000107      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
>>>>>> 1000000      \_ [lxc monitor] /var/lib/lxc f1-s390x
>>>>>> 1100000          \_ /usr/bin/qemu-s390x-static /sbin/init
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-journald
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/sbin/cron -f
>>>>>> 1100103              \_ /usr/bin/qemu-s390x-static /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-ac
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
>>>>>> 1100104              \_ /usr/bin/qemu-s390x-static /usr/sbin/rsyslogd -n -iNONE
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-logind
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
>>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-udevd
>>>>>>
>>>>>> [1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
>>>>>> [2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
>>>>>> [3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
>>>>>> [4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
>>>>>> [5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
>>>>>>
>>>>>> Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu (origin)
>>>>>> Link: https://lore.kernel.org/r/20211028103114.2849140-2-brauner@kernel.org (v1)
>>>>>> Cc: Sargun Dhillon <sargun@sargun.me>
>>>>>> Cc: Serge Hallyn <serge@hallyn.com>
>>>>>
>>>>> (one typo below)
>>>>>
>>>>> Acked-by: Serge Hallyn <serge@hallyn.com>
>>>>>
>>>>
>>>> What happened to this afterwards? Any remaining issues?
>>>
>>> Not that we know. I plan to queue this up for 5.20.
>>
>> Hello!
>>
>> Thanks for the thread-ping -- I hadn't had a chance to read through this
>> before, but since it's touching binfmt, it popped up on my radar. :)
>>
>> I like it overall, though I'd rather see it split up more (there's
>> some refactoring built into the patches that would be nice to split out
>> just to make review easier), but since others have already reviewed it,
>> that's probably overkill.
>>
>> I'd really like to see some self-tests for this, though. Especially
> 
> Yeah, I had started writing them but decoupled the upstreaming. Imho,
> you can start queueing this up. I'd like this to have very long exposure
> in -next. I'll follow up with selftests in the next weeks. (I'm out for
> a conference this week.)
> 
>> around the cred logic changes and the namespace fallback logic. I'd like
>> to explicitly document and test what the expectations are around the
>> mounts, etc.
>>
>> Finally, I'd prefer this went via the execve tree.
> 
> I mentioned this yesterday to you but just so there's a paper trail:
> The series and this iteration preceeds the maintainer entry. That's the
> only reason this originally wasn't aimed at that tree when the series
> was sent. You've been in Cc from the start though. :)
> I'd like to step up and maintain the binfmt_misc fs going forward. There
> are other tweaks it could use.
> 

Did anything happen after this? I'm not finding traced in lkml at least.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

