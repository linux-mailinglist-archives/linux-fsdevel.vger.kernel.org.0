Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B512E31D360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBQATr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:19:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47310 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhBQAS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613521137; x=1645057137;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JARFtW2gQ0t1I4u2YPrhOXbXNOZ8zO9QSN9A/2Z5+UM=;
  b=M+IfgATVk21PfKQffn42v/ZTfnf0FjC7Ve4zzIyBkK7PEW+C0hCdp8s5
   eUw0uznwFVbYmhm6RnkWgT3OdH/O229rqTJiOWEpytfpoL7yJbRfIVWT7
   mH52Q0y/dC8iXY5bXRe+4JGjx/uGxgoCqRO7c+AlN10N7vyO37eWlV6k2
   0kZjuPMre84oz/MX0BzBL17zvu9XB6iujCfdvVcHxwlRegBWkhpGLHwcg
   WE0+l593Uh5Rhjc27WHfhe/NENNaj/zWNNXdFlMSeQktkJMsA1cTeQ5yv
   RNX75GQCVO9vswFncQnaVeND1ms4OqYKMnU23sF0CYGGAypbbO7LHDM3l
   A==;
IronPort-SDR: h8WNExfOdSNPpIKKhf+ixoXnlWAnykt6XRkoMF9QVVd2hxGD8p2NIQyBBOhbeIPQn1HJ0YVjYO
 r9VZaQOm4tB1TosAgo7LCwYKkYdEWhDyexEEbufGLBS8o7DYSQUjwkhsOOqH9uTDTDMEW3qjKk
 vzU/osrsnsgWTMQkHWfKTw3cJ4BiV1fh+oVs5TjUORvWq4tnXX4wzITNoYCghfAoQeAZxaPBcP
 qAa3Aa29sk4mb5H9zhRMua/YwMMT8wYF+6TogRXIL1SRL//fwutU2AhJvB6JZVITnqEudGiA/z
 FIc=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="160099177"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:17:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLtLP6Af0fsqeXzpj+3hjzMK4r0zUaXYIWZXImtjSupg+EYun20R8AfdR2dhsq+hOggIFt2YzKHJXfVsk2EbPpUNt9pKZt473IL4zFhneW0Qy/ETDHrI97noGeNF5wgXrRJKSzaOG5hN8y8Jhczso0OowNyxG1SprXnX5qsf6Ds/BaY5YsX3u0mJG99lZR4KEYc+NgUxRXq0QeNC2hKKSOezaIH/p0vR7U6V2kh2pMPLGapIpYSsJ9Zv4IxoB2qbOmbsqlCmN7cwgmw1fWx4+A3wcHlOUrynHa3Ub5II0oL8NIqZjKWWJvEqAANoPmrfXUAflJT/MPRQqAvrEpHEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JARFtW2gQ0t1I4u2YPrhOXbXNOZ8zO9QSN9A/2Z5+UM=;
 b=CCgsMVCUj25O7kAIu5uDuFMZKDdaeiRyctahbVE3r4kJ5hl9R0wxY+rRxEVJ/0z+0vaL8smZWJrovNiFXEQOCHXw1T4XZIkrkGMFByajoGAXibRLO0L2LsrpJsD/xxj0PcMRLs8qkxjSugB3HDovBgCQHG/gks3Ed02gjFdfFRskqjp5/jWrO9A2R68iZbFfDUUE0bDEACBnmazz6QH20pJxJ6xUh+LRy/YqJJ8bFfj8rMlvd+NCgiPRQa8eNMBduxOg5LQe/BwpCm2s4W96nqbQbpQ03r7LIRHqpkeDQuUwE2sNxCQFH2EI5kTkhJZFxQhvoBqNHAoZqBorw1mMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JARFtW2gQ0t1I4u2YPrhOXbXNOZ8zO9QSN9A/2Z5+UM=;
 b=bhPV3Ow2Oxh4UTWMmk2OGtYNWImtSvYzqrGh0ZDpmepqCI5NY1MHeMVv4o2nL7/Cky4uhYZU1Fmys4IOFOoazSPNfywL8mmq1UPUsOoJ3Tc9s01PcHhsNvLSlbcbjCC3pal4gaB274wvYHA9PhibI/bLbPx/d5+Hz/o6ZK9LqXE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Wed, 17 Feb
 2021 00:17:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 00:17:47 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hyeongseok Kim <hyeongseok@gmail.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] exfat: add initial ioctl function
Thread-Topic: [PATCH v2 1/2] exfat: add initial ioctl function
Thread-Index: AQHXBLQ3E7G2/hieYkujh2Rjf/9pjQ==
Date:   Wed, 17 Feb 2021 00:17:47 +0000
Message-ID: <BYAPR04MB4965E80E52DA1E8D90F4736886869@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-2-hyeongseok@gmail.com>
 <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c186df93-a6b8-2cd5-8710-077382574b83@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31a69f84-24f2-4577-73a8-08d8d2d97429
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB55266CEF2909CCB7DDBABB0D86869@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKLgTflpK9W4uclEOjyTpfJrsU53f7MYI6JaMtq0Cv4t4ONLK0+8DoOKrWuWLmXW947Yde740KNTkolfBmQDa8/0XooEHW532Qa0i/NKGchXyrRkoKy7VG7IqfkPq4ZQroUT4rKtS2am4VuTPB+TMJEqp55/fIoxPeMiAZgPyEHq24DXglR97VAl5iCOfRVN0VsyoHlSYuy4G/Q1+XB6hs+uEA9NKCD4DT6I5UfVgSZNOqDlg5mmYFhg7QZ8BIEQEd//yhnG2w1F1NZGNb8B17DHrlBIjwac5eCf1JtHvubScAosciXYsXv0K8AHSWMd0HteSnb48xDVldpwQ8EfNWPczWmGQXrBCAOvplE2UA6L35urI5AD87+mUqWyJoiJmt8vSM5h6Kp4Id68H9uAf2au//UFnt/h0BPFvtaIiHtsIB5YUx5C61TMJUuroulCSbbD++poW+8HtIxLFxbDoViteS05TClD9KiuXoFiQOrmhoPllLNF1OkwjDHC4e1CwqJE2ZvLCN4l5EEENKsCNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(66946007)(66446008)(186003)(64756008)(9686003)(66556008)(66476007)(76116006)(2906002)(316002)(52536014)(55016002)(7696005)(26005)(8936002)(71200400001)(86362001)(33656002)(4326008)(478600001)(53546011)(110136005)(54906003)(6506007)(8676002)(5660300002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/KDWDlhZ+okActHfRTliy0GXnBKt6VQtA3snS+na2S8Jj1bnaztISZ4qzRES?=
 =?us-ascii?Q?D+qzfByb3ZapKP5VS6eMTHnPZVyu8aLNyqJnt64y+DtVvJ9MnTo2+JVXL8W4?=
 =?us-ascii?Q?UbZWHoCFimSsImAOWDYhutEOrpz4KPNnM0rrZegV1X9ETy67AK97T/pJwTgs?=
 =?us-ascii?Q?1RVL3mcPJngA7ko6VHbKQBEkMGjead3CLRgJYe97+fRXACjhMRHgLxTddvS9?=
 =?us-ascii?Q?eTJJNmirTsEqcqeSXg+9s7fEgWsFntz2D1ptm25iOqqQ7lo9F2f0fttyOKw+?=
 =?us-ascii?Q?uJLawKZNqBwz4D0cCwo1RW1nmtr+aw2/MaXw2Kvwc/cz014alcPTDQENul+l?=
 =?us-ascii?Q?P6KEArK6xLD2rUy1WYCd18DH5/F1mQorjzp8dCyIE9nYpUwJ6NfczHlntDeY?=
 =?us-ascii?Q?H8eclVsI3K1eeH7COWJW1m/tWxZ1kPVMyHS2NfY3Ij+9q+xICc4LDQdD0OHl?=
 =?us-ascii?Q?0reflSpFLStS8iBbEBXwJdRZp5p6fh+2FCti0eR+GAcONAIjmmXXtGdaB8Mx?=
 =?us-ascii?Q?p+niBajp+WNtCNnhDqfkQscY0KLuImDSCQvJi4XTGvhIspwPj/yCL5BUavAL?=
 =?us-ascii?Q?3Z6ARzI9EB+E/mWXaDw/60Y+9m0JPhSV7Ek6z9qxE1VWcUUZmLXee63IT+CW?=
 =?us-ascii?Q?csL4ZL53ntfOAk0RFk1SgfK8mKVFsF4DY5/ZCnY1bXgx+kE76RY8UfXnS9ps?=
 =?us-ascii?Q?AFHwlEodSsxbIWF1DVvle+mmgKS8Le995BAs3iBi77Z2fIA3ftYn1CdfQj+6?=
 =?us-ascii?Q?tFGRS66Xi9+6rkraVi1xN5mrDo4vo6WfqULo4rCfDa+2O93Eiqi/56X2QajY?=
 =?us-ascii?Q?KioAQPR4jKW1IycjuqSTl6oQsZbNaiPVdpL+wmD8mM5Zj9tMh1X2OY5W3mLN?=
 =?us-ascii?Q?8H0w1wzANIUCwejmhF55bohC+J+PMXAkXrNSzvDmWMyBt8/dV3nc4evX2WLn?=
 =?us-ascii?Q?D66JH/wCMIkhF+Lg49X8WlV4NzIAlxR5Pc3KIBCdVEGnbCioIYISZjjcG9FD?=
 =?us-ascii?Q?6TnCG9RxP05NIMAoE3mI5ya77G1cVySkZXVvYJYm/0/si+FYsg28psRbZAgp?=
 =?us-ascii?Q?gBiH7sqGhxRqq4Yzs55M1EN+jZMAHxgDSi0WOVrPmSE6Nn6GKqgZVJVtKSgU?=
 =?us-ascii?Q?wZkZuZyu2IZof4dcw3jAYTxUKje2/fZ+o3YHEcfhtYvgf1HbQFldFAmDKfQf?=
 =?us-ascii?Q?zLCQl+FmfI9IWoWNO9jrrbPebrpHoVFY5O1M+aEFRzkxo6xITB8ETVOsVeo9?=
 =?us-ascii?Q?EbPhc+hkEASoozoQHPZDOFFif0tx4e9LyWNeEXI6dgTpPAUf/Cw2OFVvqhOH?=
 =?us-ascii?Q?wFj5Xm3yx0u0QGDy+Elujc4U?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a69f84-24f2-4577-73a8-08d8d2d97429
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 00:17:47.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaKrULDMZiD3g6GTXiL6G2yV0MgqrDzvpHaGaNe0q/L8BfDFx1l+udYLhDmaR8yaYEI+TnQWp0xQcTLAtFYhBB5hv+Qu2P2EU/mdsYago9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/21 16:13, Hyeongseok Kim wrote:=0A=
> Sorry, I don't understand exactly.=0A=
> You're saying that these 2 patch should be merged to a single patch?=0A=
> Would it be better?=0A=
I think so unless there is a specific reason for this to keep it isolated.=
=0A=
