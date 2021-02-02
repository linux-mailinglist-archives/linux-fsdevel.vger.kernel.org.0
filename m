Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719EC30C803
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhBBRiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 12:38:09 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:60731 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237611AbhBBRf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612287259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKxtAvIGXb32R8HRQAZat/oSz8cai+cGvtkCQm8CgvI=;
        b=H0vBPvfX/KEUPpqHLBeaYuJ2CdJiZ4qTyrmgZK6pv2ZQudZkuFvJG0/86/GBhEY+w8Nz2E
        B9J4xm800wNxXsctTXjTkQ/SaKcdsWcAM9GMuPQ4OgMJlSHqjZY45XctAEox3Aa0pZv+iw
        D1Gikb+LU7fHxW8bB9CRixBgKcgmHqI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-tITc2xmePy-t9OJHx-BRqg-1; Tue, 02 Feb 2021 18:34:17 +0100
X-MC-Unique: tITc2xmePy-t9OJHx-BRqg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD5LaqUV+w6mywzkcjBfrVwXXEDw95xynplmfb7is7JX3vJ5+ER3U1FBd09+V3Umgkn0tA8FvL82gDigTQxLg88QyTNtfOYD0YqJKeTiwYKnFSdPyThE3HDUQ4vMFcV3QbpETpNL4SKkqjy4HD0cVyPleClUkHXhTUfIcZ8N7n1pH7JiXTxe0VuWtVc5hNV6mlRl/BfDsedzYnXQpMZ3Nv9aHXOz6DwRl/lHSLalR6obCJqX5ucID/artVNbkQoXAao+LgBmYD0C6GDd4IZaPeUPyex0J6MoHd0X9baGQ0HD+xjAB9nKY64McmwkClJ8pRRUSMfInMXWSkOzdshP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKxtAvIGXb32R8HRQAZat/oSz8cai+cGvtkCQm8CgvI=;
 b=lBMtG9JcUXLbEKZHhuzn1TcBMts4T6eUmL8eG7V6YJku8fFuwISpdjXfCXPl+KoOdUcOdV18MX55SFf/qNYG6vnxpiWGWtG/3AydjyQCcHtMd6akRCwLDVPs7Rc1uoUNX4m+9GP6wa94dm0LHuKD94hZxhyQa+dksVhLHWz6opXvxTuRui1Z75yQCHtvJY/i3yqxrC9m4jrjqpqrtXxN1YLBlQUcI3FZTNroA4B+DEckiZUFYPr5DDSlNoI+3SG29L74pyT9nD4fQHt3+hQ7eiVVNP3/lKDtuXCcvCLFNd8YEQxh7rJfsrA20Ajlj3ZiCe75ALGzuiaDJ2X7WoUm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB6526.eurprd04.prod.outlook.com (2603:10a6:803:11d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 17:34:16 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Tue, 2 Feb 2021
 17:34:16 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH v2] cifs: report error instead of invalid when
 revalidating a dentry fails
In-Reply-To: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
References: <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
 <20210202111607.16372-1-aaptel@suse.com>
 <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
Date:   Tue, 02 Feb 2021 18:34:15 +0100
Message-ID: <87r1ly8jc8.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9f33:33e3:4e11:8cc3:3b4d]
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f33:33e3:4e11:8cc3:3b4d) by ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 17:34:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd52352-f9a6-4b1f-e667-08d8c7a0c390
X-MS-TrafficTypeDiagnostic: VE1PR04MB6526:
X-Microsoft-Antispam-PRVS: <VE1PR04MB652631046450713224A071C0A8B59@VE1PR04MB6526.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvml+08+SgLek+MxusX1RqhcU1oyifMncVFyNvITUIDcF4cWKQnYNrfr1TpLT/Ko4QQ5WIXqmxlmU9d36c6xZ8u8+68eRzf3tKw81FXxZdCe6Mldcx/UGonRfwz2oUhikiXhBP6pGSrQC79Nvsi13XXvu/dFixw1Y6WKKtjJDMrRgZf3GhG9WYcjghWeHm1oUzzlna5LkCDckiovBA6NnU0tFfJja4eaMkuQyEI0FNTfzwOgqeEyrTMj1fQT+98T81T1FGmOPMf44AhZNYNYnAiCsbx9H1PhmIO8AWdVcj7tXvMsccRXvIe3p4b051rgxD4SN1WNk2t1x1LZ2FNZHaWVvaKtwe9aev1a9SJMk6ZOcUVzD/8YF7rlYe/XI2wG/cQkmC+0f8JyhPYojmBZFpp80stkaDuj3EwdNDWhajJWHjSvVpS/PyX9m4Y8OOK9DU5sjwbJbO0FqD01lJeuvECOqyRId7DEgyk0LViggUutnGTuPinnO97aTHA/WQnsXs52h/YA/MTsrNxwjfVGCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(376002)(396003)(346002)(366004)(6496006)(36756003)(8676002)(2616005)(66556008)(4326008)(66574015)(83380400001)(316002)(478600001)(6916009)(52116002)(5660300002)(66946007)(54906003)(66476007)(86362001)(8936002)(6486002)(186003)(2906002)(4744005)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bmY5bi82ZWw0VEpGbWtnNmYyb0JSTE0wYUd3NDdEMnRkMGUzM3VUeWozbjFH?=
 =?utf-8?B?Z2tmV0EzNS9KZkd5VXE0MEwzRjNVa1RQa0VaZHRaUDEyTnRjQ1p2V0FVU0NB?=
 =?utf-8?B?QkZ1Ynp5c29TVUpiSmZmRVgzMm5ZdjA0UG9XRkxYNS9XSnpKZGg5b3p4S3hB?=
 =?utf-8?B?OEZLT1MvYXpvaEFaOHpDZFp4VUY2L1l3Qk82TFl0WFFxV1lDOWtZUTEzdWl6?=
 =?utf-8?B?cG1rVG9JNEdUQkM1TzZjYUZMVFQ1MGJvbGkzQ1ZYM01yeHMwNFk1NFNhMlJS?=
 =?utf-8?B?WUdGVHM3OFU3aWp0OVFaSC94ZGdRb3M3SWpIai9WSExCL3FYZVg1TUxzdzFI?=
 =?utf-8?B?dXJKOGV5MkhRckczM1ozRFRYWTVUNVFhd0Q4SHp5TjhiV2dqUUM0ZFRXdnhs?=
 =?utf-8?B?blkvTTdVSHdVK01nWk5QNHVDQ3RuK1VuNmczbjk1R2UvUXdwYzh6RDZPdGJB?=
 =?utf-8?B?UVdPQk45L0RnOEZxRTRRNVZEd1VNbDNWc1N5R0EvZHFnNHArdFBrV3libDVR?=
 =?utf-8?B?S1Zaa3lscGo4ZnhXYXQ4UXRqVnlHUnVlcjY2SFI3a0hxSVJuWWRNT1k0S045?=
 =?utf-8?B?ekFjQ2FCVmh2aUExYVlabDEvQldiaXV3WDlreEphcjdMQ1VYRzBQbW5vazhY?=
 =?utf-8?B?VUJ5WWlyRnU5QURVYUkrcFd1a2Rka0lOaUNBUDk4VTYxTHlWbmdGSXZoWTQ0?=
 =?utf-8?B?dmNsTWNUNXZ0cGkwVkxnZzFKTDFwVG9rbXFHT2lYZEg3d0p1ZVgyWkZtemNQ?=
 =?utf-8?B?eVVCcWxzYytPbmJVaXNCcEp4em1DYzBOZW0zUG9PRVhSQ0VIRUt6dUQ0TWFC?=
 =?utf-8?B?dzliaFJpZEdQVWZpWHNtYmR2djN0b05zRDlhU2h0ZURkWDRQOEloa25tU1hE?=
 =?utf-8?B?em8rM0ttcGMvKzdjQWY2S3NDUFRPUVB0M1RUZFFjcks1TWtkTkNMUFdiVysw?=
 =?utf-8?B?S09EZ2FoK3lYZHI3REMwaEZHSXJuREs3bFlNdC9DV0xuNTM4eC9OKzh6bW54?=
 =?utf-8?B?L3R6NE1Fc0tsWnZuT1dWN1dlRWRTZHZGVEx0UTI4d1kyQmUvNHlIRllIVE9Q?=
 =?utf-8?B?QWRha3ZVUUYzTXVGMWNtVHEzaXBhTUk2dmNxUDJ6cnQwOGJTSGhndWdiVjRn?=
 =?utf-8?B?bS9pRmh6NnFMUm9KTU5ab3pPakozd2x3UjFaT2dFMC9JY3JZcU1oUmU0dkVx?=
 =?utf-8?B?VytzYTVsQkRDamNXRUdIaFd6d2JHWWdwcGk4eHd4d0czZU90TXBRK0tmRlVz?=
 =?utf-8?B?U1NCRkwyZFlFWGNsMFZOT1Y0Z0tBNkZTeHo1VWFvc2RxMHEvSVYyRlFJb1ZY?=
 =?utf-8?B?YmVaeDVPUGVBSGdPL05waW45cGRpR3RoOVVnTWpiOE5Na3pBc1lZVXl1ZGRD?=
 =?utf-8?B?SGRISFVCTFlBOFJCaFZUMUFEdzAxMm81UlEvbGNRQkRwSG1NWE9EbHZwMGNK?=
 =?utf-8?B?dWZ1NWo5RnNtRXRmQWJiMVBHdU5hZTdjQktKKzZjZDhWNnpsUzdvR0QrcDRi?=
 =?utf-8?Q?Hgz5bY4EUptVEy4JIOsm5UTA7JR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd52352-f9a6-4b1f-e667-08d8c7a0c390
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 17:34:16.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9hi4LcMe5oKpC5VLn/xz0j1UVtxm2jJjV+leraY2+056/Yy53V42Tuke/tBgiEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6526
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:
> What does cifs_revalidate_dentry return when the dentry is no longer exis=
ts?
> I'm guessing that it'll return some error (ENOENT?). Do we need to
> treat that as a special case and return 0 (invalid)?

Yes it seems to return ENOENT; I'll send a v3. Are there other errors we
should consider?

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

