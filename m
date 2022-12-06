Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCD644227
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiLFL35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiLFL3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:29:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE227CCB;
        Tue,  6 Dec 2022 03:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670326174; x=1701862174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=k+ayw1N83Gyc9w4mLKmG70PbDQuzXRwQ7ONJsvGagGFmHeEGFOQ0tAf9
   bgp9e49HPe9Bq0ZTzo/kCyK18J+K1NTwM1VanLyNr+iW6YVzq/uqndaKC
   hu9mksTuwurln8XtfC2K5iaGokhiSlDcqH9CF5Hex4+8gMbmpZxJJmtZU
   FaLLOqsKKW8HA93kOq8mWJ1oLPQGtYQ9miAxMinAlRVM5KJrJ/8IPbdyD
   jA0WJCYj7hxVQdhSkLl5/MXAn7zL7eKwqIY2Xo9YGNAEtBAB5ZXfW4lsb
   /78WhUwR7/TXDHtMJbMoU2YHBArDq8EjeEE6zbmNWiFmQlixqyOXbbyKh
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="216223086"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:29:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/hcISPlVmb0z2nlm+0GFxaq90beJHpn7qMEO8ihr/rEqJR/ivdXWhYmluMG4VRFeDmqHkBAvoOkoAKcOz6DTDd0e6xCoI7XyntRiN2abu2XJFYn0aPgkt7azAbafk2P5FstwSPnpR/YPxCrW20u6NKkKZ9tHh9FjRrDgGB1WJKyvjq26EHwpdlWezXwbAMFs5UXC5d0Cm14zqb9yAXUJNSEMEGUTwjituglqs8QTQyB3eDiFkRG+sashEO6sJHXKRCLZYnT0zQb4auVLlVjT2Sj84DISNfjYThYWc3O0SBQ/6HqjTlkQxRum6Lip8Wm6qC/kYf6PEwjo/V1XxlGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XZm0CC2kTCMxkgAP7Janh5SpMNoMkrlKtWJ7KE3mTX2O3H3OjgSik204gVhhNVbpA1laBlW8/lhkXdj9YS2LD/1LF9vYx+jlSW5L2B73ccuI7m8XMwF7aQt0LZxLVC5rHBJ3cOXMAI3ijUES7pFNFsxviYvjXQOIsDYZmImORnu3/znfnWH03P6bcqAvDCZQ3iMW6rqNDWDEEOoAD6SRmmaLmuhN/kZiZzpHcTcOJ8v/LeNTQC/gLrvM2YNZN+5Dgqhyu9j+eWE6nt5/zWW/BdorbNAsnYVsSZMkKrxE6aV03qoQ85vz6JOHhFEuNinNo1r8e7yLlooSfKoY1x5r9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OhqZtWMVe4zo5hbmLZD/bS19pb/VaewGY4Xa/Qt60CeRsWnV6bbqyaaVfcStzx3SShtezK/qUX2R980JtEp6KQ7woHErrekZH5eMXTYeber9iKKPEZ9tAn+csy2+Yoip25+1iHpTZfcLbMr7+fuFqKlibpepqwTMCMaCUBp+DOs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7979.namprd04.prod.outlook.com (2603:10b6:208:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:29:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:29:29 +0000
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
Subject: Re: [PATCH 10/19] btrfs: remove stripe boundary calculation for
 buffered I/O
Thread-Topic: [PATCH 10/19] btrfs: remove stripe boundary calculation for
 buffered I/O
Thread-Index: AQHY/N5avm10dFM8t0uNAEnCsGj8+q5g0kMA
Date:   Tue, 6 Dec 2022 11:29:29 +0000
Message-ID: <79fad9c5-45dd-e88f-13b4-b41e8e6c6f40@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-11-hch@lst.de>
In-Reply-To: <20221120124734.18634-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7979:EE_
x-ms-office365-filtering-correlation-id: d224249e-00a5-40ad-c363-08dad77d239b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7NGbxpbRQs8RzmaO5xCHFXKYw+FDCWQ8InDUKfCD8gO+8HTtrXIl+O9IoT3cz8HacuGSfW4XZY33kOXowjhnnuzhkExqha+C2r5oDb6kHDYZVdCx18ar9/hjeQbNAdKW2SOe3i4dV5Qq5+0MOuBsnf6x0uT4XoF3NEuFaHssiAtzNk+j5Vgacxio8cIXwT7ID7itgk6UG2Jo81YWm+UAe3FQullxUseL9O53U6Rt85f3kdNnYdXqgMJ4Uj0Zm9xLoU51tNtpAXtcS6M1eq8msP5r+wfgm3ZS07oQAhF9IL3M/tsk0K2E7LkKPDVILIAdS5wtKw1mrq3DJE55Ah31Uj67ISXcJUSidrESJ4Onj39RL5GLgXtTpg2e/KzppJkfeMK1pb7Ue1aCrG9gi2dYXc16AKauensDxlfjAWBmevSeHoE5N2X6uWY6uqY/zSqCR/iRRAXVmTvWwA545J2eWpDg/61lmQTcQouNNukzbYv4gFvAlJJn0oDTxx5SCb9Upk8CoOYo918sDfZD9mVbGLCxT9gW8sf7V5CA9ueuDapi/swtJqPIsJmKfdLilj/OtQ4w3nMDbnKe0s8qU8EbEML+TKBz7/7fghGxTSOFNcM6DhkGFG/XQKRRFidoqt/1P3zHbu0xW/JxDROeHGPkp2Pf/XSycV8PFhgJcYU/yCpVnyFFkOksyxhAK76OXvWzSPPvo9ap5vJHB5B+X0ANgBz5B08TB0N2/0xebz9L6zuf3hAiQEfgQB+3T9C5SkBWUSY7Ck1roNNufQQ5tpzGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(122000001)(558084003)(86362001)(31696002)(8936002)(82960400001)(5660300002)(38070700005)(7416002)(4326008)(2906002)(19618925003)(41300700001)(478600001)(8676002)(186003)(64756008)(6506007)(6512007)(110136005)(66946007)(2616005)(66556008)(66446008)(6486002)(91956017)(54906003)(4270600006)(316002)(76116006)(66476007)(38100700002)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE03b3BKMVhZL0wrWHlEYkFyR0xIbXpjb255T2ptejBaMG5nVmwvaDBkTDdJ?=
 =?utf-8?B?WXRVRU9xdXJLZ1FDekNMbElyRDdMcDZiM1AxU2xDMjFhcTFLbGVsSVNQTEZ6?=
 =?utf-8?B?Um0vNmhpOTNKM3ZUam5yNEJqVFAxdld3dmg5aTNMelI3TGQ1bDBKSHk1bXJj?=
 =?utf-8?B?ck1rSlIweXR3OHYySTJKa0I5TEJBUkFML3dqMkhaa0tId2x3dXplVHZZTHJR?=
 =?utf-8?B?YW5TQnhqdUR6aWFydjlMcWhCbksyM2JxcHJORExUTXp5WXhsazNYRnhyQWRM?=
 =?utf-8?B?bVBhWVh1RnZMN3lsVjZaYWJhNXZRWE5hbGRiQTBtbWlWZTlOVjNjS2c5Ri84?=
 =?utf-8?B?VEpNbFZMOVI0aENVNlY2aTVLWFhuYWhKVU1QZ252YXpMdUtzblRINDdtUGdQ?=
 =?utf-8?B?NCtWZGl3Y0dmRmZ6V0Q2VVkwZXJmbHpMV29PbVVxNHRRc0tsL1IrRmo3VUQy?=
 =?utf-8?B?QXZIeU8ydEE1QXZ1QkxLV1dXQ3UrcWwrTU0zY2c1UFF6MFhyZFF1dWNwYWp3?=
 =?utf-8?B?UDJ1VlZYM2dpWWxsT05PbnhJdS9zL0xaNklSVmMzcHlKdVpxMjdSMWlKZC9Q?=
 =?utf-8?B?YVFYWmV5NXZUU3kycGF6TWxITnQzcmxweVZiVDh0bnBTL3BRWGJ1OVNxMzdp?=
 =?utf-8?B?TzJIRU1SMm03YzBWcW81dWc1WFJYZCtJRU5BdDVGSm4rdmZnNDBVekVlUEQy?=
 =?utf-8?B?U0g3cFNpSWRKUHowaE04MWlkVSt1bDFYQkVrYUFzMUxsMjd6Q0t2cE81Ym1U?=
 =?utf-8?B?YUVxcUFlNllmWnFuQk41MkdJZzJYb0EyMHpEZmY3NTRydiswRFFOMEdnVmhO?=
 =?utf-8?B?VmNydDVnb0Z3NUR6WDFQbjZMeVUxak9BcElJaExyU1pURDdRWFBCdkJBd1Nx?=
 =?utf-8?B?SHl0Vm1MUUJxeVVxOWlZVjFtT1RxZjJ0U1BnNC9YL1Bhay9FcXJ3ZTFjUEM5?=
 =?utf-8?B?Z21OVnZqRFJvZTNCdmc3aEpYRjZmZCt4RjdlalZ0ckV4SWlFd0Y3NWJoYVVB?=
 =?utf-8?B?a2RjQjRKNUhOVXlRQWU4cTlVUEZXRjRiQkwwOHptenprckZmQ0pqVVFqd0FD?=
 =?utf-8?B?TURrTUxuSUpTQnZsWXNFTENtL3Jxa0ZQeXUvU25PR0ltZk1TaGNDSVNEK3ZG?=
 =?utf-8?B?aU9XdG9zeFZqL3F2cW5nNVEyZmFHTi9sK3ZOK3Nra2pUNHZndU5wQkJxZktS?=
 =?utf-8?B?L3VHenVzZklFcGk2QjU0enUzZTdya05rdFZTTjFtNi9XS3hZTFlqN2NlWVZy?=
 =?utf-8?B?WVptZE9aNWdFODZESE1KdnhrdlpJM2d5NnNaUklxR2QyUmNtT3VwYWpiT2p4?=
 =?utf-8?B?c0hxbjVOK0pQSU52SHAxMWFFZ0dBWlVuT0tybzlUV24rcWFWMGlzZ0pVWUhq?=
 =?utf-8?B?ZWVDTHBRREp3ZHB1Z3B5RmFOcXJtRHdmWlF3aXAzYkFjYlFkSU9GbGxJTWV6?=
 =?utf-8?B?Y1ZLT2EvUkc4WkRBajEwOU9MaUsyNlcwVGtHOUhmMiszaG9oNEI5d1pqZGMx?=
 =?utf-8?B?V0VheW5DZjlEaTJ5Umhld1ovVHVBSUFpR1ZKZFdGeUhCN1IzSW82NGJ3ZXNZ?=
 =?utf-8?B?akw0YkhvVFgxM2hidFl0azlHYUI3MHFPbnhmL1NZbVYzVXo2by95cmtaM1B1?=
 =?utf-8?B?aUZ1eDIwNCs4S3FQWWw3MENQcExQbGdDZFhUcHdHaDVSRnN0dW1BaGNYUXFI?=
 =?utf-8?B?T3A3L0xVSE00WDdwd0JxT0QxbUZDZHlBMzBqSFRlYmJpT012T0s5QUsvejho?=
 =?utf-8?B?Szl6Mk1JM3RnRVZHYlI0R3lqNFVuc0ZJZXpyUmtlcFN1U24rZHh2SGpURXRB?=
 =?utf-8?B?ZnIwZVFoUDZFbW16cW0rdUMzSXdHRFpsampGeEczYlpYb1JpSUExb0h1RmU2?=
 =?utf-8?B?QjBzWmluRTQvTkhZUG01R1JYUlhJUGdsbzIxQ3ZNa2k4NFpIczZXbTRXR25j?=
 =?utf-8?B?Z2E3eFRpbmJJM2VmeXl4SitnbG5sQnlZRlpoYnpTU3N0VVJaY3MzeGdPbEFM?=
 =?utf-8?B?RnlZRWNhMUROV21ROGk0d1FYVmdSUFFFa0ozZ0UydU1TZkJxdjMxQ2dqTkRw?=
 =?utf-8?B?SXpZY29waWNldnVZNHZhY2JtU2l2MzY2Tzc3RE5wN29YQ0I2SGREcnIyTi9X?=
 =?utf-8?B?bDZrZDJBVWNTak1SVzBNcVRhSXZTOEY2WW85TEpwamh5UjVwREVoNjQwK2I1?=
 =?utf-8?B?TTdLUE4zeGRhMVpZUElRQTM2OTVaZU8yRmxqR2hISkwwTmsvVTIrQWc2bUx3?=
 =?utf-8?Q?K7NYYwPNUacU12+PAsqJqmoN1EsX6cieUdLiK3uH98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C749CC6888564089DD01F580825C1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z0dkNzJFNkI3Y1dqOEgvbFZuSElyTTEyNmQ3ZUtiUG9zZXYzYkFoNkxjZEFJ?=
 =?utf-8?B?SUZTRndSa1Y4cmw4cFFDdjFOaWlHS3VCNllPL0ZGQk54T1NwU0VTZTZPTG80?=
 =?utf-8?B?UVoySzhpY0lkUHBYdWZlMmtxSnNLdE1xMHl3QXlmTWJQRmQwZFhGZklSZElL?=
 =?utf-8?B?VUxWSTFJVGg4WVdqaG1RYnA4THNaY0VoTk9rVk9nMzZacFhZUnB0WTZscDBJ?=
 =?utf-8?B?NDV4TG53aFgxQWwrUGx1eDlpWjV2eE1PclJHRU01RmFPTTJENFBSeG4zV0d6?=
 =?utf-8?B?ci9PejdYdEJ4R0ZDbGdib1BmaUxFVklyUFZvRUtmdG95RTN5aW8yaXk3dUNB?=
 =?utf-8?B?NXg5ZmdvM0pJMkg1RVNDZ0c1NWRqWFlCZzV3a3hZdlY4aTVWbGc1L1k0QlBl?=
 =?utf-8?B?QWxOYUVELzVOc0lKcXdIOXIvcDRFM2xJRDJjUlVlODgveGdYR2FMdkhMNGxP?=
 =?utf-8?B?b2dlNHZtYitGZ2xoczQwR3FTNlFGNnNvYjBVZDNMRktNRmhZNGpHS1ZBK0Ro?=
 =?utf-8?B?YkxHWE5ZbDNBU2dTMFA5OEFHbStyZEg0VEMwSWJWaWFqc0F0aGtVblI3Zkp5?=
 =?utf-8?B?N2duVVlwdVJ1SHVoSHpZZ0czbktib1N3elhWWDNzUWlmdXVhb1E3aFd5ZE1w?=
 =?utf-8?B?SnY2cVg3NzJ6VDVETXRjQnB4cmxPSEM5bDJGck8wRDg1cjN4Q2VNM0JQQW9I?=
 =?utf-8?B?QWovSzVDNUV1YW00ZHpGbE5ab0ZoY20wdzBVOEpKbEIwdHVvd3RXU0ltOFMx?=
 =?utf-8?B?RjVVYi8zejg1VnZWcEVrQzhZL3RXaEsxakpxRVY1Z3VFdS9RZDlLcnBKMXU1?=
 =?utf-8?B?dXhZUURWRjFpTW1Ld1hCdFZvcUQzUStjdlNzejVXK2FmNWZicjN5TXlWRks3?=
 =?utf-8?B?V0dpZlVZSmdtREdkMTJRS3h3QStFM0lKQy9PQTFHeUhMelVST3lMV09jL21O?=
 =?utf-8?B?dlFBVHVIZ1VXWUZIaGFQZXVYa0J3OGhDckRMNmtMaEtRejEyYkVJVFN3Y2kx?=
 =?utf-8?B?Rm9GWkJOc1ZLNUM5SGpOM3NOaFJHbHN5cWJiRlBkc3FhUE5jdzVCbVMxZ3gw?=
 =?utf-8?B?aG5nR2kwdGhNTGpwamN2ejdCZlptZXRTa3lnUW1Zc1l0UWZaeDJxMEUzQU9j?=
 =?utf-8?B?K0RpUjROdWYvZVpaYVY5WHVyRWxMc2xGbWtIN2N0UGg2dzhwMjdCQUlYVGp5?=
 =?utf-8?B?QkxTODYxVUx3TUNXQnh6eHJBY3YwR29GTVBEdzNZMk16d1E4NlUxN1gxaWwx?=
 =?utf-8?B?L09CZ1pRQzk4eU5tWTVFeXJ2QlZlV1pLMnBEQjR3UHhYZnhDN0h4SE9wSHNC?=
 =?utf-8?B?Vjg5Ynp4UklXS2RzK0gvNDI3SEY0UzhvZ3hENEp6QjZzaE5lSUkyd055VmxP?=
 =?utf-8?Q?DWiQqB2puk9rQHfoXLouPMAW5Vg6SIfc=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d224249e-00a5-40ad-c363-08dad77d239b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:29:29.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mo9/ctdAyC+qAJHwVyN1axXQpZEDgUK1SK1hT9mRBThTxG4+X6rkVyiVWpJOSx8DkVKJ7rX6EDDdSO6Ok2/QcTOok/eOHj3JrKi66YIADHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7979
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
