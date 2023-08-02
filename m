Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836B76CA77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjHBKG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjHBKGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:06:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E0196;
        Wed,  2 Aug 2023 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690970814; x=1722506814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qiczXCxrkRYyy4wnZiyZeuBqLbf0Ohk97izrLfgN/htI6NfICFW+BS1L
   UT1a6H3kBCplhhSeCz8YbmqfnbXuiHkicuq5iZjSj5KD0dUICoM8I2VU/
   Mtv+ObivKHiVIXLzEIN5WeVERcHMlqLM8SUqP8o2NAoaeE9al7a15FFLa
   7yMXc5Ssz6g0wFh+uUxBKvt986664KgVruudH4vZWCzvNE8922hVxNPii
   2VRg5Xrk5XPRgcv1UZwch1fINDdB/XKSEeTIAromtb5jDb/44Kahqx/X1
   GHFMAv6k/T/xc2u5WNmaSqgZEHknCu24b32VgZEvJ6JGxOs1+pWLDHMsk
   g==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684771200"; 
   d="scan'208";a="351895538"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2023 18:06:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEtZCOOnyDYIpGQXCpjL409010UlEr5s2QqHr9rdd1i0e3J8MAtKRVkiSy5apibbeZUGn33EPiNlEKrqPDiodajjhna3MWVjlDXPv5vt5j/pBRumcilN2N6+YGO1eb5l8x6rEyTIIxRqg5szkNUAin8RADEOTFjjTDvqta754RJjgqR8zUm++pC3FOwWomKeLgXftB/Y+Sp4A7dNxjrVGdoUL8KgWEuPmCZdFPzlfgMLyQawyBLFRdu2iIMoUoZ20UPss6tsTVimgVMaxUnkZV0vVu+RLEU7nvJBjyUO5Bg+kKft7/C7qRLuOj2RNPh2b0+jD1BwkupTdElGUcIQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=TrxP/kkdmPxvRZOLcT+/mtnYhEIbjGiTks63WD2/d9OGdIsElamxvhS1wQhLbTfn1xrrBu9UPNCmMipAImiBibhZ6ZjUUf+TtNIZF5bxeYRmmNikAYbNFqk2+ACrPhk3C4UBVSod7Yd2IdIRaN6ymAvz7G3EI5abhwLpUTUTN05hQlcZc6zk5FFxBrwaDgDN3pW/fT8Ijsj7cOOyt5DE/D2Gld4jrjbS1sjVBtEer6giRCsQCLHVfQVu+urQ9PjUooqzb07jjF9c7E8vH+8PhS0o179Kh5Gg+fUzWNrgAOC1TVMH0H1/UQ0YDqnQbLZ1om4jrihlrdvIEfE5TcTTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=H12dWklqnHGASDIuKDx6YOdhTnLC46tA8+ehrRFhcieofGFo7m/gQDsX1c78ZoUi31gTZ3wGC1Cjenqyv0QW7jLf5xQLzHIoI/KiYG/HhaTBIc4bHYN1LAk7izErGBDAW+XjpSrTKTjxx0CnIK5KMbpT2rVexZhaixphn9KoEZ8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8646.namprd04.prod.outlook.com (2603:10b6:806:2fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 10:06:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 10:06:51 +0000
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
Subject: Re: [PATCH 3/6] block: open code __generic_file_write_iter for blkdev
 writes
Thread-Topic: [PATCH 3/6] block: open code __generic_file_write_iter for
 blkdev writes
Thread-Index: AQHZxJzT/PsxFfD3nkyLbY3Do+7MGq/WyOEA
Date:   Wed, 2 Aug 2023 10:06:51 +0000
Message-ID: <46c04039-64e4-8079-ab12-4d74fc8b5d53@wdc.com>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-4-hch@lst.de>
In-Reply-To: <20230801172201.1923299-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8646:EE_
x-ms-office365-filtering-correlation-id: f1b0024e-2777-4c9a-dcc8-08db93403107
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMgyvgbdaYfPvwhik6GJzMK1HFhBjIzC1AkJH2+WEjGwjavy5TDEpmC/9SQCEh0VsIBagpdDvS3Uo4kHYyfMtW0GkXLnw764LCmEzxKJG5xlOcbCayMgS0Ck5Owet4DaeSQx/CHQQ8Dtba6ZsrxOpPCGASeFoAXbynwB/TyGLAjIIoZ4w7HY6I9gdEEVO/doaGSX4gdeWL51jalSK0spTWlWXkM3gHGVgtBpHkmQb5VI7oxqnQsNAes/eZDNJGBOdWjfbceKmnJH98+o5DQvomqvrkTFgiTRGWdPQf/EXyBFUwv4L2okn/xjG2bP7ZtnC5aCNX7vy1JBhX/HQ1qHGrFupS+e1J5iYtNrs6I2ekeitLv+EKQPCdl+/OG+omFrS5Yx3tTehGRgc+K6gzLzQ8sOzuMzFiFGirMDM7f7rA45fkKcDR7XwJvzaFWeDwBtEtY1h47QMh9+lNqRn+F5oVH4oRLFkq3cZKkrjRErLRMCwACXmXj5sBfqp+IIOBb9LBQTdDy13Qu7/cfYNANAPtXW9sNA+3FFSdZX/hAfWzPTomtjE6vI+bnASnPCovHpCJhqMDojio41sbxRIkCbWh5pFh+5s20671JvGAK9exz29izGhV3g4bhdlZdGcbiwXcKWro0I1EPUBBjiAcsBNjB8bLyTHdVJ87HtUUriTMwGbdW4OIeUPRjqNEieQ+cJRcNy8kyQbQeMrvhLDdi2lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(41300700001)(2906002)(31686004)(7416002)(38070700005)(19618925003)(186003)(2616005)(4270600006)(558084003)(122000001)(478600001)(110136005)(54906003)(38100700002)(316002)(86362001)(6506007)(6486002)(64756008)(71200400001)(66946007)(76116006)(91956017)(66556008)(66446008)(66476007)(82960400001)(31696002)(4326008)(6512007)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxOSnh2aVpyVjRtaTRyRVoxd3F0NXlYR29YNXpHeCtDYmxiaVFzVU5aL0h6?=
 =?utf-8?B?YUhsV2FsSVVHeUxmK1c2UHJtWkxZYnUyYmVacWdoSEIwZXptcnhTSDhXeGZz?=
 =?utf-8?B?UGxnMldCU2JDeFdPZS9HQm03aEhGcHFkWTFTWVVRcXgreGpoMXNUNlZjY3h2?=
 =?utf-8?B?ODJFN05oQnd0Y3YrUlZkUVBjTkMrMm5Kc1BWUFhlTEdUdTJ3TXd2Y1AwelYy?=
 =?utf-8?B?Snc0NXhDY1VGRHhJYnEzRnUrKytUREQ0M3V2bDVjTTgyZjdWZE04TzJ0TW11?=
 =?utf-8?B?QVNtVEJJMHRiSkt0b3ZtZ21PUUxveDA3MzdHcjFPTmloS1FxQ3JCc3pyVGZv?=
 =?utf-8?B?T0FVRzlXaVhJSmY2VzJYWmxWZEVtU05FdlE5K2xWTUNaVEdXMjhDdDF1elU4?=
 =?utf-8?B?SHN6NW1sT0YrMWhsNnllY09LQnVhdFRXR2xRc3Y2VjE1K25sb0FpbmplZjVV?=
 =?utf-8?B?WFdLWDI2ZHFOQXErZS9yaW5xSU55ZHZQTEFwYnJUYWVRc2dSWktmdVhtQmRQ?=
 =?utf-8?B?NkszeVNETWs4dmRxbTlyWEJTcTR2ZGZsQlR4WHhMa3NHTGRhWnlBcm1rc05h?=
 =?utf-8?B?UlRGbE9sYlFwMXg3RzVQVk4wNFlMeVJVRGVBOGFRalJ1aDllT092eTUzSlhx?=
 =?utf-8?B?Q0l4ZEg1Vm9tMHVDZjFvSVJDamxCaUlBTXlJdXM3R3ZKQ2tjWXJScUpuUDh3?=
 =?utf-8?B?WTdLN29yVDNvaWdHbXNUL0J2S01oNjErYldrcFI0TWQ1aURkRWVyZzFOMHJ5?=
 =?utf-8?B?Nkc2WWYzbzNHbmhaWGVQd1lYdWV3UVZiOVZOczZVQlM0VHMwVENGS2Rjb1hU?=
 =?utf-8?B?VW8yejF6RHZvZVREOW1FUTdNRUZ0Zm9WcjNPYmdSTGdhSWJMSnVpQUFqN1dX?=
 =?utf-8?B?N3Uxa1drRkZEVGtmU3pmbmlvektyYnZ5ZHcyR2lmTWE1WWdxUU5SdHhqTGls?=
 =?utf-8?B?UitJQS81THMxL3IxOHJUZUlkazRldTlFMFJKdXFiQW9xTEFzSGxFMkdJZUpk?=
 =?utf-8?B?SjdueWxVZFBGUmk3V3grdERWMzFTTGM2Z1UvUGlRQ3pyTmFxcEVXVS9oRzdH?=
 =?utf-8?B?WGkySlk1SG5mYWxVZVdUaHlwL090TmM1YTAwb3JHTWFnVjBPeGhyc05MaThT?=
 =?utf-8?B?WUVLTGNaaWxuUmxBdjE5RXpSYitRMWVRUTBLNkFLNUw4cGRBZ3BSTDRJZWNZ?=
 =?utf-8?B?MGVDMGhKVWh2WTJadkRMbUltTy9DckYvTGVXd2hEZklxMzBLRlBHeGNWaWpx?=
 =?utf-8?B?bWNUMDF1eGp2Z3JOTGRWLzZaY3NXNVcvT3dNcGExMzd3TDMxWU1DSUh4S0Fj?=
 =?utf-8?B?K3BlUVQ2eDBabm1qMDNkLzllTk5vM0FpWE5DVXhjVm80M21hMlp2NVRSMnZG?=
 =?utf-8?B?RC81ME1xQU5UK2tkV3ZzL2lUb0cxcUdQenZxNWh1R1JURmkwdzh2d1JrNFhm?=
 =?utf-8?B?TjBGbk4yckRUQUV3b0hjdlVyTllhQ3V6cGd1M0hTaml2SXljdE1wdWYydjJy?=
 =?utf-8?B?WHNnb0tCU2E5T3hOeWxEM2dvdUdPVXMvU1ZyZmU0RXN1WTFUWEhjTkw2NTYz?=
 =?utf-8?B?V0pwYU5qRTkxK3VkeW5FUnBsTEJ0ZmRrdkdVb0FtN3ZFTWN1bkpNV0RrQjhU?=
 =?utf-8?B?Z3QybnRZYXFRbmtKdTBDYkgyU0cxR2ZmV3BiSUF6aUNLS0MzbUh0d29ZcXhx?=
 =?utf-8?B?YUYwOGZpUDAyR2UwckljRjdiSmUxSDlSbDlEN216aDRoMTVoVFA2VGhkVm5M?=
 =?utf-8?B?UkxFTlMwcHhuNGMyL0F6ak1SVnBUL0JKVlFBODM3MW9FUkc1M2pzNys0Yllt?=
 =?utf-8?B?M09Zc3lWdERxcVlXSmxrVlprTHFpZTNrQTczZU5SWm1Eei92WG56cUt3QWJD?=
 =?utf-8?B?MWw1eEI1dGpVdGNUWHdyVnhTV1BsOE0zbEdzaEo1eU5qa3pkMXFCSEcraWJm?=
 =?utf-8?B?OWtpMytyNERXSnY1YUhQTEw0T3NpaTcvdDV3L0MyNGlVN0RUL09SanJKcW9I?=
 =?utf-8?B?c0lUVmF1TmlxbnQ2WkZpTGJsUTJIQzZ5MktoYW1Ib1V5WTI1bFZiMzc4cUZE?=
 =?utf-8?B?Nkc4RDFxVGpBUEtMSnduVjNxbmlFSTJ2SnI0UnZOYXVCM3YyeTRIbUp5dnlK?=
 =?utf-8?B?LzNWOHJMMEVmeXBmMHlobVN0RnBnRms1dGRlVXlCN0d1Ump0RVZCWXBNT2w4?=
 =?utf-8?B?cWN0RjFCaUZNREd3Z3g0ay9PZzBuQTRBZUdwbnBjc2l0dllqdjBURkZhOUdw?=
 =?utf-8?B?Qk9WY1RHZUtGbEVESzlVcWlVMmp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7FCD8D436DA847ABFD2964B9BF9518@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QW5Kc1JQamJ0UjBTVTFmTGpXeHVieWh3VTlOdUNwOGs4ZGtqTFI1cmF4aU0w?=
 =?utf-8?B?OElEWVB6b0F4dnlLbmtVaHlXNTl0NUlWRWJZWDRBWmtldXFrRXFGR2gwcnBW?=
 =?utf-8?B?QVJYdytWaldTeGltd2xreUxqS3ZFTmZVS0ovMzBiZ3cyeW5SSHR6NEhQZzBm?=
 =?utf-8?B?UDRoT2R2aDhRRmdENC9TTFdVdUdOZ3k3ZEZqUVYyMUNNcmVzbGtiRWpxQlcw?=
 =?utf-8?B?bVB4SWR0LzNKMHhzWWZkekFPY0dvbjFwdGZUNEMwSzkwUk9NRmlhRHlzcTFO?=
 =?utf-8?B?Q2V1RTdXMHBibnN1bGZ0VGdGOEJKK0hMUnhpMUVPWDR4UnhkT2pUUWo3RXNG?=
 =?utf-8?B?MXUrNmdWWkh3K2U1M2lzVDFMVjFvdTRLYWZqVWVaNDN6YlpUWkliMHRoWmJq?=
 =?utf-8?B?RHFGR1NURzJOeU5UV0xLYWwrejhpbFhsRHl4cDZiZmhXYU94VFlSclducnhs?=
 =?utf-8?B?K3Q1OWR4WENaTHBMSGRQY3IyY1BIVXZzOXVlUEJTU2pOR1kvbUNMTm5yWmtK?=
 =?utf-8?B?aXlHWUtlalZHVHptYmpuRlFrbW1TM1oyN1RyS21Eb05kTXdGdXFTZFZwRjA3?=
 =?utf-8?B?ZWxOL1VWc0lqb3J5TllraFptLzFrb0lRUDQveklHaC96UlFjc2tycTJ6alFT?=
 =?utf-8?B?b1hYRU5XV1VhRll0ZnBueTd0emtoV0lhWmZXT0R1b2RkMlVvUHhmSmtXZkFo?=
 =?utf-8?B?dzB1OUlnOXIvRHFCRGphcUd5YmJhVjROWU0xMlZaYVVmc0FIc0ozMEdiQ3Mw?=
 =?utf-8?B?SkZjZUVOcG1tdXNFTElYWk80SnZvS0xoZWIwb29HZC9qR0VNQ1hwTlJzLzJZ?=
 =?utf-8?B?R3V4N045L01xRjVOSWFWTXVaTmdEUE1uaTUvVjIza3FWVGl2TnlzcGtxKzUw?=
 =?utf-8?B?SkwvWVZ3WFpKMVptQVk1R2tUZHRvdUhINFNwUllqc2pNR3ZHVitYQ1ZnSVhO?=
 =?utf-8?B?SzRDeXVmN0tOaUNNRmg1dC90VTA0eFJmSXBNTDhqQ0tHQW1kWmtkRHROZDAz?=
 =?utf-8?B?b0M4Z25oaWJDblZiUFdWZW1NRGJvQW5rM3haN0xtbThCZFZEelFESm1Ea0lo?=
 =?utf-8?B?UWZ1RXRBSTJwb3QyOXJEODg0NFo4WWd3YmEzVkc1Y0IrTHlpUGxMTk5JUnBy?=
 =?utf-8?B?aXJFd2lqVVN2UFEvaG1ONkxQdHE0OFgyOCt2VnJjNW9aQ1dmSEV5b0JlYi9D?=
 =?utf-8?B?M3VYN2xWUE9QZVFIK21LMXNOWXRReEJzOEkzZTFsdUFzeHE4T2szLysvS1lq?=
 =?utf-8?B?UjBCWnhRY1pSa2Z4NWNEbW9LdTNYMDFQLzUvTlhRditnM2xwSXRkcjVYY2xI?=
 =?utf-8?Q?BbNCMidRpx8kePMMOL23HYC8VTvD+wG4n3?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b0024e-2777-4c9a-dcc8-08db93403107
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 10:06:51.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwQ5szv3p8dEZvDB7k7hm9/W1gZ41I09posr28cCkebH/3mwaOw5d053g54Yi1d0ffDdMdQrRyBqu89+rxVMgS0zhYcqzduvlpWvBvTzK7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8646
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
