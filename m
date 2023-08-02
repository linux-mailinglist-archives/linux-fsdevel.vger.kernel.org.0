Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9735776CC07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjHBLvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHBLvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:51:00 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74397213D;
        Wed,  2 Aug 2023 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690977059; x=1722513059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qs42gldTb4YVv0AaGItbj7huiX8kAIkAdxn7/JWjb+apnxQ7Cm17ggRB
   vdaPrIvUXTtZrLSN/rVaUaJFXYxPjoRllXZBGL8JviOI97yFZqAb0ZjLa
   N17jXJXtl0CXyD3caobuIICavOSvvqwlUuB1p5uuM3CktJTicgVRCj4XO
   CoCFGw2zaIFAuZJcBWksDtcaZbDI7eLZLtip0lsgRkub+GANEm8pDU+7s
   zpFm96HB+F6e21mM0TGhLjCyy0ZmtnDOnSYi807PWv06llb1uu/vCYIHG
   iBK5C8jd1nDtOeKcBOlnMPdgbAe/yvsEDtWojxxUHGMhoyKy6SQwLDCys
   g==;
X-IronPort-AV: E=Sophos;i="6.01,249,1684771200"; 
   d="scan'208";a="239755443"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2023 19:50:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVMg5sAoIQ8yh2K8BXse3A8gGoymiLE1JliOv8nmgtmmZgLTKqOsyT/dkOEvJmr/lQ7dH2rH7pBePnlzLfIyEDWo4suyNjXOVLScx0E1MKDCNWjZcfQAJQOsXvMdheljUaeUNU53a4N1x26PNnq3Oyts8iH+2hl7vSwSdR8XvnyfLIQr1vzR8QVMCCn7bS0Sm4G5HmwqqpnEhHzDqYTg3V7s3byGNLg18HB4ZcQi+vBxYhX1Tb8sC3AM60jCUMFzhYPukXfaKdcHBFPZ+kHiysmetN5AaDtnd6g0mPzougf3bHAIs65ONDoV6IgbBZp9khTmlvMLx6ngIm9Hu2B2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=W68RmjEEJ+JfIbjqMdk/UsGdYwkbcv7c40W8IAhMsfBu5c6HJrd8YV44qZIDV7VEV4THEucl7WLPv2Z0b58dccsPTe/iacO/vfl9cYaFGx1USQg/zyFDw48AK/xN73SatlH+2pkUPNQHE/bNKUlIKvQIcCHaM2LLFaJputqI+Gq/kU1IT/ErXbUknriYi9Qv7AUqyUaHK34+GPRdMxIYko8nyyxiTroJA6pGR8fPhWWRtP+sT9Ytp68AbVqcoD+0zeFLBolFxMdjVayTc+14PtP9RbCrc1qPoEBJGsBW+LH3UUs9BvUmdOPMFj8OlEqnEJrt0SchvCIimAGzbkRFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dNDoWK0+bGSnwW69Qf6Gr4nqrrAIyNduOFSzSHDYd6k96ihdAsw0tkTqi8lrhdaRRkUgA+oCkyio8FUFDdlKcSY+kRVguI3udAKGLiV2tRRZodcDNO+ZMQ9CNVJlPe498M1VUHnD2YCvXLABy0rzbvuEr5kiuleYzcOM1RThr68=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6941.namprd04.prod.outlook.com (2603:10b6:208:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:50:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 11:50:53 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/6] block: use iomap for writes to block devices
Thread-Topic: [PATCH 5/6] block: use iomap for writes to block devices
Thread-Index: AQHZxJzhueQodplZkka8WNngGZhSla/W5fSA
Date:   Wed, 2 Aug 2023 11:50:53 +0000
Message-ID: <03a3ac2c-dd6c-a836-dffb-70ac6fe6ac32@wdc.com>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-6-hch@lst.de>
In-Reply-To: <20230801172201.1923299-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6941:EE_
x-ms-office365-filtering-correlation-id: 6810a924-895c-415d-9739-08db934eb9d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7JJeCHm44vYFKCevguJsyCVC4L47U0VDCXb+PwV6QCWMW1ro2xD8Sf0ArEzXzI+PCnFhvK6Defl3yoky8+ietu3FFeYZyGEkom9LLZCxujqNLY/w70Y+HfJPmy9wHy6b74lEEf21L5zSTMrrAy2lPz94S1ACbcWTImebjjtbVUgvqDQ3888KprF1SYshpadGlc1Den/HdGZ6ZEQO9yk3R7KyI4XyhDlieRZb3pu4B2z4SWP3R02iZDDoTymmevzMPhlrGNzbYOpnUAp60RxgqoVKgxpIfPxyatlu2NB+nGLvrDWq3pCNJq756Tme2KhfAJxxKbSzcDewo+r8NvM7cMdJqkgBPFr3GzKA3Y3xTppxLMYPuLs5DUBN8HAgIXVbFR8DRWbKXOOXXoavFZrGIeR8InWFxbK9ZRtVcdXq20HUDAbwlDn3bTgyoK1HF/Mh+f9NGY/7UPGnUSJ6vrtUSsVkiawWX3KuPlkwVNh2bzNEg9qhI9vHa1gACnTqiVFxhrqeOgfBYjr+tZBk5inz4waAOJzuTCq6z/JshoNl65MjlYU513ez0qjCQQ7svGT9VeSRIj+K0oDxlk6WE1ykK9eRfFAoFQey5NOWUOJbPYYBoWFqZSSfJLEbEJX/6FrYsangtqrGVc2hEUJVyQq0barELMpmJqHDPEUPBh9sl+Crz/DtrGHof48/h0w+b4Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(31686004)(38070700005)(558084003)(31696002)(86362001)(36756003)(4270600006)(19618925003)(54906003)(478600001)(110136005)(38100700002)(82960400001)(122000001)(2616005)(6506007)(186003)(41300700001)(8676002)(8936002)(7416002)(6512007)(71200400001)(6486002)(316002)(4326008)(64756008)(66446008)(66476007)(5660300002)(76116006)(66946007)(66556008)(91956017)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0hoSjBUZW4zeG5KS2JYTzdidG44S0lMSnZlSlN2M1AvOEZDY2c3K041VC9I?=
 =?utf-8?B?cjhsajFyQXc0anJtamdvSU5zc2UzWC9wUWdUWFVWNHlMNEcxME90NzdudHdo?=
 =?utf-8?B?bG9vN1k2Y0JNT0hYWDFzQmlubmJGbGkraTNRZUtxQk8ra3pCTjZLNUtiandE?=
 =?utf-8?B?NE5YMVNUMDduYmRuOTNhd3JVVGQxUGp2Z2V4enRWenZuUmMxUE9tQnVDZmkr?=
 =?utf-8?B?OEViUDl1RHZhYXVGcWJkNS9OWlJSbnZQcm8rMkl0NWFKTFZnYk9YUllUYkxa?=
 =?utf-8?B?dzI4amZQbEpBNzdBQThkNmh2S2MwNlBUMm9XQWJuQXVLSVYzMmYwbzF5S1FZ?=
 =?utf-8?B?b203ZExsaWQrT2I3SVZQRUI0eVA3RWltVUY1R1phRnVCNEM0Z1FKY2hCOUNW?=
 =?utf-8?B?cVV5RzdpNHVqTWxEM0pROHJ6RktRRkVxdGU1NUExN0h6d2dPRzYwMmxwNVhD?=
 =?utf-8?B?WTNCQ243aGlJQTh0cmJveFR0djRveTVvcUV5UnNXYzJIZ2pGRCtSTUFYZ1lj?=
 =?utf-8?B?YnBCMDd2a1FUaG9LSDIxamZQQXJEckxNdytxaU8rOHNaREJ3MVUyWUNBcFpG?=
 =?utf-8?B?WURtTDFGa2xnZ3E2YjZxWERmYjZmaTk1Z0hXZHA3bjhKUW5uUUNkbVUyM2NS?=
 =?utf-8?B?K3dlSnFOSW84TUF0bDZpZEk5MFNCTXZHWnVaaTV2dGVYRW9SZG9FV1BoMWJu?=
 =?utf-8?B?ZmlpTjAvRFBhYjZNLzNiSEdtQlB0Q2dKRWtuVFBLUmdkMzFBVWpud0dwbVlQ?=
 =?utf-8?B?NW15cEl6Mzk1MCttbzNNc0FNTFdsTkl2VCtMMHJxOHE0ck02dTB1bi9jWDFQ?=
 =?utf-8?B?aDFBUU1raFE4MkVBbGpqZ0c3Q0ovc0FVbUlLZlNINDc5K1VHVTNLVWRlOHJ4?=
 =?utf-8?B?dFlwemZDMGV3RWZ6cUJBZDk5VTBiNTExZ2U5Q0VUV1pqbUlvY295VEYvMmRP?=
 =?utf-8?B?Ny9SVHMySkd3UEZPRWFmZHR2dTJicTVBYWtBNUZhUDVkbXhqeElETmdCV2V2?=
 =?utf-8?B?U1NZVHY1Z0JzYWhTZkZiQmQwRjBGTXFocElyak83aUZkNWZNRFJlcmdHTlNt?=
 =?utf-8?B?V054SUhwYlA1eFhKUmdhVjRwcmhHZXhBOVFkdUFIMktESVY4bDJrSktQdWhs?=
 =?utf-8?B?amhwcUlFejYwaGkvUW5JOW0xTVJiSDNPSm1rVjhqTkRNaFg3VmIzbXEwL3Jy?=
 =?utf-8?B?MEdKSzdMN1F2UHFyRk9ISmVUak5IclpMeDZmdDNJWTFRSzAvUzE4T0RPR1Uz?=
 =?utf-8?B?VlJrRlZFS2ZrOTF1eWZhQVlQUkl1eFI5a1o0TGR3Q0ZvcW5JUzRWV0tQaEp5?=
 =?utf-8?B?OUliL1ZzT3dXSzFzaFFhKy9yMHpmUEJGeVdQRDlzelF5RXp2WUllZ2V3eTB4?=
 =?utf-8?B?dzFURzhlMDJkMTVXYlpxdjVnQWJGZzRLSng4QVlyTk50SytEaTZGODFLNjJC?=
 =?utf-8?B?bitTVk1ZNzdwbTUvbStNdjJjZUF2Uk1pVnFIcTh6VVI2Y1ZIaFZTWGo2TDhm?=
 =?utf-8?B?K1JMbUZiaDFNSkpSdHRmdkdiSHpJR2xwVFBmaUJwa3A4OU5Vd21kUmZvSnh5?=
 =?utf-8?B?THBNb1dEZGVxMjJtbm9Pa21tdTljbXc0YWJEM3Y1WkNBN3RkZGF5RGxBc0Zy?=
 =?utf-8?B?MkZmVzZUYTBqS0FybGhUTmFEVERSbkQ1aGdYRmxGMU0wOFhyT2FxQVo5M3d5?=
 =?utf-8?B?T3l1ZkFEQWkxb3pxbGRQL0RJa0x5N0M3OHRqRk1wamovOCtQaGQ3ek1sSi9B?=
 =?utf-8?B?aU1aVmFWcGRFK2IrRFcwekQrQ0ZhVW4wY0xwWDBPaVE2Kzc2Ky9CeE41bmlq?=
 =?utf-8?B?K3lQZzhURFdERzZFOFl6bDFFVTJ2THRnYnBLb2M4cUVEMUt4eVVVVTNkMFRp?=
 =?utf-8?B?T0p6SXZiSFp0Z2JLalhlRmNSVG03c3V4Q2xWWHlZdDMyN0pzNXJ2TzlGRWh1?=
 =?utf-8?B?TFZQKzJQL2Z5ZW0yaHhrWkgvMmQxNGJtazVCQk5razRkZmxrQ24rZFF1dU1a?=
 =?utf-8?B?UDdGdkI2VDZPUTVqV3A0dS81Ui9uNnY5WjBwL0hKNmRheHhHcHdCaDFnVXFx?=
 =?utf-8?B?VFQzNGdzOWQxUzBrYjE3MmlyTDRyZTNLajFHUTQ2Ky9HQ3Zxbms1ZDlZbzcr?=
 =?utf-8?B?S1hTakd6SGVncjB0YW5veWdJK2NjSUJ1eUE2TG1XQWVBaXBjN1lFK1RJUlhY?=
 =?utf-8?B?SUVxOVdzekkxb2owOHl5TzJqMlcyWWEyQkdoRXdLUlg4OWZmVFA4M3MrZkRn?=
 =?utf-8?B?b1lJQjR4UXRFMjJKUU9GekZ1MEhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B58905BADCAF8943B8F8BA8FFF23D8BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UTl0MmxSVWhNNUJ6RGR1SUdDWEtjYktocExvdjFiVE9kSUdzQzBCOXpHWUtK?=
 =?utf-8?B?ZlVCa0RwU2FGeDRIbmZmY2RRbWVld0pKaVdQeC9jQkVSS2FoWXgzQXV0NHpo?=
 =?utf-8?B?bjJwd092YlEvbmNuM1Vab3lNeHJBcU1na3JtT1hsNzM0emp5RStsSmdGQnFi?=
 =?utf-8?B?bkcxZG1TejdpL1ZGUWFzUnNvbDRqS1ZrMk9XUFJkZi9CR1YzWGtTQk41RXdj?=
 =?utf-8?B?R0VLSFVqWjVzanVrdSsrZ0dXUEJhQXdoOCtpcFp1TUp4NWRETS84eHRIWGNu?=
 =?utf-8?B?VSt0eEpBWFg5T09pUDNEMUx4RDAxblI2ajdSQkFiVE00NVczckJoQzdvVEFZ?=
 =?utf-8?B?OGxZK0pUa3h3QjRGdFRyb1VVK1ErUHRSd2ZVQzZEaW1oU3FsVXpMMDVPSUVC?=
 =?utf-8?B?ZVpTWjUwZjRXTkhoZHRCL3FsVTREQ2F1ckxlNDJOcVNPZ3hoc0d0YVhnNFNi?=
 =?utf-8?B?OVNpb0x2QUpwN3BBK2hPakE3RVFYS0FjL05kT2xaaEU4aGxhb3k3MTRKQ3Rj?=
 =?utf-8?B?OGsrSXF0Z2pLVlpWOUhRQU10Ryt3Z3c3SWVnZkI2ZHQzSDZzRjA5b083WkpH?=
 =?utf-8?B?dkszQktPdUluTHBXUU92VkNDd05GTDlLOTdJNGU3VFNQY3ZwSFBxK3dzU1ZF?=
 =?utf-8?B?a3paelZiVjZpQTRzZTZEOFVLMUVoRE55NmVaYmc3ejNTNCtmd3RsNGx0TUdI?=
 =?utf-8?B?cUtiL1JEWHhWZ2RsZjF2b09CclcybEluL0thZ1VlUGpDcmFVVkJoMXpKejBn?=
 =?utf-8?B?ZnZjTWdXSjArNFdubTRyaXp2blM5bzFtaHhRaEMxaUlyOXdDYURtcjYzM2hJ?=
 =?utf-8?B?ZEZmQlpxN1hQYnhsUy93WUxmdkNFb1V0aVhZUVMzTll5eHlYMmozNk53UjhD?=
 =?utf-8?B?elY5SVVObVBMdDNtL1JSR1RKc05IdnBQZk14YytCUHNyLzF6ZklrYWtSNGVH?=
 =?utf-8?B?Q1ZXeWE1OWJCeGNHc0s5OE1oMmlBWDJNRjNNSW5LQUh6bm9qcGRqNWNObnl0?=
 =?utf-8?B?SzdVQVBmUUtKOUpodTlpU0NXV2ZaYzhLQzh2WitvN1dLbmhHY2JNOWJ3MDZ6?=
 =?utf-8?B?OHFlc3hKVWxXWnpzaEJXc0hMeDllQ2JxbnMxZ0tNSG1vOUxKaEhNUWNRNlBY?=
 =?utf-8?B?Qk5aVUJ1ZVJKZGpxQ2EyWkZUVVkxZzlLOGN0ODV6L1hVZDM5dlZRbzRlSitK?=
 =?utf-8?B?TWVudytmWXBaOWVDSVNQejlEUDI1UjIxL0xTbGo2N0x4a0hLbWtTZXNQM3Zk?=
 =?utf-8?B?aUpNRlVVakxjcXdmWkNZaVY3dmJHTkxISXhEUXUwL0RhSjdlTTJ6bk95eG1m?=
 =?utf-8?B?TUZDL2NSTUhJVHNUQzBXbTVtV1JUT1hLdEFEQ2pGME1qWVZiTHMxSmhob2RN?=
 =?utf-8?B?VzJrSUIvS1p5SS9sZ1laa1pmMjVDUEtsOENMWlpkQWlocVROT3VFeTRjTk1n?=
 =?utf-8?Q?xRhTwJhq?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6810a924-895c-415d-9739-08db934eb9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 11:50:53.6985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VX++wpHS4u/g0yofM4XCkIq39EVUgKTLCzcHxdrbimF8g0Bu5HR7BYQLY5TJ+2rquUGff1djxLJupNZOf0Y1wqjxmHUI6+mJWEwWZtK5hGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6941
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
