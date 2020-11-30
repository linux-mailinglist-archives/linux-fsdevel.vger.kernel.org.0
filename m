Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6112C832E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgK3L1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 06:27:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37748 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgK3L1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606735670; x=1638271670;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=A5mgTb8VlnVsxgsowst8b98LKmz0rnMnMA949/poQZ/hqYQZoo6R8dDR
   TxDgXMYm1kFFkzBL5Gp4T66zFBHHLuvXWGmrhoZeihITmGujro7X/b3dZ
   TcBrE0OD5Y0yvb3Z7CQHNOP5YH5T0Odw5CgivpZUpOMqETn/KlKWve4QL
   fuOQUcBCldKYY/kwwC6ndt9+MYZU5Jzbl/zpY/8e6GE55mpfAyFthSaJl
   0YmuR0CWg4Ze3pYodbQJhELZa6TFqKZS0bpCPMx/sOozYFibMigJXIlsV
   9mMGWfwb8e5JbTeO+gVa3Srjjj/2BEO5ZbhpvTnPY3bPFtf1a2nluMRb7
   w==;
IronPort-SDR: OmjVBp2+/KVjZgsE5EXdXaIUXOv6X+0D8CTji+Ef1cZD3U/WQHnV1R77gfGQb1aMokp5XgiegP
 FwJYRxMxsKbCSUNq5vDYQoBww/X6JRrz3NSqxeWUNegXe42c/0gGKmp97ZBVpGN2yw4G2x+BVU
 cJbHZCwIjKabeS9bZ4cHcIq+5ZP0KotugabmP9srf+w+WsJ8E5CLVtWXMVbCxGw9XLauWahaNs
 ry1B/mH4H1A47aL8RKQsUZsbGb0jmeZHH+mNrn/7FyUixY43JOnfRNhPGiaFygqSm77Sug/uCm
 I20=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="153875405"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 19:26:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsv0J0gdit/E3APoeS1RuAF651IgIRyxzv38lYZHCL9k3PJBpgbtuHogNlu7Vq9CX5nv8mc8+8F7gD3i/prgwBEVE1ELn8W8FFeb8Rwz1IglVinokDhDLNTmnevhDATj5GSAJZSAU9QMH7R3y4a8jodk2reG0NTE7GuiaLam7sLE//JA9Tgew7zjsI6hfRjuCkrmR3hKqGzur3aqZ/M35R9UAd0H6IP1Ga8Dqu+s6XJjK7xUJFPAdI8LyYceFzpDxbbNguxe7+GgR1XYrLJoVu69tJ7V/5K59GvLLn0Esq/YtsJQsNkUkcpjCMXI5MeCseaD9m/PvzGUxIrlpj9HKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=d7RSiXg5PD0hDBczkKq09kRdNxXxr4MxRhtE/TwUOGd7Yg9lpQs0ylE9GokVFjN6YmmLOfjaoBJC6uqlCTRPhbNTPrTtEGCiA41sxSxBNC8Cfm0D+xnGw8UNoeZ5KbD6LTuP2DuLRLm2gVwqQ/aMG+USn2ZKswc0LUGsipNRtZbHW4eJXuXXH1iHIxGK3FAlYaCANnI7vqWGfUfr1/Eh+6CSOHN6vtl+q1eLFSRFmzFI4Puyih/8mguRlw4a5SVprUdX8wsMnJGsRgb74mqP5Mz0fKWir5iUmPd0iVrJpF4clM82RR1DkTG+q2Fj/AwVvd/SMohKDgz3G7CfiOCP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fT3htEXU1M1PqdOvqPrbYOxISG5mGReKwR4NmwO4HWFt1JQmGZDe0qgbKshQ9k0BBXOBorvQdWkP8UH+FNCclgOf0I2n1dFvqownaVZAqWI69rOgizX2jSBGUrry51/KBLn5RsZ/fbJW8cKJHZF+ljoGH4a1J4UiMdzQZ9cTxFs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7436.namprd04.prod.outlook.com
 (2603:10b6:806:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Mon, 30 Nov
 2020 11:26:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Mon, 30 Nov 2020
 11:26:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/45] loop: do not call set_blocksize
Thread-Topic: [PATCH 07/45] loop: do not call set_blocksize
Thread-Index: AQHWxaG2UPoC+nZlKkGLQI6ts2xybw==
Date:   Mon, 30 Nov 2020 11:26:40 +0000
Message-ID: <SN4PR0401MB35980299348BBA758C4B971F9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:2c26:fc00:7c60:29b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1f9f9d8-ec50-4336-825c-08d89522cf28
x-ms-traffictypediagnostic: SA0PR04MB7436:
x-microsoft-antispam-prvs: <SA0PR04MB7436FFA28E0D85578A5EF6A79BF50@SA0PR04MB7436.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C/fTD1l+S8WQ96C8pa8WdYKEZl5iM0kiZ6StblqfNPaXFSfpNi3xDBgKXj/2cMrzEU5d9b0N+4+E7Pj959cAnc4YGAegLLcotqVQuYga82OaFh5DRyKqw8d9g+ZNXYYgMIPYhHIsM0IuDpq9wENx4dW4l6vmrxL2x85YMDfCej1v1gTlha/2Nwm5BGLUSeK8bGYKghPMKXR4mvWUA/i1iGAHHPctFYt77Do5lkd5ss64xVKbH0fIiZH7ZYrCLFgFe+rBf/l4tSOxDOIot/AcS3SQMg8bRvjlQAlTlUAnYlmjE3l/sZfjqRk2a5iNCmMJa2qBZqrf6oWXhCeo85Cm0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(33656002)(64756008)(66446008)(316002)(55016002)(5660300002)(66556008)(76116006)(186003)(66946007)(110136005)(558084003)(19618925003)(54906003)(86362001)(52536014)(66476007)(8676002)(91956017)(7416002)(4326008)(71200400001)(8936002)(2906002)(478600001)(7696005)(6506007)(4270600006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?arA84ct3CvUDHCx8N0pBqLNK7/MkKQ0M6UClHD8sGI8IgxHuzisG/vQwpj5f?=
 =?us-ascii?Q?lHOKlt+AakUbbLM2kw8mrC+kFyQg4TbAjzubEtH9FSUw3rdHw5faZqN7X4T2?=
 =?us-ascii?Q?8RrrBCGAhf27YIT5n75+6M3V4pINv0+2G1hLo3w8zNGXYxqKJEBvSrNJecgg?=
 =?us-ascii?Q?dW6y8I+OabNr5T5F2JOpmTeDpsMHw/yUC1x+6oFs+/+yCq3ymn/rbC7FDIag?=
 =?us-ascii?Q?9AziGT0SKSFkw7nEHKxP1kXegOb6vV7GHgmERi09gzyiX/e6c6Z+UZAqaqun?=
 =?us-ascii?Q?hacEWecBAIscwOHcELkJE8GQbfjuspyQ0RUsziZr7xBeHgrT/4nkBNDTmLxk?=
 =?us-ascii?Q?GcjL/h4tKtqXqcKYR2jrWxI83oaQNB6U3RfAa6WRlGWmNeE6/FTy7nxDp8Tv?=
 =?us-ascii?Q?uQJ/fOJehUCqRoq8+F9z6AHTgSy4zGSqVm50W09pFiHbVedkyv8ITsmgoy2P?=
 =?us-ascii?Q?CYh4HqTlGgb3mZ7LvxuP1eFjORWVWUwXebaJ5sLhc3PWPbFPOrZCf1bWFeUM?=
 =?us-ascii?Q?3owBmbDwGmqapN6zvyQ+EpRhbKWdPW5t6ZoNwjzp1HpMOulO7jjIqJ2xXmu+?=
 =?us-ascii?Q?6HYZEx8vV4YzRjslu6PkNJVQzXbwKkpbMLd2XgdNAy2halT7ohfctChTGjmZ?=
 =?us-ascii?Q?j/bbREokwQPplndMckjuamYhgTazBaLddgb7+IXXfc6baQiqgh6jf6Fk7HxT?=
 =?us-ascii?Q?wGBS+UVFTAKzojKljmKzVitfu012Q2fnF/4kUiTDAKKQTGEvd1auygpKaj+D?=
 =?us-ascii?Q?V9O8UTPdA4LJFXl6unBTDUcosyXBcJY1D/QlOJsvWFAlt2gy4c4Vy5w6nPsm?=
 =?us-ascii?Q?wcj1Cei9n/h7ur0MbPgLCgCGzcGka7zpg0XtoJk1RxngHHqUL21B6hVMNCBt?=
 =?us-ascii?Q?+8ntXKC6EWjz/Y4kPlP1hXTSpShya2ZNUqphmswpTRydE6uZ6AM/0NC4uLsF?=
 =?us-ascii?Q?8T9jB62tOr8568I0LNoy/OnJAQ6P8lNKEPC0XCQigGpWhG8xbz0XbNXwqke3?=
 =?us-ascii?Q?70STR4ZEW99NLQTtcbJEi2LBLmvP1SX8yeFK4Q8jsJ+lAgpqaEF8irYCD67j?=
 =?us-ascii?Q?1t5GdEDq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9f9d8-ec50-4336-825c-08d89522cf28
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 11:26:40.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JluDZqeAyRCGF0BjtVqI+V0Hy+Bj86m859625whxYIDXRc/SwNiZ8casvh5/JoCtb7/asdYfl6DjtLvuzI9WnsbbQvcSAIY6S8vj99iPQ0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
