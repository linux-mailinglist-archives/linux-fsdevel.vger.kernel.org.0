Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7A344568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCVNSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:18:39 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:33081 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhCVNPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1616418938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4BKl5VQnZbkoew8Ouo8/qCT+D/ACpj8AhUTdmW8wRg=;
        b=VSGWB68eg3qLXnKto4TnkprSQ8o4NzC0xd3h1Ti4o0BPKzfNZf59Neb1alCYRc+yVutlp8
        adF0HbfWl98A+FZqtWM3xEq70TstLx1LhqOE1T1L+giaq76pgSvcccnhK1dDsRNkgZOAkf
        8p3gJb1l/1FuP3sdwKmTX8sxRBG6bno=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-G8zuYPKZPxKDUiCpIrxgpw-1;
 Mon, 22 Mar 2021 14:15:37 +0100
X-MC-Unique: G8zuYPKZPxKDUiCpIrxgpw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFlhyXXsNJJok1RVFsor+X4Y/Lp7/XQViqiN7CQn4AQnCUaLVu6MFyOSZ9nOSNJ0R4sT5caZqJanMbsPQLZeYljpdsV0DZQqtDlPoujcsazrwM+TlyYmQnZKsW3e7KGbVtg81hKYJrZf6b4g0HcZhHioCbVO5Ze/Z9Ztz4Ubakpd6Iy8TJuuKqn63wzidYzOmicKYgzaLT1SkI1cOcLS+nYoyser3vpq+dRptVae4/p35hJRGYjFPw58zGRgAIymx6mroiKKjdIWnLYX9dZNv83At+ZLKnq+J80ymL65k+eJoxLIr1fPGrmrKkpqcGuoBEUBUMgu6HRqSu8ucDoeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4BKl5VQnZbkoew8Ouo8/qCT+D/ACpj8AhUTdmW8wRg=;
 b=b/Mbsqw604YOaHkNh5/o5sdkSCYYfiSSXsojS+FITwBDhJ2nCvE9nOPWt03dlLCmn2XY8jTjc9sTU4tveQr8744ZfKYoNGxS8GdYIUIlyC72tDPTrvDX7n7gxahpfBotkefV0aVeNxGkOrJjW8qP4BNC550MFCdqqmaBvVM2KtfLTzf4aKOIC6np9pRSCr7F6oZsAQowkSdsqbp+lEvLtk85hzSBPoAuftkZWHuNF21Fj0iLDerao8UC+uJwepbJMAjHzujR0kKOFMCxpdPnsNDHwQ536fRzWRjHVO+iDXA++z2dUKB4c43L6Rg4AbZPzF09mWMBoDde7OvdOV27QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0402MB3360.eurprd04.prod.outlook.com (2603:10a6:803:2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 22 Mar
 2021 13:15:35 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.3933.032; Mon, 22 Mar 2021
 13:15:35 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
In-Reply-To: <CAH2r5mvazL5gpWfNXX1t+bf_h6AuvGEboN9uLbq=n08PTiLZLw@mail.gmail.com>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
 <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
 <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com>
 <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
 <CAH2r5mv7NFYiPYvCoDJZ50nnoSgytEB4CKYNfg0RTNSPjox2fw@mail.gmail.com>
 <CAH2r5mvazL5gpWfNXX1t+bf_h6AuvGEboN9uLbq=n08PTiLZLw@mail.gmail.com>
Date:   Mon, 22 Mar 2021 14:15:32 +0100
Message-ID: <87v99jqqh7.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:700:2815:b96b:85ea:1f90:5f2c]
X-ClientProxiedBy: ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::14) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:700:2815:b96b:85ea:1f90:5f2c) by ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 13:15:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5745e29-4ec2-4bb9-fcf0-08d8ed3493d9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3360:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3360D5914FAB1E10890BE787A8659@VI1PR0402MB3360.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+gBCbYpUoGW/k3VqH/FPoHtZNrJ1rGFUjIVr5zPs/rXsDcirDdd684DKLilXUET6Q6KKYYmh5UoF3J53+Xja7O89l4DmtHx+rkdnTBc88rUUAuKuMFhC+QRLibVVtUQphHUvoUc17SXNb7nMCq/0dgemtcNIeeQaLYpkf7LgdZ9K/OFsiMlExZkWhUwy0BpEkHOedp1tAnrJFZBTxUPXIUY4qrwD6HBEqIJ7A0Gnm+v+xwhc4SWUrSU9oRdVfPVs2SxJ52CtY3jGBeLnkrFpKsxjMdQj34f0B+XxdKQv9nAFz70bgy1XeQPBQ0RcpZvwKX3Yj5ox38jVYvzbswoY+ml9Hs0/7Q+/U0lMFL6jC0crkoy30BKRFHCOCRjuaTR1vXlH1W7PP2+cpPB8EMpMP45z4CQEbemPYFfQJdvRzenCFzgTC0+3o5OtOtz5lF5dZE3Z02B6rAqDGjGK0c1Sp9k1wELQn9h5SATD7rzcXNAbXqtxSBa6udQ7CV3c2M9iaHd05k1YgU+lQbbtjUsHvfv3drfsEge29ccuW3ADq6rhipCkRbzaKyQbdX5+tDIN0Cqn3Mf+MHs5QqUxfbkd2uQzewk2/UPoXBWBQKCLupC4HB+zg9xGegoe2qRbcBb0+tQSXxqCSvU0XyMr67WTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39860400002)(346002)(2616005)(6486002)(38100700001)(4744005)(2906002)(66556008)(4326008)(66946007)(36756003)(8936002)(5660300002)(54906003)(6496006)(16526019)(8676002)(52116002)(478600001)(316002)(86362001)(110136005)(186003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWpTTy9LTWxVSGFzNTRBOHRHQmg5bVpQRnBhQXdWN2hRcnRrazBlZ0FTY2Ny?=
 =?utf-8?B?WnA0VHJZMmdCZ2xRVGZMOXM2c3h5Nll3eG9vWFFlckN6VzJwU3dtQkduY3lz?=
 =?utf-8?B?STVTOXl4cVVvbFpaK0ZUMU9UNDVjTVFVblMvTDBtZDNic3pIVU5BZ2ZMU3Vo?=
 =?utf-8?B?ZHBMb3UyM3dZVktPME5BY2p4L1c3RHhIeU4zdTlzcFBEUytnYVd5djJlRmE0?=
 =?utf-8?B?dm9raHNGT3hteVFNcXd2TDM1UUNNRWRQMmdJYmw3Q1RSV0xjU2hxOVRzZzlG?=
 =?utf-8?B?dFpHU2xLZytoZi9KQmV4akZNVmlUbVlURlluZkFuRWVjSUt3SWRNOFdFUWxZ?=
 =?utf-8?B?MGRQQ2N3R2xPZ0crbzNNMnRDemZ3RzE3MEtZR21DR1NXV3VINnhZZmFvaTNo?=
 =?utf-8?B?cExUbDkvWHBTbGh4SFhmQmtsZGh6eDI1aEx6VUY0YkpIa0Y2SmRrWlNNWVY3?=
 =?utf-8?B?RVlRUFNUbUZUelRNU29sbHZzZUZFeDNiUjN6QWlCdEFiVzBEU0lLOXAxSjNz?=
 =?utf-8?B?OFo2QVhJLzRYSWNEMmtNQXlRcVFsaDBzNzRKdWltMFl1TmE2a045TkttdDlu?=
 =?utf-8?B?ZUhpWlVhZ1FpdXdQRXdkVjlEaFV4QVdNRnVRYjBGQTEySjllc3o4MCswUjV5?=
 =?utf-8?B?QTQ2T2VDeWNKWkVUaHIwdFRTUjRjdEtzQmdWSkkzTCt2NURzQ0NSbmNXMTVs?=
 =?utf-8?B?SmQvMGsweXd0ZTFoWGtTYUNYR1pIVERJdXBleW9OZWJKWUxsUVYrd2xlVmdj?=
 =?utf-8?B?aXhXSmRkOTQwU1VVTis4bkpyeFovNHc5OVhaL21EeDhua25xS3VGd21YZ0V0?=
 =?utf-8?B?OWRRWUdPMFl6Yjh5RzQyVXNEVlhQdFExVXdxS0JUbzczUTlpS3dSTGJnejRn?=
 =?utf-8?B?RVNGamVxTzVUKzNQYWZQMjVWNDl0aXpxOUUrU0xjQlEwOWR6a282UTFpdXZY?=
 =?utf-8?B?dG8zR3paV2hrbWRWcUw0QmxVVXUxemFlRW53Mjd4RUo2WUV5b0dLQURnVmsw?=
 =?utf-8?B?LzVBdE9nSHlvYndjVURtUEpCMm5lRmZGVGhjb1RCdldUTkV6ajArYit6cSt0?=
 =?utf-8?B?eW1OSXI3OUd1QjRtQ25JR0hScHQ2YktRYW1vYndaOXgwaHJpWTJIaXROU0da?=
 =?utf-8?B?V1Q0VDAwblY0UlFtMGZJS280aGpxcWlFNjBGdjRZT045RFdhVlhvMWM2Vjkx?=
 =?utf-8?B?anlTYVd4MDBGVFY0ODZWOVdZdmZzWFJEQ0hSNHl3WGdzNVFvRkVnQTVCUXVy?=
 =?utf-8?B?aWpKejlyMExyUE55OW9MTVJpWVhadlg0OThlSm13bExNOEV3WHlZcjZ5VFpI?=
 =?utf-8?B?TCtHWW5sNEJ3UjNLOFZNUHVicXR6VkQ2YktGOUY1SUJQVlFYcFNrckxrT0Rq?=
 =?utf-8?B?ZGJDTmRBUGtZbzBmUDZTVFJCYS9iNWc0czMzQ3krYksyWHdoTmY0WXgvbEtq?=
 =?utf-8?B?dURhSnFTRjBZSmljWjFEVk9sU2pWeDJXckJFNU56ZDhHZjd3eExkTVhZVzRW?=
 =?utf-8?B?RzNCeTNxSXV1Qm9uMnF3OFZqWGNrR0hST0tPdzVIMnhJa25xSElHMW45Mm5x?=
 =?utf-8?B?aVRFTk5LaUt1Z01Kd0pjWXlUMHc0L3Z3RCtzd1Z3d0hsdWZHVUZhN1J3ZGZW?=
 =?utf-8?B?cVJ6VWlEdHAyN3c2SCs3QWNLSWtUMGdoM1Nrb0hucGNUWEZEQktsVnExZUlk?=
 =?utf-8?B?ci95U2VvYmY0ZGRYVTZqRWVhRU55RU5KbmYyR2YwNVRkS0F0dU5INkg2T24x?=
 =?utf-8?B?WW1IditycDJpVkd6M1RkWTVnd2RUQ0NPcDcwckNFR3FvL1M3V2k4MGoxY2l6?=
 =?utf-8?B?ZnVTS05Db0YwdXU3a1gyRW5nbkc2bTN1RWY5YXZtaVpFNkR1SCtsT05aWVpD?=
 =?utf-8?Q?mPcecT/DERgWX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5745e29-4ec2-4bb9-fcf0-08d8ed3493d9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 13:15:34.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qOQ1yCI/AjVR4iYS3bFzvwYVZZ3w0HVtN3VFiSxC3ub+/MI0SviRyj17H/PZw21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3360
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> writes:
> Some additional context - currently because of the way cifs.ko handles
> conversion of '/' we can't handle a filename with '\' in the filename
> (although the protocol would support that via remapping into the UCS-2
> remap range if we made a change to move slash conversion later).

Make sure to run the DFS tests before merging those patches as well. Lot
of path manipulation happening there.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

