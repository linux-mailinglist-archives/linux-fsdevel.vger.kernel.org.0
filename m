Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B200E4D0405
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiCGQYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 11:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiCGQYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:24:45 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E185620C;
        Mon,  7 Mar 2022 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646670231; x=1678206231;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HQDZUsuduvK3br/rGiqhS/IzuONYcQzuaWlP5ZGErOk=;
  b=fiEvxhBoSH4exE9qiEcx65vHMt26DB1+xPLsGuFIyVQ+j1P6GLEBVDvL
   bPpFuWjagqJTRSBAV3zfOunZ2urhOo4lXu/+9gvDLV36mZLBsFcahof5G
   mnV+pyAj7tS+NgYUGC2cTCWRsTlJKkoTUiV115F6L5Koo8f5wGctr2AH+
   /ZvEIBu+pTHWYLCHW5U+r1YwTKdV8uo6SjBlP/Yt3X0FIkVjcWCZUbbCZ
   O0fT1rWZX72VD304BOkZHGefYASiyI6Y5oRXZc/qOzQA64OdA5lCKYkLz
   Cgn5NvCuuwtECVbzxNMtslzZPIPCkvnz91mrURPlmCPy57DMzpRyEpAPk
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643644800"; 
   d="scan'208";a="306632224"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 00:23:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4fnZKE76epWByMWBSy5NZe461AzrSajCPsPpR2b58MDNUJUVBhdrwrfkFdGOUmLADXLKNEvw3lP+C/S4YVacTaCAJwZcSFzu+vWz5uZgTBPaBMK0ArLf3pJ4pgxqU3QVwNfXTEr41+FBMoIw1J4Wxjc09MwF3hannjm4Z1nMLhMz98ceYWwKZuUCzlyu+iMtaJMcT07tYtbB2bQT2Shf6Nosk85l4i1kLPVZefIEzLOb+H+QxwN6POKf+GilKPWdibEVkkMy34HpLKqmTWb2Nzlhz1VBizvINW4UXxmvpucwGCk3Gt8bbuzDpBX6ekigmBQ4K/ZeazjujFdM9tafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnm2Bqonic8jWRrzWvtOw7SGJkMZH41hMdlNuPSB5gs=;
 b=Fq/WRNGq19VK7ek+REo2dLEYr7gnbFZnpTJCHs73qYdrxJJsMy35u3GFvyhc13VemA11Ed9JzZXyRn9dmPtNtvL7Lgf3P/PQZ39VVGVBsFb3m7XiJgGxtQvNYRtDBae4Ja+rKRlwjbMGIovPUoFV4GvKtMqeAl0Nt0aYsD7ZKDE5ZIbMFhIP8MF10X7gKOcVDA4VWJS9nzd/m2bRIDho0pPNksBhFyVOhYEijVTjo5IdyRxDUJH/ZbQEOxvj8B8HfxaZJnOEjKMUDfL70fdTwQ9BC0YFrR919eIRtH5BIh2SS/quY+W7xVZ0gCpwkgDjHf4bnBU14hVLqVuywQODmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnm2Bqonic8jWRrzWvtOw7SGJkMZH41hMdlNuPSB5gs=;
 b=ZGHBPv596zEp2+CQ3t/PkXdddiFiXJW8Z2SJP0GGYhLirwsWXE0vYGIoJsQh55+vD8FDve1btgjCDLzC0RBADJ83o7woSo+Xf05pO1C5ZMlsNabOXVPuTBQcUtIsRB5t1yFHaPvlawIbQEywzW9xUhriQuG7agWThFPipYaSSTw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6464.namprd04.prod.outlook.com (2603:10b6:208:1aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:23:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:23:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Dave Chinner <david@fromorbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmoe5dgRHtRR0OXY/Wz2q6J+g==
Date:   Mon, 7 Mar 2022 16:23:46 +0000
Message-ID: <PH0PR04MB74165C10E988676726E5EDA59B089@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <e2aeff43-a8e6-e160-1b35-1a2c1b32e443@opensource.wdc.com>
 <YiYoVmQE54mVFzHL@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7eb40bb-dd34-46a2-e421-08da0056db1e
x-ms-traffictypediagnostic: MN2PR04MB6464:EE_
x-microsoft-antispam-prvs: <MN2PR04MB64648255FC4B9B3E126A16369B089@MN2PR04MB6464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqRGRv90iCejocRduxO+4K3Vjtyqi/6NEujtLS2OB4bCvSzNnzBT53BODsRR6PpTyibybMcRnj8A40j1lg+ep8ORvUYonXaKSYKsSbmH2qcZ1WdB8FNOip/bxt1dpqKKGGgkbYTIytTkIOGO9YEAKsw+ghBIhnfrsnACNPIIHEBC/Kg88Wg470kAX2S6JUU8U04vsmD7z22izk9pyG8LAGzqYkARl5NPRSW1HCWH+S0Ra/Ok28i9rQ69NALfhOhyysEFCVD2MxgaqFxifb1LGE45pc1MYPi9TAHNdbqOehl3oLdpwiKUkhbEVkXbYadkO29D3/bz1NmglwovzvMtxllHq37OMOhcKuh7B5burKNMlwfp8tfXW/oxgPQ0+F3eW7Gdl/UutEhJ3k8DDzT3RbjnV2C6khuxoKVgCFjiXmJ6WVb1I4E5ZbSCLuVwXKwdqyzl8F154DcwiYxwKGJcVg+Z/bGAjsRtazcmNc6rjK++s/4ssEcQvkiX1rSKa23YXvaBw0l7L2xuamOYM2YFGWFy1Pew33kDGWehTdAgjAoFi1AQgBr7BRFAEH2xJpbpF9d//SgkPjmZc+RCbz2r6rYclhx6sAnAcxmvPY8uABDsSS0mMhg1CtrB2qviR2+/IXKGcEB+h4fkrv+S/Ip6rZzHlSBV8Irtb2Pa8/DRRGEJP/6eFYrOTBgFgvpVSR5sjvG+5CBwvH89D2HPELWyMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(82960400001)(33656002)(86362001)(38100700002)(2906002)(122000001)(7416002)(5660300002)(52536014)(8936002)(508600001)(83380400001)(53546011)(9686003)(7696005)(6506007)(55016003)(316002)(54906003)(8676002)(110136005)(71200400001)(4326008)(66946007)(64756008)(66556008)(66446008)(66476007)(76116006)(91956017)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6y4LSLnG70uagzx8SvNrNLWnS7lz5f64d8RGWffHRNQd3rZQ+KoCdwxUdn?=
 =?iso-8859-1?Q?dnuQtXVsyWu7a2Dc0Fa+ClFeTHGGiFFU+t8rRIanWGFKJMiGtNPC+j7gHG?=
 =?iso-8859-1?Q?44rIpOFfrnHhszOthTYFZ7h++GgldK/vdChSdc0n9tSzg/Awcq4xdlzuNO?=
 =?iso-8859-1?Q?ORIJ9gg+5e/HlUALq2etQNUXD8cl3jum7EGJ3LZ2GVDtqGW4n06OUF0fh/?=
 =?iso-8859-1?Q?cm0OGm8NlaABEB5ku2iYyhYyI6tDSq2iE306rl623uxJOJSQucs7X+06dG?=
 =?iso-8859-1?Q?v2TL19csM0aMBLUM2rwTcuUEXP0bp5zkCDjSPu3wLcDKx1jCMFAsfpHtQO?=
 =?iso-8859-1?Q?oKRE1CwfyWdH0Guq+S8RxHhet26bgU+r3ZhnMCGHuUULkdPKMPL+a8YnyC?=
 =?iso-8859-1?Q?yKbhAfQ3NYgmRv6BWh2ecXg/vS+aPEs6IqghLvRDpFPUO7M4LPrNHZprHB?=
 =?iso-8859-1?Q?qUfmjRbdQPAgk9vQZAyU1hFNnD3F314Aj7VK+YfuQlxbt0h2G2NqnY8l8T?=
 =?iso-8859-1?Q?5ssVw1/E2creuQgmvKusQyH0ZmTKym5zW43PGzDsef2MA8dq3o4m7PzQvp?=
 =?iso-8859-1?Q?9kYuIeDt7SqCJYDGYumRPdDHajKcPoNXfF/WtCXNwQAA3B/ZFV2kVda7T1?=
 =?iso-8859-1?Q?3Q46NCsMRon5hPFXtry4CG1coj7ytNRmfMIbMDjQqKGuCLlrywXEceb3Lm?=
 =?iso-8859-1?Q?58NyVcdEv95Zqjy0cKigjTUZ+nP7g7NvYxue77IoRF9pUxk+4s+xG097kz?=
 =?iso-8859-1?Q?WDLrg+wy2P/y3CW+YsLXuHNPsPR01UDJhGRTPsEIEa0K5MJYE/02bM05Gj?=
 =?iso-8859-1?Q?SoskGcu3ndkytcLA7lc9adzlGIt7v6mr5qyxIYUarwrOHnM6Uc57IIHyMN?=
 =?iso-8859-1?Q?64sfrA+K7DzciBBO3AwWmkDRFYoMFVEaPOldiLmhbppPHAzTR94TumaIZi?=
 =?iso-8859-1?Q?kEH8zT3kQSLqYUHL1wRBzP2ZHYelTxs04i2f4LvcjxdrmqTeNZtpllG+K0?=
 =?iso-8859-1?Q?KO1U13TD2o+ODBTeWpGxRld7zfNqYhYGlyDaTs+0QJv4hfWO3NaYwz43wz?=
 =?iso-8859-1?Q?9T96i67uHKNfAVI+vAMNapwNhirLG3Ujsjxq2KK/MPsz/zUDxT2kPnQHuK?=
 =?iso-8859-1?Q?2IdreldaCSGzEf9DlcLluKWt8KG2BZOmJonlVcoIwqfS+5GnkcMN/QeHcj?=
 =?iso-8859-1?Q?5D6xuDxWKSMvT5h/gTPYuVOEZpZs6Vg6jhbA813ktPrwDw8MCLr19+N2zA?=
 =?iso-8859-1?Q?SpThtfozsmpmATrgGhCcNTlln7TEK7BnEA0+LK7UgHeVW1LGrncixMNCMc?=
 =?iso-8859-1?Q?d2GXeG7pMK+A9yO8faBaPCjdrgrCsbbXykvUR8zyKh+HKFgB86MjPCbHh7?=
 =?iso-8859-1?Q?9vz+wPflEHDbYiA+9HeaxyDKfNLpjGVqjC+nbQCPjj+WnlcwqkWjSIQud3?=
 =?iso-8859-1?Q?yZublDClCU7LukXmVM3ij8rEbbf8403f2wG2b+n1/N2pcm0EV1HSIbL18t?=
 =?iso-8859-1?Q?4QDeWqqNfcTeJfDtgSY5QWNJwVkSjLD7JLg66LOTTOiGo2qnJWSpgB4nUk?=
 =?iso-8859-1?Q?okIj9i06QHARz1H9InesEBz62DkToYdmklHj8Vwl2OnxL/qYmltm0M2Olp?=
 =?iso-8859-1?Q?CzQaU5CGtwN33PWuJEwhlKRJWmTW/BOgrDlqbiqqmoUeHLRloDaJiNxvwy?=
 =?iso-8859-1?Q?N34SgBwZh9wgUEAtwh3GjFE4Acu08Tj65wD0UCMn+wZXC8gobPGwLsrsv2?=
 =?iso-8859-1?Q?LHDHCBoWch889RGIu6amBCwcek+d9eg3rMsRD3osvpo6XKJqahaiVKhYt5?=
 =?iso-8859-1?Q?EKiyqv5TGSd+N0jn6AhcbCpno39COeE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7eb40bb-dd34-46a2-e421-08da0056db1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 16:23:46.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oc4/c+tJMjFKLAx4hRizLAaliEDlHpcxG9XTTn5X0afvJC3r9O4rxFg1LpHwUc9ZOCDavxxfrOtz4/pyDnUqjbJW/DyD01D/Nu8NVT0Tg84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6464
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/03/2022 16:44, Luis Chamberlain wrote:=0A=
> On Mon, Mar 07, 2022 at 08:56:30AM +0900, Damien Le Moal wrote:=0A=
>> btrfs maps zones to block groups and the sectors between zone capacity=
=0A=
>> and zone size are marked as unusable. The report above is not showing=0A=
>> that. The coding is correct though. The block allocation will not be=0A=
>> attempted beyond zone capacity.=0A=
> =0A=
> That does not explain or justify why zone size was used instead of zone=
=0A=
> capacity. Using the zones size gives an incorrect inflated sense of actua=
l=0A=
> capacity, and users / userspace applications can easily missuse that.=0A=
> =0A=
> Should other filesystems follow this logic as well? If so why?=0A=
>=0A=
=0A=
The justification is, when btrfs zoned support was implemented there was no=
 =0A=
zone capacity. This started with zns and thus btrfs' knowledge of =0A=
zone_capacity came with it's zns support. So instead of playing the blame=
=0A=
game for whatever reason I don't want to know, you could have reported the=
=0A=
bug or fixed it yourself.=0A=
=0A=
It's not that Naohiro, Damien or I aren't following bug reports of zoned bt=
rfs=0A=
on the mailing lists.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
