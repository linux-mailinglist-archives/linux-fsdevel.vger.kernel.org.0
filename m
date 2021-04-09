Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765D4359E6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDIMNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 08:13:30 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:23268 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhDIMNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1617970396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmoIUx6okKo8fv5MfCPjE4a9WGKuOXMXpAW+OGkKb3U=;
        b=Wn158RbD0wlVeY15fZ2/D5/pQGWLyoAp7kWs8AzJpNuo8ePcxkTD/JIoGA/uUo7QSXKZ3q
        +/uCkK5Ln4kMtLVHTnulcPWncmm9q7xrtCb+W6b16lqkABt+SSDc1eRApchwxpo0gDvKfm
        72vrMTPSPjXbDrUmw2eRc9ybP73MjMs=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-c0llpcEvN4-w8HlvhtCfJQ-1; Fri, 09 Apr 2021 14:13:05 +0200
X-MC-Unique: c0llpcEvN4-w8HlvhtCfJQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnN3IQj8h3997qcbHDnxDkejRYrP3buU22Fy8NzjpnV5tRr0Xzo4j/qmMurYLMnF7hSq/34LgY1eZxhpSz76GiQCIe49Pfz5ClE0HjJUnVpJ9mXhiM9fPnPddl/yVj3QzFaZNNIPOtZIMQJk1NAMhzCEHJN3dqSzvkOJv+CI05sBu+wQMrGB7y1KS+YGkyReYp4uiIRS2tXdLoc/bNYaAlXlFOhTrLih2sHwDiRSo6KlioA7aaYRVF/h4qTnsUCEhRaXZEDuNows/0c3krE4/bweboSRYkv7oMhPJDMvHfxax25CDf7K4bAbTazSlIXr3iI9L5UhXzGv3qe7rtyagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmoIUx6okKo8fv5MfCPjE4a9WGKuOXMXpAW+OGkKb3U=;
 b=ndEZQsOncw4diZyyCuuTXrNgb56wBVA4KLHp7Jh4sYApue6iFkegHEAduN9RB0GWyqGltxXTit1Yy45cIMDBiUsx4Rk3s/M2n9QOG+5c02TSYikenYf+ZEyjxl3nidtP7A2MQAllD0fE487ck7hw/RyPJy+6Z3xJZeTcA/xIiAcRF7kNOfwFLYYci7xnAmk05Pb/+QeLi9cuHBSRfH/TLE+tP3S+qjJUlszOx2BjIK77pFE3sNRmtg9UbW6sAtx3XJlbVDhx41hkqaZXodU1rNIzknkheFWOiEUZwoN1XB+/lPnWdBh5WBtwr+SWEDu0ECCA51zb55JkedUPEfzbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 12:13:03 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.3999.035; Fri, 9 Apr 2021
 12:13:03 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>, Tom Talpey <tom@talpey.com>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH v5] flock.2: add CIFS details
In-Reply-To: <20210322143024.13930-1-aaptel@suse.com>
References: <CAKywueQkELXyRjihtD2G=vswVuaeoeyMjrDfqTQeVF_NoRVm6A@mail.gmail.com>
 <20210322143024.13930-1-aaptel@suse.com>
Date:   Fri, 09 Apr 2021 14:13:00 +0200
Message-ID: <87wntb3bcj.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:3046:69ee:cad4:97e6:ea8f]
X-ClientProxiedBy: ZR0P278CA0159.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::8) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:3046:69ee:cad4:97e6:ea8f) by ZR0P278CA0159.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Fri, 9 Apr 2021 12:13:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6f349f2-bdb5-484b-b98a-08d8fb50d307
X-MS-TrafficTypeDiagnostic: VI1PR04MB6928:
X-Microsoft-Antispam-PRVS: <VI1PR04MB6928D6C8D7FC103EF6911D0CA8739@VI1PR04MB6928.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STP51MXM3taMSP9f2PAs0KS2uk1rnZtz923+4+WoqJF8JYAn1ztLN+08PTAfQ3JhBTRObcAbDhC7VkG2azJgttNgynxAF5f4/TNGnSlAcwBsZbOYKyXSo+/fo0KQVzfdII4fDSnznGv+r4UPGN0M9U8q5U0XyLqqGBL5QiIMtCmTlV3HBZ8XmIw3SJjbCyvHiXjUUdOvBMUidBXSQ5m6av/wALVfDHExTaBYmEjVA5/mxiepYbbn+fIZc3btok29omIO9ZtQCuRGWycRO/NLIQ/+E4B5gWU/SFJZ3MLA1BFphPuUb2BGWojoD5ICKj1CTzokWAp/cO5HVITkwKWd0vJKGWNDRcqfJsXduFEAt0jHwBrca0LUCIv2i3oX5uhS8X9IuVLj+ARqC46NMlTqSg7DzLovuw0MJQ6nS0Sis9ZDKStWi19Zy6ZeEm9bc1p7aWsdnP8Rb92SvKhpH0fYyEgHMMdjMBxyIVVz7rcn9tmgW0WA9EItAwYXHxxsPcb9HExe7081Gveb00Ld38iizC/aAPOLyYaWPrYKzBoEH7fX+TUDvMyDsp/hG8i9eatapjAlAclJIyRYTFK7Yh19R1nrI0YT9QINmsLariAI/iHOBZQkQjmOMLfMBGE7vB+l/tYUqcfMwaz4pfNFfgLNnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(66556008)(6496006)(2906002)(66946007)(38100700001)(66476007)(558084003)(52116002)(2616005)(6486002)(86362001)(36756003)(54906003)(110136005)(186003)(8936002)(478600001)(16526019)(5660300002)(316002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWFJMXJJOTA4bVFKZnJOR1Z6WUVxT0ZtR3RodmxiYytCNVZKYjZ3YWNXaENV?=
 =?utf-8?B?VGJjQXdkSmc2UXB2QlM2MWIrY0NHdVNJaEdwaDdQMzIwQzk0UUN2QkRtMmgv?=
 =?utf-8?B?dk1sUnJIOXhGeE9MSzkwcFBPRW1tWWNiYVNyRzdFQXZ4Z1lvS2lrMGluUU14?=
 =?utf-8?B?TnFhcnBVcHFuLzFibHFCd0o3d0Yvb1h6ZERoS1lYdnZWckNFVzBUQXcvem1h?=
 =?utf-8?B?blE2NmJUUUw3T3NBdDZtZHYwak9XR2NNSWZFQjJqT1o3NTg5OEZUcFJva2VW?=
 =?utf-8?B?OW51a0Irb0V3UEtjNnRFMnQvTkwybzVjU1FwSWZXRDNUY0xsamFmamx6L3lQ?=
 =?utf-8?B?TE0wZXEvSG9kcG5aY2J4V1I3dDZiYkFJa255bkFYNlREL3V5dHYxbUVseUFL?=
 =?utf-8?B?bitoc1lsTGlFYlNrY1pxNmpxZi9OSDU3SGFYWDNlSjRvQjN5MEN6NXAweXNT?=
 =?utf-8?B?Rzh2LzVHRXZObDJKWUUvamtlYlVod0RjbFV6ZElFYkNWVThSa201SjZGTEdJ?=
 =?utf-8?B?Y0hGd3lMRm5EWWZyaXIyMmFjSFdNOGhEVzg4QWltbERoMGw3NjhxL2t0Z0ti?=
 =?utf-8?B?MmY3VXBWVmU0aUl4bmhQQjlZcmsyTjlEMG5GdVVMZ1hLYnM3bHMvV21IZUdJ?=
 =?utf-8?B?dW5CRGpiNnJuRmNBZ1dEVVZudlNxbG9wWlRqaEowY1Q4Wkw0dUt2M3VnajNH?=
 =?utf-8?B?eTBnNjRwaEhwZXBhenNORTA0c3FFaWhTU0JORGRURW1PK1ZqU1BjcUlmQnFs?=
 =?utf-8?B?dDZGRVBXd0w2UmVneUp2ZlpadzFmY1UrcFBXZ0JBNm9ObG05bmQ5K2RpUHJF?=
 =?utf-8?B?YXlBWHAzYUVFVjdXZ0lHaTVzaHRjOW5KYXpYUE1FTzYyMnpqQUhBUUZUaTRu?=
 =?utf-8?B?OFFwOGZma3VjSlZMWmN0ZTVIZDFPellxbEQwVUZ5WXJPbEhFRkxDMTVQZkhr?=
 =?utf-8?B?VFhsOWVRWERlTXRMYzhKNzJCMnpqU1NadTA4QXd6V1p0UE12bDhuWVdCK01s?=
 =?utf-8?B?ajZQZGthZFpOall4dHpkV1lzOWtibHhNVzBXUE8zV2NPU0NnQ1VxU1FlamJY?=
 =?utf-8?B?MkNRL00yV3NDeVN5K3R0c3JSTkJDZ0VROXVaQ2h2dGNIUlpkdkRJVFVHQ2lx?=
 =?utf-8?B?eExUcnFLRGpvaGdUN1FnZ1pQT0JURjRQcmZ5dDF4d3dJUnk4WDlmdlg0MU95?=
 =?utf-8?B?NVdVMXZUVC9aWENMUHNPOWVha0dhSDZqdml2MCtaMnJYZ3czcWJtZHloV3NB?=
 =?utf-8?B?RTBZcVBqSnAxUTc3eXpUN2RscG5lcHhaZ2FkZW1iK1dROHNrNGJNdnpjY2Mv?=
 =?utf-8?B?WWgxVUlhMnEwYnJROVZUcXArWWJnaDU2M2pZc2ZPL1cyUHRwc1BNZ0hhUlZF?=
 =?utf-8?B?bnMzdE1JdStmMjB2WlJWMFRRczhjWDFHSkcvN05MWldtWDlVWWlrUHQrZDFq?=
 =?utf-8?B?c2R2MWo5NGIvVTB5MDQrejBRMjlNZE9rL1ZXVkN2Z1p1NVNGZzRvdTNJODJZ?=
 =?utf-8?B?alNRV0ZKSGMxK3FPamZsZGV2Tzd0dUJBMElKZllWTVFCaFk3TnRlR0pxYmo0?=
 =?utf-8?B?NDZZM3kvd2lrN29zMno5bjcvYlpOMTN0aS95OXBmNjF2YjlTMi9JSm9uV0Jr?=
 =?utf-8?B?eUFxd3NaaHR6RnZRbFBmRTVIdkZNTVFSWGx4WjVOREpBM3lTSmhjSVpZSXBX?=
 =?utf-8?B?YnFMZXlQbGVpNkx2Qm8remMwek10Q0dwMnVUNGVIMGM3Q0UxcExUakcvcmoy?=
 =?utf-8?B?S2g5RDRDay84UGlBYVFsNDNsQzNSZ1FkUFZyYTRLdlE5L0Q2NHpXbFdZa0c4?=
 =?utf-8?B?YXN0VDBHY2IrVVhMc0lLMVk5UmJ5WWQ2Y3RtTStNRURPa2JtNWFmMDk1Y01B?=
 =?utf-8?Q?O+x15KKEdzyH7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f349f2-bdb5-484b-b98a-08d8fb50d307
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 12:13:03.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rsD9nmEfqcfykcgBr4NOkkr4CCu2aO3xXDsOKO9TkwsujYt0ej1P+Vx07rQo2Pk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Friendly ping to the man page maintainers

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

