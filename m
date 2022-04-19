Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B65063FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 07:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348685AbiDSFrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348666AbiDSFrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:47:11 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1BA27CF8;
        Mon, 18 Apr 2022 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650347070; x=1681883070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A6QzX/KCqHZysKtP4sex5GQwl8fq97y+33xlmNVuexA=;
  b=hYQlT2ChR0oJDDT8E/5LXW+MvdChRs5kkZE+eVKMC5Cj2KHjhsgXjaF1
   iSbQ7+WWybT0LNvpEB6vc4ahzZa5x2sEfunoIaOWQz4VcYHvHK24s65oj
   R/mtFxM1vEzutXFM5DbXJDoT67PtsOPL27FR+pHUzkhfTLOjuuJTAA7j+
   jtv/xn0GL9qKtmN4qICRI9ajsyM49pMjaYkfCR+/igWRmZ7mrG7Zt/FZY
   9RgoeqkXQyVqsqT0jGLA4hpn+LhVglGwXGt5sJ235ZPkLMuOd0MHCXmbM
   pI5aBhbMrf5Kqf+qadJ9zvwNCxxc9kYZQwC7ehOxKbeEaGcXcpYwb0PIc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="54192229"
X-IronPort-AV: E=Sophos;i="5.90,271,1643641200"; 
   d="scan'208";a="54192229"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 14:44:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyTYom5AWw+OxmUJo6xMv89VvmHpIwh1HjqcFgl1O0Wc7aImB186LAX1Lc269RHcmyx00DuKAIIm35GfhS8HcVwNe0OjFczmw3Ze8gxRUBPxJvzqXOYEVORQDol5hAVDiVmHc9jcN49OJHbLwxOo8Hdrf6+khLRZtZCRrSe/55cRMdFnaIQ/UEb/na4RTmGsT66K/1WzmUcTDhnCtw0t5y+xqxHsW9DxxIKu0EXBpCBXjKVhtj6e1OZTxfFjkyeDS9654wfPoyX1CpBcRSiezC1LZgmtMN53bUMJVnuLmR+PsPXCa35IbLphXyBE6jIwKGwCHWpaleUI+xbnxa1I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6QzX/KCqHZysKtP4sex5GQwl8fq97y+33xlmNVuexA=;
 b=CTeDpMm5Vh2BuHXwWNdaXBMeBgfkoqFIGWfROmT/NlcXkhofywBNkxxZILCvGc1ncYyUVIGP8uRlrC362gJkkmty0EfskAiQ7oHX+CvP/dz5hEgq+rYd6VvIGL2E+GuqqYqIrC15Xcwi0wIu1BWwVyYRTDTPPxrp0+kpQTSAWBy7Pazg8BOVw2GgAYOKLUsriEnjoDPkTLIkdbQQqNkYvYX3QlCC/AwPHGpzAmGQ7Y9zGJuUm0f2UNNJlICA9Q6L3Jhqz30OvcOXidXSiQSgX3bIS3Gl9k9QIi4piDgjsumNKdgK6hhenZT6N+ACYP8hiJTG+uRT7r6wGQ9pdGZGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6QzX/KCqHZysKtP4sex5GQwl8fq97y+33xlmNVuexA=;
 b=oYNWlBWfXmOOjedbASa1xAxogNixK8oDvWKdhnQ47R5NL3/xCcFs+o9nhtq+EJMTeX7k9U/IbLaoGFNDS9+HcGioX96oy75fJNwRbLL19dJh47IhX/bIPmolvhOQXQtz+mK1tLQzeLpY4dpXIwwnRdP8oe4PaBnr+WgCT+/GJoc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3284.jpnprd01.prod.outlook.com (2603:1096:604:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 05:44:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 05:44:21 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Thread-Topic: [PATCH v2 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Thread-Index: AQHYT8zXJJEQ3fV/qEi/DHdBACJsWqzvW4wAgAED2wCAAKPKgIAFz1eA
Date:   Tue, 19 Apr 2022 05:44:21 +0000
Message-ID: <625E5A8D.3010705@fujitsu.com>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649923039-2273-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220414124552.4uf3hpopqa4xlwrd@wittgenstein> <6258F17C.7010705@fujitsu.com>
 <20220415140209.a56t6wuyjper2a3z@wittgenstein>
In-Reply-To: <20220415140209.a56t6wuyjper2a3z@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aca6680a-5a7d-4ce6-060b-08da21c7a727
x-ms-traffictypediagnostic: OSAPR01MB3284:EE_
x-microsoft-antispam-prvs: <OSAPR01MB32844BCC45505D3827743957FDF29@OSAPR01MB3284.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPcFyYlDLRutS5kc7Ys8S+/Dh/MK+wUoLeIq/gX/Ql6z26OUeYfFjuIwqFRij0Oj9wevewXsyYJyUS/LcL1jNkF2xA6uTzVJfd0MZrFP5VczYj6qJksLU8KeAWSfEKAfQkMiOR58Y/JmbVoFM6WswzWkeZ6DqWw2+dP3fLUVsD+D47l+N3TUrOtWYt71Enzc39X2Jn5BsCmJ6ZkrxfPDr4DvPOwerN3sn4fI/YxLAm1fHC4eFqq8Lm7xpYEo+ZpIHeygRNxu6Gc5A5mkrpPcPs67bTK4lOmH39z/Y8AIdud0yhQCJSpQ8YUiJNojLutJsNyZl8SZA5TbRKbBhaJ0YObRWchSsx8hq01U/K3Fmfcus8vfxcT/mhs5YuIQiiPhNq7RK1PtJkMhT08ZC0+hr8T9urZg5mOwTDH7dFtjH6nB18xMoOuueYv9ip1GNRFBdnWbVWdIfqbcQpreOUo1hyGkMtz/XHm3lOFClDu594IhvdsYE8hvluvKWqZPxrZ40ZBK3x7ZCjEftTk8W/6rA2wYxn96ogFAhuSPsiXCL9ntcqo/Kr/wFir2SXwPUO/LKceY4TAA7DUmGr341WLSMUrFlxKR4jS6VtW/0G4B1Z83WyLJy+3FLJAZz48jiNAaqAFEIXEW0r9px9YrKnTKcEMCEbj1BRu8sDAn+q7oboS80VHL9+U+h87ERrGg8Uecvm1rvvuwfwBISTXWu/7niw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(508600001)(76116006)(91956017)(5660300002)(71200400001)(6486002)(66556008)(83380400001)(38100700002)(38070700005)(66476007)(186003)(64756008)(8676002)(66946007)(66446008)(2616005)(2906002)(86362001)(87266011)(26005)(6506007)(6512007)(36756003)(82960400001)(122000001)(54906003)(8936002)(33656002)(316002)(6916009)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDBLc0R6REVDWFdtK2hMS1lubmNpdENOVjgvaFppc1MxUDdoRGNXOUc2WnZD?=
 =?utf-8?B?T2YxcllOb1ZZWGxRZzhqNFRRY1B2Uzc5cm1kZERKNThtVEZVNWpVcElMNTFw?=
 =?utf-8?B?QnRLdlZQNVVoTVJ1UTdVa09rcDJjR3R1U1pQTFRDZzNkb2cxY1kyMGxocFFs?=
 =?utf-8?B?SjRNZ3ZvT1YwNU9WK2FqbXozdENORENBbUdnTUFlVkJFd3I1ZUlyalpQb3ZV?=
 =?utf-8?B?cUYxOStkVXlmR1oyVFJLZzhEQU1WMjczL2lyWVZUYmE5Z21EOU13emdUTEti?=
 =?utf-8?B?RSs5SlBaaG5zQ0w5WmxyR2JPbklrN3RUQjU1K2VmQ1RRUS9RbmR4Nkp3N0Ri?=
 =?utf-8?B?WGN2Z0l5d2VRbER5MHhoS1M0ZUNQYmhmbzRzMDN3SHN0ekM3R1FkSWxsNi9u?=
 =?utf-8?B?RUI3Um1VTktDc29BM2tZZzB2R1FJODdTSEZMN01VOXlkQXJGaW5uQmRCMzZ5?=
 =?utf-8?B?MFR5d05YTTIvMmhjNXFNK0x1Um5EbjJQQXQrampKQUl1OHgyTGM0TDFJa2pQ?=
 =?utf-8?B?eFdGRnQ1TjBTcXVBMjRydm8zYXlpTjR3SGw5cmVYT0F3cjhhbmdscGhPeTVE?=
 =?utf-8?B?bjBXM0JKc1ZCUHNDbFB0VXRvc0tiMzAvV1NUdDJRL1BUL1g0a3B3ekIrWXdy?=
 =?utf-8?B?cERSZXl3N2NsZ0I1NEczZzUrRE1EeWpWcnVnTGxzaGo4bXNKSGl4enFJbW9P?=
 =?utf-8?B?b29PRlNQcDhWM2V1dXZ2UWQya1lwRlpUL3lTTlZHelpsQms3a2RaMkJ2RXYz?=
 =?utf-8?B?YitBL1VvOGVLT2t3aTlzd0pDempESHZGaEhmVGdYdkdpb1lqeUI2SUdKZUM0?=
 =?utf-8?B?NjNmTmE4cW9KOVRoMmhFb21zVWgxV1J6dGsrSW1MYWVWWTV0UC93SEI0ZzI1?=
 =?utf-8?B?RFNyanBMR0Iya2s0V21MMUU2N1JHSHcwcEFBWHpVUktrNmNiN09KSEh1cGpw?=
 =?utf-8?B?TGthY3lxTm5ETkZuUXdMdk1LbXpqaTBBYitITGJFVy9vdmZrUmxmdHdGbnQ0?=
 =?utf-8?B?WVJsdTZJTklhUFF1WkhiSGRGdkk0UFBPR3NEMmUrVTFSSzRYS1ZyMm1PazRB?=
 =?utf-8?B?VXBKUklCQXNVTkw1WlRMQnlab280UWV1bEVibEZ4dkQvaFB3NFNkLzMrM2Vy?=
 =?utf-8?B?TEJobkVHZEJiY284NDlQWXRJd0hHTlpOMzAyNzZnbThFTmRzTHZHZTdVOWpo?=
 =?utf-8?B?aytDMWZ5TERESHZ6dzZqWVRFS05xZ0lnRXhlYllhcE5PeTJFWWRuK3R3YWxm?=
 =?utf-8?B?b2cva1orYnhIL3JkL1p3WEVIa2JxYW9EWmljKzFNQjFSd1R3TmdMNjVMRXVm?=
 =?utf-8?B?d0RjTXRIakVzV3I3bUp0RVMwMEtTY0NZOWRFNHBEdEV0VTFqMVE0Zm9RZCtF?=
 =?utf-8?B?YlM2QTIrZGVXZFJtTm8yWWZQNGNzenNyOFYxZ3ZXTU5mOHRwckFSU1ZxZVdU?=
 =?utf-8?B?YVM0dkNVOEdwellPdHBESGtEaDBndVlhOHBmTFZtTnkrR2V2dGxsOEl6VTBC?=
 =?utf-8?B?Qk1pNSsrZ2tpUnlOQXFvK2dmdlBYUGtIR1BFT1RmNXIvbjhDT1IwZDhCaDFo?=
 =?utf-8?B?ZytXczFhY1R3UmkxNytFalJxRVJlR2owcGpWNUdtOUhCeGhscXQvUWxINHYz?=
 =?utf-8?B?UDh2NkVLamRHU21uQTBpd2ZBQU1kckdwZkx2OHhGUFp0dTFjRGlQU0pqbDho?=
 =?utf-8?B?THJ5c0t4UC91RGRRRlF5ZzU1NmN1dE9IZFlHWW5EMkxZbjNxbkc2Uk4raWRW?=
 =?utf-8?B?bjlLcWUreTcxZXNRQVBQcHpCRGdUdDMweThpaVFqaGVkVnJBb1BwQURhaEd5?=
 =?utf-8?B?TU53NkwwdEp1T1VkczRDYlZqVExpcDRQUU9EdXIrbEF2bktBUk5YRjg1cHpm?=
 =?utf-8?B?N01GKzBpU1JqMkpOU044NnlyNlRhWGk4RWo2Q0QxdnMvRUVEUHZRUmZLQkxF?=
 =?utf-8?B?Ly9ub0wzcnlWQVZ4NG9HcW5JSXo0UXF0dWhRT1VIYitiYWE3WnhCT3VqVnVu?=
 =?utf-8?B?UWQ5Z0pKT0pIYm4vU1lvZUFid3dBdjJDMW8zeE9RdG5lL2RhbitGNXBaZlZv?=
 =?utf-8?B?Qk41ZWx0WERDaXBlNVlJTTJaUk9iNlA3eEwwbzdLMkFaQ1JHb0tjTVA1VDd5?=
 =?utf-8?B?d2wrdTR4VlAxeHJnSitGTlg0OWxhYVNqQnNRU0U4VUIvaE9IWmE4NkV4bWxO?=
 =?utf-8?B?RjdIUnlZY2hnZjV5Z1VQKzBHT0JSRlNJSkU2WlNEMzlNVlZPT2MwVmk1WnZx?=
 =?utf-8?B?WDJuK05SOE84aXRLU05qRWZFdWdVUWRtdFZWV3hDZDQwMGltem5CN3d1ZDhM?=
 =?utf-8?B?ckoyTno2NFphWXp2T3h6bG90d05BQnZyVEVkOEFwVVBLelM2d0dQdE9IN2Vn?=
 =?utf-8?Q?dsTPluLpYvR55+gMGm/zueqgpOxN3kXEtTOuM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA482D98A6626D4EB82525533BFC6AA7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca6680a-5a7d-4ce6-060b-08da21c7a727
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 05:44:21.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +E2gH1A/NUUcYRjx8kNSNV4xqkQNtgAIkLdIjGh9V3VEWnrlgZiTxAAzQMbV8RGXA2IX4q269jl5sC7NCOx4NlwdxwFA3uTN+CtM2AEs4z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3284
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE1IDIyOjAyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gRnJpLCBB
cHIgMTUsIDIwMjIgYXQgMDM6MTQ6NTNBTSArMDAwMCwgeHV5YW5nMjAxOC5qeUBmdWppdHN1LmNv
bSB3cm90ZToNCj4+IG9uIDIwMjIvNC8xNCAyMDo0NSwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6
DQo+Pj4gT24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDM6NTc6MThQTSArMDgwMCwgWWFuZyBYdSB3
cm90ZToNCj4+Pj4gQ3VycmVudGx5LCB2ZnMgb25seSBwYXNzZXMgbW9kZSBhcmd1bWVudCB0byBm
aWxlc3lzdGVtLCB0aGVuIHVzZSBpbm9kZV9pbml0X293bmVyKCkNCj4+Pj4gdG8gc3RyaXAgU19J
U0dJRC4gU29tZSBmaWxlc3lzdGVtKGllIGV4dDQvYnRyZnMpIHdpbGwgY2FsbCBpbm9kZV9pbml0
X293bmVyDQo+Pj4+IGZpcnN0bHksIHRoZW4gcG9zeGkgYWNsIHNldHVwLCBidXQgeGZzIHVzZXMg
dGhlIGNvbnRyYXJ5IG9yZGVyLiBJdCB3aWxsIGFmZmVjdA0KPj4+PiBTX0lTR0lEIGNsZWFyIGVz
cGVjaWFsbHkgd2UgZmlsdGVyIFNfSVhHUlAgYnkgdW1hc2sgb3IgYWNsLg0KPj4+Pg0KPj4+PiBS
ZWdhcmRsZXNzIG9mIHdoaWNoIGZpbGVzeXN0ZW0gaXMgaW4gdXNlLCBmYWlsdXJlIHRvIHN0cmlw
IHRoZSBTR0lEIGNvcnJlY3RseSBpcw0KPj4+PiBjb25zaWRlcmVkIGEgc2VjdXJpdHkgZmFpbHVy
ZSB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkLiBUaGUgY3VycmVudCBWRlMgaW5mcmFzdHJ1Y3R1cmUN
Cj4+Pj4gcmVxdWlyZXMgdGhlIGZpbGVzeXN0ZW0gdG8gZG8gZXZlcnl0aGluZyByaWdodCBhbmQg
bm90IHN0ZXAgb24gYW55IGxhbmRtaW5lcyB0bw0KPj4+PiBzdHJpcCB0aGUgU0dJRCBiaXQsIHdo
ZW4gaW4gZmFjdCBpdCBjYW4gZWFzaWx5IGJlIGRvbmUgYXQgdGhlIFZGUyBhbmQgdGhlIGZpbGVz
eXN0ZW1zDQo+Pj4+IHRoZW4gZG9uJ3QgZXZlbiBuZWVkIHRvIGJlIGF3YXJlIHRoYXQgdGhlIFNH
SUQgbmVlZHMgdG8gYmUgKG9yIGhhcyBiZWVuIHN0cmlwcGVkKSBieQ0KPj4+PiB0aGUgb3BlcmF0
aW9uIHRoZSB1c2VyIGFza2VkIHRvIGJlIGRvbmUuDQo+Pj4+DQo+Pj4+IFZmcyBoYXMgYWxsIHRo
ZSBpbmZvIGl0IG5lZWRzIC0gaXQgZG9lc24ndCBuZWVkIHRoZSBmaWxlc3lzdGVtcyB0byBkbyBl
dmVyeXRoaW5nDQo+Pj4+IGNvcnJlY3RseSB3aXRoIHRoZSBtb2RlIGFuZCBlbnN1cmluZyB0aGF0
IHRoZXkgb3JkZXIgdGhpbmdzIGxpa2UgcG9zaXggYWNsIHNldHVwDQo+Pj4+IGZ1bmN0aW9ucyBj
b3JyZWN0bHkgd2l0aCBpbm9kZV9pbml0X293bmVyKCkgdG8gc3RyaXAgdGhlIFNHSUQgYml0Lg0K
Pj4+Pg0KPj4+PiBKdXN0IHN0cmlwIHRoZSBTR0lEIGJpdCBhdCB0aGUgVkZTLCBhbmQgdGhlbiB0
aGUgZmlsZXN5c3RlbXMgY2FuJ3QgZ2V0IGl0IHdyb25nLg0KPj4+Pg0KPj4+PiBBbHNvLCB0aGUg
aW5vZGVfc2dpZF9zdHJpcCgpIGFwaSBzaG91bGQgYmUgdXNlZCBiZWZvcmUgSVNfUE9TSVhBQ0wo
KSBiZWNhdXNlDQo+Pj4+IHRoaXMgYXBpIG1heSBjaGFuZ2UgbW9kZS4NCj4+Pj4NCj4+Pj4gT25s
eSB0aGUgZm9sbG93aW5nIHBsYWNlcyB1c2UgaW5vZGVfaW5pdF9vd25lcg0KPj4+PiAiaHVnZXRs
YmZzL2lub2RlLmM6ODQ2OiAgICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMs
IGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiAgICBuaWxmczIvaW5vZGUuYzozNTQ6ICAgICBpbm9k
ZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiAgICB6
b25lZnMvc3VwZXIuYzoxMjg5OiAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlu
b2RlLCBwYXJlbnQsIFNfSUZESVIgfCAwNTU1KTsNCj4+Pj4gICAgcmVpc2VyZnMvbmFtZWkuYzo2
MTk6ICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsN
Cj4+Pj4gICAgamZzL2pmc19pbm9kZS5jOjY3OiAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91
c2VyX25zLCBpbm9kZSwgcGFyZW50LCBtb2RlKTsNCj4+Pj4gICAgZjJmcy9uYW1laS5jOjUwOiAg
ICAgICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+
Pj4gICAgZXh0Mi9pYWxsb2MuYzo1NDk6ICAgICAgICAgICAgICBpbm9kZV9pbml0X293bmVyKCZp
bml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiAgICBvdmVybGF5ZnMvZGlyLmM6
NjQzOiAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkZW50cnktPmRf
cGFyZW50LT5kX2lub2RlLCBtb2RlKTsNCj4+Pj4gICAgdWZzL2lhbGxvYy5jOjI5MjogICAgICAg
aW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+Pj4g
ICAgbnRmczMvaW5vZGUuYzoxMjgzOiAgICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBp
bm9kZSwgZGlyLCBtb2RlKTsNCj4+Pj4gICAgcmFtZnMvaW5vZGUuYzo2NDogICAgICAgICAgICAg
ICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+
PiAgICA5cC92ZnNfaW5vZGUuYzoyNjM6ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJf
bnMsIGlub2RlLCBOVUxMLCBtb2RlKTsNCj4+Pj4gICAgYnRyZnMvdGVzdHMvYnRyZnMtdGVzdHMu
Yzo2NTogICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBOVUxMLCBTX0lG
UkVHKTsNCj4+Pj4gICAgYnRyZnMvaW5vZGUuYzo2MjE1OiAgICAgaW5vZGVfaW5pdF9vd25lciht
bnRfdXNlcm5zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+Pj4gICAgc3lzdi9pYWxsb2MuYzoxNjY6
ICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsN
Cj4+Pj4gICAgb21mcy9pbm9kZS5jOjUxOiAgICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91
c2VyX25zLCBpbm9kZSwgTlVMTCwgbW9kZSk7DQo+Pj4+ICAgIHViaWZzL2Rpci5jOjk3OiBpbm9k
ZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiAgICB1
ZGYvaWFsbG9jLmM6MTA4OiAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlu
b2RlLCBkaXIsIG1vZGUpOw0KPj4+PiAgICBleHQ0L2lhbGxvYy5jOjk3OTogICAgICAgICAgICAg
IGlub2RlX2luaXRfb3duZXIobW50X3VzZXJucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+Pj4+ICAg
IGhmc3BsdXMvaW5vZGUuYzozOTM6ICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywg
aW5vZGUsIGRpciwgbW9kZSk7DQo+Pj4+ICAgIHhmcy94ZnNfaW5vZGUuYzo4NDA6ICAgICAgICAg
ICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+Pj4g
ICAgb2NmczIvZGxtZnMvZGxtZnMuYzozMzE6ICAgICAgICAgICAgICAgIGlub2RlX2luaXRfb3du
ZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIE5VTEwsIG1vZGUpOw0KPj4+PiAgICBvY2ZzMi9kbG1m
cy9kbG1mcy5jOjM1NDogICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5v
ZGUsIHBhcmVudCwgbW9kZSk7DQo+Pj4+ICAgIG9jZnMyL25hbWVpLmM6MjAwOiAgICAgIGlub2Rl
X2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+Pj4+ICAgIG1p
bml4L2JpdG1hcC5jOjI1NTogICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5v
ZGUsIGRpciwgbW9kZSk7DQo+Pj4+ICAgIGJmcy9kaXIuYzo5OTogICBpbm9kZV9pbml0X293bmVy
KCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiAiDQo+Pj4NCj4+PiBGb3Ig
Y29tcGxldGVuZXNzIHNha2UsIHRoZXJlJ3MgYWxzbyBzcHVmcyB3aGljaCBkb2Vzbid0IHJlYWxs
eSBnbw0KPj4+IHRocm91Z2ggdGhlIHJlZ3VsYXIgVkZTIGNhbGxwYXRoIGJlY2F1c2UgaXQgaGFz
IHNlcGFyYXRlIHN5c3RlbSBjYWxscw0KPj4+IGxpa2U6DQo+Pj4NCj4+PiBTWVNDQUxMX0RFRklO
RTQoc3B1X2NyZWF0ZSwgY29uc3QgY2hhciBfX3VzZXIgKiwgbmFtZSwgdW5zaWduZWQgaW50LCBm
bGFncywNCj4+PiAJdW1vZGVfdCwgbW9kZSwgaW50LCBuZWlnaGJvcl9mZCkNCj4+Pg0KPj4+IGJ1
dCBsb29raW5nIHRocm91Z2ggdGhlIGNvZGUgaXQgb25seSBhbGxvd3MgdGhlIGNyZWF0aW9uIG9m
IGRpcmVjdG9yaWVzIGFuZCBvbmx5DQo+Pj4gYWxsb3dzIGJpdHMgaW4gMDc3Ny4NCj4+IElNTywg
dGhpcyBmcyBhbHNvIGRvZXNuJ3QgdXNlIGlub2RlX2luaXRfb3duZXIsIHNvIGl0IHNob3VsZCBi
ZSBub3QNCj4+IGFmZmVjdGVkLiBXZSBhZGQgaW5kb19zZ2lkX3N0cmlwIGludG8gdmZzLCBJTU8s
IGl0IG9ubHkgaGFwcGVuIG5ldyBzZ2lkDQo+PiBzdHJpcCBzaXR1YXRpb24gYW5kIGRvZXNuJ3Qg
aGFwcGVuIHRvIHJlbW92ZSBvbGQgc2dpZCBzdHJpcCBzaXR1YXRpb24uDQo+PiBTbyBJIHRoaW5r
IGl0IGlzICJzYWZlIi4NCj4NCj4gSXQgZG9lcy4gVGhlIGNhbGxjaGFpbiBzcHVfY3JlYXRlKCkg
d2l0aCBTUF9DUkVBVEVfR0FORyBlbmRzIHVwIGluDQo+IHNwdWZzX21rZ2FuZygpIHdoaWNoIGNh
bGxzIGlub2RlX2luaXRfb3duZXIoKS4gQnV0IGFzIEkgc2FpZCBpdCdzIG5vdCBhDQo+IHByb2Js
ZW0gc2luY2UgdGhpcyBvbmx5IGNyZWF0ZXMgZGlyZWN0b3JpZXMgYW55d2F5Lg0KU29ycnksIEkg
bWlzcyB0aGlzIG1lc3NhZ2UgYmVmb3JlLg0KT2gsIFllcywgSSBvbmx5IHNlYXJjaCBpbm9kZV9p
bml0X293bmVyIGluIGxpbnV4L2ZzIGRpcmVjdG9yeSBpbnN0ZWFkIG9mIA0KdGhlIHdob2xlIGxp
bnV4IHNvdXJjZSBkaXJlY3RvcnkuDQoNCkl0IHNlZW1zIEkgYWxzbyBtaXNzIGJwZiBhbmQgc2ht
ZW0uDQoNCmtlcm5lbC9icGYvaW5vZGUuYzogICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNl
cl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQptbS9zaG1lbS5jOiAgICAgICAgICAgICBpbm9kZV9p
bml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9jZWxsL3NwdWZzL2lub2RlLmM6IA0KaW5vZGVfaW5pdF9vd25lcigmaW5pdF91
c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlIHwgU19JRkRJUik7DQphcmNoL3Bvd2VycGMvcGxhdGZv
cm1zL2NlbGwvc3B1ZnMvaW5vZGUuYzogDQppbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMs
IGlub2RlLCBkaXIsIG1vZGUgfCBTX0lGRElSKQ0KDQpicGYgdXNlIHZmc19ta29iaiBpbiBicGZf
b2JqX2RvX3BpbiB3aXRoICJTX0lGUkVHIHwgKChTX0lSVVNSIHwgU19JV1VTUikgDQomIH5jdXJy
ZW50X3VtYXNrKCkpIG1vZGUgYW5kIHVzZSBicGZfbWtvYmpfb3BzIGluIA0KYnBmX2l0ZXJfbGlu
a19waW5fa2VybmVsIHdpdGggU19JRlJFRyB8IFNfSVJVU1I7ICwgc28gYnBmIGlzIGFsc28gbm90
IA0KYWZmZWN0ZWQuDQoNCkFsc28gc2htZW0gdXNlZCBzdGFuZGFyZCB2ZnMgYXBpLCBzbyBpdCBp
cyBub3QgYWZmZWN0ZWQuIEkgd2lsbCBhZGQgdGhlIA0KdGhyZWUgbWlzc2luZyB0aGluZ3Moc3B1
ZnMsIGJwZiwgc2htZW0pIGluIG15IGNvbW1pdCBtZXNzYWdlLg0KDQpCZXN0IFJlZ2FyZHMNCllh
bmcgWHUNCj4NCg==
