Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE390666F09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 11:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbjALKES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 05:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjALKCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:02:19 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C36F7A;
        Thu, 12 Jan 2023 02:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673517668; x=1705053668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=l5sadyh0+46i62WI2ftIzDzmErNzP8fJ7Yu+6t7tlbKpeRhN02J2VJTR
   jsUv5olzhPJm9quwT4KCOlgHqSkU9UpfRSVg0FsGXl0RNGi06YgQzrNvw
   MsFMAGQq/DH2fbG048nx6HFfKvIBjWEy+nyfVNEL8VlX+QJa4EIlkjsco
   7+5VkyNyAnfJE/mRo9E7T37d51qojVSPbYc1PIFe69qUjXjfU0VrWGvoX
   2jc6s59tqvufoKIf5U8XQQhZ3MMkUInu5VPcIBfinyoqYUEq970lHWFJ+
   NSEgNouFS2cMp1yoRrKs5czkuCmhw50yWS/Wq/PN9xSLxlcYcncccV4OK
   A==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665417600"; 
   d="scan'208";a="324914091"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 18:01:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ5XLfnXryhj6KuRmQZK+YWpjf51l/iI54Y+IjAkZ/5c48pd4GXnd2YBVSg9FBVTSsE0X9KccU0BCgfTlD4sqowJ3LkEhKPJInYze3Eloyu9f0yK3Nd92/LmHMI4hZUl31L/zPKmAsF92Ur049UyFaFh/1AYfqjBigkG6bGO/TyfkF9qeY5L9CMW8l81bqDv3ivXEcMUCT6RzCoqURkS8lx7O8RA0CHjBKC5+dTi6DVOT1R9OZvpmez2aLi61opG/6nWqclXcQbD9HF8NCFSCbhpF/uLNua6glHoiI9Fb2Z8O8aU6zq3br5459AK9V/xWGSo7dZBJA9VzZWjn1DN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BDy2QrS+cABafGwbkNjs4rOLsj2cmFHHS7LSIIcry/hj5+k7vhsl8TWNKL2EcEO/OJBuQ3ICpwdPudALJtwpFQdw+I+2zNk2KwVPZs8XmuGiTHM/nbAqQEg5a2mcxOu9M3CemZZpMfg+u+56owz33BAkNZT1N2WXh5mLX9fMcBFHBn8a22CtOcTDR+rAN67MPIqeC6aKY/76DWhi0jyyGmwKEuwdwwhTbNMpvh0nPMp/eB9T9v0vGaSN4yKw2EXIrluICVkUdCm68otlXrV6NkLUwOU4kYKMhiejDUCej3Apdk55v5mvZAQtnhpuawPcmodDnjnDaYSWxJ29/iSyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=kDEXZ2J5UBdBYAHwapEHV1UkO+dGyrppd1YOlTJQrtPMIUmPl7t3mc2DTID2gJ133mgnoATHkR7HG7gty4Z9LaSA3f/X3OYvefyg39C8B7aAqlo22Fj/HOssAI4mAn0HrfbgiTD+ApGxaacvNhMIvMhXEm0KjbNUIM5rB1xk7U8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0832.namprd04.prod.outlook.com (2603:10b6:300:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:01:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 10:01:04 +0000
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
Subject: Re: [PATCH 11/19] btrfs: remove stripe boundary calculation for
 compressed I/O
Thread-Topic: [PATCH 11/19] btrfs: remove stripe boundary calculation for
 compressed I/O
Thread-Index: AQHZJmUn4pYMeLi5zkONgRgqq50WrK6ajMSA
Date:   Thu, 12 Jan 2023 10:01:04 +0000
Message-ID: <196f7dc0-f10f-5711-fc26-eb4fe5d30eda@wdc.com>
References: <20230112090532.1212225-1-hch@lst.de>
 <20230112090532.1212225-12-hch@lst.de>
In-Reply-To: <20230112090532.1212225-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0832:EE_
x-ms-office365-filtering-correlation-id: e792396a-5288-4186-e9a1-08daf483eac6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nn5S0cDJjuHZjWxNsPrIgt321acvpbxCzzAILg6TvkvWoxLS9BYFS++OITjnrueql0wMnGEssByFKFKOw7K6YEVHvrAc8gmM8rqgPW5v8BJxb91Qiag2B7NPLDfEaBpFjjSqAIbgmbNF3DL5Lw83tz4V2YURvUOPaxhep6h9hr6rCEnpgOH9deRrjd2sOU78AGtaTQXC9DT8kQ2vNdsZgqm2T4Rg4C0pdbTkDSVNbISZC1mZF2+VUDqaHDIenPpLMnoX3mrjGsSw6WRCVTuA4H/eb9hWU0jHYvkj4fEo9OHvyhwIX1OLEjb1YsY8afPvwm/wuEh0R1rlVEqWQ58ZC4sykzSgPHUmLf0piywkOG2lr72uDdpj5C/TFnT2iyVpxKwagUBWfrbB6VBEK/sG+kY2jfieMc20+GutXoc+njbpZAA6VsSuQC+F9mP0xnh2SkGKPmuVTTf5dsOZUJ0T8GOS99wwMUShF5395/H8rF2OEH4ICgSYpCkF2GY0MguIUnRow67nQ750WEonYNBfz+B/7tVDtK6ZKDPuq9GLP7gT3ncOX6fMMJ5YZW3UvKnaxCuGGhX9UNa1/7Y3+VTlvJP2rBHQog7rMnvs38hbGLJAC1jDbT0pYde5bSTfLB3L1P2zwGTFCQhCcG5Xw6kQD2fyiy3CBpa4FdxLExp8s8mG/8nSt6LPkl7k3YyzlqNYiEvDL3JDu+hBAzKs61h5iEIBZeVHlQN0Od6LQbOzhODn4JsW12siyEoPJgt6oyWnMJ+XRzLAmIAO8zsjEeJm/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(19618925003)(8936002)(5660300002)(2906002)(71200400001)(41300700001)(7416002)(66446008)(66556008)(4326008)(316002)(91956017)(8676002)(76116006)(64756008)(66946007)(66476007)(110136005)(54906003)(38070700005)(6512007)(122000001)(38100700002)(2616005)(31686004)(86362001)(4270600006)(186003)(31696002)(36756003)(558084003)(6506007)(82960400001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlWZS9sQXVmNTRtbC95NjlZN0FTQTFhRTlpMWNBdkMwYkZ2QWEyZ3MwZ3RG?=
 =?utf-8?B?ZkpiUHloSzdmVWNLb2dmVTNhQmw1MmVIVElHY2NXWWlNUnJ5Mk93UjhQS0lw?=
 =?utf-8?B?YU1CVEkyVXZWc1dHLzZXU2hkVThDVVFhUGVMdjJiY2dWT0k0b1o0cnU1VFha?=
 =?utf-8?B?a0NucG1zWFkrNTlUS3I0TGhDbGhMNml1L2ZNNHkwNnkveVRxYlFadDZ0d1BL?=
 =?utf-8?B?QWYxRFVmbWM0R1VpZUF2TGFQTXoxN1NZWHAra2wyRDd5bEV4Ym1wQ2h4R1Q2?=
 =?utf-8?B?aWlRMnVUd1pXMEN5dm4reG5pZm5tU2g1bTFXRzExRW8yK0ZpMTJEU01oZWxP?=
 =?utf-8?B?UHRIUzczbzk0c1VTVnpkcVhJY2hwem9VaTI0SDJjcTdzUUNWVmI2aUFJV2Ir?=
 =?utf-8?B?TzV6WnVpbFYxNUFVWGtST0F5bXFZaHdGanh0N3VoTysvZDEyazNpNS9FcEZz?=
 =?utf-8?B?MmNramtyaitSYnEzQnhJck15VHpQSGVNbEpPQ2VuWUx0OURHY0xlMWsxQVo2?=
 =?utf-8?B?a0pGUGVOZTdLTTdPZHo1SW1lVGRMd0poRXFDSk9QM2hhZmR1WXpvYXcvNDUw?=
 =?utf-8?B?TDVoeTdOcnI0aHYxaFNXNlFuUmVYbFJCbEM5UHFrL2p3SEw4eTN6S0doZXVs?=
 =?utf-8?B?SlJaaDFTZ00rUTlhYjdSYU16dlJYUXBBWmlzYit4MWp4Uk92VkR6REErTmdP?=
 =?utf-8?B?YjJtaGRVcjc0dTNrY0tnVTZPZ1VDZjBCMXRGeTRiUkxKVTV6WithWFBkVG9Y?=
 =?utf-8?B?RkErSXhLR2gzNGZMSEVRZ0lKRzAxTStNUG5iUDRTR0VWNjZ3RWJwZE5CK2J5?=
 =?utf-8?B?Qkt4YmZkVVlxM1FZa3l3L0lEVENoVXF1NzFkOUJVS1RwVU5zWlg1cWdDK054?=
 =?utf-8?B?c3A2aVFHcVZjMS9WYjdLNGplT3Y1OUIvUWhmcS9IMmwrdDd5ZzA4QUJHWGFv?=
 =?utf-8?B?a1ZsRDB5eXMyaWdJTDcvQWx0ZGJGTjd4RHpad0NqYTZFakg1NnFDaWZjdnNV?=
 =?utf-8?B?ZGdoNWxFd0dGOXF2K3gvQWc5d0pLbHRGeUxwU3RBR2dMSTlSYm1pU3MrWkpQ?=
 =?utf-8?B?by9vSE15QzdOakw2YUx2aXlMcGtpNGpoWktJd3JqOWRaSGZxSzJHOXZsalJs?=
 =?utf-8?B?M3FkMW00bEFFSXJIWHdod1dCeGd5VExvTUd3VVV3bkxibjU1a0hBcUdIU0dY?=
 =?utf-8?B?TFVxZDk1dkEyYU1rWWJrZUZTMVBYUFhpWktXNGcxWVg0TUVzb2RLcEJoaG8v?=
 =?utf-8?B?bHJtdEM2akZXRGtNb0Zuc0F4VnRvdjBDRjE0blVUWHQwc3RpU2IwQ0w1ZmFS?=
 =?utf-8?B?emQ5NDFpL1R4eHFGSG5vMUo0c3V5VjdtRUhlMnN4bGN0bDdoSmRqbTR5R3hV?=
 =?utf-8?B?RkJ3dUFhRklXVXI4QlM2UVFxeVZiVEVRYnhLbzl3TlM3N3M1T0xUQW1RZmho?=
 =?utf-8?B?VlJQbWJwemwyaUd0SC9mNUVQUkVJcmpOcTdKamtWd0ZhbFYwTHNXM0JtNE4x?=
 =?utf-8?B?cmYyeXRxbmU1dThpUzJoZit1eUFNaUk5dTQ5eEMxUmpuVW1sbzhUM1VrRVlY?=
 =?utf-8?B?MTU4ZmRiQ1lEYXFoL0JxK2d1LzJNVXZMUkV0cjhUc0Y5eThORS9udWNROEFP?=
 =?utf-8?B?M2w0R0tLL0I4amluWTNldVZMS2l4bEgySkEyaldoZzNpcm5haHZiTkFqTVk3?=
 =?utf-8?B?Z3RrSUNEckkzdUxiSjJFbkdTWjRSL1NRWEFMNmY4RU00VUJwL2JJYUxOTE9w?=
 =?utf-8?B?c1IvQzh1Yjl0RjVMOWozaEk3d1RrTnRtbWhsT2d5QnNzUGkrSko0eHFKdWgy?=
 =?utf-8?B?ZTE4dHNqS0dLcjB6bmlTTUlZYytWMjhuZTNBbkhYMWEvTzNKbWRGQ2kxSEdl?=
 =?utf-8?B?NFBGTVAvOFEvNU1mWFRMUFQxbmRMRlZDclJ4cStOS21aL3ZmVDRoQXgwZHpM?=
 =?utf-8?B?QVhjWUJYMy90VEdRSTlTTUJ5c1RuUjFZMis5S0xpWjZJeEU2QnE5N1VwOHVo?=
 =?utf-8?B?NHZOd3BZTHQ4ZXJTM1lqdlR5d0NKRWU3NXoralBtbHU5YmVNUVYyZGlKekls?=
 =?utf-8?B?RXFsYUt4RWpEc2RaS1lyZ1JJZnpCbyt3Tlk2TkZEWXhpSVQyYWlVd2RNVzhS?=
 =?utf-8?B?ZVpDTFRPMVdrZWxpR1pXL01Fc0NFRHNzVVhMK04zOHAyZnpqS0E4R3BaRCtS?=
 =?utf-8?B?bUJ3R3pVSlkwWlRJL2h0ZE9zeGhGY1B1R1MzYzdUOS92bmJTOVlxY2plTS9S?=
 =?utf-8?Q?1Gu8eECh3eS+d58LhDosnT5PLQYGGpynKwIKBGXcSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52F0CF206F7E524FB56FCD1CDC3656AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WEJ1c2pBNXA4WnlmUzErU0toM3hhTUdZWUpDbkRBbjVYQlY2SHlJcWxCWTZo?=
 =?utf-8?B?WEFkMHJaUVBDMUZ3eWE4Yld3NUFrdFZrcU5tSmErODlrdlBSQnV3SHNhckVj?=
 =?utf-8?B?RHlqVlZac0hpQ3l1VzZSY2dQcjlyTmowVjRHVVpnd0xqZTZmVkk4WUYrai9M?=
 =?utf-8?B?elN4ckdmZGIxelIwQjZLYWd3bzBKTkVzc0Zhc05iQXRBVkI4aHZ3TDNYV3hV?=
 =?utf-8?B?eWRCNHh3anlyM2lGTnVjUnMzckdDUnE0VGJiSHdTRlZ0ZUtPdXJZQnoxYUJp?=
 =?utf-8?B?Q1c2VUFBekZnOXk4YXN6dy9kdjJzdHdnZWYyc2VucHpFR2ZETUNMUTNoeTFJ?=
 =?utf-8?B?dm9ETlA3TTcyTGsrK0xmR0FuVDB3Y2ZZVGxHR0hWSFJZMEF6dHBhSTRaTWJZ?=
 =?utf-8?B?aUp5cU9UenRtdWxWOCtpd3prdGpHWXhVdkJPK0RHMGV0ZGZHOG8xWGhnT0ZU?=
 =?utf-8?B?VXJSSTdxZlNXcFhxQ29TZzh1S3BLMlhEL1BVVmhmOXR4TTVKV3FZcExOclZM?=
 =?utf-8?B?RWk5M1RqVlI2alZtQXhhWGJzZ0huaUdGWHQzTG5DQ25abyswRXlhdkhQV1dx?=
 =?utf-8?B?emFjZXVORXU4RkRXTDBEZWlIQS8wd1l1UmRTMEVOZy83TnJPU0cvdHQ1QXJj?=
 =?utf-8?B?cDFmRFlKUzl4L1h5ckVxTmIrR0VwQnk1YUpnSmFGSThkc1hGak1KanA2YUJ3?=
 =?utf-8?B?OHdlK3JPMzA2cDFQd3NiVmlzZGtnTFNuMThkRFFYYTUzR01oS3VZcWJKNGhU?=
 =?utf-8?B?WS9zekp2WXpqclUzTjFLdUthYWxzWWM2c0hqa0c3eTh3TlNaY0hlWjIwMkcv?=
 =?utf-8?B?VUU2Y0tueWEzcXc5UExlWUc4SDNnYTIyRXVnN0JGRnJUd3Ziek5IOEVQMklX?=
 =?utf-8?B?UTBxczRJaWJqVUpSdk5JMjlUbm9NYi9zdFU2c0tabkdQZ2pVRml0UlU0K2Qy?=
 =?utf-8?B?SzVHRXhHeFEvMkF4TTRUTmphcnRtODFyVEhreGhVRlZxUXQ2TGp1K1BXMWEr?=
 =?utf-8?B?czF3dklnU3ZZRFFwUVZtTjRudFlBVWt6Vmt4QWpmSzVSSDJxWHd4aGI1Ni9J?=
 =?utf-8?B?V2xPbm1GTkFyNjg1RUdXSGxmM0ZXaENQdVNLQ1B1eU5DRUNqY3h3Z2tjejZk?=
 =?utf-8?B?b2JTaDN6aEE3TGNKeDNuU1BjQ0liTDB5YXB4UzB4L01UbW9GU0ZSQlk1ekVH?=
 =?utf-8?B?NkU1SThiNHpaMkNqVEtrM3JTaVpsblozMlUvMjlKSm5Gb3FWam1VQkEvVE5B?=
 =?utf-8?Q?H08wplEFI6mxgry?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e792396a-5288-4186-e9a1-08daf483eac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 10:01:04.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaNoqtavfVcU/FoB9geQXjGLrIHOG917ufeA8z38dKh1yI3Y0VdeTmH2J7SKct6Q+JAolgEBVgsAo27g4y+QDs2LpdWkLZxxPZ+xwi/zmzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0832
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
