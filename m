Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A466BD2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 12:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjAPLta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 06:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjAPLtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:49:17 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8E1CAD2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673869752; x=1705405752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=kYfCFQNaSCe0Hn1CSu9M/Z6IBSMnrz917bW85mrU9gGRUO03nsONQQ/q
   TFTgnqNgTcupuFKS8qXeSqxYP2Ljrb/AB0JZN904Yhoh6JfGnJVConSRp
   CQDQ09EdhzaQMjAOGf7C2K2pqeBsUDsuKqR41oBgQtiJWh9WQ9/CNBS/G
   QD+FhM4G2MvOWDIXrCFA/axcycI9CWDQ8QP13Hqo6X2Lp4n419aw5eJ1W
   EQn1wJTcQRzqkmc1hVKtnUl1lsX0rbLs0kA9KmXLVV/QHX16Rf6qz57RB
   kUd1E2ZGTuuXG43By3FCbObGPuRi8f9nolygO0cWrnnRM7Xs/3Xvu5k+s
   A==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="221004289"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 19:49:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVicXG03kDFvnDTFV3Q33WQSqEFwfUmyqZhujRmxPT+AR3VssJZuqNY3SrR7ozBvToIjxz7dcuS64WU8Sh1uyXANXDUV21fXvBC/Wsk0uXXZB80lsiu1HmatFxPpTIXYTd30VJFYr5NIpFMFHqjYnlXdkYeoBDF9sxt9kqcPfJasKC1yiRAwEnF7/JQ+mUxVmetjBnR4Tx+sN2Rl2kwLs7hKMfDG4dGvWV+veV2gl9L6wcy9rulfuMi9HXwRFfilr6IOQeHS2Eq50qRvu/E86xvMPE2xNvFIHpE08C9j/AzDAah3PFp2tU5ukyNa40MhOPNmuUKsMNIz3BsMd4R6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WjXxp2grq62CkkTen+x8ilI/djeQF+KXpj77JjA4w5Is4fra7IH/vbiLKnNBiKYHshFpRoG5Tx4C3PDUvkRGN0+or943A7J6A/jHLXYnz48tYlhFXMrmVvixea/Ob19N+V1YXzQG985KayhwPJg+Zeqn9GCed3gNI3t0KvLrTnT73dI6fVpK1Wc4ZtBp3PsFQw9Q6DbCdg9Xz7leF0wgDCRZ2nU0xhpKBdlPgQnboNUWS8c1VVEsLbrvOiR3BkwHRjXKLgdg2tn34wV9NoaMaZjuFnJgtbS2E93Ytymz5sf+Lt8kO/IG5l5z7VWSIE1HcNBiIFDWS3UfqQj16Id1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=G6AQVlFoG4eO094OuB1aeYrNNv+q+ZyBtJmV0NVKSN6W4MJboC+vV7F1miAnBmuzbvxQBQ6m5egfUdusXpvuuqs12zm0WW9L16hEsOp49EWNaxgndFcqiSVVJ7Zer4P2PMgTUulbmlQcNz6o9fJO+XQ5SVKTOmJ30RS2LYikpQ8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8131.namprd04.prod.outlook.com (2603:10b6:610:fc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 11:49:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 11:49:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 7/7] zonefs: Cache zone group directory inodes
Thread-Topic: [PATCH 7/7] zonefs: Cache zone group directory inodes
Thread-Index: AQHZJPSrJxI4Otq2UUCnJ0qJel6c7K6g9yYA
Date:   Mon, 16 Jan 2023 11:49:05 +0000
Message-ID: <e4383f17-e288-b47c-e44e-ac9219a7611d@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-8-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-8-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8131:EE_
x-ms-office365-filtering-correlation-id: 818d907d-d12d-46d9-ff4c-08daf7b7ab7d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oDB/DCIgKG4t5TOS1Eu6azySPmnWFM8dQedliDSa/t/+A8ihs8Af/z5joOcVFRqb6wVZKMetRev/sLYt8O3Yo9ER+TYOrpn/Z1mizD+Hwgiv7rjdaiCDjyLYZ2AjkL05iMdmaU8CPipzJV9k8WckMBHR8YN5sTyGNtkkwPM3gTXHxitJUl4HgFzy5DUitP/QmvXw4ifrTX2Jq3VVafZMEQKafu1JtZ0T8HDc4umn+e+8IEj4r526t1Yb4oP8j5bAJ94nnwoMwfthCPmE7r5Yw0pgvuDNmiHHMlNd+zJB0hcbVmrSGjHutdKEWMICpgA+YKHcHJIqMvioYgfVzA88p3j2tXkwQfhvToEfB+shoRqCjRhGtbMkKfeL7rSicCaz1nc99lX9O2UcAKom/201Ob5jVlGsLMBRj2ffGGp+4Xh2M6rgV+2yPDGdj8dP/Pk4gpF1G7WPdJsL2QlQE72S40FfwdNrFKz3tc276tWhnLxoyazwHj3/WxWE5gc0NpAmRPG8Bej6d1WHcc4yD9aE9dvIZwEp12jqywfh5ZtyIDghFSqxVrOlCyPTCoESkz/yVDFItdobbihUGiXPHHbmcYfGbXxXp2hp+k9EO9ZW/CddmKANlxp/qn9vnfLVekCrX6loq+NrIMeIGNmlRnIpDK4gMKYglE+xuCMtgOxnwOjLKh1rlLUmRxkjrv97fYax4Tom0Tht6ewm1KM/cxusb9UdQFEVe4LhfyMTEWv5OqCPxrp4b4gh/pdV2dtnCLHASCLLr+cOLCyslH5ZETjx8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(82960400001)(38100700002)(122000001)(558084003)(86362001)(38070700005)(8936002)(31696002)(2906002)(19618925003)(5660300002)(8676002)(4326008)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(41300700001)(91956017)(6512007)(4270600006)(6506007)(26005)(186003)(2616005)(110136005)(478600001)(71200400001)(316002)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJQaXptSkJQNGVUYTFuN0hISXg4MjdtaklOZUpUSm1xWTVoTmt2RUs4SmFU?=
 =?utf-8?B?MGJKalNTQ1VncWFnYkFWaXRGc3c4ZVFRRlp1Q2c0cEhCbkRJaFBhS1laRHFD?=
 =?utf-8?B?eHFFUkVPSUxzaDNLclJXZDNvSnJ0eW1ySndkdmcrcG1QdzNPM1VuNlY0RHF5?=
 =?utf-8?B?WTFKTDBLcGRMVThmU1NxQmNFeWs0ZCtmamlKMVl3c3Q0c1QyMEQ4ZjhhOUM3?=
 =?utf-8?B?QXlwSjZTL1Jody9qU3VYS1Z3N2pSVCt3OWdqY0VGaFNmMXBodnBsdkZnUUF3?=
 =?utf-8?B?Tkw2Y0lLa3p6dGg4bjc5Y3MwRUhvVUw4L0VkN2IrK2RFZk50c09ZNmFZaFhR?=
 =?utf-8?B?MVNERHFqTzNBSTQxVGY2YzA2TjN2bDFRSEUvY1FJMzN2eXROc09mL0Y4ajdl?=
 =?utf-8?B?eFRsT3ZjLzErRlVkYzR6dGUzbW5oUFNkUkYwc3NyZ05HdC8xYk1pSjc1ZzJp?=
 =?utf-8?B?Z1o1T2FZOWRMRXZUQWpPT1NZWUZzUGMray93VWQ1c3ZUWXFkOXBRdGZ1OVAy?=
 =?utf-8?B?eFpqSWIzcEIwdU9haUkvQ2hEbFgxMTQvajZTK3FoNzNzU0k1NW5FRnRpV2ts?=
 =?utf-8?B?S01EdUt0RnpBOE9XNHArc09uUGN4UURDZHBWbWtpR3ZBVUlzUUdRMUZmODFP?=
 =?utf-8?B?alVhazBzajhJTm1aczhWREJIM1RPaWJsQm1qUnMyaVpGVjBOYUpUYTRYVTRI?=
 =?utf-8?B?OW1ieDFnNXEwV3l1UWR0MGIvT3huSUR2WnV1YjdRVXV5T0lCNDNrNFVSa1Bz?=
 =?utf-8?B?Qit3bFJUQitqeldoYXBSSTVzZUYzMk5mQVNoRnJvaUk1dy9BYXlCUkdpSE5q?=
 =?utf-8?B?RXVqbFpOOGk4VWpRbVpKSkw1REI3Q0tNbTQyQ0FkYnFYK29yWDUydlo0UkFo?=
 =?utf-8?B?d0hQWkVJYXI3K3RTNHRvc1NqZWRBTWVRVWlHN1FOWm81QTBDMGlaU0M0L0tQ?=
 =?utf-8?B?MFJLbVJ5bTY3T2lPWUJUbDFCR0lMRHljWG5KaDFuMEtqN1NmRGsrOTlwU2Ux?=
 =?utf-8?B?b214RU5ScUR5b3V6SlFsckdISGVqM05FUkkveEdkdHRkcS83SEd1d1JYdlJV?=
 =?utf-8?B?czdFdXRqN21CbW40ZGxwYkhRMFBFczNFOUgwelpnSWpwWitVN3ZyT2Rxd0hJ?=
 =?utf-8?B?V1ZlT3oyNzhOcUVlczBXN0hXRWg1STRwVHRzd0hpTHE2dzJJZStxUGJBRktX?=
 =?utf-8?B?azMvYzFSalA5WmNRNlhpbk1YbXk3Zm1QUDJ6ZEJSZlpqRHJsZnZGczZic1hK?=
 =?utf-8?B?VHAwMUxxWUFXZzN5R3ZHak4rZXJPQXBWNU8yRXMxSlNzeENRdmZJOThMR04v?=
 =?utf-8?B?VFNmaWx2RHlxUkw3UmhkbEprUUxyc2FQdnNqenFUT3ZiWm10TEY2bFROeEVN?=
 =?utf-8?B?SStKNy8wNnNtZ3BLaklYWnVyaG9CeHRXUXZMSmI5UEZMbnFVUjBzUC9YeldP?=
 =?utf-8?B?eTZoZjJDdVQ3MWFFdUo0bXo5cndiOUZBRTNxRHhpT0MyU3FUVmdWR0pVeXBO?=
 =?utf-8?B?cG1IdUprakNBd3plVGlGN2htT2NNUFlTOUlEVXV2TDU4bWhreDR4dTR5OUsw?=
 =?utf-8?B?TEgrNHRRbGpCSkdEYUJ0aXJRejM2ZG9yV0lMUVBTY1R2TUJRS0VtU1ljWGRL?=
 =?utf-8?B?NFFWQlhxNkRiSnh5b2lmQW9aeWZtV0xwNzhBWUFzL3M3Mkg4d1dYbm5MdVh1?=
 =?utf-8?B?QzBORFRIenZyZElGUFJwcDlRRFJ6QXFPdjR0MWVUcXMrR2ZKVS9mdmp4UGY4?=
 =?utf-8?B?QWw0WFIra3NsZ2NmUTJqUGJqSmhwNGs2azFQWGdiZUhWZzlDNTYyUERPRi9h?=
 =?utf-8?B?eGo1L2FsVHRtTnJpMUM5Zmp1MW9MbVBjNE9SYW5pM2ZEZy9BTzVOZ2pxak12?=
 =?utf-8?B?N1RjWklkRVFEa09HZkppUGY2YTNJT0NmUjAreG9YVDB5VHFWd3BjYi9rRC9l?=
 =?utf-8?B?K01JU21RWkZMcFZSRFVOKzkvWmFwbnhWTWNweE5nYWhVemxVNG10VUlhMVhL?=
 =?utf-8?B?MzFCRkJwMHZPWFpqTUtLcUovaUE2WUNNeC9ValFDSHF1Q1R0SnJaaU51RzVt?=
 =?utf-8?B?TDgzTnRucS9jY1prVmF5YmthaTlrQ0JvdUVsZitKeGhkUmhRU2xvZllIS3hV?=
 =?utf-8?B?dVFvbk8xZk9RVlc0VzhlcXdjSTRhM2hoZXJTc3NtdmlQVWhuelQrYkV4YXpz?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F43B29D654207744A682D05DDA3AFA34@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YupwfvsYLRysYt34NB2yNYJ4u/ezsU+qyfGQZAHkY6Jxc6FSez7Jyij7427HeYh9tAMlTMVhOv1fD44qr4Nqy+4DyVMyadjOm019qrlYAVOrb9LWFx9GgHHAqfSkkz26EpPkt+deAAjfMGSphB9Uu88Lj3SZf4w4MzWj77KQ5UXw+8KATOvb/ptwKZLvaBpqpUnecJ8IE6qkMMSKvdKDY264pnYbWdHLoKOwCk59x3YgHO5fv3ofZSC/br0RasEHrXY7J7U68jnm8ZVsrw0GPwOd7Y9mK0exESEEnFpdm44h13mFLutbZjqeyAFVUv5DmRWwTJv9aIjD3jS2oXYZHotyEMNCChTovvC0GhGGi1Rcj/9ZHkLmuFmwUa7Np8rC1OWyjfgJ/hrIMHzs1b4+YgNOihomK3tMmLyAE4ROXO6W89qFngXJCC1CVXsUM3DLOqxd3m0dieQ2Sy7S2Dq+YrqgfXm6WQCrEzFevz/TKCGFjhqYjJKZNY328zjzzqEzO9hirclUw0ny9vNPnlJuktLkP68ND3epK2rL+NjDQb94Rpm8XsPLCLs5fAVMTFHbmFiaGXgQBVeS1QYD3mL7m9XExrZJjyzjET/9afPR4X8yw4gTPaf777mGwurPt/1DqtIOLIZLu+m6AS8kbiuL/tFQ5DYXV5aZ9IUBRj+inRsm2W+ShqmCn0qXfFYlhP3rDHnYjyi6m0Losid7L7OBg37t2dS7nVCT1llONiRF2kgDp07qxulJBkyM1yhI5L2KwwZsJ0XgvnyfxGCiozWtBH1Rrr/H+IpgbUIB3Prwg6E=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818d907d-d12d-46d9-ff4c-08daf7b7ab7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 11:49:05.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrZszJVtHLtzRzmfcygwmktPXDEdWEVxgkR2jvV9AaLtgss22YBcExCeN3Xl5iFUX5+FcMJY80QJ8PMjXMoRxJjpMRFlRcJmdPAZa/izzqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8131
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
