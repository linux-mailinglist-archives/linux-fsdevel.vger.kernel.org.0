Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5782652CD32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiESHe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiESHe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:34:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BEC939DF;
        Thu, 19 May 2022 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652945693; x=1684481693;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=z6G63D6JNhp1tAT9y+Fdr7bow/5wKaqSsfd9/EQVG8A=;
  b=jcg3mgUpqeESDavzlAoaXUxkgQcnmk/c7eB7QngtG5XyuV5vUohVLx2v
   SjaC5TIlsfJWvh6u+vXByTEZtehcIZMBAksrG7x53kEeTE6MDWSLCGNEX
   0XnhJXmaIfFjZ9FVdFtEBgUqFHV5wv84rGsliatQnrH724Mo/MUMo/iHz
   A50EEkSsk6C/CoBDSgV4HsMYYxyt703Gt3TE5Ou1K23MkH1GuzhqCwDle
   3xQJIB/+/REKYr83z+E5ncLt3oIRtFSOydv3adipWhiAWa7svPYxb6z98
   U2NlEhu4nlVfprejfu3J1m135m5Io2AWdqejLtjtdWhOlMtuNVkRwO+Ce
   g==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="201618087"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 15:34:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk0Qb+ZmvvBH8gwFUqv0tcMqSSu4dFAPyNflJv30CFzce9ipAyo9N1LqNAWj2pgqtScl9UDgwJNQ2aURx6ykMZ/7Vd+nNGTwD2PcaziAgjoyBott/aOVOhABuEPLK4r1kUd4DQt4xwVA/Rl7MeFNlHQd5PBBJDaBdto8SNOYbJl4cD6m6lCazv/X5gKP6ODx8jkFglNZ4zP7ZBOL2t1wUvRl09trVt82dtjrDPz6AxOX7/t4qrDZTOIbPwCZhEYJoegLlD+MWf6M1/duwAt20TAmSAq6cM+GaDJ+7XKCIkTVjF8I7y9fHstWBJjVu2ypHbuPBB4SYJxo+8fRAIWQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7jNce2B+HaAJtqPawQ8sd9/z0T6SDlp6jTvQ2XgXVo=;
 b=g9hUPZYhALPvT4aDD9rdQc3hA1Aje4bBQKib0mlHf41Bent1QOm6yhuOE8GkJctXbNozKoJk3FSTV6m9yMQ57J+h72JXNM2jyZrIUll3/nJpaO/P8OSzMsrE+vN7Qy1vC7F4T4ZISEfGL0/AoCquB2Ueg46Ki0m7qZD4Q2AbT68sHM6ONK1ElMBdsoNlySr0NN3bbO4IZMrHpNV5i3tS37tsT63FDOTjs10FeCddGYwYN4HZUiZcQG8GiplDFOUvGExQS5smUvGVJVDFZ4VJCao1I3/MGpzZ91H6zZsWWGuVQbXQY1K21DPbY5nnevqx3iwei5zl3UYDl2mX0CAREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7jNce2B+HaAJtqPawQ8sd9/z0T6SDlp6jTvQ2XgXVo=;
 b=Vh0pfWQezS50Xw5GN+H/E9p4mUImTmHcO9yypb6wTtvw/sJtxsKn/DmEaPrM3Dq1duNa4H1muCeXfcpOQeyNzDF2wzTD3FkteXb/exoPrqxsQN4S4sAeQj6cP9vIKZZP9sERTxalZQk3hGBh50pbQfnjUQ8K0rSxk5pfw1a3IJQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4187.namprd04.prod.outlook.com (2603:10b6:5:a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 07:34:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:34:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Thread-Topic: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Thread-Index: AQHYaUWgb63nSgvmhECLq0/sZ1bDBw==
Date:   Thu, 19 May 2022 07:34:43 +0000
Message-ID: <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c7c4581-a622-4889-41e5-08da396a0a96
x-ms-traffictypediagnostic: DM6PR04MB4187:EE_
x-microsoft-antispam-prvs: <DM6PR04MB4187369AEDAA4084B85CF17B9BD09@DM6PR04MB4187.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8m9jLhFEmqSNw379+AQH8zDWBLEeIy8R4Wb5pGEQtw8ivtJwCuq1gpAAychrArejBHfEWrE1civaqObG2LsXTvahe8ptlb6b90gwq/Znfiv9ITFLCZ+rWGUrrApYjPfsAyIasAq6341YGJ4VLhW12XE28axH/sC6fosjI/CyNUDRqv2fKccNmPEMgfh6m4gXOiGk1IJVr0aiJAhXfvvkXR574uDa9GPSu0di6VSN28APeuJPATDvGgyvK7VE4/g3o1lPyuFl9wefC/kTC1JzIqtbNA3HcGPyBupG2JvOYhVljXM2IyV/r7aFUdJvjIwAD+Y3PYXV6SM2EUSv5PTYcVAvAu3IHRi3VKRQGthF/2lzPEdpi+ziLbBbiTKhf9ah2BEiGhnmOz6UNfIlHoK2BwixmAXqx3kZkPK2pav1bI84oy4+TFJdqcVW5wWAn++A2OIBKjbwxqQpSPiFRUfcKcRcgpSU7hFQSNTDPPnw36Yo4XEFCX6jNWu2GYlQrKq597v9NUimCAnbd04lEOasozVUu4tl6ZG0wBLtIIbzdELegPSdAAMBpJmuxDyJVJAc7pH2JN3Tc20jRtFdn4bIC9D4B6jkVp+AIJWBE0pMeJ0ZJ3VaAumVA7TpDCa7v9Yx98gAGPiC1INLnyH1yGBCadRw6s0KQFWWTvYcHSnQGvyutYFwZ9KPIe16BL9Ek3Bs6HfrszZJ4oCBGcLwDSSFzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(38070700005)(122000001)(82960400001)(66446008)(91956017)(76116006)(186003)(86362001)(64756008)(4326008)(8676002)(66946007)(66556008)(66476007)(110136005)(38100700002)(316002)(55016003)(9686003)(8936002)(33656002)(83380400001)(6506007)(71200400001)(53546011)(52536014)(7416002)(2906002)(508600001)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?69au8SXA9WvMT9/TbsL/iZIaHcBha5uSUOoPK5YdoCoP2mdnrI6TpZUmU3se?=
 =?us-ascii?Q?PPg7Wk6VA6EB7sNUyHnL6hlqw7c0Wk3DhWNdxmHpZczCSm6WP0bjMRxWCovi?=
 =?us-ascii?Q?s5QQLDFrQM1TvLNhkAvPNwsoF5j5/enzokd26ggBg2UFF724G2rgY+lX88gS?=
 =?us-ascii?Q?XxsneDZSlaDgG6y2NxZjSL2Qic3gAmb8M/EzlM64hPksgJ1LFW2FODrO0+FZ?=
 =?us-ascii?Q?6K7NRZG8jjqdimmSg5HmUXfd+37f4Y3tmnQTYKRJRfWripoCxWi9yuLdgP13?=
 =?us-ascii?Q?5SDmYvCT3P8qwUzmOI5mZhJX9tOl3wdMLHzLB1aCArUUHRh/gH2/CNlEh2we?=
 =?us-ascii?Q?RgJMtzqupZ1fTJHCi/JcIpvLWG4WCkf4mXgA834Th+/bOGEC5gYPJvBy4mKt?=
 =?us-ascii?Q?WX1IX1wcdib4kb1dAITD6qSoJ9nrXQ6ShTVmmEphJN9N57qMqN/jpGkIQ7zs?=
 =?us-ascii?Q?nXE776FG/0V02QmkbIXwkgYYY6j4ePgIZx15l+Qi1IZ2IU90bJD+ta/iZ17L?=
 =?us-ascii?Q?DqgH8ThXXy+yLDa/wZOpkSO1xwnZ6ePtBx8SrZ8wLj2XKhCXG6E+nblXIXM7?=
 =?us-ascii?Q?pXi907dG7EpgdJQdToPrunSs9TKytb3OuDZwDH+m3qN6zdLTFxU+NZg3KUwf?=
 =?us-ascii?Q?CNaKdkpjvZOK7RO27aGeDulQN77JlbU1WbU9h0xS1DAF21oOFkGvifauSVZj?=
 =?us-ascii?Q?FSMa0KHZ3TtRIdIugYiySwOrGKSCuATb2cwIOMZaahLLCjTW4lFdmZNLHbBj?=
 =?us-ascii?Q?eCekAAgHit/kG3e79ripyPXm7hkyke+ivn6pQU3D798ndeaFKgpAMK7yEcph?=
 =?us-ascii?Q?9mvd+kx96OuB4hvAHdJLc1GsA3cQPGOvtPbQbHPtTe8GIuBl/w8eZGCJDgYZ?=
 =?us-ascii?Q?S5kgPJMPza3KekX8M620pHnN/1Ue2KGUC4u6PC7eEIGlSnuXntL5IKvbE3Ve?=
 =?us-ascii?Q?+m23SI2mGk9S3a+ZfZDsg9M5ZTkUD94MvUe94wIN1NiTjyzrsc4nlCKHLxSF?=
 =?us-ascii?Q?2l5pInCoDUyuFfhg+g2F1eEu/rNAhdILPjgvL7kmRqB8AzJ/z6M11add52yg?=
 =?us-ascii?Q?MyX5eRVUJ+gyutHCZyICDNwYyKfxGPodany4U1FQXCDi/4yVidKhUbtJBfle?=
 =?us-ascii?Q?NFFa/Gew7GlnRaPColSAXfh7ytoVPkrcEI2bBfWmXB5M+bs635MxTxFRGqKB?=
 =?us-ascii?Q?wudOnLARekdgHjFlFtRvLDDN7O6ryP67gtkYHZiC/6DBvkvzikMpshbLgPS5?=
 =?us-ascii?Q?UQw5qkEeUSxiBJKndkN/lAJcAe8OOMq6YLArGwXzmhqS7O5eVr4xrnQD7CmL?=
 =?us-ascii?Q?LOo9Xg89CSanAXvLqwCCn6SZsGT+cV3esLyGzdyyT4L58yYnuERPuU9inkX0?=
 =?us-ascii?Q?Gjqc4hDi9TsBEunvaa2jOaPQexKaEAuUkbPoiqHp1vQ4t2bm5vEn1zlQS3nw?=
 =?us-ascii?Q?oq56flCkpROLSGckldAKT3F7sT+WU1VtQ7n7UqwPZIcJNU0oGNCL+AQbdxFC?=
 =?us-ascii?Q?E4fa5lgv7WQHJ4ZnGDSO3Ewz+TM2fuGC9zySuuVk5Ygez7axoRIX0BZ6jNmT?=
 =?us-ascii?Q?Ev7vMaEKtcmQwUvAgJOem41sh+BEhuw7YEtukM6q/XARQsPmC95ybUTfba5U?=
 =?us-ascii?Q?3B3tbktSQbiY3TAk8hQmIBngbk2tggvSjrOk1r9oW3ce8NkSIhKFbzIgFupF?=
 =?us-ascii?Q?7AU/bZqQ37SX2H+dXXmbnZMBATMTQh9EJu+q8Vz8KPq8N1MlzJWBQcjlK9Qy?=
 =?us-ascii?Q?bWTlYTXDWIMA1LWtsv96+C3Cn6Duj81IEw1Vh1CjexDsc8m9CQqulcXbuyNe?=
x-ms-exchange-antispam-messagedata-1: dqhWBS95udqgACXEH+bnWpntPLnLiMmGCkLWxmz4Pzxr/N+/Thwl4DoQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7c4581-a622-4889-41e5-08da396a0a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 07:34:43.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkM+rOzIByb0F/kCYf2NS5ZH8eqcqVSbaC98SaH8ZXfEGpQeQ32NdvMIhMTbM3dRT955d2AUtRKU+OXm6uIAZ/hrTi5Iz+3Bt9S9ap5csu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4187
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/05/2022 05:19, Damien Le Moal wrote:=0A=
> On 5/19/22 12:12, Luis Chamberlain wrote:=0A=
>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:=0A=
>>> On 5/18/22 00:34, Theodore Ts'o wrote:=0A=
>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:=0A=
>>>>> I'm a little surprised about all this activity.=0A=
>>>>>=0A=
>>>>> I though the conclusion at LSF/MM was that for Linux itself there=0A=
>>>>> is very little benefit in supporting this scheme.  It will massively=
=0A=
>>>>> fragment the supported based of devices and applications, while only=
=0A=
>>>>> having the benefit of supporting some Samsung legacy devices.=0A=
>>>>=0A=
>>>> FWIW,=0A=
>>>>=0A=
>>>> That wasn't my impression from that LSF/MM session, but once the=0A=
>>>> videos become available, folks can decide for themselves.=0A=
>>>=0A=
>>> There was no real discussion about zone size constraint on the zone=0A=
>>> storage BoF. Many discussions happened in the hallway track though.=0A=
>>=0A=
>> Right so no direct clear blockers mentioned at all during the BoF.=0A=
> =0A=
> Nor any clear OK.=0A=
=0A=
So what about creating a device-mapper target, that's taking npo2 drives an=
d=0A=
makes them po2 drives for the FS layers? It will be very similar code to =
=0A=
dm-linear.=0A=
=0A=
After all zoned support for FSes started with a device-mapper (dm-zoned) an=
d =0A=
as the need for a more integrated solution arose, it changed into natiive=
=0A=
support.=0A=
=0A=
And all that is there is simple arithmetic and a bio_clone(), if this is th=
e=0A=
slowest part of the stack involving a FS like f2fs or btrfs I'm throwing a=
=0A=
round of anyone's favorite beverage at next year's LSFMM.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
=0A=
