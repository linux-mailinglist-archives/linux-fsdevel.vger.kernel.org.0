Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411C6441CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiLFLEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFLEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:04:22 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09113C56;
        Tue,  6 Dec 2022 03:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670324660; x=1701860660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=XfuWEE2p2bw6qserwG9aL3vBFnsTa6+QF6+4NNGzYNYM0FgEEgZmaQ/b
   2aJ/spp/RNrsDzP8DVHQQOPFxmn71yVdxuwPcn0UeNFWZMyql41wkHXe6
   7WizdEM2YZLnwHMgy0rtH8bJu8V4sazXWN3cJvTE0O5FSuU4yvL4L6uBu
   beEdSTHB0lfSxgdTW6qgvvZGefj6wvfujEfyXUJ+aLyznQ95ctcT6gsk1
   BDmGUvRoxbS/D9AicpAGCGC4NeZyqb1YxEmuiMIzx65XxolDSyi4nKYpO
   o6t4jBrB6OxlAwIc9AHjch3lZ/If4bw7hFHdyG5tMKAkGqntG7xGlhvsU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="216221757"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:04:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arK5Bp0mhqPa2di9CdjnPW/PFw3bpFvzCOphfzNoR/BJhei+HBAcDHFUk0OyR4BIxAEf/5Lvwgw0MB8hnnmB93nVyQ/T89YtGluky6O6X/lSEIyY2y8DTNvTbVQP/AnpcBLXU05LsVJvjppUyZu4WAlu3dGbryre+QJ3qXT2vnwZ1wdiJrMMnGoPTc9aQipKs3DL++mbhfBhtmWhxd+x7oStE2CigbgHOBfoA1/ElmD9JlCapKNFozbjHd6n6K6i0bl4t4/jGOXdL2eU8FA2a8hA0x0US2uhKCO8SLz58uz/wYqLzzzmUzmpdLOjHhmezPSRORL/AKNXPZG6A45a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=h0HHCbyOk3amBo84Odw8yO2jYKqRhh3s/GzQJMmmK/SsWMTpgbWEkRBSNfseyZemPhFerF1XMkFN65R1YUvoNKG6jkV4EuRJemAglAR5DLmZnNHisbThmudpJALUUENw9Tav45BGp8+IkU6vsZ5r4+boC1bCuWtJ4O6SeiZo1XvTPQsoSd5imgOARyGLXQkEXzn0B1jPee/SERFdgheScDRse+HZu7X3vKrxpzlrpiYjPW7Ep+aaBcDMMNLHoLytJr6uU6APcHEhM7GMtDnX8PavrDbBKfx3JauC2uWqnpSIbApYRChZ3JJGjpYaHZN6nu9S9c5HJEs+7AEJT22J/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=R5DivWBD3HFEkeGIxVAAi91Kf+YEpnyBEFDw8NisWdcT2jAq1PqKWOKvNr58JX4LXCweK+LG4KdeLmUZpbT1n5rXKrt+4gN6WyrnAu1PQ8uFJZHisPCsmhcQzfTgnRnyaQUKnGb2UPEr24EY7H2Q8CnKwr8PBeDbTqWfrJsdzug=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0247.namprd04.prod.outlook.com (2603:10b6:903:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:04:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:04:16 +0000
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
Subject: Re: [PATCH 02/19] btrfs: handle checksum validation and repair at the
 storage layer
Thread-Topic: [PATCH 02/19] btrfs: handle checksum validation and repair at
 the storage layer
Thread-Index: AQHY/N5Rc4T4pkxXLEWR7XmAj+eE9a5gyziA
Date:   Tue, 6 Dec 2022 11:04:16 +0000
Message-ID: <90064ca8-3629-e686-212c-981cc43a9e1d@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-3-hch@lst.de>
In-Reply-To: <20221120124734.18634-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0247:EE_
x-ms-office365-filtering-correlation-id: acb54514-c6a5-46ca-a960-08dad7799dde
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFMVd4XkLT2C5kEBVrqk+Kc8YJEkZeEjVdImUkvb5OjfKraN/XVnFHuBusD4YKWuIPHNQJb1wy+x/mu5r2ijH0Ea6f3uJUroAJCwurq7g0ODYoI9Z6MIEOsBHWsV6epIi/23MN7XSH1AHPZ2vo8rFK6qhCSRLc71xFWxRfAFZGTLLJzWPYvpg+55Z0VlIumgflIESin3oCT6Kdw1CxBLIQ0QGY7xRZKadNOleg3G61lNGAGyOxIxDsr1IFsq24xQpX8a/Ys3qYaW29Qid62GoHbfbHrndmeghxagox5fli7V9tH5VXfSKPwaf6aNSvS3xCFsfPlQlYTtuOyBWbtENzMeZ7ZYdKlHbH/vbV5ecoKg5uS36WHhU3v/VInvcOyPoT+K+1hHSjdnIR0OcNYW5OwUgW9CNHcpEXd+VH5WcBi2vJavkuOtej+Mjm+jHYDswAvaDHjJg4wPeJqOqo0Ni7KzbJF5DmigTv0eZJOCerer7KvPZgTyhiOacokzFjUhUrS8yyLkcP80tEZgGNY/PAQRZ3Ti1oD86Srx9u2IyyZpNVq8deTOSx+pSLaKOwlfdEdm1o52QX3tsMsxwIt0zMUuySrjKpEBXGAIuN3UUbp9Cn6a5PF3XCtjk95xxSD8gPJbBIzp3++oqGfrZ2GO/+A3x/EmYs6Ru8jis0q6ToQRdr8O8kV5RAdQshn4LMyh49AALkkfXiHlTvkM2HERDDqKHnwquwLfI9+xC8quypk/Lq8GMxfpofP7Pf3E7zEJo0yhulPNzC+r8IhvTMsMQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(122000001)(31686004)(558084003)(86362001)(82960400001)(31696002)(7416002)(38070700005)(5660300002)(19618925003)(41300700001)(2906002)(4326008)(8936002)(8676002)(6506007)(6512007)(186003)(64756008)(316002)(110136005)(4270600006)(54906003)(2616005)(91956017)(66476007)(76116006)(66946007)(6486002)(66446008)(71200400001)(478600001)(66556008)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzZ4Mm9OY0c4TGJwL1dTbE9ZMWF6ay8walBKM2YxcUI5LzVhaHNFTW9HVnN3?=
 =?utf-8?B?Z1NTUjZISWNjNjExRzJ4ZUtiUEs1dFNvMUZZNDNsMjcrWHFUUDBUbHY3bENq?=
 =?utf-8?B?a1FadnVGV1pENkNVOVIvQlEwN1lPRVZMc3dkOTJUbVJPL1IvN000eUR6UitR?=
 =?utf-8?B?ZCtRWDlnbnhGWFNjVHljZUlSKzJ6Y0dKTTJJeVlobmtINEZVQTJ4aktoVkd2?=
 =?utf-8?B?akVaZzVuVVdybXJsUW90YXVkTVN5TDBLVm1mbzIwUnBnbDQwNTV6am1EWHhy?=
 =?utf-8?B?bWIreXBud1NlZHVPU0laS0ZiWWhwWElsbVNvS0c1MHExSDFjY2FQZXhHcmhR?=
 =?utf-8?B?ZEtVSGc5T0EyaHY0TmF3WGl6dUtpN29KaW1Jb3Eya3lJV0JFRmQ4VzNQWEFr?=
 =?utf-8?B?eWZlbndWZ0xGbnVZVVNkY1N0UWFZc1JFaEY1ZEFjMUZSc2NRQlF0UnpoNlI2?=
 =?utf-8?B?ZHlwRXRwY2dDb05EOUdvUnFsRm5yUDQyNWF6NVhGZExNLzE5d29xSlhLQWV5?=
 =?utf-8?B?bjFDZXo1ZTd1MXFPZWVqQUttZTBJTnh3RXJaTjR1UnJMU3V6L2tuUmlRb21o?=
 =?utf-8?B?dVNGS0VVcy9DV0RYVXB2V2wrbWIvVGlWckwxcS9rRThtbVZqK0pHSGszVDJJ?=
 =?utf-8?B?ZTl5allnVjg0OGJIMUx2cjR4QTNNeEloVlBBaE5GWEtPOVdGdTRKTDNNK0dJ?=
 =?utf-8?B?TGtmUUpMSTJ0TmQyeHRPZU9EU2lyRnYwK0pUaFJuK3VZMkw5SXBRUXJSVlpq?=
 =?utf-8?B?TUtVTHA2bGZ1UU9YSnQ4U3poTVhKTnBzNDlqc1pLaDlKVVQ3OHZJWms4K1U1?=
 =?utf-8?B?VVdjdUx5UEtmWHBkQWNCNGZhc2x2ZSs2aDRsbXEvejdVQXdXRDFJdzkvRk90?=
 =?utf-8?B?RjNmZzBXdHYzMi9uVnpIc2JhQjROTkJyTHdZdjZEUTFLMUNpM1VOdzVaQzBP?=
 =?utf-8?B?cmRNamJzZTdnNVluakJzWFR4RC84dlFJMVMrVU9zZ3ZLc2Z5eTJUN1BvRVNz?=
 =?utf-8?B?SlpIQzAxK09xK0VFMkZDWWVLN0FwQS9pNW14T2VRN1N4KzM3OCtHK2c2ODQv?=
 =?utf-8?B?Y05QbFJDYjN6d29CVlJJaC9nZDVBNXN0d0lZb0NYWFU1R3I2T2JsZ0NlKzda?=
 =?utf-8?B?Zkw1alpsMjh1dUZSVHc3czFmWTBPR1psQ2pWNDdiaSs0MitacHhMTFk2ZmlL?=
 =?utf-8?B?a2RsSW5KbDJwNHQzbnRQamtpa1RxQlRsVTRGVmd1WHBTUURFWUNMV0xqUTl2?=
 =?utf-8?B?d0IydXAzUUF3WUp0N1JCdVFKblgwYitOTStpcWptMkpqZXBsZDRGbXg3MkNQ?=
 =?utf-8?B?V0R5M1V6MjAvbk5Jc0Jta2Zpcys4dWtuNU1uaWI1d2ZGSWFBNURLQ0pyWG1G?=
 =?utf-8?B?ZDFpelZ4ZmVvWVJYbGVDeCtYWGdQRTdaUy9Gbzl3U2VSMFZNSFdPejFUS2ww?=
 =?utf-8?B?ZGRXbHJRclZsVzZQMW8ycm9ta1o3UXFQVDVHeEJIYUhNOU9JVXFqbzRPdUEx?=
 =?utf-8?B?elBpd2ZsZXphalZ3d3hybkttbTBJZzJpd2pqVlcvTHhJMjNQcWxVTFMwN2do?=
 =?utf-8?B?MlZuYm1BK25yVTNxaS9Hc01MNC8xSnVJcjk2SGlwcllzc1VVOGQrdzBHYnRK?=
 =?utf-8?B?d0pUdkdXengxUGJVR1NsMy81Z2JuQlRtOHlEd0VvYTZqUlNjbmg1a0RvM09C?=
 =?utf-8?B?RWFnd1pRbzFrNjVkc0pYNGtLWFREeGRlSTRXVWI0VnF2bzZCRXg2RUJaQ0ho?=
 =?utf-8?B?QUFIb08zSlZaS2FScCsyNVZPUGV4SW1RUytJVVhIY1A2MFlPQThpc3pobCtC?=
 =?utf-8?B?OXVFSndCRE0xaENkdk8xVlRBQmRWREk1Z3hQdUhsSE1RMllZSjhldS9NVWlr?=
 =?utf-8?B?N3dVV0pMeXlZKzNUb1MwQmpjbyt1dTFPWUVNaDcyWU9wMEpyU1hkbEpSMTJi?=
 =?utf-8?B?UHNRVWNoYUJuOWtPSDJVakpJSmFPMlIwRW1VVFdLMVgxM2pjbE9Hd1JUS2Vs?=
 =?utf-8?B?ZlNUSU85MmtHanNvMEo0VkhaVjBsWFYzM3BwdUpRSHZXVDJ6dGRCd3RVTGVB?=
 =?utf-8?B?Z01waVdzSkhqRmNabWFRcmJyVElVSWNvMkh0MFNSSFV3a1RPYWRyV0I1VWJ1?=
 =?utf-8?B?enIvQkV5dUVmNEZvalBNRnJQNVZUWlgySHVUY2NYVmVCNjZjZndlaWpIeURH?=
 =?utf-8?B?TjFIU2NrVFh2SEl5R3hRbG9MNVlNSHo3dVVCYkNIQllsWTBuU3BLaXdZVWdJ?=
 =?utf-8?Q?6Ru7g/9kMOklsOlL8oqeuOfukDgyQxQagc9UCN/1Rc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA5FA69D67CAE4C80632B15CEB34278@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SGNvaURHbVJuZ0MwMU13OFZmVklvTGhWMEFwZlRKejVoZmgrd0xWQlF2YXJH?=
 =?utf-8?B?Z29WN3hQbkhjdGpablMxWmF5Z0VqY0dEOEErOFNWbVdOcE1UTGs2LytMTHA0?=
 =?utf-8?B?WFpyM3o1NUc1aDd4eWRRU3lBN0RxZmxMZGozQU9rUjREWU84aVNGOFk4UFdh?=
 =?utf-8?B?L1grYTM0RU1PYXZPKzFNbDgvNHRqK0t5R2ZWeWU2ZkFheFZualdCNENncGVD?=
 =?utf-8?B?d0NWS3FpcTlUMkptZHNBZkhkTkM5QjRJMXk4Qjg1UjlpNkZJbEJkNmxXS3ha?=
 =?utf-8?B?dTNlOG9OVEcvZGJIQUNsQlFtcW5taXlQbmhVR0gvVjVYd0FJMjBwY2N3S05E?=
 =?utf-8?B?TXdzYy9ySVEvTjdzOW5TczdCclphVm0xb1ZVNVZNVHJobVQ0MmkxTVo5VEVP?=
 =?utf-8?B?LzU2aW5TMXp5eEI0dnRMZ3VlN0xhVW5iNG1BOC9ZUUpYcmJic1VqY2VvN29S?=
 =?utf-8?B?SFF6N09Ka2NSK0twRlJldGtDU2tOeExWZFErWGZzRUE3N1dmeFdZY1FmYldx?=
 =?utf-8?B?bS9tbThGWHhHRC9CY2lObmdIa2Mycml5WmpDMTN3cTIybUFCV3dTTUUya1lQ?=
 =?utf-8?B?YnJKVXcrbVdjSUdDOFJvWHNGbWhtODBndnF4ZmJLaTZhZDNpY1p3N2kxWEhj?=
 =?utf-8?B?ZVdBZCs1SnBGQm11U3o1bldCRFRZY1dHYkNoQ1Q1VXFSbm9ZNURJMVFLMVND?=
 =?utf-8?B?TktCaitBUTNibDJCb1NhTkllOHcreVVyYTBVWm5ueTYxa0pJbU9JZWt3MEpm?=
 =?utf-8?B?RXVRSnR3dDlTalkrMnE2bWg2V0t4RTBFc1UrRHQ4WW4wMUU0RU9CdDFjNVZY?=
 =?utf-8?B?U21kVmJWNFh6YTgzY1NUdG1tTXBHZGloYXhKK1YzTUQxbGZnM1JCemlieEEv?=
 =?utf-8?B?cDdXTUR6dDJ2bDhlYmZWNTQyWHZ2eU96R0wvQ0ZicGI1Q21tQkkrRzVla0Yx?=
 =?utf-8?B?U3hLT1hGN0MzcEJtSFBKZTZudjVITkZGYUpFMjd3Mkp3R3EwQVExOVZsTDgx?=
 =?utf-8?B?Tlh2aXh3L2c1R2M0cGdZK3l6ZjZ2bWs0b0x6UC9sb05KMFBjMTRuYVdSQzd2?=
 =?utf-8?B?blR4NFpPUGxrSW5kM3lFN2tsVlBqL2FlSGtPcVJXZHFZcWVmdFhQWSt6NXR6?=
 =?utf-8?B?R1RuUUh5ZXZYN2tGeWRaa1l2MzNIK1NITlZPT0tyTVpUTDh4bUhYbktHeDFX?=
 =?utf-8?B?eUxRRGxQemxhajNQRjBxbFZkUnNlcFhDWHFHQ1pBZ2tiRXJ1RlJKakw0ZzBl?=
 =?utf-8?B?dFZGWmdRR2Mrc1JScjVvNWk4c3U4U0tuRjV2OTZvWVd4QTllZEVkWVJNa1ls?=
 =?utf-8?B?N3lqNmxtZXVjNnhXOXh6NC9TQkg0bFk1YjZVeTl4R3FFTm1Rd3lMUER3TDd6?=
 =?utf-8?Q?kQNlfrj+ABot4IZ83ryqAqnTC9+WdTmY=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb54514-c6a5-46ca-a960-08dad7799dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:04:16.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjhG/ToVtTHdgyAKh5VaQD066e+t8Z7gnRUhv2QVOhz/xUvcbmpN012QDdgqpaNEg0Xd1+A08ujJpesjeDUBHqionCSu5nrQA+/P5Y1ZPnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0247
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
