Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD6344EAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCVSij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 14:38:39 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:44251 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhCVSiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1616438300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxzrEh5pE9ItXB8/KmZDeONb9hiLpCM9VY6voGGVDBM=;
        b=j5ZQckcdH+SFOvofEU5se3m1vrtgErGTCaSJ+I+Tjyyid0QbUMnrqPwq1EFAMzX8/d4Wlb
        vVcjvoKTjVlqC/n/KL0CMoedDnrljEFvuaExhc4KaBFa5eqRrLY9s52IGxT5Kn8x+S362k
        Lk2uZ6hAXwl/Eq1XDso1nUbPyRoFYvE=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-3buP4y0JOJC5JCv9YJPrvw-1; Mon, 22 Mar 2021 19:38:19 +0100
X-MC-Unique: 3buP4y0JOJC5JCv9YJPrvw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oiog+8OYMcjdZpbldAYdQCsTb5SJQwjcRvUoveWxEn/QapUHSgKWM+Ds5g/4G4M0qH4/Tam0xGjlJwWnVYegm0yHq3oz6+INuKN3U0p3b9BLNmXrCFqy2+aKQVxwKEl5OyBboiVzObLoBCNIORqDEQTDsgm2xcHjcOopx+3nJh1i/ANdORjOSbJ+COzyU+6kI0HWdhTZcZ8x60GcjGWZfvRdE7v/nh79CuhhQmS73PzS+elbCt6WP2GlNs9EF50aTDWHyh8cz9KmJ98EnZvUL81KZ/bhMfbKaslyBktrA60N1nQE2nl94rAAVJXRx3G3PfWMNViQbTKodjQQJ2kqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxzrEh5pE9ItXB8/KmZDeONb9hiLpCM9VY6voGGVDBM=;
 b=JiqqHljnYPEEfQofzp+r+Z2mz2aRjJQC4aRXEI3iLJFKk7THKDou2wfHDL2nHqgvK8l4hj28bha/vGQhOKafvMZgVpyN0l/1cI2MWMhrzZTUU0WUR5+lezI2kKMgvt4leNlr9EPEHfxsuJ0uRDL1Ukdm0UoWNEhp/6WvE1LqbU8IaeCzRbz7Jdl+G7ZBFkyYvfUr9lgTdZMu282vwYU5fKxkFwuLbn+6RpNuiFSQxDd2CYyEVOWOUV8E6jm+ItZrPr2DickUUwxImTh0Syczs0ooUVF7a1YqNhlE+zDkPED1gGEF6XvDiw05nyRnHeHDMTPWjHrwm6wubWfApnwyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:38:18 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.3933.032; Mon, 22 Mar 2021
 18:38:18 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org
Cc:     Paulo Alcantara <palcantara@suse.de>,
        Steve French <stfrench@microsoft.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: broken hash use in fs/cifs/dfs_cache.c
In-Reply-To: <YFjYbftTAJdO+LNg@zeniv-ca.linux.org.uk>
References: <YFjYbftTAJdO+LNg@zeniv-ca.linux.org.uk>
Date:   Mon, 22 Mar 2021 19:38:15 +0100
Message-ID: <87o8fbqbjc.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:700:2815:b96b:85ea:1f90:5f2c]
X-ClientProxiedBy: ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:700:2815:b96b:85ea:1f90:5f2c) by ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:38:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57681a1-fd33-4035-978d-08d8ed61a94e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6928:
X-Microsoft-Antispam-PRVS: <VI1PR04MB6928B00AD43076B46AAD0623A8659@VI1PR04MB6928.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wecj4E+D/1lvuVCBdWddJThc0Ka5w/L4P9Vjj6Jt3gggpx/sjI3uoC6SLX38rZKMFVYh3gzSGIrD5s27MyHWPb2Rk3TXKWvnGhH0+IV/eppuSYlbs70t17qatiJsTx/+xSVQJEDPjs5VPWxDrKJeH9VKtxLBC2FqhP+JP/NdfAItoNm8tZ76datRW1zr47Uf+FtNLi3lvrcoKWH45oRgeFT/6u+X2DmDy8GGscRW3YxZPK5iNOKK6b1CYP96E1rmg1CuvNtPQ1C4OmnTDJnVgrHVWxtl4DEZezVQChgoDuk4ogU+7T0Rx74zh+7xZ89pBMbcMVuappslXzynr5YWLfvHXZScFXl8M2YRqKVXOwA/f6Ez6MhIy3zD+vij84f7nIg51yhGJOe3mz8MHuyXYzNcDkhIvD8TM1mNyAG1IGv2PGcfo6oRgFaUlrT0E/eoFJ162DAxZE3SCjPO8cJjIRBA9lL7+urpZ0Svf9OlmkgO64kjYFwkKEMb7VTPFYH+ObzuEKHtJ0GIOnEFAhQQlpsHJP4bREGS1FByPHYvU0CMIHheNhyFAI09F0MCoHmjjy4A+aJgaUW54hQCmCih+54NYBGvhPI8R+My5wpuo5qfOsHZTqylBvyMYQX+aFRb2GagN359yfolWWyuI0DkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(4744005)(2906002)(4326008)(316002)(6486002)(5660300002)(52116002)(6496006)(38100700001)(6666004)(478600001)(8676002)(66556008)(16526019)(66476007)(36756003)(8936002)(86362001)(66946007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UDVNT29wcnRqYjJ1ZWg3dHFFbW5oREZJVHNUOHg0WDc0Y0FESFNDaVdvZktt?=
 =?utf-8?B?SXFMK1RuTGpVbllGQ0xWWUFia1VTY2x2OVdXM21aMENKZFVULyt3SU9oR1px?=
 =?utf-8?B?bVE2Wm9MUXpRMzR2amh5WmJPYzVVdW9DU3hWMnN4SDFFRWNSTTd3L0FQZ3Vp?=
 =?utf-8?B?SXFTUUU1MnpkM2NQUTlndzZDTEF3ZnBKbmlJS1pNVEJ4SEhtSmZMWWdUL3Ft?=
 =?utf-8?B?enJLT1VyaktkMUREOFJEV1lXNG9zbVZSbUFxL3o5NVFtUGNiTjNzaHlUU3Fx?=
 =?utf-8?B?Q3pyT21JWmZmREx4dUdxM2puTUNjZk9rN3FTekhLMzJSNUtseWxZeGpaL0xP?=
 =?utf-8?B?U00rUGhsRXdGOXhqWjdocE1vY3VlODMyU3AyVE9VZTJKbDJ2RUZpdGdJS3Yv?=
 =?utf-8?B?dzdiTVNSallBZVVuRkZoU1dGQ1Z1M1p1eDhHMFpadGdkaUFKalEycE1jdkNC?=
 =?utf-8?B?OW00NllTRlVRcjN0MXZrZWtqVUk5WE4rQTZjazEvckQ2S1BaakxTQW1BZ05q?=
 =?utf-8?B?TFpMcG0zLzA5U0ViaUowT3g1TDkzeldoZ1RFNFZMQlo5d0ZJK1RhV3VUN2Zn?=
 =?utf-8?B?UEpwMm5wK2lvVUR6bHdXT0ZzMnVkTDlYOFBrRkE0U0JUWHVTV2JnV2N6a1Az?=
 =?utf-8?B?c3FIeDdkVU51aEt1eGl3UDdyb0xiZ0t6YVRPa09haHNUL1dJQ0xIelgxanZT?=
 =?utf-8?B?M0N0U0plV0ZtY1JvR2JKb0F5bThZUTNPN1ovUjZhQlg3TzROVjJaQ0RnazE3?=
 =?utf-8?B?ZURHK215eXcvdDNVbEs2ZFprWm9USW9PYnVBeDAyVnNoSE93Vm1TWVNvamtQ?=
 =?utf-8?B?QytOSU1kL3B2VG50Y0ZIZDVJWFA2Y2NtQW5BWDh0TVlrem1MTllSempzSDBS?=
 =?utf-8?B?bEtaSzZteGJ5VytESndCUXYyUmh2Ty9KRHhKSDNnUUNPUHUrQnFHb29KUjc3?=
 =?utf-8?B?NFRHZEFkbFlCejgwVUJsM01oeHJ5WWs1cFgrUXFYTGdXK3NjSmx3K1BXbGRY?=
 =?utf-8?B?TXA1aTh3UTVnR0FEOHBEUFZMamxENDYrU2IrTFNjSHlDU3lGaVpxdlZrSmtV?=
 =?utf-8?B?M211Mkt1YTdWWlM0S2Y1QVVpeWpGb3RVV3hQVEpUS2tRcEN3QVR2VWRkSVEv?=
 =?utf-8?B?RmJXSWptR2VZNGF6TkZ0alNHbml6US9Ga0o5c01QTEFycm1seXZINmdYdHdz?=
 =?utf-8?B?RE1senhVQURrODRrME9QYUNEU2xwcFpxZkhVOUUvaG8vSVRKK25LZUNiamRV?=
 =?utf-8?B?TEkzb0FDKzAzbTd1NHlxTmhIVzNZVTE1eDBMZUp3amp6bHNJdnpCR0NHbGl1?=
 =?utf-8?B?QjJLVGRPTVJ5RFBoQUYzcHAzcFJSTXkxakFuYzZMM0R5ZWJPVTBTb3RRUEVV?=
 =?utf-8?B?bzl4TjV3MmVrd0g3L2JtWDN4SFRsUzAybWlXbWJKelFOV1ZBY0wzU3IyZDgv?=
 =?utf-8?B?a0ZhVzFqKzE5S2lRMEtkdmhKcEc2dmtBbFlzeGVrcHdVM05vdHUzWm1Za2Z2?=
 =?utf-8?B?TkQ1Y2FJWmt1NWl6cUJhNHBzY0d5OWgxNzJZK3dOV1FmQ1RsMDVVeFBRUVFj?=
 =?utf-8?B?YkpPZVVUMlpLNnlsUUxKNkg0NGY2M0VxdmMybXF5dFcwSm9Qc3E0RWVxeTh0?=
 =?utf-8?B?ejR2S2tjbDg0RUk0K2JiaHNYbWIyMEwvcXplV2JNRjN4UWlkSG1SSDhPOEpv?=
 =?utf-8?B?dWppUC9aMUhvUUxGZ21Vb05lYk1WTUtuTGlpUVZMdTVuQllxTzFhRm5IQnNs?=
 =?utf-8?B?RU5ucDk5ZHBpdEQ3YVhwVFpEc01DNEVWYjdpUjgvTzZySDBST1UyVk10MHVO?=
 =?utf-8?B?anhXV2VRNGNsZWhJTUNRaHFYdVNDRDR0S3VvdGRSU3N1bkp0Ty8waHRGa3o2?=
 =?utf-8?Q?6pt1FFB4hJ02x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57681a1-fd33-4035-978d-08d8ed61a94e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:38:18.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6B7yoQQmhCMJOSEtqwGaQM0R5l9DzuGxYqGSbZltF2uzxgOLM9A1k+KGccKwtW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> Either the key comparison or the hash function is wrong here.  *IF* somet=
hing
> external guarantees the full match, we don't need strcasecmp() - strcmp()
> would work.  Otherwise, the hash function needs to be changed.

I think here we need to make the hash case-insensitive.

Perhaps calling jhash() with lower-cased bytes like so (pseudo-code):

static inline unsigned int cache_entry_hash(const void *data, int size)
{
	unsigned int h =3D 0;
        u32 c;
        u8 *s =3D data;

        while (s < data+size) {
        	int len =3D decode_char(s, &c);
        	if (!len)
        		break;
		c =3D tolower(c);
                s +=3D len;
                h =3D jhash(&c, sizeof(c), h);
        }

	return h % CACHE_HTABLE_SIZE;
}

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

