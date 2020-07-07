Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CA2165DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 07:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGGFSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 01:18:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60037 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgGGFSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594099088; x=1625635088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=USMPPNcd4wJ7J8C3Lt+RV4h4khvaiR26jll+4EgzhZ0=;
  b=rSw5V0pL3182VzBKB3zC40Lk1OgWQZuM9WUV4eXGgehdDcsDCpg+wRFQ
   JP+xkGSSpyHuRS9lBBhFLWJISfm9ZuMhzhDjL+O7RSs3M5qzbBOWtcqKv
   uvrRjmiF0YwHJ/uxZOKSksWroWGrkwaGjZmEkYbXPXkz5GKAIo040xGie
   WtDCFdk1fIjsUAsmPvbqCNH2GBxrW56i96pvcSj7P/uM4GlSpylXOrut7
   JUdwdYx1QhajWdyuzbtX8EmVBJ5tfEaYa15OohljDdb6oqibgfyWDA/kd
   jggiwPUCmzXrpul5pgOJ87fMYT2iz0QGudh4wcWUB2m7lcNGh1m2+jW2M
   g==;
IronPort-SDR: 0eG3qFXpMRWa9Vl6Fbs+XuSrs94/2t3yoyiI+m4QFGA94jb0Nv20MOekLjFHatDSYxZjXetetD
 egxj48rBdABTSOGgGI/nl9d2aZf5Sqc+ybzSorTMsOyJifjJN0Y+1LnMw9wTpA9dunmxDqx3sc
 RF3UOm7KDKgv8oMio+RvhbLXwuHXtLZovX0tEUGpEaG0VO42A+7nXIEuk5AqW9qk7IGHCIBSW3
 H3ViA+O2gvBw4a3SuoFMgvGhGh3uaUZcLUVnbBc6nrA1G4AX1/kRgb71MOoQj7apjV5xBJp8/Q
 c6I=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; 
   d="scan'208";a="141789835"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 13:18:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITkf50oEMoAL2kzZUUdtGTv3G1P1nOf0aCE9OnVwuZqvRjeIViQlaGR4JRm3OdUGSSTG5d/QUjIQAyLC6/8Xy7704rIsitVE4+ftsZQIILuwTtGLiCu3J4cpdMtg+Ppik4SHprb2JAkASijZYqAWc/ujdagoWoL2pAgn2NTC2f0kQwsv2NC0BufkyyT3WEcFku3q2JLZk/hO1zgWERP+AIuG2blXKlCovGueuWovyIWOL/26uFalWWSrZ+n+trAYfLd5WTYrAb5sOoxPfOTO3egLPy0VneAKPYkpfFxCaci48FyYbD54MtIx0PPdwa6pyz6HkrIq/FpsYGmboHihHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8WMzclKHgDkmMZi+/3H3fBJ5GmwvPxC1FJdY+IGCfY=;
 b=HN0Czy/YIQ5NR0dpjwEU8OicTbIIHYCq6P7/XfXKroodhTxGna5ueFD2o5h05ck18sfcYMDxnjUyWL5OJznw64nr5vRCdk6JZe+vVuNbGWhn04vqv+qFA/Max3xNo6jcaDEgDpgzFAdcNGFmOywHpFZLIdUAIAGnKwxrSzvG0cP7K9uyv62biFaHW0t1Dzo5057c2gKEaT8pHMnlXa3C4HrxjVFNF1uk8KCWxMxPcDFMGG2CrJ08Mwt88+RgLLzkFDNIsx3z+giH3kGhM7VoF/uZdeakHfUhpK7QMVOF1kb7oOmbEZum/zNrGAL6DsyukbKu+rhtVwzaY7yqMvzc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8WMzclKHgDkmMZi+/3H3fBJ5GmwvPxC1FJdY+IGCfY=;
 b=opceDN9o2P1I8cjm9FBjE7LF1Q4nTqpJZs5SzGQLAW2RzuNC1p7m0esR7Lo+6qP5RynhR5zXiVp6twpgum0HAsXN7PK/R5/wHwalYSD9XL2jN9xdffhE9mojQpf2NFQc49pKd98h6hnjr3tbdnUyfNGLD553tfR8m5wBFzrEJhQ=
Received: from BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12)
 by BYAPR04MB3973.namprd04.prod.outlook.com (2603:10b6:a02:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 05:18:06 +0000
Received: from BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b]) by BY5PR04MB6995.namprd04.prod.outlook.com
 ([fe80::f813:2bba:2c5c:a63b%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 05:18:06 +0000
From:   Aravind Ramesh <Aravind.Ramesh@wdc.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: RE: [PATCH 1/2] f2fs: support zone capacity less than zone size
Thread-Topic: [PATCH 1/2] f2fs: support zone capacity less than zone size
Thread-Index: AQHWUIkRI5HubGFr/0O9cA9AIcqh/aj7RBoAgAA12+CAAAhJgIAACm6w
Date:   Tue, 7 Jul 2020 05:18:06 +0000
Message-ID: <BY5PR04MB6995BCC3F4C7D31239684F6B8C660@BY5PR04MB6995.namprd04.prod.outlook.com>
References: <20200702155401.13322-1-aravind.ramesh@wdc.com>
 <20200702155401.13322-2-aravind.ramesh@wdc.com>
 <20200707000722.GB2897553@google.com>
 <BY5PR04MB6995E03B6FE331FF0CDEE7AD8C660@BY5PR04MB6995.namprd04.prod.outlook.com>
 <20200707034947.GA3142230@google.com>
In-Reply-To: <20200707034947.GA3142230@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.109.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac795ebc-5a3b-4fd6-7ad6-08d822352187
x-ms-traffictypediagnostic: BYAPR04MB3973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3973AF3B7711F14BC183E8808C660@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRzByrJ++F5PJYAjWl0WV+ks035CXbDKXOSy/1rjuyC+TWlfp3Gf9XbscexlAUxB1Wxy/jn/HkVZRzaWaCNyCHsAs10uMcsQPAA8D8Zmak1MrTl1zcFaIYW7FFTY2LNiWhHHeqhKOWZqGRmK40EmuLpE7GDQMlx7mp5rS95q6AGyYEjM1HBRuxFW6vVvXswyMOk7NSSnzLOMvPlmzjVhiEIMy7uVHmmj3K8aPNvhjKj7wt8DEHQT3BjtQSLcZVnna0Va6Zaq4XGkih/U/wC/kk9BrUTQVEOlBr6hmCxH3r04wyLgWRk0cNEKTbM/hm0O9+M7IJT3XvGE3F1uDf6USdeUHoQMCPxogNLRscL18JQqXs9Kykqg+mSMqTJEYi8r35byBnY95JPx8eKchchFTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6995.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(6506007)(53546011)(7696005)(26005)(55236004)(186003)(52536014)(478600001)(966005)(83380400001)(2906002)(4326008)(8936002)(8676002)(6916009)(55016002)(33656002)(316002)(54906003)(9686003)(30864003)(66476007)(86362001)(66946007)(76116006)(71200400001)(66556008)(64756008)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LO3zHTbfyHHguaDVuJ4jMOIBeUTTPNLvKTUI4bRXpSDDnum4GV2eZAnz3IumV18HgtJlENdtBcnbvi8DAbmHwJOXexWQw2jH2RdKqzukwwfQ1n5oT92mEKPeDRbUqHaShJuHD6jkvUWYkEQ6EETTf+7lncm11Rc6faSBf/gBEgFU3MtYmRuglc7EE6rhTw0SCAsDeXBrFgY67iFM3X9OPIlzOnJ4fBvmWel8PyrVlfsJE4lYwyScm6PuV4RX77KVATHnpZfpBWzk0BYVFhlnlNbLlCOksryFI+UrFEMlfZc2R3/3BC7TvN6nZUrYce8UDBbeqtLbZh//RIrmOZXzX+WVkFvt8gpWU/4p6sUo/4HSgqv57Ph/dQm7XjfFf33Df7HdpF1LIgr+NUJ5YvdilnhLYd656a7+KAkk3wjmYc7uCS7ow9JxMh0UHlYGFBud28VmUoqsP1mLFQUGJtgY8GgN+2BFAH8P76vzkPDz8n90Hh6idju0gO8skuxqjMyD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6995.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac795ebc-5a3b-4fd6-7ad6-08d822352187
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 05:18:06.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvFz9MyWo1hQHCyP24Nfdvz4y1z2cE1i6qehLsirIslN8bmF+S6YnjQRlWQOxMHBazh+05Y0KmIRNMri/VKDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Jaegeuk.
The qemu patches to emulate ZNS devices is in the process of getting merged=
.
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05390.html
We can use this emulated ZNS drive along with a null-block device to create=
 a f2fs volume if physical ZNS device is not available.=20

Aravind

> -----Original Message-----
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Sent: Tuesday, July 7, 2020 9:20 AM
> To: Aravind Ramesh <Aravind.Ramesh@wdc.com>
> Cc: yuchao0@huawei.com; linux-fsdevel@vger.kernel.org; linux-f2fs-
> devel@lists.sourceforge.net; hch@lst.de; Damien Le Moal
> <Damien.LeMoal@wdc.com>; Niklas Cassel <Niklas.Cassel@wdc.com>; Matias
> Bjorling <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone size
>=20
> On 07/07, Aravind Ramesh wrote:
> > Hello Jaegeuk,
> >
> > I had mentioned the dependency in the cover letter for this patch, as b=
elow.
> >
> > This series is based on the git tree
> > git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git branch
> > dev
> >
> > and requires the below patch in order to build.
> >
> > https://lore.kernel.org/linux-nvme/20200701063720.GA28954@lst.de/T/#m1
> > 9e0197ae1837b7fe959b13fbc2a859b1f2abc1e
> >
> > The above patch has been merged to the nvme-5.9 branch in the git tree:
> > git://git.infradead.org/nvme.git
> >
> > Could you consider picking up that patch in your tree ?
> >
> > I have run checkpatch before sending this, it was ok. Ran it again.
>=20
> I see. I don't have any device, so have to rely on your tests as usual.
> Thank you for posting the patch, and will check any regression.
>=20
> >
> > f2fs$ scripts/checkpatch.pl
> > ./0001-f2fs-support-zone-capacity-less-than-zone-size.patch
> > total: 0 errors, 0 warnings, 289 lines checked
> >
> > ./0001-f2fs-support-zone-capacity-less-than-zone-size.patch has no obvi=
ous style
> problems and is ready for submission.
> >
> > Thanks,
> > Aravind
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Sent: Tuesday, July 7, 2020 5:37 AM
> > > To: Aravind Ramesh <Aravind.Ramesh@wdc.com>
> > > Cc: yuchao0@huawei.com; linux-fsdevel@vger.kernel.org; linux-f2fs-
> > > devel@lists.sourceforge.net; hch@lst.de; Damien Le Moal
> > > <Damien.LeMoal@wdc.com>; Niklas Cassel <Niklas.Cassel@wdc.com>;
> > > Matias Bjorling <Matias.Bjorling@wdc.com>
> > > Subject: Re: [PATCH 1/2] f2fs: support zone capacity less than zone
> > > size
> > >
> > > Hi,
> > >
> > > Is there any dependency to the patch? And, could you please run check=
patch
> script?
> > >
> > > Thanks,
> > >
> > > On 07/02, Aravind Ramesh wrote:
> > > > NVMe Zoned Namespace devices can have zone-capacity less than zone-=
size.
> > > > Zone-capacity indicates the maximum number of sectors that are
> > > > usable in a zone beginning from the first sector of the zone. This
> > > > makes the sectors sectors after the zone-capacity till zone-size to=
 be unusable.
> > > > This patch set tracks zone-size and zone-capacity in zoned devices
> > > > and calculate the usable blocks per segment and usable segments per=
 section.
> > > >
> > > > If zone-capacity is less than zone-size mark only those segments
> > > > which start before zone-capacity as free segments. All segments at
> > > > and beyond zone-capacity are treated as permanently used segments.
> > > > In cases where zone-capacity does not align with segment size the
> > > > last segment will start before zone-capacity and end beyond the
> > > > zone-capacity of the zone. For such spanning segments only sectors
> > > > within the
> > > zone-capacity are used.
> > > >
> > > > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > > > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > ---
> > > >  fs/f2fs/f2fs.h    |   5 ++
> > > >  fs/f2fs/segment.c | 136
> > > ++++++++++++++++++++++++++++++++++++++++++++--
> > > >  fs/f2fs/segment.h |   6 +-
> > > >  fs/f2fs/super.c   |  41 ++++++++++++--
> > > >  4 files changed, 176 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> > > > e6e47618a357..73219e4e1ba4 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -1232,6 +1232,7 @@ struct f2fs_dev_info {  #ifdef
> > > > CONFIG_BLK_DEV_ZONED
> > > >  	unsigned int nr_blkz;		/* Total number of zones */
> > > >  	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
> > > > +	block_t *zone_capacity_blocks;  /* Array of zone capacity in
> > > > +blks */
> > > >  #endif
> > > >  };
> > > >
> > > > @@ -3395,6 +3396,10 @@ void
> > > > f2fs_destroy_segment_manager_caches(void);
> > > >  int f2fs_rw_hint_to_seg_type(enum rw_hint hint);  enum rw_hint
> > > > f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> > > >  			enum page_type type, enum temp_type temp);
> > > > +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > > > +			unsigned int segno);
> > > > +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > > > +			unsigned int segno);
> > > >
> > > >  /*
> > > >   * checkpoint.c
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
> > > > c35614d255e1..d2156f3f56a5 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -4294,9 +4294,12 @@ static void init_free_segmap(struct
> > > > f2fs_sb_info *sbi)  {
> > > >  	unsigned int start;
> > > >  	int type;
> > > > +	struct seg_entry *sentry;
> > > >
> > > >  	for (start =3D 0; start < MAIN_SEGS(sbi); start++) {
> > > > -		struct seg_entry *sentry =3D get_seg_entry(sbi, start);
> > > > +		if (f2fs_usable_blks_in_seg(sbi, start) =3D=3D 0)
> > > > +			continue;
> > > > +		sentry =3D get_seg_entry(sbi, start);
> > > >  		if (!sentry->valid_blocks)
> > > >  			__set_free(sbi, start);
> > > >  		else
> > > > @@ -4316,7 +4319,7 @@ static void init_dirty_segmap(struct f2fs_sb_=
info
> *sbi)
> > > >  	struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> > > >  	struct free_segmap_info *free_i =3D FREE_I(sbi);
> > > >  	unsigned int segno =3D 0, offset =3D 0, secno;
> > > > -	unsigned short valid_blocks;
> > > > +	unsigned short valid_blocks, usable_blks_in_seg;
> > > >  	unsigned short blks_per_sec =3D BLKS_PER_SEC(sbi);
> > > >
> > > >  	while (1) {
> > > > @@ -4326,9 +4329,10 @@ static void init_dirty_segmap(struct f2fs_sb=
_info
> *sbi)
> > > >  			break;
> > > >  		offset =3D segno + 1;
> > > >  		valid_blocks =3D get_valid_blocks(sbi, segno, false);
> > > > -		if (valid_blocks =3D=3D sbi->blocks_per_seg || !valid_blocks)
> > > > +		usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, segno);
> > > > +		if (valid_blocks =3D=3D usable_blks_in_seg || !valid_blocks)
> > > >  			continue;
> > > > -		if (valid_blocks > sbi->blocks_per_seg) {
> > > > +		if (valid_blocks > usable_blks_in_seg) {
> > > >  			f2fs_bug_on(sbi, 1);
> > > >  			continue;
> > > >  		}
> > > > @@ -4678,6 +4682,101 @@ int f2fs_check_write_pointer(struct
> > > > f2fs_sb_info *sbi)
> > > >
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zo=
ne_idx,
> > > > +						unsigned int dev_idx)
> > > > +{
> > > > +	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
> > > > +		return true;
> > > > +	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq); }
> > > > +
> > > > +/* Return the zone index in the given device */ static unsigned
> > > > +int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
> > > > +					int dev_idx)
> > > > +{
> > > > +	block_t sec_start_blkaddr =3D START_BLOCK(sbi,
> > > > +GET_SEG_FROM_SEC(sbi, secno));
> > > > +
> > > > +	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
> > > > +						sbi->log_blocks_per_blkz;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Return the usable segments in a section based on the zone's
> > > > + * corresponding zone capacity. Zone is equal to a section.
> > > > + */
> > > > +static inline unsigned int f2fs_usable_zone_segs_in_sec(
> > > > +		struct f2fs_sb_info *sbi, unsigned int segno) {
> > > > +	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
> > > > +
> > > > +	dev_idx =3D f2fs_target_device_index(sbi, START_BLOCK(sbi, segno)=
);
> > > > +	zone_idx =3D get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno),
> > > > +dev_idx);
> > > > +
> > > > +	/* Conventional zone's capacity is always equal to zone size */
> > > > +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > > > +		return sbi->segs_per_sec;
> > > > +
> > > > +	/*
> > > > +	 * If the zone_capacity_blocks array is NULL, then zone capacity
> > > > +	 * is equal to the zone size for all zones
> > > > +	 */
> > > > +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > > > +		return sbi->segs_per_sec;
> > > > +
> > > > +	/* Get the segment count beyond zone capacity block */
> > > > +	unusable_segs_in_sec =3D (sbi->blocks_per_blkz -
> > > > +				FDEV(dev_idx).zone_capacity_blocks[zone_idx])
> > > >>
> > > > +				sbi->log_blocks_per_seg;
> > > > +	return sbi->segs_per_sec - unusable_segs_in_sec; }
> > > > +
> > > > +/*
> > > > + * Return the number of usable blocks in a segment. The number of
> > > > +blocks
> > > > + * returned is always equal to the number of blocks in a segment
> > > > +for
> > > > + * segments fully contained within a sequential zone capacity or
> > > > +a
> > > > + * conventional zone. For segments partially contained in a
> > > > +sequential
> > > > + * zone capacity, the number of usable blocks up to the zone
> > > > +capacity
> > > > + * is returned. 0 is returned in all other cases.
> > > > + */
> > > > +static inline unsigned int f2fs_usable_zone_blks_in_seg(
> > > > +			struct f2fs_sb_info *sbi, unsigned int segno) {
> > > > +	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
> > > > +	unsigned int zone_idx, dev_idx, secno;
> > > > +
> > > > +	secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > > > +	seg_start =3D START_BLOCK(sbi, segno);
> > > > +	dev_idx =3D f2fs_target_device_index(sbi, seg_start);
> > > > +	zone_idx =3D get_zone_idx(sbi, secno, dev_idx);
> > > > +
> > > > +	/*
> > > > +	 * Conventional zone's capacity is always equal to zone size,
> > > > +	 * so, blocks per segment is unchanged.
> > > > +	 */
> > > > +	if (is_conv_zone(sbi, zone_idx, dev_idx))
> > > > +		return sbi->blocks_per_seg;
> > > > +
> > > > +	if (!FDEV(dev_idx).zone_capacity_blocks)
> > > > +		return sbi->blocks_per_seg;
> > > > +
> > > > +	sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secn=
o));
> > > > +	sec_cap_blkaddr =3D sec_start_blkaddr +
> > > > +				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
> > > > +
> > > > +	/*
> > > > +	 * If segment starts before zone capacity and spans beyond
> > > > +	 * zone capacity, then usable blocks are from seg start to
> > > > +	 * zone capacity. If the segment starts after the zone capacity,
> > > > +	 * then there are no usable blocks.
> > > > +	 */
> > > > +	if (seg_start >=3D sec_cap_blkaddr)
> > > > +		return 0;
> > > > +	if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
> > > > +		return sec_cap_blkaddr - seg_start;
> > > > +
> > > > +	return sbi->blocks_per_seg;
> > > > +}
> > > >  #else
> > > >  int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)  { @@
> > > > -4688,7 +4787,36 @@ int f2fs_check_write_pointer(struct
> > > > f2fs_sb_info
> > > > *sbi)  {
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2f=
s_sb_info
> *sbi,
> > > > +							unsigned int segno)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2f=
s_sb_info
> *sbi,
> > > > +							unsigned int segno)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > >  #endif
> > > > +unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > > > +					unsigned int segno)
> > > > +{
> > > > +	if (f2fs_sb_has_blkzoned(sbi))
> > > > +		return f2fs_usable_zone_blks_in_seg(sbi, segno);
> > > > +
> > > > +	return sbi->blocks_per_seg;
> > > > +}
> > > > +
> > > > +unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > > > +					unsigned int segno)
> > > > +{
> > > > +	if (f2fs_sb_has_blkzoned(sbi))
> > > > +		return f2fs_usable_zone_segs_in_sec(sbi, segno);
> > > > +
> > > > +	return sbi->segs_per_sec;
> > > > +}
> > > >
> > > >  /*
> > > >   * Update min, max modified time for cost-benefit GC algorithm
> > > > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index
> > > > f261e3e6a69b..79b0dc33feaf 100644
> > > > --- a/fs/f2fs/segment.h
> > > > +++ b/fs/f2fs/segment.h
> > > > @@ -411,6 +411,7 @@ static inline void __set_free(struct
> > > > f2fs_sb_info *sbi,
> > > unsigned int segno)
> > > >  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > > >  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> > > >  	unsigned int next;
> > > > +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> > > >
> > > >  	spin_lock(&free_i->segmap_lock);
> > > >  	clear_bit(segno, free_i->free_segmap); @@ -418,7 +419,7 @@
> > > > static inline void __set_free(struct f2fs_sb_info *sbi, unsigned
> > > > int segno)
> > > >
> > > >  	next =3D find_next_bit(free_i->free_segmap,
> > > >  			start_segno + sbi->segs_per_sec, start_segno);
> > > > -	if (next >=3D start_segno + sbi->segs_per_sec) {
> > > > +	if (next >=3D start_segno + usable_segs) {
> > > >  		clear_bit(secno, free_i->free_secmap);
> > > >  		free_i->free_sections++;
> > > >  	}
> > > > @@ -444,6 +445,7 @@ static inline void __set_test_and_free(struct
> > > > f2fs_sb_info
> > > *sbi,
> > > >  	unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > > >  	unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> > > >  	unsigned int next;
> > > > +	unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> > > >
> > > >  	spin_lock(&free_i->segmap_lock);
> > > >  	if (test_and_clear_bit(segno, free_i->free_segmap)) { @@ -453,7
> > > > +455,7 @@ static inline void __set_test_and_free(struct
> > > > +f2fs_sb_info *sbi,
> > > >  			goto skip_free;
> > > >  		next =3D find_next_bit(free_i->free_segmap,
> > > >  				start_segno + sbi->segs_per_sec, start_segno);
> > > > -		if (next >=3D start_segno + sbi->segs_per_sec) {
> > > > +		if (next >=3D start_segno + usable_segs) {
> > > >  			if (test_and_clear_bit(secno, free_i->free_secmap))
> > > >  				free_i->free_sections++;
> > > >  		}
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> > > > 80cb7cd358f8..2686b07ae7eb 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -1164,6 +1164,7 @@ static void destroy_device_list(struct f2fs_s=
b_info
> *sbi)
> > > >  		blkdev_put(FDEV(i).bdev, FMODE_EXCL);  #ifdef
> > > CONFIG_BLK_DEV_ZONED
> > > >  		kvfree(FDEV(i).blkz_seq);
> > > > +		kvfree(FDEV(i).zone_capacity_blocks);
> > > >  #endif
> > > >  	}
> > > >  	kvfree(sbi->devs);
> > > > @@ -3039,13 +3040,26 @@ static int init_percpu_info(struct
> > > > f2fs_sb_info *sbi)  }
> > > >
> > > >  #ifdef CONFIG_BLK_DEV_ZONED
> > > > +
> > > > +struct f2fs_report_zones_args {
> > > > +	struct f2fs_dev_info *dev;
> > > > +	bool zone_cap_mismatch;
> > > > +};
> > > > +
> > > >  static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int=
 idx,
> > > > -			       void *data)
> > > > +			      void *data)
> > > >  {
> > > > -	struct f2fs_dev_info *dev =3D data;
> > > > +	struct f2fs_report_zones_args *rz_args =3D data;
> > > > +
> > > > +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > > > +		return 0;
> > > > +
> > > > +	set_bit(idx, rz_args->dev->blkz_seq);
> > > > +	rz_args->dev->zone_capacity_blocks[idx] =3D zone->capacity >>
> > > > +						F2FS_LOG_SECTORS_PER_BLOCK;
> > > > +	if (zone->len !=3D zone->capacity && !rz_args->zone_cap_mismatch)
> > > > +		rz_args->zone_cap_mismatch =3D true;
> > > >
> > > > -	if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > > > -		set_bit(idx, dev->blkz_seq);
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -3053,6 +3067,7 @@ static int init_blkz_info(struct
> > > > f2fs_sb_info *sbi, int devi)  {
> > > >  	struct block_device *bdev =3D FDEV(devi).bdev;
> > > >  	sector_t nr_sectors =3D bdev->bd_part->nr_sects;
> > > > +	struct f2fs_report_zones_args rep_zone_arg;
> > > >  	int ret;
> > > >
> > > >  	if (!f2fs_sb_has_blkzoned(sbi))
> > > > @@ -3078,12 +3093,26 @@ static int init_blkz_info(struct
> > > > f2fs_sb_info *sbi, int
> > > devi)
> > > >  	if (!FDEV(devi).blkz_seq)
> > > >  		return -ENOMEM;
> > > >
> > > > -	/* Get block zones type */
> > > > +	/* Get block zones type and zone-capacity */
> > > > +	FDEV(devi).zone_capacity_blocks =3D f2fs_kzalloc(sbi,
> > > > +					FDEV(devi).nr_blkz * sizeof(block_t),
> > > > +					GFP_KERNEL);
> > > > +	if (!FDEV(devi).zone_capacity_blocks)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	rep_zone_arg.dev =3D &FDEV(devi);
> > > > +	rep_zone_arg.zone_cap_mismatch =3D false;
> > > > +
> > > >  	ret =3D blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_z=
one_cb,
> > > > -				  &FDEV(devi));
> > > > +				  &rep_zone_arg);
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > >
> > > > +	if (!rep_zone_arg.zone_cap_mismatch) {
> > > > +		kvfree(FDEV(devi).zone_capacity_blocks);
> > > > +		FDEV(devi).zone_capacity_blocks =3D NULL;
> > > > +	}
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  #endif
> > > > --
> > > > 2.19.1
