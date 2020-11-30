Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8012A2C80D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgK3JVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 04:21:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50717 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgK3JVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606728628; x=1638264628;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=JSKzNFjgqylNsXrGb8IqL2r9S/oY4FDMKXjiUalPcG40utddLH83ZLmd
   M9Ps4BMDVCF+71WFg47kLNXIyCUufR2uOveNVmyVdF19T509zChuA+rtH
   6VA6eCj5XlaRLAtWskAxe/5UIYAfH59Ci2DECMq93/e2xY3bA4TfzNb/L
   o3/JwgWMa+hnBmp6vdFFZMEzNJtJjBYmtA5R0cFWtSuGQbsORSfssJtpZ
   LsfxHmwRPS1TeEsWQ4trdQ0eauTCmSzKuG3cFqamy6HNSDPa8wimbUtuy
   jmBOGvHrignyFg0VEwRja+NeTj7CjHzIg/tZZqiS9YuqVjfdzyzel+a36
   w==;
IronPort-SDR: 30dmv2GVw9omZk5nScyBE94RWc12Y6/AOrt36CDVDgm3EJZT3g5dfep61PdsUYnfs+gLNwEczG
 lZorKKiN2ARJKbt8FOICeEW4tn+CN47ZNOJCiOAGrc9VH8axE3v1ryfp+3IE0lJZtNUQcUD8pA
 8TaIDArIFcdAJa4H3rY/29b+Bsn06eTF9SG/Xptw+RIaILqN7SK8SCauWcTf5lwVZElD7fYMAZ
 NNNU95ZQaFrs1UR+v9D7A6SZAdY4p871MkXTf68cL0+XrFp1Ah/liuArU3T21ErM8j68Rly6Hr
 FDQ=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="257475519"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 17:28:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTy/hm8ZzXAbTjHsaUUf1kveXVEoCEnu4JqYgUFlC9dUECoRHxJZYORF4dTkQl4BgvNJDa5frf6dwP54LEKHgBElHtATYAMXpszMvj1pj3XLP3RmebUkpUR70aNn1VB8x4DF59qjNcnJ1uMyKr371OK+ZeMKqMFHevad0VVvtiid2UfdVBRVezpARCIw+vrIwevT3/ZnkLKksAxAJJZDEgS9lbTWGLzj+R+cehpC/03yxbhD4jv7ORpbt/Kv9C1GK4BoTZn6nYC1IzS7BKx9jNX1CT96zuNMSlWsjkErICksU0QIdUVQCPhBjq0OiiqQHOB418zqkcPnXlUdFoSGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eSr/Pvsx9LHiOD1n+pemv2le4de+LHnVxxISa62B3bMCXGVqXysu9IH/FB69Yh1gQpFbIcxsD3Wm+vuI6SlWwr+XKDfMEFZ2BHQocgY5bpKO9zRvrSxvOGLp+iIFPqZU2O+pYX8spwsk/W0RXDLexyXXS/i6ieByqcEoxyKhDz35hMfexqdKkspYyoB/oO/RojjzrTi3GpVmMwymACAziOWQJNU36w2RM3+qHp1Ka6HEXQ9bVe7O4Hcx/oIZ+Dkkdx9FUvoOG+6gTarPz91nV5e5wgtaW8+RhFK+xD5HdJsixZLWoE6IcIQKpzSO1zIf1lC6aiNXu02imV382xOTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qfO3nsDKJKylRVnAT2PR4NgkeqKc0W0IspjFphHHVISuWba9hW+zfxczg3iYeIetGBM0tJPxhzaZwNk1TCAEVgarXsSSrsNNgckmqCW+pfJDmGJl5Ympl4QAKBZvjO2qUvshTr0XqsJAFkzr5IYqzwTk6w6N7+tnRy8102qwilk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7594.namprd04.prod.outlook.com
 (2603:10b6:806:136::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 09:20:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Mon, 30 Nov 2020
 09:20:07 +0000
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 11/45] block: remove a superflous check in blkpg_do_ioctl
Thread-Topic: [PATCH 11/45] block: remove a superflous check in blkpg_do_ioctl
Thread-Index: AQHWxaG2R4tyW2DDf0eoMvMUHA4YTw==
Date:   Mon, 30 Nov 2020 09:20:07 +0000
Message-ID: <SN4PR0401MB359840636BA2F57A26F159E79BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:2c26:fc00:7c60:29b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d631229-9cb0-48a3-34ed-08d89511215e
x-ms-traffictypediagnostic: SA2PR04MB7594:
x-microsoft-antispam-prvs: <SA2PR04MB75949460375CD1052865D6069BF50@SA2PR04MB7594.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzeUkmGPfSYvr0GQ/DW1fyEW3zzaETC4h/ntDEp/lAVe8ZTTwR5Vo5fZedO/796kdj175Fgka8vPLc7d/sHvZ9AS9Ob0tv6kLCys1rnboFxltaVN1eg3VrFMt64ciQFvmwfZ9KLb3GcF7beMzIo7M5augKw4GMoWf6yRRRkY/Xmvw8Pufis1JbFTulz6+dMbXgt8sRRXN23U4IAh/a27pf3kOobxhN887eD0sYr48y1XgYlBJKVUzsNWDrb820DTJpLTXxRuspFcApQoSeFT13e6CWgiOPuo+b/fQ2egNDJsgIO/iT4lPmjnfxc5GHWtyyVvIMFRnIDau0sqTa4y9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(5660300002)(6506007)(478600001)(186003)(4270600006)(558084003)(55016002)(66946007)(66446008)(91956017)(8936002)(9686003)(4326008)(2906002)(64756008)(76116006)(33656002)(19618925003)(71200400001)(52536014)(316002)(110136005)(66476007)(66556008)(86362001)(7696005)(8676002)(7416002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sBwgiRi8HFz91hVZPsEH4xofEUZ84B2oNLt24n94w5o7lK6S7/E8mNiOHVKE?=
 =?us-ascii?Q?W6sW3acQp2VPp7BmZ9a9S2AmMj4vCKjBOF39ms6IvnQb6ecCCfMRN5xIOL6z?=
 =?us-ascii?Q?al76fcfciTE56Db49P2aoVzSWV/Kj9fT7XbVQrebaiRxR0HtvwY301QPxV2b?=
 =?us-ascii?Q?2PuWaxrKG0sY5ZsL/iC8lVta+Mp6RaRFYjnDJ4lHo2l1RcHv8GhUKPLANbrv?=
 =?us-ascii?Q?frSL2A6R0wzzTR5Krwlv6sx2mkaMua4sQNGGfa/KH2V8mEBrd6mX3FrDJxOn?=
 =?us-ascii?Q?36iT9cuPvoyXpMzhsh4pZaXyhiTDd1FaE3VRHhqcDEdYrN+vzXi0Z9kbykT/?=
 =?us-ascii?Q?t+ZdOmKouYfeC2h0bHwydsm1DTWImrk5/SiclJrEx523Dgct/NnKmP57G6fe?=
 =?us-ascii?Q?FR2OvbheXDMTmrALZF2UWN7ll8MlAzTjSecSR0HcSLVcFEb4Qjj9K+/6c8bp?=
 =?us-ascii?Q?EuwKMGcqJV7WptUbqPz+AHCszfUiOFoXZQvXWz47cQPhgAtJNQT5z3k79c5p?=
 =?us-ascii?Q?42vAnAqqwdmG/W07Oc4NGxeDDR5r9kkwaFUiUEGe01nXonqcySw+pKlDsMq8?=
 =?us-ascii?Q?s+p0sjEcBAtLyVe7VJA9UZspCiSyeh9HwcOAgX/OvmNFGGCHFoG5qEgup2UP?=
 =?us-ascii?Q?q6PFQbyRMJbJAG1oKXWSzD90C8quOYGk8qrRluL0N0rg8au6nul/O/+RPHF8?=
 =?us-ascii?Q?QYnX6HVk69lw+GD+e0r7J17Y9Xcumgisx3VJhJ0DopmXsne7lOq7afNU8BRi?=
 =?us-ascii?Q?7HfEaxNtMmMtu9mdQ2BvKwtpUMViIVXYWHVwcdIQTyluJ+WHaLiQshTJIXIU?=
 =?us-ascii?Q?US6ucXZw7VXbrzAT7iptzDMxI4n+tpowKAoFfOu8rbgMY6raDQB+GpD8lnfW?=
 =?us-ascii?Q?P0C2/oh6lwjcKBMuQcViN97RC77/xZfjCz5awsaDaBhbHCYMxav3P9E37Ed4?=
 =?us-ascii?Q?yyDvEFryRLsCmKq/zXyESXx0bS0duZF/x5+6QJF1I5E8OtypWbcuLtk7xWnh?=
 =?us-ascii?Q?yGrGm0lAozanuFx9X/uHJri9aKPbM2lPv4qQQV/IBJ+T3WUuPlcAgBZZIybS?=
 =?us-ascii?Q?y5QxRKaC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d631229-9cb0-48a3-34ed-08d89511215e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 09:20:07.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCCId/TlCPrFtQtXgAAKu6GD7sV8O1Yxb7MHMs04oekt4TNyHsAgXL7kCnq5SEsna7hLI9cetZxvuL96hmRqCglMCCZFHXUZuI1b/8NNon4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
