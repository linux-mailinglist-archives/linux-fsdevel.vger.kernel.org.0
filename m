Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0E4ED6F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiCaJcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiCaJcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:32:12 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB119D60D;
        Thu, 31 Mar 2022 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648719025; x=1680255025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C01uZHv7GA5VmCVxV97xvLJyDJttOOu5CSAu6q+xXSk=;
  b=jRX9Ebc1SwBob2uBM2RIjoSouqI51YcpON76nKZvLkxg9vEX3hHU8rdQ
   IhrRF+Ac7aW57mspTEhVXRUL6q4cPmumRAbe4co/qbPPihiJ8wyMcvtBf
   MHghkT+GseBemC/ydoDnRh6VDBv9vavsbOjcvQn5j2Bbjl87O4YmpOR44
   rztlLeiSOvoZxhGC2RMDplAbF8G/vKJmCU5TTb/OXo72OXwODvmZa39Et
   Hfd61huKbqizs4VweGCacPWAhAwp82QnehijpxhsHzQ8n7/md5rKX8gGn
   GLNNgCGX4jU0yoO/5wVZHrj2p0KVuxluzGvK9nzWzWhV4P1XcUa2/WNs1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="52924610"
X-IronPort-AV: E=Sophos;i="5.90,224,1643641200"; 
   d="scan'208";a="52924610"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 18:30:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbG3yey/Zr7du30H3Wtt7Y5B/8dcUFtN4RKRVGa9DifN0qUngBLb95XSb/1kpvGCVWGLqbiURh++tO3knr+TfhfJhNWHCBApChefHcjENtZQC+Uo2bCBerpDbTSd1XKha3p3hOvFDtVoS6Slpm8KFBao4R4Sv3lAW1KqjoS7pLEjnzUPdrTLBaMi3F9KLujrdGscoAIUIsZ3zJwHPkaQDUpDbOdfdrXv2gF/gI7NH0uG96ten6R46KA2pSNIgKBUz8qffF/3IsURkkdK55WTd+CnpW2xr3Bu3VyTPtRlCXMAHBhgRCusorjYbS6+F9mXvU974E6eMwzsQ5H52cbUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C01uZHv7GA5VmCVxV97xvLJyDJttOOu5CSAu6q+xXSk=;
 b=bgCXtTVSNwnTfQN6Qt0TVxP0AU+TyTHL69Prnqghqj51SsqYkjoJ/G15pIxU2aOstTB1alDvtxqFuZy4xlQXCO0wQnatdi4+j7zV5PtVeYVcIUdNgilRxmdTElm5D5Ykjiuc5CbGzU/izVjpHZ6UV20H0CViABjg1R0jGlRFwdo5YTN2h5id8m5UJvmMsx2jwFPvC4iIv9lFqIfhrz/eayTBNpg/sWITKguFT0fIXC5WL/MLRhjsWSFjgyQd+kXPd0nryywVhJbmIey6yc0VSw7j9cY581vgF1A6ceFPY+eJLq3gmeyyFxqUNYwbqp8FRhpA76616gbEAeDNhu5C4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C01uZHv7GA5VmCVxV97xvLJyDJttOOu5CSAu6q+xXSk=;
 b=OTLXfH4rE7El1Q4aAmyc32HhHyM5Z17rGCf1rR90v4aNHAwQyMXMYh6gdsLszzdblAkwF2k27G4SCwgamQcAVVZMurkeQnisV7eBCoaR4mBbmKeeY24bZQHotTcGwNH/6sYUvljMGlMzBW2XyddB6BoS0iEjNGVgbSybeP4E9Dk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB2478.jpnprd01.prod.outlook.com (2603:1096:404:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 09:30:17 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 09:30:17 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on filesystem
Thread-Topic: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on filesystem
Thread-Index: AQHYQoohmNglp2hVDEu76q0CRIf+hKzWNpeAgAC4EYCAANJ7gIAAZKwAgAEZLIA=
Date:   Thu, 31 Mar 2022 09:30:17 +0000
Message-ID: <624574D3.4050803@fujitsu.com>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <4250135d7321841ee6bdf0487c576f311aa583aa.camel@kernel.org>
 <20220329221059.GN1609613@dread.disaster.area>
 <20220330104419.j7qwcf465hyms2tv@wittgenstein>
 <20220330164438.GC27649@magnolia>
In-Reply-To: <20220330164438.GC27649@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2e4d76f-b24a-4926-56a3-08da12f91142
x-ms-traffictypediagnostic: TYAPR01MB2478:EE_
x-microsoft-antispam-prvs: <TYAPR01MB247808705BF00472FFE549B1FDE19@TYAPR01MB2478.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwZZ/48sfJYFW4R04GCW+Nlz4HK/MtHYN6tK8OO4m1K8QEHmV1CWyzkps9qURqlvi4F9yOblvJnCMAsNz/dKaj8PzSrp4OTLF3V/cgshb4yvIJdMUxzbxhtilJEcF9wTJJ2xUXznUK30kaS0Zr2m7GXw5+6Zgo0V1Nvt8Z0dvjxj/W0mmcdNRbAebGTQMeL1tMIEKoPaLePoO5MW+fkTU6GkKUY/UWVX1eWe3/P5UZV2D2wKe7ZjGU4WZw7RYLecuOH7XSf2MxpTRsbXhyk6G0Gwtp6EeUBc2/xGmSOQFbshdRuh3Uifv6fRbpdBJlzNFPvB1EEGFkv8eMLHf1I9cyBFeXrT1Jdnd1EQDvFo0/KD7DcBEoH738z64pyHJ7N4dKHBwybtFdIPYGv08ufTskJc+2M37mWLwezZ4n2/rFYDpOYEOITWrpfgRUNOlLteWP4V+t45wcOgmRqahUpj27ks3V1XR4iPVF+QglM7/GE7M4F6mbLAf0e6atSblLRZ0OEubtvGFP0IV6+3g/91wMtgRZ/fC6682v1ZLRp6FIn6USHZlXJoxh8lnHP+w1kr2vC5Kfy6l515Q4OWCj0vLUW9k1USkkFNLAMBnv25oqTnz5UYFZg4jS5vCnSHYkrtWj2aklv5iVjdzl2xL/SwESDqPfR7mcLrpGS+Qcy7S2qN464+7j5El0vveX2r7cexutjCWJC59AroM7xjgJATDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(66446008)(64756008)(87266011)(33656002)(85182001)(36756003)(8676002)(122000001)(54906003)(91956017)(6506007)(4326008)(83380400001)(6512007)(76116006)(82960400001)(2616005)(186003)(26005)(38100700002)(38070700005)(6916009)(71200400001)(8936002)(5660300002)(6486002)(316002)(2906002)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dkRjTHk1NHZEYXhNMmYxQ2YzZjRWTE84emlDSE81OHZjSDZwUDVPQnM1UDMx?=
 =?gb2312?B?MmZXYTYyR3prcEE1Mjhyczh1RWd3VWdxaWFNdFBLWlFaNlh6UEFKby9yVXhR?=
 =?gb2312?B?K3BKY1c3VkpnaDAyYUEvZGFSZHEvNHgwZ1BJdW9UU1kwUzBwcmI4eTQ2UHl0?=
 =?gb2312?B?R0JsR2trWXVka1R4aHRSS3hxK3R2dU5nd2prU0FnbmZxbWdBL0tLSWN0aXo0?=
 =?gb2312?B?MGtyR1pzem8xUFBuWXZ1SWgvQ29ZUmpVSlg3TFdhTWgvRFY4NC84WDUyWmpl?=
 =?gb2312?B?eWdRT0tpZWhIMjlRbmo0enRxSkhmNXNmbXhEZ1VUaDZ5QjUrdHI1aWRTclk1?=
 =?gb2312?B?VDBEd05YcHo4UlhoU3MrdVZiNGp5eG9wMW42eHNmb0xvSU9ENkxQY2xMaUd2?=
 =?gb2312?B?eFVUcWRTWEpxMWxXNVc0TGxnMHJQNFVVZ1JpYU4yOW1lS2U0WU10VldveUdS?=
 =?gb2312?B?QSs3OGtZWlpsNTBUeUVpUmlxTEZJREtDN1VlaTlWZWxyYVVzcmg1SjV6eDdR?=
 =?gb2312?B?SXFRbFRseTdJVm5qaHlMRC84Qi9tM1JST2RDYWlFNDRIR2NTMVhuT05KQ01Z?=
 =?gb2312?B?bDdhdkhKZFVIVThOM1YxV21DWXhuR2hWYmk1WE5kSzVab3Q0SFVJVXoyMDRo?=
 =?gb2312?B?NFFHWkpmS1JuSTdFSDhldG9EMlRCTkdyYlN0cnMvbW8vTXlhRjZxekE2aHRo?=
 =?gb2312?B?TDlDd1ZQL1hzRnA3blZ2TDNGcmwwN1Y2NEZLalBoVzBtc000R3E5ZzEzZlQv?=
 =?gb2312?B?ZC96bjgvbG85WFl3NzN1ZU9EWHJycDhCcGVQY3ZYSERkVlErUG5nOFQrWVlO?=
 =?gb2312?B?cTVkeWZSaXhHZGl1bWVWWkhyd04weGsyRkM3a1NHUkM4QTZvTytVYTFKMUVS?=
 =?gb2312?B?VWk5U0RPOHBDci9GZ2JBbnBKajkzYkQybTBOcitnQUJHQWVGVTZiQW5RVFA0?=
 =?gb2312?B?TDZMaGtnd0tpUmlwS29rQVRBczJYZEpBWGYvYnc0cHNEVEpKOUYwc2Y0VmJt?=
 =?gb2312?B?bGVrbDBsU213bXVlNnFRZFhpOXBoVVcxeHdSaForZ3h5QlA4Q1V5cDFpMklU?=
 =?gb2312?B?ODQ1c2RWWlZBTURiU2F6cXROdGJaZXZvQmxWUUdpUy80eVNJclIxMkRuOS9x?=
 =?gb2312?B?Ymg1Y1g0UjZHRGNBT3JudkEvR3ZaWmxuSnFOVnhlRjIyWm5ydG1aSTdqSkVC?=
 =?gb2312?B?czlIbEw2SzZQcHcxT1AyTTFrU0ZLWHhRKzZLa3F2OUt6UTdVM1FJbGwyRUt4?=
 =?gb2312?B?V3gwbHBWOU12a3JYMWdrWXZZVU1pSjZnOUkyRzlsOHVSSFErUlU0NEdYTVk5?=
 =?gb2312?B?ejNJUzAxR3haVnd1bmVYV1FzcTc5VXdFemE3TmpzWHJTcGNMUERieWp6d1l0?=
 =?gb2312?B?L3pvS0VGN001b0tORGpvYmtCR1ZId2VydHJmSlZNQ1lXWEgzdGY5Y01vdUFU?=
 =?gb2312?B?dDZKOVZweFVKVjh6TXBiam5WNXBUQlEzRzJrSGEyTUEvQWpBNERRcUJBKytH?=
 =?gb2312?B?U1FTTkxFTUpoQ2tQSHdtT2p1dGdKSHdHMG03ay9McS9sQldpMmZ5Z1BwaDRJ?=
 =?gb2312?B?R1RRd1IyN1IrQlJ2Qk8vcEhzeTUycmtwQjVTeFN0d1REY0dSM2JiM3JqbWo5?=
 =?gb2312?B?dzdoUnhjMTFLQVJGdjQ1K3VmUDFPZThydWRiOVFEMzlQd3k0c093NDRRUHQy?=
 =?gb2312?B?dkR2SkNKZFJiN2pyQkwyeHBaODk2NHZITW1DOEFvNGRHeVdpWHo2MlNXczlj?=
 =?gb2312?B?YjlkWS9BQjFFdWtzZ1IreFFnU3hseG1UeDNvTExIcHdBaXI0RldHSjhsS3pQ?=
 =?gb2312?B?U0hXcVY4dEtyMG9Hbm80L1dEZmFjU09TanJ0SkVKeFJIbUk5TlpnTytvQlNW?=
 =?gb2312?B?N2s5WmlZWmJPNTMxeElLdGd0NlBDWE1NVTB6alZhSTNFNUNQVU1wcnZRZWlB?=
 =?gb2312?B?MFdsOHc1UDc1eWxWMzQyQ2Fac010c1RiT3I5dHl0MFl3K0JhVHdRK1NCRGVY?=
 =?gb2312?B?UGNoUWdPdHlGY3M5RjZNZ0NnbWQzSXdxWHhBaTJSMUJ3bWxQU0NXYWNSZVBC?=
 =?gb2312?B?dGtLYnh3NWsyNlFQb3BXcTBOV3BlL2dBeXFiL3VQd3ZNQU9uWVB4Z1lkUEpj?=
 =?gb2312?B?alNWTVVLZHFVbVRkSGFYdlpjUERDajY4K2dtdzNyckJSKzl5OHBWRFU4SDVX?=
 =?gb2312?B?b1BOM2pVU3AzUEl5TGJPVU9PdVM2ZmozbWNxSnJSVWs0cGdnNHF0cEJua1hI?=
 =?gb2312?B?ZWVsdkR2VXZ3TlFQZXVndm1lT3NqMWZSd2JiZWl3enp3RGhoS1BOdGhqSDZW?=
 =?gb2312?B?R0tVb1dURHFRM2d3ZVg3QjZKcG1vZTkwWUdkSFpjSGJhNlpVZCsyS1Q3K25F?=
 =?gb2312?Q?zT1uG8LGu0d8nIDtn5ErdctPboHsqrSGIruDL?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <B6ACC34A3AA2C14AA6A61DB043695E47@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e4d76f-b24a-4926-56a3-08da12f91142
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 09:30:17.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpsKYEibx4wVpmXv4fYa9SKmtIpvIrdzzCqo93jCd97YFCMTLQHccH/5tv3YavaCe7xTNwA3o4g61H0LvfyCx5PumGTHXz6UE/g0h2bcCus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2478
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi8zLzMxIDA6NDQsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gT24gV2VkLCBNYXIg
MzAsIDIwMjIgYXQgMTI6NDQ6MTlQTSArMDIwMCwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+
PiBPbiBXZWQsIE1hciAzMCwgMjAyMiBhdCAwOToxMDo1OUFNICsxMTAwLCBEYXZlIENoaW5uZXIg
d3JvdGU6DQo+Pj4gT24gVHVlLCBNYXIgMjksIDIwMjIgYXQgMDc6MTI6MTFBTSAtMDQwMCwgSmVm
ZiBMYXl0b24gd3JvdGU6DQo+Pj4+IE9uIE1vbiwgMjAyMi0wMy0yOCBhdCAxNzo1NiArMDgwMCwg
WWFuZyBYdSB3cm90ZToNCj4+Pj4+IEN1cnJlbnRseSwgdmZzIG9ubHkgcGFzc2VzIG1vZGUgYXJn
dW1lbnQgdG8gZmlsZXN5c3RlbSwgdGhlbiB1c2UgaW5vZGVfaW5pdF9vd25lcigpDQo+Pj4+PiB0
byBzdHJpcCBTX0lTR0lELiBTb21lIGZpbGVzeXN0ZW0oaWUgZXh0NC9idHJmcykgd2lsbCBjYWxs
IGlub2RlX2luaXRfb3duZXINCj4+Pj4+IGZpcnN0bHksIHRoZW4gcG9zeGkgYWNsIHNldHVwLCBi
dXQgeGZzIHVzZXMgdGhlIGNvbnRyYXJ5IG9yZGVyLiBJdCB3aWxsIGFmZmVjdA0KPj4+Pj4gU19J
U0dJRCBjbGVhciBlc3BlY2lhbGx5IHVtYXNrIHdpdGggU19JWEdSUC4NCj4+Pj4+DQo+Pj4+PiBW
ZnMgaGFzIGFsbCB0aGUgaW5mbyBpdCBuZWVkcyAtIGl0IGRvZXNuJ3QgbmVlZCB0aGUgZmlsZXN5
c3RlbXMgdG8gZG8gZXZlcnl0aGluZw0KPj4+Pj4gY29ycmVjdGx5IHdpdGggdGhlIG1vZGUgYW5k
IGVuc3VyaW5nIHRoYXQgdGhleSBvcmRlciB0aGluZ3MgbGlrZSBwb3NpeCBhY2wgc2V0dXANCj4+
Pj4+IGZ1bmN0aW9ucyBjb3JyZWN0bHkgd2l0aCBpbm9kZV9pbml0X293bmVyKCkgdG8gc3RyaXAg
dGhlIFNHSUQgYml0Lg0KPj4+Pj4NCj4+Pj4+IEp1c3Qgc3RyaXAgdGhlIFNHSUQgYml0IGF0IHRo
ZSBWRlMsIGFuZCB0aGVuIHRoZSBmaWxlc3lzdGVtcyBjYW4ndCBnZXQgaXQgd3JvbmcuDQo+Pj4+
Pg0KPj4+Pj4gQWxzbywgdGhlIGlub2RlX3NnaWRfc3RyaXAoKSBhcGkgc2hvdWxkIGJlIHVzZWQg
YmVmb3JlIElTX1BPU0lYQUNMKCkgYmVjYXVzZQ0KPj4+Pj4gdGhpcyBhcGkgbWF5IGNoYW5nZSBt
b2RlIGJ5IHVzaW5nIHVtYXNrIGJ1dCBTX0lTR0lEIGNsZWFyIGlzbid0IHJlbGF0ZWQgdG8NCj4+
Pj4+IFNCX1BPU0lYQUNMIGZsYWcuDQo+Pj4+Pg0KPj4+Pj4gU3VnZ2VzdGVkLWJ5OiBEYXZlIENo
aW5uZXI8ZGF2aWRAZnJvbW9yYml0LmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8
eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICBmcy9pbm9kZS5j
IHwgNCAtLS0tDQo+Pj4+PiAgIGZzL25hbWVpLmMgfCA3ICsrKysrLS0NCj4+Pj4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4g
ZGlmZiAtLWdpdCBhL2ZzL2lub2RlLmMgYi9mcy9pbm9kZS5jDQo+Pj4+PiBpbmRleCAxZjk2NGU3
Zjk2OTguLmEyZGQ3MWMyNDM3ZSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2ZzL2lub2RlLmMNCj4+Pj4+
ICsrKyBiL2ZzL2lub2RlLmMNCj4+Pj4+IEBAIC0yMjQ2LDEwICsyMjQ2LDYgQEAgdm9pZCBpbm9k
ZV9pbml0X293bmVyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlu
b2RlICppbm9kZSwNCj4+Pj4+ICAgCQkvKiBEaXJlY3RvcmllcyBhcmUgc3BlY2lhbCwgYW5kIGFs
d2F5cyBpbmhlcml0IFNfSVNHSUQgKi8NCj4+Pj4+ICAgCQlpZiAoU19JU0RJUihtb2RlKSkNCj4+
Pj4+ICAgCQkJbW9kZSB8PSBTX0lTR0lEOw0KPj4+Pj4gLQkJZWxzZSBpZiAoKG1vZGUmICAoU19J
U0dJRCB8IFNfSVhHUlApKSA9PSAoU19JU0dJRCB8IFNfSVhHUlApJiYNCj4+Pj4+IC0JCQkgIWlu
X2dyb3VwX3AoaV9naWRfaW50b19tbnQobW50X3VzZXJucywgZGlyKSkmJg0KPj4+Pj4gLQkJCSAh
Y2FwYWJsZV93cnRfaW5vZGVfdWlkZ2lkKG1udF91c2VybnMsIGRpciwgQ0FQX0ZTRVRJRCkpDQo+
Pj4+PiAtCQkJbW9kZSY9IH5TX0lTR0lEOw0KPj4+Pj4gICAJfSBlbHNlDQo+Pj4+PiAgIAkJaW5v
ZGVfZnNnaWRfc2V0KGlub2RlLCBtbnRfdXNlcm5zKTsNCj4+Pj4+ICAgCWlub2RlLT5pX21vZGUg
PSBtb2RlOw0KPj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL25hbWVpLmMgYi9mcy9uYW1laS5jDQo+Pj4+
PiBpbmRleCAzZjE4MjliM2FiNWIuLmU2OGE5OWUwYWM5NiAxMDA2NDQNCj4+Pj4+IC0tLSBhL2Zz
L25hbWVpLmMNCj4+Pj4+ICsrKyBiL2ZzL25hbWVpLmMNCj4+Pj4+IEBAIC0zMjg3LDYgKzMyODcs
NyBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqbG9va3VwX29wZW4oc3RydWN0IG5hbWVpZGF0YSAq
bmQsIHN0cnVjdCBmaWxlICpmaWxlLA0KPj4+Pj4gICAJaWYgKG9wZW5fZmxhZyYgIE9fQ1JFQVQp
IHsNCj4+Pj4+ICAgCQlpZiAob3Blbl9mbGFnJiAgT19FWENMKQ0KPj4+Pj4gICAJCQlvcGVuX2Zs
YWcmPSB+T19UUlVOQzsNCj4+Pj4+ICsJCWlub2RlX3NnaWRfc3RyaXAobW50X3VzZXJucywgZGly
LT5kX2lub2RlLCZtb2RlKTsNCj4+Pj4+ICAgCQlpZiAoIUlTX1BPU0lYQUNMKGRpci0+ZF9pbm9k
ZSkpDQo+Pj4+PiAgIAkJCW1vZGUmPSB+Y3VycmVudF91bWFzaygpOw0KPj4+Pj4gICAJCWlmIChs
aWtlbHkoZ290X3dyaXRlKSkNCj4+Pj4+IEBAIC0zNTIxLDYgKzM1MjIsOCBAQCBzdHJ1Y3QgZGVu
dHJ5ICp2ZnNfdG1wZmlsZShzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsDQo+Pj4+
PiAgIAljaGlsZCA9IGRfYWxsb2MoZGVudHJ5LCZzbGFzaF9uYW1lKTsNCj4+Pj4+ICAgCWlmICh1
bmxpa2VseSghY2hpbGQpKQ0KPj4+Pj4gICAJCWdvdG8gb3V0X2VycjsNCj4+Pj4+ICsJaW5vZGVf
c2dpZF9zdHJpcChtbnRfdXNlcm5zLCBkaXIsJm1vZGUpOw0KPj4+Pj4gKw0KPj4+Pj4gICAJZXJy
b3IgPSBkaXItPmlfb3AtPnRtcGZpbGUobW50X3VzZXJucywgZGlyLCBjaGlsZCwgbW9kZSk7DQo+
Pj4+PiAgIAlpZiAoZXJyb3IpDQo+Pj4+PiAgIAkJZ290byBvdXRfZXJyOw0KPj4+Pj4gQEAgLTM4
NDksMTQgKzM4NTIsMTQgQEAgc3RhdGljIGludCBkb19ta25vZGF0KGludCBkZmQsIHN0cnVjdCBm
aWxlbmFtZSAqbmFtZSwgdW1vZGVfdCBtb2RlLA0KPj4+Pj4gICAJZXJyb3IgPSBQVFJfRVJSKGRl
bnRyeSk7DQo+Pj4+PiAgIAlpZiAoSVNfRVJSKGRlbnRyeSkpDQo+Pj4+PiAgIAkJZ290byBvdXQx
Ow0KPj4+Pj4gLQ0KPj4+Pj4gKwltbnRfdXNlcm5zID0gbW50X3VzZXJfbnMocGF0aC5tbnQpOw0K
Pj4+Pj4gKwlpbm9kZV9zZ2lkX3N0cmlwKG1udF91c2VybnMsIHBhdGguZGVudHJ5LT5kX2lub2Rl
LCZtb2RlKTsNCj4+Pj4+ICAgCWlmICghSVNfUE9TSVhBQ0wocGF0aC5kZW50cnktPmRfaW5vZGUp
KQ0KPj4+Pj4gICAJCW1vZGUmPSB+Y3VycmVudF91bWFzaygpOw0KPj4+Pj4gICAJZXJyb3IgPSBz
ZWN1cml0eV9wYXRoX21rbm9kKCZwYXRoLCBkZW50cnksIG1vZGUsIGRldik7DQo+Pj4+PiAgIAlp
ZiAoZXJyb3IpDQo+Pj4+PiAgIAkJZ290byBvdXQyOw0KPj4+Pj4NCj4+Pj4+IC0JbW50X3VzZXJu
cyA9IG1udF91c2VyX25zKHBhdGgubW50KTsNCj4+Pj4+ICAgCXN3aXRjaCAobW9kZSYgIFNfSUZN
VCkgew0KPj4+Pj4gICAJCWNhc2UgMDogY2FzZSBTX0lGUkVHOg0KPj4+Pj4gICAJCQllcnJvciA9
IHZmc19jcmVhdGUobW50X3VzZXJucywgcGF0aC5kZW50cnktPmRfaW5vZGUsDQo+Pj4+DQo+Pj4+
IEkgaGF2ZW4ndCBnb25lIG92ZXIgdGhpcyBpbiBkZXRhaWwsIGJ1dCBoYXZlIHlvdSB0ZXN0ZWQg
dGhpcyB3aXRoIE5GUyBhdA0KPj4+PiBhbGw/DQo+Pj4+DQo+Pj4+IElJUkMsIE5GUyBoYXMgdG8g
bGVhdmUgc2V0dWlkL2dpZCBzdHJpcHBpbmcgdG8gdGhlIHNlcnZlciwgc28gSSB3b25kZXINCj4+
Pj4gaWYgdGhpcyBtYXkgZW5kIHVwIHJ1bm5pbmcgYWZvdWwgb2YgdGhhdCBieSBmb3JjaW5nIHRo
ZSBjbGllbnQgdG8gdHJ5DQo+Pj4+IGFuZCBzdHJpcCB0aGVzZSBiaXRzLg0KPj4+DQo+Pj4gQWxs
IGl0IG1lYW5zIGlzIHRoYXQgdGhlIG1vZGUgcGFzc2VkIHRvIHRoZSBORlMgc2VydmVyIGZvciB0
aGUNCj4+PiBjcmVhdGUgYWxyZWFkeSBoYXMgdGhlIFNHSUQgYml0IHN0cmlwcGVkIGZyb20gaXQu
IEl0IG1lYW5zIHRoZQ0KPj4+IGNsaWVudCBpcyBubyBsb25nZXIgcmVsaWFudCBvbiB0aGUgc2Vy
dmVyIGJlaGF2aW5nIGNvcnJlY3RseSB0bw0KPj4+IGNsb3NlIHRoaXMgc2VjdXJpdHkgaG9sZS4N
Cj4+Pg0KPj4+IFRoYXQgaXMsIGZhaWxpbmcgdG8gc3RyaXAgdGhlIFNHSUQgYml0IGFwcHJvcHJp
YXRlbHkgaW4gdGhlIGxvY2FsDQo+Pj4gY29udGV4dCBpcyBhIHNlY3VyaXR5IGlzc3VlLiBIZW5j
ZSBsb2NhbCBtYWNoaW5lIHNlY3VyaXR5IHJlcXVpcmVzDQo+Pj4gdGhhdCB0aGUgTkZTIGNsaWVu
dCBzaG91bGQgdHJ5IHRvIHN0cmlwIHRoZSBTR0lEIHRvIGRlZmVuZCBhZ2FpbnN0DQo+Pj4gYnVn
Z3kvdW5maXhlZCBzZXJ2ZXJzIHRoYXQgZmFpbCB0byBzdHJpcCBpdCBhcHByb3ByaWF0ZWx5IGFu
ZA0KPj4+IHRoZXJlYnkgY29udGludXRlIHRvIGV4cG9zZSB0aGUgbG9jYWwgbWFjaGluZSB0byB0
aGlzIFNHSUQgc2VjdXJpdHkNCj4+PiBpc3N1ZS4NCj4+Pg0KPj4+IFRoYXQncyB0aGUgcHJvYmxl
bSBoZXJlIC0gdGhlIFNHSUQgc3RyaXBwaW5nIGluIGlub2RlX2luaXRfb3duZXIoKQ0KPj4+IGlz
IG5vdCBkb2N1bWVudGVkLCB3YXNuJ3QgcmV2aWV3ZWQsIGRvZXNuJ3Qgd29yayBjb3JyZWN0bHkN
Cj4+PiBhY3Jvc3MgYWxsIGZpbGVzeXN0ZW1zIGFuZCBsZWF2ZXMgbmFzdHkgc2VjdXJpdHkgbGFu
ZG1pbmVzIHdoZW4gdGhlIFZGUw0KPj4+IGNyZWF0ZSBtb2RlIGFuZCB0aGUgc3RyaXBwZWQgaW5v
ZGUgbW9kZSBkaWZmZXIuDQo+Pj4NCj4+PiBWYXJpb3VzIGZpbGVzeXN0ZW1zIGhhdmUgd29ya2Fy
b3VuZHMsIHBhcnRpYWwgZml4ZXMgb3Igbm8gZml4ZXMgZm9yDQo+Pj4gdGhlc2UgaXNzdWVzIGFu
ZCBsYW5kbWluZXMuIEhlbmNlIHdlIGhhdmUgYSBzaXR1YXRpb24gd2hlcmUgd2UgYXJlDQo+Pj4g
cGxheWluZyB3aGFjay1hLW1vbGUgdG8gZGlzY292ZXIgYW5kIHNsYXAgYmFuZC1haWRzIG92ZXIg
YWxsIHRoZQ0KPj4+IHBsYWNlcyB0aGF0IGlub2RlX2luaXRfb3duZXIoKSBiYXNlZCBzdHJpcHBp
bmcgZG9lcyBub3Qgd29yaw0KPj4+IGNvcnJlY3RseS4NCj4+Pg0KPj4+IEluIFhGUywgdGhpcyBt
ZWFudCB0aGUgcHJvYmxlbSB3YXMgbm90IG9yZ2luYWxseSBmaXhlZCBieSB0aGUNCj4+PiBzaWxl
bnQsIHVucmV2aWV3ZWQgY2hhbmdlIHRvIGlub2RlX2luaXRfb3duZXIoKSBpbiAyMDE4DQo+Pj4g
YmVjYXVzZSBpdCBkaWRuJ3QgY2FsbCBpbm9kZV9pbml0X293bmVyKCkgYXQgYWxsLiBTbyA0IHll
YXJzIGFmdGVyDQo+Pj4gdGhlIGJ1ZyB3YXMgImZpeGVkIiBhbmQgdGhlIENWRSByZWxlYXNlZCwg
d2UgYXJlIHN0aWxsIGV4cG9zZWQgdG8NCj4+PiB0aGUgYnVnIGJlY2F1c2UgKm5vIGZpbGVzeXN0
ZW0gcGVvcGxlIGtuZXcgYWJvdXQgaXQqIGFuZCAqbm9ib2R5IHdyb3RlIGENCj4+PiByZWdyZXNz
aW9uIHRlc3QqIHRvIGNoZWNrIHRoYXQgdGhlIHByb2JlbG0gd2FzIGZpeGVkIGFuZCBzdGF5ZWQN
Cj4+PiBmaXhlZC4NCj4+Pg0KPj4+IEFuZCBub3cgdGhhdCBYRlMgZG9lcyBjYWxsIGlub2RlX2lu
aXRfb3duZXIoKSwgd2UndmUgc3Vic2VxdWVudGx5DQo+Pj4gZGlzY292ZXJlZCB0aGF0IFhGUyBz
dGlsbCBmYWlsIHdoZW4gZGVmYXVsdCBhY2xzIGFyZSBlbmFibGVkIGJlY2F1c2UNCj4+PiB3ZSBj
cmVhdGUgdGhlIEFDTCBmcm9tIHRoZSBtb2RlIHBhc3NlZCBmcm9tIHRoZSBWRlMsIG5vdCB0aGUN
Cj4+PiBzdHJpcHBlZCBtb2RlIHRoYXQgcmVzdWx0cyBmcm9tIGlub2RlX2luaXRfb3duZXIoKSBi
ZWluZyBjYWxsZWQuDQo+Pj4NCj4+PiBTZWUgd2hhdCBJIG1lYW4gYWJvdXQgbGFuZG1pbmVzPw0K
Pj4+DQo+Pj4gVGhlIGZhY3QgaXMgdGhpczogcmVnYXJkbGVzcyBvZiB3aGljaCBmaWxlc3lzdGVt
IGlzIGluIHVzZSwgZmFpbHVyZQ0KPj4+IHRvIHN0cmlwIHRoZSBTR0lEIGNvcnJlY3RseSBpcyBj
b25zaWRlcmVkIGEgc2VjdXJpdHkgZmFpbHVyZSB0aGF0DQo+Pj4gbmVlZHMgdG8gYmUgZml4ZWQu
IFRoZSBjdXJyZW50IFZGUyBpbmZyYXN0cnVjdHVyZSByZXF1aXJlcyB0aGUNCj4+PiBmaWxlc3lz
dGVtIHRvIGRvIGV2ZXJ5dGhpbmcgcmlnaHQgYW5kIG5vdCBzdGVwIG9uIGFueSBsYW5kbWluZXMg
dG8NCj4+PiBzdHJpcCB0aGUgU0dJRCBiaXQsIHdoZW4gaW4gZmFjdCBpdCBjYW4gZWFzaWx5IGJl
IGRvbmUgYXQgdGhlIFZGUw0KPj4+IGFuZCB0aGUgZmlsZXN5c3RlbXMgdGhlbiBkb24ndCBldmVu
IG5lZWQgdG8gYmUgYXdhcmUgdGhhdCB0aGUgU0dJRA0KPj4+IG5lZWRzIHRvIGJlIChvciBoYXMg
YmVlbiBzdHJpcHBlZCkgYnkgdGhlIG9wZXJhdGlvbiB0aGUgdXNlciBhc2tlZA0KPj4+IHRvIGJl
IGRvbmUuDQo+Pj4NCj4+PiBXZSBuZWVkIHRoZSBhcmNoaXRlY3R1cmUgdG8gYmUgKnNlY3VyZSBi
eSBkZXNpZ24qLCBub3QgdGFja2VkIG9udG8NCj4+PiB0aGUgc2lkZSBsaWtlIGl0IGlzIG5vdy4g
IFdlIG5lZWQgdG8gc3RvcCB0cnlpbmcgdG8gZGFuY2UgYXJvdW5kDQo+Pj4gdGhlc2UgbGFuZG1p
bmVzIC0gaXQgaXMgKm5vdCB3b3JraW5nKiBhbmQgd2UgYXJlIGJsb3dpbmcgb3VyIG93bg0KPj4+
IGZlZXQgb2ZmIHJlcGVhdGVkbHkuIFRoaXMgaHVydHMgYSBsb3QgKGVzcGVjaWFsbHkgaW4gZGlz
dHJvIGxhbmQpDQo+Pj4gc28gd2UgbmVlZCB0byB0YWtlIHRoZSByZXNwb25zaWJpbGl0eSBmb3Ig
c3RyaXBwaW5nIFNHSUQgcHJvcGVybHkNCj4+PiBhd2F5IGZyb20gdGhlIGZpbGVzeXN0ZW1zIGFu
ZCBwdXQgaXQgd2hlcmUgaXQgYmVsb25nczogaW4gdGhlIFZGUy4NCj4+DQo+PiBJIGFncmVlLiBX
aGVuIEkgYWRkZWQgdGVzdHMgZm9yIHNldCppZCBzdHJpcHBpbmcgdG8geGZzdGVzdHMgZm9yIHRo
ZQ0KPj4gc2FrZSBvZiBnZXR0aW5nIGNvbXBsZXRlIHZmcyBjb3ZlcmFnZSBvZiBpZG1hcHBlZCBt
b3VudHMgaW4gZ2VuZXJpYy82MzMNCj4+IEkgaW1tZWRpYXRlbHkgZm91bmQgYnVncy4gT25jZSBJ
IG1hZGUgdGhlIHRlc3RzdWl0ZSB1c2VhYmxlIGJ5IGFsbA0KPj4gZmlsZXN5c3RlbXMgd2Ugc3Rh
cnRlZCBzZWVpbmcgbW9yZS4NCj4+DQo+PiBJIHRoaW5rIHdlIHNob3VsZCBhZGQgYW5kIHVzZSB0
aGUgbmV3IHByb3Bvc2VkIHN0cmlwcGluZyBoZWxwZXIgaW4gdGhlDQo+PiB2ZnMgLSBhbGJlaXQg
d2l0aCBhIHNsaWdodGx5IGNoYW5nZWQgYXBpIGFuZCBhbHNvIHVzZSBpdCBpbg0KPj4gaW5vZGVf
aW5pdF9vd25lcigpLiBXaGlsZSBpdCBpcyBhIGRlbGljYXRlIGNoYW5nZSBpbiB0aGUgd29yc3Qg
Y2FzZSB3ZQ0KPj4gZW5kIHVwIHJlbW92aW5nIGFkZGl0aW9uYWwgcHJpdmlsZWdlcyB0aGF0J3Mg
YW4gYWNjZXB0YWJsZSByZWdyZXNzaW9uDQo+PiByaXNrIHRvIHRha2UuDQo+DQo+IEFuZCBpZiBp
dCdzIG5vdCB0b28gbXVjaCB0cm91YmxlLCBjYW4gd2UgYWRkIGFuIGZzdGVzdCB0byBlbmNvZGUg
b3VyDQo+IGN1cnJlbnQgZXhwZWN0YXRpb25zIGFib3V0IGhvdyBzZXRnaWQgaW5oZXJpdGFuY2Ug
d29ya3M/ICBJIHdvdWxkIHJlYWxseQ0KPiBsaWtlIHRvIHJlZHVjZSB0aGUgbmVlZCBmb3IgaGlz
dG9yaWMgc2V0Z2lkIGJlaGF2aW9yIHNwZWx1bmtpbmcuIDspDQpJIGhhdmUgc2VudCB0d28gcGF0
Y2hlcyB0byBpbmNyZWFzZSB0aGUgaWRtYXBwZWQgbW91bnRzIGNvdmVyYWdlIGZvciANClNfSVNH
SUQgaW4geGZzdGVzdHMuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KDQo+DQo+IC0tRA0K
