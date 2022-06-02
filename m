Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA953B274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 06:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiFBEMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 00:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiFBEMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:12:33 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B101E96EA;
        Wed,  1 Jun 2022 21:12:27 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2523B1aV005329;
        Thu, 2 Jun 2022 04:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=h3bz1tjOCYPWhNPC0/YlFPz8CRc6k3Yd/Tpadks30yE=;
 b=A29uhKZ/rJVQBeKl6SV5b/NaozbegjsHV2CEcn+9fGO1vKNJ16wxfoY/QON6g7+RwbO1
 26V2rhRaUZraYafh0zCWswAh2x4sDzzgssAg9ZSNU7bSMiJlHfBgOzESsr+EQJAuAEl9
 GjENtl23s9NYpkQkpe3ZD3xIUFEOh2hcvMoARFmP3T0XhMCZWZbrkE6IXO10e92IdCXT
 sTcQk7X4f/ZOBbcJzHoieecP5Q0F/7dyc3aUfxH9PWmI/NjpK+GMWE+uHcpnklsCxg9k
 tK6NqHLd2E0BEQh3O3ZEg3cc6z5HnCTa+Xqb+QFLHHQAhcqFVloiyXPWevcvXmpg+VTB 0Q== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3gbc9ncw59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 04:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBgXf6SJO/cs48WFNDKLpLYQZlxwfbpiKs3Y5xctjQaUukjz+Ccxd19aMNEFVAGxxZreWxYIjabJWzTDRFkSYwIhSEdnJxGpeb+KNo6C3yo6rzw4C3AZpAiTKx+SB/a8iMRiZFwx5LRApSpMsqAjF8ui6V2Y1GImCOSzG5bud7lp3M5QzIgccUsA+zN+hghPh/q3lI1hun1QXMsiJy30RxB6bs/IdjKnxNxfQwgErQpLBx4A0cdxf5FhbWwihtlPLy+ppFUYJcOVCVcLbzWWJhgfG5ndx5YD6qucVfHcEgFlZwWLpRlR1O1bGpviKK5twgxcKRGbZbIdropZG/6CsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3bz1tjOCYPWhNPC0/YlFPz8CRc6k3Yd/Tpadks30yE=;
 b=H5ETwF5TDhaZJ3m75s3/+A55zUrFttNTVy8r5amtpa/r/u8y1Ia4tmbDVuZnW7Bcfb9n6rL8PEoxG5yycbqZspfla9PdwG9cq/fco1MkonMnRAXzQ5n4TCPekYrFESg4CXXcKCSyCOeWDyzLZHnBNFRI4kl63kdie/lQ/lKtqSRQqR35nmZBjP+FK0xtzSdiUUrN1OPou5z07Nfyzgqx69y97aRFwwP2tptnjySufX/iPH0MPUxsiuht6Bgwoq4jNFJ+h1YnJx/gEsW9hwSYxxOM8RA1TOlCk4d08igkRLpQIvSUWGkW2UJovx4Ut0QwNdT/9R7YHHY5HQJM84j3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by PH7PR13MB5935.namprd13.prod.outlook.com (2603:10b6:510:159::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5; Thu, 2 Jun
 2022 04:11:16 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::61c5:661c:f216:e59a]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::61c5:661c:f216:e59a%6]) with mapi id 15.20.5314.011; Thu, 2 Jun 2022
 04:11:16 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Richard Fontana <fontana@sharpeleven.org>,
        "tj@kernel.org" <tj@kernel.org>,
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
Thread-Index: AQHYbuvq+O+5yJ1eNkGH1te7vK8zAK0vz1+AgAADYDCAABUcgIAACgiAgAA6W4CACvdb8A==
Date:   Thu, 2 Jun 2022 04:11:16 +0000
Message-ID: <BYAPR13MB2503DAC31B8B5CC69F8FECD3FDDE9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org> <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
 <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <871qwhz2aa.ffs@tglx>
In-Reply-To: <871qwhz2aa.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f06a70-5345-4ddb-f127-08da444df05a
x-ms-traffictypediagnostic: PH7PR13MB5935:EE_
x-microsoft-antispam-prvs: <PH7PR13MB5935BEE5FF1AAAA19B4D15FAFDDE9@PH7PR13MB5935.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAhwBL2vyrSMOKdpxaJolLjgQpA7QuC8CbeHh05Mu1IeMNFot1QNa5wAclUHMWE+hUFD9jO7N6wXEKTHlwLRIo/48oB09SjrP9/cIv8MFndFIi4WyuNoCQaPGCKaRHiH2LLDFygm9klQRewEwPxmj76aodN8eZYAC7n4l+3MqHoo+XfPT0oRfu/Y5S6O7N0gTsRXMpzghaylq3hVbq7PQfMgn30bKNFFyt8aR2ISOZ33GXv+dCQpgA9OSHvnTdd72IVhY1oJOIgOCo1T2eV0e8+kBnIOtOGnPV9NSq96jrFJ9oFC0/Jb5Y1kpTI+wd7ZUtXV07aBpxajozvVt02DygiCHQXE+1llMqLSBIL+v1obo5iJOO+38+7snMXq77aqGhPoML8dSD83MjaxKU1mxC/RylN/e9J16tLg+GeDfx/zS4uS8KPQ6g9t+uQ9Fg8e5UJME4PEvWdJLihOlcX4JNanrTl3Y1CYucrha5T2N4QNwq9uJsRJ34uAnys5j1893xzpCE//Yqsy5hZi12Wua/xcayj7xdb1tj6ZJ55BceMMM1cWXua6B7W0oilLwQ4cklfIEdI9kicD1sl4HeIDEk/AJ799PZsjRu7vPilYjsVNqJ2JwRJKkXkbKXyQoQzdQutjG+V6Q3HAsQmR51xEoECHN7Fc0GSK4G9NU+GkFiZ8ZjzVZ+LzSK8IwY+WPHZcG+NdG6w9TEQ5fiTb+DCZPDpRvoWIDsD+Tknzwg4YEgFJPPayObvaRuR47VeaJwfa6qPpdAQsy0Thc+EciyVXSKciI0pSR+cRQITb4O5QIfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(122000001)(8936002)(2906002)(966005)(7416002)(508600001)(71200400001)(5660300002)(54906003)(316002)(86362001)(82960400001)(8676002)(4326008)(66556008)(64756008)(38070700005)(52536014)(55016003)(66476007)(66446008)(26005)(83380400001)(76116006)(66946007)(110136005)(33656002)(66574015)(7696005)(6506007)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5m7NQeCuhnMctMeDuV31/SYH1tZ0Wv+iWFlPrpbuqtLtyegStbgVsFP1D+hS?=
 =?us-ascii?Q?wNd0A/e+jDs8wdWT2dQWZxUXOQgxng84BXUeRCOoTDU+XsLOTkliBtiBQwSC?=
 =?us-ascii?Q?PQDShU+JfMPKostHLbqEkWxyIU32NNti6t6mOFE64kpZ/pqD7A6U41qS2vML?=
 =?us-ascii?Q?8zv8nIabSubGCF00S2U1BVL5fAO49xlXMH2gYip+14o6Gk3fiT7uGNiL0eiG?=
 =?us-ascii?Q?ZuEspG88DZ7xbxp5IY4Ay04Nhz+ZBFMr9uFcuHwZscQvdIw2Xu/TRnZrmvk1?=
 =?us-ascii?Q?fo1nc2pHAb0abdZnfem63PSzDh1a4FWmOqmAcpLEljubm2UA9ZmkXtyBPSJZ?=
 =?us-ascii?Q?C3xwshEjuU0njmGbNUBshSlVVs7DE1eFoaCCR1Avm3uQvFLWYYgw8NLy+j6o?=
 =?us-ascii?Q?UygtEYENcgiduJ8ArxspVIcrXEJRyIpniKUQPK9xdtEZSdJ8C5iVuDeN4PI9?=
 =?us-ascii?Q?cuSXRnEo4tpoyZT5ve9xFvnwkAewX9Xa27bIkCBW8gwpC7QBWbC7qWMm8on4?=
 =?us-ascii?Q?AFBhMFZiQqSnoAX08uAVNXg89hMVCBaiVRDocLFFeSS/WSJYGsw7tgk8tW3D?=
 =?us-ascii?Q?KMrF8avU97+JofjvBIhAJKWFqVcVVZhtXuLDjaytBCTh3nMeqb64rBgQ8diI?=
 =?us-ascii?Q?rJClgE74j59mwCTMMLuYaFJ7e2LFAqPqDnEjlz4LaC6h/vBZKLJVgvgLlCwh?=
 =?us-ascii?Q?Q/bts2b2Hddp3raJaerjOumzcN3wP25Wm5AUl8/0p8L9FX4X07iQGNbAQ3Tx?=
 =?us-ascii?Q?PhvltjAMuoFY5sZ5hH216l9Zv0otjE4BU41S6dWtqbWI2+GJRF0sghmEB7hx?=
 =?us-ascii?Q?oO8Pvojx/HBaQ3WasMKOijl+6Q3NIiLkEkL9mB/G1o8S9U+nl73k8lJ7Jm1P?=
 =?us-ascii?Q?Zuc/kw15c1GoGZy748MUspLmSmWYVKdv3uHrgZs7tdlcF5gggueG64lCnVBD?=
 =?us-ascii?Q?TdT9EKD3IPh/3QbJ6dT4bMl3xjGWWgahzbHrcvNQDkgbE4DtddtbXTP3dSJI?=
 =?us-ascii?Q?huZgEnTOCx1ppyZzPeJXeJFHNq8gms1FC/fGNjQH6odxB4bfyeRAxeZLfNeE?=
 =?us-ascii?Q?TcmsZkd2H9a1sMXIsVi8C8X1xh/jB8VW2iGBccGuwyTuY/4/ikEgMCKac2Iv?=
 =?us-ascii?Q?wKFjX0VFpdP7c0HPpeUd/vMfE4Ea5r+OE6Ung9gz+NG0onXH5tIPCuOxwLR+?=
 =?us-ascii?Q?jiC2eopjdg9KfblEPTJi16EkCwa+08lZ4aOAS+v78cbDjul3dDjz2+V9omBa?=
 =?us-ascii?Q?f2bliYEW7X4brsNwjFWVxPi008qGZYy0ELmWAeFKQ4W8F3WH0I1F++LTJesg?=
 =?us-ascii?Q?CMgNRSUcUUMzyXcDaoRSXsQuXRD44N9id697Cd2o0UqhxK8IVN9hvNkRjzpe?=
 =?us-ascii?Q?jLaGwxqozHl+5ANCtcYBqFNXbczVYaQk1DfsDTJ1rOR2RV9ft4W9wTp732FF?=
 =?us-ascii?Q?hyNat3PWVSske0kNdMI5s0xT+e4NBQs16x8oTr34Z0M4bjuJQIT7yAifMGax?=
 =?us-ascii?Q?1HkTsSWflIBwLXGdLqaTgC2buZa+9tN4f7UJRK6X6UtVm0DysrzSp9JskL1V?=
 =?us-ascii?Q?vV7fS5J34WQ4SJ7OqSEwTBNKCkDily+r3yxoF126IDFLzTxHjRgd/niFOyL3?=
 =?us-ascii?Q?dqpP6kj4ezuthucneJB9+GBpD22ehFRUjzdqMwq0PQMaLgQ5MELDY7if8aAa?=
 =?us-ascii?Q?gKPrGYqSNul9zt6ZvgG2aTBaGxCfUJZRj6EhUcM8nO8S+Rkc/wcM0YsBDm9T?=
 =?us-ascii?Q?I4eHrS+/RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f06a70-5345-4ddb-f127-08da444df05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 04:11:16.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXuWkqt9lufp4BeHiCLiTDw9h5+HM4JFAcdYhY/hMOm6ZtIcmxUUtWm0ZEskfVBwzIzUslPAPhdEZ3yZfoyYoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5935
X-Proofpoint-GUID: qY6CcAhKYCWncjpETk0PTnbr72-GBVC4
X-Proofpoint-ORIG-GUID: qY6CcAhKYCWncjpETk0PTnbr72-GBVC4
X-Sony-Outbound-GUID: qY6CcAhKYCWncjpETk0PTnbr72-GBVC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> Tim!
>=20
> On Wed, May 25 2022 at 19:05, Bird, Tim wrote:
> >> From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chambe=
rlain
> >> I agree that we want to keep the number of licenses as small as
> >> possible but we cannot really dictate which dual licensing options a
> >> submitter selects unless the license is GPL-2.0-only incompatible,
> >> which copyleft-next is not.
> >
> > Um, yes we can dictate that.
>=20
> No!
Sorry for the delayed response.  I was on vacation over memorial day weeken=
d
(holiday in the US.)

I think that the option to reject a contribution based on its license shoul=
d be
available to the community, using criteria beyond those that Luis has menti=
oned
(and that you mention below).

I could create a license that was GPL-2.0-only compatible, and use it to co=
ver a new
contribution to the Linux kernel (in dual-license format), in order to get =
exposure
for the license or to promote it.  We could use the SPDX identifier "Tims-l=
icense-0.1".
I think it would be fair for the community to reject a contribution based
on those license circumstances, even though it met all the criteria you men=
tion.

I don't think that the Linux kernel should be used for license promotion, b=
ut if it is,
then it should be used to promote GPL-v2-only.

>=20
> > There were good reasons that the original BSD dual-licenses were
> > allowed.  Those same reasons don't apply here.
>=20
> That's just wrong. The reason why dual licensing is allowed is to share
> code across licesce preferences. The very same reason applies here.

I was talking about why dual licensing was originally introduced, which was
a situation different from what went on in 2016, when the copyleft-next
dual license was discussed.

Dual-licensing in the Linux kernel was originally introduced because code w=
as being
taken from BSD and placed into Linux (under GPL v2), often by someone other=
 than the
original author.  This created a bit of hard feelings between the BSD commu=
nity
and the Linux community.  So dual-licensing was introduced so that derivati=
ve works
(created by Linux developers) of BSD code could flow back into the BSD proj=
ect.

This was code that existed before being introduced into Linux, and there wa=
s
no notion of using the kernel to promote the BSD license.

I have a problem with the statement:

"The reason why dual licensing is allowed is to share
 code across license preferences. The very same reason applies here."

I'm concerned about license proliferation, and that statement has no limiti=
ng principle.
Although you do raise some limiting principles below, I don't think they ar=
e adequate.
I don't think it should be the mission of the kernel to allow shared code a=
cross [any and all]
license preferences.

Just by way of example, I would hesitate to support the adoption into the k=
ernel of any
license that had an "or later" provision.  That's true, even on the other s=
ide of
an "OR" clause. Also, my preference would be to limit new licenses to OSI-a=
pproved
licenses, which have already had extensive vetting.

>=20
> > Each license added to the kernel (even when added as an OR), requires
> > additional legal analysis.  Corporate lawyers don't usually rely on
> > the interpretation of novel licenses from external sources.  They do
> > it themselves.  This means that hundreds of lawyers may find
> > themselves reading and trying to interpret the copyleft-next license.
>=20
> It's none of our problems that corporate lawyers are obviously unable to
> act, cooperate and to agree on something.
That's an over-generalization.

>=20
>      The license in question is around since 2016 and the kernel carries
>      code under that license since 2017.
>=20
>   So what the hell are you complaining 5 years after the fact? The whole
>   point here is to convert this to SPDX identifiers.

I missed the original discussion, and the license was limited in applicatio=
n.
I agree that my complaint is late, but this conversion to SPDX adds the lic=
ense
text to LICENSES, which IMHO makes this license stand out more than it
has previously, and possibly provides an implied endorsement.

I think it's a good thing to convert from the current language to an SPDX i=
dentifier.
And that I'm late to the party with complaints about this particular licens=
e.
But I'd rather not encourage developers to use this license going forward.

>=20
> Aside of that I'm impressed by your chutzpah to make up an argument on
> corporate lawyer costs.
Burden on corporate lawyers (and, dare I say, OSPO people like myself
who deal in license training at our respective companies) has been a
consideration in past discussions of contributions.

The 2016  LKML thread about the original submission included
discussion about the amount of "lawyer ink" required for
different licensing constructs and development scenarios. For example, see
https://lore.kernel.org/lkml/20170518221205.gcfs2t4ihlpx5kj6@thunk.org/#t

>=20
>   Do you realize how much costs the very same crowd of corporate lawyers

"very same crowd"?

>   created by ill advising their employees to put corporate defined
>   boiler plate into every other kernel source code file or by not
>   advising them at all and let them add random crap?

I think we're talking about different sets of lawyers, so the rest of the c=
omplaint
about some lawyers and the costs they've imposed on the kernel community
I think is unrelated.

>=20
>   Do you realize that the costs to cleanup this mess have been mostly
>   covered by community members with the help from a _very_ small subset
>   of corporate lawyers?
>=20
>   Do you realize that it's hilarious that your so costly corporate
>   lawyers only need to react now that we are trying to convert licensing
>   information to SPDX 5 years after the fact?

The fact that the conversion being discussed *now* may not yield
an identical licensing situation seems to warrant some legal discussion.
I assume Luis is on-board with the change in licensing situation due
to the conversion, but I have yet to see the final patches.

>=20
>   Do you realize that the SPDX cleanup effort is reducing the costs for
>   everyone including _all_ of the corporate lawyers you are so concerned
>   of?

Yes.
I'm supportive of using SPDX in the kernel, as are all the lawyers I work w=
ith.

>=20
> Sure, complaining about your individual corporate costs is way simpler
> than:
>=20
>    - contributing to community efforts to reduce those costs
>=20
>    - acknowledging that the community efforts even without contribution
>      or your particular organization are reducing those costs
>=20
> Try again.

Try what again?  Communicating a preference on license proliferation?
That's what this message is.

>=20
> > And here's the thing.
> > The copyleft-next license has a number of legal issues that make it pro=
blematic.
> > Not the least of which are that some of its terms are dependent on exte=
rnal
> > situations that can change over time, in a matter that is uncontrolled =
by either
> > the licensor or the licensee.  In order to determine what terms are eff=
ective, you
> > have to know when the license was granted, and what the FSF and OSI app=
roved
> > licenses were at various points in time.  You literally have to use the=
 Internet
> > Archive wayback machine, and do a bunch of research, to interpret the l=
icense terms.
> > It is not, as currently constructed, a good license, due to this lack o=
f legal clarity.
>=20
> And here is the thing:
>=20
>     Whether you consider it to be a good license or not, does not matter
>     in this context.
>=20
>     The license _IS_ GPLv2 compatible which is even understandable for
>     mere mortals, i.e. non lawyers. That's the only relevant point for
>     including code under this license into the kernel.

I disagree.  There are other relevant points if the kernel is being used
to promote a license.  I have made all my contributions to the Linux kernel
(meager though they are) under GPL-v2-only.  I think straying from this
should be rare and well-justified.

>=20
>     Your way-back machine argument is beyond hilarious. Guess what the
>     folks who try to cleanup the corporate lawyers induced mess in the
>     kernel rely on? But that's absolutely not applicable to this
>     problem. Why?
>=20
>         The kernel has very strict rules for licensing today. Any valid
>         SPDX tag in a source file has to be accompanied with a
>         corresponding machine readable license file.
>=20
>         This license file is version controlled and if there is a
>         dependency on any other license in the context then the
>         dependency is also available in the git history.
>=20
>         So no, you do not need Internet archive for this at all simply
>         because if the kernel git history vanishes from the planet
>         then this particular licensing problem is the least of your
>         worries.


I said that the textual terms of copyleft-next require the Internet archive
to interpret.  That's completely independent of what version control
system you use to track the license and its application to the kernel.
Linux kernel git logs are not going to tell you what the OSI and
FSF-approved licenses were in 2016.

>=20
> Maybe it's about time to move your corporate lawyers, who are
> caught in their own past sins, to the reality of today.
*My* corporate lawyers and their "past sins"?  I think you're taking
actions by some lawyers and overgeneralizing them.  It is not unheard-of
to consider the cost in legal overhead in licensing considerations in the k=
ernel.

I believe Luis is working on an independent patch that isolates the SPDX
conversion from the changes to the testing module code.  As such, I'll give
feedback on new patches going forward.

Regards,
 -- Tim
