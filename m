Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6022150202C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 03:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbiDOBn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 21:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiDOBn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:43:26 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 18:40:59 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C8AC05B;
        Thu, 14 Apr 2022 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649986860; x=1681522860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e3/IAmwjGg19sclI5BBFCZjBh0m3tlp14zthcnNSQBM=;
  b=n6tTTioigznKxuWqBRrlRnOtNvGNv1HB+mcVxPXw2xXuVNB8YfrlZhXh
   tsSiCxVQP3k9HcpD+aZlyplAOnU8WmjXlz9u7CQVUXqQ1aTt959O67saU
   YQxLFryKQGvEg9afyalKKjBq/rSxghTwZHp3Yj/E8gaIAlUPZaJ1TZ+wC
   8HQULSzpSCeJmNUeuYLtISOEqHDXFft6N3XwzbAiOf0Rcjpk/E8p397kT
   E0GGU/h0E3UFvP49Hkcl2YVAciBWsI5sScKDKWh1K6r1GD7YYLT9Qud31
   URN+ihpCXqbxFdNcZpedjkk7ZfJpbt1H2fTvuF5b8SgihXdi3OmFXdUjt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="53806587"
X-IronPort-AV: E=Sophos;i="5.90,261,1643641200"; 
   d="scan'208";a="53806587"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 10:39:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0D2xAkMa7Oz2vz6VgcXdbYfyKDt06JfcpS12hnDsWlENgJCYMVGCbRfO2srBVzERLHrg7DMAJHiY4UBcz6CPSH4EGEewDx34gtphcGzCc55/9Giun0/UJHuF8XXAngeUv6xsjUrA8dbiA2vedZ5n9Tg9/g7mK7VNdlrL3JimytH1i/dyZv+F1WjzW+ZdsAPzdua4n7VcIhF6/MulfB4PDnlh4Vzfbw+R1QUANnvVnP4BJf51WQny4D+Qxxfd8JYc1XOarXb/t375SyhKHdFVQC2DhgGiMcHi+YROwVn4zzfDWzK6+V0hr06zCysw9epY2q6OsdeYmTZuhEfvhxtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3/IAmwjGg19sclI5BBFCZjBh0m3tlp14zthcnNSQBM=;
 b=MZ8BPqyzJpjnQojERfazFdsa0C6B3uo8d7u39A5cGlSjMoIXXq7fMIfrHAiwH8AMzxjovyrLC095lscU6nwlw3escJSKdbA6NVkzOdDFLaVNtejJXamGFSeBmgP0MYxkGeSva05iV0eOhjy3YDtN7U3mhVN45VncYHH5Qk38J+gPZnNE/7ivQ9iy6uLwisbMXb4Slhf/tQ9hXbKMfwmcDMpYg7iigrh5BysrTpthYM2sZb2yRf1bHx6yFWtIElg6yVaYmu88jud5bjrD3kU1AAu7UcHh9E96s/pvfk1JgCJt+jCIMsgLULku43gWdTHFeAzuZd+9qAoyONgjXcGj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3/IAmwjGg19sclI5BBFCZjBh0m3tlp14zthcnNSQBM=;
 b=nQA8m/iXtclC+CMbdQP7HZMSUtRuNWjgW4Uvfc9DzAtjYVfB5Q6+/5vwSi1IkUfhiUzo0GW2iNnvaaKOrz8CSjOpR/hx/QpKPeZOTu5Z4uE4TTujnUEdFQHBN+aHvac2ZA4cNJPVRVqqghSkIzs2zAHCfqAGSvjFT0hTbl4++UQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB2990.jpnprd01.prod.outlook.com (2603:1096:404:86::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 01:39:47 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 01:39:46 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Thread-Topic: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Thread-Index: AQHYT8zJjgXI7lzLHECHzFKbpundU6zvT1+AgAD1dYA=
Date:   Fri, 15 Apr 2022 01:39:46 +0000
Message-ID: <6258DB31.4020403@fujitsu.com>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220414120217.fbsljr7alpvy5nmy@wittgenstein>
In-Reply-To: <20220414120217.fbsljr7alpvy5nmy@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3b461b8-94af-47a3-217f-08da1e80d2e4
x-ms-traffictypediagnostic: TYAPR01MB2990:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2990DA9F59257C4A2D4A6E37FDEE9@TYAPR01MB2990.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +B1+jsUSn6k5RUYXeHE3Fn9JihvUf7qEp320k+oFfSqzX4CQmOtgixvaruxcG5x6VTNdtQ6vIVcchz1HhrDEWw1BtuXN+2G5Ra71/G9MvZmm7AJcByhu0HzxozBb77nHFYKdXuIvE5UKcmnumzW78++dryyolOc8wGqlgGp/MAi02EQIL1e0gNsVjr61IoIci55+E6lsUPikXqaNNVbVAokjiJGfliNa+OerNwFWRFdL2Neu+ZkVA2aTSNcMC8UT0Z0n1s2qGQIqb6NHT/EB7kBesEnZByxg1cYoWqgeTxmQ3e/KtCBZBeYQkQXkF2+R3gqWLDDURl6XIJNct9gPF7rXrQv1RrVTYfLFUh8/XMhIzuKG5/GZi8bQv3pp7kWK6gTuSm6cRP0LmEg5UyHewrzC2XEgy2IGq7lf0rjPTEL+gJw+3iNemTPv/dNxNDWZZVgnC9Ahdq0/g37YjIfZ/7sXx9inO6QQesrE2Ap4nnrY9vFGR0Twk0GJz3Mqsl83KZK3VWRV9kOk9b4jV5BgbEeSz/92HMzIWSokWyrIu0KFKAtZTnUVIRKk4V/X0pJJSv5WvGQ04m7ImOxdTx7sUnIN6bgBFpdqSf71cFmVStF0Ha92FFXG/rsElHW7pRgPMEhInCLjaQFu4bXdMCaTeYhePceTCVA1q8rUqD63JHDn1u3jXm3r69dOL+ucCSh+eZJxgbbIbuuPL5N6dx9QqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(71200400001)(85182001)(36756003)(110136005)(122000001)(38100700002)(8936002)(86362001)(6512007)(76116006)(2616005)(26005)(91956017)(33656002)(66946007)(8676002)(66556008)(64756008)(66476007)(66446008)(4326008)(83380400001)(316002)(6486002)(82960400001)(87266011)(508600001)(186003)(2906002)(38070700005)(6506007)(45080400002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1VLNVI3a3MvRmtRWHk5R2tId0Y3VUJRSDlRZTBMYVZBNyttaGNRRncyRkdB?=
 =?utf-8?B?cVE3S0RKWjBwRGV1S3VVaEg0WFF1MitwcU9PWHBpY0F1cWtQTytpbU1XSTdR?=
 =?utf-8?B?TXBhQktuN2VFRUE5T0kwZFAvQmQ3YVVYUm5INmZlazMyUWtUcW1VdklvZzFX?=
 =?utf-8?B?NlplTlYwaHlzUUV4dTJuMjRZbnRDazhXdFAwdWVBenNoelRDY3hlK3BzbUF2?=
 =?utf-8?B?b2RnZUZ6OW84TTJGdmVDeDJDYTlHbGdSUEhtc2QwUlUxd1k0SzZTanc1OElY?=
 =?utf-8?B?Y2hMV3lNMmRLN29saEFTaXdSQmJhNWZyNlRvNG5Qd25JRGNQY0ozUW9zeGZq?=
 =?utf-8?B?RjNub01wemw3UmYrRG1jSFNrQ3lESitiMzVsR1d1YkdqMDRpMjZ5RDEzN0Rz?=
 =?utf-8?B?bDdxbXI1eHl6YzlPUGdUV2FBcXh2SmZNTkRpOGtsakNGcTlHK2NkZ0FZU2Np?=
 =?utf-8?B?NUhweXlWbnVpRHU2UFh2THBuTnR5U1hrTTJzaHRjQUFESFRLaDNpWnVrQ2NE?=
 =?utf-8?B?ektwVVN5SU15ODE4amdMdVNvclVBTnNqSXJEMVdMQWhGZFJNckFyWXZ1eTNq?=
 =?utf-8?B?T1VlRmZRc3BCSGg3OGNpcXRid1BOWmZmdzIwbjVXTWc2aGVCZjI0SVpDQk5s?=
 =?utf-8?B?cFdnam9HOW1FNGw0aEZ0WE9MLzJZaFdwU1pYRHNBQU56cXJHUGtITXd3TWpK?=
 =?utf-8?B?YXdDMHRmSnRJLytPNEUrLzNhOE5LWExpbDBlbTBjajJQR3g3TmtEdWdDS1FM?=
 =?utf-8?B?SHgrQ2dIMktKMlhlU1Uxb3VhMHE1Z2xkeXQ2SkhNU1NuT1U3YXJGOVpXT3Ur?=
 =?utf-8?B?WVBSTFB0VUx3YTRYV0daaEZWOVVCNkl3RXNBU0tJNWpySDZpbWFzSXJaUG1y?=
 =?utf-8?B?QkJTWW9YbG1vSW1ONUZCcmdwWHdjOUZiU3A0SDY4LzlGcWcxelVtbm1VenZ5?=
 =?utf-8?B?Wi9vMGo4SVFMMCtmUWVmeFF6L2YwbytPOThxN3VoOUlqaFRxNUtnWWwxanht?=
 =?utf-8?B?OVlBTTR3S3dNTENHY1ZxTWZFYmwwOVkycCtuMHNMdCtRN0ZJZ3F4dGZ5dEJW?=
 =?utf-8?B?ak5kM3RMK25LTkI3OG9YcXpZTGFQUEFhWTFsRXFnWjVuZ1VxTXhoSTVWcUdq?=
 =?utf-8?B?Qit4Sjc3NmdrT3hlcWNEaXZ5a055WkZQOWZzSXJTelV1eWhKUGNmZHA0NVpx?=
 =?utf-8?B?dDJvYlIvd0EwdHErdkFPQ21qRUhHSDVYUXBlMlUzUXdCRzByYkhYQ3BRQThT?=
 =?utf-8?B?Vmd3QnRGUmE3djZBNm9lbUhhZ0pCaWdsNDZjdDcyREJjSmJTNGhnZ1Jxa1Mw?=
 =?utf-8?B?K3lYUXVrZWNIK1lzcm43TElIdUxTV3EyT0lrY3hyN3FKL0JabG9DaXJsekRC?=
 =?utf-8?B?TmdpbUpzOW91dmlNZHNHWXpsNGduUDBjMEIvMlB5TG1oM2R3ckJrSXN2TFZs?=
 =?utf-8?B?VTFhazBrL1NlTXg5SER5SWpiazJBem1jWlVRYXBSSklhSEt1bTVWenV1K3Ju?=
 =?utf-8?B?c1R5U1Zhb3I1VXdPWnBmMjhPdnBPMlBjOHhld243Q3pYNkcyWXk4QUtyMHEw?=
 =?utf-8?B?MjBLT2IzczM0SVdDMUcrUXJRampGOEIxSXdpR1YzUVhyb1JIRkhoVkM5REJo?=
 =?utf-8?B?ZmlRLzladHMwTnkvd0t0Um1BUlRWRUlwN2NvSi9CdmZmeldXOE9iZFBlb2JG?=
 =?utf-8?B?a2ZGRHJQcDlOMzZYTFg2d1RiQ0g5blZ4YTJab2o5dWZtd2ZEU3B5dFBORmJu?=
 =?utf-8?B?VUJCYzJxNExkLzk2ZXdPdGpDQnlwT1JvM2s1OWhaUlZuZFZHRUxxUTFZTHc0?=
 =?utf-8?B?UWo3L1o4cDlPRUtyaG1pVHRqTW1oNCtWd0tqRUZEMGM4akUrNlltS3loSzR2?=
 =?utf-8?B?RDlsYXRqODhvc0NVZXZHdEoyT2ZEY1FiU0V2SU5xcW1mU0Y3aWxiZVY0WXd1?=
 =?utf-8?B?Z0UxK2xIeDVTczRROFdkem00YzhDeGlBOU14bkFyQ3dNZXY2bnBGd2U1Rk1i?=
 =?utf-8?B?QUpCRnpKR2hORVFTTHFXWVBmVmo4UTJObWlnVkFNNTd5MTRYZ0Vod2V6bFVE?=
 =?utf-8?B?aGxlTEtwc29Ib00xM050ait0bDlzNzZ4U29WUHUvclpJdVNYRVF2WjVETi9j?=
 =?utf-8?B?UW9UeTFONXhNNE1KcHlZWXY5ZXcyV01YaEMvakVNamZkV3lWc0hNdFpkL1JB?=
 =?utf-8?B?bE9wMXVLdjVVYXRxdmtuZGpXTDdwSWdMMS9CbjFsS1duUXY1U3hXaWVvUmZ2?=
 =?utf-8?B?L2kxQW5qcWNpMUtiVVNNQmhIQW1xY0NnWFQzZE5wVklFN3BrdU9tdjV4VG93?=
 =?utf-8?B?N2FiSWxnME9SK1JFdkJhc2k0Zm9JYXRpQ29ERUthZ0lkWVpNRUNCanlFUkJm?=
 =?utf-8?Q?HpY1kChmZhpYOCsW/11salo6UQ/fMo/k1vS1r?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2BEC40F7DC8D742AA5C563336958844@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b461b8-94af-47a3-217f-08da1e80d2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 01:39:46.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKUcFze301whHxq4TUL7zkU1qFfa2pNzMElU/VyRctN8DM4CkEpJtHFKsDojzKrkSXPi8KBve6yTjRwz7XqeycPKUbvHFcPDPSwz9M32Hs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2990
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE0IDIwOjAyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMTQsIDIwMjIgYXQgMDM6NTc6MTdQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IGlub2Rl
X3NnaWRfc3RyaXAoKSBmdW5jdGlvbiBpcyB1c2VkIHRvIHN0cmlwIFNfSVNHSUQgbW9kZQ0KPj4g
d2hlbiBjcmVhdC9vcGVuL21rbm9kIGZpbGUuDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBCcmF1bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFlhbmcgWHU8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9p
bm9kZS5jICAgICAgICAgfCAxOCArKysrKysrKysrKysrKysrKysNCj4+ICAgaW5jbHVkZS9saW51
eC9mcy5oIHwgIDMgKystDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9pbm9kZS5jIGIvZnMvaW5vZGUu
Yw0KPj4gaW5kZXggOWQ5YjQyMjUwNGQxLi5kNjMyNjQ5OTg4NTUgMTAwNjQ0DQo+PiAtLS0gYS9m
cy9pbm9kZS5jDQo+PiArKysgYi9mcy9pbm9kZS5jDQo+PiBAQCAtMjQwNSwzICsyNDA1LDIxIEBA
IHN0cnVjdCB0aW1lc3BlYzY0IGN1cnJlbnRfdGltZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPj4g
ICAJcmV0dXJuIHRpbWVzdGFtcF90cnVuY2F0ZShub3csIGlub2RlKTsNCj4+ICAgfQ0KPj4gICBF
WFBPUlRfU1lNQk9MKGN1cnJlbnRfdGltZSk7DQo+PiArDQo+PiArdm9pZCBpbm9kZV9zZ2lkX3N0
cmlwKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICpkaXIs
DQo+PiArCQkgICAgICB1bW9kZV90ICptb2RlKQ0KPj4gK3sNCj4+ICsJaWYgKCFkaXIgfHwgIShk
aXItPmlfbW9kZSYgIFNfSVNHSUQpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKwlpZiAoKCptb2RlJiAg
KFNfSVNHSUQgfCBTX0lYR1JQKSkgIT0gKFNfSVNHSUQgfCBTX0lYR1JQKSkNCj4+ICsJCXJldHVy
bjsNCj4+ICsJaWYgKFNfSVNESVIoKm1vZGUpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKwlpZiAoaW5f
Z3JvdXBfcChpX2dpZF9pbnRvX21udChtbnRfdXNlcm5zLCBkaXIpKSkNCj4+ICsJCXJldHVybjsN
Cj4+ICsJaWYgKGNhcGFibGVfd3J0X2lub2RlX3VpZGdpZChtbnRfdXNlcm5zLCBkaXIsIENBUF9G
U0VUSUQpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwkqbW9kZSY9IH5TX0lTR0lEOw0KPj4g
K30NCj4+ICtFWFBPUlRfU1lNQk9MKGlub2RlX3NnaWRfc3RyaXApOw0KPg0KPg0KPiBJIHN0aWxs
IHRoaW5rIHRoaXMgc2hvdWxkIHJldHVybiB1bW9kZV90IHdpdGggdGhlIHNldGdpZCBiaXQgc3Ry
aXBwZWQNCj4gaW5zdGVhZCBvZiBtb2RpZnlpbmcgdGhlIG1vZGUgZGlyZWN0bHkuIEkgbWF5IGhh
dmUgbWlzdW5kZXJzdG9vZCBEYXZlLA0KPiBidXQgSSB0aG91Z2h0IGhlIHByZWZlcnJlZCB0byBy
ZXR1cm4gdW1vZGVfdCB0b28/DQpEYXZlJ3MgY29tbWVudCBhcyBiZWxvdzoNCiINCkFncmVlZCwg
dGhhdCdzIGEgbXVjaCBuaWNlciBBUEkgZm9yIHRoaXMgZnVuY3Rpb24gLSBpdCBtYWtlcyBpdA0K
Y2xlYXIgdGhhdCBpdCBjYW4gbW9kaWZ5aW5nIHRoZSBtb2RlIHRoYXQgaXMgcGFzc2VkIGluLg0K
Ig0KDQpTbyBJIHRoaW5rIERhdmUgc2hvdWxkIGxpa2UgbW9kaWZ5IG1vZGUgZGlyZWN0bHkgaW5z
dGVhZCBvZiByZXR1cm5pbmcgYSANCnVtb2RlX3QgdmFsdWUuDQoNCkBEYXZlICBTbyB3aGljaCB3
YXkgZG8geW91IG1lYW4/DQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPg0KPiB1bW9kZV90IGlu
b2RlX3NnaWRfc3RyaXAoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3Qg
aW5vZGUgKmRpciwgdW1vZGVfdCBtb2RlKQ0KPiB7DQo+IAlpZiAoU19JU0RJUihtb2RlKSkNCj4g
CQlyZXR1cm4gbW9kZTsNCj4NCj4gCWlmICghZGlyIHx8ICEoZGlyLT5pX21vZGUmICBTX0lTR0lE
KSkNCj4gCQlyZXR1cm47DQo+DQo+IAlpZiAoKG1vZGUmICAoU19JU0dJRCB8IFNfSVhHUlApKSAh
PSAoU19JU0dJRCB8IFNfSVhHUlApKQ0KPiAJCXJldHVybjsNCj4NCj4gCWlmIChpbl9ncm91cF9w
KGlfZ2lkX2ludG9fbW50KG1udF91c2VybnMsIGRpcikpKQ0KPiAJCXJldHVybjsNCj4NCj4gCWlm
IChjYXBhYmxlX3dydF9pbm9kZV91aWRnaWQobW50X3VzZXJucywgZGlyLCBDQVBfRlNFVElEKSkN
Cj4gCQlyZXR1cm47DQo+DQo+IAlyZXR1cm4gbW9kZSYgIH5TX0lTR0lEOw0KPiB9DQo=
