Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1216C388A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhESJOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 05:14:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:25075 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230211AbhESJOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621415583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=506OdaHFhtYpAhUWQVRFGzzNx2Q3kE0HOWiYZO07ioU=;
        b=SO2YXd1UoppEyvPhFmxG2uHuyZyeP3LtRJEgEPSy4hi06UjKp9h5MpJ/Vdru+URgjb+Stl
        0WGLzGWrSCyRKGnVBHd9Z00OoIR2MAsRXkosHrbZQBAHQZYTBDhiZ9Dfg3RiMsfcFbiD8Y
        aFKU9Ok+mMMxPdm6h1tRpaYKHzU5BZA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-DGaDFxMmOu2daU7NJQBX6A-1; Wed, 19 May 2021 11:11:59 +0200
X-MC-Unique: DGaDFxMmOu2daU7NJQBX6A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASgXhfAzXvqTOLX26l2yzKfcQUYnwTSk0zlGQJuuzvHQFQYoo6kZgl0RuW+k7obff+pLb/w6zr5envvilHWbHa/9LzLkXMchGlpIwimZVAweEd3yRgJO9Vu/z2hI7mdp0eMB3vAWafaH/ojV/BQV67YZtuVk0tjh/vQ1gkeTraSKTZOTfpydWBtT60JDVsXd/MdDxRai7HFFStYO+x0bLdfU0j2YBDVqmSiz8oJpHSvAapGZGtmAxOD+VcFpVCfHQdD82oeoSOhf9pW/MxkEK1TQdUOh+rbySohsRSo2FYORgAmhzOYqiGhVMPVC0dB5D78QFV9b1z/mEsws6g6DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=506OdaHFhtYpAhUWQVRFGzzNx2Q3kE0HOWiYZO07ioU=;
 b=TG0nsm1B2t1xaLpoQuPkLP2bjhTc0f7+nIdhUJs/uRSzpJSEcSpX5zk6m0Nm7DYgFbcD/q379eJyDC0o8OfKAoTiwzChPTCDSU7WcEda9I2+hyQZrWjwD5NuqZRx3xekaLbM5n0F9agejrxyAlbQ4wQ5YHwEjR6Xpc4TLbd5hDJhrWykTm61lXy0gKIRaNSU7i7XKRSAGst2oeHXiOozN4U+uUjHYDmteOOgk6ID8L01IxbRDu19VIv/z2sKJn5eG2W19zjpEZnnyzrdNWUCS/uAEKL1YUttA/V4aDmqpQowgbU9tiMK7SJg+ZP00T9eNn7YIJ9brf4O+thBUFdtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB4669.eurprd04.prod.outlook.com (2603:10a6:803:70::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 09:11:57 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 09:11:57 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fwd: [EXTERNAL] Re: ioctl.c:undefined reference to
 `__get_user_bad'
In-Reply-To: <d3e24342-4f30-6a2f-3617-a917539eac94@infradead.org>
References: <202105110829.MHq04tJz-lkp@intel.com>
 <a022694d-426a-0415-83de-4cc5cd9d1d38@infradead.org>
 <MN2PR21MB15184963469FEC9B13433964E42D9@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAH2r5mswqB9DT21YnSXMSAiU0YwFUNu0ni6f=cW+aLz4ssA8rw@mail.gmail.com>
 <d3e24342-4f30-6a2f-3617-a917539eac94@infradead.org>
Date:   Wed, 19 May 2021 11:11:55 +0200
Message-ID: <87r1i3qe90.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:713:d341:3455:1612:4218:6466]
X-ClientProxiedBy: ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::12) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:713:d341:3455:1612:4218:6466) by ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 09:11:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c1a8c9-8c11-4ef0-a29b-08d91aa62756
X-MS-TrafficTypeDiagnostic: VI1PR04MB4669:
X-Microsoft-Antispam-PRVS: <VI1PR04MB466903EBCD9F8F2D7031FE0BA82B9@VI1PR04MB4669.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFYJKpXc4itZJrKLP0tDCumWu80EjkTmUtciznwPd7PMgnFMoX8SJb46wqfFu/C/ajEYiS1lhlP6C1zr454Ly+e+HGiq/QZ7NRB/dORBbt3vhHluYSLHNCF+GEBw4pkAVN0qCFHUeXodmUygZxzLKslfSHKBbkLZX3EZvKbbXsx0szq2+gKKEHo52q6v7LcXOXllqOUa7W2xqJV+qT7lRR1Nlc3F0EJEQu1QOtvoOk6FaDfHJ0VFiAoEX3GpSvEZUvWdQbyeMg78y5sqfjNmajqzH+XXlECm6gxqbt+a15nAfkJsZYQV3rRyxV7fQj2Mle7RWwkKzyQef8gwYJZ1fW5VafPW6+G8s7xSJbgpmh2SBT7n40xNeUzhoYUs3xseR4hMphKGs94QImW9m+BQNhB+bjqIstpcDlHccFOTiRdGbQfMEgPhS+YZrt/gBUXgLazbbr7c6rUocTxR0ohwkWt1xVoU4LpZ+E5qPuiOVc8bF/knzbgkHfAoNxXIY7Gm9eicE7bFHLI/hLo5FpNE24pp8hfXxm9X5yNv4y8AQYNtd/enr8B7/w9Jw3PdH21Z32JZm3URcURMGDfpTBhzyaxPmJDxAfhspEBU3Yy/Ul8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(39850400004)(136003)(4744005)(66556008)(66476007)(66946007)(5660300002)(8936002)(8676002)(316002)(6496006)(186003)(2616005)(16526019)(2906002)(478600001)(110136005)(6486002)(52116002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZlhqMHhOV3ZEZDB4N25ZdzcrZU1tRklIbmxVRUZySkJtSWVBT1RPZFd0Z3Ev?=
 =?utf-8?B?bms5M3JJeHJxMDJzNXVDM3V4UXgwRnBMM1JWVWY1clF5TjBVSTdOaVNoSDFP?=
 =?utf-8?B?aFhZb2JZdTdWaXVoVXl1VHlGNDBBSnhZTmNyWUQrVk5JOHowb2R1akkvUnk4?=
 =?utf-8?B?b3pDRGxpaDMrdzdDSER0SlFJSU1RdytYcWtSQTcrSEtnRFhNQVg3a3dWSzY0?=
 =?utf-8?B?U2w1UndWZHpHSFJxdjBMZUxyc0R1RHovb2FWN29BSjB6ZlVKUGxtWUhuZjBp?=
 =?utf-8?B?UVEyUmx1dG1GbllEajNGeHVHbS83bHFialIzVjI5Q2lSQ1lvRnlwM3REUGxt?=
 =?utf-8?B?dlNhSlJWQm1uS2FrTWRBdVRWbVl5QWVHMHlPbkZxbEpOcnRSZTlucm5RYWtk?=
 =?utf-8?B?dDlIZndQQmxWeGY1a3ZQb0ZOVEdiREVUK2M3dFZlYXlqMzhrcHRVTmNXMEJw?=
 =?utf-8?B?QjYzNkVkOXp2OGVka21NcUs3RjRGR1ZrazR0dUp6Nk4yeFUzZEtJR0FuQWFZ?=
 =?utf-8?B?d29tNnVvQmZPNmNGemdYRDNRTHRpNituUnBZTEcxd3pYYXM4K3pqS3kzc1RK?=
 =?utf-8?B?UEJxYUo2Qm9FS1ducDJSZ0ZCNzZTdVJXeG5qVmNDWGdVWEtLazRjd08zOGF5?=
 =?utf-8?B?WnVjZm5RUGtVMTRGOE1sbkZ2ckpZYWQ3b09DeEo0TGM3STE5blFhT094UU53?=
 =?utf-8?B?NDdQMVRzdUNSS05vZUxnVzFYWWdkcDBCKzkrR2NLcW92eklWeVNwUG8wcEJw?=
 =?utf-8?B?NUZOdkh1dGZqcHRpTnRwUUl0UUtTb2UxeEUwMnNJU3oyekxEUEo1VjV1NlI4?=
 =?utf-8?B?b3h3NURCcnZmS09lQ0hUQU8weTk2S0o1TW4wdGJVOVRPUUlzdThjUll1WTJh?=
 =?utf-8?B?emtwdHFkTjRXK0pNaDRiR1B1RG1ia21DS2RJTmU2OFB4eWZvMERoOXZqdHNH?=
 =?utf-8?B?Z0lxeEdnemJENWZSVHcrQ1NoQ2NuM2lUN3ZEejJRQXZORHhwaTVKb3BScGNo?=
 =?utf-8?B?WW9RaWsyZnpRenp1SlhkenZWZCtNZUw3QVFNeVVrZ0lhN2Jra1hGT2RCS001?=
 =?utf-8?B?VENSdHpDRXZza2toOEJ6UllyODlHL3lKTllQM1NkMVN3Wk8ybEZQcmd1bzM3?=
 =?utf-8?B?bm9OZnliTGRLeGF5VmxKYWloOWdiTTIvdW5tN2UzZU9FVldSSkQ1eDN2TU9t?=
 =?utf-8?B?R3NzalExOTdpbGJMaGgzcE5jNHZud25RU1duRjlmQXRlbVk3aVVMa0V4Z24y?=
 =?utf-8?B?dTZ4aW9tZWphSS9Ja2g4ZTBOcGNoZFF5MXJGYmNsdWZ1Q2JVRlVhdXlCTGtC?=
 =?utf-8?B?NUtNMFdBc3lma3lUWmtEd3VQR1VDWGt3eWVPTTRMMDBBZnBLS0RqL3pLaWRX?=
 =?utf-8?B?blp4SjlVdG5LYTc1QVBBcWpyUWdTTi9uNHRZUGNTNzBFMzNiQ0ZGWFZ5d0Nx?=
 =?utf-8?B?VDhidzQ0ZVJjN3hacU9zVzQ5SHI2UHpRNlMzT2ZNWnEvMzlWaVF2bmdVTnNu?=
 =?utf-8?B?U01xQWVtZk0rd0o3eGFHWHZGcFNhbVNsMDZXUng0R3ZncGtrRDdGbzJGdUtK?=
 =?utf-8?B?eURBeVVCS0VoakpkOWRNZ3hOdFE5d2hwbnArYXQ3clc5aEpYNlVTMXF2anFs?=
 =?utf-8?B?WUVxd0MyWEVIWHd1RTJIQTZJUnVhV2IvcUtoUkxaclU3WkxTV1JqWEJpWmI3?=
 =?utf-8?B?bXdQOVJNUFVPN1AyNmJ6Yk1KVEVvMkg5TytiQWhqVWtjS3JhWmU2OXFDQURl?=
 =?utf-8?B?UWd5Q3JydVFGTzUvclFzTE4zeC9Za0N4UTdYckZ4aXk4MHhJbU1RcjdXa0l1?=
 =?utf-8?B?SzhtREpUeEFQNmV1WnBOaS9RQmMybW9iaGQxWStWVitSRzJKYXlFenNNMkcv?=
 =?utf-8?Q?W8QHciLe+sEro?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c1a8c9-8c11-4ef0-a29b-08d91aa62756
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 09:11:57.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz0innXN86VI3P+TvQgrTd+2i3BdRIaKKUZIrebkWio1A/8tqhyERDSg6WyMXH40
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4669
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I am working on a rewrite of that CIFS ioctl like we discussed, and I'm
not using the get_user() helper so it should be ok.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

