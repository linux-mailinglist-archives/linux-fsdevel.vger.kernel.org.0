Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B166441F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiLFLWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLFLV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:21:56 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C88B7FC;
        Tue,  6 Dec 2022 03:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670325715; x=1701861715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mut57DSIUv6wHahvD2jRnVZQf8n7e2MA5VcthJGPAKQaj0H8BMpmuCq4
   1p4vs75rMjRjfRSZVeaFliQcLz4ChHUFlA75TlhFiBKO1SzS0ujIWBOBO
   e6dVW62VyNtXTXLYOXoECoP2O2+z8k+lRd3hbrbkwzL4SUCBzPVoxLza0
   v3NJ5dETSx5d2ViT6TyEm4xZoq2RNylXVy1Jdt6e4ln/Q+se6jvWFhyJG
   3zXMh9RJis15wYX7f7BOgBbNfSZuCRknpFmYc1y70tfPE4NbS74yw9LPY
   SkTwGsTr2VXTDIj2o5FTEkD7fon6AWEnoolY+Iml58YNu7nThapC6S2Ms
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="216222697"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:21:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0ftbtZG+6pOIKgRmbOb2xVlCHmuyNRFOVnHH4vgnCrs+9Fi0puwPAPJxC13pybbz5MPj18J3ufdslubEUIuKHtGFp/+TkzDQm0EIhdIGuOVbgEIgQeHJ7mvcBph4YPc3rHN0XwFlYH2o2rXyni9Hc4w/nKxEisIyWaAtpr6c8fOk1ZQT+Mt+nNkhir/0TvExGC67UV+lnnOpBOEuv0mh0BDe/f2AWLCpLfdqVL/PvdScd9YoXspugXsVTMA//V5YczyrboiMGTinG8ug0bGoxLfwyBIgr4fHNBy76QjxCXDjekmoYtHofDdFaQ2Lw6Tvdlyfmn+6tupdwwqkjdw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QR5ybHUTHuzAdhu4lEj2B1H1buYlAZ1k0H78Mqb+qEQj8mtEhnq+7+DZ/bjWbgysdOUT1bPcra0Ta+OP7tYIETIkC08aqKHG3dxu5uCeNbgexoq5gKRbTUnkjV66FfAaEhGG705SSIAXDSzwV3nbfFePADQ1EbuzfmVrpgTSKX757c7NcwCCA9Mg2rpNhjtmmzP0X5OjSOClF1HcRQPCdpEa5RszA+do/Qg3dHiZrW5GS09WoRPsaYuY3orU7lt0GBSi5bPC+mLw5mup7qkJktBegz1M3RgTybXRqhrbeHq1pnGLt3IkbirbkEQpf9ouUwrr3bWfxHN0Qffc/Mc8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VjrpaNqOMqcPkDC2jgGSSdQ+uXk138sTTYbhUBT7ciE2xH8TwmXr/yKXCRtji5HAyqyoZpDsG8PwNX70kZOCXKW8T+bMUOPHK7qV6Q0A0dcNrxxWR26hsAU9YqzEpB6gbweqIPRKeTE9t/ALfRDpEqZJv79ehmeVtmVjs5jIk5c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7979.namprd04.prod.outlook.com (2603:10b6:208:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:21:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:21:51 +0000
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
Subject: Re: [PATCH 05/19] btrfs: handle checksum generation in the storage
 layer
Thread-Topic: [PATCH 05/19] btrfs: handle checksum generation in the storage
 layer
Thread-Index: AQHY/N5S+KhHZwYwbkO5ghwSH8AdGa5g0COA
Date:   Tue, 6 Dec 2022 11:21:51 +0000
Message-ID: <ca5c1bc8-e008-8a8e-21fc-1971cceb1a42@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-6-hch@lst.de>
In-Reply-To: <20221120124734.18634-6-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 7fcf2a52-0d62-4f71-98bd-08dad77c12a3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFFad7wqo/mFDgMppnXFz5SC+g5xI7AczKHD91zYDs4/p/4WBRnqJYyL1USJ+5qaBQuMIGbNTYj+sH1x2THB3VmyQhiBGUS8rBHUWQsAkTM2dyMfL58ZCGOXVxj2O71PvBkEXIqMZIiynGovuFzQ3sw4+UVwvWiQPGU+O+QvCPsiL/WsxNrxTK9cCRGaHhMQgrQHHJa/3PMmARS5mNbLQCg9OXp4QY3DNTwKp5TrIJjkKucA94SNL6wRZt5aXBbckQ2IjaLjutfe7zkBDdqQBMgu9A/r4uE4yiewOSXYMsuyuehGedbSUkrkeX3x6+26W9gUTWYOo4jnbf6ID5cXqrHNVt6r6d8R5DWYjBxFkIdCCYo0XWwy8rTp3uu3ruJB1pcMkIFpSTFl2HaCnwnsmvFPl3qdiOjpZbK2xyWBqfv6Zeh+X1u6/jb0uUvK5tZzMRwEbiheS3RXnUJgEE/YKKLEdMJdqOjM7MKQwP2yDfjwGQV2bHs/AnfFZRuxTJ899F1dBENszczna3jtrlMDLZ0MNlNQIGoB625eIdS0lX4wtCSpBzdbeGdXwpegj+wfnOaV430Jnnzrl4Lb1vkWHO/ARPSvg1iKE8Ekr6gs+K1spFhuK0IQtoa5imYRw4F5YD8ee/EZJPo9Qkx/7Y13B6v9UlJZn3qU46yXOqiluD+NBD5iLRWy0GLp+1ukUsBB1Md5QMu+bwFCaWw65/pCvyC0vV+VlaccFTOqQAOrDq9N2w4zejgx7QxS/vTauo6NTi+bDHjp5jHWJA9Z8ab7lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(122000001)(558084003)(86362001)(31696002)(8936002)(82960400001)(5660300002)(38070700005)(7416002)(4326008)(2906002)(19618925003)(41300700001)(478600001)(8676002)(186003)(64756008)(6506007)(6512007)(110136005)(66946007)(2616005)(66556008)(66446008)(6486002)(91956017)(54906003)(4270600006)(316002)(76116006)(66476007)(38100700002)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2hkamwvMWxvMGRVdFh1b2lOMWxHeG5OaVpRdDlzL1oxanRmRW41SDRxWDdm?=
 =?utf-8?B?L2pVeXdNNHlGcWpUOG5EQkxrUDRlSWtNb3doMG83U2IzbFJWZDFwd216eHBu?=
 =?utf-8?B?K1pOZ3RkWktPb3ZJMDA5SmZzSUtlRy9iN1BKaGw1dzUwNVhDcUxUVHNiRFU5?=
 =?utf-8?B?R2FFc2R3aVlaMUVwSVc1RmhCSE1FTU54bGQyVTRGVE1lTUN3MFlJdmZCK2pE?=
 =?utf-8?B?SjZCeWNKTnhpbHUxK2pEdE5ZZ0dwM0kvZXVSUTJ6cXB0bXFWVTBqYzNaemla?=
 =?utf-8?B?eXc1K2VpejRaNElMZ1RibEh6OGRCLzZBcGRBMWdtMytoQTBjanJaM2RCLzZr?=
 =?utf-8?B?WWlkNmsrVzJ0dW51ZmRvbGNBVFlhN3dQdnl2SFB6RGdSeXhOUW1aMkNTTnBu?=
 =?utf-8?B?R0pSTGkrRzRCb2ppYUZqeUV2WXdrQ2dMcVFVUjNnTFBCQTRTVU9BMW9ad2lu?=
 =?utf-8?B?Tmk3UzhGMlVtUnYyRlBELzhaRnVJV2NGRUdLVGpQd1JnVXZTWFBEN2FRc21i?=
 =?utf-8?B?RzY2TWxVeG5uNDhOMzg2YkNHNDJRdkozSTk2T25FYzJqMVMydmlOdXNHbE41?=
 =?utf-8?B?QmVsNlNPSlE4alF2RExPaG45dzBacm9UZDkzRXFZUGFTUkdMcm5nWWIzTlh3?=
 =?utf-8?B?N2Nva0hzQmdhUHMzY2E1VHVmZFcwS0krRmJ4a1NET2VqK0ZLaWV0dGI0Zjkz?=
 =?utf-8?B?QTNVRFlQSTZJU09ISXB3aWs5TTExcndBbFZ4aTliSGRCWnFvUTFud0daOUE2?=
 =?utf-8?B?WFdxMHB5b2o1WTRzMTlpaUREUTVOTGRkVFh5YmFxMlNvYndmMzJiU0FrVWF3?=
 =?utf-8?B?OGJjWjR3bDlBTEVacEM4ckhnOUhNQlpldGlhZkZJZ2p0Y29VMkhzWEJkR3Rh?=
 =?utf-8?B?aVBVeDQwWXlIazdoQ3JPbVA0YmZPWnVTamQ4cmErTkpLNXZQUGlqMXZQV2Ja?=
 =?utf-8?B?ZHduRkNGQ1F0MDU1Yy9NUWNOVGRMa0txRXpJbUZCSm1zdW5tcmFVaWJQL0ly?=
 =?utf-8?B?eWJOdW1lbXRqcDhRWmozWE5pQWhyUFh5aUs3cmdCc0piVHlwc1B3SkwrUURm?=
 =?utf-8?B?bDI1VTN3SVd6SFN6dmd4SkNIeHBKL3B2elI5Q2dsL3I4S2hDSU83QU51OHA4?=
 =?utf-8?B?V0c0azZsK1l2VVVjRndCSkwwbEFnSHZSeGhtNE1qd2NOSmtQTW1RL0Q3QXJZ?=
 =?utf-8?B?VStSLzh6UmY1YjdVOVdSWUh3ZDFZUnRSRUxvYlRMVHdvYnd3OUxiRDZoc3JF?=
 =?utf-8?B?OHhMS3FMSkRTQXExeG5XTDlUSzlDQXlOOWNqSkxsT29vSXQ2cDRtWFB1WWJH?=
 =?utf-8?B?ZWVDTHc1d0NqRXhZbWNFNkxzWUtqTDV5NUVYbUg4SFBLU05tdlRtTndDcmda?=
 =?utf-8?B?SHZlS3FwWllZWUEybzJhaUhxZk4rT2hWeUM0WFYrM21ISnBETmZlR21VeVJ6?=
 =?utf-8?B?bWM4R0t1NHBlTUo5QVZZV2ZrUUFsWGxnbllnSWlJWk1uYjFWUkZaTmJMVWNu?=
 =?utf-8?B?bmJxVUpLZDJBV2N2L3R2QklnQ0QvSi9acFU3LytaQTAyNHl3dzFrUlcza2p5?=
 =?utf-8?B?bWlkVkxYWHBNZjMrMkxwQ2IyZmR1LzBaaUIvcHhKNjhVcng4SlE2dTZDblpG?=
 =?utf-8?B?aFRPQkJwSjhTYjk0SkN4Zk5oSmRkazhjWUpKWTE0YXdtaksyN0xEYWZ3b1NK?=
 =?utf-8?B?TkFiTVl5UU9GOG9qblcrMUIvWW9ucjRYcUxESlJzcEFaN2hIdTNRMFpSVzZw?=
 =?utf-8?B?dlRUbmNSY2RMVzBQUFg1a0xvL1VrZVh0NVM5Rm92ejA5ZkthWlFkaXZMVFk2?=
 =?utf-8?B?a1RKbXF5VUNRVU9jMW9SamxDVmlOOGFKRUk3QXAvTnRVQmZnRGZFN2NORGRn?=
 =?utf-8?B?NzFvSEx0Y1ZKOHlNa21GaVg5WktDd3k0VXdwVUJpRCtoTWRROFlyQlhSeFd3?=
 =?utf-8?B?TW9PM2RoTWc3Q3F6b3p4NldKQjM1R0M4WlBvSGljSnFrdWFPRS9FQ2tWQUpw?=
 =?utf-8?B?Q3NzNEJFN0tvTGtZcExwZUY5MkY5RVh3czdiZHRLNDFLUTkrem1Eb2x5SXdN?=
 =?utf-8?B?TDBNK1JQRXJpSE9veXVHc3hyMGJUdWJTY044M3c2UjEyYVI2WmtsTlJ5TlJ1?=
 =?utf-8?B?d1NYaXpFaTFtUGxsTlRWdmpoa2tIUHhhWXBTTXVhUllnWXBCMkEyTTFIYmpX?=
 =?utf-8?B?WlBxRUhnbEhHTmxhSGV5QzZqMUc5clFsSFFvbng2QXFLd0Faa004LzNTMWha?=
 =?utf-8?Q?VlbexGwsUcrxFzI6j9u9VS2E/lWt58VVsJkVYWHXnE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3851772718F57C4EBBEDEECB38946B8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NDNneEMwSzlERUsyOHB1WS9jTXhUNDF4WnJSSlVUelIxdW9SQkhCN29VaHYz?=
 =?utf-8?B?V1Uyd2FOZ1l6YzVYS05iYVFhbFJNdlQ2aEtWdWIvL0tDZjRKeXpzWWxrbVIz?=
 =?utf-8?B?d3dTZkY1QlN4U1ZqY05YTXBwc2kyM0M0V29lQmZPZHRDZ2FVdjh6U2pTbmlv?=
 =?utf-8?B?RXNKdzV4VmMwckw0aXhmVG41dE5YM1BtKysxbW1vaGdQc1I4cThDWHhXcjho?=
 =?utf-8?B?MktQQ0dvd1Q0Vm1oZFJLWTVuak93bGhyR1BQUXZUM0JKU2lPdWczdDJ1QzFa?=
 =?utf-8?B?UlZ4aHB5L2hwZk9IdlYwbzYrUjhYVUV6cDZxQ05TdTRoQTlQVGV3b3BtYWtI?=
 =?utf-8?B?S2tPZjMxSEdnZVVpWTM0MzMvNkFqL2Z2RjRTcGY5N1piMWVZd3oxOXBZblBw?=
 =?utf-8?B?cUhkcnJQbFBhNFhvTVVCTlJReVlnU1JQeXZFMnZKdnhWck9ZV1kzOGJXVEVx?=
 =?utf-8?B?bDJvWGpKM0FaZzYxbCtMU3hmb0xJMzEyK1ZwUEFzMm1Na01hK2lIbUczWDM4?=
 =?utf-8?B?cXhkM04xdG5MWWo1VU5Jb09MQjJBUGtLR1Bmc3JBY3Vybi9TUmVSck5ldHM1?=
 =?utf-8?B?L25YRDRsbTNKanpqYnFiWEUrd1FUdXYrZ3crWTE4a2RLejhoYVRPWE9iWDBH?=
 =?utf-8?B?eWdDczFZU3QwZm5xc29jVXdIV1VpQ3NiZnZ0WmY3REdoVmdyb1VoMVBFSHJu?=
 =?utf-8?B?TDhhakZNaFJWTTNUdnVJWVBGY0JJTmh5NHA4MStuc2ZMYnp1SlZUYkMyVmJV?=
 =?utf-8?B?VGFRWjZPNFpkdktJZFN4TktCL0pmMlM4WlQ2MnBGMFh5WkR6T0p3alVPdkxr?=
 =?utf-8?B?dVRrdDgzTlY5S1lxZnB2bExUMkgyaEt6QTJQN0wrWUluckRzV0VaeVY3U1U0?=
 =?utf-8?B?dk0xWiswelhRNmlPWkg1SmVROGdRVEY1K3Z0MWczV2hsYklJckQ1TWdQUXd0?=
 =?utf-8?B?NStHMklKd2lKY3FTb0FkSjhJN1lja2Q5QnBvYU1JNGpkWE1xd3g4TlR3MEov?=
 =?utf-8?B?SXB1U3VKTCtJeFQ1ZlZnWGdSd2FIbnYwNStYcUh5K2FFQ3dQZnh1Qy9sd0ky?=
 =?utf-8?B?a1l0SHBJQSt4eW1kRFFPRGdkU3lFZ0FBKzhxaWlkejJvck9ZK1ZDTzNhZUVq?=
 =?utf-8?B?ZGhyNDJvTzM2QmwvbE1qMit2N3lSZEVvZThicUw3a2ZkTklZYVV6WUxyQXRX?=
 =?utf-8?B?TUpFQ3djYVlUYVMwVVZVZjFMc3dLWVowTWNMd01LYW8yWmZPY2wrZlpsdFdP?=
 =?utf-8?B?ejNLaVp0TWpqdjRzdEdBWWs0MkcvQ0gzTkI4Tms4SlBUa2w2SU5NWFBsZFpS?=
 =?utf-8?B?bitna2lQdjBBa2k1dDc5RmpYNWhmWm5GR2RsYm1wYTBFdzdubXgwY2duM2NR?=
 =?utf-8?Q?cBVWCdDteStu4wlB0omISikKwmlWqtUk=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf2a52-0d62-4f71-98bd-08dad77c12a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:21:51.4974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8Xhjn43pLrw51jG+y+4W83seYJMpHoLPRNUdbPzHbF6GLzYRuNh2KBchGA+LPVG+OxDUMK7cfHsrLUgF3Qx47NRsRHxQYyeNW8IwsszNIw=
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
