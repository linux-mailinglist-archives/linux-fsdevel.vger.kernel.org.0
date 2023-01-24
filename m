Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572A679639
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjAXLJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 06:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjAXLJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:09:50 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B22138;
        Tue, 24 Jan 2023 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674558589; x=1706094589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=UEsbM0hezTboLKUhFnAWLT+xoVl5T724kYe9k8yXMfpUnJMGhDnHYT2d
   cpOf/8OYTv8fJzROnrSjfSk+XLta+lj4LCG1hE21t/9aekrF2V+yopAWf
   96K8DcC9GcHaUrmnFeaNaldd59NaYRjTL60q0nx397UMTbrVqRMVr7D44
   Hf2qq0Kuk1fbMmkCfuweTiR/r1S+jbz+LhvSOm4dL/D0VWmTDdqX1dDXb
   OYPX35OcBNI85ymqR7UCNfVqfq6hHs/GwzG1AkCx3Ya/doo49augNgpmO
   XzwMtcLmDXBICS7g1paOUaYHbQVgx+MkHMNkry6tUyYSoVPgXCX1az6PI
   g==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669046400"; 
   d="scan'208";a="221693085"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 19:09:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br+B9y/N0VuGwwalcfgT0wcRc6beH/aXyIbsuKsmv855k3xD5GEk/l2XbSO0SIY4uj8DFg9soSeglTmiPNDu53wp1saz9d5r1c2ylR1ibOGCXVzWU45X5nTTvBovsIoimpnqsjm6mrhvhqkL8mzaG0R3XaF8zmoKvsaJ3f57XlRKPT7Ss4kgPo1rMN28V8AZ6/TkOqO0Fq65oNWZxtIv5S91l8T4h3vQL905zwsEhV8EmjKuLNfvkASAtp2VGg6uz77+SkjcUE+z9g5JKy0CJu5fWXUr7hA1/2pvQfVjkvDKYCsVZjI8qmQiM47FhixcQ9DmKxRDJ0+E+XO7DpfsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Cf9t54AyQ1CN5KJTmP7zXSlSCGKTuuXWzdX9d6+9B6BVvsB+6itxH57k4SDpQ9Y5V8YAIYqci+GNnfe7b4jnbhudizmSkIypNL+FDS4T0rH+rcMB2bvXgjgZMxKbh5FmcFLUZuwjbbPrSnx7b7YX7Pfy2U0ajEoSGZJfT1hiawh2kIg8auNsZzeRKSf5e6/Z5099fRzmaJWzZnw5TfqbmWp8ckRPPHGkTm4O+3F/nudQv4i/dzNmHQvb39FNBr6/DXJNcBBjUZwkaoKVvyJDiTyZ5GwHUWw+V1lLCWfoWELk9EFnsL4hMD1h53e5aCXggDhLNF+YYtE3JEUaCw7O2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=StrpCD+nXDXTdvpSFYVLjN13GdPBdcIpXyUnmdaNigX+guEq/PJ8QyyubEQye7jGON1Jz6aAVUrqdOTYiKPLWiQihHf03KyPtQV8hEEb/3/9frM64EFwOY+Su1krd6L/gQoVNmUin6iaBNTGwOWcBb8U/OntfQAspOoOMb1s6sI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5681.namprd04.prod.outlook.com (2603:10b6:408:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:09:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:09:41 +0000
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
Subject: Re: [PATCH 16/34] btrfs: rename the iter field in struct btrfs_bio
Thread-Topic: [PATCH 16/34] btrfs: rename the iter field in struct btrfs_bio
Thread-Index: AQHZLWTFCKdwwtdp6kaIUZQjma39066tbeqA
Date:   Tue, 24 Jan 2023 11:09:40 +0000
Message-ID: <d7e54738-3495-c48e-bbf6-e2dc0e6b4ced@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-17-hch@lst.de>
In-Reply-To: <20230121065031.1139353-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5681:EE_
x-ms-office365-filtering-correlation-id: cb116cc3-2b2f-4127-8dd9-08dafdfb7d7b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKUW6vy8ro3OIkvT1pJM64uE0uCufGBosIW8KGtX9EHDkcknsKcNs4HsaR2tHMznPFhmuOhUYgwbfoSdfMzLw3Kq+YDSyklggyvE0Xth8FqjFhtJEWljxpT/ts3sPuNLO1vFpY0Q5u29bx6khxRYi6vxwWiWfM4N15jB6vLPzlwmm3mahJZ4VBMJPScoaScfsDi6Ng3o0YVujf9IPRiZO1ZkDElLI4/Kh9zzMjnn6H+XZIlW8oTiNxmdq2V2Sv4wGRu6iEBy9msnRdPP/rjtcQdiYXUvOl9FTeAi92Up2kcvLCQftCNrC64vs502yoaEzPbIeP1Pr+gGRDMw+atN46ZTlgDg8zSgTgtljo/WMIIO4/CgHTXHeg/dv5R5jINxuSDv8K/KooDhkM6IH6YojxNqqubLM/8JVUZKEfISHZFn4bkjjFAAbqmbi70KtkDbsnrSJCnksj5Tu1CF1Vx0u9BJXhJYk4aPR7ozZbHDhr9KFbzGUW3sp0g5kaZv7QijJM2KiadMtWMMnD6YfmLYBxczW4bhyGbKtuBFnlj1ivHKtgVP6dX8myBWo/G7uBuJVjjSQlrmM41BYgOE+5PPdeuSa3RNm1K1Tf9zDWwxTjCckCOzTwfUmEviP+yBE0E+CNFChWRgH8o5DB/g0cGZY6NSP2W+BzcE251XHfpeOoy4JvLzKrOrVIySY9Reio/MownKwCx339zCpX3Xo1yqIgcaCxD9F4txJn5n30Nv3Iab9K5kPtPQB2EgBJhC21D/AZk0XbXOAWoUpBOeSfW1WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(4270600006)(478600001)(6512007)(31686004)(6486002)(2616005)(71200400001)(66476007)(4326008)(8676002)(91956017)(66446008)(26005)(186003)(64756008)(6506007)(316002)(76116006)(66946007)(66556008)(8936002)(41300700001)(2906002)(5660300002)(7416002)(19618925003)(38100700002)(558084003)(82960400001)(122000001)(31696002)(54906003)(110136005)(38070700005)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnVQVFg2bTBYeklzcjJxcXZ3WXBVTHN2QmFmb0VmSUhGQTBOM3diUVJ4MFZR?=
 =?utf-8?B?RDZuaHQ0MlVyNzN6VDIwUVlIZ3ZvV2ZOaUJmQjNIaFRlL0U2ZnF3RTB6eTV6?=
 =?utf-8?B?Y05EVlhGWlhEOWI3bmwzNUJFVzF6cjdoTFlBNGdXSTNUa0FSR2ZzN2V3elFC?=
 =?utf-8?B?WENUQzIreEpBb1JkK3RZL212bnRMWmJpa2UxdFlacWtSQVY4Tnk3cHRMbTRo?=
 =?utf-8?B?M29hQ0tLVnZwdnlCeTBNakVBMVI4ZmNXQVQ3RVdmWXA5aVRjR3duTU5XeDNj?=
 =?utf-8?B?WHVIVTZQOFF1ZDk5OXkrSUlhRGRwLzJXTXd5NVkyMGxRTHJhYzZxcDFPdmhU?=
 =?utf-8?B?ZGRPd3A4dnpRTG1rTHdmc21NYzBqZVFjYmFoNW83cStIb0laRUQ4VjBQSXlj?=
 =?utf-8?B?SnZ0SlZJam9ycis3ZGFBdDB5WDFjYkt1bzNaUytaSE1KYUxtZDlVdXZZVXdZ?=
 =?utf-8?B?WWFtSXdXcFowYXF5L01uWXRnQ2wrVkRaQVI0SWZ0Tk16Z0grelh5WkNaTzhk?=
 =?utf-8?B?aXZWclhteG4yNDZ0Y1lyaE40QWpkaWQvZkF4WkpObnNLODY0YS9WL29SZXZz?=
 =?utf-8?B?OGJiNmhuaVVwNU13N2k5dkJ4eW50KzVxNVFRTks3dHpieTNHeXZ6M2I0YmVB?=
 =?utf-8?B?WWRzbm16WmRZQjgwRERqbW1oSjFrUWEzakhadDJ4Yk02aGlZY2YxOXVNczJx?=
 =?utf-8?B?L21wWWord01hdVBuRk4yaVBEcm1QeENBVVVZSFhyaTRORWQxU3cyd1hMTU5X?=
 =?utf-8?B?Umd3MVEyYnVhTmd4QUNlK3h2V3ozVmFkQll5c0FUd2d2WXhlWTNOTUVETzVq?=
 =?utf-8?B?YWNxN3FsR0FiMUJ3bzVjRTBSMzRWY0N5aDJpYndoMlpCSnhyYUdBOTZQa05U?=
 =?utf-8?B?eElIRkpGOTExTVIxc280Qko0azVXUVAxbENibzcrdzNEbnp6YmhkZjU5bGpz?=
 =?utf-8?B?WENZdnZBOVVadTRUY0V1MXF3Z01yV1l0SmhtNkFibDlCdFN1WUZOOGZQNzVM?=
 =?utf-8?B?Q1RJT2pKWWJYS2xEeXVnMHJ1TVZoU1FqRnRHdWVWTU9uOFMyL3FsOTkzRVp1?=
 =?utf-8?B?blFqVHhHZWIwcEdnajF6djhQbFZyRlA4VkwxY1lydDFRRGpRaUw5TktEeWQy?=
 =?utf-8?B?dm10OUw4T0huRkFQYUxZVk5Lckh1a0dQLzBzaUxDTlB3MnJhQmpEUkRCK2FK?=
 =?utf-8?B?ZDBXYWV2WG5NbC9zcXRXcmhGTSsxWkMyZnIwQzRpbWsvWjdNUnpTK0NPV0RK?=
 =?utf-8?B?YUI0Rk5RZ0phUzVvUGJwZXIvUSt1Qy9mck9YVnRVakdwTzZ6aEtwUXRLTE55?=
 =?utf-8?B?eFZlYTMyY2tnaTVqT01nYXgwdXZzYWZFeVhqYmttNUE3bmh5TGwvZncvVXZy?=
 =?utf-8?B?OEttekNveHVPV1ZGT2orR21OdVEzaGd5dEJUZGJMcFdFcUFTY2VQRXJ1blEr?=
 =?utf-8?B?MkdwNmRLbEI0NHFMdmkwVkpVcUhZbG1LWVRBQURzRDBCWHRHSjdYMFlMSzBn?=
 =?utf-8?B?UHVlVE55YjN3M01YTHAveTRwKzRZdkY4M21TMnJYVitGRDZaOElqajlGZzdn?=
 =?utf-8?B?OVRvaU1lRGNZSEpVclovUEFmb1l6NlY0c1VQemxPZTB6REM1SDZsVm94SUZx?=
 =?utf-8?B?QXYrWjQ3NjNQUG5IOVBLNlhianltQlR2dU9MQ2pZN3R2NHRwb2xBVCtqY2l0?=
 =?utf-8?B?SnQwTkRSK2hXK3M5U2dpWG9VaWcrRzMrNXY0cHFJRzM1TmFvb011Y0kwNk5a?=
 =?utf-8?B?WTBiRTZPZ3FSUGY3MHM5cFp5TElPYTRzTm4wd2lVNUdPQ3JJRW9iMkhKbURK?=
 =?utf-8?B?Y0c4b0laL3RIdkJIZWNtbFZuZ0dPR1FrZDRRYlRZM1FKQjVMTEE5dnJmaExS?=
 =?utf-8?B?Z0ExMmZhRmhEZmdzQ2QwVjdSc1hNU2liNzZrZFpraGpxVUEvSVhsY2pFTGV0?=
 =?utf-8?B?TmlpdmtwejBPMHgyNTFJT3J2SW1SVzEwKzJmdU05U1hGbGx2STdrbmRwNEo5?=
 =?utf-8?B?T1FoUHZYY1pONDNCRkw0UGE1S2VXSndUTTNQaWdKSmx6OVAxdWl6ei9qUWNi?=
 =?utf-8?B?NFFUZjdUQ0hKVzV5YjVYVkNrOXNteSt3T3NDam16Y2lwWDY0NWxoL09OUFJh?=
 =?utf-8?B?OU9XbTRnV0xxcUR2Znh5SmdRUEd5THc1a3pHN0hFcWxnN05ReDNVaUU0TEJl?=
 =?utf-8?Q?Z1kkqAvl6oyDnlbWjQuxmN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98BC52AE6797E04F8D4D21FD993AAD71@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SldVckszaWFpSkpNcWU1dG53WXRzRFNGak1aYnE5dFJJeHl5bmo1SHZ6L1A1?=
 =?utf-8?B?Uy9pZnJCVWpDcjViVEwzV3lYZWtjK2Z0cFdlRTNNNitFOTBRKytDU2VaMDZ3?=
 =?utf-8?B?NUpGQUVXYVhNd3FSSjI2S3B5ZFRpMDY4bytXb2drOU4zbnpKZjV3UWNuT3Qw?=
 =?utf-8?B?R2kzZGI3WkxsdWlvVlN1c1NkWFJyRXBYcWxqTGdvdHJnd2Vvc0wrRUhMbXhh?=
 =?utf-8?B?eldXNlRSYllDL2hwcWZPYnpaeGhCTnNGT3U2cS80RWJNdkNMT01mcGNnZC9J?=
 =?utf-8?B?N25MLzh5TVJBTlNVY2tBVDIyeDkrdHg5VFpCWm1DVXFrU0ZKT3J4MVZKQWdE?=
 =?utf-8?B?VHVkZ1QvdmtRcW9IREtjSHI0MWNGaXh3WGpoVjBBVGFnNTZGNkkzaSs1UWlS?=
 =?utf-8?B?RHp0QUxzRFF2MGxEbjZBVitzUFltQ3FvTDQrWGcwKy9tS2dhYy93TDd4Z21h?=
 =?utf-8?B?a1MzL0t5bFVkKzJ0cXVYVEtEUzRmbURDRlF0Y0hWeXFGOWljQXZyeG5WZm5n?=
 =?utf-8?B?REJvTi94TERENlNZUUptV0xDV2NrZFlOd2JIekVRbUZCSDNhRUpZbmJUR0My?=
 =?utf-8?B?Mnh4UUNjdmRvcWw4WW8wVzVORnJpSFpzU1ZEcDJyczZ6VEdUUUQ5QzFlTVNR?=
 =?utf-8?B?Y2xSb0g4VW80Ykt4UFU2TENmN1F3QWFFYWJtK2ZhbVNqaDZLZTRkeWFmVWY1?=
 =?utf-8?B?N1J1WWRXbmVZSVdCWkRMeGZWck0zZEJTbDh2OWIyZmNvV2EyOUhMcmNEZ01O?=
 =?utf-8?B?RWpmVStFdlVpT01Gd3NUTFBnUHozT1lBcjBqeUgyOWMzWU5vMVpKdlQxVlV6?=
 =?utf-8?B?dXdPWmxpeGErODY3dGNuNERqQTJ6ZGU1K3R5Zkg5N1JJczlDZDBaL3NhS2tY?=
 =?utf-8?B?ZXhQRmhUSEQzWGtTQWFoQXkrVjI4NStDWld0YWJ3a2M5RW85M1R2L1Q1UzZR?=
 =?utf-8?B?TzROWlBkNzd5dHFPdWQxZUt5VHlXQ0UvTUZESE5TVkNPNUFRV3IzanI1clNv?=
 =?utf-8?B?U01EdE9PZlQvd3Q2RWNkQTZISGQwQ1BpTll2VFNZYjVXQXUvZEJ1cHh6Rkg1?=
 =?utf-8?B?U1BHdUdYV1MzNVFOb0hmb0NFQUp6R0xwbDJIay9ZT2JUaDNFQ1RKT2Y5ZTVO?=
 =?utf-8?B?MHZlcDR0YWh6UHprTzRqaVhNWjd5K2VENDJTU2lkcmc2YVJ5a25teGsvTWZT?=
 =?utf-8?B?RTNOTXhQRjVBNHlTSTI3QUdwWUNicFpFcEpJQnNzR3pNRXhxeFROYVV2SGsr?=
 =?utf-8?Q?PCFG8O/7aetDI2h?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb116cc3-2b2f-4127-8dd9-08dafdfb7d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 11:09:40.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YbBUghzLyXL/uj358YvyZhuTPcUZLhS0SPlYTyWPAfYKCquFH0480Ve9gXEiiXCaRZAK5tTS5qM2cZ6D63ayY94rzG2Lb9eD9iZlAbPnvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5681
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
