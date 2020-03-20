Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9678218D2D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 16:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgCTPZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 11:25:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62864 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgCTPZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584717908; x=1616253908;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QKHYuIkYYUZGtd+91cTk609uosNUP/Xeoce/M0a6Ew94MUgh42pCWg6P
   UiN4mb3IsB2rvfxoppFlLDWmaAI6woDjXvS3mHwpuzeX2HQVa+hpupQ8T
   lyfxRKiZxb9c5BNrjWMtpIQ3H6B2x9Z6WPbSn+rVNijxLF+xhbK66ozgZ
   4uYA8lnLRikm0DScakv9lR1T7T3wSOzwSKrKihI+Y/PdUckECV6plrZ+W
   zYBAy1lWXNzcJa829UPDp1AlXwOBD9jR97wBFKGY/SXKQJm+mhp039ufS
   5RgOwvnSsuPk6/pSBNmyLd15d7iaZOJtxzpTqdSGyIbWrV7wruxZooxOq
   w==;
IronPort-SDR: DM6t/+s4AkAu/VfqRlSWAPl81Cs6VvlFzctR9hR/W//ZLpDQxCcg+xqF4rUOD+hVfchWUYD4I7
 chFy6LJAIoU8zLgbqaeUe+0kZg00URKiToZ+aXJ6F2wu6mYrVJbWSaf5SvDWVHyFcVGXPAbX+F
 FJzwMrm2f5yoV0mimJZlZfkLbdOgzMVLSTNak4WHXaBVMAmhVSzfogC8Hc9fgXpDDH35F/++xD
 2Fbp1A+BgVZV8iuo3OP3IXW8ESqru3w1FQ7WAevBajcsvVETNru99bEs3zZ/LFNnQaciEcnUfp
 /Xw=
X-IronPort-AV: E=Sophos;i="5.72,285,1580745600"; 
   d="scan'208";a="133517830"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2020 23:25:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+OKQ3KUe9O2EatA2n8nMlTxvpFE7jtz0HO7zVg8DzlI9qgh0HT1JTUXHaOHeeAfTCv/8ftDqvU5teFgOrURIYQKnr+ghUsqMMYJ0YWcl1a04pvwJgpmTydQfyY3GaE6HmDFQPfyJ9EYbxs+dVaFl55jRB+lhhsGPgI3oiaX2IRN+p594fFj0lv2hXds1huIMhMKTS4YzjeZO26Hkgq+oVWDarf5U4zF49ud+u2bKQoiIbcljrtc723SAgtAOpBlBeQib72P9CZayU/lBK3aEJjdmQV8ls/lwGC5XIPW0yQtejFGnsNcXeKTs3ads7/x7KeLlcOcA8JBZCa4+Gv5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CvWgETUTMT0C6qrebKOp4i8dG3qzbSbOun53N9GeN9hba4jFiVuvG4K/J3S3B0MBfYTIbzAsLKgJUb2BvSNgvA1D5P4WKE7MPIyavoobtcxGAXz3697di8bYJvciX1PIx7pSdXYogHeA5LMXHXZ/mSW5HG8KEVqGuiaDpmwTIfgctTWskzk8/A9lc3PxZ94u7EjHIEWk524Vx31RIMGw+XWiuUovMcmP3V7JYWfq82/nDKB+u3hU8rllvFGHXzsxPmOxwgLtYsc2HA2n+q+24+fHEyzEdu/iInjrgk1c+k8CNX29X2UxUq8q2kwnJfm0YAgYqOCKuGdV4Op9fzFPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=snpUTRQZellhJCZcJck1uja5pIINkIUXbdozN3ZGm3XB+rtfwnXjVVJ9IsA5qnnynPt0eEhk3SGXWcrxIQsyiukGvepbTck3zQsfdOCkku3Qt8Q8vn4N+EfIx9V2HI84BeKg4xM8EyaVIrS2UZwzhJBJDjmbXPufenOqF5Ll5/g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3535.namprd04.prod.outlook.com
 (2603:10b6:803:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 15:25:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 15:25:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonfs: Fix handling of read-only zones
Thread-Topic: [PATCH] zonfs: Fix handling of read-only zones
Thread-Index: AQHV/rYMKMw/h8+sR0e4aVlmCHUv+w==
Date:   Fri, 20 Mar 2020 15:25:05 +0000
Message-ID: <SN4PR0401MB359857E013B72AF93E26B17D9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200320124948.2212917-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0b5c879-6f64-4295-f63d-08d7cce2de10
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3535D6D729B7E6C65DFC9C369BF50@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(66446008)(66946007)(64756008)(76116006)(66556008)(66476007)(4270600006)(316002)(558084003)(91956017)(5660300002)(19618925003)(86362001)(52536014)(33656002)(110136005)(55016002)(186003)(2906002)(71200400001)(26005)(8676002)(81156014)(8936002)(81166006)(7696005)(478600001)(9686003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3535;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5xgT75sIBMQ5RRhegVo0E1bm03gcNVB1YLw6gjUDz10xqqOHv+bm7smHbAiW5dY1ozSkEHElcjRX3HaUXVLJewMObCYa09BO5d4zEFvv58yBZB0akZIGZRKcaDt6IJk6fUsBq9rqzJJM9HyMsZ/wmIjoEcrfdIM35skoXWz0YUNGI1z8xjyozaE+NO6roC5d/rjQT+0zfJ5wl+oqcqriAWWF9XVnee7Cysi0bQdIbad3Jh4mUiLwG2482FtaihI855QNjo3mDEiUbpnlXOEQeaik3HxskFfZVpWArf0DJqfhAu0er1C49nmETdjBg5zgKXagqyteMuhE9jFMAdPgvxQIHvXuNWv1O3fIcy7DLdBnLGi3efFkEwcxvPS4qnH7K7eT/PCkgADOJUk03zpt3ui5LbpSiWwGpVuKHv065YNAd8xDtI6F8e78mF5Jn++o
x-ms-exchange-antispam-messagedata: 4nL03Gs0dvlF0BSQfMHPxpMFuQuIa/c64jmWsUXqY+bj/+Gs9fRlfAudH41DzdBcGgXbwLqDGh9/Mec7eF5fRShi9airecyIWPQcBy0a5EBa8wZM6dG4F9eNR/okcowAVNes73y4X+INyka4wpHaTQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b5c879-6f64-4295-f63d-08d7cce2de10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 15:25:05.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUHFwZiAVG9OhUbe/kb3IlJsPKNnSFX14U2dVcYnYlOreauWKcFk11lFU8rOFLNCnxjPPiL+NG2rYlpmVMu0P0EhUr4keQCW19l723Xxjfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
