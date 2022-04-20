Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E92507DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 03:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358688AbiDTBR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 21:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358149AbiDTBRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:17:25 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863C1A812;
        Tue, 19 Apr 2022 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650417282; x=1681953282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kDt+rjQUGYPtIpRXwlhSGVC0FIp+2fZsfwHQVWfQyuI=;
  b=QRBCC24XDj2nwbUKiyc077K6zXtTdaYOVUyJodEiduRKZ2DrW17SXYc9
   fcNy95FiHUwfAVQgrXHMvQ2Uk6GuZDFQDshlsAqWzq5lUHBaCI3m3OpLA
   goKp/CtmOdA9n/7T1TWSPQp9ZHT2ghBT9KHI8WH96PFD02FWfRGHXFuGa
   dJH52OM4X1IJL5VQ2M0S2kWT+dwzxcFmYzYCBDdfL47odbrt1LuM9ucgO
   iFbDR9ydllatarbVWCiazfu3UDd+mILDdgIli4YxHpYLoMR3Ql+gFMYeA
   HY/z4BZHoJX9oMBJ8msBLCHkcDjpd7woNVmPWYbm2LlTKa44yp9siZzWz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="54054773"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="54054773"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:14:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHpMumJxtAaDIZdYwxD23FX310jBqjqrVQi1DLx9rKPRpdlL4mJva9ICyz4kza0Wjo0IjrWi4OQ/wZ34bR4z26MpLFtC6xtcJ8Qjp5OEVhiOX7U/8a2nGBxMSazOml4zq23NSEv+ipdSXJqFbCefMguE8tRvex2tMqaBd09EpQmZhZT3W5z7m4XzRBfpyJmFQNVJARSEtv4Z0aGd4nwj3nxFnjeXwthh/fVd8uuJT7aXBprDijs6Q6pV23IMKWcMV7/ilN+hRXtsKYYN5fYrk5n3QGrDbLpTW5Uq9x2BQTC2VTRL7bVGh9a22qzo5+Nr+7CO/O96wc6vaDUvffr/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDt+rjQUGYPtIpRXwlhSGVC0FIp+2fZsfwHQVWfQyuI=;
 b=M8bWCTiHdp7RTs7s+dPCmK4b6qp98cMAuoV6JpJk6WsmNmmQ4CVeGM+0W7+PrXN2v8U+2krUWdAyG5vaDXW4GRZswvzTkYJ4XVKHlRKxvWZPNlL4WEL4/ePxrGh3FvQwrcrlVNqw32RxMFt0Ww1wghA9aUdao+0A84PT7QpaD7sthMk/gld02xznkd74aUEBR0QX6Bj/VyAmiJCyfprZ5PLJa5SyOG9CG+eHOfvo2sk7Z9pmpiyMOuush+7acZ/B+DB1+qy7G/t9b4DHu3rOVNyNOwAc2pBXZcNLJl7Kd2WbiNzVn44+tc5V7meWKhPhQYvxMSASMlypPx7+3+QWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDt+rjQUGYPtIpRXwlhSGVC0FIp+2fZsfwHQVWfQyuI=;
 b=IUT7RWlb8FVMOirfqgGR8Mmh3mTGSz799WLKCNWIoKJRX7l8hKc/LQzhkuK/oCb1UeOdqCJ2iMkf/zGdr9yM/HDcE/wDJK6VB4nb5RR7tCq2nBKRPUta1StDHMvJOQIRuD5kqOtHRXVbi/EHcR7qo8OhIsQ68CRQlUIDp/QUOrE=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10073.jpnprd01.prod.outlook.com (2603:1096:604:1e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 20 Apr
 2022 01:14:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 01:14:32 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 5/8] f2fs: Remove useless NULL assign value for acl and
 default_acl
Thread-Topic: [PATCH v4 5/8] f2fs: Remove useless NULL assign value for acl
 and default_acl
Thread-Index: AQHYU9rxNbgjAU8likSkbLKJYp328qz3RHUAgADM6wA=
Date:   Wed, 20 Apr 2022 01:14:32 +0000
Message-ID: <625F6CD2.8020107@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419140220.bfziilnj47vdgsef@wittgenstein>
In-Reply-To: <20220419140220.bfziilnj47vdgsef@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14042d99-717e-408d-c2df-08da226b2040
x-ms-traffictypediagnostic: OS3PR01MB10073:EE_
x-microsoft-antispam-prvs: <OS3PR01MB10073469AAB33D6B68611D6ECFDF59@OS3PR01MB10073.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDa3KO0wt1XeBNJAJxj21kU/3PO9qs/+t6n+UwmwTgwHoYhB4Pu1w40VAx1gSGXOYDay1fhcqOApARPoTMgL2NgUTsnPkopy7F3MbM5PJ2zN79XvHinauvKyHZGBM3NQ6t46FcdIFccMpuWVZ4DA8zCtWJWqHhHmdPCrXK5ANVh6sfY5QbTWg3a8XVDijuKz6TLz0WCSri87zKPbEYCYk8lkV7OAGszBSjTDZtRoE1bhN9FUKsnHEcxBIC955OkR3jOKe2DuvmT8Ka4MU079CRJSdqVvU+0x/lQ+3HbyFopSu/urwRKKvOWJiceezoFV4Dmpb5UiZeyKEAldLlp6bfAgfaJQmweSsF3gnkgN7NwQcFW5pLhcutKMLNj+6uz828KxVXB0MoI5t6ECe4rh2dG8p0iIoQOFPCEKK0/7EqNFcLjvrscgpv0pGTz63Cwu3WqsGQo3ujwDPaVz7EYaYeL3V+bTqEkflrhz5dNfF5fbl6ezYUEmAqjUu3L997uh54iuRFiNoGhd/rY4Vtp4WPaf/ju/yhav7Do3/dP+ZUzgfQi3LpK06hRtdJnFV4+LeAmFsd83CEHHNzBM8CjIMhcA7gK9WcbzLyWruQ7i8I5YV8WGpbweRNeqRDX7vp1cdJw+l0JB0ZRwpIrkW3S4EbTofcupcy5QmTG8PY4GoTsIKRZ293z7nPR/6L260fE7kdjNXP2lDjrYeH5AxJVs6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(54906003)(6916009)(8936002)(6512007)(87266011)(26005)(2616005)(2906002)(64756008)(8676002)(82960400001)(38070700005)(38100700002)(91956017)(122000001)(6486002)(36756003)(66946007)(6506007)(33656002)(83380400001)(7416002)(85182001)(316002)(66446008)(86362001)(186003)(71200400001)(66476007)(66556008)(76116006)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZkbGp5ODJVTzV3ZmZTOGV4YnF5N1pyM3UyS3EybUlRSGZIYlFrYWQ2T0dB?=
 =?utf-8?B?dG9EQU9uUXNIODAyLzVTZjVXS2hEQ2ZmSWJSUWdiSGExcFRyT0tQWTFxaU9i?=
 =?utf-8?B?TG5vaVlQU2k0eVFpZHVWeTJQSHFXdncwY2FHK01XMDEvdFZSWE9xQ24xREtP?=
 =?utf-8?B?UjdtZis5UFZjekRvb3IxYVNhcGxBOEV2MGE1dVBIcFQ5ZHdKVGVLZTBkckNT?=
 =?utf-8?B?aXRlSFV4NUF1QVUwZGN3MTIxMStmdEJ2ZTIvOGtGZjRKZTRoZVh5UXdGUjgy?=
 =?utf-8?B?Ukp4OXZIS0xSejJVUGFxZEZxTFRjWEYxZVdlU3JzczZmZGJBa3h6YmVnVnZU?=
 =?utf-8?B?MlZtTFJIUTF4am9ic2hPaHRXeFh6SEx1YVlKOXpLNEpldno0WWg5TXpiZmxv?=
 =?utf-8?B?cys5VkdFU3dBaUxEL2lUbTJMMmpHNmxnczRDL0hZdXozOXRlMjNLSndROVhs?=
 =?utf-8?B?S095bnA0OVQzTnBJNjdMTGRFdHBxQ0dXOXVRbi9iWkszczVxazRCL3lJUlA5?=
 =?utf-8?B?SHpIUWxPOFZrV2dmZTlFRGZSa2dTUWx5OTcxRjVWbnR0bWRKN1NUZXVmb0Zs?=
 =?utf-8?B?aFByQ3Rua0s1NHMvUUxWWU1VV3NOb2hQbTNnV3YzbzNqQk1LaU1KeSsvWUJQ?=
 =?utf-8?B?T20rYWR0WXpwbU41dmViK2VEUjFGckczZ1RvcWF5V3kxUSsyM09Pb3IvUjM1?=
 =?utf-8?B?ZmlVNGMyd0RyN3hOMjhnWmx5a1Fhem9qbDJGeVYrYlByNFM4QjgwRkQ4alJ1?=
 =?utf-8?B?R1VUVXlqd081ZzhTSmxuVWhvR3pEYlExYTl1MHBweWxIMWZCNzFMTitnWEJX?=
 =?utf-8?B?aGp2VHZWdjFyVUUwSkJwd1VTc1ROWlJTQmQyeXE4dTlMWkY1ODh6c0RaVjZn?=
 =?utf-8?B?TDJFRXhUa0l0eUV6OGZNbkhETUhOSVNpdTNkTy9ZOFBlRDdzT0x0T2g3TlFE?=
 =?utf-8?B?RDBiM1Z2TFlZWndBQkhTL0NZM0FTMVpjQTdxcVFET1dGbFordFVzVWVtWjZN?=
 =?utf-8?B?UTYrSDRVV2ZHdmVWczhNTWRYREhvRnA2d0lEL0ZTV1ZmN2w4YnAwLzVpcGhz?=
 =?utf-8?B?UU1IVWFXZlZLU0RScHNTZ09kb09aa1BNWCtUbjl2RG9EbUFtNVFSR0E3RHhz?=
 =?utf-8?B?OWNmd0J4Mm9ZK1VsTkRRTkhXS2p2aVNtenlIblFCUGpUclZYeXVBUDR0OC9L?=
 =?utf-8?B?Nyt2aXZ4cjAwMW15YnBhaWpIQkl0S3JxQUpQOHlBQWpkU0JTQ0FpY1RpQWZn?=
 =?utf-8?B?d2YySmEyY0plQ1lRZmJuNEFaVHZzc045M1ZOaW4yTnYyWWR2UFk2b21VYkVG?=
 =?utf-8?B?TjdZbm10L2pmbGR6bXNja0lXaXkvOFpSeGo2K2ZEcDZKaVJ4UzJrd0FXNlc0?=
 =?utf-8?B?S0RBM05XWlRZRnordFUyZ1k2cmx5NjZNVVZEaDZXUWhwVlFBQ1lsK2E1dzJj?=
 =?utf-8?B?dzVRVDBtOEJsYytBUU9xSUhlLzBkeVRCcGpaZ3MyYWRPZW9WTTY2b3ZoUkJz?=
 =?utf-8?B?b3lwanJSZENYcGJiR3dTM29zU1U2SUYwZjBENTkvZDM1VzBXRFVMN2tzSzdi?=
 =?utf-8?B?MHowYXdFOTNoejlpVklBdE13dEEvQWUxTW83SWhwUGhuSTJ0U25mdmlHTmtz?=
 =?utf-8?B?L0dGa3NMZEU5V3dLY2NPNnlBbThpbWVKdmVyTWdabldPckhBbEh1bEZRUTdo?=
 =?utf-8?B?VkxjYjFFQUZnVEZ4azUva25vNTNaMTRDQWw4SDNXRGpxZGwxVEovOVVQdlVt?=
 =?utf-8?B?eVpDTmZNMWtaWHFDVktRRStGaEIvZ2J2Y1hXZUQxK3hFS1Y3UEpmWlQwRHZw?=
 =?utf-8?B?UXhLWnZYSFdhcS9UamlDS3A4UlZXTk8vVTFhZTgrTUo5d3o5MStyWTBhVnpR?=
 =?utf-8?B?STlMOWFwcDdOSW1ya0xSWDViNVZTOFQ1MUI1a3laQ3lKQ1hvbUZFbnRnVVNU?=
 =?utf-8?B?VHA5SFN6dDJTTjZpeCtXRGJGSUR1L2d4RWJiaFRreldMc0ZnRFRIUGZ1c1RX?=
 =?utf-8?B?Y0ZjeDNwbWt0SDZwYXRJdWNzNDlTNkRTQ2p5U0xqdTB0cFRtUHNLTDVqN25U?=
 =?utf-8?B?NmV2QjJIYjNINmhvSG1VSzhvYnZTeWpNa1B3SmJaNUNqNHV4Q1NoUGtSZTJl?=
 =?utf-8?B?YlRDVlgwNVArRVBEVkhCS3hTdVZLRDdlL0k3dGFKNDNneDNpNTg5dkNsK09K?=
 =?utf-8?B?UWF2TS9mZE5yNWVUSmsvd3A3WHl1amUwLzlrcUFUNHl5N0MyRjAvc21ROGFG?=
 =?utf-8?B?UnhxWlFwLzRvWENBT2RVcXU5K004alkyS1FIKzc0R0pUaHMzci9lYXc1OWEx?=
 =?utf-8?B?ZDRPaDVUblNkdGtNUkVHQlZLVmduYytoVENCRjVQcnFMWFBLa2w1V1NRVmpQ?=
 =?utf-8?Q?4oBfOvGqAYacZmkB80RpgNOkn77iJ4zB9qN8+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D4368F4E45E447A475B6D0693BB64D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14042d99-717e-408d-c2df-08da226b2040
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 01:14:32.3369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vkn76UI1Fr4NK5R6tq+q8pFGTIlgSEBt+f14z2hddjO1JOsY9BwiG4gARHrb9p0qXYnuN3XZGjWW8lq6Q97d4tOWYmj3pwuNsCVPXrTzF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10073
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE5IDIyOjAyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTksIDIwMjIgYXQgMDc6NDc6MTFQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IExpa2Ug
b3RoZXIgdXNlICR7ZnN9X2luaXRfYWNsIGFuZCBwb3NpeF9hY2xfY3JlYXRlIGZpbGVzeXN0ZW0s
IHdlIGRvbid0DQo+PiBuZWVkIHRvIGFzc2lnbiBOVUxMIGZvciBhY2wgYW5kIGRlZmF1bHRfYWNs
IHBvaW50ZXIgYmVjYXVzZSBmMmZzX2FjbF9jcmVhdGUNCj4+IHdpbGwgZG8gdGhpcyBqb2IuIFNv
IHJlbW92ZSBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZnMvZjJmcy9hY2wuYyB8IDIgKy0NCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2ZzL2YyZnMvYWNsLmMgYi9mcy9mMmZzL2FjbC5jDQo+PiBpbmRleCBlYWEyNDBiMjFm
MDcuLjlhZTJkMmZlYzU4YiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2YyZnMvYWNsLmMNCj4+ICsrKyBi
L2ZzL2YyZnMvYWNsLmMNCj4+IEBAIC00MTIsNyArNDEyLDcgQEAgc3RhdGljIGludCBmMmZzX2Fj
bF9jcmVhdGUoc3RydWN0IGlub2RlICpkaXIsIHVtb2RlX3QgKm1vZGUsDQo+PiAgIGludCBmMmZz
X2luaXRfYWNsKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3Qg
cGFnZSAqaXBhZ2UsDQo+PiAgIAkJCQkJCQlzdHJ1Y3QgcGFnZSAqZHBhZ2UpDQo+PiAgIHsNCj4+
IC0Jc3RydWN0IHBvc2l4X2FjbCAqZGVmYXVsdF9hY2wgPSBOVUxMLCAqYWNsID0gTlVMTDsNCj4+
ICsJc3RydWN0IHBvc2l4X2FjbCAqZGVmYXVsdF9hY2wsICphY2w7DQo+DQo+IEhtLCBwYXRjaGVz
IGxpa2UgdGhpcyBoYXZlIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGUgdGhlbWUgb2YgdGhpcyBwYXRj
aA0KPiBzZXJpZXMuIFRoZXkgY2FuIGdvIGFzIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQgcGF0Y2hl
cyB0byB0aGUgcmVsZXZhbnQNCj4gZnNlcy4gSW1obywgdGhleSBkb24ndCBiZWxvbmcgd2l0aCB0
aGlzIHNlcmllcyBhdCBhbGwuDQpPay4NCg==
