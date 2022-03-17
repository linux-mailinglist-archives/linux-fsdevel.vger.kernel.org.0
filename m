Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937904DC494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiCQLOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiCQLOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:14:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A7ABF47;
        Thu, 17 Mar 2022 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647515598; x=1679051598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yUA8asYcx7d/5wUdrrH+aPLbPKwfgFjX7XcFnP97up4=;
  b=DQoVZ7z1v44JdWlwk73Dvu4rdtJeXmcKmj0FTTcg0uv82qRLLg0uMQFu
   3U1sTYuH08HUD0Ief8vq5lw8Xdgi7QD999IPOWbmNOCGjGax0OL86d6eZ
   ltC+umtNu/8ZryhUEs6Il9sJDVtMT4N4jcl5aCpogfIYSWuLpYdLevP+W
   vvoCr+HtzJJGZBgG2j/qf8evGi1icPdffX11IjNpn8kMRuzBkrHfig13L
   ByeN7sReMS95BBhcb3UyHWAOhH5cSsRlHH+QKdSsdt1yekP8r2HPL6mKB
   Aj/c2co7xB+zxUbZIfAqvu/Ye8yJLiu1DwVdCrqWtgYyIzTgjaQ0EhYAB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,188,1643644800"; 
   d="scan'208";a="196529987"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 19:13:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irN+7AZk0z73rXSF6X0nCHpq0DtjlwKeOv0AXVvuuXqZTy7SEro1tMOO5cpzJAYOAsf+3kPDJNuRoN1ysynCELZE6vOTknYk3V5Ri4GxBR8WIHbwY+9cqKUwmVbvMoDocDQN1MRPjeA8v7heBQ5hZAaqy7jnDznts5yETqIdnl9pT0HLrb6g1g25cBqFW3TOxq617w7L/z2/xV/l/56KkdXF/+Yo5ndeBOvQr88IrEcFb19A/PHRXc0yXgK9T/Zzb9n4JcSWiCvENf8aizH1g9xm6zJGvIUGoEd78EJDmJMXbqdutcuwdBQK24GzWXvJ15TpqIyErjSreQ9EbE34jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9l/elPISwXWkNva3uck3M4wJk3AcEB1UNdzWnMjt4I=;
 b=CUX3J7PU/gUq4Y72Ygc6mTNXT2YF2nnKhWk4A+QsnvJin70EUzjt+ze/B0TgppEOjdpiFimiLiTm78zvMkk+r1QeEfyd5qj2dXninefaTGAG2RuD9T/UxUB/b7y6rYw7Lmdsy4XTuaYh4S7MX0X2ZDOPtQITbPkbjWlVvqEQ8lmVQfJ8KuwKdx34mlQaRnnWUBu8UuASfjN2WvWZ2FgkXcVC2y9m7820NaICxL19LvVjZckwtx0KUm/5DYAGi1WcHwKxqJuhpX1yuKXHaSbHiwjOh5IoVRF9DDx/Q0amS9xXslyit5LAGDQxZTjVK4m3ZtSLUFI+FXahvgA8xNgX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9l/elPISwXWkNva3uck3M4wJk3AcEB1UNdzWnMjt4I=;
 b=cswjnPNjJYQsqWWiSVfqGpnMWc0xA6fq3/6hPtgfCpWWuoABs1X4PPAcmfA0dePhLLvCsJtmwAeM3QuslNkZBaodsHJ2XM4FDH/4jnjQh9R+hSbToDd7oPWotwwA5fsNhDOoo1STJxEr3qVby2LqFHHTM/poZNueESWxSYQ2L5I=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8329.namprd04.prod.outlook.com (2603:10b6:303:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 17 Mar
 2022 11:13:07 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:13:07 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 3/4] fs: add check functions for
 sb_start_{write,pagefault,intwrite}
Thread-Topic: [PATCH v2 3/4] fs: add check functions for
 sb_start_{write,pagefault,intwrite}
Thread-Index: AQHYOTj/5+ga/Ksn+E+blZR2k5+Mx6zDQSUAgAAsXAA=
Date:   Thu, 17 Mar 2022 11:13:07 +0000
Message-ID: <20220317111306.gpunvfyuvadgguyq@naota-xeon>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <0737603ecc6baf785843d6e91992e6ef202c308c.1647436353.git.naohiro.aota@wdc.com>
 <20220317083420.GA1544202@dread.disaster.area>
In-Reply-To: <20220317083420.GA1544202@dread.disaster.area>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fdd2ad2-34d6-4edf-7824-08da08071d50
x-ms-traffictypediagnostic: CO6PR04MB8329:EE_
x-microsoft-antispam-prvs: <CO6PR04MB8329E27E861177B899B356E08C129@CO6PR04MB8329.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMEMj7ef6e98TCl5GV+7tXIarMpzjDR64YOj3xu9NmpCskYY0Ly8PacU5vMx7VCL2I+FahKGpWdxMUU1/4pDXFrUL5EuguyC8YChCLPXXoN/cmD1vHMYixf7zHqdxRgyxGyENVZKI8lZqza+XOMiULD2hjaj4CT6Fb3hdUaj46GvoYvezcinSIW0TRJYyY05O3sr/Egbzv5El2/aLxlH4/41598JuPEJmcytw6o6pBqcTffZ+TXNTNDo4/VMpxoU9FG3oLt6mCvKTy48f0Vk1iLpRFmJSW7Q23vlZbQQZybSCrw+ZcVBo8bfROlxd1hQOtsyHJr6vfb/4mAxR3xfliGW4suMH+mL2fH+TSM/FS8Q0JYM/rnmX9vPMe2JbT9OCrac7I3etdm878ahqc19Gq9RPfDXASzkSEphnkmBvjGlxnAaHfOuLrXkBFki9/5U34kXS4MRkCaMyAEMyI4Fmng+p37IH/ltPRxPYnd4tIgBPpAg/w5N7O2mucm6KjkjAa4CfB2f4+TKxCqZhfmHhUTfEaZql5B/m49bzY7TMRdwC+vrEqeBPYZiUpN0rq/DymWO0qXf03QHUVS49tbjyRHzc+i2eLfxwHEC3XYUM/8ueInAySdpgdEDStSVyP1cP7puv8f+jRRCX1li/BovqfY5LfB1+Xsz/zlBUt87ny7UkvgiElki+VJq3SfRMdmkoRUdrG7ZPVd3LoJbl4268Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66946007)(54906003)(83380400001)(8676002)(6506007)(64756008)(91956017)(76116006)(33716001)(66446008)(66556008)(9686003)(6512007)(508600001)(66476007)(4326008)(6486002)(71200400001)(26005)(86362001)(6916009)(316002)(186003)(1076003)(8936002)(38070700005)(3716004)(2906002)(38100700002)(82960400001)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hjdfpeQMj1jrAMGDcZF7D0slz6hgIjUrWzHmURE/Irq+vjUdMTAvU88feNRe?=
 =?us-ascii?Q?n2Xw5AStpwzGf9krpp/Yq/iKJsx6VKpEc7t257YNVPJr9NBOraH7qTCYDPbT?=
 =?us-ascii?Q?wtslLFX6zWm6oingLFbEE3QZe1tdA8BB39QIjJXAc/Ycb6H/VEoRFhgnxkhf?=
 =?us-ascii?Q?JHHI+WAo/Ubgwoc4HQfzkUGNIVyu7nRnL4hmVOKu8nWHS+ikzvzsY8Wxr130?=
 =?us-ascii?Q?l2JmYh/QnbhiNSEWlBrf4z7rnh2GnDWwx2Mr14MLiAa4hc1V5uZ7vEQ3rukd?=
 =?us-ascii?Q?f6+5lenkpzrXVMDTfWM/FHqkT+3U70j9Attvs23Fjm6ioMa80lf5WRSlIXuY?=
 =?us-ascii?Q?e3bQEpknys9JP2KC8/AxzWGQ0Kh5WYMuXfIblxgYSvzfUGliZLD8zji8xq9N?=
 =?us-ascii?Q?p26wtfSusqhU88h4cc/bXFpxRtOmGFNRpK1Ibw6BzD/vOL6ULQoGtMYiuOg7?=
 =?us-ascii?Q?ujrBn9korR0Vy1w+d5OYh0h+4mQxPXDKijcEQF1lFzZ5GAE7EgTY+vjTxkll?=
 =?us-ascii?Q?E0HCQox3hLu4BgL9ruevgjvgYwYc/nHouA2N2c3kD2nAKCYWKe0+EKA4VtFk?=
 =?us-ascii?Q?vyYadTG47y1SPJfe++foFIaQnnBWocSSlMPMmYbbJJDgkEJH/1cmt0lrp8ZK?=
 =?us-ascii?Q?UY/Mq8bw3qjr6Amnzy3YzEc4st+8zHH425WTZXnvaSEF29FHNREWW9UrgrNw?=
 =?us-ascii?Q?M3sPt1dBZHO28bI63bX1Gm11Qq2A9Sfds0QLIsMycCS0ij05+sMTwFQ7uTze?=
 =?us-ascii?Q?pk5IJCt8SdW/Bz4WCVAvxNnqzdnr75LxVoI/2L2ZVbCrOVhO1VlIA/Kc2U47?=
 =?us-ascii?Q?+ZjTjsmrhT7Jyd0qTuPIltYCQCkNJbJCp9ckjNYCmLyNrQVIrzpQ8xu9nhjk?=
 =?us-ascii?Q?fVrCi2YkN0X8ftvBatulhrvIcIwjbRLlP1Ay+CF9ujfXFA724/gan4tndKHw?=
 =?us-ascii?Q?eOAyF0HWSvSSQ74vwSW1rjRY93eCWCRZV5CZO/iDmzIqX7IDi0grBbJJpp5N?=
 =?us-ascii?Q?6meif+tpA6ADiJloUmpaJ8w44Gf4bJhK3gwWZzusspwts05uzOLIEMZbag7J?=
 =?us-ascii?Q?Jzocv8A3B3l10GrJcfp/3zdlM1DH4PhmIwtc5qDT8rxzCTZaDpN2VABSrCI0?=
 =?us-ascii?Q?UkEsgOChBkuSK8SbfP1co8IsG2An0L+UwpBVXOFyEhRC1dPqrRThq9m2y6TL?=
 =?us-ascii?Q?B0yFrHjVbEWkx1Bx3uVxtqB52HIgRk+6OYeK5x7dVy621U8+oF82RdA29Rhc?=
 =?us-ascii?Q?a81iEC/prAwRLFGltzc8pAZXT4Gbszwz/fCHX3q5JKnRtOe3lLsWJH4Am6Kp?=
 =?us-ascii?Q?C41z80J+ESpGVmcxbAzoHQjK3QXZ4yWpRFuaM50B+Ye8dPE1zuTjZH3akOs0?=
 =?us-ascii?Q?tOUvKiVRO4tuGinv2S/tqHovOr3h4DQDb7ic4G/i/77bXLfUvG/JBDLpXPHk?=
 =?us-ascii?Q?mScGKPoqXa49pSLAQ3+XHGiK/AP33KOaa5ZgIGohPuxgmVlpCX9hTAwuAh+H?=
 =?us-ascii?Q?JYASTPyHFj0bePlgJXkdkWf7NmV5Ds42OjvrOcht9tvBA09426mTuCj9PW4S?=
 =?us-ascii?Q?F9OnIJ8IMi3G6Hp9nIKk8T+OuQ1fmOSxP0SPYCIgUc54yCNkxhN9OnFSd7nX?=
 =?us-ascii?Q?IeKm6AEtOgbce5jHbLp/Sys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <926F0169D5A4CA4D9CBB257470CAADAB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdd2ad2-34d6-4edf-7824-08da08071d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 11:13:07.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkdUyEJyYhrqJmhq94amOPk779N0LLQe/JD1LykBhtofuYPWbaSn8KnM5VV5eZlg63mN9mxriKleX4eHNliONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8329
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:34:20PM +1100, Dave Chinner wrote:
> On Wed, Mar 16, 2022 at 10:22:39PM +0900, Naohiro Aota wrote:
> > Add a function sb_write_started() to return if sb_start_write() is
> > properly called. It is used in the next commit.
> >=20
> > Also, add the similar functions for sb_start_pagefault() and
> > sb_start_intwrite().
> >=20
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  include/linux/fs.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 27746a3da8fd..0c8714d64169 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1732,6 +1732,11 @@ static inline bool __sb_start_write_trylock(stru=
ct super_block *sb, int level)
> >  #define __sb_writers_release(sb, lev)	\
> >  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
> > =20
> > +static inline bool __sb_write_started(struct super_block *sb, int leve=
l)
> > +{
> > +	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> > +}
> > +
> >  /**
> >   * sb_end_write - drop write access to a superblock
> >   * @sb: the super we wrote to
> > @@ -1797,6 +1802,11 @@ static inline bool sb_start_write_trylock(struct=
 super_block *sb)
> >  	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
> >  }
> > =20
> > +static inline bool sb_write_started(struct super_block *sb)
> > +{
> > +	return __sb_write_started(sb, SB_FREEZE_WRITE);
> > +}
> > +
> >  /**
> >   * sb_start_pagefault - get write access to a superblock from a page f=
ault
> >   * @sb: the super we write to
> > @@ -1821,6 +1831,11 @@ static inline void sb_start_pagefault(struct sup=
er_block *sb)
> >  	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
> >  }
> > =20
> > +static inline bool sb_pagefault_started(struct super_block *sb)
> > +{
> > +	return __sb_write_started(sb, SB_FREEZE_PAGEFAULT);
> > +}
> > +
> >  /**
> >   * sb_start_intwrite - get write access to a superblock for internal f=
s purposes
> >   * @sb: the super we write to
> > @@ -1844,6 +1859,11 @@ static inline bool sb_start_intwrite_trylock(str=
uct super_block *sb)
> >  	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
> >  }
> > =20
> > +static inline bool sb_intwrite_started(struct super_block *sb)
> > +{
> > +	return __sb_write_started(sb, SB_FREEZE_FS);
> > +}
> > +
> >  bool inode_owner_or_capable(struct user_namespace *mnt_userns,
> >  			    const struct inode *inode);
> > =20
>=20
> We should not be adding completely unused code to the VFS APIs.
>=20
> Just rename __sb_write_started() to sb_write_started() and pass
> SB_FREEZE_WRITE directly from the single debug assert that you've
> added that needs this check.

Sure, I will drop them in the next version. I just added them for
completeness.

> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com=
