Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE333D1F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhCPKmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 06:42:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:41326 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236752AbhCPKmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1615891330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTs4NxE6qUYISSm7o5z2dEDGWNxlaK/+EKjRplmzXso=;
        b=Yeu4N2RvJs9w+tgbq2k9T/ma7ajj3pVrHSi0+HKiVxfT51+RHF1EwIr2RMtDiXsRKbi+cC
        CrnZ+IFw9OkJMPfopz19GI/V2fi+wJMmw2QSVOPt2FOJXlJm3KXAzPGEZJaCuSdWfSlb9y
        0m8oSqfvm63kctDicDPmO3K7GLmH/pk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-aFT1GEhkMWaOiOLm80naWg-1; Tue, 16 Mar 2021 11:42:09 +0100
X-MC-Unique: aFT1GEhkMWaOiOLm80naWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RddkPyqz+sui+tawq5Pt2HenKePsOJeHWNng7gKpeDSTzuMZtKElj79YvDNLsv0qQ4mKyKxc7M5LKsIjKPzpYqce/weoD/aYQWYY8I3FNJm4cICFZl3Hq9jBp4g16h4FDIkyzEVYBCM+tufCeoPMvKLeSc1TQQS14JVtSWFf81O40KfX0TY3XhzHfo3QgRihL3joUew+EkoevPzDrSirGssao+REtAqM+UZVNgWdT1K9NWRdR8gjZGwfWXpQhlkfBE20B68Z+ChEbksz0jNQ2gUPXTOv99vIYrkuNB/bXJfLwbU7LsjgH8dfSI5tOSI8yzchJOzHpcZz7WYqdugzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTs4NxE6qUYISSm7o5z2dEDGWNxlaK/+EKjRplmzXso=;
 b=iBtWnyvId+uJzTVyGqKfKDaTM/t0P9jblL3bqKYs5ASTLzhHd0utFrSGco4RGl8paWXk3EN53O7JwhRwGY7EvGjOaoo7a/1YCbIStjT1f9eoyF/WHqREYnnoW/c8jhxXkPWlGP2MY+DmMJspTOHGunxPsJ5pTHNt74/Rixn+rrIda39UjIHrUqwvtXn+sO9ECVbBSCwJl5CUsVXkDmM1qtv27aLi6sbOzCWDtC0K+0eu+YarGraUuLastth2uv6yY4NtkWMSNlGLKH6Recu/osdxhjzNbC2NGs5O0SoJGDNTQ+VJGGX4orXJ3om0dKn7QsQO1KoM9JE7UmYpOPv2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:07 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:06 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH v4] flock.2: add CIFS details
In-Reply-To: <CAKywueREp5mib_4gmofwekrT=GhqoZo1kEmmUmNeqghG0EYYwQ@mail.gmail.com>
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com>
 <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com>
 <878s6ttwhd.fsf@suse.com>
 <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com>
 <871rcltiw9.fsf@suse.com>
 <CAKywueREp5mib_4gmofwekrT=GhqoZo1kEmmUmNeqghG0EYYwQ@mail.gmail.com>
Date:   Tue, 16 Mar 2021 11:42:04 +0100
Message-ID: <87pmzzs7lv.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a35:a682:38bf:93be:d889]
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a35:a682:38bf:93be:d889) by ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 10:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2153cc3d-cb2d-4897-9970-08d8e86824dc
X-MS-TrafficTypeDiagnostic: VE1PR04MB7456:
X-Microsoft-Antispam-PRVS: <VE1PR04MB7456F779E96447E9ACC69813A86B9@VE1PR04MB7456.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyNTQsPL8JyJF8PRv16ArQW69M2+L2H1/15NV/6SjyBxjBk0Me3q1oCSxbdVpnyz0TA9osNH4jOLi/hRIta6+6hbER/btymEASNP7CmBOJGsJ0ze2igzo7y5PyvROj9xcP6tiBcfQlNZ8jGNGDJuNaPedwfrpZJQsnSQf10puy5atYCBnD2gliCSpQzQJVav8CTLlPEJOEmHmPVRHKlMI5I3EzKvn7ICbHKQXX00P8d5ASQQ1aEXuXomimAc3uA/OIt9Y80fZC3zTpZjXrl3rvbQw80ZI9VhKqEIViNsDOh+NlMwmMxJGKNNx48jVBgG7QXxVHXxsbtuMz/fUaxjCxCSLqmJm1oYsAYWG+VIZeZwJmGEsmJCRVIQj3UQiTSawIo/1EeLGGM0ICj92Efs4BnQkOTTdzKi1OiDKfj2/EmgFpNoHOLROzT76nRSHan1ywx7eGLO26X6f9+Jpmd0Sc9eRn8TCgFMELnzpV7S/JIlS6er8D7q5yM8GGMkzs2ddbsPFq7nzmjG1WgCbsc3tyUjGGas+kaY8tvTW1dtqYrXRPaxB2U5LVh9BFxc3PrV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39850400004)(186003)(2616005)(6916009)(66574015)(2906002)(5660300002)(478600001)(8936002)(66946007)(54906003)(16526019)(52116002)(36756003)(6486002)(6496006)(66556008)(316002)(8676002)(66476007)(4744005)(4326008)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dS9YdzV2aVg0TFk5blNXTHAzR2Q4UUFqbEdvZkI2c21UdnYxd0E3ZUhxNlZV?=
 =?utf-8?B?eTFKR21HZ0U0N1EzKytqOUw4Q3lnNUR3OWN6YmdQRHBPS2V6UjdOZElFTSt1?=
 =?utf-8?B?ZDhiVDc4NkF6Zk9XY2dnMEFodkF3TkZDMVJxc2s5QzdFMld4Z1pKYXZFU0w3?=
 =?utf-8?B?aXlKM2RhQ3FMNEF4SjRSOXVvaGQwY1gweG9nN2kzbzBwOXFqSXBnbG40Q21O?=
 =?utf-8?B?MHpETTM4MzlMVU9RdUxFZnUwUmVweE0vOWdOb081QWRSYVBLc2ZpRkVPRU9n?=
 =?utf-8?B?MkR1NkJMRkF6WTNLck9JK09GZXhXN0hsZTcrVzRXQmsvTHFBZ1JUcURNVEly?=
 =?utf-8?B?aHptcE9iVVQxMXgxdjlPMGM1dFdTbGRJSS9veUg5YUJZOFFDVXVDaDNFd0xy?=
 =?utf-8?B?N2NPalZXbkFUVnI4cytJajNJUEIzQUhwc1BxaXFHeHZQQ0pMWEIwUUVvSi9M?=
 =?utf-8?B?NCtDR2hzWXhZdWdPNkFiUTJyczBPZnI0aUwxekE1VUJ5d095Z0dXRnhTcmk1?=
 =?utf-8?B?dVlwVXBjeWV1Z2FiZ3BOVEVJM3hTUDBPQmRCenZMbmIvTE9sb01lRFg5ZjQy?=
 =?utf-8?B?ZkVUdy92SUdZUGZkdWQxcUFGSWVQbS9ZWmFPRWVhS04xR1p5WWxUMGE1QjM1?=
 =?utf-8?B?UUtXU3dhNWZvRlNiNXZzTjZGZUpMTm1sbmxGd1JDUVh6bDgzWlZ5Q2NGWjJI?=
 =?utf-8?B?TWl2RjdlZE1admhDaE5zOWZ4UHdrWUhydm9YT1VNK3h4MGxPMVYrNjZpQkdo?=
 =?utf-8?B?bnYzTXU1emQrQ3JtSDBxRWk4Nk5pc2c2NDJTWGxPeGs1SXdFdVN3dWNMNmlz?=
 =?utf-8?B?N1ZTRFlZVWpXZ1FTNWNFMHk4ek5qVjFKbytZSEp0V2paVk9temU2MlBXOEkv?=
 =?utf-8?B?N2dISnBUV0tCSjFOQVNFVEc4T3JVeC9FTkZBODJ3MWpoZkpCWjZtZ3Nka21Y?=
 =?utf-8?B?OFVzN204cEFZdkRuc1lQVDI1dG5vSU94MkZqYzZGTVdWLzZiM3crY091UTdn?=
 =?utf-8?B?ejUvbTZxUHVMRTdIeXU5bjc2REE1NFhGYWNpNTZDM1FtZmNHZVhFNVRSa0tW?=
 =?utf-8?B?NUt3MjlzVENyN0wxbHJQZzdCRklBeE1GNkJWd1NVd1N4RkdqdkpSa1NvRTM3?=
 =?utf-8?B?T1hDQ3lmZDBhcHVIV3BZZ011SkRNWjAyWS9mYTh0NG91bGpldjhaRHJqV21n?=
 =?utf-8?B?RVRIVkpYM21MSXFDei9NYlVyYll4TENCeFpwMlJHQXpXNVFzN1V6OE5TT2hz?=
 =?utf-8?B?b1dvT09KVTJIZXdlMUViaU9hK0l4d3NRd1VUWjB2dmI5ZXhtVEFyR0E4U2tY?=
 =?utf-8?B?cFJTcW9sRHVXR1NtVnNZYTlOenZVZ1BReHVFYjlLMXZ3LytnMGdEOVIraWJj?=
 =?utf-8?B?dklOcm1wOUpVc2k1dmVmQTZZNUF1TytIbUtyVHNpODhIRVpBWTlhZFdIdC9n?=
 =?utf-8?B?WENDUlJ4ZWNYOGlwNlZsbVQ1T2R2WXFHVmR1b3pZUTIzQnhnSUszRWN6a3dO?=
 =?utf-8?B?R09PdWJmbkoxejhpMjBWVFVpR2dBb01ZTDlrNkM5Z2VTWnFyZ3ZncW9iWVp0?=
 =?utf-8?B?VEFNMnhycy9rNitBMjlvK01BM2ZMOFROMzZnT2d4T201bnFaTVJRcXhnWTZ5?=
 =?utf-8?B?Y1RqQWh3MnQ0bEh2TGpCZFRuNDhCNUFKRUVCajZlTTFOUkoydEZPcS92L3Ny?=
 =?utf-8?B?Tnk0dzQ0Ty9JZHdFMTg1WENNcGpxTzBJQndYb3hvQXJ4VVlJa0I3UnZRUk5Y?=
 =?utf-8?B?VmxqVk00bjZZbzR3SlFHT2txT0NtWXJxdEMrM3N4Q2hwdjVMUno5NjJrU3JT?=
 =?utf-8?B?bHNiMXpPQ29rZ3hkU2JqeEsweExmRURUSkoyekFLVGxJekRUTWZxMWpjZ2kr?=
 =?utf-8?Q?2NrTzTmT7q7lH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2153cc3d-cb2d-4897-9970-08d8e86824dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:06.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coXTKyYFklnOtuvFhwTRwGNPMLIZfSHsI1jpLx/Q1VLUAd1jMerJFwgZVQ76pPvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pavel Shilovsky <piastryyy@gmail.com> writes:
> It is not only about writing to a locked file. It is also about any IO
> against a locked file if such a file is locked through another file
> handle. Right?

Yes that was implied, the write was a simple example to illustrate. I'll
update to make it more generic:

  Another important side-effect is that the locks are not advisory anymore:
  any IO on a locked file will always fail with EACCES,
  even when done from a separate file descriptor.

If you have comments please provide direct text suggestion to save time.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

