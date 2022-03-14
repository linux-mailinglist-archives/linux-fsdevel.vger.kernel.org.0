Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C666D4D79CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 04:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiCNDzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 23:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiCNDzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:55:20 -0400
Received: from mx05.melco.co.jp (mx05.melco.co.jp [192.218.140.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5B15A12;
        Sun, 13 Mar 2022 20:54:09 -0700 (PDT)
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 4KH2hw410hzMw4R9;
        Mon, 14 Mar 2022 12:54:08 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4KH2hw3cZkzMqvSs;
        Mon, 14 Mar 2022 12:54:08 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4KH2hw3JCLzMqvSB;
        Mon, 14 Mar 2022 12:54:08 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 4KH2hw3GGCzMr4pt;
        Mon, 14 Mar 2022 12:54:08 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.171])
        by mf04.melco.co.jp (Postfix) with ESMTP id 4KH2hw34QTzMr4q0;
        Mon, 14 Mar 2022 12:54:08 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjCCPDdYfoC+vP2qd+QPiXNjbskoz2yVjkSMgzIkcRo98mtdmv7oepsluLwIgfWE5DAkTOUZbNS+XFGFyUgkBRoGMOiszLDbAPPEomOvsWeOumy774SHpkqWicAHGWUdxwsUT8T3WikzrnTz+6tMBSP3qcY0AYsPn0SQIlJ6qJ0VoVvnNWPP4jY0DWjE9elxpAXxwXRGCj9U2KjVTxKBvCENapsbmnRb/s8t0GCZ6yLFCImQTDvR9C9zB9rgMnSoWqxTYrLOmic4ylKTkXf67ueqzzLB/14RoHdGvJXW7L66JLftjnBqbjth6x+GnkFWshmtQFCDPt9jwngN2edjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmj7CKGhvvJLP6x92X87ob+0oNAgx21Yh9+yxaH7hLA=;
 b=OQoyGF3GvVr5N1sAa1L/3ia1OTpMcpR88l42Z2RhnUsGy3H2nOw5cz7z/G5zsq7O/xwLdz4lOhlqm6GaaK5v5okBtymx+2bfPMVNPbN5yA80kPE5S6RlKhM1Yd7/dGCSDckGj0RQjhEU18zOVk1/cDlMEY8UIzCjlySoWfUFT0osQNcLCSN8Sqk8OJvgdu40fpNJ49LkXEkAjCDae7w9Hb7HSUxw7T1S09bpgRDWZHxs7vMsKcip0JhcA+A97mX4B3bbW9osk+xfrurQDJ9Znj2c4CIB14JsyAXYq2PPBJ7PNaDvQ4Hr4KYEcAmhu9NyFlZDUXt2mrEWahaqNSU74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmj7CKGhvvJLP6x92X87ob+0oNAgx21Yh9+yxaH7hLA=;
 b=ZEBXME/h7k6x99gnx9Js4cFPA9vSWL5UQFw6bYLRPKCZEM4P25BDT8LZtq7SCNjPMGciTdCcAA36ThGpaZYbm63dRkzCqS75tJjzZaeOGnln58m0Y7qogzJK36gvMVlR2Aru+UP2Yas1z0kI241yjNxuPNsn3SGwOc+hqMUyDns=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by OS3PR01MB6039.jpnprd01.prod.outlook.com (2603:1096:604:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 03:54:06 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 03:54:06 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Vasant Karasulli' <vkarasulli@suse.de>
CC:     'Sungjong Seo' <sj1557.seo@samsung.com>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Takashi Iwai' <tiwai@suse.de>,
        'David Disseldorp' <ddiss@suse.de>,
        'Namjae Jeon' <linkinjeon@kernel.org>
Subject: RE: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which ...
Thread-Topic: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which ...
Thread-Index: AQHYNLplcevRMz/jOUuuvmG0JvLRkKy55GyAgAAFMQCABE5KoA==
Date:   Mon, 14 Mar 2022 03:52:08 +0000
Deferred-Delivery: Mon, 14 Mar 2022 03:54:00 +0000
Message-ID: <TYAPR01MB535314A6E1FB0CB1BAD621C2900F9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <20220310142455.23127-1-vkarasulli@suse.de>
 <20220310142455.23127-3-vkarasulli@suse.de> <20220310210633.095f0245@suse.de>
 <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
 <YisU2FA7EBeguwN5@vasant-suse>
In-Reply-To: <YisU2FA7EBeguwN5@vasant-suse>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1d493fd-15cd-4d73-05a6-08da056e49bf
x-ms-traffictypediagnostic: OS3PR01MB6039:EE_
x-microsoft-antispam-prvs: <OS3PR01MB603960D4856FF3EA0CAC7065900F9@OS3PR01MB6039.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6kCcm/2RR2EXlS5nRXUKuPZtK+qoSr5MaItP5LSHpm/1fnjFUgqnRx+aRqAJPrrLCqs2My23OE7i6vsSGDZWWSacWWrVtG+VYkuH4PGBwhITRJ3ombveGj6+6y52QqB5Q2O7CFfcqHzbf+v/jLor5RbZPVGCqv/k8L62NPpseCr4cKiRL9bsvDhvxFF4fCNvQUa4N2VUJAwjwDGu3nxBDJw3kL5tUUtE3Inzlf7PdxmvS4O1vgJwnGdyAq4nXS7hIystcTGB0/Act/VFk3D9Ma8st3X1n3Bi39d7pTFSARF0HW5FkWteEi0zElif7fZnyxIG8imEms3VRAdP2g0H+LYwHjfkb0du1Pn+hsKmGjKvjhKZntrOvOKpeB12qpBqleBsI52VSj2Z1+Y/1Nxwde3HRJhYX66QnNvJscrJVCbwGwcN/J+mesKvnOa4wUCEwOHZdL6DvA1tQbeKcL3qH3kGNEt0XXZVtx1bVycN/9jPXlYkVWV93ZIFAp5Ve5xY/vWDe9frXMNU7PgtOjMbGZ3tG4dZj9V8nc9r8wxxhBcWD+vSsimSP3DtjGPQS6CxlsnecvKxUYXZVqSScLbhV8Pq1guzOu8P8Gl/69Z9hctb65lQusg10aNGUjzRcYtyyn7DYf2t5BS+qW1pPB5e/QAPbBULPPp7JQ8B/+DRUoIgbWIkqGGoEJxr5ABexSaZI0rgJcN7k+ms0eX8zcEUDv/l4Hom9MtFEyxbSPesk6CVkvapI8HdTdvWwdO62WNy0g+of/4NcFqK25UC2TIxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(9686003)(6506007)(6916009)(54906003)(316002)(4326008)(33656002)(55016003)(122000001)(38100700002)(76116006)(8676002)(64756008)(66446008)(66476007)(66946007)(66556008)(71200400001)(508600001)(86362001)(5660300002)(52536014)(8936002)(83380400001)(26005)(2906002)(186003)(38070700005)(219693004)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?b0MxRk9sbFhlQlZhalloMis4NGQveGdyME1lMURIRkVrTC9CcjhxcDgv?=
 =?iso-2022-jp?B?cngxTWhVZWdMUXFqUVVYaUpzZmR6QUsrNTJwYVhDWDIyRWRoRk42QXNk?=
 =?iso-2022-jp?B?S00zRXprUlJHZi8vWVRZbnBQd2t3TDRjenlRTUNiNDB0emdJMkdJVVlr?=
 =?iso-2022-jp?B?b2FrL3d0UzIwNmltOGw2MGE3Rkc0cHB1RnBZVnBnYkppMWRZdzBSMjd4?=
 =?iso-2022-jp?B?dVJwZEdhWFAxYzhuVGdNb2FNS1ovODFxQ09LS09tbWJsWGFjcUh3SlEx?=
 =?iso-2022-jp?B?bDUyZDExOWhJT3dvM1VrUmZjcy9VbnhaMVNrUnJHZkl5RHBYaUkrR0wz?=
 =?iso-2022-jp?B?UHhwaGFVRk1Fbkh2V29SRmovZjdVWTg4cmcyQ2twdEptTGVPRHhQbEYz?=
 =?iso-2022-jp?B?SXNvZVdKc3VoaXZTVTZtbVUvWlJhVjB2M3p6UDFMcEFhMUp4bDZuMStL?=
 =?iso-2022-jp?B?NytZaytvL05QTDUzNk5WaXo1MndudHlMZURUejZna3RSL1JjcWdFZkhk?=
 =?iso-2022-jp?B?QzB2cS8xQzVOMThKK3FDTk56YXEwU29BQmdBcEEwNFM1cVlKb1VkZ0J0?=
 =?iso-2022-jp?B?ajMxVWRYbU9LaGpzQzFMT0VKRzZub3FPdE1mNWhqOWl4b1ZLNFREMlQz?=
 =?iso-2022-jp?B?M3czK2lWaTBYVlo3UWU0UUZ6NjFJTGcvV0hZTXFiT0tKQ2dtVUFpNkdS?=
 =?iso-2022-jp?B?MUwvL3RVN2RaaTNsL0xKTzAyaWZLUEFFV1l2WGNQNzFwOVA3ZzZyMFVa?=
 =?iso-2022-jp?B?OWM5SkRuMFdLUFdiKzhjMWxFdE1zRWc0bURnMW1jNVdDempDY1BINDJN?=
 =?iso-2022-jp?B?UGRqdzJQUUVocDlMVjd5aVdlbVAreEdzTnY4K3MzRGpscXA0dDdsK0pz?=
 =?iso-2022-jp?B?TENkZStGZGNRZ1lTNU9oaWZPLzZUK2VzSnZabUU4K0c4NWdtM05SSVFu?=
 =?iso-2022-jp?B?ZHU0ekMvM2ZML2pEL3FKWXNDUmsvZmw5cEIvNEVDOVREZDBOVkVMQ2Zv?=
 =?iso-2022-jp?B?K0RaQVJoRkhrTVFuOWFHRHVtUnh0dWRSbnJ2NXFraXRaandOWHJHMjdQ?=
 =?iso-2022-jp?B?ZUdqbVBaekpCaXFWeWUzV3VKL0ZyWS9aM3R4U3dXcWF6OURHQmNxOEc2?=
 =?iso-2022-jp?B?dXhieWJ2NzkvRUhhODIxYXpabzl4KzJCaDl5QkNTTG95cU5KcVpRWkF5?=
 =?iso-2022-jp?B?aHBVRjBkYzNFSEszL1ZCTXhSR0l5VENBOWZkMjN2SHlyZkQ3UGk5WEFz?=
 =?iso-2022-jp?B?YXRwbjUyd3NMSjdIUmRVQVBCbU5lTUxRdGJmcGVUa0hMcUZsN2tmTmt1?=
 =?iso-2022-jp?B?elBBQ2E1RS9rWEVKTHVBRHRhY3hNWVFidmVIUmhMaDlOVmdQNXFlVHVD?=
 =?iso-2022-jp?B?NHN1a3pVNXpPTUc3SmR2RVlBQVFsZjFGWjVwRFlhVTdkMW5IbTZySHRH?=
 =?iso-2022-jp?B?NjdLb2lNcWZiTkVydUhBeW91emFrUENDQmdYK3ZMbXVyQnlNSTFpVmJn?=
 =?iso-2022-jp?B?cXRHTnJjdFlTbk5EUUdHMjZJSk9TYTFmblV6NXg2Z3c4SHlPamIzZE9N?=
 =?iso-2022-jp?B?ZVJEcEIvOU9WUVRRWVV1V3laOVZCREVnbmZWcGNuNXNMV3gxSmlCaE9z?=
 =?iso-2022-jp?B?dDA4Q0Y3WmRWSXdJakdldXdHZEZLYUN0cEJGSEt3bEZ4NDdRN3JQbTd3?=
 =?iso-2022-jp?B?N2F3RzhoK1pERmN1Q3VMZzdHb3JlUk81b2xjQTdoR1dRZDFaMXZmU3Y3?=
 =?iso-2022-jp?B?TGNWZHhHY3ZxQW1heU9ZOS9ZRlBPdk9tRi9WeDJ3NTBiRFJGd3lDak1U?=
 =?iso-2022-jp?B?WFUzZGRkOUpYNk5kZy9TQlNYTmdQR210NC9DWE1ORDc2cXVXMVZPdjdl?=
 =?iso-2022-jp?B?eW9sZ0FlR0wxRk9iSkFNMWdLNlJWVitRcGRLZzZGK3FQU2h3eUNkdGZV?=
 =?iso-2022-jp?B?MHFOemZ5SjUxWHplcTRzUGI0MXhPYWFuekJ6clFyMkdzQm0zSmZseUNX?=
 =?iso-2022-jp?B?Nlo5R0U1YWhha09aWWdpdFpGN2o5Vk82cUlYNkNYdXh0M2FsRUpUVWgy?=
 =?iso-2022-jp?B?aktjbHdVRDBRV3pXN0JxejY1SHZtZmhvU011cWtDRjhuRjJXZytHMG1h?=
 =?iso-2022-jp?B?dUY=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d493fd-15cd-4d73-05a6-08da056e49bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 03:54:06.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTxZi19/3BDHiv/XY6r2P4wPgMxjDIPlOaQ1artr4ZPFxAUuDsq9UouOEoIZei0qDuH+2D8/KW9mNVuQw3lsiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Vasant Karasulli.

> > > I think it makes sense to mention your findings from the Windows
> > > tests here. E.g. "Windows 10 also retains leading and trailing space
> > > characters".
> > Windows 10 do also strip them. So you can make another patch to strip
> > it as well as trailing periods.
> Actually I found contradicting behavior between Window 10 File Explorer a=
nd Commandline. Commandline seems to strip
> trailing spaces, but File Explorer doesn't.

The exfat specification specifies an invalid character set, but there are n=
o restrictions on the use of leading or trailing white-space or dots.
Even if the filename has trailing-dot as shown below, it conforms to the ex=
fat specification and can be created on Windows.
"a"
"a."
"a.."
These are treated as "a" in the current implementation of linix-exfat, so t=
he intended file cannot be accessed.
The specified filename should not be modified to comply with the exfat spec=
ification.
Therefore, exfat_striptail_len() should not be used.

Note:
Windows explorer removes trailing white-space and dots, but not the behavio=
r of the filesystem.
Also, you can create a trailing-dot filename by quoting it on the command l=
ine.

BR
T.Kohada
