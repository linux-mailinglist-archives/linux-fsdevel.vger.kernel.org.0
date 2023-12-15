Return-Path: <linux-fsdevel+bounces-6186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB6814A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE281C24605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9E30359;
	Fri, 15 Dec 2023 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PWW1g6hN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EQGhDbDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEF3032F;
	Fri, 15 Dec 2023 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702649604; x=1734185604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=PWW1g6hNEHkHBohkAR+0eapgpkvzd7BsWMu6uSWR9tyUjokpOcQKyT0A
   7Z1yJVdM7Vq1mgSjZVbfrIg79ht6830f4mHnmtoMTS6TMnqsMuYBNQwVv
   OVF6egBxneq4E5McXS1vxzOgLpM22F/ZzBU/V+TJodSiXRb1KjqQ0WcS6
   iXeW2chcY/TA4Fd/2ZH8ZvugGCTRYybyAH3SwLIsYoOr4I3gXFeJIWdR2
   K/bkTQiIeG1zZRPjOn61ECd+L6rZZKnYcLZvstXiz0W3U9EJZ7YBgn8pf
   dCrtpivjGEh4HQFq7hvbp5IxQ8MUS3Br9Tx7FjpJ/9O6qvub50qpnVhks
   g==;
X-CSE-ConnectionGUID: 9mDbTtnLSYm7JVdVJWsbxg==
X-CSE-MsgGUID: D7mB4GPNQqSjV4s265Olmg==
X-IronPort-AV: E=Sophos;i="6.04,278,1695657600"; 
   d="scan'208";a="4748581"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 22:13:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTlFum37lQPedB3hJCOCfHpBN1jNHPw+t4Oo2qe01lwmPIs171FlXEqrC2og95FZSn6bo5L9fwTKSePVPQcHXi8Df/dU6A4W3TCGNOFD3gqssmgs5+pyC9lID4LX2cr5wUetTX+g2Q07qQ916SEh8aPsgL1H75fnuyf3CBBYUQEgcOchrw+ypYfeFjgneWF1PeGZTILir04eV66aGGq4HkeC/MNctsQbxBSWONpKPZpOq5EhyvOz+AupXacRjRqXWtoyNkaIRV/yYIvY0MV+rPtzFLR9fpc80SPWZXdBqHYKt57vnFBMKl0SKVh32fqelFmsN7xTKgll5DNu5we9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fKTYfwWclA4Jiiq7hDllkd5izxZGiswIcvABCpVet0oCoT088cufwtKX0djcszM+VGhTFfLR5E13L8vn1Njs8EAx43T5snnvN1iNF6RDMTiLYIFew0XP0yEtWlJF7KrfHgqQb1emVs4nBBdtMk40WPHJaZ+aAkHOmUoGkCujYUJEQcxDGFY15niCte16kS+PRdGygnZf2o4tJe3turW0lYrBCv/rzedKgWEOvM49OzmGdfVjK03U5wEptyyJs/ae8BLXg+uQRkUkLnDXshjOmcAzhyCVljOIviiC4r3YEfmT5CjXuX7nsyBathhki9PbIHd0az33jqKx8Y4ZwEw2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EQGhDbDTKwJcKcOX3h0ogB7mgvo7uDJR7TQud+P51W0N6Enl7G288w95aMY+UUvkAZCrBN9Aii9BwZw9XOU1QLUg4/RsCy7dizJ+DF08ixJQNj9JPvmXLjQH9Aw1wXVYLPlB8JZREgoPDaHSLUaVV5WOOf0QMQKPIOg56Q5MQWU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8400.namprd04.prod.outlook.com (2603:10b6:806:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 14:13:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:13:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Daejun Park
	<daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 02/20] fs: Verify write lifetime constants at compile
 time
Thread-Topic: [PATCH v6 02/20] fs: Verify write lifetime constants at compile
 time
Thread-Index: AQHaLs4TSSQUYUMdlkS97oBPA/mRPbCqZBaA
Date: Fri, 15 Dec 2023 14:13:18 +0000
Message-ID: <58283c5e-c2b0-42e4-902f-59a59e89e961@wdc.com>
References: <20231214204119.3670625-1-bvanassche@acm.org>
 <20231214204119.3670625-3-bvanassche@acm.org>
In-Reply-To: <20231214204119.3670625-3-bvanassche@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8400:EE_
x-ms-office365-filtering-correlation-id: 7673243f-2ef5-4861-d3f2-08dbfd77fc7a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V5SzWDiR24OrbyIFlRCVj9bvjY/G/rLj0hCemgK9OXZ0kq6b7kCo08zjmTA95j8TjCpDXLnjq0nlcqZl3BT3AfI0fVpQsuURhQJRsZpjI/uf/o1okMEzYH8HKayyBzzG8Apr5EUrMLagNZ16yKZUvHT/ZyN7rur3wcwcmJmkCJC2UYAZksmY+6UhC4oWlAaZva/4hdaRit2vPUUzs2IHYc6NeGrv8eE/o8Z0icqq5nGGmQ8nzbyWXF5bzKcpa7uHVWfgcAez+2xEwRFg3aan0EAvdBpYiIzHI6vJHVA0ujg1qYqaFvvIYZzZaJTuPvAn0d6K3HYgFdzeyu7vg75EndfAS78Aq3r7R5vJBTDUTOEZI4XXEs8zSL0dSR4xzvpmmcvpMDFrKdpbExl06t6ZxPEeF4EABzFLCwR5+SoRJPhvS10qwte9UwmEXf9wFyqFrYCyQLBBLiT6z6uHKpqBBpMO/vNr9kc8z7D9mMSsOUxa8NO/3Shmz0TAs8rmMe0jA4RkmtTv0uxoedmMcL7MDJAy/lj2pxLYAq2QpF2coyiEVpTCnoj1Ola2HvrM2HLRYnrCOAou64Yoe2ObLt6vunW/d6CCJ02gLB/fSgx68Fj1l90IiBQ7PxaDXb6P8Tf9se+d7LGTpK6jQFO5oTPZCp55X7MgNB8n84QmacwpoGJHxl4CenXBNp6XLNglakH5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6486002)(478600001)(4270600006)(82960400001)(6506007)(71200400001)(2616005)(6512007)(110136005)(91956017)(66556008)(66946007)(64756008)(66476007)(54906003)(66446008)(316002)(76116006)(38100700002)(122000001)(31686004)(86362001)(8676002)(4326008)(31696002)(8936002)(5660300002)(7416002)(19618925003)(2906002)(558084003)(36756003)(41300700001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmJ3NkgybCsrNkIrVzNoVnNhMVlQMFdjYzlCcWZKYmdRZ1EyUW0rRlpWU3FV?=
 =?utf-8?B?bnN3cjU1UjdmaEhYOGl1VngzRGhEOHVuc3BLcmcrWDJiV1o0b1M1RGpJbVBv?=
 =?utf-8?B?dXdzT0VkOXhPbnc3WGRMeWZ1ZEIweHp2RHRINm04MFBLTjlickhjTUtIRjR2?=
 =?utf-8?B?cnVSdm1CcFZtWi8zcXZwTDEzM3lXWUx4UEtjRDNGSWFtMVMvYzFqSmkyaEdB?=
 =?utf-8?B?Um5xdGFpMUJROTZGZ2pUQW9pYmRkSVpkaXR5UFpQVjVKN0V0amZsa29Wcjh3?=
 =?utf-8?B?UGJyZ3lYUVM2T2pQM2llVS8yOHhnWnNmbFZNQmtwSjk0OFlCVHlDaE5QQU42?=
 =?utf-8?B?YWJUMmlaZUdDVHdkQ2tNKzFTOEE2WndMUWtuRVh2VG5OYWt6VEljT1BPS0Zh?=
 =?utf-8?B?OWdCT3hDYmJXZmJtMDlqQTc1ZDUwNDdITXMvZ0t4bXEvanRHbElOUmdUdUFL?=
 =?utf-8?B?REpJS2IxcUo1T2NseGVkdjkrSHVQQ1U3aDB5Tis3THYyTDZHaWFCU1A1R2pH?=
 =?utf-8?B?dUJjb0tXZTQrWUF2QXpxQjRmZXhoSXgyWWFDeDdRWXRKbHNSTnhyeER4WmZr?=
 =?utf-8?B?QUtONmNKalBKU3lmVHZMa0dUdVRxMUhZL3ZiYWJMQ1VXT1QvUXIraG1OVEFa?=
 =?utf-8?B?NURXMVN3VFBTUVA2Qkhla0plb3lLSzBNSHR2N3FqazBmL3Z4NW9NenRNeUs1?=
 =?utf-8?B?Nk9DcXMwZ1ZQbm5ZcnliVkZaZ1hoRDF2aWdkb28vbWJNeUJRcW43NjVjckFB?=
 =?utf-8?B?VnBJdmNycGVIMHRUOWpKMXhudTE3dG51S21mdXV6MEp2cmE4L2VTa3EwUFA0?=
 =?utf-8?B?QW5GYms5UVNYRHNqS3pXYWdsMVQ2ajZrUEFrY2hiRGUzUTI5bXBMUXZRSjFH?=
 =?utf-8?B?QmFYZUZURk9zd0M1KzFFOFRGTUN6cGNkTVpXN29ZL3lTN2VpUEJEd2NSZkF5?=
 =?utf-8?B?TUk4OUd6bXd1QWlRaGRrWlFkclBGZVlxQkllNmJlVUZyTFkvc1BVc1BFQTFE?=
 =?utf-8?B?QXlUdzhKZW9GbnVtZjNjQWtRaXJPN2hMWldjcVY0ckRCMWdlbU1sU2g5U2t3?=
 =?utf-8?B?Zk1qTEd3eTlNaTl1SlBPNXlPaWZDL00rZUJ1dUQzcFlBM2VhODBxbE9aN0Vl?=
 =?utf-8?B?SEs2NlQ1Nk82WGN2dXVOZnNwOERIWktpOWxwSElzSllXNk9FZk55Y1F6eFIy?=
 =?utf-8?B?cEZSWWp5MlVvMHRxdTZWd3RSRVJzMVBKSkVPd25zQU0zdXZGVU5nenJ1MTZ4?=
 =?utf-8?B?VUJ2TFBYQzRnNkdRckZKREtiMFE3Vk0zQVlsZ3UxcURZMlB3YWtWQU14UWpJ?=
 =?utf-8?B?U3BlbFBCc1VpOWpPYk5SdUtJd0RqT0o1azVubS85TWUvU2FpeWh3eDVMOWEr?=
 =?utf-8?B?Nmx3bzVaSG02OWNXVmtlQUFzQ0gxTkFlS3dodkQvcXNyYlhqbkIyMmVZdmpQ?=
 =?utf-8?B?eC9QVGwzTmtqQ29kY0hqVUk5bnpGRTNhOHRaYUdNMUVEakhsR2Y1eUdtMjRP?=
 =?utf-8?B?N2YwM2t6aDBhN2ZtOUhjZk5pZkY1enp6LzJNdTVRQzhxclBXS1dVQXZQbjZH?=
 =?utf-8?B?ZjhuMlVNNExhYUdXQVRiSWwzLzNraEVhb1UxVSthOHhNeUNZOWVwWWpPM3cz?=
 =?utf-8?B?RkU1blpnR0FVcXBSNGwvMnl6RllnZUw4M0lIaDVPcDgxRUZVY0laTCs4QUdx?=
 =?utf-8?B?UnQ5MFlMTWVFQXFWZ3hrRndGcVJxbGp2MTIxN0lVKzNSWjYyRHk5OS9SZDM3?=
 =?utf-8?B?UU43S0F6bzZSb2tuMzY3emo0VGpFU2pHOElDT0U5eVYrRXBKcVFMTFV3TFh2?=
 =?utf-8?B?VEd2Q0pXSmVYVk9mdG56NFlaRll6QVNhRG0zL05sUU1YYlRSbUhIR3RVMEk4?=
 =?utf-8?B?cDNqSEZHNE1ranN3UkpmVTJ3M2tzZ1ZHOWs5bm9WdUp5ZGxlVzd5T0hDR3lj?=
 =?utf-8?B?dUhpRENpd0w1a2RCREwvcGlIdkRKOWZYeWt2b2FMTmlNZlplYjZzL3Y1YkZa?=
 =?utf-8?B?bnVnbmhVcnliR0lSY0hHaG9GOHd0OHlJMmFzMVEzSzBtblc5S3VTVUJWQjRh?=
 =?utf-8?B?Vmc1RjNRSVIyR21sSTBXeFJxWDlMSTBFM3dhTERwSUdVdXpvak8zSkUrVzB2?=
 =?utf-8?B?M29wTmg1RXZNdndPU1pZZWVpRW5MMTljaE5yNC9FZkNFWS9JNCs3dkVTZ3RN?=
 =?utf-8?B?dVJVaWtXRHFXNFJFV2NlbXBKNUFFRTFkZGJhNVlGU3NBRm1vOGp0UWNXaHd2?=
 =?utf-8?B?MjdYeXdWRWtOdWxKc2h6aEx4anNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA90AE7BC930143AD19B3DF4EE69008@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DoOZlqCumZBOGw2CzgP9+F7fRvXIs5kkTZGm7KPqLdE6lrjqorHBa0PMGGtexPr0IOW7MWM/iTV0fUZi6jKS1b6gj1FFjU8xVbPV7l97IsXhnzbqsgcvzLLZbqQPmv4TzV4HoN+3C7DcFpqRI/Fu2B7ikiPhSakPFr+D9/9RXAOwk5qmkBP0l3Uxt+N/4jy/EgKAEqfqr4nRnqK/eTe3RShhpZH7CCsQ8G/HecgBDnhEPwhUy2AOpvZ8I5VrVvblDyF4ETfys/kCNOambdptI41k13rIq6SYsHuljywmmDlUDHFjdoNaEcLAW/BaCzZO5H5CdmrXNebO9nLgQXLwy6BkSHoeUQ8TXSZGVzueJTSdlMJ/qQwo8VKC0dcXsMXQ40eP2WyGK5n44diMf1/psQdpt5LPkEvmQcqIzoToKbX8Xda6hEJOLXIMkXGczz+QxGrMP6O5H9TXJjXkAyjJppZ3hQXI/VuRGFe5qjHgvNoB/bqenGPapPTx5YTbro96ynPzuqc94MjxdkU3eX0GElVf5eXlyYDh2vfxQgeber0Liw9/2r8ScZo+aTgU967/+y4yJUYJmvPHwuB5QyNDBVgjmAtz3nPwGW6OpKEvNl26n3/hmyoYcrUimNbeS5RA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7673243f-2ef5-4861-d3f2-08dbfd77fc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:13:18.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZ72nr7wNuZKkkrzTkkYd2ABilv5MBDFPmCStOO5cxqMKQtkE0avknhx3DN1dV+PTBhBY3efX0gipe0vVk5cEr/6b4jhtvB7TjJPcmIFRUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8400

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

