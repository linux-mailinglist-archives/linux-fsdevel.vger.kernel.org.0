Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07539690488
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 11:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBIKWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBIKWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:22:38 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8113D69
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 02:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675938155; x=1707474155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s/aANtn8M1MRwMxWmJrzWCK8teLJJSshpJqiog73p/U=;
  b=mKFXhgwA0PCllvBhdpphW9jsQmJdTLaQFkps1cCHyCMIadBwbGswbsYk
   RSCMELZhgd3FuCkGlwdU33qEYOPflyn+NxTKNtTNFYGxirrUnlYbSlO+R
   pypPNby7huEGcMJvvQSy3MulHUevUFCso/YxfqT/0i79D7iDL9UP6DrG1
   oWXRpFpO8JE3nW9Splz73ZjX4gQLpm53U/OYv2w5Lf2bdv2VrbdULqRnK
   qC5wisz1zAGwebjYgR4xWNs3AGBhy7pd7IYTNdXXeukcJGrK9lMYRnt4g
   NRhryd9smw94y52bzJqrsg1uSWw2vX1069xZnRl7NmFle5OtBYZJMJeNO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,283,1669046400"; 
   d="scan'208";a="222696693"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2023 18:22:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOlT3oFuTych30YebPk/8EUs5WIUiyjAj7qH/ehT15I5aAhkqwTR1quPiEFBC7ywjur6bcP1Tw/tJM6EqAnqr01TNuuEoFQCTecI3W+LI3JfXE8bORSLdH/e1ynAVnGBqCe3gZlwrgS4QwgFuWLVedflRUbO2rB5QlecarlKGG7/JHsg6K65mFXq5ECcoU2mY3tAQ0sBmURjVA55aZPfr/SYesn1lUy8h8p6lzO6DXb+95D1peWyYOWySaPkcgvrVdgEcO36wcHmQxZlXHV20WWOeTd1/x7dtWzR/5RO0yO1h8lDvPXpqC3UgMKqE7thrZqdmO9ph/WfnWb+0QRq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/aANtn8M1MRwMxWmJrzWCK8teLJJSshpJqiog73p/U=;
 b=nsxficVMdPu976QOJwK3dygdmEW7Vc7ijal/kS1XuKlwzhrTl9C/rW5cta63mcHpmKjsJO0eX5yfSPR4EY5bbyFV/hzHSKG6+vTV+mRhQbX9uz32VDYPWWLwak5pc0YjCVWE1pjcw0pQWMwaLFyerKoPrhE+somuE1RYksAZ0qZyRRHytsejvVSkSiDSU/xZeUD6zrZDRJfwNGb4LcF5R+gjUbEgjunlIyAU5fC5SPXkm1CebGv8t3InUUsQAvJ5qIwLg3gNsS4uswcibYMTTqqCV1NXrRxINihR5l5K000VjHVDpLFJbFlMzwvMiMls87Mf7db0fR1gI/gHnOi1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/aANtn8M1MRwMxWmJrzWCK8teLJJSshpJqiog73p/U=;
 b=m9ysjHoBz10VWRAaq19NdYgiQKo7UOP900rRC+sPQkOPnMTBULKrLy+l8UfJqOfaE4QArpZ805jtU2xHcFDQBwE5Vn+3OySMc5XtNEsR5P29XY+SyxQwfngRa0LfGGiB3eWXJlDUNFGfF++yW40kk7LaLSu6GKNm7026+qVvbqE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7996.namprd04.prod.outlook.com (2603:10b6:208:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 10:22:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 10:22:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hans Holmberg <hans@owltronix.com>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Topic: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Index: AQHZOjDDUZpAXLX4TUqlcfdOqdocu67F0woAgACUuQCAAASvAA==
Date:   Thu, 9 Feb 2023 10:22:31 +0000
Message-ID: <61a40b61-2346-053d-1190-907075e1c9d2@wdc.com>
References: <CGME20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b@uscas1p2.samsung.com>
 <20230206134148.GD6704@gsv> <20230208171321.GA408056@bgt-140510-bm01>
 <CANr-nt0wVphKW1LXhmw3CgtJ5qRKYWkTy=Xg9Ey-39OnwvxnHA@mail.gmail.com>
In-Reply-To: <CANr-nt0wVphKW1LXhmw3CgtJ5qRKYWkTy=Xg9Ey-39OnwvxnHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7996:EE_
x-ms-office365-filtering-correlation-id: cae5921d-6c17-43cc-7b1c-08db0a878d8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYMSYB3Ao8GTq7AOuwtZPMpnOVC5a7uGDYdFUhzPpK/69hDhWtVD85zA33+ycVsCbK/UoIW4fQDjCaldhZfAG5ebefwQBaq+CShw+VllNnIRMSWKZDnQsozXWAgTKhJFe6f7AOyE437wOsqwssNA71tSCdURWse2nHetIVyrIVkM+0RGVUfROmapxayJ7KXVjpIj48IFA6RkQ6TDEC938HSaKLUVWHz03fnfz1JKjj+JUTjK6giHE3V3MvNNQ3bYfI815y7pgQLPxiTtg53wmvhQaI4/a9bp5FfjdyVA7g4BivJ0jMIP+ImpFZzAS/hH9BO9awvvYTHqV6kNZsb2pRTFhp55D0/d8tHYPht2QVXJ4vaa8bGGlgq3dmN0WIa0k7iGXrMGp3GFPgc0gjbmOxegmAMYpv2pQ1+hRcvVohSn5nyoeFPeVHurK0hkjRQMajWL9077HoffTyAnwwKKCllRjsvr/6tffFdMhvyF8MaL2aaH1+OlbFbg3LIhYOmhhoAtd/qBnYWfAC9pqcUpcfIuzz8PLlk6vpd6yDKH2OdWdOHjqaxmeHzX4gYy0pWHBcw7lrCVakNGDnUfLmLUXtuiSyytAErb63ShcdFNmJOcY0QJ2K2TTVL028n5DTNJef5UGpQwRkZ2EGeQff3kP9YvaedyJ4+tHfrZ5tGdynShYJCj7hcMd6KCanrCPuJ0DoJ+1nGBx7xEtmKns9efyWacVGaOEdv+4Un45cxz9Rc0yLJK+z/tXxcvXhM5NfW18TGLcwNfS9+KY4ZP28s3Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(6512007)(53546011)(6506007)(83380400001)(38070700005)(186003)(2906002)(82960400001)(36756003)(7416002)(31686004)(6486002)(478600001)(8936002)(41300700001)(2616005)(71200400001)(5660300002)(66446008)(64756008)(8676002)(66946007)(4326008)(66476007)(91956017)(76116006)(122000001)(66556008)(86362001)(110136005)(54906003)(316002)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0V5Rkh0NkxzMXRJck9QMXIvYjJJVVpTQTl6dlhvQ3hOb3A2V2ZuSUhXT0ZU?=
 =?utf-8?B?SjZPelRrelZYL3ZmazBpVjlUOTc0VkNzTkNWSEhoWmdQVEtBSkdGelE5dExH?=
 =?utf-8?B?VnNJUGExWUFPSFpWQ0RMcXJwRVN5VG1vT3JKL29zNGdwMXY2MmNIck40bEJ2?=
 =?utf-8?B?Wkk4RXAxQWszMlZ2R3RSY3hadjVHTGhKSVF5VnVqSkFyZjAwcUJJREduSDVx?=
 =?utf-8?B?NWJUWlQzVm95OFphdzUyaFdnUEVXVStyMzk1T2N1L2VmSmRIRm8zWG1GTEZ6?=
 =?utf-8?B?VGxpTk5ZUjJRc0VZN21WaER1Rll2YVVqbnRjd2Q0NkJocS9QbUpVam1KN2k4?=
 =?utf-8?B?dW50cXVqRjUxVEZVTEZ4cTFYQllxcVBkZGV5aWJFNnV0UDJNZExaM21EWm9P?=
 =?utf-8?B?WlZ2MjkzVW9PL1JETjk1OEUwN1gxUUdxTjlnOERIUndNelZzTlNZUzZlRC90?=
 =?utf-8?B?YXNGRm1GRjFkWDMyRFFsSTFYejBmNEJjWUswMVRJNDh3RTdQdlRSWmtUMnZZ?=
 =?utf-8?B?VEZRMmRTRThFd3ZEZjdEeXM0dTI2ZCtnL3pYSm82RkRnK0NHaExEVzR1OGtD?=
 =?utf-8?B?dlAvN0djV0JDY2k0VnFxdHRGUU9iVExIOGJjeWNVSjg4SEpmOWRuYnJEUzZj?=
 =?utf-8?B?QUNFazZpbDI4cDc5VHduUG0ybElKVlZ6WGdNQWdWWjl6bEhwczdZYXdEQkhV?=
 =?utf-8?B?U2dndk5rNmdidjNFRDB2Qi9iaWxyMit6UG5YTGxwWUVzQWw0RzZkQ05mcU1j?=
 =?utf-8?B?YzJGZThaOGhocVpIUU9wQU95dm1HTU1JS2VwN1U5bDY0U0RjVnNTdFBVVW5W?=
 =?utf-8?B?TWw3eWFWSXRWNHBJWHhUWUdXWVBNVExQZGNqZW15Zy9QSXVXalpZQzVpYzFt?=
 =?utf-8?B?aEF5MHhKZzNjSUNQMThqZms2ZUdQVXM3RFp4MFcwNjJnQU9ORis3Z1hpTWla?=
 =?utf-8?B?YmxPQmJ3Zk9aTm81MExScUZRTFVxcThEcWxVdHcyZkREMTNUQVdhdXFjNlp1?=
 =?utf-8?B?WmdVQWFOdjVLeHlHSTNWVDF6bVEzVS9PaGNZVmNRdnlIMWsrMjNKZnpjM0pY?=
 =?utf-8?B?SjJSVHRQbXBvZFZPRUkva3F4eU1CR2hLWXIxOHVJU3l1QWNFWmdDbkZucmtp?=
 =?utf-8?B?NnFnVUFLR0ZGeEYrVGFMQmZWVUFEbGcycGtsTmptUHlsMEZRaHlvVWd0RmpB?=
 =?utf-8?B?Ui9HVHBIbExneFdtV21aV3o4RGdTSFJtOURxOTcyR0hkMnBkaHYyVGxaQ3dO?=
 =?utf-8?B?Q2VUTjdETHRIWFg5bkkxNUtrbUY5N1RyM3dBTUE2OEVVcHB5TUo3djYyZWRQ?=
 =?utf-8?B?MVJvbFdxTVZiWG82elA3VEU3U04zNXZrR0ZFWmdQK2Z6bXFpbHVuT0Fmc0Vh?=
 =?utf-8?B?Tjhzejg1SDN5WTNVdnpOcGFGV0hTM3BqSXh3VWloaExMcEdoMlpwb0RYaVpW?=
 =?utf-8?B?UzV0aGJaZ0xhRDFUdkFZK2RQQStHMFJiTjNQYlZWU3ZLRkFIZUQwaG9zbkpI?=
 =?utf-8?B?dUFJdTRwclU1Ti9jQ1JsRGdoSUEwWU1KNHlWNzZrRUJYUjFHaEx5TW5Yc0lX?=
 =?utf-8?B?eTkvdHZXdXV5TnJ3MEZUa0xLVWtVenZheEloL3FtT0pEdjRXblFoaFFEbDRj?=
 =?utf-8?B?Y1lFcUIxdzhiTGJvdjV0Ly8xMTd4Y3VVVlZHSFBCei8vWjNhblZETXpEa2dh?=
 =?utf-8?B?VTZRaTdQWnI2WFBIZFRXTWhEL05pNUo3NFlId21PRCtOZXB5b1hTOE9zc0gy?=
 =?utf-8?B?cmNuNXZmbGF6QURzNGU3andjNXRFVW1PSCt0SmpWaDZiY1ZKNUppR3BxL0Qy?=
 =?utf-8?B?TXlmWlByZEVkY1BnbWFpYnFxNFRvSDViM3hBMEdqRGkrcjY2a3ljRkNsQ2t2?=
 =?utf-8?B?Qm9NVklML0hmdVE1TUc4eVJuYXczdTJNbkRFUy9ML3V4M2QxMkkwaERRYldP?=
 =?utf-8?B?V2hVeWNJMWdRUlljeGd3dG9TVUQzWE1RQkVuRU1MSldhcGYrNnNMSVpzK1Az?=
 =?utf-8?B?RGF1b3E5NEpGSzIraFhPWE5BSVVrblZHczB6NUZ6OEwvK3hudkFmazhhNWp3?=
 =?utf-8?B?TzhReTFSUW4rdzllSXQ4bUhJcXllMkx5cDRwQUIzT0U4d2c5VmtGOWptVVBX?=
 =?utf-8?B?SmxLRFVrYml3VVQ5YjBQTDFYbkl3a2tNUFNHNjZvVDhlYWxBbDZDK0VlMlAz?=
 =?utf-8?B?c2FRaDFiemtsWDRQWWxOTXBTQzJMRitwN0FyeFMwVEZiQ1Z4ZmhPVzc1dVRn?=
 =?utf-8?Q?mEP8A/2n/+V1Ty9OiZZzLNMBxBvLHY+qYLlxsqK2ww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43271624F69DD5409B1285FB3CD3C09E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QmlrQ1B0MkpiMEFSeFFxWWNuT3B5ZnhUT01pQWhrelR5WU1GZFhhZUhNd1Rw?=
 =?utf-8?B?clFGa3lReEtITXJlc0EzUlFCTm5pNWtZSFpNS0p6YTM1cEdpenYzZzZJQXpJ?=
 =?utf-8?B?WEp5WWx4SHNYU0VSWHVnLzBVTE5nSWNKdU52aVp2TGRvSERmd3hOdnN5V1k2?=
 =?utf-8?B?eGhSdXV0YmdUZGJna3h0NC85eXl4NEZZa2RyeXM5TkpIRmpEUkVaRE5EMktv?=
 =?utf-8?B?N05FMWZ5TEF2bkNZUFFoajU0aFhUYVZoSU5YamFLTGRIWmhuV0RUZEhUQVZu?=
 =?utf-8?B?ZlYxVitNcWY5RWxUTUdZRWFYNFU2Y21YamVvWjdIdHRwd2FrZjVVZmx4c2FP?=
 =?utf-8?B?alBJQTA4eDJmaHZwcG5iWXpZN2Y4Q2Q1WEpsbFNMa2lNS0VGMHBjNC9yZmpa?=
 =?utf-8?B?YWZJdW9qSW5tWkc5MlAvcG1ObW5qK29OTmZ5TDl0ZlJWaW1SRTV1cWVqeW1w?=
 =?utf-8?B?d1k3eEdiR1ZQdWErM0ZKV3lrRlArUDdnNUNYUU9od2RSaGVubGNmSXIrM3NV?=
 =?utf-8?B?WFZuM3FJKzA3MUhtVmJVU3lVMS9YWGVWZFJqMWVuK1Y5c2NqZ2VKUlQ4MlNj?=
 =?utf-8?B?WVl3amhXRldEQk1mZTlSUS9OeXVFYnphVGZQUjNYdExVeEJUclRJZ2RnMXJF?=
 =?utf-8?B?RnpuWjlCbTNVcXk3dDZhVDdNdjdVS2xxZ2JiL0twTU9yZUF1MEFHNWVkQmNs?=
 =?utf-8?B?ejdaY2RSZElMVDdDWDF4cGdUSzdudlN6TFRla290VzliajZPWURrd3ZRQjcr?=
 =?utf-8?B?VTRjaXJGaGJuZGhibkVDL3BmMkZzMTNXRS90NFR2VE9LMzJPNzJEV2ZLK2Iw?=
 =?utf-8?B?VXBKNDlMOUhpazJEc2NKYlgxN1VpS3diVzVHVHVXdExyVURqc0crYnpLTzdu?=
 =?utf-8?B?YlBsd0pkazhUYzUwUCtLZVQxbC9iVjY4TUhwWHpmMy9UNDFSVHRmR0REaGZW?=
 =?utf-8?B?SlNuNkhGU05KOWN4WUFacTBrU1lTb3ZzS1AxZ1lvWlJMTU5WNTJ4aXNpaTB1?=
 =?utf-8?B?azZEejhJWGhDTGJWY3FqZGdoQVVxeUEwSWJDYldwdmdRZ2o0c0UrK0RqdHhz?=
 =?utf-8?B?WGdJRWVTa2V3YSs2L0JyL0ZuQTFCQ1FRNS81YnlwdFUyOVMxQVVwRnlTZkV1?=
 =?utf-8?B?NmVmaFk5K3BFNkJ2M3A3S09LdDByeUZGdEMrWGllcHlML1JMZVk4VER6UlNj?=
 =?utf-8?B?MElYVWEwVmEveitQZ1RJY25jamY3MDNjY3Z5OWdXN2VqdlVNV3pGczk4L1Bs?=
 =?utf-8?B?N1JuUDJMaUhEbzN4aFdhaHdtMkxSbkhZMjA5aXQ5SHQvUGUzMitKMm51c2Ux?=
 =?utf-8?Q?KhPte3AQlw2j/0TWJI+PQkEzUNdr/rppW9?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae5921d-6c17-43cc-7b1c-08db0a878d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 10:22:31.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UY/yEZ+3KTJ+wy7zLfkNUkoDXHjItNPPgtd2wRGt3efa3O8dvSY0IAyHfJbk4+q0uKfh/a3NnJcRNlAv10msLD1m9ORqI18urYvCLykC/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7996
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDkuMDIuMjMgMTE6MDYsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+IEl0IHRha2VzIGEgc2ln
bmlmaWNhbnQgYW1vdW50IG9mIHRpbWUgYW5kIHRyb3VibGUgdG8gYnVpbGQsIHJ1biBhbmQgdW5k
ZXJzdGFuZA0KPiBiZW5jaG1hcmtzIGZvciB0aGVzZSBhcHBsaWNhdGlvbnMuIE1vZGVsaW5nIHRo
ZSB3b3JrbG9hZHMgdXNpbmcgZmlvDQo+IG1pbmltaXplcyB0aGUgc2V0LXVwIHdvcmsgYW5kIHdv
dWxkIGVuYWJsZSBtb3JlIGRldmVsb3BlcnMgdG8gYWN0dWFsbHkNCj4gcnVuIHRoZXNlIHRoaW5n
cy4gVGhlIHdvcmtsb2FkIGRlZmluaXRpb25zIGNvdWxkIGFsc28gaGVscCBkZXZlbG9wZXJzDQo+
IHVuZGVyc3RhbmRpbmcgd2hhdCBzb3J0IG9mIElPIHRoYXQgdGhlc2UgdXNlIGNhc2VzIGdlbmVy
YXRlLg0KDQpUcnVlLCBidXQgSSB0aGluayBBZGFtIGhhcyBhIHBvaW50IGhlcmUuIElJUkMgbW10
ZXN0cyBjb21lcyB3aXRoIHNvbWUgc2NyaXB0cw0KdG8gZG93bmxvYWQsIGJ1aWxkIGFuZCBydW4g
dGhlIGRlc2lyZWQgYXBwbGljYXRpb25zIGFuZCB0aGVuIGRvIHRoZSBtYXRocy4NCg0KSW4gdGhp
cyBkYXkgYW5kIGFnZSBwZW9wbGUgd291bGQgcHJvYmFibHkgd2FudCB0byB1c2UgYSBjb250YWlu
ZXIgd2l0aCB0aGUNCmFwcGxpY2F0aW9uIGluc2lkZSBhbmQgc29tZSBhdXRvbWF0aW9uIGFyb3Vu
ZCBpdCB0byBydW4gdGhlIGJlbmNobWFyayBhbmQgDQpwcmVzZW50IHRoZSByZXN1bHRzLg0KDQpE
b24ndCBnZXQgbWUgd3JvbmcuIFNpbXBsZSBmaW8gc25pcHBldHMgYXJlIGRlZmluaXRpdmVseSB3
aGF0IEkgd291bGQgcHJlZmVyDQphcyB3ZWxsLCBidXQgY3JlYXRpbmcgdGhlc2UgZG9lcyByZXF1
aXJlIGEgbG90IG9mIGluc2lnaHQgaW50byB0aGUgaW5uZXINCndvcmtpbmdzIG9mIGEgZGVzaXJl
ZCB1c2VyLXNwYWNlIHdvcmtsb2FkLiBPZiBjYXVzZSBvbmNlIHRoYXQgaXMgYWNoaWV2ZWQgd2UN
CmNhbiBlYXNpbHkgYWRkIHRoaXMgd29ya2xvYWQgdG8gZnNwZXJmIGFuZCBoYXZlIHNvbWUgc29y
dCBvZiBDSSB0ZXN0aW5nIGZvcg0KaXQgdG8gbWFrZSBzdXJlIHdlIGRvbid0IHJlZ3Jlc3MgaGVy
ZS4NCg==
