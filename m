Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063250F97A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiDZKDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDZKCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:02:41 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93EBE0;
        Tue, 26 Apr 2022 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650964937; x=1682500937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2DJ/O5DSlbizKA2Vd0Dv1vXjWVWHVCR/5rg7FB3eGlA=;
  b=m6mitETzv3b8Sc0u2PvB2z4aFvY7APAyNW4UjYqdG+K0GPx+abI5IZnH
   XvWAG1TNY64UOQoW159xNiENjj313yEUStAOot0kq2oPXWeEXh8tqt7l5
   9WGmRiCP+du7bWCqWOC2T9RdKvJ4GcPgXlrvVBbtoEdSAy76H1bVKvPt7
   O+x8xzTST1Jc2eitrv7Ka4NXb9o/Z+tvQn3tqY+Ozc6uzjRxw2c84HCMu
   M79AdLR8RefG5OqkGgXMKxS8PfziQzgXC4yZRk2nONJqGKzlm6vCog8w4
   r+nTuXKK/4Cp4asah1ld2lWcXUjazMZ/LrbA+oeLqGTgYd7iSSK60isrl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="62764646"
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; 
   d="scan'208";a="62764646"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 18:22:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkJJ9uoiKL6EdiSJNK67f2q3U/y5mcU4A/kjhYwP0Y3upRN9o9CcG1uTiGG04pMzhzkfFf25iV5wP4JOfBl+SNhNUqXA5QoKDBiu8Y0JUZr2ZL7WI07wvnHtwcCdG18J2AOLgQ0d7Wdwd+8Yx6ITOHZPNgkocbzkaUBgpyfh44clZLFBChJTwCkVROHfp4Xm2jjfnIBECz2bzCUwcAi4XOHsjWS5VktxC3JWAYvMPPvx1Jr539b8vZo7RyTFeAQG/6RWboeoQd8Jplnq9AmUK1OUs2dfcjSyZR3hEkzFqg77ODgDjnvs7LnI8kCKhRdfzhMdParEKSEc4cufKkduIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DJ/O5DSlbizKA2Vd0Dv1vXjWVWHVCR/5rg7FB3eGlA=;
 b=NyYssWS57GiBl5QiFuK+D5LBWFzmmPJxrE29/PEMd6w+uDon+WWhj627zrrKdJA7nXqVkrdqg6P9vKVfhDoIpmjeH/g2MLFtK6mYW8Pwc+csmri/2roKkH8aDJVh8Uxz5M//dqCTCrdOGUDFJy4L3cred8K6IHDNha8FmYa2H9tXHZrgax9UYbLFC6Y54qMoOC++4uQMl03Bkj/Z7LaTMZkYTbvQbkM3Zhcq1hCv/cK9Ao/sK2PkXC3ZWFA8ewVtEW2iJQUFp0STXfWpe7fwLduhBEthd/Kfv1WxpaN/NGBDRluhpdjnmDrpwtwqk90vVOu3n9OnIYpCA9NfiIeeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DJ/O5DSlbizKA2Vd0Dv1vXjWVWHVCR/5rg7FB3eGlA=;
 b=Z7kN0XvL+2uKHqi7ACUPVmqhzEZQrQ2hTcWKCNgpjOdPt2O9UfImG5EJNVW6PblHmI72ld1Hwrsfs3NO7qVPqZG5vDnoWhdiBqEgTR7CWFVnheK42HZuql0tKY+EreWDlkrTw4RRPS1BF7sLlu/1jp/dT64d2gBn/wO2fv42vbs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5754.jpnprd01.prod.outlook.com (2603:1096:404:8059::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 09:22:09 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 09:22:09 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v7 1/4] fs: move sgid stripping operation from
 inode_init_owner into mode_strip_sgid
Thread-Topic: [PATCH v7 1/4] fs: move sgid stripping operation from
 inode_init_owner into mode_strip_sgid
Thread-Index: AQHYWRxiXlzZQzop/keBoP18JzYMnK0BxisAgAAaNID///+2gIAAHRIA
Date:   Tue, 26 Apr 2022 09:22:08 +0000
Message-ID: <6267C828.3040907@fujitsu.com>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426070648.3k6dahljcjhpggur@wittgenstein> <6267B003.3050602@fujitsu.com>
 <20220426083933.74jjezusejrpsi6z@wittgenstein>
In-Reply-To: <20220426083933.74jjezusejrpsi6z@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def0ec25-a0d9-4ba8-eccb-08da27663cf7
x-ms-traffictypediagnostic: TYAPR01MB5754:EE_
x-microsoft-antispam-prvs: <TYAPR01MB575429A5A221943542ECAEACFDFB9@TYAPR01MB5754.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2tb7sQeti+JXkyDjzul++p3Hxa4schQCfqOMNFobvWXeOdZueXFnPkEAe+jgMKZlDkwthNfla5LCVvsmCSjGbwQrysCnVhHY+h6hBa9eR//KdcEITObMnzIro03CUDK1K717Irv3fd9FKXwLqN6tPxSUuZLWrE/qAYAwyJiMesmBAlf3qIDNKGrbU8IxaCTsmbRd8NjoBj3eAUKvqQNH221fPFzCV/PxsUv+3GCSNuu8ddGlpWFCcahyUkWN9qhBpSqyIGJEKRaRwhgpFinAI/9ogh9pjP/7SM0OVRKY6Xqz0FAdKUXjsS0SPQn5pYMgRhS1OAwxXi61HV+4ReXUDs9TNE0w+wkfKOcCVIv5bsX78VcuhzbmXFyyKYQJiDFxK78FLua4uiPoHYEgowNXrwUT6MGFlwPZiJhctWjLcvXJN7rJvpMkivVB73T7bJMjiUNgksMJbhRlvfoo7EOAAv7qgCrMkLUSWOdB9QRqwvaHWMLu+W6YF+Ca2L2+IcUMH8doB2DhgA74dN2vuFyNPzZiUYbsvZwXTr/igXOb5RPEMuh0xeqzyB9WnYcW0vDG5VU1YKG41nVEVqGRpFW658QBhqYnIEW3ARPZexe3SaOsaaLLKJRdxmv6maGCebWg5CnOrLGmVWhAlF4X5Hd/9fLzi4g02lVhq9n3am9GMQL36f7J3hEPhwzfiqjoQu1BH5IWfT707Dahz6WuuitrXxu5r66EiRpKzUFyhfEk0E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(38100700002)(316002)(76116006)(87266011)(64756008)(8936002)(82960400001)(508600001)(83380400001)(6486002)(2906002)(4326008)(45080400002)(86362001)(36756003)(66476007)(54906003)(66946007)(8676002)(66446008)(38070700005)(66556008)(71200400001)(91956017)(2616005)(85182001)(186003)(33656002)(5660300002)(26005)(6512007)(6506007)(122000001)(168613001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnJaZW1aWmVmUjk0Qnc2ODZsY1FhcWFjeFYwRCsxR29pSm9HbkhQTGRSTlNH?=
 =?utf-8?B?UkpQYnhjdTZWUklVWENCZnQrZTJ5bkxCc3owYTJRSEw3VnhxbStsM0hqL2JM?=
 =?utf-8?B?cVJOSXNmbnFSK2dxSVF2dGZDNWJtRGFRbmMzME84b2l1dXgzNnM2Nit5WnR4?=
 =?utf-8?B?NTJLZjQ1TEZ1ckpRdXE4eEJFSlp6SENDaFFKdGVHOGpsSEhvVVRnV0FOa0d3?=
 =?utf-8?B?dWVKalJjQlRlc1YxSzZ2bkRJT1ZwL2QrcndnalRQVHpwMG1pZ1IrdHByYzFI?=
 =?utf-8?B?RjV5T1FkektoK1hybmpaVFpVcmVYejErbjNUNXNHaEVPajJVVWtIaW9jdSt6?=
 =?utf-8?B?YkxnN3J6b1pSTU9zTDBOQTRZMTZDeGNMc2NjZ2tMak1ZTDdoYnNjNVZQdy9N?=
 =?utf-8?B?ZXVZNHZaSCtEbVVnRUJJUmdRTnQyQW1BL0U5MDhpSmhER29IcTFLd3hxWi9x?=
 =?utf-8?B?cms4b1k3YnBRMXExU0FFKzVSVmF4ZmVjckw0bis5VEUrSjYwUHBnMEJBZ3NK?=
 =?utf-8?B?Nkpic3pLOGIxNUR1czFlNkVvM0ZVVFg2YmRZM3d5VHhrTUFmSnYrY2tSeDRW?=
 =?utf-8?B?QTcvdlpINDhMSEs5T1g2WnN1VjhHSEpTSm9yOFgzM1lhWTA4bVVZK3JUUk4z?=
 =?utf-8?B?My9lWExDVGMrQlloN1FabUdtWThzYlYzNkFaMXB1b05HS0hEZjF5TTdieXlF?=
 =?utf-8?B?dzhMelUwZ2pINW1iOW00Z2VkcmdkeUJWdkdsL0FmbnNjSnR2aHEwOTBkeUFi?=
 =?utf-8?B?M3o5SHdLblNiYXpRclVqT1NacEcraXJGdlNHZnB6cVM5RVZvVXZQc0gydFFZ?=
 =?utf-8?B?WFFKZk1vU0R2ZFpCTE1rQ2JLS1g3QVBNUzU1ZU5OMVBtQWhUZlMwbmpDRHZh?=
 =?utf-8?B?QW9VU0VlVzdoY3ozRlFJZ2lVYjhsQ1R2b3YvcnVOY0F3UUVMTldxVC92L2Fw?=
 =?utf-8?B?WDQ0a0hEdEQ1KzhiM2xhNkNFTGNQdEhZMVY0UDcva1dJaThRb1FzMkJXeXdO?=
 =?utf-8?B?YkZ5bm9pRkx1VzY3ME8yVjB5QkJGNjJkNHVDYkhxTll3QURJVENFQzFuRkZm?=
 =?utf-8?B?ZERBN01NSXlueno0OHl2c3dRSytyQkVuVW5qRDBWTFVEa0VZalJMbFNCMW1B?=
 =?utf-8?B?b2VIWlF2VmZ1eERWd1lTN3NyWjhLMXRFUnl0bmVNZSt6YjFYVlV0OGVYcy9C?=
 =?utf-8?B?dFg5aDBhUUgySFVuZ1M5MWhsQTBKYktWOFRyTXJGU3NjTHJndXVQQjFXTCt5?=
 =?utf-8?B?bEIvcUlOaVZqRW1jV20zRHVGelM2OFFrVk14ZTRCMDRkTW5OaG1TYmVtajJi?=
 =?utf-8?B?c2tqZ1NWTDRkQ1BuZEpTd3d4S3NaYzhNOVlLZXpBSUFLVE8vNWpPdVZzanN2?=
 =?utf-8?B?Z3R5MkVNL01WOVB5c3NuN3VzZ0FZUG4zZU1aaTFDWGJGZjBIekZlQWZySFN4?=
 =?utf-8?B?N3VkNzhJNitmcDMzUHF1QWpxZzlmN3hMa1R1UDBLOS9hbHBxUDAyTWNxbThx?=
 =?utf-8?B?djNVMXREK3Q0K0VVWElsWWsyN3c4cldvSGJKaTBrQ3pVaGhoMmw5MzlLTmJN?=
 =?utf-8?B?YjV5SndrcHhoOXNTUHRweEY0THNLK1MzRnI2UWw2T2NFZXFaRWxYZEc3NEoy?=
 =?utf-8?B?V1gvWGFuaWo0N08yMDBtb2lwaW9BWTRtenlrQnlaQzBHVVpIYU9Kd0VVdFBt?=
 =?utf-8?B?QSthbjg5aDE1aEZEYklaenVCdm9Oak9YZDNkR0FJZlBxS3ZOS25xL2ZVUHIx?=
 =?utf-8?B?N1JtNjNXWnQzNW5pNHpha1UzRkQreVp6ODJEa1VDeFhublk1WHpzZFEvMnRO?=
 =?utf-8?B?ZWpxVE1vWVh1OEdYVzJJUVFQamozQmFUeURKcmVXd1VlWmpJRHpsWllHQXBk?=
 =?utf-8?B?dmdwWVU0Z2ZtWXRLWFF3S3E0NWpQZC81cnJwTkIxYkxub0MyYnRlTTZubFJw?=
 =?utf-8?B?K0t4UUpqeHg4ZkRVSkE0a1FOOTVCMytwWVJXTEhCWEtrZkFiSnlPVnJhNHRl?=
 =?utf-8?B?cjdFazcwUkc2SU9QSmpPWElTTUZSaVV2eVBlRW9QeDBpd1VqM2t0dzhRYzFB?=
 =?utf-8?B?b0gzcCt5U1NPRDJYclR5WGZWYlhuaVlLTzVpYUlLeTV1YjhscEJDT1VHQ3Mw?=
 =?utf-8?B?YzBSdzgxbjhkK2RvV01vR0UwZ0Nub3NXcWsxaEg4Q21CSnozaHIwL0x3Qksw?=
 =?utf-8?B?U083VmlSNjVFODlpeHl5WTJWUnErM2NPRnhkM0xudW81ZjBUWG5FOWJUU2Rs?=
 =?utf-8?B?NVJWanZWWVR3TGpJYmQrVUZ6NXVDQkVtZUNWMmUzREYyNnN1MllxMlZpWS8w?=
 =?utf-8?B?bXQzSzY1WWl6MHJ6MzJVTkhEbWQ0ZFhrVDV0Mjc4dHB3aGphYXptZ0ZrMDRZ?=
 =?utf-8?Q?TIBIMjlzV8RsFjXPVz2Thmt6G2wkYGf7WLhW6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1B461AFB43875429031E09D71AF3259@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def0ec25-a0d9-4ba8-eccb-08da27663cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 09:22:08.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5xBdqrVoNdmXH+jPpoiRKVNc23j76gvWAftIQSAEDCAyUoe/bojNSVLoSoLSYWlhNgJcmFB4vAA+5EBhHm5Zsv0IQJv3sgiZHzcy+Um0rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5754
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI2IDE2OjM5LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMDc6Mzk6MDdBTSArMDAwMCwgeHV5YW5nMjAxOC5qeUBmdWppdHN1LmNv
bSB3cm90ZToNCj4+IG9uIDIwMjIvNC8yNiAxNTowNiwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6
DQo+Pj4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTI6MTk6NDlQTSArMDgwMCwgWWFuZyBYdSB3
cm90ZToNCj4+Pj4gVGhpcyBoYXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuIEp1c3QgY3JlYXRlIGFu
ZCBleHBvcnQgbW9kZV9zdHJpcF9zZ2lkDQo+Pj4+IGFwaSBmb3IgdGhlIHN1YnNlcXVlbnQgcGF0
Y2guIFRoaXMgZnVuY3Rpb24gaXMgdXNlZCB0byBzdHJpcCBTX0lTR0lEIG1vZGUNCj4+Pj4gd2hl
biBpbml0IGEgbmV3IGlub2RlLg0KPj4+Pg0KPj4+PiBSZXZpZXdlZC1ieTogRGFycmljayBKLiBX
b25nPGRqd29uZ0BrZXJuZWwub3JnPg0KPj4+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEJyYXVu
ZXIgKE1pY3Jvc29mdCk8YnJhdW5lckBrZXJuZWwub3JnPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZ
YW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+Pj4+IC0tLQ0KPj4+DQo+Pj4gU2lu
Y2UgdGhpcyBpcyBhIHZlcnkgc2Vuc2l0aXZlIHBhdGNoIHNlcmllcyBJIHRoaW5rIHdlIG5lZWQg
dG8gYmUNCj4+PiBhbm5veWluZ2x5IHBlZGFudGljIGFib3V0IHRoZSBjb21taXQgbWVzc2FnZXMu
IFRoaXMgaXMgcmVhbGx5IG9ubHkNCj4+PiBuZWNlc3NhcnkgYmVjYXVzZSBvZiB0aGUgbmF0dXJl
IG9mIHRoZXNlIGNoYW5nZXMgc28geW91J2xsIGZvcmdpdmUgbWUNCj4+PiBmb3IgYmVpbmcgcmVh
bGx5IGFubm95aW5nIGFib3V0IHRoaXMuIEhlcmUncyB3aGF0IEknZCBjaGFuZ2UgdGhlIGNvbW1p
dA0KPj4+IG1lc3NhZ2UgdG86DQo+Pj4NCj4+PiBmczogYWRkIG1vZGVfc3RyaXBfc2dpZCgpIGhl
bHBlcg0KPj4+DQo+Pj4gQWRkIGEgZGVkaWNhdGVkIGhlbHBlciB0byBoYW5kbGUgdGhlIHNldGdp
ZCBiaXQgd2hlbiBjcmVhdGluZyBhIG5ldyBmaWxlDQo+Pj4gaW4gYSBzZXRnaWQgZGlyZWN0b3J5
LiBUaGlzIGlzIGEgcHJlcGFyYXRvcnkgcGF0Y2ggZm9yIG1vdmluZyBzZXRnaWQNCj4+PiBzdHJp
cHBpbmcgaW50byB0aGUgdmZzLiBUaGUgcGF0Y2ggY29udGFpbnMgbm8gZnVuY3Rpb25hbCBjaGFu
Z2VzLg0KPj4+DQo+Pj4gQ3VycmVudGx5IHRoZSBzZXRnaWQgc3RyaXBwaW5nIGxvZ2ljIGlzIG9w
ZW4tY29kZWQgZGlyZWN0bHkgaW4NCj4+PiBpbm9kZV9pbml0X293bmVyKCkgYW5kIHRoZSBpbmRp
dmlkdWFsIGZpbGVzeXN0ZW1zIGFyZSByZXNwb25zaWJsZSBmb3INCj4+PiBoYW5kbGluZyBzZXRn
aWQgaW5oZXJpdGFuY2UuIFNpbmNlIHRoaXMgaGFzIHByb3ZlbiB0byBiZSBicml0dGxlIGFzDQo+
Pj4gZXZpZGVuY2VkIGJ5IG9sZCBpc3N1ZXMgd2UgdW5jb3ZlcmVkIG92ZXIgdGhlIGxhc3QgbW9u
dGhzIChzZWUgWzFdIHRvDQo+Pj4gWzNdIGJlbG93KSB3ZSB3aWxsIHRyeSB0byBtb3ZlIHRoaXMg
bG9naWMgaW50byB0aGUgdmZzLg0KPj4+DQo+Pj4gTGluazogZTAxNGYzN2RiMWEyICgieGZzOiB1
c2Ugc2V0YXR0cl9jb3B5IHRvIHNldCB2ZnMgaW5vZGUgYXR0cmlidXRlcyIgWzFdDQo+Pj4gTGlu
azogMDFlYTE3M2UxMDNlICgieGZzOiBmaXggdXAgbm9uLWRpcmVjdG9yeSBjcmVhdGlvbiBpbiBT
R0lEIGRpcmVjdG9yaWVzIikgWzJdDQo+Pj4gTGluazogZmQ4NGJmZGRkZDE2ICgiY2VwaDogZml4
IHVwIG5vbi1kaXJlY3RvcnkgY3JlYXRpb24gaW4gU0dJRCBkaXJlY3RvcmllcyIpIFszXQ0KPj4N
Cj4+IFRoaXMgc2VlbXMgYmV0dGVyLCB0aGFua3MuDQo+Pg0KPj4gcHM6IFNvcnJ5LCBmb3JnaXZl
IG15IHBvb3IgYWJpbGl0eSBmb3Igd3JpdGUgdGhpcy4NCj4NCj4gVGhpcyByZWFsbHkgaXNuJ3Qg
YW55IGNvbW1lbnQgb24geW91ciBhYmlsaXR5IHRvIHdyaXRlIHRoaXMhIEkgdHJpZWQgdG8NCj4g
bWFrZSB0aGlzIGNsZWFyIGJ1dCBJIG9idmlvdXNseSBmYWlsZWQuDQo+DQo+IEl0IGlzIHJlYWxs
eSBqdXN0IHRoYXQgdGhpcyBoYXMgYW4gYXNzb2NpYXRlZCBub24temVybyByZWdyZXNzaW9uIHJp
c2sNCj4gYW5kIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRvIGhpZ2hsaWdodCB0aGlzIGFuZCBiZSB2
ZXJ5IGNsZWFyIGFib3V0IHRoZQ0KPiBtb3RpdmF0aW9uIGZvciB0aGlzIGNoYW5nZS4gU28gaXQn
cyBlcXVhbCBwYXJ0cyBwZWRhbnRyeSBhbmQgdHJ5aW5nIHRvDQo+IGtlZXAgb3VyIG93biBoZWFk
cyBvZmYgdGhlIGd1aWxsb3RpbmUuDQoNClVuZGVyc3RhbmQuIFNvIGRvIHlvdSBoYXZlIG90aGVy
IGNvbW1lbnRzPyBJIHBsYW4gdG8gc2VuZCBhIHY4KGJhc2VkIG9uIA0KNS4xOC1yYzQpLg0K
