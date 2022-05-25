Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC15341FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 19:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiEYRHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 13:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiEYRHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 13:07:24 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66461633;
        Wed, 25 May 2022 10:07:21 -0700 (PDT)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P3XNF2021952;
        Wed, 25 May 2022 17:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=/jQhZBxUP0DsfhfL2jXPR8uFyJBIiXu9/kxX3od3Twg=;
 b=b/Wy1qIiYbqNCufIGAYynVjqlzRrfPjQUbEF1Mhjp4+l8PYSIOx1IytX/6gG4tZAokCD
 h1kSyk//VhPP5sv7ueegqwYfVMMBlTBS6wDW9480nk9H2ITc1bUg2S5H8l8z37vfcqt7
 073SuH2QDaKjZMgEZsBpwFJBrcai893QBWSYLDSd5MTyA3mzCcKEWD4CWY4XDI5WIw/q
 9jLBIw46jpwjjnfVkxHPmoL2zcAUxxJWxW8aDqsiUI0+SgazG98mBMjr2bIj5f2/5TKJ
 rj2ukWeUAd3kdDnyWojvBgpiPEJ0mqF16elWKs3kiz2opXnTJ/eaLLfFVV4KbjM+IQXq Eg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3g93up96kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 17:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDF+aCfTLZSdXGIxXdaN02ri0RKC4NWiNQtHVpOABTKsDu+K2hmgqLTeBaLISBlpVVoZGAcP8HjlVbUwReQ8MxTpMjPPibajMG95dgtItDW3QDkiW/JJrU4KFXzzKQeFd8BS6yUsjb3HwVBFE7GczBHd0NVA6NcyYC1+3J2EIEyRoWZMJ2lumYI8vk4AOeMDRUvP29TYh0aJScLabp9uQNGM2IJrA1HDK+wvFK/Nvxn7iJLOY9b8qEM96+pp2UmzDFG/PRFPDbQpj+mB50ED++gToRbu2CxDYhboc4LS6k5Xyl+SPCJwtK4YB7js+BH8WWl++PVeqzvT6TP9iqkoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jQhZBxUP0DsfhfL2jXPR8uFyJBIiXu9/kxX3od3Twg=;
 b=kp2/dIpQvSVw7DxSliEJjRmXmC6Qzezrj3m6twtCNaMF8tfhIeEItlEY19tg0eiAidEsuV3nMs6JhvtYZX9hrbkCMxzhR+I1x4nPOWD2359nsfSS5bHe3xG+/bhd8O0Xrjl/JPagV5/2HrMooBJgmuqgmkOjDxucrslFjFl4gW7Vy/XywbW+dcDNZmnAaIlJJsSFoAmtdCtWb79thgZZoSzaMb/ANzFvUPrjAvw8cTvbWRbF0BuFNoxssXmm1TC0+rahi3R6PwJ+0+icUBudKoyAe8k5ZxOoie448vgyt/FQkyAGh4HMkRXTJRA2OCIy3wpPTUeLQyXMHxls+rwPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN7PR13MB2499.namprd13.prod.outlook.com (2603:10b6:406:ac::18)
 by BN6PR1301MB1876.namprd13.prod.outlook.com (2603:10b6:405:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7; Wed, 25 May
 2022 17:05:55 +0000
Received: from BN7PR13MB2499.namprd13.prod.outlook.com
 ([fe80::6d71:f79a:cbeb:b66d]) by BN7PR13MB2499.namprd13.prod.outlook.com
 ([fe80::6d71:f79a:cbeb:b66d%5]) with mapi id 15.20.5314.005; Wed, 25 May 2022
 17:05:55 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <fontana@sharpeleven.org>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "joe@perches.com" <joe@perches.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: RE: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Thread-Topic: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Thread-Index: AQHYbuvq+O+5yJ1eNkGH1te7vK8zAK0vz1+AgAADYDA=
Date:   Wed, 25 May 2022 17:05:54 +0000
Message-ID: <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org> <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
In-Reply-To: <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67bfdd74-a776-4e26-6fb4-08da3e70d499
x-ms-traffictypediagnostic: BN6PR1301MB1876:EE_
x-microsoft-antispam-prvs: <BN6PR1301MB1876096CDE753BB3950998E6FDD69@BN6PR1301MB1876.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+uwANE90tJbE3MRX32Bcwa+p0TTaldEX9DBi2qUBh6/9JrIIGn65hvgtc/NQyiTvwLo9kywtMTmFRq7TFpuauOgNfYxIQDZo+n7EPu8hH2bClcz+ksXz6l/j6dMPA7+aUXvWq8tvD4qAtgnWMMQWTjg0S9cFQGMRadkwT5UK1hmfKzpsyw3wbGmCfsB5YTMyUWUBbkJkFV02D2VQtjO66CSktcYhFstCW1EunCM9wgDw0VY0cnrgwLfOjIzuYKXVSPji99nYzWFkpuxcyXsxoI8Bs9kSdNV1JbP6kS2x5fY/maThjythMUPWSoRkw9haqdB78UpW6lWdBuklp8TFwGgoL1Epr5HUFTkVJupvMTrLNdZ1JXUarZU0jPtlWhGEKFmPbszrUQncKJlEdWHqFGfCuZNS3Yn1MpmgLV7P0rVRah7VGr82nz/bXfdzGRMgDnPmQUHkXCv0UTw6MGemR85hosWH6SNZciOpGMwWEjQI3L3CXMKZDOCdR3nrbkTy3s7phvL495+C10lSuzGprcTr5VMJ4gxGQ4xphsveUdtTUQ1Gk6t27kM3J1Kx9dnuFWOGyGXoi06MMSZu9Cv0j9pMzCayFX9crwsPzWtwLgf372ljGUCXKlB2dNQ6awertbxPlh26dpDkHDZZYekRAca379DO5Gy6W3/3VNjj3cGd+Axs8jzRTI1hSsIOFhXMA0tsksB6UaNU+N7BlcgWAalgrmimw3jVeSYFQMfHbORVmcKjR3xJFIfduvUw9s0+ytNJcAdh5sbiWEW4w1Xjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR13MB2499.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(8936002)(33656002)(55016003)(52536014)(82960400001)(5660300002)(7416002)(38070700005)(6506007)(83380400001)(7696005)(508600001)(38100700002)(76116006)(66556008)(66446008)(186003)(64756008)(54906003)(66946007)(66476007)(4326008)(86362001)(9686003)(8676002)(26005)(71200400001)(110136005)(316002)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U8Vn3fMGYBhD/UoDrnzIqU6hiRX8OkPGcupENdwKW12Lja94Off9RmRJNmy3?=
 =?us-ascii?Q?ojYdE7cRjIDGkx1Vk0UqMs2aSvIRbqhJb5oEsTnoOrXL+BEWUAA75TN8xNzw?=
 =?us-ascii?Q?UeuFgYmLA6CUjxxUn36xIwT/Qv/LORMB940fc1AMzTbqIzmsh0tjHGdO7r1g?=
 =?us-ascii?Q?ZttadW2Ky844cN6rnheycZYbk7HIT0mO8zysVQS5Fv2C2Ch6FjUV/1cyBXft?=
 =?us-ascii?Q?fzD2dh7pw/HE5cHvSHWcDUHlTENiKb5vmVvLj8N++ECrI48xs+VoTTC68LBo?=
 =?us-ascii?Q?A0r93O8uhi6ToGn2OQGbuuWms2FnTKJey9cI6N38Wk/qk2q7xUcLbWuRBua0?=
 =?us-ascii?Q?sLccHbURb4cRT+zx33TaZgMqvWiBBpPzLzPhlFyDmTHkGB+y2ci6OqH43ZJV?=
 =?us-ascii?Q?ZiMp0KG97ln/PdHecD+5y4OyVqaqZiYho1CtLHrGwP739D+BLgSmdR18zY/Q?=
 =?us-ascii?Q?EnMIyTVDFgjB6Yl6+D8EwM4lKahT6+q3DCeFB8Sof4ls4qawqBS5U5fS8P3m?=
 =?us-ascii?Q?igzMezv/65+r1ZJeP7nxnu6sa8Kix49pCHLUDOrDP5cSFdekdhBxCBwNMtAn?=
 =?us-ascii?Q?4kBU11v06EdwCYY85LRe39lLNaoVZyU6FIuAbVqKqNfsrNlnEop61eQ9zkZ8?=
 =?us-ascii?Q?cdOpJdjoHCBGBR9wzZpHTxlVgXMTeDCtUmAmWGLPpV1Fjc0AFxFaUBgVXfIv?=
 =?us-ascii?Q?cZrXql+5WLDWu0FWBjfxuH2CtXv92Z8zn6jqtZ1kIEKwb2D8KblAYeyCOkBK?=
 =?us-ascii?Q?cwvIjF7ukgk5VWMSu7T0MyJ/B3PQGu9DomvzXL1+XstcGTgnJUOS/le55pK3?=
 =?us-ascii?Q?z0jjBhNyveq0H7ZSVqKqthz5fS5ocT+8LiodyotwutPdhYcZkUZGPDux6IR2?=
 =?us-ascii?Q?Qyq0Zvhx83tbdspL1TY4T1Hcto2s6rnG1GUN2sCoVfkAGFJaSxwGtSVcsrFl?=
 =?us-ascii?Q?esPWKi5G4ZDcrXpLn6rQ/lMH/fiIFGaYiLLI17OWkCGUeaeqDJPAZt1/CjrL?=
 =?us-ascii?Q?9wiSGY/SkeKg3zoL6ARLliwk0/uhet+QSdt3iaEixlQFNRSuzGGBNZnZrPYI?=
 =?us-ascii?Q?hOJBJ0UEDM0bI2S14yKcAgx3i+2115dsdE+LXKrnoaZf6QEvDfHHtflSwih+?=
 =?us-ascii?Q?b8lbvnTJhDsudu2Fsd7VfnlGeqv7Wqjuyf5IgWboNCEziOMKvO9729CTZP5Z?=
 =?us-ascii?Q?F4g/9q/Gcw2lodO805+RWFt10hPIl2wkN4zgiE7bJtQAZ0C/Sf/ySflOj1q3?=
 =?us-ascii?Q?c1GdEYHDlUlnweanXgM5c91GswHFFeGRJZ47XCF2oh5XWIVQlHSGOMJCOpd2?=
 =?us-ascii?Q?2XFKSuC9LqXjZ6vrRgqFX9a5thAm0FuEOSJrDeaqkg6sz62t5yS1WMUo/Zo7?=
 =?us-ascii?Q?Rn81e/ybTYx94Kg0l1DAmPZFa9U8q0XMLtUy3rl1JpNHpdgBk+0uYTGDIIBh?=
 =?us-ascii?Q?FT49zVisiA2+Qa/kluZZoEu/a+pslyJiLaxldNlAJ8WnJIlyoiljErpPLnsr?=
 =?us-ascii?Q?CFPPzNpb9NxRd5VgpB5hiedJ2sZFze5LoxJBBvsq90pPbNCjBaeiGTom2PCo?=
 =?us-ascii?Q?h3xOVqh9xF3doaUuVNNQaz2yXq4MPah5MZZfdF2RlBWbv0/y0mQEbmGL8OnY?=
 =?us-ascii?Q?Cq3dviQh2PWQO+ZvgQ/fsldtMZ8tyGwkgClIE+2jOLjoS+8Dx3zFnJ+osnN+?=
 =?us-ascii?Q?FVozUlKQiyE7zdpAmNQdzJSDsN4XmzDX67g/vdfNneEfhCW2+WuKGnS8wiJK?=
 =?us-ascii?Q?LgiVRRekTA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR13MB2499.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bfdd74-a776-4e26-6fb4-08da3e70d499
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 17:05:55.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siW7uS46RXYlrq9d540DiKCKvsNmH012NcDE30KOA2SsJU0SUg94+NcfAdXvyY3FByMgKa7l7B6LXwPQWTRB2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB1876
X-Proofpoint-GUID: 4NXbEwZFheojYryUKHohdhS-Q-4GoUxr
X-Proofpoint-ORIG-GUID: 4NXbEwZFheojYryUKHohdhS-Q-4GoUxr
X-Sony-Outbound-GUID: 4NXbEwZFheojYryUKHohdhS-Q-4GoUxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberla=
in
>=20
> On Mon, May 23, 2022 at 11:27:34PM +0200, Thomas Gleixner wrote:
> > On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> > > +    "FSF-Free" means classified as 'free' by the Free Software Found=
ation.
> > > +
> > > +    "OSI-Approved" means approved as 'Open Source' by the Open Sourc=
e
> > > +    Initiative.
> >
> > copyleft-next is neither nor. Confused...
>=20
> The terms are used in two clauses:
>=20
> 4. Condition Against Further Restrictions; Inbound License Compatibility
> 7. Nullification of Copyleft/Proprietary Dual Licensing
>=20
> IANAL but at least as per my reading, in both cases it is used to refer t=
o
> "other licenses", not itself, so I see no issue with that use. If there
> is an issue it would be nice to hear more details about it, so that
> perhaps new versions of the license can make this clearer somehow, if
> not already.

I don't begrudge Luis his licensing choice, but one
of the main reasons to stick with a well-known and reviewed license
is to avoid kernel developers having to do license-vetting
themselves.  I know it's being submitted as an OR, but I question
the value of introducing another license into the kernel's licensing mix.
    -- Tim

