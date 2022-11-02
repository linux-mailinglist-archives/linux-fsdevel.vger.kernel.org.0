Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3498615BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 06:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKBFYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 01:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKBFYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:24:42 -0400
X-Greylist: delayed 244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 22:24:41 PDT
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE5248EB
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667366681; x=1698902681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fgT8FxU3qdon5M6tRECA0lpBxIF8Vaf/ord8oohbvEc=;
  b=PBMp/7JT1NoCSExxv3ahdkcP9FWYc+mKO6oceJo2Vl0R4/sK1BsjaDGp
   WZXce4Klddd0SfxyiziQwDGBOWRziYJPqR08R8bpi6waFNts0vmnI9qn/
   wsoWe5jBezY2Uh5afPi+563WpUyV7KFYcVq4bnXwFnnOURzdoUCxuG8PT
   7IcnHpcR60+FCsrKXmhZC3AD7s/Fk0PzydPI2zEJKvVuweZC0x5eRhK71
   87Ct30yMGCAwrGi6hQ3GkfBbLLQB7cC77fu1eZYj3qg+ygdITuDiZ4wlc
   AzLvvjIzQhfTSo1ZzfLeRWGZtj6bfCi/1hEJ8K6v/kCQSscu2/a2HfKuE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="69067830"
X-IronPort-AV: E=Sophos;i="5.95,232,1661785200"; 
   d="scan'208";a="69067830"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:17:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZdNCknWKmeNifZRQ89h6qgntURvSgqXjQ2o1P57wIVbO9CdXnNCDQoleaWFvdkiki5CBKrjMyIT/i7rp0EnTVh528JrRjdcEjGu7bDzxjT6rg4jRJoobPm1tPdkwX3/w7/vIqrjcP09iF8hKlHrTuDkXMfJuhMqZwIJWviDiXdkkVgYTlQ2Qkx6GdggjKkF6cIE39KE6LSJwfEDAgP38DXFjBpYRQ6uvdgwwokk6ZiO5DolULVRm1m+noeaPzhcWz83PHPWySa8O6jExoOrSyVPROtvR3pIpO+/9yn/QXPmVjkJTfNqqxIh3RLinQfpG+90diAFUG4cmBwbtgdlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgT8FxU3qdon5M6tRECA0lpBxIF8Vaf/ord8oohbvEc=;
 b=PTJ8VtY3w86Rlo1vUPHiONQOIw4Yz+BDC4HZMCVr/Uxkds8H66Ok6zthiGLPHCf+q0bkjvxYr4qpmkxx5bu682scTPDXM7IirN1kayJyKof8plwzbYIlFp1G8DyAw/C3Cyff1pK02aMsshHDGcNni0pEzoQ126OmcA3l3L4uylhxklXmfRLMMGteHNBu2VZoS73ObD/p75lSCJc/hzHTCYXUGttWhpu7MKLtq5zaihHBuAJEf9OXHbMt6Wwa/Rww7KegI5ODj7Bc8Dg+Jomv7XZ1u2kb5ip+95Y6yDqxvehVfioPwVpEm7MbEqTwL1vRtyz8Np6Qp1y2K9CJeWk13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by TYCPR01MB9569.jpnprd01.prod.outlook.com (2603:1096:400:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:17:18 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::5fa2:ac9e:d081:37f1]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::5fa2:ac9e:d081:37f1%5]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:17:18 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Topic: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Index: AQHYfA4g5aj+ViA5o0mdS5cU960Zpq1oy6eAgCBSEICAACSLAIALwXoAgAASpQCAB7mIAIABcJ4AgDfaCgCAAYXbgIAHcj8AgAAwlgCAADFJAIAAQWgAgAEpzwCAAQljgIAGUv0AgA+aw4CABj0IgIAAQxUAgADul4CAGN++gIACWZ4AgALenACAAFidVoAAJVqAgAHUVwCAAI4xgIADWnYAgABLEYCAA6klgIAEI92AgABL3QA=
Date:   Wed, 2 Nov 2022 05:17:18 +0000
Message-ID: <384341d2-876d-2e61-d791-bad784d3add4@fujitsu.com>
References: <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia> <20221023220018.GX3600936@dread.disaster.area>
 <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20221024053109.GY3600936@dread.disaster.area>
 <dd00529c-d3ef-40e3-9dea-834c5203e3df@fujitsu.com>
 <Y1gjQ4wNZr3ve2+K@magnolia> <Y1rzZN0wgLcie47z@magnolia>
 <635b325d25889_6be129446@dwillia2-xfh.jf.intel.com.notmuch>
 <7a3aac47-1492-a3cc-c53a-53c908f4f857@fujitsu.com>
 <Y2G9k9/XJVQ7yiWN@magnolia>
In-Reply-To: <Y2G9k9/XJVQ7yiWN@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-02T05:17:17.976Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2920:EE_|TYCPR01MB9569:EE_
x-ms-office365-filtering-correlation-id: 8b2668cf-1e62-400b-63eb-08dabc918355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkTDq9DnegGsTpvN6sdIceynVazX8EpC5dwktVPB6fVqBg8mOEoi18LcnQjY4gpwlrvN/3m+7D+E9bN9hXAg/jizoY5Do0rP9Gz3g94qbK5Pxzz5i995anEfMYL+9x2pN0S/I9N4NQiRB0kaYK3c0ia9EYlqxw1o4i9+a9MFWvZmceUjlBeedlt1V0m5R0g4M1fyc4KFbM3Q4s9y0PLjqjqqV19tz8EIEzy8BA6dLCJZzAf23IKW1C3HEFLTBYkM2RSn7Q4R8upTFwew+OGJEowOQo8faVGB3b01QqM6iMXhnCPqVRZ0d9CQSkC9fclpe7LDSq2dpMduMU8e4lX4AhlFjR7oAQak5BUP4YjmNM6Xk5O16Iz32xpRg6+Aj1xEGl8LID5oCVFIfJKhCusADMnMe5DN+KSbVlTMPbpvrTq+qetUlsVCmun0b+oIc40xy+zFeMJK14sYjAs/KZoA4CnT3TCnfHCaTvV9E6F3vs+WhUH+LIr1ZEOX5sgvTuE3Ac9X4H/ooYldM7Abe0wxQh4PzEBbbIIsqnHwL38EG5vT8eXFDrkfSX42vwcp9fxiXV3pQg/MFL2BfeOBN3GHuED16OEYCsgBy4U57J2UzRTMZQro5SGwDcjeSdiwFWqu11Fz54T9+MrBfgN6ekeapPuErmVfYIivyYTXH7H2JTDtfugEDhhiCbT+uYF5R7+arymMQpgJ+0aC934EXj8s5lsO0FYkn6zGV4sBf39shmhMjg1HnOOhIV32lFavjBmjAvxw+bVbnx58egbnNrP5ur5bBYHHVWd4AGr0eLtY147WS9lM4dUxeaXGrdab/dmpckC/aeR0TBxdDSfPj0NxaOZdYGBzMLmfZesxQOyK9CU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(84040400005)(451199015)(1590799012)(31686004)(71200400001)(966005)(38070700005)(7416002)(1580799009)(5660300002)(31696002)(66899015)(6486002)(478600001)(8936002)(66946007)(54906003)(316002)(36756003)(66476007)(2906002)(110136005)(85182001)(76116006)(91956017)(66556008)(38100700002)(26005)(2616005)(6512007)(4326008)(8676002)(64756008)(86362001)(66446008)(6506007)(41300700001)(82960400001)(186003)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WFFSdXg3Q01nM2VudlFYT2pOVkt5cGpyTnZ5RzFyZWN0STQvRWdkcDZpakVO?=
 =?gb2312?B?b1NyUTRMUG1tNy9abi9kM1hmcitHTmg2VXZlL1RqRnk3M21xeXVqcUJSMkZr?=
 =?gb2312?B?WlJWcEdFY3dZQzJSTndmVEgwVVBNM04vb1pocXkvQWJjVXZuUHNPUmgralVQ?=
 =?gb2312?B?UGFUdDB4SGdmQkFWcDYrV1cvMWdab2tHeWV6OGplZ0E2bTM0RnZMUmgyNzZn?=
 =?gb2312?B?TllFMkpYcU5OcGZvamx1ZjMrNVB5SkVLeVp1M2VSUG9oUm5DTHpsaUtVU0RN?=
 =?gb2312?B?ZVNQZTBNU0hjY3h6TXhldHpHdC80Z0Y5bTIydWZYb2IyeUc5b1pVTytCQkR3?=
 =?gb2312?B?V0tBV2dOUk0rMUlWMUt2Y0kzVytZc0JQd2VXaU42RVM2bXA1M0lHTm5ockgy?=
 =?gb2312?B?bTFXNVdELzV0cDlYaVNMaDVaRVNDTnRyR3psQTRJaHNTdmZvUzY2bGJZMGRa?=
 =?gb2312?B?c0lCNjQ3RUJlUlE3OHlWVFM1RVF4QndPb0ZyQkFWdmxueFhuME9NQytubnhC?=
 =?gb2312?B?YVpzcTl3L3JCRFYxUjV3aDhDSGI3bW44UzRzOEZWVG5rcERFcTdDVURlQWJ4?=
 =?gb2312?B?WTk3SmxkbU96c284cm44a3hKc3lVbzBuNEI0WE9qbjhkbzBnZmRhMnpxZSs1?=
 =?gb2312?B?ZTAvZW8yWk15VlZwMjV2OU1BQkU4K3d0TDlxd0JkMWZVT0NIMFBxYTU1Wkc4?=
 =?gb2312?B?Rkl4Nm1WY0RlekNiaHZ1OXl6eDUrYkdobTY4Y2RVN0hQa0tUVTh0bEVTYTRD?=
 =?gb2312?B?OGNWMld4S0xBOFdMNHVUT2tvV1dqMzIvQi9nSUpwVDBlS1lrZXZOQm80NGxY?=
 =?gb2312?B?Q096QTZIT1lWVUtDamp6cDU1MSt2S0hOV0pBc0lrVTJRanlFY2gyRUFIWldj?=
 =?gb2312?B?TVFidlcwMGpqdTlHY1cwYmZZbFVoK1lhV2hRbTRHcmlHREx6WDJ2ZHFtRlFV?=
 =?gb2312?B?QUJJdzhQTXhxcUNpTXlwVGdHZDA5WVozbEhNeTU4S2ExdWl1TU40MWEzS2Ru?=
 =?gb2312?B?RG8wTHlUTzdqc2N2QXVEc05IOVRwMUxIcEJFNU9XN3FMaDF6WmQxU09XdXEw?=
 =?gb2312?B?UnZSd25XVld2TEN2VFk2cFEvSDVTY1BoTkRxUFdhUUlYUUMyN1hjdU1tTWty?=
 =?gb2312?B?VjhKLzRqenIwQkt1d2dpcGFXalE5MWU2QVlleGFKQUJqZUdzcVdrQm5sUUNN?=
 =?gb2312?B?Ly9TOS9wQkNpSDl4d1FadUJydVl4TENBaGZsUFhENXY4aTBHVlFGa1JhM3N6?=
 =?gb2312?B?K0xnM0dyT01TYlE5cVNwZ2JPb1duTk5hN2VMcy9rbWFIcktmcFV2amU3bk9l?=
 =?gb2312?B?bWNoeUpiL3hhMW5vcUh6L3UxVVEvdVVNUTZwcFZBVTVuZi83Rk92MGNYeE1E?=
 =?gb2312?B?TkFuSlBpd0QrN1psbUxpN1A1SVhZSXIvN2drd1c0UGdJZU9lejBWeTh5T0s3?=
 =?gb2312?B?VHB1UHRMdmlnbTZIYy9qQnc5UXd3L05na08zNnlJdkp6UGMxckR4eVV2TjZy?=
 =?gb2312?B?VE9YaGJHZGVua3JsUy9HMTY2YnJXdXduOHdSK2RHUmhMMGZaNUFSSWh3c2lQ?=
 =?gb2312?B?eUl0NFNVTEZvbDlRU0xaWjU5QUtxLzhNTUU1M25MTk9vQXY3Z3VVdHNWK1Zh?=
 =?gb2312?B?ZXE5VlRvbStSVmVxOFdyZEl3eWlVZFRuZFFPMkRua21zOWt5dlpNWFdZbGN2?=
 =?gb2312?B?N2MyQnJRWGlsazdEQUdBUFhuQkdhK3dWem5YSjU0ME4xZ1hsUFdkY2ZSUXV5?=
 =?gb2312?B?eUtXMzh0S083T3Y3R0xlQnZ5Y3FzbmtrN1N5bzZDaE5EcFB6TGxkMlBxSnht?=
 =?gb2312?B?TUdpeUp4M2Mza24zeFV5MFR4N1J2dFRaQkZiSnJ0UFFVT1MxQVdVTDI5ZHNH?=
 =?gb2312?B?K3A1TVhUR0RpYXBOSDBqQTFjblhrcGQ4U2dsVFZjc2l2QXhIcWJBYTFLWUsy?=
 =?gb2312?B?SVdKdlJYZWNEQW9JN3o1bUxUbTZQZ1lJaEtZZWd5VGpwdHVNL0RwN0I1Q2hM?=
 =?gb2312?B?OVdaOVUzSG9BV0xVeXo5OTR0NFFwQmlsaVptWjZHelpkcERwLzhYSkY1d1dJ?=
 =?gb2312?B?L0RHS0ExN2ludUdZbzZPVTZqelg5Sy9IbklnZ0ovRnlBVURhZUxqbnlvRFpB?=
 =?gb2312?Q?uQKwZAxMiapzvCcf2iW/J9qo8?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <6CDAC3A7CD7AEA488670AE6282A65F28@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2668cf-1e62-400b-63eb-08dabc918355
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:17:18.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mz3kuoU9QNxxqwk0RQGutsIlAi3Ey36yOtt5JoYG1qYZSlQM2Hu3Ka4JheMhElZsvKC0gmksAIJKgleuQ2im7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9569
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLACK autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CtTaIDIwMjIvMTEvMiA4OjQ1LCBEYXJyaWNrIEouIFdvbmcg0LS1wDoKPiBPbiBTdW4sIE9jdCAz
MCwgMjAyMiBhdCAwNTozMTo0M1BNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6Cj4+Cj4+Cj4+
INTaIDIwMjIvMTAvMjggOTozNywgRGFuIFdpbGxpYW1zINC0tcA6Cj4+PiBEYXJyaWNrIEouIFdv
bmcgd3JvdGU6Cj4+Pj4gW2FkZCB0eXRzbyB0byBjYyBzaW5jZSBoZSBhc2tlZCBhYm91dCAiSG93
IGRvIHlvdSBhY3R1YWxseSAvZ2V0LyBmc2RheAo+Pj4+IG1vZGUgdGhlc2UgZGF5cz8iIHRoaXMg
bW9ybmluZ10KPj4+Pgo+Pj4+IE9uIFR1ZSwgT2N0IDI1LCAyMDIyIGF0IDEwOjU2OjE5QU0gLTA3
MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToKPj4+Pj4gT24gVHVlLCBPY3QgMjUsIDIwMjIgYXQg
MDI6MjY6NTBQTSArMDAwMCwgcnVhbnN5LmZuc3RAZnVqaXRzdS5jb20gd3JvdGU6Cj4+Cj4+IC4u
LnNraXAuLi4KPj4KPj4+Pj4KPj4+Pj4gTm9wZS4gIFNpbmNlIHRoZSBhbm5vdW5jZW1lbnQgb2Yg
cG1lbSBhcyBhIHByb2R1Y3QsIEkgaGF2ZSBoYWQgMTUKPj4+Pj4gbWludXRlcyBvZiBhY2NlcyB0
byBvbmUgcHJlcHJvZHVjdGlvbiBwcm90b3R5cGUgc2VydmVyIHdpdGggYWN0dWFsCj4+Pj4+IG9w
dGFuZSBESU1NcyBpbiB0aGVtLgo+Pj4+Pgo+Pj4+PiBJIGhhdmUgL25ldmVyLyBoYWQgYWNjZXNz
IHRvIHJlYWwgaGFyZHdhcmUgdG8gdGVzdCBhbnkgb2YgdGhpcywgc28gaXQncwo+Pj4+PiBhbGwg
Y29uZmlndXJlZCB2aWEgbGlidmlydCB0byBzaW11bGF0ZSBwbWVtIGluIHFlbXU6Cj4+Pj4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXhmcy9ZelhzYXZPV01TdXdUQkVDQG1hZ25vbGlh
Lwo+Pj4+Pgo+Pj4+PiAvcnVuL210cmRpc2svW2doXS5tZW0gYXJlIGJvdGggcmVndWxhciBmaWxl
cyBvbiBhIHRtcGZzIGZpbGVzeXN0ZW06Cj4+Pj4+Cj4+Pj4+ICQgZ3JlcCBtdHJkaXNrIC9wcm9j
L21vdW50cwo+Pj4+PiBub25lIC9ydW4vbXRyZGlzayB0bXBmcyBydyxyZWxhdGltZSxzaXplPTgy
ODk0ODQ4ayxpbm9kZTY0IDAgMAo+Pj4+Pgo+Pj4+PiAkIGxzIC1sYSAvcnVuL210cmRpc2svW2do
XS5tZW0KPj4+Pj4gLXJ3LXItLXItLSAxIGxpYnZpcnQtcWVtdSBrdm0gMTA3Mzk1MTUzOTIgT2N0
IDI0IDE4OjA5IC9ydW4vbXRyZGlzay9nLm1lbQo+Pj4+PiAtcnctci0tci0tIDEgbGlidmlydC1x
ZW11IGt2bSAxMDczOTUxNTM5MiBPY3QgMjQgMTk6MjggL3J1bi9tdHJkaXNrL2gubWVtCj4+Pj4K
Pj4+PiBBbHNvIGZvcmdvdCB0byBtZW50aW9uIHRoYXQgdGhlIFZNIHdpdGggdGhlIGZha2UgcG1l
bSBhdHRhY2hlZCBoYXMgYQo+Pj4+IHNjcmlwdCB0byBkbzoKPj4+Pgo+Pj4+IG5kY3RsIGNyZWF0
ZS1uYW1lc3BhY2UgLS1tb2RlIGZzZGF4IC0tbWFwIGRldiAtZSBuYW1lc3BhY2UwLjAgLWYKPj4+
PiBuZGN0bCBjcmVhdGUtbmFtZXNwYWNlIC0tbW9kZSBmc2RheCAtLW1hcCBkZXYgLWUgbmFtZXNw
YWNlMS4wIC1mCj4+Pj4KPj4+PiBFdmVyeSB0aW1lIHRoZSBwbWVtIGRldmljZSBnZXRzIHJlY3Jl
YXRlZCwgYmVjYXVzZSBhcHBhcmVudGx5IHRoYXQncyB0aGUKPj4+PiBvbmx5IHdheSB0byBnZXQg
U19EQVggbW9kZSBub3dhZGF5cz8KPj4+Cj4+PiBJZiB5b3UgaGF2ZSBub3RpY2VkIGEgY2hhbmdl
IGhlcmUgaXQgaXMgZHVlIHRvIFZNIGNvbmZpZ3VyYXRpb24gbm90Cj4+PiBhbnl0aGluZyBpbiB0
aGUgZHJpdmVyLgo+Pj4KPj4+IElmIHlvdSBhcmUgaW50ZXJlc3RlZCB0aGVyZSBhcmUgdHdvIHdh
eXMgdG8gZ2V0IHBtZW0gZGVjbGFyZWQgdGhlIGxlZ2FjeQo+Pj4gd2F5IHRoYXQgcHJlZGF0ZXMg
YW55IG9mIHRoZSBEQVggd29yaywgdGhlIGtlcm5lbCBjYWxscyBpdCBFODIwX1BSQU0sCj4+PiBh
bmQgdGhlIG1vZGVybiB3YXkgYnkgcGxhdGZvcm0gZmlybXdhcmUgdGFibGVzIGxpa2UgQUNQSSBO
RklULiBUaGUKPj4+IGFzc3VtcHRpb24gd2l0aCBFODIwX1BSQU0gaXMgdGhhdCBpdCBpcyBkZWFs
aW5nIHdpdGggYmF0dGVyeSBiYWNrZWQKPj4+IE5WRElNTXMgb2Ygc21hbGwgY2FwYWNpdHkuIElu
IHRoYXQgY2FzZSB0aGUgL2Rldi9wbWVtIGRldmljZSBjYW4gc3VwcG9ydAo+Pj4gREFYIG9wZXJh
dGlvbiBieSBkZWZhdWx0IGJlY2F1c2UgdGhlIG5lY2Vzc2FyeSBtZW1vcnkgZm9yIHRoZSAnc3Ry
dWN0Cj4+PiBwYWdlJyBhcnJheSBmb3IgdGhhdCBtZW1vcnkgaXMgbGlrZWx5IHNtYWxsLgo+Pj4K
Pj4+IFBsYXRmb3JtIGZpcm13YXJlIGRlZmluZWQgUE1FTSBjYW4gYmUgdGVyYWJ5dGVzLiBTbyB0
aGUgZHJpdmVyIGRvZXMgbm90Cj4+PiBlbmFibGUgREFYIGJ5IGRlZmF1bHQgYmVjYXVzZSB0aGUg
dXNlciBuZWVkcyB0byBtYWtlIHBvbGljeSBjaG9pY2UgYWJvdXQKPj4+IGJ1cm5pbmcgZ2lnYWJ5
dGVzIG9mIERSQU0gZm9yIHRoYXQgbWV0YWRhdGEsIG9yIHBsYWNpbmcgaXQgaW4gUE1FTSB3aGlj
aAo+Pj4gaXMgYWJ1bmRhbnQsIGJ1dCBzbG93ZXIuIFNvIHdoYXQgSSBzdXNwZWN0IG1pZ2h0IGJl
IGhhcHBlbmluZyBpcyB5b3VyCj4+PiBjb25maWd1cmF0aW9uIGNoYW5nZWQgZnJvbSBzb21ldGhp
bmcgdGhhdCBhdXRvLWFsbG9jYXRlZCB0aGUgJ3N0cnVjdAo+Pj4gcGFnZScgYXJyYXksIHRvIHNv
bWV0aGluZyB0aGF0IG5lZWRlZCB0aG9zZSBjb21tYW5kcyB5b3UgbGlzdCBhYm92ZSB0bwo+Pj4g
ZXhwbGljaXRseSBvcHQtaW4gdG8gcmVzZXJ2aW5nIHNvbWUgUE1FTSBjYXBhY2l0eSBmb3IgdGhl
IHBhZ2UgbWV0YWRhdGEuCj4+Cj4+IEkgYW0gdXNpbmcgdGhlIHNhbWUgc2ltdWxhdGlvbiBlbnZp
cm9ubWVudCBhcyBEYXJyaWNrJ3MgYW5kIERhdmUncyBhbmQgaGF2ZQo+PiB0ZXN0ZWQgbWFueSB0
aW1lcywgYnV0IHN0aWxsIGNhbm5vdCByZXByb2R1Y2UgdGhlIGZhaWxlZCBjYXNlcyB0aGV5Cj4+
IG1lbnRpb25lZCAoZGF4K25vbl9yZWZsaW5rIG1vZGUsIGN1cnJlbnRseSBmb2N1aW5nKSB1bnRp
bCBub3cuIE9ubHkgYSBmZXcKPj4gY2FzZXMgcmFuZG9tbHkgZmFpbGVkIGJlY2F1c2Ugb2YgInRh
cmdldCBpcyBidXN5Ii4gQnV0IElJUkMsIHRob3NlIGZhaWxlZAo+PiBjYXNlcyB5b3UgbWVudGlv
bmVkIHdlcmUgZmFpbGVkIHdpdGggZG1lc2cgd2FybmluZyBhcm91bmQgdGhlIGZ1bmN0aW9uCj4+
ICJkYXhfYXNzb2NpYXRlX2VudHJ5KCkiIG9yICJkYXhfZGlzYXNzb2NpYXRlX2VudHJ5KCkiLiBT
aW5jZSBJIGNhbm5vdAo+PiByZXByb2R1Y2UgdGhlIGZhaWx1cmUsIGl0IGhhcmQgZm9yIG1lIHRv
IGNvbnRpbnVlIHNvdmxpbmcgdGhlIHByb2JsZW0uCj4gCj4gRldJVyB0aGluZ3MgaGF2ZSBjYWxt
ZWQgZG93biBhcyBvZiA2LjEtcmMzIC0tIGlmIEkgZGlzYWJsZSByZWZsaW5rLAo+IGZzdGVzdHMg
cnVucyB3aXRob3V0IGNvbXBsYWludC4gIE5vdyBpdCBvbmx5IHNlZW1zIHRvIGJlIGFmZmVjdGlu
Zwo+IHJlZmxpbms9MSBmaWxlc3lzdGVtcy4gPgo+PiBBbmQgaG93IGlzIHlvdXIgcmVjZW50IHRl
c3Q/ICBTdGlsbCBmYWlsZWQgd2l0aCB0aG9zZSBkbWVzZyB3YXJuaW5ncz8gSWYgc28sCj4+IGNv
dWxkIHlvdSB6aXAgdGhlIHRlc3QgcmVzdWx0IGFuZCBzZW5kIGl0IHRvIG1lPwo+IAo+IGh0dHBz
Oi8vZGp3b25nLm9yZy9kb2NzL2tlcm5lbC9kYXhiYWQuemlwCgpUaGFua3MgZm9yIHlvdXIgaW5m
byEKCgooVG8gRGF2ZSkgSSBuZWVkIHlvdXIgcmVjZW50IHRlc3QgcmVzdWx0IHRvby4gIElmIGNh
c2VzIHdvbid0IGZhaWwgd2hlbiAKcmVmbGluayBkaXNhYmxlZCwgSSdsbCBmb2N1c2luZyBvbiBz
b2x2aW5nIHRoZSB3YXJuaW5nIHdoZW4gcmVmbGluayBlbmFibGVkLgoKCi0tClRoYW5rcywKUnVh
bi4KCj4gCj4gLS1ECj4gCj4+Cj4+Cj4+IC0tCj4+IFRoYW5rcywKPj4gUnVhbgo=
