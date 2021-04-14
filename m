Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7601135F09C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhDNJSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 05:18:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32545 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhDNJSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618391874; x=1649927874;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MisUxQ15CNG27tI65D0e1bRlA+zyVxtYyMFgW7VxgB+sghOi3YkydPNN
   g51AjfCFfnANF6/KY/bFRGtazkVGyRvUqoH+42Zrzc86z/MtJ68AfDdRf
   IEuCzm46Mu2GZam6p6K0u2An35yaT9GiaQ5woY6CqKN9Hqqyzi1j+/7Ab
   Uk3e0EW+9Q4NqxGkAhU1uEue7CRkIeuB5F51k+McNVF07rkTsmh9szeE4
   fCjI7RLJwa7S971q0gC722eJdR9lzx42VrAzUxFTeIyRz45RAtFCamF/o
   4RXuSj6igEfPjoCghDUxbcN41Kg05pzl1c8Tao6dzvmrHDWcmk/mnyHwF
   w==;
IronPort-SDR: MwsB04DU+OGTRSXOLdmlaXV7Yt9Y/ON3Eq1pFlRI6F5mPPt3omwFwWaFXeT51pWiT7qkS+meKZ
 xtUvSayA2a0efN4QzX8Zs1VA9UUnkn751aSlHBtiVw8ZUgFynDz+XsFLLddV0haPD+rSnFo5xK
 zxLAvoCIxosQB3IpwM2AwyEy3f/QBHOPIRoqsHQMEjQHLfvioJcx/8w+Hd03VAFgrvderXPuPR
 jLsWSy9Wnd1SNnGlg2MvLUztGdnY4I5RVolQWX/BC+/wJXqFnQBjG+0oxQIRLC44k74Xssoctg
 lbk=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="165462330"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 17:17:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOMBTQKGTsDwe4MiF/DE2zJ06Ba2V3PjbADXnWiDwh+7I5FwaFAw5mTevlTohcdXxVM0FpM+IBE5I4XEqkOowLVeaPHxkyg/qJiBpxuxsOZPVCh3EM/210hAoLggQchSFliW0QeQz3u+atCgrzdFYlIygl1HwkCk1Lf+FsWFnzhONSkbNJLPBe8o1Fh47IvLm99j9QYgxA6bIf1mNrrqwmsZAcIdHp4MOEqr/zUYQMUZ4LPh8UzMue42YqhIO6ZA+QEec9zyIBfGjopSmqqOU7CGWrd6WxMhJJXIvFDEc2hqi1C01UaUZrzRgx9R9JeyI9/wilPgF2r6jlymeP5prA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QtuMMjaYuLLiWxMsF9F+tYHQS97g8T1CtnOnZnClEtl7LTvxvCRbwEm7BQjxFctYyu4oda7DVVlniD5HynmueiOvaPFfFoXfokhSz2XG8x4R0siC4FyUmA69RJ1fvWGtgMfTZUPjba47quSTkeakTjbq7nL3N1xTsKJYV2ZenuyP6RD3Aa8sJL9rU6A9n6ue32pSlSq69NElW/nDS1WWg3Qq0N8tBvyWB+x2DEDQ8lXXZDcVGhdU9LhxPe9jNlQfhrsqqgq6xKBw/mcaG6CcR58WkPFd6hrrW0C2PoTwDSPMnORl/0w475iWYp9vYkp5qDr2b5MVO/e8HTTMHVxNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RgLvor4Zlkn4ELCUGpDEsDU42oqDtl2c8Xhhh2WB8sJsz63OJzI/gTHfLK3M+zudpoZtlvQVoKy++x13XSPw04yD1T+i1S6T0TJE2xf+pLniYho9qAv2Kvct90159Z2adpcv2nAAyjDmm/Wk2/KOeOLqNoQrKZutMU9zJgc6ulk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7638.namprd04.prod.outlook.com (2603:10b6:510:52::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 09:17:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:17:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/3] blkid: implement zone-aware probing
Thread-Topic: [PATCH v2 1/3] blkid: implement zone-aware probing
Thread-Index: AQHXMM42E292WAY0n0KSj7P/Y1BXwA==
Date:   Wed, 14 Apr 2021 09:17:23 +0000
Message-ID: <PH0PR04MB741632E9550D66AD1536E8349B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-2-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9111107a-f4f6-4abf-636c-08d8ff261d4a
x-ms-traffictypediagnostic: PH0PR04MB7638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76389B6B8A5B974D2E27B9E19B4E9@PH0PR04MB7638.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zi/Rs6GMvGvVUCoOxpHYapSucXXnhZgJpitHtR7sZpgYJfrjfmI0+cVYTavzc2QWELsHhJZH7nI6SuwSpQimQR16mpcl9B6GN3cWvLOARgp0hZ4sPNJyNkPHMd0BaISR4OZavqPuWHOud0AzXSK09YDtsOjm616468ak88oIoOC3hNj3AR7lukLKagqrdvyadHsXpOgd7HKuwzWuftH/8yuVPnl9mOdqDe9ErBCCNbDTzvMLwV2VD1aVFlCpLw1+lhBx1365UW80p6ktffsTQ7B5Tv44JuqXzLICiFDeBvI+Cghu9fd6KvKVaRVM6zv55BlM5Vhyv8+mIs8TFCwvofXfVMpvUkPcRSEWMqhOW7wXdA4yziWDewmX8nQp2uk7J08IX9+bsvKygtq0kgi31YvKH7k2GDmMR3FUcAaq5MMhz2tpmnY6yARCtrdu2F7xMI+J6czho1zemk6Dvu3c/zQub1NORgL270avf5IZgIDLGMTtTDqjw9qUo0keWQ0YPxQVIIqj61PI3PncaJN/ZSXNsXVPN93YvxGiDCqmCter0WWeKhh1FasYD9cOxCSYC5agI2hvSa4no+/30j3tqhlJZ8UUGJfHDg7T5mDBPJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(8936002)(66946007)(55016002)(54906003)(8676002)(316002)(9686003)(110136005)(4326008)(26005)(4270600006)(86362001)(5660300002)(66476007)(66556008)(7696005)(76116006)(64756008)(6506007)(2906002)(478600001)(558084003)(38100700002)(19618925003)(122000001)(66446008)(71200400001)(52536014)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S0ah+5GrZNGPAPvB+XyAFTPAM+RkAaEdrR3/mk4f4g3WqdnaYMnpe+674OTo?=
 =?us-ascii?Q?FascPXmCrls/uWuPH+P6cXONLKSOoFArlJCU25bTyrAHWmnXXZbvTfcS+U4p?=
 =?us-ascii?Q?w2+t39qKkQmIL1Y9DGC83JZdPseIVwhMESScKARl14A3yIWc2kRhH+huEOBC?=
 =?us-ascii?Q?rjC22AqyAbF59lIDLp9Xe7FHK0UnVQePV6k7nfFDDShszUOfH/5V7NmIbDOB?=
 =?us-ascii?Q?mrr8wBVLdhhhsNWwxWaSzocA9NMX55oLYaYWTQ+VpvGOm6uFjH4sKiRiA7z4?=
 =?us-ascii?Q?Ye17eWas1dIj/sFe9Wh3IMJ2ad6B354c9TPJcwD9zHbgj9nPCL5Bc1bl2Luc?=
 =?us-ascii?Q?Q2Jn8urWCIXQCaVutJcp2Eyny51onDI+10N3gDgAvhAKMEByxKU6LMiPFSNZ?=
 =?us-ascii?Q?hmKBY29Rcl00bepncVHQRt/k5kGr2pQ8d4JxzMp00y79JD6j7oVJ0QBQDVJs?=
 =?us-ascii?Q?LvkJ6YSpCbCO2sxs84moDHXSDfyhSTuTCcd5oJ9XDoyWvnAe25k5d08q8SF3?=
 =?us-ascii?Q?x7H3ZqWprixBZjer6By63WKpI9rvh5m0i82OMGjzbAl/sJrIbKp9bQMsUQ7t?=
 =?us-ascii?Q?UwY/VtPO0ivfs9EYyve4ey7YaE3tWPAFoqQGBBVvj45RhWZnSnN2v+zPxxzi?=
 =?us-ascii?Q?ZpfcFSXhb3jVUQP+f6wcPB9i3qMSHQSM8IdDA+7XU53RcUQZSOuHesOG2nKu?=
 =?us-ascii?Q?HxB2TDy2oR0VeHnACEL+5S+RDflMoL3QWLPwOe54Zxs3QLe3JxW3OYL/3rWw?=
 =?us-ascii?Q?6qTXcMWwpWcC2wDCuujGmUV3pQoTqEsWLTcsmDQnMYja4CZZpctZiNdgKSJj?=
 =?us-ascii?Q?vBjmQZwrNDf0CG7Pd3nTdIZqSjj2faz+WrNPVFXHQOnE/LtlaruTSnBwsz6N?=
 =?us-ascii?Q?UsF/sq5SfphT/t3x9uR5K/yBfSO53hWIAhMpOn6vHKlbAA0eoaxiBBWfD4rU?=
 =?us-ascii?Q?aXDqUXbqPgDKQ2p+vIsTXnXgks+4sHWvXi22MHTKpWl7+aVItDdYjjWaWmFg?=
 =?us-ascii?Q?lMELUVp1DdNGIQP1WNHR2QtyiAVuIwgs8BrBqkilWf5Z6v1rrQiQV2DzMueu?=
 =?us-ascii?Q?k6GCSWt/Xl/04QNcWwUbHw2A3LLkICHs//P6nObLHLBD7PCcEj2ZnCSerBwJ?=
 =?us-ascii?Q?TCE0lPYz3Uw7LqeYF22MDHpIF2k0+JlJqN9rbhO05eSj73Ddn8orLbRbJELm?=
 =?us-ascii?Q?De0Fhpnmk6/sbi5iuvdFby8A1e6l3Qe/HayNbKrg0JC9ZRdWFMNzGN2vFY3K?=
 =?us-ascii?Q?MIYCjUPCE8Y4cc6GnDEr3RhCkKBR3Oi1FqE0SDsrVo7O/wGwVohF+8BU3Zol?=
 =?us-ascii?Q?8D/fN0wZdszTbVcUUj/dZlqAdGYSajtYe8JunC7j482UGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9111107a-f4f6-4abf-636c-08d8ff261d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:17:23.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlA2oOGUlpa9W1tYr8h1cbxmCrpCRD6MpV47jy2wfN4HDI72Gf4+yWq7kVpyMeEOzCE7ngC3U0SP3lospZ0IImTpuohy6F7U/0wRgjVEEDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7638
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
