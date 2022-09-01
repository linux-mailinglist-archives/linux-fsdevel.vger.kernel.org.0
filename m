Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD745A93AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiIAJ4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 05:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiIAJ4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:56:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB421C7B9E;
        Thu,  1 Sep 2022 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662026167; x=1693562167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=St8udiBkKkNOFOeBKvC5//4/XVpboPwo5tvf7Vf0ib0=;
  b=Dt/GG/ozg4iLf9J8xyn9UJoC06zauG08qlRoHoouU2p75rpjxrPyOhCL
   LNZKgyEZFkRCHm+sAb9A1hgbsU5ppjKYf1B+0T8D+e4hJ43ePCra5AbJG
   OCfzIo39xfDf9dTwj93Gj64IpgzelgYAYra0xFuwDkvaex/rz5Cph7oPL
   7JGc8THSMxcM9n1fruW/4DDUPAA7LgDN0b9BPgxrcYHa1k6ZhxGH2CX55
   ZZzVfLokP+WUbhGQOYymDNqVSNEn6oSJX65zlbTK+IbIf6DSRSR62WDKM
   uq9J2ofc/2vl+8jf8rHNVJ0C/H2jJLUAFX/P/Tr8j+Zje6sgJ2hpa3ZHm
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="210214648"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 17:56:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMlXw0nkdZ/VLmMh0Th2mVazYe1M2Ot0YmnkkRhegNyN1jKUKh0g0rVWCGN9BdZOgwd9qisuJ+UzUr5bT3byUeW6zjujvyVF9bXzOtt9RnQxvqkrdYist0Kb9elI19/kD3SS23NPiQsKRBOUqyPN3nRQ3JevKqsKBLSO1HLrh+XoGMnUaCyQS6wILc3n9p3SGvRUY/B5a344oBshNEaRMUEk0rD9Cg6VJvUydTqpgnf8rjPYpO7pEoY+QGQJ05qAqEo8E4m6xt2DbiRko79yfDnWcCeStMzopWya8bZzVT0oVEmy1Iy8zq5PR8UDXarOEnfdLwRlXf7b+kAB3551lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaxU+L+52iklPdLtBbCIInuZrKnCRiZSX/gvjMuKYxU=;
 b=ZiykUS8FfsLPQvkIDsz0MmnOE5P4msXx/apOS0o0zj6868QTW8lVxVN0WQfeZjMwz/gk4n/2DVyeGIMHSQ02g9vUjPpdX/r+hVvX13o9BC9GuW7YenFMh5xctCIE+HNXjxWW3zu8nBD5SLOHcbMlup82DpsldTji4h6IdCaVgtwXIfKBLqRE1Cr2z2SE4mUU2sT0af8nZanoj4YasqiQI4PsEYimKv/O5bAmd+3zjQZ1woRTPOTBeUE9HdP2vaGDW3Y5K77B5nwMv3j6pQ1Xhf2x/c1l7HFbDpr2f90Ar1XByqA91c5xvD8JpPiSmkV3a4bDd3KAbAvOeloWp/7Xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaxU+L+52iklPdLtBbCIInuZrKnCRiZSX/gvjMuKYxU=;
 b=MlI+AIMHxWwqwFEqwnVLWFklgZ+bZQncHgsykks1h8KVBVoGxRjwuIolnTTqln+Y29k1TY3V8px5IQyg79ZiZsPDzcLzz+eE9DpRQUqHCWx1TBEi9/G78lTTSKFy89T1I8GeU4oJXRO3zJIQcsN4Ts/TXWLvYEmLQS9QEGva63U=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BN8PR04MB5778.namprd04.prod.outlook.com (2603:10b6:408:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Thu, 1 Sep
 2022 09:56:05 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97%6]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 09:56:05 +0000
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
Subject: Re: [PATCH 10/17] btrfs: remove stripe boundary calculation for
 compressed I/O
Thread-Topic: [PATCH 10/17] btrfs: remove stripe boundary calculation for
 compressed I/O
Thread-Index: AQHYvdZ7RTZiUJ/j/Eu81tHCoaqdpQ==
Date:   Thu, 1 Sep 2022 09:56:05 +0000
Message-ID: <SA0PR04MB7418043F611C6BC2CD453F659B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0c06ed7-7bf4-46f3-3f7c-08da8c002fbc
x-ms-traffictypediagnostic: BN8PR04MB5778:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OH6uyIPqZf1znfI0iBp4+RZhACmJ5oIRnrYY4BGZcXAMCC3PDNYX6sfF2H4eP1tVr5h69PsIQu7QvPe7oWAjNDotWGsp8+EvFOuL2z0CxjONU/nX0IEuqnM/ISYc8d1u67ntaCAi1u5OMXO8W8b6YVcE3Ebc3zNFvZ9L/ASlLeGeNZRn4hDwh/Vedf9+mhuDK6jyMLn6A+kZT//wluaxAfCfWxxVYK3xF4pdXdKDovFhIVhIai0qoMyR70gH5GhlI4mUpPzjtgrXBjJJfmCGAIgncRTtO/e+cgleP3f1rcT+660T3j1VRpeomD1fe28+7m/FlTW35v7ZBLP3l0zf4fsPDx1BDjUXYUasxwNdOEgUw0md9GPEXuFGbDOlIX//3T0FJKu66cCV9Z2E+5DdDFHk8KKlshSgLQTCg5B+uVXwf+2zT+oqv0hdsQZ0COcJlU7wfIc+TrYfEw7nJUrvfbIsJdrtmQK+/L86zHODFn5brajepV8xlI9v+jBnbnRJ3D3JN46TH4cuRmSWEc9STXodCwR7X8ShRE5PIrDQPRK+qocCl1aN3ClUx5zDQLpT2ZVqRTcae5GXe1egb3Pe9TxH/e87+ofypJ9PanRqWziTzGIVuUEjdcTtqV+VnSdDs42ZrhYBWNCBEcvIlA/PamYqIf0PPJZ+Ye3xYU2ud1J+5LYn3bpyXSffDcmiMsBJFUWQ7uvb/MW9O/C8lhckkNEfPQTL73orYMQ512sis4sH+XoQT+t7Cwi7QrMYge6phTvdFV+7KCE2Mv6l8ybO0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(66446008)(66946007)(91956017)(316002)(38070700005)(64756008)(110136005)(54906003)(66556008)(76116006)(66476007)(86362001)(82960400001)(2906002)(33656002)(122000001)(478600001)(38100700002)(7696005)(6506007)(26005)(9686003)(41300700001)(8936002)(186003)(71200400001)(8676002)(55016003)(4326008)(5660300002)(53546011)(4744005)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3tFBEsM8ckzDrO7Fe0CizU4juPnT1Y01Ntbcd0GzAMOiHznsGqNnhwBVy0ye?=
 =?us-ascii?Q?OBP3aj2RMZvIEtS/y9csqbAeRxdR21Ex1kwPqdZcJj61lIbArb+1q6TLatlB?=
 =?us-ascii?Q?3sP3cH1ztXQW0fXkLfTUa5faZLLOONLUL+TegvbmztdUinyXpEzYnPci3zYm?=
 =?us-ascii?Q?/YNB8ehpxA0OFj5DP3/87ZjYUN/pD8aVSeh+cLa5DLmhYkkE2LQkG1J1lLbd?=
 =?us-ascii?Q?24X2V/ZJJxSe0cWVwrE/bs2hxASLtUg2cLzNB75oQkECYFN08wTWMYjOGNl4?=
 =?us-ascii?Q?tOjlCSEJ7PFdyBzVXpDPrWF0XT7ODimXkOBu8tWxDted18LBM2IKCt5q3fdj?=
 =?us-ascii?Q?5DFbYSoZahNepniXGcCkokXSE77SVquGSlxQE0mrpLWrLQmgtoKjr97L9hpi?=
 =?us-ascii?Q?xus6XjwOk4EKrX0TVTJdbHDdDdcKJoVN4EMVLjbXqUudLTgHYyrMBqMy0lot?=
 =?us-ascii?Q?g2Y+T7C7pxOHLdXI+T++QcDZgC7TwIgDg5mpIpos/YXeMQyzwN5gb1uQIP1d?=
 =?us-ascii?Q?WezjtrM/+0fSj4iUa6XjWpnvsRXdOHCrEDfTL7PShBQ8rPL33OCidS2zyrXA?=
 =?us-ascii?Q?5iccT+1yEK8D1slyailq3lvXarAleXpxvd7143MKGIw0KK/gfJ6B4cy2fzOz?=
 =?us-ascii?Q?SfF+ElPs67l+hpOe6Jg4gx+DyNihotD7D+Ar3T/YemZI6AuFlcuZM8LJ99a0?=
 =?us-ascii?Q?omIlREaOQTGiNNlx+B+5Es4mm56tMwDEzQ2qNjBT/PqW6WbsipIzFuW+rLJh?=
 =?us-ascii?Q?3EEstXK8nQS+9f5/JLtu/6/DqxhRlF8NQ5+zrSl52x7no+mfHBSW/pA8eEcP?=
 =?us-ascii?Q?mCb5CAcO7JX9UBoV8ztDnblND0/HGaZO6IknRuCmjh8dUVHF0glBFzZvF/AT?=
 =?us-ascii?Q?SeCKxDo+WvF3m6aDsbOja3p7WWdQw9v/N3hMTLdpO2tL9tE+HDzPXLgQzg66?=
 =?us-ascii?Q?HqS35cl8mdEQ7vTfNmRlv7m/kJx/9LCgOcgyVSnSEYWT/BxGqTgJLnP4Qi/2?=
 =?us-ascii?Q?PXBY3LshqlImYEi5XHquilX627gjxeUR5YGwLYOfhbhAKCuIFRk1PzNYF7Bl?=
 =?us-ascii?Q?+LgoC0DtKUnuzMD8EH4dpHMVlmBDHEfm5SG1ibXQnVK6QrcVIfVjXlhJdinN?=
 =?us-ascii?Q?TSQAqD8Hwb71jCWxhtbw3BJWSyV7FXXO9GOIpSin+Wjmy5hpTyY9cni235jV?=
 =?us-ascii?Q?MVWtFYStEzr4JWCQv0QoER/iHwYuOGTnyVuKkgrWVuamh2WDpcPstVfswe0q?=
 =?us-ascii?Q?3oSAgZvZFaR6Va+LzZyV4FRMdC0f9Facz4cC7w01GYHqQVYNC9K1unwoRua0?=
 =?us-ascii?Q?PZl0ZiXhuhstrIpIhRR0ExOfuEi/drIe5EdSfMr3OfJbr5/O4Mo24aXWCtWP?=
 =?us-ascii?Q?mfKptZlvW+oTIHZisWiTutejWqO4XPyyyCmX007IBYgfwYshfK0DbnpkFzUc?=
 =?us-ascii?Q?oRlMQAkkifU2duqD60iQZktqp+JXqmsfbYnktAVvsM+Ix0lZl0uvUq0HXgLF?=
 =?us-ascii?Q?1DemoxbmbzNRa/jF/sdBMEeUvIZLT1PedsU7KeufLj7znWkzw3cc3QOGPgwn?=
 =?us-ascii?Q?c0HG7w4pB4fYL4asn9xCNbJOUA5o1NGiw/T2I6G5v+GQjOBbOCnNkkZGyDHJ?=
 =?us-ascii?Q?JvQdkBZ69xMVY4s7kW4ZowM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c06ed7-7bf4-46f3-3f7c-08da8c002fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 09:56:05.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZvy7b2BlyzQtaiP5mrYKh05ZicPSojEHkc8ARBuDe2mz7KORZRSnpJmAyaOAdPMPFVTVbH078W9Hs+hPa7MdTJ6JggUGcP674Bfx3O5Zr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5778
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.09.22 09:43, Christoph Hellwig wrote:=0A=
> +	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> +		struct btrfs_fs_info *fs_info =3D btrfs_sb(cb->inode->i_sb);=0A=
> +		struct extent_map *em;=0A=
>  =0A=
> -	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)=0A=
> -		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);=0A=
> +		em =3D btrfs_get_chunk_map(fs_info, disk_bytenr,=0A=
> +					 fs_info->sectorsize);=0A=
> +		if (IS_ERR(em)) {=0A=
> +			bio_put(bio);=0A=
> +			return ERR_CAST(em);=0A=
> +		}=0A=
=0A=
Please use btrfs_get_zoned_device() instead of open coding it.=0A=
