Return-Path: <linux-fsdevel+bounces-248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAEA7C821C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 11:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308001C21096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2F1118E;
	Fri, 13 Oct 2023 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eh1u6PE2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lMVWz696"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922310A11
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:33:46 +0000 (UTC)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2895;
	Fri, 13 Oct 2023 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697189623; x=1728725623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rOP/yyFk0P6Uu6+WKOTrtjSbAkipHQJQVWzIeJqZem8=;
  b=Eh1u6PE27sfz1nM+KXCnZpn9iIqax1nM6bNYkuflA1YQzAJ/4EH8H4kT
   zq0s3j1PWrjvXBYR/VgPNlOnV/LDEref8Qaiebrmj+y3gkf2sI6gmYyCR
   DP2YHs6YrYER/8vXPK0uDZ6W3W9SRIIstbPk1ZpbpBdriWjcQso/amNsp
   7egR/8AzrxpAy6majk4A4VEQ2GaM8SzyAw3Rl7heCZ1RQZvQvZFoRfZiM
   DQLoeSZjy7E40YPjCXz8llZmawbGWEk3PX8V+J4rvvoMV06lM3aPuXmgd
   1PyKd+Ifo0hfHem5xEeNzk15CXwcYcNBwNfvDJiaQMMlq0FcdaxVKgmHf
   g==;
X-CSE-ConnectionGUID: 0+zKvc1yQZ6EcewFcshxJQ==
X-CSE-MsgGUID: o3MP1IbYRvWku8DpqZieYw==
X-IronPort-AV: E=Sophos;i="6.03,221,1694707200"; 
   d="scan'208";a="358553804"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 17:33:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJrEZeqjHEh6DpmJvdrVdgTH+SpuQLIxCDBpbHP+xuWfr2nKLOBtvWo0Y5dwSIW0S5E4Tmz7rXr7lybFYU1Ik9at3Y0QUeRUqFm98gcVXv79eUW5FMkXLnp+r8EmdiPainQTeJMCAnA8aqbz4rUQjdOab2KkEZMQ9BQW1z2Wcq6K7wJdlUdSSQHqHcpV2U0yyZBYbyQf+iJ1kSRxF4YXoJjOT3gJg6BNcVMhn7fopZUpdvIF+29mDWgm0VKwushkF6vhtHOyaU6lAGYNuGw/AIC4b72KWLWsX2zjJ2srFes1sYwBQVilh5zpBmi7HnEte7ZhkVOrdRjcTuenFIUbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTdvI0gI4Mqujtt5WC/RXrqa/3V5OYztE+Dv9EIA2xg=;
 b=baFWjAkatYdBRQ3VGlTrK5F1RSngIsxbVzr9YUrb8XkgjuLgcoCedsI9ewetfI92xnf1joKzZtKr3hZpImrGfEokKtgSoCgE6G9vsBWIeC3HKPH6bQ3iT/SBmVbVlp0LErBYNHIhv22myJDv89yl40b0QWhFqxBi9Vn6eUpZKcv8smnR4oVpPmr9w1e2T4Jg9qAtvjzJmF85tCd7hS99JOcrB+LGPTxKP1BNZe7ztW5WkG7o/NovDyUK5bgs9af6aszu2ipph26nqoLgFsdm9Z0yrPOkARlVR5mYAIEd24kX06TQHpdS/EbMEsQDSCp0lTh+RLWMIGAkhMkIFz1JNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTdvI0gI4Mqujtt5WC/RXrqa/3V5OYztE+Dv9EIA2xg=;
 b=lMVWz696f4xqtME3zFivdCYGG/DSBpIfNyKs2pYvUMaqjaFaQJuvP9YoqoVZmHs+/mUG/Wk/KjKw7yxmKRw6Dg5j7gZKHMaWnrd23M0mEeLaE6HZxyWISt5uzV0SxeGf77LSepJ8f4ADwkRxoAGsgKyVsZ1XR6sAA9Xx8Kzwtso=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6881.namprd04.prod.outlook.com (2603:10b6:a03:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 09:33:37 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Fri, 13 Oct 2023
 09:33:37 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
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
 AQHZ98QEzxK1K1BQ10ix4dd17lPdvbA8bDoAgACkDQCACAl4AIAARiqAgAEcigCAAHeSgIAAjSEA
Date: Fri, 13 Oct 2023 09:33:37 +0000
Message-ID: <ZSkO8J9pD+IVaGPf@x1-carbon>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
 <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
 <4fee2c56-7631-45d2-b709-2dadea057f52@acm.org>
 <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
In-Reply-To: <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6881:EE_
x-ms-office365-filtering-correlation-id: 49e704f4-c9e1-4b3c-36c3-08dbcbcf7a31
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ePAnpvM1/ptOetayk4F4icvU7I66aD20YoOAW0gibyFSVlxdPuUdJWgZRGWzzhR1dQf+1++g4WMvYn3ABG6XAwhkkwgWVuO5UTUyqoKdoqTMH2UCVdzBJw+BPOMJctO5Eedfi158QE2V7u8bI9m6UG7yqk/973SBJ/VflH16EejvNropvV8kgXeGZMCQnLzyF7X/i4qkPtMwL2LlJLMEHvVvDftd6s/L14huie1cGTiDIrnp4Zly6kEPBY0EXCRPgbiiqih2irm7v66C90rTv2sM9R+WUO1Nc4mkbrbwijMj0Mk2IJKJQFgJaFIb3y/sEWWJUnYL1EzQy7XX96OD6Q1SoyM9mhHXg9N8D9f9QTpvfc8riKnN1NzqVb+5lrj+6ruxrMx+WRT1q4QbXyg4vx5rSUFTmoFcN4TTkjRUIZAPrR4rxlQoKwkqeHnZxCgjKxI2Z7motiQMAABQ74sEHtM3iqK0YVLg1a+uoCCYx+NTX0C0SPbm+NjnHvaHyBHIIBjyVmsCEIoXLKRZ66Oep/SPgrE6VOlJFRFwL/JwonRtfaeHzdI4bnWg1SRvnEgmc1xMPvA/n9h6zW0E4mLNaeES3aslN6lijyMCxVew9SEFAYKPxe68mtd1tWgknERdN8PH7wyIu3Vhl5mg21SdOw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(9686003)(71200400001)(26005)(53546011)(82960400001)(38070700005)(86362001)(38100700002)(122000001)(4326008)(2906002)(64756008)(478600001)(7416002)(8676002)(41300700001)(6506007)(33716001)(6512007)(76116006)(66446008)(66946007)(83380400001)(6916009)(8936002)(6486002)(5660300002)(316002)(54906003)(91956017)(66556008)(66476007)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zeHYg6bWASFCw4icA8MoQM8iXjAaQ+FOPsI4UB6P4U+fWDuTfXLoR2izvYQs?=
 =?us-ascii?Q?lxn+oRcRW2bCtyhPQNoN86qD9ZMWod/dQoIwj0RAehyF+S/NWlY4APqgTu74?=
 =?us-ascii?Q?5+DX2RJKc5yWzn+AlOqo3L1kToIb0vHpsEJPKOJG9Lg1hRC151w1hLQ21/9N?=
 =?us-ascii?Q?9ctk3VynnipWBC+KIP0A+VxK2c3hrMSxY2m9Bkb0Xx2P7aD7jxSH0+rRk3OH?=
 =?us-ascii?Q?1YakdpiZ3d2GaKTU651tTYVRROxlUi73/IqhPZUAXUDXaxs0rOAFsWy8fEhM?=
 =?us-ascii?Q?7zY6D7587vQ3jwXGqzQpOaLJXWiBlkbgqoLraSDd0BfgMk52R3Qw1Ku5xPmA?=
 =?us-ascii?Q?Xmsud1IVs8drexpbCbBix03BBdARec55QCR3wouOzBo/jzD1ek5LZyOj+lF/?=
 =?us-ascii?Q?tJZ6VylMr6KGeroFMsiJWuqGCZ3XMardNwzWbOkVbErQXV3dTmjrh1CpsSWt?=
 =?us-ascii?Q?wcO3OgRzZr9ipRFp315LuuVXIoea6yxl1G+pQ6U0uwciw5dBOwGMrfGdJ3lL?=
 =?us-ascii?Q?dIkg+L9wupnoXCjRKlpfxuxT4ymDJST33XCjwz+pDRufHtdak3xTECvyaPTB?=
 =?us-ascii?Q?lqZUr6oE09Lpmv7a9SVRySIwd8IUp7uYWHgeLpL6VkxT6sQZwg2dEYa7XFqc?=
 =?us-ascii?Q?QZKsZgdQ4s1O+vPIXyUXiLrRkinOwQhlJjh66EU06mvvYzFY/trocoaEgoyg?=
 =?us-ascii?Q?eYrgy2taOP3icZ+LMckpgBYbkVKlcgVWHgqMXqqx2byyI5wzwyHqla8ZdS5z?=
 =?us-ascii?Q?AaDpZi55+s9SuxsJmBwahlORNtt/V7Dc/gUZPPILCG7CCi0WQ+XfefPpgEeE?=
 =?us-ascii?Q?nH6EAtg3IltwKfRJI88xeix0im+dBfnVJCmxDZIJGeHZfoTtiyjA3fPiap6d?=
 =?us-ascii?Q?mzKv7lraEPlTzVaVbzEXUzLsNURETCXhIvN6W2phteTNiYQDyirMZxahFH62?=
 =?us-ascii?Q?y1GBtY9yuI9rkP3rGiWUyE+rz+J6Hqtf1J/SiRhkYnnQFeqi/SCE+uTv0ANz?=
 =?us-ascii?Q?mHit7xclYWnyqVrPHsthrp6EGdDKoe76eIzCCYW6Bx2PI3u+I37p+MH7VRxP?=
 =?us-ascii?Q?cAc4D8UC/TN897SSgXZXQNOju4Y/X8vJYcGLNALVqr5ES8s68x05RNov8ydt?=
 =?us-ascii?Q?ds7q0gL2j6KRbWuVTBU1Xjrc9jbfbIio4MJsmDqlDwUt3MCQl1/ri/vJeG2M?=
 =?us-ascii?Q?d7AbxKUFvulP6k/7f8UuXuC5VFDhByIrfHbtwTtYnjGWNcKPDGM8mg48wj4e?=
 =?us-ascii?Q?0VHu2fQJT/lU+Fa8sQhv7Vj1B40YBYFqgJEkdL+PMRDeu6h4S+Je42V1v4Yd?=
 =?us-ascii?Q?E42qd6i5U+OADqA/KCAe7H8Yjh2Krl09oBBpJLMC4In1yFX2rnVIxpZK3AY2?=
 =?us-ascii?Q?0YApkY5SbYtKtamJ87qTV3HkehFXfk9YnFkyPH5bEVij2ddSdg8r9nsIqGBH?=
 =?us-ascii?Q?NyuKnt6aJBqIEsLieg9aOy8PZGRak2w51wBZXw84ac3tHEee6EPJo2ob5g2j?=
 =?us-ascii?Q?pvlnUr2DZrMQjSZ7Mhb6RBq4Rq3RlYgiCqd9XW5PvJrBXWgkx9j1iZ/OFdY0?=
 =?us-ascii?Q?gKBLDo2r0DVspAypufYC2mi9qNB4Ws9MvrsFXD+ZAOYa9ouJ2oQv8GHPYHHb?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0929EFC5C1999B429228702157CC7748@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?us-ascii?Q?AUNFnBIDUdVg34XdRqf43/qQTH3PjYD8Qcm43gCEI8HH7uCRqeEHOCIN7xp4?=
 =?us-ascii?Q?70ilRjmnFLKAc1HMgkG5nOVsr75hQpy7ASY+NlUtZi4hwcNkqRKgWSJlzP0A?=
 =?us-ascii?Q?8NFTgsnbOYj3Tmjn2JCHuJEZJd/rPbirNz8NxZKs71gK8CLRrMAeaq6B4Rs8?=
 =?us-ascii?Q?dbqpkm0Ya8KburzkRfsexQliDETT7bntkuyQ7+LkPwWGs0QVpnBlShhprwmQ?=
 =?us-ascii?Q?BgaeHn8NTxCyyCFaBM2LY34eBJggAws9PpfXjkeFy/pkqvnTsPwhzl9RpaE5?=
 =?us-ascii?Q?5reHvyweuRV3fbiLblReqvDv/zseua7hQM7AtXqHDE0x4YI2CG5T/ctnLIL6?=
 =?us-ascii?Q?tQehVkNYWEeNbxuDelBGSuCI337ty6iZsX3f+NiCdT+tirWkhDPUYJzCDMJN?=
 =?us-ascii?Q?NrF8YvT9H6X6fOGwKtO+DiwLGPCv/GtnPQDk3n95ZFtF7NAsJ0yOKBCGdGlf?=
 =?us-ascii?Q?tHq9RLmfBD0ArHI31Ym3iaY5k1BbXAMUiJnOQ/B2SFqadSCZzU3NdkxIA+ud?=
 =?us-ascii?Q?qb6g/+FgC546rEyGx581rqc5oUa8/4Hwu/dIjIioQknMuTMD9vFEOFtv9YQ7?=
 =?us-ascii?Q?BKHZHD3fEzP//ZNR9uJljuFaaBi8kwC6WxmPcej7hASbbM1XqAkW2Cv5WB2e?=
 =?us-ascii?Q?7Hbo5Sm21zDLE/3CBBIHYvjvwY1h4t2yPmlY3juxGPCnyD9MOHrhoLfcXB0e?=
 =?us-ascii?Q?MeT90dH/m3BKB7ogtkSEW+NJGJ/xspJcQv76jDvYZh443GmlWL4XLw4DYHpr?=
 =?us-ascii?Q?ezsOXglfquclU/DQCJ20TEiBlDdPRIw/dG/9NKaehFhV0rT73NJBv1CZs54f?=
 =?us-ascii?Q?GE900HgnNV9Wnsy3wFwTvtjyQqrkZfNjfVpunabKGvDYzalwluZ3FIzdIsZg?=
 =?us-ascii?Q?BVzhFp/MvVIVaAup3cY9UkqpkKSvIxVqKEwobFSamfB2Xxybu4ycAaugmGZ8?=
 =?us-ascii?Q?93u4pYcfAwdoqSlzqQqEpVGhAjGc+3XlsYodZn0httI=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e704f4-c9e1-4b3c-36c3-08dbcbcf7a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:33:37.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0dznYFKb6Tpo52CX7h86iD1fDTpTmtxHkwEzLjtBYt5Lkfa01drZ07mBFKb1DQ5Xe0Xr8CEXmwhPbSWq1Jr4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 10:08:29AM +0900, Damien Le Moal wrote:
> On 10/13/23 03:00, Bart Van Assche wrote:
> > On 10/11/23 18:02, Damien Le Moal wrote:
> >> Some have stated interest in CDL in NVMe-oF context, which could
> >> imply that combining CDL and lifetime may be something useful to do
> >> in that space...
> >=20
> > We are having this discussion because bi_ioprio is sixteen bits wide an=
d
> > because we don't want to make struct bio larger. How about expanding th=
e
> > bi_ioprio field from 16 to 32 bits and to use separate bits for CDL
> > information and data lifetimes?
>=20
> I guess we could do that as well. User side aio_reqprio field of struct a=
iocb,
> which is used by io_uring and libaio, is an int, so 32-bits also. Changin=
g
> bi_ioprio to match that should not cause regressions or break user space =
I
> think. Kernel uapi ioprio.h will need some massaging though.
>=20
> > This patch does not make struct bio bigger because it changes a three
> > byte hole with a one byte hole:
>=20
> Yeah, but if the kernel is compiled with struct randomization, that does =
not
> really apply, doesn't it ?
>=20
> Reading Niklas's reply to Kanchan, I was reminded that using ioprio hint =
for
> the lifetime may have one drawback: that information will be propagated t=
o the
> device only for direct IOs, no ? For buffered IOs, the information will b=
e
> lost. The other potential disadvantage of the ioprio interface is that we
> cannot define ioprio+hint per file (or per inode really), unlike the old
> write_hint that you initially reintroduced. Are these points blockers for=
 the
> user API you were thinking of ? How do you envision the user specifying
> lifetime ? Per file ? Or are you thinking of not relying on the user to s=
pecify
> that but rather the FS (e.g. f2fs) deciding on its own ? If it is the lat=
ter, I
> think ioprio+hint is fine (it is simple). But if it is the former, the io=
prio
> API may not be the best suited for the job at hand.

Hello Damien,

If you look closer at this series, you will see that even V2 of this series
still uses fcntl F_SET_RW_HINT as the user facing API.

This series simply take the value from fcntl F_SET_RW_HINT
(inode->i_write_hint) and stores it in bio->ioprio.

So it is not really using the ioprio user API.

See the patch to e.g. buffered-io.c:

--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fs-lifetime.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
@@ -1660,6 +1661,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_w=
ritepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector =3D sector;
+	bio_set_data_lifetime(bio, inode->i_write_hint);
 	wbc_init_bio(wbc, bio);
=20
 	ioend =3D container_of(bio, struct iomap_ioend, io_inline_bio);




In commit c75e707fe1aa ("block: remove the per-bio/request write hint")
this line from fs/direct-io.c was removed:
-       bio->bi_write_hint =3D dio->iocb->ki_hint;

I'm not sure why this series does not readd a similar line to set the
lifetime (using bio_set_data_lifetime()) also for fs/direct-io.c.


I still don't understand what happens if one uses io_uring to write
to a file on a f2fs filesystem using buffered-io, with both
inode->i_write_hint set using fcntl F_SET_RW_HINT, and bits belonging
to life time hints set in the io_uring SQE (sqe->ioprio).

I'm guessing that the:
bio_set_data_lifetime(bio, inode->i_write_hint);
call above in buffered-io.c, will simply overwrite whatever value
that was already stored in bio->ioprio. (Because if I understand
correctly, bio->ioprio will initially be set to the value in the
io_uring SQE (sqe->ioprio).)


Kind regards,
Niklas=

