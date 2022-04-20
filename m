Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1991507DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 03:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358684AbiDTBPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiDTBPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:15:00 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6818E22;
        Tue, 19 Apr 2022 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650417136; x=1681953136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8QbU6+VIAuCYczDMhdelrb+mJl6ir8oP1Fz7JNZgwbY=;
  b=C0SC/Yj18YcM1Pdhj6HBRLyKgWGIwK78lm3HC0zoHXIdKUfrw5jNOLoK
   3vrUYp/vhFCO8nZMfyFCYqp5egksRIu8vZI4FfxmK6j2yyPpmh5QmU2Wq
   qEFZp+IZPJR8KXciT0cJk/j+0xGQjOoKzVDBuWR81ZlMPAa0+MCt9K2aV
   KEYXSF0okCIYc9nTZK1AGYJycvr5/cT3Q+j9260eQFmX2f0TatrTN9xgR
   RY6z+fysfwtLb0P0h3nqCVB0+BdlZf07D466fK0iobDCM9hvheE0FGi1s
   +f47aeIwd8WN/YuY4HIY8GU7y8iJDHXK9zopCbbPjjbb2Aqk56ec+p0xI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="54269785"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="54269785"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:12:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPNtln7WrkpnN/S1sU62/IqNqScm0qYRugawaCVZhRG13n3Sm1GTGWBj4KmgG6dm6kzXvTBgCm07/42YueLWjI8lu4INX/KgxAHzhHPNOOdoDlb20Dp5frGD+WeKdKvARQgCoL80fnD91L788ylIfOslEpkqlNxZTPzvMMlxlR9j7StVabK+TD6cObYCrBbeEXbUIwk6wFaDophPFjEEJszh7dQ9LY2GVLFDuyF8FY51w5glv3Udpul03hVNPeu0o6DfYnibVawRuZr1JGk4yvOt6wyZt7e2lgklBgkcFFdGn5ZxhIr4W2IbuSgTjhuryh2fv6V3VuUEUTHCCvLv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QbU6+VIAuCYczDMhdelrb+mJl6ir8oP1Fz7JNZgwbY=;
 b=NoEWXJ65IU5j2vorT/fhjApiPY+e4WQkgm4fsY+Dhxlxhqu9fpEPWhI/+eYSvKUoRmwPXusVnr5KVP0uUbwXpsGNHMRuOhLmFIICapyCBYkBYHFzb53BN+X1gtWgExRitd0nwsPJPEineEMYxQ9llUl8ny3mI6iKvynDTLG+cNf9JHHtoXkgdiJJw6x9DdwgAK52W+FSN/nEG1T9la/PmgYAJw89Vf7nrIuOKlIO35zE+3qcPudO/guAx8WcFOfXY0fSL/QK2MWMufBHJWMVJIDm//KFCYUa8NAHo8OwX2uNDic2rSkyeiJAIAEHP0RgKKyfSBrkn7gS4GreFXghBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QbU6+VIAuCYczDMhdelrb+mJl6ir8oP1Fz7JNZgwbY=;
 b=dD8O9xTvwNiXojHIiDOjbBaabz10STZcA2Uaxf/deT9JJppXhPScGXamjg2PW2M68VQxdJguUvf0praYN92IMBAvPliqe+yauMXVn42ZHpfxYs3NcCfrT8kH+XqY57//KIezEkcPLYMs0nenVTGrisY+Rvu5VZqBJGsGDJoNATY=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB2327.jpnprd01.prod.outlook.com (2603:1096:604:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 01:12:05 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 01:12:05 +0000
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
Subject: Re: [PATCH v4 3/8] xfs: only call posix_acl_create under
 CONFIG_XFS_POSIX_ACL
Thread-Topic: [PATCH v4 3/8] xfs: only call posix_acl_create under
 CONFIG_XFS_POSIX_ACL
Thread-Index: AQHYU9rQ1RyFOxEMHEKdCE0i0JLGpaz3QeCAgADO0YA=
Date:   Wed, 20 Apr 2022 01:12:04 +0000
Message-ID: <625F6C3F.1040308@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419135305.7vztxq5mld5jynt5@wittgenstein>
In-Reply-To: <20220419135305.7vztxq5mld5jynt5@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e4d3b8c-6bf3-45ae-f1cd-08da226ac865
x-ms-traffictypediagnostic: OSBPR01MB2327:EE_
x-microsoft-antispam-prvs: <OSBPR01MB23274BB5C5DDF55F91216EA1FDF59@OSBPR01MB2327.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E54VF5UbTlShbAmjCgPqTBe0L28m7yfiz5dVNC8719/Upr517woLw7LunzIbhbsQCkvJTDpr5mKMb9nr4SiSjYVksi5A6s0cLdGGgMxQlB99BIpwj2espKhElX33pwCd8MtunVVAFMq+NjUMC2GxpjeeaOTAnPMEPFFC0cn/T9wY5L8LaGRTBWYPrkrhDZ7vENa0ipN5XH/QWz97yJ4cEp7CZcvxp7IgSDroOpMBnhWSiacQyjcsYq1tDqdcbdHtUvb6magGSjEe7yUt8t8x5YAIUMBlzRqmHfr9AUzSvODI9EBkcLXKNv4uhyb+OxTCANsHdqvgopEsiQzIqbEMUiFCkrO43JcwA2Tlpza5S3fKvUICiMUm3dog27jE8T+P9+MKB8hNrCoTlG5MFuC9wBuIt4Z5pZYR2pL6g0ZSaJRSx0rtEkG7RqBUjMUQTNve/AECwcr2FA4JNT5yViRKfw6FK3+JrfwnTYyHypVanQv4I2vi29/bggmMSZm4pMyjmhuU7qljTlH69GF3GOySAk/yu0HvSEqooFLFMjmT8Y1BRdTN1tNvZlWjJP6UYVEh1p/zLkq6qyBrXM05IDcBR6vWh81cX0BsjEkL4P8UWdH1204zbYHTGTbC9jReMDXRr82s9MMyL/zUKKy2xZUYwkmJ2Sit3L1JgfsNnliAX5SNqPQWaV5enD4GTDQGynP31LwSOOmov6lrDVLHTEErkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(91956017)(186003)(7416002)(316002)(8936002)(82960400001)(71200400001)(76116006)(86362001)(2616005)(66446008)(66946007)(66476007)(66556008)(64756008)(4326008)(83380400001)(8676002)(6512007)(5660300002)(508600001)(38070700005)(26005)(36756003)(6506007)(87266011)(38100700002)(2906002)(85182001)(122000001)(6486002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGFIeXJBcVU2QkpCY2FDZWNlUmgxSjcxYkxIN3hLV1NwVTFkNndUUzRsdm1z?=
 =?utf-8?B?dE1aOVFPdUFSOUtoUVZ6dDdGZU16QVVhTnBBSTR4dkdEcG9qSWFEUXNWSUdD?=
 =?utf-8?B?b21jTkF4TXhxL01GY3hqY3JOM09hNUprUUlRUm43NW4wKzhpamxLQ01rTzZB?=
 =?utf-8?B?MEpsdEZoRkZKQ0NTUFFlNFBWVnhwQS8vUE5FcXlHWWVETVF5Y2ttNmp0NXJs?=
 =?utf-8?B?ZVI1U2JPaExlUXVWVUpyL2R4ZWhYWmNVdEpyWjRlRFVJbW5XTm1KenpmSDVj?=
 =?utf-8?B?cllndjdSUiszUnh5ZmhSMkVoTU55U1gyYmNYZU5WczVBc1JueW9VMmNpZzBa?=
 =?utf-8?B?bVZRMmdvWHluM2VGYlJLS3hjVUxXVEZOR3ExR2paTUlLRCtUQUZSN1BTRnly?=
 =?utf-8?B?VFVEcDVzKy9aSm5HTFlFdUxINjdNNGUrRWlDUFRSd2J5UjN4clN6cVVOVW5y?=
 =?utf-8?B?NFRObVhMT3FkQ1BoclMvOWd1aHNRZlhEL3lYRWVoZFI0bHJOYmV3YmRBWUJV?=
 =?utf-8?B?UERIRXBkSHpibmdsS21tN1FqZXVydHY3cWQvTjF2ZWpwak5rNDdpS0s1anpY?=
 =?utf-8?B?bXJDODJrd0ZtS2tROG56cnZuK2szbGZhU3hPRlVHMEcrL1UyUnhNTGlHYXBk?=
 =?utf-8?B?bTg5ZFdXNysxM2ZUTXY5N2NPTUpWUTNaYXY5Tjc0Nnc2d3RVZW55NU5YMm84?=
 =?utf-8?B?d2hWVWl1aDc4VTN1RHZRenRCVGs0bjAzbkhXeE4xYmg3Tmd0V2kybmFCdGQ0?=
 =?utf-8?B?US9vL2lMZW1ROUhGYTVXZmVDVnVJaTQ4cXlwcC9ZRTlQeEhVL2xsQnM5RnlL?=
 =?utf-8?B?T2VoTXNCZ3d2V1VmQXRRbmUySHZYQkdDMUwzdWZ1VjdhY2s4RkZWY2FMUUFF?=
 =?utf-8?B?RjZYZ3V6OEJ4dmhTRXYwYnhVbXdvY2FXY0o5Z1hVRWkzMnZSZzJTdkhZNnl1?=
 =?utf-8?B?MFBiVTBqd1ZBcEsySUFyY2Nlb3l1NU54bFl0RTZRTkYxNmQ2WU5UL3ZGSEN6?=
 =?utf-8?B?THNCdndjenA5dU5BdGJvcFhLNVN6UE13NncxVVZUZUxhdUdjYjdnajF0cHg0?=
 =?utf-8?B?SmU3eEVabjN0SFRTOGg0SUdEL1hsYWZoL1puNXVGSWp3NVJQenYzL1d4NS9k?=
 =?utf-8?B?Q25Wam82TVZtcmVTQlZMUlNEMmk4c1R1YytmcnpUbDRWZ1B0TWhYNEFHTGtl?=
 =?utf-8?B?NE52TkszTkNvc1FWL1pJY0RQcDRNRUZydEE1TGxrVDZMS3p0YnRXeWhRbEZN?=
 =?utf-8?B?ZFZjMWptYUxBSWo3RjJGeW9qVzZVa3BNcWFxMWhtNTlqV3JBREdpQmZ4M1FM?=
 =?utf-8?B?QU1YSWliZmh3U3FIT0RKUWN6eXhCRHAzSUVxY3RMTGFrbjY0UnFwNUt3VkRq?=
 =?utf-8?B?dzBzZHE4Y0tPSVJLcng3Qk5ITTJpak0wWG1PcFZFekJSb3ArZzU0bWVEc3Fa?=
 =?utf-8?B?c2FpN0JXV2hJQ3AvTjI3Y0ZTQTh0cjJVOHVZNlo0V2x0ZE5XdS8zbzl5MEFJ?=
 =?utf-8?B?L29RYkpjbzczUXg0VGM2dUJTRGxsZ0tkZU1LSXRibTFCWkl0NllmSC9taDhq?=
 =?utf-8?B?UXRWMlFGalZBOVllZXVGcUFzK0pjTHgxK1RGRk94NU1GNU5aNTBmTUlPS09i?=
 =?utf-8?B?V2t6ZG1tQktEYVFkMjZzYWluZDBmc3JXWjdlRi9uTExrcVhZY1VyVWhzREV6?=
 =?utf-8?B?Tm15RHpqN21XeWx6b2VhbUdURy9EMlZ4MmFmbXVySUd3MUIxWUNrbmRqREp2?=
 =?utf-8?B?TmVwUnVESFFrZUI2a0JVelZveFBQLzBGUXp1QUVyRTZ2K0c3RTBvT1prZER2?=
 =?utf-8?B?R0lza25QZjVpMllaeXRtWUJWSUtVL2pOYmRBZ0V5dmxJdTB0Zy85WTNqdGVm?=
 =?utf-8?B?aVE2RWRJVnFPaHRhVmpPL1VDT2RyS2s1U3pPYVBFbllQR2laNFJwZUk5SVlD?=
 =?utf-8?B?K1BtZE1qcUYzeWhmS0xIelFmNUdWdWJFcnY4ZzdxWmdIclFvcHY4eVJ0M24x?=
 =?utf-8?B?ME14cUlMRGdjckRCS2svdTlEUzgwTmdoSVJTaEszZXkyd2tZanJNcVl0czFJ?=
 =?utf-8?B?Yk1DNUJvYi9lZGtZTEFaM1FKMVV0bnJuWFloaUhBRGN3Q0lzbmxNVisvb3hS?=
 =?utf-8?B?cUdpOElHUHo2L3k0Mnk0RmkvblZDMStjZ09pTEIzWTJ5Y1ExakVnTUQzelll?=
 =?utf-8?B?V0h6TlVwenk1cXZEQm9CZ2RpYndqdTh5WkxRdFRnNlJBdHl3MXZ1SndqT1FZ?=
 =?utf-8?B?WGVhUXJteW5mT3pUVU4vVlBtcFlmYWE2QzdNL1BudW9UZFZndU9UdzdqN3Rq?=
 =?utf-8?B?WmgwcHVMUjQrTnJZZXBaYlYxN0huRjRYUEdCVkJjRUp4NkVGeUJLZ1liN0x1?=
 =?utf-8?Q?7fgavEa4FA75sWBme7NSODEJlXjx9q3aMNtQe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84416A9CBF797F4A8BAC76E478B72786@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4d3b8c-6bf3-45ae-f1cd-08da226ac865
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 01:12:04.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6SRKlYqrvas2o4q6gpcA112U6UZG3y7DzHL/iAhhOpUEwfGF/x15MXLM5CChbSnHImZbJBP1MmkrLYN2+STl5456GJTww6QERJQTp1Jg2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2327
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE5IDIxOjUzLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTksIDIwMjIgYXQgMDc6NDc6MDlQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNl
IHhmc19nZW5lcmljX2NyZWF0ZSBvbmx5IGNhbGxzIHhmc19zZXRfYWNsIHdoZW4gZW5hYmxlIHRo
aXMga2NvbmZpZywgd2UNCj4+IGRvbid0IG5lZWQgdG8gY2FsbCBwb3NpeF9hY2xfY3JlYXRlIGZv
ciB0aGUgIUNPTkZJR19YRlNfUE9TSVhfQUNMIGNhc2UuDQo+Pg0KPj4gVGhlIHByZXZpb3VzIHBh
dGNoIGhhcyBhZGRlZCBtaXNzaW5nIHVtYXNrIHN0cmlwIGZvciB0bXBmaWxlLCBzbyBhbGwgY3Jl
YXRpb24NCj4+IHBhdGhzIGhhbmRsZSB1bWFzayBpbiB0aGUgdmZzIGRpcmVjdGx5IGlmIHRoZSBm
aWxlc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBvcg0KPj4gZW5hYmxlIFBPU0lYIEFDTHMuDQo+Pg0K
Pj4gU28ganVzdCBwdXQgdGhpcyBmdW5jdGlvbiB1bmRlciBDT05GSUdfWEZTX1BPU0lYX0FDTCBh
bmQgdW1hc2sgc3RyaXAgc3RpbGwgd29ya3MNCj4+IHdlbGwuDQo+Pg0KPj4gQWxzbyB1c2UgdW5p
ZmllZCBydWxlIGZvciBDT05GSUdfWEZTX1BPU0lYX0FDTCBpbiB0aGlzIGZpbGUsIHNvIHVzZSBJ
U19FTkFCTEVEIGluDQo+PiB4ZnNfZ2VuZXJpY19jcmVhdGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIGZzL3hm
cy94ZnNfaW9wcy5jIHwgNyArKysrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfaW9w
cy5jIGIvZnMveGZzL3hmc19pb3BzLmMNCj4+IGluZGV4IGIzNGU4ZTQzNDRhOC4uNmI4ZGY5YWIy
MTVhIDEwMDY0NA0KPj4gLS0tIGEvZnMveGZzL3hmc19pb3BzLmMNCj4+ICsrKyBiL2ZzL3hmcy94
ZnNfaW9wcy5jDQo+PiBAQCAtMTUwLDYgKzE1MCw3IEBAIHhmc19jcmVhdGVfbmVlZF94YXR0cigN
Cj4+ICAgCQlyZXR1cm4gdHJ1ZTsNCj4+ICAgCWlmIChkZWZhdWx0X2FjbCkNCj4+ICAgCQlyZXR1
cm4gdHJ1ZTsNCj4+ICsNCj4+ICAgI2lmIElTX0VOQUJMRUQoQ09ORklHX1NFQ1VSSVRZKQ0KPj4g
ICAJaWYgKGRpci0+aV9zYi0+c19zZWN1cml0eSkNCj4+ICAgCQlyZXR1cm4gdHJ1ZTsNCj4+IEBA
IC0xNjksNyArMTcwLDcgQEAgeGZzX2dlbmVyaWNfY3JlYXRlKA0KPj4gICB7DQo+PiAgIAlzdHJ1
Y3QgaW5vZGUJKmlub2RlOw0KPj4gICAJc3RydWN0IHhmc19pbm9kZSAqaXAgPSBOVUxMOw0KPj4g
LQlzdHJ1Y3QgcG9zaXhfYWNsICpkZWZhdWx0X2FjbCwgKmFjbDsNCj4+ICsJc3RydWN0IHBvc2l4
X2FjbCAqZGVmYXVsdF9hY2wgPSBOVUxMLCAqYWNsID0gTlVMTDsNCj4+ICAgCXN0cnVjdCB4ZnNf
bmFtZQluYW1lOw0KPj4gICAJaW50CQllcnJvcjsNCj4+DQo+PiBAQCAtMTg0LDkgKzE4NSwxMSBA
QCB4ZnNfZ2VuZXJpY19jcmVhdGUoDQo+PiAgIAkJcmRldiA9IDA7DQo+PiAgIAl9DQo+Pg0KPj4g
KyNpZiBJU19FTkFCTEVEKENPTkZJR19YRlNfUE9TSVhfQUNMKQ0KPj4gICAJZXJyb3IgPSBwb3Np
eF9hY2xfY3JlYXRlKGRpciwmbW9kZSwmZGVmYXVsdF9hY2wsJmFjbCk7DQo+PiAgIAlpZiAoZXJy
b3IpDQo+PiAgIAkJcmV0dXJuIGVycm9yOw0KPj4gKyNlbmRpZg0KPg0KPiBEb2VzIHRoaXMgYWN0
dWFsbHkgZml4IG9yIGltcHJvdmUgYW55dGhpbmc/DQo+IElmIENPTkZJR19YRlNfUE9TSVhfQUNM
IGlzbid0IHNlbGVjdGVkIHRoZW4gU0JfUE9TSVhBQ0wgd29uJ3QgYmUgc2V0IGluDQo+IGlub2Rl
LT5pX3NiLT5zX2ZsYWdzIGFuZCBjb25zZXF1ZW50bHkgcG9zaXhfYWNsX2NyZWF0ZSgpIGlzIGEg
bm9wLiBTbw0KPiBpZmRlZmluZyB0aGlzIGRvZXNuJ3QgcmVhbGx5IGRvIGFueXRoaW5nIHNvIEkn
ZCBhcmd1ZSB0byBub3QgYm90aGVyIHdpdGgNCj4gdGhpcyBjaGFuZ2UuDQpJdCBvbmx5IGF2b2lk
IHVzZWxlc3MgbW9kZSAmPSB+Y3VycmVudF9tYXNrIGhlcmUuDQo+DQo+PiAgIAkvKiBWZXJpZnkg
bW9kZSBpcyB2YWxpZCBhbHNvIGZvciB0bXBmaWxlIGNhc2UgKi8NCj4+ICAgCWVycm9yID0geGZz
X2RlbnRyeV9tb2RlX3RvX25hbWUoJm5hbWUsIGRlbnRyeSwgbW9kZSk7DQo+PiBAQCAtMjA5LDcg
KzIxMiw3IEBAIHhmc19nZW5lcmljX2NyZWF0ZSgNCj4+ICAgCWlmICh1bmxpa2VseShlcnJvcikp
DQo+PiAgIAkJZ290byBvdXRfY2xlYW51cF9pbm9kZTsNCj4+DQo+PiAtI2lmZGVmIENPTkZJR19Y
RlNfUE9TSVhfQUNMDQo+PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX1hGU19QT1NJWF9BQ0wpDQo+
PiAgIAlpZiAoZGVmYXVsdF9hY2wpIHsNCj4+ICAgCQllcnJvciA9IF9feGZzX3NldF9hY2woaW5v
ZGUsIGRlZmF1bHRfYWNsLCBBQ0xfVFlQRV9ERUZBVUxUKTsNCj4+ICAgCQlpZiAoZXJyb3IpDQo+
DQo+IFNpZGUtbm90ZSwgSSB0aGluaw0KPg0KPiAJI2lmZGVmIENPTkZJR19YRlNfUE9TSVhfQUNM
DQo+IAlleHRlcm4gc3RydWN0IHBvc2l4X2FjbCAqeGZzX2dldF9hY2woc3RydWN0IGlub2RlICpp
bm9kZSwgaW50IHR5cGUsIGJvb2wgcmN1KTsNCj4gCWV4dGVybiBpbnQgeGZzX3NldF9hY2woc3Ry
dWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAJ
CQkgICAgICAgc3RydWN0IHBvc2l4X2FjbCAqYWNsLCBpbnQgdHlwZSk7DQo+IAlleHRlcm4gaW50
IF9feGZzX3NldF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHBvc2l4X2FjbCAqYWNs
LCBpbnQgdHlwZSk7DQo+IAkjZWxzZQ0KPiAJZXh0ZXJuIGludCB4ZnNfc2V0X2FjbChzdHJ1Y3Qg
dXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsIHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+IAkJCSAg
ICAgICBzdHJ1Y3QgcG9zaXhfYWNsICphY2wsIGludCB0eXBlKQ0KPiAJew0KPiAJCXJldHVybiAw
Ow0KPiAJfQ0KPiAJDQo+IAlleHRlcm4gaW50IF9feGZzX3NldF9hY2woc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IHBvc2l4X2FjbCAqYWNsLCBpbnQgdHlwZSkNCj4gCXsNCj4gCQlyZXR1cm4g
MDsNCj4gCX0NCj4gCSNlbmRpZg0KPg0KPiBhbmQgdGhlbiByZW1vdmluZyB0aGUgaW5saW5lLWlm
ZGVmIG1pZ2h0IGJlIGFuIGltcHJvdmVtZW50Lg0KTWF5YmUsIGJ1dCBpdCBzaG91bGQgbm90IGJl
IGluIHRoaXMgcGF0Y2hzZXQgYXMgeW91IHNhaWQuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0K
