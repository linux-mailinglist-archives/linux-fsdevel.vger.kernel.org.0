Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0630F0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhBDKbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:31:42 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32514 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhBDKa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612434561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aBP0yZZ5Fcbmj3srGNBrjAQeibYtYRz/AaqkldShfk=;
        b=FKWb11kn6aekHcNYASZP5YF9sC82R1Crq5ei+D3cOtK0ddMT8j73xOf+o9HmtIBnPjKKhW
        xXjxb2ECR/34daxuw7znjEaMXPqUtycwkVdmYaQaXNb3Jlah8I82oLgXrCiVZuQNRgAUMY
        Is7UH1NAOm3+0TEDE04kd2IheAVUfTE=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-9yPKTVzrM2atM24peA1KaQ-1; Thu, 04 Feb 2021 11:29:19 +0100
X-MC-Unique: 9yPKTVzrM2atM24peA1KaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE0YUX+18RtJnp8ErtbHay2ZCSti/BOGiA4JuTCtHJgaZG3IM5o3fVpIvkZKBbxLvCRlp3EkFQzBxNEKxAg+gDGe9mLedTobFAfYr0gOODN5NlLpVw5t4shOMSsWidiyPzcuJGM7p6C/3GSVq1ZxPtl9Tks9fwbRZk+nbsOwXab+WwSJYimgfVVD+2MWX9fhH6AW1CKvUJrj6S49Gi6IfZXj0UxK40BENQQXVxqv/FDMf5ha2eNqzesroIrm6yzdGHba5SjWHBhYAAUGOod0qWwjdzMoD0mEQLXMj0uK8h5m4S6tCo0s9pH0sB/O2Zdq+MtJ8gM5IkTArvisgwT89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aBP0yZZ5Fcbmj3srGNBrjAQeibYtYRz/AaqkldShfk=;
 b=DJs0to90NUxzJHzjTMw39KX8g/FFO7g0l/6z2ANafTNvz4eMgUn/QEiP0nUDj1vnqPZdMUvQuwzH8aCAohqzZnKPbFjJiPKTQdueKp6oUw3GzC9HBlJ2nDJ4Y1feoKiCci6G6BLqkyFpbL5bbqNOREVCcLEw0IoAVo9NssUA7cuwQcJCNtxftaLji+OeTaSdIS6ayadiaGsaT4vhMR7f2CrDqSd5kn4NiG3qEeVZq8pAvZlFqCq/ZMxIwzO6XuupZsoNczqwMh4CpxVt5kYZnX/kcMg9WzwlYF4Oh2oS5mfGPKFRy+IUdV5M5gJ4kenyr+nF9jCKymFx58D/vjizMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB5550.eurprd04.prod.outlook.com (2603:10a6:803:cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21; Thu, 4 Feb
 2021 10:29:17 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Thu, 4 Feb 2021
 10:29:17 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] cifs: use discard iterator to discard unneeded network
 data more efficiently
In-Reply-To: <CAH2r5ms9dJ3RW=_+c0HApLyUC=LD5ACp_nhE2jJQuS-121kV=w@mail.gmail.com>
References: <CAH2r5ms9dJ3RW=_+c0HApLyUC=LD5ACp_nhE2jJQuS-121kV=w@mail.gmail.com>
Date:   Thu, 04 Feb 2021 11:29:15 +0100
Message-ID: <87eehwnn2c.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9b05:ee03:72d7:dd87:90d5]
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9b05:ee03:72d7:dd87:90d5) by ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 10:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf7514e-8b35-4a95-a47c-08d8c8f7b997
X-MS-TrafficTypeDiagnostic: VI1PR04MB5550:
X-Microsoft-Antispam-PRVS: <VI1PR04MB555076BFDFE6F155C63FD8D7A8B39@VI1PR04MB5550.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8spsbnI6ilMvObFmI2CAE95JSSepiKWNVvwy4mNy2nxaQTKtsrqRN4BwYhFsaPoa0f8HxT1wpSF/GrOS+pP1dY1qtyCEai28Cppj7U89MwLe2yUfzEQ3couJdINIJutnYKWWJs/w4SdTpvBIVl9L2H36+4TBVpJU1TOPxYevizQCghre872/rz7S9etP2xaYAe8G9uzfyBO2ImUbC1QFoeWVXD8e7xqlvTWteW5ZtPFkSoBQdxJ7sLi865WnOb3wgkkjLw675ZZrbGukVj/JvFpKOpD/HIxVkQnZmJnNJJ0r8uicCqVQcpFurBp2djJ0bAaWMKUceKKWA78TBKMqQdpa1IivsCsMP0DWq3F5gLKWyrLhC8HU5CZc0IWKgggrWCFOrKK44zZY0kKCxbQf5zpBL6AIuUTcPDvv8w6xJYmz6rDVF4H0hvpj7X+RXU12xXSEinQdI4BtHDQc6mdWnLZatEzWBgrTwcQh7pnaa1Xww2mTpJ+Zr1Bt2yL355RCRHSd//Ty5sDg/8qeEfmQ+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(8936002)(86362001)(66556008)(52116002)(66476007)(66946007)(478600001)(16526019)(2616005)(54906003)(36756003)(186003)(6486002)(4744005)(2906002)(8676002)(316002)(5660300002)(6496006)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmYwcTNWdk5Sb290MkM5NUxpRlFVWS9FVXdDNTdRSG51ZDExdlYxUk5hSjQz?=
 =?utf-8?B?aWErNTc1eUJEU0ZPd1dZWmkzbENuQkJ3ZWI1YlZicm1tSElWeXJFcHNvZk9u?=
 =?utf-8?B?cTEyT0tZUVN6Vk1xOVprTmJWenp6TS9pUHgxUW9ySmNSMXdpUDhWUmdkaXho?=
 =?utf-8?B?TWh3VHBEYzZOOVpMQ25DSlpVVVNWUWRPMjhQaWliK21XdlFTZWFIN2I0ZnVv?=
 =?utf-8?B?UGdEMWhzMUtwNGNLZUpETEEwM0kvWThNUDJJdmhJQ2pUdDFFK1RWRTdDZFhW?=
 =?utf-8?B?VGxxMys4dVViVlBOUHBWWUdUOEsrTUcrV3lDclZ2cHIxZ09LWXBZdkY3NzRS?=
 =?utf-8?B?OG5lM0psQ1dURFlUeHRHaHg3NHNTQWRQb3o2SWxpSU5YcklWQWljRnlUUTZk?=
 =?utf-8?B?cHkzaHdicFhSZm9HdjkwYkprVjJPemlCc1VzZFpXMTRzSnZuRWordzdqOHFK?=
 =?utf-8?B?dEQ0Z0Z4bHBlakZpVzRVR2xNcEpTcStDeDA0STFWUHR2cEJvYTAxSlJyc0Rx?=
 =?utf-8?B?SkdvT21KekQ4bE15NUYydUxmL0EvRGhFWDBuVUE2WE1pWnpHUG5sZDBTK1Nh?=
 =?utf-8?B?NUs4cklGeFJCZG93eno5cERqNjlrY2ppbzZmckhmK0dnSWFRMmJwMG9wVXhS?=
 =?utf-8?B?QU9DL0tML2lPNHhHbTVSSTM4WDJUeWNlRTJxOGtXU0lYd2tKUXo4RXFKaHlz?=
 =?utf-8?B?YWZJdysxeTJOL2pPV3RwRG5mRE1ZRVlTd2JaMzQ5dExQWDVvTGhwSWg5Ny9y?=
 =?utf-8?B?b3N0QnBGU25ra2dBa2pqUDZlWXRUQ2FFRFZEUEJMVG9tcVoxREdWRGZ4VnAr?=
 =?utf-8?B?QXZrb3dwaTZyN2IxTFR6ckoyc2VtSVpJaTVlRmpVMWlNVkpNRnByL25vNWh1?=
 =?utf-8?B?eXZrTUpVY3ZMeXR4QzhEMDl6Ly8zRDFLdWFSZThOdkhYOFFTeTJZVmMvMEJD?=
 =?utf-8?B?bjhHS3Z4SGcvb1VCWm9EdDFPL1BLQ3lIVmdJbzZyRXFPM1k2Z2toVDhEVWcr?=
 =?utf-8?B?WXJ0Ui9PMG9jTGZ0QVl0Z3hURHgvTnUzL0ZNM3hKN25aQ1lSNllZNzYyTlpD?=
 =?utf-8?B?OUdpczdVdjdnaWh2VUpaOXExMVVXUDJSV2NiQ3ZscmN5VHc4SSs3RmVRbGgr?=
 =?utf-8?B?KzBSUVJJQjVQM0ZJVGhvbFZJbUFQUkVid1pwa2d0VzhjWERlUWxWai93ZXBr?=
 =?utf-8?B?WFlVMEFLYVlVN0E5cFArQm4vOWVHa1c1SDAzZXg4N2J1aWJaK3pOYUl6YmEv?=
 =?utf-8?B?amRQa05lTTZUK24vZFVtazl6b0F6L0tmSEM5eU9teERCMVB5OHBiNnNSSS9P?=
 =?utf-8?B?dlZRLy8wZnhYTDJTRHZJVFBOS2xIaVFmREZDems2U2s2WDFlQjBLdCtGbzNo?=
 =?utf-8?B?Wnk4N0V3a2psWkloUkVnczdLeXI0OHhSeElXZC82YU50OVdwNU1MRXJLeHVR?=
 =?utf-8?B?aitzbEZMNStHN3VtK0RTT1JqL00zUmlmMURlcmJJODZYV1lZd1kzMG1zbEtW?=
 =?utf-8?Q?+bsM1v1+Ib55YQj6ajl4Exs4Zl+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf7514e-8b35-4a95-a47c-08d8c8f7b997
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 10:29:16.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7cXMiUH9+tLRn1jv7yNuZAIeMHQ3WVTfCwP8xw1ihrTn/OVDRC9y5vX9VCX3Ry9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5550
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steve French <smfrench@gmail.com> writes:
> +ssize_t
> +cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
> +{
> +	struct msghdr smb_msg;
> +
> +	iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
> +
> +	return cifs_readv_from_socket(server, &smb_msg);
> +}
> +

Shouldn't smb_msg be initialized to zeroes? Looking around this needs to
be done for cifs_read_from_socket() and cifs_read_page_from_socket() too.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

