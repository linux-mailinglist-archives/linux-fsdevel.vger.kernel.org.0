Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57D4B7E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 04:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbiBPDCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 22:02:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiBPDCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:02:41 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A66673EC;
        Tue, 15 Feb 2022 19:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644980548; x=1676516548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VbOYpltPVpjPkcoE+BfKqMZI+SCQaGnbtAoCPS9QrZo=;
  b=PnUA2B2e4mLxudyv0ji80UJWHWWfOb+zgDg3I+kS95/v7KJCEOZK71FU
   TurRfxWWnsXnsUlaVYEthrbdZr0nyOKjhWP6FXOKzeROSGCCx1DMEVnNW
   x1Lhp1OLzaH6yT3ECqSRIj3UoiWVa9SB23L8rssnkAlSbr5XjVp32Gpo/
   TSu7P/EaJ0s9mUkoabGktVUsHWoK93DU/FrOFZIUOYfEnDJf0nBoYQNpE
   fXD8nUKW6uNZULLTLWurCH02NsdGA3VECb5HvdsvVZuAAfz/oqp3OH0WO
   CCQajBeeT2rPI5Z9NAvlaEq8wroPERkjHFiLu7tws/D696wM+/XRasCHR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,371,1635177600"; 
   d="scan'208";a="304961742"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 11:02:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNpQjukN3P/rkChLweDW9Ks53kQyipUBKQS3eT15bQM6Xn5nzjoECGdydCGUdoFN3ir8hfcJ0ISlztZyctv5JV84/Ob5uACiMXO9rlN3JRAIkPjVHnHUSf/rosKfyLklSMVk9IWfqDsTQR7+SsTzfkMADyxZFdGHfzB2IEwDLJxFXFEoAuBxCchYw1vCAk4tF8CQoja+0WDSvY9CuLyIPe8iHUaiFA7uT0tBF79CavseWbG9AloF5wUXvBXEbXCc9BGjpIhUTSrlwmWvLlIVHR/7kTXGP38q4y6H6XbF3zs0aAmH6z9Ho8KP8QkhP5iFRZDdTiHkYEyw2yiW8fJ3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C2EOC3pO1jEAycol+UZsm4XIGC9d+Lm5Dw3gx89gpM=;
 b=U/MwNLziLnMm22fKYITllvQdw+9g8ChScQmF58tJXx7/FWDfwq/nVLow2UJjHuXJT8VmD1nfRZudLuzkNq12nlQ9tshrvBSdpZYiCemaUbNnB4KTENuu8lr6+O8sTrg7DsfH4hH/w7cEFIrt7d8MAK/SCObtQJgrpEG6HJpexjovi7HKf4MoVSBIcg7QkF0AodhuwlPpaTQFrgKFwoBmAvqkZnCK6SdYKG35NBRXhejQyBPGMIvm4M/VM7NjN+niqkmAtT/O6RF+ZRhduw3F9EtEpHpxPpyXAOM7NZjuEo60EQoqUlriD6X3IZjIH151Y/CeqImkO33GSSaEXI8Oig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C2EOC3pO1jEAycol+UZsm4XIGC9d+Lm5Dw3gx89gpM=;
 b=SK5R6UEIZanTLBa/avzzl9iBPl0c2FvFjtOrc86wHNacDs6zMt3PVhtoNeTk3rgvLlEoiWdYHe7d0mncsEAdR+OMwNMQCz29AQuoGDpeTaXk7u4MqpvoQuPUVelUVA1LDeoxUATZzHbkHSvnx0yOAZRQ7b6x3/ZS+VFMuvg+Q74=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN6PR04MB4927.namprd04.prod.outlook.com (2603:10b6:805:93::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Wed, 16 Feb
 2022 03:02:25 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee%6]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 03:02:24 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] fs: add asserting functions for
 sb_start_{write,pagefault,intwrite}
Thread-Topic: [PATCH v2 1/2] fs: add asserting functions for
 sb_start_{write,pagefault,intwrite}
Thread-Index: AQHYHkNcgseIo69yC0yvO1qLR1/smqyTmQ6AgAAUqICAABUtgIABw9OA
Date:   Wed, 16 Feb 2022 03:02:24 +0000
Message-ID: <20220216030223.7it5t2qgfjf3gdcy@naota-xeon>
References: <cover.1644469146.git.naohiro.aota@wdc.com>
 <40cbbef14229eaa34df0cdc576f02a1bd4ba6809.1644469146.git.naohiro.aota@wdc.com>
 <20220214213531.GA2872883@dread.disaster.area>
 <159d58f4-2585-7edf-7849-1a21b8b326f9@opensource.wdc.com>
 <20220215000515.GC2872883@dread.disaster.area>
In-Reply-To: <20220215000515.GC2872883@dread.disaster.area>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 819fdd31-5d40-4484-9866-08d9f0f8c22a
x-ms-traffictypediagnostic: SN6PR04MB4927:EE_
x-microsoft-antispam-prvs: <SN6PR04MB49274F15589795E7D47F42FA8C359@SN6PR04MB4927.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USsnVvilOMgHGP/9hzwXNzTNEOBzU+dGwhWnKkZqmvTWna6o/M5wqAh5kPzyqH0mZ63e4xolKA5Jh7jb6mRiPTxLSL3/5if24H+TtfEy6+ALtsk9hGRCwbh0uNHCHLd6j0B7DOQ0SHob927KFLfDa7iUNyyCSWcOUjgNFNrwHzLZ7jUfwe71ad65DoKQ6onzvmWLSqtsnZFLaQ4ZuPa3lSvy/Zx4Q8Vk2mCoBTqc042hbhBnb8PiGErzCjblaCcFrxtogE8ewnwQ3+WwfOVf3C3zlwsfB7hrUngI7paK/WiyZLtQvZ/GbfRkt4xoeSMVGczL+jBck+k51iteKbw2wL+SJbxW/aMAfFv3+8xuYDNwDquKRyyZfP2yCHHd0w4Ttq51z21QyFPVH+ixV+whm6bUeDCflXKSVz5qN0gou0TCjATF4TBWcXFB9GeZ/wwRChPfyMWY3XJnKI7qFxfKUkQZkVj6krVTq0TmCeCK5Lx53Q2MFdGFXIYwFuo6OWUoiJ9rznzBjwWl8YTQ1qclpdU1m3+RE0qdezbMKufH0Gral1MZLz0uKIMtozeAmDgP2HpPTGSvjVBN83e75obsILzkDArVb1icm9MgSaWUr40by4B2KGVQRdq0PS44dCYDqvguaLw49eXwBA1tKHmymQA1DEEWblSP7eYD8Bl8N3y9hV71RYAidnDQ322Ftpy/SZgvXjaFBTyXpLcX8E6r5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8676002)(9686003)(6512007)(8936002)(5660300002)(4326008)(71200400001)(6486002)(53546011)(54906003)(508600001)(38070700005)(91956017)(26005)(64756008)(186003)(66556008)(6506007)(6916009)(122000001)(33716001)(1076003)(83380400001)(2906002)(82960400001)(66476007)(66946007)(38100700002)(66446008)(86362001)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYUQeThMbi4ZAYYJbY46VYKqtB0SQLRHj877oMDcU0ABK5weWssqdukKViFr?=
 =?us-ascii?Q?NHEhJzp2+jYi+rwsA98ZhOYRaa8AILRZzVeV23pcCyavfXOQ3isCR/dUfS/C?=
 =?us-ascii?Q?1hjLCVtan5Lskir4t2UMxGD9idW8Kb1LFtPdIhzxV5RdDQi6uX7czEBCw0lD?=
 =?us-ascii?Q?13NO7hUYcFS/jhH4NuKQFijxYOSQYDraxww+DPoL2UwaBiJOPBhakz8aOCFR?=
 =?us-ascii?Q?MXruTmXenxO4IwzNBUbFM66/+eC3JJRXddf/DwbzPSHw3zpsDp/lplHYa35k?=
 =?us-ascii?Q?5pgdb1iCnaTUrKStYIh3+QBTqRb+Z8ruXrgcdKmCgzH5CVtF7Ht7lI/BX+FZ?=
 =?us-ascii?Q?2Ft51Y18u6K/+cy4zpC05b+EEgt/HmCoP0BB5i4zwKLxxrDnYvoeFCMXK4ma?=
 =?us-ascii?Q?7bhPNB5lEg+HmhRCJnLCqfwngIVZeBc1z6AhlaRiueI2/9kB9e88hlCM/NJI?=
 =?us-ascii?Q?7lJnB6SgdrgE+N0lGNdSp8avtgvkr2skNX49zwwDtHziZiVk0sZLJ1xChBHC?=
 =?us-ascii?Q?jQtveDj0a8Sl0zlZXCASg5RYqINNvtRMT0/lkRot1oEhVUnCelip3ZwywnCS?=
 =?us-ascii?Q?ImgEVaClUjFV0nls27GOLaSrjRrYIa9Sm1Blbf22xR876CW7xiJBtUpIxu5L?=
 =?us-ascii?Q?WhrjKU2Qk/f9rszVP9Ofd4yW1t0PCzFq4/CALEfaQ97+QZch4zhmZhRGdTO9?=
 =?us-ascii?Q?KP4DNyFde0C1KL3Un9s7UIRMvAPdiWBO0z8Ottaemfvmya6SYo4vPeCNC4gQ?=
 =?us-ascii?Q?pUtKLOBC5fRKKu6OI6woaVcvtnK/g7aRxk6g+RZsxRe58tzJeC9NYJHb5nyF?=
 =?us-ascii?Q?a338XF0vXM4neljY0rX8m48P0ZrCObLdEQgkrICDg0uCHxdvGNLq862ny6wJ?=
 =?us-ascii?Q?LOlQ9ZBXE4V5I6SNuNWDAlzWNOn/l7uim3oBOxfcHByH8gYiACZ9Q7U4xcHD?=
 =?us-ascii?Q?TwTgsrUxxGiklwWGOfK5GVQTrSqc/nhX35R8BkF3WUxViTOkgBSenBUj/VnX?=
 =?us-ascii?Q?lyIUslS4aLns2C1nJw/BbO14vZm3LjxG27cZ62YkGwUwWtJ94RahifjDHfOf?=
 =?us-ascii?Q?u8J7gH9uIVLr+13QvffcKoefhJUV+AjAaizw3cX+5/ZksDL8pb5U/KVETi5A?=
 =?us-ascii?Q?CaSaMHOPemyN5gW1mlwtGWpjqAZJ7EK9W1S59TPbxcHmfsuB/sPWk9MKp+EK?=
 =?us-ascii?Q?8W2eKopNrl64My6HJqhJlkQkxTKYwHT2cgrzfoaN5BerekdfXPGpNXHmKRSy?=
 =?us-ascii?Q?p7HCsBe+wll7xSOPsIhupIqBPI3MHKJI9crIstzJsbaooDC6uCD0QeoyvAtf?=
 =?us-ascii?Q?l1lE0I0n2vfv+pJymQAdoeZcc651Nk8OIeiJ3IyuO6VE6P88LzZdTDiBDmBZ?=
 =?us-ascii?Q?oV3l6dhqdjjGerXNqISf4CPX0sGXBJBhncPFp+vVPoTV4F6pYs8LmrvU07tu?=
 =?us-ascii?Q?9Hm8YYxaK037ZfBFQ1g6ev81vO9P/jZxGBx5Z6Jv+AErI4XQSLvJhMqhS4NO?=
 =?us-ascii?Q?f3ApMMsYJv8R7f7yFlcqF8g/JWGGojyjOWPdlHwvSKGvj75JVy8JyomdFNCl?=
 =?us-ascii?Q?DEHBRPD4LlP73j8ua4rxX52pDo6XWDeQYk6k/DyIYcUmfd7Qm7bDK3WdUoBU?=
 =?us-ascii?Q?pNPDjGZ+iJDWmCznAmP5oKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <846C1045F0C33649B61C3EA287B4D7D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819fdd31-5d40-4484-9866-08d9f0f8c22a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:02:24.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tI/bkZL8riPAXtUsGfliBoD5CzXflS9voxGHXcJBVLTu3dLJ2lY5/pa6+yzMzJwK8bpSCPGJ12IBC658xR/Hmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4927
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:05:15AM +1100, Dave Chinner wrote:
> On Tue, Feb 15, 2022 at 07:49:27AM +0900, Damien Le Moal wrote:
> > On 2/15/22 06:35, Dave Chinner wrote:
> > > On Thu, Feb 10, 2022 at 02:59:04PM +0900, Naohiro Aota wrote:
> > >> Add an assert function sb_assert_write_started() to check if
> > >> sb_start_write() is properly called. It is used in the next commit.
> > >>
> > >> Also, add the assert functions for sb_start_pagefault() and
> > >> sb_start_intwrite().
> > >>
> > >> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > >> ---
> > >>  include/linux/fs.h | 20 ++++++++++++++++++++
> > >>  1 file changed, 20 insertions(+)
> > >>
> > >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> > >> index bbf812ce89a8..5d5dc9a276d9 100644
> > >> --- a/include/linux/fs.h
> > >> +++ b/include/linux/fs.h
> > >> @@ -1820,6 +1820,11 @@ static inline bool __sb_start_write_trylock(s=
truct super_block *sb, int level)
> > >>  #define __sb_writers_release(sb, lev)	\
> > >>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP=
_)
> > >> =20
> > >> +static inline void __sb_assert_write_started(struct super_block *sb=
, int level)
> > >> +{
> > >> +	lockdep_assert_held_read(sb->s_writers.rw_sem + level - 1);
> > >> +}
> > >> +
> > >=20
> > > So this isn't an assert, it's a WARN_ON(). Asserts stop execution
> > > (i.e. kill the task) rather than just issue a warning, so let's not
> > > name a function that issues a warning "assert"...
> > >=20
> > > Hence I'd much rather see this implemented as:
> > >=20
> > > static inline bool __sb_write_held(struct super_block *sb, int level)
> > > {
> > > 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> > > }
> >=20
> > Since this would be true when called in between __sb_start_write() and
> > __sb_end_write(), what about calling it __sb_write_started() ? That
> > disconnects from the fact that the implementation uses a sem.
>=20
> Makes no difference to me; I initially was going to suggest
> *_inprogress() but that seemed a bit verbose. We don't need to
> bikeshed this to death - all I want is it to be a check that can be
> used for generic purposes rather than being an explicit assert.

Agree. I'd like to use __sb_write_started() as it is conforming to
other functions.

> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com=
