Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD24EE80D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 08:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiDAGMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 02:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiDAGMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:12:00 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 23:10:09 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEED54699;
        Thu, 31 Mar 2022 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648793410; x=1680329410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LyhH+UM73y4yyQaPMgnsUitc8mCIpLPF0sW34iw7Vvw=;
  b=HGQB7OGqR+XtLnu5TfhkD8IhV7xRul23MvAFc8y31V8QfqrVQI8Rvcko
   HonF5Kzikn80Wae/kPWh+AQNxTNr5hfsNVo9km3NT6h3gT3fjrYZe4NpR
   J0Q/yo9nmyOmWT+ORdHXe+ei/PCf9UfANs0UUtylnORu94Btd1E9VNU16
   4tXdbXVZKQV/DnFlu48Wu3Cpu9jmk/lcTfYST14lL5pIdM2rx8OXXdn50
   O+Mo//fDG7ar0PQM0QQBSuBc2ggLCIIs44J3a3521P0mxdroNSKGEQHJK
   /IG431IFQ3UGnHfW9RtbHU2e70fCkjHNoM6SwVixSBBDkXIgi2tt6wufN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="53020155"
X-IronPort-AV: E=Sophos;i="5.90,226,1643641200"; 
   d="scan'208";a="53020155"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:09:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxRUtM/feIYgL1Q4V8egKcFOH41ebP5G17Qrpl7ps+KZQz/fIhA8yCWo9VEh+SxauEoLdOr0ByzvBylkW14erSYaI2CBDGKTc29K4122x+kfgfvyxElNqKNq6r0YIbwqhSwk0fZ4cR0Zp7B2ma4lDd9bcp7VbuHW3PoLIWjXcOG2NwONA7Kf9zYSdrBgM3Iu3aZFrzB2KkaTGrefUGtq7xU6gpq0/pcLT+dr2+/FgcM89Tv4f22Zw2Y1Zs7Kg26544/K3Yd33ozRtkPmxOCJ5ERLRg5jukhMp06gI+JgVjdXRxjEMwmxrlf4BJW9AGj4NiKhzRwO+4ogFTlF/w3Ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyhH+UM73y4yyQaPMgnsUitc8mCIpLPF0sW34iw7Vvw=;
 b=G8sApyrNE5BumUnPipdLAs5geux6XeVQF/qZhMqJ/6kWDJr8N08eSFHQrSPs82NJgJ7OPQShTGHSGI2avwn6yb9e9zFmh6wyY1ObUyp69rpY7cQvhrnhB6rxIG6KtQz6eQoCtNoZIzf7YzQc3q953eD98XXap6VCHaCbXoKr9rP30t8JUZZIQSu+f2H/O9VmFLeIJ94CP8clSW2/1yf/Qd1hyjDxahnaGB5U4CD0rbNFJJ7LZG31B+8ba8hwC5hDaZ5qlfGJ8qHQrXrJQxAyVAhKL4lFoMI2kGf/JPoce6Lnmng0tCW7WhXTPlZN+75O9LHdeVG1FNVK7diuNL/xdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyhH+UM73y4yyQaPMgnsUitc8mCIpLPF0sW34iw7Vvw=;
 b=OaDErwYbp6yYRXqKuic2dWCLu9PFt1i3v/Y50Ihx3kBBVUTbFWzId9yX6VoORDHiAh1B4L5bsDfcavXTNINg34KL6gDQ/P2fLWas4NLOtp6kiA9eI1JQ9gDRPJKMO1wlmQ1yiaP8HpUmVBRCeKQ89IZyh6MQs8ReazRovNyLRt0=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB6672.jpnprd01.prod.outlook.com (2603:1096:400:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 06:08:58 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.023; Fri, 1 Apr 2022
 06:08:58 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] idmapped-mounts: Add umask before test
 setgid_create
Thread-Topic: [PATCH v1 2/2] idmapped-mounts: Add umask before test
 setgid_create
Thread-Index: AQHYROG1nkif++qfDEmcNMEnghbLd6zZZKyAgAEvugA=
Date:   Fri, 1 Apr 2022 06:08:58 +0000
Message-ID: <62469728.4040904@fujitsu.com>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648718902-2319-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220331120239.uzliits77lfmn5m2@wittgenstein>
In-Reply-To: <20220331120239.uzliits77lfmn5m2@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d651e09d-beff-467c-0b06-08da13a61c55
x-ms-traffictypediagnostic: TYCPR01MB6672:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6672B7C01999FCBCEDE7F1FFFDE09@TYCPR01MB6672.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4eJJPsOw3LsEYBmUkZFJgAKxpGUdvexTNmHlqROnUh1pxnkM0aUDtVhyh52lXr0Ed3vPx18nHWdcfmDPt1CGxHPLjvz6BUkxgBc4OcGedhwhnHdqzIakBgvNoo+9CjU319JuNXZIavOmXzgvxPbzSY4NLyAQr8aU9QnhwYln4vYOZxUGNHWjWHiFaWYp7n+qQDz8HT3U+4fLxTPr/r+zXAoF9XGUBaILLZGtt8LmQ7YKxmXe1qcMeXqhnL1batAGSTI1+NAo0tZGEWjCFG/Won56AvbCMLpN17IMAtZR4nK+4rf1bhpmyIIIejVIZQ0TvUyqLt7sjAZi+sUUBdjBNKsxsRYSzpksoBSBFidFtxI7OoEpzA0G4zND4/usq6wzsUwRtffuHLSd8UzAm2OIUTCs30EpB2Fyq/GZh3qVkVnL8tp9nWjv+wWmoqx7Eg2oRLNHi6q1yVRetGgYK8h5R9/tZu0gX16niqJPJlnK22H02SX4npG0pzfL/u1UxEyb1qEcZpyUaCy15j/qaZ1ca445kpaLPURdM85DDbplxHseTk6X0WKIeg+zLp5/UKKhD3bOWgLjzFsw7T8DJ1YC6obB4AY4KDHdeYf8KPCLjpXsI5Rc+ydQq9a6thtarIZJT8QqPMCXez2RGcBSGO/0Pse7kQE8pRlg9s1vBJzzpW7WcPSOfknFCVfMOJt2NYR0DAIY9MSkRt9IO00Ew/lRPGne4BhFFYYkmQ4I2vdNFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(76116006)(91956017)(66946007)(64756008)(36756003)(85182001)(66476007)(66556008)(4326008)(8676002)(316002)(66446008)(83380400001)(6506007)(2616005)(186003)(26005)(86362001)(8936002)(4744005)(6512007)(2906002)(87266011)(82960400001)(54906003)(6486002)(71200400001)(45080400002)(122000001)(508600001)(5660300002)(38100700002)(6916009)(62816006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlFBUUVyaVBaU0ZMSHZsZm5BZWJ3bXJRZkR2WEI1THplck5qUjN4UGlCSUVF?=
 =?utf-8?B?QUxVSjQ2NUV6bnJ6K0lDZ2U1TVQ1WmZ4VWl3eGpVMWZuS01FUU95bU5MUnM5?=
 =?utf-8?B?YjNoWThtNVN5UmVQcmp1VHVWWHdKQkI2OEVhMFhxOG01R2hzSjNCNUI4TEc3?=
 =?utf-8?B?M2VsSzNQcEIwNVBvazUzTGV5ckZ1RHFEa0xmdnI3RndxZ3Bod3RpU0JQSWtQ?=
 =?utf-8?B?SHhpcW5SYnBXZzhhcTIzRFBYekpVN01nclprYmpkSW5BNmhJKzJUaC96ZGps?=
 =?utf-8?B?RFY4ck8reGdCRnhpWlJSbWJ1Y2RFc0FNYU8zMXVLckRxaWgxWVFPUnliTWl1?=
 =?utf-8?B?UGpWT0VYUVczaGR6djRKMEl4TXhiNFRxdGVmbzZUNmFqOE9rbk5la25RVWJG?=
 =?utf-8?B?WDRSMnZLaklvR3ZZUnJyMFo4MjVGT1RzTkU1V2ZacURkSUhudVFzbUJiVlpS?=
 =?utf-8?B?U3lqa2VwaVNycVJFWWVraEk0VUtXYWhScENKL3lKY20yTVNzaFZ2ck04Z2l0?=
 =?utf-8?B?YjV2MFl6SCs3REdBdE1jU2UyTHk4RDJSeExwM0l0M3JZUTFONXNmS2RuL25Q?=
 =?utf-8?B?NHpmQ3ZRM3lCNGYzUjFCdFFtamFuS2o4UHVPUy9rOUJidHNaUEhaM1p5a1Rw?=
 =?utf-8?B?Y2lKMHIzRHpCYThYdElwN0Z6NGtMaFM0QmxQR0tJM1JtQ3BEUE9YQjVxTFZs?=
 =?utf-8?B?TkcyMFFDZUFjUDhIRkwyUEkxSHUrTHpQQ1c5MUJTRmZocUhOK0VUQmlDN2wy?=
 =?utf-8?B?NWI3VzV5aWJIa3dTZE43dVRjQ1l6M1E5OWVZSzlyVXdYc2dkanhVTzBjYzFB?=
 =?utf-8?B?aUZ1ZkdsQzJ4eklHbm1SQ1dIQkNMS08zd0I1UTJDV1FneEgrWUN2bTNpWlB1?=
 =?utf-8?B?ejNiamkrVlo1ZllIMjg3MlRGMU16TXdDN1VqaGRESVQ3Mk50MWZrTy9lUnRa?=
 =?utf-8?B?SGVBcDZKL3RZQW85eVNYRnpGSGpFRDdBTS8yUWtWTU9DVjBHZStjd2Y2ZzVQ?=
 =?utf-8?B?czFtaWhuazBUeWEzMkZuT1RWeHd5VmdoQzZGMFVpNlZLQUhMWlNSNWZUdVdy?=
 =?utf-8?B?ektTUDZKRHV2MWVocTdzRjRLTGVXdVB1K0s3eFF0VEkzS2FUbHVqRXBwZjVZ?=
 =?utf-8?B?amV3Zk1IaWQ2Y1JCVk81WDhQZk5qYUNCcnBCTGN0MTlpcVFYNUxaVmhKUzFk?=
 =?utf-8?B?K2lZTFRhelk0MHBMSlNQZG5XVHhMcE9FUEJCT1I5UEhYZm9pZnZ1K2EyYllk?=
 =?utf-8?B?WXhKUmlQbUR5NytGWm5HclpOckdVTU1kOVJEOG1oMlBSNkgremliOGFJYmpL?=
 =?utf-8?B?WVpnaGpaNDdDVkxrQ2JmaHVsOHdoOVJiL3dvRjBWbjRMdTZUYlFMWHZMcDRC?=
 =?utf-8?B?Mm44SWk2b2lGSXFwZ1QwSGlEYmp3Wmc4aXpKQzdSbTlHTmNyWW5BYlFYc3R2?=
 =?utf-8?B?bFp1RDZQVEZubGMzQjE2NzFGUndlcE5ISXBFWlhPamhBNjhwYUVnamZaRTNO?=
 =?utf-8?B?WTljOFhqMkEwZ25tTjMzRWo3RHcxU3VzOEFFR1Y2dGtudi8wMTY3eGNPaXVu?=
 =?utf-8?B?Qkw1S25IY2tkYU1obWRDMDdNeHRHaXFhMXRSYVRPNGJLenVqSEkvWmVVNXpm?=
 =?utf-8?B?WUNqc1l6M2VuVFdWV0tzdnpEanBNMVpYNEd4NHhkUzdaa1dRczNBZU1qK0Fq?=
 =?utf-8?B?YnFhdms0L0JEb1BCZEdkM1pESWllZEY0YkNDQ0NCVjVqUUdpSElNdkROeUtL?=
 =?utf-8?B?UHpaell1aExVNy9VUjZaY0tvY1NjWFFITStzV0lUamxWcE80bW8zeDY0cjNS?=
 =?utf-8?B?b0ladWZrOTZwbllPY1Nra2o0WXJTZHhPeDR6MXZkWUtjaExKNTMrTXZrdmRs?=
 =?utf-8?B?UzhVeFh4T3hzVVJFSGFsczY4NXlHSTZHQyt2cUxyVVZvMXVBMVhJOSthZmRs?=
 =?utf-8?B?L2x2bjRQSVRRSTdRQ0xRbkF2SU1Qb3V0bTJNQWswQWtHb2tmTHg1VzFQazlw?=
 =?utf-8?B?bldJT0JhdERhSnpxdWZyTU5YdFQ5ZmtodGp6NnB5UXNZS1JISDB0YnUwVnZy?=
 =?utf-8?B?Qll1WlJFNjZvaVhSZ1lzaUJ3bTlvdUxxTHFFeW9YNHhpaHFJWUNJdVlmYWV6?=
 =?utf-8?B?UFpRZDFFMFZtaFBnVi91dGtPQ3M4cDlRUEZ5QnRMaGRVQWhiT2NnMjlBVEV6?=
 =?utf-8?B?NDZ6VDVjaUNPcmMvYko2TUtLdDVCc1BuMFBGUVlCT2dXSC9BT0VuWFdLVGFR?=
 =?utf-8?B?Qjh6ZDlXS2xJZXFJbUo1WGVGd1A5d3ovTVJ0OEx0bmhpYmZSMVVKbFhmeUpU?=
 =?utf-8?B?UitRQklOa1hVTDVzeTQ3KzBWSEtPbit2MTA0bUtBZ2NRekJpU3k0TVNHVitO?=
 =?utf-8?Q?mnB3WEvVcnHB/Nrgy2/G4AuHoYss33eiLCfrl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DB4F11C48DBFD4B9DD077406AEC00A8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d651e09d-beff-467c-0b06-08da13a61c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 06:08:58.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQPyOMy47zRmi355fco+p4ntdSY+Us3r12U+otiQvHTPv4J/mQtJsoY2NhQAFft3PQLTvXnIfiwm+RzN3vz1QOKd5vOo88yBVNCqW/5XUmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6672
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi8zLzMxIDIwOjAyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBN
YXIgMzEsIDIwMjIgYXQgMDU6Mjg6MjJQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNl
IHN0aXBwaW5nIFNfU0lHSUQgc2hvdWxkIGNoZWNrIFNfSVhHUlAsIHNvIHVtYXNrIGl0IHRvIGNo
ZWNrIHdoZXRoZXINCj4+IHdvcmtzIHdlbGwuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBY
dTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+DQo+IChTaWRlbm90ZTogSSBy
ZWFsbHkgbmVlZCB0byByZW5hbWUgdGhlIHRlc3QgYmluYXJ5IHRvIHNvbWV0aGluZyBvdGhlcg0K
PiB0aGFuIGlkbWFwcGVkLW1vdW50cy5jIGFzIHRoaXMgdGVzdHMgYSBsb3Qgb2YgZ2VuZXJpYyB2
ZnMgc3R1ZmYgdGhhdCBoYXMNCj4gbm90aGluZyB0byBkbyB3aXRoIHRoZW0uKQ0KPg0KPiBUZXN0
ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4N
Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJAa2Vy
bmVsLm9yZz4NCj4NCj4+IElmIHdlIGVuYWJsZSBhY2wgb24gcGFyZW50IGRpcmVjdG9yeSwgdGhl
biB1bWFzayBpcyB1c2VsZXNzLCBtYXliZSB3ZQ0KPj4gYWxzbyBhZGQgc2V0ZmFjbCBvbiBwYXJl
bnQgZGlyZWN0b3J5IGJlY2F1c2Ugd2UgbWF5IGNoYW5nZSB0aGUgb3JkZXINCj4+IGFib3V0IHN0
cmlwIFNfSVNHSUQgYW5kIHBvc2l4X2FjbCBzZXR1cC4gQW55IGlkZWE/DQo+DQo+IElmIGFjbHMg
ZmlndXJlIGludG8gdGhpcyB0aGVuIHRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIGEgbmV3IHRlc3Qg
b3INCj4gc3VidGVzdC4NCldpbGwgYWRkIGl0IG9uIHYyDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBY
dQ0K
