Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0A2F9B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 09:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbhARI4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 03:56:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48028 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbhARI4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610960205; x=1642496205;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OorG9cK9Ae2APBL7+MFIdiCcA4w2cwLIS6Q1jFK0AhI=;
  b=h3BGFq+VSk/Od+ww3hYWS1TB4E8jWlAcvoRAB9Lns92aXwmteIeIDIMC
   GFUU6lo2PXAHE2GME9UVLop74JufpsO1q1A6g0o1J2kQtrmnbTdOf0W6S
   LfrAcxrSDFvEnZw+4n0gTMs0RE4DMYDPMTbpSp/7VZD/inJ7+5JrVr+2D
   SeqA+KPGyiHt0y5uyBhJ77XQfk8Eb5Vrd7uAw6Gn1JcfCvvW5bF3iLHqO
   7KLlDxEBPwfh5SGxKujJzDYBOmePDwTNW3qt7/nbetl6azcj/YiDIxCzU
   o4DQ3vBkhDQBrDvXnXStaOG89xnMZiJc2Hqaynv4u+pGHC2tfH3TxrD54
   w==;
IronPort-SDR: f4FZmxvxcOQ87rQV8v8Vus/cYk/CM2mCMNVciF6oWFUvz2qdtEgbJ/zVgycvYFMlvuG2O2Lkao
 rPTG2X+TYmaQwT33wlM0rl4mdylA5jeY1/DmZy88V113lE/hpuEPgWn3y+DSb8K8oT6yaftPWN
 dnzh5+5pPU3/+BhqUeDW9iSxstKqFprUWlHCibtbICfcB41SwH58MZzuPltFigg8+PmeNp5Qe0
 6eVCfzUOKbgg0x+C9AIUIUCMyVjavkpvtrhJ8fGoCl0xIKgkTRiAZKXhRyFCvGGsvFDbpzZIxY
 Qn8=
X-IronPort-AV: E=Sophos;i="5.79,355,1602518400"; 
   d="scan'208";a="268009149"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2021 16:55:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC40WqBP/jvd6/AHckhGL4/kF/0vza2wr9wVfrMpoKscY8vmBy/MRYh9dJ5BIHgqmHGmemSir0vwM9nuV4eHYXvDVEmWrsaYcpuEK0TtI9E6kJ2yN9ySrwhXjIW4Kf+FXHDAKk4Pi63Bd3bkCqJzs5380Rx28Vb0icnHg9T/Uol5iU0Y/QsMYAtsPTbNmM7A6+iLyEQM8PGSGP/tj57XGkmWjQQeKwS/XG0gkAaJUMsdrFfNKxcCVyePVuDENwn7KaQ5hQYOPPOaCKLXhlIk1j96KI164A2c1Euzqk8gaiggihgPfqHW4drBxCL4Lp7tr6k3Wtm8cT0b94whmncLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2ZvcLV+17IW43hsPQ9o/PcZ/QbQJIqDCsKD635FkN8=;
 b=QG89SXCHZyfHzt0NA2f2hmxkFhnYt95uu8JFIOYkf/SUWg0Rmhumm5FN1lXzcJiCqrukJb6c7Rfh64uEMf9J5/I4KBZzgTu959pgxv/l2XDNfNeGT2VffWZNJZbGCVdCMR+e2WAdwwrj54nwErlN9sLfj5AU84aYdOvaWRQmpHZLX8bQmkcpwXGKgcpS3gikuhfEblR22auE9Jyc1UulWF+xgu60b09x6PbWIMJMYzQVhZ0YuqPNL4mpCVI0RdWEFoj4j7HorYdsMpxTu5fu2xBnOTMKL1WS4lZvpRqAf8unujpMkcgwT3+5gZNbZEeCR7swernv/ncVJtlV0Tv+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2ZvcLV+17IW43hsPQ9o/PcZ/QbQJIqDCsKD635FkN8=;
 b=gLWY5f+Re2WwgruqMCtKltjxztTz4EA3ZVZGndSVnqmklVfQFgAXSwcEBJ3ITZObw7HX4QuLBer1cukLLTNvE0HjxOGRUVor9ZbTl9H/ejSA7qDb3OMUSprXgS42fdaBOw+QMBOufRYZ2WWBKTzhrZ42xuKd7bJW70N08dlXpBY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2240.namprd04.prod.outlook.com
 (2603:10b6:804:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 08:55:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 08:55:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v12 05/41] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
Thread-Topic: [PATCH v12 05/41] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
Thread-Index: AQHW6wthcM4npzKSMUeHMA/mGsCCyA==
Date:   Mon, 18 Jan 2021 08:55:36 +0000
Message-ID: <SN4PR0401MB35982E318D23D91BC093637E9BA40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <0786a9782ec6306cddb0a2808116c3f95a88849b.1610693037.git.naohiro.aota@wdc.com>
 <8f7434ae-fdb8-32be-f781-a47f32ace949@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:a8cb:1595:5b20:8662]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bade78f-6a84-4749-39b8-08d8bb8ed2ab
x-ms-traffictypediagnostic: SN2PR04MB2240:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB22407DE6C1999A3573C4E76B9BA40@SN2PR04MB2240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:68;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ib6GlsI6OMw8uMoNCGAVZLM9Wix8kfXOz1YkKGiiujEKbbuvKxR18eRsHrg2LHgxpk8sQPVF2pGG3rfVpJ06xXDRChVybdlHowEAe1DGqmoHWXUrlRQ5L3Zv3g/RLax9Db2+9jHxTS2zd9UFJJKsy7J3gedsRUh6iJ21uDDy8rysAqHD/VILsPHr6KuSvNEh70y5lEaYGOMDiGlXlLuiyVC5VOxSrY36pdl58kFW+8BFvhMKPtKJRVnNaxmw2DEcU6Lb+42q/wkgHqwHGyRQU8ZayAH8EhxooAvg2irWY3HtD4gwRcs4eocyy7vS0Xy/jcIKysb+LkL6MauKBf2q/ndryaoRh9TUOI4MHQQai4OnT+ZIek2VOzqDAvjJigCuHhPec6w6Gdb1krpQtuqLAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(86362001)(66446008)(52536014)(54906003)(91956017)(2906002)(55016002)(5660300002)(558084003)(8676002)(478600001)(66476007)(9686003)(66556008)(7696005)(110136005)(33656002)(186003)(64756008)(4326008)(66946007)(316002)(71200400001)(76116006)(6506007)(53546011)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WNZ90kwcRgT+hGtDwd9ohWD5rP8466exdO4MwWhteh1sukvFsZHp7XKZiPzP?=
 =?us-ascii?Q?0Aho7DMjt+cKBku2wJYMy68rEswcHAGCq2nxjgDOB9hfq4V47pBBaYJYFnZZ?=
 =?us-ascii?Q?+mxSX0kC1n8ugNLomAAMjQVNvI6+dCS7TzjGj2fjWwR1SKAFCM8SXH3bBQjU?=
 =?us-ascii?Q?Lfn1tJn4Hp1WG2+zMQjWn5JZVn2QsviHIIRL92FhJnJp2bj/q+eqCyfjLP8o?=
 =?us-ascii?Q?Dq7UBwF17NYiV20HQda83ppPg7yhqGlhsipVScG66EKeplQDgWIxaSH4sCal?=
 =?us-ascii?Q?8ezyX37AnW2Cx69P9rzW4q8e5uX87ESGhcc8536sYpVAzrXN0fL3/uT2oP5K?=
 =?us-ascii?Q?B2u7MWvL7x1IfAuJMv84s98nfxyV68nhCynXjwdU6Z/lFMiz0+w+DZ76sykZ?=
 =?us-ascii?Q?LBgoTYPPNkCI22Rqdh0FQRA46I1B95tAkjhj43p04nN2dGiOIiLCQ2NTPSs1?=
 =?us-ascii?Q?+zm9nXhjzBE3fcaZkYRe+M8F7UVJ4PjEryNZDzAL8f9BLMOMMJj3asXQ2XG0?=
 =?us-ascii?Q?DOsOMZoE7FwP4j4MBgc+GmEUaBwVP3hR6W3tmpot0yq2KmXN2/iRa36X1AbD?=
 =?us-ascii?Q?SYlLmu6IvNn8/dzQFggUf+1D1T3uEo65nSVRGGY4TQ/Glt+W/Y62vlP0Tmja?=
 =?us-ascii?Q?N3PzLkv5i7+JRECZ1kxITwYK0Y2dvVT56z84zHiWa4605vXhn1ROEM+qBBmU?=
 =?us-ascii?Q?1kITxSzobfSZ4DvXw943VTUpKpPJdjompHoljgW95+aloZ///f4ZTKFhjCIa?=
 =?us-ascii?Q?3W2zw/FLviC5mTjXUhPckEbTECzLEsECuM4RaLmDXGNOKIxpk4KvP7ymLu42?=
 =?us-ascii?Q?nX3JYKWLV7mxZItl/L4H0C2Uaz74h716Vvwnzhsf1r3ckSm+MsOsjrmeB92g?=
 =?us-ascii?Q?4pmXTLYFUPSAMGFMJFY9BimpH1ISIfZw2p9GN4RdH/94mv9Q0qJXh3CvbeYh?=
 =?us-ascii?Q?9t1hWayaey0wgvlWMr7/wPyPYJwgSqA2OHRKFDoeONCplgwkEbmRNMq5i68B?=
 =?us-ascii?Q?fQPzp8nRN/PJM9c/JAfNOvSiBzDAnqNZaoSj2Sa+PXH5+acgUx0tnA3LAYb7?=
 =?us-ascii?Q?gkidXlVe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bade78f-6a84-4749-39b8-08d8bb8ed2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 08:55:36.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYhrwFYHs75C5uDOv/h+94EcksNfzRo8CIi0VAO6N9TclqQY4bWLkQitkSP2GqCPZ7tOLQHdGoIQ18PDcHZLy7gZmlkKMyUMteS9b9S6o5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2240
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/01/2021 23:22, Josef Bacik wrote:=0A=
> You're releasing the path and then reading from it, a potential UAF.  Tha=
nks,=0A=
=0A=
*\@#%! I'm stupid, fixed for v13.=0A=
