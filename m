Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492A75B0E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGTOMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGTOMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:12:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E892115;
        Thu, 20 Jul 2023 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689862336; x=1721398336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SF5FLP2UUMJhX/exn6YYzFoR6Z4ItTOhtkqM4tyYODilQFCN/RLN6gp9
   rLaSBD36wsS1CzBR6sF/d/5QEGZj1Dow1RXtpaPs/azb9tOEQbdZTr9aU
   naAUamRvMK+NWfKaBMoY0HnongnEKu2xGiLSzlKxThzaFo4YKKJ+gczZq
   NWOVRtHIPxNGeifrzqfG4CmOtSZczG21Lbf8n2ujliOhmV2v9OwxgO9fQ
   /WV6E24hUgRq0fw1xNDzl5RiGAKSjGc5k5VB3b6TFOKdfoOqBaVqTR2Rq
   U41kCK8BqUHs9/vvAzhxzt6lvbYnOlqZBZ0RWhvJPlFib8W6Zxr7cg2XF
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,219,1684771200"; 
   d="scan'208";a="243256127"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2023 22:12:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmrgjpU5lAo+G4ngB6+U/LYBrB8z8EgyHq6dt8ux5D+lBhI4LTkE8fn7lKhKbWO3sgSrfbIDXIMq2YrYt5c4+WqWyHV6+7uYQQyzICyS7Xh4NwyF+a0fuVlA+FALk3azgT97CoON8oBaCKTxPR5CWwbZjLa8agDiYl810bE2WlYnLl/bAnPJApFvE450ttCQxkOHxReOXgiS8ntTdLa7AfIsARKixY6m2EUsm7jS25AuAbVVWMyIcT73nz0O2Zw0zClnRM33ITGzevpnnc3o3WePID6pGqf4p/JjUfOxJZBjta//9mYOjXp3EHSBoHnOEQoZJryprAG+b6X8nOK6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=kIMc3VRO2W1mR2fudFembNUSMteIj0WdVbENlLSdfd/PBDB4Y8Zw2btuj3jzDhemMGDTsMceQ8FImXiuhinOz78tH5+F+xXWkHzfcYeGtleaHxuernH5j6LS7yL00fwxKObxbUBLc7tkOmUcKrOLDlYoJg48slg13SUv/an2rq8OwEjgJ05ZNzE5RH74uzyMTkuRfUBI67DplXn2aFqNwIErwKt38dypB+5MdXAo1iw4kOxNnzB2zyvSy5oyvzaxmQ78w7wpDhG950PMibNxmJ9e607+fEQ0UHSpQNoLxmZ+yuPLSYR6QcZKSyFX1iVCzW/266cZSNuNt/7wEjOYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EoeW2tF+I68wfr1xbxBUqKM89bYkjPv84aH3x9fUwIg+cWihbradYpjl2GZ6MEUNTZvqTw7IdfyB8id2DyH6A+T1iQ4bgra6skglBROvxgARfv2app5xTeA0p9PDM7RBujsOtG6uE/XP+mn+WU7tb+WMI7l8vLv4H4UNREk3I1E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7896.namprd04.prod.outlook.com (2603:10b6:8:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 14:12:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 14:12:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: remove emergency_thaw_bdev
Thread-Topic: [PATCH 1/6] fs: remove emergency_thaw_bdev
Thread-Index: AQHZuxM2IlHF8h/inE6Ck/nb++j/EK/Csi8A
Date:   Thu, 20 Jul 2023 14:12:09 +0000
Message-ID: <b83fcf28-d24e-44cb-c48c-cec40b4cb4a7@wdc.com>
References: <20230720140452.63817-1-hch@lst.de>
 <20230720140452.63817-2-hch@lst.de>
In-Reply-To: <20230720140452.63817-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7896:EE_
x-ms-office365-filtering-correlation-id: 05322199-3f27-40e6-146b-08db892b4e48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDjXpqRB00QMkHSs0gWTlMFzKAR7CQKaQtG831f1eSMQbGzRm4VWcvpkXqpyJVA2Gu8zl1D2/k/103H2pWxI2yPKs/cVljIo3ByW9ULICJlZuYKeMdRnI2Pvd2Ha2XrSb1ox25+AyCwscQ+cRn5I/mYByQV3sz65dWGD6scnnvR+kFRe4/mzOUMcDf0QzwC6+lSFNvHAE/g11WGd9sVMwHO3UJ/CRfS0oVd2+a5QOjwsNq4pns8bXKfI8rwCQlUw+uH94AZREdBFWVBRYT4cjX4BUONziTOrKgNHj8JSjuExWc5nCXZ0jx8tR6TfNym/0CpLjCinUrR4qvr/BJx228V3Gxp/nBw6Hf1h1VOOoMph1uFDLj9HGml206VJohfZKLOutKvqjYg8XbTj9BuKmEDJc9i+uJVq5fgb3hAS4IUz15rdfKkIMA0Vt8MP/3l9QsSN+1VLlLtHIqE2PpmMuNulg/IhCSsiXwrxaLSp8A7x03iVoqiWYEv4GcK5yNCVUcEYFtQY+3wCARVPrOEwtb+e6ym9mSkvR2dMGqvqXTa6APZHcJ5TZhOEFqZIilljTytVGRkOkyj9xJCUudBFk740GnmshUN8f+4QaPoWzS4+u0xfegd4WtIHoPo5bDPCaFgakk/bDlRWpELuorU/nM3okDZ3TS2h1f93vhlVpWPTWn8aCTLgAb6OzqOeYRKd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(66556008)(66946007)(64756008)(66446008)(66476007)(91956017)(76116006)(41300700001)(6512007)(6486002)(2906002)(8936002)(7416002)(8676002)(4326008)(316002)(5660300002)(31686004)(36756003)(54906003)(38070700005)(31696002)(478600001)(19618925003)(110136005)(38100700002)(26005)(4270600006)(6506007)(2616005)(558084003)(86362001)(186003)(82960400001)(71200400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymh1ck5EdTZnNmxNVjJIbHlKMS9GSzRFbnpRanJ1U0FZNjZvRlVyOEhML0s2?=
 =?utf-8?B?eTZqMkt6TjliSTcwWUJpeXVlV1dWMWxyQ25iRjA1V3U1N2hvem1xWGdkQ01H?=
 =?utf-8?B?dW13c0YvdXdCRUxkT3cvb0pod0t0dUFScWJDWmhhVzNFeHp1bnlxK1h1UDJl?=
 =?utf-8?B?anM2Tm5Qbm9pZDIybmNmZTI0bGxwZWVGZEZOM2pNczNlbHpyd01Id1pEZmph?=
 =?utf-8?B?aXN6N0Vub0xCUng2R1ovSWViR2hiTHdGSEJNSG9wQkJVWmFRL0NDTEtQMitt?=
 =?utf-8?B?eXJqT005VVlTcFoxclgrMUxvTFRUK2s3cVBCa1hIeUtWWG05dUFlWDJoaTBI?=
 =?utf-8?B?MzFiRnBPQ3FoWkJVQlg5RWZEUFlXVXN0TDhuaUJYREtuY3ZNdlpxVVJ0N0FY?=
 =?utf-8?B?VlF4NUJxc3EvdUJYRTVGV1NoZGU5S0dFd2s0MXg0N2g5YU1KUzJIdklZaXZO?=
 =?utf-8?B?eDRVcTlCdEd6Q01PcG1GWTlrY0tKSlpVNHFzMnpDaCtmVUNMNGFtOHBUU0k3?=
 =?utf-8?B?V2drb1RpOWtzcmVBLzFveFNnQlhJV0ZXN1hlQTNYU3M4Zm9zUWVsU3BCNFpq?=
 =?utf-8?B?L1F5dmxUVU5lMDV2eC81MURTc2ZpdzBIMXV3K2VaMlJTUWlQUHJZVDYzeHF1?=
 =?utf-8?B?alNYZitHN0xEcWJ0T1NUNUViK0U0eTVINW1TLzd0Vng4M1d0MUZNSklpYWtS?=
 =?utf-8?B?UVNVMG05SlF6MnV0T0tmN1dmYTdwaXBJejJPOXBxZGFRUlNLaEwvZ3ZuZk5O?=
 =?utf-8?B?WDN3dkVYME5jUUJBS255UFVqbStmWDh5ancyYndJUDhBUm0xbGhxMk0rNW9L?=
 =?utf-8?B?QlMvVTFWdGFsRHMxSUh2eXB1bDZkdFN6dWlZSkRFVURabURSbHdKWnpjZFY2?=
 =?utf-8?B?U3BpZld1UXhCYnhXRHk2VVRoLzlGTjBiWmU3M0o4S0JURXF3TnZ6Syt4UUlE?=
 =?utf-8?B?V0MwUWtSVEhLaC9HWnNrQXZWQU9nL1pCSGJLY0FiL1M5c0p4YWRwVGwrRzNN?=
 =?utf-8?B?VTNEd1d2SlFhRWZ4ZzEyNFExK1JVSytMNU5EMkFFM25YR2lsOVFvdFM0NmJ4?=
 =?utf-8?B?aW1VTnlxS3FFQUgxeWtobWs0WjIzaWp4WVZyeG12YU9MSGNmQnV1SyszK042?=
 =?utf-8?B?UEYvczRsTVZJM3lTeWdyS2Y3Z29nMjg0MjRhWWI0L3FzNnF0UHhCMGJwSnhz?=
 =?utf-8?B?TTkxVWNmYjF6eGVLKzUzM1A5Z2lTRUZ5ek1SNStZeEJkMFh0WFVGeXlJOHFE?=
 =?utf-8?B?S2k3K3kwLzYyNGw4Vm05TWU4T2YxVGJoZVoyMU0vNnY1OHUya3IyRkRyM1E4?=
 =?utf-8?B?MEoxdVlCVlpPVitoMk4zd2tiK2pCRGlkTUt2Zyt5cklpTDIvcnpGOWZBRURZ?=
 =?utf-8?B?bFB3RWZ2L1NUeUlrY29rT09LcjJRZ1M5cS83T3RzWklBbDJxV282NlJpWWpk?=
 =?utf-8?B?eXprb1lRT3RVSEltMjdFWGhCbTdOWWE0R3pyUTRVSFh5YVhWUW5RNjlRWUhx?=
 =?utf-8?B?UGRWOFphNlozdDlCQlA5UWZrZDdsUXBMRVdVTzJFNStYYWVrWFZPRzJWdWFP?=
 =?utf-8?B?YmFsbFY5eWtQV1NkVWRKYit5QjNzMHJpWHFvdk5GTXozT0VpZ2FTczNHNlcx?=
 =?utf-8?B?ei9KOEFLbHYyYko5a01jU09YOERtajk5NjdRK1k4Q0hHZGI4TTF1M0lVd0Rs?=
 =?utf-8?B?Z20zZFNKMWVOU0k1S3Q1K2JDdjJEclJJUVhlQUlLWW10NkdKbG9ZWHFhMjJP?=
 =?utf-8?B?ZitzVGpJYjgrbW9LcmYyeEdBTEsxZWpqYnp5alY2WTh4UFNsalFZSjBpc2tn?=
 =?utf-8?B?ejl4dTM2SjlGWkszS1J1NnUxK2U5aTlXcHY4V255QXpLM0NPYkgvVHZEZUNV?=
 =?utf-8?B?RDlYWVdyUndZOFlNazVFbE1PaUk3bU15TFJhOVV4OEdsU2c3N1AzNXRmNTFY?=
 =?utf-8?B?Yk5Ub0J3L1NGdlAwakk4clYxNXlBZXBuVVZOSnc0ZXdCdm9qMnptN1ZjdGdo?=
 =?utf-8?B?WThXREtZSnU3Nm8ybzl1OTlKVE5YS3lMRS94MUNvS2h3ekExRnczeW1VNmRx?=
 =?utf-8?B?TzI2cVl2MWVHQ00zejdVTFBSMVJVMU1KUnl1VWhWWFB2MTFKNzNUa001MjZ0?=
 =?utf-8?B?RVY2QUVqTWVJcFdwOUtCZWYrT2pXRkZNbC90ZTVhQjlkcG42c0VvL21nRmJJ?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D816C8E26A64C64BA9F9DCDF2272BEC6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L1BENVdZa3l1aTJkSTJTc1ZxUzlCdkdQeDdlV3Z4VWgxZC9JVjV6YnZLQlJP?=
 =?utf-8?B?L3NWWEQxN3J3ZTRwV1ozUk8rYUxWdkdQSVdETDZzZVV6ckR6eGVQdXQwOCtj?=
 =?utf-8?B?emI1NTlxdkQ2c2o1YWxlYXVEdGtPWFNwN3FJWXM2RGd0MmVGcWFaT3M0Nitq?=
 =?utf-8?B?OWRsWVNzcStnaHBEVWF4SFVVVjlwODdYZGRNNGhKT3hDRmlkeXN1ZmI1bnk2?=
 =?utf-8?B?Y0xIeXhKOWtUKzNGU0oxd0NSVWpud2VLTnppNEYwdWJ5WW0wTnRmc1FCamdN?=
 =?utf-8?B?SEZLRnBDZTJRd3psTWFGQ2Rsa29jMHQ4NDVwN1k0UU92THN3dG16ZTdJcWFx?=
 =?utf-8?B?TXlQdjFYVUtlRXFjTDZrUVhGcnJtZ1lTS2ZTOGgyQnpKcnh1Wk1wU3VYcXdS?=
 =?utf-8?B?UHV0dkxxT2I2bGxjdmNSQzduTXphd20zREVBUGtVNGMrV1ZnWXBOVC9iWmxY?=
 =?utf-8?B?aXNybE5DaHMxUUpEYWZLQWN3blJNb292a0hYUUhkdytJYnlkb1dYZFh5OHVq?=
 =?utf-8?B?Q3QvOUxORkdmM2ZXVENtUGd2Yjl0dldUb2pZNXNFVk9scENVMEtOYWp0SGJj?=
 =?utf-8?B?MmgwcE93dFdxUlJIUGNMVWdYbzJEaXhhd295UE5JcHc4b0hYQmk3N0lzQWQr?=
 =?utf-8?B?K24xWlIxNTZHZC9yQ3lGZXRJa1JadUZCTFR3Qk9MR3I1WWVydDVueVlFMEth?=
 =?utf-8?B?VlhPVmYxeXNjWWFTWk1ud1dRcXJkQkdhWWFzTituemtpTjFrYmltNlNRU1Zv?=
 =?utf-8?B?SjRZNTBSa0VUd1pEa0pUVGprd21CL3ZJS1Qxc0JOa1NrVGR4VFBpQXVEZFNw?=
 =?utf-8?B?OXNXSFMwam1sMm5FTFZ0Nm5YdllRTDdzenRIaUI2Mm12RWl2U1NPUFBnTVo0?=
 =?utf-8?B?MmdlQUc0cVR2OHpIL3VOQWNnTmV3Q0xxQlk3OVZBblFaRktydXc5RWZOWmdZ?=
 =?utf-8?B?UFlrMUZQRDlaL1E5QXhyM1R0OEMwUStxTlcyOUxRYitGMGxJKzFnNnV1aVBj?=
 =?utf-8?B?ai9UNWJXcUFoRjFwbGFNMU5JMUl1OVZmdHRKL05CakY2Q1BaaTVpSjZkNVFk?=
 =?utf-8?B?OWJMeHE1Tjh4T1pEYWcrOHB0VEkwd2tiN2pKZzZpVFc2MWY3RFl2YjhLUEF5?=
 =?utf-8?B?UXVIMGxtb0JVUkNTc3BkeGJGVkR4d2pZc0p0N1JwK0syVjRUOUJVb1VKdVQv?=
 =?utf-8?B?WHFianZRMlE4L1ZuMGtUKzh3Qys5Q0pQODRwMyt4SFBEZWxta3p6VjlCOHdw?=
 =?utf-8?B?VFBzN3kyTkJ2U0dnUW11VWYrRFp6S0dUamlkcDgxZFlISFI2Yk93c0k4WjlB?=
 =?utf-8?Q?sA4dEcyU7YrrGCFkQq7sD1hJpRcjLKBtHm?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05322199-3f27-40e6-146b-08db892b4e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:12:09.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ci2bKC5XLorSZks7HxbcYDJvorTVWDfs6MQ5pbPGtbFTqzEAN1GSBuBE7AJp3gGmBuiP97seBL3oXKmmjqGLA1j1I85zOqheiqVfpAlohoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7896
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
