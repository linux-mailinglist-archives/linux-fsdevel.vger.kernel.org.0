Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E114E28EDDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgJOHpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:45:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60993 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJOHpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602748747; x=1634284747;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=24r6PJUDJQYAZ9lVcHNjQriNGFZaW6ErUsDTFdiheC4=;
  b=QtqIXWKuqGpMYkenZWwi/wys8LcdP13HNHoOOnNJMbpfb9omj8acgjVP
   E5ETfMf+1a5I70Px+1364dyvinTsk3+ckvom5Ray7VgxFuHr7BOeyvBok
   deJyFV6cePJE+hTapYN1UpNfqbB/JpyQ9JhEqpWoWAiY2MHCQPdNJu+4+
   GCFWoWYoYt19Rkk2jtJg8K2WnRTKk1VNC9HY80f/WqXjE09Q/Cg4mNI6I
   FX0t8BdkvgxV+F6gB7bTVdyXPd0fOIOl+JPIEeNmbzTWkMuwgo5CqDqi3
   pJxDvY7k+FToqesPovptdXlE767Jb+H1iS5eleeZYCUZBBsB6lAD5Pej1
   w==;
IronPort-SDR: dZLTwlhBhhqYmlMYVOgCOfIOiKbB1ly+wnNJxgIk3ad3rWewA0lax9fbhVofWqMpVKXMM8nvya
 s4xAH1/FK+BmbN0CSZ7B775cFpeXC/mJct6WvAo7OksAT27hIGKu+A22zNIZhdXCUBt0ZK5LRN
 BnKd5fiV6CnmCRNZirYUjWxfHDovYJIwQUV+ITUltP+Rc2Q+RhQkWQ/g9pRz4Ps5didVEfUoUK
 LzDE5Ny5dC4ACClpBdMuskJZw2vuIU3bl/naTrLsCCRp0wrR2903fGigu/S4i/m30WAIchuxvt
 1R8=
X-IronPort-AV: E=Sophos;i="5.77,378,1596470400"; 
   d="scan'208";a="253410435"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2020 15:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnSS8qiDwxcRaLUrzG6xq7vCP4XFa+kK73Oiow50NwbIVRIHLVG9O2h8+qWurnHxmsP1PbzwoQZtme7cMrHVnbZgt0qlcUIznoMmMXPEd/X1nS1WVw57zbNtdYrUbg2vdCM7eBon2fRlWNnZ2FnXlLYZwukHaSJB3BHmUCde7QVdPLBqD7bPy4ZmD4irmaStqb+U69M4fs5SleTk/Wo6dWnBU//d6abr4yyNbGvPawBn2XGPc3PnMRZqR2hJe4GJdu9dMNRywfCzGd7Yfs8R3xtfAFnyskaG6qXLtugwJOUvcqNGRy+dcAszm/Ro4YQ/BU2y9iq99aBfFaKISRgS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtY2/LidgOGa+Gx2LJxRDSkZHfbBLHjd2yRk6uDjjvI=;
 b=oT96yl+t8xJmyaOJRx7V+IUrgzYdNWaMIzPl7evh/958dPeVlKOEXLasUSSdyCHcDmD3uHU5Hm2E6XaMJOnS7hcz7zAOUyFuaW15pRQ8Nv5y55BjLBy//7Kh9s0W9aLHKBjqbjKe2QTJCvXNB8F4IPL/4djok9WclXmCgW14EkdhfoqP+j6oUWzfqdvE0qEMEJ1aLzjf9oCbJLJkIkEwqlNkzEZHKeAudLEWciOMcbzuNJoJVXMb/yPxyxJTXZu5AMbxGGIszw5psNc2dibrjznMWeDsKxgvMMxIR6nHO1QzDsrzIkomeRBzRZxdLxxc+L1DXk1u4pmYb/zFvd5SDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtY2/LidgOGa+Gx2LJxRDSkZHfbBLHjd2yRk6uDjjvI=;
 b=CHHV/uyQBBPjqqXn09Zx/gnlOO2Uz+Jq940J6XvbUFm47hLJol+wSxZn+5MhjEHClNIi9kXfhQ420LGcfdlRqmsG7q0zN4byuu4suEm0W7lr+cZebFTaXG+lKG0sH4jthD0vZfK2RNChtWQR2vaoHi2tdDVX5X8VREBqHwTMPqQ=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB3948.namprd04.prod.outlook.com (2603:10b6:5:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 15 Oct
 2020 07:45:31 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3455.030; Thu, 15 Oct 2020
 07:45:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v8 03/41] btrfs: Get zone information of zoned block
 devices
Thread-Topic: [PATCH v8 03/41] btrfs: Get zone information of zoned block
 devices
Thread-Index: AQHWmuaeJDKMOB9LSUer+b2KN1Je6w==
Date:   Thu, 15 Oct 2020 07:45:30 +0000
Message-ID: <DM5PR0401MB3591567D922E2F5E4113D27A9B020@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <dd872ec3ab449a3a97c7a3843aafe15b10154a3f.1601574234.git.naohiro.aota@wdc.com>
 <20201013155301.GE6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cef8ee51-76e1-440a-1f47-08d870de4a9f
x-ms-traffictypediagnostic: DM6PR04MB3948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB39487BB41161D15AB39C14809B020@DM6PR04MB3948.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5gDidoz/F1o5aJzZl5P846h1ollf6zMB+MmLLyg4HhBBl1dk5yl1FyvjsojmLHpN+cDymFdJczuPzA/oggzj5L/EAhe3WG5CEpojrsUK5PKN4WtHPAMnXLYOt/7WLnNI4WHM/+63KNvTV5rXGZJEDfnYhbP/EF0UzC6dTF2wiUZMC60We4uLIEhOePd+Uw+kjgyoxjLTJShoQ/xH95HK19VJocmDQJoNfxS/Gvbvz67OvrxolfQ1ATmp7QfRJmoyyqGFOJfQWCFuAeiCwE8c+mikwPE5O7D4L5KiPKiROYvao2NVTok2TtWu+ujDvxG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(4744005)(86362001)(33656002)(91956017)(4326008)(6506007)(66556008)(66446008)(8676002)(64756008)(5660300002)(186003)(76116006)(66476007)(52536014)(71200400001)(66946007)(8936002)(478600001)(6636002)(9686003)(7696005)(53546011)(110136005)(26005)(55016002)(316002)(2906002)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 86MnPf23IrLZNW1omA7+uGal3/wvOGoMTpzMxRcx55EXrNlC/rhM1yYeJH+AuP2wtKB/1fJ92FH1Of+t0oh6GRRcVozjgvElS7YViSMJI6Ks+kBb0NKcqt6n/9mKZ8Wkkvkf8dQX8413CM99J9SJMkpqFc/DRsdcOfXMgt9HqgpR/K7OMOEBdy+1MPWLio9AYBs1nZbU5x42G7bsmtcie/XRM6x2D2HtHZLCgC4obuFl4Nw0Dx//A4qd3nTZ7VMo8C+R3uMUw29FQLaQfzCYF7YghD+7P/0zkbXXoUL34nqk61TVAUSB8Xf2HZxYchJIIxXPNWdYwhWDEZwlefGqX7SbuV0OeV9M/NRPE7HS89c5bcRUeLA63BqFLy8dILxXBTjOLg4AEtxsep9HRxTQQxOlSfw/euWtrHaeCTkAzUAHvu4uXBY+ss8LsUpLY5NrBYuQeO8VvUT2YpwYhR9yuPxiBqbzPRvnp7mcci8bG5JsuzhvWKwEXsa1DpdQtXnEvyXC7G8bFThOTw9uHbgQZV2o/lCtpJwSKMrYU17ioT3HoXSKO1WJ2ISbqvQkAJMZROyaYnQstTDRyCjh9kpFqTG+k7d4cEwujV20TBZ7S08NTnmepqvKwfEtrqYoI0joazKHRCk+oI6UAJoM5oSqzw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef8ee51-76e1-440a-1f47-08d870de4a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 07:45:30.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzqtaEuTYKAFDxBy9iPyMuz02i9zfnAgvYwViigIcRgqQZreSZWPb+xAtJATAuyDaAbedUatHhMcyletIuN9z/tkDGE9dr4+NI0gAQ90fus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3948
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2020 17:54, David Sterba wrote:=0A=
> On Fri, Oct 02, 2020 at 03:36:10AM +0900, Naohiro Aota wrote:=0A=
>> --- a/fs/btrfs/Makefile=0A=
>> +++ b/fs/btrfs/Makefile=0A=
>> @@ -16,6 +16,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.=
o root-tree.o dir-item.o \=0A=
>>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o=0A=
>>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) +=3D check-integrity.o=0A=
>>  btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) +=3D ref-verify.o=0A=
>> +btrfs-$(CONFIG_BLK_DEV_ZONED) +=3D zoned.o=0A=
> =0A=
> As this is conditionally built in, it should be also added to the string=
=0A=
> printed by btrfs_print_mod_info and we want the actual status so=0A=
> =0A=
> #ifdef CONFIG_BLK_DEV_ZONED=0A=
> 	", zoned=3Dyes"=0A=
> #else=0A=
> 	", zoned=3Dno"=0A=
> #endif=0A=
> =0A=
=0A=
done=0A=
