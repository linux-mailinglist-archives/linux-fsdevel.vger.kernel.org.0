Return-Path: <linux-fsdevel+bounces-180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69367C6FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 16:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051E21C21127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46430D19;
	Thu, 12 Oct 2023 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bJj99FCb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S95F4AKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44B1A72D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 14:03:38 +0000 (UTC)
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4491;
	Thu, 12 Oct 2023 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697119416; x=1728655416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zfd9lCbBfEWxPYzv2snNKh4hYeo3V4UOCJci+qVybrU=;
  b=bJj99FCbNcmA7BbxVs+lO9YjtVTJzAAo642mShjNhJl1ImWZyq0vKMKA
   b+/gohNdpWZP2jOKrNmZAW+RhZpsLaabheetRiupzoO9IO7Q/LSwkV7Ge
   GIhmjEhuBCdGVRgi7D8KDpHpqKPQRcaudjpvXoVX5k50H4XnGX39Ux+6T
   ZcfXFjWrqQyosFjpsYEtdZtkOCrA66Rx9mlPpQp2mtTnvJtuvYwfqWQy7
   5naegAauX5jne9+XtjoNNLWODUMK9+aRd5P0UO+xJ/FQoEGarQu8/4eBO
   4McnKAzxT4gXV2H55X+E7Vfp3XDsJJaopTdXBKHV9gXILOkxRoB/rORfY
   A==;
X-CSE-ConnectionGUID: JPSFTYUYRuGhiwMY5O207A==
X-CSE-MsgGUID: 5TVzScKOQe+t8YyGE4H4cA==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="244483885"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 22:03:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGgVHjfCD/ZkR44sB3nSMle/5dZ8TsVrY3zj1G8lwv9GRp+gVrVW6SGEOOimCbMWxHc5lhlHIs+VWCHdAb/xDqKoYjIpdQyAXfWhkJh5ZhwGXKddl5imz3ibY831M/sJVhVTKt1RQ2oC7piLQIXK/UNUebpGckAzRuDSGS+ugMKKWGDK2peqbtMx7vv1CTNV2EzzItQYtlt7WeiMFJifzUBqTT4P+2l6BiyFAQ186C9KiLipbf4kfCVrvM+p+/LXxKxe3U5zT3KVIKAnOIYNMEoifoTMIUzsjrzCKy3B8tsaK4Qwu/b0W0wLi6/wTQvEwodrdmz8c6g7NpaMvOuzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfd9lCbBfEWxPYzv2snNKh4hYeo3V4UOCJci+qVybrU=;
 b=Qmpsj5Vw42GCrOOU0lKewu1L+w8aCBwpAAu5y8tWd8wrNQZq2qBF0zQuBDPukZ6/H7j8LOoKuAmsJ+gfTeva0ZOlrouxeapr1o4rE04dL4VpWL7J0uU5eWCAD1i93EvJt8hhvUfuJzXvNlAVWwnraHMZtjDMci8iCx1kJctt18JCtqkD8LrgN4tlrnRRGZ9H4LQNr3bxGJryW0Eztlmhus7RKRBlNSpiZq65aGsZVHmFmNYKLHdO42/l3gv70Y7pHHPxgUs0UAgSeDoyJyWWAPwKppZd8SQ6ypZkWpWQpoSbpi3JMOvek18+Xg46cu3KAEh5VgyEIwJcCy5DgOlw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfd9lCbBfEWxPYzv2snNKh4hYeo3V4UOCJci+qVybrU=;
 b=S95F4AKeycut/aaZMvcNdzU7et2XnZqPaZnj74TC0eFOM34O6PPA3aVGhO/ioxPVDzrEafN5o9dvxM3Stcm5LJL94mBOBnk+gk/2WYf3/yPx8XSh3RzL1nc7l5u+Excler+r2q+jUr2K8ZZZXQiELBvjUgJZJovSXs6DXE4engU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6567.namprd04.prod.outlook.com (2603:10b6:a03:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29; Thu, 12 Oct
 2023 14:03:26 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Thu, 12 Oct 2023
 14:03:26 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Avri
 Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>, Daejun Park
	<daejun7.park@samsung.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Thread-Topic: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Thread-Index: AQHZ/GNmB0uMhefUdUmtQGujn0nYYbBF2R4AgABX14A=
Date: Thu, 12 Oct 2023 14:03:26 +0000
Message-ID: <ZSf8rcBYG/8aEcGi@x1-carbon>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <CGME20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e@epcas5p1.samsung.com>
 <20231005194129.1882245-2-bvanassche@acm.org>
 <28f21f46-60f1-1651-e6a9-938fd2340ff5@samsung.com>
 <bfb7e2be-79f8-4f5e-b87e-3045d9c937b4@acm.org>
 <fdf765a0-54a0-a9e9-fffa-3e733c2535b0@samsung.com>
In-Reply-To: <fdf765a0-54a0-a9e9-fffa-3e733c2535b0@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6567:EE_
x-ms-office365-filtering-correlation-id: 39ccaeec-f79d-4a42-10f0-08dbcb2c0140
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oR0yxVMNzhC61WrrCQw0DPwfXdXsaDWkVtrUyJ8yeQMEE6Ygu1dkmCBrrj5rOO70m0e6bOFOI0vEa/UWVA8ZLbSad/Ltx5BOgemRVAuPLumc3b4LlGSKCB5tpMV0jbbelanlwMmRgvNQ23/r/exJDpbJLfmEqK6QySz1MAE3cEvVINtBfo6Ch9Py864JG0QQ6s99KZOmKIX4o405xxRhxhRtR7C13wju5L4iQb7OXAQS2lu+CKkz1ha7dwLnVOWTmzxURGSN+Yp8pSNHo2bha0O85vLUwyHznKsyHbqyc4GogzNI/3apIkoihK5Ie9tFe2mQGJIaF4xb9fDEd/bgKpeqtJPbgmY98ir6QYyua1vF67tnLXmGYagW32FLnd3fKqsvcWujUvqGxZhVBdAfult6Ps+3tYd93sJT1UJ30C7drqWRsgCnrmxKmutsJH/2ioZXYVbZ8N7DIeOdJsrR7B0N44MxPwR1i6mKq6MB2cg8MCak5e2GQktG1q/pWcAS5Rl/pUOQjZuA6yJ/KtVw2BXj5kQsqKp0phNKHIE5qbVwmpZ1c0Dx0xCvgHf/qBWDAcnTAErHaRB6Gbc1AFWOzT4auq8PGILXaGrwl7mhlhnIXguvvo2z0yZ2R+Hg3O7o
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8936002)(8676002)(4326008)(41300700001)(71200400001)(5660300002)(83380400001)(7416002)(2906002)(86362001)(38070700005)(122000001)(82960400001)(33716001)(38100700002)(26005)(91956017)(6916009)(316002)(478600001)(66446008)(66556008)(66476007)(76116006)(66946007)(54906003)(64756008)(9686003)(53546011)(6486002)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzlKdlQ5Ym5oWTV5YnpFUnJQdVIxeEJaNTBpNGlub095VTVlVEg0S0ZKK3E2?=
 =?utf-8?B?dkxLZEEzT0M0TmFuRXZKZldkV0xTTDNSTUIzNm9GN3UwSXVYSGg0ZmlCT3Ex?=
 =?utf-8?B?Z3RXR1NLbDdlcjhTZnhaanFXOGlhenpJNDNjazl4MWI5ZmtPT1JNY0l0RXVR?=
 =?utf-8?B?ODNtUzl2Y0c2QWxOZUZnRzM5Uk9kSlVUWmFhSnB5b05PRk5RSUkwWE5QSXYx?=
 =?utf-8?B?TXMzdFpyblI2emE0ZUpGZXF4YzlpS0JvdVJNT1BBR1VrWHNIM29Va3lNRTlC?=
 =?utf-8?B?WmlOR3pBUC9OOXQyU0NNdGtBbDRoM2RZRi8yaFBoQ2xrT2dYNjBxSkp0WWZs?=
 =?utf-8?B?KzRjcnVkOVdqTlJzSmV4T2VTNERRVmNIL1ZGN29MT0Y0clFvajVJWVJNQmJS?=
 =?utf-8?B?TWhVTXVIVzhRSnVxbVdZTEdQRS9KajVVZHdWOEdYMFdmWEkyZkVVQnYxMmFN?=
 =?utf-8?B?QnNSYnB6bEkyUDJPcEg4WUNRL1lOWHpxTlNwVjlHdXlwck1BVHVyZWhheGR2?=
 =?utf-8?B?eGhTcUJ3VmpPbnlFY1dydzI1S0JyYWVveXdFbWR0TnMvNGd3bkZnajlNMEE3?=
 =?utf-8?B?WjNCTHRFUnExME5RU3VobXdCY01ENDQrNmVlWWpja21FR1FEVnVxZjNIVUhk?=
 =?utf-8?B?TzdEeXhZR3hxbEsvVnlvUHJpUGRJSmNUQit3MWZWWkEzWENXdWx3MU54KzU2?=
 =?utf-8?B?U3RHbWhkdGo4TWVlS1BSQ1dVdW9FRnhLZHUzcklnOVpZRFlUZm1QS3Y4NE93?=
 =?utf-8?B?V1Y0THk3SENMRUVOS1ZCMkd6WUFDMGx0a3E1VlhlMTNWWUQxcldiUERDM010?=
 =?utf-8?B?VHJhUGVvYVFWYnYvdHVNYjBpQ0FodDQ0Ykw3bE10cnU3OUdoM0VVaHdvQ3ha?=
 =?utf-8?B?OVpUVGJnTGRBSnRua0hhbHN3dEhTWVZWZng3MzJvMndCSjJ5MVd1aFJQNFJQ?=
 =?utf-8?B?cVU3ZzdISk82NzFodkdsNVlodEdtbUVybnVqWDdFMnRNc3JVTzVsVUFKK3dU?=
 =?utf-8?B?NzJOcFdsdDR3clcwaHhVSllIR001VkZOWC83d2pEOGVLY29keDY0ZGJWVGc5?=
 =?utf-8?B?N0JhQnRlQTBPSUxZRjg0cDlDVUozR0k4UkV4SWFKK09BUkJYS29WUmFDSENk?=
 =?utf-8?B?dUFjNm40RCtOcXd5L2s3MHR0Vzh2T2JERGoxVDRzZ2JGMnovSUZEdVJDYVhL?=
 =?utf-8?B?Y0NyZnRYN05sOEp5UnZaU0g2Zk1aRVgwbTBrY1BUd2FRb2hjeU03K0k5NHR2?=
 =?utf-8?B?SEtxTE52elRFa0lrckd2UCtBWmVWYmsvRW55K1ZUdjd4N21WeEdhZms3Z05F?=
 =?utf-8?B?c0N3NFlPemM1UU9xaCtrNDRrWjBqd3dDRnRYTENrNk52aHgrY3U3UFdIcjVB?=
 =?utf-8?B?aHJ5RmJTa1A5cU9yWU1vWkYvNTljRHNKcXdYRnZZTUt5ZFN0YnZ4UnNid3Vs?=
 =?utf-8?B?SU5GWjBtTUUxZ2ZKRnVXTVh3VUdxZnArcVk3NENpc3YrUlpkYmNlZkJPYkRH?=
 =?utf-8?B?YXBBTjBld1ZvOGtKYkJnemdHUHFvYVVIRnlOejdqSTl3WUhtZ3hGQ212LzVG?=
 =?utf-8?B?Zm45ZldxV3lsd0FBMmMyVXc5VlliemszVW5LVFBNVno1VXZObnlQcDh5ZXc1?=
 =?utf-8?B?V3lBWkxyMWJrYndiaVNFdFV3N0VVSTlNUVRYSlVOU2tRZUt4dHRqY0FGTnJm?=
 =?utf-8?B?T0QvNS8vNm9jRmtCQ1dXclBiQitaRlBvK2c4ekx1ZFhtdXE1eWJaQTNkczVq?=
 =?utf-8?B?U2pIRzgvZVBSbHIyT2YzdGl4RkNWOE1pQUpnV25zVnkwOXM4SWJuK2RLZEVv?=
 =?utf-8?B?Zmtmb3V6dExRTmNCSFV1bG1Dby9ETENqdUx6SEsxRG9sYWdVeUt1ekQ0VjNx?=
 =?utf-8?B?QlBzYnFPN051WU5NclNWU29yVDVoVjJ2ckZCdjc4VGhpUEM2VzI0ZTFXUTc3?=
 =?utf-8?B?clRrMlF4R3VDRS96VXlONThXZzBsNHVGWTBtVEI1blRsWUhVblhIekhnYmY0?=
 =?utf-8?B?UDA0ZTlvajJKRzFNUzQ0R2xNQk9aWGdESzNrWFdxbmZCQkl6aEhNSVVrN3A0?=
 =?utf-8?B?MFNZcFVLamxnRDBDMHlrWWRJNmRCVmdDNHpMeXl4ZFpJUUc5TitWZ0EvMlhV?=
 =?utf-8?B?L3hKOGZMQ0IweWpDVVNGenhOV2djanRkRzRneTF5aGxaSEZ4Q0QxZ0I1K0Fs?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4D3686CE943AB43B4352798E41A9913@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	=?utf-8?B?QUdLZ2ovaHc1M1RJNUR1NmZEb1JnUlY1ZHF4bzN5Q21ZRlZEQnEvVDJ2WXJ3?=
 =?utf-8?B?L0FOTHZQU2daVUhHa0JTMGhzZytwNFNNbGhxdU9QdHR1aG96dDV0V2p4SGsy?=
 =?utf-8?B?YlFCSzJwWjU2ck1CRDBOZGhrb3BjaWlDMWxlTjYvSmpvalprdTlYdUxCNU94?=
 =?utf-8?B?akFqajNIL0FuK0RDSUYzT2l5MW9kZzYwa0NKWHdEWGNHMEtTSTdCMEhHYkcv?=
 =?utf-8?B?QWQ0cmlBSkkvSnQ5N2VyQXhDUmx1clAzbTR4NEVZeWtiNDh6Mk1panR6TWtC?=
 =?utf-8?B?dTYvdW13VVBlTlhrTmh0VnpxdHpxdWtzbU1VandFd2RQMmczdDlPNnBibTZH?=
 =?utf-8?B?N3F1YzJiU3QzRXN2am1FV2cwTWpuTTByVEJkQmFaSXF3ZGpiSUN4VUdhajlw?=
 =?utf-8?B?anJvbFByWkdHYzBlYWR2Q0UrS1ZadzNOREYyS3R5MUJxeEQ1V1k1U3hDeUp2?=
 =?utf-8?B?RGNzeCtyL3RQUTU5TlQzeS8reXhDcEQrTUwvWllDbVNyclhWVnNVSHg0aGZZ?=
 =?utf-8?B?V0twR2twRmpKQzZoMFRsY0NuYzY1ZkFhTXVVN0VDQXYyOHNGUFZUWDJwS0ZE?=
 =?utf-8?B?ZDJYY0hkb0JOT25ZNm53eHBYRXBuVVF1K3JWRjVUTXlqcGFKUURWYlNZR2dv?=
 =?utf-8?B?L0FYR2ZYK2lxTkJUd21xVkJMSmpoRVFQOVdXZXYwd2pkNEQwMG9QY0Y2cnpn?=
 =?utf-8?B?SmRHTDlBSDc2NUJFY3hwTkVITlh1Y3NKTXFkWnhnODcxRE5lTEhITlNka0sv?=
 =?utf-8?B?VzVOOHhiYm1JQW4zZm9SVHpXMW9qcHkvRzl6TERlaS92VHpYY0JUd3JUTzNq?=
 =?utf-8?B?T3BUSkZFalpranMxSmhicUFGeXpxSEVZOWpKSUJwTHFDUEljNElCVHNzTXZp?=
 =?utf-8?B?empGVVhnU3A5MWc1a2YzZW5PdVhXYlNsVUYxMit0Z2lPSGdoRUNTdkRGMjdF?=
 =?utf-8?B?MENjV2dudCtsY1lWVkpFdHVtdFNEdzJFb2tQTlZvMTBoT2hmN0pQc2l0YzZ6?=
 =?utf-8?B?S1FibUZCZDdCcEFHZVZlMXUzMWx1SUVXYk9BUDRITFZMYkk0eHdrN3R5Wldm?=
 =?utf-8?B?QnVtZTRDb095UUJDOW5aN0xpWWRYU3Q5YVlla1JYRFlaTFozVDhHSXJoV0t3?=
 =?utf-8?B?Mm5qSmxId014YnRwdnpFY3VTQ0xEcUY5alVxaEtCbytRc2pZc1J3QnB1Y0Ix?=
 =?utf-8?B?VjZTRkFmamEzUGlWZ0VvdU9ZT3RuV3ZjK3pJWENEblhpY2VlNktzZk1FdmVN?=
 =?utf-8?B?UUVJZXFPcFZianVrWTFXQ2FGSEE2eVJ3dmN3RTZCQ0l1OWU5dz09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ccaeec-f79d-4a42-10f0-08dbcb2c0140
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 14:03:26.2979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpx/v8/5rfs47NL8HjXTC1Iin1+kJfx6j03vPQl5FRMiAMod9qm7VwpP/K0yOh1Xzbch37uq4Q3yGtOGF+AWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDI6MTk6MDJQTSArMDUzMCwgS2FuY2hhbiBKb3NoaSB3
cm90ZToNCj4gT24gMTAvMTEvMjAyMyAxMDoyMiBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0K
PiA+Pj4gQEAgLTI5MjYsNyArMjkyNiw4IEBAIHN0YXRpYyB2b2lkIGJpb19zZXRfaW9wcmlvKHN0
cnVjdCBiaW8gKmJpbykNCj4gPj4+IMKgwqAgew0KPiA+Pj4gwqDCoMKgwqDCoMKgIC8qIE5vYm9k
eSBzZXQgaW9wcmlvIHNvIGZhcj8gSW5pdGlhbGl6ZSBpdCBiYXNlZCBvbiB0YXNrJ3MgDQo+ID4+
PiBuaWNlIHZhbHVlICovDQo+ID4+PiDCoMKgwqDCoMKgwqAgaWYgKElPUFJJT19QUklPX0NMQVNT
KGJpby0+YmlfaW9wcmlvKSA9PSBJT1BSSU9fQ0xBU1NfTk9ORSkNCj4gPj4+IC3CoMKgwqDCoMKg
wqDCoCBiaW8tPmJpX2lvcHJpbyA9IGdldF9jdXJyZW50X2lvcHJpbygpOw0KPiA+Pj4gK8KgwqDC
oMKgwqDCoMKgIGlvcHJpb19zZXRfY2xhc3NfYW5kX2xldmVsKCZiaW8tPmJpX2lvcHJpbywNCj4g
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfY3Vy
cmVudF9pb3ByaW8oKSk7DQo+ID4+PiDCoMKgwqDCoMKgwqAgYmxrY2dfc2V0X2lvcHJpbyhiaW8p
Ow0KPiA+Pj4gwqDCoCB9DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb3ByaW8u
aCBiL2luY2x1ZGUvbGludXgvaW9wcmlvLmgNCj4gPj4+IGluZGV4IDc1NzhkNGY2YTk2OS4uZjJl
NzY4YWI0YjM1IDEwMDY0NA0KPiA+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb3ByaW8uaA0KPiA+
Pj4gKysrIGIvaW5jbHVkZS9saW51eC9pb3ByaW8uaA0KPiA+Pj4gQEAgLTcxLDQgKzcxLDE0IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGlvcHJpb19jaGVja19jYXAoaW50IGlvcHJpbykNCj4gPj4+IMKg
wqAgfQ0KPiA+Pj4gwqDCoCAjZW5kaWYgLyogQ09ORklHX0JMT0NLICovDQo+ID4+PiArI2RlZmlu
ZSBJT1BSSU9fQ0xBU1NfTEVWRUxfTUFTSyAoKElPUFJJT19DTEFTU19NQVNLIDw8IA0KPiA+Pj4g
SU9QUklPX0NMQVNTX1NISUZUKSB8IFwNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoSU9QUklPX0xFVkVMX01BU0sgPDwgMCkpDQo+ID4+PiArDQo+ID4+PiArc3RhdGlj
IGlubGluZSB2b2lkIGlvcHJpb19zZXRfY2xhc3NfYW5kX2xldmVsKHUxNiAqcHJpbywgdTE2IA0K
PiA+Pj4gY2xhc3NfbGV2ZWwpDQo+ID4+PiArew0KPiA+Pj4gK8KgwqDCoCBXQVJOX09OX09OQ0Uo
Y2xhc3NfbGV2ZWwgJiB+SU9QUklPX0NMQVNTX0xFVkVMX01BU0spOw0KPiA+Pj4gK8KgwqDCoCAq
cHJpbyAmPSB+SU9QUklPX0NMQVNTX0xFVkVMX01BU0s7DQo+ID4+PiArwqDCoMKgICpwcmlvIHw9
IGNsYXNzX2xldmVsOw0KPiA+Pg0KPiA+PiBSZXR1cm4gb2YgZ2V0X2N1cnJlbnRfaW9wcmlvKCkg
d2lsbCB0b3VjaCBhbGwgMTYgYml0cyBoZXJlLiBTbw0KPiA+PiB1c2VyLWRlZmluZWQgdmFsdWUg
Y2FuIGFsdGVyIHdoYXRldmVyIHdhcyBzZXQgaW4gYmlvIGJ5IEYyRlMgKHBhdGNoIDQgaW4NCj4g
Pj4gdGhpcyBzZXJpZXMpLiBJcyB0aGF0IG5vdCBhbiBpc3N1ZT8NCj4gPiANCj4gPiBUaGUgYWJv
dmUgaXMgaW5jb21wcmVoZW5zaWJsZSB0byBtZS4gQW55d2F5LCBJIHdpbGwgdHJ5IHRvIGFuc3dl
ci4NCj4gPiANCj4gPiBJdCBpcyBub3QgY2xlYXIgdG8gbWUgd2h5IGl0IGlzIGNsYWltZWQgdGhh
dCAiZ2V0X2N1cnJlbnRfaW9wcmlvKCkgd2lsbA0KPiA+IHRvdWNoIGFsbCAxNiBiaXRzIGhlcmUi
PyBUaGUgcmV0dXJuIHZhbHVlIG9mIGdldF9jdXJyZW50X2lvcHJpbygpIGlzDQo+ID4gcGFzc2Vk
IHRvIGlvcHJpb19zZXRfY2xhc3NfYW5kX2xldmVsKCkgYW5kIHRoYXQgZnVuY3Rpb24gY2xlYXJz
IHRoZSBoaW50DQo+ID4gYml0cyBmcm9tIHRoZSBnZXRfY3VycmVudF9pb3ByaW8oKSByZXR1cm4g
dmFsdWUuDQo+IA0KPiBGdW5jdGlvbiBkb2VzIE9SIGJpby0+YmlfaW9wcmlvIHdpdGggd2hhdGV2
ZXIgaXMgdGhlIHJldHVybiBvZiANCj4gZ2V0X2N1cnJlbnRfaW9wcmlvKCkuIFNvIGlmIGxpZmV0
aW1lIGJpdHMgd2VyZSBzZXQgaW4gDQo+IGdldF9jdXJyZW50X2lvcHJpbygpLCB5b3Ugd2lsbCBl
bmQgdXAgc2V0dGluZyB0aGF0IGluIGJpby0+YmlfaW9wcmlvIHRvby4NCj4gDQo+IA0KPiA+IGlv
cHJpb19zZXRfY2xhc3NfYW5kX2xldmVsKCkgcHJlc2VydmVzIHRoZSBoaW50IGJpdHMgc2V0IGJ5
IEYyRlMuDQo+ID4gDQo+ID4+IEFuZCB3aGF0IGlzIHRoZSB1c2VyIGludGVyZmFjZSB5b3UgaGF2
ZSBpbiBtaW5kLiBJcyBpdCBpb3ByaW8gYmFzZWQsIG9yDQo+ID4+IHdyaXRlLWhpbnQgYmFzZWQg
b3IgbWl4IG9mIGJvdGg/DQo+ID4gDQo+ID4gU2luY2UgdGhlIGRhdGEgbGlmZXRpbWUgaXMgZW5j
b2RlZCBpbiB0aGUgaGludCBiaXRzLCB0aGUgaGludCBiaXRzIG5lZWQNCj4gPiB0byBiZSBzZXQg
YnkgdXNlciBzcGFjZSB0byBzZXQgYSBkYXRhIGxpZmV0aW1lLg0KPiANCj4gSSBhc2tlZCBiZWNh
dXNlIG1vcmUgdGhhbiBvbmUgd2F5IHNlZW1zIHRvIGVtZXJnZSBoZXJlLiBQYXJ0cyBvZiB0aGlz
IA0KPiBzZXJpZXMgKFBhdGNoIDQpIGFyZSB0YWtpbmcgaW5vZGUtPmlfd3JpdGVfaGludCAoYW5k
IG5vdCBpb3ByaW8gdmFsdWUpIA0KPiBhbmQgcHV0dGluZyB0aGF0IGludG8gYmlvLg0KPiBJIHdv
bmRlciB3aGF0IHRvIGV4cGVjdCBpZiBhcHBsaWNhdGlvbiBnZXQgdG8gc2VuZCBvbmUgbGlmZXRp
bWUgd2l0aCANCj4gZmNudGwgKHdyaXRlLWhpbnRzKSBhbmQgZGlmZmVyZW50IG9uZSB3aXRoIGlv
cHJpby4gSXMgdGhhdCBub3QgcmFjeT8NCg0KSGVsbG8gS2FuY2hhbiwNCg0KVGhlIGZjbnRsIEZf
U0VUX1JXX0hJTlQgc3RpbGwgZXhpc3RzLCB3aGljaCBzZXRzIGlub2RlLT5pX3dyaXRlX2hpbnQu
DQpUaGlzIGlzIGN1cnJlbnRseSBvbmx5IHVzZWQgYnkgZjJmcy4NCg0KVGhlIHVzYWdlIG9mIGlu
b2RlLT5pX3dyaXRlX2hpbnQgd2FzIHJlbW92ZWQgZnJvbSBhbGwgZmlsZXN5c3RlbXMNCihleGNl
cHQgZjJmcykgaW46DQpjNzVlNzA3ZmUxYWEgKCJibG9jazogcmVtb3ZlIHRoZSBwZXItYmlvL3Jl
cXVlc3Qgd3JpdGUgaGludCIpLg0KVGhpcyBjb21taXQgYWxzbyByZW1vdmVkIGJpX3dyaXRlX2hp
bnQgZnJvbSBzdHJ1Y3QgYmlvLg0KDQpUaGUgZmNudGwgRl9TRVRfRklMRV9SV19ISU5ULCB3aGlj
aCB1c2VkIHRvIHNldCBmLT5mX3dyaXRlX2hpbnQgd2FzIHJlbW92ZWQNCmluOg0KN2IxMmU0OTY2
OWM5ICgiZnM6IHJlbW92ZSBmcy5mX3dyaXRlX2hpbnQiKQ0KVGhpcyBjb21taXQgYWxzbyByZW1v
dmVkIGZfd3JpdGVfaGludCBmcm9tIHN0cnVjdCBmaWxlLg0KDQpNeSB0aGlua2luZyB3aGVuIHN1
Z2dlc3RpbmcgdG8gcmV1c2UgaW9wcmlvIGhpbnRzLCB3YXMgdGhhdCB3ZSBkb24ndCBuZWVkDQp0
byByZWFkZCB3cml0ZV9oaW50IHN0cnVjdCBtZW1iZXJzIHRvIHN0cnVjdCBiaW8gYW5kIHN0cnVj
dCByZXF1ZXN0Lg0KDQpTQ1NJIGNhbiBqdXN0IHJldXNlIHRoZSBoaW50cyBiaXRzIGluIGlvcHJp
by4NCg0KDQoNCk5vdGUgdGhhdCBteSBmaWxlc3lzdGVtIGtub3dsZWRnZSBpcyBub3QgdGhlIGJl
c3QuLi4NCg0KQnV0IGZvciBmMmZzLCBJIGd1ZXNzIGl0IGp1c3QgbmVlZHMgdG8gc2V0IHRoZSBi
aW8tPmlvcHJpbyBoaW50IGJpdHMNCmNvcnJlY3RseS4NCg0KSSBndWVzcyB0aGUgY29uZnVzaW9u
IGlzIGlmIGFuIGFwcGxpY2F0aW9uIGRvZXMgYm90aDoNCmlvcHJpb19zZXQoKSBhbmQgZmNudGwo
Li4sIEZfU0VUX1JXX0hJTlQsIC4uKSwgd2hhdCBzaG91bGQgdGhlIGZpbGVzeXN0ZW0NCnVzZT8N
Cg0KT3IuLiBpZiB5b3UgdXNlIGUuZy4gaW9fdXJpbmcgdG8gd3JpdGUgdG8gYSBmaWxlIHN0b3Jl
ZCBvbiBmMmZzLi4uDQppb191cmluZyBoYXMgc3FlLT5pb3ByaW8sIHdoaWNoIGNhbiBjb250YWlu
IGEgd3JpdGUgaGludCwgZG9lcyB0aGlzIGdldA0KcHJvcGFnYXRlZCB0byB0aGUgZmlsZXN5c3Rl
bT8NCkFuZCBpZiBzbywgd2hhdCBpZiB5b3UgYWxzbyBkaWQgZmNudGwoLi4sIEZfU0VUX1JXX0hJ
TlQsIC4uKSB0byBzZXQNCmlfd3JpdGVfaGludD8gV2hpY2ggc2hvdWxkIHRoZSBmaWxlc3lzdGVt
IHVzZSB0byBzZXQgYmlvLT5pb3ByaW8/DQoNCg0KS2luZCByZWdhcmRzLA0KTmlrbGFz

