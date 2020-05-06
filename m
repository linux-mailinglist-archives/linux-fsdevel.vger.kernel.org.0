Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222DC1C6BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 10:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgEFIat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 04:30:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15003 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgEFIas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 04:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588753848; x=1620289848;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7yMtI+CGsMn2YEP12PUn8wyPWV8T4bHcrqRQaho+IWM=;
  b=bz/BwaLI2HLu7o+hrfZAVB/atJ0oNb5W1xfLG8hhyyCUEr3VVdI+ZLog
   zSSdF/yuTaIaYAx5I4nvLmGw9+lzyKjbwzDP2JUnFU8eOJETdoyDHTyUt
   E9AA80rb1LoMWM1gs7gt4ohXA3vU4L05V63eVt5eb+0gOj+PTzUzCmEMz
   3Ip+PdLESOjbs3wLI9V3cCge332+gtQMY1gSs8xNA/bQGzoJRhyS8tZ4j
   iV8WvUBPiWg4J+Sk4UGt5gBl9x42VL42IHZMEP61zem/bqqcIGReG25J1
   3CUdZGp6uSDMhq/L+ShdPoIbTkgwlYtCvSEM3IUhE74UATq2crUYQgFoR
   w==;
IronPort-SDR: tYPyYdMecbHhsPBM6ZzucEhSLLX5ZDXsRrchUgewIa0S/WyS/llNxy2lZ5bv/LWxUMf96r6uo3
 Vdo/lQoX5P+bCaZsw+WzisErDdRoZtraITMGeQVQOTGvQPB78FFM8PJcLaOR/dIYSBDA5osXG2
 CT5qb45zrTGiniX3avGTcdH0qxZsSZgMglKvRgPlf8cHBKLqtKbcXm56e4w5U7XV+BiD3VaDp8
 r9uljxLCoGxzmHrzKkwz0XEgZdU3ZhTBhYH0canm+TK6gfc69wqcdEvl4FNDf5HXKLGVTsk4d2
 ks0=
X-IronPort-AV: E=Sophos;i="5.73,358,1583164800"; 
   d="scan'208";a="137034794"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 16:30:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoT/LvmUgw3oLiU6zJClo+dGLD2uFp1Im3R13Ug2mLKWjBzVm6ARiYYgYG80C/EGuIV5rCn0xyNnYwbXCkwxQONr0VTS914V4vPhOMh2IedgyIoVTdHLPXUTPSzzeocm4TMdqGlK0IFRh7fM99hb68E/unWJ1pIu3OooVWpTRB2/+4eCbcbWOX43L8l8rJKp/dOFo7/NJ8G60Cw+kxJE+1CiPrhwc07+ofMc0TPVLaOVxhGHhbodxPji01x8DtKjmNDC30Ag2yDJAcP+/FocmX9sH25tqbwjTzcGlRm9PM7mfnkMD0+r/i9Y399CQ/vwGRpZxJSRjfrNMCMcldzFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yMtI+CGsMn2YEP12PUn8wyPWV8T4bHcrqRQaho+IWM=;
 b=X3E3KRQBQ+5tp7Jb4gRC9u3hHfyPgLYXLb5m/kTOmD0dD4P1xZivu+yEGQuUp1aYYzBn7dPA0wMFMXAvxgoJVHs4wkb10gpok9JsYfIF0lEBEYgpgvIJsCNqcnyCQE7cnQGd5Ox/SuYITbZgzLGNuSecUpmXAXxsXIG4Rtl3j2LI1UkPH/s1NexgNn+KU8eSzOE85EDz4vMkhkW7ef/z2k6OaBksNFgolc8ShcEYmffVyPDzQIF3L57LUy856g7O+/Zn+4fFk8oKf7SpTcRsnBeXw7gQRsXSx2ZqIg7EE1UEdA1KL6wIj5CiNDoZFrmJLRQIqJhEyCm6yEyCSgxOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yMtI+CGsMn2YEP12PUn8wyPWV8T4bHcrqRQaho+IWM=;
 b=mZUI3baC2186WoaYYzQ8AQnF1QWI64sb/2ATkkLAwSk657CyLW6OorY4MWLPGWOxTDFo0Cj4CdyJpM4KnhIj+06RDsg2MKa2pPKkIaTfwcaTjLjnRT0koKh2QRAiSkLKpIzpdF9o4tDJemiWsUjqFFXBAVp0KkfuxGE1S5iE9qc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3629.namprd04.prod.outlook.com
 (2603:10b6:803:49::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 08:30:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.027; Wed, 6 May 2020
 08:30:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Wed, 6 May 2020 08:30:46 +0000
Message-ID: <SN4PR0401MB3598CC5E31C02D98198038609BA40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200505223705.GD128280@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ab90a8e-3e82-43f5-2ab3-08d7f197c629
x-ms-traffictypediagnostic: SN4PR0401MB3629:
x-microsoft-antispam-prvs: <SN4PR0401MB3629C173F3433B46D4305BE29BA40@SN4PR0401MB3629.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEVyydf6k1yoGj4atlZqouOm016IOtl7KGVbEj4/73oYByCS4Zld14rncyDMzy16k16Bt28UTag2X5d7/eBXxYPGYQuPQIFXDZULCHkzb5PYNkXrQXi3mGwncJXUXdoXUV12IFp1oGIFTJ+a9XZ5dEgJtAg2BVhYvqV+HV45um9Ct8poZ8J8Qvp1+/OWogE/3dMRtLQYhIHsml6Lw91e0eu7nzgJeY788RlbOTYsBbFpHlaw45+ySeSI1CqRmrkvxq9JjN7v0C6s3MLGegmXstrNNLggS0KQsEzwaLuSp09VN+9HEv9ji2YFpE7/5ZMrBmAi232JhAF89/SmTNQaPUaEClZZlDK+JsIR2Hv9SrShUA8IFGSJjkBc5BZqXDG3Nitb5U6KyOV6qKGh5IPbARykQzgVn9+XH0LFAivc2nGfpBtwkCnXcM9x8HO2YoUZTtuf8MgNXP3lLw0p1e72/AbumzVVQUrZcrCd6I3hpjAv3Go9/6glfOtxsboCx/Lf83IYNL/e8OM3hM+7ZWGDoBeoRzXwa+xyYH/+wDKEmENjKyo9Zsuyfu3vlrYz1mMv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(33430700001)(91956017)(2906002)(316002)(4744005)(54906003)(9686003)(4326008)(33656002)(55016002)(86362001)(8936002)(6916009)(478600001)(66446008)(66476007)(66556008)(33440700001)(8676002)(64756008)(71200400001)(186003)(6506007)(53546011)(7696005)(5660300002)(52536014)(66946007)(26005)(76116006)(387924003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VoLVA/DOaQj77nvfJcHvAVtWTm9hOZRp+NaQFFN062wp4F60EtHISysFzlqh+LjvG1ROD6WxAH03N2Z+/GSCZ7xmJkKK4S1S6EYe6oaxr1aH/2BpvKCmYG3N1If9RKDB8qk47/BfJFAnaPm9lMzrQAXawNg4gmvKqk1AETQV1xujJNAZEF2GXidy+fP8Hahd53Y+BxZlznzJMh6Ha0AAR+yVauzXmEI7ADOPUkKSpd/+0otRjSiqQvlojQwW+hFPCFdFVk6SIWlb4tSA+C138nkdrbZ1DDJ1F4azeSCUHodgh1bpeOQVsJXW2PADaYDdegXX0YviffrD4D32+nmb7E1qCPeJlyl9X1ijT53VZ3DgMgewPuAw2zg6P0JXLJJfMhy2jTTVVvEOXp+tli3jGll6eag4BQ3nyDMyW+GEQ1xpjIe51E12QxpgnUDpkzio5r9OydOVrAYqNb9BlSbMkLZmOZ1Pe9xgRpqOGptQJ3yYvLgul6CiVIErbI66ttYuzGJKlfVG9ZzHeoKhM76I0AsmdTQeP7lkigjLb0mzM/Taiv86oBPoExwwinGO/g4J4Ym/DgjC8yitc8/sZ4FgC+Zn5ddtyP6jY6WMtqSi8D5wTgiJxxO84sN0e/iwohA+FPNbqejkuUkCh8pjzP5/o+6xjOxEqzv0ScEFo59cvd2txwYaZE0DNZ9xz8P6xxQoRdXANEHB2+mwpnVzPm9yaWMd8kvqXXj2f44LvsIkY8rXRILeWXoaQIUGyiOIu67SiFDXuIgHn+dn0BVtbi1Gaao3p8X8/iMbGJ/ZZAlCmVo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab90a8e-3e82-43f5-2ab3-08d7f197c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 08:30:46.2307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmjBeW9hXCe+vVfW96AWPy70FY4zOuycFF9L1dItp+nUctHl5WqnZgw/sAWbtTXzKDuPK0tGclFErlATVDW1A6sS2JvlcB1CWkPIPtw3xnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3629
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/05/2020 00:37, Eric Biggers wrote:=0A=
> They replace the current content of the block device with the content at =
an=0A=
> earlier time.=0A=
=0A=
We could mitigate this (at a later time probably), by writing the super =0A=
block generation into some trusted store like a TPM.=0A=
=0A=
But I think this would need general support from the kernel.=0A=
=0A=
But thanks for showing me this attack, I'll document that this attack =0A=
will still work.=0A=
