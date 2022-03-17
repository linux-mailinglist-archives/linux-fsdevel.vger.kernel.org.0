Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD44DBFFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiCQHMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 03:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiCQHMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:12:32 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861C16A698;
        Thu, 17 Mar 2022 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647501076; x=1679037076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YWkIxoY4srksMXzZGk+Dt++iBrQahRaalBsON2jkwvo=;
  b=YxNlMtN8QOMngHPUlMpt+zf4+aU+11PZMBjxd3XajcNV7pzn8/kp7DTK
   ciBXlj6YDn3wGE3Pn2vkQ62B/mBTiz2piGTH4/aNvf71HiVvkolEbDZBi
   pb4jMfsB6+HPDfqbYKpLFDfikPHf7mswn2AI2nCGKkEwCuFEFgeQ++PJp
   BGXnIvsGeDfB8n4oGS1Gbs6HMe2lYt6O7liJM59KtJF8lBnocomqef8Uz
   u953z5ZbVFTpq+pRu+nDiXYsrYaSFFiPOsjizkOmjHBXjdm1X5m59EP5y
   F5QU45Dpj9OrrY2XFhR906gIdmF4jPnMhRWLLjfV3NYr8TnTsnKIdIp0x
   g==;
X-IronPort-AV: E=Sophos;i="5.90,188,1643644800"; 
   d="scan'208";a="307532610"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 15:11:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCSYu1DlIcyZrv7BdpdWybjqK0zYkIGeELlBmnH2kWwXzPE4svUgHHGLzj1apa8C4uM08cfUgCbfPagrkXfZmFmezotIKuvJ8jPWp/ags0L1DwVTTF5sEDRYJzVwpjoZ3/gM9tkb0k59RsDIDOp2DPgYV2K8ueMOVEB3/+Wi7R21bKM05QQ/WZDdj9qvayljqAeyt0QF21+V+3aPnsMyWMj9PIy0ofKXeOgJgE5tq/kSiCFvcvuDJziHJU9v1J21XAyD9wpt/KvaqyNCP4eeKxy1O4Qof3n+Nv1wU1qInIw93IT8feQ5gAV8QQ+5b7sReNfH1s7JoRsPp/qDzo6K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omx8zo3PUf2+hnUgRtNgHfCfHzm4nUF+5iySQPg26CA=;
 b=krQHGim2El16LrV5I/XMGLghiToih05PYMRJSINqrFx5uYb2xn9TkEpItOYEWDOmXKcwhSXE819n9CAkiJcPxgAN5uNtbJVXaQkyHN7tnCPXNDKflQwv0V4ZZ4plcNouPzyq6Im1I3wfg/0cfMm+Ord5jJEc9DD//tXLLKGHYUjLQp2VIKGXC+tT+3HSTtrsU9dba/b+/qn04hVETUN7xbN4KYNC/hI+5K5WoHXZbHbytjDAYhx8A1cF5CmWQbs81Npme37ctYbY99ebhIx1I48at2GCDgYQZ+0ekPZIhx7/aHbkUuKmyYoRpHYw6riikOMFz4tWXag+oxNvxOEtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omx8zo3PUf2+hnUgRtNgHfCfHzm4nUF+5iySQPg26CA=;
 b=jL2c0RK89QCnZO/gTRnqYh36VPPCLtygJWi6MA2Sl+zVtD/z4VcUJ09eMP4pgedzBn72n7egT/2i/lmiI98tiO/gwgadIOHl2x0Ob2eUhlj0V5G77j8c0F/MIqo55zVzFbGAnKpZGMO/ElAtIQ13GV8JxE0mR5jgVy/FBPUyrBw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BYAPR04MB4470.namprd04.prod.outlook.com (2603:10b6:a03:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 07:11:14 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:11:14 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 1/4] btrfs: mark resumed async balance as writing
Thread-Topic: [PATCH v2 1/4] btrfs: mark resumed async balance as writing
Thread-Index: AQHYOTj/vsJV1d2ElkuVD0W319wF+azCKqUAgAD/R4A=
Date:   Thu, 17 Mar 2022 07:11:14 +0000
Message-ID: <20220317071113.dy75tv3phfvej2dl@naota-xeon>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <bd1ecbdfca4a2873d3825afba00d462a84f7264f.1647436353.git.naohiro.aota@wdc.com>
 <YjII7HRAZ1HCuwwH@debian9.Home>
In-Reply-To: <YjII7HRAZ1HCuwwH@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5593ceee-136e-41b6-d433-08da07e552a9
x-ms-traffictypediagnostic: BYAPR04MB4470:EE_
x-microsoft-antispam-prvs: <BYAPR04MB44705D25B48D83ACEA76E2B48C129@BYAPR04MB4470.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPoGKajCrRZuFh3tht6CCvZC4Bw8k3YGi2UWeDkZ84vrawexXC6/UA3CnunCdKjrznBBqotKL6MmdlUDYMUPWYfZS0kCtJ5+xUpP0N5vikEufIXJj2b4l1cH6y2Nkh061v1bf+56z/2QNSI6RZUEvuU3llQ/79rJxaccB0QQopZ9SmHkP8tMyLHelF15O83N5Je+cSHpeK38nsV0X5xDGinGyDa8f+OvUnAkayN7xnFImenUMottjslas7CeJYnuz4D/7bCNtOx+lYOGl0PswuooPEEyhDl1R2+LjbMZowhlKlPk32vR3CtLbAdAjpg3RZ2UQvSFxGYQq/qUm/Cjn4fM9uhQyEb7/t/6Kl5cPTjb4ArQYX4SNYxJiM5WKVmR5hAf7Z+M3Cea0on8dfVwkxR/60rAqsTCmYoEewvq/KZnjcjSTk+CluY7qxHHE9sEPPjsCOYnYNJuQSeafKXT6KMfjGfKBzJD85jQQv4n1N5liAzX2ragKhPOxoXam3njm3tbkhEXkOS1N8SjcEAno9aKyUra3TExCjDvHwGtPQqMKrnCeict9jqmoP7vE2InhNGdaQFKxklnWEaUmbFUPUw+7RoC/RO6Xgj5sjiHS+cm/kAEcb1CS5OAShd6CuoG1LYn9GEGhLye5LfN5QRLxF6GcQJzqHCPCeCKM5WR+J8FM6uHd2ge9dXTon/IgHV2mNyuSHCfzhgxrsSGg63L1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(76116006)(508600001)(316002)(8676002)(9686003)(6506007)(6512007)(54906003)(66556008)(91956017)(6486002)(66476007)(66446008)(64756008)(1076003)(26005)(186003)(83380400001)(66946007)(4326008)(6916009)(33716001)(71200400001)(38100700002)(2906002)(5660300002)(86362001)(8936002)(122000001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RTR2Kgaar2KGCGSTSB14Xp71QMw3ZhU0SQcSp+UGW0ElToysjwCEBMOXT9hJ?=
 =?us-ascii?Q?WxtYXlWDnmMoSV+YiyhTZ0e07/qEd2g9lJ28Ln1Lw7WiZTv2YC/5ifPBagxi?=
 =?us-ascii?Q?KGIX1h94FZvA8BvHhzLeqzYcfGE7KxIlRrfrIZ7Tujc9ghSKjxeaDDm5QUkH?=
 =?us-ascii?Q?Fq0VPwmbd9i3HFC5WFtvji+CuSinGsELZa0/RF59x8GD4wIh5yG/eS2bP7Hb?=
 =?us-ascii?Q?66nhsNgZQm7M9ZI0qXRu9stXJQVKlcSIvHPWsipW8sWX2ZPEx+B+ErP9jNQQ?=
 =?us-ascii?Q?VFsuunD/Sxd01QnooXAcp7aeZUvdSC2nZFwNzGtRL4HFVseqFV0CN1HwrTRf?=
 =?us-ascii?Q?EWEcfXpmh3xaBO7YSE8i9T/+0HDlqlo9MgNO1f7BODnnn22wA4oLyAszqa35?=
 =?us-ascii?Q?u0gD2v9qiVUaUCi76zKF5KE/K4EA61VR40szQX5dH6/oUwz6GeRF63uVqWFF?=
 =?us-ascii?Q?HlupBU7bHs9rVMt4U69J243EKgzPKR0yIc59tNlrYDOqz+wGsJvZk1oA1M46?=
 =?us-ascii?Q?yeCr8tlUi9583CRwY4EUUNi0FW0mU5DRerP32+ajTINZq89Yr5GI3bkl/Ua0?=
 =?us-ascii?Q?kPTjDxlVRKRNT0VfF3GuUOZcXE5Za0USERV41/YFPFC1e3KucDMm+dumykS+?=
 =?us-ascii?Q?iI9hVdU9849YgSe5T5QMp0qTclB/ryN+AqT/9opVWFUGeBxNDnUtnYJlx+ax?=
 =?us-ascii?Q?2Jo6EeTgE/S+F4E6vDBO3+pcUUYl4WytC62pI6sHcMhHbTLrzVXrQndMgM2n?=
 =?us-ascii?Q?ju6dbTenUgbMA0tpzPnCaEy3oCVlWsJpTaG8V+lZp5pmWKvPadBLHNaWU1G2?=
 =?us-ascii?Q?ndw8yjq3J+yW7FkZOntY+hpB6wmal8h1Pw9NsIIYuaR8D4vKbE3GedNghkFN?=
 =?us-ascii?Q?H8E4TF23ZsYU5EL+aoAL26JBUpXEWckrSP1uciurTd2gB6LrmW7S0RGlG5nN?=
 =?us-ascii?Q?c92HYJmJjhM21BSr38583zQz2eRSeBtLhTkCjYQyVy/eoRA1D3t7XGoEoZwY?=
 =?us-ascii?Q?GzMXiKRN574dnjHfrdlrj04usy+/I5hWEOpf0bLHChElur7K+yKjLkdHT/L/?=
 =?us-ascii?Q?NmYC+MJfEEv39BmPOBQWDJPAlWkqmkc1KJTmAPheM+Owb26xfo7RytCEbim9?=
 =?us-ascii?Q?nojSwtZpvT/D4kAqSxWRFBxoXAQX2Abk5tHHG6T7mJu4VJKU5YaMfEvXYY18?=
 =?us-ascii?Q?DsOBltm1EHo1q2S0XWn+K6JnhmbomGC2bb2nCblhrQoz8t3Rxr0r7tsclVUI?=
 =?us-ascii?Q?XL0yn3iXcqlEbTbwMgX9mm6H7GryZkSuDHscf6guim/eGb7RrmHiH+hhDvpR?=
 =?us-ascii?Q?pwTF3+eFtXIA0dtT1WifDcTfNIAChLJtpn8U41P6ZkoAC5SZiFQfPDT7KDvK?=
 =?us-ascii?Q?MZlPvbtZbIDdKhvVao0Clhy9syiUAdHp5/Bme1GSi3RxieGxmOrVfe2xe5Ae?=
 =?us-ascii?Q?wKKUVoGWVwx1Ub5KtoVWmmUySNJCEBasMKfZnZLkPIditJ99INn9EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <279BA3468EA2724CA63887EE58EA7203@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5593ceee-136e-41b6-d433-08da07e552a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 07:11:14.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1Io8q2Nj0IEdXABSGW2IjxRYBaB/AexrdbdsOvB+h1HVQGXiSik2cF3XE33SPp+nhrLcP8+wznCI+1n9lSPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4470
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:57:32PM +0000, Filipe Manana wrote:
> On Wed, Mar 16, 2022 at 10:22:37PM +0900, Naohiro Aota wrote:
> > When btrfs balance is interrupted with umount, the background balance
> > resumes on the next mount. There is a potential deadlock with FS freezi=
ng
> > here like as described in commit 26559780b953 ("btrfs: zoned: mark
> > relocation as writing").
> >=20
> > Mark the process as sb_writing. To preserve the order of sb_start_write=
()
> > (or mnt_want_write_file()) and btrfs_exclop_start(), call sb_start_writ=
e()
> > at btrfs_resume_balance_async() before taking fs_info->super_lock.
>=20
> This paragraph is now outdated, it should go away as it applied only to v=
1.
> The ordering problem is no longer relevant and we don't do anything at
> btrfs_resume_balance_async() anymore.

Oops. I took the last sentence and unified it with the first paragraph.

> >=20
> > Cc: stable@vger.kernel.org # 4.9+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> Other than that, it looks good.
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> Thanks.
>=20
> > ---
> >  fs/btrfs/volumes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 3fd17e87815a..3471698fd831 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -4430,10 +4430,12 @@ static int balance_kthread(void *data)
> >  	struct btrfs_fs_info *fs_info =3D data;
> >  	int ret =3D 0;
> > =20
> > +	sb_start_write(fs_info->sb);
> >  	mutex_lock(&fs_info->balance_mutex);
> >  	if (fs_info->balance_ctl)
> >  		ret =3D btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
> >  	mutex_unlock(&fs_info->balance_mutex);
> > +	sb_end_write(fs_info->sb);
> > =20
> >  	return ret;
> >  }
> > --=20
> > 2.35.1
> > =
