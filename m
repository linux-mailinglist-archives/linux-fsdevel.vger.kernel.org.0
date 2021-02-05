Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BA31045E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBEFLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:11:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58166 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhBEFLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612502062; x=1644038062;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=j8sElubGgBHZRsP7lbacHb4FV2phzrfAJo9+PNHclv4=;
  b=FCGqyhiYZsw+7hZeo9ouX/73A8PHKi+ho/dOTeAbFQ4gb6vjhevv4J/8
   GNGOcepbv+2RO7Zu5baJQndZUD2I6JXnK3zGPUkfaUphBDbFGHObiwlJB
   Y4pR/GqltECKNRpBlk89OEiEcIKkj5v/HSW1PdLnD7Qr9OySdcG3wR6zL
   6CNlGj8usx3JV6KZIY0o8q+bp0pvoQGNNJ+vDA8Q5gPUoupGvMnn1I1JT
   vqmMmSGYO+6/P0jbDKGNs+kChssCXtqMsp+C0uMSYe1uaTVcmX+bL7JMy
   uZhKqLOwc2v/9Cxrid7FRnCu/ILxNwn29I8A0xCnatZOaRPDyGuKcxMz5
   Q==;
IronPort-SDR: ADAhrH1ThPNZs/AYOfgHnb4aGcyyEH0f8S8D0CpvNNM6YTs22w0JrfK/E0X1ZCITUMNW4gYlJM
 H/yrIsc8yL9UDxFq6AfJuQ9Zmp5fe5m9uCLT7ypWgCahlx8o20Ut8MLBNNnAHI1G1PU/H5HDqL
 mzHJWeKJgdDj7lbjgxkmSgAdDieN/mAE4Tglb0DvDZqhym6aSdY9tv0CDT/6tR/pklkQHR500S
 8wU3EtAXhR7PpZG+lbcsNOJz9eDRs6x2RZq8wEWJFe8bvyAUfZ+XCpwe1JfMYw/c7pBtYliTJj
 i6Y=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="263305767"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 13:12:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlugWsEEpEBvfBhgNgjTSiO9sj0emiMTRoJkB2MsEc7jrYA4QMRBpz4Lq0/vy5lJ4KcGhlwNQuWjNGLYxlqFRihTFp++OdLf6yWZuij23g61pJbV9dhbCsaCxmpiOqyn9dNBATQgidFzlFLV447usYAhMjyyKTgBOX4trVjcJYFA6F4JT/t8wxGxrgU0cI9lJ2EvgzzAyLXHv7ugI5TiopIc/7j3nrJ7Rit2CQtBAe+48R0L4M2wM8CLbiKnOxQz9OCn7qmJE1XIdxYM4EBRgMsaskUQyklDvx0Bb+Vuv55OoZkozJR51UEzOcnEzaOddGMyqvFdOkYNRWpkcqxLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6nlg9mLAYuxZDf4bgX2KMcjiYNYBkVEnENm5j96zIE=;
 b=a2fuLpVDhzVwoaEI3EqG9yna/8QPvz73Hyahw4qg9jTeSFD7y9VUDFVDHcggUibLn7C41KL1jphNbwBiO5Fh7elEMaJSK1IupYKUNYZw6i+kE0OsmMkxPTVoa89FMvJO4G/LINGONx0Hz/2lyf738/XAf0+HC56Ip5aoUBje1pp/eIHzyIJMqJLo4X5JQ9FpNtys9XGpofDWLKFRQaHA6v66zEfOG4FSpisrjmSu/FvwNOIjK5y59oXilz/R+hSI3Tq7o7zvfroRrqAwqbTuxKAk2S9RBRgS8wGzzmOt5DLg+QoOkqlGwPrWZz2o2piqrNwGrAV+vuJhBxa0Xe7sxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6nlg9mLAYuxZDf4bgX2KMcjiYNYBkVEnENm5j96zIE=;
 b=XJz4d+4GYUNC9QBDCneu+yRiX2cuFvdtMuezMMNCSguDBJ5JNYHJtjKDZAU8SC1uncq+SEF2LhoaYTkyJiXca42hdpYKvvsj9zlRCUWbCDH5WNKwxIuwQbgyG0y6hkNztuyIRh+YGNqW0PU5BT/WON8NB5L41+xyaCYuXGCqtKw=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM5PR04MB0298.namprd04.prod.outlook.com (2603:10b6:3:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19; Fri, 5 Feb 2021 05:09:54 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 05:09:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Amy Parker <enbyamy@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs/efs: Use correct brace styling for statements
Thread-Topic: [PATCH 1/3] fs/efs: Use correct brace styling for statements
Thread-Index: AQHW+3sb8esbC/s2RUmR1UQYt0mr1w==
Date:   Fri, 5 Feb 2021 05:09:54 +0000
Message-ID: <DM6PR04MB49723F2FCDD6E7D11489CD0186B29@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210205045217.552927-1-enbyamy@gmail.com>
 <20210205045217.552927-2-enbyamy@gmail.com>
 <DM6PR04MB4972E287DED6DA5D4435986286B29@DM6PR04MB4972.namprd04.prod.outlook.com>
 <CAE1WUT7BHwyL600Zx_3JrG4CGUgCTdufr8Hyy0ObYALqHO_OoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18bae298-00a4-4ad1-f3b7-08d8c9944687
x-ms-traffictypediagnostic: DM5PR04MB0298:
x-microsoft-antispam-prvs: <DM5PR04MB029873347BB88D581C93070A86B29@DM5PR04MB0298.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAk5tEok/Zc1scrJxxGKH4g9XXqwHJ9x7or4xJkafIcWOUmLXsxvOtDMLNkjt4zZrRR2GmhLM3p7kiTcm2Mh+RyudPUvyoRqZfyi9O3BMJCWuYDnTYEbQ+yPV+fQXe9KKdIQHQjL40NacYi2l0yTHfNJtS4WA9KJI8MjEyZFjmTRdCi9Se5m9g48Jlb9E9V395bvVGYNbPlZsPAi4YI3zR+iyekAYysbSWx0EIcxB5UW0hzXMQTx1eMF5epx0iyHhORN4WsTQdtu7CINVJlpgR+ne8t3rM53bgpQEUqUWzLkHpLwD1H5d0k5lld1nwHu3Pukux8YmEDK8aQ4XiQkNEV7WQNUuihVeRzwMMSR829JQvlu6lxIM8dyEZ+xOYNmTsEftBx6IqC3sEjFEfwV9J6EbQF0LZ70k7KGn7HQpLS10hrKIbcf0ijA51lSTfmR2q67Ix7A2TOxYqXommeQpQMuqTaolPLfW6WGerJUqyXULglbwL99k6Y/3n3br1y+gyeaHZj4MpCdFG31HgPf9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(7696005)(26005)(6916009)(33656002)(478600001)(54906003)(4744005)(8936002)(66476007)(66446008)(71200400001)(66946007)(55016002)(66556008)(9686003)(52536014)(5660300002)(186003)(2906002)(91956017)(4326008)(86362001)(83380400001)(6506007)(64756008)(76116006)(8676002)(53546011)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aau5V6GoSU9EyWPR365QkPC2wJQsHaElz+IqUU5Hf/8NWXrT+8pz+sPzBGzh?=
 =?us-ascii?Q?4JKjkHavyO6guG2Z0EjTsVN6BFTccmRjHFnedKQKe40I17rGUKe15SW2Cz/z?=
 =?us-ascii?Q?IyM20r9Ib4Gbp3q/VRhELzm98UDDXUTe+7MVwCv4O+e9+dXoQoQ7DsXpKIKJ?=
 =?us-ascii?Q?2MSHQii1bY/I6458FhRgKxCuNkHHxZcAT/GVZ58/No1nEZOVh4HyWzE1x4Ii?=
 =?us-ascii?Q?uA3+wq6FNsoQ9xu0PQKlGKTaPT8wIbT14TayvF3OpZjHSXZvd5XA0YhGHxuK?=
 =?us-ascii?Q?7q1lVK363g9toi/k+pbg90EfQQLXqrZSZZn0Q1qNYzkd1UdDYyrtSJbdWvZn?=
 =?us-ascii?Q?vjjxAodfhwDHTL9OuYRU/NRuDKwo2KN5i349yvt8YntwX8pGbtAoAaKT/gzC?=
 =?us-ascii?Q?u8R4/5rbMR/6rKQk0Unu827X15dEKAEhWxlutw4capdscNIsbGBZFb5CRkmp?=
 =?us-ascii?Q?h49sfSs0v+hJenv8tProUZQWcfKoNKhXWyOGD9Sjufh55YJJA61ywjbUQzvc?=
 =?us-ascii?Q?xqiUrnrh4XXI4JmiZ4PsAIclsOc4wCBocqFVpnlsQlAkw49od1lcl23OhWdf?=
 =?us-ascii?Q?+NQCSgprY1kv1+ev6Jn9NXBg1VDG7nO5h+ipWE8yfre218BZTYpeLNmx32iw?=
 =?us-ascii?Q?3/VGb+gmjpEqpikQErvBtJjMJb5npmxgTe6Qc1xkPclH3YVOsg9Pu/+CZDKb?=
 =?us-ascii?Q?M4akiLYy3jraPfiLuWf34+s1KwauTgN/VW+BoSfFSJXjWJ7vT2EN9c6gWD10?=
 =?us-ascii?Q?TFnASNfJpYWfFkbZZm97+xCHbXp6pkYU0cod8LmW6/OtSiPntZwyWu9b8hJK?=
 =?us-ascii?Q?oBez71tG4on1a19odRLsksdLIMadnsYQFQelKZ81iGUcrGhMEg24VYBDLO2Q?=
 =?us-ascii?Q?tjXR6vz50Fex9764t8LI8gS6qR8rtSBTPWu9C8WNEzq/sZuEaWTLPK7ipscR?=
 =?us-ascii?Q?IyuSxryU4M2X8f9hBHEe3nS86s3DJTSuxWOJGglPjbw5iNRnNJlTkWs2XvmM?=
 =?us-ascii?Q?XcyFYnxaH+Yqh7ssWyLQEvfW5KyOua/Uy/dIb0pN45C3ZeOy6FvTtNGmM1NN?=
 =?us-ascii?Q?e7vKXo2mV2GPXGVUbO5HLzJlNI87AU54YKUueKIfnj/gO2xnuT9k0RJqV+xy?=
 =?us-ascii?Q?VFPsrTmCH/nxw7xY/tIhKqGeZIWIYVZEvDLqmiH3AF286ZJfOhYSQBVyFUTE?=
 =?us-ascii?Q?g8F6l4RifZtSv/1Ufrh78boiga/P8XL/GIwGJfrQBkjKH9YsLNnC5CWRZ2mm?=
 =?us-ascii?Q?uTB9beO4WCXmJx+Uhj03Di7JCpO3+e3SZ897SkO+ef7T8lnBavNz1Mv9L7Ht?=
 =?us-ascii?Q?TBFlDPtPaWg2aXnkX8uNRhZe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bae298-00a4-4ad1-f3b7-08d8c9944687
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 05:09:54.7853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcBx8V1c4Fqb8qw+wLFZuzxkLIqcm7i1egJrKqVUd5Ae4/7e/rRvERXGv1JprrreM8/XHhNkrcpwEvJCH0jpX2UpVTmI3VV/eOaiohg/VT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0298
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/21 21:01, Amy Parker wrote:=0A=
>> Commit message is too long. Follow the style present in the tree.=0A=
> Are you referring to the per-line length? That was supposed to have=0A=
> been broken up, my apologies. Or is it the overall length that is the=0A=
> issue?=0A=
>=0A=
>    -Amy IP=0A=
>=0A=
Per line length. I think it should be < 73.=0A=
