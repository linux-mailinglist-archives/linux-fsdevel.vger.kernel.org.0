Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194B93094E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 12:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhA3Lb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 06:31:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54215 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhA3LbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 06:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612006284; x=1643542284;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ifhxRIDywkVQ3yhBHsKi24Rd/4FAJonAgsyOLpRlrJQ=;
  b=fU1OZSa0dqlW5m8ED47r7AEAekYUbmFBdn2Y0/9rLZ3eADFt+NcV5Mhx
   QN28iyVENLPRLYk9PgxDoY+Gcet7ClAnHw0YujlJzRLMVvZzP8J+fkP01
   Glat3u4LAWvXv1zUgHDYlHtmhJBMJaMLcV+G7eApZvNyyr/8HD5nbhYxm
   kg3be7VgeKVE5oSGSsMsd+/4oHQ+/58Toajv6GHfQnz2yPcptZyKhH+xz
   k8HdaNEJbylx8UiE8fRtFwHMjtiEVV32ITV0+JfFkrybLCM0/XKqSCjcH
   DyNb9kPwHfa70EGybZrf8gnKS20ArLZCpqMdwJminJ1GKrpxZeZOKYpTX
   w==;
IronPort-SDR: ZqaYK4GrOXjKVfinvBDHgOI8sir4lqCogOr3OQbPifGKDKcL5g7/1LLDbM//eGLW3ZPj9zPVzo
 RG7H3e/60CU6ZNqxJ7VOpFQUoYDTP5TApu7LemSG1HXA2n0C7mzuKVttb6kW/bWtiBv1UiYPVO
 9lnSPhxj07ThMLKMDhW6PIiPiBwewcvfz9wqvD2YbC0v4G3lkndsh4RhOpiNUpE7oL33VhqVW+
 UDsmRzlIefvvcoYMS0n1/ag4u158QfA2oYP4IwzyEmlyOi9yGzRKOZHdfmUQsaRTcVB29Fccc6
 bRg=
X-IronPort-AV: E=Sophos;i="5.79,388,1602518400"; 
   d="scan'208";a="159878961"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 19:30:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmjPxwc0e9sprTIVqFkMKLfza9FCQpo7ZBZ/dVkRqmXReT0nKIbhz0zerSMdUGT+WF8nhHAb0KfEV38EozVaFMwl51uZ37spTx2eBRW+7Yn624pswi0QtTWZGwaOw7aVW/HJsa4xc8Me88Lsnz9JH7IwbpoqFvk/b2H29CXeIXda8fai2mY5Rpuyhb5LQbaLuhfDe073UMmW/sD06Butqsd7AHZwK15XmD31zj3SEQlDG5nfPM9yNJrkdD+vm4fqvPgErNyxmn45GfHixh4Ln1pDnMFHWv2ge1tTzHrCBkhgfQBcGP7aMk7pJGlDSSIfdiKZSojAhE75eA8vJmhrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f+6SJuf6r+08tipL50nPRHPFgEUb6FgJb7ELvXcWvo=;
 b=Q4CSk3w/Sb0vm1UrPoorPvHzWaOr/rvETHSB4bPuUi9TLiUQQ4m1u85nGLbs/g38bw+zbtRvOn5V7J3NFmdeQjDbmP7pI4+p96tngh6gzz5LXODRbBs68VkyXtfzYgKXmmPLBRGXFYKV9nkh46+LLYDUTpsYRZ76vD8nSCDc2hGPITc4S005X2w81CUlxsfb946dYwySrtmvAaRdYaoVLz/tB4VRC2xZqGA9E/X8q0kAbHyJ+tmp5OzomC71ytLa86TlV6HLSIhvuPBMexfNP7J1icksarXOjjVg4HBCD64hglff9faQjnUQEfNqKCfuhMSQ1c/0hFHQGQpMlx2fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f+6SJuf6r+08tipL50nPRHPFgEUb6FgJb7ELvXcWvo=;
 b=qLCB+pPFvRWLcvBIsv0uI+17xFKpmjo1bOdz1Gh110KcL89mpub/kwZXpEz8GKOwMhrejof6sgrdikTENey7ag5msKYoY3aAgja4OFEaYi8FA80sypq9PGVKO7kYMbeEjsZkqVJ6PIwPPrPleg7Hj0TcVjvHT4RS2oC2JWgomNU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sat, 30 Jan
 2021 11:30:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 11:30:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v14 00/42] btrfs: zoned block device support
Thread-Topic: [PATCH v14 00/42] btrfs: zoned block device support
Thread-Index: AQHW9BnjelVVA5dvZkawooc/VUdIMw==
Date:   Sat, 30 Jan 2021 11:30:14 +0000
Message-ID: <SN4PR0401MB359814032CDF9889ED2DA7FA9BB89@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <SN4PR0401MB3598F3B150177BD74CB966459BB99@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210129204442.GN1993@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c51f0f5-16ad-4070-fce2-08d8c51269fd
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB48621893273A8E36238AE0E09BB89@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itkAuwJmAse9LWMQZUh5+Rkq3ggUDQNRE/fXml6zOREZTFZ5W3h0K9knpwt4fxLCkUrFDEE9pEBRKqmL78Nn5wtlTf2B3zikWNta9O57SDuq0JM8FrIGX7V/UtS45G7ke02jmVyQ2teLoiitXRfK5zwi5Qchc9/12SOfqq5LrD7t7Tv21DgwFQWHCANJLK33/qt87RL3PXmnl97RNAb+h/UMizTWD6zq60ukIwxK8YOhrZ2zOM9nOUBziFXQ43fn2SsXt0ThGkLpArxUT6xF95I+2BkZSkJ9LIu/pdziX2r0fF1RuN0d3iA8i/S3mCvX7/ADicfjmC+HNKzHrlvGG906vo+hwduU7V5Q1Sa21OAcVAu1onXSPROKc59VkJh5UfRZhuohbYMxVEoTF6JqpcnbGTcM2ZA70yEbEAKlEgJ0aaQoiuaqInqq7AuB7XnhlTePDDqanLIUe3eX5n0EpYKfaqt1Z+cRRdIZU4bfjOI17CRbosCNlw53+Khx2IpHAmKeOEx2FCs7HnU0yyIT6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(316002)(76116006)(7696005)(91956017)(66476007)(66556008)(66946007)(8936002)(33656002)(4744005)(64756008)(66446008)(54906003)(5660300002)(83380400001)(478600001)(86362001)(71200400001)(6916009)(53546011)(6506007)(55016002)(2906002)(9686003)(52536014)(186003)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d1hgH4udeap/wLzkQsFcIZaciuMIJDhB9MNmKzAb6qIsnEMKsqrhlLeL4s9o?=
 =?us-ascii?Q?8jaHy2lsDTfUkndPdIULJftDXVTZCQX7DkSMloDdXsSrU0M5LvQPLNeRvmTY?=
 =?us-ascii?Q?xSN+A+zWX6M4btMCtDmyZNSp8cgKsOkbTIo4dz+nb4tQ7OcXgU803Qfgze4k?=
 =?us-ascii?Q?hBFlX+9k+S6n2kL4+CFnKZ9hOm/0eGisxoBzcraG17p0kdexNwFmi+n89fBM?=
 =?us-ascii?Q?/G89RagWM6oLd2i6QLoReS7553ZbVLYqbIRBqZ/oovNdAjtZi8LUO6MJTMnk?=
 =?us-ascii?Q?Uv1vAr7u3lk3L6im4MZLDWLyoaDdSFmFWCWlyenXapGYBONIpoMewW1IR4qM?=
 =?us-ascii?Q?aupnVwzhHPJhXlDkuZdir4Cl1IFDljix1BlAg2vB4VGmmIoiYZ//wEyvf7Sf?=
 =?us-ascii?Q?JcRzh5FIjhOSCeJEBvg9UyOqhizevd0ayhdcm8YFEBN0SznCmyVEFNfEBXtb?=
 =?us-ascii?Q?6OLrK34fKsG+RuZWsRjyfQ+JwqtKodtGRt0cwhsjX56a5VMn5zBDD4hzKAOc?=
 =?us-ascii?Q?sppyvl5Szdic8Ca+wMMHT4uPEl4H5OyL34BHKhfQUCOoTNsQOLUOTGS3GQmi?=
 =?us-ascii?Q?mWUTR6uD0gPvM0BwFKS5NyD4y+kKIHYY+sM+ebfckU7/grKMsiwQoM9TzFOH?=
 =?us-ascii?Q?odO6sDRZadfDbql2hoLgY0BkDYF1mAIYQw2RNg5zUfXQMM+NKSdA8i0gtH42?=
 =?us-ascii?Q?aH88cFqa3k5i9hz2plY6Pj4+DZr7ZDh9T1LD8E670Wy+oCg/Y2UzzOiRPy+z?=
 =?us-ascii?Q?I9pn+uj8PWnQlVoBMC/3ujjO8gmVtR7nQ14QzRi/3jrCRO7NNgxNT/twW6GM?=
 =?us-ascii?Q?oR6AjdfNfPwDnDEDpsxb1hEKJYNlE/aeNk/mxbb0Yc/y5QX0QBV90NIBIZbb?=
 =?us-ascii?Q?NfzNQpSxtgjlStDoC2H6mIggSF/NUKWap/uIUlEzoI3pELlcwFXtpXRhG5Dg?=
 =?us-ascii?Q?gAprXyueoG6WqpKTq5UVvMg9XeDP9zOUJ3aB/6GnLBcCN7OeB1rx2kC2Sylq?=
 =?us-ascii?Q?zYH9H+3vSpgn5cshJ0vF8NfpWBIJ4hSjfscinT6AoteJgME9bFMUu3NbLtNa?=
 =?us-ascii?Q?9S7qW1FIvpl7mTl8d6iXoJOra3cQxH4G62bRzgqXa3YrkSju3+DIqJ21HgeW?=
 =?us-ascii?Q?n4Ow5xCbbnPafMrSnwXuTlYnMu+z0s3Q6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c51f0f5-16ad-4070-fce2-08d8c51269fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2021 11:30:14.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+2hy9Y3mFqYWWVKQ9PuYiqggbpePbeOUtXmgha2/PN6k9nKcycLE2/mce37B8qadmDcnvNXuceZi6Gg9ooB8TNSNxUzLqn2nZbyWY/QSrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/01/2021 21:46, David Sterba wrote:=0A=
> Yes it's on the radar for 5.12 because of the low risk and relatively=0A=
> isolated changes, I don't want to let it slip to the next cycle. I'll=0A=
> add it to for-next for testing coverage, merge will happen probably=0A=
> early next week.=0A=
=0A=
Thanks a lot, I've sent fixes for the build failures reported for for-next.=
=0A=
=0A=
My apologies that this slipped through.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
