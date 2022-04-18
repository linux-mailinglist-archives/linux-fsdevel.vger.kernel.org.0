Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF7504ACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 04:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiDRCLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 22:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiDRCLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:11:01 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9993183B7;
        Sun, 17 Apr 2022 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650247700; x=1681783700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BUVtPq9dSQSxjAI/9oMEQtuTZkxNuJLAX3ZSQYu2jVM=;
  b=qLYmDFnQ76HnDIKvTjMQg4sR5pvvF9GxyoWePvLnLc7imNos9oiQiDew
   4hHWKOc6SXifws74BQoZqEno9nTJ2cQ+NMYokaQ84R02GqFOwAKYwAHBf
   JJoJslXwu7YTLI7LTFhudaWndFXFNpXXOwzOdGeJbi1vqdVDO+6o6vrxD
   w7I3uYrmFeBZT90o3+DPjJeGwWWUh9rCSPkom/Q98h8oqFJaFIb+CUP8j
   6lgxYYponTrZarsMN/128BwR3a/jigqxkV92wufLvFan1lIN66AzwuY5v
   DVfxPgkCU4NWkMgqG+I86XBQSfsS+5UAKuInRrYZ2JSpqJl40+oaFIJ2I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="54173646"
X-IronPort-AV: E=Sophos;i="5.90,267,1643641200"; 
   d="scan'208";a="54173646"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:08:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQn78mLviRBKpTraMjsnAyleJOyQ5/ukPaNwbXWehwrgNBXeXt1YfHPv/aP8XVj7TUjm7og6s8lwsLI1ZixPGgqzSGRM4dkKQIOuUKpva3T2I9iKnTqHaEZct2qJ49t/wrW5E/Nf0GDdu9sFio3IFiErjkV6KV7rdWlOpbUTajgRjmpztY5gT+1UGFGfjsgtIsgjQ1TSRU8/UN5NPxuf77Y6YZayhHDLU+BrdHqARS3+7fq2fU+mo/8lQYwCYnDk52sBgcIkd7hLzhDNC5OpjBHQp6uDoq86dvUF1tPBpL4ZqsmuvoHV1L5myrDnykGZXTE5MJMBLpRV7jBVnNxNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUVtPq9dSQSxjAI/9oMEQtuTZkxNuJLAX3ZSQYu2jVM=;
 b=hRbCF/ZmBTX1XUlJjjzPNUIwiqlhfIvrtSj4BE4szcTOLQtFlVz13Op33E3gX59ufrgzPr2NGNyMuTA0ptt714V2EOcw7EKj5sYxYFE+6nMloSKGkpU7zZGi5bEdU4EtC8YZ/TD9tbCrJh8eW8zUsbG95kS9EX5d/kJFBT4lDx2Rm25H4D8E0fjbf6Beih/yJMpFd8kef+wX9EJyiLpr4Odv12Ad4i0ZVJ0UHE+Onlu3ufFh0hENXDFRyY10sxnqoAsZJTYuZhozvCCuSghlTXKkjPFFz2+UsPDJV6xJEXufghJufY0ePksrYrMsuqQAa3W+WsEslg7hJFwvJY4GpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUVtPq9dSQSxjAI/9oMEQtuTZkxNuJLAX3ZSQYu2jVM=;
 b=CstncVPzIXxjsNeCbqmkQJBHiv1eoDjXusthtUL/RB59uhH22o6OIblTyjJE+tFOm+8MZEurPnK+Gnjj0nvlzOTf8TwkWJN1Z+POs0HmwHbbLhs3YMhzw6g44NBuykcLKlmwCwV5S8X/5ck56U+UYB6nCkv9B/B9b1CeeqmSY9s=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8132.jpnprd01.prod.outlook.com (2603:1096:604:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:08:12 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:08:12 +0000
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
Subject: Re: [PATCH v3 1/7] fs/inode: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v3 1/7] fs/inode: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYUK/jJkL7Z7ciH0Owe804/6Pum6zxA3EAgAP+lIA=
Date:   Mon, 18 Apr 2022 02:08:12 +0000
Message-ID: <625CD661.9070103@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220415140924.oirar6dklelujnxs@wittgenstein>
In-Reply-To: <20220415140924.oirar6dklelujnxs@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b54acb4-3b97-4e7c-0618-08da20e04a9f
x-ms-traffictypediagnostic: OS3PR01MB8132:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8132AFD70E6E5F55B6FB81FFFDF39@OS3PR01MB8132.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AqB5JI8lzkPzEdzX2g8hO2GMPHtqI6HPGvwWzIEof5r34t7AUHd2JERIJo6OUJVhuUoMrVcqWXmNZL8JdaRTR15zbnvwsBgE04kVSVgoZu3EMdkhlVyCptGRGY3k5ePSEmHszctEODs9z566oxjRfA1wk3S6favwjE2XCkIsx3OWNRnyFVJX/9fe0Li8uMVvjUofi8pu+2wU4Ovs0KtP9S5Fjlk56XIl48bZYLmo6PCSrwVG7bkE6E+2wLbJqxdGSgJ/lym/9NM/WHEwvwmR78YF6hRHCsvdSPY4B9xPu2qQHwMmaXkaAVBdPs3N2cFncnCBqt4Wxb74kSuLjTI/PzwpQ4pp5JUMXSov1BwBLK5kJ4KPNeYLl3i6u/qKqCIVp5iY7WLo8TZlhWb2mMuxPtRWPQN2d4/Rkrc0+4ueapAKoU0p28s1tWbl5yXnQj7r9BBmKiG0NbNKPaGd2ZCD2WseplTLsiXRrGXCdT/sifXkdBLlqNKJSF40NNt46W2pce9w22d/S7Ns6NaQWH1lbzkEQ7qugJxGhvzqCN60cams4cTnXzh+KACF7k4vBU9kXriOcNO/eM/mKdIZecO9d1JVCbKsNqBBwSzpAQr4HKFwGwGCUPjTx5hIABHwcEoBoG9c6ejt9qdbf4Q9RkSfjvkAP3KuxrPiJwVxYU97t454tvhsH1SqfWMqQT8I0SsFT5hz7jJy+wAfPnbQZAFO0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(71200400001)(86362001)(82960400001)(508600001)(83380400001)(2906002)(186003)(6916009)(33656002)(54906003)(36756003)(5660300002)(38100700002)(87266011)(316002)(6486002)(91956017)(8676002)(2616005)(66476007)(64756008)(66946007)(66556008)(66446008)(85182001)(6506007)(76116006)(4326008)(38070700005)(122000001)(8936002)(45080400002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE8vZlMzb3FyK2pGNWN2MUxUaXExZ1JsbFJBcFU2NFFUV3BJR1BuaGpFSVgz?=
 =?utf-8?B?allQc2UrWUVRRU5wTHB6cWVKbHhkZExPNXphbS9sVlVrcnNLTVJzT3BvZUps?=
 =?utf-8?B?ZUlZbXdJK05NMVZPNlJiYWZoTG9VSzNYLzBLWVJEUFhPWWVXVEdKSWpuc29m?=
 =?utf-8?B?RnRZckVnQWZkNkFVYVRuU1pNNUVnVmlDVXNLMXpWTmV6QlFLaG1uSGZJV0pr?=
 =?utf-8?B?OGFsL2VyVUxGY3Q0SHZRZ1VrbVZNMWNKK3dPTUJqRXBKbGhyVmJ6RldCVloy?=
 =?utf-8?B?aHFkVjYwSGRTb2NtQ09BZU9kZDg1K3NRV3VzNGdqdzUwVGhIV2grK1VHcndm?=
 =?utf-8?B?WFV5SzBNaUt4ZDQ1eTJjbUVuZUVLakEvRm8vbzdDZmVKYk1pQ2kzSkhMSTJP?=
 =?utf-8?B?cC9Ib25NUDR4alNQQ0I3a0Z1aXhIbmEvemdaU0d6bjNRRkNVN1VQYkdYcTd4?=
 =?utf-8?B?bW1VQTZpTk11VEtZS1dTaEdIZmU0UENSY1NLV3QxVGphRmo1TDYzcEJiaXRm?=
 =?utf-8?B?UkhFQlEwQ2pDWmQvUzA0a28ycUREbGVTZmdBRmY2U2pvU0JtT2JCRmhZSkdC?=
 =?utf-8?B?R0pJRjROcGRXMjBGLzhWN0c3bVJzd3Qxc2JUZHR4UDB6ZW1QRkNpaTZ5d1d6?=
 =?utf-8?B?UTZxVUhyU3R6STJ3S0RQOHI5K3JKa3l0SmJtN3JCRHZML0wwYncrRmMwSjB4?=
 =?utf-8?B?YkJPUm5QZTNOelpJbk1TbkNGSTlXMVRkUmNWRTVxcDRPRjZuSDI4bHorRWRE?=
 =?utf-8?B?Vys5WjVNeXR4UnExZi83MnluM0xwQzA2QjF6aUgrSHUvRjQ5dit3OHUzclUz?=
 =?utf-8?B?K3d4djFtMVhsQ05CU2IxdGtmZkMzSGc0OXkzdE1pN1pocWowS2kvekl5RjRu?=
 =?utf-8?B?dGhsNXNRYUVqUzJKS3Z2SHM2R3NRVW85OGJCcExoWUlVRDBkRTZGRVhPNEdR?=
 =?utf-8?B?YmFTV3JveWFjY2dPZk0zVWl3RTFTM0hscWtZalA1UlduaDdiRmVxUmZyVk5T?=
 =?utf-8?B?dWlUZzBITFV0TW9oajVobmh3MVlMQWs4dXVyTG0vT1QxZVVSbGt0NGE2SUww?=
 =?utf-8?B?RG1RM0ovaGFxREY1Y0hLS250Y0VaZERwOEhPL3RaUUIyZmJmejR1YzVUcUVY?=
 =?utf-8?B?U1BDMVRSNG13L00rakhpSG5SYjcrZlpiUUtDWjlyQTdZREhod2xOYy93djFJ?=
 =?utf-8?B?T2dMNG4vb3VwQmdZOE93VzhEcHRDN2hOU050ZWhnNGRPSEdOK1RFL21xdis4?=
 =?utf-8?B?M1JLTFl1QzZoSVJoaXpOQmYzbElNc2wvK1RuSW9icC80bHJDOFMwdWtIZFBB?=
 =?utf-8?B?MTE5QTEwNnUvc1YyZTl4NGtaM1dqZ0ZGeU05dUZaeTZVeVZnYVJuSXpSeHBl?=
 =?utf-8?B?SEtpWU5YQm5RVWZpVTF3MjkrZ214MFB4MW82SmlZQVZOQ3JscmNLc3VnQUl4?=
 =?utf-8?B?bGlZcysra2RrYmpGb1RvaEYwSC8wU216am43S0xCMk9jWlZ3UURWMGNsSUli?=
 =?utf-8?B?d3cwUERab3hoQUFFdnFQUzRQdTBuOVlHM0NDck9NSStSSXdUblVXSTI4bEdt?=
 =?utf-8?B?WThlKzdCL0hPYlBmZGZ0MnVWSE1la0RhdUd2VDdiRVZ0d0R5QU15VzRGc1Fa?=
 =?utf-8?B?bDhIbzdKRGZqaEdqZ1FFb2Vsb1pUZXNUSjYwczBMR1ZqTHBzTmZoSjkrOWpJ?=
 =?utf-8?B?NXdDNW5RbitLZVRMdnVLNVdMZnFsZm9Dc2pZK2doTkwxZWpUdHBuY1E5WDR1?=
 =?utf-8?B?UUJnNjMxN0UrWUR0MkxtdGdlY1hiQ0pLYkFKRHR4NmRFakx3R2lYWTFETTY1?=
 =?utf-8?B?QWszUWZMN0c4RzdkbjJXdTJQanJHQ1ZTSStYYWpRZmhDQW9JQ0d5MGpYZXFI?=
 =?utf-8?B?bk1RSGR3SFJpWVhlamFYTlM1VUFyY1g4V0ZoUjhsQXkraDRSQnl2aTNUVnpW?=
 =?utf-8?B?MlRYelR2b04zM1Q2TzhKUGtBeHV3dEJnaEhVRVpWdDNybkUrSmJTK3RYa0Jj?=
 =?utf-8?B?MjJkRlZKZlZWa0lnSUpPWkRPbzNaVFk3RkY0dEM4eWp1aTlJTjh1YW52VGUr?=
 =?utf-8?B?UlVmdFVaaWRibzBRSGdieExGeGhpL3VuNXFDa3RzTXR6Rm1pTkhyUlpibEZX?=
 =?utf-8?B?VHFjcUdZUGlpcURQVkVLb201Um5ndDBHekU5dGJyTzg0dTV0SDV0c2tGZWZQ?=
 =?utf-8?B?T2xBRFhLcDlnaTZFL3VJdmJxSko1ZkxFOVJycTZKV3Q0UmNaaDBQeE51cmdW?=
 =?utf-8?B?c3dtMWhSaUUyTW1sSmVuK3RNSk9XbG1QQmFVdWNEYjUwQUZvT0F4dkFIWHdS?=
 =?utf-8?B?YzBWRGowV1lPcXFiemZDSjYvRW9YYVEvQzJKQ2RiNlVEanEyb3VScm1CR20w?=
 =?utf-8?Q?S1FIUNamw28JGvvChsKqOp2mUkoZfRI08uC8P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B5D22939FD6FB4FA347EE40DEF8FE6D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b54acb4-3b97-4e7c-0618-08da20e04a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 02:08:12.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzhDnnjbVUK0T9dOATX2PUIrEewVLoihOQ3qPTx3EOGbpbS+0Xt0gHHAkf53zAT7bQ0rXrbLIY5VwvQ8IA1kZpOgCqeACPx5H9laej2Z/s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8132
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE1IDIyOjA5LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gRnJpLCBB
cHIgMTUsIDIwMjIgYXQgMDc6MDI6MTdQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFRoaXMg
aGFzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBKdXN0IGNyZWF0ZSBhbmQgZXhwb3J0IGlub2RlX3Nn
aWRfc3RyaXAgYXBpIGZvcg0KPj4gdGhlIHN1YnNlcXVlbnQgcGF0Y2guIFRoaXMgZnVuY3Rpb24g
aXMgdXNlZCB0byBzdHJpcCBTX0lTR0lEIG1vZGUgd2hlbiBpbml0DQo+PiBhIG5ldyBpbm9kZS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+
DQo+PiAtLS0NCj4+IHYyLT52MzoNCj4+IDEuVXNlIGNvbnN0IHN0cnVjdCBpbm9kZSAqIGluc3Rl
YWQgb2Ygc3RydWN0IGlub2RlICoNCj4+IDIucmVwbGFjZSBzZ2lkIHN0cmlwIHdpdGggaW5vZGVf
c2dpZF9zdHJpcCBpbiBhIHNpbmdsZSBwYXRjaA0KPj4gICBmcy9pbm9kZS5jICAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+ICAgaW5jbHVkZS9saW51eC9mcy5oIHwgIDMg
KystDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMNCj4+IGluZGV4
IDlkOWI0MjI1MDRkMS4uMWI1NjlhZDg4MmNlIDEwMDY0NA0KPj4gLS0tIGEvZnMvaW5vZGUuYw0K
Pj4gKysrIGIvZnMvaW5vZGUuYw0KPj4gQEAgLTIyNDYsMTAgKzIyNDYsOCBAQCB2b2lkIGlub2Rl
X2luaXRfb3duZXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5v
ZGUgKmlub2RlLA0KPj4gICAJCS8qIERpcmVjdG9yaWVzIGFyZSBzcGVjaWFsLCBhbmQgYWx3YXlz
IGluaGVyaXQgU19JU0dJRCAqLw0KPj4gICAJCWlmIChTX0lTRElSKG1vZGUpKQ0KPj4gICAJCQlt
b2RlIHw9IFNfSVNHSUQ7DQo+PiAtCQllbHNlIGlmICgobW9kZSYgIChTX0lTR0lEIHwgU19JWEdS
UCkpID09IChTX0lTR0lEIHwgU19JWEdSUCkmJg0KPj4gLQkJCSAhaW5fZ3JvdXBfcChpX2dpZF9p
bnRvX21udChtbnRfdXNlcm5zLCBkaXIpKSYmDQo+PiAtCQkJICFjYXBhYmxlX3dydF9pbm9kZV91
aWRnaWQobW50X3VzZXJucywgZGlyLCBDQVBfRlNFVElEKSkNCj4+IC0JCQltb2RlJj0gflNfSVNH
SUQ7DQo+PiArCQllbHNlDQo+PiArCQkJaW5vZGVfc2dpZF9zdHJpcChtbnRfdXNlcm5zLCBkaXIs
Jm1vZGUpOw0KPj4gICAJfSBlbHNlDQo+PiAgIAkJaW5vZGVfZnNnaWRfc2V0KGlub2RlLCBtbnRf
dXNlcm5zKTsNCj4+ICAgCWlub2RlLT5pX21vZGUgPSBtb2RlOw0KPj4gQEAgLTI0MDUsMyArMjQw
MywyMSBAQCBzdHJ1Y3QgdGltZXNwZWM2NCBjdXJyZW50X3RpbWUoc3RydWN0IGlub2RlICppbm9k
ZSkNCj4+ICAgCXJldHVybiB0aW1lc3RhbXBfdHJ1bmNhdGUobm93LCBpbm9kZSk7DQo+PiAgIH0N
Cj4+ICAgRVhQT1JUX1NZTUJPTChjdXJyZW50X3RpbWUpOw0KPj4gKw0KPj4gK3ZvaWQgaW5vZGVf
c2dpZF9zdHJpcChzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsDQo+PiArCQkgICAg
ICBjb25zdCBzdHJ1Y3QgaW5vZGUgKmRpciwgdW1vZGVfdCAqbW9kZSkNCj4+ICt7DQo+PiArCWlm
ICghZGlyIHx8ICEoZGlyLT5pX21vZGUmICBTX0lTR0lEKSkNCj4+ICsJCXJldHVybjsNCj4+ICsJ
aWYgKCgqbW9kZSYgIChTX0lTR0lEIHwgU19JWEdSUCkpICE9IChTX0lTR0lEIHwgU19JWEdSUCkp
DQo+PiArCQlyZXR1cm47DQo+PiArCWlmIChTX0lTRElSKCptb2RlKSkNCj4+ICsJCXJldHVybjsN
Cj4NCj4gSSdkIHBsYWNlIHRoYXQgY2hlY2sgZmlyc3QgYXMgdGhpcyB3aG9sZSBmdW5jdGlvbiBp
cyByZWFsbHkgb25seQ0KPiByZWxldmFudCBmb3Igbm9uLWRpcmVjdG9yaWVzLg0KU291bmQgcmVh
c29uYWJsZS4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+DQo+IE90aGVyd2lzZSBJIGNhbiBs
aXZlIHdpdGggKm1vZGUgYmVpbmcgYSBwb2ludGVyIGFsdGhvdWdoIEkgc3RpbGwgZmluZA0KPiB0
aGlzIHVucGxlYXNhbnQgQVBJIHdpc2UgYnV0IHRoZSBiaWtlc2hlZCBkb2VzIGl0J3Mgam9iIHdp
dGhvdXQgaGF2aW5nDQo+IG15IGNvbG9yLiA6KQ0KPg0KPiBJJ2QgbGlrZSB0byBkbyBzb21lIGdv
b2QgdGVzdGluZyBvbiB0aGlzLg0KPg0KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgKE1p
Y3Jvc29mdCk8YnJhdW5lckBrZXJuZWwub3JnPg0K
