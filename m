Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBCF5AB54D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiIBPeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiIBPeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:34:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEFF39B;
        Fri,  2 Sep 2022 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662131936; x=1693667936;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mYwUc3DW8Mn7bZLU2+hcqgMJTdTcfSZGFGA9if2dLpk=;
  b=GwizmdfzEb3Cv1n3eBNt2T55729SOyjWprkS677kEt6SPMvPMEkYpiju
   +AXZddoO/MBHxLiBdvB4bAF3RVvwmoDV0WYxutE6il/vnRl3PBzOMwBn7
   iop1W24VJFb3nU55/tMZuVrLlpkigdr8eb+UDpTljvaGuefQBhDztPbE2
   COdL29HlFROulop7V7adJYtpNUA5Z+jcpYrwJwoXwHxIwoHkjzgEBVWSt
   D48FF3J3jJfo/JVpgWWEMNomNokpWTAmjlrsdRSOafKH2lO/L/0o8PGwY
   WpwqSZvyx2qzHY24WtK/7Nj1BHdCqHQfeTz4NXBozMKxxCU1uGbZq5kQZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654531200"; 
   d="scan'208";a="314628391"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 23:18:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUyjfiZoX8W5SAy3fq2jBargA50QL4jwV4MgVygbZVcJStn+YR2HopBapI9pd9jLnr9ahCoBYTdwxhiTqWaVUfrb+i2A/MScxXNRR4IuOgiCOiPMlHnK/Kbc+/gkKcrQVdQIFzMrN8haVhHal5S0ikgaIP2/L0Tv/1/IszqwHVgNN6PvULujBK11R98a0sIsYv4UI/HGNEl0Mc0Tdvy2cGXRJmXrm/qc5QRT2X1YBn4h/biLcuacXVU8MkJY2Fs+axTWNDVXwtmXVrnacArtr5JDFBWD8xO7C29uP1x0MprN9DC1c5ZTMikfdzObpcrESKB6Kdma13QNQIJALr9tGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2A1uoCW2AJuVIE2w/y15L3MxvZp9R+cz14mXYxkMGA=;
 b=Ik17BeyF9na3/B4x4SizmCEeWP1TCyEwXGmKIrORXbxT0lRMTyT+a7qQWkzyF99DDftGkQb7TmtZC9a8sFZV9MM1NOZ2EFFFhaX3TRbl71SUACuX+BpWtmenHKMNjpezWl/Ewt2cYX58UrRkXrG8GkjAduV4E5Q/jNvcDe7FPogmAip4Tdez8ZXzhQ/k69icWCC34IcYKRPOm3JfTM/LP9ma5RjM5eQBz8/EFICOhoOuEjCxtGCXZYsfYLYScytv9HIlwqn9+sSZVeDCCZGbLFNACm1d3IuGsKQrELnyTo2M/jsCMcehlSgvLAfTD0D3ljitFzJ0yk+qL/srYYPQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2A1uoCW2AJuVIE2w/y15L3MxvZp9R+cz14mXYxkMGA=;
 b=S6lV5NG7+266sAGL7TiiVDZ99IvnG20O+M/dArkGKzXnAf1dFw/XUcERqSJfLQm19PLRoAOrsXnzOXNPs6R2FBc84F0UTICNJH82OJoU/JxUFDPFhU7n1rU/u6J6roiqCMDJuk6SLgg5oUSfIZGAqRQFX/A49U+AUEbcjQSrrxc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Fri, 2 Sep
 2022 15:18:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.015; Fri, 2 Sep 2022
 15:18:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Thread-Topic: consolidate btrfs checksumming, repair and bio splitting
Thread-Index: AQHYvdZkzfjbXHDoM0mHBIw1hzgYgA==
Date:   Fri, 2 Sep 2022 15:18:53 +0000
Message-ID: <PH0PR04MB741603DA3C8B9A1AA99AD2819B7A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8283c9d5-3241-4c38-609b-08da8cf6721b
x-ms-traffictypediagnostic: BYAPR04MB4965:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32/0X6fb3dB6sVN/qeAWYuB/c2qyRG+tv6W9bPegU17GfRrqJk4QT93AnKubzpZVEfUEOKlFfBTMvAaaXx8WSe2JLSyoGtTnjzv+HQO0nO7mAtMPYjakJi/whZaPrFDylboT9nstTtrjDsAKPMjWn4L4I0FBUuiF1jS5dUiM1NwCE400qscKdqbIYPOTPToP4DgiiVoDZz/Hd1rnMDiyGFCAw8oEG+TGCTQ57gQosCILd8JmgmKtVf3q8QjbeTXboX2dnkkX3rPydGgw2BtfeKkNewqGt8dJJSrFVsVpazZ1QaN0nk8trnJ0DvB9urxeBaPgzCu13K99n1Rb+bLhRImu1l+iuo1uMt0Me8mJyivIVZzXmTE+yoEZ7tKzOY0S2489NKz2cJVtyj+r6+YJ0U9uI3AwK+Z5gYrDJkUHOlhjPfQbxdgRTxt1p1ikQiWkKgn5TRkraTRcl8A9rX7kaHyvQ7wt4BkfVdSaSY+j9QpJRn5tfCq5fjH4i/GaAv8JMnxoE38Vs76O/naxZf4g4VZme/jPKLxExHgKp+0Pc5kx/Ta6jq069bBGDbiX96yfyMUzCq/ivU6g2vQY1axBiwld3tbGcEAq++ZCVmnbu1fOs9EwchusF1Sh9xTtbxTnJs3OoZpas0IN8hhNy+AJnIeWm8ZQc/wuNojXyBc3NRNh6sQLT5YcM4YaO98Ekqasb32O88dV5vrrMuam9wPnkbu5kQzkc6ZiGsOi/So2mSc886F3TUENLYaiPIJ6ZW5fXF34Jm1KfcnzDB58WUxhdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(2906002)(6506007)(66446008)(316002)(110136005)(41300700001)(64756008)(91956017)(8936002)(66476007)(55016003)(66946007)(66556008)(8676002)(4326008)(76116006)(54906003)(478600001)(33656002)(53546011)(7696005)(9686003)(71200400001)(7416002)(82960400001)(186003)(5660300002)(38100700002)(83380400001)(86362001)(52536014)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TA70hkslaZMKy8Yiaa+w+5H+0+0VuOxsLHpAx4EdHjC8nns3RMZTaJSxGtQ+?=
 =?us-ascii?Q?C86BXtfInForycZZ6i1PK2kovhzGnNl0WpCV6B4c0MpZEptfX3fY1cC3zYTy?=
 =?us-ascii?Q?Lt2BfYNaDk5i3zbxSymyWo9/u4rzPAZwxRDC88EP2osTwXuOEw6mu0JGLfiI?=
 =?us-ascii?Q?HyTizWCn1DDoRGQ9Yzk09pwpajvIvRRMMJ54FV0nhhiIeEYu8hEf2ZXYTVHG?=
 =?us-ascii?Q?i0vZn9O/kwWpaYnOuZLKkfiStuWz3q4oDpNnWiBT93mxUPuqNG7DT07Ij/+b?=
 =?us-ascii?Q?h+1/kq8c/PgucWCy6+o4d6glhVkfXxLHkWmC6U62q/IJWzTY9G2GjW/i/Atk?=
 =?us-ascii?Q?+5TT9QTeaFmMhhlpyf5gITkX8Jbs6q+cWqmm6OhsNNTKFFovMbt8qK7uaTdq?=
 =?us-ascii?Q?Lla9MX9uW8vAYnjot2Lw3WOVzrklBQkoysN3dWMYVcp6bQiZzeDMkl8y2wsT?=
 =?us-ascii?Q?yyNi6uKP/BNyuEiFM2eTYIMeW72H7qgPuaZSKkhLTJxMy2zG56i7h/HV88vf?=
 =?us-ascii?Q?uiktsGfHbLlxgbw9pQtiSQXsOLaqna+IQtYqwru+LzejYb9H14MkU8A5WLLc?=
 =?us-ascii?Q?D6ann3BFWylKlL9h+Hx68xVxwvMmHyWkcAmouB2kGTWHdrAxzZfolHS4d15n?=
 =?us-ascii?Q?WQ1wNMomUTIHL10rJ5ed6qtzWV+57s08iGVHtBdinJluaCFa8sij88+KTGSM?=
 =?us-ascii?Q?jGY9XQ5AIngeezczpfSfXkuOTKLGklEcD06wM3iOxF7SXim5CVPNkG0IRyGR?=
 =?us-ascii?Q?+DukkdUdgq/webrHklky0kLfg22LcMGPsLvr7x0iwDoPdiGD3SPZ8sMHep5/?=
 =?us-ascii?Q?ip8H9ngM+JD8V5YMTLCK+BDVfkQjKnpAFNWVEe7o9XAAHje+1fXn66okTUfG?=
 =?us-ascii?Q?rIU0dvsMiU3rj5ehSUGKejGHe4OpuWiapR8E2A2my70DPHkJwOF5ZwmdLMzc?=
 =?us-ascii?Q?O9z/VKNFK8ChIdzVYrSngy9gL+dleq3oyV3WOi7qkEHpwxDOKQ48OAuTMw3N?=
 =?us-ascii?Q?9wB8+2njwwD/StIDPXwd0uB2i4AzAOfm1hpiN4PkCRuUhYX4A/BF/YjUSa43?=
 =?us-ascii?Q?TTX1Ce5M9M56aVZoZn7iQImvuM3ODXnx9yjmnjbUiPYTXgLlq99maEkkSb/L?=
 =?us-ascii?Q?KrcFS+R0/ZqcqXptbefuGWhtkRMMGIbeoq/2yu4gDba/1d8WT+KNbYJgDcpW?=
 =?us-ascii?Q?KJAJ7VSwR/yzdVEzXCsnHvKztIOe3daNKj0/GSbzxI5aGdLMlU0wAeZUFvZ/?=
 =?us-ascii?Q?cX00yym0jmuynKFyeBlF9DC8HU9YNA4oRXNNzKWg7MwrDfcBeyFehtvzC7X8?=
 =?us-ascii?Q?3mJz//s4iTGpsiuYoe/ytZiAc06Tl47Vt3tKBKjGp4wSKzTzRERFaAE5chEk?=
 =?us-ascii?Q?PkObgTRr2FWFb/gboSgl105w3wiPeiIPvxbVjck0I0laqRH0MjnA6q8pMhin?=
 =?us-ascii?Q?oKem4pTjbi65cdptu71SXHzgZ4hzAIvusTbmL59IdZdcTEhsvq9iKynnk/AG?=
 =?us-ascii?Q?et36G4jowD4VfWAIIfWTMTixCoKBvIGiZGf1bLjagS7g2ozJQ2Iy589bvFNl?=
 =?us-ascii?Q?ItNnFsvljJlt+/WmnX0bwJycArhHGHleuEkE4RR3gBu7zbXRwqSuPAKJTR/9?=
 =?us-ascii?Q?1YFncpCgsgQb0F3RNsV8/qoRQzdd0Jvz9xSUgGMwV3oTz4kG4Q+rISRJMCg4?=
 =?us-ascii?Q?bWD25Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8283c9d5-3241-4c38-609b-08da8cf6721b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:18:53.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySe6biONnrFtYubnWTuPpxTUad7N5g20SwexL6VLaG1wS+Xv0xNdVz1elnLBjPG2yIFHC2ha/sPPNWE1zeO6ZMF30m/M4jaIy2SY5F6VpV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4965
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.09.22 09:42, Christoph Hellwig wrote:=0A=
> Hi all,=0A=
> =0A=
> this series moves a large amount of duplicate code below btrfs_submit_bio=
=0A=
> into what I call the 'storage' layer.  Instead of duplicating code to=0A=
> checksum, check checksums and repair and split bios in all the caller=0A=
> of btrfs_submit_bio (buffered I/O, direct I/O, compressed I/O, encoded=0A=
> I/O), the work is done one in a central place, often more optiomal and=0A=
> without slight changes in behavior.  Once that is done the upper layers=
=0A=
> also don't need to split the bios for extent boundaries, as the storage=
=0A=
> layer can do that itself, including splitting the bios for the zone=0A=
> append limits for zoned I/O.=0A=
> =0A=
> The split work is inspired by an earlier series from Qu, from which it=0A=
> also reuses a few patches.=0A=
> =0A=
> Note: this adds a fair amount of code to volumes.c, which already is=0A=
> quite large.  It might make sense to add a prep patch to move=0A=
> btrfs_submit_bio into a new bio.c file, but I only want to do that=0A=
> if we have agreement on the move as the conflicts will be painful=0A=
> when rebasing.=0A=
=0A=
This series on top of misc-next passes my usual zoned null_blk fstests=0A=
setup without regressions.=0A=
=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
