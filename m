Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF4B4C21A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 03:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiBXCQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 21:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiBXCQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:16:34 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F47606F6;
        Wed, 23 Feb 2022 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645668961; x=1677204961;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jtYY0i9in8mLLjXLcZb4sMiMb3nt8QP0fnxJ/P/A3GQ=;
  b=a4wzFzo6VJIVSKrXTN450CN2zDTJ7HEIWyzF3mV0BPF2RDWcTQ7GMKdn
   L+PIvNJVyDgpGQmLFiHw5/utY6odnOzHLiFrn1o80YKR2ad5LA95BMt0f
   TfjrJCjCuK30/2uX3p7feMfoZIlE22lRJh7BhNEWTPzKydC8A+yunViui
   xotCp9Qgi8c0k17Zf0U8haF1/sLuKrpQfz2rgUDiuGz2UF82Jhty7GHqT
   hUJBEa6J9+EmYMcphINYKnSoGwCqdV+V0VCsrucs1gLuSMJNTGcFy7+vX
   cGVTgja1UdgE/VG06s7PcAlmpE8kTkXFNvpg4w6Usg4dusp/mUV4FGkuR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,392,1635177600"; 
   d="scan'208";a="305715801"
Received: from mail-sn1anam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2022 10:16:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGSxY/eLS5pgLCLlHaJJYQa1EbAriwk/90FeLb2QJp+2cliFw3JbFlflhVWM09JjlizTJJlvkQct04m/PJb+1CuDeU1S17N6PYSrOkk2CqtHmnqlfznsmsvmOKVGpTVtcwIBB7XjTkc6iP/BH5TFzJldvkiYlzfYz+fngMh6g7VPX0Yh9DF8a/D+aaKUnFIhzqgW6fVyciliKAYtJo6Q72W+HpGRaP4kgwQK4dScYDT+TqojeluK3nwjnEwTkhO+yKfv2BG5zwa67Z8bQmwBTfXovZHG2eO9hzALNJeEex02IP2rLI9pTt8UUAQvYzJ15GdxDNYiu1CdguwRUft8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VF2CrenxRkF05sd3kyF1msPbitVlvJPJKPEGeVuvSE=;
 b=MeSAk9EX57h2koZpO9/F+PI4nJd7CoZy4cDFJA6YbGY2vsGx36lMu4ICm67gm4xhF6gM8dfk/5dGL5Va17g2lF+9rJZ8cLllaA4ZMhfWei8kHsZBvWiY4l/MKSQCMrzYvF8vylCZAtmr3U0Sk2agNjrVqC7orZrtSk3KAZXC3eD++mGf2ctcwMFRhVLDteT6m6YWsX6Vw8GYDqlvsxK3CCsa1W+YX5AmcvrWU6ioUz34+Fah/wfwnGSeq/ZV5hs4DvO82+wzsUOGcYRlyUYRhKtoXCqXd2/Zeab/OGvB0/c1iSz4k+/MLa+BSVSrIFuMx0OQegRapkNIJGoLHcLnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VF2CrenxRkF05sd3kyF1msPbitVlvJPJKPEGeVuvSE=;
 b=zwi7dRyd+jjw+SXqeB1q4ckOsgNKdaZzovwwmJpqhnxna0S8uwSy88oeebbBe/SwyKC/bVPjFN7ypKM1MyT2f0WOgqglPgxYboISeh8GTJGEIY6bxTn1D4/WCU0SBKCq2CGuGyygLBLEwYFV0n1OePmxM+KDvQdsXjxdI+Te1Vg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BYAPR04MB5960.namprd04.prod.outlook.com (2603:10b6:a03:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 02:15:58 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee%8]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 02:15:58 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYJH4Hg8zszeTopEC3wqDurB05xqyg9/KAgAEH/QA=
Date:   Thu, 24 Feb 2022 02:15:58 +0000
Message-ID: <20220224021558.eubg4agqnkkodkd6@naota-xeon>
References: <cover.1645157220.git.naohiro.aota@wdc.com>
 <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
 <20220223103107.GM12643@twin.jikos.cz>
In-Reply-To: <20220223103107.GM12643@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edf3ea0f-940a-4c76-9f38-08d9f73b98ca
x-ms-traffictypediagnostic: BYAPR04MB5960:EE_
x-microsoft-antispam-prvs: <BYAPR04MB596007F3FE4D7989796C07D68C3D9@BYAPR04MB5960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBhJ7wwTw+kT9zHoDEkLOfdFR3vcrD4mVdWHj6ULGScrX5+DGu0ISOBGop7Kikj2NAWRIocKh7FxUmrxpMzWS/goPxEqeYC5cHTkQtlflfnb28Ufw6vPDkeOfB6c3uCEcOhP/53VHognqwPnoBm6xRS5PbWv3UzOMMPO2v281ay/52EcSAvW0Dl2Od7MhK4FU6WVB1OWW92+POGwWErLOjllIFV4FVnu6ec3ekNfD9tD7IpfNXY5fi2i3p4aVyPRW185Snm5ZE8fJ2C9821+cEid7ssBPG0H09t3g5I13ZfcgzoffwOkv+lRKeq+t0UVJ3keO4EvG1wmiNJY1RcRcG5mAKg4u6YKUq2afV+tdRgXGYCfAX2fjlJC69L1oRZkiDseIgc/NNIVO/VB6VprNXhamOGYQpaVoGQSKUzLkIBjV/PbrLI8/WrTarWQH84+DEF14sP9WUQnQ2OFDR+BpxRO1+SozsL33DoUwxnjIuJiJfeLPCE9dMXV1EpHqUAaW/lO8W5LlfgBUL6Qsuf+LBSvxWPcJvBqGoPPAgYP9lCrq+CBnZJzNwPQe663Hh8nK04rw/+28OG8+M4dXxdqKoGBaljNtWNBAStjNuIxsPk+Ap3a5TEa+HejysZEY/iaSkKBmUZh46J2UMOdEggz9tCCvvZ8sU7LUr9a78ihcmbyWKymZq1UUvphi+41fEoqCiAhrW2aq05/LMP7ToEz6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(26005)(1076003)(9686003)(186003)(38070700005)(2906002)(82960400001)(122000001)(6512007)(33716001)(83380400001)(91956017)(45080400002)(6506007)(5660300002)(508600001)(86362001)(66946007)(6486002)(66556008)(316002)(71200400001)(66446008)(66476007)(8676002)(64756008)(76116006)(110136005)(8936002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4c9mTWftBFa+jbJUXyyGUIrKt0aSReh0pHJUmljr5kUk7/l1eO97doRSDsub?=
 =?us-ascii?Q?+cVBss0maeS/2a/IXGxBh71QeaNC8A1UgkeLKjo2uvkGy4HxLih7qlPb1Qqw?=
 =?us-ascii?Q?b4fe1hn7d57foXdWZQnPruYn/PsX9D0loOUuk27keMtOPUIs5NadFQW40n+M?=
 =?us-ascii?Q?Nd7ccAdyO9aTniYkJSoFPJWqRFDtyAQ81GUtkSIfRI8btsW/3BICux1a9gMs?=
 =?us-ascii?Q?bKuju68iOK0S5dy4o8tsx9WhmT2nxz0+ec1c6JMsBZAUJZ9ziFIuKksLScMy?=
 =?us-ascii?Q?xlrP9y1q6uC/aawUjehyJMi0vRnLQlycWGuVh8fGVXOH+rstnUbU2wjte1RQ?=
 =?us-ascii?Q?pV7wc4cFTN7A36ep/G2TOiy24YV2omCqaJ+rx5Sjjme+bqAyGuUJb7uUNJm+?=
 =?us-ascii?Q?vB1eJVJ7W9hPI9YXLbjdiuoOTaRz8Ls+RVoEHzIoCijmUKnIrJaxFiqQUeY/?=
 =?us-ascii?Q?8x58tWhldCT5WqbVn/o5fbCv+OAw+E4nEpcBFncu9F3r+B/dMd2KYUE2OFvq?=
 =?us-ascii?Q?+/gyGogmVUHM5aWB+N039X310CPxxAuSTGQsPK/HtVP2BzgeJ77+nq2yoHE9?=
 =?us-ascii?Q?LPMDi5yVfzz6ZHO2tHSWrsHOZNfwgTzLeKSpCI+gjiL/viw1fQ5cHppSQ0hm?=
 =?us-ascii?Q?KCi/WNK3KhtHGFoe8AIa6eoenwHbCKbet+5CAiiak+vf6R2eJKloHX4ExCD8?=
 =?us-ascii?Q?SROP1fA+aaP9ym/6yG5xPLqLGaoM5nPCE8KJV/tbk8cR4HNDWtO4wjinzENe?=
 =?us-ascii?Q?gvuL/ct+sGBKgEwqHcZ2DaB1048vkmcuzw7fRS36DQV9bC+YHtjhcY2kxgK0?=
 =?us-ascii?Q?vFpG3G7IG8K+l1mF2qrGgLDbMlhLF4BQpZvXkujWRhIXIitt1qyia6fxo3RI?=
 =?us-ascii?Q?mzT2ydY30VW+yMkDL2QsGvhB9q+SpTLYVvMIBwT+8gw+hHSijJYctV/45V7y?=
 =?us-ascii?Q?KTJEuMIaq56qOUBfLQms3hgdq7zd421cOEw9nHVo1MwQFEUNGIgN8F7Np9JA?=
 =?us-ascii?Q?QCypxYk1vKKscKXQb2EwKEjQCzJ4E1s2N1nXq6GRTugveuVNDac8AV2VBrmN?=
 =?us-ascii?Q?/Iwl4Rg/aXFovDM5mzDQu17CEHKFTa4W98u0GHL+mK6wOwVBb+1YoD178lRX?=
 =?us-ascii?Q?HuYFTdsB9+nRxOqHiIdA7Q2PjSfiQJyvuXBs9AaSZ4jH04FFpe4KkdFsKeDf?=
 =?us-ascii?Q?kVVPM1zTiBcCAya0NbAOTfqtiKpBQcHhtSF1yfdc2Ze5x+S1RG84CCrTjqVo?=
 =?us-ascii?Q?YIozMxjhZIVSyXKgdKZPZJpylFq6nM9nVDwl9WhYWcNjPR/S983ZBtLiiJit?=
 =?us-ascii?Q?pqjaoLL24JTwNtKXT1fh7RVrxJHxp66cm38JFjENqDI1JJdh2d1ohHMHuvY+?=
 =?us-ascii?Q?36RM72tv//dUlEjXaNE5snwGtT+b+FkqcrOTILwGicz2EkS18A3lHYn/EOxs?=
 =?us-ascii?Q?776OnEl881tc4k+G2o7rejaJZn8sLIi7WjirXKlj0Z/52R8Rst09P5/aorg+?=
 =?us-ascii?Q?5yqYP3ZMwSaF+9lgcGrPSo53r69Ikm+/Cwkg3ysv/+09rZ291mwDHkGS00FP?=
 =?us-ascii?Q?Q3cUCElder4GfaKfXuOHQvtSF7V0LfMFhrrjEI5HQAneaukLmxUzLk34H5xA?=
 =?us-ascii?Q?6BDUVoBNWX6vOyvF8iFMT4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C10A6F25FA53C4B8882553B8F87A217@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf3ea0f-940a-4c76-9f38-08d9f73b98ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 02:15:58.6919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9D6f4MD68sBVvNnLjSypIb9BxUM98SKqgf8aAEyYUG7Jpdd5rZYVI8xDlAFT57w0AWMhYrtFuSjnQV2hFIC8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5960
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:31:07AM +0100, David Sterba wrote:
> On Fri, Feb 18, 2022 at 01:14:19PM +0900, Naohiro Aota wrote:
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3240,6 +3240,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs=
_info, u64 chunk_offset)
> >  	u64 length;
> >  	int ret;
> > =20
> > +	/* Assert we called sb_start_write(), not to race with FS freezing */
> > +	ASSERT(sb_write_started(fs_info->sb));
>=20
> I see this assertion to fail, it's not on all testing VMs, but has
> happened a few times already so it's probably some race:
>=20
> [ 2927.013859] BTRFS warning (device vdc): devid 1 uuid 4335c7a6-652c-438=
9-8ea9-270c00fa9880 is missing
> [ 2927.017693] BTRFS warning (device vdc): devid 1 uuid 4335c7a6-652c-438=
9-8ea9-270c00fa9880 is missing
> [ 2927.022921] BTRFS info (device vdc): bdev /dev/vdd errs: wr 0, rd 0, f=
lush 0, corrupt 6000, gen 0
> [ 2927.031780] BTRFS info (device vdc): checking UUID tree
> [ 2927.045348] BTRFS: error (device vdc: state X) in __btrfs_free_extent:=
3199: errno=3D-5 IO failure
> [ 2927.049729] BTRFS info (device vdc: state EX): forced readonly
> [ 2927.051787] BTRFS: error (device vdc: state EX) in btrfs_run_delayed_r=
efs:2159: errno=3D-5 IO failure
> [ 2927.058758] BTRFS info (device vdc: state EX): balance: resume -dusage=
=3D90 -musage=3D90 -susage=3D90
> [ 2927.062457] assertion failed: sb_write_started(fs_info->sb), in fs/btr=
fs/volumes.c:3244
> [ 2927.066121] ------------[ cut here ]------------
> [ 2927.067682] kernel BUG at fs/btrfs/ctree.h:3552!
> [ 2927.069214] invalid opcode: 0000 [#1] PREEMPT SMP
> [ 2927.070926] CPU: 2 PID: 22817 Comm: btrfs-balance Not tainted 5.17.0-r=
c5-default+ #1632
> [ 2927.075299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 2927.080897] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 2927.092652] RSP: 0018:ffffaed9c610fdc0 EFLAGS: 00010246
> [ 2927.095227] RAX: 000000000000004b RBX: ffffa13a873db000 RCX: 000000000=
0000000
> [ 2927.096898] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000f=
fffffff
> [ 2927.100514] RBP: ffffa13a55324000 R08: 0000000000000003 R09: 000000000=
0000001
> [ 2927.102518] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa13a6=
922f098
> [ 2927.104330] R13: 000000008cfa0000 R14: ffffa13a553262a0 R15: ffffa13a8=
73db000
> [ 2927.106025] FS:  0000000000000000(0000) GS:ffffa13abda00000(0000) knlG=
S:0000000000000000
> [ 2927.108652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2927.110568] CR2: 000055fdf2a94fd0 CR3: 000000005d012005 CR4: 000000000=
0170ea0
> [ 2927.112167] Call Trace:
> [ 2927.112801]  <TASK>
> [ 2927.113212]  btrfs_relocate_chunk.cold+0x42/0x67 [btrfs]
> [ 2927.114328]  __btrfs_balance+0x2ea/0x490 [btrfs]
> [ 2927.114871] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 131072 csum 0x7e797e3e expected csum 0x8941f998 mirror 2
> [ 2927.115469]  btrfs_balance+0x4ed/0x7e0 [btrfs]
> [ 2927.118802] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 139264 csum 0x27df6522 expected csum 0x8941f998 mirror 2
> [ 2927.119691]  ? btrfs_balance+0x7e0/0x7e0 [btrfs]
> [ 2927.123158] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 143360 csum 0x9f144c35 expected csum 0x8941f998 mirror 2
> [ 2927.123965]  balance_kthread+0x37/0x50 [btrfs]

It looks like this occurs when the balance is resumed. We also need
sb_{start,end}_write around btrfs_balance() in balance_kthred().

I guess we can cause a hang if we resume the balance and freeze the FS
at the same time.

> [ 2927.127299] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 147456 csum 0x1027ab9a expected csum 0x8941f998 mirror 2
> [ 2927.128016]  kthread+0xea/0x110
> [ 2927.128023]  ? kthread_complete_and_exit+0x20/0x20
> [ 2927.128027]  ret_from_fork+0x1f/0x30
> [ 2927.128031]  </TASK>
> [ 2927.128032] Modules linked in:
> [ 2927.131390] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 155648 csum 0x428b86d5 expected csum 0x8941f998 mirror 2
> [ 2927.131400] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 163840 csum 0x8fff7df2 expected csum 0x8941f998 mirror 2
> [ 2927.131401] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 159744 csum 0x9893a835 expected csum 0x8941f998 mirror 2
> [ 2927.131416] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 180224 csum 0x83d83877 expected csum 0x8941f998 mirror 2
> [ 2927.131832] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 524288 csum 0x1a0c8fd4 expected csum 0x8941f998 mirror 2
> [ 2927.132128] BTRFS warning (device vdc: state EX): csum failed root 5 i=
no 258 off 540672 csum 0xcaaf83cc expected csum 0x8941f998 mirror 2
> [ 2927.133105]  dm_flakey dm_mod btrfs blake2b_generic libcrc32c crc32c_i=
ntel xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress=
 xxhash loop
> [ 2927.144290] ---[ end trace 0000000000000000 ]---
> [ 2927.145080] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 2927.147738] RSP: 0018:ffffaed9c610fdc0 EFLAGS: 00010246
> [ 2927.148220] RAX: 000000000000004b RBX: ffffa13a873db000 RCX: 000000000=
0000000
> [ 2927.149126] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000f=
fffffff
> [ 2927.150057] RBP: ffffa13a55324000 R08: 0000000000000003 R09: 000000000=
0000001
> [ 2927.150676] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa13a6=
922f098
> [ 2927.151297] R13: 000000008cfa0000 R14: ffffa13a553262a0 R15: ffffa13a8=
73db000
> [ 2927.152529] FS:  0000000000000000(0000) GS:ffffa13abda00000(0000) knlG=
S:0000000000000000
> [ 2927.153646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2927.154280] CR2: 000055fdf2a94fd0 CR3: 000000005d012005 CR4: 000000000=
0170ea0=
