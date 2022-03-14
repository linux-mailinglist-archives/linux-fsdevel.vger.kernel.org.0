Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4A4D795E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 03:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiCNCag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 22:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiCNCaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:30:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52F1AD8B;
        Sun, 13 Mar 2022 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647224966; x=1678760966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SJcnwqi/geGwqrpZkoK74vAbv3P8XnFnV/cBnV2iDqM=;
  b=mf9T+jPZ1CNdkxhVQ8/+5RgulMZzWs286oVjK6VT2O4iicfyLaaZYv3Z
   7pX76zleXI7h3GQ2+zI0aY9ouIhBn923onh9qOTuAJEnLewUS7G17mWrc
   qshoE09XKcDPgjx3KgC3NZQo/kvYxIbM8Jk8PApyaskmNqOQiDznNmBJr
   ERDowcz5FQ4EMQGWFPn6QPwnixFgRbQzTgVkSOPArPprOLBCPSOAgpCeF
   yqWkbnyviB213WZMF3jp/1YJWZsouGsPko4STWKvr9brCcnd2TEXFGsHV
   61rjWHY4ttKnZ3qN7jVDGjFyeCMjJI/CTcQsam1jmKFUqMriB+P+rlxst
   A==;
X-IronPort-AV: E=Sophos;i="5.90,179,1643644800"; 
   d="scan'208";a="194180057"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 10:29:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbhTfVSH2TG1wcQG37vSbIic5rsoQzgUV2ambvZYF0HcwKMCIabq5wXF1LWGqjjAiUOTQxL/hgXIxXmyKHJ/D7ExMXPcmjmOwrKqAmyXMWp6bKOIivUyOGPYsp+KjpWLAZq4wGyDDaZbH2PfQzYPt/vuXJq4iWDGtbqX3BGxnHIGy724lF11nsrMRDZrqK5FWt1u6CXadLbC205m4R416fdr9q1IXkpwMeLLZMj6RSTTib9qZOY/79ucU6K2m6h+PNApAuXOjLt79jDlqc85+BNedLZovk4wVN8tyri3SU9plPiiUNSlMW3QZl2JmzPS1ZvWtGbHpDOxTHogOkB44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SorRyWo5e6aSv4C5xfcNClDNxDuceCSNwkpsnKqcBk=;
 b=POZH8GMCu7Csh/iAHYvTLuQTc9c241SI+mAN7wdWteSHrZsJ2GjwdCgPYMZzJ5ekObN6haxJ5actjuQPdmxnB7G9VqCdnZEavln9UWdJX7k4HMN4B6jOZnZU1P+hcLXXAEdsd6t10fGuiwEFqJyr+xTZ6apni2XtoGMh7mcIBhezl4AvWmKX9hXWp4QSBs0D4nMTEBtdFA7iE/YFZq/K8xihiMbD4nLk2+LCrW2PLfE3+uVFz4/whw1FElsQJX05U1q6yFHcy6Tly61o20j2yokt9wOde0ODOTdy0fBxS9MBxlAl0ndxKbylXGwMwHsxtsY1QENcabNrQkbIzDcEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SorRyWo5e6aSv4C5xfcNClDNxDuceCSNwkpsnKqcBk=;
 b=ocu/t4shVyzbmK0RyNSxAZ5rQwCtY+tErZhGZs+DQEIrGqKl1wBtHHfSC36qlazHfvqRM6bXz0t4edK6iQXYCc5xZYHo8iWamALQzf/zq47/Hw7To48mHj2keMLjIMMUlWV5zfmxiUaXz5A+WkD/ZoV7Up2wIpa+wTSqE1iNh8E=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR04MB0881.namprd04.prod.outlook.com (2603:10b6:301:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 02:29:23 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 02:29:23 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH 1/4] btrfs: mark resumed async balance as writing
Thread-Topic: [PATCH 1/4] btrfs: mark resumed async balance as writing
Thread-Index: AQHYNRsLUs1jC1nM1U+NVi005axwJ6y6OMqAgAPzoAA=
Date:   Mon, 14 Mar 2022 02:29:22 +0000
Message-ID: <20220314022922.e4k5wxob6rqjw3aw@naota-xeon>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <65730df62341500bfcbde7d86eeaa3e9b15f1bcb.1646983176.git.naohiro.aota@wdc.com>
 <YitX5fpZcC/P70o6@debian9.Home>
In-Reply-To: <YitX5fpZcC/P70o6@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa6969da-5b40-467b-8d33-08da056273a0
x-ms-traffictypediagnostic: MWHPR04MB0881:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0881279AE1B2E42C721933DE8C0F9@MWHPR04MB0881.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SM1qXkJHnWb5VFq0x5A8TZ/ax4OytmYN7yERF0f4GoVcxJgFiBYjwIT6PrLUy51E7dSK//7An3TilRL9StxXa+jbg+zkB5uztPrlCOEHfSfgKrAmyVPaIAFK6lYJL+CvQdvMUC2oZmxb++K02MPltnCfq03TRV6ceLI2JAd5DmsT05pZD77X9h0anz+Auh1qvvz133AvFl8U8xFqlr/93JN0MugqdPaALfXt3X7LPBWabospw9qiyzeLmP8JFApa28IfWidGr0D51TNSKRF4P7FqyXhe0/dKGXxRzchhWqHHRrgzX+xxKkt066lGhANxe9SFGVb8A7UUaTDoECp/Uw4XdZa8C6mxLjfaxsnoXxsNy/H/3avBU+SE9c5rOkF5y+VqUOfnvokkwR+6kXLxvAGN8bPNY5SxzZ31wzcyZY4fMdf5IRKS2M9AVaLIHiTdTWhRSl+97rFO/2I3VinRcHAQQFZbDmGsdpeo7aDP6U/jPPZn2rMSb1gql8c+uwF3NQPwM+KYLRRplgx0BiXG5XTZn6BdyTbtzcgYSK7BWM47bgvLjIMDG+TlHpmA6qkZogTaOvza2nNqzNBTuJRnALVljALGtcncdB2pUswbbYYf30j0LnZCHLcvQ+mozf2q8w2xn0/XhgpTnp8WcemqwDhmwgD8M4G/CsXgNiYA1DvIv9k2xyLBN0m1Ops1Eqs2d+eldxDSTJkk9oWUQLCUWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(38070700005)(83380400001)(82960400001)(122000001)(66556008)(76116006)(66946007)(86362001)(66476007)(66446008)(64756008)(91956017)(4326008)(8676002)(54906003)(6916009)(5660300002)(33716001)(2906002)(316002)(8936002)(6506007)(6512007)(9686003)(186003)(1076003)(26005)(508600001)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ACrUt8pH91lcBcrsSZVs1QoAS0rwNVm8Zb/SGYlXxQQeYCZuc2Kna2CPNLRY?=
 =?us-ascii?Q?ZhS/wcBEx7kXt6CRn4eGgcztvUzjTdxAfuGLInGsL+Vq11Y/caV7EOyj0JUH?=
 =?us-ascii?Q?sSBtfkvbTmLWVn08jm/fatB1CsnRP5m8rF8GMTKWV3M7o0F6LKkrC6sYM68+?=
 =?us-ascii?Q?GZQnGGqxcYLT9MXz6VTYzLE8L0YyR6/Fade4f8/DCMK2tUzQNPP5TEDEktIh?=
 =?us-ascii?Q?/GEnm39J1motZd6tVcizh1yMV2pQw5xJi+PWxCljHb0C2zSa3Y0X0Qm/3k0y?=
 =?us-ascii?Q?/Z3TfLiiV7g6L0GCEZ3OIxPiCpVAGMpSGuCQbgTwNLB3eJXsCUzDiNn1hQ7K?=
 =?us-ascii?Q?ZbWkoJ8lFcQ5a2UMRGbx8W/cOtjLrOekBqDgMMgdrHZUaez+Fh+CwByL2Osu?=
 =?us-ascii?Q?y9DyNRDU9Nxf5/gMgjgGHEcV42xwnGmW+Yqhw1bJYAvN5NE10bBhOT7E/Co1?=
 =?us-ascii?Q?DIrJw98NWe1JXS4bO1R/o+i4eMPOndlTyKefxEORhHEBWp/RhPK4s6Poa71Z?=
 =?us-ascii?Q?uyswzI7kwvDQJLi1WO+hT5sue+8eUW2wwsKf2D+2U6idjMihX792lCPpdb4R?=
 =?us-ascii?Q?tCDc4mN06qtYjQ6wVId9+eFVcCH6JZRuCkwJ868Z41tfYpG3kdzL9F8QGRvI?=
 =?us-ascii?Q?IVLDGnAsJ/XBY9vqEtxHOz/zd9dQAoeCWBVk1pViIxyhSFZVc9qP8iysbeL/?=
 =?us-ascii?Q?DzVnWTLcFCwLzzzhnZzinZCYVSoPVf37oLBV9poLW2uCYC4vnWwNVzzgaMcy?=
 =?us-ascii?Q?PqM1fBgOzo4Qe3uqkRdVzO/hbZfD0SYZgmuz0R5u2ZM4HyHi1GQvEvNlH3Fr?=
 =?us-ascii?Q?57hfQPQTzsWAvyY092zO3V50RftPgGh3C+20hzeQGRLOUWWxgz/K04F+z8sk?=
 =?us-ascii?Q?HzNVWD5830x/anzhj0s2FlUZS+g9Dw601s5UR6zmJliZd4kTOcJnByQB7hlg?=
 =?us-ascii?Q?H+C3ZFsfUNV5mG6Jeyz8rMcP3emG7ioqif5Y7IKIwTeN4X7hEVjxfwTv6+0Q?=
 =?us-ascii?Q?ud4jS7UHa+zXgTID6SEF6J1TcsnTan4YWD+8EZr7P/JWGJFwvwhC9Oc35Ne3?=
 =?us-ascii?Q?OUJnX2nF4l6KzZjmj+ngVzXQlVjBQCs9V6weqQYuVWttEF1rGKsH2pUG5Cdl?=
 =?us-ascii?Q?BX8cOxyXxX4Dx34mEvQJCqsuOPNNuF2eK0c6S2aXeVhgs9QBR5PZ3N6CxP6U?=
 =?us-ascii?Q?iLewPyRx4yJF+e7S1+rgyzh8jT+agSInYuXJrlslPM/AjuIy8v+2Zjdrn+un?=
 =?us-ascii?Q?+fL7TQYOwsLA8hJV8iZTi/797IS1RyKkkyx3sIkNzIo0AgQ5HwMgsJC40+NZ?=
 =?us-ascii?Q?DIZL8KI/vxVEV3cWweYCo4E9MrAuIWQvJ75aD/xJdnZ2H/2OrUlNFqNsIhuN?=
 =?us-ascii?Q?YiXqscIGJ7dbQST4G4euzrYntN0e3NTYCCWlbTp16c1rT/9btgb9fcximeFf?=
 =?us-ascii?Q?ZS40a3Zn7mTm63g15qGYtiJC6S4z0ZNn6Cd6jXfQoGjT6QW2K3ghVA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <001EF78E4438DD47BEA18B2A79E5E36F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6969da-5b40-467b-8d33-08da056273a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 02:29:22.9932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MlxHLk5QKCx0NfPVCObrV/Gf/EJ0RiEE8vNUWjh3xLclv1Go/5u3qIezpv8TFnJfB9jMmqNxDbCmzfd7GZylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0881
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:08:37PM +0000, Filipe Manana wrote:
> On Fri, Mar 11, 2022 at 04:38:02PM +0900, Naohiro Aota wrote:
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
> >=20
> > Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")
>=20
> This seems odd to me. I read the note you left on the cover letter about
> this, but honestly I don't think it's fair to blame that commit. I see
> it more as btrfs specific problem.

Yeah, I was really not sure how I should write the tag. The issue is
we missed to add sb_start_write() after this commit.

> Plus it's a 10 years old commit, so instead of the Fixes tag, adding a
> minimal kernel version to the CC stable tag below makes more sense.

So, only with "Cc: stable@vger.kernel.org # 3.6+" ?

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/volumes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 1be7cb2f955f..0d27d8d35c7a 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -4443,6 +4443,7 @@ static int balance_kthread(void *data)
> >  	if (fs_info->balance_ctl)
> >  		ret =3D btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
> >  	mutex_unlock(&fs_info->balance_mutex);
> > +	sb_end_write(fs_info->sb);
> > =20
> >  	return ret;
> >  }
> > @@ -4463,6 +4464,7 @@ int btrfs_resume_balance_async(struct btrfs_fs_in=
fo *fs_info)
> >  		return 0;
> >  	}
> > =20
> > +	sb_start_write(fs_info->sb);
>=20
> I don't understand this.
>=20
> We are doing the sb_start_write() here, in the task doing the mount, and =
then
> we do the sb_end_write() at the kthread that runs balance_kthread().

Oops, I made a mistake here. It actually printed the lockdep warning
"lock held when returning to user space!".

> Why not do the sb_start_write() in the kthread?
>=20
> This is also buggy in the case the call below to kthread_run() fails, as
> we end up never calling sb_end_write().

I was trying to preserve the lock taking order: sb_start_write() ->
spin_lock(fs_info->super_lock). But, it might not be a big deal as
long as we don't call sb_start_write() in the super_lock.

> Thanks.
>=20
> >  	spin_lock(&fs_info->super_lock);
> >  	ASSERT(fs_info->exclusive_operation =3D=3D BTRFS_EXCLOP_BALANCE_PAUSE=
D);
> >  	fs_info->exclusive_operation =3D BTRFS_EXCLOP_BALANCE;
> > --=20
> > 2.35.1
> > =
