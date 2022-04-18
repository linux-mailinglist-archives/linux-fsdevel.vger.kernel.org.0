Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C956504B1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 04:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiDRC6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 22:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDRC6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:58:40 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B01A1837D;
        Sun, 17 Apr 2022 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650250563; x=1681786563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yXf3MjWaMC5cgQCBD59sqCKSaiMEM4Kry69bhGJ8s4E=;
  b=GC/rErNKG3qYHaaIEPbFxk1cm0aEPL+Ah9hwj/i8n8IVQv2tDBbx6yza
   g+PixR1Vp3hIPNkahns3xRA4kpGkCFotrASZwE8koxuumWoGYM7Y+w1VO
   3njtfal+/W+tZy1SxDKxCYCV62uK4Gia0ut1aSCdl10m7yScMrXvZzYhS
   VgL/ROV8ct3YrSxPNvnLT99YsOw4GV8jRiXouku5ZmxYwEfI70Rbd5cb2
   zBwArDIAvSQXVrDcpKFge9Uu6NqHmoqCc4E4IPFiQWtW9VXN6Pxy43C0K
   MT2dOybWIo/PPODx3Zumm1BT0+IKR7zzIUCPmFrsjh06Jh3t37LLgCIgw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="54067896"
X-IronPort-AV: E=Sophos;i="5.90,267,1643641200"; 
   d="scan'208";a="54067896"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:55:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcG5T4tvH5NTSvswpJXN0sZmw5FgT46AAJJKZUhOgDpMBuu4V9TfC3IuV/jDofF4t+QFl1rwz9EPRlm7DTTeC81kdF4g85fT/qkKAJIOAtswENRs9Px61ChTjqIKzF5zk0WZztbGVwWKs8JkNMznYsk2E9zfXkQy7LJFA+T0QG/7N1cPPOyNzwKfht7geSAMvRihbJZkWTOTL2yeXZihYLZcv6ssfYS8Cy56VPWgYKMYQ0uyv3CZG0MVwENIZFEGP1lrI6wQW8iw71mBgP/w5bgCoDLSffWYC3xLvFIFgfolmbZej25CeXzwFsW4XambQvlp/cb0LPDjNsY6yJUjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXf3MjWaMC5cgQCBD59sqCKSaiMEM4Kry69bhGJ8s4E=;
 b=AqFXz/XMtWc42EpwDaQ63TTEp9s2iT3g71DH9BbeuOsVoJfRCOZTgNWQhw/4NLAzB5nBmUV//yCW2I05YBN4eGjlNpvwikNSRKO1/9RXxfunOoxgPtQGcr8Ql3hLdR2rNUztAGxu3h1TbjE6KsolW/Uapx9SpF8T/sH1IixpWynQxgwZgmv5CdrOgpiypz/IBr5E6AAQwG75lJ8Rcn3wsgDJyshiY4lz4/rtGT1vmhqj4NbBEb8A5m/Z4J+UPC0Q/GDxtHtVCtH1bMEA2ENANwtzDWWhElALYhCpe0f+SWry2bIPTcA+9foNzUsW8Epy1JdlaAndoYPRhXcgI1q3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXf3MjWaMC5cgQCBD59sqCKSaiMEM4Kry69bhGJ8s4E=;
 b=jsSkF08qpUJiBxaLw17Q5M7kdZVpocw9KnrEEO/N5HZPDtYkrwrtI7hF7ddpoX1D7yW8h+gO4leuER9UqPsIfvHUKWWP8WpIaJYxhawZrq7GzA0INTwNw7bEtaXDT2pLW4ogBZQniubmAh+Y00T0M75v+PLfwgGT1TN7ad9lGzs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB1913.jpnprd01.prod.outlook.com (2603:1096:404:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:55:53 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:55:53 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v3 2/7] fs/namei.c: Add missing umask strip in vfs_tmpfile
Thread-Topic: [PATCH v3 2/7] fs/namei.c: Add missing umask strip in
 vfs_tmpfile
Thread-Index: AQHYUK/29WO0TlTeYk2xxm7cRjN3fazxBcKAgAQJiYA=
Date:   Mon, 18 Apr 2022 02:55:53 +0000
Message-ID: <625CE183.4020704@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650020543-24908-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220415141741.q7i7wwcmuzo5dgav@wittgenstein>
In-Reply-To: <20220415141741.q7i7wwcmuzo5dgav@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bd49838-01c5-4b2b-6f69-08da20e6f3cc
x-ms-traffictypediagnostic: TY2PR01MB1913:EE_
x-microsoft-antispam-prvs: <TY2PR01MB1913AB920F5F639E9C0788D2FDF39@TY2PR01MB1913.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyZzjDOfa3F10J8CnJOTwTpHtiuI3n5EpwuNETmoCTa41oHNapBMvCelhgttb5jTmYT4JhQmWHeV6notY55Q+69Fl26vkIt72XLkzClV9EgrmgOBQFMHeyS8g9jwQ7s1KtGmpfMbOeoyJisKq5WGWbiZ+BHiOoRH7U+iHPePk27E8Rrt136i8I5cwcxHELXjhe6HFUZMjek7OG0mtBBCcCfYyAIFM/FFepricWLETgqDFHf2s2Hyd2sstAjklfa0OLhAqJp9RdbRIg2vF/CNLv3pmJNHsD/aSP3BrIZRjpfZgTCIvQ2L3rumF8a1B5DVADFCSdwm3pqiAa++LwCHqE1BD1EVFEogTmqHe3YuYk9roIQCvF0E4dhZVOmfuaTbd+i90XOLMejXtfv8pJqDjFuEWTIoXz20xIET3+DLeNNkXtm06QlwFbpn8HHUVYzxcbnusFixJpZCP6sCux3Qb672jmgraDMyo9MZciRwMdP/SeWhWJ//v1Gb9iLM/Sz09W8e4UHLqDus2vQs9ojhtYWmNxFcTJvCN0BoEaPC95vGxxzNrG79cXeAoM/LcWIKiL1dahe1plidFST1rZ/UCmpdmw2ZEiKvfYcnEKvlsgwzGKSmM1VVgGSWqHIzkThCqlCe7F5qesOKKihgQsi6nwsr8Z7m6PTQLh0tplDIfjDBkBxv2vW4g5sPalJgNlxSlZPGksF2HdV8EXeOPv+iZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(91956017)(122000001)(6486002)(38070700005)(38100700002)(508600001)(86362001)(2906002)(6506007)(26005)(36756003)(33656002)(6512007)(186003)(87266011)(2616005)(5660300002)(316002)(8676002)(4326008)(85182001)(82960400001)(83380400001)(8936002)(45080400002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGMxeVlXVm8rczd2THpyTTJqVWtLR3BHRVpmRlVJWUVyTVFMclJkUEJoaEY2?=
 =?utf-8?B?T1BuejRWR0RFd0I3VzRsV200SEIvSlcwM1RydlEzYzNZNUJPQkRuVHRVdUxU?=
 =?utf-8?B?a1JoRFpWWm8ydTBWUVh3bzhVejNOTDhoTGsxVjRYT3lSMVlvTjBQOTRUM25k?=
 =?utf-8?B?M0wwejJoOURSTWdBOVVjdnF5V1dVMitiNzRnZHoxaDFpRy8vTmw2QVZGcFZv?=
 =?utf-8?B?MklDNXNFREh6aThXWlpIUjBYVlI0UGtFcmJ0T3dndHFSa09qSElobHVjQTJi?=
 =?utf-8?B?ejl1MFBnNkdHeTZ0c2lqTng1R09YaVJDUVlHSEdQd0hqYTk0a2lRVWpoc1hn?=
 =?utf-8?B?OThYcERpdEpVQjlFNEFlZWFaOHlUcTdtb3Y2N1NDbkg1ZEFFVkVnWCtIOXdK?=
 =?utf-8?B?eVdQdXdzUnVZNlBQRlZiY2Eyd2hZaDA1MS9KRXlnTWl4TE50ZnRSTmpaVklz?=
 =?utf-8?B?Q2dOS1FZWU5IOFFUUXZEL0pVUS82Wm95TXFKelZPYzJIUVFxYjdUY2FRZFVz?=
 =?utf-8?B?cW8vSVBJUzJ6VW5IRjNlYm1aQTRPR212VlZtWThzZnRtUTF5VE5ZS05IOFFi?=
 =?utf-8?B?czdNQ2NjRHpLc3FBUzdmc1ZmWVFDTnVMRlU1TTEzWXU3MHNuM0RmQ2s4SlJD?=
 =?utf-8?B?U0NNOUowa0xmSGQvQ2xZR3RoZ2hjRGRkNWF3V0xLWndabmhWYlBKWkIxWHlm?=
 =?utf-8?B?NEZkbTBOWmVscnJyTkFGY0kvekdXcHh4bE9GMXhFNzhGUjF0NjBTQmF2VGlk?=
 =?utf-8?B?d0xZcE1rRkVHcG5iQnNrVG1DNzZnNm9lSVV2T3QvbVNGcHZ2SjdaaTZwcG91?=
 =?utf-8?B?RUZCUzZTeStkbkdyVjh0UUxJV3dmVFRmQXhSdCt5MlN1blJ3TXZUUGV3V09x?=
 =?utf-8?B?NXlCakkwaklIdXlEOElkLzBad3ZuZVVKeHAyelRtNlNjV0pZUVc0SzV2ZzBw?=
 =?utf-8?B?OFo5MktYUmpIRW83MFRJK2tiTzFSWVZJUnk1OUsxUnZIRzRJdFhxQ0tVblF2?=
 =?utf-8?B?MXpFSEIrNndMcWxiWG9tWkIxUy9ya3E3NWx1ME4rckFaak5QQXUzMFk1RkVm?=
 =?utf-8?B?T0tEbjBMYVJaVW13TGhZbTN2ZUtNVmZuK2dRTnJZRkdiOE1pOUVOTGpsSjdp?=
 =?utf-8?B?MUIxakgvWTZRZE9qM2J0SjRIbWh4ekYrcS8wYWhTS0dqRy9HSFVzcGJxRHpY?=
 =?utf-8?B?RnErMjFKVjFBelJaOUE5ZTNyVkk2SnBPdlJBSWc5V042MUZGUW5xTlBJTFVZ?=
 =?utf-8?B?WjJ5OXZVTUtKVm5yT0lsT2ZNQ3hyVUF0UndRQkJTN1BYNjBRM3M3TnNkNXpr?=
 =?utf-8?B?c0o4dkxFYy81cStkaE1iWHpCRnhlalVKejU2UHZiQzZCY3NWK2VlbXh6cjhm?=
 =?utf-8?B?YVZYZU95UkVnaFpYWGF4ei9HWWFoSDl6ZE1qeWNjOGFXOWZwWllSV0l6ck5Q?=
 =?utf-8?B?M2Fxa1kyY3lIQlBSRXBaSkRFakIra09lK3U1c3J0U3lsR0lwM0Y3Z3ppQlRM?=
 =?utf-8?B?TndoajhiSUhmSWJPZlZkQjdtQUJTelk4dWJHdU9FTkU4c3ZzMFJwV0Vac3Mv?=
 =?utf-8?B?WHRVeTBmU3kvZlYwQzB3UUZ6N2hHWnZTQlltZlErVit2aHBTTENuS09rQms4?=
 =?utf-8?B?UFY4eFM4ZHV2ZGRQbndrMzBvZ2RiajFiendHSitvdm04ZE1lazIzenlzTDN3?=
 =?utf-8?B?TUNxMnNyWUwyYzBWcW5DOTdaSnd2VnFEYzNKY3Z6c3lzalJQK0tRd1VLYlJl?=
 =?utf-8?B?bHZiRHZ4RGJROHh4S0xKN0R6eFI1MlVpZ2MzMFZqdnJJc2JSTTJzM1FzZTVz?=
 =?utf-8?B?ZnBnZHY1RkowR2FGSnZlM004Z0NjR0tmU0h0Q3dSUHRlMzFZaFlsQUhqQ0Zv?=
 =?utf-8?B?djBEUHBlbHloVzZtcmdKR2k2WVY5N2hmVXpjUkYwSVFMaTVwa2JDdUtnUW1w?=
 =?utf-8?B?cVFCYXRaMG5zb0VzTUhiNzFsbmFodE1PaDJWNzZKUU1nT1A0S0JYSklvRDd1?=
 =?utf-8?B?bVhVMGs4N2pRUWJ3YW8rSzAzUmZVUHkzbmliRE9TRXp4Q3U3bmNKaURtUXUz?=
 =?utf-8?B?MHhqK2YxTFRrdHpaQndDY3B4bVN6aXdzSnhqK0NmelpPejd4czY3SUEzTUxt?=
 =?utf-8?B?T3RtcGlrRjRILzlIK2g5RkRVbzRSY2VBV1pYcCthTnNrUGQ3WHBmSm5jeUMr?=
 =?utf-8?B?ZWsrUHMyNm1Zckl3NGNrMklxQk9ObG9QRkNFekhubmhvdTU5NVFCM0diSCs5?=
 =?utf-8?B?RWo0SzAzNzN1Nmhwa2VUcUp1bElWdzF6L2lLVzE3RVdXaHphLzloUWpweGR6?=
 =?utf-8?B?OWMwVVhyMVovZlpHSVRYd3lvZ2tpYXJLTUdzUGVIajNnL3hLT0YxZlNzVS9j?=
 =?utf-8?Q?JTvAsRv35D9LVY3Qkpj0+465PHtgvNbRFJ5jN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FD4973DF222BC4FBB86C6FBA422CD0F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd49838-01c5-4b2b-6f69-08da20e6f3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 02:55:53.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCigrknAQzBVr7X5o3qtV56NiDLXY2n8Jc2YY9euzsx68tDE8Yo5YGK3LEzFG+5JHcQ/mrxTVjRd469UVLj7qFb1vrVovIG2uJIRv8lzxhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1913
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE1IDIyOjE3LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gRnJpLCBB
cHIgMTUsIDIwMjIgYXQgMDc6MDI6MThQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IElmIHVu
ZGVyZmx5aW5nIGZpbGVzeXN0ZW0gZG9lc24ndCBlbmFibGUgb3duIENPTkZJR19GU19QT1NJWF9B
Q0wsIHRoZW4NCj4+IHBvc2l4X2FjbF9jcmVhdGUgY2FuJ3QgYmUgY2FsbGVkLiBTbyB3ZSB3aWxs
IG1pc3MgdW1hc2sgc3RyaXAsIGllDQo+PiB1c2UgZXh0NCB3aXRoIG5vYWNsIG9yIGRpc2JsYWUg
Q09ORklHX0VYVDRfRlNfUE9TSVhfQUNMLg0KPg0KPiBIbSwgbWF5YmU6DQo+DQo+ICJBbGwgY3Jl
YXRpb24gcGF0aHMgZXhjZXB0IGZvciBPX1RNUEZJTEUgaGFuZGxlIHVtYXNrIGluIHRoZSB2ZnMN
Cj4gZGlyZWN0bHkgaWYgdGhlIGZpbGVzeXN0ZW0gZG9lc24ndCBzdXBwb3J0IG9yIGVuYWJsZSBQ
T1NJWCBBQ0xzLiBJZiB0aGUNCj4gZmlsZXN5c3RlbSBkb2VzIHRoZW4gdW1hc2sgaGFuZGxpbmcg
aXMgZGVmZXJyZWQgdW50aWwNCj4gcG9zaXhfYWNsX2NyZWF0ZSgpLg0KPiBCZWNhdXNlLCBPX1RN
UEZJTEUgbWlzc2VzIHVtYXNrIGhhbmRsaW5nIGluIHRoZSB2ZnMgaXQgd2lsbCBub3QgaG9ub3IN
Cj4gdW1hc2sgc2V0dGluZ3MuIEZpeCB0aGlzIGJ5IGFkZGluZyB0aGUgbWlzc2luZyB1bWFzayBo
YW5kbGluZy4iDQpPSywgd2lsbCBkbyBpdCBvbiB2NC4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1
DQo+DQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNyb3NvZnQpPGJy
YXVuZXJAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5YW5nMjAxOC5q
eUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIg
KE1pY3Jvc29mdCk8YnJhdW5lckBrZXJuZWwub3JnPg0KPg0KPj4gICBmcy9uYW1laS5jIHwgMiAr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2ZzL25hbWVpLmMgYi9mcy9uYW1laS5jDQo+PiBpbmRleCAzZjE4MjliM2FiNWIuLmJiYzdj
OTUwYmJkYyAxMDA2NDQNCj4+IC0tLSBhL2ZzL25hbWVpLmMNCj4+ICsrKyBiL2ZzL25hbWVpLmMN
Cj4+IEBAIC0zNTIxLDYgKzM1MjEsOCBAQCBzdHJ1Y3QgZGVudHJ5ICp2ZnNfdG1wZmlsZShzdHJ1
Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsDQo+PiAgIAljaGlsZCA9IGRfYWxsb2MoZGVu
dHJ5LCZzbGFzaF9uYW1lKTsNCj4+ICAgCWlmICh1bmxpa2VseSghY2hpbGQpKQ0KPj4gICAJCWdv
dG8gb3V0X2VycjsNCj4+ICsJaWYgKCFJU19QT1NJWEFDTChkaXIpKQ0KPj4gKwkJbW9kZSY9IH5j
dXJyZW50X3VtYXNrKCk7DQo+PiAgIAllcnJvciA9IGRpci0+aV9vcC0+dG1wZmlsZShtbnRfdXNl
cm5zLCBkaXIsIGNoaWxkLCBtb2RlKTsNCj4+ICAgCWlmIChlcnJvcikNCj4+ICAgCQlnb3RvIG91
dF9lcnI7DQo+PiAtLQ0KPj4gMi4yNy4wDQo+Pg0K
