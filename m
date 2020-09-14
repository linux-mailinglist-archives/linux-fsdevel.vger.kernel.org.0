Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395DE268A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgINLv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 07:51:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23631 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgINLsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600084099; x=1631620099;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bPtM+QvprWiRbpcl/rEXx78S9rLUBuX9siqY/0pD7zY=;
  b=mJzokQmlhh1mjrOhiHk4h6l4IluzX08qf3scSb1kElellvluFaoxm+k9
   rUAeeMOyyaCFEW+Kuvm5c6DTRIGefgDp93Ikp3uvMhkL9KE26KV5tkVll
   6rrirp0HJzR0en1MKDXy9wOKpulR+waOQXQDHTT6JtVlWyILd8QMbx/jN
   QpStlqEnZRyXuj2aR83MJshtcMmvW6/PR9hYQ+wCkcIBAjkBMKJp3sOtn
   NSHUArDOPthnueIsV4sKachrhprgldxuSxtIDG4EA9a9tmNh/vjJq6MaZ
   PHGeYAfDqhd0CaDYCcdESgPW3COxpKpJve8gqZM9AfoYw3qyqP22G2/BB
   w==;
IronPort-SDR: Qs3i+xIo6sDqF8idpn3NSv1RgCqObCUzW8tbK8YC7VN+ZlFt635llBohXXhLLFO5uNkYmMy4m9
 SZE5CBzxn9u7OyltnxosAuPM8vaSRjC38Ai5IprUa8LZbLNFF9Ek8Bc9zzBZP5VD4TxWDZnYfy
 F+4I5G4l7YK7NZQFUJ/s2Q/Tua8gCL7yl+YPW/aqDzks9Rnr1kFDb9dw6CIMmYz6P5u5iLxiFJ
 vVBatJw6LyLHHLyqkPagAaIZuIGk/aWc85piojJYBIkKzGgvE69D0dg44KKNaWxKFBLttFl4mW
 aIA=
X-IronPort-AV: E=Sophos;i="5.76,425,1592841600"; 
   d="scan'208";a="151664906"
Received: from mail-dm6nam08lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 19:48:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiK8Dd1+0b+IuYMTYRcY12pEqvHXzVAlA/b+rUJMwRR60BGbDlYs7WO0XAILLskdslHk5YoACnEYKPpa1p3yVKR1Nnk9hPMbAoQ/nmUhSK7ZITi6Vco49gZl2OHrlGk1jvASqI0o6SRdrOIMeu7cI9DtW8d1SeWrK6tveuv0BpQuhc+2KwA+d59jMRxC68XaN69ab7pRttrCo3ZGvn0KXQD3h3IPKXpbRT+t8rySixA8MAtiHlxjPvijHiRZeAUXiEij1OXP307tk9+Gf2vB1O//cehtthlfC+/6vpWcR2zhbZLcIkuonPPcJcHboPkCctNsFfxWByoyN0NMDVH8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtM+QvprWiRbpcl/rEXx78S9rLUBuX9siqY/0pD7zY=;
 b=bEyuE7M3nYWc22SQc5lHZxEV+MN2db3+IbqCiaYQp+crf/NU/THTQVSbZuCL+OzTq4Zw4L4iecKOcDbkCPdsmop2VbxqOM/k857jO49nS6P3DaVHUFhs68HMuZWUI44Ciq6NlNZ55P9TU04eHbTFF8SwsO+4ycj/JsC0AWrJRpmEtghuSgaVKMwOqn6FFNeuZyzX66Y7MpOPX88U3L58W6p4FJ98AEtjPdn+AzGkiHfCaFkIe+tg3ayQnXc5gPxAZluQSeo3X+JeVo8998XF3mzmO6KRAPqtwE3v6/6jpefnaJbIOWG8bsnqrYJfRkSpuHs1CYqIxuFsPsbeLO/+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtM+QvprWiRbpcl/rEXx78S9rLUBuX9siqY/0pD7zY=;
 b=eWz6XurRI0CYXiGKhfTPP0uv/k92Vxybbg5WfTU9cyYoRgyR5bsVe+HIsSqCtVAhIjhi++cRm09jSiLEG2Pb87iMC0QfbooZstHRpmtPETchHcimSchFa65ivMWcL9RYPDmDOTcGRSbTwbPQQn8Sfe5+bnn3nEmvd9Wnuf3jBQ8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 11:48:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 11:48:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 18/39] btrfs: redirty released extent buffers in ZONED
 mode
Thread-Topic: [PATCH v7 18/39] btrfs: redirty released extent buffers in ZONED
 mode
Thread-Index: AQHWiGL6kOlC4qdw3EypagtA7iP6Gw==
Date:   Mon, 14 Sep 2020 11:48:16 +0000
Message-ID: <SN4PR0401MB3598D6CBEC94FD4F7EE568299B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200911123259.3782926-19-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5f9a89c-7c35-4bb9-7b59-08d858a4119e
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3520E95ED25CC48762BDB5889B230@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGtkUr1gjxYBA5TK5BZCXs/ephtB5BShFJw4NMMPG2seYYsjOsN3gsVYeDA2cyIwbMZkQ1GAQon+nxm6jVqjFYQs5mqpNic/lSc6T1YlrA9Vasu7NDXsgitww9LoTkrnw68tIp3+RJ3ryuh98GVYxcHxv+vRVC+kzNHwyV5e1k5cBM/tfTa6uK3ArUV07qH4jWsvryueswgHn9VkZ2ek599h5iDprlEal2hUhW3p0/FR7PbIfu6L0Xy4uEtRBucjMkhWPzzQMBAkoD8bYZpDdGHjJ+9/Qj5pQVgK8foaK3l4QhM3ZhCYbgVO8ma9BHgX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(4744005)(316002)(91956017)(76116006)(66946007)(8676002)(86362001)(66446008)(66476007)(33656002)(66556008)(64756008)(8936002)(2906002)(54906003)(110136005)(71200400001)(186003)(4326008)(53546011)(6506007)(7696005)(55016002)(52536014)(5660300002)(83380400001)(508600001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NqhtALk8Vdtt0kr8FabK1fx3kYwZX+tgFdxOrHgBBv/CRzgq0821qHnuopnyw52ctBUxFIWw1ihYO21MDOqv9xcqUDqmptRVkB3Z2qy0EFZhgfn7Ta7mz004nUPh35f2tksu4bhzWU8AP/NU1UIEQ512urTVDdZFBU+k6IGFcMVzPWwld2IhKSS4HJT+k4GdU6AebfQMTj5g/WvvVEaCWqlm4/6O66K/S/hiCos/eK23SUL1an29sNFPyDhGbPV7iNJusoIT7dtq7fjf8kLjRIA7qBx5+UPehEdsOqKs/Yt5C/DZMvL/xALagA0Osz+sUMB1x8jSSHvfyCJdU4wsnJBENZ4FHRQQwykRSH2mFa6xGCNTy4SGq2FWw2NlIhhGSXRGdqn6v9MDm46JA+Bmrm6QO83mMaqTNjjSfDXtHgXCjKQnAp5UIxv00tuFN57n7LLY8KdGGYpii2lNy5huNGiAkj3OMZlbe4HYmwGZHpwZw/jUyxboA9skmfYGcIKtqz3fpBk5T5IPhF39sltbBl4Xl9qIWDlvO6JYFjrn8XFSbD39T7/DU7qbhXedWjZqpVnmwthya2yyOCAAjhhfwaODYtIn4ElJag6wlmxLsDCJWdjgeC4MWtkcmZGQmNyxSwWAs++QnF9MjSWNFhJHt54DY69fC0ETJa84BCcmxgH5V0gws5yvMSNY2Z3wSTSKqd7Chqo1MIRUm2Y8WCQiIg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f9a89c-7c35-4bb9-7b59-08d858a4119e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 11:48:16.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/7bPseaawQuaWGBAlfOKsmEkpFVmR/RX53SosLqAQLExLBRU577tQ5I4UlwhRVSTQCXoxXMvnATp1bwX/ojd1w0iNAbCrSK8EQHUWbBgZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/09/2020 19:42, Naohiro Aota wrote:=0A=
> Tree manipulating operations like merging nodes often release=0A=
> once-allocated tree nodes. Btrfs cleans such nodes so that pages in the=
=0A=
> node are not uselessly written out. On ZONED volumes, however, such=0A=
> optimization blocks the following IOs as the cancellation of the write ou=
t=0A=
> of the freed blocks breaks the sequential write sequence expected by the=
=0A=
> device.=0A=
> =0A=
> This patch introduces a list of clean and unwritten extent buffers that=
=0A=
> have been released in a transaction. Btrfs redirty the buffer so that=0A=
> btree_write_cache_pages() can send proper bios to the devices.=0A=
> =0A=
> Besides it clears the entire content of the extent buffer not to confuse=
=0A=
> raw block scanners e.g. btrfsck. By clearing the content,=0A=
> csum_dirty_buffer() complains about bytenr mismatch, so avoid the checkin=
g=0A=
> and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.=
=0A=
=0A=
That one doesn't apply cleanly on current misc-next.=0A=
