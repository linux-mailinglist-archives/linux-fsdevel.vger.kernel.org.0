Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236396780AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 16:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjAWP7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 10:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjAWP7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:59:44 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AFDCC3D;
        Mon, 23 Jan 2023 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674489574; x=1706025574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YhikOauPN/rIV/sU7NpBNYf9U7N/KTuCTY529QZwhxQ=;
  b=pgY+Lth4OKW7Gg0EJ4RrRDwSB5ADKWGH+Umz2rOYysnXnHo0UCaOV5D1
   Msl5fnaSvRoF2jtKBL3O6T8yYQ5mViPhAVDoWXSfFURRpXt6EkC36JftJ
   OMTuEdNURfljPgDw8aROfT/3fKfviUEz7HasqrLWS3aIhYEmREuILce6C
   /YpXbEUM61OgJTm6Okg03eT1/Cx98IdciF2RwgLQNwNhPO7wmmD+7F1Tq
   uYu2ytsruIOw0arI3KUVtuLBoN+pNq4EqoCVfhCwUf+jVA8AEOPQSEaxx
   GGkpAcxsQ1yUNq7wQfNq46k+fm8+Srx5Ml3fD0Fx4l6VR4XVzzOrlFeV4
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="226545757"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 23:59:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciJKIBm3GCXq8Pv8g7Ky6xeYmz7odkfo0Mvmt/TzEfNnmogPf+epf35eYmrINSNCS9fBA/+iZpSDqhNj19MbAerhETUYBUzCGK8zIuDVXYgjA7yi0CprOgcGim+ZVEMut5bSiebQoqXIzkzkgeN7uk3BGals0i93K2/wvJA6rIAlGdc8enHEYFGKMMMIpbH+CchzSkWZiPVgOv0qTURU1aBwYPFBiIAm6Xoqgoynih238a+9X1Zm1bjaQpdro6rrefCGdp/vbByiqyxSJ5AKYbHSL+qgiHtTMOBQejAU50lH4d9Rzm/N5U1bc4Msw8QWkgQRgIxCELfc3obqNS6u1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhikOauPN/rIV/sU7NpBNYf9U7N/KTuCTY529QZwhxQ=;
 b=bQgv0BcoZA8zGHe7CVFYalQ1OlEnV1o97EsbuHZznT8b2XiIg0rfiIKIPRXzlV6qXXMyZbSE1TQeWE/encNr2AUDGIbYMTU50J4a3u0ULiQgQXhVRVmGb1StDs6OyaQavaMd8SkjxyIVTj0xUtcVGk+rKrPCJiT9LEK2yZcJEyEV1CsOr9Atss/iAuVJTVyztH+R0KrgA8TVWNV00Iw1kLAxAQNKoVhHlzYocPoTnumm7Q65UZTej+mogKNkKcOqEbN11hcx12e4XdIXLZ1vnScIzdeSAQ6S4dG1L/a4Rxscy1DYOe/68GVhIxMXmQ2j4zpX+ZlxbB5b73zXKAy/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhikOauPN/rIV/sU7NpBNYf9U7N/KTuCTY529QZwhxQ=;
 b=x5/iX7OAoFtV6AmmAeV7rp4NMHiTNDE9YlS6lsqdIIP8IY8ZExZlP1YFwZ/i9zJ+WI4ayO5lfBTHRKbNSa1JBDGJ05+JYYvElYyAzdUux7cY6vaM5fvKXEk6wMo9MfYKDcn8w6jc6S2cxCQF/XOudqIn6wjSu+AlCxboxF/XO6M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5647.namprd04.prod.outlook.com (2603:10b6:208:3f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 15:59:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 15:59:30 +0000
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
Subject: Re: [PATCH 04/34] btrfs: remove the direct I/O read checksum lookup
 optimization
Thread-Topic: [PATCH 04/34] btrfs: remove the direct I/O read checksum lookup
 optimization
Thread-Index: AQHZLWS3pW1cBEbtU0ybfWLT9keuSK6sLI+A
Date:   Mon, 23 Jan 2023 15:59:29 +0000
Message-ID: <cd2b790e-b607-854f-70b1-eb4c492b9282@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-5-hch@lst.de>
In-Reply-To: <20230121065031.1139353-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5647:EE_
x-ms-office365-filtering-correlation-id: 169c576d-e2b7-4699-7cca-08dafd5acfae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaldTSygJhrl2URjmQ24IXpGfBtAepjnZ586sFIKxGf4nFLhjlOqmJjNQxGTGNXwbQzDO/mUJfiI7mPwSealtkCmS3g01pL6rkIof13FBj3kg5gW6GKgpODu7H6smtZFpCZNarUgTddHhw4XAFqUk9am/Y9pX9FXJtM+JeS526th2hr0SkWU223hhJtmtdE75+hG0EMyEDj4BwL5PzBmep1LksSwxjJFXw979TA/kCmr05aEj4b+GeYX84zeyIae4Mr5PsXFKVE3oKKPT791aKdgUixs2lUZmRW0FxAku03oOXxwCwz17EzItnK9uowXR0+NMXMvExIFGFiHDMnVPn9y5SBolyGI5FSPPe59gZUC4X+svi8XWawHu7e1gi1+4eVi2V2P1lSUohePIuoq0MN+IdrWjUyZ0ah4LSMWw0YViog7K2AhbthXW7W+LraDC+LiEY4+2lZR+5QC+LTf4bb4h89nJYVpHP3AUdXhkeXyrZo+0o1Y0/X+qq5tta5RcNtUvyHz1JdxB9yC4+GqTbimyw0xsSOHzvI4sF5g1NpCGKb7qRUuuRWXkogXUpOsEo3IbOwWuybF2lD145yKrPUzmsPpP3XTZLFmII6lF4+687j7LqSdna+MUFFQhZ5JzibMC54PJmOxO2ldoOYzX091mgO/FDgUm1mexy6lNhnSixRzum2Hkx118c30QOtioY4v3EQ5sMn/GqqUyl+6rHke/U36vDflADbpRJGW7MaP9B5G8ThCq3n2IglT+dFOwVt2073wCOPTsyf6C58TPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(36756003)(31696002)(41300700001)(86362001)(38070700005)(82960400001)(7416002)(5660300002)(8936002)(4326008)(2906002)(4744005)(83380400001)(122000001)(38100700002)(478600001)(110136005)(91956017)(71200400001)(6486002)(31686004)(8676002)(53546011)(186003)(6512007)(6506007)(316002)(76116006)(64756008)(2616005)(66446008)(66946007)(54906003)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2k2M0VGbjRFaFdzMEI3cWxvaDBsUmhNalFlSUJ2cDFqWU5qbWtkWS9GUEgw?=
 =?utf-8?B?eXQ5VGFRRWppNitZazlCN1ZsTENXd3ZMTG5FcVpGcE5KVVU3T1ZnRGcvbXBB?=
 =?utf-8?B?VVErakVGZDlWVVk2M2NGMTV4NjR5TFJTUFNBZExwT3dxMGxUYlRibU5VQVQ2?=
 =?utf-8?B?NW1vS0tjNk0wcWZUVVNqczE2bWpHdnMrYnFXNlA5L1drVytDVDU3dFJQUDRk?=
 =?utf-8?B?bnRqdjZ0YnM5Tnk1cTV6WkJ6VmlvcTJHclhlbnJhelRmSUZXMjVjU29lSkl1?=
 =?utf-8?B?Wjd3ZllwdnIzcWtXTHFQakowV2RaWGRoVFRyUFRJeFljOGtkcndRR3JJY08x?=
 =?utf-8?B?YW9uWGoxdEtlM05ydjh6bkhuZ2dnOGkra3ZyNTBoMnV2RjRMRDc1ZDFLaXE5?=
 =?utf-8?B?N1BVaHQ2SUFmQWhPenZXSDQvME1Ub3ZDSDA0V29kdjRwTzV5eWowRkQxSlI4?=
 =?utf-8?B?bVpQak5QTzJhNWx5emxnaFlsU2Y0RjRIdzI4Q1NoTTdoMFJ2ZnMxcjhCY2Vj?=
 =?utf-8?B?NzUvMWwzcDNPZzdpREJOeUZFRnNYOVRZTTMzZXhMU0dwSzk3VjAvS0VkVTY2?=
 =?utf-8?B?SFRtWStLR0U2OVRQbktPZVdRcUZZaDBnVk5TTE9jcHNWYTZYVjRqa3Y2a1hk?=
 =?utf-8?B?NSt4bkdXWU01Vit0ZTFBRHdNckFzd3llR0prR1E4ZkViazVXc0haczhEeGpX?=
 =?utf-8?B?cUdwQUsvaStYSmVwampVcStsNTdXQ1ZZeGVubjYvSGd0OEpKWmNvbndReVdT?=
 =?utf-8?B?SEUrZXJUUVhRWkxZc3MyY3plYTJLcjhMVmxWTEZPbjhHb3dvcjNQVG9vYTBQ?=
 =?utf-8?B?NU8yRnFFYlREdGYrdTVFWUYwaXJma0pOOGhPajlLY3BSWTNaT3UyVkxOVmE1?=
 =?utf-8?B?U2sxUFBjUnZUSHY4YmRmdUl3YldUVWR0TGpUOFVrSEl0SVcrVDZPZGw3cU0v?=
 =?utf-8?B?UnR4a29nL0lxL2tiWWp2ZTIxRHFvazVTREpYZ0Y5a0tXckNhdUR6ekx0eWRz?=
 =?utf-8?B?MWE0c2ZlMWFqb3FMZFhnSmx4Skc5d3o5L010ZUJtTEk2QmVuUGs0eC9yVTFs?=
 =?utf-8?B?VzZjdWlpOWZ6bi81U3R2U1pNY2FwUVREQUI5Z09NL0dxUVVYRWtSQmszZWsv?=
 =?utf-8?B?TlhWN0dsbENXaStVQUNqbjN2STlJNXhWdWFTYXVHVDVyRDVuTytZZWIzaDVS?=
 =?utf-8?B?VEFVemtqc0RwU2sraXNCOG1RVXY0djJtK0xUQnhoNmJsb0xrQW5YM0hhV2Jz?=
 =?utf-8?B?MFV1RG1nYVk0UkVnUlhFaUoxdnk1Tkkya3p5SE5DSVczcHZFNVA3KzJxUEFH?=
 =?utf-8?B?aUY5UHhWUWdhNTJnVFE2ejJxOEN1TGo3TzhTaEJES1FjaitTWGxHWU1uaFNr?=
 =?utf-8?B?R0NzeUx3VGNCRHRCRlNvREgxOGdLUWVUNWhST0tHU3ZWbE5jTEttMGpCRENh?=
 =?utf-8?B?ODVXN3RieVM1a1l4MjZJVTJRdVNwNjUyQWxodkM2eDhNc1NYRGY0V3lMOVJG?=
 =?utf-8?B?NkN5SUR6OERFaGhWajZFQkxCUVVObW5Yc0prTTE3ZGhWODdwMWxYOFE3SzBF?=
 =?utf-8?B?TzVsR0tUZmlOaG0wM09FSE5SNy9XU2o1Z3hKZnRkRXI4T05JcEhmU25SeEtx?=
 =?utf-8?B?Q2FxUGpxSUYrYXhDdytWRmVMWkhkVUJwLzUweVBXejJlaGczQnR2eDlFbzdt?=
 =?utf-8?B?SStKSXp2dzkyRlBqZXh0RE90WDBpcVNVQ0plSExLNjRKQys0MGhSVnUveXhh?=
 =?utf-8?B?ZmpHTWEwTGM1aG4zZC84VVRvbkQxdnVQYkdBY05EblNQZVRoVlBSRmFoVWhw?=
 =?utf-8?B?UlU5UC9hVThpS2NMYjBPNklaWWI0SWlVaFM0WG4zWkdjeDFGOHg5MktsVllI?=
 =?utf-8?B?Ukx6RytTNFBkcHZCdndFaTV3Q3ZVdWtaZ2hoQy93OUNNNWpRbFZZbEJ2aFh4?=
 =?utf-8?B?M2syai9QdDlXWVNCcEltdlMwQ3BDdUtGb25NSHhBZGwwYjNSUHB0eWUzNEtX?=
 =?utf-8?B?d2Uwd3A0MnJDY0s4ZE1KVTZLdGlVZC9HVU9kZEJwTDlBZ3gzVXZST1pQRDZU?=
 =?utf-8?B?WjdRSktISitKTm1Xck5lK2FoUVMvUnNvalJrVGRpVEx3VnBuWG9jUEpBT2kr?=
 =?utf-8?B?OVEwZTBVT2l6YUhBaW96dkU1aWFzY2t5V0FwL2wvVXdnNmplckY3eElablVj?=
 =?utf-8?B?S0hTTE5rQ2Z0QXV6ZUp5TVJZK05yL2ZXZWhSeStta1dDZ25qNEpTa3pqQzFJ?=
 =?utf-8?Q?15pM4dIYPDybPrFm6jF3CS/n/hsffsNAaWYrMwGkik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54C4EBC92D935D4898FE7AA022A54E71@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NDhMVy80bUNpdE5JMjJKTk5BZFFBVmM2bVRrODBzSXUzOFZaZlA3UmxERjdH?=
 =?utf-8?B?TDJwcjB0ZC9Gd2Uxd3lrSHQvbzZTMGdBMWdGZGxMai9RM1ZsUUN2Mzc0STdT?=
 =?utf-8?B?bFdZMjI5aXZLV3JtY2liWUQwN1hBTmVUN2JkTTgrMHBlRWZNbDdwU09FdVNQ?=
 =?utf-8?B?WW5HbklnY01oOCszN21HME91WnBqZFg4VzZPS2M2eTZRVUNNU0EvTmljNEpS?=
 =?utf-8?B?c0lrejdZbXh5MW43THB2YUlZUFM1R1BOUkdDQmxrNmhSY3JtOXlDL0g1R0Vk?=
 =?utf-8?B?eGFYNi9kNUNxaHphRGc5dElQd0lKOHJUalZCZldTRDlKYkxVKzZlelpaTG0r?=
 =?utf-8?B?WUU2OEdjZXl3Z1JCME1FSGRYOXhPS25yRXpabk14OGdWMjV2RXU1RkRKMlZI?=
 =?utf-8?B?UG5RSWwwT1BKNkczSmdsN0d3SDJqUUtpcFc2aTVMUnZidXNabmFSWlM0bzEy?=
 =?utf-8?B?YnFmOUFEZGI1UHJUMjRVU0pQMEZiRWZCMGxNYmxlVWpRU2JqU3RVaU1FRDJh?=
 =?utf-8?B?L3BadmJadTVOODVXRFNtd05KQmF4UWJkVHRqSStEbWFKaWhJbjV2L3VSYjJ2?=
 =?utf-8?B?Z2NKWjFvOTF1WG5Qc0t3aEMvWGVRVCtrN1BOUnFMMUxXWjZFS0crbHBTS0s0?=
 =?utf-8?B?YmhwSkZDL0JscEd3ekQ3UjlpMk51MXdyL0I3WTNsWVV5U3VaZTdPQlNwM28z?=
 =?utf-8?B?ZXNSK0RmRjJYL0pza21OamN0OXE0K2ZzaTRBY0xoNWxZWkxiemh1UFJ5MTVz?=
 =?utf-8?B?ZGtxZG1DWitpSFJOUkZ6SGxpVmIyZ0J6aVVmUVp0NlcvaUFHT3lkdEt5VnRw?=
 =?utf-8?B?UWtuWWhkbTRwSGZwRGpCUDJVV3UxWStaWTRQcjlsRU5zdUxEd0VsZmg2SG40?=
 =?utf-8?B?eGR2WXFJMmhMWEpFeVoxTU5YRkVoN1FyNk1aVFp4RHkrZ1VzbVg4R3BRTmZq?=
 =?utf-8?B?MGcxbW1lN3RDOCtleWJCK0puVDVzRHRGU1R5UTNWSWZhZ0YxMm0rUUVHZTVq?=
 =?utf-8?B?N05WZkVDRGYxRjhWUk9FOThveGR6TU1ScDRIUlkxVXN6cnhHdXRNVVBxSU1k?=
 =?utf-8?B?QWhzVjFHYkpiTlNRN3huMUhmbFZUckd1TEs2L3RLWWJxOVRLUzg0TWhjVENr?=
 =?utf-8?B?aUFMTVNwR0R0MEdPODRleWVCVjhMQXN1RmpXRjlyN1E5ZVVnSFVVeFpVQU9y?=
 =?utf-8?B?ZCs5R3pnMXFhYXBjV1JKNWV5bDlRdDlBTEJQcnQrV1ZsVjJBWXozWnphZjNn?=
 =?utf-8?Q?AXU3VkgUCEyOiC/?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169c576d-e2b7-4699-7cca-08dafd5acfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 15:59:29.9393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qP5gYbpOGAIfAllV18tKsmSHiTojf2hZaLmyeW6FahxYCYW17Iy3iGs8Qwhu+8fNLNJFEAvfUUxBfRdCZ/Ss7tQFxjPwbpqMeIK3/RWzQbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5647
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjEuMDEuMjMgMDc6NTAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUbyBwcmVwYXJl
IGZvciBwZW5kaW5nIGNoYW5nZXMgZHJvcCB0aGUgb3B0aW1pemF0aW9uIHRvIG9ubHkgbG9vayB1
cA0KPiBjc3VtcyBvbmNlIHBlciBiaW8gdGhhdCBpcyBzdWJtaXR0ZWQgZnJvbSB0aGUgaW9tYXAg
bGF5ZXIuICBJbiB0aGUNCj4gc2hvcnQgcnVuIHRoaXMgZG9lcyBjYXVzZSBhZGRpdGlvbmFsIGxv
b2t1cHMgZm9yIGZyYWdtZW50ZWQgZGlyZWN0DQo+IHJlYWRzLCBidXQgbGF0ZXIgaW4gdGhlIHNl
cmllcywgdGhlIGJpbyBiYXNlZCBsb29rdXAgd2lsbCBiZSB1c2VkIG9uDQo+IHRoZSBlbnRpcmUg
YmlvIHN1Ym1pdHRlZCBmcm9tIGlvbWFwLCByZXN0b3JpbmcgdGhlIG9sZCBiZWhhdmlvcg0KPiBp
biBjb21tb24gY29kZS4NCg0KSSB3YXMgd29uZGVyaW5nIGhvdyB0aGF0IHdvdWxkIGltcGFjdCBw
ZXJmb3JtYW5jZSwgd2hlbiB3ZSBkbyBhIGNzdW0NCnRyZWUgbG9va3VwIG9uIGV2ZXJ5IERJTyBy
ZWFkIHVudGlsIEkgcmVhbGl6ZWQgeW91IGFscmVhZHkgYWNjb3VudGVkDQpmb3IgdGhhdCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UuDQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=
