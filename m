Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D276B30BC7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhBBLBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 06:01:38 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32903 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhBBLBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612263623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OdgJ9khXU7ttVvL+UtYdyAjH928ArYWWWtcH0nF4UY=;
        b=XWsqs9Txg8HOnOo8DoD6BN/xhmT34Sp9HXVuHaV0ZJWYqqRZLLOiN5RkghPjkzM2C/Chho
        3Q/np3L8Y7N58tzszD5PIVEjFbXUQqnNXdNqkao5hRm3JJ5g4ozPRMcXIdRSgoJ8CqvvOu
        gOAN41K5PAECwKS+bAek3JVn/1u7uw8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-tbpjQc1ePxqh8bH65Eyerw-1; Tue, 02 Feb 2021 12:00:20 +0100
X-MC-Unique: tbpjQc1ePxqh8bH65Eyerw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzJ/isSdyxY6VIiea1/EmzRi3FDL7/vWiKTJyXjjFfzD5H7XGrq3j97NveZ3JkuspQQqaOUrS/RINLbjJkaD+ERosehKvCuMJV7X9rvLcOlBPA2v3fnqINTyvb4hcl4BWyuVPC7tO8mTvz5S3wyO4ioCFwu1Y6CYlEuh1zVeI9RoicJYeLphbAaM4i9KQVH/kBX86cIwL8V/mkQQpPBjFlMx2/581Jv+dXQlMWN2bgDahkTKoaEc1f3GaByVCDKKRzNOhajGlz85Lm4AbhHzHyKFy0jeMytFNREw0dDVJnHNfnw2+BXtPa9d24Zgdld9xbtbY1htgJRXl/4Lr/rvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OdgJ9khXU7ttVvL+UtYdyAjH928ArYWWWtcH0nF4UY=;
 b=PBwD0MZkLXDHrXB/zE33r8AZ/UvBi/9aPuOFo+iXRKHURuSvJ/5i8OqVixbrvwd2mbtz0G23uU25gbpWDvgRffTUZBL8yZdFjnuZ9gYlKfy+Pmjj/OYamLpIj/d7yJrQZFM6yl4quawc57sJ2CuwQbt8H5lsuoIoCWfE/uVDErOKShsmGTNE8zD19ZnwdYAoGax7ufd68Y4fk16+Y1Lo2YjiKKlgZzs5Q/dEQq3k1yWYFKigIHggi3ZBoqqs+fgBrtiKQDkMdQ9Pf35AhaEJKRtmjPy1CFTTjiw4RIcezvYMrohKrqToNybTb06ARhc7Bg/daGCvRkWuPdPHEbegYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0401MB2381.eurprd04.prod.outlook.com (2603:10a6:800:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 11:00:18 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Tue, 2 Feb 2021
 11:00:18 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>, Paulo Alcantara <pc@cjr.nz>
Subject: Re: [PATCH v1] cifs: make nested cifs mount point dentries always
 valid to deal with signaled 'df'
In-Reply-To: <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
References: <20210129171316.13160-1-aaptel@suse.com>
 <CANT5p=ofvpimU9Z7jwj4cPXXa1E4KkcijYrxbVKQZf5JDiR-1g@mail.gmail.com>
 <877dns9izy.fsf@suse.com>
 <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
Date:   Tue, 02 Feb 2021 12:00:16 +0100
Message-ID: <87v9ba91kv.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9f17:137b:35ab:5b49:10f1]
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f17:137b:35ab:5b49:10f1) by ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 11:00:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899a6d7c-756b-4078-8b12-08d8c769b9e3
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2381:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB238167F701AD3DD38BC9BE52A8B59@VI1PR0401MB2381.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rbph6AiGSqjomoJCjORPDT3f/JrShk0oYleA+buTN/vdFDRhy58ZuCMbpeT64BVQHBus12kL/GRj5HO/lroKXRS6S0O+Ky3QWR7EjpnSnIFw19ZKbbgZj0oaD/JBpf6mNIBu4JGLzZ1L0lFwqW6Lh2ftqYI5G3zpgH25afWkyXBcoXI6hrQ/WqQWyiJ91xp6DCPJlw5Vnmb1Pmi7OMppTwhor46gjoTwccYP7xN17UjTbwxlVxMHaNtdgB7NbmTi0GNSZUnZ1ISUq9fDlvSNmjKlFCjmWoOuGDfvowpI+E1NcjBfSUFiLjxh+q4tY08AyOseEzLX9vyUEX9IWuJTqJ1f6lRfopCr3HXgRZ3GKGsllXM9XIrGQtf4KE0+FmeSNrAAp4M2wDrVdi84M5hvE+unjvZUh/qJ8u7u0CE15fLQo6tHxDcXylvLwTUmKrD5YvEkUuhQ2t7AfYyfZ17+ZwWdw5k/DC9jOLaiAn4tWShZ1GQ203h2R+jKrSVYged93g0a+EwUyYLQe26zzsUj3hW0lfpBTdjyfRPVWcMBungznXVnF9QnBFVZM/ZnyYU+7J2jhWD4H4FdVFWpSVuf7QwBIV95WcTorBbwR6v2rkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(52116002)(4326008)(36756003)(966005)(186003)(498600001)(66556008)(66476007)(66574015)(86362001)(83380400001)(2616005)(8936002)(16526019)(8676002)(2906002)(66946007)(6916009)(6486002)(6496006)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWp4aGozdzYvUDIxNjYyd0VxKzk1L0JIUHFHZDBWMFV0amFNcEhQY3N4V0o1?=
 =?utf-8?B?UWZZdWlzanl4MjJFc2NTbk43Zi82V1lEMUhzN0s0OGg0cjdUYkFNTEhxeG96?=
 =?utf-8?B?alprZ1I2R2dhckNrLzV3QmRQWk9iVkVvZ21wK3NuU2NSQWR4azBidDYydHVh?=
 =?utf-8?B?ZnBKaVRNbm9MR001Q1FXSXJLTm9pVnRHaGxwSnJWQnkvVHUwTVppb1hJOG95?=
 =?utf-8?B?TkllR1BsaVFVRWp1T1ZCTzlCWmlVdFRjZXQrc1YxTUR3aVh4N1JGNzQrcE9y?=
 =?utf-8?B?RmNaQ0VoUCt4cU02TnJXVk9OQ0h5V0RrNjlxTW5UVE5yb2NxYXRVL2dIbUp2?=
 =?utf-8?B?YlpXOVBMaGY5cCsxSEpTdGhxaGx4N25vTGxUeGIwVUoyTStKYmpyZDJ0bXVw?=
 =?utf-8?B?MmF5V05mNkh5ekx6UThVV3VKZEJkazdNSzVKQm5WVnpBaHVoU3hlNUJaL2xp?=
 =?utf-8?B?eVhpbFdwNVZmVWZXeHE2dmg2djF0Qmpxa0JRVGZLeEh3SFhGckdzeG9NYzVs?=
 =?utf-8?B?R2tJWTYvWFJZajVzWEVoYlZSVWc3d0loeEhoYk5yazRrT2NNYjBGMEhNc2FX?=
 =?utf-8?B?V0szUThONEZjK3NwcmN3L29CMXY5TTFwWGJmckdNNXc1REgvTjVqNmVDZDNK?=
 =?utf-8?B?UG9xbUJsRUo5T2JrOEhPVjBsaFFDbWtwdFNXeVRQaXowZno2Wmh2Q0dDYWxh?=
 =?utf-8?B?NVpEYXBZYzNzYThpamYyZEVoK1RvN2E0MktXcWQ5SE8rd3dmZld0elBEQU94?=
 =?utf-8?B?U1BGazdtTnRGR0NsYktVQXVTTGJRNXladVVXQ1FERG90bUEwNE9EKzE3TkZk?=
 =?utf-8?B?OWQ2UUNXT2NjQ1NTZHNjU3J6VEwrdTI5bjR3T296WTBkbStXem9vREpLSllY?=
 =?utf-8?B?WnJtY3YwVGlGMnRPblgrUjNYNkRXb2d6RlhjZVFIMGtUWkFpNDZ3b0Y0VTVY?=
 =?utf-8?B?WjhsNmRkZ2F1dGY4OEVZVjFoTWpaK09tM1ErQ0tyYm5SaDZUNVptZkpwdnZS?=
 =?utf-8?B?VlRWY3BIQWVtYmxQc3Q3NU9IdmxnR0p3NmFMVjBFVFYxNnl1ZlVzKzUxcUM0?=
 =?utf-8?B?L2hJT2Rld0c2RlFzdS8vdTR5L212YktJZjEvYldDNHFSRnFYZHkvWW53MlIr?=
 =?utf-8?B?VlRXZ01CWlFMMGp2WFpQaDFqWENWMW1uZGhhU1diZXJ2WkN0dlNEUk5SK0tx?=
 =?utf-8?B?Qkd4MWdzaVZnYitmUnhONHIxQlpzWWZoTGNaQUp0TldWQzJDNnRWWjdQVkFk?=
 =?utf-8?B?TzBkOU9CN3BxWko5bUt6VnR5WTVFNXZNU1doa1lZTGVpYk9SZHkxRFhNdTNX?=
 =?utf-8?B?RkY4ZkhZSTFqcHVaOUtYeW10emNEVjlZNk5Bc2dZU0x6V1k3Z3Q0WEhNWDJ5?=
 =?utf-8?B?OHgvSmpnM0kzZmViUVozU1k0UmZXZ1ZhWEZBTzVZREh1YVp1ck16TS9saUdP?=
 =?utf-8?B?b200alI0ZFA5cjFRQ3o2UllqSjBnWUttQkRpbGUyVlp1REI4RjF5amFpKzhR?=
 =?utf-8?Q?CrwX/LwJSzcUQGR+lDo9IprcgMv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899a6d7c-756b-4078-8b12-08d8c769b9e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 11:00:18.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mS7yHUR3cOxxMtUEvBYpOeULxxOuRHIyietpsWjEHXpJB/tXEdhO8Ec1s2mQE8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:
> But the point that I'm trying to make here is that VFS reacts
> differently when d_validate returns an error VS when it just returns
> invalid:
> https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L1409

I've tried returning the error with the repro script and it also worked.

> Notice how it calls d_invalidate only when there's no error. And
> d_invalidate seems to have detach_mounts.
> It is likely that the umount happens there.

I've dumped call stacks, the revalidation is triggered by filename_lookup()

[   31.913092]  [<ffffffff8133e3d1>] ? SendReceive+0x2b1/0x2d0
[   31.913093]  [<ffffffff8132cbd2>] ? CIFSSMBQPathInfo+0x152/0x260
[   31.913096]  [<ffffffff81343c9f>] ? cifs_query_path_info+0x6f/0x1a0
[   31.913098]  [<ffffffff81366953>] ? cifs_get_inode_info.cold+0x44f/0x6bb
[   31.913100]  [<ffffffff810bf935>] ? wake_up_process+0x15/0x20
[   31.913102]  [<ffffffff810e9c30>] ? vprintk_emit+0x200/0x500
[   31.913103]  [<ffffffff810ea099>] ? vprintk_default+0x29/0x40
[   31.913105]  [<ffffffff811a896f>] ? printk+0x50/0x52
[   31.913107]  [<ffffffff813678c1>] ? cifs_revalidate_dentry_attr.cold+0x7=
1/0x79
[   31.913109]  [<ffffffff8133b194>] ? cifs_revalidate_dentry+0x14/0x30
[   31.913110]  [<ffffffff813327e5>] ? cifs_d_revalidate+0x25/0xb0
[   31.913112]  [<ffffffff812404ff>] ? lookup_fast+0x1bf/0x220
[   31.913113]  [<ffffffff812407bc>] ? walk_component+0x3c/0x3f0
[   31.913114]  [<ffffffff8123fe5b>] ? path_init+0x23b/0x450
[   31.913116]  [<ffffffff812412bf>] ? path_lookupat+0x7f/0x110
[   31.913118]  [<ffffffff81242ae7>] ? filename_lookup+0x97/0x190
[   31.913120]  [<ffffffff811e1e39>] ? handle_pte_fault+0x1d9/0x240
[   31.913122]  [<ffffffff81242cc9>] ? user_path_at_empty+0x59/0x90
[   31.913124]  [<ffffffff8126ab59>] ? user_statfs+0x39/0xa0
[   31.913125]  [<ffffffff8126abd6>] ? SYSC_statfs+0x16/0x40
[   31.913127]  [<ffffffff8106de53>] ? trace_do_page_fault+0x43/0x150
[   31.913130]  [<ffffffff8180359c>] ? async_page_fault+0x3c/0x60
[   31.913131]  [<ffffffff8126ad6e>] ? SyS_statfs+0xe/0x10
[   31.913132]  [<ffffffff81800021>] ? entry_SYSCALL_64_fastpath+0x20/0xee


d_invalidate()->...->drop_mountpoint() adds a callback to unmount at later =
times:

[   31.913246]  [<ffffffff812554da>] ? drop_mountpoint+0x6a/0x70
[   31.913247]  [<ffffffff8126b0b8>] ? pin_kill+0x88/0x160
[   31.913249]  [<ffffffff810d6a20>] ? prepare_to_wait_event+0x100/0x100
[   31.913250]  [<ffffffff810d6a20>] ? prepare_to_wait_event+0x100/0x100
[   31.913252]  [<ffffffff8126b205>] ? group_pin_kill+0x25/0x50
[   31.913253]  [<ffffffff812564fa>] ? __detach_mounts+0x13a/0x140
[   31.913255]  [<ffffffff8124bf24>] ? d_invalidate+0xa4/0x100
[   31.913256]  [<ffffffff812404cd>] ? lookup_fast+0x18d/0x220
[   31.913257]  [<ffffffff812407bc>] ? walk_component+0x3c/0x3f0
[   31.913258]  [<ffffffff8123fe5b>] ? path_init+0x23b/0x450
[   31.913259]  [<ffffffff812412bf>] ? path_lookupat+0x7f/0x110
[   31.913261]  [<ffffffff81242ae7>] ? filename_lookup+0x97/0x190
[   31.913262]  [<ffffffff811e1e39>] ? handle_pte_fault+0x1d9/0x240
[   31.913263]  [<ffffffff81242cc9>] ? user_path_at_empty+0x59/0x90
[   31.913265]  [<ffffffff8126ab59>] ? user_statfs+0x39/0xa0
[   31.913266]  [<ffffffff8126abd6>] ? SYSC_statfs+0x16/0x40
[   31.913268]  [<ffffffff8106de53>] ? trace_do_page_fault+0x43/0x150
[   31.913269]  [<ffffffff8180359c>] ? async_page_fault+0x3c/0x60
[   31.913270]  [<ffffffff8126ad6e>] ? SyS_statfs+0xe/0x10
[   31.913272]  [<ffffffff81800021>] ? entry_SYSCALL_64_fastpath+0x20/0xee

The actual unmount call:

[   31.913594]  [<ffffffff81362248>] ? cifs_put_tcon.part.0+0x71/0x123
[   31.913597]  [<ffffffff81362309>] ? cifs_put_tlink.cold+0x5/0xa
[   31.913599]  [<ffffffff813318a5>] ? cifs_umount+0x65/0xd0
[   31.913601]  [<ffffffff8132976f>] ? cifs_kill_sb+0x1f/0x30
[   31.913603]  [<ffffffff8123527a>] ? deactivate_locked_super+0x4a/0xd0
[   31.913605]  [<ffffffff81235344>] ? deactivate_super+0x44/0x50
[   31.913609]  [<ffffffff81253adb>] ? cleanup_mnt+0x3b/0x90
[   31.913610]  [<ffffffff81253b82>] ? __cleanup_mnt+0x12/0x20
[   31.913613]  [<ffffffff810af9eb>] ? task_work_run+0x7b/0xb0
[   31.913616]  [<ffffffff810a0a3a>] ? get_signal+0x4ea/0x4f0
[   31.913618]  [<ffffffff811e1e39>] ? handle_pte_fault+0x1d9/0x240
[   31.913621]  [<ffffffff810185d1>] ? do_signal+0x21/0x100
[   31.913624]  [<ffffffff81242cc9>] ? user_path_at_empty+0x59/0x90
[   31.913626]  [<ffffffff8126ab59>] ? user_statfs+0x39/0xa0
[   31.913628]  [<ffffffff8126abd6>] ? SYSC_statfs+0x16/0x40
[   31.913630]  [<ffffffff81003517>] ? exit_to_usermode_loop+0x87/0xc0
[   31.913632]  [<ffffffff81003bed>] ? syscall_return_slowpath+0xed/0x180
[   31.913634]  [<ffffffff818001b1>] ? int_ret_from_sys_call+0x8/0x6d


> I'm suggesting that we should return errors inside d_validate
> handlers, rather than just 0 or 1.
> Makes sense?

Yes that worked too. I'll send v2.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

