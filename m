Return-Path: <linux-fsdevel+bounces-383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD2D7CA3F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53497B20EB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8251C6A5;
	Mon, 16 Oct 2023 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GnNYTVAF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KqZw3e6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDC18047
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:20:18 +0000 (UTC)
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0255AB;
	Mon, 16 Oct 2023 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697448016; x=1728984016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=utuckHxdGobixYh9wdn+26cFfN/BWfxl7CHpScbq9mY=;
  b=GnNYTVAF9ONmPGVqCBBMjSi+aG5ZzvnPPOxT2b64Hc3zfip8fqTzy3EU
   OzTYmSRhKhur/TsqDTt7CKVTYESiKbTtFblH1crM69ztOt7PEYmeFSiFO
   UKlJsXJk2YaDBSA92KNEGG2FVjxHphr+ZGoJrwFVZ+mMCqeUBxtvpS+TQ
   xI/fnOWlSmqvOd4cSEchvCtELJ5AANzPkPYVq1jRhXIJMGam4hse6TODX
   imNv0uB900UKkQR76O/SDrn1XiopxE5kRJLtnjKH+Vui3/bBf7iQMbtZa
   3Cv/nb2yAS1hD+Od7aCia2VobPQ8gzH5e8Molk1DE2qORXNwOYjBUzFmA
   w==;
X-CSE-ConnectionGUID: GyNdhyv3QqWRINRD4TNx4g==
X-CSE-MsgGUID: nJjVMA2nRcGX3FMfmM6gEg==
X-IronPort-AV: E=Sophos;i="6.03,229,1694707200"; 
   d="scan'208";a="244730745"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2023 17:20:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHuQrqvk3DGyRIAwzK5HayGbLPAOl+SX69zO1c6q17HhhKLj38m7lC0GBd3As2DXtlFDpPnTRNdPCXZrQuV5y+NE/m36HbshLu6WcyZ+WBIEj1ZwAQyomHd20XcJZA7OuK9z79NjuhCGak0bQH8vpeup29ecrt297eMLr65X/VgtkkwdLSDq7Uw+cChcY/dwG9Ec7SM4R7Z64kII0PNXKhA/EpkoaqR1fZ+bQRnkHNFt3e7T/S8PRD6QLB52x8M6Uu+KTN8vW9+Mr8ROtKmgz4ylQcvxyuidSksQhmIYf30WeWJdwsASR5ls41WJWbrJ2SpIYMWSQclDMA7J26cSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG2Ws3NIjy+q/n10MKyj4XHnV92W6l0lMMnha+1+qDY=;
 b=Jmd+I4WaXrDGp/u4hCS3FBp5Jap9WLHYBOwcpYbfFFOc5BjB2tC9oLUngKH/SHEfeYyLBSIeL/mr/5lofi/9+AF3IhJlq1Z0kD5fbTHBkIeSXj+g8qQd7aEiDVSNt7I8a5NFiaMYpgAjLDDQ5x4xuhUtPKlqiyJIGiPM+XMjy/sleWMJ7DgZoCYCQgqJQzkBU6pXR6CKAytnIg0e54HWb9dWdBaNHi2wTnHyUM1t7XQGBrkZ6gxU7AUR0LuYJomfI7fI+cId4emRr2/K3jH6AP2xz80/JhASxlYBMhAgev23/SvR8LwCJM2pbAM6d+ophJim1MEfLoLEKUFoi4hbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG2Ws3NIjy+q/n10MKyj4XHnV92W6l0lMMnha+1+qDY=;
 b=KqZw3e6s6BqyTTTUeHpgmknhK1U1Vz4GMooFagsm6Z/EfZlyl9wE7/T5fkrquW2xJAlc3L1wvylKVvNELRcbeReSZkKEPanwF24XpdPIbDdPUDQ5ZO24CNFFeqdoUXZTEprEcchbVFcGmnOXtxmjr4LiWJSrlPV6WSWOm+YxcXs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB8355.namprd04.prod.outlook.com (2603:10b6:510:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.19; Mon, 16 Oct
 2023 09:20:11 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6907.018; Mon, 16 Oct 2023
 09:20:10 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Avri
 Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>, Daejun Park
	<daejun7.park@samsung.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Thread-Topic: [PATCH v2 03/15] block: Support data lifetime in the I/O
 priority bitfield
Thread-Index:
 AQHZ98QEzxK1K1BQ10ix4dd17lPdvbA8bDoAgACkDQCACAl4AIAARiqAgAEcigCAAHeSgIAAjSEAgADFeYCAA+3CAA==
Date: Mon, 16 Oct 2023 09:20:10 +0000
Message-ID: <ZS0ASN6OY0KeOx+C@x1-carbon>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
 <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
 <4fee2c56-7631-45d2-b709-2dadea057f52@acm.org>
 <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
 <ZSkO8J9pD+IVaGPf@x1-carbon> <2f092612-eed0-4c4b-940f-48793b97b068@acm.org>
In-Reply-To: <2f092612-eed0-4c4b-940f-48793b97b068@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB8355:EE_
x-ms-office365-filtering-correlation-id: 5d8d1a34-0f7f-40f8-cb9e-08dbce291874
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XKBAlEFzXlrT1ArQL+2xMem+LsAqRlYuEV16GAfOiBXZ9fGfWtsmERBGSAwzk3bmcCyHZftONRtD34pqLBQHQR9/3oIEIymZpB5LIJGW8ZjPZovW+EIdXTeVs5kS/chBn3gjylW+thl1vWXVQ/WpQ8/S/ueftqT0XEWfEmDNgYSKkJRGtUMxhCQAhsex/saf4zFwDHQQOaaI7geqMCClN+gMx81atrYs0BCc3COYy1cCaa1U5YJyftWQDMxWzxjZMCwMOyQX6CYCzgnx/HF5DWpHxYCM+qdgSsAQ/ZMpgI95NvhP2ZOdPvB6XRl/HiqfmBJ7gXCfrLE1Zl/sVlSZ4E86KIPppBFELjmrHkZxwNbal6bIZ3WdAn8gbevFTc2REUOfrwncsNmg3FwdfrLWQ0HPhg7iTP0yk1R+tW1Ir59hIhVmkA5N3afnuBja3J9dgnun6nvEbfw33YPs8XGvmIga1od/EXEWRSyU3ywLCdDKjNoipk2+IXVxtMc1tYdP6MStYn61/KOUnR8ayxb8ZtVjPfOxcaU89WZkFT+lbTIpY2L+p5ttNn4V6lT4gJHYuLGTUJsgHuu5u8rgWMmuJz4KI7fzKBPH07GbLtPukfhd5OmSGTWu+dAzj7V9Ott2jVd/eO6yX9hAeClSKrqivw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6486002)(71200400001)(76116006)(91956017)(66946007)(66556008)(6916009)(54906003)(64756008)(66446008)(66476007)(26005)(53546011)(6506007)(6512007)(9686003)(316002)(33716001)(4326008)(8676002)(8936002)(7416002)(2906002)(5660300002)(41300700001)(38070700005)(122000001)(86362001)(83380400001)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QKMJnHl7FXUQflqjt0v7BncnXUCs24PogFsjY7I0mSEwYxaFJ8w7SNyKN/uo?=
 =?us-ascii?Q?9uoTZiJthZcpepdNxbNIyfEcCE4ncOjkwRDh1aWjvgzMoiVL6mHidoOqOJpy?=
 =?us-ascii?Q?NfDbHyz8e6a8KYp+00QDiGg6lsuE7LqZhYkNZFctgrTQNUsSXjQfiJVKz5ys?=
 =?us-ascii?Q?IL/dlf1oc0iPplnq/PKarjxIbjGo+vA5s43RTVrZnfq9kDHpPwDXVOkbKi5G?=
 =?us-ascii?Q?CxwZjACU6/lSuw09Tr2DcBpuD7koKa1xAoWwbHW5jSFJ9i3jD+1UKbPCRjq9?=
 =?us-ascii?Q?d+SJD3+HAePTwi24nQicA3vqPgA+T+Tiv+K6ZJKtnUbcArImhVQtSAjSNR5p?=
 =?us-ascii?Q?+aCe4gzYBNayFwcJ3RiVmRNSCe9+JAGAu8IvYjxWoNP26TyNz+kKhrt0wpKJ?=
 =?us-ascii?Q?EKxpznnif1kWH4yNdUygHgdaddKgw7FJcRTz7F2V+ZcI7dW+FjRbznj3+v6I?=
 =?us-ascii?Q?uTcxyv/oG4l6tNex6rheU+da6rvlBVpPEWABD+JXiqa/u52ZdEm+SN5WKL57?=
 =?us-ascii?Q?hMNLKo2psbfwS5mqsn7+eHr6dCxP4xpuCz/K8aBfN6roGTAZzZIoAQn1Vs7A?=
 =?us-ascii?Q?tYAhwDutNV62uiosBSSDWk5Y1tW8WSLuYdglkDOwg7F4Zm5r1T5S5QW5kGYC?=
 =?us-ascii?Q?7NkOLeaOvM2TXZ/s86thVSR02/734fU41qrTrbt5K+FeYDRqiBETQRxwN4qL?=
 =?us-ascii?Q?kx86eQFVcq/Ek22DIOk39JlouWqATWY7pufIs0E6rJ+rGfMfCBAKgMtzXnLP?=
 =?us-ascii?Q?Ubti46/rMHg5xG0Yu5tR7euLplbxLQY7w2qpjiIP5EoNCgs50GmAaXINTZK+?=
 =?us-ascii?Q?H6+tsmLJUhqgCfA4p4mb7yGfmnj3FgOR4NNIzJQRjU5G4k0VQy4swdY/tR4y?=
 =?us-ascii?Q?SNvq0ko6kWP/KlXAmiiQt7fDzE7avS9GUzZvAttc7W2UQvmHamOxgbPer+Q5?=
 =?us-ascii?Q?gPJ/fGzqSH4a63liiVpLplTiJpGUthd8MMR5IttRgale4GD+KrynkMBuyCTd?=
 =?us-ascii?Q?gtE9yAsIVYrvmJgyQcHfobd4VC31nDgFCkZjBvqLhYQss7XLmjoPvNWIIW7T?=
 =?us-ascii?Q?4mjAS+MsN9RESLOJSFC1w3GhdauzorNsJhyvYXtCfGTeQBfZFWsq1Ktj4u2x?=
 =?us-ascii?Q?ZfbGZ4zkEyG070hxNdXN8UXK6m22bGFIEKPbU2pqlPZarruwsx9roOA4jz6w?=
 =?us-ascii?Q?NAyrF9/+El7BZ38hcnWVeTgk6udt97TOvLeO25hGBXMLK4sXY16DGuXlA8za?=
 =?us-ascii?Q?iUg4DUbbeB5QS73PICazfdR9szExLflM/s1XhDQU158DKxHhEbord5X8IHvm?=
 =?us-ascii?Q?OS3U5/rjZYAcbnPqX2fMRfzNJJiagGN8KrpB4wbvglJM9xIyYnuMVGWbDJpr?=
 =?us-ascii?Q?gvTrzYwuclO/AYxTMsdfuvweerZf/hBhUlKdygUI5zcfwB4H22mGpxPicPiV?=
 =?us-ascii?Q?kCNmvnDKcwv/sCze/l7QhtNEmoR6t0ODwQDj3FvxGHZWl9W5Z1QDqqnO+URI?=
 =?us-ascii?Q?5mf/dUuFNAr9gwka3A9JHDorDWPPtGYvWZSTnglyD0ctEHRP4RclqAIrh8Xa?=
 =?us-ascii?Q?NwSfP7u9tc+Oe0BvQe5tZeMN/EsSPa7aTg6aZ23ypJ/9JX1SjOipoVFa/M99?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE52232292CDCA4694EB62FA0FED060C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?wEQUFfzUeU4DUK7YYvHSuL18jmKY2Egq+K8yl8huLM3oSesbSgSoIaQxVL3M?=
 =?us-ascii?Q?QHC+0HS2UWqKxPxleajKt5ofoOfTpcjialuFJB7LopoZqtNMK357BaQi9K9q?=
 =?us-ascii?Q?HkEkb/HCRRI/NWLNTM0clsX1amIMIR+rU6grnPoGuGi6c1XP75uXYsapW/rU?=
 =?us-ascii?Q?P91PNBwUMONxbYedDLlk3DCHDdmHR9knGuKAbGPmUgUT/H+S/Xgh05l3yC+t?=
 =?us-ascii?Q?xNEm1tlFhYWJ3T/7gSzcS6yNV02KnOFMEz5kZUA0zMtmBqQj5CzrK35i5WqI?=
 =?us-ascii?Q?amL1hAa/u5qyFJ0xb0gnK9nsuwgHGDs02zLjQB/k4Sb5hF0K0q4F871Y1kST?=
 =?us-ascii?Q?Xj/YCS1XdLwEx69fFcakrAl638J+aSttnWsWahDETLngTDBnoGMK0v3nHFXZ?=
 =?us-ascii?Q?ylSuxJVIdt/oFp+lQabqPYebIuO4u+zM/UM/88ivOEpjYhIW/04ercRWIP7G?=
 =?us-ascii?Q?wC8gSXtBZpF8neS0P8mwzSAnI+JLCk6f4/FZcdlZ2xljUM8LNB5jsVPNJnUQ?=
 =?us-ascii?Q?xi8CkLkNwSnx5+BnSBjCRxsyOLtneA303cnf3HoURinaK6laLkynNZOdiB1o?=
 =?us-ascii?Q?+MkpDHtj6hw1EhA87D++NQDo59TT13S/qAVIzcMIspOFmcmuavLEXcFmILH3?=
 =?us-ascii?Q?vSgWOtjhaxl02TTqVpcry7youbVe8pJmn3gkFgoQ19Qm3hq2r5gG7guVKUET?=
 =?us-ascii?Q?0u8QnGSwUiLLlUoa6PGo+z5r0dzLxIPcd9y+eD9LHThHfM3rJead1SAKTcVI?=
 =?us-ascii?Q?RTndzj/LFffuaDS3Y6JOk5sjqAeOSuYISrqIHup+4VesFQYmibeiLoOWwSeG?=
 =?us-ascii?Q?EfAoMYKbYhv5qegFxYFXeV319zVuN7+zQqW4n85FYC28YWpDz3QRzy8OVvDJ?=
 =?us-ascii?Q?Hc90cndMX5zB9h1LvKLY9+O/YqC8WUnIOYpei5qFvjjZV1WVCtTG65GX4y5k?=
 =?us-ascii?Q?0JUfGAjRoYV4saaw9OdgdyfyjgZSu0Wl4Hg1As4PiL8=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8d1a34-0f7f-40f8-cb9e-08dbce291874
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 09:20:10.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1J7RY0bfVkq8Psxyq1CoVWHnrdRV4Muv9873nvAQafxKvmXi2neW4UXf/xsZyFybJQxf8gzNlDgqZyYSXt1lWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8355
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 02:20:23PM -0700, Bart Van Assche wrote:
> On 10/13/23 02:33, Niklas Cassel wrote:
> > In commit c75e707fe1aa ("block: remove the per-bio/request write hint")
> > this line from fs/direct-io.c was removed:
> > -       bio->bi_write_hint =3D dio->iocb->ki_hint;
> >=20
> > I'm not sure why this series does not readd a similar line to set the
> > lifetime (using bio_set_data_lifetime()) also for fs/direct-io.c.
>=20
> It depends on how we want the user to specify the data lifetime for
> direct I/O. This assignment is not modified by this patch series and
> copies the data lifetime information from the ioprio bitfield from user
> space into the bio:
>=20
> 		bio->bi_ioprio =3D dio->iocb->ki_ioprio;

Before per-bio/request write hints were removed, things looked like this:

io_uring.c:
req->rw.kiocb.ki_hint =3D ki_hint_validate(file_write_hint(req->file));

fs/fcntl.c:
static inline enum rw_hint file_write_hint(struct file *file)
{
	if (file->f_write_hint !=3D WRITE_LIFE_NOT_SET)
		return file->f_write_hint;

	return file_inode(file)->i_write_hint;
}

direct-io.c:
bio->bi_write_hint =3D dio->iocb->ki_hint;

buffered-io.c:
bio->bi_write_hint =3D inode->i_write_hint;



After this series, things instead look like this:

direct-io.c:
bio->bi_ioprio =3D dio->iocb->ki_ioprio;

buffered-io.c:
bio_set_data_lifetime(bio, inode->i_write_hint);


So when you say:
"It depends on how we want the user to specify the data lifetime for
direct I/O.", do you mean that buffered I/O should use fcntl() to specify
data lifetime, but direct I/O should used Linux IO priority API to specify
the same?

Because, to me that seems to be how the series is currently working.
(I am sorry if I am missing something.)


Kind regards,
Niklas=

