Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200B431C4C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 02:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBPBHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 20:07:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5822 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBPBHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 20:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613437666; x=1644973666;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q+8mUUoqns61tUwKkjNz3M/c47KnSODdrTYRSkGJidE=;
  b=U8wOzraokTpzAuGi1el4HsAyT8BZ2z3q4z3/PwUKenrQbSfgDfuDkoIK
   bhBF2iGxZX57h/OA12UQSmOBmk03Iibxsci2bEbjq7gi8006I5aLGl/d1
   EMnQp3gVboP7bnnoDqP0vKE7TvDU3V6hqLYrfrd3WqFnYlST15rdxhd4F
   zy/4ts7rScAQQFr0H2LNsakMwxUAWGVtBNPHfNiQumakjrQq9NeDw6WWg
   KQSXrYQ6aXwzZs5UoVFr/Xi0NaWi40mL2oN5z/VXGGU3Ur7ZdU+zWu+bw
   GBvmjRqn2sMqD7xXygpgDTpldSdVfa6XXOkDJW3DYecqVC187ue+ebba8
   A==;
IronPort-SDR: BvPkc30USXnMokzpw2IZ5X9FOsfgCTQS99133zXV+9qAesSp+qC5J2QYlF6OMEIatp/7s6Lm5/
 0PWZzz+Cw0dVtZBtk/BDdGLH1mjR25nTR77lMPJ6cxEIHyPYfjtCb1H3qW0ZwAiVXZC0PxrSbc
 A5kVkQ/db2dXEE2LGzvYwZGcIn3zm/jlujBzqvlGBnhxf5LTs/HuLfA3L9a3fuGDrSy/UjImDo
 gG/eZfyArRWFD3Zx9Pa0RN4+gxoqmQUhN0MXg2052VCDp2qw4WJ45YSyi7Mym1qT/pmBUSnTTI
 owY=
X-IronPort-AV: E=Sophos;i="5.81,182,1610380800"; 
   d="scan'208";a="164500116"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2021 09:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPzDJMAW8k/f1/rb3oS3wZFwiE609tbTZw5QGkAL1oIbDJegBpR+Im5I4L9V/AHlVUKfQTAXhCNy4IJRoQ2av9siWKpbNjvM+4sxetWUHCGrmSGAcxSC3kFspUGXZaaeX5Y0OuzSraTTSuuQ4GLnAYxJdxjqJbX8lXZjWRSw9noXRJonzlLEVsq+YsKdSPeCJ6WKLxlC7qwD1xxuThm6ClN4eFeGa/aOobUnCDqylO2Q6OMDgUhB/fQtI2CDuq7wH0HuepMOpRD+tShvjnStiJBwrl4DoaIc1yrelbQZA4QyKvO/wftPiqRCCcEIakUZFf2Oz+CEYIqawnAE5DmQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+8mUUoqns61tUwKkjNz3M/c47KnSODdrTYRSkGJidE=;
 b=QMjHJYJED2Xn4nc/5SxoSAKUtRzQ+awhcZEp7HKQmC2neBNVLKJQhwHx9K503R3aWEcchDOgJzJj2L++/3w3hEvc8ZZ2R094mRPEGVZUNm3tTIhVWayEWrw1+gqGg5O/en7ZB36aD/9D89maYgzBrz5oVVEJb9sTYNmfygjFGt5pqCIbRLAFTEYuo44Ddr3QtPkNe6/IGfZ/SzrMr7Pi39101pruhqQpwrNxC4tgt4T+7Q4CF5gmKoYWVeBzW43VVhC/3a24YrXZpIkY29ZCkaY3XbwCM5NGdyoLh/jiPrnFuC6HingNRUhMY8RoWcQ2RGWJmeAM6SZfSl35giMLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+8mUUoqns61tUwKkjNz3M/c47KnSODdrTYRSkGJidE=;
 b=c9A3B32M7yecFa+Kn5pUplacLuGDLJ5+roNBVF6ZScYkJaVw2z5twGuBgomzRj1cAMyZpHkyef0O6svd99wDwezsydLxSXzYdIA7Ec/tt63bdisfdgBfcG9xTIdXgfHO6Lhao+jJQr1GU4Yr6oK7fKLQaR91cRtMq+Uchml0pW4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6478.namprd04.prod.outlook.com (2603:10b6:208:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 01:06:39 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Tue, 16 Feb 2021
 01:06:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] zonefs: fix build warning for s390 in tracepoints
Thread-Topic: [PATCH] zonefs: fix build warning for s390 in tracepoints
Thread-Index: AQHXA3tRxo13//ANTkW3IDmGBItVlg==
Date:   Tue, 16 Feb 2021 01:06:38 +0000
Message-ID: <BL0PR04MB6514DA35B439BA7A5AD2B383E7879@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <d3378bec918aab6090def490784fb0de5a336388.1613380577.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b438:c9a7:948a:1ec5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 004cdf84-c30a-494d-be27-08d8d2171d48
x-ms-traffictypediagnostic: MN2PR04MB6478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6478BE816906A639CD8C8CEAE7879@MN2PR04MB6478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AetG7QwFufTmfqIZeHMPAibVy2jPoY4Yb3KSIsc95wndnXz3Hk4i+XSz6plrADQA0ePiX8BJp8YfCEM0MDXK+72OzTAzWDJlwnSpKgkMufPdFbVcs4XmI3qvg97jyVmvwYsMvugo3esKdcBlXM4+A/qioHbJYF9HXim1/K1n7FCd5nXbqPW3g3FpAGD/L4mjwwBYmwXcDXg0xta2psEovSPCVsoU/7YvMJzKv49AuVQ1istUYRGOzNNhSKNApHtIYzdOCtlwxzFPRd8zA10gJ+E8QLAtRoPZSNCpYrj/h5h7o1I+V8zI1MmFFlTHcCwLFArO+zyNLn0zMW25TIXfWTHtSYvE8Q9CkhgklnP9vuvs/TPu4UGsOozecGi+M2W/l09OQDNsXxmChWtU3bJ/4UWXTG73XdQmheUA819NBqPVFOlj0i17GQyNhtp2iGj+sh7zwkXqu1cTreHNSK7epewGqL3S7JWfvhBG9ZQ/KmCNw86gYr7aV39FDzyA6/2HjGU72w2p5xfyN1LXdhtvPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(66556008)(91956017)(76116006)(83380400001)(9686003)(66946007)(66476007)(316002)(66446008)(6636002)(54906003)(33656002)(64756008)(6862004)(186003)(55016002)(7696005)(8936002)(52536014)(478600001)(6506007)(53546011)(5660300002)(4326008)(4744005)(86362001)(8676002)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SiPfKjGo6jvkbLMTt6MOInjtX594Emo+2SuzjXITzIZmdgn8uXOdTusqqNNy?=
 =?us-ascii?Q?z7aul3HEzhjuV9WoX0Nho86qSroB6K19RNXbb3wR9qlnopJP/KAEFYT1kQIA?=
 =?us-ascii?Q?Vp4DVd7AyY4LkSgOb2RdrpHJ5gLPGZDNGvwox1vUIQ69/muf/kf6YeW56+7A?=
 =?us-ascii?Q?ZCBBd6wbwIxa3aYX7KXtH/QZWpr3Q2mq1XIvR6ceeOQYNs98dSjuv3L6u90U?=
 =?us-ascii?Q?R2999/bY316UrIq+WnkY/JBilZlYPmaoVkUBU70BpXyjFDhFlhk+XlhkBku/?=
 =?us-ascii?Q?LGXhVqvRHIu9GUcTe6NJQ4G79eaACBLzt8VWUcxj0gp6D/O9mvGjcp/hS2r0?=
 =?us-ascii?Q?VaT+xvJIiOe4h8jlGZDTWqWCjFyQNE6O1mzO/S7rcAxiF/sMvEX0Zl2DCcZN?=
 =?us-ascii?Q?Uqk3Ps1omYg7qQ6+Ld2pJD+COMeS13mCQmuWkRIHSxPPDqoB+oha1eMaarNP?=
 =?us-ascii?Q?MHnMRJ0xEGy2JW5DqTtO0/QqpqkWiHn0l4wZ751oDiFD9WKDKqjYOoTjGzWm?=
 =?us-ascii?Q?rIsfQMTLWzyX4MbYdmDgTHXuJzzELBxZoOgjGa9WiRlijjyPml+h6C8HK20P?=
 =?us-ascii?Q?rBc5VGTRZRXVcKlYHp5+9usWNKTIS1CWRM/ZCurgDD2sFd1BMYeihv5wDert?=
 =?us-ascii?Q?2bLVUvAbqnD10+xGMTHJjqhlXVOr4XgmGnyN505Ncg9pYvVyNwVygOycZp2J?=
 =?us-ascii?Q?HqgAr5nnGjiriorMEydkZ4aeb/fwYy1JhyA+eUQDoexrYoNLyi4sjAst2xQi?=
 =?us-ascii?Q?VgOjQ9WWt2KZ0LY/WbwtHc1aV8hT7jIjHm51S77eYyakGitbXssnaOsz3Uex?=
 =?us-ascii?Q?eCnsmZU/GQMSeZZ6TcG6+Wld5X5VmtrLT9BwY7/iUlTBChdPErcUFxCGTaQR?=
 =?us-ascii?Q?/tybIhnxE8W+fSkVuuZ98QmMwSOdExzqsrDmXPd2aGBWPOMjfuMkiPcDpCZb?=
 =?us-ascii?Q?jhKWmgUwGdSTEGt5CpJaRPSLPjL4EUwcHTw68xNe/KRc8IZ0JQ8LWR1A1ce6?=
 =?us-ascii?Q?FSzZ/5XnZih8RX/abJpgUNTfjXGfwymCYdSW1gFVcMd2nTeKiAl6dXVjW4jL?=
 =?us-ascii?Q?vRhyOrXV28i9goPDFKgeXjarpYFI6CFRCfhcg4prU0HuCmWgNPaed3Nwf7se?=
 =?us-ascii?Q?d0T0DWheIU45506WJTRvdECnvBtuMRUn57hAhd6luAnHaKQ/F2AK0AVm2bxm?=
 =?us-ascii?Q?2FLxT/4zznDnU7id3gN+tCOfvEwdHdmhWSM/CUa9KRW+9FPlqGoQZlh57f00?=
 =?us-ascii?Q?E1C+qCxpOUM/oXtrJuroDfSohRG7GvQvH6W5qA1GREbdWojohPKB6jUupRd0?=
 =?us-ascii?Q?Zgdkx+7IssuNmE/AxtFA9MBAda9JVu8IT9q778r9C5s6jSg3ci8nM7WXJIQb?=
 =?us-ascii?Q?gt++siA3VUCSCeXYNrsUqUHSl46gpPc6/fjGnm5is14+fBOIdw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004cdf84-c30a-494d-be27-08d8d2171d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 01:06:38.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXxAO6vfmbOZoxO7wD992lD2gcRP5PL4faAW/onMzEYh57Yb/MTCTDmyhDwCJbbI+qisYQApDGeAYBUE/GqB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6478
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/15 18:17, Johannes Thumshirn wrote:=0A=
> s390 (and alpha) define __kernel_ino_t and thus ino_t as unsigned int=0A=
> instead of unsigned long like the other architectures do.=0A=
> =0A=
> Zonefs' tracepoints use the %lu format specifier for unsigned long=0A=
> generating a build warning. So cast inode numbers to (unsigned long) when=
=0A=
> printing to get rid of the build warning, like other filesystems do as we=
ll.=0A=
> =0A=
> Fixes: 6716b125b339 ("zonefs: add tracepoints for file operations")=0A=
> Reported-by: kernel test robot <lkp@intel.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
=0A=
Squashed this into the original patch. Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
