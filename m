Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042A2309C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgG1MP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:15:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49816 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1MP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595938556; x=1627474556;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qqnuwUkhj5XeGXEZcbHvOV/wszL4groR6zxEFAjxd6NcpQKyRHhst1uE
   fzXscWbdCxfVLIbakzV0r/ThhRG1sFSMgeS0D5YRx3YIEx76dIxSKBSTp
   BHPoW7EcAHdeIhFmL9OGxsy1x3s5JYYCf1e9t9FgXwCIXM5Lmeel8k0DA
   h/1z7wTNwZMseCcUVOCB9NdhpRVBzA5OoRy75mVmDTMAMbTxVe5fjkQRz
   uhHwaUJAY4zrGXsIRvp2DzZzUFdkNwOwel5R4gCWxhbfY5t83H2Si9e1h
   Mim9J+lMl1wKYNKPbsfztVSjUmYLABz7Xs2Ot+0tzWWqln0FxAtPWMcQz
   g==;
IronPort-SDR: DQ89LqcNqS6hIg5IfjIwlVPJXYWvuLtTpczt793f7BZT9yHddHwdf4R8g3qO/ccI+yXDskvu3T
 FkdKxlU3j9ndgrTehFy0Fu/xLUMJITZnD/VlCqbnuslTy3qmjQpltov52ep0ETerW175Gc+JJ1
 tfkwD5JlnDOW3OWrKhpRa8dmiSL99uSiTL6afC7vrTpEi+C9lwlbveqguRJXG217oEGwmvDQAT
 bZ7xG/u0jQrixWvuhMfvvZNH+L5wgKVsF7FiMnpD5yT3dhjV3yamCPb4Df2c3niYGOZ5PnQl0M
 WKI=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="147859580"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:15:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyzX8lTGp1jClVmFyr7KNg19MAU4A9vf1FOaC0WecS9uIcxyWEhQMfYYsMm/sSIeZTxJPxSELYSMdKO5vkJniV7vzYAE1JgGEo3nBm9kgKS1MSzkkWF67baZJUumFQb7G9KL0zbVWN/rfTAzOzJ2qm+wfqjgERD2ZJl4fQfj6/gT1ybJtKtTtsFHTqX9qpE0TuDUvmqXoi1zN75F9oqnPahn3dQt3fzD9FnW2d7BC0P1MhJDvP0doqilMvEPcTbInRBwQp6IpS7IoUJubymaVOOURiDaL/ZhYiYzMTaUS/LI6TVtmAKhmYE6OijoAFDvt6s1P581QAADdRVMS1w/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TNwAkjVxcrfGjojuKfMExShIqjo4HWFNcdafUePP9Ju8fwVlowfIq1zQvahOsV2EJ9x8sSRI5EcX8G7UdbLrU1eQ0bBPHtSLDvRDsN9twjINSNDJ6Cn+/wQs27vtcYxotHBaYTgvP6LfgIK/Kj+BJQErqAkGy3fmsjI/uyZstzYtQSi6e30nbweeNMg9Ep7YTZvb8yGnzAKGCPx19MYp0dyrZBBTRqDbl1x8yyObzmgP1dqFGXMYuxgIiib8fxIzOGFIOjmTSM3G0okPTHNs4qFl0htpFS0ZmhSxj9Gnydg7TVGLnycuSQbx+eM6KVz0ObkK8weebDh8i5ZiWm2PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tIOK7ueSH5DJwXOqwARPUiTahzpVsXyl/1RWj+14QL3pzTxu4BPLZlr3G/Q+MgEEvAzNVK+zeveMp1mwXv0Ei59sAcPers8B5dGX2+s5p+pp86oFafxyUUcHKhkzE6kspdrE3nojiQHFLRy7ky/yvdvL8crtFTQAQwAM4mxn/X0=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5867.namprd04.prod.outlook.com (2603:10b6:5:16d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 12:15:53 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:15:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
Thread-Topic: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
Thread-Index: AQHWYYz0cBIiuUymiUC2H4EgOD1fxQ==
Date:   Tue, 28 Jul 2020 12:15:53 +0000
Message-ID: <DM5PR0401MB35912432EB080E02FB3AF7139B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aec02afb-8046-46ce-f7ff-08d832eff96d
x-ms-traffictypediagnostic: DM6PR04MB5867:
x-microsoft-antispam-prvs: <DM6PR04MB586751929C92D24ACD96C8619B730@DM6PR04MB5867.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ss/J8/A0fOeIHByKJ9vsCN5Bs5sYq/pLcoOX0d+4R2lAfZ7Z3o5yiWWSL/CNMLFc8MAU8/KR45qmwrJ/PwNTxBWv7rgxvF10Z3EI+qhYE1MpdXoRzrmZxrpNdH3BKZ+7CJhAFygbEo9n2F/5Un+YScGX1AKuGOfchxPvfCT1btduDMS4uCUuUod4RwwCoB8mMDLpddTcLuFx4RsiB4l2K/gwZp0rUKRkb9TA4ffsZZlFWTLXigHpA++OUJCNoJ/lmIzZMQ3l1yaOYs7BNtnAS7hznblLw1sp/Plf2z0GlKOlVdtR1s8GuA3JAaHdGTHQOZ2BPqPPwMKCBbEFnHEkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(86362001)(2906002)(54906003)(66946007)(66556008)(66476007)(91956017)(76116006)(6506007)(33656002)(186003)(71200400001)(110136005)(66446008)(64756008)(26005)(316002)(558084003)(19618925003)(7696005)(55016002)(52536014)(4326008)(8936002)(8676002)(4270600006)(478600001)(9686003)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nt4FLhI3Cp4f77Vmu/5FucvBoZG4GEtRl5uammbP0zfFKHk2IJxg6rTOSnEGRYEaf+Of4+UFnr2ufqWmJlWdP/OyjtObVM5nyTAcKZG/3Xf07kuq1dzx/+1ny/jt/Sn+Upg2lQ67fIULxJ9xs6/UGvYk9q/k90BijXWto2B31AmXkzagkxHGkNkBhv8pmEO0LzDWNsNZ5+ziqMUAUG9HzihmYKHM49BOTsePgBVHIsoM1cQy1P3JgM4n8McCwwVnBCAFTyW/0SIa0mnlhpZWC7FhpVBTRWlEizLAgkfUgxBpSOTKD4axvJA5JaK+IRdjnBru0ngr3kwDSzudkl7uWzRBLyZdgBNr7pypLLtDsyg3LJOOlT0gTMQ7t48wOCqEcDVdUboR0urnmMYCMHJBXRVJfX6T76SCRZvF1sVg2XPXzHYP5C9Ayqu162wmwsC8tN7gDD2obtkaE+FS18rIsEAHwDX6uz4uPrjSUOJV+ygyzqZD/wN/sZCEX954QuSy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec02afb-8046-46ce-f7ff-08d832eff96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:15:53.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pu0ZdkEQACpwwgqAO/MtVb87qVCsSDPULKY74Njyt0B3bGaCKaa25dG1sV/YiRnq0xliy59YnI+KN7F37kx7UlPQCvOH9aYBZ753qhunjJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5867
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
