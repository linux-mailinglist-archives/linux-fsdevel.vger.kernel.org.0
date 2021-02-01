Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8413730B3BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 00:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBAX6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 18:58:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8664 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAX6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612223925; x=1643759925;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XnbK2h7duJ6dy3kPV6obti2Fcdfq+qvZqzMPNgaZgf4=;
  b=Icd+p0WTge2kY24jlITFKv7b7KpAdlryNx2lmJ9/TGlZCotq3hNDF3PD
   ba5Hy4UbgQL/6sr8rHsGlZro10QQDSe5m2HT3FEPlTM0UIj5R3pXS69Yv
   bE1KDaiQvg8FxEBBtca+EX1P/orfwNCAO/TZoCYVTHUhWtSCuKFLMeucs
   f+VW2AeRj87gJNu/sDHrqHheNGm7LrUzbUGrOtnlkh5IrlVNjHnrx2MUY
   DzvrGpW6Ey1JtKICIxAfgaWfMvIhChnlOxteJgd69NIK8EHh8VT8G+trc
   l69IqhEZnEDM23BgkSDqcTffNuB1HQTimojq9uN+jf7QRwNPLZe/W54Cq
   g==;
IronPort-SDR: r4v/xGWR7rS2GElQvFMBDfzuH9wwjEHxf/JhexWZAWOGTT7H6J3J6eA1wnATvSSuRN9kkRJHAz
 upOAu9hECS4/2i7h7SDXdp6B86U30DRU7RfOo/S3bzC9Q28tWNWTeldDdggCV3rm2enjGj8tid
 3SmLCAbmRb9rq0xKwdcf4kvb9h37a3himJF7ko2uTD7pOPAeVmKOwC/i29cTDEwthcoMJPazvN
 PcqOsvO3xaYoH4LGnNy5CFQAExGDk+4h5QvxYxsih1HyzL61uK0phHn0VSrqDdz3oRaXnaLMam
 JGg=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; 
   d="scan'208";a="160042880"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 07:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZzwAiz7PTrL8xgTNpVWfXrrYRSBCbSY5mnVbIjv2AEF+fePha11RV/h7tu0Wvnmw6H1z1pT8dTr7YpjzaW1PyHDTRtEE7xy6BGO4xM9bYXq2pe/21FUPYFm6nIrz6aAgpO/t3gDSKY7v8D1qNYL6hzCeJYt9OPjsrtmYoGimYZAbOpPsel0gOvRjX8nwiNLGP18/YF/D9/RI+jOIJpNSdLKVWwwhr66oZ26UPHwLsxJre56j7XtJd8f1xXYBnqXm3ctOqxR4uecK/RtKmh2DvoaLV82ZJNlyD78TvTTaRo+gnFVLWovCWivb8taOTRrlAoeA5jHbxqIbl1OEpw6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnbK2h7duJ6dy3kPV6obti2Fcdfq+qvZqzMPNgaZgf4=;
 b=PqMPWk4YosxBX2oD9djjYHduD2inSQgMjAkwvuTRCyaYnv48E1gY17hKAdQvM8m08m7YjbOHyQAFGYNJafArTnGAjptHE82IwGM0vlx40BxsnwhJYhx1kbZ8fFcrpJDUE9SEvb4Ra+rsX7rq2Q2gP3YoKPnz/426YmAibM8hsRq0QGkBmxH+y8/KPLQAd6I6KyXtUrdJX50YMoWGNnL2DBJRhp/5P0tNDAD47ea5ghViOc6U8w68I7Z/VI4gf6uC7Mu4cCw+/DQiwvvbcaNFTRu74zn1ZeYWjQROJxlGbaAD8vu49Gd75oDAd5WQcE2q+cdFJKWUeJ5P11UpM4mW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnbK2h7duJ6dy3kPV6obti2Fcdfq+qvZqzMPNgaZgf4=;
 b=dZcKPUDG54k6TaG9daeulLbpbd1NwQUE7qsypakw+Rplj3cq2CpfFhg01TQ1NZ5Gbw6g1868h16tIVYLAt0wfh3WgnsIc3XDE8iYxcydjtSElAOCNCAHJ9eEKJtCPkekGz+2pLHZY3evrX75+DsyoI+ruZjr7Z5PUeNFsS7KsV8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 23:57:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 23:57:38 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Amy Parker <enbyamy@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: Using bit shifts for VXFS file modes
Thread-Topic: Using bit shifts for VXFS file modes
Thread-Index: AQHW+PUPjDV06v1HiUmjtfb9bHQn/w==
Date:   Mon, 1 Feb 2021 23:57:38 +0000
Message-ID: <BYAPR04MB4965DE15FE77E45C46BA2A7986B69@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afc57b1b-811e-420a-1e25-08d8c70d2772
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB610492B33E2A352ED131F75C86B69@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZlC9D8thHhiCKhO6Wzmp1jUgyvP+ZxhKsCAjDorVYb9kGbwkYHuizCywh0HDeSsBqlYkAdgxq+7+/bonM7W2P7vtG1t+ukdmwAD23Eu9CTfcu5IQPYDS7TlBTHA/Xwr3YOoNl0bB2D+CP5XT1noxYI3vI+iThQYpbPi78HCdy2PtFSOwpf4Vg3B79I9HRdqMPg6oQau/zkGNRWDgpeFCK4NWKwINoS3p5ltsomjYKv4d/zBkMlBkJYqXMdZL2bIar6fYqSj5VGsIWlu/Vvu3qY3RdvICvvZEHlbIzLmvy38EZAG/bIl6Efa78neb/DiLSYLpEkOrC2Jk1vi9Wb4Ss+V4mtxWck3L+0FV91KIyfGKtwYoDZhWxOJp2gwsnNTZDscWvRvkHKgfTIg9WUEtSAbpeujm4Oytc0qQeAECRSpdKZ0522cxsYHyAH1ZQP9IIJvEYsyCv+qu7haBNC3WYwCWBnMrbSW2Oe6OOKYW1SqrQbeBOSwuEF+yIJ9XzLg/94C+pUDjgGPqFI7YaOZ6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(26005)(52536014)(53546011)(7696005)(6506007)(71200400001)(2906002)(5660300002)(186003)(8936002)(478600001)(64756008)(4744005)(76116006)(66476007)(66556008)(83380400001)(8676002)(66446008)(66946007)(110136005)(316002)(55016002)(86362001)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AJrPwuW2Y99lZ7Mjnc7M12hjVHC+zoW8/6KvkLkynxKLAA7oSxGBGU+Ja3Uk?=
 =?us-ascii?Q?DvB9+CaJ9tlms23S0HyGRxuWObtGEuI+yYMROtupFNiNyeSJHOda86q5CnZK?=
 =?us-ascii?Q?rMe9P0/rzT5XUKCGarEkscWCrNkP+lXKjXqXDPa/UP7gkgPFvzM2IzzsbFz6?=
 =?us-ascii?Q?fao740l5+oo0yljuxoUGjN7QXa87SOl4H5MLU/cEru4tEYnm8Hw7HopcZtgt?=
 =?us-ascii?Q?YrL3kHLE6diTgbo5QNhezxYIk3EBxFO0Hzdoc+FEPWwnEM1eZHoN6LfGdsr6?=
 =?us-ascii?Q?pdUW+DQVywt10UFdoHQxhD1PDrc6FufePe5L5DbDgn6k6bw2m8B2MEFCxPQ0?=
 =?us-ascii?Q?NXgiPzl1JZdFzjxwjJv1qeG/HtKvdCiFLKLrc1wnSfDTjAZ8TFZEdG0wCdkC?=
 =?us-ascii?Q?IDV6T1AlyJFmnUS2F2t8/7ZyVTgLZ1Qz2AuL3y2njVJl7+DyuxMieOqJGy76?=
 =?us-ascii?Q?W1c3kkJoqzAqsXIRBpOiPfoQmLeItOOHnF/9u2J4hjSJwhxQzMKtFicqsWq/?=
 =?us-ascii?Q?zhZ9KN//q+blH5XjQhon1hCCwN1sNiXXAVxY4WlJUBTbzpRVjamOhjpbS9qo?=
 =?us-ascii?Q?k0PFDrVWH2EvZsWfKfj2nMDzavX1rg+1jZpcynpv/kC7PrvmDCljaCBiiX4l?=
 =?us-ascii?Q?LXhelePdi9gK3dpoF0WcvJ0UYNhGxU56H5l6Qu2gxa/REoGY/bUHW1fJRTa9?=
 =?us-ascii?Q?heHwg/oWNSKMPJnAaT8j/++i5T6gYC9HuOd6O5lLnYQ4DfYv8hszTzKBIwAf?=
 =?us-ascii?Q?4flKkYe/n+4wKYRYXO8qn0u143N/B7U7kR67lto6A1HgnGjT4ftDYDpyEoF+?=
 =?us-ascii?Q?ct1XA7yo5/dIipJI0mpW/nUDMyVL/L0r4Tz6sRnG/wmzafiuD5Op8bm/S/zC?=
 =?us-ascii?Q?OttfGcMoqzTAm1KA0qLO6/SxDE7gZYp+tf+mY3OFGsWt1NlEZg/o+Bl9fbDU?=
 =?us-ascii?Q?eNE0Jsf93N5AyfyPaCVRczM7DzYB/kBG3ohSZM9zOSbL1ypVYviP3acEdUwi?=
 =?us-ascii?Q?OVl7QHEZuh9u4kuStIi+gcifbvpFXo/8kGp9CkknHK0FP/znV1h/zXiBevwD?=
 =?us-ascii?Q?+c9jUq3u5E3XGc4cBH1suH8IStcNYA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc57b1b-811e-420a-1e25-08d8c70d2772
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 23:57:38.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eu/7pMWxTJWwchouU3n2LoZekst5C6m1OwyFB2veVmi4erz0/4DN5nm0pAgRwM/gIhoVtlcw9UgDl4RGg5ft5B4qF5ELW5E2G29wYXnde1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/21 15:50, Amy Parker wrote:=0A=
> Especially in an expanded form like this, these are ugly to read, and=0A=
> a pain to work with.=0A=
>=0A=
> An example of potentially a better method, from fs/dax.c:=0A=
>=0A=
> #define DAX_SHIFT (4)=0A=
> #define DAX_LOCKED (1UL << 0)=0A=
> #define DAX_PMD (1UL << 1)=0A=
> #define DAX_ZERO_PAGE (1UL << 2)=0A=
> #define DAX_EMPTY (1UL << 3)=0A=
I think this is much better to read with proper alignment.=0A=
