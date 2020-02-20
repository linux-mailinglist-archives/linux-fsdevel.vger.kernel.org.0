Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34A166AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 00:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgBTXOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 18:14:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37438 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgBTXO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582240503; x=1613776503;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VbgopJaOYLFqbg4tUVU0VkBP8Q3U+LK1cY8v7g01hew=;
  b=XX+tZV/KRj4OW6f0DEE6HGwgOWd6kiwOqre/iN5hGVvdz65U74vrAbdM
   v3zCNMQnnfbTpQ7dFvHSGi56HXrEb9RtDmyMoPUUe8J1sT8W/htscavbl
   6gBW4uxmda4mRMUfY1ajeTHnoCJIMJ/AI+lyvVjzkUmItd/aZeYKfjheD
   F8dqlsk3Y7PZLxwJEyNfLKtvz3dfgFfTk1O9bJjTQcY+QXCqmKJQFFMRe
   j/bjJYvaLUspB2cCIJFkz5PUXRzmRtcMLXYOhfKtCozQtviiVzyDJM8S4
   DIN5yiiq169MiDh3XBbumXO96RcDz44GACG/0MyUZvcXXWo+rJzwrEMDf
   A==;
IronPort-SDR: zvnuWz/60BTvXUYBG14wW77uFtl29EAHXnpRWChwRalHoRxR9Oza1maCavzyXgaDpIjYhd+SMR
 h5rEuNxYVr2wT5wrTpnDvdcMQOCZWZkuBb66A/uVd98LpY1Fj8uMnLmWhznWE1oDQNQ/3YpJmc
 2yq0JFKdVKwjRAPMhChCVsPRu3HxAMHJyqhIFsWplOAJKcMocAnfwHn5auoEpVyavW4x/nwn60
 cBlRyZNF6YA9azLEN+pD60Lmdcwdp3EMOTl24kacPOHzv98YLW4FKgDrQ3XctKz66NRv6jl6kd
 /R0=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="232204408"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 07:14:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giI9ay0CBxoiqjgOndoJ28nDbCDxhs94SBxQ0vcQkCYFPhvFhRtxkbrsQosVCo24rjKnkxpRt6oi2ac+x6mMb07obOsKGSZqfTkj7bGJmYc52SDL8hmhGgTZlMvUcalO15YC2bvI09ZKRmootH0ZnfvAlD+/6g+rAMvygnI4ys2/mSVDA1OfaCBE6wrkwFo0XJzAjG+ZwhVccrCOYaWVCRo0WgeOWW2w8RqNrm7S77ho76267Vqro/rJrssWcDh9FO2xPqAaYsy8P372HyxypUy1lDmflyJX+pgkEBo9Qc2WbsvozB92XUyugAPl1rmI02QNefvfR2J9hU3bC/A98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbgopJaOYLFqbg4tUVU0VkBP8Q3U+LK1cY8v7g01hew=;
 b=CiRUluGOSGabeux3SsvyNsCWcV3uBs0OzbZ0FKBfOHGSNE13NuNKNgwqjN2KBJb/5WZs8Ffe6wa0Zrl4PtyuqMqgcy9Aud7ebszYBwE+A5Vs0GacEGrbqY/MjfksHN260pNrN1XW+SI7PJABAcsGb19VaUQ1EXg6SA0eBoVNsSJC6r2YveEkfGfVOHKPIqw6LLmIaNIZpp3o+q12LHrS3lWaTA1cPrJHE9PFbNsGljDcyQtl9Yew1a60CSDbsV0A/NzoduzWSL/ltp9u4KrAwlcBbjJ/hpCler6WHU/iRjzNNazYYqnpWOnFaiF4FCnlTgn95POtkw2hAi3lD4GIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbgopJaOYLFqbg4tUVU0VkBP8Q3U+LK1cY8v7g01hew=;
 b=foL1Ah+DxoptEauD80MEnK5wD8PnC0yWfCqdNAYS02Z29gqMD/uHkE2ye+7h4N2kuutK5lKeljKNDnYilDPWSpeb01hIe/pVyhaEgVfWRuRcyOxsqCN+czIBMwIqO4QCeJ/bMfLKPe76UOeYrhX7bwdnYqxSjHn2q1dWKwuQr+Q=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6245.namprd04.prod.outlook.com (20.178.235.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Thu, 20 Feb 2020 23:14:23 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 23:14:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH] zonefs: fix documentation typos etc.
Thread-Topic: [PATCH] zonefs: fix documentation typos etc.
Thread-Index: AQHV540OnAiG2RQeb0SZ+1i2wHVHDg==
Date:   Thu, 20 Feb 2020 23:14:23 +0000
Message-ID: <BYAPR04MB57493D05B6C990E2B808214786130@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <14e7bd16-c1ec-c863-a15c-fd4f70540d2a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a151d3b9-3afd-480b-207d-08d7b65a9f4e
x-ms-traffictypediagnostic: BYAPR04MB6245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB62453F3D52163A78119AA44386130@BYAPR04MB6245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(54906003)(316002)(52536014)(71200400001)(66556008)(66446008)(66476007)(81166006)(110136005)(6636002)(81156014)(8676002)(33656002)(2906002)(66946007)(64756008)(8936002)(9686003)(4326008)(478600001)(76116006)(55016002)(558084003)(86362001)(6506007)(53546011)(5660300002)(186003)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6245;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNRK3ZgbpkfO6ubYx1au1nBAU6DaCZLaTSYJhhIeCfSdXLXDkK3zqrW1e8lv+grZv2GgCsRV1F8olqYNP4vL6Lr42Xh5tW5GQVohhZ7zgCDppZXA6B4e7kM4i6rLiVKgGsdIj9c5NG/Z93rZCyWEKJHsAuJ+Mhl4vDXNtzecr85vNSuGMamIFjwzNh+QtZlYmjBGsQggEvW0lj3a2kYMx7RohEy8Xb1ltyfmp7lUBbVpjSf2i8OuDY6qjN3LdUe3L3QM143rQlM+VHVhNxrCB6Zg/DIIzHZbr49ti6ZRKRFt/x2f0RxbHGNDcuwKq59W91zT8S+E+OS5PZjIFEPZosi/OchcBdntd33RjF9AdW8DuO2rXn8utVrqTfk/xDw0bOJE8rdZUEUVAiFXTlkdYp8i+yVRlFpfJ2nBPuQdJ3QWOfJ+YuanI8Mf1TRFzNux
x-ms-exchange-antispam-messagedata: 6Q7eKle3jKeTTtelrVWJg1t6pgQ5UjdPSB5UVIRhb+4rLua2xv15eIZeub0Gze2RqkwHDb1yrgXs89ptlbtP9VX4i2PVHn9Jas+C66zZkVUysHDeIuLFrbxoDeeK/uhs88/638q8RUkbYDK+UlEofA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a151d3b9-3afd-480b-207d-08d7b65a9f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 23:14:23.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v31lg8sh5jX6glrM3e+wfJxh9nCZPMRwXpAQgCLk+D86k6ERQ8I6V8MeXnTH2gMyz7ustGBjJd3Azbpy+pT496sCx42CT4J/KTjkyXQmmUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6245
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 02/19/2020 05:28 PM, Randy Dunlap wrote:=0A=
> From: Randy Dunlap<rdunlap@infradead.org>=0A=
>=0A=
> Fix typos, spellos, etc. in zonefs.txt.=0A=
>=0A=
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>=0A=
> Cc: Damien Le Moal<Damien.LeMoal@wdc.com>=0A=
=0A=
