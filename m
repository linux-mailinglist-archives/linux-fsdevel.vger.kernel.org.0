Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E32CA154
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 12:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgLAL2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 06:28:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12559 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgLAL2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606822109; x=1638358109;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7swzTNKt3/FhVRX0OoG+MEfVZ6eCmSzjCq3S1Bm8RWw=;
  b=U3337PGa+UVo25zFm1J5q1QRmFa9MkqfzfEnn/kF6JUqLf2upoLu26bJ
   XuvgGakDIqVABAhae1DQEVQ46hhX9MVuWc7EDFkT+IyhhvtriZTaK0LcI
   K15KJVFR/h6gSZAFZ6mgR+D/1fd6kKjfEuyFY6KjZ/naHSe630dB0Cqq1
   wShPJCAD56XMhZPkl7IG2z/hn2u0/ao/TYRKcMNg3S1Uw8FUyazUgg+3R
   0uQE2rUmTL5AnQWGJE2P9M3GKf/ZhKpqyZGzHvgJu/wfDqCzR7OvpxcTk
   VH7iZS/lIliZElmvnyGo47ggEr9zCmeyGKvIWwwgGjiS7DmPkepR7Oazd
   g==;
IronPort-SDR: 6p6En7o1LRoWtZ3LzcG+G1hYM3ikDmuiwx+RAnaF1GG1ZcFy2wxnEIXspi0YSwZwryMelPlFs3
 0TFcbu6sc7EnYvgM2tqupBmrv5ziw67KTxYQd26GCwo20lXoRCuVd1mBbKSAzM+7jhdh0XUz30
 x3EidlCB5XrU1dbgeOoHSCM3+3O5mB47cHfEIW35Bm2e8VOsMO6+r0rvZp6Y/QVi5GZ4YgZH8D
 +ieQqSUtRSeF8kzhAYR4pDhaojpmvCwIRvi9XO8RxTBpvgbPlu0mjX2m+mjzoiegmC6dH8NHFb
 N8M=
X-IronPort-AV: E=Sophos;i="5.78,384,1599494400"; 
   d="scan'208";a="264038806"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 19:27:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxEjdGFxHE9pqE83iE76eI+dGWUS1nz6LLlBaDDdRB+5vJqXSv5WOePGSftyzqnDRmol0nSSkuuEbjnU7ZS1RohAfAxE70nwrSJ1xicIGBD/+cvoUgl1Z8/7/ZmFjomDo/3YNn449x1ZaN3gcarfSd9gb5uztTR5Te+6a6kRHvxfp6L2rsdorpTNNnnBOSgQQgNu9zQdtTA9sg5or2SinyqTU0sNzzDuntYQ2Ti+DmTFusl2eAB6NjTT/ajjYZM5n1EwDIQ4Hkh38Wla5iOD3OLJRJJMB5L5x8pYRgqsxlNC3yREqYSgNOYpPthIAv+0VRj06MVp9TykvAIwOrBnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7swzTNKt3/FhVRX0OoG+MEfVZ6eCmSzjCq3S1Bm8RWw=;
 b=KEB7Bb4PfKb3RObdizmZmTxJcmSdx2xY2lTSXKXKD5NY1FGKjC/vNxc8nzDg3yuU6CH8lHzyqS5Npy54H8NG3jYqGoBxMyND3/EYsCiJaiqzONLg6OzgS6zzU9PzlEzPITN+Rb7og++qzl8CpkjtB7CYFwjzGIAiIXxGp4oL3Yh1CmTrgMd0/+lro4Syn6+1ad+0jnWH5OqruQuPPV1nW5RLQiF+tJrLFRjcIPHyYu2G0o8W2hC1QbQ7afKoQHghop9Y/1KpJzPjBK0hC/3RtTF/ccFk+0igyiJLOmtVJbbAyPbU8Vq2zqftkq9ycs2Mw5py68xWauNXhiFKSxIp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7swzTNKt3/FhVRX0OoG+MEfVZ6eCmSzjCq3S1Bm8RWw=;
 b=rO5YqEf0t2wYEcuXe4Ji9YacgUu7W0Uk/LenNCj8qW5L/mC8oqbL5e9bqQ7k5qRxGAYIc45kLf8skG57NairTE3wJYzX+TGVhLRnU9sAVgvDHM1fYvJkvccptvqS918YALpDsNaAgVO0rWRa9yBMQ7KMf6gsbMa5zaFmh40QnIw=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 11:27:21 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 11:27:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Thread-Topic: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Thread-Index: AQHWt1SX6TBkGrIRlEa+5WXQUx+StA==
Date:   Tue, 1 Dec 2020 11:27:21 +0000
Message-ID: <CH2PR04MB6522C521169922D1C8732A29E7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
 <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <1dc43899-82de-564f-6e52-bd5b990f3887@cobb.uk.net>
 <CH2PR04MB6522151758FE8FD0ECBCB09EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201201111146.GA30215@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00c0f1ea-0d7b-4bda-0dec-08d895ec11ab
x-ms-traffictypediagnostic: CH2PR04MB7078:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB707838F6F28F35F39998FD19E7F40@CH2PR04MB7078.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWKyFKFwBDZZ6nQtoS9DDbG61oOi9hQ51rgHIDmR9auxe1TOrRt1+x1GofRCgCquyl0ovNV52NZ+oMl6JZjspMF6ouiki8HiiNAM2t9iq5NHq7p3t5fmZO+hfBxgPUxKGhIyhQghwJpEi3Ed42z4q2FWgP6MUTlpJXPrCSYCycX9K2jx9HEKHvQaJXtg6Qb3ItxfN3yFDmixI33nErzrephD2rHOp3QLjVJhqcog8gRt/ZTYjvo5M8FNQ6vuM1Rz2qrMDF33spsyNRLtcCTHELrS8vcsNYaZJZturfTk705aURiJ368VxDSZrzzrsj/SC1oIKfAOweuL0EJWyft7BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(76116006)(86362001)(478600001)(83380400001)(316002)(9686003)(6916009)(4744005)(7696005)(4326008)(186003)(66946007)(91956017)(64756008)(53546011)(55016002)(26005)(71200400001)(8936002)(7416002)(66476007)(66556008)(5660300002)(2906002)(54906003)(8676002)(52536014)(6506007)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sQ/msObhU9YNEcIQ36X/fqWjFlpHof0Pwk0VqO1AF0DwhGsXWtDQdvlC9L2k?=
 =?us-ascii?Q?EuffoNpEpBYD9jIciELOcw0QKxNlv071Lk6OZogXKG6Lk1hbmEX+5LAey7Mr?=
 =?us-ascii?Q?lhLuJ1rtMaxPb/k+z1ZFz78FjaRhQLbQq7BKLY2Sp8E0IzUBPJVsCy6LcyET?=
 =?us-ascii?Q?3hFIXbnak3nUBlNIJd7cQYBP9dx9x4m2N4MeMjgXojTSp34EemVFggRafmNB?=
 =?us-ascii?Q?uuzgvH9HRcwIOcR20v5zvjInukAYWaKmA66HtOpma/rn2DRxnQRyBpsYoTbt?=
 =?us-ascii?Q?fXTxLcvZU8H1Z1ez5Mlu7Fa6mcZrrXrA20YCQh/9e2Rsv1JMr39FIcUWwLy8?=
 =?us-ascii?Q?orXQrbAPoffSM4GEfCzUf2xntiq9DNjpn1VLPquxBCnxVZmg2jCoscg6FPRi?=
 =?us-ascii?Q?jy5icahTPWAmBktZ9mO51r4by2lz3aPx8veQXwcxdjiv8uihIotWr6goHvZz?=
 =?us-ascii?Q?c4AII1rgYsrEoRRa20dr7OdvrcaNtZXOcAckIqjHKx8pLproyAE1e5T5Vxkc?=
 =?us-ascii?Q?/auyechSn+IUq+abUcnT5/0MxsqzakkBZv3sID4551WJB+Q4c+6tI536FqEh?=
 =?us-ascii?Q?kTrC4PcTnm9f7qgvxkkKzBOzRwLyBzWHWDynfU8/cpF8RGEDPrZspWrV/YHX?=
 =?us-ascii?Q?XDvoyakC9HDjIjH8Ouz0WBXwtPchbEhr5OaUGTVm0u70gI9N3nw4D19n8fHg?=
 =?us-ascii?Q?toFqy4Z8qY8T9tBPXOS087hWqJ9hFSdR2lRZEo7dhO+QNffKDcpDHsGHAZgp?=
 =?us-ascii?Q?EmhSS4WkHNsx76riVaWOolizzL28JJyrXV5VeqCQRNn1YRWuCurGPhldTrFS?=
 =?us-ascii?Q?cEMt1bxHOujJH85EF0GAh6M3kxWBErwIimoyuyVYTQ9t5+VYyTetQ5iWMDp9?=
 =?us-ascii?Q?Gw6zyugS7dSC7xwZo4leGVW1PyuA8GyN+aVgwWXyp6SOykMQ3GF/zD1Pn5B/?=
 =?us-ascii?Q?Hbfnp6rtpvpCjXr+ATufLRQO3H0HXEL/oCXQAgLwOmKmpwEQXIncjzcNndm6?=
 =?us-ascii?Q?pFD0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c0f1ea-0d7b-4bda-0dec-08d895ec11ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 11:27:21.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO+nUdmYVht5pSPeuf7cmfiA2HgZCcfhpWazEY9za5p03tYRV/cxICncahae7wDaAvPPb+sYEZ+LMuv3bkuZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7078
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/12/01 20:11, hch@infradead.org wrote:=0A=
> On Tue, Dec 01, 2020 at 11:03:35AM +0000, Damien Le Moal wrote:=0A=
>> Well, not really. HA drives, per specifications, are backward compatible=
. If=0A=
>> they are partitioned, the block layer will force a regular drive mode us=
e,=0A=
>> hiding their zoned interface, which is completely optional to use in the=
 first=0A=
>> place.=0A=
>>=0A=
>> If by "untested territory" you mean the possibility of hitting drive FW =
bugs=0A=
>> coming from the added complexity of internal GC, then I would argue that=
 this is=0A=
>> a common territory for any FS on any drive, especially SSDs: device FW b=
ugs do=0A=
>> exist and show up from time to time, even on the simplest of drives.=0A=
> =0A=
> Also note that most cheaper hard drives are using SMR internally,=0A=
> you'll run into the same GC "issues" as with a HA drive that is used for=
=0A=
> random writes.=0A=
=0A=
Indeed. Good point !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
