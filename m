Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A408E5AD4D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiIEOcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 10:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiIEOb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:31:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6254D17D;
        Mon,  5 Sep 2022 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662388318; x=1693924318;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/B/dXdMFzHUL8EPNqyrtXVO/u7P79k7+dFNBua2Hnrg=;
  b=bOoRhKcDkqSWyufY8rq0ThgXcJxcYnt5SNaECXtm9xou2ifi4TNjEGvE
   FmtZnbeV8xuGW1HzaLWml//5+8rafPHYizFsNP96Bn6LqAB6mWE3ISK56
   Jildb/C06vqn0jOL0JqCVOata+Jvd2NwRRo/I/pe1fbD+O5lUNkBMPY4E
   LJ5ilQBnThmtRIHha416ce0o5Zv6zVGlND4wLY6ZTu4uWR6CNJH9sdXVx
   6hRQsULNMrYIsT/z0f6cRiHmNffn4WabUaQBgUTcn16CjWmrRh4n0MUWi
   b6C/jUA2q8Fcw6guOS2+d/7UqzFhg/zMdWWNcQSIAuxCVSDuoxpIT/PxN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="215702176"
Received: from mail-mw2nam04lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 22:31:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkpIJCn/OW3LxHvdksrIm0x/eFK8JTy3tOUz/qJCj2Xpz9btW9QnCdkH1djdosCuzulR+KUEN1iBFBowHX/jtQfsqzcDpYLBUNNWxNnUg2uRW4o4dCopqCWyuTTZbmS4n8ejN0GPfPsgV+NLPlpdHAEPf7ExSBQe+0kcpaX6WpfB5M6D7S1sb4DmbV7sJn5W1piPnf85UkBnF9VnB5n7rxiedq5j7L+HM5Ald7c9Kd99vKu7XvWwkYoyceT/lzZcZMGz3cKhwTynWz0fzMRCyytHQnm/5/Bhq/vXWJRDTC3bTyryDuw6Pg7PXhLgoWi4qO8RFV+NHWEBZ1evfcJxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sFFvuamq9F+KQm+bL8+pH2ng3x6rV9AUyqoxc35UTs=;
 b=cIxpeztvMhYivDi1e786DtvvMcwaEE05vYKd3OLVK0K1BWBiMuhAxrNXzf/fJ0B+UHnHwSAmAIXHvH7jQG6EBonAyMntscf97DWPgHdsG7d5+k+mMb6JcL5eXVKgqCoVvw/oCzHmpiYO9lrAOspRSBOTIorgEfUav2qCEyJv7fyzf8hwRNt4WfLi16nrh354FjzhHRSOFzuVg52tq9wvbhVXAS8Q+TOMpd6Mp9CGQaj8ew/ucJVmK0NWtBNFM1FI5rhHD56DXWSgG1hhE67IZvDSCG+7cbcFGbBIIUAl56uJ0XgWlq/HTHXAVT2NXjjbwR5mtK7OZ9vMeBf21F3Smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sFFvuamq9F+KQm+bL8+pH2ng3x6rV9AUyqoxc35UTs=;
 b=AjjAHF7oOKYmvTkOthdcjEl+E7lTHPKU5wBfz2o/EYPUcZU+4YXCSm48DYIvNwUEOw7XfFoS/k1dnU50Es1N1wX9YWT+Oukqr4qsH7Mr5/mpjJvxn5j4ZENYn5S/cGxeQpYrjlbZrUglcWS50Ysct8nXcY9bkD4nnIOQJPhcgCI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5765.namprd04.prod.outlook.com (2603:10b6:a03:10b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 14:31:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 14:31:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Topic: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Index: AQHYvdaJyAEeDCU+DUSQMj+EHyZpYA==
Date:   Mon, 5 Sep 2022 14:31:53 +0000
Message-ID: <PH0PR04MB7416B4597F2F3426A85295A49B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-17-hch@lst.de>
 <PH0PR04MB74166908EB6DF6C586B5AC539B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220905142543.GA5262@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f89977-97a2-4286-d193-08da8f4b6107
x-ms-traffictypediagnostic: BYAPR04MB5765:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4RseODsIgsNvEyn0dwcrrvnll4ccTzgUlq7HEYFzuq2/MZSm2utyMA2VrtGtxh1Y7WbCH28inxaTQKNoXwH0amDPr2F/gTi4xgSczfD0tWUSzp1JlQNxXZJK9xLk1PlzzqhtqpEgmFBqzaa3EanFDlj3E1ikLZQiv9zA00TW+YyUNhm0c9dT5dSG1ZpCD+a/z0D5cwX/fCYF7x+Eg52vTDlXrukbOAjX+lZFGWG6gjfXWgwEr2lI+oeT6PTuZoBRKpI23+aO+p+4X3GwVgvwzShoV9vZtY1e3MFWgu/EtsogZNS6E9irguf8SRiwUxYWBcS1V3FxYnBbnQKy4Pa7Sp/07C/TSgQqN1pSZRfJUBqQ3La9mTsK3x6b8vkawKrxsLBd0n5n+DvvDjPqmBZFw0o0F7BO/R2xqaY+XAUlDkWIk6vcpU9QyaMCTEK/rNAcHE2CLVKloZOKwdtBoZohk8VE2n9nC78TbHIf1D6Nt1FyU1+NIn8570p0sMiyjkPMc87uf9yXk3A8PeEBMIfAy+D+EsdkRmiGC4ARNnImpanbP7eFoAaElM0ts9oSSDv0qtE1JVCRjnKtKnUtpljgmd6rHtnVAO3yV2VgtQB8k1d2lKk81fxN9H4lZiBSk3vv/K/gj6GD0OmROPLifY6woTIVSb2l9HORDhU4lwxJIJp3cIbK3FhLu/EChKj0hErgpNNfjWgP7KQqFA0C3m5Om6L5d/pcGUa5aCPau6yfZ6uYnoowlWa1LczMZ8qReaczYl9QNNsf7mgVzGvVyy3+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(55016003)(76116006)(186003)(71200400001)(9686003)(41300700001)(6506007)(478600001)(7696005)(66446008)(53546011)(122000001)(83380400001)(7416002)(8936002)(38070700005)(86362001)(5660300002)(38100700002)(52536014)(2906002)(33656002)(6916009)(45080400002)(316002)(91956017)(66556008)(82960400001)(66476007)(66946007)(54906003)(8676002)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X7W46MTmn5ZVPCyl6jmC40cmT563mJzk451emPDty4GuDikK3CvH+NLFzUb7?=
 =?us-ascii?Q?uYGuCJR97MwoB0Bw2oIB3NZdAt1pGENgpWRl73EYkiAmrBQMFnaZC2J8I5fV?=
 =?us-ascii?Q?y+7/THDbtNKb/1hXGA2f+DjlUUyWNGRuXqT69AxhRH+T1DglqBnazWfSmA7z?=
 =?us-ascii?Q?e8V/9PUuSmVsPOv2uofEwksbqmhwtZcic57xl5+P7STCZ5RUSCeAVgV3XFwu?=
 =?us-ascii?Q?YpTHvILIj/YkhDbL6i/YUS05PqdfPBDTWuZuQk9l9Kk0gM4YqtRdbkLW+ee/?=
 =?us-ascii?Q?YY49NokHel6JPths3QleckY92DPpfco+r0IskgzwsJHDIWWpjOtyh5kZBoRg?=
 =?us-ascii?Q?qBzU6xPZNOshcY1LEFthpx47I5hGHLGy0qjsir6hku2P4wQ8JJkbyXoL+xbE?=
 =?us-ascii?Q?MQP19gpvLSxYT0bnj5xk3o8ONkHEbA7ECajHFfTGzJhS/A0XfY+NQmcVO0kq?=
 =?us-ascii?Q?XbCN8X2PdnZHmMu6UnHl8r3E7jWTp4x8UE6sffXo93SUkOzW64N14H7Yae7V?=
 =?us-ascii?Q?wvsbfu40K/ihT+HIHmB3P8KmXcUyYdjeD+cyxNxtiGGspB24yooBpDf5/77q?=
 =?us-ascii?Q?mJJkM+i+7d2qEaQyo6o4Ej9/SxIMEndaobUNiFdch+Ye4ifZKKpXhQo89PT2?=
 =?us-ascii?Q?3QHXTc+T3YJtxeSUJOQgrT0U+d8kkuF2biQ5MN1XaXjFeK9dEm5Z1RkniSL7?=
 =?us-ascii?Q?NDupyfXyeWc3KmU5Yku40S/TuSkJjN6MZtdAGYtGXZfay690jMdhRQssFWyz?=
 =?us-ascii?Q?e1IT5yDZImYYjBhCEAcqo7S4o/DnQiHEP4qHvHkfstOUsMRvognMsxcxNHA4?=
 =?us-ascii?Q?2t/i2vv0MuNOHBOyVoHF/Uw5wBTY5JbVaHYUJKHszbBGXgFCYoD6geoFwrjL?=
 =?us-ascii?Q?9ZCyZi195tNJHHyWLJpT8u2nKCaVVoVVF8bUmHpZsi2NNakodo4MZg96w7zU?=
 =?us-ascii?Q?vEBJSPnLVDUpNoKLvKqyJwIhuRedtKGuPnp9OXk7EH42cme1DicpDwdHgAEu?=
 =?us-ascii?Q?zbNX2NU5kB6c9hvWu4xUfWUGmut7z+QeRpsKj1/pAHfWRZYuv+ocO0Hc6gCw?=
 =?us-ascii?Q?nSvzxyGCJWoOUS6daGk0RZ2Kq49FaUVct3G1Qd6599npJbUv7fGSH4JUHgAt?=
 =?us-ascii?Q?8S7WWidSAMQoeXLZYX/NmOBbQV9+Ypc+TELDccP1ZWs7DIksPQAcZSp1ueru?=
 =?us-ascii?Q?acYAC3TliTPeqPg3hw+Jo/IuVSxzNGl9fyPowvbfVNQcN1mQ8tj7cA+JFycH?=
 =?us-ascii?Q?vYmobGPnc88J4Vy52TOdP1ohVy1/Zotn5R6cDCvfJLaKL+YiXrs+Mu5BlXcT?=
 =?us-ascii?Q?rZh8w7T2wU9q/2SJu3lCrj0bMgDpmIeTEWVDn3u2tk9WsNeJPSlwKP5JK5ci?=
 =?us-ascii?Q?UJEU73POYevFZXX3Zf5DhuBIBQdjh3HU5MXKMgUKqo9SjwW92dZjqkbpk7f3?=
 =?us-ascii?Q?e+mhF0mlvxsa5gC8h6w+b0dknfOFoGmUQCXPLEQm5Vpa8dXmm80TfaoE8aVo?=
 =?us-ascii?Q?HzK3EiKyX2XZfbnx8uc9zKvRdmZAGEl9JQ17Gkvpu6DeMppJXVKqUv+KRgKn?=
 =?us-ascii?Q?tDoFDvH0rCW160dnW6NzUn+kbVywNPLrbK0XmRGoqUIqv9uL/sEErLEIixrZ?=
 =?us-ascii?Q?dsLux4oNucDZn4nA8jvgtv6iK+7U2DEJiDDun2ejeULYNzP03548O8gFAeWu?=
 =?us-ascii?Q?DIOaDH3xlx/WpYoM4mu2ss/33ls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f89977-97a2-4286-d193-08da8f4b6107
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 14:31:53.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJ2a2fzlxIHSmaXqki7VEACx/xKIi9pe+ppDps1lnolUrvf2gY2AjijRq2JRnykAMPvArbzSYIUI9Ze2Hw8RcnT+Yyuzh7DMEPdxLxcL+uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5765
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.09.22 16:25, Christoph Hellwig wrote:=0A=
> On Mon, Sep 05, 2022 at 01:15:16PM +0000, Johannes Thumshirn wrote:=0A=
>> On 01.09.22 09:43, Christoph Hellwig wrote:=0A=
>>> +		ASSERT(btrfs_dev_is_sequential(dev, physical));=0A=
>>> +		bio->bi_iter.bi_sector =3D zone_start >> SECTOR_SHIFT;=0A=
>>=0A=
>> That ASSERT() will trigger on conventional zones, won't it?=0A=
> =0A=
> The assert is inside a=0A=
> =0A=
> 	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> =0A=
> btrfs_submit_chunk only sets the op to REQ_OP_ZONE_APPEND when=0A=
> btrfs_use_zone_append returns true, which excludes conventional zones.=0A=
> =0A=
=0A=
=0A=
hmm I got that one triggered with fsx:=0A=
=0A=
+ /home/johannes/src/fstests/ltp/fsx -d /mnt/test/test                     =
                                                                           =
                                =0A=
Seed set to 1                                                   =0A=
main: filesystem does not support fallocate mode 0, disabling!             =
     =0A=
main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disab=
ling!=0A=
main: filesystem does not support fallocate mode FALLOC_FL_PUNCH_HOLE | FAL=
LOC_FL_KEEP_SIZE, disabling!=0A=
main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disa=
bling!                                                                     =
                                                                           =
                                                                           =
                                                                =0A=
main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, =
disabling!      =0A=
main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, di=
sabling!        =0A=
1 mapwrite      0x27d31 thru    0x3171f (0x99ef bytes)                     =
     =0A=
[    2.399348] assertion failed: btrfs_dev_is_sequential(dev, physical), in=
 fs/btrfs/volumes.c:7034=0A=
[    2.400881] ------------[ cut here ]------------                        =
     =0A=
[    2.401677] kernel BUG at fs/btrfs/ctree.h:3772!                        =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
[    2.402463] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI                 =
                =0A=
[    2.402943] CPU: 0 PID: 233 Comm: fsx Not tainted 6.0.0-rc3-raid-stripe-=
tree-bio-split #313=0A=
[    2.402943] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.0-1.fc36 04/01/2014=0A=
[    2.402943] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]          =
                                                                           =
                                =0A=
[    2.402943] Code: 83 ff ff 48 89 d9 48 89 ea 48 c7 c6 48 d9 1d a0 eb e5 =
89 f1 48 c7 c2 68 51 1d a0 48 89 fe 48 c7 c7 b0 d9 1d a0 e8 83 b0 4f e1 <0f=
> 0b be bf 16 00 00 48 c7 c7 d8 d9 1d a0 e8 d5 ff ff ff 49 8b 85=0A=
[    2.402943] RSP: 0018:ffffc9000015f8a8 EFLAGS: 00010286         =0A=
[    2.402943] RAX: 0000000000000054 RBX: ffff888103f35428 RCX: 00000000000=
00000=0A=
[    2.402943] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000fff=
fffff                                                                      =
                                =0A=
[    2.402943] RBP: ffff88811ad33148 R08: 00000000ffffefff R09: 00000000fff=
fefff                                                                      =
                                =0A=
[    2.402943] R10: ffffffff8203cf80 R11: ffffffff8203cf80 R12: ffff88811ad=
330c0=0A=
[    2.402943] R13: 0000000000000002 R14: 0000000000000002 R15: ffff8881004=
957e8           =0A=
[    2.402943] FS:  00007f87c5d23740(0000) GS:ffff888627c00000(0000) knlGS:=
0000000000000000                                                           =
                                                                           =
                                                                           =
                                                                =0A=
[    2.402943] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033          =
=0A=
[    2.402943] CR2: 00007f87c5ca0000 CR3: 0000000103fa8000 CR4: 00000000000=
006b0=0A=
[    2.402943] Call Trace:                                                 =
                                                                           =
                                =0A=
[    2.402943]  <TASK>                                                     =
     =0A=
[    2.402943]  btrfs_submit_dev_bio.cold+0x11/0x11 [btrfs]                =
                                                                           =
                                =0A=
[    2.402943]  __btrfs_submit_bio+0x8e/0x150 [btrfs]                      =
     =0A=
[    2.402943]  btrfs_submit_chunk+0x12e/0x450 [btrfs]                     =
                                                                           =
                                =0A=
[    2.402943]  btrfs_submit_bio+0x1e/0x30 [btrfs]                   =0A=
[    2.402943]  submit_one_bio+0x89/0xc0 [btrfs]                           =
                                                                           =
                                =0A=
[    2.402943]  extent_write_locked_range+0x1d9/0x1f0 [btrfs]            =
=0A=
[    2.402943]  run_delalloc_zoned+0x74/0x160 [btrfs]                      =
                =0A=
[    2.402943]  btrfs_run_delalloc_range+0x16f/0x5e0 [btrfs]               =
                =0A=
[    2.402943]  ? find_lock_delalloc_range+0x27b/0x290 [btrfs]             =
=0A=
[    2.402943]  writepage_delalloc+0xb9/0x180 [btrfs]                =0A=
[    2.402943]  __extent_writepage+0x17f/0x340 [btrfs]                =0A=
[    2.402943]  extent_write_cache_pages+0x193/0x410 [btrfs]      =0A=
[    2.402943]  ? rt_mutex_trylock+0x2b/0x90=0A=
[    2.402943]  extent_writepages+0x60/0xe0 [btrfs]=0A=
[    2.402943]  do_writepages+0xac/0x180                                   =
                                                                           =
                                =0A=
[    2.402943]  ? balance_dirty_pages_ratelimited_flags+0xcd/0xb10   =0A=
[    2.402943]  ? btrfs_inode_rsv_release+0x52/0xe0 [btrfs]                =
 =0A=
[    2.402943]  ? preempt_count_add+0x4e/0xb0                              =
   =0A=
[    2.402943]  filemap_fdatawrite_range+0x76/0x80=0A=
[    2.402943]  start_ordered_ops.constprop.0+0x37/0x80 [btrfs]            =
  =0A=
[    2.402943]  btrfs_sync_file+0xb7/0x500 [btrfs]                    =0A=
[    2.402943]  __do_sys_msync+0x1dd/0x310                                 =
 =0A=
[    2.402943]  do_syscall_64+0x42/0x90                                    =
                =0A=
[    2.402943]  entry_SYSCALL_64_after_hwframe+0x63/0xcd               =0A=
[    2.402943] RIP: 0033:0x7f87c5e31197           =0A=
[    2.402943] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 =
90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 1a 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10=0A=
[    2.402943] RSP: 002b:00007fff06ca0788 EFLAGS: 00000246 ORIG_RAX: 000000=
000000001a=0A=
[    2.402943] RAX: ffffffffffffffda RBX: 0000000000000d31 RCX: 00007f87c5e=
31197=0A=
[    2.402943] RDX: 0000000000000004 RSI: 000000000000a720 RDI: 00007f87c5c=
96000=0A=
[    2.402943] RBP: 0000000000027d31 R08: 0000000000000000 R09: 00000000000=
27000=0A=
[    2.402943] R10: 00007f87c5d33578 R11: 0000000000000246 R12: 00000000000=
099ef           =0A=
[    2.402943] R13: 000000000000a720 R14: 00007f87c5c96000 R15: 00007f87c5f=
6b000=0A=
[    2.402943]  </TASK>=0A=
[    2.402943] Modules linked in: btrfs blake2b_generic xor lzo_compress zl=
ib_deflate raid6_pq zstd_decompress zstd_compress xxhash null_blk=0A=
[    2.402943] Dumping ftrace buffer:=0A=
[    2.402943]    (ftrace buffer empty)=0A=
